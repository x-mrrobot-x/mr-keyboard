#!/bin/bash
# Paridade do motor nativo (v1.77) com os dicionários de dicts/: a busca de correção, a lista final de sugestões e os
# trigramas pelo Java e pela libmrengine.so têm de dar o MESMO resultado nos três idiomas. Roda no CI (mr-checks.yml) e no PC.
# As consultas saem do próprio dicionário (engine/tools/gen_parity_queries.py): não precisa de corpus.
#
# Na raiz do projeto:
#   bash docs/tools/e2e/run_native_parity.sh [jar_do_app.jar]
# Sem o jar (classes.dex do APK -> dex2jar), monta o APK só para isso: precisa de APKTOOL_JAR e DEX2JAR (pasta dex-tools-2.1).
# Variáveis: OUT (padrão /tmp/mr_paridade), WORDS (palavras por idioma, padrão 2500), ROUNDS (padrão 1),
#            SUGG (quantas passam pelo Suggest completo, padrão 2000).
# Sai com código 1 se houver qualquer diferença.
set -e
ROOT=$(pwd)
OUT=${OUT:-/tmp/mr_paridade}
WORDS=${WORDS:-2500}
ROUNDS=${ROUNDS:-1}
SUGG=${SUGG:-2000}
E=docs/tools/e2e
unset JAVA_TOOL_OPTIONS
mkdir -p "$OUT"

# ---- libs de PC: motor (engine/) e leitor do dicionário (native/)
cmake -S engine -B "$OUT/engine" -DCMAKE_BUILD_TYPE=Release > "$OUT/cmake_engine.log" 2>&1
cmake --build "$OUT/engine" >> "$OUT/cmake_engine.log" 2>&1
cmake -S native -B "$OUT/native" -DCMAKE_BUILD_TYPE=Release > "$OUT/cmake_native.log" 2>&1
cmake --build "$OUT/native" >> "$OUT/cmake_native.log" 2>&1

# ---- jar do app
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
javac -nowarn -encoding UTF-8 -cp "$JAR:$OUT/stubs" -d "$OUT/cls" $E/E2ETest.java $E/NativeParity.java
CP="$OUT/cls:$OUT/stubs:$JAR"

FALHOU=0
for L in "pt-BR|qwertyuiop,asdfghjklç,zxcvbnm" "en-US|qwertyuiop,asdfghjkl,zxcvbnm" "es|qwertyuiop,asdfghjklñ,zxcvbnm"; do
  D=${L%%|*}; ROWS=${L#*|}
  echo "================ $D"
  python3 -I engine/tools/gen_parity_queries.py --lang "$D" --out "$OUT" --words "$WORDS" --root .
  java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -Dfile.encoding=UTF-8 -Dstdout.encoding=UTF-8 \
       -Djava.library.path="$OUT/engine:$OUT/native" -Drows="$ROWS" -Drounds="$ROUNDS" -Dsuggmax="$SUGG" -Dpairs="$OUT/pares_$D.txt" \
       -cp "$CP" com.mrkeyboard.app.NativeParity "dicts/$D/main.dict" "$OUT/erros_$D.tsv" "dicts/$D/trigrams.bin" || FALHOU=1
done
exit $FALHOU
