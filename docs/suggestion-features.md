# Suggestion engine: what is implemented

Living list of every suggestion, correction and prediction feature, per language, with the check that proves it works.
Update it in the same commit that adds, changes or removes a feature. The ids (S1, S2...) are the tags used by
`docs/tools/e2e/StrategyTest.java`; run `bash docs/tools/e2e/run_strategy_tests.sh` to check them all (3 languages, native engine).

Pack counts and sizes in the table below are those of 1.90.0 (pt-BR 8, en-US 7, es 6; the same words, pairs and triples as 1.89.0, the trigram file in the MRT2 layout); the other numbers were measured on 1.86.1. Everyday-language numbers (prediction and completion hit rates on subtitle sentences) are in `dictionary-tuning.md` and come from `docs/tools/e2e/run_subtitle_eval.sh`; a small set of original sentences (`docs/tools/e2e/data/everyday_<lang>.txt`) runs in CI as check S28. "Since" is the version that introduced the feature (from the version notes and the code comments).

## Data per language
| | pt-BR | en-US | es |
|---|---|---|---|
| Pack version (`dicts/<id>/pack.json`) | 9 | 7 | 7 |
| `main.dict` size (limit 4,194,304 in format v1, 16,777,216 in v2; all three packs are v2 since 1.86.1) | 6,259,668 (v2, 37.3% of 16 MB) | 5,836,626 (v2, 34.8% of 16 MB) | 6,380,745 (v2, 38.0% of 16 MB) |
| Words (pt-BR and es include the 151 and 152 common English words of `docs/tools/loanwords/`, pack versions 9 and 7) | 182,099 | 167,446 | 243,438 |
| Word pairs (bigrams, up to 60 per word) | 750,069 | 698,010 | 714,452 |
| `trigrams.bin` (MRT2 since 1.90.0; was MRT1): words / contexts | 36,020 / 267,004 (3,556,058 bytes; MRT1 4,699,986) | 27,576 / 276,228 (3,488,504 bytes; MRT1 4,719,992) | 38,349 / 282,781 (3,779,526 bytes; MRT1 4,929,982) |
| `rules.txt`: corrections (keys are compared without accent: es has 142 distinct) | 230 | 350 | 143 |
| `rules.txt`: phonetic / vowels / groups / silent / extra / one-letter words | 12 / 2 / 11 / 6 / 1 / 3 | 6 / 4 / 4 / 17 / 0 / 2 | 9 / 2 / 6 / 4 / 1 / 5 |
| Sentence starters (`[sentence_start]`) | Eu, Você, Não | I, The, You | No, El, Me |
| Sources | AOSP list, OpenSubtitles2018 pt_br (a 1/64 sample, counts only), Tatoeba, Leipzig `por_news_2024_1M`, Reddit comments (counts only; mix subtitles / Tatoeba / news / Reddit 40 / 15 / 15 / 25%; `docs/tools/corpus/`) | AOSP list, OpenSubtitles2018 en (a 1/128 sample, counts only), Tatoeba, Leipzig `eng_news_2025_1M`, Reddit comments (counts only; mix 40 / 15 / 15 / 25%; `docs/tools/corpus/`) | AOSP list, OpenSubtitles2018 (a 1/64 sample, counts only), Tatoeba, Leipzig `spa_news_2024_1M`, Reddit comments (counts only; mix 40 / 15 / 15 / 25%; `docs/tools/corpus/`) |
| Keyboard layout in tests | `qwertyuiop,asdfghjklç,zxcvbnm` | `qwertyuiop,asdfghjkl,zxcvbnm` | `qwertyuiop,asdfghjklñ,zxcvbnm` |

Files of a pack: `main.dict` (AOSP LatinIME "latest" format, header 200/1 = format v1, or 200/2 = format v2 since 1.86, see "Dictionary format v2" below), `trigrams.bin` (MRT1 until 1.89, MRT2 since 1.90.0, continuations after two words; "trigrams.bin layouts" below),
`rules.txt` (format 1), `NOTICE.txt`. The pack is downloaded in *Settings → Suggestions and dictionaries*; one language is active at a time.

## trigrams.bin layouts (1.90.0)
Both are big-endian and told apart by the first four bytes; the app 1.90 reads both, the packs of 1.90.0 are MRT2. The word ids are the same in the two, so the same data gives the same hits in the same order.

| | MRT1 (until 1.89) | MRT2 (1.90) |
|---|---|---|
| Header | `MRT1`, u32 words | `MRT2`, u32 words, u32 records |
| Words | words x (u8 length, UTF-8), in byte order | (words + 1) x u32 start of each word, then (further down) the same (u8 length, UTF-8) block |
| Contexts | `u32 m`, then m x (u24 a, u24 b, u8 k, k x (u24 id, u8 score)) sorted by (a, b) | (words + 1) x u32 "first record of each first word a" (the last is m), then m x 11-byte records (u16 b, 3 x (u16 id, u8 score)); id `0xFFFF` = empty slot, always at the end |
| What the lib builds at open | two index vectors, 4 bytes per word and per context (about 1.2 MB) | nothing: it searches the file itself (binary search of the word, then of `b` inside the row of `a`) |
| Limits | 2^24 words, 255 continuations | **65,535 words, 3 continuations** (the packs never have more; pt-BR: 22.6% of the contexts have 1, 20.8% have 2, 56.7% have 3) |
| Size (pt-BR) | 4,699,986 bytes | 3,556,058 bytes (-24.3%); en-US -26.1%, es -23.3% |

