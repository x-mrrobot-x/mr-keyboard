#!/usr/bin/env python3
"""Generates the binary dictionary read by libjni_pckeyboard (dictionary.cpp of Hacker's Keyboard /
LatinIME Gingerbread) in the "latest" format: a 2-byte header and a bigram list per word.

Usage: python3 -I build_dict.py input.combined.gz output.dict [--format 1|2]
       python3 -I build_dict.py --convert in.dict out.dict [--format 2]    (re-encodes a dictionary that already exists)
       python3 -I build_dict.py --dump in.dict words.tsv bigrams.tsv       (every word and every pair, for native/test/dict_test.cpp)

Two formats, told apart by the 2nd byte of the header (docs/dictionary-build.md):
  v1  header [200][1]: addresses of 22 bits (6 bits of the flags byte + 2 bytes), dictionary under 4 MB (4,194,304 bytes)
  v2  header [200][2] (Mr Keyboard 1.86): one more byte in every address (6 bits + 3 bytes), dictionary under 16 MB
      (16,777,216 bytes, a policy limit: the format itself would hold much more). Same content takes about 0.7 MB more.
      Only an app that reads v2 (minApp 1.86.0) can use it, so a v2 pack has "format": 2 and "minApp": 1086000 in pack.json.

Format (checked against dictionary.cpp; see docs/dictionary-build.md); A = 3 in v1 and 4 in v2
  header        = [version 200][bigram 1 or 2]  (checkIfDictVersionIsLatest: version >= 200, flag 0/1/2)
  group         = [count:1] + count * entry; the root group sits at offset 2
  entry         = char:1 + flags/address + [freq:1 + bigrams, if terminal]
  char          = only 1 byte (< 0xFF): searchForTerminalNode walks 1 byte per char, so words
                  with characters >= 0xFF are left out
  flags/address: 0x80 terminal, 0x40 has children; with children it is A bytes: the flags byte (its low 6 bits are the
                  high bits) and the absolute address of the child group; without children it is 1 byte
  bigrams       = 1 byte 0x00 if there are none; otherwise N entries of A + 1 bytes:
                  [0x80 | end >> (8 * (A - 1)) (6 bits)][the other A - 1 bytes of end][0x80 if there is another | freq (7 bits)]
                  where "end" is the address of the char byte of the entry of the next word
  Depth-first layout (pre-order): searchForTerminalNode goes down choosing the last child with
  address <= target, which only works if each subtree takes a contiguous stretch after the
  parent's group. In breadth-first order (BFS) the search gets lost and the lib reads out of place.

The script re-reads the generated file with a Python copy of the lib's reading routines and stops with
an error if any word, frequency or bigram does not come out equal to the input.
"""
import gzip
import sys

HEADER_SIZE = 2
# format -> (header, bytes of an address, size limit)
FORMATS = {
    1: (bytes((200, 1)), 3, 0x400000),     # 22 bits
    2: (bytes((200, 2)), 4, 0x1000000),    # 24 bits (policy limit; the address field has 30)
}
ADDRESS_LIMIT = FORMATS[1][2]              # kept for the callers that only know v1
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


def entry_size(n, ab):
    s = 1 + (ab if n.kids else 1)
    if n.freq >= 0:
        s += 1 + ((ab + 1) * len(n.bigrams) if n.bigrams else 1)
    return s


def addr_bytes(flags, a, ab):
    """The address 'a' as the ab bytes of the format: the first one carries flags and the 6 high bits."""
    shift = 8 * (ab - 1)
    return bytes((flags | (a >> shift),) + tuple((a >> (8 * k)) & 0xFF for k in range(ab - 2, -1, -1)))


def read_addr(d, pos, ab):
    a = d[pos] & 0x3F
    for k in range(1, ab):
        a = (a << 8) | d[pos + k]
    return a


def serialize(root, fmt=1):
    header, ab, limit = FORMATS[fmt]
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
        pos += 1 + sum(entry_size(k, ab) for _, k in ks)
    total = pos
    if total >= limit:
        raise ValueError(f"dictionary with {total} bytes goes past the limit of format {fmt} ({limit} bytes)")
    entry_at = {}
    for n in order:
        p = group_at[id(n)] + 1
        for _, k in kids_of(n):
            entry_at[id(k)] = p
            p += entry_size(k, ab)
    out = bytearray(header)
    for n in order:
        assert len(out) == group_at[id(n)]
        ks = kids_of(n)
        out.append(len(ks))
        for ch, k in ks:
            out.append(ord(ch))
            flags = FLAG_TERMINAL if k.freq >= 0 else 0
            if k.kids:
                out += addr_bytes(flags | FLAG_CHILDREN, group_at[id(k)], ab)
            else:
                out.append(flags)
            if k.freq >= 0:
                out.append(k.freq)
                if k.bigrams:
                    last = len(k.bigrams) - 1
                    for j, (t, f) in enumerate(k.bigrams):
                        out += addr_bytes(0x80, entry_at[id(t)], ab)
                        out.append((0x80 if j < last else 0) | f)
                else:
                    out.append(0)
    assert len(out) == total
    return bytes(out)


# ---------------------------------------------------------------- re-reading (copy of the lib)

def format_of(d):
    """1 or 2, from the header (Dictionary::getVersionNumber); raises for anything else."""
    if len(d) < 3 or d[0] < 200 or d[1] not in (1, 2):
        raise ValueError("not a dictionary in the format v1 or v2")
    return d[1]


