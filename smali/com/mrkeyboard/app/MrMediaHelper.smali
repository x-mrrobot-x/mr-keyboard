.class final Lcom/mrkeyboard/app/MrMediaHelper;
.super Ljava/lang/Object;
.source "MrMediaHelper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrMediaHelper$Api29;,
        Lcom/mrkeyboard/app/MrMediaHelper$Api25;
    }
.end annotation


# static fields






# direct methods
.method private constructor <init>()V
    .registers 1

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static commitImage(Landroid/view/inputmethod/InputConnection;Landroid/view/inputmethod/EditorInfo;Landroid/net/Uri;Landroid/content/ClipDescription;)Z
    .registers 7

    .line 33
    const/4 v0, 0x0

    if-eqz p0, :cond_45

    if-eqz p1, :cond_45

    if-eqz p2, :cond_45

    if-nez p3, :cond_a

    goto :goto_45

    .line 36
    :cond_a
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrMediaHelper$Api25;->commit(Landroid/view/inputmethod/InputConnection;Landroid/view/inputmethod/EditorInfo;Landroid/net/Uri;Landroid/content/ClipDescription;)Z

    move-result p0

    return p0

    .line 34
    :cond_45
    :goto_45
    return v0
.end method

.method static loadThumb(Landroid/content/ContentResolver;Landroid/net/Uri;)Landroid/graphics/Bitmap;
    .registers 8

    .line 66
    const/4 v0, 0x0

    if-eqz p0, :cond_7f

    if-nez p1, :cond_7

    goto/16 :goto_7f

    .line 69
    :cond_7
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1d

    if-lt v1, v2, :cond_16

    .line 71
    :try_start_d
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrMediaHelper$Api29;->loadThumbnail(Landroid/content/ContentResolver;Landroid/net/Uri;)Landroid/graphics/Bitmap;

    move-result-object v1
    :try_end_11
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_11} :catch_15

    .line 72
    if-eqz v1, :cond_14

    .line 73
    return-object v1

    .line 76
    :cond_14
    goto :goto_16

    .line 75
    :catch_15
    move-exception v1

    .line 78
    :cond_16
    :goto_16
    new-instance v1, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v1}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 79
    const/4 v2, 0x1

    iput-boolean v2, v1, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 80
    :try_start_1e
    invoke-virtual {p0, p1}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v3

    .line 81
    if-nez v3, :cond_2b

    .line 82
    nop

    .line 85
    if-eqz v3, :cond_2a

    invoke-virtual {v3}, Ljava/io/InputStream;->close()V
    :try_end_2a
    .catch Ljava/io/IOException; {:try_start_1e .. :try_end_2a} :catch_7d

    .line 82
    :cond_2a
    return-object v0

    .line 84
    :cond_2b
    :try_start_2b
    invoke-static {v3, v0, v1}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;
    :try_end_2e
    .catchall {:try_start_2b .. :try_end_2e} :catchall_71

    .line 85
    if-eqz v3, :cond_33

    :try_start_30
    invoke-virtual {v3}, Ljava/io/InputStream;->close()V
    :try_end_33
    .catch Ljava/io/IOException; {:try_start_30 .. :try_end_33} :catch_7d

    .line 87
    :cond_33
    nop

    .line 88
    iget v3, v1, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    .line 89
    if-gtz v3, :cond_39

    .line 90
    return-object v0

    .line 92
    :cond_39
    nop

    .line 93
    :goto_3a
    div-int v4, v3, v2

    const/16 v5, 0x12c

    if-le v4, v5, :cond_43

    .line 94
    mul-int/lit8 v2, v2, 0x2

    goto :goto_3a

    .line 96
    :cond_43
    const/4 v3, 0x0

    iput-boolean v3, v1, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 97
    iput v2, v1, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 98
    sget-object v2, Landroid/graphics/Bitmap$Config;->RGB_565:Landroid/graphics/Bitmap$Config;

    iput-object v2, v1, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 99
    :try_start_4c
    invoke-virtual {p0, p1}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object p0

    .line 100
    if-nez p0, :cond_59

    .line 101
    nop

    .line 104
    if-eqz p0, :cond_58

    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_58
    .catch Ljava/io/IOException; {:try_start_4c .. :try_end_58} :catch_6f

    .line 101
    :cond_58
    return-object v0

    .line 103
    :cond_59
    :try_start_59
    invoke-static {p0, v0, v1}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object p1
    :try_end_5d
    .catchall {:try_start_59 .. :try_end_5d} :catchall_63

    .line 104
    if-eqz p0, :cond_62

    :try_start_5f
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_62
    .catch Ljava/io/IOException; {:try_start_5f .. :try_end_62} :catch_6f

    .line 103
    :cond_62
    return-object p1

    .line 99
    :catchall_63
    move-exception p1

    if-eqz p0, :cond_6e

    :try_start_66
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_69
    .catchall {:try_start_66 .. :try_end_69} :catchall_6a

    goto :goto_6e

    :catchall_6a
    move-exception p0

    :try_start_6b
    invoke-virtual {p1, p0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_6e
    :goto_6e
    throw p1
    :try_end_6f
    .catch Ljava/io/IOException; {:try_start_6b .. :try_end_6f} :catch_6f

    .line 104
    :catch_6f
    move-exception p0

    .line 105
    return-object v0

    .line 80
    :catchall_71
    move-exception p0

    if-eqz v3, :cond_7c

    :try_start_74
    invoke-virtual {v3}, Ljava/io/InputStream;->close()V
    :try_end_77
    .catchall {:try_start_74 .. :try_end_77} :catchall_78

    goto :goto_7c

    :catchall_78
    move-exception p1

    :try_start_79
    invoke-virtual {p0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_7c
    :goto_7c
    throw p0
    :try_end_7d
    .catch Ljava/io/IOException; {:try_start_79 .. :try_end_7d} :catch_7d

    .line 85
    :catch_7d
    move-exception p0

    .line 86
    return-object v0

    .line 67
    :cond_7f
    :goto_7f
    return-object v0
.end method

.method static matchesAnyMime(Landroid/content/ClipDescription;[Ljava/lang/String;)Z
    .registers 6

    .line 54
    const/4 v0, 0x0

    if-nez p1, :cond_4

    .line 55
    return v0

    .line 57
    :cond_4
    array-length v1, p1

    move v2, v0

    :goto_6
    if-ge v2, v1, :cond_17

    aget-object v3, p1, v2

    .line 58
    if-eqz v3, :cond_14

    invoke-virtual {p0, v3}, Landroid/content/ClipDescription;->hasMimeType(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_14

    .line 59
    const/4 p0, 0x1

    return p0

    .line 57
    :cond_14
    add-int/lit8 v2, v2, 0x1

    goto :goto_6

    .line 62
    :cond_17
    return v0
.end method
