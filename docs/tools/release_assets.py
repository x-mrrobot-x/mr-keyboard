#!/usr/bin/env python3
"""What the release must have, and what the catalog expects from other releases (used by publish_release.sh).

  release_assets.py assets   out/data.json <tag> <apk> <source-zip>
                                                         the files this release must have, one per line and
                                                         sorted: the APK, the source zip, catalog.json, update.json
                                                         and ONLY the zips whose "release" is <tag> (a language that
                                                         did not change keeps its zip in the release that made it)
  release_assets.py external out/data.json <tag>         one line "<release> <zip> <size>" for each pack whose zip
                                                         is in ANOTHER release, to check before publishing
  release_assets.py text     out/data.json <tag>         "pt-BR v3 (novo nesta versão / new in this version), ..."

Exits 1 if the catalog repeats a language or a zip, or if a "release" is not a tag like v1.82.0."""
import json, re, sys

TAG_RE = re.compile(r'^v[0-9]+\.[0-9]+\.[0-9]+$')


def load(path, tag):
    if not TAG_RE.match(tag):
        sys.exit('invalid tag: %r' % tag)
    packs = json.load(open(path, encoding='utf-8'))['packs']
    ids = [p['id'] for p in packs]
    zips = [(p['release'], p['url']) for p in packs]
    if len(set(ids)) != len(ids) or len(set(zips)) != len(zips):
        sys.exit('catalog with a repeated language or zip: %s' % ids)
    for p in packs:
        if not TAG_RE.match(str(p.get('release', ''))):
            sys.exit('%s: invalid or missing "release": %r' % (p['id'], p.get('release')))
    return packs


def main():
    if len(sys.argv) < 4:
        sys.exit(__doc__)
    cmd, packs = sys.argv[1], load(sys.argv[2], sys.argv[3])
    tag = sys.argv[3]
    if cmd == 'assets' and len(sys.argv) == 6:
        for name in sorted([sys.argv[4], sys.argv[5], 'catalog.json', 'update.json'] + [p['url'] for p in packs if p['release'] == tag]):
            print(name)
    elif cmd == 'external' and len(sys.argv) == 4:
        for p in packs:
            if p['release'] != tag:
                print(p['release'], p['url'], p['size'])
    elif cmd == 'text' and len(sys.argv) == 4:
        print(', '.join('%s v%d%s' % (p['id'], p['version'], ' (novo nesta versão / new in this version)' if p['release'] == tag else '')
                        for p in packs))
    else:
        sys.exit(__doc__)


main()
