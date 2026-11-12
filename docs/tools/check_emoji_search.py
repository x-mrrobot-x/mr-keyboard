#!/usr/bin/env python3
"""Checks the emoji search of the panel (1.97.0). Run at the project root; exits with 1 if it finds a problem.

  - every view tag that MrEmojiSearch.java looks for is in res/layout/mr_toolbar.xml, and the layout has the floating bar
    (emote_fab) inside p_emote and the header (bar_es);
  - the texts mr_es_* exist in the 3 languages (values, values-pt-rBR, values-es) and the dimens/integer in values and values-land;
  - MrTools.smali calls the three hooks (setup, onPanel, afterPanel) of MrEmojiSearch;
  - the panel mode of the search (MrEmojiSearch.MODE) is not one the other panels use;
  - the newer emojis (MrEmojiNew.java, merged into the base list of the panel by MrEmotes.data): the smali wrapper calls MrEmojiNew.merge,
    the table has 8 categories, every anchor is an emoji of its category in the base list, no new emoji is in the base list or in the table
    twice, and every one has U+FE0F where the panel writes it (after the characters it writes with it);
  - the words (res/raw/mr_emoji_en, _pt, _es): the same emojis in the same order as the panel (the base list of MrEmotes.smali with the newer
    ones put in), the line format, almost every emoji with words (docs/tools/make_emoji_search.py builds them from the CLDR annotations),
    every newer emoji with words in the three languages, no stray character;
  - docs/emoji-search.md carries the Unicode licence notice and the raw files say where the words come from.
"""
import os, re, sys
import xml.dom.minidom

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import make_emoji_search as mk

problems = []


def read(p):
    return open(p, encoding='utf-8').read()


java = read('docs/tools/java/src/com/mrkeyboard/app/MrEmojiSearch.java')
layout = read('res/layout/mr_toolbar.xml')
xml.dom.minidom.parseString(layout.encode('utf-8'))

# --- tags
tags = set(re.findall(r'findViewWithTag\("([\w]+)"\)', java)) | {'es_back', 'emote_search', 'emote_del', 'emote_fab', 'es_card', 'es_div', 'es_title', 'es_icon'}
for t in sorted(tags):
    if 'android:tag="%s"' % t not in layout:
        problems.append('MrEmojiSearch looks for the tag "%s" and mr_toolbar.xml has no view with it' % t)
for t in ('es_field', 'es_grid', 'es_scroll', 'es_empty', 'bar_es', 'bar_main'):
    if 'android:tag="%s"' % t not in layout:
        problems.append('mr_toolbar.xml: no view tagged "%s"' % t)
doc = xml.dom.minidom.parseString(layout.encode('utf-8'))


def by_tag(tag):
    for n in doc.getElementsByTagName('*'):
        if n.getAttribute('android:tag') == tag:
            return n
    return None


def inside(node, ancestor):
    while node is not None:
        if node is ancestor:
            return True
        node = node.parentNode
    return False


fab, pemote = by_tag('emote_fab'), by_tag('p_emote')
if fab is None or pemote is None or not inside(fab, pemote):
    problems.append('the floating bar (emote_fab) must be inside the emoji panel (p_emote)')
for t in ('emote_search', 'emote_del'):
    n = by_tag(t)
    if n is None or not inside(n, fab):
        problems.append('the button "%s" must be inside emote_fab' % t)
    elif not n.getAttribute('android:contentDescription').startswith('@string/mr_es_'):
        problems.append('the button "%s" needs a contentDescription (@string/mr_es_...) for accessibility' % t)
if pemote is not None and pemote.tagName != 'FrameLayout':
    problems.append('p_emote must be a FrameLayout (the bar floats over the list)')
bar = by_tag('bar_es')
if bar is not None and bar.getAttribute('android:visibility') != 'gone':
    problems.append('bar_es must start gone')

# --- texts and sizes
STRINGS = ('mr_es_title', 'mr_es_hint', 'mr_es_empty', 'mr_es_search', 'mr_es_delete')
for d in ('values', 'values-pt-rBR', 'values-es'):
    text = read('res/%s/mr_strings.xml' % d)
    for k in STRINGS:
        if not re.search(r'<string name="%s">[^<]+</string>' % k, text):
            problems.append('res/%s/mr_strings.xml: no text %s' % (d, k))
