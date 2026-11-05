#!/bin/bash
# Medições do motor de sugestões no PC (v1.75): correção de erros (CorrEval), digitação normal (PrefixEval),
# risco de autocorreção em palavra certa fora do dicionário (OovEval) e palavras recentes (RecentEval),
# nos três idiomas. Roda na raiz do projeto. Ver README.md desta pasta.
#
#   DATA=/pasta/dos/textos APKTOOL_JAR=/caminho/apktool.jar DEX2JAR=/pasta/dex-tools-2.1 \
#       bash docs/tools/e2e/run_eval.sh [jar_do_app.jar]
#
# DATA tem os textos de TESTE (frases que não entraram no treino do dicionário):
#   leipzig1m/br/test.txt  tatoeba/br/test_sem_nomes.txt  en/split/news_test.txt  en/split/chat_test.txt  es/split/chat_test.txt
# (ou aponte PT_NEWS, PT_CHAT, EN_NEWS, EN_CHAT, ES_CHAT). Sem o jar do app, monta o APK só para isso (apktool b +
# verify_dex.sh) e apaga a pasta build/ que o apktool deixa. Resultados em $OUT (padrão /tmp/mr_eval).
set -e
ROOT=$(pwd)
E=docs/tools/e2e
OUT=${OUT:-/tmp/mr_eval}
DATA=${DATA:?defina DATA (pasta com os textos de teste)}
PT_NEWS=${PT_NEWS:-$DATA/leipzig1m/br/test.txt}; PT_CHAT=${PT_CHAT:-$DATA/tatoeba/br/test_sem_nomes.txt}
EN_NEWS=${EN_NEWS:-$DATA/en/split/news_test.txt}; EN_CHAT=${EN_CHAT:-$DATA/en/split/chat_test.txt}
ES_CHAT=${ES_CHAT:-$DATA/es/split/chat_test.txt}
unset JAVA_TOOL_OPTIONS
mkdir -p "$OUT"

# ---- libs nativas de PC: libjni_pckeyboard.so (native/, o mesmo dictionary.cpp) e libmrengine.so (engine/, motor nativo).
# Com as duas no java.library.path as medições usam o motor nativo (resultado idêntico ao do Java); JAVA_OPTS=-Dmr.native=off força o Java.
if [ ! -f "$OUT/host/libjni_pckeyboard.so" ]; then
  cmake -S native -B "$OUT/host" -DCMAKE_BUILD_TYPE=Release > "$OUT/cmake.log" 2>&1
  cmake --build "$OUT/host" >> "$OUT/cmake.log" 2>&1
fi
if [ ! -f "$OUT/host-engine/libmrengine.so" ]; then
  cmake -S engine -B "$OUT/host-engine" -DCMAKE_BUILD_TYPE=Release >> "$OUT/cmake.log" 2>&1
  cmake --build "$OUT/host-engine" >> "$OUT/cmake.log" 2>&1
fi
# ---- jar do app (classes.dex -> dex2jar)
JAR=${1:-}
if [ -z "$JAR" ]; then
  : "${APKTOOL_JAR:?defina APKTOOL_JAR ou passe o jar do app}"; : "${DEX2JAR:?defina DEX2JAR (pasta dex-tools-2.1)}"
  java -jar "$APKTOOL_JAR" b . -o "$OUT/app.apk" > /dev/null 2>&1; rm -rf build
  rm -rf "$OUT/dex"; sh docs/tools/verify_dex.sh "$OUT/app.apk" "$DEX2JAR" "$OUT/dex" > /dev/null
  JAR=$OUT/dex/classes.jar
fi
# ---- classes de teste
rm -rf "$OUT/stubs" "$OUT/cls"; mkdir -p "$OUT/stubs" "$OUT/cls"
javac -nowarn -encoding UTF-8 -cp "$JAR" -d "$OUT/stubs" $(find $E/android_stubs -name '*.java')
javac -nowarn -encoding UTF-8 -cp "$JAR:$OUT/stubs" -d "$OUT/cls" $E/E2ETest.java $E/CorrEval.java $E/PrefixEval.java $E/OovEval.java $E/RecentEval.java
CP="$OUT/cls:$OUT/stubs:$JAR"
run() { java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -Djava.library.path="$OUT/host:$OUT/host-engine" $JAVA_OPTS -cp "$CP" "$@"; }

# ---- erros e sessões sintéticos (semente fixa)
python3 -I $E/gen_typos_all.py pt "$PT_NEWS" "$PT_CHAT" "$OUT/typos_pt.tsv" > /dev/null
python3 -I $E/gen_typos_all.py en "$EN_NEWS" "$EN_CHAT" "$OUT/typos_en.tsv" > /dev/null
python3 -I $E/gen_typos_all.py es "$ES_CHAT" "$ES_CHAT" "$OUT/typos_es.tsv" > /dev/null
python3 -I $E/gen_sessions.py "$PT_NEWS" "$PT_CHAT" "$OUT/sess_pt_topic.txt" "$OUT/sess_pt_random.txt" 400 > /dev/null
python3 -I $E/gen_sessions.py "$EN_NEWS" "$EN_CHAT" "$OUT/sess_en_topic.txt" "$OUT/sess_en_random.txt" 400 > /dev/null
python3 -I $E/gen_sessions.py "$ES_CHAT" "$ES_CHAT" "$OUT/sess_es_topic.txt" "$OUT/sess_es_random.txt" 400 > /dev/null

for L in "pt-BR|pt|qwertyuiop,asdfghjklç,zxcvbnm|$PT_NEWS $PT_CHAT" "en-US|en|qwertyuiop,asdfghjkl,zxcvbnm|$EN_NEWS $EN_CHAT" "es|es|qwertyuiop,asdfghjklñ,zxcvbnm|$ES_CHAT"; do
  D=$(echo "$L" | cut -d'|' -f1); K=$(echo "$L" | cut -d'|' -f2); ROWS=$(echo "$L" | cut -d'|' -f3); F=$(echo "$L" | cut -d'|' -f4)
  echo "================ $D"
  echo "--- correção de erros sintéticos (CorrEval)"
  run -Drows=$ROWS com.mrkeyboard.app.CorrEval dicts/$D/main.dict "$OUT/typos_$K.tsv" | grep -v "^erros"
  echo "--- digitação normal (PrefixEval): a palavra certa entre as 3 primeiras depois de k letras"
  run -Drows=$ROWS com.mrkeyboard.app.PrefixEval dicts/$D/main.dict $F
  echo "--- palavra certa fora do dicionário (OovEval): autocorreção trocaria"
  run -Drows=$ROWS com.mrkeyboard.app.OovEval dicts/$D/main.dict $F
  for KIND in topic random; do
    for R in 0 1; do
      echo "--- palavras recentes (RecentEval), sessões $KIND, recentes=$R"
      run -Drows=$ROWS -Drecent=$R com.mrkeyboard.app.RecentEval dicts/$D/main.dict dicts/$D/trigrams.bin "$OUT/sess_${K}_$KIND.txt" | grep -v "palavras fora\|palavras do dic"
    done
  done
done
