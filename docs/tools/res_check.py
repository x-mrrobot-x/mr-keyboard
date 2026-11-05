#!/usr/bin/env python3
"""Checks the resources of the apktool project. Run at the project root; exits with 1 if it finds a problem.

  - well-formed XMLs;
  - public.xml: every entry has a resource, with no repeated name or ID;
  - every resource ID constant in the smali (0x7f......) is in public.xml;
  - every @type/name reference in the XMLs and the manifest exists;
  - no unused resource (reachable from the manifest, from the smali ID constants and from the names read
    as text in the smali and the Java sources);
  - themes: mr_theme_layouts covering every value of
    keyboard_layout_modes_values; mr_theme_tags and mr_theme_flags with the same size and only valid bits;
    each theme layout with a tag in mr_theme_tags; each color
    mr_<theme>_<role> with a default mr_<role>, and every role asked of MrTheme.color with a default color;
    the input_mr_*, input_popup_* and key_preview_* of all themes equal to each other, only the theme name changes;
  - set of each theme: selector and 5 key drawables, accent-key selector (the drawables it uses are
    checked through the references; Slate and Midnight reuse hl/pressed/on/lock), long-press popup, preview balloon,
    explicit popupLayout and keyPreviewLayout, no hex color in the theme layouts and drawables (the key
    colors live in res/values/mr_key_colors.xml) and the theme name in the 3 languages;
  - Spanish (values-es) with the same keys and lists as Portuguese (values-pt-rBR) and the same placeholders
    (%s, %1$d) as the original.
"""
import collections, difflib, glob, os, re, sys
import xml.dom.minidom

FILE_TYPES = {'drawable', 'mipmap', 'layout', 'anim', 'xml', 'raw', 'menu', 'color', 'animator', 'interpolator'}
VAL_TAGS = 'style|string|color|dimen|bool|integer|string-array|integer-array|array|attr|declare-styleable|plurals|item'
NOT_RESOURCES = {'0x7f000001', '0x7f7fffff', '0x7fffffff'}      # smali constants that are not resources
UNUSED_OK = {('string', 'status_bar_notification_info_overflow')}   # from the support library
problems = []


def norm(t):
    return {'string-array': 'array', 'integer-array': 'array', 'mipmap': 'drawable'}.get(t, t)


def read_file(p):
    return open(p, encoding='utf-8', errors='ignore').read()


# --- well-formed XMLs
for p in glob.glob('res/**/*.xml', recursive=True) + ['AndroidManifest.xml']:
    try:
        xml.dom.minidom.parse(p)
    except Exception as e:
        problems.append('invalid XML %s: %s' % (p, e))

# --- definitions
defs = collections.defaultdict(list)       # (type,name) -> [(file, text)]
for p in glob.glob('res/*/*'):
    t = os.path.basename(os.path.dirname(p)).split('-')[0]
    if t in FILE_TYPES:
        defs[(norm(t), os.path.basename(p).split('.')[0])].append((p, read_file(p) if p.endswith('.xml') else ''))
for p in glob.glob('res/values*/*.xml'):
    if p.endswith('public.xml'):
        continue
    s = read_file(p)
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
    for m in re.finditer(r'(?:@\+id/|name=")(\w+)', read_file(p)):
        pass

# --- public.xml
pub = re.findall(r'<public type="(\w+)" name="([^"]+)" id="(0x[0-9a-f]+)"', read_file('res/values/public.xml'))
used_ids = set()
for p in glob.glob('res/**/*.xml', recursive=True):
    used_ids |= set(re.findall(r'@\+id/(\w+)', read_file(p)))
for t, n, i in pub:
    if t != 'id' and (norm(t), n) not in defs:
        problems.append('public.xml: %s/%s (%s) has no resource' % (t, n, i))
for name, count in collections.Counter(i for _, _, i in pub).items():
    if count > 1: problems.append('public.xml: repeated ID ' + name)
