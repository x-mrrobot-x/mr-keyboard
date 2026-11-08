#!/usr/bin/env python3
"""The acceptance rule for a candidate dictionary pack (stage 2 of the plan after 1.87.0, now deleted; the Git history keeps it; the reasons are in docs/dictionary-tuning.md, "Acceptance rule").

Usage:
  python3 -I accept_pack.py --lang pt-BR --old results/old --new results/new [--pack-dir work/pt-BR/new_dicts/pt-BR] [--zip pack.zip] [--json out.json]
  python3 -I accept_pack.py --rule        (prints the rule and exits)

--old and --new are the folders written by docs/tools/e2e/run_real_eval.sh: one text file per test (subs, news, tatoeba, real, real_<source>, dev), each
the output of SubtitleEval. The pack is compared with the OLD pack on the same sentences. The old pack must be the baseline built the old way on the same
splits (docs/tools/corpus/README.md, section 4), not the shipped one, which has seen part of the test sentences.

Score of a test = the mean of the four hit rates (after the space, 1, 2 and 3 letters; words of 4+ letters). Gains and losses are in percentage points of the score.
The noise of a difference is estimated from the number of words (n) of each rate, as if old and new were independent (that is pessimistic: both use the same words).
Exit code: 0 accepted, 1 rejected, 2 a result that the rule needs is missing.
"""
import argparse
import json
import math
import os
import re
import sys

RULE = {
    "real_min_gain": 0.5,          # score points on the real messages (all test sources together)
    "real_noise_z": 2.0,           # ... and at least this many standard errors of the difference
    "real_max_after_space_loss": 0.1,   # the hit rate right after the space may not fall on the real messages
    "source_noise_z": 1.0,         # on each independent test source the gain may not be negative by more than this many standard errors
    "max_loss": {"subs": 0.5, "tatoeba": 1.5, "news": 1.5},    # score points allowed to lose on the other hold-outs
    "max_after_space_loss": {"subs": 0.5, "tatoeba": 1.5, "news": 1.0},   # and the rate right after the space, per hold-out
    "max_disk_bytes": 12000000,    # the pack folder (main.dict + trigrams.bin + rules.txt + ...) per language
    "max_zip_bytes": 7000000,      # the download per language
}
TEXT = """Acceptance rule (score = mean of the hit rates after the space, 1, 2 and 3 letters; points of the score, candidate minus old pack, same sentences):
  1. Real messages (test sources together): gain >= {real_min_gain} AND >= {real_noise_z} standard errors of the difference; the rate after the space may not fall by more than {real_max_after_space_loss}.
  2. Each independent real test source (tweets, another subreddit group): the gain may not be below -{source_noise_z} standard error (a gain that shows in only one of them is not trusted).
  3. The other hold-outs may lose at most (score / right after the space): subtitles {max_loss[subs]} / {max_after_space_loss[subs]}, news {max_loss[news]} / {max_after_space_loss[news]}, Tatoeba {max_loss[tatoeba]} / {max_after_space_loss[tatoeba]}.
     (Tatoeba is the artificial register; the pt-BR ablation measured -1.3 / -1.2 on it for the decided cut from 25% to 10%, so a smaller loss there is not a regression.)
  4. Size: the pack folder at most {max_disk_bytes} bytes, the zip at most {max_zip_bytes} bytes (when given).
  The dev file (training communities) is shown for information only: a big gap between its gain and the test gain means the pack learned the communities, not the language."""

LINE = re.compile(r"^\s*(after the space|([1-7]) letters?)\s+weighted\s+([\d.]+)% \(n=(\d+)\)")
HEAD = re.compile(r"^\S+: (\d+) sentences")
KINDS = ["after the space", "1 letter", "2 letters", "3 letters"]


def parse(path):
    rates, ns, sentences = {}, {}, 0
    for line in open(path, encoding="utf-8"):
        m = HEAD.match(line)
        if m:
            sentences = int(m.group(1))
        m = LINE.match(line)
        if m:
            k = 0 if m.group(2) is None else int(m.group(2))
            if k <= 3:
                rates[k] = float(m.group(3))
                ns[k] = int(m.group(4))
    if sorted(rates) != [0, 1, 2, 3]:
        raise ValueError("%s: the four rates (after the space, 1, 2, 3 letters) were not found" % path)
    return {"rates": [rates[i] for i in range(4)], "n": [ns[i] for i in range(4)], "sentences": sentences}


def score(r):
    return sum(r["rates"]) / 4.0


def se_score(r):
    s = 0.0
    for p, n in zip(r["rates"], r["n"]):
        p = p / 100.0
        s += (p * (1 - p) / max(n, 1))
    return 100.0 * math.sqrt(s) / 4.0


def compare(old, new):
    d = score(new) - score(old)
    se = math.sqrt(se_score(old) ** 2 + se_score(new) ** 2)
    return {"old": round(score(old), 2), "new": round(score(new), 2), "gain": round(d, 2), "se": round(se, 2),
            "after_space_gain": round(new["rates"][0] - old["rates"][0], 2), "words": new["n"][0], "sentences": new["sentences"],
            "rates_old": old["rates"], "rates_new": new["rates"]}


