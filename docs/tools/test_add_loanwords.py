#!/usr/bin/env python3
"""Tests add_loanwords.py (common English words added to the main dictionary of a pack).

Run it from the project root:  python3 -I docs/tools/test_add_loanwords.py

What it checks, on small made-up packs: only a missing, plain word of 5+ letters that the English pack has is added; a word one typo away from a
common word is not; the frequency band; every old word, frequency and pair stays the same; the version goes up once; a second run changes nothing;
a dry run writes nothing. And on the shipped packs: every word of added_<id>.tsv is in the pack with that frequency and the list has nothing left to add.
"""
import json
import os
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
sys.path.insert(0, HERE)
import add_loanwords as A  # noqa: E402
import build_dict as B  # noqa: E402

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


def pack(folder, words, bigrams, version=3, fmt=2):
    os.makedirs(folder)
    data, errors, _, _, _, _ = B.write(words, bigrams, fmt)
    assert not errors
    with open(os.path.join(folder, "main.dict"), "wb") as fh:
        fh.write(data)
    with open(os.path.join(folder, "pack.json"), "w", encoding="utf-8") as fh:
        fh.write('{\n  "id": "x",\n  "version": %d,\n  "format": %d\n}\n' % (version, fmt))


def run(*args):
    p = subprocess.run([sys.executable, "-I", os.path.join(HERE, "add_loanwords.py")] + list(args), capture_output=True, text=True)
    return p.returncode, p.stdout + p.stderr


def read(path):
    with open(path, "rb") as fh:
        return B.from_dict(fh.read())


T = tempfile.mkdtemp()
en_words = [("deploy", 98), ("feedback", 109), ("branch", 90), ("commit", 200), ("kit", 120), ("sneakers", 70), ("zzzzz", 40), ("hello", 150), ("Deploy", 99)]
pt_words = [("de", 250), ("para", 240), ("branco", 150), ("feedback", 102), ("Android", 90), ("comite", 80), ("commita", 60), ("casa", 200)]
pt_bigrams = {"de": [("para", 50), ("casa", 40)], "para": [("casa", 30)]}
pack(os.path.join(T, "dicts", "en-US"), en_words, {})
pack(os.path.join(T, "dicts", "pt-BR"), pt_words, pt_bigrams)
wl = os.path.join(T, "list.txt")
open(wl, "w", encoding="utf-8").write("\n".join(["deploy", "feedback", "branch", "commit", "kit", "sneakers", "zzzzz", "missing", "hello", "android", "a-b"]) + "\n")
d = os.path.join(T, "dicts")
md = os.path.join(d, "pt-BR", "main.dict")
pj = os.path.join(d, "pt-BR", "pack.json")

english, _ = read(os.path.join(d, "en-US", "main.dict"))
words, _ = read(md)
added, skipped = A.pick(["deploy", "feedback", "branch", "commit", "kit", "sneakers", "zzzzz", "missing", "hello", "android"], words, english)
got = dict(added)
check("a missing word that the English pack has is added", "deploy" in got and "sneakers" in got and "hello" in got, got)
check("a word the pack already has is not added", "feedback" not in got)
check("a word with a capital variant in the pack is not added", "android" not in got)
check("a word the English pack lacks is not added", "missing" not in got)
check("a word under 5 letters is not added", "kit" not in got)
check("a word one typo away from a common word is not added", "branch" not in got and any(w == "branch" for w, _ in skipped.get("close to a common word", [])), skipped)
check("a word one typo away from a common word of the same pack: commit vs commita (60 < 100) is added", "commit" in got, got)
check("frequency is the English one minus the shift, inside the band", got["deploy"] == 68 and got["hello"] == A.HIGH and got["sneakers"] == A.LOW, got)
check("a word that is not plain is refused", A.pick(["a-b", "Hello", "caf\u00e9s", "x" * 4], words, english)[0] == [])

before = open(md, "rb").read()
rc, out = run("--dicts", d, "--words", wl, "--lang", "pt-BR")
check("a dry run says what it would add and writes nothing", rc == 0 and "to add" in out and open(md, "rb").read() == before and not os.path.exists(os.path.join(T, "added_pt-BR.tsv")), out)

rc, out = run("--dicts", d, "--words", wl, "--lang", "pt-BR", "--write")
new_words, new_bigrams = read(md)
cur = dict(new_words)
check("--write succeeds", rc == 0, out)
check("every old word keeps its frequency", all(cur.get(w) == f for w, f in words), [w for w, f in words if cur.get(w) != f][:5])
check("the new words are in with the frequency of the report", all(cur.get(w) == f for w, f in added))
check("the number of words is old + added", len(new_words) == len(words) + len(added))
check("every pair is the same", {w: sorted(v) for w, v in new_bigrams.items()} == {w: sorted(v) for w, v in pt_bigrams.items()})
check("the version went up by one", json.load(open(pj))["version"] == 4)
check("the report file has the added words", sorted(l.split("\t")[0] for l in open(os.path.join(T, "added_pt-BR.tsv"), encoding="utf-8").read().split("\n") if l) == sorted(w for w, _ in added))

after = open(md, "rb").read()
rc, out = run("--dicts", d, "--words", wl, "--lang", "pt-BR", "--write")
check("a second run adds nothing, rewrites nothing and keeps the version", rc == 0 and "0 to add" in out and open(md, "rb").read() == after and json.load(open(pj))["version"] == 4, out)

rc, out = run("--dicts", d, "--words", wl, "--lang", "xx")
check("a language with no pack is an error", rc != 0)

for lang in ("pt-BR", "es"):
    folder = os.path.join(ROOT, "dicts", lang)
    if not os.path.isdir(folder):
        continue
    shipped, _ = read(os.path.join(folder, "main.dict"))
    freq = dict(shipped)
    with open(os.path.join(HERE, "loanwords", "added_%s.tsv" % lang), encoding="utf-8") as fh:
        rows = [l.rstrip("\n").split("\t") for l in fh if l.strip()]
    check("%s: every word of added_%s.tsv is in the shipped pack with that frequency" % (lang, lang), rows and all(freq.get(w) == int(f) for w, f in rows),
          [w for w, f in rows if freq.get(w) != int(f)][:5])
    with open(os.path.join(HERE, "loanwords", "english_words.txt"), encoding="utf-8") as fh:
        candidates = [w.strip() for w in fh if w.strip()]
    en_shipped, _ = read(os.path.join(ROOT, "dicts", "en-US", "main.dict"))
    left, _ = A.pick(candidates, shipped, en_shipped)
    check("%s: the list has nothing left to add to the shipped pack" % lang, left == [], left[:5])

print("\n%d ok, %d fail" % (ok, fails))
sys.exit(1 if fails else 0)
