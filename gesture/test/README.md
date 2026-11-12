# gesture/test/ — data for the tests of the gesture recognition

Read by `engine/test/mr_gesture_test.cpp` (C++, on the PC and on the Android builds), `engine/test/java/.../JniSmoke.java` (the JNI
bridge) and `docs/tools/e2e/GestureTest.java` (the app's classes). Nothing here goes into the APK.

| File | What it is | Made by |
|---|---|---|
| `gesture_vectors.bin` | 201 real gestures with the output the **official runtime** (ExecuTorch 1.6.0 + XNNPACK, the file FUTO publishes) gives for each: the engine's own code must give the same numbers within a tolerance | `docs/tools/gesture/make_vectors.py` |
| `gestures_en-US.tsv` | 300 **real** gestures in English, QWERTY | `docs/tools/gesture/make_samples.py` |
| `gestures_es.tsv` | 300 **real** gestures in Spanish, on a layout with the `ñ` key | `docs/tools/gesture/make_samples.py` |
| `gestures_pt-BR.tsv` | 300 **synthetic** gestures in Portuguese, on the standard keyboard of the app | `docs/tools/gesture/make_samples.py` |
| `LICENSE-swipe-dataset.txt` | the licence of the dataset the real gestures come from | |

The exact commands, with the revisions of the sources, are in `docs/tools/gesture/README.md`; each tool rebuilds its file byte for
byte.

## Where the gestures come from
- **Real gestures** (the two real files and the gestures inside `gesture_vectors.bin`): the public dataset
  <https://huggingface.co/datasets/futo-org/swipe.futo.org>, revision `d71bf5fd7f45b3e7c2ed2d76a21b0dbd3b4ba566`, collected by FUTO
  from volunteers. **MIT License, Copyright (c) 2025 FUTO**; the licence text is `LICENSE-swipe-dataset.txt`. English: one gesture
  in 164 of `test.jsonl` (the part the model was not trained on). Spanish: one in 6 of the Spanish gestures of
  `swipe-5/swipe5.jsonl` (collected after the model was trained), one finger, without the ones the dataset itself marks as
  invalid. The sample goes across many volunteers; no gesture was chosen or left out because of what the recognition gives for it.
- **Synthetic gestures** (Portuguese): there are no public real gestures in Portuguese. `make_samples.py` draws a trace for each
  word of the sentences of `docs/tools/e2e/data/everyday_pt-BR.txt` (written for this project): a point near each key, smooth
  movement between them, sampled like a touch screen. Its knobs were set so that English synthetic gestures are recognised as
  often as the real gestures of the same words. **A synthetic gesture is not a person's gesture**: this file checks that the
  Portuguese dictionary, the accents and the layout of the app work, and guards against regressions; it does not prove how well
  Portuguese will be recognised on a phone.
- `gesture_vectors.bin` also holds numbers produced by running the FUTO Swipe model (its outputs for those gestures). They are
  there only to compare implementations.

## Format of `gestures_<language>.tsv`
Text, UTF-8. Lines starting with `#` are comments. One line `@keys letter x y letter x y ...` gives the keys of the keyboard the
gestures were made on (the letter of each key and the centre of the key). Then one gesture per line, three fields separated by TAB:

```
word <TAB> previous word (may be empty) <TAB> x0 y0 t0 x1 y1 t1 ...
```

`x` and `y` use the frame of the recognition (`engine/src/mr_gesture.h`): x = 0 at the left edge of the keyboard and 1 at the
right edge; y = 0 at the top of the first row of letters and 1 at the bottom of the last one (a touch above the letters has
y < 0). `t` is in milliseconds since the first point. The previous word is the one before it in the sentence the volunteer saw.

## What the tests expect from these files
Counts with the dictionaries of `dicts/` and the values of `MrGesture.java` (PC and the four Android builds give the same):

| File | gestures counted | word in the dictionary | right word first | among the first 3 | first, without the previous word |
|---|---|---|---|---|---|
| `gestures_en-US.tsv` | 298 | 281 | 256 (91.1%) | 272 (96.8%) | 250 |
| `gestures_es.tsv` | 284 | 277 | 260 (93.9%) | 276 (99.6%) | 256 |
| `gestures_pt-BR.tsv` | 300 | 300 | 288 (96.0%) | 294 (98.0%) | 283 |

Gestures of a one-letter word are left out (a single key is a tap); the percentages are over the words the dictionary has. Two words
that differ only in upper and lower case count as one. The tests fail if a count falls below its floor (the floors are a little
under these numbers; `mr_gesture_test.cpp`, `JniSmoke.java`, `GestureTest.java`). These samples are small: for a measurement, run
`mr_gesture_test eval` on the whole dataset (`docs/gesture-typing.md` has the numbers).
