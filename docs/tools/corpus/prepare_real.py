#!/usr/bin/env python3
"""Cleans, filters and splits the REAL messages sampled by sample_real.py (stage 2 of the plan after 1.87.0, now deleted; the Git history keeps it) and writes the report.

Usage:
  python3 -I prepare_real.py --config real_sources.json --lang pt-BR --raw work/pt-BR/raw --out work/pt-BR/real [--root <project root>]
                             [--words-dir DIR] [--dev-slice 20]

Input  (--raw): <source id>.jsonl of sample_real.py (t = text, c = community, u = hash of the user) and sample_log.json.
Output (--out), one message per line, UTF-8, no user name, no link, no e-mail, no phone:
  chat_real_train.txt          messages of the sources with "role": "train" (what a pack would count)
  chat_real_dev.txt            1 in --dev-slice (hash of the message) of the train sources, kept OUT of train: same community, so it
                               measures the gain in "home" conditions; the test below measures it on communities the training never saw
  chat_real_test.txt           messages of ALL the sources with "role": "test" (another community, another period or another medium)
  chat_real_test_<source>.txt  the same, one file per test source (a gain that shows in only one of them is suspicious)
  real_report.json / real_report.md   NUMBERS ONLY (plus the 50 most frequent new words, each used by 5+ different users)
A "message" here is one line: a comment is split at line breaks and at . ! ? so each line is a sentence or a short comment.

What is removed (each reason is counted in the report):
  retweets; quoted text (> ...); code; links, www., [text](url), @mentions, /u/ and r/ names, #hashtags, emoji and symbols (taken out of the text);
  e-mails and phone numbers (the whole sentence goes); laughs (kkkk, haha, jajaja, rsrs, lol, xd...) are taken out of the sentence; letters repeated 3+ times
  ("noooossa") go back to the word of the dictionary when the single or double letter is one (otherwise the sentence is dropped); numbers and symbols
  (letters under 60% of the characters), all-capitals shouting, sentences over 300 characters or under 2 words; European Portuguese (pt-BR, PT_PT_RE);
  another language (see below); the same message twice (after lowercasing and removing punctuation); messages of one user above 1% of the source (min 20).
Language: the words of 3+ letters are looked up in the dictionary of each language of the config (dicts/<lang>/main.dict dumped by build_dict.py). A word
typed without accent counts for the accented word of the list (nao -> não); a word WITH an accent must be in the list as it is. For each other language the
sentence has a = words that only the target has and b = words that only the other has: the sentence is dropped as "that other language" when b > a for any of
them (a tie stays: if every word is valid in both, the community decides), and as "low coverage" when the target has fewer than min_cover of the words
(real_sources.json, "lang_filter"). Sentences with fewer than 2 such words cannot be judged and are dropped. The rule was chosen on known text (docs/tools/corpus/README.md,
5.5): on subtitles, Tatoeba and news of the three languages it keeps 98.5 to 99.9% of the own language and 0 to 7% of another one (the 7% are sentences whose
words all exist in both languages). This favours words the dictionary already has, so the out-of-dictionary rate of the report is a LOWER bound; the real typing has more.
The test never repeats a message of the training: a message that is in a test source is taken out of train and dev.
"""
import argparse
import collections
import html
import json
import math
import os
import re
import subprocess
import sys
import unicodedata

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from prepare_corpus import APOS, LETTERS_RE, PT_PT_RE, SPACE_RE, digest   # noqa: E402

WORD_RE = re.compile(r"[^\W\d_]+(?:'[^\W\d_]+)*", re.U)
URL_RE = re.compile(r"(?:https?://|www\.)\S+|\b[\w-]+(?:\.[\w-]+)*\.(?:com|org|net|gov|edu|br|io|tv|ly|gl)(?:/\S*)?(?!\w)", re.I)
MDLINK_RE = re.compile(r"\[([^\]]*)\]\([^)]*\)")
EMAIL_RE = re.compile(r"[\w.+-]+@[\w-]+(?:\.[\w-]+)+")
PHONE_RE = re.compile(r"(?<!\w)\+?\(?\d[\d\s().-]{6,}\d(?!\w)")
MENTION_RE = re.compile(r"(?<![\w/])@\w+|(?<![\w])/?[ru]/[A-Za-z0-9_-]+|(?<!\w)#\w+")
CODE_RE = re.compile(r"```.*?```|`[^`]*`", re.S)
RT_RE = re.compile(r"^\s*RT\s+@", re.I)
ZW_RE = re.compile("[​-‏  ⁠﻿]")
SENT_SPLIT = re.compile(r"(?<=[.!?…])\s+")
RUN_RE = re.compile(r"(.)\1{2,}")
LAUGH_RE = re.compile(
    r"^(?:k{2,}\w*|(?:ka){2,}k?|(?:ha){2,}h?|(?:he){2,}h?|(?:hi){2,}h?|(?:ho){2,}h?|(?:ja){2,}j?|(?:je){2,}j?|(?:ji){2,}j?|(?:jo){2,}j?|"
    r"(?:js){2,}|(?:rs){2,}|(?:ah){2,}a?|(?:eh){2,}e?|(?:oh){2,}o?|(?:uh){2,}u?|xd+|lo+l+|lmf?ao+|rofl+|ksks\w*)$", re.I)
