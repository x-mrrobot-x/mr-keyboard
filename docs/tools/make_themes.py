#!/usr/bin/env python3
"""Writes the generated themes of the keyboard from three tables, one per family: SOLID, GLOSS and NEON (all below).

A family is a look: the solid themes have plain keys in two tones and nothing that shines; the gloss themes have keys
with a sheen, polished metal or wet glass; the neon themes have a thin bright tube around each key, light that fades
into the key and out of it and labels that shine. Inside a family a theme is a handful of colors, and everything else
(16 to 19 files and from 60 to 140 colors per theme) is derived from them. So they are generated. To change one of
these themes or add one, edit its table and run, at the project root:

    python3 docs/tools/make_themes.py            # writes the files
    python3 docs/tools/make_themes.py --check    # writes nothing; exits with 1 if a file is out of date

The list of the setting "Keyboard theme" is ORDER (below): Midnight Steel, the neon themes, Aqua, the light themes, Cobalt
Glass (the only one written by hand) and Denim, last. The id of a theme is the value stored in the preference pref_keyboard_layout and its position in ORDER (and in
mr_theme_layouts): change the list, run the script and the lists follow. Ids are not kept between versions.

What it writes, for each theme <t> of the tables:

  res/drawable/   btn_keyboard_key_<t>.xml, btn_keyboard_key_<t>_accent.xml, key_<t>_{normal,hl,pressed,on,lock}.xml,
                  key_<t>_acc_{normal,pressed,on,lock}.xml, btn_keyboard_key_popup_<t>.xml, key_popup_<t>_pressed.xml,
                  popup_<t>_bg.xml, preview_<t>_bg.xml, preview_<t>_more_bg.xml
  res/layout/     input_mr_<t>.xml, input_popup_<t>.xml, key_preview_<t>.xml
  res/values/mr_solid_colors.xml, res/values/mr_gloss_colors.xml, res/values/mr_neon_colors.xml
                  every color of the themes of each family (the whole files are generated: do not edit them)

and, in files that are also edited by hand, only its own lines:

  res/values/mr_themes.xml        mr_theme_layouts (position = id = value of the preference), mr_theme_tags, mr_theme_flags
  res/values/arrays.xml           keyboard_layout_modes and keyboard_layout_modes_values (names and ids, in the order of ORDER)
  res/values/strings.xml          layout_mr_<t>, the English name of the theme (the names are not translated: only this file has them)

It never removes a theme: to drop one, take it out of its table and delete its files and lines by hand
(res_check.py then lists whatever was left behind).

The dash that Ctrl, Alt, Shift and the Meta key (❖) show under their label tells their state, so its colors are chosen
against the face of those keys (the highlight keys) in every theme, by the same three rules (dash_colors()):

  off     a subdued tone of the face, 1.3 of contrast with it (the face a little darker)
  on      the theme's interaction color, moved towards white (towards black on a bright face) until it has at least
          3.8 of contrast with the face
  lock    red, turned a little towards the hue of the highlight keys so that it still belongs to the theme, with at
          least 3 of contrast with the face

Both families lean on KeyStyle.prepare, which puts the LAST layer of a key drawable at half the key spacing from the
cell edge (2 dp by default) and gives each layer the key radius plus its distance to the last one: everything below
follows the "key radius" and "key spacing" settings.

How a neon key is drawn (dp):

  3 strokes outside the tube   insets 0 / 0.67 / 1.34, each one reaching under the tube: the light around the key
  1 gradient                   inset 2, opaque: the face (the keyboard background with a little of the hue)
  6 strokes inside the tube    inset 2, widths 6.5 ... 1.5: the light that fades into the face
  1 stroke                     inset 2, 1 dp: the tube

Insets are cut to whole pixels and stroke widths are rounded, so adjoining bands would leave gaps or overlap by a
pixel on some screens. That is why every band starts at the tube and is simply longer than the next one: the light
adds up towards the tube and no rounding can break it. The opacities of the neon states are the ones seen on the
screen (cumulative); layer_alphas() turns them into the opacity of each layer.

The light of the labels and icons, and the hue per key of the spectrum themes, cannot be done by a drawable: they
are in MrGlow.java, switched on by the flags 0x80 (GLOW) and 0x100 (SPECTRUM) that this script writes.

How a solid key is drawn (dp):

  1 shape   the lip: the face color darkened, pushed down by the height of the lip (left out on a flat theme)
  1 shape   the face, in one plain color

How a gloss key is drawn (dp):

  1 shape      the shadow: the outline of the face, pushed down by the height of the lip plus 1
  1 shape      the dark edge: the same outline, 1 dp down
  1 shape      the light edge: the same outline, 1 dp up, as if lit from above
  1 gradient   the face, in three colors (top, middle, bottom), with the white of the clear coat mixed into the
               upper two

The three shapes under the face are plain colors on purpose: a gradient costs several times more to draw than a
plain shape, and the keyboard is drawn without the graphics chip. They are copies of the face moved up or down, not
a ring around it, so they fit any key radius.

A solid or gloss theme can have a see-through background (its color carries an opacity, the field `clear`): the theme then gets
the flag 0x10 (TRANSLUCENT), which blurs what is behind the keyboard where the phone can (MrTranslucentBlur). The keys stay solid.

A solid or gloss theme with a dark text is a light theme: the code finds that out from the text color alone
(MrLight.java). One with a light text is a dark theme, and its tools take the tint from the face of the highlight keys unless
the table gives it (the role tool_tint).
"""
import collections
import colorsys
import os
import re
import sys

WHITE = '#ffffff'
BLACK = '#000000'


# Flags of mr_theme_flags (the bits are described at the top of MrTheme.smali)
FLAT_BAR, ACCENT_KEYS, ACCENT_WIDE, TRANSLUCENT, TECH_PALETTE, PLAIN_ACCENT_TEXT, GLOW, SPECTRUM = 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x100


# ---------------------------------------------------------------------------------------------------------------
# Colors and XML, for both families
# ---------------------------------------------------------------------------------------------------------------
def rgb(c):
    c = c.lstrip('#')
    assert len(c) == 6, c
    return tuple(int(c[i:i + 2], 16) for i in (0, 2, 4))


def mix(a, b, t):
    """Opaque mix of two '#rrggbb' colors: t = 0 gives a, t = 1 gives b."""
    A, B = rgb(a), rgb(b)
    return '#ff%02x%02x%02x' % tuple(int(A[i] + (B[i] - A[i]) * t + 0.5) for i in range(3))


def alpha(c, a):
    """The color '#rrggbb' or '#ffrrggbb' at opacity a (0..1)."""
    return '#%02x%s' % (int(a * 255 + 0.5), c.lstrip('#')[-6:])


def opaque(c):
    return '#ff' + c.lstrip('#')[-6:]


def hex6(c):
    """'#rrggbb' of a color written with or without its opacity (what mix() takes)."""
    return '#' + c.lstrip('#')[-6:]


def luminance(c):
    """Relative luminance of a color, 0 (black) to 1 (white)."""
    def linear(v):
        v /= 255.0
        return v / 12.92 if v <= 0.03928 else ((v + 0.055) / 1.055) ** 2.4
    r, g, b = rgb(hex6(c))
    return 0.2126 * linear(r) + 0.7152 * linear(g) + 0.0722 * linear(b)


def contrast(a, b):
    """Contrast ratio of two colors, 1 (the same) to 21 (black on white)."""
    la, lb = luminance(a), luminance(b)
    return (max(la, lb) + 0.05) / (min(la, lb) + 0.05)


def dark_ink(c):
    """True for a dark text color. The same rule as MrLight.is and MrTools.deriveColors: brightness of at most 0.5."""
    return max(rgb(hex6(c))) * 2 <= 255


# ---------------------------------------------------------------------------------------------------------------
# The dash of Ctrl, Alt, Shift and the Meta key: its three colors, for the face it sits on (the highlight keys)
# ---------------------------------------------------------------------------------------------------------------
DASH_OFF, DASH_ON, DASH_LOCK = 1.3, 3.8, 3.0   # contrast with the face: unlit (subdued), lit, locked
LIGHT_ALPHA = {'btn': .22, 'tab_off': .12, 'sel': .30, 'card': .16}   # opacity of the tint of a light theme (tool_tint): buttons, tabs that are off, selection, cards
DARK_ALPHA = {'btn': .26, 'tab_off': .15, 'sel': .38, 'card': .20}   # the same on a dark theme (a little above the defaults, made for Midnight Steel, so that the buttons are not dull on a navy background)
LOCK_RED = '#ff5252'                           # the red of the locked dash, before it leans to the theme's hue
LOCK_LEAN, LOCK_TURN = .12, 12                 # share of the way to the hue of the keys, at most this many degrees


def hsv(c):
    return colorsys.rgb_to_hsv(*(v / 255.0 for v in rgb(hex6(c))))


def from_hsv(h, s, v):
    return '#%02x%02x%02x' % tuple(int(x * 255 + 0.5) for x in colorsys.hsv_to_rgb(h % 1.0, s, v))


def subdued(face, ratio=DASH_OFF):
    """A tone of `face` with `ratio` of contrast with it: the face a little darker, or a little lighter where it is
    already too dark to go darker."""
    for toward in (BLACK, WHITE):
        for step in range(1, 101):
            c = mix(face, toward, step / 100.0)
            if contrast(c, face) >= ratio:
                return c
    raise ValueError('no tone of %s has %s of contrast with it' % (face, ratio))


def reach(color, face, ratio, toward):
    """`color` itself when it has `ratio` of contrast with `face`; else mixed with `toward` as little as it takes
    (1% steps), `toward` itself when even that is not enough."""
    for step in range(101):
        c = opaque(color) if step == 0 else mix(color, toward, step / 100.0)
        if contrast(c, face) >= ratio:
            return c
    return opaque(toward)


def lock_red(hue):
    """The red of the locked dash, turned a little towards `hue` (the hue of the highlight keys), the less the greyer
    that hue is: it stays red, but belongs to the theme."""
    h, s, v = hsv(hue)
    rh, rs, rv = hsv(LOCK_RED)
    diff = (h - rh + .5) % 1.0 - .5
    turn = max(-LOCK_TURN / 360.0, min(LOCK_TURN / 360.0, diff * LOCK_LEAN)) * min(1.0, s / .4)
    return from_hsv(rh + turn, rs, rv)


def lively(accent, text, faces, ratio=3.4, lean=.25):
    """The color of the secondary texts of a light theme (the small letters on the keys, the placeholder of the field, the
    hints and the empty states of the tools): the vivid color of the theme leaning a little to the ink, moved towards the ink
    only as far as it takes to have `ratio` of contrast with every face it can sit on. A mix of the ink with a pale face
    gave a flat grey in the light themes."""
    start = hex6(mix(accent, text, lean))
    for step in range(101):
        c = opaque(start) if step == 0 else mix(start, text, step / 100.0)
        if all(contrast(c, f) >= ratio for f in faces):
            return c
    return opaque(text)


def dash_colors(face, lit, hue):
    """(off, on, lock) of the dash on the face `face` of the highlight keys. lit: where the lit dash starts (the
    interaction color of the theme); hue: the hue of the highlight keys, which the red of the lock leans to."""
    face, lit, hue = hex6(face), hex6(lit), hex6(hue)
    toward = BLACK if contrast(face, BLACK) > contrast(face, WHITE) else WHITE
    return (opaque(subdued(face)),
            opaque(reach(lit, face, DASH_ON, toward)),
            opaque(reach(lock_red(hue), face, DASH_LOCK, toward)))


XML = '<?xml version="1.0" encoding="utf-8"?>\n'
NS = 'xmlns:android="http://schemas.android.com/apk/res/android"'
HEAD = XML + '<!-- Generated by docs/tools/make_themes.py: do not edit. -->\n'


def num(v):
    """dp value without a useless '.0' (2.0 -> '2', 9.33 -> '9.33')."""
    return ('%.2f' % float(v)).rstrip('0').rstrip('.')


def item(inset, shape_body):
    i = num(inset) + 'dp'
    return ('    <item android:left="%s" android:top="%s" android:right="%s" android:bottom="%s">\n'
            '        <shape android:shape="rectangle">\n%s        </shape>\n    </item>\n' % (i, i, i, i, shape_body))


def layer(body, left=0, top=0, right=0, bottom=0):
    """One layer of a layer-list, with its insets in dp."""
    return ('    <item android:left="%sdp" android:top="%sdp" android:right="%sdp" android:bottom="%sdp">\n'
            '        <shape android:shape="rectangle">\n%s        </shape>\n    </item>\n'
            % (num(left), num(top), num(right), num(bottom), body))


def selector(rows):
    out = HEAD + '<selector %s>\n' % NS
    for states, drawable in rows:
        attrs = ''.join('android:state_%s="true" ' % s for s in states)
        out += '    <item %sandroid:drawable="@drawable/%s" />\n' % (attrs, drawable)
    return out + '</selector>\n'


def key_selector(t, accent):
    """The two selectors of a theme, for both families. Same states as every theme of the keyboard
    (LatinKeyboard$LatinKey and Keyboard$Key give them to the key):
    single = function key (123, Tab, F5...), single + selected = function key that the theme highlights;
    checkable = sticky key (Fn...), + checked = on, + checked + active = locked.
    The highlight keys of these themes use the accent selector; Ctrl, Alt and Shift, which are among them, only
    ever ask for rest and pressed (their dash tells the state). `hl` is what is left on the normal selector: a
    sticky key at rest, or a function key that only LatinKey.isHl highlights."""
    k = lambda s: 'key_%s_%s%s' % (t, 'acc_' if accent else '', s)
    idle = k('normal') if accent else 'key_%s_hl' % t
    rows = [(('single', 'pressed'), k('pressed'))]
    if not accent:
        rows.append((('single', 'selected'), 'key_%s_hl' % t))
    rows += [
        (('single',), k('normal')),
        (('checkable', 'checked', 'pressed'), k('pressed')),
        (('checkable', 'pressed'), k('pressed')),
        (('checkable', 'checked', 'active'), k('lock')),
        (('checkable', 'checked'), k('on')),
        (('checkable',), idle),
        (('pressed',), k('pressed')),
        ((), k('normal')),
    ]
    return selector(rows)


