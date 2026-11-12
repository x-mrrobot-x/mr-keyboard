# engine/ — native engine of Mr Keyboard (stage 1)

The correction search (`MrFuzzy`) and the trigram lookup (`MrTrigram`) of the app in C++, delivered as
**`libmrengine.so`**. It reads the files of the packs (`main.dict`, `trigrams.bin`), with **no format of its own** (`trigrams.bin` has two layouts, MRT1 and MRT2, see `docs/suggestion-features.md`): `main.dict` in format v1 (header `200/1`) or v2 (header `200/2`, since 1.86, up to 16 MB; `docs/dictionary-build.md`), told apart by the header. Since 1.87.0 it is the **only**
implementation (the Java copy was removed; before, the result was identical word by word, score, cost and visited nodes, which the release v1.86.1 still
lets you check). If the lib is not in the APK, fails to load or has another contract version, the keyboard keeps typing and completing words but has no correction by search and no two-word prediction. Overview and flow: `docs/native-engine.md`.

Since the contract 3 (1.96.0) the lib also has the **recognition of gesture typing** (`src/mr_gesture*`): a small neural network reads the trace of the
finger and a search finds the words in the same `main.dict` (gesture typing, experimental and off by default). The same gesture can be searched in a second dictionary of the same
format, which the app writes in memory from the words of the person (`nGestureMore`, `Gesture::more`). What it is, what was measured and what is left: `docs/gesture-typing.md`. Its weights file and test data are in `gesture/` (the weights have a licence of their own:
`gesture/README.md`).

The dictionary reader (`libjni_pckeyboard.so`) lives in `native/` and is a separate CMake project; both libs come out of the same
workflow (`.github/workflows/mr-native.yml`).

## Layout
| Path | What it is |
|---|---|
| `src/mr_engine.h` | contract: constants, tables, `Fuzzy`, `TriStore`, `kEngineVersion` (2 since gesture typing, 3 since the second dictionary of a gesture) |
| `src/mr_fuzzy.cpp` | the correction search (passes, banded dynamic programming, splitting of run-together words); ported from `MrFuzzy.java` in 1.77 |
| `src/mr_tri.cpp` | the trigram file (MRT1 and, since 1.90, MRT2; both mapped) and UTF-8 conversions; ported from `MrTrigram.java` in 1.77 |
| `src/mr_gesture.h` | gesture typing: limits, the frame of the coordinates, `GestureNet`, `GestureDict`, `GestureSearch`, `Gesture` |
| `src/mr_gesture_nn.cpp` | the weights file, the resampling of the trace and the network (the encoder of FUTO Swipe, run by this code: no third-party library) |
| `src/mr_gesture_decode.cpp` | the search of the words of a gesture in `main.dict` and, since the contract 3, in a second dictionary of the same format (`Gesture::more`) |
| `src/mr_jni.cpp` | `JNI_OnLoad` + `RegisterNatives` of `com.mrkeyboard.app.MrNative` |
| `test/mr_test.cpp` | search on the real dictionary, order independence, corrupt files, edge cases (without Java) |
| `test/mr_gesture_test.cpp` | gesture typing: the weights file, the network against the official runtime, the search on hand-made tables, real gestures, the second dictionary, corrupt files, absurd input; `eval`, `words` and `partial` measure any file of gestures |
| `test/run_android_tests.sh` | builds the tests for the Android ABIs and runs them on the PC (the ARM ones under qemu-user) |
| `test/mr_bench.cpp` | measurement |
| `test/java/…` | `JniSmoke` (JNI bridge, bad arguments, gestures through the JNI, with and without a second dictionary) and the copy of the native declarations of `MrNative` |
| `tools/gen_parity_queries.py` | queries for the parity test, taken from `dicts/` itself |

