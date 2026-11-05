# Suggestion engine: what is implemented

Living list of every suggestion, correction and prediction feature, per language, with the check that proves it works.
Update it in the same commit that adds, changes or removes a feature. The ids (S1, S2...) are the tags used by
`docs/tools/e2e/StrategyTest.java`; run `bash docs/tools/e2e/run_strategy_tests.sh` to check them all (3 languages, native engine and Java fallback).

Measured on 1.83.0. Everyday-language numbers (prediction and completion hit rates on subtitle sentences) are in `plan-suggestions.md` and come from `docs/tools/e2e/run_subtitle_eval.sh`. "Since" is the version that introduced the feature (from the version notes and the code comments).

## Data per language
| | pt-BR | en-US | es |
|---|---|---|---|
| Pack version (`dicts/<id>/pack.json`) | 4 | 3 | 2 |
| `main.dict` size (limit 4,194,304, 22-bit addresses) | 3,708,011 (88.4%) | 3,758,547 (89.6%) | 3,792,609 (90.4%) |
| Words | 173,822 | 168,992 | 239,683 |
| Word pairs (bigrams, up to 60 per word) | 400,000 | 400,000 | 340,000 |
| `trigrams.bin` (MRT1): words / contexts | 30,618 / 169,258 | 18,127 / 142,509 | 35,948 / 191,217 |
| `rules.txt`: corrections (keys are compared without accent: es has 137 distinct) | 217 | 346 | 138 |
| `rules.txt`: phonetic / vowels / groups / silent / extra / one-letter words | 12 / 2 / 11 / 6 / 1 / 3 | 6 / 4 / 4 / 17 / 0 / 2 | 9 / 2 / 6 / 4 / 1 / 5 |
| Sentence starters (`[sentence_start]`) | Eu, Você, Não | I, The, You | No, El, Me |
| Sources | AOSP list, Leipzig `por_news_2024_1M`, Tatoeba | AOSP list, Leipzig English news, Tatoeba | AOSP list, Leipzig Spanish news, Tatoeba |
| Keyboard layout in tests | `qwertyuiop,asdfghjklç,zxcvbnm` | `qwertyuiop,asdfghjkl,zxcvbnm` | `qwertyuiop,asdfghjklñ,zxcvbnm` |

Files of a pack: `main.dict` (AOSP LatinIME "latest" format, header 200/1), `trigrams.bin` (MRT1, continuations after two words),
`rules.txt` (format 1), `NOTICE.txt`. The pack is downloaded in *Settings → Suggestions and dictionaries*; one language is active at a time.

## Strategies
All of them are in the three languages unless the last column says otherwise. "Where" is the class or file that does it.

