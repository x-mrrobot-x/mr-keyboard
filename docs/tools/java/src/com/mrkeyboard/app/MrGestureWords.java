package com.mrkeyboard.app;

import java.lang.ref.WeakReference;
import java.nio.ByteBuffer;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Gesture typing, the words of the person (1.96.0, docs/gesture-typing.md): the words the keyboard learned, the ones
 * added in "Add words and texts" and the ones of the user dictionary of Android can be written by a gesture too.
 *
 * The recognition searches dictionaries of the main.dict format (engine/src/mr_gesture.h), and the words of the person live in
 * two trees the keyboard fills while it runs (AutoDictionary and UserDictionary, both ExpandableDictionary). This class keeps
 * a copy of those words as a small dictionary of that format, in memory, and MrGesture.decode hands it to the lib as the
 * second dictionary of each gesture (Gesture::more: the network does not run again; the two lists are merged by score).
 *
 * The copy is made again only when something changed, and on the keyboard thread, when a gesture begins (never when the
 * finger lifts): ExpandableDictionary.addWord and clearDictionary call changed() (hand-edited smali), MrLearned calls it when
 * the list of blocked words is read, and a language change brings other dictionary objects. A tree that its loading thread is
 * still filling is not read: the copy there is stays in use and the next gesture tries again.
 *
 * Which words go in:
 *   - of the learned ones, those the keyboard already suggests (frequency LEARNED_MIN or more: typed a few times), and every
 *     added word; of the user dictionary, every word;
 *   - never a blocked word (MrLearned.isBlocked);
 *   - a word with a character that has no key is written to the copy all the same: the search leaves it out (as it does with
 *     main.dict).
 * Their frequency in the copy goes from FREQ_LOW (just learned) to FREQ_HIGH (used often, or added with the highest weight).
 * The two values were measured (docs/gesture-typing.md, "The words of the person"): higher, and words of main.dict start
 * losing their place to them; lower, and the person's own words stay behind similar words of main.dict.
 */
public final class MrGestureWords {
    private MrGestureWords() { }

    /** Frequency, in the copy, of a word the keyboard has just started to suggest... */
    static final int FREQ_LOW = 100;
    /** ...and of a word with the highest frequency the keyboard gives (FULL). In between, in proportion. */
    static final int FREQ_HIGH = 130;
    /** A learned word counts from this frequency on: the value from which the keyboard suggests it (AutoDictionary). */
    static final int LEARNED_MIN = 6;
    /** The frequency of a word used often (AutoDictionary.FREQUENCY_FOR_AUTO_ADD) and of the highest weight of an added word. */
    static final int FULL = 250;
    /** At most this many words in the copy: with more, the ones of the highest frequency stay. */
    static final int MAX_WORDS = 10000;
    /** Longest word (characters): the limit of the lib (kMaxWord). */
    static final int MAX_CHARS = MrFuzzy.MAX_WORD;
    /** The format has 22 bits for an address. */
    private static final int MAX_BYTES = 0x3FFFFF;

    private static final AtomicInteger sChanges = new AtomicInteger();

    /**
     * A word of the person was added, changed or thrown away, or the blocked words changed: the copy is made again before the
     * next gesture. Called from any thread, by smali that must never see an exception: it only counts.
     */
    public static void changed() {
        sChanges.incrementAndGet();
    }

    // ------------------------------------------------------------------ the copy in use

    private static WeakReference<Dictionary> sAuto, sUser;     // the dictionaries the copy was made from
    private static int sAt;                                     // sChanges when it was made
    private static boolean sMade;
    private static ByteBuffer sBuffer;                          // null = no words
    private static int sWords;
    private static long sLastNs;

    /**
     * The dictionary of the words of the person for the language in use, or null when there is none. Keyboard thread only (the
     * trees are changed on it and by their loading threads, which are waited for). The buffer is a direct one and holds exactly
     * the dictionary: capacity() is its size. Never throws.
     */
    static synchronized ByteBuffer get(LatinIME ime) {
        try {
            final Suggest s = ime != null ? ime.mrSuggest() : null;
            final Dictionary auto = s != null ? s.mrAutoDict() : null;
            final Dictionary user = s != null ? s.mrUserDict() : null;
            final int at = sChanges.get();            // read before the trees: a change during the reading makes the next call read again
            final boolean same = sMade && is(sAuto, auto) && is(sUser, user);
            if (same && at == sAt) return sBuffer;
            if (loading(auto) || loading(user)) return same ? sBuffer : null;
            final long t0 = System.nanoTime();
            final Collector c = new Collector();
            if (auto instanceof ExpandableDictionary) c.read(((ExpandableDictionary) auto).mrRoots(), LEARNED_MIN);
            if (user instanceof ExpandableDictionary) c.read(((ExpandableDictionary) user).mrRoots(), 0);
            c.keepBest(MAX_WORDS);
            sBuffer = build(c.words, c.freqs, c.n);
            sWords = sBuffer != null ? c.n : 0;
            sAuto = new WeakReference<Dictionary>(auto);
            sUser = new WeakReference<Dictionary>(user);
            sAt = at;
            sMade = true;
            sLastNs = System.nanoTime() - t0;
            return sBuffer;
        } catch (Throwable t) {
            // a gesture without the words of the person is still a gesture
            sMade = false;
            sBuffer = null;
            sWords = 0;
            return null;
        }
    }

