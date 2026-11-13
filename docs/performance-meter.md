# Performance meter

Since the performance round after v1.98.0 the keyboard times its own work on the phone and shows it in **Settings → Advanced →
Performance → Keyboard times**. Code: `MrPerf` (`docs/tools/java/src/com/mrkeyboard/app/MrPerf.java`); the smali of the keyboard
calls a begin and an end around each piece of work, with no register taken.

## Lines

Each line is `name: average · 95 % within · maximum (count)`, in milliseconds. The average and the 95 % come from the last 256
times of that line; the maximum and the count from the last reset. A line measured once shows only its time; a line never
measured is not shown.

| Line | What is timed | Where |
|------|---------------|-------|
| Start the keyboard | a new process of the keyboard: the fields of the service (compose tables included) and `onCreate` | `LatinIME.<init>` → end of `onCreate` |
| Build the keyboard | the keyboard view and the tool bar made (first open of a process, theme, app language, rotation) | `LatinIME.onCreateInputView` |
| Open in a field | the keyboard getting ready for a field | `LatinIME.onStartInputView` |
| Until it appears | from the start of the open to the end of the first frame after it; not counted beyond 2 s (nothing was redrawn) | `onStartInputView` → `LatinKeyboardBaseView.onDraw` |
| Draw a frame (GPU) / Draw a frame (CPU) | one frame of the keyboard or of a popup of variants. The name says how this phone draws the keyboard window (`MrAccel.state`): **GPU** is the time to record the drawing, not the GPU's work; **CPU** is the whole drawing. The two are not comparable, so they are never mixed in one line. Before the mode is known the line is just "Draw a frame" | `LatinKeyboardBaseView.onDraw` |
| Handle a key | all the work of a key, the waits for the app included | `LatinIME.onKey` |
| Key: letter or digit / space, punctuation, Enter / delete / shift, symbols, modes | the same time of "Handle a key", split by the primary code of the key: letters and digits; any other positive code (space, Enter, punctuation); delete (-5); the other negative codes and 0. A key is in "Handle a key" and in one of the four | `LatinIME.onKey` |
| Touch wait | how late a finger down (first or another) reached the keyboard: the clock against the time of the event. A busy main thread shows here | `LatinKeyboardView.onTouchEvent` |
| Wait for the app | every question that waits for the app's answer: the text before and after the cursor (the previous word, the word under the cursor, the old word on open), the selected text, the caps mode, and the whole text of a field that does not report its selection | `getTextBeforeCursor`, `getTextAfterCursor`, `getSelectedText`, `getCursorCapsMode`, `getExtractedText` in `LatinIME`, `EditingUtil` and the Java layer (`MrPredict`, `MrRecorrect`, `MrGestureInput`) |
| Suggestions | the suggestions of the strip computed | `LatinIME.updateSuggestions` |
| Suggestions: the engine | the call to the suggestion engine, wherever it comes from (typing a word, a space) | `Suggest.getSuggestions` |
| Suggestions: show the strip | the strip filled and drawn | `LatinIME.setSuggestions` |
| Open: choose the keyboard for the field | inside "Open in a field": the keyboards made if needed, the field type read and the keyboard put on the view | `onStartInputView`, from `makeKeyboards` to the `closing()` of the view |
| Open: read the settings | inside "Open in a field": `loadSettings` | `onStartInputView` |
| Open the long-press popup | the popup of variants of a key built and shown | `LatinKeyboardBaseView.onLongPress` |
| Popup: put the variants together | inside "Open the long-press popup": the variants of the key built (`Key.getPopupKeyboard`). Only when the popup of that key was not kept from before, so its count against the count of the popup line is how many long presses found the variants ready | `LatinKeyboardBaseView.getLongPressKeyboard` |
| Popup: show the window | inside "Open the long-press popup": the popup window shown (`PopupWindow.showAtLocation`, a call to the system) | `LatinKeyboardBaseView.onLongPress` |
| Selection change | the keyboard's reaction when the app reports a new cursor or selection (after every key typed, and when the user moves the cursor). Includes the questions it asks the app back | `LatinIME.onUpdateSelection` |
| Selection echo: one question / full check | inside "Selection change": the check "is the cursor touching a word" after a new selection. **One question**: the report was the echo of a separator the keyboard typed itself, so only the character after the cursor was asked. **Full check**: any other report (another cursor position, a selection, a key typed in between, no separator of ours). The count of each line says how many echoes took each way | `LatinIME.mrEchoTouchingWord` |
| Message | the work of the keyboard's own delayed messages (the shift state, the suggestions after a key) | `LatinIME$1.handleMessage` |
| Wait for the app: inside a key / in the suggestions / when opening / in a selection change / in a message / at other times | the same waits as "Wait for the app", counted again by where they are asked: inside a key (not in its suggestions), inside the suggestions, inside an open, inside the reaction to a selection change, inside a message, and anywhere else. The innermost piece of work under way decides, so a wait is in "Wait for the app" and in exactly one of the six. A piece of work that began more than 10 s ago and never ended is not taken as the place | `MrPerf.appEnd` |

