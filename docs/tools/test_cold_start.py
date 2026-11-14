#!/usr/bin/env python3
"""Tests of the cold start of the keyboard (stage 7 of docs/plan-performance.md): what no longer runs when the service is built.

Run it from the project root:  python3 -I docs/tools/test_cold_start.py

Two pieces of work were done for every new process of the keyboard, before the first key, and almost nobody uses them:
  1. `LatinIME.<init>` made the compose buffer and the dead-key buffer, and with them ran the static initializer of
     `ComposeSequence` (a table of 883 compose sequences, each one formatted) and the one of `DeadAccentSequence`. Only the compose key
     and a dead key (a combining mark typed) use them. Now `mrComposeBuffer` / `mrDeadBuffer` make them the first time they are needed.
  2. `LatinIME.onCreate` asked the package manager twice (`PluginManager.getPluginDictionaries`: the Hacker's Keyboard and the
     AnySoftKeyboard dictionary apps) although the downloaded packs are the normal source of the dictionaries. Now
     `PluginManager.getDictionary` looks the apps up, once, only when a language has no pack (`ensurePlugins`); a change of the
     installed packages (`onReceive`) only marks what was looked up as stale.
The test runs the REAL smali in the mini Dalvik interpreter (dalvik_mini.py) with fake classes that count what is made and asked, and reads
the smali for the places where the work used to be. The time it saves is the phone's to say (the line "Start the keyboard" of the meter,
which is timed from `LatinIME.<init>` to the end of `onCreate`); this test counts that none of it runs at the start any more and that
every use still finds what it needs.
"""
import os
import re
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
IME = "Lcom/mrkeyboard/app/LatinIME;"
PM = "Lcom/mrkeyboard/app/PluginManager;"
CS = "Lcom/mrkeyboard/app/ComposeSequence;"
DAS = "Lcom/mrkeyboard/app/DeadAccentSequence;"

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


def read(name):
    return open(os.path.join(APP, name), encoding="utf-8").read()


def body(src, header):
    """Text of the method whose line starts with `.method` and contains `header`."""
    for chunk in src.split("\n.method ")[1:]:
        if header in chunk.split("\n", 1)[0]:
            return chunk.split("\n.end method")[0]
    raise KeyError(header)


def code(text):
    return [l.strip() for l in text.split("\n") if l.strip() and not l.strip().startswith(("#", ".line", ".locals"))]


LATIN = read("LatinIME.smali")

# ---------------------------------------------------------------- the smali: where the work used to be
init = body(LATIN, "constructor <init>()V")
on_create = body(LATIN, "public onCreate()V")
check("LatinIME.<init> makes no compose buffer and no dead-key buffer (no ComposeSequence, no DeadAccentSequence)",
      "ComposeSequence" not in init and "DeadAccentSequence" not in init)
check("LatinIME.onCreate does not look up the dictionary apps (no getPluginDictionaries)", "getPluginDictionaries" not in on_create)
check("LatinIME.onCreate still makes the receiver that follows the installed packages (PluginManager)",
      "new-instance v3, " + PM in on_create and "registerReceiver" in on_create)

makers = sorted(m.split("\n", 1)[0].split()[-1] for m in LATIN.split("\n.method ")[1:]
                if "new-instance" in m.split("\n.end method")[0] and re.search(r"new-instance \w+, L[^;]*(ComposeSequence|DeadAccentSequence);", m.split("\n.end method")[0]))
check("only mrComposeBuffer and mrDeadBuffer make the two buffers", makers == ["mrComposeBuffer()Lcom/mrkeyboard/app/ComposeSequence;", "mrDeadBuffer()Lcom/mrkeyboard/app/ComposeSequence;"], makers)

users = sorted(m.split("\n", 1)[0].split()[-1] for m in LATIN.split("\n.method ")[1:]
               if re.search(r"->m(ComposeBuffer|DeadAccentBuffer):", m.split("\n.end method")[0]))
check("the two fields are read or written only by processMultiKey and the two makers", users == [
    "mrComposeBuffer()Lcom/mrkeyboard/app/ComposeSequence;", "mrDeadBuffer()Lcom/mrkeyboard/app/ComposeSequence;", "processMultiKey(I)Z"], users)

