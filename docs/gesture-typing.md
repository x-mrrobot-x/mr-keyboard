# Gesture typing (experimental, off by default, since 1.96.0)

Gesture typing: the finger goes down on the first letter of a word, slides over the others and lifts on the last one, and the
keyboard writes the word. This file is the living description of the feature: what exists, how it works, what was measured and
what is left. Update it in the same commit that changes any of that.

## Where it stands

It was built in four stages, and all of them are in 1.96.0:

| Stage | What | State |
|---|---|---|
| 0 | Study and prototype outside the app: which recogniser, how well it does with the dictionaries of the app, what it costs | done |
| 1 | The recognition inside the native engine (`libmrengine.so`, contract 3), the Java class that drives it (`MrGesture`) and the tests at every level | done on the PC |
| 2 | The keyboard: reading the trace of the finger, telling a gesture from a tap, a long press and a fling, the trail, writing the word, the strip with the other candidates, the setting, the weights as a pack to download (or picked from a file), the "FUTO Swipe" notice, the time of a gesture shown in the settings | done; tried on a phone |
| 3 | The words of the person in the search (the ones the keyboard learned, the ones added by hand, the user dictionary of Android); a blocked word is never written; the word so far on the strip while the finger slides, with its setting; the two measurements behind those choices | done; tried on a phone |

**On a phone.** The code of stages 0 to 3 was written and tested outside this project (a parallel line of the keyboard) and
brought here as it was. Two readings from the phone of the owner of the project (model not told) are all that is known from a
device:
- An earlier build of that line, with stages 1 and 2 only (no words of the person, no word while sliding): "Recognition time"
  showed 9.3 ms for the last gesture, 9.4 ms on average and 10.2 ms for the longest of 21 gestures (the PC of these
  measurements takes 4.3 to 5.2 ms), and no false gesture showed up in fast typing by taps.
- **This release (1.96.0, 2026-11-12)**, with the libs of the workflow: the owner went through the items 1 to 20 of "To try on a
  phone before a release" and reported that **all of them passed**; the screen of the settings showed **10.4 ms** for the last gesture, **9.4 ms** on average and 10.4 ms for
  the longest of 26 gestures; **9.6 ms** on average and 17.1 ms for the longest of the recognitions made while the finger
  slid; **10 words** of the person known to the gestures, prepared in **0.2 ms**. The weights had been installed from a file
  (the release did not exist yet), so the download from the catalog of the published release (item 13) is still to be seen once
  it is published.

Everything else comes from a PC: the recognition on the PC and on the Android builds under an emulator, the keyboard code
against a fake Android. What only a device can show is listed in "To try on a phone before a release".

**The libs.** The four `libmrengine.so` are the ones built by `mr-native.yml` (the `commit:` line of `mrengine-info.txt`
says from which commit) and committed. A first build made by hand from the working tree, with the same NDK and options,
gave the same four files byte for byte; the same hand build of the untouched code of 1.93.0 also gave, byte for byte, the
eight libs the workflow had built for that version (the four `libjni_pckeyboard.so` are those, not rebuilt).

**Left out.** The **recorder of gestures** (the owner of the project decided: not now). The **trigrams in the score** and
**weights per language** were to enter only if a measurement showed a gain, and that measurement was **not made**: the trigrams
need files of gestures with two previous words and a search that reads `trigrams.bin`; for the weights, the real Spanish
gestures are few to tune four values on (1,761) and the Portuguese ones are synthetic. The **pairs the keyboard learned** from
the person as context for a gesture ("Known limits").

**What it changes for who uses the app.** With gesture typing off, which is how it comes: nothing on the keyboard (each of the
six calls added to its code returns on its first line; a seventh reads the setting when a dictionary is loaded; the tree of
learned words counts its changes, one addition each, for a copy nobody asks for while the setting is off). There is a new group,
**Gesture typing (experimental)**, in Settings, Suggestions and dictionaries. Turning it on asks for a download of 2.4 MB (the
weights); the APK does not carry them. With it on: the word is written by sliding the finger; the words the keyboard learned
from the person, the ones added in "Add words and texts" and the ones of the user dictionary of Android can be written too; a
word on the list of blocked words is never written nor offered; and the strip shows, while the finger slides, the word that
would be written if it lifted there (a setting, on by default, in the same group). The four `libmrengine.so` grew by 85,592,
60,780, 105,932 and 101,384 bytes (before compression) because of the recognition; the size of the whole APK was not measured
for this release (nothing is built where this was written).

## How it works

```
touch points (x, y, t)                      MrGesture.decode (Java)             the policy: values, spellings of the previous word
   -> resampled to 64 points                gestureResample                     60 points per second by time, then 64 by index
   -> neural network                        GestureNet (mr_gesture_nn.cpp)      32 steps x (keys + 1) log-probabilities
   -> search in main.dict                   GestureSearch (mr_gesture_decode.cpp)
   -> search in the words of the person     the same search, the same table (Gesture::more)
   -> up to 16 words, best first            MrGesture.Result
```

1. **The network** is the encoder of [FUTO Swipe](https://huggingface.co/futo-org/futo-swipe) (model `honorable_sturgeon`,
   633,988 values): for each of 32 steps along the trace it gives the probability that the finger meant each key, or no key at
   that step. The keyboard enters only as the list of the centres of its keys, so the same network serves any layout of up to 64
   keys: the standard, compact and full modes of the app, a layout with `ñ`, a tablet. It was trained by FUTO on English gestures
   only; it reads the geometry of the trace, not the language. The **weights** are FUTO's, under their own licence
   (`gesture/README.md`). The **code** that runs it (`engine/src/mr_gesture_nn.cpp`, about 500 lines of plain C++) was written
   for this project from the published graph: no ExecuTorch, no XNNPACK, no third-party library. It gives the numbers of the
   official runtime (table below).
2. **The search** finds, in the same `main.dict` the rest of the keyboard uses (no second word list, no file of its own), the
   words that best explain those probabilities. It keeps the 200 most promising **sequences of keys** at each step and adds up the
   probability of every way of aligning a sequence with the 32 steps (CTC). Each sequence carries the set of dictionary prefixes
   it writes, so the words that are one and the same gesture share one place: `esta` and `está` (accents, `ç` and `ñ` use the key
   of the base letter when the keyboard has no key for them), `the` and `The`, `of` and `off` (a doubled letter is passed over
   once), `dont` and `don't` (`'` and `-` take no key).
3. **The score** of a word is `logp + 0.075 * frequency + 2.9 * keys + 0.066 * bigram`: what the network says, how common the
   word is in the dictionary, a bonus per key (without it short words win over long ones) and how often the word follows the
   previous word of the text (the bigrams of `main.dict`). The values live in `MrGesture.java`, which hands them to the lib; they
   were tuned on the validation part of the public English gestures and are flat around those values. Two words with exactly the
   same score (same keys, same frequency: `governors` and `governor's`) come the shorter one first.
4. **The words of the person** are a second dictionary of the same format, a few kilobytes that `MrGestureWords`
   writes in memory from the words the keyboard learned, the ones added by hand and the user dictionary of Android. After
   the search in `main.dict`, the **same table** of the network is searched in it (`Gesture::more`: the network does not run
   again) and the two lists become one, by the same score. A word the two have, in any capitals, comes once, with the larger
   of its two scores. These words carry no pairs, so the previous word gives them no bonus.

## In the keyboard

`MrGestureInput` (Java, `docs/tools/java/src/.../MrGestureInput.java`) is everything around the recognition: which touches are
gestures, the trail, the text that goes to the app, the strip, the backspace and the word shown while the finger
slides. `MrGestureWords` is the copy of the words of the person that the recognition searches.

### When it is on
Two conditions, both read in `MrGestureInput.reload()`: the setting `pref_gesture_typing` is on (it is off by default) **and**
the weights are installed (`MrPacks.modelFile`). Then the lib opens the weights (2.8 MB of memory); when either condition
goes away the lib lets go of them. A listener follows the setting, and `MrPacks` calls `reload()` after it installs or removes
the weights. Android's backup carries the setting but not the weights (it covers only the default preferences and
`sheets.json`): a restored phone has the setting on and gesture typing off until the file is downloaded, and the settings
screen says so in red.

