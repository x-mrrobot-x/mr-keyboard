# Mixed-language typing (stage 5): code map, options and how they are measured

Status: investigation. Nothing in the app changes until the options below are measured and one is approved.

The problem: a person with `pt-BR` active types `deploy`, `feedback` or `pull request` in the middle of a Portuguese sentence. Every
search runs on the pack of the active language, so the English word has no completion, is "corrected" to a Portuguese word and the
prediction after the space never offers it.

## How the app picks the dictionary today (read from the code)

| Step | Where | What it does |
|---|---|---|
| Language | `LatinIME.initSuggest(locale)` | builds a new `Suggest` for the input language each time it changes |
| Dictionary | `Suggest.<init>` -> `MrPacks.mainDictionary(context, locale)` -> `installedFor` | opens `main.dict` of the installed pack of that language (same region first) as the only `mMainDict` |
| Activation | `MrPacks.activate(dir)` | `MrRules.set(rules.txt of the pack)` and `MrTrigram.use(trigrams.bin of the pack)`: both are process-wide singletons |
| Completion | `Suggest.getSuggestions` -> `BinaryDictionary.getWords` (`libjni_pckeyboard.so`) | prefix and neighbouring-key completion on `mMainDict` |
| Correction | `MrFuzzy.afterWords` -> `MrNative.search` -> `Fuzzy::search` (`libmrengine.so`) | runs only when the typed word is not valid and has 3 or more letters (or for a rare valid word, `validAlternative`); the dictionary bytes come with each call, the rules are the ones last handed over |
| Valid word | `Suggest.isValidWord` | `mMainDict`, then the user, auto and contacts dictionaries; never a second language |
| Prediction | `MrPredict.forWords` | `MrTrigram.find` (one store), `mrBigrams` of `mMainDict`, user pairs, recent pairs; keeps its context in statics (`sCtx1`, `sCtx2`, `sWord`, `sCount`, `sTypedCtx`) |
| Autocorrect | `MrFuzzy.finish` / `confident` | compares the first suggestion with the typed word by edit distance; knows nothing about a second language |

What in the engine is single-language:
- `gRules` (`mr_jni.cpp`): one `Rules` object. `MrNative.search` hands it over again whenever the `MrRules` instance changes (`sPushed`), so
  alternating two languages on every keystroke would hand the rules over on every keystroke.
- `gTri`: one open `TriStore`. `MrTrigram.use` closes and reopens it when the file changes.
- `Fuzzy::search` already takes the dictionary per call (`nSearch(dict, size, ...)`), so a second dictionary needs no change there.
- Contract: a different signature of any native function or a new table means `kEngineVersion` 2 and a new `native-libs.zip`.

## The options

All three need the second pack to be installed and chosen by the person (an "also write in" setting); none touches the packs.

**(a) Ask the second language only when the first has no answer.** `Suggest` keeps a second `BinaryDictionary` (`mMainDict2`). When the typed
word is not valid in the first and the first list has no candidate close to it, the second is asked and, if it has one, its candidates go in front of the
first language's (the reserved-slot mechanism `MrFuzzy.finish` already uses for a cheap correction). Cost: nothing when the first language answers (the usual case).
Touches: `Suggest.smali` (second dictionary, a call after `MrFuzzy.afterWords`), `LatinIME.initSuggest`/`MrPacks` (open the second pack), `MrFuzzy`/`MrPredict`
(per-language rules and trigram store when the second is asked). Needs the engine to keep one `Rules` and one `TriStore` per language
(`kEngineVersion` 2) unless the cost of handing the rules over on each switch is acceptable (the test measures it).

**(b) Merge both candidate lists with a weight.** Both languages are always asked and the lists are merged by score, the second one multiplied by a weight.
Best for foreign words, but every keystroke pays two searches and the weight decides how much the second language gets in the way of the first.
Same files as (a) plus a score-based merge in `Suggest`.

**(c) Choose the language from the sentence already written.** One language is asked, the one the previous words are valid in. No extra search; but the
first foreign word of a sentence still has Portuguese words before it, and the Portuguese word after it has English before it.

## How the options are measured (`MixEval`)

`docs/tools/e2e/MixEval.java`, run by `bash docs/tools/e2e/run_mixed_eval.sh` (the manual workflow `mr-eval.yml` does it on the runner).

Data (`docs/tools/e2e/data/`): `mixed_pt-BR_en-US.txt` and `mixed_es_en-US.txt`, 106 original sentences each, the English words between braces.
The plain-language guard uses `everyday_<lang>.txt`. Nothing personal in any file.

Groups (each is a table in the report):
- **E**, the foreign words: embedded, 4 or more letters, **unknown in the active language** and known in the other. A word valid in both is left out (it is not a mixing problem). The line above the table counts what was left out and why.
- **M**, the active-language words of the same mixed sentences. Must not get worse.
- **P**, plain sentences of the active language with the second pack installed, and the same for the other language with the roles swapped. These are the "one language only" guard: a strategy that lowers them is not acceptable.

Columns: `space` = the word is among the 3 predictions after the space; `1 let` to `5 let` = among the 2 suggestions next to the typed word after that many
letters (the SubtitleEval rule); `typo 1st`/`typo top2` = the whole word typed with one synthetic error (a neighbouring key in place of the middle letter,
the middle letter missing, the two middle letters swapped), in 1st place or in the first 2.

Strategies: `A only` is today. `B only` is the other language alone (the ceiling for E and the worst case for M and P). Then (a), (b) and (c) as defined above.
Each word is typed in one session per language (so the context kept in `MrPredict` statics never mixes) and the strategies are computed from the two recorded lists.

Two limits to keep in mind when reading the numbers:
- The lists that `Suggest` returns carry no score. (b) is therefore emulated by ranks (`-Dw=` is the weight of the other language's ranks; with only 2 strip
  places any weight above 0.5 and up to 1 gives the same two entries: the first of each language). It shows what a reserved slot for the other language gains for E and costs M and P.
  A score-based merge would sit between that and (a); measuring it needs the engine to hand the scores over, which is a code change.
- The autocorrect risk (a foreign word replaced by a Portuguese one, or a Portuguese word left alone because the second language knows it) is not measured here; it needs the replacement logic
  of `MrFuzzy.finish`, and goes in the next round if an option is approved.

Latency: the report prints the time per keystroke **modeled from measured query times** of both languages, in two columns. `sw` adds what switching language costs with
the current engine (the rules handed over again, measured by alternating the two languages, plus reopening the trigram file); `no` is the same without that cost,
which is what one `Rules` and one `TriStore` per language would give. Compare the `p95 ratio` columns, always inside the same run: time on the runner is noisy and the decision on latency is made on the phone.

## Running it

Actions -> "Mr Keyboard - evaluation (by hand)" -> Run workflow (no inputs). It needs about as long as the `assemble` job of *Mr Keyboard - checks*. It publishes
nothing and has no secrets or write permission. The artifact `mr-eval-reports` has: `run_info.txt`, `single_<lang>.txt` (CorrEval, PrefixEval and SpeedEval of each language on
`everyday_<lang>.txt`, the one-language baseline of this commit) and `mixed_<pair>.txt` (MixEval). The same text is printed at the end of the job log.

## Results

Not run yet.
