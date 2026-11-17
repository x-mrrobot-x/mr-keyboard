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
    checked through the references; Midnight reuses hl/pressed/on/lock), long-press popup, preview balloon,
    explicit popupLayout and keyPreviewLayout, no hex color in the theme layouts and drawables (the key
    colors live in res/values/mr_key_colors.xml; those of the generated themes in res/values/mr_solid_colors.xml,
    mr_gloss_colors.xml and mr_neon_colors.xml, which docs/tools/make_themes.py writes together with their drawables
    and layouts) and the theme name in the 3 languages;
  - Spanish (values-es) with the same keys and lists as Portuguese (values-pt-rBR) and the same placeholders
    (%s, %1$d) as the original;
  - fonts tool: mr_font_style_0..STYLES-1 (unique names), its other texts and the clipboard counter in the 3 languages;
  - format specifiers of the project's own strings (mr_strings.xml, every language): no stray "%" and no several
    unnumbered specifiers in one string (aapt2 refuses them and String.format throws); "%%" is the literal percent.
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
    # a string literal, the empty one and the ones with escapes included (an earlier pattern skipped "" and paired the next quotes wrongly)
    lits |= set(re.findall(r'"([^"\\\n]*(?:\\.[^"\\\n]*)*)"', read_file(p)))


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
            if v & ~0x1fe:
                problems.append('themes: mr_theme_flags of %s = %s uses a bit outside 0x1fe (bit 0x01 belongs to MrTheme)' % (t, f))
            if v & 0x100 and not v & 0x80:
                problems.append('themes: mr_theme_flags of %s = %s has SPECTRUM (0x100) without GLOW (0x80): MrGlow only looks at '
                                'the hue of a key on a theme that glows' % (t, f))
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
            # theme drawables: color only through @color (the values live in res/values/mr_key_colors.xml; the
            # generated themes have theirs in mr_neon_colors.xml, mr_solid_colors.xml and mr_gloss_colors.xml)
            drs = {'btn_keyboard_key_' + t, 'btn_keyboard_key_%s_accent' % t, 'btn_keyboard_key_popup_' + t,
                   'key_popup_%s_pressed' % t, 'popup_%s_bg' % t, 'preview_%s_bg' % t, 'preview_%s_more_bg' % t}
            drs |= {os.path.basename(x)[:-4] for x in glob.glob('res/drawable/key_%s_*.xml' % t)}
            for d in sorted(drs):
                file_d = 'res/drawable/%s.xml' % d
                if os.path.exists(file_d) and re.search(r'="#[0-9a-fA-F]{3,8}"', read_file(file_d)):
                    problems.append('themes: %s has a hex color; declare it in res/values/mr_key_colors.xml '
                                     '(mr_%s_key_<state>_<part>) and use @color (a neon, solid or gloss theme is written '
                                     'by docs/tools/make_themes.py: change its table and run it)' % (file_d, t))
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
    if n not in orig:
        problems.append('themes: theme name %s is missing from values (the names are in English in every language: only values/strings.xml has them)' % n)
    for folder, tab in (('values-pt-rBR', pt), ('values-es', es)):
        if n in tab:
            problems.append('themes: theme name %s is translated in %s (the names of the themes are not translated: take it out)' % (n, folder))
for missing in sorted(set(pt) - set(es)): problems.append('values-es lacks the key ' + missing)
for leftover in sorted(set(es) - set(pt)): problems.append('values-es has a key that Portuguese lacks: ' + leftover)
marks = lambda s: sorted(re.findall(r'%(?:\d+\$)?[sdf]', s.replace('%%', '')))
for name, table in (('values-es', es), ('values-pt-rBR', pt)):
    for k, v in table.items():
        if k in orig and marks(v) != marks(orig[k]):
            problems.append('%s/%s: placeholders %s differ from the original %s' % (name, k, marks(v), marks(orig[k])))
# --- an apostrophe in a string must be escaped (\') unless the whole text is inside double quotes: aapt2 refuses the file otherwise ("unescaped
# apostrophe in string"), and nothing else in the checks reads the strings the way aapt2 does
for p in sorted(glob.glob('res/values*/*.xml')):
    for m in re.finditer(r'<string\s+name="([^"]+)"[^>]*>(.*?)</string>', read_file(p), re.S):
        v = m.group(2).strip()
        if v.startswith('"') and v.endswith('"') and len(v) > 1:
            continue
        if re.search(r"(?<!\\)'", re.sub(r'<!\[CDATA\[.*?\]\]>', '', v, flags=re.S)):
            problems.append("%s: string %s has an apostrophe that is not escaped (write \\' or rephrase): aapt2 refuses it" % (p, m.group(1)))

# --- format specifiers of the project's own strings (mr_strings.xml, every language). The original LatinIME strings.xml
# is left out on purpose: it has literal values such as "60%" that never go through String.format.
SPEC = re.compile(r'%(?:\d+\$)?[-#+0,(]*\d*(?:\.\d+)?(?:[bBhHsScCdoxXeEfgGaAn]|[tT][a-zA-Z])')
for p in sorted(glob.glob('res/values*/mr_strings.xml')):
    for m in re.finditer(r'<string\s+name="([^"]+)"([^>]*)>(.*?)</string>', read_file(p), re.S):
        k, attrs, v = m.groups()
        if 'formatted="false"' in attrs:
            continue
        v = v.replace('%%', '')
        specs = SPEC.findall(v)
        plain = [x for x in specs if not re.match(r'%\d+\$', x)]
        if '%' in SPEC.sub('', v):
            problems.append('%s/%s: a "%%" that is not a format specifier (write %%%% for a literal percent)' % (p, k))
        if len(plain) > 1:
            problems.append('%s/%s: several specifiers without a position %s (number them: %%1$s, %%2$s)' % (p, k, plain))
        elif plain and len(plain) != len(specs):
            problems.append('%s/%s: mixes numbered and unnumbered specifiers %s' % (p, k, specs))
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