### Which touches are gestures
The rule, and the numbers behind it (tables in "What was measured"):

1. A touch **may** be a gesture when one finger goes down on a **letter key of the main keyboard** (letters layout, main
   sheet), with no popup open, no Ctrl, Alt or Meta switched on, no style of the Fonts tool chosen, in a plain text field
   (not a password, an address or an e-mail field, not a field that refuses suggestions), with the weights open and the
   dictionary of the language loaded. Anywhere else the touch is not looked at again.
2. While it only may be one, **every event still goes to the usual path**: the key is pressed, its preview shows, a tap types
   it exactly as before. One thing changes: the long press of that key waits at least **300 ms**
   (`LONG_PRESS_MIN`; the app's default is 200 ms, and 1.5% of real gestures are still within a quarter of a key of their
   start after 200 ms, 0.5% after 300 ms). A longer value chosen by the user is kept.
3. It **is** a gesture when the finger gets **0.7 key width** away from where it went down (`START_KEYS`; never less than
   22 dp, 3.5 mm). At that moment the usual path receives one cancel event (the key is let go without being typed, its
   timers stop, the detector of the slide actions forgets the touch) and from there to the last finger up every event is
   taken by `MrGestureInput`. So, with gesture typing on, a **slide action** only happens when the finger starts outside
   the letters (decided by the owner of the project).
4. A second finger before that point: not a gesture (typing with two thumbs is untouched). A second finger after it: ignored
   until the gesture ends.
5. Finger up: nothing is written when the finger lifted more than half a row outside the rows of letters (a slide that left
   the letters is not a word), when the search has no word, or when the best word has a `logp` under -30 (`MIN_LOGP`; it only
   stops absurd traces: `logp` cannot tell a word from a scribble, the geometry of rule 3 and of this rule does).
6. A word on the **list of blocked words** (`MrLearned.isBlocked`: "What the keyboard learned", Block) is passed over, as the
   word written and among the other candidates. The floor of rule 5 is then asked
   of the first word that is left.

Two-letter words are the cost of rule 3: in real gestures 0.5% of them never get half a key away from their start and 0.9%
never a whole key. Such a touch stays on the usual path, which types one letter, and the user types the word.

### What is written
The word goes in the way a tap on a suggestion does (`LatinIME.pickSuggestionManually`), so the rest of the keyboard sees
nothing new: same text path, same automatic space after the word, same learning of the pair with the previous word, same
handling of the punctuation that follows.
- A word being typed by taps is committed first, as it is; a word underlined for re-correction is left alone.
- A **space goes in before** the word when the text needs one (`needsSpace`): not at the start, after a space or a line
  break, after an opening sign or one that joins (`(`, `¿`, `/`, `@`, `#`, `-`...), nor after a quote that opens.
- **Capitals** follow the Shift key (`withCase`): on (tapped, or automatic at the start of a sentence) gives the first
  letter, locked gives the whole word.
- The **previous word** of the text goes to the search (the bigrams of the dictionary), read from the field itself.
- The **strip** then shows up to three other candidates, the best in the middle. A tap on one swaps the word in the text;
  the word that left takes its place on the strip. With "show suggestions" off the strip appears only for this (decided by
  the owner of the project). The strip lives in the toolbar: with the toolbar hidden nothing shows, as with any suggestion.
- **Backspace** right after a gesture removes the whole word and the space put before it. Any other key ends both (the
  strip goes back to what it shows between two words).
- The **trail** follows the finger in the accent colour of the theme, drawn over the keys in `LatinKeyboardView.draw`;
  only the rectangle around the new points is redrawn. `pref_gesture_trail` (on by default) turns it off.

The recognition runs on the thread of the keyboard when the finger lifts, so the word is in the text before the next key
is read. Its time is kept (`MrGestureInput.stats()`) and shown in the settings ("Recognition time": last, average, longest,
how many).

### The words of the person
`MrGestureWords` keeps, in memory, a dictionary of the `main.dict` format with the words of the person for the language in
use, and `MrGesture.decode` hands it to the lib as the second dictionary of each gesture.

- **Which words.** The keyboard keeps them in two trees (`ExpandableDictionary`): `AutoDictionary` has the words it learned
  from typing and the ones added in "Add words and texts"; `UserDictionary` has the user dictionary of Android and the
  learned words that were used often. From the first, a word counts from **frequency 6** on, the value from which the
  keyboard itself suggests it (a word typed once is more often a typo than a word); from the second, every word. A
  **blocked** word never goes in. Two spellings are two words (`Zeca` and `zeca`); the Shift key still decides the capitals
  of what is written.
- **Their frequency** in the copy goes from **100** (just learned) to **130** (used often, or added with the highest
  weight), in proportion to the frequency the keyboard keeps. Both ends were measured ("What was measured"): higher, and the
  words of `main.dict` start losing their place to them; lower, and the person's own words stay behind similar words of
  `main.dict`. The values are `FREQ_LOW` and `FREQ_HIGH` in `MrGestureWords.java`.
- **When the copy is made.** Only when something changed, on the thread of the keyboard, **when a touch becomes a gesture**
  (not when the finger lifts): 1.5 to 1.7 ms on the PC for 2,000 words ("Cost" has the other sizes and the 0.2 ms
  read on a phone for 10 words). What tells it that something changed: the first line of `ExpandableDictionary.addWord` and of
  `clearDictionary` (hand-edited smali) and `MrLearned.refreshBlocked` call `MrGestureWords.changed()`, which only adds
  one to a counter; and a change of language brings other dictionary objects.
  A tree that its loading thread is still filling is not read (`reloadDictionaryIfRequired()`, the question every search of
  the keyboard asks first): the copy there is stays in use, or none when it would be the one of another language, and the
  next gesture tries again. At most 10,000 words (`MAX_WORDS`; the ones of the highest frequency stay).
- **No pairs.** The copy has no bigram lists: a word of the person gets nothing from the previous word, while a word of
  `main.dict` may get up to 8.4 points from it. The pairs the keyboard learned (`UserBigramDictionary`) are not used by
  the gestures.

### The word while the finger slides
With `pref_gesture_preview` on (it is, by default) the strip shows the word that would be written if the finger lifted at
that moment.

- About every **120 ms** (`PREVIEW_MS`) the trace so far goes through the whole recognition, as if the finger had lifted
  there, and the best word that is not blocked goes to the strip, **alone** (one word sits in the middle), in the capitals
  the Shift key will give it. The same word again leaves the strip untouched; no word, or one under the floor of rule 5,
  leaves what is shown.
- It is spaced by its own cost: the next one never comes sooner than **6 times** what the last one took (`PREVIEW_LOAD`),
  so these recognitions take a sixth of the thread at most and a slow phone shows the word less often instead of letting
  the trail fall behind the finger.
- When the finger **stops**, no touch event comes; a delayed task then recognises the trace up to where the finger is, once.
- The previous word of the text is read **once per gesture** for this (a question to the app each time would cost more
  than the recognition). What is written is decided when the finger lifts, with a fresh reading and the whole trace: the
  preview changes nothing in it (`GestureInputE2E` draws every gesture with and without it and compares the text).
- A gesture that **writes nothing** gives the strip back: the other candidates of the gesture before, if they are still
  pending; else what `LatinIME` would show (`mrStrip(null)`: the suggestions of the word being typed by taps, or the
  predictions of the next word).
- A **tap on that word** (another finger) does nothing: it is not a suggestion to pick, the finger lifting writes it.
- The strip lives in the tool bar, in the place of the tools, so showing a word there does not move the keys. When it
  cannot be seen **nothing is recognised** until the finger lifts (`stripInView()`): the bar hidden or another bar in its
  place (`MrTools.sBarMain` not visible). With the tools in the row (the debounce of `pref_sugg_idle` gave it back to
  them) the preview goes on, and its first list brings the strip back (`LatinIME.mrStrip` counts as typing for `MrSugg.onList`).
- How often the word shown is the final one is in "What was measured": early in the gesture it rarely is; it settles in
  the last quarter.

