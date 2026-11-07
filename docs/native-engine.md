# Native libraries and native engine (1.77; the only search since 1.87.0)

The app uses two native libraries, both with the code **in this repository** and both built by the same workflow (`mr-native.yml`, NDK):

| Library | Code | What it does |
|---|---|---|
| `libjni_pckeyboard.so` | `native/` | dictionary reader (`BinaryDictionary`): word completion, valid word, bigrams. Mandatory. Base: Hacker's Keyboard / LatinIME (Apache-2.0) |
| `libmrengine.so` | `engine/` | native engine: the correction search (`MrFuzzy`) and the trigram lookup (`MrTrigram`) in C++. Since 1.87.0 there is **no Java copy** of them in the app. Since 1.90.0 it maps `trigrams.bin` (MRT1 or MRT2) instead of copying it |

The ready-made binaries live in `lib/<abi>/`. Engine details: `engine/README.md`.

## How the app uses the native engine
- `MrNative` (Java) loads `libmrengine.so` once per process, in the background: `MrPacks.activate` (called when the keyboard opens the dictionary of a language) starts the load, so the first key does not wait for it. Then it checks the contract (`ENGINE_VERSION`) and hands over the costs of `MrFuzzy`,
  the uppercase/lowercase/unaccented tables and the language rules (`rules.txt`) that are already loaded. The **source of truth
  stays in Java**; the lib has no constant of its own. What stays in Java is the policy (costs, rules, the reserved slot, the careful autocorrection, the prediction, learning, the screens) and the
  short dictionary lookup that tells the frequency of a typed word (`MrFuzzy.ownFrequency`).
- `MrFuzzy.search` and `MrTrigram.find` ask the lib. A query that arrives while the lib is still loading waits for it (`MrNative.ready()`); this happens at most once per process
  (the process of the keyboard lives on in the background; it starts again after a reboot or when Android kills it, not every time the keyboard opens). On the PC the file loads in 0.3 ms and the tables and rules take 8 to 14 ms to build and hand over (that time is the tables and rules, not the trigram indexes: opening `trigrams.bin` cost about 3 ms as MRT1 and costs about 0.5 ms as MRT2); the times on a phone are shown by the "Dictionary memory" line (1.90.0) and were not measured by us.
- Without the lib (no `libmrengine.so` for the ABI, a different contract version, an error while loading) the searches answer "no result": typing, word completion (`libjni_pckeyboard.so`), the prediction from the pairs of the dictionary and the learned words keep working;
  the correction by search and the two-word prediction are gone. "Settings → Suggestions and dictionaries" then shows **"Motor de sugestões: Indisponível (biblioteca nativa não encontrada)"** (Suggestion engine: Unavailable (native library not found)); with the lib it shows **"Nativo (C++)"** (Native (C++)).
  `docs/tools/native_test/NoLibTest.java` (in `run_java_tests.sh`) checks that this case throws nothing.

## trigrams.bin: MRT2, mmap and the rule about pack files (1.90.0)
`TriStore` (`engine/src/mr_tri.cpp`) reads two layouts, told apart by the magic number: MRT1 (packs until 1.89: variable records, the lib builds two index vectors at open, about 1.2 MB) and MRT2 (1.90: 11-byte fixed records and the offset tables inside the file, nothing built at open). Both are **mapped** (`mmap`, read-only) instead of copied to the heap, so each active language no longer holds about 6 MB of app memory (4.7 MB of file + 1.2 MB of indexes in pt-BR) but pages of a file that the system can drop. Layouts, limits and measurements: `suggestion-features.md`, "trigrams.bin layouts".
- **Invariant that mmap depends on: a pack file is never rewritten, truncated or overwritten in place.** Reading a mapped page of a file that shrank brings the app down (SIGBUS) and no check in the lib can catch it. `MrPacks.install` is safe because it writes `<id>/<version>.tmp`, renames the folder and deletes the old one with `unlink` (the mapped inode lives on until the lib closes it). Any new code that writes `main.dict` or `trigrams.bin` must write another file and rename it. `mr_test` swaps a pack with the file open (delete + rename, and replace by rename) for MRT1 and MRT2.
- **Open checks only what is O(words)** in MRT2; the records are checked when they are read (a corrupt record gives fewer hits, never a read outside the file; ASan/UBSan fuzz in `mr_test`). `TriStore::verifyAll()` checks them all.
- **Changing the layout again**: write the new reader next to the old ones (the app must keep reading what is installed), keep the word ids, raise `minApp` of the packs (`make_catalog.py` has the rule, `MRT2_MIN_APP`), update `mrt_format.py` (an independent reader and writer), and compare the old and new files on every context, as `mr_test` and `test_mrt_format.py` do. The JNI contract did not change in 1.90.0 (`kEngineVersion` stays 1): nothing in the signatures or tables moved. The "Dictionary memory" line reads `/proc/self/smaps` in Java, so it needs no native function.

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
- Changing the **file format** read by the lib (a new dictionary format, as the v2 of 1.86.0, or the MRT2 of 1.90.0): besides the cases above, compare the lib with an independent reader once. For MRT2 that was done with a second reader/writer written apart in `engine/test/test_util.h` and a third one in Python (`docs/tools/mrt_format.py`): about 550,000 queries per language, 0 differences. 1.86.0 did it against the Java search (10,897 correction queries, 2,000 suggestion lists and 24,000 trigram queries per language, 0 differences). The Java search and its comparison script (`docs/tools/e2e/run_native_parity.sh`, `NativeParity.java`) were removed in 1.87.0 but are in the release v1.86.1: build its APK jar, put the new libs on `java.library.path` and run that script with `DICTS=<folder>`; it works while the lib contract (`ENGINE_VERSION`) is the same.

## Rolling back
There is no Java engine to go back to. Without `libmrengine.so` the keyboard types and completes words but loses the correction by search and the two-word prediction (above); without `libjni_pckeyboard.so` it does not read the dictionary at all.
The decision to remove the Java search was taken with the owner of the project in 1.87.0: the C++ engine gave the same result in every test and the Java copy only doubled the tests; the cost is that a device that cannot load the lib has no safety net.