# ===============================================================================================================
# NEON family (the order of the list of the setting is ORDER, below).
#   tag       name used in files and colors (mr_<tag>_...): lower-case letters only, and not a piece of another
#             word of the layouts (res_check.py compares the layouts of all themes with the tag blanked out)
#   name      the name in the list of the setting, in English in every language
#   bg        keyboard background
#   key       hue of the tubes and of the light of the normal keys
#   accent    hue of the highlight keys (arrows, Tab, Enter, Space, 123...); None = the same as key
#   core      color of the tube itself; None = the hue with 28% of white
#   text      color of the labels and icons; None = the hue with 72% of white
#   spectrum  (start, mid, end): each key of the main keyboard takes its hue from its position, turning from one
#             color to the next by the short way round the color wheel (MrGlow.java redraws the drawables, which
#             are written in the hue `key`, through a color filter). `key` is then the hue of what is not a key:
#             preview bubble, popup of variants, toolbar and panels. accent must be None
#   glow      strength of the light of the labels and icons, 0..1 (hues that the eye sees darker need more)
#   lite      a lighter key: two bands of halo and three of light inside the tube instead of three and six (7 layers instead
#             of 11, the same for the preview bubble and the popup of variants). Less to draw, and less glare around the tube
#   flat      the tools take the roles of the flat themes (flag FLAT_BAR): tabs, cards and icons painted from the alpha_* and panel_*
#             roles, as in Midnight Steel and the light themes, instead of the older look (half opacity for what is off)
#   roles     None, or {role: color} for a theme whose tools are chosen, not derived (Aurora: every color of the bar and the
#             panels is a step of one scale of indigo): each entry replaces the derived color of that role or declares one that
#             only has a default (NEON_OWN_ROLES). A color is '#rrggbb', or '#aarrggbb' where the opacity matters
# ---------------------------------------------------------------------------------------------------------------
Neon = collections.namedtuple('Neon', 'tag name bg key accent core text spectrum glow lite flat roles')


def neon(tag, name, bg, key, accent=None, core=None, text=None, spectrum=None, glow=1.0, lite=False, flat=False, roles=None):
    return Neon(tag, name, bg, key, accent, core, text, spectrum, glow, lite, flat, roles or {})


# The tools of a neon theme that chooses them (the field `roles`) are steps of ONE scale: the hue of what is not a key, from the
# keyboard background to the ice of the text, named by lightness (OKLCH times 1000). Its faces are the ones the keys already have at
# rest (the letter keys and the highlight keys), so that every color of the bar and the panels belongs to the keyboard.
#
# The scale of Aurora: the hue of what is not a key (the middle of its spectrum, 276 degrees). 142, 176, 209 and 292 are the background
# and the faces that the keys already had at rest (the letter keys and the highlight keys), 390 the tube of the Cancel button, 641 the
# hue of the keys, 738 the tube of a lit key, 817 the lit dash and 898 the text; the other steps lie between them. The spectrum itself
# (teal to pink) is the roles spectrum_* and is not on it.
INDIGO = collections.OrderedDict([
    ('142', '#070912'),   # the keyboard background, the ink on the indigo
    ('176', '#0d0f1f'),   # tabs that are off, the field of the tools
    ('209', '#12162c'),   # the face of the letter keys, the buttons of the tools, the cards, Cancel
    ('250', '#1a1e3d'),   # the divider, a tool of the bar under the finger
    ('292', '#222750'),   # the face of the highlight keys, the selected row, a marked file
    ('340', '#2c3167'),   # a button under the finger
    ('390', '#363c7d'),   # the unlit dash, outlines
    ('440', '#404894'),
    ('641', '#6f7bff'),   # the hue of the keys: the tint of the tools, Send, the + button
    ('660', '#878ec0'),   # secondary texts
    ('738', '#97a0ff'),   # the tube of a lit key
    ('817', '#b7bdff'),   # the lit dash
    ('898', '#d7daff'),   # the text
])

# The scale of Neon Cyan, the same idea in the hue of its keys (209 degrees): the keyboard background with the tint of the keys (844)
# over it at the opacities the faces of the keys already have, named by lightness. 207 is the face of a letter key at rest (8% of the
# tint), 314 the face of a highlight key (21%); 379 and 410 are 30% and 34%, a button under the finger and an unlit tube; 720 is what a
# large surface in the hue of the keys is (Send: the key hue itself, 844, glares on a button that wide), 899 the tube of a lit key and
# the lit dash, 939 the text.
CYAN = collections.OrderedDict([
    ('135', '#04090d'),   # the keyboard background, the ink on the cyan
    ('171', '#041217'),   # tabs that are off, the field of the tools
    ('207', '#041b21'),   # the face of the letter keys, the buttons of the tools, the cards, Cancel
    ('263', '#032a31'),   # the divider
    ('314', '#033841'),   # the face of the highlight keys, the selected row, a marked file
    ('379', '#034b56'),   # a button under the finger
    ('410', '#03545f'),   # the unlit dash, outlines
    ('668', '#749da3'),   # secondary texts
    ('720', '#01b9cf'),   # the hue of the keys at the lightness of a large surface: Send, the + button
    ('844', '#00e5ff'),   # the hue of the keys: the tint of the tools
    ('899', '#80f2ff'),   # the tube of a lit key, the lit dash, the ring of Send
    ('939', '#b8f8ff'),   # the text
])

# Neon Purple and Neon Pink: the recipe of Aurora in their hue (the key over the background at 5.5%, 11%, 18%, 26%, 36% and 45%). The
# faces 172/205/290 (Purple) and 175/209/300 (Pink) are exactly the ones their keys have at rest.
PURPLE = collections.OrderedDict([
    ('136', '#0a0612'),   # the keyboard background, the ink on the purple
    ('172', '#130b1f'),   # tabs that are off, the field of the tools
    ('205', '#1d0f2c'),   # the face of the letter keys, the buttons of the tools, the cards, Cancel
    ('246', '#29153d'),   # the divider, a tool of the bar under the finger
    ('290', '#361c50'),   # the face of the highlight keys, the selected row, a marked file
    ('344', '#472567'),   # a button under the finger
    ('392', '#562d7d'),   # the unlit dash, outlines
    ('640', '#9584a5'),   # secondary texts
    ('654', '#b45cff'),   # the hue of the keys: the tint of the tools, Send, the + button
    ('818', '#daaeff'),   # the tube of a lit key, the lit dash, the ring of Send
    ('896', '#ead1ff'),   # the text
])
PINK = collections.OrderedDict([
    ('138', '#10050b'),   # the keyboard background, the ink on the pink
    ('175', '#1d0814'),   # tabs that are off, the field of the tools
    ('209', '#2a0b1c'),   # the face of the letter keys, the buttons of the tools, the cards, Cancel
    ('252', '#3b0f28'),   # the divider, a tool of the bar under the finger
    ('300', '#4e1434'),   # the face of the highlight keys, the selected row, a marked file
    ('354', '#651944'),   # a button under the finger
    ('406', '#7c1e53'),   # the unlit dash, outlines
    ('638', '#a47f93'),   # secondary texts
    ('683', '#ff3daa'),   # the hue of the keys: the tint of the tools, Send, the + button
    ('814', '#ff9ed5'),   # the tube of a lit key, the lit dash, the ring of Send
    ('892', '#ffc9e7'),   # the text
])

# The opacities of the tint of the tools (the hue of the keys, role tool_tint) over the background, which land on steps of the
# scales: tabs that are off, buttons and cards (the face of a letter key), selected row (the face of a highlight key) and a button
# under the finger; a tool of the bar under the finger is the highlight face (ctrl_bg) at the `flat` opacity. The darker the hue of
# the keys (Aurora, Purple, Pink), the more of it a face takes (TOP: the top of the face of a key); the brighter (Cyan), the less
# (MID: the middle of the face).
TOOL_ALPHAS_TOP = dict(flat='#b1000000', btn='#1c000000', press='#5b000000', tab_off='#0e000000', sel='#43000000', card='#1c000000')
TOOL_ALPHAS_MID = dict(flat='#99000000', btn='#15000000', press='#4b000000', tab_off='#0a000000', sel='#36000000', card='#15000000')


def tool_roles(scale, alphas, ink, tint, send, ring, field, btn, divider, sel, dim, text2):
    """The roles of the bar and the panels of a theme whose tools are chosen. `scale` is one of the scales above and `alphas` one of
    TOOL_ALPHAS_*; the rest are names of steps of the scale: the ink on a lit surface (the background), the tint of the tools, Send and
    the + button, the ring of both (a lit tube), the field and tabs that are off, buttons and cards, the divider, a selected row, the
    unlit tube (outlines and the dash of Ctrl, Alt and Shift: a dim tone instead of the black that the rule gives on a dark face) and
    the secondary texts."""
    c = scale.__getitem__
    return collections.OrderedDict([
        ('modifier_indicator_off', c(dim)),
        ('tool_tint', c(tint)),
        ('alpha_flat', alphas['flat']),
        ('alpha_btn', alphas['btn']),
        ('alpha_press', alphas['press']),
        ('alpha_tab_off', alphas['tab_off']),
        ('alpha_sel', alphas['sel']),
        ('alpha_card', alphas['card']),
        ('panel_field', c(field)),             # a well a step above the background, with the outline of a dim tube
        ('panel_field_stroke', c(dim)),
        ('panel_divider', c(divider)),
        ('panel_btn', c(btn)),                 # card of a file: the face of a letter key
        ('panel_tab_off_text', c(text2)),
        ('sel_card', c(sel)),                  # a marked file
        ('sel_cancel', c(btn)),                # Cancel: a key with a dim tube, Send: the hue of the keys, as a lit tube
        ('sel_cancel_stroke', c(dim)),
        ('sel_send', c(send)),
        ('sel_send_stroke', c(ring)),          # also the ring of the check on a marked picture: light, to show on a photo
        ('sel_send_text', c(ink)),
        ('attach_fab', c(send)),
        ('attach_fab_stroke', c(ring)),
        ('attach_fab_icon', c(ink)),
    ])


NEON = [
    # Neon Cyan, Purple and Pink: lighter keys, flat tools, and every color of the tools a step of the scale of their hue (as Aurora)
    neon('cyan', 'Neon Cyan',
         bg='#04090d', key='#00e5ff', lite=True, flat=True,
         roles=tool_roles(CYAN, TOOL_ALPHAS_MID, ink='135', tint='844', send='720', ring='899', field='171', btn='207',
                          divider='263', sel='314', dim='410', text2='668')),
    neon('purple', 'Neon Purple',
         bg='#0a0612', key='#b45cff', lite=True, flat=True,
         roles=tool_roles(PURPLE, TOOL_ALPHAS_TOP, ink='136', tint='654', send='654', ring='818', field='172', btn='205',
                          divider='246', sel='290', dim='392', text2='640')),
    neon('pink', 'Neon Pink',
         bg='#10050b', key='#ff3daa', lite=True, flat=True,
         roles=tool_roles(PINK, TOOL_ALPHAS_TOP, ink='138', tint='683', send='683', ring='814', field='175', btn='209',
                          divider='252', sel='300', dim='406', text2='638')),
    neon('synthwave', 'Synthwave',
          bg='#0b0618', key='#9d7bff', accent='#ff4d9d'),
    # a light spectrum: the keys have a thin tube and a soft light, and the tools are chosen on one scale of indigo (the hue of
    # what is not a key), so that they belong to the keyboard instead of being the default of the other themes
    neon('aurora', 'Aurora',
         bg='#070912', key='#6f7bff', spectrum=('#00e5c8', '#6f7bff', '#ff4fc3'), lite=True, flat=True,
         roles=tool_roles(INDIGO, TOOL_ALPHAS_TOP, ink='142', tint='641', send='641', ring='738', field='176', btn='209',
                          divider='250', sel='292', dim='390', text2='660')),
]

# ---------------------------------------------------------------------------------------------------------------
# The look of a neon key in each state. Opacities are the ones seen on the screen, from the cell edge to the tube
# (halo) and from the tube into the face (inner); face = share of the hue mixed into the background, top and
# bottom; tube = share of white mixed into the tube color at rest (None = the tube at rest itself: the hue with 28% of
# white, or the `core` of the theme). A lit key is always whiter than one at rest.
# ---------------------------------------------------------------------------------------------------------------
HALO_INSETS = ('0', '0.67', '1.34')      # dp; the tube is at TUBE_INSET
TUBE_INSET = 2.0
TUBE = '1'                               # dp, width of the tube
INNER_WIDTHS = ('6.5', '5.17', '4', '3', '2.17', '1.5')   # dp, tube included: the widest (faintest) first

State = collections.namedtuple('State', 'halo face inner tube')
KEY_STATES = collections.OrderedDict([
    ('normal',  State((.06, .17, .38), (.110, .055), (.30, .21, .145, .095, .055, .025), None)),
    ('pressed', State((.12, .30, .58), (.46, .34), (.60, .46, .34, .24, .15, .07), .80)),
    ('on',      State((.08, .22, .46), (.24, .16), (.44, .32, .22, .15, .09, .04), .50)),
    ('lock',    State((.11, .28, .55), (.38, .27), (.55, .42, .30, .21, .13, .06), .85)),
])
ACCENT_STATES = collections.OrderedDict([
    ('acc_normal',  State((.07, .20, .42), (.26, .17), (.42, .31, .22, .15, .09, .04), None)),
    ('acc_pressed', State((.13, .32, .60), (.60, .46), (.62, .48, .36, .26, .16, .08), .85)),
    ('acc_on',      State((.10, .26, .50), (.44, .32), (.52, .39, .28, .19, .12, .05), .60)),
    ('acc_lock',    State((.12, .30, .58), (.54, .40), (.58, .45, .33, .23, .14, .07), .90)),
])
# The dash of Ctrl, Alt, Shift and the Meta key (dash_colors): the face of a highlight key has about this much of its hue
# at the height of the dash, and the lit dash starts from the hue with this much white, which is how a lit tube looks.
DASH_FACE, DASH_WHITE = .22, .50
# Preview bubble and popup of variants: lit like a key, a little lighter than the keyboard so that they stand out.
BUBBLE = State((.10, .26, .50), (.20, .12), (.40, .27, .17, .09), .45)
BUBBLE_INNER_WIDTHS = ('5', '3.5', '2.25', '1.5')
# A lighter key (the field `lite` of the table): of the three bands of halo, the first and a little less than the last, at the
# insets of HALO_INSETS_LITE; of the six bands of light inside the tube, every second one (the ones nearest to it, which are the
# ones that are seen, stay). 7 layers a key instead of 11.
HALO_INSETS_LITE = ('0', '1')
LITE_INNER_WIDTHS = INNER_WIDTHS[1::2]
LITE_BUBBLE_INNER_WIDTHS = BUBBLE_INNER_WIDTHS[1::2]


