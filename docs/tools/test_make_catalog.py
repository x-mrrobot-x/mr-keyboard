#!/usr/bin/env python3
"""Tests make_catalog.py with fake dictionaries (no network, no key). Run it from the project root.

Covers the single release (--tag, --reuse): one zip per language, a serial that only goes up when something
changes, the release base address, a zip reused with the same bytes, and the errors (content changed without
raising the version, previous zip missing or tampered).
"""
import hashlib, json, os, shutil, subprocess, sys, tempfile

MC = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'make_catalog.py')
ok = falhas = 0


def check(nome, cond, extra=''):
    global ok, falhas
    if cond:
        ok += 1; print('OK    ' + nome)
    else:
        falhas += 1; print('FALHA ' + nome + (' | ' + extra if extra else ''))


def pack(root, pid, version, conteudo):
    d = os.path.join(root, pid); os.makedirs(d, exist_ok=True)
    json.dump({'id': pid, 'lang': pid.split('-')[0], 'name': {'en': pid}, 'version': version, 'format': 1,
               'minApp': 1, 'files': ['main.dict'], 'licenses': []}, open(os.path.join(d, 'pack.json'), 'w'))
    open(os.path.join(d, 'main.dict'), 'wb').write(bytes([200, 1]) + conteudo)


def run(dicts, out, tag, prev=None, reuse=None):
    cmd = [sys.executable, '-I', MC, '--dicts', dicts, '--out', out, '--repo', 'dono/repo', '--now', '2026-10-31T00:00:00+00:00', '--tag', tag]
    if prev: cmd += ['--prev', prev]
    if reuse: cmd += ['--reuse', reuse]
    r = subprocess.run(cmd, capture_output=True, text=True)
    return r.returncode, r.stdout + r.stderr


def dados(out):
    return json.load(open(os.path.join(out, 'data.json'), encoding='utf-8'))


def como_catalogo(out, destino):
    """data.json no formato do catalog.json publicado (o make_catalog só lê o campo "data")."""
    json.dump({'data': open(os.path.join(out, 'data.json'), encoding='utf-8').read()}, open(destino, 'w'))


def zips(pasta):
    return sorted(f for f in os.listdir(pasta) if f.endswith('.zip'))


def sha(p):
    return hashlib.sha256(open(p, 'rb').read()).hexdigest()


