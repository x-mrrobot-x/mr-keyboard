#!/usr/bin/env python3
"""Reads a heap dump (HPROF) and prints, for every instance of the classes asked for, the shortest chain of references from a root of the
heap to it: what holds it alive.

Made for the row "Save the memory map (test)" of the Advanced screen (MrHeap, build _86), which writes the dump of the keyboard's process
in a zip, but it reads any HPROF file, the one of Android (ART: "JAVA PROFILE 1.0.3", ids of 4 bytes) and the one of the JVM (1.0.2).

    python3 docs/tools/heap_holders.py mr_heap.zip
    python3 docs/tools/heap_holders.py mr_heap.hprof --class com.mrkeyboard.app.LatinIME --class com.mrkeyboard.app.LatinKeyboardView

By default it looks for the service (com.mrkeyboard.app.LatinIME) and the input view (com.mrkeyboard.app.LatinKeyboardView). The service that
is reached straight from the static LatinIME.sInstance, and the input view that is reached from KeyboardSwitcher.sInstance.mInputView, are the
ones in use ("in use"); every other one is what stayed behind ("HELD"), and the chain says what holds it. The references that do not keep an object alive are left out of the chains: the referent of a java.lang.ref.Reference (weak,
soft, phantom, and the finalizer references). The objects that no root reaches (garbage that the collector had not taken when the dump was
written) are reported as unreachable. The chain is the shortest one: where two things hold the same object, the one nearer to a root is shown.

The roots are the ones the dump lists (JNI globals and locals, the stacks of the threads, the thread objects, monitors, the interned strings,
the sticky classes, the objects of the VM) and, for every class, its static variables.

Needs only the standard library. It reads the whole file in memory (a dump of the keyboard is some tens of MB).
"""
import argparse
import collections
import io
import struct
import sys
import zipfile

DEFAULT_CLASSES = ("com.mrkeyboard.app.LatinIME", "com.mrkeyboard.app.LatinKeyboardView")
# how the instance in use is reached: from the class of the first element, through these references, one after the other
IN_USE = {
    "com.mrkeyboard.app.LatinIME": ("class com.mrkeyboard.app.LatinIME", ["static sInstance"]),
    "com.mrkeyboard.app.LatinKeyboardView": ("class com.mrkeyboard.app.KeyboardSwitcher", ["static sInstance", "mInputView"]),
}

# sub-record tags of a heap dump segment
ROOT_UNKNOWN, ROOT_JNI_GLOBAL, ROOT_JNI_LOCAL, ROOT_JAVA_FRAME, ROOT_NATIVE_STACK, ROOT_STICKY_CLASS = 0xFF, 0x01, 0x02, 0x03, 0x04, 0x05
ROOT_THREAD_BLOCK, ROOT_MONITOR_USED, ROOT_THREAD_OBJECT = 0x06, 0x07, 0x08
CLASS_DUMP, INSTANCE_DUMP, OBJ_ARRAY_DUMP, PRIM_ARRAY_DUMP = 0x20, 0x21, 0x22, 0x23
# the ones that Android adds
HEAP_DUMP_INFO, ROOT_INTERNED_STRING, ROOT_FINALIZING, ROOT_DEBUGGER, ROOT_REFERENCE_CLEANUP = 0xFE, 0x89, 0x8A, 0x8B, 0x8C
ROOT_VM_INTERNAL, ROOT_JNI_MONITOR, UNREACHABLE, PRIM_ARRAY_NODATA = 0x8D, 0x8E, 0x90, 0xC3

ROOT_NAMES = {ROOT_UNKNOWN: "root (unknown)", ROOT_JNI_GLOBAL: "root (JNI global)", ROOT_JNI_LOCAL: "root (JNI local)",
              ROOT_JAVA_FRAME: "root (stack frame)", ROOT_NATIVE_STACK: "root (native stack)", ROOT_STICKY_CLASS: "root (sticky class)",
              ROOT_THREAD_BLOCK: "root (thread block)", ROOT_MONITOR_USED: "root (monitor)", ROOT_THREAD_OBJECT: "root (thread)",
              ROOT_INTERNED_STRING: "root (interned string)", ROOT_FINALIZING: "root (finalizing)", ROOT_DEBUGGER: "root (debugger)",
              ROOT_REFERENCE_CLEANUP: "root (reference cleanup)", ROOT_VM_INTERNAL: "root (VM internal)", ROOT_JNI_MONITOR: "root (JNI monitor)"}

# the size in bytes of a value of each basic type (2 is an object: the size of an id)
TYPE_SIZE = {4: 1, 5: 2, 6: 4, 7: 8, 8: 1, 9: 2, 10: 4, 11: 8}


class HeapError(Exception):
    pass


