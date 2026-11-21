.class final Lcom/mrkeyboard/app/MrKeyLook;
.super Ljava/lang/Object;
.source "MrKeyLook.java"


# static fields
.field static final DASH_OFF_SHARE:F = 0.45f

.field static final LINE_BASE:F = 0.6f

.field static final NONE:Lcom/mrkeyboard/app/MrKeyLook;

.field static final OPACITY_DEFAULT:I = 0x64

.field static final OPACITY_MAX:I = 0xfa

.field static final PALE:F = 0.85f

.field static final PARTNER_SHIFT:F = 100.0f

.field static final PREFIX:Ljava/lang/String; = "pref_kbd_look_"

.field static final PREFS:[Ljava/lang/String;

.field static final PREF_EDGE:Ljava/lang/String; = "pref_kbd_look_edge"

.field static final PREF_HUE:Ljava/lang/String; = "pref_kbd_look_hue"

.field static final PREF_HUE2:Ljava/lang/String; = "pref_kbd_look_hue2"

.field static final PREF_KEY:Ljava/lang/String; = "pref_kbd_look_key"

.field static final PREF_LINE:Ljava/lang/String; = "pref_kbd_look_line"

.field static final PREF_TEXT:Ljava/lang/String; = "pref_kbd_look_text"

.field static final TONE_DOWN:F = 0.14f

.field static final TONE_UP:F = 0.28f

.field private static sCurrent:Lcom/mrkeyboard/app/MrKeyLook;

.field private static sVersion:I


# instance fields
.field final edge:I

.field final hue:I

.field final hue2:I

.field final key:I

.field final line:I

.field final text:I


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .prologue
    const/16 v1, 0x64

    const/4 v3, 0x0

    .line 22
    const/4 v0, 0x6

    new-array v0, v0, [Ljava/lang/String;

    const-string v2, "pref_kbd_look_key"

    aput-object v2, v0, v3

    const/4 v2, 0x1

    const-string v4, "pref_kbd_look_edge"

    aput-object v4, v0, v2

    const/4 v2, 0x2

    const-string v4, "pref_kbd_look_text"

    aput-object v4, v0, v2

    const/4 v2, 0x3

    const-string v4, "pref_kbd_look_hue"

    aput-object v4, v0, v2

    const/4 v2, 0x4

    const-string v4, "pref_kbd_look_hue2"

    aput-object v4, v0, v2

    const/4 v2, 0x5

    const-string v4, "pref_kbd_look_line"

    aput-object v4, v0, v2

    sput-object v0, Lcom/mrkeyboard/app/MrKeyLook;->PREFS:[Ljava/lang/String;

    .line 41
    new-instance v0, Lcom/mrkeyboard/app/MrKeyLook;

    move v2, v1

    move v4, v3

    move v5, v3

    move v6, v3

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIIII)V

    sput-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    return-void
.end method

.method constructor <init>(IIIII)V
    .locals 7

    .prologue
    .line 50
    const/4 v6, 0x0

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIIII)V

    .line 51
    return-void
.end method

.method constructor <init>(IIIIII)V
    .locals 3

    .prologue
    const/4 v1, 0x0

    const/high16 v2, -0x1000000

    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 54
    invoke-static {p1}, Lcom/mrkeyboard/app/MrKeyLook;->clampOpacity(I)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    .line 55
    invoke-static {p2}, Lcom/mrkeyboard/app/MrKeyLook;->clampOpacity(I)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    .line 56
    if-nez p3, :cond_0

    move v0, v1

    :goto_0
    iput v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    .line 57
    if-nez p4, :cond_1

    move v0, v1

    :goto_1
    iput v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    .line 58
    if-nez p5, :cond_2

    move v0, v1

    :goto_2
    iput v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    .line 59
    if-nez p6, :cond_3

    :goto_3
    iput v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    .line 60
    return-void

    .line 56
    :cond_0
    or-int v0, v2, p3

    goto :goto_0

    .line 57
    :cond_1
    or-int v0, v2, p4

    goto :goto_1

    .line 58
    :cond_2
    or-int v0, v2, p5

    goto :goto_2

    .line 59
    :cond_3
    or-int v1, v2, p6

    goto :goto_3
.end method

.method static changed(Ljava/lang/String;)Z
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 156
    if-nez p0, :cond_1

    .line 161
    :cond_0
    :goto_0
    return v0

    .line 158
    :cond_1
    const-string v1, "pref_kbd_bg"

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "pref_kbd_bg_soft"

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    :cond_2
    sget v1, Lcom/mrkeyboard/app/MrKeyLook;->sVersion:I

    add-int/lit8 v1, v1, 0x1

    sput v1, Lcom/mrkeyboard/app/MrKeyLook;->sVersion:I

    .line 159
    :cond_3
    const-string v1, "pref_kbd_look_"

    invoke-virtual {p0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 160
    invoke-static {}, Lcom/mrkeyboard/app/MrKeyLook;->invalidate()V

    .line 161
    const/4 v0, 0x1

    goto :goto_0
.end method

.method static clampOpacity(I)I
    .locals 1

    .prologue
    const/16 v0, 0xfa

    .line 63
    if-gez p0, :cond_1

    const/4 p0, 0x0

    :cond_0
    :goto_0
    return p0

    :cond_1
    if-le p0, v0, :cond_0

    move p0, v0

    goto :goto_0
.end method

.method static current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 1

    .prologue
    .line 141
    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->sCurrent:Lcom/mrkeyboard/app/MrKeyLook;

    .line 142
    if-nez v0, :cond_0

    .line 143
    invoke-static {p0}, Lcom/mrkeyboard/app/MrKeyLook;->read(Landroid/content/Context;)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    .line 144
    if-eqz p0, :cond_0

    sput-object v0, Lcom/mrkeyboard/app/MrKeyLook;->sCurrent:Lcom/mrkeyboard/app/MrKeyLook;

    .line 146
    :cond_0
    return-object v0
.end method

.method static dashOff(I)I
    .locals 2

    .prologue
    .line 214
    const/high16 v0, -0x1000000

    or-int/2addr v0, p0

    const v1, 0x3ee66666    # 0.45f

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrGlow;->fade(IF)I

    move-result v0

    return v0
.end method

.method static invalidate()V
    .locals 1

    .prologue
    .line 165
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrKeyLook;->sCurrent:Lcom/mrkeyboard/app/MrKeyLook;

    .line 166
    sget v0, Lcom/mrkeyboard/app/MrKeyLook;->sVersion:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrKeyLook;->sVersion:I

    .line 167
    return-void
.end method

.method static lineFor(II)I
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 183
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v1

    if-eqz v1, :cond_1

    .line 185
    :cond_0
    :goto_0
    return v0

    .line 184
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->isOwnStyle(I)Z

    move-result v1

    if-eqz v1, :cond_3

    if-eqz p1, :cond_2

    :goto_1
    invoke-static {p1}, Lcom/mrkeyboard/app/MrKeyLook;->toneAbove(I)I

    move-result v0

    goto :goto_0

    :cond_2
    const p1, -0x908401

    goto :goto_1

    .line 185
    :cond_3
    if-eqz p0, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrBackdrop;->STYLE_COLORS:[[I

    aget-object v1, v1, p0

    aget v0, v1, v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeyLook;->toneAbove(I)I

    move-result v0

    goto :goto_0
.end method

.method static middle(II)I
    .locals 1

    .prologue
    .line 209
    const/high16 v0, 0x3e800000    # 0.25f

    invoke-static {p0, p1, p1, v0}, Lcom/mrkeyboard/app/MrGlow;->ramp(IIIF)I

    move-result v0

    return v0
.end method

.method static partner(I)I
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x1

    .line 201
    const/4 v0, 0x3

    new-array v2, v0, [F

    .line 202
    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 203
    aget v0, v2, v3

    const v1, 0x3eb33333    # 0.35f

    cmpg-float v0, v0, v1

    if-gez v0, :cond_0

    const v0, 0x3f0ccccd    # 0.55f

    :goto_0
    aget v1, v2, v4

    const v3, 0x3f19999a    # 0.6f

    cmpg-float v1, v1, v3

    if-gez v1, :cond_1

    const v1, 0x3f666666    # 0.9f

    .line 204
    :goto_1
    const/4 v3, 0x0

    aget v2, v2, v3

    const/high16 v3, 0x42c80000    # 100.0f

    add-float/2addr v2, v3

    const/high16 v3, 0x43b40000    # 360.0f

    rem-float/2addr v2, v3

    invoke-static {v2, v0, v1}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v0

    return v0

    .line 203
    :cond_0
    aget v0, v2, v3

    goto :goto_0

    :cond_1
    aget v1, v2, v4

    goto :goto_1
.end method

.method static read(Landroid/content/Context;)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 1

    .prologue
    .line 121
    if-nez p0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    :goto_0
    return-object v0

    :cond_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeyLook;->read(Landroid/content/SharedPreferences;)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    goto :goto_0
.end method

.method static read(Landroid/content/SharedPreferences;)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 8

    .prologue
    .line 112
    if-nez p0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    .line 116
    :goto_0
    return-object v0

    .line 114
    :cond_0
    :try_start_0
    new-instance v0, Lcom/mrkeyboard/app/MrKeyLook;

    const-string v1, "pref_kbd_look_key"

    const/16 v2, 0x64

    invoke-interface {p0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    const-string v2, "pref_kbd_look_edge"

    const/16 v3, 0x64

    invoke-interface {p0, v2, v3}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v2

    const-string v3, "pref_kbd_look_text"

    const/4 v4, 0x0

    invoke-interface {p0, v3, v4}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v3

    const-string v4, "pref_kbd_look_hue"

    const/4 v5, 0x0

    invoke-interface {p0, v4, v5}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v4

    const-string v5, "pref_kbd_look_hue2"

    const/4 v6, 0x0

    invoke-interface {p0, v5, v6}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v5

    const-string v6, "pref_kbd_look_line"

    const/4 v7, 0x0

    invoke-interface {p0, v6, v7}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v6

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIIII)V
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 115
    :catch_0
    move-exception v0

    .line 116
    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    goto :goto_0
.end method

.method static spectrum(Ljava/lang/String;Lcom/mrkeyboard/app/MrKeyLook;)[I
    .locals 6

    .prologue
    const/4 v2, 0x3

    const/4 v5, 0x1

    const/4 v4, 0x0

    const/4 v3, 0x2

    .line 192
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->isOwn(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    if-nez p1, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 196
    :goto_0
    return-object v0

    .line 193
    :cond_1
    iget v0, p1, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    if-eqz v0, :cond_2

    iget v0, p1, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    .line 194
    :goto_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->styleOf(Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v1

    if-eq v1, v3, :cond_3

    new-array v1, v2, [I

    aput v0, v1, v4

    aput v0, v1, v5

    aput v0, v1, v3

    move-object v0, v1

    goto :goto_0

    .line 193
    :cond_2
    const v0, -0x908401

    goto :goto_1

    .line 195
    :cond_3
    iget v1, p1, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    if-eqz v1, :cond_4

    iget v1, p1, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    .line 196
    :goto_2
    new-array v2, v2, [I

    aput v0, v2, v4

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrKeyLook;->middle(II)I

    move-result v0

    aput v0, v2, v5

    aput v1, v2, v3

    move-object v0, v2

    goto :goto_0

    .line 195
    :cond_4
    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeyLook;->partner(I)I

    move-result v1

    goto :goto_2
.end method

.method static toneAbove(I)I
    .locals 4

    .prologue
    const/high16 v3, -0x1000000

    .line 173
    or-int v0, v3, p0

    .line 174
    invoke-static {v0}, Lcom/mrkeyboard/app/MrThemeColors;->luminance(I)F

    move-result v1

    const v2, 0x3f59999a    # 0.85f

    cmpl-float v1, v1, v2

    if-lez v1, :cond_0

    const v1, 0x3e0f5c29    # 0.14f

    invoke-static {v0, v3, v1}, Lcom/mrkeyboard/app/MrBackdrop;->mix(IIF)I

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v1, -0x1

    const v2, 0x3e8f5c29    # 0.28f

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrBackdrop;->mix(IIF)I

    move-result v0

    goto :goto_0
.end method

.method static version()I
    .locals 1

    .prologue
    .line 151
    sget v0, Lcom/mrkeyboard/app/MrKeyLook;->sVersion:I

    return v0
.end method


# virtual methods
.method faceTuned()Z
    .locals 2

    .prologue
    const/16 v1, 0x64

    .line 97
    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method isNone()Z
    .locals 2

    .prologue
    const/16 v1, 0x64

    .line 92
    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    if-nez v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    if-nez v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    if-nez v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method lineAlpha()F
    .locals 3

    .prologue
    .line 102
    const/high16 v0, 0x3f800000    # 1.0f

    const v1, 0x3f19999a    # 0.6f

    iget v2, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    int-to-float v2, v2

    mul-float/2addr v1, v2

    const/high16 v2, 0x42c80000    # 100.0f

    div-float/2addr v1, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->min(FF)F

    move-result v0

    return v0
.end method

.method same(Lcom/mrkeyboard/app/MrKeyLook;)Z
    .locals 2

    .prologue
    .line 106
    if-eqz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    iget v1, p1, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    iget v1, p1, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    iget v1, p1, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    iget v1, p1, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    iget v1, p1, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    iget v1, p1, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method withEdge(I)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 7

    .prologue
    .line 71
    new-instance v0, Lcom/mrkeyboard/app/MrKeyLook;

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    iget v3, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    iget v4, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    iget v5, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    iget v6, p0, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    move v2, p1

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIIII)V

    return-object v0
.end method

.method withHue(I)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 7

    .prologue
    .line 79
    new-instance v0, Lcom/mrkeyboard/app/MrKeyLook;

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    iget v3, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    iget v5, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    iget v6, p0, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    move v4, p1

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIIII)V

    return-object v0
.end method

.method withHue2(I)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 7

    .prologue
    .line 83
    new-instance v0, Lcom/mrkeyboard/app/MrKeyLook;

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    iget v3, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    iget v4, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    iget v6, p0, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    move v5, p1

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIIII)V

    return-object v0
.end method

.method withKey(I)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 7

    .prologue
    .line 67
    new-instance v0, Lcom/mrkeyboard/app/MrKeyLook;

    iget v2, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    iget v3, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    iget v4, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    iget v5, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    iget v6, p0, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    move v1, p1

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIIII)V

    return-object v0
.end method

.method withLine(I)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 7

    .prologue
    .line 87
    new-instance v0, Lcom/mrkeyboard/app/MrKeyLook;

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    iget v3, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    iget v4, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    iget v5, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    move v6, p1

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIIII)V

    return-object v0
.end method

.method withText(I)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 7

    .prologue
    .line 75
    new-instance v0, Lcom/mrkeyboard/app/MrKeyLook;

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    iget v4, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    iget v5, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    iget v6, p0, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    move v3, p1

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIIII)V

    return-object v0
.end method

.method write(Landroid/content/SharedPreferences$Editor;)V
    .locals 2

    .prologue
    .line 126
    const-string v0, "pref_kbd_look_key"

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 127
    const-string v0, "pref_kbd_look_edge"

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 128
    const-string v0, "pref_kbd_look_text"

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 129
    const-string v0, "pref_kbd_look_hue"

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 130
    const-string v0, "pref_kbd_look_hue2"

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 131
    const-string v0, "pref_kbd_look_line"

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 132
    return-void
.end method
