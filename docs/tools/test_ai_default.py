#!/usr/bin/env python3
"""Tests that Google Gemini is the service of the AI settings until the person changes it (v2.0.0 work). Static checks on the files.

Run it from the project root:  python3 -I docs/tools/test_ai_default.py

  - res/xml/prefs_ai.xml: the provider, the address and the model start as Gemini;
  - MrAi (PROVIDER_DEF, ENDPOINT_DEF, MODEL_DEF) has the same three values, so a phone that never opened the settings sends to the same service that the
    settings screen shows;
  - the ready-made provider "gemini" of MrAiPrefs uses those values, and the one of "openai" has its own (it does not follow the default);
  - the provider list still offers every provider (the default is one of the values of the list);
  - the key is still needed (a default service does not make the feature work without one), and "Restore defaults" still resets the three keys.
"""
import os
import re
import sys

ROOT = os.getcwd()
ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


def read(*p):
    with open(os.path.join(ROOT, *p), encoding="utf-8") as f:
        return f.read()


xml = read("res", "xml", "prefs_ai.xml")
ai = read("docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrAi.java")
prefs = read("docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrAiPrefs.java")
reset = read("docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrReset.java")
arrays = read("res", "values", "arrays.xml")


def xml_default(key):
    m = re.search(r'android:key="%s"[^>]*android:defaultValue="([^"]*)"' % re.escape(key), xml)
    return m.group(1) if m else None


def const(name):
    m = re.search(r'static final String %s = "([^"]*)";' % name, ai)
    return m.group(1) if m else None


GEMINI_EP = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions"
GEMINI_MODEL = "gemini-3.5-flash-lite"

check("the settings screen starts on the provider Gemini", xml_default("pref_ai_provider") == "gemini", xml_default("pref_ai_provider"))
check("... with the address of Gemini", xml_default("pref_ai_endpoint") == GEMINI_EP, xml_default("pref_ai_endpoint"))
check("... and its model", xml_default("pref_ai_model") == GEMINI_MODEL, xml_default("pref_ai_model"))
check("MrAi has the same provider, address and model as what the screen shows",
      const("PROVIDER_DEF") == xml_default("pref_ai_provider") and const("ENDPOINT_DEF") == xml_default("pref_ai_endpoint") and const("MODEL_DEF") == xml_default("pref_ai_model"),
      (const("PROVIDER_DEF"), const("ENDPOINT_DEF"), const("MODEL_DEF")))
check("the provider read by the migration of old models is the default one", 'prefs.getString(MrAi.KEY_PROVIDER, MrAi.PROVIDER_DEF)' in prefs)
check("the ready-made provider Gemini fills in the default values", re.search(r'"gemini"\.equals\(provider\)\) \{\s*endpoint = MrAi\.ENDPOINT_DEF;\s*model = MrAi\.MODEL_DEF;', prefs) is not None)
check("the ready-made provider OpenAI has its own values and does not follow the default",
      re.search(r'"openai"\.equals\(provider\)\) \{\s*endpoint = MrAi\.ENDPOINT_OPENAI;\s*model = MrAi\.MODEL_OPENAI;', prefs) is not None
      and const("ENDPOINT_OPENAI") == "https://api.openai.com/v1/chat/completions" and const("MODEL_OPENAI") == "gpt-6.1-terra")
check("the old OpenAI model is moved to the OpenAI one, not to the default", '"gpt-4o-mini".equals(model)) replacement = MrAi.MODEL_OPENAI;' in prefs)
check("the address and the model are read with the default (a phone that never opened the settings)",
      "cfg(c, KEY_ENDPOINT, ENDPOINT_DEF)" in ai and "cfg(c, KEY_MODEL, MODEL_DEF)" in ai)
m = re.search(r'<string-array name="mr_ai_provider_values">(.*?)</string-array>', arrays, re.S)
values = re.findall(r"<item>([^<]*)</item>", m.group(1)) if m else []
check("the list of providers still has OpenAI, Groq, OpenRouter, Gemini and custom, and the default is one of them",
      values == ["openai", "groq", "openrouter", "gemini", "custom"] and const("PROVIDER_DEF") in values, values)
check("a key is still required (the default does not call the service without one)", "mr_ai_no_key" in ai and "return apiKey(c).length() > 0;" in ai)
check("\"Restore defaults\" still resets the provider, the address and the model", all('"%s"' % k in reset for k in ("pref_ai_provider", "pref_ai_endpoint", "pref_ai_model")))
check("no other file sets another default address or model (the only ones are the Gemini and OpenAI values of MrAi and the presets of MrAiPrefs)",
      "api.openai.com" not in xml and "gpt-6.1-terra" not in xml)

print()
print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