DROP_CATEGORIES = {"So", "Sk", "Cs", "Co", "Cn", "Cf", "Mn", "Cc"}
MARK = "\u00a7\u00a7"             # put where an e-mail or a phone was; the sentence that keeps it is dropped
MAX_CHARS = 300
MIN_WORDS = 2
USER_CAP_SHARE = 0.01
USER_CAP_MIN = 20
NEW_WORD_MIN_USERS = 5


def fold(w):
    return "".join(c for c in unicodedata.normalize("NFD", w) if unicodedata.category(c) != "Mn")


class LangModel:
    def __init__(self, words):
        self.exact = {w.lower() for w in words}
        self.folded = {fold(w) for w in self.exact}

    def covers(self, w):
        """Exact word, or an accent-free spelling of an accented word (nao -> não). A token WITH an accent that is not in the list is not
        covered: "qué" must not pass for the Portuguese "que"."""
        return w in self.exact or (w in self.folded and w == fold(w))


def load_words(path):
    out = []
    with open(path, encoding="utf-8") as f:
        for line in f:
            w = line.split("\t", 1)[0].strip()
            if w:
                out.append(w)
    return out


def load_models(cfg, root, words_dir, work):
    models, notes = {}, []
    for code, lc in cfg["languages"].items():
        tsv = os.path.join(words_dir, code + ".words.tsv") if words_dir else None
        if not (tsv and os.path.exists(tsv)):
            dpath = os.path.join(root, lc["dictionary"])
            if not os.path.exists(dpath):
                notes.append("dictionary of %s not found (%s): it does not compete in the language test" % (code, dpath))
                continue
            os.makedirs(os.path.join(work, "dictwords"), exist_ok=True)
            tsv = os.path.join(work, "dictwords", code + ".words.tsv")
            if not os.path.exists(tsv) or os.path.getmtime(tsv) < os.path.getmtime(dpath):
                bd = os.path.join(root, "docs", "tools", "build_dict.py")
                r = subprocess.run([sys.executable, "-I", bd, "--dump", dpath, tsv, os.path.join(work, "dictwords", code + ".bigrams.tsv")], capture_output=True, text=True)
                if r.returncode != 0:
                    raise SystemExit("build_dict.py --dump failed for %s: %s" % (code, (r.stdout + r.stderr)[-300:]))
        models[code] = LangModel(load_words(tsv))
    return models, notes


# ------------------------------------------------------------------------------ cleaning

def strip_symbols(s):
    return "".join(c for c in s if unicodedata.category(c) not in DROP_CATEGORIES or c in "\n")


class Counters:
    def __init__(self):
        self.c = collections.Counter()

    def __getitem__(self, k):
        return self.c[k]

    def add(self, k, n=1):
        self.c[k] += n


def split_units(raw, st):
    """Raw message -> list of candidate sentences (still to be judged). Counts what the message had."""
    t = html.unescape(raw).translate(APOS)
    t = ZW_RE.sub("", t)
    if RT_RE.match(t):
        st.add("retweet")
        return []
    has_link = bool(URL_RE.search(t) or MDLINK_RE.search(t))
    st.add("msg_with_link", has_link)
    st.add("msg_with_mention", bool(MENTION_RE.search(t)))
    t = CODE_RE.sub(" ", t)
    t = "\n".join(l for l in t.split("\n") if not l.lstrip().startswith("&gt;") and not l.lstrip().startswith(">"))
    # e-mails and phones: marked, the sentence that has them is dropped later (the mark survives the splitting).
    # The e-mails go BEFORE the links: "joao@email.com" would otherwise lose "email.com" to the link rule and leave "joao@".
    t = EMAIL_RE.sub(" " + MARK + " ", t)
    t = MDLINK_RE.sub(r"\1", t)
    t = URL_RE.sub(" ", t)
    t = PHONE_RE.sub(lambda m: " " + MARK + " " if len(re.sub(r"\D", "", m.group(0))) >= 8 else m.group(0), t)
    t = MENTION_RE.sub(" ", t)
    t = t.replace("*", " ").replace("~", " ").replace("^", " ").replace("_", " ")
    t = strip_symbols(unicodedata.normalize("NFC", t))
    out = []
    for line in t.split("\n"):
        line = SPACE_RE.sub(" ", line).strip()
        if not line:
            continue
        for s in SENT_SPLIT.split(line):
            s = s.strip()
            if s:
                out.append(s)
    return out


