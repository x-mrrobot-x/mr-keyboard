# Suggestion engine and dictionaries: remaining improvements

Updated after 1.87.0. The plan of 1.84.0 to 1.87.0 (context while typing, new everyday data, format v2, the two "My words" screens, the closing) is finished and was deleted; what it delivered is in `suggestion-features.md` and `dictionary-tuning.md`. The numbers come from the PC measurements (`docs/tools/e2e/`, see the `README.md` there) and from the notes of each version (`docs/release-notes/` and the Git history).

## Already done
| Item | What it was | Version |
|---|---|---|
| 1 | Recent words in prediction and when completing (`MrRecent`) | 1.75 |
| 3 | Missing letter in correction (`C_DEL` 60 → 40; middle letter, 2 positions: pt 67 → 87%, en 69 → 78%, es 58 → 80%) | 1.75 |
| 5 | Neighbouring keys in the word reopened by re-correction | 1.75 (and the adjustment of the strip center in 1.76) |
| 4 (part) | Chat words and apps in `rules.txt` (`flw`, `fmz`, `wpp`, `whatsapp`, `uber`, `ifood`, `tiktok`..., WhatsApp spellings in en/es, `visavis` target); the rest needs data | 1.84 (packs pt-BR 5, en-US 4, es 3) |
| 8 | Accuracy test in CI: 133 original everyday sentences per language with a floor per rate (S28), `PacksTest` (75 checks) and `ThreeLangTest` (23) in `mr-checks.yml`; the strategy runner no longer hides failures | 1.84 |
| - | Context kept while typing (`MrPredict.complete`) and the suggestion for a valid word that is probably another (`MrFuzzy.alternative`) | 1.84 |
| 2 | Smoothing of the prediction: trigram, pair and unigram evaluated on the hold-out sentences; the fixed `TRIGRAM_BONUS` is already the best of the variants (a mix of probabilities loses 0.8 to 2.4 points after the space) | phase 5 of the plan, no code change (numbers in `suggestion-features.md`, "Known gaps") |
| 9a | Native engine, stage 1: the correction search and the trigrams in C++ (`libmrengine.so`, repository `mr-engine`), same files, result identical to Java's, with Java as the fallback (the Java copy was removed in 1.87.0, see 9c) | 1.77 (code) and 1.77.1 (lib in the APK); gains measured on the PC, operation validated on the device (speed and memory on the device were not measured) |
| 9c | The Java copy of the correction search and of the trigram reader was removed from the app and from the tests (decided with the owner): the lib is the only engine, loaded when the keyboard opens a dictionary; a device whose lib does not load keeps typing and completing words but has no correction by search and no two-word prediction | 1.87.0 (`native-engine.md`) |

## What remains, from the cheapest to the most expensive

### Small, measurable on the PC
**4. Slang and abbreviations in `rules.txt`.**
- Done in 1.84 for what the dictionaries already know (see "Already done"). The frequency of the chat words (`tá`, `tô`, `né`, `oi`) was fixed by the new pt-BR 6 pack (1.86.1). What is left needs data: words the dictionary lacks (en `tiktok`, pt `pix`).

### Medium
**6. Finger position.**
- The app only receives the order of the neighbouring keys, not the distance (limit noted in 1.66).
- It can be simulated on the PC first (`TouchEval`), but it requires changing `LatinIME` and `PointerTracker`, in smali.

**7. Forgetting over time and managing what was learned.**
- Today the database keeps 10 thousand pairs and deletes 1,000 at once when it fills up.
- It would require changing the database and, perhaps, a screen to see and delete learned words.

### Large
**9b. Native engine, stage 2: new dictionary format.**
- Stage 1 (1.77) already took the trigrams out of the Java heap (7 to 9 MB → ~0 on the heap; 3 to 4.4 MB outside it) and moved the correction search to C++, **without changing the files**.
- What was missing is what only a new format solves: removing the 4 MB limit (22 address bits) of the `.dict` and storing more data per word. **Done in 1.86.0** (format v2, up to 16 MB, see `dictionary-build.md`); storing more data per word is still open.
- It only pays off for new data (for example, Leipzig News 2023): more pairs alone yield little (480 thousand instead of 400 thousand gave only +0.2 to +0.4 point, in 1.6.4). It would require regenerating the three packs and changing the app and the engine together.

**10. Data closer to phone conversation.**
- The dictionaries come from news and Tatoeba.
- The limit is finding a freely licensed chat corpus.

## Gaps that the measurements showed
- **A wrong word that is another valid word** is not corrected (since 1.84 the frequent neighbour is offered in the 3rd slot when the typed word is rare, never replaced: `cassa` → casa). Missing middle letter: 3%; missing 1st letter: 8 to 22% (depending on the language).
- **A 3-letter error that still starts another word** ("coo", "dis") is left uncorrected. Running the search in that case corrected more, but worsened normal typing by 2.8 to 4.8 points; it was discarded in 1.75.
- **Some missing letters** end up in the 3rd or 4th position ("tods" → todas).
- **Mixed language** (Portuguese and English in the same sentence, with both dictionaries downloaded): I have not yet checked in the code how the keyboard behaves.

## Suggested order
1. **Finger position (6)** and **forgetting over time (7)**, if the test on the device shows a need (7 is in phase 2 of the plan: "What the keyboard learned").
2. **New dictionary format (9b)** and **chat data (10)**: phases 3 and 4 of the plan.
