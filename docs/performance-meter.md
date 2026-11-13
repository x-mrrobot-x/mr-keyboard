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
| Touch wait | how late a finger down (first or another) reached the keyboard: the clock against the time of the event. A busy main thread shows here | `LatinKeyboardView.onTouchEvent` |
| Wait for the app | the questions that wait for the app's answer: the caps mode of the cursor and the text of a field when it opens | `getCursorCapsMode`, `getExtractedText` |
| Suggestions | the suggestions of the strip computed | `LatinIME.updateSuggestions` |

Then the memory of the process when the screen opens: Java heap in use and native heap (the screens share the process with the
keyboard, so their own memory is in it too).

## How to read it

1. Tap the row: everything starts again from zero.
2. Use the keyboard as usual for a few minutes: a long field (note, e-mail) and a chat, a theme you use.
3. Come back to the row. The numbers are kept while the process lives; when Android ends the process they are gone ("Nothing
   measured yet").

When the keyboard hides after keys were typed, one line goes to the log: `adb logcat -s MrPerf`
(`frame 4.2/6.0/14.1 ms (420) key ... heap 24.1 MB native 18.3 MB`: average/95 %/maximum, count).

The meter costs two clock readings per piece of work and allocates nothing while the keyboard works.

Tests: `docs/tools/perf_test/PerfTest.java` (the Java, in `run_java_tests.sh`) and `docs/tools/test_perf_meter.py` (the smali in the
mini Dalvik interpreter and every call in the keyboard, in `mr-checks.yml`).
