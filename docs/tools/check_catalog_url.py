#!/usr/bin/env python3
"""Confere que o app lê o catálogo de dicionários da release mais recente (a mesma do APK).

Rode na raiz do projeto. O app (MrPacks.CATALOG_URL) abre
  https://github.com/<dono>/<repo>/releases/latest/download/catalogo.json
e o publish_release.sh anexa o catálogo com esse nome (catalogo.json) na release de cada lançamento.
Também confere o smali gerado (as duas ocorrências da URL) e o dono/repositório do README.
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
    padrao = r'^https://github\.com/([^/]+/[^/]+)/releases/latest/download/catalogo\.json$'
    mm = re.match(padrao, url)
    if not mm:
        problemas.append('CATALOG_URL deve ser https://github.com/<dono>/<repo>/releases/latest/download/catalogo.json (está %s)' % url)
    else:
        repo = mm.group(1)
        readme = open('README.md', encoding='utf-8').read()
        if 'github.com/' + repo not in readme and '../../releases' not in readme:
            problemas.append('o repositório %s da URL não aparece no README' % repo)

smali = open('smali/com/mrkeyboard/app/MrPacks.smali', encoding='utf-8').read()
if url and smali.count(url) != 2:
    problemas.append('o smali de MrPacks tem a URL %d vez(es) (esperado 2: campo e const-string); rode o build_java.sh' % smali.count(url))
if 'releases/download/dicionarios' in smali or 'releases/download/dicionarios' in java:
    problemas.append('MrPacks ainda aponta para a release antiga "dicionarios"')

publicar = open('docs/tools/publish_release.sh', encoding='utf-8').read()
if 'out/catalogo.json' not in publicar:
    problemas.append('publish_release.sh não anexa out/catalogo.json (o app procura o anexo catalogo.json)')

print('catálogo lido de: ' + (url or '(não achei)'))
for p in problemas:
    print('PROBLEMA:', p)
sys.exit(1 if problemas else 0)
