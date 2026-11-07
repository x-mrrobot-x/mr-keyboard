#!/usr/bin/env python3
"""Converts trigrams.bin between MRT1 and MRT2 (formats in mrt_format.py) and compares two files.

Usage:
  python3 -I convert_trigrams.py to2 IN.bin OUT.bin     # to MRT2 (the app 1.90+ reads it with mmap)
  python3 -I convert_trigrams.py to1 IN.bin OUT.bin     # back to MRT1 (to check the round trip)
  python3 -I convert_trigrams.py same A.bin B.bin       # same data in any format? (words, contexts, continuations, scores)
  python3 -I convert_trigrams.py info FILE.bin

The conversion only changes the layout: the word ids, the contexts and the continuations (and their order) stay as they are. 'to2' fails if the
file has more than 65535 words or a context with more than 3 continuations, instead of cutting anything.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import mrt_format as F  # noqa: E402


def load(path):
    with open(path, "rb") as fh:
        d = fh.read()
    return d, F.read_any(d)


def main(argv):
    if len(argv) >= 3 and argv[1] in ("to1", "to2") and len(argv) == 4:
        d, (words, ctx) = load(argv[2])
        out = F.write2(words, ctx) if argv[1] == "to2" else F.write1(words, ctx)
        F.read_any(out)   # reads back what it wrote
        with open(argv[3], "wb") as fh:
            fh.write(out)
        print("%s: MRT%d %d bytes -> MRT%d %d bytes (%+.1f%%), %d words, %d contexts" % (
            argv[2], F.version_of(d), len(d), F.version_of(out), len(out), 100.0 * (len(out) - len(d)) / len(d), len(words), len(ctx)))
        return 0
    if len(argv) == 4 and argv[1] == "same":
        _a, (wa, ca) = load(argv[2])
        _b, (wb, cb) = load(argv[3])
        if wa != wb:
            print("DIFFERENT: the word lists differ")
            return 1
        if ca != cb:
            print("DIFFERENT: the contexts differ")
            return 1
        print("SAME: %d words, %d contexts" % (len(wa), len(ca)))
        return 0
    if len(argv) == 3 and argv[1] == "info":
        d, (words, ctx) = load(argv[2])
        ks = {}
        for _a, _b, c in ctx:
            ks[len(c)] = ks.get(len(c), 0) + 1
        print("MRT%d, %d bytes, %d words, %d contexts, continuations per context %s" % (
            F.version_of(d), len(d), len(words), len(ctx), dict(sorted(ks.items()))))
        return 0
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv))
