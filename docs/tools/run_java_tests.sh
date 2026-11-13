#!/bin/sh
# PC tests of the Java layer that do not need the APK (run at the project root):
#   - compiles the stubs (docs/tools/java/stubs) and the sources (docs/tools/java/src), like build_java.sh;
#   - AuthorTest: author card and main-screen link (MrAuthor, MrLink).
#   - RecorrectTest: word under the cursor, which words get suggestions and neighbour keys (MrRecorrect).
#   - RecentTest: recent words in the prediction and when completing (MrRecent).
#   - NoLibTest: without libmrengine.so (native engine, 1.77) the search answers no results and the trigrams nothing, with no exception (since 1.87.0 there is no Java search).
#   - UpdateTest: the notice of a new version (MrUpdate): signature, every field, versions, replay, checking windows,
#     notes by language and styled for the dialog (MrNotesText: bullets, colored labels, thin lines, hanging indent), the switch and "Not now", the glue of the screens (MrUpdateUi) with a fake screen, and the
#     download and install (MrUpdateInstall) with a fake session: nothing is committed unless size and hash match, and the
#     morning check (MrUpdateSchedule/Notify/Job): time of the next morning in several zones and with daylight saving time,
#     the job in a fake JobScheduler, one notification per version, no request when the notifications are blocked; it also
#     reads an update.json made by make_update.py and signed by SignCatalog.java (keytool key).
#   - ScreensTest: the insets of the screens on Android 15+ (MrScreens): which Android registers it, the padding of the
#     content area (bars and cutout) and what is left for the views below, which cannot reserve the bars a second time.
#   - NavTest: opening screens without stacking copies (MrNav): flags from the keyboard window and from a screen, and
#     what the AI style editor does when it is asked for again while it is already open.
#   - ScreenImeTest: the keyboard on the editor screens (MrScreenIme): which field has it saved when the screen is
#     recreated, how it is asked for again once the new window has the focus, and the room made for it on Android 15+.
#   - BarTest: the buttons of the tool bar close the dialogs that are open (MrBarClose), except the one that the button itself toggles
#   - KeepTest: the "Customize keyboard" tool and the keyboard when the screen turns (MrKeep): the tool opens again in the form of
#     the new orientation, the keyboard that Android 17 leaves hidden is asked to show itself, all within a short window
#   - ImportTest, LearnedStoreTest: the screens "What the keyboard learned" and "Add words and texts" (MrImport, MrLearned on a MrWordStore in memory):
#     cleaning of a free text (links, WhatsApp prefixes, laughs, numbers), the two-occurrence rule, the standard list (every kind of line left out), saving an
#     import with its caps and undo, block, forget, edit, the export that is also the backup (export -> import -> export gives the same text), and what
#     the keyboard loads into its dictionaries. The SQLite store needs Android and is checked on the device.
#   - AiImportTest: the formatting of a text by AI (MrImportAi, MrImport.scrub) with a fake service: what is taken out before sending,
#     the parts, the reading of the answers (introductions, code fences, bullets, weights, [blocked] dropped), the merge, a failure in the
#     middle (what came back is kept), unreadable answers, cancelling, and that the result is a list the importer reads with no line left out.
#   - LangTest: the language card of the two word screens (MrLang): the languages offered, which one a screen starts on (its own choice,
#     the last one chosen on either screen, the UI language) and the memory of the last choice.
#   - AiReturnTest: coming back to the AI Editor dialog after its Settings screen (MrAiDialog): the keyboard is asked to
#     appear for the original field, once, soon after leaving, and the dialog reopens when the keyboard window shows.
#   - DiagTest: the "Dictionary memory" line (MrDiag, 1.90.0): the reading of /proc/self/smaps on made-up text (headers, Pss/Rss, deleted
#     files, a file mapped twice), the matching of the path, the texts, the report of a pack folder, and on Linux a real mapping seen as resident.
#   - PerfTest: the performance meter of the keyboard (MrPerf, docs/plan-performance.md stage 2): begin/end pairs in microseconds, the
#     average and p95 of the last 256 samples with the count and maximum since the reset, the first frame after a field opens (not after
#     2 s), how late a finger down reaches the keyboard, the Advanced row (lines, memory, a tap resets) and one log line per hide with keys.
#   - GridTest: the drawn key grid of the sheet editor (SheetGridView, Java since 1.92.0): the geometry of the cells
#     (margins, gaps, key height, the "+" of a row, the locked "⌫" and the locked bottom row), the limits (6 rows, 10 keys
#     per row and 9 in the last one) and the touch rules (tap, cancel, long press, drag and drop, a full row refusing it).
#   - FontsTest: the Unicode styles of the fonts tool (MrFonts): 27 styles with known code points (block styles and their
#     letter-like exceptions, small caps, superscript, Subscript with only the letters Unicode has, the combining marks,
#     Parenthesized), the letters left as they are, accents kept, no two styles equal, the fields that take no style
#     (passwords, e-mail, web addresses, numbers), the delete of a styled letter (with a selection it is left to the
#     normal delete), that the keyboard lets go of the word it holds before every style writes a letter (a styled letter
#     must not replace it) and when the suggestions stop (styleOn).
#   - GlowTest: the neon look of the keyboard themes (MrGlow): a theme without the flag is drawn as before; a neon theme
#     gets the light of the labels, icons, dash and preview letter; a spectrum theme gets the hue of each key from its
#     position (the colour matrix of the face, label, icon, hint letters, dash), except in the popup of variants.
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
#     away or still loading, another language).
#   - EmojiSearchTest: the search of the emoji panel (MrEmojiIndex, 1.97.0): the text made lower case and without accents, a word of
#     the name or a keyword in any of the three languages at once, every word typed having to begin one of the words of the emoji,
#     the ranking (whole word, first word of the name, the language of the app winning a tie, then the order of the panel), the
#     limits (max, empty text, six words), a language file that is missing; and the extra height of a header (MrBar.expand/restore).
#   - EmojiPanelTest: the search and delete buttons of the emoji panel (MrEmojiSearch, 1.97.0) with fake views: what showPanel asks of it
#     (setup, onPanel, afterPanel), the redirect and the field of the keyboard while it is open and after, the height of the header taken
#     and given back, the delete button (press feedback, Backspace, the repeat, release and cancel), a tap on a result written in the
#     app and not in the search field, the words read in a background thread, dropped when the emoji panel is left, thrown away when
#     they arrive late, and a keyboard view made again while the search is open.
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