Then the memory of the process when the screen opens: Java heap in use and native heap (the screens share the process with the
keyboard, so their own memory is in it too).

## How to read it

1. Tap the row: everything starts again from zero. (To see "Start the keyboard" and "Build the keyboard" do not tap: force stop the
   keyboard app, open a field in another app, type a little and come back here.)
2. Use the keyboard as usual for a few minutes: a long field (note, e-mail) and a chat, a theme you use.
3. Come back to the row. The numbers are kept while the process lives; when Android ends the process they are gone ("Nothing
   measured yet").

When the keyboard hides after keys were typed, one line goes to the log: `adb logcat -s MrPerf`
(`frame 4.2/6.0/14.1 ms (420) key ... heap 24.1 MB native 18.3 MB`: average/95 %/maximum, count).

Reading the lines: "Open in a field" is made of the choice of the keyboard, the settings and the rest; "Until it appears" adds the layout
and the first frame. A touch that waits long ("Touch wait") usually means the main thread was busy with a long open, a long suggestion
or a long key before it. The average and the 95 % are of the last 256 times, so a line can look better after other keys come in;
the maximum and the count are since the reset.

The meter costs two clock readings per piece of work and allocates nothing while the keyboard works.

## Why the questions to the app are counted

Every question to the app (`getTextBeforeCursor`, `getTextAfterCursor`...) blocks the main thread of the keyboard until the app answers,
and how long that takes depends on the app and the phone. The keyboard is judged by what can be counted: how many questions each key
asks, not how long they took on one phone. After a separator (space, punctuation, Enter) the app reports the new cursor and the
keyboard used to ask two questions (the character before the cursor and the one after it); now, when the cursor is exactly where the
keyboard's own separator should have put it, it asks only for the character after. In any other case (another position, a selection,
another key typed in between, no separator typed by us) the full check runs as before. `docs/tools/test_echo_questions.py` counts the
questions on the PC with the real smali.

For each letter typed the keyboard asked two things; both are cut now, with the same counting test (`docs/tools/test_letter_questions.py`):

- "Is the cursor touching a word" (before and after the cursor) was asked for every letter, even in the middle of a word, where the
  answer changes nothing (the code it guards also needs "no word being predicted"). It is now asked only when no word is being
  predicted, that is, for the first letter of a word. This does not depend on the app.
- The capital letter question (`getCursorCapsMode`, after each letter) is skipped while the keyboard knows the character before
  the cursor is the letter it has just typed (a letter, no Ctrl/Alt/Meta; the note lasts only while that key is handled) and the
  field does not ask for all capitals. In the middle of a word the answer of a normal editor is 0 (`TextUtils.getCapsMode`);
  fields that ask for all capitals, digits, symbols, gestures and every other case ask as before. One edge: a field that refuses the
  letter (full to its maximum length) would show the shift state of a typed letter on the next key.
- Typing "hello" in an empty field with the capital at the start of a sentence, on a simulated app: 4+2+2+2+2 = 12 questions in the
  previous build, 3+0+0+0+0 = 3 now (the first letter still asks, as it decides whether the word starts a sentence).

Tests: `docs/tools/perf_test/PerfTest.java` (the Java, in `run_java_tests.sh`), `docs/tools/test_perf_meter.py` (the smali in the
mini Dalvik interpreter and every call in the keyboard, in `mr-checks.yml`), `docs/tools/test_open_selection.py` (the selection when
a field opens, without a copy of its text) and `docs/tools/test_popup_cache.py` (the popups of variants kept between field opens) and `docs/tools/test_echo_questions.py` (the questions to
the app after a separator the keyboard typed, counted).
