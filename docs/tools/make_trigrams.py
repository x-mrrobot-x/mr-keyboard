#!/usr/bin/env python3
"""Gera o trigrams.bin do pacote de dicionário (dicts/<id>/; antes da 1.63, assets/mr_trigrams.bin): as palavras mais prováveis depois de DUAS palavras (trigramas),
lidas em Java por MrTrigram (a lib nativa só guarda pares).

Uso:
  python3 -I make_trigrams.py --list main_pt.combined.gz --base pt_BR_wordlist.combined.gz \
      --corpus noticias.txt [--corpus2 conversa.txt --weight2 3] --out mr_trigrams.bin

Só entram contextos (palavra1, palavra2) vistos pelo menos --min-ctx vezes, com continuações
vistas pelo menos --min-count vezes (contagens já com peso), e só quando as 3 primeiras
continuações diferem das 3 que o par (palavra2 -> ?) já daria: no resto, o dicionário já acerta.

Formato (big-endian):
  "MRT1" | u32 nPalavras | nPalavras x (u8 bytes UTF-8, texto) em ordem de código
  | u32 nContextos | nContextos x (u24 id1, u24 id2, u8 k, k x (u24 id3, u8 f7))
  ordenado por (id1, id2); f7 = 127*(1 + log10(P(w3|w1 w2))/3), de 1 a 127.
"""
import argparse
import collections
import gzip
import math
import os
import struct
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from make_wordlist import tokens, is_word, SENTENCE_END  # noqa: E402


def read_list(path):
    freq, big = {}, collections.defaultdict(list)
    cur = None
    with gzip.open(path, "rt", encoding="utf-8") as fh:
        for line in fh:
            if line.startswith(" word="):
                d = dict(kv.split("=", 1) for kv in line.strip().split(","))
                cur = d["word"]
                freq[cur] = int(d["f"])
            elif line.startswith("  bigram=") and cur is not None:
                d = dict(kv.split("=", 1) for kv in line.strip().split(","))
                big[cur].append((d["bigram"], int(d["f"])))
    for k in big:
        big[k].sort(key=lambda x: -x[1])
    return freq, big


def read_offensive(path):
    off = set()
    with gzip.open(path, "rt", encoding="utf-8") as fh:
        for line in fh:
            if line.startswith(" word=") and "possibly_offensive=true" in line:
                off.add(line[6:line.index(",")])
    return off


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--list", required=True)
    ap.add_argument("--base", required=True)
    ap.add_argument("--corpus", required=True)
    ap.add_argument("--corpus2", default=None)
    ap.add_argument("--weight2", type=int, default=1)
    ap.add_argument("--min-ctx", type=int, default=8)
    ap.add_argument("--min-count", type=int, default=3)
    ap.add_argument("--out", required=True)
    a = ap.parse_args()

    final, big = read_list(a.list)
    offensive = read_offensive(a.base) | {w for w, f in final.items() if f <= 5}

    def canon(t, first):
        if first and t[0].isupper():
            lw = t.lower()
            if lw in final:
                return lw
            return t if t in final else None
        if t in final:
            return t
        if t[0].isupper():
            lw = t.lower()
            if lw in final:
                return lw
        return None

    def segments():
        files = [(a.corpus, 1)] + ([(a.corpus2, a.weight2)] if a.corpus2 else [])
        for path, wgt in files:
            for line in open(path, encoding="utf-8"):
                seg, first = [], True
                for t in tokens(line.strip()):
                    if not t[0].isalpha():
                        if len(seg) >= 3:
                            yield seg, wgt
                        seg = []
                        if t in SENTENCE_END:
                            first = True
                        continue
                    w = canon(t, first) if is_word(t) else None
                    first = False
                    if w is None:
                        if len(seg) >= 3:
                            yield seg, wgt
                        seg = []
                    else:
                        seg.append(w)
                if len(seg) >= 3:
                    yield seg, wgt

    pairs = collections.Counter()
    for seg, wgt in segments():
        for i in range(len(seg) - 2):
            pairs[(seg[i], seg[i + 1])] += wgt
    ctxs = {k for k, c in pairs.items() if c >= a.min_ctx}
    del pairs
    tri = collections.defaultdict(collections.Counter)
    for seg, wgt in segments():
        for i in range(len(seg) - 2):
            k = (seg[i], seg[i + 1])
            if k in ctxs:
                tri[k][seg[i + 2]] += wgt

    kept = {}
    for k, cnt in tri.items():
        total = sum(cnt.values())
        cands = [(c, w) for w, c in cnt.items() if c >= a.min_count and w not in offensive]
        if not cands:
            continue
        cands.sort(key=lambda x: (-x[0], x[1]))
        top = cands[:3]
        bigram_top = [w for w, _ in big.get(k[1], [])[:3]]
        if [w for _, w in top] == bigram_top[:len(top)]:
            continue
        kept[k] = [(w, max(1, min(127, int(round(127 * (1 + math.log10(c / total) / 3)))))) for c, w in top]

    vocab = sorted({w for k in kept for w in k} | {w for v in kept.values() for w, _ in v})
    vid = {w: i for i, w in enumerate(vocab)}
    if len(vocab) >= 1 << 24:
        raise ValueError("vocabulário grande demais para ids de 24 bits")
    out = bytearray(b"MRT1")
    out += struct.pack(">I", len(vocab))
    for w in vocab:
        b = w.encode("utf-8")
        out.append(len(b))
        out += b
    keys = sorted(kept, key=lambda k: (vid[k[0]], vid[k[1]]))
    out += struct.pack(">I", len(keys))
    for k in keys:
        out += vid[k[0]].to_bytes(3, "big") + vid[k[1]].to_bytes(3, "big")
        out.append(len(kept[k]))
        for w, f in kept[k]:
            out += vid[w].to_bytes(3, "big")
            out.append(f)
    with open(a.out, "wb") as fh:
        fh.write(out)
    print(f"contextos com {a.min_ctx}+ ocorrências: {len(ctxs)}; gravados (diferentes do par): "
          f"{len(keys)}; palavras: {len(vocab)}; bytes: {len(out)}")


if __name__ == "__main__":
    main()