pmk = code(body(LATIN, "private processMultiKey(I)Z"))
i_get = next(i for i, l in enumerate(pmk) if "->mDeadAccentBuffer:" in l)
check("processMultiKey (every key) tests the dead-key buffer for null before it reads it", pmk[i_get + 1].startswith("if-eqz v0, ") and "composeBuffer" in pmk[i_get + 2], pmk[i_get:i_get + 3])

key_orig = body(LATIN, "private onKeyOrig(I[III)V")
check("the dead key and the compose key (onKeyOrig) go through the makers, not through the fields",
      "->mrDeadBuffer()" in key_orig and "->mrComposeBuffer()" in key_orig and "->mDeadAccentBuffer" not in key_orig and "->mComposeBuffer" not in key_orig)

pmgr = read("PluginManager.smali")
get_dict = code(body(pmgr, "getDictionary(Landroid/content/Context;Ljava/lang/String;)"))
i_pack = next(i for i, l in enumerate(get_dict) if "MrPacks;->openDictionary" in l)
i_ens = next(i for i, l in enumerate(get_dict) if "->ensurePlugins(" in l)
i_map = next(i for i, l in enumerate(get_dict) if "->mPluginDicts:" in l)
check("getDictionary asks for the downloaded pack first, looks the dictionary apps up (ensurePlugins) only after it found none, and reads the map after",
      i_pack < i_ens < i_map and any(l.startswith("if-eqz v0, :cond_mr_no_pack") for l in get_dict[i_pack:i_ens]), (i_pack, i_ens, i_map))
callers = sorted(m.split("\n", 1)[0].split()[-1] for m in pmgr.split("\n.method ")[1:] if "->getPluginDictionaries(" in m.split("\n.end method")[0])
check("getPluginDictionaries is called only by ensurePlugins (nothing looks the apps up at the start or when the packages change)",
      callers == ["ensurePlugins(Landroid/content/Context;)V"], callers)
others = [f for f in os.listdir(APP) if f.endswith(".smali") and f != "PluginManager.smali" and "getPluginDictionaries" in read(f)]
check("no other class calls it either", not others, others)
check("ensurePlugins is synchronized and the flag is volatile (the dictionaries can be asked for from a thread other than the main one)",
      ".method static declared-synchronized ensurePlugins(" in pmgr and ".field private static volatile sPluginsLoaded:Z" in pmgr)


# ---------------------------------------------------------------- LatinIME: the buffers, in the interpreter
class BufHost:
    def __init__(self):
        self.made = []          # classes made, in order
        self.executed = []      # (class, code)
        self.cleared = 0
        self.returns = {}       # what execute answers

    def sget(self, cls, name):
        raise AssertionError("static: %s.%s" % (cls, name))

    def new_instance(self, cls):
        if cls in (CS, DAS):
            self.made.append(cls)
            return dm.Obj(cls, composeBuffer=dm.Obj("Ljava/lang/StringBuilder;", n=0))
        raise AssertionError(cls)

    def instance_of(self, obj, cls):
        raise AssertionError(cls)

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        name = mem.split("(")[0]
        if name == "<init>" and cls in (CS, DAS):
            return None
        if cls in (CS, DAS) and name == "execute":
            self.executed.append((args[0].cls, args[1]))
            return self.returns.get(args[0].cls, 1)
        if cls in (CS, DAS) and name == "clear":
            self.cleared += 1
            args[0].f["composeBuffer"].f["n"] = 0
            return None
        if cls == "Ljava/lang/StringBuilder;" and name == "length":
            return args[0].f["n"]
        raise AssertionError(target)


METHODS = dm.parse_methods(os.path.join(APP, "LatinIME.smali"))


def ime(host, compose_mode=0):
    vm = dm.VM(IME, METHODS, host)
    this = dm.Obj(IME, mComposeBuffer=None, mDeadAccentBuffer=None, mComposeMode=compose_mode)
    return vm, this


MPK = "processMultiKey(I)Z"
h = BufHost()
vm, this = ime(h)
r = [vm.run(MPK, [this, k]) for k in (97, 32, 10, -5, 44)]
check("keys typed with no compose key and no dead key: processMultiKey answers 0 and makes nothing", r == [0] * 5 and h.made == [], (r, h.made))

