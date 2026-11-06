#!/usr/bin/env python3
"""Tests sample_real.py and prepare_real.py of the real-message evaluation (stage 2 of docs/plan-next.md) without any network.

Run it from the project root:  python3 -I docs/tools/corpus/test_real.py

The sampler talks to two local fake servers that behave like Arctic Shift (date parameter in one format only, 429 with
X-RateLimit-Reset, a timeout for big pages, an error answered at once, [deleted] comments, bots, repeated ids) and like the
Hugging Face datasets-server (/splits, /rows with 100 rows at most, 404 for a wrong config, a 500 on demand). The tests check
the files that come out (no user name in them), the date probe, the retries, and that one failing source never stops the others.
"""
import hashlib
import http.server
import json
import os
import random
import re
import shutil
import subprocess
import sys
import tempfile
import threading
import time
import urllib.parse

HERE = os.path.dirname(os.path.abspath(__file__))
SAMPLER = os.path.join(HERE, "sample_real.py")
PREPARE = os.path.join(HERE, "prepare_real.py")
ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


T = tempfile.mkdtemp(prefix="mr_real_test_")

# ------------------------------------------------------------------------------ fake services

WORDS_PT = "eu acho que isso vai dar certo amanhã mas ninguém sabe ainda porque o trânsito está horrível hoje cedo".split()
WORDS_EN = "i think this is going to work tomorrow but nobody knows yet because the traffic is awful today".split()
FMT_RE = {"epoch": re.compile(r"^\d+$"), "iso": re.compile(r"^\d{4}-\d\d-\d\dT\d\d:\d\d:\d\dZ$"), "date": re.compile(r"^\d{4}-\d\d-\d\d$")}


def to_epoch(s):
    import calendar
    if s.isdigit():
        return int(s)
    if "T" in s:
        return calendar.timegm(time.strptime(s, "%Y-%m-%dT%H:%M:%SZ"))
    return calendar.timegm(time.strptime(s, "%Y-%m-%d"))


class State:
    """What a fake service does (changed by each test) and what it saw."""

    def __init__(self, **kw):
        self.fmt = "iso"             # the only date format the fake Arctic Shift accepts
        self.lax = False             # True: a date in another format is ignored instead of refused
        self.per_hour = 2            # comments per hour in the community
        self.every_429 = 0           # every Nth request is a 429
        self.slow_over = 0           # a page bigger than this takes 1.6 s (a timeout for a client with timeout_s=1)
        self.refuse_subs = ()        # answered at once with an error
        self.err422_subs = ()        # HTTP 422 with a JSON body that explains it
        self.sparse = {}             # community -> N: a comment only in 1 hour of N (a small community)
        self.hf_total = 1000
        self.hf_fail = False         # every /rows answers 500
        self.hf_config = "default"
        self.hf_field = "text"
        self.requests = []
        self.n = 0
        self.__dict__.update(kw)


def comment_text(sub, ts, i, words):
    r = random.Random("%s-%d-%d" % (sub, ts, i))
    return " ".join(r.choice(words) for _ in range(r.randint(4, 12)))


