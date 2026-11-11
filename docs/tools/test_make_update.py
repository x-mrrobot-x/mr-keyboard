#!/usr/bin/env python3
"""Tests make_update.py (the data of update.json) with a fake APK and fake notes. Run it from the project root.

Covers the content (version, size and SHA-256 of the APK, notes of both languages, UTF-8), the same bytes for the same
input, the blocks in any order and with CRLF, and every error that must stop a release: tag different from the
version, versionCode out of the formula, wrong APK name, missing/empty/repeated/too long notes. It also runs the
script on the real project notes, which must fit the limit.
"""
import hashlib, json, os, subprocess, sys, tempfile

MU = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'make_update.py')
ROOT = os.getcwd()
ok = fails = 0


def check(name, cond, extra=''):
    global ok, fails
    if cond:
        ok += 1; print('OK    ' + name)
    else:
        fails += 1; print('FAIL  ' + name + (' | ' + extra if extra else ''))


T = tempfile.mkdtemp()
NOTES = '**Português**\n- Corrige o fechamento do app.\n- Novo: **ação** em `Ajustes`.\n\n**English**\n- Fixes the app closing.\n'


def setup(tag='v1.82.0', code=1082000, notes=NOTES, apk=b'APKBYTES', apk_name=None):
    d = tempfile.mkdtemp(dir=T)
    open(os.path.join(d, 'apktool.yml'), 'w').write("versionInfo:\n  versionCode: '%d'\n  versionName: %s\n" % (code, tag))
    open(os.path.join(d, 'notes.md'), 'wb').write(notes.encode('utf-8'))
    apk_path = os.path.join(d, apk_name or 'mr-keyboard-%s.apk' % tag)
    if apk is not None:
        open(apk_path, 'wb').write(apk)
    return d, apk_path


def run(d, apk_path, tag='v1.82.0', extra=None):
    out = os.path.join(d, 'update-data.json')
    cmd = [sys.executable, '-I', MU, '--apk', apk_path, '--tag', tag, '--notes', os.path.join(d, 'notes.md'),
           '--apktool', os.path.join(d, 'apktool.yml'), '--out', out, '--now', '2026-11-05T03:00:00+00:00'] + (extra or [])
    r = subprocess.run(cmd, capture_output=True, text=True)
    data = json.load(open(out, encoding='utf-8')) if r.returncode == 0 else None
    return r.returncode, r.stdout + r.stderr, data, out


# ---- content
d, apk = setup()
rc, msg, data, out = run(d, apk)
check('normal: runs and the data has the expected fields', rc == 0 and data and sorted(data) == ['apk', 'format', 'generated', 'notes', 'versionCode', 'versionName'], msg)
check('normal: version, code and date', data['versionName'] == 'v1.82.0' and data['versionCode'] == 1082000 and data['generated'] == '2026-11-05T03:00:00+00:00' and data['format'] == 1)
check('normal: APK name, size and SHA-256 are the file\'s', data['apk'] == {'name': 'mr-keyboard-v1.82.0.apk', 'size': 8, 'sha256': hashlib.sha256(b'APKBYTES').hexdigest()}, str(data['apk']))
check('normal: notes of the two blocks, as written, with accents', data['notes'] == {'pt-BR': '- Corrige o fechamento do app.\n- Novo: **ação** em `Ajustes`.', 'en': '- Fixes the app closing.'}, str(data['notes']))
check('normal: UTF-8 written as is (no \\u escapes) and no link in the file', b'\\u' not in open(out, 'rb').read() and 'http' not in open(out, encoding='utf-8').read())
# apktool 2.11 writes the code bare (versionCode: 1082000), older ones quoted: both are read
d2, apk2 = setup()
y = os.path.join(d2, 'apktool.yml')
open(y, 'w').write("versionInfo:\n  versionCode: 1082000\n  versionName: v1.82.0\n")
rc, msg, data2, out2 = run(d2, apk2)
check('apktool.yml with the code without quotes (apktool 2.11): accepted', rc == 0 and data2 and data2['versionCode'] == 1082000, msg)
a1 = open(out, 'rb').read()
rc, msg, data, out = run(d, apk)
check('same input, same bytes', open(out, 'rb').read() == a1)

