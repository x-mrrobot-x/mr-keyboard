#!/bin/sh
# PC tests of the Java layer that do not need the APK (run at the project root):
#   - compiles the stubs (docs/tools/java/stubs) and the sources (docs/tools/java/src), like build_java.sh;
#   - AuthorTest: author card and main-screen link (MrAuthor, MrLink).
#   - RecorrectTest: word under the cursor, which words get suggestions and neighbour keys (MrRecorrect).
#   - RecentTest: recent words in the prediction and when completing (MrRecent).
#   - NativeFallbackTest: without libmrengine.so (native engine, 1.77) correction and trigrams go on through Java.
#   - UpdateTest: the notice of a new version (MrUpdate): signature, every field, versions, replay, checking windows,
#     notes by language, the switch and "Not now", the glue of the screens (MrUpdateUi) with a fake screen, and the
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
#   - AiReturnTest: coming back to the AI Editor dialog after its Settings screen (MrAiDialog): the keyboard is asked to
#     appear for the original field, once, soon after leaving, and the dialog reopens when the keyboard window shows.
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

echo "== NativeFallbackTest (without libmrengine.so: the app must work as in 1.76)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_native" $D/native_test/NativeFallbackTest.java
java -cp "$T/test_native:$T/stubs:$T/main" com.mrkeyboard.app.NativeFallbackTest

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

echo "== AiReturnTest (return to the AI Editor dialog)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_aireturn" $D/ai_return_test/AiReturnTest.java
java -cp "$T/test_aireturn:$T/stubs:$T/main" com.mrkeyboard.app.AiReturnTest

echo "== BarTest (tool bar buttons with a dialog open)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_bar" $D/bar_test/BarTest.java
java -cp "$T/test_bar:$T/stubs:$T/main" com.mrkeyboard.app.BarTest

echo "== KeepTest (tool and keyboard when the screen turns)"
javac -encoding UTF-8 -nowarn -cp "$T/stubs:$T/main" -d "$T/test_keep" $D/keep_test/KeepTest.java
java -cp "$T/test_keep:$T/stubs:$T/main" com.mrkeyboard.app.KeepTest

if [ -n "$APPJAR" ]; then
  echo "== EsTest"
  javac -nowarn -cp "$T/stubs" -d "$T/ov_es" $(find $D/settings_test/stubs -name '*.java')
  javac -encoding UTF-8 -nowarn -cp "$T/ov_es:$T/stubs:$APPJAR" -d "$T/test_es" $D/es_test/EsTest.java
  # the jar comes from dex2jar, without stack maps: the JVM verifier is switched off just for it
  java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote \
    -cp "$T/test_es:$T/ov_es:$T/stubs:$APPJAR" com.mrkeyboard.app.EsTest
fi
rm -rf "$T"
