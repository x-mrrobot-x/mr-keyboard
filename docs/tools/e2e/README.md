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

### Strategy tests and everyday-language benchmark (after 1.83)
- `bash docs/tools/e2e/run_strategy_tests.sh [app_jar.jar]`: `StrategyTest`, one table-driven check per strategy of `docs/suggestion-features.md` (S1...), the data
  integrity checks (D1-D4) and the limits (L1-L5), in 3 languages through the native engine. Cases marked `GAP` are known
  gaps (they print `FIXED` when they start to pass). It runs in *Mr Keyboard - checks* and exits with 1 on a failure (`set -o pipefail`).
  Since 1.86 `run_strategy_tests.sh` reads the dictionaries from the folder in the `DICTS` variable (default `dicts`), so the same
  checks run on a copy where every `main.dict` is in format v2: `python3 -I docs/tools/make_v2_dicts.py /tmp/dicts_v2` and then
  `DICTS=/tmp/dicts_v2 bash docs/tools/e2e/run_strategy_tests.sh`. *Mr Keyboard - checks* runs both folders.
  `D1` accepts a header `200/1` (up to 4,194,304 bytes) or `200/2` (up to 16,777,216).
  Check **S28** types the original sentences of `data/everyday_<lang>.txt` (133 per language, written for this repository) and fails when a hit rate
  falls under its floor (`StrategyTest.FLOORS`); raise the floors when a release improves the rates, never lower one to pass.
- `bash docs/tools/e2e/run_subtitle_eval.sh <folder with the *_top_sentences.csv> [app_jar.jar]`: `SubtitleEval`, the hit rate of the next word
  after the space and after 1, 2 and 3 letters on the 10,000 most common OpenSubtitles sentences (not the training data of any pack). It needs the
  sentences, which are not in the repository (the script header says where to get them), so it does not run in CI. The same class reads a plain text file
  (one sentence per line, name ending in `.txt`): `java ... SubtitleEval pt-BR dicts docs/tools/e2e/data/everyday_pt-BR.txt`.
- `bash docs/tools/e2e/run_real_eval.sh <lang> <dicts dir> <tests dir> <results dir> [app_jar.jar]`: `SubtitleEval` on the four tests of the real-message evaluation
  (subtitles, news and Tatoeba hold-outs of `prepare_corpus.py`, and the real messages of `prepare_real.py`: all test sources together, each one alone, and the dev file), one result file
  per test. Run it for the old pack and for the candidate, then `python3 -I docs/tools/corpus/accept_pack.py --old ... --new ...` applies the acceptance rule
  (`docs/dictionary-tuning.md`, "Acceptance rule"). It needs the work files of the corpus pipeline, so it does not run in CI; the rule itself is tested in `docs/tools/corpus/test_real.py`.
- `SpeedEval` (by hand, run it alone on the machine): the time of every keystroke of typed sentences, by kind (after a space, 1 letter, 2-4, 5 or more,
  a word that is not in the dictionary, a valid word): `java ... SpeedEval <lang> dicts <top_sentences.csv>` with `-Dsentences=1500 -Drounds=3`. To compare two versions put the classes of one in front of the classpath (`-cp old_classes:...`) and run both
  in the same session; differences under 10% are noise. To compare dictionary formats pass the folder of the v2 copies instead of `dicts` (same classes and libs). Numbers of 1.83 → 1.84, 1.84 → 1.85 and v1 → v2 are in "Speed" of `docs/suggestion-features.md`.
- `MixEval` (stage 5, `docs/mixed-language.md`): typing in a second language in the middle of a sentence of the first. It types the sentences of
  `data/mixed_pt-BR_en-US.txt` and `data/mixed_es_en-US.txt` (the other language's words between braces) and the plain `everyday_<lang>.txt` ones,
  and compares today's behaviour with three ways of using the second pack, on the foreign words, on the active-language words and on plain text of each language
  (the guard that a strategy must not lower). It also prints the time per keystroke modeled from measured query times, with and without the cost of switching language.
  `bash docs/tools/e2e/run_mixed_eval.sh [app_jar.jar]` runs it together with `CorrEval`, `PrefixEval` and `SpeedEval` on `everyday_<lang>.txt` (the one-language baseline), and
  writes the reports to `$OUT/reports` (default `/tmp/mr_mixed`). With `-Dadded=docs/tools/loanwords/added_<id>.tsv` the foreign words that `add_loanwords.py` put in the pack get their own table (N), apart from the ones the pack already knew (F). The workflow `mr-eval.yml` (by hand, no secrets, nothing published) builds the jar like the `assemble` job, runs the script and uploads the reports.
- `TouchRescore` (stage 6, `docs/finger-position.md`): the same simulated imprecise touches as `TouchEval`, repeated, with the candidates of the real engine re-ordered by how close each touch was to the keys of
  each candidate (the distance the app does not carry today), for several dispersions and neighbour thresholds. `bash docs/tools/e2e/run_touch_eval.sh [app_jar.jar]` runs it together with `TouchEval` and writes `touch_<lang>.txt`
  to `$OUT/reports`; `mr-eval.yml` runs it after the stage 5 script.
- `AltEval` (by hand): false positives and hits of the suggestion for a valid but probably wrong word (`MrFuzzy.alternative`, strategy S27), over the
  valid words of the subtitle sentences; it was used to choose `ALT_GAP`, `ALT_TYPED_MAX` and the other `ALT_*` constants.

- `PromoEval` (by hand): how often the likely word goes to the center of the strip because the previous words confirm it (`MrFuzzy.ALT_CTX_FIRST`,
  `eu aida` → ainda), on the real previous words of the subtitle sentences: wrong promotions among correctly typed words and the share of the
  real-word errors that reach the center. Needs `AltEval.java` compiled with it: `java ... PromoEval <lang> dicts <top_sentences.csv>`, `-Dmax=10000`
  sentences, `-Dexplore=1` prints examples. Numbers of 1.85 are in "Known gaps" of `docs/suggestion-features.md`.
- `ImportEval` (by hand, and shared with `StrategyTest` S29): how an added word of a given weight ranks in the strip. It takes names the dictionary does not
  know, adds them as `MrLearned` does and counts how many are one of the 2 suggestions after 2, 3 and 4 letters: `ImportEval <lang> dicts` for the weights as shipped,
  `ImportEval <lang> dicts sweep` for the same names with a stored frequency from 6 to 250; `-Dspeed=1` times a full list, `-Dexplore=1` prints the cases and
  `-Dprobe=<word>` follows one word. It chose `MrLearned.WORD_FREQ_AT_50` (130) and the pair frequencies.

### Native engine (1.77; the only search since 1.87.0)
Every class in this folder runs the suggestion engine through `libmrengine.so`, so the lib must be on the `java.library.path` (`run_strategy_tests.sh` and `run_eval.sh`
already build the PC libs and put them there). `E2ETest.openTrigrams` stops the run when the lib does not open `trigrams.bin`: a run without
trigrams would give wrong numbers. Until 1.86.1 there was a Java copy of the search and `run_native_parity.sh` compared the two; it was removed in 1.87.0
(how to repeat that comparison after a change of file format: "Tests" in `docs/native-engine.md`).

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
