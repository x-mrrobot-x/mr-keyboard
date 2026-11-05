#!/bin/sh
# Checks that the smali of the Java layer (generated Mr*.smali) is what docs/tools/build_java.sh produces today from the
# sources in docs/tools/java/src: it catches Java changed without regenerating the smali (or smali of a class that left Java).
# Hand-written smali (MrTools, MrShots, ...) is not covered: only the classes that have a Java source.
# Usage (at the root): DX_JAR=.../dx-27.0.3.jar APKTOOL_JAR=.../apktool.jar sh docs/tools/check_java_smali.sh
set -e
: "${DX_JAR:?set DX_JAR}"
: "${APKTOOL_JAR:?set APKTOOL_JAR}"
ROOT=$(pwd)
T=$(mktemp -d)
mkdir -p "$T/smali/com/mrkeyboard/app" "$T/docs/tools"
cp -r docs/tools/java docs/tools/build_java.sh "$T/docs/tools/"
(cd "$T" && sh docs/tools/build_java.sh > /dev/null)
GENERATED="$T/smali/com/mrkeyboard/app"
APP="$ROOT/smali/com/mrkeyboard/app"
FAILED=0
for f in "$GENERATED"/Mr*.smali; do
  n=$(basename "$f")
  if [ ! -f "$APP/$n" ]; then echo "MISSING in repo: $n"; FAILED=1
  elif ! cmp -s "$f" "$APP/$n"; then echo "DIFFERENT: $n"; FAILED=1; fi
done
# repo classes that have a Java source but no longer come out of the build (leftover inner class, for example)
for java in docs/tools/java/src/com/mrkeyboard/app/*.java; do
  base=$(basename "$java" .java)
  for f in "$APP/$base.smali" "$APP/$base"'$'*.smali; do
    [ -f "$f" ] || continue
    n=$(basename "$f")
    [ -f "$GENERATED/$n" ] || { echo "LEFTOVER in repo (no longer comes out of Java): $n"; FAILED=1; }
  done
done
rm -rf "$T"
if [ $FAILED -ne 0 ]; then
  echo "Regenerate with: DX_JAR=... APKTOOL_JAR=... sh docs/tools/build_java.sh   (and commit the smali)"
else
  echo "Java-layer smali up to date"
fi
exit $FAILED