## Run on the PC
```bash
cmake -S engine -B build/engine -DCMAKE_BUILD_TYPE=Release -DMR_HOST_TEST=ON
cmake --build build/engine -j4
./build/engine/mr_test dicts 100       # search, trigrams in both layouts, pack swap, corrupt files, edge cases (dictionaries in dicts/)
python3 -I docs/tools/test_mrt_format.py   # the same layouts from Python: round trips, limits, damaged files, converter
./build/engine/mr_bench dicts 20       # speed
./build/engine/mr_gesture_test dicts gesture/encoder.bin gesture/test 100    # gesture typing (data in gesture/)

cmake -S engine -B build/san -DCMAKE_BUILD_TYPE=RelWithDebInfo -DMR_HOST_TEST=ON -DMR_SANITIZE=ON
cmake --build build/san -j4 && ./build/san/mr_test dicts 200            # ASan + UBSan
./build/san/mr_gesture_test dicts gesture/encoder.bin gesture/test 150

javac -d build/jc engine/test/java/com/mrkeyboard/app/*.java
java -cp build/jc com.mrkeyboard.app.JniSmoke build/engine/libmrengine.so dicts gesture/encoder.bin gesture/test    # JNI bridge without the app

bash docs/tools/e2e/run_strategy_tests.sh     # the app's strategy checks through this lib, 3 languages (builds the temporary APK; see the script header)
bash docs/tools/e2e/run_gesture_tests.sh      # gesture typing through the app's classes, 3 languages
```

### The tests on the Android builds
The PC tests run code built by the PC compiler for the PC processor. `test/run_android_tests.sh` builds the same tests with the NDK
for each Android ABI, as static executables, and runs them on the PC: the x86 ones directly, the ARM ones under `qemu-user`.
```bash
sudo apt install qemu-user-static        # Debian/Ubuntu; or QEMU_DIR=<folder with qemu-aarch64-static and qemu-arm-static>
bash engine/test/run_android_tests.sh $ANDROID_HOME/ndk/27.2.12479018                      # the four ABIs, the gesture test in its quick mode
FULL=1 MR_TEST=3 bash engine/test/run_android_tests.sh $ANDROID_HOME/ndk/27.2.12479018 arm64-v8a   # everything, mr_test too
```
It answers one question: does the ARM code (NEON, 32-bit sizes, the libm of Android) give the same answers as the PC code? It says
nothing about speed (an emulator is some 50 times slower than a phone: 200 ms per gesture) and it is not a run on a device. The
script header has the two details of static Android executables (built for android-30; the 32-bit ones need a low process id).

### On a phone
The same executables run on a device, where the times mean something:
```bash
cmake -S engine -B build/arm64-test -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake -DANDROID_ABI=arm64-v8a \
      -DANDROID_PLATFORM=android-30 -DCMAKE_BUILD_TYPE=Release -DMR_ANDROID_TEST=ON && cmake --build build/arm64-test -j4
adb shell mkdir -p /data/local/tmp/mr/dicts /data/local/tmp/mr/gesture
adb push build/arm64-test/mr_gesture_test /data/local/tmp/mr/
adb push dicts/pt-BR dicts/en-US dicts/es /data/local/tmp/mr/dicts/
adb push gesture/encoder.bin /data/local/tmp/mr/gesture/ && adb push gesture/test /data/local/tmp/mr/gesture/
adb shell "cd /data/local/tmp/mr && ./mr_gesture_test dicts gesture/encoder.bin gesture/test 20"       # prints ms per gesture per language
adb shell "cd /data/local/tmp/mr && ./mr_gesture_test eval dicts/pt-BR/main.dict gesture/encoder.bin gesture/test/gestures_pt-BR.tsv"
```
(`-DANDROID_PLATFORM=android-30` needs a device with Android 11 or later; this has not been run by anyone yet. What is known
from a phone came from the app itself: with 1.96.0 the settings showed 9.4 ms per gesture on average on the phone of the owner,
`docs/gesture-typing.md`, "Cost".)


