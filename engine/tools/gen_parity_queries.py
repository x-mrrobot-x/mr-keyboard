#!/usr/bin/env python3
"""Queries for the Java vs C++ parity test (docs/tools/e2e/NativeParity.java), taken from the project's OWN dictionary:
no text corpus needed. For each language it generates
  typos_<id>.tsv   wrong TAB right TAB kind   (one synthetic typo per sampled word, fixed seed)
  pairs_<id>.txt   word pairs "w1 w2" from the contexts of trigrams.bin (and variants with a capital first letter)

  python3 -I engine/tools/gen_parity_queries.py --lang pt-BR --out /tmp/parity [--words 2500] [--root .]

The typos are the same kinds as in docs/tools/e2e/gen_typos_all.py (swapped letters, missing letter at the start/middle/end,
repeated letter, neighbouring key, extra letter). Parity does not depend on the typos being realistic: it needs variety and
the same input going to Java and to C++.
"""
import argparse
import os
import random
import struct
import sys

ROWS = {
    "pt-BR": ["qwertyuiop", "asdfghjklç", "zxcvbnm"],
    "en-US": ["qwertyuiop", "asdfghjkl", "zxcvbnm"],
    "es": ["qwertyuiop", "asdfghjklñ", "zxcvbnm"],
}


def neighbors(c, rows):
    out = []
    for r, row in enumerate(rows):
        k = row.find(c)
        if k < 0:
            continue
        for dr, dk in ((0, -1), (0, 1), (-1, 0), (-1, 1), (1, -1), (1, 0)):
            rr, kk = r + dr, k + dk
            if 0 <= rr < len(rows) and 0 <= kk < len(rows[rr]):
                out.append(rows[rr][kk])
    return out


def typo(w, rows, rnd):
    kinds = ["swap", "del_mid", "del_first", "del_last", "dup", "near", "ins"]
    for _ in range(20):
        kind = rnd.choice(kinds)
        i = rnd.randrange(len(w))
        if kind == "swap" and i + 1 < len(w) and w[i] != w[i + 1]:
            return w[:i] + w[i + 1] + w[i] + w[i + 2:], kind
        if kind == "del_mid" and 1 <= i < len(w) - 1:
            return w[:i] + w[i + 1:], kind
        if kind == "del_first":
            return w[1:], kind
        if kind == "del_last":
            return w[:-1], kind
        if kind == "dup":
            return w[:i] + w[i] + w[i:], kind
        if kind == "near":
            n = neighbors(w[i], rows)
            if n:
                return w[:i] + rnd.choice(n) + w[i + 1:], kind
        if kind == "ins":
            return w[:i] + rnd.choice("abcdefghijklmnopqrstuvwxyz") + w[i:], kind
    return None, None


def read_tri(path):
    d = open(path, "rb").read()
    assert d[:4] == b"MRT1"
    n = struct.unpack(">I", d[4:8])[0]
    pos = 8
    words = []
    for _ in range(n):
        ln = d[pos]
        words.append(d[pos + 1: pos + 1 + ln].decode("utf-8", "replace"))
        pos += 1 + ln
    m = struct.unpack(">I", d[pos: pos + 4])[0]
    pos += 4
    ctx = []
    for _ in range(m):
        a = int.from_bytes(d[pos: pos + 3], "big")
        b = int.from_bytes(d[pos + 3: pos + 6], "big")
        k = d[pos + 6]
        pos += 7 + 4 * k
        ctx.append((words[a], words[b]))
    return ctx


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--lang", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--words", type=int, default=2500)
    ap.add_argument("--pairs", type=int, default=20000)
    ap.add_argument("--root", default=".")
    ap.add_argument("--dicts", default=None, help="folder with the <lang>/main.dict and trigrams.bin (default: <root>/dicts)")
    a = ap.parse_args()
    sys.path.insert(0, os.path.join(a.root, "docs", "tools"))
    import build_dict as bd  # noqa: E402

    rnd = random.Random(20261031)
    rows = ROWS[a.lang]
    got = bd.walk(open(os.path.join(a.dicts or os.path.join(a.root, "dicts"), a.lang, "main.dict"), "rb").read())
    words = sorted(w for w in got if len(w) >= 4 and w.isalpha() and w == w.lower())
    step = max(1, len(words) // a.words)
    os.makedirs(a.out, exist_ok=True)
    n = 0
    with open(os.path.join(a.out, f"typos_{a.lang}.tsv"), "w", encoding="utf-8") as fh:
        for w in words[::step][: a.words]:
            t, kind = typo(w, rows, rnd)
            if t and t != w:
                fh.write(f"{t}\t{w}\t{kind}\n")
                n += 1
    ctx = read_tri(os.path.join(a.dicts or os.path.join(a.root, "dicts"), a.lang, "trigrams.bin"))
    step = max(1, len(ctx) // a.pairs)
    m = 0
    with open(os.path.join(a.out, f"pairs_{a.lang}.txt"), "w", encoding="utf-8") as fh:
        for i, (w1, w2) in enumerate(ctx[::step][: a.pairs]):
            fh.write(f"{w1} {w2}\n")
            m += 1
            if i % 5 == 0 and w1:
                fh.write(f"{w1[0].upper() + w1[1:]} {w2}\n")   # start of sentence: the lib also tries lowercase
                m += 1
    print(f"{a.lang}: {n} typos, {m} pairs")


if __name__ == "__main__":
    main()