### The calls from the keyboard
Seven static calls: six in hand-edited smali, each of which returns at once when gesture typing is off, and one in Java
(`MrPacks.mainDictionary`), which reads the setting and, the first time, registers the listener that follows it.
`MrGestureInput` catches whatever is thrown inside any of them (a fault there never stops typing: a touch that was not yet a
gesture goes on as a plain one, one that was already cancelled on the usual path is swallowed to the end).

| Where | Call | What for |
|---|---|---|
| `LatinKeyboardView.onTouchEvent`, first line | `onTouch(view, event)`; true = taken | following the touch |
| `LatinKeyboardView.draw`, last line | `draw(view, canvas)` | the trail |
| `PointerTracker.startLongPressTimer` | `longPress(ms)` | the 300 ms of rule 2 |
| `LatinIME.pickSuggestionManually`, first line | `onPick(ime, index, word)`; true = it was a candidate of the gesture | the swap |
| `LatinIME.handleBackspace`, first line | `onBackspace(ime)` | the whole word |
| `LatinIME.onKey`, first line | `onKey(ime, code)` | ending what is pending |
| `MrPacks.mainDictionary` (Java) | `init(context)` | reading the setting when the keyboard loads a dictionary |

Two small methods were added to `LatinIME` for it: `mrSuggest()` (the engine of the language in use, for its main
dictionary) and `mrStrip(list)` (puts words on the strip, creating it if "show suggestions" never did).

More hand-edited smali, for the words of the person and for giving the strip back:

| Where | What | What for |
|---|---|---|
| `ExpandableDictionary.addWord`, first line | `MrGestureWords.changed()` | a word of the person was added or its frequency changed |
| `ExpandableDictionary.clearDictionary`, first line | `MrGestureWords.changed()` | the tree is thrown away (a reload) |
| `ExpandableDictionary.mrRoots()` (new) | returns the first level of the tree | reading every word and its frequency |
| `Suggest.mrAutoDict()`, `Suggest.mrUserDict()` (new) | return the two dictionaries of the person | finding the trees |
| `LatinIME.mrStrip(null)` | with a word being typed by taps, `updateSuggestions()` instead of `setNextSuggestions()` | giving the strip back after a gesture that wrote nothing |

`changed()` is one atomic addition and cannot throw; it runs whether gesture typing is on or off. `MrLearned.refreshBlocked`
(Java) calls it too.

### The weights: a pack of the catalog, or a file
The APK does not carry the weights. They are a **pack**, like a dictionary, made from `gesture/` (`pack.json`, `encoder.bin`,
the licence text, `NOTICE.txt`): `mr-keyboard-model-gesture-<version>.zip`, 2,374,557 bytes, attached to the release where
its version changed.
- **In the catalog** it is an entry of a second list, `"models"`, next to `"packs"`. The apps before 1.96.0 read only `packs`
  and ignore every other key, so the same signed `catalog.json` serves them unchanged; this was checked by running the
  `MrPacks` of 1.93.0 (the one 1.94.0 has too) on a catalog made by the new tool. Inside `packs` the entry would have made those apps refuse the
  whole catalog (every entry of `packs` must be a language with a `main.dict`). Without `--model` the tool writes no
  `models` key at all.
- **In the app** (`MrPacks`) it goes through the same code as a dictionary: signed catalog, size and SHA-256 of the zip
  and of each file, nothing extracted that the catalog does not list, the folder swapped only at the end. It is installed
  in `files/models/gesture/<version>/` and its state is `model.gesture` in the `mr_packs` preferences. Before the swap
  `checkModel` asks that the weights start with `MRSWENC1` and that the licence text came with them. An entry of `models`
  this version cannot read (another id, a missing field) is skipped; one that needs a newer app or another format shows
  "needs a newer version of the app".
- **From a file** (`MrPacks.installModelFile`, the button "From a file"): the user picks `gesture/encoder.bin` on the
  device and nothing is downloaded. Only a file whose SHA-256 is in `MrPacks.MODEL_FILES` is taken, so what ends up
  installed is byte for byte what the catalog brings; the licence text is written next to it from the copy in the APK
  (`res/raw/mr_futo_license.md`). This is how a version is tried on a phone **before** its release exists (the app only
  reads the catalog of the latest release, which has no weights until 1.96.0 is published), and what a device that cannot
  reach GitHub uses.
- **The settings** (`MrPacksActivity`, the group "Gesture typing (experimental)" of `res/xml/prefs_suggestions.xml`): the
  options (on or off, the trail and the word while sliding), the row of the file (state, download, update,
  remove), "Recognition time" (with the recognitions made while sliding and how many words of the person the
  gestures know), and the notice. The row of the file
  never connects on a tap: without a stored catalog that has the weights, a dialog says what will be downloaded and from
  where, and only its Download button connects (it fetches the catalog and then the file); with one, the dialog is the
  one of a language, with Download or Update. Installing the weights does not turn the option on, and does not touch
  "show suggestions". "Restore defaults" (`MrReset.KEYS`) turns the option off and leaves the file.
- **The notice**: the licence of the weights asks for a visible notice that the product is powered by "FUTO Swipe"
  technology. It is the last row of the group, always there, with or without the file: one line that does nothing when
  tapped. The text of the licence travels with the pack (`LICENSE-FUTO-Model-Weights.md`, `NOTICE.txt`).

## The pieces

| Path | What it is |
|---|---|
| `engine/src/mr_gesture.h` | the contract of this part: limits, the frame of the coordinates, the classes |
| `engine/src/mr_gesture_nn.cpp` | the weights file (reader with every check), the resampling, the network |
| `engine/src/mr_gesture_decode.cpp` | the reader of `main.dict` for gestures (formats v1 and v2), the search, `Gesture` (what the JNI uses) |
| `engine/src/mr_jni.cpp` | `nGestureOpen`, `nGestureClose`, `nGestureConfig`, `nGestureLayout`, `nGesture`, `nGestureMore` |
| `docs/tools/java/src/.../MrGesture.java` | the values, which weights file is open, the layout, the previous word, the results, the second dictionary |
| `docs/tools/java/src/.../MrNative.java` | the bridge (`gestureOpen`, `gestureClose`, `gestureConfig`, `gestureLayout`, `gesture`, `gestureMore`); `ENGINE_VERSION = 3` |
| `gesture/` | the weights (`encoder.bin`), their licence, and in `gesture/test/` the data of the tests |
| `engine/test/mr_gesture_test.cpp` | the C++ tests, and `eval` to measure any file of gestures; also `words` (the words of the person at several frequencies) and `partial` (what a part of a gesture gives) |
| `engine/test/run_android_tests.sh` | the same tests on the Android builds of the code, under an emulator |
| `engine/test/java/.../JniSmoke.java` | the JNI bridge: bad arguments, real gestures through the JNI |
| `docs/tools/e2e/GestureTest.java`, `run_gesture_tests.sh` | the same through the APK's own classes |
| `docs/tools/native_test/NoLibTest.java` | without the lib nothing throws |
| `docs/tools/gesture/` | how every file of `gesture/` was made, byte for byte |
| `docs/tools/java/src/.../MrGestureInput.java` | gesture typing in the keyboard: the touch, the trail, the text, the strip, the backspace, the time |
| `smali/.../LatinKeyboardView.smali`, `PointerTracker.smali`, `LatinIME.smali` | the calls to `MrGestureInput` (hand-edited smali, table above), `mrSuggest()`, `mrStrip()` |
| `docs/tools/java/src/.../MrPacks.java` | the `models` list of the catalog, the weights installed from the pack or from a picked file |
| `docs/tools/java/src/.../MrPacksActivity.java`, `res/xml/prefs_suggestions.xml` | the settings group: the two options, the file, the time, the notice |
| `gesture/pack.json`, `gesture/NOTICE.txt` | what makes `gesture/` a pack: id, version, format, the oldest app, the files that go in the zip |
| `res/raw/mr_futo_license.md` | the licence of the weights inside the APK (the same bytes as `gesture/LICENSE-FUTO-Model-Weights.md`) |
| `docs/tools/make_catalog.py --model gesture` | the zip of the weights and the `models` list of the catalog |
| `docs/tools/gesture_input_test/GestureInputTest.java` | `MrGestureInput` against a fake keyboard, text field and recognition |
| `docs/tools/e2e/GestureInputE2E.java`, `run_gesture_input_tests.sh` | from touch events to text with the real recognition |
| `docs/tools/packs_test/ModelPackTest.java`, `make_model_fixtures.py` | the pack of the weights through the classes of the APK: catalog, download, checks, update, remove, a picked file |
| `docs/tools/java/src/.../MrGestureWords.java` | the words of the person as a second dictionary: which words, their frequency, the writer of the format, when the copy is made again |
| `smali/.../ExpandableDictionary.smali`, `Suggest.smali`, `LatinIME.smali` | the two calls to `MrGestureWords.changed()`, `mrRoots()`, `mrAutoDict()`, `mrUserDict()`, `mrStrip(null)` with a word being typed (hand-edited smali, table above) |
| `docs/tools/java/stubs/.../ExpandableDictionary.java`, `MrSugg.java` | compile and test stubs of what `MrGestureWords` and the preview read in the hand-written classes (`check_stub_api.py` compares them with the smali) |
| `docs/tools/gesture_input_test/GestureWordsTest.java` | `MrGestureWords` alone: the dictionary written is read back by a reader of the format |

