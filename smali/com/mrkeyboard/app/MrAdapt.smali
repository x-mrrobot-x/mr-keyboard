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

.field static final INK_DARK:F = 0.65f

.field static final INK_DARK_MIN:F = 0.16f

.field static final INK_LIGHT:F = 0.22f

.field static final INK_NEUTRAL:F = 0.14f

.field static final RIM:F = 0.28f

.field static final SAT_SHARE:F = 0.65f

.field static final SEE_TINT:F = 0.3f

.field static final STROKE:F = 0.85f

.field static final TEXT:F = 0.3f

.field static final WHITE_SHARE:F = 0.1f

.field private static sBusy:Z

.field private static sFaces:[I

.field private static volatile sKey:Ljava/lang/String;

.field private static sPopupColour:I

.field private static sPopupFilter:Landroid/graphics/PorterDuffColorFilter;

.field private static volatile sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 189
    sget-object v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 38
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAdapt;->isInk(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$100(Ljava/lang/String;Z)F
    .locals 1

    .prologue
    .line 38
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrAdapt;->share(Ljava/lang/String;Z)F

    move-result v0

    return v0
.end method

.method static active()Z
    .locals 1

    .prologue
    .line 208
    invoke-static {}, Lcom/mrkeyboard/app/MrAdapt;->tone()Lcom/mrkeyboard/app/MrAdapt$Tone;

    move-result-object v0

    iget-boolean v0, v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->on:Z

    return v0
.end method

.method static adapt(Ljava/lang/String;I)I
    .locals 1

    .prologue
    .line 221
    sget-boolean v0, Lcom/mrkeyboard/app/MrAdapt;->sBusy:Z

    if-eqz v0, :cond_0

    .line 222
    :goto_0
    return p1

    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAdapt;->tone()Lcom/mrkeyboard/app/MrAdapt$Tone;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/mrkeyboard/app/MrAdapt$Tone;->adapt(Ljava/lang/String;I)I

    move-result p1

    goto :goto_0
.end method

.method static base(III)I
    .locals 4

    .prologue
    const/4 v3, 0x1

    const v2, 0x3df5c28f    # 0.12f

    .line 311
    const/4 v0, 0x3

    new-array v0, v0, [F

    .line 312
    if-eqz p0, :cond_0

    .line 313
    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 314
    aget v1, v0, v3

    cmpl-float v1, v1, v2

    if-ltz v1, :cond_0

    .line 320
    :goto_0
    return p0

    .line 316
    :cond_0
    if-eqz p1, :cond_1

    .line 317
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 318
    aget v0, v0, v3

    cmpl-float v0, v0, v2

    if-ltz v0, :cond_1

    move p0, p1

    goto :goto_0

    :cond_1
    move p0, p2

    .line 320
    goto :goto_0
.end method

.method static bubble(Landroid/graphics/drawable/Drawable;)V
    .locals 3

    .prologue
    .line 413
    if-eqz p0, :cond_0

    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAdapt;->active()Z

    move-result v0

    if-nez v0, :cond_1

    .line 420
    :cond_0
    :goto_0
    return-void

    .line 414
    :cond_1
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAdapt;->faceNow(Z)[I

    move-result-object v0

    .line 415
    if-eqz v0, :cond_2

    const/4 v1, 0x0

    aget v1, v0, v1

    const/4 v2, 0x1

    aget v0, v0, v2

    const-string v2, "hint"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v2

    invoke-static {p0, v1, v0, v2}, Lcom/mrkeyboard/app/MrAdapt;->paint(Landroid/graphics/drawable/Drawable;III)V

    goto :goto_0

    .line 417
    :catch_0
    move-exception v0

    goto :goto_0

    .line 416
    :cond_2
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
.end method

.method private static compute(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/MrAdapt$Tone;
    .locals 5

    .prologue
    .line 299
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->lookNow(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Look;

    move-result-object v1

    .line 300
    if-nez v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;

    .line 303
    :goto_0
    return-object v0

    .line 301
    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->darkNow(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x1

    .line 302
    :goto_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrKeyLook;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v2

    invoke-static {p1, v2}, Lcom/mrkeyboard/app/MrAdapt;->keyColour(Ljava/lang/String;Lcom/mrkeyboard/app/MrKeyLook;)I

    move-result v2

    .line 303
    iget v3, v1, Lcom/mrkeyboard/app/MrBackdrop$Look;->accent:I

    iget v4, v1, Lcom/mrkeyboard/app/MrBackdrop$Look;->bottom:I

    invoke-static {v2, v3, v4}, Lcom/mrkeyboard/app/MrAdapt;->base(III)I

    move-result v2

    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->spectrum()Z

    move-result v3

    const-string v4, "mr_overlight"

    invoke-virtual {v4, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    iget v1, v1, Lcom/mrkeyboard/app/MrBackdrop$Look;->bottom:I

    invoke-static {v2, v0, v3, v4, v1}, Lcom/mrkeyboard/app/MrAdapt$Tone;->of(IZZZI)Lcom/mrkeyboard/app/MrAdapt$Tone;

    move-result-object v0

    goto :goto_0

    .line 301
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method static current()Lcom/mrkeyboard/app/MrAdapt$Tone;
    .locals 1

    .prologue
    .line 213
    invoke-static {}, Lcom/mrkeyboard/app/MrAdapt;->tone()Lcom/mrkeyboard/app/MrAdapt$Tone;

    move-result-object v0

    return-object v0
.end method

.method static face(Landroid/content/Context;Ljava/lang/String;Lcom/mrkeyboard/app/MrKeyLook;IZ)[I
    .locals 7

    .prologue
    const/4 v3, 0x0

    const/4 v6, 0x1

    const/high16 v5, 0x42c80000    # 100.0f

    const/4 v1, 0x0

    .line 349
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    ushr-int/lit8 v0, p3, 0x18

    if-nez v0, :cond_1

    :cond_0
    move-object v0, v3

    .line 366
    :goto_0
    return-object v0

    .line 350
    :cond_1
    if-eqz p4, :cond_2

    const-string v0, "pressed"

    .line 351
    :goto_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "key_"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "_fill"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {p0, p1, v2}, Lcom/mrkeyboard/app/MrThemeColors;->own(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 352
    if-nez v2, :cond_3

    move-object v0, v3

    goto :goto_0

    .line 350
    :cond_2
    const-string v0, "normal"

    goto :goto_1

    .line 353
    :cond_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "key_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "_edge"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/mrkeyboard/app/MrThemeColors;->own(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 354
    invoke-static {p1, p2}, Lcom/mrkeyboard/app/MrKeyLook;->spectrum(Ljava/lang/String;Lcom/mrkeyboard/app/MrKeyLook;)[I

    move-result-object v3

    .line 355
    if-eqz v3, :cond_6

    aget v3, v3, v6

    .line 356
    :goto_2
    if-eqz v3, :cond_4

    .line 357
    const-string v4, "glow"

    invoke-static {p0, p1, v4}, Lcom/mrkeyboard/app/MrThemeColors;->own(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    invoke-static {v4, v3}, Lcom/mrkeyboard/app/MrGlow;->remap(II)[F

    move-result-object v3

    .line 358
    invoke-static {v3, v2}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v2

    .line 359
    if-nez v0, :cond_7

    move v0, v1

    .line 361
    :cond_4
    :goto_3
    iget v3, p2, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    int-to-float v3, v3

    div-float/2addr v3, v5

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrGlow;->scale(IF)I

    move-result v2

    .line 362
    if-nez v0, :cond_8

    move v0, v1

    .line 363
    :goto_4
    iget v3, p2, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    if-eqz v3, :cond_5

    iget v0, p2, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    invoke-virtual {p2}, Lcom/mrkeyboard/app/MrKeyLook;->lineAlpha()F

    move-result v3

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrGlow;->fade(IF)I

    move-result v0

    .line 364
    :cond_5
    invoke-static {p3, v2}, Lcom/mrkeyboard/app/MrAdapt;->over(II)I

    move-result v3

    .line 365
    ushr-int/lit8 v2, v0, 0x18

    if-nez v2, :cond_9

    const/4 v0, -0x1

    const v2, 0x3e8f5c29    # 0.28f

    invoke-static {v3, v0, v2}, Lcom/mrkeyboard/app/MrBackdrop;->mix(IIF)I

    move-result v0

    .line 366
    :goto_5
    const/4 v2, 0x2

    new-array v2, v2, [I

    aput v3, v2, v1

    aput v0, v2, v6

    move-object v0, v2

    goto/16 :goto_0

    .line 355
    :cond_6
    const-string v3, "spectrum_mid"

    invoke-static {p0, p1, v3}, Lcom/mrkeyboard/app/MrThemeColors;->own(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    goto :goto_2

    .line 359
    :cond_7
    invoke-static {v3, v0}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v0

    goto :goto_3

    .line 362
    :cond_8
    iget v3, p2, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    int-to-float v3, v3

    div-float/2addr v3, v5

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrGlow;->scale(IF)I

    move-result v0

    goto :goto_4

    .line 365
    :cond_9
    invoke-static {p3, v0}, Lcom/mrkeyboard/app/MrAdapt;->over(II)I

    move-result v0

    goto :goto_5
.end method

.method private static declared-synchronized faceNow(Z)[I
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 379
    const-class v1, Lcom/mrkeyboard/app/MrAdapt;

    monitor-enter v1

    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAdapt;->tone()Lcom/mrkeyboard/app/MrAdapt$Tone;

    move-result-object v2

    .line 380
    iget-boolean v3, v2, Lcom/mrkeyboard/app/MrAdapt$Tone;->on:Z

    if-eqz v3, :cond_0

    iget v3, v2, Lcom/mrkeyboard/app/MrAdapt$Tone;->under:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v3, :cond_1

    .line 390
    :cond_0
    :goto_0
    monitor-exit v1

    return-object v0

    .line 381
    :cond_1
    :try_start_1
    sget-object v3, Lcom/mrkeyboard/app/MrAdapt;->sFaces:[I

    if-nez v3, :cond_2

    .line 382
    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    .line 383
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->tag()Ljava/lang/String;

    move-result-object v4

    .line 384
    invoke-static {v3}, Lcom/mrkeyboard/app/MrKeyLook;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v5

    .line 385
    iget v2, v2, Lcom/mrkeyboard/app/MrAdapt$Tone;->under:I

    const/4 v6, 0x0

    invoke-static {v3, v4, v5, v2, v6}, Lcom/mrkeyboard/app/MrAdapt;->face(Landroid/content/Context;Ljava/lang/String;Lcom/mrkeyboard/app/MrKeyLook;IZ)[I

    move-result-object v2

    .line 386
    if-eqz v2, :cond_0

    .line 387
    const/4 v0, 0x0

    aget v0, v2, v0

    const/4 v6, 0x1

    invoke-static {v3, v4, v5, v0, v6}, Lcom/mrkeyboard/app/MrAdapt;->face(Landroid/content/Context;Ljava/lang/String;Lcom/mrkeyboard/app/MrKeyLook;IZ)[I

    move-result-object v3

    .line 388
    const/4 v0, 0x4

    new-array v4, v0, [I

    const/4 v0, 0x0

    const/4 v5, 0x0

    aget v5, v2, v5

    aput v5, v4, v0

    const/4 v0, 0x1

    const/4 v5, 0x1

    aget v5, v2, v5

    aput v5, v4, v0

    const/4 v5, 0x2

    if-nez v3, :cond_3

    const/4 v0, 0x0

    aget v0, v2, v0

    :goto_1
    aput v0, v4, v5

    const/4 v5, 0x3

    if-nez v3, :cond_4

    const/4 v0, 0x1

    aget v0, v2, v0

    :goto_2
    aput v0, v4, v5

    sput-object v4, Lcom/mrkeyboard/app/MrAdapt;->sFaces:[I

    .line 390
    :cond_2
    if-eqz p0, :cond_5

    const/4 v0, 0x2

    new-array v0, v0, [I

    const/4 v2, 0x0

    sget-object v3, Lcom/mrkeyboard/app/MrAdapt;->sFaces:[I

    const/4 v4, 0x2

    aget v3, v3, v4

    aput v3, v0, v2

    const/4 v2, 0x1

    sget-object v3, Lcom/mrkeyboard/app/MrAdapt;->sFaces:[I

    const/4 v4, 0x3

    aget v3, v3, v4

    aput v3, v0, v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 379
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0

    .line 388
    :cond_3
    const/4 v0, 0x0

    :try_start_2
    aget v0, v3, v0

    goto :goto_1

    :cond_4
    const/4 v0, 0x1

    aget v0, v3, v0

    goto :goto_2

    .line 390
    :cond_5
    const/4 v0, 0x2

    new-array v0, v0, [I

    const/4 v2, 0x0

    sget-object v3, Lcom/mrkeyboard/app/MrAdapt;->sFaces:[I

    const/4 v4, 0x0

    aget v3, v3, v4

    aput v3, v0, v2

    const/4 v2, 0x1

    sget-object v3, Lcom/mrkeyboard/app/MrAdapt;->sFaces:[I

    const/4 v4, 0x1

    aget v3, v3, v4

    aput v3, v0, v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0
.end method

.method private static fillAndLine(Landroid/graphics/drawable/GradientDrawable;II)V
    .locals 2

    .prologue
    .line 442
    invoke-virtual {p0, p1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 443
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    .line 444
    if-nez v0, :cond_0

    const/high16 v0, 0x3f800000    # 1.0f

    .line 445
    :goto_0
    const/4 v1, 0x1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-virtual {p0, v0, p2}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 446
    return-void

    .line 444
    :cond_0
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    goto :goto_0
.end method

.method private static isInk(Ljava/lang/String;)Z
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 75
    if-nez p0, :cond_0

    .line 81
    :goto_0
    return v0

    .line 76
    :cond_0
    const/4 v2, -0x1

    invoke-virtual {p0}, Ljava/lang/String;->hashCode()I

    move-result v3

    sparse-switch v3, :sswitch_data_0

    :cond_1
    :goto_1
    packed-switch v2, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    move v0, v1

    .line 79
    goto :goto_0

    .line 76
    :sswitch_0
    const-string v3, "text"

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    move v2, v0

    goto :goto_1

    :sswitch_1
    const-string v3, "hint"

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    move v2, v1

    goto :goto_1

    :sswitch_2
    const-string v3, "accent_text"

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/4 v2, 0x2

    goto :goto_1

    :sswitch_3
    const-string v3, "accent_hint"

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/4 v2, 0x3

    goto :goto_1

    :sswitch_4
    const-string v3, "popup_text"

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/4 v2, 0x4

    goto :goto_1

    :sswitch_5
    const-string v3, "popup_hint"

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/4 v2, 0x5

    goto :goto_1

    :sswitch_6
    const-string v3, "cursor"

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/4 v2, 0x6

    goto :goto_1

    :sswitch_7
    const-string v3, "panel_icon"

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/4 v2, 0x7

    goto :goto_1

    :sswitch_8
    const-string v3, "panel_tab_on_text"

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/16 v2, 0x8

    goto :goto_1

    :sswitch_9
    const-string v3, "sel_cancel_text"

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/16 v2, 0x9

    goto :goto_1

    :sswitch_a
    const-string v3, "attach_fab_icon"

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/16 v2, 0xa

    goto :goto_1

    :sswitch_b
    const-string v3, "tool_ink"

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/16 v2, 0xb

    goto/16 :goto_1

    :sswitch_c
    const-string v3, "tool_hint"

    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/16 v2, 0xc

    goto/16 :goto_1

    :sswitch_data_0
    .sparse-switch
        -0x71eb4dc6 -> :sswitch_5
        -0x71e5e720 -> :sswitch_4
        -0x6968d093 -> :sswitch_9
        -0x5069ecaa -> :sswitch_6
        -0x4458af24 -> :sswitch_3
        -0x4453487e -> :sswitch_2
        -0x3a9b5b41 -> :sswitch_b
        -0x18d09332 -> :sswitch_c
        -0x33db8d8 -> :sswitch_8
        0x30de87 -> :sswitch_1
        0x36452d -> :sswitch_0
        0x4d5d8dd4 -> :sswitch_7
        0x5598b76b -> :sswitch_a
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method static keyColour(Landroid/content/Context;Ljava/lang/String;)I
    .locals 1

    .prologue
    .line 325
    invoke-static {p0}, Lcom/mrkeyboard/app/MrKeyLook;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrAdapt;->keyColour(Ljava/lang/String;Lcom/mrkeyboard/app/MrKeyLook;)I

    move-result v0

    return v0
.end method

.method static keyColour(Ljava/lang/String;Lcom/mrkeyboard/app/MrKeyLook;)I
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v0, 0x0

    .line 330
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->isOwn(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 331
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrKeyLook;->spectrum(Ljava/lang/String;Lcom/mrkeyboard/app/MrKeyLook;)[I

    move-result-object v1

    .line 332
    if-nez v1, :cond_1

    .line 337
    :cond_0
    :goto_0
    return v0

    .line 332
    :cond_1
    aget v0, v1, v3

    goto :goto_0

    .line 334
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->styleOf(Ljava/lang/String;)I

    move-result v1

    .line 335
    if-lez v1, :cond_0

    const/16 v2, 0xf

    if-ge v1, v2, :cond_0

    .line 336
    sget-object v2, Lcom/mrkeyboard/app/MrBackdrop;->STYLE_COLORS:[[I

    aget-object v1, v2, v1

    .line 337
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

    .line 284
    const-string v1, ""

    .line 287
    :try_start_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 288
    if-eqz v2, :cond_0

    .line 289
    const-string v3, "pref_kbd_bg"

    const-string v4, ""

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 290
    const-string v3, "pref_kbd_bg_soft"

    const/4 v4, 0x0

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 295
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

    .line 292
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method static over(II)I
    .locals 3

    .prologue
    .line 371
    const/high16 v0, -0x1000000

    or-int/2addr v0, p1

    ushr-int/lit8 v1, p1, 0x18

    int-to-float v1, v1

    const/high16 v2, 0x437f0000    # 255.0f

    div-float/2addr v1, v2

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrBackdrop;->mix(IIF)I

    move-result v0

    return v0
.end method

.method private static paint(Landroid/graphics/drawable/Drawable;III)V
    .locals 5

    .prologue
    const/4 v2, 0x0

    .line 424
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 425
    instance-of v1, v0, Landroid/graphics/drawable/LayerDrawable;

    if-nez v1, :cond_1

    .line 426
    instance-of v1, v0, Landroid/graphics/drawable/GradientDrawable;

    if-eqz v1, :cond_0

    check-cast v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-static {v0, p1, p2}, Lcom/mrkeyboard/app/MrAdapt;->fillAndLine(Landroid/graphics/drawable/GradientDrawable;II)V

    .line 439
    :cond_0
    return-void

    .line 429
    :cond_1
    check-cast v0, Landroid/graphics/drawable/LayerDrawable;

    .line 430
    const/4 v1, -0x1

    move v3, v1

    move v1, v2

    .line 431
    :goto_0
    invoke-virtual {v0}, Landroid/graphics/drawable/LayerDrawable;->getNumberOfLayers()I

    move-result v4

    if-ge v1, v4, :cond_3

    .line 432
    invoke-virtual {v0, v1}, Landroid/graphics/drawable/LayerDrawable;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v4

    instance-of v4, v4, Landroid/graphics/drawable/GradientDrawable;

    if-eqz v4, :cond_2

    move v3, v1

    .line 431
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 434
    :cond_3
    :goto_1
    invoke-virtual {v0}, Landroid/graphics/drawable/LayerDrawable;->getNumberOfLayers()I

    move-result v1

    if-ge v2, v1, :cond_0

    .line 435
    invoke-virtual {v0, v2}, Landroid/graphics/drawable/LayerDrawable;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    .line 436
    if-ne v2, v3, :cond_5

    check-cast v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-static {v1, p1, p2}, Lcom/mrkeyboard/app/MrAdapt;->fillAndLine(Landroid/graphics/drawable/GradientDrawable;II)V

    .line 434
    :cond_4
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 437
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
    .line 401
    if-eqz p0, :cond_0

    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAdapt;->active()Z

    move-result v0

    if-nez v0, :cond_1

    .line 408
    :cond_0
    :goto_0
    return-void

    .line 402
    :cond_1
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAdapt;->faceNow(Z)[I

    move-result-object v0

    .line 403
    if-eqz v0, :cond_2

    const/4 v1, 0x0

    aget v1, v0, v1

    const/4 v2, 0x1

    aget v0, v0, v2

    const/4 v2, 0x0

    invoke-static {p0, v1, v0, v2}, Lcom/mrkeyboard/app/MrAdapt;->paint(Landroid/graphics/drawable/Drawable;III)V

    goto :goto_0

    .line 405
    :catch_0
    move-exception v0

    goto :goto_0

    .line 404
    :cond_2
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
.end method

.method static declared-synchronized popupFilter()Landroid/graphics/PorterDuffColorFilter;
    .locals 4

    .prologue
    .line 453
    const-class v1, Lcom/mrkeyboard/app/MrAdapt;

    monitor-enter v1

    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAdapt;->active()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 460
    :goto_0
    monitor-exit v1

    return-object v0

    .line 454
    :cond_0
    const/4 v0, 0x1

    :try_start_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAdapt;->faceNow(Z)[I

    move-result-object v0

    .line 455
    if-eqz v0, :cond_3

    const/4 v2, 0x0

    aget v0, v0, v2

    .line 456
    :goto_1
    sget-object v2, Lcom/mrkeyboard/app/MrAdapt;->sPopupFilter:Landroid/graphics/PorterDuffColorFilter;

    if-eqz v2, :cond_1

    sget v2, Lcom/mrkeyboard/app/MrAdapt;->sPopupColour:I

    if-eq v2, v0, :cond_2

    .line 457
    :cond_1
    new-instance v2, Landroid/graphics/PorterDuffColorFilter;

    sget-object v3, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v2, v0, v3}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V

    sput-object v2, Lcom/mrkeyboard/app/MrAdapt;->sPopupFilter:Landroid/graphics/PorterDuffColorFilter;

    .line 458
    sput v0, Lcom/mrkeyboard/app/MrAdapt;->sPopupColour:I

    .line 460
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrAdapt;->sPopupFilter:Landroid/graphics/PorterDuffColorFilter;

    goto :goto_0

    .line 455
    :cond_3
    const-string v0, "popup_key_fill"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v0

    goto :goto_1

    .line 453
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static declared-synchronized reset()V
    .locals 2

    .prologue
    .line 200
    const-class v1, Lcom/mrkeyboard/app/MrAdapt;

    monitor-enter v1

    const/4 v0, 0x0

    :try_start_0
    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sKey:Ljava/lang/String;

    .line 201
    sget-object v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    .line 202
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sPopupFilter:Landroid/graphics/PorterDuffColorFilter;

    .line 203
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sFaces:[I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 204
    monitor-exit v1

    return-void

    .line 200
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

    .line 230
    const/4 v1, 0x3

    new-array v1, v1, [F

    .line 231
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 232
    const/4 v4, 0x1

    aget v4, v1, v4

    const/4 v5, 0x1

    aget v1, v1, v5

    sub-float v1, p2, v1

    mul-float/2addr v1, p3

    add-float/2addr v4, v1

    .line 233
    or-int v1, v8, p0

    invoke-static {v1}, Lcom/mrkeyboard/app/MrThemeColors;->luminance(I)F

    move-result v5

    .line 235
    invoke-static {p1, v4, v3}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrThemeColors;->luminance(I)F

    move-result v1

    cmpg-float v1, v1, v5

    if-gez v1, :cond_2

    move v1, v4

    move v4, v0

    .line 238
    :goto_0
    const/16 v0, 0xe

    if-ge v4, v0, :cond_1

    .line 239
    add-float v0, v2, v1

    div-float/2addr v0, v7

    .line 240
    invoke-static {p1, v0, v3}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v6

    invoke-static {v6}, Lcom/mrkeyboard/app/MrThemeColors;->luminance(I)F

    move-result v6

    cmpg-float v6, v6, v5

    if-gez v6, :cond_0

    move v1, v2

    .line 238
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

    .line 241
    goto :goto_1

    .line 243
    :cond_1
    invoke-static {p1, v2, v3}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v0

    .line 253
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

    .line 246
    :goto_3
    const/16 v1, 0xe

    if-ge v3, v1, :cond_4

    .line 247
    add-float v1, v2, v0

    div-float/2addr v1, v7

    .line 248
    invoke-static {p1, v4, v1}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v6

    invoke-static {v6}, Lcom/mrkeyboard/app/MrThemeColors;->luminance(I)F

    move-result v6

    cmpg-float v6, v6, v5

    if-gez v6, :cond_3

    .line 246
    :goto_4
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    move v2, v1

    goto :goto_3

    :cond_3
    move v0, v1

    move v1, v2

    .line 249
    goto :goto_4

    .line 251
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

    .line 60
    if-nez p0, :cond_0

    .line 69
    :goto_0
    return v0

    .line 61
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

    .line 62
    goto :goto_0

    .line 61
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

    .line 63
    goto/16 :goto_0

    :pswitch_2
    move v0, v2

    .line 64
    goto/16 :goto_0

    .line 65
    :pswitch_3
    const v0, 0x3f0ccccd    # 0.55f

    goto/16 :goto_0

    .line 66
    :pswitch_4
    const v0, 0x3e99999a    # 0.3f

    goto/16 :goto_0

    .line 67
    :pswitch_5
    if-eqz p1, :cond_2

    const v0, 0x3dcccccd    # 0.1f

    goto/16 :goto_0

    :cond_2
    const/high16 v0, 0x3f400000    # 0.75f

    goto/16 :goto_0

    :pswitch_6
    move v0, v2

    .line 68
    goto/16 :goto_0

    .line 61
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
    .line 259
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    .line 260
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->tag()Ljava/lang/String;

    move-result-object v1

    .line 261
    if-eqz v0, :cond_0

    invoke-static {v1}, Lcom/mrkeyboard/app/MrThemeColors;->hidden(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;

    .line 278
    :goto_0
    return-object v0

    .line 262
    :cond_1
    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAdapt;->keyOf(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 263
    if-eqz v2, :cond_2

    sget-object v3, Lcom/mrkeyboard/app/MrAdapt;->sKey:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrAdapt;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    goto :goto_0

    .line 264
    :cond_2
    const-class v3, Lcom/mrkeyboard/app/MrAdapt;

    monitor-enter v3

    .line 265
    if-eqz v2, :cond_3

    :try_start_0
    sget-object v4, Lcom/mrkeyboard/app/MrAdapt;->sKey:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    sget-object v0, Lcom/mrkeyboard/app/MrAdapt;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    monitor-exit v3

    goto :goto_0

    .line 279
    :catchall_0
    move-exception v0

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 266
    :cond_3
    const/4 v4, 0x1

    :try_start_1
    sput-boolean v4, Lcom/mrkeyboard/app/MrAdapt;->sBusy:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 268
    :try_start_2
    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAdapt;->compute(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/MrAdapt$Tone;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    .line 269
    sput-object v2, Lcom/mrkeyboard/app/MrAdapt;->sKey:Ljava/lang/String;

    .line 270
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sPopupFilter:Landroid/graphics/PorterDuffColorFilter;

    .line 271
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sFaces:[I
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 276
    const/4 v0, 0x0

    :try_start_3
    sput-boolean v0, Lcom/mrkeyboard/app/MrAdapt;->sBusy:Z

    .line 278
    :goto_1
    sget-object v0, Lcom/mrkeyboard/app/MrAdapt;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    monitor-exit v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    .line 272
    :catch_0
    move-exception v0

    .line 273
    :try_start_4
    sget-object v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    .line 274
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt;->sKey:Ljava/lang/String;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 276
    const/4 v0, 0x0

    :try_start_5
    sput-boolean v0, Lcom/mrkeyboard/app/MrAdapt;->sBusy:Z

    goto :goto_1

    :catchall_1
    move-exception v0

    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrAdapt;->sBusy:Z

    .line 277
    throw v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0
.end method
