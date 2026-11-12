package com.mrkeyboard.app;

import android.graphics.Paint;

import java.util.HashMap;
import java.util.HashSet;

/**
 * The emojis that are newer than the base list of the emoji panel (1.97.0).
 *
 * The base list (MrEmotes, hand-written smali) stops at Emoji 13, so the panel lacked the melting face, the new hearts, the
 * hands, the animals and the flags that came after it. They are listed here, by category, each group as "anchor|new|new|...":
 * the new emojis go right after the anchor, an emoji of the base list of that category (the group goes to the end of the
 * category when the anchor is not there, so a change of the base list cannot lose an emoji). MrEmotes.data(I) hands the
 * base list to merge(), which gives the merged one back.
 *
 * What the font of the phone cannot draw is left out (Paint.hasGlyph, asked once per emoji and kept), so an old phone does
 * not get squares for the newest ones and the panel grows by itself as the system font does. The search (MrEmojiSearch)
 * asks shown() for the same reason.
 *
 * Left out on purpose, because the panel does not carry them either: the skin tones, the man/woman versions of the
 * activities ("man running"), the "facing right" ones and the four hair components.
 *
 * docs/tools/make_emoji_search.py reads this table to write the words of the search for the merged list (all the emojis,
 * whether this phone can draw them or not), so the table is the only place to add an emoji.
 */
final class MrEmojiNew {
    /** The categories of MrEmotes.data: smileys and people, animals, food, activities, travel, objects, symbols, flags. */
    static final int CATEGORIES = 8;

