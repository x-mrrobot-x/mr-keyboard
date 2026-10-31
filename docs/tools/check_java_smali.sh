#!/bin/sh
# Confere que o smali da camada Java (Mr*.smali gerados) é o que docs/tools/build_java.sh produz hoje dos
# fontes em docs/tools/java/src: pega Java mudado sem regenerar o smali (ou smali de classe que saiu do Java).
# Smali escrito à mão (MrTools, MrShots, ...) não entra: só as classes que têm fonte Java.
# Uso (na raiz): DX_JAR=.../dx-27.0.3.jar APKTOOL_JAR=.../apktool.jar sh docs/tools/check_java_smali.sh
set -e
: "${DX_JAR:?defina DX_JAR}"
: "${APKTOOL_JAR:?defina APKTOOL_JAR}"
ROOT=$(pwd)
T=$(mktemp -d)
mkdir -p "$T/smali/com/mrkeyboard/app" "$T/docs/tools"
cp -r docs/tools/java docs/tools/build_java.sh "$T/docs/tools/"
(cd "$T" && sh docs/tools/build_java.sh > /dev/null)
NOVO="$T/smali/com/mrkeyboard/app"
APP="$ROOT/smali/com/mrkeyboard/app"
FALHOU=0
for f in "$NOVO"/Mr*.smali; do
  n=$(basename "$f")
  if [ ! -f "$APP/$n" ]; then echo "FALTA no repo: $n"; FALHOU=1
  elif ! cmp -s "$f" "$APP/$n"; then echo "DIFERENTE: $n"; FALHOU=1; fi
done
# classes do repo que têm fonte Java mas não saem mais do build (sobra de classe interna, por exemplo)
for java in docs/tools/java/src/com/mrkeyboard/app/*.java; do
  base=$(basename "$java" .java)
  for f in "$APP/$base.smali" "$APP/$base"'$'*.smali; do
    [ -f "$f" ] || continue
    n=$(basename "$f")
    [ -f "$NOVO/$n" ] || { echo "SOBRA no repo (não sai mais do Java): $n"; FALHOU=1; }
  done
done
rm -rf "$T"
if [ $FALHOU -ne 0 ]; then
  echo "Regenere com: DX_JAR=... APKTOOL_JAR=... sh docs/tools/build_java.sh   (e faça o commit do smali)"
else
  echo "smali da camada Java em dia"
fi
exit $FALHOU
