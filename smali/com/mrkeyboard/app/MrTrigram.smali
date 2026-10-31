.class public final Lcom/mrkeyboard/app/MrTrigram;
.super Ljava/lang/Object;
.source "MrTrigram.java"


# static fields
.field private static final NATIVE_LOAD:Ljava/lang/Object;

.field private static sGen:I

.field private static sKeys:[J

.field private static sNative:Z

.field private static sNext:[I

.field private static sPath:Ljava/lang/String;

.field private static sScore:[B

.field private static sStart:[I

.field private static sWords:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 30
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrTrigram;->NATIVE_LOAD:Ljava/lang/Object;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;I)Z
    .locals 1

    .prologue
    .line 19
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrTrigram;->openNative(Ljava/lang/String;I)Z

    move-result v0

    return v0
.end method

.method static synthetic access$100(Ljava/io/InputStream;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 19
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrTrigram;->load(Ljava/io/InputStream;I)V

    return-void
.end method

.method static declared-synchronized find(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[I)I
    .locals 17

    .prologue
    .line 168
    const-class v8, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v8

    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrTrigram;->sWords:[Ljava/lang/String;

    if-nez v2, :cond_0

    sget-boolean v2, Lcom/mrkeyboard/app/MrTrigram;->sNative:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v2, :cond_1

    :cond_0
    if-eqz p0, :cond_1

    if-nez p1, :cond_3

    :cond_1
    const/4 v2, 0x0

    .line 189
    :cond_2
    :goto_0
    monitor-exit v8

    return v2

    .line 169
    :cond_3
    const/4 v2, 0x2

    :try_start_1
    new-array v4, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    aput-object p0, v4, v2

    const/4 v2, 0x1

    invoke-virtual/range {p0 .. p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v4, v2

    .line 170
    const/4 v2, 0x2

    new-array v5, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    aput-object p1, v5, v2

    const/4 v2, 0x1

    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v5, v2

    .line 171
    sget-boolean v2, Lcom/mrkeyboard/app/MrTrigram;->sNative:Z

    if-eqz v2, :cond_4

    const/4 v2, 0x0

    aget-object v2, v4, v2

    const/4 v3, 0x1

    aget-object v3, v4, v3

    const/4 v4, 0x0

    aget-object v4, v5, v4

    const/4 v6, 0x1

    aget-object v5, v5, v6

    move-object/from16 v6, p2

    move-object/from16 v7, p3

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrNative;->triFind(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[I)I

    move-result v2

    goto :goto_0

    .line 172
    :cond_4
    array-length v6, v4

    const/4 v2, 0x0

    move v3, v2

    :goto_1
    if-ge v3, v6, :cond_9

    aget-object v2, v4, v3

    .line 173
    invoke-static {v2}, Lcom/mrkeyboard/app/MrTrigram;->id(Ljava/lang/String;)I

    move-result v7

    .line 174
    if-gez v7, :cond_6

    .line 172
    :cond_5
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    goto :goto_1

    .line 175
    :cond_6
    array-length v9, v5

    const/4 v2, 0x0

    :goto_2
    if-ge v2, v9, :cond_5

    aget-object v10, v5, v2

    .line 176
    invoke-static {v10}, Lcom/mrkeyboard/app/MrTrigram;->id(Ljava/lang/String;)I

    move-result v10

    .line 177
    if-gez v10, :cond_8

    .line 175
    :cond_7
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 178
    :cond_8
    sget-object v11, Lcom/mrkeyboard/app/MrTrigram;->sKeys:[J

    int-to-long v12, v7

    const/16 v14, 0x20

    shl-long/2addr v12, v14

    int-to-long v14, v10

    or-long/2addr v12, v14

    invoke-static {v11, v12, v13}, Ljava/util/Arrays;->binarySearch([JJ)I

    move-result v10

    .line 179
    if-ltz v10, :cond_7

    .line 180
    const/4 v3, 0x0

    .line 181
    sget-object v2, Lcom/mrkeyboard/app/MrTrigram;->sStart:[I

    aget v2, v2, v10

    move/from16 v16, v2

    move v2, v3

    move/from16 v3, v16

    :goto_3
    sget-object v4, Lcom/mrkeyboard/app/MrTrigram;->sStart:[I

    add-int/lit8 v5, v10, 0x1

    aget v4, v4, v5

    if-ge v3, v4, :cond_2

    move-object/from16 v0, p2

    array-length v4, v0

    if-ge v2, v4, :cond_2

    .line 182
    sget-object v4, Lcom/mrkeyboard/app/MrTrigram;->sWords:[Ljava/lang/String;

    sget-object v5, Lcom/mrkeyboard/app/MrTrigram;->sNext:[I

    aget v5, v5, v3

    aget-object v4, v4, v5

    aput-object v4, p2, v2

    .line 183
    sget-object v4, Lcom/mrkeyboard/app/MrTrigram;->sScore:[B

    aget-byte v4, v4, v3

    and-int/lit16 v4, v4, 0xff

    aput v4, p3, v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 184
    add-int/lit8 v4, v2, 0x1

    .line 181
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    move v2, v4

    goto :goto_3

    .line 189
    :cond_9
    const/4 v2, 0x0

    goto/16 :goto_0

    .line 168
    :catchall_0
    move-exception v2

    monitor-exit v8

    throw v2
.end method

.method private static id(Ljava/lang/String;)I
    .locals 2

    .prologue
    const/4 v1, -0x1

    .line 157
    sget-object v0, Lcom/mrkeyboard/app/MrTrigram;->sWords:[Ljava/lang/String;

    .line 158
    if-eqz v0, :cond_0

    if-nez p0, :cond_2

    :cond_0
    move v0, v1

    .line 160
    :cond_1
    :goto_0
    return v0

    .line 159
    :cond_2
    invoke-static {v0, p0}, Ljava/util/Arrays;->binarySearch([Ljava/lang/Object;Ljava/lang/Object;)I

    move-result v0

    .line 160
    if-gez v0, :cond_1

    move v0, v1

    goto :goto_0
.end method

.method static load(Ljava/io/InputStream;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 92
    const-class v1, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v1

    .line 93
    :try_start_0
    sget v0, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    .line 94
    const-string v2, "(teste)"

    sput-object v2, Lcom/mrkeyboard/app/MrTrigram;->sPath:Ljava/lang/String;

    .line 95
    const/4 v2, 0x0

    sput-boolean v2, Lcom/mrkeyboard/app/MrTrigram;->sNative:Z

    .line 96
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 97
    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTrigram;->load(Ljava/io/InputStream;I)V

    .line 98
    return-void

    .line 96
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method private static load(Ljava/io/InputStream;I)V
    .locals 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 102
    new-instance v3, Ljava/io/DataInputStream;

    new-instance v0, Ljava/io/BufferedInputStream;

    const/high16 v1, 0x10000

    invoke-direct {v0, p0, v1}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;I)V

    invoke-direct {v3, v0}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    .line 103
    const/4 v0, 0x4

    new-array v0, v0, [B

    .line 104
    invoke-virtual {v3, v0}, Ljava/io/DataInputStream;->readFully([B)V

    .line 105
    const/4 v1, 0x0

    aget-byte v1, v0, v1

    const/16 v2, 0x4d

    if-ne v1, v2, :cond_0

    const/4 v1, 0x1

    aget-byte v1, v0, v1

    const/16 v2, 0x52

    if-ne v1, v2, :cond_0

    const/4 v1, 0x2

    aget-byte v1, v0, v1

    const/16 v2, 0x54

    if-ne v1, v2, :cond_0

    const/4 v1, 0x3

    aget-byte v0, v0, v1

    const/16 v1, 0x31

    if-eq v0, v1, :cond_1

    .line 106
    :cond_0
    new-instance v0, Ljava/io/IOException;

    const-string v1, "formato desconhecido"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 108
    :cond_1
    invoke-virtual {v3}, Ljava/io/DataInputStream;->readInt()I

    move-result v1

    .line 109
    new-array v4, v1, [Ljava/lang/String;

    .line 110
    const/16 v0, 0x100

    new-array v2, v0, [B

    .line 111
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v1, :cond_2

    .line 112
    invoke-virtual {v3}, Ljava/io/DataInputStream;->readUnsignedByte()I

    move-result v5

    .line 113
    const/4 v6, 0x0

    invoke-virtual {v3, v2, v6, v5}, Ljava/io/DataInputStream;->readFully([BII)V

    .line 114
    new-instance v6, Ljava/lang/String;

    const/4 v7, 0x0

    const-string v8, "UTF-8"

    invoke-direct {v6, v2, v7, v5, v8}, Ljava/lang/String;-><init>([BIILjava/lang/String;)V

    aput-object v6, v4, v0

    .line 111
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 116
    :cond_2
    invoke-virtual {v3}, Ljava/io/DataInputStream;->readInt()I

    move-result v5

    .line 117
    new-array v6, v5, [J

    .line 118
    add-int/lit8 v0, v5, 0x1

    new-array v7, v0, [I

    .line 119
    mul-int/lit8 v0, v5, 0x3

    new-array v8, v0, [I

    .line 120
    mul-int/lit8 v0, v5, 0x3

    new-array v9, v0, [B

    .line 121
    const/4 v1, 0x0

    .line 122
    const/4 v0, 0x0

    move v2, v0

    :goto_1
    if-ge v2, v5, :cond_4

    .line 123
    invoke-static {v3}, Lcom/mrkeyboard/app/MrTrigram;->read24(Ljava/io/DataInputStream;)I

    move-result v0

    int-to-long v10, v0

    .line 124
    invoke-static {v3}, Lcom/mrkeyboard/app/MrTrigram;->read24(Ljava/io/DataInputStream;)I

    move-result v0

    int-to-long v12, v0

    .line 125
    const/16 v0, 0x20

    shl-long/2addr v10, v0

    or-long/2addr v10, v12

    aput-wide v10, v6, v2

    .line 126
    aput v1, v7, v2

    .line 127
    invoke-virtual {v3}, Ljava/io/DataInputStream;->readUnsignedByte()I

    move-result v10

    .line 128
    const/4 v0, 0x0

    :goto_2
    if-ge v0, v10, :cond_3

    .line 129
    invoke-static {v3}, Lcom/mrkeyboard/app/MrTrigram;->read24(Ljava/io/DataInputStream;)I

    move-result v11

    aput v11, v8, v1

    .line 130
    invoke-virtual {v3}, Ljava/io/DataInputStream;->readUnsignedByte()I

    move-result v11

    int-to-byte v11, v11

    aput-byte v11, v9, v1

    .line 131
    add-int/lit8 v1, v1, 0x1

    .line 128
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 122
    :cond_3
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    .line 134
    :cond_4
    aput v1, v7, v5

    .line 135
    const-class v1, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v1

    .line 136
    :try_start_0
    sget v0, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    if-eq p1, v0, :cond_5

    monitor-exit v1

    .line 143
    :goto_3
    return-void

    .line 137
    :cond_5
    sput-object v6, Lcom/mrkeyboard/app/MrTrigram;->sKeys:[J

    .line 138
    sput-object v7, Lcom/mrkeyboard/app/MrTrigram;->sStart:[I

    .line 139
    sput-object v8, Lcom/mrkeyboard/app/MrTrigram;->sNext:[I

    .line 140
    sput-object v9, Lcom/mrkeyboard/app/MrTrigram;->sScore:[B

    .line 141
    sput-object v4, Lcom/mrkeyboard/app/MrTrigram;->sWords:[Ljava/lang/String;

    .line 142
    monitor-exit v1

    goto :goto_3

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private static openNative(Ljava/lang/String;I)Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    .line 75
    sget-object v1, Lcom/mrkeyboard/app/MrTrigram;->NATIVE_LOAD:Ljava/lang/Object;

    monitor-enter v1

    .line 76
    :try_start_0
    const-class v2, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 77
    :try_start_1
    sget v3, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    if-eq p1, v3, :cond_0

    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 86
    :goto_0
    return v0

    .line 78
    :cond_0
    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 79
    :try_start_4
    invoke-static {p0}, Lcom/mrkeyboard/app/MrNative;->triOpen(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 80
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->triClose()V

    .line 81
    const/4 v0, 0x0

    monitor-exit v1

    goto :goto_0

    .line 87
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw v0

    .line 78
    :catchall_1
    move-exception v0

    :try_start_5
    monitor-exit v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    :try_start_6
    throw v0

    .line 83
    :cond_1
    const-class v2, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v2
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 84
    :try_start_7
    sget v3, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    if-ne p1, v3, :cond_2

    const/4 v3, 0x1

    sput-boolean v3, Lcom/mrkeyboard/app/MrTrigram;->sNative:Z

    .line 85
    :cond_2
    monitor-exit v2
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .line 86
    :try_start_8
    monitor-exit v1
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    goto :goto_0

    .line 85
    :catchall_2
    move-exception v0

    :try_start_9
    monitor-exit v2
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    :try_start_a
    throw v0
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_0
.end method

.method private static read24(Ljava/io/DataInputStream;)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 146
    invoke-virtual {p0}, Ljava/io/DataInputStream;->readUnsignedByte()I

    move-result v0

    .line 147
    invoke-virtual {p0}, Ljava/io/DataInputStream;->readUnsignedByte()I

    move-result v1

    .line 148
    invoke-virtual {p0}, Ljava/io/DataInputStream;->readUnsignedByte()I

    move-result v2

    .line 149
    shl-int/lit8 v0, v0, 0x10

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    or-int/2addr v0, v2

    return v0
.end method

.method static declared-synchronized ready()Z
    .locals 2

    .prologue
    .line 153
    const-class v1, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrTrigram;->sWords:[Ljava/lang/String;

    if-nez v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrTrigram;->sNative:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    monitor-exit v1

    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static use(Ljava/io/File;)V
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 34
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    .line 36
    :cond_0
    const-class v1, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v1

    .line 37
    if-nez v0, :cond_2

    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrTrigram;->sPath:Ljava/lang/String;

    if-nez v2, :cond_3

    :cond_1
    monitor-exit v1

    .line 71
    :goto_0
    return-void

    .line 37
    :cond_2
    sget-object v2, Lcom/mrkeyboard/app/MrTrigram;->sPath:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 38
    :cond_3
    sput-object v0, Lcom/mrkeyboard/app/MrTrigram;->sPath:Ljava/lang/String;

    .line 39
    sget v2, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    add-int/lit8 v2, v2, 0x1

    sput v2, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    .line 40
    const/4 v3, 0x0

    sput-object v3, Lcom/mrkeyboard/app/MrTrigram;->sWords:[Ljava/lang/String;

    .line 41
    const/4 v3, 0x0

    sput-object v3, Lcom/mrkeyboard/app/MrTrigram;->sKeys:[J

    .line 42
    const/4 v3, 0x0

    sput-object v3, Lcom/mrkeyboard/app/MrTrigram;->sStart:[I

    .line 43
    const/4 v3, 0x0

    sput-object v3, Lcom/mrkeyboard/app/MrTrigram;->sNext:[I

    .line 44
    const/4 v3, 0x0

    sput-object v3, Lcom/mrkeyboard/app/MrTrigram;->sScore:[B

    .line 45
    const/4 v3, 0x0

    sput-boolean v3, Lcom/mrkeyboard/app/MrTrigram;->sNative:Z

    .line 46
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 47
    if-nez v0, :cond_4

    .line 48
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->triClose()V

    goto :goto_0

    .line 46
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 51
    :cond_4
    new-instance v1, Ljava/lang/Thread;

    new-instance v3, Lcom/mrkeyboard/app/MrTrigram$1;

    invoke-direct {v3, v0, v2, p0}, Lcom/mrkeyboard/app/MrTrigram$1;-><init>(Ljava/lang/String;ILjava/io/File;)V

    const-string v0, "MrTrigram"

    invoke-direct {v1, v3, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 69
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Ljava/lang/Thread;->setPriority(I)V

    .line 70
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method
