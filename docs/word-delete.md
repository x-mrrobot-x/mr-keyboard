# Delete by words when held (2.0.0)

Setting **Delete by words when held** (`pref_word_delete`, off by default) in *Settings → Touch and gestures*, right below
*Long-press duration*, and **Time before deleting by words** (`pref_word_delete_after`, 500 ms to 3000 ms, 1000 ms by default; it only
works with the first one on). Code: `MrWordDelete` (Java layer, `docs/tools/java/src`), four small calls in the smali.

## What it does

The delete key repeats: once on the touch, then after 300 ms (`config_delay_before_key_repeat_start`), then every 50 ms
(`config_key_repeat_interval`). With the setting on, a repeat that comes after the key was held for the set time removes the word
before the cursor instead of one letter, and the repeats after it come 4 times later (200 ms with the usual 50 ms), so that the finger
can let go at the word wanted. A tap, or a hold shorter than the set time, is the usual delete; with the setting off nothing changes
(the key down finds it off and every later call returns on its first line).

The time held counts from the touch on the delete key, not from the number of repeats: a quick series of taps never starts the words
(the "20 deletes in a row" of `LatinIME.mDeleteCount`, which only looks at the gap between deletes, is not used).

## What a word is (`MrWordDelete.wordLength`)

Of the text before the cursor (at most 64 characters are read; a longer word goes in more than one step):

1. A line break right before the cursor goes alone (`\r\n` is one).
2. Otherwise the blanks before the cursor go too, but never across a line break: blanks that follow a line break are removed up to it.
3. Then, the letters and digits before the blanks (`_` too; an apostrophe or hyphen between two letters belongs to the word: `don't`,
   `state-of-the-art`); or, when what is there is not a letter, the run of signs (punctuation, symbols, emojis).
4. Accents written as separate marks and the joiner of emoji sequences stay with what they follow, so a family or a flag goes whole.

So `hello world|` removes `world`, `hello, |` removes `, `, then `hello`; `foo-|` removes only the hyphen.

## What is left to the usual delete

- text selected (the delete removes it);
- a word being typed with the suggestions on (`LatinIME.mrComposingLength() > 0`): it is composing text that the keyboard keeps in
  step with the strip, so it goes letter by letter and the words begin with the next repeat. Learning is not touched: a word deleted
  this way is not written to the dictionaries;
- text before the cursor that the app does not give, and the start of the field.

## The calls

| Where | Call | What for |
|---|---|---|
| `PointerTracker.onDownEvent` (key that repeats, before its first repeat) | `MrWordDelete.down(key)` | only the delete key starts a hold; reads the setting the first time |
| `LatinKeyboardBaseView$UIHandler.cancelKeyRepeatTimer` | `up()` | the hold is over |
| `LatinKeyboardBaseView$UIHandler.handleMessage` (repeat) | `interval(normal)` | 4 times the usual interval after a word was deleted |
| `LatinIME.handleBackspace` (after its housekeeping) | `onBackspace(ime)` | true = the word was deleted there; the smali then only updates the shift state and the text entry state |

`LatinIME.mrComposingLength()` is a small method added to the class for it. The setting is read once and followed by a listener on the
default preferences; both keys are in `MrReset.KEYS`.

## Tests

- `docs/tools/worddel_test/WordDelTest.java` (in `run_java_tests.sh`): the rule on a table of texts and on thousands of random ones
  (progress, no half pair, no line break taken with a word), the setting and its limits, the time held against a fake clock, the
  interval, what is left to the usual delete, the setting off, and whole holds replayed on a fake field (the touch, the repeat at
  300 ms, then the interval asked) with the exact text left.
- `docs/tools/test_word_delete.py` (in `mr-checks.yml`): the real smali of `handleBackspace`, `cancelKeyRepeatTimer` and the repeat of
  `handleMessage` in the mini Dalvik interpreter with a fake `MrWordDelete`, the order of the calls in `PointerTracker.onDownEvent`,
  that nobody else calls the class, the place of the setting on the screen, its limits against the Java constants, the texts in the three
  languages and the keys in `MrReset`.
