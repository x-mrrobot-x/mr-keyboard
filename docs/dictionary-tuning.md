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

## Acceptance rule for a new pack (stage 2 of `plan-next.md`; applied from stage 3)

Why a rule: until now a pack was accepted by reading three hold-outs (subtitles, Tatoeba, news) and none of them is text typed by people. From stage 2 there is a fourth test, **real messages**
(`chat_real_test.txt`: Reddit comments and tweets of communities, a period or a medium that the training data never had; `docs/tools/corpus/README.md`, section 5), and a fixed rule that is
written **before** the packs are built, so that the thresholds are not chosen after seeing the result. The code is `docs/tools/corpus/accept_pack.py` (`--rule` prints it); `docs/tools/e2e/run_real_eval.sh`
produces the numbers; `docs/tools/corpus/test_real.py` tests the rule.

How it is measured: `SubtitleEval` on each test, the candidate against the **old pack rebuilt by the old scripts on the same splits** (a shipped pack has seen part of the sentences), same sentences, words of
4+ letters, each sentence once. Score of a test = the mean of the four hit rates (after the space, 1, 2 and 3 letters), in points. The noise of a difference is estimated from the number of words of each rate
as if the two packs were independent (pessimistic: they use the same words).

| # | Rule | Why this number |
|---|---|---|
| 1 | **Real messages** (all test sources together): gain of at least **0.5** point and at least **2 standard errors** of the difference; the rate right after the space may not fall by more than 0.1 | a candidate that cannot beat the old pack by half a point on real messages is not worth the size and the risk of a new pack (the 1.86.1 rebuild gained +0.1 to +0.6 after the space and +2.6 to +3.5 with 3 letters on its chat hold-out); 2 standard errors keeps a lucky small test from passing (about 0.4 to 0.9 points for 30,000 to 5,000 words) |
| 2 | **Each independent real test source** (for example tweets and a group of subreddits): the gain may not be below minus 1 standard error | a gain that shows in only one medium is a gain on that medium |
| 3 | Other hold-outs may lose at most (score / right after the space): **subtitles 0.5 / 0.5**, **news 1.5 / 1.0**, **Tatoeba 1.5 / 1.5** | subtitles are the base of the packs and must not pay for the new source; news already lost 1.2 to 2.1 points in es and 0.2 to 1.1 in pt-BR on purpose in 1.86.1; Tatoeba is the artificial register, and the pt-BR ablation above measured -1.3 (score) / -1.2 (after the space) for the cut from 25% to 10% that was decided, so that loss must not be a veto |
| 4 | Size: **at most 12,000,000 bytes** in the language folder (`main.dict`, `trigrams.bin`, `rules.txt`...) and **7,000,000 bytes** for the zip | the budget decided for stage 3 (the packs of 1.88.0 are 10.6 to 11.1 MB on disk and 6.48 to 6.82 MB zipped as `make_catalog.py` zips them, a little above the "6.4 MB" first written here; the limits themselves did not change) |
| info | The **dev** file (real messages of the training communities) is shown, not judged | a large gap between its gain and the test gain means the pack learned the communities and not the language |

Other gates of stage 3 that this script does not compute: `SpeedEval` p95 not worse than +10%, opening time not slower, `run_strategy_tests.sh` with 0 failures and the S28 floors held (raise the floors when a release improves the rates, never lower one).
Exit code of `accept_pack.py`: 0 accepted, 1 rejected, 2 a result is missing (without the real-message result there is no decision). If a rule turns out to be wrong, change it in the script **and** in this table in a separate commit before using it again.


## Stage 3 (1.89.0): the fourth source (real messages), the mix and the size

