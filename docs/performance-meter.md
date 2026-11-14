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
| Selection echo: one question for both sides (Android 12+) | inside "Selection change", in the same echo of our own separator: ONE `getSurroundingText` answered both "is a word character after the cursor" and the text before the cursor that the next-word prediction reads. Counted only when the app answered it. On Android 11 or older, in an app that does not answer it (asked once per field, then not again) and with a selection, this line stays empty and the echo asks as before | `MrSurround.echo` |
| Delayed echo reaction: wait until it ran / dropped before it ran | the reaction to the echo of our own separator can wait 100 ms for the app to be idle (switch "Delay the reaction to the echo" on the Advanced screen, on by default; stage 6 part 7). **Wait until it ran**: how long the reaction waited before it ran (the count is how many ran). **Dropped**: how long it had waited when a key, a new report of the selection or the end of the field ended the wait (the count is how many were not needed). With the switch off both lines stay empty | `LatinIME.mrEchoRun` / `LatinIME.mrEchoCancel` |
| Delayed capital-letter check: wait until the message ran it / until a key asked it at once | the check of the shift state at the end of a separator (the question to the app "does the next letter start a sentence?") can wait 100 ms for the app to be idle (switch "Delay the capital-letter check" on the Advanced screen, on by default). The first line is how long it waited when its message ran it, the second how long when a key, a text or a suggestion asked it at once before the message. A check that the end of a field dropped, or that another update of the shift state replaced, is counted in neither | `LatinIME.mrShiftRun` / `mrShiftFlush` |
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

### Questions per key (counted on a phone, build before stage 6 part 5)

The 11-block test with the meter (typing in several ways in two apps, with Autocompletar off and on, a suggestion tapped, an autocorrect and
its revert) gave counts that were the same in every app and with Autocompletar on or off, so
they are the keyboard's, not the app's:

| Key | Asked inside the key | Asked in the echo of the cursor | Asked in the suggestions |
|-----|----------------------|----------------------------------|--------------------------|
| first letter of a word | 2 | 0 | 1 |
| other letters | 0 | 0 | **1 per letter** (the word before the one being typed) |
| space, punctuation, Enter | 3 | 2 | 0 |
| second space of a double space | 4 | 2 | 0 |
| delete | 0 | 0 | 1 |
| a suggestion tapped | 3 (at other times) | 3 (full check) | 0 |

A word of 4 letters and a space therefore cost 5 questions inside keys (2 + 3), 2 in the echo and 4 in the suggestions: the suggestions were
37 % of all the waits (82 of 223 in the block that typed "casa " twenty times). The echo was about half of the time spent waiting (the
first reading of this paragraph said "about 7 ms an answer": it was the average of two very different answers, see the next section).

Two cuts (stage 6 part 5), both with the same answers as before and counted by tests:

- **The word before the one being typed** (`MrPrevWord`, asked by `showSuggestions` for the bigram context) used to be asked of the app on
  every run, that is, once per letter. The text that is before a word cannot change while letters are added to it, so it is asked once
  per word, when the text before the cursor ends with the word being typed (the app confirms where the word is), and for the next letters
  of the same word the answer is worked out from what was kept, with the rule of `EditingUtil.getPreviousWord` on the same 15 characters
  (a long previous word is cut exactly as before). Everything that starts, ends or reopens a word forgets it (every write of
  `mPredicting`, `WordComposer.reset`, backspace, a separator, a text written by the keyboard, a new field, the end of the input);
  with any doubt the app is asked as before. `docs/tools/prevword_test/PrevWordTest.java` compares the answer with the original's for
  every letter of 4,000 random words and counts the questions; `docs/tools/test_prev_word.py` checks the places that forget it.
- **The echo of our own separator on Android 12+** (`MrSurround`) asked two questions: the character after the cursor (is it touching a
  word?) and, a moment later in the same reaction, the 96 characters before the cursor (next-word prediction, `MrPredict.list`).
  `getSurroundingText(96, 1)` gives both, so it is asked once, the character after the cursor decides the first question and the text
  before the cursor is handed to the second, once, inside that one reaction. It is used only on Android 12 or later, only when the
  app answers with a text, and never with a selection; otherwise the old two questions run. The class that needs API 31 is a nested
  class, so Android 8 to 11 never load it. An app that answers `null` is not asked again in that field.

Expected on the same block ("casa " twenty times, Android 12+, an app that answers `getSurroundingText`): inside keys 100 (same), in
the selection change 20 (was 40), in the suggestions about 22 (was 82): 142 questions instead of 223.

Measured on the phone with build _73 (same block; the counts matched the expected ones): inside keys 100, selection change 20,
suggestions 22 (21 in Telegram), 142 in all. What it did to the time:

