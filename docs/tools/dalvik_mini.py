#!/usr/bin/env python3
"""Mini interpretador Dalvik (so o subconjunto de instrucoes que o codigo do Mr Keyboard usa).

Serve para EXECUTAR metodos smali de verdade em testes, sem aparelho: o chamador fornece um
"host" com as classes do framework de mentira (Color, Bitmap, Drawable, View...). Nao e o
verificador do ART e nao cobre todas as instrucoes; instrucao desconhecida levanta
NotImplementedError em vez de ser ignorada.

Valores: inteiros guardados com sinal de 32 bits; floats como float32 (struct); constantes
(`const`, `const/high16`) guardam o padrao de bits e as operacoes de float o interpretam.
"""
import math, re, struct

INT_MIN, INT_MAX = -2 ** 31, 2 ** 31 - 1


def i32(x):
    x &= 0xffffffff
    return x - 2 ** 32 if x >= 2 ** 31 else x


def f32(x):
    try:
        return struct.unpack('>f', struct.pack('>f', x))[0]
    except OverflowError:
        return math.inf if x > 0 else -math.inf


def bits2f(x):
    return struct.unpack('>f', struct.pack('>I', x & 0xffffffff))[0]


def fv(x):
    """Operando de float: inteiro = padrao de bits de uma constante."""
    if isinstance(x, bool):
        raise TypeError('boolean em operacao de float')
    return bits2f(x) if isinstance(x, int) else x


def iv(x):
    if isinstance(x, float):
        raise TypeError(f'float {x} usado em operacao de inteiro')
    if x is None:
        return 0
    if not isinstance(x, int):
        raise TypeError(f'objeto {x!r} usado em operacao de inteiro')
    return x


def parse_int(tok):
    tok = tok.strip()
    neg = tok.startswith('-')
    v = int(tok.lstrip('-'), 16) if tok.lstrip('-').lower().startswith('0x') else int(tok.lstrip('-'))
    return i32(-v if neg else v)


class FArr(list):
    """float[]: aput converte constantes (padrao de bits) em float, como o ART."""


class JavaExc(Exception):
    def __init__(self, cls='Ljava/lang/Exception;', msg=''):
        super().__init__(f'{cls} {msg}')
        self.cls = cls


class Obj:
    """Objeto de mentira: cls = nome Java; f = campos."""
    def __init__(self, cls='Ljava/lang/Object;', **kw):
        self.cls = cls
        self.f = dict(kw)

    def __repr__(self):
        return f'<{self.cls} {self.f}>'


# ------------------------------------------------------------------------------ parser
def nparams(sig):
    n, i = 0, 0
    while i < len(sig):
        c = sig[i]
        if c in 'IFZBSCJD':
            i += 1
        elif c == 'L':
            i = sig.index(';', i) + 1
        elif c == '[':
            i += 1
            continue
        else:
            raise ValueError(sig)
        n += 1
    return n


def parse_methods(path):
    methods, cur = {}, None
    for raw in open(path, encoding='utf-8'):
        line = raw.strip()
        if line.startswith('.method '):
            m = re.match(r'\.method\s+(?:[\w-]+\s+)*([\w$<>]+)\((.*?)\)(\S+)$', line)
            cur = {'sig': m.group(2), 'static': ' static ' in ' ' + line + ' ', 'locals': 0, 'code': [],
                   'labels': {}, 'catches': []}
            methods[m.group(1) + '(' + m.group(2) + ')' + m.group(3)] = cur
        elif line.startswith('.end method'):
            cur = None
        elif cur is not None:
            if line.startswith('.locals'):
                cur['locals'] = int(line.split()[1])
            elif line.startswith('.catch'):
                m = re.match(r'\.catch(all)?\s+(?:(\S+)\s+)?\{:(\S+)\s+\.\.\s+:(\S+)\}\s+:(\S+)', line)
                cur['catches'].append((m.group(2) or 'Ljava/lang/Throwable;', m.group(3), m.group(4), m.group(5)))
            elif line.startswith('#') or line.startswith('.') or not line:
                continue
            elif line.startswith(':'):
                cur['labels'][line[1:]] = len(cur['code'])
            else:
                cur['code'].append(line.split('#')[0].strip())
    return methods


