# Rebuilding a dictionary pack from the corpora (the rebuild of 1.86.1, results in `docs/dictionary-tuning.md`)

The text of the corpora is never in the repository and never in a pack: only counts leave it. What is here are the scripts; the corpora are
downloaded by a GitHub runner (below) and the work files stay in a scratch folder.

## 1. Get the corpora
`mr-corpus-samples.yml` (this folder) is a manual workflow: copy it to `.github/workflows/` of a **private** repository, run *Mr Keyboard - corpus
samples* and download the artifact of each language (`corpus-es`, `corpus-pt-BR`, `corpus-en-US`). Each one has the OpenSubtitles 2018 sample (one line in
every 64; 128 for English), the Tatoeba sentences of the language and the Leipzig news sentences, plus `SUMMARY.txt` (sizes, counts, sha256).
Delete the artifacts after downloading: the OpenSubtitles text has no clear licence.

The AOSP base list and the Hunspell spellers are the same as for the earlier packs:
```
git clone --depth 1 --filter=blob:none --sparse https://github.com/LibreOffice/dictionaries lo && (cd lo && git sparse-checkout set es)   # es_ES, es_MX, es_AR
git init aosp && cd aosp && git remote add origin https://github.com/LineageOS/android_packages_inputmethods_LatinIME \
  && git fetch --depth 1 --filter=blob:none origin c9e8aa87038e1194d2717ac48f207df4068cebd9 && git checkout FETCH_HEAD -- dictionaries/es_wordlist.combined.gz
```
(`libhunspell-1.7.so.0` must be installed: `Speller` in `make_wordlist.py` loads it with ctypes.)

## 2. Clean and split (`prepare_corpus.py`)
```
python3 -I docs/tools/corpus/prepare_corpus.py --lang es --subs es.opensubtitles.sample.txt.gz --tatoeba es.tatoeba.tsv.bz2 \
    --news es.leipzig-sentences.txt.gz --out work/es --tatoeba-code spa --names "Tom,Mary,Tomás,Marta"
```
Subtitles: tags, sound descriptions, credits and timestamps are removed, a dialogue dash at the start is dropped. **The hold-out is chosen by the hash
of the sentence** (`md5 % 20 == 0`, about 5% of the distinct sentences), so a test sentence is never in the training counts even when the subtitles repeat it
hundreds of thousands of times. `subs_test.txt` has each test sentence once. Tatoeba: repeated sentences dropped, 1 in 20 to test. News: 1 in 50 to test.

