#!/usr/bin/env python3
"""Lists, one per line and sorted, the files the release must have: the APK, catalog.json and ONE zip
per language (the ones in the catalog). Exits 1 if the catalog repeats a language or a zip.
Usage: python3 release_assets.py out/data.json mr-keyboard-v1.82.0.apk"""
import json, sys

d = json.load(open(sys.argv[1], encoding='utf-8'))
apk = sys.argv[2]
ids = [p['id'] for p in d['packs']]
zips = [p['url'] for p in d['packs']]
if len(set(ids)) != len(ids) or len(set(zips)) != len(zips):
    print('catalog with a repeated language or zip: %s' % ids, file=sys.stderr)
    sys.exit(1)
for name in sorted([apk, 'catalog.json'] + zips):
    print(name)
