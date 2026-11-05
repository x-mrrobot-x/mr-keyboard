# Suggestion engine measurements on the PC (1.75)

Runs the APK's real classes (classes.dex → jar with dex2jar) and the native lib compiled for the PC from the
same `dictionary.cpp`. Only `LatinIME` (which needs Android) is left out. It exists to decide engine changes
**before** touching the app: each adjustment is measured in three languages and only goes in if it gains without worsening the rest.

`bash docs/tools/e2e/run_eval.sh` runs everything (see the script header for the variables). What each class measures:

| Class | What it measures |
|---|---|
| `CorrEval` (`gen_typos_all.py`) | synthetic errors (neighboring key, swapped letters, missing letter at the start, middle and end, repeated letter): does the right word appear in 1st position? within 2 positions? It separates the cases where the wrong word is a valid word. `--noprox` builds the word from the letters only (the re-correction up to 1.74). |
| `PrefixEval` | typing **without errors**: after 2 to 5 letters of a word from the text, is it among the first 3? It is the brake on any change to the correction: it must not get worse. |
| `OovEval` | right words the dictionary does not know (names, slang): with autocorrection on, how many would be replaced? It is the risk of a more aggressive correction. |
| `RecentEval` (`gen_sessions.py`) | recent words: is the next word among the 3 shown after the space and after 1 to 3 letters, in simulated sessions, with and without `MrRecent` (`-Drecent=0`). |
| `E2ETest`, `E2EEn`, `E2EEs` | end-to-end checks with fixed expectations (`ALL OK` or `FAIL`). |
| `Parity`, `TouchEval`, `TypoEval` | list-by-list comparison of two versions, imprecise touches and synthetic errors (1.64 to 1.66). |
| `NativeParity` | native engine (1.77): the `MrFuzzy` search and the final `Suggest` list through Java and through `libmrengine.so`, word by word, score, cost and nodes visited; trigrams through both paths; the time of both. It exits with 1 if there is any difference. It runs in CI via `run_native_parity.sh`. |

### Strategy tests and everyday-language benchmark (after 1.83)
- `bash docs/tools/e2e/run_strategy_tests.sh [app_jar.jar]`: `StrategyTest`, one table-driven check per strategy of `docs/suggestion-features.md` (S1...), the data
  integrity checks (D1-D4) and the limits (L1-L5), in 3 languages through the native engine and the Java fallback. Cases marked `GAP` are known
  gaps (they print `FIXED` when they start to pass). It runs in *Mr Keyboard - checks*.
- `bash docs/tools/e2e/run_subtitle_eval.sh <folder with the *_top_sentences.csv> [app_jar.jar] [-Dctx=A]`: `SubtitleEval`, the hit rate of the next word
  after the space and after 1, 2 and 3 letters on the 10,000 most common OpenSubtitles sentences (not the training data of any pack). It needs the
  sentences, which are not in the repository (the script header says where to get them), so it does not run in CI. `-Dctx=A` is the prototype of keeping the
  previous words' context while typing (`plan-suggestions.md`, item 1.1).

### Native engine (1.77)
`bash docs/tools/e2e/run_native_parity.sh [app_jar.jar]` compiles the PC libs (`engine/` and `native/`), generates the queries from
`dicts/` itself (`engine/tools/gen_parity_queries.py`) and runs `NativeParity` in the 3 languages; it is the same thing that *Mr Keyboard - checks* runs.
Any other class in this folder (`CorrEval`, `PrefixEval`…) also uses the lib when it is on the `java.library.path` (`run_eval.sh`
already puts both there); `JAVA_OPTS=-Dmr.native=off` forces Java. In comparative measurements, run both ways.

## Measurement limits
- The test texts (Leipzig, Tatoeba) come **shuffled**, with no real conversation. `gen_sessions.py` builds two
  approximations: sessions **by topic** (sentences that repeat a rare word: optimistic, the topic repeats more than in a
  conversation) and **random** (unrelated sentences: pessimistic, recent words can only get in the way). The truth is in between.
- The errors are synthetic and uniform by type; real typing errors have a different distribution.
- Times are from the PC (warmed-up JIT); on the phone they are a few times larger.

## Adjusting a value without recompiling the app
Copy the `.java` to a temporary folder, replace `static final int NAME = N;` with
`static int NAME = Integer.getInteger("NAME", N);`, compile against the jar and put the folder in front of the classpath;
`-DNAME=value` changes the number without recompiling. That is how `C_DEL`, `COMP_V` and the others were chosen.
