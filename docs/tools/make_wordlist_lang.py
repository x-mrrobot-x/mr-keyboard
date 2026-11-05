#!/usr/bin/env python3
"""Builds the list of one Mr Keyboard language (words + bigrams) in the AOSP "combined" format.
Used for English (v1.64; make_wordlist_en.py calls this one with --lang en) and for Spanish (v1.65). The
Portuguese has its own rules in make_wordlist.py.

Usage:
  python3 -I make_wordlist_lang.py --lang es --base es_wordlist.combined.gz --corpus news.txt \
      --corpus2 chat.txt --weight2 1 --spell es_ES.aff:es_ES.dic --spell es_MX.aff:es_MX.dic \
      --out main_es.combined.gz [--words-tsv words.tsv] [--report report.txt]
  (for English: --aff en_US.aff --dic en_US.dic, as before)

Inputs
  --base     dictionaries/<language>_wordlist.combined.gz of the AOSP LatinIME (Apache-2.0), version 54,
             from the LineageOS mirror (same commit as the pt-BR list).
  --corpus   news sentences (Leipzig, CC BY 4.0), one per line.
  --corpus2  chat sentences (Tatoeba, CC BY 2.0 FR), with the repeated names replaced by "|".
  The Hunspell spellers (--spell, one or more; it counts if any of them accepts) only serve as a
  filter (they decide whether a new word comes in); nothing from them is copied.

Rules
  base     - minus the not_a_word entries (they are only shortcuts; the good ones became corrections in rules.txt);
           - words with characters >= 0xFF or more than 40 letters are dropped (format limit);
           - possibly offensive ones (AOSP list) are never prediction; the vulgar ones (VULGAR) stay
             with f = 5 and only show up when typed in full.
  corpus   - lowercase words that Hunspell accepts (in English, American spelling: "colour" does not come in), with
             count >= --min-count; proper names accepted by Hunspell with count >=
             --min-name-count outside the start of a sentence and without the lowercase form in the list;
           - f of the new words: fit f ~ a*log10(count) + b on the base words, minus 10.
  informal - a few chat words missing from the base (lol, omg, okay...).
  bigrams  - same as the pt-BR list (make_wordlist.py): stretches without punctuation, 2nd corpus with
             weight --weight2, the first --top-each of each word guaranteed and the rest by
             count up to --max-bigrams; 7-bit f = 127*(1 + log10(P(w2|w1))/3).
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
    # fixed chat expressions that the texts underestimate (Tatoeba has each sentence only once):
    # the continuation becomes the word's 1st one
    # (only words that are not among the most frequent: "de nada" in front of "de la" would get in the way)
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
    ap.add_argument("--spell", action="append", default=[], help="Hunspell aff:dic (can be repeated)")
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
        ap.error("give --aff/--dic or --spell")
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
    rep.append(f"base: {len(base)} words ({skipped} left out by the format), "
               f"{len(offensive)} possibly offensive")
    final = dict(base)

    # ------------------------------------------------------------------ counts (1st pass)
    seen = collections.Counter()       # exact form
    lower_seen = collections.Counter()  # lowercase
    cap_mid = collections.Counter()    # capitalized outside the start of a sentence, news only
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

    rep.append(f"fit of the new words: f = {slope:.2f}*log10(c) + {icpt + 10:.2f} - 10 (n={len(xs)})")

    # ------------------------------------------------------------------ new words
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
            continue  # new acronyms are left out
        if w.lower() in base_lower or not sp.ok(w):
            continue
        final[w] = f_new(c)
        new_names.append(w)
    informal = [w for w in cfg["informal"] if w not in final]
    for w in informal:
        final[w] = cfg["informal"][w]
    # vulgar ones (from the base or the corpus): minimum f and never prediction
    vulgar = cfg["vulgar"]
    for w in vulgar & set(final):
        final[w] = 5
    offensive |= vulgar & set(final)
    rep.append(f"new from the corpus: {len(new_lower)} lowercase, {len(new_names)} names; "
               f"chat: {len(informal)} ({' '.join(sorted(informal))})")

    # ------------------------------------------------------------------ bigrams (2nd pass)
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
    rep.append(f"bigrams: {len(pair)} pairs; {sum(len(v) for v in by_w1.values())} with c >= "
               f"{a.min_bigram}; chose {nsel} for {len(chosen)} words")
    if boosted:
        rep.append("chat expressions in 1st place: " + ", ".join(boosted))

    # ------------------------------------------------------------------ output
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
    rep.append(f"final list: {len(final)} words")
    print("\n".join(rep))
    if a.report:
        with open(a.report, "w", encoding="utf-8") as r:
            r.write("\n".join(rep) + "\n\n")
            r.write(f"[new lowercase] ({len(new_lower)})\n" + " ".join(sorted(new_lower, key=lambda w: -seen[w])[:800]) + "\n\n")
            r.write(f"[new names] ({len(new_names)})\n" + " ".join(sorted(new_names, key=lambda w: -cap_mid[w])[:800]) + "\n")


if __name__ == "__main__":
    main()
