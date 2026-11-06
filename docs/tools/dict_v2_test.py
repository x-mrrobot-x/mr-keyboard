#!/usr/bin/env python3
"""Tests of the dictionary format v2 (1.86) in build_dict.py, beyond what the shipped dictionaries reach:

  1. a synthetic dictionary of about 14 MB (more than three times the v1 limit) is built in v2, re-read and every bigram
     checked (address table for all, the lib's own walk for a sample), and its biggest address uses bit 23;
  2. the same words do NOT fit in v1 (the builder refuses), and a dictionary just over 16 MB is refused in v2;
  3. converting v2 -> v2 gives the same bytes, and v1 -> v2 -> v1 gives the original back (the shipped dictionaries);
  4. a truncated or damaged file is refused by walk (never an endless loop).

Usage: python3 -I docs/tools/dict_v2_test.py [--keep folder]
  --keep folder   also writes folder/synthetic/main.dict (the big file) for docs/tools/dict_readback.sh, which reads it back
                  through the C++ reader, and folder/synthetic/pack.json is NOT written (it is not a pack)
"""
import os
import random
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import build_dict as bd  # noqa: E402

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + extra if extra else ""))


def synthetic(n_words, n_pairs, seed=7):
    """Deterministic words made of syllables, with frequencies, and random pairs between them."""
    rnd = random.Random(seed)
    cons = "bcdfghjlmnprstvz"
    vows = "aeiou"
    seen = set()
    words = []
    while len(words) < n_words:
        w = "".join(rnd.choice(cons) + rnd.choice(vows) for _ in range(rnd.randint(2, 5)))
        if rnd.random() < 0.4:
            w += rnd.choice("rsmn")
        if w in seen:
            continue
        seen.add(w)
        words.append((w, rnd.randint(1, 255)))
    bigrams = {}
    for _ in range(n_pairs):
        a = words[rnd.randrange(len(words))][0]
        b = words[rnd.randrange(len(words))][0]
        bigrams.setdefault(a, []).append((b, rnd.randint(1, 127)))
    return words, bigrams


def main():
    keep = None
    if len(sys.argv) == 3 and sys.argv[1] == "--keep":
        keep = sys.argv[2]
    t0 = time.time()
    words, bigrams = synthetic(720000, 450000)
    root, nodes, skipped, dropped = bd.build(words, bigrams)
    data = bd.serialize(root, 2)
    print("synthetic dictionary: %d words, %d bytes (%.1f s)" % (len(nodes), len(data), time.time() - t0))
    check("the synthetic dictionary is over 12 MB (3 times the v1 limit)", len(data) > 12 * 1024 * 1024, str(len(data)))
    check("... and under the 16 MB of the format v2", len(data) < bd.FORMATS[2][2])
    check("header [200,2]", data[:2] == bytes((200, 2)))

    errors, nb = bd.verify(data, words, nodes, root, 2, 500)
    check("every word, frequency and bigram is read back (%d bigrams; the lib's walk on one in 500)" % nb, not errors, "; ".join(errors[:3]))
    got, at = bd.walk(data, True)
    top = max(at)
    check("the biggest address uses bit 23 (it needs the 24th bit; v1 stops at 22)", top >= 0x800000, hex(top))
    far = sum(1 for w, (f, big) in got.items() for a, _ in big if a >= 0x800000)
    check("bigrams point above 8 MB (%d of them)" % far, far > 1000)

    try:
        bd.serialize(root, 1)
        check("the same words do not fit in the format v1", False)
    except ValueError as e:
        check("the same words do not fit in the format v1 (the builder refuses)", "limit" in str(e), str(e))

    saved = bd.FORMATS[2]
    bd.FORMATS[2] = (saved[0], saved[1], len(data) - 1)
    try:
        bd.serialize(root, 2)
        check("a dictionary over the limit of v2 is refused", False)
    except ValueError:
        check("a dictionary over the limit of v2 is refused", True)
    finally:
        bd.FORMATS[2] = saved

    # v2 -> v2 must not change a byte
    w2, b2 = bd.from_dict(data)
    again, errors, nb2, _, sk, dr = bd.write(w2, b2, 2, 2000)
    check("v2 -> v2 gives the same bytes", again == data and not errors and not sk and not dr)

    # damaged files: walk may raise, never loop forever (the guard is the file size: every group address must be inside the file)
    for name, cut in (("cut in half", len(data) // 2), ("cut after the header", 3)):
        t1 = time.time()
        try:
            bd.walk(data[:cut])
            res = "read"
        except (IndexError, ValueError):
            res = "refused"
        check("%s: %s in %.1f s, no endless loop" % (name, res, time.time() - t1), time.time() - t1 < 60)

    if keep:
        os.makedirs(os.path.join(keep, "synthetic"), exist_ok=True)
        with open(os.path.join(keep, "synthetic", "main.dict"), "wb") as fh:
            fh.write(data)
        print("written: %s" % os.path.join(keep, "synthetic", "main.dict"))

    # the shipped dictionaries: v1 -> v2 -> v1 gives the original back
    here = os.path.dirname(os.path.abspath(__file__))
    dicts = os.path.join(here, "..", "..", "dicts")
    if os.path.isdir(dicts):
        for lang in sorted(os.listdir(dicts)):
            p = os.path.join(dicts, lang, "main.dict")
            if not os.path.isfile(p):
                continue
            with open(p, "rb") as fh:
                old = fh.read()
            fmt = bd.format_of(old)
            w, b = bd.from_dict(old)
            other = 2 if fmt == 1 else 1
            try:
                mid, e1, _, _, s1, d1 = bd.write(w, b, other, 50)
            except ValueError:
                # a v2 dictionary that no longer fits in v1 (es 4, 1.86.1): the other direction cannot exist; v2 -> v2 must still be exact
                again, e1, _, _, s1, d1 = bd.write(w, b, fmt, 50)
                check("%s: v%d (over the v1 limit) -> v%d gives the original bytes back" % (lang, fmt, fmt),
                      again == old and not (e1 or s1 or d1))
                continue
            back_words, back_bigrams = bd.from_dict(mid)
            back, e2, _, _, s2, d2 = bd.write(back_words, back_bigrams, fmt, 50)
            check("%s: v%d -> v%d -> v%d gives the original bytes back" % (lang, fmt, other, fmt),
                  back == old and not (e1 or e2 or s1 or s2 or d1 or d2))

    print("ALL OK (%d checks)" % ok if not fails else "%d FAILURE(S) out of %d checks" % (fails, ok + fails))
    sys.exit(1 if fails else 0)


if __name__ == "__main__":
    main()
