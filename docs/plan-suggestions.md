<!-- target-version: v1.87.0 -->
# Plan: better correction, suggestion and precision

Written on 1.83.0. Delete this file in the release commit of the target version (`check_version.py` warns when it is reached).
What exists today is in `suggestion-features.md` (ids S1...S28 are the tags of `docs/tools/e2e/StrategyTest.java`); the remaining items
of the older list are in `engine-improvements.md` and are absorbed here.

## Decisions already taken
| Question | Decision |
|---|---|
| Dictionary size limit (4 MB, packs are 88-90% full) | **Format v2, up to 16 MB** (wider addresses in the readers, builder and tests; new packs need a newer app: `minApp`) |
| Text base of the new dictionaries | **Subtitles (OpenSubtitles) as the main base, news with a low weight**; only counts are distributed, never text |
| A valid word that is probably another word (`cassa`, `fone`, `ombre`) | **Suggest the frequent one in the strip, never replace on its own** |
| Mixed languages | **Frequent English loanwords inside the pt-BR / es dictionary** (`ok`, `bye`, `deploy`, `link`); one active language at a time as today |
| Two new screens (asked after the questions) | **"What the keyboard learned"** (manage) and **"Add words and texts"** (import), phase 2 |

## Where we are (measured)
The rows marked 1.83.0 are the state before Phase 1; the rows marked 1.84.0 are what Phase 1 delivered (the same sentences, same code). Everyday-language benchmark: the 10,000 most common sentences of OpenSubtitles 2018 (`orgtre/top-open-subtitles-sentences`), words of 4 or
more letters, previous words as context, hit = the word is among the 3 predictions after the space, or among the 2 suggestions next to the typed word
after 1, 2 or 3 letters. Run it with `docs/tools/e2e/run_subtitle_eval.sh` (the sentences are not in the repository; the script says where to get them).
The sentences are not the training data of any pack. Weighted by how often each sentence occurs:

| | pt-BR | en-US | es |
|---|---|---|---|
| Words of the sentences that the dictionary knows | 99.7% | 99.6% | 99.8% |
| Right word among the 3 predictions after the space | 34.5% | 31.9% | 27.5% |
| ... among the 2 suggestions after **1** letter | 58.9% | 58.3% | 50.0% |
| ... after **2** letters (1.83.0) | 48.5% | 51.6% | 37.7% |
| ... after **3** letters (1.83.0) | 72.0% | 83.5% | 55.6% |
| **1.84.0** (context kept while typing), **2** letters | **73.1%** | **70.4%** | **62.1%** |
| **1.84.0**, **3** letters | 80.9% | 84.7% | 69.9% |

What this says:
1. **The vocabulary is not the problem** (99.6-99.8% of the words are known). The ranking is: frequencies and word pairs come from news.
2. **The context is thrown away after the first letter.** `Suggest` only asks for the previous word's bigrams when 1 letter is typed
   (`getBigrams` branch with `composer.size() == 1`); from the 2nd letter on only the plain frequency list is used, so the hit rate *falls* from 1 to 2
   letters in all three languages (pt-BR 58.9 → 48.5). **Fixed in 1.84.0** (item 1.1): keeping the previous words' candidates (bigrams, trigrams, user pairs) for
   the typed prefix gives +24.6 / +18.8 / +24.4 points at 2 letters and +8.9 / +1.2 / +14.3 at 3 (pt-BR / en-US / es), better than the prototype (+19.5 / +15.9 / +19.8). Cost: about +5% on the time of a keystroke on average (`suggestion-features.md`, "Speed").
3. **es is the weakest** (3 letters: 55.6% against 83.5% in en-US): its frequencies are the least reliable (`hola` has frequency 78 and loses to `bola`/`golazo` for `gola`).
4. The correction strategies themselves work: `StrategyTest` (about 85 checks per language, native and Java) and the Java x C++ parity are green; the
   failures it records (`GAP`) are data or structure, not bugs (see "Known gaps" in `suggestion-features.md`).

## Phase 1 - v1.84.0: context while typing and quick wins (no new data, no format change) - **delivered**
| # | Item | How | Check |
|---|---|---|---|
| 1.1 | **Context while typing (2 to 12 letters)** - **done** | `MrPredict.complete(suggest, composer)`, called from `MrFuzzy.afterWords` (so no hand-edit of `Suggest.smali`): from the 2nd letter, the 2 best candidates of the previous words (the arrays `forWords` already built: dictionary pairs, trigrams, user pairs, recent pairs) that start with what is typed (accent and case ignored) join the list with a score above plain completions. Java only; the C++ engine is untouched | strategy **S26** in `StrategyTest` (16 cases: pt `muito ob` → obrigado, en `thank yo` → you, es `muchas gr` → gracias...); `SubtitleEval` at 2 letters: pt-BR 48.5 → 73.1%, en-US 51.6 → 70.4%, es 37.7 → 62.1% |
| 1.2 | **Valid word that is probably another word** (suggestion only) - **done** | `MrFuzzy.validAlternative/alternative`: a valid typed word of 3 to 12 letters with frequency 6 to 80 gets one fuzzy search; a word within cost 40 that is at least 60 more frequent (and ≥ 110) is kept for the 3rd strip slot. Never in the autocorrect decision. The thresholds come from `AltEval` (sweep of gap 40-100 and of the cut on the typed frequency): false positives 0.27-0.33% of valid words (weighted), hits 46-58% of the confusions | strategy **S27**: `cassa` → casa, `cousa` → coisa, `whee` → where, `vece` → veces..., `autocorrect(cassa) = false`, no alternative for `casa`, `fone`, `they`, `hola`. What stays open: `fone` → phone (a real word, frequent) and `hola`/`bola` (the neighbour is not much more frequent) |
| 1.3 | **Accuracy gate in CI** - **done** | 133 *original* everyday sentences per language in `docs/tools/e2e/data/everyday_<lang>.txt` (no corpus text, so no licence issue); `SubtitleEval.run` is shared with `StrategyTest`, check **S28** fails when one of 5 rates (known words, after the space, 1, 2, 3 letters) falls under its floor (2 points under the value measured at 1.84.0) | `mr-checks.yml` (`run_strategy_tests.sh`, also when only `dicts/**` changes). Measured on these sentences: 2 letters pt-BR 30.5 → 52.7%, en-US 39.1 → 53.7%, es 27.3 → 45.4% |
| 1.4 | **`PacksTest` (75 checks) and `ThreeLangTest` (23) in CI** - **done** | `docs/tools/packs_test/run_packs_tests.sh` builds a test key with `keytool`/`openssl`, the fixtures (`make_fixtures.py`, `sign_fixtures.py`) and a signed catalog of the three real packs, then runs both; the fixed numbers of the old test (217 corrections, dictionary size, app code) now come from `dicts/` and `apktool.yml`. Step "Dictionary packs" in the `assemble` job. While doing it, `run_strategy_tests.sh` was found to hide failures (`set -o pipefail` was missing: a failing test still gave a green CI); fixed | the job fails on any `FAIL` or non-zero exit |
| 1.5 | **Data patches until the rebuild** - **done for `rules.txt`** | pt-BR: `flw`, `fmz`, `wpp`, `whatsapp`, `uber`, `ifood`, `tiktok`, `instagram`, `netflix`, `youtube`, `spotify`; en-US: `whatsapp`, `wasap`, `whatsap`, `wpp`, and `visavis` now points to `vis-à-vis`; es: `whatsapp`, `wasap`, `wasapp`, `guasap`, `wpp` (`pa` → para was tried and dropped: it is a prefix of many words and cost 0.2 points at 2 letters for no gain). Packs pt-BR 5, en-US 4, es 3. Left for the rebuild (they need data, and a correction cannot point to a word the dictionary lacks): en `tiktok`, pt `pix`, the frequency of `tá`, `né`, `oi` and the other chat words | `StrategyTest` D3 (no known defect left in the list) and the `GAP` cases of the chat words |
| 1.6 | **`x86_64` libs** - **done** | `mr-native.yml` builds a 4th ABI for both libs; the artifact of that workflow (built from the current `native/` and `engine/`, same source hashes) was merged into `lib/x86_64`, and `mr-apk.yml` now requires the 4 ABIs. The 8 ELF files were checked: x86-64, 16 KB alignment (0x4000), `JNI_OnLoad`, no `libc++_shared`. The other 6 libs came back byte-identical | the artifact passes the checks of `mr-native.yml` (alignment, JNI, no `libc++_shared`) |

