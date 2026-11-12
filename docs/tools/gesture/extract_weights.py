#!/usr/bin/env python3
"""Takes the weights of the FUTO Swipe encoder (honorable_sturgeon) out of the file FUTO publishes (an ExecuTorch .pte) and
writes them in the plain file the native engine reads (gesture/encoder.bin; reader in engine/src/mr_gesture_nn.cpp).

Usage: python3 extract_weights.py <model_fp32.pte> <out.bin>
       python3 extract_weights.py <model_fp32.pte> --check gesture/encoder.bin     (says whether the file is what this tool writes)

The source file: https://huggingface.co/futo-org/futo-swipe, revision 315d42583233b71d75665d076cfa2f2c7c6f43ad,
honorable_sturgeon/model_fp32.pte (sha256 725242bab5d14345e96ff214e8de2bfbc1f962c232d320df9c24cb82ffd1fbaf).

Output (little-endian):
    8 bytes  "MRSWENC1"
    u32      number of tensors
    per tensor: u8 name length, name (ASCII), u8 number of dimensions, u32 x dimensions, f32 x product(dimensions)

No value is changed: each tensor is the bytes the .pte holds, only given a short name and the shape the C++ code indexes
(reshape, never a transpose or a sum). The weights stay under the FUTO Model Weights License 1.0
(gesture/LICENSE-FUTO-Model-Weights.md). The `executorch` package is needed only to read the .pte container
(pip: torch (CPU), then executorch; flatbuffers, ruamel.yaml, pyyaml, tabulate, packaging); the app does not use it.
"""
import hashlib, json, os, re, struct, subprocess, sys, tempfile
import numpy as np
import executorch.exir
from executorch.exir._serialize._program import deserialize_pte_binary

SP = os.path.dirname(os.path.dirname(executorch.exir.__file__))
FLATC = os.path.join(SP, "data", "bin", "flatc")
XSCHEMA = os.path.join(SP, "backends", "xnnpack", "serialization", "schema.fbs")


def xnn_json(blob, tmp, i):
    """The graph of one XNNPACK delegate as JSON (the weights are named there)."""
    if blob[4:8] == b"XH00":
        fb_off, fb_size = struct.unpack_from("<II", blob, 10)
        blob = blob[fb_off:fb_off + fb_size]
    p = os.path.join(tmp, "d%02d.fb" % i)
    open(p, "wb").write(blob)
    subprocess.run([FLATC, "--json", "--strict-json", "--defaults-json", "--raw-binary", "-o", tmp, XSCHEMA, "--", p], check=True)
    txt = open(os.path.join(tmp, "d%02d.json" % i)).read()
    txt = re.sub(r'(?<=[:\s\[,])(-?)inf(?=[,\s\]}])', lambda m: m.group(1) + "1e999", txt)     # flatc writes inf unquoted
    return json.loads(txt)


def read_named(pte_path):
    """Returns {name without the hash: array in the shape XNNPACK stored} and the 10 GRN vectors (constants of the program)."""
    r = deserialize_pte_binary(open(pte_path, "rb").read())
    prog = r.program
    ep = prog.execution_plan[0]
    nd = r.named_data
    named = {}
    with tempfile.TemporaryDirectory() as tmp:
        for i, d in enumerate(ep.delegates):
            j = xnn_json(bytes(prog.backend_delegate_data[d.processed.index].data), tmp, i)
            cd = j["constant_data"]
            for v in j["xvalues"]:
                u = v["xvalue_union"]
                u = u.get("tensor_value", u)
                cb = u.get("constant_buffer_idx", 0)
                if not cb:
                    continue
                key = cd[cb]["named_key"]
                name = key[:-65]            # takes "_<sha256>" off
                e = nd.pte_data[key]
                buf = nd.buffers[e.buffer_index if hasattr(e, "buffer_index") else e]
                data = bytes(buf.buffer if hasattr(buf, "buffer") else buf)
                arr = np.frombuffer(data, "<f4").reshape(u["dims"]).copy()
                if name in named:
                    assert np.array_equal(named[name], arr), name
                named[name] = arr
    consts = [bytes(b.storage) for b in prog.constant_buffer]
    grn = []
    for v in ep.values:
        t = v.val
        if type(t).__name__ == "Tensor" and t.data_buffer_idx and list(t.sizes) == [1, 256, 1]:
            grn.append(np.frombuffer(consts[t.data_buffer_idx], "<f4").copy())
    assert len(grn) == 10, len(grn)
    return named, grn


