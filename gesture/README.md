# gesture/ — the model of gesture typing and its test data

Gesture typing (sliding the finger over the letters of a word) is recognised by the native engine (`engine/src/mr_gesture*.{h,cpp}`,
overview in `docs/gesture-typing.md`). This folder holds the data that code needs: the weights of the neural network and, in
`test/`, the gestures the tests run on. Like `dicts/`, it is **not** part of the apktool project: nothing here goes into the APK by
itself. It is also a **pack** (1.96.0): the app downloads the weights from the release, like a dictionary ("The pack" below).

| File | What it is |
|---|---|
| `encoder.bin` | the weights of the network (2,537,110 bytes; 73 tensors, 633,988 float32 values) |
| `encoder.bin.sha256` | its SHA-256 (`sha256sum -c encoder.bin.sha256`, checked in CI) |
| `LICENSE-FUTO-Model-Weights.md` | the licence of the weights, as published with them (`res/raw/mr_futo_license.md` is a copy of it inside the APK) |
| `pack.json` | what makes this folder a pack: id `gesture`, version, format, the oldest app that can use it, the files that go in the zip |
| `NOTICE.txt` | the notice that travels inside the pack: derived from FUTO Swipe, under which licence, from which file, not modified |
| `test/` | reference outputs of the official runtime and 900 gestures for the tests (`test/README.md`) |

## `encoder.bin` is derived from FUTO Swipe and is subject to the FUTO Model Weights License 1.0

**`encoder.bin` contains the weights of the "FUTO Swipe" encoder (model `honorable_sturgeon`), by FUTO Holdings, Inc. It is derived
from FUTO Swipe and is subject to the FUTO Model Weights License 1.0, whose full text is in
[`LICENSE-FUTO-Model-Weights.md`](LICENSE-FUTO-Model-Weights.md).** That licence, not the Apache License of the rest of this
repository, governs this one file.

- Source: <https://huggingface.co/futo-org/futo-swipe>, revision `315d42583233b71d75665d076cfa2f2c7c6f43ad`, file
  `honorable_sturgeon/model_fp32.pte` (SHA-256 `725242bab5d14345e96ff214e8de2bfbc1f962c232d320df9c24cb82ffd1fbaf`).
- **The weights were not modified.** `docs/tools/gesture/extract_weights.py` takes them out of the ExecuTorch container (`.pte`) and
  writes them in a plain container the engine reads (magic `MRSWENC1`, then each tensor with a name and its sizes). Every tensor is,
  byte for byte, a run of bytes of the published file. `python3 docs/tools/gesture/extract_weights.py model_fp32.pte --check
  gesture/encoder.bin` rebuilds the file from the published one and says whether it is the same.
- Only the encoder is here. The other models FUTO publishes with it (a decoder and context language models, English only) are
  not used.

What the licence asks, in short. **Read the text; this summary is not legal advice.**

1. Any use is allowed, commercial ones included, **provided the product shows its users a visible notice that it is powered by
   "FUTO Swipe" technology**, in a place such as the settings or the about screen. Leaving the notice out is a material breach.
   → The app offers the weights and **shows the notice**: "Powered by “FUTO Swipe” technology" is the last row of
   Settings, Suggestions and dictionaries, Gesture typing. It is there with or without the weights installed, as one line that
   does nothing when tapped. Its text is `mr_gesture_notice_title` in `res/values*/mr_strings.xml`
   (`ModelPackTest` fails if the title loses the name). Do not remove that row while the app can use the weights.
2. Whoever passes the weights (or a model derived from them) on must pass the licence text along and say, prominently, in the
   README or equivalent, that it is derived from FUTO Swipe and under this licence. That is what this section and the licence
   file are for: keep the two next to the weights wherever they go (a pack, the APK, a release).
   → The pack carries `LICENSE-FUTO-Model-Weights.md` and `NOTICE.txt` next to `encoder.bin` (the catalog tool and the app both
   refuse a pack without the licence text); its entry in the catalog and the text of the release say the same; weights installed
   from a picked file get the licence text written next to them from the copy in the APK.