### The frame of the coordinates
Keys and touch points use the same frame: **x** = 0 at the left edge of the keyboard and 1 at the right edge; **y** = 0 at the
top of the first row of letters and 1 at the bottom of the last row of letters. In the standard keyboard the three rows of
letters are at y = 1/6, 1/2 and 5/6; the centres of `res/xml/kbd_qwerty.xml` in this frame are those of the QWERTY layout the
model was trained on (largest difference 0.0005). A touch may be outside the frame (y < 0 over the number row).

### The native functions (contracts 2 and 3)
| Function | What |
|---|---|
| `nGestureOpen(path)` | reads the weights file (once: nothing stays mapped) and checks it; a failed open leaves it closed |
| `nGestureClose()` | frees the weights and the work memory (the layout stays) |
| `nGestureConfig(float[6], int[3])` | the scoring values and the limits (`MrGesture.params()`, `limits()`); refused if out of range |
| `nGestureLayout(char[] keys, float[] xy, char[] free)` | the letter of each key, its centre, the characters that take no key |
| `nGesture(dict, size, n, x[], y[], t[], prev[], prevLen[], outWords, outInfo, outScores)` | the words of a gesture: 0 to 16, or -1 if it cannot answer |
| `nGestureMore(dict, size, prev[], prevLen[], outWords, outInfo, outScores)` | The gesture of the last `nGesture` searched in another dictionary of the same format; what is found is merged into its results and the arrays get the merged list. `outInfo[0]` counts the entries read in both searches; `outInfo[1]` is a mask (bit i: result i came from this dictionary). -1, with the arrays untouched, when there is no gesture to search (none answered since the weights or the layout were set) or the arguments are refused |

Nothing changed in the functions of contract 1 (`nSearch`, `nTri*`), nor, with contract 3, in those of contract 2. The
gesture has a mutex of its own: a gesture does not hold up a correction search on another thread. `nGestureMore` uses what
`nGesture` left, so `MrGesture.decode` makes the two calls under one lock of its own.

## What was measured

All on the PC (one core of a 2.6 GHz Xeon) unless said otherwise, with the dictionaries of `dicts/` and the values above. "First"
and "among 3" are over the gestures whose word is in the dictionary; two words that differ only in upper and lower case count as
one. Commands at the end.

### How often the right word comes
| Gestures | Dictionary | Counted | First | Among 3 | Among 10 |
|---|---|---|---|---|---|
| English, **real**, the test part of the public dataset (683 sessions) | en-US | 46,955 | **93.39%** | **98.17%** | 99.16% |
| the same without the previous word | en-US | 46,955 | 92.69% | 97.94% | 99.13% |
| English, **real**, a later collection of the same dataset (`swipe-5`, gathered after the model was trained) | en-US | 24,001 | 93.03% | 97.87% | 98.93% |
| Spanish, **real**, layout with `ñ` (29 sessions) | es | 1,761 | **94.09%** | **98.92%** | 99.43% |
| the same without the previous word | es | 1,761 | 93.07% | 98.64% | 99.43% |
| Portuguese, **synthetic**, standard keyboard of the app | pt-BR | 8,152 | 95.57% | 98.61% | 99.09% |
| the same without the previous word | pt-BR | 8,152 | 93.95% | 98.11% | 99.04% |
| Portuguese, synthetic, compact keyboard (`kbd_compact.xml`) | pt-BR | 8,152 | 95.45% | 98.59% | 99.06% |
| Portuguese, synthetic, full keyboard (`kbd_full.xml`) | pt-BR | 8,152 | 92.54% | 97.74% | 98.52% |

- **There are no public real gestures in Portuguese.** The Portuguese rows are an estimate: made-up traces whose knobs were set so
  that English synthetic gestures are recognised as often as the real gestures of the same words (within 0.9 point in six
  comparisons made in stage 0). Real gestures taken from English and Spanish and re-labelled with the Portuguese words that have
  the same keys gave 96.6% and 97.1% first (384 and 452 gestures). Only real use will tell (a recorder of gestures: "What is left").
- The words the dictionary does not have (3.5% of the English gestures, 4.2% of the Spanish ones) cannot come: a gesture only
  writes dictionary words. Counting them as errors: English 90.1% first.
- For comparison, the paper of the model reports 92.94% / 97.46% on English with its own English word list and decoder, and
  80.05% / 90.47% for the classic shape-matching method (SHARK2).
- The full keyboard loses three points: its keys are narrower (14 columns).

### The words of the person
What frequency should a word of the person have in the second dictionary? `mr_gesture_test words` answers with the public
gestures: the words of a file that `main.dict` lacks stand for what a person taught the keyboard. They all go into a second
dictionary with one frequency, every gesture of the file is searched in both dictionaries, and two things are counted: how
often those words now come out, and how many words of `main.dict` lose the first place to one of them.

English, the whole test part of the dataset: 46,955 gestures of words `main.dict` has, 1,705 of words it lacks (1,636
different words: the second dictionary, 43 KB).

| Frequency in the second dictionary | Words of the person: first | among 3 | Words of `main.dict`: first | that lost the first place | Right words gained, per 1,000 gestures |
|---|---|---|---|---|---|
| none (`main.dict` alone) | 0 | 0 | 93.39% | | |
| **100** | **90.56%** | 98.01% | 93.35% | 19 (0.04%) | **+31.3** |
| **130** | **95.31%** | 99.18% | 93.17% | 102 (0.22%) | **+31.3** |
| 160 | 97.18% | 99.59% | 92.63% | 357 (0.76%) | +26.7 |
| 200 | 98.24% | 99.65% | 90.53% | 1,340 (2.85%) | +6.9 |

With fewer words the price is lower and the best value a little higher: the first 8,000 gestures of the same file (292
gestures of 284 words) and the Spanish gestures (78 gestures of 75 words; 1,761 of words `main.dict` has):

| Frequency | English, 284 words: first / among 3 | lost by `main.dict` (of 7,640) | Spanish, 75 words: first / among 3 | lost by `main.dict` (of 1,761) |
|---|---|---|---|---|
| 30 | 69.5% / 84.6% | 0 | 69.2% / 93.6% | 0 |
| 60 | 79.1% / 91.8% | 0 | 88.5% / 97.4% | 0 |
| **100** | 89.4% / 96.2% | 0 | 97.4% / 100% | 0 |
| **130** | 91.8% / 98.3% | 3 | 98.7% / 100% | 0 |
| 160 | 94.2% / 99.3% | 10 | 100% / 100% | 1 |
| 200 | 96.9% / 99.7% | 36 | 100% / 100% | 3 |
| 250 | 98.6% / 100% | 190 | 100% / 100% | 19 |

- Hence **100 to 130** (`MrGestureWords.FREQ_LOW`, `FREQ_HIGH`): in that range the words of the person come first nine times
  in ten or more and `main.dict` loses next to nothing; above it every word gained costs one or more of `main.dict`.
