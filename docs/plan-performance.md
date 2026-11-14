# Performance plan (in progress)

Live plan of the performance round started after v1.98.0. One stage = one zip and one commit; the version of the release does
not change. When the round is over this file is deleted (the history stays in Git), like docs/plan-suggestions.md was.

Everything below was found by reading the code (smali, the Java layer, the manifest); the environment has no device. Costs
are estimates, marked as such. Stage 2 (the meter on the Advanced screen) gives the numbers of the phone.

Read on the owner's phone (2026-11-13, Advanced screen): the keyboard window is drawn by the GPU, and so is the Advanced screen
although the app does not ask for it: the system (or the ROM) turns the acceleration on by itself. The first finding below was
written before that reading and is kept corrected.

**The app is for other people's phones, so no decision rests on the owner's numbers alone.** What the phone does (GPU or CPU
drawing, how fast an app answers a question) varies from device to device. So: (1) a cut is made where it can be COUNTED (questions
to the app per key, windows shown, work on the main thread), and the tests count it on the PC; (2) a cut is made only when the
keyboard is certain of the answer, and anything doubtful falls back to asking as before; (3) no threshold is tuned to one phone;
(4) the manifest flag `hardwareAccelerated="false"` is not flipped and acceleration is not forced; (5) what depends on the way the
window is drawn is decided at run time, by the mode the phone reports (`MrAccel.state`), and the meter's frame line says which mode
it measured.

## 1. Findings

### Drawing the keyboard

- **Whether the keyboard window is drawn by the GPU depends on the phone.** The manifest has `hardwareAccelerated="false"` for
  the app. A window with no parent (the keyboard window is one) takes its acceleration from the app flag
  (`WindowManagerGlobal.addView`), and `InputMethodService` does not ask for it (`enableHardwareAcceleration()` only returns
  whether the device is high end since Android 5). Some systems turn it on anyway: the owner's phone does, for every window of
  the app. Where the system does not, the keyboard, the suggestion strip and the panels are drawn by the processor and the
  background blur of the translucent themes (`MrTranslucentBlur`) does not run. The "Keyboard drawing" row of the Advanced
  screen (`MrAccel`) tells which case a phone is.
- **The first keyboard view of each process had a software layer** (fixed in stage 1). `GlobalKeyboardSettings.renderMode` was
  always 1 (`LAYER_TYPE_SOFTWARE`; the setting that changed it is gone) and `LatinKeyboardBaseView.setRenderModeIfPossible` only
  applies it when it differs from a STATIC "previous mode" that starts at -1: the first view made in a process got the layer,
  every later one (after a theme change, a rotation, the popups of variants) did not. With a software layer any invalidation
  throws the whole layer away: each key press and each release redrew ALL keys (shadows and glows included) on the processor
  into a bitmap the size of the keyboard, and on a GPU window that bitmap was then sent whole to the GPU again. The same
  keyboard was fast or slow depending on whether its view was the first of the process.
- **On a GPU window every key press records every key again.** Since Android 5 the area passed to `invalidate(rect)` is ignored
  by the GPU pipeline: the view's `onDraw` runs with the whole view as its clip, so `onBufferDraw` records all keys (faces,
  labels, text shadows, icon shadows) for one pressed key, and the GPU draws all of them. Recording is far cheaper than drawing
  on the processor, but it grows with the theme (neon: two drawings with a shadow per label). The meter says how long a frame
  takes on the phone ("Draw a frame"); stage 3 acts on it.
- **Icon shadows were blurred again on every frame** (fixed in stage 1). `ShadowDrawHelper.draw` (dark outline of the icons on
  dark themes, the light of the icons on neon themes) created a bitmap of the key, drew the icon, blurred it with a
  `BlurMaskFilter` (`extractAlpha`), drew the result and recycled both bitmaps: two allocations and one blur per icon key per
  frame, and on a GPU window each new bitmap is a new texture sent to the GPU. Recycling a bitmap right after drawing it is also
  unsafe on a GPU window (the frame is drawn later, on the render thread).
- Small, per frame (`onBufferDraw`): two lists with every key's width and height are filled (boxed) and sorted to find the
  median size, and two `PorterDuffColorFilter` are created when the theme recolours symbols. Cheap next to the rasterizing,
  but it is garbage on every frame.
- `onMeasure`, `closing` and `LatinIME.onSharedPreferenceChanged` write a log line each time they run.

### Opening the keyboard (each field)

- `checkReCorrectionOnStart` (re-correction is on by default) asks the app for the whole text of the field
  (`getExtractedText` with no size limit), synchronously, every time the keyboard opens, only to know the selection, which
  `EditorInfo.initialSelStart/End` already gives. In a long note or e-mail that is a large copy across processes before the
  keyboard can answer.
- `LatinKeyboardView.closing()` runs in every `onStartInputView` and empties the caches of the popups of variants (three) and the
  label metrics cache. `setKeyboard` empties the popup caches again, even when the keyboard is the same object. Result: in every
  new field the first long press of each key builds a mini keyboard and inflates a new keyboard view (a long constructor) before
  the popup appears; the accents of Portuguese live on long presses.
