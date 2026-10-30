#!/usr/bin/env python3
"""Executa o smali de CandidateView (onDraw, mrLayout, mrDrawAll, mrSlot, mrText, mrDivider,
mrOnFirst) num mini interpretador Dalvik (so o subconjunto de instrucoes usado), com Canvas e
Paint de mentira que gravam o que foi desenhado, e confere o resultado contra uma especificacao
independente escrita em Python (3 posicoes fixas, centro mais provavel, texto centralizado e
ajustado, divisores, destaque e selecao de toque, dica de salvar).

Uso: python3 -I strip_sim.py caminho/CandidateView.smali
"""
import math, operator as O, random, re, struct, sys

CV = 'Lcom/mrkeyboard/app/CandidateView;'
ELLIPSIS = '…'


# ----------------------------------------------------------------------------- parser
def parse_methods(path):
    methods, cur = {}, None
    for raw in open(path, encoding='utf-8'):
        line = raw.strip()
        if line.startswith('.method '):
            m = re.match(r'\.method\s+(?:\w+\s+)*([\w$<>]+)\((.*?)\)(\S+)$', line)
            cur = {'sig': m.group(2), 'static': ' static ' in line + ' ', 'locals': 0, 'code': [], 'labels': {}}
            methods[m.group(1) + '(' + m.group(2) + ')' + m.group(3)] = cur
        elif line.startswith('.end method'):
            cur = None
        elif cur is not None:
            if line.startswith('.locals'):
                cur['locals'] = int(line.split()[1])
            elif line.startswith('#') or line.startswith('.') or not line:
                continue
            elif line.startswith(':'):
                cur['labels'][line[1:]] = len(cur['code'])
            else:
                cur['code'].append(line.split('#')[0].strip())
    return methods


def nparams(sig):
    n, i = 0, 0
    while i < len(sig):
        c = sig[i]
        if c in 'IFZBSC': i += 1
        elif c == 'L': i = sig.index(';', i) + 1
        elif c == '[': i += 1; continue
        else: raise ValueError(sig)
        n += 1
    return n


def f32(x):
    return struct.unpack('>f', struct.pack('>f', x))[0]


def parse_int(tok):
    return -int(tok[1:], 16) if tok.startswith('-') else int(tok, 16)


# ----------------------------------------------------------------------------- objetos de mentira
class Obj:
    def __init__(self, **kw): self.f = dict(kw)


def text_width(text, size, bold):
    return f32(len(text) * size * 0.5 * (1.1 if bold else 1.0))


class Paint(Obj):
    def __init__(self):
        super().__init__(color=0, tf='DEFAULT', size=40.0)


class Canvas(Obj):
    def __init__(self):
        super().__init__(tx=0.0, ty=0.0, ops=[])


