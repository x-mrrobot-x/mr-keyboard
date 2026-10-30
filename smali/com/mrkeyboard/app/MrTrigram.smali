.class public final Lcom/mrkeyboard/app/MrTrigram;
.super Ljava/lang/Object;
.source "MrTrigram.java"


# static fields
.field private static sGen:I

.field private static sKeys:[J

.field private static sNext:[I

.field private static sPath:Ljava/lang/String;

.field private static sScore:[B

.field private static sStart:[I

.field private static sWords:[Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/io/InputStream;I)V
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
    .line 141
    const-class v5, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v5

    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrTrigram;->sWords:[Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v2, :cond_0

    if-eqz p0, :cond_0

    if-nez p1, :cond_2

    :cond_0
    const/4 v2, 0x0

    .line 161
    :cond_1
    :goto_0
    monitor-exit v5

    return v2

    .line 142
    :cond_2
    const/4 v2, 0x2

    :try_start_1
    new-array v4, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    aput-object p0, v4, v2

    const/4 v2, 0x1

    invoke-virtual/range {p0 .. p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v4, v2

    .line 143
    const/4 v2, 0x2

    new-array v6, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    aput-object p1, v6, v2

    const/4 v2, 0x1

    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v6, v2

    .line 144
    array-length v7, v4

    const/4 v2, 0x0

    move v3, v2

    :goto_1
    if-ge v3, v7, :cond_7

    aget-object v2, v4, v3

    .line 145
    invoke-static {v2}, Lcom/mrkeyboard/app/MrTrigram;->id(Ljava/lang/String;)I

    move-result v8

    .line 146
    if-gez v8, :cond_4

    .line 144
    :cond_3
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    goto :goto_1

    .line 147
    :cond_4
    array-length v9, v6

    const/4 v2, 0x0

    :goto_2
    if-ge v2, v9, :cond_3

    aget-object v10, v6, v2

    .line 148
    invoke-static {v10}, Lcom/mrkeyboard/app/MrTrigram;->id(Ljava/lang/String;)I

    move-result v10

    .line 149
    if-gez v10, :cond_6

    .line 147
    :cond_5
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 150
    :cond_6
    sget-object v11, Lcom/mrkeyboard/app/MrTrigram;->sKeys:[J

    int-to-long v12, v8

    const/16 v14, 0x20

    shl-long/2addr v12, v14

    int-to-long v14, v10

    or-long/2addr v12, v14

    invoke-static {v11, v12, v13}, Ljava/util/Arrays;->binarySearch([JJ)I

    move-result v10

    .line 151
    if-ltz v10, :cond_5

    .line 152
    const/4 v3, 0x0

    .line 153
    sget-object v2, Lcom/mrkeyboard/app/MrTrigram;->sStart:[I

    aget v2, v2, v10

    move/from16 v16, v2

    move v2, v3

    move/from16 v3, v16

    :goto_3
    sget-object v4, Lcom/mrkeyboard/app/MrTrigram;->sStart:[I

    add-int/lit8 v6, v10, 0x1

    aget v4, v4, v6

    if-ge v3, v4, :cond_1

    move-object/from16 v0, p2

    array-length v4, v0

    if-ge v2, v4, :cond_1

    .line 154
    sget-object v4, Lcom/mrkeyboard/app/MrTrigram;->sWords:[Ljava/lang/String;

    sget-object v6, Lcom/mrkeyboard/app/MrTrigram;->sNext:[I

    aget v6, v6, v3

    aget-object v4, v4, v6

    aput-object v4, p2, v2

    .line 155
    sget-object v4, Lcom/mrkeyboard/app/MrTrigram;->sScore:[B

    aget-byte v4, v4, v3

    and-int/lit16 v4, v4, 0xff

    aput v4, p3, v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 156
    add-int/lit8 v4, v2, 0x1

    .line 153
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    move v2, v4

    goto :goto_3

    .line 161
    :cond_7
    const/4 v2, 0x0

    goto :goto_0

    .line 141
    :catchall_0
    move-exception v2

    monitor-exit v5

    throw v2
.end method

.method private static id(Ljava/lang/String;)I
    .locals 2

    .prologue
    const/4 v1, -0x1

    .line 130
    sget-object v0, Lcom/mrkeyboard/app/MrTrigram;->sWords:[Ljava/lang/String;

    .line 131
    if-eqz v0, :cond_0

    if-nez p0, :cond_2

    :cond_0
    move v0, v1

    .line 133
    :cond_1
    :goto_0
    return v0

    .line 132
    :cond_2
    invoke-static {v0, p0}, Ljava/util/Arrays;->binarySearch([Ljava/lang/Object;Ljava/lang/Object;)I

    move-result v0

    .line 133
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
    .line 66
    const-class v1, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v1

    .line 67
    :try_start_0
    sget v0, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    .line 68
    const-string v2, "(teste)"

    sput-object v2, Lcom/mrkeyboard/app/MrTrigram;->sPath:Ljava/lang/String;

    .line 69
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 70
    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTrigram;->load(Ljava/io/InputStream;I)V

    .line 71
    return-void

    .line 69
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
    .line 75
    new-instance v3, Ljava/io/DataInputStream;

    new-instance v0, Ljava/io/BufferedInputStream;

    const/high16 v1, 0x10000

    invoke-direct {v0, p0, v1}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;I)V

    invoke-direct {v3, v0}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    .line 76
    const/4 v0, 0x4

    new-array v0, v0, [B

    .line 77
    invoke-virtual {v3, v0}, Ljava/io/DataInputStream;->readFully([B)V

    .line 78
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

    .line 79
    :cond_0
    new-instance v0, Ljava/io/IOException;

    const-string v1, "formato desconhecido"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 81
    :cond_1
    invoke-virtual {v3}, Ljava/io/DataInputStream;->readInt()I

    move-result v1

    .line 82
    new-array v4, v1, [Ljava/lang/String;

    .line 83
    const/16 v0, 0x100

    new-array v2, v0, [B

    .line 84
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v1, :cond_2

    .line 85
    invoke-virtual {v3}, Ljava/io/DataInputStream;->readUnsignedByte()I

    move-result v5

    .line 86
    const/4 v6, 0x0

    invoke-virtual {v3, v2, v6, v5}, Ljava/io/DataInputStream;->readFully([BII)V

    .line 87
    new-instance v6, Ljava/lang/String;

    const/4 v7, 0x0

    const-string v8, "UTF-8"

    invoke-direct {v6, v2, v7, v5, v8}, Ljava/lang/String;-><init>([BIILjava/lang/String;)V

    aput-object v6, v4, v0

    .line 84
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 89
    :cond_2
    invoke-virtual {v3}, Ljava/io/DataInputStream;->readInt()I

    move-result v5

    .line 90
    new-array v6, v5, [J

    .line 91
    add-int/lit8 v0, v5, 0x1

    new-array v7, v0, [I

    .line 92
    mul-int/lit8 v0, v5, 0x3

    new-array v8, v0, [I

    .line 93
    mul-int/lit8 v0, v5, 0x3

    new-array v9, v0, [B

    .line 94
    const/4 v1, 0x0

    .line 95
    const/4 v0, 0x0

    move v2, v0

    :goto_1
    if-ge v2, v5, :cond_4

    .line 96
    invoke-static {v3}, Lcom/mrkeyboard/app/MrTrigram;->read24(Ljava/io/DataInputStream;)I

    move-result v0

    int-to-long v10, v0

    .line 97
    invoke-static {v3}, Lcom/mrkeyboard/app/MrTrigram;->read24(Ljava/io/DataInputStream;)I

    move-result v0

    int-to-long v12, v0

    .line 98
    const/16 v0, 0x20

    shl-long/2addr v10, v0

    or-long/2addr v10, v12

    aput-wide v10, v6, v2

    .line 99
    aput v1, v7, v2

    .line 100
    invoke-virtual {v3}, Ljava/io/DataInputStream;->readUnsignedByte()I

    move-result v10

    .line 101
    const/4 v0, 0x0

    :goto_2
    if-ge v0, v10, :cond_3

    .line 102
    invoke-static {v3}, Lcom/mrkeyboard/app/MrTrigram;->read24(Ljava/io/DataInputStream;)I

    move-result v11

    aput v11, v8, v1

    .line 103
    invoke-virtual {v3}, Ljava/io/DataInputStream;->readUnsignedByte()I

    move-result v11

    int-to-byte v11, v11

    aput-byte v11, v9, v1

    .line 104
    add-int/lit8 v1, v1, 0x1

    .line 101
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 95
    :cond_3
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    .line 107
    :cond_4
    aput v1, v7, v5

    .line 108
    const-class v1, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v1

    .line 109
    :try_start_0
    sget v0, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    if-eq p1, v0, :cond_5

    monitor-exit v1

    .line 116
    :goto_3
    return-void

    .line 110
    :cond_5
    sput-object v6, Lcom/mrkeyboard/app/MrTrigram;->sKeys:[J

    .line 111
    sput-object v7, Lcom/mrkeyboard/app/MrTrigram;->sStart:[I

    .line 112
    sput-object v8, Lcom/mrkeyboard/app/MrTrigram;->sNext:[I

    .line 113
    sput-object v9, Lcom/mrkeyboard/app/MrTrigram;->sScore:[B

    .line 114
    sput-object v4, Lcom/mrkeyboard/app/MrTrigram;->sWords:[Ljava/lang/String;

    .line 115
    monitor-exit v1

    goto :goto_3

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private static read24(Ljava/io/DataInputStream;)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 119
    invoke-virtual {p0}, Ljava/io/DataInputStream;->readUnsignedByte()I

    move-result v0

    .line 120
    invoke-virtual {p0}, Ljava/io/DataInputStream;->readUnsignedByte()I

    move-result v1

    .line 121
    invoke-virtual {p0}, Ljava/io/DataInputStream;->readUnsignedByte()I

    move-result v2

    .line 122
    shl-int/lit8 v0, v0, 0x10

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    or-int/2addr v0, v2

    return v0
.end method

.method static declared-synchronized ready()Z
    .locals 2

    .prologue
    .line 126
    const-class v1, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrTrigram;->sWords:[Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    monitor-exit v1

    return v0

    :cond_0
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

    .line 32
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    .line 34
    :cond_0
    const-class v1, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v1

    .line 35
    if-nez v0, :cond_3

    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrTrigram;->sPath:Ljava/lang/String;

    if-nez v2, :cond_4

    :cond_1
    monitor-exit v1

    .line 62
    :cond_2
    :goto_0
    return-void

    .line 35
    :cond_3
    sget-object v2, Lcom/mrkeyboard/app/MrTrigram;->sPath:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 36
    :cond_4
    sput-object v0, Lcom/mrkeyboard/app/MrTrigram;->sPath:Ljava/lang/String;

    .line 37
    sget v2, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    add-int/lit8 v2, v2, 0x1

    sput v2, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    .line 38
    const/4 v3, 0x0

    sput-object v3, Lcom/mrkeyboard/app/MrTrigram;->sWords:[Ljava/lang/String;

    .line 39
    const/4 v3, 0x0

    sput-object v3, Lcom/mrkeyboard/app/MrTrigram;->sKeys:[J

    .line 40
    const/4 v3, 0x0

    sput-object v3, Lcom/mrkeyboard/app/MrTrigram;->sStart:[I

    .line 41
    const/4 v3, 0x0

    sput-object v3, Lcom/mrkeyboard/app/MrTrigram;->sNext:[I

    .line 42
    const/4 v3, 0x0

    sput-object v3, Lcom/mrkeyboard/app/MrTrigram;->sScore:[B

    .line 43
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 44
    if-eqz v0, :cond_2

    .line 45
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/mrkeyboard/app/MrTrigram$1;

    invoke-direct {v1, p0, v2}, Lcom/mrkeyboard/app/MrTrigram$1;-><init>(Ljava/io/File;I)V

    const-string v2, "MrTrigram"

    invoke-direct {v0, v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 60
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/Thread;->setPriority(I)V

    .line 61
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    goto :goto_0

    .line 43
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method
