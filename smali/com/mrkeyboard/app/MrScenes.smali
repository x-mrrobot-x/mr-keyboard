.class final Lcom/mrkeyboard/app/MrScenes;
.super Ljava/lang/Object;
.source "MrScenes.java"


# static fields
.field static final AI:I = 0x5

.field static final ANIMALS:I = 0x1

.field static final ANIME:I = 0x4

.field static final CATEGORIES:I = 0x6

.field static final COUNT:I = 0x30

.field private static final FOCUS:[I

.field static final NATURE:I = 0x3

.field static final PER_CATEGORY:I = 0x8

.field private static final SLUGS:[Ljava/lang/String;

.field static final SNOW:I = 0x2

.field static final SPORTS:I


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 32
    const/4 v0, 0x6

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "sports"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "animals"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "snow"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "nature"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "anime"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "ai"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrScenes;->SLUGS:[Ljava/lang/String;

    .line 35
    const/16 v0, 0x30

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/mrkeyboard/app/MrScenes;->FOCUS:[I

    return-void

    nop

    :array_0
    .array-data 4
        0x0
        -0x19
        0xa
        -0xf
        -0x23
        -0x19
        -0xa
        0x0
        0x0
        -0xa
        0x0
        -0x1e
        -0x28
        -0x1e
        0x0
        0x0
        0x1e
        0x0
        0x28
        0x0
        -0x14
        0xa
        0x1e
        0x0
        0x0
        -0x28
        0xa
        0x0
        0xa
        0x0
        0xa
        0x14
        -0xa
        0x0
        0x0
        0x0
        0x0
        -0x1e
        0x0
        0xa
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
        0xf
    .end array-data
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static category(I)I
    .locals 1

    .prologue
    .line 47
    invoke-static {p0}, Lcom/mrkeyboard/app/MrScenes;->valid(I)Z

    move-result v0

    if-eqz v0, :cond_0

    div-int/lit8 v0, p0, 0x8

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method static focus(I)I
    .locals 1

    .prologue
    .line 66
    invoke-static {p0}, Lcom/mrkeyboard/app/MrScenes;->valid(I)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrScenes;->FOCUS:[I

    aget v0, v0, p0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static load(Landroid/content/Context;I)Landroid/graphics/Bitmap;
    .locals 1

    .prologue
    .line 109
    const/4 v0, 0x1

    invoke-static {p0, p1, v0}, Lcom/mrkeyboard/app/MrScenes;->load(Landroid/content/Context;II)Landroid/graphics/Bitmap;

    move-result-object v0

    return-object v0
.end method

.method static load(Landroid/content/Context;II)Landroid/graphics/Bitmap;
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 81
    invoke-static {p1}, Lcom/mrkeyboard/app/MrScenes;->path(I)Ljava/lang/String;

    move-result-object v1

    .line 82
    if-eqz p0, :cond_0

    if-nez v1, :cond_1

    .line 96
    :cond_0
    :goto_0
    return-object v0

    .line 85
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    .line 86
    invoke-virtual {v2, v1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_5
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v1

    .line 87
    :try_start_1
    new-instance v2, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v2}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 88
    const/4 v3, 0x1

    invoke-static {v3, p2}, Ljava/lang/Math;->max(II)I

    move-result v3

    iput v3, v2, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 89
    sget-object v3, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v3, v2, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 90
    const/4 v3, 0x0

    invoke-static {v1, v3, v2}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_a
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_9
    .catch Ljava/lang/OutOfMemoryError; {:try_start_1 .. :try_end_1} :catch_8
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-object v0

    .line 98
    if-eqz v1, :cond_0

    .line 100
    :try_start_2
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 101
    :catch_0
    move-exception v1

    goto :goto_0

    .line 91
    :catch_1
    move-exception v1

    move-object v1, v0

    .line 98
    :goto_1
    if-eqz v1, :cond_0

    .line 100
    :try_start_3
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_0

    .line 101
    :catch_2
    move-exception v1

    goto :goto_0

    .line 93
    :catch_3
    move-exception v1

    move-object v1, v0

    .line 98
    :goto_2
    if-eqz v1, :cond_0

    .line 100
    :try_start_4
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_4

    goto :goto_0

    .line 101
    :catch_4
    move-exception v1

    goto :goto_0

    .line 95
    :catch_5
    move-exception v1

    move-object v1, v0

    .line 98
    :goto_3
    if-eqz v1, :cond_0

    .line 100
    :try_start_5
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_6

    goto :goto_0

    .line 101
    :catch_6
    move-exception v1

    goto :goto_0

    .line 98
    :catchall_0
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    :goto_4
    if-eqz v1, :cond_2

    .line 100
    :try_start_6
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_7

    .line 105
    :cond_2
    :goto_5
    throw v0

    .line 101
    :catch_7
    move-exception v1

    goto :goto_5

    .line 98
    :catchall_1
    move-exception v0

    goto :goto_4

    .line 95
    :catch_8
    move-exception v2

    goto :goto_3

    .line 93
    :catch_9
    move-exception v2

    goto :goto_2

    .line 91
    :catch_a
    move-exception v2

    goto :goto_1
.end method

.method static number(I)I
    .locals 1

    .prologue
    .line 52
    invoke-static {p0}, Lcom/mrkeyboard/app/MrScenes;->valid(I)Z

    move-result v0

    if-eqz v0, :cond_0

    rem-int/lit8 v0, p0, 0x8

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method static path(I)Ljava/lang/String;
    .locals 3

    .prologue
    .line 71
    invoke-static {p0}, Lcom/mrkeyboard/app/MrScenes;->valid(I)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 72
    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mr_scenes/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/mrkeyboard/app/MrScenes;->SLUGS:[Ljava/lang/String;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrScenes;->category(I)I

    move-result v2

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrScenes;->number(I)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".webp"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static scene(II)I
    .locals 1

    .prologue
    .line 57
    mul-int/lit8 v0, p0, 0x8

    add-int/2addr v0, p1

    return v0
.end method

.method static valid(I)Z
    .locals 1

    .prologue
    .line 61
    if-ltz p0, :cond_0

    const/16 v0, 0x30

    if-ge p0, v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
