#!/bin/bash
# Tests docs/tools/publish_release.sh with a fake gh (gh), a fake apksigner and the real signature
# (test keystore). Each test workspace is a git repository (a mini project + a copy of docs/tools), because the release
# also carries the source zip made with git archive from the commit being published.
# Run from the project root: bash docs/tools/publish_test/run.sh
ROOT=$(pwd)
HERE=$ROOT/docs/tools/publish_test
T=$(mktemp -d)
ok=0; fails=0
check() { if [ "$2" = "1" ]; then ok=$((ok+1)); echo "OK    $1"; else fails=$((fails+1)); echo "FAIL  $1 ${3:+| $3}"; fi; }

# test key (the same one signs the catalog)
keytool -genkeypair -alias k -keyalg RSA -keysize 2048 -validity 3650 -keystore "$T/t.p12" -storetype PKCS12 \
  -storepass pass123 -keypass pass123 -dname CN=Test > /dev/null 2>&1
export KEYSTORE_B64=$(base64 -w0 "$T/t.p12") KEYSTORE_PASS=pass123 KEY_ALIAS=k KEY_PASS=pass123

# fake apksigner
mkdir -p "$T/android/build-tools/34.0.0"
cat > "$T/android/build-tools/34.0.0/apksigner" <<'EOS'
#!/bin/sh
if [ "$FAKE_UNSIGNED" = "1" ]; then echo "DOES NOT VERIFY" >&2; exit 1; fi
if [ "$1" = "verify" ] && [ "$2" = "--print-certs" ]; then echo "Signer #1 certificate SHA-256 digest: deadbeef1234"; fi
exit 0
EOS
chmod +x "$T/android/build-tools/34.0.0/apksigner" "$HERE/gh"
mkdir -p "$T/bin"; cp "$HERE/gh" "$T/bin/gh"

# template of the workspaces: a git repository with a mini project and a real copy of docs/tools
TPL=$T/tpl; mkdir -p "$TPL/docs" "$TPL/res/values" "$TPL/smali/com/x" "$TPL/lib/arm64-v8a" "$TPL/native/src" "$TPL/engine/src" \
  "$TPL/.github/workflows" "$TPL/build"
cp -a "$ROOT/docs/tools" "$TPL/docs/tools"; find "$TPL/docs/tools" -name __pycache__ -prune -exec rm -rf {} +
echo '<manifest/>' > "$TPL/AndroidManifest.xml"; echo '<resources/>' > "$TPL/res/values/strings.xml"
echo '.class public Lcom/x/A; # committed' > "$TPL/smali/com/x/A.smali"; echo so > "$TPL/lib/arm64-v8a/libx.so"
echo cmake > "$TPL/native/CMakeLists.txt"; echo cpp > "$TPL/native/src/a.cpp"; echo cmake > "$TPL/engine/CMakeLists.txt"
echo hash > "$TPL/native-src.sha256"; echo hash > "$TPL/mrengine-src.sha256"; echo MIT > "$TPL/LICENSE"
echo readme > "$TPL/README.md"; echo leia-me > "$TPL/README.pt-BR.md"
echo plan > "$TPL/docs/plan-x.md"; echo wf > "$TPL/.github/workflows/x.yml"; echo junk > "$TPL/build/junk.txt"
git -C "$TPL" init -q 2> /dev/null

pack() {  # folder id version content
  mkdir -p "$1/$2"
  printf '{"id":"%s","lang":"%s","name":{"en":"%s"},"version":%s,"format":1,"minApp":1,"files":["main.dict"],"licenses":[]}' "$2" "${2%%-*}" "$2" "$3" > "$1/$2/pack.json"
  printf '\310\001%s' "$4" > "$1/$2/main.dict"
}

notes() {  # fake notes file (does not depend on the project's real notes)
  mkdir -p "$(dirname "$1")"
  printf '**Português**\n- Corrige o fechamento do app de teste.\n\n**English**\n- Fixes the test app closing.\n' > "$1"
}

setver() {  # workspace tag: apktool.yml with that version and the versionCode that goes with it (v1.73.0 -> 1073000)
  local a b c; IFS=. read -r a b c <<< "${2#v}"
  printf "versionInfo:\n  versionCode: '%d'\n  versionName: %s\n" $((a*1000000 + b*1000 + c)) "$2" > "$1/apktool.yml"
}