# ---- blocks in the other order, CRLF, text before the first block
d, apk = setup(notes='Cabeçalho solto\n\n**English**\n- Only English line.\n\n**Português**\n- Só uma linha.\n')
rc, msg, data, _ = run(d, apk)
check('blocks in the other order and text before the first block (ignored)', rc == 0 and data['notes'] == {'pt-BR': '- Só uma linha.', 'en': '- Only English line.'}, msg)
d, apk = setup(notes=NOTES.replace('\n', '\r\n'))
rc, msg, data, _ = run(d, apk)
check('CRLF notes: same text, no \\r in it', rc == 0 and '\r' not in json.dumps(data['notes']) and data['notes']['en'] == '- Fixes the app closing.', msg)

# ---- notes errors
d, apk = setup(notes='**Português**\n- Só português.\n')
rc, msg, data, _ = run(d, apk)
check('no English block: error naming the block', rc != 0 and '**English**' in msg, msg)
d, apk = setup(notes='**English**\n- Only.\n')
rc, msg, data, _ = run(d, apk)
check('no Português block: error naming the block', rc != 0 and 'Português' in msg, msg)
d, apk = setup(notes='**Português**\n\n\n**English**\n- Text.\n')
rc, msg, data, _ = run(d, apk)
check('empty block: error', rc != 0 and 'empty' in msg, msg)
d, apk = setup(notes=NOTES + '\n**English**\n- Again.\n')
rc, msg, data, _ = run(d, apk)
check('repeated block: error', rc != 0 and 'two' in msg, msg)
d, apk = setup(notes='**Português**\n' + 'x' * 4000 + '\n\n**English**\n- Text.\n')
rc, msg, data, _ = run(d, apk)
check('4000 characters in a block: accepted (the limit)', rc == 0, msg)
d, apk = setup(notes='**Português**\n' + 'x' * 4001 + '\n\n**English**\n- Text.\n')
rc, msg, data, _ = run(d, apk)
check('4001 characters in a block: error', rc != 0 and '4001' in msg, msg)
d, apk = setup()
os.remove(os.path.join(d, 'notes.md'))
rc, msg, data, _ = run(d, apk)
check('notes file missing: error', rc != 0 and 'notes not found' in msg, msg)

# ---- version errors
d, apk = setup(tag='v1.81.0', code=1081000)
rc, msg, data, _ = run(d, apk, tag='v1.82.0')
check('tag different from the versionName: error', rc != 0 and 'v1.81.0' in msg and 'v1.82.0' in msg, msg)
d, apk = setup(code=1082001)
rc, msg, data, _ = run(d, apk)
check('versionCode out of the formula: error with the expected value', rc != 0 and '1082000' in msg, msg)
d, apk = setup()
rc, msg, data, _ = run(d, apk, tag='1.82.0')
check('invalid tag (no v): error', rc != 0 and 'invalid --tag' in msg, msg)
d, apk = setup(tag='v2.0.10', code=2000010)
rc, msg, data, _ = run(d, apk, tag='v2.0.10')
check('code formula with other numbers (v2.0.10 -> 2000010)', rc == 0 and data['versionCode'] == 2000010, msg)

# ---- APK errors
d, apk = setup(apk_name='MrKeyboard.apk')
rc, msg, data, _ = run(d, apk)
check('APK with another name: error saying the expected name', rc != 0 and 'mr-keyboard-v1.82.0.apk' in msg, msg)
d, apk = setup(apk=None)
rc, msg, data, _ = run(d, apk)
check('APK missing: error', rc != 0 and 'not found' in msg, msg)
d, apk = setup(apk=b'')
rc, msg, data, _ = run(d, apk)
check('empty APK: error', rc != 0, msg)

# ---- the real project: its current notes must be accepted
yml = open(os.path.join(ROOT, 'apktool.yml'), encoding='utf-8').read()
import re
tag = re.search(r"versionName:\s*['\"]?(v[0-9.]+)", yml).group(1)
d = tempfile.mkdtemp(dir=T)
apk = os.path.join(d, 'mr-keyboard-%s.apk' % tag); open(apk, 'wb').write(b'x')
out = os.path.join(d, 'u.json')
r = subprocess.run([sys.executable, '-I', MU, '--apk', apk, '--tag', tag, '--notes', os.path.join(ROOT, 'docs/release-notes/%s.md' % tag),
                    '--apktool', os.path.join(ROOT, 'apktool.yml'), '--out', out], capture_output=True, text=True)
check('real project (%s): the notes in docs/release-notes are accepted' % tag, r.returncode == 0, r.stdout + r.stderr)

import shutil; shutil.rmtree(T, ignore_errors=True)
if fails == 0:
    print('ALL OK (%d checks)' % ok)
else:
    print('%d FAILURE(S) out of %d checks' % (fails, ok + fails)); sys.exit(1)
