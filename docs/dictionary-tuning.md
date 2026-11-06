# Dictionary rebuild (1.86.1): decisions, method and results

How the three packs of 1.86.1 (es 4, pt-BR 6, en-US 5) were decided and measured. The commands to rebuild a pack are in `docs/tools/corpus/README.md`; the
format of the files is in `dictionary-build.md`; what the keyboard does with them is in `suggestion-features.md`. This text was the "Phase 4" of the plan
`plan-suggestions.md` (phases 1 to 4 were delivered in 1.84.0 to 1.86.1 and phase 5 closed it in 1.87.0, when the file was deleted); the Git history keeps the whole plan.

## Decisions taken before the rebuild
| Question | Decision |
|---|---|
| Dictionary size limit (4 MB, packs are 88-90% full) | **Format v2, up to 16 MB** (wider addresses in the readers, builder and tests; new packs need a newer app: `minApp`) |
| Text base of the new dictionaries | **Subtitles (OpenSubtitles) as the main base, news with a low weight**; only counts are distributed, never text |
| A valid word that is probably another word (`cassa`, `fone`, `ombre`) | **Suggest the frequent one in the strip, never replace on its own** |
| Mixed languages | **Frequent English loanwords inside the pt-BR / es dictionary** (`ok`, `bye`, `deploy`, `link`); one active language at a time as today |
| Two new screens (asked after the questions) | **"What the keyboard learned"** (manage) and **"Add words and texts"** (import), phase 2 |

## Method and choices (targets, mix, filters)
Needs the corpus files (how to get them and the commands: `docs/tools/corpus/README.md`). Packs are published through the catalog; the app did not change for it (1.86.1 only changed the version number, `mr-apk.yml` and the three packs).
1. **Counts, not text.** Per language, from OpenSubtitles (`mono`, one sentence per line): clean (drop lines with timestamps, `[music]`-style tags and lines under 2 words), normalise (case, apostrophes, spelling per variant: pt-BR only; remove European Portuguese markers as in `split_br.py`), count unigrams, in-line bigrams and trigrams. The text itself is never stored or distributed.
2. **Hold-out first.** A sentence goes to the *test set* when `hash(sentence) % 20 == 0` and is excluded from every count. All dictionaries (old and new) are evaluated on that same set with `SubtitleEval`, so the comparison is fair (the top-10,000 benchmark above is for the current packs only, because those sentences are very frequent and would leak into new counts).
3. **Mix.** Starting weights: subtitles 60%, Tatoeba 20%, news 15%, AOSP list 5%; tune on the hold-out by the 4 rates (after space, 1, 2, 3 letters) plus the normal-typing rate of `StrategyTest`. News stays for the formal vocabulary (so `previdência` is still there) but stops deciding the order.
4. **Words.** AOSP list as the base spelling filter (as today); words are added from the corpus when they appear in at least two sources or N times in subtitles; frequent English loanwords (`ok`, `bye`, `deploy`, `link`, `feedback`) and brands/apps are kept in pt-BR and es when they pass the same count rule. Offensive words stay as today (never predicted).
5. **Pairs and trigrams.** More pairs per word where the format v2 allows (today 400,000 with up to 60 per word; the target is 1,000,000+ pairs and a larger `trigrams.bin`, bounded by the 16 MB and by the time to open). Pair selection by P(next | previous) with a floor, not only raw count.
6. **Frequencies calibrated per language**, starting with es (hola/bola, bamos → vamos) and the chat words of `rules.txt` (`tá`, `né`, `kkk`, `pq`...), checked by the `GAP` cases of `StrategyTest`.
7. **Release.** Packs pt-BR 6, en-US 5, es 4, each with `NOTICE.txt` (credits and the licences of the sources; the licence of OpenSubtitles text is not clear, which is why only counts are published, and the notice says so). If the strict legal view matters, the pack can be built from Tatoeba + Common Voice + news alone with the same scripts (lower quality, clean licences).
8. **Targets** (to be fixed after the first hold-out comparison): after the space +8 points over the old pack on the same hold-out; 3 letters in es ≥ 70%; no drop in the normal-typing rate or in any `StrategyTest` case; opening time of the keyboard no worse than 20% above today.

## What was delivered for es in 1.86.1 (and where it differs from the design)
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

## What was delivered for pt-BR in 1.86.1 (the same pipeline; what is different)
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

## What was delivered for en-US in 1.86.1 (the same pipeline; what is different)
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

## Which source to cut: Tatoeba or the subtitles (pt-BR ablation, after 1.87.0)

Why it was run: the "chat" source of the mix is Tatoeba, which is translated example sentences, not messages typed on a phone (the plan in `plan-next.md` explains). Same pipeline as pt-BR 6 (`exp_pt.sh`, `--min-ctx 6 --min-tri 2`, same splits, the same dictionary of 5,905,022 bytes in every row), only `--mix` changes. Numbers are the hit among the 3 suggestions after the space / with 1 / 2 / 3 letters, in % (weighted, as above).

| Mix (subtitles / Tatoeba / news) | subtitles hold-out | news hold-out | Tatoeba hold-out | `trigrams.bin` |
|---|---|---|---|---|
| 45 / 25 / 30 (pt-BR 6, shipped) | 13.8 / 30.2 / 41.8 / 58.8 | 14.2 / 26.8 / 36.1 / 51.6 | 19.0 / 36.6 / 48.0 / 63.4 | 5,176,682 |
| 60 / 10 / 30 | 14.1 / 30.6 / 42.3 / 59.0 | 14.3 / 27.0 / 36.2 / 51.7 | 17.8 / 35.3 / 46.5 / 62.2 | 5,160,134 |
| 70 / 0 / 30 (Tatoeba weight 0.001: 0 divides by zero in the log fit) | 14.2 / 30.5 / 42.4 / 59.1 | 14.3 / 26.9 / 36.1 / 51.5 | 16.2 / 32.9 / 44.4 / 60.2 | 5,169,467 |
| 2 / 68 / 30 (almost no subtitles) | 12.1 / 28.0 / 40.0 / 56.6 | 13.9 / 26.3 / 35.8 / 51.2 | 19.7 / 37.9 / 49.4 / 64.7 | 5,242,651 |

Reading: taking the subtitles out costs 1.7 to 2.2 points on the subtitles and 0.3 to 0.5 on the news and gives back only 0.7 to 1.4 on Tatoeba. Taking Tatoeba out gives 0.3 to 0.6 points on the subtitles, is neutral on the news and costs 2.8 to 3.7 points on Tatoeba itself. The hold-out of Tatoeba is the artificial register, so that loss says little about typing; **none of the four hold-outs is real messages**, which is why the decision is confirmed (or reversed) in the plan's stage 3 with a hold-out of informal text. Only pt-BR was run (about 12 minutes per row); en-US and es are repeated with the same script before their packs change.