- `setKeyboard` asks for a new layout of the window and recomputes the proximity threshold on every open, even for the same
  keyboard.

### Typing

- With auto-capitalization on, every letter makes a synchronous call to the app (`getCursorCapsMode`, from
  `updateShiftKeyState`), plus the one after `onUpdateSelection`. In the middle of a word the answer is known (no capital), except
  in fields that ask for all capitals. A synchronous call waits for the app's main thread: in a busy app (browser, chat with
  media) that is where typing lag comes from.
- With key sounds on, each click asks the audio service for the volume twice (`getStreamMaxVolume`, `getStreamVolume`).
- Suggestions: debounced (100 ms) and computed by the native engine on the main thread; nothing to change before the phone
  numbers say otherwise.

### Creating the input view and the tools

- `MrTools.wrap` inflates the whole tool bar (`mr_toolbar.xml`, about 120 views: every panel, clipboard, translation,
  screenshots, emojis, fonts, emoji search, tune) and sets every panel up each time the input view is created: the first open
  after the process starts, a theme change, the app language, a rotation, the radius of the keys. Panels never opened in the
  session are built anyway. The emoji list itself recycles its rows correctly.

### Cold start (new process: after a reboot, an update, or when Android kills the keyboard)

- `ComposeSequence` fills its table (883 entries, each formatted) in a static initializer that runs when `LatinIME` is
  constructed, before the first key; it is only used by the compose key and dead keys.
- `PluginManager.getPluginDictionaries` asks the package manager twice for dictionary apps (Hacker's Keyboard and
  AnySoftKeyboard plugins) in `onCreate`, although the packs are the normal source now.
- `initSuggest` and `KeyboardSwitcher.getKeyboard` (on a cache miss) change the locale of the service's own `Resources` with
  `updateConfiguration` and change it back: each call throws away the resource caches of the service (drawables, strings).

### Closing

- `onFinishInput` flushes the learning databases in the background; `onFinishInputView` cancels the pending messages. Nothing
  heavy. `resetSheetToAbc` runs four times in an open/close cycle but does nothing when the sheet is already ABC.

### Memory and cleanup (the keyboard leaves everything to the garbage collector)

- Nothing in the app answers `onTrimMemory` or `onLowMemory`: when Android asks the keyboard to give memory back, it gives
  nothing, and becomes a better candidate to be killed (and then pays a cold start on the next open).
- The only `Bitmap.recycle` of the app is the temporary bitmap of `ShadowDrawHelper`. The space bar draws a new bitmap (and a new
  `BitmapDrawable`) every time its label changes and leaves the old one to the collector; the kept shadows of stage 1 are dropped
  the same way when their place is taken.
- The caches only shrink when the collector wants: the keyboards of `KeyboardSwitcher` are `SoftReference`s, the popups of
  variants `WeakHashMap`s keyed by keys that live as long as their keyboard.
- `onDestroy` closes the user dictionary but not the native engine (`Suggest`), the auto dictionary nor the bigram database.
- Rule for any explicit release of a bitmap: never during a draw, and only when no frame can still use it (the window hidden, or
  the view that drew it replaced), followed by an invalidation; with an accelerated window a frame is drawn later by the render
  thread, so "after the next frame" is not enough.

### Settings screens

- They do not slow typing: they run in the keyboard's process, but on their own windows, while the keyboard is hidden, and the
  heavy ones (import, packs, learned words, update) already work on background threads.
- A change of theme, layout or app language rebuilds the keyboard view at once, while the user is still in the screen; it is
  wasted work when several themes are tried in a row, but it also leaves the next open ready, so it stays.
