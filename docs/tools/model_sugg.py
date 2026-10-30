# Modelo da maquina de estados de MrSugg (traduzido do smali) para checar cenarios.
DELAY = 1.0
class M:
    def __init__(s):
        s.container = s.host = True
        s.has = s.pinned = s.hold = False
        s.baron = True
        s.deadline = None
        s.t = 0.0
        s.shown = 1          # 0 oculto, 1 ferramentas, 2 sugestoes (ultimo applyMain)
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
    print(("OK   " if cond else "FALHA"), name)
    return cond

ok = True
# S1: digitando com pausas curtas entre palavras: nunca mostra ferramentas
m = M(); m.on_list(True); ok &= check("S1a digitando -> sugestoes", m.shown == 2)
for w in range(5):
    m.advance(0.4); m.on_list(False)            # espaco
    ok &= check(f"S1b palavra {w}: apos espaco continua sugestoes", m.shown == 2)
    m.advance(0.6); m.on_list(True)             # proxima palavra (0,6 s depois)
    ok &= check(f"S1c palavra {w}: sem piscar", m.shown == 2)
# S2: parou de digitar: ferramentas so apos 1 s
m = M(); m.on_list(True); m.advance(0.1); m.on_list(False)
m.advance(0.9); ok &= check("S2a 0,9 s depois ainda sugestoes", m.shown == 2)
m.advance(0.2); ok &= check("S2b 1,1 s depois ferramentas", m.shown == 1)
# S3: tecla durante a espera -> ferramentas na hora; digitar volta
m = M(); m.on_list(True); m.on_list(False); m.advance(0.3)
ok &= check("S3a tecla consumida", m.bar_key() is True and m.shown == 1)
m.advance(2); ok &= check("S3b continua ferramentas", m.shown == 1)
m.on_list(True); ok &= check("S3c digitar -> sugestoes na hora", m.shown == 2)
# S4: fixado em ferramentas durante a palavra
m = M(); m.on_list(True); m.bar_key(); ok &= check("S4a fixado -> ferramentas", m.shown == 1)
m.on_list(True); m.on_list(True); ok &= check("S4b mais letras: continua", m.shown == 1)
m.on_list(False); ok &= check("S4c fim da palavra: ferramentas, sem espera", m.shown == 1 and not m.hold and not m.pinned)
m.on_list(True); ok &= check("S4d proxima palavra volta a sugestoes", m.shown == 2)
# S5: barra oculta: nunca mostra
m = M(); m.baron = False; m.apply(); m.on_list(True); m.on_list(False)
ok &= check("S5 barra oculta -> 0 e sem espera", m.shown == 0 and not m.hold)
# S6: unhost durante a espera
m = M(); m.on_list(True); m.on_list(False); m.unhost()
ok &= check("S6 unhost cancela espera", not m.hold and m.deadline is None and m.shown == 1)
m.advance(2); ok &= check("S6b nada dispara depois", m.shown == 1)
# S7: listas vazias repetidas durante a espera reiniciam o relogio
m = M(); m.on_list(True); m.on_list(False); m.advance(0.7); m.on_list(False); m.advance(0.7)
ok &= check("S7a reiniciou: 1,4 s apos o 1o, ainda sugestoes", m.shown == 2)
m.advance(0.4); ok &= check("S7b 1,1 s apos o ultimo: ferramentas", m.shown == 1)
# S8: sem sugestoes, tecla oculta/mostra a linha (nao consumida)
m = M(); ok &= check("S8 tecla sem sugestoes nao consumida", m.bar_key() is False)
# S9: espera expirada, usuario continua; ferramentas -> sugestoes imediato
m = M(); m.on_list(True); m.on_list(False); m.advance(1.2); m.on_list(True)
ok &= check("S9 ferramentas -> sugestoes imediato", m.shown == 2)
print("\nTODOS OK" if ok else "\nHA FALHAS")