# --- the app is ONE task and ONE window in the list of recent apps, and nothing is hidden from that list: the screens that the keyboard opens from its window
# (FLAG_ACTIVITY_NEW_TASK) land in the task of the package (no screen has a taskAffinity of its own: a second affinity was a second window, "Settings" next to
# "Mr Keyboard") and none of them says excludeFromRecents (the person has to see what is open to close it). The only windows left out of the list are the three
# translucent singleInstance helpers, which exist for a moment. MrScreens gives the task the one title (setTaskDescription), whichever screen is on top.
KEYBOARD_SCREENS = ('LatinIMESettings', 'PrefScreenSheets', 'MrPacksActivity', 'MrAiPrefs', 'MrAiStyleActivity')
manifest_tags = re.findall(r'<activity\b[^>]*>', read_file('AndroidManifest.xml'))
for tag in manifest_tags:
    name = re.search(r'android:name="([^"]+)"', tag)
    who = name.group(1) if name else '?'
    if 'android:taskAffinity=' in tag:
        problems.append('manifest: %s has a taskAffinity of its own: the app is one task (a second affinity is a second window in the recent apps)' % who)
    if 'android:excludeFromRecents="true"' in tag and 'android:launchMode="singleInstance"' not in tag:
        problems.append('manifest: %s is excludeFromRecents: the screens are not hidden from the recent apps (the person closes them there)' % who)
for screen in KEYBOARD_SCREENS:
    if not [t for t in manifest_tags if 'android:name="com.mrkeyboard.app.%s"' % screen in t]:
        problems.append('manifest: activity %s not found' % screen)

# --- MrNav marks what the keyboard opens and MrScreens tells it about the screens that come and go (and sets the one title of the task), so that the AI settings
# screen is closed when the person is back in the app they were typing in, and the whole task goes only when that screen is alone in it
nav_src = read_file('docs/tools/java/src/com/mrkeyboard/app/MrNav.java')
if 'EXTRA_FROM_KEYBOARD' not in nav_src or 'finishAndRemoveTask' not in nav_src or 'aloneInTask(a)' not in nav_src:
    problems.append('MrNav: the screens opened from the keyboard must carry EXTRA_FROM_KEYBOARD and be closed with their task (finishAndRemoveTask) only when alone in it (aloneInTask)')
_scr = read_file('docs/tools/java/src/com/mrkeyboard/app/MrScreens.java')
for call in ('MrNav.born(activity)', 'MrNav.opened(activity)', 'MrNav.gone(activity)', 'titleTask(activity)', 'MrMatrix.pause(activity)', 'MrMatrix.resume(activity)'):
    if call not in _scr:
        problems.append('MrScreens: %s is missing (the screens opened by the keyboard are tracked, and the rain stops when a screen leaves the display)' % call)
if 'MrNav.closeOpenedByKeyboard(MrAiPrefs.class)' not in read_file('docs/tools/java/src/com/mrkeyboard/app/MrAiDialog.java'):
    problems.append('MrAiDialog: the AI settings screen that the keyboard opened must be closed when the dialog comes back')

# --- one screen on top of itself is not allowed: every screen except the launcher and the singleInstance helpers is
# singleTop (a double tap on a Settings row reaches the screen already open through onNewIntent), and no method opens a
# screen of the keyboard by hand with NEW_TASK: the intent comes from MrNav.intent
for tag in manifest_tags:
    name = re.search(r'android:name="com\.mrkeyboard\.app\.(\w+)"', tag)
    if not name or name.group(1) == 'Main' or 'singleInstance' in tag: continue
    if 'android:launchMode="singleTop"' not in tag:
        problems.append('manifest: %s must be launchMode="singleTop"' % name.group(1))
screen_class = re.compile(r'const-class [vp]\d+, Lcom/mrkeyboard/app/(?:%s);' % '|'.join(KEYBOARD_SCREENS))
for sm in glob.glob('smali/com/mrkeyboard/app/*.smali'):
    for body in re.split(r'(?m)^\.method ', read_file(sm))[1:]:
        if screen_class.search(body) and '0x10000000' in body.split('.end method')[0]:
            problems.append('%s: opens a keyboard screen with its own NEW_TASK (use MrNav.intent): %s' % (
                os.path.basename(sm), body.splitlines()[0]))

# --- the dialog of the AI Editor is a window of its own (not an Activity): on Android 11+ it takes the bars and the cutout
# as padding through MrScreens.fitDialog, or its card could sit under the status bar or the camera
ai_dialog = read_file('docs/tools/java/src/com/mrkeyboard/app/MrAiDialog.java')
if 'MrScreens.fitDialog(window.getDecorView(), root)' not in ai_dialog:
    problems.append('MrAiDialog: the window of the dialog must go through MrScreens.fitDialog (insets of Android 11+)')
if 'attrs.height = windowHeight(' not in ai_dialog or 'nextHeight = windowHeight(' not in ai_dialog:
    problems.append('MrAiDialog: the height of the window must come from windowHeight (whole display when the area above the keyboard is short)')
if 'MrScreens;->fitDialog' not in read_file('smali/com/mrkeyboard/app/MrAiDialog.smali'):
    problems.append('MrAiDialog.smali: out of date, no call to MrScreens.fitDialog (run docs/tools/build_java.sh)')

# --- the tool and the keyboard survive a turn of the screen (MrKeep): the three places of LatinIME that feed it
ime_smali = read_file('smali/com/mrkeyboard/app/LatinIME.smali')
for method, call in (('onConfigurationChanged(Landroid/content/res/Configuration;)V', 'MrKeep;->onTurn('),
                     ('onWindowHidden()V', 'MrKeep;->onHidden()'),
                     ('onStartInput(Landroid/view/inputmethod/EditorInfo;Z)V', 'MrKeep;->onInput(')):
    start = ime_smali.find('.method public %s' % method)
    body = ime_smali[start:ime_smali.find('.end method', start)] if start >= 0 else ''
    if call not in body:
        problems.append('LatinIME.%s must call %s (the Customize tool and the keyboard come back after a rotation)' % (method.split('(')[0], call))
