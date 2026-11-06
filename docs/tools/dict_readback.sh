#!/bin/bash
# Reads back EVERY word and EVERY pair of the dictionaries through the real C++ reader (native/src/dictionary.cpp, via native/test/dict_test.cpp):
# every word must be valid and getBigrams must return exactly the stored list of every word. Used by mr-native.yml for the dictionaries in dicts/
# (format v1) and for a copy re-encoded in the format v2 (docs/tools/make_v2_dicts.py), so a change of format or of the reader cannot lose a word.
#
# From the project root:
#   bash docs/tools/dict_readback.sh <dict_test binary> [dicts folder]
# The binary comes from: cmake -S native -B build/host-native -DMR_HOST_TEST=ON && cmake --build build/host-native
set -e
BIN=${1:?path of the dict_test binary}
DICTS=${2:-dicts}
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
FAILED=0
for L in $(ls "$DICTS"); do
  [ -f "$DICTS/$L/main.dict" ] || continue
  python3 -I docs/tools/build_dict.py --dump "$DICTS/$L/main.dict" "$TMP/w.tsv" "$TMP/b.tsv" > /dev/null
  # the exit code of dict_test also counts the Portuguese "non-words" it tries (nao, voce), which are words in other languages, so the
  # result is read from the two summary lines instead
  OUT=$("$BIN" "$DICTS/$L/main.dict" "$TMP/w.tsv" "$TMP/b.tsv" | grep -E "^isValidWord|^getBigrams|MISMATCH|INVALID" || true)
  W=$(echo "$OUT" | sed -n 's/^isValidWord: \([0-9]*\)\/\([0-9]*\) valid.*/\1 \2/p')
  B=$(echo "$OUT" | sed -n 's/^getBigrams: \([0-9]*\)\/\([0-9]*\) words.*/\1 \2/p')
  set -- $W; WA=$1; WB=$2
  set -- $B; BA=$1; BB=$2
  if [ -n "$WA" ] && [ "$WA" = "$WB" ] && [ -n "$BA" ] && [ "$BA" = "$BB" ]; then
    echo "OK    $L: $WA words valid, $BA lists of pairs exact ($(head -c 2 "$DICTS/$L/main.dict" | od -An -tu1 | tr -s ' ' '/' | sed 's/^\///') header)"
  else
    echo "FAIL  $L"; echo "$OUT" | head -12; FAILED=1
  fi
done
exit $FAILED
