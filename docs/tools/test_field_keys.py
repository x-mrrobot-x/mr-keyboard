#!/usr/bin/env python3
"""Tests the keys with a modifier (Ctrl+A, Shift+arrows, Ctrl+Backspace...) in the fields of the toolbar (the translator and the emoji search), with the REAL
smali of MrTools.sendEvent and of LatinIME.sendKeyDown / sendKeyUp in the mini Dalvik interpreter (dalvik_mini.py).

Run it from the project root:  python3 -I docs/tools/test_field_keys.py

LatinIME sends every key with a modifier as a KeyEvent through the InputConnection it is typing into. For the field of a tool of the toolbar that
connection is the one of the EditText itself (MrTools.sRedirect), which hands the event to the window of the keyboard, and that window does not take key
events: nothing happened. The plain keys already went straight to the field (MrTools.sendKey). Now sendKeyDown/sendKeyUp ask MrTools.sendEvent first:
  - the target is the redirect and a field is set: the event goes to the field with its meta state, and when the field does not use a key that has a
    modifier (and the key is not a modifier itself) its shortcut is tried, which is where a TextView keeps Ctrl+A / C / X / V / Z; true is returned;
  - any other target (the InputConnection of the app, no redirect, no field): false, and the event goes through the connection as before.
"""
import os
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
TOOLS = "Lcom/mrkeyboard/app/MrTools;"
IME = "Lcom/mrkeyboard/app/LatinIME;"
KEYEVENT = "Landroid/view/KeyEvent;"

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


CTRL_ON, CTRL_LEFT_ON, SHIFT_ON, SHIFT_LEFT_ON = 0x1000, 0x2000, 0x1, 0x40
KEY_A, KEY_DEL, KEY_RIGHT, KEY_CTRL_LEFT, KEY_SHIFT_LEFT = 29, 67, 22, 113, 59
DOWN, UP = 0, 1
MODIFIER_KEYS = {57, 58, 59, 60, 113, 114, 117, 118, 63, 78}      # alt, shift, ctrl, meta, sym, function (KeyEvent.isModifierKey)


def event(action, code, meta=0):
    return dm.Obj(KEYEVENT, action=action, code=code, meta=meta)


class Host:
    def __init__(self):
        self.field = dm.Obj("Landroid/widget/EditText;")
        self.field_takes = False         # View.dispatchKeyEvent of the field: true when the field uses the key itself
        self.log = []                    # ("key", action, code, meta) / ("shortcut", ...) at the field; ("ic", ...) at an InputConnection
        self.created = []

    def sget(self, cls, name):
        raise AssertionError("static %s.%s" % (cls, name))

    def new_instance(self, cls):
        assert cls == KEYEVENT, cls
        ev = dm.Obj(KEYEVENT)
        self.created.append(ev)
        return ev

    def instance_of(self, obj, cls):
        raise AssertionError(cls)

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        name = mem.split("(")[0]
        if cls == KEYEVENT:
            if name == "<init>":                       # KeyEvent(long, long, int action, int code, int repeat, int meta)
                ev, action, code, meta = args[0], args[3], args[4], args[6]
                ev.f.update(action=action, code=code, meta=meta)
                return None
            if name == "getAction":
                return args[0].f["action"]
            if name == "getKeyCode":
                return args[0].f["code"]
            if name == "getMetaState":
                return args[0].f["meta"]
            if name == "isModifierKey":
                return 1 if args[0] in MODIFIER_KEYS else 0
            if name == "metaStateHasNoModifiers":
                return 1 if args[0] & (CTRL_ON | 0x2 | 0x10 | SHIFT_ON | 0x200 | 0x8) == 0 else 0
        if cls == "Landroid/view/View;" and name == "dispatchKeyEvent":
            self.log.append(("key", args[1].f["action"], args[1].f["code"], args[1].f["meta"]))
            return 1 if self.field_takes else 0
        if cls == "Landroid/view/View;" and name == "dispatchKeyShortcutEvent":
            self.log.append(("shortcut", args[1].f["action"], args[1].f["code"], args[1].f["meta"]))
            return 1
        if cls == "Ljava/lang/System;" and name == "currentTimeMillis":
            return 1000
        if cls == "Landroid/view/inputmethod/InputConnection;" and name == "sendKeyEvent":
            self.log.append(("ic", args[1].f["action"], args[1].f["code"], args[1].f["meta"]))
            return 1
        raise AssertionError("invoke " + target)


def tools(host, redirect=None, field="field"):
    vm = dm.VM(TOOLS, dm.parse_methods(os.path.join(APP, "MrTools.smali")), host)
    vm.statics["sRedirect"] = redirect
    vm.statics["sField"] = host.field if field == "field" else None
    return vm


# ---------------------------------------------------------------- MrTools.sendEvent
IC_FIELD = dm.Obj("Landroid/view/inputmethod/InputConnection;", who="field")
IC_APP = dm.Obj("Landroid/view/inputmethod/InputConnection;", who="app")
SEND = "sendEvent(Landroid/view/inputmethod/InputConnection;Landroid/view/KeyEvent;)Z"

