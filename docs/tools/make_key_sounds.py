#!/usr/bin/env python3
"""Synthesises the key sounds of Mr Keyboard (res/raw/mr_snd_<style>.ogg): 13 short original sounds, made from scratch with numpy/scipy
(sine sweeps, filtered noise, a glottal-like pulse train through formant filters). Nothing is sampled or copied from any other app.

    python3 -I docs/tools/make_key_sounds.py [out_dir]        (default: res/raw; needs numpy, scipy and ffmpeg with libvorbis)

The styles and their order are the ones of MrKeySound.STYLES. Every sound is short (a key sound is heard again and again): 70 to 260 ms, mono,
44.1 kHz, peak at about -3 dBFS, with a few ms of fade at both ends so that nothing clicks by accident.
Change a recipe here and run it again: the .ogg files are rebuilt and the test (SoundTest) checks them (names, length, peak, no clipping).
"""
import os
import subprocess
import sys

import numpy as np
from scipy import signal

SR = 44100


def t_axis(ms):
    return np.arange(int(SR * ms / 1000.0)) / SR


def env_exp(n, attack_ms, decay_ms):
    """Fast attack, exponential decay."""
    t = np.arange(n) / SR
    a = np.minimum(1.0, t / max(attack_ms / 1000.0, 1e-4))
    return a * np.exp(-t / (decay_ms / 1000.0))


def sweep(f0, f1, ms, curve=1.0):
    """A sine that goes from f0 to f1 (Hz) in ms; curve > 1 spends more time near f0."""
    t = t_axis(ms)
    x = (t / t[-1]) ** curve if len(t) > 1 else t
    f = f0 + (f1 - f0) * x
    return np.sin(2 * np.pi * np.cumsum(f) / SR)


def bandpass(x, lo, hi, order=2):
    sos = signal.butter(order, [lo, hi], btype="band", fs=SR, output="sos")
    return signal.sosfilt(sos, x)


def highpass(x, f, order=2):
    return signal.sosfilt(signal.butter(order, f, btype="high", fs=SR, output="sos"), x)


def lowpass(x, f, order=2):
    return signal.sosfilt(signal.butter(order, f, btype="low", fs=SR, output="sos"), x)


def formants(x, freqs, widths):
    """The sum of resonances: a voice-like colour for a pulse train."""
    out = np.zeros_like(x)
    for f, w in zip(freqs, widths):
        out += bandpass(x, max(60.0, f - w / 2), f + w / 2)
    return out


def glottal(f_curve, n):
    """A saw-like pulse train whose pitch follows f_curve (Hz per sample)."""
    phase = np.cumsum(f_curve) / SR
    return 2.0 * (phase - np.floor(phase)) - 1.0