def lite_state(st):
    """The state of a lighter key: opacities seen, as in State; the two bands of halo and the three of inner light that are left."""
    return State((st.halo[0] + .02, st.halo[2] * .85), st.face, st.inner[::-1][1::2][::-1], st.tube)


# ---------------------------------------------------------------------------------------------------------------
# Neon: colors
# ---------------------------------------------------------------------------------------------------------------
def layer_alphas(seen):
    """Opacity of each stacked layer so that the opacities SEEN are `seen` (first layer alone, then first and
    second together...). Each layer covers the ones before it: 1 - seen[k] = product of (1 - layer[i]), i <= k."""
    out, prev = [], 0.0
    for s in seen:
        assert prev < s < 1, seen
        out.append(1 - (1 - s) / (1 - prev))
        prev = s
    return out


TUBE_REST = .28      # share of white in the tube of a key at rest


def tube_color(hue, core, white):
    """Tube of a state that asks for `white` (0..1) of white: counted from the hue, so that the states of every theme
    look alike, but never less white than the tube at rest (a theme with a `core` of its own, such as a white neon)."""
    if core:
        return mix(core, WHITE, max(0.0, (white - TUBE_REST) / (1 - TUBE_REST)))
    return mix(hue, WHITE, white)


def state_colors(prefix, st, hue, bg, core):
    """Colors of one key state, in the order they are written: name -> value. core: the theme's own tube color, or None."""
    c = collections.OrderedDict()
    for i, a in enumerate(layer_alphas(st.halo)):
        c['%s_halo%d' % (prefix, i + 1)] = alpha(hue, a)
    c[prefix + '_top'] = mix(bg, hue, st.face[0])
    c[prefix + '_bottom'] = mix(bg, hue, st.face[1])
    # inner bands: the widest is drawn first and is the faintest
    for i, a in enumerate(layer_alphas(st.inner[::-1])):
        c['%s_in%d' % (prefix, i + 1)] = alpha(hue, a)
    c[prefix + '_stroke'] = tube_color(hue, core, TUBE_REST if st.tube is None else st.tube)
    return c


# Roles of the tools that no rule derives in a neon theme: a theme declares them only through `roles`
NEON_OWN_ROLES = ('tool_tint', 'alpha_btn', 'alpha_tab_off', 'alpha_sel', 'alpha_card', 'alpha_press', 'panel_btn', 'panel_field',
                  'panel_field_stroke', 'panel_divider', 'accent_hint', 'label_shadow')


def neon_colors(th):
    """Every color of a neon theme, name -> value, in the order of the file."""
    t, bg, key = th.tag, th.bg, th.key
    acc = th.accent or key
    core = th.core                                   # None = the hue with a little white (tube_color)
    acc_core = th.core if not th.accent else None    # an accent hue of its own has a tube of its own
    text = opaque(th.text) if th.text else mix(key, WHITE, .72)
    acc_text = opaque(th.text) if (th.text and not th.accent) else mix(acc, WHITE, .82)
    n = lambda role: 'mr_%s_%s' % (t, role)
    ref = lambda role: '@color/' + n(role)
    c = collections.OrderedDict()

    # ---- what the layouts point at
    c[n('kbd_bg')] = opaque(bg)
    c[n('text')] = text
    c[n('cursor')] = ref('text')
    c[n('hint')] = alpha(mix(key, WHITE, .55), .62)
    c[n('popup_hint')] = ref('hint')

    # ---- roles read by name (MrTheme.color): keys
    c[n('accent_text')] = acc_text
    c[n('glow')] = alpha(key, th.glow)
    c[n('accent_glow')] = alpha(acc, th.glow)
    if th.spectrum:
        for role, col in zip(('spectrum_start', 'spectrum_mid', 'spectrum_end'), th.spectrum):
            c[n(role)] = opaque(col)
    # the dash of Ctrl, Alt, Shift and the Meta key, which are highlight keys: see dash_colors(). Off = a subdued tone of
    # their face; on and lock shine (MrGlow.dash)
    off, on, lock = dash_colors(mix(bg, acc, DASH_FACE), mix(acc, WHITE, DASH_WHITE), acc)
    c[n('modifier_indicator_off')] = off
    c[n('modifier_indicator_on')] = on
    c[n('modifier_indicator_lock')] = lock

    # ---- roles read by name: toolbar and panels. ctrl_bg is the face of the highlight keys, as in every theme: the
    # bar derives its colors from it (MrTools.deriveColors); alpha_flat = how much of it a pressed tool button shows
    c[n('ctrl_bg')] = ref('key_acc_normal_top')
    c[n('alpha_flat')] = '#e6000000'
    # texts and icons inside the panels: the tint of the letters instead of the neutral default of the other themes
    c[n('panel_icon')] = ref('text')
    c[n('panel_tab_on_text')] = ref('text')
    c[n('panel_tab_off_text')] = mix(bg, '#' + text[3:], .62)
    c[n('sel_cancel')] = mix(bg, key, .10)
    c[n('sel_cancel_stroke')] = mix(bg, key, .45)
    c[n('sel_cancel_text')] = ref('text')
    c[n('sel_send')] = mix(bg, acc, .80)
    c[n('sel_send_stroke')] = mix(acc, WHITE, .30)
    c[n('sel_send_text')] = mix(bg, BLACK, .15)
    c[n('attach_fab')] = alpha(mix(bg, acc, .20), .95)
    c[n('attach_fab_stroke')] = mix(bg, acc, .55)
    c[n('attach_fab_icon')] = ref('accent_text')
    c[n('sel_media')] = alpha(acc, .35)
    c[n('sel_card')] = mix(bg, acc, .30)

    # ---- preview bubble and popup of variants
    shape = lite_state if th.lite else (lambda st: st)
    c.update(state_colors(n('bubble'), shape(BUBBLE), key, bg, core))
    c[n('preview_dots')] = alpha(mix(key, WHITE, .45), .85)

    # ---- keys
    for name, st in KEY_STATES.items():
        c.update(state_colors(n('key_' + name), shape(st), key, bg, core))
    for name, st in ACCENT_STATES.items():
        c.update(state_colors(n('key_' + name), shape(st), acc, bg, acc_core))

    # ---- a theme with chosen tools: they replace the derived colors (same place in the file); the roles that only have a
    # default go after the roles read by name
    own = collections.OrderedDict()
    for role, color in th.roles.items():
        color = color if len(color.lstrip('#')) == 8 else opaque(color)
        if n(role) in c:
            c[n(role)] = color
        else:
            assert role in NEON_OWN_ROLES, 'theme %s: %s is not a role of a neon theme' % (t, role)
            own[n(role)] = color
    if own:
        out = collections.OrderedDict()
        for name, color in c.items():
            if name == n('bubble_halo1'):
                out.update(own)
            out[name] = color
        c = out
    return c


# ---------------------------------------------------------------------------------------------------------------
# Neon: drawables
# ---------------------------------------------------------------------------------------------------------------
def stroke(width, color, radius, extra=''):
    """A band of light: a stroke with nothing inside. The transparent <solid> is NOT decoration: a shape without a
    solid color is taken for a gradient by GradientDrawable, which then fills it with opaque black whenever it is
    drawn through a color filter, and the spectrum themes draw every key through one (MrGlow.drawKey). Without it
    each band would black out everything under it."""
    return ('            <solid android:color="@android:color/transparent" />\n'
            '            <stroke android:width="%sdp" android:color="@color/%s" />\n'
            '            <corners android:radius="%sdp" />\n%s' % (num(width), color, num(radius), extra))


def glow_layers(prefix, radius, inner_widths, tube_extra='', halo_insets=HALO_INSETS):
    """The layers of a lit rounded rectangle whose colors are <prefix>_{halo1..,top,bottom,in1..,stroke}. `radius`
    is the one of the tube; it is only what the drawable shows before KeyStyle sets the real one."""
    out = ''
    for k, inset in enumerate(halo_insets):
        gap = TUBE_INSET - float(inset)
        out += item(inset, stroke(gap + float(TUBE), '%s_halo%d' % (prefix, k + 1), radius + gap))
    out += item(TUBE_INSET,
                '            <gradient android:angle="270" android:startColor="@color/%s_top" '
                'android:endColor="@color/%s_bottom" />\n'
                '            <corners android:radius="%sdp" />\n' % (prefix, prefix, num(radius)))
    for k, w in enumerate(inner_widths):
        out += item(TUBE_INSET, stroke(w, '%s_in%d' % (prefix, k + 1), radius))
    out += item(TUBE_INSET, stroke(TUBE, prefix + '_stroke', radius, tube_extra))
    return out


def neon_key(th, state):
    t = th.tag
    widths, halos = (LITE_INNER_WIDTHS, HALO_INSETS_LITE) if th.lite else (INNER_WIDTHS, HALO_INSETS)
    return ('%s<layer-list %s>\n%s</layer-list>\n'
            % (HEAD, NS, glow_layers('mr_%s_key_%s' % (t, state), 8, widths, '', halos)))


PREVIEW_PADDING = ('            <padding android:left="19dp" android:top="10dp" android:right="18dp" '
                   'android:bottom="17dp" />\n')
PREVIEW_DOTS = '''    <item android:gravity="bottom|right" android:right="8dp" android:bottom="8dp">
        <vector android:width="10dp" android:height="3dp" android:viewportWidth="10" android:viewportHeight="3">
            <path android:fillColor="@color/mr_%s_preview_dots" android:pathData="M0,0.5h2v2h-2zM4,0.5h2v2h-2zM8,0.5h2v2h-2z" />
        </vector>
    </item>
'''


def neon_bubble(th, radius, padding='', tail=''):
    widths, halos = (LITE_BUBBLE_INNER_WIDTHS, HALO_INSETS_LITE) if th.lite else (BUBBLE_INNER_WIDTHS, HALO_INSETS)
    return ('%s<layer-list %s>\n%s%s</layer-list>\n'
            % (HEAD, NS, glow_layers('mr_%s_bubble' % th.tag, radius, widths, padding, halos), tail))


def neon_drawables(th):
    t = th.tag
    d = collections.OrderedDict()
    d['btn_keyboard_key_%s.xml' % t] = key_selector(t, False)
    d['btn_keyboard_key_%s_accent.xml' % t] = key_selector(t, True)
    # asked of every theme (res_check.py); here a normal key: the highlight is the accent selector
    d['key_%s_hl.xml' % t] = neon_key(th, 'normal')
    for state in list(KEY_STATES) + list(ACCENT_STATES):
        d['key_%s_%s.xml' % (t, state)] = neon_key(th, state)
    d['btn_keyboard_key_popup_%s.xml' % t] = selector([(('pressed',), 'key_popup_%s_pressed' % t)])
    d['key_popup_%s_pressed.xml' % t] = neon_key(th, 'pressed')
    # the padding of the bubble goes on its LAST shape: a layer-list shrinks every later layer by the padding
    # of the ones before it
    d['preview_%s_bg.xml' % t] = neon_bubble(th, 8, PREVIEW_PADDING)
    d['preview_%s_more_bg.xml' % t] = neon_bubble(th, 8, PREVIEW_PADDING, PREVIEW_DOTS % t)
    d['popup_%s_bg.xml' % t] = neon_bubble(th, 14)
    return d




# ===============================================================================================================
# SOLID family: plain keys in two tones (letters, highlight keys) and one vivid color for what is being touched.
#   tag, name   as in the neon table
#   bg        keyboard background (also the bar and the panels)
#   key       face of the letter keys
#   mod       face of the highlight keys (Ctrl, Alt, Shift, Tab, arrows, Space, Enter...): the second tone
#   text      labels and icons of the letter keys. A dark text makes it a light theme: the code sees it by itself
#             (MrLight.java: no dark outline under the labels, dark system buttons under the keyboard); a light one makes
#             it a dark theme, which also carries the flag TECH_PALETTE
#   accent    the one vivid color: the key under the finger, the lit dash of Ctrl, Alt and Shift, the chosen
#             variant of the popup, the edge of the preview bubble, the Send button of the attachments
#   mod_text  labels and icons of the highlight keys, when their face asks for another color than `text` (white
#             keys on a black keyboard, green keys on a cream one); None = the same as text
#   lip       height in dp of the darker edge under each key, which makes it a keycap; 0 = flat
#   dash_on   the lit dash of Ctrl, Alt and Shift, exactly (the contrast rule below does not move it), when the accent
#             moved to that contrast does not look right; None = derived from the accent
#   tint      the color of the buttons, tabs and field border of the tools, and of the secondary texts (placeholder, hints), when
#             the accent is a foreign color in the palette of the theme (a neutral theme with a bright blue accent); None = the accent
#   roles     None, or {role: color} for a theme whose colors are all chosen, not derived (Midnight Steel and Aqua: every
#             color is a step of one scale): each entry replaces the derived color of that role (mr_<tema>_<role>: hint, key_pressed_fill,
#             alpha_btn, sel_send...) or declares a role that only has a default (the ones in OWN_ROLES). A color is
#             '#rrggbb', or '#aarrggbb' where the opacity matters
# ---------------------------------------------------------------------------------------------------------------
Solid = collections.namedtuple('Solid', 'tag name bg key mod text accent mod_text lip dash_on tint roles clear')
# Roles that no rule derives: a theme declares them only through `roles` (their defaults are in mr_colors.xml)
OWN_ROLES = ('alpha_press', 'panel_field', 'panel_field_stroke', 'panel_divider', 'accent_hint', 'label_shadow', 'tool_tint')


