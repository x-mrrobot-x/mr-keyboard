#!/usr/bin/env python3
"""Generates the binary dictionary read by libjni_pckeyboard (dictionary.cpp of Hacker's Keyboard /
LatinIME Gingerbread) in the "latest" format: a 2-byte header and a bigram list per word.

Usage: python3 -I build_dict.py input.combined.gz output.dict

Format (checked against dictionary.cpp; see docs/dictionary-build.md)
  header        = [version 200][bigram 1]  (checkIfDictVersionIsLatest: version >= 200, flag 0/1)
  group         = [count:1] + count * entry; the root group sits at offset 2
  entry         = char:1 + flags/address + [freq:1 + bigrams, if terminal]
  char          = only 1 byte (< 0xFF): searchForTerminalNode walks 1 byte per char, so words
                  with characters >= 0xFF are left out
  flags/address: 0x80 terminal, 0x40 has children; with children it is 3 bytes with the absolute address
                  (22 bits) of the child group, without children it is 1 byte
  bigrams       = 1 byte 0x00 if there are none; otherwise N entries of 4 bytes:
                  [0x80 | end>>16 (6 bits)][end>>8][end][0x80 if there is another | freq (7 bits)]
                  where "end" is the address of the char byte of the entry of the next word
  Depth-first layout (pre-order): searchForTerminalNode goes down choosing the last child with
  address <= target, which only works if each subtree takes a contiguous stretch after the
  parent's group. In breadth-first order (BFS) the search gets lost and the lib reads out of place.

The script re-reads the generated file with a Python copy of the lib's reading routines and stops with
an error if any word, frequency or bigram does not come out equal to the input.
"""
import gzip
import sys

HEADER = bytes((200, 1))
HEADER_SIZE = 2
ADDRESS_LIMIT = 0x400000  # 22 bits
MAX_WORD_LENGTH = 47      # BinaryDictionary uses 48-char buffers with a terminator
MAX_BIGRAMS = 60          # the lib reads at most 60 per word (MAX_BIGRAMS of BinaryDictionary)
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
    while stack:                      # pre-order, children in code order
        n = stack.pop()
        order.append(n)
        stack.extend(k for _, k in reversed(kids_of(n)) if k.kids)
    group_at = {}
    pos = HEADER_SIZE
    for n in order:
        ks = kids_of(n)
        if len(ks) > 255:
            raise ValueError("group with more than 255 children")
        group_at[id(n)] = pos
        pos += 1 + sum(entry_size(k) for _, k in ks)
    total = pos
    if total >= ADDRESS_LIMIT:
        raise ValueError(f"dictionary with {total} bytes goes past the address limit (22 bits)")
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


# ---------------------------------------------------------------- re-reading (copy of the lib)

def walk(d):
    """Walks the trie like getWordsRec/getFreq; returns {word: (freq, [(target_end, f)])}."""
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
    """Copy of Dictionary::searchForTerminalNode: finds the word whose char is at 'target'."""
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
        errors.append("header")
    got = walk(data)
    expected = {w: n for w, n in nodes.items()}
    if set(got) != set(expected):
        miss = sorted(set(expected) - set(got))[:5]
        extra = sorted(set(got) - set(expected))[:5]
        errors.append(f"different words: missing {miss} extra {extra}")
    nb = 0
    for w, n in expected.items():
        g = got.get(w)
        if g is None:
            continue
        if g[0] != n.freq:
            errors.append(f"freq of {w}: {g[0]} != {n.freq}")
        if len(g[1]) != len(n.bigrams):
            errors.append(f"bigrams of {w}: {len(g[1])} != {len(n.bigrams)}")
            continue
        for (a, f), (t, ft) in zip(g[1], n.bigrams):
            nb += 1
            if f != ft:
                errors.append(f"freq do bigrama {w}: {f} != {ft}")
            r = search_terminal(data, a)
            if r is None or nodes.get(r) is not t:
                errors.append(f"bigram of {w} points to {r!r}")
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
            print("ERROR:", e)
        sys.exit(1)
    with open(dst, "wb") as fh:
        fh.write(data)
    print(f"words: {len(nodes)} (left out: {len(skipped)} with a character >= U+00FF or too long"
          f"{': ' + ' '.join(skipped[:10]) if skipped else ''})")
    print(f"bigrams: {nb} (dropped: {dropped})")
    print(f"bytes: {len(data)} (limit {ADDRESS_LIMIT}); re-read and bigrams checked")


if __name__ == "__main__":
    main()
