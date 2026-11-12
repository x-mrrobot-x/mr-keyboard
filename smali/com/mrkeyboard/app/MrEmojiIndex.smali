.class final Lcom/mrkeyboard/app/MrEmojiIndex;
.super Ljava/lang/Object;
.source "MrEmojiIndex.java"


# static fields
.field private static final KEYWORD:I = 0x1

.field static final LANGS:[Ljava/lang/String;

.field static final MAX_WORDS:I = 0x5

.field private static final NAME:I


# instance fields
.field private final chars:[[C

.field private final emoji:[Ljava/lang/String;

.field private final first:[[I

.field private final kind:[[B

.field private final n:I

.field private final start:[[I

.field private final work:[J


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 35
    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "en"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "pt"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "es"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrEmojiIndex;->LANGS:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>([Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 44
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiIndex;->LANGS:[Ljava/lang/String;

    array-length v0, v0

    new-array v0, v0, [[C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->chars:[[C

    .line 45
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiIndex;->LANGS:[Ljava/lang/String;

    array-length v0, v0

    new-array v0, v0, [[I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->start:[[I

    .line 46
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiIndex;->LANGS:[Ljava/lang/String;

    array-length v0, v0

    new-array v0, v0, [[B

    iput-object v0, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->kind:[[B

    .line 47
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiIndex;->LANGS:[Ljava/lang/String;

    array-length v0, v0

    new-array v0, v0, [[I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->first:[[I

    .line 51
    iput-object p1, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->emoji:[Ljava/lang/String;

    .line 52
    array-length v0, p1

    iput v0, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->n:I

    .line 53
    iget v0, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->n:I

    new-array v0, v0, [J

    iput-object v0, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->work:[J

    .line 54
    return-void
.end method

.method private static begins([CILjava/lang/String;)Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 258
    move v0, v1

    :goto_0
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v0, v2, :cond_1

    .line 259
    add-int v2, p1, v0

    aget-char v2, p0, v2

    invoke-virtual {p2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    if-eq v2, v3, :cond_0

    .line 261
    :goto_1
    return v1

    .line 258
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 261
    :cond_1
    const/4 v1, 0x1

    goto :goto_1
.end method

.method private build(I[Ljava/lang/String;Ljava/util/HashMap;)V
    .locals 18
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I[",
            "Ljava/lang/String;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 111
    move-object/from16 v0, p0

    iget v1, v0, Lcom/mrkeyboard/app/MrEmojiIndex;->n:I

    add-int/lit8 v1, v1, 0x1

    new-array v9, v1, [I

    .line 112
    if-nez p2, :cond_0

    .line 113
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrEmojiIndex;->chars:[[C

    const/4 v2, 0x0

    new-array v2, v2, [C

    aput-object v2, v1, p1

    .line 114
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrEmojiIndex;->start:[[I

    const/4 v2, 0x1

    new-array v2, v2, [I

    const/4 v3, 0x0

    const/4 v4, 0x0

    aput v4, v2, v3

    aput-object v2, v1, p1

    .line 115
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrEmojiIndex;->kind:[[B

    const/4 v2, 0x0

    new-array v2, v2, [B

    aput-object v2, v1, p1

    .line 116
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrEmojiIndex;->first:[[I

    aput-object v9, v1, p1

    .line 158
    :goto_0
    return-void

    .line 119
    :cond_0
    move-object/from16 v0, p0

    iget v1, v0, Lcom/mrkeyboard/app/MrEmojiIndex;->n:I

    new-array v10, v1, [Ljava/lang/String;

    .line 120
    move-object/from16 v0, p2

    array-length v3, v0

    const/4 v1, 0x0

    move v2, v1

    :goto_1
    if-ge v2, v3, :cond_3

    aget-object v4, p2, v2

    .line 121
    const/16 v1, 0x9

    invoke-virtual {v4, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v5

    .line 122
    if-gtz v5, :cond_2

    .line 120
    :cond_1
    :goto_2
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_1

    .line 123
    :cond_2
    const/4 v1, 0x0

    invoke-virtual {v4, v1, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    move-object/from16 v0, p3

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    .line 124
    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    add-int/lit8 v5, v5, 0x1

    invoke-virtual {v4, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v10, v1

    goto :goto_2

    .line 126
    :cond_3
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    .line 127
    const/16 v1, 0x40

    new-array v4, v1, [I

    .line 128
    const/16 v1, 0x40

    new-array v3, v1, [B

    .line 129
    const/4 v2, 0x0

    .line 130
    const/4 v1, 0x0

    :goto_3
    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrEmojiIndex;->n:I

    if-ge v1, v5, :cond_a

    .line 131
    aput v2, v9, v1

    .line 132
    aget-object v5, v10, v1

    if-nez v5, :cond_4

    .line 130
    :goto_4
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    .line 134
    :cond_4
    aget-object v5, v10, v1

    const-string v6, "[|]"

    invoke-virtual {v5, v6}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v12

    .line 135
    const/4 v5, 0x0

    move-object v6, v4

    move v4, v2

    move-object/from16 v17, v3

    move v3, v5

    move-object/from16 v5, v17

    :goto_5
    array-length v7, v12

    if-ge v3, v7, :cond_b

    .line 136
    aget-object v7, v12, v3

    invoke-static {v7}, Lcom/mrkeyboard/app/MrEmojiIndex;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v8, " "

    invoke-virtual {v7, v8}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v13

    .line 137
    array-length v14, v13

    const/4 v7, 0x0

    move v8, v7

    :goto_6
    if-ge v8, v14, :cond_9

    aget-object v15, v13, v8

    .line 138
    invoke-virtual {v15}, Ljava/lang/String;->length()I

    move-result v7

    if-eqz v7, :cond_5

    invoke-static {v11, v6, v2, v4, v15}, Lcom/mrkeyboard/app/MrEmojiIndex;->seen(Ljava/lang/StringBuilder;[IIILjava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_6

    .line 137
    :cond_5
    :goto_7
    add-int/lit8 v7, v8, 0x1

    move v8, v7

    goto :goto_6

    .line 139
    :cond_6
    add-int/lit8 v7, v4, 0x1

    array-length v0, v6

    move/from16 v16, v0

    move/from16 v0, v16

    if-lt v7, v0, :cond_7

    .line 140
    array-length v7, v6

    mul-int/lit8 v7, v7, 0x2

    invoke-static {v6, v7}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v6

    .line 141
    array-length v7, v5

    mul-int/lit8 v7, v7, 0x2

    invoke-static {v5, v7}, Ljava/util/Arrays;->copyOf([BI)[B

    move-result-object v5

    .line 143
    :cond_7
    invoke-virtual {v11}, Ljava/lang/StringBuilder;->length()I

    move-result v7

    aput v7, v6, v4

    .line 144
    if-nez v3, :cond_8

    const/4 v7, 0x0

    :goto_8
    int-to-byte v7, v7

    aput-byte v7, v5, v4

    .line 145
    invoke-virtual {v11, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 146
    add-int/lit8 v4, v4, 0x1

    goto :goto_7

    .line 144
    :cond_8
    const/4 v7, 0x1

    goto :goto_8

    .line 135
    :cond_9
    add-int/lit8 v3, v3, 0x1

    goto :goto_5

    .line 150
    :cond_a
    move-object/from16 v0, p0

    iget v1, v0, Lcom/mrkeyboard/app/MrEmojiIndex;->n:I

    aput v2, v9, v1

    .line 151
    invoke-virtual {v11}, Ljava/lang/StringBuilder;->length()I

    move-result v1

    aput v1, v4, v2

    .line 152
    invoke-virtual {v11}, Ljava/lang/StringBuilder;->length()I

    move-result v1

    new-array v1, v1, [C

    .line 153
    const/4 v5, 0x0

    array-length v6, v1

    const/4 v7, 0x0

    invoke-virtual {v11, v5, v6, v1, v7}, Ljava/lang/StringBuilder;->getChars(II[CI)V

    .line 154
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrEmojiIndex;->chars:[[C

    aput-object v1, v5, p1

    .line 155
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrEmojiIndex;->start:[[I

    add-int/lit8 v5, v2, 0x1

    invoke-static {v4, v5}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v4

    aput-object v4, v1, p1

    .line 156
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrEmojiIndex;->kind:[[B

    invoke-static {v3, v2}, Ljava/util/Arrays;->copyOf([BI)[B

    move-result-object v2

    aput-object v2, v1, p1

    .line 157
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrEmojiIndex;->first:[[I

    aput-object v9, v1, p1

    goto/16 :goto_0

    :cond_b
    move v2, v4

    move-object v3, v5

    move-object v4, v6

    goto/16 :goto_4
.end method

.method static normalize(Ljava/lang/String;)Ljava/lang/String;
    .locals 10

    .prologue
    const/16 v9, 0x20

    const/4 v3, 0x1

    const/4 v1, 0x0

    .line 176
    if-nez p0, :cond_0

    const-string v0, ""

    .line 196
    :goto_0
    return-object v0

    .line 177
    :cond_0
    sget-object v0, Ljava/text/Normalizer$Form;->NFD:Ljava/text/Normalizer$Form;

    invoke-static {p0, v0}, Ljava/text/Normalizer;->normalize(Ljava/lang/CharSequence;Ljava/text/Normalizer$Form;)Ljava/lang/String;

    move-result-object v4

    .line 178
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v0

    invoke-direct {v5, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    move v0, v1

    move v2, v3

    .line 180
    :goto_1
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v6

    if-ge v0, v6, :cond_4

    .line 181
    invoke-virtual {v4, v0}, Ljava/lang/String;->charAt(I)C

    move-result v6

    .line 182
    invoke-static {v6}, Ljava/lang/Character;->getType(C)I

    move-result v7

    .line 183
    const/4 v8, 0x6

    if-eq v7, v8, :cond_1

    const/16 v8, 0x8

    if-eq v7, v8, :cond_1

    const/4 v8, 0x7

    if-ne v7, v8, :cond_2

    .line 180
    :cond_1
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 187
    :cond_2
    invoke-static {v6}, Ljava/lang/Character;->isLetterOrDigit(C)Z

    move-result v7

    if-eqz v7, :cond_3

    .line 188
    invoke-static {v6}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v2

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move v2, v1

    .line 189
    goto :goto_2

    .line 190
    :cond_3
    if-nez v2, :cond_1

    .line 191
    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move v2, v3

    .line 192
    goto :goto_2

    .line 195
    :cond_4
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    if-lez v0, :cond_5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->charAt(I)C

    move-result v0

    if-ne v0, v9, :cond_5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->setLength(I)V

    .line 196
    :cond_5
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static parse([Ljava/io/InputStream;)Lcom/mrkeyboard/app/MrEmojiIndex;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 74
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiIndex;->LANGS:[Ljava/lang/String;

    array-length v0, v0

    new-array v4, v0, [[Ljava/lang/String;

    .line 75
    const/4 v0, -0x1

    move v2, v0

    move v0, v1

    .line 76
    :goto_0
    sget-object v3, Lcom/mrkeyboard/app/MrEmojiIndex;->LANGS:[Ljava/lang/String;

    array-length v3, v3

    if-ge v0, v3, :cond_1

    .line 77
    array-length v3, p0

    if-ge v0, v3, :cond_0

    aget-object v3, p0, v0

    if-eqz v3, :cond_0

    .line 78
    aget-object v3, p0, v0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrEmojiIndex;->readLines(Ljava/io/InputStream;)[Ljava/lang/String;

    move-result-object v3

    aput-object v3, v4, v0

    .line 79
    if-gez v2, :cond_0

    move v2, v0

    .line 76
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 82
    :cond_1
    if-gez v2, :cond_3

    new-instance v0, Lcom/mrkeyboard/app/MrEmojiIndex;

    new-array v1, v1, [Ljava/lang/String;

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrEmojiIndex;-><init>([Ljava/lang/String;)V

    .line 92
    :cond_2
    return-object v0

    .line 83
    :cond_3
    aget-object v0, v4, v2

    array-length v0, v0

    new-array v5, v0, [Ljava/lang/String;

    .line 84
    new-instance v6, Ljava/util/HashMap;

    invoke-direct {v6}, Ljava/util/HashMap;-><init>()V

    move v0, v1

    .line 85
    :goto_1
    array-length v3, v5

    if-ge v0, v3, :cond_5

    .line 86
    aget-object v3, v4, v2

    aget-object v3, v3, v0

    const/16 v7, 0x9

    invoke-virtual {v3, v7}, Ljava/lang/String;->indexOf(I)I

    move-result v3

    .line 87
    if-gez v3, :cond_4

    aget-object v3, v4, v2

    aget-object v3, v3, v0

    :goto_2
    aput-object v3, v5, v0

    .line 88
    aget-object v3, v5, v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v6, v3, v7}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 85
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 87
    :cond_4
    aget-object v7, v4, v2

    aget-object v7, v7, v0

    invoke-virtual {v7, v1, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    goto :goto_2

    .line 90
    :cond_5
    new-instance v0, Lcom/mrkeyboard/app/MrEmojiIndex;

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrEmojiIndex;-><init>([Ljava/lang/String;)V

    .line 91
    :goto_3
    sget-object v2, Lcom/mrkeyboard/app/MrEmojiIndex;->LANGS:[Ljava/lang/String;

    array-length v2, v2

    if-ge v1, v2, :cond_2

    aget-object v2, v4, v1

    invoke-direct {v0, v1, v2, v6}, Lcom/mrkeyboard/app/MrEmojiIndex;->build(I[Ljava/lang/String;Ljava/util/HashMap;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_3
.end method

.method private static readLines(Ljava/io/InputStream;)[Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 96
    new-instance v1, Ljava/io/BufferedReader;

    new-instance v0, Ljava/io/InputStreamReader;

    const-string v2, "UTF-8"

    invoke-direct {v0, p0, v2}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v1, v0}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 97
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 100
    :cond_0
    :goto_0
    :try_start_0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 101
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-eqz v3, :cond_0

    const-string v3, "# "

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 102
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 105
    :catchall_0
    move-exception v0

    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V

    .line 106
    throw v0

    .line 105
    :cond_1
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V

    .line 107
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    new-array v1, v1, [Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    return-object v0
.end method

.method private score(II[Ljava/lang/String;I)I
    .locals 13

    .prologue
    .line 233
    iget-object v1, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->first:[[I

    aget-object v1, v1, p1

    aget v5, v1, p2

    .line 234
    iget-object v1, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->first:[[I

    aget-object v1, v1, p1

    add-int/lit8 v2, p2, 0x1

    aget v7, v1, v2

    .line 235
    if-ne v5, v7, :cond_0

    const/4 v1, 0x0

    .line 254
    :goto_0
    return v1

    .line 236
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->chars:[[C

    aget-object v8, v1, p1

    .line 237
    iget-object v1, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->start:[[I

    aget-object v9, v1, p1

    .line 238
    const/4 v3, 0x0

    .line 239
    const/4 v1, 0x0

    move v6, v1

    :goto_1
    move/from16 v0, p4

    if-ge v6, v0, :cond_9

    .line 240
    aget-object v10, p3, v6

    .line 241
    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v11

    .line 242
    const/4 v2, 0x0

    move v4, v5

    .line 243
    :goto_2
    if-ge v4, v7, :cond_7

    .line 244
    add-int/lit8 v1, v4, 0x1

    aget v1, v9, v1

    aget v12, v9, v4

    sub-int/2addr v1, v12

    .line 245
    if-lt v1, v11, :cond_5

    aget v12, v9, v4

    invoke-static {v8, v12, v10}, Lcom/mrkeyboard/app/MrEmojiIndex;->begins([CILjava/lang/String;)Z

    move-result v12

    if-nez v12, :cond_2

    move v1, v2

    .line 243
    :cond_1
    :goto_3
    add-int/lit8 v2, v4, 0x1

    move v4, v2

    move v2, v1

    goto :goto_2

    .line 246
    :cond_2
    if-ne v1, v11, :cond_6

    const/4 v1, 0x6

    .line 247
    :goto_4
    iget-object v12, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->kind:[[B

    aget-object v12, v12, p1

    aget-byte v12, v12, v4

    if-nez v12, :cond_3

    add-int/lit8 v1, v1, 0x2

    .line 248
    :cond_3
    if-ne v4, v5, :cond_4

    if-nez v6, :cond_4

    add-int/lit8 v1, v1, 0x1

    .line 249
    :cond_4
    if-gt v1, v2, :cond_1

    :cond_5
    move v1, v2

    goto :goto_3

    .line 246
    :cond_6
    const/4 v1, 0x3

    goto :goto_4

    .line 251
    :cond_7
    if-nez v2, :cond_8

    const/4 v1, 0x0

    goto :goto_0

    .line 252
    :cond_8
    add-int/2addr v3, v2

    .line 239
    add-int/lit8 v1, v6, 0x1

    move v6, v1

    goto :goto_1

    :cond_9
    move v1, v3

    .line 254
    goto :goto_0
.end method

.method private static seen(Ljava/lang/StringBuilder;[IIILjava/lang/String;)Z
    .locals 2

    .prologue
    .line 162
    :goto_0
    if-ge p2, p3, :cond_2

    .line 163
    add-int/lit8 v0, p2, 0x1

    if-ge v0, p3, :cond_0

    add-int/lit8 v0, p2, 0x1

    aget v0, p1, v0

    .line 164
    :goto_1
    aget v1, p1, p2

    sub-int/2addr v0, v1

    invoke-virtual {p4}, Ljava/lang/String;->length()I

    move-result v1

    if-ne v0, v1, :cond_1

    aget v0, p1, p2

    invoke-virtual {p0, p4, v0}, Ljava/lang/StringBuilder;->indexOf(Ljava/lang/String;I)I

    move-result v0

    aget v1, p1, p2

    if-ne v0, v1, :cond_1

    const/4 v0, 0x1

    .line 166
    :goto_2
    return v0

    .line 163
    :cond_0
    invoke-virtual {p0}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    goto :goto_1

    .line 162
    :cond_1
    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 166
    :cond_2
    const/4 v0, 0x0

    goto :goto_2
.end method


# virtual methods
.method emoji(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 63
    iget-object v0, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->emoji:[Ljava/lang/String;

    aget-object v0, v0, p1

    return-object v0
.end method

.method search(Ljava/lang/String;Ljava/lang/String;I)[Ljava/lang/String;
    .locals 12

    .prologue
    .line 206
    invoke-static {p1}, Lcom/mrkeyboard/app/MrEmojiIndex;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 207
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_0

    if-lez p3, :cond_0

    iget v1, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->n:I

    if-nez v1, :cond_2

    :cond_0
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/String;

    .line 228
    :cond_1
    return-object v0

    .line 208
    :cond_2
    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v6

    .line 209
    array-length v0, v6

    const/4 v1, 0x5

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v7

    .line 210
    const/4 v1, -0x1

    .line 211
    const/4 v0, 0x0

    :goto_0
    sget-object v2, Lcom/mrkeyboard/app/MrEmojiIndex;->LANGS:[Ljava/lang/String;

    array-length v2, v2

    if-ge v0, v2, :cond_4

    .line 212
    sget-object v2, Lcom/mrkeyboard/app/MrEmojiIndex;->LANGS:[Ljava/lang/String;

    aget-object v2, v2, v0

    invoke-virtual {v2, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    move v1, v0

    .line 211
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 214
    :cond_4
    const/4 v2, 0x0

    .line 215
    const/4 v0, 0x0

    :goto_1
    iget v3, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->n:I

    if-ge v0, v3, :cond_9

    .line 216
    const/4 v4, 0x0

    .line 217
    const/4 v3, 0x0

    :goto_2
    sget-object v5, Lcom/mrkeyboard/app/MrEmojiIndex;->LANGS:[Ljava/lang/String;

    array-length v5, v5

    if-ge v3, v5, :cond_7

    .line 218
    invoke-direct {p0, v3, v0, v6, v7}, Lcom/mrkeyboard/app/MrEmojiIndex;->score(II[Ljava/lang/String;I)I

    move-result v5

    .line 219
    if-lez v5, :cond_5

    if-ne v3, v1, :cond_5

    add-int/lit8 v5, v5, 0x1

    .line 220
    :cond_5
    if-le v5, v4, :cond_6

    move v4, v5

    .line 217
    :cond_6
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 222
    :cond_7
    if-lez v4, :cond_8

    iget-object v5, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->work:[J

    add-int/lit8 v3, v2, 0x1

    rsub-int v4, v4, 0x7fff

    int-to-long v8, v4

    const/16 v4, 0x20

    shl-long/2addr v8, v4

    int-to-long v10, v0

    or-long/2addr v8, v10

    aput-wide v8, v5, v2

    move v2, v3

    .line 215
    :cond_8
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 224
    :cond_9
    iget-object v0, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->work:[J

    const/4 v1, 0x0

    invoke-static {v0, v1, v2}, Ljava/util/Arrays;->sort([JII)V

    .line 225
    invoke-static {v2, p3}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 226
    new-array v0, v2, [Ljava/lang/String;

    .line 227
    const/4 v1, 0x0

    :goto_3
    if-ge v1, v2, :cond_1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->emoji:[Ljava/lang/String;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->work:[J

    aget-wide v4, v4, v1

    const-wide v6, 0xffffffffL

    and-long/2addr v4, v6

    long-to-int v4, v4

    aget-object v3, v3, v4

    aput-object v3, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_3
.end method

.method size()I
    .locals 1

    .prologue
    .line 58
    iget v0, p0, Lcom/mrkeyboard/app/MrEmojiIndex;->n:I

    return v0
.end method