    private static final String[][] GROUPS = {
        // 0: smileys and people
        {
            // melting face, distorted face, cracking face
            "\ud83d\ude43|\ud83e\udee0|\ud83e\udeea|\ud83e\udeeb",
            // face with open eyes and hand over mouth, face with peeking eye
            "\ud83e\udd2d|\ud83e\udee2|\ud83e\udee3",
            // saluting face
            "\ud83e\udd14|\ud83e\udee1",
            // dotted line face, face in clouds
            "\ud83d\ude36|\ud83e\udee5|\ud83d\ude36\u200d\ud83c\udf2b\ufe0f",
            // face exhaling
            "\ud83d\ude2c|\ud83d\ude2e\u200d\ud83d\udca8",
            // shaking face, head shaking horizontally, head shaking vertically
            "\ud83e\udd25|\ud83e\udee8|\ud83d\ude42\u200d\u2194\ufe0f|\ud83d\ude42\u200d\u2195\ufe0f",
            // face with bags under eyes
            "\ud83d\ude34|\ud83e\udee9",
            // face with spiral eyes
            "\ud83d\ude35|\ud83d\ude35\u200d\ud83d\udcab",
            // face with diagonal mouth
            "\ud83d\ude15|\ud83e\udee4",
            // face holding back tears
            "\ud83e\udd7a|\ud83e\udd79",
            // heart on fire, mending heart
            "\ud83d\udc94|\u2764\ufe0f\u200d\ud83d\udd25|\u2764\ufe0f\u200d\ud83e\ude79",
            // pink heart
            "\u2764\ufe0f|\ud83e\ude77",
            // light blue heart
            "\ud83d\udc99|\ud83e\ude75",
            // grey heart
            "\ud83d\udda4|\ud83e\ude76",
            // fight cloud
            "\ud83d\udca5|\ud83e\udeef",
            // eye in speech bubble
            "\ud83d\udcac|\ud83d\udc41\ufe0f\u200d\ud83d\udde8\ufe0f",
            // rightwards hand, leftwards hand, palm down hand, palm up hand, leftwards pushing hand, rightwards pushing hand,
            // leftwards thumb sign, rightwards thumb sign
            "\ud83d\udd96|\ud83e\udef1|\ud83e\udef2|\ud83e\udef3|\ud83e\udef4|\ud83e\udef7|\ud83e\udef8|\ud83e\udef9|\ud83e\udefa",
            // hand with index finger and thumb crossed
            "\ud83e\udd1e|\ud83e\udef0",
            // index pointing at the viewer
            "\u261d\ufe0f|\ud83e\udef5",
            // heart hands
            "\ud83d\ude4c|\ud83e\udef6",
            // biting lip
            "\ud83d\udc44|\ud83e\udee6",
            // fingerprint
            "\ud83d\udc63|\ud83e\udec6",
            // person with crown
            "\ud83d\udc78|\ud83e\udec5",
            // pregnant man, pregnant person
            "\ud83e\udd30|\ud83e\udec3|\ud83e\udec4",
            // Mx Claus
            "\ud83e\udd36|\ud83e\uddd1\u200d\ud83c\udf84",
            // troll
            "\ud83e\udddf|\ud83e\uddcc",
            // ballet dancer
            "\ud83d\udd7a|\ud83e\uddd1\u200d\ud83e\ude70",
            // person with white cane, man with white cane, woman with white cane, person in motorized wheelchair, man in
            // motorized wheelchair, woman in motorized wheelchair, person in manual wheelchair, man in manual wheelchair,
            // woman in manual wheelchair
            "\ud83e\uddce|\ud83e\uddd1\u200d\ud83e\uddaf|\ud83d\udc68\u200d\ud83e\uddaf|\ud83d\udc69\u200d\ud83e\uddaf|\ud83e\uddd1\u200d\ud83e\uddbc|\ud83d\udc68\u200d\ud83e\uddbc|\ud83d\udc69\u200d\ud83e\uddbc|\ud83e\uddd1\u200d\ud83e\uddbd|\ud83d\udc68\u200d\ud83e\uddbd|\ud83d\udc69\u200d\ud83e\uddbd",
            // person: red hair, person: curly hair, person: white hair, person: bald, man: red hair, man: curly hair, man:
            // white hair, man: bald, woman: red hair, woman: curly hair, woman: white hair, woman: bald
            "\ud83d\udc69|\ud83e\uddd1\u200d\ud83e\uddb0|\ud83e\uddd1\u200d\ud83e\uddb1|\ud83e\uddd1\u200d\ud83e\uddb3|\ud83e\uddd1\u200d\ud83e\uddb2|\ud83d\udc68\u200d\ud83e\uddb0|\ud83d\udc68\u200d\ud83e\uddb1|\ud83d\udc68\u200d\ud83e\uddb3|\ud83d\udc68\u200d\ud83e\uddb2|\ud83d\udc69\u200d\ud83e\uddb0|\ud83d\udc69\u200d\ud83e\uddb1|\ud83d\udc69\u200d\ud83e\uddb3|\ud83d\udc69\u200d\ud83e\uddb2",
            // people holding hands
            "\ud83d\udecc|\ud83e\uddd1\u200d\ud83e\udd1d\u200d\ud83e\uddd1",
            // health worker
            "\ud83d\udc68\u200d\u2695\ufe0f|\ud83e\uddd1\u200d\u2695\ufe0f",
            // student
            "\ud83d\udc68\u200d\ud83c\udf93|\ud83e\uddd1\u200d\ud83c\udf93",
            // teacher
            "\ud83d\udc68\u200d\ud83c\udfeb|\ud83e\uddd1\u200d\ud83c\udfeb",
            // judge
            "\ud83d\udc68\u200d\u2696\ufe0f|\ud83e\uddd1\u200d\u2696\ufe0f",
            // farmer
            "\ud83d\udc68\u200d\ud83c\udf3e|\ud83e\uddd1\u200d\ud83c\udf3e",
            // cook
            "\ud83d\udc68\u200d\ud83c\udf73|\ud83e\uddd1\u200d\ud83c\udf73",
            // mechanic
            "\ud83d\udc68\u200d\ud83d\udd27|\ud83e\uddd1\u200d\ud83d\udd27",
            // factory worker
            "\ud83d\udc68\u200d\ud83c\udfed|\ud83e\uddd1\u200d\ud83c\udfed",
            // office worker
            "\ud83d\udc68\u200d\ud83d\udcbc|\ud83e\uddd1\u200d\ud83d\udcbc",
            // scientist
            "\ud83d\udc68\u200d\ud83d\udd2c|\ud83e\uddd1\u200d\ud83d\udd2c",
            // technologist
            "\ud83d\udc68\u200d\ud83d\udcbb|\ud83e\uddd1\u200d\ud83d\udcbb",
            // singer
            "\ud83d\udc68\u200d\ud83c\udfa4|\ud83e\uddd1\u200d\ud83c\udfa4",
            // artist
            "\ud83d\udc68\u200d\ud83c\udfa8|\ud83e\uddd1\u200d\ud83c\udfa8",
            // pilot
            "\ud83d\udc68\u200d\u2708\ufe0f|\ud83e\uddd1\u200d\u2708\ufe0f",
            // astronaut
            "\ud83d\udc68\u200d\ud83d\ude80|\ud83e\uddd1\u200d\ud83d\ude80",
            // firefighter, woman feeding baby, man feeding baby, person feeding baby
            "\ud83d\udc68\u200d\ud83d\ude92|\ud83e\uddd1\u200d\ud83d\ude92|\ud83d\udc69\u200d\ud83c\udf7c|\ud83d\udc68\u200d\ud83c\udf7c|\ud83e\uddd1\u200d\ud83c\udf7c",
            // family: man, woman, boy, boy, family: man, woman, girl, girl
            "\ud83d\udc68\u200d\ud83d\udc69\u200d\ud83d\udc67\u200d\ud83d\udc66|\ud83d\udc68\u200d\ud83d\udc69\u200d\ud83d\udc66\u200d\ud83d\udc66|\ud83d\udc68\u200d\ud83d\udc69\u200d\ud83d\udc67\u200d\ud83d\udc67",
            // family: woman, woman, girl, family: woman, woman, girl, boy, family: woman, woman, boy, boy, family: woman,
            // woman, girl, girl
            "\ud83d\udc69\u200d\ud83d\udc69\u200d\ud83d\udc66|\ud83d\udc69\u200d\ud83d\udc69\u200d\ud83d\udc67|\ud83d\udc69\u200d\ud83d\udc69\u200d\ud83d\udc67\u200d\ud83d\udc66|\ud83d\udc69\u200d\ud83d\udc69\u200d\ud83d\udc66\u200d\ud83d\udc66|\ud83d\udc69\u200d\ud83d\udc69\u200d\ud83d\udc67\u200d\ud83d\udc67",
            // family: man, man, girl, family: man, man, girl, boy, family: man, man, boy, boy, family: man, man, girl, girl
            "\ud83d\udc68\u200d\ud83d\udc68\u200d\ud83d\udc66|\ud83d\udc68\u200d\ud83d\udc68\u200d\ud83d\udc67|\ud83d\udc68\u200d\ud83d\udc68\u200d\ud83d\udc67\u200d\ud83d\udc66|\ud83d\udc68\u200d\ud83d\udc68\u200d\ud83d\udc66\u200d\ud83d\udc66|\ud83d\udc68\u200d\ud83d\udc68\u200d\ud83d\udc67\u200d\ud83d\udc67",
            // family: woman, boy, boy
            "\ud83d\udc69\u200d\ud83d\udc66|\ud83d\udc69\u200d\ud83d\udc66\u200d\ud83d\udc66",
            // family: woman, girl, boy, family: woman, girl, girl
            "\ud83d\udc69\u200d\ud83d\udc67|\ud83d\udc69\u200d\ud83d\udc67\u200d\ud83d\udc66|\ud83d\udc69\u200d\ud83d\udc67\u200d\ud83d\udc67",
            // family: man, boy, boy
            "\ud83d\udc68\u200d\ud83d\udc66|\ud83d\udc68\u200d\ud83d\udc66\u200d\ud83d\udc66",
            // family: man, girl, boy, family: man, girl, girl, family: adult, adult, child, family: adult, adult, child,
            // child, family: adult, child, family: adult, child, child
            "\ud83d\udc68\u200d\ud83d\udc67|\ud83d\udc68\u200d\ud83d\udc67\u200d\ud83d\udc66|\ud83d\udc68\u200d\ud83d\udc67\u200d\ud83d\udc67|\ud83e\uddd1\u200d\ud83e\uddd1\u200d\ud83e\uddd2|\ud83e\uddd1\u200d\ud83e\uddd1\u200d\ud83e\uddd2\u200d\ud83e\uddd2|\ud83e\uddd1\u200d\ud83e\uddd2|\ud83e\uddd1\u200d\ud83e\uddd2\u200d\ud83e\uddd2",
            // kiss: woman, man, kiss: man, man, kiss: woman, woman
            "\ud83d\udc69\u200d\u2764\ufe0f\u200d\ud83d\udc69|\ud83d\udc69\u200d\u2764\ufe0f\u200d\ud83d\udc8b\u200d\ud83d\udc68|\ud83d\udc68\u200d\u2764\ufe0f\u200d\ud83d\udc8b\u200d\ud83d\udc68|\ud83d\udc69\u200d\u2764\ufe0f\u200d\ud83d\udc8b\u200d\ud83d\udc69",
        },
        // 1: animals and nature
        {
            // moose, donkey
            "\ud83d\udc34|\ud83e\udece|\ud83e\udecf",
            // hairy creature
            "\ud83e\udda7|\ud83e\udec8",
            // service dog
            "\ud83e\uddae|\ud83d\udc15\u200d\ud83e\uddba",
            // black cat
            "\ud83d\udc08|\ud83d\udc08\u200d\u2b1b",
            // polar bear
            "\ud83d\udc3b|\ud83d\udc3b\u200d\u2744\ufe0f",
            // feather
            "\ud83e\udda4|\ud83e\udeb6",
            // wing, black bird, goose, phoenix
            "\ud83e\udd9c|\ud83e\udebd|\ud83d\udc26\u200d\u2b1b|\ud83e\udebf|\ud83d\udc26\u200d\ud83d\udd25",
            // orca
            "\ud83d\udc0b|\ud83e\udecd",
            // coral, jellyfish
            "\ud83d\udc1a|\ud83e\udeb8|\ud83e\udebc",
            // monarch butterfly
            "\ud83e\udd8b|\ud83e\udecc",
            // lotus
            "\ud83d\udcae|\ud83e\udeb7",
            // hyacinth
            "\ud83c\udf37|\ud83e\udebb",
            // leafless tree
            "\ud83c\udf33|\ud83e\udebe",
            // empty nest, nest with eggs
            "\ud83c\udf43|\ud83e\udeb9|\ud83e\udeba",
        },
        // 2: food and drink
        {
            // lime
            "\ud83c\udf4b|\ud83c\udf4b\u200d\ud83d\udfe9",
            // root vegetable
            "\ud83e\udd55|\ud83e\udedc",
            // brown mushroom
            "\ud83c\udf44|\ud83c\udf44\u200d\ud83d\udfeb",
            // beans
            "\ud83e\udd5c|\ud83e\uded8",
            // ginger root, pea pod
            "\ud83c\udf30|\ud83e\udeda|\ud83e\udedb",
            // pickle
            "\ud83e\udd52|\ud83e\udedd",
            // jar
            "\ud83e\udd6b|\ud83e\uded9",
            // pouring liquid
            "\ud83e\udd43|\ud83e\uded7",
        },
        // 3: activities
        {
            // magic wand
            "\ud83d\udd2e|\ud83e\ude84",
            // hamsa
            "\ud83e\uddff|\ud83e\udeac",
            // mirror ball
            "\ud83e\ude86|\ud83e\udea9",
        },
        // 4: travel and places
        {
            // map of Japan
            "\ud83d\uddfa\ufe0f|\ud83d\uddfe",
            // landslide
            "\ud83c\udfd4\ufe0f|\ud83d\uded8",
            // lighthouse
            "\ud83d\uddfc|\ud83d\uded9",
            // playground slide
            "\ud83c\udfa1|\ud83d\udedd",
            // wheel
            "\u26fd|\ud83d\udede",
            // ring buoy
            "\u2693|\ud83d\udedf",
            // meteor
            "\u2604\ufe0f|\ud83e\ude8b",
        },
        // 5: objects
        {
            // identification card
            "\ud83d\udcb3|\ud83e\udeaa",
            // low battery
            "\ud83d\udd0b|\ud83e\udeab",
            // trombone
            "\ud83c\udfba|\ud83e\ude8a",
            // maracas, flute, harp
            "\ud83e\ude98|\ud83e\ude87|\ud83e\ude88|\ud83e\ude89",
            // hair pick
            "\ud83e\ude92|\ud83e\udeae",
            // crutch
            "\ud83e\ude79|\ud83e\ude7c",
            // x-ray
            "\ud83e\ude7a|\ud83e\ude7b",
            // shovel
            "\u26cf\ufe0f|\ud83e\ude8f",
            // treasure chest
            "\ud83e\uddf0|\ud83e\ude8e",
            // eraser, splatter
            "\ud83d\udd8d\ufe0f|\ud83e\ude8c|\ud83e\udedf",
            // net with handle
            "\ud83e\udea4|\ud83e\ude8d",
            // broken chain
            "\ud83d\udd17|\u26d3\ufe0f\u200d\ud83d\udca5",
            // bubbles
            "\ud83e\uddfc|\ud83e\udee7",
            // folding hand fan
            "\ud83d\udc52|\ud83e\udead",
        },
        // 6: symbols
        {
            // wireless
            "\ud83d\udcf6|\ud83d\udedc",
            // heavy equals sign
            "\u2797|\ud83d\udff0",
            // khanda
            "\u2721\ufe0f|\ud83e\udeaf",
        },
        // 7: flags
        {
            // transgender flag
            "\ud83c\udff3\ufe0f\u200d\ud83c\udf08|\ud83c\udff3\ufe0f\u200d\u26a7\ufe0f",
            // flag: Sark
            "\ud83c\udde8\ud83c\uddf5|\ud83c\udde8\ud83c\uddf6",
            // flag: England, flag: Scotland, flag: Wales
            "\ud83c\uddff\ud83c\uddfc|\ud83c\udff4\udb40\udc67\udb40\udc62\udb40\udc65\udb40\udc6e\udb40\udc67\udb40\udc7f|\ud83c\udff4\udb40\udc67\udb40\udc62\udb40\udc73\udb40\udc63\udb40\udc74\udb40\udc7f|\ud83c\udff4\udb40\udc67\udb40\udc62\udb40\udc77\udb40\udc6c\udb40\udc73\udb40\udc7f",
        },
    };