if ime_smali.find('MrKeep;->onHidden()') > ime_smali.find('MrAiDialog;->dismiss()V', ime_smali.find('.method public onWindowHidden()V')):
    problems.append('LatinIME.onWindowHidden: MrKeep.onHidden has to come before the tool is closed')

# --- the buttons of the tool bar close the open dialogs (MrBarClose): the list of codes has to be the one that MrTools binds to
# the eight buttons of bar_tools (b_fonts is the fonts tool), and MrTools.onClick has to call MrBarClose first
tools_smali = read_file('smali/com/mrkeyboard/app/MrTools.smali')
bound = {}
for m in re.finditer(r'const-string v1, "(b_\w+)"\s+(?:\.line \d+\s+)?const/(?:4|16) v2, (-?0x[0-9a-f]+)\s+(?:\.line \d+\s+)?invoke-static \{v0, v1, v2\}, Lcom/mrkeyboard/app/MrTools;->btn', tools_smali):
    bound[m.group(1)] = int(m.group(2), 16)
bar_src = read_file('docs/tools/java/src/com/mrkeyboard/app/MrBarClose.java')
listed = re.search(r'TOOLBAR = \{([^}]*)\}', bar_src)
listed = sorted(int(x.strip(), 16) for x in listed.group(1).split(',')) if listed else []
if sorted(bound) != ['b_aied', 'b_clip', 'b_emote', 'b_fonts', 'b_sheets', 'b_shots', 'b_trans', 'b_tune']:
    problems.append('MrTools: the buttons of the bar are not the eight expected (found %s)' % sorted(bound))
elif sorted(bound.values()) != listed:
    problems.append('MrBarClose.TOOLBAR %s does not match the codes that MrTools binds to the bar %s' % (listed, sorted(bound.values())))
start = tools_smali.find('.method public onClick(Landroid/view/View;)V')
if 'MrBarClose;->onClick(I)V' not in tools_smali[start:tools_smali.find('.end method', start)]:
    problems.append('MrTools.onClick must call MrBarClose.onClick (a button of the bar closes the open dialogs)')

# --- hardware acceleration of the screens (MrScreens + the setting pref_ui_hw_accel): Android can turn it on by window but never
# off, so the manifest keeps the app at "false" and only the three screens that draw with their own code at "true"; the setting
# only adds the flag. Off by default, in the three languages, and the Advanced screen creates itself again when it changes
manifest_text = read_file('AndroidManifest.xml')
app_tag = re.search(r'<application\b[^>]*>', manifest_text)
if not app_tag or 'android:hardwareAccelerated="false"' not in app_tag.group(0):
    problems.append('manifest: <application> must keep android:hardwareAccelerated="false" (the setting of the screens adds the flag; the default is software)')
accelerated = sorted(re.search(r'android:name="com\.mrkeyboard\.app\.(\w+)"', t).group(1)
                     for t in manifest_tags if 'android:hardwareAccelerated="true"' in t and re.search(r'android:name="com\.mrkeyboard\.app\.(\w+)"', t))
if accelerated != ['MrAiStyleActivity', 'PrefScreenSheets', 'SheetEditorActivity']:
    problems.append('manifest: the screens accelerated by the manifest must be MrAiStyleActivity, PrefScreenSheets and SheetEditorActivity (found %s)' % accelerated)
adv_xml = read_file('res/xml/prefs_advanced.xml')
hw_pref = [t for t in re.findall(r'<CheckBoxPreference\b[^>]*>', adv_xml) if 'android:key="pref_ui_hw_accel"' in t]
if len(hw_pref) != 1:
    problems.append('prefs_advanced.xml: the setting pref_ui_hw_accel is missing or repeated')
else:
    for attr in ('android:persistent="true"', 'android:defaultValue="false"', 'android:summaryOn="@string/mr_ui_hw_accel_on"',
                 'android:summaryOff="@string/mr_ui_hw_accel_off"', 'android:title="@string/mr_ui_hw_accel"'):
        if attr not in hw_pref[0]:
            problems.append('prefs_advanced.xml: pref_ui_hw_accel needs %s (off by default)' % attr)
for lang in ('values', 'values-es', 'values-pt-rBR'):
    texts = read_file('res/%s/mr_strings.xml' % lang)
    for name in ('mr_ui_cat_draw', 'mr_ui_cat_draw_sum', 'mr_ui_hw_accel', 'mr_ui_hw_accel_on', 'mr_ui_hw_accel_off',
                 'mr_ui_kbd_accel', 'mr_ui_kbd_accel_on', 'mr_ui_kbd_accel_off', 'mr_ui_kbd_accel_unknown',
                 'mr_ui_scr_accel', 'mr_ui_scr_accel_unknown', 'mr_ui_scr_accel_off', 'mr_ui_scr_accel_asked',
                 'mr_ui_scr_accel_system', 'mr_ui_scr_accel_refused'):
        if '<string name="%s">' % name not in texts:
            problems.append('%s/mr_strings.xml: string %s of the acceleration setting is missing' % (lang, name))
# --- Matrix effect of the screens (MrMatrix + MrRainDrawable + the setting pref_ui_matrix): ON by default, in the category Appearance of the main
# settings screen (not on Advanced), in the three languages, and the key is the same in the XML, in MrMatrix and in the list of what "Restore
# defaults" resets; the main settings screen has to tell MrScreens when it changes (the screen is created again to take it)
prefs_xml = read_file('res/xml/prefs.xml')
mx_pref = [t for t in re.findall(r'<CheckBoxPreference\b[^>]*>', prefs_xml) if 'android:key="pref_ui_matrix"' in t]
if len(mx_pref) != 1:
    problems.append('prefs.xml: the setting pref_ui_matrix is missing or repeated')