- The app does not ask the GPU for the screens by default (`pref_ui_hw_accel`, Advanced, off); only the three screens that draw on
  their own ask for it in the manifest. Some systems give it anyway (the owner's phone does).
- Writes made by the keyboard while typing (recent emojis, clipboard, tool bar state) go through `apply()` and the listeners
  ignore the keys they do not care about.

## 2. Stages

| # | Stage | What changes | Risk |
|---|-------|--------------|------|
| 1 | Drawing in the current mode | no software layer on the keyboard view (every view the same); icon shadows blurred once and kept | low |
| 2 | Performance meter | Advanced screen ("Performance"), `MrPerf` log: start and build of the keyboard, open in a field, until it appears, time per frame, per key, touch wait, waits for the app, suggestions (average, 95 %, maximum, count); Java and native memory. A tap resets | low |
| 3 | Draw only what changed | **conditional on the mode of the window at run time** (GPU or CPU; the frame line of the meter says which) and decided by the meter ("Draw a frame"): on a GPU window (Android 10+) each key recorded in its own `RenderNode`, so a press records one key and the GPU reuses the others; acceleration asked for the keyboard window where the system does not turn it on by itself, with a switch in Advanced to turn it off; check every theme, gestures, popups, the AI Editor dialog | medium |
| 4 | Cleanup by the keyboard itself | `onTrimMemory`/`onLowMemory`: by level, drop the keyboards not in use, the popups of variants, the kept shadows, the label metrics, the screenshot thumbnails, the emoji search index and the panels that are closed; release (recycle) the bitmaps of the space bar and of the shadows at the safe moments (window hidden, view replaced, theme change); `onDestroy` closes the engine and the databases and stops the threads; the meter shows the effect | medium |
| 5 | Opening in each field | re-correction from `initialSelStart/End` (no full text); popups of variants and label metrics kept while the keyboard is the same; `setKeyboard` with the same keyboard does less | low-medium |
| 6 | Typing | no `getCursorCapsMode` in the middle of a word (except all-caps fields); click volume kept and refreshed on change; the small per-frame garbage of `onBufferDraw`; the log lines | low |
| 7 | Cold start | compose tables built on first use; plugin dictionaries only looked up when a language has no pack; locale resources through a configuration context instead of `updateConfiguration` | medium |
| 8 | Tool bar and panels | panels inflated the first time they open, only if stage 2 shows the creation of the input view is slow on the phone | medium-high |
| 9 | Settings screens | hardware acceleration on by default for the screens once stage 3 is confirmed (the owner's phone already draws them with the GPU); nothing else needed for typing | low |

Stage 4 comes after stage 3 on purpose: when a bitmap may be recycled depends on whether the window is accelerated. Stage 5
keeps more in its caches, so it relies on stage 4 to give that memory back when Android asks.

Each stage keeps the tests green (`smali_regcheck`, the mini Dalvik tests, the Java tests) and adds its own. What can only be
seen on a phone (smoothness, look of each theme) is listed in the reply of the stage.

## 3. Status

- Stage 1: done (render mode 0; `ShadowDrawHelper` keeps 24 blurred shadows; `docs/tools/test_shadow_cache.py`).
- Stage 2: done (`MrPerf`, row "Keyboard times" of the Advanced screen, docs/performance-meter.md; `docs/tools/perf_test/PerfTest.java`,
  `docs/tools/test_perf_meter.py`). The smali of `MrPerf` is the one generated by the mr-smali workflow.
  First numbers on the owner's phone (about 1,200 keys, 15 opens in several apps): "Draw a frame" 2.7 ms on average, 5.6 at 95 %
  (a frame is 16.7 ms at 60 Hz): drawing is not the cost on that phone, so stage 3 goes last and only if another phone shows
  otherwise (or the on-screen GPU profile does). The costs seen are in the opening (32.6 ms on average, 89 at 95 %, 133 ms until the
  first frame, 7.7 ms of it waiting for the app), the tail of "Handle a key" (95 % at 21 ms in a chat, maximum 107 ms), the
  suggestions (maximum 307 ms) and the "Touch wait" (95 % at 47 ms, maximum 221 ms, probably touches that arrived while the main
  thread was busy with one of those). Memory: Java 11.5 MB, native 54.0 MB, not growing.
- Stage 5: done, with one thing left to confirm on the phone. `checkReCorrectionOnStart` takes the selection from
  `EditorInfo.initialSelStart/End` and no longer asks the app for the whole text of the field at every open (the old question stays
  only for a field that reports -1); `docs/tools/test_open_selection.py`. A cursor at the very start (0/0, most often an empty field)
  offers no old-word suggestions on open (before: only if the field had text and a word right after the cursor). The popups of
  variants are kept between opens: `closing()` and `setKeyboard()` clear the three maps only for a different keyboard or after a
  change of any preference (`LatinIME.onSharedPreferenceChanged` bumps a number that each view compares with its own), and the view
  leaving the window clears them; `docs/tools/test_popup_cache.py`. The gain is only the part of a long press that put the variants
  together (the new line "Popup: put the variants together"); showing the popup window is a call to the system and stays. Whether
  that part is large is what the next numbers show (count of the popup line against the count of the build line).
- Stage 6, first part: the meter is finer (keys by kind, the engine and the strip of the suggestions, the keyboard and the settings
  inside an open, the popup of variants, and every question to the app of `LatinIME` and `EditingUtil`), to find what is inside the
  107 ms key and the 307 ms suggestion. The fixes of stage 6 (caps mode in the middle of a word, click volume, garbage per frame, log
  lines) wait for those numbers.
  Second round of numbers (gestures on and off made no difference): letters 1-2 ms, delete 0.4 ms, the engine 1.5 ms, the strip 0.3 ms,
  a frame 2.6-2.8 ms; space, punctuation and Enter 11-14 ms on average (95 % at 35-45 ms, maximum 67 ms); a wait for the app 3.6-4.4 ms
  on average (95 % at 19-20 ms, maximum 124-128 ms), about 2.5 per key; the popup of variants 18-19 ms; open 37-43 ms. The waits
  for the app are the biggest cost of typing.
- Stage 6, second part: the wait for the app is also counted by where it is asked (inside a key, in the suggestions, in an open, elsewhere),
  and the popup of variants by what it spends (the variants put together, the window shown). The next fixes cut the questions to the app
  where the numbers show them: per key, per separator, per selection update. `isCursorTouchingWord` (two questions) with
  `getSurroundingText` on Android 12+ is a candidate.
  Next: the owner reads the new lines (reset, then open several apps, type words and punctuation in a chat and a long field, delete,
  long-press a few keys, open the same kind of field twice).
- Stage 6, third part (this stage): the Java layer's questions to the app are metered too (`MrPredict`, `MrRecorrect`, `MrGestureInput`),
  and so are the reaction to a selection change and the keyboard's own messages (new lines "Selection change", "Message" and their
  waits). The frame line is named by the window mode of the phone ("Draw a frame (GPU)": only the recording; "(CPU)": the whole
  drawing). Third round of numbers on the owner's phone: a separator costs about 17 ms against 1.1 ms for a letter, because of the
  questions to the app; the popup of variants is almost all the window shown (18.4 ms; putting the variants together 1.5 ms).
  After a separator the app reports the new cursor, and `onUpdateSelection` then asked two questions (`isCursorTouchingWord`: before and
  after the cursor) plus the previous word for the suggestions. The cut: `isCursorTouchingWord` asks for the character after the cursor
  only when the one before did not answer, and after the echo of a separator the keyboard typed itself (cursor exactly where expected,
  no selection, no key typed in between) only the character after the cursor is asked; any other case runs the full check
  (`docs/tools/test_echo_questions.py` counts the questions). Not done yet and why: the popup window (a call to the system; to be
  looked into), `getSurroundingText` on Android 12+ (one call for before and after; depends on how apps implement it), stage 3
  (waits for the frame line to show the mode on other phones).
  Next: the owner resets the meter and types words with spaces and punctuation in a chat and a long field; the waits counted in "Wait for the
  app: in a selection change" per separator should be one fewer than before (the previous word for the suggestions is still asked).
- Stage 6, fourth part: the meter says how many selection echoes took the short check ("Selection echo: one question") and how many the
  full one. Reading of the first run of the five-app test (one sentence typed in each): letters 1.9 ms, space/punctuation/Enter 17.6 ms
  (95 % at 45 ms), 986 waits for the app inside 725 keys, 366 waits inside 737 reactions to a selection change (131 separators), a
  single wait of 242.6 ms on opening one app. Cut in this stage, counted by `docs/tools/test_letter_questions.py`: for every letter the
  keyboard asked "is the cursor touching a word" (also in the middle of a word, where the answer changes nothing) and the caps mode.
  Now the first is asked only when no word is being predicted (no assumption about the app) and the second is skipped while the
  character before the cursor is the letter just typed and the field does not ask for all capitals. On a simulated app, a five-letter
  word went from 12 questions to 3. What is left per separator inside the key (guess: about three): the caps mode after the
  separator, `doubleSpace` (the three characters before the cursor, at every space) and `swapPunctuationAndSpace` after a word
  accepted from the strip. Candidates for the next stage: `doubleSpace` and the swap only when the previous key was a separator the
  keyboard typed itself, the popup window (18 ms, a system call), `getSurroundingText` on Android 12+.
  Next: the owner resets the meter and types the same sentence in the same five apps; the count of "Wait for the app: inside a key"
  per key and of "in a selection change" per separator should be lower than in the last run, and the two echo lines say how many
  echoes took the short way.
- Stage 6, fifth part (build _73): the owner ran an 11-block test of the meter on the build above (counts equal in every app and with
  Autocompletar on or off, so they are the keyboard's own; the table is in docs/performance-meter.md, "Questions per key"). It showed
  where the questions are: the first letter of a word 2 inside the key; every other letter 0 inside the key but exactly one in the
  suggestions (the word before the one being typed), which was 37 % of all the waits; a separator 3 inside the key and 2 in the echo of the
  cursor; a suggestion tapped 3 + 3 and no short way; an answer in the echo about 7 ms against 1.3 ms inside a key. Two cuts, both with
  the same answers and counted on the PC:
  A. `MrPrevWord` (the previous word for the suggestions): asked of the app once per word instead of once per letter, worked out for
  the next letters from the text kept and the word, forgotten wherever the word starts, ends or is reopened (`PrevWordTest.java`,
  4,000 random words against the original rule; `test_prev_word.py`).
  B. `MrSurround` (the echo of our own separator): on Android 12+ one `getSurroundingText` answers both "is a word character after the
  cursor" and the 96 characters before it that the next-word prediction reads; older Android, an app that answers null (asked once per
  field), a selection and any exception ask as before (`test_echo_questions.py`, `PrevWordTest.java`). New meter line "Selection echo:
  one question for both sides (Android 12+)".
  Expected on the block that typed "casa " twenty times: suggestions 82 -> about 22, selection change 40 -> 20 (Android 12+, an app
  that answers `getSurroundingText`), inside keys 100 unchanged: 223 -> about 142 questions. Nothing ran on a device in this stage.
  Left, in the order of what the counts say: the three questions inside a separator (the caps mode after it, `doubleSpace` and, per
  word learned, the previous word for the user bigrams in `checkAddToDictionary`, which still asks `EditingUtil.getPreviousWord`),
  the six of a suggestion tapped (extend the short way of the echo to the space added after a pick), the second space of a double space
  (+1 inside, +2 in the echo), the revert of an autocorrect (+4 inside per cycle), the popup window (18 ms, a system call).
  Next: the owner resets the meter and repeats the blocks L and S (and S in Telegram): "Wait for the app: in the suggestions" should be
  about one per word, and "in a selection change" about one per separator, with the new echo line counting them.
- Stage 6, sixth part (build _74): the owner's run of the blocks L, S, S in Telegram, D, T, C1 and C2 on build _73: the counts were the
  expected ones (S: inside keys 100, selection 20, suggestions 22; 142 against 223; L 5 against about 44) and no regression showed. A is a
  real gain in time (the suggestions' waits about 131 -> 31 ms per 20 words; total waiting -21 to -24 %); B cut the count and not the
  time (about 12 ms per 20 words), because the first question after the app's change costs about 13.5 ms and the second about 0.4 ms
  (an earlier line of this plan said "about 7 ms an answer": wrong, an average of the two). So the count is no longer what costs: what
  costs is the first synchronous question after a change of the app's text.
  Cuts of this build, with the same answers and counted on the PC (`PrevWordTest.java` section C, `test_prev_word.py`):
  C. the word before the committed one, for the user bigrams (`checkAddToDictionary`): `MrPrevWord.hold` (start of a separator) /
  `previousForLearning` / `release` (end of the key); the answer is worked out from the text kept, asked of the app when that is not
  certain; `EditingUtil.getPreviousWord` has no caller left.
  D. `doubleSpace` is not called when the key committed a word that ends with a character that is not white space (the character before
  the space about to be sent cannot be a space); `MrPrevWord.endsPlain`.
  Hygiene (asked by the owner, found while checking): `MrPrevWord.clear` drops the text and not only the flag; `MrPrevWord.reset` (end of
  the input, window hidden, input view finished, service destroyed) drops everything.
  Expected on the block "casa " twenty times: inside keys 60 (was 100), 102 questions in all (was 142). Nothing ran on a device in this
  stage. Time: small, the caps mode is now the first question after the change.
  Not done, and why: the caps mode after a separator (the answer can be worked out only by assuming that the app answers like
  `TextUtils.getCapsMode`; the cut of stage 6 for letters already assumes it for the middle of a word, this one would assume it for the
  start of one), the two questions of the first letter (`isCursorTouchingWord`: an answer kept from the echo of the separator would need
  every write of the keyboard to forget it, and a stale answer starts a word in the middle of another; `getSurroundingText(1, 1)` would
  make it one question, count only, and a wrong answer from an app would break typing inside a word), the suggestion tapped (6 questions),
  the second space of a double space, the revert of an autocorrect. The one change that would cut time and not only count is to not ask
  at the moment of the app's change: the check after the echo of a separator posted a few milliseconds later, when the app is idle. It
  changes the order of what happens after a key (a key typed in between has to cancel it) and its gain can only be measured on a
  device; to be decided with the owner before it is made.
  Next: the owner repeats the blocks S and C1/C2: "Wait for the app: inside a key" should be 60 for the 20 words of S (first letter 2
  + separator 1 per word), and the learned screen, a password field, closing and opening the keyboard and switching keyboards must show
  nothing odd (the previous word is dropped at each).
- Stage 6, seventh part (build _75): the owner's run of build _74 measured the echo of our own separator at about 12 ms x 20 (51 to 60 %
  of the waiting for the app in a block of 20 words), the same in both Autocompletar modes: the first question after the app changed its
  text. The decision made with the owner: not to cut it but to ask it later, when the app is idle.
  E. The reaction to the echo of our own separator (`mrEchoReact`: the question to the app and what follows) is sent as message 5 of
  the keyboard's handler with the delay of the suggestions (100 ms) and runs in `mrEchoRun`. Any key, a new report of the selection and
  every end of the field cancel it (`mrEchoCancel`); a correction in progress, a missing handler and the switch off run it at once. The
  switch is on the Advanced screen ("Delay the reaction to the echo", `pref_mr_echo_defer`, on by default, read when a field opens, in
  "Restore defaults"). Two new meter lines: how long a reaction waited before it ran, and how long it had waited when it was dropped.
  Counted on the PC with the real smali (`test_echo_questions.py`, `PerfTest.java`, `test_perf_meter.py`): the same answers as before in
  every neighbourhood and in the three modes of Android 12+; the echo asks nothing until the message arrives; a key before it asks
  nothing at all.
  It is NOT a cut by certainty (the same question is asked later, and dropped when a key replaces it) and its gain is a hypothesis: if the
  app is idle after 100 ms the first question costs about 0.4 ms instead of about 12 ms. By count nothing changes at a normal typing
  speed. What is paid: the next-word suggestions after a separator appear about 100 ms later. Nothing ran on a device in this stage.
  Next: the owner resets the meter and types block S (20 words) in Telegram with the switch ON and OFF, Autocompletar off and on (four
  runs): compare "Selection echo: one question" (average and 95 %), "Wait for the app: in a message" and in a selection change, the
  total waiting for the app, and the two new lines (how many reactions ran and how many a key dropped). Also: the next-word suggestions
  still appear after a space, a double space still becomes a period, the screen "What the keyboard learned" still works, and closing and
  opening the keyboard, switching keyboards, leaving the app and a password field show nothing odd. If the echo line does not fall, the
  switch goes off by default or the change is reverted.
  Measured by the owner on build _75 (block S, "casa " 20 times, in Telegram; Autocompletar off and on, each with the switch off and on).
  The counts are the same in the four runs (101 questions: 60 inside keys, 21 in the suggestions, 20 in the echo) and no reaction was
  dropped by a key (the line is not shown). "Selection echo: one question for both sides" went from 13.2 to 3.4 ms on average
  (Autocompletar off) and from 12.6 to 2.8 ms (on); its 95 % stays at about 15 ms, so some reactions (about 3 of 20, estimated from the
  average) still find the app busy after 100 ms. The wait for the app in all (average times count) went from about 475 to 253 ms and
  from about 455 to 242 ms per 20 words: -47 % in both. "Selection change" went from 2.7 and 2.6 ms to 0.0 ms. The reaction ran after
  100.4 ms on average (maximum 101.2). The next-word suggestions, the double space, the screen "What the keyboard learned" and the
  lifecycle (close and open, switch keyboard, leave the app, password field) checked out. Decision: the switch stays on by default.
  To watch: "Touch wait" is about 1 ms higher with the switch on (3.7 -> 5.2 and 3.3 -> 4.4 ms on average, 95 % about 1 ms higher):
  it can be noise (100 samples, one outlier of about 70 ms in three runs) or the question now falling closer to the next finger down.
  What is left in the same runs: inside keys 60 questions, about 120 ms per 20 words (half of what is left); letters take about 1 ms;
  the space key keeps a tail (average 3.3-5.1 ms, 95 % at 12.7-18.2 ms in three of the four runs), most likely the caps mode asked right
  after the app got the space (the first question after a change of the app's text). Open: reading the smali (and the mini Dalvik
  with a fake app) the first letter of a word asks three things (before, after, caps) and the space one (caps), 4 per word, but the
  phone shows 3 per word; one of them is not asked in Telegram and it is not explained yet.
- Stage 6, eighth part (build _76): what is left after the echo is the question that ends every separator: `handleSeparator` finishes
  with `updateShiftKeyState`, which asks the app for the caps mode of the cursor (does the next letter start a sentence?). It is asked
  right after the app got the space, so it is the first question after a change of the app's text (the slow one, about 13 ms, as the echo
  was). It is the likely cause of the tail of the space key measured on build _75 (95 % at 12.7-18.2 ms). The decision made with the owner:
  ask it later, as with the echo, not remove it.
  F. The update of the shift state at the end of `handleSeparator` is sent as message 6 of the keyboard's handler with the delay of the
  suggestions (100 ms: `mrShiftPost`) and runs in `mrShiftRun`. What the answer decides (the shift key and the capital of the next
  letter) must be the same when anything looks at it, so anything that could look first asks at once (`mrShiftFlush`, which also removes
  the message): every key (first thing in `onKey`, after the meter of the key starts), `onText` and `pickSuggestionManually` (a suggestion
  or the word of a gesture is written with the shift state of the text before it). Any other update of the shift state replaces the one
  that waits (`mrShiftCancel` is the first thing in `updateShiftKeyState`), and the end of the field, the window hidden and the service
  destroyed drop it without asking (next to each `MrPrevWord.reset`). The switch off and a missing handler ask at the end of the separator
  as before. The switch is on the Advanced screen ("Delay the capital-letter check", `pref_mr_caps_defer`, on by default, read when a
  field opens, in "Restore defaults"). Two new meter lines: how long a check waited before the message ran it, and how long it waited
  before a key, text or suggestion asked it at once.
  Counted on the PC with the real smali (`test_caps_defer.py`: 400 random sentences with random timings, in three timings: mixed, idle
  before every key and no pause at all; `PerfTest.java`, `test_perf_meter.py`): every key sees the same shift state as with the switch off,
  the text and the final shift state are the same and the app is asked exactly as many times (the question moves, none is added or lost).
  It is NOT a cut by count: a fast typist's next key asks the same question inside its own time. The gain is an estimate: when the app is
  idle after 100 ms the question costs about 0.4 ms instead of about 12 ms; per 20 words that is about 50 ms of the waiting inside keys and
  the 12-18 ms tail of the space key. What is paid: if some path reads the shift state without going through one of the places above, it
  would see the state of before the space (a wrong capital after ". ", "! " or Enter); the places are covered by tests, but a phone is
  the real check. Nothing ran on a device in this stage.
  Next: the owner resets the meter and types block S (20 words) in Telegram, Autocompletar off and on, with the new switch off and on
  (the echo switch stays on): compare "Key: space, punctuation, Enter" (average and 95 %), "Wait for the app: inside a key", the total
  waiting for the app and the two new lines (how many checks the message ran and how many a key asked at once). Also: the capital after
  ". ", "! " and Enter, a capital at the start of a sentence typed fast (less than 100 ms between the space and the letter) and slow, a
  gesture word and the suggestions at the start of a sentence, the shift key tapped right after a space, and closing and opening the
  keyboard, switching keyboards, leaving the app and a password field. If the space key does not fall, the switch goes off by default or
  the change is reverted.
  Measured by the owner on build _76 (block S, "casa " 20 times, in Telegram; Autocompletar off and on, each with the new switch off and
  on; the echo switch on; Auto-capitalization ON). The first attempt had Auto-capitalization off (its default in this keyboard, `default_auto_cap`
  false): the counts did not change, because with it off the shift update asks the app nothing, and the switch only added 20 messages that
  asked nothing (100 -> 120 keyboard messages), so that run measured nothing. With it on: the counts moved exactly as designed, inside a key
  120 -> 100 and in a message 20 -> 40, total 162 in the four runs, the 20 checks all ran by their message (about 100.1-100.4 ms) and none was
  asked early by a key. The space key went from 23.5 to 11.9 ms on average (95 %: 46.2 -> 25.1) with Autocompletar off and from 23.8 to 11.1 ms
  (95 %: 43.6 -> 18.9) with it on, about -50 %. "Handle a key" went from 6.6 to 3.3 ms and from 6.0 to 3.9 ms on average. The wait for the app in
  all (average x count) went from about 761 to 502 ms (-34 %) and from about 680 to 535 ms (-21 %) per 20 words; the two runs with the switch
  off differ by 11 % between themselves, the space key does not (23.5 and 23.8). Each question costs about 10-17 ms inside the key and about
  3.6-4 ms in the message. Letters, the touch wait (4.5, 3.6, 3.2 and 2.6 ms on average) and the suggestions did not change. Usage checks
  all passed (capital at the start of a field, after a period, "!" and Enter, typed fast and slow, the shift key after a space, the next-word
  suggestions, the lifecycle) and the double space turned into a period in all four runs. Decision: the switch stays on by default.
  A first usage check before the Auto-capitalization run reported a double space that needed three spaces to become a period; it was not
  reproduced (the real smali in the mini Dalvik gives the period at two spaces in every combination) and it passed in the four runs above.
  What is left: with Auto-capitalization on the same block asks 162 questions (against 101 with it off): 6 per word inside keys before the
  switch (3 per word with it off), 5 after it; the ones in the first letter of each word are not explained yet. With Auto-capitalization off
  the new switch posts a message per separator that asks nothing (nothing to defer): to run inline in that case is a candidate.
