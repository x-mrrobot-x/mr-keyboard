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
