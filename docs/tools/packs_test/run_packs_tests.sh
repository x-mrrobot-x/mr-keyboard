#!/bin/bash
# Pack flow on the PC (PacksTest, 60+ checks), the three installed languages (ThreeLangTest) and the gesture recognition pack
# (ModelPackTest, 1.96.0), with the APK's real classes, the native lib compiled for the PC and a fake Android. Runs in CI
# (mr-checks.yml, job "assemble") and on your computer.
# README.md in this folder says what each case covers.
#
# From the project root:
#   bash docs/tools/packs_test/run_packs_tests.sh <app_jar.jar>
# The jar is the classes.dex of the assembled APK (dex2jar), like in run_strategy_tests.sh. Needs: JDK 11+ (keytool), openssl, cmake.
# Variables: OUT (default /tmp/mr_packs; give it a folder of its own, not the one of run_strategy_tests.sh: both write cls/ and stubs/).
# Exits with code 1 if any check fails.
set -e
set -o pipefail   # the Java tests exit 1 on a failure; without this the pipe to grep would hide it
JAR=${1:?app jar (classes.dex of the APK converted with dex2jar)}
JAR=$(cd "$(dirname "$JAR")" && pwd)/$(basename "$JAR")
OUT=${OUT:-/tmp/mr_packs}
ROOT=$(pwd)
P=docs/tools/packs_test
unset JAVA_TOOL_OPTIONS
# only what this script makes: OUT may be a folder that also holds other things (the app jar, say)
rm -rf "$OUT/fa" "$OUT/fx" "$OUT/three" "$OUT/cls" "$OUT/stubs" "$OUT/stubsrc"
mkdir -p "$OUT/fa" "$OUT/fx" "$OUT/three" "$OUT/cls" "$OUT/stubs"

# ---- PC libs: dictionary reader (native/) and engine (engine/)
cmake -S engine -B "$OUT/engine" -DCMAKE_BUILD_TYPE=Release > "$OUT/cmake_engine.log" 2>&1
cmake --build "$OUT/engine" >> "$OUT/cmake_engine.log" 2>&1
cmake -S native -B "$OUT/native" -DCMAKE_BUILD_TYPE=Release > "$OUT/cmake_native.log" 2>&1
cmake --build "$OUT/native" >> "$OUT/cmake_native.log" 2>&1

# ---- test key (RSA, the one the app "was installed with") and another one (EC) for the "other key" case
keytool -genkeypair -keyalg RSA -keysize 2048 -alias mrkeyboard -keystore "$OUT/fa/test.p12" -storetype PKCS12 \
        -storepass pass123 -keypass pass123 -dname CN=Test -validity 30 > /dev/null 2>&1
keytool -exportcert -rfc -alias mrkeyboard -keystore "$OUT/fa/test.p12" -storepass pass123 -file "$OUT/fa/cert.pem" > /dev/null 2>&1
openssl ecparam -name prime256v1 -genkey -noout -out "$OUT/fa/ec.key" 2> /dev/null
openssl pkcs8 -topk8 -nocrypt -in "$OUT/fa/ec.key" -outform DER -out "$OUT/fa/ec.pk8"
openssl req -new -x509 -key "$OUT/fa/ec.key" -days 30 -subj /CN=EC -out "$OUT/fa/eccert.pem" 2> /dev/null

# ---- fixtures: pt-BR packs in every state PacksTest needs, and the catalog of the three real packs
python3 -I $P/make_fixtures.py "$ROOT" "$OUT/fx" > /dev/null
python3 -I $P/make_model_fixtures.py "$ROOT" "$OUT/fx" > /dev/null    # the catalogs with the gesture recognition (m_*), for ModelPackTest
python3 -I $P/sign_fixtures.py "$ROOT" "$OUT/fx" "$OUT/fa" > /dev/null
python3 -I docs/tools/make_catalog.py --dicts dicts --out "$OUT/three" --tag v1.73.0 > /dev/null
KEYSTORE_PASS=pass123 KEY_ALIAS=mrkeyboard KEY_PASS=pass123 \
  java -Dstdout.encoding=UTF-8 docs/tools/SignCatalog.java --data "$OUT/three/data.json" --out "$OUT/three/catalog.json" --keystore "$OUT/fa/test.p12" > /dev/null

# ---- test classes. Stubs of the fake Android, from the lowest to the highest priority: the ones of the e2e tests, the ones of the Java
# layer (docs/tools/java/stubs/android, which are richer), and the ones of this folder (they replace the files with the same name).
# apktool writes the number with or without quotes, depending on the version that decoded the APK: both are read
APPCODE=$(sed -n "s/^ *versionCode: *['\"]\{0,1\}\([0-9][0-9]*\).*/\1/p" apktool.yml | head -n 1)
[ -n "$APPCODE" ] || { echo "no versionCode in apktool.yml"; exit 1; }
mkdir -p "$OUT/stubsrc"
cp -r docs/tools/e2e/android_stubs/. "$OUT/stubsrc/"
cp -r docs/tools/java/stubs/android "$OUT/stubsrc/"
cp docs/tools/e2e/android_stubs/android/view/inputmethod/InputConnection.java "$OUT/stubsrc/android/view/inputmethod/"   # the tests implement this small one
cp -r $P/stubs/. "$OUT/stubsrc/"
javac -nowarn -encoding UTF-8 -cp "$JAR" -d "$OUT/stubs" $(find "$OUT/stubsrc" -name '*.java') $P/UiLocale.java
javac -nowarn -encoding UTF-8 -cp "$OUT/stubs:$JAR" -d "$OUT/cls" docs/tools/e2e/E2ETest.java $P/PacksTest.java $P/ThreeLangTest.java $P/ModelPackTest.java
CP="$OUT/cls:$OUT/stubs:$JAR"
run() { java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -Dfile.encoding=UTF-8 -Dstdout.encoding=UTF-8 \
             -Djava.library.path="$OUT/engine:$OUT/native" -Dmr.fx="$OUT/fx" -Dmr.fa="$OUT/fa" -Dmr.three="$OUT/three" \
             -Dmr.dicts=dicts -Dmr.appcode="$APPCODE" -cp "$CP" "$@"; }

FAILED=0
echo "================ PacksTest"
run com.mrkeyboard.app.PacksTest | grep -E "FAIL|ALL OK|FAILURE|Exception" || FAILED=1
echo "================ ThreeLangTest"
run com.mrkeyboard.app.ThreeLangTest | grep -E "FAIL|ALL OK|FAILURE|Exception" || FAILED=1
echo "================ ModelPackTest"
run com.mrkeyboard.app.ModelPackTest | grep -E "FAIL|ALL OK|FAILURE|Exception" || FAILED=1
exit $FAILED
