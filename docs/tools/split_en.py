"""Separa os corpora em inglês em treino e teste (v1.64).

Uso: python3 -I split_en.py <pasta_leipzig> <eng_sentences.tsv> <saida>
  Leipzig (<pasta>/<nome>-sentences.txt, id TAB frase): 1 de cada 50 frases vai para o teste.
  Tatoeba (id TAB eng TAB frase): os nomes e lugares que se repetem nas frases de exemplo (Tom,
  Mary, Layla, Rima, Skura, Boston, Algeria...) viram "|", para não ensinarem pares como "Tom is"
  ou "to Boston"; frases repetidas saem; 1 de cada 20 vai para o teste.
Saída: <saida>/news_train.txt, news_test.txt, chat_train.txt, chat_test.txt
"""
import os
import re
import sys

src_dir, tsv, out = sys.argv[1], sys.argv[2], sys.argv[3]
os.makedirs(out, exist_ok=True)
name = os.path.basename(os.path.normpath(src_dir))
sent = os.path.join(src_dir, name + "-sentences.txt")
n = [0, 0]
with open(sent, encoding="utf-8") as f, open(os.path.join(out, "news_train.txt"), "w", encoding="utf-8") as tr, \
        open(os.path.join(out, "news_test.txt"), "w", encoding="utf-8") as te:
    for i, line in enumerate(f):
        p = line.rstrip("\n").split("\t", 1)
        if len(p) < 2:
            continue
        (te if i % 50 == 0 else tr).write(p[1] + "\n")
        n[i % 50 == 0] += 1
print("notícias: treino", n[0], "teste", n[1])

NAMES = re.compile(r"\b(?:Tom|Mary|Layla|Rima|Skura|Ziri|Sami|Yanni|Baya|Walid|Mennad|Taninna|Fadil|Dania|"
                   r"Salima|Nuja|Nuhad|Rami|Boston|Australia|Algeria|Algiers|Algerians?|Kabylie|"
                   r"Kabyles?|Berbers?|Tatoeba)(?:'s)?\b")
seen, uniq = set(), []
with open(tsv, encoding="utf-8") as f:
    for line in f:
        p = line.rstrip("\n").split("\t")
        if len(p) < 3 or p[1] != "eng":
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
