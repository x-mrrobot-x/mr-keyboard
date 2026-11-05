#!/bin/bash
# Tests docs/tools/publish_release.sh with a fake gh (gh), a fake apksigner and the real signature
# (test keystore). Run from the project root: bash docs/tools/publish_test/run.sh
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

pack() {  # folder id version content
  mkdir -p "$1/$2"
  printf '{"id":"%s","lang":"%s","name":{"en":"%s"},"version":%s,"format":1,"minApp":1,"files":["main.dict"],"licenses":[]}' "$2" "${2%%-*}" "$2" "$3" > "$1/$2/pack.json"
  printf '\310\001%s' "$4" > "$1/$2/main.dict"
}

notes() {  # fake notes file (does not depend on the project's real notes)
  mkdir -p "$(dirname "$1")"
  printf '**Português**\n- Corrige o fechamento do app de teste.\n\n**English**\n- Fixes the test app closing.\n' > "$1"
}

fresh() {  # creates a workspace: $W (project) and $S (gh state)
  W=$(mktemp -d -p "$T"); S=$(mktemp -d -p "$T")
  mkdir -p "$W/docs" "$S/rel"; ln -s "$ROOT/docs/tools" "$W/docs/tools"
  notes "$W/docs/release-notes/v1.72.0.md"
  printf "versionInfo:\n  versionCode: '1'\n  versionName: %s\n" "${1:-v1.72.0}" > "$W/apktool.yml"
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

publish() {  # mode lib_ok [extra environment]  -> $CODE, $OUT
  ( cd "$W" && env "${@:3}" PATH="$T/bin:$PATH" FAKE_STATE="$S" MODE="$1" LIB_OK="$2" GITHUB_SHA=abc123 \
      GITHUB_REPOSITORY=owner/repo ANDROID_HOME="$T/android" GH_TOKEN=t bash "$ROOT/docs/tools/publish_release.sh" ) > "$T/out" 2>&1
  CODE=$?; OUT=$(cat "$T/out")
}
serial() { python3 -c "import json,sys; print(json.loads(json.load(open(sys.argv[1]))['data'])['serial'])" "$1"; }
relof() { python3 -c "import json,sys; print([p['release'] for p in json.loads(json.load(open(sys.argv[1]))['data'])['packs'] if p['id'] == sys.argv[2]][0])" "$1" "$2"; }
assets() { ls "$S/rel/$1/assets" | LC_ALL=C sort | tr '\n' ' '; }
published() { [ -d "$S/rel/$1" ] && [ "$(cat "$S/rel/$1/draft")" = "false" ] && echo 1 || echo 0; }

# ---- 1) release after an earlier one (serial 5), dictionaries unchanged: no zip is attached, the catalog keeps pointing to v1.71.0
fresh; earlier v1.71.0 5
publish automatic true X=1
check "new release: publishes" "$([ $CODE = 0 ] && [ "$(published v1.72.0)" = 1 ] && echo 1 || echo 0)" "$OUT"
check "new release: assets = APK with the version in the name + catalog, no dictionary zip" "$([ "$(assets v1.72.0)" = "catalog.json mr-keyboard-v1.72.0.apk " ] && echo 1 || echo 0)" "$(assets v1.72.0)"
check "new release: no unsigned APK" "$([ -z "$(ls "$S/rel/v1.72.0/assets" | grep -i unsigned)" ] && echo 1 || echo 0)"
check "new release: serial continues the previous catalog's (5) and the 3 languages stay in v1.71.0" "$([ "$(serial "$S/rel/v1.72.0/assets/catalog.json")" = 5 ] && [ "$(relof "$S/rel/v1.72.0/assets/catalog.json" pt-BR)" = v1.71.0 ] && [ "$(relof "$S/rel/v1.72.0/assets/catalog.json" en-US)" = v1.71.0 ] && [ "$(relof "$S/rel/v1.72.0/assets/catalog.json" es)" = v1.71.0 ] && echo 1 || echo 0)" "$(serial "$S/rel/v1.72.0/assets/catalog.json")"
check "new release: it is the latest" "$([ "$(cat "$S/latest")" = v1.72.0 ] && echo 1 || echo 0)"
check "new release: it downloaded the previous catalog only, not the zips" "$(grep -q 'release download v1.71.0 -p catalog.json' "$S/log" && ! grep -q "\.zip'" "$S/log" && echo 1 || echo 0)"
check "release text: both languages of the notes + included dictionaries + SHA-256, no full-notes link" "$(grep -q 'Corrige o fechamento do app de teste' "$S/rel/v1.72.0/notes.md" && grep -q 'Fixes the test app closing' "$S/rel/v1.72.0/notes.md" && grep -q 'Dicionários incluídos' "$S/rel/v1.72.0/notes.md" && grep -q 'pt-BR v2' "$S/rel/v1.72.0/notes.md" && grep -q 'APK SHA-256' "$S/rel/v1.72.0/notes.md" && ! grep -q 'blob/' "$S/rel/v1.72.0/notes.md" && echo 1 || echo 0)"
check "release text: nothing is marked as new in this version" "$(! grep -q 'novo nesta versão' "$S/rel/v1.72.0/notes.md" && echo 1 || echo 0)"

# ---- 2) second release (nothing changed in the dictionaries): same serial, and the catalog still points to v1.71.0 (not to v1.72.0)
sed -i 's/v1.72.0/v1.73.0/' "$W/apktool.yml"; notes "$W/docs/release-notes/v1.73.0.md"
publish automatic true X=1
check "2nd release: publishes and becomes the latest" "$([ $CODE = 0 ] && [ "$(cat "$S/latest")" = v1.73.0 ] && echo 1 || echo 0)" "$OUT"
check "2nd release: serial kept (5), zips still in v1.71.0 and only APK + catalog attached" "$([ "$(serial "$S/rel/v1.73.0/assets/catalog.json")" = 5 ] && [ "$(relof "$S/rel/v1.73.0/assets/catalog.json" pt-BR)" = v1.71.0 ] && [ "$(assets v1.73.0)" = "catalog.json mr-keyboard-v1.73.0.apk " ] && echo 1 || echo 0)" "$(assets v1.73.0)"
check "2nd release: the zips were checked in v1.71.0 before publishing" "$(grep -q 'api repos/owner/repo/releases/tags/v1.71.0' "$S/log" && echo 1 || echo 0)"

# ---- 3) pt-BR goes up a version: serial +1 and only the new zip of that language (the others stay in v1.71.0)
sed -i 's/v1.73.0/v1.74.0/' "$W/apktool.yml"; notes "$W/docs/release-notes/v1.74.0.md"; pack "$W/dicts" pt-BR 3 aaaaX
publish automatic true X=1
check "pt-BR v3: serial 6 and assets with only the pt-BR zip (with the dictionary prefix in the name)" "$([ $CODE = 0 ] && [ "$(serial "$S/rel/v1.74.0/assets/catalog.json")" = 6 ] && [ "$(assets v1.74.0)" = "catalog.json mr-keyboard-dict-pt-BR-3.zip mr-keyboard-v1.74.0.apk " ] && echo 1 || echo 0)" "$(assets v1.74.0) serial $(serial "$S/rel/v1.74.0/assets/catalog.json")"
check "pt-BR v3: pt-BR in v1.74.0, en-US and es still in v1.71.0" "$([ "$(relof "$S/rel/v1.74.0/assets/catalog.json" pt-BR)" = v1.74.0 ] && [ "$(relof "$S/rel/v1.74.0/assets/catalog.json" en-US)" = v1.71.0 ] && [ "$(relof "$S/rel/v1.74.0/assets/catalog.json" es)" = v1.71.0 ] && echo 1 || echo 0)"
check "pt-BR v3: release text marks pt-BR as new in this version" "$(grep -q 'pt-BR v3 (novo nesta versão / new in this version)' "$S/rel/v1.74.0/notes.md" && grep -q 'en-US v2,' "$S/rel/v1.74.0/notes.md" && echo 1 || echo 0)" "$(grep 'Dicion' "$S/rel/v1.74.0/notes.md")"

# ---- 4) no catalog published at all: serial 1
fresh
publish automatic true X=1
check "no earlier catalog: serial 1, three zips attached and all three languages in this release" "$([ $CODE = 0 ] && [ "$(serial "$S/rel/v1.72.0/assets/catalog.json")" = 1 ] && [ "$(ls "$S/rel/v1.72.0/assets" | grep -c zip)" = 3 ] && [ "$(relof "$S/rel/v1.72.0/assets/catalog.json" es)" = v1.72.0 ] && [ -f "$S/rel/v1.72.0/assets/mr-keyboard-dict-es-1.zip" ] && echo 1 || echo 0)" "$OUT"

# ---- 5) an asset did not upload: the draft is deleted and nothing is published
fresh; earlier v1.71.0 5; pack "$W/dicts" es 2 ccccY
publish automatic true FAKE_DROP=mr-keyboard-dict-es-2.zip
check "missing asset: error, draft deleted, nothing published and the latest stays the earlier one" "$([ $CODE != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && [ "$(cat "$S/latest")" = v1.71.0 ] && echo 1 || echo 0)" "$CODE $OUT"

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
check "version already published, automatic: warns and changes nothing" "$([ $CODE = 0 ] && [ "$(ls "$S/rel/v1.72.0/assets" | wc -l)" = 0 ] && echo 1 || echo 0)"
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
check "latest without a catalog: v1.73.0 goes out with serial 1, everything attached and becomes the latest" "$([ $CODE = 0 ] && [ "$(serial "$S/rel/v1.73.0/assets/catalog.json")" = 1 ] && [ "$(assets v1.73.0)" = "catalog.json mr-keyboard-dict-en-US-2.zip mr-keyboard-dict-es-1.zip mr-keyboard-dict-pt-BR-2.zip mr-keyboard-v1.73.0.apk " ] && [ "$(cat "$S/latest")" = v1.73.0 ] && echo 1 || echo 0)" "$OUT"

rm -rf "$T"
if [ $fails = 0 ]; then echo "ALL OK ($ok checks)"; else echo "$fails FAILURE(S) out of $((ok+fails)) checks"; exit 1; fi
