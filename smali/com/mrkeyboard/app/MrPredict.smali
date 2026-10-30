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
.field static final LOOKBACK:I = 0x40

.field static final MAX_BIGRAMS:I = 0x3c

.field private static final MAX_CAND:I = 0xf0

.field static final MAX_WORD:I = 0x30

.field static final SHOW:I = 0x3

.field static final USER_WEIGHT:I = 0x2

.field private static sCount:I

.field private static final sFreq:[I

.field private static sInitialCount:I

.field private static final sInitials:[I

.field private static final sMain:[I

.field private static final sOut:[C

.field private static sPrev:Ljava/lang/String;

.field private static final sUser:[I

.field private static final sUserCollector:Lcom/mrkeyboard/app/MrPredict$UserCollector;

.field private static final sWord:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/16 v1, 0xf0

    .line 27
    const/16 v0, 0x60

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sInitials:[I

    .line 29
    const/16 v0, 0xb40

    new-array v0, v0, [C

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sOut:[C

    .line 30
    const/16 v0, 0x3c

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sFreq:[I

    .line 32
    new-array v0, v1, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    .line 33
    new-array v0, v1, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sMain:[I

    .line 34
    new-array v0, v1, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    .line 51
    new-instance v0, Lcom/mrkeyboard/app/MrPredict$UserCollector;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrPredict$UserCollector;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrPredict;->sUserCollector:Lcom/mrkeyboard/app/MrPredict$UserCollector;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;II)V
    .locals 0

    .prologue
    .line 17
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrPredict;->add(Ljava/lang/String;II)V

    return-void
.end method

.method private static add(Ljava/lang/String;II)V
    .locals 2

    .prologue
    .line 124
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sPrev:Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 137
    :cond_0
    :goto_0
    return-void

    .line 125
    :cond_1
    const/4 v0, 0x0

    :goto_1
    sget v1, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    if-ge v0, v1, :cond_4

    .line 126
    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    aget-object v1, v1, v0

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 127
    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sMain:[I

    aget v1, v1, v0

    if-le p1, v1, :cond_2

    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sMain:[I

    aput p1, v1, v0

    .line 128
    :cond_2
    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    aget v1, v1, v0

    if-le p2, v1, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    aput p2, v1, v0

    goto :goto_0

    .line 125
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 132
    :cond_4
    sget v0, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    const/16 v1, 0xf0

    if-ge v0, v1, :cond_0

    .line 133
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    sget v1, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    aput-object p0, v0, v1

    .line 134
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sMain:[I

    sget v1, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    aput p1, v0, v1

    .line 135
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    sget v1, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    aput p2, v0, v1

    .line 136
    sget v0, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    goto :goto_0
.end method

.method static declared-synchronized forWord(Lcom/mrkeyboard/app/Suggest;Ljava/lang/String;)Ljava/util/List;
    .locals 11
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
    const/4 v10, 0x3

    const/4 v1, 0x2

    const/4 v2, 0x1

    const/4 v0, 0x0

    const/4 v3, 0x0

    .line 71
    const-class v5, Lcom/mrkeyboard/app/MrPredict;

    monitor-enter v5

    const/4 v4, 0x0

    :try_start_0
    sput v4, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    .line 72
    sput-object p1, Lcom/mrkeyboard/app/MrPredict;->sPrev:Ljava/lang/String;

    .line 73
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v4

    .line 74
    invoke-virtual {v4, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_4

    .line 75
    :goto_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v6

    .line 76
    if-eqz v6, :cond_1

    .line 77
    sget v7, Lcom/mrkeyboard/app/MrPredict;->sInitialCount:I

    if-nez v7, :cond_0

    sget-object v7, Lcom/mrkeyboard/app/MrPredict;->sInitials:[I

    invoke-static {v7}, Lcom/mrkeyboard/app/MrText;->allInitials([I)I

    move-result v7

    sput v7, Lcom/mrkeyboard/app/MrPredict;->sInitialCount:I

    .line 78
    :cond_0
    invoke-static {v6, p1}, Lcom/mrkeyboard/app/MrPredict;->mainBigrams(Lcom/mrkeyboard/app/BinaryDictionary;Ljava/lang/String;)V

    .line 79
    if-eqz v2, :cond_1

    invoke-virtual {v6, v4}, Lcom/mrkeyboard/app/BinaryDictionary;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_1

    invoke-static {v6, v4}, Lcom/mrkeyboard/app/MrPredict;->mainBigrams(Lcom/mrkeyboard/app/BinaryDictionary;Ljava/lang/String;)V

    .line 81
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrUserBigrams()Lcom/mrkeyboard/app/Dictionary;

    move-result-object v6

    .line 82
    if-eqz v6, :cond_2

    .line 83
    const/4 v7, 0x0

    sget-object v8, Lcom/mrkeyboard/app/MrPredict;->sUserCollector:Lcom/mrkeyboard/app/MrPredict$UserCollector;

    const/4 v9, 0x0

    invoke-virtual {v6, v7, p1, v8, v9}, Lcom/mrkeyboard/app/Dictionary;->getBigrams(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;Lcom/mrkeyboard/app/Dictionary$WordCallback;[I)V

    .line 84
    if-eqz v2, :cond_2

    const/4 v2, 0x0

    sget-object v7, Lcom/mrkeyboard/app/MrPredict;->sUserCollector:Lcom/mrkeyboard/app/MrPredict$UserCollector;

    const/4 v8, 0x0

    invoke-virtual {v6, v2, v4, v7, v8}, Lcom/mrkeyboard/app/Dictionary;->getBigrams(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;Lcom/mrkeyboard/app/Dictionary$WordCallback;[I)V

    .line 86
    :cond_2
    sget v2, Lcom/mrkeyboard/app/MrPredict;->sCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v2, :cond_5

    .line 103
    :cond_3
    :goto_1
    monitor-exit v5

    return-object v0

    :cond_4
    move v2, v3

    .line 74
    goto :goto_0

    .line 88
    :cond_5
    const/4 v0, 0x3

    :try_start_1
    new-array v6, v0, [I

    fill-array-data v6, :array_0

    move v4, v3

    .line 89
    :goto_2
    sget v0, Lcom/mrkeyboard/app/MrPredict;->sCount:I

    if-ge v4, v0, :cond_a

    .line 90
    invoke-static {v4}, Lcom/mrkeyboard/app/MrPredict;->score(I)I

    move-result v7

    move v2, v3

    .line 91
    :goto_3
    if-ge v2, v10, :cond_8

    .line 92
    aget v0, v6, v2

    if-ltz v0, :cond_6

    aget v0, v6, v2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPredict;->score(I)I

    move-result v0

    if-le v7, v0, :cond_9

    :cond_6
    move v0, v1

    .line 93
    :goto_4
    if-le v0, v2, :cond_7

    add-int/lit8 v7, v0, -0x1

    aget v7, v6, v7

    aput v7, v6, v0

    add-int/lit8 v0, v0, -0x1

    goto :goto_4

    .line 94
    :cond_7
    aput v4, v6, v2

    .line 89
    :cond_8
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_2

    .line 91
    :cond_9
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_3

    .line 99
    :cond_a
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x3

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 100
    const/4 v1, 0x1

    aget v1, v6, v1

    if-ltz v1, :cond_b

    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    const/4 v2, 0x1

    aget v2, v6, v2

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 101
    :cond_b
    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    const/4 v2, 0x0

    aget v2, v6, v2

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 102
    const/4 v1, 0x2

    aget v1, v6, v1

    if-ltz v1, :cond_3

    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sWord:[Ljava/lang/String;

    const/4 v2, 0x2

    aget v2, v6, v2

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 71
    :catchall_0
    move-exception v0

    monitor-exit v5

    throw v0

    .line 88
    nop

    :array_0
    .array-data 4
        -0x1
        -0x1
        -0x1
    .end array-data
.end method

.method public static list(Lcom/mrkeyboard/app/Suggest;Landroid/view/inputmethod/InputConnection;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
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
    const/4 v0, 0x0

    .line 59
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 65
    :cond_0
    :goto_0
    return-object v0

    .line 60
    :cond_1
    const/16 v1, 0x40

    const/4 v2, 0x0

    :try_start_0
    invoke-interface {p1, v1, v2}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v1

    .line 61
    invoke-static {v1}, Lcom/mrkeyboard/app/MrText;->lastWord(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1

    .line 62
    if-eqz v1, :cond_0

    .line 63
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrPredict;->forWord(Lcom/mrkeyboard/app/Suggest;Ljava/lang/String;)Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 64
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static mainBigrams(Lcom/mrkeyboard/app/BinaryDictionary;Ljava/lang/String;)V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 111
    invoke-virtual {p1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 112
    sget-object v2, Lcom/mrkeyboard/app/MrPredict;->sInitials:[I

    sget v3, Lcom/mrkeyboard/app/MrPredict;->sInitialCount:I

    sget-object v4, Lcom/mrkeyboard/app/MrPredict;->sOut:[C

    sget-object v5, Lcom/mrkeyboard/app/MrPredict;->sFreq:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBigrams([C[II[C[I)I

    move v1, v6

    .line 113
    :goto_0
    const/16 v0, 0x3c

    if-ge v1, v0, :cond_0

    .line 114
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sFreq:[I

    aget v2, v0, v1

    .line 115
    if-gtz v2, :cond_1

    .line 121
    :cond_0
    return-void

    .line 116
    :cond_1
    mul-int/lit8 v3, v1, 0x30

    move v0, v6

    .line 118
    :goto_1
    const/16 v4, 0x30

    if-ge v0, v4, :cond_2

    sget-object v4, Lcom/mrkeyboard/app/MrPredict;->sOut:[C

    add-int v5, v3, v0

    aget-char v4, v4, v5

    if-eqz v4, :cond_2

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 119
    :cond_2
    if-lez v0, :cond_3

    new-instance v4, Ljava/lang/String;

    sget-object v5, Lcom/mrkeyboard/app/MrPredict;->sOut:[C

    invoke-direct {v4, v5, v3, v0}, Ljava/lang/String;-><init>([CII)V

    invoke-static {v4, v2, v6}, Lcom/mrkeyboard/app/MrPredict;->add(Ljava/lang/String;II)V

    .line 113
    :cond_3
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0
.end method

.method private static score(I)I
    .locals 2

    .prologue
    .line 107
    sget-object v0, Lcom/mrkeyboard/app/MrPredict;->sMain:[I

    aget v0, v0, p0

    sget-object v1, Lcom/mrkeyboard/app/MrPredict;->sUser:[I

    aget v1, v1, p0

    mul-int/lit8 v1, v1, 0x2

    add-int/2addr v0, v1

    return v0
.end method
