package com.mrkeyboard.app;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * Language rules that come in the dictionary pack (rules.txt, v1.63). Before 1.63 these rules
 * were Portuguese ones and lived in the code (MrFix, MrPredict, MrFuzzy); now each pack brings its own.
 *
 * Format 1 (see dicts/pt-BR/rules.txt): sections [name], comments with #, empty lines ignored.
 *   [sentence_start]   one word per line (up to 3)
 *   [corrections]      typed TAB suggestion
 *   [phonetic]         "a b": letters that sound alike (cost C_PHON)
 *   [vowels]           "a b": vowels that get confused (cost C_VOWEL)
 *   [groups]           "typed = dictionary": 2 letters for 1 or 1 for 2 (cost C_MULTI)
 *   [silent]           "before letter [cost]": dictionary letter that may be missing; ^ = start,
 *                      * = after any letter (v1.64)
 *   [extra]            letter that may be extra in the typed word
 *   [one_letter_words] one-letter words (to split run-together words)
 * Unknown sections and lines that do not follow the format are ignored (future packs).
 */
public final class MrRules {
    static final int DEFAULT_SILENT_START = 30;  // h at the start ("omem")
    static final int DEFAULT_SILENT = 45;        // silent letter after another one ("trabalo")
    static final int MAX_STARTERS = 3;

    static final MrRules EMPTY = new MrRules();
    private static volatile MrRules sCurrent = EMPTY;

    /** Rules of the pack in use (never null; without a pack, empty). */
    public static MrRules get() {
        return sCurrent;
    }

    static void set(MrRules r) {
        sCurrent = r != null ? r : EMPTY;
    }

    String[] starters = new String[0];
    final HashMap<String, String> corrections = new HashMap<String, String>();
    /** [(a << 8) | b] = 1 phonetic, 2 vowel (both directions), for letters < 256. */
    final byte[] pairs = new byte[65536];
    // groups: typed (2 letters, no accent) -> dictionary (1 letter, lowercase)
    char[] t2a = new char[0], t2b = new char[0], t2d = new char[0];
    // groups: dictionary (2 letters, lowercase) -> typed (1 letter, no accent)
    char[] d2p = new char[0], d2c = new char[0], d2t = new char[0];
    /** cost of the silent letter at the start of the word (0 = not silent). */
    final short[] silentStart = new short[256];
    /** cost of the letter that may be missing after any other ("*", v1.64; 0 = it may not). */
    final short[] silentAny = new short[256];
    // silent letter after another one: previous, letter, cost
    char[] silPrev = new char[0], silChar = new char[0];
    short[] silCost = new short[0];
    final boolean[] extra = new boolean[256];
    final boolean[] oneLetter = new boolean[256];

    boolean isEmpty() {
        return this == EMPTY;
    }

