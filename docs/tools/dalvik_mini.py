#!/usr/bin/env python3
"""Mini Dalvik interpreter (only the subset of instructions that the Mr Keyboard code uses).

It EXECUTES smali methods for real in tests, without a device: the caller provides a
"host" with fake framework classes (Color, Bitmap, Drawable, View...). It is not the
ART verifier and does not cover every instruction; an unknown instruction raises
NotImplementedError instead of being ignored.

Values: integers stored as signed 32 bits; floats as float32 (struct); constants
(`const`, `const/high16`) keep the bit pattern and the float operations interpret it.
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
    """Float operand: integer = bit pattern of a constant."""
    if isinstance(x, bool):
        raise TypeError('boolean in a float operation')
    return bits2f(x) if isinstance(x, int) else x


def iv(x):
    if isinstance(x, float):
        raise TypeError(f'float {x} used in an integer operation')
    if x is None:
        return 0
    if not isinstance(x, int):
        raise TypeError(f'object {x!r} used in an integer operation')
    return x


def parse_int(tok):
    tok = tok.strip()
    neg = tok.startswith('-')
    v = int(tok.lstrip('-'), 16) if tok.lstrip('-').lower().startswith('0x') else int(tok.lstrip('-'))
    return i32(-v if neg else v)


class FArr(list):
    """float[]: aput converts constants (bit pattern) to float, as ART does."""


class JavaExc(Exception):
    def __init__(self, cls='Ljava/lang/Exception;', msg=''):
        super().__init__(f'{cls} {msg}')
        self.cls = cls


class Obj:
    """Fake object: cls = Java name; f = fields."""
    def __init__(self, cls='Ljava/lang/Object;', **kw):
        self.cls = cls
        self.f = dict(kw)

    def __repr__(self):
        return f'<{self.cls} {self.f}>'


# ------------------------------------------------------------------------------ parser
def param_types(sig):
    """The types of the parameters of a method signature, one string each ('I', 'J', 'Lx/Y;', '[I'...)."""
    out, i = [], 0
    while i < len(sig):
        j = i
        while sig[j] == '[':
            j += 1
        j = sig.index(';', j) + 1 if sig[j] == 'L' else j + 1
        out.append(sig[i:j])
        i = j
    return out


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
    methods, cur, in_annotation, sw, last_label = {}, None, False, None, None
    for raw in open(path, encoding='utf-8'):
        line = raw.strip()
        if sw is not None:                      # the body of a switch table: targets (':label') or 'key -> :label'
            if line.startswith('.end '):
                sw = None
            elif line.startswith(':'):
                sw[1].append(line[1:])
            elif '->' in line:
                k, _, t = line.partition('->')
                sw[1].append((parse_int(k), t.strip()[1:]))
            continue
        if line.startswith('.annotation'):      # the body (value = { "..." }) is no code
            in_annotation = True
            continue
        if in_annotation:
            in_annotation = not line.startswith('.end annotation')
            continue
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
            elif line.startswith('.packed-switch') or line.startswith('.sparse-switch'):
                first = parse_int(line.split()[1]) if line.startswith('.packed') else None
                sw = (first, [])
                cur['labels']['@' + last_label] = sw
            elif line.startswith('#') or line.startswith('.') or not line:
                continue
            elif line.startswith(':'):
                last_label = line[1:]
                cur['labels'][last_label] = len(cur['code'])
            else:
                cur['code'].append(line.split('#')[0].strip())
    return methods


# ------------------------------------------------------------------------------ machine
class VM:
    """cls: name of the class whose methods are in `methods`. host: object with
    `invoke(vm, op, target, args)`, used for everything that is not in the class."""

    def __init__(self, cls, methods, host):
        self.cls, self.m, self.host = cls, methods, host
        self.statics = {}          # 'name' -> value, of the class itself
        self.max_steps = 400000

    # --- execution
    def run(self, key, args):
        m = self.m[key]
        loc = m['locals']
        n = nparams(m['sig']) + (0 if m['static'] else 1)
        assert len(args) == n, f'{key}: {len(args)} arguments, expected {n}'
        # a long or a double (J, D) takes two registers (p1, p2...): the value is kept in both, the call passes one
        kinds = ([] if m['static'] else ['L']) + param_types(m['sig'])
        slots = sum(2 if t in ('J', 'D') else 1 for t in kinds)
        R = [None] * (loc + slots)
        k = 0
        for a, t in zip(args, kinds):
            R[loc + k] = a
            if t in ('J', 'D'):
                R[loc + k + 1] = a
                k += 1
            k += 1
        labels, code = m['labels'], m['code']
        catches = [(c[0], labels[c[1]], labels[c[2]], labels[c[3]]) for c in m['catches']]
        pc, res, exc, steps = 0, None, None, 0

        def r(t):
            t = t.strip()
            return int(t[1:]) if t[0] == 'v' else loc + int(t[1:])

        while True:
            steps += 1
            assert steps < self.max_steps, f'{key}: infinite loop?'
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

        if op in ('const/4', 'const/16', 'const', 'const/high16', 'const-wide/16', 'const-wide/32'):
            a, b = ops(rest); setr(a, parse_int(b))
        elif op == 'const-string':
            a, b = rest.split(',', 1); setr(a, b.strip()[1:-1])
        elif op in ('move', 'move/from16', 'move-object', 'move-object/from16'):
            a, b = ops(rest); setr(a, R[r(b)])
        elif op in ('move-wide', 'move-wide/from16'):       # a long or double takes two registers: both are copied (the value is kept in both)
            a, b = ops(rest); R[r(a)] = R[r(b)]; R[r(a) + 1] = R[r(b) + 1] if r(b) + 1 < len(R) else R[r(b)]
        elif op in ('move-result', 'move-result-object', 'move-result-wide'): setr(rest, res)
        elif op == 'move-exception': setr(rest, exc)
        elif op in ('return', 'return-object', 'return-wide'): return pc, res, exc, True, R[r(rest)]
        elif op == 'return-void': return pc, res, exc, True, None
        elif op in ('iget', 'iget-boolean', 'iget-object', 'iget-wide'):
            a, b, c = ops(rest); setr(a, R[r(b)].f[c.split('->')[1].split(':')[0]])
        elif op in ('iput', 'iput-boolean', 'iput-object', 'iput-wide'):
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
            assert cls == self.cls, f'sput outside the class: {b}'
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
        elif op in ('add-int/lit8', 'mul-int/lit8', 'div-int/lit8', 'and-int/lit8', 'rsub-int/lit8', 'xor-int/lit8',
                    'ushr-int/lit8', 'shl-int/lit8', 'shr-int/lit8', 'add-int/lit16', 'mul-int/lit16', 'rsub-int'):
            a, b, c = ops(rest); lit = parse_int(c); x = iv(R[r(b)])
            k = op.split('-int')[0]
            setr(a, i32({'add': lambda: x + lit, 'mul': lambda: x * lit, 'div': lambda: math.trunc(x / lit),
                         'and': lambda: x & lit, 'xor': lambda: x ^ lit, 'rsub': lambda: lit - x,
                         'ushr': lambda: (x & 0xffffffff) >> (lit & 31), 'shl': lambda: x << (lit & 31),
                         'shr': lambda: x >> (lit & 31)}[k]()))
        elif op in ('div-int', 'div-int/2addr'):          # Dalvik truncates towards zero; a division by zero is an ArithmeticException
            t = ops(rest); x, y = (iv(R[r(t[0])]), iv(R[r(t[1])])) if op == 'div-int/2addr' else (iv(R[r(t[1])]), iv(R[r(t[2])]))
            if y == 0: raise JavaExc('Ljava/lang/ArithmeticException;', 'divide by zero')
            setr(t[0], i32(math.trunc(x / y)))
        elif op == 'int-to-long': a, b = ops(rest); setr(a, iv(R[r(b)]))
        elif op == 'mul-long/2addr': a, b = ops(rest); setr(a, R[r(a)] * R[r(b)])
        elif op == 'cmp-long': a, b, c = ops(rest); setr(a, (R[r(b)] > R[r(c)]) - (R[r(b)] < R[r(c)]))
        elif op == 'int-to-char': a, b = ops(rest); setr(a, iv(R[r(b)]) & 0xffff)
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
        elif op in ('packed-switch', 'sparse-switch'):
            reg, tab = ops(rest)
            first, targets = labels['@' + tab[1:]]
            v = iv(R[r(reg)])
            if op == 'packed-switch':
                if 0 <= v - first < len(targets):
                    pc = labels[targets[v - first]]
            else:
                for k, t in targets:
                    if k == v:
                        pc = labels[t]
                        break
        elif op.startswith('if-'):
            t = ops(rest); zero = op.endswith('z'); kind = op[3:5]
            a = R[r(t[0])]; b = 0 if zero else R[r(t[1])]
            if kind in ('eq', 'ne') and not zero and a is not None and b is not None \
                    and not isinstance(a, (int, float)) and not isinstance(b, (int, float)):
                # two references: the same object or not (not "both are non-null")
                if (a is b) == (kind == 'eq'):
                    pc = labels[t[-1][1:]]
                return pc, res, exc, False, None
            a = 0 if a is None else a
            b = 0 if b is None else b
            if not isinstance(a, (int, float)): a = 1            # non-null reference
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
            if '(' in mem and re.search(r'[JD]', mem[mem.index('(') + 1:mem.index(')')]):
                # long/double arguments take two registers: one value is passed
                types = ([] if 'static' in op else ['L']) + param_types(mem[mem.index('(') + 1:mem.index(')')])
                packed, i = [], 0
                for t in types:
                    packed.append(args[i])
                    i += 2 if t in ('J', 'D') else 1
                args = packed
            if cls == self.cls and mem in self.m and not mem.startswith('<init>'):
                res = self.run(mem, args)
            else:
                res = self.host.invoke(self, op, target, args)
        else:
            raise NotImplementedError(f'{op} {rest}')
        return pc, res, exc, False, None