host = Host()
vm = tools(host, redirect=IC_FIELD)
r = vm.run(SEND, [IC_FIELD, event(DOWN, KEY_A, CTRL_ON | CTRL_LEFT_ON)])
check("Ctrl+A for the field: delivered", r == 1, r)
check("... the field gets the key with its meta state, then the shortcut (the field did not use the key)",
      host.log == [("key", DOWN, KEY_A, CTRL_ON | CTRL_LEFT_ON), ("shortcut", DOWN, KEY_A, CTRL_ON | CTRL_LEFT_ON)], host.log)

host = Host()
host.field_takes = True
vm = tools(host, redirect=IC_FIELD)
r = vm.run(SEND, [IC_FIELD, event(DOWN, KEY_RIGHT, SHIFT_ON | SHIFT_LEFT_ON)])
check("Shift+Right for the field: delivered, the field uses it (it extends the selection), no shortcut is tried",
      r == 1 and host.log == [("key", DOWN, KEY_RIGHT, SHIFT_ON | SHIFT_LEFT_ON)], (r, host.log))

host = Host()
vm = tools(host, redirect=IC_FIELD)
vm.run(SEND, [IC_FIELD, event(UP, KEY_A, CTRL_ON)])
check("the key going up: to the field, no shortcut", host.log == [("key", UP, KEY_A, CTRL_ON)], host.log)

for code, label in ((KEY_CTRL_LEFT, "Ctrl itself"), (KEY_SHIFT_LEFT, "Shift itself")):
    host = Host()
    vm = tools(host, redirect=IC_FIELD)
    r = vm.run(SEND, [IC_FIELD, event(DOWN, code, CTRL_ON | SHIFT_ON)])
    check("%s going down: to the field, no shortcut" % label, r == 1 and host.log == [("key", DOWN, code, CTRL_ON | SHIFT_ON)], (r, host.log))

host = Host()
vm = tools(host, redirect=IC_FIELD)
r = vm.run(SEND, [IC_FIELD, event(DOWN, KEY_DEL, 0)])
check("a key with no modifier the field does not use: to the field, no shortcut", r == 1 and host.log == [("key", DOWN, KEY_DEL, 0)], (r, host.log))

host = Host()
vm = tools(host, redirect=IC_FIELD)
r = vm.run(SEND, [IC_APP, event(DOWN, KEY_A, CTRL_ON)])
check("the target is the InputConnection of the app, not the redirect: not taken (false), nothing sent to the field", r == 0 and host.log == [], (r, host.log))

host = Host()
vm = tools(host, redirect=None)
r = vm.run(SEND, [IC_APP, event(DOWN, KEY_A, CTRL_ON)])
check("no redirect (a field of the app is the target): not taken", r == 0 and host.log == [], (r, host.log))
r = vm.run(SEND, [None, event(DOWN, KEY_A, CTRL_ON)])
check("no redirect and no connection: not taken", r == 0 and host.log == [], (r, host.log))

host = Host()
vm = tools(host, redirect=IC_FIELD, field=None)
r = vm.run(SEND, [IC_FIELD, event(DOWN, KEY_A, CTRL_ON)])
check("a redirect with no field: not taken, the connection is used as before", r == 0 and host.log == [], (r, host.log))

# ---------------------------------------------------------------- LatinIME.sendKeyDown / sendKeyUp
IME_METHODS = dm.parse_methods(os.path.join(APP, "LatinIME.smali"))


class ImeHost(Host):
    def __init__(self, tools_vm):
        super().__init__()
        self.tools_vm = tools_vm

    def invoke(self, vm, op, target, args):
        if target.startswith(TOOLS + "->sendEvent"):
            return self.tools_vm.run(target.split("->")[1], args)
        return super().invoke(vm, op, target, args)


def ime_send(method, ic, redirect, code, meta):
    host = ImeHost(None)
    host.tools_vm = tools(host, redirect=redirect)
    ime = dm.VM(IME, IME_METHODS, host)
    this = dm.Obj(IME)
    ime.run(method, [this, ic, code, meta])
    return host.log


for method, action, name in (("sendKeyDown(Landroid/view/inputmethod/InputConnection;II)V", DOWN, "sendKeyDown"),
                             ("sendKeyUp(Landroid/view/inputmethod/InputConnection;II)V", UP, "sendKeyUp")):
    log = ime_send(method, IC_FIELD, IC_FIELD, KEY_A, CTRL_ON)
    check("%s into the field of the toolbar: the field gets the event with its meta state, the connection none" % name,
          log[0] == ("key", action, KEY_A, CTRL_ON) and not any(e[0] == "ic" for e in log), log)
    log = ime_send(method, IC_APP, IC_FIELD, KEY_A, CTRL_ON)
    check("%s into the app while a field of the toolbar is open (the app's own connection): through the connection, as before" % name,
          log == [("ic", action, KEY_A, CTRL_ON)], log)
    log = ime_send(method, IC_APP, None, KEY_A, CTRL_ON)
    check("%s with no tool open: through the connection, as before" % name, log == [("ic", action, KEY_A, CTRL_ON)], log)
    log = ime_send(method, None, IC_FIELD, KEY_A, CTRL_ON)
    check("%s with no connection: nothing is sent" % name, log == [], log)

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