for name, count in collections.Counter((t, n) for t, n, _ in pub).items():
    if count > 1: problems.append('public.xml: repeated entry %s/%s' % name)
pubmap = {i: (norm(t), n) for t, n, i in pub}

# --- smali and Java
smali = ''.join(read_file(p) for p in glob.glob('smali*/**/*.smali', recursive=True))
for i in sorted(set(re.findall(r'0x7f[0-9a-f]{6}', smali)) - NOT_RESOURCES):
    if i not in pubmap:
        problems.append('smali uses the ID %s that is not in public.xml' % i)
lits = set(re.findall(r'const-string(?:/jumbo)? [vp]\d+, "([^"]+)"', smali))
for p in glob.glob('docs/tools/java/src/**/*.java', recursive=True):
    lits |= set(re.findall(r'"([^"\\]+)"', read_file(p)))


def refs(s):
    out = set()
    for m in re.finditer(r'@(layout|drawable|mipmap|color|dimen|style|anim|string|array|bool|integer|xml|raw|menu|attr|plurals)/([\w.]+)', s):
        out.add((norm(m.group(1)), m.group(2)))
    for m in re.finditer(r'\?(?:attr/)?([A-Za-z_][\w.]*)(?=["\s<])', s):
        out.add(('attr', m.group(1)))
    for m in re.finditer(r'parent="([\w.@/]+)"', s):
        out.add(('style', m.group(1).split('/')[-1]))
    return out


# --- references that do not exist
for p in glob.glob('res/**/*.xml', recursive=True) + ['AndroidManifest.xml']:
    if p.endswith('public.xml'):
        continue
    for m in re.finditer(r'@(layout|drawable|mipmap|color|dimen|style|anim|string|array|bool|integer|xml|raw|menu)/([\w.]+)', read_file(p)):
        if (norm(m.group(1)), m.group(2)) not in defs:
            problems.append('%s: @%s/%s does not exist' % (p, m.group(1), m.group(2)))

# --- unused resources
roots = refs(read_file('AndroidManifest.xml'))
for i in set(re.findall(r'0x7f[0-9a-f]{6}', smali)):
    if i in pubmap: roots.add(pubmap[i])
by_name = collections.defaultdict(list)
for k in defs: by_name[k[1]].append(k)
for l in lits:
    for k in by_name.get(l, []):
        if k[0] != 'attr': roots.add(k)
prefixes = [l for l in lits if l.endswith('_') and len(l) > 3]
for k in list(defs):
    if any(k[1].startswith(pf) for pf in prefixes): roots.add(k)
# colors by role (MrTheme.color): the smali passes the role and the final name is built at run time
roles = set(re.findall(r'const-string [vp]\d+, "(\w+)"\s+invoke-static \{[vp]\d+\}, Lcom/mrkeyboard/app/MrTheme;->color\(', smali))
# theme registry arrays (mr_themes.xml)
def array_items(name):
    for p in glob.glob('res/values/*.xml'):
        m = re.search(r'<(?:string-|integer-)?array name="%s"[^>]*>(.*?)</(?:string-|integer-)?array>' % name, read_file(p), re.S)
        if m: return re.findall(r'<item>\s*([^<]*?)\s*</item>', m.group(1))
    return None


theme_tags = set(array_items('mr_theme_tags') or [])
for k in list(defs):
    if k[0] != 'color': continue
    for r in roles:
        if k[1] == 'mr_' + r or any(k[1] == t + '_' + r for t in theme_tags):
            roots.add(k)
seen, stack = set(), list(roots)
while stack:
    k = stack.pop()
    if k in seen: continue
    seen.add(k)
    for _, text in defs.get(k, []):
        stack.extend(r for r in refs(text) if r not in seen)
for k in list(seen):
    for _, text in defs.get(k, []):
        seen |= {('attr', a) for a in re.findall(r'\b(?!android:|xmlns:)\w+:(\w+)=', text)}
        seen |= {('attr', a) for a in re.findall(r'<item name="([\w.]+)"', text)}
