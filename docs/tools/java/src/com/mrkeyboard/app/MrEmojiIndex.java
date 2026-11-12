package com.mrkeyboard.app;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.Normalizer;
import java.util.Arrays;
import java.util.HashMap;

/**
 * Search of the emoji panel (1.97.0): finds emojis by their names and keywords in the three languages of the app at once, so
 * "coração", "heart" and "corazón" find the same emoji. The words are the CLDR annotations of Unicode (docs/emoji-search.md).
 *
 * Data (res/raw/mr_emoji_en, mr_emoji_pt, mr_emoji_es, UTF-8): one line per emoji of the panel,
 *     emoji TAB name | keyword | keyword ...
 * Blank lines and lines that start with "# " (a hash and a space) are skipped: the keycap of the number sign (#, U+FE0F, U+20E3) is an
 * emoji line that starts with a hash. The three files list the same emojis in the order of the panel.
 *
 * Built to cost little while the keyboard is in use: it is made when the search opens (MrEmojiSearch, in a background
 * thread) and dropped when the panel closes. Each language is kept as ONE char array with every word of every emoji one
 * after another (already without accents and capitals), plus int arrays with where the words start and which emoji they
 * belong to: about 200 KB for the three languages, no object per word. A search is a scan of those words (about 30,000
 * comparisons of a few letters): well under a frame, so it runs on every key typed.
 *
 * Matching: the text typed is made lower case and loses accents and marks (so "nino" finds "niño"), and is cut into words
 * (at most MAX_WORDS). An emoji matches when EVERY word typed begins one of its words (in any language). It scores more
 * when the word is whole and not only a beginning, when it is a word of the name and not a keyword, and when it is the
 * first word of the name; the language of the app wins a tie. Same score: the order of the panel.
 *
 * Not thread safe: the search runs on the main thread (the data is built in the background and handed over whole).
 */
final class MrEmojiIndex {
    /** The languages of the data, in the order of the files. */
    static final String[] LANGS = {"en", "pt", "es"};
    /** Words of the text typed that count; the rest is ignored. */
    static final int MAX_WORDS = 5;

    private static final int NAME = 0;
    private static final int KEYWORD = 1;

    private final int n;
    private final String[] emoji;
    private final char[][] chars = new char[LANGS.length][];     // the words of every emoji, one after another
    private final int[][] start = new int[LANGS.length][];       // start of word t in chars; start[l][t + 1] is where it ends
    private final byte[][] kind = new byte[LANGS.length][];      // NAME or KEYWORD
    private final int[][] first = new int[LANGS.length][];       // words of emoji e: first[l][e] until first[l][e + 1]
    private final long[] work;                                    // the matches of one search (reused)

    private MrEmojiIndex(String[] emoji) {
        this.emoji = emoji;
        this.n = emoji.length;
        this.work = new long[n];
    }

    /** Number of emojis. */
    int size() {
        return n;
    }

    /** The emoji with this number (the order of the panel). */
    String emoji(int id) {
        return emoji[id];
    }

    // ------------------------------------------------------------------ building

    /**
     * Reads the three files (null = that language is missing: it just finds nothing). The emojis and their order are the ones
     * of the first file that is not null; the other files are matched to them by the emoji itself, and an emoji they do not
     * have has no words in that language.
     */
    static MrEmojiIndex parse(InputStream[] files) throws IOException {
        String[][] lines = new String[LANGS.length][];
        int main = -1;
        for (int l = 0; l < LANGS.length; l++) {
            if (l < files.length && files[l] != null) {
                lines[l] = readLines(files[l]);
                if (main < 0) main = l;
            }
        }
        if (main < 0) return new MrEmojiIndex(new String[0]);
        String[] list = new String[lines[main].length];
        HashMap<String, Integer> ids = new HashMap<String, Integer>();
        for (int i = 0; i < list.length; i++) {
            int tab = lines[main][i].indexOf('\t');
            list[i] = tab < 0 ? lines[main][i] : lines[main][i].substring(0, tab);
            ids.put(list[i], Integer.valueOf(i));
        }
        MrEmojiIndex x = new MrEmojiIndex(list);
        for (int l = 0; l < LANGS.length; l++) x.build(l, lines[l], ids);
        return x;
    }

    private static String[] readLines(InputStream in) throws IOException {
        BufferedReader r = new BufferedReader(new InputStreamReader(in, "UTF-8"));
        java.util.ArrayList<String> out = new java.util.ArrayList<String>();
        try {
            String line;
            while ((line = r.readLine()) != null) {
                if (line.length() == 0 || line.startsWith("# ")) continue;
                out.add(line);
            }
        } finally {
            r.close();
        }
        return out.toArray(new String[out.size()]);
    }

