#!/usr/bin/env python3
"""Lista en-US do Mr Keyboard (v1.64): o mesmo que make_wordlist_lang.py --lang en.

Uso:
  python3 -I make_wordlist_en.py --base en_US_wordlist.combined.gz --corpus noticias.txt \
      --corpus2 conversa.txt --weight2 1 --aff en_US.aff --dic en_US.dic \
      --out main_en.combined.gz [--words-tsv palavras.tsv] [--report relatorio.txt]
Regras e entradas: veja make_wordlist_lang.py.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from make_wordlist_lang import main  # noqa: E402

if __name__ == "__main__":
    sys.argv[1:1] = ["--lang", "en"]
    main()
