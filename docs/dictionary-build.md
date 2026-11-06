# 1.6.0 — Suggestions: new dictionary with bigrams, approximate correction, prediction and learning

## Request
"Balanced" package from the suggestions research, 100% offline:
- larger and cleaner pt-BR dictionary, with word pairs (bigrams) from the Leipzig corpus (CC BY);
- correction beyond the prefix: extra or missing letter, swapped letters, phonetic errors, missing space, error map and abbreviations;
- next-word prediction after the space (up to 3, the best in the center; with no prediction, the punctuation from before);
- learning working whenever suggestions are on, never in a password or incognito field;
- defaults kept: suggestions and autocorrection stay off.

## What changed
| Item | 1.5.9 | 1.6.0 |
|---|---|---|
| `res/raw/main_pt.dict` | old format, ~165 thousand words, no bigrams, 1.92 MB stored uncompressed | "latest" format (header 200/1), 174,722 words, 400,000 bigrams (news + Tatoeba conversation), 3.71 MB (format limit: 4 MB), compressed in the APK |
| Spelling | had idéia, freqüência, vôo, pára, projecto, della, vous, the... | 1990 Orthographic Agreement spelling, no Lusitanian variants, no foreign function words and no English that is not used in Portuguese |
| New words | — | segunda-feira, bem-vindo, e-mail, trata-se, streaming, podcast, criptomoedas, WhatsApp, Instagram, Bolsonaro, chat slang and abbreviations (vc, tbm, pq, kkk, rs, perrengue, crush...) |
| 1st letter typed | bigrams only in modes 1 and 3 and only with the exact same letter | whenever there are suggestions; accepts accent and uppercase (e → é, está) |
| Errors outside the prefix | only neighboring key and one extra letter | + missing letter, swapped letters, phonetic (s/z/ç, ch/x, g/j, silent h), doubled letter, missing space, ~200 corrections and abbreviations |
| After the space | punctuation | up to 3 predictions (2nd, 1st in the center, 3rd); with no prediction, punctuation |
| Learning | only with autocorrection on, and then the learned bigrams were never read | whenever suggestions are on; never in a password or with `IME_FLAG_NO_PERSONALIZED_LEARNING` |
| Autocorrection on | mode 2 (no bigrams) | mode 3 (with bigrams) |
| Version | 1059000 / v1.59.0 | 1060000 / v1.60.0 (`apktool.yml` and `apktool.json`) |

