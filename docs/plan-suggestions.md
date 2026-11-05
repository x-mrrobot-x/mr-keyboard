<!-- target-version: v1.87.0 -->
# Plan: better correction, suggestion and precision

Written on 1.83.0. Delete this file in the release commit of the target version (`check_version.py` warns when it is reached).
What exists today is in `suggestion-features.md` (ids S1...S25 are the tags of `docs/tools/e2e/StrategyTest.java`); the remaining items
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
Everyday-language benchmark: the 10,000 most common sentences of OpenSubtitles 2018 (`orgtre/top-open-subtitles-sentences`), words of 4 or
more letters, previous words as context, hit = the word is among the 3 predictions after the space, or among the 2 suggestions next to the typed word
after 1, 2 or 3 letters. Run it with `docs/tools/e2e/run_subtitle_eval.sh` (the sentences are not in the repository; the script says where to get them).
The sentences are not the training data of any pack. Weighted by how often each sentence occurs:

| | pt-BR | en-US | es |
|---|---|---|---|
| Words of the sentences that the dictionary knows | 99.7% | 99.6% | 99.8% |
| Right word among the 3 predictions after the space | 34.5% | 31.9% | 27.5% |
| ... among the 2 suggestions after **1** letter | 58.9% | 58.3% | 50.0% |
| ... after **2** letters | **48.5%** | **51.6%** | **37.7%** |
| ... after **3** letters | 72.0% | 83.5% | 55.6% |
| Prototype: context kept while typing, **2** letters | 68.0% | 67.5% | 57.5% |
| Prototype: context kept while typing, **3** letters | 79.8% | 84.5% | 68.1% |

What this says:
1. **The vocabulary is not the problem** (99.6-99.8% of the words are known). The ranking is: frequencies and word pairs come from news.
2. **The context is thrown away after the first letter.** `Suggest` only asks for the previous word's bigrams when 1 letter is typed
   (`getBigrams` branch with `composer.size() == 1`); from the 2nd letter on only the plain frequency list is used, so the hit rate *falls* from 1 to 2
   letters in all three languages (pt-BR 58.9 → 48.5). A prototype that keeps the previous words' candidates (bigrams, trigrams, user pairs) for
   the typed prefix recovers +16 to +20 points at 2 letters and +1 to +12 at 3 (`SubtitleEval -Dctx=A`). This is the best gain per hour of work in the whole plan.
3. **es is the weakest** (3 letters: 55.6% against 83.5% in en-US): its frequencies are the least reliable (`hola` has frequency 78 and loses to `bola`/`golazo` for `gola`).
4. The correction strategies themselves work: `StrategyTest` (about 85 checks per language, native and Java) and the Java x C++ parity are green; the
   failures it records (`GAP`) are data or structure, not bugs (see "Known gaps" in `suggestion-features.md`).

## Phase 1 - v1.84.0: context while typing and quick wins (no new data, no format change)
| # | Item | How | Check |
|---|---|---|---|
| 1.1 | **Context while typing (2 to 4 letters)** | In `Suggest.getSuggestions`, next to the `MrPredict.firstLetter` call, also for `composer.size()` 2..4: add the previous-words candidates that start with the typed prefix (accent and case ignored, like `sameInitial`) as `BigramDictionary` entries, keeping at most 2 so the normal completions still come in. New `MrPredict.complete(suggest, composer, prev)` (reads the candidates `forWords` already built: `sWord/sMain/sUser`). Java first, then it is only smali glue: no change in the C++ engine | new strategy **S26** in `StrategyTest` (e.g. pt `muito ob` → obrigado, en `thank yo` → you, es `muchas gr` → gracias); `SubtitleEval` 2 letters must be ≥ 1 letter in the 3 languages |
| 1.2 | **Valid word that is probably another word** (suggestion only) | In `MrFuzzy.finish`, when the typed word is valid and a candidate with cost ≤ 1 error is ≥ 50× more frequent, offer it in the 3rd strip slot. Never in the autocorrect decision (`hasMinimalCorrection` stays false for valid words) | `StrategyTest` cases `cassa`→casa, `fone`→phone, `ombre`→hombre go from `GAP` to `FIXED`; guard: 2,000 valid words from the subtitle sample must keep their own slot 0 and no new alternative may appear for more than 3% of them |
| 1.3 | **Accuracy gate in CI** (item 8 of `engine-improvements.md`) | Write about 300 *original* everyday sentences per language (no corpus text, so no license issue) in `docs/tools/e2e/data/everyday_<lang>.txt`; `StrategyTest` computes the same 4 rates as `SubtitleEval` on them and fails below a floor set 2 points under the value measured at the release | `mr-checks.yml` already runs `run_strategy_tests.sh` (and now also when only `dicts/**` changes) |
| 1.4 | **Move `PacksTest` (63 checks) and `ThreeLangTest` (23) to CI** | they only need the PC native lib that `mr-native.yml` builds | CI step |
| 1.5 | **Data patches until the rebuild** | `rules.txt`: `flw`, `pix`, `whatsapp`/`wpp`, `uber`, `ifood`, `tiktok`, `pa`, `wasap`; fix the `visavis` target; raise `tá`, `né` and other chat words to a believable frequency (list from FrequencyWords) | `StrategyTest` D3 (targets exist) and the `GAP` cases for chat words |
| 1.6 | **`x86_64` libs** | `lib/` has `arm64-v8a`, `armeabi-v7a` and 32-bit `x86`, but no `x86_64`; a 64-bit-only x86 device or emulator image cannot load the 32-bit libs, and without `libjni_pckeyboard.so` there is no dictionary at all there (confirm on a current x86_64 image first) | `mr-native.yml` builds a 4th ABI for both libs; `verify_dex.sh`/the APK check lists it |

