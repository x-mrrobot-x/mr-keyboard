#!/bin/sh
# Assina o catálogo de dicionários (data.json -> catalog.json) com a chave do APK.
# O app só aceita catálogo assinado pela chave com que ele foi instalado.
# A chave vem do ambiente, como no mr-apk.yml:
#   KEYSTORE_B64 + KEYSTORE_PASS + KEY_ALIAS + KEY_PASS      (keystore em base64)
#   KEY_PK8_B64 + CERT_PEM_B64                               (par .pk8 + .pem em base64)
# Uso: sh docs/tools/sign_catalog.sh out/data.json out/catalog.json
set -e
DADOS=$1; SAIDA=$2
AQUI=$(cd "$(dirname "$0")" && pwd)
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
J="java -Dstdout.encoding=UTF-8 $AQUI/SignCatalog.java --data $DADOS --out $SAIDA"
if [ -n "$KEYSTORE_B64" ]; then
  printf '%s' "$KEYSTORE_B64" | tr -d ' \r\n\t' | base64 -d > "$TMP/key.jks" || {
    echo "KEYSTORE_B64 não é base64 válido (texto cortado ou com caracteres a mais)"; exit 1; }
  $J --keystore "$TMP/key.jks"
elif [ -n "$KEY_PK8_B64" ] && [ -n "$CERT_PEM_B64" ]; then
  printf '%s' "$KEY_PK8_B64" | tr -d ' \r\n\t' | base64 -d > "$TMP/key.pk8"
  printf '%s' "$CERT_PEM_B64" | tr -d ' \r\n\t' | base64 -d > "$TMP/cert.pem"
  $J --pk8 "$TMP/key.pk8" --cert "$TMP/cert.pem"
else
  echo "sem chave nos secrets: o app não aceita catálogo sem assinatura"; exit 1
fi
