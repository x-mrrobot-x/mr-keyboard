#!/usr/bin/env python3
"""Fixtures of ModelPackTest: catalogs that carry the weights of the gesture recognition (the "models" list, 1.96.0).

    python3 -I docs/tools/packs_test/make_model_fixtures.py <project root> <fx dir>

Everything starts from the real thing: make_catalog.py over a copy of dicts/pt-BR (version 2, as in make_fixtures.py) and of
gesture/ (version 1). The other folders change one thing at a time; each <fx>/<name>/ gets data.json and the zip of the model
when it has one of its own. sign_fixtures.py signs them all afterwards (it signs every folder of <fx> that has a data.json).
The serials go up in the order ModelPackTest fetches the catalogs (the app refuses a catalog older than one it has seen).

  m_ok        serial 1   pt-BR v2 and gesture v1, as published (the zip of the language is here too)
  m_badmagic  serial 2   gesture v2 whose encoder.bin does not start with MRSWENC1 (sizes and SHA-256 all consistent)
  m_nolicense serial 3   gesture v2 whose licence file has a few bytes
  m_extra     serial 4   gesture v2 with one more file inside the zip
  m_minapp    serial 5   gesture v2 that asks for an app newer than any
  m_format    serial 6   gesture v2 in a model format this app does not know
  m_v2        serial 7   gesture v2, good
  m_mixed     serial 8   "models" with an unknown id, an entry with fields missing, a repeat, and the good gesture v2
  m_notlist   serial 9   "models" that is not a list
  m_none      serial 10  no "models" at all (a catalog made without --model)
"""
import copy
import hashlib
import io
import json
import os
import shutil
import subprocess
import sys
import tempfile
import zipfile

B = sys.argv[1]
O = sys.argv[2]
NOW = '2026-11-11T12:00:00+00:00'
TAG = 'v1.96.0'
MC = os.path.join(B, 'docs/tools/make_catalog.py')

work = tempfile.mkdtemp()
os.makedirs(work + '/dicts')
shutil.copytree(B + '/dicts/pt-BR', work + '/dicts/pt-BR')
pj = work + '/dicts/pt-BR/pack.json'
meta = json.load(open(pj, encoding='utf-8'))
meta['version'] = 2
json.dump(meta, open(pj, 'w', encoding='utf-8'), ensure_ascii=False, indent=2)
shutil.copytree(B + '/gesture', work + '/gesture', ignore=shutil.ignore_patterns('test'))
gj = work + '/gesture/pack.json'
gmeta = json.load(open(gj, encoding='utf-8'))
gmeta['version'] = 1
json.dump(gmeta, open(gj, 'w', encoding='utf-8'), ensure_ascii=False, indent=2)

subprocess.run([sys.executable, '-I', MC, '--dicts', work + '/dicts', '--model', work + '/gesture', '--out', O + '/m_ok',
                '--tag', TAG, '--now', NOW], check=True, stdout=subprocess.DEVNULL)
base = json.load(open(O + '/m_ok/data.json', encoding='utf-8'))
assert base['serial'] == 1 and len(base['packs']) == 1 and len(base['models']) == 1, base.keys()
entry = base['models'][0]
zf = zipfile.ZipFile(O + '/m_ok/' + entry['url'])
contents = {i.filename: zf.read(i.filename) for i in zf.infolist()}
order = [i.filename for i in zf.infolist()]
assert order == ['pack.json', 'encoder.bin', 'LICENSE-FUTO-Model-Weights.md', 'NOTICE.txt'], order


def sha(b):
    return hashlib.sha256(b).hexdigest()


def mkzip(entries):
    b = io.BytesIO()
    with zipfile.ZipFile(b, 'w') as z:
        for n, d in entries:
            info = zipfile.ZipInfo(n, (1980, 1, 1, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            z.writestr(info, d)
    return b.getvalue()


def model_v2(change=None, extra=None, entry_change=None):
    """A gesture v2 entry and its zip. change: {file: new bytes}; extra: files added to the zip only; entry_change: fn(entry)."""
    files = dict(contents)
    m = json.loads(files['pack.json'].decode('utf-8'))
    m['version'] = 2
    files['pack.json'] = json.dumps(m, ensure_ascii=False, indent=2).encode('utf-8')
    files.update(change or {})
    e = copy.deepcopy(entry)
    e['version'] = 2
    e['url'] = 'mr-keyboard-model-gesture-2.zip'
    e['manifestSha256'] = sha(files['pack.json'])
    e['files'] = [{'name': n, 'size': len(files[n]), 'sha256': sha(files[n])} for n in order if n != 'pack.json']
    e['installedSize'] = sum(f['size'] for f in e['files'])
    zb = mkzip([(n, files[n]) for n in order] + list((extra or {}).items()))
    e['size'] = len(zb)
    e['sha256'] = sha(zb)
    if entry_change:
        entry_change(e)
    return e, zb


def write(name, serial, models, zips=None):
    d = copy.deepcopy(base)
    d['serial'] = serial
    if models is None:
        d.pop('models', None)
    else:
        d['models'] = models
    folder = os.path.join(O, name)
    os.makedirs(folder, exist_ok=True)
    open(folder + '/data.json', 'wb').write(json.dumps(d, ensure_ascii=False, indent=1).encode('utf-8'))
    for zn, zb in (zips or {}).items():
        open(folder + '/' + zn, 'wb').write(zb)


def variant(name, serial, **kw):
    e, zb = model_v2(**kw)
    write(name, serial, [e], {e['url']: zb})


variant('m_badmagic', 2, change={'encoder.bin': b'MRSWENC2' + contents['encoder.bin'][8:]})
variant('m_nolicense', 3, change={'LICENSE-FUTO-Model-Weights.md': b'see the web\n'})
variant('m_extra', 4, extra={'evil.txt': b'x'})
variant('m_minapp', 5, entry_change=lambda e: e.__setitem__('minApp', 9999999))
variant('m_format', 6, entry_change=lambda e: e.__setitem__('format', 2))
good, goodzip = model_v2()
write('m_v2', 7, [good], {good['url']: goodzip})
unknown = copy.deepcopy(good)
unknown['id'] = 'voice'
broken = copy.deepcopy(good)
del broken['sha256']
repeat = copy.deepcopy(good)
repeat['version'] = 9
write('m_mixed', 8, [unknown, broken, 'not an object', good, repeat], {good['url']: goodzip})
write('m_notlist', 9, 'gesture')
write('m_none', 10, None)
shutil.rmtree(work)
print('ok', sorted(n for n in os.listdir(O) if n.startswith('m_')))
