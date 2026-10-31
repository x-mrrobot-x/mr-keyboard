#!/usr/bin/env python3
"""Sessões de digitação simuladas para RecentEval.java (v1.75), sem texto de conversa de verdade.

Uso: python3 -I gen_sessions.py texto1.txt texto2.txt saida_topico.txt saida_aleatorio.txt [quantas]
Os corpora de teste vêm embaralhados (frase solta, sem documento). Duas aproximações:
  topico     frases que repetem uma palavra rara (df 3 a 30), na ordem do arquivo: como uma conversa sobre um
             assunto (otimista: o assunto repete mais do que numa conversa de verdade);
  aleatorio  frases sem relação nenhuma (pessimista: as palavras recentes só atrapalham).
Cada sessão são até 8 frases; sessões separadas por linha em branco.
"""
import collections
import random
import re
import sys

f1, f2, out_t, out_r = sys.argv[1:5]
n_sess = int(sys.argv[5]) if len(sys.argv) > 5 else 400
random.seed(1750)
sents = []
for f in (f1, f2):
    for line in open(f, encoding="utf-8"):
        line = line.strip()
        toks = re.findall(r"[^\W\d_]+", line)
        if 6 <= len(toks) <= 25:
            sents.append(line)
sents = list(dict.fromkeys(sents))
df = collections.Counter()
for s in sents:
    for w in sorted(set(t.lower() for t in re.findall(r"[^\W\d_]+", s) if len(t) >= 5)):
        df[w] += 1
seeds = sorted(w for w, c in df.items() if 3 <= c <= 30)   # ordem fixa: o resultado não depende do hash do Python
random.shuffle(seeds)
bysent = collections.defaultdict(list)
for i, s in enumerate(sents):
    for w in sorted(set(t.lower() for t in re.findall(r"[^\W\d_]+", s) if len(t) >= 5)):
        if 3 <= df[w] <= 30:
            bysent[w].append(i)
topic = []
for w in seeds:
    idx = sorted(bysent[w])[:8]
    if len(idx) >= 4:
        topic.append([sents[i] for i in idx])
    if len(topic) >= n_sess:
        break
rand = [random.sample(sents, 8) for _ in range(n_sess)]
open(out_t, "w", encoding="utf-8").write("\n\n".join("\n".join(b) for b in topic) + "\n")
open(out_r, "w", encoding="utf-8").write("\n\n".join("\n".join(b) for b in rand) + "\n")
print(len(topic), "sessões por assunto,", len(rand), "aleatórias,", len(sents), "frases")
