#!/bin/bash
# Publishes the single release of a launch (used by the "Mr Keyboard - APK" workflow): the signed APK, the
# dictionary catalog (signed with the same key) and ONE zip per language, all in one release.
# The tag is the versionName from apktool.yml (v1.72.0) and the notes come from docs/release-notes/<tag>.md
# (e.g. docs/release-notes/v1.72.0.md): a short file, Portuguese and English, that is the release text itself,
# followed by the list of included dictionaries and the checksums.
# The APK is named mr-keyboard-<tag>.apk (e.g. mr-keyboard-v1.72.0.apk), so the version shows in the asset
# list; the app reads the catalog from .../releases/latest/download/catalog.json.
#
# Dictionaries: starts from the catalog of the latest release (if there is one), reuses the zips of the
# packs that did not change and only builds the ones whose version went up in dicts/ (make_catalog.py --tag).
# The release is created as a draft, the assets are checked and only then it is published: a half-made
# release never becomes "latest".
#
# Variables:
#   MODE   manual (run by hand with "publish") or automatic (push to main)
#   LIB_OK false when lib/ does not match the current native/
#   GH_TOKEN, GITHUB_SHA, GITHUB_REPOSITORY, ANDROID_HOME (from Actions)
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
# a single APK, with the version in the name (the asset list shows which version it is)
cp mr-keyboard-signed.apk "$APK"
CERT=$("$BT/apksigner" verify --print-certs "$APK" | sed -n 's/.*certificate SHA-256 digest: //p' | head -1)
if [ -z "$CERT" ]; then
  stop "Could not read the APK certificate."
fi

# ---- dictionaries: start from the catalog of the latest release (if it has one)
mkdir -p prev out
PREV_TAG=$(gh api "repos/$GITHUB_REPOSITORY/releases/latest" -q .tag_name 2> /dev/null || true)
PREV_ARGS=""
if [ -n "$PREV_TAG" ] && gh release view "$PREV_TAG" --json assets -q '.assets[].name' 2> /dev/null | grep -qx catalog.json; then
  mkdir -p prev/zips
  gh release download "$PREV_TAG" -p catalog.json -D prev
  gh release download "$PREV_TAG" -p '*.zip' -D prev/zips
  PREV_SERIAL=$(python3 -c "import json,sys; print(json.loads(json.load(open(sys.argv[1]))['data'])['serial'])" prev/catalog.json)
  PREV_ARGS="--prev prev/catalog.json --reuse prev/zips"
  echo "dictionaries: starting from the catalog of $PREV_TAG (serial $PREV_SERIAL)"
else
  echo "::warning::No dictionary catalog published before: the serial starts at 1. Apps that already stored a higher serial will refuse this catalog; only go on if this really is the first one."
fi
python3 -I docs/tools/make_catalog.py --dicts dicts --out out --repo "$GITHUB_REPOSITORY" --tag "$TAG" $PREV_ARGS
sh docs/tools/sign_catalog.sh out/data.json out/catalog.json
EXPECTED=$(python3 docs/tools/release_assets.py out/data.json "$APK")
DICTIONARIES=$(python3 -c "import json,sys; print(', '.join('%s v%d' % (p['id'], p['version']) for p in json.load(open(sys.argv[1]))['packs']))" out/data.json)

# ---- release text: the whole notes file (short, for people downloading)
SUMMARY=""
if [ -f "$NOTES" ]; then
  SUMMARY=$(sed '/./,$!d' "$NOTES")
fi
if [ -z "$SUMMARY" ]; then
  echo "::warning::$NOTES does not exist or is empty; the release goes out with the title only."
  SUMMARY="Mr Keyboard $TAG"
fi
{
  echo "Download: **$APK** · [installation / instalação](https://github.com/$GITHUB_REPOSITORY#installation)"
  echo
  echo "$SUMMARY"
  echo
  echo "Dicionários incluídos / Included dictionaries: $DICTIONARIES."
  echo "Você só precisa do \`$APK\`: o app baixa os dicionários sozinho. / You only need \`$APK\`: the app downloads the dictionaries by itself."
  echo
  echo "- APK SHA-256: \`$(sha256sum "$APK" | cut -d' ' -f1)\`"
  echo "- Certificate SHA-256: \`$CERT\`"
} > notes.md

# ---- draft with everything attached, check the assets and only then publish
FILES="$APK out/catalog.json"
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
