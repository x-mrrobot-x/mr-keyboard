#!/usr/bin/env python3
"""Tests smali_regcheck.py: the five errors it must report and the code it must leave alone.

Run it from the project root:  python3 -I docs/tools/test_smali_regcheck.py

It writes small smali classes in a temporary folder, runs the real script on them (as the CI does) and reads what it prints and its exit code. For
each rule there is a broken case (it must be reported, with the right message) and a good one (it must not be): the register read without a value, the
call to a method that does not exist (declared, inherited from the project, from an interface, or a chain that leaves for the framework), the register
above the limit of the format, more than 5 registers in a plain invoke (a wide argument counts 2) and the field that does not exist (the rule added
in 1.93.0: a `sget` left behind by a cleanup that removed the field), with the field declared, inherited and read through the framework class.
The --base mode (only what is new) is tested too. The last check runs the script on the real `smali/` folder: it must stay clean.
"""
import os
import subprocess
import sys
import tempfile

ROOT = os.getcwd()
TOOL = os.path.join(ROOT, "docs", "tools", "smali_regcheck.py")

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


def cls(name, body, sup="Ljava/lang/Object;", ifs=(), kind="class"):
    """The text of a smali class. `name` is the short name (com/t/Name)."""
    head = ".class public %s Lcom/t/%s;\n.super %s\n" % ("interface abstract" if kind == "interface" else "", name, sup)
    head = head.replace("public  ", "public ")
    for i in ifs:
        head += ".implements %s\n" % i
    return head + "\n" + body + "\n"


def method(name, sig, insns, locals_n=2, static=True, flags="public"):
    return ".method %s%s %s%s\n    .locals %d\n%s\n.end method\n" % (
        flags, " static" if static else "", name, sig, locals_n, "\n".join("    " + x for x in insns))


def write_tree(files):
    root = tempfile.mkdtemp(prefix="smalitest_")
    for rel, text in files.items():
        p = os.path.join(root, "com", "t", rel + ".smali")
        os.makedirs(os.path.dirname(p), exist_ok=True)
        open(p, "w", encoding="utf-8").write(text)
    return root


def run(files, extra=()):
    root = write_tree(files)
    r = subprocess.run([sys.executable, "-I", TOOL, root] + list(extra), capture_output=True, text=True)
    return r.returncode, r.stdout


def clean(code, out):
    return code == 0 and "methods with a problem: 0" in out


def reported(code, out, what):
    return code == 1 and what in out


# ---- rule 1: a register read without a value
code, out = run({"A": cls("A", method("m", "()V", ["invoke-static {v1}, Lcom/t/B;->use(I)V", "return-void"])),
                 "B": cls("B", method("use", "(I)V", ["return-void"], locals_n=0))})
check("1: a register read before any value is reported", reported(code, out, "v1 read without a value"), out)

code, out = run({"A": cls("A", method("m", "()V", ["const/4 v1, 0x1", "invoke-static {v1}, Lcom/t/B;->use(I)V", "return-void"])),
                 "B": cls("B", method("use", "(I)V", ["return-void"], locals_n=0))})
check("1: a register that has its value is clean", clean(code, out), out)

one_branch = ["if-eqz p0, :skip", "const/4 v1, 0x1", ":skip", "invoke-static {v1}, Lcom/t/B;->use(I)V", "return-void"]
code, out = run({"A": cls("A", method("m", "(I)V", one_branch)), "B": cls("B", method("use", "(I)V", ["return-void"], locals_n=0))})
check("1: a value given on one branch only is reported", reported(code, out, "v1 read without a value"), out)

# ---- rule 2: a call to a method that does not exist
code, out = run({"A": cls("A", method("m", "()V", ["invoke-static {}, Lcom/t/B;->gone()V", "return-void"], locals_n=0)),
                 "B": cls("B", method("here", "()V", ["return-void"], locals_n=0))})
check("2: a call to a method the class does not have is reported", reported(code, out, "method does not exist: Lcom/t/B;->gone()V"), out)

