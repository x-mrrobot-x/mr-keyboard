#!/usr/bin/env python3
"""Confere se MrReset.KEYS tem todas as chaves de configuração das telas (res/xml/prefs*.xml).

Rode na raiz do projeto depois de mudar qualquer tela de configurações. Sai com 1 se faltar
alguma chave (o "Restaurar padrões" deixaria essa opção como está) ou se sobrar uma que nenhuma
tela oferece e que não está na lista de chaves antigas.
"""
import re, glob, sys

# chaves que só mostram informação ou abrem algo (não guardam valor)
SEM_VALOR = {'label_version', 'mr_hero', 'mr_reset', 'mr_privacy'}
# chaves que já saíram das telas e que o "Restaurar padrões" ainda limpa
ANTIGAS = {'pref_render_mode', 'pref_slide_keys_int', 'connectbot_tab_hack', 'pref_touch_pos',
           'pref_click_method', 'pref_top_row_scale', 'pref_caps_lock', 'pref_shift_lock_modifiers',
           'pref_chording_meta_key', 'settings_key'}
# chaves com tela fora dos XML (páginas montadas em código)
FORA_DE_XML = {'pref_sheet_return'}

tela = set()
for f in glob.glob('res/xml/prefs*.xml'):
    s = open(f, encoding='utf-8').read()
    for m in re.finditer(r'<(?!PreferenceCategory|PreferenceScreen)([\w.]+)\s([^>]*)>', s):
        k = re.search(r'android:key="([^"]+)"', m.group(2))
        if k and 'android:persistent="false"' not in m.group(2) and k.group(1) not in SEM_VALOR:
            tela.add(k.group(1))
src = open('docs/tools/java/src/com/mrkeyboard/app/MrReset.java', encoding='utf-8').read()
lista = set(re.findall(r'"([a-z_0-9]+)"', src[src.index('KEYS = {'):src.index('};')]))
faltam = sorted(tela - lista)
sobram = sorted(lista - tela - ANTIGAS - FORA_DE_XML)
faltam = sorted(set(faltam) - FORA_DE_XML)
print('chaves nas telas: %d | em MrReset.KEYS: %d' % (len(tela), len(lista)))
if faltam: print('FALTAM em MrReset.KEYS:', faltam)
if sobram: print('SOBRAM em MrReset.KEYS (sem tela e fora de ANTIGAS):', sobram)
sys.exit(1 if faltam or sobram else 0)
