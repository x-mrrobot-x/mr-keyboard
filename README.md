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
  - **AI editor:** rewrite selected text or the text before the cursor in a modal dialog above the keyboard; configure the service in *Settings → AI Editor*;
  - **Attachments:** photos, videos and files, inserted into the app you are typing in;
  - **Emotes.**
- **Word suggestions** in Brazilian Portuguese, US English and Spanish (one dictionary per language):
  - dictionaries are downloaded in *Settings → Suggestions and dictionaries*, so the app itself is only about 1 MB. Each language you download is added to the keyboard: slide the space bar sideways to switch between them;
  - typo correction and next-word prediction;
  - learns the words you use, never in password or incognito fields;
  - *Settings → Suggestions and dictionaries → My words*: see, fix, block and forget what the keyboard learned (with an exported backup), and add names, slang and phrases from a pasted text, a file or a word list, with a preview before anything is saved;
  - suggests the names and words you just wrote in the same conversation (kept only in memory and cleared when you change field or app);
  - everything runs on the device;
  - off by default: turn on *Show suggestions* on the same screen.
- **Themes:** twelve, in this order: Midnight Steel (the default), the neon ones (Aurora, whose keys change hue across the keyboard, Neon Cyan, Neon Purple, Neon Pink and Synthwave), Aqua, Snow, Chrome (silver keys on a navy background) and Rose, then Cobalt Glass (translucent, with background blur on Android 12+ and a semi-transparent dark background where blur is unavailable), then Denim (a cobalt blue background that is only slightly see-through, with the same blur, and navy keys). Ctrl, Alt, Shift and ❖ wear the highlight style of the other special keys and show their state with a small colored dash along the lower edge; Shift distinguishes off, active and locked. Key spacing and corner roundness work in every theme, and the roundness also follows into the long-press popup and the key preview bubble. The toolbar and panels have their own fixed corners. The AI editor dialog always uses the settings theme.
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
- The app connects to the internet only for these features:
  - **Translate** sends the text you type in the translate field to Google Translate (`translate.googleapis.com`). Only that text is sent, and only when you use it. The field says so ("Type to translate with Google").
  - **AI editor** sends only the text you choose to rewrite, and only to the AI service you configure. No request is sent until you tap a style.
  - **Dictionaries** (*Settings → Suggestions and dictionaries*): the app only connects when you tap *Check for updates*, *Download*, *Update* or a language that isn't downloaded yet, and it only downloads files from this repository's [latest release](../../releases/latest) (the catalog, `catalog.json`, and the zip of each language, which is attached to the release where that language last changed). Every file is checked against a list signed with the app's own key before it is used.
  - **App updates** (*Settings → About*): the app reads `update.json` from this repository's [latest release](../../releases/latest) when it opens (at most once a day) and every morning in the background, and shows a notice when there is a newer version. Both can be turned off. The request carries nothing about you or your phone. The file is checked against a signature made with the app's own key before it is used.

| Permission | Why |
|---|---|
| Internet | Translate, AI editor, dictionary downloads and update notices |
| Notifications | Optional permanent notification to bring up the keyboard, and the new-version notice |
| Install unknown apps | *Download and install* hands the new APK to Android, which asks you to confirm |
| Run at startup | Keeps the morning update check scheduled after the phone restarts |
| Storage / All files access | Attachments: list and send your photos, videos and files |
| User dictionary | Read and add words to Android's personal dictionary |
| Vibration | Vibrate on keypress |

## Installation
1. Download the APK (`mr-keyboard-v<version>.apk`) from the [latest release](../../releases/latest) and install it.
2. Open **Mr Keyboard** and tap **Enable keyboard**. Turn on Mr Keyboard in the list and accept the system warning. Android shows that warning for every keyboard that doesn't come with the phone.
3. Tap **Set input method** and choose Mr Keyboard.
4. For word suggestions (optional): in the settings, open **Suggestions and dictionaries**, tap your language to download its dictionary, then turn on **Show suggestions**. Download more than one language and slide the space bar sideways to switch between them.

