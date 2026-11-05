# Model of the MrSugg state machine (translated from the smali) to check scenarios.
DELAY = 1.0
class M:
    def __init__(s):
        s.container = s.host = True
        s.has = s.pinned = s.hold = False
        s.baron = True
        s.deadline = None
        s.t = 0.0
        s.shown = 1          # 0 hidden, 1 tools, 2 suggestions (last applyMain)
        s.applies = 0
    # --- smali ---
    def available(s):
        if not (s.container and s.host): return False
        return True if s.has else s.hold
    def mode(s, on):
        if not on: return 0
        if s.available() and not s.pinned: return 2
        return 1
    def apply(s):
        s.shown = s.mode(s.baron); s.applies += 1
    def schedule(s): s.deadline = s.t + DELAY
    def cancel(s): s.hold = False; s.deadline = None
    def expire(s):
        if s.hold:
            s.hold = False; s.apply()
    def on_list(s, has):
        if has:
            s.cancel()
            if not s.has:
                s.has = True; s.apply()
            return
        if s.hold: s.schedule(); return
        if not s.has: return
        before = s.mode(s.baron)
        s.has = False; s.pinned = False
        if before == 2:
            s.hold = True; s.schedule()
        else:
            s.apply()
    def bar_key(s):
        if not s.baron: return False
        if hold := s.hold:
            s.cancel(); s.apply(); return True
        if s.available():
            s.pinned = not s.pinned; s.apply(); return True
        return False
    def unhost(s):
        s.cancel(); s.container = False; s.has = s.pinned = False; s.apply()
    # --- tempo ---
    def advance(s, dt):
        end = s.t + dt
        if s.deadline is not None and s.deadline <= end:
            s.t = s.deadline; s.deadline = None; s.expire()
        s.t = end

def check(name, cond):
    print(("OK   " if cond else "FAIL "), name)
    return cond

ok = True
# S1: typing with short pauses between words: never shows the tools
m = M(); m.on_list(True); ok &= check("S1a typing -> suggestions", m.shown == 2)
for w in range(5):
    m.advance(0.4); m.on_list(False)            # space
    ok &= check(f"S1b word {w}: after the space it stays on suggestions", m.shown == 2)
    m.advance(0.6); m.on_list(True)             # next word (0.6 s later)
    ok &= check(f"S1c word {w}: no flicker", m.shown == 2)
# S2: stopped typing: tools only after 1 s
m = M(); m.on_list(True); m.advance(0.1); m.on_list(False)
m.advance(0.9); ok &= check("S2a 0.9 s later still suggestions", m.shown == 2)
m.advance(0.2); ok &= check("S2b 1.1 s later tools", m.shown == 1)
# S3: key during the wait -> tools right away; typing brings them back
m = M(); m.on_list(True); m.on_list(False); m.advance(0.3)
ok &= check("S3a key consumed", m.bar_key() is True and m.shown == 1)
m.advance(2); ok &= check("S3b stays on tools", m.shown == 1)
m.on_list(True); ok &= check("S3c typing -> suggestions right away", m.shown == 2)
# S4: pinned on tools during the word
m = M(); m.on_list(True); m.bar_key(); ok &= check("S4a pinned -> tools", m.shown == 1)
m.on_list(True); m.on_list(True); ok &= check("S4b more letters: stays", m.shown == 1)
m.on_list(False); ok &= check("S4c end of the word: tools, no wait", m.shown == 1 and not m.hold and not m.pinned)
m.on_list(True); ok &= check("S4d next word goes back to suggestions", m.shown == 2)
# S5: bar hidden: never shows
m = M(); m.baron = False; m.apply(); m.on_list(True); m.on_list(False)
ok &= check("S5 bar hidden -> 0 and no wait", m.shown == 0 and not m.hold)
# S6: unhost during the wait
m = M(); m.on_list(True); m.on_list(False); m.unhost()
ok &= check("S6 unhost cancels the wait", not m.hold and m.deadline is None and m.shown == 1)
m.advance(2); ok &= check("S6b nothing fires afterwards", m.shown == 1)
# S7: repeated empty lists during the wait restart the clock
m = M(); m.on_list(True); m.on_list(False); m.advance(0.7); m.on_list(False); m.advance(0.7)
ok &= check("S7a restarted: 1.4 s after the 1st one, still suggestions", m.shown == 2)
m.advance(0.4); ok &= check("S7b 1.1 s after the last one: tools", m.shown == 1)
# S8: without suggestions, the key hides/shows the row (not consumed)
m = M(); ok &= check("S8 key without suggestions not consumed", m.bar_key() is False)
# S9: wait expired, user continues; tools -> suggestions immediately
m = M(); m.on_list(True); m.on_list(False); m.advance(1.2); m.on_list(True)
ok &= check("S9 tools -> suggestions immediately", m.shown == 2)
print("\nALL OK" if ok else "\nFAILURES")
