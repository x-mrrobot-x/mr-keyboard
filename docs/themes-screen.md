# Themes screen and backgrounds

Settings → **Keyboard theme** opens a screen with the keyboard as it is now on top, under it the themes and the backgrounds, every one drawn as a small keyboard with the real keys, so what is
chosen is seen before it is chosen. It replaces the dialog with a list of names.

```
┌──────────────────────────────┐
│ ←  Keyboard theme            │
│ ┌──────────────────────────┐ │   the keyboard in use (theme + background);
│ │  big keyboard            │ │   with a picture of the gallery: drag it to move the picture
│ └──────────────────────────┘ │
│  Midnight Steel · Dusk       │
│  [ Zoom ───●──── 150% ]      │   only with a picture
│  [ Soften background ──● ]   │   only with a background
│  Themes                      │
│  ▭ ▭ ▭   13 tiles, 3 a row   │   the check mark is on the one in use
│  Backgrounds                 │
│  ▭ ＋ ▭   none · gallery · my image
│  Landscapes   ▭ ▭ ▭ ▭ ▭ ▭    │
│  Gradients    12 tiles       │
│  [ Remove my image ]         │
└──────────────────────────────┘
```

## The theme and the background are chosen apart

The theme gives the keys, the colors and the ink of the toolbar; the background gives what shows around them. Every tile of the **themes** is
drawn over the background in use, and every tile of the **backgrounds** is drawn with the theme in use, so what a touch gives is what the tile
shows. The theme is still the preference `pref_keyboard_layout` (position 0 to 12, as before); nothing changes for the keyboard that is set up
already.

| Preference | Holds |
| --- | --- |
| `pref_keyboard_layout` | The theme, as it always was (`keyboard_layout_modes_values`). |
| `pref_kbd_bg` | The background: empty = none (the color of the theme), `g<N>` = gradient N (0 to 11), `s<N>` = landscape N (0 to 5), `i<zoom>,<dx>,<dy>,<time>` = the picture of the gallery. Anything that does not parse is "none". |
| `pref_kbd_bg_soft` | How much the background is softened, 0 to 70 (%). |

For a picture, the zoom is in per cent (100 to 400), the position goes from -100 (against the left or top edge) to 100 (against the right or
bottom one), and the time is when the picture was chosen, so a new picture is a new value and the caches know it. **Reset settings** puts the three
back (`MrReset.KEYS`).

## Where the backgrounds come from

- **Landscapes** (`MrScenes`): drawn by the code, nothing is stored or downloaded: a sky, a sun or a moon and layers of hills, trees or buildings.
  Six of them (dusk, dunes, sea, forest, northern lights, city). They look the same every time (the "random" parts come from a fixed sequence)
  and fill any shape, so one routine draws the keyboard, the tiles and the big preview.
- **Gradients** (`MrBackdrop.GRADIENTS`): twelve, each an angle and its colors. The angle is the one of CSS: 0 from the bottom up, 90 from left to
  right, 135 from the top left corner to the bottom right one.
- **The gallery** (`MrBackdrop.importImage`): the system picker (`ACTION_OPEN_DOCUMENT`, no permission is asked). The photo is read once, off the
  main thread, made at most **1280 px** on its longest side (it is decoded smaller, by a power of two, so a 48 MP photo does not fill the memory),
  turned the way its orientation tag says and kept as `kbd_bg.jpg` in the files of the app (JPEG, quality 90). A failure (not a picture, a stream
  that breaks) keeps what was there: the new file replaces the old one only when it is whole.

## A picture: zoom and move

The big keyboard shows the part of the picture that the keyboard will show (`MrBackdrop.crop`: the biggest part with the shape of the keyboard,
made smaller by the zoom). Dragging it moves the picture under the finger (`MrBackdrop.pan`); the
**Zoom** slider scales it. The settings are written when the finger lets go, not on every step, because the keyboard is made again at every
write.

## Legibility: the veil

