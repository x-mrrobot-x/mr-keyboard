#!/bin/sh
# PC tests of the Java layer that do not need the APK (run at the project root):
#   - compiles the stubs (docs/tools/java/stubs) and the sources (docs/tools/java/src), like build_java.sh;
#   - AuthorTest: author card and main-screen link (MrAuthor, MrLink).
#   - RecorrectTest: word under the cursor, which words get suggestions and neighbour keys (MrRecorrect).
#   - DigitTest: a digit typed for the letter under it on the number row: what space may replace on its own (MrFuzzy.digitSlip: "obr8gado",
#     "5udo" yes; "teste1", "mp3", "9h" no), no suggestion with another number ("mp3": no MP4), and the lone digit that starts a word (MrDigitStart).
#   - RecentTest: recent words in the prediction and when completing (MrRecent).
#   - NoLibTest: without libmrengine.so (native engine, 1.77) the search answers no results and the trigrams nothing, with no exception (since 1.87.0 there is no Java search); and the search kept for the dictionary is let go (MrFuzzy.release, stage 4 part 2).
#   - UpdateTest: the notice of a new version (MrUpdate): signature, every field, versions, replay, checking windows,
#     notes by language and as cards for the dialog (MrNotesText: one card for each item, label bold, gaps and sizes by the screen density; MrVersion: the blocks of the notes of the installed version and the reading of the asset), the switch and "Not now", the glue of the screens (MrUpdateUi) with a fake screen, and the
#     download and install (MrUpdateInstall) with a fake session: nothing is committed unless size and hash match, and the
#     morning check (MrUpdateSchedule/Notify/Job): time of the next morning in several zones and with daylight saving time,
#     the job in a fake JobScheduler, one notification per version, no request when the notifications are blocked; it also
#     reads an update.json made by make_update.py and signed by SignCatalog.java (keytool key).
#   - ScreensTest: the insets of the screens on Android 15+ (MrScreens): which Android registers it, the padding of the
#     content area (bars and cutout) and what is left for the views below, which cannot reserve the bars a second time.
#   - MatrixTest: the Matrix effect of the settings screens (MrRain, MrRainDrawable, MrMatrix, and what MrScreens does with it): the drops and their
#     trails, what is drawn and the beats that stop when the window is hidden, which screens get it (all of them but the helper windows), the
#     see-through cards and dialogs that are laid over the theme with it, the screen that is created again when the setting changed and never in a loop.
#   - SoundTest: the key sounds (MrKeySound, MrSoundActivity): the style and the volume read from the preferences, what is played for each key (the speed of space, delete and
#     return), a sound that is still loading, fails or is missing (the system click plays as before), a style that changes, a preview asked for before the sound has loaded; the
#     screen (fifteen tiles in the order of the picture, the choice written in sound_on / pref_sound_style, mute, the volume, the note of the default sound); and the files
#     (the thirteen .ogg of res/raw read byte by byte, the strings in 3 languages, the manifest, the row of the feedback screen, the reset and the call in LatinIME.playKeyClick).
#   - ThemesTest: the themes screen (MrThemesActivity, MrThemePreview, MrCropView, MrThemeRow, MrBackdrop, MrBackdropDrawable, MrScenes, MrThemeColors) with the real colours and texts of res/ and Java2D behind the
#     Canvas stub (the first argument is a folder where it dumps the previews as PNG): the spec of the background (colour, gradient, landscape, picture with zoom and position, anything else is none), the part
#     of a picture that fills the keyboard and how a finger moves and pinches its frame, the 20 gradients drawn as CSS does (stops and lights included), the 48 landscapes read from the assets (eight in each of six categories), the complete keyboard of the dialog with the dash of the modifier keys, the veil that keeps the toolbar readable over every
#     colour, gradient and landscape (a plain colour has none; the softening is for gradients, landscapes and pictures), the picture of the gallery (size, turned as the photo says, a failure keeps what waits, applied, cancelled, let go),
#     the background put on the keyboard only in the twenty-two themes of the backgrounds and the colour of the navigation bar (up to Android 15), the thirty-five themes (thirteen listed, twenty-two hidden: see-through keys with
#     light or dark ink, the fourteen styles of keys, the three of the colour the person picks (glass, outline and gradient) and the same three with dark ink for the pale colours, each checked for the contrast of the letters, of the dash and of the line of the key over every colour, gradient and landscape), the small keyboards (every key, the faces made once, the neon light, the ring), the screen (the tabs and their cards made a few at a time, the pictures of a category read apart, a theme or a background only after its dialog, the softening, the styles of the keys and their tuning (opacity of the key and of its line, colour of the letters, the colour picker and the colours of the own styles, a background that is not in use starting clean), the line of suggestions centred in every theme, the card of the choice in use, the list of one card a row with its thin scroll bar at the margin, the themes never changed by a
#     background, the photo picker and its fallbacks, the crop dialog, remove, a picture that is gone), the row of the settings, and the files (texts in three languages, manifest, prefs.xml, smali hooks).
#   - NavTest: opening screens without stacking copies (MrNav): a settings screen opened from the keyboard goes in a task of its own (the affinity of the settings), cleared and out of
#     the recents; opened from another screen it comes to the front instead of piling up; the AI style editor with an unsaved draft is the exception and is brought back, not cleared.
#   - BottomSpaceTest: the space under the last row of keys (MrBottom): 4 dp whatever the way of navigating, the height that is left to the rows (the space is
#     part of the height of the keyboard), the padding of the view once, errors from Android, the new default heights (34% / 61%), the navigation bar that takes the colour of the
#     theme (opaque up to Android 15, transparent from 16 on) and the calls in LatinIME.setInputView and in the Keyboard.
#   - ScreenImeTest: the keyboard on the editor screens (MrScreenIme): which field has it saved when the screen is
#     recreated, how it is asked for again once the new window has the focus, and the room made for it on Android 15+.
#   - BarTest: the buttons of the tool bar close the dialogs that are open (MrBarClose), except the one that the button itself toggles
#   - KeepTest: the "Customize keyboard" tool and the keyboard when the screen turns (MrKeep): the tool opens again in the form of
#     the new orientation, the keyboard that Android 17 leaves hidden is asked to show itself, all within a short window
#   - ImportScreenTest: the screen "Add words and texts" (MrImportActivity) run against the stubs of Android: the one button under the box (Format with AI from the start, quiet
#     while the box is empty and in the colour of the main action from one character on, for a text that is not a list; See what will be added for a list typed, pasted, restored or made by
#     the AI), the preview in a dialog (the numbers, the empty state, Add and its count) that goes when the text changes, the wording of Undo the last addition, and what the screen no longer
#     has (the button that opens a file and its code, the warning under the AI card, the way back of the formatting, the words "open a file" in the card, the new text of the box in 3 languages).
#   - ImportTest, LearnedStoreTest: the screens "What the keyboard learned" and "Add words and texts" (MrImport, MrLearned on a MrWordStore in memory):
#     cleaning of a free text (links, WhatsApp prefixes, laughs, numbers), the two-occurrence rule, the standard list (every kind of line left out), saving an
#     import with its caps and undo, block, forget, edit, the export that is also the backup (export -> import -> export gives the same text), and what
#     the keyboard loads into its dictionaries. The SQLite store needs Android and is checked on the device.
#   - AppWordsTest, AppScreensTest: the words that are added for ONE app (MrApp, MrAppList, MrAppPicker; screens "Add words and texts" and "What the keyboard learned"): the key
#     "language|package" in the store and the rules of the added words on it (caps of 5000 words / 10000 pairs per app, undo, forget, edit, export and import again, the blocked words that stay
#     for every app), the tree of the app in front (made off the main thread when a field opens in that app, kept while the person is away until a field opens in another app, replaced by the
#     next app, one comparison and no thread for an app without words, the last request wins, a failing store breaks nothing), the list of apps (no system apps, the updated ones stay, search
#     without accents), the dialog, the choice on both screens, the texts in three languages, the manifest and the hooks in smali.
#   - AiImportTest: the formatting of a text by AI (MrImportAi, MrImport.scrub) with a fake service: what is taken out before sending,
#     the parts, the reading of the answers (introductions, code fences, bullets, weights, [blocked] dropped), the merge, a failure in the
#     middle (what came back is kept), unreadable answers, cancelling, and that the result is a list the importer reads with no line left out.
#   - TourTest: the first steps (MrTour): which steps there are (turn the keyboard on, choose it, the dictionary, the gesture recognition) and when the screen opens
#     (once, and again while the keyboard is not on), the keyboard read from Android, the dictionary of the system language (the region first, English for any
#     language that has none), the choices that turn an option off, and a screen that cannot start never reaching the main screen. The downloads are in ThreeLangTest and ModelPackTest.
#   - TourScreenTest: the screen of the first steps (MrTourActivity) run against the stubs of Android: what it says and does at each step (counter, chip, button,
#     quiet button, note), the follow-up of the two steps of Android when the person comes back, a download's progress, a failure and Try again, Skip, the end, a rebuilt screen.
#   - LangTest: the language card of the two word screens (MrLang): the languages offered, which one a screen starts on (its own choice,
#     the last one chosen on either screen, the UI language) and the memory of the last choice.
#   - AiReturnTest: coming back to the AI Editor dialog after its Settings screen (MrAiDialog): the keyboard is asked to
#     appear for the original field, once, soon after leaving, and the dialog reopens when the keyboard window shows.
#   - DiagTest: the numbers of the "Dictionary memory" row (MrDiag, 1.90.0): the reading of /proc/self/smaps on made-up text (headers, Pss/Rss, deleted
#     files, a file mapped twice), the matching of the path, the texts, the report of a pack folder, and on Linux a real mapping seen as resident.
#   - DictMemTest: the "Dictionary memory" lines inside the card of Settings → Advanced → Performance → Keyboard statistics (MrDictMem, written into the row of MrPerf): no lines before
#     the screen opens, no pack in use (said at once, no thread), "Reading…" and then the three lines from the thread (pack, triples, engine), a pack without triples, a newer read
#     winning over an older one, the pack that goes away, a screen that is gone, no row, texts missing.
#   - EngineStatsTest: the engine line and the recognition time of the gestures (MrEngineStats), now in the card "Keyboard statistics" of Advanced and no longer rows of "Suggestions and dictionaries":
#     the texts when the lib is missing, typing by gestures off or the file not downloaded, a title missing, a phone that gives no resources, and the screen of the suggestions without the two rows.
#   - PerfTest: the performance meter of the keyboard (MrPerf): begin/end pairs in microseconds, the
#     average and p95 of the last 256 samples with the count and maximum since the reset, the first frame after a field opens (not after
#     2 s), how late a finger down reaches the keyboard, the delay of the long press timer counted from the touch and the worst long press (MrLongPress), a key counted by its kind (letter, separator, delete, other), the Advanced row
#     (lines, memory, a tap resets), the history of the last 9 starts (minimum, median, maximum; saved when the screen opens, cleared by a
#     tap), one log line per hide with keys, and the memory cleanup of stage 4 (MrTrim: by level, against the view on screen, hidden or
#     absent, a failure inside never goes up, the line of the last cleanup, the row that runs it by hand), and the count of the
#     services and input views still alive after a collection (MrLive: real weak references, the line, the reset, the row).
#   - PrevWordTest: the questions to the app counted on a fake app: the word before the one being
#     typed (MrPrevWord) asked once per word instead of once per letter, with the answer of EditingUtil.getPreviousWord for every letter of
#     thousands of random words (long words, long previous words cut by the 15 characters, any text); when it asks as before (the app does not show
#     the word, a shorter or another word, clear(), nothing composed, no answer); and one question after the echo of our own separator on
#     Android 12+ (MrSurround: getSurroundingText answers the character after the cursor and keeps the text before it for the next-word
#     prediction; Android 11, an app that answers null (asked once per field), a selection and an exception ask as before).
#   - WordDelTest: Ctrl + delete by words (MrWordDelete, 2.0.0): what a word is (a table of texts: letters and digits,
#     apostrophe and hyphen inside a word, signs, accents as marks, emojis and joined families, blanks, line breaks) and what must hold for any text
#     (some progress, never more than there is, no half pair of surrogates, no line break taken along with a word), the setting and its limits, Ctrl
#     read at the touch and kept for the hold, the interval, the word being typed or reopened by the correction (the field deletes like Android's, composing text counted as selected), what is left to the usual delete
#     (a selection, no text, a failing app), the setting off, and whole holds replayed on a fake field (the touch, the repeat at 300 ms, then the
#     interval asked; a one-shot Ctrl goes off after the first key) with the exact text left, and Ctrl + Z word by word: the last word first, a word alone left to the app, what is not the text the word left (typed, cursor moved, selection), the composing text, the words that expire (lifetime, limit, the setting turned off) and a failing app; Ctrl + Y, the redo (the order, a word alone, a new Ctrl + delete ending it, the text the return left, both lists expiring, the limit for both, release).
#   - GridTest: the drawn key grid of the sheet editor (SheetGridView, Java since 1.92.0): the geometry of the cells
#     (margins, gaps, key height, the "+" of a row, the locked "⌫" and the locked bottom row), the limits (6 rows, 10 keys
#     per row and 9 in the last one), the touch rules (tap, cancel, long press, drag and drop, a full row refusing it and
#     telling the editor), the colours of each kind of key (the legend of the editor) and the description TalkBack reads.
#   - SheetsTest: the "Keyboard sheets" page and the sheet editor (MrSheetTest, PrefScreenSheets, SheetEditorActivity, KeyEditDialog,
#     PopupEditDialog): the quick test field that opens the keyboard on its sheet and keeps it there (only for this app's field, a
#     sheet that is gone does nothing, the hooks in LatinIME), the name of the sheet of a "switch sheet" popup item, the preview of a
#     row, the legend, the import that reads at most 1 MB, and the files (the key editor that scrolls, no repeated buttons, texts in 3 languages).
#   - FontsTest: the Unicode styles of the fonts tool (MrFonts): 27 styles with known code points (block styles and their
#     letter-like exceptions, small caps, superscript, Subscript with only the letters Unicode has, the combining marks,
#     Parenthesized), the letters left as they are, accents kept, no two styles equal, the fields that take no style
#     (passwords, e-mail, web addresses, numbers), the delete of a styled letter (with a selection it is left to the
#     normal delete), that the keyboard lets go of the word it holds before every style writes a letter (a styled letter
#     must not replace it) and when the suggestions stop (styleOn).
#   - GlowTest: the neon look of the keyboard themes (MrGlow): a theme without the flag is drawn as before; a neon theme
#     gets the light of the labels, icons, dash and preview letter; a spectrum theme gets the hue of each key from its
#     position (the colour matrix of the face, label, icon, hint letters, dash), except in the popup of variants; and, on the themes of the backgrounds, what the
#     person tuned (MrKeyLook): the colour of the letters, the opacity of the fill and of the line of the face (two layers, each with its own filter), the faint dash
#     that is off, and the hues of the styles of their own colour (one colour, or from a first to a second for the gradient).
#   - LightTest: what a light keyboard theme needs (MrLight): which text colours make a theme light, no dark outline under
#     its labels and icons, and dark system buttons under the keyboard from Android 15 on (light again on a dark theme).
#   - GestureInputTest: gesture typing in the keyboard (MrGestureInput, 1.96.0) with a fake keyboard view, text field and recognition:
#     off by default and nothing changes while it is off, when a touch is followed and when it is not (password, URL, popup, modifier,
#     symbols, font style, two fingers), a tap and a long press unchanged, the gesture taking the touch over (one cancel to the usual
#     path, no fling action), the trace handed to the recognition in its frame, what is written (space, capitals), the other candidates
#     on the strip, backspace taking the whole word, the trail, the time kept, and no exception leaving it; the word so far
#     on the strip while the finger slides (when, how often, a slow phone, its switch, the strip given back) and the blocked words.
#     The real recognition, from touch to text, is docs/tools/e2e/run_gesture_input_tests.sh.
#   - GestureWordsTest: the words of the person in gesture typing (MrGestureWords, 1.96.0): the frequency they get, the small dictionary
#     written from them (read back by a reader of the format: every word, every frequency, every byte), which words are read from the
#     trees of the keyboard (learned from frequency 6, never a blocked one) and when the copy is made again (a word added, a tree thrown
#     away or still loading, another language), and that the copy is let go when the engine closes and made again (MrGestureWords.release, stage 4 part 2).
#   - EmojiSearchTest: the search of the emoji panel (MrEmojiIndex, 1.97.0): the text made lower case and without accents, a word of
#     the name or a keyword in any of the three languages at once, every word typed having to begin one of the words of the emoji,
#     the ranking (whole word, first word of the name, the language of the app winning a tie, then the order of the panel), the
#     limits (max, empty text, six words), a language file that is missing; and the extra height of a header (MrBar.expand/restore).
#   - EmojiPanelTest: the search and delete buttons of the emoji panel (MrEmojiSearch, 1.97.0) with fake views: what showPanel asks of it
#     (setup, onPanel, afterPanel), the redirect and the field of the keyboard while it is open and after, the height of the header taken
#     and given back, the delete button (press feedback, Backspace, the repeat, release and cancel), a tap on a result written in the
#     app and not in the search field, the words read in a background thread, dropped when the emoji panel is left, thrown away when
#     they arrive late, and a keyboard view made again while the search is open.
#   - SymbolsTest: the symbols page of the emoji panel (MrSymbols, 2.1.0): the eight categories of one code point each (none twice, the ones of the reference pictures
#     among them, ASCII source), the swap between the emojis and the symbols with the two buttons of the floating bar (tabs with a symbol in place of the icon and the icon back, the list built
#     again), the recent symbols (their own preference, 24 at most, a long press removes), the names of the tabs, the symbols the font of the phone cannot draw left out (asked once per
#     category), the way back to the emojis when the panel is left, and the hooks in MrEmotes.smali.
#   - EmojiNewTest: the emojis newer than the base list of the panel (MrEmojiNew, 1.97.0): the table (one group per anchor, no emoji
#     twice), the merge into a base list (right after the anchor, at the end of the category when the anchor is not there, none added
#     twice), what a phone whose font cannot draw some of them gets (Paint.hasGlyph: left out of the panel and of the search results,
#     the answers kept so it is asked once), and that every emoji of the table has words in the three languages.
# With the path of the APK jar (classes.dex -> d2j-dex2jar), it also runs:
#   - EsTest: SheetStrings/MrEs with Spanish, Portuguese, English and French contexts.
# Usage: sh docs/tools/run_java_tests.sh [app.jar]
set -e
APPJAR=$1
T=$(mktemp -d)
D=docs/tools
javac -nowarn --release 8 -d "$T/stubs" $(find $D/java/stubs -name '*.java')
javac -Xlint:-options --release 8 -cp "$T/stubs" -d "$T/main" $(find $D/java/src -name '*.java')

