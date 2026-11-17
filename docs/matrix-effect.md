# Matrix effect of the settings screens

Letters that fall behind the settings screens, in the colour of the theme (the accent of the app, `mr_accent`; the head of every drop is that colour made lighter). It is a setting of the **Advanced** screen, in the category **Screens**, **off by default**: *Matrix effect* (`pref_ui_matrix`, in the three languages). "Restore defaults" turns it off.

## Where it shows

- **Which screens:** the settings screens, that is every `PreferenceActivity` of the app (the settings, the pages of the keyboard settings, the AI settings, the dictionaries) and the home screen (`Main`). The word screens, the tour, the Sheets editor and the helper windows do not get it (`MrMatrix.eligible`).
- **Where on the screen:** it is the **window background** (`MrRainDrawable`), so it is drawn behind everything. The cards (the rows of the settings, the hero card, and on the home screen the header card, the shortcuts and the other cards) are **see-through** while the effect is on, so the letters show a little behind them; the letters also show around the cards, behind the category titles and the bars. The bar at the top of the settings screens stays solid.
- **Home screen (Main):** same as the settings screens: the rain behind it and see-through cards. Its root has no background of its own while the effect is on.
- **Colour:** the flat background of the screens (`mr_ui_bg`) and the letters over it in `mr_accent`; the trail fades away from the head.

## How it works

- `MrRain` is the model, with no Android in it: one drop per column (a head that goes down a row every 1–3 beats, with a trail of 6–22 rows behind it that fades); a drop that has left the bottom comes back after a random wait with another length and speed; a few glyphs change in every beat (the flicker).
- `MrRainDrawable` draws it. It asks for its own beats (80 ms apart, about 12 a second: the drops move in whole rows, so more would only cost battery) with `scheduleSelf`; when the window is hidden (`setVisible(false)`) the beats stop, and they start again on the first draw after it is shown. The glyphs are digits, capitals and signs, plus the half-width katakana when the font has them (`Paint.hasGlyph`, asked once), so there is never a "missing character" box.
- `MrMatrix` decides who gets it and puts it on; `MrScreens` calls it when a screen is created. The effect asks for **hardware acceleration of the window** (the letters are animated; drawn by the processor the whole window would be painted again at every beat). Android only takes that flag when the window is created, so a screen that is already open is **created again** when it comes back after the setting changed (`onActivityResumed`), and the Advanced screen at once (`onSetting`). The manifest is unchanged (`hardwareAccelerated="false"` for the app).
- A failure of any kind (no window, colours that cannot be read, preferences that cannot be opened) leaves the screen as it was: a decoration must never stop a screen from opening. A screen whose rain could not be put is not created again and again: what it was made with is kept and compared.

## See-through cards

The cards do not know about the effect: the rows (`mr_ui_pref_row*.xml`, `mr_ui_pref_hero.xml`) and `main.xml` take their card from the theme (`?attr/mrCard`, `mrCardFlat`, `mrHero`, and `mrScreenBg` for the root of the home screen), declared in `res/values/mr_attrs.xml`.

- `Theme.MrKeyboard.Settings` (and the home theme, its child) gives the solid ones (`mr_ui_card_ripple`, `mr_ui_card_shape`, `mr_ui_hero_bg`, `mr_ui_bg`): with the effect off nothing changes.
- The style `MrMatrixGlass` gives the see-through ones (`*_glass` drawables, the same files with only the fill changed to `mr_ui_card_glass`, the card colour at about 63%, `#a00d1626`; `mrScreenBg` clear). `MrMatrix.attach` lays it over the theme of the screen (`getTheme().applyStyle`, forced) while the screen is being created, before the layouts are inflated; that is why the effect creates the screen again when the setting changes. A build without the style only loses the see-through cards.
- To make the cards more or less see-through change the alpha of `mr_ui_card_glass` (`res/values/mr_colors.xml`; `MatrixTest` and `res_check.py` keep it between 40% and 80%, so the text stays readable). The danger rows were already see-through and stay as they are.

## Tests

- `docs/tools/screens_test/MatrixTest.java` (in `run_java_tests.sh`): the drops, trails, return and flicker of `MrRain`; what `MrRainDrawable` paints (colours, faintness, columns), the beats and their stop when hidden; which screens get it; the screen at creation (rain, acceleration and the see-through style, the home screen included), after a change of the setting and in the failure cases; the files (attributes, solid and see-through values, drawables, rows, `main.xml`, alpha of the card).
- `res_check.py`: the setting (off by default, after the acceleration, before the read-only rows), the texts in the three languages, the reset list; every `?attr/mr...` used by a layout is declared and has a solid value in the settings theme and a see-through one in `MrMatrixGlass`, and only the settings rows and the home screen use them.

## Test on the phone

Advanced → Screens → *Matrix effect* on: the Advanced screen opens again with the letters falling in the blue of the theme, around the cards and a little visible through them (the text stays readable). Go back to the other settings screens and to the home screen (Main): they have it too. Turn it off: the letters stop and the flat background is back. Leave the app and come back: the letters keep falling. Do it with the keyboard's *Autocompletar* on and off (the effect does not touch the keyboard).
