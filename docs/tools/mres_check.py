#!/usr/bin/env python3
"""Checks the fixed Portuguese texts of the sheet editor and the attachments against the Spanish table (MrEs.java).

Run at the project root after changing Portuguese text in those files. Exits with 1 if:
  - a text passed through SheetStrings.p() / SheetStrings.a() is not in the table (it would stay untranslated);
  - a table key does not appear in the smali (leftover of a text that changed or went away);
  - Portuguese text is left without going through p()/a() in the sheet editor and attachment files.
The smali of the files listed in BASES uses the Portuguese text and lets p() switch it to Spanish; the
names and categories of the special-keys picker are switched at the 4 reading points (SpecialKeyPicker).
"""
import re, glob, sys

BASES_P = ['KeyEditDialog', 'PopupEditDialog', 'PrefScreenSheets', 'SheetGridView', 'SheetEditorActivity', 'SpecialKeyPicker']
BASES_A = ['MrShots', 'MrCacheClear']
SMALI = 'smali/com/mrkeyboard/app/'
# texts of the special-keys picker: they live in <clinit> and are switched on reading, not on declaration
NO_CLINIT = {'SpecialKeyPicker'}


def dec(s):
    return re.sub(r'\\u([0-9a-fA-F]{4})', lambda m: chr(int(m.group(1), 16)), s).replace('\\"', '"').replace("\\'", "'").replace('\\n', '\n')


def java_str(s):
    return dec(s.replace('\\\\', '\\').replace('\\"', '"')) if False else re.sub(r'\\(u[0-9a-fA-F]{4}|.)', lambda m: chr(int(m.group(1)[1:], 16)) if m.group(1)[0] == 'u' and len(m.group(1)) == 5 else {'n': '\n', '"': '"', '\\': '\\'}.get(m.group(1), m.group(1)), s)


src = open('docs/tools/java/src/com/mrkeyboard/app/MrEs.java', encoding='utf-8').read()
table = set()
for m in re.finditer(r'^\s+[ea]\("((?:[^"\\]|\\.)*)",', src, re.M):
    table.add(java_str(m.group(1)))

cs = re.compile(r'const-string(?:/jumbo)? ([vp]\d+), "((?:[^"\\]|\\.)*)"')
used, untranslated, loose = set(), [], []
hint = re.compile(r'[áéíóúãõçâêôà]|\b(de|do|da|para|ou|em|com|uma|um|que|não|Toque|Nenhum|Folha|folha)\b')
english = re.compile(r'\b(the|and|to|of|for|with|key|keys|sheet|sheets|type|enter|each|button)\b')
for kind, bases in (('p', BASES_P), ('a', BASES_A)):
    for b in bases:
        for f in sorted(glob.glob(SMALI + b + '.smali') + glob.glob(SMALI + b + '$*.smali')):
            txt = open(f, encoding='utf-8').read()
            for m in cs.finditer(txt):
                lit = dec(m.group(2))
                after = txt[m.end():m.end() + 160]
                wrapped = re.match(r'\s*invoke-static/range \{%s \.\. %s\}, Lcom/mrkeyboard/app/SheetStrings;->%s\(' % (m.group(1), m.group(1), kind), after)
                if wrapped:
                    used.add(lit)
                    if lit not in table: untranslated.append((f, lit))
                elif lit in table:
                    used.add(lit)    # stays in the table because it is switched at another point (picker names)
                elif hint.search(lit) and not english.search(lit) and not re.match(r'^[a-z_.:/$\-]+$', lit) and b not in NO_CLINIT:
                    loose.append((f, lit))
# picker names and categories come from <clinit>: they count as used if they are in the table
unused = sorted(k for k in table if k not in used and not any(k in open(f, encoding='utf-8').read().replace('\\n', '\n') for f in glob.glob(SMALI + 'SpecialKeyPicker*.smali')))
print('keys in the table: %d | wrapped texts: %d' % (len(table), len(used)))
for f, l in untranslated: print('NOT TRANSLATED IN THE TABLE', f, repr(l))
for f, l in loose: print('PORTUGUESE WITHOUT p()/a()', f, repr(l))
sys.exit(1 if untranslated or loose else 0)
