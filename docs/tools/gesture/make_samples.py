#!/usr/bin/env python3
"""Writes a file of gestures for the tests of the gesture recognition (gesture/test/gestures_<language>.tsv).

Two sources:
  real gestures       --jsonl FILE: a file of the public dataset https://huggingface.co/datasets/futo-org/swipe.futo.org
                      (MIT License, Copyright (c) 2025 FUTO): test.jsonl, dev.jsonl or swipe-5/*.jsonl;
  synthetic gestures  --sentences FILE: one sentence per line (docs/tools/e2e/data/everyday_<language>.txt); each word becomes
                      a made-up trace. For the languages the dataset does not have (Portuguese).

The keys of the keyboard the gestures were (or are) made on:
  --layout-json FILE  a layout of the dataset (swipe-5/layouts/qwerty.json, spanish.json);
  --layout-xml FILE   a keyboard of the app (res/xml/kbd_qwerty.xml, kbd_compact.xml, kbd_full.xml).

Output: comment lines "# ..."; one line "@keys letter x y letter x y ..."; then one gesture per line:
    word TAB previous word TAB x0 y0 t0 x1 y1 t1 ...
The previous word is the one before it in the sentence ("" for the first one). x and y are in the frame of the letter block
(x: 0 at the left edge of the keyboard, 1 at the right edge; y: 0 at the top of the first row of letters, 1 at the bottom of the
last one); t in milliseconds since the first point.

Real gestures, filters: one finger only; --max-distance uses the field `distance` of the dataset itself (the collections 2 to 5 are
not filtered; values from 100000 on are codes of an invalid gesture). No filter uses the result of the recognition.
--every N keeps one gesture in N (after the filters) and --max stops at that many: a sample across many volunteers.

Synthetic gestures, the model of the trace (simple on purpose, few knobs):
  1. one point per letter: the centre of the key plus a normal error (--sigma, in key widths) and an offset common to the whole
     gesture (--offset); a fraction of the gestures (--sloppy) is careless, with the error multiplied by --factor;
  2. between two points, minimum-jerk movement with a Fitts-like duration;
  3. a low-pass filter in time (--smooth, ms) rounds the corners, as a hand does.
Then the trace is sampled at the rate of a screen (60, 90 or 120 Hz) and rounded to pixels. A doubled letter is passed over
once. Accents, c-cedilla and n-tilde use the key of the base letter when the layout has no key for them.
The knobs were set so that the recognition gets, on synthetic English gestures, what it gets on the real gestures of the same
words (docs/gesture-typing.md). A synthetic gesture is not a person's gesture: it is an estimate, not a proof.

The three files of gesture/test (run at the project root; DS = a copy of the dataset, see README.md in this folder):
  make_samples.py --standard en-US --ds DS --out gesture/test/gestures_en-US.tsv
  make_samples.py --standard es    --ds DS --out gesture/test/gestures_es.tsv
  make_samples.py --standard pt-BR         --out gesture/test/gestures_pt-BR.tsv
--standard is a shorthand for the options and the comment lines of each file (STANDARD below); the files come out byte for byte.
The same sources whole, to measure with `mr_gesture_test eval`: the same options without --every and --max, for example
  make_samples.py --jsonl DS/test.jsonl --layout-json DS/swipe-5/layouts/qwerty.json --out /tmp/en_test.tsv
The synthetic traces need numpy (the file in the repository comes out the same with numpy 2.3 and 2.5).
"""
import argparse, json, math, os, random, re
import xml.etree.ElementTree as ET

