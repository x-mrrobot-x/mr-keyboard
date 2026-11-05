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
# the seven buttons of bar_tools, and MrTools.onClick has to call MrBarClose first
tools_smali = read_file('smali/com/mrkeyboard/app/MrTools.smali')
bound = {}
for m in re.finditer(r'const-string v1, "(b_\w+)"\s+(?:\.line \d+\s+)?const/(?:4|16) v2, (-?0x[0-9a-f]+)\s+(?:\.line \d+\s+)?invoke-static \{v0, v1, v2\}, Lcom/mrkeyboard/app/MrTools;->btn', tools_smali):
    bound[m.group(1)] = int(m.group(2), 16)
bar_src = read_file('docs/tools/java/src/com/mrkeyboard/app/MrBarClose.java')
listed = re.search(r'TOOLBAR = \{([^}]*)\}', bar_src)
listed = sorted(int(x.strip(), 16) for x in listed.group(1).split(',')) if listed else []
if sorted(bound) != ['b_aied', 'b_clip', 'b_emote', 'b_sheets', 'b_shots', 'b_trans', 'b_tune']:
    problems.append('MrTools: the buttons of the bar are not the seven expected (found %s)' % sorted(bound))
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
screens_src = read_file('docs/tools/java/src/com/mrkeyboard/app/MrScreens.java')
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
        problems.append('target 37: %s found in %s' % (what, ', '.join(owners[:5])))
for tag in manifest_tags:
    for attr in ('android:screenOrientation=', 'android:resizeableActivity="false"', 'android:minAspectRatio=', 'android:maxAspectRatio='):
        if attr in tag:
            problems.append('manifest: %s in %s: target 37 ignores orientation and resizability limits on screens of 600 dp or more' % (
                attr, re.search(r'android:name="([^"]+)"', tag).group(1)))

print('resources: %d defined, %d entries in public.xml, %d strings in Spanish' % (len(defs), len(pub), len(es)))
for p in problems:
    print('PROBLEM:', p)
sys.exit(1 if problems else 0)