Whatever the background, the ink of the toolbar (the suggestions, the icons) has to stay readable. A **veil** of the opposite color is laid over
the background: black over a dark theme, white over a light one. A theme is dark when **its background** is dark (`MrThemeColors.dark`, by the
role `kbd_bg`): not by its ink, because Chrome has dark letters on a dark background and Sky pale letters on a light one.

How dense it is comes from the picture itself (`MrBackdrop.look`): a small copy of it is measured, and the average brightness, over all of it
**and over its upper part where the toolbar is** (a bright sky over dark hills would otherwise slip through), must end up no brighter than 0.40
under a dark theme and no darker than 0.62 under a light one. The veil is never denser than 75% and never less than the softening that the person
set with **Soften background**. The keys have their own faces and do not need it. A dark landscape under a light theme is therefore washed out
(that is what it takes to keep the dark ink readable); the person can pick another theme or background.

`ThemesTest` runs it over every landscape and every gradient, under a dark and a light theme, and checks that the contrast of the ink of the
toolbar with the bar is at least 3 to 1 in the worst case.

## On the keyboard

`MrBackdrop.apply` (called by `MrTools.applyTranslucentBlur`, when the keyboard is made and when it is shown) puts a `MrBackdropDrawable` as the
background of the root of the toolbar, which holds the bar, the panels and the keys on the same sheet, and leaves the keyboard view clear (it
would paint the color of the theme over it). The drawable draws once for the size it has (a bitmap of that size) and the picture of the gallery is
let go of after it. When it cannot be made (no memory, a picture that is gone) it paints the color of the theme, so the keyboard is never
see-through. No background, or a picture that is gone: nothing is changed and the keyboard has the color of its theme.

`KeyboardSwitcher.onSharedPreferenceChanged` makes the keyboard again when `pref_kbd_bg` or `pref_kbd_bg_soft` change.

The navigation bar (`MrBottom.bar`, up to Android 15) takes the color of the **lower edge of the background** with its veil
(`MrBackdrop.bottomColor`); from Android 16 the keyboard is drawn under a transparent bar. See [bottom-space.md](bottom-space.md).

## The small keyboards

`MrThemePreview` draws a keyboard with the real faces: the key drawables of the theme (`btn_keyboard_key_<theme>` and `_accent`, one copy of each
per tile, so that making them ready does not change the ones of the keyboard), its colors and labels, the neon light of the neon themes, a line of
suggestions in the ink of the toolbar. The keys are drawn as large as the real ones on this phone (the narrow side of the screen is the width of
the keyboard) and the whole is scaled to the tile, so the radius, the lips and the gaps are the ones of the keyboard. A theme that has no key
drawable falls back to flat faces in its colors. The chosen one has a ring and a check mark.

## Files

| File | What it is |
| --- | --- |
| `MrThemesActivity` | The screen. Nothing is kept in it: it reads the preferences, so it can be made again at any time. |
| `MrThemeRow` | The row of the settings: it opens the screen and says on its second line what is chosen ("Midnight Steel · Dusk"). |
| `MrThemePreview` | The small keyboard. |
| `MrBackdrop`, `MrBackdropDrawable`, `MrScenes` | The background: the spec, the drawing, the veil, the picture of the gallery, the keyboard. |
| `MrThemeColors` | The colors and names of any theme (the one in use is `MrTheme`'s). |
| `docs/tools/themes_test/ThemesTest.java` | The test, with the real `res/` files. |

## Testing

`ThemesTest` (`docs/tools/run_java_tests.sh`) draws the previews with Java2D behind the `Canvas` stub and reads the pixels. Give it a folder as the
first argument and it dumps PNGs of the thirteen themes, of the landscapes and gradients under a dark, a light and a neon theme, and of a picture
with several zooms and positions, to look at. The real key faces are drawn by `KeyStyle` (smali) and are not in those pictures: how it looks on the
phone is for the person to try, with **Autocompletar** on and off.

New `android.graphics` calls (to check against the real API with `ANDROID_JAR` in CI, `check_stub_api.py`): `Bitmap`, `BitmapFactory`,
`LinearGradient`, `RadialGradient`, `Matrix`, `Canvas.drawBitmap` / `clipPath` / `drawRect`, `ExifInterface`.
