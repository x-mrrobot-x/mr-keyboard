#!/usr/bin/env python3
import argparse
import json
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import build_dict  # noqa: E402

MIN_LEN = 5
CLOSE_FREQ = 100
SHIFT = 30
LOW, HIGH = 55, 80
ALPHABET = "abcdefghijklmnopqrstuvwxyzáàâãéêíóôõúüçñ-'"
WORD_RE = re.compile(r"^[a-z][a-z'-]*$")


def load(path):
    with open(path, "rb") as fh:
        return build_dict.from_dict(fh.read())


def near(w):
    out = set()
    for i in range(len(w)):
        out.add(w[:i] + w[i + 1:])
    for i in range(len(w) - 1):
        out.add(w[:i] + w[i + 1] + w[i] + w[i + 2:])
    for i in range(len(w)):
        for c in ALPHABET:
            out.add(w[:i] + c + w[i + 1:])
    for i in range(len(w) + 1):
        for c in ALPHABET:
            out.add(w[:i] + c + w[i:])
    out.discard(w)
    return out


def pick(candidates, target_words, english):
    freq = {}
    for w, f in target_words:
        k = w.lower()
        freq[k] = max(freq.get(k, 0), f)
    en = {}
    for w, f in english:
        if w == w.lower():
            en[w] = f
    added, skipped = [], {}
    for w in candidates:
        why = None
        if len(w) < MIN_LEN or not WORD_RE.match(w):
            why = "too short or not a plain word"
        elif w in freq:
            why = "already in the pack"
        elif w not in en:
            why = "not in the English pack"
        else:
            close = [n for n in near(w) if freq.get(n, 0) >= CLOSE_FREQ]
            if close:
                why = "close to " + sorted(close, key=lambda n: -freq[n])[0]
        if why:
            skipped.setdefault("close to a common word" if why.startswith("close") else why, []).append((w, why))
        else:
            added.append((w, max(LOW, min(HIGH, en[w] - SHIFT))))
    return added, skipped


def bump(path):
    with open(path, encoding="utf-8") as fh:
        text = fh.read()
    m = re.search(r'("version":\s*)(\d+)', text)
    new = text[:m.start(2)] + str(int(m.group(2)) + 1) + text[m.end(2):]
    with open(path, "w", encoding="utf-8") as fh:
        fh.write(new)
    return int(m.group(2)) + 1


def main():
    ap = argparse.ArgumentParser(description="adds common English words to the main.dict of a dictionary pack; only words that the "
                                 "pack lacks, that the English pack has and that are not one typo away from a common word")
    ap.add_argument("--dicts", default="dicts")
    ap.add_argument("--words", default=os.path.join(os.path.dirname(os.path.abspath(__file__)), "loanwords", "english_words.txt"))
    ap.add_argument("--lang", action="append", required=True)
    ap.add_argument("--write", action="store_true", help="rewrite main.dict, raise the version in pack.json and write added_<id>.tsv")
    ap.add_argument("--list", action="store_true", help="print every word added and every word skipped")
    a = ap.parse_args()
    with open(a.words, encoding="utf-8") as fh:
        candidates = [w.strip() for w in fh if w.strip()]
    english, _ = load(os.path.join(a.dicts, "en-US", "main.dict"))
    status = 0
    for lang in a.lang:
        folder = os.path.join(a.dicts, lang)
        with open(os.path.join(folder, "pack.json"), encoding="utf-8") as fh:
            fmt = json.load(fh)["format"]
        words, bigrams = load(os.path.join(folder, "main.dict"))
        added, skipped = pick(candidates, words, english)
        print("%s: %d words in the pack, %d candidates, %d to add" % (lang, len(words), len(candidates), len(added)))
        for why, lst in sorted(skipped.items()):
            print("  skipped %-34s %d" % (why, len(lst)))
        if a.list:
            print("  added: " + " ".join("%s:%d" % x for x in added))
            for why, lst in sorted(skipped.items()):
                print("  skipped (%s): %s" % (why, " ".join(w if d == why else "%s(%s)" % (w, d[9:]) for w, d in lst)))
        if not added:
            continue
        data, errors, nb, nodes, left_out, dropped = build_dict.write(words + added, bigrams, fmt, 20)
        if left_out or dropped:
            errors.append("%d words and %d bigrams did not survive" % (len(left_out), dropped))
        if nb != sum(len(v) for v in bigrams.values()):
            errors.append("the new dictionary has %d bigrams, expected %d" % (nb, sum(len(v) for v in bigrams.values())))
        if len(nodes) != len(words) + len(added):
            errors.append("the new dictionary has %d words, expected %d" % (len(nodes), len(words) + len(added)))
        if len(data) >= build_dict.FORMATS[fmt][2]:
            errors.append("the new dictionary is over the size limit")
        if errors:
            for e in errors[:20]:
                print("ERROR:", e)
            status = 1
            continue
        print("  new dictionary: %d bytes, limit %d" % (len(data), build_dict.FORMATS[fmt][2]))
        if a.write:
            with open(os.path.join(folder, "main.dict"), "wb") as fh:
                fh.write(data)
            with open(os.path.join(os.path.dirname(a.words), "added_%s.tsv" % lang), "w", encoding="utf-8") as fh:
                for w, f in added:
                    fh.write("%s\t%d\n" % (w, f))
            print("  written; version %d in pack.json" % bump(os.path.join(folder, "pack.json")))
    sys.exit(status)


if __name__ == "__main__":
    main()