## Phase 2 - v1.85.0: two new screens - **delivered**
The text below is the design; "What was delivered" at the end of this phase lists what changed while building it. How it works today is in "The two screens" of `suggestion-features.md`.
Both go in *Settings → Suggestions and dictionaries*, in a new category **"My words"** (title in the three languages: Portuguese, English, Spanish, like the other screens; `res_check.py` must pass).
They use the settings palette (`mr_ui_*`) and plain framework views (`ListView` + adapter, no new library), built in Java under `docs/tools/java/src/com/mrkeyboard/app/` like `MrPacksActivity`.

### What exists today (it shapes the design)
- Learned **words**: `auto_dict.db`, table `words(_id, word, freq, locale)`, loaded into the Java heap by `AutoDictionary` (an `ExpandableDictionary`); a word is promoted after a few uses.
- Learned **pairs**: `userbigram_dict.db`, tables `main(word1, word2, locale)` + `frequency(pair_id, freq)`; cap **10,000 pairs**, and when it fills up it deletes 1,000 at once, so a big import would wipe what was learned.
- No timestamps, no source. Both databases are in the `database` domain, which `backup_rules.xml`/`data_extraction_rules.xml` do not include: **a new phone or a reinstall loses everything that was learned**. The export in screen A is also the backup.
- Nothing learns in password fields or with `IME_FLAG_NO_PERSONALIZED_LEARNING` (S16, no PC test because it needs Android).
- Word length in learned/user words: 32 letters (`ExpandableDictionary`).

### Storage (both screens share it)
- `auto_dict.db` and `userbigram_dict.db` go to **version 2** with `ALTER TABLE ... ADD COLUMN` in `onUpgrade` (nothing is lost): `src` (0 learned, 1 imported), `batch` (import id, 0 for learned), `added` (ms).
- Imported pairs live in their **own table with their own cap** (30,000) and are never evicted by the 1,000-at-a-time cleanup; imported words are capped at 20,000. Measure the Java heap with the caps full before release (`ExpandableDictionary` keeps a node per letter; the estimate is a few MB).
- New table `blocked(word, locale)` for "never suggest this": checked in one place, a final filter over the list at the end of `Suggest.getSuggestions` (the typed word is never removed) and in `checkAddToDictionary` (a blocked word is not learned again).
- One shared `SQLiteOpenHelper` instance per database (the existing `sOpenHelper` statics), because the settings screens and the keyboard service run in the same process. After any change the screen calls `MrLearned.changed()`; `LatinIME` reloads the user dictionaries at the next `onStartInputView` (it already rebuilds `AutoDictionary` when the locale changes, at the same place).
- All storage code sits behind a small interface (`MrWordStore`) with an in-memory implementation, so parsing, limits, counting and undo run in a PC test; the SQLite implementation is checked on the device with the checklist at the end of this phase.

### Screen A - "What the keyboard learned" (`MrLearnedActivity`)
- Language selector (the installed languages) and three tabs: **Words** (learned and imported, with a small icon telling which), **Pairs** (`word1 → word2`), **Blocked**.
- Each row: the word, how many times it was used (`freq`) and the date it was added. Search box on top; sort by "most used" or "newest".
- Rows load in pages of 200 (`LIMIT/OFFSET`), so 10,000+ entries stay smooth.
- Tap a row: **Forget** (delete; it can be learned again), **Block** (never suggest, never learn), **Edit** (fix a typo that was learned: delete + add). Long press: multiple selection with the same actions.
- Menu: **Delete all learned** (with the count and a confirmation), **Delete everything imported**, **Export** (below) and a counter "1,234 words, 856 pairs, 312 imported".
- **Export / backup**: writes the learned and imported data in the standard format (next screen) with `ACTION_CREATE_DOCUMENT` (the system file picker: no storage permission). The same file can be imported again on another phone: this is the backup the backup rules do not give.
- Nothing leaves the phone; there is no network code in these two screens.

### Screen B - "Add words and texts" (`MrImportActivity`)
Ways to give material, all on the same screen:
1. **Paste or type** in a big text box (a **Paste** button reads the clipboard).
2. **Choose a file** with `ACTION_OPEN_DOCUMENT` (`.txt`, `.csv`, `.tsv`, `.md`; no storage permission). At most 2 MB, UTF-8 (BOM accepted, ISO-8859-1 fallback), read on a background thread. A WhatsApp export `.zip` is not opened: the screen says to unzip it first and choose the `.txt`.
3. *(optional, later)* **Share to Mr Keyboard** from other apps (`ACTION_SEND` `text/plain`). It appears in every share sheet, so it is off the first version.

What the screen does with it (`MrImport`, pure Java, PC-tested):
- **Free text** (anything that is not the standard list): split in lines and sentences; remove URLs, e-mails, phone numbers, numbers, WhatsApp/Telegram line prefixes (`[12/03/24 14:05] Ana:`, `12/03/2024 14:05 - Ana:`), laughs and repeated letters (`kkkkk`, `aaaaa`), words over 32 letters.
  - A word is stored only if the main dictionary does **not** know it (names, slang, jargon, brands) and it appears at least twice, or once when written with a capital in the middle of a sentence (a name). Known words are not stored (it would only cost memory); the pairs are what the text teaches.
  - A pair is stored when both words are valid (main dictionary or just added) and it appears at least twice.
