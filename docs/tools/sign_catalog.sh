#!/bin/sh
# Signs a JSON file of the release with the APK key: the dictionary catalog (data.json -> catalog.json) or the update
# notice (update-data.json -> update.json). The app only accepts a file signed by the key it was installed with.
# The domain ("catalog" or "update") goes in the signed prefix, so one kind of file is never accepted as the other.
# The key comes from the environment, as in mr-apk.yml:
#   KEYSTORE_B64 + KEYSTORE_PASS + KEY_ALIAS + KEY_PASS      (keystore in base64)
#   KEY_PK8_B64 + CERT_PEM_B64                               (.pk8 + .pem pair in base64)
# Usage: sh docs/tools/sign_catalog.sh out/data.json out/catalog.json [catalog]
#        sh docs/tools/sign_catalog.sh out/update-data.json out/update.json update
set -e
DATA=$1; OUTFILE=$2; DOMAIN=${3:-catalog}
HERE=$(cd "$(dirname "$0")" && pwd)
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
J="java -Dstdout.encoding=UTF-8 $HERE/SignCatalog.java --data $DATA --out $OUTFILE --domain $DOMAIN"
if [ -n "$KEYSTORE_B64" ]; then
  printf '%s' "$KEYSTORE_B64" | tr -d ' \r\n\t' | base64 -d > "$TMP/key.jks" || {
    echo "KEYSTORE_B64 is not valid base64 (text cut short or with extra characters)"; exit 1; }
  $J --keystore "$TMP/key.jks"
elif [ -n "$KEY_PK8_B64" ] && [ -n "$CERT_PEM_B64" ]; then
  printf '%s' "$KEY_PK8_B64" | tr -d ' \r\n\t' | base64 -d > "$TMP/key.pk8"
  printf '%s' "$CERT_PEM_B64" | tr -d ' \r\n\t' | base64 -d > "$TMP/cert.pem"
  $J --pk8 "$TMP/key.pk8" --cert "$TMP/cert.pem"
else
  echo "no key in the secrets: the app does not accept an unsigned catalog or update notice"; exit 1
fi
