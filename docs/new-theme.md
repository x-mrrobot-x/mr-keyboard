# How to add a theme to the keyboard

Each theme is a layout with a tag. Detection, flags, colors, drawables and registration all live in resources; the smali
only reads them (`MrTheme`, `KeyStyle`, `MrTools`). A new theme does not require touching the smali. Everywhere below,
`<tema>` is the tag name without the `mr_` prefix (`glass`, `midnight`...).

1. **Layout:** copy the closest one to `res/layout/input_mr_<tema>.xml`, with `android:tag="mr_<tema>"`,
   `latin:popupLayout="@layout/input_popup_<tema>"` and `latin:keyPreviewLayout="@layout/key_preview_<tema>"`. Every
   color in the layout comes from `@color/mr_<tema>_*`, with no hex.
2. **Flags** (`res/values/mr_themes.xml`): one line in `mr_theme_tags` with the tag (`mr_<tema>`) and one in
   `mr_theme_flags`, at the same position, with the theme's bits (flat bar, accent keys, wide accent group,
   translucent, tech palette, default text on accent keys). The bits are described at the top of
   `smali/com/mrkeyboard/app/MrTheme.smali` and in the comment of `mr_themes.xml`; `0x01` (`INIT`) belongs to `MrTheme` and
   is not part of the value. Every theme with a tag turns on `ACCENT_KEYS` (`0x04`) and brings its own accent selector (item 5).
   `ACCENT_WIDE` (`0x08`) widens the accent group (item 5); all themes turn it on.
3. **Registration** (`res/values/mr_themes.xml`): one line in `mr_theme_layouts`. The index is the value stored in
   `pref_keyboard_layout`. This array is per preference value (several values may open the same layout);
   `mr_theme_tags` and `mr_theme_flags` are per theme. The key layers' radius has no registration (item 5).
4. **Selector:** the name in `keyboard_layout_modes` (and in the translations) and the value in `keyboard_layout_modes_values`.
5. **Keys:** `btn_keyboard_key_<tema>` and `key_<tema>_{normal,pressed,on,lock,hl}`. The drawables only reference
   `@color`, with no hex: the colors live in `res/values/mr_key_colors.xml`, named
   `mr_<tema>_key_<estado>_<parte>` (state `normal`, `pressed`, `hl`, `on`, `lock` or `acc_<estado>`; part `halo`, `base`,
   `fill`, `top`, `mid`, `bottom`, `stroke` or `shadow`). The neutral shadows that repeat across themes are global:
   `mr_key_shadow`, `mr_popup_shadow` and `mr_preview_shadow`. **Accent keys** (Shift,
   Delete, arrows, Tab, 123, Space, Enter...): `btn_keyboard_key_<tema>_accent`. The accent **replaces** the key's
   background, so the selector must bring everything (shadow, halo, border). There are two ways: dedicated drawables
   `key_<tema>_acc_{normal,pressed,on,lock}` (Neon, Soft and Glass) or reusing `key_<tema>_hl` (rest) and the theme's own
   `pressed/on/lock` (Slate and Midnight), so that sticky keys and accent keys are
   customized together, in a single set of files. `LatinKeyboardBaseView` reads the selector by name, from
   the tag; without it, the key gets the normal background.
   **Key layer radius:** at runtime the last layer of the `layer-list` (the border, which is the key) gets the
   keys' radius (`pref_key_radius`), and each outer layer adds the gap that the drawable itself draws: the last layer's
   left inset minus the layer's own (`KeyStyle.layerGap`, never negative). A halo inset 2 dp less than the
   border (Neon and Soft) ends up with radius + 2 dp, and corners stay concentric. A shadow that is only offset vertically (Slate and
   Midnight) and a single shape (Glass) have no side gap and get the keys' radius. A new theme only needs to inset the
   outer layers in the XML; the radius written in them is a fallback. Keep the inner layer last.
   Which keys are accent keys (`isAccentKey` in `LatinKeyboardBaseView`, the same for all themes): a fixed list of
   codes (Shift, Delete, Tab, Ctrl, Alt, ❖, arrows, Home/End, PgUp/PgDn and the bar key) and, with `ACCENT_WIDE`,
   also every key marked `android:isModifier="true"` (F1, Fn, F keys, Ins, ".", settings...), the Tasker
   keys (text `tskcmd:`), 123/TSK (`-300`), the phone keyboard's 123 (`-2`), Space and Enter. A theme that does not
   want the wide group turns off only `ACCENT_WIDE`. Note: the theme's `hl` state is also applied by
   `LatinKey.isHl` (its own list plus `tskcmd:`), so the accent and `hl` must go together in each theme (in Slate and
   Midnight the accent is the `hl` itself).