for d in ('values', 'values-land'):
    text = read('res/%s/dimens.xml' % d)
    for k in ('mr_es_height', 'mr_es_title_height'):
        if 'name="%s"' % k not in text:
            problems.append('res/%s/dimens.xml: no dimen %s' % (d, k))
    if 'name="mr_es_rows"' not in read('res/%s/integers.xml' % d):
        problems.append('res/%s/integers.xml: no integer mr_es_rows' % d)
for k in ('mr_es_title', 'mr_es_hint', 'mr_es_empty', 'mr_es_search', 'mr_es_delete'):
    if '@string/%s' % k not in layout:
        problems.append('mr_toolbar.xml does not use @string/%s' % k)

# --- hooks and mode
tools = read('smali/com/mrkeyboard/app/MrTools.smali')
for sig, n in (('MrEmojiSearch;->setup(Landroid/view/View;)V', 1), ('MrEmojiSearch;->onPanel(I)V', 1), ('MrEmojiSearch;->afterPanel(I)V', 2)):
    if tools.count(sig) != n:
        problems.append('MrTools.smali: %d call(s) of %s, expected %d' % (tools.count(sig), sig, n))
mode = re.search(r'static final int MODE = (\d+);', java)
if not mode:
    problems.append('MrEmojiSearch.MODE not found')
else:
    others = {}
    for f in ('MrFonts',):
        m = re.search(r'static final int MODE = (\d+);', read('docs/tools/java/src/com/mrkeyboard/app/%s.java' % f))
        if m:
            others[f] = int(m.group(1))
    if int(mode.group(1)) in list(others.values()) + [0, 1, 2, 3, 4, 5]:
        problems.append('the panel mode %s of the search is used by another panel' % mode.group(1))

# --- the newer emojis
emotes = read('smali/com/mrkeyboard/app/MrEmotes.smali')
if 'MrEmojiNew;->merge(ILjava/lang/String;)Ljava/lang/String;' not in emotes:
    problems.append('MrEmotes.smali: data(I) does not call MrEmojiNew.merge(ILjava/lang/String;)Ljava/lang/String;')
if emotes.count('.method static dataBase(I)Ljava/lang/String;') != 1 or emotes.count('.method static data(I)Ljava/lang/String;') != 1:
    problems.append('MrEmotes.smali: expected data(I) (merges) and dataBase(I) (the base list), one of each')
if not re.search(r'static (synchronized )?String merge\(int \w+, String \w+\)', read('docs/tools/java/src/com/mrkeyboard/app/MrEmojiNew.java')):
    problems.append('MrEmojiNew.java: merge(int, String) not found (MrEmotes.smali calls it)')
base_cats = mk.base_categories()
new_cats = mk.new_groups()
newer = []
if len(base_cats) != 8 or len(new_cats) != 8:
    problems.append('the base list has %d categories and the table of MrEmojiNew has %d; both must have 8' % (len(base_cats), len(new_cats)))
else:
    base_all = {mk.key(e) for c in base_cats for e in c}
    # the characters the panel writes with U+FE0F after them
    with_fe0f = set()
    for c in base_cats:
        for e in c:
            for i, ch in enumerate(e[:-1]):
                if e[i + 1] == mk.FE0F:
                    with_fe0f.add(ch)
    seen_new = set()
    for ci, groups in enumerate(new_cats):
        anchors = set()
        for g in groups:
            if len(g) < 2:
                problems.append('MrEmojiNew category %d: a group without anything new: %r' % (ci, g))
                continue
            if g[0] not in base_cats[ci]:
                problems.append('MrEmojiNew category %d: the anchor %s is not in the base list of that category' % (ci, g[0]))
            if g[0] in anchors:
                problems.append('MrEmojiNew category %d: two groups with the anchor %s' % (ci, g[0]))
            anchors.add(g[0])
            for e in g[1:]:
                newer.append(e)
                if mk.key(e) in base_all:
                    problems.append('MrEmojiNew: %s is in the base list of the panel already' % e)
                if e in seen_new:
                    problems.append('MrEmojiNew: %s twice' % e)
                seen_new.add(e)
                if '|' in e or not e:
                    problems.append('MrEmojiNew: a bad emoji in category %d' % ci)
                for i, ch in enumerate(e):
                    if ch in with_fe0f and not (i + 1 < len(e) and e[i + 1] == mk.FE0F) and ord(ch) > 0x7f:
                        problems.append('MrEmojiNew: %s needs U+FE0F after U+%04X (the panel writes it so)' % (e, ord(ch)))
                        break
                    if ch == mk.FE0F and (i == 0 or e[i - 1] not in with_fe0f):
                        problems.append('MrEmojiNew: %s has a U+FE0F the panel would not put there' % e)
                        break
    if len(newer) < 100:
        problems.append('MrEmojiNew has %d emojis; fewer than expected (100)' % len(newer))

