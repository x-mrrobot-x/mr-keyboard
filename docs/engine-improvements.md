# Suggestion engine and dictionaries: remaining improvements

Updated after 1.77.2. The numbers come from the PC measurements (`docs/tools/e2e/`, see the `README.md` there) and from the notes of each version (`docs/release-notes/` and the Git history).

## Already done
| Item | What it was | Version |
|---|---|---|
| 1 | Recent words in prediction and when completing (`MrRecent`) | 1.75 |
| 3 | Missing letter in correction (`C_DEL` 60 → 40; middle letter, 2 positions: pt 67 → 87%, en 69 → 78%, es 58 → 80%) | 1.75 |
| 5 | Neighbouring keys in the word reopened by re-correction | 1.75 (and the adjustment of the strip center in 1.76) |
| 9a | Native engine, stage 1: the correction search and the trigrams in C++ (`libmrengine.so`, repository `mr-engine`), same files, result identical to Java's, with Java as the fallback | 1.77 (code) and 1.77.1 (lib in the APK); gains measured on the PC, operation validated on the device (speed and memory on the device were not measured) |

## What remains, from the cheapest to the most expensive

### Small, measurable on the PC
**2. Smoothing of the prediction.**
- Today the right word shows up among the 3 suggestions after the space in about 18 to 27% of the cases.
- The two-word file uses a fixed bonus (`TRIGRAM_BONUS`); there is room for a better calculation between two words, one word and frequency.
- A prediction evaluator without sessions is missing (`RecentEval` only measures the effect of recent words).

**4. Slang and abbreviations in `rules.txt`.**
- Sizes today: pt-BR ~5 KB, en-US ~7 KB, es ~4 KB.
- It still needs checking what is already covered ("vc", "tbm", "blz", "pq", common typing errors).
- It is cheap, but without real chat text the gain cannot be measured.

**8. Accuracy test in CI.**
- Keep a small, fixed sample of sentences and fail the CI when the hit rate of correction, normal typing or prediction drops.
- Take the chance to move `PacksTest` (63 checks) and `ThreeLangTest` (23) to CI; today they only run by hand. They need the native PC lib, which `mr-native.yml` already builds.

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
- What is missing is what only a new format solves: removing the 4 MB limit (22 address bits) of the `.dict` and storing more data per word.
- It only pays off for new data (for example, Leipzig News 2023): more pairs alone yield little (480 thousand instead of 400 thousand gave only +0.2 to +0.4 point, in 1.6.4). It would require regenerating the three packs and changing the app and the engine together.

**10. Data closer to phone conversation.**
- The dictionaries come from news and Tatoeba.
- The limit is finding a freely licensed chat corpus.

## Gaps that the measurements showed
- **A wrong word that is another valid word** is not corrected. Missing middle letter: 3%; missing 1st letter: 8 to 22% (depending on the language).
- **A 3-letter error that still starts another word** ("coo", "dis") is left uncorrected. Running the search in that case corrected more, but worsened normal typing by 2.8 to 4.8 points; it was discarded in 1.75.
- **Some missing letters** end up in the 3rd or 4th position ("tods" → todas).
- **Mixed language** (Portuguese and English in the same sentence, with both dictionaries downloaded): I have not yet checked in the code how the keyboard behaves.

## Suggested order
1. **Accuracy test in CI (8)**, to protect what has already been gained.
2. **Smoothing of the prediction (2)**, measured on the PC before it goes into the app.
3. **Slang and abbreviations (4)**, after checking what `rules.txt` already covers.
4. **Finger position (6)** and **forgetting over time (7)**, if the test on the device shows a need.
5. **New dictionary format (9b)** and **chat data (10)** only if the format limit or the lack of data becomes a problem.
