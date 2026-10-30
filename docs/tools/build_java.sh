#!/bin/sh
# Gera o smali da camada Java do Mr Keyboard (MrText, MrFix, MrFuzzy, MrPredict) a partir de
# docs/tools/java/src e copia para smali/com/mrkeyboard/app/.
#
# Uso (na raiz do projeto apktool):
#   DX_JAR=/caminho/dx-27.0.3.jar APKTOOL_JAR=/caminho/apktool_2.11.1.jar sh docs/tools/build_java.sh
#
# Precisa de um JDK (javac com --release 8), do dx (vem no dex2jar 2.1, lib/dx-27.0.3.jar) e do
# apktool. Os stubs em java/stubs só servem para compilar (assinaturas das classes do APK); não
# entram no dex. Sem lambdas nem APIs novas: o código precisa rodar no Android 8 (minSdk 26).
set -e
ROOT=$(pwd)
SRC="$ROOT/docs/tools/java"
OUT=$(mktemp -d)
: "${DX_JAR:?defina DX_JAR}"
: "${APKTOOL_JAR:?defina APKTOOL_JAR}"

mkdir -p "$OUT/stubs" "$OUT/classes"
javac -nowarn --release 8 -d "$OUT/stubs" $(find "$SRC/stubs" -name '*.java')
javac -Xlint:-options --release 8 -g:source,lines -cp "$OUT/stubs" -d "$OUT/classes" \
    $(find "$SRC/src" -name '*.java')
java -cp "$DX_JAR" com.android.dx.command.Main --dex --min-sdk-version=26 \
    --output="$OUT/classes.dex" "$OUT/classes"
(cd "$OUT" && zip -q mr.apk classes.dex)
java -jar "$APKTOOL_JAR" d -r -f "$OUT/mr.apk" -o "$OUT/dec" >/dev/null
cp "$OUT"/dec/smali/com/mrkeyboard/app/Mr*.smali "$ROOT/smali/com/mrkeyboard/app/"
ls "$OUT"/dec/smali/com/mrkeyboard/app/
rm -rf "$OUT"
