#!/usr/bin/env python3
"""Simulated typing sessions for RecentEval.java (v1.75), without real conversation text.

Usage: python3 -I gen_sessions.py text1.txt text2.txt out_topic.txt out_random.txt [how_many]
The test corpora come shuffled (loose sentences, no document). Two approximations:
  topic      sentences that repeat a rare word (df 3 to 30), in file order: like a conversation about a
             subject (optimistic: the subject repeats more than in a real conversation);
  random     sentences with no relation at all (pessimistic: the recent words can only get in the way).
Each session is up to 8 sentences; sessions are separated by a blank line.
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
seeds = sorted(w for w, c in df.items() if 3 <= c <= 30)   # fixed order: the result does not depend on Python's hash
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
print(len(topic), "sessions by topic,", len(rand), "random,", len(sents), "sentences")
