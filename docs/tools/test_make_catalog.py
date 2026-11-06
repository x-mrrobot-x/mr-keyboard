#!/usr/bin/env python3
"""Tests make_catalog.py with fake dictionaries (no network, no key). Run it from the project root.

Covers the "release" field (the tag that holds each pack's zip): a zip only goes in the release where its
language changed, an unchanged pack keeps its old entry and builds no zip, a serial that only goes up when
something changes, the zip name (mr-keyboard-dict-<id>-<version>.zip), the zip being the same bytes for the same
content, and the errors (content changed without raising the version, lower version, invalid tag, previous
catalog without "release").
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


def pack(root, pid, version, content, fmt=1, min_app=1, header=None):
    d = os.path.join(root, pid); os.makedirs(d, exist_ok=True)
    json.dump({'id': pid, 'lang': pid.split('-')[0], 'name': {'en': pid}, 'version': version, 'format': fmt,
               'minApp': min_app, 'files': ['main.dict'], 'licenses': []}, open(os.path.join(d, 'pack.json'), 'w'))
    open(os.path.join(d, 'main.dict'), 'wb').write(bytes(header or [200, fmt]) + content)


def run(dicts, out, tag, prev=None):
    cmd = [sys.executable, '-I', MC, '--dicts', dicts, '--out', out, '--now', '2026-10-31T00:00:00+00:00', '--tag', tag]
    if prev: cmd += ['--prev', prev]
    r = subprocess.run(cmd, capture_output=True, text=True)
    return r.returncode, r.stdout + r.stderr


def load_data(out):
    return json.load(open(os.path.join(out, 'data.json'), encoding='utf-8'))


def as_catalog(out, dest):
    """data.json in the format of the published catalog.json (make_catalog only reads the "data" field)."""
    json.dump({'data': open(os.path.join(out, 'data.json'), encoding='utf-8').read()}, open(dest, 'w'))


def zips(folder):
    return sorted(f for f in os.listdir(folder) if f.endswith('.zip'))


def uploads(folder):
    return sorted(open(os.path.join(folder, 'upload.txt')).read().split())


def sha(p):
    return hashlib.sha256(open(p, 'rb').read()).hexdigest()


def rel(data):
    return {p['id']: p['release'] for p in data['packs']}


P = 'mr-keyboard-dict-'
T = tempfile.mkdtemp()
try:
    dicts = os.path.join(T, 'dicts')
    pack(dicts, 'pt-BR', 2, b'aaaa'); pack(dicts, 'en-US', 2, b'bbbb'); pack(dicts, 'es', 1, b'cccc')

    # ---------------- first release: no previous catalog
    o1 = os.path.join(T, 'o1')
    rc, out1 = run(dicts, o1, tag='v1.73.0')
    d1 = load_data(o1)
    check('first time: works, serial 1, no global address in the catalog', rc == 0 and d1['serial'] == 1 and 'baseUrl' not in d1, out1[-200:])
    check('first time: every pack says it is in this release', rel(d1) == {'en-US': 'v1.73.0', 'es': 'v1.73.0', 'pt-BR': 'v1.73.0'}, str(rel(d1)))
    expected = [P + 'en-US-2.zip', P + 'es-1.zip', P + 'pt-BR-2.zip']
    check('first time: one zip per language, with the dictionary prefix in the name', zips(o1) == expected, str(zips(o1)))
    check('first time: "url" is the zip name', sorted(p['url'] for p in d1['packs']) == expected)
    check('first time: upload.txt lists all the zips', uploads(o1) == zips(o1))
    cat1 = os.path.join(T, 'cat1.json'); as_catalog(o1, cat1)

    o1b = os.path.join(T, 'o1b')
    run(dicts, o1b, tag='v1.73.0')
    check('same content, same zip bytes (reproducible)', all(sha(os.path.join(o1, z)) == sha(os.path.join(o1b, z)) for z in zips(o1)))

    # ---------------- nothing changed: no zip at all
    o2 = os.path.join(T, 'o2')
    rc, output = run(dicts, o2, prev=cat1, tag='v1.74.0')
    d2 = load_data(o2)
    check('nothing changed: serial kept', rc == 0 and d2['serial'] == 1, str(d2.get('serial')))
    check('nothing changed: no zip is built and upload.txt is empty', zips(o2) == [] and uploads(o2) == [], str(zips(o2)))
    check('nothing changed: the packs keep the old release (v1.73.0)', rel(d2) == rel(d1), str(rel(d2)))
    check('nothing changed: the entries are the same as before (same sha256 and url)', d2['packs'] == d1['packs'])
    cat2 = os.path.join(T, 'cat2.json'); as_catalog(o2, cat2)

    # ---------------- one language changed: only its zip, in the new release
    pack(dicts, 'pt-BR', 3, b'aaaaX')
    o3 = os.path.join(T, 'o3')
    os.makedirs(o3)
    open(os.path.join(o3, P + 'pt-BR-2.zip'), 'wb').write(b'leftover from a previous run')    # must disappear
    rc, _ = run(dicts, o3, prev=cat2, tag='v1.75.0')
    d3 = load_data(o3)
    check('pt-BR v3: serial goes up to 2', rc == 0 and d3['serial'] == 2, str(d3.get('serial')))
    check('pt-BR v3: only the new pt-BR zip is built (leftover removed)', zips(o3) == [P + 'pt-BR-3.zip'] and uploads(o3) == zips(o3), str(zips(o3)))
    check('pt-BR v3: pt-BR points to the new release, the others stay where they were',
          rel(d3) == {'en-US': 'v1.73.0', 'es': 'v1.73.0', 'pt-BR': 'v1.75.0'}, str(rel(d3)))
    check('pt-BR v3: the catalog lists only the current versions', sorted((p['id'], p['version']) for p in d3['packs']) == [('en-US', 2), ('es', 1), ('pt-BR', 3)])
    check('pt-BR v3: the unchanged entries are identical', [p for p in d3['packs'] if p['id'] != 'pt-BR'] == [p for p in d1['packs'] if p['id'] != 'pt-BR'])
    cat3 = os.path.join(T, 'cat3.json'); as_catalog(o3, cat3)

    # ---------------- later release with another change: the chain keeps working
    pack(dicts, 'es', 2, b'ccccY')
    o3b = os.path.join(T, 'o3b')
    rc, _ = run(dicts, o3b, prev=cat3, tag='v1.76.0')
    d3b = load_data(o3b)
    check('es v2 later: each language points to the release that made its zip',
          rc == 0 and rel(d3b) == {'en-US': 'v1.73.0', 'es': 'v1.76.0', 'pt-BR': 'v1.75.0'}, str(rel(d3b)))
    pack(dicts, 'es', 1, b'cccc')

    # ---------------- language removed / added
    shutil.rmtree(os.path.join(dicts, 'es'))
    o4 = os.path.join(T, 'o4')
    rc, _ = run(dicts, o4, prev=cat3, tag='v1.76.0')
    check('language removed: serial goes up, no zip and es is gone from the catalog',
          rc == 0 and load_data(o4)['serial'] == 3 and zips(o4) == [] and sorted(rel(load_data(o4))) == ['en-US', 'pt-BR'])
    cat4 = os.path.join(T, 'cat4.json'); as_catalog(o4, cat4)
    pack(dicts, 'es', 1, b'cccc')
    o4b = os.path.join(T, 'o4b')
    rc, _ = run(dicts, o4b, prev=cat4, tag='v1.77.0')
    check('language added back: new zip in the new release, serial goes up',
          rc == 0 and load_data(o4b)['serial'] == 4 and zips(o4b) == [P + 'es-1.zip'] and rel(load_data(o4b))['es'] == 'v1.77.0')

    # ---------------- errors
    pack(dicts, 'en-US', 2, b'bbbbCHANGED')
    rc, output = run(dicts, os.path.join(T, 'o5'), prev=cat3, tag='v1.77.0')
    check('content changed without raising the version: error', rc != 0 and 'raise' in output, output[-200:])
    pack(dicts, 'en-US', 2, b'bbbb')

    pack(dicts, 'pt-BR', 2, b'aaaa')
    rc, output = run(dicts, os.path.join(T, 'o5b'), prev=cat3, tag='v1.77.0')
    check('version lower than the published one: error', rc != 0 and 'lower' in output, output[-200:])
    pack(dicts, 'pt-BR', 3, b'aaaaX')

    for bad in ('1.77.0', 'v1.77', 'main', 'v1.77.0/../x', ''):
        rc, output = run(dicts, os.path.join(T, 'o6'), prev=cat3, tag=bad)
        check('invalid --tag %r: error' % bad, rc != 0 and '--tag' in output, output[-200:])

    old = json.load(open(cat3)); dd = json.loads(old['data'])
    for p in dd['packs']: del p['release']
    old['data'] = json.dumps(dd); oldcat = os.path.join(T, 'oldcat.json'); json.dump(old, open(oldcat, 'w'))
    rc, output = run(dicts, os.path.join(T, 'o7'), prev=oldcat, tag='v1.77.0')
    check('previous catalog without "release" for an unchanged pack: clear error', rc != 0 and '"release"' in output, output[-200:])

    # ---------------- dictionary format v2 (pack format 2, 1.86): header, size limit and minApp are checked per format
    d2 = os.path.join(T, 'dicts2')
    pack(d2, 'pt-BR', 6, b'v' * 5000000, fmt=2, min_app=1086000)          # 5 MB: over the v1 limit, fine for v2
    rc, output = run(d2, os.path.join(T, 'p1'), tag='v1.86.0')
    dp = load_data(os.path.join(T, 'p1')) if rc == 0 else {}
    check('format 2: a 5 MB dictionary with header [200,2] and minApp 1086000 is accepted',
          rc == 0 and [(p['format'], p['minApp']) for p in dp['packs']] == [(2, 1086000)], output[-200:])
    pack(d2, 'pt-BR', 6, b'v' * 5000000, fmt=1)
    rc, output = run(d2, os.path.join(T, 'p2'), tag='v1.86.0')
    check('format 1: a dictionary over 4,194,304 bytes is refused', rc != 0 and 'format limit' in output, output[-200:])
    pack(d2, 'pt-BR', 6, b'v' * 100, fmt=2, min_app=1086000, header=[200, 1])
    rc, output = run(d2, os.path.join(T, 'p3'), tag='v1.86.0')
    check('format 2 with a v1 header: refused (an old app would not tell them apart)', rc != 0 and '[200,2]' in output, output[-200:])
    pack(d2, 'pt-BR', 6, b'v' * 100, fmt=1, header=[200, 2])
    rc, output = run(d2, os.path.join(T, 'p4'), tag='v1.86.0')
    check('format 1 with a v2 header: refused', rc != 0 and '[200,1]' in output, output[-200:])
    pack(d2, 'pt-BR', 6, b'v' * 100, fmt=2, min_app=1085000)
    rc, output = run(d2, os.path.join(T, 'p5'), tag='v1.86.0')
    check('format 2 with minApp below 1086000: refused', rc != 0 and '1086000' in output, output[-200:])
    pack(d2, 'pt-BR', 6, b'v' * 16777300, fmt=2, min_app=1086000)
    rc, output = run(d2, os.path.join(T, 'p6'), tag='v1.86.0')
    check('format 2: a dictionary over 16 MB is refused', rc != 0, output[-200:])
    pack(d2, 'pt-BR', 6, b'v' * 100, fmt=3, min_app=1086000)
    rc, output = run(d2, os.path.join(T, 'p7'), tag='v1.86.0')
    check('unknown pack format 3: refused', rc != 0 and 'unknown format' in output, output[-200:])
finally:
    shutil.rmtree(T, ignore_errors=True)

print('ALL OK (%d checks)' % ok if not fails else '%d FAILURE(S) out of %d checks' % (fails, ok + fails))
sys.exit(1 if fails else 0)
