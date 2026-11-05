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

- **Download and install (`install()`):** `MrUpdateInstall` with a fake session (`Target`) and the network read from memory:
  the APK reaches the session whole and is committed once; a changed bit, a shorter or longer file, a size different from
  the signed one, HTTP 404, no connection, no space, a refused commit and a Cancel at any moment all end with the session
  abandoned and **nothing committed**; every status of the system maps to its text; the job in its thread, the answer of
  the system (the user's "No" is not an error), a stale answer, and a Cancel while the network is stuck. The real session,
  the `PendingIntent` and the confirm screen of Android are checked on the device.
- **Morning check (`morning()`):** `MrUpdateSchedule.next` with fixed dates (before/at/after the time, change of month and year,
  leap year, minutes held to 0-59, other time zones, the clocks going back and forward in New York and Sydney, and 6000 random
  moments in 12 zones); the job armed in a fake `JobScheduler` (id, service, any network, persisted, wait until 8:mm, replace,
  `ensure`, switch off cancels, a refusal of the system throws nothing); the notification in a fake `NotificationManager`
  (channel with low importance, title with the version, `PendingIntent` immutable that opens Settings in a clean task with the
  `mr_update_show` extra, removal when the installed app is that version); the round of the job (`MrUpdateJob.run`): switch off
  or notifications blocked = **no request**, one notification per `versionCode`, a dismissed notification does not come
  back, the 6 h reuse of a check, offline, a notification the system refuses is not marked as notified; the `JobService`
  (next morning scheduled before `jobFinished`, `onStopJob` asks to retry only if the work did not end); the receiver of the
  update of the app; and the Settings glue (permission asked once on Android 13+, the "Allow notifications" line that
  comes and goes, the switch, the update dialog waiting while the system asks).

With the folder made by `update_test/make_fixtures.sh` as argument it also reads an `update.json` made by the **real tools**
(`make_update.py` and `SignCatalog.java` with a keytool key, `--domain update`): it must be accepted, and the same data signed
for the catalog (or changed after signing) must not.

```sh
sh docs/tools/run_java_tests.sh        # at the project root; or by hand:
sh docs/tools/update_test/make_fixtures.sh /tmp/update_fx
```

It was also run against the classes of the assembled APK (dex → jar), with the same 150 checks.