## Updates
- The app looks for a new version when it opens (at most once a day) and every morning in the background. When there is one, a dialog (or a notification, for the morning check) shows what's new, with **Download and install**, **View on GitHub** and **Not now**. The line **Check for updates** and the two switches are in *Settings → About*.
- **Download and install** downloads the APK of that release, checks its size and SHA-256 against the signed `update.json` and hands it to Android, which asks you to confirm. The first time, Android also asks you to allow Mr Keyboard to install apps (*Install unknown apps*).
- The morning check asks Android to run it some time after 8 a.m. (phone time), when there is a network. Android decides the exact moment: with battery saver, or on phones that put apps to sleep (some Samsung, Xiaomi and Huawei models, for example), the notice can arrive hours late or not at all. The check when the app opens always runs. On Android 13 or newer, the notice needs the notification permission.
- You can also update by hand: download the new APK from the [latest release](../../releases/latest) and install it over the old one (it has to be signed with the same key). The APK name has the version, so there is no fixed direct link; use the release page.

## Building
This repository holds the app as an [apktool](https://apktool.org/) project (smali code and resources). It also has:
- `native/`: the C++ dictionary reader, `libjni_pckeyboard.so` (CMake);
- `engine/`: the native suggestion engine, `libmrengine.so` (correction search and two-word prediction in C++, with the Java code as fallback; see `docs/native-engine.md`);
- `docs/`: notes for each version (in Portuguese) and the tools used to build the dictionary and the Java classes.

**From a release (download, edit, build):** every [release](../../releases) has `mr-keyboard-v<version>-source.zip`, made from the exact commit that was published. It holds the apktool project (`smali/`, `res/`, `lib/`, `apktool.yml`), `native/` and `engine/`, the Java-layer sources (`docs/tools/java`, with `build_java.sh`), the licence and these READMEs. The dictionaries are not in it: they are in the dictionary zips of the releases and in `dicts/` in the repository. To change the app, unzip it, edit `smali/` and `res/`, and build and sign as shown in *Locally* below. Two things to know about a build signed with your own key: Android only installs it over the original app after that one is uninstalled (its settings are lost), and the app only accepts a dictionary catalog signed with its own key, so a fork needs its own releases (the *Mr Keyboard - APK* workflow makes them) and the repository address in `docs/tools/java/src/com/mrkeyboard/app/MrPacks.java` changed to yours.

**With GitHub Actions** there are three workflows:
- *Mr Keyboard - APK* runs on every push that changes the app (`smali/`, `res/`, `lib/`, `apktool.yml`). It builds the APK with apktool 2.11.1 using the libraries already in `lib/`, and signs it if these secrets exist: `KEYSTORE_B64`, `KEYSTORE_PASS`, `KEY_ALIAS`, `KEY_PASS`. Without the secrets (in a fork, for example), you get an unsigned APK in the `apk` artifact. To publish, it first runs *Mr Keyboard - checks* and only goes on if they all pass; the job that creates the release is the only one with write permission.
- *Mr Keyboard - native lib* runs only when `native/` or `engine/` changes (or by hand). It builds both libraries for arm64-v8a, armeabi-v7a, x86 and x86_64 with NDK 27 and runs the PC tests. Extract its `native-libs` artifact at the project root (merging with `lib/`) and commit `lib/`, `native-src.sha256`, `mrengine-src.sha256` and `mrengine-info.txt`. The APK workflow compares those hashes with the current `native/` and `engine/` and refuses to publish if `lib/` is out of date.
- *Mr Keyboard - checks* runs on pushes to `main` and on pull requests that change the app. It checks the version and release notes, the resources (including the Spanish strings), the "Restore defaults" key list, the smali registers and that the generated Java-layer smali is up to date, builds the app to verify the dex, runs the PC tests and checks that the native engine gives exactly the same results as the Java code (Java x C++, three languages). The same scripts are in `docs/tools/` and run on your computer too. `check_workflows.py` also checks the workflows themselves: every action pinned by commit, minimal permissions, and publishing only after the checks.

**Publishing (maintainers):**
- **Immutable releases (once, by the repository owner):** in *Settings → Releases*, turn on *Enable release immutability* **before** the first release made by this workflow. It only applies to releases published after it is on. From then on the files and the tag of a published release can never be changed or deleted, and the name of its tag can never be used again, so a wrong release is fixed with a new version, never by editing the old one. Releases made before it was turned on stay mutable. The workflow already does what GitHub recommends: it creates the release as a draft, attaches everything and only then publishes it.
- **One release per launch:** raise `versionCode` and `versionName` in `apktool.yml`, write the notes in `docs/release-notes/<tag>.md` (e.g. `docs/release-notes/v1.72.0.md`, with a **Português** block and an **English** block, as a changelog: one item per change, starting with **New**, **Improved** or **Fixed** (**Novo**, **Melhorado**, **Corrigido** in Portuguese), told from the user's side) and push to `main`. *Mr Keyboard - APK* publishes a single [release](../../releases), tagged with `versionName` (e.g. `v1.72.0`), with the signed APK (`mr-keyboard-v1.72.0.apk`, the version is in the file name), the source code of that commit (`mr-keyboard-v1.72.0-source.zip`), a signed `catalog.json`, a signed `update.json` (the version, the size and SHA-256 of the APK and the notes in Portuguese and English, taken from the two blocks of the notes file) and only the zips of the dictionary languages that changed in this version. Both JSON files are signed with the same key as the APK, each with its own prefix, so one can never be taken for the other. The APK and the source zip get a build provenance attestation. The text is the notes file, the list of included dictionaries (with the ones that are new in this version) and the checksums. It needs the signing secrets; without them, with a version that is already published, or with an out-of-date `lib/`, it only warns and the APK stays in the `apk` artifact. Running it by hand with *publish* checked does the same, but treats any of these as an error. The release is created as a draft, its files are checked, and only then it is published.
- **Dictionaries:** the packs live in `dicts/<language>/` (`pack.json` lists the files). Each zip is named `mr-keyboard-dict-<id>-<version>.zip` and is attached **only to the release where that language changed**; the catalog says, for each language, which release holds its zip (`release`), and the app builds the download address from it. After a change, raise `version` in that `pack.json` **and** the app version, and push: the new release brings the new zip and a `catalog.json` with a higher `serial`. Languages that did not change keep pointing to the release that made their zip, and nothing is copied. **Never delete or change a release that still holds a dictionary the catalog uses:** the script checks this before publishing and stops with an error naming the missing zip. The catalog is signed with the app's own key (the same one that signs the APK), and the app only accepts catalogs signed with the key it was installed with.

**Locally:**
```sh
apktool b . -o mr-keyboard-unsigned.apk
zipalign -p -f 4 mr-keyboard-unsigned.apk aligned.apk
apksigner sign --ks your-key.jks --out mr-keyboard.apk aligned.apk
```

## Verifying a release
Releases are [immutable](https://docs.github.com/en/code-security/concepts/supply-chain-security/immutable-releases) (see *Publishing* above): after publication their files and tag can't be changed. The APK and the source zip are built by the *Mr Keyboard - APK* workflow of this repository from the tagged commit, and each has a signed provenance attestation. With the [GitHub CLI](https://cli.github.com/), in the folder where you saved the file (replace the version):
```sh
gh release verify v1.82.0 --repo x-mrrobot-x/mr-keyboard
gh release verify-asset v1.82.0 mr-keyboard-v1.82.0.apk --repo x-mrrobot-x/mr-keyboard
gh attestation verify mr-keyboard-v1.82.0.apk --repo x-mrrobot-x/mr-keyboard
```
The first confirms that the release exists and is immutable, the second that your file is exactly the one attached to it, and the third that it was built by this repository's workflow (it works the same for `mr-keyboard-v1.82.0-source.zip`). Without the CLI, compare the SHA-256 shown in the release text with `sha256sum <file>`. Use the zip attached by the release, not the *Source code* zip that GitHub generates on its own: that one is created when it is requested and can't be verified.

## Credits and licenses
Mr Keyboard is under the [Apache License 2.0](LICENSE).
- [Hacker's Keyboard](https://github.com/klausw/hackerskeyboard), by Klaus Weidner, and the Android Open Source Project's LatinIME, which Mr Keyboard is based on, are also under the Apache License 2.0.
- Dictionary data (full credits in `dicts/<language>/NOTICE.txt`):
  - AOSP pt_BR, en_US and es word lists (Apache 2.0);
  - [Leipzig Corpora Collection](https://wortschatz-leipzig.de/) (CC BY 4.0);
  - [Tatoeba](https://tatoeba.org/) (CC BY 2.0 FR);
  - [OpenSubtitles](https://opus.nlpl.eu/OpenSubtitles/) via OPUS (only counts of words and pairs; no subtitle text is stored or distributed);
  - Comments of public [Reddit](https://www.reddit.com/) communities (January to June 2025), obtained from the [Arctic Shift](https://arctic-shift.photon-reddit.com) archive (only counts of words, pairs and triples; no comment, user name or text is stored or distributed; the licence of the text is not clear, so only counts are used).
