#!/usr/bin/env python3
"""Checks that what the Java layer calls really exists, with the same signature, in the APK.

The Java sources in docs/tools/java/src are compiled against the hand-written stubs in docs/tools/java/stubs
(they are the only "android.jar" the build has). If a stub declares a method or a field that the APK does not
have, or with another return type, the code compiles and the dex builds, and the app only fails on the device:

    java.lang.NoSuchMethodError: No virtual method setTypeface(Landroid/graphics/Typeface;)V
        in class Landroid/graphics/Paint;   (the real one returns Typeface, the stub said void)

That is what happened once with Paint.setTypeface and Paint.getFontMetrics (the sheet editor did not open).
This script reads the generated smali of the Java layer and checks every method and field it touches:

  - classes of the APK (com/mrkeyboard/...): compared with the smali in smali/, following .super and
    .implements, so a member inherited from a hand-written class counts. A member that is in none of them must
    come from the Android class where the chain ends (LatinIME from InputMethodService, a view from View): with
    ANDROID_JAR it is looked up there; without it, it is taken on trust unless the chain only reaches
    java.lang.Object. A member found in the APK must also be usable from where it is used: not private in another
    class (IllegalAccessError on the device), and static or not as the instruction says (invoke-static, sget and
    sput against the others: IncompatibleClassChangeError);
  - android.*: compared with a real android.jar when ANDROID_JAR points to one (Android SDK
    platforms/android-XX/android.jar, or a Robolectric android-all jar). Without it this part is skipped:
    it is the only way to know the real signatures, and the project does not keep a copy of the framework.

Until 1.96.0 the APK side reported nothing: every chain of classes ends in java.lang.Object, which was taken as
"the member may come from the framework", and the pattern for iget/sget expected braces those instructions do not
have, so no field was looked at, in the APK or in android.*. MrGestureInput (gesture typing) reaches LatinIME,
LatinKeyboardView, KeyboardSwitcher and MrTools only through stubs, which is what made the gap matter.

Run at the project root, after the smali is up to date:

    python3 docs/tools/check_stub_api.py
    ANDROID_JAR=/opt/android-sdk/platforms/android-35/android.jar python3 docs/tools/check_stub_api.py

Use a jar of the newest API (the target one): the calls behind an `if (Build.VERSION.SDK_INT >= N)` are
inside `MrFoo$ApiN` classes and count as expected when the jar is older; a guard written by hand inside a
normal method (MrUpdateInstall) only shows up with a jar older than that API.

Exits with 1 when it finds a call that the APK cannot answer (each one is a line that starts with PROBLEM).
"""
import glob
import os
import re
import subprocess
import sys
import tempfile

SRC = 'docs/tools/java/src/com/mrkeyboard/app'
STUBS = 'docs/tools/java/stubs'
SMALI = 'smali'
JAVAP = ['java', '-m', 'jdk.jdeps/com.sun.tools.javap.Main', '-p', '-s', '-cp']
ANDROID_JAR = os.environ.get('ANDROID_JAR', '')

# group 1 is the instruction (invoke-static, iget...): it says whether the member is used as a static one
re_invoke = re.compile(r'(invoke-[a-z]+)(?:/range)? \{[^}]*\}, (L[^;]+;)->([^(\s]+)(\(.*)$', re.M)
re_field = re.compile(r'([is](?:get|put))(?:-\w+)? [vp]\d+(?:, [vp]\d+)?, (L[^;]+;)->([\w$]+):(\S+)$', re.M)


def modifiers(txt):
    """{(kind, name, descriptor): the words before the name (public, static, final...)} of one smali class."""
    out = {}
    for line in txt.split('\n'):
        if line.startswith('.method '):
            parts = line.split()
            m = re.match(r'([\w$<>]+)(\(.*)$', parts[-1])
            if m:
                out[('m', m.group(1), m.group(2))] = set(parts[1:-1])
        elif line.startswith('.field '):
            parts = line.split(' = ')[0].split()
            if ':' in parts[-1]:
                name, desc = parts[-1].split(':', 1)
                out[('f', name, desc)] = set(parts[1:-1])
    return out


