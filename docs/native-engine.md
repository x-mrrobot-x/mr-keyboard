# Native libraries and native engine (1.77; the only search since 1.87.0)

The app uses two native libraries, both with the code **in this repository** and both built by the same workflow (`mr-native.yml`, NDK):

| Library | Code | What it does |
|---|---|---|
| `libjni_pckeyboard.so` | `native/` | dictionary reader (`BinaryDictionary`): word completion, valid word, bigrams. Mandatory. Base: Hacker's Keyboard / LatinIME (Apache-2.0) |
| `libmrengine.so` | `engine/` | native engine: the correction search (`MrFuzzy`) and the trigram lookup (`MrTrigram`) in C++. Since 1.87.0 there is **no Java copy** of them in the app |

The ready-made binaries live in `lib/<abi>/`. Engine details: `engine/README.md`.

## How the app uses the native engine
- `MrNative` (Java) loads `libmrengine.so` once per process, in the background: `MrPacks.activate` (called when the keyboard opens the dictionary of a language) starts the load, so the first key does not wait for it. Then it checks the contract (`ENGINE_VERSION`) and hands over the costs of `MrFuzzy`,
  the uppercase/lowercase/unaccented tables and the language rules (`rules.txt`) that are already loaded. The **source of truth
  stays in Java**; the lib has no constant of its own. What stays in Java is the policy (costs, rules, the reserved slot, the careful autocorrection, the prediction, learning, the screens) and the
  short dictionary lookup that tells the frequency of a typed word (`MrFuzzy.ownFrequency`).
- `MrFuzzy.search` and `MrTrigram.find` ask the lib. A query that arrives while the lib is still loading waits for it (`MrNative.ready()`); this happens at most once per process
  (the process of the keyboard lives on in the background; it starts again after a reboot or when Android kills it, not every time the keyboard opens). On the PC the file loads in 0.3 ms and the tables and rules take 8 to 14 ms to build and hand over; the time on a phone was not measured.
- Without the lib (no `libmrengine.so` for the ABI, a different contract version, an error while loading) the searches answer "no result": typing, word completion (`libjni_pckeyboard.so`), the prediction from the pairs of the dictionary and the learned words keep working;
  the correction by search and the two-word prediction are gone. "Settings → Suggestions and dictionaries" then shows **"Motor de sugestões: Indisponível (biblioteca nativa não encontrada)"** (Suggestion engine: Unavailable (native library not found)); with the lib it shows **"Nativo (C++)"** (Native (C++)).
  `docs/tools/native_test/NoLibTest.java` (in `run_java_tests.sh`) checks that this case throws nothing.

## Changed `native/` or `engine/`: build the libs
1. Push. The **Mr Keyboard - native lib** workflow runs by itself (or by hand: Actions → Run workflow). It tests on the PC (`dict_test`, `mr_test`, `JniSmoke`, ASan/UBSan) and builds both libs for arm64-v8a, armeabi-v7a, x86 and x86_64.
2. Download the `native-libs` artifact and extract it at the project root, **merging** with what already exists. It writes `lib/<abi>/libjni_pckeyboard.so` and `libmrengine.so`, `native-src.sha256` and `mrengine-src.sha256` (which code each lib came from) and `mrengine-info.txt` (contract, commit and SHA-256 of each `.so`).
3. Commit.

The step **Check that lib/ was built from the current native/ and engine/** of *Mr Keyboard - APK* recalculates both hashes and checks that the 6 libs exist; if anything does not match, it warns and **does not publish** (with *publish* checked, it fails). The `native/` calculation covers `native/CMakeLists.txt` + `native/src`; the engine one is done from inside `engine/` (`CMakeLists.txt` + `src`). Tests and data are not included.

## Tests
There is one implementation, so there is no Java × C++ comparison any more. The engine is checked at two levels:
- `mr-native.yml`, on the PC and without the app: `mr_test` (search on the real dictionary, order independence, corrupt files, edge cases), ASan/UBSan, `JniSmoke` (the JNI bridge and bad arguments) and `dict_test` (every word and pair of the dictionaries read back).
- `mr-checks.yml`, through the real app classes and the PC build of the lib: `run_strategy_tests.sh` (one check per strategy S1-S29, the data and limit checks, the floors of S28; in 3 languages, on `dicts/` and on a copy in the format v2) and `packs_test/run_packs_tests.sh`.

## When to touch the engine
- Changing a **cost** or a language rule in `MrFuzzy.java`/`rules.txt`: Java only; the lib receives the new values by itself.
- Changing the **algorithm** (`engine/src/mr_fuzzy.cpp`, `mr_tri.cpp`): change the C++ only, add the case to `mr_test.cpp` or `StrategyTest`, build the libs (above) and raise `kEngineVersion` (C++) and `ENGINE_VERSION` (Java) if the contract changed.
- Changing the **signature** of a `native` of `MrNative`: change `engine/src/mr_jni.cpp` and `engine/test/java/.../MrNative.java` and raise the contract version.
- Changing the **file format** read by the lib (a new dictionary format, as the v2 of 1.86.0): besides the cases above, compare the lib with an independent reader once. 1.86.0 did it against the Java search (10,897 correction queries, 2,000 suggestion lists and 24,000 trigram queries per language, 0 differences). The Java search and its comparison script (`docs/tools/e2e/run_native_parity.sh`, `NativeParity.java`) were removed in 1.87.0 but are in the release v1.86.1: build its APK jar, put the new libs on `java.library.path` and run that script with `DICTS=<folder>`; it works while the lib contract (`ENGINE_VERSION`) is the same.

## Rolling back
There is no Java engine to go back to. Without `libmrengine.so` the keyboard types and completes words but loses the correction by search and the two-word prediction (above); without `libjni_pckeyboard.so` it does not read the dictionary at all.
The decision to remove the Java search was taken with the owner of the project in 1.87.0: the C++ engine gave the same result in every test and the Java copy only doubled the tests; the cost is that a device that cannot load the lib has no safety net.
