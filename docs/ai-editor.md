# AI Editor ("Editor de IA")

## Opening from the toolbar

The `b_aied` button of the main bar is still the only way in. Its code (`0x18`) calls `MrAiDialog.toggle()` instead of selecting a keyboard panel.

`MrAiDialog` creates a `Dialog` attached to the IME window token (`TYPE_APPLICATION_ATTACHED_DIALOG`), using the same pattern as the "Preferências" (Preferences) dialog of `MrTune`: the window covers the area above the keyboard, the keyboard stays visible and the dialog follows size/orientation changes. Its own layout is in `res/layout/mr_ai_dialog.xml`.

Removed from the AI Editor flow: the `bar_ai`/`p_ai` panel, the integration with `MrTools.showPanel(5)`, the `barVisible()` query, the height adjustment of the panel inside the keyboard and the assembly of the panel during `MrTools.wrap`. The bar button no longer expands content inside the keyboard.

The dialog card uses the height of the current content and is centered in the area above the keyboard; if the content does not fit, it can scroll. The chips measure their own content and the horizontal strip lets the user reach all of them, including long labels. The header and the icon buttons are compact, with the glyphs centered, and "Emojificar" (Emojify) has a rounded checkbox that shows its state. "Criar" (Create) uses a vector add icon. The non-editable dialogs use `FLAG_NOT_FOCUSABLE` to keep the focus of the field while they appear above the keyboard, following the Android IME visibility guide. When the keyboard is hidden, `LatinIME.onWindowHidden()` closes both the AI Editor and the "Preferências" dialog of `MrTune`. Opening the settings or the style editor closes the AI Editor and marks a pending reopening; when returning to the original editor, `onWindowShown()` reopens the dialog. When the result is applied, it closes.

## Theme

The dialog uses `Theme.MrKeyboard.Dialog` exclusively and the settings palette (`mr_ui_*`, plus `mr_ai_scrim` in the background); the colors are read straight from the resources, with no fallback values in the code. Chips, result and buttons do not consult `MrTheme` or the keyboard colors (`MrTools.shotTab`, `fieldBg`, `flatBar` etc.), so changing the keyboard theme does not change the colors of the AI Editor. The rest of the keyboard keeps supporting its themes as usual.

## Structure

- `docs/tools/java/src/com/mrkeyboard/app/MrAi.java`: captures and validates the text, builds the dialog interface, calls the provider, updates the result and applies/copies the text. The network is only used after the person chooses a style.
- `docs/tools/java/src/com/mrkeyboard/app/MrAiDialog.java`: lifecycle of the dialog attached to the IME window and resizing above the keyboard.
- `MrAiPrefs`: settings for provider, model, key and styles; `MrAiStyleActivity`: creation/editing of the styles.
- `res/xml/prefs_ai.xml`: settings; `res/layout/mr_ai_dialog.xml`: modal interface; `MrNotice.aiEditor`: notice shown on the first opening.
- `MrTools.smali` keeps the manual hooks of the bar (button `b_aied`), calls the dialog through code `0x18` and ends the tool when the keyboard is released.

## Network and privacy

The request uses the Chat Completions-compatible endpoint configured in *Configurações → Editor de IA* (Settings → AI Editor). The key goes only in the `Authorization` header of that request. In password fields, the text is neither captured nor sent. The selected text — or the stretch before the cursor — is replaced only if it still matches the original; otherwise, the result can be copied.

The manifest does not enable HTTP traffic without TLS. Use an `https://` endpoint; the text of the address dialog (`mr_ai_endpoint_dlg`, in English, Portuguese and Spanish) states this requirement.

Only `https://` addresses are accepted, and the key is always required. The key is not kept in the default preferences: the value goes to the `mr_ai` file (`MrAi.apiKey`/`setApiKey`), which is not listed in `backup_rules.xml` or `data_extraction_rules.xml`, so it does not leave through cloud backup or device transfer. The `pref_ai_key` row is non-persistent and *Restaurar padrões* (Restore defaults) clears the value.

## Generation and checks

The `MrAi` and `MrAiDialog` classes have their source in `docs/tools/java/src` and smali generated in `smali/com/mrkeyboard/app/` by `docs/tools/build_java.sh`. `MrTools.smali` is still edited by hand. The Java build uses the stubs in `docs/tools/java/stubs` only to compile tests/generation; they do not go into the APK.
