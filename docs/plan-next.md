# Plan after 1.87.0

Status: version 7, 2026-11-07. 1.87.0 was validated on the device by the owner. **Stage 1 (1.88.0) is built** (see the stage). **Stage 2 (tools) is built and both runs were done on the owner's runner** (the small and the big one, for the three languages: the data for stage 3 is in hand); **Stage 3 (1.89.0) is built: the three packs passed the acceptance rule** (numbers below); **Stage 4 (1.90.0) is built, with the new libs integrated; only the phone numbers are missing**; **Stage 5 (mixed language) was measured on the owner's runner and option (d) is built: 151 and 152 common English words added to the packs pt-BR 9 and es 7 (data only, no app change); waiting for the second run and the phone**; **Stage 6 (finger position) is investigated and its measurement is built (`TouchRescore` in `mr-eval.yml`, `docs/finger-position.md`); waiting for the run**; stage 7 is not.
Delete this file when the plan is closed, as `plan-suggestions.md` was; the Git history keeps it.

## Decided by the owner
1. 1.87.0 is validated on the device.
2. **1.88.0 does the language select card and the AI formatting together** (stages 1 and 2 of the old draft).
3. **No personal data.** The app is for other people and other languages, so the test set of real messages comes from public sources and the recipe is generic per language; the owner's own chats are not used.
4. Spanish stays one pack for Spain and Latin America.
5. Size budget: at most 12 MB per language on disk and 7 MB downloaded.
6. AI formatting: when a text or file is **not** in the standard format, the app **always asks** whether to send it to the AI to be formatted, with the option **not to send**; the answer is not remembered. A file already in the standard format (`# mr-words 1`) is not asked about.
7. Tatoeba × subtitles: **Tatoeba stays at 10%** (in the end the rule chose 15% in the final mix, because with `real` at 25% a 10% share broke the Tatoeba guard by 0.05; see stage 3) (decided by the owner; applied in stage 3 after the ablation is repeated for en-US and es). The subtitles were the base; after seeing the real messages the owner asked for them to weigh more if they prove better (stage 2, "Direction from the owner"): the mix is chosen in stage 3 by the acceptance rule.
8. Each stage ends with the prompt of the next one (the prompts are kept outside the repository).
9. **No other languages are planned** beyond pt-BR, en-US and es.

## Tatoeba or subtitles: what the numbers say
`dictionary-tuning.md`, section "Which source to cut", has the table (pt-BR, same pipeline, only `--mix` changes). In short, with the shipped mix 45 / 25 / 30 as reference:

| Change | Subtitles hold-out | News hold-out | Tatoeba hold-out |
|---|---|---|---|
| Subtitles out (2 / 68 / 30) | -1.7 to -2.2 | -0.3 to -0.5 | +0.7 to +1.4 |
| Tatoeba cut to 10% (60 / 10 / 30) | +0.2 to +0.5 | +0.1 to +0.2 | -1.2 to -1.5 |
| Tatoeba out (70 / 0 / 30) | +0.3 to +0.6 | -0.1 to +0.1 | -2.8 to -3.7 |

- The **subtitles carry value across registers**; taking them out hurts both the subtitles and the news. They are also the only source with volume in many languages, which matters for the future languages.
- **Tatoeba only helps on Tatoeba.** Its hold-out is the artificial register (translated example sentences), so that loss says little about typing. The sentences are simple and everyday, though, so some of it may be real; no test we have can tell.
- Proposal: **keep the subtitles as the base; cut Tatoeba from 25% to 10%** now (it costs nothing on subtitles and news, and keeps about 60% of what Tatoeba gave on its own hold-out), and drop it to 0 in stage 3 only if the test of real messages shows it adds nothing there. Tatoeba stays as a spelling and vocabulary check even at 0.
- Limit: only pt-BR was run. en-US (where Tatoeba is much larger) and es are repeated with the same script before their packs change.