code, out = run({"A": cls("A", method("m", "()V", ["invoke-static {}, Lcom/t/B;->here()V", "return-void"], locals_n=0)),
                 "B": cls("B", method("here", "()V", ["return-void"], locals_n=0))})
check("2: a call to a declared method is clean", clean(code, out), out)

code, out = run({"A": cls("A", method("m", "()V", ["invoke-static {}, Lcom/t/C;->here()V", "return-void"], locals_n=0)),
                 "B": cls("B", method("here", "()V", ["return-void"], locals_n=0)),
                 "C": cls("C", "", sup="Lcom/t/B;")})
check("2: a method inherited from a project class is found", clean(code, out), out)

iface = {"I": cls("I", ".method public abstract here()V\n.end method\n", kind="interface"), "C": cls("C", "", ifs=["Lcom/t/I;"])}
code, out = run(dict(iface, A=cls("A", method("m", "()V", ["invoke-static {}, Lcom/t/C;->here()V", "return-void"], locals_n=0))))
check("2: a method of an interface of the project is found", clean(code, out), out)
code, out = run(dict(iface, A=cls("A", method("m", "()V", ["invoke-static {}, Lcom/t/C;->nothere()V", "return-void"], locals_n=0))))
check("2: ...and a method that neither the class nor its interface has is reported (the fixture is read)", reported(code, out, "nothere"), out)
code, out = run({"A": cls("A", method("m", "()V", ["invoke-static {}, Lcom/t/C;->nothere()V", "return-void"], locals_n=0)),
                 "B": cls("B", method("here", "()V", ["return-void"], locals_n=0)), "C": cls("C", "", sup="Lcom/t/B;")})
check("2: ...and the same through a superclass of the project", reported(code, out, "nothere"), out)

code, out = run({"A": cls("A", method("m", "()V", ["invoke-static {}, Lcom/t/C;->anything()V", "return-void"], locals_n=0)),
                 "C": cls("C", "", sup="Landroid/app/Activity;")})
check("2: a chain that leaves for the framework is not reported (it may be there)", clean(code, out), out)

# ---- rule 3: a register above the limit of the format
many = ["invoke-static {p0}, Lcom/t/B;->use(I)V", "return-void"]
code, out = run({"A": cls("A", method("m", "(I)V", many, locals_n=17)), "B": cls("B", method("use", "(I)V", ["return-void"], locals_n=0))})
check("3: p0 = v17 in a plain invoke is reported, with the /range hint", reported(code, out, "over the limit") and "invoke-static/range" in out, out)

ranged = ["invoke-static/range {p0 .. p0}, Lcom/t/B;->use(I)V", "return-void"]
code, out = run({"A": cls("A", method("m", "(I)V", ranged, locals_n=17)), "B": cls("B", method("use", "(I)V", ["return-void"], locals_n=0))})
check("3: the same call in the /range form is clean", clean(code, out), out)

code, out = run({"A": cls("A", method("m", "()V", ["const-string v200, \"x\"", "return-void"], locals_n=201))})
check("3: an 8-bit instruction (const-string) may use v200", clean(code, out), out)

# ---- rule 4: more than 5 registers in a plain invoke
six = ["const/4 v0, 0x0", "const/4 v1, 0x0", "const/4 v2, 0x0", "const/4 v3, 0x0", "const/4 v4, 0x0", "const/4 v5, 0x0"]
code, out = run({"A": cls("A", method("m", "()V", six + ["invoke-static {v0, v1, v2, v3, v4, v5}, Lcom/t/B;->use6(IIIIII)V", "return-void"], locals_n=6)),
                 "B": cls("B", method("use6", "(IIIIII)V", ["return-void"], locals_n=0))})
check("4: six registers in a plain invoke are reported", reported(code, out, "6 registers"), out)

code, out = run({"A": cls("A", method("m", "()V", six + ["invoke-static/range {v0 .. v5}, Lcom/t/B;->use6(IIIIII)V", "return-void"], locals_n=6)),
                 "B": cls("B", method("use6", "(IIIIII)V", ["return-void"], locals_n=0))})
check("4: six registers in the /range form are clean", clean(code, out), out)