What changed in the three packs (pt-BR 7, en-US 6, es 5): a fourth source `real` in `make_pack_data.py` (Reddit comments of public communities, January to June 2025, counts only; the tweets are test-only),
the mix **subtitles 40 / Tatoeba 15 / news 15 / real 25** in all three languages, trigrams pruned by gain per byte to fit the 7,000,000-byte zip, rare hyphenated words refused (`--min-hyphen 20`),
more inflections of swear words at f = 5, a few slang words with a fixed frequency (`EXTRA_INFORMAL`) and two more correction rules in pt-BR (`ctz`, `aq`). Without `real` in `--mix` the script still gives the shipped packs
byte for byte (pt-BR and es compared; `test_pack_data.py`, 46 checks, keeps it). Commands: `docs/tools/corpus/README.md`, section 3.

**How the mix was chosen.** The owner's direction was: if real messages prove better, use more of them and let the acceptance rule choose. Twelve pt-BR mixes (five for es and en-US, to confirm) were built with the same word list
and the same pairs and triples rules, and each was measured on five sets with `SubtitleEval` (5.5 minutes per candidate): **real, test sample** (6,000 real messages of communities the training never saw: Reddit of other communities and tweets, interleaved),
**real, dev** (10,000 messages of the training communities, information only), and the three guards (the first 8,000 sentences of the subtitle hold-out, 6,000 of the news, 6,000 of Tatoeba). Every cell is the change against the pack of 1.88.0 rebuilt by the old scripts,
in points of the mean of the four rates / change right after the space; **over** = beyond the loss limit of the rule (subtitles 0.5 / 0.5, news 1.5 / 1.0, Tatoeba 1.5 / 1.5).

pt-BR (the same candidates ran with the whole trigram file, 12.2 to 12.3 MB on disk):

| Mix: subtitles / Tatoeba / news / real (%) | real, test sample | real, dev | subtitles | news | Tatoeba |
|---|---|---|---|---|---|
| B: 60 / 10 / 30 / 0 | +0.05 / -0.1 | +0.15 / +0.0 | +0.33 / +0.2 | +0.18 / +0.2 | -1.40 / -1.3 |
| C: 40 / 10 / 20 / 30 | +2.37 / +1.4 | +3.57 / +2.3 | -0.38 / -0.3 | -0.65 / -0.3 | -1.90 / -1.7 **over** |
| D: 30 / 10 / 15 / 45 | +2.75 / +1.5 | +4.18 / +2.6 | -1.05 / -0.9 **over** | -1.30 / -0.7 | -2.23 / -1.9 **over** |
| E: 30 / 5 / 10 / 50 | +2.80 / +1.5 | +4.43 / +2.7 | -1.15 / -1.0 **over** | -2.00 / -1.1 **over** | -3.12 / -2.6 **over** |
| F: 20 / 5 / 15 / 60 | +3.00 / +1.7 | +4.65 / +2.8 | -2.00 / -1.5 **over** | -1.37 / -0.8 | -3.63 / -3.0 **over** |
| G: 45 / 5 / 20 / 25 | +2.25 / +1.4 | +3.40 / +2.2 | -0.20 / -0.1 | -0.52 / -0.2 | -2.67 / -2.3 **over** |
| H: 45 / 10 / 15 / 25 | +2.20 / +1.4 | +3.33 / +2.2 | -0.05 / +0.0 | -1.20 / -0.6 | -1.55 / -1.3 **over** |
| I: 45 / 5 / 15 / 30 | +2.35 / +1.4 | +3.60 / +2.3 | -0.17 / -0.1 | -1.17 / -0.6 | -2.60 / -2.2 **over** |
| J: 45 / 15 / 15 / 20 | +1.87 / +1.2 | +2.98 / +1.9 | +0.17 / +0.2 | -1.30 / -0.6 | -0.83 / -0.7 |
| K: 45 / 15 / 10 / 25 | +1.97 / +1.2 | +3.20 / +2.1 | +0.15 / +0.2 | -2.15 / -1.1 **over** | -0.93 / -0.8 |
| L: 40 / 15 / 15 / 25 | +2.07 / +1.3 | +3.28 / +2.1 | -0.07 / +0.0 | -1.23 / -0.6 | -0.95 / -0.8 |
| M: 35 / 15 / 15 / 30 | +2.38 / +1.4 | +3.65 / +2.3 | -0.40 / -0.3 | -1.17 / -0.6 | -1.13 / -1.0 |