else:
    for attr in ('android:persistent="true"', 'android:defaultValue="true"', 'android:summaryOn="@string/mr_ui_matrix_on"',
                 'android:summaryOff="@string/mr_ui_matrix_off"', 'android:title="@string/mr_ui_matrix"'):
        if attr not in mx_pref[0]:
            problems.append('prefs.xml: pref_ui_matrix needs %s (on by default)' % attr)
    appearance = re.search(r'<PreferenceCategory\b[^>]*android:key="graphics_settings"[^>]*>(.*?)</PreferenceCategory>', prefs_xml, re.S)
    if not appearance or 'android:key="pref_ui_matrix"' not in appearance.group(1):
        problems.append('prefs.xml: pref_ui_matrix goes in the category Appearance (graphics_settings)')
if 'pref_ui_matrix' in adv_xml:
    problems.append('prefs_advanced.xml: pref_ui_matrix moved to the Appearance category of prefs.xml')
if 'MrScreens;->onSetting(Landroid/app/Activity;Ljava/lang/String;)V' not in read_file('smali/com/mrkeyboard/app/LatinIMESettings.smali'):
    problems.append('LatinIMESettings.smali: onSharedPreferenceChanged must call MrScreens.onSetting (the Matrix setting is on this screen)')
for lang in ('values', 'values-es', 'values-pt-rBR'):
    texts = read_file('res/%s/mr_strings.xml' % lang)
    for name in ('mr_ui_matrix', 'mr_ui_matrix_on', 'mr_ui_matrix_off'):
        if '<string name="%s">' % name not in texts:
            problems.append('%s/mr_strings.xml: string %s of the Matrix effect is missing' % (lang, name))
matrix_src = read_file('docs/tools/java/src/com/mrkeyboard/app/MrMatrix.java')
if 'KEY = "pref_ui_matrix"' not in matrix_src or 'getBoolean(KEY, true)' not in matrix_src:
    problems.append('MrMatrix: the key of the setting is not pref_ui_matrix or the default is not true')
if '"pref_ui_matrix"' not in read_file('docs/tools/java/src/com/mrkeyboard/app/MrReset.java'):
    problems.append('MrReset: pref_ui_matrix is not in the list of the settings that Restore defaults resets')
# --- "Dictionary memory" lines (MrDictMem): inside the row of the numbers (mr_perf, "Keyboard statistics") on Settings -> Advanced -> Performance, not a row of their own
# and not on the dictionaries screen; PrefScreenAdvanced.onResume starts the read BEFORE MrPerf.fill writes the row, MrPerf.summary asks MrDictMem.block for the lines, and
# the texts they read exist in the 3 languages. The row of the numbers is named "Keyboard statistics" (it shows more than times).
if 'mr_dict_mem' in adv_xml:
    problems.append('prefs_advanced.xml: the dictionary memory is inside the row mr_perf (Keyboard statistics), not a row of its own (mr_dict_mem)')
perf_cat = re.search(r'<PreferenceCategory\b[^>]*android:key="keyboard_perf"[^>]*>(.*?)</PreferenceCategory>', adv_xml, re.S)
if not perf_cat or 'android:key="mr_perf"' not in perf_cat.group(1):
    problems.append('prefs_advanced.xml: the row mr_perf goes in the category Performance (keyboard_perf)')
adv_smali = read_file('smali/com/mrkeyboard/app/PrefScreenAdvanced.smali')
i_dm = adv_smali.find('MrDictMem;->fill(Landroid/preference/PreferenceActivity;)V')
i_pf = adv_smali.find('MrPerf;->fill(Landroid/preference/PreferenceActivity;)V')
if i_dm < 0:
    problems.append('PrefScreenAdvanced.smali: onResume must call MrDictMem.fill (the lines of the dictionary memory are on this screen)')
elif i_pf < 0 or i_dm > i_pf:
    problems.append('PrefScreenAdvanced.smali: MrDictMem.fill must come BEFORE MrPerf.fill (the row is written once, with the lines)')
if 'MrDictMem.block(' not in read_file('docs/tools/java/src/com/mrkeyboard/app/MrPerf.java'):
    problems.append('MrPerf.summary must ask MrDictMem.block for the lines of the dictionary memory')
packs_act = read_file('docs/tools/java/src/com/mrkeyboard/app/MrPacksActivity.java')
for old in ('mMem', 'refreshMem', 'memText', 'mr_mem_'):
    if old in packs_act:
        problems.append('MrPacksActivity: "%s" is still there; the dictionary memory moved to Advanced (MrDictMem)' % old)
dm_names = ('mr_mem_title', 'mr_mem_wait', 'mr_mem_none', 'mr_mem_dict', 'mr_mem_tri', 'mr_mem_tri_none', 'mr_mem_engine', 'mr_mem_nomem')
for folder, tab in (('values', orig), ('values-pt-rBR', pt), ('values-es', es)):
    for k in dm_names:
        if k not in tab:
            problems.append('dictionary memory: %s is missing from %s' % (k, folder))
    for k in ('mr_ui_perf', 'mr_ui_cat_perf_sum'):
        if k in tab and re.search(r'(?i)keyboard times|tempos do teclado|tiempos del teclado', tab[k]):
            problems.append('%s: %s still says "keyboard times" (the row shows more than times: Keyboard statistics)' % (folder, k))
# --- the language on the space bar: LatinKeyboard.setLanguageSwitcher gives mLocale the language that is being typed (LanguageSwitcher.getInputLocale, which answers the
# device language when nothing is selected), always. The original code left it null with no selected language, or with a single one equal to the device language, so the
# name never showed up on the key for most people. It must not look at the number of languages or at the device language again (the arrows are drawn by drawSpaceBar,
# which already asks for 2 or more).
_kb = read_file('smali/com/mrkeyboard/app/LatinKeyboard.smali')
_sls = re.search(r'\.method public setLanguageSwitcher\(.*?\.end method', _kb, re.S)
if not _sls:
    problems.append('LatinKeyboard.smali: setLanguageSwitcher not found')
