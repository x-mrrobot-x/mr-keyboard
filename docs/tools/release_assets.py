#!/usr/bin/env python3
"""Lista, um por linha e em ordem, os arquivos que a release tem que ter: MrKeyboard.apk, catalogo.json e UM zip
por idioma (os do catálogo). Sai com 1 se o catálogo repetir um idioma ou um zip.
Uso: python3 release_assets.py out/dados.json"""
import json, sys

d = json.load(open(sys.argv[1], encoding='utf-8'))
ids = [p['id'] for p in d['packs']]
zips = [p['url'] for p in d['packs']]
if len(set(ids)) != len(ids) or len(set(zips)) != len(zips):
    print('catálogo com idioma ou zip repetido: %s' % ids, file=sys.stderr)
    sys.exit(1)
for nome in sorted(['MrKeyboard.apk', 'catalogo.json'] + zips):
    print(nome)
