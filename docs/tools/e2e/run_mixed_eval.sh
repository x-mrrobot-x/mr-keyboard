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
javac -nowarn -encoding UTF-8 -cp "$JAR:$OUT/stubs" -d "$OUT/cls" $E/E2ETest.java $E/SubtitleEval.java $E/CorrEval.java $E/PrefixEval.java $E/SpeedEval.java $E/MixEval.java
CP="$OUT/cls:$OUT/stubs:$JAR"
run() { java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -Dfile.encoding=UTF-8 -Dstdout.encoding=UTF-8 \
             -Djava.library.path="$OUT/engine:$OUT/native" -cp "$CP" "$@"; }

{
  date -u
  java -version 2>&1 | head -1
  echo "cpus: $(nproc)"
  grep -m1 "model name" /proc/cpuinfo || true
  echo "commit: ${GITHUB_SHA:-unknown}"
  ls -l "$DICTS"/*/main.dict "$DICTS"/*/trigrams.bin
  cat mrengine-info.txt
} > "$OUT/reports/run_info.txt"

for L in "pt-BR|pt|qwertyuiop,asdfghjklç,zxcvbnm" "en-US|en|qwertyuiop,asdfghjkl,zxcvbnm" "es|es|qwertyuiop,asdfghjklñ,zxcvbnm"; do
  D=$(echo "$L" | cut -d'|' -f1); K=$(echo "$L" | cut -d'|' -f2); ROWS=$(echo "$L" | cut -d'|' -f3)
  T=$E/data/everyday_$D.txt
  python3 -I $E/gen_typos_all.py $K "$T" "$T" "$OUT/typos_$K.tsv" > /dev/null
  {
    echo "================ $D"
    echo "--- error correction (CorrEval)"
    run -Drows=$ROWS com.mrkeyboard.app.CorrEval "$DICTS/$D/main.dict" "$OUT/typos_$K.tsv" | grep -v "^misses"
    echo "--- normal typing (PrefixEval)"
    run -Drows=$ROWS -Devery=1 com.mrkeyboard.app.PrefixEval "$DICTS/$D/main.dict" "$T"
    echo "--- speed per keystroke (SpeedEval)"
    run -Dsentences=1500 -Drounds=5 com.mrkeyboard.app.SpeedEval $D "$DICTS" "$T"
  } > "$OUT/reports/single_$D.txt"
done

run com.mrkeyboard.app.MixEval pt-BR en-US "$DICTS" $E/data/mixed_pt-BR_en-US.txt $E/data/everyday_pt-BR.txt $E/data/everyday_en-US.txt > "$OUT/reports/mixed_pt-BR_en-US.txt"
run com.mrkeyboard.app.MixEval es en-US "$DICTS" $E/data/mixed_es_en-US.txt $E/data/everyday_es.txt $E/data/everyday_en-US.txt > "$OUT/reports/mixed_es_en-US.txt"

for f in "$OUT"/reports/*.txt; do
  echo "##### $(basename "$f")"
  cat "$f"
done
