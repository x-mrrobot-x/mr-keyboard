#!/usr/bin/env python3
"""Makes the words of the emoji search (res/raw/mr_emoji_en.txt, mr_emoji_pt.txt, mr_emoji_es.txt) from the CLDR annotations.

Input: the six files of the Unicode CLDR (common/annotations/{en,pt,es}.xml and common/annotationsDerived/{en,pt,es}.xml), in a
folder or a .zip, either with those paths or named annotations_en.xml, derived_en.xml, ... (docs/emoji-search.md says where they
come from). The emojis are the ones of the panel: the base list (MrEmotes.smali, 8 categories, in that order) with the newer ones
of the table MrEmojiNew.java put in their places, as the keyboard does when the phone can draw all of them.

Output, one file per language, UTF-8, one line per emoji of the panel (also the ones CLDR has no words for: the line ends at the
TAB, so the three files list the same emojis in the same order, which MrEmojiIndex relies on):
    emoji TAB name | keyword | keyword ...
Lines that start with "# " (a hash and a space) are comments; the keycap of the number sign is an emoji line that starts with a hash.
The emoji is written as the panel has it (with or without U+FE0F); CLDR is matched without U+FE0F on both sides.

Usage (at the project root):
    python3 docs/tools/make_emoji_search.py <folder-or-zip> [--out res/raw] [--cldr 47] [--max-missing 0.03] [--license-out docs/LICENSE-Unicode-CLDR.txt] [--smali ...] [--java ...]
The text of the Unicode licence asks to go with the data (docs/emoji-search.md). If the source has UNICODE_LICENSE.txt (the LICENSE of the
CLDR repository) it is copied, byte for byte, to --license-out; if not, --license-out has to exist already.
Exits with 1 when a language misses more than --max-missing of the emojis (the list is printed).
"""
import argparse, os, re, sys, tempfile, zipfile
import xml.etree.ElementTree as ET

LANGS = ('en', 'pt', 'es')
FE0F = '️'
SMALI = 'smali/com/mrkeyboard/app/MrEmotes.smali'
JAVA_NEW = 'docs/tools/java/src/com/mrkeyboard/app/MrEmojiNew.java'


def unescape(raw):
    """A string constant of the smali or of the Java source (\\uXXXX escapes, surrogate pairs) as text."""
    s = re.sub(r'\\u([0-9a-fA-F]{4})', lambda x: chr(int(x.group(1), 16)), raw)
    return s.encode('utf-16', 'surrogatepass').decode('utf-16')


def base_categories(smali_path=SMALI):
    """The base list of the panel, one list of emojis per category (0 to 7), read from the constants of MrEmotes.dataBase(I)."""
    text = open(smali_path, encoding='utf-8').read()
    start = text.index('.method static dataBase(I)Ljava/lang/String;')
    end = text.index('.end method', start)
    cats = []
    for m in re.finditer(r'const-string v0, "((?:[^"\\]|\\.)*)"', text[start:end]):
        cats.append([e for e in unescape(m.group(1)).split('|') if e])
    return [c for c in cats if c]   # the first constant is the empty one of a category that does not exist


def new_groups(java_path=JAVA_NEW):
    """The table of MrEmojiNew.java: for each category (0 to 7) the groups "anchor|new|new..." as lists of emojis."""
    text = open(java_path, encoding='utf-8').read()
    start = text.index('GROUPS = {') + len('GROUPS = {')
    end = text.index('\n    };', start)
    body = '\n'.join(l for l in text[start:end].split('\n') if not l.strip().startswith('//'))
    out = []
    for block in re.findall(r'\{([^{}]*)\}', body):
        out.append([unescape(s).split('|') for s in re.findall(r'"((?:[^"\\]|\\.)*)"', block)])
    return out


def merge_category(base, groups):
    """The same merge as MrEmojiNew.merge when the phone can draw everything: the new emojis right after their anchor, or at the end."""
    in_base = set(base)
    added = set()
    after = {}
    tail = []
    for part in groups:
        add = []
        for e in part[1:]:
            if e in in_base or e in added:
                continue
            added.add(e)
            add.append(e)
        if not add:
            continue
        if part[0] in in_base:
            after.setdefault(part[0], []).extend(add)
        else:
            tail.extend(add)
    out = []
    for e in base:
        out.append(e)
        out.extend(after.get(e, ()))
    return out + tail


def panel_emojis(smali_path=SMALI, java_path=JAVA_NEW):
    """The emojis of the panel, in order: the base list (MrEmotes.smali) with the new ones (MrEmojiNew.java) in their places."""
    base = base_categories(smali_path)
    groups = new_groups(java_path)
    out, seen = [], set()
    for c, cat in enumerate(base):
        for e in merge_category(cat, groups[c] if c < len(groups) else []):
            if e not in seen:
                seen.add(e)
                out.append(e)
    return out


def key(cp):
    return cp.replace(FE0F, '')


