.class final Lcom/mrkeyboard/app/MrSymbols;
.super Ljava/lang/Object;
.source "MrSymbols.java"


# static fields
.field static final CATS:I = 0x8

.field static final PREF_RECENT:Ljava/lang/String; = "symbol_recent"

.field static final RECENT_DEFAULT:Ljava/lang/String; = "\u2605|\u2665|\u2714|\u279c|\u266a|\u263a|\u273f|\u2661|\u270c|\u262f|\u20ac|\u221e"

.field static final RECENT_MAX:I = 0x18

.field static final SETS:[Ljava/lang/String;

.field static final TAB:[Ljava/lang/String;

.field private static sEmojis:Landroid/widget/TextView;

.field private static sOn:Z

.field private static sPaint:Landroid/graphics/Paint;

.field private static sRecent:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final sShown:[Ljava/lang/String;

.field private static sSymbols:Landroid/widget/TextView;

.field private static sTabIcons:[Landroid/graphics/drawable/Drawable;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v7, 0x3

    const/4 v6, 0x2

    const/4 v5, 0x1

    const/4 v4, 0x0

    const/16 v3, 0x8

    .line 39
    new-array v0, v3, [Ljava/lang/String;

    const-string v1, "\u2605"

    aput-object v1, v0, v4

    const-string v1, "\u2665"

    aput-object v1, v0, v5

    const-string v1, "\u279c"

    aput-object v1, v0, v6

    const-string v1, "\u2211"

    aput-object v1, v0, v7

    const/4 v1, 0x4

    const-string v2, "\u266a"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "\u25c6"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "\u265e"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "\u20ac"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrSymbols;->TAB:[Ljava/lang/String;

    .line 46
    new-array v0, v3, [Ljava/lang/String;

    const-string v1, "\u2605\u2606\u272a\u272b\u272c\u272d\u272e\u272f\u2730\u2729\u2726\u2727\u2721\u269d\u2b51\u2b52\u235f\u2735\u2734\u2733\u2732\u2731\u2736\u2737\u2738\u2739\u273a\u273b\u273c\u273d\u273e\u273f\u2740\u2741\u2742\u2743\u2744\u2745\u2746\u2747\u2748\u2749\u274a\u274b\u2724\u2723\u2722\u2756\u2698\u269c\u2618\u2042\u204e\u2051\u2055\u2058\u2059\u2600\u263c\u2609\u26e4\u26e5\u26e6\u26e7"

    aput-object v1, v0, v4

    const-string v1, "\u2661\u2665\u2764\u2763\u2765\u2766\u2767\u2619\u2762\u10d3\u10e6\u2660\u2663\u2666\u2664\u2667\u2662\u263a\u263b\u2639\u2620\u30c4\u30c3\u30b7\u30c5\u32db\u0298\u0ca0\u0ca5\u0ca1\u0e4f\u0e51\u25d5\u25d4\u25c9\u25ce\u25e0\u25e1\u203f\u2040\u1d17\u1d25\u1d54\u1d55\ua4b3\u02d8\u03c9\u2200\u25bd\u0414\u30ee\u0296\uc6c3\uc720\u3162\u3161\u3160\u315c\u3157\u3145\u314f\u3154\u3147\u3141\u2640\u2642\u26a5"

    aput-object v1, v0, v5

    const-string v1, "\u261c\u261d\u261e\u261f\u261a\u261b\u270c\u270d\u270b\u270a\u2190\u2191\u2192\u2193\u2194\u2195\u2196\u2197\u2198\u2199\u219a\u219b\u219c\u219d\u219e\u219f\u21a0\u21a1\u21a2\u21a3\u21a4\u21a5\u21a6\u21a7\u21a8\u21a9\u21aa\u21ab\u21ac\u21ad\u21ae\u21af\u21b0\u21b1\u21b2\u21b3\u21b4\u21b5\u21b6\u21b7\u21b8\u21b9\u21ba\u21bb\u21bc\u21bd\u21be\u21bf\u21c0\u21c1\u21c2\u21c3\u21c4\u21c5\u21c6\u21c7\u21c8\u21c9\u21ca\u21cb\u21cc\u21cd\u21ce\u21cf\u21d0\u21d1\u21d2\u21d3\u21d4\u21d5\u21d6\u21d7\u21d8\u21d9\u21da\u21db\u21dc\u21dd\u21de\u21df\u21e0\u21e1\u21e2\u21e3\u21e4\u21e5\u21e6\u21e7\u21e8\u21e9\u21ea\u21eb\u21ec\u21ed\u21ee\u21ef\u21f0\u21f1\u21f2\u21f3\u21f4\u21f5\u21f6\u21f7\u21f8\u21f9\u21fa\u21fb\u21fc\u21fd\u21fe\u21ff\u2794\u2798\u2799\u279a\u279b\u279c\u279d\u279e\u279f\u27a0\u27a1\u27a2\u27a3\u27a4\u27a5\u27a6\u27a7\u27a8\u27a9\u27aa\u27ab\u27ac\u27ad\u27ae\u27af\u27b1\u27b2\u27b3\u27b4\u27b5\u27b6\u27b7\u27b8\u27b9\u27ba\u27bb\u27bc\u27bd\u27be\u27f5\u27f6\u27f7\u27f8\u27f9\u27fa\u27fb\u27fc\u2900\u2903\u2904\u2905\u2906\u2907\u2912\u2913\u2934\u2935\u2b05\u2b06\u2b07\u2b08\u2b09\u2b0a\u2b0b\u2b0c\u2b0d\u2b60\u2b62\u2b61\u2b63"

    aput-object v1, v0, v6

    const-string v1, "\u00b1\u2213\u00d7\u00f7\u2215\u2212+=\u2260\u2248\u2245\u2243\u2261\u2262\u2264\u2265\u226a\u226b\u2270\u2271<>\u00ac\u221e\u221a\u221b\u221c\u2211\u220f\u222b\u222c\u222d\u222e\u2202\u2206\u2207\u2208\u2209\u220b\u220c\u2229\u222a\u2282\u2283\u2286\u2287\u2205\u2203\u2204\u2227\u2228\u2295\u2297\u221d\u2220\u2225\u22a5\u2234\u2235\u223c\u2030\u2031\u00b0\u2032\u2033\u2034\u00bd\u2153\u2154\u00bc\u00be\u2155\u2156\u2157\u2158\u2159\u215a\u215b\u215c\u215d\u215e\u2189\u2070\u00b9\u00b2\u00b3\u2074\u2075\u2076\u2077\u2078\u2079\u207a\u207b\u207c\u207d\u207e\u207f\u2080\u2081\u2082\u2083\u2084\u2085\u2086\u2087\u2088\u2089\u208a\u208b\u208c\u208d\u208e\u2460\u2461\u2462\u2463\u2464\u2465\u2466\u2467\u2468\u2469\u246a\u246b\u246c\u246d\u246e\u246f\u2470\u2471\u2472\u2473\u24ea\u2776\u2777\u2778\u2779\u277a\u277b\u277c\u277d\u277e\u277f\u2780\u2781\u2782\u2783\u2784\u2785\u2786\u2787\u2788\u2789\u2160\u2161\u2162\u2163\u2164\u2165\u2166\u2167\u2168\u2169\u216a\u216b\u2170\u2171\u2172\u2173\u2174\u2175\u2176\u2177\u2178\u2179\u217a\u217b\u03b1\u03b2\u03b3\u03b4\u03b5\u03b8\u03bb\u03bc\u03c0\u03c3\u03c6\u0394\u03a3\u03a9\u03a0\u03a6\u03a8\u00b5\u210f\u2113\u2118\u2111\u211c\u2135\u2102\u210d\u2115\u2119\u211a\u211d\u2124"

    aput-object v1, v0, v7

    const/4 v1, 0x4

    const-string v2, "\u2669\u266a\u266b\u266c\u266d\u266e\u266f\u2601\u2602\u2603\u2604\u2614\u263d\u263e\u2607\u2608\u03df\u26a1\u26c5\u26c8\u2668\u269b\u267b\u2672\u2673\u2674\u2675\u2676\u2677\u2678\u2679\u267a\u267c\u267d\u262f\u262e\u2638\u262a\u262d\u2626\u2625\u2627\u2628\u2629\u262c\u262b\u271d\u2648\u2649\u264a\u264b\u264c\u264d\u264e\u264f\u2650\u2651\u2652\u2653\u260a\u260b\u260c\u260d\u2641\u263f\u2643\u2644\u2645\u2646\u2647"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "\u25a0\u25a1\u25a2\u25a3\u25a4\u25a5\u25a6\u25a7\u25a8\u25a9\u25aa\u25ab\u25ac\u25ad\u25ae\u25af\u25b0\u25b1\u25b2\u25b3\u25b4\u25b5\u25b6\u25b7\u25b8\u25b9\u25ba\u25bb\u25bc\u25be\u25bf\u25c0\u25c1\u25c2\u25c3\u25c4\u25c5\u25c6\u25c7\u25c8\u25ca\u25cb\u25cc\u25cd\u25cf\u25d0\u25d1\u25d2\u25d3\u25d6\u25d7\u25d8\u25d9\u25da\u25db\u25dc\u25dd\u25de\u25df\u25e2\u25e3\u25e4\u25e5\u25e6\u25e7\u25e8\u25e9\u25ea\u25eb\u25ec\u25ed\u25ee\u25ef\u25f0\u25f1\u25f2\u25f3\u25f4\u25f5\u25f6\u25f7\u25f8\u25f9\u25fa\u25fb\u25fc\u25fd\u25fe\u25ff\u2b12\u2b13\u2b14\u2b15\u2b16\u2b17\u2b18\u2b19\u2b1a\u2b1b\u2b1c\u2b1d\u2b1e\u2b1f\u2b20\u2b21\u2b22\u2b23\u2b24\u2b25\u2b26\u2b27\u2b28\u2b29\u2b2a\u2b2b\u2b2c\u2b2d\u2b2e\u2b2f\u2580\u2581\u2582\u2583\u2584\u2585\u2586\u2587\u2588\u2589\u258a\u258b\u258c\u258d\u258e\u258f\u2590\u2591\u2592\u2593\u2594\u2595\u2596\u2597\u2598\u2599\u259a\u259b\u259c\u259d\u259e\u259f\u2500\u2501\u2502\u2503\u250c\u250f\u2510\u2513\u2514\u2517\u2518\u251b\u251c\u2523\u2524\u252b\u252c\u2533\u2534\u253b\u253c\u254b\u2550\u2551\u2554\u2557\u255a\u255d\u2560\u2563\u2566\u2569\u256c\u256d\u256e\u256f\u2570\u2571\u2572\u2573\u2574\u2575\u2576\u2577\u3010\u3011\u300c\u300d\u300e\u300f\u300a\u300b\u3008\u3009\u3014\u3015\u3016\u3017\uff3b\uff3d\uff5b\uff5d\ufe41\ufe42\u275b\u275c\u275d\u275e\u2039\u203a\u00ab\u00bb\u201c\u201d\u2018\u2019\u201e\u2026\u2022\u2023\u2043\u2219\u00b7\u2025\u205d\u205e\u2758\u2759\u275a\u2e2e\u203d\u2047\u2048\u2049"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "\ud80c\udcd2\ud80c\udcd3\ud80c\udcd4\ud80c\udcd5\ud80c\udcd6\ud80c\udcd7\ud80c\udcd8\ud80c\udcd9\ud80c\udcda\ud80c\udcdb\ud80c\udcdc\ud80c\udcdd\ud80c\udcde\ud80c\udcdf\ud80c\udce0\ud80c\udce1\ud80c\udce2\ud80c\udce3\ud80c\udce4\ud80c\udce5\ud80c\udce6\ud80c\udce7\ud80c\udce8\ud80c\udce9\ud80c\udcea\ud80c\udceb\ud80c\udcec\ud80c\udced\ud80c\udcee\ud80c\udcef\ud80c\udcf0\ud80c\udcf1\ud80c\udcf2\ud80c\udcf3\ud80c\udcf4\ud80c\udcf5\ud80c\udcf6\ud80c\udcf7\ud80c\udcf8\ud80c\udcf9\ud80c\udcfa\ud80c\udcfb\ud80c\udcfc\ud80c\udcfd\ud80c\udd3f\ud80c\udd40\ud80c\udd41\ud80c\udd42\ud80c\udd43\ud80c\udd44\ud80c\udd45\ud80c\udd46\ud80c\udd47\ud80c\udd48\ud80c\udd49\ud80c\udd4a\ud80c\udd4b\ud80c\udd4c\ud80c\udd4d\ud80c\udd4e\ud80c\udd4f\ud80c\udd50\ud80c\udd51\ud80c\udd52\ud80c\udd53\ud80c\udd54\ud80c\udd55\ud80c\udd56\ud80c\udd57\ud80c\udd58\ud80c\udd59\ud80c\udd5a\ud80c\udd5b\ud80c\udd5c\ud80c\udd5d\ud80c\udd5e\ud80c\udd5f\ud80c\udd60\ud80c\udd61\ud80c\udd62\ud80c\udd63\ud80c\udd64\ud80c\udd65\ud80c\udd66\ud80c\udd67\ud80c\udd68\ud80c\udd69\ud80c\udd6a\ud80c\udd6b\ud80c\udd6c\ud80c\udd6d\ud80c\udd6e\ud80c\udd6f\ud80c\udd70\ud80c\udd71\ud80c\udd72\ud80c\udd73\ud80c\udd74\ud80c\udd75\ud80c\udd76\ud80c\udd77\ud80c\udd78\ud80c\udd79\ud80c\udd7a\ud80c\udd7b\ud80c\udd7c\ud80c\udd7d\ud80c\udd7e\ud80c\udd88\ud80c\udd89\ud80c\udd8a\ud80c\udd8b\ud80c\udd8c\ud80c\udd8d\ud80c\udd8e\ud80c\udd8f\ud80c\udd90\ud80c\udd91\ud80c\udd92\ud80c\udd93\ud80c\udd94\ud80c\udd95\ud80c\udd96\ud80c\udd97\ud80c\udd98\ud80c\udd99\ud80c\udd9a\ud80c\udd9b\ud80c\udd9c\ud80c\udd9d\ud80c\udd9e\ud80c\udd9f\ud80c\udda0\ud80c\udda1\ud80c\udda2\ud80c\udda3\ud80c\udda4\ud80c\udda5\ud80c\udda6\ud80c\udda7\ud80c\udda8\ud80c\udda9\ud80c\uddaa\ud80c\uddab\ud80c\uddac\ud80c\udc80\ud80c\udef9\u2654\u2655\u2656\u2657\u2658\u2659\u265a\u265b\u265c\u265d\u265e\u265f\ud83c\udca1\ud83c\udcb1\ud83c\udcc1\ud83c\udcd1\ud83c\udca0\ud83c\udccf\u2680\u2681\u2682\u2683\u2684\u2685\u26a2\u26a3\u26a4\u26a6\u26a7\u26a8\u26a9\u26b2"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "$\u00a2\u00a3\u00a4\u00a5\u20ac\u20a0\u20a1\u20a2\u20a3\u20a4\u20a5\u20a6\u20a7\u20a8\u20a9\u20aa\u20ab\u20ad\u20ae\u20af\u20b0\u20b1\u20b2\u20b3\u20b4\u20b5\u20b6\u20b7\u20b8\u20b9\u20ba\u20bb\u20bc\u20bd\u20be\u20bf\u0e3f\u17db\ufdfc\u00a9\u00ae\u2122\u2120\u2117\u00a7\u00b6\u2020\u2021\u2116\u2105\u2100\u2101\u2121\u2103\u2109\u211e\u214d\u2713\u2714\u2715\u2716\u2717\u2718\u2610\u2611\u2612\u237b\u2318\u2325\u2303\u23ce\u232b\u2326\u238b\u2328\u2702\u2709\u270e\u270f\u2706\u260e\u260f\u231a\u231b\u2615\u2708\u26a0\u2622\u2623\u2699\u2696\u2694\u2693\u267f\u2691\u2690\u2692\u2697\u26b0"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrSymbols;->SETS:[Ljava/lang/String;

    .line 90
    new-array v0, v3, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrSymbols;->sShown:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 93
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static addRecent(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 204
    sget-boolean v0, Lcom/mrkeyboard/app/MrSymbols;->sOn:Z

    if-nez v0, :cond_0

    .line 205
    invoke-static {p0}, Lcom/mrkeyboard/app/MrEmotes;->addRecent(Ljava/lang/String;)V

    .line 213
    :goto_0
    return-void

    .line 208
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrSymbols;->loadRecent()V

    .line 209
    sget-object v0, Lcom/mrkeyboard/app/MrSymbols;->sRecent:Ljava/util/ArrayList;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 210
    sget-object v0, Lcom/mrkeyboard/app/MrSymbols;->sRecent:Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, p0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 211
    :goto_1
    sget-object v0, Lcom/mrkeyboard/app/MrSymbols;->sRecent:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v1, 0x18

    if-le v0, v1, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrSymbols;->sRecent:Ljava/util/ArrayList;

    sget-object v1, Lcom/mrkeyboard/app/MrSymbols;->sRecent:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    goto :goto_1

    .line 212
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrSymbols;->save()V

    goto :goto_0
.end method

.method private static buttons()V
    .locals 4

    .prologue
    const/16 v1, 0x8

    const/4 v2, 0x0

    .line 153
    sget-object v0, Lcom/mrkeyboard/app/MrSymbols;->sSymbols:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrSymbols;->sEmojis:Landroid/widget/TextView;

    if-nez v0, :cond_1

    .line 156
    :cond_0
    :goto_0
    return-void

    .line 154
    :cond_1
    sget-object v3, Lcom/mrkeyboard/app/MrSymbols;->sSymbols:Landroid/widget/TextView;

    sget-boolean v0, Lcom/mrkeyboard/app/MrSymbols;->sOn:Z

    if-eqz v0, :cond_2

    move v0, v1

    :goto_1
    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setVisibility(I)V

    .line 155
    sget-object v0, Lcom/mrkeyboard/app/MrSymbols;->sEmojis:Landroid/widget/TextView;

    sget-boolean v3, Lcom/mrkeyboard/app/MrSymbols;->sOn:Z

    if-eqz v3, :cond_3

    :goto_2
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0

    :cond_2
    move v0, v2

    .line 154
    goto :goto_1

    :cond_3
    move v2, v1

    .line 155
    goto :goto_2
.end method

.method static drawable(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 235
    sget-object v0, Lcom/mrkeyboard/app/MrSymbols;->sPaint:Landroid/graphics/Paint;

    if-nez v0, :cond_0

    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    sput-object v0, Lcom/mrkeyboard/app/MrSymbols;->sPaint:Landroid/graphics/Paint;

    .line 236
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 237
    const/4 v0, 0x0

    .line 238
    :cond_1
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v0, v2, :cond_3

    .line 239
    invoke-virtual {p0, v0}, Ljava/lang/String;->codePointAt(I)I

    move-result v2

    .line 240
    invoke-static {v2}, Ljava/lang/Character;->charCount(I)I

    move-result v3

    add-int/2addr v0, v3

    .line 241
    new-instance v3, Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v2

    invoke-direct {v3, v2}, Ljava/lang/String;-><init>([C)V

    .line 242
    sget-object v2, Lcom/mrkeyboard/app/MrSymbols;->sPaint:Landroid/graphics/Paint;

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->hasGlyph(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 243
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->length()I

    move-result v2

    if-lez v2, :cond_2

    const/16 v2, 0x7c

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 244
    :cond_2
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 246
    :cond_3
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static forget(Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 217
    invoke-static {}, Lcom/mrkeyboard/app/MrSymbols;->loadRecent()V

    .line 218
    sget-object v0, Lcom/mrkeyboard/app/MrSymbols;->sRecent:Ljava/util/ArrayList;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 221
    :goto_0
    return v0

    .line 219
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrSymbols;->save()V

    .line 220
    invoke-static {}, Lcom/mrkeyboard/app/MrEmotes;->refresh()V

    .line 221
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private static join(Ljava/util/ArrayList;)Ljava/lang/String;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    .line 250
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 251
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_1

    .line 252
    if-lez v1, :cond_0

    const/16 v0, 0x7c

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 253
    :cond_0
    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 251
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 255
    :cond_1
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static leave()V
    .locals 1

    .prologue
    .line 136
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrSymbols;->set(Z)V

    .line 137
    return-void
.end method

.method private static loadRecent()V
    .locals 5

    .prologue
    .line 259
    sget-object v0, Lcom/mrkeyboard/app/MrSymbols;->sRecent:Ljava/util/ArrayList;

    if-eqz v0, :cond_1

    .line 268
    :cond_0
    return-void

    .line 260
    :cond_1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrSymbols;->sRecent:Ljava/util/ArrayList;

    .line 261
    const-string v0, "\u2605|\u2665|\u2714|\u279c|\u266a|\u263a|\u273f|\u2661|\u270c|\u262f|\u20ac|\u221e"

    .line 262
    invoke-static {}, Lcom/mrkeyboard/app/MrSymbols;->prefs()Landroid/content/SharedPreferences;

    move-result-object v1

    .line 263
    if-eqz v1, :cond_2

    const-string v0, "symbol_recent"

    const-string v2, ""

    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 264
    :cond_2
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_4

    :cond_3
    const-string v0, "\u2605|\u2665|\u2714|\u279c|\u266a|\u263a|\u273f|\u2661|\u270c|\u262f|\u20ac|\u221e"

    .line 265
    :cond_4
    const-string v1, "[|]"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    array-length v2, v1

    const/4 v0, 0x0

    :goto_0
    if-ge v0, v2, :cond_0

    aget-object v3, v1, v0

    .line 266
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-lez v4, :cond_5

    sget-object v4, Lcom/mrkeyboard/app/MrSymbols;->sRecent:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_5

    sget-object v4, Lcom/mrkeyboard/app/MrSymbols;->sRecent:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 265
    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method static names(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 190
    sget-boolean v0, Lcom/mrkeyboard/app/MrSymbols;->sOn:Z

    if-nez v0, :cond_1

    .line 192
    :cond_0
    :goto_0
    return-object p0

    .line 191
    :cond_1
    const-string v0, "mr_sym_cats"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrSymbols;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 192
    if-eqz v0, :cond_0

    move-object p0, v0

    goto :goto_0
.end method

.method static on()Z
    .locals 1

    .prologue
    .line 126
    sget-boolean v0, Lcom/mrkeyboard/app/MrSymbols;->sOn:Z

    return v0
.end method

.method private static prefs()Landroid/content/SharedPreferences;
    .locals 1

    .prologue
    .line 276
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    goto :goto_0
.end method

.method static recent(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 197
    sget-boolean v0, Lcom/mrkeyboard/app/MrSymbols;->sOn:Z

    if-nez v0, :cond_0

    .line 199
    :goto_0
    return-object p0

    .line 198
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrSymbols;->loadRecent()V

    .line 199
    sget-object v0, Lcom/mrkeyboard/app/MrSymbols;->sRecent:Ljava/util/ArrayList;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrSymbols;->join(Ljava/util/ArrayList;)Ljava/lang/String;

    move-result-object p0

    goto :goto_0
.end method

.method static rows(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 185
    sget-boolean v0, Lcom/mrkeyboard/app/MrSymbols;->sOn:Z

    if-eqz v0, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrSymbols;->shown(I)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrEmotes;->data(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static save()V
    .locals 3

    .prologue
    .line 271
    invoke-static {}, Lcom/mrkeyboard/app/MrSymbols;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 272
    if-eqz v0, :cond_0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "symbol_recent"

    sget-object v2, Lcom/mrkeyboard/app/MrSymbols;->sRecent:Ljava/util/ArrayList;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrSymbols;->join(Ljava/util/ArrayList;)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 273
    :cond_0
    return-void
.end method

.method private static set(Z)V
    .locals 1

    .prologue
    .line 140
    sget-boolean v0, Lcom/mrkeyboard/app/MrSymbols;->sOn:Z

    if-ne p0, v0, :cond_0

    .line 149
    :goto_0
    return-void

    .line 141
    :cond_0
    sput-boolean p0, Lcom/mrkeyboard/app/MrSymbols;->sOn:Z

    .line 143
    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrSymbols;->tabs()V

    .line 144
    invoke-static {}, Lcom/mrkeyboard/app/MrSymbols;->buttons()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 148
    :goto_1
    invoke-static {}, Lcom/mrkeyboard/app/MrEmotes;->refresh()V

    goto :goto_0

    .line 145
    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method static setup(Landroid/view/View;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 99
    sget-boolean v0, Lcom/mrkeyboard/app/MrSymbols;->sOn:Z

    if-eqz v0, :cond_0

    .line 101
    sput-boolean v2, Lcom/mrkeyboard/app/MrSymbols;->sOn:Z

    .line 102
    invoke-static {}, Lcom/mrkeyboard/app/MrSymbols;->tabs()V

    .line 104
    :cond_0
    sput-boolean v2, Lcom/mrkeyboard/app/MrSymbols;->sOn:Z

    .line 105
    sput-object v1, Lcom/mrkeyboard/app/MrSymbols;->sTabIcons:[Landroid/graphics/drawable/Drawable;

    .line 106
    sput-object v1, Lcom/mrkeyboard/app/MrSymbols;->sRecent:Ljava/util/ArrayList;

    .line 107
    sput-object v1, Lcom/mrkeyboard/app/MrSymbols;->sSymbols:Landroid/widget/TextView;

    .line 108
    sput-object v1, Lcom/mrkeyboard/app/MrSymbols;->sEmojis:Landroid/widget/TextView;

    .line 109
    if-nez p0, :cond_2

    .line 123
    :cond_1
    :goto_0
    return-void

    .line 110
    :cond_2
    const-string v0, "emote_sym"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 111
    const-string v1, "emote_emo"

    invoke-virtual {p0, v1}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    .line 112
    instance-of v2, v0, Landroid/widget/TextView;

    if-eqz v2, :cond_1

    instance-of v2, v1, Landroid/widget/TextView;

    if-eqz v2, :cond_1

    .line 113
    check-cast v0, Landroid/widget/TextView;

    sput-object v0, Lcom/mrkeyboard/app/MrSymbols;->sSymbols:Landroid/widget/TextView;

    move-object v0, v1

    .line 114
    check-cast v0, Landroid/widget/TextView;

    sput-object v0, Lcom/mrkeyboard/app/MrSymbols;->sEmojis:Landroid/widget/TextView;

    .line 115
    new-instance v0, Lcom/mrkeyboard/app/MrSymbols$1;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrSymbols$1;-><init>()V

    .line 120
    sget-object v1, Lcom/mrkeyboard/app/MrSymbols;->sSymbols:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 121
    sget-object v1, Lcom/mrkeyboard/app/MrSymbols;->sEmojis:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 122
    invoke-static {}, Lcom/mrkeyboard/app/MrSymbols;->buttons()V

    goto :goto_0
.end method

.method private static declared-synchronized shown(I)Ljava/lang/String;
    .locals 3

    .prologue
    .line 228
    const-class v1, Lcom/mrkeyboard/app/MrSymbols;

    monitor-enter v1

    if-ltz p0, :cond_0

    const/16 v0, 0x8

    if-lt p0, v0, :cond_1

    :cond_0
    :try_start_0
    const-string v0, ""
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 230
    :goto_0
    monitor-exit v1

    return-object v0

    .line 229
    :cond_1
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrSymbols;->sShown:[Ljava/lang/String;

    aget-object v0, v0, p0

    if-nez v0, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrSymbols;->sShown:[Ljava/lang/String;

    sget-object v2, Lcom/mrkeyboard/app/MrSymbols;->SETS:[Ljava/lang/String;

    aget-object v2, v2, p0

    invoke-static {v2}, Lcom/mrkeyboard/app/MrSymbols;->drawable(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, p0

    .line 230
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrSymbols;->sShown:[Ljava/lang/String;

    aget-object v0, v0, p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 228
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private static tabs()V
    .locals 7

    .prologue
    const/4 v0, 0x1

    const/4 v6, 0x0

    .line 160
    sget-object v1, Lcom/mrkeyboard/app/MrEmotes;->sTabs:[Landroid/widget/TextView;

    .line 161
    if-eqz v1, :cond_0

    array-length v2, v1

    const/16 v3, 0x9

    if-eq v2, v3, :cond_1

    .line 179
    :cond_0
    :goto_0
    return-void

    .line 162
    :cond_1
    sget-boolean v2, Lcom/mrkeyboard/app/MrSymbols;->sOn:Z

    if-eqz v2, :cond_4

    .line 163
    array-length v2, v1

    new-array v2, v2, [Landroid/graphics/drawable/Drawable;

    .line 164
    :goto_1
    array-length v3, v1

    if-ge v0, v3, :cond_3

    .line 165
    aget-object v3, v1, v0

    if-nez v3, :cond_2

    .line 164
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 166
    :cond_2
    aget-object v3, v1, v0

    invoke-virtual {v3}, Landroid/widget/TextView;->getCompoundDrawables()[Landroid/graphics/drawable/Drawable;

    move-result-object v3

    const/4 v4, 0x0

    aget-object v3, v3, v4

    aput-object v3, v2, v0

    .line 167
    aget-object v3, v1, v0

    invoke-virtual {v3, v6, v6, v6, v6}, Landroid/widget/TextView;->setCompoundDrawables(Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    .line 168
    aget-object v3, v1, v0

    sget-object v4, Lcom/mrkeyboard/app/MrSymbols;->TAB:[Ljava/lang/String;

    add-int/lit8 v5, v0, -0x1

    aget-object v4, v4, v5

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_2

    .line 170
    :cond_3
    sput-object v2, Lcom/mrkeyboard/app/MrSymbols;->sTabIcons:[Landroid/graphics/drawable/Drawable;

    goto :goto_0

    .line 171
    :cond_4
    sget-object v2, Lcom/mrkeyboard/app/MrSymbols;->sTabIcons:[Landroid/graphics/drawable/Drawable;

    if-eqz v2, :cond_0

    .line 172
    :goto_3
    array-length v2, v1

    if-ge v0, v2, :cond_6

    .line 173
    aget-object v2, v1, v0

    if-nez v2, :cond_5

    .line 172
    :goto_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 174
    :cond_5
    aget-object v2, v1, v0

    const-string v3, ""

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 175
    aget-object v2, v1, v0

    sget-object v3, Lcom/mrkeyboard/app/MrSymbols;->sTabIcons:[Landroid/graphics/drawable/Drawable;

    aget-object v3, v3, v0

    invoke-virtual {v2, v3, v6, v6, v6}, Landroid/widget/TextView;->setCompoundDrawables(Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    goto :goto_4

    .line 177
    :cond_6
    sput-object v6, Lcom/mrkeyboard/app/MrSymbols;->sTabIcons:[Landroid/graphics/drawable/Drawable;

    goto :goto_0
.end method

.method private static text(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 281
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    if-nez v1, :cond_1

    .line 284
    :cond_0
    :goto_0
    return-object v0

    .line 282
    :cond_1
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    .line 283
    const-string v2, "string"

    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, p0, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 284
    if-eqz v2, :cond_0

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static toggle()V
    .locals 1

    .prologue
    .line 131
    sget-boolean v0, Lcom/mrkeyboard/app/MrSymbols;->sOn:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-static {v0}, Lcom/mrkeyboard/app/MrSymbols;->set(Z)V

    .line 132
    return-void

    .line 131
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