REV = "d71bf5fd7f45b3e7c2ed2d76a21b0dbd3b4ba566"
URL = "https://huggingface.co/datasets/futo-org/swipe.futo.org"
NOTE_HEAD = "Mr Keyboard - test data of the gesture recognition (README.md in this folder says how the file was made)."
NOTE_FORMAT = "word TAB previous word TAB x y t x y t ...: the frame of x and y is in README.md, t in milliseconds."
MIT = "MIT License, Copyright (c) 2025 FUTO (LICENSE-swipe-dataset.txt)."
# The files of gesture/test: options (as on the command line; {ds} is the folder given with --ds) and the comment of each.
STANDARD = {
    "en-US": (["--jsonl", "{ds}/test.jsonl", "--layout-json", "{ds}/swipe-5/layouts/qwerty.json", "--every", "164", "--max", "300"],
              "300 real gestures in English (QWERTY): one in 164 of test.jsonl of %s (revision %s). %s" % (URL, REV, MIT)),
    "es": (["--jsonl", "{ds}/swipe-5/swipe5.jsonl", "--lang", "es", "--layout", "spanish", "--max-distance", "100000",
            "--layout-json", "{ds}/swipe-5/layouts/spanish.json", "--every", "6", "--max", "300"],
           "300 real gestures in Spanish (the layout with the n-tilde key): one in 6 of the Spanish ones of swipe-5/swipe5.jsonl of "
           "%s (revision %s). %s" % (URL, REV, MIT)),
    "pt-BR": (["--sentences", "docs/tools/e2e/data/everyday_pt-BR.txt", "--repeat", "8", "--seed", "31", "--layout-xml",
               "res/xml/kbd_qwerty.xml", "--every", "27", "--max", "300"],
              "300 SYNTHETIC gestures in Portuguese (there are no public real ones), on the standard keyboard of the app "
              "(res/xml/kbd_qwerty.xml): one in 27 of the traces made up by docs/tools/gesture/make_samples.py for the words of "
              "docs/tools/e2e/data/everyday_pt-BR.txt."),
}

EDGE = re.compile(r"^[^\w]+|[^\w]+$", re.UNICODE)
KEY_H = 1.35          # height of a key in key widths (the screen of the first collection of the dataset: 422 x 170 px)


def clean(w):
    return EDGE.sub("", w.replace("\u2019", "'"))


# ------------------------------------------------------------------------------------------------ layouts

def layout_from_json(path):
    """A layout of the dataset: the centre of each key, already in the frame of the letter block."""
    j = json.load(open(path, encoding="utf-8"))
    centre = {k["letter"]: (k["cx"], k["cy"]) for k in j["keys"]}
    return [(c, centre[c][0], centre[c][1]) for c in j["letters"]]


def layout_from_xml(path):
    """The letter keys of a res/xml/kbd_*.xml of the app: x = centre / keyboard width; y = 1/6, 1/2 and 5/6 for the three rows
    of letters. Labels of the kind @string/name (kbd_full.xml) are looked up in res/values/strings.xml."""
    ns = "{http://schemas.android.com/apk/res-auto}"

    def pct(v, default):
        if v is None:
            return default
        m = re.match(r"([\d.]+)%p", v)
        return float(m.group(1)) / 100.0 if m else default

    strings = {}
    sx = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(path))), "values", "strings.xml")
    if os.path.exists(sx):
        for e in ET.parse(sx).getroot().iter("string"):
            strings[e.get("name")] = e.text or ""
    root = ET.parse(path).getroot()
    kw0 = pct(root.get(ns + "keyWidth"), 0.1)
    gap0 = pct(root.get(ns + "horizontalGap"), 0.0)
    rows = []
    for row in root.iter("Row"):
        x = 0.0
        kw = pct(row.get(ns + "keyWidth"), kw0)
        gp = pct(row.get(ns + "horizontalGap"), gap0)
        keys = {}
        for k in row.findall("Key"):
            w = pct(k.get(ns + "keyWidth"), kw)
            g = pct(k.get(ns + "horizontalGap"), gp)
            lab = k.get(ns + "keyLabel")
            if lab and lab.startswith("@string/"):
                lab = strings.get(lab[8:], "")
            if lab and len(lab) == 1 and lab.isalpha() and lab.islower():
                keys[lab] = x + g + w / 2
            x += g + w
        rows.append(keys)
    order = {"q": 0, "a": 1, "z": 2}
    out = {}
    for keys in rows:
        if len(keys) < 5:
            continue
        ri = next((order[c] for c in "qaz" if c in keys), None)
        if ri is None or any(c in out for c in keys):
            continue                      # the same row again (another mode of the keyboard)
        for c, cx in keys.items():
            out[c] = (cx, (ri + 0.5) / 3.0)
    return [(c, out[c][0], out[c][1]) for c in sorted(out)]


# ------------------------------------------------------------------------------------------- real gestures