## 3. Counts, mix and pack data (`make_pack_data.py`)
```
python3 -I docs/tools/corpus/make_pack_data.py --lang es --work work/es --base es_wordlist.combined.gz \
    --spell es_ES.aff:es_ES.dic --spell es_MX.aff:es_MX.dic --spell es_AR.aff:es_AR.dic --out work/es/out \
    --mix subs=0.45,chat=0.25,news=0.30 --min-ctx 6 --min-tri 2 \
    --foreign-list en_wordlist.combined.gz --foreign-list de_wordlist.combined.gz
python3 -I docs/tools/build_dict.py work/es/out/main.combined.gz main.dict --format 2
```
That is the command of the Spanish pack 4 (1.86.1). `--foreign-list` takes the AOSP lists of languages that do NOT share word forms with the target
(`dictionaries/en_wordlist.combined.gz` and `de_wordlist.combined.gz` come from the same AOSP commit as the base list): a new word that is in one of
them needs 150+ real occurrences or 15+ in the news sample, otherwise it is song lyrics or a quote. Portuguese, French and Italian lists were tried and
removed: they threw out real Spanish words (`tsunami`, `vegano`, `calmate`).
**Portuguese (pt-BR 6, 1.86.1).** Same options, with three differences. (1) `prepare_corpus.py ... --lang pt-BR --tatoeba-code por --drop-european-pt` removes by sentence
the ones with European Portuguese markers (and the credit lines of the subtitles); the filter by site or by author of `split_br.py` is not possible because the
workflow artifact has no Leipzig source names and no Tatoeba authors, so a European sentence without a marker still counts. (2) `--base` is NOT the raw AOSP list but the
list of the **old recipe run on the same splits** (`make_wordlist.py --base pt_BR_wordlist.combined.gz --corpus work/pt-BR/news_train.txt --corpus2 work/pt-BR/chat_train.txt --weight2 3
--vero-aff pt_BR.aff --vero-dic pt_BR.dic --en-aff en_US.aff --en-dic en_US.dic --out main.combined.gz`), because that is the one that already has the 1990 spelling agreement and the Lusitanian
forms taken out; the raw AOSP list is given as `--offensive-from pt_BR_wordlist.combined.gz`, only to know which words are possibly offensive. The same run, followed by `make_trigrams.py`, is
the old pack that the new one is compared with. (3) `--spell pt_BR.aff:pt_BR.dic` (Hunspell VERO, `LibreOffice/dictionaries`, folder `pt_BR`) and the same `--foreign-list en --foreign-list de`.
The pairs and triples use `--mix subs=0.45,chat=0.25,news=0.30 --min-ctx 6 --min-tri 2`, as in Spanish. `make_pack_data.py` also treats the inflections of the swear words
(`vulgar_re`: `cago`, `fodeu`, `merdinha`...) like the vulgar list: f = 5 and never predicted. It needs about 2 GB of RAM and 5 minutes.
**English (en-US 5, 1.86.1).** `prepare_corpus.py --lang en-US --tatoeba-code eng --names "Tom,Mary,Boston,Rima,Layla,John,Skura,Ziri,Sami,Yanni,Linda,Australia,Algeria,Algiers,Algerian,Berber,Kabyle,Kabylie"`
(the English subtitles also lose their credit lines: `CREDIT_EN_RE`); then `make_pack_data.py --lang en --work work/en-US --base en_wordlist.combined.gz --spell en_US.aff:en_US.dic
--mix subs=0.45,chat=0.25,news=0.30 --min-ctx 6 --min-tri 2` plus `--foreign-list` for the AOSP lists of Spanish, German, French and Italian. The base is the raw AOSP list (nothing to clean first), the speller is
Hunspell `en_US` (`LibreOffice/dictionaries`, folder `en`), and the old pack for the comparison is `make_wordlist_en.py` + `make_trigrams.py` on the same splits with Tatoeba weight 1 (it reproduces the shipped
en-US 4 to the digit: 12.1 / 29.4 / 42.8 / 62.8% against 12.1 / 29.4 / 42.9 / 62.9% on the subtitle hold-out). English needs its own rules, all in the `en` entry of `make_pack_data.py`: the apostrophe-free
form of a word of the list is never a new word (`dont` would stop the correction to `don't`); subtitle stutters (`i-i`, `w-what`), compounds with a contraction and `A's` are refused; slurs and the inflections of
swear words (`fuckin`, `shitty`) get f = 5; the other languages' lists only judge short words without a hyphen (they hold `barista`, `quinoa` and `e-mails` too); and a capitalised word that has a lowercase
twin (`Nice`, `Good`, `Hi`, `Will`) counts only the occurrences inside a sentence, because the capital at the start of a sentence is the twin (without it `Nice` took a slot of the strip next to `nice`). It needs
about 3 GB of RAM and 8 minutes.
The tuning that led to these values (what each option did on the three hold-outs) is in `docs/dictionary-tuning.md`. Writes `main.combined.gz`, `trigrams.bin`, `words.tsv` and `report.txt` (what it did and the lists of new words, to be read by a person). It needs about 3 GB of RAM
and 8 minutes for the Spanish sample; do not run two at once on a small machine.

The sources are weighted so that after the weighting each one has its share of the mass (`--mix`); the real counts still decide what is allowed in. The
frequency of EVERY word is recomputed from the weighted counts (`f = a*log10(count) + b`, the line fitted on the AOSP words) and blended with the AOSP
frequency (a word with 30+ real occurrences takes 95% of the corpus value, one seen less is pulled towards the AOSP value). A new word enters when it
is accepted by the Hunspell spellers and has 3+ real occurrences, when it is a frequent loanword or slang that the spellers refuse (150+ occurrences, at
least 3 in two sources, written in lowercase), or when it is a name seen 20+ times in the middle of a sentence. Refused on purpose: function words of
another language that the subtitles quote (`FOREIGN`) and the accent-free form of a word that is in the list (`aqui` next to `aquí`).

