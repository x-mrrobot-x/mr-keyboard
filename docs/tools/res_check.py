#!/usr/bin/env python3
"""Confere os recursos do projeto apktool. Rode na raiz do projeto; sai com 1 se achar problema.

  - XMLs bem formados;
  - public.xml: toda entrada tem recurso, sem nome nem ID repetido;
  - toda constante de ID de recurso do smali (0x7f......) está no public.xml;
  - toda referência @tipo/nome dos XMLs e do manifest existe;
  - nenhum recurso sem uso (alcançável pelo manifest, pelas constantes de ID do smali e pelos nomes lidos
    por texto no smali e nos fontes Java);
  - espanhol (values-es) com as mesmas chaves e listas do português (values-pt-rBR) e os mesmos marcadores
    (%s, %1$d) do original.
"""
import collections, glob, os, re, sys
import xml.dom.minidom

FILE_TYPES = {'drawable', 'mipmap', 'layout', 'anim', 'xml', 'raw', 'menu', 'color', 'animator', 'interpolator'}
VAL_TAGS = 'style|string|color|dimen|bool|integer|string-array|integer-array|array|attr|declare-styleable|plurals|item'
NAO_RECURSO = {'0x7f000001', '0x7f7fffff', '0x7fffffff'}      # constantes do smali que não são recursos
SEM_USO_OK = {('string', 'status_bar_notification_info_overflow')}   # da biblioteca de suporte
problemas = []


def norm(t):
    return {'string-array': 'array', 'integer-array': 'array', 'mipmap': 'drawable'}.get(t, t)


def ler(p):
    return open(p, encoding='utf-8', errors='ignore').read()


# --- XMLs bem formados
for p in glob.glob('res/**/*.xml', recursive=True) + ['AndroidManifest.xml']:
    try:
        xml.dom.minidom.parse(p)
    except Exception as e:
        problemas.append('XML inválido %s: %s' % (p, e))

# --- definições
defs = collections.defaultdict(list)       # (tipo,nome) -> [(arquivo, texto)]
for p in glob.glob('res/*/*'):
    t = os.path.basename(os.path.dirname(p)).split('-')[0]
    if t in FILE_TYPES:
        defs[(norm(t), os.path.basename(p).split('.')[0])].append((p, ler(p) if p.endswith('.xml') else ''))
for p in glob.glob('res/values*/*.xml'):
    if p.endswith('public.xml'):
        continue
    s = ler(p)
    for m in re.finditer(r'<(%s)\s+name="([^"]+)"[^>]*?(?:/>|>(.*?)</\1>)' % VAL_TAGS, s, re.S):
        t = norm(m.group(1))
        if t == 'item':
            continue
        n = m.group(2)
        defs[(t, n)].append((p, m.group(0)))
        if t == 'style' and '.' in n:
            defs[(t, n)].append((p, '@style/' + n.rsplit('.', 1)[0]))
        if t == 'declare-styleable':
            for a in re.finditer(r'<attr\s+name="([^"]+)"', m.group(0)):
                defs[('attr', a.group(1))].append((p, ''))
for p in glob.glob('res/**/*.xml', recursive=True):
    for m in re.finditer(r'(?:@\+id/|name=")(\w+)', ler(p)):
        pass

# --- public.xml
pub = re.findall(r'<public type="(\w+)" name="([^"]+)" id="(0x[0-9a-f]+)"', ler('res/values/public.xml'))
ids_usados = set()
for p in glob.glob('res/**/*.xml', recursive=True):
    ids_usados |= set(re.findall(r'@\+id/(\w+)', ler(p)))
for t, n, i in pub:
    if t != 'id' and (norm(t), n) not in defs:
        problemas.append('public.xml: %s/%s (%s) sem recurso' % (t, n, i))
for nome, cont in collections.Counter(i for _, _, i in pub).items():
    if cont > 1: problemas.append('public.xml: ID repetido ' + nome)
for nome, cont in collections.Counter((t, n) for t, n, _ in pub).items():
    if cont > 1: problemas.append('public.xml: entrada repetida %s/%s' % nome)
pubmap = {i: (norm(t), n) for t, n, i in pub}

# --- smali e Java
smali = ''.join(ler(p) for p in glob.glob('smali*/**/*.smali', recursive=True))
for i in sorted(set(re.findall(r'0x7f[0-9a-f]{6}', smali)) - NAO_RECURSO):
    if i not in pubmap:
        problemas.append('smali usa o ID %s que não está no public.xml' % i)
lits = set(re.findall(r'const-string(?:/jumbo)? [vp]\d+, "([^"]+)"', smali))
for p in glob.glob('docs/tools/java/src/**/*.java', recursive=True):
    lits |= set(re.findall(r'"([^"\\]+)"', ler(p)))