fresh() {  # creates a workspace: $W (project) and $S (gh state)
  W=$(mktemp -d -p "$T"); S=$(mktemp -d -p "$T")
  cp -a "$TPL/." "$W/"; mkdir -p "$S/rel"
  notes "$W/docs/release-notes/v1.72.0.md"
  setver "$W" "${1:-v1.72.0}"
  echo apk > "$W/mr-keyboard-signed.apk"; echo apk > "$W/mr-keyboard-unsigned.apk"
  pack "$W/dicts" pt-BR 2 aaaa; pack "$W/dicts" en-US 2 bbbb; pack "$W/dicts" es 1 cccc
  : > "$S/log"
}

earlier() {  # tag serial: puts an earlier published release (APK, zips and signed catalog) in the state, as the latest
  local tag=$1 serial=$2
  python3 -I "$ROOT/docs/tools/make_catalog.py" --dicts "$W/dicts" --out "$T/ant" --tag "$tag" > /dev/null
  python3 - "$T/ant/data.json" "$serial" <<'EOP'
import json, sys
d = json.load(open(sys.argv[1])); d['serial'] = int(sys.argv[2]); open(sys.argv[1], 'w').write(json.dumps(d, indent=1))
EOP
  sh "$ROOT/docs/tools/sign_catalog.sh" "$T/ant/data.json" "$T/ant/catalog.json"
  mkdir -p "$S/rel/$tag/assets"; echo false > "$S/rel/$tag/draft"; echo "$tag" > "$S/latest"
  cp "$T/ant"/*.zip "$T/ant/catalog.json" "$S/rel/$tag/assets/"; echo apk > "$S/rel/$tag/assets/mr-keyboard-$tag.apk"; rm -rf "$T/ant"
}

commit_all() { git -C "$W" add -A > /dev/null && git -C "$W" -c user.name=t -c user.email=t@t commit -q --allow-empty -m test; }
publish() {  # mode lib_ok [extra environment]  -> $CODE, $OUT, $SHA, $T/ghout (what the step leaves for the workflow)
  # the commit being published: all the workspace, unless FORCE_SHA says which commit (even a wrong one)
  [ -n "$FORCE_SHA" ] || commit_all
  SHA=${FORCE_SHA:-$(git -C "$W" rev-parse HEAD)}; : > "$T/ghout"
  ( cd "$W" && env "${@:3}" PATH="$T/bin:$PATH" FAKE_STATE="$S" MODE="$1" LIB_OK="$2" GITHUB_SHA="$SHA" GITHUB_OUTPUT="$T/ghout" \
      GITHUB_REPOSITORY=owner/repo ANDROID_HOME="$T/android" GH_TOKEN=t bash "$ROOT/docs/tools/publish_release.sh" ) > "$T/out" 2>&1
  CODE=$?; OUT=$(cat "$T/out")
}
zipof() { echo "$S/rel/$1/assets/mr-keyboard-$1-source.zip"; }
serial() { python3 -c "import json,sys; print(json.loads(json.load(open(sys.argv[1]))['data'])['serial'])" "$1"; }
relof() { python3 -c "import json,sys; print([p['release'] for p in json.loads(json.load(open(sys.argv[1]))['data'])['packs'] if p['id'] == sys.argv[2]][0])" "$1" "$2"; }
# the public key of the test key, to check signatures with openssl (independent of the signing code)
keytool -exportcert -rfc -alias k -keystore "$T/t.p12" -storepass pass123 2> /dev/null | openssl x509 -pubkey -noout > "$T/pub.pem"
sigok() {  # file domain -> 1 if the signature is valid for the prefix mr-keyboard/<domain>/v1, 0 if not
  python3 - "$1" "$2" "$T/pub.pem" "$T/m.bin" "$T/s.bin" <<'EOP'
import base64, json, subprocess, sys
f, dom, pub, mf, sf = sys.argv[1:6]
j = json.load(open(f, encoding='utf-8'))
open(mf, 'wb').write(('mr-keyboard/%s/v1\n' % dom).encode() + j['data'].encode('utf-8'))
open(sf, 'wb').write(base64.b64decode(j['signature']))
print(1 if subprocess.run(['openssl', 'dgst', '-sha256', '-verify', pub, '-signature', sf, mf], capture_output=True).returncode == 0 else 0)
EOP
}
updfield() {  # update.json python-expression (d = the signed data) -> value
  python3 -c "import json,sys; d=json.loads(json.load(open(sys.argv[1]))['data']); print(eval(sys.argv[2]))" "$1" "$2"
}
assets() { ls "$S/rel/$1/assets" | LC_ALL=C sort | tr '\n' ' '; }
published() { [ -d "$S/rel/$1" ] && [ "$(cat "$S/rel/$1/draft")" = "false" ] && echo 1 || echo 0; }

# ---- 1) release after an earlier one (serial 5), dictionaries unchanged: no zip is attached, the catalog keeps pointing to v1.71.0
fresh; earlier v1.71.0 5
publish automatic true X=1
check "new release: publishes" "$([ $CODE = 0 ] && [ "$(published v1.72.0)" = 1 ] && echo 1 || echo 0)" "$OUT"
check "new release: assets = APK with the version in the name + source zip + catalog + update.json, no dictionary zip" "$([ "$(assets v1.72.0)" = "catalog.json mr-keyboard-v1.72.0-source.zip mr-keyboard-v1.72.0.apk update.json " ] && echo 1 || echo 0)" "$(assets v1.72.0)"
check "new release: no unsigned APK" "$([ -z "$(ls "$S/rel/v1.72.0/assets" | grep -i unsigned)" ] && echo 1 || echo 0)"
check "new release: serial continues the previous catalog's (5) and the 3 languages stay in v1.71.0" "$([ "$(serial "$S/rel/v1.72.0/assets/catalog.json")" = 5 ] && [ "$(relof "$S/rel/v1.72.0/assets/catalog.json" pt-BR)" = v1.71.0 ] && [ "$(relof "$S/rel/v1.72.0/assets/catalog.json" en-US)" = v1.71.0 ] && [ "$(relof "$S/rel/v1.72.0/assets/catalog.json" es)" = v1.71.0 ] && echo 1 || echo 0)" "$(serial "$S/rel/v1.72.0/assets/catalog.json")"
check "new release: it is the latest" "$([ "$(cat "$S/latest")" = v1.72.0 ] && echo 1 || echo 0)"
check "new release: it downloaded the previous catalog only, not the zips" "$(grep -q 'release download v1.71.0 -p catalog.json' "$S/log" && ! grep -q "\.zip'" "$S/log" && echo 1 || echo 0)"
check "release text: both languages of the notes + included dictionaries + SHA-256, no full-notes link" "$(grep -q 'Corrige o fechamento do app de teste' "$S/rel/v1.72.0/notes.md" && grep -q 'Fixes the test app closing' "$S/rel/v1.72.0/notes.md" && grep -q 'Dicionários incluídos' "$S/rel/v1.72.0/notes.md" && grep -q 'pt-BR v2' "$S/rel/v1.72.0/notes.md" && grep -q 'APK SHA-256' "$S/rel/v1.72.0/notes.md" && ! grep -q 'blob/' "$S/rel/v1.72.0/notes.md" && echo 1 || echo 0)"
check "release text: nothing is marked as new in this version" "$(! grep -q 'novo nesta versão' "$S/rel/v1.72.0/notes.md" && echo 1 || echo 0)"

# ---- 1b) the source zip: what is in it, what is not, and that it is the committed code
Z=$(zipof v1.72.0); ZL=$(unzip -Z1 "$Z" 2> /dev/null)
check "source zip: everything inside the folder mr-keyboard-<tag>/" "$([ -n "$ZL" ] && [ -z "$(echo "$ZL" | grep -v '^mr-keyboard-v1.72.0/')" ] && echo 1 || echo 0)" "$(echo "$ZL" | head -3)"
check "source zip: has the apktool project, the native code, the Java layer, the licence and the READMEs" "$(for f in apktool.yml AndroidManifest.xml res/values/strings.xml smali/com/x/A.smali lib/arm64-v8a/libx.so native/CMakeLists.txt engine/CMakeLists.txt native-src.sha256 docs/tools/build_java.sh docs/tools/check_java_smali.sh docs/tools/java/src LICENSE README.md README.pt-BR.md; do echo "$ZL" | grep -q "^mr-keyboard-v1.72.0/$f" || { echo "missing $f" >&2; echo 0; exit; }; done; echo 1)"
check "source zip: no dictionaries, release notes, workflows, plan, build, APK, out/ or the other tools" "$([ -z "$(echo "$ZL" | grep -E '/(dicts|build|out|\.github)/|release-notes|plan-x|\.apk$|publish_test|make_catalog')" ] && echo 1 || echo 0)" "$(echo "$ZL" | grep -E '/(dicts|build|out|\.github)/|release-notes|plan-x|\.apk$|publish_test|make_catalog' | head -3)"
check "source zip: the content is the published commit's (the file is as committed)" "$(unzip -p "$Z" mr-keyboard-v1.72.0/smali/com/x/A.smali | grep -q committed && echo 1 || echo 0)"
check "source zip: the SHA-256 and the link to the verification are in the release text" "$(grep -q "Source zip SHA-256: \`$(sha256sum "$Z" | cut -d' ' -f1)\`" "$S/rel/v1.72.0/notes.md" && grep -q 'mr-keyboard-v1.72.0-source.zip' "$S/rel/v1.72.0/notes.md" && grep -q '#verifying-a-release' "$S/rel/v1.72.0/notes.md" && echo 1 || echo 0)"
check "GITHUB_OUTPUT: published, tag, apk and source (what the workflow attests)" "$([ "$(cat "$T/ghout")" = "$(printf 'published=true\ntag=v1.72.0\napk=mr-keyboard-v1.72.0.apk\nsource=mr-keyboard-v1.72.0-source.zip')" ] && [ -f "$W/mr-keyboard-v1.72.0.apk" ] && [ -f "$W/mr-keyboard-v1.72.0-source.zip" ] && echo 1 || echo 0)" "$(cat "$T/ghout")"
( cd "$W" && sh docs/tools/make_source_zip.sh v1.72.0 "$SHA" "$T/again.zip" > /dev/null )
check "source zip: same commit, same bytes (reproducible)" "$(cmp -s "$T/again.zip" "$Z" && echo 1 || echo 0)"

# ---- 1b2) update.json: what the app reads to learn that a new version is out
U=$S/rel/v1.72.0/assets/update.json; A=$S/rel/v1.72.0/assets/mr-keyboard-v1.72.0.apk
check "update.json: signed for the update (and only for the update: with the catalog prefix it does not validate)" "$([ "$(sigok "$U" update)" = 1 ] && [ "$(sigok "$U" catalog)" = 0 ] && echo 1 || echo 0)"
check "catalog.json: signed for the catalog (and not valid as an update notice) - the prefixes keep the two apart" "$([ "$(sigok "$S/rel/v1.72.0/assets/catalog.json" catalog)" = 1 ] && [ "$(sigok "$S/rel/v1.72.0/assets/catalog.json" update)" = 0 ] && echo 1 || echo 0)"
check "update.json: same signer (certificate) as the catalog" "$([ "$(python3 -c "import json,sys; print(json.load(open(sys.argv[1]))['signer'])" "$U")" = "$(python3 -c "import json,sys; print(json.load(open(sys.argv[1]))['signer'])" "$S/rel/v1.72.0/assets/catalog.json")" ] && echo 1 || echo 0)"
check "update.json: version and code of apktool.yml" "$([ "$(updfield "$U" "d['versionName']")" = v1.72.0 ] && [ "$(updfield "$U" "d['versionCode']")" = 1072000 ] && echo 1 || echo 0)"
check "update.json: APK name, size and SHA-256 are those of the APK in the release" "$([ "$(updfield "$U" "d['apk']['name']")" = mr-keyboard-v1.72.0.apk ] && [ "$(updfield "$U" "d['apk']['size']")" = "$(stat -c %s "$A")" ] && [ "$(updfield "$U" "d['apk']['sha256']")" = "$(sha256sum "$A" | cut -d' ' -f1)" ] && echo 1 || echo 0)" "$(updfield "$U" "d['apk']")"
check "update.json: notes in Portuguese and English, each from its own block" "$([ "$(updfield "$U" "'Corrige o fechamento' in d['notes']['pt-BR'] and 'Fixes' not in d['notes']['pt-BR']")" = True ] && [ "$(updfield "$U" "'Fixes the test app closing' in d['notes']['en'] and 'Corrige' not in d['notes']['en']")" = True ] && echo 1 || echo 0)"
check "update.json: no link (the app builds the addresses from its own constants)" "$(! grep -q 'http' "$U" && echo 1 || echo 0)"

# ---- 1c) only the commit counts: a change made in the folder after the commit does not enter the zip
fresh; earlier v1.71.0 5; commit_all; C1=$(git -C "$W" rev-parse HEAD)
echo '.class public Lcom/x/A; # DIRTY' > "$W/smali/com/x/A.smali"; echo new > "$W/smali/com/x/Uncommitted.smali"
FORCE_SHA=$C1 publish automatic true X=1
check "source zip: edited and new files that were not committed stay out (the zip is the commit)" "$([ $CODE = 0 ] && unzip -p "$(zipof v1.72.0)" mr-keyboard-v1.72.0/smali/com/x/A.smali | grep -q committed && ! unzip -Z1 "$(zipof v1.72.0)" | grep -q Uncommitted && echo 1 || echo 0)" "$OUT"

# ---- 1d) a commit that does not exist: error before anything is created
fresh; earlier v1.71.0 5
FORCE_SHA=0000000000000000000000000000000000000000 publish automatic true X=1
check "commit that does not exist: error (even if automatic), nothing created and nothing for the workflow to attest" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && [ "$(cat "$S/latest")" = v1.71.0 ] && [ ! -s "$T/ghout" ] && echo "$OUT" | grep -q 'Nothing was published' && echo 1 || echo 0)" "$CODE $OUT"

# ---- 1e) update.json cannot be made: error in any mode, nothing created, nothing to attest
fresh; earlier v1.71.0 5; printf '**Português**\n- Só em português.\n' > "$W/docs/release-notes/v1.72.0.md"
publish automatic true X=1
check "notes without the English block: error (even if automatic), nothing created" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && [ "$(cat "$S/latest")" = v1.71.0 ] && [ ! -s "$T/ghout" ] && echo "$OUT" | grep -q 'Could not make update.json' && echo "$OUT" | grep -q 'English' && echo 1 || echo 0)" "$CODE $OUT"
fresh; earlier v1.71.0 5; rm "$W/docs/release-notes/v1.72.0.md"
publish automatic true X=1
check "no notes file: error and nothing created" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)" "$OUT"
fresh; earlier v1.71.0 5; printf "versionInfo:\n  versionCode: '1'\n  versionName: v1.72.0\n" > "$W/apktool.yml"
publish automatic true X=1
check "versionCode that does not follow the version: error and nothing created" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo "$OUT" | grep -q '1072000' && echo 1 || echo 0)" "$OUT"
fresh; earlier v1.71.0 5
publish automatic true FAKE_DROP=update.json
check "update.json that did not upload: error, draft deleted, nothing published" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && [ "$(cat "$S/latest")" = v1.71.0 ] && [ ! -s "$T/ghout" ] && echo 1 || echo 0)" "$CODE $OUT"

# ---- 2) second release (nothing changed in the dictionaries): same serial, and the catalog still points to v1.71.0 (not to v1.72.0)
fresh; earlier v1.71.0 5; publish automatic true X=1
setver "$W" v1.73.0; notes "$W/docs/release-notes/v1.73.0.md"
publish automatic true X=1
check "2nd release: publishes and becomes the latest" "$([ $CODE = 0 ] && [ "$(cat "$S/latest")" = v1.73.0 ] && echo 1 || echo 0)" "$OUT"
check "2nd release: serial kept (5), zips still in v1.71.0 and only APK + source zip + catalog + update.json attached" "$([ "$(serial "$S/rel/v1.73.0/assets/catalog.json")" = 5 ] && [ "$(relof "$S/rel/v1.73.0/assets/catalog.json" pt-BR)" = v1.71.0 ] && [ "$(assets v1.73.0)" = "catalog.json mr-keyboard-v1.73.0-source.zip mr-keyboard-v1.73.0.apk update.json " ] && echo 1 || echo 0)" "$(assets v1.73.0)"
check "2nd release: the zips were checked in v1.71.0 before publishing" "$(grep -q 'api repos/owner/repo/releases/tags/v1.71.0' "$S/log" && echo 1 || echo 0)"

# ---- 3) pt-BR goes up a version: serial +1 and only the new zip of that language (the others stay in v1.71.0)
setver "$W" v1.74.0; notes "$W/docs/release-notes/v1.74.0.md"; pack "$W/dicts" pt-BR 3 aaaaX
publish automatic true X=1
check "pt-BR v3: serial 6 and assets with only the pt-BR dictionary zip (with the prefix in the name)" "$([ $CODE = 0 ] && [ "$(serial "$S/rel/v1.74.0/assets/catalog.json")" = 6 ] && [ "$(assets v1.74.0)" = "catalog.json mr-keyboard-dict-pt-BR-3.zip mr-keyboard-v1.74.0-source.zip mr-keyboard-v1.74.0.apk update.json " ] && echo 1 || echo 0)" "$(assets v1.74.0) serial $(serial "$S/rel/v1.74.0/assets/catalog.json")"
check "pt-BR v3: pt-BR in v1.74.0, en-US and es still in v1.71.0" "$([ "$(relof "$S/rel/v1.74.0/assets/catalog.json" pt-BR)" = v1.74.0 ] && [ "$(relof "$S/rel/v1.74.0/assets/catalog.json" en-US)" = v1.71.0 ] && [ "$(relof "$S/rel/v1.74.0/assets/catalog.json" es)" = v1.71.0 ] && echo 1 || echo 0)"
check "pt-BR v3: release text marks pt-BR as new in this version" "$(grep -q 'pt-BR v3 (novo nesta versão / new in this version)' "$S/rel/v1.74.0/notes.md" && grep -q 'en-US v2,' "$S/rel/v1.74.0/notes.md" && echo 1 || echo 0)" "$(grep 'Dicion' "$S/rel/v1.74.0/notes.md")"

# ---- 4) no catalog published at all: serial 1
fresh
publish automatic true X=1
check "no earlier catalog: serial 1, three zips attached and all three languages in this release" "$([ $CODE = 0 ] && [ "$(serial "$S/rel/v1.72.0/assets/catalog.json")" = 1 ] && [ "$(ls "$S/rel/v1.72.0/assets" | grep -c '^mr-keyboard-dict-.*zip$')" = 3 ] && [ "$(relof "$S/rel/v1.72.0/assets/catalog.json" es)" = v1.72.0 ] && [ -f "$S/rel/v1.72.0/assets/mr-keyboard-dict-es-1.zip" ] && echo 1 || echo 0)" "$OUT"

# ---- 5) an asset did not upload: the draft is deleted and nothing is published
fresh; earlier v1.71.0 5; pack "$W/dicts" es 2 ccccY
publish automatic true FAKE_DROP=mr-keyboard-dict-es-2.zip
check "missing asset: error, draft deleted, nothing published and the latest stays the earlier one" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && [ "$(cat "$S/latest")" = v1.71.0 ] && echo 1 || echo 0)" "$CODE $OUT"

fresh; earlier v1.71.0 5
publish automatic true FAKE_DROP=mr-keyboard-v1.72.0-source.zip
check "source zip that did not upload: error, draft deleted, nothing published and nothing for the workflow to attest" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && [ "$(cat "$S/latest")" = v1.71.0 ] && [ ! -s "$T/ghout" ] && echo 1 || echo 0)" "$CODE $OUT"

# ---- 6) old draft of the same version: it is deleted and publishing goes on
fresh; earlier v1.71.0 5
mkdir -p "$S/rel/v1.72.0/assets"; echo true > "$S/rel/v1.72.0/draft"; echo leftover > "$S/rel/v1.72.0/assets/old.zip"
publish automatic true X=1
check "old draft: deleted, publishes again" "$([ $CODE = 0 ] && [ "$(published v1.72.0)" = 1 ] && [ ! -f "$S/rel/v1.72.0/assets/old.zip" ] && echo 1 || echo 0)" "$OUT"

# ---- 6b) a zip that the catalog keeps in an earlier release disappeared or changed: nothing is created
fresh; earlier v1.71.0 5; rm "$S/rel/v1.71.0/assets/mr-keyboard-dict-es-1.zip"
publish automatic true X=1
check "zip missing from the earlier release: error naming the zip and the release, no draft, no release" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo "$OUT" | grep -q 'mr-keyboard-dict-es-1.zip in release v1.71.0' && [ "$(cat "$S/latest")" = v1.71.0 ] && echo 1 || echo 0)" "$OUT"
fresh; earlier v1.71.0 5; echo x >> "$S/rel/v1.71.0/assets/mr-keyboard-dict-pt-BR-2.zip"
publish automatic true X=1
check "zip with another size in the earlier release: error and nothing created" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)" "$OUT"
fresh; earlier v1.71.0 5; echo true > "$S/rel/v1.71.0/draft"
publish automatic true X=1
check "earlier release that is still a draft does not count as holding the zips: error" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"

# ---- 7) version already published
fresh; earlier v1.71.0 5
mkdir -p "$S/rel/v1.72.0/assets"; echo false > "$S/rel/v1.72.0/draft"; echo v1.72.0 > "$S/latest"
publish automatic true X=1
check "version already published, automatic: warns, changes nothing and leaves nothing to attest" "$([ $CODE = 0 ] && [ "$(ls "$S/rel/v1.72.0/assets" | wc -l)" = 0 ] && [ ! -s "$T/ghout" ] && echo 1 || echo 0)"
publish manual true X=1
check "version already published, manual: error" "$([ $CODE != 0 ] && echo 1 || echo 0)"

# ---- 8) obstacles before building anything
fresh; earlier v1.71.0 5; rm "$W/mr-keyboard-signed.apk"
publish automatic true X=1
check "no signed APK, automatic: warns, does not publish" "$([ $CODE = 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"
publish manual true X=1
check "no signed APK, manual: error" "$([ $CODE != 0 ] && echo 1 || echo 0)"
echo apk > "$W/mr-keyboard-signed.apk"
publish automatic true FAKE_UNSIGNED=1
check "invalid signature, automatic: does not publish" "$([ $CODE = 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"
publish automatic false X=1
check "stale lib, automatic: does not publish" "$([ $CODE = 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"
publish manual false X=1
check "stale lib, manual: error" "$([ $CODE != 0 ] && echo 1 || echo 0)"

# ---- 9) real errors in the dictionaries: they fail and leave nothing behind
fresh; earlier v1.71.0 5; pack "$W/dicts" en-US 2 bbbbCHANGED
publish automatic true X=1
check "dictionary changed without raising the version: error and nothing created" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"
fresh; earlier v1.71.0 5
publish automatic true KEYSTORE_B64=
check "no key for the catalog: error and nothing created" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"

# ---- 10) the latest exists but has no catalog (e.g. a release made before the catalog): serial 1, everything attached
fresh v1.73.0; notes "$W/docs/release-notes/v1.73.0.md"
mkdir -p "$S/rel/v1.72.0/assets"; echo false > "$S/rel/v1.72.0/draft"; echo apk > "$S/rel/v1.72.0/assets/mr-keyboard-v1.72.0.apk"; echo v1.72.0 > "$S/latest"
publish automatic true X=1
check "latest without a catalog: v1.73.0 goes out with serial 1, everything attached and becomes the latest" "$([ $CODE = 0 ] && [ "$(serial "$S/rel/v1.73.0/assets/catalog.json")" = 1 ] && [ "$(assets v1.73.0)" = "catalog.json mr-keyboard-dict-en-US-2.zip mr-keyboard-dict-es-1.zip mr-keyboard-dict-pt-BR-2.zip mr-keyboard-v1.73.0-source.zip mr-keyboard-v1.73.0.apk update.json " ] && [ "$(cat "$S/latest")" = v1.73.0 ] && echo 1 || echo 0)" "$OUT"

# ---- 11) the weights of the gesture recognition (gesture/pack.json, 1.96.0): a zip of its own, in the "models" list of the same catalog
gmodel() {  # workspace version content: gesture/ with pack.json, the weights, the licence text and a notice
  mkdir -p "$1/gesture"
  printf '{"id":"gesture","name":{"en":"Gesture recognition"},"version":%s,"format":1,"minApp":1096000,"files":["encoder.bin","LICENSE-FUTO-Model-Weights.md","NOTICE.txt"],"licenses":["FUTO Model Weights License 1.0"]}' "$2" > "$1/gesture/pack.json"
  { printf 'MRSWENC1'; head -c 3000 /dev/zero | tr '\0' "$3"; } > "$1/gesture/encoder.bin"
  head -c 2000 /dev/zero | tr '\0' 'L' > "$1/gesture/LICENSE-FUTO-Model-Weights.md"
  echo notice > "$1/gesture/NOTICE.txt"
}
modelrel() { python3 -c "import json,sys; print(json.loads(json.load(open(sys.argv[1]))['data'])['models'][0]['release'])" "$1"; }
fresh; earlier v1.71.0 5; gmodel "$W" 1 w
publish automatic true X=1
check "model, first time: publishes, serial 6, the model zip is attached next to the usual assets and no dictionary zip is" "$([ $CODE = 0 ] && [ "$(serial "$S/rel/v1.72.0/assets/catalog.json")" = 6 ] && [ "$(assets v1.72.0)" = "catalog.json mr-keyboard-model-gesture-1.zip mr-keyboard-v1.72.0-source.zip mr-keyboard-v1.72.0.apk update.json " ] && echo 1 || echo 0)" "$(assets v1.72.0) $OUT"
check "model, first time: the catalog says the model is in this release and the languages stay in v1.71.0" "$([ "$(modelrel "$S/rel/v1.72.0/assets/catalog.json")" = v1.72.0 ] && [ "$(relof "$S/rel/v1.72.0/assets/catalog.json" pt-BR)" = v1.71.0 ] && echo 1 || echo 0)"
check "model, first time: the signed catalog still checks" "$(sigok "$S/rel/v1.72.0/assets/catalog.json" catalog)"
check "model, first time: the release text names it, new in this version, with the licence of the weights" "$(grep -q 'Gesture recognition: gesture v1 (novo nesta versão / new in this version)' "$S/rel/v1.72.0/notes.md" && grep -q 'FUTO Model Weights License 1.0' "$S/rel/v1.72.0/notes.md" && echo 1 || echo 0)" "$(cat "$S/rel/v1.72.0/notes.md")"
check "model, first time: the zip holds pack.json, the weights, the licence and the notice" "$([ "$(unzip -Z1 "$S/rel/v1.72.0/assets/mr-keyboard-model-gesture-1.zip" | tr '\n' ' ')" = "pack.json encoder.bin LICENSE-FUTO-Model-Weights.md NOTICE.txt " ] && echo 1 || echo 0)"
setver "$W" v1.73.0; notes "$W/docs/release-notes/v1.73.0.md"
publish automatic true X=1
check "model unchanged in the next release: serial kept, no zip attached, the catalog keeps it in v1.72.0" "$([ $CODE = 0 ] && [ "$(serial "$S/rel/v1.73.0/assets/catalog.json")" = 6 ] && [ "$(assets v1.73.0)" = "catalog.json mr-keyboard-v1.73.0-source.zip mr-keyboard-v1.73.0.apk update.json " ] && [ "$(modelrel "$S/rel/v1.73.0/assets/catalog.json")" = v1.72.0 ] && echo 1 || echo 0)" "$OUT"
check "model unchanged: its zip was checked in v1.72.0 before publishing, and the text does not call it new" "$(grep -q 'mr-keyboard-model-gesture-1.zip stays in v1.72.0' "$T/out" && grep -q 'Gesture recognition: gesture v1\.' "$S/rel/v1.73.0/notes.md" && echo 1 || echo 0)" "$OUT"
setver "$W" v1.74.0; notes "$W/docs/release-notes/v1.74.0.md"; gmodel "$W" 2 x
publish automatic true X=1
check "model v2: serial 7 and only its new zip, in the new release" "$([ $CODE = 0 ] && [ "$(serial "$S/rel/v1.74.0/assets/catalog.json")" = 7 ] && [ "$(assets v1.74.0)" = "catalog.json mr-keyboard-model-gesture-2.zip mr-keyboard-v1.74.0-source.zip mr-keyboard-v1.74.0.apk update.json " ] && [ "$(modelrel "$S/rel/v1.74.0/assets/catalog.json")" = v1.74.0 ] && echo 1 || echo 0)" "$OUT"
setver "$W" v1.75.0; notes "$W/docs/release-notes/v1.75.0.md"; rm "$S/rel/v1.74.0/assets/mr-keyboard-model-gesture-2.zip"
publish automatic true X=1
check "model zip missing from the release that holds it: error naming it, nothing created" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.75.0" ] && echo "$OUT" | grep -q 'mr-keyboard-model-gesture-2.zip in release v1.74.0' && echo 1 || echo 0)" "$OUT"
fresh; earlier v1.71.0 5; gmodel "$W" 1 w
publish automatic true FAKE_DROP=mr-keyboard-model-gesture-1.zip
check "model zip that did not upload: error, draft deleted, nothing published" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && [ "$(cat "$S/latest")" = v1.71.0 ] && echo 1 || echo 0)" "$CODE $OUT"
fresh; earlier v1.71.0 5; gmodel "$W" 1 w; printf 'NOTWEIGHTS' > "$W/gesture/encoder.bin"
publish automatic true X=1
check "model with weights that are not weights: error and nothing created" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)" "$OUT"

rm -rf "$T"
if [ $fails = 0 ]; then echo "ALL OK ($ok checks)"; else echo "$fails FAILURE(S) out of $((ok+fails)) checks"; exit 1; fi
