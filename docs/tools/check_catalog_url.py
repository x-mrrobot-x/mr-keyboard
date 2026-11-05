#!/usr/bin/env python3
"""Checks that the app reads the dictionary catalog from the latest release (the same one as the APK).

Run at the project root. The app (MrPacks.CATALOG_URL) opens
  https://github.com/<owner>/<repo>/releases/latest/download/catalog.json
and publish_release.sh attaches the catalog with that name (catalog.json) to the release of each launch.
It also checks the generated smali (the two occurrences of the URL) and the owner/repository in the README.
"""
import re, sys

problems = []
java = open('docs/tools/java/src/com/mrkeyboard/app/MrPacks.java', encoding='utf-8').read()
m = re.search(r'CATALOG_URL\s*=\s*"([^"]+)"', java)
if not m:
    problems.append('MrPacks.java has no CATALOG_URL')
    url = ''
else:
    url = m.group(1)
    pattern = r'^https://github\.com/([^/]+/[^/]+)/releases/latest/download/catalog\.json$'
    mm = re.match(pattern, url)
    if not mm:
        problems.append('CATALOG_URL must be https://github.com/<owner>/<repo>/releases/latest/download/catalog.json (it is %s)' % url)
    else:
        repo = mm.group(1)
        readme = open('README.md', encoding='utf-8').read()
        if 'github.com/' + repo not in readme and '../../releases' not in readme:
            problems.append('the repository %s from the URL does not appear in the README' % repo)

smali = open('smali/com/mrkeyboard/app/MrPacks.smali', encoding='utf-8').read()
if url and smali.count(url) != 2:
    problems.append('the MrPacks smali has the URL %d time(s) (expected 2: field and const-string); run build_java.sh' % smali.count(url))

publish = open('docs/tools/publish_release.sh', encoding='utf-8').read()
if 'out/catalog.json' not in publish:
    problems.append('publish_release.sh does not attach out/catalog.json (the app looks for the catalog.json asset)')

print('catalog read from: ' + (url or '(not found)'))
for p in problems:
    print('PROBLEM:', p)
sys.exit(1 if problems else 0)