es:

| Mix: subtitles / Tatoeba / news / real (%) | real, test sample | real, dev | subtitles | news | Tatoeba |
|---|---|---|---|---|---|
| B: 60 / 10 / 30 / 0 | -0.00 / +0.1 | -0.00 / +0.0 | +0.20 / +0.0 | +0.05 / +0.0 | -1.57 / -1.1 **over** |
| J: 45 / 15 / 15 / 20 | +1.22 / +0.8 | +2.05 / +1.2 | +0.07 / +0.1 | -1.07 / -0.5 | -0.75 / -0.5 |
| K: 45 / 15 / 10 / 25 | +1.30 / +0.8 | +2.22 / +1.4 | +0.02 / +0.0 | -1.72 / -0.9 **over** | -0.82 / -0.4 |
| L: 40 / 15 / 15 / 25 | +1.45 / +0.9 | +2.30 / +1.3 | -0.10 / -0.1 | -1.02 / -0.6 | -0.90 / -0.5 |
| M: 35 / 15 / 15 / 30 | +1.58 / +1.0 | +2.52 / +1.4 | -0.33 / -0.4 | -1.03 / -0.6 | -1.02 / -0.8 |

en-US:

| Mix: subtitles / Tatoeba / news / real (%) | real, test sample | real, dev | subtitles | news | Tatoeba |
|---|---|---|---|---|---|
| B: 60 / 10 / 30 / 0 | -0.05 / +0.0 | -0.07 / -0.1 | +0.20 / +0.2 | -0.02 / -0.1 | -1.50 / -1.4 |
| J: 45 / 15 / 15 / 20 | +1.20 / +1.0 | +2.02 / +1.5 | +0.22 / +0.2 | -0.92 / -0.6 | -0.90 / -0.6 |
| K: 45 / 15 / 10 / 25 | +1.30 / +1.1 | +2.17 / +1.5 | +0.20 / +0.1 | -1.50 / -1.0 | -1.00 / -0.7 |
| L: 40 / 15 / 15 / 25 | +1.45 / +1.2 | +2.27 / +1.6 | +0.07 / +0.0 | -0.90 / -0.6 | -1.02 / -0.6 |
| M: 35 / 15 / 15 / 30 | +1.57 / +1.2 | +2.57 / +1.8 | -0.07 / -0.1 | -0.88 / -0.6 | -1.05 / -0.7 |

Reading. (1) The gain on real messages grows with the share of `real` but with diminishing returns: 20% gives +1.9, 25% about +2.1, 30% +2.4, 45% +2.75, 60% +3.0 (pt-BR). (2) Above about 30% the subtitle and Tatoeba limits break first (D, E, F), the news limit
next (K, E); with 5% Tatoeba the Tatoeba guard breaks (G, I) and with 10% and `real` at 25% it breaks by 0.05 (H, -1.55 against 1.5), so **Tatoeba is 15%, not the 10% of the plan**: the new source takes over the informal register that Tatoeba was keeping alive.
(3) L (40 / 15 / 15 / 25) and M (35 / 15 / 15 / 30) both pass in all three languages; M adds only +0.1 to +0.3 points on real messages and leaves a margin of 0.1 on the subtitles in pt-BR, so L was taken: the larger the real share, the more the pack depends on a sample
that leans to politics, sports and technology. The rule did not have a tie to break and the owner was not asked. (4) The numbers on the dev set (+2.3 to +3.3) are larger than the test ones (+1.5 to +2.1), as expected: part of the gain is the vocabulary of the training communities.
This is why the rule judges the test.

**Tatoeba and subtitles ablation, repeated for es and en-US** (the same three mixes as the pt-BR ablation above, now on the five sets; no `real`):

es:

