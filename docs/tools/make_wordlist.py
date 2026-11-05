#!/usr/bin/env python3
"""Builds the pt-BR list of Mr Keyboard (words + bigrams) in the AOSP "combined" format.

Usage:
  python3 -I make_wordlist.py --base pt_BR_wordlist.combined.gz --corpus train.txt \
      --vero-aff pt_BR.aff --vero-dic pt_BR.dic --en-aff en_US.aff --en-dic en_US.dic \
      --out main_pt.combined.gz [--words-tsv words.tsv] [--report report.txt]

Inputs
  --base     dictionaries/pt_BR_wordlist.combined.gz of the AOSP LatinIME (Apache-2.0, with the
             Lexiteria notice), version 54.
  --corpus   pt-BR sentences, one per line (Leipzig por_news_2024_300K, CC BY 4.0, Brazilian
             sources only; see split_br.py).
  VERO (pt_BR) and en_US from Hunspell only serve as a filter (they decide whether a word comes
  in, goes out, or which spelling stays); no content from them is copied into the list.

Rules (details and numbers in docs/dictionary-build.md)
  base     - minus the entries that only exist as a shortcut (not_a_word / shortcut);
           - spelling from before the 1990 Orthographic Agreement replaced by the current one when
             VERO rejects the old one and accepts the new one (freqüência -> frequência, idéia ->
             ideia, jóia -> joia, vôo -> voo, vêem -> veem) and the differential accents (pára,
             pêlo, pólo);
           - lowercase words that VERO rejects and that appear fewer than 5 times in the corpus are
             dropped when they are a Lusitanian variant (projecto, contactos), a known error
             (enquando), differ from the correct form only in the accent (simultâneamente) or also
             exist with an initial capital;
           - lowercase words of up to 3 letters that VERO rejects (et, di, du, les, on), the ones
             that appear 10+ times in the corpus with foreign neighbors more than 60% of the time
             and the English (en_US) words that do not appear at least 3 times in the corpus in
             the middle of Portuguese (first, upon, still) are dropped, as are grammatical words
             of other languages that came from names and titles (FOREIGN_WORDS: della, vous,
             mein); the real loanwords come back through the corpus rule;
           - acronyms (2+ capitals, up to 5 letters) that do not appear in the corpus are dropped,
             except the technical ones (TECH_ACRONYMS);
           - words marked as possibly offensive (AOSP list) are never a bigram target (they do not
             show up as a prediction); the vulgar ones (VULGAR) stay with f = 5, only show up when
             typed in full, as in the AOSP with "block offensive words".
  corpus   - lowercase words accepted by VERO with count >= --min-count (includes hyphenated
             compounds and enclitics, like segunda-feira and trata-se);
           - loanwords/neologisms that VERO does not know, with count >= 10 and Portuguese
             neighbors in >= 60% of the occurrences (streaming, podcast, criptomoedas);
           - proper names with count >= --min-name-count outside the start of a sentence, without
             common English words (City, Club), without Roman numerals and without the ones that
             are also a common word (Rio/rio: they would take two of the three slots of the strip);
           - f of the new words comes from the fit f ~ a*log10(count) + b made on the base words
             that appear in the corpus, minus 10 (near the 1st quartile, so they do not get ahead
             of the base words just for being frequent in news).
  bigrams  - counted inside stretches without punctuation; the 2nd corpus (--corpus2, chat) counts
             --weight2 times; count >= --min-bigram (2); up to --per-word per word (the lib reads
             at most 60); selection: the first --top-each of each word and the rest by count, up to
             --max-bigrams; 7-bit f = 127*(1 + log10(P(w2|w1))/3).
  slang    - short list written for the keyboard (chat abbreviations, laughter, common slang), with
             moderate f; only the ones that do not exist yet come in.
"""
import argparse
import collections
import ctypes
import gzip
import math
import re
import unicodedata

