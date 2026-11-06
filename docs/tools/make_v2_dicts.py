#!/usr/bin/env python3
"""Copies dicts/ to another folder with every main.dict re-encoded in the dictionary format v2 (build_dict.py --convert).

Usage: python3 -I docs/tools/make_v2_dicts.py <output folder> [dicts folder]

The tests that read the dictionaries from a folder (run_strategy_tests.sh, mr_test, dict_test) take this
folder in place of dicts/ to prove that the readers (C++ lib, C++ engine) read it well with v2. The
copy is for tests only: pack.json says format 2 / minApp 1086000, but nothing here is published. A dictionary that is already v2 in
dicts/ (es 4, 1.86.1) is copied as it is.
"""
import json
import os
import shutil
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import build_dict  # noqa: E402


def main():
    if len(sys.argv) not in (2, 3):
        print(__doc__)
        sys.exit(2)
    out = sys.argv[1]
    src = sys.argv[2] if len(sys.argv) == 3 else os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "dicts")
    for lang in sorted(os.listdir(src)):
        d = os.path.join(src, lang)
        if not os.path.isfile(os.path.join(d, "main.dict")):
            continue
        o = os.path.join(out, lang)
        os.makedirs(o, exist_ok=True)
        for name in os.listdir(d):
            if name != "main.dict":
                shutil.copy2(os.path.join(d, name), os.path.join(o, name))
        with open(os.path.join(d, "main.dict"), "rb") as fh:
            old = fh.read()
        if build_dict.format_of(old) == 2:
            shutil.copy2(os.path.join(d, "main.dict"), os.path.join(o, "main.dict"))
            continue
        words, bigrams = build_dict.from_dict(old)
        data, errors, nb, nodes, skipped, dropped = build_dict.write(words, bigrams, 2, 20)
        if errors or skipped or dropped:
            print("ERROR:", lang, errors[:5], len(skipped), dropped)
            sys.exit(1)
        with open(os.path.join(o, "main.dict"), "wb") as fh:
            fh.write(data)
        pj = os.path.join(o, "pack.json")
        if os.path.isfile(pj):
            with open(pj, encoding="utf-8") as fh:
                m = json.load(fh)
            m["format"] = 2
            m["minApp"] = 1086000
            with open(pj, "w", encoding="utf-8") as fh:
                json.dump(m, fh, ensure_ascii=False, indent=2)
                fh.write("\n")
        print("%s: %d words, %d bigrams, %d -> %d bytes" % (lang, len(nodes), nb, len(old), len(data)))


if __name__ == "__main__":
    main()
