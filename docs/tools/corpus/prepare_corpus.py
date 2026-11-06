#!/usr/bin/env python3
"""Cleans and splits the text corpora of one language for the dictionary rebuild (docs/dictionary-tuning.md).

Usage:
  python3 -I prepare_corpus.py --lang es --subs es.opensubtitles.sample.txt.gz --tatoeba es.tatoeba.tsv.bz2 \
      --news es.leipzig-sentences.txt.gz --out work/es [--tatoeba-code spa] [--names "Tom,Mary"] [--drop-european-pt]

Output (in --out), one sentence per line, UTF-8:
  subs_train.txt   OpenSubtitles sample, cleaned, every occurrence kept (the counts need the real frequency)
  subs_test.txt    HOLD-OUT: distinct sentences whose hash falls in the test slice; none of them is in subs_train.txt
  chat_train.txt / chat_test.txt   Tatoeba (repeated names replaced by "|", repeated sentences dropped, 1 in 20 to test)
  news_train.txt / news_test.txt   Leipzig news (1 in 50 to test, as in the earlier packs)
  report.txt       counts of what was dropped and why (numbers only)

--drop-european-pt (pt-BR): drops every sentence, in the three sources, that has a European Portuguese marker (equipa, facto, ecrã, "estou a fazer"...;
the lists of split_br.py and split_tatoeba.py). The earlier pt-BR pack also dropped whole news sites and Tatoeba authors; the samples of the workflow
carry no site or author, so only sentences with a marker go. The words are then accepted by the Brazilian speller anyway, so what is left over
(a European sentence without any marker) only weighs on the pairs.

The hold-out is by the HASH OF THE SENTENCE, not by its position: every copy of an identical sentence goes to the same side, so
the test sentences are never seen in the training counts (subtitles repeat "Gracias." hundreds of thousands of times; by position
a copy would almost always be in the training set). Slice: md5(text) % 20 == 0 (5% of the distinct sentences).
Only counts leave this machine: the text of the corpora is never stored in the repository or in a pack.
"""
import argparse
import bz2
import collections
import gzip
import hashlib
import os
import re

TAG_RE = re.compile(r"</?[a-zA-Z][^>]*>|\{\\[^}]*\}")           # <i>, </font>, {\an8}
SOUND_RE = re.compile(r"\[[^\]]*\]|\([^)]*\)|♪[^♪]*♪?|#[^#]*#")   # [música], (RISAS), ♪ la la ♪
TIME_RE = re.compile(r"\d{1,2}:\d{2}")                           # timestamps left in the line
CREDIT_RE = re.compile(
    r"opensubtitles|subtitulos\.es|subtitulado|sincroniza|traduc|subt[ií]tulos? (?:por|de|by)|www\.|https?://|\.com\b|\.org\b|\.net\b|"
    r"addic7ed|subdivx|tusubtitulo|resync|corregid|revisi[oó]n|encode|rip by|ripped|copyright|©", re.I)
DASH_RE = re.compile(r"^(?:[-–—]\s*)+")
SPACE_RE = re.compile(r"\s+")
APOS = str.maketrans({"’": "'", "‘": "'", "ʼ": "'", "´": "'", "`": "'"})
LETTERS_RE = re.compile(r"[^\W\d_]", re.U)
CREDIT_PT_RE = re.compile(
    r"legend(?:a|as|ado|adores?)\b|tradu[çc][ãa]o|sincroniza|sincronia|revis[ãa]o|\blegendas?\.|\bsubs? by\b|\bsync\b|\bcorre[çc][ãa]o\b|"
    r"legendas?div|opensubtitles|www\.|https?://|\.com\b|\.org\b|\.net\b|addic7ed|resync|encode|rip by|ripped|copyright|©", re.I)
CREDIT_EN_RE = re.compile(
    r"opensubtitles|\bsubtitles? (?:by|made by|provided|from)\b|\bsubs? by\b|\bsync(?:ed|hronized)?\b.{0,30}\bby\b|\bresync|\bcorrected by\b|"
    r"\btranslated by\b|\btranscribed by\b|\bcaptioned by\b|\bsync and corrections?\b|www\.|https?://|\.com\b|\.org\b|\.net\b|addic7ed|"
    r"\bencoded by\b|\brip(?:ped)? by\b|copyright|©", re.I)
# markers of European Portuguese (split_br.py for the news and the subtitles; split_tatoeba.py adds the 2nd person "tu" forms for Tatoeba)
PT_PT_RE = re.compile(
    r"\b(equipa|equipas|facto|factos|autocarro|telemóvel|telemóveis|ecrã|registo|registos|utilizador|utilizadores|contacto|contactos|casa de banho|"
    r"comboio|pequeno-almoço|vai a ser|frigorífico|guarda-redes|camião|sítio web|rapariga|raparigas|miúdo|miúdos|desporto|desportivo|desportiva|"
    r"óptimo|acção|direcção|objectivo|actual|actualmente|exacto|projecto|baptismo|adoptar|"
    r"(?:estou|está|estás|estamos|estão|estava|estavam|estive|esteve|andava|anda|andam|continua|continuam) a [a-zà-ú]+(?:ar|er|ir|or))\b", re.I)
PT_PT_WIDE_RE = re.compile(
    r"\b(estás|és|tens|vens|queres|podes|sabes|fazes|vais|dizes|tu|contigo|teu|tua|teus|tuas|vós|vosso|vossa|connosco|percebes|sumo|propina|bicha)\b", re.I)


def digest(text):
    return int.from_bytes(hashlib.md5(text.encode("utf-8")).digest()[:8], "big")


