.class final Lcom/mrkeyboard/app/MrFonts;
.super Ljava/lang/Object;
.source "MrFonts.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrFonts$Back;,
        Lcom/mrkeyboard/app/MrFonts$Pick;
    }
.end annotation


# static fields
.field static final CODE_DELETE:I = -0x5

.field static final COMB:[I

.field static final EXC:[Ljava/lang/String;

.field static final KEY:Ljava/lang/String; = "pref_font_style"

.field static final LOW:[I

.field static final MODE:I = 0x6

.field static final SMALL_CAPS:[I

.field static final STYLES:I = 0x1b

.field static final SUB:[I

.field static final SUPER:[I

.field static final TAB:[[I

.field static final UP:[I

.field private static sBar:Landroid/view/View;

.field private static sButtons:[Landroid/widget/TextView;

.field private static sChoice:I

.field private static sCtx:Landroid/content/Context;

.field private static sMainBar:Landroid/view/View;

.field private static sRow:Landroid/widget/LinearLayout;

.field private static sTextOff:I


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v7, 0x1

    const/4 v6, 0x0

    const/16 v5, 0x34

    const/16 v4, 0x1b

    const/4 v3, 0x0

    .line 49
    new-array v0, v4, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/mrkeyboard/app/MrFonts;->UP:[I

    .line 56
    new-array v0, v4, [I

    fill-array-data v0, :array_1

    sput-object v0, Lcom/mrkeyboard/app/MrFonts;->LOW:[I

    .line 67
    new-array v0, v4, [Ljava/lang/String;

    const-string v1, ""

    aput-object v1, v0, v6

    const-string v1, "h\u210e"

    aput-object v1, v0, v7

    const/4 v1, 0x2

    const-string v2, ""

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, ""

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, ""

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, ""

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, ""

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "B\u212cE\u2130F\u2131H\u210bI\u2110L\u2112M\u2133R\u211be\u212fg\u210ao\u2134"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "C\u212dH\u210cI\u2111R\u211cZ\u2128"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "C\u2102H\u210dN\u2115P\u2119Q\u211aR\u211dZ\u2124"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0x16

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0x17

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0x18

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0x19

    const-string v2, ""

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    const-string v2, ""

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrFonts;->EXC:[Ljava/lang/String;

    .line 78
    new-array v0, v5, [I

    fill-array-data v0, :array_2

    sput-object v0, Lcom/mrkeyboard/app/MrFonts;->SMALL_CAPS:[I

    .line 94
    new-array v0, v5, [I

    fill-array-data v0, :array_3

    sput-object v0, Lcom/mrkeyboard/app/MrFonts;->SUPER:[I

    .line 111
    new-array v0, v5, [I

    fill-array-data v0, :array_4

    sput-object v0, Lcom/mrkeyboard/app/MrFonts;->SUB:[I

    .line 127
    new-array v0, v4, [[I

    aput-object v3, v0, v6

    aput-object v3, v0, v7

    const/4 v1, 0x2

    aput-object v3, v0, v1

    const/4 v1, 0x3

    aput-object v3, v0, v1

    const/4 v1, 0x4

    aput-object v3, v0, v1

    const/4 v1, 0x5

    aput-object v3, v0, v1

    const/4 v1, 0x6

    aput-object v3, v0, v1

    const/4 v1, 0x7

    aput-object v3, v0, v1

    const/16 v1, 0x8

    aput-object v3, v0, v1

    const/16 v1, 0x9

    aput-object v3, v0, v1

    const/16 v1, 0xa

    aput-object v3, v0, v1

    const/16 v1, 0xb

    aput-object v3, v0, v1

    const/16 v1, 0xc

    aput-object v3, v0, v1

    const/16 v1, 0xd

    aput-object v3, v0, v1

    const/16 v1, 0xe

    aput-object v3, v0, v1

    const/16 v1, 0xf

    aput-object v3, v0, v1

    const/16 v1, 0x10

    aput-object v3, v0, v1

    const/16 v1, 0x11

    aput-object v3, v0, v1

    const/16 v1, 0x12

    sget-object v2, Lcom/mrkeyboard/app/MrFonts;->SMALL_CAPS:[I

    aput-object v2, v0, v1

    const/16 v1, 0x13

    sget-object v2, Lcom/mrkeyboard/app/MrFonts;->SUPER:[I

    aput-object v2, v0, v1

    const/16 v1, 0x14

    sget-object v2, Lcom/mrkeyboard/app/MrFonts;->SUB:[I

    aput-object v2, v0, v1

    const/16 v1, 0x15

    aput-object v3, v0, v1

    const/16 v1, 0x16

    aput-object v3, v0, v1

    const/16 v1, 0x17

    aput-object v3, v0, v1

    const/16 v1, 0x18

    aput-object v3, v0, v1

    const/16 v1, 0x19

    aput-object v3, v0, v1

    const/16 v1, 0x1a

    aput-object v3, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrFonts;->TAB:[[I

    .line 138
    new-array v0, v4, [I

    fill-array-data v0, :array_5

    sput-object v0, Lcom/mrkeyboard/app/MrFonts;->COMB:[I

    return-void

    .line 49
    :array_0
    .array-data 4
        0x1d400
        0x1d434
        0x1d468
        0x1d5a0
        0x1d5d4
        0x1d608
        0x1d63c
        0x1d670
        0x1d49c
        0x1d4d0
        0x1d504
        0x1d56c
        0x1d538
        0x24b6
        0x1f150
        0x1f130
        0x1f170
        0x249c
        0x0
        0x0
        0x0
        0xff21
        0x0
        0x0
        0x0
        0x0
        0x0
    .end array-data

    .line 56
    :array_1
    .array-data 4
        0x1d41a
        0x1d44e
        0x1d482
        0x1d5ba
        0x1d5ee
        0x1d622
        0x1d656
        0x1d68a
        0x1d4b6
        0x1d4ea
        0x1d51e
        0x1d586
        0x1d552
        0x24d0
        0x1f150
        0x1f130
        0x1f170
        0x249c
        0x0
        0x0
        0x0
        0xff41
        0x0
        0x0
        0x0
        0x0
        0x0
    .end array-data

    .line 78
    :array_2
    .array-data 4
        0x1d00
        0x299
        0x1d04
        0x1d05
        0x1d07
        0xa730
        0x262
        0x29c
        0x26a
        0x1d0a
        0x1d0b
        0x29f
        0x1d0d
        0x274
        0x1d0f
        0x1d18
        0x1eb
        0x280
        0xa731
        0x1d1b
        0x1d1c
        0x1d20
        0x1d21
        0x78
        0x28f
        0x1d22
        0x1d00
        0x299
        0x1d04
        0x1d05
        0x1d07
        0xa730
        0x262
        0x29c
        0x26a
        0x1d0a
        0x1d0b
        0x29f
        0x1d0d
        0x274
        0x1d0f
        0x1d18
        0x1eb
        0x280
        0xa731
        0x1d1b
        0x1d1c
        0x1d20
        0x1d21
        0x78
        0x28f
        0x1d22
    .end array-data

    .line 94
    :array_3
    .array-data 4
        0x1d2c
        0x1d2e
        0x0
        0x1d30
        0x1d31
        0x0
        0x1d33
        0x1d34
        0x1d35
        0x1d36
        0x1d37
        0x1d38
        0x1d39
        0x1d3a
        0x1d3c
        0x1d3e
        0x0
        0x1d3f
        0x0
        0x1d40
        0x1d41
        0x2c7d
        0x1d42
        0x0
        0x0
        0x0
        0x1d43
        0x1d47
        0x1d9c
        0x1d48
        0x1d49
        0x1da0
        0x1d4d
        0x2b0
        0x2071
        0x2b2
        0x1d4f
        0x2e1
        0x1d50
        0x207f
        0x1d52
        0x1d56
        0x0
        0x2b3
        0x2e2
        0x1d57
        0x1d58
        0x1d5b
        0x2b7
        0x2e3
        0x2b8
        0x1dbb
    .end array-data

    .line 111
    :array_4
    .array-data 4
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x2090
        0x0
        0x0
        0x0
        0x2091
        0x0
        0x0
        0x2095
        0x1d62
        0x2c7c
        0x2096
        0x2097
        0x2098
        0x2099
        0x2092
        0x209a
        0x0
        0x1d63
        0x209b
        0x209c
        0x1d64
        0x1d65
        0x0
        0x2093
        0x0
        0x0
    .end array-data

    .line 138
    :array_5
    .array-data 4
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x332
        0x333
        0x336
        0x305
        0x338
    .end array-data
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 154
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$100(I)V
    .locals 0

    .prologue
    .line 28
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFonts;->choose(I)V

    return-void
.end method

.method private static activeBg()Landroid/graphics/drawable/GradientDrawable;
    .locals 2

    .prologue
    .line 393
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 394
    const-string v1, "ctrl_bg"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 395
    const/high16 v1, 0x40000000    # 2.0f

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->radius(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 396
    return-object v0
.end method

.method static afterPanel(I)V
    .locals 2

    .prologue
    .line 194
    const/4 v0, 0x6

    if-eq p0, v0, :cond_1

    .line 198
    :cond_0
    :goto_0
    return-void

    .line 195
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->sMainBar:Landroid/view/View;

    if-eqz v0, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->sMainBar:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 196
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    .line 197
    if-eqz v0, :cond_0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0
.end method

.method private static build()V
    .locals 3

    .prologue
    .line 330
    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->sRow:Landroid/widget/LinearLayout;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    if-nez v0, :cond_1

    .line 334
    :cond_0
    return-void

    .line 331
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->sRow:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 332
    const/16 v0, 0x1c

    new-array v0, v0, [Landroid/widget/TextView;

    sput-object v0, Lcom/mrkeyboard/app/MrFonts;->sButtons:[Landroid/widget/TextView;

    .line 333
    const/4 v0, 0x0

    :goto_0
    const/16 v1, 0x1b

    if-gt v0, v1, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrFonts;->sButtons:[Landroid/widget/TextView;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrFonts;->button(I)Landroid/widget/TextView;

    move-result-object v2

    aput-object v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method private static button(I)Landroid/widget/TextView;
    .locals 6

    .prologue
    const/16 v5, 0xa

    const/4 v1, 0x0

    .line 342
    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v2, "mr_font_btn"

    const-string v3, "layout"

    sget-object v4, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 343
    if-eqz v0, :cond_0

    .line 344
    sget-object v2, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    invoke-static {v2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v2

    sget-object v3, Lcom/mrkeyboard/app/MrFonts;->sRow:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v0, v3, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    move-object v2, v0

    .line 351
    :goto_0
    if-nez p0, :cond_1

    invoke-static {}, Lcom/mrkeyboard/app/MrFonts;->normalName()Ljava/lang/String;

    move-result-object v0

    .line 352
    :goto_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "f_btn_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 353
    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    .line 354
    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 355
    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->sRow:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 357
    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->sRow:Landroid/widget/LinearLayout;

    const/4 v4, -0x1

    invoke-static {v0, v3, v4}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    .line 358
    invoke-virtual {v2}, Landroid/widget/TextView;->getCurrentTextColor()I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrFonts;->sTextOff:I

    .line 359
    new-instance v0, Lcom/mrkeyboard/app/MrFonts$Pick;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrFonts$Pick;-><init>(I)V

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 360
    sget v0, Lcom/mrkeyboard/app/MrFonts;->sChoice:I

    if-ne p0, v0, :cond_2

    const/4 v0, 0x1

    :goto_2
    invoke-static {v2, p0, v0}, Lcom/mrkeyboard/app/MrFonts;->select(Landroid/widget/TextView;IZ)V

    .line 361
    return-object v2

    .line 346
    :cond_0
    new-instance v0, Landroid/widget/TextView;

    sget-object v2, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    invoke-direct {v0, v2}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 347
    const/high16 v2, 0x41400000    # 12.0f

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextSize(F)V

    .line 348
    const/16 v2, 0x11

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 349
    invoke-static {v5}, Lcom/mrkeyboard/app/MrFonts;->dp(I)I

    move-result v2

    invoke-static {v5}, Lcom/mrkeyboard/app/MrFonts;->dp(I)I

    move-result v3

    invoke-virtual {v0, v2, v1, v3, v1}, Landroid/widget/TextView;->setPadding(IIII)V

    move-object v2, v0

    goto :goto_0

    .line 351
    :cond_1
    add-int/lit8 v0, p0, -0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrFonts;->styleName(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_2
    move v0, v1

    .line 360
    goto :goto_2
.end method

.method private static choose(I)V
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 406
    sput p0, Lcom/mrkeyboard/app/MrFonts;->sChoice:I

    .line 407
    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    if-eqz v0, :cond_0

    .line 408
    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "pref_font_style"

    invoke-interface {v0, v2, p0}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 410
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->sButtons:[Landroid/widget/TextView;

    if-eqz v0, :cond_3

    move v0, v1

    .line 411
    :goto_0
    sget-object v2, Lcom/mrkeyboard/app/MrFonts;->sButtons:[Landroid/widget/TextView;

    array-length v2, v2

    if-ge v0, v2, :cond_3

    .line 412
    sget-object v2, Lcom/mrkeyboard/app/MrFonts;->sButtons:[Landroid/widget/TextView;

    aget-object v2, v2, v0

    if-eqz v2, :cond_1

    sget-object v2, Lcom/mrkeyboard/app/MrFonts;->sButtons:[Landroid/widget/TextView;

    aget-object v3, v2, v0

    if-ne v0, p0, :cond_2

    const/4 v2, 0x1

    :goto_1
    invoke-static {v3, v0, v2}, Lcom/mrkeyboard/app/MrFonts;->select(Landroid/widget/TextView;IZ)V

    .line 411
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    move v2, v1

    .line 412
    goto :goto_1

    .line 415
    :cond_3
    invoke-static {}, Lcom/mrkeyboard/app/MrFonts;->refreshKeys()V

    .line 416
    return-void
.end method

.method private static deleteCluster(Landroid/view/inputmethod/InputConnection;)Z
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 266
    invoke-interface {p0, v0}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;

    move-result-object v1

    .line 267
    if-eqz v1, :cond_1

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-lez v1, :cond_1

    .line 278
    :cond_0
    :goto_0
    return v0

    .line 268
    :cond_1
    const/16 v1, 0x10

    invoke-interface {p0, v1, v0}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v1

    .line 269
    if-eqz v1, :cond_0

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-eqz v2, :cond_0

    .line 270
    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    .line 271
    invoke-static {}, Ljava/text/BreakIterator;->getCharacterInstance()Ljava/text/BreakIterator;

    move-result-object v2

    .line 272
    invoke-virtual {v2, v1}, Ljava/text/BreakIterator;->setText(Ljava/lang/String;)V

    .line 273
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/text/BreakIterator;->preceding(I)I

    move-result v2

    .line 274
    const/4 v3, -0x1

    if-eq v2, v3, :cond_0

    .line 275
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    sub-int/2addr v3, v2

    .line 276
    const/4 v4, 0x2

    if-lt v3, v4, :cond_0

    const-string v4, "\r\n"

    invoke-virtual {v1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 277
    invoke-interface {p0, v3, v0}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z

    .line 278
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private static dp(I)I
    .locals 2

    .prologue
    .line 400
    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    .line 401
    int-to-float v1, p0

    mul-float/2addr v0, v1

    const/high16 v1, 0x3f000000    # 0.5f

    add-float/2addr v0, v1

    float-to-int v0, v0

    return v0
.end method

.method static fieldTakesStyle(Landroid/view/inputmethod/EditorInfo;)Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x1

    .line 206
    if-nez p0, :cond_1

    .line 210
    :cond_0
    :goto_0
    return v0

    .line 207
    :cond_1
    iget v2, p0, Landroid/view/inputmethod/EditorInfo;->inputType:I

    .line 208
    and-int/lit8 v3, v2, 0xf

    if-eq v3, v0, :cond_2

    move v0, v1

    goto :goto_0

    .line 209
    :cond_2
    and-int/lit16 v2, v2, 0xff0

    .line 210
    const/16 v3, 0x10

    if-eq v2, v3, :cond_3

    const/16 v3, 0x20

    if-eq v2, v3, :cond_3

    const/16 v3, 0x80

    if-eq v2, v3, :cond_3

    const/16 v3, 0x90

    if-eq v2, v3, :cond_3

    const/16 v3, 0xd0

    if-eq v2, v3, :cond_3

    const/16 v3, 0xe0

    if-ne v2, v3, :cond_0

    :cond_3
    move v0, v1

    goto :goto_0
.end method

.method private static label(I)Ljava/lang/String;
    .locals 3

    .prologue
    .line 366
    if-nez p0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrFonts;->normalName()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 367
    :goto_0
    return-object v0

    :cond_0
    add-int/lit8 v0, p0, -0x1

    add-int/lit8 v1, p0, -0x1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrFonts;->styleName(I)Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrFonts;->styledText(ILjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static letter(IC)Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 294
    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->EXC:[Ljava/lang/String;

    aget-object v3, v0, p0

    move v0, v1

    .line 295
    :goto_0
    add-int/lit8 v4, v0, 0x1

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v4, v5, :cond_1

    .line 296
    invoke-virtual {v3, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    if-ne v4, p1, :cond_0

    new-instance v1, Ljava/lang/String;

    add-int/lit8 v0, v0, 0x1

    invoke-virtual {v3, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>([C)V

    move-object v0, v1

    .line 309
    :goto_1
    return-object v0

    .line 295
    :cond_0
    add-int/lit8 v0, v0, 0x2

    goto :goto_0

    .line 298
    :cond_1
    const/16 v0, 0x41

    if-lt p1, v0, :cond_3

    const/16 v0, 0x5a

    if-gt p1, v0, :cond_3

    move v0, v2

    .line 299
    :goto_2
    const/16 v3, 0x61

    if-lt p1, v3, :cond_2

    const/16 v3, 0x7a

    if-gt p1, v3, :cond_2

    move v1, v2

    .line 300
    :cond_2
    if-nez v0, :cond_4

    if-nez v1, :cond_4

    const/4 v0, 0x0

    goto :goto_1

    :cond_3
    move v0, v1

    .line 298
    goto :goto_2

    .line 301
    :cond_4
    sget-object v1, Lcom/mrkeyboard/app/MrFonts;->COMB:[I

    aget v1, v1, p0

    if-eqz v1, :cond_5

    .line 302
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {p1}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    new-instance v1, Ljava/lang/String;

    sget-object v2, Lcom/mrkeyboard/app/MrFonts;->COMB:[I

    aget v2, v2, p0

    invoke-static {v2}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/String;-><init>([C)V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 304
    :cond_5
    sget-object v1, Lcom/mrkeyboard/app/MrFonts;->TAB:[[I

    aget-object v1, v1, p0

    if-eqz v1, :cond_8

    .line 305
    sget-object v1, Lcom/mrkeyboard/app/MrFonts;->TAB:[[I

    aget-object v1, v1, p0

    if-eqz v0, :cond_6

    add-int/lit8 v0, p1, -0x41

    :goto_3
    aget v0, v1, v0

    .line 306
    new-instance v1, Ljava/lang/String;

    if-nez v0, :cond_7

    :goto_4
    invoke-static {p1}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>([C)V

    move-object v0, v1

    goto :goto_1

    .line 305
    :cond_6
    add-int/lit8 v0, p1, -0x61

    add-int/lit8 v0, v0, 0x1a

    goto :goto_3

    :cond_7
    move p1, v0

    .line 306
    goto :goto_4

    .line 308
    :cond_8
    if-eqz v0, :cond_9

    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->UP:[I

    aget v0, v0, p0

    add-int/lit8 v1, p1, -0x41

    add-int/2addr v0, v1

    .line 309
    :goto_5
    new-instance v1, Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>([C)V

    move-object v0, v1

    goto :goto_1

    .line 308
    :cond_9
    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->LOW:[I

    aget v0, v0, p0

    add-int/lit8 v1, p1, -0x61

    add-int/2addr v0, v1

    goto :goto_5
.end method

.method private static normalName()Ljava/lang/String;
    .locals 4

    .prologue
    .line 372
    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "mr_font_default"

    const-string v2, "string"

    sget-object v3, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 373
    if-nez v0, :cond_0

    const-string v0, "Normal"

    :goto_0
    return-object v0

    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static onPanel(I)V
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 184
    const/4 v0, 0x6

    if-ne p0, v0, :cond_2

    const/4 v0, 0x1

    .line 185
    :goto_0
    sget-object v2, Lcom/mrkeyboard/app/MrFonts;->sBar:Landroid/view/View;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/mrkeyboard/app/MrFonts;->sBar:Landroid/view/View;

    if-eqz v0, :cond_3

    :goto_1
    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    .line 186
    :cond_0
    if-eqz v0, :cond_1

    invoke-static {}, Lcom/mrkeyboard/app/MrFonts;->build()V

    .line 187
    :cond_1
    return-void

    :cond_2
    move v0, v1

    .line 184
    goto :goto_0

    .line 185
    :cond_3
    const/16 v1, 0x8

    goto :goto_1
.end method

.method private static refreshKeys()V
    .locals 2

    .prologue
    .line 420
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    .line 421
    instance-of v1, v0, Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    if-eqz v1, :cond_0

    .line 422
    check-cast v0, Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->invalidateAllKeys()V

    .line 424
    :cond_0
    return-void
.end method

.method private static select(Landroid/widget/TextView;IZ)V
    .locals 1

    .prologue
    .line 381
    invoke-static {p1}, Lcom/mrkeyboard/app/MrFonts;->label(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 382
    if-eqz p2, :cond_0

    .line 383
    invoke-static {}, Lcom/mrkeyboard/app/MrFonts;->activeBg()Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 384
    const-string v0, "accent_text"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 389
    :goto_0
    return-void

    .line 386
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->flatBg()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 387
    sget v0, Lcom/mrkeyboard/app/MrFonts;->sTextOff:I

    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_0
.end method

.method static setup(Landroid/view/View;)V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 158
    sput-object v5, Lcom/mrkeyboard/app/MrFonts;->sBar:Landroid/view/View;

    .line 159
    sput-object v5, Lcom/mrkeyboard/app/MrFonts;->sMainBar:Landroid/view/View;

    .line 160
    sput-object v5, Lcom/mrkeyboard/app/MrFonts;->sRow:Landroid/widget/LinearLayout;

    .line 161
    sput-object v5, Lcom/mrkeyboard/app/MrFonts;->sButtons:[Landroid/widget/TextView;

    .line 162
    sput-object v5, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    .line 163
    if-nez p0, :cond_1

    .line 180
    :cond_0
    :goto_0
    return-void

    .line 164
    :cond_1
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 165
    sput-object v0, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    .line 166
    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "pref_font_style"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrFonts;->sChoice:I

    .line 167
    const-string v0, "bar_fonts"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    .line 168
    const-string v0, "f_row"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 169
    const-string v2, "f_back"

    invoke-virtual {p0, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    .line 170
    const-string v3, "bar_main"

    invoke-virtual {p0, v3}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v3

    .line 171
    if-eqz v1, :cond_0

    instance-of v4, v0, Landroid/widget/LinearLayout;

    if-eqz v4, :cond_0

    .line 172
    sput-object v1, Lcom/mrkeyboard/app/MrFonts;->sBar:Landroid/view/View;

    .line 173
    check-cast v0, Landroid/widget/LinearLayout;

    sput-object v0, Lcom/mrkeyboard/app/MrFonts;->sRow:Landroid/widget/LinearLayout;

    .line 174
    sput-object v3, Lcom/mrkeyboard/app/MrFonts;->sMainBar:Landroid/view/View;

    .line 175
    if-eqz v2, :cond_2

    .line 176
    const-string v0, "f_back"

    const/4 v1, -0x1

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    .line 177
    new-instance v0, Lcom/mrkeyboard/app/MrFonts$Back;

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrFonts$Back;-><init>(Lcom/mrkeyboard/app/MrFonts$1;)V

    invoke-virtual {v2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 179
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->sBar:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0
.end method

.method static styleLabel(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 223
    sget v0, Lcom/mrkeyboard/app/MrFonts;->sChoice:I

    if-lez v0, :cond_0

    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    .line 227
    :cond_0
    :goto_0
    return-object p0

    .line 224
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 225
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrFonts;->fieldTakesStyle(Landroid/view/inputmethod/EditorInfo;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 226
    :cond_2
    sget v0, Lcom/mrkeyboard/app/MrFonts;->sChoice:I

    add-int/lit8 v0, v0, -0x1

    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrFonts;->styled(IC)Ljava/lang/String;

    move-result-object v0

    .line 227
    if-eqz v0, :cond_0

    move-object p0, v0

    goto :goto_0
.end method

.method static styleName(I)Ljava/lang/String;
    .locals 4

    .prologue
    .line 324
    sget-object v0, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mr_font_style_"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "string"

    sget-object v3, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 325
    if-nez v0, :cond_0

    const-string v0, ""

    :goto_0
    return-object v0

    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrFonts;->sCtx:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static styleOn(Landroid/view/inputmethod/EditorInfo;)Z
    .locals 1

    .prologue
    .line 258
    sget v0, Lcom/mrkeyboard/app/MrFonts;->sChoice:I

    if-lez v0, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrFonts;->fieldTakesStyle(Landroid/view/inputmethod/EditorInfo;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static styled(IC)Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 283
    if-ltz p0, :cond_0

    const/16 v1, 0x1b

    if-lt p0, v1, :cond_1

    .line 289
    :cond_0
    :goto_0
    return-object v0

    .line 284
    :cond_1
    const/16 v1, 0x80

    if-ge p1, v1, :cond_2

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrFonts;->letter(IC)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 286
    :cond_2
    invoke-static {p1}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ljava/text/Normalizer$Form;->NFD:Ljava/text/Normalizer$Form;

    invoke-static {v1, v2}, Ljava/text/Normalizer;->normalize(Ljava/lang/CharSequence;Ljava/text/Normalizer$Form;)Ljava/lang/String;

    move-result-object v1

    .line 287
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrFonts;->letter(IC)Ljava/lang/String;

    move-result-object v2

    .line 288
    if-eqz v2, :cond_0

    .line 289
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static styledText(ILjava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 314
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 315
    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-ge v0, v1, :cond_1

    .line 316
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrFonts;->styled(IC)Ljava/lang/String;

    move-result-object v1

    .line 317
    if-nez v1, :cond_0

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v1

    :cond_0
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 315
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 319
    :cond_1
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static typeStyled(Lcom/mrkeyboard/app/LatinIME;I)Z
    .locals 5

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 237
    if-eqz p0, :cond_0

    sget v2, Lcom/mrkeyboard/app/MrFonts;->sChoice:I

    if-gtz v2, :cond_1

    .line 249
    :cond_0
    :goto_0
    return v0

    .line 238
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrFonts;->fieldTakesStyle(Landroid/view/inputmethod/EditorInfo;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 239
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v2

    .line 240
    if-eqz v2, :cond_0

    .line 241
    const/4 v3, -0x5

    if-ne p1, v3, :cond_2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrFonts;->deleteCluster(Landroid/view/inputmethod/InputConnection;)Z

    move-result v0

    goto :goto_0

    .line 242
    :cond_2
    if-ltz p1, :cond_0

    const v3, 0xffff

    if-gt p1, v3, :cond_0

    .line 243
    sget v3, Lcom/mrkeyboard/app/MrFonts;->sChoice:I

    add-int/lit8 v3, v3, -0x1

    int-to-char v4, p1

    invoke-static {v3, v4}, Lcom/mrkeyboard/app/MrFonts;->styled(IC)Ljava/lang/String;

    move-result-object v3

    .line 244
    if-eqz v3, :cond_0

    .line 247
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrEndWord()V

    .line 248
    invoke-interface {v2, v3, v1}, Landroid/view/inputmethod/InputConnection;->commitText(Ljava/lang/CharSequence;I)Z

    move v0, v1

    .line 249
    goto :goto_0
.end method
