#!/usr/bin/env python3
"""Gera o dicionário binário lido por libjni_pckeyboard (dictionary.cpp do Hacker's Keyboard /
LatinIME Gingerbread) no formato "latest": cabeçalho de 2 bytes e lista de bigramas por palavra.

Uso: python3 -I build_dict.py entrada.combined.gz saida.dict

Formato (conferido no dictionary.cpp; ver docs/revisao-1.6.0.md)
  cabeçalho     = [versão 200][bigrama 1]  (checkIfDictVersionIsLatest: versão >= 200, flag 0/1)
  grupo         = [count:1] + count * entrada; o grupo raiz fica no offset 2
  entrada       = char:1 + flags/endereço + [freq:1 + bigramas, se terminal]
  char          = só 1 byte (< 0xFF): searchForTerminalNode anda 1 byte por char, então palavras
                  com caracteres >= 0xFF ficam de fora
  flags/endereço: 0x80 terminal, 0x40 tem filhos; com filhos são 3 bytes com o endereço absoluto
                  (22 bits) do grupo filho, sem filhos é 1 byte
  bigramas      = 1 byte 0x00 se não há; senão N entradas de 4 bytes:
                  [0x80 | end>>16 (6 bits)][end>>8][end][0x80 se há outra | freq (7 bits)]
                  onde "end" é o endereço do byte de char da entrada da palavra seguinte
  Layout em profundidade (pré-ordem): searchForTerminalNode desce escolhendo o último filho com
  endereço <= alvo, o que só funciona se cada subárvore ocupar um trecho contíguo depois do
  grupo do pai. Em largura (BFS) a busca se perde e a lib lê fora do lugar.

O script relê o arquivo gerado com uma cópia em Python das rotinas de leitura da lib e para com
erro se qualquer palavra, frequência ou bigrama não sair igual à entrada.
"""
import gzip
import sys

HEADER = bytes((200, 1))
HEADER_SIZE = 2
ADDRESS_LIMIT = 0x400000  # 22 bits
MAX_WORD_LENGTH = 47      # BinaryDictionary usa buffers de 48 chars com terminador
MAX_BIGRAMS = 60          # a lib lê no máximo 60 por palavra (MAX_BIGRAMS do BinaryDictionary)
FLAG_TERMINAL = 0x80
FLAG_CHILDREN = 0x40


class Node:
    __slots__ = ("kids", "freq", "bigrams")

    def __init__(self):
        self.kids = {}
        self.freq = -1
        self.bigrams = []


def read_combined(path):
    words, bigrams, cur = [], {}, None
    with gzip.open(path, "rt", encoding="utf-8") as fh:
        for line in fh:
            if line.startswith(" word="):
                d = dict(kv.split("=", 1) for kv in line.strip().split(","))
                cur = d["word"]
                words.append((cur, int(d["f"])))
            elif line.startswith("  bigram=") and cur is not None:
                d = dict(kv.split("=", 1) for kv in line.strip().split(","))
                bigrams.setdefault(cur, []).append((d["bigram"], int(d["f"])))
    return words, bigrams


def usable(w):
    return 0 < len(w) <= MAX_WORD_LENGTH and all(0 < ord(c) < 0xFF for c in w)


def build(words, bigrams):
    root = Node()
    nodes = {}
    skipped = []
    for w, f in words:
        if not usable(w):
            skipped.append(w)
            continue
        n = root
        for ch in w:
            n = n.kids.setdefault(ch, Node())
        n.freq = max(n.freq, max(1, min(255, f)))
        nodes[w] = n
    dropped_bigrams = 0
    for w1, lst in bigrams.items():
        n1 = nodes.get(w1)
        if n1 is None:
            dropped_bigrams += len(lst)
            continue
        seen = set()
        for w2, f in lst:
            n2 = nodes.get(w2)
            if n2 is None or w2 in seen or len(n1.bigrams) >= MAX_BIGRAMS:
                dropped_bigrams += 1
                continue
            seen.add(w2)
            n1.bigrams.append((n2, max(1, min(127, f))))
        n1.bigrams.sort(key=lambda x: -x[1])
    return root, nodes, skipped, dropped_bigrams


def kids_of(n):
    return sorted(n.kids.items(), key=lambda kv: ord(kv[0]))


def entry_size(n):
    s = 1 + (3 if n.kids else 1)
    if n.freq >= 0:
        s += 1 + (4 * len(n.bigrams) if n.bigrams else 1)
    return s


def serialize(root):
    order = []
    stack = [root]
    while stack:                      # pré-ordem, filhos em ordem de código
        n = stack.pop()
        order.append(n)
        stack.extend(k for _, k in reversed(kids_of(n)) if k.kids)
    group_at = {}
    pos = HEADER_SIZE
    for n in order:
        ks = kids_of(n)
        if len(ks) > 255:
            raise ValueError("grupo com mais de 255 filhos")
        group_at[id(n)] = pos
        pos += 1 + sum(entry_size(k) for _, k in ks)
    total = pos
    if total >= ADDRESS_LIMIT:
        raise ValueError(f"dicionário com {total} bytes passa do limite de endereço (22 bits)")
    entry_at = {}
    for n in order:
        p = group_at[id(n)] + 1
        for _, k in kids_of(n):
            entry_at[id(k)] = p
            p += entry_size(k)
    out = bytearray(HEADER)
    for n in order:
        assert len(out) == group_at[id(n)]
        ks = kids_of(n)
        out.append(len(ks))
        for ch, k in ks:
            out.append(ord(ch))
            flags = FLAG_TERMINAL if k.freq >= 0 else 0
            if k.kids:
                a = group_at[id(k)]
                out += bytes((flags | FLAG_CHILDREN | (a >> 16), (a >> 8) & 0xFF, a & 0xFF))
            else:
                out.append(flags)
            if k.freq >= 0:
                out.append(k.freq)
                if k.bigrams:
                    last = len(k.bigrams) - 1
                    for j, (t, f) in enumerate(k.bigrams):
                        a = entry_at[id(t)]
                        out += bytes((0x80 | (a >> 16), (a >> 8) & 0xFF, a & 0xFF,
                                      (0x80 if j < last else 0) | f))
                else:
                    out.append(0)
    assert len(out) == total
    return bytes(out)