- **Standard list** (below): every line is checked and counted.
- A **preview before anything is saved**: "312 new words, 1,204 pairs, 18 shortcuts; 41 lines ignored", the list of new words with a checkbox each (all checked; the user unticks typos), and the first 20 ignored lines with the reason (too long, invalid characters, a number, unknown section). A typo in the material would otherwise become a "valid" word.
- **Language** dropdown (default: the active language); everything is stored per locale.
- After the import, an **Undo this import** button (deletes the `batch`) and the filter "Imported" in screen A.
- Limits shown in the screen: 2 MB per file, 20,000 imported words, 30,000 imported pairs.
- Imported words enter with a frequency below the common words (starting value 60 of 255, scaled by the optional weight) so they show up when their letters are typed but do not outrank everyday words. Calibrate with a PC test: an imported name typed with 2 letters must be in the top 2 of the list.

#### The standard format ("Mr Keyboard word list")
A UTF-8 text file; `#` starts a comment; sections in square brackets, like `rules.txt`.
```
# mr-words 1
# language: pt-BR
[words]
Nubank
Itaú	70
[phrases]
reunião de alinhamento
Maria Clara
[shortcuts]
pdc	pau de chuva
```
- `[words]`: one word per line (no space inside), optional TAB and a weight from 1 to 100 (default 50).
- `[phrases]`: one text per line; every unknown word is added and every neighbouring pair becomes a pair. This is the right place for names with surname and for expressions.
- `[shortcuts]` *(phase 2b, only if the first two sections work well)*: `typed<TAB>expansion`; shown in the strip when the typed word matches, tap to expand; never expanded on its own. It reuses the map idea of `[corrections]` (`MrFix`) with a per-user table consulted first.
- The `# language:` line is a hint; if it differs from the language chosen in the screen the screen asks which one to use.

#### "Ask an AI to format it" (button in screen B)
The screen explains in two lines that any AI can turn a messy list (contacts, glossary, product names, a spreadsheet, notes) into this format, and has a **Copy prompt for AI** button that puts the text below on the clipboard (translated to the screen language). A warning goes next to it: *everything you paste into an AI leaves your phone; remove passwords, phone numbers and private data first.*
```
Convert the material below into a UTF-8 plain-text word list in exactly this format and return ONLY the file content, no explanations and no code fences.

# mr-words 1
# language: <language code, e.g. pt-BR>
[words]
<one word per line, no spaces inside; optional TAB + weight 1-100>
[phrases]
<one name, expression or short sentence per line>

Rules:
- Put single words in [words] and anything with spaces (full names, expressions) in [phrases].
- Keep original spelling, accents and capitalisation. Do not translate, do not invent entries, do not fix names.
- Remove duplicates, phone numbers, e-mail addresses, passwords, URLs and numbers.
- Weight: 80-100 for words I use all the time, 40-60 normal, 10-30 rare. If unsure, leave the weight out.

Material:
<paste here>
```
- The file the AI returns is pasted or opened in the same screen; the preview catches whatever it got wrong.
- The same text is kept in `docs/` (this section) and in the app strings; a PC test checks that the example in the prompt parses without ignored lines.

### Tests for phase 2
- `ImportTest` (PC, in CI): text cleaning, WhatsApp prefixes, laughs, limits, the two-occurrence rule, the standard format (every error line), weights, language hint, undo, counts of the preview.
- `LearnedStoreTest` (PC, in CI) on the in-memory `MrWordStore`: caps, imported pairs never evicting learned ones, block, forget, edit, export → import round trip is identical.
- `StrategyTest` S29 (imported word completes with 2 letters; blocked word never shows; imported pair raises the prediction).
- Device checklist (SQLite and screens, as S16 needs Android): upgrade over 1.84 keeps learned words; delete a word and see it disappear from the strip at once; block; import 5,000 words and watch the heap and the keyboard opening time; export on one phone, import on another; rotate the screen during an import; password field still learns nothing.

### What was delivered in 1.85.0 (and where it differs from the design)
| Design | Delivered | Why |
|---|---|---|
| `ALTER TABLE` to version 2 of both databases (`src`, `batch`, `added`) | A third database, `mr_words.db` (`MrSqlStore`), for added words, added pairs and blocked words; `auto_dict.db` and `userbigram_dict.db` are untouched and `MrLearned.loadFrom` pushes the added rows into the dictionaries in memory | no migration risk (an upgrade from 1.84 cannot lose what was learned); the caps and "delete everything added" are one table; a store that fails to open leaves the learned data working |
| One "Words" list with an icon for the source, plus "Pairs" and "Blocked" tabs | Tabs **Learned / Added / Blocked** and a Words/Pairs switch | the source is the first thing to filter by, and learned rows have no date or source column |
| Pages of 200; date added and times used on each row; long press for a multiple selection | Pages of 50 with a "Show more" button; each row shows the word (or pair) and its weight (1-100; learned frequencies are mapped to the same scale); one action menu per row, plus delete-all per tab | simpler and light on small phones; the learned databases have no date; multi-select can come later if it is asked for |
| Reading a file: UTF-8 (BOM accepted), ISO-8859-1 fallback, at most 2 MB | At most **8 MB**, UTF-8 with or without BOM, **Windows-1252** when the bytes are not valid UTF-8 (`MrImport.decode`, PC-tested); a file cut at the limit loses only its last character | a long chat export is more than 2 MB; old Notepad/Excel files are Windows-1252, not ISO-8859-1 |
| `[shortcuts]` (phase 2b) and "Share to Mr Keyboard" | Not done: a `[shortcuts]` line is reported as ignored ("Shortcuts are not supported yet") | both were marked optional; they need their own design (a per-user table consulted first, an extra share-sheet entry) |
| "Imported words enter with frequency 60 of 255" | Weight 1-100 → frequency 6-250, **130 at weight 50**, calibrated with `ImportEval` (3 letters: pt-BR 11 of 12 names, en-US 15 of 18, es 18 of 19 are one of the 2 suggestions; 4 letters nearly all; weight 100 from 2 letters). Pairs: frequency 4-9 on the scale of the user's pairs (score 80-127) | 60 never reached the strip; the numbers come from the sweep, not a guess |
| Strategy tag S29 "imported word completes with 2 letters" | S29 has 16 checks per language (weights 5, 50 and 100, the valid-word rule, learned words from frequency 6, blocked words, imported pairs); at 2 letters a weight-100 name completes in more than half of the cases and a weight-50 name seldom does | a name must not outrank everyday words when only 2 letters are typed |
| `ImportTest`, `LearnedStoreTest` | 80 and 49 checks, in `run_java_tests.sh` | |

