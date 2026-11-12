package com.mrkeyboard.app;

import android.view.View;
import android.view.ViewGroup;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Arrays;

/**
 * Search of the emoji panel (1.97.0): the index of names and keywords in three languages (MrEmojiIndex) and the extra height
 * a panel header can take and give back (MrBar.expand / restore).
 */
public class EmojiSearchTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    static final String HEART = "❤️";
    static final String GRIN = "😀";
    static final String BROKEN = "💔";
    static final String CHILD = "🧒";
    static final String NOMOUTH = "😶";
    static final String HASH = "#" + (char) 0xFE0F + (char) 0x20E3;   // keycap number sign: its line starts with a hash
    static final String BETA_FIRST = "🅱";   // B: listed first in the panel; "beta" in English, "alpha" in Portuguese
    static final String ALPHA_SECOND = "🅰"; // A: listed second; "alpha" in English, "beta" in Portuguese

    static String line(String e, String body) { return e + "\t" + body + "\n"; }

    static final String EN = "# comment line\n\n"
            + line(BETA_FIRST, "beta|zzz") + line(ALPHA_SECOND, "alpha|yyy")
            + line(HEART, "red heart|heart|love") + line(GRIN, "grinning face|face|grin")
            + line(BROKEN, "broken heart|heart|break") + line(CHILD, "child|kid") + line(NOMOUTH, "face without mouth|face|mouth")
            + line(HASH, "keycap: #|hash|pound");
    static final String PT = "# comentario\n"
            + line(BETA_FIRST, "alpha|xxx") + line(ALPHA_SECOND, "beta|www")
            + line(HEART, "coração vermelho|coração|amor") + line(GRIN, "rosto sorrindo|rosto|sorriso")
            + line(BROKEN, "coração partido|coração|partido") + line(CHILD, "criança|menino")
            + line(NOMOUTH, "rosto sem boca|rosto|boca") + line(HASH, "tecla: #|jogo da velha|sustenido");
    // Spanish has no line for the broken heart: it only has words in the other two languages.
    static final String ES = line(BETA_FIRST, "uno|vvv") + line(ALPHA_SECOND, "dos|uuu")
            + line(HEART, "corazón rojo|corazón|amor") + line(GRIN, "cara sonriendo|cara|sonrisa")
            + line(CHILD, "niño|chico") + line(NOMOUTH, "cara sin boca|cara|boca") + line(HASH, "tecla: #|almohadilla");

    static InputStream in(String s) throws Exception { return new ByteArrayInputStream(s.getBytes("UTF-8")); }

    static MrEmojiIndex index() throws Exception {
        return MrEmojiIndex.parse(new InputStream[] {in(EN), in(PT), in(ES)});
    }

    static boolean has(String[] r, String e) { return Arrays.asList(r).contains(e); }
    static int pos(String[] r, String e) { return Arrays.asList(r).indexOf(e); }

    /** A bar with real layout parameters (the stub View has none) that counts the layouts asked for. */
    static class Bar extends View {
        ViewGroup.LayoutParams lp;
        int sets;
        Bar(int height) { lp = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, height); }
        public ViewGroup.LayoutParams getLayoutParams() { return lp; }
        public void setLayoutParams(ViewGroup.LayoutParams p) { lp = p; sets++; }
    }

    public static void main(String[] a) throws Exception {
        // ---- normalize
        check("normalize: capitals and accents go", "coracao".equals(MrEmojiIndex.normalize("Coração")));
        check("normalize: punctuation and edges", "nino".equals(MrEmojiIndex.normalize("  NIÑO!! ")));
        check("normalize: an apostrophe splits the word", "o clock".equals(MrEmojiIndex.normalize("o’clock")));
        check("normalize: digits stay", "1 2 3".equals(MrEmojiIndex.normalize("1, 2 ... 3")));
        check("normalize: null and empty", "".equals(MrEmojiIndex.normalize(null)) && "".equals(MrEmojiIndex.normalize("")));
        check("normalize: only punctuation", "".equals(MrEmojiIndex.normalize(" ?! ")));

        // ---- the index
        MrEmojiIndex x = index();
        check("parse: 8 emojis, in the order of the first file, comments and blank lines skipped, the keycap # kept", x.size() == 8 && BETA_FIRST.equals(x.emoji(0)) && HASH.equals(x.emoji(7)));
        check("the keycap of the number sign is found by its words (its line starts with a hash)", has(x.search("hash", "en", 10), HASH) && has(x.search("almohadilla", "pt", 10), HASH));
        check("a comment is only a line that starts with a hash and a space", x.search("comment", "en", 10).length == 0);

        String[] r = x.search("heart", "en", 10);
        check("english name: both hearts, the panel order between equals", r.length == 2 && HEART.equals(r[0]) && BROKEN.equals(r[1]));
        r = x.search("red heart", "en", 10);
        check("two words: every word has to match", r.length == 1 && HEART.equals(r[0]));
        r = x.search("heart red", "en", 10);
        check("two words in any order", r.length == 1 && HEART.equals(r[0]));
        r = x.search("coracao", "pt", 10);
        check("portuguese without the accent finds the hearts", r.length == 2 && has(r, HEART) && has(r, BROKEN));
        r = x.search("CORAÇÃO", "en", 10);
        check("portuguese typed with accent and capitals, app in English: same hearts", r.length == 2 && has(r, HEART) && has(r, BROKEN));
        r = x.search("corazon", "pt", 10);
        check("spanish word found while the app is in Portuguese", has(r, HEART));
        check("the broken heart has no spanish words: not found by 'corazon'", !has(r, BROKEN));
        r = x.search("nino", "es", 10);
        check("spanish 'nino' finds the child", r.length == 1 && CHILD.equals(r[0]));
        check("spanish 'niño' with the tilde finds it too", Arrays.equals(r, x.search("niño", "es", 10)));
        check("english name of the same emoji", has(x.search("kid", "pt", 10), CHILD));
        check("a keyword of another language: 'amor' finds the red heart", has(x.search("amor", "en", 10), HEART));
        check("prefix: 'hea'", x.search("hea", "en", 10).length == 2);
        check("a prefix is not in the middle of a word: 'eart' finds nothing", x.search("eart", "en", 10).length == 0);
        check("a longer word than the one in the data finds nothing", x.search("heartx", "en", 10).length == 0);
        check("no match at all", x.search("zzzzqq", "en", 10).length == 0);
        check("'gri' finds the grin by its name", has(x.search("gri", "en", 10), GRIN));

        // ---- ranking
        r = x.search("face", "en", 10);
        check("first word of the name ranks above a later word of the name", r.length >= 2 && pos(r, NOMOUTH) < pos(r, GRIN));
        r = x.search("face", "pt", 10);
        check("'face' is found through the english words even in Portuguese", has(r, GRIN) && has(r, NOMOUTH));
        r = x.search("alpha", "en", 10);
        check("tie: the language of the app wins (English)", r.length == 2 && ALPHA_SECOND.equals(r[0]) && BETA_FIRST.equals(r[1]));
        r = x.search("alpha", "pt", 10);
        check("tie: the language of the app wins (Portuguese)", r.length == 2 && BETA_FIRST.equals(r[0]) && ALPHA_SECOND.equals(r[1]));
        r = x.search("alpha", "es", 10);
        check("tie in a language with no match: the order of the panel", r.length == 2 && BETA_FIRST.equals(r[0]));
        r = x.search("alpha", "", 10);
        check("no language: the order of the panel", r.length == 2 && BETA_FIRST.equals(r[0]));
        r = x.search("alpha", null, 10);
        check("language null does not break", r.length == 2);

        // ---- limits and odd input
        check("max cuts the list", x.search("heart", "en", 1).length == 1 && HEART.equals(x.search("heart", "en", 1)[0]));
        check("max 0 and negative: nothing", x.search("heart", "en", 0).length == 0 && x.search("heart", "en", -3).length == 0);
        check("empty text: nothing", x.search("", "en", 10).length == 0);
        check("only spaces and punctuation: nothing", x.search("  ?! ", "en", 10).length == 0);
        check("null text: nothing", x.search(null, "en", 10).length == 0);
        check("the sixth word and the next ones are ignored", has(x.search("red heart red heart red zzzz", "en", 10), HEART));
        check("repeated searches give the same (the work array is reused)", Arrays.equals(x.search("heart", "en", 10), x.search("heart", "en", 10)));
        String[] big = x.search("a", "en", 10);
        check("a single letter works", big.length > 0);

        // ---- missing data
        MrEmojiIndex noPt = MrEmojiIndex.parse(new InputStream[] {in(EN), null, in(ES)});
        check("a language missing: the others still work", has(noPt.search("heart", "en", 10), HEART) && noPt.search("coracao", "pt", 10).length == 0);
        MrEmojiIndex onlyPt = MrEmojiIndex.parse(new InputStream[] {null, in(PT), null});
        check("the emojis come from the first file that exists", onlyPt.size() == 8 && has(onlyPt.search("coracao", "pt", 10), HEART));
        MrEmojiIndex none = MrEmojiIndex.parse(new InputStream[] {null, null, null});
        check("no file at all: no emojis, no exception", none.size() == 0 && none.search("heart", "en", 10).length == 0);
        MrEmojiIndex shortList = MrEmojiIndex.parse(new InputStream[] {in(EN)});
        check("fewer streams than languages: no exception", shortList.size() == 8 && has(shortList.search("heart", "en", 10), HEART));
        MrEmojiIndex noTab = MrEmojiIndex.parse(new InputStream[] {in("abc\n" + line(HEART, "heart")), null, null});
        check("a line without a tab is an emoji with no words, and does not break the others", noTab.size() == 2 && has(noTab.search("heart", "en", 10), HEART));

        // ---- the real words (res/raw, made by docs/tools/make_emoji_search.py from the CLDR files), when the test runs at the project root
        java.io.File rawEn = new java.io.File("res/raw/mr_emoji_en.txt");
        if (rawEn.exists()) {
            MrEmojiIndex real = MrEmojiIndex.parse(new InputStream[] {new java.io.FileInputStream(rawEn),
                    new java.io.FileInputStream("res/raw/mr_emoji_pt.txt"), new java.io.FileInputStream("res/raw/mr_emoji_es.txt")});
            String flagBr = new String(Character.toChars(0x1F1E7)) + new String(Character.toChars(0x1F1F7));
            String cat = new String(Character.toChars(0x1F431));
            String pizza = new String(Character.toChars(0x1F355));
            check("real words: the emojis of the panel (the 1633 of the base list and the newer ones), the keycap # among them", real.size() >= 1633 + 150 && has(real.search("keycap", "en", 100), HASH));
            String melting = new String(Character.toChars(0x1FAE0));
            String phoenix = new String(Character.toChars(0x1F426)) + (char) 0x200D + new String(Character.toChars(0x1F525));
            check("real words: the newer emojis are found: 'melting' (en), 'derretendo' (pt), 'derritiendose' (es) give the melting face",
                    has(real.search("melting", "en", 60), melting) && has(real.search("derretendo", "pt", 60), melting) && has(real.search("derritiendose", "es", 60), melting));
            check("real words: a newer sequence (the phoenix, a bird and fire joined) is found by 'phoenix' and by 'fenix' in Spanish", has(real.search("phoenix", "en", 60), phoenix) && has(real.search("fenix", "es", 60), phoenix));
            check("real words: 'cora\u00E7\u00E3o' in Portuguese finds the red heart", has(real.search("cora\u00E7\u00E3o", "pt", 60), HEART));
            check("real words: 'coracao' without the accent finds it too", has(real.search("coracao", "pt", 60), HEART));
            check("real words: 'heart' in English", has(real.search("heart", "en", 60), HEART));
            check("real words: 'corazon' in Spanish", has(real.search("corazon", "es", 60), HEART));
            check("real words: 'gato' finds the cat face, and so does 'cat'", has(real.search("gato", "pt", 60), cat) && has(real.search("cat", "en", 60), cat));
            check("real words: 'pizza' in the three languages", has(real.search("pizza", "pt", 10), pizza) && has(real.search("pizza", "en", 10), pizza) && has(real.search("pizza", "es", 10), pizza));
            String[] br = real.search("bandeira brasil", "pt", 10);
            check("real words: 'bandeira brasil' finds only the flag of Brazil", br.length == 1 && flagBr.equals(br[0]));
            check("real words: 'brazil flag' (English) and 'bandera brasil' (Spanish) find it too", has(real.search("brazil flag", "en", 10), flagBr) && has(real.search("bandera brasil", "es", 10), flagBr));
            check("real words: a bracket or other punctuation finds nothing (only emojis are searched)",
                    real.search("{", "en", 60).length == 0 && real.search("(", "en", 60).length == 0 && real.search("!?", "pt", 60).length == 0);
            check("real words: the three languages answer a single letter", real.search("a", "en", 60).length == 60 && real.search("a", "pt", 60).length == 60 && real.search("a", "es", 60).length == 60);
            long t0 = System.nanoTime();
            int sink = 0;
            for (int i = 0; i < 300; i++) sink += real.search(i % 2 == 0 ? "co" : "rosto feliz", "pt", 60).length;
            double ms = (System.nanoTime() - t0) / 1e6 / 300;
            System.out.println("INFO  real words: " + String.format(java.util.Locale.US, "%.2f", ms) + " ms per search on this PC (" + sink + ")");
            check("real words: a search is far under a frame (16 ms) on the PC", ms < 16);
        } else {
            System.out.println("SKIP  real words: res/raw/mr_emoji_en.txt not found (run at the project root)");
        }

        // ---- MrBar.expand / restore
        Bar bar = new Bar(100);
        check("not expanded at first", !MrBar.expanded(bar));
        MrBar.expand(bar, 300);
        check("expand: taller", bar.lp.height == 300 && MrBar.expanded(bar));
        MrBar.expand(bar, 250);
        check("expand again: only the height changes", bar.lp.height == 250 && MrBar.expanded(bar));
        int before = bar.sets;
        MrBar.expand(bar, 250);
        check("expand with the same height does not ask for another layout", bar.sets == before);
        MrBar.apply(bar);
        check("the bar-height setting does not undo an expanded bar", bar.lp.height == 250);
        MrBar.restore(bar);
        check("restore: the first height comes back (not the second)", bar.lp.height == 100 && !MrBar.expanded(bar));
        before = bar.sets;
        MrBar.restore(bar);
        check("restore twice: nothing happens", bar.lp.height == 100 && bar.sets == before);
        MrBar.expand(bar, 300);
        MrBar.restore(bar);
        MrBar.expand(bar, 200);
        check("a new expand after a restore starts from the height of the bar", bar.lp.height == 200);
        MrBar.restore(bar);
        check("and goes back to it", bar.lp.height == 100);
        MrBar.expand(null, 100);
        MrBar.restore(null);
        check("null bar: no exception", !MrBar.expanded(null));
        Bar zero = new Bar(100);
        MrBar.expand(zero, 0);
        MrBar.expand(zero, -5);
        check("a height of zero or less is ignored", zero.lp.height == 100 && !MrBar.expanded(zero));
        Bar noLp = new Bar(100) { public ViewGroup.LayoutParams getLayoutParams() { return null; } };
        MrBar.expand(noLp, 300);
        MrBar.restore(noLp);
        check("a bar with no layout parameters yet: no exception and not marked as expanded", !MrBar.expanded(noLp));

        System.out.println("\n" + ok + " OK, " + fail + " FAIL");
        if (fail > 0) System.exit(1);
    }
}