def clean_sentence(s, models, lang, cfg_lang, flt, st, tokens_out=None):
    """One candidate sentence -> the cleaned text or None (the reason is counted in st)."""
    if MARK in s:
        st.add("drop_personal")
        return None
    fail = []

    def fix(m):
        w = m.group(0)
        if LAUGH_RE.match(w):
            st.add("laughs_removed")
            return ""
        if RUN_RE.search(w):
            for cand in (RUN_RE.sub(r"\1", w), RUN_RE.sub(r"\1\1", w)):
                if models[lang].covers(cand.lower()):
                    st.add("elongations_fixed")
                    return cand
            fail.append(w)
        return w
    s = WORD_RE.sub(fix, s)
    if fail:
        st.add("drop_elongation")
        return None
    s = re.sub(r"([!?])\1+", r"\1", s)
    s = re.sub(r"\.{4,}", "...", s)
    s = SPACE_RE.sub(" ", s).strip()
    s = re.sub(r"\s+([,.;:!?])", r"\1", s)
    s = re.sub(r"^[\s,.;:!?-]+", "", s)
    s = re.sub(r"^[•·\-–—]+\s*", "", s)
    s = s.strip(' -–—"“”')
    if not s:
        st.add("drop_empty")
        return None
    letters = len(LETTERS_RE.findall(s))
    if letters < 2 or letters < 0.6 * len(s.replace(" ", "")):
        st.add("drop_not_text")
        return None
    if len(s) > MAX_CHARS:
        st.add("drop_too_long")
        return None
    if len(s) > 12 and s.upper() == s and letters > 8:
        st.add("drop_allcaps")
        return None
    words = WORD_RE.findall(s)
    if len(words) < MIN_WORDS:
        st.add("drop_too_short")
        return None
    if cfg_lang.get("drop_european_pt") and PT_PT_RE.search(s):
        st.add("drop_european_pt")
        return None
    toks = [w.lower() for w in words if len(w) >= 3]
    if len(toks) < flt["min_tokens"]:
        st.add("drop_unjudged")
        return None
    st.add("judged")
    # Evidence by words that only one language has: a = words of the sentence that the target dictionary has and the other one lacks, b = the reverse.
    # The sentence goes when another language has MORE exclusive words than the target (it is that language), or when the target covers too little of it.
    # A tie (for example every word is valid in Spanish and Portuguese) stays: the community is already of the target language, and dropping the
    # short generic messages would bias the sample against exactly what people type most.
    cov = {code: [m.covers(t) for t in toks] for code, m in models.items()}
    mine = cov[lang]
    worst, worst_gap, shared = "", 0, False
    for code, v in cov.items():
        if code == lang:
            continue
        a = sum(1 for x, y in zip(mine, v) if x and not y)
        b = sum(1 for x, y in zip(mine, v) if y and not x)
        if a == 0 and sum(v) / float(len(toks)) >= flt["min_cover"]:
            shared = True            # nothing in the sentence is only the target's: another language could have written it as well
        if b - a > worst_gap:
            worst, worst_gap = code, b - a
    if worst:
        st.add("drop_lang_other")
        st.add("other_" + worst)
        return None
    if sum(mine) / float(len(toks)) < flt["min_cover"]:
        st.add("drop_lang_low")
        return None
    st.add("lang_ok")
    if shared:
        st.add("lang_shared")
    return s


def msg_key(s):
    return digest(re.sub(r"\W+", " ", s.lower()).strip())


# ------------------------------------------------------------------------------ per source

