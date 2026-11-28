# Keyboard sheets

The sheets are the extra pages of keys of the keyboard (123, TSK, HTML, FRS and the ones the person creates). The key at the bottom left
(its badge) goes through them in order: ABC, then each sheet, then ABC again. They are edited in *Settings → Keyboard sheets*.

## The page (PrefScreenSheets)

- **Header:** back, the title and how many sheets there are out of the limit (12).
- **ABC:** the main keyboard, always the first card of the list, with a padlock instead of up and down (see "ABC" below).
- **Return to the main sheet after typing** (`pref_sheet_return`, on by default): after a key of another sheet the keyboard goes back to ABC.
- **Your sheets:** one card per sheet, in the order of the cycle. A tap opens the editor; the arrows move it up or down; ⋮ has edit, name
  and badge, move, duplicate, restore (built-in sheets) and delete. The buttons are 40 dp and say what they do to TalkBack.
- **+ New sheet:** blank, number pad, arrows and editing, or a copy of a sheet; then the name and the badge. With 12 sheets the button says
  that the limit was reached.
- **Backup:** export and import a JSON file and restore the default sheets. The import reads at most 1 MB and a file with no sheet the app
  understands is refused with a plain message; what it finds replaces the current sheets after a confirmation.

Two quick taps open one thing only (700 ms between them): the editor is never opened twice.

## Name and badge (SheetNameDialog)

The same dialog on the page and in the editor. The name (up to 40 characters) opens with the keyboard and its text selected; the badge (up to
5 characters, in capitals) is what the key that switches sheets shows. An empty field keeps what was there.

## The editor (SheetEditorActivity)

- **Header:** the badge, the name and the count of rows and keys; a tap (or the pencil) changes the name and the badge. Undo is an icon,
  dimmed while there is nothing to undo (up to 20 steps; a name and badge that did not change leave no step).
- **+ Row** (up to 6) and **Arrange rows**: each row shows its number, how many keys it has and the labels of its keys, with up, down,
  duplicate and delete (a deleted row with keys says that Undo brings it back).
- **The grid** (SheetGridView): tap a key to edit it, "+" to add one, hold and drag to move it. A key dropped on another row that is full
  stays where it was and the editor says why. The ⌫ of the last row and the bottom row (badge, comma, space, period, Enter) are the same
  on every sheet. Under the grid, the legend of its colours: text (plain), Tasker (amber), sheet switch (blue), special (violet), gap
  (dashed).
- **Key editor** (KeyEditDialog): type (text, Tasker, special, switch sheet, gap), label, text, command, special key, target sheet, width
  (the preset that matches is lit) and long-press popup. Its content scrolls, so everything is reached with the keyboard open. A key being
  added has no actions row; an existing one has move left/right, duplicate and delete. In the popup list a "switch sheet" item shows the
  badge and name of its sheet.
- **One dialog at a time:** a second tap while a dialog of the editor is open is ignored.
- A sheet that no longer exists (deleted while the editor waited in the background) closes the editor with a note.

## ABC (MrAbcKeys)

ABC is edited as any sheet (rows, keys, widths, name, badge, undo), but it is always the first one:

- **On the page:** ABC is the first card of the list, with the same line as the others (rows, keys, kind) and a padlock where the others
  have up and down. Its ⋮ has edit, rename, duplicate and **Restore ABC**; Delete is greyed. A duplicate is a sheet of the person, the first
  one after ABC.
- **In the editor:** the same editor as the sheets (`EXTRA_SHEET_ID` = `abc`). It starts from the XML of ABC (kbd_qwerty read as a sheet:
  letters as text keys with the popup of the language, Shift, Ctrl, Alt, Tab, the arrows and the grid key as special keys, the room before
  the A row as gaps) or from ABC as edited. Delete is greyed and Restore ABC brings back the XML.
- **How it is kept:** nothing while ABC is the XML; otherwise the whole ABC in the preference `pref_abc_keys` (a JSON of rows of keys of the
  sheets). A key whose popup is the one of a key of the XML only names that key, so the accents follow the language of the keyboard; a name
  or badge that was not changed is not kept.
- **On the keyboard:** `KeyboardSwitcher.getKeyboard` calls `MrAbcKeys.apply` right after it reads a layout of ABC (also the 5-row ones). The
  rows above the bottom row are laid out again in the same room (the height of the keyboard and the bottom row of the XML stay): the keys of
  the system of the XML are moved to their new place (they keep their icons and states), the others are made as the keys of the sheets
  (`SheetKeyboardBuilder.configureKeyFromSpec`), a key that writes one letter gets its capital for Shift (`Keyboard.Key.mrSetCase`) and the
  delete key of the XML closes the last row, 1.5 wide, as on the sheets. A row wider than 10 is narrowed to fit. Then the keyboard finds its
  keys again (`finishCustomBuild`, `bindCustomSpecialKeys`). A broken preference leaves ABC as in the XML.
- **Badge:** the popup of sheets and a key that switches to ABC show the badge of ABC (`MrAbcKeys.badge`).
- **Backup:** the export of the sheets carries ABC (`abc`) when it was edited; an import of a file that has it replaces it, and a file without
  it leaves ABC as it is. *Restore the default sheets* does not touch ABC (it has its own Restore ABC).

## Quick test (MrSheetTest)

The test field at the bottom of the editor opens the keyboard on the sheet being edited and keeps it there while the person types in it, even
with *Return to the main sheet after typing* on. Edits apply at once.

How: the field puts `com.mrkeyboard.app.sheet=<id>` in its `privateImeOptions`. The keyboard honours it only for a field of this same app:

- `LatinIME.onStartInputView` (at the end) and `LatinIME.onWindowShown` (after it goes back to ABC) call `MrSheetTest.show`, which looks the
  sheet up by its id and goes there (nothing when it is already there, when the field asks for no sheet or the sheet is gone);
- `LatinIME.returnToMainSheet` asks `MrSheetTest.holds` before going back to ABC.

After a duplicate the editor edits the copy and the field asks for the copy at once (`restartInput`).

## Tests

`docs/tools/grid_test/SheetGridViewTest.java` (the grid), `docs/tools/sheets_test/SheetsTest.java` (the
quick test field, the texts the screens make, the import limit and the files, the hooks of ABC) and `docs/tools/abc_test/AbcKeysTest.java`
(ABC as a sheet: the XML read as a sheet, what is kept, the backup, the badge and the keyboard laid out again), all in
`docs/tools/run_java_tests.sh`; `docs/tools/test_sheet_test_field.py` runs the real
smali of `LatinIME.onWindowShown` and `returnToMainSheet` (the order of the hooks, every other field as before).
