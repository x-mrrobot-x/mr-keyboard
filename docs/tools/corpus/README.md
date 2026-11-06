# Rebuilding a dictionary pack from the corpora (phase 4 of `plan-suggestions.md`)

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
The tuning that led to these values (what each option did on the three hold-outs) is in `plan-suggestions.md`, Phase 4. Writes `main.combined.gz`, `trigrams.bin`, `words.tsv` and `report.txt` (what it did and the lists of new words, to be read by a person). It needs about 3 GB of RAM
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
Then `run_strategy_tests.sh` (S1-S29, the data checks and the floors of S28) and `run_native_parity.sh` with `DICTS=<folder with the new pack>`.