## Goals
1. Packs that predict what people really type on a phone, not only what is said in films or translated in textbooks, without growing the keyboard (disk, memory, opening time, key latency).
2. One shared **language select card** (like the settings rows) in the screens that choose a language, instead of the chips.
3. "Add words and texts": a language select and **formatting by AI** (with the AI Editor's API settings).
4. The open items of `engine-improvements.md` (mixed language, finger position, forgetting over time).

## Why the data needs work (diagnosis)
- The shipped sources are OpenSubtitles 2018 (weight 0.45), Tatoeba (0.25, called "chat" in `--mix`) and Leipzig news (0.30).
- **Tatoeba is not chat**: translated example sentences (pt-BR hold-out: "Os gatos modernos não comem ratos", "O corvo crucita"). The pack descriptions say "conversa"; that is not accurate.
- **Subtitles** are scripted dialogue: natural rhythm, but written for the screen, with quoted foreign lines (the pt-BR hold-out has "¿Michi?") and no texting style. **News** is formal.
- None has `vc`, `tb`, `kkkk`, missing accents or run-on messages.
- **Our hold-outs come from the same three sources**, so every number in `dictionary-tuning.md` measures "predicts subtitles / Tatoeba / news", not "predicts what people type". The first job is the measurement.

## Stage 1: 1.88.0, language select card + AI formatting (built)
**What was built** (details in `suggestion-features.md`, "The two screens"): `MrKit.select` / `languageCard` and `MrLang` (offered languages, which one a screen starts on, the last choice in the `mr_words` preferences); `MrAi.complete` (extracted from `rewrite`), `MrAi.configured` and `serviceHost`; `MrImport.scrub`; `MrImportAi` (instructions, parts of 6,000 characters, at most 40 requests, reading of the answers, merge, run with cancel); the button, the question and the progress on `MrImportActivity`. PC tests: `LangTest` (17), `AiImportTest` (71, with a fake service). What the PC could not test: a real AI service, and the screens on a device (checklist in `suggestion-features.md`).
Differences from the draft below: the *cost estimate* is the number of requests and characters (the price depends on the model and is not known to the app); the hard cap is 40 requests, the stronger warning starts above 12; the question is not asked on a file when the AI Editor has no key (the button explains and leads to the settings); the `[blocked]` section of an answer is always dropped.

Draft of the stage, as planned:
**Select card.** Today only "What the keyboard learned" (`MrLearnedActivity`) and "Add words and texts" (`MrImportActivity`) choose a language, both with chips; `MrPacksActivity` is a list of packs, not a selector. A search for other uses is part of the stage.
- New widget in `MrKit`: a card with the title, the chosen language and a chevron; a tap opens a single-choice dialog, the same pattern as the `AutoSummaryListPreference` rows of the settings.
- One shared preference: the language chosen in one screen is the default of the other. Export and Delete all act on the language shown.
- List: installed packs first, then any language with data, then the three of the app when there is nothing (as `loadLanguages` does).

**AI formatting in "Add words and texts".** Today the screen takes pasted text or a file (up to 8 MB), cleans it (`MrImport`), shows a preview, and can copy a prompt (`mr_import_prompt`) for an outside AI chat. The stage brings that step inside.
- **Button "Format with AI"** by the text box, for typed or pasted text: sends the text with the AI Editor settings (`pref_ai_*`), puts the standard list (`# mr-words 1`) back in the box, then the usual preview and checks run.
- **Ask when the text or file has no standard format**: "Send to the AI to format?" with *Send* and *Don't send* (import as it is). Always asked, never remembered. If the AI Editor has no key: *Set up AI Editor* or import as it is.
- **The answer of the model is untrusted data**: it goes through `MrImport`, which checks every line and lists what it left out and why; nothing is saved without the preview and the user's confirmation.
- **Size and cost**: local clean-up first (links, e-mails, phones, numbers, chat prefixes, laughs; this also cuts what leaves the phone), parts of about 6,000 characters cut at a line or sentence, a cap on requests without confirmation (proposal: 12), a cost estimate before a large file, progress with Cancel, parts that worked are kept if one fails, merge without repeats (the highest weight wins).
- **Privacy**: `mr_ai_privacy` says only the text you explicitly rewrite is sent. This feature sends imported text, so the text changes (pt, en, es) and the first use names the service address and what is sent.
- **Code**: extract `MrAi.complete(context, system, user, temperature)` (`rewrite` calls it; today it adds a rewriting system prompt and a clean-up that do not fit here) and make `configured()` reachable.
- **Tests (PC)**: selector logic (default, order, persistence), the chunker, the merge, answers with a code fence or an introduction, a wrong language tag, a missing header, a fake transport (success, HTTP error, empty answer, timeout).

## Stage 2: real messages, a test set and the viability of the sources (tools only, no app version)
Runs in parallel with stage 1 because it needs the owner's GitHub runner.
- Generic recipe per language (a registry of sources, not code fixed to three languages), built to add a language by adding an entry.
- A manual workflow for the owner's private repository (like `mr-corpus-samples.yml`) that downloads a sample (start with 50,000 messages per language) and returns only counts and a report: language purity, share with links, profanity, repeated messages, the 50 most frequent new words.
- A hold-out `chat_real_test.txt` (at least 10,000 messages per language) cleaned of user names, mentions, links, e-mails and phones, and taken from **another community or period** than the training data. With two independent sources (for example tweets and Reddit in Spanish) train on one and measure on the other.
- Rule of acceptance: gain on real messages, and a maximum loss on the other hold-outs.

| Source | Language | What I found | Verdict (to confirm by the small run) |
|---|---|---|---|
| Reddit comments (Pushshift / Arctic Shift, per subreddit) | all | Archive up to 2025; Arctic Shift has an HTTP API (rate limited) and bulk dumps on Academic Torrents | Main candidate for pt-BR and en-US; communities to be approved by the owner; needs a language and spam filter |
| `pysentimiento/spanish-tweets` (Hugging Face) | es | 622M tweets (2019), about 7 to 8% not Spanish; a `-small` variant exists | Best candidate for es; a few shards only |
| Tweets in Portuguese | pt-BR | Only small public sets (`fpaulino/portuguese-tweets`, 115k rows); the big corpora of the papers are described but I found no download | Probably not usable; pt-BR leans on Reddit |
| Pushshift Telegram (Zenodo) | mixed | 317M messages, 28K channels, 2020; mostly broadcast channels, language not labelled | Low value |
| WhatsApp | pt-BR | No open message corpus of useful size found | Not available |
| OpenAssistant (oasst1), WildChat | pt, es, en | Messages to an assistant; es about 43k, pt-BR about 3k | Too small and not chat |
| FineWeb-2 | all | Web documents, terabytes | Not worth the cost |

The workspace shell cannot reach these sites; a runner in the owner's private repository downloads them and only counts come back (as with OpenSubtitles). If a source fails the small run, say so before building on it.

**Built (tools only, no app version).** All in `docs/tools/corpus/` (README section 5): `real_sources.json` (the registry per language, source types `reddit` and `hf`), `sample_real.py`, `prepare_real.py`, `mr-corpus-real.yml` (the manual workflow: report only, or report + cleaned files), `accept_pack.py` (the rule, also in `dictionary-tuning.md`), `docs/tools/e2e/run_real_eval.sh` (SubtitleEval on subtitles, news, Tatoeba and real messages), `test_real.py` (112 checks with fake servers; runs in `mr-checks.yml`).
- Sources chosen for the first run: **Reddit** via Arctic Shift for the three languages (train and test in different communities and different half-years) and **tweets** from Hugging Face as an independent test for es (`pysentimiento/spanish-tweets`) and pt-BR (`fpaulino/portuguese-tweets`). Communities of confession, distress, relationships, personal finances and r/teenagers (minors) are left out on purpose; the lists are in `real_sources.json` and need the owner's approval.
- **Small run (50,000 messages per language, 10 to 17 minutes each) done on the owner's runner.** What it proved: Arctic Shift answers with the date as epoch seconds; the two Hugging Face datasets are served and their text column is found; the three test sets reach 10,000 messages. What it showed and was fixed afterwards: about 15% of the Arctic Shift requests fail with HTTP 422 (the answer is now kept in the log to find the cause); `r/rio` gave nothing (now `riodejaneiro`); the language filter threw out 22 to 29% of correct Spanish (rewritten: now 96 to 100% of known-good text passes); the train sources gave only 0.3 to 0.7 million words, far too little for a pack. Details: `docs/tools/corpus/README.md`, section 5.6.
- Acceptance rule (fixed before stage 3): gain of at least 0.5 point and 2 standard errors on real messages, each independent test source not worse, losses allowed on the other hold-outs (subtitles 0.5, news 1.5, Tatoeba 1.5), size within 12 MB / 7 MB.
- **Big run, the three languages** (300,000 train comments and 40,000 test per language, 4.7 to 4.8 hours of sampling each): train 7.8 million words (pt-BR), 7.5 (en-US), 6.7 (es); test 61,481 / 95,532 / 50,826 messages; language purity 98 to 100% (pt-BR, en-US) and 85 to 92% (es); no personal data left. The shipped packs score on real messages: after a space / at 3 letters, pt-BR 9.1 / 52.5 (Reddit) and 9.4 / 51.3 (tweets), en-US 9.4 / 58.6, es 7.1 / 47.9 and 7.2 / 47.1, against 14.1 / 58.9, 14.6 / 68.1 and 11.1 / 53.2 on the subtitles: real messages are the hardest test in all three. What it showed and was fixed afterwards: the 422 is the service's own "Timeout. Maybe slow down a bit" (17 to 23% of the train requests; now a 2-minute pause and the community goes on); a third of the Spanish requests and most of the small Brazilian communities' were lost re-reading the same comments (the sampler now keeps the spans already read); and the three jobs left only 12 to 17 minutes of the 300-minute limit for the cleaning, and a job that hits the limit loses the artifact (now `max_minutes` stops the sampling in time). Details: `docs/tools/corpus/README.md`, section 5.7.
- **Direction from the owner after seeing the data (2026-11-06): if the real messages prove better, give them more weight than the subtitles, news and Tatoeba.** Stage 3 tests mixes in which the real messages are the largest part and lets the acceptance rule choose the point (gain on real messages and the limits on the other hold-outs); the subtitles stay as the base only if the numbers say so. Limits to keep in view: 6.7 to 7.8 million words fill the frequent words and pairs but not the rare ones (the subtitles, 19 million, and the news cover that tail), and the Reddit sample leans to politics, sports and technology.
- Nothing is left for the owner in stage 2.

## Stage 3: 1.89.0, packs with real-message data, inside the budget (built)
- Done: pt-BR 7, en-US 6 and es 5 rebuilt with a fourth source (Reddit comments, counts only) in the mix **subtitles 40 / Tatoeba 15 / news 15 / real 25** (the rule chose it; the sweep of 12 mixes in pt-BR and 5 in es and en-US is in `dictionary-tuning.md`), the Tatoeba ablation repeated for en-US and es, trigrams pruned by gain per byte, rare hyphenated words refused, more swear-word inflections at f = 5, a few slang words with a fixed frequency, `ctz` and `aq` in the pt-BR rules.
- Result (`accept_pack.py`, all three ACCEPT): real messages pt-BR +2.05, es +1.47, en-US +1.40 points (after the space +1.4 / +0.9 / +1.1); subtitles -0.25 / -0.10 / +0.03; news -1.32 / -0.88 / -0.85; Tatoeba -0.90 / -0.80 / -0.78. Zips (as `make_catalog.py` makes them) 6,716,082 / 6,730,119 / 6,591,626 bytes (limit 7,000,000), folders 10.97 / 11.32 / 10.57 MB (limit 12); the whole trigram file would have zipped to 7.0 to 7.4 MB, so about 11 to 21% of the triples were cut by gain per byte. `SpeedEval` p95 -3.4% to +0.1%, opening within the noise of the PC; the phone is not measured.
- Not done on purpose: no politician names were added; the tweets stay as a test only; the evaluation on a device is the owner's.
- Left for later: more real data of other kinds (the Reddit sample leans to politics, sports and technology, and the gain on SMS-style typing is not measured). If a new real source is found, repeat the sweep before changing the mix.

## Stage 4: 1.90.0, memory, opening and size of the engine (built; changes C++)
- Done: (1) the line **Dictionary memory** in *Settings → Suggestions and dictionaries* (`MrDiag`): sizes, memory in use (Pss from `/proc/self/smaps`), opening times and engine start, for the language in use; (2) `trigrams.bin` is **mapped** (`mmap`) with a safe pack swap (the installer already wrote a new folder and renamed it; the rule is now written down and `mr_test` swaps a pack with the file open); (3 and 4) a new layout, **MRT2**: 16-bit ids, a row table and the offset tables stored in the file, nothing built at open; (5) already true (one open `TriStore`, closed when the language changes), now covered by the mapping tests.
- Result on the PC (details in `dictionary-tuning.md`, "Stage 4"): `trigrams.bin` -24 to -26%, zip -4.6 to -5.3%, installed -10 to -12%; indexes on the heap 1.2 MB → 0; open about 3 ms → 0.5 ms; lookup about 25% faster; about 550,000 queries per language identical in both layouts. Packs pt-BR 8, en-US 7, es 6 (same content), `minApp` 1090000. The JNI contract did not change (`kEngineVersion` stays 1), but the lib did: **new `native-libs.zip` from `mr-native.yml` is needed**.
- Corrections to the plan found by measuring: the "8 to 14 ms" of item 4 is the tables and rules handover, not the trigram indexes (about 3 ms); "2 continuations when the first dominates" would change the suggestions, and "delta-coded context ids" cannot be binary-searched, so neither was done (reasons and numbers in `suggestion-features.md`).
- Left for the owner: read the new line on a phone (cold start, then after typing) and send the numbers; they decide whether the 8-14 ms of tables and rules deserve a stage of their own.
- Left for later: a block layout of MRT2 (5.5 to 6.6% of the file at best), and using the room that was freed (about 0.3 MB per pack) for more trigram contexts, which needs the sweep and the acceptance rule again.

## Stages 5 to 7: items carried over from `engine-improvements.md`
- **Mixed language** (pt and en in one sentence, both packs installed): read the code first (`Suggest`, `MrPacks`, `MrPredict`), test with mixed sentences, show the options with their cost; implement only what is approved. Measured and option (d) approved and built: `docs/mixed-language.md`.
- **Finger position**: simulate with `TouchEval` on the PC to see the gain before touching `LatinIME`/`PointerTracker` in smali; implement only if approved. Investigated: `docs/finger-position.md`.
- **Forgetting over time**: the database keeps 10 thousand pairs and drops 1,000 at once; with the two "My words" screens in place the missing part is a decay over time. Design first (what decays, how fast, what never decays, how the user sees and undoes it).

## Order
1. **Stage 1, 1.88.0** (card + AI). Built; waiting for the device test.
2. **Stage 2** (tools only). Done: tools built, small and big runs done for the three languages (the data is in hand).
3. **Stage 3, 1.89.0** (packs). Built; waiting for the device test.
4. **Stage 4, 1.90.0** (engine memory and size). Built, with the new libs integrated; waiting for the phone numbers.
5. **Stages 5, 6, 7** in this order, each with its approval before code.

Sources: [Spanish tweets (Hugging Face)](https://huggingface.co/datasets/pysentimiento/spanish-tweets), [Portuguese tweets (Hugging Face)](https://huggingface.co/datasets/fpaulino/portuguese-tweets), [Pushshift Telegram dataset](https://zenodo.org/records/3607497), [Arctic Shift](https://github.com/ArthurHeitmann/arctic_shift), [OpenAssistant oasst1](https://huggingface.co/datasets/OpenAssistant/oasst1), [FineWeb-2](https://huggingface.co/datasets/HuggingFaceFW/fineweb-2).