    private static final String[] sBase = new String[CATEGORIES];
    private static final String[] sMerged = new String[CATEGORIES];
    private static final HashMap<String, Boolean> sGlyph = new HashMap<String, Boolean>();
    private static HashSet<String> sAll;
    private static Paint sPaint;

    private MrEmojiNew() { }

    /** The groups of one category ("anchor|new|new|..."), for the tools that read the table; empty for a category that has none. */
    static String[] groups(int cat) {
        return cat < 0 || cat >= GROUPS.length ? new String[0] : GROUPS[cat];
    }

    /** The base list of category cat (emojis separated by |) with the new emojis this phone can draw put in their places. */
    static synchronized String merge(int cat, String base) {
        if (base == null || base.length() == 0 || cat < 0 || cat >= GROUPS.length) return base;
        if (base == sBase[cat] || base.equals(sBase[cat])) return sMerged[cat];
        String[] list = base.split("[|]");
        HashSet<String> inBase = new HashSet<String>();
        for (int i = 0; i < list.length; i++) inBase.add(list[i]);
        HashSet<String> added = new HashSet<String>();
        HashMap<String, String> after = new HashMap<String, String>();
        StringBuilder tail = new StringBuilder();
        String[] groups = GROUPS[cat];
        for (int g = 0; g < groups.length; g++) {
            String[] part = groups[g].split("[|]");
            StringBuilder add = new StringBuilder();
            for (int i = 1; i < part.length; i++) {
                String e = part[i];
                if (inBase.contains(e) || added.contains(e) || !glyph(e)) continue;
                added.add(e);
                add.append('|').append(e);
            }
            if (add.length() == 0) continue;
            if (inBase.contains(part[0])) {
                String before = after.get(part[0]);
                after.put(part[0], before == null ? add.toString() : before + add);
            } else {
                tail.append(add);
            }
        }
        StringBuilder out = new StringBuilder(base.length() + 2048);
        for (int i = 0; i < list.length; i++) {
            if (i > 0) out.append('|');
            out.append(list[i]);
            String more = after.get(list[i]);
            if (more != null) out.append(more);
        }
        out.append(tail);
        sBase[cat] = base;
        sMerged[cat] = out.toString();
        return sMerged[cat];
    }

