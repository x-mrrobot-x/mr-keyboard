# Themes screen and backgrounds

Settings → **Keyboard theme** opens a screen with the keyboard as it is now on top, under it the themes, the colors, the gradients, the landscapes and the pictures of the gallery, every one drawn as a
small keyboard with the real keys, so what is chosen is seen before it is chosen. It replaces the dialog with a list of names.

```
┌──────────────────────────────┐
│ ←  Keyboard theme            │
│ ┌──────────────────────────┐ │   the keyboard in use: the only place that shows the choice
│ │  big keyboard            │ │
│ └──────────────────────────┘ │
│  Midnight Steel              │
│  Themes                      │
│  ▭ ▭ ▭   13 tiles, 3 a row   │   touch = chosen at once; the check mark is on the one in use
│  Colors       12 tiles       │   touch = dialog with the preview: Cancel / Apply
│  Gradients    21 tiles       │   (same dialog)
│  Landscapes    9 tiles       │   (same dialog)
│  Gallery      ＋ · my image   │   ＋ = photo picker, then the crop, then the preview
│  [ Remove my image ]         │
└──────────────────────────────┘
```

## A theme and a background are never mixed

- A **theme** (Midnight, Aurora…) is chosen with one touch and written at once. It takes the background away (`pref_kbd_bg` is cleared in the same
  write), and its tile, like every tile of the list, always shows the theme as it is: a background chosen never changes them.
- A **color, a gradient or a landscape** opens a dialog with the keyboard as it will look (a sheet at the bottom: **Cancel** / **Apply**). Nothing
  is written until **Apply**, and only the keyboard at the top of the screen shows the result.
- A **picture of the gallery** goes through the crop dialog first (below), then through the same preview.

The backgrounds have two themes of their own, which the list does not show (`MrThemeColors.hidden`, tags `mr_overlight` and `mr_overdark`, the last
two of `make_themes.ORDER`, values 13 and 14 of `pref_keyboard_layout`):

| Theme | For | Ink |
| --- | --- | --- |
| `overlight` | gradients, landscapes, pictures and the dark colors | white (`#ffffff`) |
| `overdark` | the light colors | dark (`#202124`) |

Their keys are all the same, flat (no lip, no border) and see-through: a white veil (`#38ffffff`, a black one on the light colors) over whatever
the background is, the accent keys (shift, delete, enter…) included; only the ink of the letters and of the icons changes. A color has dark ink when
white would not read on it (less than 4.5 to 1 against white, `MrBackdrop.darkInk`): the light and light-medium ones. Applying a background writes the
right one of the two in the same edit as the background itself (`MrBackdrop.themeTag`).

| Preference | Holds |
| --- | --- |
| `pref_keyboard_layout` | The theme (`keyboard_layout_modes_values`): 0 to 12 the themes of the list, 13 and 14 the themes of the backgrounds. |
| `pref_kbd_bg` | The background: empty = none, `c<N>` = color N (0 to 11), `g<N>` = gradient N (0 to 20), `s<N>` = landscape N (0 to 8), `i<zoom>,<dx>,<dy>,<time>` = the picture of the gallery. Anything that does not parse is "none". It counts only when the theme is one of the two of the backgrounds: in any other theme an old value is let be (`MrBackdrop.lookNow` / `apply`, the screen and the row of the settings all go by this). |
| `pref_kbd_bg_soft` | How much a **picture** is softened, 0 to 70 (%). Colors, gradients and landscapes ignore it. |

For a picture, the zoom is in per cent (100 to 400), the position goes from -100 (against the left or top edge) to 100 (against the right or
bottom one), and the time is when the picture was chosen, so a new picture is a new value and the caches know it. **Reset settings** puts the
three back (`MrReset.KEYS`).

## Where the backgrounds come from

- **Colors** (`MrBackdrop.COLORS`): twelve plain colors, shown as they are (no veil: the color itself is the lower edge for the navigation bar).
- **Gradients** (`MrBackdrop.GRADS`): twenty-one dark ones, all from the top down (some with stops, two with a soft light in a corner), like the dark
  gradients of the GB examples without the brown and orange ones.
- **Landscapes** (`MrScenes`): nine technological ones drawn by the code (nothing is stored or downloaded): neon city, synthwave, circuit board,
  network, orbit, hologram, data streams, signal waves and hex grid. They look the same every time (the "random" parts come from a fixed sequence)
  and fill any shape, so one routine draws the keyboard, the tiles and the previews.
- **The gallery**: the photo picker of the system (`MrThemesActivity.pickers`): `android.provider.action.PICK_IMAGES` (Android 11 and later where it
  exists, always on 13), then `ACTION_PICK` on the images of the media store, and last `ACTION_OPEN_DOCUMENT` (the file manager), each tried when the one
  before it has no app to answer. No permission is asked. The photo is read once, off the main thread (`MrBackdrop.importPending`), made at most
  **1280 px** on its longest side (decoded smaller, by a power of two, so a 48 MP photo does not fill the memory), turned the way its orientation tag
  says, and kept as `kbd_bg_new.jpg`: a **waiting** picture. It becomes `kbd_bg.jpg` (the background, `commitPending`) only with **Apply**; **Cancel**,
  the back button and closing the screen delete it (`discardPending`), so a picture that is not applied costs the one that was there nothing.