## Build and put it in the app
Changed `engine/` (or `native/`)? The **Mr Keyboard - native lib** workflow runs on push (or by hand: Actions → Run workflow). It
tests on the PC and builds both libs for arm64-v8a, armeabi-v7a, x86 and x86_64 with NDK 27. Download the **`native-libs`** artifact, extract it at the
project root (merging with `lib/`) and commit `lib/`, `native-src.sha256`, `mrengine-src.sha256` and `mrengine-info.txt`. The APK
workflow compares the hashes with the current code and does not publish if `lib/` is stale.

## Contract with the app
- The **source of truth** for the costs (`C_PROX_1`, `C_DEL`…), the rules (`rules.txt`), `Character.toLowerCase`/`isUpperCase` and
  `MrText.base` is the **app's Java**. It hands everything to the lib at load time (`MrNative.init`) and when the language pack
  changes (`MrNative.pushRules`). The lib has no tuning constant of its own. Changing a cost in `MrFuzzy.java` **does not require**
  rebuilding the lib; changing the **algorithm** (a new pass, a new rule in the walk) is a change in `src/mr_fuzzy.cpp`, with a case in
  `mr_test.cpp` or `StrategyTest`, new libs and, if the contract changed, a new `kEngineVersion`.
- **`kEngineVersion`** (`src/mr_engine.h`) must equal `MrNative.ENGINE_VERSION`. It goes up when the signature of a native function,
  the order of the costs or the meaning of a table changes. Different version = the app does not use the lib.
- The Java score uses `Math.pow(2.0, -cost/25.0)`; Java hands over that table computed by itself, so the rounding is the same on
  any device.
- The trigrams are **mapped** (`mmap`, read-only), since 1.90.0; before, they were read whole into memory (about 5 MB) with 1.2 MB of indexes. MRT2 needs no index. This is
  safe only because a pack file is never rewritten in place: the installer writes another folder and renames it (see `docs/native-engine.md`). `mr_test` swaps a pack with the file open.
- **Never trust the files**: every read is checked against the size; the recursive searches have a node ceiling (`MrFuzzy.NODE_BUDGET`,
  handed over by the app), because on a corrupt file they would grow exponentially.
- **Gesture typing** follows the same rules with one exception. The scoring values, the limits, the keys and the characters that take
  no key come from Java (`MrGesture`); the weights file is checked whole when it is opened (size, tensor names and sizes, every value a
  finite number) and the dictionary at every read, with a ceiling of entries per gesture (`MrGesture.NODE_BUDGET`). The exception is
  rule 5 of `mr_engine.h`: there is no Java implementation to be identical to, and float arithmetic is not identical between
  processors, so the network is checked by tolerance against the official runtime and the words by counts on real gestures.

## What is tested
| What | How | Where |
|---|---|---|
| The app's strategies through the lib | S1-S29, the data and limit checks and the floors of S28, in 3 languages, on `dicts/` and on a copy in the format v2 (the lib is the PC build) | `run_strategy_tests.sh`, in CI (mr-checks.yml) |
| Search on the real dictionary and order independence | obvious corrections; the result of a query does not change because of the previous ones | `mr_test`, in CI |
| Corrupt dictionary/trigrams | cut off, swapped bytes, garbage, with ASan + UBSan: no crash, no read outside the file, no freeze | `mr_test`, in CI |
| Bad arguments in the JNI | non-direct buffer, short arrays, nonexistent file | `JniSmoke`, in CI |
| Gesture typing | the weights file, the network against the official runtime, the search, real gestures in 3 languages, the second dictionary of a gesture (contract 3: the merge, the marks, bad arguments, a corrupt one), corrupt files, absurd input, through C++, the JNI and the app's classes, on the PC and on the ARM builds under an emulator (`docs/gesture-typing.md` has the table) | `mr_gesture_test`, `JniSmoke`, `run_android_tests.sh`, `run_gesture_tests.sh`, in CI |

Validated on a device (1.77): lib loading, correction and prediction. Since 1.90.0 the "Dictionary memory" line shows memory and opening time on the device; the owner read it on 2026-11-08 (the numbers were not recorded in the repository).
