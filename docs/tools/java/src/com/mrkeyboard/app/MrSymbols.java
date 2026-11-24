package com.mrkeyboard.app;

import android.content.SharedPreferences;
import android.content.res.Resources;
import android.graphics.Paint;
import android.graphics.drawable.Drawable;
import android.preference.PreferenceManager;
import android.view.View;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * The characters of the emoji panel (2.1.0).
 *
 * The floating bar of the emoji panel (MrEmojiSearch) has a button between Search and Delete. It swaps what the panel shows: the
 * emojis give way to the text symbols (stars, hearts, arrows, math, music, shapes, animals and games, currency and signs), and
 * the button becomes the emoji button, which swaps them back. The panel is the same one (MrEmotes: the same list, the same rows
 * of eight, the same tabs and the same tap that writes the text in the app); what changes is the data and a few details:
 *  - the rows of each category come from SETS instead of the emoji table, and the names above them from the string mr_sym_cats;
 *  - the first tab keeps its clock: the recent symbols are a list of their own (pref symbol_recent, 24 at most, a long press
 *    removes one), so the recent emojis are not mixed with them;
 *  - the other eight tabs show a symbol of their category in place of the icon, and get their icons back with the emojis;
 *  - what the font of the phone cannot draw is left out (Paint.hasGlyph, asked once per category and kept), as the newer emojis
 *    are: an old phone shows no empty boxes.
 * The panel goes back to the emojis whenever it is left (the search opens, another tool opens, the keyboard comes back): it
 * opens on the emojis, as before.
 *
 * MrEmotes (hand-written smali) calls rows, names, recent, addRecent and forget; everything else is here.
 */
final class MrSymbols {
    /** Categories of symbols: the eight tabs after the recents. */
    static final int CATS = 8;
    static final String PREF_RECENT = "symbol_recent";
    static final int RECENT_MAX = 24;
    /** What the recents hold before anything was tapped. */
    static final String RECENT_DEFAULT = "\u2605|\u2765|\u279c|\u266a|\u273f|\u2661|\u261c|\u261e|\u20ac|\u221e|\u263b|\u2606";
    /** The symbol on the tab of each category (the tab shows it in place of its icon): text symbols of a size alike, none of them an emoji. */
    static final String[] TAB = {"\u2605", "\u2765", "\u279c", "\u2211", "\u266a", "\u25c6", "\u265e", "\u20ac"};