3. Modified weights must carry a prominent notice that they were modified. The file here is not modified. A smaller variant
   (16-bit floats take 1.29 MB, 8-bit integers 0.68 MB, with no measurable loss in the tests of `docs/gesture-typing.md`) would be,
   and would have to say so.
4. The name "FUTO Swipe" may be used only for the notice of item 1, not to promote the app or to suggest any relationship with FUTO.
5. The licence covers the weights only. The code that runs the network in this repository (`engine/src/mr_gesture_nn.cpp`) was
   written for this project from the published graph, uses nothing of FUTO's own inference code (their library is GPLv3 and is not
   used) and is under the Apache License 2.0 like the rest.
6. Research publications that use the weights must cite them as "FUTO Swipe Model". The licence ends for whoever claims in writing
   that the weights infringe a patent.

## The pack (1.96.0)
The app does not carry the weights. `docs/tools/make_catalog.py --model gesture` (called by `publish_release.sh` when this folder
has a `pack.json`) makes `mr-keyboard-model-gesture-<version>.zip` with `pack.json` and the files it lists, and adds an entry to
the `"models"` list of the signed catalog. The zip is attached to the release where the version changed and stays there; the apps
before 1.96.0 do not read `"models"`. How the app downloads, checks and installs it, and the settings around it:
`docs/gesture-typing.md`, "The weights: a pack of the catalog, or a file".

`pack.json`:

| Field | Value today | What it is |
|---|---|---|
| `id` | `gesture` | the only model the app knows (`MrPacks.MODEL_GESTURE`) |
| `version` | 1 | raise it whenever a file of the pack changes: the tool refuses a changed content with the same version |
| `format` | 1 | 1 = `encoder.bin` as the engine contract 2 reads it. A file the current lib cannot read needs another number, so that older apps leave it alone |
| `minApp` | 1096000 | the oldest app that may install it (never under 1096000, the first one that reads `"models"`) |
| `files` | `encoder.bin`, `LICENSE-FUTO-Model-Weights.md`, `NOTICE.txt` | what goes in the zip; the weights and the licence text are required |
| `name`, `description`, `licenses`, `credits` | | what the settings show (Portuguese, English, Spanish) |

When the weights change, four things change together (`ModelPackTest` fails until they agree): `encoder.bin.sha256`, `version`
here, the table `MrPacks.MODEL_FILES` (the files the app takes from **From a file**) and the size in the three
`mr_gesture_need_pack` strings. A release is what carries the pack, so the version of the app goes up too (`apktool.yml`), as
when a dictionary changes; and modified weights need the notice of item 3 above, in `NOTICE.txt` and in this file.

To try a version on a phone before its release exists (the app reads the catalog of the latest release, which does not have the
weights until 1.96.0 is published): copy `encoder.bin` to the phone and, in the settings of gesture typing, choose **From a
file**. The app only takes a file whose SHA-256 it knows.

## How the files are used
```bash
# the engine tests (PC), from the project root; see engine/README.md
./build/engine/mr_gesture_test dicts gesture/encoder.bin gesture/test 100
# through the app's classes
bash docs/tools/e2e/run_gesture_tests.sh
# the keyboard code, from touch events to text
bash docs/tools/e2e/run_gesture_input_tests.sh
# the zip of the pack and the catalog entry, by hand
python3 -I docs/tools/make_catalog.py --dicts dicts --model gesture --out /tmp/out --tag v1.96.0
```
In the app, `MrGesture.use(File)` hands the path of the weights file to the lib, which reads it once (2.8 MB on the heap with the
work memory) and closes it. The file is the one `MrPacks` installed in `files/models/gesture/<version>/`, from the pack or from a
picked file; `MrGestureInput.reload()` opens it when the setting is on and lets go of it when the setting or the file goes away.
