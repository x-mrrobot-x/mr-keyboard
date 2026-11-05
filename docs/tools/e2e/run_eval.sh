#!/bin/bash
# Suggestion-engine measurements on the PC (v1.75): error correction (CorrEval), normal typing (PrefixEval),
# autocorrect risk on a correct word outside the dictionary (OovEval) and recent words (RecentEval),
# in the three languages. Run from the project root. See README.md in this folder.
#
#   DATA=/texts/folder APKTOOL_JAR=/path/to/apktool.jar DEX2JAR=/folder/dex-tools-2.1 \
#       bash docs/tools/e2e/run_eval.sh [app_jar.jar]
#
# DATA has the TEST texts (sentences that did not go into the dictionary training):
#   leipzig1m/br/test.txt  tatoeba/br/test_sem_nomes.txt  en/split/news_test.txt  en/split/chat_test.txt  es/split/chat_test.txt
# (or point to PT_NEWS, PT_CHAT, EN_NEWS, EN_CHAT, ES_CHAT). Without the app jar, it builds the APK just for this (apktool b +
# verify_dex.sh) and deletes the build/ folder apktool leaves behind. Results in $OUT (default /tmp/mr_eval).
set -e
ROOT=$(pwd)
E=docs/tools/e2e
OUT=${OUT:-/tmp/mr_eval}
DATA=${DATA:?set DATA (folder with the test texts)}
PT_NEWS=${PT_NEWS:-$DATA/leipzig1m/br/test.txt}; PT_CHAT=${PT_CHAT:-$DATA/tatoeba/br/test_sem_nomes.txt}
EN_NEWS=${EN_NEWS:-$DATA/en/split/news_test.txt}; EN_CHAT=${EN_CHAT:-$DATA/en/split/chat_test.txt}
ES_CHAT=${ES_CHAT:-$DATA/es/split/chat_test.txt}
unset JAVA_TOOL_OPTIONS
mkdir -p "$OUT"

# ---- native PC libs: libjni_pckeyboard.so (native/, the same dictionary.cpp) and libmrengine.so (engine/, native engine).
# With both on java.library.path the measurements use the native engine (result identical to Java's); JAVA_OPTS=-Dmr.native=off forces Java.
if [ ! -f "$OUT/host/libjni_pckeyboard.so" ]; then
  cmake -S native -B "$OUT/host" -DCMAKE_BUILD_TYPE=Release > "$OUT/cmake.log" 2>&1
  cmake --build "$OUT/host" >> "$OUT/cmake.log" 2>&1
fi
if [ ! -f "$OUT/host-engine/libmrengine.so" ]; then
  cmake -S engine -B "$OUT/host-engine" -DCMAKE_BUILD_TYPE=Release >> "$OUT/cmake.log" 2>&1
  cmake --build "$OUT/host-engine" >> "$OUT/cmake.log" 2>&1
fi
# ---- app jar (classes.dex -> dex2jar)
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
javac -nowarn -encoding UTF-8 -cp "$JAR:$OUT/stubs" -d "$OUT/cls" $E/E2ETest.java $E/CorrEval.java $E/PrefixEval.java $E/OovEval.java $E/RecentEval.java
CP="$OUT/cls:$OUT/stubs:$JAR"
run() { java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -Djava.library.path="$OUT/host:$OUT/host-engine" $JAVA_OPTS -cp "$CP" "$@"; }

# ---- synthetic errors and sessions (fixed seed)
python3 -I $E/gen_typos_all.py pt "$PT_NEWS" "$PT_CHAT" "$OUT/typos_pt.tsv" > /dev/null
python3 -I $E/gen_typos_all.py en "$EN_NEWS" "$EN_CHAT" "$OUT/typos_en.tsv" > /dev/null
python3 -I $E/gen_typos_all.py es "$ES_CHAT" "$ES_CHAT" "$OUT/typos_es.tsv" > /dev/null
python3 -I $E/gen_sessions.py "$PT_NEWS" "$PT_CHAT" "$OUT/sess_pt_topic.txt" "$OUT/sess_pt_random.txt" 400 > /dev/null
python3 -I $E/gen_sessions.py "$EN_NEWS" "$EN_CHAT" "$OUT/sess_en_topic.txt" "$OUT/sess_en_random.txt" 400 > /dev/null
python3 -I $E/gen_sessions.py "$ES_CHAT" "$ES_CHAT" "$OUT/sess_es_topic.txt" "$OUT/sess_es_random.txt" 400 > /dev/null

for L in "pt-BR|pt|qwertyuiop,asdfghjklç,zxcvbnm|$PT_NEWS $PT_CHAT" "en-US|en|qwertyuiop,asdfghjkl,zxcvbnm|$EN_NEWS $EN_CHAT" "es|es|qwertyuiop,asdfghjklñ,zxcvbnm|$ES_CHAT"; do
  D=$(echo "$L" | cut -d'|' -f1); K=$(echo "$L" | cut -d'|' -f2); ROWS=$(echo "$L" | cut -d'|' -f3); F=$(echo "$L" | cut -d'|' -f4)
  echo "================ $D"
  echo "--- synthetic error correction (CorrEval)"
  run -Drows=$ROWS com.mrkeyboard.app.CorrEval dicts/$D/main.dict "$OUT/typos_$K.tsv" | grep -v "^misses"
  echo "--- normal typing (PrefixEval): the right word among the first 3 after k letters"
  run -Drows=$ROWS com.mrkeyboard.app.PrefixEval dicts/$D/main.dict $F
  echo "--- correct word outside the dictionary (OovEval): autocorrect would swap"
  run -Drows=$ROWS com.mrkeyboard.app.OovEval dicts/$D/main.dict $F
  for KIND in topic random; do
    for R in 0 1; do
      echo "--- recent words (RecentEval), $KIND sessions, recent=$R"
      run -Drows=$ROWS -Drecent=$R com.mrkeyboard.app.RecentEval dicts/$D/main.dict dicts/$D/trigrams.bin "$OUT/sess_${K}_$KIND.txt" | grep -v "words outside\|dictionary words"
    done
  done
done