LETTER = r"[^\W\d_]"
TOKEN_RE = re.compile(rf"{LETTER}+(?:['-]{LETTER}+)*|\S")
URL_RE = re.compile(
    r"(?:https?://|www\.)\S+|\S+@\S+\.\S+|[@#]\w+"
    r"|\b[\w-]+(?:\.[\w-]+)*\.(?:com|net|org|gov|edu|br|io|tv|me|app|info|jus|leg)\b\S*", re.I)
SENTENCE_END = set('.!?:;"“”«»()[]{}—–…')
APOSTROPHES = str.maketrans({"’": "'", "‘": "'", "ʼ": "'"})
ROMAN_RE = re.compile(r"^[IVXLCDM]+$")
MAX_WORD = 40

PT_PT_SWAPS = (("ct", "t"), ("cç", "ç"), ("pç", "ç"), ("pt", "t"), ("ó", "ô"), ("é", "ê"))

# Errors and variants in the base reviewed by hand (all rejected by VERO and rare in the corpus).
KNOWN_BAD = set("""
enquando entretando encontar entitulado homosexuais homosexualismo entretia sombrancelhas
motoserra motoserras eregido eregir eregidos manisfesta manisfestar manisfestado manisfestou
manisfesto manisfestantes aseguir reinvindicações bijouterias baseamo propomo tentendo
temporiamente sustenção partipação mercedez trinidade cafetaria cafetarias portefólio
stressantes açoreanos açoreano pirenéus casadoiras comummente catéter catéteres quartelado
heptahidratado hexahidratada americas náo asim brig continou contigente dividos inclue
espectativas previnir supresa eregida cincos oitos quatros catalizador catalizadores catalizada
catalizadas cataliza catalizar kryptonita imãs camião camiões
""".split())

# Vulgar words that the base does not mark as offensive.
EXTRA_OFFENSIVE = {"caralho", "corno", "cornos", "bosta", "bostas"}

# Swear words and insults: f = 5 (they only show up when typed in full). The other words marked by the
# AOSP (crianças, negro, peito, sexo...) keep their frequency and only leave the prediction.
VULGAR = set("""
pica cu merda porra foda foder puta puteiro punheta boquete suruba viado bicha vagabunda vadia
cagão gozada chupada esguichando rabão tetas ninfeta novinhas pedo caralho corno cornos bosta
bostas pederasta sodomita
""".split())

# Address leftovers, unit acronyms and stray English words that pass the context filter.
LOAN_EXCLUDE = set("""
ibahia noticiadamanha kgfm bpd nits houthis dia-a-dia point points position guidance payroll
banking hard front dark stand card
""".split())

# Technical acronyms that stay even without appearing in the news corpus.
TECH_ACRONYMS = set("""
MP3 MP4 USB PDF DNS URL XML HTML CSS SQL CPU GPU RAM ROM LED LCD HD HDMI GPS SMS MMS PIN WiFi
IP VPN API APK DVD CD PC TV FM AM AIDS HIV DNA RNA PH QI RG CPF CNPJ CEP ONG
""".split())

# English words that VERO accepts with an initial capital.
NAME_EXCLUDE = {"Big", "Wall", "Man", "Max"}
# Brands that the English filter would drop (google, amazon and apple are en_US words).
NAME_ALWAYS = {"Google", "Amazon", "Apple", "Microsoft", "Samsung", "Xiaomi", "Motorola", "Shopee"}

EN_STOP = set("""
the and of to in for on with by at from is are was be it this that you we my your our all new
one two more not no yes or but if so up out off do go get got me us he she his her they them
""".split())

