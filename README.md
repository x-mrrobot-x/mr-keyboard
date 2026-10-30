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
- **Word suggestions** (Brazilian Portuguese for now; English is planned):
  - typo correction and next-word prediction;
  - learns the words you use, never in password or incognito fields;
  - everything runs on the device;
  - off by default: turn on *Show suggestions* in the settings.
- **Themes:** Mr Keyboard Neon, Dark Tech (soft and raised), Midnight Steel, Material Dark/Light, Stone, Gingerbread and more.
- **Gestures and keys:** swipe up/down/left/right and the volume keys can run keyboard actions.
- **Settings in English or Portuguese.**

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
  - **Translate** sends the text you type in the translate field to Google Translate (`translate.googleapis.com`). Only that text is sent, and only when you use it.
  - **Dictionary downloads** (in development) will only download files, and only when you tap *Download*.

| Permission | Why |
|---|---|
| Internet | Translate (and, later, dictionary downloads) |
| Notifications | Optional permanent notification to bring up the keyboard |
| Storage / All files access | Attachments: list and send your photos, videos and files |
| User dictionary | Read and add words to Android's personal dictionary |
| Vibration | Vibrate on keypress |

## Installation
1. Download the APK from [Releases](../../releases) and install it.
2. Open **Mr Keyboard** and tap **Enable keyboard**. Turn on Mr Keyboard in the list and accept the system warning. Android shows that warning for every keyboard that doesn't come with the phone.
3. Tap **Set input method** and choose Mr Keyboard.
4. Optional: tap **Input languages** to pick layouts. Slide the space bar sideways to switch between them.

## Building
This repository holds the app as an [apktool](https://apktool.org/) project (smali code and resources). It also has:
- `native/`: the C++ dictionary engine (CMake);
- `docs/`: notes for each version (in Portuguese) and the tools used to build the dictionary and the Java classes.

**With GitHub Actions** (*Actions → Mr Keyboard - nativo e APK → Run workflow*), the workflow:
1. builds the native library for arm64-v8a, armeabi-v7a and x86 with NDK 27;
2. builds the APK with apktool 2.11.1;
3. signs it if these secrets exist: `KEYSTORE_B64`, `KEYSTORE_PASS`, `KEY_ALIAS`, `KEY_PASS`.

Without the secrets (in a fork, for example), you get an unsigned APK in the `apk` artifact.

**Publishing (maintainers):**
- **App:** run the same workflow with *publicar* checked. The signed APK goes to [Releases](../../releases), tagged with `versionName` from `apktool.yml` (e.g. `v1.63.0`).
- **Dictionaries:** the packs live in `dicts/<language>/` (`pack.json` lists the files). After a change, raise `version` in `pack.json` and run *Mr Keyboard - dicionários*. It publishes the pack and a signed `catalogo.json` in the `dicionarios` release. The catalog is signed with the app's own key, and the app only accepts catalogs signed with the key it was installed with.

**Locally:**
```sh
apktool b . -o MrKeyboard-unsigned.apk
zipalign -p -f 4 MrKeyboard-unsigned.apk aligned.apk
apksigner sign --ks your-key.jks --out MrKeyboard.apk aligned.apk
```

## Credits and licenses
Mr Keyboard is under the [Apache License 2.0](LICENSE).
- [Hacker's Keyboard](https://github.com/klausw/hackerskeyboard), by Klaus Weidner, and the Android Open Source Project's LatinIME, which Mr Keyboard is based on, are also under the Apache License 2.0.
- Portuguese dictionary data:
  - AOSP pt_BR word list (Apache 2.0);
  - [Leipzig Corpora Collection](https://wortschatz-leipzig.de/) (CC BY 4.0);
  - [Tatoeba](https://tatoeba.org/) (CC BY 2.0 FR).

  Full credits are in `dicts/pt-BR/NOTICE.txt`.
