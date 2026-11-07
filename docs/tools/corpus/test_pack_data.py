#!/usr/bin/env python3
"""Tests make_pack_data.py (the data of a language pack) with tiny made-up corpora and a made-up speller (no Hunspell, no real text).

Run it from the project root:  python3 -I docs/tools/corpus/test_pack_data.py

What it checks: the fourth source `real` (chat_real_train.txt) only counts when it is in --mix, a pack built without it does not change
(not even when the file is there), the weight of each source, the admission rules applied to the new source (a word the speller refuses
needs the occurrences AND a second source, an accent-free form is not a new word, a swear word keeps f = 5), the pairs and trigrams that
come from the real messages, and the errors of a wrong --mix.
"""
import gzip
import importlib.util
import os
import random
import shutil
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


spec = importlib.util.spec_from_file_location("make_pack_data", os.path.join(HERE, "make_pack_data.py"))
mpd = importlib.util.module_from_spec(spec)
sys.modules["make_pack_data"] = mpd      # the token cache is built by a pool of processes, which must find the function by its module
spec.loader.exec_module(mpd)


class FakeSpeller:
    """The `dic` file is a list of words, one per line; a word is right when it is listed (no affixes)."""
    def __init__(self, aff, dic):
        with open(dic, encoding="utf-8") as f:
            self.words = set(f.read().split())

    def ok(self, w):
        return w in self.words


mpd.Speller = FakeSpeller
T = tempfile.mkdtemp(prefix="mr_pack_test_")

BASE = {"casa": 200, "pero": 190, "hola": 180, "agua": 160, "tiempo": 150, "mundo": 140, "también": 130, "gracias": 120, "vamos": 110,
        "cabrón": 60, "aquí": 170}
SPELLED = ["casa", "pero", "hola", "agua", "tiempo", "mundo", "también", "gracias", "vamos", "cabrón", "aquí", "wifi",
           "pizza", "zorro", "luna", "Zeca", "aqui", "ahora", "agua-luna", "casa-luna"]
rnd = random.Random(7)
WEIGHTS = [60, 30, 20, 12, 8, 6, 5, 4, 3, 2, 12]


def sentence(extra=(), n=4):
    ws = rnd.choices(list(BASE), WEIGHTS, k=n) + list(extra)
    rnd.shuffle(ws)
    return " ".join(ws) + "."


