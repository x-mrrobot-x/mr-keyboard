.class public final Lcom/mrkeyboard/app/KeyStyle;
.super Ljava/lang/Object;
.source "KeyStyle.java"

# static fields
.field private static final PREF_RADIUS:Ljava/lang/String; = "pref_key_radius"

.field private static final PREF_SPACING:Ljava/lang/String; = "pref_key_spacing"

.field private static volatile sLoaded:Z

.field private static final sPrefListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

.field private static volatile sRadiusDirty:Z

.field private static volatile sRadiusDp:F

.field private static volatile sRegisteredPrefs:Landroid/content/SharedPreferences;

.field private static volatile sSpacingDp:F

# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 15
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/KeyStyle;->sLoaded:Z

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
    const/4 v2, 0x1

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
    const-string v1, "pref_key_radius"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_mr_nodirty

    const/4 v1, 0x1

    sput-boolean v1, Lcom/mrkeyboard/app/KeyStyle;->sRadiusDirty:Z

    :cond_mr_nodirty
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

    .line 106
    const/4 v1, 0x0

    .line 107
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
    invoke-static {v4, v1}, Lcom/mrkeyboard/app/KeyStyle;->layerGap(Landroid/graphics/drawable/LayerDrawable;I)F

    move-result v7

    add-float/2addr v7, v0

    .line 120
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
    const/4 v5, 0x0

    invoke-static {p0, v5}, Lcom/mrkeyboard/app/KeyStyle;->borderInset(Landroid/graphics/drawable/Drawable;I)I

    move-result v0

    sub-int v0, v3, v0

    const/4 v5, 0x1

    invoke-static {p0, v5}, Lcom/mrkeyboard/app/KeyStyle;->borderInset(Landroid/graphics/drawable/Drawable;I)I

    move-result v1

    sub-int v1, v3, v1

    const/4 v5, 0x2

    invoke-static {p0, v5}, Lcom/mrkeyboard/app/KeyStyle;->borderInset(Landroid/graphics/drawable/Drawable;I)I

    move-result v2

    sub-int v6, p1, v3

    add-int/2addr v2, v6

    const/4 v5, 0x3

    invoke-static {p0, v5}, Lcom/mrkeyboard/app/KeyStyle;->borderInset(Landroid/graphics/drawable/Drawable;I)I

    move-result v4

    sub-int v6, p2, v3

    add-int/2addr v4, v6

    invoke-virtual {p0, v0, v1, v2, v4}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 129
    :cond_59
    return-void
.end method

.method private static borderInset(Landroid/graphics/drawable/Drawable;I)I
    .locals 4

    const/4 v0, 0x0

    if-nez p0, :cond_have

    return v0

    :cond_have
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getCurrent()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    instance-of v2, v1, Landroid/graphics/drawable/LayerDrawable;

    if-eqz v2, :cond_none

    check-cast v1, Landroid/graphics/drawable/LayerDrawable;

    invoke-virtual {v1}, Landroid/graphics/drawable/LayerDrawable;->getNumberOfLayers()I

    move-result v2

    if-lez v2, :cond_none

    add-int/lit8 v2, v2, -0x1

    if-eqz p1, :cond_left

    const/4 v3, 0x1

    if-eq p1, v3, :cond_top

    const/4 v3, 0x2

    if-eq p1, v3, :cond_right

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/LayerDrawable;->getLayerInsetBottom(I)I

    move-result v0

    goto :cond_clamp

    :cond_left
    invoke-virtual {v1, v2}, Landroid/graphics/drawable/LayerDrawable;->getLayerInsetLeft(I)I

    move-result v0

    goto :cond_clamp

    :cond_top
    invoke-virtual {v1, v2}, Landroid/graphics/drawable/LayerDrawable;->getLayerInsetTop(I)I

    move-result v0

    goto :cond_clamp

    :cond_right
    invoke-virtual {v1, v2}, Landroid/graphics/drawable/LayerDrawable;->getLayerInsetRight(I)I

    move-result v0

    :cond_clamp
    if-gez v0, :cond_none

    const/4 v0, 0x0

    :cond_none
    return v0
.end method

.method private static hasInset(Landroid/graphics/drawable/Drawable;)Z
    .locals 2

    const/4 v0, 0x0

    :goto_side
    const/4 v1, 0x4

    if-ge v0, v1, :cond_no

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/KeyStyle;->borderInset(Landroid/graphics/drawable/Drawable;I)I

    move-result v1

    if-gtz v1, :cond_yes

    add-int/lit8 v0, v0, 0x1

    goto :goto_side

    :cond_yes
    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method