class VM:
    def __init__(self, methods): self.m = methods

    def run(self, key, args):
        m = self.m[key]
        loc = m['locals']
        n = nparams(m['sig']) + (0 if m['static'] else 1)
        R = [None] * (loc + n)
        for k, a in enumerate(args): R[loc + k] = a
        res = None
        pc, code, labels = 0, m['code'], m['labels']
        steps = 0

        def r(t):
            t = t.strip()
            return int(t[1:]) if t[0] == 'v' else loc + int(t[1:])

        while True:
            steps += 1
            assert steps < 200000, 'laco infinito?'
            ins = code[pc]; pc += 1
            op, _, rest = ins.partition(' ')
            def ops(): return [t.strip() for t in re.split(r',\s*(?![^{]*\})', rest)]
            if op in ('const/4', 'const/16', 'const'):
                a, b = ops(); R[r(a)] = parse_int(b)
            elif op == 'const/high16':
                a, b = ops(); R[r(a)] = struct.unpack('>f', struct.pack('>I', int(b, 16) & 0xffffffff))[0]
            elif op in ('move', 'move/from16', 'move-object', 'move-object/from16'):
                a, b = ops(); R[r(a)] = R[r(b)]
            elif op in ('move-result', 'move-result-object'): R[r(rest)] = res
            elif op in ('return', 'return-object'): return R[r(rest)]
            elif op == 'return-void': return None
            elif op in ('iget', 'iget-boolean', 'iget-object'):
                a, b, c = ops(); R[r(a)] = R[r(b)].f[c.split('->')[1].split(':')[0]]
            elif op in ('iput', 'iput-boolean', 'iput-object'):
                a, b, c = ops(); R[r(b)].f[c.split('->')[1].split(':')[0]] = R[r(a)]
            elif op == 'sget-object':
                a, b = ops(); R[r(a)] = b.split('->')[1].split(':')[0]
            elif op == 'aget':
                a, b, c = ops(); R[r(a)] = R[r(b)][R[r(c)]]
            elif op == 'aput':
                a, b, c = ops(); R[r(b)][R[r(c)]] = R[r(a)]
            elif op == 'new-array':
                a, b, c = ops(); R[r(a)] = [0] * R[r(b)]
            elif op == 'new-instance':
                a, b = ops()
                R[r(a)] = Obj(top=0) if b.endswith('Rect;') else (Paint() if b.endswith('TextPaint;') else Obj())
            elif op in ('add-int', 'sub-int', 'mul-int', 'add-float', 'sub-float', 'mul-float', 'div-float'):
                a, b, c = ops(); x, y = R[r(b)], R[r(c)]
                R[r(a)] = {'add-int': x + y if False else None}.get(op) if False else \
                    {'add': x + y, 'sub': x - y, 'mul': x * y}.get(op[:3]) if op[4:] != 'float' or op[:3] != 'div' else None
                if op == 'div-float': R[r(a)] = f32(x / y) if y else (math.inf if x > 0 else -math.inf if x < 0 else math.nan)
                elif op.endswith('float'): R[r(a)] = f32(R[r(a)])
            elif op in ('add-int/2addr', 'sub-int/2addr', 'add-float/2addr', 'sub-float/2addr', 'mul-float/2addr'):
                a, b = ops(); x, y = R[r(a)], R[r(b)]
                v = x + y if op[:3] == 'add' else x - y if op[:3] == 'sub' else x * y
                R[r(a)] = f32(v) if 'float' in op else v
            elif op in ('add-int/lit8', 'mul-int/lit8', 'div-int/lit8', 'and-int/lit8', 'rsub-int/lit8'):
                a, b, c = ops(); lit = parse_int(c); x = R[r(b)]
                R[r(a)] = {'add': x + lit, 'mul': x * lit, 'div': math.trunc(x / lit) if lit else 0,
                           'and': x & lit, 'rsu': lit - x}[op[:3]]
            elif op == 'neg-int': a, b = ops(); R[r(a)] = -R[r(b)]
            elif op == 'neg-float': a, b = ops(); R[r(a)] = -R[r(b)]
            elif op == 'int-to-float': a, b = ops(); R[r(a)] = f32(float(R[r(b)]))
            elif op == 'float-to-int': a, b = ops(); R[r(a)] = int(R[r(b)])
            elif op in ('cmpg-float', 'cmpl-float'):
                a, b, c = ops(); x, y = R[r(b)], R[r(c)]
                if math.isnan(x) or math.isnan(y): R[r(a)] = 1 if op == 'cmpg-float' else -1
                else: R[r(a)] = (x > y) - (x < y)
            elif op == 'check-cast': pass
            elif op == 'goto': pc = labels[rest[1:]]
            elif op.startswith('if-'):
                t = ops(); zero = op.endswith('z'); kind = op[3:5]
                a = R[r(t[0])]; b = 0 if zero else R[r(t[1])]
                if a is None: a = 0
                if not isinstance(a, (int, float)): a = 1
                if cond_ := {'eq': O.eq, 'ne': O.ne, 'lt': O.lt, 'ge': O.ge, 'gt': O.gt, 'le': O.le}[kind](a, b):
                    pc = labels[t[-1][1:]]
            elif op.startswith('invoke-'):
                if '/range' in op:
                    a, b = [x.strip() for x in rest[rest.index('{') + 1:rest.index('}')].split('..')]
                    regs = list(range(r(a), r(b) + 1))
                else:
                    regs = [r(x) for x in rest[rest.index('{') + 1:rest.index('}')].split(',') if x.strip()]
                target = rest[rest.index('}') + 2:].strip()
                res = self.invoke(op, target, [R[i] for i in regs])
            else:
                raise NotImplementedError(ins)

    # ------------------------------------------------------------------ chamadas externas
    def invoke(self, op, target, a):
        cls, _, mem = target.partition('->')
        if cls == CV and mem in self.m: return self.run(mem, a)
        if mem == '<init>(IIII)V' or mem == '<init>()V': return None
        if mem == '<init>(Landroid/graphics/Paint;)V':
            a[0].f.update(color=a[1].f['color'], tf=a[1].f['tf'], size=a[1].f['size']); return None
        if mem == 'onDraw(Landroid/graphics/Canvas;)V': return None
        tbl = {
            'Ljava/util/Arrays;->fill([II)V': lambda: [a[0].__setitem__(i, a[1]) for i in range(len(a[0]))] and None,
            'Ljava/lang/Math;->min(II)I': lambda: min(a[0], a[1]),
            'Ljava/util/ArrayList;->size()I': lambda: len(a[0]),
            'Ljava/util/ArrayList;->get(I)Ljava/lang/Object;': lambda: a[0][a[1]],
            'Ljava/lang/CharSequence;->length()I': lambda: len(a[0]),
        }
        if target in tbl: return tbl[target]()
        name = target.split('->')[1].split('(')[0]
        o = a[0]
        if name == 'setColor': o.f['color'] = a[1]; return None
        if name == 'setTypeface': o.f['tf'] = a[1]; return a[1]
        if name == 'getTextSize': return f32(o.f['size'])
        if name == 'setTextSize': o.f['size'] = a[1]; return None
        if name == 'measureText':
            return f32(text_width(a[1][a[2]:a[3]], o.f['size'], o.f['tf'] == 'DEFAULT_BOLD'))
        if name == 'ellipsize':   # TextUtils.ellipsize(text, tp, avail, END)
            text, tp, avail, _where = a
            if text_width(text, tp.f['size'], tp.f['tf'] == 'DEFAULT_BOLD') <= avail: return text
            k = len(text)
            while k > 0 and text_width(text[:k] + ELLIPSIS, tp.f['size'], tp.f['tf'] == 'DEFAULT_BOLD') > avail: k -= 1
            return text[:k] + ELLIPSIS
        if name == 'translate': o.f['tx'] += a[1]; o.f['ty'] += a[2]; return None
        if name == 'drawText':
            o.f['ops'].append(('text', a[1][a[2]:a[3]], round(a[4] + o.f['tx'], 3), round(a[5] + o.f['ty'], 3),
                               a[6].f['color'], a[6].f['tf'], round(a[6].f['size'], 3)))
            return None
        if name == 'draw':   # Drawable.draw(canvas)
            c = a[1]; c.f['ops'].append((o.f['kind'], tuple(o.f['bounds']), round(c.f['tx'], 3), round(c.f['ty'], 3))); return None
        if name == 'setBounds': o.f['bounds'] = a[1:5]; return None
        if name == 'getIntrinsicWidth': return o.f['iw']
        if name == 'getIntrinsicHeight': return o.f['ih']
        if name == 'getPadding': return 0
        if name == 'getWidth': return o.f['_w']
        if name == 'getHeight': return o.f['_h']
        if name == 'getScrollX': return 0
        if name == 'isInEditMode': return 0
        if name == 'getBackground': return None
        if name == 'getContext': return Obj()
        if name == 'getResources': return Obj()
        if name == 'getDisplayMetrics': return Obj(widthPixels=1080)
        if name == 'onAutoCompletionStateChanged': o.f['calls'].append(a[1]); return None
        raise NotImplementedError(target)


