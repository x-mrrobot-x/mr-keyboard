#!/usr/bin/env python3
"""Tests the cleanup of the learned pairs (UserBigramDictionary$UpdateDbTask.checkPruneData, stage 7).

Run it from the project root:  python3 -I docs/tools/test_prune_order.py

The database is not testable on the PC with the app, so this reads the real thing out of the smali (the two CREATE TABLE statements, the two caps and the
ORDER BY of the query that picks the pairs to delete), builds the same tables in SQLite and runs the same steps as the method: read the pairs of the
`frequency` table in that order and, when there are more than the cap, delete from `main` the first `total - cap + step` of them (the frequency rows go with them by the
foreign key). It checks that the pairs used the most survive and that the least used and, among those, the oldest go first; and that the old query, with no order,
would have deleted the oldest pairs whatever their use (so the check can tell the two apart).
"""
import os
import re
import sqlite3
import sys

ROOT = os.getcwd()
APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


def read(name):
    with open(os.path.join(APP, name), encoding="utf-8") as fh:
        return fh.read()


helper = read("UserBigramDictionary$DatabaseHelper.smali")
dictionary = read("UserBigramDictionary.smali")
task = read("UserBigramDictionary$UpdateDbTask.smali")

create = re.findall(r'const-string v0, "(CREATE TABLE (?:main|frequency) [^"]*)"', helper)
cap = int(re.search(r"sMaxUserBigrams:I = (0x[0-9a-f]+)", dictionary).group(1), 16)
step = int(re.search(r"sDeleteUserBigrams:I = (0x[0-9a-f]+)", dictionary).group(1), 16)

start = task.index(".method private checkPruneData")
method = task[start:task.index(".end method", start)]
call = method.index("invoke-virtual/range {v1 .. v8}")
before = method[:call]
order = None
for m in re.finditer(r"^\s*(const-string|const/4) v8, (\"[^\"]*\"|0x0)\s*$", before, re.M):
    order = None if m.group(2) == "0x0" else m.group(2).strip('"')
table = re.search(r'const-string v2, "(\w+)"', before).group(1)
column = re.search(r'const-string v1, "(\w+)"', before).group(1)
delete_from = re.search(r'const-string v6, "(\w+)"\s*\n\s*const-string v7, "([^"]*)"', method[call:]).groups()

check("the method reads the table frequency, column pair_id", table == "frequency" and column == "pair_id", (table, column))
check("the method deletes from main by _id", delete_from == ("main", "_id=?"), delete_from)
check("the pairs are read least used first, the oldest first among equals", order == "freq ASC, _id ASC", order)
check("the caps are 10,000 and 1,000", (cap, step) == (10000, 1000), (cap, step))
check("the two CREATE TABLE statements were found", len(create) == 2, create)


def database(freqs):
    db = sqlite3.connect(":memory:")
    db.execute("PRAGMA foreign_keys = ON;")
    for sql in create:
        db.execute(sql)
    for i, f in enumerate(freqs, 1):
        db.execute("INSERT INTO main(word1, word2, locale) VALUES (?, ?, 'pt')", ("a%d" % i, "b%d" % i))
        db.execute("INSERT INTO frequency(pair_id, freq) VALUES (?, ?)", (i, f))
    return db


def prune(db, how):
    db.execute("PRAGMA foreign_keys = ON;")
    rows = db.execute("SELECT pair_id FROM frequency" + (" ORDER BY " + how if how else "")).fetchall()
    if len(rows) > cap:
        for (pid,) in rows[:len(rows) - cap + step]:
            db.execute("DELETE FROM main WHERE _id=?", (str(pid),))
    db.commit()


def left(db):
    return {r[0] for r in db.execute("SELECT _id FROM main")}


total = cap + 500
freqs = [127] * 200 + [2] * 8000 + [4] * 1000 + [6] * (total - 9200)
expected_gone = len(freqs) - cap + step

db = database(freqs)
prune(db, order)
alive = left(db)
gone = set(range(1, total + 1)) - alive
check("%d pairs are deleted: the total, minus the cap, plus the step" % expected_gone, len(gone) == expected_gone, len(gone))
check("the 200 oldest pairs, the most used, all survive", all(i in alive for i in range(1, 201)))
lowest = sorted(range(1, total + 1), key=lambda i: (freqs[i - 1], i))[:expected_gone]
check("the pairs deleted are exactly the least used, the oldest first among equals", gone == set(lowest))
check("among the pairs typed once the oldest go and the newest stay", min(set(range(201, 8201)) & alive) > max(set(range(201, 8201)) - alive))
check("the frequency rows of the deleted pairs went with them", db.execute("SELECT COUNT(*) FROM frequency").fetchone()[0] == len(alive))

old = database(freqs)
prune(old, None)
check("with no order (the old query) the 200 most used oldest pairs were deleted: the check tells the two apart", all(i not in left(old) for i in range(1, 201)))

db = database([2] * cap)
prune(db, order)
check("at the cap nothing is deleted", len(left(db)) == cap)

db = database([2] * (cap + 1))
prune(db, order)
check("one over the cap deletes 1,001 pairs", len(left(db)) == cap - step, len(left(db)))

print("\n%d ok, %d fail" % (ok, fails))
sys.exit(1 if fails else 0)
