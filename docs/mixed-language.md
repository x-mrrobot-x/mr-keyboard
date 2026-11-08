# Mixed-language typing (stage 5): code map, options and how they are measured

Status: closed. Option (d), foreign words added to the packs, is done and measured twice; (a), (b) and (c) are not implemented and the app code is unchanged. The list stays at 151 and 152 words: the keyboard is for many people, so it is not grown with the vocabulary of one.

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

## Results of the first run (packs pt-BR 8 and es 6, before option d)

Words in E are the foreign words the active pack did not know: 32 in the pt-BR run, 84 in the es run. The pt-BR pack already knew 85 of the 118 English words
of the sentences (72%), the es pack 30 (25%). Hit rates in percent, pt-BR / es:

| E, foreign words | 3 letters | 5 letters | typo, top 2 | worst drop in the active-language words | p95 ratio, plain text |
|---|---|---|---|---|---|
| A only (today) | 0 / 0 | 0 / 0 | 0 / 0 | - | 1.00 |
| B only (ceiling) | 47 / 37 | 77 / 80 | 91 / 94 | total | - |
| (a) ask B when A has no answer | 0 / 0 | 18 / 28 | 38 / 45 | none | 1.00 to 1.02 |
| (b) one slot kept for B | 19 / 23 | 50 / 61 | 82 / 82 | 13 / 15 points (5 letters) | 2.2 to 4.2 |
| (c) language of the words before | 3 / 0 | 0 / 0 | 2 / 0 | 2.7 / 1.8 points | 1.00 to 1.08 |

Switching language with the current engine costs 52 / 41 microseconds for the rules and 740 / 771 for the trigram file, so what weighs is reopening the trigrams,
not the rules; (a) has no use for the second language's trigrams. The prediction after the space of a foreign word is 0 in every strategy: the context is
always of the active language.

## Option (d): the packs learn the foreign words

The packs already hold most of the English words people mix in (the ones that were frequent in the real messages), so the cheapest way to cover the rest is data:
`docs/tools/loanwords/english_words.txt` lists common English words (software and work, social networks, games, fitness, beauty, food) and
`python3 -I docs/tools/add_loanwords.py --lang pt-BR --lang es --write` adds to `main.dict` the ones the pack lacks. Rules, all in the script:
- a word is added only if it is a plain lowercase word of 5 or more letters, is not in the pack (any capitalisation), and is in the English pack of Mr Keyboard;
- a word one typo away (substitution, missing or extra letter, swap) from a word of the pack with frequency 100 or more is not added (`branch` and `branco`, `sequel` and `sequer`);
- the frequency is the one in the English pack minus 30, kept between 55 and 80. The words that the real messages made frequent have 84 to 114 in the pack, so an added word ranks first only when no
  word of the language has the same beginning, and it can still be the correction of a typo that has no native word near it;
- nothing else changes: the words and pairs that were there are the same bytes of data (the script re-reads the new file and checks every word, frequency and pair), `trigrams.bin` is not touched, and
  the pack version goes up by one (pt-BR 9, es 7).

Added: 151 words to pt-BR and 152 to es (`docs/tools/loanwords/added_<id>.tsv`). A second run adds nothing, and `test_add_loanwords.py` checks that the shipped packs match the list.

How to measure it: run the manual workflow again. `MixEval` now has two more groups: **N**, the foreign words that the list added (before they were in E with 0% in every column), and **F**, the foreign
words the pack already knew (not measured in the first run). E shrinks to what is still unknown. The words of the active language (M) and the plain text (P) must stay where they were in the first run:
that is the check that the added words do not get in the way. The list was written without looking at the test sentences, but the sentences were written by the same hand, so the gain on N is optimistic;
the check that matters is M and P, and the phone.

## Results of the second run (packs pt-BR 9 and es 7)

The foreign words of the sentences: 118 in each pair. What the list did: of the 32 (pt-BR) and 84 (es) words that were unknown, 15 are now known in each pack (N); 17 and 69 are still unknown (E). The list holds 151 and 152
new words, so it was not written around these sentences: it covers 47% of the unknown words in pt-BR and 18% in es.

Hit rates in percent, pt-BR / es, active language alone (before they were 0 in every column):

| | 3 letters | 4 letters | 5 letters | typo, 1st | typo, top 2 |
|---|---|---|---|---|---|
| N, the words the list added (15 words) | 7 / 20 | 20 / 53 | 69 / 85 | 82 / 91 | 96 / 98 |
| F, the foreign words the pack already knew (82 / 29 words) | 27 / 35 | 64 / 60 | 91 / 75 | 81 / 76 | 88 / 86 |

- The words of the active language did not change: in the mixed sentences (M) and in plain text (P), every column of the row "A only" is the same as in the first run in pt-BR and in es, and so are the `CorrEval` and `PrefixEval` blocks of the three
  languages (for example the total of `CorrEval`: 78.6 / 90.2 in pt-BR, 79.7 / 88.6 in en-US, 77.4 / 89.4 in es). Times in `SpeedEval` are lower than in the first run by about a fifth in the three languages; time on the runner is not
  comparable between runs.
- The added words rank below the ones that real messages made frequent (3 and 4 letters: 7 and 20 against 27 and 64 in pt-BR) because their frequency is kept in a band of 55 to 80, and rank like them from 5 letters on and in the typed-with-error case.
  Since nothing got worse, there is room to raise the band, at the cost of risking the words of the language; the guard (M, P, `CorrEval`, `PrefixEval`) is in place to say if it does.
- What is left: more words in the list (it covers less than half of what was unknown in pt-BR and a fifth in es), or the band. Both are data and the same run measures them.

