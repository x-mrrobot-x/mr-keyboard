.class public final Lcom/mrkeyboard/app/MrGesture;
.super Ljava/lang/Object;
.source "MrGesture.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrGesture$Result;
    }
.end annotation


# static fields
.field static final BEAM:I = 0xc8

.field static final BETA:F = 2.9f

.field static final BETA_PRUNE:F = 1.0382f

.field static final CTX:F = 0.066f

.field private static final DECODE:Ljava/lang/Object;

.field static final FREE:[C

.field static final GAMMA:F = 0.0f

.field static final GAMMA_PRUNE:F = 0.4234f

.field static final INFO_SIZE:I = 0x42

.field static final LAMBDA_FREQ:F = 0.075f

.field static final MAX_KEYS:I = 0x40

.field static final MAX_RESULTS:I = 0x10

.field static final MAX_TOUCHES:I = 0x1000

.field static final MIN_KEYS:I = 0x2

.field private static final NATIVE_LOAD:Ljava/lang/Object;

.field static final NODE_BUDGET:I = 0xea60

.field static final RESULT_CHARS:I = 0x30

.field private static sGen:I

.field private static sOpen:Z

.field private static sPath:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 56
    const/4 v0, 0x2

    new-array v0, v0, [C

    fill-array-data v0, :array_0

    sput-object v0, Lcom/mrkeyboard/app/MrGesture;->FREE:[C

    .line 121
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrGesture;->DECODE:Ljava/lang/Object;

    .line 126
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrGesture;->NATIVE_LOAD:Ljava/lang/Object;

    return-void

    .line 56
    nop

    :array_0
    .array-data 2
        0x27s
        0x2ds
    .end array-data
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;I)Z
    .locals 1

    .prologue
    .line 27
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrGesture;->open(Ljava/lang/String;I)Z

    move-result v0

    return v0
.end method

.method static decode(Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[F[F[IILjava/lang/CharSequence;Lcom/mrkeyboard/app/MrGesture$Result;)I
    .locals 13

    .prologue
    .line 222
    if-nez p8, :cond_0

    const/4 v2, -0x1

    .line 261
    :goto_0
    return v2

    .line 223
    :cond_0
    const/4 v1, 0x0

    move-object/from16 v0, p8

    iput v1, v0, Lcom/mrkeyboard/app/MrGesture$Result;->count:I

    .line 224
    const/4 v1, 0x0

    move-object/from16 v0, p8

    iput v1, v0, Lcom/mrkeyboard/app/MrGesture$Result;->extra:I

    .line 225
    if-eqz p0, :cond_1

    if-eqz p3, :cond_1

    if-eqz p4, :cond_1

    if-eqz p5, :cond_1

    const/4 v1, 0x1

    move/from16 v0, p6

    if-lt v0, v1, :cond_1

    const/16 v1, 0x1000

    move/from16 v0, p6

    if-gt v0, v1, :cond_1

    move-object/from16 v0, p3

    array-length v1, v0

    move/from16 v0, p6

    if-lt v1, v0, :cond_1

    move-object/from16 v0, p4

    array-length v1, v0

    move/from16 v0, p6

    if-lt v1, v0, :cond_1

    move-object/from16 v0, p5

    array-length v1, v0

    move/from16 v0, p6

    if-ge v1, v0, :cond_2

    .line 227
    :cond_1
    const/4 v2, -0x1

    goto :goto_0

    .line 229
    :cond_2
    const-class v3, Lcom/mrkeyboard/app/MrGesture;

    monitor-enter v3

    .line 230
    :try_start_0
    sget-boolean v1, Lcom/mrkeyboard/app/MrGesture;->sOpen:Z

    if-nez v1, :cond_3

    const/4 v2, -0x1

    monitor-exit v3

    goto :goto_0

    .line 231
    :catchall_0
    move-exception v1

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    :cond_3
    :try_start_1
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 232
    const/4 v7, 0x0

    .line 233
    const/4 v8, 0x0

    .line 234
    if-eqz p7, :cond_5

    invoke-interface/range {p7 .. p7}, Ljava/lang/CharSequence;->length()I

    move-result v1

    move v3, v1

    .line 235
    :goto_1
    if-lez v3, :cond_6

    const/16 v1, 0x30

    if-gt v3, v1, :cond_6

    .line 236
    mul-int/lit8 v1, v3, 0x3

    new-array v7, v1, [C

    .line 237
    const/4 v1, 0x3

    new-array v8, v1, [I

    const/4 v1, 0x0

    aput v3, v8, v1

    const/4 v1, 0x1

    aput v3, v8, v1

    const/4 v1, 0x2

    aput v3, v8, v1

    .line 238
    const/4 v1, 0x0

    move v2, v1

    :goto_2
    if-ge v2, v3, :cond_6

    .line 239
    move-object/from16 v0, p7

    invoke-interface {v0, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v4

    .line 240
    invoke-static {v4}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v1

    .line 241
    aput-char v4, v7, v2

    .line 242
    add-int v5, v3, v2

    aput-char v1, v7, v5

    .line 243
    mul-int/lit8 v5, v3, 0x2

    add-int/2addr v5, v2

    if-nez v2, :cond_4

    invoke-static {v4}, Ljava/lang/Character;->toUpperCase(C)C

    move-result v1

    :cond_4
    aput-char v1, v7, v5

    .line 238
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_2

    .line 234
    :cond_5
    const/4 v1, 0x0

    move v3, v1

    goto :goto_1

    .line 247
    :cond_6
    sget-object v12, Lcom/mrkeyboard/app/MrGesture;->DECODE:Ljava/lang/Object;

    monitor-enter v12

    .line 248
    :try_start_2
    move-object/from16 v0, p8

    iget-object v9, v0, Lcom/mrkeyboard/app/MrGesture$Result;->words:[C

    move-object/from16 v0, p8

    iget-object v10, v0, Lcom/mrkeyboard/app/MrGesture$Result;->info:[I

    move-object/from16 v0, p8

    iget-object v11, v0, Lcom/mrkeyboard/app/MrGesture$Result;->scores:[F

    move-object v1, p0

    move v2, p1

    move/from16 v3, p6

    move-object/from16 v4, p3

    move-object/from16 v5, p4

    move-object/from16 v6, p5

    invoke-static/range {v1 .. v11}, Lcom/mrkeyboard/app/MrNative;->gesture(Ljava/nio/ByteBuffer;II[F[F[I[C[I[C[I[F)I

    move-result v8

    .line 249
    if-ltz v8, :cond_8

    if-eqz p2, :cond_8

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->isDirect()Z

    move-result v1

    if-eqz v1, :cond_8

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v1

    const/4 v2, 0x2

    if-le v1, v2, :cond_8

    .line 250
    move-object/from16 v0, p8

    iget-object v1, v0, Lcom/mrkeyboard/app/MrGesture$Result;->info:[I

    const/4 v2, 0x1

    aget v9, v1, v2

    .line 252
    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object/from16 v0, p8

    iget-object v5, v0, Lcom/mrkeyboard/app/MrGesture$Result;->words:[C

    move-object/from16 v0, p8

    iget-object v6, v0, Lcom/mrkeyboard/app/MrGesture$Result;->info:[I

    move-object/from16 v0, p8

    iget-object v7, v0, Lcom/mrkeyboard/app/MrGesture$Result;->scores:[F

    move-object v1, p2

    invoke-static/range {v1 .. v7}, Lcom/mrkeyboard/app/MrNative;->gestureMore(Ljava/nio/ByteBuffer;I[C[I[C[I[F)I

    move-result v2

    .line 253
    if-ltz v2, :cond_8

    .line 255
    move-object/from16 v0, p8

    iget-object v1, v0, Lcom/mrkeyboard/app/MrGesture$Result;->info:[I

    const/4 v3, 0x1

    aget v1, v1, v3

    move-object/from16 v0, p8

    iput v1, v0, Lcom/mrkeyboard/app/MrGesture$Result;->extra:I

    .line 256
    move-object/from16 v0, p8

    iget-object v1, v0, Lcom/mrkeyboard/app/MrGesture$Result;->info:[I

    const/4 v3, 0x1

    aput v9, v1, v3

    .line 259
    :goto_3
    monitor-exit v12
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 260
    if-gez v2, :cond_7

    const/4 v1, 0x0

    :goto_4
    move-object/from16 v0, p8

    iput v1, v0, Lcom/mrkeyboard/app/MrGesture$Result;->count:I

    goto/16 :goto_0

    .line 259
    :catchall_1
    move-exception v1

    :try_start_3
    monitor-exit v12
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw v1

    :cond_7
    move v1, v2

    .line 260
    goto :goto_4

    :cond_8
    move v2, v8

    goto :goto_3
.end method

.method static decode(Ljava/nio/ByteBuffer;I[F[F[IILjava/lang/CharSequence;Lcom/mrkeyboard/app/MrGesture$Result;)I
    .locals 9

    .prologue
    .line 266
    const/4 v2, 0x0

    move-object v0, p0

    move v1, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move v6, p5

    move-object v7, p6

    move-object/from16 v8, p7

    invoke-static/range {v0 .. v8}, Lcom/mrkeyboard/app/MrGesture;->decode(Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[F[F[IILjava/lang/CharSequence;Lcom/mrkeyboard/app/MrGesture$Result;)I

    move-result v0

    return v0
.end method

.method static limits()[I
    .locals 1

    .prologue
    .line 65
    const/4 v0, 0x3

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    return-object v0

    nop

    :array_0
    .array-data 4
        0xc8
        0x2
        0xea60
    .end array-data
.end method

.method private static open(Ljava/lang/String;I)Z
    .locals 5

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 167
    sget-object v2, Lcom/mrkeyboard/app/MrGesture;->NATIVE_LOAD:Ljava/lang/Object;

    monitor-enter v2

    .line 168
    :try_start_0
    const-class v3, Lcom/mrkeyboard/app/MrGesture;

    monitor-enter v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 169
    :try_start_1
    sget v4, Lcom/mrkeyboard/app/MrGesture;->sGen:I

    if-eq p1, v4, :cond_0

    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 185
    :goto_0
    return v0

    .line 170
    :cond_0
    :try_start_3
    monitor-exit v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 171
    :try_start_4
    invoke-static {}, Lcom/mrkeyboard/app/MrGesture;->params()[F

    move-result-object v3

    invoke-static {}, Lcom/mrkeyboard/app/MrGesture;->limits()[I

    move-result-object v4

    invoke-static {v3, v4}, Lcom/mrkeyboard/app/MrNative;->gestureConfig([F[I)Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-static {p0}, Lcom/mrkeyboard/app/MrNative;->gestureOpen(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 172
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->gestureClose()V

    .line 173
    monitor-exit v2

    goto :goto_0

    .line 186
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw v0

    .line 170
    :catchall_1
    move-exception v0

    :try_start_5
    monitor-exit v3
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    :try_start_6
    throw v0

    .line 176
    :cond_2
    const-class v3, Lcom/mrkeyboard/app/MrGesture;

    monitor-enter v3
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 177
    :try_start_7
    sget v4, Lcom/mrkeyboard/app/MrGesture;->sGen:I

    if-ne p1, v4, :cond_3

    .line 178
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrGesture;->sOpen:Z

    .line 179
    monitor-exit v3
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    :try_start_8
    monitor-exit v2
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    move v0, v1

    goto :goto_0

    .line 181
    :cond_3
    :try_start_9
    sget-object v4, Lcom/mrkeyboard/app/MrGesture;->sPath:Ljava/lang/String;

    if-nez v4, :cond_5

    .line 182
    :goto_1
    monitor-exit v3
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    .line 184
    if-eqz v1, :cond_4

    :try_start_a
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->gestureClose()V

    .line 185
    :cond_4
    monitor-exit v2
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    goto :goto_0

    :cond_5
    move v1, v0

    .line 181
    goto :goto_1

    .line 182
    :catchall_2
    move-exception v0

    :try_start_b
    monitor-exit v3
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_2

    :try_start_c
    throw v0
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_0
.end method

.method static params()[F
    .locals 1

    .prologue
    .line 60
    const/4 v0, 0x6

    new-array v0, v0, [F

    fill-array-data v0, :array_0

    return-object v0

    nop

    :array_0
    .array-data 4
        0x0
        0x3d99999a    # 0.075f
        0x4039999a    # 2.9f
        0x3d872b02    # 0.066f
        0x3ed8c7e3    # 0.4234f
        0x3f84e3bd    # 1.0382f
    .end array-data
.end method

.method static declared-synchronized ready()Z
    .locals 2

    .prologue
    .line 191
    const-class v0, Lcom/mrkeyboard/app/MrGesture;

    monitor-enter v0

    :try_start_0
    sget-boolean v1, Lcom/mrkeyboard/app/MrGesture;->sOpen:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method static sameIgnoringCase(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 114
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    if-eq v0, v2, :cond_1

    .line 118
    :cond_0
    :goto_0
    return v1

    :cond_1
    move v0, v1

    .line 115
    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v0, v2, :cond_2

    .line 116
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v2

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v3

    if-ne v2, v3, :cond_0

    .line 115
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 118
    :cond_2
    const/4 v1, 0x1

    goto :goto_0
.end method

.method static setLayout([C[F)Z
    .locals 2

    .prologue
    .line 200
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    array-length v0, p0

    const/4 v1, 0x2

    if-lt v0, v1, :cond_0

    array-length v0, p0

    const/16 v1, 0x40

    if-gt v0, v1, :cond_0

    array-length v0, p1

    array-length v1, p0

    mul-int/lit8 v1, v1, 0x2

    if-ge v0, v1, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 201
    :goto_0
    return v0

    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrGesture;->FREE:[C

    invoke-static {p0, p1, v0}, Lcom/mrkeyboard/app/MrNative;->gestureLayout([C[F[C)Z

    move-result v0

    goto :goto_0
.end method

.method static use(Ljava/io/File;)V
    .locals 4

    .prologue
    .line 130
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    .line 132
    :goto_0
    const-class v1, Lcom/mrkeyboard/app/MrGesture;

    monitor-enter v1

    .line 133
    if-nez v0, :cond_2

    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrGesture;->sPath:Ljava/lang/String;

    if-nez v2, :cond_3

    :cond_0
    monitor-exit v1

    .line 149
    :goto_1
    return-void

    .line 130
    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    .line 133
    :cond_2
    sget-object v2, Lcom/mrkeyboard/app/MrGesture;->sPath:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 134
    :cond_3
    sput-object v0, Lcom/mrkeyboard/app/MrGesture;->sPath:Ljava/lang/String;

    .line 135
    sget v2, Lcom/mrkeyboard/app/MrGesture;->sGen:I

    add-int/lit8 v2, v2, 0x1

    sput v2, Lcom/mrkeyboard/app/MrGesture;->sGen:I

    .line 136
    const/4 v3, 0x0

    sput-boolean v3, Lcom/mrkeyboard/app/MrGesture;->sOpen:Z

    .line 137
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 138
    if-nez v0, :cond_4

    .line 139
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->gestureClose()V

    goto :goto_1

    .line 137
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 142
    :cond_4
    new-instance v1, Ljava/lang/Thread;

    new-instance v3, Lcom/mrkeyboard/app/MrGesture$1;

    invoke-direct {v3, v0, v2}, Lcom/mrkeyboard/app/MrGesture$1;-><init>(Ljava/lang/String;I)V

    const-string v0, "MrGesture"

    invoke-direct {v1, v3, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 147
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Ljava/lang/Thread;->setPriority(I)V

    .line 148
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_1
.end method

.method static useNow(Ljava/io/File;)Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 153
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGesture;->use(Ljava/io/File;)V

    .line 154
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    .line 155
    :cond_0
    if-nez v1, :cond_1

    .line 162
    :goto_0
    return v0

    .line 157
    :cond_1
    const-class v2, Lcom/mrkeyboard/app/MrGesture;

    monitor-enter v2

    .line 158
    :try_start_0
    sput-object v1, Lcom/mrkeyboard/app/MrGesture;->sPath:Ljava/lang/String;

    .line 159
    sget v0, Lcom/mrkeyboard/app/MrGesture;->sGen:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrGesture;->sGen:I

    .line 160
    const/4 v3, 0x0

    sput-boolean v3, Lcom/mrkeyboard/app/MrGesture;->sOpen:Z

    .line 161
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 162
    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrGesture;->open(Ljava/lang/String;I)Z

    move-result v0

    goto :goto_0

    .line 161
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method