else:
    if 'LanguageSwitcher;->getInputLocale()' not in _sls.group(0):
        problems.append('LatinKeyboard.setLanguageSwitcher must take mLocale from LanguageSwitcher.getInputLocale (the space bar always names the language)')
    for _bad in ('getLocaleCount', 'getSystemLocale'):
        if _bad in _sls.group(0):
            problems.append('LatinKeyboard.setLanguageSwitcher must not call %s: it hid the language name on the space bar when there was one language or the device language' % _bad)

# --- Words for ONE app (MrApp, MrAppList, MrAppPicker; the choice on "Add words and texts" and on "What the keyboard learned"): every text of the choice is in the three
# languages with the same %n$ holes; the manifest asks for the apps that have a launcher icon (Android 11+ hides the others) and not for every package; LatinIME,
# AutoDictionary and UserBigramDictionary call MrApp; the Java layer cannot ask for the list of every package.
app_names = ('mr_app_card_title', 'mr_app_all', 'mr_app_only', 'mr_app_search', 'mr_app_loading', 'mr_app_none', 'mr_app_none_installed', 'mr_app_note', 'mr_app_note_all',
             'mr_app_scope_title', 'mr_app_scope_pick', 'mr_app_scope_empty', 'mr_import_for_app', 'mr_import_added_app', 'mr_import_undo_ask_app',
             'mr_learned_empty_added_app', 'mr_learned_empty_added_apps', 'mr_learned_delete_ask_app')
for k in app_names:
    holes = []
    for folder, tab in (('values', orig), ('values-pt-rBR', pt), ('values-es', es)):
        if k not in tab or not tab[k].strip():
            problems.append('words for an app: %s is missing from %s' % (k, folder))
            holes.append(None)
        else:
            holes.append(sorted(re.findall(r'%\d\$[sd]', tab[k])))
    if None not in holes and not (holes[0] == holes[1] == holes[2]):
        problems.append('words for an app: %s has different %%n$ holes in the three languages: %s' % (k, holes))
manifest_txt = read_file('AndroidManifest.xml')
if 'android.intent.category.LAUNCHER' not in manifest_txt.split('<queries>')[-1].split('</queries>')[0]:
    problems.append('AndroidManifest.xml: <queries> must ask for the apps with a launcher icon (the list of apps of the choice "Add to" on Android 11+)')
if 'QUERY_ALL_PACKAGES' in manifest_txt:
    problems.append('AndroidManifest.xml: QUERY_ALL_PACKAGES must not be asked for (the list uses the launcher query)')
for smali_file, needle in (('LatinIME.smali', 'MrApp;->onInput('), ('AutoDictionary.smali', 'MrApp;->words('), ('AutoDictionary.smali', 'MrApp;->isValid('), ('UserBigramDictionary.smali', 'MrApp;->getBigrams(')):
    if needle not in read_file('smali/com/mrkeyboard/app/' + smali_file):
        problems.append('%s: the call %s (words for an app) is missing' % (smali_file, needle))
if 'MrApp.onLoad(' not in read_file('docs/tools/java/src/com/mrkeyboard/app/MrLearned.java'):
    problems.append('MrLearned.load must call MrApp.onLoad (the tree of the app is made again with the dictionaries)')
for src_name in ('MrApp.java', 'MrAppList.java', 'MrAppPicker.java'):
    src_txt = read_file('docs/tools/java/src/com/mrkeyboard/app/' + src_name)
    if 'getInstalledApplications' in src_txt or 'getInstalledPackages' in src_txt:
        problems.append('%s: the list of apps comes from the launcher query (queryIntentActivities), not from the list of every package' % src_name)
# --- AI Editor dialog: the style chips, the result field and the "Emojificar" button and box use the lighter navy (mr_ui_raised) with mr_ui_stroke_strong
ai_src = read_file('docs/tools/java/src/com/mrkeyboard/app/MrAi.java')
if ai_src.count('"mr_ui_raised"') != 4 or ai_src.count('"mr_ui_stroke_strong"') != 4:
    problems.append('MrAi: the chips, the result field and the Emojificar button and box (4 places) must use mr_ui_raised with mr_ui_stroke_strong')
if 'mr_ui_field' in ai_src:
    problems.append('MrAi: mr_ui_field and mr_ui_field_line were replaced by mr_ui_raised and mr_ui_stroke_strong')
# --- Key sounds (MrKeySound, MrSoundActivity): the screen builds the names of its strings and of the raw files from the style ids, so the references below are
# not seen by the unused-resource check. Every style needs its sound file and its name (mute too) in the three languages, and no sound file may be left without a style.
snd_src = read_file('docs/tools/java/src/com/mrkeyboard/app/MrKeySound.java')
snd_styles = re.findall(r'"([a-z0-9]+)"', snd_src[snd_src.index('STYLES = {'):snd_src.index('};', snd_src.index('STYLES = {'))])
if len(snd_styles) != 13:
    problems.append('MrKeySound.STYLES: 13 styles expected, found %d' % len(snd_styles))
snd_files = sorted(f for f in os.listdir('res/raw') if f.startswith('mr_snd_'))
if snd_files != sorted('mr_snd_%s.ogg' % st for st in snd_styles):
    problems.append('res/raw: the mr_snd_*.ogg files and MrKeySound.STYLES do not match')
for lang in ('values', 'values-es', 'values-pt-rBR'):
    texts = read_file('res/%s/mr_strings.xml' % lang)
    for name in ['mr_sound_' + k for k in ('title', 'summary', 'styles', 'volume', 'default', 'default_note', 'muted', 'try', 'other_ime')] + ['mr_sound_name_' + st for st in ['mute'] + snd_styles]:
        if '<string name="%s">' % name not in texts:
            problems.append('%s/mr_strings.xml: string %s of the Keyboard sound screen is missing' % (lang, name))
