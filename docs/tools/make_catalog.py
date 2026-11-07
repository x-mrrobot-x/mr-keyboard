#!/usr/bin/env python3
"""Builds the dictionary packs (dicts/<id>/) and the catalog data, for the single release of a launch.

Called by publish_release.sh:
    python3 make_catalog.py --dicts dicts --out out --tag v1.82.0 [--prev catalog.json]
Each pack in the catalog says which release holds its zip ("release", a tag like v1.82.0); the app builds the
address from a constant + that tag + the zip name. A zip only goes in the release where its language changed:
a pack equal to the previous catalog keeps its old entry (and the old "release") and no zip is built or
copied; a new or changed pack gets a new zip in --out and "release" = --tag. The serial only goes up if some
pack changed; otherwise it stays the one of the previous catalog (the app accepts an equal serial, it only
refuses a lower one).

For each folder dicts/<id>/ with a pack.json:
  - checks the manifest and the files (dictionary header, two-word file, UTF-8 of the rules);
  - if the previous catalog (--prev) already has this id at the same version with the same files, reuses the entry;
  - if the version is new, builds mr-keyboard-dict-<id>-<version>.zip, always identical for the same content;
  - if the content changed and the version did not, stops with an error (raise "version" in pack.json).

Output in --out:
  data.json    what gets signed (exact bytes)
  upload.txt   zips to attach to this release, one per line (only the new ones; may be empty)
  mr-keyboard-dict-<id>-<v>.zip   the new zips
"""
import argparse
import datetime
import hashlib
import json
import os
import re
import shutil
import sys
import zipfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import mrt_format  # noqa: E402

FORMAT = 1                 # catalog format
PACK_FORMATS = {1, 2}      # pack formats this script knows how to build: 1 = main.dict v1, 2 = main.dict v2 (1.86, minApp 1086000)
NAME_RE = re.compile(r"^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$")
TAG_RE = re.compile(r"^v[0-9]+\.[0-9]+\.[0-9]+$")      # the same rule the app applies to "release"
ZIP_PREFIX = "mr-keyboard-dict-"                        # makes clear in the asset list that it is a dictionary
ID_RE = re.compile(r"^[a-z]{2,3}(-[A-Z]{2})?$")
ZIP_TIME = (1980, 1, 1, 0, 0, 0)
MAX_FILE = 16 * 1024 * 1024
DICT_MAX = {1: 4194304,    # 22-bit address of the dictionary format v1
            2: 16777216}   # format v2 (one more byte per address; the limit is a policy, see docs/suggestion-features.md, "Dictionary format v2")
V2_MIN_APP = 1086000       # the first app that reads the dictionary format v2
MRT2_MIN_APP = 1090000     # the first app that reads trigrams.bin in the MRT2 layout (1.90.0)


def fail(msg):
    print("::error::" + msg)
    sys.exit(1)


def sha256(data):
    return hashlib.sha256(data).hexdigest()


def check_file(pid, name, data, fmt=1, min_app=0):
    if len(data) == 0 or len(data) > MAX_FILE:
        fail("%s/%s: invalid size (%d bytes)" % (pid, name, len(data)))
    if name.endswith(".dict"):
        if len(data) > DICT_MAX[fmt]:
            fail("%s/%s: over the format limit (%d > %d bytes)" % (pid, name, len(data), DICT_MAX[fmt]))
        # the header says which dictionary format the file is in; pack.json "format" must say the same, because an app
        # that does not know v2 decides by that field alone (it refuses the pack) and would otherwise read v2 as garbage
        if data[0] != 200 or data[1] != fmt:
            fail("%s/%s: dictionary header %s, but pack.json has format %d (it must be [200,%d])"
                 % (pid, name, list(data[:2]), fmt, fmt))
    elif name == "trigrams.bin":
        if data[:4] not in (b"MRT1", b"MRT2"):
            fail("%s/%s: does not start with MRT1 or MRT2" % (pid, name))
        if data[:4] == b"MRT2":
            # an app older than 1.90 would read MRT2 as garbage (it would refuse the file: no two-word prediction), so the pack must say so
            if not isinstance(min_app, int) or min_app < MRT2_MIN_APP:
                fail("%s/%s: a pack with MRT2 trigrams needs minApp >= %d (the first app that reads it)" % (pid, name, MRT2_MIN_APP))
            try:
                mrt_format.read2(data)   # strict reader, written apart from the one in the app
            except ValueError as e:
                fail("%s/%s: invalid MRT2 (%s)" % (pid, name, e))
    elif name.endswith(".txt"):
        try:
            data.decode("utf-8")
        except UnicodeDecodeError:
            fail("%s/%s: not UTF-8" % (pid, name))


