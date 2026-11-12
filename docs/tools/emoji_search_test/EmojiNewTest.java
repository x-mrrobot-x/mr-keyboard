package com.mrkeyboard.app;

import android.graphics.Paint;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;

/**
 * The emojis newer than the base list of the panel (MrEmojiNew, 1.97.0): the table, the merge into the base list, what the
 * phone cannot draw (Paint.hasGlyph, asked once and kept) and the filter of the search results.
 */
public class EmojiNewTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    static String join(String... s) {
        StringBuilder b = new StringBuilder();
        for (int i = 0; i < s.length; i++) {
            if (i > 0) b.append('|');
            b.append(s[i]);
        }
        return b.toString();
    }

    static String[] split(String s) { return s.split("[|]"); }

    /** The anchors of a category in the order of the table, and the new emojis of each (all of them). */
    static String[] anchors(int cat) {
        String[] g = MrEmojiNew.groups(cat);
        String[] a = new String[g.length];
        for (int i = 0; i < g.length; i++) a[i] = split(g[i])[0];
        return a;
    }

    /** Forgets what MrEmojiNew kept (the glyph answers and the merged lists), as a new process would. */
    @SuppressWarnings("unchecked")
    static void forget() throws Exception {
        Field glyph = MrEmojiNew.class.getDeclaredField("sGlyph");
        glyph.setAccessible(true);
        ((HashMap<String, Boolean>) glyph.get(null)).clear();
        Field base = MrEmojiNew.class.getDeclaredField("sBase");
        base.setAccessible(true);
        Arrays.fill((String[]) base.get(null), null);
        Paint.stubNoGlyph.clear();
        Paint.stubGlyphCalls = 0;
    }

    static int count(String list, String emoji) {
        int n = 0;
        for (String e : split(list)) {
            if (e.equals(emoji)) n++;
        }
        return n;
    }

    public static void main(String[] args) throws Exception {
        // ---- the table
        HashSet<String> all = new HashSet<String>();
        int groups = 0, total = 0;
        boolean shapeOk = true, dupOk = true, charsOk = true;
        for (int c = 0; c < MrEmojiNew.CATEGORIES; c++) {
            String[] g = MrEmojiNew.groups(c);
            if (g.length == 0) shapeOk = false;
            HashSet<String> anchorsSeen = new HashSet<String>();
            for (String line : g) {
                String[] part = split(line);
                groups++;
                if (part.length < 2 || part[0].length() == 0) shapeOk = false;
                if (!anchorsSeen.add(part[0])) dupOk = false;   // one group per anchor
                for (int i = 1; i < part.length; i++) {
                    total++;
                    if (part[i].length() == 0 || !all.add(part[i])) dupOk = false;
                    for (int k = 0; k < part[i].length(); k++) {
                        if (part[i].charAt(k) < 0x80) charsOk = false;   // an emoji has no plain ASCII in it (the keycaps are not new)
                    }
                }
            }
        }
        check("the table has groups in all 8 categories, each with an anchor and something new", shapeOk && groups > 80);
        check("no emoji twice in the table, one group per anchor", dupOk && all.size() == total);
        check("every emoji of the table is made of emoji characters (no ASCII)", charsOk);
        check("the table is out of range safe: groups(-1), groups(8)", MrEmojiNew.groups(-1).length == 0 && MrEmojiNew.groups(8).length == 0);

        // ---- merge: the phone draws everything
        forget();
        String melting = new String(Character.toChars(0x1FAE0));
        String upside = new String(Character.toChars(0x1F643));
        String merged0 = MrEmojiNew.merge(0, join("A", upside, "B"));
        String[] m0 = split(merged0);
        check("merge: the new emojis come right after their anchor", m0[0].equals("A") && m0[1].equals(upside) && m0[2].equals(melting));
        String[] firstGroup = split(MrEmojiNew.groups(0)[0]);
        java.util.List<String> m0list = Arrays.asList(m0);
        check("merge: the base emojis stay, in order, around the new ones", firstGroup[0].equals(upside) && m0list.indexOf("B") == 2 + (firstGroup.length - 1) && m0list.indexOf("A") == 0);
        boolean tailOk = true;
        int at = m0list.indexOf("B") + 1;
        for (int g = 1; g < MrEmojiNew.groups(0).length; g++) {
            String[] part = split(MrEmojiNew.groups(0)[g]);
            for (int i = 1; i < part.length; i++) {
                if (at >= m0.length || !m0[at++].equals(part[i])) tailOk = false;
            }
        }
        check("merge: the groups whose anchor is not in the base go to the end, in the order of the table", tailOk && at == m0.length);
        // a category with the anchors of the table: every new emoji lands after its anchor
        String[] flagAnchors = anchors(7);
        String flagBase = join(flagAnchors);
        String[] flagGroups = MrEmojiNew.groups(7);
        String flagMerged = MrEmojiNew.merge(7, flagBase);
        boolean placed = true;
        String[] fm = split(flagMerged);
        int pos = 0;
        for (String line : flagGroups) {
            String[] part = split(line);
            while (pos < fm.length && !fm[pos].equals(part[0])) pos++;
            for (int i = 1; i < part.length; i++) {
                pos++;
                if (pos >= fm.length || !fm[pos].equals(part[i])) placed = false;
            }
        }
        check("merge (flags): every group is right after its anchor, in the order of the table", placed && fm.length == flagAnchors.length + (flagGroups[0].split("[|]").length - 1) + (flagGroups[1].split("[|]").length - 1) + (flagGroups[2].split("[|]").length - 1));
        // the anchors missing
        String lone = join("X", "Y");
        String loneMerged = MrEmojiNew.merge(7, lone);
        int newInFlags = 0;
        for (String line : flagGroups) newInFlags += split(line).length - 1;
        check("merge: with none of the anchors in the base, all the new emojis are at the end", loneMerged.startsWith("X|Y|") && split(loneMerged).length == 2 + newInFlags);
        check("merge: the same base twice gives the same list (and the same object: it is kept)", MrEmojiNew.merge(7, lone) == loneMerged);
        check("merge: an emoji already in the base is not added again", count(MrEmojiNew.merge(0, join(upside, melting)), melting) == 1);
        check("merge: an empty or missing base, or a category out of range, comes back as it is",
                MrEmojiNew.merge(0, "").equals("") && MrEmojiNew.merge(0, null) == null && MrEmojiNew.merge(9, "A|B").equals("A|B") && MrEmojiNew.merge(-1, "A").equals("A"));
        check("merge: the base is one list with no empty item (no || and no | at the ends)", !merged0.contains("||") && !merged0.startsWith("|") && !merged0.endsWith("|"));

        // ---- a phone that cannot draw some of them
        forget();
        String sark = new String(Character.toChars(0x1F1E8)) + new String(Character.toChars(0x1F1F6));   // flag: Sark
        check("the table has the flag of Sark", all.contains(sark));
        String crying = new String(Character.toChars(0x1F972));   // not in the table: a base emoji
        Paint.stubNoGlyph.add(melting);
        Paint.stubNoGlyph.add(sark);
        String noGlyph = MrEmojiNew.merge(0, join("A", upside, "B"));
        check("no glyph: the emoji the font lacks is not in the list", count(noGlyph, melting) == 0);
        check("no glyph: the others of the same group are", noGlyph.startsWith("A|" + upside + "|") && split(noGlyph).length > 3);
        check("no glyph: the flag of Sark (a group of one) is left out", count(MrEmojiNew.merge(7, join(flagAnchors)), sark) == 0 && count(MrEmojiNew.merge(7, join(flagAnchors)), "x") == 0);
        check("shown: false for a new emoji the phone cannot draw, true for the others", !MrEmojiNew.shown(melting) && MrEmojiNew.shown(new String(Character.toChars(0x1FAE1))));
        check("shown: true for an emoji that is not in the table (the base list), whatever the font", MrEmojiNew.shown(upside) && MrEmojiNew.shown(crying));
        check("shown: false for null", !MrEmojiNew.shown(null));
        String[] results = {upside, melting, crying, new String(Character.toChars(0x1FAE1)), sark};
        String[] shown = MrEmojiNew.filter(results);
        check("filter: the ones the phone cannot draw go away, the order stays", Arrays.equals(shown, new String[] {upside, crying, new String(Character.toChars(0x1FAE1))}));
        String[] fine = {upside, crying};
        check("filter: nothing to remove: the same array comes back", MrEmojiNew.filter(fine) == fine);
        check("filter: an empty list", MrEmojiNew.filter(new String[0]).length == 0);

        // ---- the answers of the font are kept
        int calls = Paint.stubGlyphCalls;
        MrEmojiNew.merge(0, join("A", upside, "B"));
        MrEmojiNew.merge(0, join("C", upside));      // another base: the merged list is made again, the glyphs are not asked again
        MrEmojiNew.shown(melting);
        MrEmojiNew.filter(results);
        check("the glyph test is asked once per emoji of the table (the answers are kept)", Paint.stubGlyphCalls == calls);
        check("and it was asked for each of the new emojis of the first categories only as far as they were used", Paint.stubGlyphCalls > 0 && Paint.stubGlyphCalls <= total);

        // ---- the words: every emoji of the table has a line in each language
        File en = new File("res/raw/mr_emoji_en.txt");
        if (en.exists()) {
            String[] langs = {"en", "pt", "es"};
            boolean words = true;
            String missing = "";
            for (String l : langs) {
                HashSet<String> inFile = new HashSet<String>();
                BufferedReader r = new BufferedReader(new InputStreamReader(new FileInputStream("res/raw/mr_emoji_" + l + ".txt"), "UTF-8"));
                String line;
                while ((line = r.readLine()) != null) {
                    if (line.length() == 0 || line.startsWith("# ")) continue;
                    int tab = line.indexOf('\t');
                    if (tab > 0 && line.length() > tab + 1) inFile.add(line.substring(0, tab));
                }
                r.close();
                for (String e : all) {
                    if (!inFile.contains(e)) { words = false; missing += l + ":" + e + " "; }
                }
            }
            check("every new emoji has words in en, pt and es" + (words ? "" : " (missing " + missing + ")"), words);
        }

        System.out.println("\n" + ok + " OK, " + fail + " FAIL");
        if (fail > 0) System.exit(1);
    }
}