| Id | Strategy | Where | Since | Per-language detail | Check |
|---|---|---|---|---|---|
| S1 | Completion of the typed prefix, ignoring accent and case | `libjni_pckeyboard.so` (`native/`) + `Suggest` | AOSP; initials with accent/capital 1.60 | same in all | `StrategyTest` S1 |
| S2 | Neighbouring key (the touch's neighbours, in order of distance: costs 25 / 30 / 35) | lib + `MrFuzzy` (`C_PROX_1/2/FAR`) | 1.60; by distance 1.66 | same in all | S2 |
| S3 | Map of common errors and chat abbreviations (`vc`, `tbm`, `dont`, `xq`), case kept (`Vc` → `Você`) | `MrFix`, `[corrections]` | 1.60; per pack 1.63 | 217 / 346 (contractions) / 138 | S3 |
| S4 | Extra letter (doubled 30, `[extra]` letter 40, neighbour 45, other 60) | `MrFuzzy.insCost` | 1.60 | `[extra]`: h in pt-BR and es | S4 |
| S5 | Missing letter (40; doubled 30; silent letters cheaper) | `MrFuzzy.delCost` | 1.60; 60 → 40 in 1.75 | same in all | S5 |
| S6 | Two adjacent letters swapped (40) | `MrFuzzy` (`C_TRANS`) | 1.60 | same in all | S6 |
| S7 | Doubled letter (`asim` → assim) | `MrFuzzy` | 1.60 | same in all | S7 |
| S8 | Phonetic pairs (cost 25) and confusable vowels (45) | `[phonetic]`, `[vowels]` | 1.60; per pack 1.63 | pt s/z/c/k/q/g/j/x...; en c/k/s/z...; es b/v, s/z/c, y/i... | S8 |
| S9 | Silent letters: at the start (`^ h`), after a letter, after any letter (`*`) | `[silent]` | 1.60; `*` 1.64 | pt h q u g u c h; en k w h + vowels; es h | S9 |
| S10 | One letter for two and two for one (`ch`/`x`, `ss`/`ç`, `ph`/`f`, `ll`/`y`, `qu`/`k`) | `[groups]` (cost 35) | 1.60; per pack 1.63 | 11 / 4 / 6 groups | S10 |
| S11 | First letter not typed (`ossível` → possível) | `MrFuzzy` (`C_DEL_FIRST` 30) | 1.66; 35 → 30 in 1.75 | same in all | S11 |
| S12 | Missing space (`porisso` → por isso), from 4 typed letters | `MrFuzzy.split` (cost 35), `[one_letter_words]` | 1.60 | one-letter words: a e o / a i / a e o u y | S12 |
| S13 | First letter after a word: the previous word's bigrams, with accent/capital initials | `Suggest`, `BinaryDictionary.getBigrams` | 1.60 | same in all | S13 |
| S14 | Prediction after the space: dictionary bigrams + the user's pairs (weight 2) + recent pairs; 3 shown, best in the centre | `MrPredict.forWords` | 1.60 | same in all | S14 |
| S15 | Prediction from the two previous words | `MrTrigram` (C++ since 1.77), `TRIGRAM_BONUS` 128 | 1.62 | 169k / 143k / 191k contexts | S15 |
| S16 | Learning: words and pairs you use (`AutoDictionary`, `UserBigramDictionary`); never in a password field or with `IME_FLAG_NO_PERSONALIZED_LEARNING` | `LatinIME.checkAddToDictionary` (smali) | AOSP; always on with suggestions since 1.60 | per locale | **no PC test** (needs Android) |
| S17 | Recent words of this conversation: completion (2), prediction bonus, recent pairs; memory only, cleared when the field or app changes | `MrRecent` | 1.75 | same in all | `RecentTest` (CI) |
| S18 | Sentence starters at the start of the text or after `. ! ? … ¿ ¡` | `MrPredict.list`, `MrText.atSentenceStart` | 1.62; `¿ ¡` 1.65 | 3 words per language | S18 |
| S19 | Careful autocorrection: replaces on its own only a map entry, or within 1 error (up to 5 letters) / 2 errors (longer), accent and case ignored; never a suggestion with a space outside the map | `MrFuzzy.finish/confident` | 1.62; touch half-error 1.66 | same in all | S19 |
| S20 | A valid word is never searched or replaced; capital letters kept | `MrFuzzy.afterWords` | 1.60 | same in all | S20 |
| S21 | A cheap correction keeps a slot among the 3 shown even when the completions are many (`prota` → porta) | `MrFuzzy.finish` (`RESERVE_MAX_COST` 45) | 1.62 | same in all | S21 |
| S22 | Re-correction of the word under the cursor, with the neighbour keys of the on-screen keyboard; API 31+ reads one snapshot with `getSurroundingText` | `MrRecorrect` | 1.74; neighbours 1.75 | same in all | `RecorrectTest` (CI), S22 |
| S23 | Tie-breaks by touch distance and demotion of the capital-only variant (`ds` → DS) | `MrFuzzy.touchOrder/demoteCaseVariant` | 1.66 | same in all | S23 |
| S24 | Native engine in C++ (correction search and trigrams), Java as fallback, identical results; ceiling of 12,000 nodes per query | `engine/` (`libmrengine.so`), `MrNative` | 1.77; ceiling 1.77.2 | same in all | `NativeParity` (CI), `NativeFallbackTest` (CI), L3 |
| S25 | Android user dictionary (words added in system settings); only an enabled IME can read it since API 23 | `UserDictionary` (smali) | AOSP | by locale | **no PC test** |

Integrity and robustness checks (same test class): D1 dictionary header and size, D2 the rules sections exist, D3 every correction
points to dictionary words, D4 sentence starters are dictionary words, L1 list size, L2 long words, L3 node ceiling, L4 time per key, L5 no
prediction for an unknown word.

## Not implemented
- Mixed language in the same sentence: one pack is active at a time (slide the space bar to change); there is no second dictionary in the same query.
- Contacts dictionary: no `READ_CONTACTS`, no class. Names of contacts are only learned by typing them.
- Android inline (autofill) suggestions (no `onCreateInlineSuggestionsRequest`) and a spell-checker service (the manifest only declares the IME, the voice helper and the update jobs).
- Emoji suggestions from the typed word.
- `x86_64` native libs (`lib/` has arm64-v8a, armeabi-v7a and x86): a 64-bit x86 emulator or Chromebook has no dictionary reader.

## Limits
| Limit | Value | Where | Effect |
|---|---|---|---|
| Dictionary size | 4,194,304 bytes (22-bit address) | `native/src/dictionary.h`, `engine/src/mr_fuzzy.cpp`, `MrFuzzy.java`, `build_dict.py` | the three packs use 88–90% of it |
| Suggestions per query | 12 (`Suggest.mPrefMaxSuggestions`, settable 1–100) | `Suggest.smali` | list = typed word + up to 12 |
| Words per native query | 18 (`MAX_WORDS`), 16 alternatives per letter | `BinaryDictionary.smali` | |
| Bigrams per word | 60 | `BinaryDictionary`, `MrPredict.MAX_BIGRAMS` | |
| Word length | 48 in the dictionary and re-correction; 32 in `ExpandableDictionary` (learned and user words) and `APPROX_MAX_WORD_LENGTH`; 30 in recent words | smali, `MrRecent` | |
| Correction search | typed 3–20 letters, 5 results, 12,000 nodes | `MrFuzzy` | longer typed words get completions only |
| Prediction | 3 shown, text read before the cursor 96 chars, 248 candidates | `MrPredict` | |
| Recent words | 96 terms, 3–30 letters | `MrRecent` | |
| Re-correction reach | 1000 chars each side of the cursor | `MrRecorrect` | |
| Strip | 3 slots drawn (`CandidateView.mrLayout`); `MAX_SUGGESTIONS` 32 is the old scrolling-strip size | smali | the 12 of `Suggest` are not all visible: the strip shows 3 |

By Android version (minSdk 26, targetSdk 37):
- 26: `IME_FLAG_NO_PERSONALIZED_LEARNING` exists, so the "do not learn" flag works from the minimum version.
- 23+: only an enabled IME or spell checker can read the user dictionary, so the `READ_USER_DICTIONARY` entry in the manifest is not needed (and no runtime request is made).
- 26–30: re-correction reads the word with `EditingUtil.getWordAtCursorOrSelection` (separate reads before/after the cursor); 31+: one `getSurroundingText` snapshot.
- 35+/16 KB pages: both libs link with `-Wl,-z,max-page-size=16384`.
- 37: no change that touches suggestions (the notes of 1.83.0 only mention the local-network permission for the AI editor).
- Nothing in the framework caps the number of suggestions of an IME that draws its own strip: every limit above is the app's own constant.

## Known gaps
Each one has a case marked `GAP` in `StrategyTest`; when the case starts to pass, the test says `FIXED` and the marker comes off.
- **News-biased frequencies and pairs** (all languages): after `tudo` the strip shows que/o/isso, not bem; after `muito`, tempo/bem/mais, not obrigado; en `how` → much/to/many; es `por` → el/la/qué. Chat words rank low: pt `tá` (rank 30 thousand), `tô` (57 thousand), `né` (49 thousand), `oi` (38 thousand); es `hola` has frequency 78 and loses to `bola`/`golazo` (`gola`).
- **Context is dropped after the 1st letter** (all languages): `Suggest` asks for the previous word's bigrams only when 1 letter is typed, so on everyday sentences the hit rate falls from 1 to 2 letters (pt-BR 58.9% → 48.5%, en-US 58.3% → 51.6%, es 50.0% → 37.7%; `docs/tools/e2e/run_subtitle_eval.sh`). A prototype that keeps the context gives 68.0 / 67.5 / 57.5% at 2 letters. Fix planned in `plan-suggestions.md` (item 1.1).
- **A wrong word that is another valid word** is not searched: pt `cassa`, en `fone`, es `ombre`.
- Chat words and apps missing: pt `flw`, `whatsapp`/`pix`/`uber`/`ifood` (as words), es `pa`, `wasap`, en `tiktok`. `vis-a-vis` is the target of a correction (`visavis`) but is not in the en-US dictionary.
- A wrong first letter that is not a neighbour or phonetic pair is not found (`MrFuzzy.firstLetters`).
- When the editor does not give the text before the cursor, `MrText.atSentenceStart(null)` answers "start of a sentence" and the strip shows the starters.