Two things were found while building it and are part of this release:
- **`AutoDictionary` never completed a word.** In the original code `mAutoDictionary` is only asked by `Suggest.isValidWord`; `getSuggestions` never read it, so the words the keyboard "learned" only stopped being flagged as errors. `Suggest.getSuggestions` now asks it before the main dictionary and `AutoDictionary.getWords` passes only words from frequency 6 (`MrLearned.gate`), the point where the original code already calls a learned word valid (a word typed once or twice does not show). This is a visible behaviour change and is in the release notes.
- **The center promotion** (`quase semper` → sempre, S27, `MrFuzzy.ALT_CTX_FIRST`): when the alternative for a rare valid word is also one of the candidates of the previous words and the typed word is not, it goes to the center slot. `PromoEval`: the right word reaches the center in 50.0% (pt-BR), 30.2% (en-US) and 55.2% (es) of the real-word errors; 0.28% / 0.00% / 0.24% of the correctly typed words get a wrong word there. The typed word keeps the first place and autocorrect is unchanged.

Measured: a full list (20,000 words, 30,000 pairs) takes about 5 MB of Java heap; keystroke time pt-BR unchanged, en-US +3 to 5%, es +1 to 3% (details in "Speed" of `suggestion-features.md`). **Not testable on the PC** and left to the device checklist in `suggestion-features.md`: `MrSqlStore` and the real screens.

## Phase 3 - v1.86.0: dictionary format v2 (up to 16 MB) - **delivered**
Why: the packs use 88-90% of the 22-bit address space and subtitle data needs more words and pairs. A `.dict` address is 6 bits in the flags byte + 2 bytes (`0x40` children, `0x80` terminal) and bigrams carry a 3-byte address.
- New header value (format v2, `main.dict` header `200/2`) with 24-bit group addresses and 4-byte bigram addresses (about +0.7 MB for the same content). Readers to change together: `native/src/dictionary.cpp`, `engine/src/mr_fuzzy.cpp` (3 places), `MrFuzzy.java` (`prefixRec`, `walk`, `lookupRec`, `skipBigrams`), and `build_dict.py` (`ADDRESS_LIMIT`, its own re-read check). The libs stay compatible with v1 files (the header decides).
- `pack.json`: `format: 2`, `minApp: 1.86.0`. An older app keeps the v1 pack it has; the catalog only offers v2 to apps that can read it (`make_catalog.py` + `test_make_catalog.py`).
- Memory: the dictionary is read into a direct buffer, one language at a time; 16 MB is acceptable, but measure the opening time of the keyboard with a 16 MB pack on a low-end device.
- Checks: `run_native_parity.sh` and `StrategyTest` with a v2 pack in 3 languages; a round trip on `build_dict.py` with more than 4 MB; `dict_test.cpp` reads every word and pair back.

### What was delivered in 1.86.0 (and where it differs from the design)
| Design | Delivered | Why |
|---|---|---|
| "24-bit group addresses and 4-byte bigram addresses" | Group addresses: 6 bits of the flags byte + **3 bytes** (30 bits); bigram entry: **5 bytes** (4-byte address + frequency). Header `200/2`. The policy limit is **16,777,216 bytes** (`DICT_MAX_V2`), not the capacity of the field | v1 is 6 bits + 2 bytes (22 bits, 4,194,304); one more byte is the smallest step that reaches 16 MB, and the bigger field leaves room if the limit is raised again |
| Content costs about +0.7 MB | The three shipped dictionaries converted to v2: pt-BR 3,708,011 → 4,423,351, en-US 3,758,547 → 4,484,792, es 3,792,609 → 4,473,361 (+0.68 to +0.73 MB, +18 to +19%) | a v2 file for today's content is already over the v1 limit, so v2 is for dictionaries that really need the space |
| "The catalog only offers v2 to apps that can read it" | `pack.json` `format: 2` + `minApp: 1086000`; the **catalog format stays 1** and there is no fallback entry for old apps: an app older than 1.86.0 keeps the v1 pack it has and shows "needs a newer version of the app" (`MrPacks.PACK_FORMAT` 1 treats format 2 as unsupported). `make_catalog.py` checks the header `[200, format]`, the size limit per format and `minApp >= 1086000` for format 2 | no change in the catalog means no change for old apps; a fallback would need the v1 version of a pack that does not fit in v1 |
| New packs published in this release | **None**: pt-BR 5, en-US 4 and es 3 stay v1. The v2 packs of the tests come from `make_v2_dicts.py` (conversion of the shipped files) | the new content is Phase 4; a v2 copy of an unchanged dictionary only costs the users 0.7 MB |
| Readers: `dictionary.cpp`, `mr_fuzzy.cpp` (3 places), `MrFuzzy.java`, `build_dict.py` | Also `MrPacks.dictHeaderOk` (accepts `200/1` up to 4,194,304 and `200/2` up to 16,777,216) and `make_catalog.py`. The address width is read once from the header (`mAddrBytes`, `ab_`, `mAb`), so a v1 file takes the same path as before; every read of an address is bounds-checked | one reader for both formats; damaged v2 files are refused (tests with cut files and addresses past the end) |
| `build_dict.py` round trip over 4 MB | `build_dict.py in.combined.gz out.dict [--format 1\|2]` (default 1), `--convert in out [--format 2]` (reads any format back, writes the other; v1 → v1 is **byte-identical** for the three shipped files) and `--dump in words.tsv bigrams.tsv`. It re-reads its own output and checks every word, every bigram through an address table and a lib walk | the same converter serves the tests, Phase 4 and any later change of limit |
| `dict_test.cpp` reads every word and pair back | `docs/tools/dict_readback.sh <dict_test> [dicts]`: dumps every word and pair of each language and runs `dict_test` (the real C++ reader) requiring N/N on `isValidWord` and `getBigrams`; done on `dicts/` (v1) and on the v2 copy | `dict_test` returns exit 1 on en-US/es because its fixed Portuguese "non-words" are valid there, so the script reads the two summary lines |
| A big file | `docs/tools/dict_v2_test.py`: a synthetic dictionary of 720,000 words and 450,000 pairs (13,982,499 bytes) built in v2 and verified (all bigrams, lib walk on 1 in 500, a bit-23 address, v1 refuses it, the v2 limit refuses one byte more, v2 → v2 identical, damaged files refused, v1 → v2 → v1 gives the shipped files back): 14 checks, about 2 minutes. Not in the quick CI chain (it runs in `mr-native.yml`) | proves the format at the size it was made for, without needing the Phase 4 data |
| Parity and strategy tests with a v2 pack in 3 languages | `run_native_parity.sh` and `run_strategy_tests.sh` take `DICTS` (default `dicts`); both run on `dicts/` and on the v2 copy: 0 differences between the Java and C++ engines, `StrategyTest` all passing on both | |
| `PacksTest` | Fixture v8 (a v2 pack, serial 7) installs over v7, is larger than 4 MB, has header `200/2` and its words are valid in `Suggest`; 11 `dictHeaderOk` cases and 5 `appTooOld` cases. `PacksTest` 94 checks, `ThreeLangTest` 23 | |
| `mr_test`, `mr_bench` | `mr_test` has a hand-made v2 dictionary with child-group addresses `0x500000`, `0xC00000`, `0xFFFFF0` (v2 finds `ab`; the same bytes with a v1 header must not); runs plain and under ASan/UBSan on v1 and v2 files, including corrupt ones | |