## 4. Measure (same hold-out for every candidate and for the old pack)
`SubtitleEval` reads a plain text file, one sentence per line (docs/tools/e2e/README.md). Use the three hold-outs (subtitles, Tatoeba, news) so a gain in one
register does not hide a loss in another; an old pack must be compared with a pack rebuilt by the **old scripts on the same splits**
(`make_wordlist_lang.py` + `make_trigrams.py`, news weight 1, Tatoeba weight 3), because the shipped pack has seen the sentences of its own export.
Then `run_strategy_tests.sh` (S1-S29, the data checks and the floors of S28) with `DICTS=<folder with the new pack>`.

## 5. Real messages: sample, clean, split and measure (stage 2 of `docs/plan-next.md`)
Why: the "chat" source of the mix is Tatoeba (translated example sentences) and none of the three hold-outs is text typed by people. This section adds a **fourth test
(real messages)** and the data for a fourth source. Nothing here changes the app; the tools only produce numbers and files for the next pack.

| File | What it is |
|---|---|
| `real_sources.json` | **The registry.** Per language (`pt-BR`, `es`, `en-US`): the dictionary used by the language filter, the minimum size of the test, a profanity list for the report, and the `sources`. Each source has an `id`, a `type` (`reddit` or `hf`), a `role` (`train` or `test`), a `weight` (its share of `--messages`, or of the total of its role when the workflow gets `train_messages` / `test_messages`) and its own settings (the subreddits and the period, or the Hugging Face dataset). Services, pauses, retries and the language-filter thresholds are at the top. |
| `sample_real.py` | Downloads the sample of one language. `reddit`: Arctic Shift API, comments of the listed subreddits taken from random windows of time inside `[after, before)`, so one viral thread cannot fill the sample; a pause of 2 s between calls, a wait on 429, a smaller page after a timeout, the format of the date parameter probed on the first call (the finest that works: epoch, ISO, then a plain date), each page read from the start or from the end of its window at random; each community remembers which spans of time its pages already read and never asks for them again (a page cut short at a read span); a community that fails 6 requests in a row for a refusal stops, but for "Timeout. Maybe slow down a bit" (the service is busy) it waits 2 minutes and goes on, and gives up only after 3 such pauses with no success between; the quota a small or failing community could not give is asked again from the others (extra rounds); `--max-minutes` is a time budget for the whole run (test sources first, then the train ones with the time left; what was read is kept); an HTTP error keeps the body of the answer (`error_samples` in the log, with the parameters of the request), because Arctic Shift explains its 422 there. `--role-messages train=N,test=M` gives each role its own total. `hf`: Hugging Face datasets-server (`/rows`), random pages of 100 rows; the text column is found from the features. A source that fails is reported and the others go on. User names are hashed with a random salt on the spot and never written. Standard library only. |
| `prepare_real.py` | Cleans, filters the language (see 5.2), drops repeated messages, caps one user at 1% of a source, splits into `chat_real_train.txt`, `chat_real_dev.txt`, `chat_real_test.txt` (+ one test file per test source) and writes `real_report.md/json` (numbers only, plus the 50 most frequent words that are not in the dictionary and were used by 5+ different users). Rules in the header of the script. |
| `mr-corpus-real.yml` | The manual workflow (like `mr-corpus-samples.yml`): checks out this repository, runs the two scripts, puts the report in the *Summary* of the run and uploads the artifact `real-<language>` (report always; the cleaned text only with `deliver = data`). |
| `accept_pack.py` | The acceptance rule for a candidate pack (below). |
| `../e2e/run_real_eval.sh` | `SubtitleEval` on the four tests for one dictionary folder. |
| `test_real.py` | Tests of all of the above with fake servers (no network); runs in `mr-checks.yml`. |

