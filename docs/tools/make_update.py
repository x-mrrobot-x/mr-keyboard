#!/usr/bin/env python3
"""Builds the data of update.json, the notice the app reads to learn that a new version is out.

  python3 docs/tools/make_update.py --apk mr-keyboard-v1.82.0.apk --tag v1.82.0 \\
      --notes docs/release-notes/v1.82.0.md --apktool apktool.yml --out out/update-data.json [--now ISO]

publish_release.sh then signs it with the APK key (sign_catalog.sh ... update) and attaches the result as update.json.
The app reads .../releases/latest/download/update.json, checks the signature, and only offers a versionCode higher
than the installed one. The download link is NOT in the file: the app builds it from its own constants (the release
tag + the apk name below), so the file cannot send anybody to another address.

Content (format 1):
  versionCode, versionName   from apktool.yml; the tag must be the versionName and the code must be
                             major*1000000 + minor*1000 + patch (v1.82.0 -> 1082000)
  generated                  UTC time of the release
  apk.name / size / sha256   mr-keyboard-<tag>.apk, its size in bytes and its SHA-256; the app checks both after downloading
  notes.pt-BR / notes.en     the text of the **Português** and **English** blocks of docs/release-notes/<tag>.md, as
                             written (Markdown: "- " items, **bold**, `code`); the app shows English when the
                             phone is in a language with no block

Fails (exit 1, message on stderr) if the tag, version, APK name or notes do not fit, so a broken notice is never published.
"""
import argparse, datetime, hashlib, json, os, re, sys

TAG_RE = re.compile(r'^v([0-9]+)\.([0-9]+)\.([0-9]+)$')
FORMAT = 1
NOTES_MAX = 4000    # characters per language: the notice stays small and the dialog stays readable
BLOCKS = (('pt-BR', '**Português**'), ('en', '**English**'))


def fail(msg):
    sys.exit('make_update: ' + msg)


def read_version(path):
    yml = open(path, encoding='utf-8').read()
    n = re.search(r"^\s*versionName:\s*['\"]?(v?[0-9.]+)", yml, re.M)
    c = re.search(r"^\s*versionCode:\s*['\"]?(\d+)", yml, re.M)
    if not n or not c:
        fail('%s has no versionName/versionCode' % path)
    return n.group(1), int(c.group(1))


def split_notes(text):
    """{'pt-BR': ..., 'en': ...} from the lines **Português** and **English** (each alone on its line)."""
    marks = {}
    lines = text.replace('\r\n', '\n').split('\n')
    for i, line in enumerate(lines):
        for lang, marker in BLOCKS:
            if line.strip() == marker:
                if lang in marks:
                    fail('the notes have two %s blocks' % marker)
                marks[lang] = i
    out = {}
    for lang, marker in BLOCKS:
        if lang not in marks:
            fail('the notes have no %s block' % marker)
        start = marks[lang] + 1
        later = [i for i in marks.values() if i > marks[lang]]
        end = min(later) if later else len(lines)
        body = '\n'.join(lines[start:end]).strip()
        if not body:
            fail('the %s block is empty' % marker)
        if len(body) > NOTES_MAX:
            fail('the %s block has %d characters (the limit is %d)' % (marker, len(body), NOTES_MAX))
        out[lang] = body
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--apk', required=True, help='the signed APK, named mr-keyboard-<tag>.apk')
    ap.add_argument('--tag', required=True, help='tag of the release (e.g. v1.82.0)')
    ap.add_argument('--notes', required=True, help='docs/release-notes/<tag>.md')
    ap.add_argument('--apktool', default='apktool.yml')
    ap.add_argument('--out', required=True, help='where to write the data (JSON)')
    ap.add_argument('--now', help='fixed time (for tests), ISO 8601')
    a = ap.parse_args()

    m = TAG_RE.match(a.tag)
    if not m:
        fail('invalid --tag %r (expected v<major>.<minor>.<patch>)' % a.tag)
    major, minor, patch = (int(x) for x in m.groups())
    name, code = read_version(a.apktool)
    if name != a.tag:
        fail('%s says versionName %s, but the tag is %s' % (a.apktool, name, a.tag))
    expected = major * 1000000 + minor * 1000 + patch
    if code != expected:
        fail('versionCode %d does not match %s (expected %d)' % (code, a.tag, expected))

    apk_name = 'mr-keyboard-%s.apk' % a.tag
    if os.path.basename(a.apk) != apk_name:
        fail('the APK must be named %s (it is %s)' % (apk_name, os.path.basename(a.apk)))
    if not os.path.isfile(a.apk) or os.path.getsize(a.apk) == 0:
        fail('APK not found or empty: %s' % a.apk)
    apk = open(a.apk, 'rb').read()

    if not os.path.isfile(a.notes):
        fail('notes not found: %s' % a.notes)
    notes = split_notes(open(a.notes, encoding='utf-8').read())

    now = a.now or datetime.datetime.now(datetime.timezone.utc).replace(microsecond=0).isoformat()
    data = {
        'format': FORMAT,
        'versionCode': code,
        'versionName': a.tag,
        'generated': now,
        'apk': {'name': apk_name, 'size': len(apk), 'sha256': hashlib.sha256(apk).hexdigest()},
        'notes': notes,
    }
    with open(a.out, 'wb') as f:
        f.write(json.dumps(data, ensure_ascii=False, indent=1).encode('utf-8'))
    print('update notice: %s (code %d), %s %d bytes, notes %d + %d characters'
          % (a.tag, code, apk_name, len(apk), len(notes['pt-BR']), len(notes['en'])))


main()
