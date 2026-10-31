#!/bin/sh
# Verifica o dex de um APK (ou um .dex) com o verificador do dex2jar e deixa o jar para os testes.
# O d2j-asm-verify sai com 0 mesmo quando acha erro: o erro aparece como linha "Error verify method ...".
# Uso: sh docs/tools/verify_dex.sh <apk ou classes.dex> <pasta do dex-tools-2.1> [pasta de saída]
set -e
ENTRADA=$1; DT=$2; OUT=${3:-$(mktemp -d)}
mkdir -p "$OUT"
case "$ENTRADA" in
  *.dex) cp "$ENTRADA" "$OUT/classes.dex" ;;
  *) unzip -q -o "$ENTRADA" 'classes*.dex' -d "$OUT" ;;
esac
FALHOU=0
for d in "$OUT"/classes*.dex; do
  jar="${d%.dex}.jar"
  sh "$DT/d2j-dex2jar.sh" -f -o "$jar" "$d" > /dev/null 2>&1
  SAIDA=$(sh "$DT/d2j-asm-verify.sh" "$jar" 2>&1 || true)
  echo "$SAIDA" | grep -v '^Picked up'
  if echo "$SAIDA" | grep -v '^verify ' | grep -v '^Picked up' | grep -q .; then
    echo "ERRO: o verificador achou problema em $(basename "$d")"; FALHOU=1
  fi
done
echo "jar para os testes: $OUT/classes.jar"
exit $FALHOU