def solid(tag, name, bg, key, mod, text, accent, mod_text=None, lip=1, dash_on=None, tint=None, roles=None, clear=None):
    return Solid(tag, name, bg, key, mod, text, accent, mod_text, lip, dash_on, tint, roles or {}, clear)


# The scale of Aqua: one hue of water from foam to deep sea, in even steps of lightness (OKLCH: lightness .99 to .31, the
# hue turning from 198 to 242 degrees as it gets darker, the chroma highest in the middle). Every color of the theme is one
# of these steps (or the sea blue a little darker: the unlit dash, by the rule of every theme), so that any two of them belong
# together; the only one from outside is the coral of the locked dash.
AQUA = collections.OrderedDict([
    ('25', '#f6fefe'),    # foam: the letter keys, the cards, the field, the text on the sea blue
    ('50', '#e2f7f9'),
    ('100', '#c9eef2'),   # shallows: the keyboard background
    ('200', '#b2e3eb'),   # tabs that are off, a sticky key that is on
    ('300', '#96d5e1'),   # the edge under the letter keys, the buttons of the tools, a letter key under the finger
    ('400', '#74c4d6'),   # outlines, the selected row
    ('500', '#4aafc9'),   # a highlight key under the finger, the edge of the preview bubble
    ('600', '#1a97ba'),   # the vivid step: the tint of the tools
    ('650', '#0e8baf'),   # sea blue: the highlight keys (white text reads at 3.9)
    ('700', '#0f7ea3'),   # secondary texts and the small letters of the keys
    ('800', '#126286'),   # the edge under the highlight keys
    ('900', '#104969'),
    ('950', '#0a3550'),   # deep sea: the ink
])


# The scale of Rose: one hue of petal pink from blush to wine, named by lightness (OKLCH, times 1000; the hue between 355 and 360 degrees,
# the chroma low in the pale steps, highest in the rose of the interaction and lower again in the dark ones). 983, 920, 833, 637, 561,
# 497 and 309 are the keys, the background, the highlight keys, the rose of the interaction, the small letters, the lit dash and the ink
# that the theme always had; the rest is what its states, tools, bubble and popup were missing. Every color of the theme is a step of
# this scale, so that any two of them belong together; the only one from outside is the red of the locked dash (by the rule of every
# theme).
ROSE = collections.OrderedDict([
    ('983', '#fff7fa'),   # blush: the letter keys, the cards, the field, the bubble, the text on the rose
    ('920', '#f4dee5'),   # petals: the keyboard background
    ('880', '#f0cdd8'),   # tabs that are off, a sticky key that is on
    ('833', '#efb6c8'),   # the highlight keys, the buttons of the tools, a letter key under the finger, the edge under the letter keys
    ('790', '#eca2ba'),   # the selected row, outlines, the chosen variant of the popup
    ('745', '#e78dab'),   # a button under the finger, a highlight key under the finger, the edge under the highlight keys
    ('690', '#e46f98'),   # the edge under a letter key or a highlight key that is held, a locked highlight key
    ('637', '#e04e86'),   # the rose of the interaction: the tint of the tools, the edge that lights up under a sticky key, the preview bubble
    ('561', '#bb4371'),   # secondary texts, the rose of Send and of the + button (blush reads at 5.1), the edge of a locked key
    ('497', '#9f375f'),   # the lit dash, the small letters of the highlight keys
    ('309', '#4a2030'),   # wine: the ink
])


# The scale of Midnight Steel: one hue of blue steel from the keyboard background to the ice of the text, in steps of lightness (OKLCH,
# hue 255 turning to 258 as it gets lighter, the chroma low in the dark steps and highest in the blue of the interaction). The
# names are the lightness times 1000. 232, 306, 385, 707 and 946 are the background, the letter keys, the highlight keys, the
# interaction blue and the text that the theme always had; the rest is what its states, tools, bubble and popup were missing, so
# that every color of the theme is one of these steps (or the red of the locked key, in the same lightness and chroma).
STEEL = collections.OrderedDict([
    ('190', '#0e141c'),   # under the letter keys, the field of the tools (a well), the text on the interaction blue
    ('232', '#171e27'),   # the keyboard background
    ('285', '#212b38'),   # under the highlight keys, the tabs that are off
    ('306', '#243040'),   # the letter keys, the cards and the Cancel button
    ('345', '#2b3a4e'),   # the buttons of the tools, the bubble of the preview and of the popup, the divider
    ('385', '#33455c'),   # the highlight keys, the outline of the field
    ('430', '#385173'),   # a letter key under the finger, the selected row, the edge of the popup
    ('480', '#405f89'),   # a highlight key under the finger, the chosen variant of the popup
    ('540', '#4c70a4'),   # the edge of the preview bubble
    ('610', '#5884c3'),   # the edge under a sticky key that is on
    ('660', '#7e94b1'),   # secondary texts and the small letters of the letter keys
    ('707', '#72a2e8'),   # the interaction blue: the lit dash, the tint of the tools, Send, the + button
    ('800', '#a0c1e9'),   # the small letters of the highlight keys, the ring of Send
    ('946', '#e7eef7'),   # ice: the text
])
STEEL_RED = collections.OrderedDict([('340', '#592627'), ('420', '#7a3336'), ('700', '#e87878')])   # locked: a key, and its edge and dash


# The scale of Snow: one hue of cold slate from white to ink, named by lightness (OKLCH, times 1000; hue 255 to 258, the chroma
# low in the pale steps and higher as they get darker). 1000, 936, 855, 551, 482 and 255 are the white of the keys, the
# background, the highlight keys, the tint of the tools, the secondary text and the ink that the theme always had; 707 is the lit dash
# of Midnight Steel. Every color of the theme is a step of this scale, so that any two of them belong together; the only one from
# outside is the red of the locked dash.
SNOW = collections.OrderedDict([
    ('1000', '#ffffff'),  # the letter keys, the cards, the field, the bubble
    ('936', '#e7eaef'),   # the keyboard background
    ('895', '#d8dde4'),   # tabs that are off, a sticky key that is on
    ('855', '#c8d0db'),   # the highlight keys, the buttons of the tools, a letter key under the finger
    ('815', '#b8c4d4'),   # the edge under the letter keys, the selected row, outlines
    ('770', '#a6b6cc'),   # a button under the finger, a highlight key under the finger, the unlit dash
    ('715', '#90a5c1'),   # the edge under the highlight keys
    ('707', '#72a2e8'),   # the lit dash
    ('650', '#7891b3'),
    ('620', '#5b87c8'),   # the edge that lights up under a sticky key, the edge of the preview bubble
    ('551', '#5a7494'),   # slate: the tint of the tools
    ('520', '#3868b0'),   # the blue of Send and of the + button (white reads at 5.6), the edge of a locked key
    ('482', '#4b6079'),   # secondary texts
    ('255', '#1f2329'),   # the ink
])


# The scale of Denim: one hue of cobalt from deep navy to ice (OKLCH, the hue 256 to 258 degrees, named by lightness times 1000).
# 411 is the middle of the popup of variants of Cobalt Glass (its two ends are 455 and 370): the background of the keyboard is that color
# with that opacity. Every color of the theme is a step of this scale, so that any two of them belong together; the only
# ones from outside are the reds of what is locked.
DENIM = collections.OrderedDict([
    ('190', '#081425'),   # the field of the tools (a well), the ink on the interaction blue
    ('260', '#112440'),   # the edge under the letter keys
    ('320', '#1a3356'),   # the letter keys, the cards, the Cancel button
    ('370', '#254066'),   # the edge under the highlight keys, the edge under a key under the finger
    ('411', '#2b4b78'),   # the keyboard background
    ('455', '#32578b'),   # the bubble of the preview and of the popup, a letter key under the finger, tabs that are off, the divider
    ('500', '#3864a0'),   # the highlight keys, buttons of the tools, a highlight key under the finger's edge, the outline of the field
    ('545', '#3f70b5'),   # the chosen variant of the popup, the selected row, a sticky highlight key that is on
    ('600', '#4d81ca'),   # a highlight key under the finger, a button under the finger, the edge of the preview bubble
    ('660', '#6294da'),   # the tint of the tools
    ('735', '#80abe8'),   # the interaction blue: the edge under a key that is on, Send, the + button, the sticky edge of the preview
    ('800', '#9ec0ee'),   # the small letters of the letter keys, secondary texts, the ring of Send
    ('870', '#c5d6eb'),   # the lit dash, the small letters of the highlight keys, the tabs that are off
    ('946', '#e7eef7'),   # ice: the text
])
DENIM_RED = collections.OrderedDict([('340', '#582a33'), ('420', '#7e3b46'), ('700', '#ffa3a3')])   # locked: a key, and its edge and dash (the dash reads on the face of the highlight keys: 3.1)