def read_pack(dicts, pid):
    folder = os.path.join(dicts, pid)
    with open(os.path.join(folder, "pack.json"), "rb") as f:
        raw = f.read()
    try:
        m = json.loads(raw.decode("utf-8"))
    except ValueError as e:
        fail("%s/pack.json invalid: %s" % (pid, e))
    for key in ("id", "lang", "name", "version", "format", "minApp", "files", "licenses"):
        if key not in m:
            fail("%s/pack.json is missing the field %s" % (pid, key))
    if m["id"] != pid or not ID_RE.match(pid):
        fail("%s: id in pack.json (%s) must equal the folder name, e.g. pt-BR" % (pid, m["id"]))
    if not isinstance(m["version"], int) or m["version"] < 1:
        fail("%s: version must be an integer >= 1" % pid)
    if m["format"] not in PACK_FORMATS:
        fail("%s: unknown format %r" % (pid, m["format"]))
    if m["format"] == 2 and (not isinstance(m["minApp"], int) or m["minApp"] < V2_MIN_APP):
        fail("%s: a pack in format 2 needs minApp >= %d (the first app that reads it)" % (pid, V2_MIN_APP))
    if not isinstance(m["name"], dict) or "en" not in m["name"]:
        fail("%s: name needs at least the English text (en)" % pid)
    files = m["files"]
    if not files or len(set(files)) != len(files):
        fail("%s: files list empty or with repeats" % pid)
    if "main.dict" not in files:
        fail("%s: the pack needs main.dict (the app looks for that name)" % pid)
    out = []
    for name in files:
        if not NAME_RE.match(name) or name == "pack.json":
            fail("%s: invalid file name: %r" % (pid, name))
        path = os.path.join(folder, name)
        if not os.path.isfile(path):
            fail("%s: file %s is missing" % (pid, name))
        with open(path, "rb") as f:
            data = f.read()
        check_file(pid, name, data, m["format"], m["minApp"])
        out.append((name, data))
    extra = sorted(set(os.listdir(folder)) - set(files) - {"pack.json"})
    if extra:
        print("warning: %s: files outside the files list (they do not go in the pack): %s" % (pid, ", ".join(extra)))
    return m, raw, out


def make_zip(path, manifest_raw, files):
    with zipfile.ZipFile(path, "w") as z:
        for name, data in [("pack.json", manifest_raw)] + files:
            info = zipfile.ZipInfo(name, ZIP_TIME)
            info.compress_type = zipfile.ZIP_DEFLATED
            info.create_system = 3
            info.external_attr = 0o644 << 16
            z.writestr(info, data, compresslevel=9)


