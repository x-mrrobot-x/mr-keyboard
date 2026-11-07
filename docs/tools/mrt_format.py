#!/usr/bin/env python3
"""Readers and writers of the two formats of trigrams.bin (big-endian), independent of the C++ reader in engine/src/mr_tri.cpp.

  MRT1 (until 1.89)
    "MRT1" | u32 n | n x (u8 length, UTF-8 bytes) in code order | u32 m
    | m x (u24 a, u24 b, u8 k, k x (u24 id, u8 score)), sorted by (a, b)
  MRT2 (1.90, needs app 1.90+; the engine reads it with mmap and builds nothing at open)
    "MRT2" | u32 n | u32 m
    | (n+1) x u32 start of each word inside the word section (the last one is the size of the section)
    | (n+1) x u32 first record of each first word a (the last one is m)
    | m x record: u16 b, 3 x (u16 id, u8 score); id 0xFFFF = empty slot, and the empty slots come last
    | n x (u8 length, UTF-8 bytes) in code order
    The records of a are sorted by b. The word ids are the same as in MRT1, so the same data gives the same hits in both formats.
    Limits: n <= 65535 words, at most 3 continuations per context (MRT1 files made by this project never have more).

Both readers return (words, ctx): words = list of bytes in code order, ctx = list of (a, b, [(id, score), ...]) sorted by (a, b).
They are STRICT: any detail out of order is an error (ValueError), so a file that the C++ reader accepts and this one does not
(or the opposite) is a bug to investigate.

Use:  from mrt_format import read_any, write1, write2, convert
"""
import struct

MAX_WORDS_2 = 65535
SLOTS_2 = 3
RECORD_2 = 2 + 3 * SLOTS_2
EMPTY = 0xFFFF


def _check_words(words):
    prev = None
    for w in words:
        if not isinstance(w, bytes) or len(w) > 255:
            raise ValueError("word too long or not bytes")
        if prev is not None and not prev < w:
            raise ValueError("words out of order or repeated")
        prev = w


def _check_ctx(n, ctx, max_k, id_limit):
    prev = None
    for a, b, c in ctx:
        if not (0 <= a < n and 0 <= b < n):
            raise ValueError("context id out of range")
        if prev is not None and not prev < (a, b):
            raise ValueError("contexts out of order or repeated")
        prev = (a, b)
        if len(c) > max_k:
            raise ValueError("%d continuations (the limit is %d)" % (len(c), max_k))
        for i, s in c:
            if not (0 <= i < n and i < id_limit and 0 <= s <= 255):
                raise ValueError("continuation id or score out of range")


# ------------------------------------------------------------------------------------------------ MRT1

def read1(d):
    if d[:4] != b"MRT1" or len(d) < 12:
        raise ValueError("not MRT1")
    n = struct.unpack_from(">I", d, 4)[0]
    p = 8
    words = []
    for _ in range(n):
        if p >= len(d):
            raise ValueError("truncated")
        ln = d[p]
        if p + 1 + ln > len(d):
            raise ValueError("truncated word")
        words.append(bytes(d[p + 1:p + 1 + ln]))
        p += 1 + ln
    _check_words(words)
    if p + 4 > len(d):
        raise ValueError("truncated")
    m = struct.unpack_from(">I", d, p)[0]
    p += 4
    ctx = []
    for _ in range(m):
        if p + 7 > len(d):
            raise ValueError("truncated context")
        a = int.from_bytes(d[p:p + 3], "big")
        b = int.from_bytes(d[p + 3:p + 6], "big")
        k = d[p + 6]
        p += 7
        if p + 4 * k > len(d):
            raise ValueError("truncated continuations")
        c = [(int.from_bytes(d[p + 4 * j:p + 4 * j + 3], "big"), d[p + 4 * j + 3]) for j in range(k)]
        p += 4 * k
        ctx.append((a, b, c))
    if p != len(d):
        raise ValueError("%d bytes after the end" % (len(d) - p))
    _check_ctx(n, ctx, 255, 1 << 24)
    return words, ctx


