#!/usr/bin/env python3
"""Tests of docs/tools/make_emoji_search.py with made-up CLDR files (run at the project root:
python3 docs/tools/emoji_search_test/test_make_emoji_search.py)."""
import os, subprocess, sys, tempfile, zipfile

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
import make_emoji_search as m

ok = fail = 0


def check(what, cond):
    global ok, fail
    if cond:
        ok += 1
        print('OK    ' + what)
    else:
        fail += 1
        print('FAIL  ' + what)


HEART, GRIN, FLAG, KEY1, NONE = '❤️', '\U0001F600', '\U0001F1E7\U0001F1F7', '1️⃣', '\U0001F9FF'
JAVA = None   # the made-up table of the newer emojis (set in main)


def esc(s):
    return ''.join('\\u%04x' % u for u in (s.encode('utf-16-be')[i] << 8 | s.encode('utf-16-be')[i + 1] for i in range(0, len(s.encode('utf-16-be')), 2)))


def smali_for(cats):
    body = '.method static dataBase(I)Ljava/lang/String;\n    .locals 1\n'
    for c in cats:
        body += '    const-string v0, "%s"\n    return-object v0\n' % '|'.join(esc(e) for e in c)
    return body + '.end method\n'


def xml(entries):
    out = '<?xml version="1.0" encoding="UTF-8" ?>\n<!-- Copyright Unicode, Inc. -->\n<ldml><identity><language type="x"/></identity><annotations>\n'
    for cp, tts, kws in entries:
        if kws:
            out += '<annotation cp="%s">%s</annotation>\n' % (cp, ' | '.join(kws))
        if tts:
            out += '<annotation cp="%s" type="tts">%s</annotation>\n' % (cp, tts)
    return out + '</annotations></ldml>\n'


def write(path, text):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    open(path, 'w', encoding='utf-8').write(text)


def java_for(cats, comment='            // a comment with "quotes" and { braces }\n'):
    """A made-up MrEmojiNew.java: cats is a list (one per category) of groups, each a list [anchor, new, new...]."""
    body = '    private static final String[][] GROUPS = {\n'
    for groups in cats:
        body += '        {\n' + comment
        for g in groups:
            body += '            "%s",\n' % '|'.join(esc(e) for e in g)
        body += '        },\n'
    return body + '    };\n'


def make_source(d, layout):
    data = {
        'en': ([('❤', 'red heart', ['heart', 'love']), (GRIN, 'grinning face', ['face', 'grin'])],
               [(FLAG, 'flag: Brazil', []), ('1⃣', 'keycap: 1', []), (NONE, None, ['amulet', 'nazar'])]),
        'pt': ([('❤', 'coração vermelho', ['coração', 'amor']), (GRIN, 'rosto sorrindo', ['rosto'])],
               [(FLAG, 'bandeira: Brasil', []), ('1⃣', 'tecla: 1', [])]),
        'es': ([('❤', 'corazón rojo', ['corazón', 'amor', 'con barra']), (GRIN, 'cara sonriendo', ['cara'])],
               [(FLAG, 'bandera: Brasil', [])]),
    }
    write(os.path.join(d, 'UNICODE_LICENSE.txt'), 'UNICODE LICENSE V3\n\nCopyright (c) 1991-2099 Unicode, Inc.\n')
    for lang, (main, derived) in data.items():
        if layout == 'cldr':
            write(os.path.join(d, 'common/annotations/%s.xml' % lang), xml(main))
            write(os.path.join(d, 'common/annotationsDerived/%s.xml' % lang), xml(derived))
        else:
            write(os.path.join(d, 'annotations_%s.xml' % lang), xml(main))
            write(os.path.join(d, 'derived_%s.xml' % lang), xml(derived))


def run(src, out, smali, extra=()):
    return subprocess.run([sys.executable, '-I', os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'make_emoji_search.py'),
                           src, '--out', out, '--smali', smali, '--java', JAVA, '--cldr', '99', '--license-out', os.path.join(out, 'LICENSE-copy.txt')] + list(extra),
                          capture_output=True, text=True)


def lines(path):
    return [l for l in open(path, encoding='utf-8').read().split('\n') if l and not l.startswith('# ')]


