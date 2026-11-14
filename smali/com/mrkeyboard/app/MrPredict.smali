.class public final Lcom/mrkeyboard/app/MrPredict;
.super Ljava/lang/Object;
.source "MrPredict.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrPredict$UserCollector;
    }
.end annotation


# static fields
.field static final CTX_FREQ:I = 0xff

.field static final CTX_MAX:I = 0x2

.field static final CTX_MAX_LETTERS:I = 0xc

.field static final CTX_STEP:I = 0x28

.field static final LOOKBACK:I = 0x60

.field static final MAX_BIGRAMS:I = 0x3c

.field private static final MAX_CAND:I = 0xf8

.field static final MAX_WORD:I = 0x30

.field static final SHOW:I = 0x3

.field static final TRIGRAM_BONUS:I = 0x80

.field private static sCount:I

.field private static sCtx1:Ljava/lang/String;

.field private static sCtx2:Ljava/lang/String;

.field private static final sFreq:[I

.field private static sInitialCount:I

.field private static final sInitials:[I

.field private static final sMain:[I

.field private static final sOut:[C

.field private static sPrev:Ljava/lang/String;

.field private static final sTriScores:[I

.field private static final sTriWords:[Ljava/lang/String;

.field private static sTypedCtx:Z

.field private static sTypedInitial:I

.field private static final sUser:[I

.field private static final sUserCollector:Lcom/mrkeyboard/app/MrPredict$UserCollector;

.field private static final sWord:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v2, 0x3

    const/16 v1, 0xf8

    .line 31
    const/16 v0, 0x60

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sInitials:[I

    .line 33
    const/16 v0, 0xb40

    new-array v0, v0, [C

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sOut:[C

    .line 34
    const/16 v0, 0x3c

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sFreq:[I

    .line 35
    new-array v0, v2, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sTriWords:[Ljava/lang/String;

    .line 36
    new-array v0, v2, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sTriScores:[I

    .line 38
    new-array v0, v1, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    .line 39
    new-array v0, v1, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sMain:[I

    .line 40
    new-array v0, v1, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    .line 78
    new-instance v0, Lcom/mrkeyboard/app/MrPredict$UserCollector;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrPredict$UserCollector;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sUserCollector:Lcom/mrkeyboard/app/MrPredict$UserCollector;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;II)V
    .locals 0

    .prologue
    .line 20
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrPredict;->add(Ljava/lang/String;II)V

    return-void
.end method

.method private static add(Ljava/lang/String;II)V
    .locals 2

    .prologue
    .line 308
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sPrev:Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrLearned;->isBlocked(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 321
    :cond_0
    :goto_0
    return-void

    .line 309
    :cond_1
    const/4 v0, 0x0

    :goto_1
    sget v1, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    if-ge v0, v1, :cond_4

    .line 310
    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    aget-object v1, v1, v0

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 311
    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sMain:[I

    aget v1, v1, v0

    if-le p1, v1, :cond_2

    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sMain:[I

    aput p1, v1, v0

    .line 312
    :cond_2
    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    aget v1, v1, v0

    if-le p2, v1, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    aput p2, v1, v0

    goto :goto_0

    .line 309
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 316
    :cond_4
    sget v0, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    const/16 v1, 0xf8

    if-ge v0, v1, :cond_0

    .line 317
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    sget v1, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    aput-object p0, v0, v1

    .line 318
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sMain:[I

    sget v1, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    aput p1, v0, v1

    .line 319
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    sget v1, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    aput p2, v0, v1

    .line 320
    sget v0, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    goto :goto_0
.end method

.method public static complete(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V
    .locals 14

    .prologue
    const/4 v13, 0x2

    const/4 v1, 0x0

    .line 223
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 257
    :cond_0
    :goto_0
    return-void

    .line 225
    :cond_1
    :try_start_0
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->size()I

    move-result v9

    .line 226
    if-lt v9, v13, :cond_0

    const/16 v0, 0xc

    if-gt v9, v0, :cond_0

    .line 227
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->getTypedWord()Ljava/lang/CharSequence;

    move-result-object v4

    .line 228
    if-eqz v4, :cond_0

    invoke-interface {v4}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-ne v0, v9, :cond_0

    .line 229
    const/4 v0, 0x2

    new-array v10, v0, [Ljava/lang/String;

    .line 230
    const/4 v0, 0x2

    new-array v5, v0, [I

    .line 232
    const-class v6, Lcom/mrkeyboard/app/MrPredict;

    monitor-enter v6
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 233
    :try_start_1
    sget-boolean v0, Lcom/mrkeyboard/app/MrPredict;->sTypedCtx:Z

    if-eqz v0, :cond_2

    sget v0, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    if-eqz v0, :cond_2

    const/4 v0, 0x0

    invoke-interface {v4, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v0

    sget v2, Lcom/mrkeyboard/app/MrPredict;->sTypedInitial:I

    if-eq v0, v2, :cond_3

    :cond_2
    monitor-exit v6

    goto :goto_0

    .line 249
    :catchall_0
    move-exception v0

    monitor-exit v6
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v0
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0

    .line 254
    :catch_0
    move-exception v0

    goto :goto_0

    :cond_3
    move v3, v1

    move v7, v1

    .line 234
    :goto_1
    :try_start_3
    sget v0, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    if-ge v3, v0, :cond_8

    .line 235
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    aget-object v8, v0, v3

    .line 236
    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v0

    if-le v0, v9, :cond_9

    invoke-static {v8, v4, v9}, Lcom/mrkeyboard/app/MrPredict;->startsWith(Ljava/lang/String;Ljava/lang/CharSequence;I)Z

    move-result v0

    if-nez v0, :cond_4

    move v0, v7

    .line 234
    :goto_2
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    move v7, v0

    goto :goto_1

    .line 237
    :cond_4
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPredict;->score(I)I

    move-result v11

    move v2, v7

    .line 239
    :goto_3
    if-lez v2, :cond_5

    add-int/lit8 v0, v2, -0x1

    aget v0, v5, v0

    if-ge v0, v11, :cond_5

    add-int/lit8 v0, v2, -0x1

    move v2, v0

    goto :goto_3

    .line 240
    :cond_5
    if-lt v2, v13, :cond_6

    move v0, v7

    goto :goto_2

    .line 241
    :cond_6
    const/4 v0, 0x1

    invoke-static {v7, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    :goto_4
    if-le v0, v2, :cond_7

    .line 242
    add-int/lit8 v12, v0, -0x1

    aget-object v12, v10, v12

    aput-object v12, v10, v0

    .line 243
    add-int/lit8 v12, v0, -0x1

    aget v12, v5, v12

    aput v12, v5, v0

    .line 241
    add-int/lit8 v0, v0, -0x1

    goto :goto_4

    .line 245
    :cond_7
    aput-object v8, v10, v2

    .line 246
    aput v11, v5, v2

    .line 247
    if-ge v7, v13, :cond_9

    add-int/lit8 v0, v7, 0x1

    goto :goto_2

    .line 249
    :cond_8
    monitor-exit v6
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move v8, v1

    .line 250
    :goto_5
    if-ge v8, v7, :cond_0

    .line 251
    :try_start_4
    aget-object v0, v10, v8

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 252
    const/4 v2, 0x0

    array-length v3, v1

    mul-int/lit8 v0, v8, 0x28

    rsub-int v0, v0, 0xff

    const/16 v4, 0x10

    invoke-static {v9, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    shl-int v4, v0, v4

    const/4 v5, 0x1

    sget-object v6, Lcom/mrkeyboard/app/Dictionary$DataType;->UNIGRAM:Lcom/mrkeyboard/app/Dictionary$DataType;

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/Suggest;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_0

    .line 250
    add-int/lit8 v0, v8, 0x1

    move v8, v0

    goto :goto_5

    :cond_9
    move v0, v7

    goto :goto_2
.end method

.method public static firstLetter(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;)V
    .locals 11

    .prologue
    const/4 v2, 0x1

    const/4 v0, 0x0

    .line 186
    :try_start_0
    sget-object v3, Lcom/mrkeyboard/app/MrPredict;->sCtx1:Ljava/lang/String;

    sget-object v4, Lcom/mrkeyboard/app/MrPredict;->sCtx2:Ljava/lang/String;

    .line 187
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 215
    :cond_0
    :goto_0
    return-void

    .line 189
    :cond_1
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrRecent;->complete(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V

    .line 191
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->size()I

    move-result v1

    if-ne v1, v2, :cond_2

    .line 192
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->getTypedWord()Ljava/lang/CharSequence;

    move-result-object v5

    .line 193
    const-class v6, Lcom/mrkeyboard/app/MrPredict;

    monitor-enter v6
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 194
    if-eqz v5, :cond_3

    :try_start_1
    invoke-interface {v5}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-lez v1, :cond_3

    if-eqz p2, :cond_3

    if-eqz v4, :cond_3

    invoke-interface {p2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    move v1, v2

    :goto_1
    sput-boolean v1, Lcom/mrkeyboard/app/MrPredict;->sTypedCtx:Z

    .line 195
    sget-boolean v1, Lcom/mrkeyboard/app/MrPredict;->sTypedCtx:Z

    if-eqz v1, :cond_4

    const/4 v1, 0x0

    invoke-interface {v5, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    :goto_2
    sput v1, Lcom/mrkeyboard/app/MrPredict;->sTypedInitial:I

    .line 196
    monitor-exit v6
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 198
    :cond_2
    if-eqz p2, :cond_0

    if-eqz v3, :cond_0

    if-eqz v4, :cond_0

    .line 199
    :try_start_2
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->size()I

    move-result v1

    if-ne v1, v2, :cond_0

    invoke-interface {p2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 200
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->getTypedWord()Ljava/lang/CharSequence;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v1, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v8

    .line 201
    const/4 v1, 0x3

    new-array v9, v1, [Ljava/lang/String;

    .line 202
    const/4 v1, 0x3

    new-array v1, v1, [I

    .line 204
    const-class v2, Lcom/mrkeyboard/app/MrPredict;

    monitor-enter v2
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0

    .line 205
    :try_start_3
    invoke-static {v3, v4, v9, v1}, Lcom/mrkeyboard/app/MrTrigram;->find(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[I)I

    move-result v10

    .line 206
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    move v7, v0

    .line 207
    :goto_3
    if-ge v7, v10, :cond_0

    .line 208
    :try_start_4
    aget-object v0, v9, v7

    invoke-static {v0, v8}, Lcom/mrkeyboard/app/MrText;->sameInitial(Ljava/lang/CharSequence;I)Z
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_0

    move-result v0

    if-nez v0, :cond_5

    .line 207
    :goto_4
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_3

    :cond_3
    move v1, v0

    .line 194
    goto :goto_1

    :cond_4
    move v1, v0

    .line 195
    goto :goto_2

    .line 196
    :catchall_0
    move-exception v0

    :try_start_5
    monitor-exit v6
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    :try_start_6
    throw v0
    :try_end_6
    .catch Ljava/lang/RuntimeException; {:try_start_6 .. :try_end_6} :catch_0

    .line 212
    :catch_0
    move-exception v0

    goto :goto_0

    .line 206
    :catchall_1
    move-exception v0

    :try_start_7
    monitor-exit v2
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    :try_start_8
    throw v0

    .line 209
    :cond_5
    aget-object v0, v9, v7

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 210
    const/4 v2, 0x0

    array-length v3, v1

    const/16 v4, 0x7f

    const/4 v5, 0x1

    sget-object v6, Lcom/mrkeyboard/app/Dictionary$DataType;->BIGRAM:Lcom/mrkeyboard/app/Dictionary$DataType;

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/Suggest;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z
    :try_end_8
    .catch Ljava/lang/RuntimeException; {:try_start_8 .. :try_end_8} :catch_0

    goto :goto_4
.end method

.method static forWord(Lcom/mrkeyboard/app/Suggest;Ljava/lang/String;)Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/mrkeyboard/app/Suggest;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/CharSequence;",
            ">;"
        }
    .end annotation

    .prologue
    .line 126
    const/4 v0, 0x0

    invoke-static {p0, v0, p1}, Lcom/mrkeyboard/app/MrPredict;->forWords(Lcom/mrkeyboard/app/Suggest;Ljava/lang/String;Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method static declared-synchronized forWords(Lcom/mrkeyboard/app/Suggest;Ljava/lang/String;Ljava/lang/String;)Ljava/util/List;
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/mrkeyboard/app/Suggest;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/CharSequence;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v11, 0x3

    const/4 v2, 0x1

    const/4 v1, 0x2

    const/4 v0, 0x0

    const/4 v3, 0x0

    .line 131
    const-class v5, Lcom/mrkeyboard/app/MrPredict;

    monitor-enter v5

    const/4 v4, 0x0

    :try_start_0
    sput v4, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    .line 132
    sput-object p2, Lcom/mrkeyboard/app/MrPredict;->sPrev:Ljava/lang/String;

    .line 133
    sput-object p1, Lcom/mrkeyboard/app/MrPredict;->sCtx1:Ljava/lang/String;

    .line 134
    sput-object p2, Lcom/mrkeyboard/app/MrPredict;->sCtx2:Ljava/lang/String;

    .line 135
    invoke-virtual {p2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v6

    .line 136
    invoke-virtual {v6, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    move v4, v2

    .line 137
    :goto_0
    if-eqz p1, :cond_1

    .line 138
    sget-object v2, Lcom/mrkeyboard/app/MrPredict;->sTriWords:[Ljava/lang/String;

    sget-object v7, Lcom/mrkeyboard/app/MrPredict;->sTriScores:[I

    invoke-static {p1, p2, v2, v7}, Lcom/mrkeyboard/app/MrTrigram;->find(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[I)I

    move-result v7

    move v2, v3

    .line 139
    :goto_1
    if-ge v2, v7, :cond_1

    sget-object v8, Lcom/mrkeyboard/app/MrPredict;->sTriWords:[Ljava/lang/String;

    aget-object v8, v8, v2

    sget-object v9, Lcom/mrkeyboard/app/MrPredict;->sTriScores:[I

    aget v9, v9, v2

    add-int/lit16 v9, v9, 0x80

    const/4 v10, 0x0

    invoke-static {v8, v9, v10}, Lcom/mrkeyboard/app/MrPredict;->add(Ljava/lang/String;II)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_0
    move v4, v3

    .line 136
    goto :goto_0

    .line 141
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v2

    .line 142
    if-eqz v2, :cond_3

    .line 143
    sget v7, Lcom/mrkeyboard/app/MrPredict;->sInitialCount:I

    if-nez v7, :cond_2

    sget-object v7, Lcom/mrkeyboard/app/MrPredict;->sInitials:[I

    invoke-static {v7}, Lcom/mrkeyboard/app/MrText;->allInitials([I)I

    move-result v7

    sput v7, Lcom/mrkeyboard/app/MrPredict;->sInitialCount:I

    .line 144
    :cond_2
    invoke-static {v2, p2}, Lcom/mrkeyboard/app/MrPredict;->mainBigrams(Lcom/mrkeyboard/app/BinaryDictionary;Ljava/lang/String;)V

    .line 145
    if-eqz v4, :cond_3

    invoke-virtual {v2, v6}, Lcom/mrkeyboard/app/BinaryDictionary;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_3

    invoke-static {v2, v6}, Lcom/mrkeyboard/app/MrPredict;->mainBigrams(Lcom/mrkeyboard/app/BinaryDictionary;Ljava/lang/String;)V

    .line 147
    :cond_3
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrUserBigrams()Lcom/mrkeyboard/app/Dictionary;

    move-result-object v2

    .line 148
    if-eqz v2, :cond_4

    .line 149
    const/4 v7, 0x0

    sget-object v8, Lcom/mrkeyboard/app/MrPredict;->sUserCollector:Lcom/mrkeyboard/app/MrPredict$UserCollector;

    const/4 v9, 0x0

    invoke-virtual {v2, v7, p2, v8, v9}, Lcom/mrkeyboard/app/Dictionary;->getBigrams(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;Lcom/mrkeyboard/app/Dictionary$WordCallback;[I)V

    .line 150
    if-eqz v4, :cond_4

    const/4 v4, 0x0

    sget-object v7, Lcom/mrkeyboard/app/MrPredict;->sUserCollector:Lcom/mrkeyboard/app/MrPredict$UserCollector;

    const/4 v8, 0x0

    invoke-virtual {v2, v4, v6, v7, v8}, Lcom/mrkeyboard/app/Dictionary;->getBigrams(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;Lcom/mrkeyboard/app/Dictionary$WordCallback;[I)V

    .line 154
    :cond_4
    const/4 v2, 0x2

    invoke-static {p2, v2}, Lcom/mrkeyboard/app/MrRecent;->nextAfter(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v4

    move v2, v3

    .line 155
    :goto_2
    array-length v6, v4

    if-ge v2, v6, :cond_5

    aget-object v6, v4, v2

    const/4 v7, 0x0

    mul-int/lit8 v8, v2, 0x5

    rsub-int/lit8 v8, v8, 0x46

    invoke-static {v6, v7, v8}, Lcom/mrkeyboard/app/MrPredict;->add(Ljava/lang/String;II)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_5
    move v2, v3

    .line 156
    :goto_3
    sget v4, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    if-ge v2, v4, :cond_7

    .line 157
    sget-object v4, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    aget-object v4, v4, v2

    invoke-static {v4}, Lcom/mrkeyboard/app/MrRecent;->bonus(Ljava/lang/String;)I

    move-result v4

    .line 158
    if-lez v4, :cond_6

    sget-object v6, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    aget v7, v6, v2

    add-int/2addr v4, v7

    aput v4, v6, v2

    .line 156
    :cond_6
    add-int/lit8 v2, v2, 0x1

    goto :goto_3

    .line 160
    :cond_7
    sget v2, Lcom/mrkeyboard/app/MrPredict;->sCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v2, :cond_9

    .line 176
    :cond_8
    :goto_4
    monitor-exit v5

    return-object v0

    .line 161
    :cond_9
    const/4 v0, 0x3

    :try_start_1
    new-array v6, v0, [I

    fill-array-data v6, :array_0

    move v4, v3

    .line 162
    :goto_5
    sget v0, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    if-ge v4, v0, :cond_e

    .line 163
    invoke-static {v4}, Lcom/mrkeyboard/app/MrPredict;->score(I)I

    move-result v7

    move v2, v3

    .line 164
    :goto_6
    if-ge v2, v11, :cond_c

    .line 165
    aget v0, v6, v2

    if-ltz v0, :cond_a

    aget v0, v6, v2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPredict;->score(I)I

    move-result v0

    if-le v7, v0, :cond_d

    :cond_a
    move v0, v1

    .line 166
    :goto_7
    if-le v0, v2, :cond_b

    add-int/lit8 v7, v0, -0x1

    aget v7, v6, v7

    aput v7, v6, v0

    add-int/lit8 v0, v0, -0x1

    goto :goto_7

    .line 167
    :cond_b
    aput v4, v6, v2

    .line 162
    :cond_c
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_5

    .line 164
    :cond_d
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_6

    .line 172
    :cond_e
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x3

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 173
    const/4 v1, 0x1

    aget v1, v6, v1

    if-ltz v1, :cond_f

    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    const/4 v2, 0x1

    aget v2, v6, v2

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 174
    :cond_f
    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    const/4 v2, 0x0

    aget v2, v6, v2

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 175
    const/4 v1, 0x2

    aget v1, v6, v1

    if-ltz v1, :cond_8

    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    const/4 v2, 0x2

    aget v2, v6, v2

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_4

    .line 131
    :catchall_0
    move-exception v0

    monitor-exit v5

    throw v0

    .line 161
    nop

    :array_0
    .array-data 4
        -0x1
        -0x1
        -0x1
    .end array-data
.end method

.method static inContext(Ljava/lang/CharSequence;)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 264
    if-eqz p0, :cond_0

    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 271
    :cond_0
    :goto_0
    return v0

    .line 265
    :cond_1
    const-class v2, Lcom/mrkeyboard/app/MrPredict;

    monitor-enter v2

    .line 266
    :try_start_0
    sget-boolean v1, Lcom/mrkeyboard/app/MrPredict;->sTypedCtx:Z

    if-eqz v1, :cond_2

    sget v1, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    if-nez v1, :cond_3

    :cond_2
    monitor-exit v2

    goto :goto_0

    .line 270
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    :cond_3
    move v1, v0

    .line 267
    :goto_1
    :try_start_1
    sget v3, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    if-ge v1, v3, :cond_5

    .line 268
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPredict;->score(I)I

    move-result v3

    if-lez v3, :cond_4

    sget-object v3, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    aget-object v3, v3, v1

    invoke-static {v3, p0}, Lcom/mrkeyboard/app/MrPredict;->sameWord(Ljava/lang/String;Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_4

    const/4 v0, 0x1

    monitor-exit v2

    goto :goto_0

    .line 267
    :cond_4
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 270
    :cond_5
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0
.end method

.method public static list(Landroid/content/Context;Lcom/mrkeyboard/app/Suggest;Landroid/view/inputmethod/InputConnection;)Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Lcom/mrkeyboard/app/Suggest;",
            "Landroid/view/inputmethod/InputConnection;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/CharSequence;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v0, 0x0

    .line 86
    if-eqz p1, :cond_0

    if-nez p2, :cond_1

    .line 120
    :cond_0
    :goto_0
    return-object v0

    .line 87
    :cond_1
    :try_start_0
    invoke-virtual {p1}, Lcom/mrkeyboard/app/Suggest;->hasMainDictionary()Z

    move-result v1

    if-nez v1, :cond_2

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->offerList(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    goto :goto_0

    .line 90
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrSurround;->takeBefore()Ljava/lang/CharSequence;

    move-result-object v1

    .line 91
    if-nez v1, :cond_3

    .line 92
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 94
    const/16 v1, 0x60

    const/4 v2, 0x0

    :try_start_1
    invoke-interface {p2, v1, v2}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v1

    .line 96
    :try_start_2
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 99
    :cond_3
    invoke-static {v1}, Lcom/mrkeyboard/app/MrText;->atSentenceStart(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_6

    .line 100
    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrPredict;->sCtx1:Ljava/lang/String;

    .line 101
    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrPredict;->sCtx2:Ljava/lang/String;

    .line 102
    invoke-static {}, Lcom/mrkeyboard/app/MrRecent;->breakPair()V

    .line 103
    invoke-static {}, Lcom/mrkeyboard/app/MrRules;->get()Lcom/mrkeyboard/app/MrRules;

    move-result-object v1

    iget-object v2, v1, Lcom/mrkeyboard/app/MrRules;->starters:[Ljava/lang/String;

    .line 104
    array-length v1, v2

    if-eqz v1, :cond_0

    .line 106
    new-instance v1, Ljava/util/ArrayList;

    const/4 v3, 0x3

    invoke-direct {v1, v3}, Ljava/util/ArrayList;-><init>(I)V

    .line 107
    array-length v3, v2

    if-lt v3, v4, :cond_4

    const/4 v3, 0x1

    aget-object v3, v2, v3

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 108
    :cond_4
    const/4 v3, 0x0

    aget-object v3, v2, v3

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 109
    array-length v3, v2

    if-lt v3, v5, :cond_5

    const/4 v3, 0x2

    aget-object v2, v2, v3

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_5
    move-object v0, v1

    .line 110
    goto :goto_0

    .line 96
    :catchall_0
    move-exception v1

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 97
    throw v1

    .line 119
    :catch_0
    move-exception v1

    goto :goto_0

    .line 112
    :cond_6
    invoke-static {v1}, Lcom/mrkeyboard/app/MrText;->lastTwoWords(Ljava/lang/CharSequence;)[Ljava/lang/String;

    move-result-object v1

    .line 113
    if-nez v1, :cond_7

    .line 114
    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrPredict;->sCtx1:Ljava/lang/String;

    .line 115
    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrPredict;->sCtx2:Ljava/lang/String;

    goto :goto_0

    .line 118
    :cond_7
    const/4 v2, 0x0

    aget-object v2, v1, v2

    const/4 v3, 0x1

    aget-object v1, v1, v3

    invoke-static {p1, v2, v1}, Lcom/mrkeyboard/app/MrPredict;->forWords(Lcom/mrkeyboard/app/Suggest;Ljava/lang/String;Ljava/lang/String;)Ljava/util/List;
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0

    move-result-object v0

    goto :goto_0
.end method

.method private static mainBigrams(Lcom/mrkeyboard/app/BinaryDictionary;Ljava/lang/String;)V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 295
    invoke-virtual {p1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 296
    sget-object v2, Lcom/mrkeyboard/app/MrPredict;->sInitials:[I

    sget v3, Lcom/mrkeyboard/app/MrPredict;->sInitialCount:I

    sget-object v4, Lcom/mrkeyboard/app/MrPredict;->sOut:[C

    sget-object v5, Lcom/mrkeyboard/app/MrPredict;->sFreq:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBigrams([C[II[C[I)I

    move v1, v6

    .line 297
    :goto_0
    const/16 v0, 0x3c

    if-ge v1, v0, :cond_0

    .line 298
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sFreq:[I

    aget v2, v0, v1

    .line 299
    if-gtz v2, :cond_1

    .line 305
    :cond_0
    return-void

    .line 300
    :cond_1
    mul-int/lit8 v3, v1, 0x30

    move v0, v6

    .line 302
    :goto_1
    const/16 v4, 0x30

    if-ge v0, v4, :cond_2

    sget-object v4, Lcom/mrkeyboard/app/MrPredict;->sOut:[C

    add-int v5, v3, v0

    aget-char v4, v4, v5

    if-eqz v4, :cond_2

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 303
    :cond_2
    if-lez v0, :cond_3

    new-instance v4, Ljava/lang/String;

    sget-object v5, Lcom/mrkeyboard/app/MrPredict;->sOut:[C

    invoke-direct {v4, v5, v3, v0}, Ljava/lang/String;-><init>([CII)V

    invoke-static {v4, v2, v6}, Lcom/mrkeyboard/app/MrPredict;->add(Ljava/lang/String;II)V

    .line 297
    :cond_3
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0
.end method

.method private static sameWord(Ljava/lang/String;Ljava/lang/CharSequence;)Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 275
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-eq v0, v2, :cond_1

    .line 279
    :cond_0
    :goto_0
    return v1

    :cond_1
    move v0, v1

    .line 276
    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v0, v2, :cond_2

    .line 277
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    invoke-interface {p1, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v3

    if-ne v2, v3, :cond_0

    .line 276
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 279
    :cond_2
    const/4 v1, 0x1

    goto :goto_0
.end method

.method private static score(I)I
    .locals 2

    .prologue
    .line 291
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sMain:[I

    aget v0, v0, p0

    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    aget v1, v1, p0

    add-int/2addr v0, v1

    return v0
.end method

.method private static startsWith(Ljava/lang/String;Ljava/lang/CharSequence;I)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 284
    move v1, v0

    :goto_0
    if-ge v1, p2, :cond_1

    .line 285
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    invoke-interface {p1, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v3

    if-eq v2, v3, :cond_0

    .line 287
    :goto_1
    return v0

    .line 284
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 287
    :cond_1
    const/4 v0, 0x1

    goto :goto_1
.end method
