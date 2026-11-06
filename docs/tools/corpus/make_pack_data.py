#!/usr/bin/env python3
"""Builds the data of one language pack from the mixed corpora (plan-suggestions.md, phase 4):
the word list with bigrams (AOSP "combined" format, input of build_dict.py) and trigrams.bin (MRT1).

Usage:
  python3 -I make_pack_data.py --lang es --work work/es --base es_wordlist.combined.gz \
      --spell es_ES.aff:es_ES.dic --spell es_MX.aff:es_MX.dic --out work/es/out [--mix subs=0.60,chat=0.20,news=0.15]

Input (--work, from prepare_corpus.py): subs_train.txt, chat_train.txt, news_train.txt.
Output (--out): main.combined.gz, trigrams.bin, words.tsv, report.txt. Only counts leave the corpora; no sentence is written.

How the sources are mixed. Each source s has a weight  W_s = share_s * T / tokens_s  (T = tokens of the subtitles / share of the subtitles),
so that after weighting the subtitles are `subs` of the mass, the Tatoeba sentences `chat` and the news `news`; the remaining 5% is the AOSP
list itself (its own frequency stays in the blend, see BASE_SHARE). The weighted count is used for the frequency of a word, the pair
probabilities and the order of the pairs; the REAL counts decide what is allowed in (a word or a pair seen once is not a fact).
"""
import argparse
import collections
import gzip
import re
import math
import multiprocessing
import os
import struct
import sys
import unicodedata

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
from make_wordlist import SENTENCE_END, Speller, is_word, tokens  # noqa: E402
from make_wordlist_lang import LANGS, MAX_WORD  # noqa: E402
import make_wordlist as _pt  # noqa: E402  (the lists written for the Portuguese pack)

LANGS = dict(LANGS)
LANGS["pt-BR"] = {
    "header": "dictionary=main:pt_BR,locale=pt_BR,description=Português (Brasil),date=1793318400,version=65",
    "vulgar": set(_pt.VULGAR),
    "informal": dict(_pt.INFORMAL),
    "extra_offensive": set(_pt.EXTRA_OFFENSIVE),     # vulgar words that the AOSP does not mark: never a prediction
    "name_exclude": set(_pt.NAME_EXCLUDE),            # English words that the speller accepts with a capital (Big, Wall, Man, Max)
    "name_always": set(_pt.NAME_ALWAYS),              # brands that stay even when the lowercase form is an English word
}
# Inflections of swear words that the lists above do not have (fodeu, cagou, jodido...). The subtitles are full of them, so a NEW word that
# matches is treated like the listed ones: f = 5, never a prediction, it only shows up when typed in full.
LANGS["pt-BR"]["vulgar_re"] = re.compile(
    r"^(?:fod(?:a|as|e|em|er|eu|eram|i|ido|ida|idos|idas|endo|ia|iam|ão|ões)|foda-se|fode-se|fodam-se|cagu?(?:ei|ou|ar|ado|ada|adas|ados|aram|ando)|"
    r"cag[ao]s?|merdas?|merdinha|merdão|mij(?:ar|ou|ei|ada|ado|ando)|xoxotas?|trepad[ao]s?|trepou|trepamos|trepando|boquetes?|peid(?:ar|ou|o|os|ei|ando)|"
    r"punhetas?|punheteiro|putaria|putarias|putinhas?|putões|putas|puteiros?|cuzão|cuzões|cuzinho|bucetas?|caralhos?|porras?|porrada|viadinho|viadão|"
    r"viados|bichas|vagabundas?|vadias?|pirocas?|picas|chupadas?)$")
