#!/usr/bin/env python3
"""Confere os recursos do projeto apktool. Rode na raiz do projeto; sai com 1 se achar problema.

  - XMLs bem formados;
  - public.xml: toda entrada tem recurso, sem nome nem ID repetido;
  - toda constante de ID de recurso do smali (0x7f......) está no public.xml;
  - toda referência @tipo/nome dos XMLs e do manifest existe;
  - nenhum recurso sem uso (alcançável pelo manifest, pelas constantes de ID do smali e pelos nomes lidos
    por texto no smali e nos fontes Java);
  - temas: mr_theme_layouts cobrindo todo valor de
    keyboard_layout_modes_values; mr_theme_tags e mr_theme_flags com o mesmo tamanho e só bits válidos;
    cada layout de tema com tag em mr_theme_tags; cada cor
    mr_<tema>_<papel> com padrão mr_<papel>, e todo papel pedido ao MrTheme.color com cor padrão;
    os input_mr_*, input_popup_* e key_preview_* de todos os temas iguais entre si, só muda o nome do tema;
  - conjunto de cada tema: seletor e 5 drawables de tecla, seletor da tecla de destaque (os drawables que ele usa são
    conferidos pelas referências; Slate e Midnight reaproveitam hl/pressed/on/lock), popup do toque longo, balão de preview,
    popupLayout e keyPreviewLayout explícitos, sem cor em hex nos layouts e nos drawables do tema (as cores das
    teclas ficam em res/values/mr_key_colors.xml) e nome do tema nos 3 idiomas;
  - espanhol (values-es) com as mesmas chaves e listas do português (values-pt-rBR) e os mesmos marcadores
    (%s, %1$d) do original.
"""
import collections, difflib, glob, os, re, sys
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
# cores por papel (MrTheme.color): o smali passa o papel e o nome final e montado na execucao
papeis = set(re.findall(r'const-string [vp]\d+, "(\w+)"\s+invoke-static \{[vp]\d+\}, Lcom/mrkeyboard/app/MrTheme;->color\(', smali))
# arrays de registro dos temas (mr_themes.xml)
def itens(nome):
    for p in glob.glob('res/values/*.xml'):
        m = re.search(r'<(?:string-|integer-)?array name="%s"[^>]*>(.*?)</(?:string-|integer-)?array>' % nome, ler(p), re.S)
        if m: return re.findall(r'<item>\s*([^<]*?)\s*</item>', m.group(1))
    return None


tags_tema = set(itens('mr_theme_tags') or [])
for k in list(defs):
    if k[0] != 'color': continue
    for r in papeis:
        if k[1] == 'mr_' + r or any(k[1] == t + '_' + r for t in tags_tema):
            raizes.add(k)
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


lay, vals, nomes = (itens(n) for n in ('mr_theme_layouts', 'keyboard_layout_modes_values', 'keyboard_layout_modes'))
if None in (lay, vals, nomes):
    problemas.append('temas: falta mr_theme_layouts, keyboard_layout_modes_values ou keyboard_layout_modes')