def refs(s):
    out = set()
    for m in re.finditer(r'@(layout|drawable|mipmap|color|dimen|style|anim|string|array|bool|integer|xml|raw|menu|attr|plurals)/([\w.]+)', s):
        out.add((norm(m.group(1)), m.group(2)))
    for m in re.finditer(r'\?(?:attr/)?([A-Za-z_][\w.]*)(?=["\s<])', s):
        out.add(('attr', m.group(1)))
    for m in re.finditer(r'parent="([\w.@/]+)"', s):
        out.add(('style', m.group(1).split('/')[-1]))
    return out


# --- referências que não existem
for p in glob.glob('res/**/*.xml', recursive=True) + ['AndroidManifest.xml']:
    if p.endswith('public.xml'):
        continue
    for m in re.finditer(r'@(layout|drawable|mipmap|color|dimen|style|anim|string|array|bool|integer|xml|raw|menu)/([\w.]+)', ler(p)):
        if (norm(m.group(1)), m.group(2)) not in defs:
            problemas.append('%s: @%s/%s não existe' % (p, m.group(1), m.group(2)))

# --- recursos sem uso
raizes = refs(ler('AndroidManifest.xml'))
for i in set(re.findall(r'0x7f[0-9a-f]{6}', smali)):
    if i in pubmap: raizes.add(pubmap[i])
por_nome = collections.defaultdict(list)
for k in defs: por_nome[k[1]].append(k)
for l in lits:
    for k in por_nome.get(l, []):
        if k[0] != 'attr': raizes.add(k)
prefixos = [l for l in lits if l.endswith('_') and len(l) > 3]
for k in list(defs):
    if any(k[1].startswith(pf) for pf in prefixos): raizes.add(k)
vistos, pilha = set(), list(raizes)
while pilha:
    k = pilha.pop()
    if k in vistos: continue
    vistos.add(k)
    for _, txt in defs.get(k, []):
        pilha.extend(r for r in refs(txt) if r not in vistos)
for k in list(vistos):
    for _, txt in defs.get(k, []):
        vistos |= {('attr', a) for a in re.findall(r'\b(?!android:|xmlns:)\w+:(\w+)=', txt)}
        vistos |= {('attr', a) for a in re.findall(r'<item name="([\w.]+)"', txt)}
for k in sorted(defs):
    if k not in vistos and k[0] != 'attr' and k not in SEM_USO_OK:
        problemas.append('recurso sem uso: %s/%s (%s)' % (k[0], k[1], ', '.join(sorted({p for p, _ in defs[k]}))))


# --- espanhol x português x original
def textos(pasta):
    r = {}
    for p in glob.glob(pasta + '/*.xml'):
        for m in re.finditer(r'<string name="([^"]+)"(?:\s[^>]*)?>(.*?)</string>', ler(p), re.S):
            r[m.group(1)] = m.group(2)
    return r


def listas(pasta):
    r = {}
    for p in glob.glob(pasta + '/*.xml'):
        for m in re.finditer(r'<string-array name="([^"]+)"[^>]*>(.*?)</string-array>', ler(p), re.S):
            r[m.group(1)] = len(re.findall(r'<item>', m.group(2)))
    return r


orig, pt, es = textos('res/values'), textos('res/values-pt-rBR'), textos('res/values-es')
for faltam in sorted(set(pt) - set(es)): problemas.append('values-es sem a chave ' + faltam)
for sobra in sorted(set(es) - set(pt)): problemas.append('values-es com chave que o português não tem: ' + sobra)
marc = lambda s: sorted(re.findall(r'%(?:\d+\$)?[sdf]', s.replace('%%', '')))
for nome, tabela in (('values-es', es), ('values-pt-rBR', pt)):
    for k, v in tabela.items():
        if k in orig and marc(v) != marc(orig[k]):
            problemas.append('%s/%s: marcadores %s diferentes do original %s' % (nome, k, marc(v), marc(orig[k])))
la_o, la_p, la_e = listas('res/values'), listas('res/values-pt-rBR'), listas('res/values-es')
for k in la_p:
    if la_e.get(k) != la_p[k]: problemas.append('values-es: lista %s com %s itens (português: %d)' % (k, la_e.get(k), la_p[k]))
for k in la_e:
    if k in la_o and la_e[k] != la_o[k]: problemas.append('values-es: lista %s com %d itens (original: %d)' % (k, la_e[k], la_o[k]))

print('recursos: %d definidos, %d entradas no public.xml, %d textos em espanhol' % (len(defs), len(pub), len(es)))
for p in problemas:
    print('PROBLEMA:', p)
sys.exit(1 if problemas else 0)