    /**
     * The symbols of each category, one code point each (no sequences: nothing that needs a variation selector). Stars and
     * flowers; hearts, faces and people; arrows and hands; math and numbers; music, weather and nature; shapes, lines and
     * brackets; animals (Egyptian hieroglyphs), cards, chess, dice and gender signs; currency, signs and objects.
     * None of them is an emoji (the Unicode Emoji property): those are in the emoji panel already, and many phones draw them in colour
     * (yellow hands, a red heart), which does not follow the colour of the theme. SymbolsTest checks it against the properties of the
     * JDK and against the emoji of the panel; the tab symbols and the first symbols of the recents are checked the same way.
     */
    static final String[] SETS = {
        // 1. stars and flowers
        "\u2605\u2606\u272a\u272b\u272c\u272d\u272e\u272f\u2730\u2729\u2726\u2727\u269d\u2b51\u2b52\u235f\u2735\u2732\u2731\u2736\u2737\u2738\u2739\u273a\u273b\u273c\u273d\u273e\u273f\u2740\u2741\u2742\u2743\u2745\u2746\u2748\u2749\u274a\u274b\u2724\u2723\u2722\u2756\u2698\u2042\u204e\u2051\u2055" +
            "\u2058\u2059\u263c\u2609\u26e4\u26e5\u26e6\u26e7",
        // 2. hearts, faces and people
        "\u2661\u2765\u2766\u2767\u2619\u2762\u10d3\u10e6\u2664\u2667\u2662\u263b\u30c4\u30c3\u30b7\u30c5\u32db\u0298\u0ca0\u0ca5\u0ca1\u0e4f\u0e51\u25d5\u25d4\u25c9\u25ce\u25e0\u25e1\u203f\u2040\u1d17\u1d25\u1d54\u1d55\ua4b3\u02d8\u03c9\u2200\u25bd\u0414\u30ee\u0296\uc6c3\uc720\u3162\u3161\u3160" +
            "\u315c\u3157\u3145\u314f\u3154\u3147\u3141\u26a5",
        // 3. arrows and hands
        "\u261c\u261e\u261f\u261a\u261b\u2190\u2191\u2192\u2193\u219a\u219b\u219c\u219d\u219e\u219f\u21a0\u21a1\u21a2\u21a3\u21a4\u21a5\u21a6\u21a7\u21a8\u21ab\u21ac\u21ad\u21ae\u21af\u21b0\u21b1\u21b2\u21b3\u21b4\u21b5\u21b6\u21b7\u21b8\u21b9\u21ba\u21bb\u21bc\u21bd\u21be\u21bf\u21c0\u21c1\u21c2" +
            "\u21c3\u21c4\u21c5\u21c6\u21c7\u21c8\u21c9\u21ca\u21cb\u21cc\u21cd\u21ce\u21cf\u21d0\u21d1\u21d2\u21d3\u21d4\u21d5\u21d6\u21d7\u21d8\u21d9\u21da\u21db\u21dc\u21dd\u21de\u21df\u21e0\u21e1\u21e2\u21e3\u21e4\u21e5\u21e6\u21e7\u21e8\u21e9\u21ea\u21eb\u21ec\u21ed\u21ee\u21ef\u21f0\u21f1\u21f2" +
            "\u21f3\u21f4\u21f5\u21f6\u21f7\u21f8\u21f9\u21fa\u21fb\u21fc\u21fd\u21fe\u21ff\u2794\u2798\u2799\u279a\u279b\u279c\u279d\u279e\u279f\u27a0\u27a2\u27a3\u27a4\u27a5\u27a6\u27a7\u27a8\u27a9\u27aa\u27ab\u27ac\u27ad\u27ae\u27af\u27b1\u27b2\u27b3\u27b4\u27b5\u27b6\u27b7\u27b8\u27b9\u27ba\u27bb" +
            "\u27bc\u27bd\u27be\u27f5\u27f6\u27f7\u27f8\u27f9\u27fa\u27fb\u27fc\u2900\u2903\u2904\u2905\u2906\u2907\u2912\u2913\u2b08\u2b09\u2b0a\u2b0b\u2b0c\u2b0d\u2b60\u2b62\u2b61\u2b63",
        // 4. math and numbers
        "\u00b1\u2213\u00d7\u00f7\u2215\u2212+=\u2260\u2248\u2245\u2243\u2261\u2262\u2264\u2265\u226a\u226b\u2270\u2271<>\u00ac\u221e\u221a\u221b\u221c\u2211\u220f\u222b\u222c\u222d\u222e\u2202\u2206\u2207\u2208\u2209\u220b\u220c\u2229\u222a\u2282\u2283\u2286\u2287\u2205\u2203" +
            "\u2204\u2227\u2228\u2295\u2297\u221d\u2220\u2225\u22a5\u2234\u2235\u223c\u2030\u2031\u00b0\u2032\u2033\u2034\u00bd\u2153\u2154\u00bc\u00be\u2155\u2156\u2157\u2158\u2159\u215a\u215b\u215c\u215d\u215e\u2189\u2070\u00b9\u00b2\u00b3\u2074\u2075\u2076\u2077\u2078\u2079\u207a\u207b\u207c\u207d" +
            "\u207e\u207f\u2080\u2081\u2082\u2083\u2084\u2085\u2086\u2087\u2088\u2089\u208a\u208b\u208c\u208d\u208e\u2460\u2461\u2462\u2463\u2464\u2465\u2466\u2467\u2468\u2469\u246a\u246b\u246c\u246d\u246e\u246f\u2470\u2471\u2472\u2473\u24ea\u2776\u2777\u2778\u2779\u277a\u277b\u277c\u277d\u277e\u277f" +
            "\u2780\u2781\u2782\u2783\u2784\u2785\u2786\u2787\u2788\u2789\u2160\u2161\u2162\u2163\u2164\u2165\u2166\u2167\u2168\u2169\u216a\u216b\u2170\u2171\u2172\u2173\u2174\u2175\u2176\u2177\u2178\u2179\u217a\u217b\u03b1\u03b2\u03b3\u03b4\u03b5\u03b8\u03bb\u03bc\u03c0\u03c3\u03c6\u0394\u03a3\u03a9" +
            "\u03a0\u03a6\u03a8\u00b5\u210f\u2113\u2118\u2111\u211c\u2135\u2102\u210d\u2115\u2119\u211a\u211d\u2124",
        // 5. music, weather and nature
        "\u2669\u266a\u266b\u266c\u266d\u266e\u266f\u263d\u263e\u2607\u2608\u03df\u2672\u2673\u2674\u2675\u2676\u2677\u2678\u2679\u267a\u267c\u267d\u262d\u2625\u2627\u2628\u2629\u262c\u262b\u260a\u260b\u260c\u260d\u2641\u263f\u2643\u2644\u2645\u2646\u2647\u26e2\u26e3\u2301\u237e\ud834\udd1e\ud834\udd22\ud834\udd2a" +
            "\ud834\udd2b",
        // 6. shapes, lines and brackets
        "\u25a0\u25a1\u25a2\u25a3\u25a4\u25a5\u25a6\u25a7\u25a8\u25a9\u25ac\u25ad\u25ae\u25af\u25b0\u25b1\u25b2\u25b3\u25b4\u25b5\u25b7\u25b8\u25b9\u25ba\u25bb\u25bc\u25be\u25bf\u25c1\u25c2\u25c3\u25c4\u25c5\u25c6\u25c7\u25c8\u25ca\u25cb\u25cc\u25cd\u25cf\u25d0\u25d1\u25d2\u25d3\u25d6\u25d7\u25d8" +
            "\u25d9\u25da\u25db\u25dc\u25dd\u25de\u25df\u25e2\u25e3\u25e4\u25e5\u25e6\u25e7\u25e8\u25e9\u25ea\u25eb\u25ec\u25ed\u25ee\u25ef\u25f0\u25f1\u25f2\u25f3\u25f4\u25f5\u25f6\u25f7\u25f8\u25f9\u25fa\u25ff\u2b12\u2b13\u2b14\u2b15\u2b16\u2b17\u2b18\u2b19\u2b1a\u2b1d\u2b1e\u2b1f\u2b20\u2b21\u2b22" +
            "\u2b23\u2b24\u2b25\u2b26\u2b27\u2b28\u2b29\u2b2a\u2b2b\u2b2c\u2b2d\u2b2e\u2b2f\u2580\u2581\u2582\u2583\u2584\u2585\u2586\u2587\u2588\u2589\u258a\u258b\u258c\u258d\u258e\u258f\u2590\u2591\u2592\u2593\u2594\u2595\u2596\u2597\u2598\u2599\u259a\u259b\u259c\u259d\u259e\u259f\u2500\u2501\u2502" +
            "\u2503\u250c\u250f\u2510\u2513\u2514\u2517\u2518\u251b\u251c\u2523\u2524\u252b\u252c\u2533\u2534\u253b\u253c\u254b\u2550\u2551\u2554\u2557\u255a\u255d\u2560\u2563\u2566\u2569\u256c\u256d\u256e\u256f\u2570\u2571\u2572\u2573\u2574\u2575\u2576\u2577\u3010\u3011\u300c\u300d\u300e\u300f\u300a" +
            "\u300b\u3008\u3009\u3014\u3015\u3016\u3017\uff3b\uff3d\uff5b\uff5d\ufe41\ufe42\u275b\u275c\u275d\u275e\u2039\u203a\u00ab\u00bb\u201c\u201d\u2018\u2019\u201e\u2026\u2022\u2023\u2043\u2219\u00b7\u2025\u205d\u205e\u2758\u2759\u275a\u2e2e\u203d\u2047\u2048",
        // 7. animals, hieroglyphs and games
        "\ud80c\udcd2\ud80c\udcd3\ud80c\udcd4\ud80c\udcd5\ud80c\udcd6\ud80c\udcd7\ud80c\udcd8\ud80c\udcd9\ud80c\udcda\ud80c\udcdb\ud80c\udcdc\ud80c\udcdd\ud80c\udcde\ud80c\udcdf\ud80c\udce0\ud80c\udce1\ud80c\udce2\ud80c\udce3\ud80c\udce4\ud80c\udce5\ud80c\udce6\ud80c\udce7\ud80c\udce8\ud80c\udce9\ud80c\udcea\ud80c\udceb\ud80c\udcec\ud80c\udced\ud80c\udcee\ud80c\udcef\ud80c\udcf0\ud80c\udcf1\ud80c\udcf2\ud80c\udcf3\ud80c\udcf4\ud80c\udcf5\ud80c\udcf6\ud80c\udcf7\ud80c\udcf8\ud80c\udcf9\ud80c\udcfa\ud80c\udcfb\ud80c\udcfc\ud80c\udcfd\ud80c\udd3f\ud80c\udd40\ud80c\udd41\ud80c\udd42" +
            "\ud80c\udd43\ud80c\udd44\ud80c\udd45\ud80c\udd46\ud80c\udd47\ud80c\udd48\ud80c\udd49\ud80c\udd4a\ud80c\udd4b\ud80c\udd4c\ud80c\udd4d\ud80c\udd4e\ud80c\udd4f\ud80c\udd50\ud80c\udd51\ud80c\udd52\ud80c\udd53\ud80c\udd54\ud80c\udd55\ud80c\udd56\ud80c\udd57\ud80c\udd58\ud80c\udd59\ud80c\udd5a\ud80c\udd5b\ud80c\udd5c\ud80c\udd5d\ud80c\udd5e\ud80c\udd5f\ud80c\udd60\ud80c\udd61\ud80c\udd62\ud80c\udd63\ud80c\udd64\ud80c\udd65\ud80c\udd66\ud80c\udd67\ud80c\udd68\ud80c\udd69\ud80c\udd6a\ud80c\udd6b\ud80c\udd6c\ud80c\udd6d\ud80c\udd6e\ud80c\udd6f\ud80c\udd70\ud80c\udd71\ud80c\udd72" +
            "\ud80c\udd73\ud80c\udd74\ud80c\udd75\ud80c\udd76\ud80c\udd77\ud80c\udd78\ud80c\udd79\ud80c\udd7a\ud80c\udd7b\ud80c\udd7c\ud80c\udd7d\ud80c\udd7e\ud80c\udd88\ud80c\udd89\ud80c\udd8a\ud80c\udd8b\ud80c\udd8c\ud80c\udd8d\ud80c\udd8e\ud80c\udd8f\ud80c\udd90\ud80c\udd91\ud80c\udd92\ud80c\udd93\ud80c\udd94\ud80c\udd95\ud80c\udd96\ud80c\udd97\ud80c\udd98\ud80c\udd99\ud80c\udd9a\ud80c\udd9b\ud80c\udd9c\ud80c\udd9d\ud80c\udd9e\ud80c\udd9f\ud80c\udda0\ud80c\udda1\ud80c\udda2\ud80c\udda3\ud80c\udda4\ud80c\udda5\ud80c\udda6\ud80c\udda7\ud80c\udda8\ud80c\udda9\ud80c\uddaa\ud80c\uddab" +
            "\ud80c\uddac\ud80c\udc80\ud80c\udef9\u2654\u2655\u2656\u2657\u2658\u2659\u265a\u265b\u265c\u265d\u265e\ud83c\udca1\ud83c\udcb1\ud83c\udcc1\ud83c\udcd1\ud83c\udca0\u2680\u2681\u2682\u2683\u2684\u2685\u26a2\u26a3\u26a4\u26a6\u26a8\u26a9\u26b2",
        // 8. currency, signs and objects
        "$\u00a2\u00a3\u00a4\u00a5\u20ac\u20a0\u20a1\u20a2\u20a3\u20a4\u20a5\u20a6\u20a7\u20a8\u20a9\u20aa\u20ab\u20ad\u20ae\u20af\u20b0\u20b1\u20b2\u20b3\u20b4\u20b5\u20b6\u20b7\u20b8\u20b9\u20ba\u20bb\u20bc\u20bd\u20be\u20bf\u0e3f\u17db\ufdfc\u2120\u2117\u00a7\u00b6\u2020\u2021\u2116\u2105" +
            "\u2100\u2101\u2121\u2103\u2109\u211e\u214d\u2713\u2715\u2717\u2718\u2610\u2612\u237b\u2318\u2325\u2303\u23ce\u232b\u2326\u238b\u270e\u2706\u260f\u2691\u2690",
    };

