#!/bin/sh
# Makes the files UpdateTest reads from the real tools: a test key, an update.json made by make_update.py and signed by
# SignCatalog.java for the update domain, and the same data signed for the catalog domain.
# Usage, at the project root: sh docs/tools/update_test/make_fixtures.sh <empty-folder>
set -e
OUT=$1
[ -n "$OUT" ] || { echo "usage: sh docs/tools/update_test/make_fixtures.sh <folder>" >&2; exit 1; }
mkdir -p "$OUT"
keytool -genkeypair -alias k -keyalg RSA -keysize 2048 -validity 3650 -keystore "$OUT/t.p12" -storetype PKCS12 \
  -storepass pass123 -keypass pass123 -dname CN=Test > /dev/null 2>&1
keytool -exportcert -rfc -alias k -keystore "$OUT/t.p12" -storepass pass123 -file "$OUT/cert.pem" > /dev/null 2>&1
printf 'abc' > "$OUT/mr-keyboard-v1.82.0.apk"
printf '**Português**\n- Novidade **boa**.\n\n**English**\n- Good `news`.\n' > "$OUT/notes.md"
printf "versionInfo:\n  versionCode: '1082000'\n  versionName: v1.82.0\n" > "$OUT/apktool.yml"
python3 -I docs/tools/make_update.py --apk "$OUT/mr-keyboard-v1.82.0.apk" --tag v1.82.0 --notes "$OUT/notes.md" \
  --apktool "$OUT/apktool.yml" --out "$OUT/data.json" > /dev/null
sha256sum "$OUT/mr-keyboard-v1.82.0.apk" | cut -d' ' -f1 > "$OUT/apk.sha256"
export KEYSTORE_PASS=pass123 KEY_ALIAS=k KEY_PASS=pass123
java docs/tools/SignCatalog.java --data "$OUT/data.json" --out "$OUT/update.json" --keystore "$OUT/t.p12" --domain update > /dev/null
java docs/tools/SignCatalog.java --data "$OUT/data.json" --out "$OUT/as_catalog.json" --keystore "$OUT/t.p12" --domain catalog > /dev/null
