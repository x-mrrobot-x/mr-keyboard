#!/usr/bin/env python3
"""Monta os pacotes de dicionário (dicts/<id>/) e os dados do catálogo.

Uso (o workflow mr-dicts.yml roda assim):
  python3 make_catalog.py --dicts dicts --out out --repo dono/repo [--prev catalogo.json]

Para cada pasta dicts/<id>/ com pack.json:
  - confere o manifesto e os arquivos (cabeçalho do dicionário, das duas palavras, UTF-8 das regras);
  - se o catálogo publicado (--prev) já tem esse id na mesma versão com os mesmos arquivos,
    reaproveita a entrada (o zip publicado não muda);
  - se a versão é nova, gera <id>-<versão>.zip sempre igual para o mesmo conteúdo;
  - se o conteúdo mudou e a versão não, para com erro (aumente "version" no pack.json).

Saída em --out:
  dados.json   o que vai ser assinado (bytes exatos)
  enviar.txt   zips novos para enviar ao Release, um por linha
  <id>-<v>.zip os zips novos
Se nada mudou em relação ao catálogo publicado, não escreve dados.json (nada a publicar).
"""
import argparse
import datetime
import hashlib
import json
import os
import re
import sys
import zipfile

FORMAT = 1                 # formato do catálogo
PACK_FORMATS = {1}         # formatos de pacote que este script sabe montar
RELEASE_TAG = "dicionarios"
NAME_RE = re.compile(r"^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$")
ID_RE = re.compile(r"^[a-z]{2,3}(-[A-Z]{2})?$")
ZIP_TIME = (1980, 1, 1, 0, 0, 0)
MAX_FILE = 16 * 1024 * 1024
DICT_MAX = 4194304         # endereço de 22 bits do formato do dicionário


def fail(msg):
    print("::error::" + msg)
    sys.exit(1)


def sha256(data):
    return hashlib.sha256(data).hexdigest()


def check_file(pid, name, data):
    if len(data) == 0 or len(data) > MAX_FILE:
        fail("%s/%s: tamanho inválido (%d bytes)" % (pid, name, len(data)))
    if name.endswith(".dict"):
        if len(data) > DICT_MAX:
            fail("%s/%s: passa do limite do formato (%d > %d bytes)" % (pid, name, len(data), DICT_MAX))
        if data[0] != 200 or data[1] != 1:
            fail("%s/%s: cabeçalho do dicionário diferente de [200,1]" % (pid, name))
    elif name == "trigrams.bin":
        if data[:4] != b"MRT1":
            fail("%s/%s: não começa com MRT1" % (pid, name))
    elif name.endswith(".txt"):
        try:
            data.decode("utf-8")
        except UnicodeDecodeError:
            fail("%s/%s: não é UTF-8" % (pid, name))


def read_pack(dicts, pid):
    folder = os.path.join(dicts, pid)
    with open(os.path.join(folder, "pack.json"), "rb") as f:
        raw = f.read()
    try:
        m = json.loads(raw.decode("utf-8"))
    except ValueError as e:
        fail("%s/pack.json inválido: %s" % (pid, e))
    for key in ("id", "lang", "name", "version", "format", "minApp", "files", "licenses"):
        if key not in m:
            fail("%s/pack.json sem o campo %s" % (pid, key))
    if m["id"] != pid or not ID_RE.match(pid):
        fail("%s: id do pack.json (%s) tem que ser igual ao nome da pasta, ex.: pt-BR" % (pid, m["id"]))
    if not isinstance(m["version"], int) or m["version"] < 1:
        fail("%s: version tem que ser inteiro >= 1" % pid)
    if m["format"] not in PACK_FORMATS:
        fail("%s: format %r desconhecido" % (pid, m["format"]))
    if not isinstance(m["name"], dict) or "en" not in m["name"]:
        fail("%s: name precisa ter ao menos o texto em inglês (en)" % pid)
    files = m["files"]
    if not files or len(set(files)) != len(files):
        fail("%s: lista files vazia ou repetida" % pid)
    if not any(n.endswith(".dict") for n in files):
        fail("%s: o pacote precisa de um arquivo .dict" % pid)
    out = []
    for name in files:
        if not NAME_RE.match(name) or name == "pack.json":
            fail("%s: nome de arquivo inválido: %r" % (pid, name))
        path = os.path.join(folder, name)
        if not os.path.isfile(path):
            fail("%s: falta o arquivo %s" % (pid, name))
        with open(path, "rb") as f:
            data = f.read()
        check_file(pid, name, data)
        out.append((name, data))
    extra = sorted(set(os.listdir(folder)) - set(files) - {"pack.json"})
    if extra:
        print("aviso: %s: arquivos fora da lista files (não vão no pacote): %s" % (pid, ", ".join(extra)))
    return m, raw, out