def real_gestures(a):
    drop = {"filter": 0, "two_fingers": 0, "distance": 0, "few_points": 0}
    out = []
    with open(a.jsonl, encoding="utf-8") as f:
        for ln in f:
            j = json.loads(ln)
            if (a.lang and j.get("language") != a.lang) or (a.layout and j.get("layout") != a.layout):
                drop["filter"] += 1; continue
            if j.get("dual_finger"):
                drop["two_fingers"] += 1; continue
            if a.max_distance is not None and not (j.get("distance") is not None and j["distance"] < a.max_distance):
                drop["distance"] += 1; continue
            d = j["data"]
            if not isinstance(d, list) or len(d) < 2:
                drop["few_points"] += 1; continue
            word = clean(j["word"])
            prev = ""
            toks = [clean(t) for t in (j.get("sentence") or "").split()]
            toks = [t for t in toks if t]
            i = j.get("word_idx")
            if isinstance(i, int) and 0 < i < len(toks) and toks[i].lower() == word.lower():
                prev = toks[i - 1]
            t0 = d[0]["t"]
            out.append((word, prev, " ".join("%.5f %.5f %d" % (p["x"], p["y"], round(p["t"] - t0)) for p in d)))
    print("%s: %d gestures after the filters, dropped %s" % (a.jsonl, len(out), drop))
    return out


# -------------------------------------------------------------------------------------- synthetic gestures

def base(c):
    """MrText.base: lowercase without the accent (only the accents the app knows)."""
    c = c.lower()
    table = {"à": "a", "á": "a", "â": "a", "ã": "a", "ä": "a", "å": "a", "ç": "c", "è": "e", "é": "e", "ê": "e", "ë": "e",
             "ì": "i", "í": "i", "î": "i", "ï": "i", "ñ": "n", "ò": "o", "ó": "o", "ô": "o", "õ": "o", "ö": "o",
             "ù": "u", "ú": "u", "û": "u", "ü": "u", "ý": "y", "ÿ": "y"}
    return table.get(c, c)


def key_seq(word, keys):
    seq = []
    for c in word:
        if c in "'-\u2019":
            continue
        k = c.lower() if c.lower() in keys else base(c)
        if k not in keys:
            return None
        if not seq or seq[-1] != k:
            seq.append(k)
    return seq if len(seq) >= 2 else None


def synthetic_trace(seq, keys, rng, sigma, offset, smooth_ms, sloppy, factor):
    import numpy as np
    if rng.random() < sloppy:                                # a careless gesture: a much larger error in the whole gesture
        sigma, offset = sigma * factor, offset * factor
    ox, oy = rng.gauss(0, offset), rng.gauss(0, offset)
    pts = [(keys[k][0] + ox + rng.gauss(0, sigma), keys[k][1] + oy + rng.gauss(0, sigma)) for k in seq]
    speed = math.exp(rng.gauss(0, 0.25))
    dt = 1000.0 / 240.0
    xs, ys = [], []
    for _ in range(int(rng.uniform(20, 80) / dt)):           # the finger stands still when it touches
        xs.append(pts[0][0]); ys.append(pts[0][1])
    for (x0, y0), (x1, y1) in zip(pts, pts[1:]):
        d = math.hypot(x1 - x0, y1 - y0)
        dur = (60.0 + 90.0 * math.log2(1.0 + d)) * speed
        n = max(2, int(dur / dt))
        for i in range(1, n + 1):
            u = i / n
            s = 10 * u ** 3 - 15 * u ** 4 + 6 * u ** 5
            xs.append(x0 + (x1 - x0) * s); ys.append(y0 + (y1 - y0) * s)
    for _ in range(int(rng.uniform(15, 60) / dt)):           # and when it lifts
        xs.append(pts[-1][0]); ys.append(pts[-1][1])
    if smooth_ms > 0:                                        # Gaussian low-pass in time
        sg = smooth_ms / dt
        r = int(3 * sg) + 1
        w = np.exp(-0.5 * (np.arange(-r, r + 1) / sg) ** 2)
        w /= w.sum()

        def smooth(v):
            return np.convolve(np.pad(np.asarray(v, float), r, mode="edge"), w, mode="valid").tolist()
        xs, ys = smooth(xs), smooth(ys)
    rate = rng.choice((60.0, 60.0, 90.0, 120.0))
    step = 1000.0 / rate
    px_w = rng.choice((360.0, 393.0, 412.0, 430.0))          # width of the screen in pixels
    out = []
    t = 0.0
    total = (len(xs) - 1) * dt
    while t <= total + 1e-6:
        f = t / dt
        i = min(len(xs) - 2, int(f))
        a = f - i
        x = (xs[i] + a * (xs[i + 1] - xs[i])) / 10.0
        y = (ys[i] + a * (ys[i + 1] - ys[i])) / (3.0 * KEY_H)
        x = round(x * px_w) / px_w                           # the screen gives whole pixels
        y = round(y * px_w * 0.4) / (px_w * 0.4)
        out.append((x, y, int(round(t + rng.uniform(-2, 2))) if out else 0))
        t += step
    for i in range(1, len(out)):                             # time does not go back
        if out[i][2] <= out[i - 1][2]:
            out[i] = (out[i][0], out[i][1], out[i - 1][2] + 1)
    return out