echo "== AuthorTest"
javac -nowarn -cp "$T/stubs" -d "$T/ov_author" $(find $D/author_test/stubs -name '*.java')
javac -nowarn -cp "$T/ov_author:$T/stubs:$T/main" -d "$T/test_author" $D/author_test/AuthorTest.java
java -cp "$T/test_author:$T/ov_author:$T/stubs:$T/main" com.mrkeyboard.app.AuthorTest

echo "== RecorrectTest"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_rec" $D/recorrect_test/RecorrectTest.java
java -cp "$T/test_rec:$T/stubs:$T/main" com.mrkeyboard.app.RecorrectTest

echo "== DigitTest (a digit typed for a letter: what is replaced on its own, other numbers, the lone digit that starts a word)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_digit" $D/digit_test/DigitTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_digit:$T/stubs:$T/main" com.mrkeyboard.app.DigitTest

echo "== RecentTest"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_recent" $D/recent_test/RecentTest.java
java -cp "$T/test_recent:$T/stubs:$T/main" com.mrkeyboard.app.RecentTest

echo "== DiagTest (memory and load time line)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_diag" $D/diag_test/DiagTest.java
java -cp "$T/test_diag:$T/stubs:$T/main" com.mrkeyboard.app.DiagTest

echo "== DictMemTest (the Dictionary memory row of Advanced: no pack, Reading…, the lines from the thread, a newer read wins, a gone screen, missing texts)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_dictmem" $D/diag_test/DictMemTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_dictmem:$T/stubs:$T/main" com.mrkeyboard.app.DictMemTest

