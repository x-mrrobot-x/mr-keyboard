# Package flow test on the PC (1.63)

**Run it with one command** (it is what *Mr Keyboard - checks* runs, job `assemble`):

    bash docs/tools/packs_test/run_packs_tests.sh <app_jar.jar>

The script builds the PC libs, a test key (`keytool`, plus an EC key made with `openssl` for the "other key" case), the fixtures
(`make_fixtures.py` from only the pt-BR pack, `sign_fixtures.py` to sign them and make the two bad catalogs) and the signed catalog of the three real
packs of `dicts/`, then runs `PacksTest` and `ThreeLangTest`. Nothing is fixed in the test any more: the number of corrections, the size of the
dictionary and the app code come from `dicts/` and `apktool.yml`, so a new pack or a change of `rules.txt` does not break it. The manual recipe below
is what the script does, kept to explain each piece.

Runs the APK's classes (dex → jar with dex2jar) and the native lib compiled for the PC, with a fake
Android (preferences in memory, network read from files). It covers: signed catalog, a series that
does not go back, a tampered catalog or one from another key, HTTP error, cancel, install, tampered
or truncated zip, extra file in the zip (including `../`), file with the wrong SHA-256, package
for a newer app, update, remove, the "Baixar dicionário" (Download dictionary) item and the keyboard languages rule (cards and selected_languages).

1. Test key: `keytool -genkeypair -keyalg RSA -alias mrkeyboard -keystore /tmp/fa/test.p12 -storetype PKCS12 -storepass pass123 -keypass pass123 -dname CN=Test`
   and `keytool -exportcert -rfc -alias mrkeyboard -keystore /tmp/fa/test.p12 -storepass pass123 -file /tmp/fa/cert.pem`;
   for the "other key" case, an EC pair in `/tmp/fa/ec.pk8` and `/tmp/fa/eccert.pem` (openssl).
2. `python3 -I docs/tools/packs_test/make_fixtures.py <root> /tmp/pt/fx`, where `<root>` has `docs/tools` and a `dicts/` **with only pt-BR** (the generator assumes the 1st package is pt-BR; with all three it builds swapped fixtures). `ThreeLangTest` reads the 3-package catalog from `/tmp/v165out` (`make_catalog.py --dicts dicts --out /tmp/v165out --tag v1.73.0`, signed), and sign each `data.json` with
   `docs/tools/SignCatalog.java` (`catalog.json`; in `ok/` also `catalog_ec.json` with the EC key
   and `catalog_tamper.json` with the series changed after signing).
3. Stubs: `docs/tools/java/stubs/android` + the ones in this folder (`stubs/`, which replace the ones with the same name).
4. `java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -Djava.library.path=<PC lib>
   -cp classes:stubs:e2e_classes:app_v163.jar:android_stubs com.mrkeyboard.app.PacksTest`
   (the `UiLocale.java` from here goes before the jar: the real class uses APIs that the PC does not have).

`PacksTest` also checks the `release` field: the zip is asked from `RELEASES_URL` + the pack's release + its name (including a pack whose zip stayed in an earlier release), and catalogs with an invalid or missing `release` are rejected.

`LiveTest` downloads the real catalog and package from GitHub with the same code as the app (without checking
the signature, which depends on the certificate of the published APK).
