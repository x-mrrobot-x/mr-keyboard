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
| Draw a frame | one frame of the keyboard or of a popup of variants; on a GPU window it is the time to record the drawing, not the GPU's | `LatinKeyboardBaseView.onDraw` |
| Handle a key | all the work of a key, the waits for the app included | `LatinIME.onKey` |
| Key: letter or digit / space, punctuation, Enter / delete / shift, symbols, modes | the same time of "Handle a key", split by the primary code of the key: letters and digits; any other positive code (space, Enter, punctuation); delete (-5); the other negative codes and 0. A key is in "Handle a key" and in one of the four | `LatinIME.onKey` |
| Touch wait | how late a finger down (first or another) reached the keyboard: the clock against the time of the event. A busy main thread shows here | `LatinKeyboardView.onTouchEvent` |
| Wait for the app | every question that waits for the app's answer: the text before and after the cursor (the previous word, the word under the cursor, the old word on open), the selected text, the caps mode, and the whole text of a field that does not report its selection | `getTextBeforeCursor`, `getTextAfterCursor`, `getSelectedText`, `getCursorCapsMode`, `getExtractedText` in `LatinIME` and `EditingUtil` (the Java layer, e.g. `MrPredict`, is not in it yet) |
| Suggestions | the suggestions of the strip computed | `LatinIME.updateSuggestions` |
| Suggestions: the engine | the call to the suggestion engine, wherever it comes from (typing a word, a space) | `Suggest.getSuggestions` |
| Suggestions: show the strip | the strip filled and drawn | `LatinIME.setSuggestions` |
| Open: choose the keyboard for the field | inside "Open in a field": the keyboards made if needed, the field type read and the keyboard put on the view | `onStartInputView`, from `makeKeyboards` to the `closing()` of the view |
| Open: read the settings | inside "Open in a field": `loadSettings` | `onStartInputView` |
| Open the long-press popup | the popup of variants of a key built and shown | `LatinKeyboardBaseView.onLongPress` |

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

Tests: `docs/tools/perf_test/PerfTest.java` (the Java, in `run_java_tests.sh`), `docs/tools/test_perf_meter.py` (the smali in the
mini Dalvik interpreter and every call in the keyboard, in `mr-checks.yml`) and `docs/tools/test_open_selection.py` (the selection when
a field opens, without a copy of its text).
