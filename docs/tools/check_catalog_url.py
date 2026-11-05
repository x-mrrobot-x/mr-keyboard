#!/usr/bin/env python3
"""Checks that the app reads the dictionary catalog from the latest release (the same one as the APK).

Rode na raiz do projeto. O app (MrPacks.CATALOG_URL) abre
  https://github.com/<dono>/<repo>/releases/latest/download/catalog.json
and publish_release.sh attaches the catalog with that name (catalog.json) to the release of each launch.
It also checks the generated smali (the two occurrences of the URL) and the owner/repository in the README.
"""
import re, sys

problemas = []
java = open('docs/tools/java/src/com/mrkeyboard/app/MrPacks.java', encoding='utf-8').read()
m = re.search(r'CATALOG_URL\s*=\s*"([^"]+)"', java)
if not m:
    problemas.append('MrPacks.java sem CATALOG_URL')
    url = ''
else:
    url = m.group(1)
    padrao = r'^https://github\.com/([^/]+/[^/]+)/releases/latest/download/catalog\.json$'
    mm = re.match(padrao, url)
    if not mm:
        problemas.append('CATALOG_URL deve ser https://github.com/<dono>/<repo>/releases/latest/download/catalog.json (está %s)' % url)
    else:
        repo = mm.group(1)
        readme = open('README.md', encoding='utf-8').read()
        if 'github.com/' + repo not in readme and '../../releases' not in readme:
            problemas.append('o repositório %s da URL não aparece no README' % repo)

smali = open('smali/com/mrkeyboard/app/MrPacks.smali', encoding='utf-8').read()
if url and smali.count(url) != 2:
    problemas.append('o smali de MrPacks tem a URL %d vez(es) (esperado 2: campo e const-string); rode o build_java.sh' % smali.count(url))

publicar = open('docs/tools/publish_release.sh', encoding='utf-8').read()
if 'out/catalog.json' not in publicar:
    problemas.append('publish_release.sh não anexa out/catalog.json (o app procura o anexo catalog.json)')

print('catálogo lido de: ' + (url or '(não achei)'))
for p in problemas:
    print('PROBLEMA:', p)
sys.exit(1 if problemas else 0)
