# Space under the last row of keys

The last row of keys does not touch the bottom of the keyboard: there is a small space under it, and the space depends on how the person
navigates in Android.

| Navigation | Space under the last row |
| --- | --- |
| Home gesture (swipe up from the bottom edge) | 10 dp |
| Three buttons, or two | 4 dp |

## Why these values

- With the home gesture the system reserves the bottom of the screen for the swipe: the gesture bar is **24 dp** high and the area that
  detects the swipe is **32 dp** (`navigation_bar_gesture_height` of AOSP). A row of keys that touches the edge of the window is where a
  swipe up starts, and a finger that slides while typing by gestures can take the person out of the keyboard. 32 dp less the 24 dp of the
  bar is 8 dp; Gboard, the reference, leaves about 10 dp under its last row, which is the value used.
- With the three buttons (or two) the system draws its own bar of **48 dp** under the keyboard, so the keys are already apart from the
  edge of the screen and a thin margin is enough.

From Android 15 on the keyboard is drawn under the system bar and `ImeInsets` adds the height of the bar on top of this space. Before
that the window already ends above the bar, and this space is all there is under the keys.

## The navigation bar takes the color of the theme

The bar of the system (with the three buttons) sits under the keyboard, and `MrBottom.bar` asks the window of the keyboard to paint it with
the background of the theme, the same color as the rest of the keyboard, as Gboard does. It depends on the Android:

| Android | What is asked of the window |
| --- | --- |
| 15 and up | **Transparent** bar and **no contrast veil** (`setNavigationBarColor(TRANSPARENT)`, `setNavigationBarContrastEnforced(false)`). The keyboard is drawn under the bar, so the buttons sit on its background. Without this the system puts a veil (80% of an opaque color) on the three buttons, a band of another shade under the keys. |
| 11 to 14 | The bar gets the **color of the keyboard background** (the role `kbd_bg` of the theme), with its opacity, and no contrast veil. The window ends above the bar there and the system paints it black if nobody asks. |
| 10 and before | Nothing is asked (the system paints its own bar). |

The color of the buttons (dark or light) follows the theme from Android 11 on (`MrLight.bars`: dark buttons on a light theme, light buttons
on a dark one). Everything is asked when the keyboard view is put in the window and again when the window is shown, because a window that
the system made again has the defaults. With the home gesture the bar is already transparent, so the request changes nothing there.

## Where it is

`MrBottom` (Java layer) decides the space and does two things with it:

- `MrBottom.apply` adds it as bottom padding of the view that holds the toolbar and the keys (`LatinIME.setInputView`, before
  `ImeInsets`, which takes the padding the view has as its base). That view has the background of the theme, so the space is painted like
  the keyboard. Asking twice for the same view does not add it twice.
- `MrBottom.keysHeight` takes it out of the height of the keyboard: the setting "Keyboard height" is a share of the height of the screen
  that **includes** the space, so the rows of keys have what is left (the `Keyboard` constructor, where `mKeyboardHeight` is made). The
  keys never give up more than half of that share. The keyboard is as tall as the setting says, with or without the space.

The default heights went from 34% to 35% (portrait) and from 60% to 62% (landscape): the space is 26 px at 2.625 px per dp, 1.1% of a
screen of 2400 px and 2.4% of one of 1080 px, so the rows of keys keep the size they had.

## How the way of navigating is read

`Settings.Secure navigation_mode` (0 three buttons, 1 two, 2 gestures). When it is not there, the resource
`config_navBarInteractionMode` of the system (same values). Samsung (`navigation_bar_gesture_while_hidden`) and Xiaomi
(`force_fsg_nav_bar`) have settings of their own for their full-screen gestures, in `Settings.Global`; 1 counts as the home gesture. When
nothing is found the smaller space (buttons) is used. The values are read every time a keyboard is made and when the view is put in the
window, so a change in the system shows the next time the keyboard opens.

To change a value: `GESTURE_DP` and `BUTTONS_DP` in `MrBottom.java`, and the two default heights in `res/values/strings.xml`
(`default_height_portrait` and `default_height_landscape`, the share of the screen plus the space divided by the height of the screen,
`BottomSpaceTest` checks that the rows keep their height within 1%).

Test: `docs/tools/bottom_test/BottomSpaceTest.java` (`run_java_tests.sh`).