6. **Long-press popup:** `input_popup_<tema>`, `popup_<tema>_bg`, `btn_keyboard_key_popup_<tema>` and
   `key_popup_<tema>_pressed`, for every theme (including Neon, with green halo and border). The `styles.xml` default for a
   layout without `popupLayout` is `input_popup_slate`, and the `keyBackground` default is `btn_keyboard_key_slate` (the default theme).
7. **Preview bubble:** `key_preview_<tema>`, `preview_<tema>_bg` and `preview_<tema>_more_bg`. `LatinKeyboardBaseView`
   reads the two drawables by name (`preview_<tema>_bg` and `preview_<tema>_more_bg`) from the tag and, if it does not find them,
   uses `keyboard_key_feedback_background` and `keyboard_key_feedback_more_background`.
   **Radii (keys, popup and preview):** the radius written in the drawables is only a fallback. At runtime `KeyStyle` swaps it for the
   keys' radius (`pref_key_radius`) plus a gap: preview bubble +2 dp and popup background +8 dp
   (`LatinKeyboardBaseView`), buttons, fields and bar panels through `MrTools` (`KeyStyle.radiusPx`). With radius 0 on the
   keys everything is square; a new theme needs no code for this.
8. **Theme colors** (`res/values/mr_colors.xml`): `mr_<tema>_kbd_bg`, `_text`, `_cursor`, `_hint`;
   `_popup_bg_{top,bottom,stroke}`, `_popup_key_{top,bottom,stroke}` (Soft also has `_mid`; Neon has `_popup_halo` and
   `_popup_key_halo`) and `_popup_hint`;
   `_preview_{top,bottom,stroke,dots}`. If the theme does **not** turn on `PLAIN_ACCENT_TEXT`, the text and icon of the accent
   keys use `mr_<tema>_accent_text` (without it, `mr_accent_text` applies, white); with the flag, they use the theme's default text.
9. **Panel colors:** only if the theme needs different colors, declare `mr_<tema>_panel_<papel>` in
   `res/values/mr_colors.xml`. Without the theme's version, `mr_panel_<papel>` applies. The roles are `bar`, `btn`,
   `btn_stroke`, `tab_off`, `tab_off_stroke`, `tab_on_text`, `tab_off_text`, `field`, `field_stroke`, `card` and `icon`.
   The panels (Clipboard, languages, Attachments and emotes) have no frame in any theme: in the flat themes the background is `panel_bar`.
   Attachments' own roles (without the `panel_` prefix, also with a `mr_<tema>_<papel>` version when the theme needs it):
   `attach_fab`, `attach_fab_stroke`, `attach_fab_icon` (picker button), `sel_cancel`, `sel_cancel_stroke`,
   `sel_cancel_text`, `sel_send`, `sel_send_stroke`, `sel_send_text` (Cancel/Send bar and the check on the selected item),
   `sel_media` (layer over the selected thumbnail) and `sel_card` (background of the selected file).
10. **Check:** `python3 docs/tools/res_check.py` and `python3 docs/tools/smali_regcheck.py smali/ --base <smali anterior>`.
    `res_check` warns if the registration arrays do not match (`mr_theme_tags` with `mr_theme_flags`, a value of
    `keyboard_layout_modes_values` outside `mr_theme_layouts`, and invalid flag bits), if the layout's tag is not in `mr_theme_tags`, if
    the default color of a role is missing, if any resource from items 5 to 7 is missing (including the accent selector and the drawables it references), if the theme's layout does not point to its popup and
    preview, if a hex color is left in the theme's layouts or drawables, if the `input_mr_*`, `input_popup_*` and `key_preview_*` differ
    from each other beyond the theme name, or if the theme name does not exist in the 3 languages.

## Naming convention

- What applies to all themes, or is decided by a `MrTheme` flag, gets a generic name: `isAccentKey`,
  `drawAccentFill`, `getAccentContentColor`, `applyTranslucentBlur`, `MrTranslucentBlur`, `flatBar()`, `translucent()`.
- What exists for only one theme gets its name (`neon`, `soft`, `slate`, `midnight`, `glass`), as in the resources
  `mr_<tema>_*`, `key_<tema>_*` and `input_popup_<tema>`.
- A theme name does not go into a method, field or class that serves more than one theme.