    private static boolean sOn;
    private static TextView sSymbols;       // emote_sym: the button that shows the symbols (visible with the emojis)
    private static TextView sEmojis;        // emote_emo: the button that shows the emojis again (visible with the symbols)
    private static Drawable[] sTabIcons;    // the icons of the tabs while the symbols are on their place
    private static ArrayList<String> sRecent;
    private static final String[] sShown = new String[CATS];
    private static Paint sPaint;

    private MrSymbols() { }

    // ------------------------------------------------------------------ setup

    /** Called with the root of the toolbar each time a keyboard view is made (MrEmojiSearch.setup); null lets everything go. */
    static void setup(View root) {
        if (sOn) {
            // the tabs that are still on screen get their icons back before the state is let go
            sOn = false;
            tabs();
        }
        sOn = false;
        sTabIcons = null;
        sRecent = null;
        sSymbols = null;
        sEmojis = null;
        if (root == null) return;
        View a = root.findViewWithTag("emote_sym");
        View b = root.findViewWithTag("emote_emo");
        if (!(a instanceof TextView) || !(b instanceof TextView)) return;
        sSymbols = (TextView) a;
        sEmojis = (TextView) b;
        View.OnClickListener swap = new View.OnClickListener() {
            public void onClick(View v) {
                toggle();
            }
        };
        sSymbols.setOnClickListener(swap);
        sEmojis.setOnClickListener(swap);
        buttons();
    }