def process_source(path, src, models, lang, cfg_lang, flt, profanity, wanted):
    st = Counters()
    units = []                                  # (text, user)
    comm = collections.Counter()
    users = set()
    with open(path, encoding="utf-8") as f:
        for line in f:
            if not line.strip():
                continue
            try:
                m = json.loads(line)
            except ValueError:
                st.add("bad_line")
                continue
            st.add("raw")
            users.add(m.get("u"))
            for s in split_units(m.get("t", ""), st):
                st.add("candidates")
                c = clean_sentence(s, models, lang, cfg_lang, flt, st)
                if c:
                    units.append((c, m.get("u", ""), m.get("c", "")))
    before = len(units)
    seen, uniq = set(), []
    for t, u, c in units:
        k = msg_key(t)
        if k in seen:
            continue
        seen.add(k)
        uniq.append((t, u, c))
    st.add("repeated", before - len(uniq))
    cap = max(USER_CAP_MIN, int(USER_CAP_SHARE * len(uniq)))
    per_user, capped = collections.Counter(), []
    for t, u, c in uniq:
        if not u.startswith("r"):                # "r<page>" is a stand-in where the dataset has no user
            per_user[u] += 1
            if per_user[u] > cap:
                st.add("drop_user_cap")
                continue
        capped.append((t, u, c))
    for t, u, c in capped:
        comm[c] += 1
    stats = dict(st.c)
    stats.update({"units_before_dedupe": before, "units_kept": len(capped), "users": len(users), "user_cap": cap, "communities": dict(comm),
                  "requested": wanted, "role": src.get("role")})
    return capped, stats


def describe(units, model, profanity):
    """Words, out-of-dictionary rate, profanity, new words for a list of (text, user, community)."""
    words = tokens = oov = accent_free = prof = long_words = 0
    new = collections.Counter()
    new_users = collections.defaultdict(set)
    new_cap = collections.Counter()
    for t, u, c in units:
        ws = WORD_RE.findall(t)
        words += len(ws)
        hit = False
        for i, w in enumerate(ws):
            lw = w.lower()
            if len(lw) >= 4:
                long_words += 1
            if lw in profanity or fold(lw) in profanity:
                hit = True
            if len(lw) < 3:
                continue
            tokens += 1
            if lw in model.exact:
                continue
            if lw == fold(lw) and lw in model.folded:
                accent_free += 1
                continue
            oov += 1
            new[lw] += 1
            if len(new_users[lw]) < NEW_WORD_MIN_USERS:
                new_users[lw].add(u)
            if w[0].isupper() and i > 0:
                new_cap[lw] += 1
        prof += hit
    n = len(units)
    top = [(w, k, len(new_users[w]), "N" if new_cap[w] >= 0.8 * k else "") for w, k in new.most_common() if len(new_users[w]) >= NEW_WORD_MIN_USERS][:50]
    return {"units": n, "words": words, "words_4plus": long_words, "avg_words": round(words / float(n), 2) if n else 0,
            "oov_rate": round(oov / float(tokens), 4) if tokens else 0, "accent_free_rate": round(accent_free / float(tokens), 4) if tokens else 0,
            "profanity_rate": round(prof / float(n), 4) if n else 0}, top


def pct(a, b):
    return 100.0 * a / b if b else 0.0


