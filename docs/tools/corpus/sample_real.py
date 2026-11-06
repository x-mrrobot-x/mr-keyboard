#!/usr/bin/env python3
"""Downloads a sample of REAL informal messages for one language (stage 2 of docs/plan-next.md).

Usage:
  python3 -I sample_real.py --config real_sources.json --lang pt-BR --messages 50000 --out work/pt-BR/raw [--seed 1] [--only id,id]
                            [--arctic-base URL] [--hf-base URL] [--pace 1.0]

What it does, for each source of the language in real_sources.json (the sources are independent: one that fails never stops the others):
  reddit  Arctic Shift API (https://arctic-shift.photon-reddit.com): comments of the listed subreddits, taken from random windows of time inside
          [after, before) so a viral thread does not fill the sample. The service is free, run by one person and has no guarantee, so the
          calls are spaced (min_interval_s), a 429 waits for X-RateLimit-Reset, a timeout is retried with a smaller page, and a refusal that
          comes back at once (the cost guard) is not repeated. The format of the date parameters is probed on the first call (epoch, ISO or date).
  hf      Hugging Face datasets-server (/rows): random pages of 100 rows of a dataset. The text column is found from the features list.
Writes <out>/<source id>.jsonl (one JSON object per message: t = text, c = community, u = hash of the user, ts = time) and <out>/sample_log.json
(requests, rows, failures and the yield of each community, numbers only). User names are hashed with a random salt before anything is
written and are never stored; the text of the messages stays in <out> and is NOT meant to leave the runner (prepare_real.py cleans it first).
Exit code: 0 when at least one source gave messages, 3 when none did.
"""
import argparse
import datetime
import hashlib
import json
import math
import os
import random
import sys
import time
import traceback
import urllib.error
import urllib.parse
import urllib.request

UA = "MrKeyboard-corpus/1 (research sample for a keyboard dictionary; low rate)"
MAX_TEXT = 2000


class FetchError(Exception):
    """A request that could not be completed (the reason is a short text for the log)."""


class Pacer:
    def __init__(self, min_interval, scale):
        self.min_interval = min_interval * scale
        self.last = 0.0

    def wait(self):
        d = self.last + self.min_interval - time.monotonic()
        if d > 0:
            time.sleep(d)
        self.last = time.monotonic()


def get_json(url, timeout, retries, pacer, scale, log, shrink=None):
    """GET a JSON document. Retries timeouts and 5xx with a back-off, waits for a 429, gives up at once on a 4xx.

    shrink: optional callable(attempt) -> new url, used by the caller to ask for a smaller page after a timeout.
    """
    last = "no attempt"
    cur = url
    for attempt in range(retries + 1):
        pacer.wait()
        t0 = time.monotonic()
        try:
            req = urllib.request.Request(cur, headers={"User-Agent": UA, "Accept": "application/json"})
            with urllib.request.urlopen(req, timeout=timeout) as r:
                body = r.read().decode("utf-8", errors="replace")
            obj = json.loads(body)
        except urllib.error.HTTPError as e:
            elapsed = time.monotonic() - t0
            if e.code == 429:
                wait = 30
                try:
                    wait = int(float(e.headers.get("X-RateLimit-Reset", "30")))
                except (TypeError, ValueError):
                    pass
                wait = max(1, min(wait + 1, 120)) * scale
                last = "HTTP 429 (rate limit), waited %.0fs" % wait
                log["rate_limited"] = log.get("rate_limited", 0) + 1
                time.sleep(wait)
                continue
            if 500 <= e.code < 600:
                last = "HTTP %d" % e.code
                time.sleep(min(2 ** attempt, 30) * scale)
                continue
            raise FetchError("HTTP %d%s" % (e.code, "" if elapsed > 1 else " (at once)"))
        except (urllib.error.URLError, TimeoutError, OSError, ValueError) as e:
            last = "%s: %s" % (type(e).__name__, str(e)[:80])
            time.sleep(min(2 ** attempt, 30) * scale)
            if shrink:
                cur = shrink(attempt + 1) or cur
            continue
        # a JSON answer; the Arctic Shift API reports its own errors as {"data": null, "error": "..."}
        if isinstance(obj, dict) and obj.get("error"):
            elapsed = time.monotonic() - t0
            err = str(obj.get("error"))[:120]
            if elapsed < 1.0 and "imeout" not in err and "timed out" not in err:
                raise FetchError("refused at once: " + err)    # the cost guard: asking again does not help
            last = "service error after %.1fs: %s" % (elapsed, err)
            log["service_errors"] = log.get("service_errors", 0) + 1
            time.sleep(min(2 ** attempt, 30) * scale)
            if shrink:
                cur = shrink(attempt + 1) or cur
            continue
        return obj
    raise FetchError(last)


