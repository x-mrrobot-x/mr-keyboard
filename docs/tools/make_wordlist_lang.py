#!/usr/bin/env python3
"""Monta a lista de um idioma do Mr Keyboard (palavras + bigramas) no formato "combined" do AOSP.
Usado no inglês (v1.64; make_wordlist_en.py chama este com --lang en) e no espanhol (v1.65). O
português tem regras próprias em make_wordlist.py.

Uso:
  python3 -I make_wordlist_lang.py --lang es --base es_wordlist.combined.gz --corpus noticias.txt \
      --corpus2 conversa.txt --weight2 1 --spell es_ES.aff:es_ES.dic --spell es_MX.aff:es_MX.dic \
      --out main_es.combined.gz [--words-tsv palavras.tsv] [--report relatorio.txt]
  (no inglês: --aff en_US.aff --dic en_US.dic, como antes)

Entradas
  --base     dictionaries/<idioma>_wordlist.combined.gz do AOSP LatinIME (Apache-2.0), versão 54,
             do espelho do LineageOS (mesmo commit da lista pt-BR).
  --corpus   frases de notícias (Leipzig, CC BY 4.0), uma por linha.
  --corpus2  frases de conversa (Tatoeba, CC BY 2.0 FR), com os nomes repetidos trocados por "|".
  Os corretores do Hunspell (--spell, um ou mais; vale se qualquer um aceitar) servem só de
  filtro (decidem se uma palavra nova entra); nada deles é copiado.

Regras
  base     - fora as entradas not_a_word (são só atalhos; as boas viraram correções no rules.txt);
           - palavras com caracteres >= 0xFF ou mais de 40 letras saem (limite do formato);
           - possivelmente ofensivas (lista do AOSP) nunca são previsão; as vulgares (VULGAR) ficam
             com f = 5 e só aparecem quando digitadas por inteiro.
  corpus   - minúsculas que o Hunspell aceita (no inglês, grafia americana: "colour" não entra), com
             contagem >= --min-count; nomes próprios aceitos pelo Hunspell com contagem >=
             --min-name-count fora do início de frase e sem a forma minúscula na lista;
           - f das palavras novas: ajuste f ~ a*log10(contagem) + b nas palavras da base, menos 10.
  informal - poucas palavras de conversa que faltam na base (lol, omg, okay...).
  bigramas - iguais aos da lista pt-BR (make_wordlist.py): trechos sem pontuação, 2º corpus com
             peso --weight2, as --top-each primeiras de cada palavra garantidas e o resto por
             contagem até --max-bigrams; f de 7 bits = 127*(1 + log10(P(w2|w1))/3).
"""
import argparse
import collections
import gzip
import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from make_wordlist import SENTENCE_END, Speller, corpus_lines, is_word, tokens  # noqa: E402