Measured (PC, native engine, 800 sentences x 2 rounds, same code, the three shipped dictionaries as v1 and converted to v2; table in "Speed" of `suggestion-features.md`): the mean time per keystroke differs by -2.3% to +4.4% in every row and language (the slower side is the extra address byte read per node, and it is inside the noise of the machine); `mr_bench` is within 3%, with the same number of nodes visited. The dictionary is read through `MappedByteBuffer` (`MrPacks.open`), so a bigger file costs no Java heap.

**Not testable on the PC** and left to the device checklist in `suggestion-features.md`: the opening time of the keyboard with a 16 MB pack on a low-end phone, and the real download/install of a v2 pack on an app older than 1.86.0.

**The libs were rebuilt for this phase.** `native/` and `engine/` changed, so the four ABIs of both libs were built again by `mr-native.yml` (the `native-libs` artifact) and merged: `lib/`, `native-src.sha256`, `mrengine-src.sha256` and `mrengine-info.txt` match the current sources (`mr-apk.yml` gives "lib/ matches the current native/ and engine/"). The engine contract (`kEngineVersion`) stays 1: the Java and C++ engines still return the same lists.

## Phase 4 - v1.86.x (packs only) and v1.87.0: new everyday dictionaries - **es, pt-BR and en-US delivered in 1.86.1**
Needs the corpus files listed below. Packs are published through the catalog; the app does not change after phase 3 (1.86.1 only changes the version number, `mr-apk.yml` and the three packs).
1. **Counts, not text.** Per language, from OpenSubtitles (`mono`, one sentence per line): clean (drop lines with timestamps, `[music]`-style tags and lines under 2 words), normalise (case, apostrophes, spelling per variant: pt-BR only; remove European Portuguese markers as in `split_br.py`), count unigrams, in-line bigrams and trigrams. The text itself is never stored or distributed.
2. **Hold-out first.** A sentence goes to the *test set* when `hash(sentence) % 20 == 0` and is excluded from every count. All dictionaries (old and new) are evaluated on that same set with `SubtitleEval`, so the comparison is fair (the top-10,000 benchmark above is for the current packs only, because those sentences are very frequent and would leak into new counts).
3. **Mix.** Starting weights: subtitles 60%, Tatoeba 20%, news 15%, AOSP list 5%; tune on the hold-out by the 4 rates (after space, 1, 2, 3 letters) plus the normal-typing rate of `StrategyTest`. News stays for the formal vocabulary (so `previdência` is still there) but stops deciding the order.
4. **Words.** AOSP list as the base spelling filter (as today); words are added from the corpus when they appear in at least two sources or N times in subtitles; frequent English loanwords (`ok`, `bye`, `deploy`, `link`, `feedback`) and brands/apps are kept in pt-BR and es when they pass the same count rule. Offensive words stay as today (never predicted).
5. **Pairs and trigrams.** More pairs per word where the format v2 allows (today 400,000 with up to 60 per word; the target is 1,000,000+ pairs and a larger `trigrams.bin`, bounded by the 16 MB and by the time to open). Pair selection by P(next | previous) with a floor, not only raw count.
6. **Frequencies calibrated per language**, starting with es (hola/bola, bamos → vamos) and the chat words of `rules.txt` (`tá`, `né`, `kkk`, `pq`...), checked by the `GAP` cases of `StrategyTest`.
7. **Release.** Packs pt-BR 6, en-US 5, es 4, each with `NOTICE.txt` (credits and the licences of the sources; the licence of OpenSubtitles text is not clear, which is why only counts are published, and the notice says so). If the strict legal view matters, the pack can be built from Tatoeba + Common Voice + news alone with the same scripts (lower quality, clean licences).
8. **Targets** (to be fixed after the first hold-out comparison): after the space +8 points over the old pack on the same hold-out; 3 letters in es ≥ 70%; no drop in the normal-typing rate or in any `StrategyTest` case; opening time of the keyboard no worse than 20% above today.

### What was delivered for es in 1.86.1 (and where it differs from the design)
Pipeline: `docs/tools/corpus/` (README there): `mr-corpus-samples.yml` (the runner that downloads the samples), `prepare_corpus.py` (clean + hold-out), `make_pack_data.py` (counts, mix, vocabulary, frequencies, pairs, trigrams), then `build_dict.py --format 2`.

| Design | What was done | Why |
|---|---|---|
| Hold-out by `hash % 20` on the sentence, excluded from every count | Done on the **distinct** sentences (md5 % 20 == 0), so a sentence that the subtitles repeat 100,000 times cannot leak. Three hold-outs: subtitles (`holdout_30k.txt`, 20,000 used), Tatoeba (1 in 20) and news (1 in 50) | one register must not hide a loss in another |
| Fair comparison with the old pack | The old pack is **rebuilt with the old scripts on the same splits** (`base_recipe`) and compared with that, not with the shipped es 3 | the shipped es 3 has seen the sentences of its own Tatoeba export (it looked better than the rebuilt old recipe on the Tatoeba hold-out only because of that) |
| Mix 60 / 20 / 15 / 5 (subtitles / Tatoeba / news / AOSP) | **45 / 25 / 30** (subtitles / chat / news); the AOSP list is not a source of counts: its frequency is blended in (5% when a word has 30+ real occurrences, more when it has fewer) | 60 / 20 / 15 lost 1.2 to 4.3 points on news; 45 / 25 / 30 got back 0.5 to 2.0 of them and cost 0.3 to 0.5 on subtitles |
| Frequencies calibrated | Recomputed for every word from the weighted counts (`f = 24.47 * log10(count) + 39.88`, fitted on the AOSP words, R² 0.35), blended with the AOSP value; new words get f - 10 (30..180); vulgar words f = 5; possibly-offensive words never predicted | the AOSP scale is kept so the old and new words sit on one scale |
| Words from the corpus | Hunspell (es_ES, es_MX, es_AR) as the filter, 3+ real occurrences; frequent words the speller refuses (150+ occurrences, 2+ sources, lowercase 60%+); names seen 20+ times in the middle of a sentence; the accent-free form of a word of the list and function words of English quoted in the subtitles are refused; **a new word that is also an English or German word needs 150+ occurrences or 15+ in the news sample** (the speller accepts `tell`, `home`, `der`; a first filter with Portuguese, French and Italian too threw out `tsunami`, `vegano`, `ambientalista`) | 242,364 words (was 239,683); the report of the run lists every new word for a person to read |
| Pairs: 1,000,000+, selection by P with a floor | **647,009** pairs (was 340,000), up to 60 per word (the lib limit), the top 3 of each word always kept, 2+ real occurrences; the floor stays at 0 | the data decides: 1 occurrence gives +1.7 MB for +0.0 to +0.3 points on subtitles and **loses** on news; 3 occurrences saves 1 MB and loses up to 0.5 |
| Larger `trigrams.bin` | 38,947 words / 285,946 contexts, 4,882,809 bytes (was 3,462,246); contexts with 6+ real occurrences, trigrams with 2+ | 4 / 2 gives 5.4 MB for the same hit rate as 6 / 2; 8 / 3 (2.9 MB) loses 0.2 to 0.6 points after the space |
| Targets: after the space +8 points, es 3 letters ≥ 70% | **Not reached, and the targets were wrong**: they came from the top-10,000 frequent-sentence benchmark, which the old pack has partly seen. On sentences nobody counted: after the space +2.8 (subtitles) and +0.6 (chat); 3 letters 53.7% / 61.0% | doubling the subtitle sample adds only 0.3 to 0.4 points after the space, so more data would not close that gap; the table below has the real numbers |
| No drop in any `StrategyTest` case; opening time ≤ 20% above today | StrategyTest: 0 failures (native and Java, 3 languages), **6 es gaps fixed** (`gola`, `bamos`, `ombre`, `vam`, `gr`, `por` → favor), S28 floors held; PromoEval: wrong swaps of correct words 0.14% → 0.01%, right word at the center 49.7% → 54.7%. Per key on the PC: after a space +12%, 2-4 letters +6%, 5+ letters 0%; reading `trigrams.bin` 3.4 → 4.3 ms. Opening time on a phone is **not measured** (device checklist) | |

