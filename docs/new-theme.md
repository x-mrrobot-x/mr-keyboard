# How to add a theme to the keyboard

Each theme is a layout with a tag. Detection, flags, colors, drawables and registration all live in resources; the smali
only reads them (`MrTheme`, `KeyStyle`, `MrTools`). A new theme does not require touching the smali. Everywhere below,
`<tema>` is the tag name without the `mr_` prefix (`glass`, `midnight`...).

The **generated themes** follow every item below, but nobody writes their files: a script does, from three tables. They
are Midnight Steel and Denim (dark), the neon ones (Aurora, Neon Cyan, Neon Purple, Neon Pink, Synthwave) and Aqua, Snow, Chrome and Rose (light, except Chrome: light keys on a dark background);
only Cobalt Glass is written by hand. To add or change one of the generated ones, go straight to
[Generated themes](#generated-themes).

1. **Layout:** copy the closest one to `res/layout/input_mr_<tema>.xml`, with `android:tag="mr_<tema>"`,
   `latin:popupLayout="@layout/input_popup_<tema>"` and `latin:keyPreviewLayout="@layout/key_preview_<tema>"`. Every
   color in the layout comes from `@color/mr_<tema>_*`, with no hex.
2. **Flags** (`res/values/mr_themes.xml`): one line in `mr_theme_tags` with the tag (`mr_<tema>`) and one in
   `mr_theme_flags`, at the same position, with the theme's bits (flat bar, accent keys, wide accent group,
   translucent, tech palette, default text on accent keys, glow, spectrum). The bits are described at the top of
   `smali/com/mrkeyboard/app/MrTheme.smali` and in the comment of `mr_themes.xml`; `0x01` (`INIT`) belongs to `MrTheme` and
   is not part of the value. Every theme with a tag turns on `ACCENT_KEYS` (`0x04`) and brings its own accent selector (item 5).
   `ACCENT_WIDE` (`0x08`) widens the accent group (item 5); all themes turn it on. `GLOW` (`0x80`) and `SPECTRUM`
   (`0x100`, only together with `GLOW`) are the light of the neon themes (section below).
3. **Registration** (`res/values/mr_themes.xml`): one line in `mr_theme_layouts`. The index is the value stored in
   `pref_keyboard_layout` (the id of the theme: Midnight Steel 0, Aurora 1, Neon Cyan 2, Neon Purple 3, Neon Pink 4,
   Synthwave 5, Aqua 6, Snow 7, Chrome 8, Rose 9, Cobalt Glass 10, Denim 11). The id is the position in the list, so a theme put in
   the middle moves the ones after it (nothing is kept for older installs); for the generated themes the script writes the
   three lists from its `ORDER`. `mr_theme_tags` and `mr_theme_flags` are per theme, in the same order.
   The key layers' radius has no registration (item 5).