| Mix (subtitles / Tatoeba / news) | real, test sample | subtitles | news | Tatoeba |
|---|---|---|---|---|
| 45 / 25 / 30 (1.88.0) | 0 | 0 | 0 | 0 |
| 60 / 10 / 30 | -0.00 / +0.1 | +0.20 / +0.0 | +0.05 / +0.0 | -1.57 / -1.1 |
| 70 / 0 / 30 | -0.15 / +0.0 | +0.25 / +0.1 | +0.07 / +0.1 | -3.65 / -2.7 |
| 2 / 68 / 30 | -0.77 / -0.4 | -1.72 / -1.2 | -0.48 / -0.3 | +1.45 / +1.0 |

en-US:

| Mix (subtitles / Tatoeba / news) | real, test sample | subtitles | news | Tatoeba |
|---|---|---|---|---|
| 45 / 25 / 30 (1.88.0) | 0 | 0 | 0 | 0 |
| 60 / 10 / 30 | -0.05 / +0.0 | +0.20 / +0.2 | -0.02 / -0.1 | -1.50 / -1.4 |
| 70 / 0 / 30 | -0.15 / +0.1 | +0.20 / +0.2 | -0.08 / -0.1 | -3.05 / -2.7 |
| 2 / 68 / 30 | +0.07 / -0.1 | -1.50 / -1.0 | -0.25 / -0.3 | +2.03 / +1.4 |

The three languages agree with pt-BR: cutting Tatoeba to 10% changes real messages by 0.0 (-0.05 to +0.05) and the subtitles by +0.2 to +0.3, and costs 1.4 to 1.6 on Tatoeba itself; removing it costs 3.0 to 3.7 there; removing the subtitles costs 1.5 to 1.7 on them and does not help real messages (-0.77 in es, +0.07 in en-US).
So Tatoeba has little to say about real typing, but the subtitles are not the thing to cut either; the room for `real` came from the news (30 to 15%), Tatoeba (25 to 15%) and the subtitles (45 to 40%).

**The size budget.** The zips of the 1.88.0 packs, made by `make_catalog.py` (deflate level 9), are 6,750,313 (pt-BR), 6,483,347 (es) and 6,819,336 bytes (en-US), a little above the 6.4 MB first written in the plan. Mix L with the whole trigram file is 12.2 to 12.3 MB on disk
and zips to 7,405,326 (pt-BR), 7,042,202 (es) and 7,400,757 bytes (en-US): over the 7,000,000-byte zip limit, while the 12,000,000 disk limit is only just broken, so the **zip limit is the one that binds**. (`main.dict` zips to 0.65 to 0.68 of its size and `trigrams.bin` to 0.56 to 0.58.)
The pruning experiments used the default deflate level of Python, about 2.5% larger than level 9, so they were conservative. Pruning on pt-BR (mix L, all rows measured on the five sets):

| Row | What was cut | Disk (`main.dict` + `trigrams.bin`) | Result against the whole file |
|---|---|---|---|
| Lp | nothing | 12.23 MB | reference: real +2.07, subtitles -0.07, news -1.23, Tatoeba -0.95 |
| P1 | triples to 5,576,000 bytes by gain per byte | 11.83 MB | identical rates on the five sets |
| P2 | pairs to 675,000 (`--max-bigrams`) | 11.86 MB | news -1.45 (was -1.23): pairs cost |
| P3 | both | 11.16 MB | news -1.55, **over** the limit |
| P4 | triples to 4,900,000 bytes | 11.16 MB | rates equal to Lp on all five sets; zip 7,027,389 with Python's default level (it was believed to be over the limit, so the budget was lowered); 6,829,420 with `make_catalog.py`, which fits |

So pairs are kept and the triples are cut by **gain per byte** (the weighted mass of the continuations that the pair of the last word does not already give, divided by the bytes the context takes). Final budgets:
pt-BR 4,700,000 bytes (5,976,794 → 4,699,986: 21% of the triples cut), es 4,930,000 (5,537,223 → 4,929,982: 11%), en-US 4,720,000 (5,887,605 → 4,719,992: 20%). The budgets are a little below what the real zipper needs (P4 shows 4.9 MB would fit in pt-BR),
which costs nothing that was measured: the rates of Lp, P1 and P4 are the same. Final packs, zipped by `make_catalog.py` / on disk: pt-BR 6,716,082 / 10,968,025 bytes, es 6,730,119 / 11,316,368, en-US 6,591,626 / 10,569,061
(the headroom to 7,000,000 is 270 to 410 KB).

