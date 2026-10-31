#!/usr/bin/env python3
"""Confere a versão: apktool.yml e apktool.json iguais, versionCode coerente com versionName e notas da versão.

Rode na raiz do projeto. versionCode = maior*1000000 + menor*1000 + correção (v1.72.0 -> 1072000).
As notas (com a seção "## Notas da release", que vira o texto da Release) seguem o que o workflow de publicação procura: docs/revisao-<versão>.md ou, para v1.MM.0,
docs/revisao-1.M.M.md (v1.72.0 -> docs/revisao-1.7.2.md).
"""
import json, os, re, sys

problemas = []
yml = open('apktool.yml', encoding='utf-8').read()
nome = re.search(r"versionName:\s*['\"]?v?([0-9.]+)", yml).group(1)
codigo = int(re.search(r"versionCode:\s*['\"]?(\d+)", yml).group(1))
info = json.load(open('apktool.json', encoding='utf-8'))['VersionInfo']
if info['versionName'].lstrip('v') != nome or int(info['versionCode']) != codigo:
    problemas.append('apktool.yml (v%s, %d) e apktool.json (%s, %s) não batem' % (nome, codigo, info['versionName'], info['versionCode']))
partes = nome.split('.')
if len(partes) != 3:
    problemas.append('versionName v%s não tem o formato maior.menor.correção' % nome)
else:
    maior, menor, pat = (int(x) for x in partes)
    esperado = maior * 1000000 + menor * 1000 + pat
    if codigo != esperado:
        problemas.append('versionCode %d não combina com v%s (esperado %d)' % (codigo, nome, esperado))
    notas = ['docs/revisao-%s.md' % nome]
    if pat == 0 and 10 <= menor <= 99:
        notas.append('docs/revisao-%d.%d.%d.md' % (maior, menor // 10, menor % 10))
    achadas = [n for n in notas if os.path.exists(n)]
    if not achadas:
        problemas.append('sem notas da versão: crie um destes arquivos: ' + ' ou '.join(notas))
    elif not re.search(r'^## Notas da release\s*$', open(achadas[0], encoding='utf-8').read(), re.M):
        problemas.append('%s sem a seção "## Notas da release" (o texto curto que vai na Release do GitHub)' % achadas[0])
print('versão v%s (código %d)' % (nome, codigo))
for p in problemas:
    print('PROBLEMA:', p)
sys.exit(1 if problemas else 0)