def main():
    t = tempfile.mkdtemp()
    smali = os.path.join(t, 'MrEmotes.smali')
    write(smali, smali_for([[HEART, GRIN, HEART], [FLAG, KEY1], [NONE]]))
    global JAVA
    JAVA = os.path.join(t, 'MrEmojiNew.java')
    write(JAVA, java_for([[], [], []]))
    check('panel_emojis: order kept, a repeated emoji once, surrogate pairs decoded', m.panel_emojis(smali, JAVA) == [HEART, GRIN, FLAG, KEY1, NONE])

    # the newer emojis: right after the anchor, at the end of the category when the anchor is not there, never twice
    MELT, CRY, FLAG2, ZWJ_NEW = '\U0001FAE0', '\U0001F979', '\U0001F1E8\U0001F1F6', '\U0001F426\u200d\U0001F525'
    other = os.path.join(t, 'Other.java')
    write(other, java_for([[[GRIN, MELT, CRY], [HEART, GRIN, ZWJ_NEW]], [[KEY1, FLAG2]], [[HEART, MELT]]]))
    check('newer emojis: right after their anchor, in the order of the table; one that is in the base already is not added; a group of another category does not count here',
          m.panel_emojis(smali, other) == [HEART, ZWJ_NEW, GRIN, MELT, CRY, FLAG, KEY1, FLAG2, NONE])
    write(other, java_for([[[HEART, MELT]], [], []]))
    check('newer emojis: after the anchor, and the rest of the base list follows', m.panel_emojis(smali, other) == [HEART, MELT, GRIN, FLAG, KEY1, NONE])
    write(other, java_for([[['nope', MELT, CRY]], [], [['also nope', FLAG2]]]))
    check('newer emojis: a missing anchor puts them at the end of the category', m.panel_emojis(smali, other) == [HEART, GRIN, MELT, CRY, FLAG, KEY1, NONE, FLAG2])
    check('the table reader: comments (with quotes and braces) are skipped, one list per category', m.new_groups(other) == [[['nope', MELT, CRY]], [], [['also nope', FLAG2]]])
    real = m.new_groups()
    check('the real table: 8 categories, each group an anchor and something new', len(real) == 8 and all(len(g) >= 2 for c in real for g in c))

    check('clean: a bar, a tab or a line break inside a word cannot break the line format', m.clean(' a|b\tc\nd ') == 'a/b c d')

    for layout in ('flat', 'cldr'):
        src, out = os.path.join(t, 'src_' + layout), os.path.join(t, 'out_' + layout)
        make_source(src, layout)
        r = run(src, out, smali, ['--max-missing', '1'])
        check('%s layout: runs (%s)' % (layout, r.stderr.strip()[:80]), r.returncode == 0)
        en = lines(os.path.join(out, 'mr_emoji_en.txt'))
        pt = lines(os.path.join(out, 'mr_emoji_pt.txt'))
        es = lines(os.path.join(out, 'mr_emoji_es.txt'))
        check('%s: the three files list the same emojis in the same order' % layout,
              [l.split('\t')[0] for l in en] == [l.split('\t')[0] for l in pt] == [l.split('\t')[0] for l in es] == [HEART, GRIN, FLAG, KEY1, NONE])
        check('%s: the name first, then the keywords; the emoji as the panel has it (with FE0F)' % layout, en[0] == HEART + '\tred heart|heart|love')
        check('%s: a derived emoji (flag) takes its words from the derived file' % layout, en[2] == FLAG + '\tflag: Brazil' and pt[2] == FLAG + '\tbandeira: Brasil')
        check('%s: the keycap matches without U+FE0F on both sides' % layout, en[3] == KEY1 + '\tkeycap: 1')
        check('%s: no name but keywords: the first keyword is the name' % layout, en[4] == NONE + '\tamulet|nazar')
        check('%s: missing in a language: a line with no words (the emoji stays in the list)' % layout, es[3] == KEY1 + '\t' and pt[4] == NONE + '\t')
        check('%s: the keywords of CLDR (separated by a bar) stay separate, a keyword with a space stays whole' % layout, es[0] == HEART + '\tcorazón rojo|corazón|amor|con barra')
        check('%s: the licence text is copied byte for byte' % layout,
              open(os.path.join(out, 'LICENSE-copy.txt'), 'rb').read() == open(os.path.join(src, 'UNICODE_LICENSE.txt'), 'rb').read())
        head = open(os.path.join(out, 'mr_emoji_en.txt'), encoding='utf-8').read().split('\n')[:3]
        check('%s: header with the licence and the release' % layout, all(h.startswith('#') for h in head) and 'release 99' in head[0] and 'Unicode' in head[1])

    z = os.path.join(t, 'cldr.zip')
    with zipfile.ZipFile(z, 'w') as zf:
        for dp, _, ns in os.walk(os.path.join(t, 'src_flat')):
            for n in ns:
                zf.write(os.path.join(dp, n), n)
    r = run(z, os.path.join(t, 'out_zip'), smali, ['--max-missing', '1'])
    check('a zip with the files at the root works', r.returncode == 0 and len(lines(os.path.join(t, 'out_zip', 'mr_emoji_pt.txt'))) == 5)

    r = run(os.path.join(t, 'src_flat'), os.path.join(t, 'out_strict'), smali)   # default 3%: es misses 2 of 5
    check('too many emojis without words: exit 1 and the list is printed', r.returncode == 1 and 'without words' in r.stdout)

    os.rename(os.path.join(t, 'src_flat', 'UNICODE_LICENSE.txt'), os.path.join(t, 'src_flat', 'x.txt'))
    r = run(os.path.join(t, 'src_flat'), os.path.join(t, 'out_nolic'), smali, ['--max-missing', '1'])
    check('without the licence text anywhere: stops (the licence has to travel with the data)', r.returncode != 0 and 'licence text is missing' in (r.stderr + r.stdout))
    existing = os.path.join(t, 'LICENSE-existing.txt')
    write(existing, 'Unicode License, Copyright of the files already in docs')
    r = subprocess.run([sys.executable, '-I', os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'make_emoji_search.py'),
                        os.path.join(t, 'src_flat'), '--out', os.path.join(t, 'out_existing'), '--smali', smali, '--java', JAVA, '--license-out', existing, '--max-missing', '1'],
                       capture_output=True, text=True)
    check('without the licence in the source but with the file already in the project: runs and leaves it as it is',
          r.returncode == 0 and open(existing, encoding='utf-8').read().startswith('Unicode License, Copyright of the files'))
    os.rename(os.path.join(t, 'src_flat', 'x.txt'), os.path.join(t, 'src_flat', 'UNICODE_LICENSE.txt'))
    os.remove(os.path.join(t, 'src_flat', 'derived_pt.xml'))
    r = run(os.path.join(t, 'src_flat'), os.path.join(t, 'out_absent'), smali)
    check('a file missing: stops and says which', r.returncode != 0 and 'derived' in (r.stderr + r.stdout))

    print('\n%d OK, %d FAIL' % (ok, fail))
    sys.exit(1 if fail else 0)


main()
