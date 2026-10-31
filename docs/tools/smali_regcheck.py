#!/usr/bin/env python3
"""Confere, no smali, se todo registrador lido já recebeu valor em TODOS os caminhos até ali.

Existe porque editar smali à mão pode tirar a única instrução que dava valor a um registrador
(`const/4 v1, 0x1`, por exemplo) e o resto do método continuar usando. O verificador do ART recusa a
classe inteira ao carregar ("register vN has type Undefined"), o app fecha, e nem o apktool nem o
d2j-asm-verify avisam.

Só olha atribuição definitiva (não confere tipos). Uso:

    python3 docs/tools/smali_regcheck.py smali/                      # tudo
    python3 docs/tools/smali_regcheck.py smali/ --base outra/smali/  # só o que é novo em relação a outra árvore

Sai com 1 se achar algo (novo, no modo --base).
"""
import os, re, sys

WIDE_T = ('long', 'double')
THROWING = ('invoke', 'new-instance', 'new-array', 'iget', 'iput', 'sget', 'sput', 'aget', 'aput',
            'check-cast', 'instance-of', 'array-length', 'throw', 'monitor', 'const-string',
            'const-class', 'div-', 'rem-', 'filled-new-array', 'fill-array-data')


def regs_of(text, locals_n):
    """Números dos registradores citados em `text`, em ordem (pN vira locals+N)."""
    out = []
    for m in re.finditer(r'\{\s*([vp]\d+)\s*\.\.\s*([vp]\d+)\s*\}|([vp])(\d+)', text):
        if m.group(1):
            a, b = [conv(x, locals_n) for x in (m.group(1), m.group(2))]
            out.extend(range(a, b + 1))
        else:
            out.append(conv(m.group(3) + m.group(4), locals_n))
    return out


def conv(r, locals_n):
    n = int(r[1:])
    return n if r[0] == 'v' else locals_n + n


def is_wide_binop(op):
    return op.endswith(('-long', '-double', '-long/2addr', '-double/2addr'))


def rw(op, regs):
    """(lidos, escritos) do instruction. `regs` = registradores do operando, em ordem (sem labels)."""
    r = regs
    w2 = lambda x: [x, x + 1]
    base = op.split('/')[0]
    if op == 'nop' or op.startswith('goto') or op == 'return-void':
        return [], []
    if op.startswith('move-result') or op == 'move-exception':
        return [], (w2(r[0]) if op.endswith('wide') else [r[0]])
    if op.startswith('move'):
        wide = '-wide' in op
        return (w2(r[1]) if wide else [r[1]]), (w2(r[0]) if wide else [r[0]])
    if op.startswith('return'):
        return (w2(r[0]) if op == 'return-wide' else [r[0]]), []
    if op.startswith('const-wide'):
        return [], w2(r[0])
    if op.startswith('const'):
        return [], [r[0]]
    if op in ('monitor-enter', 'monitor-exit', 'throw', 'fill-array-data', 'check-cast') \
            or op.startswith(('packed-switch', 'sparse-switch')):
        return [r[0]], []
    if op in ('instance-of', 'array-length', 'new-array'):
        return [r[1]], [r[0]]
    if op == 'new-instance':
        return [], [r[0]]
    if op.startswith('filled-new-array'):
        return list(r), []
    if op.startswith('invoke'):
        return list(r), []
    if op.startswith('cmp'):
        wide = 'long' in op or 'double' in op
        a = (w2(r[1]) + w2(r[2])) if wide else [r[1], r[2]]
        return a, [r[0]]
    if op.startswith('if-'):
        return list(r), []
    if base.startswith('aget'):
        return [r[1], r[2]], (w2(r[0]) if base == 'aget-wide' else [r[0]])
    if base.startswith('aput'):
        return ((w2(r[0]) if base == 'aput-wide' else [r[0]]) + [r[1], r[2]]), []
    if base.startswith('iget'):
        return [r[1]], (w2(r[0]) if base == 'iget-wide' else [r[0]])
    if base.startswith('iput'):
        return ((w2(r[0]) if base == 'iput-wide' else [r[0]]) + [r[1]]), []
    if base.startswith('sget'):
        return [], (w2(r[0]) if base == 'sget-wide' else [r[0]])
    if base.startswith('sput'):
        return (w2(r[0]) if base == 'sput-wide' else [r[0]]), []
    m = re.match(r'^(\w+)-to-(\w+)$', op)
    if m:
        s, d = m.groups()
        return (w2(r[1]) if s in WIDE_T else [r[1]]), (w2(r[0]) if d in WIDE_T else [r[0]])
    if re.match(r'^(neg|not)-(int|float|long|double)$', op):
        wide = op.endswith(('long', 'double'))
        return (w2(r[1]) if wide else [r[1]]), (w2(r[0]) if wide else [r[0]])
    if op.endswith('/2addr'):
        wide = is_wide_binop(op)
        shift = op.split('-')[0] in ('shl', 'shr', 'ushr') and wide
        a = (w2(r[0]) if wide else [r[0]]) + ([r[1]] if shift else (w2(r[1]) if wide else [r[1]]))
        return a, (w2(r[0]) if wide else [r[0]])
    if re.search(r'/lit(8|16)$', op) or op.startswith('rsub-int'):
        return [r[1]], [r[0]]
    if re.match(r'^[a-z]+-(int|long|float|double)$', op):
        wide = is_wide_binop(op)
        shift = op.split('-')[0] in ('shl', 'shr', 'ushr') and wide
        a = (w2(r[1]) if wide else [r[1]]) + ([r[2]] if shift else (w2(r[2]) if wide else [r[2]]))
        return a, (w2(r[0]) if wide else [r[0]])
    raise NotImplementedError(op)