T = tempfile.mkdtemp()
try:
    dicts = os.path.join(T, 'dicts')
    pack(dicts, 'pt-BR', 2, b'aaaa'); pack(dicts, 'en-US', 2, b'bbbb'); pack(dicts, 'es', 1, b'cccc')

    # ---------------- release única (--tag)
    o1 = os.path.join(T, 'o1')
    rc, _ = run(dicts, o1, tag='v1.73.0')
    d1 = dados(o1)
    check('única 1ª vez: dá certo, série 1, endereço-base da release', rc == 0 and d1['serial'] == 1 and d1['baseUrl'] == 'https://github.com/dono/repo/releases/download/v1.73.0/', str(d1.get('baseUrl')))
    check('única 1ª vez: um zip por idioma', zips(o1) == ['en-US-2.zip', 'es-1.zip', 'pt-BR-2.zip'])
    check('única 1ª vez: upload.txt lista todos os zips', sorted(open(os.path.join(o1, 'upload.txt')).read().split()) == zips(o1))
    cat1 = os.path.join(T, 'cat1.json'); como_catalogo(o1, cat1)

    o2 = os.path.join(T, 'o2')
    rc, saida = run(dicts, o2, prev=cat1, tag='v1.74.0', reuse=o1)
    d2 = dados(o2)
    check('nada mudou: série mantida e endereço-base novo', rc == 0 and d2['serial'] == 1 and d2['baseUrl'].endswith('/v1.74.0/'), str(d2['serial']))
    check('nada mudou: os zips vão para a release nova com os mesmos bytes', zips(o2) == zips(o1) and all(sha(os.path.join(o1, z)) == sha(os.path.join(o2, z)) for z in zips(o1)))
    check('nada mudou: upload.txt ainda lista os 3 zips', sorted(open(os.path.join(o2, 'upload.txt')).read().split()) == zips(o2))
    cat2 = os.path.join(T, 'cat2.json'); como_catalogo(o2, cat2)

    pack(dicts, 'pt-BR', 3, b'aaaaX')
    o3 = os.path.join(T, 'o3')
    os.makedirs(o3)
    open(os.path.join(o3, 'pt-BR-2.zip'), 'wb').write(b'sobra de uma execucao anterior')    # tem que sumir
    rc, _ = run(dicts, o3, prev=cat2, tag='v1.75.0', reuse=o2)
    d3 = dados(o3)
    check('pt-BR v3: série sobe para 2', rc == 0 and d3['serial'] == 2, str(d3.get('serial')))
    check('pt-BR v3: um zip por idioma (o v2 do pt-BR não vai)', zips(o3) == ['en-US-2.zip', 'es-1.zip', 'pt-BR-3.zip'], str(zips(o3)))
    check('pt-BR v3: en-US e es reaproveitados com os mesmos bytes', all(sha(os.path.join(o3, z)) == sha(os.path.join(o1, z)) for z in ('en-US-2.zip', 'es-1.zip')))
    check('pt-BR v3: o catálogo lista só as versões atuais', sorted((p['id'], p['version']) for p in d3['packs']) == [('en-US', 2), ('es', 1), ('pt-BR', 3)])
    cat3 = os.path.join(T, 'cat3.json'); como_catalogo(o3, cat3)

    shutil.rmtree(os.path.join(dicts, 'es'))
    o4 = os.path.join(T, 'o4')
    rc, _ = run(dicts, o4, prev=cat3, tag='v1.76.0', reuse=o3)
    check('idioma removido: série sobe e o zip some', rc == 0 and dados(o4)['serial'] == 3 and zips(o4) == ['en-US-2.zip', 'pt-BR-3.zip'])
    pack(dicts, 'es', 1, b'cccc')

    pack(dicts, 'en-US', 2, b'bbbbMUDOU')
    rc, saida = run(dicts, os.path.join(T, 'o5'), prev=cat3, tag='v1.77.0', reuse=o3)
    check('conteúdo mudou sem subir a version: erro', rc != 0 and 'aumente' in saida, saida[-200:])
    pack(dicts, 'en-US', 2, b'bbbb')

    shutil.copytree(o3, os.path.join(T, 'o3b'))
    os.remove(os.path.join(T, 'o3b', 'es-1.zip'))
    rc, saida = run(dicts, os.path.join(T, 'o6'), prev=cat3, tag='v1.77.0', reuse=os.path.join(T, 'o3b'))
    check('zip anterior faltando: erro claro', rc != 0 and 'es-1.zip' in saida, saida[-200:])

    shutil.copytree(o3, os.path.join(T, 'o3c'))
    open(os.path.join(T, 'o3c', 'es-1.zip'), 'ab').write(b'x')
    rc, saida = run(dicts, os.path.join(T, 'o7'), prev=cat3, tag='v1.77.0', reuse=os.path.join(T, 'o3c'))
    check('zip anterior adulterado: erro', rc != 0 and 'não confere' in saida, saida[-200:])

    rc, saida = run(dicts, os.path.join(T, 'o8'), prev=cat3, tag='v1.77.0')
    check('pacote igual sem --reuse: erro', rc != 0 and '--reuse' in saida, saida[-200:])
finally:
    shutil.rmtree(T, ignore_errors=True)

print('TUDO OK (%d verificações)' % ok if not falhas else '%d FALHA(S) em %d verificações' % (falhas, ok + falhas))
sys.exit(1 if falhas else 0)
