#!/usr/bin/env python3
"""Tests make_update.py (the data of update.json) with a fake APK and fake notes. Run it from the project root.

Covers the content (version, size and SHA-256 of the APK, notes of both languages and the optional Spanish block, UTF-8), the text of the Release
(--release-text: the notes without the Spanish block), the same bytes for the same
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

# ---- the Spanish block (optional, in the same file): notes.es in the data; never in the text of the Release
NOTES_ES = NOTES + '\n**Español**\n- Corrige el cierre de la app.\n- Nuevo: **acción** en `Ajustes`.\n'
d, apk = setup(notes=NOTES_ES)
rc, msg, data, _ = run(d, apk)
check('Spanish block: notes.es as written, with accents, next to the other two',
      rc == 0 and data['notes'] == {'pt-BR': '- Corrige o fechamento do app.\n- Novo: **ação** em `Ajustes`.', 'en': '- Fixes the app closing.',
                                    'es': '- Corrige el cierre de la app.\n- Nuevo: **acción** en `Ajustes`.'}, str(data and data['notes']))
check('Spanish block: the message counts the three blocks', rc == 0 and msg.count(' + ') == 2, msg)
d, apk = setup()
rc, msg, data, _ = run(d, apk)
check('no Spanish block: no notes.es (it is optional)', rc == 0 and 'es' not in data['notes'], str(data and data['notes']))
d, apk = setup(notes='**Español**\n- Primero.\n\n**Português**\n- Um.\n\n**English**\n- One.\n')
rc, msg, data, _ = run(d, apk)
check('Spanish block first: each block ends at the next mark, in any order',
      rc == 0 and data['notes'] == {'es': '- Primero.', 'pt-BR': '- Um.', 'en': '- One.'}, str(data and data['notes']))
d, apk = setup(notes=NOTES + '\n**Español**\n\n')
rc, msg, data, _ = run(d, apk)
check('empty Spanish block: error', rc != 0 and 'empty' in msg and '**Español**' in msg, msg)
d, apk = setup(notes=NOTES + '\n**Español**\n' + 'x' * 4001 + '\n')
rc, msg, data, _ = run(d, apk)
check('Spanish block over the limit: error', rc != 0 and '4001' in msg, msg)
d, apk = setup(notes=NOTES_ES + '\n**Español**\n- Otra vez.\n')
rc, msg, data, _ = run(d, apk)
check('repeated Spanish block: error', rc != 0 and 'two' in msg and '**Español**' in msg, msg)
d, apk = setup(notes=NOTES_ES.replace('\n', '\r\n'))
rc, msg, data, _ = run(d, apk)
check('Spanish block with CRLF: no \\r in it', rc == 0 and '\r' not in data['notes']['es'], msg)
d, apk = setup(notes='**Português**\n- Só.\n\n**Español**\n- Solo.\n')
rc, msg, data, _ = run(d, apk)
check('Spanish block does not replace the missing English block (still an error)', rc != 0 and '**English**' in msg, msg)


def release_text(d, notes_bytes=None):
    path = os.path.join(d, 'notes.md')
    if notes_bytes is not None:
        open(path, 'wb').write(notes_bytes)
    r = subprocess.run([sys.executable, '-I', MU, '--release-text', path], capture_output=True)
    return r.returncode, r.stdout.decode('utf-8'), r.stderr.decode('utf-8')


d, apk = setup(notes=NOTES_ES)
rc, out, err = release_text(d)
check('release text: the notes without the Spanish block, nothing else changed', rc == 0 and out == NOTES + '\n', repr(out) + err)
check('release text: no **Español**, no Spanish line', '**Español**' not in out and 'cierre' not in out and 'acción' not in out)
rc, out, err = release_text(d, NOTES.encode('utf-8'))
check('release text: notes with no Spanish block come out exactly as they are', rc == 0 and out == NOTES, repr(out))
rc, out, err = release_text(d, NOTES.replace('\n', '\r\n').encode('utf-8'))
check('release text: CRLF is kept as it is', rc == 0 and out == NOTES.replace('\n', '\r\n'), repr(out))
rc, out, err = release_text(d, ('**Español**\n- Primero.\n\n' + NOTES).encode('utf-8'))
check('release text: Spanish block first: it goes away up to the next block and the others stay', rc == 0 and out == NOTES, repr(out))
mid = '**Português**\n- Um.\n\n**Español**\n- Dos.\n- Tres.\n\n**English**\n- One.\n'
rc, out, err = release_text(d, mid.encode('utf-8'))
check('release text: Spanish block between the two: both stay, the Spanish lines go', rc == 0 and out == '**Português**\n- Um.\n\n**English**\n- One.\n', repr(out))
rc, out, err = release_text(d, ('# v9.9.9\n\n' + NOTES_ES).encode('utf-8'))
check('release text: the text before the first block stays', rc == 0 and out.startswith('# v9.9.9\n\n**Português**') and 'Español' not in out, repr(out))
rc, out, err = release_text(d, b'**Portugu\xc3\xaas**\n- So pt.\n')
check('release text: notes without the English block: error, nothing printed', rc != 0 and out == '' and '**English**' in err, err)
rc, out, err = release_text(os.path.join(d, 'nada'))
check('release text: notes file missing: error', rc != 0 and out == '' and 'not found' in err, err)
r = subprocess.run([sys.executable, '-I', MU, '--tag', 'v1.82.0'], capture_output=True, text=True)
check('without --release-text the options of the update notice are still required', r.returncode != 0 and '--apk is required' in r.stderr, r.stderr)

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
real_notes = os.path.join(ROOT, 'docs/release-notes/%s.md' % tag)
got = json.load(open(out, encoding='utf-8'))['notes'] if r.returncode == 0 else {}
rt = subprocess.run([sys.executable, '-I', MU, '--release-text', real_notes], capture_output=True)
check('real project (%s): the text of the Release has no Spanish block, and it keeps both languages' % tag,
      rt.returncode == 0 and '**Español**' not in rt.stdout.decode('utf-8') and '**Português**' in rt.stdout.decode('utf-8') and '**English**' in rt.stdout.decode('utf-8'),
      rt.stderr.decode('utf-8'))
if '**Español**' in open(real_notes, encoding='utf-8').read():
    check('real project (%s): the Spanish notes are in the data and fit the limit' % tag, 0 < len(got.get('es', '')) <= 4000, str(sorted(got)))

import shutil; shutil.rmtree(T, ignore_errors=True)
if fails == 0:
    print('ALL OK (%d checks)' % ok)
else:
    print('%d FAILURE(S) out of %d checks' % (fails, ok + fails)); sys.exit(1)