def parse_smali(path):
    txt = open(path, encoding='utf-8').read()
    sup = re.search(r'^\.super (L[^;]+;)', txt, re.M)
    mods = modifiers(txt)
    return {
        'mods': mods,
        'super': sup.group(1) if sup else None,
        'ifaces': re.findall(r'^\.implements (L[^;]+;)', txt, re.M),
        'methods': {(m.group(1), '(' + m.group(2) + ')' + m.group(3))
                    for m in re.finditer(r'^\.method\s+[^\n]*?([\w$<>]+)\(([^)]*)\)(\S+)', txt, re.M)},
        # from the same reading as the modifiers: a field with no modifier at all (".field size:J") has nothing before its name
        'fields': {(name, desc) for kind, name, desc in mods if kind == 'f'},
    }


smali = {}
for p in glob.glob(SMALI + '/**/*.smali', recursive=True):
    smali['L' + p[len(SMALI) + 1:-len('.smali')] + ';'] = parse_smali(p)


def declared_in(cls, kind, name, desc, seen=None):
    """The class of the APK (this one, a superclass or an interface) that declares the member, or None."""
    seen = seen if seen is not None else set()
    if cls in seen or cls not in smali:
        return None
    seen.add(cls)
    t = smali[cls]
    if (name, desc) in (t['methods'] if kind == 'm' else t['fields']):
        return cls
    for parent in ([t['super']] if t['super'] else []) + t['ifaces']:
        found = declared_in(parent, kind, name, desc, seen)
        if found:
            return found
    return None


def outside(cls, seen=None, out=None):
    """The classes that are not in the APK (android.*, java.*) where the chain of this class ends, in order."""
    seen = seen if seen is not None else set()
    out = out if out is not None else []
    if cls in seen:
        return out
    seen.add(cls)
    if cls not in smali:
        out.append(cls)
        return out
    t = smali[cls]
    for parent in ([t['super']] if t['super'] else []) + t['ifaces']:
        outside(parent, seen, out)
    return out


# ---- android.jar side
jar_cache = {}


def jar_members(cls):
    if cls in jar_cache:
        return jar_cache[cls]
    r = subprocess.run(JAVAP + [ANDROID_JAR, cls], capture_output=True, text=True)
    if r.returncode != 0:
        jar_cache[cls] = None
        return None
    lines = r.stdout.split('\n')
    head = ''
    for l in lines:
        if re.search(r'\b(class|interface|enum)\s', l):
            head = re.sub(r'<[^>]*>', '', l).strip().rstrip('{').strip()
            break
    supers = []
    m = re.search(r' extends (.+?)(?: implements |$)', head)
    if m:
        supers += [x.strip() for x in m.group(1).split(',') if x.strip()]
    m = re.search(r' implements (.+)$', head)
    if m:
        supers += [x.strip() for x in m.group(1).split(',') if x.strip()]
    methods, fields = set(), set()
    for i, l in enumerate(lines):
        s = l.strip()
        if not s.startswith('descriptor:'):
            continue
        d = s.split('descriptor:')[1].strip()
        prev = lines[i - 1] if i else ''
        mm = re.search(r'([\w$<>]+)\((.*)\)', prev)
        if mm:
            nm = mm.group(1)
            simple = cls.split('.')[-1]
            if nm == simple or nm == simple.split('$')[-1]:
                nm = '<init>'
            methods.add((nm, d))
        else:
            fields.add((prev.strip().split(' ')[-1].rstrip(';'), d))
    jar_cache[cls] = {'supers': supers, 'methods': methods, 'fields': fields}
    return jar_cache[cls]


OBJECT_METHODS = {('toString', '()Ljava/lang/String;'), ('hashCode', '()I'), ('equals', '(Ljava/lang/Object;)Z'),
                  ('getClass', '()Ljava/lang/Class;')}


def in_jar(cls, kind, name, desc, seen=None):
    seen = seen if seen is not None else set()
    if kind == 'm' and (name, desc) in OBJECT_METHODS:
        return jar_members(cls) is not None
    seen.add(cls)
    info = jar_members(cls)
    if not info:
        return False
    if (name, desc) in (info['methods'] if kind == 'm' else info['fields']):
        return True
    return any(in_jar(s, kind, name, desc, seen)
               for s in info['supers'] if s not in seen and s != 'java.lang.Object')