# Chat abbreviations, laughter and common slang that the base lacks. The expansion of abbreviations
# (vc -> você) lives in MrFix; here they just stop being treated as errors.
INFORMAL = [
    ("vc", 60), ("vcs", 45), ("tbm", 55), ("tb", 50), ("pq", 55), ("hj", 50), ("td", 45),
    ("tds", 35), ("mto", 45), ("mt", 45), ("msm", 45), ("oq", 40), ("obg", 40), ("vlw", 40),
    ("blz", 40), ("cmg", 35), ("ctg", 30), ("nd", 35), ("ngm", 30), ("agr", 35), ("dps", 40),
    ("bjs", 35), ("bj", 30), ("sdds", 30), ("vdd", 35), ("msg", 40), ("qnd", 35), ("qdo", 30),
    ("tmj", 35), ("mds", 35), ("sqn", 25), ("fds", 30), ("pfv", 30), ("aki", 25), ("axo", 25),
    ("kd", 25),
    ("kkk", 60), ("kkkk", 55), ("kkkkk", 50), ("rs", 55), ("rsrs", 50), ("rsrsrs", 40),
    ("haha", 60), ("hahaha", 55), ("hahahaha", 40), ("hehe", 50), ("hehehe", 40),
    ("aff", 50), ("afe", 40), ("poxa", 80), ("putz", 70), ("caraca", 65), ("vixe", 60),
    ("uai", 60), ("bah", 55), ("oxe", 50), ("simbora", 45), ("vambora", 45), ("tamo", 60),
    ("vamo", 60), ("daora", 55), ("véi", 55), ("véio", 50), ("véia", 45), ("parça", 50),
    ("parças", 40), ("trampo", 55), ("trampar", 45), ("trampando", 40), ("bagulhos", 40),
    ("tretas", 45), ("zoou", 50), ("zuar", 40), ("zueira", 55), ("zuera", 40), ("zuado", 40),
    ("cringe", 50), ("crush", 60), ("stalkear", 40), ("stalkeando", 35), ("stalker", 45),
    ("printar", 50), ("printou", 45), ("printei", 45), ("print", 70), ("prints", 60),
    ("shippar", 35), ("flopar", 40), ("flopou", 45), ("flopada", 35), ("flop", 40),
    ("mitar", 40), ("mitou", 45), ("biscoitar", 35), ("biscoiteiro", 35), ("biscoiteira", 35),
    ("sextou", 55), ("hater", 50), ("haters", 50), ("sussa", 40), ("migué", 45),
    ("perrengue", 60), ("perrengues", 50), ("mozão", 55), ("boy", 65), ("boys", 55),
    ("contatinho", 40), ("contatinhos", 40), ("tchauzinho", 40), ("fofura", 55), ("lindeza", 45),
    ("surtei", 50), ("surtando", 50), ("surtar", 50), ("surtou", 50), ("pirar", 50),
    ("pirando", 45), ("zap", 55), ("zapzap", 40), ("tuíte", 45), ("tuitar", 40), ("tuitou", 40),
    ("repostar", 40), ("postei", 55), ("story", 60), ("stories", 60), ("reels", 50),
    ("live", 70), ("inbox", 45), ("wi-fi", 70), ("wifi", 50), ("logar", 45), ("deslogar", 40),
    ("app", 85), ("apps", 70), ("cel", 40), ("zerei", 45), ("upou", 40), ("lag", 45),
    ("bugou", 50), ("bugado", 45), ("bugar", 40), ("lagando", 35), ("tavam", 45),
]


def strip_accents(w):
    return "".join(c for c in unicodedata.normalize("NFD", w) if not unicodedata.combining(c))


# Differential accents that the 1990 Agreement removed (VERO still accepts some, like pára).
REFORM_FIXED = {
    "pára": "para", "péla": "pela", "pélas": "pelas", "pélo": "pelo", "pélos": "pelos",
    "pêlo": "pelo", "pêlos": "pelos", "pêra": "pera", "pêras": "peras", "pólo": "polo",
    "pólos": "polos", "côa": "coa", "côas": "coas",
}


HYPHEN_COMPOUND = ("norte", "sul", "latino", "mato", "afro", "ibero", "anglo", "franco", "greco",
                   "luso", "nipo", "sino", "teuto")
HYPHEN_PREFIXES = ("anti", "arqui", "auto", "contra", "extra", "infra", "intra", "macro", "micro",
                   "mini", "multi", "neo", "proto", "pseudo", "semi", "sobre", "supra", "tri",
                   "ultra", "super", "hiper", "inter", "sub", "para") + HYPHEN_COMPOUND