echo "== EngineStatsTest (the engine and the recognition time of the gestures, now in the card of the statistics)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_engstats" $D/perf_test/EngineStatsTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_engstats:$T/stubs:$T/main" com.mrkeyboard.app.EngineStatsTest

echo "== PerfTest (performance meter: begin/end, average/p95/max, first frame, touch wait, the Advanced row, the history of the starts, the memory cleanup, the log)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_perf" $D/perf_test/PerfTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_perf:$T/stubs:$T/main" com.mrkeyboard.app.PerfTest

echo "== PrevWordTest (questions to the app: the word before the one typed, one question after our own separator)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_prevword" $D/prevword_test/PrevWordTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_prevword:$T/stubs:$T/main" com.mrkeyboard.app.PrevWordTest

echo "== NoLibTest (without libmrengine.so: no exception, no results)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_native" $D/native_test/NoLibTest.java
java -cp "$T/test_native:$T/stubs:$T/main" com.mrkeyboard.app.NoLibTest

echo "== UpdateTest (update notice: the logic, and the files made by the real tools)"
sh $D/update_test/make_fixtures.sh "$T/update_fx"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_update" $D/update_test/UpdateTest.java
java -cp "$T/test_update:$T/stubs:$T/main" com.mrkeyboard.app.UpdateTest "$T/update_fx"

