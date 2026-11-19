# Space under the last row of keys and the navigation bar

Two things at the bottom of the keyboard.

## The space under the last row

The last row of keys does not touch the bottom of the keyboard: there is a space of **4 dp** under it. It is the same with the home
gesture and with the three buttons (or two): the gap is fixed, it does not depend on the way of navigating.

The space is part of the height of the keyboard, and it is painted with the background of the theme:

- `MrBottom.apply` adds it as bottom padding of the view that holds the toolbar and the keys (`LatinIME.setInputView`, before
  `ImeInsets`, which takes the padding the view has as its base). Asking twice for the same view does not add it twice.
- `MrBottom.keysHeight` takes it out of the height of the keyboard: the setting "Keyboard height" is a share of the height of the screen
  that **includes** the space, so the rows of keys have what is left (the `Keyboard` constructor, where `mKeyboardHeight` is made). The
  keys never give up more than half of that share. The keyboard is as tall as the setting says, with or without the space.

From Android 15 on the keyboard is drawn under the system bar and `ImeInsets` adds the height of the bar on top of this space. Before
that the window already ends above the bar, and this space is all there is under the keys.

The default heights are 34% (portrait) and 61% (landscape): the space is 11 px at 2.625 px per dp, 0.5% of a screen of 2400 px and 1.0% of
one of 1080 px, so the rows of keys keep about the size they had when the keyboard had no space (34% and 60%).

## The navigation bar takes the color of the theme

The bar of the system (with the three buttons) sits under the keyboard, and `MrBottom.bar` asks the window of the keyboard to paint it with
the background of the theme, the same color as the rest of the keyboard. It depends on the Android:

| Android | What is asked of the window |
| --- | --- |
| 16 and up | **Transparent** bar and **no contrast veil** (`setNavigationBarColor(TRANSPARENT)`, `setNavigationBarContrastEnforced(false)`). The keyboard is drawn under the bar, so the buttons sit on its background. |
| 11 to 15 | The bar gets the **color of the keyboard background** (the role `kbd_bg` of the theme), with its opacity, and no contrast veil. Without it the system paints the bar black, or puts a veil (80% of an opaque color) on the three buttons, a band of another shade under the keys. |
| 10 and before | Nothing is asked (the system paints its own bar). |

The color of the buttons (dark or light) follows the theme from Android 11 on (`MrLight.bars`: dark buttons on a light theme, light buttons
on a dark one). Everything is asked when the keyboard view is put in the window and again when the window is shown, because a window that
the system made again has the defaults. With the home gesture there are no buttons, so the request changes nothing visible there.

To change a value: `GAP_DP` in `MrBottom.java`, and the two default heights in `res/values/strings.xml` (`default_height_portrait` and
`default_height_landscape`: the share of the screen is the height of the rows plus the space). `BottomSpaceTest` checks that the rows keep
their height within 2% (portrait) and 1% (landscape).

Test: `docs/tools/bottom_test/BottomSpaceTest.java` (`run_java_tests.sh`).