    static boolean on() {
        return sOn;
    }

    /** The other of the two: emojis to symbols and back. */
    static void toggle() {
        set(!sOn);
    }

    /** Back to the emojis (the panel is left, or the emoji search opens). */
    static void leave() {
        set(false);
    }

    private static void set(boolean on) {
        if (on == sOn) return;
        sOn = on;
        try {
            tabs();
            buttons();
        } catch (RuntimeException e) {
            // the look of the tabs is a detail: the panel still swaps
        }
        MrEmotes.refresh();
    }

    /** One button is visible, the one that takes the panel to the other list. */
    private static void buttons() {
        if (sSymbols == null || sEmojis == null) return;
        sSymbols.setVisibility(sOn ? View.GONE : View.VISIBLE);
        sEmojis.setVisibility(sOn ? View.VISIBLE : View.GONE);
    }

    /** A symbol on each category tab while the symbols are on; the icons again with the emojis. */
    private static void tabs() {
        TextView[] t = MrEmotes.sTabs;
        if (t == null || t.length != CATS + 1) return;
        if (sOn) {
            Drawable[] saved = new Drawable[t.length];
            for (int i = 1; i < t.length; i++) {
                if (t[i] == null) continue;
                saved[i] = t[i].getCompoundDrawables()[0];
                t[i].setCompoundDrawables(null, null, null, null);
                t[i].setText(TAB[i - 1]);
            }
            sTabIcons = saved;
        } else if (sTabIcons != null) {
            for (int i = 1; i < t.length; i++) {
                if (t[i] == null) continue;
                t[i].setText("");
                t[i].setCompoundDrawables(sTabIcons[i], null, null, null);
            }
            sTabIcons = null;
        }
    }

