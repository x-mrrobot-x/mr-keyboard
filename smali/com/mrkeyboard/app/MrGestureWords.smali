.class public final Lcom/mrkeyboard/app/MrGestureWords;
.super Ljava/lang/Object;
.source "MrGestureWords.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrGestureWords$Collector;
    }
.end annotation


# static fields
.field static final FREQ_HIGH:I = 0x82

.field static final FREQ_LOW:I = 0x64

.field static final FULL:I = 0xfa

.field static final LEARNED_MIN:I = 0x6

.field private static final MAX_BYTES:I = 0x3fffff

.field static final MAX_CHARS:I = 0x30

.field static final MAX_WORDS:I = 0x2710

.field private static sAt:I

.field private static sAuto:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference",
            "<",
            "Lcom/mrkeyboard/app/Dictionary;",
            ">;"
        }
    .end annotation
.end field

.field private static sBuffer:Ljava/nio/ByteBuffer;

.field private static final sChanges:Ljava/util/concurrent/atomic/AtomicInteger;

.field private static sLastNs:J

.field private static sMade:Z

.field private static sUser:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference",
            "<",
            "Lcom/mrkeyboard/app/Dictionary;",
            ">;"
        }
    .end annotation
.end field

.field private static sWords:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 49
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrGestureWords;->sChanges:Ljava/util/concurrent/atomic/AtomicInteger;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static build([Ljava/lang/String;[II)Ljava/nio/ByteBuffer;
    .locals 20

    .prologue
    .line 228
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    if-gtz p2, :cond_1

    :cond_0
    const/4 v2, 0x0

    .line 334
    :goto_0
    return-object v2

    .line 230
    :cond_1
    const/16 v11, 0x40

    .line 231
    new-array v10, v11, [C

    .line 232
    new-array v9, v11, [I

    new-array v8, v11, [I

    new-array v7, v11, [I

    new-array v6, v11, [I

    new-array v5, v11, [I

    .line 233
    const/4 v4, 0x1

    .line 234
    const/4 v2, 0x0

    const/4 v3, -0x1

    aput v3, v5, v2

    .line 235
    const/4 v13, 0x0

    .line 236
    const/4 v2, 0x0

    move v15, v2

    :goto_1
    move/from16 v0, p2

    if-ge v15, v0, :cond_9

    .line 237
    aget-object v16, p0, v15

    .line 238
    if-eqz v16, :cond_26

    invoke-virtual/range {v16 .. v16}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_26

    invoke-virtual/range {v16 .. v16}, Ljava/lang/String;->length()I

    move-result v2

    const/16 v3, 0x30

    if-le v2, v3, :cond_2

    move v2, v13

    .line 236
    :goto_2
    add-int/lit8 v3, v15, 0x1

    move v15, v3

    move v13, v2

    goto :goto_1

    .line 239
    :cond_2
    const/4 v3, 0x0

    .line 240
    const/4 v14, 0x1

    .line 241
    const/4 v2, 0x0

    :goto_3
    invoke-virtual/range {v16 .. v16}, Ljava/lang/String;->length()I

    move-result v12

    if-ge v2, v12, :cond_25

    .line 242
    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v17

    .line 243
    aget v12, v9, v3

    .line 244
    :goto_4
    if-eqz v12, :cond_3

    aget-char v18, v10, v12

    move/from16 v0, v18

    move/from16 v1, v17

    if-eq v0, v1, :cond_3

    aget v12, v7, v12

    goto :goto_4

    .line 245
    :cond_3
    if-nez v12, :cond_24

    .line 246
    aget v12, v6, v3

    const/16 v18, 0xff

    move/from16 v0, v18

    if-lt v12, v0, :cond_4

    .line 247
    const/4 v2, 0x0

    .line 269
    :goto_5
    if-nez v2, :cond_7

    move v2, v13

    goto :goto_2

    .line 250
    :cond_4
    if-ne v4, v11, :cond_5

    .line 251
    mul-int/lit8 v11, v11, 0x2

    .line 252
    invoke-static {v10, v11}, Ljava/util/Arrays;->copyOf([CI)[C

    move-result-object v10

    .line 253
    invoke-static {v9, v11}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v9

    .line 254
    invoke-static {v8, v11}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v8

    .line 255
    invoke-static {v7, v11}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v7

    .line 256
    invoke-static {v6, v11}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v6

    .line 257
    invoke-static {v5, v11}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v5

    .line 259
    :cond_5
    add-int/lit8 v12, v4, 0x1

    .line 260
    aput-char v17, v10, v4

    .line 261
    const/16 v17, 0x0

    aput v17, v6, v4

    aput v17, v7, v4

    aput v17, v8, v4

    aput v17, v9, v4

    .line 262
    const/16 v17, -0x1

    aput v17, v5, v4

    .line 263
    aget v17, v9, v3

    if-nez v17, :cond_6

    aput v4, v9, v3

    .line 264
    :goto_6
    aput v4, v8, v3

    .line 265
    aget v17, v6, v3

    add-int/lit8 v17, v17, 0x1

    aput v17, v6, v3

    move v3, v4

    move v4, v12

    .line 241
    :goto_7
    add-int/lit8 v2, v2, 0x1

    goto :goto_3

    .line 263
    :cond_6
    aget v17, v8, v3

    aput v4, v7, v17

    goto :goto_6

    .line 270
    :cond_7
    aget v2, p1, v15

    invoke-static {v2}, Lcom/mrkeyboard/app/MrGestureWords;->freq(I)I

    move-result v2

    .line 271
    aget v12, v5, v3

    if-le v2, v12, :cond_8

    aput v2, v5, v3

    .line 272
    :cond_8
    add-int/lit8 v2, v13, 0x1

    goto/16 :goto_2

    .line 274
    :cond_9
    if-nez v13, :cond_a

    const/4 v2, 0x0

    goto/16 :goto_0

    .line 276
    :cond_a
    new-array v13, v4, [Z

    .line 277
    new-array v6, v4, [I

    .line 278
    const/4 v2, 0x0

    move v3, v2

    :goto_8
    if-ge v3, v4, :cond_c

    aget v2, v9, v3

    :goto_9
    if-eqz v2, :cond_b

    aput v3, v6, v2

    aget v2, v7, v2

    goto :goto_9

    :cond_b
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    goto :goto_8

    .line 279
    :cond_c
    add-int/lit8 v2, v4, -0x1

    :goto_a
    const/4 v3, 0x1

    if-lt v2, v3, :cond_f

    .line 280
    aget v3, v5, v2

    if-ltz v3, :cond_d

    const/4 v3, 0x1

    aput-boolean v3, v13, v2

    .line 281
    :cond_d
    aget-boolean v3, v13, v2

    if-eqz v3, :cond_e

    aget v3, v6, v2

    const/4 v8, 0x1

    aput-boolean v8, v13, v3

    .line 279
    :cond_e
    add-int/lit8 v2, v2, -0x1

    goto :goto_a

    .line 284
    :cond_f
    new-array v14, v4, [I

    new-array v15, v4, [I

    .line 285
    const/4 v6, 0x1

    const/4 v4, 0x2

    .line 286
    const/4 v2, 0x0

    move v11, v2

    :goto_b
    if-ge v11, v6, :cond_19

    .line 287
    aget v8, v15, v11

    .line 288
    const/4 v3, 0x0

    .line 289
    aget v2, v9, v8

    move/from16 v19, v2

    move v2, v3

    move/from16 v3, v19

    :goto_c
    if-eqz v3, :cond_11

    aget-boolean v12, v13, v3

    if-eqz v12, :cond_10

    add-int/lit8 v2, v2, 0x1

    :cond_10
    aget v3, v7, v3

    goto :goto_c

    .line 290
    :cond_11
    if-nez v2, :cond_13

    .line 286
    :cond_12
    add-int/lit8 v2, v11, 0x1

    move v11, v2

    goto :goto_b

    .line 291
    :cond_13
    aput v4, v14, v8

    .line 292
    add-int/lit8 v4, v4, 0x1

    .line 293
    aget v2, v9, v8

    move v8, v2

    :goto_d
    if-eqz v8, :cond_18

    .line 294
    aget-boolean v2, v13, v8

    if-nez v2, :cond_14

    move v2, v4

    move v3, v6

    .line 293
    :goto_e
    aget v4, v7, v8

    move v8, v4

    move v6, v3

    move v4, v2

    goto :goto_d

    .line 295
    :cond_14
    aget-char v2, v10, v8

    const/16 v3, 0xff

    if-lt v2, v3, :cond_15

    const/4 v2, 0x3

    :goto_f
    invoke-static {v8, v9, v7, v13}, Lcom/mrkeyboard/app/MrGestureWords;->hasLiveKid(I[I[I[Z)Z

    move-result v3

    if-eqz v3, :cond_16

    const/4 v3, 0x3

    :goto_10
    add-int/2addr v3, v2

    aget v2, v5, v8

    if-ltz v2, :cond_17

    const/4 v2, 0x2

    :goto_11
    add-int/2addr v2, v3

    add-int/2addr v2, v4

    .line 296
    add-int/lit8 v3, v6, 0x1

    aput v8, v15, v6

    goto :goto_e

    .line 295
    :cond_15
    const/4 v2, 0x1

    goto :goto_f

    :cond_16
    const/4 v3, 0x1

    goto :goto_10

    :cond_17
    const/4 v2, 0x0

    goto :goto_11

    .line 298
    :cond_18
    const v2, 0x3fffff

    if-le v4, v2, :cond_12

    const/4 v2, 0x0

    goto/16 :goto_0

    .line 300
    :cond_19
    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v8

    .line 301
    const/4 v2, 0x0

    const/16 v3, -0x38

    invoke-virtual {v8, v2, v3}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    .line 302
    const/4 v2, 0x1

    const/4 v3, 0x1

    invoke-virtual {v8, v2, v3}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    .line 303
    const/4 v2, 0x0

    move v12, v2

    :goto_12
    if-ge v12, v6, :cond_23

    .line 304
    aget v4, v15, v12

    .line 305
    aget v2, v14, v4

    if-nez v2, :cond_1b

    .line 303
    :cond_1a
    add-int/lit8 v2, v12, 0x1

    move v12, v2

    goto :goto_12

    .line 306
    :cond_1b
    aget v11, v14, v4

    const/4 v3, 0x0

    .line 307
    aget v2, v9, v4

    move/from16 v19, v2

    move v2, v3

    move/from16 v3, v19

    :goto_13
    if-eqz v3, :cond_1d

    aget-boolean v16, v13, v3

    if-eqz v16, :cond_1c

    add-int/lit8 v2, v2, 0x1

    :cond_1c
    aget v3, v7, v3

    goto :goto_13

    .line 308
    :cond_1d
    add-int/lit8 v3, v11, 0x1

    int-to-byte v2, v2

    invoke-virtual {v8, v11, v2}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    .line 309
    aget v2, v9, v4

    move v11, v2

    :goto_14
    if-eqz v11, :cond_1a

    .line 310
    aget-boolean v2, v13, v11

    if-nez v2, :cond_1f

    move v2, v3

    .line 309
    :cond_1e
    :goto_15
    aget v3, v7, v11

    move v11, v3

    move v3, v2

    goto :goto_14

    .line 311
    :cond_1f
    aget-char v4, v10, v11

    .line 312
    const/16 v2, 0xff

    if-lt v4, v2, :cond_20

    .line 313
    add-int/lit8 v2, v3, 0x1

    const/16 v16, -0x1

    move/from16 v0, v16

    invoke-virtual {v8, v3, v0}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    .line 314
    add-int/lit8 v3, v2, 0x1

    shr-int/lit8 v16, v4, 0x8

    move/from16 v0, v16

    int-to-byte v0, v0

    move/from16 v16, v0

    move/from16 v0, v16

    invoke-virtual {v8, v2, v0}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    .line 315
    add-int/lit8 v2, v3, 0x1

    int-to-byte v4, v4

    invoke-virtual {v8, v3, v4}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    .line 319
    :goto_16
    aget v3, v5, v11

    if-ltz v3, :cond_21

    const/16 v3, 0x80

    .line 320
    :goto_17
    aget v4, v14, v11

    .line 321
    if-eqz v4, :cond_22

    .line 322
    add-int/lit8 v16, v2, 0x1

    or-int/lit8 v3, v3, 0x40

    shr-int/lit8 v17, v4, 0x10

    or-int v3, v3, v17

    int-to-byte v3, v3

    invoke-virtual {v8, v2, v3}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    .line 323
    add-int/lit8 v3, v16, 0x1

    shr-int/lit8 v2, v4, 0x8

    int-to-byte v2, v2

    move/from16 v0, v16

    invoke-virtual {v8, v0, v2}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    .line 324
    add-int/lit8 v2, v3, 0x1

    int-to-byte v4, v4

    invoke-virtual {v8, v3, v4}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    .line 328
    :goto_18
    aget v3, v5, v11

    if-ltz v3, :cond_1e

    .line 329
    add-int/lit8 v3, v2, 0x1

    aget v4, v5, v11

    int-to-byte v4, v4

    invoke-virtual {v8, v2, v4}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    .line 330
    add-int/lit8 v2, v3, 0x1

    const/4 v4, 0x0

    invoke-virtual {v8, v3, v4}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    goto :goto_15

    .line 317
    :cond_20
    add-int/lit8 v2, v3, 0x1

    int-to-byte v4, v4

    invoke-virtual {v8, v3, v4}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    goto :goto_16

    .line 319
    :cond_21
    const/4 v3, 0x0

    goto :goto_17

    .line 326
    :cond_22
    add-int/lit8 v4, v2, 0x1

    int-to-byte v3, v3

    invoke-virtual {v8, v2, v3}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    move v2, v4

    goto :goto_18

    :cond_23
    move-object v2, v8

    .line 334
    goto/16 :goto_0

    :cond_24
    move v3, v12

    goto/16 :goto_7

    :cond_25
    move v2, v14

    goto/16 :goto_5

    :cond_26
    move v2, v13

    goto/16 :goto_2
.end method

.method public static changed()V
    .locals 1

    .prologue
    .line 56
    sget-object v0, Lcom/mrkeyboard/app/MrGestureWords;->sChanges:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 57
    return-void
.end method

.method static freq(I)I
    .locals 1

    .prologue
    .line 143
    const/16 v0, 0xfa

    if-lt p0, v0, :cond_0

    const/16 v0, 0x82

    .line 145
    :goto_0
    return v0

    .line 144
    :cond_0
    const/4 v0, 0x6

    if-gt p0, v0, :cond_1

    const/16 v0, 0x64

    goto :goto_0

    .line 145
    :cond_1
    add-int/lit8 v0, p0, -0x6

    mul-int/lit8 v0, v0, 0x1e

    div-int/lit16 v0, v0, 0xf4

    add-int/lit8 v0, v0, 0x64

    goto :goto_0
.end method

.method static declared-synchronized get(Lcom/mrkeyboard/app/LatinIME;)Ljava/nio/ByteBuffer;
    .locals 14

    .prologue
    const/4 v2, 0x1

    const/4 v6, 0x0

    const/4 v5, 0x0

    .line 75
    const-class v7, Lcom/mrkeyboard/app/MrGestureWords;

    monitor-enter v7

    if-eqz p0, :cond_0

    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrSuggest()Lcom/mrkeyboard/app/Suggest;

    move-result-object v3

    move-object v4, v3

    .line 76
    :goto_0
    if-eqz v4, :cond_1

    invoke-virtual {v4}, Lcom/mrkeyboard/app/Suggest;->mrAutoDict()Lcom/mrkeyboard/app/Dictionary;

    move-result-object v3

    .line 77
    :goto_1
    if-eqz v4, :cond_2

    invoke-virtual {v4}, Lcom/mrkeyboard/app/Suggest;->mrUserDict()Lcom/mrkeyboard/app/Dictionary;

    move-result-object v4

    .line 78
    :goto_2
    sget-object v8, Lcom/mrkeyboard/app/MrGestureWords;->sChanges:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v8}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v8

    .line 79
    sget-boolean v9, Lcom/mrkeyboard/app/MrGestureWords;->sMade:Z

    if-eqz v9, :cond_3

    sget-object v9, Lcom/mrkeyboard/app/MrGestureWords;->sAuto:Ljava/lang/ref/WeakReference;

    invoke-static {v9, v3}, Lcom/mrkeyboard/app/MrGestureWords;->is(Ljava/lang/ref/WeakReference;Lcom/mrkeyboard/app/Dictionary;)Z

    move-result v9

    if-eqz v9, :cond_3

    sget-object v9, Lcom/mrkeyboard/app/MrGestureWords;->sUser:Ljava/lang/ref/WeakReference;

    invoke-static {v9, v4}, Lcom/mrkeyboard/app/MrGestureWords;->is(Ljava/lang/ref/WeakReference;Lcom/mrkeyboard/app/Dictionary;)Z

    move-result v9

    if-eqz v9, :cond_3

    .line 80
    :goto_3
    if-eqz v2, :cond_4

    sget v9, Lcom/mrkeyboard/app/MrGestureWords;->sAt:I

    if-ne v8, v9, :cond_4

    sget-object v5, Lcom/mrkeyboard/app/MrGestureWords;->sBuffer:Ljava/nio/ByteBuffer;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 100
    :goto_4
    monitor-exit v7

    return-object v5

    :cond_0
    move-object v4, v5

    .line 75
    goto :goto_0

    :cond_1
    move-object v3, v5

    .line 76
    goto :goto_1

    :cond_2
    move-object v4, v5

    .line 77
    goto :goto_2

    :cond_3
    move v2, v6

    .line 79
    goto :goto_3

    .line 81
    :cond_4
    :try_start_1
    invoke-static {v3}, Lcom/mrkeyboard/app/MrGestureWords;->loading(Lcom/mrkeyboard/app/Dictionary;)Z

    move-result v9

    if-nez v9, :cond_5

    invoke-static {v4}, Lcom/mrkeyboard/app/MrGestureWords;->loading(Lcom/mrkeyboard/app/Dictionary;)Z

    move-result v9

    if-eqz v9, :cond_7

    :cond_5
    if-eqz v2, :cond_6

    sget-object v2, Lcom/mrkeyboard/app/MrGestureWords;->sBuffer:Ljava/nio/ByteBuffer;

    :goto_5
    move-object v5, v2

    goto :goto_4

    :cond_6
    move-object v2, v5

    goto :goto_5

    .line 82
    :cond_7
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v10

    .line 83
    new-instance v9, Lcom/mrkeyboard/app/MrGestureWords$Collector;

    invoke-direct {v9}, Lcom/mrkeyboard/app/MrGestureWords$Collector;-><init>()V

    .line 84
    instance-of v2, v3, Lcom/mrkeyboard/app/ExpandableDictionary;

    if-eqz v2, :cond_8

    move-object v0, v3

    check-cast v0, Lcom/mrkeyboard/app/ExpandableDictionary;

    move-object v2, v0

    invoke-virtual {v2}, Lcom/mrkeyboard/app/ExpandableDictionary;->mrRoots()Lcom/mrkeyboard/app/ExpandableDictionary$NodeArray;

    move-result-object v2

    const/4 v12, 0x6

    invoke-virtual {v9, v2, v12}, Lcom/mrkeyboard/app/MrGestureWords$Collector;->read(Lcom/mrkeyboard/app/ExpandableDictionary$NodeArray;I)V

    .line 85
    :cond_8
    instance-of v2, v4, Lcom/mrkeyboard/app/ExpandableDictionary;

    if-eqz v2, :cond_9

    move-object v0, v4

    check-cast v0, Lcom/mrkeyboard/app/ExpandableDictionary;

    move-object v2, v0

    invoke-virtual {v2}, Lcom/mrkeyboard/app/ExpandableDictionary;->mrRoots()Lcom/mrkeyboard/app/ExpandableDictionary$NodeArray;

    move-result-object v2

    const/4 v12, 0x0

    invoke-virtual {v9, v2, v12}, Lcom/mrkeyboard/app/MrGestureWords$Collector;->read(Lcom/mrkeyboard/app/ExpandableDictionary$NodeArray;I)V

    .line 86
    :cond_9
    const/16 v2, 0x2710

    invoke-virtual {v9, v2}, Lcom/mrkeyboard/app/MrGestureWords$Collector;->keepBest(I)V

    .line 87
    iget-object v2, v9, Lcom/mrkeyboard/app/MrGestureWords$Collector;->words:[Ljava/lang/String;

    iget-object v12, v9, Lcom/mrkeyboard/app/MrGestureWords$Collector;->freqs:[I

    iget v13, v9, Lcom/mrkeyboard/app/MrGestureWords$Collector;->n:I

    invoke-static {v2, v12, v13}, Lcom/mrkeyboard/app/MrGestureWords;->build([Ljava/lang/String;[II)Ljava/nio/ByteBuffer;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrGestureWords;->sBuffer:Ljava/nio/ByteBuffer;

    .line 88
    sget-object v2, Lcom/mrkeyboard/app/MrGestureWords;->sBuffer:Ljava/nio/ByteBuffer;

    if-eqz v2, :cond_a

    iget v2, v9, Lcom/mrkeyboard/app/MrGestureWords$Collector;->n:I

    :goto_6
    sput v2, Lcom/mrkeyboard/app/MrGestureWords;->sWords:I

    .line 89
    new-instance v2, Ljava/lang/ref/WeakReference;

    invoke-direct {v2, v3}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v2, Lcom/mrkeyboard/app/MrGestureWords;->sAuto:Ljava/lang/ref/WeakReference;

    .line 90
    new-instance v2, Ljava/lang/ref/WeakReference;

    invoke-direct {v2, v4}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v2, Lcom/mrkeyboard/app/MrGestureWords;->sUser:Ljava/lang/ref/WeakReference;

    .line 91
    sput v8, Lcom/mrkeyboard/app/MrGestureWords;->sAt:I

    .line 92
    const/4 v2, 0x1

    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureWords;->sMade:Z

    .line 93
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v2

    sub-long/2addr v2, v10

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureWords;->sLastNs:J

    .line 94
    sget-object v5, Lcom/mrkeyboard/app/MrGestureWords;->sBuffer:Ljava/nio/ByteBuffer;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_4

    :cond_a
    move v2, v6

    .line 88
    goto :goto_6

    .line 95
    :catch_0
    move-exception v2

    .line 97
    const/4 v2, 0x0

    :try_start_2
    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureWords;->sMade:Z

    .line 98
    const/4 v2, 0x0

    sput-object v2, Lcom/mrkeyboard/app/MrGestureWords;->sBuffer:Ljava/nio/ByteBuffer;

    .line 99
    const/4 v2, 0x0

    sput v2, Lcom/mrkeyboard/app/MrGestureWords;->sWords:I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto/16 :goto_4

    .line 75
    :catchall_0
    move-exception v2

    monitor-exit v7

    throw v2
.end method

.method private static hasLiveKid(I[I[I[Z)Z
    .locals 2

    .prologue
    .line 338
    aget v0, p1, p0

    :goto_0
    if-eqz v0, :cond_1

    aget-boolean v1, p3, v0

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    .line 339
    :goto_1
    return v0

    .line 338
    :cond_0
    aget v0, p2, v0

    goto :goto_0

    .line 339
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private static is(Ljava/lang/ref/WeakReference;Lcom/mrkeyboard/app/Dictionary;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/ref/WeakReference",
            "<",
            "Lcom/mrkeyboard/app/Dictionary;",
            ">;",
            "Lcom/mrkeyboard/app/Dictionary;",
            ")Z"
        }
    .end annotation

    .prologue
    .line 105
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-ne v0, p1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static loading(Lcom/mrkeyboard/app/Dictionary;)Z
    .locals 1

    .prologue
    .line 110
    instance-of v0, p0, Lcom/mrkeyboard/app/ExpandableDictionary;

    if-eqz v0, :cond_0

    check-cast p0, Lcom/mrkeyboard/app/ExpandableDictionary;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/ExpandableDictionary;->reloadDictionaryIfRequired()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static declared-synchronized release()V
    .locals 2

    .prologue
    .line 124
    const-class v1, Lcom/mrkeyboard/app/MrGestureWords;

    monitor-enter v1

    const/4 v0, 0x0

    :try_start_0
    sput-object v0, Lcom/mrkeyboard/app/MrGestureWords;->sUser:Ljava/lang/ref/WeakReference;

    sput-object v0, Lcom/mrkeyboard/app/MrGestureWords;->sAuto:Ljava/lang/ref/WeakReference;

    .line 125
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureWords;->sMade:Z

    .line 126
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureWords;->sBuffer:Ljava/nio/ByteBuffer;

    .line 127
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrGestureWords;->sWords:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 128
    monitor-exit v1

    return-void

    .line 124
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static declared-synchronized resetForTest()V
    .locals 4

    .prologue
    .line 132
    const-class v1, Lcom/mrkeyboard/app/MrGestureWords;

    monitor-enter v1

    const/4 v0, 0x0

    :try_start_0
    sput-object v0, Lcom/mrkeyboard/app/MrGestureWords;->sUser:Ljava/lang/ref/WeakReference;

    sput-object v0, Lcom/mrkeyboard/app/MrGestureWords;->sAuto:Ljava/lang/ref/WeakReference;

    .line 133
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureWords;->sMade:Z

    .line 134
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureWords;->sBuffer:Ljava/nio/ByteBuffer;

    .line 135
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrGestureWords;->sWords:I

    .line 136
    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureWords;->sLastNs:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 137
    monitor-exit v1

    return-void

    .line 132
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static declared-synchronized stats()[J
    .locals 6

    .prologue
    .line 115
    const-class v2, Lcom/mrkeyboard/app/MrGestureWords;

    monitor-enter v2

    const/4 v0, 0x3

    :try_start_0
    new-array v3, v0, [J

    const/4 v0, 0x0

    sget v1, Lcom/mrkeyboard/app/MrGestureWords;->sWords:I

    int-to-long v4, v1

    aput-wide v4, v3, v0

    const/4 v0, 0x1

    sget-wide v4, Lcom/mrkeyboard/app/MrGestureWords;->sLastNs:J

    aput-wide v4, v3, v0

    const/4 v4, 0x2

    sget-object v0, Lcom/mrkeyboard/app/MrGestureWords;->sBuffer:Ljava/nio/ByteBuffer;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrGestureWords;->sBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v0

    int-to-long v0, v0

    :goto_0
    aput-wide v0, v3, v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v2

    return-object v3

    :cond_0
    const-wide/16 v0, 0x0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v2

    throw v0
.end method