.method public static layerGap(Landroid/graphics/drawable/LayerDrawable;I)F
    .locals 2

    invoke-virtual {p0}, Landroid/graphics/drawable/LayerDrawable;->getNumberOfLayers()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {p0, v0}, Landroid/graphics/drawable/LayerDrawable;->getLayerInsetLeft(I)I

    move-result v0

    invoke-virtual {p0, p1}, Landroid/graphics/drawable/LayerDrawable;->getLayerInsetLeft(I)I

    move-result v1

    sub-int/2addr v0, v1

    if-gez v0, :cond_0

    const/4 v0, 0x0

    :cond_0
    int-to-float v0, v0

    return v0
.end method

.method public static drawKey(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;II)V
    .locals 2

    invoke-static {p0}, Lcom/mrkeyboard/app/KeyStyle;->hasInset(Landroid/graphics/drawable/Drawable;)Z

    move-result v0

    if-nez v0, :cond_clip

    invoke-virtual {p0, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    return-void

    :cond_clip
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    const/4 v1, 0x0

    invoke-virtual {p1, v1, v1, p2, p3}, Landroid/graphics/Canvas;->clipRect(IIII)Z

    invoke-virtual {p0, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    return-void
.end method

# Corner radius (px) of an element that follows the keys: key radius + p1 slack (dp). The slack
# grows from 0 to the full value as the key radius goes from 0 to 8 dp and then stays fixed: with
# radius 0 the element stays square; at the default radius (8 dp) it is radius + slack; above that it only adds.
.method public static radiusPx(Landroid/content/Context;F)F
    .locals 4

    invoke-static {p0}, Lcom/mrkeyboard/app/KeyStyle;->ensureLoaded(Landroid/content/Context;)V

    sget v0, Lcom/mrkeyboard/app/KeyStyle;->sRadiusDp:F

    const/high16 v1, 0x41000000    # 8.0f

    div-float v2, v0, v1

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-static {v2, v3}, Ljava/lang/Math;->min(FF)F

    move-result v2

    mul-float/2addr v2, p1

    add-float/2addr v0, v2

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr v0, v1

    const/4 v1, 0x0

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    return v0
.end method

# Applies the radius (radiusPx with p2 slack) to the shape layers of drawable p0 (LayerDrawable or single
# shape). A layer inset 1.5 dp or more from the edge uses the radius minus the inset (concentric corners);
# the others use the full radius.
.method public static applyShape(Landroid/graphics/drawable/Drawable;Landroid/content/Context;F)V
    .locals 8

    if-nez p0, :cond_have

    return-void

    :cond_have
    invoke-static {p1, p2}, Lcom/mrkeyboard/app/KeyStyle;->radiusPx(Landroid/content/Context;F)F

    move-result v0

    instance-of v2, p0, Landroid/graphics/drawable/LayerDrawable;

    if-eqz v2, :cond_single

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->density:F

    check-cast p0, Landroid/graphics/drawable/LayerDrawable;

    invoke-virtual {p0}, Landroid/graphics/drawable/LayerDrawable;->getNumberOfLayers()I

    move-result v2

    const/4 v3, 0x0

    const/high16 v4, 0x3fc00000    # 1.5f

    mul-float/2addr v4, v1

    :goto_loop
    if-ge v3, v2, :cond_done

    invoke-virtual {p0, v3}, Landroid/graphics/drawable/LayerDrawable;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    instance-of v6, v5, Landroid/graphics/drawable/GradientDrawable;

    if-eqz v6, :cond_next

    check-cast v5, Landroid/graphics/drawable/GradientDrawable;

    invoke-virtual {p0, v3}, Landroid/graphics/drawable/LayerDrawable;->getLayerInsetLeft(I)I

    move-result v6

    int-to-float v6, v6

    move v7, v0

    cmpg-float v1, v6, v4

    if-ltz v1, :cond_set

    sub-float v7, v0, v6

    const/4 v6, 0x0

    invoke-static {v7, v6}, Ljava/lang/Math;->max(FF)F

    move-result v7

    :cond_set
    invoke-virtual {v5, v7}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    :cond_next
    add-int/lit8 v3, v3, 0x1

    goto :goto_loop

    :cond_single
    instance-of v2, p0, Landroid/graphics/drawable/GradientDrawable;

    if-eqz v2, :cond_done

    check-cast p0, Landroid/graphics/drawable/GradientDrawable;

    invoke-virtual {p0, v0}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    :cond_done
    return-void
.end method

# true only once after the key radius changed (LatinIME rebuilds the view when the keyboard opens).
.method public static takeRadiusDirty()Z
    .locals 2

    sget-boolean v0, Lcom/mrkeyboard/app/KeyStyle;->sRadiusDirty:Z

    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/KeyStyle;->sRadiusDirty:Z

    return v0
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
