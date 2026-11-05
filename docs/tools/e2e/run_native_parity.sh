#!/bin/bash
# Parity of the native engine (v1.77) with the dictionaries in dicts/: the correction search, the final suggestion list and the
# trigrams through Java and through libmrengine.so must give the SAME result in the three languages. Runs in CI (mr-checks.yml) and on the PC.
# The queries come from the dictionary itself (engine/tools/gen_parity_queries.py): no corpus needed.
#
# From the project root:
#   bash docs/tools/e2e/run_native_parity.sh [app_jar.jar]
# Without the jar (classes.dex of the APK -> dex2jar), it builds the APK just for this: needs APKTOOL_JAR and DEX2JAR (dex-tools-2.1 folder).
# Variables: OUT (default /tmp/mr_parity), WORDS (words per language, default 2500), ROUNDS (default 1),
#            SUGG (how many go through the full Suggest, default 2000).
# Exits with code 1 if there is any difference.
set -e
ROOT=$(pwd)
OUT=${OUT:-/tmp/mr_parity}
WORDS=${WORDS:-2500}
ROUNDS=${ROUNDS:-1}
SUGG=${SUGG:-2000}
E=docs/tools/e2e
unset JAVA_TOOL_OPTIONS
mkdir -p "$OUT"

# ---- PC libs: engine (engine/) and dictionary reader (native/)
cmake -S engine -B "$OUT/engine" -DCMAKE_BUILD_TYPE=Release > "$OUT/cmake_engine.log" 2>&1
cmake --build "$OUT/engine" >> "$OUT/cmake_engine.log" 2>&1
cmake -S native -B "$OUT/native" -DCMAKE_BUILD_TYPE=Release > "$OUT/cmake_native.log" 2>&1
cmake --build "$OUT/native" >> "$OUT/cmake_native.log" 2>&1

# ---- app jar
JAR=${1:-}
if [ -z "$JAR" ]; then
  : "${APKTOOL_JAR:?set APKTOOL_JAR or pass the app jar}"; : "${DEX2JAR:?set DEX2JAR (dex-tools-2.1 folder)}"
  java -jar "$APKTOOL_JAR" b . -o "$OUT/app.apk" > /dev/null 2>&1; rm -rf build
  rm -rf "$OUT/dex"; sh docs/tools/verify_dex.sh "$OUT/app.apk" "$DEX2JAR" "$OUT/dex" > /dev/null
  JAR=$OUT/dex/classes.jar
fi

# ---- test classes
rm -rf "$OUT/stubs" "$OUT/cls"; mkdir -p "$OUT/stubs" "$OUT/cls"
javac -nowarn -encoding UTF-8 -cp "$JAR" -d "$OUT/stubs" $(find $E/android_stubs -name '*.java')
javac -nowarn -encoding UTF-8 -cp "$JAR:$OUT/stubs" -d "$OUT/cls" $E/E2ETest.java $E/NativeParity.java
CP="$OUT/cls:$OUT/stubs:$JAR"

FAILED=0
for L in "pt-BR|qwertyuiop,asdfghjklç,zxcvbnm" "en-US|qwertyuiop,asdfghjkl,zxcvbnm" "es|qwertyuiop,asdfghjklñ,zxcvbnm"; do
  D=${L%%|*}; ROWS=${L#*|}
  echo "================ $D"
  python3 -I engine/tools/gen_parity_queries.py --lang "$D" --out "$OUT" --words "$WORDS" --root .
  java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -Dfile.encoding=UTF-8 -Dstdout.encoding=UTF-8 \
       -Djava.library.path="$OUT/engine:$OUT/native" -Drows="$ROWS" -Drounds="$ROUNDS" -Dsuggmax="$SUGG" -Dpairs="$OUT/pairs_$D.txt" \
       -cp "$CP" com.mrkeyboard.app.NativeParity "dicts/$D/main.dict" "$OUT/typos_$D.tsv" "dicts/$D/trigrams.bin" || FAILED=1
done
exit $FAILED