- Stage 6, ninth part (build _77): three changes, asked by the owner after the run of build _76.
  A. With Auto-capitalization off the delayed check has nothing to delay (the shift update asks the app nothing), so `mrShiftPost` now
  starts with `mAutoCapActive`: off = the update at once, no message (before: 20 messages per 20 words that asked nothing). And
  Auto-capitalization is on by default (`default_auto_cap` true; the screen takes its default from there; it is in "Restore defaults"
  already). `test_caps_defer.py`: auto-capitalization off with the switch on or off sends no message, asks nothing and gives the same
  text, and 200 random sentences give the same result.
  B. Capital on the second word of a gesture (owner's report: with Auto-capitalization on, the first word written by gesture in an empty
  field has a capital, right, and so does the second, wrong). Not reproduced with an app that answers from the text as it is. Reproduced
  in the PC test with an app that answers `getCursorCapsMode` from the text of before the batch edit (`MrGestureInput.write` writes the
  word and its space inside `beginBatchEdit`/`endBatchEdit`; both `pickSuggestion` and `sendSpace` end with `updateShiftKeyState`):
  the empty field says "capital", the shift state after the first word stays on and the second word is written with a capital (the third
  is right, because the answer then is the one of the text with a word). That this is what the owner's app does is not proved: the
  phone has to confirm it. The change does not depend on the app: `pickSuggestionManually` sets `mMrPick` (new field) when the picked
  word ends in a letter, and `getCursorCapsMode` does not ask while it is up unless the field asks for a capital on every word or all
  capitals (`inputType & 0x3000`, where the answer after the space is a capital). Before the cursor is that letter or the space after it, and
  `TextUtils.getCapsMode` gives 0 there for every other field. It is a cut by certainty, not by time or count: no threshold. It also
  removes two questions per picked word with the automatic space (one without it): the same cut as `mMrLetter` for typed letters. The
  note goes down right after the space (before the dictionary and strip steps) and when the method returns; nothing else reads it.
  `test_pick_caps.py` (26 checks, new), `test_letter_questions.py` (41), `test_gesture_comma.py` (40): with the old smali the stale
  app gives "Casa Mesa bonita" and the other 7 checks fail; with the new one only the first word has the capital with both kinds of app,
  the field with a capital on every word still capitalizes every word, locked shift is untouched, a word that does not end in a letter
  asks as before, and the sign glued after a gesture word still makes the next word start a sentence.
  C. `? ! :` after a word. `. , ! ? ) ; :` were already glued after a gesture word (`MrGestureInput.onKey` -> `LatinIME.mrGlue`), but
  `? ! :` are not on the main sheet: they are on the symbols sheet (and `:` in the popup of the period), and the key that goes there
  was one more key that ended the pending word (`forget()`), so the sign typed next was no longer glued. Now Shift (-1), Symbols (-2) and
  the sheet keys (-299..-305, -399..-499) are not "other keys": the pending word stays. And the same for a suggestion tapped on the
  strip: after its automatic space `pickSuggestionManually` calls `MrGestureInput.afterTap(ime, word)` (it does nothing while a gesture is
  being written) and the sign typed next goes through the same `mrGlue`, with the same `written()` check (the word and its space are right
  before the cursor, same field) instead of depending on `TextEntryState` and on what the editor answers about the text just given (the
  usual swap, which failed on the device after a gesture). Nothing else is pending after a tap: the backspace stays the usual one (one
  character; after a gesture it still takes the whole word), the strip is not touched. A letter, a space, Enter or any other key ends it;
  a tap in another field or a text changed without a key is not glued. `GestureInputTest.java` (330 checks).
  Questions added by C: none on any key but a glued sign: `written()` asks the app for the text before the cursor, once, and that
  replaces the one the usual swap (`swapPunctuationAndSpace`) asked (and the sign is not written and then swapped: one deletion and one
  commit), so a glued sign costs the same as before or less; the keys of the sheet and Shift add nothing; a tap writes two strings and one `getCurrentInputEditorInfo` (not a question to the app). If the glue is not
  possible the sign goes the usual way and asks what it asked before. A letter after a tapped word asks nothing more than before (the
  pending word is dropped).
  Risk of C: `:` glued to a word breaks things like `http: //` and `12: 30` typed by hand after a suggestion, and emoticons (`:)`); it
  was already so for a gesture word and for the usual swap (`:` is in the sentence separators of the keyboard), now it holds from the
  symbols sheet too. Not asked for: `;` and `)` are glued as before.
  Phone test (the owner): Auto-capitalization on (default now) and off, in an empty field of Telegram and of another app: three gesture
  words in a row (only the first has a capital); a tapped suggestion and then a letter; a field with a capital on every word (a name
  field); after a gesture word and after a tapped suggestion, Symbols and `?`, `!`, `:` and `,` `.` on the main sheet (glued, one space
  after); then a letter; the backspace after a tapped word (one character). Autocompletar off and on.