def param_count(sig, static):
    inner = sig[sig.index('(') + 1:sig.index(')')]
    n = 0 if static else 1
    i = 0
    while i < len(inner):
        c = inner[i]
        if c == 'L':
            i = inner.index(';', i) + 1
            n += 1
        elif c == '[':
            while inner[i] == '[':
                i += 1
            i = inner.index(';', i) + 1 if inner[i] == 'L' else i + 1
            n += 1
        else:
            n += 2 if c in 'JD' else 1
            i += 1
    return n


def methods(path):
    text = open(path, encoding='utf-8', errors='replace').read().split('\n')
    cur = None
    for ln, line in enumerate(text, 1):
        s = line.strip()
        if s.startswith('.method '):
            cur = {'head': s, 'lines': [], 'start': ln}
        elif s == '.end method' and cur:
            yield cur
            cur = None
        elif cur is not None:
            cur['lines'].append((ln, s))


def analyze(m):
    head = m['head']
    name_sig = head.split()[-1]
    static = ' static ' in head + ' '
    nparams = param_count(name_sig, static)
    locals_n = None
    insns = []        # (ln, op, regs, labels)
    label_at = {}     # rótulo -> índice da próxima instrução
    catches = []      # (try_start, try_end, handler)
    payload = {}      # rótulo do payload -> rótulos alvo
    skip = None
    pending_payload = None
    for ln, s in m['lines']:
        s = re.sub(r'"(?:[^"\\]|\\.)*"', '"S"', s)
        if '#' in s:
            s = s.split('#', 1)[0].strip()
        if not s:
            continue
        if skip:
            if s.startswith('.end ' + skip):
                skip = None
            elif skip in ('packed-switch', 'sparse-switch') and pending_payload:
                payload[pending_payload].extend(re.findall(r':[\w$]+', s))
            continue
        if s.startswith('.locals'):
            locals_n = int(s.split()[1])
        elif s.startswith('.registers'):
            locals_n = int(s.split()[1]) - nparams
        elif s.startswith(('.catch ', '.catchall ')):
            labs = re.findall(r':[\w$]+', s)
            catches.append((labs[0], labs[1], labs[2]))
        elif s.startswith(('.annotation', '.array-data', '.packed-switch', '.sparse-switch')):
            skip = s.split()[0][1:]
            if skip in ('packed-switch', 'sparse-switch'):
                pending_payload = last_label
                payload.setdefault(pending_payload, [])
                if skip == 'sparse-switch':
                    pass
        elif s.startswith('.'):
            continue
        elif s.startswith(':'):
            label_at[s] = len(insns)
            last_label = s
        else:
            op = s.split()[0]
            rest = s[len(op):]
            labs = re.findall(r':[\w$]+', rest)
            # tira tipos (Lpacote/v1/Classe;) e referências (->campo) para não confundir "v1" com registrador
            ops = re.sub(r'->\S+', 'F', re.sub(r'\[*L[\w/$]+;', 'T', rest))
            insns.append((ln, op, regs_of(ops, locals_n if locals_n is not None else 0), labs))
    if locals_n is None or not insns:
        return []
    total = locals_n + nparams
    entry = 0
    for k in range(nparams):
        entry |= 1 << (locals_n + k)
    n = len(insns)
    succ = [[] for _ in range(n)]
    for i, (ln, op, regs, labs) in enumerate(insns):
        nxt = []
        if op.startswith('goto'):
            nxt = [label_at[labs[0]]]
        elif op.startswith(('return', 'throw')):
            nxt = []
        elif op.startswith(('packed-switch', 'sparse-switch')):
            nxt = [i + 1] + [label_at[t] for t in payload.get(labs[0], []) if t in label_at]
        elif op.startswith('if-'):
            nxt = [i + 1, label_at[labs[0]]]
        else:
            nxt = [i + 1]
        succ[i] = [x for x in nxt if x < n]
    handlers = []
    for a, b, h in catches:
        handlers.append((label_at[a], label_at[b], label_at[h]))
    ALL = (1 << total) - 1
    state = [None] * n
    state[0] = entry
    work = [0]
    findings = []

    def merge(j, st):
        if state[j] is None:
            state[j] = st
            work.append(j)
        else:
            new = state[j] & st
            if new != state[j]:
                state[j] = new
                work.append(j)

    while work:
        i = work.pop()
        st = state[i]
        ln, op, regs, labs = insns[i]
        for (a, b, h) in handlers:
            if a <= i < b and op.startswith(THROWING):
                merge(h, st)
        if op.startswith('move-exception'):
            pass
        try:
            rd, wr = rw(op, regs)
        except NotImplementedError:
            findings.append((ln, 'opcode sem regra: ' + op))
            continue
        out = st
        for x in wr:
            if x < total:
                out |= 1 << x
        for j in succ[i]:
            merge(j, out)
    for i in range(n):
        if state[i] is None:
            continue
        ln, op, regs, labs = insns[i]
        try:
            rd, wr = rw(op, regs)
        except NotImplementedError:
            continue
        for x in rd:
            if x < total and not (state[i] >> x) & 1:
                findings.append((ln, 'v%d lido sem valor em "%s"' % (x, op)))
    return findings


def scan(root):
    res = {}
    for dp, _, fs in os.walk(root):
        for f in fs:
            if not f.endswith('.smali'):
                continue
            p = os.path.join(dp, f)
            rel = os.path.relpath(p, root)
            for m in methods(p):
                try:
                    fl = analyze(m)
                except Exception as e:  # noqa
                    fl = [(m['start'], 'erro ao analisar: %r' % e)]
                for ln, msg in fl:
                    res.setdefault((rel, m['head'].split()[-1]), []).append((ln, msg))
    return res


if __name__ == '__main__':
    args = sys.argv[1:]
    base = None
    if '--base' in args:
        k = args.index('--base')
        base = args[k + 1]
        del args[k:k + 2]
    cur = scan(args[0])
    old = scan(base) if base else {}
    new = {k: v for k, v in cur.items() if k not in old}
    for (rel, meth), fl in sorted(new.items()):
        for ln, msg in fl:
            print('%s:%d  %s  %s' % (rel, ln, meth, msg))
    print('métodos com problema: %d (%s)' % (len(new), 'novos em relação a --base' if base else 'total'))
    sys.exit(1 if new else 0)
