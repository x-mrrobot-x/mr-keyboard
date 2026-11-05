#!/bin/bash
# Everyday-language benchmark of the suggestion engine (SubtitleEval): how often the next word is among the 3 predictions after
# the space and among the 2 suggestions after 1, 2 and 3 letters, on the 10,000 most common sentences of OpenSubtitles.
# The sentences are NOT in the repository (they are a corpus, not ours): download them once (about 1 MB per language):
#   git clone --depth 1 --filter=blob:none --sparse https://github.com/orgtre/top-open-subtitles-sentences /tmp/tos
#   cd /tmp/tos && git sparse-checkout set bld/top_sentences
# From the project root, after run_strategy_tests.sh has built the PC libs and the test classes in $OUT (default /tmp/mr_strategy):
#   bash docs/tools/e2e/run_subtitle_eval.sh /tmp/tos/bld/top_sentences [app_jar.jar] [-Dall=1]
# The last argument is passed to Java (-Dall=1 counts words of every length, see SubtitleEval.java).
set -e
OUT=${OUT:-/tmp/mr_strategy}
S=${1:?folder with pt_br_top_sentences.csv, en_top_sentences.csv, es_top_sentences.csv}
JAR=${2:-$OUT/dex/classes.jar}
EXTRA=${3:-}
unset JAVA_TOOL_OPTIONS
mkdir -p "$OUT/sub"
javac -nowarn -encoding UTF-8 -cp "$JAR:$OUT/stubs:$OUT/cls" -d "$OUT/sub" docs/tools/e2e/SubtitleEval.java
for P in "pt-BR pt_br" "en-US en" "es es"; do
  set -- $P
  java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -Dfile.encoding=UTF-8 -Dstdout.encoding=UTF-8 $EXTRA \
       -Djava.library.path="$OUT/engine:$OUT/native" -cp "$OUT/sub:$OUT/cls:$OUT/stubs:$JAR" \
       com.mrkeyboard.app.SubtitleEval "$1" dicts "$S/$2_top_sentences.csv"
done
