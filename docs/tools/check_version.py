#!/usr/bin/env python3
"""Checks the version: apktool.yml and apktool.json agree, versionCode matches versionName, the APK name (apkFileName) in both
files carries the same version, and the version notes exist.
It also warns (without failing) when a plan for this release is still in docs/.

Run at the project root. versionCode = major*1000000 + minor*1000 + patch (v1.72.0 -> 1072000).
The version notes live where the publishing workflow looks for them: docs/release-notes/v<version>.md (v1.72.0 ->
docs/release-notes/v1.72.0.md). The whole file becomes the Release text and must have both blocks, **Português** and **English**.

Plans: a file docs/plan-*.md that is only needed until its release is out says so with a line `<!-- target-version: v1.82.0 -->`
near the top. Once the project version reaches that target, the plan has done its job and should be deleted in the release
commit: the check prints a GitHub Actions warning. Nothing is deleted or committed automatically.
"""
import json, os, re, sys

problems = []
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
for p in problems:
    print('PROBLEM:', p)
sys.exit(1 if problems else 0)
