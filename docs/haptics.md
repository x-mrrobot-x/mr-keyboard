# Key vibration (since 1.98.0)

The keyboard vibrates on every key press when "Vibrate on keypress" is on (Settings > Vibration, sound and preview). The person sets a **strength**
(5 % to 100 %, steps of 5 %, 50 % by default; the key `vibrate_strength`, kept as a fraction in text, like the click volume), not a duration.

## Why not a duration in milliseconds
Until 1.97.0 the setting was a duration (1 to 200 ms) and every key press played `VibrationEffect.createOneShot(ms, DEFAULT_AMPLITUDE)`: a square pulse.
Even at 1 ms it did not feel smooth, and no value fixed it, because the duration is not what is felt:
- Android calls the legacy one-shots (`createOneShot`, `Vibrator.vibrate(long)`) buzzy: the actuator goes on after the input ends, mostly on simple motors and drivers.
  A key click should last 10 to 20 ms, and the motor can ring for another 20 to 50 ms after a 20 ms signal.
- An abrupt change of amplitude makes the actuator overshoot and ring (50 ms or more in the measurements of the Android documentation).
- The tuning belongs to the device (a linear actuator, its driver with overdrive and braking). Android keeps it in the haptic constants, the predefined effects
  and the primitives, and asks apps to use them instead of one-shots.
So the keyboard now asks for a short, clear click of a given strength and lets the phone play it.

## What plays (`MrHaptic.play`, called by `LatinIME.vibrate`)
Each device takes the first it can do. The strength is brought to 1..100 first.

| Tier | When | What |
|---|---|---|
| 1. Primitives | API 30+ and the vibrator supports TICK and CLICK (`areAllPrimitivesSupported`) | up to 50 %: TICK at strength/50; above: CLICK at strength/100 (`VibrationEffect.startComposition`) |
| 2. Predefined effect | API 29+ (or tier 1 not possible) | up to 50 %: `EFFECT_TICK`; up to 80 %: `EFFECT_CLICK`; above: `EFFECT_HEAVY_CLICK` |
| 3. System haptic | API 26 to 28, or no effect could be built, and the keyboard view exists | `performHapticFeedback(KEYBOARD_TAP)`; before API 33 with `FLAG_IGNORE_GLOBAL_SETTING`, as before. **No strength**: the phone's own tuning |
| 4. One-shot | no keyboard view, or tier 3 impossible | 15 ms; the amplitude is the strength when the motor has amplitude control, the default otherwise |

- TICK is half of a CLICK in peak acceleration, so TICK at full scale (50 %) and CLICK at half scale (just above 50 %) are about the same: the strength goes up without a jump.
- From API 33 tiers 1, 2 and 4 are played with the usage **touch** (`VibrationAttributes.USAGE_TOUCH`, 0x12), as the old code did; before, plain `vibrate(effect)`.
- A composition that throws falls to tier 2; a predefined effect that throws leaves the device with none (tier 3 or 4).
- The effect of a strength is built **once** (`sStrength`, `sEffect`; null when the device has none) and reused at every key press. The slider changes it: a new one is built for the new strength.
- No motor (`hasVibrator` false): nothing is played; the system haptic of the view is still asked.
- Only the API calls are guarded by `Build.VERSION.SDK_INT`; there are no nested classes per version (minSdk 26 runs on ART, where a call that does not exist on the
  device only fails when executed, and the code never reaches it).

On API 26 to 28 and on a device with no effect the slider has no effect (the system haptic has no strength). The slider still plays the vibration while it moves
(`VibratePreference.onChange` -> `LatinIME.vibrate`), so the person feels what they choose.

## Where it is
- `smali/com/mrkeyboard/app/MrHaptic.smali` (hand-written smali, no Java source): `play(Context, int strength, View)`, `level(SharedPreferences)` (the setting as 1..100,
  50 when missing or unreadable). It replaced `HapticHelper` and its `Api26`/`Api33` classes.
- `LatinIME`: `mVibrateStrength` (loaded in `loadSettings` and when the key changes), `vibrate(I)V`.
- `VibratePreference.onChange(F)`: the slider fraction x 100 -> `LatinIME.vibrate`.
- `res/xml/prefs_feedback.xml`: the slider (`vibrate_strength`, 0.05..1.0, step 0.05, default 0.5, shown as a percentage); `MrReset` resets the key.

Check: `docs/tools/test_haptic.py` (in `mr-checks.yml`): the real smali in the mini Dalvik interpreter with a fake vibrator and view, on API 26, 28, 29, 30, 32, 33, 34 and 36:
the tiers and their mapping, the exceptions, the effect built once, the usage touch, no motor, the setting read as a fraction, the slider, the key equal in the xml, `MrHaptic`, `LatinIME` and `MrReset`.

**Device checklist** (the feel needs a phone): on a recent phone with a linear actuator the key press should be a short, crisp tick at 50 % and a firmer click at 100 %;
at 5 % it should still be felt but light; with the vibration off nothing vibrates; on a phone with API 26 to 28 the slider does not change anything; a phone with a motor
that does not support primitives (tier 2) changes between three steps (light, medium, strong) as the slider goes up.