Hold-out results (hit among the 3 suggestions after the space / 1 / 2 / 3 letters typed; words of 4+ letters; each sentence once):

| Hold-out | old recipe, same splits | es 4 |
|---|---|---|
| subtitles (distinct sentences) | 8.4 / 20.9 / 32.5 / 46.6 | 11.2 / 24.9 / 38.3 / 53.7 |
| Tatoeba (chat) | 15.4 / 30.7 / 43.1 / 57.1 | 16.0 / 31.8 / 45.7 / 61.0 |
| news | 10.6 / 23.0 / 34.2 / 49.4 | 10.3 / 21.8 / 32.1 / 47.9 |

News is the one register that loses (1.2 to 2.1 points from 1 letter on); it is the price of putting conversation first, and the weight of news (30%) is the knob if that has to change.

### What was delivered for pt-BR in 1.86.1 (the same pipeline; what is different)
Command and the list of steps: `docs/tools/corpus/README.md`. The sources are OpenSubtitles2018 `pt_br` (a 1/64 sample: 19.3 million word tokens), Tatoeba (3.0 million) and Leipzig `por_news_2024_1M` (18.9 million); weights per occurrence subs 1.000, chat 3.519, news 0.680 (mix 45 / 25 / 30, kept from es; it was **not** tuned again for pt-BR).

| Topic | What was done | Why |
|---|---|---|
| Base list | The base of the counts is the list of the **old recipe rebuilt on the same splits** (it keeps the cleaning of the old pt-BR list: 1990 spelling agreement and Lusitanian forms out); the raw AOSP `pt_BR` list is used only to know which words are possibly offensive (150) | the raw AOSP list has the European forms that the old recipe had already removed |
| European Portuguese | Taken out **by sentence** with markers (`prepare_corpus.py --drop-european-pt`: `PT_PT_RE`, and `PT_PT_WIDE_RE` for Tatoeba only) and the credit lines of the subtitles (`CREDIT_PT_RE`) | **Limit:** the workflow artifact has no Leipzig source names and no Tatoeba authors, so the filter by site or by author of `split_br.py` could not be used; a European sentence without a marker still counts, with its weight |
| Frequencies | `f = 24.80 * log10(count) + 38.54` (R² 0.44, 39,428 words), blended with the AOSP value; 97,491 of 175,907 base words changed; 7,170 new words accepted by the speller (`pt_BR` Hunspell), 10 names | same rule as es |
| Words of another language | English and German lists (`--foreign-list en --foreign-list de`): 2,313 new words refused. **Test without the filter:** 43 more words, nearly all English (`aches`, `bacons`, `crackers`, `ignores`, `monopolize`) or foreign names, so the filter stays | Portuguese shares few word forms with English and German |
| Swear words and their inflections | `vulgar_re` (in `make_pack_data.py`): `cago`, `fodeu`, `merdinha`, `foda-se`... 59 words are treated like the vulgar list: f = 5 and never predicted. The same rule exists for es | the subtitles are full of them and the AOSP list only has the base forms |
| Result | 183,088 words (was 173,822); 674,241 pairs (was 400,000), up to 60 per word, top 3 guaranteed; `trigrams.bin` with 38,877 words / 307,566 contexts, 5,176,682 bytes (was 30,618 / 169,258); `main.dict` 5,905,022 bytes in **format v2** (it does not fit the 4 MB of v1), `minApp` 1086000 | |
| `StrategyTest` | 0 failures (native and Java, 3 languages). **Three pt-BR gaps fixed:** `tudo _` → bem, `to` → tô, `pr` → pra. Two cases were changed because the new list no longer has the old words: `aida` (the lowercase word is gone, so the 'valid but rare word' test uses `semper` → sempre and `quase semper`) and `prota` → porta (`pro tá` now takes the reserved slot, and `deposi` → depois, 34 completions, is the new example; in the app `prota` still shows `porta` as the 6th suggestion) | |

Hold-out results (same measure as above; each sentence once):

| Hold-out | old recipe, same splits | pt-BR 6 |
|---|---|---|
| subtitles (distinct sentences) | 10.5 / 25.4 / 36.1 / 51.7 | 13.8 / 30.2 / 41.8 / 58.8 |
| Tatoeba (chat) | 18.6 / 35.4 / 46.3 / 59.9 | 19.0 / 36.6 / 48.0 / 63.4 |
| news | 14.4 / 27.6 / 37.2 / 51.8 | 14.2 / 26.8 / 36.1 / 51.6 |

The shipped pt-BR 5 gets 28.2 / 45.1 / 55.4 / 66.7 on the chat hold-out, because it was built with those very sentences; it is not a fair baseline (on the subtitles, which it did not see, it gets 10.5 / 25.3 / 36.1 / 51.8, the same as the rebuilt old recipe). The gain after the space is +3.3 points on subtitles and +0.4 on chat; with 3 letters +7.1 and +3.5. News loses 0.2 to 1.1 points, less than es, and the typing checks agree: `CorrEval` (synthetic typos, first place / among the 3) 81.3 / 91.4 → 81.8 / 92.0. `PrefixEval` (no context, the prefix alone) shows the register trade-off: with 2 letters news falls from 13.5% to 9.2%, and with 3 letters chat rises from 39.7% to 48.0% and subtitles from 40.0% to 50.1%.