SOLID = [
    # ---- dark
    # steel blue, dark and calm: the colors that the theme always had, on one scale; letter keys and highlight keys with a soft edge
    # under them that is the darker step of the same steel, the interaction blue (707) as the edge that lights up under a key that is
    # on. Every color below is a step of the scale STEEL
    solid('midnight', 'Midnight Steel',
          bg=STEEL['232'], key=STEEL['306'], mod=STEEL['385'], text=STEEL['946'], accent=STEEL['707'], tint=STEEL['707'], lip=1.5,
          dash_on=STEEL['707'],
          roles=collections.OrderedDict([
              # ---- labels
              ('hint', STEEL['660']),                # small letters on the letter keys
              ('accent_hint', STEEL['800']),         # the same on the highlight keys, whose face is lighter
              # ---- the dash of Ctrl, Alt and Shift: off and on by the rule of every theme (a tone of the face; the blue 707), locked = red
              ('modifier_indicator_lock', STEEL_RED['700']),
              # ---- tool bar and panels. The blue (707) over the background at these opacities lands on steps of the scale: tabs that
              # are off = 285, buttons = 345, selected row = 430, a button under the finger = 480; a tool of the bar under the finger
              # is the face of the highlight keys (385) at 72% = 345
              ('tool_tint', STEEL['707']),
              ('alpha_flat', '#b9000000'),
              ('alpha_btn', '#35000000'),
              ('alpha_press', '#7e000000'),
              ('alpha_tab_off', '#18000000'),
              ('alpha_sel', '#63000000'),
              ('alpha_card', '#22000000'),
              ('panel_field', STEEL['190']),         # the field is a well, darker than the keyboard, with an outline of the highlight keys
              ('panel_field_stroke', STEEL['385']),
              ('panel_divider', STEEL['345']),
              ('panel_btn', STEEL['306']),           # card of a file: as the cards of the clipboard (which are keys)
              ('panel_tab_off_text', STEEL['660']),
              ('sel_card', STEEL['430']),            # a marked file
              ('sel_media', '#5972a2e8'),            # a marked picture: 707 at 35%
              ('sel_cancel', STEEL['306']),          # Cancel: a key with an outline, Send: the blue
              ('sel_cancel_stroke', STEEL['385']),
              ('sel_send', STEEL['707']),
              ('sel_send_stroke', STEEL['800']),     # also the ring of the check on a marked picture: light, to show on a photo
              ('sel_send_text', STEEL['190']),
              ('attach_fab', STEEL['707']),
              ('attach_fab_stroke', STEEL['800']),
              ('attach_fab_icon', STEEL['190']),
              # ---- preview bubble and popup of variants: one step above the letter keys, so that they float over them
              ('bubble_fill', STEEL['345']),
              ('bubble_stroke', STEEL['430']),
              ('preview_stroke', STEEL['540']),
              ('preview_dots', '#d972a2e8'),
              ('popup_key_fill', STEEL['480']),
              # ---- keys: the more it is held, the bluer. Letters: 306, 430 under the finger; sticky: lit blue edge when on, red when locked.
              # Highlight keys: 385, 480 under the finger; sticky as the letters, on a lighter face
              ('key_normal_lip', STEEL['190']),
              ('key_pressed_fill', STEEL['430']), ('key_pressed_lip', STEEL['345']),
              ('key_on_fill', STEEL['385']), ('key_on_lip', STEEL['610']),
              ('key_lock_fill', STEEL_RED['340']), ('key_lock_lip', STEEL_RED['700']),
              ('key_acc_normal_lip', STEEL['285']),
              ('key_acc_pressed_fill', STEEL['480']), ('key_acc_pressed_lip', STEEL['385']),
              ('key_acc_on_fill', STEEL['430']), ('key_acc_on_lip', STEEL['707']),
              ('key_acc_lock_fill', STEEL_RED['420']), ('key_acc_lock_lip', STEEL_RED['700']),
          ])),
    # a slab of denim blue, dark and rich: the background is the color and the opacity of the popup of variants of Cobalt Glass (see
    # through, with the blur where the phone has it), the letter keys sink into it as navy keycaps with a darker edge under them, the highlight
    # keys are a lighter blue, one light blue for what is touched. Every color below is a step of the scale DENIM
    solid('denim', 'Denim',
          bg=DENIM['411'], key=DENIM['320'], mod=DENIM['500'], text=DENIM['946'], accent=DENIM['735'], tint=DENIM['660'], lip=1.5,
          dash_on=DENIM['870'], clear=(.92, .92),
          roles=collections.OrderedDict([
              # ---- labels
              ('hint', DENIM['800']),                # small letters on the letter keys, placeholder and secondary texts
              ('accent_hint', DENIM['870']),         # the same on the highlight keys, whose face is lighter
              # ---- the dash of Ctrl, Alt and Shift: off by the rule of every theme (a tone of the face), on = 870 (4.1 of contrast), locked = red
              ('modifier_indicator_lock', DENIM_RED['700']),
              # ---- tool bar and panels. The tint (660) over the background at these opacities lands near steps of the scale: tabs that
              # are off = 455, buttons = 500, selected row = 545, a button under the finger = 600; a tool of the bar under the finger
              # is the face of the highlight keys (500) at 48% = 455
              ('tool_tint', DENIM['660']),
              ('alpha_flat', '#7b000000'),
              ('alpha_btn', '#5c000000'),
              ('alpha_press', '#c5000000'),
              ('alpha_tab_off', '#2c000000'),
              ('alpha_sel', '#8b000000'),
              ('alpha_card', '#22000000'),
              ('panel_field', DENIM['260']),         # the field is a well, darker than the keyboard, with an outline of the highlight keys
              ('panel_field_stroke', DENIM['500']),
              ('panel_divider', DENIM['455']),
              ('panel_btn', DENIM['320']),           # card of a file: as the cards of the clipboard (which are keys)
              ('panel_tab_off_text', DENIM['870']),
              ('sel_card', DENIM['545']),            # a marked file
              ('sel_media', '#5980abe8'),            # a marked picture: 735 at 35%
              ('sel_cancel', DENIM['320']),          # Cancel: a key with an outline, Send: the blue
              ('sel_cancel_stroke', DENIM['500']),
              ('sel_send', DENIM['735']),
              ('sel_send_stroke', DENIM['800']),     # also the ring of the check on a marked picture: light, to show on a photo
              ('sel_send_text', DENIM['190']),
              ('attach_fab', DENIM['735']),
              ('attach_fab_stroke', DENIM['800']),
              ('attach_fab_icon', DENIM['190']),
              # ---- preview bubble and popup of variants: lighter than everything under them, so that they float
              ('bubble_fill', DENIM['455']),
              ('bubble_stroke', DENIM['545']),
              ('preview_stroke', DENIM['600']),
              ('preview_dots', '#d980abe8'),
              ('popup_key_fill', DENIM['545']),
              # ---- keys: the more it is held, the lighter. Letters: 320, 500 under the finger; sticky: lit blue edge when on, red when locked.
              # Highlight keys: 500, 600 under the finger; sticky as the letters, on a lighter face
              ('key_normal_lip', DENIM['260']),
              ('key_pressed_fill', DENIM['500']), ('key_pressed_lip', DENIM['411']),
              ('key_on_fill', DENIM['455']), ('key_on_lip', DENIM['735']),
              ('key_lock_fill', DENIM_RED['340']), ('key_lock_lip', DENIM_RED['700']),
              ('key_acc_normal_lip', DENIM['370']),
              ('key_acc_pressed_fill', DENIM['600']), ('key_acc_pressed_lip', DENIM['500']),
              ('key_acc_on_fill', DENIM['545']), ('key_acc_on_lip', DENIM['735']),
              ('key_acc_lock_fill', DENIM_RED['420']), ('key_acc_lock_lip', DENIM_RED['700']),
          ])),
    # ---- light
    # cold snow, light and quiet: white letter keys with a soft slate edge under them on a pale grey background, slate highlight
    # keys, one blue for what is lit. The colors are chosen, not derived: every one below is a step of the scale SNOW
    solid('snow', 'Snow',
          bg=SNOW['936'], key=SNOW['1000'], mod=SNOW['855'], text=SNOW['255'], accent=SNOW['520'], tint=SNOW['551'], lip=1.5,
          dash_on=SNOW['707'],        # the lit dash of Midnight Steel, as it is
          roles=collections.OrderedDict([
              # ---- labels
              ('hint', SNOW['482']),                 # small letters, placeholder and secondary texts
              ('modifier_indicator_off', SNOW['770']),   # the unlit dash of Ctrl, Alt and Shift: a step of the slate, not a grey
              # ---- tool bar and panels. The slate (551) over the background at these opacities lands on steps of the scale: tabs that
              # are off = 895, buttons = 855 (the face of the highlight keys), selected row = 815, a button under the finger = 770;
              # a tool of the bar under the finger is the face of the highlight keys itself
              ('alpha_flat', '#f2000000'),
              ('alpha_btn', '#38000000'),
              ('alpha_press', '#70000000'),
              ('alpha_tab_off', '#1c000000'),
              ('alpha_sel', '#52000000'),
              ('alpha_card', '#1c000000'),
              ('panel_field', SNOW['1000']),         # the field is white, as the keys, with an outline one step above the buttons
              ('panel_field_stroke', SNOW['815']),
              ('panel_divider', SNOW['855']),
              ('panel_btn', SNOW['1000']),           # card of a file: white, as the cards of the clipboard (which are keys)
              ('panel_tab_off_text', SNOW['482']),
              ('sel_card', SNOW['815']),             # a marked file
              ('sel_media', '#593868b0'),            # a marked picture: 520 at 35%
              ('sel_cancel', SNOW['1000']),          # Cancel: a white button with an outline, Send: the blue
              ('sel_cancel_stroke', SNOW['770']),
              ('sel_send', SNOW['520']),
              ('sel_send_stroke', SNOW['815']),      # also the ring of the check on a marked picture: light, to show on a photo
              ('sel_send_text', SNOW['1000']),
              ('attach_fab', SNOW['520']),
              ('attach_fab_stroke', SNOW['815']),
              ('attach_fab_icon', SNOW['1000']),
              # ---- preview bubble and popup of variants
              ('bubble_fill', SNOW['1000']),
              ('bubble_stroke', SNOW['815']),
              ('preview_stroke', SNOW['620']),
              ('preview_dots', '#d93868b0'),
              ('popup_key_fill', SNOW['815']),
              # ---- keys: the deeper, the more it is held. Letters: white, 855 under the finger; sticky: pale when on, with the blue as
              # the edge that lights up under it (620), 815 locked (520). Highlight keys: 855, 770 under the finger; sticky as the letters
              ('key_normal_lip', SNOW['815']),
              ('key_pressed_fill', SNOW['855']), ('key_pressed_lip', SNOW['715']),
              ('key_on_fill', SNOW['895']), ('key_on_lip', SNOW['620']),
              ('key_lock_fill', SNOW['815']), ('key_lock_lip', SNOW['520']),
              ('key_acc_normal_lip', SNOW['715']),
              ('key_acc_pressed_fill', SNOW['770']), ('key_acc_pressed_lip', SNOW['650']),
              ('key_acc_on_fill', SNOW['815']), ('key_acc_on_lip', SNOW['620']),
              ('key_acc_lock_fill', SNOW['715']), ('key_acc_lock_lip', SNOW['520']),
          ])),
    # rose petals, light and warm: the colors that the theme always had, on one scale; blush letter keys with a soft pink edge under them
    # on petal pink, pink highlight keys with a deeper edge, wine ink, the rose of the interaction (637) as the edge that lights up
    # under a key that is on. Every color below is a step of the scale ROSE
    solid('rose', 'Rose',
          bg=ROSE['920'], key=ROSE['983'], mod=ROSE['833'], text=ROSE['309'], accent=ROSE['637'], tint=ROSE['637'], lip=1.5,
          dash_on=ROSE['497'],
          roles=collections.OrderedDict([
              # ---- labels
              ('hint', ROSE['561']),                 # small letters on the letter keys, placeholder and secondary texts
              ('accent_hint', ROSE['497']),          # the same on the highlight keys, whose face is darker
              # ---- the dash of Ctrl, Alt and Shift: off by the rule of every theme (a tone of the face), lit = 497 (dash_on), locked = the
              # red of the rule, deeper: on the face of a locked key (690) the one of the rule would have 1.7 of contrast, this one 3.0
              ('modifier_indicator_lock', '#8c1c2b'),
              # ---- tool bar and panels. The rose (637) over the background at these opacities lands on steps of the scale: tabs that
              # are off = 880, buttons = 833 (the face of the highlight keys), selected row = 790, a button under the finger = 745;
              # a tool of the bar under the finger is the face of the highlight keys itself
              ('alpha_flat', '#f2000000'),
              ('alpha_btn', '#49000000'),
              ('alpha_press', '#93000000'),
              ('alpha_tab_off', '#20000000'),
              ('alpha_sel', '#6d000000'),
              ('alpha_card', '#20000000'),
              ('panel_field', ROSE['983']),          # the field is blush, as the keys, with an outline one step above the buttons
              ('panel_field_stroke', ROSE['790']),
              ('panel_divider', ROSE['833']),
              ('panel_btn', ROSE['983']),            # card of a file: blush, as the cards of the clipboard (which are keys)
              ('panel_tab_off_text', ROSE['561']),
              ('sel_card', ROSE['790']),             # a marked file
              ('sel_media', '#59e04e86'),            # a marked picture: 637 at 35%
              ('sel_cancel', ROSE['983']),           # Cancel: a blush button with an outline, Send: the rose
              ('sel_cancel_stroke', ROSE['745']),
              ('sel_send', ROSE['561']),
              ('sel_send_stroke', ROSE['790']),      # also the ring of the check on a marked picture: light, to show on a photo
              ('sel_send_text', ROSE['983']),
              ('attach_fab', ROSE['561']),
              ('attach_fab_stroke', ROSE['790']),
              ('attach_fab_icon', ROSE['983']),
              # ---- preview bubble and popup of variants
              ('bubble_fill', ROSE['983']),
              ('bubble_stroke', ROSE['790']),
              ('preview_stroke', ROSE['637']),
              ('preview_dots', '#d9e04e86'),
              ('popup_key_fill', ROSE['790']),
              # ---- keys: the deeper, the more it is held. Letters: blush, 833 under the finger; sticky: pale when on, with the rose as
              # the edge that lights up under it (637), 790 locked (561). Highlight keys: 833, 745 under the finger; sticky as the letters
              ('key_normal_lip', ROSE['833']),
              ('key_pressed_fill', ROSE['833']), ('key_pressed_lip', ROSE['745']),
              ('key_on_fill', ROSE['880']), ('key_on_lip', ROSE['637']),
              ('key_lock_fill', ROSE['790']), ('key_lock_lip', ROSE['561']),
              ('key_acc_normal_lip', ROSE['745']),
              ('key_acc_pressed_fill', ROSE['745']), ('key_acc_pressed_lip', ROSE['690']),
              ('key_acc_on_fill', ROSE['790']), ('key_acc_on_lip', ROSE['637']),
              ('key_acc_lock_fill', ROSE['690']), ('key_acc_lock_lip', ROSE['561']),
          ])),
    # sea water, light and calm: foam keys with a soft aqua edge under them on shallow water, sea blue highlight keys with a
    # deep edge, deep sea ink. The colors are chosen, not derived: every one below is a step of the scale AQUA
    solid('aqua', 'Aqua',
          bg=AQUA['100'], key=AQUA['25'], mod=AQUA['650'], text=AQUA['950'], mod_text=AQUA['25'],
          accent=AQUA['600'], tint=AQUA['600'], lip=1.5,
          roles=collections.OrderedDict([
              # ---- labels
              ('hint', AQUA['700']),                 # small letters on the foam keys
              ('accent_hint', AQUA['200']),          # the same on the sea blue keys, where the one above would not read
              ('label_shadow', '#66104969'),           # soft deep shade under the foam labels of the sea blue keys (900 at 40%)
              # ---- the dash of Ctrl, Alt and Shift on the sea blue: lit = foam, as a light that went on; locked = coral. The
              # rule would turn both dark (the face is nearer to white than to black), where a navy and a maroon dash look the
              # same; the coral is told from the foam by its hue, so it keeps its color instead of 3 of contrast
              ('modifier_indicator_on', AQUA['25']),
              ('modifier_indicator_lock', '#ff9eaa'),
              # ---- tool bar and panels. The tint (600) over the background at these opacities lands on steps of the scale:
              # tabs that are off = 200, buttons = 300, selected row = 400, a button under the finger = 500
              ('alpha_flat', '#4d000000'),           # a tool of the bar under the finger: the sea blue at 30% = 300
              ('alpha_btn', '#47000000'),
              ('alpha_press', '#8c000000'),
              ('alpha_tab_off', '#24000000'),
              ('alpha_sel', '#6b000000'),
              ('alpha_card', '#24000000'),
              ('panel_field', AQUA['25']),           # the field is foam, as the keys, with an outline one step above the buttons
              ('panel_field_stroke', AQUA['400']),
              ('panel_divider', AQUA['300']),
              ('panel_btn', AQUA['25']),             # card of a file: foam, as the cards of the clipboard (which are keys)
              ('panel_tab_off_text', AQUA['700']),
              ('sel_card', AQUA['300']),             # a marked file
              ('sel_media', '#591a97ba'),            # a marked picture: 600 at 35%
              ('sel_cancel', AQUA['25']),            # Cancel: a foam button with an outline, Send: a sea blue one
              ('sel_cancel_stroke', AQUA['400']),
              ('sel_send', AQUA['650']),
              ('sel_send_stroke', AQUA['300']),      # also the ring of the check on a marked picture: light, to show on a photo
              ('sel_send_text', AQUA['25']),
              ('attach_fab', AQUA['650']),
              ('attach_fab_stroke', AQUA['300']),
              # ---- preview bubble and popup of variants
              ('bubble_fill', AQUA['25']),
              ('bubble_stroke', AQUA['300']),
              ('preview_stroke', AQUA['500']),
              ('preview_dots', '#d91a97ba'),
              ('popup_key_fill', AQUA['300']),
              # ---- keys: the deeper, the more it is held. Letters: foam, 300 under the finger; sticky: 200 on, 400 locked.
              # Highlight keys: sea blue, lighter (500) under the finger; sticky: 800 on, 900 locked
              ('key_normal_lip', AQUA['300']),
              ('key_pressed_fill', AQUA['300']), ('key_pressed_lip', AQUA['500']),
              ('key_on_fill', AQUA['200']), ('key_on_lip', AQUA['400']),
              ('key_lock_fill', AQUA['400']), ('key_lock_lip', AQUA['600']),
              ('key_acc_normal_lip', AQUA['800']),
              ('key_acc_pressed_fill', AQUA['500']), ('key_acc_pressed_lip', AQUA['700']),
              ('key_acc_on_fill', AQUA['800']), ('key_acc_on_lip', AQUA['900']),
              ('key_acc_lock_fill', AQUA['900']), ('key_acc_lock_lip', AQUA['950']),
          ])),
]