# SoundPool.load(Context, int, int) opens the raw resource as a file descriptor, which Android refuses for a compressed entry (the sound would never play and
# every key would fall back to the system click): the sounds must be stored. apktool reads apktool.yml (apktool.json is the same list for the other tool).
if '\n- ogg' not in read_file('apktool.yml').split('doNotCompress:')[-1]:
    problems.append('apktool.yml: ogg must be in doNotCompress (SoundPool.load of a raw resource needs it stored; the APK is built from this file)')
if '"ogg"' not in read_file('apktool.json'):
    problems.append('apktool.json: ogg must stay in doNotCompress (same list as apktool.yml)')
if 'MrKeySound;->play' not in read_file('smali/com/mrkeyboard/app/LatinIME.smali'):
    problems.append('LatinIME.playKeyClick: the call to MrKeySound.play is missing')
# The see-through cards: a layout that takes its card or its background from the theme (?attr/mrCard...) must find the attribute in every theme it
# is inflated under (every screen of the app has Theme.MrKeyboard.Settings or its child), and MrMatrixGlass must replace each one that is used.
# Only the rows of the settings, the home screen and the sheets use them: the dialogs and the notification layouts are inflated under other themes.
theme_xml = read_file('res/values/mr_theme.xml')
settings_theme = re.search(r'<style name="Theme\.MrKeyboard\.Settings"[^>]*>(.*?)</style>', theme_xml, re.S)
glass_style = re.search(r'<style name="MrMatrixGlass">(.*?)</style>', theme_xml, re.S)
attrs_xml = read_file('res/values/mr_attrs.xml')
glass_users = set()
for f in sorted(os.listdir('res/layout')):
    for attr in re.findall(r'\?attr/(mr(?:Card|CardFlat|Hero|ScreenBg|SheetFixed))\b', read_file('res/layout/' + f)):
        glass_users.add((f, attr))
        if '<attr name="%s"' % attr not in attrs_xml:
            problems.append('mr_attrs.xml: attribute %s (used by layout/%s) is not declared' % (attr, f))
        if not settings_theme or '<item name="%s">' % attr not in settings_theme.group(1):
            problems.append('mr_theme.xml: Theme.MrKeyboard.Settings has no value for %s (layout/%s uses it)' % (attr, f))
        if not glass_style or '<item name="%s">' % attr not in glass_style.group(1):
            problems.append('mr_theme.xml: MrMatrixGlass has no see-through value for %s (layout/%s uses it)' % (attr, f))
allowed_glass = {'main.xml', 'mr_ui_pref_hero.xml', 'mr_ui_pref_row.xml', 'mr_ui_pref_row_value.xml', 'mr_ui_pref_row_metrics.xml',
                 'mr_ui_pref_row_static.xml', 'mr_ui_pref_row_last.xml', 'mr_sheets_screen.xml', 'mr_sheet_ed_screen.xml', 'mr_sheet_card.xml',
                 'mr_sheet_ed_test_card.xml', 'mr_sheet_fixed_card.xml'}
for f, attr in sorted(glass_users):
    if f not in allowed_glass:
        problems.append('layout/%s uses ?attr/%s: only the rows of the settings, the home screen and the sheets are inflated under the theme that has it' % (f, attr))
if glass_style:
    for ref in re.findall(r'@drawable/(\w+)', glass_style.group(1)):
        if not os.path.exists('res/drawable/%s.xml' % ref):
            problems.append('mr_theme.xml: MrMatrixGlass uses drawable %s, which does not exist' % ref)
if glass_style and 'android:alertDialogTheme' not in glass_style.group(1):
    problems.append('mr_theme.xml: MrMatrixGlass must change android:alertDialogTheme (the dialogs of the screen are a little see-through with the effect)')
for src_name in ('MrVersion', 'MrUpdateDialog'):
    if 'MrMatrix.dialogTheme(a, theme)' not in read_file('docs/tools/java/src/com/mrkeyboard/app/%s.java' % src_name):
        problems.append('%s.java: the dialog is opened with an explicit theme and must ask MrMatrix.dialogTheme (the effect makes it a little see-through)' % src_name)
if 'MrMatrixGlass' not in matrix_src or 'applyStyle(style, true)' not in matrix_src:
    problems.append('MrMatrix: the see-through style (MrMatrixGlass) must be laid over the theme, forced, when the rain is put')
screens_src = read_file('docs/tools/java/src/com/mrkeyboard/app/MrScreens.java')
if 'MrMatrix.KEY.equals(key)' not in screens_src or 'MrMatrix.attach(activity)' not in screens_src:
    problems.append('MrScreens: the Matrix setting must create the screen again (onSetting) and the screen must get the rain when it is created')
if 'KEY_HW_ACCEL = "pref_ui_hw_accel"' not in screens_src or 'getBoolean(KEY_HW_ACCEL, false)' not in screens_src:
    problems.append('MrScreens: the key of the setting is not pref_ui_hw_accel or the default is not false')
install_body = screens_src[screens_src.index('public static void install('):screens_src.index('public static void onSetting(')]
if 'SDK_INT' in install_body:
    problems.append('MrScreens.install: must register on every Android (the acceleration setting works on all; the insets check is in onActivityStarted)')
adv_smali = read_file('smali/com/mrkeyboard/app/PrefScreenAdvanced.smali')
changed = adv_smali[adv_smali.find('.method public onSharedPreferenceChanged('):]
if 'MrScreens;->onSetting(Landroid/app/Activity;Ljava/lang/String;)V' not in changed:
    problems.append('PrefScreenAdvanced.onSharedPreferenceChanged must call MrScreens.onSetting (the screen is created again with the new acceleration)')
# the read-only row "Keyboard drawing" (what MrAccel measured on the keyboard window): not a stored setting, filled when the screen
# comes back, and the answer lives in a file of its own that the backup does not take
kbd_row = [t for t in re.findall(r'<Preference\b[^>]*>', adv_xml) if 'android:key="mr_kbd_accel"' in t]
if len(kbd_row) != 1:
    problems.append('prefs_advanced.xml: the row mr_kbd_accel is missing or repeated')