echo "== ScreensTest (insets of the screens)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_screens" $D/screens_test/ScreensTest.java
java -cp "$T/test_screens:$T/stubs:$T/main" com.mrkeyboard.app.ScreensTest

echo "== MatrixTest (the Matrix effect of the settings screens)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_matrix" $D/screens_test/MatrixTest.java
java -cp "$T/test_matrix:$T/stubs:$T/main" com.mrkeyboard.app.MatrixTest

echo "== SoundTest (the key sounds: MrKeySound, the screen Keyboard sound and its files)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_sound" $D/screens_test/SoundTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_sound:$T/stubs:$T/main" com.mrkeyboard.app.SoundTest

echo "== ThemesTest (the themes screen, the backgrounds and the picture of the gallery)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_themes" $D/themes_test/ThemesTest.java
java -Djava.awt.headless=true -Dfile.encoding=UTF-8 -cp "$T/test_themes:$T/stubs:$T/main" com.mrkeyboard.app.ThemesTest "$T/themes_png"

echo "== NavTest (screens without copies)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_nav" $D/nav_test/NavTest.java
java -cp "$T/test_nav:$T/stubs:$T/main" com.mrkeyboard.app.NavTest

echo "== BottomSpaceTest (space under the last row, by the way of navigating)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_bottom" $D/bottom_test/BottomSpaceTest.java
java -cp "$T/test_bottom:$T/stubs:$T/main" com.mrkeyboard.app.BottomSpaceTest