for k in sorted(defs):
    if k not in seen and k[0] != 'attr' and k not in UNUSED_OK:
        problems.append('unused resource: %s/%s (%s)' % (k[0], k[1], ', '.join(sorted({p for p, _ in defs[k]}))))


lay, vals, names = (array_items(n) for n in ('mr_theme_layouts', 'keyboard_layout_modes_values', 'keyboard_layout_modes'))
if None in (lay, vals, names):
    problems.append('themes: mr_theme_layouts, keyboard_layout_modes_values or keyboard_layout_modes is missing')
else:
    if len(vals) != len(names):
        problems.append('themes: keyboard_layout_modes_values has %d items and keyboard_layout_modes %d' % (len(vals), len(names)))
    for v in vals:
        if not v.isdigit() or int(v) >= len(lay):
            problems.append('themes: value %s of keyboard_layout_modes_values is outside mr_theme_layouts (%d items)' % (v, len(lay)))
    tag_list, flag_list = array_items('mr_theme_tags'), array_items('mr_theme_flags')
    if tag_list is None or flag_list is None:
        problems.append('themes: mr_theme_tags or mr_theme_flags is missing')
    else:
        if len(tag_list) != len(flag_list):
            problems.append('themes: mr_theme_tags has %d items and mr_theme_flags %d' % (len(tag_list), len(flag_list)))
        if len(set(tag_list)) != len(tag_list):
            problems.append('themes: mr_theme_tags with a repeated tag')
        for t, f in zip(tag_list, flag_list):
            try:
                v = int(f, 0)
            except ValueError:
                problems.append('themes: mr_theme_flags of %s = %s is not a number' % (t, f))
                continue
            if v & ~0x7e:
                problems.append('themes: mr_theme_flags of %s = %s uses a bit outside 0x7e (bit 0x01 belongs to MrTheme)' % (t, f))
    for l in sorted(set(lay)):
        name = l.replace('@layout/', '')
        file = 'res/layout/%s.xml' % name
        if not os.path.exists(file):
            continue
        tag = re.search(r'android:tag="([^"]+)"', read_file(file))
        if not tag:
            problems.append('themes: %s has no android:tag' % file)
        elif tag.group(1) not in theme_tags:
            problems.append('themes: tag %s of %s is missing from mr_theme_tags' % (tag.group(1), file))
        else:
            t = tag.group(1)[3:]
            text = read_file(file)
            pop = 'input_popup_' + t
            required = ['btn_keyboard_key_' + t] + ['key_%s_%s' % (t, e) for e in ('normal', 'pressed', 'on', 'lock', 'hl')]
            required += ['btn_keyboard_key_%s_accent' % t]
            required += ['preview_%s_bg' % t, 'preview_%s_more_bg' % t, 'key_preview_' + t]
            required += ['input_popup_' + t, 'popup_%s_bg' % t, 'btn_keyboard_key_popup_' + t, 'key_popup_%s_pressed' % t]
            for e in required:
                if not any(k[1] == e for k in defs):
                    problems.append('themes: theme %s lacks the resource %s' % (t, e))
            for attr_name, expected in (('popupLayout', pop), ('keyPreviewLayout', 'key_preview_' + t)):
                m = re.search(r'latin:%s="@layout/(\w+)"' % attr_name, text)
                if not m or m.group(1) != expected:
                    problems.append('themes: %s must have latin:%s="@layout/%s"' % (file, attr_name, expected))
            for extra in ('res/layout/%s.xml' % pop, 'res/layout/key_preview_%s.xml' % t, file):
                if os.path.exists(extra) and re.search(r'="#[0-9a-fA-F]{6,8}"', read_file(extra)):
                    problems.append('themes: %s has a hex color; use @color/mr_%s_*' % (extra, t))
            # theme drawables: color only through @color (the values live in res/values/mr_key_colors.xml)
            drs = {'btn_keyboard_key_' + t, 'btn_keyboard_key_%s_accent' % t, 'btn_keyboard_key_popup_' + t,
                   'key_popup_%s_pressed' % t, 'popup_%s_bg' % t, 'preview_%s_bg' % t, 'preview_%s_more_bg' % t}
            drs |= {os.path.basename(x)[:-4] for x in glob.glob('res/drawable/key_%s_*.xml' % t)}
            for d in sorted(drs):
                file_d = 'res/drawable/%s.xml' % d
                if os.path.exists(file_d) and re.search(r'="#[0-9a-fA-F]{3,8}"', read_file(file_d)):
                    problems.append('themes: %s has a hex color; declare it in res/values/mr_key_colors.xml '
                                     '(mr_%s_key_<state>_<part>) and use @color' % (file_d, t))
    # layouts per theme: the input_mr_*, input_popup_* and key_preview_* may only differ in the theme name
    themes_ok = []
    for l in sorted(set(lay)):
        file = 'res/layout/%s.xml' % l.replace('@layout/', '')
        mt = re.search(r'android:tag="mr_(\w+)"', read_file(file)) if os.path.exists(file) else None
        if mt and 'mr_' + mt.group(1) in theme_tags and mt.group(1) not in themes_ok:
            themes_ok.append(mt.group(1))
    for group in ('input_mr_%s', 'input_popup_%s', 'key_preview_%s'):
        ref_name, ref_lines = None, None
        for t in themes_ok:
            file = 'res/layout/%s.xml' % (group % t)
            if not os.path.exists(file):
                continue
            lines = read_file(file).replace(t, '<theme>').splitlines()
            if ref_lines is None:
                ref_name, ref_lines = file, lines
                continue
            diff_lines = [d for d in difflib.unified_diff(ref_lines, lines, lineterm='', n=0)
                   if d[:1] in '+-' and d[:3] not in ('+++', '---')]
            if diff_lines:
                problems.append('themes: %s differs from %s beyond the theme name (%s)' % (file, ref_name, '; '.join(x.strip() for x in diff_lines[:3])))
