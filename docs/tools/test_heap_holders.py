#!/usr/bin/env python3
"""Tests docs/tools/heap_holders.py (the reader of the memory map saved by the Advanced screen, MrHeap, build _86).

Run it from the project root:  python3 -I docs/tools/test_heap_holders.py

Part 1 makes a real heap dump with the JVM (a small program, compiled here, that holds objects in known ways: by a static variable, through
lists and maps, only by a weak reference, and a pair of classes named like the service of the keyboard) and checks the chains the tool prints.
Part 2 builds by hand a small dump in the format of Android (ids of 4 bytes, the records ART adds) and reads it.
"""
import os
import shutil
import struct
import subprocess
import sys
import tempfile

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import heap_holders as hh  # noqa: E402

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  %s | %s" % (name, extra))


LATIN = """package com.mrkeyboard.app;
public class LatinIME {
    public static LatinIME sInstance;
    public static java.util.ArrayList<Object> sLeaks = new java.util.ArrayList<Object>();
    byte[] pad = new byte[16];
}
"""
PROBE = """package t;
import java.lang.ref.WeakReference;
import java.util.*;
public class Probe {
    static class Target { byte[] pad = new byte[8]; }
    static class Wrapper { Object inner; Wrapper(Object o) { inner = o; } }
    public static List<Object> sList = new ArrayList<Object>();
    public static Map<String, Object> sMap = new HashMap<String, Object>();
    public static WeakReference<Target> sWeak;
    static void garbage() { sWeak = new WeakReference<Target>(new Target()); }
    public static void main(String[] a) throws Exception {
        sList.add(new Wrapper(new Target()));
        sMap.put("k", new Wrapper(new Wrapper(new Target())));
        garbage();
        com.mrkeyboard.app.LatinIME.sInstance = new com.mrkeyboard.app.LatinIME();
        com.mrkeyboard.app.LatinIME.sLeaks.add(new com.mrkeyboard.app.LatinIME());
        com.sun.management.HotSpotDiagnosticMXBean bean = java.lang.management.ManagementFactory.getPlatformMXBean(com.sun.management.HotSpotDiagnosticMXBean.class);
        bean.dumpHeap(a[0], false);
    }
}
"""


def hops(chain):
    return [h for _, h in chain]


tmp = tempfile.mkdtemp(prefix="heaptest")
try:
    src = os.path.join(tmp, "src")
    os.makedirs(os.path.join(src, "com", "mrkeyboard", "app"))
    os.makedirs(os.path.join(src, "t"))
    open(os.path.join(src, "com", "mrkeyboard", "app", "LatinIME.java"), "w").write(LATIN)
    open(os.path.join(src, "t", "Probe.java"), "w").write(PROBE)
    classes = os.path.join(tmp, "classes")
    os.makedirs(classes)
    r = subprocess.run(["javac", "-nowarn", "-d", classes, os.path.join(src, "com", "mrkeyboard", "app", "LatinIME.java"),
                        os.path.join(src, "t", "Probe.java")], capture_output=True, text=True)
    check("the probe program compiles", r.returncode == 0, r.stderr[-300:])
    dump = os.path.join(tmp, "probe.hprof")
    r = subprocess.run(["java", "-cp", classes, "t.Probe", dump], capture_output=True, text=True)
    check("the JVM writes a heap dump", r.returncode == 0 and os.path.getsize(dump) > 0, r.stderr[-300:])

    heap = hh.Heap(hh.load(dump))
    check("the dump is read: classes, instances and roots are found", len(heap.classes) > 100 and len(heap.instances) > 100 and len(heap.roots) > 10,
          (len(heap.classes), len(heap.instances), len(heap.roots)))
    found = heap.holders({"t.Probe$Target"})
    chains = sorted(found.values(), key=lambda c: -1 if c is None else len(c))
    check("three Targets are in the dump", len(found) == 3, len(found))
    check("one of them is held by nothing the roots reach (only a weak reference holds it): unreachable", chains[0] is None, chains[0])
    a_chain = chains[1]
    check("held by a static list: the class, the static variable, the list's array, the item, the wrapper's field",
          a_chain is not None and hops(a_chain) == ["class", "static sList", "elementData", "[0]", "inner"], a_chain and hops(a_chain))
    check("... and the first element says which class holds the static variable", a_chain is not None and a_chain[0][0] == "class t.Probe", a_chain and a_chain[0])
    b_chain = chains[2]
    check("held through a map and two wrappers: the static variable, then the 'value' of a node, then two 'inner'",
          b_chain is not None and hops(b_chain)[:2] == ["class", "static sMap"] and "value" in hops(b_chain) and hops(b_chain).count("inner") == 2,
          b_chain and hops(b_chain))
    check("the shortest chain is the one shown (the list is a shorter way than the map)", len(a_chain) < len(b_chain), (len(a_chain), len(b_chain)))

    text, found2 = hh.report(heap, ["com.mrkeyboard.app.LatinIME"])
    check("the report: two services, one in use and one held", "2 instance(s)" in text and text.count("in use") == 1 and text.count("HELD") == 1, text)
    check("... the held one shows the chain through the list of leaks", "static sLeaks" in text and "elementData" in text, text)
    text2, _ = hh.report(heap, ["t.Probe$Target"])
    check("the report names an unreachable one as such", "unreachable" in text2 and text2.count("HELD") == 2, text2)
    text3, _ = hh.report(heap, ["no.Such"])
    check("a class with no instance: 0 instances, no error", "no.Such: 0 instance(s)" in text3, text3)

    # the zip made by the app: the same dump inside a zip with one entry
    import zipfile
    zpath = os.path.join(tmp, "mr_heap.zip")
    with zipfile.ZipFile(zpath, "w", zipfile.ZIP_DEFLATED) as z:
        z.write(dump, "mr_heap.hprof")
    check("the zip of the app is read like the file", hh.load(zpath) == hh.load(dump))
