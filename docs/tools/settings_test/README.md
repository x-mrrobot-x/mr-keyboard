# Engine default values test (1.69)

Checks that `GlobalKeyboardSettings` (the fields the keyboard reads: Caps Lock, click method, drawing mode, sliding keys,
etc.) keeps the same values before and after a change, and that old stored values of options that no longer
have a screen no longer change anything.

1. Stubs: `docs/tools/java/stubs/android` (compiled) and, in front, the `stubs/` of this folder (the `Resources` with `getBoolean` and `getInteger`).
2. `javac -cp <compiled stubs>:<APK jar> -d cls SettingsDefaultsTest.java`
3. `java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -cp cls:<this folder's Resources compiled>:<compiled stubs>:<APK jar> com.mrkeyboard.app.SettingsDefaultsTest <decoded project folder> [key=value ...]`
   - the jar comes from the APK's `classes.dex` (`d2j-dex2jar.sh`);
   - the project folder is the one with `res/values/public.xml` from the same APK (apktool d);
   - each `key=value` simulates a stored preference (`true` and `false` become booleans).

The output is the `field=value` list. Run it with the jar from before and the one from after and compare with `diff`: with no stored values the two lists
must be equal; with old values (`pref_caps_lock=false pref_click_method=0 pref_touch_pos=true ...`) the new list must stay equal to the defaults one.