echo "== ScreenImeTest (keyboard on the editor screens)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_screenime" $D/screenime_test/ScreenImeTest.java
java -cp "$T/test_screenime:$T/stubs:$T/main" com.mrkeyboard.app.ScreenImeTest

echo "== ImportTest (import of words and texts)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_import" $D/learned_test/ImportTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_import:$T/stubs:$T/main" com.mrkeyboard.app.ImportTest

echo "== ImportScreenTest (the screen Add words and texts run against the stubs: the button under the box, the preview, what the screen no longer has)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_importscreen" $D/learned_test/ImportScreenTest.java $D/tour_test/TourTest.java $D/tour_test/TourScreenTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_importscreen:$T/stubs:$T/main" com.mrkeyboard.app.ImportScreenTest

echo "== LearnedStoreTest (what the keyboard learned: block, forget, edit, undo, export)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_learned" $D/learned_test/LearnedStoreTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_learned:$T/stubs:$T/main" com.mrkeyboard.app.LearnedStoreTest

echo "== AppWordsTest (words for one app: the key, caps, undo, export, blocked words, and the tree of the app in front: off the main thread, kept while away, replaced by the next app, no cost without words)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_appwords" $D/learned_test/AppWordsTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_appwords:$T/stubs:$T/main" com.mrkeyboard.app.AppWordsTest

