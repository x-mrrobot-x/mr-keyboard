#!/bin/bash
# One check per suggestion strategy, in the three languages, with the dictionaries from dicts/ (no corpus needed).
# Runs StrategyTest (docs/suggestion-features.md lists the strategies) and the older end-to-end checks (E2ETest, E2EEn, E2EEs),
# through the native engine and through the Java fallback. Runs in CI (mr-checks.yml) and on the PC.
#
# From the project root:
#   bash docs/tools/e2e/run_strategy_tests.sh [app_jar.jar]
# Without the jar (classes.dex of the APK -> dex2jar), it builds the APK just for this: needs APKTOOL_JAR and DEX2JAR (dex-tools-2.1 folder).
# Variables: OUT (default /tmp/mr_strategy); DICTS (folder with the dictionaries, default dicts; docs/tools/make_v2_dicts.py makes a copy in
#            the dictionary format v2 to run the same checks on it). Exits with code 1 if any check fails (a case marked GAP may fail: it is a known gap).
set -e
set -o pipefail   # the Java tests exit 1 on a failure; without this the pipe to grep would hide it
OUT=${OUT:-/tmp/mr_strategy}
E=docs/tools/e2e
unset JAVA_TOOL_OPTIONS
mkdir -p "$OUT"

# ---- PC libs: dictionary reader (native/) and engine (engine/)
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
javac -nowarn -encoding UTF-8 -cp "$JAR:$OUT/stubs" -d "$OUT/cls" $E/E2ETest.java $E/E2EEn.java $E/E2EEs.java $E/SubtitleEval.java $E/ImportEval.java $E/StrategyTest.java
CP="$OUT/cls:$OUT/stubs:$JAR"
run() { java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -Dfile.encoding=UTF-8 -Dstdout.encoding=UTF-8 \
             -Djava.library.path="$OUT/engine:$OUT/native" "$@"; }

DICTS=${DICTS:-dicts}   # a copy in the dictionary format v2: docs/tools/make_v2_dicts.py
FAILED=0
for MODE in native java; do
  OPT=""; [ "$MODE" = java ] && OPT="-Dmr.native=off"
  for L in pt-BR en-US es; do
    echo "================ $L ($MODE)"
    case $L in pt-BR) OLD=E2ETest;; en-US) OLD=E2EEn;; es) OLD=E2EEs;; esac
    run $OPT -cp "$CP" com.mrkeyboard.app.$OLD $DICTS/$L/main.dict - 1 $DICTS/$L/trigrams.bin | grep -E "FAIL|ALL OK|FAILURE" || FAILED=1
    run $OPT -cp "$CP" com.mrkeyboard.app.StrategyTest $L "$DICTS" | grep -v "^Picked" || FAILED=1
  done
done
exit $FAILED
