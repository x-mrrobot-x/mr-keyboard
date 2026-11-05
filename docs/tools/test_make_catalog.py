#!/usr/bin/env python3
"""Tests make_catalog.py with fake dictionaries (no network, no key). Run it from the project root.

Covers the single release (--tag, --reuse): one zip per language, a serial that only goes up when something
changes, the release base address, a zip reused with the same bytes, and the errors (content changed without
raising the version, previous zip missing or tampered).
"""
import hashlib, json, os, shutil, subprocess, sys, tempfile

MC = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'make_catalog.py')
ok = fails = 0


def check(name, cond, extra=''):
    global ok, fails
    if cond:
        ok += 1; print('OK    ' + name)
    else:
        fails += 1; print('FAIL  ' + name + (' | ' + extra if extra else ''))


def pack(root, pid, version, content):
    d = os.path.join(root, pid); os.makedirs(d, exist_ok=True)
    json.dump({'id': pid, 'lang': pid.split('-')[0], 'name': {'en': pid}, 'version': version, 'format': 1,
               'minApp': 1, 'files': ['main.dict'], 'licenses': []}, open(os.path.join(d, 'pack.json'), 'w'))
    open(os.path.join(d, 'main.dict'), 'wb').write(bytes([200, 1]) + content)


def run(dicts, out, tag, prev=None, reuse=None):
    cmd = [sys.executable, '-I', MC, '--dicts', dicts, '--out', out, '--repo', 'owner/repo', '--now', '2026-10-31T00:00:00+00:00', '--tag', tag]
    if prev: cmd += ['--prev', prev]
    if reuse: cmd += ['--reuse', reuse]
    r = subprocess.run(cmd, capture_output=True, text=True)
    return r.returncode, r.stdout + r.stderr


def load_data(out):
    return json.load(open(os.path.join(out, 'data.json'), encoding='utf-8'))


def as_catalog(out, dest):
    """data.json in the format of the published catalog.json (make_catalog only reads the "data" field)."""
    json.dump({'data': open(os.path.join(out, 'data.json'), encoding='utf-8').read()}, open(dest, 'w'))


def zips(folder):
    return sorted(f for f in os.listdir(folder) if f.endswith('.zip'))


def sha(p):
    return hashlib.sha256(open(p, 'rb').read()).hexdigest()


T = tempfile.mkdtemp()
try:
    dicts = os.path.join(T, 'dicts')
    pack(dicts, 'pt-BR', 2, b'aaaa'); pack(dicts, 'en-US', 2, b'bbbb'); pack(dicts, 'es', 1, b'cccc')

    # ---------------- single release (--tag)
    o1 = os.path.join(T, 'o1')
    rc, _ = run(dicts, o1, tag='v1.73.0')
    d1 = load_data(o1)
    check('single, first time: works, serial 1, release base address', rc == 0 and d1['serial'] == 1 and d1['baseUrl'] == 'https://github.com/owner/repo/releases/download/v1.73.0/', str(d1.get('baseUrl')))
    check('single, first time: one zip per language', zips(o1) == ['en-US-2.zip', 'es-1.zip', 'pt-BR-2.zip'])
    check('single, first time: upload.txt lists all the zips', sorted(open(os.path.join(o1, 'upload.txt')).read().split()) == zips(o1))
    cat1 = os.path.join(T, 'cat1.json'); as_catalog(o1, cat1)

    o2 = os.path.join(T, 'o2')
    rc, output = run(dicts, o2, prev=cat1, tag='v1.74.0', reuse=o1)
    d2 = load_data(o2)
    check('nothing changed: serial kept and new base address', rc == 0 and d2['serial'] == 1 and d2['baseUrl'].endswith('/v1.74.0/'), str(d2['serial']))
    check('nothing changed: the zips go to the new release with the same bytes', zips(o2) == zips(o1) and all(sha(os.path.join(o1, z)) == sha(os.path.join(o2, z)) for z in zips(o1)))
    check('nothing changed: upload.txt still lists the 3 zips', sorted(open(os.path.join(o2, 'upload.txt')).read().split()) == zips(o2))
    cat2 = os.path.join(T, 'cat2.json'); as_catalog(o2, cat2)

    pack(dicts, 'pt-BR', 3, b'aaaaX')
    o3 = os.path.join(T, 'o3')
    os.makedirs(o3)
    open(os.path.join(o3, 'pt-BR-2.zip'), 'wb').write(b'leftover from a previous run')    # must disappear
    rc, _ = run(dicts, o3, prev=cat2, tag='v1.75.0', reuse=o2)
    d3 = load_data(o3)
    check('pt-BR v3: serial goes up to 2', rc == 0 and d3['serial'] == 2, str(d3.get('serial')))
    check('pt-BR v3: one zip per language (the pt-BR v2 does not go)', zips(o3) == ['en-US-2.zip', 'es-1.zip', 'pt-BR-3.zip'], str(zips(o3)))
    check('pt-BR v3: en-US and es reused with the same bytes', all(sha(os.path.join(o3, z)) == sha(os.path.join(o1, z)) for z in ('en-US-2.zip', 'es-1.zip')))
    check('pt-BR v3: the catalog lists only the current versions', sorted((p['id'], p['version']) for p in d3['packs']) == [('en-US', 2), ('es', 1), ('pt-BR', 3)])
    cat3 = os.path.join(T, 'cat3.json'); as_catalog(o3, cat3)

    shutil.rmtree(os.path.join(dicts, 'es'))
    o4 = os.path.join(T, 'o4')
    rc, _ = run(dicts, o4, prev=cat3, tag='v1.76.0', reuse=o3)
    check('language removed: serial goes up and the zip is gone', rc == 0 and load_data(o4)['serial'] == 3 and zips(o4) == ['en-US-2.zip', 'pt-BR-3.zip'])
    pack(dicts, 'es', 1, b'cccc')

    pack(dicts, 'en-US', 2, b'bbbbCHANGED')
    rc, output = run(dicts, os.path.join(T, 'o5'), prev=cat3, tag='v1.77.0', reuse=o3)
    check('content changed without raising the version: error', rc != 0 and 'raise' in output, output[-200:])
    pack(dicts, 'en-US', 2, b'bbbb')

    shutil.copytree(o3, os.path.join(T, 'o3b'))
    os.remove(os.path.join(T, 'o3b', 'es-1.zip'))
    rc, output = run(dicts, os.path.join(T, 'o6'), prev=cat3, tag='v1.77.0', reuse=os.path.join(T, 'o3b'))
    check('previous zip missing: clear error', rc != 0 and 'es-1.zip' in output, output[-200:])

    shutil.copytree(o3, os.path.join(T, 'o3c'))
    open(os.path.join(T, 'o3c', 'es-1.zip'), 'ab').write(b'x')
    rc, output = run(dicts, os.path.join(T, 'o7'), prev=cat3, tag='v1.77.0', reuse=os.path.join(T, 'o3c'))
    check('previous zip tampered with: error', rc != 0 and 'does not match' in output, output[-200:])

    rc, output = run(dicts, os.path.join(T, 'o8'), prev=cat3, tag='v1.77.0')
    check('equal pack without --reuse: error', rc != 0 and '--reuse' in output, output[-200:])
finally:
    shutil.rmtree(T, ignore_errors=True)

print('ALL OK (%d checks)' % ok if not fails else '%d FAILURE(S) out of %d checks' % (fails, ok + fails))
sys.exit(1 if fails else 0)
