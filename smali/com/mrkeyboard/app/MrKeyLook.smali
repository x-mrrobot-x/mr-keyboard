.class final Lcom/mrkeyboard/app/MrKeyLook;
.super Ljava/lang/Object;
.source "MrKeyLook.java"


# static fields
.field static final DASH_OFF_SHARE:F = 0.45f

.field static final NONE:Lcom/mrkeyboard/app/MrKeyLook;

.field static final OPACITY_DEFAULT:I = 0x64

.field static final OPACITY_MAX:I = 0xfa

.field static final PARTNER_SHIFT:F = 100.0f

.field static final PREFIX:Ljava/lang/String; = "pref_kbd_look_"

.field static final PREFS:[Ljava/lang/String;

.field static final PREF_EDGE:Ljava/lang/String; = "pref_kbd_look_edge"

.field static final PREF_HUE:Ljava/lang/String; = "pref_kbd_look_hue"

.field static final PREF_HUE2:Ljava/lang/String; = "pref_kbd_look_hue2"

.field static final PREF_KEY:Ljava/lang/String; = "pref_kbd_look_key"

.field static final PREF_TEXT:Ljava/lang/String; = "pref_kbd_look_text"

.field private static sCurrent:Lcom/mrkeyboard/app/MrKeyLook;

.field private static sVersion:I


# instance fields
.field final edge:I

.field final hue:I

.field final hue2:I

.field final key:I

.field final text:I


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .prologue
    const/16 v1, 0x64

    const/4 v3, 0x0

    .line 22
    const/4 v0, 0x5

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

    sput-object v0, Lcom/mrkeyboard/app/MrKeyLook;->PREFS:[Ljava/lang/String;

    .line 31
    new-instance v0, Lcom/mrkeyboard/app/MrKeyLook;

    move v2, v1

    move v4, v3

    move v5, v3

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIII)V

    sput-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    return-void
.end method

.method constructor <init>(IIIII)V
    .locals 3

    .prologue
    const/4 v1, 0x0

    const/high16 v2, -0x1000000

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    invoke-static {p1}, Lcom/mrkeyboard/app/MrKeyLook;->clampOpacity(I)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    .line 38
    invoke-static {p2}, Lcom/mrkeyboard/app/MrKeyLook;->clampOpacity(I)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    .line 39
    if-nez p3, :cond_0

    move v0, v1

    :goto_0
    iput v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    .line 40
    if-nez p4, :cond_1

    move v0, v1

    :goto_1
    iput v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    .line 41
    if-nez p5, :cond_2

    :goto_2
    iput v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    .line 42
    return-void

    .line 39
    :cond_0
    or-int v0, v2, p3

    goto :goto_0

    .line 40
    :cond_1
    or-int v0, v2, p4

    goto :goto_1

    .line 41
    :cond_2
    or-int v1, v2, p5

    goto :goto_2
.end method

.method static changed(Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 128
    if-eqz p0, :cond_0

    const-string v0, "pref_kbd_look_"

    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 130
    :goto_0
    return v0

    .line 129
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrKeyLook;->invalidate()V

    .line 130
    const/4 v0, 0x1

    goto :goto_0
.end method

.method static clampOpacity(I)I
    .locals 1

    .prologue
    const/16 v0, 0xfa

    .line 45
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
    .line 113
    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->sCurrent:Lcom/mrkeyboard/app/MrKeyLook;

    .line 114
    if-nez v0, :cond_0

    .line 115
    invoke-static {p0}, Lcom/mrkeyboard/app/MrKeyLook;->read(Landroid/content/Context;)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    .line 116
    if-eqz p0, :cond_0

    sput-object v0, Lcom/mrkeyboard/app/MrKeyLook;->sCurrent:Lcom/mrkeyboard/app/MrKeyLook;

    .line 118
    :cond_0
    return-object v0
.end method

.method static dashOff(I)I
    .locals 2

    .prologue
    .line 164
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
    .line 134
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrKeyLook;->sCurrent:Lcom/mrkeyboard/app/MrKeyLook;

    .line 135
    sget v0, Lcom/mrkeyboard/app/MrKeyLook;->sVersion:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrKeyLook;->sVersion:I

    .line 136
    return-void
.end method

.method static middle(II)I
    .locals 1

    .prologue
    .line 159
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

    .line 151
    const/4 v0, 0x3

    new-array v2, v0, [F

    .line 152
    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 153
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

    .line 154
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

    .line 153
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
    .line 94
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
    .locals 7

    .prologue
    .line 85
    if-nez p0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    .line 89
    :goto_0
    return-object v0

    .line 87
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

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIII)V
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 88
    :catch_0
    move-exception v0

    .line 89
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

    .line 142
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->isOwn(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    if-nez p1, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 146
    :goto_0
    return-object v0

    .line 143
    :cond_1
    iget v0, p1, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    if-eqz v0, :cond_2

    iget v0, p1, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    .line 144
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

    .line 143
    :cond_2
    const v0, -0x908401

    goto :goto_1

    .line 145
    :cond_3
    iget v1, p1, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    if-eqz v1, :cond_4

    iget v1, p1, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    .line 146
    :goto_2
    new-array v2, v2, [I

    aput v0, v2, v4

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrKeyLook;->middle(II)I

    move-result v0

    aput v0, v2, v5

    aput v1, v2, v3

    move-object v0, v2

    goto :goto_0

    .line 145
    :cond_4
    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeyLook;->partner(I)I

    move-result v1

    goto :goto_2
.end method

.method static version()I
    .locals 1

    .prologue
    .line 123
    sget v0, Lcom/mrkeyboard/app/MrKeyLook;->sVersion:I

    return v0
.end method


# virtual methods
.method faceTuned()Z
    .locals 2

    .prologue
    const/16 v1, 0x64

    .line 75
    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    if-eq v0, v1, :cond_1

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

    .line 70
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

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method same(Lcom/mrkeyboard/app/MrKeyLook;)Z
    .locals 2

    .prologue
    .line 79
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

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method withEdge(I)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 6

    .prologue
    .line 53
    new-instance v0, Lcom/mrkeyboard/app/MrKeyLook;

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    iget v3, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    iget v4, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    iget v5, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    move v2, p1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIII)V

    return-object v0
.end method

.method withHue(I)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 6

    .prologue
    .line 61
    new-instance v0, Lcom/mrkeyboard/app/MrKeyLook;

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    iget v3, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    iget v5, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    move v4, p1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIII)V

    return-object v0
.end method

.method withHue2(I)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 6

    .prologue
    .line 65
    new-instance v0, Lcom/mrkeyboard/app/MrKeyLook;

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    iget v3, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    iget v4, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    move v5, p1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIII)V

    return-object v0
.end method

.method withKey(I)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 6

    .prologue
    .line 49
    new-instance v0, Lcom/mrkeyboard/app/MrKeyLook;

    iget v2, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    iget v3, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    iget v4, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    iget v5, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    move v1, p1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIII)V

    return-object v0
.end method

.method withText(I)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 6

    .prologue
    .line 57
    new-instance v0, Lcom/mrkeyboard/app/MrKeyLook;

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    iget v4, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    iget v5, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    move v3, p1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIII)V

    return-object v0
.end method

.method write(Landroid/content/SharedPreferences$Editor;)V
    .locals 2

    .prologue
    .line 99
    const-string v0, "pref_kbd_look_key"

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 100
    const-string v0, "pref_kbd_look_edge"

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 101
    const-string v0, "pref_kbd_look_text"

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 102
    const-string v0, "pref_kbd_look_hue"

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 103
    const-string v0, "pref_kbd_look_hue2"

    iget v1, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 104
    return-void
.end method