def place(total_ms, *parts):
    """Puts (start_ms, signal) parts on one timeline; each part gets 1 ms in and 6 ms out so that no part starts or ends with a click."""
    out = np.zeros(int(SR * total_ms / 1000.0))
    for start, x in parts:
        x = np.array(x, dtype=np.float64)
        fi = min(len(x) // 2, int(SR * 0.001))
        fo = min(len(x) // 2, int(SR * 0.006))
        if fi:
            x[:fi] *= np.linspace(0.0, 1.0, fi)
        if fo:
            x[-fo:] *= np.linspace(1.0, 0.0, fo)
        i = int(SR * start / 1000.0)
        j = min(len(out), i + len(x))
        out[i:j] += x[: j - i]
    return out


rng = np.random.default_rng(20241117)


def noise(ms):
    return rng.standard_normal(int(SR * ms / 1000.0))


# ---------------------------------------------------------------- the recipes
def bubble():
    """A bubble that pops: a sine that climbs fast and dies."""
    x = sweep(420, 1500, 90, curve=0.6) * env_exp(int(SR * 0.09), 2, 28)
    return place(90, (0, x + 0.25 * sweep(840, 3000, 90, curve=0.6) * env_exp(int(SR * 0.09), 2, 14)))


def bubble2():
    """A rounder, lower bubble followed by a small one."""
    a = sweep(300, 900, 110, curve=0.7) * env_exp(int(SR * 0.11), 3, 40)
    b = 0.45 * sweep(520, 1500, 70, curve=0.7) * env_exp(int(SR * 0.07), 2, 22)
    return place(190, (0, a), (70, b))


def bell():
    """A small bell: inharmonic partials with different lives."""
    n = int(SR * 0.26)
    t = np.arange(n) / SR
    f0 = 1046.5
    x = np.zeros(n)
    for ratio, amp, life in ((1.0, 1.0, 0.11), (2.76, 0.55, 0.07), (5.4, 0.3, 0.045), (8.93, 0.14, 0.03)):
        x += amp * np.sin(2 * np.pi * f0 * ratio * t) * np.exp(-t / life)
    return x * np.minimum(1.0, t / 0.001)


def duck():
    """A short nasal quack: a pulse train with a falling pitch, a wobble and two narrow resonances."""
    ms = 150
    n = int(SR * ms / 1000.0)
    t = np.arange(n) / SR
    f = 520 - 190 * (t / t[-1]) + 18 * np.sin(2 * np.pi * 55 * t)
    x = formants(glottal(f, n), (900, 2200), (260, 500))
    shape = np.minimum(1.0, t / 0.008) * np.exp(-((t - 0.04) ** 2) / (2 * 0.05 ** 2))
    return x * shape * (0.75 + 0.25 * np.sin(2 * np.pi * 62 * t))


def keyboard():
    """A mechanical key: a click on the way down, a softer one on the way up, and a low knock."""
    def click(ms, centre, decay):
        n = int(SR * ms / 1000.0)
        return bandpass(noise(ms), centre * 0.6, centre * 1.6) * env_exp(n, 0.3, decay)
    down = place(40, (0, click(30, 3200, 4.0)), (0, 0.9 * sweep(210, 120, 40) * env_exp(int(SR * 0.04), 0.5, 9)))
    up = 0.45 * click(24, 4200, 3.0)
    return place(80, (0, down), (48, up))


def fox():
    """A short 'yip': the pitch jumps up and bends down, with a voice-like colour."""
    ms = 140
    n = int(SR * ms / 1000.0)
    t = np.arange(n) / SR
    x01 = t / t[-1]
    f = 780 + 820 * np.sin(np.pi * np.minimum(1.0, x01 * 1.4)) - 160 * x01
    x = formants(glottal(f, n), (1100, 2600), (320, 700))
    return x * np.minimum(1.0, t / 0.006) * np.exp(-t / 0.075)


def pistol():
    """A toy water pistol: a fast falling chirp and a puff of noise."""
    chirp = sweep(2300, 380, 100, curve=0.55) * env_exp(int(SR * 0.1), 1, 34)
    puff = 0.45 * highpass(noise(60), 2500) * env_exp(int(SR * 0.06), 0.5, 14)
    return place(130, (0, chirp), (0, puff))


def wand():
    """A little magic: three quick rising notes with a sparkle on top."""
    notes = []
    for i, f in enumerate((1318.5, 1760.0, 2349.3)):
        n = int(SR * 0.075)
        t = np.arange(n) / SR
        x = np.sin(2 * np.pi * f * t) + 0.35 * np.sin(2 * np.pi * 2 * f * t)
        notes.append((i * 38, x * env_exp(n, 1, 24)))
    sparkle = 0.18 * highpass(noise(150), 6000) * env_exp(int(SR * 0.15), 1, 45)
    return place(220, *notes, (10, sparkle))


def frog():
    """A croak: a low pulse train, chopped fast, through a low resonance."""
    ms = 170
    n = int(SR * ms / 1000.0)
    t = np.arange(n) / SR
    f = 105 - 22 * (t / t[-1])
    x = formants(glottal(f, n), (330, 900), (160, 420))
    chop = 0.5 + 0.5 * np.sign(np.sin(2 * np.pi * 38 * t)) * 0.9
    shape = np.minimum(1.0, t / 0.01) * np.exp(-((t - 0.07) ** 2) / (2 * 0.06 ** 2))
    return x * chop * shape


def cat():
    """A tiny 'mew': the pitch rises and falls while the vowel slides from 'e' to 'a'."""
    ms = 230
    n = int(SR * ms / 1000.0)
    t = np.arange(n) / SR
    x01 = t / t[-1]
    f = 560 + 360 * np.sin(np.pi * x01) ** 1.2 + 14 * np.sin(2 * np.pi * 6 * t)
    src = glottal(f, n)
    first = formants(src, (650, 2200), (200, 500))
    second = formants(src, (950, 1700), (260, 420))
    x = first * (1.0 - x01) + second * x01
    return x * np.sin(np.pi * np.clip(x01 * 1.0, 0, 1)) ** 0.8 * np.minimum(1.0, t / 0.01)


def drop():
    """A water drop: a quick rising sine and a smaller echo."""
    a = sweep(700, 2100, 60, curve=0.5) * env_exp(int(SR * 0.06), 1, 22)
    b = 0.35 * sweep(620, 1700, 50, curve=0.5) * env_exp(int(SR * 0.05), 1, 16)
    return place(150, (0, a), (62, b))


def rocket():
    """A whoosh: noise through a band that rises, over a low rumble."""
    ms = 260
    n = int(SR * ms / 1000.0)
    t = np.arange(n) / SR
    x01 = t / t[-1]
    raw = noise(ms)
    out = np.zeros(n)
    steps = 26
    edges = np.linspace(0, n, steps + 1).astype(int)
    for i in range(steps):
        centre = 350 * (9.0 ** (i / (steps - 1)))
        seg = bandpass(raw, centre * 0.7, min(centre * 1.5, SR * 0.45), order=2)
        out[edges[i]:edges[i + 1]] = seg[edges[i]:edges[i + 1]]
    rumble = 0.5 * lowpass(noise(ms), 180) * (1.0 - x01)
    shape = np.sin(np.pi * np.clip(x01, 0, 1)) ** 0.7
    return (out * 1.0 + rumble) * shape


def mouse():
    """A mouse button: a hard click and, a moment later, a lighter one."""
    def tick(amp, centre):
        n = int(SR * 0.014)
        x = bandpass(noise(14), centre * 0.5, centre * 1.5) * env_exp(n, 0.2, 2.2)
        return amp * (x + 0.6 * np.sin(2 * np.pi * centre * 0.4 * np.arange(n) / SR) * env_exp(n, 0.2, 3.0))
    return place(95, (0, tick(1.0, 2600)), (58, tick(0.55, 3400)))


RECIPES = [
    ("bubble", bubble),
    ("bubble2", bubble2),
    ("bell", bell),
    ("duck", duck),
    ("keyboard", keyboard),
    ("fox", fox),
    ("pistol", pistol),
    ("wand", wand),
    ("frog", frog),
    ("cat", cat),
    ("drop", drop),
    ("rocket", rocket),
    ("mouse", mouse),
]

PEAK = 0.7  # about -3 dBFS


def finish(x):
    """Removes any offset, fades the two ends (3 ms in, 8 ms out) and puts the peak at PEAK."""
    x = np.asarray(x, dtype=np.float64)
    x = x - np.mean(x)
    fi = int(SR * 0.003)
    fo = int(SR * 0.008)
    x[:fi] *= np.linspace(0.0, 1.0, fi)
    x[-fo:] *= np.linspace(1.0, 0.0, fo)
    return x * (PEAK / max(1e-9, np.max(np.abs(x))))


def write_ogg(x, path):
    pcm = np.int16(np.clip(x, -1.0, 1.0) * 32767)
    tmp = path + ".wav.tmp"
    import wave
    with wave.open(tmp, "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(SR)
        w.writeframes(pcm.tobytes())
    subprocess.run(["ffmpeg", "-hide_banner", "-loglevel", "error", "-y", "-f", "wav", "-i", tmp, "-c:a", "libvorbis", "-q:a", "4",
                    "-ac", "1", "-ar", str(SR), "-map_metadata", "-1", "-f", "ogg", path], check=True)
    os.remove(tmp)


def main():
    out_dir = sys.argv[1] if len(sys.argv) > 1 else "res/raw"
    os.makedirs(out_dir, exist_ok=True)
    for name, recipe in RECIPES:
        x = finish(recipe())
        path = os.path.join(out_dir, "mr_snd_%s.ogg" % name)
        write_ogg(x, path)
        print("%-9s %4d ms  %6d bytes" % (name, int(1000 * len(x) / SR), os.path.getsize(path)))


if __name__ == "__main__":
    main()