## Phase 2 - v1.85.0: two new screens
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
- `StrategyTest` S27 (imported word completes with 2 letters; blocked word never shows; imported pair raises the prediction).
- Device checklist (SQLite and screens, as S16 needs Android): upgrade over 1.84 keeps learned words; delete a word and see it disappear from the strip at once; block; import 5,000 words and watch the heap and the keyboard opening time; export on one phone, import on another; rotate the screen during an import; password field still learns nothing.

## Phase 3 - v1.86.0: dictionary format v2 (up to 16 MB)
Why: the packs use 88-90% of the 22-bit address space and subtitle data needs more words and pairs. A `.dict` address is 6 bits in the flags byte + 2 bytes (`0x40` children, `0x80` terminal) and bigrams carry a 3-byte address.
- New header value (format v2, `main.dict` header `200/2`) with 24-bit group addresses and 4-byte bigram addresses (about +0.7 MB for the same content). Readers to change together: `native/src/dictionary.cpp`, `engine/src/mr_fuzzy.cpp` (3 places), `MrFuzzy.java` (`prefixRec`, `walk`, `lookupRec`, `skipBigrams`), and `build_dict.py` (`ADDRESS_LIMIT`, its own re-read check). The libs stay compatible with v1 files (the header decides).
- `pack.json`: `format: 2`, `minApp: 1.86.0`. An older app keeps the v1 pack it has; the catalog only offers v2 to apps that can read it (`make_catalog.py` + `test_make_catalog.py`).
- Memory: the dictionary is read into a direct buffer, one language at a time; 16 MB is acceptable, but measure the opening time of the keyboard with a 16 MB pack on a low-end device.
- Checks: `run_native_parity.sh` and `StrategyTest` with a v2 pack in 3 languages; a round trip on `build_dict.py` with more than 4 MB; `dict_test.cpp` reads every word and pair back.

