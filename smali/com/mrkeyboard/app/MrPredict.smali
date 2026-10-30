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
.field static final LOOKBACK:I = 0x60

.field static final MAX_BIGRAMS:I = 0x3c

.field private static final MAX_CAND:I = 0xf8

.field static final MAX_WORD:I = 0x30

.field static final SHOW:I = 0x3

.field private static final STARTERS:[Ljava/lang/String;

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

.field private static final sUser:[I

.field private static final sUserCollector:Lcom/mrkeyboard/app/MrPredict$UserCollector;

.field private static final sWord:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/16 v4, 0xf8

    const/4 v3, 0x3

    .line 30
    new-array v0, v3, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "Voc\u00ea"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "Eu"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "N\u00e3o"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->STARTERS:[Ljava/lang/String;

    .line 32
    const/16 v0, 0x60

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sInitials:[I

    .line 34
    const/16 v0, 0xb40

    new-array v0, v0, [C

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sOut:[C

    .line 35
    const/16 v0, 0x3c

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sFreq:[I

    .line 36
    new-array v0, v3, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sTriWords:[Ljava/lang/String;

    .line 37
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sTriScores:[I

    .line 39
    new-array v0, v4, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    .line 40
    new-array v0, v4, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sMain:[I

    .line 41
    new-array v0, v4, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    .line 62
    new-instance v0, Lcom/mrkeyboard/app/MrPredict$UserCollector;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrPredict$UserCollector;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sUserCollector:Lcom/mrkeyboard/app/MrPredict$UserCollector;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;II)V
    .locals 0

    .prologue
    .line 18
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrPredict;->add(Ljava/lang/String;II)V

    return-void
.end method

.method private static add(Ljava/lang/String;II)V
    .locals 2

    .prologue
    .line 184
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sPrev:Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 197
    :cond_0
    :goto_0
    return-void

    .line 185
    :cond_1
    const/4 v0, 0x0

    :goto_1
    sget v1, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    if-ge v0, v1, :cond_4

    .line 186
    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    aget-object v1, v1, v0

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 187
    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sMain:[I

    aget v1, v1, v0

    if-le p1, v1, :cond_2

    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sMain:[I

    aput p1, v1, v0

    .line 188
    :cond_2
    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    aget v1, v1, v0

    if-le p2, v1, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    aput p2, v1, v0

    goto :goto_0

    .line 185
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 192
    :cond_4
    sget v0, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    const/16 v1, 0xf8

    if-ge v0, v1, :cond_0

    .line 193
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    sget v1, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    aput-object p0, v0, v1

    .line 194
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sMain:[I

    sget v1, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    aput p1, v0, v1

    .line 195
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    sget v1, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    aput p2, v0, v1

    .line 196
    sget v0, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    goto :goto_0
.end method

.method public static firstLetter(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;)V
    .locals 11

    .prologue
    const/4 v4, 0x1

    const/4 v0, 0x0

    .line 146
    :try_start_0
    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sCtx1:Ljava/lang/String;

    sget-object v2, Lcom/mrkeyboard/app/MrPredict;->sCtx2:Ljava/lang/String;

    .line 147
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    if-eqz v1, :cond_0

    if-nez v2, :cond_1

    .line 164
    :cond_0
    :goto_0
    return-void

    .line 148
    :cond_1
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->size()I

    move-result v3

    if-ne v3, v4, :cond_0

    invoke-interface {p2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 149
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->getTypedWord()Ljava/lang/CharSequence;

    move-result-object v3

    const/4 v4, 0x0

    invoke-interface {v3, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v8

    .line 150
    const/4 v3, 0x3

    new-array v9, v3, [Ljava/lang/String;

    .line 151
    const/4 v3, 0x3

    new-array v3, v3, [I

    .line 153
    const-class v4, Lcom/mrkeyboard/app/MrPredict;

    monitor-enter v4
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 154
    :try_start_1
    invoke-static {v1, v2, v9, v3}, Lcom/mrkeyboard/app/MrTrigram;->find(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[I)I

    move-result v10

    .line 155
    monitor-exit v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move v7, v0

    .line 156
    :goto_1
    if-ge v7, v10, :cond_0

    .line 157
    :try_start_2
    aget-object v0, v9, v7

    invoke-static {v0, v8}, Lcom/mrkeyboard/app/MrText;->sameInitial(Ljava/lang/CharSequence;I)Z
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0

    move-result v0

    if-nez v0, :cond_2

    .line 156
    :goto_2
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_1

    .line 155
    :catchall_0
    move-exception v0

    :try_start_3
    monitor-exit v4
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw v0

    .line 161
    :catch_0
    move-exception v0

    goto :goto_0

    .line 158
    :cond_2
    aget-object v0, v9, v7

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 159
    const/4 v2, 0x0

    array-length v3, v1

    const/16 v4, 0x7f

    const/4 v5, 0x1

    sget-object v6, Lcom/mrkeyboard/app/Dictionary$DataType;->BIGRAM:Lcom/mrkeyboard/app/Dictionary$DataType;

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/Suggest;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_0

    goto :goto_2
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
    .line 94
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

    const/4 v1, 0x2

    const/4 v2, 0x1

    const/4 v0, 0x0

    const/4 v3, 0x0

    .line 99
    const-class v5, Lcom/mrkeyboard/app/MrPredict;

    monitor-enter v5

    const/4 v4, 0x0

    :try_start_0
    sput v4, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    .line 100
    sput-object p2, Lcom/mrkeyboard/app/MrPredict;->sPrev:Ljava/lang/String;

    .line 101
    sput-object p1, Lcom/mrkeyboard/app/MrPredict;->sCtx1:Ljava/lang/String;

    .line 102
    sput-object p2, Lcom/mrkeyboard/app/MrPredict;->sCtx2:Ljava/lang/String;

    .line 103
    invoke-virtual {p2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v6

    .line 104
    invoke-virtual {v6, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    move v4, v2

    .line 105
    :goto_0
    if-eqz p1, :cond_1

    .line 106
    sget-object v2, Lcom/mrkeyboard/app/MrPredict;->sTriWords:[Ljava/lang/String;

    sget-object v7, Lcom/mrkeyboard/app/MrPredict;->sTriScores:[I

    invoke-static {p1, p2, v2, v7}, Lcom/mrkeyboard/app/MrTrigram;->find(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[I)I

    move-result v7

    move v2, v3

    .line 107
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

    .line 104
    goto :goto_0

    .line 109
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v2

    .line 110
    if-eqz v2, :cond_3

    .line 111
    sget v7, Lcom/mrkeyboard/app/MrPredict;->sInitialCount:I

    if-nez v7, :cond_2

    sget-object v7, Lcom/mrkeyboard/app/MrPredict;->sInitials:[I

    invoke-static {v7}, Lcom/mrkeyboard/app/MrText;->allInitials([I)I

    move-result v7

    sput v7, Lcom/mrkeyboard/app/MrPredict;->sInitialCount:I

    .line 112
    :cond_2
    invoke-static {v2, p2}, Lcom/mrkeyboard/app/MrPredict;->mainBigrams(Lcom/mrkeyboard/app/BinaryDictionary;Ljava/lang/String;)V

    .line 113
    if-eqz v4, :cond_3

    invoke-virtual {v2, v6}, Lcom/mrkeyboard/app/BinaryDictionary;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_3

    invoke-static {v2, v6}, Lcom/mrkeyboard/app/MrPredict;->mainBigrams(Lcom/mrkeyboard/app/BinaryDictionary;Ljava/lang/String;)V

    .line 115
    :cond_3
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrUserBigrams()Lcom/mrkeyboard/app/Dictionary;

    move-result-object v2

    .line 116
    if-eqz v2, :cond_4

    .line 117
    const/4 v7, 0x0

    sget-object v8, Lcom/mrkeyboard/app/MrPredict;->sUserCollector:Lcom/mrkeyboard/app/MrPredict$UserCollector;

    const/4 v9, 0x0

    invoke-virtual {v2, v7, p2, v8, v9}, Lcom/mrkeyboard/app/Dictionary;->getBigrams(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;Lcom/mrkeyboard/app/Dictionary$WordCallback;[I)V

    .line 118
    if-eqz v4, :cond_4

    const/4 v4, 0x0

    sget-object v7, Lcom/mrkeyboard/app/MrPredict;->sUserCollector:Lcom/mrkeyboard/app/MrPredict$UserCollector;

    const/4 v8, 0x0

    invoke-virtual {v2, v4, v6, v7, v8}, Lcom/mrkeyboard/app/Dictionary;->getBigrams(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;Lcom/mrkeyboard/app/Dictionary$WordCallback;[I)V

    .line 120
    :cond_4
    sget v2, Lcom/mrkeyboard/app/MrPredict;->sCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v2, :cond_6

    .line 136
    :cond_5
    :goto_2
    monitor-exit v5

    return-object v0

    .line 121
    :cond_6
    const/4 v0, 0x3

    :try_start_1
    new-array v6, v0, [I

    fill-array-data v6, :array_0

    move v4, v3

    .line 122
    :goto_3
    sget v0, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    if-ge v4, v0, :cond_b

    .line 123
    invoke-static {v4}, Lcom/mrkeyboard/app/MrPredict;->score(I)I

    move-result v7

    move v2, v3

    .line 124
    :goto_4
    if-ge v2, v11, :cond_9

    .line 125
    aget v0, v6, v2

    if-ltz v0, :cond_7

    aget v0, v6, v2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPredict;->score(I)I

    move-result v0

    if-le v7, v0, :cond_a

    :cond_7
    move v0, v1

    .line 126
    :goto_5
    if-le v0, v2, :cond_8

    add-int/lit8 v7, v0, -0x1

    aget v7, v6, v7

    aput v7, v6, v0

    add-int/lit8 v0, v0, -0x1

    goto :goto_5

    .line 127
    :cond_8
    aput v4, v6, v2

    .line 122
    :cond_9
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_3

    .line 124
    :cond_a
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_4

    .line 132
    :cond_b
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x3

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 133
    const/4 v1, 0x1

    aget v1, v6, v1

    if-ltz v1, :cond_c

    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    const/4 v2, 0x1

    aget v2, v6, v2

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 134
    :cond_c
    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    const/4 v2, 0x0

    aget v2, v6, v2

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 135
    const/4 v1, 0x2

    aget v1, v6, v1

    if-ltz v1, :cond_5

    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    const/4 v2, 0x2

    aget v2, v6, v2

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2

    .line 99
    :catchall_0
    move-exception v0

    monitor-exit v5

    throw v0

    .line 121
    :array_0
    .array-data 4
        -0x1
        -0x1
        -0x1
    .end array-data
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
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 70
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrTrigram;->preload(Landroid/content/Context;)V

    .line 71
    if-eqz p1, :cond_0

    if-nez p2, :cond_2

    :cond_0
    move-object v0, v1

    .line 88
    :cond_1
    :goto_0
    return-object v0

    .line 72
    :cond_2
    const/16 v0, 0x60

    const/4 v3, 0x0

    invoke-interface {p2, v0, v3}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v0

    .line 73
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->atSentenceStart(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 74
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sCtx1:Ljava/lang/String;

    .line 75
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sCtx2:Ljava/lang/String;

    .line 76
    new-instance v0, Ljava/util/ArrayList;

    const/4 v3, 0x3

    invoke-direct {v0, v3}, Ljava/util/ArrayList;-><init>(I)V

    .line 77
    sget-object v3, Lcom/mrkeyboard/app/MrPredict;->STARTERS:[Ljava/lang/String;

    array-length v4, v3

    :goto_1
    if-ge v2, v4, :cond_1

    aget-object v5, v3, v2

    invoke-virtual {v0, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 80
    :cond_3
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->lastTwoWords(Ljava/lang/CharSequence;)[Ljava/lang/String;

    move-result-object v0

    .line 81
    if-nez v0, :cond_4

    .line 82
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sCtx1:Ljava/lang/String;

    .line 83
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sCtx2:Ljava/lang/String;

    move-object v0, v1

    .line 84
    goto :goto_0

    .line 86
    :cond_4
    const/4 v2, 0x0

    aget-object v2, v0, v2

    const/4 v3, 0x1

    aget-object v0, v0, v3

    invoke-static {p1, v2, v0}, Lcom/mrkeyboard/app/MrPredict;->forWords(Lcom/mrkeyboard/app/Suggest;Ljava/lang/String;Ljava/lang/String;)Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 87
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 88
    goto :goto_0
.end method

.method private static mainBigrams(Lcom/mrkeyboard/app/BinaryDictionary;Ljava/lang/String;)V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 171
    invoke-virtual {p1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 172
    sget-object v2, Lcom/mrkeyboard/app/MrPredict;->sInitials:[I

    sget v3, Lcom/mrkeyboard/app/MrPredict;->sInitialCount:I

    sget-object v4, Lcom/mrkeyboard/app/MrPredict;->sOut:[C

    sget-object v5, Lcom/mrkeyboard/app/MrPredict;->sFreq:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBigrams([C[II[C[I)I

    move v1, v6

    .line 173
    :goto_0
    const/16 v0, 0x3c

    if-ge v1, v0, :cond_0

    .line 174
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sFreq:[I

    aget v2, v0, v1

    .line 175
    if-gtz v2, :cond_1

    .line 181
    :cond_0
    return-void

    .line 176
    :cond_1
    mul-int/lit8 v3, v1, 0x30

    move v0, v6

    .line 178
    :goto_1
    const/16 v4, 0x30

    if-ge v0, v4, :cond_2

    sget-object v4, Lcom/mrkeyboard/app/MrPredict;->sOut:[C

    add-int v5, v3, v0

    aget-char v4, v4, v5

    if-eqz v4, :cond_2

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 179
    :cond_2
    if-lez v0, :cond_3

    new-instance v4, Ljava/lang/String;

    sget-object v5, Lcom/mrkeyboard/app/MrPredict;->sOut:[C

    invoke-direct {v4, v5, v3, v0}, Ljava/lang/String;-><init>([CII)V

    invoke-static {v4, v2, v6}, Lcom/mrkeyboard/app/MrPredict;->add(Ljava/lang/String;II)V

    .line 173
    :cond_3
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0
.end method

.method private static score(I)I
    .locals 2

    .prologue
    .line 167
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sMain:[I

    aget v0, v0, p0

    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    aget v1, v1, p0

    add-int/2addr v0, v1

    return v0
.end method