# ----------------------------------------------------------------------------- cenario
H, DIV_H, GAP, TOP = 116, 98, 26, 3
C_FULL, C_DIM, C_REC = 0xffe7eef7, 0xa6e7eef7, 0xfffff000    # cheia, 65%, recomendada (so p/ distinguir)


def mk_view(words, W, size, mhm, valid, hint, touch=-1):
    paint = Paint(); paint.f['size'] = size
    svc = Obj(calls=[])
    return Obj(mSuggestions=list(words), mPaint=paint, mGap=GAP, mDescent=9, mService=svc,
               mHaveMinimalSuggestion=mhm, mTypedWordValid=valid, mShowingAddToDictionary=hint,
               mColorNormal=C_DIM, mColorOther=C_FULL, mColorRecommended=C_REC,
               mSelectionHighlight=Obj(kind='highlight', bounds=None, iw=0, ih=0),
               mDivider=Obj(kind='divider', bounds=(0, 0, 3, DIV_H), iw=3, ih=DIV_H),
               mBgPadding=Obj(top=TOP), mTouchX=touch, mScrolled=False, mSelectedString=None, mSelectedIndex=-1,
               mWordWidth=[0] * 32, mWordX=[0] * 32, mTotalWidth=0, mCenter=0, mMerged=False, mH=0, mY=0,
               mSlot=None, _w=W, _h=H)


