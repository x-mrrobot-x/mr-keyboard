# Ctrl + delete deletes by words (2.0.0)

Setting **Ctrl + delete deletes by words** (`pref_word_delete`, off by default) in *Settings → Touch and gestures*, right below
*Long-press duration*, and **Interval between words when held** (`pref_word_delete_interval`, 100 ms to 600 ms in steps of 50, 200 ms by
default; it only works with the first one on). Code: `MrWordDelete` (Java layer, `docs/tools/java/src`), four small calls in the smali
and three small methods in `LatinIME`.

## What it does

With the setting on and **Ctrl on when the delete key is touched** (a tap on Ctrl arms it for one key; holding Ctrl with one finger while
the other touches delete works too), the key removes the word before the cursor instead of one letter:

- a **tap** removes one word;
- a **hold** removes one word on the touch and goes on word by word from there, with no time to wait before the words start.

The delete key repeats: once on the touch, then after 300 ms (`config_delay_before_key_repeat_start`), then every 50 ms
(`config_key_repeat_interval`). For a hold with Ctrl the repeats keep the 300 ms start and then come every *interval* ms (the setting,
or the usual 50 ms if that were ever longer), so that the finger can let go at the word wanted: with 200 ms the words go at 0, 300,
500, 700... ms. A shorter interval is faster, a longer one gives more time to stop.

Ctrl is read once, when the key goes down, and kept until it is let go: the keyboard puts a one-shot Ctrl off after the first key, and
the repeats must not lose it. Without Ctrl the delete key is the usual one, tap or hold, whatever the setting; with the setting off
nothing changes (the key down finds it off and every later call returns on its first line).

## What a word is (`MrWordDelete.wordLength`)

Of the text before the cursor (at most 64 characters are read; a longer word goes in more than one step):

1. A line break right before the cursor goes alone (`\r\n` is one).
2. Otherwise the blanks before the cursor go too, but never across a line break: blanks that follow a line break are removed up to it.
3. Then, the letters and digits before the blanks (`_` too; an apostrophe or hyphen between two letters belongs to the word: `don't`,
   `state-of-the-art`); or, when what is there is not a letter, the run of signs (punctuation, symbols, emojis).
4. Accents written as separate marks and the joiner of emoji sequences stay with what they follow, so a family or a flag goes whole.

So `hello world|` removes `world`, `hello, |` removes `, `, then `hello`; `foo-|` removes only the hyphen.

## The word being typed or reopened (Autocompletar on)

With the suggestions on, the word touching the cursor is composing text in the app (the underline), in two ways:

- **typed**: the letters are in `mComposing` (`mPredicting`);
- **reopened by the correction** (the cursor ends up touching a word, e.g. after a paste or after a delete): the app marks the word with
  `setComposingRegion`, the strip shows its suggestions (`TextEntryState.isCorrecting`) and `mComposing` stays **empty**.

Android's `BaseInputConnection.deleteSurroundingText` **counts the composing region as part of the selection** and deletes before *its*
start. So with an underlined word at the end of the field, `deleteSurroundingText(n, 0)` took the n characters from before the
underlined word and left it stuck to the cursor; each repeat did it again, and the pieces of the words piled up glued to it
(`diretamente no código-fonte` became `dircódigo-fonte`, then `doccomentádircódigo-fonte`, ...). Letter by letter rewriting of the
composing text (the first try) fails the same way when the app and the keyboard disagree about where it is.

So before every delete the class:

1. finds the word by `wordLength` in the text read from the app (the composing letters are part of it);
2. if the keyboard holds a word (`LatinIME.mrHoldsWord()`: typed, or `isCorrecting`) lets go of it (`mrDropComposing()`: for a typed word
   the steps `onUpdateSelection` takes when the cursor leaves it, for a reopened one `abortCorrection`; nothing is committed, so the
   word is **not** learned);
3. **always** tells the app `finishComposingText()` (a no-op when there is none; it covers an app that has composing text the
   keyboard does not know about);
4. `deleteSurroundingText(n, 0)`. 2 to 4 go in one batch of edits.

So the class never writes composing text, and what it deletes depends only on the text of the app. A word reopened after a hyphen
(`código-fonte`) goes whole, as the rule says.

## What is left to the usual delete

- text selected (the delete removes it);
- text before the cursor that the app does not give, and the start of the field.

## The calls

| Where | Call | What for |
|---|---|---|
| `PointerTracker.onDownEvent` (key that repeats, before its first repeat) | `MrWordDelete.down(key)` | only the delete key starts a hold; reads the setting the first time; asks `LatinIME.mrCtrlOn()` once |
| `LatinKeyboardBaseView$UIHandler.cancelKeyRepeatTimer` | `up()` | the hold is over |
| `LatinKeyboardBaseView$UIHandler.handleMessage` (repeat) | `interval(normal)` | the setting's interval (at least the usual one) while the hold is by words |
| `LatinIME.handleBackspace` (after its housekeeping) | `onBackspace(ime)` | true = the word was deleted there; the smali then only updates the shift state and the text entry state |

`LatinIME` gets `mrCtrlOn()` (is Ctrl on), `mrHoldsWord()` and `mrDropComposing()`. The setting is read once and followed by a listener
on the default preferences; both keys are in `MrReset.KEYS`.

The Ctrl key is in the compact, compact-with-Fn and full layouts (`kbd_compact.xml`, `kbd_compact_fn.xml`, `kbd_full.xml`).

## Tests

- `docs/tools/worddel_test/WordDelTest.java` (in `run_java_tests.sh`): the rule on a table of texts and on thousands of random ones
  (progress, no half pair, no line break taken with a word), the setting and its limits, the Ctrl latch (read at the touch, kept
  after Ctrl goes off), the interval, the word being typed or reopened, what is left to the usual delete, the setting off, and whole
  holds replayed on a fake field (the touch, the repeat at 300 ms, then the interval asked) with the exact text left. The fake field
  deletes the way `BaseInputConnection` does (the composing region counts as selected), and one replay is the phrase of the video with
  the keyboard reopening the touched word after every delete: the earlier code fails it.
- `docs/tools/test_word_delete.py` (in `mr-checks.yml`): the real smali of `handleBackspace`, `cancelKeyRepeatTimer` and the repeat of
  `handleMessage` in the mini Dalvik interpreter with a fake `MrWordDelete`, the order of the calls in `PointerTracker.onDownEvent`,
  the three methods added to `LatinIME`, that nobody else calls the class, the place of the setting on the screen, its limits against
  the Java constants, the texts in the three languages and the keys in `MrReset`.