    // ------------------------------------------------------------------ what MrEmotes asks

    /** The category cat (0 to 7) of the panel, separated by | : the emojis, or the symbols while they are on. */
    static String rows(int cat) {
        return sOn ? shown(cat) : MrEmotes.data(cat);
    }

    /** The names of the nine tabs (recent and the categories), separated by | : the emoji ones, or the ones of the symbols. */
    static String names(String emoji) {
        if (!sOn) return emoji;
        String own = text("mr_sym_cats");
        return own == null ? emoji : own;
    }

    /** The recent ones of the panel: the emojis the panel gave, or the recent symbols while they are on. */
    static String recent(String emoji) {
        if (!sOn) return emoji;
        loadRecent();
        return join(sRecent);
    }

    /** A tap on a cell: into the recents of what is showing. */
    static void addRecent(String s) {
        if (!sOn) {
            MrEmotes.addRecent(s);
            return;
        }
        loadRecent();
        sRecent.remove(s);
        sRecent.add(0, s);
        while (sRecent.size() > RECENT_MAX) sRecent.remove(sRecent.size() - 1);
        save();
    }

    /** A long press on a cell of the recents while the symbols are on: out of the list; false when it was not there. */
    static boolean forget(String s) {
        loadRecent();
        if (!sRecent.remove(s)) return false;
        save();
        MrEmotes.refresh();
        return true;
    }