# ----------------------------------------------------------------------------- especificacao
def spec_slots(words, mhm, valid, hint):
    n = min(len(words), 3)
    if n == 0: return [-1, -1, -1], 0, False
    if hint and n >= 2: return [0, 1, -1], 1, True
    c = 1 if n >= 2 else 0
    if n >= 2 and mhm and valid: c = 0
    if n == 1: return [-1, 0, -1], 0, False
    return [1 - c, c, 2 if n == 3 else -1], c, False


def spec_fit(text, size, avail, bold):
    """(texto, tamanho) desenhados: encolhe ate 75% e depois corta com reticencias."""
    w = text_width(text, size, bold)
    if w <= avail: return text, size
    ratio = max(f32(avail / w), 0.75)
    new = f32(ratio * size)
    if text_width(text, new, bold) <= avail: return text, new
    k = len(text)
    while k > 0 and text_width(text[:k] + ELLIPSIS, new, bold) > avail: k -= 1
    return text[:k] + ELLIPSIS, new


def check(vm, words, W, size, mhm, valid, hint, touch):
    v = mk_view(words, W, size, mhm, valid, hint, touch)
    cv = Canvas()
    vm.run('onDraw(Landroid/graphics/Canvas;)V', [v, cv])
    Weff = W if W > 0 else 1080
    slots, c, merged = spec_slots(words, mhm, valid, hint)
    assert v.f['mSlot'] == slots, ('slots', v.f['mSlot'], slots)
    assert v.f['mCenter'] == c and v.f['mMerged'] == merged
    assert v.f['mTotalWidth'] == Weff
    texts, divs, hls = [], [], []
    for op in cv.f['ops']:
        (texts if op[0] == 'text' else divs if op[0] == 'divider' else hls).append(op)
    # divisores
    exp_div = [] if not words else [(1, Weff // 3), (2, 2 * Weff // 3)]
    exp_div = [x for i, x in exp_div if not (merged and i == 2)]
    exp_div = [Weff * (i + 1) // 3 for i in range(2) if not (merged and i == 1)]
    # (os divisores sao desenhados mesmo sem sugestoes, enquanto a faixa e desenhada)
    got = sorted(d[2] for d in divs)
    assert got == sorted(float(x) for x in exp_div), ('divisores', got, exp_div)
    assert all(d[3] == (H - DIV_H) // 2 for d in divs)
    # textos (comparacao como multiconjunto: a mesma palavra pode aparecer em mais de uma posicao)
    exists = False
    expected = []
    for s in range(3):
        idx = slots[s]
        if idx < 0: continue
        L = Weff * s // 3; Rr = Weff * (s + 1) // 3
        if merged and s == 1: Rr = Weff
        rec = mhm and ((idx == 1 and not valid) or (idx == 0 and valid))
        exists |= rec
        color = C_REC if rec else (C_FULL if idx == c else C_DIM)
        y = int(float(H) + size - 9) // 2
        want_text, want_size = spec_fit(words[idx], size, float(Rr - L - 2 * GAP), rec)
        cx = round(L + (Rr - L) // 2, 3)
        expected.append((want_text, float(cx), float(y), color, 'DEFAULT_BOLD' if rec else 'DEFAULT', round(want_size, 3)))
    got_t = sorted((t[1], t[2], t[3], t[4], t[5], round(t[6], 3)) for t in texts)
    assert got_t == sorted(expected), ('textos', got_t, sorted(expected))
    assert v.f['mPaint'].f['size'] == size and v.f['mPaint'].f['tf'] == 'DEFAULT'      # estado restaurado
    # autocorrecao recomendada informada ao servico
    assert v.f['mService'].f['calls'] == [exists], (v.f['mService'].f['calls'], exists)
    # toque: seleciona a posicao tocada e desenha o destaque (exceto na dica de salvar)
    sel_idx = -1
    if touch >= 0:
        for s in range(3):
            idx = slots[s]
            L = Weff * s // 3; Rr = Weff * (s + 1) // 3
            if merged and s == 1: Rr = Weff
            if idx >= 0 and L <= touch < Rr: sel_idx = idx
    assert v.f['mSelectedIndex'] == sel_idx, ('selecao', v.f['mSelectedIndex'], sel_idx)
    if sel_idx >= 0:
        assert v.f['mSelectedString'] == words[sel_idx]
        assert len(hls) == (0 if hint else 1)
    else:
        assert len(hls) == 0
    # passada sem canvas: nada desenhado, mesma selecao e mesma recomendada
    v2 = mk_view(words, W, size, mhm, valid, hint, touch)
    vm.run('onDraw(Landroid/graphics/Canvas;)V', [v2, None])
    assert v2.f['mSlot'] == slots and v2.f['mSelectedIndex'] == sel_idx
    assert v2.f['mService'].f['calls'] == [exists]
    # toque longo sobre a palavra digitada (indice 0)
    pts = {-1.0, 0.0, Weff - 1.0, float(Weff)}
    for k in range(4):
        b = Weff * k // 3
        pts |= {float(b - 1), float(b), float(b + 1), b + 0.5}
    for fx in sorted(pts):
        want = False
        if words and slots.count(0):
            s = slots.index(0); L = Weff * s // 3; Rr = Weff * (s + 1) // 3
            want = L <= fx < Rr
        assert (vm.run('mrOnFirst(F)Z', [v, fx]) == 1) == want, ('mrOnFirst', fx, slots)


def main(path):
    vm = VM(parse_methods(path))
    rnd = random.Random(11)
    pool = ['a', 'to', 'testa', 'testá', 'festa', 'testamento', 'responsabilidade', 'internacionalização',
            'extraordinariamente', 'x', 'não', 'Toque novamente para salvar', 'paralelepipedo', '.']
    n_cases = 0
    for _ in range(6000):
        n = rnd.randint(0, 6)
        words = [rnd.choice(pool) for _ in range(n)]
        W = rnd.choice([0, 720, 1058, 1080, 1440])
        size = rnd.choice([34.0, 46.0, 52.0])
        mhm, valid = rnd.random() < .4, rnd.random() < .5
        hint = rnd.random() < .15
        touch = rnd.choice([-1, -1, 10, 400, 700, 1000])
        check(vm, words, W, size, mhm, valid, hint, touch)
        n_cases += 1
    print(f'smali == especificacao em {n_cases} casos (onDraw, mrLayout, mrDrawAll, mrSlot, mrText, mrDivider, mrOnFirst)')


if __name__ == '__main__':
    main(sys.argv[1])
