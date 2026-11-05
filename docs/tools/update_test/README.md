# Update notice test on the PC (1.82)

`UpdateTest` runs `MrUpdate` (the notice of a new version, `update.json`) with a fake Android: preferences in memory,
the network read from memory, a clock set by the test and certificates made in the test. It needs no APK, so it runs in
`docs/tools/run_java_tests.sh` (CI job *quick*).

It covers:
- **Signature:** the app's RSA key and an EC key are accepted; another key, a changed `signer`, data changed after signing,
  a weak algorithm, a bad base64 and a bigger-than-limit answer are refused. A file signed with the **catalog prefix** is not
  an update notice, and an update notice does not pass as a catalog (`MrPacks.verifySigned` is the same code for both).
- **Content:** tag like `v1.82.0`, `versionCode` that follows from the tag, APK named `mr-keyboard-<tag>.apk` with size and
  SHA-256, notes in English (Portuguese optional). A link or an unknown field in the file is ignored: the APK address is
  always built from the app's constants and the tag.
- **Versions:** only a `versionCode` higher than the installed one is offered; an older signed notice than one already seen
  (replay) is refused and changes nothing.
- **Windows:** opening the app (24 h), morning job (reuses a check up to 6 h old), 1 h of waiting after a failed try, the
  manual check that ignores them all, a clock set back.
- **Notes:** simple Markdown to plain text, Portuguese for `pt`, English for the other languages.
- **Screens (`screens()`):** the "Check when the app opens" switch (on by default, kept in `mr_update`, not in the default
  preferences), "Not now" (per version, 24 h, a newer version pops up at once, a clock set back does not hide the notice),
  the text keys of the errors and the size text (1.2 MB / 1,2 MB / 512 KB).
- **Glue of the screens (`glue()`):** `MrUpdateUi` with a fake screen and fake preference rows: opening with the switch off
  and on, the 24 h window, "Not now", the `mr_update_show` extra of the morning notification, offline with and without a
  known version, a screen that is finishing, and the Settings lines (a tap for each result: up to date, offline, new
  version, version already known). The dialog is asked for through a test seam (`MrUpdateDialog.sAsked`); how it looks is
  checked on the device.

With the folder made by `update_test/make_fixtures.sh` as argument it also reads an `update.json` made by the **real tools**
(`make_update.py` and `SignCatalog.java` with a keytool key, `--domain update`): it must be accepted, and the same data signed
for the catalog (or changed after signing) must not.

```sh
sh docs/tools/run_java_tests.sh        # at the project root; or by hand:
sh docs/tools/update_test/make_fixtures.sh /tmp/update_fx
```

It was also run against the classes of the assembled APK (dex → jar), with the same 118 checks.
