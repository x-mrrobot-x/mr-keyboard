.class public final Lcom/mrkeyboard/app/MrNative;
.super Ljava/lang/Object;
.source "MrNative.java"


# static fields
.field static final ENGINE_VERSION:I = 0x3

.field static final INFO_SIZE:I = 0xb

.field private static final OFF:I = -0x1

.field private static final READY:I = 0x1

.field static final RESULT_CHARS:I = 0x62

.field private static final UNKNOWN:I

.field private static sPreloading:Z

.field private static sPushed:Lcom/mrkeyboard/app/MrRules;

.field private static volatile sState:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 37
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrNative;->sState:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Z
    .locals 1

    .prologue
    .line 22
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->load()Z

    move-result v0

    return v0
.end method

.method static baseTable()[C
    .locals 4

    .prologue
    const/16 v3, 0x100

    .line 107
    new-array v1, v3, [C

    .line 108
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v3, :cond_0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    aput-char v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 109
    :cond_0
    return-object v1
.end method

.method static costs()[I
    .locals 1

    .prologue
    .line 83
    const/16 v0, 0x11

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    return-object v0

    :array_0
    .array-data 4
        0x19
        0x1e
        0x23
        0x1e
        0x19
        0x2d
        0x4b
        0x3c
        0x1e
        0x28
        0x2d
        0x28
        0x1e
        0x28
        0x23
        0x23
        0x2ee0
    .end array-data
.end method

.method static gesture(Ljava/nio/ByteBuffer;II[F[F[I[C[I[C[I[F)I
    .locals 3

    .prologue
    const/4 v0, -0x1

    .line 253
    if-eqz p0, :cond_0

    sget v1, Lcom/mrkeyboard/app/MrNative;->sState:I

    const/4 v2, 0x1

    if-eq v1, v2, :cond_1

    .line 257
    :cond_0
    :goto_0
    return v0

    .line 255
    :cond_1
    :try_start_0
    invoke-static/range {p0 .. p10}, Lcom/mrkeyboard/app/MrNative;->nGesture(Ljava/nio/ByteBuffer;II[F[F[I[C[I[C[I[F)I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 256
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static gestureClose()V
    .locals 2

    .prologue
    .line 219
    sget v0, Lcom/mrkeyboard/app/MrNative;->sState:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 225
    :goto_0
    return-void

    .line 221
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->nGestureClose()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 222
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static gestureConfig([F[I)Z
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 229
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->ready()Z

    move-result v1

    if-nez v1, :cond_1

    .line 233
    :cond_0
    :goto_0
    return v0

    .line 231
    :cond_1
    :try_start_0
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrNative;->nGestureConfig([F[I)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 232
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static gestureLayout([C[F[C)Z
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 239
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->ready()Z

    move-result v1

    if-nez v1, :cond_1

    .line 243
    :cond_0
    :goto_0
    return v0

    .line 241
    :cond_1
    :try_start_0
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrNative;->nGestureLayout([C[F[C)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 242
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static gestureMore(Ljava/nio/ByteBuffer;I[C[I[C[I[F)I
    .locals 3

    .prologue
    const/4 v0, -0x1

    .line 270
    if-eqz p0, :cond_0

    sget v1, Lcom/mrkeyboard/app/MrNative;->sState:I

    const/4 v2, 0x1

    if-eq v1, v2, :cond_1

    .line 274
    :cond_0
    :goto_0
    return v0

    .line 272
    :cond_1
    :try_start_0
    invoke-static/range {p0 .. p6}, Lcom/mrkeyboard/app/MrNative;->nGestureMore(Ljava/nio/ByteBuffer;I[C[I[C[I[F)I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 273
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static gestureOpen(Ljava/lang/String;)Z
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 209
    if-eqz p0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->ready()Z

    move-result v1

    if-nez v1, :cond_1

    .line 213
    :cond_0
    :goto_0
    return v0

    .line 211
    :cond_1
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrNative;->nGestureOpen(Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 212
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static init()Z
    .locals 5

    .prologue
    .line 120
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->costs()[I

    move-result-object v0

    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->lowerTable()[C

    move-result-object v1

    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->upperTable()[B

    move-result-object v2

    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->baseTable()[C

    move-result-object v3

    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->powTable()[D

    move-result-object v4

    invoke-static {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrNative;->nInit([I[C[B[C[D)Z

    move-result v0

    return v0
.end method

.method private static declared-synchronized load()Z
    .locals 8

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 65
    const-class v2, Lcom/mrkeyboard/app/MrNative;

    monitor-enter v2

    :try_start_0
    sget v3, Lcom/mrkeyboard/app/MrNative;->sState:I

    if-eqz v3, :cond_1

    sget v3, Lcom/mrkeyboard/app/MrNative;->sState:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-ne v3, v0, :cond_0

    .line 78
    :goto_0
    monitor-exit v2

    return v0

    :cond_0
    move v0, v1

    .line 65
    goto :goto_0

    .line 67
    :cond_1
    :try_start_1
    invoke-static {}, Ljava/lang/System;->nanoTime()J
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-wide v4

    .line 69
    :try_start_2
    const-string v3, "off"

    const-string v6, "mr.native"

    invoke-static {v6}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 70
    const-string v3, "mrengine"

    invoke-static {v3}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 71
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->nVersion()I

    move-result v3

    const/4 v6, 0x3

    if-ne v3, v6, :cond_2

    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->init()Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result v3

    if-eqz v3, :cond_2

    move v1, v0

    .line 76
    :cond_2
    :goto_1
    if-eqz v1, :cond_4

    :goto_2
    :try_start_3
    sput v0, Lcom/mrkeyboard/app/MrNative;->sState:I

    .line 77
    if-eqz v1, :cond_3

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v6

    sub-long v4, v6, v4

    sput-wide v4, Lcom/mrkeyboard/app/MrDiag;->sEngineNs:J
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :cond_3
    move v0, v1

    .line 78
    goto :goto_0

    .line 76
    :cond_4
    const/4 v0, -0x1

    goto :goto_2

    .line 65
    :catchall_0
    move-exception v0

    monitor-exit v2

    throw v0

    .line 73
    :catch_0
    move-exception v3

    goto :goto_1
.end method

.method static lowerTable()[C
    .locals 4

    .prologue
    const/high16 v3, 0x10000

    .line 93
    new-array v1, v3, [C

    .line 94
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v3, :cond_0

    int-to-char v2, v0

    invoke-static {v2}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v2

    aput-char v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 95
    :cond_0
    return-object v1
.end method

.method private static native nGesture(Ljava/nio/ByteBuffer;II[F[F[I[C[I[C[I[F)I
.end method

.method private static native nGestureClose()V
.end method

.method private static native nGestureConfig([F[I)Z
.end method

.method private static native nGestureLayout([C[F[C)Z
.end method

.method private static native nGestureMore(Ljava/nio/ByteBuffer;I[C[I[C[I[F)I
.end method

.method private static native nGestureOpen(Ljava/lang/String;)Z
.end method

.method private static native nInit([I[C[B[C[D)Z
.end method

.method private static native nSearch(Ljava/nio/ByteBuffer;II[C[C[I[C[I[J)I
.end method

.method private static native nSetRules([B[C[C[C[S[S[S[Z[Z)Z
.end method

.method private static native nTriClose()V
.end method

.method private static native nTriFind(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[I)I
.end method

.method private static native nTriOpen(Ljava/lang/String;)Z
.end method

.method private static native nVersion()I
.end method

.method static packD2(Lcom/mrkeyboard/app/MrRules;)[C
    .locals 4

    .prologue
    .line 134
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    array-length v0, v0

    mul-int/lit8 v0, v0, 0x3

    new-array v1, v0, [C

    .line 135
    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    array-length v2, v2

    if-ge v0, v2, :cond_0

    .line 136
    mul-int/lit8 v2, v0, 0x3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    aget-char v3, v3, v0

    aput-char v3, v1, v2

    mul-int/lit8 v2, v0, 0x3

    add-int/lit8 v2, v2, 0x1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrRules;->d2c:[C

    aget-char v3, v3, v0

    aput-char v3, v1, v2

    mul-int/lit8 v2, v0, 0x3

    add-int/lit8 v2, v2, 0x2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    aget-char v3, v3, v0

    aput-char v3, v1, v2

    .line 135
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 138
    :cond_0
    return-object v1
.end method

.method static packSil(Lcom/mrkeyboard/app/MrRules;)[C
    .locals 4

    .prologue
    .line 143
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRules;->silPrev:[C

    array-length v0, v0

    mul-int/lit8 v0, v0, 0x2

    new-array v1, v0, [C

    .line 144
    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrRules;->silPrev:[C

    array-length v2, v2

    if-ge v0, v2, :cond_0

    .line 145
    mul-int/lit8 v2, v0, 0x2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrRules;->silPrev:[C

    aget-char v3, v3, v0

    aput-char v3, v1, v2

    mul-int/lit8 v2, v0, 0x2

    add-int/lit8 v2, v2, 0x1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrRules;->silChar:[C

    aget-char v3, v3, v0

    aput-char v3, v1, v2

    .line 144
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 147
    :cond_0
    return-object v1
.end method

.method static packT2(Lcom/mrkeyboard/app/MrRules;)[C
    .locals 4

    .prologue
    .line 125
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    array-length v0, v0

    mul-int/lit8 v0, v0, 0x3

    new-array v1, v0, [C

    .line 126
    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    array-length v2, v2

    if-ge v0, v2, :cond_0

    .line 127
    mul-int/lit8 v2, v0, 0x3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    aget-char v3, v3, v0

    aput-char v3, v1, v2

    mul-int/lit8 v2, v0, 0x3

    add-int/lit8 v2, v2, 0x1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrRules;->t2b:[C

    aget-char v3, v3, v0

    aput-char v3, v1, v2

    mul-int/lit8 v2, v0, 0x3

    add-int/lit8 v2, v2, 0x2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrRules;->t2d:[C

    aget-char v3, v3, v0

    aput-char v3, v1, v2

    .line 126
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 129
    :cond_0
    return-object v1
.end method

.method static powTable()[D
    .locals 9

    .prologue
    const/16 v8, 0x100

    .line 114
    new-array v1, v8, [D

    .line 115
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v8, :cond_0

    const-wide/high16 v2, 0x4000000000000000L    # 2.0

    neg-int v4, v0

    int-to-double v4, v4

    const-wide/high16 v6, 0x4039000000000000L    # 25.0

    div-double/2addr v4, v6

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    aput-wide v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 116
    :cond_0
    return-object v1
.end method

.method static declared-synchronized preload()V
    .locals 4

    .prologue
    .line 53
    const-class v1, Lcom/mrkeyboard/app/MrNative;

    monitor-enter v1

    :try_start_0
    sget-boolean v0, Lcom/mrkeyboard/app/MrNative;->sPreloading:Z

    if-nez v0, :cond_0

    sget v0, Lcom/mrkeyboard/app/MrNative;->sState:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_1

    .line 62
    :cond_0
    :goto_0
    monitor-exit v1

    return-void

    .line 54
    :cond_1
    const/4 v0, 0x1

    :try_start_1
    sput-boolean v0, Lcom/mrkeyboard/app/MrNative;->sPreloading:Z

    .line 55
    new-instance v0, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrNative$1;

    invoke-direct {v2}, Lcom/mrkeyboard/app/MrNative$1;-><init>()V

    const-string v3, "MrNative"

    invoke-direct {v0, v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 60
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Ljava/lang/Thread;->setPriority(I)V

    .line 61
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 53
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private static pushRules(Lcom/mrkeyboard/app/MrRules;)Z
    .locals 9

    .prologue
    .line 151
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRules;->pairs:[B

    invoke-static {p0}, Lcom/mrkeyboard/app/MrNative;->packT2(Lcom/mrkeyboard/app/MrRules;)[C

    move-result-object v1

    invoke-static {p0}, Lcom/mrkeyboard/app/MrNative;->packD2(Lcom/mrkeyboard/app/MrRules;)[C

    move-result-object v2

    invoke-static {p0}, Lcom/mrkeyboard/app/MrNative;->packSil(Lcom/mrkeyboard/app/MrRules;)[C

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrRules;->silCost:[S

    iget-object v5, p0, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    iget-object v6, p0, Lcom/mrkeyboard/app/MrRules;->silentAny:[S

    iget-object v7, p0, Lcom/mrkeyboard/app/MrRules;->extra:[Z

    iget-object v8, p0, Lcom/mrkeyboard/app/MrRules;->oneLetter:[Z

    invoke-static/range {v0 .. v8}, Lcom/mrkeyboard/app/MrNative;->nSetRules([B[C[C[C[S[S[S[Z[Z)Z

    move-result v0

    return v0
.end method

.method static ready()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 46
    sget v1, Lcom/mrkeyboard/app/MrNative;->sState:I

    .line 47
    if-nez v1, :cond_1

    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->load()Z

    move-result v0

    .line 48
    :cond_0
    :goto_0
    return v0

    :cond_1
    if-eq v1, v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0
.end method

.method static search(Ljava/nio/ByteBuffer;II[C[C[ILcom/mrkeyboard/app/MrRules;[C[I[J)I
    .locals 9

    .prologue
    .line 162
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->ready()Z

    move-result v0

    if-eqz v0, :cond_0

    if-eqz p0, :cond_0

    if-nez p6, :cond_1

    :cond_0
    const/4 v0, -0x1

    .line 175
    :goto_0
    return v0

    .line 164
    :cond_1
    :try_start_0
    const-class v1, Lcom/mrkeyboard/app/MrNative;

    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 165
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrNative;->sPushed:Lcom/mrkeyboard/app/MrRules;

    if-eq v0, p6, :cond_3

    .line 166
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrNative;->sPushed:Lcom/mrkeyboard/app/MrRules;

    .line 167
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v2

    .line 168
    invoke-static {p6}, Lcom/mrkeyboard/app/MrNative;->pushRules(Lcom/mrkeyboard/app/MrRules;)Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, -0x1

    monitor-exit v1

    goto :goto_0

    .line 172
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    .line 174
    :catch_0
    move-exception v0

    .line 175
    const/4 v0, -0x1

    goto :goto_0

    .line 169
    :cond_2
    :try_start_3
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v4

    sub-long v2, v4, v2

    sput-wide v2, Lcom/mrkeyboard/app/MrDiag;->sRulesNs:J

    .line 170
    sput-object p6, Lcom/mrkeyboard/app/MrNative;->sPushed:Lcom/mrkeyboard/app/MrRules;

    .line 172
    :cond_3
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-object v0, p0

    move v1, p1

    move v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object/from16 v6, p7

    move-object/from16 v7, p8

    move-object/from16 v8, p9

    .line 173
    :try_start_4
    invoke-static/range {v0 .. v8}, Lcom/mrkeyboard/app/MrNative;->nSearch(Ljava/nio/ByteBuffer;II[C[C[I[C[I[J)I
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0

    move-result v0

    goto :goto_0
.end method

.method static triClose()V
    .locals 2

    .prologue
    .line 190
    sget v0, Lcom/mrkeyboard/app/MrNative;->sState:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 196
    :goto_0
    return-void

    .line 192
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->nTriClose()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 193
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static triFind(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[I)I
    .locals 1

    .prologue
    .line 201
    :try_start_0
    invoke-static/range {p0 .. p5}, Lcom/mrkeyboard/app/MrNative;->nTriFind(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[I)I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 203
    :goto_0
    return v0

    .line 202
    :catch_0
    move-exception v0

    .line 203
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static triOpen(Ljava/lang/String;)Z
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 181
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->ready()Z

    move-result v1

    if-nez v1, :cond_0

    .line 185
    :goto_0
    return v0

    .line 183
    :cond_0
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrNative;->nTriOpen(Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 184
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static upperTable()[B
    .locals 5

    .prologue
    const/high16 v4, 0x10000

    const/4 v1, 0x0

    .line 100
    new-array v3, v4, [B

    move v2, v1

    .line 101
    :goto_0
    if-ge v2, v4, :cond_1

    int-to-char v0, v2

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_1
    int-to-byte v0, v0

    aput-byte v0, v3, v2

    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    :cond_0
    move v0, v1

    goto :goto_1

    .line 102
    :cond_1
    return-object v3
.end method
