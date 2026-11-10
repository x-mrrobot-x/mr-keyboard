# Spanish language test in the code (sheet editor and attachments)

Checks `SheetStrings.isPt/p` and `MrEs` with Spanish, Portuguese, English and French contexts: in Spanish the Portuguese text
goes through the `MrEs` table and comes out in Spanish; in Portuguese and English nothing changes; text without a translation stays the same; the text the code
had only in Portuguese (attachments and cache cleanup) comes out in the app's language. It also checks that the table has no empty translation.

1. Stubs: compiled `docs/tools/java/stubs/android`, with the `Resources` from `docs/tools/settings_test/stubs` in front; the `UiLocale` from
   `docs/tools/packs_test/UiLocale.java` (it replaces the APK's, which uses APIs that the PC does not have).
2. `javac -cp <compiled UiLocale>:<stubs>:<APK jar> -d cls EsTest.java`
3. `java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -cp cls:<compiled UiLocale>:<APK jar>:<stubs> com.mrkeyboard.app.EsTest`
   (the jar comes from the APK's `classes.dex` with `d2j-dex2jar.sh`). The **jar comes before the stubs** at run time: `java/stubs`
   carries the signatures of the APK classes with empty bodies (`SheetStrings.p` returns the text unchanged), so with the stubs
   first this test passes on the wrong class. The first check says where `SheetStrings` came from and fails if it is not the jar.

`docs/tools/mres_check.py` (at the project root) checks the other side: that every Portuguese text in the smali goes through `p()`/`a()` and
is in the table.
