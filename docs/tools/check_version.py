#!/usr/bin/env python3
"""Checks the version: apktool.yml and apktool.json agree, versionCode matches versionName, the APK name (apkFileName) in both
files carries the same version, and the version notes exist.
It also warns (without failing) when a plan for this release is still in docs/.

Run at the project root. versionCode = major*1000000 + minor*1000 + patch (v1.72.0 -> 1072000).
The version notes live where the publishing workflow looks for them: docs/release-notes/v<version>.md (v1.72.0 ->
docs/release-notes/v1.72.0.md). It must have both blocks, **Português** and **English**, and it becomes the Release text; a block **Español**
may follow them: it is only for the app (the update notice and the notes of the installed version), so publish_release.sh leaves it out of the
Release text (make_update.py --release-text) and the Release stays in Portuguese and English.
The app also carries this file, with the Spanish block, as assets/mr_release_notes.md (the "Version" line shows it offline, MrVersion): the APK build
(mr-apk.yml) copies it there by itself, so a copy that is out of date does not fail anything; it only warns, because local builds and the tests read
the copy that is committed.

Plans: a file docs/plan-*.md that is only needed until its release is out says so with a line `<!-- target-version: v1.82.0 -->`
near the top. Once the project version reaches that target, the plan has done its job and should be deleted in the release
commit: the check prints a GitHub Actions warning. Nothing is deleted or committed automatically.
"""
import json, os, re, sys

problems = []
warnings = []
yml = open('apktool.yml', encoding='utf-8').read()
name = re.search(r"versionName:\s*['\"]?v?([0-9.]+)", yml).group(1)
code = int(re.search(r"versionCode:\s*['\"]?(\d+)", yml).group(1))
info = json.load(open('apktool.json', encoding='utf-8'))['VersionInfo']
if info['versionName'].lstrip('v') != name or int(info['versionCode']) != code:
    problems.append('apktool.yml (v%s, %d) and apktool.json (%s, %s) do not match' % (name, code, info['versionName'], info['versionCode']))
# apkFileName ("Mr Keyboard_v1.91.0.apk") is the name apktool gives the APK it builds: it must not stay on an older release.
# Only compared when the name has a version in it (a name with no version has nothing to compare).
yml_apk = re.search(r"apkFileName:\s*(.+)", yml)
apk_names = [
    ('apktool.yml', yml_apk.group(1).strip().strip('\'"') if yml_apk else ''),
    ('apktool.json', json.load(open('apktool.json', encoding='utf-8')).get('apkFileName', '')),
]
for fn, apk in apk_names:
    found = re.search(r'v?(\d+\.\d+\.\d+)', apk)
    if found and found.group(1) != name:
        problems.append('apkFileName in %s is "%s" but versionName is v%s' % (fn, apk, name))
parts = name.split('.')
if len(parts) != 3:
    problems.append('versionName v%s does not have the major.minor.patch format' % name)
else:
    major, minor, patch = (int(x) for x in parts)
    expected = major * 1000000 + minor * 1000 + patch
    if code != expected:
        problems.append('versionCode %d does not match v%s (expected %d)' % (code, name, expected))
    notes = ['docs/release-notes/v%s.md' % name]
    found = [n for n in notes if os.path.exists(n)]
    if not found:
        problems.append('no version notes: create one of these files: ' + ' or '.join(notes))
    else:
        text = open(found[0], encoding='utf-8').read()
        for block in ('**Português**', '**English**'):
            if not re.search(r'^' + re.escape(block) + r'\s*$', text, re.M):
                problems.append('%s has no %s block (the text that goes in the GitHub Release)' % (found[0], block))
        # The Spanish block is optional (only for the app), but when it is there it is once and alone on its line, so it can be left out of the Release text.
        if len(re.findall(r'^\*\*Español\*\*[ \t]*$', text, re.M)) > 1 or ('**Español**' in text and not re.search(r'^\*\*Español\*\*[ \t]*$', text, re.M)):
            problems.append('%s: the **Español** block must be once, alone on its line (it is left out of the GitHub Release)' % found[0])
        # The label of an item ("Novo:", "Fixed:", "Como receber:", "Nuevo:") is followed by a space, and the text after it starts with a capital letter:
        # the update dialog colors the label (MrNotesText) and the text reads as a sentence. Only the notes of this version are checked.
        for n, line in enumerate(text.replace('\r\n', '\n').split('\n'), 1):
            item = re.match(r'^[-*] (.*)$', line)
            if not item:
                continue
            body = item.group(1).replace('**', '').replace('`', '')
            glued = re.match(r'(Novo|Melhorado|Corrigido|Como receber|New|Improved|Fixed|How to get it|Nuevo|Mejorado|Corregido|Cómo obtenerla)\b[^:]{0,24}:\S', body)
            if glued:
                problems.append('%s line %d: no space after the colon of "%s"' % (found[0], n, body[:glued.end()]))
                continue
            label = re.match(r'([^:]{1,32}): (\S)', body)
            if label and label.group(2).islower():
                problems.append('%s line %d: the text after "%s:" must start with a capital letter' % (found[0], n, label.group(1)))
    # The Version line of Settings opens the notes of the installed version with no network (MrVersion): they are a copy of this version's
    # notes inside the APK. The build puts the right copy there by itself (mr-apk.yml), so this is only a warning about the committed one.
    if found:
        asset = 'assets/mr_release_notes.md'
        if not os.path.exists(asset):
            warnings.append((asset, '%s is missing: the APK build copies %s there, but local builds and the tests read this file (cp %s %s)' % (asset, found[0], found[0], asset)))
        elif open(asset, 'rb').read() != open(found[0], 'rb').read():
            warnings.append((asset, '%s is not the same as %s: the APK build copies it by itself, but local builds and the tests read this file (cp %s %s)' % (asset, found[0], found[0], asset)))

def as_tuple(v):
    return tuple(int(x) for x in v.split('.'))


plans_left = []
if len(parts) == 3 and os.path.isdir('docs'):
    for fn in sorted(os.listdir('docs')):
        if not (fn.startswith('plan-') and fn.endswith('.md')):
            continue
        m = re.search(r'<!--\s*target-version:\s*v?([0-9]+\.[0-9]+\.[0-9]+)\s*-->', open(os.path.join('docs', fn), encoding='utf-8').read(2000))
        if m and as_tuple(name) >= as_tuple(m.group(1)):
            plans_left.append((os.path.join('docs', fn), m.group(1)))
print('version v%s (code %d)' % (name, code))
for path, target in plans_left:
    print('::warning file=%s::plan target v%s reached (project is at v%s): delete this file in the release commit' % (path, target, name))
for path, text in warnings:
    print('::warning file=%s::%s' % (path, text))
for p in problems:
    print('PROBLEM:', p)
sys.exit(1 if problems else 0)
