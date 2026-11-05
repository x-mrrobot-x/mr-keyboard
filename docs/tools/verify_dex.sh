#!/bin/sh
# Verifies the dex of an APK (or a .dex) with the dex2jar verifier and leaves the jar for the tests.
# d2j-asm-verify exits 0 even when it finds an error: the error shows up as a line "Error verify method ...".
# Usage: sh docs/tools/verify_dex.sh <apk or classes.dex> <dex-tools-2.1 folder> [output folder]
set -e
INPUT=$1; DT=$2; OUT=${3:-$(mktemp -d)}
mkdir -p "$OUT"
case "$INPUT" in
  *.dex) cp "$INPUT" "$OUT/classes.dex" ;;
  *) unzip -q -o "$INPUT" 'classes*.dex' -d "$OUT" ;;
esac
FAILED=0
for d in "$OUT"/classes*.dex; do
  jar="${d%.dex}.jar"
  sh "$DT/d2j-dex2jar.sh" -f -o "$jar" "$d" > /dev/null 2>&1
  RESULT=$(sh "$DT/d2j-asm-verify.sh" "$jar" 2>&1 || true)
  echo "$RESULT" | grep -v '^Picked up'
  if echo "$RESULT" | grep -v '^verify ' | grep -v '^Picked up' | grep -q .; then
    echo "ERROR: the verifier found a problem in $(basename "$d")"; FAILED=1
  fi
done
echo "jar for the tests: $OUT/classes.jar"
exit $FAILED