class Heap:
    def __init__(self, data):
        self.data = data
        self.strings = {}          # string id -> text
        self.class_names = {}      # class object id -> name (as in the dump: with dots)
        self.classes = {}          # class object id -> (super id, [(name id, type)], [(name id, type, value)])
        self.instances = {}        # object id -> (class id, offset of its data, length)
        self.arrays = {}           # object id -> (offset of its elements, count, class id)
        self.roots = []            # (object id, tag)
        self.id_size = 4
        self._parse()

    # ---------------------------------------------------------------- reading
    def _id(self, pos):
        return int.from_bytes(self.data[pos:pos + self.id_size], "big")

    def _parse(self):
        d = self.data
        end_name = d.index(b"\0")
        if not d.startswith(b"JAVA PROFILE"):
            raise HeapError("not an HPROF file (it starts with %r)" % d[:16])
        self.id_size = struct.unpack(">I", d[end_name + 1:end_name + 5])[0]
        if self.id_size not in (4, 8):
            raise HeapError("ids of %d bytes" % self.id_size)
        pos = end_name + 1 + 4 + 8
        names = {}                 # load class: class id -> name string id
        while pos < len(d):
            tag = d[pos]
            length = struct.unpack(">I", d[pos + 5:pos + 9])[0]
            body = pos + 9
            if tag == 0x01:        # STRING
                self.strings[self._id(body)] = d[body + self.id_size:body + length].decode("utf-8", "replace")
            elif tag == 0x02:      # LOAD CLASS: serial u4, class id, stack serial u4, name string id
                names[self._id(body + 4)] = self._id(body + 4 + self.id_size + 4)
            elif tag in (0x0C, 0x1C):
                self._segment(body, body + length)
            pos = body + length
        for cid, nid in names.items():
            self.class_names[cid] = self.strings.get(nid, "?").replace("/", ".")

    def _segment(self, pos, end):
        d, n = self.data, self.id_size
        while pos < end:
            tag = d[pos]
            pos += 1
            if tag in (ROOT_UNKNOWN, ROOT_STICKY_CLASS, ROOT_MONITOR_USED, ROOT_INTERNED_STRING, ROOT_FINALIZING, ROOT_DEBUGGER,
                       ROOT_REFERENCE_CLEANUP, ROOT_VM_INTERNAL, UNREACHABLE):
                self.roots.append((self._id(pos), tag))
                pos += n
            elif tag == ROOT_JNI_GLOBAL:
                self.roots.append((self._id(pos), tag))
                pos += 2 * n
            elif tag in (ROOT_JNI_LOCAL, ROOT_JAVA_FRAME, ROOT_THREAD_OBJECT, ROOT_JNI_MONITOR):
                self.roots.append((self._id(pos), tag))
                pos += n + 8
            elif tag in (ROOT_NATIVE_STACK, ROOT_THREAD_BLOCK):
                self.roots.append((self._id(pos), tag))
                pos += n + 4
            elif tag == HEAP_DUMP_INFO:
                pos += 4 + n
            elif tag == CLASS_DUMP:
                pos = self._class_dump(pos)
            elif tag == INSTANCE_DUMP:
                oid = self._id(pos)
                cid = self._id(pos + n + 4)
                length = struct.unpack(">I", d[pos + 2 * n + 4:pos + 2 * n + 8])[0]
                self.instances[oid] = (cid, pos + 2 * n + 8, length)
                pos += 2 * n + 8 + length
            elif tag == OBJ_ARRAY_DUMP:
                oid = self._id(pos)
                count = struct.unpack(">I", d[pos + n + 4:pos + n + 8])[0]
                cid = self._id(pos + n + 8)
                self.arrays[oid] = (pos + 2 * n + 8, count, cid)
                pos += 2 * n + 8 + count * n
            elif tag == PRIM_ARRAY_DUMP:
                count = struct.unpack(">I", d[pos + n + 4:pos + n + 8])[0]
                pos += n + 9 + count * TYPE_SIZE[d[pos + n + 8]]
            elif tag == PRIM_ARRAY_NODATA:
                pos += n + 9
            else:
                raise HeapError("unknown sub-record 0x%02X at byte %d" % (tag, pos - 1))

    def _class_dump(self, pos):
        d, n = self.data, self.id_size
        cid = self._id(pos)
        sup = self._id(pos + n + 4)
        pos += 7 * n + 4 + 4           # id, stack, super, loader, signers, domain, two reserved, instance size
        pool = struct.unpack(">H", d[pos:pos + 2])[0]
        pos += 2
        for _ in range(pool):
            pos += 2
            t = d[pos]
            pos += 1 + (n if t == 2 else TYPE_SIZE[t])
        count = struct.unpack(">H", d[pos:pos + 2])[0]
        pos += 2
        statics = []
        for _ in range(count):
            nid = self._id(pos)
            t = d[pos + n]
            pos += n + 1
            size = n if t == 2 else TYPE_SIZE[t]
            statics.append((nid, t, self._id(pos) if t == 2 else None))
            pos += size
        count = struct.unpack(">H", d[pos:pos + 2])[0]
        pos += 2
        fields = []
        for _ in range(count):
            fields.append((self._id(pos), d[pos + n]))
            pos += n + 1
        self.classes[cid] = (sup, fields, statics)
        return pos

    # ---------------------------------------------------------------- references
    def name(self, cid):
        return self.class_names.get(cid, "class@%x" % cid)

    def field_name(self, nid):
        return self.strings.get(nid, "?")

    def refs(self, oid):
        """The objects that this one holds: (label, id). The referent of a Reference is not one of them (it does not keep the object alive)."""
        out = []
        n = self.id_size
        if oid in self.instances:
            cid, off, length = self.instances[oid]
            pos = off
            while cid and cid in self.classes:
                sup, fields, _ = self.classes[cid]
                for nid, t in fields:
                    if t == 2:
                        ref = self._id(pos)
                        pos += n
                        if ref and not (self.field_name(nid) == "referent" and self.name(cid) == "java.lang.ref.Reference"):
                            out.append((self.field_name(nid), ref))
                    else:
                        pos += TYPE_SIZE[t]
                cid = sup
        elif oid in self.arrays:
            off, count, _ = self.arrays[oid]
            for i in range(count):
                ref = self._id(off + i * n)
                if ref:
                    out.append(("[%d]" % i, ref))
        elif oid in self.classes:
            for nid, t, value in self.classes[oid][2]:
                if t == 2 and value:
                    out.append(("static " + self.field_name(nid), value))
        return out

    def class_of(self, oid):
        if oid in self.instances:
            return self.instances[oid][0]
        if oid in self.arrays:
            return self.arrays[oid][2]
        return None

    def describe(self, oid):
        if oid in self.classes:
            return "class " + self.name(oid)
        cid = self.class_of(oid)
        return "%s@%x" % (self.name(cid), oid) if cid else "object@%x" % oid

    # ---------------------------------------------------------------- search
    def holders(self, wanted):
        """For every instance of the classes in `wanted` (names): the shortest chain from a root, as a list of (description, how it holds the
        next one), or None when no root reaches it. Returns {object id: chain}."""
        targets = {oid for oid, (cid, _, _) in self.instances.items() if self.name(cid) in wanted}
        parent = {}                      # object id -> (parent id or None, how the parent holds it / what root it is)
        queue = collections.deque()
        for oid, tag in self.roots:
            if oid not in parent and (oid in self.instances or oid in self.arrays or oid in self.classes):
                parent[oid] = (None, ROOT_NAMES.get(tag, "root"))
                queue.append(oid)
        for cid in self.classes:         # the static variables of every class are roots too
            if cid not in parent:
                parent[cid] = (None, "class")
                queue.append(cid)
        found = {}
        while queue and len(found) < len(targets):
            oid = queue.popleft()
            if oid in targets:
                found[oid] = True
            for label, ref in self.refs(oid):
                if ref not in parent and (ref in self.instances or ref in self.arrays or ref in self.classes):
                    parent[ref] = (oid, label)
                    queue.append(ref)
        out = {}
        for t in targets:
            if t not in parent:
                out[t] = None
                continue
            chain = []
            cur = t
            while cur is not None:
                par, how = parent[cur]
                chain.append((self.describe(cur), how))
                cur = par
            chain.reverse()
            # chain[i] = (what it is, how it was reached from chain[i-1]); the first one says which root
            out[t] = chain
        return out


