#!/usr/bin/env python3
"""Measures next-word prediction from a "combined" list on separate test sentences.

Usage: python3 -I eval_predict.py list.combined.gz test.txt [mr_trigrams.bin]

For each pair of consecutive words (inside a stretch without punctuation) whose first word
is in the list, simulates what the keyboard shows:
  - after the space: the first 3 continuations of the previous word (MrPredict);
  - after the 1st letter: the continuations that start with the same base letter, up to 3 (Suggest with
    one typed letter).
Counts a hit when the real word is among the ones shown (without distinguishing case/accent only
on the initial). Output: coverage and top-1/top-3 hits.
"""
import collections
import gzip
import re
import sys
import unicodedata

LETTER = r"[^\W\d_]"
TOKEN_RE = re.compile(rf"{LETTER}+(?:['-]{LETTER}+)*|\S")
URL_RE = re.compile(
    r"(?:https?://|www\.)\S+|\S+@\S+\.\S+|[@#]\w+"
    r"|\b[\w-]+(?:\.[\w-]+)*\.(?:com|net|org|gov|edu|br|io|tv|me|app|info|jus|leg)\b\S*", re.I)
SENTENCE_END = set('.!?:;"“”«»()[]{}—–…')
APOSTROPHES = str.maketrans({"’": "'", "‘": "'", "ʼ": "'"})


def base_char(c):
    return unicodedata.normalize("NFD", c)[0].lower()


def load(path):
    words, big = set(), collections.defaultdict(list)
    cur = None
    with gzip.open(path, "rt", encoding="utf-8") as fh:
        for line in fh:
            if line.startswith(" word="):
                d = dict(kv.split("=", 1) for kv in line.strip().split(","))
                cur = d["word"]
                words.add(cur)
            elif line.startswith("  bigram=") and cur is not None:
                d = dict(kv.split("=", 1) for kv in line.strip().split(","))
                big[cur].append((d["bigram"], int(d["f"])))
    for k in big:
        big[k].sort(key=lambda x: -x[1])
    return words, big


def load_trigrams(path):
    """Reads mr_trigrams.bin (make_trigrams.py) -> {(w1, w2): [w3, ...]}."""
    import struct
    d = open(path, "rb").read()
    assert d[:4] == b"MRT1"
    pos = 4
    n = struct.unpack(">I", d[pos:pos + 4])[0]
    pos += 4
    vocab = []
    for _ in range(n):
        ln = d[pos]
        vocab.append(d[pos + 1:pos + 1 + ln].decode("utf-8"))
        pos += 1 + ln
    m = struct.unpack(">I", d[pos:pos + 4])[0]
    pos += 4
    tri = {}
    for _ in range(m):
        a = int.from_bytes(d[pos:pos + 3], "big")
        b = int.from_bytes(d[pos + 3:pos + 6], "big")
        k = d[pos + 6]
        pos += 7
        lst = []
        for _ in range(k):
            lst.append(vocab[int.from_bytes(d[pos:pos + 3], "big")])
            pos += 4
        tri[(vocab[a], vocab[b])] = lst
    return tri


def main():
    words, big = load(sys.argv[1])
    tri = load_trigrams(sys.argv[3]) if len(sys.argv) > 3 else {}
    n = cov = h1 = h3 = 0
    fn = fcov = f1 = f3 = 0
    for line in open(sys.argv[2], encoding="utf-8"):
        toks = TOKEN_RE.findall(URL_RE.sub(" | ", line.strip().translate(APOSTROPHES)))
        prev = None
        prev2 = None
        first = True
        for t in toks:
            if not t[0].isalpha():
                prev = None
                prev2 = None
                if t in SENTENCE_END:
                    first = True
                continue
            cur = t
            if prev is not None:
                key = prev if prev in big else prev.lower() if prev.lower() in big else None
                n += 1
                lst = [w for w, _ in big.get(key, [])] if key else []
                if tri and prev2 is not None:
                    tl3 = None
                    for c1 in (prev2, prev2.lower()):
                        for c2 in (prev, prev.lower()):
                            if (c1, c2) in tri:
                                tl3 = tri[(c1, c2)]
                                break
                        if tl3:
                            break
                    if tl3:
                        lst = tl3 + [w for w in lst if w not in tl3]
                if lst:
                    cov += 1
                tl = cur.lower()
                if lst and lst[0].lower() == tl:
                    h1 += 1
                if any(w.lower() == tl for w in lst[:3]):
                    h3 += 1
                fl = [w for w in lst if base_char(w[0]) == base_char(cur[0])]
                fn += 1
                if fl:
                    fcov += 1
                if fl and fl[0].lower() == tl:
                    f1 += 1
                if any(w.lower() == tl for w in fl[:3]):
                    f3 += 1
            known = cur if (cur in words or cur.lower() in words) else None
            prev2 = prev if known is not None else None
            prev = known
            first = False
    pct = lambda x, y: f"{100.0 * x / y:5.1f}%" if y else "  -  "
    print(f"pairs evaluated: {n}")
    print(f"after the space : coverage {pct(cov, n)}  top-1 {pct(h1, n)}  top-3 {pct(h3, n)}")
    print(f"after 1st letter: coverage {pct(fcov, fn)}  top-1 {pct(f1, fn)}  top-3 {pct(f3, fn)}")


if __name__ == "__main__":
    main()