**Words.** The new data adds about 6,000 words (pt-BR), 6,200 (es) and 2,100 (en-US) that a speller accepts, plus names and a few slang words, and the review of the report found these cases, handled in `make_pack_data.py`: Reddit and tech jargon that the rule accepted on the evidence
(`subreddit`, `thread`, `layoff`, `lead`): kept, the measured rule decides; inflections of swear words (`fud*`, `escrot*`, `cacet*`, `ching*`, `cag*`, `pelotud*`, `joder*`, `shittier`) got f = 5 and are never suggested; hyphenated compounds (`ex-namorado`, `half-assed`) refused below 20 occurrences
(`--min-hyphen`; it takes the en-US list from 175,322 to 167,446 words and pt-BR from 184,859 to 181,948 ; `SubtitleEval` keeps a hyphenated word as one token, so the effect of this cut is already inside the acceptance numbers below, which were measured on the final packs and not on the sweep candidates); `alot`, `Micheal` and `Que` refused in English; `Pix`, `ué`, `mimimi`, `freela`, `nomás`, `wtf`, `tbf` added with a fixed frequency (the capital letters of Reddit or the missing speller keep them out of the automatic rule);
no word that `rules.txt` corrects was added (a word of the dictionary switches its correction off). Names of politicians were deliberately not added.

**Acceptance rule, output of `accept_pack.py` for each pack** (candidate against the 1.88.0 pack rebuilt by the old scripts on the same splits; `real` = 20,000 messages of all test sources interleaved; the noise is one standard error of the difference):

pt-BR:

```
Acceptance of the candidate pack pt-BR (points of the score = mean of the 4 hit rates; after-space = rate right after the space)
test                        old      new     gain    noise  after space     words
dev                       29.32    32.52    +3.20     0.08        +2.20    149962
news                      32.40    31.07    -1.32     0.07        -0.90    224901
real                      29.25    31.30    +2.05     0.09        +1.40    122773
real_reddit-pt-test       29.57    32.23    +2.65     0.08        +1.80    137143
real_tweets-pt-test       28.82    29.77    +0.95     0.09        +0.60    109152
subs                      36.52    36.27    -0.25     0.12        -0.20     67987
tatoeba                   41.70    40.80    -0.90     0.12        -0.70     76152
size: disk_bytes 10969141, zip_bytes 6716082
VERDICT: ACCEPT
```

es:

```
Acceptance of the candidate pack es (points of the score = mean of the 4 hit rates; after-space = rate right after the space)
test                        old      new     gain    noise  after space     words
dev                       25.62    27.97    +2.35     0.08        +1.30    149054
news                      28.12    27.25    -0.88     0.06        -0.50    235615
real                      26.20    27.67    +1.47     0.08        +0.90    129205
real_reddit-es-test       26.00    28.07    +2.07     0.07        +1.20    155953
real_tweets-es-test       25.53    26.32    +0.80     0.09        +0.50    109475
subs                      31.62    31.52    -0.10     0.12        +0.00     64963
tatoeba                   36.55    35.75    -0.80     0.12        -0.40     72227
size: disk_bytes 11317949, zip_bytes 6730119
VERDICT: ACCEPT
```

en-US:

```
Acceptance of the candidate pack en-US (points of the score = mean of the 4 hit rates; after-space = rate right after the space)
test                        old      new     gain    noise  after space     words
dev                       35.55    37.83    +2.28     0.08        +1.70    145476
news                      31.08    30.23    -0.85     0.06        -0.50    233268
real                      33.30    34.70    +1.40     0.08        +1.10    151210
real_reddit-en-test       32.18    33.35    +1.17     0.07        +0.80    170654
subs                      41.05    41.08    +0.03     0.12        -0.10     70174
tatoeba                   44.43    43.65    -0.78     0.12        -0.60     73786
size: disk_bytes 10570325, zip_bytes 6591626
VERDICT: ACCEPT
```

