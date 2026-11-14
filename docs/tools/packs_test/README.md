# Package flow test on the PC (1.63)

**Run it with one command** (it is what *Mr Keyboard - checks* runs, job `assemble`):

    bash docs/tools/packs_test/run_packs_tests.sh <app_jar.jar>

The script builds the PC libs, a test key (`keytool`, plus an EC key made with `openssl` for the "other key" case), the fixtures
(`make_fixtures.py` from only the pt-BR pack, `make_model_fixtures.py` for the gesture recognition pack, `sign_fixtures.py` to sign them all and make the
two bad catalogs) and the signed catalog of the three real packs of `dicts/`, then runs `PacksTest`, `ThreeLangTest` and `ModelPackTest`. Nothing is fixed in the test any more: the number of corrections, the size of the
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
   The stub `PackageManager` also answers `queryBroadcastReceivers` and `queryIntentActivities` with an empty list: a language without a pack reaches `PluginManager.ensurePlugins`, which asks for the dictionary apps.
4. `java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -Djava.library.path=<PC lib>
   -cp classes:stubs:e2e_classes:app_v163.jar:android_stubs com.mrkeyboard.app.PacksTest`
   (the `UiLocale.java` from here goes before the jar: the real class uses APIs that the PC does not have).

Since 1.86 the fixtures include a **v2 pack** (`make_fixtures.py`: `meta2['version'] = 8`, `format: 2`, `minApp: 1086000`, serial 7, made by converting the pt-BR `main.dict` with `build_dict.py --convert --format 2`). `PacksTest` (99 checks) installs it over v7, checks that it is larger than 4 MB, that the header is `200/2` and that `Suggest` accepts its words, runs 11 cases of `MrPacks.dictHeaderOk` (header `200/1` up to 4,194,304 bytes and `200/2` up to 16,777,216; one byte over each limit, a v2 file under 1 KB, and the headers `200/0`, `200/3` and `199/1` are refused) and 5 of `MrPacks.appTooOld` (pack format 1; formats 0 and 3, which no app knows; format 2 with `minApp` equal to the app; format 2 with `minApp` above the app). `ThreeLangTest` has 23 checks.

`PacksTest` also checks the `release` field: the zip is asked from `RELEASES_URL` + the pack's release + its name (including a pack whose zip stayed in an earlier release), and catalogs with an invalid or missing `release` are rejected.

## The gesture recognition pack (1.96.0)

`make_model_fixtures.py <project root> <fx dir>` writes ten more folders, `m_*`, next to the ones above. All start from the real thing:
`make_catalog.py --dicts <only pt-BR> --model gesture`, so the weights in the fixtures are `gesture/encoder.bin`. Each of the others changes one thing
(the header of the script lists them): weights with another magic, a licence file of a few bytes, an extra file in the zip, a pack for a newer app, a
model format this app does not know, a good version 2, a `models` list with entries this version must skip, a `models` that is not a list, and a
catalog with no `models` at all. Their serials go up in the order the test fetches them.

`ModelPackTest` (66 checks) runs the classes of the APK on them, with the fake Android of `PacksTest` and the PC lib:
- the catalog: the language list is what it was, the model is in its own list with its name in the three languages, the licence and the credits;
- downloads that must not install (cancelled, one byte changed, cut, HTTP 404) and signed packs that must be refused (the cases above), with nothing
  left behind and the installed version intact;
- install: the folder `files/models/gesture/<version>/`, the weights byte for byte the ones of the repository, the licence text whole; the model is not
  a language (no dictionary, no keyboard language) and installing it neither turns the suggestions on nor makes the keyboard reload its dictionaries;
- the setting: off by default; on without the file is still off; on with the file, **the native lib opens the installed weights**; update and remove
  follow; "restore defaults" turns it off and leaves the file;
- a file picked by the user (`MrPacks.installModelFile`): only `gesture/encoder.bin` is taken (one bit changed, another file, an empty file, a 200 MB
  file read only up to 16 MB are refused), no request is made to the network, the licence text is written from the copy in the APK;
- what must stay in step with `gesture/`: the table of known files (`MrPacks.MODEL_FILES`), the licence text in `res/raw/`, the size said in the
  download dialog (three languages) and the notice "FUTO Swipe" in the texts of the screen.

The script reads the `versionCode` of `apktool.yml` to tell the fake Android which app it is; it accepts the number with or without quotes
(apktool writes either, depending on the version that decoded the APK; with the unquoted form the script used to stop before any test).

`LiveTest` downloads the real catalog and package from GitHub with the same code as the app (without checking
the signature, which depends on the certificate of the published APK).