def clean_subtitle(line, credit_re=None):
    """Returns the cleaned line or "" when it is not a sentence. Lowercase/uppercase and accents are NOT touched."""
    t = line.rstrip("\n").translate(APOS)
    if TIME_RE.search(t) or (credit_re or CREDIT_RE).search(t):
        return ""
    t = TAG_RE.sub(" ", t)
    t = SOUND_RE.sub(" ", t)
    t = DASH_RE.sub("", SPACE_RE.sub(" ", t).strip())
    t = t.replace("♪", " ").replace("#", " ")
    t = SPACE_RE.sub(" ", t).strip(' -–—"')
    if not t:
        return ""
    letters = len(LETTERS_RE.findall(t))
    if letters < 2 or letters < 0.6 * len(t.replace(" ", "")):    # numbers, symbols, noise
        return ""
    if len(t) > 300:
        return ""
    # a line that is all capitals and long is a title card or a sign, not speech
    if len(t) > 12 and t.upper() == t and letters > 8:
        return ""
    return t


def open_text(path):
    if path.endswith(".gz"):
        return gzip.open(path, "rt", encoding="utf-8", errors="replace")
    if path.endswith(".bz2"):
        return bz2.open(path, "rt", encoding="utf-8", errors="replace")
    return open(path, encoding="utf-8", errors="replace")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--lang", required=True)
    ap.add_argument("--subs", required=True)
    ap.add_argument("--tatoeba", required=True)
    ap.add_argument("--news", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--tatoeba-code", default=None, help="Tatoeba language code (default: from the 2nd column)")
    ap.add_argument("--names", default="", help="comma-separated repeated names of the Tatoeba examples (Tom,Mary...)")
    ap.add_argument("--drop-european-pt", action="store_true", help="pt-BR: drop sentences with European Portuguese markers")
    ap.add_argument("--test-slice", type=int, default=20, help="1 in N distinct subtitle sentences goes to the test set")
    a = ap.parse_args()
    os.makedirs(a.out, exist_ok=True)
    rep = []

    # ---------------------------------------------------------------- subtitles
    drop = collections.Counter()
    credit_re = CREDIT_PT_RE if a.lang.lower().startswith("pt") else CREDIT_EN_RE if a.lang.lower().startswith("en") else None
    pt_pt = PT_PT_RE.search if a.drop_european_pt else (lambda _t: False)
    pt_pt_wide = (lambda t: PT_PT_RE.search(t) or PT_PT_WIDE_RE.search(t)) if a.drop_european_pt else (lambda _t: False)
    seen_test = set()
    n_train = n_test_lines = 0
    with open(os.path.join(a.out, "subs_train.txt"), "w", encoding="utf-8") as tr, \
            open(os.path.join(a.out, "subs_test.txt"), "w", encoding="utf-8") as te:
        for raw in open_text(a.subs):
            t = clean_subtitle(raw, credit_re)
            if not t:
                drop["empty or not a sentence"] += 1
                continue
            if pt_pt(t):
                drop["European Portuguese marker"] += 1
                continue
            if digest(t) % a.test_slice == 0:
                n_test_lines += 1
                if t not in seen_test:
                    seen_test.add(t)
                    te.write(t + "\n")
            else:
                tr.write(t + "\n")
                n_train += 1
    rep.append(f"subtitles: train lines {n_train}; test: {len(seen_test)} distinct sentences "
               f"({n_test_lines} lines in the sample); dropped {sum(drop.values())}: " + ", ".join(f"{v} {k}" for k, v in drop.items()))

    # ---------------------------------------------------------------- Tatoeba
    names = [x for x in a.names.split(",") if x]
    name_re = re.compile(r"\b(?:" + "|".join(re.escape(x) for x in names) + r")(?:'s)?\b") if names else None
    seen, uniq = set(), []
    for line in open_text(a.tatoeba):
        p = line.rstrip("\n").split("\t")
        if len(p) < 3 or (a.tatoeba_code and p[1] != a.tatoeba_code):
            continue
        t = p[2].strip().translate(APOS)
        if name_re:
            t = name_re.sub("|", t)
        if pt_pt_wide(p[2]):
            drop["Tatoeba European Portuguese marker"] += 1
            continue
        if len(t) >= 2 and t not in seen:
            seen.add(t)
            uniq.append(t)
    with open(os.path.join(a.out, "chat_train.txt"), "w", encoding="utf-8") as tr, \
            open(os.path.join(a.out, "chat_test.txt"), "w", encoding="utf-8") as te:
        for i, t in enumerate(uniq):
            (te if i % 20 == 0 else tr).write(t + "\n")
    rep.append(f"Tatoeba: {len(uniq)} distinct sentences, test {(len(uniq) + 19) // 20}; dropped by variant marker: "
               f"{drop['Tatoeba European Portuguese marker']}")

    # ---------------------------------------------------------------- news
    n = [0, 0]
    with open(os.path.join(a.out, "news_train.txt"), "w", encoding="utf-8") as tr, \
            open(os.path.join(a.out, "news_test.txt"), "w", encoding="utf-8") as te:
        for i, line in enumerate(open_text(a.news)):
            p = line.rstrip("\n").split("\t", 1)
            if len(p) < 2:
                continue
            if pt_pt(p[1]):
                drop["news European Portuguese marker"] += 1
                continue
            (te if i % 50 == 0 else tr).write(p[1].translate(APOS) + "\n")
            n[i % 50 == 0] += 1
    rep.append(f"news: train {n[0]}, test {n[1]}; dropped by variant marker: {drop['news European Portuguese marker']}")
    with open(os.path.join(a.out, "report.txt"), "w", encoding="utf-8") as f:
        f.write("\n".join(rep) + "\n")
    print("\n".join(rep))


if __name__ == "__main__":
    main()