- What this measurement cannot say: in it every word of the person is one that somebody wrote by gesture, and all have the
  same frequency. A real copy also has words the person never writes by gesture (each one is one more word that can take
  the place of another) and its frequencies go from 100 to 130. The rows with 1,636 words are the pessimistic end.
- The second search costs 0.65 ms per gesture with 75 words, 0.77 with 284 and 0.93 to 1.05 with 1,636, on the PC (the
  network and the first search took 5.2 to 5.9 ms in the same runs).
- A word lost by `main.dict` is still on the strip: among 3, `main.dict` goes from 46,095 to 46,083 (frequency 100) and
  46,065 (130) of 46,955.

### The word while the finger slides
`mr_gesture_test partial` cuts each gesture at some fractions of its duration and recognises each part as if the finger had
lifted there (the gestures of `gesture/test/` whose word is in the dictionary: 281, 277 and 300; `main.dict` alone):

| Part of the gesture drawn | en-US: the first word is the one of the whole gesture | es | pt-BR (synthetic) |
|---|---|---|---|
| 25% | 16.4% | 25.6% | 8.0% |
| 50% | 22.4% | 28.2% | 12.3% |
| 75% | 49.1% | 50.9% | 43.3% |
| 90% | 80.8% | 80.9% | 83.7% |

| Following each gesture every 120 ms | en-US | es | pt-BR |
|---|---|---|---|
| Mean duration of a gesture | 999 ms | 1,064 ms | 1,116 ms |
| Words shown per gesture | 7.8 | 8.3 | 8.8 |
| Times the word changes | 3.6 | 3.6 | 4.8 |
| The last word shown before the finger lifts is the final one | 90.0% | 87.7% | 92.3% |
| The final word shows, and stays, from this part of the duration on | 74% | 74% | 78% |
| Time of a recognition of a part (PC) | 5.1 ms | 5.0 ms | 5.1 ms |

- The word shown is, for most of the gesture, **not** the word that will be written: half a word is another word, or the
  beginning of several. It becomes the final word in the last quarter of the gesture. This is what the preview is: what
  lifting the finger now would write. It is not a prediction of the word being drawn.
- A recognition of a part costs what a whole one costs (the longest of some 3,600 took 9 to 26 ms in different runs, on a
  machine that was doing other things), so a gesture of one second costs about seven more recognitions spread along it.
  On the phone of the owner, where a whole one took 9.4 ms, that is an estimate of 10 ms every 120 ms; the spacing rule
  (`PREVIEW_LOAD`) keeps that share from growing on a slower phone. Read on that phone ("Recognition time"): these
  recognitions took 9.6 ms on average and 17.1 ms the longest.
- Through the keyboard code (`GestureInputE2E`, the clock of the fake Android following the gesture, the words of the
  person included): 6.9, 7.2 and 7.2 recognitions per gesture; 287 of 296, 262 of 283 and 283 of 290 gestures showed a word
  (in the others the finger lifted before the first recognition was due, or the part drawn gave no word); the last word
  shown was the word written in 261, 241 and 273 of them (91%, 92%, 96%). The text written and the other candidates are
  the same with and without the preview, gesture by gesture.

### The same answers as the prototype, as the official runtime, on every architecture
| Check | Result |
|---|---|
| The network against the official runtime (ExecuTorch 1.6.0 + XNNPACK), 201 real gestures | largest difference of probability 0.00017 (PC), 0.00014 (arm64 build, emulated); the most likely key is the same in 6,432 of 6,432 steps |
| The engine against the stage-0 prototype, gesture by gesture | same place of the right word in 48,655 of 48,660 English gestures and 1,838 of 1,839 Spanish ones; the other 6 are exact ties (`governors` / `governor's`, `llevo` / `llevó`), which the prototype ordered by accident and the engine orders by rule |
| PC, arm64-v8a, armeabi-v7a, x86, x86_64 (the Android builds run as static executables, the ARM ones under qemu-user) | the same counts on the 900 gestures of `gesture/test/` |
| Through the JNI and through the APK's classes (the app's real letter tables) | the same counts |
| Dictionary format v1 and v2 (a 100,000-word English dictionary written in both by `build_dict.py`) | identical words, places and scores on 5,967 real gestures |

### In the keyboard: from touch events to text
`GestureInputE2E` draws the 300 gestures of each language in `gesture/test/` again as touch events on a fake keyboard of
1080 pixels (finger down, one move per recorded point, finger up) and reads the fake text field. `MrGestureInput` and the
recognition are the real ones; `LatinIME` and Android are not.

| Language | Words written | Right first | Right among the first 3 | Right among the 4 the keyboard shows (the word and its 3 alternatives) | `GestureTest` on the same file (first / among 3) |
|---|---|---|---|---|---|
| en-US | 296 | 256 | 271 | 274 | 256 / 272 |
| es | 283 | 260 | 276 | 277 | 260 / 276 |
| pt-BR | 290 | 280 | 285 | 287 | 288 / 294 |

The same test draws each language twice more. With **the words of the person**: every word of the file is a
word the keyboard learned (frequency 6 in its tree, so 100 in the copy `MrGestureWords` writes), which is the path of the
app from the tree to the lib. And with **the word so far on the strip** (numbers in the section before).

| Language | Right first, `main.dict` alone | With the words of the person | Right among 3, alone | With the words of the person |
|---|---|---|---|---|
| en-US (17 of its words are not in `main.dict`) | 256 | 275 (19 more, none fewer) | 271 | 292 |
| es (7 are not) | 260 | 268 (8 more, none fewer) | 276 | 284 |
| pt-BR (all are) | 280 | 280 | 285 | 285 |

The first-word counts are the ones of the recognition alone for English and Spanish, so the frame of keys and points that
`MrGestureInput` hands over is the right one. The Portuguese difference (280 against 288) is not the frame: 10 of the 300
synthetic Portuguese traces start outside every letter key (on Shift, the backspace, the digits or the space row), and the
keyboard, by rule 1, does not take those as gestures. 3 to 5 ms per gesture on the PC (it changes with what else the
machine is doing), the event handling included.

### Behind the rules of the touch
Measured on the public real gestures (English and Spanish), before the rules were written.

How long a real gesture stays near where the finger went down (581 gestures; share still within the distance after the time):

| Distance from the start | 100 ms | 150 ms | 200 ms | 300 ms |
|---|---|---|---|---|
| 0.25 key | 18.8% | 4.5% | 1.5% | 0.5% |
| 0.50 key | 28.2% | 6.5% | 2.1% | 0.7% |
| 0.75 key | 37.2% | 10.3% | 3.8% | 0.9% |
| 1.00 key | 46.5% | 14.6% | 5.3% | 1.7% |

- How far a real gesture goes from its start (48,660 English gestures): a word of 2 keys stays under 0.5 key in 0.47% of
  them and under 1.0 key in 0.92%; of 3 keys, never under 0.90; of 4 or more, never under 1.07. Hence 0.7.
- Where the finger lifts: between -0.10 and 1.09 of the height of the block of letters in every gesture measured (the
  highest point of a trace was -0.47). Hence half a row of margin (0.17 of a block of three rows).
- `logp` as a filter, on 53,298 right answers and 1,800 traces that are no word (flings, scribbles, straight lines): under
  -30 loses 10 right answers (0.019%) and stops 61% of the vertical flings and at most 5% of the rest; under -20 loses 0.30%.
  It cannot separate a word from a scribble, which is why the rules above are about geometry.

**None of these numbers says how many taps of fast typing become false gestures**: there is no public data of taps with
their finger movement. 0.7 key is far more than a finger rolls during a tap, but only use on a phone will tell. On the one
phone where the earlier build of the keyboard side was in use, its owner reported no false gesture; item 6 of "To try on a phone before a release" (fast typing by taps, with one and with two thumbs) passed on this release.

