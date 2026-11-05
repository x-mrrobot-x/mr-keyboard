#!/usr/bin/env python3
"""Checks that update.json (the notice of a new version) is wired to the same repository and the same file names everywhere.

Run at the project root. The app reads
  https://github.com/<owner>/<repo>/releases/latest/download/update.json
and downloads the APK from RELEASES_URL + <tag> + "/mr-keyboard-<tag>.apk" (the tag and the APK name come from the signed file;
the address never does). <owner>/<repo> is the one in MrPacks.CATALOG_URL, the same repository that publishes the release.

Publishing side (always checked):
  - publish_release.sh makes and attaches update.json, signed with the "update" domain, from make_update.py;
  - release_assets.py lists update.json among the files the release must have;
  - make_update.py and publish_release.sh give the APK the same name, mr-keyboard-<tag>.apk;
  - SignCatalog.java knows the "update" domain (the signed prefix mr-keyboard/update/v1).
App side (checked as soon as the Java sources define it): UPDATE_URL must be the address above and must be in the
generated smali too. APP_MUST_HAVE_IT is turned on when the app gets the code that reads the notice.
"""
import glob, os, re, sys

APP_MUST_HAVE_IT = False

problems = []


def read(path):
    return open(path, encoding='utf-8').read()


java_dir = 'docs/tools/java/src'
pk = read(java_dir + '/com/mrkeyboard/app/MrPacks.java')
m = re.search(r'CATALOG_URL\s*=\s*"https://github\.com/([^/]+/[^/]+)/releases/latest/download/catalog\.json"', pk)
repo = m.group(1) if m else ''
if not repo:
    problems.append('MrPacks.CATALOG_URL does not give the repository (run check_catalog_url.py)')
want = 'https://github.com/%s/releases/latest/download/update.json' % repo

publish = read('docs/tools/publish_release.sh')
if 'out/update.json' not in publish:
    problems.append('publish_release.sh does not attach out/update.json (the app looks for the update.json asset)')
if not re.search(r'sign_catalog\.sh\s+out/update-data\.json\s+out/update\.json\s+update\b', publish):
    problems.append('publish_release.sh must sign with: sign_catalog.sh out/update-data.json out/update.json update')
if 'make_update.py' not in publish:
    problems.append('publish_release.sh does not run make_update.py')
if 'APK="mr-keyboard-$TAG.apk"' not in publish:
    problems.append('publish_release.sh does not name the APK mr-keyboard-$TAG.apk')

if "'update.json'" not in read('docs/tools/release_assets.py'):
    problems.append('release_assets.py does not list update.json among the files of the release')
if "'mr-keyboard-%s.apk' % a.tag" not in read('docs/tools/make_update.py'):
    problems.append('make_update.py does not name the APK mr-keyboard-<tag>.apk')
if 'DOMAINS = {"catalog", "update"}' not in read('docs/tools/SignCatalog.java'):
    problems.append('SignCatalog.java must accept the domains catalog and update')

app_urls = []
for f in sorted(glob.glob(java_dir + '/**/*.java', recursive=True)):
    for u in re.findall(r'UPDATE_URL\s*=\s*"([^"]+)"', read(f)):
        app_urls.append((f, u))
for f, u in app_urls:
    if u != want:
        problems.append('%s: UPDATE_URL must be %s (it is %s)' % (f, want, u))
    cls = re.sub(r'.*src/', '', f)[:-len('.java')]
    smali_path = 'smali/%s.smali' % cls
    smali = read(smali_path) if os.path.exists(smali_path) else ''
    if u not in smali:
        problems.append('smali/%s.smali does not exist or does not have %s; run build_java.sh' % (cls, u))
if APP_MUST_HAVE_IT and not app_urls:
    problems.append('the app has no UPDATE_URL')

print('update notice read from: ' + (want if repo else '(repository not found)'))
print('app: ' + ('UPDATE_URL in %s' % ', '.join(f for f, _ in app_urls) if app_urls else 'does not read the notice yet'))
for p in problems:
    print('PROBLEM:', p)
sys.exit(1 if problems else 0)