# Grammatical and common words of other languages that got into the AOSP list through names and
# titles (della, vous, mein). They only go out if VERO also rejects them.
FOREIGN_WORDS = set("""
della delle dello degli dei alla alle allo nel nella nelle nello sul sulla col coi gli una uno
che chi per con senza molto tutto tutti questa questo quella quello sono essere bella bello
belle bellas buona buono amore cuore mondo vita notte grazie ciao ragazzi ragazza signore
des les aux avec pour dans une est vous nous elle elles ils sont sur sous chez très bien mais
avoir être fait faire deux trois mon ton ses leur leurs cette ceci cela quoi qui que laissez
rendez nouveau nouvelle siècle générale château écran début maison royale royal blanc blanche
noir noire rouge petit petite grand grande monde amour coeur soleil jardin pourri foie gras
ella ellos ellas otra otro otras otros calle ciudad señor señora corazón español española
españoles nuevo nueva nuevos nuevas bueno buena blanco blanca negro rojo pueblo amigo amiga
también tiene tienen muy pero porque cuando donde está están quiero puede siempre nunca nada
mein meine dein deine und der die das dem den von vom zum zur mit für über auch nicht ist sind
wie was wer ein eine einen oder aber sehr gut heute morgen nacht liebe herz welt stadt haus
quae quod nobis vobis apud honoris causa mundi orbis sui generis inter alia ibid idem circa
""".split())


def reform(w, ok):
    """Current spelling (1990 Agreement) of a word that VERO rejects, or None. Only the changes of the
    Agreement: diaeresis (freqüência), open diphthongs éi/ói in paroxytones (idéia, jóia, heróico,
    asteróide), ôo/êe (vôo, vêem). It only accepts the new form if VERO accepts it. Dropping any
    accent will not do: VERO does not know some correct words (coreógrafo, déficit) and the form
    without accent is sometimes another word (coreografo, verbo)."""
    v = w.replace("ü", "u")
    cands = [v] if v != w else []
    for a, b in (("éi", "ei"), ("ói", "oi"), ("ôo", "oo"), ("êe", "ee")):
        i = v.find(a)
        while i >= 0:
            cands.append(v[:i] + b + v[i + 2:])
            i = v.find(a, i + 1)
    for c in cands:
        if c != w and ok(c):
            return c
    # hyphen of the Agreement: prefix ending in the vowel the word starts with, or before h
    # (microorganismo -> micro-organismo, antiinflamatório -> anti-inflamatório, sobrehumana ->
    # sobre-humana), super/hiper/inter before r and h, sub before r, b and h (subregião ->
    # sub-região), and compound gentilic adjectives (matogrossense -> mato-grossense)
    if "-" not in v:
        for pre in HYPHEN_PREFIXES:
            if not v.startswith(pre) or len(v) < len(pre) + 3:
                continue
            nxt = strip_accents(v[len(pre)])
            last = pre[-1]
            need = (last in "aeiou" and (nxt == last or nxt == "h")) or \
                (pre in ("super", "hiper", "inter") and nxt in "rh") or \
                (pre == "sub" and nxt in "rbh") or pre in HYPHEN_COMPOUND or pre == "para"
            if need:
                c = v[:len(pre)] + "-" + v[len(pre):]
                if ok(c):
                    return c
    return None


class Speller:
    def __init__(self, aff, dic):
        self.lib = ctypes.CDLL("libhunspell-1.7.so.0")
        self.lib.Hunspell_create.restype = ctypes.c_void_p
        self.lib.Hunspell_create.argtypes = [ctypes.c_char_p, ctypes.c_char_p]
        self.lib.Hunspell_spell.argtypes = [ctypes.c_void_p, ctypes.c_char_p]
        self.h = self.lib.Hunspell_create(aff.encode(), dic.encode())
        self.cache = {}

    def ok(self, w):
        r = self.cache.get(w)
        if r is None:
            r = self.cache[w] = self.lib.Hunspell_spell(self.h, w.encode("utf-8")) != 0
        return r


def corpus_lines(a, weighted):
    """Lines of the main corpus and of the 2nd corpus. With weighted=True it returns (line, weight): the weight
    of the 2nd corpus (--weight2) only enters the bigram count; the new words and the frequencies
    use the real count, so repetition does not inflate rare words."""
    for line in open(a.corpus, encoding="utf-8"):
        yield (line, 1) if weighted else line
    if a.corpus2:
        for line in open(a.corpus2, encoding="utf-8"):
            yield (line, a.weight2) if weighted else line