- the suggestions (cut A) are the real gain: the waits in them went from about 131 ms to about 31 ms per 20 words in one app and from about
  227 ms to about 59 ms in Telegram, and the total time waiting for the app went down by 21 to 24 %;
- the echo (cut B) went from two questions to one but the time hardly moved (about 12 ms per 20 words in one app, about 42 ms in
  Telegram). The reason is in the numbers of one answer: the **first** question after the app has changed its text takes about 13.5 ms
  (13.6 ms before cut B, 13.4 ms after: the app's main thread is still busy with the change), and a **second** question right after takes
  about 0.4 ms. Taking the second one away saves almost nothing; what costs is the first one.

### Stage 6 part 6 (build _74): what is left inside a separator

Inside a space or a punctuation mark the keyboard asked three questions: the caps mode of the cursor after it, `doubleSpace` (the three
characters before the cursor, to turn two spaces into ". ") and, once per word learned, the word before the committed one for the user
bigrams (`checkAddToDictionary`, `EditingUtil.getPreviousWord`). Two of them have an answer the keyboard already has when the key commits a
word:

- **`doubleSpace`** looks for a space before the space just sent. When the same key committed a word (typed as it is, or the suggestion
  picked), the character before the space is the last one of that word. `MrPrevWord.endsPlain` says it is not white space, so
  `doubleSpace` is not called and the app is not asked. With no word being typed (the second space of two), an empty word, or a picked
  suggestion that ends with a space, it asks as before.
- **The word before the committed one** is the same text `showSuggestions` already read for the same word, and `MrPrevWord` still has it
  at the start of the separator. The separator now **holds** it for that one key (`MrPrevWord.hold`, before it forgets the word as it
  always did), the learning works the answer out from it (`previousForLearning`: the 15 characters of the window, filled by the text kept
  plus the word that was really committed, whatever its length, so an autocorrection or a suggestion in capitals gives the same answer
  the app would) and the key **releases** it before it returns. When the text kept does not fill the window and is not all there is, when
  the word was never kept (the strip was off) and in every other key (a suggestion tapped, a pick in the middle of the text), the app is
  asked as before.

What stays in memory, and when it goes: one window of at most 15 characters of the text before the word being typed (plus the same, held,
for the length of one separator key), overwritten by the next word, never written to disk, never a list. Since this build forgetting
drops the text as well as the flag (before, only the flag went down and the characters stayed until the next word overwrote them), and the
end of the input, the window hidden, the input view finishing and the service being destroyed drop everything (`MrPrevWord.reset`). A
password field never starts a word, so nothing is kept there.

Expected on the block that typed "casa " twenty times: inside keys 60 (was 100: first letter 2 + separator 1), selection change 20,
suggestions 22: 102 questions instead of 142 (223 before stage 6 part 5). The time gain is small by design: the question that costs is the
first one after the app's change, and the caps mode, still asked inside the key, is now that first one. What would cut time, not only
count, is not asking at that moment at all; that is a different kind of change (see docs/plan-performance.md).

Tests: `PrevWordTest.java` section C (6,000 random texts against the original rule, no question when the 15 characters are known, memory
after fifty words, reset), `docs/tools/test_prev_word.py` (the real smali of `handleSeparator` and `checkAddToDictionary` in the mini Dalvik:
`doubleSpace` called or not in each case, hold and release, the arguments of `previousForLearning`; every place that forgets).

### Stage 6 part 7 (build _75): the reaction to the echo waits for the app

What is left in the echo of our own separator is one question to the app (the character after the cursor, and on Android 12+ the text before
it too). Its price is not in the count: the first question after the app changed its text takes about 13 ms because the app's main thread is
still busy with that change, and a second one takes about 0.4 ms. So the question was moved in time, not removed: the reaction (the question
and what follows it, `mrEchoReact`) no longer runs inside `onUpdateSelection`. It is sent as message 5 of the keyboard's handler with the
same delay the suggestions use (100 ms: `postUpdateSuggestions`, no number of this project) and runs when it arrives (`mrEchoRun`).

- **It waits** only when the switch is on (Advanced screen, "Delay the reaction to the echo", on by default, read when a field opens),
  nothing is being corrected (`TextEntryState.isCorrecting`: a correction in progress is ended at once, as before) and the handler exists.
  Every other case runs at once, as before, so with the switch off the keyboard is the one of build _74.
- **It is cancelled** (`mrEchoCancel`: the message is removed and the echo mark is cleared, the meter counts a drop) by any key
  (`handleSeparator`, and `mrSepClear` from `handleBackspace`, `handleCharacter` and `onText`), by a new report of the selection (before
  it is looked at) and by the end of the field, the window hidden, the end of the input view, the start of a new field and the service being
  destroyed (next to each `MrPrevWord.reset`). Nothing is kept for later: what the next key or report brings replaces it.
- **When it runs** it looks again at what must still be true (not typing a word, no separator just reverted, prediction on) and then does
  exactly what `onUpdateSelection` did, so the answers do not change; only when the question is asked. The text kept for the next-word
  prediction (`MrSurround`) lives only inside the reaction and is dropped when it ends.

**This is not a cut by certainty.** It asks the same question later and drops it when a key supersedes it. What changes on the screen:
the next-word suggestions after a space or a punctuation mark appear about 100 ms later (and not at all when the next key comes before that,
because the next key replaces them). A tap on the strip inside those 100 ms works on what was there. That is why the switch exists.

**The gain is a hypothesis, to be measured on the phone.** The idea: after 100 ms the app is idle, so the one question that is left costs
about 0.4 ms instead of about 12 ms. By count nothing is saved at a normal typing speed (the question is still asked once per separator
when the user pauses); a fast typist saves the question when the next key comes inside the 100 ms. The meter decides, with the switch on and
off, on the same block of typing:

- "Selection echo: one question" (average and 95 %): expected to fall a lot when the app is idle after 100 ms; if it stays near 12 ms the
  hypothesis is wrong;
- "Wait for the app: in a message": the question moved here (it is asked inside the handler's message), the total waiting for the app
  should go down, not only move;
- "Delayed echo reaction: wait until it ran": about 100 ms plus whatever the main thread was doing; and "dropped before it ran": how many
  waits a key made unnecessary;
- the next-word suggestions must still appear after a space, a double space must still become a period and the screen "What the keyboard
  learned" must still work.

If there is no gain, the switch goes off by default (or the change is reverted); nothing else depends on it.

Measured on the phone with build _75 (block S in Telegram, 20 words, switch off against on):

| Autocompletar | Echo, one question (average) | Wait for the app in all (average x count) |
|---------------|------------------------------|-------------------------------------------|
| off | 13.2 -> 3.4 ms | about 475 -> 253 ms (-47 %) |
| on | 12.6 -> 2.8 ms | about 455 -> 242 ms (-47 %) |

The counts did not change (101 in all), the reaction ran after 100.4 ms on average and none was dropped. The 95 % of the echo line stays
at about 15 ms: some reactions still find the app busy after 100 ms. "Touch wait" is about 1 ms higher with the switch on (can be noise;
to watch). The switch stays on by default.

Tests: `docs/tools/test_echo_questions.py` (the real smali in the mini Dalvik with a fake handler: switch on asks nothing and sends one
message, the message asks one question and gives the same suggestions as before for every neighbourhood and in the three modes of Android
12+; every key, report and end of field cancels; correction in progress, no handler, a word being typed, redirected input and the switch off
run as before; what is looked at again when it arrives; fast and slow typing; the shape of every place that cancels, `loadSettings`, the
handler's case 5, the switch on the Advanced screen and its texts in three languages), `PerfTest.java` and `docs/tools/test_perf_meter.py`
(the two new lines), `docs/tools/check_reset_keys.py` (the switch is in "Restore defaults").

### Stage 6 part 8 (build _76): the capital-letter check after a separator waits for the app

Every separator ends with the update of the shift state (`handleSeparator` -> `updateShiftKeyState`), and that asks the app for the caps
mode of the cursor: does the next letter start a sentence? The app has just been given the separator, so this is the first question after
a change of its text (the slow one, about 13 ms against about 0.4 ms for a second). On build _75 the space key kept a tail (95 % at
12.7-18.2 ms) that is most likely this question. As with the echo (part 7) it is moved in time, not removed: the check is sent as message 6
of the keyboard's handler with the delay of the suggestions (100 ms) and runs when it arrives (`mrShiftRun`).

- **It waits** only when the switch is on (Advanced screen, "Delay the capital-letter check", on by default, read when a field opens) and
  the handler exists. The switch off, or no handler, asks at the end of the separator as before (the keyboard of build _75).
- **It is asked at once** (`mrShiftFlush`: the flag goes down, the message is removed, the check runs, the meter counts a flush) by
  everything that could read the shift state before the message: every key (first thing in `onKey`, after the meter of the key starts),
  `onText` and `pickSuggestionManually` (a suggestion, or the word of a gesture, is written with the shift state of the text before it).
  So the key after a separator sees the shift state it would have seen with the switch off, at any speed of typing.
- **It is replaced** by any other update of the shift state (`mrShiftCancel` is the first thing in `updateShiftKeyState`: the update made now
  says what the one that waits would say) and **dropped without asking** by the end of the field, the window hidden, the end of the input
  view, the start of a new field and the service being destroyed (next to each `MrPrevWord.reset`).
- **The other updates stay inline**: after a letter, a double space, a swap of punctuation and space, a mode change, the open of a field.
  Only the one at the end of `handleSeparator` waits.

**It is not a cut by count.** The same question is asked once, later; a fast typist's next key asks it inside its own time (the same
number of questions as before, in the key instead of in the separator). Only when the user pauses (the app idle after 100 ms) is it asked
outside the keys, cheaper. What changes on the screen: with a pause longer than 100 ms the shift key (the capital state of the keys)
is updated about 100 ms after the space instead of at once; a letter typed before that gets the right state all the same.

**The gain is an estimate, to be measured on the phone**: about 12 ms less in the space key when the app is idle after 100 ms, and about
50 ms per 20 words of the waiting inside keys. The meter decides, in the same block of typing (20 words in Telegram, Autocompletar off and
on, the new switch off against on; the echo switch stays on):

- "Key: space, punctuation, Enter" (average and 95 %): expected to fall, mostly the 95 %;
- "Wait for the app: inside a key": expected to fall by about one question per separator at a pause, and to stay the same at a fast pace;
  "Wait for the app: in a message": takes the question;
- the new lines "Delayed capital-letter check": how many ran by the message (a pause) and how many a key asked at once (a fast pace), and
  how long the checks waited;
- the capital after ". ", "! " and Enter, at a fast pace and at a slow one, must be right.

**The meter only shows it with Auto-capitalization on** (Settings -> Typing; on by default since build _77, it was off before). With it off
the update of the shift state asks the app nothing, so there is no question to move. Since build _77 the switch does nothing then: with
Auto-capitalization off `mrShiftPost` runs the update at once (nothing to defer, no message is sent) and the counts and the keyboard
messages are those of the switch off (`test_caps_defer.py`).

Measured on the phone with build _76 (block S in Telegram, 20 words, Auto-capitalization on, new switch off against on):

| Autocompletar | Space key, average (95 %) | Inside a key (count x average) | In a message | Wait for the app in all |
|---------------|---------------------------|--------------------------------|--------------|-------------------------|
| off | 23.5 (46.2) -> 11.9 (25.1) ms | 120 x 5.2 -> 100 x 2.8 ms | 20 -> 40 | about 761 -> 502 ms (-34 %) |
| on | 23.8 (43.6) -> 11.1 (18.9) ms | 120 x 4.5 -> 100 x 3.3 ms | 20 -> 40 | about 680 -> 535 ms (-21 %) |

The total count did not change (162), the 20 checks ran by the message after about 100.1-100.4 ms and none was asked early by a key
("asked early" line not shown). "Handle a key" went from 6.6 to 3.3 and from 6.0 to 3.9 ms on average. Each question costs about
10-17 ms inside the key and about 3.6-4 ms in the message. The two runs with the switch off differ by 11 % in the total, the space key
does not, so the gain of the space key is far outside the noise. The switch stays on by default.

After a word picked on the strip or written by a gesture (build _77) the app is not asked for the caps mode at all when the word ends in a
letter (`LatinIME.mMrPick`): before the cursor is that letter or the automatic space after it, and the app answers 0 there unless the field
asks for a capital on every word or for all capitals. That removes the two questions of every picked word (the one of `pickSuggestion` and
the one of `sendSpace`, both inside `pickSuggestionManually`); `docs/tools/test_pick_caps.py` counts them with the real smali.

Tests: `docs/tools/test_caps_defer.py` (the real smali in the mini Dalvik with a fake handler and a fake app that answers like
`TextUtils.getCapsMode`: the switch off asks at the end of the separator; on asks nothing and sends message 6 with 100 ms; the message
asks one question; the next key asks at once and removes the message; another update replaces it; the end of the field drops it; no
handler asks at once; 400 random sentences in three timings give the same shift state at every key, the same text and the same number of
questions as with the switch off; the shape of every place that flushes or cancels, `mrShiftPost`, `loadSettings`, the handler's case 6,
the switch on the Advanced screen and its texts in three languages), `PerfTest.java` and `docs/tools/test_perf_meter.py` (the two new
lines), `docs/tools/check_reset_keys.py` (the switch is in "Restore defaults").

Tests: `docs/tools/perf_test/PerfTest.java` (the Java, in `run_java_tests.sh`), `docs/tools/test_perf_meter.py` (the smali in the
mini Dalvik interpreter and every call in the keyboard, in `mr-checks.yml`), `docs/tools/test_open_selection.py` (the selection when
a field opens, without a copy of its text) and `docs/tools/test_popup_cache.py` (the popups of variants kept between field opens) and `docs/tools/test_echo_questions.py` (the questions to
the app after a separator the keyboard typed, counted, with and without the one question of Android 12+), `docs/tools/prevword_test/PrevWordTest.java` and
`docs/tools/test_prev_word.py` (the word before the one being typed asked once per word; one question after our own separator).
