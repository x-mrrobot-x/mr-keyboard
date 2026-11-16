# Ctrl + delete deletes by words (2.0.0)

Setting **Ctrl + delete deletes by words** (`pref_word_delete`, off by default) in *Settings → Touch and gestures*, right below
*Long-press duration*, and **Interval between words when held** (`pref_word_delete_interval`, 100 ms to 600 ms in steps of 50, 200 ms by
default; it only works with the first one on). Code: `MrWordDelete` (Java layer, `docs/tools/java/src`), five small calls in the smali
and four small methods in `LatinIME`. The same setting turns on Ctrl + Z word by word (below).

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

## Ctrl + Z gives the words back one at a time

The app puts deletes that follow each other in a single step of its undo (the platform's `EditText` consolidates continuous deletes:
`EditOperation.mergeDeleteWith` joins a delete that ends where the last one began), so two words taken with Ctrl + delete came back
together with one Ctrl + Z, and the keyboard cannot cut that step in two. So `MrWordDelete` keeps what it takes.

- Every word taken is kept with the text around the cursor as the delete left it (up to 64 characters before it and up to 64 after
  it, `Cut`).
- A **Ctrl + Z** (Ctrl alone: no Shift, Alt or Meta) goes through `LatinIME.sendModifiableKeyChar`, which asks `MrWordDelete.onUndo`
  first. If the text is **exactly** what the last word left (same text before and after the cursor, nothing selected), the word is
  written back at the cursor (`commitText(word, 1)`, after the app's composing text is finished, because `commitText` replaces it) and
  the key is **not sent to the app**. The next Ctrl + Z gives the one before, and so on, in reverse order.
- Anything else goes to the app as always: other keys, Ctrl + Shift + Z (the redo of the app), a selection, text that is not the one the
  word left (typed, cursor moved, field changed), or nothing kept. A text that is not the one kept lets go of **everything** kept.
- **One word alone** is left to the undo of the app (it gives the same, and keeps its own history in step with the text). The class
  takes over when there are two or more words, or when the old ones were let go (expired, limit) and the app's step holds more
  words than the keyboard.

**Nothing piles up.** Each word expires after `UNDO_LIFETIME_MS` (2 minutes); at most `UNDO_MAX` (32) are kept, the oldest goes first;
turning the setting off clears them all; the text that is not the one kept clears them all, and the delete that finds the text changed
since the last word starts again from its own word. The expired ones are let go with the next key typed or deleted (the hook runs for
every character the keyboard sends and returns on its first line while nothing is kept); no timer runs while the keyboard is idle. What
is kept is at most 32 words of 64 characters and the text around them, in memory only, never written anywhere and never learned.

**Known limit.** The words written back are typing for the app. After the last word is back, a further Ctrl + Z goes to the app, which
takes the typing out first (the words go again) before it reaches what came before the deletes. The words of the app's own step are
the same ones, so a Ctrl + Z more brings them back, and the next one goes on with the earlier history.

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

| `LatinIME.sendModifiableKeyChar` (first thing) | `onUndo(ime, char)` | true = a Ctrl + Z was done there (the last word written back); the smali then only lets go of the one-shot Ctrl, as for a plain character, and the key is not sent |

`LatinIME` gets `mrCtrlOn()` (is Ctrl on), `mrCtrlOnly()` (Ctrl and no Shift, Alt or Meta), `mrHoldsWord()` and `mrDropComposing()`. The setting is read once and followed by a listener
on the default preferences; both keys are in `MrReset.KEYS`.

The Ctrl key is in the compact, compact-with-Fn and full layouts (`kbd_compact.xml`, `kbd_compact_fn.xml`, `kbd_full.xml`).

## Tests

- `docs/tools/worddel_test/WordDelTest.java` (in `run_java_tests.sh`): the rule on a table of texts and on thousands of random ones
  (progress, no half pair, no line break taken with a word), the setting and its limits, the Ctrl latch (read at the touch, kept
  after Ctrl goes off), the interval, the word being typed or reopened, what is left to the usual delete, the setting off, and whole
  holds replayed on a fake field (the touch, the repeat at 300 ms, then the interval asked) with the exact text left. The fake field
  deletes the way `BaseInputConnection` does (the composing region counts as selected), and one replay is the phrase of the video with
  the keyboard reopening the touched word after every delete: the earlier code fails it. Ctrl + Z: the last word first, in reverse order;
  a word alone left to the app; Ctrl with Shift/Alt/Meta and other keys left alone; text typed, cursor moved or a selection (everything
  let go); the app's composing text finished before the word is written; words that expire (the last millisecond before, the time itself,
  only the old ones, a key other than Z letting them go), the limit, the setting turned off and on, a failing app.
- `docs/tools/test_word_delete.py` (in `mr-checks.yml`): the real smali of `handleBackspace`, `cancelKeyRepeatTimer` and the repeat of
  `handleMessage` in the mini Dalvik interpreter with a fake `MrWordDelete`, the order of the calls in `PointerTracker.onDownEvent`,
  the hook of Ctrl + Z at the top of `sendModifiableKeyChar` (run: the key is not sent when the class took it), the methods added to
  `LatinIME` (`mrCtrlOnly` run with every modifier), that nobody else calls the class, the place of the setting on the screen, its limits against
  the Java constants, the texts in the three languages and the keys in `MrReset`.