else:
    for attr in ('android:persistent="false"', 'android:selectable="false"', 'android:title="@string/mr_ui_kbd_accel"',
                 'android:summary="@string/mr_ui_kbd_accel_unknown"'):
        if attr not in kbd_row[0]:
            problems.append('prefs_advanced.xml: mr_kbd_accel needs %s' % attr)
accel_src = read_file('docs/tools/java/src/com/mrkeyboard/app/MrAccel.java')
if 'ROW = "mr_kbd_accel"' not in accel_src or 'PREFS = "mr_diag"' not in accel_src:
    problems.append('MrAccel: the row key is not mr_kbd_accel or the file of the answer is not mr_diag')
for rules in ('res/xml/backup_rules.xml', 'res/xml/data_extraction_rules.xml'):
    if 'mr_diag' in read_file(rules):
        problems.append('%s: the diagnostic file mr_diag must stay out of the backup (it describes this device)' % rules)
for name in ('mr_ui_kbd_accel_on', 'mr_ui_kbd_accel_off', 'mr_ui_kbd_accel_unknown', 'mr_ui_scr_accel_off', 'mr_ui_scr_accel_asked',
             'mr_ui_scr_accel_system', 'mr_ui_scr_accel_refused'):
    if '"%s"' % name not in accel_src:
        problems.append('MrAccel: no longer names the string %s' % name)
# the second read-only row, "Drawing of this screen": what the app asked (flag of the window) against what the system gave
scr_row = [t for t in re.findall(r'<Preference\b[^>]*>', adv_xml) if 'android:key="mr_scr_accel"' in t]
if len(scr_row) != 1:
    problems.append('prefs_advanced.xml: the row mr_scr_accel is missing or repeated')
else:
    for attr in ('android:persistent="false"', 'android:selectable="false"', 'android:title="@string/mr_ui_scr_accel"',
                 'android:summary="@string/mr_ui_scr_accel_unknown"'):
        if attr not in scr_row[0]:
            problems.append('prefs_advanced.xml: mr_scr_accel needs %s' % attr)
if 'ROW_SCREEN = "mr_scr_accel"' not in accel_src or 'FLAG_HW = WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED' not in accel_src:
    problems.append('MrAccel: the row of the screen is not mr_scr_accel or the flag is not WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED')
adv_resume = adv_smali[adv_smali.find('.method protected onResume()V'):]
adv_resume = adv_resume[:adv_resume.find('.end method')]
if 'MrAccel;->fill(Landroid/preference/PreferenceActivity;)V' not in adv_resume:
    problems.append('PrefScreenAdvanced.onResume must call MrAccel.fill (the row of the keyboard drawing)')
shown = ime_smali[ime_smali.find('.method public onWindowShown()V'):]
shown = shown[:shown.find('.end method')]
if 'MrAccel;->onShown(Landroid/inputmethodservice/InputMethodService;)V' not in shown:
    problems.append('LatinIME.onWindowShown must call MrAccel.onShown (the log line of the keyboard window)')

# --- edge-to-edge (Android 15+): the app is drawn under the bars on purpose and MrScreens puts the padding. Nobody opts out of
# the enforcement (the attribute is ignored from Android 16 anyway and would hide the work), the theme of the screens keeps the
# colour of the bars for the Androids before 15 and for the 3-button bar, and every screen uses a theme of the app
for p in glob.glob('res/**/*.xml', recursive=True) + ['AndroidManifest.xml']:
    if 'windowOptOutEdgeToEdgeEnforcement' in read_file(p):
        problems.append('%s: windowOptOutEdgeToEdgeEnforcement must not be used (MrScreens handles the insets)' % p)
theme_file = read_file('res/values/mr_theme.xml')
def style_of(name):
    m = re.search(r'<style name="%s"(?: parent="([^"]*)")?[^>]*>(.*?)</style>' % re.escape(name), theme_file, re.S)
    return (m.group(1), m.group(2)) if m else (None, None)
settings_parent, settings_body = style_of('Theme.MrKeyboard.Settings')
main_parent, main_body = style_of('Theme.MrKeyboard.Main')
if settings_body is None or main_body is None:
    problems.append('mr_theme.xml: Theme.MrKeyboard.Settings or Theme.MrKeyboard.Main is missing')
else:
    for item in ('statusBarColor', 'navigationBarColor'):
        want = '<item name="android:%s">@color/mr_ui_bg</item>' % item
        if want not in settings_body:
            problems.append('Theme.MrKeyboard.Settings: %s must be @color/mr_ui_bg (the bars of the Androids before 15)' % item)
        if main_parent != '@style/Theme.MrKeyboard.Settings' and want not in main_body:
            problems.append('Theme.MrKeyboard.Main: neither inherits from Settings nor sets %s' % item)
    for item in ('statusBarColor', 'navigationBarColor'):
        for body, who in ((settings_body, 'Settings'), (main_body, 'Main')):
            if re.search(r'<item name="android:%s">(?!@color/mr_ui_bg)' % item, body):
                problems.append('Theme.MrKeyboard.%s: %s with a colour other than the screen background' % (who, item))
HELPER_SCREENS = ('ActivityHelper', 'ShotPerm', 'ShotPick')
for tag in manifest_tags:
    name = re.search(r'android:name="[\w.]*\.(\w+)"', tag).group(1)
    theme = re.search(r'android:theme="([^"]*)"', tag)
    if name in HELPER_SCREENS:
        if not theme or 'Translucent' not in theme.group(1):
            problems.append('manifest: the helper window %s must stay translucent' % name)
    elif not theme or not theme.group(1).startswith('@style/Theme.MrKeyboard.'):
        problems.append('manifest: screen %s without a Theme.MrKeyboard theme (its bars and colours would be the system ones)' % name)
if 'MrScreens;->install(Landroid/app/Application;)V' not in read_file('smali/com/mrkeyboard/app/MrApplication.smali'):
    problems.append('MrApplication.onCreate must call MrScreens.install (insets and acceleration of the screens)')

