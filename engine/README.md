# engine/ — native engine of Mr Keyboard (stage 1)

The correction search (`MrFuzzy`) and the trigram lookup (`MrTrigram`) of the app in C++, delivered as
**`libmrengine.so`**. It reads the files of the packs (`main.dict`, `trigrams.bin`), with **no format of its own**: `main.dict` in format v1 (header `200/1`) or v2 (header `200/2`, since 1.86, up to 16 MB; `docs/dictionary-build.md`), told apart by the header. Since 1.87.0 it is the **only**
implementation (the Java copy was removed; before, the result was identical word by word, score, cost and visited nodes, which the release v1.86.1 still
lets you check). If the lib is not in the APK, fails to load or has another contract version, the keyboard keeps typing and completing words but has no correction by search and no two-word prediction. Overview and flow: `docs/native-engine.md`.

The dictionary reader (`libjni_pckeyboard.so`) lives in `native/` and is a separate CMake project; both libs come out of the same
workflow (`.github/workflows/mr-native.yml`).

## Layout
| Path | What it is |
|---|---|
| `src/mr_engine.h` | contract: constants, tables, `Fuzzy`, `TriStore`, `kEngineVersion` |
| `src/mr_fuzzy.cpp` | the correction search (passes, banded dynamic programming, splitting of run-together words); ported from `MrFuzzy.java` in 1.77 |
| `src/mr_tri.cpp` | the trigram file (MRT1) and UTF-8 conversions; ported from `MrTrigram.java` in 1.77 |
| `src/mr_jni.cpp` | `JNI_OnLoad` + `RegisterNatives` of `com.mrkeyboard.app.MrNative` |
| `test/mr_test.cpp` | search on the real dictionary, order independence, corrupt files, edge cases (without Java) |
| `test/mr_bench.cpp` | measurement |
| `test/java/…` | `JniSmoke` (JNI bridge, bad arguments) and the copy of the native declarations of `MrNative` |
| `tools/gen_parity_queries.py` | queries for the parity test, taken from `dicts/` itself |

## Run on the PC
```bash
cmake -S engine -B build/engine -DCMAKE_BUILD_TYPE=Release -DMR_HOST_TEST=ON
cmake --build build/engine -j4
./build/engine/mr_test dicts 100       # search, trigrams, corrupt files, edge cases (dictionaries in dicts/)
./build/engine/mr_bench dicts 20       # speed

cmake -S engine -B build/san -DCMAKE_BUILD_TYPE=RelWithDebInfo -DMR_HOST_TEST=ON -DMR_SANITIZE=ON
cmake --build build/san -j4 && ./build/san/mr_test dicts 200            # ASan + UBSan

javac -d build/jc engine/test/java/com/mrkeyboard/app/*.java
java -cp build/jc com.mrkeyboard.app.JniSmoke build/engine/libmrengine.so dicts    # JNI bridge without the app

bash docs/tools/e2e/run_strategy_tests.sh     # the app's strategy checks through this lib, 3 languages (builds the temporary APK; see the script header)
```


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
- The trigrams are read **whole into memory** (about 3 MB) and only the indexes are kept apart. It deliberately does not use `mmap`: if
  a new pack replaced the file in place, reading a mapped page would bring the app down (SIGBUS).
- **Never trust the files**: every read is checked against the size; the recursive searches have a node ceiling (`MrFuzzy.NODE_BUDGET`,
  handed over by the app), because on a corrupt file they would grow exponentially.

## What is tested
| What | How | Where |
|---|---|---|
| The app's strategies through the lib | S1-S29, the data and limit checks and the floors of S28, in 3 languages, on `dicts/` and on a copy in the format v2 (the lib is the PC build) | `run_strategy_tests.sh`, in CI (mr-checks.yml) |
| Search on the real dictionary and order independence | obvious corrections; the result of a query does not change because of the previous ones | `mr_test`, in CI |
| Corrupt dictionary/trigrams | cut off, swapped bytes, garbage, with ASan + UBSan: no crash, no read outside the file, no freeze | `mr_test`, in CI |
| Bad arguments in the JNI | non-direct buffer, short arrays, nonexistent file | `JniSmoke`, in CI |

Validated on a device (1.77): lib loading, correction and prediction. Speed and memory on the device were not measured.
