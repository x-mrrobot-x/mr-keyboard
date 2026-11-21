.class final Lcom/mrkeyboard/app/MrAdapt;
.super Ljava/lang/Object;
.source "MrAdapt.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrAdapt$Tone;
    }
.end annotation


# static fields
.field static final ACCENT:F = 0.9f

.field static final FACE:F = 0.85f

.field static final FAINT:F = 0.55f

.field static final GREY:F = 0.12f

.field static final SAT_SHARE:F = 0.65f

.field static final STROKE:F = 0.85f

.field static final TEXT:F = 0.3f

.field static final WHITE_SHARE:F = 0.1f

.field private static sBusy:Z

.field private static volatile sKey:Ljava/lang/String;

.field private static sPopupColour:I

.field private static sPopupFilter:Landroid/graphics/PorterDuffColorFilter;

.field private static volatile sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 68
    sget-object v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static active()Z
    .locals 1

    .prologue
    .line 84
    invoke-static {}, Lcom/mrkeyboard/app/MrAdapt;->tone()Lcom/mrkeyboard/app/MrAdapt$Tone;

    move-result-object v0

    iget-boolean v0, v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->on:Z

    return v0
.end method

.method static adapt(Ljava/lang/String;I)I
    .locals 3

    .prologue
    .line 92
    sget-boolean v0, Lcom/mrkeyboard/app/MrAdapt;->sBusy:Z

    if-eqz v0, :cond_1

    .line 97
    :cond_0
    :goto_0
    return p1

    .line 93
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrAdapt;->tone()Lcom/mrkeyboard/app/MrAdapt$Tone;

    move-result-object v0

    .line 94
    iget-boolean v1, v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->on:Z

    if-eqz v1, :cond_0

    .line 95
    iget-boolean v1, v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->pale:Z

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrAdapt;->share(Ljava/lang/String;Z)F

    move-result v1

    .line 96
    const/4 v2, 0x0

    cmpg-float v2, v1, v2

    if-lez v2, :cond_0

    .line 97
    iget v2, v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->hue:F

    iget v0, v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->sat:F

    invoke-static {p1, v2, v0, v1}, Lcom/mrkeyboard/app/MrAdapt;->retint(IFFF)I

    move-result p1

    goto :goto_0
.end method