LANGS["es"] = dict(LANGS["es"])
LANGS["es"]["vulgar_re"] = re.compile(
    r"^(?:jod(?:er|ido|ida|idos|idas|ete|erme|erte|erlo|erla|erse|erles|ió|ieron|iste|iendo|a|as|an|e|es|o)|follar(?:te|me|se|lo|la|nos)?|"
    r"follad[oa]s?|follam(?:os|e|te)|folló|follaste|follaron|coñazo|coños|cabronas?|cabronazo|cagar(?:se|la|me|te|lo|los)?|"
    r"cag(?:ó|aron|aste|ué|ado|ada|ados|adas|ando|a|an)|mierdas|mierdero|comemierda|pendej[oa]s?|pendejadas?|verg[ao]s?|chingar|chingad[ao]s?|"
    r"chinga[nsr]?|culer[oa]s?|culos|culito|putas?|putos|putada|putadas|putillas?|putitas?|boludo|boluda|boludos|boludas|boludeces|pelotud[oa]s?|"
    r"pelotudez|pijas?|pollas|malnacid[oa]s?|lameculos|maricones|maricas|carajos|hijueputas?|gilipollez|gilipolleces|zorras?)$")

LANGS["en"] = dict(LANGS["en"])
LANGS["en"]["header"] = "dictionary=main:en_us,locale=en_US,description=English (US),date=1793318400,version=65"
# slurs that the subtitles bring as new words: f = 5, never a prediction (lowercase and capitalised)
LANGS["en"]["vulgar"] = set(LANGS["en"]["vulgar"]) | {x for w in ("jap", "japs", "chink", "chinks", "gook", "gooks", "wetback", "wetbacks", "spic", "spics",
                                                                 "kike", "kikes", "paki", "pakis", "negroes") for x in (w, w.capitalize())}


def _en_reject(w):
    """Why a NEW English word or name must not come in (None = it may): stutters of the subtitles (I-I, w-what, wh-what), compounds that
    carry a contraction (I'm-I'm), the possessive of a single letter (A's, B's)."""
    lw = w.lower()
    parts = lw.split("-")
    if len(parts) > 1:
        f, nxt = parts[0], parts[1]
        if (len(f) == 1 and nxt.startswith(f)) or (len(f) == 2 and len(nxt) > 2 and nxt.startswith(f)):
            return "stutter"
        if re.search(r"'(?!s$)", lw):
            return "compound with a contraction"
    if re.match(r"^[a-z]'s$", lw):
        return "possessive of a letter"
    return None


LANGS["en"]["reject"] = _en_reject
LANGS["en"]["cap_mid_only"] = True
# The other languages' lists hold English loanwords and hyphenated compounds (barista, quinoa, e-mails, bye-bye), so in English the lists only judge
# SHORT words without a hyphen: what the English speller lets through of a foreign language is abbreviations and fragments (est, fir, cis, dis, res).
LANGS["en"]["foreign_short_only"] = 5
# Inflections and compounds of swear words that VULGAR (make_wordlist_lang.py) does not list: f = 5, never a prediction (see pt-BR above).
LANGS["en"]["vulgar_re"] = re.compile(
    r"^(?:fuck(?:in|ing|en|ups?|head|heads|face|wit|tard|tards|boy|boys|ed|hole)|motherfuck(?:ing|in|ed|er|ers|a|as|s)?|mothafuck(?:a|as|er|ers|in|ing)?|"
    r"mofos?|bullshit(?:ting|ter|ters|ted|s)?|shit(?:ting|ted|head|heads|hole|holes|load|storm|face|faced|bag|less|ty|ter|ters)|"
    r"bitch(?:ing|y|ed|in|ass|es)|cocksuck(?:er|ers|ing)|dickheads?|asshats?|asswipes?|wank(?:ing|ed|ers?|s)|twats?|twatty|whor(?:ing|ehouses?)|"
    r"slutty|pussies|nigg(?:as|az|ers|a)|faggy)$")