echo "== RecentTest"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_recent" $D/recent_test/RecentTest.java
java -cp "$T/test_recent:$T/stubs:$T/main" com.mrkeyboard.app.RecentTest

echo "== DiagTest (memory and load time line)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_diag" $D/diag_test/DiagTest.java
java -cp "$T/test_diag:$T/stubs:$T/main" com.mrkeyboard.app.DiagTest

echo "== PerfTest (performance meter: begin/end, average/p95/max, first frame, touch wait, the Advanced row, the log)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_perf" $D/perf_test/PerfTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_perf:$T/stubs:$T/main" com.mrkeyboard.app.PerfTest

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

echo "== NavTest (screens without copies)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_nav" $D/nav_test/NavTest.java
java -cp "$T/test_nav:$T/stubs:$T/main" com.mrkeyboard.app.NavTest

echo "== ScreenImeTest (keyboard on the editor screens)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_screenime" $D/screenime_test/ScreenImeTest.java
java -cp "$T/test_screenime:$T/stubs:$T/main" com.mrkeyboard.app.ScreenImeTest

echo "== ImportTest (import of words and texts)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_import" $D/learned_test/ImportTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_import:$T/stubs:$T/main" com.mrkeyboard.app.ImportTest

echo "== LearnedStoreTest (what the keyboard learned: block, forget, edit, undo, export)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_learned" $D/learned_test/LearnedStoreTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_learned:$T/stubs:$T/main" com.mrkeyboard.app.LearnedStoreTest

echo "== AiImportTest (formatting of a text by AI: scrub, parts, answers, merge, fake service)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_aiimport" $D/learned_test/AiImportTest.java
java -Dfile.encoding=UTF-8 -cp "$T/test_aiimport:$T/stubs:$T/main" com.mrkeyboard.app.AiImportTest

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

echo "== GridTest (drawn key grid of the sheet editor)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_grid" $D/grid_test/SheetGridViewTest.java
java -cp "$T/test_grid:$T/stubs:$T/main" com.mrkeyboard.app.SheetGridViewTest

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