    static MrRules parse(InputStream in) throws IOException {
        BufferedReader r = new BufferedReader(new InputStreamReader(in, "UTF-8"));
        MrRules m = new MrRules();
        ArrayList<String> starters = new ArrayList<String>();
        StringBuilder t2 = new StringBuilder(), d2 = new StringBuilder(), sil = new StringBuilder();
        ArrayList<Short> silCosts = new ArrayList<Short>();
        String section = "";
        String line;
        int lines = 0;
        while ((line = r.readLine()) != null) {
            if (++lines > 20000) break;
            if (lines == 1 && line.length() > 0 && line.charAt(0) == '﻿') line = line.substring(1);
            String s = line.trim();
            if (s.length() == 0 || s.charAt(0) == '#') continue;
            if (s.charAt(0) == '[' && s.charAt(s.length() - 1) == ']') {
                section = s.substring(1, s.length() - 1).trim();
                continue;
            }
            if (section.equals("sentence_start")) {
                if (starters.size() < MAX_STARTERS && s.length() <= MrPredict.MAX_WORD) starters.add(s);
            } else if (section.equals("corrections")) {
                int tab = line.indexOf('\t');
                if (tab <= 0) continue;
                String k = MrFix.key(line.substring(0, tab).trim());
                String v = line.substring(tab + 1).trim();
                if (k != null && v.length() > 0 && v.length() <= MrPredict.MAX_WORD) m.corrections.put(k, v);
            } else if (section.equals("phonetic") || section.equals("vowels")) {
                String[] p = s.split("\\s+");
                if (p.length < 2 || p[0].length() != 1 || p[1].length() != 1) continue;
                char a = MrText.base(p[0].charAt(0)), b = MrText.base(p[1].charAt(0));
                if (a >= 256 || b >= 256 || a == b) continue;
                byte kind = section.equals("phonetic") ? (byte) 1 : (byte) 2;
                m.pairs[(a << 8) | b] = kind;
                m.pairs[(b << 8) | a] = kind;
            } else if (section.equals("groups")) {
                int eq = s.indexOf('=');
                if (eq <= 0) continue;
                String typed = s.substring(0, eq).trim(), dict = s.substring(eq + 1).trim();
                if (typed.length() == 2 && dict.length() == 1) {
                    t2.append(MrText.base(typed.charAt(0))).append(MrText.base(typed.charAt(1)))
                      .append(Character.toLowerCase(dict.charAt(0)));
                } else if (typed.length() == 1 && dict.length() == 2) {
                    d2.append(Character.toLowerCase(dict.charAt(0))).append(Character.toLowerCase(dict.charAt(1)))
                      .append(MrText.base(typed.charAt(0)));
                }
            } else if (section.equals("silent")) {
                String[] p = s.split("\\s+");
                if (p.length < 2 || p[0].length() != 1 || p[1].length() != 1) continue;
                char letter = MrText.base(p[1].charAt(0));
                if (letter >= 256) continue;
                boolean start = p[0].equals("^");
                int cost = start ? DEFAULT_SILENT_START : DEFAULT_SILENT;
                if (p.length >= 3) {
                    try {
                        cost = Integer.parseInt(p[2]);
                    } catch (NumberFormatException e) {
                        continue;
                    }
                    if (cost < 1 || cost > 200) continue;
                }
                if (start) {
                    m.silentStart[letter] = (short) cost;
                } else if (p[0].equals("*")) {
                    m.silentAny[letter] = (short) cost;
                } else {
                    sil.append(MrText.base(p[0].charAt(0))).append(letter);
                    silCosts.add((short) cost);
                }
            } else if (section.equals("extra")) {
                if (s.length() == 1) {
                    char c = MrText.base(s.charAt(0));
                    if (c < 256) m.extra[c] = true;
                }
            } else if (section.equals("one_letter_words")) {
                if (s.length() == 1) {
                    char c = MrText.base(s.charAt(0));
                    if (c < 256) m.oneLetter[c] = true;
                }
            }
        }
        m.starters = starters.toArray(new String[0]);
        int n = t2.length() / 3;
        m.t2a = new char[n]; m.t2b = new char[n]; m.t2d = new char[n];
        for (int i = 0; i < n; i++) {
            m.t2a[i] = t2.charAt(3 * i); m.t2b[i] = t2.charAt(3 * i + 1); m.t2d[i] = t2.charAt(3 * i + 2);
        }
        n = d2.length() / 3;
        m.d2p = new char[n]; m.d2c = new char[n]; m.d2t = new char[n];
        for (int i = 0; i < n; i++) {
            m.d2p[i] = d2.charAt(3 * i); m.d2c[i] = d2.charAt(3 * i + 1); m.d2t[i] = d2.charAt(3 * i + 2);
        }
        n = sil.length() / 2;
        m.silPrev = new char[n]; m.silChar = new char[n]; m.silCost = new short[n];
        for (int i = 0; i < n; i++) {
            m.silPrev[i] = sil.charAt(2 * i); m.silChar[i] = sil.charAt(2 * i + 1); m.silCost[i] = silCosts.get(i);
        }
        return m;
    }

    /** Cost of swapping a for b (letters without accent): 0 = no rule, 1 phonetic, 2 vowel. */
    int pair(char a, char b) {
        if (a >= 256 || b >= 256) return 0;
        return pairs[(a << 8) | b];
    }
}
