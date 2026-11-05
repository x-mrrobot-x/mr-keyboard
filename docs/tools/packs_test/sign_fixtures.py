#!/usr/bin/env python3
"""Signs the fixtures of PacksTest (make_fixtures.py writes <fx>/<name>/data.json) with the test key, and builds the two bad catalogs.

    python3 -I docs/tools/packs_test/sign_fixtures.py <project root> <fx dir> <test key dir>

The test key dir holds test.p12 (RSA, password pass123, alias mrkeyboard), cert.pem and ec.pk8 + eccert.pem (see run_packs_tests.sh).
Every <fx>/<name>/ gets catalog.json (RSA, the key the test trusts). <fx>/ok/ also gets
  catalog_ec.json      signed with another (EC) key: the app must refuse it ("other key")
  catalog_tamper.json  the serial changed after signing: the app must refuse it ("signature")
"""
import json
import os
import subprocess
import sys

root, fx, keys = sys.argv[1:4]
sign = os.path.join(root, "docs/tools/SignCatalog.java")
env = dict(os.environ, KEYSTORE_PASS="pass123", KEY_ALIAS="mrkeyboard", KEY_PASS="pass123")


def run(data, out, extra):
    subprocess.run(["java", "-Dstdout.encoding=UTF-8", sign, "--data", data, "--out", out] + extra,
                   check=True, env=env, stdout=subprocess.DEVNULL)


rsa = ["--keystore", os.path.join(keys, "test.p12")]
for name in sorted(os.listdir(fx)):
    d = os.path.join(fx, name)
    if os.path.isfile(os.path.join(d, "data.json")):
        run(os.path.join(d, "data.json"), os.path.join(d, "catalog.json"), rsa)
ok = os.path.join(fx, "ok")
run(os.path.join(ok, "data.json"), os.path.join(ok, "catalog_ec.json"),
    ["--pk8", os.path.join(keys, "ec.pk8"), "--cert", os.path.join(keys, "eccert.pem")])
c = json.loads(open(os.path.join(ok, "catalog.json"), encoding="utf-8").read())
changed = c["data"].replace('"serial": 1', '"serial": 99')
if changed == c["data"]:
    sys.exit("sign_fixtures: no serial to change in data.json")
c["data"] = changed
open(os.path.join(ok, "catalog_tamper.json"), "w", encoding="utf-8").write(json.dumps(c, ensure_ascii=False, indent=1))
print("signed:", sorted(os.listdir(fx)))