- Stage 7, first part (build _78): the owner's run of build _77 gave the first figures of a cold start (the keyboard stopped from the
  app settings and a field opened; one sample of each line): "Start the keyboard" 67.4 ms, "Build the keyboard" 20.3 ms, "Open in a field"
  11.6 ms, "Until it shows" 57.6 ms, memory Java 14.6 MB and native 43.2 MB. "Start" is timed from `LatinIME.<init>` to the end of `onCreate`
  and it held two pieces of work that nobody needs at that moment:
  A. `LatinIME.<init>` made the compose buffer and the dead-key buffer, so the static initializers of `ComposeSequence` (883 compose
  sequences, each one formatted) and of `DeadAccentSequence` ran before the first key; only the compose key (a hardware key code, -10024) and a
  combining mark typed (a language that allows dead keys) use them. Now `mrComposeBuffer` / `mrDeadBuffer` make them the first time (`onKeyOrig`:
  the compose key and the dead key; `processMultiKey`, which runs for every key, tests the dead-key buffer for null and has nothing to do when
  it is not there). `DeadAccentSequence.getSpacing/normalize` (a key that is a dead key, `isDeadKey()`) start the same class initializers when
  they are first used.
  B. `LatinIME.onCreate` asked the package manager twice (`queryBroadcastReceivers` for AnySoftKeyboard, `queryIntentActivities` for Hacker's
  Keyboard) to know the dictionary apps, although the downloaded packs are the normal source. Now `PluginManager.getDictionary` looks the apps
  up (`ensurePlugins`, synchronized, once) only after `MrPacks.openDictionary` found no pack for the language. The change of the installed
  packages (`PluginManager.onReceive`) no longer looks them up at once: it marks the look-up stale and asks for the languages again, and the
  look-up happens only if one of them has no pack. A language without a pack pays the same two queries as before, in `initSuggest`, so for
  that user there is no change (and no loss).
  Not in this part: the locale resources (`updateConfiguration` in `initSuggest` and `KeyboardSwitcher.getKeyboard`, which throws away the
  caches of the service's resources at each change of language): it changes how every string and drawable is loaded after a language switch,
  so it deserves its own part and its own test.
  `test_cold_start.py` (28 checks, new): the real smali in the mini interpreter with fake classes that count what is made and asked: the
  constructor and `onCreate` do not make the buffers nor look the apps up; keys typed with no compose key and no dead key make nothing;
  the buffers are made once and the same object comes back; compose mode, a dead-key sequence and the end of both still work; a language
  with a pack asks the package manager nothing; one without asks twice, once; a plugin found still gives its dictionary; a change of the
  installed packages asks nothing at once, marks stale and the next language without a pack asks again; `getPluginDictionaries` unchanged.
  With the old smali the test fails (7 checks). What the saving is, in ms, is the phone's to say: the figures are an estimate until then (the
  table is 883 `put` calls with a format each, the queries are two calls across processes), and nothing here is counted by the meter except
  the line "Start the keyboard".
  Next (the owner): with build _78, stop the keyboard from the app settings, open a field (Telegram), and read "Start the keyboard", "Build
  the keyboard", "Open in a field" and "Until it shows" on the Advanced screen, as done for the baseline; repeat 2 or 3 times (each stop is one
  sample). Also: a long press with accents, the language switch (if more than one language is on), a gesture, the tool bar, and a field of
  each kind; if there is a hardware keyboard or an app that sends combining marks, dead keys and the compose sequence still work.