def load_prev(path):
    if not path or not os.path.isfile(path):
        return None
    with open(path, "rb") as f:
        env = json.loads(f.read().decode("utf-8"))
    data = json.loads(env["data"])
    if data.get("format") != FORMAT:
        fail("published catalog has format %r; this script generates %d" % (data.get("format"), FORMAT))
    return data


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dicts", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--prev", help="catalog.json published before (if any)")
    ap.add_argument("--now", help="fixed date (for tests), ISO 8601")
    ap.add_argument("--tag", required=True, help="tag of the release being made; the new zips go in it (e.g. v1.82.0)")
    a = ap.parse_args()
    if not TAG_RE.match(a.tag):
        fail("--tag must look like v1.82.0 (it is %r)" % a.tag)

    prev = load_prev(a.prev)
    prev_packs = {p["id"]: p for p in prev["packs"]} if prev else {}
    os.makedirs(a.out, exist_ok=True)

    ids = sorted(d for d in os.listdir(a.dicts)
                 if os.path.isfile(os.path.join(a.dicts, d, "pack.json")))
    if not ids:
        fail("no pack in %s" % a.dicts)

    packs, new_zips = [], []
    for pid in ids:
        m, raw, files = read_pack(a.dicts, pid)
        file_entries = [{"name": n, "size": len(d), "sha256": sha256(d)} for n, d in files]
        old = prev_packs.get(pid)
        if old and old["version"] > m["version"]:
            fail("%s: version %d is lower than the published one (%d)" % (pid, m["version"], old["version"]))
        if old and old["version"] == m["version"]:
            same = old["files"] == file_entries and old.get("manifestSha256") == sha256(raw)
            if not same:
                fail("%s: the content changed but the version is still %d; raise \"version\" in dicts/%s/pack.json"
                     % (pid, m["version"], pid))
            if not TAG_RE.match(str(old.get("release", ""))):
                fail("%s: the previous catalog has no valid \"release\" for this pack (old catalog format?)" % pid)
            packs.append(old)
            print("%s v%d: same as published (zip in %s)" % (pid, m["version"], old["release"]))
            continue
        zname = "%s%s-%d.zip" % (ZIP_PREFIX, pid, m["version"])
        if not NAME_RE.match(zname):
            fail("%s: invalid zip name: %r" % (pid, zname))
        zpath = os.path.join(a.out, zname)
        make_zip(zpath, raw, files)
        with open(zpath, "rb") as f:
            zdata = f.read()
        entry = {
            "id": pid,
            "lang": m["lang"],
            "region": m.get("region", ""),
            "name": m["name"],
            "description": m.get("description", {}),
            "version": m["version"],
            "format": m["format"],
            "minApp": m["minApp"],
            "release": a.tag,
            "url": zname,
            "size": len(zdata),
            "sha256": sha256(zdata),
            "installedSize": sum(e["size"] for e in file_entries),
            "manifestSha256": sha256(raw),
            "files": file_entries,
            "licenses": m["licenses"],
            "credits": m.get("credits", ""),
        }
        packs.append(entry)
        new_zips.append(zname)
        print("%s v%d: new, %s (%d bytes, %d installed)" % (pid, m["version"], zname, len(zdata),
                                                              entry["installedSize"]))

    # only the zips made now stay in the folder that goes to the release (nothing left over from an earlier run)
    for f in os.listdir(a.out):
        if f.endswith(".zip") and f not in new_zips:
            os.remove(os.path.join(a.out, f))
    with open(os.path.join(a.out, "upload.txt"), "w") as f:
        f.write("".join(z + "\n" for z in new_zips))
    changed = bool(new_zips) or not prev or [p["id"] for p in prev["packs"]] != ids

    now = a.now or datetime.datetime.now(datetime.timezone.utc).replace(microsecond=0).isoformat()
    if prev:
        serial = prev["serial"] + 1 if changed else prev["serial"]
    else:
        serial = 1
    data = {
        "format": FORMAT,
        "serial": serial,
        "generated": now,
        "packs": packs,
    }
    with open(os.path.join(a.out, "data.json"), "wb") as f:
        f.write(json.dumps(data, ensure_ascii=False, indent=1).encode("utf-8"))
    print("catalog: serial %d, %d pack(s)%s" % (data["serial"], len(packs), "" if changed else " (nothing changed: serial kept)"))


if __name__ == "__main__":
    main()