echo "== AppScreensTest (the list of apps, the dialog, the choice on Add words and texts and on What the keyboard learned, the texts, the manifest and the hooks)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_appscreens" $D/learned_test/AppScreensTest.java $D/learned_test/AppWordsTest.java $D/learned_test/ImportScreenTest.java $D/tour_test/TourTest.java $D/tour_test/TourScreenTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_appscreens:$T/stubs:$T/main" com.mrkeyboard.app.AppScreensTest

echo "== AiImportTest (formatting of a text by AI: scrub, parts, answers, merge, fake service)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_aiimport" $D/learned_test/AiImportTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_aiimport:$T/stubs:$T/main" com.mrkeyboard.app.AiImportTest

echo "== TourTest (first steps: the steps, when the screen opens once, the dictionary of the system language with English as the fallback, the choices)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_tour" $D/tour_test/TourTest.java $D/tour_test/TourScreenTest.java
java -cp "$T/test_tour:$T/stubs:$T/main" com.mrkeyboard.app.TourTest

echo "== TourScreenTest (the screen of the first steps run against the stubs: what it says and does at each step)"
java -cp "$T/test_tour:$T/stubs:$T/main" com.mrkeyboard.app.TourScreenTest

echo "== LangTest (language choice shared by the word screens)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_lang" $D/learned_test/LangTest.java
java -cp "$T/test_lang:$T/stubs:$T/main" com.mrkeyboard.app.LangTest