def make_comments(st, sub, start, end, limit, sort="asc"):
    rows = []
    h = (start // 3600) * 3600
    while h < end and (len(rows) < limit or sort == "desc"):
        if st.sparse.get(sub) and (h // 3600) % st.sparse[sub] != 0:
            h += 3600
            continue
        for i in range(st.per_hour):
            ts = h + i * 17
            if ts < start or ts >= end:
                continue
            cid = hashlib.md5(("%s%d%d" % (sub, ts, i)).encode()).hexdigest()[:7]
            body = comment_text(sub, ts, i, WORDS_PT)
            author = "user_%d" % ((ts // 3600 + i) % 40)
            k = (ts // 17 + i) % 20
            if k == 0:
                body = "[deleted]"
            elif k == 1:
                author = "AutoModerator"
            elif k == 2:
                body = "I am a bot, and this action was performed automatically"
            rows.append({"id": cid, "body": body, "author": author, "created_utc": ts, "subreddit": sub, "score": 1})
        h += 3600
    return rows[:limit] if sort != "desc" else rows[::-1][:limit]


class Handler(http.server.BaseHTTPRequestHandler):
    st = None

    def log_message(self, *a):
        pass

    def handle_error(self, *a):
        pass

    def reply(self, code, obj, headers=None):
        body = json.dumps(obj).encode("utf-8")
        try:
            self.send_response(code)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            for k, v in (headers or {}).items():
                self.send_header(k, v)
            self.end_headers()
            self.wfile.write(body)
        except (BrokenPipeError, ConnectionResetError):
            pass

    def do_GET(self):
        st = self.st
        u = urllib.parse.urlparse(self.path)
        q = {k: v[0] for k, v in urllib.parse.parse_qs(u.query).items()}
        st.n += 1
        st.requests.append((u.path, q))
        if u.path == "/api/comments/search":
            if st.every_429 and st.n % st.every_429 == 0:
                return self.reply(429, {"data": None, "error": "rate limit"}, {"X-RateLimit-Reset": "0"})
            sub = q.get("subreddit", "")
            if sub in st.err422_subs:
                return self.reply(422, {"detail": [{"msg": "invalid parameter", "loc": ["query", "limit"]}]})
            if sub in st.refuse_subs:
                return self.reply(200, {"data": None, "error": "Query too expensive"})
            limit = int(q.get("limit", "25"))
            if st.slow_over and limit > st.slow_over:
                time.sleep(1.6)
            a, b = q.get("after", ""), q.get("before", "")
            if not (FMT_RE[st.fmt].match(a) and FMT_RE[st.fmt].match(b)):
                if not st.lax:
                    return self.reply(400, {"data": None, "error": "Invalid date"})
                a, b = "1735689600", "1735689600"          # ignored: whatever the service has first (outside every window)
                start, end = 1500000000, 1500000000 + 7200
            else:
                start, end = to_epoch(a), to_epoch(b)
            return self.reply(200, {"data": make_comments(st, sub, start, end, limit, q.get("sort", "asc"))})
        if u.path == "/splits":
            return self.reply(200, {"splits": [{"dataset": q["dataset"], "config": st.hf_config, "split": "train"}]})
        if u.path == "/rows":
            if st.hf_fail:
                return self.reply(500, {"error": "boom"})
            if q.get("config") != st.hf_config:
                return self.reply(404, {"error": "config not found"})
            off, ln = int(q["offset"]), min(int(q["length"]), 100)
            rows = []
            for i in range(off, min(off + ln, st.hf_total)):
                r = random.Random("hf%d" % i)
                text = " ".join(r.choice(WORDS_PT) for _ in range(r.randint(3, 10)))
                rows.append({"row_idx": i, "row": {st.hf_field: text, "user_id": 1000 + i % 70, "lang": "es"}, "truncated_cells": []})
            feats = [{"feature_idx": 0, "name": st.hf_field, "type": {"dtype": "string", "_type": "Value"}},
                     {"feature_idx": 1, "name": "user_id", "type": {"dtype": "int64", "_type": "Value"}}]
            return self.reply(200, {"features": feats, "rows": rows, "num_rows_total": st.hf_total, "partial": False})
        self.reply(404, {"error": "no such path"})


class Server:
    def __init__(self, **kw):
        self.st = State(**kw)
        h = type("H", (Handler,), {"st": self.st})
        self.httpd = http.server.ThreadingHTTPServer(("127.0.0.1", 0), h)
        self.url = "http://127.0.0.1:%d" % self.httpd.server_address[1]
        threading.Thread(target=self.httpd.serve_forever, daemon=True).start()

    def stop(self):
        self.httpd.shutdown()
        self.httpd.server_close()


def base_config(**over):
    cfg = {
        "version": 1, "about": "test",
        "arctic_shift": {"base": "http://unused", "min_interval_s": 2.0, "limit": 100, "timeout_s": 5, "retries": 3, "window_start_hours": 24, "window_max_hours": 240},
        "hf": {"base": "http://unused", "min_interval_s": 0.5, "length": 100, "timeout_s": 5, "retries": 2},
        "bot_authors": ["AutoModerator"], "bot_phrases": ["i am a bot", "this action was performed automatically"],
        "languages": {"pt-BR": {"dictionary": "dicts/pt-BR/main.dict", "min_test_lines": 50, "profanity": ["merda"], "drop_european_pt": True, "sources": [
            {"id": "rd-train", "type": "reddit", "role": "train", "weight": 0.5, "after": "2025-01-01", "before": "2025-04-01", "subreddits": ["brasil", "farialimabets"]},
            {"id": "rd-test", "type": "reddit", "role": "test", "weight": 0.25, "after": "2025-04-01", "before": "2025-07-01", "subreddits": ["conversas"]},
            {"id": "hf-test", "type": "hf", "role": "test", "weight": 0.25, "dataset": "fake/tweets", "config": "default", "split": "train", "field": "text", "user_field": "user_id"}]}}}
    cfg.update(over)
    return cfg


def run_sampler(cfg, server, out, only="", messages=400, extra=()):
    cfgp = os.path.join(out + "_cfg.json")
    json.dump(cfg, open(cfgp, "w"))
    cmd = [sys.executable, "-I", SAMPLER, "--config", cfgp, "--lang", "pt-BR", "--messages", str(messages), "--out", out,
           "--arctic-base", server.url, "--hf-base", server.url, "--pace", "0", "--seed", "3"]
    if only:
        cmd += ["--only", only]
    cmd += list(extra)
    return subprocess.run(cmd, capture_output=True, text=True, timeout=300)


def read_jsonl(p):
    return [json.loads(l) for l in open(p, encoding="utf-8") if l.strip()]


def sampler_tests():
    # 1. normal run ------------------------------------------------------------------------------------------------
    srv = Server(fmt="iso")
    out = os.path.join(T, "s1")
    r = run_sampler(base_config(), srv, out)
    check("sampler: exit 0 on a normal run", r.returncode == 0, r.stdout + r.stderr)
    log = json.load(open(os.path.join(out, "sample_log.json")))
    check("sampler: the log has the three sources, all ok", sorted(log["sources"]) == ["hf-test", "rd-test", "rd-train"] and all(s["status"] == "ok" for s in log["sources"].values()), json.dumps(log)[:600])
    check("sampler: the date probe chose the format the service applies (iso)", log["sources"]["rd-train"]["date_format"] == "iso", log["sources"]["rd-train"])
    tr = read_jsonl(os.path.join(out, "rd-train.jsonl"))
    check("sampler: reddit source reaches its share (200 of 400)", 190 <= len(tr) <= 200, len(tr))
    check("sampler: both communities are in the sample", {m["c"] for m in tr} == {"brasil", "farialimabets"})
    raw = open(os.path.join(out, "rd-train.jsonl"), encoding="utf-8").read()
    check("sampler: no user name is written (only a hash)", "user_" not in raw and "AutoModerator" not in raw and all(re.fullmatch(r"[0-9a-f]{10}", m["u"]) for m in tr))
    check("sampler: [deleted] and bot comments were dropped", "[deleted]" not in raw and "i am a bot" not in raw.lower() and log["sources"]["rd-train"]["dropped_bot"] > 0 and log["sources"]["rd-train"]["dropped_deleted"] > 0)
    check("sampler: no repeated comment id", len({(m["c"], m["ts"], m["t"]) for m in tr}) == len(tr))
    ts = [m["ts"] for m in tr]
    import calendar
    lo, hi = calendar.timegm((2025, 1, 1, 0, 0, 0)), calendar.timegm((2025, 4, 1, 0, 0, 0))
    check("sampler: every comment is inside the period asked for", all(lo <= t < hi for t in ts), (min(ts), max(ts)))
    check("sampler: windows are random, not always the first days", len({t // 86400 for t in ts}) > 5, len({t // 86400 for t in ts}))
    hf = read_jsonl(os.path.join(out, "hf-test.jsonl"))
    check("sampler: hf source gives its share (100 rows)", len(hf) == 100, len(hf))
    check("sampler: hf users are hashed too", all(re.fullmatch(r"[0-9a-f]{10}", m["u"]) for m in hf) and '"1000"' not in open(os.path.join(out, "hf-test.jsonl")).read())
    srv.stop()

    # 2. a service that ignores a date it does not understand: the probe must see rows outside the window -------------
    srv = Server(fmt="iso", lax=True)
    out = os.path.join(T, "s2")
    r = run_sampler(base_config(), srv, out, only="rd-train")
    log = json.load(open(os.path.join(out, "sample_log.json")))
    check("sampler: probe finds the right format on a lax service (iso)", log["sources"]["rd-train"].get("date_format") == "iso", log["sources"]["rd-train"].get("notes"))
    check("sampler: probe notes say what the wrong formats did", any("outside" in n for n in log["sources"]["rd-train"]["notes"]) or any("Invalid" in n or "HTTP" in n for n in log["sources"]["rd-train"]["notes"]), log["sources"]["rd-train"]["notes"])
    srv.stop()

    # 3. rate limit: every 3rd request is a 429 ----------------------------------------------------------------------
    srv = Server(fmt="iso", every_429=3)
    out = os.path.join(T, "s3")
    r = run_sampler(base_config(), srv, out, only="rd-train")
    log = json.load(open(os.path.join(out, "sample_log.json")))
    check("sampler: survives 429 and still fills the quota", log["sources"]["rd-train"]["kept"] >= 190 and r.returncode == 0, r.stdout + r.stderr)
    check("sampler: the 429s are counted in the log", log["service_notes"]["arctic_shift"].get("rate_limited", 0) > 0, log["service_notes"])
    srv.stop()

    # 4. big pages time out: the sampler asks for smaller pages --------------------------------------------------------
    cfg = base_config()
    cfg["arctic_shift"]["timeout_s"] = 1
    srv = Server(fmt="iso", slow_over=40)
    out = os.path.join(T, "s4")
    t0 = time.time()
    r = run_sampler(cfg, srv, out, only="rd-test", messages=40)
    log = json.load(open(os.path.join(out, "sample_log.json")))
    check("sampler: after a timeout it asks for a smaller page and gets rows", log["sources"]["rd-test"]["kept"] > 0, (r.stdout + r.stderr)[-400:])
    sizes = [int(q["limit"]) for p, q in srv.st.requests if p == "/api/comments/search"]
    check("sampler: the page size went down after the timeouts", min(sizes) <= 25 and max(sizes) == 100, sizes[:12])
    srv.stop()

    # 5. an answer that refuses at once (cost guard) for one community: the others go on ------------------------------
    srv = Server(fmt="iso", refuse_subs=("farialimabets",))
    out = os.path.join(T, "s5")
    r = run_sampler(base_config(), srv, out, only="rd-train")
    log = json.load(open(os.path.join(out, "sample_log.json")))
    cs = log["sources"]["rd-train"]["communities"]
    check("sampler: a refused community is reported and stops after 6 tries in a row", "refused at once" in cs["farialimabets"].get("stopped", "") and cs["farialimabets"]["requests"] == 6, cs["farialimabets"])
    check("sampler: the other community is still sampled", cs["brasil"]["kept"] > 90, cs["brasil"])
    srv.stop()

    # 6. the dataset service is down: the other sources still give their sample; exit 0 ---------------------------------
    srv = Server(fmt="iso", hf_fail=True)
    out = os.path.join(T, "s6")
    cfg = base_config()
    cfg["hf"]["retries"] = 1
    r = run_sampler(cfg, srv, out)
    log = json.load(open(os.path.join(out, "sample_log.json")))
    check("sampler: a failing hf source is marked and does not stop the reddit ones", log["sources"]["hf-test"]["status"] in ("FAILED", "EMPTY") and log["sources"]["rd-train"]["status"] == "ok" and r.returncode == 0, json.dumps(log["sources"]["hf-test"]))
    srv.stop()

    # 7. everything fails: exit 3 -----------------------------------------------------------------------------------------
    srv = Server(fmt="iso", hf_fail=True, refuse_subs=("brasil", "farialimabets", "conversas"))
    out = os.path.join(T, "s7")
    r = run_sampler(cfg, srv, out)
    check("sampler: exit code 3 when no source gave a message", r.returncode == 3, r.returncode)
    srv.stop()

    # 8. wrong config name for hf: falls back to /splits --------------------------------------------------------------------
    srv = Server(fmt="iso", hf_config="es")
    out = os.path.join(T, "s8")
    r = run_sampler(base_config(), srv, out, only="hf-test")
    log = json.load(open(os.path.join(out, "sample_log.json")))
    check("sampler: hf config not found -> asks /splits and goes on", log["sources"]["hf-test"]["status"] == "ok" and any("splits" in n for n in log["sources"]["hf-test"]["notes"]), log["sources"]["hf-test"])
    srv.stop()

    # 9. the text column is found from the features when the config does not name it ----------------------------------------
    srv = Server(fmt="iso", hf_field="tweet")
    cfg = base_config()
    for s in cfg["languages"]["pt-BR"]["sources"]:
        s.pop("field", None)
    out = os.path.join(T, "s9")
    r = run_sampler(cfg, srv, out, only="hf-test")
    log = json.load(open(os.path.join(out, "sample_log.json")))
    check("sampler: text column detected from the features (tweet)", log["sources"]["hf-test"].get("field") == "tweet" and log["sources"]["hf-test"]["kept"] == 400, log["sources"]["hf-test"])
    srv.stop()

    srv = Server(fmt="epoch")
    out = os.path.join(T, "s1b")
    run_sampler(base_config(), srv, out, only="rd-train")
    sorts = {q["sort"] for p, q in srv.st.requests if p == "/api/comments/search" and int(q["limit"]) > 5}
    log = json.load(open(os.path.join(out, "sample_log.json")))
    check("sampler: both ends of a window are read (asc and desc) and epoch is chosen when it works", sorts == {"asc", "desc"} and log["sources"]["rd-train"]["date_format"] == "epoch", (sorts, log["sources"]["rd-train"].get("date_format")))
    srv.stop()

    # 12. HTTP 422 with a body: the body goes to the log, with the parameters of the failing request; the window is not shrunk for a refusal that came at once
    srv = Server(fmt="epoch", err422_subs=("farialimabets",))
    out = os.path.join(T, "s12")
    run_sampler(base_config(), srv, out, only="rd-train")
    log = json.load(open(os.path.join(out, "sample_log.json")))
    rs = log["sources"]["rd-train"]
    es_ = rs["error_samples"]
    check("sampler: the body of an HTTP 422 and the request parameters are in the log", es_ and "invalid parameter" in es_[0]["error"] and es_[0]["community"] == "farialimabets" and es_[0]["sort"] in ("asc", "desc") and "window_hours" in es_[0], es_[:1])
    wins = [round((to_epoch(q["before"]) - to_epoch(q["after"])) / 3600.0) for p, q in srv.st.requests if p == "/api/comments/search" and q["subreddit"] == "farialimabets"]
    check("sampler: an immediate refusal does not make the window smaller", len(set(wins[2:])) == 1, wins)
    srv.stop()

    # 13. a small community cannot give its quota: the others are asked for more (round 2)
    srv = Server(fmt="epoch", sparse={"brasil": 400})
    out = os.path.join(T, "s13")
    run_sampler(base_config(), srv, out, only="rd-train")
    log = json.load(open(os.path.join(out, "sample_log.json")))
    rs = log["sources"]["rd-train"]
    check("sampler: the quota a small community could not give is taken from the others", rs["kept"] >= 0.95 * rs["wanted"] and rs["communities"]["farialimabets"]["kept"] > rs["wanted"] // 2 and any("round 2" in x for x in rs["notes"]), (rs["kept"], rs["wanted"], rs["communities"], rs["notes"]))
    srv.stop()

    # 14. totals per role
    srv = Server(fmt="epoch")
    out = os.path.join(T, "s14")
    run_sampler(base_config(), srv, out, extra=["--role-messages", "train=300,test=100"])
    log = json.load(open(os.path.join(out, "sample_log.json")))
    w = {k: v["wanted"] for k, v in log["sources"].items()}
    check("sampler: --role-messages gives each role its total, split by weight inside the role", w == {"rd-train": 300, "rd-test": 50, "hf-test": 50}, w)
    r = subprocess.run([sys.executable, "-I", SAMPLER, "--config", out + "_cfg.json", "--lang", "pt-BR", "--out", out + "x", "--role-messages", "train=abc", "--arctic-base", srv.url, "--hf-base", srv.url], capture_output=True, text=True)
    check("sampler: a wrong --role-messages is refused", r.returncode != 0 and "role-messages" in (r.stderr + r.stdout))
    srv.stop()

    # 11. a service that takes only YYYY-MM-DD (the documented form): windows are whole days and never asked twice ------------------
    srv = Server(fmt="date")
    out = os.path.join(T, "s11")
    r = run_sampler(base_config(), srv, out, only="rd-train")
    log = json.load(open(os.path.join(out, "sample_log.json")))
    reqs = [q for p, q in srv.st.requests if p == "/api/comments/search" and int(q["limit"]) > 5]
    pairs = [(q["subreddit"], q["after"]) for q in reqs]
    check("sampler: date-only service: format found, windows are whole days, no window asked twice",
          log["sources"]["rd-train"]["date_format"] == "date" and all(FMT_RE["date"].match(q["after"]) for q in reqs) and len(set(pairs)) == len(pairs) and log["sources"]["rd-train"]["kept"] >= 190,
          (log["sources"]["rd-train"].get("date_format"), len(pairs), len(set(pairs)), log["sources"]["rd-train"]["kept"]))
    srv.stop()

    # 10. same seed -> same sample ---------------------------------------------------------------------------------------------
    srv = Server(fmt="iso")
    o1, o2 = os.path.join(T, "s10a"), os.path.join(T, "s10b")
    run_sampler(base_config(), srv, o1, only="rd-train")
    run_sampler(base_config(), srv, o2, only="rd-train")
    a = sorted(m["t"] + str(m["ts"]) for m in read_jsonl(os.path.join(o1, "rd-train.jsonl")))
    b = sorted(m["t"] + str(m["ts"]) for m in read_jsonl(os.path.join(o2, "rd-train.jsonl")))
    check("sampler: the same seed gives the same messages", a == b and len(a) > 100)
    srv.stop()



# ------------------------------------------------------------------------------ prepare_real.py

FAKE_WORDS = {
    "pt-BR": "eu você não sei acho que isso vai dar certo amanhã mas ninguém sabe ainda porque trânsito está horrível hoje cedo muito bom dia vamos ver filme "
             "ontem gostei demais casa amigo obrigado tudo bem comigo esse esta aqui numero time jogo",
    "es": "yo creo que esto va funcionar mañana pero nadie sabe todavía porque tráfico está horrible hoy temprano muy bueno día vamos ver película ayer "
          "gustó mucho casa amigo gracias todo bien conmigo",
    "en-US": "i think this will work tomorrow but nobody knows yet because traffic awful today early very good day let's see movie yesterday liked "
             "house friend thanks fine is going to",
}


def write_words(d):
    os.makedirs(d, exist_ok=True)
    for code, ws in FAKE_WORDS.items():
        with open(os.path.join(d, code + ".words.tsv"), "w", encoding="utf-8") as f:
            for w in ws.split():
                f.write("%s\t100\n" % w)


def write_raw(d, name, rows):
    os.makedirs(d, exist_ok=True)
    with open(os.path.join(d, name + ".jsonl"), "w", encoding="utf-8") as f:
        for i, r in enumerate(rows):
            text, user = r if isinstance(r, tuple) else (r, "%010x" % (i % 37))
            f.write(json.dumps({"t": text, "c": "sub", "u": user, "ts": 1}, ensure_ascii=False) + "\n")


def run_prepare(cfg, raw, out, words_dir=None, extra=()):
    cfgp = out + "_cfg.json"
    json.dump(cfg, open(cfgp, "w"))
    cmd = [sys.executable, "-I", PREPARE, "--config", cfgp, "--lang", "pt-BR", "--raw", raw, "--out", out]
    if words_dir:
        cmd += ["--words-dir", words_dir]
    cmd += list(extra)
    return subprocess.run(cmd, capture_output=True, text=True, timeout=300)


def lines(p):
    return [l.rstrip("\n") for l in open(p, encoding="utf-8")]


def prepare_tests():
    wd = os.path.join(T, "words")
    write_words(wd)
    cfg = base_config()
    cfg["languages"]["pt-BR"]["min_test_lines"] = 50
    cfg["languages"]["pt-BR"]["profanity"] = ["merda"]
    for code in ("es", "en-US"):
        cfg["languages"][code] = {"dictionary": "x", "sources": []}
    cfg["lang_filter"] = {"min_cover": 0.5, "min_tokens": 2}
    import itertools
    pt = FAKE_WORDS["pt-BR"].split()
    combos = ["%s %s %s %s" % c for c in itertools.islice(itertools.product(pt[:12], pt[12:24], pt[24:36], pt[36:44]), 100)]
    heavy = [(c, "ffffffffff") for c in combos]                       # one user, 100 different messages
    train = [
        "Eu acho que isso vai dar certo amanhã",                              # 0 kept (also in the test source: leak)
        "Veja https://exemplo.com/abc eu acho que ninguém sabe ainda",        # URL out
        "@fulano você viu o filme ontem? gostei demais",                      # mention out, two sentences
        "me liga no 11 98765-4321 amanhã cedo",                               # phone: dropped
        "mande para joao@email.com hoje cedo isso",                           # e-mail: dropped
        "kkkkkkk eu acho que porque o trânsito está horrível kkkk",           # laughs out
        "muiiiito bom esse filme demais",                                     # elongation fixed
        "noooossa que filme bom demais",                                      # elongation not fixed: dropped
        "ESTE TEXTO ESTA TODO EM MAIUSCULAS GRITANDO",                        # all caps
        "I think this will work tomorrow but nobody knows yet",               # English
        "yo creo que esto va a funcionar mañana pero nadie sabe todavía",     # Spanish
        "Sim",                                                                # one word
        "> citação de outro usuário\nmeu texto aqui eu acho que isso hoje cedo",   # quote out
        "Eu acho que isso vai dar certo amanhã",                              # exact repeat
        "o equipa está a fazer isso muito bom hoje",                          # European Portuguese
        "eu acho \U0001F602 que o trânsito hoje cedo \U0001F389 está horrível",    # emoji out
        "**eu acho** que _ninguém_ sabe ainda porque está horrível",          # markdown
        "RT @alguem: eu acho que isso vai dar certo",                         # retweet
        "voce nao sabe isso ainda porque esta horrivel",                      # no accents
        "Amanhã cedo eu vou ver o time jogo aqui",
        "O amigo sabe porque casa",                                           # every word is valid in pt and es: a tie stays
    ] + [("Eu acho que o bagulho está horrível hoje %s" % w, "%010x" % (900 + i)) for i, w in enumerate(["cedo", "demais", "bom", "casa", "amigo", "tudo"])] \
      + [("O raridade está bom hoje cedo", "%010x" % 800), ("O raridade está bom ontem cedo", "%010x" % 801)] + heavy
    test = ["Eu acho que isso vai dar certo amanhã", "Vamos ver o filme hoje cedo demais", "Ninguém sabe ainda porque o trânsito está horrível",
            "Obrigado amigo tudo bem comigo hoje", "kkkk eu gostei demais desse filme ontem"]
    raw = os.path.join(T, "p1_raw")
    write_raw(raw, "rd-train", train)
    write_raw(raw, "rd-test", test)
    write_raw(raw, "hf-test", ["Casa do amigo está bem hoje cedo", "Hoje cedo eu vou ver o time jogo"])
    out = os.path.join(T, "p1_out")
    r = run_prepare(cfg, raw, out, wd)
    check("prepare: exit 0", r.returncode == 0, r.stdout + r.stderr)
    tr = lines(os.path.join(out, "chat_real_train.txt")) + lines(os.path.join(out, "chat_real_dev.txt"))
    allt = "\n".join(tr)
    rep = json.load(open(os.path.join(out, "real_report.json")))
    st = rep["sources"]["rd-train"]
    check("prepare: link, @, phone, e-mail, laughs, emoji and the quote are gone from the text", not any(x in allt for x in ("http", "@", "exemplo", "98765", "joao", "kkkk", "\U0001F602", "\U0001F389", "citação", "fulano", "RT ", "**", "_")), [l for l in tr if re.search(r"http|@|kkkk|_|\*", l)])
    check("prepare: the URL is taken out and the rest stays", "Veja eu acho que ninguém sabe ainda" in tr, tr[:8])
    check("prepare: a comment becomes sentences, the mention goes", "você viu o filme ontem?" in tr and "gostei demais" in tr, tr[:8])
    check("prepare: laughs removed from the sentence", "eu acho que porque o trânsito está horrível" in tr, tr[:10])
    check("prepare: stretched letters go back to the dictionary word", "muito bom esse filme demais" in tr and st.get("elongations_fixed", 0) >= 1)
    check("prepare: a stretched word that is not in the dictionary drops the sentence", "drop_elongation" in st and not any("nosa" in l or "noooossa" in l for l in tr), st)
    check("prepare: phone and e-mail sentences are dropped", st.get("drop_personal", 0) == 2, st.get("drop_personal"))
    check("prepare: all caps and one-word messages are dropped", st.get("drop_allcaps", 0) == 1 and st.get("drop_too_short", 0) >= 1)
    check("prepare: a sentence whose words all exist in two languages stays (the community decides) and is counted", "O amigo sabe porque casa" in tr and st.get("lang_shared", 0) >= 1, st.get("lang_shared"))
    sys.path.insert(0, HERE)
    import prepare_real as PR
    m = PR.LangModel(["que", "não", "você", "casa"])
    check("prepare: accent rule: nao covers não, a token WITH an accent must be exact (qué is not que)", m.covers("nao") and m.covers("não") and m.covers("que") and not m.covers("qué") and not m.covers("casá") and not m.covers("nosa"))
    check("prepare: other languages are dropped and counted by language", st.get("drop_lang_other", 0) == 2 and st.get("other_en-US") == 1 and st.get("other_es") == 1, st)
    check("prepare: European Portuguese dropped (pt-BR)", st.get("drop_european_pt", 0) == 1 and not any("equipa" in l for l in tr))
    check("prepare: markdown symbols are removed", "eu acho que ninguém sabe ainda porque está horrível" in tr, [l for l in tr if "acho" in l])
    check("prepare: retweets dropped", st.get("retweet", 0) == 1)
    check("prepare: text without accents is accepted and counted", "voce nao sabe isso ainda porque esta horrivel" in tr and rep["train"]["accent_free_rate"] > 0)
    check("prepare: a repeated message is kept once", st.get("repeated", 0) >= 1 and tr.count("Eu acho que isso vai dar certo amanhã") == 0)
    check("prepare: one user is capped at max(20, 1%)", st["user_cap"] == 20 and 70 <= st.get("drop_user_cap", 0) <= 80 and sum(1 for l in tr if l in set(combos)) <= 20, (st.get("drop_user_cap"), st.get("user_cap")))
    check("prepare: the message that is in the test source is removed from train", rep["removed_from_train_because_in_test"] >= 1 and "Eu acho que isso vai dar certo amanhã" in lines(os.path.join(out, "chat_real_test.txt")))
    te = lines(os.path.join(out, "chat_real_test.txt"))
    check("prepare: test = all test sources (the laugh is cleaned there too)", "eu gostei demais desse filme ontem" in te and "Casa do amigo está bem hoje cedo" in te, te)
    check("prepare: test has the two sources in separate files too", os.path.exists(os.path.join(out, "chat_real_test_rd-test.txt")) and os.path.exists(os.path.join(out, "chat_real_test_hf-test.txt")))
    check("prepare: train, dev and test never share a message", not (set(tr) & set(te)) and not (set(lines(os.path.join(out, "chat_real_train.txt"))) & set(lines(os.path.join(out, "chat_real_dev.txt")))))
    check("prepare: dev is a small share of train, taken from the same sources", 0 < len(lines(os.path.join(out, "chat_real_dev.txt"))) < 0.2 * len(tr), (len(lines(os.path.join(out, "chat_real_dev.txt"))), len(tr)))
    nw = [x[0] for x in rep["new_words_train"]]
    check("prepare: a new word of 5+ users is in the list, one of 2 users is not", "bagulho" in nw and "raridade" not in nw, nw[:10])
    check("prepare: the test is too small for min_test_lines=50 -> a todo with the size to ask for", (not rep["test_ok"]) and any("TEST TOO SMALL" in t for t in rep["todo"]), rep["todo"])
    md = open(os.path.join(out, "real_report.md"), encoding="utf-8").read()
    check("prepare: the markdown report has the table, the flags and the new words", "| source |" in md and "words not in the dictionary" in md and "bagulho" in md)
    check("prepare: no user hash in the report or in the files", not re.search(r"\b[0-9a-f]{10}\b", md) and not any(re.search(r"\b[0-9a-f]{10}\b", l) for l in tr))

    # the test is big enough
    raw2 = os.path.join(T, "p2_raw")
    write_raw(raw2, "rd-train", train[:10])
    write_raw(raw2, "rd-test", [("%s" % c, "%010x" % (i % 30)) for i, c in enumerate(combos)])
    out2 = os.path.join(T, "p2_out")
    run_prepare(cfg, raw2, out2, wd)
    rep2 = json.load(open(os.path.join(out2, "real_report.json")))
    check("prepare: test_ok when the test has min_test_lines", rep2["test_ok"] and rep2["test"]["units"] >= 50 and not rep2["todo"], (rep2["test"]["units"], rep2["todo"]))

    # a source file that is missing: the report says so and the rest goes on
    raw3 = os.path.join(T, "p3_raw")
    write_raw(raw3, "rd-train", train[:6])
    out3 = os.path.join(T, "p3_out")
    r = run_prepare(cfg, raw3, out3, wd)
    rep3 = json.load(open(os.path.join(out3, "real_report.json")))
    check("prepare: a source that was not sampled is reported, exit 0", r.returncode == 0 and rep3["sources"]["rd-test"]["raw"] == 0 and rep3["flags"]["rd-test"] == ["NO MESSAGES"] and any("TEST TOO SMALL" in t for t in rep3["todo"]), r.stderr[-300:])

    # the real dictionaries of the project (dumped by build_dict.py): the whole path used by the workflow
    root = os.getcwd()
    if os.path.exists(os.path.join(root, "dicts", "pt-BR", "main.dict")) and os.path.exists(os.path.join(root, "docs", "tools", "build_dict.py")):
        cfgr = base_config()
        cfgr["languages"]["pt-BR"]["min_test_lines"] = 2
        cfgr["languages"]["pt-BR"]["sources"] = cfgr["languages"]["pt-BR"]["sources"][:2]
        cfgr["languages"]["es"] = {"dictionary": "dicts/es/main.dict", "sources": []}
        cfgr["languages"]["en-US"] = {"dictionary": "dicts/en-US/main.dict", "sources": []}
        cfgr["languages"]["pt-BR"]["dictionary"] = "dicts/pt-BR/main.dict"
        rawr = os.path.join(T, "pr_raw")
        write_raw(rawr, "rd-train", ["eu acho que isso vai dar certo amanhã", "ninguém sabe ainda porque o trânsito está horrível hoje cedo",
                                      "i think this is going to work tomorrow but nobody knows yet", "yo creo que esto va a funcionar mañana pero nadie sabe todavía",
                                      "vamos ver o filme hoje à noite com os amigos", "não sei o que fazer com essa situação agora"])
        write_raw(rawr, "rd-test", ["obrigado pela ajuda ontem foi muito bom", "bom dia para todos vocês"])
        outr = os.path.join(T, "pr_out")
        r = run_prepare(cfgr, rawr, outr, None, ["--root", root])
        check("prepare: runs with the real dictionaries dumped by build_dict.py", r.returncode == 0, (r.stdout + r.stderr)[-400:])
        if r.returncode == 0:
            trr = lines(os.path.join(outr, "chat_real_train.txt")) + lines(os.path.join(outr, "chat_real_dev.txt"))
            check("prepare: real dictionaries: Portuguese kept, English and Spanish dropped", len(trr) == 4 and not any("think" in l or "creo" in l for l in trr), trr)



# ------------------------------------------------------------------------------ the workflow file

def workflow_tests():
    wf = os.path.join(HERE, "mr-corpus-real.yml")
    text = open(wf, encoding="utf-8").read()
    pins = {}
    wdir = os.path.join(os.getcwd(), ".github", "workflows")
    if os.path.isdir(wdir):
        for fn in os.listdir(wdir):
            for m in re.finditer(r"uses:\s*([\w.-]+/[\w./-]+)@([0-9a-f]{40})", open(os.path.join(wdir, fn), encoding="utf-8").read()):
                pins.setdefault(m.group(1), set()).add(m.group(2))
    uses = re.findall(r"uses:\s*(\S+)\s*(#.*)?$", text, re.M)
    check("workflow: every action is pinned by a 40-character commit and has its version in a comment",
          bool(uses) and all(re.match(r"^[\w.-]+/[\w./-]+@[0-9a-f]{40}$", u) and c.strip().startswith("# v") for u, c in uses), uses)
    check("workflow: the pins are the same as the ones of the project's own workflows",
          all(pins.get(u.split("@")[0]) == {u.split("@")[1]} for u, c in uses) if pins else True, (uses, pins))
    try:
        import yaml
    except ImportError:
        print("SKIP  workflow: PyYAML is not installed (the structure checks below need it)")
        return
    d = yaml.safe_load(text)
    check("workflow: top-level permissions are read only", d.get("permissions") == {"contents": "read"}, d.get("permissions"))
    runs = [st["run"] for j in d["jobs"].values() for st in j["steps"] if "run" in st]
    check("workflow: no ${{ }} inside a shell script (values go through env)", all("${{" not in r for r in runs))
    check("workflow: the repository is checked out without keeping the token", any(st.get("with", {}).get("persist-credentials") is False for st in d["jobs"]["real"]["steps"] if "uses" in st))
    check("workflow: a manual run only (workflow_dispatch)", list(d[True].keys()) == ["workflow_dispatch"] if True in d else list(d["on"].keys()) == ["workflow_dispatch"])
    # the plan step, as bash does it
    plan = [st for st in d["jobs"]["plan"]["steps"] if st.get("id") == "p"][0]["run"]

    def run_plan(langs="pt-BR,es", messages="50000", seed="1", train="", test=""):
        go = os.path.join(T, "gh_output_%d" % len(os.listdir(T)))
        env = dict(os.environ, LANGS=langs, MESSAGES=messages, SEED=seed, TRAIN_MESSAGES=train, TEST_MESSAGES=test, GITHUB_OUTPUT=go)
        r = subprocess.run(["bash", "-c", plan], env=env, capture_output=True, text=True)
        return r, (open(go).read() if os.path.exists(go) else "")
    r, o = run_plan()
    check("workflow: plan lists the languages as JSON", r.returncode == 0 and o.strip() == 'langs=["pt-BR","es"]', (r.stderr, o))
    check("workflow: plan refuses an unknown language", run_plan(langs="pt-BR,xx")[0].returncode != 0)
    check("workflow: plan refuses a message count that is not a number or is out of range",
          all(run_plan(messages=m)[0].returncode != 0 for m in ("abc", "999", "1000001", "5; rm -rf /", "")))
    check("workflow: plan refuses a seed that is not a number", run_plan(seed="x y")[0].returncode != 0)
    check("workflow: plan accepts train_messages and test_messages together", run_plan(train="300000", test="40000")[0].returncode == 0)
    check("workflow: plan refuses only one of train_messages / test_messages", run_plan(train="300000")[0].returncode != 0 and run_plan(test="40000")[0].returncode != 0)
    check("workflow: plan refuses train_messages / test_messages that are not numbers or are out of range",
          all(run_plan(train=a, test=b)[0].returncode != 0 for a, b in (("abc", "40000"), ("300000", "4; rm -rf /"), ("999", "40000"), ("300000", "1000001"))))
    # the sampler step: it passes --role-messages only when asked (a fake sampler writes its arguments)
    samp = [st for st in d["jobs"]["real"]["steps"] if st.get("id") == "sample"][0]["run"]
    for train, test in (("", ""), ("300000", "40000")):
        w = os.path.join(T, "wf_samp_%s" % (train or "none"))
        os.makedirs(os.path.join(w, "mr", "docs", "tools", "corpus"))
        open(os.path.join(w, "mr", "docs", "tools", "corpus", "sample_real.py"), "w").write("import sys, json\nopen('args.json', 'w').write(json.dumps(sys.argv[1:]))\n")
        r = subprocess.run(["bash", "-c", samp], cwd=w, env=dict(os.environ, LANG_ID="es", MESSAGES="50000", TRAIN_MESSAGES=train, TEST_MESSAGES=test, SEED="3"), capture_output=True, text=True)
        args = json.load(open(os.path.join(w, "args.json"))) if os.path.exists(os.path.join(w, "args.json")) else []
        ok = r.returncode == 0 and args[args.index("--messages") + 1] == "50000" and args[args.index("--seed") + 1] == "3" and args[args.index("--lang") + 1] == "es"
        if train:
            ok = ok and args[args.index("--role-messages") + 1] == "train=300000,test=40000"
        else:
            ok = ok and "--role-messages" not in args
        check("workflow: the sampler step %s" % ("passes --role-messages" if train else "does not pass --role-messages when the volumes are empty"), ok, (r.stderr, args))
    # the pack step, on a fake tree
    pack = [st for st in d["jobs"]["real"]["steps"] if st.get("name", "").startswith("Pack the result")][0]["run"]
    for deliver in ("report", "data"):
        w = os.path.join(T, "wf_" + deliver)
        os.makedirs(os.path.join(w, "work", "es", "real"))
        os.makedirs(os.path.join(w, "work", "es", "raw"))
        for n in ("real_report.md", "real_report.json", "chat_real_train.txt", "chat_real_dev.txt", "chat_real_test.txt", "chat_real_test_rd-test.txt"):
            open(os.path.join(w, "work", "es", "real", n), "w").write("x\n")
        open(os.path.join(w, "work", "es", "raw", "sample_log.json"), "w").write("{}")
        r = subprocess.run(["bash", "-c", pack], cwd=w, env=dict(os.environ, LANG_ID="es", DELIVER=deliver), capture_output=True, text=True)
        got = sorted(os.listdir(os.path.join(w, "out"))) if os.path.isdir(os.path.join(w, "out")) else []
        want = ["real_report.json", "real_report.md", "sample_log.json"] + ([f + ".gz" for f in ("chat_real_dev.txt", "chat_real_test.txt", "chat_real_test_rd-test.txt", "chat_real_train.txt")] if deliver == "data" else [])
        check("workflow: the artifact of deliver=%s has %s" % (deliver, "the report and the cleaned files" if deliver == "data" else "only the report"), r.returncode == 0 and got == sorted(want), (r.stderr, got))
    # without sample_log.json (the sampler died before writing it) the pack step still works
    w = os.path.join(T, "wf_nolog")
    os.makedirs(os.path.join(w, "work", "es", "real"))
    open(os.path.join(w, "work", "es", "real", "real_report.md"), "w").write("x")
    open(os.path.join(w, "work", "es", "real", "real_report.json"), "w").write("{}")
    r = subprocess.run(["bash", "-c", pack], cwd=w, env=dict(os.environ, LANG_ID="es", DELIVER="report"), capture_output=True, text=True)
    check("workflow: the pack step works when the sampler left no log", r.returncode == 0, r.stderr)



# ------------------------------------------------------------------------------ accept_pack.py

ACCEPT = os.path.join(HERE, "accept_pack.py")
SAMPLE_EVAL = """pt-BR: 2000 sentences with 3 or more words
  known words      weighted  97.5%               unique  97.5%   (words of the sentences that the dictionary knows)
  after the space  weighted  14.4% (n=6355)   unique  14.4% (n=6355)
  1 letter         weighted  30.4% (n=6355)   unique  30.4% (n=6355)
  2 letters        weighted  41.9% (n=6355)   unique  41.9% (n=6355)
  3 letters        weighted  58.7% (n=6355)   unique  58.7% (n=6355)
  4 letters        weighted  70.0% (n=6355)   unique  70.0% (n=6355)
"""


def eval_file(d, name, rates, n=30000):
    os.makedirs(d, exist_ok=True)
    with open(os.path.join(d, name + ".txt"), "w") as f:
        f.write("pt-BR: 1000 sentences with 3 or more words\n")
        f.write("  known words      weighted  97.5%               unique  97.5%   (words of the sentences that the dictionary knows)\n")
        names = ["after the space", "1 letter", "2 letters", "3 letters", "4 letters", "5 letters", "6 letters", "7 letters"]
        for k, nm in enumerate(names):
            r = rates[min(k, 3)]
            f.write("  %-16s weighted %5.1f%% (n=%d)   unique %5.1f%% (n=%d)\n" % (nm, r, n, r, n))


BASE = [10.0, 25.0, 38.0, 55.0]


def shifted(delta, first=None):
    r = [x + delta for x in BASE]
    if first is not None:
        r[0] = BASE[0] + first
    return r


def accept_case(tag, new, extra=(), old=None, **kw):
    """new = {test: rates}; every test not named is equal to the old pack. Returns (exit code, output)."""
    od, nd = os.path.join(T, "acc_%s_old" % tag), os.path.join(T, "acc_%s_new" % tag)
    tests = ["subs", "news", "tatoeba", "real", "real_a", "real_b", "dev"]
    for name in tests:
        if name in (old or {}) and old[name] is None:
            continue
        eval_file(od, name, BASE)
        eval_file(nd, name, new.get(name, BASE))
    r = subprocess.run([sys.executable, "-I", ACCEPT, "--lang", "pt-BR", "--old", od, "--new", nd] + list(extra), capture_output=True, text=True)
    return r.returncode, r.stdout + r.stderr


def accept_tests():
    sys.path.insert(0, HERE)
    import accept_pack
    p = os.path.join(T, "sample_eval.txt")
    open(p, "w").write(SAMPLE_EVAL)
    x = accept_pack.parse(p)
    check("accept: parses the output of SubtitleEval (four rates and their n)", x["rates"] == [14.4, 30.4, 41.9, 58.7] and x["n"] == [6355] * 4 and x["sentences"] == 2000, x)
    good = {"real": shifted(1.0), "real_a": shifted(1.0), "real_b": shifted(1.0)}
    code, out = accept_case("a", good)
    check("accept: a clear gain on the real messages and no loss -> ACCEPT (exit 0)", code == 0 and "VERDICT: ACCEPT" in out, out)
    code, out = accept_case("b", {"real": shifted(0.3), "real_a": shifted(0.3), "real_b": shifted(0.3)})
    check("accept: a gain under 0.5 point on the real messages -> REJECT", code == 1 and "real messages: gain" in out, out)
    code, out = accept_case("c", dict(good, news=shifted(-2.0)))
    check("accept: news loses 2 points (limit 1.5) -> REJECT", code == 1 and "news: lost" in out, out)
    code, out = accept_case("c2", dict(good, news=[BASE[0] - 0.8, BASE[1] - 1.2, BASE[2] - 1.4, BASE[3] - 1.4]))
    check("accept: news loses 1.2 in the score and 0.8 after the space (inside the limits) -> ACCEPT", code == 0, out)
    code, out = accept_case("c3", dict(good, news=shifted(-1.2)))
    check("accept: news loses 1.2 in every rate: the rate after the space is over the 1.0 limit -> REJECT", code == 1 and "news: the rate after the space fell" in out, out)
    code, out = accept_case("d", dict(good, subs=shifted(-0.6)))
    check("accept: subtitles lose 0.6 (limit 0.5) -> REJECT", code == 1 and "subs: lost" in out, out)
    code, out = accept_case("d2", dict(good, subs=shifted(-0.4)))
    check("accept: subtitles lose 0.4 -> ACCEPT", code == 0, out)
    fall = {"real": [BASE[0] - 0.5, BASE[1] + 1.5, BASE[2] + 2.0, BASE[3] + 2.0]}
    code, out = accept_case("e", dict(good, **fall))
    check("accept: the score rises but the rate after the space falls on real messages -> REJECT", code == 1 and "fell" in out, out)
    code, out = accept_case("f", dict(good, real_b=shifted(-2.0)))
    check("accept: one independent real source clearly worse -> REJECT", code == 1 and "real_b" in out, out)
    code, out = accept_case("g", dict(good, tatoeba=[BASE[0] - 1.7, BASE[1] + 1.0, BASE[2] + 1.0, BASE[3] + 1.0]))
    check("accept: a hold-out loses more than its limit after the space even if its score is fine -> REJECT", code == 1 and "tatoeba: the rate after the space fell" in out, out)
    code, out = accept_case("g2", dict(good, tatoeba=[BASE[0] - 1.2, BASE[1] - 1.3, BASE[2] - 1.3, BASE[3] - 1.3]))
    check("accept: Tatoeba loses 1.3 (the measured price of cutting it from 25% to 10%) -> ACCEPT", code == 0, out)
    code, out = accept_case("g3", dict(good, subs=[BASE[0] - 0.7, BASE[1] + 0.9, BASE[2] + 0.9, BASE[3] + 0.9]))
    check("accept: subtitles lose 0.7 after the space (limit 0.5) even with a better score -> REJECT", code == 1 and "subs: the rate after the space fell" in out, out)
    code, out = accept_case("h", dict(good, dev=shifted(-5.0)))
    check("accept: the dev file is information only", code == 0, out)
    code, out = accept_case("i", good, old={"real": None})
    check("accept: no real-message result -> cannot decide (exit 2)", code == 2 and "CANNOT DECIDE" in out, out)
    # sizes
    big = os.path.join(T, "pack_big")
    os.makedirs(big, exist_ok=True)
    with open(os.path.join(big, "main.dict"), "wb") as f:
        f.truncate(12000001)
    code, out = accept_case("j", good, ["--pack-dir", big])
    check("accept: a pack folder over 12,000,000 bytes -> REJECT", code == 1 and "pack folder" in out, out)
    small = os.path.join(T, "pack_small")
    os.makedirs(small, exist_ok=True)
    with open(os.path.join(small, "main.dict"), "wb") as f:
        f.truncate(11092381)
    z = os.path.join(T, "pack.zip")
    with open(z, "wb") as f:
        f.truncate(7000001)
    code, out = accept_case("k", good, ["--pack-dir", small, "--zip", z])
    check("accept: a zip over 7,000,000 bytes -> REJECT, the folder inside the limit is not blamed", code == 1 and "zip" in out and "pack folder" not in out, out)
    code, out = accept_case("l", good, ["--pack-dir", small])
    check("accept: sizes inside the limits -> ACCEPT", code == 0, out)
    # a noisy test: a small gain on few words is not enough even if it is over 0.5
    od, nd = os.path.join(T, "acc_m_old"), os.path.join(T, "acc_m_new")
    for name in ["subs", "news", "tatoeba", "real"]:
        eval_file(od, name, BASE, n=300)
        eval_file(nd, name, shifted(0.8) if name == "real" else BASE, n=300)
    r = subprocess.run([sys.executable, "-I", ACCEPT, "--old", od, "--new", nd], capture_output=True, text=True)
    check("accept: +0.8 on 300 words is inside the noise -> REJECT (2 standard errors)", r.returncode == 1 and "standard errors" in r.stdout, r.stdout)
    r = subprocess.run([sys.executable, "-I", ACCEPT, "--rule"], capture_output=True, text=True)
    check("accept: --rule prints the rule", r.returncode == 0 and "Acceptance rule" in r.stdout and "12000000" in r.stdout)
    jp = os.path.join(T, "acc.json")
    accept_case("n", good, ["--json", jp])
    j = json.load(open(jp))
    check("accept: --json writes the verdict, the numbers and the rule", j["verdict"] == "accept" and "real" in j["tests"] and j["rule"]["real_min_gain"] == 0.5)


if __name__ == "__main__":
    workflow_tests()
    sampler_tests()
    prepare_tests()
    accept_tests()
    shutil.rmtree(T, ignore_errors=True)
    print("\n%d ok, %d fail" % (ok, fails))
    sys.exit(1 if fails else 0)