## How it was done
### Dictionary (`docs/tools/make_wordlist.py`, `build_dict.py`)
- Base: `pt_BR_wordlist.combined.gz` v54 from AOSP (Apache-2.0 + Lexiteria notice). I did not use the HeliBoard version because its repository is GPL-3.0 and does not state the dictionaries' license; the spelling update was redone in the script.
- Corpus: Leipzig `por_news_2024_1M` (CC BY 4.0), Brazilian sources only (`split_br.py`: removes .pt/.ao/.mz etc. domains, sites with pt-PT markers and two sites based in Portugal): 876,742 of 1,000,000 sentences. The test uses 5,262 sentences set aside from the 300 thousand file; the 804 of them that were also in the 1M file left the training set (858,403 sentences, 16.6 million words).
- VERO (pt-BR) and Hunspell en_US only as a filter; nothing from them is copied.
- Conversation: Tatoeba (CC BY 2.0 FR), 445,521 Portuguese sentences; 50 authors with European Portuguese markers (autocarro, estás a) were removed, along with the sentences with those markers and the repeated ones, and the names Tom and Mary (they appear in ~15% of the site's sentences). 378,366 sentences for counting, 19,914 for testing (`split_tatoeba.py`). In word pairs they count 3 times; in new words they count 1 time, so as not to inflate rare words.
- Pair selection: up to 3 per word guaranteed and the rest by count, up to 400,000.
- New words from the corpus: 5,816 accepted by VERO, 1,236 proper nouns, foreign words, neologisms, slang and abbreviations.
- Base cleanup (numbers in `docs/tools/report_list_1.6.0.txt`): 880 old spellings replaced, 538 foreign short lowercase words, 1,535 English words not used in Portuguese in the corpus, 203 Lusitanian variants, 53 function words from other languages, spelling errors (enquando, encontar, asim...), duplicated unaccented forms (familia, agua).
- Possibly offensive words (AOSP list): never appear as a prediction; 30 profanities stay at frequency 5 (they only appear when typed in full). The others (crianças, negro, peito: "children", "black", "chest") keep their frequency.
- Bigrams: count ≥ 2 within stretches without punctuation, up to 60 per word (the lib's limit), 7-bit frequency from P(next | previous).
- `build_dict.py` writes depth-first (the lib's bigram search does not work breadth-first) and re-reads the file with a Python copy of the lib's routines, checking every word, frequency and bigram.

### Java layer (`docs/tools/java/src`, converted to smali with `docs/tools/build_java.sh`)
- `MrText`: base letter without accent, initials with variants, last word before the cursor, repair of the accents the lib returns with a sign on x86, `learnable` (does not learn a suggestion with a space).
- `MrFix`: ~200 common errors and abbreviations (vc → você, concerteza → com certeza, excessao → exceção).
- `MrFuzzy`: approximate search in the same buffer as the .dict (no copy), with costs per type of error. It only runs if the typed word is not valid; 1st pass with one error, 2nd with two only for long words with no result; first letter restricted; cap of 12,000 nodes.
- `MrPredict`: prediction after the space, merging bigrams from the dictionary and from the user (weight 2 for the user).

### Smali
- `BinaryDictionary`: `getBigrams` passes initials with accent/uppercase (up to 96 codes) and repairs x86 accents; new `mrBuffer`, `mrLength`, `mrBigrams`.
- `Suggest`: bigrams on the 1st letter in any mode, filter by `MrText.sameInitial`; `MrFuzzy.afterWords` after the main dictionary; a single capital letter does not become "all caps"; new `mrMainDict`, `mrUserBigrams`.
- `LatinIME`: `updateCorrectionMode` (2 → 3), `checkAddToDictionary` (learns if `isPredictionOn`, without `mMrNoLearn`, without a space), `onStartInputView` (`mMrNoLearn` from `imeOptions & 0x1000000`), `setNextSuggestions` (`MrPredict.list`).
- `apktool.yml`/`apktool.json`: "dict" left `doNotCompress` (the .dict is read by `openRawResource` + `available()`, which works compressed on Android 8+).

## Validation (on the PC)
- `apktool b` with no errors; unsigned APK of 3.8 MB (1.5.9: 2.8 MB).
- Original native lib compiled on the PC (`dict_test.cpp`, with `-funsigned-char` as on ARM): 174,722/174,722 valid words; `getBigrams` returns exactly the 400,000 pairs written.
- End to end (`docs/tools/e2e/E2ETest.java`): real classes from the APK (dex2jar) + the PC's native lib. 26 of 27 checks correct (1st letter with bigrams, errors, map, abbreviations, prediction, the user's bigram in the center). The one that fails: "prota" shows protagonista instead of porta, because what was typed is still the beginning of a word and the lib's completions win.
- With the lib compiled as on x86 (signed char) the predictions with accents come out the same.
- Prediction: the right word among the 3 shown

| Dictionary | News, after the space | News, after the 1st letter | Conversation, after the space | Conversation, after the 1st letter |
|---|---|---|---|---|
| Leipzig 300 thousand | 25.3% | 47.6% | — | — |
| Leipzig 1M | 26.1% | 50.2% | 19.3% | 43.9% |
| **Leipzig 1M + Tatoeba (used)** | 25.4% | 49.2% | **25.1%** | **55.2%** |

  The conversation test is the Tatoeba sentences set aside for testing. The mix loses less than 1 point on news and gains 6 to 11 points on conversation.
- Synthetic errors on frequent words: the original appears among the 3 of the approximate search in 97%.
- PC time (Java with JIT): 0.20 ms per key on average, 0.76 ms at p99; prediction 0.06 ms. **I did not measure on the device**: I estimate 5 to 15 times more.

## Android tests required
1. Install over 1.5.9 (same signature). Open the keyboard: the dictionary loads (logcat without "Read ... bytes, expected").
2. Turn on suggestions. Type "muito " and see 3 predictions, the middle one in solid color; tap one and see the next.
3. After "bom ", type "d": "dia" must appear. After "ele ", type "e": "é" must appear.
4. Type obrogado, asim, omem, pesquiza, enchergar, concerteza, vc, tbm: the correction appears in the strip.
5. Autocorrection on: "obrogado" + space becomes "obrigado"; "vc" + space stays "vc".
6. Learning: choose the same prediction a few times after a word; it moves to the center.
7. Password field and the browser's incognito tab: nothing is learned (repeat test 6 there and check outside).
8. Timing: type long wrong words quickly; the strip must not lag. Measure the keyboard opening right after a restart.
9. x86 device or emulator: predictions with accents (after "não ") without strange characters.

## Licenses and credits
The credits live in `dicts/pt-BR/NOTICE.txt` (in 1.6.0: `res/raw/notice_main_pt.txt`): AOSP (Apache-2.0, Lexiteria), Leipzig Corpora Collection (CC BY 4.0, with the requested citation), Tatoeba (CC BY 2.0 FR), own lists. No sentence from the corpora is distributed, only counts.

## Limitations
- The "Traduzir" (Translate) button keeps sending the text to translate.googleapis.com when used (an existing function, outside this package).
- News corpus: predictions lean toward the journalistic register until learning adjusts to the user.
- "prota" → "porta" and other errors that form the beginning of another word only appear after the completions.

## Next steps
The native libraries are compiled with the NDK by GitHub Actions (`.github/workflows/mr-native.yml` and `native/`).

## Format v2 (1.86.0): dictionaries up to 16 MB
The 2nd byte of the header tells the formats apart (`build_dict.py` and the three readers agree on it):

| Header | Format | Address (group of children, bigram target) | Bigram entry | Size limit applied |
|---|---|---|---|---|
| `200, 1` (the readers also accept `200, 0`, the same layout; a pack must use 1) | v1 (the AOSP "latest" format) | 6 bits of the flags byte + 2 bytes = 22 bits | address (3 bytes) + frequency/continue byte = 4 bytes | 4,194,304 bytes |
| `200, 2` | v2 (since 1.86.0) | 6 bits of the flags byte + 3 bytes = 30 bits | address (4 bytes) + frequency/continue byte = 5 bytes | 16,777,216 bytes (a policy limit; the field holds more) |

Everything else is the same: a group is `[count]` + entries, an entry is a letter (1 byte, or `0xFF` + 2 bytes) + the flags byte (`0x80` terminal, `0x40` has children, low 6 bits the high part of the address) + the rest of the address + (terminal) the frequency + the bigram list. The file is still written depth-first, because a bigram points to the letter byte of the next word's terminal entry and the readers find the word back from that address. The same content takes about 0.7 MB more in v2 (a node with children has one more byte).

Commands (all `python3 -I docs/tools/build_dict.py ...`):
- `in.combined.gz out.dict [--format 1|2]` builds from the word list (default `--format 1`, which is what the three shipped packs use). It re-reads its own output with a Python copy of the lib routines and checks every word, every frequency, every bigram through an address table and a walk like the lib's.
- `--convert in.dict out.dict [--format 1|2]` reads a dictionary of any format and writes it again in the format asked (default 1, so a v2 file needs `--format 2`). v1 → v1 gives the same bytes as the shipped files, which is how the converter is tested; it stops with an error if a word or a pair does not survive.
- `--dump in.dict words.tsv bigrams.tsv` writes every word and every pair, the input of `native/test/dict_test.cpp` (`docs/tools/dict_readback.sh` runs it for a folder of dictionaries).

A v2 pack needs `"format": 2` and `"minApp": 1086000` in `pack.json`; `make_catalog.py` refuses a v2 file without them, a header that does not match `format`, and a size over the limit of that format. An app older than 1.86.0 keeps the v1 pack it has. The tests (what they check and how to run them) are in `suggestion-features.md`, "Dictionary format v2".

## Packs built from conversation text (1.86.1: Spanish 4, Portuguese 6 and English 5)
Spanish 4, Portuguese 6 and English 5 are not built by `split_lang.py` / `make_wordlist_lang.py` / `make_trigrams.py` any more: the counts, the mix of sources, the
vocabulary, the frequencies, the pairs and the trigrams come from `docs/tools/corpus/` (`prepare_corpus.py` + `make_pack_data.py`, steps and the exact
command in `docs/tools/corpus/README.md`; choices and results in `plan-suggestions.md`, Phase 4), and the dictionary is written with
`build_dict.py ... --format 2`. The credits of the sources are in `dicts/es/NOTICE.txt`; the OpenSubtitles text has no clear licence, so only counts
leave the machine. The same holds for `dicts/pt-BR/NOTICE.txt`; for Portuguese the list of the old recipe (this document, above) is run on the same splits and is the base of
`make_pack_data.py`, because it already has the 1990 spelling agreement and the European forms out (details in `docs/tools/corpus/README.md`). English has its own rules in the `en` entry of `make_pack_data.py` (apostrophe-free forms, stutters, capitalised twins, foreign lists only for short words): `docs/tools/corpus/README.md`. The older scripts above (`split_*.py`, `make_wordlist*.py`, `make_trigrams.py`) are still the way to rebuild the old recipe on the same splits, which is how the new packs are compared with it.
