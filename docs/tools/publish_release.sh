#!/bin/bash
# Publishes the single release of a launch (used by the "Mr Keyboard - APK" workflow): the signed APK, the zip of
# the source code, the dictionary catalog and the update notice (both signed with the APK key) and the zips of the
# languages that changed in this version.
# The tag is the versionName from apktool.yml (v1.72.0) and the notes come from docs/release-notes/<tag>.md
# (e.g. docs/release-notes/v1.72.0.md): a short file, Portuguese and English, that is the release text itself,
# followed by the list of included dictionaries and the checksums. The same two blocks go in update.json.
# The APK is named mr-keyboard-<tag>.apk (e.g. mr-keyboard-v1.72.0.apk), so the version shows in the asset
# list; the app reads the catalog from .../releases/latest/download/catalog.json and the update notice from
# .../releases/latest/download/update.json (make_update.py builds it, with the size and SHA-256 of the APK).
# The source code goes as mr-keyboard-<tag>-source.zip, made by make_source_zip.sh from the commit being published
# (git archive).
#
# Dictionaries: starts from the catalog of the latest release (if there is one). A pack that did not change
# keeps its zip in the release that made it (the catalog says which one in "release"), so nothing is copied;
# only the packs whose version went up in dicts/ get a zip, attached to this release (make_catalog.py --tag).
# The weights of the gesture recognition (gesture/pack.json, 1.96.0) follow the same rules: they go in the "models" list of
# the same catalog and their zip (mr-keyboard-model-gesture-<version>.zip) is attached only to the release where it changed.
# Before creating anything, the script checks that every zip that stays in another release still exists there
# with the size from the catalog. The release is created as a draft, the assets are checked and only then it
# is published: a half-made release never becomes "latest".
#
# Variables:
#   MODE   manual (run by hand with "publish") or automatic (push to main)
#   LIB_OK false when lib/ does not match the current native/
#   GH_TOKEN, GITHUB_SHA, GITHUB_REPOSITORY, ANDROID_HOME (from Actions); GITHUB_OUTPUT (optional): after publishing,
#   it receives published=true, tag, apk and source (the workflow attests those two files)
#   KEYSTORE_B64 + KEYSTORE_PASS + KEY_ALIAS + KEY_PASS, or KEY_PK8_B64 + CERT_PEM_B64 (they sign the catalog)
# In manual mode any problem is an error (you asked to publish). In automatic mode, whatever prevents
# publishing (no key, version already published, stale lib) only warns and leaves the APK in the artifacts.
set -e
MODE=${MODE:-manual}

stop() {   # $1 = message; severity depends on the mode
  if [ "$MODE" = "manual" ]; then echo "::error::$1 Nothing was published."; exit 1; fi
  echo "::warning::$1 Nothing was published."; exit 0
}

if [ "$LIB_OK" = "false" ]; then
  stop "lib/ was not built from the current native/ (run 'Mr Keyboard - native lib', extract the native-libs artifact at the project root and commit)."
fi
if [ ! -f mr-keyboard-signed.apk ]; then
  stop "No signed APK (the key secrets are missing)."
fi

# only an APK with a valid signature goes to the Release (never mr-keyboard-unsigned.apk)
BT=$(ls -d "$ANDROID_HOME"/build-tools/* | sort -V | tail -1)
if ! "$BT/apksigner" verify mr-keyboard-signed.apk > /dev/null 2>&1; then
  stop "The APK has no valid signature (apksigner verify failed)."
fi

VER=$(sed -n 's/^  versionName: *//p' apktool.yml | tr -d "'\" ")
N="${VER#v}"
TAG="v$N"
if gh release view "$TAG" > /dev/null 2>&1 && [ "$(gh release view "$TAG" --json isDraft -q .isDraft)" = "true" ]; then
  echo "::notice::Old draft of $TAG (incomplete previous run); deleting it."
  gh release delete "$TAG" -y
fi
if gh release view "$TAG" > /dev/null 2>&1; then
  if [ "$MODE" = "manual" ]; then
    echo "::error::Version $TAG was already published; raise versionCode and versionName in apktool.yml."; exit 1
  fi
  echo "::notice::Version $TAG is already in Releases; raise the version in apktool.yml to publish another."; exit 0
fi

# notes: docs/release-notes/<tag>.md (e.g. docs/release-notes/v1.72.0.md)
NOTES="docs/release-notes/$TAG.md"
APK="mr-keyboard-$TAG.apk"
SRC="mr-keyboard-$TAG-source.zip"
# a single APK, with the version in the name (the asset list shows which version it is)
cp mr-keyboard-signed.apk "$APK"
# the source code of exactly the commit being published (the tag will point to it); a failure here is a bug in any mode
if ! sh docs/tools/make_source_zip.sh "$TAG" "$GITHUB_SHA" "$SRC"; then
  echo "::error::Could not make $SRC from the commit $GITHUB_SHA. Nothing was published."; exit 1
fi
CERT=$("$BT/apksigner" verify --print-certs "$APK" | sed -n 's/.*certificate SHA-256 digest: //p' | head -1)
if [ -z "$CERT" ]; then
  stop "Could not read the APK certificate."
fi