def folder_size(d):
    return sum(os.path.getsize(os.path.join(d, f)) for f in os.listdir(d) if os.path.isfile(os.path.join(d, f)))


def decide(old_dir, new_dir, pack_dir=None, zip_path=None, rule=RULE):
    rows, reasons, missing = {}, [], []
    names = set()
    for d in (old_dir, new_dir):
        names |= {f[:-4] for f in os.listdir(d) if f.endswith(".txt")}
    for name in sorted(names):
        po, pn = os.path.join(old_dir, name + ".txt"), os.path.join(new_dir, name + ".txt")
        if not (os.path.exists(po) and os.path.exists(pn)):
            if name in ("real", "subs", "news", "tatoeba"):
                missing.append(name)
            continue
        rows[name] = compare(parse(po), parse(pn))
    for need in ("real", "subs", "news", "tatoeba"):
        if need not in rows and need not in missing:
            missing.append(need)
    if "real" in missing:
        return rows, ["no result for the real messages (run_real_eval.sh needs real/chat_real_test.txt): the rule cannot be applied"], 2
    r = rows["real"]
    need = max(rule["real_min_gain"], rule["real_noise_z"] * r["se"])
    if r["gain"] < need:
        reasons.append("real messages: gain %+.2f is below %.2f (min %.2f, or %.1f standard errors = %.2f)" % (r["gain"], need, rule["real_min_gain"], rule["real_noise_z"], rule["real_noise_z"] * r["se"]))
    if r["after_space_gain"] < -rule["real_max_after_space_loss"]:
        reasons.append("real messages: the rate after the space fell %.2f (limit %.2f)" % (-r["after_space_gain"], rule["real_max_after_space_loss"]))
    for name, x in rows.items():
        if name.startswith("real_"):
            if x["gain"] < -rule["source_noise_z"] * x["se"]:
                reasons.append("%s: gain %+.2f is negative beyond the noise (%.2f)" % (name, x["gain"], x["se"]))
    for name, limit in rule["max_loss"].items():
        if name in missing:
            reasons.append("%s: no result (the loss on the other hold-outs cannot be checked)" % name)
            continue
        x = rows[name]
        if x["gain"] < -limit:
            reasons.append("%s: lost %.2f points (limit %.2f)" % (name, -x["gain"], limit))
        lim = rule["max_after_space_loss"][name]
        if x["after_space_gain"] < -lim:
            reasons.append("%s: the rate after the space fell %.2f (limit %.2f)" % (name, -x["after_space_gain"], lim))
    if pack_dir:
        sz = folder_size(pack_dir)
        rows["_size"] = {"disk_bytes": sz}
        if sz > rule["max_disk_bytes"]:
            reasons.append("pack folder %d bytes is over %d" % (sz, rule["max_disk_bytes"]))
    if zip_path:
        sz = os.path.getsize(zip_path)
        rows.setdefault("_size", {})["zip_bytes"] = sz
        if sz > rule["max_zip_bytes"]:
            reasons.append("zip %d bytes is over %d" % (sz, rule["max_zip_bytes"]))
    return rows, reasons, (1 if reasons else 0)


def render(lang, rows, reasons, code):
    out = ["Acceptance of the candidate pack%s (points of the score = mean of the 4 hit rates; after-space = rate right after the space)" % (" " + lang if lang else ""),
           "%-22s %8s %8s %8s %8s %12s %9s" % ("test", "old", "new", "gain", "noise", "after space", "words")]
    for name, x in rows.items():
        if name.startswith("_"):
            continue
        out.append("%-22s %8.2f %8.2f %+8.2f %8.2f %+12.2f %9d" % (name, x["old"], x["new"], x["gain"], x["se"], x["after_space_gain"], x["words"]))
    if "_size" in rows:
        out.append("size: " + ", ".join("%s %d" % (k, v) for k, v in rows["_size"].items()))
    out.append("VERDICT: " + ("ACCEPT" if code == 0 else "REJECT" if code == 1 else "CANNOT DECIDE"))
    out += ["  - " + r for r in reasons]
    return "\n".join(out)


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--lang", default="")
    ap.add_argument("--old")
    ap.add_argument("--new")
    ap.add_argument("--pack-dir")
    ap.add_argument("--zip")
    ap.add_argument("--json")
    ap.add_argument("--rule", action="store_true")
    a = ap.parse_args(argv)
    if a.rule:
        print(TEXT.format(**RULE))
        return 0
    if not (a.old and a.new):
        ap.error("--old and --new are needed")
    rows, reasons, code = decide(a.old, a.new, a.pack_dir, a.zip)
    print(render(a.lang, rows, reasons, code))
    if a.json:
        json.dump({"language": a.lang, "verdict": ["accept", "reject", "cannot decide"][code], "reasons": reasons, "tests": rows, "rule": RULE},
                  open(a.json, "w", encoding="utf-8"), indent=1)
    return code


if __name__ == "__main__":
    sys.exit(main())