BREAK, END, UNK = "\x01", "\x02", "\x03"   # in the token cache: punctuation, sentence end, a word the format cannot hold
BASE_SHARE = 0.05                           # weight of the AOSP frequency when the corpora have plenty of evidence
FULL_EVIDENCE = 30                          # real occurrences from which the corpora decide the frequency alone (minus BASE_SHARE)
SOURCES = ("subs", "chat", "news")
# function words of another language that the subtitles quote (songs, titles, signs): they must not become words of the pack
FOREIGN = {
    "es": set("the and you that for your with this are not but have was what all out one can will who from they his her she him had been were "
              "there when which would about into just like know get got going let here how now our their them then than too very yes "
              "its off over only some such more most much many any each other own same so did does done him said say see way".split()),
}
# English: function words of Spanish, French, German, Italian and Portuguese that the subtitles quote (only words that are not in the AOSP list matter)
FOREIGN["en"] = set("que los las una por para con pero como esta este muy bien gracias hola señor usted nada todo porque donde cuando también más está estoy "
                    "tengo quiero vamos est les des pas pour vous nous avec dans une qui mon mes oui non merci suis tout très être mais sont elle "
                    "und der die das ich nicht ist ein sie wir bitte danke ja nein mit auf für auch nur wie noch che per sono mio grazie ciao prego anche "
                    "questo não você uma são quot amp nbsp iii".split())
FOREIGN["pt-BR"] = FOREIGN["es"]    # the English function words quoted in subtitles are the same
# two-letter forms that are real words of a keyboard (the capitalised-in-the-middle count would otherwise take "In", "Is", "To"... from quoted English)
SHORT_OK = {"es": {"Sr", "Ud", "Vd"}, "pt-BR": {"Sr", "Dr", "Sra", "Dra"}, "en": {"Mr", "Dr", "Ms", "St"}}


STRIP_APOS = False   # English: "dont" is the folded form of "don't", so it must not become a word next to it (it would stop the correction of rules.txt)


def fold(w):
    """Lowercase without accents (the form in which the keyboard compares letters); in English also without the apostrophe."""
    f = "".join(c for c in unicodedata.normalize("NFD", w.lower()) if not unicodedata.combining(c))
    return f.replace("'", "") if STRIP_APOS else f


# ---------------------------------------------------------------------------------------------- token cache
def tokenize_file(src, dst):
    """One line per input line: words as they are, BREAK/END/UNK for the rest (the exact rules of make_wordlist_lang.py)."""
    n = 0
    with open(src, encoding="utf-8") as f, open(dst, "w", encoding="utf-8") as o:
        for line in f:
            out = []
            for t in tokens(line.strip()):
                if not t[0].isalpha():
                    m = END if t in SENTENCE_END else BREAK
                    if out and out[-1] == m:
                        continue
                    out.append(m)
                elif is_word(t):
                    out.append(t)
                else:
                    out.append(UNK)
            o.write(" ".join(out) + "\n")
            n += 1
    return n


def build_cache(work):
    jobs = []
    for s in SOURCES:
        src, dst = os.path.join(work, s + "_train.txt"), os.path.join(work, "tok_" + s + ".txt")
        if not os.path.exists(dst) or os.path.getmtime(dst) < os.path.getmtime(src):
            jobs.append((src, dst))
    if jobs:
        with multiprocessing.Pool(2) as pool:
            pool.starmap(tokenize_file, jobs)


def lines_of(work, s):
    with open(os.path.join(work, "tok_" + s + ".txt"), encoding="utf-8") as f:
        for line in f:
            yield line.rstrip("\n").split(" ")


# ---------------------------------------------------------------------------------------------- helpers
def read_base(path):
    base, offensive, skipped = {}, set(), 0
    with gzip.open(path, "rt", encoding="utf-8") as fh:
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
    return base, offensive, skipped


