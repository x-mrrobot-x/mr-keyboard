# Screens opened by the keyboard and the recent apps

What the keyboard opens (the gear, the buttons of the AI Editor, the notification of a new version) lives in **a task of its own**, which is **emptied at every opening** and is **not in the list of recent apps**. Leaving the Settings leaves nothing behind in the list, and tapping the gear again shows the Settings from its first page, not whatever screen was left open above it.

## The task of the Settings

- Every screen but the home screen has a `taskAffinity` of its own in the manifest (`MrNav.SETTINGS_AFFINITY`), so it is not in the task of the launcher.
- Every Intent that the keyboard builds to open a screen has the flags `0x10808000`: `FLAG_ACTIVITY_NEW_TASK` (0x10000000) + `FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS` (0x00800000) + `FLAG_ACTIVITY_CLEAR_TASK` (0x00008000).

## What is done

1. **Affinity (manifest).** Every screen but the home screen (`Main`) and the three translucent helper windows has `android:taskAffinity="com.mrkeyboard.app.settings"` (`MrNav.SETTINGS_AFFINITY`). `NEW_TASK` puts a screen in the task of that affinity, so all the screens that the keyboard opens are together in one task, apart from the task of the home screen. The home screen has no affinity: it is the task of the package, listed as usual.
2. **Flags (`MrNav.intent`).** From the keyboard (a Service): `NEW_TASK | CLEAR_TASK | EXCLUDE_FROM_RECENTS` (`MrNav.FROM_KEYBOARD`). `CLEAR_TASK` empties the task before the screen starts; `EXCLUDE_FROM_RECENTS` keeps it out of the list. The notification of a new version (`MrUpdateNotify.tapIntent`) has the same flags. The manifest does not say `excludeFromRecents` on any screen: the Intent does it, so the Settings reached from the **home screen** (no `NEW_TASK`: it goes on top of the home screen's task) are listed with it as usual.
3. **The one exception: a style being edited.** While a style of the AI Editor is open (`MrAiStyleActivity.isOpen()`) it may hold a draft that was not saved, and emptying the task would throw it away. The screen is then started on top of the task that is open (`NEW_TASK | REORDER_TO_FRONT`, `MrNav.KEEPING_DRAFT`), as before.
4. **No copy of a screen on top of itself.** Every screen is `singleTop`. From a screen, `MrNav.intent` adds `REORDER_TO_FRONT`: a copy that is already in the stack is brought to the front, not stacked again.
5. **Closed when it is not needed.** `MrNav.intent` marks what the keyboard opens (`EXTRA_FROM_KEYBOARD`) and `MrScreens` tells `MrNav` when a screen is created and destroyed (`MrNav.opened`, `MrNav.born`, `MrNav.gone`; weak references only). When the person is back in the app they were typing in, the AI Editor dialog reopens (`MrAiDialog.reopenPendingDialog`) and the AI settings screen that the keyboard opened is closed with `MrNav.closeOpenedByKeyboard(MrAiPrefs.class)`:
   - `finishAndRemoveTask()` only when that screen is the root of the task **and alone in it** (`MrNav.aloneInTask`);
   - otherwise `finish()`: only that screen.
   - Not closed when a style editor is open, when the field they left belonged to this app itself, or when the screen was opened by the home screen (no extra).
6. **One title.** `MrScreens` gives every task of the app `setTaskDescription` with the name of the app, so a task that is listed shows "Mr Keyboard" whichever screen is on top.

## What changed from before

Until then the app was one task and one window, and nothing was hidden from the list (the person could see what was open and close it). Now the Settings keep no window in the list and start again from the first page: the task of the Settings is emptied at every opening, so nothing stale is left, and the exception for a draft keeps the one thing that could be lost.

## What does not change

- The Settings opened by the system (Settings > Languages & input > the gear of the keyboard) go on top of the task that opened them: Android decides that, an app cannot ask for another task there.
- The app does not finish the screens when the person leaves them by Home: a file picker or the system screens (permissions, notifications) are also "leaving", and finishing there would break them. They stay in the background, out of the list, until the next opening of the Settings empties the task.

## Tests

`nav_test/NavTest.java`: the flags from the keyboard (`0x10808000`, no `REORDER_TO_FRONT`, no `CLEAR_TOP`) for the five screens and for any context that is not a screen; the exception while a style is open (and not while it is finishing); the flags from a screen; the extra only on what the keyboard opens; the list of open screens; the close (the whole task only when alone in it); the one title on every screen; and the manifest (the affinity on every screen but the home screen and the helpers, no other affinity, no screen excluded, only the 3 helpers). `update_test/UpdateTest.java`: the flags of the notification. `ai_return_test/AiReturnTest.java`: the screen is closed when the dialog reopens, and the cases where it is not. `res_check.py` keeps the manifest and the flags in `MrNav`.

## Test on the phone

Do each one with the keyboard's *Autocompletar* on and off.
1. In another app: tap the gear of the keyboard, open "Dictionaries" from the Settings, then press **Home**. Open the **recent apps**: there is **no** window of the Settings. Tap the gear again: the Settings opens on its **first page**, not on the Dictionaries.
2. Gear → Settings → *Back* until it closes: you are in the app you were typing in, and the recent apps list has no window of the Settings.
3. Open the app by its **icon** (the home screen) and tap the button to the Settings: it opens, and *Back* returns to the home screen.
4. Open the AI Editor dialog → gear → the AI settings → return to the app by *Back*: the dialog reopens and the AI settings is closed (as before).
5. AI settings → *New style*, type a name without saving, tap *Back* to the other app, open the AI dialog and tap the gear again: the style editor is still there with the draft (the task was not emptied).
6. With the notification of a new version: tap it. The Settings opens with the update dialog, and it is not listed in the recent apps afterwards.
