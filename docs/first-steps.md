# First steps: download what the keyboard needs

Suggestions, gesture typing and delete by word are on by default, but the first two need files that are **not** in the APK: the
dictionary of the language of the phone and the gesture recognition file (about 2.4 MB). The first steps are a short screen that
asks for them, so the person does not have to find *Settings → Suggestions and dictionaries* by themselves.

Code: `MrTour` (the rules and the download) and `MrTourActivity` (the screen), both in `docs/tools/java/src` (Java layer). Texts in
English, Portuguese and Spanish (`mr_tour_*` in `mr_strings.xml`).

## The steps

The screen shows **Step 1 of N**, a bar with one segment per step, one card per step and the buttons. Only the steps that still have
something to ask are shown, so N is 1, 2 or 3:

| Step | Shown when | Buttons |
|---|---|---|
| **Suggestions** (`dict`) | the suggestions are on and no dictionary is installed | **Download** (the dictionary of the language of the phone), **Turn off suggestions** |
| **Gesture typing** (`gesture`) | gesture typing is on and its file is not installed | **Download** (the file, about 2.4 MB; the "FUTO Swipe" notice is in the text), **Turn off gesture typing** |
| **Delete by word** (`word`) | delete by word is on, and only if one of the steps above is shown | **Keep on** (or **Keep on and finish** on the last step), **Turn off** |

While a download runs the button is disabled and shows the progress; when it ends the step shows a green status and **Continue**
(**Finish** on the last step). If it fails, the step shows the reason and **Try again**; if the language of the phone has no
dictionary, the button opens the screen of the dictionaries (**Choose language**).

**Skip** (top right) and the Back key close the screen. Nothing is turned off by closing it.

## When it opens

It opens **once**, from the main screen of the app (`Main.onCreate`, after the update notice), when at least one step has something to ask,
and then it is marked as done: skipping, finishing, or closing it never brings it back. A person who installs the app and has nothing to
download (everything turned off, or already installed) never sees it. Phones that update from an older version and never touched these
options see it once too, because the options count as on until the person changes them.

There is no row in the settings to open it again: the same downloads are in *Settings → Suggestions and dictionaries*, and the suggestion
strip offers **Download dictionary** while the dictionary is missing.

## The language

The dictionary is the one of the system language (`Locale.getDefault()`). For Portuguese, English and Spanish it is the pack of the
language and the country when there is one (pt-BR, es-MX...), else the first pack of the language. For **any other system language the
English pack is used** (en-US when there is one), because the keyboard has dictionaries only for these three. If the catalog has no
English pack, the step says so (`mr_tour_dict_nopack`) and offers the screen of the dictionaries.

## Network

The first steps never connect by themselves. The only request is the one that starts when the person taps **Download** or **Try again**
(`MrTour.download` → `MrTour.work`): the signed catalog and then the file, from the repository's latest release, checked the same way as in
the settings. Turning a step off, skipping and opening the screen use no network. After the download the dictionary is on the keyboard
languages of the person (`MrPacks.syncLanguages`) and the suggestions are on.

## Tests

| What | Where |
|---|---|
| The rules: which steps, when it opens (once, and not again if it fails to start), the system language table, the choices | `docs/tools/tour_test/TourTest.java` (`run_java_tests.sh`) |
| The wiring: the manifest, the call in `Main`, the defaults, the texts in the three languages, the network only in `MrTour.work`, the docs | `docs/tools/test_tour.py` |
| The downloads of the steps: the dictionary of pt-BR, es-MX, en-GB, fr-FR and ja-JP phones, the gesture file, no pack, no file, HTTP 404 | `ThreeLangTest`, `ModelPackTest` (`docs/tools/packs_test`) |

The screen itself runs only on a phone. To try it: clear the data of the app (or install fresh), open it, and go through each step: the
download with its progress, **Turn off**, **Skip**, turning the phone, the airplane mode (the reason and **Try again**), a phone in a language
other than the three (the English dictionary).