# ---------------------------------------------------------------------------------------------------------------
# The look of a solid key in each state: share of the accent mixed into the face of the key at rest.
# ---------------------------------------------------------------------------------------------------------------
SOLID_STATES = collections.OrderedDict([('pressed', .40), ('on', .28), ('lock', .55)])
SOLID_ACCENT_STATES = collections.OrderedDict([('acc_pressed', .45), ('acc_on', .30), ('acc_lock', .60)])
# The lip (the edge under a key) is the face with this much black: more on a dark face, where it has to go below
# the keyboard background to be seen, less on a light one, where a little is already a shadow.
LIP_DARK, LIP_LIGHT = .45, .20
# Preview bubble and popup of variants: the face of the letter keys with this much white (dark theme, light theme).
SOLID_BUBBLE = (.10, .60)


# ---------------------------------------------------------------------------------------------------------------
# Solid: colors
# ---------------------------------------------------------------------------------------------------------------
def lip_color(face):
    return mix(face, BLACK, LIP_LIGHT if luminance(face) > 0.35 else LIP_DARK)


def plain_roles(c, n, ref, bg, mod, text, own_mod_text, accent, ctrl_bg, clear=1.0, dash_accent=None, dash_face=None, dash_exact=None, tint=None,
                ink=None, ctrl_face=None):
    """The roles read by name (MrTheme.color) of a theme without light, shared by the solid and the gloss families:
    the text of the highlight keys, the dash of Ctrl, Alt, Shift and the Meta key, the tool bar and the panels. bg,
    mod: plain colors (the background and the face of the highlight keys, or the middle of it); ctrl_bg: name of the
    color the bar takes as that face; clear: opacity of the fills that sit on the keyboard background (a see-through
    theme lets it show); dash_accent: color the lit dash starts from when the accent would not show on the
    highlight keys; dash_face: the color of the highlight keys at the height of the dash (default: mod); dash_exact: the
    lit dash itself, which the contrast rule does not move; tint: the color of the buttons and the field border of the
    tools (default: accent); ink: the color of what sits on the background when it is not `text` (the role tool_ink);
    ctrl_face: the plain color that ctrl_bg points at, when it is not `mod`."""
    mod_text = own_mod_text or text
    # the text and the icons of the highlight keys: the text of the layout, or the one of their own. The code asks for
    # the role on a theme with the flag PLAIN_ACCENT_TEXT only in the fonts tool (the chosen font), which draws it on
    # the face of the highlight keys, so it is always written
    c[n('accent_text')] = opaque(mod_text)
    face = dash_face or mod
    off, on, lock = dash_colors(face, dash_accent or accent, mod)
    c[n('modifier_indicator_off')] = off
    c[n('modifier_indicator_on')] = opaque(dash_exact) if dash_exact else on
    c[n('modifier_indicator_lock')] = lock

    # tool bar and panels. ctrl_bg is the face of the highlight keys, as in every theme: the bar derives its colors
    # from it (MrTools.deriveColors); alpha_flat = how much of it a pressed tool button shows (less where that face
    # is far from the background). A light theme gives the inner buttons, tabs, field border and selection its own vivid
    # color (tool_tint: the derivation would turn a light face into a dark, dull tone) and fills them a little more
    veil = (lambda col: opaque(col)) if clear >= 1 else (lambda col: alpha(col, clear))
    c[n('ctrl_bg')] = ref(ctrl_bg)
    ctrl_color = ctrl_face or mod
    c[n('alpha_flat')] = alpha(BLACK, .70 if contrast(ctrl_color, bg) < 2.2 else .40)
    if ink:
        c[n('tool_ink')] = opaque(ink)
        c[n('tool_hint')] = mix(bg, ink, .62)
    c[n('panel_icon')] = ref('tool_ink' if ink else 'text')
    c[n('panel_tab_on_text')] = ref('tool_ink' if ink else 'text')
    tint = tint or accent
    text = ink or text          # from here on, what is drawn on the background
    if dark_ink(text):
        c[n('tool_tint')] = opaque(tint)
        c[n('alpha_btn')] = alpha(BLACK, LIGHT_ALPHA['btn'])
        c[n('alpha_tab_off')] = alpha(BLACK, LIGHT_ALPHA['tab_off'])
        c[n('alpha_sel')] = alpha(BLACK, LIGHT_ALPHA['sel'])
        c[n('alpha_card')] = alpha(BLACK, LIGHT_ALPHA['card'])
        c[n('panel_tab_off_text')] = ref('hint')
        c[n('panel_btn')] = veil(mix(bg, tint, .16))
        c[n('sel_cancel')] = veil(mix(bg, tint, .16))
        c[n('sel_cancel_stroke')] = mix(bg, tint, .40)
    else:
        c[n('alpha_btn')] = alpha(BLACK, DARK_ALPHA['btn'])
        c[n('alpha_tab_off')] = alpha(BLACK, DARK_ALPHA['tab_off'])
        c[n('alpha_sel')] = alpha(BLACK, DARK_ALPHA['sel'])
        c[n('alpha_card')] = alpha(BLACK, DARK_ALPHA['card'])
        c[n('panel_tab_off_text')] = mix(bg, text, .60)
        c[n('panel_btn')] = veil(mix(bg, text, .10))
        c[n('sel_cancel')] = veil(mix(bg, text, .10))
        c[n('sel_cancel_stroke')] = mix(bg, text, .24)
    c[n('sel_cancel_text')] = ref('tool_ink' if ink else 'text')
    c[n('sel_send')] = opaque(accent)
    c[n('sel_send_stroke')] = mix(accent, WHITE, .25)
    c[n('sel_send_text')] = opaque(BLACK if luminance(accent) > 0.30 else WHITE)
    c[n('attach_fab')] = alpha(ctrl_color, .95)
    c[n('attach_fab_stroke')] = mix(ctrl_color, mod_text, .20)
    c[n('attach_fab_icon')] = opaque(mod_text)
    c[n('sel_media')] = alpha(accent, .35)
    c[n('sel_card')] = veil(mix(bg, accent, .30))


def solid_colors(th):
    """Every color of a solid theme, name -> value, in the order of the file."""
    t, bg, key, mod, text, accent = th.tag, th.bg, th.key, th.mod, th.text, th.accent
    mod_text = th.mod_text or text
    light = dark_ink(text)
    n = lambda role: 'mr_%s_%s' % (t, role)
    ref = lambda role: '@color/' + n(role)
    c = collections.OrderedDict()

    # ---- what the layouts point at
    # (a see-through theme has two backgrounds: kbd_bg where there is no blur behind the keyboard, kbd_bg_blur where there is)
    c[n('kbd_bg')] = opaque(bg) if not th.clear else alpha(bg, th.clear[0])
    if th.clear:
        c[n('kbd_bg_blur')] = alpha(bg, th.clear[1])
    c[n('text')] = opaque(text)
    c[n('cursor')] = ref('text')
    c[n('hint')] = lively(th.tint or accent, text, [bg, key]) if light else mix(key, text, .50)
    c[n('popup_hint')] = ref('hint')

    plain_roles(c, n, ref, bg, mod, text, th.mod_text, accent, 'key_acc_normal_fill', GLOSS_VEIL if th.clear else 1.0,
                dash_exact=th.dash_on, tint=th.tint)

    # ---- preview bubble and popup of variants
    bubble = hex6(mix(key, WHITE, SOLID_BUBBLE[1 if light else 0]))
    c[n('bubble_fill')] = opaque(bubble)
    c[n('bubble_stroke')] = mix(bubble, text, .18)
    c[n('preview_stroke')] = opaque(accent)
    c[n('preview_dots')] = alpha(accent, .85)
    c[n('popup_key_fill')] = mix(bubble, accent, .45)

    # ---- keys: fill = the face, lip = the edge under it
    faces = collections.OrderedDict([('normal', key)])
    for state, share in SOLID_STATES.items():
        faces[state] = hex6(mix(key, accent, share))
    faces['acc_normal'] = mod
    for state, share in SOLID_ACCENT_STATES.items():
        faces[state] = hex6(mix(mod, accent, share))
    for state, face in faces.items():
        c[n('key_%s_fill' % state)] = opaque(face)
        if th.lip:
            c[n('key_%s_lip' % state)] = lip_color(face)

    # ---- a theme with chosen colors: they replace the derived ones (same place in the file); the roles that only have a
    # default go after the roles read by name
    own = collections.OrderedDict()
    for role, color in th.roles.items():
        color = color if len(color.lstrip('#')) == 8 else opaque(color)
        if n(role) in c:
            c[n(role)] = color
        else:
            assert role in OWN_ROLES, 'theme %s: %s is not a role of a solid theme' % (t, role)
            own[n(role)] = color
    if own:
        out = collections.OrderedDict()
        for name, color in c.items():
            if name == n('bubble_fill'):
                out.update(own)
            out[name] = color
        c = out
    return c


# ---------------------------------------------------------------------------------------------------------------
# Solid: drawables
# ---------------------------------------------------------------------------------------------------------------
def plain(color, radius, extra=''):
    return ('            <solid android:color="@color/%s" />\n%s'
            '            <corners android:radius="%sdp" />\n' % (color, extra, num(radius)))


def solid_key(t, state, lip):
    """A key: the lip, then the face. The face is the last layer: KeyStyle gives it the key radius and puts it at
    half the key spacing from the cell edge; the lip, with the same side insets, gets the same radius."""
    p = 'mr_%s_key_%s' % (t, state)
    out = layer(plain(p + '_lip', 8), top=lip) if lip else ''
    out += layer(plain(p + '_fill', 8), bottom=lip)
    return '%s<layer-list %s>\n%s</layer-list>\n' % (HEAD, NS, out)


def solid_bubble(t, radius, stroke_color, lift, padding='', tail=''):
    """Preview bubble or popup of variants: a soft shadow under a plain face with a 1 dp edge. `lift` = how far the
    shadow shows under the face, in dp."""
    face = plain('mr_%s_bubble_fill' % t, radius,
                 '            <stroke android:width="1dp" android:color="@color/%s" />\n' % stroke_color) + padding
    out = layer(plain('mr_popup_shadow' if not padding else 'mr_preview_shadow', radius), left=1, top=2, right=1)
    out += layer(face, bottom=lift)
    return '%s<layer-list %s>\n%s%s</layer-list>\n' % (HEAD, NS, out, tail)


def solid_drawables(th):
    t = th.tag
    d = collections.OrderedDict()
    d['btn_keyboard_key_%s.xml' % t] = key_selector(t, False)
    d['btn_keyboard_key_%s_accent.xml' % t] = key_selector(t, True)
    # asked of every theme (res_check.py): what LatinKey.isHl highlights on the normal selector is a highlight key
    d['key_%s_hl.xml' % t] = solid_key(t, 'acc_normal', th.lip)
    for state in ['normal'] + list(SOLID_STATES) + ['acc_normal'] + list(SOLID_ACCENT_STATES):
        d['key_%s_%s.xml' % (t, state)] = solid_key(t, state, th.lip)
    d['btn_keyboard_key_popup_%s.xml' % t] = selector([(('pressed',), 'key_popup_%s_pressed' % t)])
    d['key_popup_%s_pressed.xml' % t] = ('%s<layer-list %s>\n%s</layer-list>\n'
                                         % (HEAD, NS, layer(plain('mr_%s_popup_key_fill' % t, 8), 2, 2, 2, 2)))
    # the padding of the bubble goes on its LAST shape: a layer-list shrinks every later layer by the padding
    # of the ones before it
    d['preview_%s_bg.xml' % t] = solid_bubble(t, 10, 'mr_%s_preview_stroke' % t, 3, PREVIEW_PADDING)
    d['preview_%s_more_bg.xml' % t] = solid_bubble(t, 10, 'mr_%s_preview_stroke' % t, 3, PREVIEW_PADDING, PREVIEW_DOTS % t)
    d['popup_%s_bg.xml' % t] = solid_bubble(t, 16, 'mr_%s_bubble_stroke' % t, 2)
    return d


# ===============================================================================================================
# GLOSS family: keys with a sheen. The face is a gradient of three colors under a clear coat, with a light edge above
# and a dark one below, as if lit from above: polished metal, or wet glass.
#   tag, name   as in the other tables
#   bg        keyboard background (also the bar and the panels)
#   key       face of the letter keys: (top, middle, bottom)
#   rim       edges of the letter keys: (the light one above, the dark one below)
#   mod, mod_rim   the same for the highlight keys (Ctrl, Alt, Shift, Tab, arrows, Space, Enter...)
#   text      labels and icons of the letter keys; a dark text makes it a light theme (MrLight.java)
#   mod_text  labels and icons of the highlight keys; None = the same as text
#   accent    color a key leans to under the finger; also the lit dash, the chosen variant, the bubble edge
#   mod_accent   the same for the highlight keys, and the color of the lit dash of Ctrl, Alt and Shift, when
#             `accent` is too close to the face of those keys to show on it; None = accent
#   middle    where the middle color of the faces sits, 0 (top) to 1 (bottom)
#   coat      the clear coat, white over the upper part of the face: (opacity at the top, opacity at the middle).
#             It is mixed into the colors of the face here, not drawn as a layer of its own
#   lip       height in dp of the shadow under each key
#   clear     None, or (opacity of the keyboard background without blur, with blur) for a theme whose background
#             is see-through: it gets the flag TRANSLUCENT, which blurs what is behind the keyboard where the phone
#             can (MrTranslucentBlur). The background is one sheet under the bar, the panels and the keys
#             (MrTools.applyTranslucentBlur puts it on the root of the tools and clears the keyboard view)
#   tint      as in the solid table (the tools of a light theme)
#   ink       None, or the color of the text and the icons of what sits on the keyboard background (bar, panels,
#             suggestions, buttons of the system under the keyboard), for a theme whose keys and background are of opposite
#             brightness (light keys on a dark background): the role tool_ink. It decides whether the tools are those of a
#             dark or of a light theme, in place of `text`; their secondary text is the role tool_hint, derived from it
#   hint      color of the small letters on the keys (the layout's keyHintColor); None = derived from the tint or the accent.
#             The same color is on the faces of both tones, so it has to read on both
#   ctrl      which part of the face of the highlight keys the bar takes as that face (ctrl_bg): 'top', 'mid' or 'bottom'. The
#             middle of a face as dark as the background gives pressed tool buttons that do not show: the lit bottom does
#   roles     None, or {role: color} for a theme whose tools are chosen, not derived (Chrome: every color of the bar, the panels, the
#             bubble and the small letters is a step of one scale): as in the solid table, each entry replaces the derived color of
#             that role or declares one that only has a default (the ones in OWN_ROLES)
# ---------------------------------------------------------------------------------------------------------------
Gloss = collections.namedtuple('Gloss', 'tag name bg key rim mod mod_rim text mod_text accent mod_accent '
                                         'middle coat lip clear tint ink hint ctrl roles')