**Speed and opening (PC, `SpeedEval` 800 subtitle sentences x 3 rounds, run alone, each pack twice, old = 1.88.0 packs, new = 1.89.0).** Per keystroke, the three languages added together (n is the same in both):

| Keystroke | n | mean µs old → new | p95 µs old → new |
|---|---|---|---|
| after a space | 39,624 | 77.5 → 78.0 (+0.7%) | 116.3 → 113.7 (-2.2%) |
| 1 letter | 39,624 | 50.8 → 51.1 (+0.6%) | 79.4 → 77.9 (-1.9%) |
| 2 to 4 letters | 90,231 | 204.3 → 205.0 (+0.4%) | 557.6 → 554.3 (-0.6%) |
| 5 or more letters | 42,069 | 207.2 → 208.4 (+0.6%) | 452.5 → 453.0 (+0.1%) |
| typo (correction search) | 22,056 | 326.3 → 328.3 (+0.6%) | 551.6 → 548.7 (-0.5%) |
| valid word | 29,436 | 86.7 → 86.8 (+0.1%) | 244.3 → 236.0 (-3.4%) |

The p95 is within -3.4% to +0.1% (the gate was not worse than +10%), the largest per-language change is +2% (en-US, 5 or more letters; the same cell in pt-BR and es is -0% and -2%). Opening a pack on the PC (read `main.dict`, parse `rules.txt`,
open `trigrams.bin`, build the engine, first query; median of 9 openings, run twice per pack): pt-BR 13.4 / 13.0 → 14.1 / 11.0 ms, es 11.1 / 12.3 → 13.1 / 12.8 ms, en-US 11.5 / 14.0 → 10.6 / 12.4 ms. The reading noise of this PC is about
15%, so the change is not distinguishable from zero: `main.dict` is 3 to 6% larger (more pairs) and `trigrams.bin` 9 to 11% smaller. On a phone it is not measured (stage 4 adds that line to the settings).


**The project checks with the new packs.** `run_strategy_tests.sh` (3 languages, dictionaries from `dicts/`): 0 failures. One case moved: `hey _ -> guys` (S14, en-US) was third with en-US 5 and is fourth now (there / you / man), because the real sample has
`hey man` 41 times against `hey guys` 13 (weighted counts 188 against 135; subtitles alone have `there` 108, `you` 96, `guys` 44). It is marked as a **GAP (data)** like `how are` and `good morning`, and a case `hey _ -> there` (third in both packs) keeps the mechanism covered.
The S28 floors (133 everyday sentences written for the repository, about 600 words per language) were **not** raised: the pack of 1.88.0 / the new one measure, after the space / 1 / 2 / 3 letters, pt-BR 20.5 / 41.8 / 55.2 / 69.1 → 22.4 / 40.6 / 54.6 / 68.9,
en-US 18.3 / 38.8 / 54.5 / 76.1 → 17.2 / 37.0 / 53.7 / 74.5, es 19.6 / 39.2 / 51.1 / 67.2 → 18.1 / 36.3 / 48.7 / 65.8. The noise of a test this small is about 1.7 to 2 points per rate, so it is not a loss we can prove, but en-US and es are lower in every rate (as the
written-style guards, Tatoeba and subtitles, are: -0.8 and +0.0 to -0.1), pt-BR is up after the space, and all values are above the floors. A floor is never lowered and there was no improvement to raise one.

What these numbers do not say: the real messages are Reddit comments (and tweets only as a test), so the gain on SMS-style typing, on voice-to-text and on subjects outside politics, sports and technology is not measured; the evaluation uses words of 4+ letters, so
the rate right after the space is the one a person feels most and it improved by only +0.9 to +1.4; and nothing here was measured on a phone. The next lever is more real data of other kinds (the training sample is 6.7 to 7.8 million words per language, against 19 million of the subtitles).
