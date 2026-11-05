"""Splits the corpora of one language into train and test (v1.65; English used split_en.py, the same).

Usage: python3 -I split_lang.py <leipzig_folder> <xxx_sentences(_detailed).tsv> <out> <tatoeba_code> <names>
  ex.: split_lang.py spa_news_2025_1M spa_sentences_detailed.tsv split spa "Tom,Mary"
  Leipzig (<folder>/<name>-sentences.txt, id TAB sentence): 1 in every 50 sentences goes to the test set.
  Tatoeba (id TAB code TAB sentence): the repeated names and places of the example sentences (comma-
  separated list) become "|", so they do not teach pairs like "Tom es"; repeated sentences are dropped;
  1 in every 20 goes to the test set.
Output: <out>/news_train.txt, news_test.txt, chat_train.txt, chat_test.txt
"""
import os
import re
import sys

src_dir, tsv, out, code, names = sys.argv[1:6]
os.makedirs(out, exist_ok=True)
name = os.path.basename(os.path.normpath(src_dir))
n = [0, 0]
with open(os.path.join(src_dir, name + "-sentences.txt"), encoding="utf-8") as f, \
        open(os.path.join(out, "news_train.txt"), "w", encoding="utf-8") as tr, \
        open(os.path.join(out, "news_test.txt"), "w", encoding="utf-8") as te:
    for i, line in enumerate(f):
        p = line.rstrip("\n").split("\t", 1)
        if len(p) < 2:
            continue
        (te if i % 50 == 0 else tr).write(p[1] + "\n")
        n[i % 50 == 0] += 1
print("news: train", n[0], "test", n[1])
NAMES = re.compile(r"\b(?:" + "|".join(re.escape(x) for x in names.split(",") if x) + r")(?:'s)?\b")
seen, uniq = set(), []
with open(tsv, encoding="utf-8") as f:
    for line in f:
        p = line.rstrip("\n").split("\t")
        if len(p) < 3 or p[1] != code:
            continue
        t = NAMES.sub("|", p[2].strip().replace("’", "'"))
        if len(t) >= 2 and t not in seen:
            seen.add(t)
            uniq.append(t)
with open(os.path.join(out, "chat_train.txt"), "w", encoding="utf-8") as tr, \
        open(os.path.join(out, "chat_test.txt"), "w", encoding="utf-8") as te:
    for i, t in enumerate(uniq):
        (te if i % 20 == 0 else tr).write(t + "\n")
print("chat: sentences without repetition", len(uniq), "test", (len(uniq) + 19) // 20)