## Phase 4 - v1.86.x (packs only) and v1.87.0: new everyday dictionaries
Needs the corpus files listed below. Packs are published through the catalog; the app does not change after phase 3.
1. **Counts, not text.** Per language, from OpenSubtitles (`mono`, one sentence per line): clean (drop lines with timestamps, `[music]`-style tags and lines under 2 words), normalise (case, apostrophes, spelling per variant: pt-BR only; remove European Portuguese markers as in `split_br.py`), count unigrams, in-line bigrams and trigrams. The text itself is never stored or distributed.
2. **Hold-out first.** A sentence goes to the *test set* when `hash(sentence) % 20 == 0` and is excluded from every count. All dictionaries (old and new) are evaluated on that same set with `SubtitleEval`, so the comparison is fair (the top-10,000 benchmark above is for the current packs only, because those sentences are very frequent and would leak into new counts).
3. **Mix.** Starting weights: subtitles 60%, Tatoeba 20%, news 15%, AOSP list 5%; tune on the hold-out by the 4 rates (after space, 1, 2, 3 letters) plus the normal-typing rate of `StrategyTest`. News stays for the formal vocabulary (so `previdência` is still there) but stops deciding the order.
4. **Words.** AOSP list as the base spelling filter (as today); words are added from the corpus when they appear in at least two sources or N times in subtitles; frequent English loanwords (`ok`, `bye`, `deploy`, `link`, `feedback`) and brands/apps are kept in pt-BR and es when they pass the same count rule. Offensive words stay as today (never predicted).
5. **Pairs and trigrams.** More pairs per word where the format v2 allows (today 400,000 with up to 60 per word; the target is 1,000,000+ pairs and a larger `trigrams.bin`, bounded by the 16 MB and by the time to open). Pair selection by P(next | previous) with a floor, not only raw count.
6. **Frequencies calibrated per language**, starting with es (hola/bola, bamos → vamos) and the chat words of `rules.txt` (`tá`, `né`, `kkk`, `pq`...), checked by the `GAP` cases of `StrategyTest`.
7. **Release.** Packs pt-BR 5, en-US 4, es 3, each with `NOTICE.txt` (credits and the licences of the sources; the licence of OpenSubtitles text is not clear, which is why only counts are published, and the notice says so). If the strict legal view matters, the pack can be built from Tatoeba + Common Voice + news alone with the same scripts (lower quality, clean licences).
8. **Targets** (to be fixed after the first hold-out comparison): after the space +8 points over the old pack on the same hold-out; 3 letters in es ≥ 70%; no drop in the normal-typing rate or in any `StrategyTest` case; opening time of the keyboard no worse than 20% above today.

## Phase 5 - v1.87.0: prediction smoothing and closing
- **Smoothing** (item 2 of `engine-improvements.md`): replace the fixed `TRIGRAM_BONUS` by a back-off between trigram, bigram and unigram frequency, plus a small weight for the user's pairs and recent words; evaluate with `SubtitleEval` (hold-out), not by hand.
- Re-run the whole benchmark and the strategy tests; update `suggestion-features.md` (data table, S26/S27, limits, known gaps), `engine-improvements.md` (point here, then remove what was done) and the version notes.
- Delete this file in the release commit.

## What the SDK range changes (minSdk 26 → targetSdk 37)
Detail and sources are in "Limits" in `suggestion-features.md`. For this plan:
- No framework limit on the number of suggestions of an IME that draws its own strip: the limits are the app's constants (12 in `Suggest`, 3 slots in the strip). Raising the strip beyond 3 is a layout decision, not an SDK one.
- 26+: `IME_FLAG_NO_PERSONALIZED_LEARNING` works from the minimum version (already respected). 23+: the system user dictionary is readable only by an enabled IME, so no permission is needed. 31+: `getSurroundingText` gives one snapshot for re-correction (older versions use two reads). 35+: 16 KB pages (both libs already link for it).
- Screens A and B use only the system file picker (`ACTION_OPEN_DOCUMENT`, `ACTION_CREATE_DOCUMENT`), so there is **no storage permission on any version**, and no network permission.
- ABI: add `x86_64` (item 1.6); 32-bit ARM and x86 stay while minSdk is 26.

## What I need from you (links to download)
From here I can reach GitHub but not the corpus sites (they answer 403), so please download and send:
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
| Format v2 breaks old apps | `minApp` in the catalog; the libs read v1 and v2 by header; parity tests on both |
| A big import slows the keyboard or uses too much heap | caps, background import, `MrWordStore` measured at the caps, opening-time check |
| Imported typos become "valid" words | two-occurrence rule, preview with checkboxes, undo, "Imported" filter |
| Learned data is lost on a new phone | export/import in the standard format (the databases are not in the Android backup on purpose) |
| Subtitle text and licences | only counts are published; the notice says it; fallback recipe with clean sources |
| Valid-word suggestion annoys | slot 3 only, ratio threshold, guard test over thousands of valid words, never automatic |
| smali edits (`Suggest`, `LatinIME`) | `smali_regcheck.py`, `check_java_smali.sh`, `verify_dex.sh` and the strategy tests run in CI |

## Order and dependencies
1. Phase 1 can start now (it needs nothing from you).
2. Phase 2 is independent of the data and can run while you download the corpus.
3. Phase 3 must be released before the first v2 pack.
4. Phase 4 starts when the files arrive; es first (largest gap), then pt-BR, then en-US.
5. Phase 5 closes the plan.
