#!/bin/bash
# Gesture typing in the keyboard (MrGestureInput), from the touch events to the text, with the real recognition: the gestures of
# gesture/test are drawn again as touch events on a fake keyboard and the words written are counted (GestureInputE2E.java says
# what that proves). The Java layer is compiled from docs/tools/java/src against the stubs, like run_java_tests.sh; the
# recognition is the native engine built for the PC. Runs in CI (mr-checks.yml) and on the PC.
#
# From the project root:
#   bash docs/tools/e2e/run_gesture_input_tests.sh
# Needs a JDK and cmake. Variables: OUT (default /tmp/mr_gesture_input); DICTS (default dicts; a copy in the dictionary format v2 made by
# docs/tools/make_v2_dicts.py gives the same counts). Exits with code 1 if any check fails.
set -e
set -o pipefail   # the Java test exits 1 on a failure; without this the pipe to grep would hide it
OUT=${OUT:-/tmp/mr_gesture_input}
D=docs/tools
unset JAVA_TOOL_OPTIONS
mkdir -p "$OUT"

# ---- PC lib: the engine (engine/)
cmake -S engine -B "$OUT/engine" -DCMAKE_BUILD_TYPE=Release > "$OUT/cmake_engine.log" 2>&1
cmake --build "$OUT/engine" >> "$OUT/cmake_engine.log" 2>&1

# ---- the Java layer and the test
rm -rf "$OUT/stubs" "$OUT/main" "$OUT/cls"; mkdir -p "$OUT/stubs" "$OUT/main" "$OUT/cls"
javac -nowarn --release 8 -d "$OUT/stubs" $(find $D/java/stubs -name '*.java')
javac -Xlint:-options --release 8 -cp "$OUT/stubs" -d "$OUT/main" $(find $D/java/src -name '*.java')
javac -encoding UTF-8 -nowarn -cp "$OUT/stubs:$OUT/main" -d "$OUT/cls" $D/e2e/GestureInputE2E.java
DICTS=${DICTS:-dicts}
java -Dfile.encoding=UTF-8 -Dstdout.encoding=UTF-8 -Djava.library.path="$OUT/engine" -cp "$OUT/cls:$OUT/stubs:$OUT/main" \
     com.mrkeyboard.app.GestureInputE2E "$DICTS" gesture/encoder.bin gesture/test | grep -v "^Picked"