finally:
    shutil.rmtree(tmp, ignore_errors=True)

# ---------------------------------------------------------------- part 2: a dump in the format of Android (ids of 4 bytes, ART records)


class Builder:
    """The records of an HPROF with ids of 4 bytes, as ART writes them."""

    def __init__(self):
        self.strings = []
        self.body = b""
        self.next_id = 0x1000

    def new_id(self):
        self.next_id += 8
        return self.next_id

    def string(self, text):
        sid = self.new_id()
        data = struct.pack(">I", sid) + text.encode()
        self.body += bytes([0x01]) + struct.pack(">II", 0, len(data)) + data
        return sid

    def load_class(self, cid, name_id):
        data = struct.pack(">IIII", 1, cid, 0, name_id)
        self.body += bytes([0x02]) + struct.pack(">II", 0, len(data)) + data

    def segment(self, sub):
        self.body += bytes([0x1C]) + struct.pack(">II", 0, len(sub)) + sub

    def file(self):
        return b"JAVA PROFILE 1.0.3\0" + struct.pack(">IQ", 4, 0) + self.body


def class_dump(cid, sup, statics, fields):
    out = struct.pack(">IIIIIIIII", cid, 0, sup, 0, 0, 0, 0, 0, 16) + struct.pack(">H", 0)
    out += struct.pack(">H", len(statics))
    for nid, ref in statics:
        out += struct.pack(">IB", nid, 2) + struct.pack(">I", ref)
    out += struct.pack(">H", len(fields))
    for nid, t in fields:
        out += struct.pack(">IB", nid, t)
    return bytes([0x20]) + out


def instance(oid, cid, data):
    return bytes([0x21]) + struct.pack(">IIII", oid, 0, cid, len(data)) + data


b = Builder()
n_service = b.string("com/mrkeyboard/app/LatinIME")
n_holder = b.string("com/mrkeyboard/app/MrHolder")
n_object = b.string("java/lang/Object")
n_ref = b.string("java/lang/ref/Reference")
f_inst = b.string("sInstance")
f_list = b.string("sOld")
f_next = b.string("mNext")
f_referent = b.string("referent")
c_service, c_holder, c_object, c_ref = b.new_id(), b.new_id(), b.new_id(), b.new_id()
for cid, nid in ((c_service, n_service), (c_holder, n_holder), (c_object, n_object), (c_ref, n_ref)):
    b.load_class(cid, nid)
o_current, o_old, o_weak, o_node = b.new_id(), b.new_id(), b.new_id(), b.new_id()
seg = struct.pack(">BIi", 0xFE, 2, 0)[:1] + struct.pack(">II", 2, n_object)       # HEAP_DUMP_INFO: heap type, name
seg += class_dump(c_object, 0, [], [])
seg += class_dump(c_ref, c_object, [], [(f_referent, 2)])
seg += class_dump(c_service, c_object, [(f_inst, o_current)], [(f_next, 2)])
seg += class_dump(c_holder, c_object, [], [(f_next, 2)])
seg += instance(o_current, c_service, struct.pack(">I", 0))                       # in use: reached by the static
seg += instance(o_old, c_service, struct.pack(">I", 0))                           # held by a node that a JNI global holds
seg += instance(o_node, c_holder, struct.pack(">I", o_old))
seg += instance(o_weak, c_ref, struct.pack(">I", o_old))                          # a reference to the old one: it does not hold it
seg += bytes([hh.ROOT_JNI_GLOBAL]) + struct.pack(">II", o_node, 0x1)               # JNI global: id, ref id
seg += bytes([hh.ROOT_VM_INTERNAL]) + struct.pack(">I", o_weak)                    # the reference is a root of the VM, not a holder of the old
seg += bytes([hh.ROOT_JNI_MONITOR]) + struct.pack(">III", o_weak, 1, 2)
seg += bytes([hh.ROOT_INTERNED_STRING]) + struct.pack(">I", o_weak)
seg += bytes([hh.ROOT_JAVA_FRAME]) + struct.pack(">III", o_weak, 1, 0)
seg += bytes([hh.PRIM_ARRAY_NODATA]) + struct.pack(">IIIB", b.new_id(), 0, 4, 10)  # an array whose data is not in the dump
b.segment(seg)
heap2 = hh.Heap(b.file())
check("a dump with ids of 4 bytes and the records of ART is read", heap2.id_size == 4 and len(heap2.instances) == 4 and len(heap2.classes) == 4,
      (heap2.id_size, len(heap2.instances), len(heap2.classes)))
check("the roots of ART are found (JNI global, VM internal, JNI monitor, interned string, stack frame)", len(heap2.roots) == 5, heap2.roots)
t, f = hh.report(heap2, ["com.mrkeyboard.app.LatinIME"])
check("two services: the one reached by the static is in use", "2 instance(s)" in t and t.count("in use") == 1, t)
check("the other is held through the node that the JNI global holds, not through the reference", t.count("HELD") == 1 and "mNext" in t
      and "root (JNI global)" in t and "Reference" not in t.split("HELD", 1)[1], t)

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