- **Why fixed slots and not something denser.** The plan listed ids in fewer bytes, delta-coded context ids and 2 continuations when the first dominates. Measured on the real files: ids in 16 bits and the row table remove most of the bytes. Records sized by their number of continuations (5, 8 or 11 bytes) would take 18 to 19% fewer record bytes (pt-BR 528 KB), but then a binary search needs either an offset per record (4 bytes each: 1.07 MB in pt-BR, more than the saving) or a block index plus a length byte per record, which leaves 5.5 to 6.6% of the file (194 to 250 KB) for a lookup that is no longer a plain binary search; a delta code of the context ids cannot be binary-searched at all without such a table. Fixed 11-byte records keep the lookup a plain binary search with no index, so they were kept; the block layout stays an option if the size is ever the limit again. Dropping the third continuation when the first dominates would change the suggestions, so it was not done.
- **Checking.** At open the lib checks everything that is O(words): the size (the word section must end exactly at the end of the file), the offsets, the strict byte order of the words and the row table. The records (the big part) are checked when they are read: an id outside the vocabulary or an empty slot before a filled one ends the list there, a `b` is only compared. `TriStore::verifyAll()` checks every record (tests and tools). MRT1 is still checked whole at open.
- **mmap.** `TriStore` maps the file read-only (`MADV_RANDOM` on the records) instead of copying it to the heap; if `mmap` fails it reads the file into the heap and nothing else changes. **The rule that makes this safe: a pack file is never rewritten or truncated in place.** `MrPacks.install` writes `<id>/<version>.tmp`, renames it to `<id>/<version>` and deletes the old version folder with `unlink`, which keeps the mapped inode alive until the lib closes it. Anything new that writes a pack file must do the same. `engine/test/mr_test.cpp` swaps a pack with the file open (delete + rename, and replace by rename) and reads every context after that.
- **Tools.** `docs/tools/mrt_format.py` (readers and writers, strict), `docs/tools/convert_trigrams.py to2|to1|same|info`, `make_pack_data.py --tri-format 2`, `make_trigrams.py --format 2`; tests: `docs/tools/test_mrt_format.py` and the `triFormats`/`triSwap`/`tinyMrt2` parts of `mr_test`. Three readers written apart (C++ engine, the C++ test, Python) agree on every context. `make_catalog.py` refuses MRT2 in a pack with `minApp` below 1090000 and validates it with the strict reader.
- **Measured on the PC** (`mr_test`, warm cache, 100,000 lookups of real contexts): open 2.9-3.2 ms -> 0.4-0.5 ms; heap taken by the indexes 1.2 MB -> 0; lookup 0.92-1.03 us -> 0.70-0.77 us; about 550,000 queries per language (every context with the spellings the app tries, plus 40,000 random pairs) identical in both layouts and to a from-scratch oracle. On the phone, the owner read the "Dictionary memory" line and validated 1.90.0 on 2026-11-08 (the numbers were not recorded in the repository).
- **The line "Dictionary memory"** (*Settings → Suggestions and dictionaries*, under "Suggestion engine"; `MrDiag`): for the language in use it shows the size of `main.dict` and of `trigrams.bin` (and the MRT format), how much of each is in memory now, the time the last opening took and the time the engine took to start (library + tables) and to receive the rules. "In memory" is the Pss of the mappings of that file in `/proc/self/smaps`: pages of a clean file that the system keeps and can drop, not heap of the app; a file that was read to the heap (no `mmap`) would show 0 there. If `smaps` cannot be read the line says so. The times are measured by `MrNative.load`, `MrPacks.open` and `MrTrigram.open` (last opening wins; the first opening after a reboot is the cold one).

## Strategies
All of them are in the three languages unless the last column says otherwise. "Where" is the class or file that does it.

