#!/usr/bin/env python3
"""Checks that MrReset.KEYS has every settings key of the screens (res/xml/prefs*.xml).

Run at the project root after changing any settings screen. Exits with 1 if a key is
missing ("Restaurar padrões" (Restore defaults) would leave that option as it is) or if there is a leftover one that no
screen offers and that is not in the list of old keys.
"""
import re, glob, sys

# keys that only show information or open something (they store no value)
NO_VALUE = {'label_version', 'mr_hero', 'mr_reset', 'mr_privacy'}
# keys that already left the screens and that "Restaurar padrões" (Restore defaults) still clears
OLD = {'pref_render_mode', 'pref_slide_keys_int', 'connectbot_tab_hack', 'pref_touch_pos',
       'pref_click_method', 'pref_top_row_scale', 'pref_caps_lock', 'pref_shift_lock_modifiers',
       'pref_chording_meta_key', 'settings_key'}
# keys with a screen outside the XML (pages built in code)
# pref_ai_key: the screen row is not persistent (the value goes to "mr_ai", outside the backup, and MrReset
# clears both), but the key stays in MrReset.KEYS to clear any copy in the default preferences
OUTSIDE_XML = {'pref_sheet_return', 'pref_ai_key'}

screens = set()
for f in glob.glob('res/xml/prefs*.xml'):
    s = open(f, encoding='utf-8').read()
    for m in re.finditer(r'<(?!PreferenceCategory|PreferenceScreen)([\w.]+)\s([^>]*)>', s):
        k = re.search(r'android:key="([^"]+)"', m.group(2))
        if k and 'android:persistent="false"' not in m.group(2) and k.group(1) not in NO_VALUE:
            screens.add(k.group(1))
src = open('docs/tools/java/src/com/mrkeyboard/app/MrReset.java', encoding='utf-8').read()
listed = set(re.findall(r'"([a-z_0-9]+)"', src[src.index('KEYS = {'):src.index('};')]))
missing = sorted(screens - listed)
extra = sorted(listed - screens - OLD - OUTSIDE_XML)
missing = sorted(set(missing) - OUTSIDE_XML)
print('keys on the screens: %d | in MrReset.KEYS: %d' % (len(screens), len(listed)))
if missing: print('MISSING from MrReset.KEYS:', missing)
if extra: print('EXTRA in MrReset.KEYS (no screen and not in OLD):', extra)
sys.exit(1 if missing or extra else 0)