## A picture: the crop dialog

After the pick a full page opens (`MrCropView`): the picture as large as the screen allows, the frame of the keyboard over it (its shape is
`MrBackdrop.ASPECT`) and what is outside the frame dimmed. **One finger** drags the frame (`MrBackdrop.shift`), **two fingers** pinched make it smaller
(a bigger zoom) and spread make it bigger, around its middle (`MrBackdrop.rezoom`). Under it **Soften background** (0 to 70%) darkens the part inside
the frame as a hint. **Next** shows the keyboard with that frame in the preview; **Apply** there writes the picture, its zoom and position, the
softening and the theme of the backgrounds in one edit. **My image** (the tile that appears when there is a picture) opens the same crop on the picture
that is kept, with the frame where it is now.

## Legibility: the veil

Whatever the background, the ink of the toolbar (the suggestions, the icons) has to stay readable. A **veil** of the opposite color is laid over a
gradient, a landscape or a picture: black under the white ink (`overlight`), white under the dark one. How dense it is comes from the background itself
(`MrBackdrop.look`): a small copy of it is measured, and the average brightness, over all of it **and over its upper part where the toolbar is**, must
end up no brighter than 0.40 under white ink and no darker than 0.62 under dark ink. The veil is never denser than 75% and, for a picture, never less
than the softening set with **Soften background**. A plain color has no veil.

`ThemesTest` runs it over every color, gradient and landscape and checks that the contrast of the ink of the toolbar with the bar is at least 3 to 1
in the worst case, and that of the letters with their see-through keys at least 2.5 to 1.

## On the keyboard

`MrBackdrop.apply` (called by `MrTools.applyTranslucentBlur`, when the keyboard is made and when it is shown) puts a `MrBackdropDrawable` as the
background of the root of the toolbar, which holds the bar, the panels and the keys on the same sheet, and leaves the keyboard view clear (it
would paint the color of the theme over it). It does so only in one of the two themes of the backgrounds. The drawable draws once for the size it has
and the picture of the gallery is let go of after it. When it cannot be made (no memory, a picture that is gone) it paints the color of the theme, so
the keyboard is never see-through.

`KeyboardSwitcher.onSharedPreferenceChanged` makes the keyboard again when `pref_kbd_bg` or `pref_kbd_bg_soft` change.

The navigation bar (`MrBottom.bar`, up to Android 15) takes the color of the **lower edge of the background** with its veil
(`MrBackdrop.bottomColor`); from Android 16 the keyboard is drawn under a transparent bar. See [bottom-space.md](bottom-space.md).

## The small keyboards

`MrThemePreview` draws a keyboard with the real faces: the key drawables of the theme (`btn_keyboard_key_<theme>` and `_accent`, one copy of each
per tile, so that making them ready does not change the ones of the keyboard), its colors and labels, the neon light of the neon themes, a line of
suggestions in the ink of the toolbar. The keys are drawn as large as the real ones on this phone (the narrow side of the screen is the width of
the keyboard) and the whole is scaled to the tile, so the radius, the lips and the gaps are the ones of the keyboard. A theme that has no key
drawable falls back to flat faces in its colors. The chosen one has a ring and a check mark. A tile of a background is drawn with the theme of the
backgrounds that suits it; a tile of a theme is the theme with no background.

## Files

| File | What it is |
| --- | --- |
| `MrThemesActivity` | The screen and its dialogs (the preview and the crop). Nothing is kept in it: it reads the preferences, so it can be made again at any time. |
| `MrThemeRow` | The row of the settings: it opens the screen and says on its second line what is chosen (the theme, or the background when the theme is one of the two of the backgrounds). |
| `MrThemePreview` | The small keyboard. |
| `MrCropView` | The picture with the frame to drag and pinch. |
| `MrBackdrop`, `MrBackdropDrawable`, `MrScenes` | The background: the spec, the drawing, the veil, the waiting and the kept picture, the keyboard. |
| `MrThemeColors` | The colors and names of any theme (the one in use is `MrTheme`'s), which themes are hidden. |
| `docs/tools/themes_test/ThemesTest.java` | The test, with the real `res/` files. |

## Testing

`ThemesTest` (`docs/tools/run_java_tests.sh`) draws the previews with Java2D behind the `Canvas` stub and reads the pixels. Give it a folder as the
first argument and it dumps PNGs of the themes, of the colors, gradients and landscapes in their theme, of the picture with several zooms and
positions, and of the crop dialog, to look at. The real key faces are drawn by `KeyStyle` (smali) and are not in those pictures: how it looks on the
phone is for the person to try, with **Autocompletar** on and off.

New `android` calls (to check against the real API with `ANDROID_JAR` in CI, `check_stub_api.py`): `Bitmap`, `BitmapFactory`, `LinearGradient`,
`RadialGradient`, `Matrix`, `Canvas.drawBitmap` / `clipPath` / `drawRect`, `ExifInterface`, `Dialog` / `Window.setGravity` / `setLayout`,
`Intent.setDataAndType` / `addCategory`, `SeekBar`, `MotionEvent.getPointerCount` / `getActionMasked`.