def load(path):
    if path.endswith(".zip") or zipfile.is_zipfile(path):
        with zipfile.ZipFile(path) as z:
            names = [n for n in z.namelist() if n.endswith(".hprof")]
            if not names:
                raise HeapError("no .hprof in the zip")
            return z.read(names[0])
    with open(path, "rb") as f:
        return f.read()


def format_chain(chain):
    lines = []
    for i, (what, how) in enumerate(chain):
        if i == 0:
            lines.append("    %s  [%s]" % (what, how))
        else:
            lines.append("    -> %s  (%s)" % (what, how))
    return "\n".join(lines)


def report(heap, wanted):
    found = heap.holders(set(wanted))
    out = io.StringIO()
    by_class = collections.defaultdict(list)
    for oid, chain in found.items():
        by_class[heap.name(heap.class_of(oid))].append((oid, chain))
    for name in wanted:
        items = sorted(by_class.get(name, []), key=lambda x: x[0])
        out.write("%s: %d instance(s)\n" % (name, len(items)))
        for oid, chain in items:
            if chain is None:
                out.write("  @%x  unreachable (garbage that the collector had not taken)\n" % oid)
                continue
            start, hows = IN_USE.get(name, (None, None))
            in_use = chain[0][0] == start and [h for _, h in chain[1:]] == hows
            out.write("  @%x  %s\n%s\n" % (oid, "in use" if in_use else "HELD", format_chain(chain)))
    return out.getvalue(), found


def main(argv):
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("file", help="the .hprof or the zip made by the app")
    ap.add_argument("--class", dest="classes", action="append", help="a class to look for (default: the service and the input view)")
    args = ap.parse_args(argv)
    heap = Heap(load(args.file))
    print("%d classes, %d instances, %d arrays, %d roots, ids of %d bytes" % (len(heap.classes), len(heap.instances), len(heap.arrays),
                                                                             len(heap.roots), heap.id_size))
    text, _ = report(heap, args.classes or list(DEFAULT_CLASSES))
    print(text)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