def to_tensors(named, grn):
    P = "p_encoder_"
    T = {}
    for n in ("d1_x", "d1_y", "d2_x", "d2_y", "d1_curv"):
        T["savgol." + n] = named[P + "savgol_%s_weight" % n].reshape(7)
    T["stem.w"] = named[P + "backbone_input_conv_weight"].reshape(128, 7, 8)       # [output][tap][input]
    T["stem.b"] = named[P + "backbone_input_conv_bias"]
    for b in range(5):
        q = P + "backbone_blocks_%d_" % b
        T["b%d.dw.w" % b] = named[q + "dwconv_weight"].reshape(7, 128)              # [tap][channel]
        T["b%d.dw.b" % b] = named[q + "dwconv_bias"]
        T["b%d.pw1.w" % b] = named[q + "pwconv1_weight"].reshape(512, 128)
        T["b%d.pw1.b" % b] = named[q + "pwconv1_bias"]
        T["b%d.grn.g" % b] = grn[2 * b]
        T["b%d.grn.b" % b] = grn[2 * b + 1]
        T["b%d.pw2.w" % b] = named[q + "pwconv2_weight"].reshape(128, 256)
        T["b%d.pw2.b" % b] = named[q + "pwconv2_bias"]
        T["b%d.se1.w" % b] = named[q + "se_fc1_weight"]
        T["b%d.se1.b" % b] = named[q + "se_fc1_bias"]
        T["b%d.se2.w" % b] = named[q + "se_fc2_weight"]
        T["b%d.se2.b" % b] = named[q + "se_fc2_bias"]
    T["adapter.w"] = named[P + "adapter_0_weight"].reshape(256, 2, 128)            # [output][tap][input]
    T["adapter.b"] = named[P + "adapter_0_bias"]
    T["lambda.w"] = named[P + "spatial_head_lambda_proj_weight"].reshape(256)
    T["lambda.b"] = named[P + "spatial_head_lambda_proj_bias"]
    T["coeff.w"] = named[P + "spatial_head_coeff_proj_weight"]
    T["coeff.b"] = named[P + "spatial_head_coeff_proj_bias"]
    return T


def to_bytes(T):
    out = [b"MRSWENC1", struct.pack("<I", len(T))]
    for name, a in T.items():
        nb = name.encode("ascii")
        out.append(struct.pack("<B", len(nb)) + nb)
        out.append(struct.pack("<B", a.ndim))
        out.append(struct.pack("<%dI" % a.ndim, *a.shape))
        out.append(np.ascontiguousarray(a, "<f4").tobytes())
    return b"".join(out)


if __name__ == "__main__":
    if len(sys.argv) not in (3, 4) or (len(sys.argv) == 4 and sys.argv[2] != "--check"):
        sys.exit(__doc__)
    named, grn = read_named(sys.argv[1])
    T = to_tensors(named, grn)
    data = to_bytes(T)
    print("tensors: %d, values: %d, bytes: %d, sha256: %s" % (len(T), sum(a.size for a in T.values()), len(data), hashlib.sha256(data).hexdigest()))
    if len(sys.argv) == 4:
        same = open(sys.argv[3], "rb").read() == data
        print("%s: %s" % (sys.argv[3], "the same bytes this tool writes from that .pte" if same else "DIFFERENT from what this tool writes"))
        sys.exit(0 if same else 1)
    open(sys.argv[2], "wb").write(data)
