# Screens opened by the keyboard and the recent apps

The app should be **one window** in the list of recent apps (the home screen, `Main`). The screens that the keyboard opens (the gear of the keyboard, the gear of the AI Editor dialog, the style editor, the sheets) are a second task, and they must not show up there as a second (or a third) window.

## Why there are two tasks

From the keyboard (a Service) a screen has to start with `NEW_TASK`. The manifest gives these screens their own `taskAffinity` (`com.mrkeyboard.app.screens`), so that *Back* returns to the app that the person was typing in, not to the home screen of Mr Keyboard. That task (T2) is next to the one of the home screen (T1, the affinity of the app): two entries in the recent apps, and the one of T2 stayed there when the person left it by Home or by the recent apps instead of *Back* (for example: AI Editor → gear → settings → back to the other app by the recent apps; the dialog came back, the settings screen did not close).

## What is done (three layers)

1. **Out of the recent apps (manifest).** The 8 screens with that affinity (`LatinIMESettings`, `MrPacksActivity`, `MrAiPrefs`, `MrAiStyleActivity`, `MrLearnedActivity`, `MrSoundActivity`, `MrImportActivity`, `PrefScreenSheets`) say `android:excludeFromRecents="true"`. The attribute counts for the **root** of a task and any of them can be the root, so all have it. Result: T2 is never listed; the list shows `Main` only. The screens are still reached by the gear (`REORDER_TO_FRONT` brings the open one to the front).
2. **Marked and tracked.** `MrNav.intent` puts `EXTRA_FROM_KEYBOARD` on what the keyboard opens (not on what a screen opens: that one goes on the stack of the screen that opened it). `MrScreens` calls `MrNav.opened` when a screen is created and `MrNav.gone` when it is destroyed; `MrNav` keeps weak references only.
3. **Closed when it is not needed.** When the person is back in the app they were typing in, the AI Editor dialog reopens (`MrAiDialog.reopenPendingDialog`) and the AI settings screen that the keyboard opened is closed with `MrNav.closeOpenedByKeyboard(MrAiPrefs.class)`: `finishAndRemoveTask()` when it is the root of its task (the entry goes), `finish()` otherwise. Not closed when:
   - a style editor is open (`MrAiStyleActivity.isOpen()`: it may hold a draft that was not saved);
   - the field they left belonged to this app itself (the keyboard may be typing into that screen);
   - the screen was opened by the home screen (no extra): it is not the keyboard's to close.
   A refusal of the system is caught: the dialog comes back whatever happens.

## What is not done

- Nothing closes the screens when the app is opened by its icon: `Main` is T1, the screens of the keyboard are T2 and are not in the list. (A close there could lose a style that was being edited.)
- The app does not finish the screens when the person leaves them by Home: a file picker or the system screens (permissions, notifications) are also "leaving", and finishing there would break them.

## Tests

`nav_test/NavTest.java`: the extra only on what the keyboard opens, the list of open screens (by class, root or not, finishing, destroyed, two of the same class, a refusal), what `MrScreens` feeds it, and the manifest (all 8 excluded, `Main` not). `ai_return_test/AiReturnTest.java`: the screen is closed when the dialog reopens, and the cases above where it is not. `res_check.py` keeps the manifest, the extra and the calls.

## Test on the phone

Do each one with the keyboard's *Autocompletar* on and off.
1. In another app: open the AI Editor dialog → gear → the settings → return to the app by the **recent apps** (not Back): the dialog reopens, and the recent apps list shows **no** Mr Keyboard settings window.
2. Same, returning by **Back**: same result.
3. Same, but tap *New style* and type a name without saving, then return to the app by the recent apps: the dialog reopens and the style screen is still there when you tap the gear again (the draft is kept).
4. Open the app by its icon after the three above: only **one** Mr Keyboard window in the recent apps, never two or more.
5. Gear of the keyboard (settings) → Home → open the app by its icon: one window in the recent apps.