### 5.1 Run it (a few minutes of your time; the run itself takes hours, because the free services are slow on purpose)
1. Copy `docs/tools/corpus/mr-corpus-real.yml` to `.github/workflows/` of the **private** repository where you already run `mr-corpus-samples.yml`. (It checks out `x-mrrobot-x/mr-keyboard` itself, at the branch or tag you give in `ref`, so the scripts must be pushed there first.)
2. Actions → **Mr Keyboard - real messages** → Run workflow. Small run (about 15 minutes per language): leave `messages` = 50000, `train_messages` and `test_messages` empty, all languages, `deliver` = **report**, `ref` = main.
3. When the three jobs end, open each one and read **Summary** (the report and the sampler log). Send me the three reports (or download the artifacts `real-pt-BR`, `real-es`, `real-en-US`: they have `real_report.md`, `real_report.json`, `sample_log.json`, only numbers and the 50 words).
4. Big run, only after the small one looked right: `train_messages` = 250000 and `test_messages` = 30000 (both together; `messages` is then ignored), `deliver` = **data**, `max_minutes` = 240. One request every 2 seconds, up to 100 comments per request, and about 1 in 5 requests fails and is paid for: the three big runs needed 4.2 to 4.4 hours for 300,000 train comments (4.7 to 4.8 with the test sources). `max_minutes` stops the sampling in time (the job limit is 300 minutes and a job that hits it loses everything, artifact included); what was read is cleaned and delivered, and the report says how much was missing. The artifact then also has `chat_real_*.txt.gz`, already cleaned. The text is not in the repository; delete the run after downloading. The free plan has 2,000 runner minutes a month, and a big job is billed for all the time it runs (up to about 270 minutes).

### 5.2 How to read the report
* **Sampler** (`ok`, `EMPTY`, `FAILED`): a source that did not answer. The sampler log says what happened per community (requests, failures, `stopped`). Arctic Shift is a free archive with no guarantee; if a community returns nothing, replace it in `real_sources.json` rather than insisting.
* **raw / links / units kept**: raw comments or tweets; the share that had a link (removed); the sentences left after the cleaning (a comment becomes one or more lines).
* **purity**: of the sentences that could be judged, the share kept by the language filter. Under 80% means a lot of another language. The "other languages" line says which.
  The filter compares the sentence with the dictionary of the language and with the dictionaries of the other two: for each other language it counts the words only the target knows (a) and the words only the other knows (b). The sentence is dropped as **another language** if b > a for any of them, and as **low coverage** if the target knows less than half of its words (`min_cover`). When every word is valid in two languages (`si`, `no`, `me`) the sentence stays and is counted in "kept because every word is valid in two languages". A word with an accent must match exactly; a word without one may match an accented word (typing `voce`, `nao`). Sentences with fewer than 2 judgeable words (3+ letters) are dropped as unjudged. Measured on 20,000 sentences of each hold-out already known to be in the language (subtitles, chat, news): 96.4% to 100% pass (Spanish subtitles the lowest, with the real foreign lines of films); the first version (a margin of the share of known words) kept only 71 to 78% of the Spanish and was replaced.
* **repeated, profanity**: share of identical messages (dropped) and of sentences with a word of the profanity list.
* **out of the dictionary**: share of words (3+ letters) not in the dictionary, a lower bound (the language filter favours known words). **accent-free forms** are `voce`, `nao`: counted apart, not new words.
* **flags** per source: `ok` or what is wrong (including a sampler that stopped at the time budget or gave less than 90% of what was asked). **TEST TOO SMALL** says how many messages to ask for in the next run.
* **50 words**: the most frequent words not in the dictionary used by 5+ users (`*` = looks like a name). It is the list to read for slang that is missing and for junk that must not enter.

### 5.3 Add a language, a community or a source
Edit `real_sources.json`: a community is one more name in `subreddits`; a language is a new entry under `languages` (its `dictionary` must exist, because the language filter needs it, and the `case` list of the `plan` step in the workflow must name it); another source of the same two types is one more object in `sources`. A new type of source is one more function in `sample_real.py` and a branch in `main()`. Keep out communities of personal confession, distress, health or finances and any with minors; the list in the file already leaves them out.

