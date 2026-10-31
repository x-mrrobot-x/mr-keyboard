.class public final Lcom/mrkeyboard/app/KeyStyle;
.super Ljava/lang/Object;
.source "KeyStyle.java"


# static fields
.field private static final PREF_LAYOUT:Ljava/lang/String; = "pref_keyboard_layout"

.field private static final PREF_RADIUS:Ljava/lang/String; = "pref_key_radius"

.field private static final PREF_SPACING:Ljava/lang/String; = "pref_key_spacing"

.field private static volatile sLoaded:Z

.field private static volatile sMode:I

.field private static final sPrefListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

.field private static volatile sRadiusDp:F

.field private static volatile sRegisteredPrefs:Landroid/content/SharedPreferences;

.field private static volatile sSpacingDp:F


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 15
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/KeyStyle;->sLoaded:Z

    .line 16
    const/4 v0, 0x2

    sput v0, Lcom/mrkeyboard/app/KeyStyle;->sMode:I

    .line 17
    const/high16 v0, 0x41000000    # 8.0f

    sput v0, Lcom/mrkeyboard/app/KeyStyle;->sRadiusDp:F

    .line 18
    const/high16 v0, 0x40800000    # 4.0f

    sput v0, Lcom/mrkeyboard/app/KeyStyle;->sSpacingDp:F

    .line 19
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/KeyStyle;->sRegisteredPrefs:Landroid/content/SharedPreferences;

    .line 21
    new-instance v0, Lcom/mrkeyboard/app/KeyStyle$1;

    invoke-direct {v0}, Lcom/mrkeyboard/app/KeyStyle$1;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/KeyStyle;->sPrefListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$002(Z)Z
    .registers 1

    .line 10
    sput-boolean p0, Lcom/mrkeyboard/app/KeyStyle;->sLoaded:Z

    return p0
.end method

