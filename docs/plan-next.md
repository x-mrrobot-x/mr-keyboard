# Plan after 1.87.0

Status: version 5, 2026-11-06. 1.87.0 was validated on the device by the owner. **Stage 1 (1.88.0) is built** (see the stage). **Stage 2 (tools) is built and the small run was done on the owner's runner** (it worked; the big run with the train volume is still to be done, see the stage); stages 3 to 7 are not.
Delete this file when the plan is closed, as `plan-suggestions.md` was; the Git history keeps it.

## Decided by the owner
1. 1.87.0 is validated on the device.
2. **1.88.0 does the language select card and the AI formatting together** (stages 1 and 2 of the old draft).
3. **No personal data.** The app is for other people and other languages, so the test set of real messages comes from public sources and the recipe is generic per language; the owner's own chats are not used.
4. Spanish stays one pack for Spain and Latin America.
5. Size budget: at most 12 MB per language on disk and 7 MB downloaded.
6. AI formatting: when a text or file is **not** in the standard format, the app **always asks** whether to send it to the AI to be formatted, with the option **not to send**; the answer is not remembered. A file already in the standard format (`# mr-words 1`) is not asked about.
7. Tatoeba × subtitles: **subtitles are the base and Tatoeba stays at 10%** (decided by the owner; applied in stage 3 after the ablation is repeated for en-US and es).
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

**Built (tools only, no app version).** All in `docs/tools/corpus/` (README section 5): `real_sources.json` (the registry per language, source types `reddit` and `hf`), `sample_real.py`, `prepare_real.py`, `mr-corpus-real.yml` (the manual workflow: report only, or report + cleaned files), `accept_pack.py` (the rule, also in `dictionary-tuning.md`), `docs/tools/e2e/run_real_eval.sh` (SubtitleEval on subtitles, news, Tatoeba and real messages), `test_real.py` (102 checks with fake servers; runs in `mr-checks.yml`).
- Sources chosen for the first run: **Reddit** via Arctic Shift for the three languages (train and test in different communities and different half-years) and **tweets** from Hugging Face as an independent test for es (`pysentimiento/spanish-tweets`) and pt-BR (`fpaulino/portuguese-tweets`). Communities of confession, distress, relationships, personal finances and r/teenagers (minors) are left out on purpose; the lists are in `real_sources.json` and need the owner's approval.
- **Small run (50,000 messages per language, 10 to 17 minutes each) done on the owner's runner.** What it proved: Arctic Shift answers with the date as epoch seconds; the two Hugging Face datasets are served and their text column is found; the three test sets reach 10,000 messages. What it showed and was fixed afterwards: about 15% of the Arctic Shift requests fail with HTTP 422 (the answer is now kept in the log to find the cause); `r/rio` gave nothing (now `riodejaneiro`); the language filter threw out 22 to 29% of correct Spanish (rewritten: now 96 to 100% of known-good text passes); the train sources gave only 0.3 to 0.7 million words, far too little for a pack. Details: `docs/tools/corpus/README.md`, section 5.6.
- Acceptance rule (fixed before stage 3): gain of at least 0.5 point and 2 standard errors on real messages, each independent test source not worse, losses allowed on the other hold-outs (subtitles 0.5, news 1.5, Tatoeba 1.5), size within 12 MB / 7 MB.
- Left for the owner: the **big run** (workflow inputs `train_messages` = 300000, `test_messages` = 40000, `deliver` = data; about 2 to 3 hours per language), then send the three artifacts. The reports of that run show how much the new filter keeps and the 422 causes; if they are acceptable, stage 3 starts with that data.

## Stage 3: 1.89.0, packs with real-message data, inside the budget
- Rebuild pt-BR, en-US and es with a fourth source (informal messages), the Tatoeba decision above (repeating the ablation for en-US and es first), pruning by gain per byte and the size budget (12 MB disk, 7 MB download; `SpeedEval` p95 not worse than +10%; opening not slower). New data replaces weak entries, it does not pile on top. Today: `main.dict` about 5.9 MB, `trigrams.bin` about 5.2 MB, about 6.4 MB zipped per language.
- Guards for informal text: typos becoming words (keep the Hunspell gate and the 150+ occurrences rule for what the speller refuses); accent-free forms (`voce`, `nao`, `esta`) are not new words (rule exists); profanity and slurs keep f = 5; user names, mentions, links, e-mails and phones removed before counting; repeated letters and laughs normalised; duplicates dropped by hash.
- Slang that needs data (`pix`, `tiktok`) comes in here; pack descriptions say "conversa" only where it is true.

## Stage 4: 1.90.0, memory, opening and size of the engine (changes C++)
Each item measured on the PC first.
1. A line in the settings with the load time and the memory held by the dictionaries (the phone numbers we do not have).
2. `trigrams.bin` mapped in memory with a safe pack swap (write a new file and rename it; never overwrite), instead of reading about 5 MB per active language. `mr_engine.h` avoids mmap today because of SIGBUS if a pack is replaced in place. Needs a test that swaps a pack while it is open.
3. Layout of `trigrams.bin` (MRT1): ids in fewer bytes, delta-coded context ids, 2 continuations when the first dominates. Read the real layout before promising anything.
4. Indexes stored in the file instead of built when opening (8 to 14 ms on the PC; the phone is unmeasured).
5. Trigrams only for the languages in use, released when the language changes (check what the code does).
Touching `engine/` means raising `ENGINE_VERSION` and `kEngineVersion` together, `mr_test`, ASan/UBSan, `JniSmoke`, a new `native-libs.zip` from `mr-native.yml`, and `minApp` in the packs if the file format changes.

## Stages 5 to 7: items carried over from `engine-improvements.md`
- **Mixed language** (pt and en in one sentence, both packs installed): read the code first (`Suggest`, `MrPacks`, `MrPredict`), test with mixed sentences, show the options with their cost; implement only what is approved.
- **Finger position**: simulate with `TouchEval` on the PC to see the gain before touching `LatinIME`/`PointerTracker` in smali; implement only if approved.
- **Forgetting over time**: the database keeps 10 thousand pairs and drops 1,000 at once; with the two "My words" screens in place the missing part is a decay over time. Design first (what decays, how fast, what never decays, how the user sees and undoes it).

## Order
1. **Stage 1, 1.88.0** (card + AI). Built; waiting for the device test.
2. **Stage 2** (tools only). Built; small run done (sources viable); waiting for the big run with `deliver = data` (volume for a pack).
3. **Stage 3, 1.89.0** (packs), after stage 2.
4. **Stage 4, 1.90.0** (engine memory and size).
5. **Stages 5, 6, 7** in this order, each with its approval before code.

Sources: [Spanish tweets (Hugging Face)](https://huggingface.co/datasets/pysentimiento/spanish-tweets), [Portuguese tweets (Hugging Face)](https://huggingface.co/datasets/fpaulino/portuguese-tweets), [Pushshift Telegram dataset](https://zenodo.org/records/3607497), [Arctic Shift](https://github.com/ArthurHeitmann/arctic_shift), [OpenAssistant oasst1](https://huggingface.co/datasets/OpenAssistant/oasst1), [FineWeb-2](https://huggingface.co/datasets/HuggingFaceFW/fineweb-2).