### 5.4 Measure a candidate pack (the fourth test and the acceptance rule)
```
python3 -I docs/tools/corpus/prepare_real.py --config docs/tools/corpus/real_sources.json --lang pt-BR --raw work/pt-BR/raw --out work/pt-BR/real   # only if you have the raw files
bash docs/tools/e2e/run_real_eval.sh pt-BR <old dicts> work/pt-BR work/pt-BR/results/old     # the baseline built the old way on the same splits (section 4)
bash docs/tools/e2e/run_real_eval.sh pt-BR <new dicts> work/pt-BR work/pt-BR/results/new
python3 -I docs/tools/corpus/accept_pack.py --lang pt-BR --old work/pt-BR/results/old --new work/pt-BR/results/new --pack-dir <new dicts>/pt-BR
```
`work/pt-BR` has `subs_test.txt`, `news_test.txt`, `chat_test.txt` (from `prepare_corpus.py`) and `real/` (from `prepare_real.py`). A dicts folder is `<dicts>/<lang>/main.dict + trigrams.bin + rules.txt` (copy `rules.txt` of the shipped pack next to a candidate). `accept_pack.py --rule` prints the rule; its reasons are in `docs/dictionary-tuning.md`. Exit code 0 accepted, 1 rejected, 2 a result is missing.

### 5.5 What this does not tell you
* The language filter uses the dictionary, so very new slang and typos are filtered a little; the report's out-of-dictionary rate is therefore a lower bound.
* `fpaulino/portuguese-tweets` has no user column: one block of 100 rows counts as one user, so its "users" figure is the number of blocks (125 in the first run), not people.
* Reddit is written text, longer than a phone message and with a different mix of topics; the Spanish tweets are from 2019 (the style of that year). Both are better than translated sentences, neither is WhatsApp.
* The accent-free typing of Brazilians (`nao`, `voce`) is real and the dictionary does not predict those forms; it lowers the real-message rates for the old and the new pack equally.
* Arctic Shift and the Hugging Face viewer can change or fail; the probe and the report exist so that a change is seen, not hidden.

### 5.6 What the first run showed (50,000 messages per language, 10 to 17 minutes each, on the owner's runner)
* **The sources work.** Reddit through Arctic Shift (date as epoch seconds) gave 7,400 to 28,600 comments per source; the Hugging Face tweets gave exactly what was asked (es 15,000, pt-BR 12,500). All three test sets reach the 10,000-message minimum.
* **About 15% of the Arctic Shift requests failed with HTTP 422** and the first sampler did not keep the answer. It does now (`error_samples`); read them in the log of the next run before deciding what to change. Failures are not fatal: the run went on and the rest of the quota was asked again.
* **`r/rio` is not the right name** (it gave nothing); the file now has `riodejaneiro`.
* **Spanish purity of 71 to 78% was the filter's fault**, not the data: pure Spanish subtitles also scored 78%. The new filter (5.2) passes 96% of the Spanish subtitles and 99% of the Spanish chat and news hold-outs, and still drops sentences that are mostly English or Portuguese. How much of the Reddit and tweets it drops is in the report of the next run.
* **Train volume is too small for a pack.** The three train sources gave 22,000 to 59,000 sentences (about 0.3 to 0.7 million words); a pack source needs millions. The big run (`train_messages` = 300000) aims at about 10 million words per language. The small run was enough to choose sources, not to build a pack.
* Communities of confession, distress, relationships, personal finances and r/teenagers stay out; nothing in the reports identifies a person.

