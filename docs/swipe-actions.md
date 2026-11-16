# Swipe actions: how a sideways swipe is seen (2.0.0)

The swipes up, down, left and right run the actions chosen in **Settings → Touch and gestures → Gestures and volume keys** (`pref_swipe_up`, `pref_swipe_down`,
`pref_swipe_left`, `pref_swipe_right`). By default left and right change the sheet (`sheet_prev`, `sheet_next`), up opens the extension row and
down closes the keyboard.

## Where a swipe may start

| Where the finger goes down | Gesture typing off | Gesture typing on |
|----------------------------|--------------------|-------------------|
| a letter of the main sheet (ABC) | swipe | gesture typing (the swipe does not start here) |
| anything else of the main sheet: Shift, delete, space row, digits, gaps between keys | swipe | swipe |
| any key of the other sheets (123, TSK, your own...) | swipe | swipe |

Gesture typing only looks at a touch that goes down on a **letter** of the **main sheet** (sheet 0, letters layout; `MrGestureInput.begin`).
The digits, the symbols and every other sheet are never followed, so there a slide is always a swipe. With gesture typing off, the letters
have nothing else to do with a slide, so a swipe works there too. A Shift, Ctrl, Alt, Meta or Symbols key that holds the finger and slides is
a chord, not a swipe, but a fast swipe still works from them.

## How a sideways swipe is seen

Two detectors look at every touch, the fling detector first.

1. **The fling** (`LatinKeyboardBaseView$1.onFling`, the platform's `GestureDetector`): the finger must *leave* the screen fast (300 dp/s), without
   slowing down (the speed of the last points at least a quarter of the fling speed), moving more sideways than up or down, and at least
   `min(width / 3, height / 3)` away from where it went down. It only fires when the finger lifts.
2. **The release** (`LatinKeyboardBaseView.onUpEvent`, since 2.0.0): a touch that ends at least that far away (`min(width / 3, height / 3)`,
   the same distance), more sideways than up or down, starting from a key that is not a modifier. It already did one thing: the key where the
   finger stopped was not typed. Now it is the swipe too: `mrSwipeAtRelease` runs the right action when the finger ended to the right of where it
   went down, the left one when it ended to the left. Where it ends does not matter (a swipe to the left that stops over Shift is a swipe).

Before 2.0.0 a long drag that was too slow, or that slowed down before the finger lifted, was neither: no fling, and the release only cancelled
the key. Nothing happened, which is what made the swipe hard to hit. Now the distance decides, and the speed no longer does: a flick and a
slow drag both work. The fling goes first and is as it was (a swipe it takes never reaches the release, so an action runs once), and the
release is its fallback.

What does not change: a drag shorter than the distance still types the key where the finger stopped (sliding from a key to the next to
correct the aim); up and down swipes keep the fling rules only; the extension row above the keys has no swipes (`swipeGuardEnabled`).
`GlobalKeyboardSettings.sendSlideKeys`, the old mode that types every key the finger crosses, would also turn the release off, but nothing
sets it: it is always 0.

## Tests

`docs/tools/test_swipe_release.py` runs the real smali of `onUpEvent`, `mrIsSwipeRelease` and `mrSwipeAtRelease` in the mini Dalvik
interpreter (`docs/tools/dalvik_mini.py`): the distance (exactly, one pixel more), more up than sideways, from and to a modifier, each side,
the key cancelled first, a short drag typed as before, the extension row, landscape and narrow shapes, 500 random touches. The rules of where
gesture typing starts (letters of the main sheet only, nothing on the digits or the other sheets) are in `GestureInputTest`.

## To try on the phone (with gesture typing off and on)

1. A slow drag to the left and to the right, starting on a space, comma or digit key (on the main sheet) and on any key of the 123 sheet: the
   sheet changes.
2. The same drag, stopping for a moment before lifting the finger: the sheet changes.
3. A fast flick: as before.
4. With gesture typing on, a drag that starts on a letter writes a word and never changes the sheet; with it off, it changes the sheet.
5. A drag of one key to the side from a key (to correct the aim) still types the key where the finger stops.