### Cost
| | |
|---|---|
| Time per gesture on the PC | 4.3 ms: the network 2.5 to 3.0 ms, the search 1.3 to 1.4 ms. With words of the person, 0.7 to 1.0 ms more for the second search |
| Time on a phone | **9.4 ms** on average on the one phone it was read from (the owner's, model not told). This release, with the words of the person (10 of them) and the word while sliding on: last 10.4, longest 10.4, 26 gestures. The earlier build that had neither: 9.3 last, 9.4 on average, 10.2 longest, 21 gestures. The estimate made before was 5 ms on a fast core and 20 to 25 ms on a slow one |
| The word while sliding | about 7 recognitions more per gesture of one second, each the cost of a whole one, never more than a sixth of the thread; none when the strip is out of view or the setting is off. On the phone of the owner: 9.6 ms on average, 17.1 ms the longest |
| The copy of the words of the person | made when a gesture begins, only after a change (a word of the person typed or written, a word blocked, another language). On the PC, read from the tree and written: 0.5 ms for 500 words (14 KB), 1.5 to 1.7 ms for 2,000 (54 KB), 7 to 8 ms for 10,000, the ceiling (242 KB). That is Java code after the JVM compiled it; run by the interpreter alone it took 6, 22 and 104 ms. On the phone of the owner: 0.2 ms for 10 words; bigger lists were not measured there ("Recognition time" shows it, "prepared in") |
| Weights | 2,537,110 bytes on disk, 2.8 MB on the heap while open (read once, not mapped); opening and checking the file takes 2.5 to 3.5 ms on the PC |
| Work memory of the search | 0.7 to 0.8 MB, kept between gestures so that a gesture allocates nothing; a corrupt dictionary can make one gesture take up to about 8 MB, given back as soon as it is answered |
| Dictionary entries read per gesture | at most 12,512 in every gesture measured; ceiling 60,000 (`MrGesture.NODE_BUDGET`) |
| `libmrengine.so` | arm64-v8a 352,976 bytes, armeabi-v7a 214,632, x86 355,028, x86_64 358,456. Before gesture typing (1.93.0 and 1.94.0): 267,384, 153,852, 249,096, 257,072 |
| Beam 100 / 200 / 400 (validation set) | first 93.48 / 93.66 / 93.69%, among 3 97.86 / 98.15 / 98.32%; search 0.8 / 1.4 / 2.4 ms |

## What is tested, and where
| What | How | Where |
|---|---|---|
| The weights file | the real one opens; cut at 371 points, with a byte too many, another magic, any tensor renamed or resized, any value that is not a number: refused, nothing crashes; absurd but finite weights still give only log-probabilities between -100 and 0 | `mr_gesture_test`, in CI, also with ASan + UBSan |
| The network | the numbers of the official runtime on 201 real gestures, within a tolerance | `mr_gesture_test`, in CI |
| The search, alone | hand-made tables on a hand-made dictionary in both formats: doubled letters, `'` and `-`, accents, a key of its own for `ñ`, upper and lower case, the previous word, a character with no key, a 2-byte character, ties, the limits, the dictionary of older apps, a dictionary that points to itself | `mr_gesture_test`, in CI |
| Real gestures | 300 per language (`gesture/test/`): the counts of right words must not fall under their floors; a gesture gives the same answer whatever came before it | `mr_gesture_test`, `JniSmoke`, `GestureTest`, in CI |
| Corrupt dictionary | cut, swapped bytes, garbage: no crash, no read outside the file, no freeze, the ceilings hold, the memory is given back | `mr_gesture_test` (with ASan + UBSan), `JniSmoke`, in CI |
| Absurd input | no points, too many, NaN, huge values, times that go back, a 33-second scribble | `mr_gesture_test`, in CI |
| Bad arguments in the JNI | non-direct buffer, short or null arrays, lengths that do not match | `JniSmoke`, in CI |
| The ARM code | the gesture test on the arm64-v8a and armeabi-v7a builds under qemu-user | `run_android_tests.sh`, in CI (mr-native.yml) |
| The app's classes | `MrGesture` over `MrNative` over the lib, the app's letter tables, opening in the background, closing and opening | `GestureTest` (`run_gesture_tests.sh`), in CI (mr-checks.yml) |
| No lib | `MrGesture` answers -1 and throws nothing | `NoLibTest` (`run_java_tests.sh`), in CI |
| The keyboard code, alone | 176 of the 244 checks of `GestureInputTest` (the rest are below), with a fake view, text field and recognition: off by default and nothing followed while off; each condition of rule 1; a tap and a long press unchanged; the cancel sent once to the usual path; two fingers; the trace handed over in the right frame (history points included); the finger lifting outside the letters; the space, the capitals, the previous word; the strip and the swap; backspace; any other key; the trail and its redraw rectangles; the time kept; an exception inside never leaving it nor typing a key | `GestureInputTest` (`run_java_tests.sh`), in CI |
| From touch to text | the table above; the counts must not fall under their floors | `GestureInputE2E` (`run_gesture_input_tests.sh`), in CI |
| The stubs against the real classes | every method and field that `MrGestureInput` and the settings screen use in the hand-written classes (`LatinIME`, `LatinKeyboardView`, `Keyboard`, `KeyboardSwitcher`, `MrTools`...) exists in the real smali with that signature, is not private there, and is static or not as the code uses it; the same for what they use of `android.*` (methods and fields), against the SDK jar | `check_stub_api.py`, in CI (corrected in 1.96.0: it reported nothing on the APK side and looked at no field) |
| The pack of the weights | the zip and the `models` list (27 checks: reuse, serial, every error of a model pack); the release end to end with a fake `gh` (11 checks: attached once, kept in its release afterwards, a zip that did not upload) | `test_make_catalog.py`, `publish_test/run.sh`, in CI |
| The pack in the app | 66 checks through the classes of the APK and the PC lib: the catalog, a cancelled, tampered or cut download, weights with another magic, a licence of a few bytes, an extra file, a newer app or format, install, update, remove, the lib opening the installed file, "restore defaults", a picked file (only the known one is taken, 16 MB read at most, no network request), and that the table of known files, the licence in the APK and the size said in the dialog agree with `gesture/` | `ModelPackTest` (`run_packs_tests.sh`), in CI |
| The second dictionary in the lib | `Gesture::more` on hand-made and real data: `main.dict` cut in two halves and searched one after the other gives the list of the whole one; each result says which dictionary it came from; a word both have, in the same or in other capitals, comes once with the larger score; a weaker copy changes nothing; no dictionary, an empty one, one of digits: the results stay; -1 and the results untouched when there is no gesture to search (after open, close, a new layout, a refused gesture) or the values are refused; 16 results at most; a **corrupt second dictionary** (cut, swapped bytes, garbage): no crash, no read outside, the lists stay valid, the memory limit holds; real gestures: of the 17 words of the English file that `main.dict` lacks, 16 come first and 17 among 3, and the 256 right answers of `main.dict` stay | `mr_gesture_test` (355 checks; also ASan + UBSan, and the Android builds under qemu), in CI |
| `nGestureMore` through the JNI | bad arguments (non-direct or null buffer, sizes, short or null arrays, a previous word longer than its array): -1 and the arrays as they were; the mask; 20 buffers of garbage; the 300 English gestures with every word of the file in the second dictionary: 276 first and 293 among 3 (256 and 272 without) | `JniSmoke` (178 checks), in CI |
| The words of the person, Java | `MrGestureWords` alone, 52 checks: the dictionary it writes is read back by a reader of the format written for the test (20,000 words, accents, `'`, a 2-byte letter, one word in two spellings); which words go in (frequency 6 and up from the learned ones, all of the user dictionary, no blocked word, the higher frequency when both trees have it); the frequency 100 to 130; made again only after a change (a word added, the tree cleared, a word blocked or unblocked, other dictionary objects); a tree still loading is not read; the ceiling of words | `GestureWordsTest` (`run_java_tests.sh`), in CI |
| The same through the APK's classes | the real `ExpandableDictionary` of the APK (hand-edited smali): every `addWord` and `clearDictionary` tells `MrGestureWords`, `mrRoots()` gives the words back with their frequency; then the lib searches the dictionary `MrGestureWords` writes: 276 and 293 in English (256 and 272 without), 268 and 284 in Spanish (260 and 276), Portuguese unchanged; the floors are on those gains | `GestureTest` (`run_gesture_tests.sh`, 104 checks), in CI |
| The keyboard code, the words of the person and the word while sliding | The other 68 checks of `GestureInputTest`. Blocked words: passed over as the word written and among the candidates, in any capitals, the floor asked of the first one left, all blocked writes nothing. The word while sliding: none before 120 ms nor sooner than 120 ms after the last, none sooner than 6 times the cost of the last, the finger stopped, the same word leaves the strip alone, the capitals, a blocked word, a word under the floor, the text read once per gesture, a gesture that writes nothing gives the strip back (to the candidates of the gesture before, or to `LatinIME`), a tap on that word does nothing, the setting and its listener, the strip out of view (four ways) means no recognition while sliding, its recognitions counted apart, a fault in it never stops the gesture | `run_java_tests.sh`, in CI |
| From touch to text, with the words of the person and the word while sliding | The other 33 of the 54 checks of `GestureInputE2E`: each language drawn again with the words of the person and with the word while sliding (the text written must be the same with and without it), with floors | `run_gesture_input_tests.sh`, in CI |
| The libs in `lib/` | the four `libmrengine.so` export `nGestureMore`, say contract 3 and are the ones `mrengine-info.txt` lists; the hash of `engine/` is the one in `mrengine-src.sha256` | `mr-native.yml`, `mr-apk.yml` |

**On a phone** the owner of the project used this release and an earlier build (see the top of this file); none of the checks of this table is a test on a device. The ARM libs were run
under an emulator, which checks their answers and not their speed. `engine/README.md` ("On a phone") says how to run the same
test executables on a device with `adb`. What the PC tests of the keyboard cannot reach: the smali that calls
`MrGestureInput` and `MrGestureWords` (it assembles, the dex verifier and the register check pass, it was read line by line,
and `GestureTest` runs the hooks of `ExpandableDictionary` from the APK's own classes; the ones in `LatinIME`,
`LatinKeyboardView`, `PointerTracker` and `Suggest` are run by no test), the real `LatinIME.pickSuggestionManually` and
`mrStrip`, the real strip (`MrSugg`, `CandidateView`), the real touch events of a screen, the drawing, and the settings
screen itself.

## Known limits
- **A word the keyboard has not learned yet is not recognised.** A word of the person counts once the keyboard itself
  would suggest it: typed by taps about six times (each time adds 1, a pick from the strip adds 3, and 6 is the threshold),
  or added in "Add words and texts", which counts at once. Until then a gesture cannot write it.
- **The words of the person get nothing from the previous word**, and the pairs the keyboard learned are not used by the
  gestures: the context of a gesture is only the pairs of `main.dict`.
- **A word of the person can take the place of a similar word of `main.dict`**: 0.04% to 0.22% of the gestures in the
  measurement with 1,636 such words, none with 284 at the lowest frequency. The word that lost is on the strip.
- **The copy of the words of the person is made on the thread of the keyboard**, when a gesture begins, after each change.
  On the phone of the owner it took 0.2 ms for 10 words; a list of thousands of words was not measured there ("Recognition time" shows it).
- **The word while sliding is what lifting the finger now would write**, not a guess of the word being drawn: for most of
  the gesture it is another word. It needs the strip in view: nothing shows with the tool bar hidden or with another bar in
  its place (with the tools in the row after the debounce, the first word brings the strip back).
- **While the finger slides the strip shows only that word**: the suggestions that were there come back if the gesture
  writes nothing, and are replaced by the other candidates if it writes a word.
- **Only the letters keyboard, main sheet.** Not the symbol sheets, not the popup of a long press, not the extension row.
  Not in password, address and e-mail fields, nor in fields that refuse suggestions (rule 1).
- **One key is a tap**, and a two-letter word between neighbouring keys may not travel the 0.7 key of rule 3.
- **Fast typing by taps with the finger rolling far** could become a gesture. Not measured (no data); none was reported from
  the phone where the earlier build of the keyboard side was in use.
- **The alternatives need the toolbar**: the strip lives in it, so with the toolbar hidden only the first word is seen.
- **With "show suggestions" off the pair with the previous word is not learned** (`LatinIME.checkAddToDictionary` returns
  early), as for any word picked from the strip.
- **After a tap on a word of the text** (re-correction in progress) the gesture word is written without its automatic space,
  because `pickSuggestionManually` is then in its correcting branch.
- **The recognition runs on the thread of the keyboard**: once when the finger lifts (9.4 ms on the one phone it was read
  from; slower phones not measured) and, with the word while sliding on, about every 120 ms during the gesture, never for
  more than a sixth of the time.
- **The search always answers with what it has.** A scribble over the letters that ends over the letters writes a word.
- **Letters from U+0100 on** only match a key with the same letter (the table of base letters, `MrText.base`, covers Latin-1).
  The three dictionaries have none.
- **Upper and lower case** is not the recognition's business: `The` and `the` are two results; `MrGesture.Result.distinct` keeps
  the better one, and the Shift key decides how it is written.
- The network was trained on English gestures. Spanish real gestures do as well as English ones; Portuguese is an estimate (above).

## To try on a phone before a release
The owner went through items 1 to 20 below on this release, on one phone, and all of them passed (see the top of this file). The
list stays here for the next version that touches gesture typing. `mr-apk.yml` publishes on a push to `main` when the version is new, so
the way to try a version first is: push to another branch, run "Mr Keyboard - APK" by hand on it (without "publish") and
install the signed APK from the artifacts over the one in use. The weights stay installed across the update; on a phone
without them, the app downloads them from the catalog (it has them since the release of 1.96.0) or takes
`gesture/encoder.bin` with **From a file**.

Items 1 to 13 are the ones of the keyboard side; items 14 to 20 are the ones of the words of the person and the word while
sliding. The numbers of "Recognition time" after 26 gestures, 10 words of the person and the word while sliding are in the top of
this file. Item 13 was done with the weights installed from a file; the download from the published catalog remains to be seen.

1. With the setting **off**: typing, long press, the slide actions, the language switch on the space bar, the sheets. Nothing
   may differ from 1.94.0.
2. Turn it on without the file: the dialog; "Not now" leaves the row in red; **From a file** installs; "Recognition time"
   says "Ready".
3. Words of 2, 3 and many letters, in the three languages; the space; a capital at the start of a sentence, with Shift
   tapped and with Shift locked; punctuation right after a word.
4. The strip: the other candidates show (toolbar visible), a tap swaps the word, and with "show suggestions" off the strip
   shows only for this.
5. Backspace right after a gesture; backspace after another key.
6. **Fast typing by taps**, with one and with two thumbs: no false gesture, no letter lost.
7. Long press on a letter (the accents popup now takes 300 ms where it took 100), on a key outside the letters (unchanged).
8. The slide actions starting outside the letters (they must work, the language switch on the space bar among them) and
   starting on a letter (they must not).
9. The trail: every theme, with and without hardware acceleration ("Advanced"), no leftover after the finger lifts.
10. Rotation, the three keyboard modes (standard, compact, full), the keyboard heights, a layout with `ñ`.
11. A password field, an address bar, the symbol sheets, a style of the Fonts tool chosen, Ctrl switched on: no gesture.
12. "Recognition time" after some gestures: this is the number stage 1 could not measure.
13. Update the weights from the catalog once 1.96.0 is published; remove them; "Restore defaults".
14. **A word of yours.** Add a made-up word in "Add words and texts" and write it by gesture; type another made-up word by
    taps some six times (until the keyboard suggests it) and write it by gesture. "Recognition time" then shows "Words of
    yours that gestures know" and in how long they were prepared: **this is a number no PC could give**.
15. **A word of the user dictionary of Android** (Settings of the phone, personal dictionary), by gesture.
16. **A blocked word.** Block a word in "What the keyboard learned" and draw it: another word is written, and the blocked
    one is not among the alternatives. Unblock it: it comes back.
17. **The word while sliding**, tool bar visible: it shows on the strip and changes as the finger goes; the keys do not move
    when it appears; the trail does not fall behind the finger; stop the finger half-way: the word catches up; lift the
    finger above the letters (nothing written): the strip goes back to what it showed. "Recognition time" shows the line
    "Word while sliding": the average and the longest are the other numbers to read.
18. The same with the tool bar hidden (the key of the tool bar) and with the setting off: no word while sliding, and the gesture
    writes as before. With the tools in the row after the debounce, the first word of the preview brings the strip back.
19. A tap, with another finger, on the word shown while sliding: nothing happens.
20. Another language (the space bar): a learned word of that language by gesture; the words of the other language do not
    come.

## What is left
- **The download of the weights from the catalog of the published 1.96.0** (item 13), and the times that only a phone gives for
  bigger lists: the copy of the words of the person was read for 10 words only (0.2 ms), and the PC says 7 to 8 ms for 10,000.
- **A recorder of gestures** in a test version, to check the rules of the touch and the Portuguese numbers with real gestures
  (the files can use the format of `gesture/test/`, which `mr_gesture_test eval` reads). Planned for stage 2, left out by the owner of the project.
- **The pairs the keyboard learned** as context of a gesture, and a bonus of the previous word for the words of the person.
- **The trigrams in the score.** Not measured: the files of gestures keep one previous word (`make_samples.py` would have to
  keep two; the dataset has the sentences) and the search would have to read `trigrams.bin`. Without the measurement
  nothing was built.
- **Weights per language** (the four values of the score). Not measured either: the real Spanish gestures are few to tune
  four values on (1,761) and the Portuguese ones are synthetic, so a tuning would fit the sample and not the language. With
  the same values the three languages are within about two points of each other (93.4%, 94.1% and, synthetic, 95.6% first).
  Real Portuguese gestures (the recorder) are what this needs.
- **False gestures in fast typing**: none was reported from the phone where the earlier build of the keyboard side was in use, nor in item 6 of the phone checklist on this release. If they happen, the options
  are a larger `START_KEYS`, a speed condition, or the time since the last tap (what AOSP does:
  `GestureStrokeRecognitionParams`).
- The recognition and the copy of the words **off the thread of the keyboard**, if the times on real phones ask for it
  (9.4 ms per gesture and 9.6 ms for the word while sliding on the one phone known do not).
- A word near the finger instead of on the strip (the owner chose the strip); the gesture on the symbol sheets.

## Running it
```bash
# C++ tests on the PC (from the project root)
cmake -S engine -B build/engine -DCMAKE_BUILD_TYPE=Release -DMR_HOST_TEST=ON && cmake --build build/engine -j4
./build/engine/mr_gesture_test dicts gesture/encoder.bin gesture/test 100

# the same on the Android builds, the ARM ones under qemu-user
bash engine/test/run_android_tests.sh $ANDROID_HOME/ndk/27.2.12479018

# the JNI bridge
javac -d build/jc engine/test/java/com/mrkeyboard/app/*.java
java -cp build/jc com.mrkeyboard.app.JniSmoke build/engine/libmrengine.so dicts gesture/encoder.bin gesture/test

# through the APK's classes (builds the temporary APK; needs APKTOOL_JAR and DEX2JAR)
bash docs/tools/e2e/run_gesture_tests.sh

# the keyboard code: alone (with the other PC tests of the Java layer), then from touch events to text with the real recognition
sh docs/tools/run_java_tests.sh
bash docs/tools/e2e/run_gesture_input_tests.sh

# the pack of the weights: the catalog tool, a release end to end, and the app's side (needs the jar of the assembled APK)
python3 -I docs/tools/test_make_catalog.py
bash docs/tools/publish_test/run.sh
bash docs/tools/packs_test/run_packs_tests.sh <app_jar.jar>

# the zip of the weights by hand (what a release attaches)
python3 -I docs/tools/make_catalog.py --dicts dicts --model gesture --out /tmp/out --tag v1.96.0

# measuring a whole set (docs/tools/gesture/README.md says how to get the dataset)
python3 docs/tools/gesture/make_samples.py --jsonl DS/test.jsonl --layout-json DS/swipe-5/layouts/qwerty.json --out /tmp/en_test.tsv
./build/engine/mr_gesture_test eval dicts/en-US/main.dict gesture/encoder.bin /tmp/en_test.tsv

# the words of the person at some frequencies (the words of the file that main.dict lacks become the second
# dictionary; -1 = every gesture of the file; about 5 minutes per frequency on the whole English set), and what a part of
# a gesture gives (120 = one recognition every 120 ms)
./build/engine/mr_gesture_test words dicts/en-US/main.dict gesture/encoder.bin /tmp/en_test.tsv -1 100 130 160 200
./build/engine/mr_gesture_test partial dicts/en-US/main.dict gesture/encoder.bin gesture/test/gestures_en-US.tsv -1 120
```

## Changing things
- A **scoring value** or a limit (`MrGesture.java`): Java only; the lib receives it. Run `run_gesture_tests.sh`: the floors say
  whether words were lost. Regenerate the smali (`docs/tools/build_java.sh`).
- The **algorithm** (`engine/src/mr_gesture*.cpp`): add the case to `mr_gesture_test.cpp`, build the libs
  (`docs/native-engine.md`), and raise `kEngineVersion` and `ENGINE_VERSION` if a native function changed.
- The **weights**: another file means another `gesture/encoder.bin.sha256`, new reference vectors (`make_vectors.py`) and, if
  the values are not the published ones, the notice of modification the licence asks for. For the pack: raise `version` in
  `gesture/pack.json` (the catalog tool refuses a changed content with the same version), add the new SHA-256 and version
  to `MrPacks.MODEL_FILES`, and correct the size in the three `mr_gesture_need_pack` strings; `ModelPackTest` fails until
  the three agree. A file the current lib cannot read needs a new `format` in `pack.json` and `MrPacks.MODEL_FORMAT`, so that
  older apps do not download it.
- A **rule of the touch** (`START_KEYS`, `LONG_PRESS_MIN`, `END_MARGIN_ROWS`, `MIN_LOGP` in `MrGestureInput.java`): Java only.
  `GestureInputTest` has a case for each; `run_gesture_input_tests.sh` says whether words were lost. Regenerate the smali.
- The **frequency of the words of the person** (`FREQ_LOW`, `FREQ_HIGH`, `LEARNED_MIN`, `MAX_WORDS` in
  `MrGestureWords.java`): Java only. Measure first with `mr_gesture_test words` on a whole set (the table of "What was
  measured" is the reason for the values); `run_gesture_tests.sh` and `run_gesture_input_tests.sh` have floors on what the
  words of the person gain. Regenerate the smali.
- The **word while sliding** (`PREVIEW_MS`, `PREVIEW_LOAD` in `MrGestureInput.java`): Java only; `mr_gesture_test partial`
  with another step says how many words a gesture would show. `GestureInputTest` has the cases.
- What **`MrGestureWords` reads** in the hand-written classes: the fields of `ExpandableDictionary$Node` and `$NodeArray`
  (through `mrRoots()`), `Suggest.mrAutoDict()` and `mrUserDict()`. A new place that changes a tree of words without going
  through `ExpandableDictionary.addWord` or `clearDictionary` must call `MrGestureWords.changed()`, or the gestures keep
  the old copy.
- The **calls from the smali**: they are hand-edited; `python3 docs/tools/smali_regcheck.py smali` and `verify_dex.sh` after any
  change (the first also tells when a hook names a method of `MrGestureInput` that is gone).
- What **`MrGestureInput` calls in the hand-written classes** (`LatinIME`, `LatinKeyboardView`, `Keyboard`, `KeyboardSwitcher`,
  `MrTools`...) goes through the stubs of `docs/tools/java/stubs`, and a stub can say what the real class does not: a method
  or a field it does not have, has with another type, has as private or has as static compiles, assembles and only fails on
  the device. `check_stub_api.py` (with `ANDROID_JAR`) compares every such use with the real smali; run it after
  `build_java.sh`. Until 1.96.0 it reported nothing on that side (its header says why), and it was corrected because gesture
  typing depends on it: 9,662 uses of methods and fields of the APK's classes and 2,396 of `android.*` are checked now.
- The **licence text**: `res/raw/mr_futo_license.md` and `gesture/LICENSE-FUTO-Model-Weights.md` are the same bytes
  (`ModelPackTest` checks it).
- A **floor** only goes down with the reason written next to it.
