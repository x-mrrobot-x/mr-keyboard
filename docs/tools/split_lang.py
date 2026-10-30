"""Separa os corpora de um idioma em treino e teste (v1.65; o inglês usou split_en.py, igual).

Uso: python3 -I split_lang.py <pasta_leipzig> <xxx_sentences(_detailed).tsv> <saida> <código_tatoeba> <nomes>
  ex.: split_lang.py spa_news_2025_1M spa_sentences_detailed.tsv split spa "Tom,Mary"
  Leipzig (<pasta>/<nome>-sentences.txt, id TAB frase): 1 de cada 50 frases vai para o teste.
  Tatoeba (id TAB código TAB frase): os nomes e lugares repetidos das frases de exemplo (lista
  separada por vírgula) viram "|", para não ensinarem pares como "Tom es"; frases repetidas saem;
  1 de cada 20 vai para o teste.
Saída: <saida>/news_train.txt, news_test.txt, chat_train.txt, chat_test.txt
"""
import os
import re
import sys

src_dir, tsv, out, code, names = sys.argv[1:6]
os.makedirs(out, exist_ok=True)
name = os.path.basename(os.path.normpath(src_dir))
n = [0, 0]
with open(os.path.join(src_dir, name + "-sentences.txt"), encoding="utf-8") as f, \
        open(os.path.join(out, "news_train.txt"), "w", encoding="utf-8") as tr, \
        open(os.path.join(out, "news_test.txt"), "w", encoding="utf-8") as te:
    for i, line in enumerate(f):
        p = line.rstrip("\n").split("\t", 1)
        if len(p) < 2:
            continue
        (te if i % 50 == 0 else tr).write(p[1] + "\n")
        n[i % 50 == 0] += 1
print("notícias: treino", n[0], "teste", n[1])
NAMES = re.compile(r"\b(?:" + "|".join(re.escape(x) for x in names.split(",") if x) + r")(?:'s)?\b")
seen, uniq = set(), []
with open(tsv, encoding="utf-8") as f:
    for line in f:
        p = line.rstrip("\n").split("\t")
        if len(p) < 3 or p[1] != code:
            continue
        t = NAMES.sub("|", p[2].strip().replace("’", "'"))
        if len(t) >= 2 and t not in seen:
            seen.add(t)
            uniq.append(t)
with open(os.path.join(out, "chat_train.txt"), "w", encoding="utf-8") as tr, \
        open(os.path.join(out, "chat_test.txt"), "w", encoding="utf-8") as te:
    for i, t in enumerate(uniq):
        (te if i % 20 == 0 else tr).write(t + "\n")
print("conversa: frases sem repetição", len(uniq), "teste", (len(uniq) + 19) // 20)