# ---------------------------------------------------------------- releitura (cópia da lib)

def walk(d):
    """Percorre o trie como getWordsRec/getFreq; devolve {palavra: (freq, [(end_alvo, f)])}."""
    found = {}
    stack = [(HEADER_SIZE, "")]
    while stack:
        pos, prefix = stack.pop()
        count = d[pos]
        pos += 1
        for _ in range(count):
            ch = d[pos]
            pos += 1
            flags = d[pos]
            if flags & FLAG_CHILDREN:
                child = ((d[pos] & 0x3F) << 16) | (d[pos + 1] << 8) | d[pos + 2]
                pos += 3
            else:
                child = 0
                pos += 1
            w = prefix + chr(ch)
            if flags & FLAG_TERMINAL:
                freq = d[pos]
                pos += 1
                big = []
                if d[pos] & 0x80:
                    more = True
                    while more:
                        a = ((d[pos] & 0x3F) << 16) | (d[pos + 1] << 8) | d[pos + 2]
                        big.append((a, d[pos + 3] & 0x7F))
                        more = d[pos + 3] & 0x80
                        pos += 4
                else:
                    pos += 1
                found[w] = (freq, big)
            if child:
                stack.append((child, w))
    return found


def search_terminal(d, target):
    """Cópia de Dictionary::searchForTerminalNode: acha a palavra cujo char está em 'target'."""
    word = []
    follow = HEADER_SIZE
    following = None
    depth = -1
    found = False
    while not found:
        stop, first_addr, search_all = False, True, True
        if depth >= 0:
            word.append(following)
        pos = follow
        count = d[pos]
        pos += 1
        for _ in range(count):
            pos += 1
            flags = d[pos]
            if not flags & FLAG_TERMINAL:
                if not stop:
                    a = ((d[pos] & 0x3F) << 16) | (d[pos + 1] << 8) | d[pos + 2]
                    if a > target:
                        stop = True
                        if first_addr:
                            first_addr, search_all = False, True
                        elif not search_all:
                            break
                    else:
                        follow, following = a, d[pos - 1]
                        if first_addr:
                            first_addr, search_all = False, False
                pos += 3
            else:
                if target == pos - 1:
                    word.append(d[pos - 1])
                    found = True
                    break
                if flags & FLAG_CHILDREN:
                    if not stop:
                        a = ((d[pos] & 0x3F) << 16) | (d[pos + 1] << 8) | d[pos + 2]
                        if a > target:
                            stop = True
                            if first_addr:
                                first_addr, search_all = False, True
                            elif not search_all:
                                break
                        else:
                            follow, following = a, d[pos - 1]
                            if first_addr:
                                first_addr, search_all = False, True
                    pos += 4
                else:
                    pos += 2
                if d[pos] & 0x80:
                    more = True
                    while more:
                        pos += 3
                        more = d[pos] & 0x80
                        pos += 1
                else:
                    pos += 1
        depth += 1
        if not found and follow == 0:
            return None
        if depth > MAX_WORD_LENGTH:
            return None
    return "".join(chr(c) for c in word)


def verify(data, words, nodes, root):
    errors = []
    if data[:2] != HEADER:
        errors.append("cabeçalho")
    got = walk(data)
    expected = {w: n for w, n in nodes.items()}
    if set(got) != set(expected):
        miss = sorted(set(expected) - set(got))[:5]
        extra = sorted(set(got) - set(expected))[:5]
        errors.append(f"palavras diferentes: faltam {miss} sobram {extra}")
    nb = 0
    for w, n in expected.items():
        g = got.get(w)
        if g is None:
            continue
        if g[0] != n.freq:
            errors.append(f"freq de {w}: {g[0]} != {n.freq}")
        if len(g[1]) != len(n.bigrams):
            errors.append(f"bigramas de {w}: {len(g[1])} != {len(n.bigrams)}")
            continue
        for (a, f), (t, ft) in zip(g[1], n.bigrams):
            nb += 1
            if f != ft:
                errors.append(f"freq do bigrama {w}: {f} != {ft}")
            r = search_terminal(data, a)
            if r is None or nodes.get(r) is not t:
                errors.append(f"bigrama de {w} aponta para {r!r}")
        if len(errors) > 20:
            break
    return errors, nb


def main():
    src, dst = sys.argv[1], sys.argv[2]
    words, bigrams = read_combined(src)
    root, nodes, skipped, dropped = build(words, bigrams)
    data = serialize(root)
    errors, nb = verify(data, words, nodes, root)
    if errors:
        for e in errors[:20]:
            print("ERRO:", e)
        sys.exit(1)
    with open(dst, "wb") as fh:
        fh.write(data)
    print(f"palavras: {len(nodes)} (fora: {len(skipped)} com caractere >= U+00FF ou longas demais"
          f"{': ' + ' '.join(skipped[:10]) if skipped else ''})")
    print(f"bigramas: {nb} (descartados: {dropped})")
    print(f"bytes: {len(data)} (limite {ADDRESS_LIMIT}); releitura e bigramas conferidos")


if __name__ == "__main__":
    main()