    private static boolean is(WeakReference<Dictionary> ref, Dictionary d) {
        return ref != null && ref.get() == d;
    }

    /** Is the tree being filled by its loading thread? (The question also starts a reload that is due, as every search does.) */
    private static boolean loading(Dictionary d) {
        return d instanceof ExpandableDictionary && ((ExpandableDictionary) d).reloadDictionaryIfRequired();
    }

    /** {words in the copy in use, nanoseconds the last copy took to make, bytes of the copy}: for the settings screen and the tests. */
    static synchronized long[] stats() {
        return new long[] {sWords, sLastNs, sBuffer != null ? sBuffer.capacity() : 0};
    }

    /** Tests only. */
    static synchronized void resetForTest() {
        sAuto = sUser = null;
        sMade = false;
        sBuffer = null;
        sWords = 0;
        sLastNs = 0;
    }

    // ------------------------------------------------------------------ reading the trees

    /** The frequency of a word of the person (what the keyboard keeps, up to 255) -> its frequency in the copy. */
    static int freq(int f) {
        if (f >= FULL) return FREQ_HIGH;
        if (f <= LEARNED_MIN) return FREQ_LOW;
        return FREQ_LOW + (f - LEARNED_MIN) * (FREQ_HIGH - FREQ_LOW) / (FULL - LEARNED_MIN);
    }

    /** The words read so far: spelling and the frequency the keyboard keeps (the largest one when a word comes twice). */
    static final class Collector {
        String[] words = new String[256];
        int[] freqs = new int[256];
        int n;
        private final char[] buf = new char[MAX_CHARS];
        private java.util.HashMap<String, Integer> index = new java.util.HashMap<String, Integer>();

        /** Every word of this tree with at least this frequency, unless it is blocked. */
        void read(ExpandableDictionary.NodeArray roots, int minFreq) {
            walk(roots, 0, minFreq);
        }

        private void walk(ExpandableDictionary.NodeArray level, int depth, int minFreq) {
            if (level == null || depth >= MAX_CHARS) return;
            final ExpandableDictionary.Node[] data = level.data;
            if (data == null) return;
            final int count = Math.min(level.length, data.length);
            for (int i = 0; i < count; i++) {
                final ExpandableDictionary.Node node = data[i];
                if (node == null) continue;
                buf[depth] = node.code;
                if (node.terminal && node.frequency >= minFreq) add(new String(buf, 0, depth + 1), node.frequency);
                walk(node.children, depth + 1, minFreq);
            }
        }

        void add(String word, int freq) {
            if (word == null || word.length() == 0 || word.length() > MAX_CHARS || MrLearned.isBlocked(word)) return;
            final Integer seen = index.get(word);
            if (seen != null) {
                if (freq > freqs[seen.intValue()]) freqs[seen.intValue()] = freq;
                return;
            }
            if (n == words.length) {
                words = java.util.Arrays.copyOf(words, 2 * n);
                freqs = java.util.Arrays.copyOf(freqs, 2 * n);
            }
            index.put(word, Integer.valueOf(n));
            words[n] = word;
            freqs[n] = freq;
            n++;
        }

        /** Leaves at most max words: the ones of the highest frequency (with the same frequency, the first ones read). */
        void keepBest(int max) {
            index = null;                      // not needed any more
            if (n <= max) return;
            final int[] counts = new int[257];
            for (int i = 0; i < n; i++) counts[clamp(freqs[i])]++;
            int cut = 255, above = 0;          // every word over `cut` stays; of the ones at `cut`, the first `room`
            while (cut > 0 && above + counts[cut] <= max) above += counts[cut--];
            int room = max - above, k = 0;
            for (int i = 0; i < n; i++) {
                final int f = clamp(freqs[i]);
                if (f < cut || (f == cut && room-- <= 0)) continue;
                words[k] = words[i];
                freqs[k] = freqs[i];
                k++;
            }
            n = k;
        }

        private static int clamp(int f) {
            return f < 0 ? 0 : f > 255 ? 255 : f;
        }
    }

    // ------------------------------------------------------------------ writing the dictionary

