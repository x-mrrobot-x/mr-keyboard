# Mr Keyboard

**English** · [Português](README.pt-BR.md)

An Android keyboard for power users, based on [Hacker's Keyboard](https://github.com/klausw/hackerskeyboard). It has full PC keys, sheets of extra keys you can edit, commands for [Tasker](https://tasker.joaoapps.com/) and offline word suggestions.

Requires Android 8.0 or later.

## Features
- **Full keyboard:** Ctrl, Alt, Esc, Tab, arrows, Home/End, PgUp/PgDn and function keys, in compact or full layouts (separate settings for portrait and landscape).
- **Sheets:** extra pages of keys, opened from the keyboard: **123**, **TSK** (Tasker), **HTML**, **FRS** (phrases), navigation and numeric pad. You can edit them and create your own in *Settings → Sheets*.
- **Tasker commands:** a key can trigger a Tasker task instead of typing text (see below).
- **Toolbar** above the keys:
  - **Suggestions:** word suggestions and corrections;
  - **Translate:** translate text before sending it;
  - **Attachments:** photos, videos and files, inserted into the app you are typing in;
  - **Emotes.**
- **Word suggestions** in Brazilian Portuguese, US English and Spanish (one dictionary per language):
  - dictionaries are downloaded in *Settings → Suggestions and dictionaries*, so the app itself is only about 1 MB. Each language you download is added to the keyboard: slide the space bar sideways to switch between them;
  - typo correction and next-word prediction;
  - learns the words you use, never in password or incognito fields;
  - suggests the names and words you just wrote in the same conversation (kept only in memory and cleared when you change field or app);
  - everything runs on the device;
  - off by default: turn on *Show suggestions* on the same screen.
- **Themes:** Mr Keyboard Neon, Dark Tech (soft and raised), Midnight Steel and Cobalt Glass (translucent with background blur on Android 12+; a semi-transparent dark background where blur is unavailable). Key spacing and corner roundness work in every theme, and the roundness also follows into the long-press popup, the key preview bubble, and the toolbar and panels.
- **Gestures and keys:** swipe up/down/left/right and the volume keys can run keyboard actions.
- **App in English, Portuguese or Spanish:** it follows the system language, or pick one in *Settings → General → App language*.

## Tasker integration
Any key whose output text starts with `tskcmd:` sends a command instead of typing. The first row of the **TSK** sheet already has some, and you can create your own in the sheet editor (e.g. output text `tskcmd:lights_on`).

In Tasker:
1. Create a profile: *Event → System → Intent Received*.
2. Set *Action* to `com.mrkeyboard.app.TASKER_CMD`.
3. In the task, the variable `%cmd` holds the command (in the example, `lights_on`).

The command is sent as a broadcast that other apps can also receive, so don't put passwords or private data in it.

## Privacy
- What you type stays on your device. Suggestions, corrections and learned words are processed and stored only on the phone. There are no ads, no analytics and no Google Play Services.
- The app uses the internet only when you ask it to:
  - **Translate** sends the text you type in the translate field to Google Translate (`translate.googleapis.com`). Only that text is sent, and only when you use it. The field says so ("Type to translate with Google"), and the app shows a notice the first time the panel opens.
  - **Dictionaries** (*Settings → Suggestions and dictionaries*): the app only connects when you tap *Check for updates*, *Download*, *Update* or a language that isn't downloaded yet, and it only downloads files from this repository's [latest release](../../releases/latest) (the catalog, `catalogo.json`, and one zip per language). Every file is checked against a list signed with the app's own key before it is used.

| Permission | Why |
|---|---|
| Internet | Translate and dictionary downloads |
| Notifications | Optional permanent notification to bring up the keyboard |
| Storage / All files access | Attachments: list and send your photos, videos and files |
| User dictionary | Read and add words to Android's personal dictionary |
| Vibration | Vibrate on keypress |

## Installation
1. Download the APK from the [latest release](../../releases/latest) (direct link: [MrKeyboard.apk](../../releases/latest/download/MrKeyboard.apk)) and install it.
2. Open **Mr Keyboard** and tap **Enable keyboard**. Turn on Mr Keyboard in the list and accept the system warning. Android shows that warning for every keyboard that doesn't come with the phone.
3. Tap **Set input method** and choose Mr Keyboard.
4. For word suggestions (optional): in the settings, open **Suggestions and dictionaries**, tap your language to download its dictionary, then turn on **Show suggestions**. Download more than one language and slide the space bar sideways to switch between them.

## Building
This repository holds the app as an [apktool](https://apktool.org/) project (smali code and resources). It also has:
- `native/`: the C++ dictionary reader, `libjni_pckeyboard.so` (CMake);
- `engine/`: the native suggestion engine, `libmrengine.so` (correction search and two-word prediction in C++, with the Java code as fallback; see `docs/motor-nativo.md`);
- `docs/`: notes for each version (in Portuguese) and the tools used to build the dictionary and the Java classes.

**With GitHub Actions** there are three workflows:
- *Mr Keyboard - APK* runs on every push that changes the app (`smali/`, `res/`, `lib/`, `apktool.yml`). It builds the APK with apktool 2.11.1 using the libraries already in `lib/`, and signs it if these secrets exist: `KEYSTORE_B64`, `KEYSTORE_PASS`, `KEY_ALIAS`, `KEY_PASS`. Without the secrets (in a fork, for example), you get an unsigned APK in the `apk` artifact.
- *Mr Keyboard - lib nativa* runs only when `native/` or `engine/` changes (or by hand). It builds both libraries for arm64-v8a, armeabi-v7a and x86 with NDK 27 and runs the PC tests. Extract its `libs-nativas` artifact at the project root (merging with `lib/`) and commit `lib/`, `native-src.sha256`, `mrengine-src.sha256` and `mrengine-info.txt`. The APK workflow compares those hashes with the current `native/` and `engine/` and refuses to publish if `lib/` is out of date.
- *Mr Keyboard - verificações* runs on pushes to `main` and on pull requests that change the app. It checks the version and release notes, the resources (including the Spanish strings), the "Restore defaults" key list, the smali registers and that the generated Java-layer smali is up to date, builds the app to verify the dex, runs the PC tests and checks that the native engine gives exactly the same results as the Java code (Java x C++, three languages). The same scripts are in `docs/tools/` and run on your computer too.

**Publishing (maintainers):**
- **One release per launch:** raise `versionCode` and `versionName` in `apktool.yml` (and add `docs/revisao-<version>.md`, the release notes) and push to `main`. *Mr Keyboard - APK* publishes a single [release](../../releases), tagged with `versionName` (e.g. `v1.72.0`), with `MrKeyboard.apk` (the signed APK, fixed name used by the direct link above), a signed `catalogo.json` and one zip per dictionary language. The text is the *Release notes* section (**## Notas da release**, in Portuguese and English) of `docs/revisao-<version>.md`, the list of included dictionaries and a link to the full notes. It needs the signing secrets; without them, with a version that is already published, or with an out-of-date `lib/`, it only warns and the APK stays in the `apk` artifact. Running it by hand with *publicar* checked does the same, but treats any of these as an error. The release is created as a draft, its files are checked, and only then it is published.
- **Dictionaries:** the packs live in `dicts/<language>/` (`pack.json` lists the files). Each release carries only the **current version of each language** (old zips are not kept). After a change, raise `version` in that `pack.json` **and** the app version, and push: the new release brings the new zip and a `catalogo.json` with a higher `serial`. Languages that did not change are reused byte for byte from the previous release. The catalog is signed with the app's own key (the same one that signs the APK), and the app only accepts catalogs signed with the key it was installed with.

**Locally:**
```sh
apktool b . -o MrKeyboard-unsigned.apk
zipalign -p -f 4 MrKeyboard-unsigned.apk aligned.apk
apksigner sign --ks your-key.jks --out MrKeyboard.apk aligned.apk
```

## Credits and licenses
Mr Keyboard is under the [Apache License 2.0](LICENSE).
- [Hacker's Keyboard](https://github.com/klausw/hackerskeyboard), by Klaus Weidner, and the Android Open Source Project's LatinIME, which Mr Keyboard is based on, are also under the Apache License 2.0.
- Dictionary data (full credits in `dicts/<language>/NOTICE.txt`):
  - AOSP pt_BR, en_US and es word lists (Apache 2.0);
  - [Leipzig Corpora Collection](https://wortschatz-leipzig.de/) (CC BY 4.0);
  - [Tatoeba](https://tatoeba.org/) (CC BY 2.0 FR).