`PromoEval` (10,000 subtitle sentences of the hold-out): among the correctly typed words a wrong word reaches the center in 0.16% → 0.02% (weighted); among the real-word errors the right word reaches the center in 51.7% → 56.5%, stays in the 3rd place in 17.0% → 12.6%, and a wrong one is promoted in 3.9% → 3.9%. Per key on the PC (native engine, 800 sentences x 3 rounds): after a space 73.2 → 78.0 µs (+7%), 1 letter 48.4 → 51.0 (+5%), 2 to 4 letters 209.0 → 219.5 (+5%), 5 or more 249.4 → 240.9 (-3%), typo 383.3 → 388.7 (+1%), valid word 98.7 → 90.7 (-8%); reading `trigrams.bin` in the native store 2.5 → 4.9 ms (3.02 → 5.18 MB, so about 2.7 MB more native memory with the index). Native/Java parity on pt-BR 6: 10,967 correction queries, 2,000 suggestion lists and 24,000 trigram queries, 0 differences. Opening time on a low-end phone: still to be measured on a device.

### What was delivered for en-US in 1.86.1 (the same pipeline; what is different)
Command: `docs/tools/corpus/README.md`. The sources are OpenSubtitles2018 `en` (a 1/128 sample: 17.4 million word tokens), Tatoeba (13.9 million; 2.0 million distinct sentences, the biggest of the three languages) and Leipzig `eng_news_2025_1M` (19.0 million); weights per occurrence subs 1.000, chat 0.692, news 0.609 (mix 45 / 25 / 30, as in the other two). The old pack for the comparison is `make_wordlist_en.py` + `make_trigrams.py` on the same splits (Tatoeba weight 1); it reproduces the shipped en-US 4 almost to the digit (subtitles 12.1 / 29.4 / 42.8 / 62.8% against 12.1 / 29.4 / 42.9 / 62.9%), which is why it is a fair baseline here.

| Topic | What was done | Why |
|---|---|---|
| Base list | The raw AOSP `en` list (165,120 words); nothing to clean first | the English list has no variant to remove |
| Mix | 45 / 25 / 30 kept. Tested: 55 / 25 / 20 gives +0.1 to +0.3 on subtitles and **-0.5 to -0.8 on news**, so the news share stays | news is the only register that moves with that knob |
| Frequencies | `f = 26.77 * log10(count) + 38.11` (R² 0.51, 31,328 words), blended with the AOSP value; 86,450 of 165,120 base words changed; 9,391 new words accepted by Hunspell `en_US`, 12 frequent ones the speller refuses (`goin`, `doin`, `crypto`, `chatbot`...), 187 names | same rule as es and pt-BR |
| Capitalised twins | A capitalised word that has a lowercase twin (`Nice`, `Good`, `Hi`, `Will`) counts only the occurrences **inside** a sentence (`cap_mid_only`) | the first build gave `Nice` f 130 next to `nice` 149 (it counted every "Nice!" that opens a sentence), and `nife` lost `knife` from the first three suggestions: caught by the `StrategyTest` case S9. es and pt-BR have only 4 and 24 such words, so the rule is only on for English |
| Apostrophes | The form without the apostrophe of a word of the list is never a new word (274 refused: `dont`, `wouldnt`...) | `dont` as a word would stop the correction to `don't` (`rules.txt`) |
| Subtitle noise | Stutters (`i-i`, `w-what`, `wh-what`: 71), compounds with a contraction (21), `A's` / `B's` (21), the HTML residues `quot`, `amp`, `nbsp`; credit lines (`CREDIT_EN_RE`) | the speller accepts them |
| Words of another language | Spanish, German, French and Italian lists, but **only for words of up to 5 letters without a hyphen** (663 refused). With all words, 221 real English words were refused (`barista`, `quinoa`, `e-mails`, `bye-bye`, `kickboxing`), because the other lists hold English loanwords and compounds | what the English speller lets through of a foreign language is abbreviations and fragments (`est`, `fir`, `cis`, `dis`, `res`) |
| Swear words | `vulgar_re` for the inflections (`fuckin`, `shitty`, `bitching`...: 31 words) and a short list of slurs (`Japs`, `Negroes`...) get f = 5 and are never predicted | |
| Result | 174,718 words (was 168,992); 645,166 pairs (was 400,000); `trigrams.bin` 30,039 words / 316,351 contexts, 5,190,934 bytes (was 18,127 / 142,509); `main.dict` 5,786,205 bytes in **format v2**, `minApp` 1086000 | |
| `StrategyTest` | 0 failures (native and Java, 3 languages). **Three en-US gaps fixed:** `thank you _` → so, `see you _` → later and `ye` → yeah. Still open: `how _` → are, `good _` → morning, `fone` → phone, `tiktok` | |

Hold-out results (same measure as above; each sentence once):

| Hold-out | old recipe, same splits | en-US 5 |
|---|---|---|
| subtitles (distinct sentences) | 12.1 / 29.4 / 42.8 / 62.8 | 14.3 / 33.2 / 47.5 / 67.9 |
| Tatoeba (chat) | 16.9 / 34.0 / 46.9 / 65.3 | 17.0 / 34.4 / 47.9 / 67.9 |
| news | 12.1 / 24.3 / 35.7 / 53.9 | 12.0 / 24.1 / 35.5 / 53.9 |

The shipped en-US 4 gets 18.3 / 35.2 / 48.1 / 66.2 on the chat hold-out (it was built with those sentences: 1.4 points above the rebuilt old recipe after the space) and 12.1 / 29.4 / 42.9 / 62.9 on the subtitles. The gain is +2.2 points after the space on subtitles and +5.1 with 3 letters, +0.1 / +2.6 on chat, and **news does not lose** (0 to -0.2): the English news corpus and the subtitles agree more than in Spanish or Portuguese.

The typing checks agree. `CorrEval` (synthetic typos, first place / among the first two): 79.6 / 89.8 → 81.3 / 90.5. `PrefixEval` (no context, the prefix alone, 6,000 words of each hold-out), 2 letters / 3 letters: subtitles 19.1 / 55.0 → 27.1 / 63.9%, chat 17.1 / 53.3 → 23.5 / 59.6%, news 17.5 / 47.7 → 19.1 / 47.1%. `PromoEval` (10,000 subtitle sentences, shipped en-US 4 → en-US 5): a wrong word reaches the center in 0.11% → 0.02% of the correctly typed words; among the real-word errors the right word reaches the center in 32.2% → 43.3%, stays in the 3rd place in 8.4% → 10.8%, and a wrong one is promoted in 3.9% → 4.3% (English still has the weakest context: 36.3% of the errors get nothing, 51.3% before). Per key on the PC (native engine, 800 sentences x 3 rounds, en-US 4 measured twice → en-US 5): after a space 70.3 → 78.3 µs (+11%), 1 letter 46.4 → 51.0 (+10%), 2 to 4 letters 191.5 → 205.7 (+7%), 5 or more 242.0 → 247.7 (+2%), typo 328.3 → 341.0 (+4%), valid word 87.5 → 88.4 (+1%); reading `trigrams.bin` in the native store 2.0 → 4.3 ms (file 2.35 → 5.19 MB and index 0.64 → 1.39 MB, so about 3.6 MB more native memory). Native/Java parity on en-US 5: 11,183 correction queries, 2,000 suggestion lists and 24,000 trigram queries, 0 differences. Opening time on a low-end phone: still to be measured on a device.