code, out = run({"A": cls("A", method("m", "()V", six[:5] + ["invoke-static {v0, v1, v2, v3, v4}, Lcom/t/B;->use5(IIIII)V", "return-void"], locals_n=5)),
                 "B": cls("B", method("use5", "(IIIII)V", ["return-void"], locals_n=0))})
check("4: five registers in a plain invoke are clean", clean(code, out), out)

# ---- rule 5: a field that does not exist
field_int = ".field public static f:I = 0x1\n"
code, out = run({"A": cls("A", method("m", "()V", ["sget v0, Lcom/t/B;->gone:I", "return-void"], locals_n=1)),
                 "B": cls("B", field_int)})
check("5: an sget of a field the class does not declare is reported", reported(code, out, "field does not exist: Lcom/t/B;->gone:I"), out)

code, out = run({"A": cls("A", method("m", "()V", ["const/4 v0, 0x1", "sput v0, Lcom/t/B;->gone:I", "return-void"], locals_n=1)),
                 "B": cls("B", field_int)})
check("5: an sput of a field that was removed is reported (the <clinit> case)", reported(code, out, "field does not exist"), out)

code, out = run({"A": cls("A", method("m", "(Lcom/t/B;)V", ["iget v0, p1, Lcom/t/B;->gone:I", "return-void"], locals_n=1, static=False)),
                 "B": cls("B", field_int)})
check("5: an iget of a missing instance field is reported", reported(code, out, "field does not exist"), out)

code, out = run({"A": cls("A", method("m", "()V", ["sget v0, Lcom/t/B;->f:I", "return-void"], locals_n=1)), "B": cls("B", field_int)})
check("5: a declared field is clean", clean(code, out), out)

code, out = run({"A": cls("A", method("m", "()V", ["sget v0, Lcom/t/C;->f:I", "return-void"], locals_n=1)),
                 "B": cls("B", field_int), "C": cls("C", "", sup="Lcom/t/B;")})
check("5: a field inherited from a project class is clean", clean(code, out), out)

code, out = run({"A": cls("A", method("m", "()V", ["sget v0, Lcom/t/C;->f:I", "return-void"], locals_n=1)),
                 "C": cls("C", "", sup="Landroid/app/PreferenceActivity;")})
check("5: a field read on a project class that only extends the framework is reported", reported(code, out, "field does not exist"), out)

code, out = run({"A": cls("A", method("m", "()V", ["sget v0, Landroid/view/View;->NO_ID:I", "return-void"], locals_n=1))})
check("5: a field of a framework class (not in the project) is not checked", clean(code, out), out)

# ---- --base: only what is new is reported
bad = {"A": cls("A", method("m", "()V", ["sget v0, Lcom/t/B;->gone:I", "return-void"], locals_n=1)), "B": cls("B", field_int)}
base_root = write_tree(bad)
cur = dict(bad)
cur["D"] = cls("D", method("n", "()V", ["sget v0, Lcom/t/B;->gone2:I", "return-void"], locals_n=1))
cur_root = write_tree(cur)
r = subprocess.run([sys.executable, "-I", TOOL, cur_root, "--base", base_root], capture_output=True, text=True)
check("--base: only the problem that is new is reported", r.returncode == 1 and "gone2" in r.stdout and ":gone:I" not in r.stdout
      and "methods with a problem: 1" in r.stdout, r.stdout)
r = subprocess.run([sys.executable, "-I", TOOL, base_root, "--base", base_root], capture_output=True, text=True)
check("--base: a tree compared with itself is clean", r.returncode == 0, r.stdout)

# ---- the real smali of the project stays clean
real = os.path.join(ROOT, "smali")
if os.path.isdir(real):
    r = subprocess.run([sys.executable, "-I", TOOL, real], capture_output=True, text=True)
    check("the real smali/ folder has no problem", r.returncode == 0 and "methods with a problem: 0" in r.stdout, r.stdout[-300:])

print("ALL OK (%d checks)" % ok if fails == 0 else "%d FAILURE(S) of %d" % (fails, ok + fails))
sys.exit(1 if fails else 0)
