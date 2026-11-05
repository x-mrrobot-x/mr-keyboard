# Native libraries and native engine (1.77)

The app uses two native libraries, both with the code **in this repository** and both built by the same workflow (`mr-native.yml`, NDK):

| Library | Code | What it does |
|---|---|---|
| `libjni_pckeyboard.so` | `native/` | dictionary reader (`BinaryDictionary`): word completion, valid word, bigrams. Mandatory. Base: Hacker's Keyboard / LatinIME (Apache-2.0) |
| `libmrengine.so` | `engine/` | native engine, stage 1 (1.77): the correction search (`MrFuzzy`) and the trigram lookup (`MrTrigram`) in C++. Optional: without it the app uses the Java code |

The ready-made binaries live in `lib/<abi>/`. Engine details: `engine/README.md`.

## How the app uses the native engine
- `MrNative` (Java) loads `libmrengine.so` once, in the background, checks the contract (`ENGINE_VERSION`) and hands over the costs of `MrFuzzy`,
  the uppercase/lowercase/unaccented tables and the language rules (`rules.txt`) that are already loaded. The **source of truth
  stays in Java**; the lib has no constant of its own.
- `MrFuzzy.search` and `MrTrigram.find` ask the lib; if it is not there, did not load, refused the query or is still loading,
  they go through the Java code as before. The result is the same on both paths (parity test).
- "Configurações → Sugestões e dicionários" (Settings → Suggestions and dictionaries) shows **"Motor de sugestões: Nativo (C++)"** (Suggestion engine: Native (C++)) or **"Java (biblioteca nativa não encontrada)"** (Java (native library not found)).

## Changed `native/` or `engine/`: build the libs
1. Push. The **Mr Keyboard - native lib** workflow runs by itself (or by hand: Actions → Run workflow). It tests on the PC (`dict_test`, `mr_test`, `JniSmoke`, ASan/UBSan) and builds both libs for arm64-v8a, armeabi-v7a, x86 and x86_64.
2. Download the `native-libs` artifact and extract it at the project root, **merging** with what already exists. It writes `lib/<abi>/libjni_pckeyboard.so` and `libmrengine.so`, `native-src.sha256` and `mrengine-src.sha256` (which code each lib came from) and `mrengine-info.txt` (contract, commit and SHA-256 of each `.so`).
3. Commit.

The step **Check that lib/ was built from the current native/ and engine/** of *Mr Keyboard - APK* recalculates both hashes and checks that the 6 libs exist; if anything does not match, it warns and **does not publish** (with *publish* checked, it fails). The `native/` calculation covers `native/CMakeLists.txt` + `native/src`; the engine one is done from inside `engine/` (`CMakeLists.txt` + `src`). Tests and data are not included.

## Java × C++ parity
*Mr Keyboard - checks* runs `docs/tools/e2e/run_native_parity.sh`: it builds the APK, compiles the two PC libs and runs `NativeParity` in the 3 languages, with the queries taken from `dicts/` itself. The search, the final suggestion list and the trigrams must be **identical** through Java and through the lib (via the JNI). This also holds for changes in `dicts/` (rules, dictionaries, trigrams): the parity is redone over the new files, with nothing to regenerate.

## When to touch the engine
- Changing a **cost** or a language rule in `MrFuzzy.java`/`rules.txt`: Java only; the lib receives the new values by itself.
- Changing the **algorithm** of `MrFuzzy.search/walk/split` or of `MrTrigram`: port the change to `engine/src/mr_fuzzy.cpp`/`mr_tri.cpp`, run `run_native_parity.sh` (it must give 0 differences), build the libs (above) and raise `kEngineVersion` (C++) and `ENGINE_VERSION` (Java) if the contract changed.
- Changing the **signature** of a `native` of `MrNative`: change `engine/src/mr_jni.cpp` and `engine/test/java/.../MrNative.java` and raise the contract version.

## Rolling back
Delete the three `libmrengine.so` (and publish a new version): the app goes back to Java by itself, as in 1.76. Without `libjni_pckeyboard.so` the keyboard does not read the dictionary.