def write1(words, ctx):
    n = len(words)
    _check_words(words)
    _check_ctx(n, ctx, 255, 1 << 24)
    if n >= 1 << 24:
        raise ValueError("vocabulary too large for 24-bit ids")
    out = bytearray(b"MRT1")
    out += struct.pack(">I", n)
    for w in words:
        out.append(len(w))
        out += w
    out += struct.pack(">I", len(ctx))
    for a, b, c in ctx:
        out += a.to_bytes(3, "big") + b.to_bytes(3, "big")
        out.append(len(c))
        for i, s in c:
            out += i.to_bytes(3, "big")
            out.append(s)
    return bytes(out)


# ------------------------------------------------------------------------------------------------ MRT2

def read2(d):
    if d[:4] != b"MRT2" or len(d) < 12:
        raise ValueError("not MRT2")
    n, m = struct.unpack_from(">II", d, 4)
    if n > MAX_WORDS_2:
        raise ValueError("too many words")
    off_at = 12
    csr_at = off_at + 4 * (n + 1)
    rec_at = csr_at + 4 * (n + 1)
    blob_at = rec_at + RECORD_2 * m
    if blob_at > len(d):
        raise ValueError("truncated")
    blob_len = len(d) - blob_at
    offs = struct.unpack_from(">%dI" % (n + 1), d, off_at)
    csr = struct.unpack_from(">%dI" % (n + 1), d, csr_at)
    if offs[0] != 0 or offs[n] != blob_len:
        raise ValueError("word section does not match the size of the file")
    words = []
    for i in range(n):
        p = blob_at + offs[i]
        if offs[i] >= blob_len:
            raise ValueError("word outside the section")
        ln = d[p]
        if offs[i] + 1 + ln != offs[i + 1]:
            raise ValueError("word offsets do not fit")
        words.append(bytes(d[p + 1:p + 1 + ln]))
    _check_words(words)
    if csr[0] != 0 or csr[n] != m:
        raise ValueError("row table does not start at 0 or does not end at m")
    if any(csr[i] > csr[i + 1] for i in range(n)):
        raise ValueError("row table goes back")   # (with the ends fixed at 0 and m, no entry can go outside 0..m)
    ctx = []
    for a in range(n):
        lo, hi = csr[a], csr[a + 1]
        for r in range(lo, hi):
            p = rec_at + RECORD_2 * r
            b = struct.unpack_from(">H", d, p)[0]
            slots = []
            empty = False
            for j in range(SLOTS_2):
                i, s = struct.unpack_from(">HB", d, p + 2 + 3 * j)
                if i == EMPTY:
                    empty = True
                    if s != 0:
                        raise ValueError("empty slot with a score")
                    continue
                if empty:
                    raise ValueError("filled slot after an empty one")
                slots.append((i, s))
            ctx.append((a, b, slots))
    _check_ctx(n, ctx, SLOTS_2, EMPTY)
    return words, ctx


def write2(words, ctx):
    n = len(words)
    _check_words(words)
    if n > MAX_WORDS_2:
        raise ValueError("MRT2 holds up to %d words (this one has %d)" % (MAX_WORDS_2, n))
    _check_ctx(n, ctx, SLOTS_2, EMPTY)
    csr = [0] * (n + 1)
    for a, _b, _c in ctx:
        csr[a + 1] += 1
    for i in range(n):
        csr[i + 1] += csr[i]
    offs, p = [], 0
    for w in words:
        offs.append(p)
        p += 1 + len(w)
    offs.append(p)
    out = bytearray(b"MRT2") + struct.pack(">II", n, len(ctx))
    out += struct.pack(">%dI" % (n + 1), *offs)
    out += struct.pack(">%dI" % (n + 1), *csr)
    for _a, b, c in ctx:
        out += struct.pack(">H", b)
        for j in range(SLOTS_2):
            out += struct.pack(">HB", *c[j]) if j < len(c) else struct.pack(">HB", EMPTY, 0)
    for w in words:
        out.append(len(w))
        out += w
    return bytes(out)


# ------------------------------------------------------------------------------------------------ both

def read_any(d):
    if d[:4] == b"MRT1":
        return read1(d)
    if d[:4] == b"MRT2":
        return read2(d)
    raise ValueError("does not start with MRT1 or MRT2")


def version_of(d):
    return {b"MRT1": 1, b"MRT2": 2}.get(bytes(d[:4]), 0)


def convert(d, fmt):
    """Same data in the other format (or the same one, written again)."""
    words, ctx = read_any(d)
    return write2(words, ctx) if fmt == 2 else write1(words, ctx)
