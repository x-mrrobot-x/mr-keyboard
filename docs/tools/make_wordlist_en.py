#!/usr/bin/env python3
"""en-US list of Mr Keyboard (v1.64): the same as make_wordlist_lang.py --lang en.

Usage:
  python3 -I make_wordlist_en.py --base en_US_wordlist.combined.gz --corpus news.txt \
      --corpus2 chat.txt --weight2 1 --aff en_US.aff --dic en_US.dic \
      --out main_en.combined.gz [--words-tsv words.tsv] [--report report.txt]
Rules and inputs: see make_wordlist_lang.py.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from make_wordlist_lang import main  # noqa: E402

if __name__ == "__main__":
    sys.argv[1:1] = ["--lang", "en"]
    main()
