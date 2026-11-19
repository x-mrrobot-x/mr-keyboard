# Themes screen and backgrounds

Settings → **Keyboard theme** opens a screen with the keyboard in use on top, and under it **tabs**, one for each category: **Themes**, **Colors**,
**Gradients**, one for each category of landscapes (**Sports, Animals, Snow, Nature, Anime, AI**) and **Gallery**. Touching a tab shows its cards:
each is a small keyboard with the real keys, the name under it on the left and a **View** pill on the right (it says **In use** on the one in use,
with a frame in the accent color), so what is chosen is seen before it is chosen.

```
┌──────────────────────────────┐
│ ←  Keyboard theme            │
│ ┌──────────────────────────┐ │
│ │ ┌────────┐  IN USE       │ │   the card of the choice in use: the keyboard as it is now on the left;
│ │ │ big    │  Midnight     │ │   on the right the tag, the name and what it is (the tab, the keys)
│ │ │keyboard│  Steel        │ │
│ │ └────────┘  Theme        │ │
│ └──────────────────────────┘ │
│ [Themes] Colors Gradients Sports Animals Snow Nature Anime AI Gallery →   the strip of tabs scrolls sideways
│ ┌──────────────────────────┐ │
│ │ keyboard                 │ │   one card a row; touching a card opens its dialog
│ ├──────────────────────────┤ │
│ │ Aurora            [View] │ │ ▏ the scroll bar is thin and faint, in the margin on the right
│ └──────────────────────────┘ │
└──────────────────────────────┘
```

The card of the choice in use is the only place that says what is chosen besides the **In use** pill of the card that is. Under the name it says what the
choice is: **Theme** for a theme of the list, or the tab of a background and, when it has styles of keys, the kind and the style (`Keys: Outline · White`).
Every list is one card wide (`MrThemesActivity.COLUMNS`), and the margin on the right of the screen (`SCROLL_MARGIN_DP`, 20 dp) belongs to the list: it is
its padding, not clipped, and the scroll bar is drawn there (`SCROLLBARS_OUTSIDE_OVERLAY`, 3 dp wide, the thumb in a faint tone of the secondary text,
`SCROLL_THUMB_ALPHA`, from Android 10; it fades when the list is still), so it is never over the cards.

There is no "Landscapes" group: each category of landscapes is a tab of its own, like the colors and the gradients. The screen opens on the tab of
what is in use (the themes when there is no background).

**Nothing is made before it is needed.** A tab makes its cards only when it is opened, a few at a time (`CHUNK`, each step posted to the main thread,
so a long tab does not hold the screen), and lets go of the ones of the tab that was left. The small copies of the landscapes are read apart from the
main thread, half the size of the file, only for the category that was opened (once for the life of the screen); each card shows its picture as its
copy arrives. The card of a theme is the theme with no background, the card of a background is that background in the theme that suits it.

## A theme and a background are never mixed

- A **theme** (Midnight, Aurora…) opens a dialog with the **complete keyboard** of that theme: **Cancel** / **Apply**. **Apply** chooses it and
  takes the background away (`pref_kbd_bg` is cleared in the same write). Its card, like every card of the themes, always shows the theme as it is:
  a background chosen never changes them.
