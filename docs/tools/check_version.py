#!/usr/bin/env python3
"""Confere a versão: apktool.yml e apktool.json iguais, versionCode coerente com versionName e notas da versão.

Rode na raiz do projeto. versionCode = maior*1000000 + menor*1000 + correção (v1.72.0 -> 1072000).
As notas da versão ficam onde o workflow de publicação procura: docs/release-notes/v<versão>.md (v1.72.0 ->
docs/release-notes/v1.72.0.md). O arquivo inteiro vira o texto da Release e precisa ter os dois blocos, **Português** e **English**.
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
    notas = ['docs/release-notes/v%s.md' % nome]
    achadas = [n for n in notas if os.path.exists(n)]
    if not achadas:
        problemas.append('sem notas da versão: crie um destes arquivos: ' + ' ou '.join(notas))
    else:
        texto = open(achadas[0], encoding='utf-8').read()
        for bloco in ('**Português**', '**English**'):
            if not re.search(r'^' + re.escape(bloco) + r'\s*$', texto, re.M):
                problemas.append('%s sem o bloco %s (o texto que vai na Release do GitHub)' % (achadas[0], bloco))
print('versão v%s (código %d)' % (nome, codigo))
for p in problemas:
    print('PROBLEMA:', p)
sys.exit(1 if problemas else 0)
