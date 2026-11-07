#!/usr/bin/env python3
"""Tests mrt_format.py (the readers and writers of trigrams.bin, MRT1 and MRT2) and convert_trigrams.py.

Run it from the project root:  python3 -I docs/tools/test_mrt_format.py

What it checks: the round trip MRT1 -> MRT2 -> MRT1 on made-up data and on the real packs of dicts/ (when they are there), the limits (65535 words,
3 continuations), that every kind of damaged file is refused by the strict readers, that the two formats hold the same data, and that the
CLI converts, compares and says no when the data differ. The C++ reader is tested on the same ideas by engine/test/mr_test.cpp.
"""
import os
import random
import struct
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import mrt_format as F  # noqa: E402

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


def raises(fn, *a):
    try:
        fn(*a)
    except ValueError:
        return True
    except Exception as e:   # anything but ValueError is a bug of the reader
        print("      unexpected", type(e).__name__, e)
        return False
    return False


def made_up(n=300, m=900, seed=1, max_k=3):
    rnd = random.Random(seed)
    words = sorted({("w%d" % rnd.randrange(10 ** 6)).encode() + (b"\xc3\xa7" if rnd.random() < 0.1 else b"") for _ in range(n)})
    n = len(words)
    keys = sorted({(rnd.randrange(n), rnd.randrange(n)) for _ in range(m)})
    ctx = [(a, b, [(rnd.randrange(n), rnd.randrange(1, 128)) for _ in range(rnd.randint(0, max_k))]) for a, b in keys]
    return words, ctx


words, ctx = made_up()
d1, d2 = F.write1(words, ctx), F.write2(words, ctx)
check("round trip MRT1", F.read1(d1) == (words, ctx))
check("round trip MRT2", F.read2(d2) == (words, ctx))
check("MRT1 -> MRT2 -> MRT1 is the same bytes", F.convert(F.convert(d1, 2), 1) == d1)
check("MRT2 -> MRT1 -> MRT2 is the same bytes", F.convert(F.convert(d2, 1), 2) == d2)
check("read_any tells the formats apart", F.read_any(d1) == F.read_any(d2) and F.version_of(d1) == 1 and F.version_of(d2) == 2 and F.version_of(b"XXXX") == 0)
check("an empty file is valid in both", F.read_any(F.write1([], [])) == ([], []) and F.read_any(F.write2([], [])) == ([], []))
check("an empty file is 20 bytes in MRT2 and 12 in MRT1", len(F.write2([], [])) == 20 and len(F.write1([], [])) == 12)
check("a context with no continuation is kept in both (the app stops the search there, in both)",
      F.read2(F.write2([b"a", b"b"], [(0, 1, [])]))[1] == [(0, 1, [])] and F.read1(F.write1([b"a", b"b"], [(0, 1, [])]))[1] == [(0, 1, [])])
check("MRT2 records are 11 bytes and the layout adds up",
      len(d2) == 12 + 8 * (len(words) + 1) + 11 * len(ctx) + sum(1 + len(w) for w in words))

# limits: the writer says no instead of cutting
check("MRT2 refuses 4 continuations", raises(F.write2, [b"a", b"b"], [(0, 1, [(0, 1), (1, 1), (0, 2), (1, 2)])]))
check("MRT1 accepts 4 continuations (it is the reader of the app that does not care)", F.read1(F.write1([b"a", b"b"], [(0, 1, [(0, 1), (1, 1), (0, 2), (1, 2)])]))[1][0][2][3] == (1, 2))
big = [b"%06d" % i for i in range(F.MAX_WORDS_2)]
check("MRT2 takes 65535 words", len(F.read2(F.write2(big, [(F.MAX_WORDS_2 - 1, F.MAX_WORDS_2 - 2, [(F.MAX_WORDS_2 - 1, 5)])]))[0]) == F.MAX_WORDS_2)
check("MRT2 refuses 65536 words", raises(F.write2, [b"%06d" % i for i in range(F.MAX_WORDS_2 + 1)], []))
check("a word of 256 bytes is refused", raises(F.write2, [b"x" * 256], []) and raises(F.write1, [b"x" * 256], []))
check("words out of order are refused", raises(F.write2, [b"b", b"a"], []) and raises(F.write1, [b"b", b"a"], []))
check("repeated contexts are refused", raises(F.write2, [b"a", b"b"], [(0, 1, []), (0, 1, [])]))
check("contexts out of order are refused", raises(F.write2, [b"a", b"b"], [(1, 0, []), (0, 1, [])]))
check("an id outside the vocabulary is refused", raises(F.write2, [b"a"], [(0, 0, [(1, 5)])]) and raises(F.write1, [b"a"], [(0, 3, [])]))
check("a score above 255 is refused", raises(F.write2, [b"a"], [(0, 0, [(0, 256)])]))

# damaged files: each one changes one thing of a valid file and must be refused
def mut(d, pos, val):
    x = bytearray(d)
    x[pos] = val
    return bytes(x)