4. **Selector:** the name in `keyboard_layout_modes` (the name of a theme is in English in every language: it is in `values/strings.xml` only, `layout_mr_<tema>`) and the value in `keyboard_layout_modes_values`.
5. **Keys:** `btn_keyboard_key_<tema>` and `key_<tema>_{normal,pressed,on,lock,hl}`. The drawables only reference
   `@color`, with no hex: the colors live in `res/values/mr_key_colors.xml`, named
   `mr_<tema>_key_<estado>_<parte>` (state `normal`, `pressed`, `hl`, `on`, `lock` or `acc_<estado>`; part `halo`, `base`,
   `fill`, `top`, `mid`, `bottom`, `stroke` or `shadow`). The neutral shadows that repeat across themes are global:
   `mr_popup_shadow` and `mr_preview_shadow`. **Accent keys** (Delete,
   arrows, Tab, 123, Space, Enter...): `btn_keyboard_key_<tema>_accent`. Ctrl, Alt, Shift and ❖ are accent keys too, with one
   difference: they always show the resting accent face (only a touch changes it) and a small lower dash tells their state
   (`LatinKeyboardBaseView.drawModifierIndicator`), instead of the `on`/`lock` faces. Define `mr_<tema>_modifier_indicator_off`,
   `_on` and `_lock` in `res/values/mr_colors.xml` (and the `mr_modifier_indicator_*` fallback); Shift uses all
   three colors, while Ctrl, Alt and ❖ use off/on. Choose them against the accent face, not the normal one, always in the hue of the
   theme: `off` a subdued tone of the face (contrast about 1.3), `on` the theme's interaction color, moved towards white (towards
   black on a bright face) until it has about 3.8 of contrast, and `lock` a red turned a little towards the hue of the accent
   keys, with about 3 of contrast. The generated themes get these three from `dash_colors()` in `make_themes.py`; Snow and Midnight Steel name
   some of them and Aqua its lit and locked ones (see [Solid](#solid)).
   Pressed fills follow the same theme hue, and their border uses
   `mr_<tema>_press_accent` (item 8). The accent **replaces** the key's
   background, so the selector must bring everything (shadow, halo, border). There are two ways: dedicated drawables
   `key_<tema>_acc_{normal,pressed,on,lock}` (Glass and every generated theme) or reusing `key_<tema>_hl` (rest) and the theme's own
   `pressed/on/lock` (no theme does today), so that sticky keys and accent keys are
   customized together, in a single set of files. `LatinKeyboardBaseView` reads the selector by name, from
   the tag; without it, the key gets the normal background.
   **Key layer radius:** at runtime the last layer of the `layer-list` (the border, which is the key) gets the
   keys' radius (`pref_key_radius`), and each outer layer adds the gap that the drawable itself draws: the last layer's
   left inset minus the layer's own (`KeyStyle.layerGap`, never negative). A halo inset 2 dp less than the
   border (the neon themes) ends up with radius + 2 dp, and corners stay concentric. A shadow that is only offset vertically (the solid and gloss themes) and a single shape (Glass) have no side gap and get the keys' radius. A new theme only needs to inset the
   outer layers in the XML; the radius written in them is a fallback. Keep the inner layer last.
   Which keys are accent keys (`isAccentKey` in `LatinKeyboardBaseView`, the same for all themes): a fixed list of
   codes (Shift, Delete, Tab, Ctrl, Alt, ❖, arrows, Home/End, PgUp/PgDn and the bar key) and, with
   `ACCENT_WIDE`, also every other key marked `android:isModifier="true"` (F1, Fn, F keys, Ins, ".", settings...), the Tasker
   keys (text `tskcmd:`), 123/TSK (`-300`), the phone keyboard's 123 (`-2`), Space and Enter. A theme that does not
   want the wide group turns off only `ACCENT_WIDE`. Note: the theme's `hl` state is also applied by
   `LatinKey.isHl` (its own list plus `tskcmd:`), so the accent and `hl` must go together in each theme (the generated themes
   draw `hl` like the resting face of the accent keys).
6. **Long-press popup:** `input_popup_<tema>`, `popup_<tema>_bg`, `btn_keyboard_key_popup_<tema>` and
   `key_popup_<tema>_pressed`, for every theme (including the generated ones). The `styles.xml` default for a
   layout without `popupLayout` is `input_popup_midnight`, and the `keyBackground` default is `btn_keyboard_key_midnight` (the default theme).
7. **Preview bubble:** `key_preview_<tema>`, `preview_<tema>_bg` and `preview_<tema>_more_bg`. `LatinKeyboardBaseView`
   reads the two drawables by name (`preview_<tema>_bg` and `preview_<tema>_more_bg`) from the tag and, if it does not find them,
   uses `keyboard_key_feedback_background` and `keyboard_key_feedback_more_background`.
   **Radii (keys, popup and preview):** the radius written in the drawables is only a fallback. At runtime `KeyStyle` swaps it for the
   keys' radius (`pref_key_radius`) plus a gap: preview bubble +2 dp and popup background +8 dp
   (`LatinKeyboardBaseView`). The buttons, fields and cards of the bar have their own fixed corners (`MrTools.radius(2)`, 10 dp)
   and do not follow the keys' radius. With radius 0 on the keys, the keys, popup and preview are square; a new theme needs
   no code for this.
8. **Theme colors** (`res/values/mr_colors.xml`): `mr_<tema>_kbd_bg`, `_text`, `_cursor`, `_hint`;
   `_popup_bg_{top,bottom,stroke}`, `_popup_key_{top,bottom,stroke}` and `_popup_hint`;
   `_preview_{top,bottom,stroke,dots}`, plus `mr_<tema>_press_accent` (the interaction hue). Point the pressed-key edge,
   popup selected-key edge and preview stroke at that same token; make each fill a brighter, theme-tinted shade rather than
   a shared gray or cyan. (The generated themes keep their colors in `res/values/mr_solid_colors.xml`,
   `mr_gloss_colors.xml` and `mr_neon_colors.xml`, under the names listed in the section below.) If the theme does **not** turn on `PLAIN_ACCENT_TEXT`, the text and icon of the accent
   keys use `mr_<tema>_accent_text` (without it, `mr_accent_text` applies, white); with the flag, they use the theme's default text.
   The fonts tool draws the chosen font in `accent_text` on the `ctrl_bg` face on every theme, so a theme whose accent keys
   are bright declares `mr_<tema>_accent_text` whatever its flag (the generated ones always do).

   **Light theme:** there is nothing to declare. A theme whose `_text` is dark (brightness of at most 0.5) is a light
   theme and the code adapts by itself: the tool bar takes a dark accent (`MrTools.deriveColors`), and from Android 15
   on the buttons the system draws under the keyboard are asked for in a dark color (`MrLight.bars`). Dark labels and
   icons, on any theme, are drawn without the dark outline that the light ones get (`MrLight.shadowRadius`, key by
   key). What a light theme still has to do itself is give its own values to the panel roles of item 9 whose defaults
   are made for a dark keyboard (`panel_btn`, `panel_icon`, `panel_tab_*`, `sel_*`, `attach_fab*`).

   **Light labels on colored highlight keys** (Aqua: foam labels on sea blue): two roles, both with a default of 0 that changes
   nothing, read once per keyboard view (`LatinKeyboardBaseView.mrRoles`). `mr_<tema>_accent_hint` is the color of the small
   letters and dots of the highlight keys, where the hint of the layout (`_hint`, made for the face of the letter keys) does not
   read. `mr_<tema>_label_shadow` is the shade around the light labels and icons, in place of the black one of the keyboard style
   (`mr_default_key_shadow`): a tone of the theme, with its own opacity.

   **Keys and background of opposite brightness** (light keys on a dark background, as Chrome): the text of the layout is
   the ink of the keys, and the bar, the panels, the suggestions and the buttons of the system under the keyboard sit on the
   background, so the label ink would be unreadable there. The theme declares `mr_<tema>_tool_ink`, the ink of what sits on
   the background, and `mr_<tema>_tool_hint`, its secondary text (`MrTools.wrap` takes them in place of the layout's
   text and hint; default 0 = the layout's, as in every other theme). They also decide, in place of `_text`, whether the
   tools and the system buttons are those of a dark or of a light theme. The small letters of the keys (`_hint`) are on
   the faces of both tones, so they have to read on both. The cards of the clipboard are keys (the key drawable is their
   background), so their text and icon keep the ink of the keys (`MrTools.sKeyText`, the `_text` of the layout), not `tool_ink`.
9. **Toolbar colors (Ctrl key):** the buttons of the bar get their colors from the theme's Ctrl key (highlight keys), never from fixed
   grays. A theme only needs `mr_<tema>_ctrl_bg` in `res/values/mr_colors.xml`, pointing at the face color of its own highlight
   key in `mr_key_colors.xml` (e.g. `@color/mr_<tema>_key_hl_top` or `@color/mr_<tema>_key_acc_normal_top`), so changing the key
   changes the bar. From that single color:
   - **Tool button pressed** (`b_*` and emote tabs, `MrTools.flatBg`): `ctrl_bg` as it is, at the opacity of `alpha_flat`
     (`mr_<tema>_alpha_flat` when the face is bright and the default `mr_alpha_flat`, made for dark faces, is too strong);
   - **Inner buttons** (back, language, attachments, clear..., `MrTools.softBg`): the accent, which `MrTools.deriveColors` obtains
     by lightening `ctrl_bg` (same hue, brightness at least 0.86, saturation at most 0.60; on a light theme by darkening it,
     brightness at most 0.40), at the opacity of `alpha_btn` (and
     `alpha_press` on touch), with no border. The unselected Attachments tabs use `alpha_tab_off`, the border of the
     translation field the same `alpha_btn` as the buttons next to it, and the selected row of the language lists `alpha_sel`.
     That derivation is right on a dark theme (a pale, vivid tint), but on a light one it turns the face into a dark, dull tone
     (grey where the face is neutral, as in Snow): a light theme declares the role `tool_tint`, the vivid color of the theme,
     which `deriveColors` then uses as it is (default `mr_tool_tint` = 0: derived from `ctrl_bg`); its `alpha_btn`,
     `alpha_tab_off`, `alpha_sel` and `alpha_card` are a little higher. The generator does all this for the light themes.
     The vivid color is the accent, unless the accent is foreign to the palette (Snow is neutral, with a bright blue
     accent): then the table gives `tint`, a tone of the palette itself (slate on Snow), which colors the
     buttons, tabs, field border and secondary texts of the tools, while the accent stays on the lit dash and the selection.
   - **Rim of the panes** (only Cobalt Glass): a theme of glass panes declares `mr_<tema>_pane_rim`, and every pane of the tools that
     has a fill and no border of its own (inner buttons, tabs, cards, the selected row, a tool of the bar under the finger) is
     outlined with 1 dp of that color (`MrTools.rim`, called by `MrTools.rrect`). Default `mr_pane_rim` = 0: no rim.
   - **Field and divider:** the field of the translation is `panel_field` (transparent by default) with an outline in the accent
     at `alpha_btn`; a theme that wants another outline declares `mr_<tema>_panel_field_stroke`. The line between the two lists
     of the language panel is `panel_divider` (default: the grey `mr_tb_divider`).
   - **Secondary texts** (the placeholder of the field, "Tap to insert", the empty state, the small letters of the keys) take the
     key hint color (`_hint`), so a light theme gives it life instead of a mix of the ink with a pale face: the vivid color
     leaning to the ink, as far as the contrast with the background and the keys asks (`lively()` in the script).

   The toolbar rows (`bar_main`, `bar_t`, `bar_c`, `bar_s`, `bar_e`, `bar_tune`) and the panels (`p_clip`, `p_lang`, `p_shots`,
   `p_emote`) have no background of their own in any theme: the bar root copies the keyboard's (`mr_<tema>_kbd_bg`) in
   `MrTools.wrap`, so bar, panels and keys share one color, defined only in `kbd_bg` (in a see-through theme the root carries the
   one sheet and the keyboard view is clear: `MrTools.applyTranslucentBlur`). The keys must contrast with `kbd_bg`: when
   changing it, re-check `normal` and `hl` in `mr_key_colors.xml`.

   Other panel colors, only if the theme needs different ones, are declared as `mr_<tema>_panel_<papel>` (without the theme's
   version, `mr_panel_<papel>` applies). The roles are `btn` (file card of Attachments in the flat themes), `card`, `field`,
   `icon`, `tab_on_text` and `tab_off_text`.
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
    After touching a generated theme, also `python3 docs/tools/make_themes.py --check` (the automatic checks run it).

## Generated themes

Three families of themes are written by `docs/tools/make_themes.py`, each from its own table in the script: `SOLID` and `GLOSS`
(plain keys and keys with a sheen) and `NEON`. A family is a look; inside it a theme is a handful of colors, and everything else (16 drawables, 3
layouts and from 60 to 140 colors per theme) is derived from them. For each line of a table the script writes everything
the items 1 to 9 ask for.

**A new theme of one of the families, or a change to one:** edit its table and run the script at the project root.

```
python3 docs/tools/make_themes.py            # writes the files
python3 docs/tools/make_themes.py --check    # writes nothing; fails if a file is not what the tables give
python3 docs/tools/res_check.py
```

The first three fields are the same in the three tables:

| Field | What it is |
| --- | --- |
| `tag` | name in files and colors (`mr_<tag>_...`). Lower-case letters only, not the start of another tag, and not a word, or a piece of a word, that the theme layouts already use (`key`, `text`, `popup`...): `res_check.py` compares the layouts of all themes with the tag blanked out |
| `value` | value stored in `pref_keyboard_layout` (position in `mr_theme_layouts`, the id of the theme). The id is the position in `ORDER`, and ids are not kept between versions (nothing migrates the setting of an older install), so put the theme where it belongs in the list |
| `names` | name in the "Keyboard theme" list: one string for all three languages (the themes have English names everywhere), or (English, Portuguese, Spanish) |

The script never removes a theme: take it out of its table and delete its files and lines by hand (`res_check.py` lists
what was left behind).

**What it writes.** `res/drawable/` and `res/layout/`: the files of items 1, 5, 6 and 7. `res/values/mr_neon_colors.xml`,
`mr_solid_colors.xml` and `mr_gloss_colors.xml`: every color of the themes of each family; the whole files are generated,
do not edit them. In `mr_themes.xml`, `arrays.xml` and the three `strings.xml`, only its own lines. The list of the setting is
`ORDER` in the script: Midnight Steel, the neon ones, Aqua and the other light ones, Cobalt Glass (written by hand) and Denim last.

### Neon

A neon theme is a thin bright tube around each key, light that fades into the key and out of it, and labels and icons
that shine. The other fields of its table:

| Field | What it is |
| --- | --- |
| `bg` | keyboard background (also the bar and the panels) |
| `key` | hue of the keys: tube, light, tint of the face and of the letters |
| `accent` | hue of the highlight keys (Delete, arrows, Space, Enter...) in a two-color theme; without it they take `key`, with more light |
| `core` | color of the tube itself, when it is not the hue with a little white (the white neon) |
| `text` | color of the letters, when it is not the hue with 72% of white |
| `spectrum` | three hues (left edge, middle, right edge of the keyboard): turns on `SPECTRUM` |
| `glow` | strength of the light of labels and icons, 0 to 1 |
| `lite` | a lighter key: 7 layers instead of 11 (every neon theme but Synthwave) |
| `flat` | turns on `FLAT_BAR`: the bar, the tabs and the file cards are flat, like the ones of a solid theme (every neon theme but Synthwave) |
| `roles` | as in a solid theme (table of the Solid section), with the `NEON_OWN_ROLES` of the script: `tool_tint`, `alpha_btn`, `alpha_tab_off`, `alpha_sel`, `alpha_card`, `alpha_press`, `panel_btn`, `panel_field`, `panel_field_stroke`, `panel_divider`, `accent_hint`, `label_shadow`. A neon theme that sets them puts its tools on a scale of one hue instead of the tint derived from the background: `INDIGO` (Aurora), `CYAN`, `PURPLE` and `PINK`, the hue of their keys over the background, named by lightness. The script builds the roles with `tool_roles()` from a scale and one of `TOOL_ALPHAS_TOP` (dark hues) or `TOOL_ALPHAS_MID` (a bright hue, Cyan) |

**How a neon key is drawn** (the reasons are in the comment at the top of the script):

| Layers | Inset and width (dp) | Colors `mr_<tema>_key_<estado>_...` |
| --- | --- | --- |
| 3 strokes, the light around the key | insets 0 / 0.67 / 1.34, each reaching under the tube | `halo1`, `halo2`, `halo3` |
| 1 gradient, the face (opaque) | inset 2 | `top`, `bottom` |
| 6 strokes, the light that fades into the face | inset 2, widths 6.5 to 1.5 | `in1` ... `in6` |
| 1 stroke, the tube | inset 2, width 1 | `stroke` |

A `lite` key keeps what is seen and drops what is not: 2 strokes of halo (insets 0 and 1) and 3 inner strokes (widths 5.17, 3 and
1.5), the ones nearest to the tube, which is 7 layers (`HALO_INSETS_LITE`, `LITE_INNER_WIDTHS` and `lite_state()` in the script).
Colors `halo3`, `in4`..`in6` do not exist in such a theme.

The states are `normal`, `hl`, `pressed`, `on`, `lock` and `acc_{normal,pressed,on,lock}`. The preview bubble and the popup
of variants are the same recipe with 4 inner strokes (2 in a `lite` theme), in the colors `mr_<tema>_bubble_*`. Three rules that are easy to break
when changing the recipe:

- every band of light starts at the tube and is simply longer than the next one. Insets are cut to whole pixels and
  stroke widths are rounded, so bands laid side by side leave gaps or overlap by a pixel on some screens;
- a shape that only has a stroke also carries `<solid android:color="@android:color/transparent" />`. Without it, Android
  fills the shape with black whenever it is drawn through a color filter, which is how the spectrum themes draw;
- the tube is the last layer: `KeyStyle` gives the last layer the key radius and each other layer the radius plus its
  distance to it (item 5).

**The light of labels and icons** cannot be done by a drawable. It is in `MrGlow`
(`docs/tools/java/src/com/mrkeyboard/app/MrGlow.java`, part of the Java layer: `docs/tools/build_java.sh` turns it into
`smali/com/mrkeyboard/app/MrGlow.smali`), switched on by the flag `GLOW`. `LatinKeyboardBaseView` calls it at nine points
(once per key before its face, in place of `KeyStyle.drawKey`, before the label, before the label of a dead key, in place of
`ShadowDrawHelper.draw`, for the icon color, before the dash of Ctrl/Alt/Shift, for the hint letters and when the preview
bubble is filled); on a theme without the flag each call does what the keyboard did before. The colors are the roles `glow` (normal keys) and
`accent_glow` (highlight keys); the opacity of the color is the strength of the light. The dash of Ctrl, Alt and
Shift shines when it is lit, in its own color; the unlit one (`modifier_indicator_off`) does not. Its three colors come
from `dash_colors()` of the script, like in every generated theme (below).
`MrGlow` uses only text shadows, the bitmap blur of `ShadowDrawHelper` and color filters, because the keyboard window may
or may not be hardware accelerated (`MrAccel`) and those three behave the same in both. A blur mask filter does not.

**Spectrum themes** (flag `SPECTRUM`: Aurora). Each key of the main keyboard takes its hue from where it is, between the
roles `spectrum_start`, `spectrum_mid` and `spectrum_end`, leaning a little from one row to the next. The drawables are
written in ONE hue (the color of the role `glow`); each key draws them through a color matrix that moves that hue to
its own, and the label, the hint letters, the icon and the dash go through the same matrix, except the locked dash of Shift
(the role `modifier_indicator_lock`), which keeps its reddish color so it still tells "locked" apart. Highlight keys take the
hue of their place, with the stronger light of their state. The preview bubble and the popup of variants keep the hue of the
drawables.

**Tests.** `docs/tools/glow_test/GlowTest.java` (run by `docs/tools/run_java_tests.sh`): what each of the nine calls
does on a plain theme, on a neon theme and on a spectrum theme.

### Solid

A solid theme is plain keys in two tones, one for the letters and one for the highlight keys, and one vivid color for
what is being touched. Nothing shines and no code is involved: it is all drawables and colors. The other fields of
its table:

| Field | What it is |
| --- | --- |
| `bg` | keyboard background (also the bar and the panels) |
| `key` | face of the letter keys |
| `mod` | face of the highlight keys (Ctrl, Alt, Shift, Tab, arrows, Space, Enter...): the second tone |
| `text` | labels and icons of the letter keys. A dark one makes the theme a light theme (item 8); a light one a dark theme, which also carries `TECH_PALETTE` |
| `accent` | the vivid color: the key under the finger, the lit dash of Ctrl, Alt and Shift, the chosen variant of the popup, the edge of the preview bubble, the Send button of the attachments |
| `mod_text` | labels and icons of the highlight keys, when their face asks for another color than `text`. Without it the theme carries `PLAIN_ACCENT_TEXT` |
| `lip` | height in dp of the darker edge under each key, which makes it look like a keycap (1 by default, 2 = taller, 0 = flat) |
| `clear` | for a see-through background: (opacity without blur behind the keyboard, opacity with it), as in a gloss theme. The theme then carries `TRANSLUCENT` and declares `kbd_bg_blur` besides `kbd_bg`; the keys stay solid |
| `roles` | for a theme whose colors are all chosen instead of derived (Midnight Steel, Snow, Aqua, Rose): `{role: color}`. Each entry replaces the derived color of that role (`hint`, `key_pressed_fill`, `alpha_btn`, `sel_send`...) or declares one that only has a default (`OWN_ROLES` in the script: `alpha_press`, `panel_field`, `panel_field_stroke`, `panel_divider`, `accent_hint`, `label_shadow`, `tool_tint`) |

**How a solid key is drawn:**

| Layers | Inset (dp) | Colors `mr_<tema>_key_<estado>_...` |
| --- | --- | --- |
| 1 shape, the lip (left out when `lip` is 0) | top = `lip` | `lip`: the face with 45% of black, or 20% on a light face |
| 1 shape, the face | bottom = `lip` | `fill` |

The face is the last layer, so `KeyStyle` gives it the key radius and puts it at half the key spacing from the cell
edge; the lip has the same side insets and gets the same radius. The states are `normal`, `pressed`, `on`, `lock` and
`acc_{normal,pressed,on,lock}`: each face is the one at rest with a share of the accent (`SOLID_STATES` and
`SOLID_ACCENT_STATES` in the script), and `key_<tema>_hl` is drawn like `acc_normal`. The preview bubble and the popup of
variants are a plain face (`bubble_fill`: the letter keys with a little white) with a 1 dp edge over a soft shadow; the
variant under the finger is `popup_key_fill`.

**A theme of chosen colors (Aqua).** Aqua derives almost nothing (only the unlit dash, by the rule below): the script keeps its scale (`AQUA`: one hue of water in thirteen
steps, from foam to deep sea) and the table gives every role one of those steps, so that any two colors of the theme belong
together. Foam letter keys with a soft aqua edge under them (`lip` 1.5) on shallow water, sea blue highlight keys with a deep
edge, deep sea ink. In the tools the tint (step 600) lands on steps of the scale at the opacities of `alpha_*`: tabs that are
off = 200, buttons = 300, selected row = 400, a button under the finger = 500; the field and the cards are foam, as the keys.
The lit dash is foam and the locked one coral, told apart by hue (the rule below would make both dark on the sea blue).
Not themed, in any theme: the panel of the adjustments in landscape, which is a dark sheet over the keyboard in the style of
the dialogs of the app.

**A light theme that keeps the colors it had (Rose).** Same method as Midnight Steel and Snow, in petal pink: `ROSE` is one hue of pink in eleven steps
(named by their lightness times 1000: 983 is the blush of the letter keys, 920 the background, 833 the highlight keys, 637 the rose of the
interaction, 561 the secondary texts, 497 the lit dash, 309 the ink). Those seven are the colors that the theme always had; the other four are
what its states, tools, bubble and popup were missing, so the highlight keys keep their pink and their dark ink (no `mod_text`). Blush letter keys
with a soft pink edge under them (`lip` 1.5) on petal pink; the key under the finger is a step down, a sticky key that is on is pale with the rose
(637) as the edge that lights up under it, and locked it is one step deeper (561). The tint of the tools is the rose and lands on steps of the scale at
the opacities of `alpha_*`: tabs that are off = 880, buttons = 833 (the face of the highlight keys), selected row = 790, a button under the
finger = 745. The field and the cards are blush, as the keys; Cancel is a blush button with an outline, Send and the + button are 561 with blush
ink; the preview bubble and the popup of variants are blush with a pink edge, the chosen variant 790. The small letters of the highlight keys are
497 (`accent_hint`), because 561 does not read on their face. The dash is the one of the rule when off (a tone of the face), the lit one is fixed at
497 and the locked one is a deeper red than the rule's, so that it reads on the face of a locked key (3.0 of contrast, 1.7 with the rule's red).

**A light theme of chosen colors on a cold background (Snow).** Same method as Aqua, in slate: `SNOW` is one hue of cold slate in fourteen steps
(named by their lightness times 1000: 936 is the background, 1000 the white of the letter keys, 855 the highlight keys, 551 the tint
of the tools, 482 the secondary texts, 255 the ink), plus 707, the lit dash of Midnight Steel, and two steps of blue (620, 520) for what is lit.
White letter keys with a soft slate edge under them (`lip` 1.5), slate highlight keys; the key under the finger is a step down,
a sticky key that is on is pale with the blue as the edge that lights up under it, and locked it is one step deeper. The tint (551) lands
on steps of the scale at the opacities of `alpha_*`: tabs that are off = 895, buttons = 855 (the face of the highlight keys), selected
row = 815, a button under the finger = 770. The field and the cards are white, as the keys; Cancel is a white button with an outline,
Send and the + button are the blue 520 with white ink; the preview bubble and the popup of variants are white with an edge of the
slate, the chosen variant 815.

**A theme of chosen colors on a dark background (Midnight Steel).** Same method, on the other side of the scale: `STEEL` is one hue of blue
steel in fourteen steps (named by their lightness times 1000: 232 is the background, 306 the letter keys, 385 the highlight keys, 707
the interaction blue, 946 the text), plus the three of the red of a locked key. The keys have their edge under them (`lip` 1.5) in a darker
step of the steel, the key under the finger is a bluer step and a sticky key that is on shows the blue (707 or 610) as the edge that
lights up under it. The tint of the tools is the interaction blue (`tool_tint`, role of `OWN_ROLES`: on a dark theme the code would
otherwise derive it from the face of the highlight keys) and the opacities of `alpha_*` make it land on the steps: tabs that are off =
285, buttons = 345, selected row = 430, a button under the finger = 480. The field is a well (190) with an outline of the highlight keys;
the cards are keys (306); Cancel is a key with an outline and Send and the + button are the blue, with the deepest step as their ink. The
preview bubble and the popup of variants are one step above the letter keys (345), so that they float over them; the chosen variant is 480.

**A dark theme on a see-through background (Denim).** Same method as Midnight Steel, in cobalt blue: `DENIM` is one hue of cobalt in fourteen steps (named by
lightness times 1000, the hue 256 to 258 degrees). 411 is the middle of the popup of variants of Cobalt Glass (its two ends are 455 and 370): the background
of the keyboard is that color with the opacity of that popup, 92%, with and without blur (`clear=(.92, .92)`), so the app only shows through a little. The
letter keys (320) sink into it as navy keycaps with a darker edge under them (`lip` 1.5, step 260), the highlight keys are a lighter blue (500, edge 370), and the
light blue 735 is what is touched: a key under the finger is a step up (500 / 600), a sticky key that is on shows 735 as the edge that lights up under it, and locked it is a
dark red with a light red edge. The tint of the tools is 660 and lands near steps of the scale at the opacities of `alpha_*`: tabs that are off = 455, buttons = 500, selected
row = 545, a button under the finger = 600. The field is a well (260) with an outline of the highlight keys; the cards and Cancel are keys (320); Send and the + button are 735 with
the deepest step as their ink. The preview bubble and the popup of variants are 455 with a 545 edge, so they float over the keys; the chosen variant is 545. The small letters
of the letter keys are 800, the ones of the highlight keys 870 (which is also the lit dash, 4.1 of contrast on their face). Labels read at 10.9 on the letter keys
and 5.1 on the highlight keys.

**What else is derived.** The dash of Ctrl, Alt, Shift and ❖ comes from `dash_colors()` (below), against the face of the highlight keys.
The panel roles of item 9 (`panel_*`, `sel_*`, `attach_fab*`, `alpha_flat`) come from `bg`, `mod`,
`text` and `accent`, which is what makes the light themes of the table work without anything by hand. Flags: `FLAT_BAR`,
`ACCENT_KEYS`, `ACCENT_WIDE` and, without `mod_text`, `PLAIN_ACCENT_TEXT`.

**Tests.** `docs/tools/light_test/LightTest.java` (run by `docs/tools/run_java_tests.sh`): which text colors make a theme
light, the outline that dark labels do not get and the color of the system buttons under the keyboard (`MrLight`).

### Gloss

A gloss theme is keys with a sheen: polished metal (Chrome). The face of a key is a gradient
of three colors, with a light edge above it and a dark one below, as if lit from above. Like the solid themes it is all
drawables and colors, with two tones of keys and one color for what is being touched; unlike them, the colors of a face
are not derived from one: metal is its gradient, so the table gives it. The other fields:

| Field | What it is |
| --- | --- |
| `bg` | keyboard background (also the bar and the panels) |
| `key`, `mod` | face of the letter keys and of the highlight keys: (top, middle, bottom) |
| `rim`, `mod_rim` | edges of those keys: (the light one above, the dark one below) |
| `text`, `mod_text` | labels and icons of the letter keys and of the highlight keys (`mod_text` only when it is another color). A dark `text` makes it a light theme (item 8); it is also the ink of the bar, so it has to read on `bg`, unless the table gives `ink` |
| `ink` | color of the text and icons of what sits on the background (bar, panels, suggestions, system buttons): the role `tool_ink`, with `tool_hint` derived from it. For light keys on a dark background, where `text` would not read on `bg` (Chrome); `None` = `text` |
| `hint` | color of the small letters on the keys. `None` = derived from `tint` or `accent` for a light theme |
| `ctrl` | which part of the face of the highlight keys the bar takes as that face (`ctrl_bg`): `'top'`, `'mid'` (default) or `'bottom'`. A face as dark as the background (Chrome) gives pressed tool buttons that do not show in the middle, so it uses the lit bottom |
| `accent`, `mod_accent` | color a letter key, and a highlight key, leans to under the finger. `accent` is also the edge of the preview bubble and the chosen variant; `mod_accent` also the lit dash of Ctrl, Alt and Shift, which has to show on the face of those keys |
| `middle` | where the middle color of the faces sits, 0 (top) to 1 (bottom) |
| `coat` | the clear coat: white mixed into the top and the middle color of every face: (share at the top, share at the middle) |
| `lip` | height in dp of the shadow under each key |
| `roles` | as in a solid theme (table of the Solid section; the roles that only have a default are the ones in `OWN_ROLES`), for a theme whose tools are chosen instead of derived (Chrome: every color of the bar, the panels, the bubble and the small letters is a step of the scale `CHROME` of the script, the tint of the tools over the background at the opacities of the roles `alpha_*`). The faces of the states of the keys stay derived: the face with the accent mixed in (`GLOSS_STATES`) |
| `clear` | for a see-through background: (opacity without blur behind the keyboard, opacity with it). The theme then carries `TRANSLUCENT` and declares `kbd_bg_blur` besides `kbd_bg` |

**How a gloss key is drawn:**

| Layers | Insets top / bottom (dp) | Colors `mr_<tema>_key_<estado>_...` |
| --- | --- | --- |
| 1 shape, the shadow | `lip` + 1 / 0 | `mr_<tema>_key_lip` (one for every state): the background with 45% of black |
| 1 shape, the dark edge | 2 / `lip` | `rim_bottom` |
| 1 shape, the light edge | 0 / `lip` + 2 | `rim_top` |
| 1 gradient, the face | 1 / `lip` + 1 | `top`, `mid`, `bottom` |

The three shapes under the face are its own outline moved up or down by 1 dp, with the same side insets: `KeyStyle`
gives all of them the key radius, so they fit a square key and a round one alike. They are plain colors and the clear
coat is mixed into the colors of the face instead of being a layer, because a gradient costs several times more to draw
than a plain shape and the keyboard is drawn without the graphics chip: one gradient per key keeps a gloss theme about
as fast as a neon one. The states are the ones of the solid themes; each leans to the accent by the share in
`GLOSS_STATES` and `GLOSS_ACCENT_STATES`. The preview bubble and the popup of variants take the top and the middle
color of the letter keys.

**See-through background** (`clear`, in a gloss or a solid theme; Denim uses it, and Cobalt Glass is the see-through one written by hand). Only the background is
see-through; the keys of a generated theme stay solid, so the labels always read. The background is one sheet under the bar, the panels
and the keys: `MrTools.applyTranslucentBlur` paints it on the root of the tools (`kbd_bg_blur` where the window blurs what is behind
it, `kbd_bg` where it does not) and leaves the keyboard view clear, so the two opacities of `clear` are the ones seen everywhere. A
pale see-through background turns grey over a dark app (it did in Aqua, when it was a see-through gloss theme). Keep the ink (`text`)
dark enough, or light enough, to read on the background over a white screen and over a black one.

### Cobalt Glass (written by hand)

The one see-through theme, and the only one whose keys are see-through too. Its files are not generated: the colors are in
`res/values/mr_colors.xml` (the block "Cobalt Glass": the sheet, the labels, the dash, the tools, the bubble and the popup) and
`res/values/mr_key_colors.xml` (the keys), and the drawables are `key_glass_*`, `popup_glass_bg`, `preview_glass_*` and
`key_popup_glass_pressed`.

- **One sheet.** The app shows through one sheet of very dark cobalt (`kbd_bg_blur`, 9%, over the blur of Android 12 and up;
  `kbd_bg`, 50%, where there is no blur and what is behind stays sharp). It is almost clear on purpose: the blur is what makes it
  read as glass. Bar, panels and keys sit on the same sheet (see above).
- **Panes.** Everything that is a surface is a pane of glass: ONE flat see-through color (a step of the cobalt with its opacity,
  no gradient) and a hairline rim (1 dp) of the same cobalt, 700 at 16%. The rim is the same hue as the fill on purpose: a rim of
  ice (near white) over a dark blue turns grey and is the lightest thing on the key, so the keys read as outlines; a rim of the
  cobalt reads as the edge of the glass, and the keys are told apart by their color. The keys are one shape each (`fill`,
  `stroke`), so `KeyStyle` gives them the key radius. Letter keys: 455 at 32%; highlight keys are bluer (540 at 44%); `hl` is
  drawn as `acc_normal`.
- **States are light, not color.** Under the finger the fill gets bluer and the rim lights up (700 at 46%, rim 775 at 60%); a
  sticky key that is on is lit cobalt (565) with the lit rim; locked, the rim is red (1.5 dp). The dash of Ctrl, Alt and Shift
  follows: off is a line of ice (the faces are see-through, so there is no opaque tone of the face to derive one from), on is the
  light, locked is the red.
- **One scale.** Every color is a step of one scale of cobalt (OKLCH, hue 254 to 259, named by lightness times 1000; the table is
  in the comment of the block) with an opacity; the only color from outside is the red of what is locked.
- **Tools.** The buttons, the tabs, the selected row and the cards are panes like the keys: the tint is the cobalt of the highlight
  keys (`tool_tint`, 540) at the opacities of `alpha_*`, and every pane gets the rim (`pane_rim`, the same 700). The field is a
  well, a darker hollow with a rim; Cancel is a pane, Send and the + button are lit cobalt.
- **Bubble and popup.** Slabs of the same glass (455 to 370, at 90 to 94%) with the rim; the preview bubble has the lit rim of a key
  under the finger and the chosen variant is a lit pane. They are windows of their own, with no blur and no sheet behind them, so
  they are denser than the keys (at 80% the keys behind showed through the letters). They keep a slight vertical gradient.
- **Reading.** Light labels on see-through panes depend on what is behind. Over a dark or mid-grey screen the theme reads well
  (4.6 of contrast for the labels of the letter keys over mid grey with the blur on, 14 over black); over a very light screen
  with the blur on it does not (1.7 over white): the sheet is almost clear and the keys are subtle. The shade around the labels
  is the deepest cobalt (`label_shadow`) instead of black. If light apps matter, raise the opacity of the keys (`mr_key_colors.xml`)
  or of `kbd_bg_blur`, with both a light and a dark screen in sight.

### The dash of Ctrl, Alt, Shift and ❖

These keys wear the highlight face and a small dash tells their state, so its colors are made against that face (the
`mod` of a solid theme, the middle of the lower part of a gloss one, the hue of a neon one at the height of the dash).
The same three rules serve every generated theme (`dash_colors()` in the script, constants `DASH_OFF`, `DASH_ON`,
`DASH_LOCK`, `LOCK_RED`, `LOCK_LEAN`, `LOCK_TURN`):

| State | Color | Contrast with the face |
| --- | --- | --- |
| off | a subdued tone of the face: the face a little darker | 1.3 |
| on | the interaction color (`accent`, or `mod_accent` in a gloss theme; the hue with 50% of white in a neon one), moved towards white, or towards black on a bright face, as little as it takes | at least 3.8 |
| lock (Shift) | red, turned up to 12 degrees towards the hue of the highlight keys (less the greyer that hue is), moved as above | at least 3 |

A solid theme can name its lit dash (`dash_on` in its table, Snow and Midnight Steel do) when its accent, moved
to the contrast above, does not look right; the rule does not move it. On a spectrum theme (Aurora) the dash takes the hue of its key, except the
locked one of Shift, which keeps its red.

## Naming convention

- What applies to all themes, or is decided by a `MrTheme` flag, gets a generic name: `isAccentKey`,
  `drawAccentFill`, `getAccentContentColor`, `applyTranslucentBlur`, `MrTranslucentBlur`, `flatBar()`, `translucent()`.
- What exists for only one theme gets its name (`midnight`, `glass`, and the tags of the generated themes: `snow`, `rose`, `aqua`;
  `chrome`; `cyan`, `purple`, `pink`, `synthwave`, `aurora`), as in the resources
  `mr_<tema>_*`, `key_<tema>_*` and `input_popup_<tema>`.
- A theme name does not go into a method, field or class that serves more than one theme. The neon look is the flags
  `GLOW` and `SPECTRUM` and the class `MrGlow`; a light theme is one with a dark text color (`MrLight`): no theme tag is
  named in the code.