## Phase 5 - v1.87.0: prediction smoothing and closing
- **Smoothing** (item 2 of `engine-improvements.md`): replace the fixed `TRIGRAM_BONUS` by a back-off between trigram, bigram and unigram frequency, plus a small weight for the user's pairs and recent words; evaluate with `SubtitleEval` (hold-out), not by hand.
- Re-run the whole benchmark and the strategy tests; update `suggestion-features.md` (data table, S29, limits, known gaps), `engine-improvements.md` (point here, then remove what was done) and the version notes.
- **Decision to take with the user before closing: remove the Java fallback of the search?** Asked by the user in 1.86.0 ("the C++ lib always exists and is better"). The agent must raise it (one `AskUserQuestion`) before deleting this file, with the facts in item 9c of `engine-improvements.md`: what the Java search still does (first keystrokes while the lib loads in the background, a refused query, a lib that does not load, and **the reference for the parity test**), what leaving it out saves (a few tens of KB of dex, no speed, no maintenance unless the parity reference is also dropped) and the option that keeps the tests (move the Java search to the test tree, ship only the native engine, load the lib synchronously on the first key). If the user says keep it, record that in `native-engine.md` and close the item.
- Delete this file in the release commit.

## What the SDK range changes (minSdk 26 → targetSdk 37)
Detail and sources are in "Limits" in `suggestion-features.md`. For this plan:
- No framework limit on the number of suggestions of an IME that draws its own strip: the limits are the app's constants (12 in `Suggest`, 3 slots in the strip). Raising the strip beyond 3 is a layout decision, not an SDK one.
- 26+: `IME_FLAG_NO_PERSONALIZED_LEARNING` works from the minimum version (already respected). 23+: the system user dictionary is readable only by an enabled IME, so no permission is needed. 31+: `getSurroundingText` gives one snapshot for re-correction (older versions use two reads). 35+: 16 KB pages (both libs already link for it).
- Screens A and B use only the system file picker (`ACTION_OPEN_DOCUMENT`, `ACTION_CREATE_DOCUMENT`), so there is **no storage permission on any version**, and no network permission.
- ABI: `x86_64` is in `lib/` since 1.84 (item 1.6); 32-bit ARM and x86 stay while minSdk is 26.

## What I need from you (links to download)
From here I can reach GitHub but not the corpus sites (they answer 403), so please download and send. **Easiest: a GitHub runner does the downloads** (a phone would pull 2 GB per language): copy `docs/tools/corpus/mr-corpus-samples.yml` to `.github/workflows/` of a repository where you run workflows by hand (a private one: the OpenSubtitles text has no clear licence), run *Mr Keyboard - corpus samples*, download the artifact of each language (`corpus-es` is already used; **still needed: `corpus-pt-BR`, then `corpus-en-US`**) and send it. It holds the same three things listed below (OpenSubtitles sample, Tatoeba, Leipzig) plus a `SUMMARY.txt` with sizes and counts. By hand, the commands are:
1. **OpenSubtitles 2018, one file per language** (the main base). If the pattern fails, open <https://opus.nlpl.eu/OpenSubtitles-v2018.php> and take the *mono* (plain text) column for `pt_br`, `en`, `es`. The files are large, so keep only a sample while downloading (every 8th line keeps whole sentences, which is all the counts need):
   ```
   curl -L https://object.pouta.csc.fi/OPUS-OpenSubtitles/v2018/mono/pt_br.txt.gz | gunzip | awk 'NR%8==0' | gzip > pt_br.sample.txt.gz
   curl -L https://object.pouta.csc.fi/OPUS-OpenSubtitles/v2018/mono/es.txt.gz    | gunzip | awk 'NR%8==0' | gzip > es.sample.txt.gz
   curl -L https://object.pouta.csc.fi/OPUS-OpenSubtitles/v2018/mono/en.txt.gz    | gunzip | awk 'NR%8==0' | gzip > en.sample.txt.gz
   ```
   (Send them in the chat; if one is too big for the chat, use `NR%16==0`.)
2. **Tatoeba, per language** (already used, needed again as a source of the rebuild): `https://downloads.tatoeba.org/exports/per_language/por/por_sentences.tsv.bz2`, `.../eng/eng_sentences.tsv.bz2`, `.../spa/spa_sentences.tsv.bz2`. If a link changed, the list is at <https://tatoeba.org/en/downloads> (*Sentences*, per language).
3. **Leipzig news** (already used, same files as the current packs): `por_news_2024_1M`, the English and Spanish news files you used before.
4. Nothing else is needed: the frequency lists of `hermitdave/FrequencyWords` and the sentences of `orgtre/top-open-subtitles-sentences` come from GitHub, which I can read.

## Risks
| Risk | Answer |
|---|---|
| Context while typing makes the strip noisy (a context word beats the right completion) | at most 2 context candidates; measured on 2/3/4 letters and on normal typing before release; one constant to switch it off |
| Format v2 breaks old apps | `minApp` in `pack.json` (an old app keeps its v1 pack and says it needs a newer app); the libs read v1 and v2 by header; parity tests on both (done in 1.86.0) |
| A big import slows the keyboard or uses too much heap | caps, background import, `MrWordStore` measured at the caps, opening-time check |
| Imported typos become "valid" words | two-occurrence rule, preview with checkboxes, undo, "Imported" filter |
| Learned data is lost on a new phone | export/import in the standard format (the databases are not in the Android backup on purpose) |
| Subtitle text and licences | only counts are published; the notice says it; fallback recipe with clean sources |
| Valid-word suggestion annoys | slot 3 only, ratio threshold, guard test over thousands of valid words, never automatic |
| smali edits (`Suggest`, `LatinIME`) | `smali_regcheck.py`, `check_java_smali.sh`, `verify_dex.sh` and the strategy tests run in CI |

## Order and dependencies
1. Phase 1 is delivered in 1.84.0.
2. Phase 2 is delivered in 1.85.0 (it was independent of the data).
3. Phase 3 is delivered in 1.86.0 (it had to be released before the first v2 pack).
4. Phase 4: es and pt-BR are delivered in 1.86.1 (one release, by the user's choice); en-US (the corpus artifact arrived last) is in the same release.
5. Phase 5 closes the plan.