    /** False for an emoji of this table that the phone cannot draw; true for any other. */
    static synchronized boolean shown(String emoji) {
        if (emoji == null) return false;
        if (sAll == null) {
            HashSet<String> all = new HashSet<String>();
            for (int c = 0; c < GROUPS.length; c++) {
                for (int g = 0; g < GROUPS[c].length; g++) {
                    String[] part = GROUPS[c][g].split("[|]");
                    for (int i = 1; i < part.length; i++) all.add(part[i]);
                }
            }
            sAll = all;
        }
        return !sAll.contains(emoji) || glyph(emoji);
    }

    /** The emojis of the list the phone can draw, in the same order (the same array when it can draw them all). */
    static String[] filter(String[] found) {
        int n = 0;
        for (int i = 0; i < found.length; i++) {
            if (shown(found[i])) n++;
        }
        if (n == found.length) return found;
        String[] out = new String[n];
        int k = 0;
        for (int i = 0; i < found.length; i++) {
            if (shown(found[i])) out[k++] = found[i];
        }
        return out;
    }

    /** Whether the font of the phone has one glyph for the emoji (Paint.hasGlyph, which also reads the sequences); kept after the first time. */
    private static synchronized boolean glyph(String emoji) {
        Boolean known = sGlyph.get(emoji);
        if (known == null) {
            if (sPaint == null) sPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
            known = Boolean.valueOf(sPaint.hasGlyph(emoji));
            sGlyph.put(emoji, known);
        }
        return known.booleanValue();
    }
}