def synthetic_gestures(a, layout):
    keys = {c: (x * 10.0, y * 3.0 * KEY_H) for c, x, y in layout}       # in key widths
    words = []
    for ln in open(a.sentences, encoding="utf-8"):
        toks = [EDGE.sub("", t.replace("\u2019", "'")) for t in ln.split()]
        toks = [t for t in toks if t]
        for i, t in enumerate(toks):
            if any(ch.isdigit() for ch in t):
                continue
            words.append((t, toks[i - 1] if i > 0 else ""))
    rng = random.Random(a.seed)
    out = []
    skipped = 0
    for _ in range(a.repeat):
        for word, prev in words:
            seq = key_seq(word, keys)
            if seq is None:
                skipped += 1
                continue
            g = synthetic_trace(seq, keys, rng, a.sigma, a.offset, a.smooth, a.sloppy, a.factor)
            out.append((word, prev, " ".join("%.5f %.5f %d" % p for p in g)))
    print("%s: %d synthetic gestures (%d words left out: a single key, or a letter with no key)" % (a.sentences, len(out), skipped))
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--out", required=True)
    ap.add_argument("--standard", choices=sorted(STANDARD), help="one of the files of gesture/test")
    ap.add_argument("--ds", default="DS", help="folder with the dataset, for --standard")
    ap.add_argument("--jsonl"); ap.add_argument("--sentences")
    ap.add_argument("--layout-json"); ap.add_argument("--layout-xml")
    ap.add_argument("--lang"); ap.add_argument("--layout"); ap.add_argument("--max-distance", type=float, default=None)
    ap.add_argument("--every", type=int, default=1); ap.add_argument("--max", type=int, default=0)
    ap.add_argument("--note", action="append", default=[], help="a comment line for the head of the file (may repeat)")
    # synthetic: the defaults are the calibration against the real English gestures (docs/gesture-typing.md)
    ap.add_argument("--repeat", type=int, default=1); ap.add_argument("--seed", type=int, default=7)
    ap.add_argument("--sigma", type=float, default=0.27); ap.add_argument("--offset", type=float, default=0.15)
    ap.add_argument("--smooth", type=float, default=35.0)
    ap.add_argument("--sloppy", type=float, default=0.05); ap.add_argument("--factor", type=float, default=2.0)
    a = ap.parse_args()
    if a.standard:
        options, note = STANDARD[a.standard]
        a = ap.parse_args([o.replace("{ds}", a.ds) for o in options] + ["--out", a.out, "--note", NOTE_HEAD, "--note", note, "--note", NOTE_FORMAT])
    if bool(a.jsonl) == bool(a.sentences):
        ap.error("give --jsonl (real gestures) or --sentences (synthetic gestures)")
    if bool(a.layout_json) == bool(a.layout_xml):
        ap.error("give --layout-json (a layout of the dataset) or --layout-xml (a keyboard of the app)")
    layout = layout_from_json(a.layout_json) if a.layout_json else layout_from_xml(a.layout_xml)
    if not layout:
        ap.error("no letter key found in the layout")
    # The centres with the six decimals the @keys line has: the synthetic traces are drawn over the same numbers the test reads.
    layout = [(c, float("%.6f" % x), float("%.6f" % y)) for c, x, y in layout]
    gestures = real_gestures(a) if a.jsonl else synthetic_gestures(a, layout)
    kept = [g for i, g in enumerate(gestures) if i % a.every == 0]
    if a.max:
        kept = kept[:a.max]
    with open(a.out, "w", encoding="utf-8", newline="\n") as o:
        for note in a.note:
            o.write("# %s\n" % note)
        o.write("@keys " + " ".join("%s %.6f %.6f" % k for k in layout) + "\n")
        for word, prev, pts in kept:
            o.write("%s\t%s\t%s\n" % (word, prev, pts))
    print("%s: %d gestures, %d keys" % (a.out, len(kept), len(layout)))


if __name__ == "__main__":
    main()