echo "== AiReturnTest (return to the AI Editor dialog)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_aireturn" $D/ai_return_test/AiReturnTest.java
java -cp "$T/test_aireturn:$T/stubs:$T/main" com.mrkeyboard.app.AiReturnTest

echo "== BarTest (tool bar buttons with a dialog open)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_bar" $D/bar_test/BarTest.java
java -cp "$T/test_bar:$T/stubs:$T/main" com.mrkeyboard.app.BarTest

echo "== KeepTest (tool and keyboard when the screen turns)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_keep" $D/keep_test/KeepTest.java
java -cp "$T/test_keep:$T/stubs:$T/main" com.mrkeyboard.app.KeepTest

echo "== WordDelTest (Ctrl + delete by words: the rule, the setting, Ctrl at the touch, the interval, the word being typed, whole holds replayed, Ctrl + Z and Ctrl + Y by words)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_worddel" $D/worddel_test/WordDelTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_worddel:$T/stubs:$T/main" com.mrkeyboard.app.WordDelTest

echo "== GridTest (drawn key grid of the sheet editor)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_grid" $D/grid_test/SheetGridViewTest.java
java -cp "$T/test_grid:$T/stubs:$T/main" com.mrkeyboard.app.SheetGridViewTest

echo "== SheetsTest (Keyboard sheets page and sheet editor: the quick test field on its sheet, the texts the screens make, the import limit, the files)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_sheets" $D/sheets_test/SheetsTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_sheets:$T/stubs:$T/main" com.mrkeyboard.app.SheetsTest