colors = {k[1] for k in defs if k[0] == 'color'}
for r in sorted(roles):
    if 'mr_' + r not in colors:
        problems.append('themes: role %s asked of MrTheme.color has no default color mr_%s' % (r, r))
for c in sorted(colors):
    for t in theme_tags:
        if c.startswith(t + '_') and 'mr_' + c[len(t) + 1:] not in colors and c[len(t) + 1:] in roles:
            problems.append('themes: %s has no default color mr_%s' % (c, c[len(t) + 1:]))

# --- Spanish x Portuguese x original
def strings_of(folder):
    r = {}
    for p in glob.glob(folder + '/*.xml'):
        for m in re.finditer(r'<string name="([^"]+)"(?:\s[^>]*)?>(.*?)</string>', read_file(p), re.S):
            r[m.group(1)] = m.group(2)
    return r


def arrays_of(folder):
    r = {}
    for p in glob.glob(folder + '/*.xml'):
        for m in re.finditer(r'<string-array name="([^"]+)"[^>]*>(.*?)</string-array>', read_file(p), re.S):
            r[m.group(1)] = len(re.findall(r'<item>', m.group(2)))
    return r


orig, pt, es = strings_of('res/values'), strings_of('res/values-pt-rBR'), strings_of('res/values-es')
for n in re.findall(r'@string/(\w+)', ' '.join(names or [])):
    for folder, tab in (('values', orig), ('values-pt-rBR', pt), ('values-es', es)):
        if n not in tab:
            problems.append('themes: theme name %s is missing from %s' % (n, folder))
for missing in sorted(set(pt) - set(es)): problems.append('values-es lacks the key ' + missing)
for leftover in sorted(set(es) - set(pt)): problems.append('values-es has a key that Portuguese lacks: ' + leftover)
marks = lambda s: sorted(re.findall(r'%(?:\d+\$)?[sdf]', s.replace('%%', '')))
for name, table in (('values-es', es), ('values-pt-rBR', pt)):
    for k, v in table.items():
        if k in orig and marks(v) != marks(orig[k]):
            problems.append('%s/%s: placeholders %s differ from the original %s' % (name, k, marks(v), marks(orig[k])))