def walk(d, with_entries=False):
    """Walks the trie like getWordsRec/getFreq; returns {word: (freq, [(target_end, f)])}.
    With with_entries it also returns {end: word}, the address of the char byte of every word."""
    ab = FORMATS[format_of(d)][1]
    found = {}
    at = {}
    stack = [(HEADER_SIZE, "")]
    while stack:
        pos, prefix = stack.pop()
        count = d[pos]
        pos += 1
        for _ in range(count):
            end = pos
            ch = d[pos]
            pos += 1
            flags = d[pos]
            if flags & FLAG_CHILDREN:
                child = read_addr(d, pos, ab)
                pos += ab
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
                        a = read_addr(d, pos, ab)
                        big.append((a, d[pos + ab] & 0x7F))
                        more = d[pos + ab] & 0x80
                        pos += ab + 1
                else:
                    pos += 1
                found[w] = (freq, big)
                at[end] = w
            if child:
                stack.append((child, w))
    return (found, at) if with_entries else found


def search_terminal(d, target):
    """Copy of Dictionary::searchForTerminalNode: finds the word whose char is at 'target'."""
    ab = FORMATS[format_of(d)][1]
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
                    a = read_addr(d, pos, ab)
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
                pos += ab
            else:
                if target == pos - 1:
                    word.append(d[pos - 1])
                    found = True
                    break
                if flags & FLAG_CHILDREN:
                    if not stop:
                        a = read_addr(d, pos, ab)
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
                    pos += ab + 1
                else:
                    pos += 2
                if d[pos] & 0x80:
                    more = True
                    while more:
                        pos += ab
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


def verify(data, words, nodes, root, fmt=1, lib_every=1):
    """Re-reads 'data' and compares it with what was meant. Every bigram target is checked through the table of
    addresses; one in 'lib_every' also through search_terminal, the copy of the lib's own walk (1 = all)."""
    errors = []
    if data[:2] != FORMATS[fmt][0]:
        errors.append("header")
    got, at = walk(data, True)
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
                errors.append(f"freq of the bigram {w}: {f} != {ft}")
            r = at.get(a)
            if r is None or nodes.get(r) is not t:
                errors.append(f"bigram of {w} points to {r!r}")
            elif lib_every and nb % lib_every == 0:
                r = search_terminal(data, a)
                if r is None or nodes.get(r) is not t:
                    errors.append(f"bigram of {w} points to {r!r} for the lib")
        if len(errors) > 20:
            break
    return errors, nb


def from_dict(data):
    """The words [(word, freq)] and bigrams {word: [(next, f)]} of a dictionary that already exists, in the order stored."""
    got, at = walk(data, True)
    words = [(w, v[0]) for w, v in got.items()]
    bigrams = {}
    for w, (_, big) in got.items():
        if big:
            bigrams[w] = [(at[a], f) for a, f in big]
    return words, bigrams


def write(words, bigrams, fmt, lib_every=1):
    root, nodes, skipped, dropped = build(words, bigrams)
    data = serialize(root, fmt)
    errors, nb = verify(data, words, nodes, root, fmt, lib_every)
    return data, errors, nb, nodes, skipped, dropped


def main():
    args = sys.argv[1:]
    fmt = 1
    convert = False
    dump = False
    rest = []
    i = 0
    while i < len(args):
        if args[i] == "--format":
            fmt = int(args[i + 1])
            i += 2
        elif args[i] == "--convert":
            convert = True
            i += 1
        elif args[i] == "--dump":
            dump = True
            i += 1
        else:
            rest.append(args[i])
            i += 1
    if dump:
        if len(rest) != 3:
            print(__doc__)
            sys.exit(2)
        with open(rest[0], "rb") as fh:
            words, bigrams = from_dict(fh.read())
        with open(rest[1], "w", encoding="utf-8") as fh:
            for w, f in words:
                fh.write("%s\t%d\n" % (w, f))
        nb = 0
        with open(rest[2], "w", encoding="utf-8") as fh:
            for w, lst in bigrams.items():          # grouped by the previous word, in the order stored
                for w2, f in lst:
                    fh.write("%s\t%s\t%d\n" % (w, w2, f))
                    nb += 1
        print("%d words, %d bigrams" % (len(words), nb))
        return
    if len(rest) != 2 or fmt not in FORMATS:
        print(__doc__)
        sys.exit(2)
    src, dst = rest
    if convert:
        with open(src, "rb") as fh:
            old = fh.read()
        words, bigrams = from_dict(old)
        # the table of addresses checks every bigram; the lib's walk is repeated on one in 20 (it is slow in Python)
        data, errors, nb, nodes, skipped, dropped = write(words, bigrams, fmt, 20)
        if skipped or dropped:
            errors.append(f"{len(skipped)} words and {dropped} bigrams did not survive the conversion")
        before = walk(old)
        if len(before) != len(nodes) or sum(len(v[1]) for v in before.values()) != nb:
            errors.append("the converted dictionary has other counts than the source")
    else:
        words, bigrams = read_combined(src)
        data, errors, nb, nodes, skipped, dropped = write(words, bigrams, fmt)
    if errors:
        for e in errors[:20]:
            print("ERROR:", e)
        sys.exit(1)
    with open(dst, "wb") as fh:
        fh.write(data)
    print(f"format: {fmt}")
    print(f"words: {len(nodes)} (left out: {len(skipped)} with a character >= U+00FF or too long"
          f"{': ' + ' '.join(skipped[:10]) if skipped else ''})")
    print(f"bigrams: {nb} (dropped: {dropped})")
    print(f"bytes: {len(data)} (limit {FORMATS[fmt][2]}); re-read and bigrams checked")


if __name__ == "__main__":
    main()