    private void build(int l, String[] lines, HashMap<String, Integer> ids) {
        int[] f = new int[n + 1];
        if (lines == null) {
            chars[l] = new char[0];
            start[l] = new int[] {0};
            kind[l] = new byte[0];
            first[l] = f;
            return;
        }
        String[] body = new String[n];
        for (String line : lines) {
            int tab = line.indexOf('\t');
            if (tab <= 0) continue;
            Integer id = ids.get(line.substring(0, tab));
            if (id != null) body[id.intValue()] = line.substring(tab + 1);
        }
        StringBuilder text = new StringBuilder();
        int[] st = new int[64];
        byte[] kd = new byte[64];
        int words = 0;
        for (int e = 0; e < n; e++) {
            f[e] = words;
            if (body[e] == null) continue;
            int from = words;
            String[] parts = body[e].split("[|]");
            for (int p = 0; p < parts.length; p++) {
                String[] ws = normalize(parts[p]).split(" ");
                for (String w : ws) {
                    if (w.length() == 0 || seen(text, st, from, words, w)) continue;
                    if (words + 1 >= st.length) {
                        st = Arrays.copyOf(st, st.length * 2);
                        kd = Arrays.copyOf(kd, kd.length * 2);
                    }
                    st[words] = text.length();
                    kd[words] = (byte) (p == 0 ? NAME : KEYWORD);
                    text.append(w);
                    words++;
                }
            }
        }
        f[n] = words;
        st[words] = text.length();
        char[] all = new char[text.length()];
        text.getChars(0, all.length, all, 0);
        chars[l] = all;
        start[l] = Arrays.copyOf(st, words + 1);
        kind[l] = Arrays.copyOf(kd, words);
        first[l] = f;
    }

    /** True if the word is already among words from..to of the text (an emoji does not keep a word twice). */
    private static boolean seen(StringBuilder text, int[] st, int from, int to, String w) {
        for (int t = from; t < to; t++) {
            int end = t + 1 < to ? st[t + 1] : text.length();
            if (end - st[t] == w.length() && text.indexOf(w, st[t]) == st[t]) return true;
        }
        return false;
    }

    // ------------------------------------------------------------------ text

    /**
     * Lower case, no accents or marks, letters and digits only, words separated by one space, no space at the ends.
     * ("Coração" -> "coracao", "o'clock" -> "o clock".)
     */
    static String normalize(String s) {
        if (s == null) return "";
        String d = Normalizer.normalize(s, Normalizer.Form.NFD);
        StringBuilder b = new StringBuilder(d.length());
        boolean space = true;
        for (int i = 0; i < d.length(); i++) {
            char c = d.charAt(i);
            int type = Character.getType(c);
            if (type == Character.NON_SPACING_MARK || type == Character.COMBINING_SPACING_MARK
                    || type == Character.ENCLOSING_MARK) {
                continue;
            }
            if (Character.isLetterOrDigit(c)) {
                b.append(Character.toLowerCase(c));
                space = false;
            } else if (!space) {
                b.append(' ');
                space = true;
            }
        }
        if (b.length() > 0 && b.charAt(b.length() - 1) == ' ') b.setLength(b.length() - 1);
        return b.toString();
    }

    // ------------------------------------------------------------------ search

    /**
     * The emojis that match the text, best first, at most max. lang is the language of the app ("pt", "en", "es"; anything
     * else counts as none): it wins ties. A text with no letter or digit finds nothing.
     */
    String[] search(String text, String lang, int max) {
        String q = normalize(text);
        if (q.length() == 0 || max <= 0 || n == 0) return new String[0];
        String[] words = q.split(" ");
        int qn = Math.min(words.length, MAX_WORDS);
        int pref = -1;
        for (int l = 0; l < LANGS.length; l++) {
            if (LANGS[l].equals(lang)) pref = l;
        }
        int found = 0;
        for (int e = 0; e < n; e++) {
            int best = 0;
            for (int l = 0; l < LANGS.length; l++) {
                int s = score(l, e, words, qn);
                if (s > 0 && l == pref) s += 1;
                if (s > best) best = s;
            }
            if (best > 0) work[found++] = ((long) (0x7fff - best) << 32) | e;   // best score first, then the order of the panel
        }
        Arrays.sort(work, 0, found);
        int count = Math.min(found, max);
        String[] out = new String[count];
        for (int i = 0; i < count; i++) out[i] = emoji[(int) (work[i] & 0xffffffffL)];
        return out;
    }

    /** Score of emoji e in language l: 0 unless every word typed begins one of its words. */
    private int score(int l, int e, String[] words, int qn) {
        int from = first[l][e];
        int to = first[l][e + 1];
        if (from == to) return 0;
        char[] c = chars[l];
        int[] st = start[l];
        int total = 0;
        for (int w = 0; w < qn; w++) {
            String q = words[w];
            int len = q.length();
            int best = 0;
            for (int t = from; t < to; t++) {
                int wl = st[t + 1] - st[t];
                if (wl < len || !begins(c, st[t], q)) continue;
                int s = wl == len ? 6 : 3;
                if (kind[l][t] == NAME) s += 2;
                if (t == from && w == 0) s += 1;
                if (s > best) best = s;
            }
            if (best == 0) return 0;
            total += best;
        }
        return total;
    }

    private static boolean begins(char[] c, int at, String q) {
        for (int i = 0; i < q.length(); i++) {
            if (c[at + i] != q.charAt(i)) return false;
        }
        return true;
    }
}
