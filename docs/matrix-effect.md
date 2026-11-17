# Matrix effect of the settings screens

Letters that fall behind the settings screens, in the colour of the theme (the accent of the app, `mr_accent`; the head of every drop is that colour made lighter). It is a setting of the **Advanced** screen, in the category **Screens**, **off by default**: *Matrix effect* (`pref_ui_matrix`, in the three languages). "Restore defaults" turns it off.

## Where it shows

- **Which screens:** the settings screens, that is every `PreferenceActivity` of the app (the settings, the pages of the keyboard settings, the AI settings, the dictionaries) and the home screen (`Main`). The word screens, the tour, the Sheets editor and the helper windows do not get it (`MrMatrix.eligible`).
- **Where on the screen:** it is the **window background** (`MrRainDrawable`), so it is drawn behind everything. The rows of the settings are cards with their own colour and cover it; the letters show around them, behind the header and the category titles and behind the bars.
- **Colour:** the flat background of the screens (`mr_ui_bg`) and the letters over it in `mr_accent`; the trail fades away from the head.

## How it works

- `MrRain` is the model, with no Android in it: one drop per column (a head that goes down a row every 1–3 beats, with a trail of 6–22 rows behind it that fades); a drop that has left the bottom comes back after a random wait with another length and speed; a few glyphs change in every beat (the flicker).
- `MrRainDrawable` draws it. It asks for its own beats (80 ms apart, about 12 a second: the drops move in whole rows, so more would only cost battery) with `scheduleSelf`; when the window is hidden (`setVisible(false)`) the beats stop, and they start again on the first draw after it is shown. The glyphs are digits, capitals and signs, plus the half-width katakana when the font has them (`Paint.hasGlyph`, asked once), so there is never a "missing character" box.
- `MrMatrix` decides who gets it and puts it on; `MrScreens` calls it when a screen is created. The effect asks for **hardware acceleration of the window** (the letters are animated; drawn by the processor the whole window would be painted again at every beat). Android only takes that flag when the window is created, so a screen that is already open is **created again** when it comes back after the setting changed (`onActivityResumed`), and the Advanced screen at once (`onSetting`). The manifest is unchanged (`hardwareAccelerated="false"` for the app).
- A failure of any kind (no window, colours that cannot be read, preferences that cannot be opened) leaves the screen as it was: a decoration must never stop a screen from opening. A screen whose rain could not be put is not created again and again: what it was made with is kept and compared.

## Tests

- `docs/tools/screens_test/MatrixTest.java` (in `run_java_tests.sh`): the drops, trails, return and flicker of `MrRain`; what `MrRainDrawable` paints (colours, faintness, columns), the beats and their stop when hidden; which screens get it; the screen at creation (rain and acceleration), after a change of the setting and in the failure cases.
- `res_check.py`: the setting (off by default, after the acceleration, before the read-only rows), the texts in the three languages, the reset list.

## Test on the phone

Advanced → Screens → *Matrix effect* on: the Advanced screen opens again with the letters falling in the blue of the theme, around and behind the cards, and the header. Go back to the other settings screens: they have it too. Turn it off: the letters stop and the flat background is back. Leave the app and come back: the letters keep falling. Do it with the keyboard's *Autocompletar* on and off (the effect does not touch the keyboard).