def make_zip(path, manifest_raw, files):
    with zipfile.ZipFile(path, "w") as z:
        for name, data in [("pack.json", manifest_raw)] + files:
            info = zipfile.ZipInfo(name, ZIP_TIME)
            info.compress_type = zipfile.ZIP_DEFLATED
            info.create_system = 3
            info.external_attr = 0o644 << 16
            z.writestr(info, data, compresslevel=9)


def load_prev(path):
    if not path or not os.path.isfile(path):
        return None
    with open(path, "rb") as f:
        env = json.loads(f.read().decode("utf-8"))
    data = json.loads(env["data"])
    if data.get("format") != FORMAT:
        fail("catálogo publicado tem formato %r; este script gera %d" % (data.get("format"), FORMAT))
    return data


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dicts", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--repo", required=True, help="dono/repositório no GitHub")
    ap.add_argument("--prev", help="catalogo.json publicado (se existir)")
    ap.add_argument("--now", help="data fixa (para testes), ISO 8601")
    a = ap.parse_args()

    prev = load_prev(a.prev)
    prev_packs = {p["id"]: p for p in prev["packs"]} if prev else {}
    os.makedirs(a.out, exist_ok=True)

    ids = sorted(d for d in os.listdir(a.dicts)
                 if os.path.isfile(os.path.join(a.dicts, d, "pack.json")))
    if not ids:
        fail("nenhum pacote em %s" % a.dicts)

    packs, new_zips = [], []
    for pid in ids:
        m, raw, files = read_pack(a.dicts, pid)
        file_entries = [{"name": n, "size": len(d), "sha256": sha256(d)} for n, d in files]
        old = prev_packs.get(pid)
        if old and old["version"] > m["version"]:
            fail("%s: version %d é menor que a publicada (%d)" % (pid, m["version"], old["version"]))
        if old and old["version"] == m["version"]:
            same = old["files"] == file_entries and old.get("manifestSha256") == sha256(raw)
            if not same:
                fail("%s: o conteúdo mudou mas a version continua %d; aumente \"version\" em dicts/%s/pack.json"
                     % (pid, m["version"], pid))
            packs.append(old)
            print("%s v%d: igual ao publicado" % (pid, m["version"]))
            continue
        zname = "%s-%d.zip" % (pid, m["version"])
        zpath = os.path.join(a.out, zname)
        make_zip(zpath, raw, files)
        with open(zpath, "rb") as f:
            zdata = f.read()
        entry = {
            "id": pid,
            "lang": m["lang"],
            "region": m.get("region", ""),
            "name": m["name"],
            "description": m.get("description", {}),
            "version": m["version"],
            "format": m["format"],
            "minApp": m["minApp"],
            "url": zname,
            "size": len(zdata),
            "sha256": sha256(zdata),
            "installedSize": sum(e["size"] for e in file_entries),
            "manifestSha256": sha256(raw),
            "files": file_entries,
            "licenses": m["licenses"],
            "credits": m.get("credits", ""),
        }
        packs.append(entry)
        new_zips.append(zname)
        print("%s v%d: novo, %s (%d bytes, %d instalado)" % (pid, m["version"], zname, len(zdata),
                                                              entry["installedSize"]))

    with open(os.path.join(a.out, "enviar.txt"), "w") as f:
        f.write("".join(z + "\n" for z in new_zips))
    if prev and not new_zips and [p["id"] for p in prev["packs"]] == ids:
        print("nada mudou: o catálogo publicado continua valendo")
        return

    now = a.now or datetime.datetime.now(datetime.timezone.utc).replace(microsecond=0).isoformat()
    data = {
        "format": FORMAT,
        "serial": (prev["serial"] + 1) if prev else 1,
        "generated": now,
        "baseUrl": "https://github.com/%s/releases/download/%s/" % (a.repo, RELEASE_TAG),
        "packs": packs,
    }
    with open(os.path.join(a.out, "dados.json"), "wb") as f:
        f.write(json.dumps(data, ensure_ascii=False, indent=1).encode("utf-8"))
    print("catálogo: série %d, %d pacote(s)" % (data["serial"], len(packs)))


if __name__ == "__main__":
    main()
