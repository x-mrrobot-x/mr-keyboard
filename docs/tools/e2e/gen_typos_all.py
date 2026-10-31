#!/usr/bin/env python3
"""Erros de digitação sintéticos de todos os tipos para CorrEval.java (v1.75), em qualquer idioma.

Uso: python3 -I gen_typos_all.py pt|en|es texto1.txt texto2.txt saida.tsv [quantas_palavras]
Pega as palavras mais comuns (minúsculas, 4+ letras) dos textos de teste e gera, para cada uma, um erro
de cada tipo (saída: errada<TAB>certa<TAB>tipo):
  near       tecla vizinha trocada
  swap       duas letras vizinhas trocadas de lugar
  del_first  falta a 1ª letra
  del_mid    falta uma letra do meio
  del_last   falta a última letra
  dup        letra repetida a mais
Determinístico (semente fixa), para comparar versões do app.
"""
import collections
import random
import re
import sys

lang, f1, f2, out = sys.argv[1:5]
top = int(sys.argv[5]) if len(sys.argv) > 5 else 2500
random.seed(175)
ROWS = {"pt": ["qwertyuiop", "asdfghjklç", "zxcvbnm"],
        "en": ["qwertyuiop", "asdfghjkl", "zxcvbnm"],
        "es": ["qwertyuiop", "asdfghjklñ", "zxcvbnm"]}[lang]
pos = {c: (r, k) for r, row in enumerate(ROWS) for k, c in enumerate(row)}


def near(c):
    if c not in pos:
        return []
    r, k = pos[c]
    res = []
    for dr, dk in [(0, -1), (0, 1), (-1, 0), (-1, 1), (1, -1), (1, 0)]:
        rr, kk = r + dr, k + dk
        if 0 <= rr < 3 and 0 <= kk < len(ROWS[rr]):
            res.append(ROWS[rr][kk])
    return res


cnt = collections.Counter()
for f in (f1, f2):
    for line in open(f, encoding="utf-8"):
        for w in re.findall(r"[^\W\d_]+", line):
            cnt[w] += 1
words = [w for w, _ in cnt.most_common(top * 2) if len(w) >= 4 and w.islower()][:top]
rows = []
for w in words:
    i = random.randrange(len(w))
    n = near(w[i])
    if n:
        rows.append((w[:i] + random.choice(n) + w[i + 1:], w, "near"))
    i = random.randrange(len(w) - 1)
    if w[i] != w[i + 1]:
        rows.append((w[:i] + w[i + 1] + w[i] + w[i + 2:], w, "swap"))
    if len(w) >= 5:
        rows.append((w[1:], w, "del_first"))
        rows.append((w[:-1], w, "del_last"))
    i = random.randrange(1, len(w) - 1)
    rows.append((w[:i] + w[i + 1:], w, "del_mid"))
    i = random.randrange(len(w))
    rows.append((w[:i] + w[i] + w[i:], w, "dup"))
rows = [r for r in rows if r[0] != r[1] and r[0]]
open(out, "w", encoding="utf-8").write("".join("%s\t%s\t%s\n" % r for r in rows))
print(len(rows), "erros de", len(words), "palavras")