def main():
    problems = []
    checked_apk = checked_android = skipped_android = newer_apis = inherited = 0
    java_classes = {os.path.basename(p)[:-5] for p in glob.glob(SRC + '/*.java')}
    generated = [p for p in glob.glob(SMALI + '/com/mrkeyboard/app/*.smali')
                 if os.path.basename(p)[:-6].split('$')[0] in java_classes]
    for f in generated:
        txt = open(f, encoding='utf-8').read()
        this = 'L' + f[len(SMALI) + 1:-len('.smali')] + ';'
        calls = []
        for m in re_invoke.finditer(txt):
            calls.append((m.group(1), m.group(2), m.group(3), m.group(4).strip(), 'm'))
        for m in re_field.finditer(txt):
            calls.append((m.group(1), m.group(2), m.group(3), m.group(4).strip(), 'f'))
        for op, owner, name, desc, kind in calls:
            if owner.startswith('Lcom/mrkeyboard/'):
                checked_apk += 1
                where = (os.path.basename(f), owner, name, (':' if kind == 'f' else '') + desc)
                decl = declared_in(owner, kind, name, desc)
                if decl is None:
                    # not in the APK: it must come from the class of the framework where the chain ends
                    ends = outside(owner)
                    if owner not in smali:
                        ok = False
                    elif ANDROID_JAR:
                        ok = any(in_jar(e[1:-1].replace('/', '.'), kind, name, desc) for e in ends)
                    else:
                        # no jar to ask: only a chain that reaches nothing but java.lang.Object can be judged
                        ok = (any(e != 'Ljava/lang/Object;' for e in ends)
                              or (kind == 'm' and (name, desc) in OBJECT_METHODS))
                    if ok:
                        inherited += 1
                    else:
                        problems.append(where + ('the APK has no such member',))
                    continue
                mods = smali[decl]['mods'].get((kind, name, desc), set())
                is_static = 'static' in mods
                used_static = op == 'invoke-static' if kind == 'm' else op[0] == 's'
                if name != '<init>' and is_static != used_static:
                    how = ('static', 'an instance member') if is_static else ('an instance member', 'static')
                    problems.append(where + ('it is %s in the APK and the code uses it as %s' % how,))
                if 'private' in mods and decl != this:
                    problems.append(where + ('it is private in %s' % decl,))
            elif owner.startswith('Landroid/') or owner.startswith('Lcom/android/'):
                if not ANDROID_JAR:
                    skipped_android += 1
                    continue
                checked_android += 1
                dotted = owner[1:-1].replace('/', '.')
                if not in_jar(dotted, kind, name, desc):
                    if re.search(r'\$Api\d+', os.path.basename(f)):
                        # the class exists only to call an API newer than the minSdk: the code asks the SDK
                        # level before it uses this one (MrFoo$Api30 -> SDK_INT >= 30), so an older jar
                        # missing it is expected. Check it against a jar of that API or newer.
                        newer_apis += 1
                    else:
                        problems.append((os.path.basename(f), owner, name, (':' if kind == 'f' else '') + desc,
                                         'not in the android.jar'))
    print('methods and fields of APK classes checked: %d (%d of them inherited from the framework%s)'
          % (checked_apk, inherited, '' if ANDROID_JAR else ', taken on trust without ANDROID_JAR'))
    if ANDROID_JAR:
        print('methods and fields of android.* checked against %s: %d (%d newer than the jar, in $ApiNN classes)'
              % (os.path.basename(ANDROID_JAR), checked_android, newer_apis))
    else:
        print('methods and fields of android.* skipped: %d (set ANDROID_JAR to check them)' % skipped_android)
    for f, owner, name, desc, why in problems:
        print('PROBLEM: %s -> %s->%s%s  (%s)' % (f, owner, name, desc, why))
    print('check_stub_api: %s' % ('OK' if not problems else '%d problem(s)' % len(problems)))
    return 1 if problems else 0


if __name__ == '__main__':
    sys.exit(main())