.method static bubble(Landroid/graphics/drawable/Drawable;)V
    .locals 3

    .prologue
    .line 213
    if-eqz p0, :cond_0

    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAdapt;->active()Z

    move-result v0

    if-nez v0, :cond_1

    .line 218
    :cond_0
    :goto_0
    return-void

    .line 214
    :cond_1
    const-string v0, "bubble_fill"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    const-string v1, "preview_stroke"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    const-string v2, "preview_dots"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v2

    invoke-static {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrAdapt;->paint(Landroid/graphics/drawable/Drawable;III)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 215
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static compute(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/MrAdapt$Tone;
    .locals 7

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 173
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->lookNow(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Look;

    move-result-object v3

    .line 174
    if-nez v3, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;

    .line 180
    :goto_0
    return-object v0

    .line 175
    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->darkNow(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_4

    move v0, v1

    .line 176
    :goto_1
    const/4 v4, 0x3

    new-array v4, v4, [F

    .line 177
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrAdapt;->keyColour(Landroid/content/Context;Ljava/lang/String;)I

    move-result v5

    .line 178
    if-eqz v5, :cond_1

    invoke-static {v5, v4}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 179
    :cond_1
    if-eqz v5, :cond_2

    aget v5, v4, v1

    const v6, 0x3df5c28f    # 0.12f

    cmpg-float v5, v5, v6

    if-gez v5, :cond_3

    :cond_2
    iget v3, v3, Lcom/mrkeyboard/app/MrBackdrop$Look;->bottom:I

    invoke-static {v3, v4}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 180
    :cond_3
    new-instance v3, Lcom/mrkeyboard/app/MrAdapt$Tone;

    aget v2, v4, v2

    const/high16 v5, 0x3f800000    # 1.0f

    aget v4, v4, v1

    invoke-static {v5, v4}, Ljava/lang/Math;->min(FF)F

    move-result v4

    const v5, 0x3f266666    # 0.65f

    mul-float/2addr v4, v5

    invoke-direct {v3, v2, v4, v0, v1}, Lcom/mrkeyboard/app/MrAdapt$Tone;-><init>(FFZZ)V

    move-object v0, v3

    goto :goto_0

    :cond_4
    move v0, v2

    .line 175
    goto :goto_1
.end method

.method private static fillAndLine(Landroid/graphics/drawable/GradientDrawable;II)V
    .locals 2

    .prologue
    .line 240
    invoke-virtual {p0, p1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 241
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    .line 242
    if-nez v0, :cond_0

    const/high16 v0, 0x3f800000    # 1.0f

    .line 243
    :goto_0
    const/4 v1, 0x1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-virtual {p0, v0, p2}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 244
    return-void

    .line 242
    :cond_0
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    goto :goto_0
.end method

.method static keyColour(Landroid/content/Context;Ljava/lang/String;)I
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v0, 0x0

    .line 185
    invoke-static {p1}, Lcom/mrkeyboard/app/MrBackdrop;->isOwn(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 186
    invoke-static {p0}, Lcom/mrkeyboard/app/MrKeyLook;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v1

    invoke-static {p1, v1}, Lcom/mrkeyboard/app/MrKeyLook;->spectrum(Ljava/lang/String;Lcom/mrkeyboard/app/MrKeyLook;)[I

    move-result-object v1

    .line 187
    if-nez v1, :cond_1

    .line 192
    :cond_0
    :goto_0
    return v0

    .line 187
    :cond_1
    aget v0, v1, v3

    goto :goto_0

    .line 189
    :cond_2
    invoke-static {p1}, Lcom/mrkeyboard/app/MrBackdrop;->styleOf(Ljava/lang/String;)I

    move-result v1

    .line 190
    if-lez v1, :cond_0

    const/16 v2, 0xf

    if-ge v1, v2, :cond_0

    .line 191
    sget-object v2, Lcom/mrkeyboard/app/MrBackdrop;->STYLE_COLORS:[[I

    aget-object v1, v2, v1

    .line 192
    array-length v2, v1

    if-le v2, v3, :cond_3

    aget v0, v1, v3

    goto :goto_0

    :cond_3
    aget v0, v1, v0

    goto :goto_0
.end method

.method private static keyOf(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 158
    const-string v1, ""

    .line 161
    :try_start_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 162
    if-eqz v2, :cond_0

    .line 163
    const-string v3, "pref_kbd_bg"

    const-string v4, ""

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 164
    const-string v3, "pref_kbd_bg_soft"

    const/4 v4, 0x0

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 169
    :cond_0
    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "|"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Lcom/mrkeyboard/app/MrKeyLook;->version()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "|"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "|"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 166
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method private static paint(Landroid/graphics/drawable/Drawable;III)V
    .locals 5

    .prologue
    const/4 v2, 0x0

    .line 222
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 223
    instance-of v1, v0, Landroid/graphics/drawable/LayerDrawable;

    if-nez v1, :cond_1

    .line 224
    instance-of v1, v0, Landroid/graphics/drawable/GradientDrawable;

    if-eqz v1, :cond_0

    check-cast v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-static {v0, p1, p2}, Lcom/mrkeyboard/app/MrAdapt;->fillAndLine(Landroid/graphics/drawable/GradientDrawable;II)V

    .line 237
    :cond_0
    return-void

    .line 227
    :cond_1
    check-cast v0, Landroid/graphics/drawable/LayerDrawable;

    .line 228
    const/4 v1, -0x1

    move v3, v1

    move v1, v2

    .line 229
    :goto_0
    invoke-virtual {v0}, Landroid/graphics/drawable/LayerDrawable;->getNumberOfLayers()I

    move-result v4

    if-ge v1, v4, :cond_3

    .line 230
    invoke-virtual {v0, v1}, Landroid/graphics/drawable/LayerDrawable;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v4

    instance-of v4, v4, Landroid/graphics/drawable/GradientDrawable;

    if-eqz v4, :cond_2

    move v3, v1

    .line 229
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 232
    :cond_3
    :goto_1
    invoke-virtual {v0}, Landroid/graphics/drawable/LayerDrawable;->getNumberOfLayers()I

    move-result v1

    if-ge v2, v1, :cond_0

    .line 233
    invoke-virtual {v0, v2}, Landroid/graphics/drawable/LayerDrawable;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    .line 234
    if-ne v2, v3, :cond_5

    check-cast v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-static {v1, p1, p2}, Lcom/mrkeyboard/app/MrAdapt;->fillAndLine(Landroid/graphics/drawable/GradientDrawable;II)V

    .line 232
    :cond_4
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 235
    :cond_5
    if-eqz p3, :cond_4

    instance-of v4, v1, Landroid/graphics/drawable/GradientDrawable;

    if-nez v4, :cond_4

    if-le v2, v3, :cond_4

    if-ltz v3, :cond_4

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v1, p3}, Landroid/graphics/drawable/Drawable;->setTint(I)V

    goto :goto_2
.end method

.method static popup(Landroid/graphics/drawable/Drawable;)V
    .locals 3

    .prologue
    .line 203
    if-eqz p0, :cond_0

    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAdapt;->active()Z

    move-result v0

    if-nez v0, :cond_1

    .line 208
    :cond_0
    :goto_0
    return-void

    .line 204
    :cond_1
    const-string v0, "bubble_fill"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    const-string v1, "bubble_stroke"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    const/4 v2, 0x0

    invoke-static {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrAdapt;->paint(Landroid/graphics/drawable/Drawable;III)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 205
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static declared-synchronized popupFilter()Landroid/graphics/PorterDuffColorFilter;
    .locals 4

    .prologue
    .line 251
    const-class v1, Lcom/mrkeyboard/app/MrAdapt;

    monitor-enter v1

    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAdapt;->active()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 257
    :goto_0
    monitor-exit v1

    return-object v0

    .line 252
    :cond_0
    :try_start_1
    const-string v0, "popup_key_fill"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    .line 253
    sget-object v2, Lcom/mrkeyboard/app/MrAdapt;->sPopupFilter:Landroid/graphics/PorterDuffColorFilter;

    if-eqz v2, :cond_1

    sget v2, Lcom/mrkeyboard/app/MrAdapt;->sPopupColour:I

    if-eq v2, v0, :cond_2

    .line 254
    :cond_1
    new-instance v2, Landroid/graphics/PorterDuffColorFilter;

    sget-object v3, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v2, v0, v3}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V

    sput-object v2, Lcom/mrkeyboard/app/MrAdapt;->sPopupFilter:Landroid/graphics/PorterDuffColorFilter;

    .line 255
    sput v0, Lcom/mrkeyboard/app/MrAdapt;->sPopupColour:I

    .line 257
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrAdapt;->sPopupFilter:Landroid/graphics/PorterDuffColorFilter;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 251
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static declared-synchronized reset()V
    .locals 2

    .prologue
    .line 77
    const-class v1, Lcom/mrkeyboard/app/MrAdapt;

    monitor-enter v1

    const/4 v0, 0x0

    :try_start_0
    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sKey:Ljava/lang/String;

    .line 78
    sget-object v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    .line 79
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sPopupFilter:Landroid/graphics/PorterDuffColorFilter;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 80
    monitor-exit v1

    return-void

    .line 77
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static retint(IFFF)I
    .locals 10

    .prologue
    const/4 v0, 0x0

    const/high16 v8, -0x1000000

    const/high16 v7, 0x40000000    # 2.0f

    const/4 v2, 0x0

    const/high16 v3, 0x3f800000    # 1.0f

    .line 105
    const/4 v1, 0x3

    new-array v1, v1, [F

    .line 106
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 107
    const/4 v4, 0x1

    aget v4, v1, v4

    const/4 v5, 0x1

    aget v1, v1, v5

    sub-float v1, p2, v1

    mul-float/2addr v1, p3

    add-float/2addr v4, v1

    .line 108
    or-int v1, v8, p0

    invoke-static {v1}, Lcom/mrkeyboard/app/MrThemeColors;->luminance(I)F

    move-result v5

    .line 110
    invoke-static {p1, v4, v3}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrThemeColors;->luminance(I)F

    move-result v1

    cmpg-float v1, v1, v5

    if-gez v1, :cond_2

    move v1, v4

    move v4, v0

    .line 113
    :goto_0
    const/16 v0, 0xe

    if-ge v4, v0, :cond_1

    .line 114
    add-float v0, v2, v1

    div-float/2addr v0, v7

    .line 115
    invoke-static {p1, v0, v3}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v6

    invoke-static {v6}, Lcom/mrkeyboard/app/MrThemeColors;->luminance(I)F

    move-result v6

    cmpg-float v6, v6, v5

    if-gez v6, :cond_0

    move v1, v2

    .line 113
    :goto_1
    add-int/lit8 v2, v4, 0x1

    move v4, v2

    move v2, v1

    move v1, v0

    goto :goto_0

    :cond_0
    move v9, v1

    move v1, v0

    move v0, v9

    .line 116
    goto :goto_1

    .line 118
    :cond_1
    invoke-static {p1, v2, v3}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v0

    .line 128
    :goto_2
    and-int v1, p0, v8

    const v2, 0xffffff

    and-int/2addr v0, v2

    or-int/2addr v0, v1

    return v0

    :cond_2
    move v9, v0

    move v0, v3

    move v3, v9

    .line 121
    :goto_3
    const/16 v1, 0xe

    if-ge v3, v1, :cond_4

    .line 122
    add-float v1, v2, v0

    div-float/2addr v1, v7

    .line 123
    invoke-static {p1, v4, v1}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v6

    invoke-static {v6}, Lcom/mrkeyboard/app/MrThemeColors;->luminance(I)F

    move-result v6

    cmpg-float v6, v6, v5

    if-gez v6, :cond_3

    .line 121
    :goto_4
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    move v2, v1

    goto :goto_3

    :cond_3
    move v0, v1

    move v1, v2

    .line 124
    goto :goto_4

    .line 126
    :cond_4
    invoke-static {p1, v4, v0}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v0

    goto :goto_2
.end method

.method private static share(Ljava/lang/String;Z)F
    .locals 5

    .prologue
    const v2, 0x3f666666    # 0.9f

    const v1, 0x3f59999a    # 0.85f

    const/4 v0, 0x0

    .line 41
    if-nez p0, :cond_0

    .line 50
    :goto_0
    return v0

    .line 42
    :cond_0
    const/4 v3, -0x1

    invoke-virtual {p0}, Ljava/lang/String;->hashCode()I

    move-result v4

    sparse-switch v4, :sswitch_data_0

    :cond_1
    :goto_1
    packed-switch v3, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    move v0, v1

    .line 43
    goto :goto_0

    .line 42
    :sswitch_0
    const-string v4, "panel_btn"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/4 v3, 0x0

    goto :goto_1

    :sswitch_1
    const-string v4, "sel_cancel"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/4 v3, 0x1

    goto :goto_1

    :sswitch_2
    const-string v4, "sel_card"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/4 v3, 0x2

    goto :goto_1

    :sswitch_3
    const-string v4, "sel_cancel_stroke"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/4 v3, 0x3

    goto :goto_1

    :sswitch_4
    const-string v4, "sel_send"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/4 v3, 0x4

    goto :goto_1

    :sswitch_5
    const-string v4, "sel_send_stroke"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/4 v3, 0x5

    goto :goto_1

    :sswitch_6
    const-string v4, "sel_media"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/4 v3, 0x6

    goto :goto_1

    :sswitch_7
    const-string v4, "tool_tint"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/4 v3, 0x7

    goto :goto_1

    :sswitch_8
    const-string v4, "attach_fab"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/16 v3, 0x8

    goto :goto_1

    :sswitch_9
    const-string v4, "attach_fab_stroke"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/16 v3, 0x9

    goto :goto_1

    :sswitch_a
    const-string v4, "ctrl_bg"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/16 v3, 0xa

    goto :goto_1

    :sswitch_b
    const-string v4, "panel_tab_off_text"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/16 v3, 0xb

    goto/16 :goto_1

    :sswitch_c
    const-string v4, "bubble_fill"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/16 v3, 0xc

    goto/16 :goto_1

    :sswitch_d
    const-string v4, "bubble_stroke"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/16 v3, 0xd

    goto/16 :goto_1

    :sswitch_e
    const-string v4, "popup_key_fill"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/16 v3, 0xe

    goto/16 :goto_1

    :sswitch_f
    const-string v4, "preview_stroke"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/16 v3, 0xf

    goto/16 :goto_1

    :sswitch_10
    const-string v4, "preview_dots"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/16 v3, 0x10

    goto/16 :goto_1

    :pswitch_1
    move v0, v1

    .line 44
    goto/16 :goto_0

    :pswitch_2
    move v0, v2

    .line 45
    goto/16 :goto_0

    .line 46
    :pswitch_3
    const v0, 0x3f0ccccd    # 0.55f

    goto/16 :goto_0

    .line 47
    :pswitch_4
    const v0, 0x3e99999a    # 0.3f

    goto/16 :goto_0

    .line 48
    :pswitch_5
    if-eqz p1, :cond_2

    const v0, 0x3dcccccd    # 0.1f

    goto/16 :goto_0

    :cond_2
    const/high16 v0, 0x3f400000    # 0.75f

    goto/16 :goto_0

    :pswitch_6
    move v0, v2

    .line 49
    goto/16 :goto_0

    .line 42
    nop

    :sswitch_data_0
    .sparse-switch
        -0x750f01f3 -> :sswitch_8
        -0x6ffe9c41 -> :sswitch_6
        -0x5857ea5f -> :sswitch_0
        -0x568b0a6a -> :sswitch_e
        -0x513fe99f -> :sswitch_10
        -0x18cb1ebe -> :sswitch_7
        -0x12630196 -> :sswitch_5
        -0xdab23e -> :sswitch_b
        0x18f23e8f -> :sswitch_f
        0x2e67f156 -> :sswitch_c
        0x41741299 -> :sswitch_a
        0x46b11fd5 -> :sswitch_2
        0x46b8744d -> :sswitch_4
        0x4afdc94b -> :sswitch_d
        0x4ca4d078 -> :sswitch_3
        0x5ee6b5ff -> :sswitch_1
        0x6449fcaa -> :sswitch_9
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_3
        :pswitch_3
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_6
        :pswitch_6
        :pswitch_6
    .end packed-switch
.end method

.method private static tone()Lcom/mrkeyboard/app/MrAdapt$Tone;
    .locals 5

    .prologue
    .line 134
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    .line 135
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->tag()Ljava/lang/String;

    move-result-object v1

    .line 136
    if-eqz v0, :cond_0

    invoke-static {v1}, Lcom/mrkeyboard/app/MrThemeColors;->hidden(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;

    .line 152
    :goto_0
    return-object v0

    .line 137
    :cond_1
    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAdapt;->keyOf(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 138
    if-eqz v2, :cond_2

    sget-object v3, Lcom/mrkeyboard/app/MrAdapt;->sKey:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrAdapt;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    goto :goto_0

    .line 139
    :cond_2
    const-class v3, Lcom/mrkeyboard/app/MrAdapt;

    monitor-enter v3

    .line 140
    if-eqz v2, :cond_3

    :try_start_0
    sget-object v4, Lcom/mrkeyboard/app/MrAdapt;->sKey:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    sget-object v0, Lcom/mrkeyboard/app/MrAdapt;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    monitor-exit v3

    goto :goto_0

    .line 153
    :catchall_0
    move-exception v0

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 141
    :cond_3
    const/4 v4, 0x1

    :try_start_1
    sput-boolean v4, Lcom/mrkeyboard/app/MrAdapt;->sBusy:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 143
    :try_start_2
    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAdapt;->compute(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/MrAdapt$Tone;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    .line 144
    sput-object v2, Lcom/mrkeyboard/app/MrAdapt;->sKey:Ljava/lang/String;

    .line 145
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sPopupFilter:Landroid/graphics/PorterDuffColorFilter;
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 150
    const/4 v0, 0x0

    :try_start_3
    sput-boolean v0, Lcom/mrkeyboard/app/MrAdapt;->sBusy:Z

    .line 152
    :goto_1
    sget-object v0, Lcom/mrkeyboard/app/MrAdapt;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    monitor-exit v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    .line 146
    :catch_0
    move-exception v0

    .line 147
    :try_start_4
    sget-object v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    .line 148
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sKey:Ljava/lang/String;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 150
    const/4 v0, 0x0

    :try_start_5
    sput-boolean v0, Lcom/mrkeyboard/app/MrAdapt;->sBusy:Z

    goto :goto_1

    :catchall_1
    move-exception v0

    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrAdapt;->sBusy:Z

    .line 151
    throw v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0
.end method