    // ------------------------------------------------------------------ data

    /** The symbols of one category that the font of the phone can draw, separated by | (worked out once, then kept). */
    private static synchronized String shown(int cat) {
        if (cat < 0 || cat >= CATS) return "";
        if (sShown[cat] == null) sShown[cat] = drawable(SETS[cat]);
        return sShown[cat];
    }

    /** The code points of the set that Paint.hasGlyph accepts, one by one, joined with | . */
    static String drawable(String set) {
        if (sPaint == null) sPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        StringBuilder out = new StringBuilder();
        int i = 0;
        while (i < set.length()) {
            int cp = set.codePointAt(i);
            i += Character.charCount(cp);
            String one = new String(Character.toChars(cp));
            if (!sPaint.hasGlyph(one)) continue;
            if (out.length() > 0) out.append('|');
            out.append(one);
        }
        return out.toString();
    }

    private static String join(ArrayList<String> list) {
        StringBuilder out = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) out.append('|');
            out.append(list.get(i));
        }
        return out.toString();
    }

    private static void loadRecent() {
        if (sRecent != null) return;
        sRecent = new ArrayList<String>();
        String saved = RECENT_DEFAULT;
        SharedPreferences p = prefs();
        if (p != null) saved = p.getString(PREF_RECENT, "");
        if (saved == null || saved.length() == 0) saved = RECENT_DEFAULT;
        for (String s : saved.split("[|]")) {
            if (s.length() > 0 && !sRecent.contains(s)) sRecent.add(s);
        }
    }

    private static void save() {
        SharedPreferences p = prefs();
        if (p != null) p.edit().putString(PREF_RECENT, join(sRecent)).apply();
    }

    private static SharedPreferences prefs() {
        return MrTools.sApp == null ? null : PreferenceManager.getDefaultSharedPreferences(MrTools.sApp);
    }

    /** A string of the app by its name, null when it is not there. */
    private static String text(String name) {
        if (MrTools.sApp == null) return null;
        Resources r = MrTools.sApp.getResources();
        int id = r.getIdentifier(name, "string", MrTools.sApp.getPackageName());
        return id == 0 ? null : r.getString(id);
    }
}