# ---- dictionaries: start from the catalog of the latest release (if it has one); only the catalog is downloaded
mkdir -p prev out
PREV_TAG=$(gh api "repos/$GITHUB_REPOSITORY/releases/latest" -q .tag_name 2> /dev/null || true)
PREV_ARGS=""
if [ -n "$PREV_TAG" ] && gh release view "$PREV_TAG" --json assets -q '.assets[].name' 2> /dev/null | grep -qx catalog.json; then
  gh release download "$PREV_TAG" -p catalog.json -D prev
  PREV_SERIAL=$(python3 -c "import json,sys; print(json.loads(json.load(open(sys.argv[1]))['data'])['serial'])" prev/catalog.json)
  PREV_ARGS="--prev prev/catalog.json"
  echo "dictionaries: starting from the catalog of $PREV_TAG (serial $PREV_SERIAL)"
else
  echo "::warning::No dictionary catalog published before: the serial starts at 1. Apps that already stored a higher serial will refuse this catalog; only go on if this really is the first one."
fi
MODEL_ARGS=""
if [ -f gesture/pack.json ]; then MODEL_ARGS="--model gesture"; fi
python3 -I docs/tools/make_catalog.py --dicts dicts --out out --tag "$TAG" $PREV_ARGS $MODEL_ARGS
sh docs/tools/sign_catalog.sh out/data.json out/catalog.json catalog

# ---- update notice: version, APK size and SHA-256, notes of the two languages (a failure here is a bug in any mode)
if ! python3 -I docs/tools/make_update.py --apk "$APK" --tag "$TAG" --notes "$NOTES" --apktool apktool.yml --out out/update-data.json; then
  echo "::error::Could not make update.json (see above). Nothing was published."; exit 1
fi
sh docs/tools/sign_catalog.sh out/update-data.json out/update.json update
EXPECTED=$(python3 docs/tools/release_assets.py assets out/data.json "$TAG" "$APK" "$SRC")
DICTIONARIES=$(python3 docs/tools/release_assets.py text out/data.json "$TAG")
MODELS=$(python3 docs/tools/release_assets.py models out/data.json "$TAG")

# ---- zips that stay in other releases must still be there, with the size from the catalog (before any draft)
python3 docs/tools/release_assets.py external out/data.json "$TAG" > out/external.txt
while read -r REL ZIP SIZE; do
  FOUND=$(gh api "repos/$GITHUB_REPOSITORY/releases/tags/$REL" -q ".assets[] | select(.name==\"$ZIP\") | .size" 2> /dev/null || true)
  if [ "$FOUND" != "$SIZE" ]; then
    echo "::error::The catalog points to $ZIP in release $REL, but it is not there with $SIZE bytes (found: ${FOUND:-nothing}). A release that holds a dictionary in use must not be deleted or changed. Nothing was published."
    exit 1
  fi
  echo "dictionaries: $ZIP stays in $REL ($SIZE bytes, checked)"
done < out/external.txt

# ---- release text: the whole notes file (short, for people downloading); make_update.py already checked it
SUMMARY=$(sed '/./,$!d' "$NOTES")
{
  echo "Download: **$APK** · [installation / instalação](https://github.com/$GITHUB_REPOSITORY#installation)"
  echo "Código-fonte / Source code: \`$SRC\` ([como verificar / how to verify](https://github.com/$GITHUB_REPOSITORY#verifying-a-release))"
  echo
  echo "$SUMMARY"
  echo
  echo "Dicionários incluídos / Included dictionaries: $DICTIONARIES."
  if [ -n "$MODELS" ]; then
    echo "Reconhecimento de gestos / Gesture recognition: $MODELS. Feito com a tecnologia FUTO Swipe; os pesos estão sob a FUTO Model Weights License 1.0, que vai dentro do zip. / Powered by FUTO Swipe technology; the weights are under the FUTO Model Weights License 1.0, which is inside the zip."
  fi
  echo "Você só precisa do \`$APK\`: o app baixa os dicionários sozinho. / You only need \`$APK\`: the app downloads the dictionaries by itself."
  echo
  echo "- APK SHA-256: \`$(sha256sum "$APK" | cut -d' ' -f1)\`"
  echo "- Source zip SHA-256: \`$(sha256sum "$SRC" | cut -d' ' -f1)\`"
  echo "- Certificate SHA-256: \`$CERT\`"
} > notes.md

# ---- draft with everything attached, check the assets and only then publish
FILES="$APK $SRC out/catalog.json out/update.json"
for z in $(cat out/upload.txt); do FILES="$FILES out/$z"; done
gh release create "$TAG" $FILES --draft --title "Mr Keyboard $TAG" --notes-file notes.md --target "$GITHUB_SHA"
ACTUAL=$(gh release view "$TAG" --json assets -q '.assets[].name' | sort)
if [ "$ACTUAL" != "$EXPECTED" ]; then
  gh release delete "$TAG" -y || true
  echo "::error::The draft assets are not the expected ones; the draft was deleted and nothing was published."
  echo "Expected:"; echo "$EXPECTED"; echo "Found:"; echo "$ACTUAL"
  exit 1
fi
gh release edit "$TAG" --draft=false --latest
echo "Published: $TAG ($NOTES); assets: $(echo $ACTUAL | tr '\n' ' ')"
if [ -n "${GITHUB_OUTPUT:-}" ]; then
  { echo "published=true"; echo "tag=$TAG"; echo "apk=$APK"; echo "source=$SRC"; } >> "$GITHUB_OUTPUT"
fi
