# docs/tools/gesture — how the data of gesture typing was made

The recognition of gesture typing (`engine/src/mr_gesture*`, `docs/gesture-typing.md`) uses a weights file and test data that live
in `gesture/`. These tools rebuild each of those files, byte for byte, from what FUTO publishes. None of them runs in CI or is
needed to build the app: they are here so that nothing in `gesture/` has to be taken on trust.

| Tool | Writes | Needs |
|---|---|---|
| `extract_weights.py` | `gesture/encoder.bin` | `executorch` (only to read the `.pte` container), numpy |
| `make_vectors.py` | `gesture/test/gesture_vectors.bin` | `torch` (CPU) and `executorch`: it runs the official runtime |
| `make_samples.py` | `gesture/test/gestures_<language>.tsv` | nothing for the real gestures; numpy for the synthetic ones |

## Sources (fixed revisions)
```bash
M=https://huggingface.co/futo-org/futo-swipe/resolve/315d42583233b71d75665d076cfa2f2c7c6f43ad
D=https://huggingface.co/datasets/futo-org/swipe.futo.org/resolve/d71bf5fd7f45b3e7c2ed2d76a21b0dbd3b4ba566
mkdir -p DS/swipe-5/layouts
curl -L --fail -o model_fp32.pte $M/honorable_sturgeon/model_fp32.pte     # 2.6 MB; FUTO Model Weights License 1.0
for f in test.jsonl dev.jsonl swipe-5/swipe5.jsonl swipe-5/layouts/qwerty.json swipe-5/layouts/spanish.json; do
  curl -L --fail -o DS/$f $D/$f                                           # 270 MB + 304 MB + 0.3 GB; MIT License
done
```
SHA-256: `model_fp32.pte` `725242bab5d14345e96ff214e8de2bfbc1f962c232d320df9c24cb82ffd1fbaf`; `test.jsonl`
`d4e42e34ced1cae925a5ec94672bdaf48b4532598a1e39d72884f9c7b588721e`; `dev.jsonl`
`8d9d34ec1c12f564d02dcb69cf132ba19d45b75632a205af90d3a81290e24972`; `swipe5.jsonl`
`08f1a805dbfc4348959f088ef9f829cbcb41f76af33d3235b4932cb65e215555`.

## The weights
```bash
python3 -m venv .venv && . .venv/bin/activate
pip install torch==2.15.0 --index-url https://download.pytorch.org/whl/cpu
pip install --no-deps executorch==1.6.0
pip install numpy flatbuffers ruamel.yaml pyyaml tabulate packaging "nvidia-cuda-runtime>=13,<14"   # the last one only so that executorch imports
python3 docs/tools/gesture/extract_weights.py model_fp32.pte --check gesture/encoder.bin    # "the same bytes this tool writes"
python3 docs/tools/gesture/extract_weights.py model_fp32.pte gesture/encoder.bin            # writes it again
```

## The reference outputs of the official runtime
```bash
python3 docs/tools/gesture/make_vectors.py model_fp32.pte DS/dev.jsonl DS/swipe-5/swipe5.jsonl DS/swipe-5/layouts \
    gesture/test/gesture_vectors.bin 150 50
```

## The gestures of the tests
At the project root (`--standard` is a shorthand for the options and the comment lines of each file; `STANDARD` in the tool lists them):
```bash
python3 docs/tools/gesture/make_samples.py --standard en-US --ds DS --out gesture/test/gestures_en-US.tsv   # one in 164 of test.jsonl
python3 docs/tools/gesture/make_samples.py --standard es    --ds DS --out gesture/test/gestures_es.tsv      # one in 6 of the Spanish ones of swipe-5
python3 docs/tools/gesture/make_samples.py --standard pt-BR         --out gesture/test/gestures_pt-BR.tsv   # synthetic, from everyday_pt-BR.txt
```
With the options written out and without `--every` and `--max`, the same tool writes the whole set (49,211 English gestures from `test.jsonl`, 1,925 Spanish ones,
8,160 synthetic Portuguese ones), which `mr_gesture_test eval` measures:
```bash
python3 docs/tools/gesture/make_samples.py --jsonl DS/test.jsonl --layout-json DS/swipe-5/layouts/qwerty.json --out /tmp/en_test.tsv
./build/engine/mr_gesture_test eval dicts/en-US/main.dict gesture/encoder.bin /tmp/en_test.tsv        # 3 to 4 minutes
```
`--layout-xml` also reads `res/xml/kbd_compact.xml` and `kbd_full.xml`: that is how the other two keyboard modes of the app were
measured (`docs/gesture-typing.md`).

`eval` takes three more optional arguments: `[max] [context|nocontext] [detail.tsv]`. The detail file gets one line per gesture:
the word, `1` if the dictionary has it (`0` if not), the place it came in (`0` = first, `-1` = not found), and then the first
three answers of the search, each as `word(score,logp,keys)`. `max` is how many gestures to read (`-1` = all). The
answers are also written for the gestures whose word is not in the dictionary, and each answer carries its `logp` and its number
of keys: that is the file the rule "nothing is written under a `logp` of -30" of the keyboard was measured on
(`docs/gesture-typing.md`, "Behind the rules of the touch").
```bash
./build/engine/mr_gesture_test eval dicts/en-US/main.dict gesture/encoder.bin /tmp/en_test.tsv -1 context /tmp/en_detail.tsv
```

The same program has two more ways of measuring a file of gestures (`docs/gesture-typing.md`, "What was measured",
has the tables they gave):
- `words main.dict weights gestures.tsv [max] [frequency ...]`: **the words of the person.** The words of the file that
  `main.dict` lacks stand for what a person taught the keyboard: they go into a second dictionary, all with the given
  frequency, and every gesture is searched in both dictionaries. One line per frequency: how many of those words come first
  and among 3, how many words of `main.dict` lost the first place to one of them, the size of the second dictionary and the
  time of the second search. This is where the range 100 to 130 of `MrGestureWords` comes from.
- `partial main.dict weights gestures.tsv [max] [step_ms]`: **what a part of a gesture gives.** Each gesture is cut at 25,
  50, 75, 90 and 100% of its duration and each part is recognised as if the finger had lifted there; then it is followed
  every `step_ms` (100 if not given), as the keyboard does for the word it shows while the finger slides: how many words
  would be shown, how often the word changes, and how often the last one shown is the final word.
```bash
./build/engine/mr_gesture_test words dicts/en-US/main.dict gesture/encoder.bin /tmp/en_test.tsv -1 100 130 160 200    # about 5 minutes per frequency
./build/engine/mr_gesture_test partial dicts/en-US/main.dict gesture/encoder.bin gesture/test/gestures_en-US.tsv -1 120
```