| Id | Strategy | Where | Since | Per-language detail | Check |
|---|---|---|---|---|---|
| S1 | Completion of the typed prefix, ignoring accent and case | `libjni_pckeyboard.so` (`native/`) + `Suggest` | AOSP; initials with accent/capital 1.60 | same in all | `StrategyTest` S1 |
| S2 | Neighbouring key (the touch's neighbours, in order of distance: costs 25 / 30 / 35) | lib + `MrFuzzy` (`C_PROX_1/2/FAR`) | 1.60; by distance 1.66 | same in all | S2 |
| S3 | Map of common errors and chat abbreviations (`vc`, `tbm`, `dont`, `xq`), case kept (`Vc` → `Você`) | `MrFix`, `[corrections]` | 1.60; per pack 1.63 | 228 / 350 (contractions) / 143 | S3 |
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
| S16 | Learning: words and pairs you use (`AutoDictionary`, `UserBigramDictionary`); never in a password field or with `IME_FLAG_NO_PERSONALIZED_LEARNING` | `LatinIME.checkAddToDictionary` (smali) | AOSP; always on with suggestions since 1.60 | per locale; since 1.85 a learned word also completes what is typed once it is accepted (frequency 6); since 1.91 the learned pairs, when they pass 10,000, lose the 1,000 least used (ties: the oldest) and not the 1,000 oldest | the database needs Android; `test_prune_order.py` runs the cleanup in SQLite with the tables and the query read from the smali; S29 tests the completion |
| S17 | Recent words of this conversation: completion (2), prediction bonus, recent pairs; memory only, cleared when the field or app changes | `MrRecent` | 1.75 | same in all | `RecentTest` (CI) |
| S18 | Sentence starters at the start of the text or after `. ! ? … ¿ ¡` | `MrPredict.list`, `MrText.atSentenceStart` | 1.62; `¿ ¡` 1.65 | 3 words per language | S18 |
| S19 | Careful autocorrection: replaces on its own only a map entry, or within 1 error (up to 5 letters) / 2 errors (longer), accent and case ignored; never a suggestion with a space outside the map | `MrFuzzy.finish/confident` | 1.62; touch half-error 1.66 | same in all | S19 |
| S20 | A valid word is never searched or replaced; capital letters kept | `MrFuzzy.afterWords` | 1.60 | same in all | S20 |
| S21 | A cheap correction keeps a slot among the 3 shown even when the completions are many (`deposi` → depois; `prota` → porta until pt-BR 5) | `MrFuzzy.finish` (`RESERVE_MAX_COST` 45) | 1.62 | same in all | S21 |
| S22 | Re-correction of the word under the cursor, with the neighbour keys of the on-screen keyboard; API 31+ reads one snapshot with `getSurroundingText` | `MrRecorrect` | 1.74; neighbours 1.75 | same in all | `RecorrectTest` (CI), S22 |
| S23 | Tie-breaks by touch distance and demotion of the capital-only variant (`ds` → DS) | `MrFuzzy.touchOrder/demoteCaseVariant` | 1.66 | same in all | S23 |
| S24 | Native engine in C++ (correction search and trigrams), the only search since 1.87.0 (before: Java fallback with identical results); ceiling of 12,000 nodes per query; without the lib there are no results and no exception | `engine/` (`libmrengine.so`), `MrNative` | 1.77; ceiling 1.77.2; Java copy removed 1.87.0 | same in all | the whole `StrategyTest` runs through it (CI), `NoLibTest` (CI), `mr_test` (native workflow), L3 |
| S25 | Android user dictionary (words added in system settings); only an enabled IME can read it since API 23 | `UserDictionary` (smali) | AOSP | by locale | **no PC test** |
| S26 | Context while typing: from the 2nd to the 12th letter the 2 best candidates of the previous words' context (dictionary pairs, trigrams, your pairs, recent pairs) that start with what is typed join the list, scored above plain completions (`CTX_FREQ` 255, minus `CTX_STEP` 40 per rank) | `MrPredict.complete`, called from `MrFuzzy.afterWords` | 1.84 | same in all | S26, S28 |
| S27 | A valid word that is probably another word (`cassa` → casa): when the typed word is valid but rare (frequency ≤ `ALT_TYPED_MAX` 80, above `ALT_OFFENSIVE_FREQ` 5) and a word within cost 40 is at least 60 more frequent (and ≥ 110), it takes the 3rd slot as a suggestion; never a replacement (autocorrect stays off for a valid word). Since 1.85, when the previous words also confirm the alternative (it is one of the context's candidates and the typed word is not: `quase semper` → sempre; `eu aida` → ainda until pt-BR 5) it takes the **center** slot and what was there moves to the 3rd (`ALT_CTX_FIRST`); the typed word stays first | `MrFuzzy.validAlternative/alternative/finish`, `MrPredict.inContext` | 1.84; center 1.85 | same in all | S27 |
| S29 | Words and texts you add, and what the keyboard learned: an added name completes while typing (weight 50: one of the 2 suggestions after 3 letters in about 9 of 10 cases, after 4 nearly always; weight 100: from 2 letters), counts as a valid word (never corrected into another), an added pair shapes the next-word prediction, a blocked word never shows and is never learned; a learned word completes only from frequency 6. Weight 1-100 → word frequency 6-250 (`MrLearned.WORD_FREQ_AT_50` 130) and pair frequency 4-9 (score 80-127 on the user-pair scale) | `MrLearned`, `MrImport`, `AutoDictionary`/`UserBigramDictionary` hooks and the `mAutoDictionary` lookup in `Suggest.getSuggestions` (smali), the screens `MrLearnedActivity`/`MrImportActivity` | 1.85 | same in all | S29 (16 checks per language), `ImportTest`, `LearnedStoreTest` (CI) |

Integrity and robustness checks (same test class): D1 dictionary header and size, D2 the rules sections exist, D3 every correction
points to dictionary words, D4 sentence starters are dictionary words, L1 list size, L2 long words, L3 node ceiling, L4 time per key, L5 no
prediction for an unknown word, S28 hit rates on original everyday sentences (known words, after the space, after 1, 2 and 3 letters) over their floors.

Other tests in CI: `packs_test/run_packs_tests.sh` (the dictionary download flow with a signed
test catalog, and the three installed languages), `run_java_tests.sh` (the Java layer). The speed of the strip is measured by hand with
`docs/tools/e2e/SpeedEval.java` (see "Speed" below), the false positives of S27 with `AltEval.java`, how often the center promotion is right or wrong with `PromoEval.java` and the weight → frequency calibration of S29 with `ImportEval.java`.

## Strip or tools in the row
The toolbar row (`bar_main`) holds the tools and the strip, one at a time. `MrSugg` decides which, from what the person is doing.
- **The grid key** (`MrTools.toggleBar`) depends on what is in view: with a **tool open** (a header beside the row, or the AI Editor or Customize dialog) it **closes
  the tool** as its back button does (`MrTools.closeTools`: `leave(true)` for the translator, `MrTune.close`, `MrAiDialog.dismiss`, `showPanel(0)` for the panels, whose hooks
  end Fonts, the emoji search, the attachments and the emojis, so nothing stays in memory) and the tools take the row; with the **strip in view** the tools take the
  row (`MrSugg.toTools`, they stay until the next typing); only **with the tools in view** (or the row hidden) it shows or hides the whole row (`MrTools.sBarOn`).
  `test_grid_key.py` runs the real smali of `MrTools` and `MrSugg` together.
- **Typing shows the strip.** A list of the word being typed, corrected or swiped (`LatinIME.setSuggestions` with `mPredicting`, a re-correction or the preview of a
  gesture: `MrSugg.onList(has, true)`) clears the "tools came back" state and shows the strip at once. Only with the row visible and no tool using it
  (`MrTools.applyMain`): it never takes the place of a tool in use, such as the translator.
- **The tools come back after the word ends.** When the list of the next word arrives (space, a suggestion picked, the "tap to save" hint) and the strip is
  on screen, a debounce starts: `pref_sugg_idle` seconds (Settings > Suggestions > "Show tools after typing": off, 1, 2, 3 by default, 5, 8, 10). Another
  end of word restarts it; typing cancels it; when it runs out the tools take the row (`MrSugg.sIdle`) and stay until the next typing. It never counts under a
  tool or with the row hidden (`MrSugg.stripShown`). The initial suggestions (Você, Eu, Não: start of the field, after a punctuation mark, after a paste or a
  cursor move) are lists of the next word like any other and follow the same rule. Two things used to keep them on the strip for ever, both fixed:
  `TextEntryState` still said "correcting" after a re-correction (it is only reset by typing), which made `setSuggestions` call such a list "typing";
  now `setNextSuggestions` marks its lists (`LatinIME.mMrNext`) and they are never typing. And a strip that came into view without a new list (created after
  the list, or the row shown again by the grid key) had no debounce started: `MrSugg.rearm` starts it (called by `MrSugg.host` and `MrTools.toggleBar`) when the
  list in view is not of a word being typed. Left alone on purpose: the list of the word being typed (the person is in the middle of it) and the alternatives of
  a word chosen for re-correction (the person is choosing; the word stays marked until they pick or leave).
- **No suggestions at all** (an empty list while the strip was shown): the strip stays 1 s (`HOLD`) before the tools come back, so a list that empties for an
  instant does not blink the row.
Checks: `test_sugg_idle.py` (the real smali of `MrSugg` in the mini Dalvik interpreter with a fake handler and clock).

## When the suggestions stop
The strip, the dictionary search, the next-word search and the re-correction of the word under the cursor (`LatinIME.updateSuggestions`,
`setNextSuggestions`, `setOldSuggestions`, `postUpdateOldSuggestions`) do not run, and the strip is emptied, while `LatinIME.suggestionsSuspended` is true:
- **A tool is using the toolbar row** (`MrTools.rowOwned`: a header beside `bar_main` is visible: clipboard, translator, attachments, emojis, Customize,
  Fonts, emoji search). The rule of the row: while a tool uses it nothing else shares it, so the strip never sits above a tool's header
  (`MrTools.applyMain` keeps `bar_main` hidden) and no work is done for a strip nobody sees.
- **A font style is on** (`MrFonts.styleOn`: a style chosen, even with the tool closed, in a field that takes it). The typed text is made of look-alike
  Unicode letters, which are no word of the dictionary: the search would only give nothing. Fields that take no style (password, e-mail, web address,
  number) keep the suggestions.
Before a styled letter is written, `LatinIME.mrEndWord` lets go of the word the keyboard still holds (the typed one and a word reopened by the
re-correction): `commitText` replaces the composing text, and the styled letter used to erase the word before it (the superscript, small caps, subscript,
full width and the five styles made of marks, whose words the re-correction accepts, as the other styles are made of letters it ignores).
A suggestion picked for a word the re-correction reopened (`LatinIME.pickSuggestionManually`, `mrAfterWord`) is judged by what follows the word once it is
written, wherever it was tapped: nothing after it (end of the text), or a lone space and then the end of the line, and the person goes on writing, so the pick
adds the space and shows the next words, as in typing (a space that is already there is taken over and the cursor ends after it; with the automatic space off
nothing is touched). With more text after the word (a word corrected in the middle of a line) there is no space and the word is offered again, as before. Checks: `test_suggestions_suspended.py` (the real smali of those methods, in the mini Dalvik
interpreter), `test_toolbar_row.py` (the rule of the row), `FontsTest` (the word is let go before every one of the 27 styles).

## The two screens (1.85)
Both are in *Settings → Suggestions and dictionaries → My words*, built in Java like `MrPacksActivity` (plain framework views, the `mr_ui_*` palette, strings in the three languages), with no network code.
- **What the keyboard learned** (`MrLearnedActivity`): per language (chosen on a select card since 1.88, see below), tabs **Learned** / **Added** / **Blocked**, a switch between words and pairs, search, sort by most used or newest, pages of 50 with "Show more". A row opens **Fix** (delete + add), **Block this word**, **Forget** (and **Allow again** on the blocked tab). Menu: delete the whole list (with a confirmation), **export a copy** (`ACTION_CREATE_DOCUMENT`, a `.txt` in the standard format below: it is also the backup, because `auto_dict.db`/`userbigram_dict.db` are not in the backup rules), and a button to add words.
- **Add words and texts** (`MrImportActivity`): paste, open a file (`ACTION_OPEN_DOCUMENT`, at most 8 MB, UTF-8 with or without BOM, or Windows-1252 when the bytes are not valid UTF-8: `MrImport.decode`) or type; choose the language on the select card; a **preview before saving** (new words with a checkbox each, pairs, words the dictionary already knows left out, ignored lines with the reason); **Undo the last import** (one level, kept in the `mr_words` preferences); **Format with AI** (1.88, below) and **Copy instructions for an AI** (the prompt for a chat of the person's choice, translated). Free text rules (`MrImport`): URLs, e-mails, numbers, chat prefixes (`[12/03/24 14:05] Ana:`, `12/03/2024 14:05 - Ana:`), laughs and repeated letters, words over 32 letters are dropped; a word is added only if the main dictionary does not know it and it appears twice (once when written with a capital in the middle of a sentence); a pair needs both words valid and two occurrences. The list needs the dictionary of that language installed (the screen asks to download it first).
- **Language card (1.88)**: `MrKit.select(title, value, listener)` draws the card (title small, chosen value, arrow) and `MrKit.languageCard` opens the single-choice list (`setSingleChoiceItems`, the same dialog as the settings) and calls back only when the choice changes. The two screens use it instead of the chips. `MrLang` holds the rules: `offered` (installed packs first, then any language with data, then pt_BR, en_US and es when there is nothing), `pick` (the choice already made on the screen, else the last one made on either screen, else the language of the UI, else the first) and the last choice in the `mr_words` preferences (`lang_last`; `last_locale` is the language of the last import, kept for the undo). A screen remembers the language it opens on, and "What the keyboard learned" follows the last choice when it comes back from the other screen, so words added for another language are shown. Export and Delete all act on the language shown. `MrPacksActivity` is a list of packs, not a selector, and has no card.
- **Format with AI (1.88)**: a button on "Add words and texts" turns a text without the standard format into the standard list using the service of the AI Editor settings. `MrAi.complete(context, system, user, temperature)` is the one request (the same code that `rewrite` uses); `MrImportAi` is plain Java (the request is an interface, so the PC test uses a fake). Order: `MrImport.scrub` takes out links, e-mails, phone numbers, numbers of 4 or more digits and the date and author at the start of a chat line; `MrImportAi.plan` cuts the text into parts of 6,000 characters (line or sentence ends; the first 2,000,000 characters are looked at; at most 40 parts, and `truncated` says so); the screen asks (host of the service, characters, requests, a stronger line above 12 requests and another when the text is cut) with *Send* and *Don't send*; `MrImportAi.run` makes one request per part at temperature 0.2, stops at a failure of the service and keeps what already came back, skips an answer that is not a list, and can be cancelled (also when the screen closes); every answer is read line by line (introduction, code fence, bullets, numbering, `word 70`, a literal `\t`, weights above 100 clamped), each line is checked with `MrImport.checkWord`, phrases need 2 to 5 words and no final punctuation, repeated lines are joined (the larger weight stays), `[blocked]` and unknown sections are dropped, and the list is written with our header and the tag of the language chosen on the card. The result replaces the text in the box (or the opened file) and **Undo formatting** brings the previous text back (it disappears when the person edits the box). The result then goes through the usual preview: nothing is saved without it. The question is asked when a file that is not in the standard format is opened (only when the AI Editor has a key; the answer is not remembered); a standard file is never sent. The system prompt tells the model that the text is data, not instructions.
- **Standard list** (`# mr-words 1`): sections `[words]` (a word, optional TAB and a weight 1-100), `[phrases]`, `[blocked]`; `[shortcuts]` is not supported yet (the line is reported as ignored). `# language:` is a hint.
- **Storage** (`MrWordStore`): learned data stays in `auto_dict.db` and `userbigram_dict.db` as before; added words, added pairs and blocked words live in their own database `mr_words.db` (`MrSqlStore`; `MrMemStore` is the PC test twin), so the old databases did not need an `ALTER TABLE` and an upgrade from 1.84 loses nothing. Caps: 20,000 added words and 30,000 added pairs, which the cleanup of learned pairs (10,000, 1,000 at a time) never touches. After any change `MrLearned.changed(Context)` writes `mr_dicts_updated_at` and `LatinIME` reloads the user dictionaries at the next `onStartInputView`.
- **What changed in the engine for it**: `Suggest.getSuggestions` now also asks `mAutoDictionary` for completions (before 1.85 it was only used by `isValidWord`, so a learned word never completed); `AutoDictionary.getWords` lets through only words from frequency 6 (`MrLearned.gate`); blocked words are removed at the end of `MrFuzzy.finish` and are not learned (`checkAddToDictionary`).
- **Gesture typing (1.96.0)**: the same words reach the gestures. `MrGestureWords` copies the learned words (from frequency 6), the added ones and the user dictionary of Android into a small dictionary that the gesture search reads after `main.dict`, and a blocked word is never written by a gesture nor offered among its candidates. `ExpandableDictionary.addWord` and `clearDictionary` and `MrLearned.refreshBlocked` tell it that something changed. The learned and added **pairs** are not used by the gestures. Details and measurements: `docs/gesture-typing.md`.
- **Cost**: a full list (20,000 words and 30,000 pairs) takes about 5 MB of the Java heap; the keystroke time did not move (see "Speed").

**Device checklist 1.88** (done by the owner on a device, 2026-11-08): open the card on both screens and pick each language (the other screen opens on it; rotate the phone with the list open); format a short note with a real AI service and check the box, the note below it and Undo formatting; open a text file (not a list) with the AI set up and answer *Don't send*, then again and answer *Send*; open a file already in the format (no question); try the button without a key (the notice leads to the AI settings and back); cancel in the middle of a text of several parts; turn on airplane mode in the middle (the parts that came back stay); a text of 100 KB or more (the number of requests in the question); the AI Editor privacy line.

**Device checklist 1.91** (the pair cleanup; done by the owner on a device, 2026-11-08): type for a while and watch the keyboard still suggest and the pairs tab still list what you typed (the query is new); to see the cleanup itself, fill a copy of `userbigram_dict.db` with 10,100 pairs (rows in `main` and in `frequency`, the first 50 with frequency 127 and the rest with 2), put it in the app's data and type a few sentences: afterwards the 50 old pairs must still be in the pairs tab, the total about 9,100 and the keyboard must not have stopped for more than a moment; measure the time of the query with 11,000 pairs.

**Device checklist** (the SQLite store and the screens need Android, the PC tests use `MrMemStore`): update over 1.84 keeps the learned words; forget a word and watch it leave the strip at once; block a word and type it (it must not be suggested nor learned again); import a list of 5,000 words, then check the opening time of the keyboard and the heap; export on one phone and import on another; rotate the screen during an import and during the preview; open the screens with the dictionary of the language not installed; a password field still learns nothing; undo the last import; delete a whole list.

## Dictionary format v2 (1.86)
The header of `main.dict` is `200` plus a byte that names the format: `1` = **v1** (the AOSP "latest" format; the readers also accept `0`, the same layout, but `MrPacks.dictHeaderOk` and `make_catalog.py` only accept `1` in a pack), `2` = **v2**. The readers (`native/src/dictionary.cpp` for `libjni_pckeyboard.so`, `engine/src/mr_fuzzy.cpp` for `libmrengine.so`, the app's Java only looks words up with `MrFuzzy.lookup`, which takes the width the same way) take the address width from the header once and read both formats.

| | v1 | v2 |
|---|---|---|
| Address of a group of children / of a bigram target | 6 bits of the flags byte + 2 bytes (22 bits) | 6 bits of the flags byte + **3 bytes** (30 bits) |
| Bigram entry | 4 bytes (3-byte address + frequency/continue flag) | 5 bytes |
| Size limit applied (`MrPacks.dictHeaderOk`, `make_catalog.py`, `build_dict.py`) | 4,194,304 | 16,777,216 |
| Same content as v1 (the packs of 1.86.0) | 3,708,011 / 3,758,547 / 3,792,609 (pt-BR / en-US / es) | 4,423,351 / 4,484,792 / 4,473,361 (+18 to +19%) |
| `pack.json` | `format: 1` | `format: 2`, `minApp: 1086000` |

- **Old apps**: `MrPacks.appTooOld` treats a format above its own `PACK_FORMAT` (or a `minApp` above the app) as "needs a newer version of the app" and keeps the installed pack. The catalog format is still 1.
- **All three packs are v2 since 1.86.1** (es 4, pt-BR 6, en-US 5: none of them fits the 4 MB of v1). `python3 -I docs/tools/make_v2_dicts.py <out>` still writes a copy of the folder in the format v2 for the tests (for a pack that is already v2 the copy is identical in content).
- **Build and convert**: `build_dict.py in.combined.gz out.dict [--format 1|2]` (default 1), `build_dict.py --convert in out [--format 2]` and `--dump in words.tsv bigrams.tsv` (see `dictionary-build.md`). Converting v1 → v1 gives the same bytes as the shipped file.
- **Checks**: `docs/tools/dict_readback.sh <dict_test> [dicts]` (every word and every pair read back by the real C++ reader), `docs/tools/dict_v2_test.py` (14 checks on a synthetic 14 MB dictionary, about 2 minutes), `mr_test` and `mr_bench` on v1 and v2 files (plain and under ASan/UBSan, including damaged files), `run_strategy_tests.sh` with `DICTS=<folder of v2 copies>` (until 1.86.1 also `run_native_parity.sh`), `PacksTest` (fixture v8) and `test_make_catalog.py`.
- **Memory**: `MrPacks.open` maps the file (`MappedByteBuffer`), so a bigger dictionary takes no Java heap.
- **Device checklist (not testable on the PC)**: install a v2 pack on 1.86 and on a 1.85 app (the old app must say it needs a newer version and keep working); opening time of the keyboard and the first suggestion with a pack close to 16 MB on a low-end phone; switching languages between a v1 pack and a v2 pack.

## Not implemented
- Mixed language in the same sentence: one pack is active at a time (slide the space bar to change); there is no second dictionary in the same query.
- Contacts dictionary: no `READ_CONTACTS`, no class. Names of contacts are only learned by typing them.
- Android inline (autofill) suggestions (no `onCreateInlineSuggestionsRequest`) and a spell-checker service (the manifest only declares the IME, the voice helper and the update jobs).
- Emoji suggestions from the typed word.

## Limits
| Limit | Value | Where | Effect |
|---|---|---|---|
| Dictionary size | format v1: 4,194,304 bytes (22-bit address); format v2 (1.86): 16,777,216 bytes (`DICT_MAX_V2`) | `native/src/dictionary.cpp`, `engine/src/mr_fuzzy.cpp`, `MrFuzzy.java`, `MrPacks.dictHeaderOk`, `build_dict.py`, `make_catalog.py` | the three shipped packs are v1 and use 88–90% of it; the same content in v2 takes 4.4 to 4.5 MB |
| Suggestions per query | 12 (`Suggest.mPrefMaxSuggestions`, settable 1–100) | `Suggest.smali` | list = typed word + up to 12 |
| Words per native query | 18 (`MAX_WORDS`), 16 alternatives per letter | `BinaryDictionary.smali` | |
| Bigrams per word | 60 | `BinaryDictionary`, `MrPredict.MAX_BIGRAMS` | |
| Word length | 48 in the dictionary and re-correction; 32 in `ExpandableDictionary` (learned and user words) and `APPROX_MAX_WORD_LENGTH`; 30 in recent words | smali, `MrRecent` | |
| Correction search | typed 3–20 letters, 5 results, 12,000 nodes | `MrFuzzy` | longer typed words get completions only |
| Context while typing | 2nd to 12th letter, 2 candidates | `MrPredict` (`CTX_MAX_LETTERS`, `CTX_MAX`) | a longer word is completed by the dictionary alone |
| Alternative for a valid word | typed 3–12 letters, frequency 6–80, cost ≤ 40, gap ≥ 60, alternative ≥ 110 | `MrFuzzy` (`ALT_*`) | tuned with `AltEval` (false positives 0.3% weighted, hit 46–58%) |
| Prediction | 3 shown, text read before the cursor 96 chars, 248 candidates | `MrPredict` | |
| Recent words | 96 terms, 3–30 letters | `MrRecent` | |
| Learned pairs (1.91) | 10,000; over that, the 1,000 least used go (`ORDER BY freq ASC, _id ASC`) | `UserBigramDictionary$UpdateDbTask.checkPruneData` (smali) | `test_prune_order.py`; the learned words (`auto_dict.db`) have no cap and are never removed by the keyboard |
| Added words and pairs (1.85) | 20,000 words, 30,000 pairs; 8 MB per file; a word of 2–32 letters, 30 words per phrase | `MrLearned` (`IMPORT_MAX_*`), `MrImportActivity`, `MrImport` | more is reported as "left out because the list is full" |
| Weight of an added word | 1–100 → frequency 6–250 (50 → 130); pair 4–9 | `MrLearned` | measured with `ImportEval`; a learned word completes from frequency 6 |
| Pack format | `pack.json` `format` 1 or 2; 2 needs `minApp` ≥ 1086000 (`MrPacks.PACK_FORMAT` 2) | `MrPacks`, `make_catalog.py` | an app older than 1.86.0 keeps the v1 pack it has and says the pack needs a newer app |
| Re-correction reach | 1000 chars each side of the cursor | `MrRecorrect` | |
| Strip | 3 slots drawn (`CandidateView.mrLayout`); `MAX_SUGGESTIONS` 32 is the old scrolling-strip size | smali | the 12 of `Suggest` are not all visible: the strip shows 3 |

By Android version (minSdk 26, targetSdk 37):
- 26: `IME_FLAG_NO_PERSONALIZED_LEARNING` exists, so the "do not learn" flag works from the minimum version.
- 23+: only an enabled IME or spell checker can read the user dictionary, so the `READ_USER_DICTIONARY` entry in the manifest is not needed (and no runtime request is made).
- 26–30: re-correction reads the word with `EditingUtil.getWordAtCursorOrSelection` (separate reads before/after the cursor); 31+: one `getSurroundingText` snapshot.
- 35+/16 KB pages: both libs link with `-Wl,-z,max-page-size=16384`.
- ABIs: `lib/` has arm64-v8a, armeabi-v7a, x86 and (since 1.84) x86_64, both libs in each; `mr-apk.yml` refuses to publish if any is missing. A 64-bit-only x86 emulator image or Chromebook now has the dictionary reader.
- 37: no change that touches suggestions (the notes of 1.83.0 only mention the local-network permission for the AI editor).
- Nothing in the framework caps the number of suggestions of an IME that draws its own strip: every limit above is the app's own constant.

## Known gaps
Each one has a case marked `GAP` in `StrategyTest`; when the case starts to pass, the test says `FIXED` and the marker comes off.
- **News-biased frequencies and pairs**: **Fixed for Spanish in 1.86.1 (es 4, subtitles + chat + news)**: `gola` → hola, `bamos` → vamos, `ombre` → hombre, `vam` → vamos, `gr` → gracias and `por` → favor are no longer gaps. Still open in es: `hola _` → cómo (chicos/a/cariño), `por favor _` → me, `ho` → hola, `es` → estoy. **Fixed for Portuguese in 1.86.1 (pt-BR 6)**: `tudo _` → bem, `to` → tô and `pr` → pra are no longer gaps, and the chat words moved up in the frequency list (`tá` from rank 30 thousand to 811, `tô` 57 thousand → 4,092, `né` 48 thousand → 2,004, `oi` 38 thousand → 410). Still open in pt-BR: `muito _` → obrigado (tempo/bem/mais), `eu _` → vou (sei/não/tenho), `tudo bem _` → e, `vo` → vou (the strip has vó/você/vô first). **Fixed for English in 1.86.1 (en-US 5)**: `thank you _` → so, `see you _` → later and `ye` → yeah are no longer gaps. Still open in en-US: `how _` → are (much/to/do win: P(are | how) is about 4%), `good _` → morning (to/at/night), `fone` → phone (a valid word) and `tiktok` → TikTok (the dictionary does not have the word).
- **Prediction smoothing** (phase 5, evaluated and **left as it is**): the strip after the space puts the two-word continuations (`MrTrigram`, score `TRIGRAM_BONUS` 128 + f7) above the one-word ones (f7 of the pair). Both lists store the same quantity (`f7 = 127 x (1 + log10 P / 3)`, P = probability of the word given the context), so the bonus was replaced in an experiment by a mix of the two probabilities (`P = L x P3 + (1 - L) x P2`, back-off for a word that is in only one list, L from 0.3 to 0.85) and by a smaller bonus. Hit among the 3 predictions after the space, `SubtitleEval` on the hold-out sentences that no count has seen (8,000 sentences; en-US subtitles / chat / news, es and pt-BR subtitles): fixed bonus 14.4 / 16.9 / 12.1, es 11.1, pt-BR 13.7; bonus 32: 14.4 / 16.9 / 12.0, es 11.0, pt-BR 13.7; no bonus (the larger of the two): 13.6 / 15.8 / 11.4, es 10.4, pt-BR 13.1; mix of the probabilities: 12.0 to 13.5 in en-US (the more weight on the trigram, the closer to the bonus), 11.3 on en-US news, es 10.3, pt-BR 13.0; ordering only the trigram candidates among themselves with both probabilities: no change (14.4). The reason is in the file: `trigrams.bin` keeps the 3 best continuations of a context, so a word that is not listed has a trigram probability at most equal to the third listed one, and putting the listed ones first is already the right order. The rows with 1 to 3 letters did not move in any variant. A fallback to the most frequent words for the 2.4 to 3.7% of the contexts with no pair at all (the strip shows the punctuation) would win at most a few hundredths of a point and would change what the strip shows after a rare word or a number. What the PC cannot measure is the weight of the user's pairs (`userBigramScore` 40 + 10 x uses, up to 127, added to the dictionary score) and of the recent words: the test texts have no user, so those weights stay as tuned by hand in 1.75 and 1.84.
- **Context after the 1st letter** (fixed in 1.84, S26): the hit rate with 2 letters typed went from pt-BR 48.5% → 73.1%, en-US 51.6% → 70.4%, es 37.7% → 62.1% on the subtitle sentences and, on the original sentences of CI (S28), from 30.5 → 52.7 / 39.1 → 53.7 / 27.3 → 45.4% (more numbers in the Git history of the 1.84.0 plan).
- **A wrong word that is another valid word** (fixed in 1.84, S27): pt `cassa`, en `whee`, es `vece` now get the intended word in the 3rd slot. What stays open: a valid word that is more frequent than the cut (`ALT_TYPED_MAX`), and a valid word whose neighbour is not much more frequent (es `hola`/`bola`).
- Chat words and apps: fixed in 1.84 for pt (`flw`, `fmz`, `wpp`, `whatsapp`, `uber`, `ifood`, `tiktok`...), en and es (`wasap`...) with `rules.txt` entries. Still open and needs data: en `tiktok` (the en-US dictionary does not have the word, and a correction cannot point to an unknown word, also with en-US 5); pt `pix` (not in the dictionary). `visavis` now points to `vis-à-vis`, which the dictionary has.
- **Center promotion** (1.85, `PromoEval` on 10,000 subtitle sentences per language): among the errors that are another valid word the right word reaches the center in 50.0% (pt-BR), 30.2% (en-US) and 55.2% (es) of the cases, stays in the 3rd place in 10.5 / 4.3 / 7.3% and a wrong word is promoted in 2.2 / 3.0 / 3.2%; among correctly typed words 0.28% / 0.00% / 0.24% (weighted) get a wrong word in the center (pt `te sentes` → dentes, `se mexa` → mesa; es `te muevas` → nuevas). The typed word is never removed from the first place. Left open: English has the weakest context (60% of the errors get nothing).
- **Added words** (S29): a name that is only a prefix of other words (`estou ch`, `vou ma`, es `estoy ll`) still loses to the frequent words with 2 letters; that is the point of the weight. Not measured on a device: the real screens and the SQLite store.
- **Shortcuts** (`[shortcuts]`: type `pdc`, get a text) and **sharing text from other apps to the keyboard** were left out of 1.85 (they were optional in the plan).
- A wrong first letter that is not a neighbour or phonetic pair is not found (`MrFuzzy.firstLetters`).
- When the editor does not give the text before the cursor, `MrText.atSentenceStart(null)` answers "start of a sentence" and the strip shows the starters.

## Speed
Cost of one keystroke on the PC (`docs/tools/e2e/SpeedEval.java`: 800 subtitle sentences x 3 rounds per language, every keystroke timed; the three languages added together, run alone on the machine; the phone is 5 to 15 times slower, so read the ratios). Before = 1.83 classes, after = 1.84.

| Keystroke | n | mean before → after (µs) | p50 before → after | p95 before → after |
|---|---|---|---|---|
| after a space | 17,118 | 86.3 → 75.5 | 82.4 → 71.8 | 123.2 → 110.5 |
| 1 letter | 17,118 | 50.6 → 49.7 | 47.7 → 46.5 | 76.9 → 74.7 |
| 2 to 4 letters | 37,215 | 225.7 → 236.5 (+4.8%) | 159.7 → 169.6 | 658.6 → 685.7 |
| 5 or more letters | 9,633 | 177.5 → 206.8 (+16.5%) | 85.3 → 128.5 | 439.0 → 499.2 |
| typo (not a word) | 8,277 | 317.8 → 336.6 (+5.9%) | 299.4 → 310.8 | 563.0 → 615.6 |
| valid word | 12,504 | 75.4 → 90.9 (+20.5%) | 58.7 → 65.5 | 170.5 → 234.9 |
| all keystrokes | 101,865 | 157.3 → 165.5 (+5.2%) | | |

The "after a space" and "1 letter" rows are not touched by the change, so their movement (about -12% on the spaces) is the noise of the measurement: read differences under 10% as noise. The two real costs are `MrPredict.complete` (a scan of up to 248 candidates per keystroke from the 2nd letter) and the search for an alternative to a rare valid word (a normal fuzzy search, once per keystroke of such a word); measured apart, the context alone is inside the noise (157.3 → 156.4 µs per keystroke on average) and the search for the alternative is the rest of the cost (the valid-word and 5-or-more-letter rows). On a phone the average keystroke stays around 1 to 2.5 ms.

**1.84 → 1.85** (same method, 800 sentences x 2 rounds, one language at a time on the machine; mean µs per keystroke, 1.84 classes → 1.85 classes; native engine):

| Keystroke | pt-BR | en-US | es |
|---|---|---|---|
| after a space | 84 → 83 | 80.8 → 84.8 | 88.3 → 90.0 |
| 1 letter | 51 → 50 | 49.2 → 51.9 | 52.8 → 53.8 |
| 2 to 4 letters | 224 → 221 | 236.2 → 245.7 | 230.6 → 237.2 |
| 5 or more letters | 229 → 222 | 227.0 → 239.4 | 166.3 → 168.3 |
| typo (not a word) | 402 → 396 | 325.7 → 344.9 | 269.7 → 275.4 |
| valid word | 99 → 96.5 | 95.5 → 98.3 | 88.8 → 89.9 |

pt-BR does not move; en-US is 3 to 5% slower and es 1 to 3% (one run each: under 10% is noise, but the sign is the same in all rows, so the likely cause is the extra `AutoDictionary` lookup that `Suggest` now makes on every keystroke; it was not isolated). With the lists full (20,000 added words and 30,000 pairs) the per-key time does not change; the cost is memory, about 5 MB of heap.

**1.85 → 1.86, dictionary format** (same method, 800 sentences x 2 rounds, one language at a time, native engine; mean µs per keystroke, the three shipped dictionaries as v1 → converted to v2; same classes and libs in both runs):

| Keystroke | pt-BR | en-US | es |
|---|---|---|---|
| after a space | 91.5 → 95.5 | 87.8 → 90.1 | 92.0 → 90.8 |
| 1 letter | 58.8 → 61.1 | 56.8 → 58.0 | 57.5 → 57.5 |
| 2 to 4 letters | 241.6 → 245.7 | 253.3 → 258.1 | 241.2 → 235.6 |
| 5 or more letters | 241.3 → 243.5 | 238.0 → 242.2 | 170.8 → 167.3 |
| typo (not a word) | 390.6 → 399.2 | 342.6 → 346.2 | 275.8 → 274.6 |
| valid word | 95.5 → 97.2 | 100.1 → 102.3 | 92.0 → 90.0 |

The differences run from -2.3% to +4.4%; pt-BR and en-US lean a little to the slow side (about +2%), es to the fast side, which is what noise on a shared machine looks like. `mr_bench` is within 3% and visits the same nodes. The file is memory-mapped, so a larger dictionary adds no Java heap. Opening time with a 16 MB pack was not measured (no device).

**1.86.0 → 1.86.1, the new Spanish pack** (same method; 800 sentences x 3 rounds of `holdout_30k.txt`, es only, native engine, es 3 → es 4; the old pack measured twice, before and after, to show the noise: 69.2 / 68.9 µs after a space):

| Keystroke | es 3 (mean µs) | es 4 (mean µs) | change |
|---|---|---|---|
| after a space | 69.2 | 77.5 | +12% |
| 1 letter | 45.6 | 51.1 | +12% |
| 2 to 4 letters | 195.9 | 208.4 | +6% |
| 5 or more letters | 178.8 | 179.2 | 0% |
| typo (not a word) | 260.9 | 268.3 | +3% |
| valid word | 87.6 | 82.1 | -6% |

The cause is the data, not the code: es 4 has 90% more pairs, so the strip after a space and after the first letter looks at more candidates. Reading `trigrams.bin` in the native store goes from 3.4 to 4.3 ms on average (warm cache; file 3.46 → 4.88 MB and index 0.91 → 1.30 MB, so about 1.8 MB more native memory). Native/Java parity (the Java search was removed in 1.87.0) on es 4: 10,897 correction queries, 2,000 suggestion lists and 24,000 trigram queries, 0 differences. Opening time on a low-end phone: still to be measured on a device (checklist in "Dictionary format v2").

**1.86.0 → 1.86.1, the new Portuguese pack** (same method, pt-BR only, native engine, pt-BR 5 → pt-BR 6; the old pack measured twice, before and after: 72.9 / 73.4 µs after a space):

| Keystroke | pt-BR 5 (mean µs) | pt-BR 6 (mean µs) | change |
|---|---|---|---|
| after a space | 73.2 | 78.0 | +7% |
| 1 letter | 48.4 | 51.0 | +5% |
| 2 to 4 letters | 209.0 | 219.5 | +5% |
| 5 or more letters | 249.4 | 240.9 | -3% |
| typo (not a word) | 383.3 | 388.7 | +1% |
| valid word | 98.7 | 90.7 | -8% |

As in es, the cause is the data (68% more pairs). Reading `trigrams.bin` in the native store goes from 2.5 to 4.9 ms (warm cache; 3.02 → 5.18 MB with an index of 0.80 → 1.39 MB, so about 2.7 MB more native memory). Native/Java parity (the Java search was removed in 1.87.0) on pt-BR 6: 10,967 correction queries, 2,000 suggestion lists and 24,000 trigram queries, 0 differences. The center promotion (`PromoEval`): wrong swaps of correct words 0.16% → 0.02%, the right word at the center 51.7% → 56.5%.

**1.86.0 → 1.86.1, the new English pack** (same method, en-US only, native engine, en-US 4 → en-US 5; the old pack measured twice, before and after: 69.5 / 71.1 µs after a space):

| Keystroke | en-US 4 (mean µs) | en-US 5 (mean µs) | change |
|---|---|---|---|
| after a space | 70.3 | 78.3 | +11% |
| 1 letter | 46.4 | 51.0 | +10% |
| 2 to 4 letters | 191.5 | 205.7 | +7% |
| 5 or more letters | 242.0 | 247.7 | +2% |
| typo (not a word) | 328.3 | 341.0 | +4% |
| valid word | 87.5 | 88.4 | +1% |

The pack has 61% more pairs, which is where the time goes. Reading `trigrams.bin` in the native store goes from 2.0 to 4.3 ms (warm cache; file 2.35 → 5.19 MB and index 0.64 → 1.39 MB, so about 3.6 MB more native memory). Native/Java parity (the Java search was removed in 1.87.0) on en-US 5: 11,183 correction queries, 2,000 suggestion lists and 24,000 trigram queries, 0 differences. The center promotion (`PromoEval`): wrong swaps of correct words 0.11% → 0.02%, the right word at the center 32.2% → 43.3%.