.method private static ensureLoaded(Landroid/content/Context;)V
    .registers 5

    .line 38
    sget-boolean v0, Lcom/mrkeyboard/app/KeyStyle;->sLoaded:Z

    if-eqz v0, :cond_5

    .line 39
    return-void

    .line 41
    :cond_5
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object p0

    .line 42
    sget-object v0, Lcom/mrkeyboard/app/KeyStyle;->sRegisteredPrefs:Landroid/content/SharedPreferences;

    if-eq v0, p0, :cond_2b

    .line 43
    const-class v0, Lcom/mrkeyboard/app/KeyStyle;

    monitor-enter v0

    .line 44
    :try_start_10
    sget-object v1, Lcom/mrkeyboard/app/KeyStyle;->sRegisteredPrefs:Landroid/content/SharedPreferences;

    if-eq v1, p0, :cond_26

    .line 45
    sget-object v1, Lcom/mrkeyboard/app/KeyStyle;->sRegisteredPrefs:Landroid/content/SharedPreferences;

    if-eqz v1, :cond_1f

    .line 46
    sget-object v1, Lcom/mrkeyboard/app/KeyStyle;->sRegisteredPrefs:Landroid/content/SharedPreferences;

    sget-object v2, Lcom/mrkeyboard/app/KeyStyle;->sPrefListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v1, v2}, Landroid/content/SharedPreferences;->unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 48
    :cond_1f
    sget-object v1, Lcom/mrkeyboard/app/KeyStyle;->sPrefListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {p0, v1}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 49
    sput-object p0, Lcom/mrkeyboard/app/KeyStyle;->sRegisteredPrefs:Landroid/content/SharedPreferences;

    .line 51
    :cond_26
    monitor-exit v0

    goto :goto_2b

    :catchall_28
    move-exception p0

    monitor-exit v0
    :try_end_2a
    .catchall {:try_start_10 .. :try_end_2a} :catchall_28

    throw p0

    .line 53
    :cond_2b
    :goto_2b
    const-string v0, "pref_keyboard_layout"

    const-string v1, "8"

    invoke-interface {p0, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 54
    nop

    .line 55
    const-string v1, "7"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x1

    if-eqz v1, :cond_3f

    .line 56
    move v0, v2

    goto :goto_4a

    .line 57
    :cond_3f
    const-string v1, "8"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_49

    .line 58
    const/4 v0, 0x2

    goto :goto_4a

    .line 57
    :cond_49
    # v1.69: todos os temas que sobraram (Neon, Dark Tech suave e relevo, Midnight Steel) são de forma
    # e aceitam espaçamento e arredondamento; qualquer valor antigo guardado cai no modo relevo.
    const/4 v0, 0x2

    .line 60
    :goto_4a
    sput v0, Lcom/mrkeyboard/app/KeyStyle;->sMode:I

    .line 61
    const-string v0, "pref_key_radius"

    const-string v1, "8"

    const/high16 v3, 0x41000000    # 8.0f

    invoke-static {p0, v0, v1, v3}, Lcom/mrkeyboard/app/KeyStyle;->readFloat(Landroid/content/SharedPreferences;Ljava/lang/String;Ljava/lang/String;F)F

    move-result v0

    sput v0, Lcom/mrkeyboard/app/KeyStyle;->sRadiusDp:F

    .line 62
    const-string v0, "pref_key_spacing"

    const-string v1, "4"

    const/high16 v3, 0x40800000    # 4.0f

    invoke-static {p0, v0, v1, v3}, Lcom/mrkeyboard/app/KeyStyle;->readFloat(Landroid/content/SharedPreferences;Ljava/lang/String;Ljava/lang/String;F)F

    move-result p0

    sput p0, Lcom/mrkeyboard/app/KeyStyle;->sSpacingDp:F

    .line 63
    sput-boolean v2, Lcom/mrkeyboard/app/KeyStyle;->sLoaded:Z

    .line 64
    return-void
.end method

.method public static isDarkTech(Landroid/content/Context;)Z
    .registers 1

    .line 75
    invoke-static {p0}, Lcom/mrkeyboard/app/KeyStyle;->ensureLoaded(Landroid/content/Context;)V

    .line 76
    sget p0, Lcom/mrkeyboard/app/KeyStyle;->sMode:I

    if-eqz p0, :cond_9

    const/4 p0, 0x1

    goto :goto_a

    :cond_9
    const/4 p0, 0x0

    :goto_a
    return p0
.end method

.method public static onPrefChanged(Ljava/lang/String;)V
    .registers 3

    .line 80
    const/4 v0, 0x0

    if-nez p0, :cond_6

    .line 81
    sput-boolean v0, Lcom/mrkeyboard/app/KeyStyle;->sLoaded:Z

    .line 82
    return-void

    .line 84
    :cond_6
    const-string v1, "pref_keyboard_layout"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_11

    .line 85
    sput-boolean v0, Lcom/mrkeyboard/app/KeyStyle;->sLoaded:Z

    .line 86
    return-void

    .line 88
    :cond_11
    const-string v1, "pref_key_spacing"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_21

    const-string v1, "pref_key_radius"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_32

    .line 89
    :cond_21
    sput-boolean v0, Lcom/mrkeyboard/app/KeyStyle;->sLoaded:Z

    .line 90
    invoke-static {}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInstance()Lcom/mrkeyboard/app/KeyboardSwitcher;

    move-result-object p0

    .line 91
    if-eqz p0, :cond_32

    .line 92
    invoke-virtual {p0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInputView()Lcom/mrkeyboard/app/LatinKeyboardView;

    move-result-object p0

    .line 93
    if-eqz p0, :cond_32

    .line 94
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardView;->invalidateAllKeys()V

    .line 98
    :cond_32
    return-void
.end method

.method public static prepare(Landroid/graphics/drawable/Drawable;IILandroid/content/Context;)V
    .registers 12

    .line 101
    invoke-static {p3}, Lcom/mrkeyboard/app/KeyStyle;->ensureLoaded(Landroid/content/Context;)V

    .line 102
    sget v0, Lcom/mrkeyboard/app/KeyStyle;->sMode:I

    .line 103
    if-nez v0, :cond_8

    .line 104
    return-void

    .line 106
    :cond_8
    const/4 v1, 0x0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_d

    goto :goto_e

    :cond_d
    move v2, v1

    .line 107
    :goto_e
    invoke-virtual {p3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p3

    invoke-virtual {p3}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p3

    iget p3, p3, Landroid/util/DisplayMetrics;->density:F

    .line 108
    sget v0, Lcom/mrkeyboard/app/KeyStyle;->sRadiusDp:F

    mul-float/2addr v0, p3

    .line 109
    sget v3, Lcom/mrkeyboard/app/KeyStyle;->sSpacingDp:F

    mul-float/2addr v3, p3

    const/high16 v4, 0x3f000000    # 0.5f

    mul-float/2addr v3, v4

    float-to-int v3, v3

    .line 110
    const/high16 v4, 0x40000000    # 2.0f

    mul-float/2addr p3, v4

    .line 112
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getCurrent()Landroid/graphics/drawable/Drawable;

    move-result-object v4

    .line 113
    instance-of v5, v4, Landroid/graphics/drawable/LayerDrawable;

    if-eqz v5, :cond_4e

    .line 114
    check-cast v4, Landroid/graphics/drawable/LayerDrawable;

    .line 115
    invoke-virtual {v4}, Landroid/graphics/drawable/LayerDrawable;->getNumberOfLayers()I

    move-result v5

    .line 116
    nop

    :goto_34
    if-ge v1, v5, :cond_4e

    .line 117
    invoke-virtual {v4, v1}, Landroid/graphics/drawable/LayerDrawable;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v6

    .line 118
    instance-of v7, v6, Landroid/graphics/drawable/GradientDrawable;

    if-eqz v7, :cond_4b

    .line 119
    if-nez v1, :cond_45

    if-eqz v2, :cond_45

    add-float v7, v0, p3

    goto :goto_46

    :cond_45
    move v7, v0

    .line 120
    :goto_46
    check-cast v6, Landroid/graphics/drawable/GradientDrawable;

    invoke-virtual {v6, v7}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 116
    :cond_4b
    add-int/lit8 v1, v1, 0x1

    goto :goto_34

    .line 125
    :cond_4e
    mul-int/lit8 p3, v3, 0x2

    .line 126
    if-le p1, p3, :cond_59

    if-le p2, p3, :cond_59

    .line 127
    sub-int/2addr p1, v3

    sub-int/2addr p2, v3

    invoke-virtual {p0, v3, v3, p1, p2}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 129
    :cond_59
    return-void
.end method

.method private static readFloat(Landroid/content/SharedPreferences;Ljava/lang/String;Ljava/lang/String;F)F
    .registers 4

    .line 68
    :try_start_0
    invoke-interface {p0, p1, p2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result p0
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_8} :catch_9

    return p0

    .line 69
    :catch_9
    move-exception p0

    .line 70
    return p3
.end method