# ------------------------------------------------------------------------------ maquina
class VM:
    """cls: nome da classe cujos metodos estao em `methods`. host: objeto com
    `invoke(vm, op, target, args)`, usado para tudo que nao e da classe."""

    def __init__(self, cls, methods, host):
        self.cls, self.m, self.host = cls, methods, host
        self.statics = {}          # 'nome' -> valor, da propria classe
        self.max_steps = 400000

    # --- execucao
    def run(self, key, args):
        m = self.m[key]
        loc = m['locals']
        n = nparams(m['sig']) + (0 if m['static'] else 1)
        assert len(args) == n, f'{key}: {len(args)} argumentos, esperava {n}'
        R = [None] * (loc + n)
        for k, a in enumerate(args):
            R[loc + k] = a
        labels, code = m['labels'], m['code']
        catches = [(c[0], labels[c[1]], labels[c[2]], labels[c[3]]) for c in m['catches']]
        pc, res, exc, steps = 0, None, None, 0

        def r(t):
            t = t.strip()
            return int(t[1:]) if t[0] == 'v' else loc + int(t[1:])

        while True:
            steps += 1
            assert steps < self.max_steps, f'{key}: laco infinito?'
            ins = code[pc]
            at = pc
            pc += 1
            op, _, rest = ins.partition(' ')
            try:
                pc, res, exc, done, ret = self.step(op, rest, R, r, labels, pc, res, exc)
                if done:
                    return ret
            except JavaExc as e:
                for typ, s, t, h in catches:
                    if s <= at < t and (typ == e.cls or typ in ('Ljava/lang/Exception;', 'Ljava/lang/Throwable;')):
                        exc, pc = e, h
                        break
                else:
                    raise

    def ops(self, rest):
        return [t.strip() for t in re.split(r',\s*(?![^{]*\})', rest)]

    def step(self, op, rest, R, r, labels, pc, res, exc):
        ops = self.ops
        FOPS = {'add': lambda a, b: a + b, 'sub': lambda a, b: a - b, 'mul': lambda a, b: a * b}

        def setr(t, v): R[r(t)] = v

        if op in ('const/4', 'const/16', 'const', 'const/high16'):
            a, b = ops(rest); setr(a, parse_int(b))
        elif op == 'const-string':
            a, b = rest.split(',', 1); setr(a, b.strip()[1:-1])
        elif op in ('move', 'move/from16', 'move-object', 'move-object/from16'):
            a, b = ops(rest); setr(a, R[r(b)])
        elif op in ('move-result', 'move-result-object'): setr(rest, res)
        elif op == 'move-exception': setr(rest, exc)
        elif op in ('return', 'return-object'): return pc, res, exc, True, R[r(rest)]
        elif op == 'return-void': return pc, res, exc, True, None
        elif op in ('iget', 'iget-boolean', 'iget-object'):
            a, b, c = ops(rest); setr(a, R[r(b)].f[c.split('->')[1].split(':')[0]])
        elif op in ('iput', 'iput-boolean', 'iput-object'):
            a, b, c = ops(rest); R[r(b)].f[c.split('->')[1].split(':')[0]] = R[r(a)]
        elif op in ('sget', 'sget-object', 'sget-boolean'):
            a, b = ops(rest)
            cls, _, nm = b.partition('->')
            nm = nm.split(':')[0]
            setr(a, self.statics.get(nm, 0) if cls == self.cls else self.host.sget(cls, nm))
        elif op in ('sput', 'sput-object', 'sput-boolean'):
            a, b = ops(rest)
            cls, _, nm = b.partition('->')
            nm = nm.split(':')[0]
            assert cls == self.cls, f'sput fora da classe: {b}'
            self.statics[nm] = R[r(a)]
        elif op in ('aget', 'aget-object'):
            a, b, c = ops(rest); setr(a, R[r(b)][iv(R[r(c)])])
        elif op in ('aput', 'aput-object'):
            a, b, c = ops(rest); arr = R[r(b)]
            arr[iv(R[r(c)])] = fv(R[r(a)]) if isinstance(arr, FArr) else R[r(a)]
        elif op == 'array-length':
            a, b = ops(rest); setr(a, len(R[r(b)]))
        elif op == 'new-array':
            a, b, c = ops(rest)
            n = iv(R[r(b)]); setr(a, FArr([0.0] * n) if c == '[F' else [0 if c == '[I' else None] * n)
        elif op == 'new-instance':
            a, b = ops(rest); setr(a, self.host.new_instance(b))
        elif op == 'instance-of':
            a, b, c = ops(rest); setr(a, 1 if self.host.instance_of(R[r(b)], c) else 0)
        elif op == 'check-cast': pass
        elif op in ('add-int', 'sub-int', 'mul-int', 'and-int', 'or-int', 'xor-int'):
            a, b, c = ops(rest); x, y = iv(R[r(b)]), iv(R[r(c)])
            setr(a, i32({'add': x + y, 'sub': x - y, 'mul': x * y, 'and': x & y, 'or-': x | y, 'xor': x ^ y}[op[:3]]))
        elif op in ('add-int/2addr', 'sub-int/2addr', 'mul-int/2addr', 'and-int/2addr', 'or-int/2addr', 'xor-int/2addr'):
            a, b = ops(rest); x, y = iv(R[r(a)]), iv(R[r(b)])
            setr(a, i32({'add': x + y, 'sub': x - y, 'mul': x * y, 'and': x & y, 'or-': x | y, 'xor': x ^ y}[op[:3]]))
        elif op in ('add-int/lit8', 'mul-int/lit8', 'div-int/lit8', 'and-int/lit8', 'rsub-int/lit8',
                    'ushr-int/lit8', 'shl-int/lit8', 'shr-int/lit8', 'add-int/lit16', 'mul-int/lit16'):
            a, b, c = ops(rest); lit = parse_int(c); x = iv(R[r(b)])
            k = op.split('-int')[0]
            setr(a, i32({'add': lambda: x + lit, 'mul': lambda: x * lit, 'div': lambda: math.trunc(x / lit),
                         'and': lambda: x & lit, 'rsub': lambda: lit - x,
                         'ushr': lambda: (x & 0xffffffff) >> (lit & 31), 'shl': lambda: x << (lit & 31),
                         'shr': lambda: x >> (lit & 31)}[k]()))
        elif op == 'neg-int': a, b = ops(rest); setr(a, i32(-iv(R[r(b)])))
        elif op in ('add-float', 'sub-float', 'mul-float'):
            a, b, c = ops(rest); setr(a, f32(FOPS[op[:3]](fv(R[r(b)]), fv(R[r(c)]))))
        elif op in ('add-float/2addr', 'sub-float/2addr', 'mul-float/2addr'):
            a, b = ops(rest); setr(a, f32(FOPS[op[:3]](fv(R[r(a)]), fv(R[r(b)]))))
        elif op in ('div-float', 'div-float/2addr'):
            t = ops(rest); x, y = (fv(R[r(t[0])]), fv(R[r(t[-1])])) if op == 'div-float/2addr' else (fv(R[r(t[1])]), fv(R[r(t[2])]))
            setr(t[0], f32(x / y) if y else math.copysign(math.inf, x) if x else math.nan)
        elif op == 'neg-float': a, b = ops(rest); setr(a, f32(-fv(R[r(b)])))
        elif op == 'int-to-float': a, b = ops(rest); setr(a, f32(float(iv(R[r(b)]))))
        elif op == 'float-to-int':
            a, b = ops(rest); x = fv(R[r(b)])
            setr(a, 0 if math.isnan(x) else INT_MAX if x >= INT_MAX else INT_MIN if x <= INT_MIN else int(x))
        elif op in ('cmpl-float', 'cmpg-float'):
            a, b, c = ops(rest); x, y = fv(R[r(b)]), fv(R[r(c)])
            setr(a, (1 if op == 'cmpg-float' else -1) if math.isnan(x) or math.isnan(y) else (x > y) - (x < y))
        elif op == 'goto': pc = labels[rest[1:]]
        elif op.startswith('if-'):
            t = ops(rest); zero = op.endswith('z'); kind = op[3:5]
            a = R[r(t[0])]; b = 0 if zero else R[r(t[1])]
            a = 0 if a is None else a
            b = 0 if b is None else b
            if not isinstance(a, (int, float)): a = 1            # referencia nao nula
            if not isinstance(b, (int, float)): b = 1
            import operator as O
            if {'eq': O.eq, 'ne': O.ne, 'lt': O.lt, 'ge': O.ge, 'gt': O.gt, 'le': O.le}[kind](a, b):
                pc = labels[t[-1][1:]]
        elif op.startswith('invoke-'):
            if '/range' in op:
                a, b = [x.strip() for x in rest[rest.index('{') + 1:rest.index('}')].split('..')]
                regs = list(range(r(a), r(b) + 1))
            else:
                regs = [r(x) for x in rest[rest.index('{') + 1:rest.index('}')].split(',') if x.strip()]
            target = rest[rest.index('}') + 2:].strip()
            cls, _, mem = target.partition('->')
            args = [R[i] for i in regs]
            if cls == self.cls and mem in self.m and not mem.startswith('<init>'):
                res = self.run(mem, args)
            else:
                res = self.host.invoke(self, op, target, args)
        else:
            raise NotImplementedError(f'{op} {rest}')
        return pc, res, exc, False, None
