#!/bin/sh
# Builds the source zip of a release from a commit with git archive (the same bytes every time for the same commit
# and the same git; nothing from the working folder goes in, only what is committed).
#
# Usage, at the root of the repository:
#   sh docs/tools/make_source_zip.sh <tag> <commit> <out.zip>
#   e.g.: sh docs/tools/make_source_zip.sh v1.82.0 "$GITHUB_SHA" mr-keyboard-v1.82.0-source.zip
#
# Content: what someone needs to edit the app and rebuild the APK, without the dictionaries (they come from the catalog)
# and without the rest of docs/:
#   the apktool project  AndroidManifest.xml, apktool.yml, apktool.json, res/, smali/, assets/ (if any), lib/, original/, unknown/
#   native code          native/ and engine/, with native-src.sha256, mrengine-src.sha256 and mrengine-info.txt
#   Java layer           docs/tools/java, build_java.sh and check_java_smali.sh
#   LICENSE and the two READMEs
# Everything goes inside one folder named mr-keyboard-<tag>/ (the same name as the APK, without the extension).
# A path that is not in the commit (assets/, for example) is skipped; the zip must have at least the apktool project.
set -e
TAG=$1; COMMIT=$2; OUT=$3
if [ -z "$TAG" ] || [ -z "$COMMIT" ] || [ -z "$OUT" ]; then
  echo "usage: sh docs/tools/make_source_zip.sh <tag> <commit> <out.zip>" >&2; exit 1
fi
git rev-parse --verify --quiet "$COMMIT^{commit}" > /dev/null || { echo "commit not found: $COMMIT" >&2; exit 1; }

PATHS=""
for p in AndroidManifest.xml apktool.yml apktool.json res smali assets lib original unknown \
         native engine native-src.sha256 mrengine-src.sha256 mrengine-info.txt \
         docs/tools/java docs/tools/build_java.sh docs/tools/check_java_smali.sh \
         LICENSE README.md README.pt-BR.md; do
  if git cat-file -e "$COMMIT:$p" 2> /dev/null; then PATHS="$PATHS $p"; fi
done
for need in apktool.yml smali res; do
  case " $PATHS " in *" $need "*) ;; *) echo "$need is not in $COMMIT: this is not the apktool project" >&2; exit 1 ;; esac
done

rm -f "$OUT"
# shellcheck disable=SC2086
git archive --format=zip -9 --prefix="mr-keyboard-$TAG/" -o "$OUT" "$COMMIT" -- $PATHS
echo "source zip: $OUT ($(wc -c < "$OUT") bytes, $(unzip -Z1 "$OUT" | grep -vc '/$') files)"
