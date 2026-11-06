#!/bin/bash
# The tests of the real-message evaluation (stage 2 of docs/plan-next.md) for ONE dictionary folder: SubtitleEval on
#   subs     subtitles hold-out      <tests>/subs_test.txt         (prepare_corpus.py: md5 % 20, distinct sentences)
#   news     news hold-out           <tests>/news_test.txt
#   tatoeba  Tatoeba hold-out        <tests>/chat_test.txt
#   real     REAL messages           <tests>/real/chat_real_test.txt        (prepare_real.py: communities / medium the training never saw)
#   real_<source>                    <tests>/real/chat_real_test_<source>.txt  (the same, one file per independent test source)
#   dev      real messages of the training communities   <tests>/real/chat_real_dev.txt   (information: the "home" conditions)
# A missing file is skipped with a notice. One result file per test goes to <results dir> (SubtitleEval's own text:
# "after the space / 1 / 2 / 3 ... letters", words of 4+ letters, each sentence once). Run it once for the old pack and once for the
# candidate (different <results dir>), then:
#   python3 -I docs/tools/corpus/accept_pack.py --lang pt-BR --old <results old> --new <results new> [--pack-dir <candidate folder>]
#
# Usage, from the project root, after run_strategy_tests.sh has built the PC libs and the test classes in $OUT (default /tmp/mr_strategy):
#   bash docs/tools/e2e/run_real_eval.sh pt-BR dicts work/pt-BR work/pt-BR/results/old [app_jar.jar]
# <dicts dir> is the folder that has <lang>/main.dict, rules.txt and trigrams.bin (a candidate pack needs the rules.txt of the shipped one next to it).
# MAX (default 20000) = sentences read from each hold-out; MAX_REAL (default 100000) = from each real file.
set -e
LANG_ID=${1:?language: pt-BR, en-US or es}
DICTS=${2:?folder with <lang>/main.dict}
TESTS=${3:?folder with subs_test.txt, news_test.txt, chat_test.txt and real/}
RES=${4:?folder for the result files}
OUT=${OUT:-/tmp/mr_strategy}
JAR=${5:-$OUT/dex/classes.jar}
MAX=${MAX:-20000}
MAX_REAL=${MAX_REAL:-100000}
unset JAVA_TOOL_OPTIONS
[ -f "$DICTS/$LANG_ID/main.dict" ] || { echo "no $DICTS/$LANG_ID/main.dict"; exit 1; }
[ -f "$DICTS/$LANG_ID/rules.txt" ] || { echo "no $DICTS/$LANG_ID/rules.txt (copy the one of the shipped pack next to a candidate)"; exit 1; }
mkdir -p "$OUT/sub" "$RES"
javac -nowarn -encoding UTF-8 -cp "$JAR:$OUT/stubs:$OUT/cls" -d "$OUT/sub" docs/tools/e2e/SubtitleEval.java

run() {   # name file max
  if [ ! -s "$2" ]; then echo "skip $1: $2 is missing or empty"; return 0; fi
  java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -Dfile.encoding=UTF-8 -Dstdout.encoding=UTF-8 -Dmax="$3" \
       -Djava.library.path="$OUT/engine:$OUT/native" -cp "$OUT/sub:$OUT/cls:$OUT/stubs:$JAR" \
       com.mrkeyboard.app.SubtitleEval "$LANG_ID" "$DICTS" "$2" > "$RES/$1.txt"
  echo "== $1 ($2)"; cat "$RES/$1.txt"
}

run subs    "$TESTS/subs_test.txt" "$MAX"
run news    "$TESTS/news_test.txt" "$MAX"
run tatoeba "$TESTS/chat_test.txt" "$MAX"
run real    "$TESTS/real/chat_real_test.txt" "$MAX_REAL"
run dev     "$TESTS/real/chat_real_dev.txt" "$MAX_REAL"
for f in "$TESTS"/real/chat_real_test_*.txt; do
  [ -f "$f" ] || continue
  n=$(basename "$f" .txt)
  run "real_${n#chat_real_test_}" "$f" "$MAX_REAL"
done
