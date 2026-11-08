#!/bin/bash
set -e
set -o pipefail
OUT=${OUT:-/tmp/mr_mixed}
DICTS=${DICTS:-dicts}
E=docs/tools/e2e
unset JAVA_TOOL_OPTIONS
mkdir -p "$OUT/reports"

cmake -S engine -B "$OUT/engine" -DCMAKE_BUILD_TYPE=Release > "$OUT/cmake_engine.log" 2>&1
cmake --build "$OUT/engine" >> "$OUT/cmake_engine.log" 2>&1
cmake -S native -B "$OUT/native" -DCMAKE_BUILD_TYPE=Release > "$OUT/cmake_native.log" 2>&1
cmake --build "$OUT/native" >> "$OUT/cmake_native.log" 2>&1

JAR=${1:-}
if [ -z "$JAR" ]; then
  : "${APKTOOL_JAR:?set APKTOOL_JAR or pass the app jar}"; : "${DEX2JAR:?set DEX2JAR (dex-tools-2.1 folder)}"
  java -jar "$APKTOOL_JAR" b . -o "$OUT/app.apk" > /dev/null 2>&1; rm -rf build
  rm -rf "$OUT/dex"; sh docs/tools/verify_dex.sh "$OUT/app.apk" "$DEX2JAR" "$OUT/dex" > /dev/null
  JAR=$OUT/dex/classes.jar
fi

rm -rf "$OUT/stubs" "$OUT/cls"; mkdir -p "$OUT/stubs" "$OUT/cls"
javac -nowarn -encoding UTF-8 -cp "$JAR" -d "$OUT/stubs" $(find $E/android_stubs -name '*.java')
javac -nowarn -encoding UTF-8 -cp "$JAR:$OUT/stubs" -d "$OUT/cls" $E/E2ETest.java $E/TouchEval.java $E/TouchRescore.java
CP="$OUT/cls:$OUT/stubs:$JAR"
run() { java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -Dfile.encoding=UTF-8 -Dstdout.encoding=UTF-8 \
             -Djava.library.path="$OUT/engine:$OUT/native" -cp "$CP" "$@"; }

for L in "pt-BR|pt" "en-US|en" "es|es"; do
  D=$(echo "$L" | cut -d'|' -f1); K=$(echo "$L" | cut -d'|' -f2)
  T=$E/data/everyday_$D.txt
  {
    echo "================ $D"
    echo "--- as the app is today (TouchEval, sigma 0.2 and 0.3)"
    run com.mrkeyboard.app.TouchEval "$DICTS/$D/main.dict" "$T" $K 3000 0.2
    run com.mrkeyboard.app.TouchEval "$DICTS/$D/main.dict" "$T" $K 3000 0.3
    echo "--- the same touches with the candidates re-ordered by the distance of the finger (TouchRescore)"
    run com.mrkeyboard.app.TouchRescore "$DICTS/$D/main.dict" "$T" $K
  } > "$OUT/reports/touch_$D.txt"
done

for f in "$OUT"/reports/touch_*.txt; do
  echo "##### $(basename "$f")"
  cat "$f"
done