def user_hash(salt, user):
    return hashlib.sha1((salt + str(user)).encode("utf-8")).hexdigest()[:10]


# ------------------------------------------------------------------------------ Reddit (Arctic Shift)

def fmt_date(ts, fmt):
    if fmt == "epoch":
        return str(int(ts))
    d = datetime.datetime.fromtimestamp(ts, datetime.timezone.utc)
    if fmt == "iso":
        return d.strftime("%Y-%m-%dT%H:%M:%SZ")
    return d.strftime("%Y-%m-%d")


def parse_day(s):
    return datetime.datetime.strptime(s, "%Y-%m-%d").replace(tzinfo=datetime.timezone.utc).timestamp()


class Arctic:
    def __init__(self, cfg, base, pace):
        self.cfg = cfg
        self.base = (base or cfg["base"]).rstrip("/")
        self.pacer = Pacer(cfg.get("min_interval_s", 2.0), pace)
        self.scale = pace
        self.fmt = None
        self.log = {}
        self.cap = cfg.get("limit", 100)      # page size that works: goes down after timeouts and never goes up again

    def comments(self, sub, start, end, limit, sort="asc"):
        limit = min(limit, self.cap)

        def url(lim):
            q = {"subreddit": sub, "after": fmt_date(start, self.fmt), "before": fmt_date(end, self.fmt), "limit": str(lim), "sort": sort,
                 "fields": "id,body,author,created_utc,subreddit,score"}
            return self.base + "/api/comments/search?" + urllib.parse.urlencode(q)

        def shrink(attempt):
            self.cap = max(10, min(self.cap, limit // (2 ** attempt)))
            return url(self.cap)
        obj = get_json(url(limit), self.cfg.get("timeout_s", 90), self.cfg.get("retries", 5), self.pacer, self.scale, self.log, shrink)
        data = obj.get("data") if isinstance(obj, dict) else None
        if not isinstance(data, list):
            raise FetchError("unexpected answer: no 'data' list")
        return data

    def probe_dates(self, sub, after, before, limit):
        """Finds the date format that the service really applies: the rows returned must be inside the window asked for."""
        note = []
        window = min(before - after, 7 * 86400)
        start = after + max(0, (before - after - window)) / 2
        for fmt in self.cfg.get("date_formats", ["epoch", "iso", "date"]):      # the finest first: a date alone makes the window a whole day
            self.fmt = fmt
            if fmt == "date":
                start = math.floor(start / 86400) * 86400
                end = start + max(window, 86400)
            else:
                end = start + window
            try:
                rows = self.comments(sub, start, end, 5)
            except FetchError as e:
                note.append("%s: %s" % (fmt, e))
                continue
            ts = [int(float(r.get("created_utc", 0))) for r in rows if "created_utc" in r]
            if not ts:
                note.append("%s: no rows" % fmt)
                continue
            if all(start - 1 <= t < end + 1 for t in ts):
                return fmt, note
            note.append("%s: rows outside the window" % fmt)
        self.fmt = (self.cfg.get("date_formats") or ["epoch"])[0]
        return None, note


def is_bot(author, text, cfg):
    a = (author or "").lower()
    if a in [b.lower() for b in cfg.get("bot_authors", [])] or a.endswith("bot") or a.endswith("_bot"):
        return True
    low = text.lower()
    return any(p in low for p in cfg.get("bot_phrases", []))


def sample_reddit(arctic, src, n, rng, cfg, out_path, salt):
    stats = {"type": "reddit", "wanted": n, "kept": 0, "requests": 0, "failures": 0, "dropped_bot": 0, "dropped_deleted": 0, "communities": {}, "notes": []}
    after, before = parse_day(src["after"]), parse_day(src["before"])
    subs = list(src["subreddits"])
    limit = arctic.cfg.get("limit", 100)
    fmt, note = arctic.probe_dates(subs[0], after, before, limit)
    stats["notes"] += ["date probe " + x for x in note]
    if fmt is None:
        stats["notes"].append("the service did not apply any date format that was tried: windows may be wrong, check the log")
    stats["date_format"] = arctic.fmt
    span = before - after
    step = 86400 if arctic.fmt == "date" else 3600       # a date without a time cannot tell the hours apart
    quota = int(math.ceil(float(n) / len(subs)))
    seen = set()
    with open(out_path, "w", encoding="utf-8") as out:
        for sub in subs:
            cs = {"requests": 0, "rows": 0, "kept": 0, "failures": 0, "stopped": ""}
            stats["communities"][sub] = cs
            win = max(step, min(arctic.cfg.get("window_start_hours", 24) * 3600, span) // step * step)
            max_win = max(step, min(arctic.cfg.get("window_max_hours", 1440) * 3600, span) // step * step)
            budget = max(20, int(math.ceil(float(quota) / limit)) * 4)
            tried = set()
            consecutive_fail = 0
            while cs["kept"] < quota and cs["requests"] < budget:
                if win >= span:
                    start = after
                else:
                    slots = int((span - win) // step) + 1
                    start = None
                    for _ in range(12):
                        cand = after + rng.randrange(slots) * step
                        if cand not in tried:
                            start = cand
                            break
                    if start is None:
                        cs["stopped"] = "no unused window left"
                        break
                tried.add(start)
                end = min(start + win, before)
                try:
                    # a page is the first (asc) or the last (desc) comments of the window: both, at random, so a busy window is not read only from its start
                    rows = arctic.comments(sub, start, end, limit, rng.choice(("asc", "desc")))
                except FetchError as e:
                    cs["requests"] += 1
                    stats["requests"] += 1
                    cs["failures"] += 1
                    stats["failures"] += 1
                    consecutive_fail += 1
                    cs["last_error"] = str(e)
                    if consecutive_fail >= 3:
                        cs["stopped"] = "3 failures in a row: " + str(e)
                        break
                    win = max(win // 2 // step * step, step)       # a heavy window is the usual reason: ask for less time
                    continue
                consecutive_fail = 0
                cs["requests"] += 1
                stats["requests"] += 1
                cs["rows"] += len(rows)
                for r in rows:
                    rid = r.get("id")
                    text = r.get("body") or ""
                    if rid is None or rid in seen:
                        continue
                    seen.add(rid)
                    if text in ("[deleted]", "[removed]") or not text.strip():
                        stats["dropped_deleted"] += 1
                        continue
                    if is_bot(r.get("author"), text, cfg):
                        stats["dropped_bot"] += 1
                        continue
                    out.write(json.dumps({"t": text[:MAX_TEXT], "c": sub, "u": user_hash(salt, r.get("author")), "ts": int(float(r.get("created_utc", 0)))},
                                         ensure_ascii=False) + "\n")
                    cs["kept"] += 1
                    stats["kept"] += 1
                    if cs["kept"] >= quota:
                        break
                # a window with few comments is made larger; a full page means the window is rich: make it smaller
                eff = min(limit, arctic.cap)
                if len(rows) < eff * 0.3:
                    if win >= max_win and len(rows) == 0 and win >= span:
                        cs["stopped"] = "empty over the whole period"
                        break
                    win = min(win * 2, max_win)
                elif len(rows) >= eff:
                    win = max(win // 2 // step * step, step)
            if not cs["stopped"]:
                cs["stopped"] = "quota reached" if cs["kept"] >= quota else "request budget used"
    return stats


# ------------------------------------------------------------------------------ Hugging Face (datasets-server)

TEXT_FIELDS = ["text", "tweet", "tweet_text", "content", "body", "sentence", "message", "comment"]


def pick_text_field(features):
    names = [f.get("name") for f in features if isinstance(f, dict)]
    strings = [f.get("name") for f in features if isinstance(f, dict) and isinstance(f.get("type"), dict) and f["type"].get("dtype") == "string"]
    for p in TEXT_FIELDS:
        if p in names:
            return p
    return strings[0] if strings else None


class Hf:
    def __init__(self, cfg, base, pace):
        self.cfg = cfg
        self.base = (base or cfg["base"]).rstrip("/")
        self.pacer = Pacer(cfg.get("min_interval_s", 0.5), pace)
        self.scale = pace
        self.log = {}

    def get(self, path, params):
        url = self.base + path + "?" + urllib.parse.urlencode(params)
        return get_json(url, self.cfg.get("timeout_s", 90), self.cfg.get("retries", 5), self.pacer, self.scale, self.log)

    def rows(self, dataset, config, split, offset, length):
        return self.get("/rows", {"dataset": dataset, "config": config, "split": split, "offset": offset, "length": length})

    def first_split(self, dataset):
        obj = self.get("/splits", {"dataset": dataset})
        sp = obj.get("splits") or []
        if not sp:
            raise FetchError("the dataset has no splits (viewer not available?)")
        return sp[0].get("config"), sp[0].get("split")


def sample_hf(hf, src, n, rng, out_path, salt):
    stats = {"type": "hf", "wanted": n, "kept": 0, "requests": 0, "failures": 0, "communities": {}, "notes": []}
    ds = src["dataset"]
    config, split = src.get("config", "default"), src.get("split", "train")
    length = hf.cfg.get("length", 100)
    try:
        first = hf.rows(ds, config, split, 0, length)
    except FetchError as e:
        stats["notes"].append("rows with config=%s split=%s failed (%s); asking /splits" % (config, split, e))
        config, split = hf.first_split(ds)
        first = hf.rows(ds, config, split, 0, length)
    stats["requests"] += 1
    total = int(first.get("num_rows_total") or 0)
    if first.get("partial"):
        stats["notes"].append("the viewer serves only a part of the dataset (partial); rows come from that part")
    field = src.get("field") or pick_text_field(first.get("features") or [])
    if not field:
        raise FetchError("no text column found in the features")
    ufield = src.get("user_field")
    stats["field"] = field
    stats["total_rows"] = total
    pages = int(math.ceil(float(n) / length))
    starts = list(range(0, max(total, length), length))
    rng.shuffle(starts)
    starts = [0] + [s for s in starts if s != 0]
    cons_fail = 0
    with open(out_path, "w", encoding="utf-8") as out:
        for i, off in enumerate(starts[:pages]):
            try:
                obj = first if off == 0 else hf.rows(ds, config, split, off, length)
            except FetchError as e:
                stats["failures"] += 1
                cons_fail += 1
                stats["last_error"] = str(e)
                if cons_fail >= 3:
                    stats["notes"].append("stopped after 3 failures in a row: %s" % e)
                    break
                continue
            cons_fail = 0
            if off != 0:
                stats["requests"] += 1
            for item in obj.get("rows") or []:
                row = item.get("row") or {}
                if field in (item.get("truncated_cells") or []):
                    continue
                text = row.get(field)
                if not isinstance(text, str) or not text.strip():
                    continue
                u = user_hash(salt, row.get(ufield)) if ufield and row.get(ufield) is not None else "r%d" % (item.get("row_idx", off) // 100)
                out.write(json.dumps({"t": text[:MAX_TEXT], "c": ds, "u": u, "ts": 0}, ensure_ascii=False) + "\n")
                stats["kept"] += 1
                stats["communities"][ds] = stats["communities"].get(ds, 0) + 1
                if stats["kept"] >= n:
                    break
            if stats["kept"] >= n:
                break
    return stats


# ------------------------------------------------------------------------------ main

def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--config", required=True)
    ap.add_argument("--lang", required=True)
    ap.add_argument("--messages", type=int, default=50000, help="messages requested for the language, split between its sources by weight")
    ap.add_argument("--out", required=True)
    ap.add_argument("--seed", type=int, default=1)
    ap.add_argument("--only", default="", help="comma-separated source ids (default: all)")
    ap.add_argument("--arctic-base", default=None)
    ap.add_argument("--hf-base", default=None)
    ap.add_argument("--pace", type=float, default=1.0, help="multiplier of every wait (tests use 0)")
    a = ap.parse_args(argv)
    with open(a.config, encoding="utf-8") as f:
        cfg = json.load(f)
    lang = cfg["languages"][a.lang]
    os.makedirs(a.out, exist_ok=True)
    only = [x for x in a.only.split(",") if x]
    sources = [s for s in lang["sources"] if not only or s["id"] in only]
    total_w = sum(s.get("weight", 1.0) for s in sources) or 1.0
    rng = random.Random(a.seed)
    salt = os.urandom(8).hex()
    log = {"language": a.lang, "messages_requested": a.messages, "started": datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"), "sources": {}}
    arctic = Arctic(cfg["arctic_shift"], a.arctic_base, a.pace)
    hf = Hf(cfg["hf"], a.hf_base, a.pace)
    got_any = False
    for s in sources:
        n = int(round(a.messages * s.get("weight", 1.0) / total_w))
        path = os.path.join(a.out, s["id"] + ".jsonl")
        t0 = time.monotonic()
        try:
            if s["type"] == "reddit":
                st = sample_reddit(arctic, s, n, rng, cfg, path, salt)
            elif s["type"] == "hf":
                st = sample_hf(hf, s, n, rng, path, salt)
            else:
                raise FetchError("unknown source type " + str(s["type"]))
            st["status"] = "ok" if st["kept"] > 0 else "EMPTY"
        except Exception as e:      # one source failing must not stop the others
            st = {"status": "FAILED", "error": "%s: %s" % (type(e).__name__, str(e)[:200]), "wanted": n, "kept": 0, "trace": traceback.format_exc().splitlines()[-3:]}
        st["role"] = s.get("role")
        st["seconds"] = round(time.monotonic() - t0, 1)
        log["sources"][s["id"]] = st
        got_any = got_any or st["kept"] > 0
        print("%-18s %-7s wanted %6d  kept %6d  requests %s  %s" % (s["id"], st["status"], n, st["kept"], st.get("requests", "-"), st.get("error", "")), flush=True)
    log["service_notes"] = {"arctic_shift": arctic.log, "hf": hf.log}
    with open(os.path.join(a.out, "sample_log.json"), "w", encoding="utf-8") as f:
        json.dump(log, f, indent=1, ensure_ascii=False)
    return 0 if got_any else 3


if __name__ == "__main__":
    sys.exit(main())