def read_annotations(path):
    """{key: [name or None, [keywords]]} of one CLDR annotations file."""
    root = ET.parse(path).getroot()
    out = {}
    for a in root.iter('annotation'):
        cp = a.get('cp')
        txt = (a.text or '').strip()
        if not cp or not txt:
            continue
        item = out.setdefault(key(cp), [None, []])
        if a.get('type') == 'tts':
            item[0] = txt
        else:
            item[1] = [w.strip() for w in txt.split('|') if w.strip()]
    return out


def find_files(folder):
    """{(kind, lang): path}: kind 'main' or 'derived'."""
    found = {}
    for dirpath, _, names in os.walk(folder):
        for n in names:
            p = os.path.join(dirpath, n)
            parent = os.path.basename(dirpath)
            for lang in LANGS:
                if n == 'annotations_%s.xml' % lang or (n == lang + '.xml' and parent == 'annotations'):
                    found[('main', lang)] = p
                if n == 'derived_%s.xml' % lang or (n == lang + '.xml' and parent == 'annotationsDerived'):
                    found[('derived', lang)] = p
    return found


def clean(s):
    return s.replace('\t', ' ').replace('|', '/').replace('\n', ' ').strip()


def build(emojis, main, derived):
    """Lines for one language and the list of emojis with no words."""
    lines, missing = [], []
    for e in emojis:
        item = main.get(key(e)) or derived.get(key(e))
        name, kws = (item[0], item[1]) if item else (None, [])
        if item and main.get(key(e)) and derived.get(key(e)):
            d = derived[key(e)]
            name = name or d[0]
            kws = kws or d[1]
        if not name and kws:
            name, kws = kws[0], kws[1:]
        if not name:
            lines.append(e + '\t')
            missing.append(e)
            continue
        parts = [clean(name)] + [clean(k) for k in kws if clean(k)]
        lines.append(e + '\t' + '|'.join(parts))
    return lines, missing


def main_(argv):
    ap = argparse.ArgumentParser()
    ap.add_argument('source')
    ap.add_argument('--out', default='res/raw')
    ap.add_argument('--cldr', default='unknown')
    ap.add_argument('--smali', default=SMALI)
    ap.add_argument('--java', default=JAVA_NEW, help='the table of the newer emojis (MrEmojiNew.java)')
    ap.add_argument('--max-missing', type=float, default=0.03)
    ap.add_argument('--license-out', default='docs/LICENSE-Unicode-CLDR.txt')
    args = ap.parse_args(argv)
    tmp = None
    src = args.source
    if os.path.isfile(src) and src.lower().endswith('.zip'):
        tmp = tempfile.mkdtemp()
        with zipfile.ZipFile(src) as z:
            for n in z.namelist():
                if os.path.normpath(n).startswith('..') or os.path.isabs(n):
                    sys.exit('unsafe path in the zip: ' + n)
            z.extractall(tmp)
        src = tmp
    files = find_files(src)
    need = [(k, l) for k in ('main', 'derived') for l in LANGS]
    absent = [n for n in need if n not in files]
    if absent:
        sys.exit('files not found: ' + ', '.join('%s/%s' % a for a in absent))
    lic = None
    for dirpath, _, names in os.walk(src):
        if 'UNICODE_LICENSE.txt' in names:
            lic = os.path.join(dirpath, 'UNICODE_LICENSE.txt')
    if lic is not None:
        raw = open(lic, 'rb').read()
        if b'nicode' not in raw or b'opyright' not in raw:
            sys.exit('UNICODE_LICENSE.txt does not look like the Unicode licence')
        os.makedirs(os.path.dirname(os.path.abspath(args.license_out)), exist_ok=True)
        with open(args.license_out, 'wb') as f:
            f.write(raw)
    elif not os.path.exists(args.license_out):
        sys.exit('the licence text is missing: no UNICODE_LICENSE.txt in the source and %s does not exist' % args.license_out)
    emojis = panel_emojis(args.smali, args.java)
    os.makedirs(args.out, exist_ok=True)
    bad = False
    for lang in LANGS:
        lines, missing = build(emojis, read_annotations(files[('main', lang)]), read_annotations(files[('derived', lang)]))
        header = ['# Words of the emoji search (%s): names and keywords from the Unicode CLDR annotations, release %s.' % (lang, args.cldr),
                  '# Copyright (c) Unicode, Inc. Distributed under the Unicode License (see docs/emoji-search.md).',
                  '# One line per emoji of the panel: emoji TAB name | keyword | keyword ... (made by docs/tools/make_emoji_search.py)']
        path = os.path.join(args.out, 'mr_emoji_%s.txt' % lang)
        with open(path, 'w', encoding='utf-8', newline='\n') as f:
            f.write('\n'.join(header + lines) + '\n')
        share = len(missing) / float(len(emojis))
        print('%s: %d emojis, %d with words, %d without (%.1f%%), %d bytes' % (lang, len(emojis), len(emojis) - len(missing), len(missing), share * 100, os.path.getsize(path)))
        if missing:
            print('   without words: ' + ' '.join(missing[:40]) + (' ...' if len(missing) > 40 else ''))
        if share > args.max_missing:
            bad = True
    return 1 if bad else 0


if __name__ == '__main__':
    sys.exit(main_(sys.argv[1:]))