def ols(xs, ys):
    mx, my = sum(xs) / len(xs), sum(ys) / len(ys)
    sxx = sum((x - mx) ** 2 for x in xs)
    slope = sum((x - mx) * (y - my) for x, y in zip(xs, ys)) / sxx
    icpt = my - slope * mx
    ss_tot = sum((y - my) ** 2 for y in ys)
    ss_res = sum((y - (slope * x + icpt)) ** 2 for x, y in zip(xs, ys))
    return slope, icpt, 1 - ss_res / ss_tot


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--lang", required=True, choices=sorted(LANGS))
    ap.add_argument("--work", required=True)
    ap.add_argument("--base", required=True)
    ap.add_argument("--offensive-from", default=None,
                    help="AOSP list that carries the possibly-offensive marks, when --base is a cleaned list that lost them (pt-BR)")
    ap.add_argument("--spell", action="append", default=[], help="Hunspell aff:dic (repeatable; a word passes if any accepts it)")
    ap.add_argument("--out", required=True)
    ap.add_argument("--mix", default="subs=0.60,chat=0.20,news=0.15")
    ap.add_argument("--min-count", type=int, default=3, help="real occurrences for a new lowercase word accepted by the speller")
    ap.add_argument("--min-name-count", type=int, default=20)
    ap.add_argument("--min-unspelled", type=int, default=150, help="real occurrences for a word the speller refuses (slang, loanwords)")
    ap.add_argument("--min-sources", type=int, default=2, help="sources in which such a word must appear (3+ times each)")
    ap.add_argument("--foreign-list", action="append", default=[],
                    help="AOSP word list of a language that does NOT share word forms with this one (English, German; repeatable): "
                         "a new word that is in one of them needs --min-foreign real occurrences or --min-foreign-news in the news")
    ap.add_argument("--min-foreign", type=int, default=150, help="real occurrences for a new word that is also a word of another language")
    ap.add_argument("--min-foreign-news", type=int, default=15,
                    help="occurrences in the news sample that also clear such a word (quoted English rarely reaches that in news, a Spanish word does)")
    ap.add_argument("--min-bigram", type=int, default=2, help="real occurrences of a pair")
    ap.add_argument("--min-p", type=float, default=0.0, help="floor of P(next | previous) for a pair outside the top 3 of its word")
    ap.add_argument("--max-bigrams", type=int, default=1000000)
    ap.add_argument("--per-word", type=int, default=60)
    ap.add_argument("--top-each", type=int, default=3)
    ap.add_argument("--min-ctx", type=int, default=8, help="real occurrences of a two-word context for the trigrams")
    ap.add_argument("--min-tri", type=int, default=3, help="real occurrences of a trigram")
    ap.add_argument("--no-trigrams", action="store_true")
    a = ap.parse_args()
    global STRIP_APOS
    STRIP_APOS = a.lang == "en"
    os.makedirs(a.out, exist_ok=True)
    rep = []
    cfg = LANGS[a.lang]
    share = {k: float(v) for k, v in (x.split("=") for x in a.mix.split(","))}
    if not a.spell:
        ap.error("give --spell")
    spellers = [Speller(*x.split(":", 1)) for x in a.spell]

    def spell_ok(w):
        return any(s.ok(w) for s in spellers)

    build_cache(a.work)

    # ------------------------------------------------------------------------------------------ base
    base, offensive, skipped = read_base(a.base)
    if a.offensive_from:
        offensive |= read_base(a.offensive_from)[1]
    offensive |= set(cfg.get("extra_offensive", ())) & set(base)
    rep.append(f"base: {len(base)} words ({skipped} left out by the format), {len(offensive)} possibly offensive")

    # ------------------------------------------------------------------------------------------ pass 1: unigrams
    seen, lower, capmid, total = {}, {}, collections.Counter(), {}
    midc = {}                                # per source: occurrences NOT at the start of a sentence (see cap_mid_only)
    for s in SOURCES:
        sn, lw, tot, mc = collections.Counter(), collections.Counter(), 0, collections.Counter()
        for toks in lines_of(a.work, s):
            first = True
            for t in toks:
                if t == END:
                    first = True
                    continue
                if t == BREAK:
                    continue
                if t == UNK:
                    first = False
                    continue
                sn[t] += 1
                lw[t.lower()] += 1
                tot += 1
                if not first:
                    mc[t] += 1
                    if t[0].isupper() and s != "chat":
                        capmid[t] += 1
                first = False
        seen[s], lower[s], total[s], midc[s] = sn, lw, tot, mc
        rep.append(f"{s}: {tot} word tokens, {len(sn)} forms")
    T = total["subs"] / share["subs"]
    W = {s: share[s] * T / total[s] for s in SOURCES}
    rep.append("weights per occurrence: " + ", ".join(f"{s} {W[s]:.3f}" for s in SOURCES))

    def raw_lower(w):
        return sum(lower[s][w] for s in SOURCES)

    def raw_exact(w):
        return sum(seen[s][w] for s in SOURCES)

    def eff_lower(w):
        return sum(W[s] * lower[s][w] for s in SOURCES)

    def eff_exact(w):
        return sum(W[s] * seen[s][w] for s in SOURCES)

    # the scale: f ~ a*log10(weighted count) + b over base lowercase words with 20+ real occurrences
    xs, ys = [], []
    for w, f in base.items():
        if w[:1].islower() and raw_lower(w) >= 20:
            xs.append(math.log10(eff_lower(w)))
            ys.append(f)
    slope, icpt, r2 = ols(xs, ys)
    rep.append(f"scale: f = {slope:.2f}*log10(weighted count) + {icpt:.2f} (R2 {r2:.2f}, n={len(xs)})")

    def f_corpus(eff):
        return max(10, min(250, int(round(slope * math.log10(max(eff, 1e-9)) + icpt))))

    # ------------------------------------------------------------------------------------------ vocabulary
    final = dict(base)
    base_lower = {w.lower() for w in final}
    new_lower, new_unspelled, new_names = [], [], []
    cand_unspelled = []
    all_forms = set()
    for s in SOURCES:
        all_forms.update(seen[s])
    foreign = FOREIGN.get(a.lang, set())
    other_langs = set()                     # words of the other languages (songs, titles and quotes in the subtitles): the speller lets many of them through
    for path in a.foreign_list:
        other_langs.update(w.lower() for w in read_base(path)[0])
    folds = collections.defaultdict(set)    # accent-free form -> words of the list that have it: "aqui" must not become a word next to "aquí"
    for w in final:
        folds[fold(w)].add(w)
    rejected = collections.Counter()
    for w in all_forms:
        if len(w) > MAX_WORD or w in final or not w.islower() or len(w) < 3 or w in base_lower:
            continue
        rc = raw_exact(w)
        if rc < a.min_count:
            continue
        if w in foreign:
            rejected["foreign function word"] += 1
            continue
        why = cfg["reject"](w) if "reject" in cfg else None
        if why:
            rejected[why] += 1
            continue
        if any(x != w for x in folds.get(fold(w), ())):
            rejected["accent-free form of a word of the list"] += 1
            continue
        if w in other_langs and rc < a.min_foreign and seen["news"][w] < a.min_foreign_news \
                and not (cfg.get("foreign_short_only") and (len(w) > cfg["foreign_short_only"] or "-" in w)):
            rejected["word of another language"] += 1
            continue
        if spell_ok(w):
            final[w] = None
            new_lower.append(w)
        elif rc >= a.min_unspelled and sum(1 for s in SOURCES if seen[s][w] >= 3) >= a.min_sources and w.isalpha() \
                and rc >= 0.6 * raw_lower(w):
            cand_unspelled.append(w)
    base_lower = {w.lower() for w in final}
    for w, c in capmid.items():
        if w in final or c < a.min_name_count or len(w) < 2 or (w.isupper() and len(w) > 1):
            continue
        if w.lower() in base_lower or not spell_ok(w):
            continue
        if w in cfg.get("name_exclude", ()):
            rejected["name that is an English word"] += 1
            continue
        why = cfg["reject"](w) if "reject" in cfg else None
        if why:
            rejected[why] += 1
            continue
        if (len(w) < 3 and w not in SHORT_OK.get(a.lang, ())) or \
                (w.lower() in other_langs and w not in cfg.get("name_always", ()) and c < a.min_foreign and seen["news"][w] < a.min_foreign_news):
            rejected["name that is too short or a word of another language"] += 1
            continue
        final[w] = None
        new_names.append(w)
    for w in cand_unspelled:
        final[w] = None
        new_unspelled.append(w)
    informal = [w for w in cfg["informal"] if w not in final]
    for w in informal:
        final[w] = cfg["informal"][w]
    rep.append(f"new words: {len(new_lower)} accepted by the speller, {len(new_unspelled)} frequent but unspelled, "
               f"{len(new_names)} names; chat list: {len(informal)}; refused: " + ", ".join(f"{v} {k}" for k, v in rejected.items()))

    # ------------------------------------------------------------------------------------------ frequencies of every word
    vre = cfg.get("vulgar_re")
    extra_vulgar = {w for w in final if vre and vre.match(w) and w not in cfg["vulgar"]}
    vulgar = set(cfg["vulgar"]) | extra_vulgar
    rep.append(f"words treated as vulgar by pattern (f = 5, never predicted): {len(extra_vulgar)}: " + " ".join(sorted(extra_vulgar)[:100]))
    changed = 0
    for w in list(final):
        if final[w] is not None and w in cfg["informal"] and w not in base:
            continue
        rc = raw_lower(w) if w[:1].islower() else sum(seen[s][w] for s in SOURCES)
        eff = eff_lower(w) if w[:1].islower() else eff_exact(w)
        if cfg.get("cap_mid_only") and w[:1].isupper() and w.lower() != w and w.lower() in final:
            # a capitalised word that has a lowercase twin ("Nice", "Good", "Hi", "Will"): the capital at the start of a sentence is the twin, so only
            # the occurrences inside a sentence count for it (otherwise "Nice" takes a slot of the strip next to "nice")
            rc = sum(midc[s][w] for s in SOURCES)
            eff = sum(W[s] * midc[s][w] for s in SOURCES)
        fc = f_corpus(eff) if rc > 0 else None
        fb = base.get(w)
        if fb is None:   # new word: a little under the base words of the same count (as in the earlier packs)
            final[w] = max(30, min(180, (fc if fc is not None else 30) - 10))
        elif fc is None:
            final[w] = fb
        else:
            lam = min(1.0, rc / FULL_EVIDENCE)
            blended = BASE_SHARE * fb + (1 - BASE_SHARE) * fc
            final[w] = int(round(lam * blended + (1 - lam) * fb))
            changed += final[w] != fb
        final[w] = max(1, min(255, final[w]))
    for w in vulgar & set(final):
        final[w] = 5
    offensive |= vulgar & set(final)
    rep.append(f"frequencies recomputed for {changed} of {len(base)} base words")

    vocab = sorted(final)
    vid = {w: i for i, w in enumerate(vocab)}
    V = len(vocab)

    # ------------------------------------------------------------------------------------------ pass 2: pairs
    canon_first, canon_mid = {}, {}

    def canon(t, first):
        cache = canon_first if first else canon_mid
        r = cache.get(t, 0)
        if r != 0:
            return r
        if first and t[0].isupper():
            lw = t.lower()
            r = lw if lw in final else (t if t in final else None)
        elif t in final:
            r = t
        elif t[0].isupper() and t.lower() in final:
            r = t.lower()
        else:
            r = None
        cache[t] = r
        return r

    pair = {s: collections.Counter() for s in SOURCES}
    left = {s: collections.Counter() for s in SOURCES}
    for s in SOURCES:
        pc, lc = pair[s], left[s]
        for toks in lines_of(a.work, s):
            prev = None
            first = True
            for t in toks:
                if t == END:
                    prev = None
                    first = True
                    continue
                if t == BREAK:
                    prev = None
                    continue
                if t == UNK:
                    if prev is not None:
                        lc[prev] += 1
                    prev = None
                    first = False
                    continue
                w = canon(t, first)
                first = False
                w = vid[w] if w is not None else None
                if prev is not None:
                    lc[prev] += 1
                    if w is not None:
                        pc[prev * V + w] += 1
                prev = w
        rep.append(f"{s}: {len(pc)} distinct pairs")
    keys = set()
    for s in SOURCES:
        keys.update(pair[s])
    by_w1 = collections.defaultdict(list)
    left_eff = collections.Counter()
    for s in SOURCES:
        for i, c in left[s].items():
            left_eff[i] += W[s] * c
    pair_raw = {}
    for k in keys:
        raw = 0
        eff = 0.0
        for s in SOURCES:
            c = pair[s].get(k, 0)
            if c:
                raw += c
                eff += W[s] * c
        pair_raw[k] = (raw, eff)
    del keys, pair
    n_ok = 0
    for k, (raw, eff) in pair_raw.items():
        w1, w2 = divmod(k, V)
        if raw >= a.min_bigram and vocab[w2] not in offensive and final[vocab[w2]] > 5:
            by_w1[w1].append((eff, w2, raw))
            n_ok += 1
    rep.append(f"pairs: {len(pair_raw)} distinct, {n_ok} with {a.min_bigram}+ real occurrences")
    ranked = []
    for w1, lst in by_w1.items():
        lst.sort(key=lambda x: (-x[0], x[1]))
        for r, (eff, w2, raw) in enumerate(lst[:a.per_word]):
            if r >= a.top_each and a.min_p and eff / left_eff[w1] < a.min_p:
                continue
            ranked.append((0 if r < a.top_each else 1, -eff, w1, w2, eff))
    ranked.sort()
    chosen = collections.defaultdict(list)
    for _tier, _negc, w1, w2, eff in ranked[:a.max_bigrams]:
        p = eff / left_eff[w1]
        f7 = max(1, min(127, int(round(127 * (1 + math.log10(p) / 3)))))
        chosen[w1].append((w2, f7, eff))
    boosted = []
    for x1, x2 in cfg.get("boost", []):
        if x1 not in final or x2 not in final:
            continue
        i1, i2 = vid[x1], vid[x2]
        lst = [x for x in chosen.get(i1, []) if x[0] != i2]
        top = max((x[1] for x in lst), default=100)
        lst.append((i2, min(127, top + 1), pair_raw.get(i1 * V + i2, (0, 0))[1]))
        chosen[i1] = lst
        boosted.append(f"{x1} {x2}")
    nsel = sum(len(v) for v in chosen.values())
    rep.append(f"bigrams chosen: {nsel} for {len(chosen)} words (cap {a.max_bigrams}, {a.per_word} per word, floor {a.min_p})")

    # ------------------------------------------------------------------------------------------ write the list
    order = sorted(final, key=lambda x: (-final[x], x))
    with gzip.open(os.path.join(a.out, "main.combined.gz"), "wt", encoding="utf-8") as o:
        o.write(cfg["header"] + "\n")
        for w in order:
            o.write(f" word={w},f={final[w]}\n")
            for w2, f7, eff in sorted(chosen.get(vid[w], []), key=lambda x: (-x[1], -x[2], vocab[x[0]])):
                o.write(f"  bigram={vocab[w2]},f={f7}\n")
    with open(os.path.join(a.out, "words.tsv"), "w", encoding="utf-8") as o:
        for w in order:
            o.write(f"{w}\t{final[w]}\n")
    rep.append(f"final list: {len(final)} words")

    # ------------------------------------------------------------------------------------------ pass 3: trigrams
    if not a.no_trigrams:
        ctx = {k for k, (raw, eff) in pair_raw.items() if raw >= a.min_ctx}
        rep.append(f"trigram contexts with {a.min_ctx}+ real occurrences: {len(ctx)}")
        tri = {s: collections.Counter() for s in SOURCES}
        for s in SOURCES:
            tc = tri[s]
            for toks in lines_of(a.work, s):
                seg = []
                first = True
                for t in toks:
                    if t == END or t == BREAK or t == UNK:
                        if len(seg) >= 3:
                            for i in range(len(seg) - 2):
                                k = seg[i] * V + seg[i + 1]
                                if k in ctx:
                                    tc[k * V + seg[i + 2]] += 1
                        seg = []
                        if t == END:
                            first = True
                        elif t == UNK:
                            first = False
                        continue
                    w = canon(t, first)
                    first = False
                    if w is None:
                        if len(seg) >= 3:
                            for i in range(len(seg) - 2):
                                k = seg[i] * V + seg[i + 1]
                                if k in ctx:
                                    tc[k * V + seg[i + 2]] += 1
                        seg = []
                    else:
                        seg.append(vid[w])
                if len(seg) >= 3:
                    for i in range(len(seg) - 2):
                        k = seg[i] * V + seg[i + 1]
                        if k in ctx:
                            tc[k * V + seg[i + 2]] += 1
        per_ctx = collections.defaultdict(dict)
        for s in SOURCES:
            for k3, c in tri[s].items():
                k, w3 = divmod(k3, V)
                d = per_ctx[k]
                raw, eff = d.get(w3, (0, 0.0))
                d[w3] = (raw + c, eff + W[s] * c)
        kept = {}
        for k, cnt in per_ctx.items():
            total_eff = sum(e for _r, e in cnt.values())
            cands = [(e, w3) for w3, (r, e) in cnt.items() if r >= a.min_tri and vocab[w3] not in offensive]
            if not cands:
                continue
            cands.sort(key=lambda x: (-x[0], vocab[x[1]]))
            top = cands[:3]
            w2 = k % V
            bigram_top = [x[0] for x in sorted(chosen.get(w2, []), key=lambda x: (-x[1], -x[2], vocab[x[0]]))[:3]]
            if [w for _, w in top] == bigram_top[:len(top)]:
                continue
            kept[k] = [(w, max(1, min(127, int(round(127 * (1 + math.log10(e / total_eff) / 3)))))) for e, w in top]
        tvocab = sorted({vocab[x] for k in kept for x in divmod(k, V)} | {vocab[w] for v in kept.values() for w, _ in v})
        tid = {w: i for i, w in enumerate(tvocab)}
        if len(tvocab) >= 1 << 24:
            raise ValueError("vocabulary too large for 24-bit ids")
        out = bytearray(b"MRT1")
        out += struct.pack(">I", len(tvocab))
        for w in tvocab:
            b = w.encode("utf-8")
            out.append(len(b))
            out += b
        ordered = sorted(kept, key=lambda k: (tid[vocab[k // V]], tid[vocab[k % V]]))
        out += struct.pack(">I", len(ordered))
        for k in ordered:
            out += tid[vocab[k // V]].to_bytes(3, "big") + tid[vocab[k % V]].to_bytes(3, "big")
            out.append(len(kept[k]))
            for w, f in kept[k]:
                out += tid[vocab[w]].to_bytes(3, "big")
                out.append(f)
        with open(os.path.join(a.out, "trigrams.bin"), "wb") as fh:
            fh.write(out)
        rep.append(f"trigrams: {len(ordered)} contexts written (different from the pair), {len(tvocab)} words, {len(out)} bytes")

    with open(os.path.join(a.out, "report.txt"), "w", encoding="utf-8") as r:
        r.write("\n".join(rep) + "\n\n")
        for title, lst, key in (("new lowercase (speller)", new_lower, raw_exact), ("new frequent unspelled", new_unspelled, raw_exact),
                                ("new names", new_names, lambda w: sum(seen[s][w] for s in SOURCES))):
            r.write(f"[{title}] ({len(lst)})\n" + " ".join(sorted(lst, key=lambda w: -key(w))[:1500]) + "\n\n")
        r.write("chat expressions in 1st place: " + ", ".join(boosted) + "\n")
    print("\n".join(rep))


if __name__ == "__main__":
    main()
