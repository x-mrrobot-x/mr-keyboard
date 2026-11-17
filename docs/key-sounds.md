# Key sounds ("Keyboard sound")

Settings > Feedback > **Keyboard sound** opens a screen with fifteen tiles (five columns, three rows) and a volume slider:

| row | tiles |
|---|---|
| 1 | mute, bubble 1, bell, duck, keyboard |
| 2 | default, bubble 2, fox, pistol, magic wand |
| 3 | frog, cat, water drop, rocket, mouse |

Touching a tile chooses it and plays it once.

## What is stored

The screen keeps nothing of its own. It writes the preferences the keyboard already reads:

- `sound_on` (the old "Sound on keypress" box): **mute** is `sound_on = false`; every other tile sets it to `true`.
- `pref_sound_style` (new, in `MrReset.KEYS`): `default` or one of `bubble bubble2 bell duck keyboard fox pistol wand frog cat drop rocket mouse`.
  A name that does not exist is read as `default`.
- `pref_click_volume` (the old volume, a float in a string, 0 to 1, default 0.8): the slider writes `percent / 100`.

## How a key is played

`LatinIME.playKeyClick` still decides **whether** a key makes a sound (`sound_on` and the silent mode). Then it asks
`MrKeySound.play(context, effect)` first:

- `default` (or any failure) answers `false`: the system click plays exactly as before, at the volume of the system.
  The slider is disabled and the screen says so (the system click cannot be given another volume).
- a style answers `true`: the sound `res/raw/mr_snd_<style>.ogg` is played with a `SoundPool` (4 streams, sonification
  stream, so it follows the system volume and the silent mode) at the volume of the slider. Space, delete and return are
  the same sound played a little slower/faster (0.92, 0.85, 1.08), the way the system click tells them apart.
- one sound is kept loaded: the one of the style in use. A new style unloads the old one. While a sound is still loading
  the key is silent (it is never a different sound); the preview of the screen is played as soon as the load finishes.
- a file that is missing or cannot be loaded makes `play` answer `false`, so the key falls back to the system click.

## The sounds

They are original: made by `docs/tools/make_key_sounds.py` (numpy + scipy synthesis, then `ffmpeg -c:a libvorbis -q:a 4`,
mono, 44100 Hz, 77 to 261 ms, about 66 KB together). Nothing is copied from another app. To change one, edit its recipe
and run, at the project root:

    python3 -I docs/tools/make_key_sounds.py

The files must be stored (not compressed) in the APK: `SoundPool.load(Context, int, int)` opens the raw resource as a file
descriptor, which Android refuses for a compressed entry (every key would then fall back to the system click). That is why
`ogg` is in `doNotCompress` in `apktool.yml` (the file the build reads) and in `apktool.json`; `res_check.py` and `SoundTest`
check both, and a built APK shows the entries as `Stored` in `unzip -v app.apk 'res/raw/mr_snd_*'`.

## Tests

`docs/tools/screens_test/SoundTest.java` (run by `run_java_tests.sh`): the preferences, each play path against a stub
`SoundPool`, the screen against the stub views, and the files (Ogg headers, durations, strings in three languages, manifest,
the row of the feedback screen, the reset key and the call in the smali). Hearing the sounds is only possible on the phone.