la_o, la_p, la_e = arrays_of('res/values'), arrays_of('res/values-pt-rBR'), arrays_of('res/values-es')
for k in la_p:
    if la_e.get(k) != la_p[k]: problems.append('values-es: list %s with %s items (Portuguese: %d)' % (k, la_e.get(k), la_p[k]))
for k in la_e:
    if k in la_o and la_e[k] != la_o[k]: problems.append('values-es: list %s with %d items (original: %d)' % (k, la_e[k], la_o[k]))

# --- the update dialog looks like the AI Editor dialog: settings theme (Theme.MrKeyboard.Dialog) and settings palette
SETTINGS_COLORS = re.compile(r'^(mr_ui_\w+|mr_ai_\w+|mr_accent(_\d+)?|mr_ripple|mr_text_on_accent)$')
upd = read_file('res/layout/mr_update_dialog.xml')
if re.search(r'#[0-9a-fA-F]{3,8}\b', re.sub(r'<!--.*?-->', '', upd, flags=re.S)):
    problems.append('mr_update_dialog.xml: hex color (use the colors of the settings palette)')
for kind, name in re.findall(r'@(color|drawable)/([\w.]+)', upd):
    if kind == 'color' and not SETTINGS_COLORS.match(name):
        problems.append('mr_update_dialog.xml: @color/%s is not of the settings palette' % name)
    if kind == 'drawable' and not name.startswith('mr_ui_'):
        problems.append('mr_update_dialog.xml: @drawable/%s is not of the settings screens (mr_ui_*)' % name)
theme_id = dict(((n), i) for t, n, i in pub if t == 'style').get('Theme.MrKeyboard.Dialog')
for src in ('MrUpdateDialog', 'MrAiDialog'):
    j = read_file('docs/tools/java/src/com/mrkeyboard/app/%s.java' % src)
    if '"Theme.MrKeyboard.Dialog"' not in j:
        problems.append('%s.java: does not use Theme.MrKeyboard.Dialog' % src)
    m = re.search(r'theme(?:Id)? = (0x7f[0-9a-f]+)', j)
    if not m or m.group(1) != theme_id:
        problems.append('%s.java: fallback id of the dialog theme (%s) is not the one of public.xml (%s)' % (src, m and m.group(1), theme_id))

# --- the screens that the keyboard opens from its window (FLAG_ACTIVITY_NEW_TASK) share a task of their own: with the
# affinity of the app they would join its task when it is alive and Back would land on the app's main page instead of
# the app the user was typing in
KEYBOARD_SCREENS = ('LatinIMESettings', 'PrefScreenSheets', 'MrPacksActivity', 'MrAiPrefs', 'MrAiStyleActivity')
manifest_tags = re.findall(r'<activity\b[^>]*>', read_file('AndroidManifest.xml'))
affinities = set()
for screen in KEYBOARD_SCREENS:
    tag = [t for t in manifest_tags if 'android:name="com.mrkeyboard.app.%s"' % screen in t]
    aff = re.search(r'android:taskAffinity="([^"]*)"', tag[0]) if tag else None
    if not tag:
        problems.append('manifest: activity %s not found' % screen)
    elif not aff or '.' not in aff.group(1) or aff.group(1) == 'com.mrkeyboard.app':
        problems.append('manifest: %s needs its own android:taskAffinity (not the package name)' % screen)
    else:
        affinities.add(aff.group(1))
if len(affinities) > 1:
    problems.append('manifest: the screens opened by the keyboard must share one taskAffinity, found %s' % sorted(affinities))

print('resources: %d defined, %d entries in public.xml, %d strings in Spanish' % (len(defs), len(pub), len(es)))
for p in problems:
    print('PROBLEM:', p)
sys.exit(1 if problems else 0)
