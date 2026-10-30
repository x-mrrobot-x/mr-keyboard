package com.mrkeyboard.app;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * Regras do idioma que vêm no pacote de dicionário (rules.txt, v1.63). Antes da 1.63 essas regras
 * eram do português e ficavam no código (MrFix, MrPredict, MrFuzzy); agora cada pacote traz as dele.
 *
 * Formato 1 (veja dicts/pt-BR/rules.txt): seções [nome], comentários com #, linhas vazias ignoradas.
 *   [sentence_start]   uma palavra por linha (até 3)
 *   [corrections]      digitado TAB sugestão
 *   [phonetic]         "a b": letras que soam parecido (custo C_PHON)
 *   [vowels]           "a b": vogais que se confundem (custo C_VOWEL)
 *   [groups]           "digitado = dicionário": 2 letras por 1 ou 1 por 2 (custo C_MULTI)
 *   [silent]           "antes letra [custo]": letra do dicionário que pode faltar; ^ = começo,
 *                      * = depois de qualquer letra (v1.64)
 *   [extra]            letra que pode sobrar no digitado
 *   [one_letter_words] palavras de uma letra (separar palavras juntas)
 * Seções desconhecidas e linhas que não seguem o formato são ignoradas (pacotes futuros).
 */
public final class MrRules {
    static final int DEFAULT_SILENT_START = 30;  // h no começo ("omem")
    static final int DEFAULT_SILENT = 45;        // letra muda depois de outra ("trabalo")
    static final int MAX_STARTERS = 3;

    static final MrRules EMPTY = new MrRules();
    private static volatile MrRules sCurrent = EMPTY;

    /** Regras do pacote em uso (nunca null; sem pacote, vazias). */
    public static MrRules get() {
        return sCurrent;
    }

    static void set(MrRules r) {
        sCurrent = r != null ? r : EMPTY;
    }

    String[] starters = new String[0];
    final HashMap<String, String> corrections = new HashMap<String, String>();
    /** [(a << 8) | b] = 1 fonética, 2 vogal (os dois sentidos), para letras < 256. */
    final byte[] pairs = new byte[65536];
    // grupos: digitado (2 letras, sem acento) -> dicionário (1 letra, minúscula)
    char[] t2a = new char[0], t2b = new char[0], t2d = new char[0];
    // grupos: dicionário (2 letras, minúsculas) -> digitado (1 letra, sem acento)
    char[] d2p = new char[0], d2c = new char[0], d2t = new char[0];
    /** custo da letra muda no começo da palavra (0 = não é muda). */
    final short[] silentStart = new short[256];
    /** custo da letra que pode faltar depois de qualquer outra ("*", v1.64; 0 = não pode). */
    final short[] silentAny = new short[256];
    // letra muda depois de outra: anterior, letra, custo
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

    /** Custo da troca de a por b (letras sem acento): 0 = nenhuma regra, 1 fonética, 2 vogal. */
    int pair(char a, char b) {
        if (a >= 256 || b >= 256) return 0;
        return pairs[(a << 8) | b];
    }
}
