# Performance plan (in progress)

Live plan of the performance round started after v1.98.0. One stage = one zip and one commit; the version of the release does
not change. When the round is over this file is deleted (the history stays in Git), like docs/plan-suggestions.md was.

Everything below was found by reading the code (smali, the Java layer, the manifest), not by measuring on a phone: the
environment has no device. Costs are estimates, marked as such. Stage 2 adds the numbers from the phone.

## 1. Findings

### Drawing the keyboard

- **The keyboard window is drawn by the processor.** The manifest has `hardwareAccelerated="false"` for the app. A window with no
  parent (the keyboard window is one) takes its acceleration from the app flag (`WindowManagerGlobal.addView`), and
  `InputMethodService` only adds `FLAG_HARDWARE_ACCELERATED` when `enableHardwareAcceleration()` was called. So the keyboard,
  the suggestion strip and every panel (emoji list, clipboard, screenshots) are rasterized on the CPU, frame by frame. The
  "keyboard window" row of the Advanced screen (`MrAccel`, never read on a phone so far) shows what the system really did.
  Consequences: scrolling the emoji list redraws the whole list on the CPU each frame; the background blur of the translucent
  themes (`MrTranslucentBlur`) never runs, because it needs an accelerated window.
- **The first keyboard view of each process has a software layer.** `GlobalKeyboardSettings.renderMode` is always 1
  (`LAYER_TYPE_SOFTWARE`; the setting that changed it is gone) and `LatinKeyboardBaseView.setRenderModeIfPossible` only applies it
  when it differs from a STATIC "previous mode" that starts at -1. The first view made in a process gets the layer, every later
  one (after a theme change, a rotation, the popups of variants) does not. In a window drawn by the CPU a view with a software
  layer is a drawing cache: any `invalidate(rect)` throws the whole cache away, so each key press and each release redraws ALL
  keys (shadows and glows included) into a bitmap the size of the keyboard and copies it. Without the layer only the pressed key
  is redrawn. The same keyboard is fast or slow depending on whether its view is the first of the process.
- **Icon shadows are blurred again on every frame.** `ShadowDrawHelper.draw` (dark outline of the icons on dark themes, the
  light of the icons on neon themes) creates a bitmap of the key, draws the icon, blurs it with a `BlurMaskFilter`
  (`extractAlpha`), draws the result and recycles both bitmaps: two allocations and one blur per icon key per frame. Recycling a
  bitmap right after drawing it is also unsafe once the window is accelerated (the frame is drawn later, on the render thread).
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
- The screens are drawn by the CPU by default (`pref_ui_hw_accel`, Advanced, off); only the three screens that draw on their own
  ask for acceleration in the manifest.
- Writes made by the keyboard while typing (recent emojis, clipboard, tool bar state) go through `apply()` and the listeners
  ignore the keys they do not care about.

## 2. Stages

| # | Stage | What changes | Risk |
|---|-------|--------------|------|
| 1 | Drawing in the current mode | no software layer on the keyboard view (every view the same); icon shadows blurred once and kept | low |
| 2 | Performance meter | Advanced screen + `MrPerf` log: time to open, time per frame (average, p95, max), touch to text, time of the synchronous calls to the app; memory: Java heap, native heap, kept bitmaps and caches (to see stage 4 work) | low |
| 3 | Hardware acceleration of the keyboard window | on by default, switch in Advanced to turn it off; view without layer; check every theme, gestures, popups, the AI Editor dialog; translucent blur starts working | medium |
| 4 | Cleanup by the keyboard itself | `onTrimMemory`/`onLowMemory`: by level, drop the keyboards not in use, the popups of variants, the kept shadows, the label metrics, the screenshot thumbnails, the emoji search index and the panels that are closed; release (recycle) the bitmaps of the space bar and of the shadows at the safe moments (window hidden, view replaced, theme change); `onDestroy` closes the engine and the databases and stops the threads; the meter shows the effect | medium |
| 5 | Opening in each field | re-correction from `initialSelStart/End` (no full text); popups of variants and label metrics kept while the keyboard is the same; `setKeyboard` with the same keyboard does less | low-medium |
| 6 | Typing | no `getCursorCapsMode` in the middle of a word (except all-caps fields); click volume kept and refreshed on change; the small per-frame garbage of `onBufferDraw`; the log lines | low |
| 7 | Cold start | compose tables built on first use; plugin dictionaries only looked up when a language has no pack; locale resources through a configuration context instead of `updateConfiguration` | medium |
| 8 | Tool bar and panels | panels inflated the first time they open, only if stage 2 shows the creation of the input view is slow on the phone | medium-high |
| 9 | Settings screens | hardware acceleration on by default for the screens once stage 3 is confirmed on the phone; nothing else needed for typing | low |

Stage 4 comes after stage 3 on purpose: when a bitmap may be recycled depends on whether the window is accelerated. Stage 5
keeps more in its caches, so it relies on stage 4 to give that memory back when Android asks.

Each stage keeps the tests green (`smali_regcheck`, the mini Dalvik tests, the Java tests) and adds its own. What can only be
seen on a phone (smoothness, look of each theme) is listed in the reply of the stage.

## 3. Status

- Stage 1: done (render mode 0; `ShadowDrawHelper` keeps 24 blurred shadows; `docs/tools/test_shadow_cache.py`).