else:
    if len(vals) != len(nomes):
        problemas.append('temas: keyboard_layout_modes_values tem %d itens e keyboard_layout_modes %d' % (len(vals), len(nomes)))
    for v in vals:
        if not v.isdigit() or int(v) >= len(lay):
            problemas.append('temas: valor %s de keyboard_layout_modes_values fora de mr_theme_layouts (%d itens)' % (v, len(lay)))
    tags_lista, flags_lista = itens('mr_theme_tags'), itens('mr_theme_flags')
    if tags_lista is None or flags_lista is None:
        problemas.append('temas: falta mr_theme_tags ou mr_theme_flags')
    else:
        if len(tags_lista) != len(flags_lista):
            problemas.append('temas: mr_theme_tags tem %d itens e mr_theme_flags %d' % (len(tags_lista), len(flags_lista)))
        if len(set(tags_lista)) != len(tags_lista):
            problemas.append('temas: mr_theme_tags com tag repetida')
        for t, f in zip(tags_lista, flags_lista):
            try:
                v = int(f, 0)
            except ValueError:
                problemas.append('temas: mr_theme_flags de %s = %s não é número' % (t, f))
                continue
            if v & ~0x7e:
                problemas.append('temas: mr_theme_flags de %s = %s usa bit fora de 0x7e (o bit 0x01 é do MrTheme)' % (t, f))
    for l in sorted(set(lay)):
        nome = l.replace('@layout/', '')
        arq = 'res/layout/%s.xml' % nome
        if not os.path.exists(arq):
            continue
        tag = re.search(r'android:tag="([^"]+)"', ler(arq))
        if not tag:
            problemas.append('temas: %s sem android:tag' % arq)
        elif tag.group(1) not in tags_tema:
            problemas.append('temas: tag %s de %s ausente de mr_theme_tags' % (tag.group(1), arq))
        else:
            t = tag.group(1)[3:]
            txt = ler(arq)
            pop = 'input_popup_' + t
            exigidos = ['btn_keyboard_key_' + t] + ['key_%s_%s' % (t, e) for e in ('normal', 'pressed', 'on', 'lock', 'hl')]
            exigidos += ['btn_keyboard_key_%s_accent' % t]
            exigidos += ['preview_%s_bg' % t, 'preview_%s_more_bg' % t, 'key_preview_' + t]
            exigidos += ['input_popup_' + t, 'popup_%s_bg' % t, 'btn_keyboard_key_popup_' + t, 'key_popup_%s_pressed' % t]
            for e in exigidos:
                if not any(k[1] == e for k in defs):
                    problemas.append('temas: tema %s sem o recurso %s' % (t, e))
            for atr, esperado in (('popupLayout', pop), ('keyPreviewLayout', 'key_preview_' + t)):
                m = re.search(r'latin:%s="@layout/(\w+)"' % atr, txt)
                if not m or m.group(1) != esperado:
                    problemas.append('temas: %s deve ter latin:%s="@layout/%s"' % (arq, atr, esperado))
            for extra in ('res/layout/%s.xml' % pop, 'res/layout/key_preview_%s.xml' % t, arq):
                if os.path.exists(extra) and re.search(r'="#[0-9a-fA-F]{6,8}"', ler(extra)):
                    problemas.append('temas: %s com cor em hex; use @color/mr_%s_*' % (extra, t))
            # drawables do tema: cor só por @color (os valores ficam em res/values/mr_key_colors.xml)
            drs = {'btn_keyboard_key_' + t, 'btn_keyboard_key_%s_accent' % t, 'btn_keyboard_key_popup_' + t,
                   'key_popup_%s_pressed' % t, 'popup_%s_bg' % t, 'preview_%s_bg' % t, 'preview_%s_more_bg' % t}
            drs |= {os.path.basename(x)[:-4] for x in glob.glob('res/drawable/key_%s_*.xml' % t)}
            for d in sorted(drs):
                arq_d = 'res/drawable/%s.xml' % d
                if os.path.exists(arq_d) and re.search(r'="#[0-9a-fA-F]{3,8}"', ler(arq_d)):
                    problemas.append('temas: %s com cor em hex; declare em res/values/mr_key_colors.xml '
                                     '(mr_%s_key_<estado>_<parte>) e use @color' % (arq_d, t))
    # layouts por tema: os input_mr_*, input_popup_* e key_preview_* so podem diferir no nome do tema
    temas_ok = []
    for l in sorted(set(lay)):
        arq = 'res/layout/%s.xml' % l.replace('@layout/', '')
        mt = re.search(r'android:tag="mr_(\w+)"', ler(arq)) if os.path.exists(arq) else None
        if mt and 'mr_' + mt.group(1) in tags_tema and mt.group(1) not in temas_ok:
            temas_ok.append(mt.group(1))
    for grupo in ('input_mr_%s', 'input_popup_%s', 'key_preview_%s'):
        ref_nome, ref_linhas = None, None
        for t in temas_ok:
            arq = 'res/layout/%s.xml' % (grupo % t)
            if not os.path.exists(arq):
                continue
            linhas = ler(arq).replace(t, '<tema>').splitlines()
            if ref_linhas is None:
                ref_nome, ref_linhas = arq, linhas
                continue
            dif = [d for d in difflib.unified_diff(ref_linhas, linhas, lineterm='', n=0)
                   if d[:1] in '+-' and d[:3] not in ('+++', '---')]
            if dif:
                problemas.append('temas: %s difere de %s alem do nome do tema (%s)' % (arq, ref_nome, '; '.join(x.strip() for x in dif[:3])))
cores = {k[1] for k in defs if k[0] == 'color'}
for r in sorted(papeis):
    if 'mr_' + r not in cores:
        problemas.append('temas: papel %s pedido ao MrTheme.color sem a cor padrão mr_%s' % (r, r))
for c in sorted(cores):
    for t in tags_tema:
        if c.startswith(t + '_') and 'mr_' + c[len(t) + 1:] not in cores and c[len(t) + 1:] in papeis:
            problemas.append('temas: %s sem a cor padrão mr_%s' % (c, c[len(t) + 1:]))

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
for n in re.findall(r'@string/(\w+)', ' '.join(nomes or [])):
    for pasta, tab in (('values', orig), ('values-pt-rBR', pt), ('values-es', es)):
        if n not in tab:
            problemas.append('temas: nome %s do tema ausente em %s' % (n, pasta))
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
