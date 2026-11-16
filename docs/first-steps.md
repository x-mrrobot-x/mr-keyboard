# First steps: set the keyboard up

A new keyboard has to be turned on in Android and chosen as the one to type with, and the suggestions and gesture typing, which are on by
default, need two files that are **not** in the APK: the dictionary of the language of the phone and the gesture recognition file (about
2.4 MB). The first steps are a short screen that does all of it, one step at a time, so the person does not have to find *Settings →
Suggestions and dictionaries* or the keyboard list of Android by themselves.

Code: `MrTour` (the rules and the download) and `MrTourActivity` (the screen), both in `docs/tools/java/src` (Java layer). Texts in
English, Portuguese and Spanish (`mr_tour_*` in `mr_strings.xml`).

## The steps

The screen shows **Step 1 of N** (N is 1 to 4), a bar with one segment per step and one step at a time. Only the steps that still have
something to ask are shown:

| Step | Shown when | Buttons |
|---|---|---|
| **Turn on Mr Keyboard** (`enable`) | Mr Keyboard is not in the list of keyboards that are turned on in Android | **Open keyboard settings** (the keyboard list of Android) |
| **Type with Mr Keyboard** (`select`) | it is not the keyboard in use (always there when the step above is) | **Choose keyboard** (the picker of Android) |
| **Word suggestions** (`dict`) | suggestions are on and no dictionary is installed | **Download** (the dictionary of the language of the phone), **Turn off suggestions** |
| **Gesture typing** (`gesture`) | gesture typing is on and its file is not installed | **Download** (the file, about 2.4 MB; the "FUTO Swipe" notice is in the text), **Turn off gesture typing** |

Delete by word is on by default and needs nothing, so it has no step.

The two steps of Android read the system, they never connect: the list of keyboards that are on (`InputMethodManager`) and the setting
`default_input_method`. They need no permission. The screen follows the answer by itself: when the person comes back from the keyboard
settings, or the picker closes, the step turns green ("Turned on", "In use") and the button becomes **Continue**. If Android cannot be asked,
the step counts as done, so that nothing holds the person.

While a download runs, the main button is its progress bar ("Downloading… 42%"). When it ends the step shows a green check and
**Continue** (**Finish** on the last step). If it fails, the step shows the reason and **Try again**; if the language of the phone has no
dictionary, the button opens the screen of the dictionaries (**Choose language**).

**Skip** (top right) and the Back key close the screen. Nothing is turned off by closing it.

## When it opens

From the main screen of the app (`Main.onCreate`, after the update notice), when at least one step is left, and it is shown **once**:

- With only downloads left it is marked as done as soon as it starts. Skipping, finishing, or closing it never brings it back. Phones
  that update from an older version and never touched the options see it once too, because the options count as on until the person
  changes them. A phone where the keyboard is in use and everything is downloaded (or turned off) never sees it.
- While the keyboard is not turned on and chosen, it comes back at every opening of the app (there is nothing to type with otherwise).
  It is marked as done when the person closes it, or when they get past the two steps of Android.

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
the settings. Turning a step off, skipping, the two steps of Android and opening the screen use no network. After the download the dictionary
is on the keyboard languages of the person (`MrPacks.syncLanguages`) and the suggestions are on.

## The screen

Plain views built in code with `MrKit`, in the palette of the settings; no layout file. From top to bottom: "Step 2 of 4" and **Skip**; the
bar; the step **in the middle of the screen** (a round icon with a ring that pulses while the step waits for the person, the title, the text
and a chip with the state); and, at the bottom where the thumb is, the main button, the quiet one and a short note. A step too tall for
the screen (a phone on its side, big text) scrolls and the buttons stay. On a tablet the column is 440 dp wide, in the middle.

Motion follows Material: the step leaves to the left (160 ms) and the next comes from the right (340 ms), because an onboarding moves along the
horizontal axis; the segment of the new step fills; the first step settles in item by item; the icon turns into a check with a small bounce
when the step is done; the buttons shrink a little under the finger. It all runs on the animators of the system, so *Remove animations* in
Android turns it off (the ring then stays still and never loops).

## Tests

| What | Where |
|---|---|
| The rules: which steps, the keyboard read from Android, when it opens (once, again while the keyboard is off, not again after a close), the system language table, the choices | `docs/tools/tour_test/TourTest.java` (`run_java_tests.sh`) |
| The screen run on the PC against the stubs of Android (it says and does what it should at each step: the counter, the chip, the button and its action, the follow-up when the person comes back from the settings or the picker, the progress of a download, a failure and Try again, Skip, the end, a screen rebuilt). It has no drawing and no clock, so it cannot show how it looks or moves | `docs/tools/tour_test/TourScreenTest.java` (`run_java_tests.sh`) |
| The wiring: the manifest, the call in `Main`, the defaults, the steps of Android, the design rules of the screen (centred, buttons out of the scroll, horizontal axis, no loop without animations), the texts in the three languages, the network only in `MrTour.work`, the docs | `docs/tools/test_tour.py` |
| The downloads of the steps: the dictionary of pt-BR, es-MX, en-GB, fr-FR and ja-JP phones, the gesture file, no pack, no file, HTTP 404 | `ThreeLangTest`, `ModelPackTest` (`docs/tools/packs_test`) |

How the screen looks and moves can be seen only on a phone. To try it, clear the data of the app and turn Mr Keyboard off in Android (or install on a phone
that does not have it), open the app and go through each step: the keyboard settings and back, the picker, the download with its
progress, **Turn off**, **Skip**, turning the phone, the airplane mode (the reason and **Try again**), a phone in a language other than
the three (the English dictionary), and "Remove animations" in the developer options.