h = BufHost()
vm, this = ime(h)
b1 = vm.run("mrComposeBuffer()Lcom/mrkeyboard/app/ComposeSequence;", [this])
b2 = vm.run("mrComposeBuffer()Lcom/mrkeyboard/app/ComposeSequence;", [this])
check("mrComposeBuffer makes a ComposeSequence once and gives the same one afterwards", h.made == [CS] and b1 is b2 and this.f["mComposeBuffer"] is b1, h.made)
d1 = vm.run("mrDeadBuffer()Lcom/mrkeyboard/app/ComposeSequence;", [this])
d2 = vm.run("mrDeadBuffer()Lcom/mrkeyboard/app/ComposeSequence;", [this])
check("mrDeadBuffer makes a DeadAccentSequence once and gives the same one afterwards", h.made == [CS, DAS] and d1 is d2 and this.f["mDeadAccentBuffer"] is d1, h.made)

# the compose key was pressed (mComposeMode on, the buffer made by the key): the next key goes to the buffer
h = BufHost()
vm, this = ime(h, compose_mode=0)
this.f["mComposeMode"] = 1
h.returns[CS] = 1
r = vm.run(MPK, [this, ord("'")])
check("compose mode on: the key goes to the compose buffer, which is made if it was not (the key that turns it on makes it too), and the key is taken",
      r == 1 and h.made == [CS] and h.executed == [(CS, ord("'"))] and this.f["mComposeMode"] == 1, (r, h.made, h.executed))
h.returns[CS] = 0
r = vm.run(MPK, [this, ord("a")])
check("... the buffer ends compose mode when it says so; it is not made again", r == 1 and h.made == [CS] and this.f["mComposeMode"] == 0, (r, h.made, this.f["mComposeMode"]))
r = vm.run(MPK, [this, ord("b")])
check("... and the next key is an ordinary one again", r == 0 and h.made == [CS], (r, h.made))

# a dead key started a sequence (the buffer has characters): the key goes to it and it is cleared
h = BufHost()
vm, this = ime(h)
dead = vm.run("mrDeadBuffer()Lcom/mrkeyboard/app/ComposeSequence;", [this])
dead.f["composeBuffer"].f["n"] = 1
r = vm.run(MPK, [this, ord("a")])
check("a dead-key sequence pending: the next key goes to it and the buffer is cleared", r == 1 and h.executed == [(DAS, ord("a"))] and h.cleared == 1, (r, h.executed, h.cleared))
r = vm.run(MPK, [this, ord("b")])
check("... then keys are ordinary again and nothing is made", r == 0 and h.made == [DAS], (r, h.made))


# ---------------------------------------------------------------- PluginManager: the look-up, in the interpreter
class Map:
    pass


class PHost:
    def __init__(self):
        self.queries = []
        self.pack = None
        self.toggles = []
        self.dict_calls = []
        self.spec = dm.Obj("Lcom/mrkeyboard/app/PluginManager$DictPluginSpec;", dict="plugin-dictionary")

    def sget(self, cls, name):
        raise AssertionError("static: %s.%s" % (cls, name))

    def new_instance(self, cls):
        if cls in ("Landroid/content/Intent;", "Ljava/lang/StringBuilder;"):
            return dm.Obj(cls, parts=[])
        raise AssertionError(cls)

    def instance_of(self, obj, cls):
        raise AssertionError(cls)

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        name = mem.split("(")[0]
        if cls == "Landroid/content/Intent;":
            return None
        if cls == "Landroid/content/Context;" and name == "getPackageManager":
            return dm.Obj("Landroid/content/pm/PackageManager;")
        if cls == "Landroid/content/pm/PackageManager;" and name in ("queryBroadcastReceivers", "queryIntentActivities"):
            self.queries.append(name)
            return dm.Obj("Ljava/util/List;")
        if cls == "Ljava/util/List;" and name == "iterator":
            return dm.Obj("Ljava/util/Iterator;")
        if cls == "Ljava/util/Iterator;" and name == "hasNext":
            return 0
        if cls == "Ljava/util/Map;":
            d = args[0].f["d"]
            if name == "get":
                return d.get(args[1])
            if name == "put":
                d[args[1]] = args[2]
                return None
            if name == "clear":
                d.clear()
                return None
        if cls == "Lcom/mrkeyboard/app/MrPacks;" and name == "openDictionary":
            return self.pack
        if cls == "Landroid/util/Log;":
            return 0
        if cls == "Ljava/lang/String;" and name == "substring":
            return args[0][args[1]:args[2]]
        if cls == "Ljava/lang/StringBuilder;":
            return args[0] if name in ("append",) else "".join(map(str, args[0].f["parts"]))
        if cls == "Lcom/mrkeyboard/app/LatinIME;" and name == "toggleLanguage":
            self.toggles.append((args[1], args[2]))
            return None
        if cls == "Lcom/mrkeyboard/app/PluginManager$DictPluginSpec;" and name == "getDict":
            self.dict_calls.append(args[0])
            return self.spec.f["dict"]
        if cls == "Lcom/mrkeyboard/app/BinaryDictionary;" and name == "getSize":
            return 7
        raise AssertionError(target)


