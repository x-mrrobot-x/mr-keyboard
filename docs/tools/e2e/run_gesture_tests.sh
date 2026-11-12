#!/bin/bash
# Gesture typing, the recognition (MrGesture over the native engine), in the three languages, through the APK's real classes.
# Runs GestureTest with the dictionaries of dicts/, the weights of gesture/ and the gestures of gesture/test (no download).
# Runs in CI (mr-checks.yml) and on the PC.
#
# From the project root:
#   bash docs/tools/e2e/run_gesture_tests.sh [app_jar.jar]
# Without the jar (classes.dex of the APK -> dex2jar), it builds the APK just for this: needs APKTOOL_JAR and DEX2JAR (dex-tools-2.1 folder).
# Variables: OUT (default /tmp/mr_gesture); DICTS (folder with the dictionaries, default dicts; docs/tools/make_v2_dicts.py makes a copy in
#            the dictionary format v2 to run the same checks on it: the counts must be the same). Exits with code 1 if any check fails.
set -e
set -o pipefail   # the Java test exits 1 on a failure; without this the pipe to grep would hide it
OUT=${OUT:-/tmp/mr_gesture}
E=docs/tools/e2e
unset JAVA_TOOL_OPTIONS
mkdir -p "$OUT"

# ---- PC lib: the engine (engine/). The dictionary reader (native/) is not needed: the gesture search reads main.dict by itself.
cmake -S engine -B "$OUT/engine" -DCMAKE_BUILD_TYPE=Release > "$OUT/cmake_engine.log" 2>&1
cmake --build "$OUT/engine" >> "$OUT/cmake_engine.log" 2>&1

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
javac -nowarn -encoding UTF-8 -cp "$JAR:$OUT/stubs" -d "$OUT/cls" $E/GestureTest.java
DICTS=${DICTS:-dicts}   # a copy in the dictionary format v2: docs/tools/make_v2_dicts.py
java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -Dfile.encoding=UTF-8 -Dstdout.encoding=UTF-8 \
     -Djava.library.path="$OUT/engine" -cp "$OUT/cls:$OUT/stubs:$JAR" \
     com.mrkeyboard.app.GestureTest "$DICTS" gesture/encoder.bin gesture/test | grep -v "^Picked"