echo "== AccelTest (log of the keyboard window)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_accel" $D/accel_test/AccelTest.java
java -cp "$T/test_accel:$T/stubs:$T/main" com.mrkeyboard.app.AccelTest

echo "== FontsTest (Unicode styles of the fonts tool: 27 styles, field guard, delete)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_fonts" $D/fonts_test/FontsTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_fonts:$T/stubs:$T/main" com.mrkeyboard.app.FontsTest

echo "== GlowTest (neon themes: light of the labels and hue of each key)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_glow" $D/glow_test/GlowTest.java
java -cp "$T/test_glow:$T/stubs:$T/main" com.mrkeyboard.app.GlowTest

echo "== LightTest (light themes: no dark outline, dark system buttons under the keyboard)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_light" $D/light_test/LightTest.java
java -cp "$T/test_light:$T/stubs:$T/main" com.mrkeyboard.app.LightTest

echo "== GestureInputTest (gesture typing in the keyboard: touch, trail, writing, strip, backspace, the word while sliding, blocked words)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_gi" $D/gesture_input_test/GestureInputTest.java $D/gesture_input_test/GestureWordsTest.java
java -Dfile.encoding=UTF-8 -Dmr.native=off -cp "$T/test_gi:$T/stubs:$T/main" com.mrkeyboard.app.GestureInputTest

echo "== GestureWordsTest (gesture typing, the words of the person: the small dictionary written from the learned and added words)"
java -Dfile.encoding=UTF-8 -Dmr.native=off -cp "$T/test_gi:$T/stubs:$T/main" com.mrkeyboard.app.GestureWordsTest

echo "== EmojiSearchTest (emoji search: index in three languages, ranking, and the extra height of a header)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_es_emoji" $D/emoji_search_test/EmojiSearchTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_es_emoji:$T/stubs:$T/main" com.mrkeyboard.app.EmojiSearchTest

echo "== EmojiPanelTest (emoji search and delete in the panel: redirect, height, buttons, results, words in the background)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_es_panel" $D/emoji_search_test/EmojiPanelTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_es_panel:$T/stubs:$T/main" com.mrkeyboard.app.EmojiPanelTest

echo "== SymbolsTest (symbols page of the emoji panel: data, swap, recents, names, fonts)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_symbols" $D/emoji_search_test/SymbolsTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_symbols:$T/stubs:$T/main" com.mrkeyboard.app.SymbolsTest

echo "== EmojiNewTest (the emojis newer than the panel: table, merge, phones that cannot draw them)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_es_new" $D/emoji_search_test/EmojiNewTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_es_new:$T/stubs:$T/main" com.mrkeyboard.app.EmojiNewTest

if [ -n "$APPJAR" ]; then
  echo "== EsTest"
  javac -nowarn -cp "$T/stubs" -d "$T/ov_es" $(find $D/settings_test/stubs -name '*.java')
  javac -encoding UTF-8 -nowarn -cp "$T/ov_es:$T/stubs:$APPJAR" -d "$T/test_es" $D/es_test/EsTest.java
  # the jar comes from dex2jar, without stack maps: the JVM verifier is switched off just for it.
  # The jar comes BEFORE $T/stubs on purpose: the stubs of java/stubs carry the signatures of the APK classes (SheetStrings,
  # MrTools, SheetModel...), and this test wants the real ones (SheetStrings.isPt/p) from the APK. Only the android.*
  # signatures, which are not in the APK, still come from the stubs.
  java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote \
    -cp "$T/test_es:$T/ov_es:$APPJAR:$T/stubs" com.mrkeyboard.app.EsTest
fi
rm -rf "$T"