### 5.7 What the big run showed (`train_messages` 300000, `test_messages` 40000 per language, on the owner's runner)
* **All three jobs delivered, but only just.** Sampling alone took 283 min (pt-BR), 288 min (en-US) and 284 min (es) of the 300-minute job limit, leaving 12 to 17 minutes for the cleaning and the upload; a job that hits the limit loses the artifact. That is why the sampler now has a time budget (`max_minutes`).
* **The cause of the 422: "Timeout. Maybe slow down a bit".** It is the service's own timeout, not a bad parameter: 17 to 23% of the train requests (9 to 13% of the test ones), in bursts, mostly answered at once, also for windows of 1 hour and pages of 100. The first sampler stopped Chile and Colombia after 6 failures in a row, so Mexico and Argentina (90,700 comments each) outweighed them (29,600 and 61,500). The sampler now waits 2 minutes after 6 failures and goes on.
* **Re-reading the same comments.** r/spain gave 27,000 comments for 2,389 requests (a third of the Spanish run, 96,000 repeated rows in all) and the small Brazilian communities were as bad (`Bahia` 877 comments out of 7,041 rows, `pernambuco` 480 out of 6,533): windows read from random starts overlapped. The sampler now keeps the spans already read and cuts a window where it would run into one; on a fake community the old code made 1,276 requests and read 61,000 rows to find 3,700 comments, the new one 225 requests and 4,320 rows.
* **Volume and cleaning** (sentences → messages kept by the splits):

| | train | dev | test | language purity | out of the dictionary |
|---|---|---|---|---|---|
| pt-BR | 563,420 messages, 7.8 million words | 29,999 | 61,481 (Reddit 40,230, tweets 21,251) | 98 to 99% | 2.2% (accent-free 0.7%) |
| en-US | 587,540 messages, 7.5 million words | 30,710 | 95,532 (Reddit only) | 100% | 1.7% |
| es | 457,285 messages, 6.7 million words | 24,024 | 50,826 (Reddit 28,170, tweets 22,656) | 85 to 92% | 4.5% (accent-free 2.0%) |

  No message is in two sets. Spanish is the only one with a lot of English in it (32,246 sentences dropped as English, 5.3% of the candidates; 34,144 kept because all their words are valid in two languages); en-US has a single test source, so there is no second source to check it against.
* **Privacy scan of the cleaned files** (train, dev and test of the three languages): no URL, e-mail address, `@user`, `u/` or `r/` name, phone or marker is left. What the patterns still find is the inclusive `@` (`amig@s`), amounts (`1.500.000`), strings of digits typed by hand and, once in 563,000 lines, a user-name-like string inside a quotation. The text stays on the runner; the files are for the private repository only.
* **The pt-BR tweets were collected by their emoticons**: 38% of the messages end with `:)` or `:(`, so that set leans to praise and complaint. It is a second, independent source, not a neutral one.
* **The shipped packs on real messages** (`SubtitleEval`, first 20,000 sentences of each test, same words of 4+ letters; after a space / 3 letters):

| | subtitles | Tatoeba | news | real: Reddit | real: tweets |
|---|---|---|---|---|---|
| pt-BR | 14.1 / 58.9 | 19.4 / 62.9 | 14.5 / 51.8 | 9.1 / 52.5 | 9.4 / 51.3 |
| en-US | 14.6 / 68.1 | 18.6 / 70.4 | 11.8 / 53.6 | 9.4 / 58.6 | (one test source) |
| es | 11.1 / 53.2 | 14.8 / 58.3 | 10.3 / 48.1 | 7.1 / 47.9 | 7.2 / 47.1 |

  Real messages are the hardest test in every language: 4 to 5 points below the subtitles after a space in pt-BR and en-US, and a few points below at 3 letters. The published packs have seen part of the subtitle sentences and none of the real ones, so the gap is, if anything, larger than it looks.

  The two independent sources agree in Spanish and in Portuguese.
* **What the most frequent unknown words are**: names (`milei`, `trump`, `lebron`, `xandão`), the site (`reddit`, `youtube`), regional slang and profanity (`wey`, `wea`, `pqp`, `fuder`, `nomás`), words typed without apostrophe in English (`dont`, `thats`, `ive`), and the vocabulary of each community (`python`, `stack`, `pix`, `nvidia`). Stage 3 decides which of them a pack takes; names and profanity keep the existing rules.