MAX_WORD = 40
LANGS = {}
LANGS["en"] = {"header": "dictionary=main:en_us,locale=en_US,description=English (US),date=1793318400,version=64"}
VULGAR = {
    "fuck", "fucking", "fucked", "fucker", "fuckers", "fucks", "motherfucker", "motherfuckers",
    "shit", "shits", "shitty", "bullshit", "bitch", "bitches", "cunt", "cunts", "cock", "cocks",
    "dick", "dicks", "pussy", "cum", "whore", "whores", "slut", "sluts", "asshole", "assholes",
    "wank", "wanker", "twat", "nigger", "niggers", "nigga", "faggot", "faggots", "fag", "fags",
}
INFORMAL = {
    "lol": 120, "omg": 110, "okay": 150, "ok": 150, "yeah": 150, "yep": 120, "nope": 120,
    "haha": 120, "hahaha": 100, "hmm": 110, "lmao": 90, "btw": 100, "idk": 90, "tbh": 90,
    "gonna": 130, "wanna": 120, "gotta": 120, "kinda": 110, "sorta": 90, "y'all": 100,
}
LANGS["en"]["vulgar"] = VULGAR
LANGS["en"]["informal"] = INFORMAL
LANGS["es"] = {
    "header": "dictionary=main:es,locale=es,description=Español,date=1793318400,version=65",
    "vulgar": {
        "puta", "putas", "puto", "putos", "mierda", "mierdas", "coño", "joder", "jodido", "jodida",
        "verga", "vergas", "pendejo", "pendeja", "pendejos", "culero", "culeros", "chingar",
        "chingada", "chingado", "cabrón", "cabrones", "maricón", "maricones", "marica", "polla",
        "follar", "gilipollas", "hijueputa", "carajo", "zorra", "culo",
    },
    "informal": {
        "jaja": 120, "jajaja": 110, "jajajaja": 90, "jeje": 100, "ok": 140, "porfa": 100,
        "finde": 90, "okey": 100, "holi": 80,
    },
    # expressões fixas de conversa que os textos subestimam (o Tatoeba tem cada frase uma vez só):
    # a continuação passa a ser a 1ª da palavra
    # (só palavras que não são das mais frequentes: "de nada" na frente de "de la" atrapalharia)
    "boost": [
        ("muchas", "gracias"), ("buenos", "días"), ("buenas", "noches"), ("buenas", "tardes"),
        ("te", "quiero"), ("hasta", "luego"), ("mucho", "gusto"), ("feliz", "cumpleaños"),
    ],
}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--lang", required=True, choices=sorted(LANGS))
    ap.add_argument("--base", required=True)
    ap.add_argument("--corpus", required=True)
    ap.add_argument("--corpus2", default=None)
    ap.add_argument("--weight2", type=int, default=1)
    ap.add_argument("--aff", default=None)
    ap.add_argument("--dic", default=None)
    ap.add_argument("--spell", action="append", default=[], help="aff:dic do Hunspell (pode repetir)")
    ap.add_argument("--out", required=True)
    ap.add_argument("--words-tsv", default=None)
    ap.add_argument("--report", default=None)
    ap.add_argument("--min-count", type=int, default=3)
    ap.add_argument("--min-name-count", type=int, default=20)
    ap.add_argument("--min-bigram", type=int, default=2)
    ap.add_argument("--max-bigrams", type=int, default=400000)
    ap.add_argument("--per-word", type=int, default=60)
    ap.add_argument("--top-each", type=int, default=3)
    a = ap.parse_args()
    rep = []
    cfg = LANGS[a.lang]
    pairs = [x.split(":", 1) for x in a.spell]
    if a.aff and a.dic:
        pairs.insert(0, [a.aff, a.dic])
    if not pairs:
        ap.error("informe --aff/--dic ou --spell")
    spellers = [Speller(x[0], x[1]) for x in pairs]

    class AnySpeller:
        @staticmethod
        def ok(w):
            return any(s.ok(w) for s in spellers)

    sp = AnySpeller()

    # ------------------------------------------------------------------ base
    base, offensive, skipped = {}, set(), 0
    with gzip.open(a.base, "rt", encoding="utf-8") as fh:
        for line in fh:
            if not line.startswith(" word="):
                continue
            d = dict(kv.split("=", 1) for kv in line.strip().split(","))
            w = d["word"]
            if d.get("not_a_word") == "true" or int(d["f"]) <= 0:
                continue
            if len(w) > MAX_WORD or any(ord(c) >= 0xFF for c in w):
                skipped += 1
                continue
            base[w] = int(d["f"])
            if d.get("possibly_offensive") == "true":
                offensive.add(w)
    rep.append(f"base: {len(base)} palavras ({skipped} fora pelo formato), "
               f"{len(offensive)} possivelmente ofensivas")
    final = dict(base)

    # ------------------------------------------------------------------ contagens (1ª passada)
    seen = collections.Counter()       # forma exata
    lower_seen = collections.Counter()  # minúscula
    cap_mid = collections.Counter()    # com maiúscula fora do começo de frase, só nas notícias
    sources = [(a.corpus, True)] + ([(a.corpus2, False)] if a.corpus2 else [])
    for path, news in sources:
        for line in open(path, encoding="utf-8"):
            first = True
            for t in tokens(line.strip()):
                if not t[0].isalpha():
                    if t in SENTENCE_END:
                        first = True
                    continue
                if not is_word(t):
                    first = False
                    continue
                seen[t] += 1
                lower_seen[t.lower()] += 1
                if not first and t[0].isupper() and news:
                    cap_mid[t] += 1
                first = False

    xs, ys = [], []
    for w, f in base.items():
        c = lower_seen[w]
        if w[:1].islower() and c >= 5:
            xs.append(math.log10(c))
            ys.append(f)
    mx, my = sum(xs) / len(xs), sum(ys) / len(ys)
    slope = sum((x - mx) * (y - my) for x, y in zip(xs, ys)) / sum((x - mx) ** 2 for x in xs)
    icpt = my - slope * mx - 10

    def f_new(c):
        return max(30, min(180, int(round(slope * math.log10(c) + icpt))))

    rep.append(f"ajuste das palavras novas: f = {slope:.2f}*log10(c) + {icpt + 10:.2f} - 10 (n={len(xs)})")

    # ------------------------------------------------------------------ palavras novas
    base_lower = {w.lower() for w in final}
    new_lower, new_names = [], []
    for w, c in seen.items():
        if len(w) > MAX_WORD or w in final:
            continue
        if w.islower():
            if c >= a.min_count and len(w) >= 3 and w not in base_lower and sp.ok(w):
                final[w] = f_new(c)
                new_lower.append(w)
    base_lower = {w.lower() for w in final}
    for w, c in cap_mid.items():
        if w in final or c < a.min_name_count or len(w) < 2:
            continue
        if w.isupper() and len(w) > 1:
            continue  # siglas novas ficam de fora
        if w.lower() in base_lower or not sp.ok(w):
            continue
        final[w] = f_new(c)
        new_names.append(w)
    informal = [w for w in cfg["informal"] if w not in final]
    for w in informal:
        final[w] = cfg["informal"][w]
    # vulgares (da base ou do corpus): f mínima e nunca previsão
    vulgar = cfg["vulgar"]
    for w in vulgar & set(final):
        final[w] = 5
    offensive |= vulgar & set(final)
    rep.append(f"novas do corpus: {len(new_lower)} minúsculas, {len(new_names)} nomes; "
               f"conversa: {len(informal)} ({' '.join(sorted(informal))})")

    # ------------------------------------------------------------------ bigramas (2ª passada)
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

    pair = collections.Counter()
    left = collections.Counter()
    for line, wgt in corpus_lines(a, weighted=True):
        prev = None
        first = True
        for t in tokens(line.strip()):
            if not t[0].isalpha():
                prev = None
                if t in SENTENCE_END:
                    first = True
                continue
            w = canon(t, first) if is_word(t) else None
            first = False
            if prev is not None:
                left[prev] += wgt
                if w is not None:
                    pair[(prev, w)] += wgt
            prev = w
    by_w1 = collections.defaultdict(list)
    for (w1, w2), c in pair.items():
        if c >= a.min_bigram and w2 not in offensive and final.get(w2, 0) > 5:
            by_w1[w1].append((c, w2))
    ranked = []
    for w1, lst in by_w1.items():
        lst.sort(key=lambda x: (-x[0], x[1]))
        for r, (c, w2) in enumerate(lst[:a.per_word]):
            ranked.append((0 if r < a.top_each else 1, -c, w1, w2, c))
    ranked.sort()
    chosen = collections.defaultdict(list)
    for r, _negc, w1, w2, c in ranked[:a.max_bigrams]:
        p = c / left[w1]
        f7 = max(1, min(127, int(round(127 * (1 + math.log10(p) / 3)))))
        chosen[w1].append((w2, f7, c))
    boosted = []
    for w1, w2 in cfg.get("boost", []):
        if w1 not in final or w2 not in final:
            continue
        lst = [x for x in chosen.get(w1, []) if x[0] != w2]
        top = max((x[1] for x in lst), default=100)
        lst.append((w2, min(127, top + 1), pair.get((w1, w2), 0)))
        chosen[w1] = lst
        boosted.append(f"{w1} {w2}")
    nsel = sum(len(v) for v in chosen.values())
    rep.append(f"bigramas: {len(pair)} pares; {sum(len(v) for v in by_w1.values())} com c >= "
               f"{a.min_bigram}; escolhidos {nsel} para {len(chosen)} palavras")
    if boosted:
        rep.append("expressões de conversa em 1º: " + ", ".join(boosted))

    # ------------------------------------------------------------------ saída
    order = sorted(final, key=lambda x: (-final[x], x))
    with gzip.open(a.out, "wt", encoding="utf-8") as o:
        o.write(cfg["header"] + "\n")
        for w in order:
            o.write(f" word={w},f={final[w]}\n")
            for w2, f7, c in sorted(chosen.get(w, []), key=lambda x: (-x[1], -x[2], x[0])):
                o.write(f"  bigram={w2},f={f7}\n")
    if a.words_tsv:
        with open(a.words_tsv, "w", encoding="utf-8") as o:
            for w in order:
                o.write(f"{w}\t{final[w]}\n")
    rep.append(f"lista final: {len(final)} palavras")
    print("\n".join(rep))
    if a.report:
        with open(a.report, "w", encoding="utf-8") as r:
            r.write("\n".join(rep) + "\n\n")
            r.write(f"[novas minúsculas] ({len(new_lower)})\n" + " ".join(sorted(new_lower, key=lambda w: -seen[w])[:800]) + "\n\n")
            r.write(f"[novos nomes] ({len(new_names)})\n" + " ".join(sorted(new_names, key=lambda w: -cap_mid[w])[:800]) + "\n")


if __name__ == "__main__":
    main()
