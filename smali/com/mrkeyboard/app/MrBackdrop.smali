.class final Lcom/mrkeyboard/app/MrBackdrop;
.super Ljava/lang/Object;
.source "MrBackdrop.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrBackdrop$Spec;,
        Lcom/mrkeyboard/app/MrBackdrop$Look;
    }
.end annotation


# static fields
.field static final ASPECT:F = 2.4f

.field static final BAR_SHARE:F = 0.17f

.field static final DARK_TARGET:F = 0.4f

.field static final FILE:Ljava/lang/String; = "kbd_bg.jpg"

.field static final GRADIENT:I = 0x1

.field static final GRADIENTS:[[I

.field static final IMAGE:I = 0x3

.field static final JPEG_QUALITY:I = 0x5a

.field static final LIGHT_TARGET:F = 0.62f

.field static final MAX_SIDE:I = 0x500

.field static final MAX_SOFT:I = 0x46

.field static final MAX_VEIL:F = 0.75f

.field static final NONE:I = 0x0

.field static final PREF:Ljava/lang/String; = "pref_kbd_bg"

.field static final PREF_SOFT:Ljava/lang/String; = "pref_kbd_bg_soft"

.field static final PROBE_W:I = 0x30

.field static final SCENE:I = 0x2

.field static final ZOOM_MAX:I = 0x190

.field static final ZOOM_MIN:I = 0x64

.field private static sDrawable:Lcom/mrkeyboard/app/MrBackdropDrawable;

.field private static sDrawableKey:Ljava/lang/String;

.field private static sLook:Lcom/mrkeyboard/app/MrBackdrop$Look;

.field private static sLookKey:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v4, 0x4

    const/4 v3, 0x3

    .line 80
    const/16 v0, 0xc

    new-array v0, v0, [[I

    const/4 v1, 0x0

    new-array v2, v4, [I

    fill-array-data v2, :array_0

    aput-object v2, v0, v1

    const/4 v1, 0x1

    new-array v2, v3, [I

    fill-array-data v2, :array_1

    aput-object v2, v0, v1

    const/4 v1, 0x2

    new-array v2, v3, [I

    fill-array-data v2, :array_2

    aput-object v2, v0, v1

    new-array v1, v3, [I

    fill-array-data v1, :array_3

    aput-object v1, v0, v3

    new-array v1, v3, [I

    fill-array-data v1, :array_4

    aput-object v1, v0, v4

    const/4 v1, 0x5

    new-array v2, v3, [I

    fill-array-data v2, :array_5

    aput-object v2, v0, v1

    const/4 v1, 0x6

    new-array v2, v3, [I

    fill-array-data v2, :array_6

    aput-object v2, v0, v1

    const/4 v1, 0x7

    new-array v2, v3, [I

    fill-array-data v2, :array_7

    aput-object v2, v0, v1

    const/16 v1, 0x8

    new-array v2, v3, [I

    fill-array-data v2, :array_8

    aput-object v2, v0, v1

    const/16 v1, 0x9

    new-array v2, v3, [I

    fill-array-data v2, :array_9

    aput-object v2, v0, v1

    const/16 v1, 0xa

    new-array v2, v3, [I

    fill-array-data v2, :array_a

    aput-object v2, v0, v1

    const/16 v1, 0xb

    new-array v2, v3, [I

    fill-array-data v2, :array_b

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrBackdrop;->GRADIENTS:[[I

    return-void

    nop

    :array_0
    .array-data 4
        0x87
        -0xf0dfd9
        -0xdfc5bd
        -0xd3ac9c
    .end array-data

    :array_1
    .array-data 4
        0x96
        -0xbed6a6
        -0xd0f8bd
    .end array-data

    :array_2
    .array-data 4
        0xa0
        -0xecb1a2
        -0x8e4d80
    .end array-data

    :array_3
    .array-data 4
        0x87
        -0x11f687
        -0x9600
    .end array-data

    :array_4
    .array-data 4
        0x87
        -0xff3901
        -0xff8d01
    .end array-data

    :array_5
    .array-data 4
        0x87
        -0x9ab15d
        -0x155038
    .end array-data

    :array_6
    .array-data 4
        0xa0
        -0xdcdada
        -0xbebcbb
    .end array-data

    :array_7
    .array-data 4
        0x87
        -0x6ac3a
        -0x46e28d
    .end array-data

    :array_8
    .array-data 4
        0x87
        -0xee6672
        -0xc71083
    .end array-data

    :array_9
    .array-data 4
        0x87
        -0xe1c38e
        -0xd5ad68
    .end array-data

    :array_a
    .array-data 4
        0x87
        -0xd66b6
        -0xd36b4
    .end array-data

    :array_b
    .array-data 4
        0x87
        -0x1f1504
        -0x30210d
    .end array-data
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 94
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static declared-synchronized apply()V
    .locals 9

    .prologue
    .line 552
    const-class v1, Lcom/mrkeyboard/app/MrBackdrop;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarRoot:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 553
    if-nez v0, :cond_1

    .line 574
    :cond_0
    :goto_0
    monitor-exit v1

    return-void

    .line 554
    :cond_1
    :try_start_1
    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v2

    .line 555
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v3

    .line 556
    iget v4, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eqz v4, :cond_0

    .line 557
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->darkNow(Landroid/content/Context;)Z

    move-result v4

    .line 558
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->soft(Landroid/content/Context;)I

    move-result v5

    .line 559
    const-string v6, "kbd_bg"

    invoke-static {v6}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v6

    .line 561
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->format()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "|"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "|"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "|"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 562
    sget-object v8, Lcom/mrkeyboard/app/MrBackdrop;->sDrawable:Lcom/mrkeyboard/app/MrBackdropDrawable;

    if-eqz v8, :cond_2

    sget-object v8, Lcom/mrkeyboard/app/MrBackdrop;->sDrawableKey:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_3

    .line 563
    :cond_2
    invoke-static {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrBackdropDrawable;->create(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;ZII)Lcom/mrkeyboard/app/MrBackdropDrawable;

    move-result-object v2

    .line 564
    if-eqz v2, :cond_0

    .line 565
    sput-object v2, Lcom/mrkeyboard/app/MrBackdrop;->sDrawable:Lcom/mrkeyboard/app/MrBackdropDrawable;

    .line 566
    sput-object v7, Lcom/mrkeyboard/app/MrBackdrop;->sDrawableKey:Ljava/lang/String;

    .line 568
    :cond_3
    sget-object v2, Lcom/mrkeyboard/app/MrBackdrop;->sDrawable:Lcom/mrkeyboard/app/MrBackdropDrawable;

    invoke-virtual {v0, v2}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 569
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    .line 570
    if-eqz v0, :cond_0

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/view/View;->setBackgroundColor(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 571
    :catch_0
    move-exception v0

    goto :goto_0

    .line 552
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static bottomColor(Landroid/content/Context;)I
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 537
    if-eqz p0, :cond_0

    :try_start_0
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x24

    if-lt v1, v2, :cond_1

    .line 541
    :cond_0
    :goto_0
    return v0

    .line 538
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->lookNow(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Look;

    move-result-object v1

    .line 539
    if-eqz v1, :cond_0

    iget v0, v1, Lcom/mrkeyboard/app/MrBackdrop$Look;->bottom:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 540
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static clamp(III)I
    .locals 0

    .prologue
    .line 171
    if-ge p0, p1, :cond_0

    :goto_0
    return p1

    :cond_0
    if-le p0, p2, :cond_1

    move p1, p2

    goto :goto_0

    :cond_1
    move p1, p0

    goto :goto_0
.end method

.method private static copy(Ljava/io/InputStream;Ljava/io/File;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 466
    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 468
    const/16 v0, 0x4000

    :try_start_0
    new-array v0, v0, [B

    .line 470
    :goto_0
    invoke-virtual {p0, v0}, Ljava/io/InputStream;->read([B)I

    move-result v2

    if-lez v2, :cond_0

    const/4 v3, 0x0

    invoke-virtual {v1, v0, v3, v2}, Ljava/io/OutputStream;->write([BII)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 472
    :catchall_0
    move-exception v0

    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V

    .line 473
    throw v0

    .line 472
    :cond_0
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V

    .line 474
    return-void
.end method

.method static crop(IIIIIII)Landroid/graphics/Rect;
    .locals 12

    .prologue
    .line 243
    if-lez p0, :cond_0

    if-lez p1, :cond_0

    if-lez p2, :cond_0

    if-gtz p3, :cond_1

    :cond_0
    new-instance v2, Landroid/graphics/Rect;

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v5, p0}, Ljava/lang/Math;->max(II)I

    move-result v5

    const/4 v6, 0x0

    invoke-static {v6, p1}, Ljava/lang/Math;->max(II)I

    move-result v6

    invoke-direct {v2, v3, v4, v5, v6}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 261
    :goto_0
    return-object v2

    .line 244
    :cond_1
    int-to-double v2, p2

    int-to-double v4, p3

    div-double v6, v2, v4

    .line 246
    int-to-double v2, p0

    int-to-double v4, p1

    div-double/2addr v2, v4

    cmpl-double v2, v2, v6

    if-lez v2, :cond_2

    .line 247
    int-to-double v2, p1

    .line 248
    int-to-double v4, p1

    mul-double/2addr v4, v6

    .line 253
    :goto_1
    const/16 v6, 0x64

    const/16 v7, 0x190

    move/from16 v0, p4

    invoke-static {v0, v6, v7}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v6

    int-to-double v6, v6

    const-wide/high16 v8, 0x4059000000000000L    # 100.0

    div-double/2addr v6, v8

    .line 254
    div-double/2addr v4, v6

    .line 255
    div-double/2addr v2, v6

    .line 256
    int-to-double v6, p0

    sub-double/2addr v6, v4

    const/16 v8, -0x64

    const/16 v9, 0x64

    move/from16 v0, p5

    invoke-static {v0, v8, v9}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v8

    add-int/lit8 v8, v8, 0x64

    int-to-double v8, v8

    mul-double/2addr v6, v8

    const-wide/high16 v8, 0x4069000000000000L    # 200.0

    div-double/2addr v6, v8

    .line 257
    int-to-double v8, p1

    sub-double/2addr v8, v2

    const/16 v10, -0x64

    const/16 v11, 0x64

    move/from16 v0, p6

    invoke-static {v0, v10, v11}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v10

    add-int/lit8 v10, v10, 0x64

    int-to-double v10, v10

    mul-double/2addr v8, v10

    const-wide/high16 v10, 0x4069000000000000L    # 200.0

    div-double/2addr v8, v10

    .line 259
    invoke-static {v6, v7}, Ljava/lang/Math;->round(D)J

    move-result-wide v6

    long-to-int v6, v6

    const/4 v7, 0x0

    add-int/lit8 v10, p0, -0x1

    invoke-static {v6, v7, v10}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v6

    invoke-static {v8, v9}, Ljava/lang/Math;->round(D)J

    move-result-wide v8

    long-to-int v7, v8

    const/4 v8, 0x0

    add-int/lit8 v9, p1, -0x1

    invoke-static {v7, v8, v9}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v7

    .line 260
    invoke-static {v4, v5}, Ljava/lang/Math;->round(D)J

    move-result-wide v4

    long-to-int v4, v4

    add-int/2addr v4, v6

    invoke-static {p0, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    invoke-static {v2, v3}, Ljava/lang/Math;->round(D)J

    move-result-wide v2

    long-to-int v2, v2

    add-int/2addr v2, v7

    invoke-static {p1, v2}, Ljava/lang/Math;->min(II)I

    move-result v3

    .line 261
    new-instance v2, Landroid/graphics/Rect;

    add-int/lit8 v5, v6, 0x1

    invoke-static {v5, v4}, Ljava/lang/Math;->max(II)I

    move-result v4

    add-int/lit8 v5, v7, 0x1

    invoke-static {v5, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-direct {v2, v6, v7, v4, v3}, Landroid/graphics/Rect;-><init>(IIII)V

    goto/16 :goto_0

    .line 250
    :cond_2
    int-to-double v4, p0

    .line 251
    int-to-double v2, p0

    div-double/2addr v2, v6

    goto :goto_1
.end method

.method static current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Spec;
    .locals 3

    .prologue
    .line 176
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 177
    if-nez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    :goto_0
    return-object v0

    :cond_0
    const-string v1, "pref_kbd_bg"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->parse(Ljava/lang/String;)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    goto :goto_0
.end method

.method static darkNow(Landroid/content/Context;)Z
    .locals 1

    .prologue
    .line 508
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->tag()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrThemeColors;->dark(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method static degrees(I)I
    .locals 1

    .prologue
    .line 413
    packed-switch p0, :pswitch_data_0

    .line 417
    :pswitch_0
    const/4 v0, 0x0

    :goto_0
    return v0

    .line 414
    :pswitch_1
    const/16 v0, 0x5a

    goto :goto_0

    .line 415
    :pswitch_2
    const/16 v0, 0xb4

    goto :goto_0

    .line 416
    :pswitch_3
    const/16 v0, 0x10e

    goto :goto_0

    .line 413
    :pswitch_data_0
    .packed-switch 0x3
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_0
        :pswitch_3
    .end packed-switch
.end method

.method static draw(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/MrBackdrop$Spec;IILandroid/graphics/Bitmap;)V
    .locals 1

    .prologue
    .line 199
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    if-lez p2, :cond_0

    if-gtz p3, :cond_1

    .line 213
    :cond_0
    :goto_0
    return-void

    .line 200
    :cond_1
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    .line 202
    :pswitch_0
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrBackdrop;->gradient(Landroid/graphics/Canvas;III)V

    goto :goto_0

    .line 205
    :pswitch_1
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->draw(Landroid/graphics/Canvas;III)V

    goto :goto_0

    .line 208
    :pswitch_2
    if-eqz p4, :cond_0

    invoke-static {p0, p1, p4, p2, p3}, Lcom/mrkeyboard/app/MrBackdrop;->picture(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;II)V

    goto :goto_0

    .line 200
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method private static fit(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;
    .locals 4

    .prologue
    const/4 v3, 0x1

    .line 478
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 479
    const/16 v1, 0x500

    if-gt v0, v1, :cond_0

    .line 481
    :goto_0
    return-object p0

    .line 480
    :cond_0
    const/high16 v1, 0x44a00000    # 1280.0f

    int-to-float v0, v0

    div-float v0, v1, v0

    .line 481
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v1

    int-to-float v1, v1

    mul-float/2addr v1, v0

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    invoke-static {v3, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    int-to-float v2, v2

    mul-float/2addr v0, v2

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-static {v3, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-static {p0, v1, v0, v3}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object p0

    goto :goto_0
.end method

.method private static gradient(Landroid/graphics/Canvas;III)V
    .locals 12

    .prologue
    const/4 v2, 0x0

    const/4 v11, 0x0

    const/4 v10, 0x1

    const/high16 v8, 0x40000000    # 2.0f

    .line 216
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->GRADIENTS:[[I

    aget-object v0, v0, p1

    .line 217
    array-length v1, v0

    add-int/lit8 v1, v1, -0x1

    new-array v5, v1, [I

    .line 218
    array-length v1, v5

    invoke-static {v0, v10, v5, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 219
    aget v0, v0, v2

    int-to-double v0, v0

    invoke-static {v0, v1}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v0

    .line 220
    invoke-static {v0, v1}, Ljava/lang/Math;->sin(D)D

    move-result-wide v2

    double-to-float v3, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->cos(D)D

    move-result-wide v0

    neg-double v0, v0

    double-to-float v4, v0

    .line 222
    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v0

    int-to-float v1, p2

    mul-float/2addr v0, v1

    invoke-static {v4}, Ljava/lang/Math;->abs(F)F

    move-result v1

    int-to-float v2, p3

    mul-float/2addr v1, v2

    add-float/2addr v0, v1

    div-float v6, v0, v8

    .line 223
    int-to-float v0, p2

    div-float v7, v0, v8

    int-to-float v0, p3

    div-float v8, v0, v8

    .line 224
    new-instance v9, Landroid/graphics/Paint;

    invoke-direct {v9, v10}, Landroid/graphics/Paint;-><init>(I)V

    .line 225
    invoke-virtual {v9, v10}, Landroid/graphics/Paint;->setDither(Z)V

    .line 226
    new-instance v0, Landroid/graphics/LinearGradient;

    mul-float v1, v3, v6

    sub-float v1, v7, v1

    mul-float v2, v4, v6

    sub-float v2, v8, v2

    mul-float/2addr v3, v6

    add-float/2addr v3, v7

    mul-float/2addr v4, v6

    add-float/2addr v4, v8

    const/4 v6, 0x0

    sget-object v7, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct/range {v0 .. v7}, Landroid/graphics/LinearGradient;-><init>(FFFF[I[FLandroid/graphics/Shader$TileMode;)V

    invoke-virtual {v9, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 227
    int-to-float v3, p2

    int-to-float v4, p3

    move-object v0, p0

    move v1, v11

    move v2, v11

    move-object v5, v9

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 228
    return-void
.end method

.method static hasImage(Landroid/content/Context;)Z
    .locals 3

    .prologue
    .line 378
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "kbd_bg.jpg"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->isFile()Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 380
    :goto_0
    return v0

    .line 379
    :catch_0
    move-exception v0

    .line 380
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static imageStamp(Landroid/content/Context;)J
    .locals 5

    .prologue
    const-wide/16 v0, 0x0

    .line 387
    :try_start_0
    new-instance v2, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v3

    const-string v4, "kbd_bg.jpg"

    invoke-direct {v2, v3, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 388
    invoke-virtual {v2}, Ljava/io/File;->isFile()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v2}, Ljava/io/File;->lastModified()J
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v0

    .line 390
    :cond_0
    :goto_0
    return-wide v0

    .line 389
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method static importImage(Landroid/content/Context;Ljava/io/InputStream;)[I
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 427
    .line 429
    :try_start_0
    new-instance v3, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "kbd_bg_in"

    invoke-direct {v3, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_7
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 430
    :try_start_1
    invoke-static {p1, v3}, Lcom/mrkeyboard/app/MrBackdrop;->copy(Ljava/io/InputStream;Ljava/io/File;)V

    .line 431
    new-instance v1, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v1}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 432
    const/4 v2, 0x1

    iput-boolean v2, v1, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 433
    invoke-virtual {v3}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    .line 434
    iget v2, v1, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    if-lez v2, :cond_0

    iget v2, v1, Landroid/graphics/BitmapFactory$Options;->outHeight:I
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_8
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_5
    .catch Ljava/lang/OutOfMemoryError; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    if-gtz v2, :cond_3

    .line 460
    :cond_0
    if-eqz v3, :cond_1

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 461
    :cond_1
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 458
    :cond_2
    :goto_0
    return-object v0

    .line 435
    :cond_3
    :try_start_2
    new-instance v2, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v2}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 436
    iget v4, v1, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    iget v1, v1, Landroid/graphics/BitmapFactory$Options;->outHeight:I

    invoke-static {v4, v1}, Lcom/mrkeyboard/app/MrBackdrop;->sampleSize(II)I

    move-result v1

    iput v1, v2, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 437
    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v1, v2, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 438
    invoke-virtual {v3}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v2}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_8
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_5
    .catch Ljava/lang/OutOfMemoryError; {:try_start_2 .. :try_end_2} :catch_3
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    move-result-object v1

    .line 439
    if-nez v1, :cond_5

    .line 460
    if-eqz v3, :cond_4

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 461
    :cond_4
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    goto :goto_0

    .line 440
    :cond_5
    :try_start_3
    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->fit(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 441
    invoke-static {v3}, Lcom/mrkeyboard/app/MrBackdrop;->orientation(Ljava/io/File;)I

    move-result v2

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrBackdrop;->turn(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;

    move-result-object v4

    .line 442
    new-instance v2, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v5, "kbd_bg.jpg.new"

    invoke-direct {v2, v1, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_8
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_5
    .catch Ljava/lang/OutOfMemoryError; {:try_start_3 .. :try_end_3} :catch_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 443
    :try_start_4
    new-instance v5, Ljava/io/FileOutputStream;

    invoke-direct {v5, v2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_6
    .catch Ljava/lang/OutOfMemoryError; {:try_start_4 .. :try_end_4} :catch_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    .line 446
    :try_start_5
    sget-object v1, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v6, 0x5a

    invoke-virtual {v4, v1, v6, v5}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move-result v1

    .line 448
    :try_start_6
    invoke-virtual {v5}, Ljava/io/OutputStream;->close()V

    .line 451
    if-eqz v1, :cond_6

    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v5

    const-string v6, "kbd_bg.jpg"

    invoke-direct {v1, v5, v6}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/io/File;->renameTo(Ljava/io/File;)Z
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_6 .. :try_end_6} :catch_6
    .catch Ljava/lang/OutOfMemoryError; {:try_start_6 .. :try_end_6} :catch_4
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    move-result v1

    if-nez v1, :cond_9

    .line 460
    :cond_6
    if-eqz v3, :cond_7

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_7

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 461
    :cond_7
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    goto/16 :goto_0

    .line 448
    :catchall_0
    move-exception v1

    :try_start_7
    invoke-virtual {v5}, Ljava/io/OutputStream;->close()V

    .line 449
    throw v1
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_7 .. :try_end_7} :catch_6
    .catch Ljava/lang/OutOfMemoryError; {:try_start_7 .. :try_end_7} :catch_4
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    .line 453
    :catch_0
    move-exception v1

    move-object v1, v2

    move-object v2, v3

    .line 460
    :goto_1
    if-eqz v2, :cond_8

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_8

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    .line 461
    :cond_8
    if-eqz v1, :cond_2

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    goto/16 :goto_0

    .line 452
    :cond_9
    const/4 v1, 0x2

    :try_start_8
    new-array v1, v1, [I

    const/4 v5, 0x0

    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v6

    aput v6, v1, v5

    const/4 v5, 0x1

    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    aput v4, v1, v5
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_8 .. :try_end_8} :catch_6
    .catch Ljava/lang/OutOfMemoryError; {:try_start_8 .. :try_end_8} :catch_4
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    .line 460
    if-eqz v3, :cond_a

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_a

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 461
    :cond_a
    if-eqz v2, :cond_b

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_b

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    :cond_b
    move-object v0, v1

    .line 452
    goto/16 :goto_0

    .line 455
    :catch_1
    move-exception v1

    move-object v2, v0

    move-object v3, v0

    .line 460
    :goto_2
    if-eqz v3, :cond_c

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_c

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 461
    :cond_c
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    goto/16 :goto_0

    .line 457
    :catch_2
    move-exception v1

    move-object v2, v0

    move-object v3, v0

    .line 460
    :goto_3
    if-eqz v3, :cond_d

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_d

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 461
    :cond_d
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    goto/16 :goto_0

    .line 460
    :catchall_1
    move-exception v1

    move-object v2, v0

    move-object v3, v0

    move-object v0, v1

    :goto_4
    if-eqz v3, :cond_e

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_e

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 461
    :cond_e
    if-eqz v2, :cond_f

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_f

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    .line 462
    :cond_f
    throw v0

    .line 460
    :catchall_2
    move-exception v1

    move-object v2, v0

    move-object v0, v1

    goto :goto_4

    :catchall_3
    move-exception v0

    goto :goto_4

    .line 457
    :catch_3
    move-exception v1

    move-object v2, v0

    goto :goto_3

    :catch_4
    move-exception v1

    goto :goto_3

    .line 455
    :catch_5
    move-exception v1

    move-object v2, v0

    goto :goto_2

    :catch_6
    move-exception v1

    goto :goto_2

    .line 453
    :catch_7
    move-exception v1

    move-object v1, v0

    move-object v2, v0

    goto/16 :goto_1

    :catch_8
    move-exception v1

    move-object v1, v0

    move-object v2, v3

    goto/16 :goto_1
.end method

.method static load(Landroid/content/Context;)Landroid/graphics/Bitmap;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 366
    :try_start_0
    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v2

    const-string v3, "kbd_bg.jpg"

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 367
    invoke-virtual {v1}, Ljava/io/File;->isFile()Z

    move-result v2

    if-nez v2, :cond_0

    .line 372
    :goto_0
    return-object v0

    .line 368
    :cond_0
    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 371
    :catch_0
    move-exception v1

    goto :goto_0

    .line 369
    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method static look(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;ZI)Lcom/mrkeyboard/app/MrBackdrop$Look;
    .locals 15

    .prologue
    .line 331
    if-eqz p0, :cond_0

    iget v2, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-nez v2, :cond_1

    :cond_0
    const/4 v2, 0x0

    .line 358
    :goto_0
    return-object v2

    .line 332
    :cond_1
    iget v2, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v3, 0x3

    if-ne v2, v3, :cond_2

    if-nez p1, :cond_2

    const/4 v2, 0x0

    goto :goto_0

    .line 333
    :cond_2
    const/4 v2, 0x1

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v9

    .line 334
    const/16 v2, 0x30

    sget-object v3, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v2, v9, v3}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v10

    .line 335
    new-instance v2, Landroid/graphics/Canvas;

    invoke-direct {v2, v10}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    const/16 v3, 0x30

    move-object/from16 v0, p1

    invoke-static {v2, p0, v3, v9, v0}, Lcom/mrkeyboard/app/MrBackdrop;->draw(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/MrBackdrop$Spec;IILandroid/graphics/Bitmap;)V

    .line 337
    const/4 v2, 0x1

    int-to-float v3, v9

    const v4, 0x3e2e147b    # 0.17f

    mul-float/2addr v3, v4

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    invoke-static {v9, v3}, Ljava/lang/Math;->min(II)I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v11

    .line 338
    const-wide/16 v6, 0x0

    const-wide/16 v4, 0x0

    .line 339
    const/4 v2, 0x0

    move v8, v2

    :goto_1
    if-ge v8, v9, :cond_5

    .line 340
    const/4 v2, 0x0

    move v14, v2

    move-wide v2, v4

    move v4, v14

    :goto_2
    const/16 v5, 0x30

    if-ge v4, v5, :cond_4

    .line 341
    invoke-virtual {v10, v4, v8}, Landroid/graphics/Bitmap;->getPixel(II)I

    move-result v5

    invoke-static {v5}, Lcom/mrkeyboard/app/MrThemeColors;->luminance(I)F

    move-result v5

    .line 342
    float-to-double v12, v5

    add-double/2addr v6, v12

    .line 343
    if-ge v8, v11, :cond_3

    float-to-double v12, v5

    add-double/2addr v2, v12

    .line 340
    :cond_3
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 339
    :cond_4
    add-int/lit8 v4, v8, 0x1

    move v8, v4

    move-wide v4, v2

    goto :goto_1

    .line 346
    :cond_5
    mul-int/lit8 v2, v9, 0x30

    int-to-double v2, v2

    div-double v2, v6, v2

    double-to-float v3, v2

    .line 347
    mul-int/lit8 v2, v11, 0x30

    int-to-double v6, v2

    div-double/2addr v4, v6

    double-to-float v4, v4

    .line 348
    move/from16 v0, p2

    move/from16 v1, p3

    invoke-static {v0, v3, v1}, Lcom/mrkeyboard/app/MrBackdrop;->veil(ZFI)F

    move-result v2

    move/from16 v0, p2

    move/from16 v1, p3

    invoke-static {v0, v4, v1}, Lcom/mrkeyboard/app/MrBackdrop;->veil(ZFI)F

    move-result v5

    invoke-static {v2, v5}, Ljava/lang/Math;->max(FF)F

    move-result v11

    .line 349
    if-eqz p2, :cond_6

    const/high16 v6, -0x1000000

    .line 350
    :goto_3
    const/4 v8, 0x0

    const/4 v7, 0x0

    const/4 v5, 0x0

    .line 351
    const/4 v2, 0x0

    :goto_4
    const/16 v12, 0x30

    if-ge v2, v12, :cond_7

    .line 352
    add-int/lit8 v12, v9, -0x1

    invoke-virtual {v10, v2, v12}, Landroid/graphics/Bitmap;->getPixel(II)I

    move-result v12

    .line 353
    shr-int/lit8 v13, v12, 0x10

    and-int/lit16 v13, v13, 0xff

    add-int/2addr v8, v13

    .line 354
    shr-int/lit8 v13, v12, 0x8

    and-int/lit16 v13, v13, 0xff

    add-int/2addr v7, v13

    .line 355
    and-int/lit16 v12, v12, 0xff

    add-int/2addr v5, v12

    .line 351
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    .line 349
    :cond_6
    const/4 v6, -0x1

    goto :goto_3

    .line 357
    :cond_7
    const/high16 v2, -0x1000000

    div-int/lit8 v8, v8, 0x30

    shl-int/lit8 v8, v8, 0x10

    or-int/2addr v2, v8

    div-int/lit8 v7, v7, 0x30

    shl-int/lit8 v7, v7, 0x8

    or-int/2addr v2, v7

    div-int/lit8 v5, v5, 0x30

    or-int/2addr v2, v5

    invoke-static {v2, v6, v11}, Lcom/mrkeyboard/app/MrBackdrop;->mix(IIF)I

    move-result v7

    .line 358
    new-instance v2, Lcom/mrkeyboard/app/MrBackdrop$Look;

    const/high16 v5, 0x437f0000    # 255.0f

    mul-float/2addr v5, v11

    invoke-static {v5}, Ljava/lang/Math;->round(F)I

    move-result v5

    invoke-direct/range {v2 .. v7}, Lcom/mrkeyboard/app/MrBackdrop$Look;-><init>(FFIII)V

    goto/16 :goto_0
.end method

.method static declared-synchronized lookNow(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Look;
    .locals 8

    .prologue
    const/4 v0, 0x0

    .line 513
    const-class v2, Lcom/mrkeyboard/app/MrBackdrop;

    monitor-enter v2

    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v3

    .line 514
    iget v1, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_1

    .line 528
    :cond_0
    :goto_0
    monitor-exit v2

    return-object v0

    .line 515
    :cond_1
    :try_start_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->darkNow(Landroid/content/Context;)Z

    move-result v4

    .line 516
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->soft(Landroid/content/Context;)I

    move-result v5

    .line 517
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->format()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v6, "|"

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v6, "|"

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 518
    sget-object v1, Lcom/mrkeyboard/app/MrBackdrop;->sLookKey:Ljava/lang/String;

    invoke-virtual {v6, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->sLook:Lcom/mrkeyboard/app/MrBackdrop$Look;

    goto :goto_0

    .line 520
    :cond_2
    iget v1, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v7, 0x3

    if-ne v1, v7, :cond_4

    .line 521
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->load(Landroid/content/Context;)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 522
    if-eqz v1, :cond_0

    .line 524
    :goto_1
    invoke-static {v3, v1, v4, v5}, Lcom/mrkeyboard/app/MrBackdrop;->look(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;ZI)Lcom/mrkeyboard/app/MrBackdrop$Look;

    move-result-object v0

    .line 525
    if-eqz v1, :cond_3

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 526
    :cond_3
    sput-object v6, Lcom/mrkeyboard/app/MrBackdrop;->sLookKey:Ljava/lang/String;

    .line 527
    sput-object v0, Lcom/mrkeyboard/app/MrBackdrop;->sLook:Lcom/mrkeyboard/app/MrBackdrop$Look;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 513
    :catchall_0
    move-exception v0

    monitor-exit v2

    throw v0

    :cond_4
    move-object v1, v0

    goto :goto_1
.end method

.method static mix(IIF)I
    .locals 4

    .prologue
    const/high16 v3, 0x3f800000    # 1.0f

    .line 323
    shr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    int-to-float v0, v0

    sub-float v1, v3, p2

    mul-float/2addr v0, v1

    shr-int/lit8 v1, p1, 0x10

    and-int/lit16 v1, v1, 0xff

    int-to-float v1, v1

    mul-float/2addr v1, p2

    add-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 324
    shr-int/lit8 v1, p0, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-float v1, v1

    sub-float v2, v3, p2

    mul-float/2addr v1, v2

    shr-int/lit8 v2, p1, 0x8

    and-int/lit16 v2, v2, 0xff

    int-to-float v2, v2

    mul-float/2addr v2, p2

    add-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    .line 325
    and-int/lit16 v2, p0, 0xff

    int-to-float v2, v2

    sub-float/2addr v3, p2

    mul-float/2addr v2, v3

    and-int/lit16 v3, p1, 0xff

    int-to-float v3, v3

    mul-float/2addr v3, p2

    add-float/2addr v2, v3

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    .line 326
    const/high16 v3, -0x1000000

    shl-int/lit8 v0, v0, 0x10

    or-int/2addr v0, v3

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    or-int/2addr v0, v2

    return v0
.end method

.method private static orientation(Ljava/io/File;)I
    .locals 4

    .prologue
    const/4 v0, 0x1

    .line 486
    :try_start_0
    new-instance v1, Landroid/media/ExifInterface;

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/media/ExifInterface;-><init>(Ljava/lang/String;)V

    const-string v2, "Orientation"

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v3}, Landroid/media/ExifInterface;->getAttributeInt(Ljava/lang/String;I)I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 488
    :goto_0
    return v0

    .line 487
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static pan(IIIIIIIFF)[I
    .locals 8

    .prologue
    .line 270
    invoke-static/range {p0 .. p6}, Lcom/mrkeyboard/app/MrBackdrop;->crop(IIIIIII)Landroid/graphics/Rect;

    move-result-object v0

    .line 271
    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    sub-int v1, p0, v1

    int-to-double v2, v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v1

    sub-int v1, p1, v1

    int-to-double v4, v1

    .line 273
    const-wide/high16 v6, 0x3fe0000000000000L    # 0.5

    cmpl-double v1, v2, v6

    if-lez v1, :cond_0

    if-lez p2, :cond_0

    .line 275
    iget v1, v0, Landroid/graphics/Rect;->left:I

    int-to-float v1, v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v6

    int-to-float v6, v6

    mul-float/2addr v6, p7

    int-to-float v7, p2

    div-float/2addr v6, v7

    sub-float/2addr v1, v6

    float-to-double v6, v1

    .line 276
    div-double v2, v6, v2

    const-wide/high16 v6, 0x4069000000000000L    # 200.0

    mul-double/2addr v2, v6

    const-wide/high16 v6, 0x4059000000000000L    # 100.0

    sub-double/2addr v2, v6

    invoke-static {v2, v3}, Ljava/lang/Math;->round(D)J

    move-result-wide v2

    long-to-int v1, v2

    const/16 v2, -0x64

    const/16 v3, 0x64

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result p5

    .line 278
    :cond_0
    const-wide/high16 v2, 0x3fe0000000000000L    # 0.5

    cmpl-double v1, v4, v2

    if-lez v1, :cond_1

    if-lez p3, :cond_1

    .line 279
    iget v1, v0, Landroid/graphics/Rect;->top:I

    int-to-float v1, v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v0

    int-to-float v0, v0

    mul-float v0, v0, p8

    int-to-float v2, p3

    div-float/2addr v0, v2

    sub-float v0, v1, v0

    float-to-double v0, v0

    .line 280
    div-double/2addr v0, v4

    const-wide/high16 v2, 0x4069000000000000L    # 200.0

    mul-double/2addr v0, v2

    const-wide/high16 v2, 0x4059000000000000L    # 100.0

    sub-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->round(D)J

    move-result-wide v0

    long-to-int v0, v0

    const/16 v1, -0x64

    const/16 v2, 0x64

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result p6

    .line 282
    :cond_1
    const/4 v0, 0x2

    new-array v0, v0, [I

    const/4 v1, 0x0

    aput p5, v0, v1

    const/4 v1, 0x1

    aput p6, v0, v1

    return-object v0
.end method

.method private static picture(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;II)V
    .locals 9

    .prologue
    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 231
    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    iget v4, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->zoom:I

    iget v5, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dx:I

    iget v6, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dy:I

    move v2, p3

    move v3, p4

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrBackdrop;->crop(IIIIIII)Landroid/graphics/Rect;

    move-result-object v0

    .line 232
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v8}, Landroid/graphics/Paint;-><init>(I)V

    .line 233
    invoke-virtual {v1, v8}, Landroid/graphics/Paint;->setFilterBitmap(Z)V

    .line 234
    new-instance v2, Landroid/graphics/Rect;

    invoke-direct {v2, v7, v7, p3, p4}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-virtual {p0, p2, v0, v2, v1}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    .line 235
    return-void
.end method

.method private static prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 1

    .prologue
    .line 192
    if-nez p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    goto :goto_0
.end method

.method static removeImage(Landroid/content/Context;)V
    .locals 3

    .prologue
    .line 396
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "kbd_bg.jpg"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 397
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->deleteOnExit()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 401
    :cond_0
    :goto_0
    return-void

    .line 398
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static sampleSize(II)I
    .locals 4

    .prologue
    .line 405
    invoke-static {p0, p1}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 406
    const/4 v0, 0x1

    .line 407
    :goto_0
    mul-int/lit8 v2, v0, 0x2

    div-int v2, v1, v2

    const/16 v3, 0x500

    if-lt v2, v3, :cond_0

    mul-int/lit8 v0, v0, 0x2

    goto :goto_0

    .line 408
    :cond_0
    return v0
.end method

.method static soft(Landroid/content/Context;)I
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 182
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 183
    if-nez v1, :cond_0

    .line 187
    :goto_0
    return v0

    .line 185
    :cond_0
    :try_start_0
    const-string v2, "pref_kbd_bg_soft"

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    const/4 v2, 0x0

    const/16 v3, 0x46

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 186
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static turn(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 493
    invoke-static {p1}, Lcom/mrkeyboard/app/MrBackdrop;->degrees(I)I

    move-result v0

    .line 494
    if-nez v0, :cond_0

    .line 497
    :goto_0
    return-object p0

    .line 495
    :cond_0
    new-instance v5, Landroid/graphics/Matrix;

    invoke-direct {v5}, Landroid/graphics/Matrix;-><init>()V

    .line 496
    int-to-float v0, v0

    invoke-virtual {v5, v0}, Landroid/graphics/Matrix;->postRotate(F)Z

    .line 497
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    const/4 v6, 0x1

    move-object v0, p0

    move v2, v1

    invoke-static/range {v0 .. v6}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object p0

    goto :goto_0
.end method

.method static veil(ZFI)F
    .locals 5

    .prologue
    const/high16 v4, 0x3f800000    # 1.0f

    const v3, 0x3f1eb852    # 0.62f

    const v2, 0x3ecccccd    # 0.4f

    .line 311
    const/4 v0, 0x0

    .line 312
    if-eqz p0, :cond_1

    .line 313
    cmpl-float v1, p1, v2

    if-lez v1, :cond_0

    div-float v0, v2, p1

    sub-float v0, v4, v0

    .line 317
    :cond_0
    :goto_0
    const/high16 v1, 0x3f400000    # 0.75f

    invoke-static {v0, v1}, Ljava/lang/Math;->min(FF)F

    move-result v0

    .line 318
    const/4 v1, 0x0

    const/16 v2, 0x46

    invoke-static {p2, v1, v2}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v1

    int-to-float v1, v1

    const/high16 v2, 0x42c80000    # 100.0f

    div-float/2addr v1, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    return v0

    .line 314
    :cond_1
    cmpg-float v1, p1, v3

    if-gez v1, :cond_0

    .line 315
    sub-float v0, v3, p1

    sub-float v1, v4, p1

    div-float/2addr v0, v1

    goto :goto_0
.end method
