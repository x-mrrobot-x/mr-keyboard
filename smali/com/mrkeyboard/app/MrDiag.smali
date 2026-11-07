.class final Lcom/mrkeyboard/app/MrDiag;
.super Ljava/lang/Object;
.source "MrDiag.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrDiag$Report;
    }
.end annotation


# static fields
.field static volatile sDictNs:J

.field static volatile sDictPath:Ljava/lang/String;

.field static volatile sEngineNs:J

.field static volatile sRulesNs:J

.field static volatile sTriNs:J

.field static volatile sTriPath:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const-wide/16 v0, -0x1

    .line 27
    sput-wide v0, Lcom/mrkeyboard/app/MrDiag;->sEngineNs:J

    .line 28
    sput-wide v0, Lcom/mrkeyboard/app/MrDiag;->sRulesNs:J

    .line 29
    sput-wide v0, Lcom/mrkeyboard/app/MrDiag;->sDictNs:J

    .line 31
    sput-wide v0, Lcom/mrkeyboard/app/MrDiag;->sTriNs:J

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static bytesText(J)Ljava/lang/String;
    .locals 10

    .prologue
    const/4 v2, 0x1

    const/4 v8, 0x0

    .line 167
    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-gez v0, :cond_0

    const-string v0, "?"

    .line 169
    :goto_0
    return-object v0

    .line 168
    :cond_0
    const-wide/32 v0, 0xf4240

    cmp-long v0, p0, v0

    if-ltz v0, :cond_1

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    const-string v1, "%.1f MB"

    new-array v2, v2, [Ljava/lang/Object;

    long-to-double v4, p0

    const-wide v6, 0x412e848000000000L    # 1000000.0

    div-double/2addr v4, v6

    invoke-static {v4, v5}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v3

    aput-object v3, v2, v8

    invoke-static {v0, v1, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 169
    :cond_1
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    const-string v1, "%d KB"

    new-array v2, v2, [Ljava/lang/Object;

    const-wide/16 v4, 0x1f4

    add-long/2addr v4, p0

    const-wide/16 v6, 0x3e8

    div-long/2addr v4, v6

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    aput-object v3, v2, v8

    invoke-static {v0, v1, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static collect(Ljava/io/File;)Lcom/mrkeyboard/app/MrDiag$Report;
    .locals 8

    .prologue
    const-wide/16 v2, -0x1

    .line 47
    new-instance v4, Lcom/mrkeyboard/app/MrDiag$Report;

    invoke-direct {v4}, Lcom/mrkeyboard/app/MrDiag$Report;-><init>()V

    .line 48
    if-nez p0, :cond_0

    move-object v0, v4

    .line 71
    :goto_0
    return-object v0

    .line 49
    :cond_0
    invoke-virtual {p0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_4

    invoke-virtual {p0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v0

    :goto_1
    iput-object v0, v4, Lcom/mrkeyboard/app/MrDiag$Report;->id:Ljava/lang/String;

    .line 51
    :try_start_0
    invoke-virtual {p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, v4, Lcom/mrkeyboard/app/MrDiag$Report;->version:I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 55
    :goto_2
    new-instance v0, Ljava/io/File;

    const-string v1, "main.dict"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 56
    new-instance v5, Ljava/io/File;

    const-string v1, "trigrams.bin"

    invoke-direct {v5, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 57
    sget-wide v6, Lcom/mrkeyboard/app/MrDiag;->sEngineNs:J

    iput-wide v6, v4, Lcom/mrkeyboard/app/MrDiag$Report;->engineNs:J

    .line 58
    sget-wide v6, Lcom/mrkeyboard/app/MrDiag;->sRulesNs:J

    iput-wide v6, v4, Lcom/mrkeyboard/app/MrDiag$Report;->rulesNs:J

    .line 59
    invoke-virtual {v0}, Ljava/io/File;->isFile()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 60
    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v6

    iput-wide v6, v4, Lcom/mrkeyboard/app/MrDiag$Report;->dictBytes:J

    .line 61
    invoke-static {v0}, Lcom/mrkeyboard/app/MrDiag;->resident(Ljava/io/File;)J

    move-result-wide v6

    iput-wide v6, v4, Lcom/mrkeyboard/app/MrDiag$Report;->dictMem:J

    .line 62
    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/mrkeyboard/app/MrDiag;->sDictPath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    sget-wide v0, Lcom/mrkeyboard/app/MrDiag;->sDictNs:J

    :goto_3
    iput-wide v0, v4, Lcom/mrkeyboard/app/MrDiag$Report;->dictNs:J

    .line 64
    :cond_1
    invoke-virtual {v5}, Ljava/io/File;->isFile()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 65
    const/4 v0, 0x1

    iput-boolean v0, v4, Lcom/mrkeyboard/app/MrDiag$Report;->hasTri:Z

    .line 66
    invoke-virtual {v5}, Ljava/io/File;->length()J

    move-result-wide v0

    iput-wide v0, v4, Lcom/mrkeyboard/app/MrDiag$Report;->triBytes:J

    .line 67
    invoke-static {v5}, Lcom/mrkeyboard/app/MrDiag;->resident(Ljava/io/File;)J

    move-result-wide v0

    iput-wide v0, v4, Lcom/mrkeyboard/app/MrDiag$Report;->triMem:J

    .line 68
    invoke-virtual {v5}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/mrkeyboard/app/MrDiag;->sTriPath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    sget-wide v2, Lcom/mrkeyboard/app/MrDiag;->sTriNs:J

    :cond_2
    iput-wide v2, v4, Lcom/mrkeyboard/app/MrDiag$Report;->triNs:J

    .line 69
    invoke-static {v5}, Lcom/mrkeyboard/app/MrDiag;->formatOf(Ljava/io/File;)I

    move-result v0

    iput v0, v4, Lcom/mrkeyboard/app/MrDiag$Report;->triFormat:I

    :cond_3
    move-object v0, v4

    .line 71
    goto :goto_0

    .line 49
    :cond_4
    const-string v0, ""

    goto :goto_1

    .line 52
    :catch_0
    move-exception v0

    .line 53
    const/4 v0, 0x0

    iput v0, v4, Lcom/mrkeyboard/app/MrDiag$Report;->version:I

    goto :goto_2

    :cond_5
    move-wide v0, v2

    .line 62
    goto :goto_3
.end method

.method static formatOf(Ljava/io/File;)I
    .locals 8

    .prologue
    const/4 v1, 0x2

    const/4 v0, 0x1

    const/4 v7, 0x4

    const/4 v2, 0x0

    .line 76
    const/4 v4, 0x0

    .line 78
    :try_start_0
    new-instance v3, Ljava/io/FileInputStream;

    invoke-direct {v3, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 79
    const/4 v4, 0x4

    :try_start_1
    new-array v5, v4, [B

    move v4, v2

    .line 81
    :goto_0
    if-ge v4, v7, :cond_0

    .line 82
    rsub-int/lit8 v6, v4, 0x4

    invoke-virtual {v3, v5, v4, v6}, Ljava/io/FileInputStream;->read([BII)I

    move-result v6

    .line 83
    if-gtz v6, :cond_2

    .line 86
    :cond_0
    if-ne v4, v7, :cond_5

    const/4 v4, 0x0

    aget-byte v4, v5, v4

    const/16 v6, 0x4d

    if-ne v4, v6, :cond_5

    const/4 v4, 0x1

    aget-byte v4, v5, v4

    const/16 v6, 0x52

    if-ne v4, v6, :cond_5

    const/4 v4, 0x2

    aget-byte v4, v5, v4

    const/16 v6, 0x54

    if-ne v4, v6, :cond_5

    .line 87
    const/4 v4, 0x3

    aget-byte v4, v5, v4
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    const/16 v6, 0x31

    if-ne v4, v6, :cond_3

    .line 93
    if-eqz v3, :cond_1

    .line 94
    :try_start_2
    invoke-virtual {v3}, Ljava/io/FileInputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    .line 97
    :cond_1
    :goto_1
    return v0

    .line 84
    :cond_2
    add-int/2addr v4, v6

    .line 85
    goto :goto_0

    .line 88
    :cond_3
    const/4 v0, 0x3

    :try_start_3
    aget-byte v0, v5, v0
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_6
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    const/16 v4, 0x32

    if-ne v0, v4, :cond_5

    .line 93
    if-eqz v3, :cond_4

    .line 94
    :try_start_4
    invoke-virtual {v3}, Ljava/io/FileInputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    :cond_4
    :goto_2
    move v0, v1

    .line 88
    goto :goto_1

    .line 93
    :cond_5
    if-eqz v3, :cond_6

    .line 94
    :try_start_5
    invoke-virtual {v3}, Ljava/io/FileInputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_4

    :cond_6
    :goto_3
    move v0, v2

    .line 97
    goto :goto_1

    .line 90
    :catch_0
    move-exception v0

    move-object v0, v4

    .line 93
    :goto_4
    if-eqz v0, :cond_6

    .line 94
    :try_start_6
    invoke-virtual {v0}, Ljava/io/FileInputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_1

    goto :goto_3

    :catch_1
    move-exception v0

    goto :goto_3

    .line 93
    :catchall_0
    move-exception v0

    move-object v3, v4

    :goto_5
    if-eqz v3, :cond_7

    .line 94
    :try_start_7
    invoke-virtual {v3}, Ljava/io/FileInputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_5

    .line 96
    :cond_7
    :goto_6
    throw v0

    .line 94
    :catch_2
    move-exception v1

    goto :goto_1

    :catch_3
    move-exception v0

    goto :goto_2

    :catch_4
    move-exception v0

    goto :goto_3

    :catch_5
    move-exception v1

    goto :goto_6

    .line 93
    :catchall_1
    move-exception v0

    goto :goto_5

    .line 90
    :catch_6
    move-exception v0

    move-object v0, v3

    goto :goto_4
.end method

.method private static kb(Ljava/lang/String;)J
    .locals 8

    .prologue
    .line 151
    const-wide/16 v2, 0x0

    .line 152
    const/4 v1, 0x0

    .line 153
    const/16 v0, 0x3a

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v0, v4, :cond_2

    .line 154
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 155
    const/16 v5, 0x30

    if-lt v4, v5, :cond_1

    const/16 v5, 0x39

    if-gt v4, v5, :cond_1

    .line 156
    const-wide/16 v6, 0xa

    mul-long/2addr v2, v6

    add-int/lit8 v1, v4, -0x30

    int-to-long v4, v1

    add-long/2addr v2, v4

    .line 157
    const/4 v1, 0x1

    .line 153
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 158
    :cond_1
    if-eqz v1, :cond_0

    .line 162
    :cond_2
    return-wide v2
.end method

.method static msText(J)Ljava/lang/String;
    .locals 8

    .prologue
    .line 174
    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-gez v0, :cond_0

    const-string v0, "?"

    .line 175
    :goto_0
    return-object v0

    :cond_0
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    const-string v1, "%.1f"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    long-to-double v4, p0

    const-wide v6, 0x412e848000000000L    # 1000000.0

    div-double/2addr v4, v6

    invoke-static {v4, v5}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v0, v1, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static resident(Ljava/io/File;)J
    .locals 3

    .prologue
    .line 113
    const/4 v0, 0x0

    .line 115
    :try_start_0
    new-instance v2, Ljava/io/FileReader;

    const-string v1, "/proc/self/smaps"

    invoke-direct {v2, v1}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 116
    :try_start_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrDiag;->tail(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrDiag;->residentIn(Ljava/io/Reader;Ljava/lang/String;)J
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-wide v0

    .line 120
    if-eqz v2, :cond_0

    .line 121
    :try_start_2
    invoke-virtual {v2}, Ljava/io/Reader;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    .line 118
    :cond_0
    :goto_0
    return-wide v0

    .line 117
    :catch_0
    move-exception v1

    move-object v2, v0

    .line 118
    :goto_1
    const-wide/16 v0, -0x1

    .line 120
    if-eqz v2, :cond_0

    .line 121
    :try_start_3
    invoke-virtual {v2}, Ljava/io/Reader;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_0

    :catch_1
    move-exception v2

    goto :goto_0

    .line 120
    :catchall_0
    move-exception v1

    move-object v2, v0

    move-object v0, v1

    :goto_2
    if-eqz v2, :cond_1

    .line 121
    :try_start_4
    invoke-virtual {v2}, Ljava/io/Reader;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    .line 123
    :cond_1
    :goto_3
    throw v0

    .line 121
    :catch_2
    move-exception v2

    goto :goto_0

    :catch_3
    move-exception v1

    goto :goto_3

    .line 120
    :catchall_1
    move-exception v0

    goto :goto_2

    .line 117
    :catch_4
    move-exception v0

    goto :goto_1
.end method

.method static residentIn(Ljava/io/Reader;Ljava/lang/String;)J
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const-wide/16 v4, 0x0

    const/4 v1, 0x0

    .line 132
    new-instance v8, Ljava/io/BufferedReader;

    const/16 v0, 0x4000

    invoke-direct {v8, p0, v0}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V

    move v0, v1

    move-wide v2, v4

    move-wide v6, v4

    .line 136
    :cond_0
    :goto_0
    invoke-virtual {v8}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v9

    if-eqz v9, :cond_7

    .line 137
    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v10

    if-eqz v10, :cond_0

    .line 138
    invoke-virtual {v9, v1}, Ljava/lang/String;->charAt(I)C

    move-result v10

    .line 139
    const/16 v11, 0x30

    if-lt v10, v11, :cond_1

    const/16 v11, 0x39

    if-le v10, v11, :cond_2

    :cond_1
    const/16 v11, 0x61

    if-lt v10, v11, :cond_5

    const/16 v11, 0x66

    if-gt v10, v11, :cond_5

    .line 140
    :cond_2
    invoke-virtual {v9, p1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v10, " (deleted)"

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v9, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    :cond_3
    const/4 v0, 0x1

    goto :goto_0

    :cond_4
    move v0, v1

    goto :goto_0

    .line 143
    :cond_5
    if-eqz v0, :cond_0

    .line 144
    const-string v10, "Pss:"

    invoke-virtual {v9, v10}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_6

    invoke-static {v9}, Lcom/mrkeyboard/app/MrDiag;->kb(Ljava/lang/String;)J

    move-result-wide v10

    add-long/2addr v6, v10

    goto :goto_0

    .line 145
    :cond_6
    const-string v10, "Rss:"

    invoke-virtual {v9, v10}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_0

    invoke-static {v9}, Lcom/mrkeyboard/app/MrDiag;->kb(Ljava/lang/String;)J

    move-result-wide v10

    add-long/2addr v2, v10

    goto :goto_0

    .line 147
    :cond_7
    cmp-long v0, v6, v4

    if-lez v0, :cond_8

    :goto_1
    const-wide/16 v0, 0x400

    mul-long/2addr v0, v6

    return-wide v0

    :cond_8
    move-wide v6, v2

    goto :goto_1
.end method

.method static tail(Ljava/io/File;)Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 102
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    move v0, v1

    .line 104
    :goto_0
    const/4 v3, 0x4

    if-ge v0, v3, :cond_0

    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_0

    .line 105
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "/"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v1, v3}, Ljava/lang/StringBuilder;->insert(ILjava/lang/String;)Ljava/lang/StringBuilder;

    .line 106
    invoke-virtual {p0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object p0

    .line 104
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 108
    :cond_0
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