def gloss(tag, name, bg, key, rim, mod, mod_rim, text, accent, mod_text=None, mod_accent=None,
          middle=.5, coat=(.30, .04), lip=1, clear=None, tint=None, ink=None, hint=None, ctrl='mid', roles=None):
    return Gloss(tag, name, bg, key, rim, mod, mod_rim, text,
                 mod_text, accent, mod_accent, middle, coat, lip, clear, tint, ink, hint, ctrl, roles or {})


# The scale of Chrome: steel on a navy night, named by lightness (OKLCH times 1000; hue 255 to 258, the chroma low in the dark steps
# and in the silver, highest in the interaction blue). 176, 966, 852 and 172 are the background, the silver of the letter keys and
# the dark of their labels that the theme always had, 632 and 802 its blue; the rest is what its softer metal, tools, bubble and small
# letters were missing, so that every color of the theme is one of these steps. The tools are the tint (685) over the background at
# the opacities of the roles alpha_*: tabs that are off = 224, buttons and cards = 282, outlines = 337, selected row = 368, a button
# under the finger = 419. The states of the keys (under the finger, on, locked) are the faces with this blue (632 and 802) mixed in
# (GLOSS_STATES); the red of the locked dash is the one color from outside.
CHROME = collections.OrderedDict([
    ('138', '#05090f'),   # the shadow under the keys and their dark edge, the field of the tools (a well)
    ('172', '#0b1018'),   # the labels of the letter keys
    ('176', '#09111c'),   # the keyboard background, the horizon of the highlight keys
    ('224', '#121c29'),   # tabs that are off
    ('258', '#192434'),   # the top of the highlight keys, the divider
    ('282', '#1e2a3a'),   # the bottom of the highlight keys, the buttons of the tools, the cards, Cancel
    ('337', '#2a384b'),   # the edge under the letter keys, outlines
    ('368', '#314055'),   # the selected row, a marked file
    ('419', '#3c4e66'),   # a button under the finger, the unlit dash
    ('498', '#53647a'),   # the small letters of the letter keys
    ('632', '#3d8fd6'),   # the interaction blue: Send, the + button, the edge of the preview bubble, what a key leans to under the finger
    ('685', '#7e9cc4'),   # the tint of the tools, secondary texts
    ('709', '#8fa3bd'),   # the small letters of the highlight keys, the light edge of their top, the edge of the bubble
    ('721', '#6eabe0'),   # the ring of Send
    ('773', '#aab6c8'),   # the middle of the metal of the letter keys
    ('802', '#7cc7ff'),   # the lit dash, what a highlight key leans to under the finger
    ('852', '#c7cfdb'),   # the bottom of the metal, the bottom of the bubble
    ('943', '#e6edf6'),   # ice: the text and the icons on the background
    ('953', '#eaf0f8'),   # the light edge of the letter keys
    ('966', '#f1f4f8'),   # the top of the metal, the top of the bubble
    ('972', '#f2f6fb'),   # the labels of the highlight keys
])


GLOSS = [
    # silver gradients: light, darker in the middle, light again; gunmetal for the highlight keys
    gloss('chrome', 'Chrome',
          bg=CHROME['176'],
          key=(CHROME['966'], CHROME['773'], CHROME['852']), rim=(CHROME['953'], CHROME['337']),
          mod=(CHROME['258'], CHROME['176'], CHROME['282']), mod_rim=(CHROME['709'], CHROME['138']),
          text=CHROME['172'], mod_text=CHROME['972'], accent=CHROME['632'], mod_accent=CHROME['802'], middle=.55, coat=(.10, .02),
          # polished steel on a navy night: pale silver letter keys with a soft horizon (the middle of the metal is 773, not a dark
          # grey), a navy edge under them, highlight keys of a dark navy steel. The keys are light and the background is dark, so what
          # is drawn on the background has its own ink; the small letters are two steel blues, one that reads on the pale faces and
          # one on the dark ones
          ink=CHROME['943'], hint=CHROME['498'], ctrl='bottom',
          roles=collections.OrderedDict([
              ('accent_hint', CHROME['709']),         # the small letters on the highlight keys, whose face is dark
              # the unlit dash of Ctrl, Alt and Shift: an unlit tube (a dim steel) instead of the black the rule gives on a dark face
              ('modifier_indicator_off', CHROME['419']),
              # ---- tool bar and panels. The tint (685) over the background at these opacities lands on steps of the scale: tabs that
              # are off = 224, buttons and cards = 282, selected row = 368, a button under the finger = 419; a tool of the bar under
              # the finger is the bottom of the highlight keys (282) at 70%
              ('tool_tint', CHROME['685']),
              ('alpha_flat', '#b3000000'),
              ('alpha_btn', '#2e000000'),
              ('alpha_press', '#70000000'),
              ('alpha_tab_off', '#14000000'),
              ('alpha_sel', '#57000000'),
              ('alpha_card', '#2e000000'),
              ('panel_field', CHROME['138']),         # the field is a well, darker than the keyboard, with an outline
              ('panel_field_stroke', CHROME['337']),
              ('panel_divider', CHROME['258']),
              ('panel_btn', CHROME['282']),           # card of a file: the bottom of the highlight keys
              ('panel_tab_off_text', CHROME['685']),
              ('sel_card', CHROME['368']),            # a marked file
              ('sel_cancel', CHROME['282']),          # Cancel: a key with an outline, Send: the blue
              ('sel_cancel_stroke', CHROME['337']),
              ('sel_send', CHROME['632']),
              ('sel_send_stroke', CHROME['721']),     # also the ring of the check on a marked picture: light, to show on a photo
              ('attach_fab', CHROME['632']),
              ('attach_fab_stroke', CHROME['721']),
              ('attach_fab_icon', CHROME['972']),
              # ---- preview bubble and popup of variants: a lighter metal than the keys, so that they float over them
              ('bubble_top', CHROME['966']),
              ('bubble_bottom', CHROME['852']),
              ('bubble_stroke', CHROME['709']),
          ])),
]

# ---------------------------------------------------------------------------------------------------------------
# The look of a gloss key in each state: share of the accent mixed into each color of the face and of the ring.
# ---------------------------------------------------------------------------------------------------------------
GLOSS_STATES = collections.OrderedDict([('pressed', .32), ('on', .20), ('lock', .40)])
GLOSS_ACCENT_STATES = collections.OrderedDict([('acc_pressed', .36), ('acc_on', .22), ('acc_lock', .44)])
# The shadow under a key: the keyboard background with this much black.
GLOSS_LIP = .45
# Fills of the tool panels on a see-through background: this opaque, so that it shows through them too.
GLOSS_VEIL = .85


# ---------------------------------------------------------------------------------------------------------------
# Gloss: colors
# ---------------------------------------------------------------------------------------------------------------
def gloss_dash_face(th):
    """Color of the highlight keys (with their clear coat) at the height of the dash, 85% of the way down: the face is
    a gradient of three colors, the middle one at th.middle."""
    top, mid = hex6(mix(th.mod[0], WHITE, th.coat[0])), hex6(mix(th.mod[1], WHITE, th.coat[1]))
    at = .85
    if at <= th.middle:
        return mix(top, mid, at / th.middle)
    return mix(mid, th.mod[2], (at - th.middle) / (1 - th.middle))


def gloss_colors(th):
    """Every color of a gloss theme, name -> value, in the order of the file."""
    t, bg, text, accent = th.tag, th.bg, th.text, th.accent
    n = lambda role: 'mr_%s_%s' % (t, role)
    ref = lambda role: '@color/' + n(role)
    c = collections.OrderedDict()

    # ---- what the layouts point at. A see-through theme has two backgrounds: kbd_bg where there is no blur behind
    # the keyboard, kbd_bg_blur (lighter: the blur already hides what is behind) where there is
    c[n('kbd_bg')] = opaque(bg) if not th.clear else alpha(bg, th.clear[0])
    if th.clear:
        c[n('kbd_bg_blur')] = alpha(bg, th.clear[1])
    c[n('text')] = opaque(text)
    c[n('cursor')] = ref('text')
    if th.hint:
        c[n('hint')] = opaque(th.hint)
    else:
        c[n('hint')] = lively(th.tint or accent, text, [bg, th.key[1]]) if dark_ink(text) else mix(th.key[1], text, .50)
    c[n('popup_hint')] = ref('hint')

    # ---- roles read by name (MrTheme.color)
    ctrl_face = {'top': hex6(mix(th.mod[0], WHITE, th.coat[0])), 'mid': hex6(th.mod[1]), 'bottom': hex6(th.mod[2])}[th.ctrl]
    plain_roles(c, n, ref, bg, th.mod[1], text, th.mod_text, accent, 'key_acc_normal_' + th.ctrl,
                GLOSS_VEIL if th.clear else 1.0, th.mod_accent, gloss_dash_face(th), tint=th.tint, ink=th.ink,
                ctrl_face=ctrl_face if th.ctrl != 'mid' else None)

    # ---- preview bubble and popup of variants: the face of a letter key
    c[n('bubble_top')] = opaque(th.key[0])
    c[n('bubble_bottom')] = opaque(th.key[1])
    c[n('bubble_stroke')] = mix(th.key[1], text, .22)
    c[n('preview_stroke')] = opaque(accent)
    c[n('preview_dots')] = alpha(accent, .85)
    c[n('popup_key_top')] = mix(th.key[0], accent, .50)
    c[n('popup_key_bottom')] = mix(th.key[1], accent, .50)

    # ---- keys: top/mid/bottom = the face with its clear coat, rim_top/rim_bottom = the light edge above it and
    # the dark one below, key_lip = the shadow under every key
    def state(name, stops, rim, toward, share):
        lean = (lambda col: hex6(mix(col, toward, share))) if share else (lambda col: col)
        for part, col, coat in zip(('top', 'mid', 'bottom'), stops, (th.coat[0], th.coat[1], 0.0)):
            c[n('key_%s_%s' % (name, part))] = mix(lean(col), WHITE, coat)
        for part, col in zip(('rim_top', 'rim_bottom'), rim):
            c[n('key_%s_%s' % (name, part))] = opaque(lean(col))
    state('normal', th.key, th.rim, None, 0)
    for name, share in GLOSS_STATES.items():
        state(name, th.key, th.rim, accent, share)
    state('acc_normal', th.mod, th.mod_rim, None, 0)
    for name, share in GLOSS_ACCENT_STATES.items():
        state(name, th.mod, th.mod_rim, th.mod_accent or accent, share)
    if th.lip:
        c[n('key_lip')] = mix(bg, BLACK, GLOSS_LIP)

    # ---- a theme with chosen colors: they replace the derived ones (same place in the file); the roles that only have a
    # default go after the roles read by name
    own = collections.OrderedDict()
    for role, color in th.roles.items():
        color = color if len(color.lstrip('#')) == 8 else opaque(color)
        if n(role) in c:
            c[n(role)] = color
        else:
            assert role in OWN_ROLES, 'theme %s: %s is not a role of a gloss theme' % (t, role)
            own[n(role)] = color
    if own:
        out = collections.OrderedDict()
        for name, color in c.items():
            if name == n('bubble_top'):
                out.update(own)
            out[name] = color
        c = out
    return c


# ---------------------------------------------------------------------------------------------------------------
# Gloss: drawables
# ---------------------------------------------------------------------------------------------------------------
def sheen(top, mid, bottom, radius, middle, extra=''):
    """A vertical gradient of three colors; `middle` = where the second one sits (0 = top, 1 = bottom). A linear
    gradient reads that position from centerY, or from centerX when centerY is the default 0.5."""
    return ('            <gradient android:angle="270" android:startColor="%s" android:centerColor="%s" '
            'android:endColor="%s" android:centerY="%s" />\n%s'
            '            <corners android:radius="%sdp" />\n' % (top, mid, bottom, num(middle), extra, num(radius)))


def gloss_key(th, state):
    """A key: the shadow, the dark edge, the light edge and, last, the face. The three under the face have its
    outline, moved down (shadow, dark edge) or up (light edge): with the same side insets as the face, KeyStyle
    gives all four the key radius, and puts the face, the last layer, at half the key spacing from the cell edge."""
    p = 'mr_%s_key_%s' % (th.tag, state)
    col = lambda part: '@color/%s_%s' % (p, part)
    lip = th.lip
    out = layer(plain('mr_%s_key_lip' % th.tag, 8), top=lip + 1) if lip else ''
    out += layer(plain(p + '_rim_bottom', 8), top=2, bottom=lip)
    out += layer(plain(p + '_rim_top', 8), bottom=lip + 2)
    out += layer(sheen(col('top'), col('mid'), col('bottom'), 8, th.middle), top=1, bottom=lip + 1)
    return '%s<layer-list %s>\n%s</layer-list>\n' % (HEAD, NS, out)


def gloss_bubble(t, radius, stroke_color, lift, padding='', tail=''):
    """Preview bubble or popup of variants: a soft shadow under a two-color face with a 1 dp edge."""
    face = ('            <gradient android:angle="270" android:startColor="@color/mr_%s_bubble_top" '
            'android:endColor="@color/mr_%s_bubble_bottom" />\n'
            '            <stroke android:width="1dp" android:color="@color/%s" />\n'
            '            <corners android:radius="%sdp" />\n%s' % (t, t, stroke_color, num(radius), padding))
    out = layer(plain('mr_popup_shadow' if not padding else 'mr_preview_shadow', radius), left=1, top=2, right=1)
    out += layer(face, bottom=lift)
    return '%s<layer-list %s>\n%s%s</layer-list>\n' % (HEAD, NS, out, tail)