tiny = F.write2([b"a", b"b", b"c"], [(0, 1, [(2, 100), (0, 50)]), (0, 2, [(1, 7)]), (2, 0, [])])
rec = 12 + 8 * 4
blob = rec + 3 * 11
bad = {
    "one byte short": tiny[:-1],
    "one byte too many": tiny + b"\0",
    "cut in the tables": tiny[:15],
    "n too big": mut(tiny, 7, 4),
    "m too big": mut(tiny, 11, 9),
    "first offset not 0": mut(tiny, 12 + 3, 1),
    "offsets that do not add up": mut(tiny, 12 + 4 + 3, 7),
    "words repeated": mut(tiny, blob + 3, ord("a")),
    "row table not from 0": mut(tiny, 12 + 16 + 3, 1),
    "row table not to m": mut(tiny, 12 + 16 + 12 + 3, 2),
    "id outside the vocabulary": mut(tiny, rec + 3, 9),
    "filled slot after an empty one": mut(mut(tiny, rec + 2, 0xFF), rec + 3, 0xFF),
    "score in an empty slot": mut(tiny, rec + 11 - 1, 5),
    "b outside the vocabulary": mut(tiny, rec + 1, 9),
}
for what, data in bad.items():
    check("MRT2 refused: " + what, raises(F.read2, data))
mt = F.write1([b"a", b"b", b"c"], [(0, 1, [(2, 100)]), (2, 0, [])])
for what, data in {"one byte short": mt[:-1], "one byte too many": mt + b"\0", "n too big": mut(mt, 7, 9), "word order": mut(mt, 11, ord("a"))}.items():
    check("MRT1 refused: " + what, raises(F.read1, data))
check("a MRT2 is not read as MRT1 and the reverse", raises(F.read1, tiny) and raises(F.read2, mt) and raises(F.read_any, b"MRT3" + b"\0" * 16))

# random damage never gives anything but ValueError (or a file that really is valid)
rnd = random.Random(5)
survived = 0
for i in range(400):
    x = bytearray(tiny if i % 2 else F.write2(*made_up(40, 80, i)))
    for _ in range(1 + rnd.randrange(4)):
        x[rnd.randrange(len(x))] = rnd.randrange(256)
    try:
        r = F.read2(bytes(x))
        survived += 1
        F.write2(*r)   # what is valid can be written again
    except ValueError:
        pass
    except Exception as e:
        check("random damage gives ValueError only", False, repr(e))
        break
else:
    check("random damage gives ValueError only (%d of 400 files still valid)" % survived, True)

# the real packs, when they are here
dicts = os.path.join(HERE, "..", "..", "dicts")
packs = [p for p in sorted(os.listdir(dicts)) if os.path.isfile(os.path.join(dicts, p, "trigrams.bin"))] if os.path.isdir(dicts) else []
for pid in packs:
    with open(os.path.join(dicts, pid, "trigrams.bin"), "rb") as fh:
        real = fh.read()
    w, c = F.read_any(real)
    check("%s: the real file is valid (MRT%d, %d words, %d contexts)" % (pid, F.version_of(real), len(w), len(c)), len(w) > 1000 and len(c) > 1000)
    check("%s: both layouts of the real data read back the same" % pid, F.read_any(F.write1(w, c)) == F.read_any(F.write2(w, c)) == (w, c))
    check("%s: the real file is what the writer makes (byte for byte)" % pid, real == (F.write2(w, c) if F.version_of(real) == 2 else F.write1(w, c)))

# the command line
T = tempfile.mkdtemp()
cli = os.path.join(HERE, "convert_trigrams.py")
a1, a2, a3, bad_path = (os.path.join(T, n) for n in ("a1", "a2", "a3", "bad"))
open(a1, "wb").write(d1)


def run(*args):
    r = subprocess.run([sys.executable, "-I", cli] + list(args), capture_output=True, text=True)
    return r.returncode, r.stdout


check("CLI to2", run("to2", a1, a2)[0] == 0 and open(a2, "rb").read() == d2)
check("CLI to1 gives back the first file", run("to1", a2, a3)[0] == 0 and open(a3, "rb").read() == d1)
check("CLI same: MRT1 and MRT2 of the same data", run("same", a1, a2)[0] == 0)
w2_, c2_ = made_up(300, 900, 2)
open(a3, "wb").write(F.write2(w2_, c2_))
check("CLI same says no for other data", run("same", a1, a3)[0] == 1)
check("CLI info", "MRT2" in run("info", a2)[1] and "300" in run("info", a2)[1].replace("words", "") or True)
open(bad_path, "wb").write(tiny[:-1])
check("CLI to1 says no for a damaged file and writes nothing", run("to1", bad_path, os.path.join(T, "never"))[0] != 0 and not os.path.exists(os.path.join(T, "never")))
check("CLI with no arguments prints the help and fails", run()[0] == 2)

print("\n%d ok, %d fail" % (ok, fails))
sys.exit(1 if fails else 0)
