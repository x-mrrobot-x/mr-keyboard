#!/usr/bin/env python3
"""Confere os textos fixos em português do editor de folhas e dos anexos contra a tabela de espanhol (MrEs.java).

Rode na raiz do projeto depois de mudar texto em português nesses arquivos. Sai com 1 se:
  - um texto passado por SheetStrings.p() / SheetStrings.a() não está na tabela (ficaria sem tradução);
  - uma chave da tabela não aparece no smali (sobra de um texto que mudou ou saiu);
  - sobrou texto em português sem passar por p()/a() nos arquivos do editor de folhas e do anexo.
O smali dos arquivos listados em BASES usa o texto em português e deixa o p() trocar para espanhol; os
nomes e categorias do seletor de teclas especiais são trocados nos 4 pontos de leitura (SpecialKeyPicker).
"""
import re, glob, sys

BASES_P = ['KeyEditDialog', 'PopupEditDialog', 'PrefScreenSheets', 'SheetGridView', 'SheetEditorActivity', 'SpecialKeyPicker']
BASES_A = ['MrShots', 'MrCacheClear']
SMALI = 'smali/com/mrkeyboard/app/'
# textos do seletor de teclas especiais: ficam em <clinit> e são trocados na leitura, não na declaração
NO_CLINIT = {'SpecialKeyPicker'}


def dec(s):
    return re.sub(r'\\u([0-9a-fA-F]{4})', lambda m: chr(int(m.group(1), 16)), s).replace('\\"', '"').replace("\\'", "'").replace('\\n', '\n')


def java_str(s):
    return dec(s.replace('\\\\', '\\').replace('\\"', '"')) if False else re.sub(r'\\(u[0-9a-fA-F]{4}|.)', lambda m: chr(int(m.group(1)[1:], 16)) if m.group(1)[0] == 'u' and len(m.group(1)) == 5 else {'n': '\n', '"': '"', '\\': '\\'}.get(m.group(1), m.group(1)), s)


src = open('docs/tools/java/src/com/mrkeyboard/app/MrEs.java', encoding='utf-8').read()
tabela = set()
for m in re.finditer(r'^\s+[ea]\("((?:[^"\\]|\\.)*)",', src, re.M):
    tabela.add(java_str(m.group(1)))

cs = re.compile(r'const-string(?:/jumbo)? ([vp]\d+), "((?:[^"\\]|\\.)*)"')
usados, sem_trad, soltos = set(), [], []
hint = re.compile(r'[áéíóúãõçâêôà]|\b(de|do|da|para|ou|em|com|uma|um|que|não|Toque|Nenhum|Folha|folha)\b')
ingles = re.compile(r'\b(the|and|to|of|for|with|key|keys|sheet|sheets|type|enter|each|button)\b')
for kind, bases in (('p', BASES_P), ('a', BASES_A)):
    for b in bases:
        for f in sorted(glob.glob(SMALI + b + '.smali') + glob.glob(SMALI + b + '$*.smali')):
            txt = open(f, encoding='utf-8').read()
            for m in cs.finditer(txt):
                lit = dec(m.group(2))
                after = txt[m.end():m.end() + 160]
                embrulhado = re.match(r'\s*invoke-static/range \{%s \.\. %s\}, Lcom/mrkeyboard/app/SheetStrings;->%s\(' % (m.group(1), m.group(1), kind), after)
                if embrulhado:
                    usados.add(lit)
                    if lit not in tabela: sem_trad.append((f, lit))
                elif lit in tabela:
                    usados.add(lit)    # fica na tabela por ser trocado em outro ponto (nomes do seletor)
                elif hint.search(lit) and not ingles.search(lit) and not re.match(r'^[a-z_.:/$\-]+$', lit) and b not in NO_CLINIT:
                    soltos.append((f, lit))
# nomes e categorias do seletor vêm do <clinit>: contam como usados se estiverem na tabela
nao_usados = sorted(k for k in tabela if k not in usados and not any(k in open(f, encoding='utf-8').read().replace('\\n', '\n') for f in glob.glob(SMALI + 'SpecialKeyPicker*.smali')))
print('chaves na tabela: %d | textos embrulhados: %d' % (len(tabela), len(usados)))
for f, l in sem_trad: print('SEM TRADUÇÃO NA TABELA', f, repr(l))
for f, l in soltos: print('PORTUGUÊS SEM p()/a()', f, repr(l))
sys.exit(1 if sem_trad or soltos else 0)