# --- the words
panel = mk.panel_emojis()
langs = {}
for lang in mk.LANGS:
    path = 'res/raw/mr_emoji_%s.txt' % lang
    if not os.path.exists(path):
        problems.append('%s is missing (docs/tools/make_emoji_search.py makes it from the CLDR files)' % path)
        continue
    raw = open(path, 'rb').read()
    try:
        text = raw.decode('utf-8')
    except UnicodeDecodeError:
        problems.append('%s is not UTF-8' % path)
        continue
    if '\r' in text:
        problems.append('%s has carriage returns' % path)
    lines = [l for l in text.split('\n') if l and not l.startswith('# ')]
    head = '\n'.join(l for l in text.split('\n') if l.startswith('# '))
    if 'Unicode' not in head or 'CLDR' not in head:
        problems.append('%s: the header must say the words come from the Unicode CLDR' % path)
    emojis = [l.split('\t')[0] for l in lines]
    if any('\t' not in l for l in lines):
        problems.append('%s: a line without the TAB' % path)
    if emojis != panel:
        extra = [e for e in emojis if e not in panel][:5]
        gone = [e for e in panel if e not in emojis][:5]
        problems.append('%s: the emojis are not the panel ones in the panel order (%d lines, panel %d; not in the panel: %s; missing: %s)' % (path, len(emojis), len(panel), extra, gone))
    empty = [l.split('\t')[0] for l in lines if '\t' in l and not l.split('\t', 1)[1].strip()]
    if len(empty) > 0.03 * len(panel):
        problems.append('%s: %d emojis without words (more than 3%%): %s' % (path, len(empty), ' '.join(empty[:20])))
    lacking = [l.split('\t')[0] for l in lines if l.split('\t')[0] in set(newer) and not l.split('\t', 1)[1].strip()]
    if lacking:
        problems.append('%s: newer emojis without words: %s' % (path, ' '.join(lacking[:20])))
    for l in lines:
        body = l.split('\t', 1)[1] if '\t' in l else ''
        if '\t' in body:
            problems.append('%s: a second TAB in the line of %s' % (path, l.split('\t')[0]))
            break
    langs[lang] = len(raw)
    if len(raw) > 400000:
        problems.append('%s is %d bytes: too big for what the keyboard carries (400000)' % (path, len(raw)))

# --- licence
if not os.path.exists('docs/LICENSE-Unicode-CLDR.txt'):
    problems.append('docs/LICENSE-Unicode-CLDR.txt is missing (the text of the Unicode licence, copied by make_emoji_search.py from the CLDR repository)')
else:
    lic = read('docs/LICENSE-Unicode-CLDR.txt')
    if 'nicode' not in lic or 'opyright' not in lic or len(lic) < 500:
        problems.append('docs/LICENSE-Unicode-CLDR.txt does not look like the full Unicode licence')
if not os.path.exists('docs/emoji-search.md'):
    problems.append('docs/emoji-search.md is missing')
else:
    md = read('docs/emoji-search.md')
    if 'Unicode License' not in md or 'unicode.org/copyright' not in md:
        problems.append('docs/emoji-search.md must carry the Unicode licence notice (Unicode License and the link unicode.org/copyright)')

if problems:
    for p in problems:
        print('PROBLEM: ' + p)
    sys.exit(1)
print('emoji search: layout, texts, hooks and words ok (%s)' % ', '.join('%s %d bytes' % kv for kv in sorted(langs.items())))
