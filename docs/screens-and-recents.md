# Screens opened by the keyboard and the recent apps

The app is **one task**, so it is **one window** in the list of recent apps. Every screen is in that task: the home screen (`Main`), the settings, the dictionaries, the AI Editor settings and its style editor, the sheets, "What the keyboard learned", "Add words and texts" and the key sounds. Nothing is hidden from the list: the person sees that the app is open there and can close it, so it does not stay in memory.

## Why there were two windows

The keyboard (a Service) has to start a screen with `NEW_TASK`. The screens used to have an affinity of their own (`com.mrkeyboard.app.screens`), so that *Back* returned to the app being typed in. That made a second task next to the one of the home screen: two entries in the recent apps. The first fix hid the second one (`excludeFromRecents`), and the person could no longer see, or close, what was still open.

## What is done

1. **One identity (manifest).** No screen has a `taskAffinity` of its own: the screens belong to the task of the package. `NEW_TASK` from the keyboard puts the screen on top of the task of the app when that is alive (and creates the task when it is not), so there is never a second task. No screen says `excludeFromRecents`; only the three translucent helper windows (voice, screenshot permission and picker) are left out of the list, because they exist for a moment.
2. **One title.** `MrScreens` gives the task `setTaskDescription` with the name of the app on every screen, so the entry is always listed as "Mr Keyboard", whichever screen is on top (not "Settings" or "Dictionaries").
3. **No copy of a screen on top of itself.** Every screen is `singleTop`. `MrNav.intent` adds `REORDER_TO_FRONT`: a screen that is already open is brought to the front, not stacked again (three taps on the gear do not need three Backs). `CLEAR_TOP` is not used (it would close what the person has open above the screen, such as a style being edited).
4. **Closed when it is not needed.** `MrNav.intent` marks what the keyboard opens (`EXTRA_FROM_KEYBOARD`) and `MrScreens` tells `MrNav` when a screen is created and destroyed (`MrNav.opened`, `MrNav.born`, `MrNav.gone`; weak references only). When the person is back in the app they were typing in, the AI Editor dialog reopens (`MrAiDialog.reopenPendingDialog`) and the AI settings screen that the keyboard opened is closed with `MrNav.closeOpenedByKeyboard(MrAiPrefs.class)`:
   - `finishAndRemoveTask()` only when that screen is the root of the task **and alone in it** (`MrNav.aloneInTask`): the entry goes;
   - otherwise `finish()`: only that screen, and whatever the person has open next to it (a text being typed in "Add words and texts", for example) stays.
   - Not closed when a style editor is open (`MrAiStyleActivity.isOpen()`: it may hold a draft that was not saved), when the field they left belonged to this app itself, or when the screen was opened by the home screen (no extra).

## What changes for *Back*

With one task, *Back* from a screen that the keyboard opened goes to the previous screen of the app when the app was already open (its home screen, for example), and one more *Back* returns to the app being typed in. When the screen was the only one, *Back* returns straight to that app.

## What is not done

- The app does not finish the screens when the person leaves them by Home: a file picker or the system screens (permissions, notifications) are also "leaving", and finishing there would break them. The person closes them from the recent apps.

## Tests

`nav_test/NavTest.java`: the extra only on what the keyboard opens, the list of open screens (by class, root or not, finishing, destroyed, two of the same class, a refusal), the close (the whole task only when alone in it), the one title on every screen, and the manifest (no affinity, no screen excluded, only the 3 helpers). `ai_return_test/AiReturnTest.java`: the screen is closed when the dialog reopens, and the cases where it is not. `res_check.py` keeps the manifest, the extra and the calls.

## Test on the phone

Do each one with the keyboard's *Autocompletar* on and off.
1. In another app: open the AI Editor dialog → gear → the AI settings → return to the app by the **recent apps**: the dialog reopens and the list shows **one** window, "Mr Keyboard", never two or more.
2. Same, returning by **Back**: the dialog reopens, and the list shows one window or none (when the AI settings was the only screen).
3. Open the app by its icon, then the gear of the keyboard in another app, then the dictionaries from the settings: the recent apps list has **one** "Mr Keyboard" card. Swipe it away: all the screens close.
4. Gear of the keyboard → Home → open the app by its icon: one window in the list.
5. Tap *New style*, type a name without saving, return to the app by the recent apps: the dialog reopens and the style editor is still there when you tap the gear again (the draft is kept).