def verdict(sid, st, flt):
    """Plain-words flags for a source (the numbers are in the report)."""
    flags = []
    judged = st.get("judged", 0)
    purity = pct(st.get("lang_ok", 0), judged)
    if st.get("raw", 0) == 0:
        return ["NO MESSAGES"]
    if purity < 80:
        flags.append("language purity %.0f%% (< 80%%): a lot of other language or slang outside the dictionary" % purity)
    if pct(st.get("msg_with_link", 0), st.get("raw", 1)) > 40:
        flags.append("more than 40% of the messages have a link")
    if st.get("time_budget"):
        flags.append("the sampler stopped at the time budget with %d of the %d messages asked" % (st.get("sampler_kept", 0), st.get("sampler_wanted", 0)))
    elif st.get("sampler_wanted") and st.get("sampler_kept", 0) < 0.9 * st["sampler_wanted"]:
        flags.append("the sampler gave %d of the %d messages asked (a community failed or ran out: see the sampler log)" % (st.get("sampler_kept", 0), st["sampler_wanted"]))
    if st.get("requested") and st.get("units_kept", 0) < 0.5 * st["requested"]:
        flags.append("kept %d units for %d messages requested (< 50%%)" % (st.get("units_kept", 0), st["requested"]))
    return flags or ["ok"]


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--config", required=True)
    ap.add_argument("--lang", required=True)
    ap.add_argument("--raw", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--root", default=os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "..")))
    ap.add_argument("--words-dir", default=None, help="folder with <lang>.words.tsv (word<TAB>freq) instead of dumping dicts/<lang>/main.dict")
    ap.add_argument("--dev-slice", type=int, default=20, help="1 in N messages of the train sources goes to the dev file")
    a = ap.parse_args(argv)
    cfg = json.load(open(a.config, encoding="utf-8"))
    lang = a.lang
    lc = cfg["languages"][lang]
    flt = {"min_cover": 0.5, "min_tokens": 2}
    flt.update(cfg.get("lang_filter", {}))
    os.makedirs(a.out, exist_ok=True)
    models, notes = load_models(cfg, a.root, a.words_dir, a.out)
    if lang not in models:
        raise SystemExit("the dictionary of %s is needed for the language test and was not found: %s" % (lang, "; ".join(notes)))
    profanity = {fold(w.lower()) for w in lc.get("profanity", [])} | {w.lower() for w in lc.get("profanity", [])}
    try:
        slog = json.load(open(os.path.join(a.raw, "sample_log.json"), encoding="utf-8"))
    except (OSError, ValueError):
        slog = {"sources": {}}

    per_source, kept = {}, {}
    for src in lc["sources"]:
        p = os.path.join(a.raw, src["id"] + ".jsonl")
        if not os.path.exists(p):
            per_source[src["id"]] = {"raw": 0, "role": src.get("role"), "sampler": (slog["sources"].get(src["id"]) or {}).get("status", "not sampled")}
            kept[src["id"]] = []
            continue
        wanted = (slog["sources"].get(src["id"]) or {}).get("wanted", 0)
        units, st = process_source(p, src, models, lang, lc, flt, profanity, wanted)
        sl = slog["sources"].get(src["id"]) or {}
        st["sampler"] = sl.get("status", "?")
        if sl.get("wanted"):
            st["sampler_wanted"], st["sampler_kept"] = sl.get("wanted", 0), sl.get("kept", 0)
        if sl.get("time_budget_hit"):
            st["time_budget"] = True
            st["sampler"] = "%s, time budget" % st["sampler"]
        per_source[src["id"]] = st
        kept[src["id"]] = units

    # ---- split by role; a message of a test source never stays in train/dev; the same message is not in two sources of one side
    roles = {s["id"]: s.get("role", "train") for s in lc["sources"]}
    test_keys, test_units, test_by_src = set(), [], {}
    for sid, units in kept.items():
        if roles[sid] != "test":
            continue
        mine = []
        for t, u, c in units:
            k = msg_key(t)
            if k in test_keys:
                continue
            test_keys.add(k)
            mine.append((t, u, c))
        test_by_src[sid] = mine
        test_units += mine
    train_keys, train_units, dev_units, leak = set(), [], [], 0
    for sid, units in kept.items():
        if roles[sid] == "test":
            continue
        for t, u, c in units:
            k = msg_key(t)
            if k in test_keys:
                leak += 1
                continue
            if k in train_keys:
                continue
            train_keys.add(k)
            (dev_units if k % a.dev_slice == 0 else train_units).append((t, u, c))

    def write(name, units):
        with open(os.path.join(a.out, name), "w", encoding="utf-8") as f:
            for t, u, c in units:
                f.write(t + "\n")
    write("chat_real_train.txt", train_units)
    write("chat_real_dev.txt", dev_units)
    write("chat_real_test.txt", test_units)
    for sid, mine in test_by_src.items():
        write("chat_real_test_%s.txt" % sid, mine)

    m = models[lang]
    d_train, top_train = describe(train_units, m, profanity)
    d_dev, _ = describe(dev_units, m, profanity)
    d_test, top_test = describe(test_units, m, profanity)
    d_src = {sid: describe(u, m, profanity)[0] for sid, u in test_by_src.items()}
    min_test = lc.get("min_test_lines", 10000)
    flags = {sid: verdict(sid, per_source[sid], flt) for sid in per_source}
    requested = slog.get("messages_requested") or 0
    test_requested = sum((slog["sources"].get(x["id"]) or {}).get("wanted", 0) for x in lc["sources"] if x.get("role") == "test")
    todo = []
    if len(test_units) < min_test:
        need = int(math.ceil(1.1 * test_requested * min_test / max(len(test_units), 1))) if test_requested else 0
        todo.append("TEST TOO SMALL: %d messages (need %d). %s" % (len(test_units), min_test,
                    ("Run again asking for about %d test messages (test_messages in the workflow, --role-messages test=%d in the sampler)." % (need, need))
                    if len(test_units) and need else "No test source gave messages: see the sampler log."))
    if not train_units:
        todo.append("NO TRAINING MESSAGES: the train sources gave nothing usable.")
    rep = {"language": lang, "filter": flt, "notes": notes, "sampler_messages_requested": requested,
           "sources": per_source, "flags": flags,
           "train": d_train, "dev": d_dev, "test": d_test, "test_by_source": d_src,
           "removed_from_train_because_in_test": leak, "min_test_lines": min_test, "test_ok": len(test_units) >= min_test, "todo": todo,
           "new_words_train": top_train, "new_words_test": top_test}
    json.dump(rep, open(os.path.join(a.out, "real_report.json"), "w", encoding="utf-8"), indent=1, ensure_ascii=False)
    with open(os.path.join(a.out, "real_report.md"), "w", encoding="utf-8") as f:
        f.write(render_md(rep))
    print(render_md(rep))
    return 0


def render_md(r):
    L = []
    w = L.append
    w("## Real messages: %s" % r["language"])
    w("")
    w("| source | role | sampler | raw | links | units kept | purity | repeated | profanity |")
    w("|---|---|---|---:|---:|---:|---:|---:|---:|")
    for sid, st in r["sources"].items():
        raw = st.get("raw", 0)
        if not raw:
            w("| %s | %s | %s | 0 | | | | | |" % (sid, st.get("role"), st.get("sampler")))
            continue
        w("| %s | %s | %s | %d | %.0f%% | %d | %.0f%% | %.0f%% | %.1f%% |" % (
            sid, st.get("role"), st.get("sampler"), raw, pct(st.get("msg_with_link", 0), raw), st.get("units_kept", 0),
            pct(st.get("lang_ok", 0), st.get("judged", 0)), pct(st.get("repeated", 0), st.get("units_before_dedupe", 0)),
            100.0 * r["train"]["profanity_rate"] if st.get("role") != "test" else 100.0 * r["test"]["profanity_rate"]))
    w("")
    for sid, fl in r["flags"].items():
        w("- **%s**: %s" % (sid, "; ".join(fl)))
    w("")
    w("### What was dropped (units, from the candidate sentences)")
    for sid, st in r["sources"].items():
        if not st.get("raw"):
            continue
        keys = [k for k in st if k.startswith("drop_") or k in ("retweet", "repeated")]
        line = "- %s: candidates %d; " % (sid, st.get("candidates", 0))
        line += ", ".join("%s %d" % (k.replace("drop_", ""), st[k]) for k in sorted(keys) if st[k])
        others = ["%s %d" % (k[6:], st[k]) for k in sorted(st) if k.startswith("other_")]
        if others:
            line += "; other languages: " + ", ".join(others)
        if st.get("lang_shared"):
            line += "; kept because every word is valid in two languages: %d" % st["lang_shared"]
        w(line)
    w("")
    w("### Sets")
    for name in ("train", "dev", "test"):
        d = r[name]
        w("- %s: %d messages, %d words (%d of 4+ letters), %.1f words each, out of the dictionary %.1f%% (accent-free forms %.1f%%), profanity %.1f%%" % (
            name, d["units"], d["words"], d["words_4plus"], d["avg_words"], 100 * d["oov_rate"], 100 * d["accent_free_rate"], 100 * d["profanity_rate"]))
    for sid, d in r["test_by_source"].items():
        w("  - test %s: %d messages, %d words of 4+ letters, out of the dictionary %.1f%%" % (sid, d["units"], d["words_4plus"], 100 * d["oov_rate"]))
    w("- removed from train because the same message is in the test: %d" % r["removed_from_train_because_in_test"])
    w("- test needs %d messages: %s" % (r["min_test_lines"], "OK" if r["test_ok"] else "NOT ENOUGH"))
    for t in r["todo"]:
        w("- **%s**" % t)
    for key, title in (("new_words_train", "train"), ("new_words_test", "test")):
        w("")
        w("### 50 most frequent words not in the dictionary (%s sources; used by %d+ users; N = looks like a name)" % (title, NEW_WORD_MIN_USERS))
        w(", ".join("%s%s %d" % (x[0], "*" if x[3] else "", x[1]) for x in r[key]) or "(none)")
    return "\n".join(L) + "\n"


if __name__ == "__main__":
    sys.exit(main())