def tokens(line):
    return TOKEN_RE.findall(URL_RE.sub(" | ", line.translate(APOSTROPHES)))


def is_word(t):
    return t[0].isalpha() and "º" not in t and "ª" not in t and all(ord(c) < 0xFF for c in t)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--base", required=True)
    ap.add_argument("--corpus", required=True)
    ap.add_argument("--corpus2", default=None, help="2nd corpus (chat, e.g. Tatoeba)")
    ap.add_argument("--weight2", type=int, default=1, help="weight of the 2nd corpus in the bigrams")
    ap.add_argument("--top-each", type=int, default=3, help="guaranteed continuations per word")
    ap.add_argument("--vero-aff", required=True)
    ap.add_argument("--vero-dic", required=True)
    ap.add_argument("--en-aff", required=True)
    ap.add_argument("--en-dic", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--words-tsv", default=None, help="also writes word<TAB>f")
    ap.add_argument("--min-count", type=int, default=3)
    ap.add_argument("--min-name-count", type=int, default=20)
    ap.add_argument("--min-bigram", type=int, default=2)
    ap.add_argument("--max-bigrams", type=int, default=400000)
    ap.add_argument("--per-word", type=int, default=60)
    ap.add_argument("--report", default=None)
    a = ap.parse_args()

    vero = Speller(a.vero_aff, a.vero_dic).ok
    english = Speller(a.en_aff, a.en_dic).ok
    rep = []
    samples = {}

    # ------------------------------------------------------------------ base
    base, offensive, shortcut_only = {}, set(), []
    cur = None
    with gzip.open(a.base, "rt", encoding="utf-8") as fh:
        for line in fh:
            if line.startswith(" word="):
                d = dict(kv.split("=", 1) for kv in line.strip().split(","))
                cur = d["word"]
                if d.get("not_a_word") == "true":
                    shortcut_only.append(cur)
                    cur = None
                    continue
                base[cur] = int(d["f"])
                if d.get("possibly_offensive") == "true":
                    offensive.add(cur)
            elif line.startswith("  shortcut=") and cur is not None and cur in base:
                # word that only exists to become a shortcut (atras -> atrás): not a word
                shortcut_only.append(cur)
                del base[cur]
                offensive.discard(cur)
                cur = None
    offensive |= EXTRA_OFFENSIVE & set(base)
    base_lower = {w.lower() for w in base}
    rep.append(f"base: {len(base)} words, {len(offensive)} marked as possibly offensive "
               f"({len(VULGAR & set(base))} vulgar with f = 5); minus {len(shortcut_only)} shortcut-only "
               f"({' '.join(shortcut_only)})")

    # ------------------------------------------------------------------ corpus, 1st pass
    lower_seen = collections.Counter()   # exact form with lowercase initial
    cap_mid = collections.Counter()      # capital initial outside the start of a sentence
    exact_seen = collections.Counter()   # exact form, in any position
    ctx_total = collections.Counter()    # occurrences of each form
    ctx_pt = collections.Counter()       #   ... with both neighbors in the base (or punctuation)
    dot_after = collections.Counter()    #   ... followed by a period (abbreviation?)
    n_tokens = 0
    for line in corpus_lines(a, weighted=False):
        toks = tokens(line.strip())
        first = True
        for i, t in enumerate(toks):
            if not t[0].isalpha():
                if t in SENTENCE_END:
                    first = True
                continue
            if not is_word(t):
                first = False
                continue
            n_tokens += 1
            exact_seen[t] += 1
            if t[0].islower():
                lower_seen[t] += 1
            elif not first:
                cap_mid[t] += 1
            ctx_total[t] += 1
            p = toks[i - 1] if i > 0 else "."
            n = toks[i + 1] if i + 1 < len(toks) else "."
            if (not p[0].isalpha() or p.lower() in base_lower) and \
                    (not n[0].isalpha() or n.lower() in base_lower):
                ctx_pt[t] += 1
            if n == ".":
                dot_after[t] += 1
            first = False
    rep.append(f"corpus: {n_tokens} words")

    # fit f ~ a*log10(c) + b on the lowercase words of the base with c >= 5
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
        return max(30, min(200, int(round(slope * math.log10(c) + icpt))))

    rep.append(f"fit of the new words: f = {slope:.2f}*log10(c) + {icpt + 10:.2f} - 10 "
               f"(n={len(xs)})")

    # ------------------------------------------------------------------ base cleanup
    final = {}
    removed = collections.defaultdict(list)
    for w, f in sorted(base.items(), key=lambda kv: -kv[1]):
        if w in REFORM_FIXED:
            nw = REFORM_FIXED[w]
            final[nw] = max(final.get(nw, 0), base.get(nw, 0), f)
            removed["spelling before the Agreement (replaced)"].append(f"{w}->{nw}")
            continue
        if w[:1].islower() and not vero(w):
            nw = reform(w, vero)
            if nw is not None:
                final[nw] = max(final.get(nw, 0), base.get(nw, 0), f)
                removed["spelling before the Agreement (replaced)"].append(f"{w}->{nw}")
                continue
            c = lower_seen[w]
            why = None
            if len(w) <= 3:
                why = "short lowercase that VERO rejects (foreign)"
            elif c >= 10 and ctx_pt[w] < 0.4 * ctx_total[w]:
                why = "foreign (in the corpus, surrounded by foreign words)"
            elif english(w) and not (c >= 3 and ctx_pt[w] >= 0.6 * ctx_total[w]):
                why = "English with no use in Portuguese in the corpus"
            elif w in FOREIGN_WORDS and not (c >= 10 and ctx_pt[w] >= 0.6 * ctx_total[w]):
                why = "common word of another language"
            elif c < 5:
                if w in KNOWN_BAD:
                    why = "error or variant reviewed by hand"
                elif w.capitalize() in base or w.upper() in base or \
                        cap_mid[w.capitalize()] >= a.min_name_count:
                    why = "exists with a capital"
                else:
                    for x, y in PT_PT_SWAPS:
                        if x in w and w.replace(x, y) in base and vero(w.replace(x, y)):
                            why = "Lusitanian variant"
                            break
                    if why is None:
                        st = strip_accents(w)
                        if st != w and st in base and base[st] >= f:
                            why = "extra accent"
            if why:
                removed[why].append(w)
                continue
        final[w] = max(final.get(w, 0), f)
    # accent in the wrong place (heróina x heroína): same form without accent, the other is accepted
    by_strip = collections.defaultdict(list)
    for w in final:
        by_strip[strip_accents(w)].append(w)
    for k, ws in by_strip.items():
        if len(ws) < 2:
            continue
        good = [w for w in ws if vero(w)]
        if not good:
            continue
        for w in ws:
            if w not in good and w[:1].islower() and lower_seen[w] < 5 and \
                    max(final[g] for g in good) >= final[w]:
                removed["accent in the wrong place"].append(w)
                del final[w]
    # acronyms that do not appear in the corpus (FHM, RBN, TgN, SBbc): they only get in the way of short words
    acr = [w for w in final if 2 <= len(w) <= 5 and sum(1 for ch in w if ch.isupper()) >= 2
           and exact_seen[w] == 0 and w not in TECH_ACRONYMS]
    for w in acr:
        del final[w]
    removed["acronym that does not appear in the corpus"] = acr
    rep.append(f"base, removed (acronym that does not appear in the corpus): {len(acr)}")
    for w in VULGAR:
        if w in final:
            final[w] = min(final[w], 5)
    offensive |= VULGAR
    for why, ws in removed.items():
        rep.append(f"base, removed ({why}): {len(ws)}")
        samples[f"removed: {why}"] = ws
    final_lower = {w.lower() for w in final}

    # ------------------------------------------------------------------ corpus words
    def abbreviation_like(w):
        return len(w) <= 4 and dot_after[w] * 2 > ctx_total[w]

    added = []
    for w, c in lower_seen.items():
        if c < a.min_count or len(w) < 3 or len(w) > MAX_WORD or w.lower() in final_lower:
            continue
        if abbreviation_like(w) or not vero(w):
            continue
        final[w] = f_new(c)
        final_lower.add(w.lower())
        added.append(w)
    rep.append(f"corpus, lowercase words accepted by VERO (c >= {a.min_count}): {len(added)}")
    samples["new from the corpus"] = sorted(added, key=lambda w: -lower_seen[w])

    loans = []
    for w, c in lower_seen.items():
        if c < 10 or len(w) < 3 or len(w) > MAX_WORD or w.lower() in final_lower:
            continue
        if not w.replace("-", "").isalpha() or w in EN_STOP or w.lower() in LOAN_EXCLUDE:
            continue
        if abbreviation_like(w):
            continue
        if ctx_pt[w] < 0.6 * ctx_total[w]:
            continue
        caps = cap_mid[w.capitalize()] + cap_mid[w.upper()]
        if caps > 2 * c:
            continue
        final[w] = f_new(c)
        final_lower.add(w.lower())
        loans.append(w)
    rep.append(f"corpus, loanwords and neologisms outside VERO (c >= 10): {len(loans)}")
    samples["loanwords and neologisms"] = sorted(loans, key=lambda w: -lower_seen[w])

    names = []
    for w, c in cap_mid.items():
        if c < a.min_name_count or len(w) < 3 or len(w) > MAX_WORD or w in final:
            continue
        if ROMAN_RE.match(w) or abbreviation_like(w):
            continue
        lw = w.lower()
        # a name that is also a common word (Rio/rio, Lula/lula) stays out: with 3 slots in the
        # strip, "rio" and "Rio" would take two
        if lw in final_lower:
            continue
        if english(lw) and not vero(w) and w not in NAME_ALWAYS:
            continue
        if w.isupper() and len(w) > 5 or w in NAME_EXCLUDE:
            continue
        names.append(w)
    # same word with different case (WhatsApp/Whatsapp, Samu/SAMU): the most frequent one stays
    best = {}
    for w in names:
        k = w.lower()
        if k not in best or cap_mid[w] > cap_mid[best[k]]:
            best[k] = w
    names = [w for w in names if best[w.lower()] == w]
    for w in names:
        final[w] = f_new(cap_mid[w])
    final_lower |= {w.lower() for w in names}
    rep.append(f"corpus, proper names (c >= {a.min_name_count} outside the start of a sentence): "
               f"{len(names)}")
    samples["names"] = sorted(names, key=lambda w: -cap_mid[w])

    informal = []
    for w, f in INFORMAL:
        if w in final:
            continue
        final[w] = f
        informal.append(w)
    rep.append(f"slang and abbreviations added: {len(informal)}")
    samples["slang and abbreviations"] = informal

    # ------------------------------------------------------------------ bigrams, 2nd pass
    lower_map = {}
    for w in final:
        lw = w.lower()
        if lw in final:
            lower_map[lw] = lw
        elif lw not in lower_map:
            lower_map[lw] = w

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
    # selection: the first --top-each continuations of each word (prediction after the space) and,
    # in the space left over, the ones with the highest count (frequent words are the most typed)
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
    nsel = sum(len(v) for v in chosen.values())
    rep.append(f"bigrams: {len(pair)} pairs; {sum(len(v) for v in by_w1.values())} with c >= "
               f"{a.min_bigram}; chose {nsel} for {len(chosen)} words "
               f"(up to {a.top_each} guaranteed per word, the rest by count)")

    # ------------------------------------------------------------------ output
    order = sorted(final, key=lambda x: (-final[x], x))
    with gzip.open(a.out, "wt", encoding="utf-8") as o:
        o.write("dictionary=main:pt_br,locale=pt_BR,description=Português (Brasil),"
                "date=1793318400,version=60\n")
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
            for k, ws in samples.items():
                r.write(f"[{k}] ({len(ws)})\n" + " ".join(ws[:600]) + "\n\n")


if __name__ == "__main__":
    main()
