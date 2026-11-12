#!/usr/bin/env python3
"""Writes the reference vectors of the gesture network (gesture/test/gesture_vectors.bin): what the OFFICIAL runtime
(ExecuTorch with XNNPACK, the file FUTO publishes) gives for real gestures. engine/test/mr_gesture_test.cpp reads the file and
compares the engine's own code with it, number by number, with no need of ExecuTorch.

Usage:
    python3 make_vectors.py <model_fp32.pte> <dev.jsonl> <swipe5.jsonl> <layouts dir> <out.bin> [n_en] [n_es]
The file in the repository: model_fp32.pte of https://huggingface.co/futo-org/futo-swipe (revision
315d42583233b71d75665d076cfa2f2c7c6f43ad, honorable_sturgeon/); dev.jsonl, swipe-5/swipe5.jsonl and swipe-5/layouts of
https://huggingface.co/datasets/futo-org/swipe.futo.org (revision d71bf5fd7f45b3e7c2ed2d76a21b0dbd3b4ba566; MIT License,
Copyright (c) 2025 FUTO); n_en 150, n_es 50; torch 2.15.0 (CPU) and executorch 1.6.0. 201 records: the example of the model
card, one gesture in 37 of dev.jsonl (English, QWERTY) and the first 50 one-finger gestures of the Spanish layout.

Format (little-endian): 8 bytes "MRSWVEC1", u32 number of records; per record:
    u16 n; n x (f32 x, f32 y, f64 t in ms since the first point)    the raw touch points
    u8 keys; keys x (f32 x, f32 y)                                   the centres of the keys of the layout
    f32 x 2 x 64                                                     the resampling the model card prescribes (x then y)
    f32 x 32 x (keys + 1)                                            the output: log-probability of each key, then of the blank
"""
import json, struct, sys
import numpy as np
import torch
from executorch.runtime import Runtime

MAX_KEYS = 64

# A real gesture of the word "computer" (from the model card).
PX = [0.4141, 0.4478, 0.5, 0.5741, 0.6599, 0.7256, 0.7744, 0.8098, 0.8485, 0.867,
      0.8737, 0.8653, 0.8418, 0.8182, 0.8098, 0.7963, 0.7946, 0.8081, 0.8418, 0.8704,
      0.9057, 0.9259, 0.9545, 0.9697, 0.968, 0.9529, 0.9141, 0.8468, 0.7811, 0.7273,
      0.6869, 0.6616, 0.6582, 0.6431, 0.6061, 0.5572, 0.5067, 0.4663, 0.4495, 0.4461,
      0.4411, 0.4192, 0.3872, 0.362, 0.3283, 0.2795, 0.2391, 0.2323, 0.2407, 0.2593,
      0.2879, 0.3249, 0.3468, 0.3569]
PY = [0.8991, 0.858, 0.7876, 0.6702, 0.5352, 0.4237, 0.3357, 0.2653, 0.1655, 0.142,
      0.142, 0.2183, 0.3709, 0.588, 0.7347, 0.8462, 0.8697, 0.811, 0.6115, 0.4707,
      0.3122, 0.2066, 0.1303, 0.1068, 0.1068, 0.1068, 0.1185, 0.1596, 0.1772, 0.1772,
      0.1772, 0.189, 0.189, 0.189, 0.1831, 0.189, 0.189, 0.189, 0.189, 0.189,
      0.1831, 0.1831, 0.1831, 0.1831, 0.1831, 0.1948, 0.189, 0.1948, 0.189, 0.189,
      0.189, 0.1831, 0.1831, 0.1831]
PT = [0.0, 100, 149, 197, 246, 297, 348, 399, 449, 498, 548, 598, 648, 698, 749, 799,
      849, 949, 999, 1047, 1100, 1152, 1197, 1248, 1314, 1364, 1414, 1465, 1515, 1565,
      1614, 1666, 1715, 1851, 1898, 1951, 1998, 2049, 2097, 2165, 2231, 2279, 2331,
      2382, 2431, 2481, 2532, 2584, 2649, 2700, 2751, 2798, 2848, 2899]


def resample(px, py, pt, T=64):
    """As in the model card; a time that goes back counts as no time passed."""
    x, y, t = np.asarray(px, np.float64), np.asarray(py, np.float64), np.asarray(pt, np.float64)
    t = np.maximum.accumulate(t - t[0])
    if t[-1] > 1e-3:
        n60 = max(2, round(t[-1] / (1000.0 / 60.0)) + 1)
        tt = np.linspace(0.0, t[-1], n60)
        x, y = np.interp(tt, t, x), np.interp(tt, t, y)
    idx = np.linspace(0, len(x) - 1, T)
    rx = np.interp(idx, np.arange(len(x)), x)
    ry = np.interp(idx, np.arange(len(y)), y)
    return np.stack([rx, ry], axis=0).astype(np.float32)


def layout(path):
    j = json.load(open(path, encoding="utf-8"))
    letters = j["letters"]
    xy = np.zeros((len(letters), 2), np.float32)
    for k in j["keys"]:
        xy[letters.index(k["letter"])] = (k["cx"], k["cy"])
    return xy


def main():
    if len(sys.argv) < 6:
        sys.exit(__doc__)
    pte, dev, sw5, ldir, out = sys.argv[1:6]
    n_en = int(sys.argv[6]) if len(sys.argv) > 6 else 150
    n_es = int(sys.argv[7]) if len(sys.argv) > 7 else 50
    enc = Runtime.get().load_program(pte).load_method("forward")
    q = layout(ldir + "/qwerty.json")
    s = layout(ldir + "/spanish.json")
    recs = [(PX, PY, PT, q)]
    with open(dev, encoding="utf-8") as f:
        for i, ln in enumerate(f):
            if len(recs) > n_en:
                break
            if i % 37:
                continue
            d = json.loads(ln)["data"]
            if len(d) >= 2:
                recs.append(([p["x"] for p in d], [p["y"] for p in d], [p["t"] for p in d], q))
    n = 0
    with open(sw5, encoding="utf-8") as f:
        for ln in f:
            if n >= n_es:
                break
            j = json.loads(ln)
            if j.get("layout") != "spanish" or j.get("dual_finger") or len(j["data"]) < 2:
                continue
            d = j["data"]
            recs.append(([p["x"] for p in d], [p["y"] for p in d], [p["t"] for p in d], s))
            n += 1
    with open(out, "wb") as f:
        f.write(b"MRSWVEC1" + struct.pack("<I", len(recs)))
        for px, py, pt, xy in recs:
            feats = resample(px, py, pt)
            nk = xy.shape[0]
            keys = torch.zeros(1, MAX_KEYS, 2)
            mask = torch.zeros(1, MAX_KEYS, dtype=torch.bool)
            keys[0, :nk] = torch.from_numpy(xy)
            mask[0, :nk] = True
            le = enc.execute((torch.from_numpy(feats[None]), keys, mask))[0].numpy()[0]      # [32, 65]
            exp = np.concatenate([le[:, :nk], le[:, 64:65]], axis=1).astype("<f4")
            f.write(struct.pack("<H", len(px)))
            t0 = pt[0]
            for a, b, c in zip(px, py, pt):
                f.write(struct.pack("<ffd", a, b, c - t0))
            f.write(struct.pack("<B", nk))
            f.write(xy.astype("<f4").tobytes())
            f.write(feats.astype("<f4").tobytes())
            f.write(exp.tobytes())
    print("records:", len(recs))


if __name__ == "__main__":
    main()