- A **color, a gradient or a landscape** opens a dialog with the **complete keyboard** as it will look (a sheet at the bottom: **Cancel** / **Apply**):
  the row of Ctrl, Alt and the arrows, the numbers, the letters and the bottom row, every highlight key with its own face and the dash of the
  modifier keys in its three states (see [The small keyboards](#the-small-keyboards)). It also has two controls, so that the keys can be told
  apart from a busy background (below). Nothing is written until **Apply**, and only the keyboard at the top of the screen shows the result.
- A **picture of the gallery** goes through the crop dialog first (below), then through the same preview.

### Soften background and key styles

Keys that blend with the background are the main problem of a picture, so the dialog of a background has:

- **Soften background** (0 to 70%, a slider; gradients, landscapes and pictures, not the plain colors): a veil over the background itself, in the
  opposite color of the ink, that is at least as dense as the setting. The keyboard of the dialog is drawn again while the slider moves; it starts
  at the softening in use when the background is the one in use, and at none for another. It is written (`pref_kbd_bg_soft`) with **Apply**.
- **Keys**, fifteen **styles** in three kinds, to choose in two levels (the **Glass**, **Outline** and **Gradient** chips and, under them, the dots of
  the colours of the kind in use with the name of the one chosen), for every background but the light colors (their keys already have dark ink on a
  pale background). Every face is translucent: a hue at low opacity over the background, never a solid fill.

| Kind | Styles | Keys |
| --- | --- | --- |
| Glass | See-through (the default), Ice, Lilac, Mint, Ember | The first is a white veil (`#38ffffff`); the others a veil of the hue (about 26%, a little more on the highlight keys) with a lighter rim of the hue. The letters stay white. |
| Outline | White, Cyan, Violet, Fuchsia, Lime, Gold | A bright 1 dp outline of the hue around a faint face of the same hue (8%, 16% on the highlight keys); the letters are a very light tone of the hue. |
| Gradient | Dawn, Tide, Prism, Lagoon | The outline, the letters, the icons and the light of the keys are gradients: each key takes the hue of its place on the keyboard (`MrGlow`, the same mechanism as the neon themes, three hues from the left to the right and a little down). |

The style is not a preference of its own: **each style is a hidden theme** and the one chosen is the theme stored in `pref_keyboard_layout` along
with the background (`MrBackdrop.themeTag(spec, style)`, `styleOf(tag)`), so the keyboard and the screen read it from there and nothing needs
migrating. The dialog of the next background starts with the style in use.

The backgrounds have sixteen themes of their own, which the list does not show (`MrThemeColors.hidden`, tags starting with `mr_over`, the last
sixteen of `make_themes.ORDER`, values 13 to 28 of `pref_keyboard_layout`):

| Theme | Value | For | Ink |
| --- | --- | --- | --- |
| `overlight` | 13 | gradients, landscapes, pictures and the dark colors (the see-through style) | white (`#ffffff`) |
| `overdark` | 14 | the light colors | dark (`#202124`) |
| `overice`, `overlilac`, `overmint`, `overember` | 15 to 18 | the tinted glass styles (`MrBackdrop.STYLE_TAGS`) | white |
| `overline`, `overteal`, `overviolet`, `overfuchsia`, `overlime`, `overgold` | 19 to 24 | the outline styles | a light tone of the hue |
| `overdawn`, `overtide`, `overprism`, `overlagoon` | 25 to 28 | the gradient styles | a light tone, redrawn per key |

Their keys are flat (no lip, no border; the outline and gradient styles have a 1 dp stroke in the face), and the accent keys (shift, delete, enter…) have the face of
the letters in the see-through style; only the ink of the letters and of the icons changes between `overlight` and `overdark`. A color has dark ink
when white would not read on it (less than 4.5 to 1 against white, `MrBackdrop.darkInk`): the light and light-medium ones, which have no styles.
Applying a background writes the right theme in the same edit as the background itself.

| Preference | Holds |
| --- | --- |
| `pref_keyboard_layout` | The theme (`keyboard_layout_modes_values`): 0 to 12 the themes of the list, 13 to 28 the themes of the backgrounds (the style of the keys). |
| `pref_kbd_bg` | The background: empty = none, `c<N>` = color N (0 to 15), `g<N>` = gradient N (0 to 19), `s<N>` = landscape N (0 to 35, six per category in the order of `MrScenes.SLUGS`), `i<zoom>,<dx>,<dy>,<time>` = the picture of the gallery. Anything that does not parse is "none". It counts only when the theme is one of the sixteen of the backgrounds: in any other theme an old value is let be (`MrBackdrop.lookNow` / `apply`, the screen and the row of the settings all go by this). |
| `pref_kbd_bg_soft` | How much a **gradient, a landscape or a picture** is softened, 0 to 70 (%). Colors ignore it. |

For a picture, the zoom is in per cent (100 to 400), the position goes from -100 (against the left or top edge) to 100 (against the right or
bottom one), and the time is when the picture was chosen, so a new picture is a new value and the caches know it. **Reset settings** puts the
three back (`MrReset.KEYS`).

## Where the backgrounds come from

- **Colors** (`MrBackdrop.COLORS`): sixteen plain colors, shown as they are (no veil: the color itself is the lower edge for the navigation bar).
- **Gradients** (`MrBackdrop.GRADS`): twenty dark ones, all from the top down (some with stops, two with a soft light in a corner), like the dark
  gradients of the GB examples without the brown and orange ones.
- **Landscapes** (`MrScenes`): thirty-six pictures kept in the app as WebP files, `assets/mr_scenes/<category>_<n>.webp`, six for each of the
  categories **Sports, Animals, Snow, Nature, Anime** and **AI** (`sports`, `animals`, `snow`, `nature`, `anime`, `ai`). They are cropped from the
  source sheets to the shape of the keyboard (about 500 px wide, quality 72, about 1.5 MB all together) and read from the assets (`MrScenes.load`),
  then drawn like a picture of the gallery: scaled to fill the keyboard, with the vertical position that suits each one (`MrScenes.FOCUS`) and the
  veil of the background. The screen shows them in six tabs, one for each category; the names are in `mr_strings.xml`.
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
softening and the theme of the backgrounds in one edit. **My image** (the card that appears in the Gallery tab when there is a picture, next to
the one that picks a photo and with a **Remove my image** button under them) opens the same crop on the picture that is kept, with the frame where it is now.

## Legibility: the veil

Whatever the background, the ink of the toolbar (the suggestions, the icons) has to stay readable. A **veil** of the opposite color is laid over a
gradient, a landscape or a picture: black under the white ink (`overlight`), white under the dark one. How dense it is comes from the background itself
(`MrBackdrop.look`): a small copy of it is measured, and the average brightness, over all of it **and over its upper part where the toolbar is**, must
end up no brighter than 0.40 under white ink and no darker than 0.62 under dark ink. The veil is never denser than 75% and, for a picture, never less
than the softening set with **Soften background** (a gradient, a landscape or a picture). A plain color has no veil.

`ThemesTest` runs it over every color, gradient and landscape and checks that the contrast of the ink of the toolbar with the bar is at least 3 to 1
in the worst case, and that of the letters with their keys at least 2.5 to 1, in the clear glass. It also checks that over every color and
gradient, in each of the themes of the backgrounds, the dash of the modifier keys has a contrast of 2.2 to 1 or more when on and when locked,
and 1.15 to 1 or more when off, with the key it is on.

## On the keyboard

`MrBackdrop.apply` (called by `MrTools.applyTranslucentBlur`, when the keyboard is made and when it is shown) puts a `MrBackdropDrawable` as the
background of the root of the toolbar, which holds the bar, the panels and the keys on the same sheet, and leaves the keyboard view clear (it
would paint the color of the theme over it). It does so only in one of the sixteen themes of the backgrounds. The drawable draws once for the size it has
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
drawable falls back to flat faces in its colors. The card in use has a frame in the accent color and a filled **In use** pill. A card of a background
is drawn with the theme of the backgrounds that suits it (the style in use is only in the dialog and in the keyboard at the top); a card of a theme is
the theme with no background.

The dialog of a theme, a color, a gradient or a landscape uses the **complete keyboard** (`setFull`): the row of tools, Ctrl, Alt, Tab, the arrows, the
numbers, the three rows of letters with shift and delete, and the bottom row (123, F1, space, period and enter), with the same proportions as
`kbd_qwerty.xml`. The highlight keys use the accent face of the theme. The keyboard is drawn **at rest**, as the real one is when nothing is pressed: no key is lit or locked (shift is not painted red; red is only for a real
Caps Lock), and only Ctrl, Alt and Shift have the **dash** under them, in the `modifier_indicator_off` color (no dash under the arrows or any other key). In the themes of the backgrounds these roles, and
those of the popups and key previews (`popup_*`, `key_preview_*`), are set in `make_themes.py` so that the dash is seen on any color, gradient or
landscape: in `overlight` (white ink) it is a light slate when off, white when on and amber when locked, in the styles with a hue the off dash is
a pale tone of the family, and in `overdark` (dark ink) a mid slate when off, a deep blue when on and a red when locked; the colors are opaque
because the keyboard draws the dash with the alpha of the keys. The key styles are listed in `OVER_GLASS`, `OVER_OUTLINE` and `OVER_GRADIENT` of `make_themes.py` (the edge roles `key_<state>_edge` are the
outline of the outline and gradient ones).

## Files

| File | What it is |
| --- | --- |
| `MrThemesActivity` | The screen (the current keyboard, the tabs, the cards) and its dialogs (a theme, a background with the softening and the styles, the crop). Nothing is kept in it: it reads the preferences, so it can be made again at any time. |
| `MrThemeRow` | The row of the settings: it opens the screen and says on its second line what is chosen (the theme, or the background when the theme is one of the sixteen of the backgrounds). |
| `MrThemePreview` | The small keyboard (at rest, as the real one: no key is lit or locked). |
| `MrStyleDot` | The dot of a colour of the styles of keys in the dialog (a chip of the colours of the style, with its name as the description). |
| `MrCropView` | The picture with the frame to drag and pinch. |
| `MrBackdrop`, `MrBackdropDrawable`, `MrScenes` | The background: the spec, the drawing, the veil, the waiting and the kept picture, the keyboard. |
| `MrThemeColors` | The colors and names of any theme (the one in use is `MrTheme`'s), which themes are hidden. |
| `docs/tools/themes_test/ThemesTest.java` | The test, with the real `res/` files. |

## Testing

`ThemesTest` (`docs/tools/run_java_tests.sh`) draws the previews with Java2D behind the `Canvas` stub and reads the pixels. Give it a folder as the
first argument and it dumps PNGs of the themes, of the colors, gradients and landscapes in their theme, of the complete keyboard, of the fifteen styles of
keys (`styles_big_*`, and the softening) over a landscape, a gradient and a colour, of the picture with several zooms and positions, and of the crop dialog, to look at.
The test double of the screen queues what the loading threads post to the main thread (`UI`, `pump()`, run by `waitFor`), and the posted steps of the
cards run with `stubRunPosted()`. The WebP files cannot be decoded on the PC: the stub gives a pattern of the size
the file says, unless `-Dmr.assets=<folder>` points to a folder with PNG copies named like the assets (`mr_scenes/sports_1.webp`…), whose real pixels
are then drawn. The real key faces are drawn by `KeyStyle` (smali) and are not in those pictures: how it looks on the
phone is for the person to try, with **Autocompletar** on and off.

New `android` calls (to check against the real API with `ANDROID_JAR` in CI, `check_stub_api.py`): `HorizontalScrollView.smoothScrollTo`,
`View.getLeft` / `setHorizontalScrollBarEnabled`, `TextView.setMinWidth`, `AssetManager.open`, `Context.getAssets`,
`BitmapFactory.decodeStream`, `Drawable.setState`, `Bitmap`, `BitmapFactory`, `LinearGradient`,
`RadialGradient`, `Matrix`, `Canvas.drawBitmap` / `clipPath` / `drawRect`, `ExifInterface`, `Dialog` / `Window.setGravity` / `setLayout`,
`Intent.setDataAndType` / `addCategory`, `SeekBar`, `MotionEvent.getPointerCount` / `getActionMasked`, `View.setScrollBarStyle` / `setScrollBarSize` /
`setScrollbarFadingEnabled` / `setVerticalScrollbarThumbDrawable` (API 29, guarded by `Build.VERSION.SDK_INT >= 29`), `ViewGroup.setClipToPadding`.

`ThemesTest` also audits the styles of keys (`styleAudit`): over every colour, gradient and landscape that has styles, in 120 places of the keyboard, the letters
of no style may read worse than the clear glass (the reference: its dark outline of the labels does the rest on a bright landscape), and the line of an outline or
gradient key must be a difference of colour (CIE Lab) of 14 or more from what is behind it in nine places out of ten.