def gloss_drawables(th):
    t = th.tag
    d = collections.OrderedDict()
    d['btn_keyboard_key_%s.xml' % t] = key_selector(t, False)
    d['btn_keyboard_key_%s_accent.xml' % t] = key_selector(t, True)
    # asked of every theme (res_check.py): what LatinKey.isHl highlights on the normal selector is a highlight key
    d['key_%s_hl.xml' % t] = gloss_key(th, 'acc_normal')
    for state in ['normal'] + list(GLOSS_STATES) + ['acc_normal'] + list(GLOSS_ACCENT_STATES):
        d['key_%s_%s.xml' % (t, state)] = gloss_key(th, state)
    d['btn_keyboard_key_popup_%s.xml' % t] = selector([(('pressed',), 'key_popup_%s_pressed' % t)])
    d['key_popup_%s_pressed.xml' % t] = (
        '%s<layer-list %s>\n%s</layer-list>\n'
        % (HEAD, NS, layer('            <gradient android:angle="270" android:startColor="@color/mr_%s_popup_key_top" '
                           'android:endColor="@color/mr_%s_popup_key_bottom" />\n'
                           '            <corners android:radius="8dp" />\n' % (t, t), 2, 2, 2, 2)))
    d['preview_%s_bg.xml' % t] = gloss_bubble(t, 10, 'mr_%s_preview_stroke' % t, 3, PREVIEW_PADDING)
    d['preview_%s_more_bg.xml' % t] = gloss_bubble(t, 10, 'mr_%s_preview_stroke' % t, 3, PREVIEW_PADDING, PREVIEW_DOTS % t)
    d['popup_%s_bg.xml' % t] = gloss_bubble(t, 16, 'mr_%s_bubble_stroke' % t, 2)
    return d


# ---------------------------------------------------------------------------------------------------------------
# Layouts: the same three files of every theme of the keyboard, only the name changes (res_check.py compares them)
# ---------------------------------------------------------------------------------------------------------------
LAYOUTS = collections.OrderedDict([
    ('input_mr_%s.xml', '''<?xml version="1.0" encoding="utf-8"?>
<com.mrkeyboard.app.LatinKeyboardView
    android:textStyle="bold"
    android:id="@id/LatinkeyboardBaseView"
    android:background="@color/mr_%(t)s_kbd_bg"
    android:tag="mr_%(t)s"
    android:paddingBottom="@dimen/keyboard_bottom_padding"
    android:layout_width="fill_parent"
    android:layout_height="wrap_content"
    android:layout_alignParentBottom="true"
    latin:keyBackground="@drawable/btn_keyboard_key_%(t)s"
    latin:keyCursorColor="@color/mr_%(t)s_cursor"
    latin:keyHintColor="@color/mr_%(t)s_hint"
    latin:keyPreviewLayout="@layout/key_preview_%(t)s"
    latin:keyTextColor="@color/mr_%(t)s_text"
    latin:keyTextStyle="bold"
    latin:popupLayout="@layout/input_popup_%(t)s"
    latin:recolorSymbols="true"
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:latin="http://schemas.android.com/apk/res-auto" />
'''),
    ('input_popup_%s.xml', '''<?xml version="1.0" encoding="utf-8"?>
<LinearLayout
    android:orientation="horizontal"
    android:background="@drawable/popup_%(t)s_bg"
    android:padding="8.0dip"
    android:layout_width="fill_parent"
    android:layout_height="wrap_content"
    xmlns:android="http://schemas.android.com/apk/res/android">
    <com.mrkeyboard.app.LatinKeyboardBaseView
        android:id="@id/LatinKeyboardBaseView"
        android:background="@color/latinkeyboard_transparent"
        android:layout_width="fill_parent"
        android:layout_height="wrap_content"
        android:layout_alignParentBottom="true"
        latin:keyBackground="@drawable/btn_keyboard_key_popup_%(t)s"
        latin:keyHintColor="@color/mr_%(t)s_popup_hint"
        latin:keyHysteresisDistance="0.0dip"
        latin:keyPreviewLayout="@layout/null_layout"
        latin:keyTextColor="@color/mr_%(t)s_text"
        latin:popupLayout="@layout/null_layout"
        latin:verticalCorrection="@dimen/mini_keyboard_vertical_correction"
        xmlns:latin="http://schemas.android.com/apk/res-auto" />
</LinearLayout>
'''),
    ('key_preview_%s.xml', '''<?xml version="1.0" encoding="utf-8"?>
<TextView
    android:textSize="40.0sp"
    android:textColor="@color/mr_%(t)s_text"
    android:gravity="center"
    android:background="@drawable/preview_%(t)s_bg"
    android:layout_width="wrap_content"
    android:layout_height="80.0sp"
    android:minWidth="32.0dip"
    xmlns:android="http://schemas.android.com/apk/res/android" />
'''),
])




# ---------------------------------------------------------------------------------------------------------------
# The list of the setting "Keyboard theme"
#   ORDER   every theme of the keyboard, in the order of the list. The id of a theme (the value stored in the
#           preference pref_keyboard_layout, the index in mr_theme_layouts) is its position here. The ids are not
#           kept between versions: change the list and run the script, the files that it writes follow.
#   HAND    the themes that are written by hand (not in the tables): their files and their flags (mr_theme_flags) are
#           edited by hand, the script only places them in the lists
#   AFTER   the last theme written by hand in strings.xml: the names of the generated themes go right after it
# ---------------------------------------------------------------------------------------------------------------
ORDER = ['midnight', 'aurora', 'cyan', 'purple', 'pink', 'synthwave', 'aqua', 'snow', 'chrome', 'rose', 'glass', 'denim']
HAND = ('glass',)
AFTER = 'glass'
Family = collections.namedtuple('Family', 'name themes flags colors drawables intro')


def neon_flags(th):
    return ACCENT_KEYS | ACCENT_WIDE | GLOW | (SPECTRUM if th.spectrum else 0) | (FLAT_BAR if th.flat else 0)


def solid_flags(th):
    return (FLAT_BAR | ACCENT_KEYS | ACCENT_WIDE | (0 if th.mod_text else PLAIN_ACCENT_TEXT)
            | (0 if dark_ink(th.text) else TECH_PALETTE)     # a dark solid theme (Midnight Steel) has the "tech" palette
            | (TRANSLUCENT if th.clear else 0))


def gloss_flags(th):
    return solid_flags(th) | (TRANSLUCENT if th.clear else 0)


FAMILIES = [
    Family('solid', SOLID, solid_flags, solid_colors, solid_drawables,
           'Per theme: what the layouts point at, the roles read by name (MrTheme.color; the default of each role is in\n'
           '     mr_colors.xml), the preview bubble and the popup of variants (bubble, preview, popup) and the keys:\n'
           '     fill = the face of the key in that state, lip = the darker edge under it.'),
    Family('gloss', GLOSS, gloss_flags, gloss_colors, gloss_drawables,
           'Per theme: what the layouts point at, the roles read by name (MrTheme.color; the default of each role is in\n'
           '     mr_colors.xml), the preview bubble and the popup of variants (bubble, preview, popup) and the keys:\n'
           '     top/mid/bottom = the three colors of the face in that state, rim_top/rim_bottom = the light edge above\n'
           '     it and the dark one below, key_lip = the shadow under every key.'),
    Family('neon', NEON, neon_flags, neon_colors, neon_drawables,
           'Per theme: what the layouts point at, the roles read by name (MrTheme.color; the default of each role is in\n'
           '     mr_colors.xml), the preview bubble and the popup of variants (bubble) and the keys. In the names of the lit\n'
           '     shapes: halo1..3 = light outside the tube, from the cell edge inwards; top/bottom = face; in1..N = light\n'
           '     inside the tube, the widest band first; stroke = the tube.'),
]
THEMES = [(fam, th) for fam in FAMILIES for th in fam.themes]


# ---------------------------------------------------------------------------------------------------------------
# Files that are also edited by hand: only the lines of these themes are touched
# ---------------------------------------------------------------------------------------------------------------
def array_items(text, kind, name):
    """(start, end, [items]) of <kind name="name"> ... </kind> in text; start/end delimit the lines of the items."""
    m = re.search(r'<%s name="%s">\n(.*?)( *)</%s>' % (kind, name, kind), text, re.S)
    assert m, 'array %s not found' % name
    return m.start(1), m.end(1), re.findall(r'<item>(.*?)</item>', m.group(1))


def set_array(text, kind, name, items):
    start, end, old = array_items(text, kind, name)
    if items == old:
        return text
    return text[:start] + ''.join('        <item>%s</item>\n' % i for i in items) + text[end:]


def register_themes(text):
    """res/values/mr_themes.xml: the three lists in the order of ORDER (the flags of the themes written by hand are kept)."""
    _, _, tags = array_items(text, 'string-array', 'mr_theme_tags')
    _, _, flags = array_items(text, 'integer-array', 'mr_theme_flags')
    assert len(tags) == len(flags)
    known = {t[len('mr_'):]: f for t, f in zip(tags, flags)}
    for fam, th in THEMES:
        known[th.tag] = '0x%02x' % fam.flags(th)
    for tag in HAND:
        assert tag in known, 'the theme %s (written by hand) has no flags in mr_theme_flags' % tag
    text = set_array(text, 'array', 'mr_theme_layouts', ['@layout/input_mr_' + t for t in ORDER])
    text = set_array(text, 'string-array', 'mr_theme_tags', ['mr_' + t for t in ORDER])
    return set_array(text, 'integer-array', 'mr_theme_flags', [known[t] for t in ORDER])


def register_names(text):
    """res/values/arrays.xml: the list of the setting, names and values (the id of each theme) side by side."""
    text = set_array(text, 'string-array', 'keyboard_layout_modes', ['@string/layout_mr_' + t for t in ORDER])
    return set_array(text, 'string-array', 'keyboard_layout_modes_values', [str(i) for i in range(len(ORDER))])


def xml_text(s):
    return s.replace('&', '&amp;').replace('<', '&lt;').replace("'", "\\'")


def register_strings(text):
    """res/values/strings.xml: layout_mr_<t>, in the order of ORDER, right after the one written by hand (AFTER). The names are
    the same in every language (they are not translated), so only the default file has them."""
    after = 'layout_mr_' + AFTER
    for tag in ORDER:
        th = next((th for _, th in THEMES if th.tag == tag), None)
        if th is None:
            continue
        key = 'layout_mr_' + tag
        line = '    <string name="%s">%s</string>\n' % (key, xml_text(th.name))
        m = re.search(r' *<string name="%s">.*?</string>\n' % key, text)
        if m:
            text = text[:m.start()] + line + text[m.end():]
        else:
            m = re.search(r' *<string name="%s">.*?</string>\n' % after, text)
            assert m, 'no string %s to put %s after' % (after, key)
            text = text[:m.end()] + line + text[m.end():]
        after = key
    return text


def colors_file(fam):
    out = (XML +
           '<!-- Colors of the %s themes. GENERATED by docs/tools/make_themes.py from its table of themes: do not\n'
           '     edit this file, change the table (or the recipe) and run the script again.\n'
           '     %s -->\n'
           '<resources>\n' % (fam.name, fam.intro))
    for th in fam.themes:
        out += '\n    <!-- ===== %s ===== -->\n' % th.name
        for name, value in fam.colors(th).items():
            out += '    <color name="%s">%s</color>\n' % (name, value)
    return out + '</resources>\n'


# ---------------------------------------------------------------------------------------------------------------
def build(root):
    """path -> content of everything this script owns or touches (the touched ones are read from `root`)."""
    files = collections.OrderedDict()
    read = lambda p: open(os.path.join(root, p), encoding='utf-8').read()
    themes = [th for _, th in THEMES]
    assert len({th.tag for th in themes}) == len(themes), 'repeated tag'
    assert sorted(ORDER) == sorted([th.tag for th in themes] + list(HAND)), 'ORDER must have every theme of the tables and the ones written by hand, once'
    for fam, th in THEMES:
        assert re.match(r'^[a-z]+$', th.tag), th.tag
        assert not any(o.tag != th.tag and o.tag.startswith(th.tag) for o in themes), '%s starts another tag' % th.tag
        if fam.name == 'neon':
            assert not (th.spectrum and th.accent), '%s: a spectrum theme has one hue per key, so no accent hue' % th.tag
        for name, body in fam.drawables(th).items():
            files['res/drawable/' + name] = body
        for name, body in LAYOUTS.items():
            files['res/layout/' + name % th.tag] = body % {'t': th.tag}
    for fam in FAMILIES:
        files['res/values/mr_%s_colors.xml' % fam.name] = colors_file(fam)
    files['res/values/mr_themes.xml'] = register_themes(read('res/values/mr_themes.xml'))
    files['res/values/arrays.xml'] = register_names(read('res/values/arrays.xml'))
    files['res/values/strings.xml'] = register_strings(read('res/values/strings.xml'))
    return files


def main(argv):
    check = '--check' in argv
    args = [a for a in argv if not a.startswith('--')]
    root = args[0] if args else '.'
    if not os.path.isdir(os.path.join(root, 'res', 'values')):
        sys.exit('run at the root of the apktool project (res/values not found in %r)' % root)
    stale = []
    for path, body in build(root).items():
        full = os.path.join(root, path)
        old = open(full, encoding='utf-8').read() if os.path.exists(full) else None
        if old == body:
            continue
        stale.append(path)
        if not check:
            with open(full, 'w', encoding='utf-8', newline='\n') as f:
                f.write(body)
    count = ', '.join('%d %s' % (len(fam.themes), fam.name) for fam in FAMILIES)
    if check:
        if stale:
            print('Out of date (run python3 docs/tools/make_themes.py):')
            for p in stale:
                print('  ' + p)
            sys.exit(1)
        print('Generated themes up to date (%s)' % count)
    else:
        print('%d file(s) written, themes: %s' % (len(stale), count))


if __name__ == '__main__':
    main(sys.argv[1:])