    /**
     * A dictionary of the main.dict format (the one with the two-byte header and the pair lists, here all empty) with the first
     * n of these words, each with freq() of its frequency. Returns null when no word can be written.
     *
     * The format (the reader is GestureDict in engine/src/mr_gesture_decode.cpp): byte 200, byte 1, then groups. A group is a
     * count (1 byte) and that many entries: the character (1 byte; 0xFF and 2 bytes from U+00FF on), a byte of flags (0x80 =
     * the entry ends a word, 0x40 = it has children, and then the low 6 bits and the next 2 bytes are the address of their
     * group) and, when it ends a word, its frequency (1 byte) and one zero byte (no pairs).
     */
    static ByteBuffer build(String[] words, int[] freqs, int n) {
        if (words == null || freqs == null || n <= 0) return null;
        // the tree: node 0 is the root; the children of a node are a chain (kid -> next)
        int cap = 64;
        char[] ch = new char[cap];
        int[] kid = new int[cap], last = new int[cap], next = new int[cap], kids = new int[cap], freq = new int[cap];
        int nodes = 1;
        freq[0] = -1;
        int written = 0;
        for (int w = 0; w < n; w++) {
            final String word = words[w];
            if (word == null || word.length() == 0 || word.length() > MAX_CHARS) continue;
            int cur = 0;
            boolean fits = true;
            for (int i = 0; i < word.length() && fits; i++) {
                final char c = word.charAt(i);
                int k = kid[cur];
                while (k != 0 && ch[k] != c) k = next[k];
                if (k == 0) {
                    if (kids[cur] >= 255) {            // a group holds 255 entries at most: this word does not fit
                        fits = false;
                        break;
                    }
                    if (nodes == cap) {
                        cap *= 2;
                        ch = java.util.Arrays.copyOf(ch, cap);
                        kid = java.util.Arrays.copyOf(kid, cap);
                        last = java.util.Arrays.copyOf(last, cap);
                        next = java.util.Arrays.copyOf(next, cap);
                        kids = java.util.Arrays.copyOf(kids, cap);
                        freq = java.util.Arrays.copyOf(freq, cap);
                    }
                    k = nodes++;
                    ch[k] = c;
                    kid[k] = last[k] = next[k] = kids[k] = 0;
                    freq[k] = -1;
                    if (kid[cur] == 0) kid[cur] = k; else next[last[cur]] = k;
                    last[cur] = k;
                    kids[cur]++;
                }
                cur = k;
            }
            if (!fits) continue;      // the nodes already made for it end no word: they are left out below
            final int f = freq(freqs[w]);
            if (f > freq[cur]) freq[cur] = f;
            written++;
        }
        if (written == 0) return null;
        // which nodes lead to a word (a word that did not fit left branches that lead nowhere)
        final boolean[] live = new boolean[nodes];
        final int[] parent = new int[nodes];
        for (int p = 0; p < nodes; p++) for (int k = kid[p]; k != 0; k = next[k]) parent[k] = p;
        for (int i = nodes - 1; i >= 1; i--) {         // a child always has a larger number than its parent
            if (freq[i] >= 0) live[i] = true;
            if (live[i]) live[parent[i]] = true;
        }
        // the place of each group, breadth first (the order the reader of main.dict is used to)
        final int[] group = new int[nodes], order = new int[nodes];
        int queued = 1, pos = 2;
        for (int q = 0; q < queued; q++) {
            final int p = order[q];
            int liveKids = 0;
            for (int k = kid[p]; k != 0; k = next[k]) if (live[k]) liveKids++;
            if (liveKids == 0) continue;
            group[p] = pos;
            pos += 1;
            for (int k = kid[p]; k != 0; k = next[k]) {
                if (!live[k]) continue;
                pos += (ch[k] >= 0xFF ? 3 : 1) + (hasLiveKid(k, kid, next, live) ? 3 : 1) + (freq[k] >= 0 ? 2 : 0);
                order[queued++] = k;
            }
            if (pos > MAX_BYTES) return null;          // far more than any person's words: no copy rather than a broken one
        }
        final ByteBuffer out = ByteBuffer.allocateDirect(pos);
        out.put(0, (byte) 200);
        out.put(1, (byte) 1);
        for (int q = 0; q < queued; q++) {
            final int p = order[q];
            if (group[p] == 0) continue;
            int at = group[p], count = 0;
            for (int k = kid[p]; k != 0; k = next[k]) if (live[k]) count++;
            out.put(at++, (byte) count);
            for (int k = kid[p]; k != 0; k = next[k]) {
                if (!live[k]) continue;
                final char c = ch[k];
                if (c >= 0xFF) {
                    out.put(at++, (byte) 0xFF);
                    out.put(at++, (byte) (c >> 8));
                    out.put(at++, (byte) c);
                } else {
                    out.put(at++, (byte) c);
                }
                final int flags = freq[k] >= 0 ? 0x80 : 0;
                final int g = group[k];
                if (g != 0) {
                    out.put(at++, (byte) (flags | 0x40 | (g >> 16)));
                    out.put(at++, (byte) (g >> 8));
                    out.put(at++, (byte) g);
                } else {
                    out.put(at++, (byte) flags);
                }
                if (freq[k] >= 0) {
                    out.put(at++, (byte) freq[k]);
                    out.put(at++, (byte) 0);
                }
            }
        }
        return out;
    }

    private static boolean hasLiveKid(int node, int[] kid, int[] next, boolean[] live) {
        for (int k = kid[node]; k != 0; k = next[k]) if (live[k]) return true;
        return false;
    }
}