def write(path, lines):
    with open(path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")


def corpus(extra_lines):
    return [sentence() for _ in range(900)] + extra_lines


def make_work(name, with_real=True, real_extra=()):
    w = os.path.join(T, name)
    os.makedirs(w)
    subs = corpus([sentence(("pizza",)) for _ in range(5)] + [sentence(("pix",)) for _ in range(5)] + [sentence(("aqui",)) for _ in range(6)])
    chat = corpus([sentence(("luna",)) for _ in range(4)])
    news = corpus([sentence(("Zeca",)) for _ in range(3)])
    write(os.path.join(w, "subs_train.txt"), subs)
    write(os.path.join(w, "chat_train.txt"), chat)
    write(os.path.join(w, "news_train.txt"), news)
    if with_real:
        real = corpus(list(real_extra))
        write(os.path.join(w, "chat_real_train.txt"), real)
    return w


def base_file():
    p = os.path.join(T, "base.combined.gz")
    with gzip.open(p, "wt", encoding="utf-8") as o:
        o.write("dictionary=main:es,locale=es,description=test,date=1,version=1\n")
        for w, f in BASE.items():
            o.write(f" word={w},f={f}\n")
    return p


def spell_file():
    p = os.path.join(T, "es.dic")
    write(p, SPELLED)
    return p


BASE_FILE, DIC = base_file(), spell_file()


def run(work, out, mix, extra=()):
    """Runs main() as the command line would; returns (exit code, files of the output as bytes)."""
    argv = ["make_pack_data.py", "--lang", "es", "--work", work, "--base", BASE_FILE, "--spell", "x.aff:" + DIC, "--out", out,
            "--mix", mix, "--min-count", "3", "--min-name-count", "3", "--min-unspelled", "20", "--min-bigram", "2",
            "--min-ctx", "3", "--min-tri", "2"] + list(extra)
    old = sys.argv
    sys.argv = argv
    code = 0
    try:
        mpd.main()
    except SystemExit as e:
        code = e.code
    finally:
        sys.argv = old
    files = {}
    if os.path.isdir(out):
        for n in ("main.combined.gz", "words.tsv", "trigrams.bin", "report.txt"):
            p = os.path.join(out, n)
            if os.path.exists(p):
                files[n] = gzip.open(p, "rb").read() if n.endswith(".gz") else open(p, "rb").read()
    return code, files


def words_of(files):
    return {l.split("\t")[0]: int(l.split("\t")[1]) for l in files["words.tsv"].decode().splitlines()}


def quiet(fn, *a, **k):
    so, se = sys.stdout, sys.stderr
    sys.stdout = sys.stderr = open(os.devnull, "w")
    try:
        return fn(*a, **k)
    finally:
        sys.stdout, sys.stderr = so, se


# ---------------------------------------------------------------------------------------------------------- the real source is optional
real_extra = ([sentence(("pix",)) for _ in range(40)] + [sentence(("xablau",)) for _ in range(40)] + [sentence(("aqui",)) for _ in range(40)] +
              [sentence(("zorro",)) for _ in range(4)] + [sentence(("agua-luna",)) for _ in range(5)] + [sentence(("casa-luna",)) for _ in range(30)] + [sentence(("wifi",)) for _ in range(4)] + ["wifi casa ahora."] * 6 + ["gracias vamos ahora."] * 6 +
              [sentence(("Zeca",)) for _ in range(5)] + [sentence(("cabrón",)) for _ in range(3)] + [sentence(("fodeu",)) for _ in range(40)] +
              [])
W1 = make_work("with_real", True, real_extra)
W2 = make_work("without_real", False)
shutil.copy(os.path.join(W1, "subs_train.txt"), os.path.join(W2, "subs_train.txt"))
shutil.copy(os.path.join(W1, "chat_train.txt"), os.path.join(W2, "chat_train.txt"))
shutil.copy(os.path.join(W1, "news_train.txt"), os.path.join(W2, "news_train.txt"))
MIX3 = "subs=0.60,chat=0.10,news=0.25"
c1, f1 = quiet(run, W1, os.path.join(T, "o1"), MIX3)
c2, f2 = quiet(run, W2, os.path.join(T, "o2"), MIX3)
check("mix without real: the build works with and without chat_real_train.txt in the folder", c1 == 0 and c2 == 0 and len(f1) == 4 and len(f2) == 4)
check("mix without real: the output does not change because the file is there (all four files equal)", f1 == f2,
      [k for k in f1 if f1.get(k) != f2.get(k)])
check("mix without real: the token cache of the real messages is not made", not os.path.exists(os.path.join(W2, "tok_real.txt")))
check("mix without real: no weight of `real` in the report", b"real " not in f1["report.txt"].split(b"weights per occurrence:")[1].split(b"\n")[0])

# ---------------------------------------------------------------------------------------------------------- with real
MIX4 = "subs=0.30,chat=0.05,news=0.15,real=0.45"
c3, f3 = quiet(run, W1, os.path.join(T, "o3"), MIX4)
check("mix with real: the build works and the token cache is made", c3 == 0 and os.path.exists(os.path.join(W1, "tok_real.txt")))
rep3 = f3["report.txt"].decode()
check("mix with real: the report counts the fourth source and its weight", "real: " in rep3 and "real " in rep3.split("weights per occurrence:")[1].split("\n")[0])
# the weight of every source is share * T / tokens, with T = subs tokens / subs share: so subs weighs 0.30 of T in the end
tok = {}
for line in rep3.splitlines():
    for s in ("subs", "chat", "news", "real"):
        if line.startswith(s + ": ") and "word tokens" in line:
            tok[s] = int(line.split()[1])
T_ = tok["subs"] / 0.30
want = {"subs": 0.30, "chat": 0.05, "news": 0.15, "real": 0.45}
wline = rep3.split("weights per occurrence:")[1].split("\n")[0]
got = {p.split()[0]: float(p.split()[1]) for p in wline.split(",")}
check("mix with real: weight = share * T / tokens for each of the four sources",
      all(abs(got[s] - want[s] * T_ / tok[s]) < 0.0015 for s in want), (got, tok))
wd3 = words_of(f3)
wd1 = words_of(f1)
check("a word of the speller that only the real messages bring (3+ times) is in with real and out without it", "zorro" in wd3 and "zorro" not in wd1)
check("a word the speller refuses, frequent in real AND seen in the subtitles (second source), comes in", "pix" in wd3 and "pix" not in wd1)
check("a word the speller refuses, frequent in real only, stays out (needs a second source)", "xablau" not in wd3)
check("an accent-free form of a word of the list is not a new word, even when the speller accepts it (aqui next to aquí)",
      "aqui" not in wd3 and "aqui" not in wd1 and "aquí" in wd3)
check("a name seen with a capital letter in the middle of the real messages counts for the names (Zeca)", "Zeca" in wd3)
check("a swear word of the list keeps f = 5", wd3.get("cabrón") == 5)
check("a swear word that the pattern knows (fodeu) is not a prediction: f = 5 when it comes in", wd3.get("fodeu", 5) == 5)
check("the frequency of a base word moves with the weight of the corpora (not the same as without real)", wd3["casa"] != wd1["casa"] or wd3["tiempo"] != wd1["tiempo"])

comb = f3["main.combined.gz"].decode()


def bigrams_of(text, w):
    out, cur = [], None
    for line in text.splitlines():
        if line.startswith(" word="):
            cur = line.split(",")[0][6:]
        elif line.startswith("  bigram=") and cur == w:
            out.append(line.split(",")[0][9:])
    return out


def trigram_vocab(blob):
    n = int.from_bytes(blob[4:8], "big")
    pos, out = 8, set()
    for _ in range(n):
        ln = blob[pos]
        out.add(blob[pos + 1:pos + 1 + ln].decode("utf-8"))
        pos += 1 + ln
    return out


check("a word that only the real messages bring (ahora) comes in with real and not without it", "ahora" in wd3 and "ahora" not in wd1)
check("a pair that only the real messages have (vamos ahora) is a bigram with real", "ahora" in bigrams_of(f3["main.combined.gz"].decode(), "vamos"))
check("a trigram that only the real messages have (wifi casa ahora) is in trigrams.bin with real and not without it",
      "ahora" in trigram_vocab(f3["trigrams.bin"]) and "ahora" not in trigram_vocab(f1["trigrams.bin"]))
check("trigrams.bin is written with the magic number", f3["trigrams.bin"][:4] == b"MRT1")

# the same build twice is the same bytes
c4, f4 = quiet(run, W1, os.path.join(T, "o4"), MIX4)
check("the build is deterministic (same inputs, same four files)", c4 == 0 and f3 == f4)

# compounds with a hyphen need more evidence when --min-hyphen says so
ch, fh = quiet(run, W1, os.path.join(T, "oh"), MIX4, ["--min-hyphen", "20"])
wdh = words_of(fh)
check("hyphen: a compound seen 5 times comes in with the normal threshold and stays out with --min-hyphen 20",
      "agua-luna" in wd3 and "agua-luna" not in wdh, ("agua-luna" in wd3, "agua-luna" in wdh))
check("hyphen: a compound seen 30 times stays in with --min-hyphen 20; the rest of the words do not change", "casa-luna" in wdh and wdh.get("zorro") == wd3.get("zorro"))

# the size budget of trigrams.bin: the contexts with the least gain per byte go first, the file fits, a big budget changes nothing
full = len(f3["trigrams.bin"])
cb, fb = quiet(run, W1, os.path.join(T, "ob"), MIX4, ["--max-trigram-bytes", str(full // 2)])
check("trigram budget: the file fits the budget and is not empty", cb == 0 and 100 < len(fb["trigrams.bin"]) <= full // 2, (len(fb["trigrams.bin"]), full // 2))
check("trigram budget: the report says how many contexts were cut", b"trigram budget" in fb["report.txt"] and b"by gain per byte" in fb["report.txt"])
check("trigram budget: the words and the pairs do not change", fb["words.tsv"] == f3["words.tsv"] and fb["main.combined.gz"] == f3["main.combined.gz"])
cbig, fbig = quiet(run, W1, os.path.join(T, "obig"), MIX4, ["--max-trigram-bytes", str(full * 2)])
check("trigram budget: a budget above the size changes nothing", cbig == 0 and fbig["trigrams.bin"] == f3["trigrams.bin"])
n_full = int.from_bytes(f3["trigrams.bin"][4:8], "big")
check("trigram budget: the cut keeps fewer words in the table than the full file", int.from_bytes(fb["trigrams.bin"][4:8], "big") <= n_full)

# a mix with real, run again after the file changed, rebuilds the cache
with open(os.path.join(W1, "chat_real_train.txt"), "a", encoding="utf-8") as f:
    f.write("\n".join(sentence(("zorro",)) for _ in range(30)) + "\n")
os.utime(os.path.join(W1, "chat_real_train.txt"), (os.path.getmtime(os.path.join(W1, "tok_real.txt")) + 5,) * 2)
c5, f5 = quiet(run, W1, os.path.join(T, "o5"), MIX4)
check("the token cache of the real messages follows the file (newer file, new counts)", c5 == 0 and f5["report.txt"] != f3["report.txt"])

# ---------------------------------------------------------------------------------------------------------- wrong --mix
c, _ = quiet(run, W1, os.path.join(T, "e1"), "subs=0.6,chat=0.1,real=0.3")
check("--mix without news: error", c == 2)
c, _ = quiet(run, W1, os.path.join(T, "e2"), "subs=0.5,chat=0.1,news=0.1,twitter=0.3")
check("--mix with an unknown source: error", c == 2)
c, _ = quiet(run, W1, os.path.join(T, "e3"), "subs=0,chat=0.1,news=0.1,real=0.3")
check("--mix with subs = 0: error", c == 2)
c, _ = quiet(run, W2, os.path.join(T, "e4"), MIX4)
check("--mix with real but no chat_real_train.txt in the folder: error", c == 2)
c, _ = quiet(run, W1, os.path.join(T, "e5"), "subs=abc,chat=0.1,news=0.1")
check("--mix that is not a number: error", c == 2)

# the patterns of swear words (f = 5, never predicted) of each language: the inflections that the real messages brought, and no ordinary word
V = mpd.LANGS
for lang, yes, no in (
        ("pt-BR", "fuder fudido fudendo escrotas cacetada mamador punhetinha tesudo esquerdopata fodeu merdinha", "fundo fundação mamadeira casa escritório cacete"),
        ("es", "chinguen chingones cagaban cagada pelotudear pendejear joderlos mamador verguear jodido", "vergüenza casa cargar pendiente cagüeyo"),
        ("en", "shittier fuckin bullshitting", "shifty shiver ship")):
    r = V[lang]["vulgar_re"]
    check("vulgar pattern %s: swear words match" % lang, all(r.match(w) for w in yes.split()), [w for w in yes.split() if not r.match(w)])
    check("vulgar pattern %s: ordinary words do not" % lang, not any(r.match(w) for w in no.split()), [w for w in no.split() if r.match(w)])
check("English: a known misspelling and foreign names are listed for refusal",
      "alot" in V["en"]["reject_words"] and {"Que", "Micheal"} <= V["en"]["name_exclude"])

# the slang added from the real messages: with a fixed frequency, and never a word that rules.txt corrects (in the dictionary it would stop the correction)
import unicodedata
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", ".."))


def folded(w):
    return "".join(c for c in unicodedata.normalize("NFD", w.lower()) if not unicodedata.combining(c))


for lang, dirname in (("pt-BR", "pt-BR"), ("es", "es"), ("en", "en-US")):
    extra = mpd.EXTRA_INFORMAL[lang]
    keys = set()
    in_corr = False
    for line in open(os.path.join(ROOT, "dicts", dirname, "rules.txt"), encoding="utf-8"):
        line = line.rstrip("\n")
        if line.startswith("["):
            in_corr = line.strip() == "[corrections]"
        elif in_corr and line and not line.startswith("#") and "\t" in line:
            keys.add(folded(line.split("\t")[0]))
    clash = [w for w in extra if folded(w) in keys]
    check("slang from the real messages (%s): none of the %d words has a correction in rules.txt" % (lang, len(extra)), not clash, clash)
    check("slang from the real messages (%s): the table of the language has them with their frequency" % lang,
          all(mpd.LANGS[lang]["informal"].get(w) == f for w, f in extra.items()))

shutil.rmtree(T, ignore_errors=True)
print("\n%d ok, %d fail" % (ok, fails))
sys.exit(1 if fails else 0)