PMETHODS = dm.parse_methods(os.path.join(APP, "PluginManager.smali"))


def plugin_world():
    host = PHost()
    vm = dm.VM(PM, PMETHODS, host)
    vm.statics.update(TAG="PCKeyboard", SOFTKEYBOARD_INTENT_DICT="a", HK_INTENT_DICT="b", sPluginsLoaded=0)
    vm.statics["mPluginDicts"] = dm.Obj("Ljava/util/Map;", d={})
    return host, vm


GET = "getDictionary(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/BinaryDictionary;"
ctx = dm.Obj("Landroid/content/Context;")

host, vm = plugin_world()
host.pack = dm.Obj("Lcom/mrkeyboard/app/BinaryDictionary;")
r = vm.run(GET, [ctx, "pt_BR"])
check("a language with a downloaded pack: its dictionary is returned and the package manager is not asked", r is host.pack and host.queries == [], host.queries)

host, vm = plugin_world()
check("before the first language without a pack nothing was looked up", host.queries == [] and vm.statics["sPluginsLoaded"] == 0)
r = vm.run(GET, [ctx, "xx_YY"])
check("a language with no pack: the two look-ups (Hacker's Keyboard and AnySoftKeyboard) happen, here, and there is no dictionary",
      not r and sorted(host.queries) == ["queryBroadcastReceivers", "queryIntentActivities"] and vm.statics["sPluginsLoaded"] == 1, host.queries)
r = vm.run(GET, [ctx, "zz_ZZ"])
check("the next language without a pack does not look them up again", not r and len(host.queries) == 2, host.queries)

# the dictionary of a plugin that was found: after the look-up the map answers, with no new query
vm.statics["mPluginDicts"].f["d"]["xx"] = host.spec
r = vm.run(GET, [ctx, "xx_YY"])
check("a dictionary app found by the look-up still gives its dictionary (the map is read as before), with no new query",
      r == "plugin-dictionary" and len(host.queries) == 2 and len(host.dict_calls) == 1, (r, host.queries))

# the installed packages changed
recv = dm.Obj(PM, mIME=dm.Obj(IME))
vm.run("onReceive(Landroid/content/Context;Landroid/content/Intent;)V", [recv, ctx, dm.Obj("Landroid/content/Intent;")])
check("the installed packages changed: nothing is looked up at once, the language is asked for again (toggleLanguage) and what was looked up is marked stale",
      len(host.queries) == 2 and vm.statics["sPluginsLoaded"] == 0 and host.toggles == [(1, 1)], (host.queries, host.toggles))
r = vm.run(GET, [ctx, "xx_YY"])
check("... the next language without a pack looks the apps up again (the old map was cleared before it was filled)",
      len(host.queries) == 4 and vm.statics["sPluginsLoaded"] == 1 and not r, (host.queries, r))
host.pack = dm.Obj("Lcom/mrkeyboard/app/BinaryDictionary;")
vm.run("onReceive(Landroid/content/Context;Landroid/content/Intent;)V", [recv, ctx, dm.Obj("Landroid/content/Intent;")])
r = vm.run(GET, [ctx, "pt_BR"])
check("the packages changed and the language has a pack: no look-up at all", r is host.pack and len(host.queries) == 4, host.queries)

# the method that does the look-up is unchanged
host, vm = plugin_world()
vm.statics["mPluginDicts"].f["d"]["old"] = host.spec
vm.run("getPluginDictionaries(Landroid/content/Context;)V", [ctx])
check("getPluginDictionaries: clears the map, makes the two queries and marks the look-up done",
      vm.statics["mPluginDicts"].f["d"] == {} and sorted(host.queries) == ["queryBroadcastReceivers", "queryIntentActivities"] and vm.statics["sPluginsLoaded"] == 1)

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
