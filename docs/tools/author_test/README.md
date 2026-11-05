# Author card and main screen links test (1.72)

Checks that `MrAuthor` opens the link and that, with no app to open it (`ActivityNotFoundException`), it does not propagate the error: it shows the notice in the app's language
(or the link itself, if the text is missing) and returns `false`. It also checks `MrLink.protect`: the link in the main screen text becomes a span that opens the link (or warns) without crashing the app. It runs on the PC, without an APK.

1. `javac --release 8 -d stubs $(find docs/tools/java/stubs -name '*.java')`
2. `javac --release 8 -cp stubs -d main $(find docs/tools/java/src -name '*.java')`
3. Test-only overlays: `javac -cp stubs -d ov docs/tools/author_test/stubs/android/widget/Toast.java docs/tools/author_test/stubs/android/content/res/Resources.java`
   (the `Toast` records the text; the `Resources` resolves `mr_ui_author_no_browser`).
4. `javac -cp ov:stubs:main -d test docs/tools/author_test/AuthorTest.java` and
   `java -cp test:ov:stubs:main com.mrkeyboard.app.AuthorTest`
