# Suggestion engine and dictionaries: remaining improvements

Updated after 1.91.0. The plan of 1.84.0 to 1.87.0 (context while typing, new everyday data, format v2, the two "My words" screens, the closing) and the plan after 1.87.0 (language card and AI formatting, real messages, packs with real data, engine memory, mixed language, finger position, forgetting) are finished and were deleted; what they delivered is in `suggestion-features.md`, `dictionary-tuning.md`, `mixed-language.md`, `finger-position.md` and `native-engine.md`, and the Git history keeps the plans. The numbers come from the PC measurements (`docs/tools/e2e/`, see the `README.md` there) and from the notes of each version (`docs/release-notes/` and the Git history). The device tests of 1.88.0 to 1.91.0 were done by the owner on 2026-11-08.

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
| 6 | Finger position: simulated with `TouchEval`; the distance gains at most 0.1 to 0.7 points, so the app was left as it is (`finger-position.md`) | closed after 1.87.0, no code change |
| 7 (part) | Cleanup of the learned pairs: when the 10,000 are full it deletes the 1,000 least used (ties: the oldest) instead of the 1,000 oldest | 1.91.0 |
| 10 | Data closer to phone conversation: a fourth source (Reddit comments, counts only) in the mix 40 / 15 / 15 / 25, chosen by the acceptance rule (`dictionary-tuning.md`); the language card and AI formatting in "Add words and texts" came in 1.88.0 | 1.89.0 (packs pt-BR 7, en-US 6, es 5) |
| 9b | Dictionary format: v2 in 1.86.0; `trigrams.bin` as MRT2 (mapped, 16-bit ids, offset tables in the file) and the "Dictionary memory" line in 1.90.0 | 1.86.0 and 1.90.0 |
| - | Mixed language: option (d), 151 and 152 common English words added to the pt-BR and es packs (`mixed-language.md`) | 1.91.0 (packs pt-BR 9, es 7) |

## What is not built (on purpose or for later)
**Forgetting over time (7).**
- Not approved by the owner, so not built. The database keeps 10 thousand learned pairs and, since 1.91.0, drops the 1,000 least used when it fills up. The screens to see and delete learned words exist since 1.85 ("What the keyboard learned").
- What the decay would need: a last-use date, which neither learned database keeps; the way would be a new table in `mr_words.db` (no `ALTER TABLE`), counting days of use of the keyboard, not calendar days. Learned words (`auto_dict.db`) are never removed by the keyboard. Design first (what decays, how fast, what never decays, how the user sees and undoes it).

**Mixed language.** Options (a), (b) and (c) of `mixed-language.md` are not implemented; the app code is unchanged. The list of common English words stays at 151 and 152, since the keyboard is for many people.

**Slang and abbreviations in `rules.txt` (4).** Done in 1.84 for what the dictionaries knew. What was left needed data (en `tiktok`, pt `pix`); not rechecked after the real-message data of 1.89.0.

**Engine and packs.**
- A block layout of MRT2 (5.5 to 6.6% of the file at best).
- Using the room freed by MRT2 (about 0.3 MB per pack) for more trigram contexts: needs the sweep and the acceptance rule again.
- More real data of other kinds (the Reddit sample leans to politics, sports and technology, and the gain on SMS-style typing is not measured). If a new real source is found, repeat the sweep before changing the mix.
- The 8 to 14 ms of tables and rules handed to the engine at start (not the trigram indexes, which are about 0.5 ms): the owner decides, from the phone numbers, whether they deserve work of their own.
- Storing more data per word in the dictionary (format v2 allows it; only worth it with new data).

## Decisions kept from the plan after 1.87.0
- **No personal data.** The app is for other people and other languages: the test set of real messages comes from public sources and the recipe is generic per language; the owner's own chats are not used.
- Spanish stays one pack for Spain and Latin America. No other languages are planned beyond pt-BR, en-US and es.
- Size budget per pack: at most 12 MB on disk and 7 MB downloaded.
- AI formatting in "Add words and texts": when a text or file is not in the standard format (`# mr-words 1`) the app always asks whether to send it to the AI, with the option not to send; the answer is not remembered. A file already in the standard format is not asked about.
- The mix of the packs is chosen by the acceptance rule (`dictionary-tuning.md`), not by hand; real messages weigh more than the other sources only as far as the rule allows. Tatoeba was cut from 25% to 15% in the final mix.

## Gaps that the measurements showed
- **A wrong word that is another valid word** is not corrected (since 1.84 the frequent neighbour is offered in the 3rd slot when the typed word is rare, never replaced: `cassa` → casa). Missing middle letter: 3%; missing 1st letter: 8 to 22% (depending on the language).
- **A 3-letter error that still starts another word** ("coo", "dis") is left uncorrected. Running the search in that case corrected more, but worsened normal typing by 2.8 to 4.8 points; it was discarded in 1.75.
- **Some missing letters** end up in the 3rd or 4th position ("tods" → todas).
- **Mixed language** (Portuguese and English in the same sentence, with both dictionaries downloaded): the keyboard uses only the pack of the active language; read from the code and measured in `mixed-language.md`. Option (d) covers the common English words; the rest is not built.