# --- every test of the PC is in the runner (a test that nobody runs proves nothing); only a folder with a README, which says how
# it is run by hand (it needs a network, an APK or fixtures), is left out
runner = read_file('docs/tools/run_java_tests.sh')
for folder in sorted(glob.glob('docs/tools/*_test')):
    if os.path.exists(folder + '/README.md'): continue
    for test in sorted(glob.glob(folder + '/*Test.java')):
        if '/' + os.path.basename(folder) + '/' + os.path.basename(test) not in runner.replace('$D', ''):
            problems.append('%s: not in docs/tools/run_java_tests.sh (run it there, or explain in a README.md how it is run by hand)' % test)

# --- targetSdk 37 (Android 17): the three files that say it agree, the compile SDK is not below it, and nothing in the app does what
# a target-37 app can no longer do (https://developer.android.com/about/versions/17/behavior-changes-17)
target_yml = re.search(r"targetSdkVersion: '(\d+)'", read_file('apktool.yml'))
target_json = re.search(r'"targetSdkVersion": "(\d+)"', read_file('apktool.json'))
manifest_head = re.search(r'<manifest\b[^>]*>', manifest_text).group(0)
compile_sdk = re.search(r'android:compileSdkVersion="(\d+)"', manifest_head)
platform_sdk = re.search(r'platformBuildVersionCode="(\d+)"', manifest_head)
if not (target_yml and target_json and compile_sdk and platform_sdk):
    problems.append('target SDK: apktool.yml, apktool.json or the head of the manifest has no SDK number')
else:
    if target_yml.group(1) != target_json.group(1):
        problems.append('target SDK: apktool.yml says %s and apktool.json %s' % (target_yml.group(1), target_json.group(1)))
    if compile_sdk.group(1) != platform_sdk.group(1) or int(compile_sdk.group(1)) < int(target_yml.group(1)):
        problems.append('target SDK: compileSdkVersion %s / platformBuildVersionCode %s must match and not be below the target %s' % (
            compile_sdk.group(1), platform_sdk.group(1), target_yml.group(1)))
    if int(target_yml.group(1)) < 37:
        problems.append('target SDK: %s, the plan raised it to 37 (Android 17)' % target_yml.group(1))
TARGET37 = (
    (r'Ljava/lang/System;->load\(', 'System.load of a file (a target-37 app can only load read-only native libraries; the app uses System.loadLibrary from the APK)'),
    (r'Ljava/lang/Runtime;->load\(', 'Runtime.load of a file (same limit as System.load)'),
    (r'Ljava/lang/reflect/Field;->set', 'a reflective write to a field (static final fields cannot be written at target 37)'),
    (r'->setAccessible\(', 'setAccessible (reflection on a private member breaks with the lock-free MessageQueue and static final fields of Android 17)'),
    (r'ActivityOptions;->setPendingIntentBackgroundActivityStartMode', 'a background activity start mode (hardened for IntentSender at target 37)'),
)
for pattern, what in TARGET37:
    if re.search(pattern, smali):
        owners = sorted({os.path.basename(f) for f in glob.glob('smali*/**/*.smali', recursive=True) if re.search(pattern, read_file(f))})
        if owners:
            problems.append('target 37: %s found in %s' % (what, ', '.join(owners[:5])))
for tag in manifest_tags:
    for attr in ('android:screenOrientation=', 'android:resizeableActivity="false"', 'android:minAspectRatio=', 'android:maxAspectRatio='):
        if attr in tag:
            problems.append('manifest: %s in %s: target 37 ignores orientation and resizability limits on screens of 600 dp or more' % (
                attr, re.search(r'android:name="([^"]+)"', tag).group(1)))

# --- fonts tool (MrFonts): the style N is named by mr_font_style_N, in the 3 languages (every name different from the others in its language); the
# other texts of the tool and the counter of the clipboard panel (mr_tb_clip_count_one / _many, with %1$d) exist in the 3 languages too.
fonts_src = read_file('docs/tools/java/src/com/mrkeyboard/app/MrFonts.java')
styles_m = re.search(r'static final int STYLES = (\d+);', fonts_src)
if not styles_m:
    problems.append('fonts: MrFonts.STYLES not found')
else:
    n_styles = int(styles_m.group(1))
    want_keys = sorted('mr_font_style_%d' % i for i in range(n_styles))
    for folder, tab in (('values', orig), ('values-pt-rBR', pt), ('values-es', es)):
        style_keys = sorted(k for k in tab if re.match(r'mr_font_style_\d+$', k))
        if style_keys != want_keys:
            problems.append('fonts: %s must have mr_font_style_0..mr_font_style_%d (MrFonts.STYLES = %d), it has %d' % (folder, n_styles - 1, n_styles, len(style_keys)))
        names = [tab[k].strip() for k in style_keys]
        if len(set(names)) != len(names) or '' in names:
            problems.append('fonts: the style names of %s must be different from each other and not empty: %s' % (folder, sorted(n for n in names if names.count(n) > 1 or not n)))
    for k in ('mr_tb_fonts', 'mr_font_default'):
        for folder, tab in (('values', orig), ('values-pt-rBR', pt), ('values-es', es)):
            if k not in tab:
                problems.append('fonts: %s is missing from %s' % (k, folder))
    for k in ('mr_tb_clip_count_one', 'mr_tb_clip_count_many'):
        for folder, tab in (('values', orig), ('values-pt-rBR', pt), ('values-es', es)):
            if k not in tab:
                problems.append('clipboard counter: %s is missing from %s' % (k, folder))
            elif tab[k].count('%1$d') != 1:
                problems.append('clipboard counter: %s in %s needs exactly one %%1$d' % (k, folder))

print('resources: %d defined, %d entries in public.xml, %d strings in Spanish' % (len(defs), len(pub), len(es)))
for p in problems:
    print('PROBLEM:', p)
sys.exit(1 if problems else 0)
