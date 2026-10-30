.class public final Lcom/mrkeyboard/app/MrFuzzy;
.super Ljava/lang/Object;
.source "MrFuzzy.java"


# static fields
.field private static final BASE:[C

.field static final C_DEL:I = 0x3c

.field static final C_DEL_DOUBLE:I = 0x1e

.field static final C_INS:I = 0x3c

.field static final C_INS_DOUBLE:I = 0x1e

.field static final C_INS_H:I = 0x28

.field static final C_INS_NEAR:I = 0x2d

.field static final C_MULTI:I = 0x23

.field static final C_PHON:I = 0x19

.field static final C_PROX:I = 0x19

.field static final C_SPLIT:I = 0x23

.field static final C_SUB:I = 0x4b

.field static final C_TRANS:I = 0x28

.field static final C_VOWEL:I = 0x2d

.field static final INF:I = 0x100000

.field private static final LOWER:[C

.field static final MAX_EXTRA_DEPTH:I = 0x3

.field static final MAX_RESULTS:I = 0x5

.field static final MAX_TYPED:I = 0x14

.field static final MAX_WORD:I = 0x30

.field static final MIN_TYPED:I = 0x3

.field static final NODE_BUDGET:I = 0x2ee0

.field static final RESERVE_MAX_COST:I = 0x2d

.field private static sCache:Lcom/mrkeyboard/app/MrFuzzy;

.field static sLastVisits:I

.field private static sReserveTyped:Ljava/lang/String;

.field private static sReserveWord:Ljava/lang/String;


# instance fields
.field private mBand:I

.field private final mDict:Ljava/nio/ByteBuffer;

.field private final mFirst:[Z

.field private final mIns:[I

.field private final mLatest:Z

.field private final mLeftBuf:[C

.field private final mLookBuf:[C

.field private mLookFreq:I

.field private mLookLen:I

.field private final mLookPath:[C

.field private mMaxCost:I

.field private mN:I

.field private final mNear:[[C

.field private final mNearCount:[I

.field private mOnlyTyped:I

.field private final mPath:[C

.field private mR:Lcom/mrkeyboard/app/MrRules;

.field private final mResCost:[I

.field private mResCount:I

.field private final mResLen:[I

.field private final mResScore:[J

.field private final mResWord:[[C

.field private final mRoot:I

.field private final mRows:[[I

.field private final mSize:I

.field private final mSplitBuf:[C

.field private final mSub:[[S

.field private final mTb:[C

.field private final mTwoD1:[C

.field private final mTwoD2:[C

.field private mVisits:I


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/16 v3, 0x100

    .line 49
    new-array v0, v3, [C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    .line 50
    new-array v0, v3, [C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    .line 53
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v3, :cond_0

    .line 54
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    aput-char v2, v1, v0

    .line 55
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    int-to-char v2, v0

    invoke-static {v2}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v2

    aput-char v2, v1, v0

    .line 53
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 57
    :cond_0
    return-void
.end method

.method constructor <init>(Ljava/nio/ByteBuffer;I)V
    .locals 7

    .prologue
    const/16 v6, 0x15

    const/4 v1, 0x1

    const/4 v5, 0x5

    const/4 v2, 0x0

    const/16 v4, 0x14

    .line 102
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 70
    new-array v0, v4, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    .line 71
    const/16 v0, 0x10

    filled-new-array {v4, v0}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    .line 72
    new-array v0, v4, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    .line 73
    const/16 v0, 0x100

    filled-new-array {v4, v0}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Short;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[S

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    .line 74
    new-array v0, v4, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    .line 75
    const/16 v0, 0x100

    new-array v0, v0, [Z

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    .line 77
    new-array v0, v6, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD1:[C

    .line 78
    new-array v0, v6, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD2:[C

    .line 80
    sget-object v0, Lcom/mrkeyboard/app/MrRules;->EMPTY:Lcom/mrkeyboard/app/MrRules;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 81
    const/16 v0, 0x19

    filled-new-array {v0, v6}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    .line 82
    const/16 v0, 0x32

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    .line 91
    const/16 v0, 0x62

    filled-new-array {v5, v0}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    .line 92
    new-array v0, v5, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    .line 93
    new-array v0, v5, [J

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    .line 94
    new-array v0, v5, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    .line 665
    const/16 v0, 0x62

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    .line 666
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    .line 667
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    .line 668
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    .line 103
    iput-object p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    .line 104
    iput p2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    .line 106
    const/4 v0, 0x2

    if-le p2, v0, :cond_3

    .line 107
    invoke-virtual {p1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 108
    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 109
    const/16 v4, 0xc8

    if-lt v0, v4, :cond_2

    if-eqz v3, :cond_0

    if-ne v3, v1, :cond_2

    :cond_0
    move v0, v1

    .line 111
    :goto_0
    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    .line 112
    if-eqz v0, :cond_1

    const/4 v2, 0x2

    :cond_1
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    .line 113
    return-void

    :cond_2
    move v0, v2

    .line 109
    goto :goto_0

    :cond_3
    move v0, v2

    goto :goto_0
.end method

.method public static afterWords(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 133
    const/4 v1, 0x0

    :try_start_0
    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 134
    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 135
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 162
    :cond_0
    :goto_0
    return-void

    .line 136
    :cond_1
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->size()I

    move-result v1

    .line 137
    const/4 v2, 0x2

    if-lt v1, v2, :cond_0

    const/16 v2, 0x14

    if-gt v1, v2, :cond_0

    .line 138
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->getTypedWord()Ljava/lang/CharSequence;

    move-result-object v2

    .line 139
    if-eqz v2, :cond_0

    .line 140
    invoke-static {v2}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    .line 141
    if-eqz v3, :cond_2

    .line 142
    invoke-virtual {v3}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 143
    const/4 v2, 0x0

    array-length v3, v1

    const v4, 0x1fffffff

    const/4 v5, 0x1

    sget-object v6, Lcom/mrkeyboard/app/Dictionary$DataType;->UNIGRAM:Lcom/mrkeyboard/app/Dictionary$DataType;

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/Suggest;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z

    goto :goto_0

    .line 159
    :catch_0
    move-exception v0

    goto :goto_0

    .line 146
    :cond_2
    const/4 v3, 0x3

    if-lt v1, v3, :cond_0

    .line 147
    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/Suggest;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 148
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v1

    .line 149
    if-eqz v1, :cond_0

    .line 150
    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrLength()I

    move-result v1

    invoke-static {v3, v1}, Lcom/mrkeyboard/app/MrFuzzy;->forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;

    move-result-object v1

    .line 151
    if-eqz v1, :cond_0

    .line 152
    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 153
    :try_start_1
    invoke-virtual {v1, p1, v2}, Lcom/mrkeyboard/app/MrFuzzy;->search(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;)V

    .line 154
    invoke-virtual {v1, p0}, Lcom/mrkeyboard/app/MrFuzzy;->emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V

    .line 155
    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 156
    iget v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-lez v2, :cond_3

    iget-object v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    const/4 v3, 0x0

    aget v2, v2, v3

    const/16 v3, 0x2d

    if-gt v2, v3, :cond_3

    .line 157
    const/4 v0, 0x0

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->resultWord(I)Ljava/lang/String;

    move-result-object v0

    :cond_3
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 158
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v0
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0
.end method

.method private static baseString(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 233
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    new-array v1, v0, [C

    .line 234
    const/4 v0, 0x0

    :goto_0
    array-length v2, v1

    if-ge v0, v2, :cond_0

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    aput-char v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 235
    :cond_0
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/String;-><init>([C)V

    return-object v0
.end method

.method static confident(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 6

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 224
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 225
    if-eqz v0, :cond_1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 229
    :cond_0
    :goto_0
    return v1

    .line 226
    :cond_1
    const/16 v0, 0x20

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_2

    move v1, v2

    goto :goto_0

    .line 227
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {p1}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 228
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v5, 0x5

    if-gt v0, v5, :cond_3

    move v0, v1

    .line 229
    :goto_1
    invoke-static {v3, v4, v0}, Lcom/mrkeyboard/app/MrFuzzy;->distance(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v3

    if-le v3, v0, :cond_0

    move v1, v2

    goto :goto_0

    .line 228
    :cond_3
    const/4 v0, 0x2

    goto :goto_1
.end method

.method private delCost(III)I
    .locals 6

    .prologue
    const/16 v5, 0x100

    .line 585
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 586
    if-nez p3, :cond_0

    if-ge p1, v5, :cond_0

    iget-object v0, v1, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v0, v0, p1

    if-lez v0, :cond_0

    iget-object v0, v1, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v0, v0, p1

    .line 593
    :goto_0
    return v0

    .line 587
    :cond_0
    if-lez p3, :cond_1

    if-ne p1, p2, :cond_1

    const/16 v0, 0x1e

    goto :goto_0

    .line 588
    :cond_1
    iget-object v2, v1, Lcom/mrkeyboard/app/MrRules;->silPrev:[C

    iget-object v3, v1, Lcom/mrkeyboard/app/MrRules;->silChar:[C

    .line 589
    const/4 v0, 0x0

    :goto_1
    array-length v4, v2

    if-ge v0, v4, :cond_3

    .line 590
    aget-char v4, v3, v0

    if-ne v4, p1, :cond_2

    aget-char v4, v2, v0

    if-ne v4, p2, :cond_2

    iget-object v1, v1, Lcom/mrkeyboard/app/MrRules;->silCost:[S

    aget-short v0, v1, v0

    goto :goto_0

    .line 589
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 592
    :cond_3
    if-lez p3, :cond_4

    if-ge p1, v5, :cond_4

    iget-object v0, v1, Lcom/mrkeyboard/app/MrRules;->silentAny:[S

    aget-short v0, v0, p1

    if-lez v0, :cond_4

    iget-object v0, v1, Lcom/mrkeyboard/app/MrRules;->silentAny:[S

    aget-short v0, v0, p1

    goto :goto_0

    .line 593
    :cond_4
    const/16 v0, 0x3c

    goto :goto_0
.end method

.method static distance(Ljava/lang/String;Ljava/lang/String;I)I
    .locals 12

    .prologue
    .line 240
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v7

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v8

    .line 241
    sub-int v0, v7, v8

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    if-le v0, p2, :cond_0

    add-int/lit8 v0, p2, 0x1

    .line 259
    :goto_0
    return v0

    .line 242
    :cond_0
    add-int/lit8 v0, v8, 0x1

    new-array v5, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v4, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v1, v0, [I

    .line 243
    const/4 v0, 0x0

    :goto_1
    if-gt v0, v8, :cond_1

    aput v0, v4, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 244
    :cond_1
    const/4 v0, 0x1

    move v3, v0

    move-object v6, v4

    move-object v4, v1

    :goto_2
    if-gt v3, v7, :cond_6

    .line 245
    const/4 v0, 0x0

    aput v3, v4, v0

    .line 246
    const/4 v0, 0x0

    aget v1, v4, v0

    .line 247
    const/4 v0, 0x1

    move v2, v0

    :goto_3
    if-gt v2, v8, :cond_4

    .line 248
    add-int/lit8 v0, v3, -0x1

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    add-int/lit8 v9, v2, -0x1

    invoke-virtual {p1, v9}, Ljava/lang/String;->charAt(I)C

    move-result v9

    if-ne v0, v9, :cond_3

    const/4 v0, 0x0

    .line 249
    :goto_4
    aget v9, v6, v2

    add-int/lit8 v9, v9, 0x1

    add-int/lit8 v10, v2, -0x1

    aget v10, v4, v10

    add-int/lit8 v10, v10, 0x1

    invoke-static {v9, v10}, Ljava/lang/Math;->min(II)I

    move-result v9

    add-int/lit8 v10, v2, -0x1

    aget v10, v6, v10

    add-int/2addr v0, v10

    invoke-static {v9, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 250
    const/4 v9, 0x1

    if-le v3, v9, :cond_2

    const/4 v9, 0x1

    if-le v2, v9, :cond_2

    add-int/lit8 v9, v3, -0x1

    invoke-virtual {p0, v9}, Ljava/lang/String;->charAt(I)C

    move-result v9

    add-int/lit8 v10, v2, -0x2

    invoke-virtual {p1, v10}, Ljava/lang/String;->charAt(I)C

    move-result v10

    if-ne v9, v10, :cond_2

    add-int/lit8 v9, v3, -0x2

    invoke-virtual {p0, v9}, Ljava/lang/String;->charAt(I)C

    move-result v9

    add-int/lit8 v10, v2, -0x1

    invoke-virtual {p1, v10}, Ljava/lang/String;->charAt(I)C

    move-result v10

    if-ne v9, v10, :cond_2

    .line 251
    add-int/lit8 v9, v2, -0x2

    aget v9, v5, v9

    add-int/lit8 v9, v9, 0x1

    invoke-static {v0, v9}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 253
    :cond_2
    aput v0, v4, v2

    .line 254
    if-ge v0, v1, :cond_7

    .line 247
    :goto_5
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    move v1, v0

    goto :goto_3

    .line 248
    :cond_3
    const/4 v0, 0x1

    goto :goto_4

    .line 256
    :cond_4
    if-le v1, p2, :cond_5

    add-int/lit8 v0, p2, 0x1

    goto/16 :goto_0

    .line 244
    :cond_5
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    move-object v11, v5

    move-object v5, v6

    move-object v6, v4

    move-object v4, v11

    goto :goto_2

    .line 259
    :cond_6
    aget v0, v6, v8

    goto/16 :goto_0

    :cond_7
    move v0, v1

    goto :goto_5
.end method

.method public static finish(Ljava/util/List;Z)Z
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/CharSequence;",
            ">;Z)Z"
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    const/4 v6, 0x2

    const/4 v2, 0x1

    .line 177
    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 178
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 179
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 180
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 182
    if-eqz p0, :cond_0

    :try_start_0
    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 220
    :cond_0
    :goto_0
    return p1

    .line 183
    :cond_1
    const/4 v0, 0x0

    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v5

    .line 184
    if-eqz v1, :cond_5

    invoke-virtual {v5, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_5

    .line 186
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    if-le v0, v2, :cond_7

    invoke-virtual {v5}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-virtual {v5}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_7

    .line 187
    invoke-virtual {v1}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    .line 191
    :cond_2
    :goto_1
    const/4 v4, -0x1

    move v3, v2

    .line 192
    :goto_2
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v3, v0, :cond_c

    .line 193
    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_8

    move v0, v3

    .line 195
    :goto_3
    if-ltz v0, :cond_3

    if-le v0, v6, :cond_5

    .line 196
    :cond_3
    if-le v0, v6, :cond_4

    invoke-interface {p0, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 197
    :cond_4
    const/4 v0, 0x2

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v3

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-interface {p0, v0, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 202
    :cond_5
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    if-ne v0, v2, :cond_b

    .line 203
    invoke-static {v5}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 204
    if-eqz v0, :cond_b

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_b

    .line 205
    const/4 v1, 0x0

    invoke-virtual {v5, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v1

    if-eqz v1, :cond_9

    .line 206
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v3, 0x0

    invoke-virtual {v0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/Character;->toUpperCase(C)C

    move-result v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    const/4 v3, 0x1

    invoke-virtual {v0, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v3, v0

    .line 207
    :goto_4
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v0

    :goto_5
    if-lt v1, v2, :cond_a

    .line 208
    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-interface {p0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 207
    :cond_6
    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_5

    .line 188
    :cond_7
    const/4 v0, 0x0

    invoke-virtual {v5, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 189
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/Character;->toUpperCase(C)C

    move-result v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v3, 0x1

    invoke-virtual {v1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    goto/16 :goto_1

    .line 192
    :cond_8
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_2

    :cond_9
    move-object v3, v0

    .line 206
    goto :goto_4

    .line 210
    :cond_a
    const/4 v0, 0x1

    invoke-interface {p0, v0, v3}, Ljava/util/List;->add(ILjava/lang/Object;)V

    move p1, v2

    .line 211
    goto/16 :goto_0

    .line 214
    :cond_b
    if-eqz p1, :cond_0

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v0, v6, :cond_0

    .line 215
    const/4 v0, 0x1

    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v5, v0}, Lcom/mrkeyboard/app/MrFuzzy;->confident(Ljava/lang/String;Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result p1

    goto/16 :goto_0

    .line 217
    :catch_0
    move-exception v0

    goto/16 :goto_0

    :cond_c
    move v0, v4

    goto/16 :goto_3
.end method

.method private firstLetters()V
    .locals 8

    .prologue
    const/16 v7, 0x100

    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 391
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([ZZ)V

    .line 392
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v3, v0, v2

    .line 393
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    and-int/lit16 v5, v3, 0xff

    if-ge v3, v7, :cond_1

    move v0, v1

    :goto_0
    aput-boolean v0, v4, v5

    move v0, v2

    .line 394
    :goto_1
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v4, v4, v2

    if-ge v0, v4, :cond_2

    .line 395
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v4, v4, v2

    aget-char v4, v4, v0

    .line 396
    if-ge v4, v7, :cond_0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v4

    .line 394
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    move v0, v2

    .line 393
    goto :goto_0

    .line 398
    :cond_2
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    move v0, v2

    .line 399
    :goto_2
    if-ge v0, v7, :cond_5

    .line 401
    invoke-virtual {v4, v0, v3}, Lcom/mrkeyboard/app/MrRules;->pair(CC)I

    move-result v5

    if-nez v5, :cond_3

    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v5, v5, v0

    if-lez v5, :cond_4

    :cond_3
    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v0

    .line 399
    :cond_4
    add-int/lit8 v0, v0, 0x1

    int-to-char v0, v0

    goto :goto_2

    .line 404
    :cond_5
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-le v0, v1, :cond_7

    move v0, v2

    .line 405
    :goto_3
    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    array-length v5, v5

    if-ge v0, v5, :cond_7

    .line 406
    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    aget-char v5, v5, v0

    if-ne v5, v3, :cond_6

    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2b:[C

    aget-char v5, v5, v0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v6, v6, v1

    if-ne v5, v6, :cond_6

    .line 407
    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2d:[C

    aget-char v5, v5, v0

    invoke-static {v5}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v5

    .line 408
    if-ge v5, v7, :cond_6

    iget-object v6, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v6, v5

    .line 405
    :cond_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 412
    :cond_7
    :goto_4
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    array-length v0, v0

    if-ge v2, v0, :cond_9

    .line 413
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    aget-char v0, v0, v2

    if-ne v0, v3, :cond_8

    .line 414
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    aget-char v0, v0, v2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v0

    .line 415
    if-ge v0, v7, :cond_8

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v0

    .line 412
    :cond_8
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    .line 418
    :cond_9
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-le v0, v1, :cond_a

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, v1

    if-ge v0, v7, :cond_a

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v2, v2, v1

    aput-boolean v1, v0, v2

    .line 419
    :cond_a
    return-void
.end method

.method static declared-synchronized forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;
    .locals 3

    .prologue
    .line 116
    const-class v1, Lcom/mrkeyboard/app/MrFuzzy;

    monitor-enter v1

    if-eqz p0, :cond_0

    const/4 v0, 0x2

    if-gt p1, v0, :cond_2

    :cond_0
    const/4 v0, 0x0

    .line 122
    :cond_1
    :goto_0
    monitor-exit v1

    return-object v0

    .line 117
    :cond_2
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;

    .line 118
    if-eqz v0, :cond_3

    iget-object v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    if-ne v2, p0, :cond_3

    iget v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-eq v2, p1, :cond_1

    .line 119
    :cond_3
    new-instance v0, Lcom/mrkeyboard/app/MrFuzzy;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrFuzzy;-><init>(Ljava/nio/ByteBuffer;I)V

    .line 120
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 116
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private insCost(I)I
    .locals 4

    .prologue
    const/16 v0, 0x2d

    .line 575
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v1, v1, p1

    .line 576
    if-lez p1, :cond_1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v3, p1, -0x1

    aget-char v2, v2, v3

    if-ne v2, v1, :cond_1

    const/16 v0, 0x1e

    .line 580
    :cond_0
    :goto_0
    return v0

    .line 577
    :cond_1
    const/16 v2, 0x100

    if-ge v1, v2, :cond_2

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v2, v2, Lcom/mrkeyboard/app/MrRules;->extra:[Z

    aget-boolean v2, v2, v1

    if-eqz v2, :cond_2

    const/16 v0, 0x28

    goto :goto_0

    .line 578
    :cond_2
    if-lez p1, :cond_3

    add-int/lit8 v2, p1, -0x1

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v2

    if-nez v2, :cond_0

    .line 579
    :cond_3
    add-int/lit8 v2, p1, 0x1

    iget v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-ge v2, v3, :cond_4

    add-int/lit8 v2, p1, 0x1

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v1

    if-nez v1, :cond_0

    .line 580
    :cond_4
    const/16 v0, 0x3c

    goto :goto_0
.end method

.method private insert([CIIJI)V
    .locals 8

    .prologue
    const/4 v7, 0x5

    const/4 v1, 0x0

    .line 612
    move v0, v1

    :goto_0
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v0, v2, :cond_2

    .line 613
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aget v2, v2, v0

    if-ne v2, p3, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v2, v2, v0

    invoke-static {v2, p1, p2, p3}, Lcom/mrkeyboard/app/MrFuzzy;->same([C[CII)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 614
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v2, v2, v0

    cmp-long v2, p4, v2

    if-gtz v2, :cond_1

    .line 636
    :cond_0
    :goto_1
    return-void

    .line 615
    :cond_1
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->remove(I)V

    .line 619
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    move v2, v0

    .line 620
    :goto_2
    if-lez v2, :cond_4

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    add-int/lit8 v3, v2, -0x1

    aget-wide v4, v0, v3

    cmp-long v0, v4, p4

    if-gez v0, :cond_4

    add-int/lit8 v0, v2, -0x1

    move v2, v0

    goto :goto_2

    .line 612
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 621
    :cond_4
    if-ge v2, v7, :cond_0

    .line 622
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    const/4 v3, 0x4

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 623
    :goto_3
    if-le v0, v2, :cond_5

    .line 624
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v3, v3, v0

    .line 625
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v6, v0, -0x1

    aget-object v5, v5, v6

    aput-object v5, v4, v0

    .line 626
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v5, v0, -0x1

    aput-object v3, v4, v5

    .line 627
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    add-int/lit8 v5, v0, -0x1

    aget v4, v4, v5

    aput v4, v3, v0

    .line 628
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    add-int/lit8 v5, v0, -0x1

    aget-wide v4, v4, v5

    aput-wide v4, v3, v0

    .line 629
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    add-int/lit8 v5, v0, -0x1

    aget v4, v4, v5

    aput v4, v3, v0

    .line 623
    add-int/lit8 v0, v0, -0x1

    goto :goto_3

    .line 631
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v0, v0, v2

    invoke-static {p1, p2, v0, v1, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 632
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aput p3, v0, v2

    .line 633
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aput-wide p4, v0, v2

    .line 634
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    aput p6, v0, v2

    .line 635
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v0, v7, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    goto :goto_1
.end method

.method private isNear(IC)Z
    .locals 3

    .prologue
    .line 556
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v1, v0, p1

    .line 557
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v0, v0, p1

    add-int/lit8 v0, v0, -0x1

    :goto_0
    if-ltz v0, :cond_1

    .line 558
    aget-char v2, v1, v0

    if-ne v2, p2, :cond_0

    const/4 v0, 0x1

    .line 560
    :goto_1
    return v0

    .line 557
    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 560
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private isPrefix()Z
    .locals 2

    .prologue
    .line 348
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->prefixRec(II)Z

    move-result v0

    return v0
.end method

.method private lookup(II)I
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 702
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 703
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 704
    sub-int v1, p2, p1

    const/16 v2, 0x30

    if-le v1, v2, :cond_0

    .line 706
    :goto_0
    return v0

    .line 705
    :cond_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v1, p1, p2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->lookupRec(IIII)V

    .line 706
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    goto :goto_0
.end method

.method private lookupRec(IIII)V
    .locals 10

    .prologue
    const/4 v3, 0x0

    .line 710
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 752
    :cond_0
    return-void

    .line 711
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v8, v0, 0xff

    .line 712
    add-int/lit8 v4, p1, 0x1

    .line 713
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v9, v0, p2

    move v7, v3

    .line 714
    :goto_0
    if-ge v7, v8, :cond_0

    .line 715
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v0, :cond_0

    .line 716
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v4, 0x1

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 717
    const/16 v2, 0xff

    if-ne v0, v2, :cond_2

    .line 718
    add-int/lit8 v0, v1, 0x1

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v0, v2, :cond_0

    .line 719
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x8

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v4, v1, 0x1

    invoke-virtual {v2, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v2, v2, 0xff

    or-int/2addr v0, v2

    .line 720
    add-int/lit8 v1, v1, 0x2

    .line 722
    :cond_2
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v2, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v4, v2, 0xff

    .line 723
    and-int/lit16 v2, v4, 0x80

    if-eqz v2, :cond_4

    const/4 v2, 0x1

    move v6, v2

    .line 725
    :goto_1
    and-int/lit8 v2, v4, 0x40

    if-eqz v2, :cond_5

    .line 726
    add-int/lit8 v2, v1, 0x2

    iget v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v2, v5, :cond_0

    .line 727
    and-int/lit8 v2, v4, 0x3f

    shl-int/lit8 v2, v2, 0x10

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v5, v1, 0x1

    invoke-virtual {v4, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    shl-int/lit8 v4, v4, 0x8

    or-int/2addr v2, v4

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v5, v1, 0x2

    invoke-virtual {v4, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    or-int/2addr v2, v4

    .line 728
    add-int/lit8 v1, v1, 0x3

    move v5, v2

    .line 733
    :goto_2
    if-eqz v6, :cond_a

    .line 734
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    .line 735
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v1, 0x1

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 736
    iget-boolean v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v4, :cond_9

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v2

    move v4, v2

    move v2, v1

    .line 738
    :goto_3
    const/16 v1, 0x100

    if-ge v0, v1, :cond_6

    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v1, v1, v0

    .line 739
    :goto_4
    if-eq v1, v9, :cond_7

    .line 714
    :cond_3
    :goto_5
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto/16 :goto_0

    :cond_4
    move v6, v3

    .line 723
    goto :goto_1

    .line 730
    :cond_5
    add-int/lit8 v1, v1, 0x1

    move v5, v3

    goto :goto_2

    .line 738
    :cond_6
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    goto :goto_4

    .line 740
    :cond_7
    int-to-char v0, v0

    .line 741
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aput-char v0, v1, p4

    .line 742
    add-int/lit8 v0, p2, 0x1

    if-ne v0, p3, :cond_8

    .line 743
    if-eqz v6, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    if-le v2, v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aget-char v0, v0, v3

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-nez v0, :cond_3

    .line 744
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 745
    add-int/lit8 v0, p4, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 746
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    add-int/lit8 v2, p4, 0x1

    invoke-static {v0, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_5

    .line 748
    :cond_8
    if-eqz v5, :cond_3

    .line 749
    add-int/lit8 v0, p2, 0x1

    add-int/lit8 v1, p4, 0x1

    invoke-direct {p0, v5, v0, p3, v1}, Lcom/mrkeyboard/app/MrFuzzy;->lookupRec(IIII)V

    goto :goto_5

    :cond_9
    move v4, v2

    move v2, v1

    goto :goto_3

    :cond_a
    move v2, v3

    move v4, v1

    goto :goto_3
.end method

.method private offer([CIII)V
    .locals 7

    .prologue
    .line 605
    invoke-direct {p0, p3, p4}, Lcom/mrkeyboard/app/MrFuzzy;->scoreFor(II)J

    move-result-wide v4

    .line 606
    const-wide/16 v0, 0x0

    cmp-long v0, v4, v0

    if-gtz v0, :cond_0

    .line 608
    :goto_0
    return-void

    .line 607
    :cond_0
    const/4 v2, 0x0

    move-object v0, p0

    move-object v1, p1

    move v3, p2

    move v6, p4

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrFuzzy;->insert([CIIJI)V

    goto :goto_0
.end method

.method private oneLetterWord(C)Z
    .locals 1

    .prologue
    .line 697
    const/16 v0, 0x100

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrRules;->oneLetter:[Z

    aget-boolean v0, v0, p1

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private prefixRec(II)Z
    .locals 11

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 352
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    :cond_0
    move v0, v2

    .line 386
    :goto_0
    return v0

    .line 353
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v6, v0, 0xff

    .line 354
    add-int/lit8 v1, p1, 0x1

    .line 355
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v7, v0, p2

    move v5, v2

    move v0, v1

    .line 356
    :goto_1
    if-ge v5, v6, :cond_d

    .line 357
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v0, v1, :cond_2

    move v0, v2

    goto :goto_0

    .line 358
    :cond_2
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v0, 0x1

    invoke-virtual {v4, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 359
    const/16 v4, 0xff

    if-ne v0, v4, :cond_4

    .line 360
    add-int/lit8 v0, v1, 0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v0, v4, :cond_3

    move v0, v2

    goto :goto_0

    .line 361
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x8

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v8, v1, 0x1

    invoke-virtual {v4, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    or-int/2addr v0, v4

    .line 362
    add-int/lit8 v1, v1, 0x2

    .line 364
    :cond_4
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v8, v4, 0xff

    .line 366
    and-int/lit8 v4, v8, 0x40

    if-eqz v4, :cond_6

    .line 367
    add-int/lit8 v4, v1, 0x2

    iget v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v4, v9, :cond_5

    move v0, v2

    goto :goto_0

    .line 368
    :cond_5
    and-int/lit8 v4, v8, 0x3f

    shl-int/lit8 v4, v4, 0x10

    iget-object v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v10, v1, 0x1

    invoke-virtual {v9, v10}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v9

    and-int/lit16 v9, v9, 0xff

    shl-int/lit8 v9, v9, 0x8

    or-int/2addr v4, v9

    iget-object v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v10, v1, 0x2

    invoke-virtual {v9, v10}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v9

    and-int/lit16 v9, v9, 0xff

    or-int/2addr v4, v9

    .line 369
    add-int/lit8 v1, v1, 0x3

    .line 373
    :goto_2
    and-int/lit16 v8, v8, 0x80

    if-eqz v8, :cond_8

    .line 374
    iget v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v1, v8, :cond_7

    move v0, v2

    goto/16 :goto_0

    .line 371
    :cond_6
    add-int/lit8 v1, v1, 0x1

    move v4, v2

    goto :goto_2

    .line 375
    :cond_7
    add-int/lit8 v1, v1, 0x1

    .line 376
    iget-boolean v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v8, :cond_8

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v1

    .line 378
    :cond_8
    const/16 v8, 0x100

    if-ge v0, v8, :cond_a

    sget-object v8, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v0, v8, v0

    .line 379
    :goto_3
    if-eq v0, v7, :cond_b

    .line 356
    :cond_9
    add-int/lit8 v0, v5, 0x1

    move v5, v0

    move v0, v1

    goto/16 :goto_1

    .line 378
    :cond_a
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v0

    goto :goto_3

    .line 380
    :cond_b
    add-int/lit8 v0, p2, 0x1

    iget v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-ne v0, v8, :cond_c

    .line 381
    if-eqz v4, :cond_9

    move v0, v3

    goto/16 :goto_0

    .line 382
    :cond_c
    if-eqz v4, :cond_9

    add-int/lit8 v0, p2, 0x1

    invoke-direct {p0, v4, v0}, Lcom/mrkeyboard/app/MrFuzzy;->prefixRec(II)Z

    move-result v0

    if-eqz v0, :cond_9

    move v0, v3

    .line 383
    goto/16 :goto_0

    :cond_d
    move v0, v2

    .line 386
    goto/16 :goto_0
.end method

.method private remove(I)V
    .locals 4

    .prologue
    .line 639
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v0, v0, p1

    .line 640
    :goto_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v1, v1, -0x1

    if-ge p1, v1, :cond_0

    .line 641
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v3, p1, 0x1

    aget-object v2, v2, v3

    aput-object v2, v1, p1

    .line 642
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    add-int/lit8 v3, p1, 0x1

    aget v2, v2, v3

    aput v2, v1, p1

    .line 643
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    add-int/lit8 v3, p1, 0x1

    aget-wide v2, v2, v3

    aput-wide v2, v1, p1

    .line 644
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    add-int/lit8 v3, p1, 0x1

    aget v2, v2, v3

    aput v2, v1, p1

    .line 640
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 646
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v2, v2, -0x1

    aput-object v0, v1, v2

    .line 647
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 648
    return-void
.end method

.method private static same([C[CII)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 651
    move v1, v0

    :goto_0
    if-ge v1, p3, :cond_1

    aget-char v2, p0, v1

    add-int v3, p2, v1

    aget-char v3, p1, v3

    if-eq v2, v3, :cond_0

    .line 652
    :goto_1
    return v0

    .line 651
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 652
    :cond_1
    const/4 v0, 0x1

    goto :goto_1
.end method

.method private scoreFor(II)J
    .locals 10

    .prologue
    const-wide v0, 0x41affffffe000000L    # 2.68435455E8

    .line 597
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    const/16 v3, 0x18

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 598
    int-to-double v4, p1

    const-wide/16 v6, 0x1

    add-int/lit8 v2, v2, 0x1

    shl-long v2, v6, v2

    long-to-double v2, v2

    mul-double/2addr v2, v4

    .line 599
    const-wide/high16 v4, 0x4000000000000000L    # 2.0

    neg-int v6, p2

    int-to-double v6, v6

    const-wide/high16 v8, 0x4039000000000000L    # 25.0

    div-double/2addr v6, v8

    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v4

    mul-double/2addr v2, v4

    .line 600
    cmpl-double v4, v2, v0

    if-lez v4, :cond_0

    .line 601
    :goto_0
    double-to-long v0, v0

    return-wide v0

    :cond_0
    move-wide v0, v2

    goto :goto_0
.end method

.method private setMaxCost(I)V
    .locals 1

    .prologue
    .line 332
    iput p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mMaxCost:I

    .line 333
    div-int/lit8 v0, p1, 0x1e

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    .line 334
    return-void
.end method

.method private skipBigrams(I)I
    .locals 3

    .prologue
    .line 542
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 552
    :cond_0
    :goto_0
    return p1

    .line 543
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    if-eqz v0, :cond_2

    .line 544
    const/4 v0, 0x0

    .line 545
    :goto_1
    add-int/lit8 v1, p1, 0x3

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    add-int/lit8 v1, v0, 0x1

    const/16 v2, 0x2710

    if-ge v0, v2, :cond_0

    .line 546
    add-int/lit8 v0, p1, 0x3

    .line 547
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 p1, v0, 0x1

    invoke-virtual {v2, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    .line 548
    if-eqz v0, :cond_0

    move v0, v1

    .line 549
    goto :goto_1

    .line 552
    :cond_2
    add-int/lit8 p1, p1, 0x1

    goto :goto_0
.end method

.method private split()V
    .locals 12

    .prologue
    const/16 v6, 0x23

    const/4 v8, 0x1

    const/4 v2, 0x0

    .line 673
    iget v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    .line 674
    const-wide/16 v4, 0x0

    move v7, v8

    move v3, v2

    .line 676
    :goto_0
    add-int/lit8 v0, v9, -0x2

    if-gt v7, v0, :cond_2

    .line 677
    if-ne v7, v8, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, v2

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneLetterWord(C)Z

    move-result v0

    if-nez v0, :cond_1

    .line 676
    :cond_0
    :goto_1
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    .line 678
    :cond_1
    invoke-direct {p0, v2, v7}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v0

    .line 679
    if-lez v0, :cond_0

    .line 680
    iget v10, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 681
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    iget-object v11, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    invoke-static {v1, v2, v11, v2, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 682
    invoke-direct {p0, v7, v9}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v1

    .line 683
    if-lez v1, :cond_0

    .line 684
    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->scoreFor(II)J

    move-result-wide v0

    .line 685
    cmp-long v11, v0, v4

    if-lez v11, :cond_0

    .line 687
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    invoke-static {v3, v2, v4, v2, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 688
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    const/16 v4, 0x20

    aput-char v4, v3, v10

    .line 689
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    add-int/lit8 v5, v10, 0x1

    iget v11, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    invoke-static {v3, v2, v4, v5, v11}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 690
    add-int/lit8 v3, v10, 0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    add-int/2addr v3, v4

    move-wide v4, v0

    goto :goto_1

    .line 693
    :cond_2
    if-lez v3, :cond_3

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    move-object v0, p0

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrFuzzy;->insert([CIIJI)V

    .line 694
    :cond_3
    return-void
.end method

.method private sub(II)I
    .locals 2

    .prologue
    .line 422
    const/16 v0, 0x100

    if-lt p2, v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, p1

    if-ne p2, v0, :cond_1

    const/4 v0, 0x0

    .line 428
    :cond_0
    :goto_0
    return v0

    .line 422
    :cond_1
    const/16 v0, 0x4b

    goto :goto_0

    .line 423
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v0, v0, p1

    aget-short v0, v0, p2

    .line 424
    if-gez v0, :cond_0

    .line 425
    int-to-char v0, p2

    invoke-direct {p0, v0, p1}, Lcom/mrkeyboard/app/MrFuzzy;->subCost(CI)I

    move-result v0

    int-to-short v0, v0

    .line 426
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v1, v1, p1

    aput-short v0, v1, p2

    goto :goto_0
.end method

.method private subCost(CI)I
    .locals 3

    .prologue
    const/16 v0, 0x19

    .line 564
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v1, v1, p2

    .line 565
    if-ne p1, v1, :cond_1

    const/4 v0, 0x0

    .line 570
    :cond_0
    :goto_0
    return v0

    .line 566
    :cond_1
    invoke-direct {p0, p2, p1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v2

    if-nez v2, :cond_0

    .line 567
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    invoke-virtual {v2, p1, v1}, Lcom/mrkeyboard/app/MrRules;->pair(CC)I

    move-result v1

    .line 568
    const/4 v2, 0x1

    if-eq v1, v2, :cond_0

    .line 569
    const/4 v0, 0x2

    if-ne v1, v0, :cond_2

    const/16 v0, 0x2d

    goto :goto_0

    .line 570
    :cond_2
    const/16 v0, 0x4b

    goto :goto_0
.end method

.method private walk(IIIC)V
    .locals 28

    .prologue
    .line 432
    if-ltz p1, :cond_0

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    move/from16 v0, p1

    if-lt v0, v4, :cond_1

    .line 539
    :cond_0
    return-void

    .line 433
    :cond_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    move/from16 v0, p1

    invoke-virtual {v4, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v0, v4, 0xff

    move/from16 v21, v0

    .line 434
    add-int/lit8 v6, p1, 0x1

    .line 435
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v13, v4, p2

    .line 436
    if-lez p2, :cond_4

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v5, p2, -0x1

    aget-object v4, v4, v5

    .line 437
    :goto_0
    move-object/from16 v0, p0

    iget v0, v0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move/from16 v16, v0

    .line 438
    const/4 v5, 0x0

    move/from16 v20, v5

    move-object v12, v4

    :goto_1
    move/from16 v0, v20

    move/from16 v1, v21

    if-ge v0, v1, :cond_0

    .line 439
    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v6, v4, :cond_0

    .line 440
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v5, v6, 0x1

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 441
    const/16 v6, 0xff

    if-ne v4, v6, :cond_2

    .line 442
    add-int/lit8 v4, v5, 0x1

    move-object/from16 v0, p0

    iget v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v6, :cond_0

    .line 443
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v4, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    shl-int/lit8 v4, v4, 0x8

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v7, v5, 0x1

    invoke-virtual {v6, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    and-int/lit16 v6, v6, 0xff

    or-int/2addr v4, v6

    .line 444
    add-int/lit8 v5, v5, 0x2

    .line 446
    :cond_2
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v6, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    and-int/lit16 v7, v6, 0xff

    .line 447
    and-int/lit16 v6, v7, 0x80

    if-eqz v6, :cond_5

    const/4 v6, 0x1

    move/from16 v19, v6

    .line 448
    :goto_2
    const/4 v6, 0x0

    .line 449
    and-int/lit8 v8, v7, 0x40

    if-eqz v8, :cond_6

    .line 450
    add-int/lit8 v6, v5, 0x2

    move-object/from16 v0, p0

    iget v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v6, v8, :cond_0

    .line 451
    and-int/lit8 v6, v7, 0x3f

    shl-int/lit8 v6, v6, 0x10

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v8, v5, 0x1

    invoke-virtual {v7, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v7

    and-int/lit16 v7, v7, 0xff

    shl-int/lit8 v7, v7, 0x8

    or-int/2addr v6, v7

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v8, v5, 0x2

    invoke-virtual {v7, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v7

    and-int/lit16 v7, v7, 0xff

    or-int/2addr v6, v7

    .line 452
    add-int/lit8 v7, v5, 0x3

    move/from16 v18, v6

    .line 456
    :goto_3
    const/4 v5, 0x0

    .line 457
    if-eqz v19, :cond_25

    .line 458
    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v7, v5, :cond_0

    .line 459
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v6, v7, 0x1

    invoke-virtual {v5, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 460
    move-object/from16 v0, p0

    iget-boolean v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v7, :cond_3

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v6

    .line 462
    :cond_3
    :goto_4
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    add-int/lit8 v7, v7, 0x1

    move-object/from16 v0, p0

    iput v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v8, 0x2ee0

    if-gt v7, v8, :cond_0

    .line 463
    const/16 v7, 0x100

    if-ge v4, v7, :cond_7

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v7, v7, v4

    move/from16 v17, v7

    .line 464
    :goto_5
    if-nez p2, :cond_a

    .line 465
    const/16 v7, 0x100

    move/from16 v0, v17

    if-ge v0, v7, :cond_1e

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aget-boolean v7, v7, v17

    if-nez v7, :cond_8

    move-object v4, v12

    move-object v5, v13

    .line 438
    :goto_6
    add-int/lit8 v7, v20, 0x1

    move/from16 v20, v7

    move-object v12, v4

    move-object v13, v5

    goto/16 :goto_1

    .line 436
    :cond_4
    const/4 v4, 0x0

    goto/16 :goto_0

    .line 447
    :cond_5
    const/4 v6, 0x0

    move/from16 v19, v6

    goto/16 :goto_2

    .line 454
    :cond_6
    add-int/lit8 v7, v5, 0x1

    move/from16 v18, v6

    goto :goto_3

    .line 463
    :cond_7
    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    move/from16 v17, v7

    goto :goto_5

    .line 466
    :cond_8
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v8, 0x1

    if-ne v7, v8, :cond_9

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    const/4 v8, 0x0

    aget-char v7, v7, v8

    move/from16 v0, v17

    if-eq v0, v7, :cond_9

    move-object v4, v12

    move-object v5, v13

    goto :goto_6

    .line 467
    :cond_9
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v8, 0x2

    if-ne v7, v8, :cond_a

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    const/4 v8, 0x0

    aget-char v7, v7, v8

    move/from16 v0, v17

    if-ne v0, v7, :cond_a

    move-object v4, v12

    move-object v5, v13

    goto :goto_6

    .line 469
    :cond_a
    int-to-char v0, v4

    move/from16 v22, v0

    .line 470
    const/16 v7, 0x100

    if-ge v4, v7, :cond_c

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    aget-char v4, v7, v4

    .line 471
    :goto_7
    move-object/from16 v0, p0

    move/from16 v1, v17

    move/from16 v2, p3

    move/from16 v3, p2

    invoke-direct {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrFuzzy;->delCost(III)I

    move-result v23

    .line 473
    const/4 v10, -0x1

    const/4 v9, -0x1

    .line 474
    if-eqz v12, :cond_f

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v7, v7, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    array-length v7, v7

    if-lez v7, :cond_f

    .line 475
    const/16 v7, 0x100

    move/from16 v0, p4

    if-ge v0, v7, :cond_d

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    aget-char v7, v7, p4

    .line 476
    :goto_8
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v11, v8, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v14, v8, Lcom/mrkeyboard/app/MrRules;->d2c:[C

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v15, v8, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    .line 477
    const/4 v8, 0x0

    :goto_9
    array-length v0, v11

    move/from16 v24, v0

    move/from16 v0, v24

    if-ge v8, v0, :cond_f

    .line 478
    aget-char v24, v11, v8

    move/from16 v0, v24

    if-ne v0, v7, :cond_b

    aget-char v24, v14, v8

    move/from16 v0, v24

    if-ne v0, v4, :cond_b

    .line 479
    if-gez v10, :cond_e

    aget-char v10, v15, v8

    .line 477
    :cond_b
    :goto_a
    add-int/lit8 v8, v8, 0x1

    goto :goto_9

    .line 470
    :cond_c
    invoke-static/range {v22 .. v22}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v4

    goto :goto_7

    .line 475
    :cond_d
    invoke-static/range {p4 .. p4}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v7

    goto :goto_8

    .line 480
    :cond_e
    if-gez v9, :cond_b

    aget-char v9, v15, v8

    goto :goto_a

    .line 484
    :cond_f
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v8, p2, 0x1

    aget-object v24, v7, v8

    .line 485
    add-int/lit8 v8, p2, 0x1

    .line 486
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    sub-int v7, v8, v7

    .line 487
    move-object/from16 v0, p0

    iget v11, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    add-int/2addr v8, v11

    .line 488
    move/from16 v0, v16

    if-le v8, v0, :cond_24

    move/from16 v15, v16

    .line 489
    :goto_b
    const/high16 v11, 0x100000

    .line 490
    if-gtz v7, :cond_19

    .line 491
    const/4 v7, 0x0

    aget v7, v13, v7

    add-int v7, v7, v23

    .line 492
    const/high16 v8, 0x100000

    if-le v7, v8, :cond_10

    const/high16 v7, 0x100000

    .line 493
    :cond_10
    const/4 v8, 0x0

    aput v7, v24, v8

    .line 495
    const/4 v8, 0x1

    move v11, v7

    move v7, v8

    .line 499
    :goto_c
    add-int/lit8 v8, v15, 0x1

    move/from16 v0, v16

    if-gt v8, v0, :cond_11

    add-int/lit8 v8, v15, 0x1

    const/high16 v14, 0x100000

    aput v14, v24, v8

    .line 500
    :cond_11
    add-int/lit8 v8, v15, 0x2

    move/from16 v0, v16

    if-gt v8, v0, :cond_12

    add-int/lit8 v8, v15, 0x2

    const/high16 v14, 0x100000

    aput v14, v24, v8

    :cond_12
    move v14, v7

    .line 501
    :goto_d
    if-gt v14, v15, :cond_1a

    .line 502
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v8, v14, -0x1

    aget-char v25, v7, v8

    .line 503
    add-int/lit8 v7, v14, -0x1

    aget v7, v13, v7

    add-int/lit8 v8, v14, -0x1

    move-object/from16 v0, p0

    move/from16 v1, v17

    invoke-direct {v0, v8, v1}, Lcom/mrkeyboard/app/MrFuzzy;->sub(II)I

    move-result v8

    add-int/2addr v8, v7

    .line 504
    add-int/lit8 v7, v14, -0x1

    aget v7, v24, v7

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    move-object/from16 v26, v0

    add-int/lit8 v27, v14, -0x1

    aget v26, v26, v27

    add-int v7, v7, v26

    .line 505
    if-ge v7, v8, :cond_23

    .line 506
    :goto_e
    aget v8, v13, v14

    add-int v8, v8, v23

    .line 507
    if-ge v8, v7, :cond_22

    .line 508
    :goto_f
    const/4 v7, 0x2

    if-lt v14, v7, :cond_21

    .line 509
    if-eqz v12, :cond_20

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v26, v14, -0x2

    aget-char v7, v7, v26

    move/from16 v0, v17

    if-ne v0, v7, :cond_20

    move/from16 v0, p3

    move/from16 v1, v25

    if-ne v0, v1, :cond_20

    move/from16 v0, v17

    move/from16 v1, p3

    if-eq v0, v1, :cond_20

    .line 510
    add-int/lit8 v7, v14, -0x2

    aget v7, v12, v7

    add-int/lit8 v7, v7, 0x28

    .line 511
    if-ge v7, v8, :cond_20

    .line 513
    :goto_10
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD1:[C

    aget-char v8, v8, v14

    if-eqz v8, :cond_13

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD1:[C

    aget-char v8, v8, v14

    if-eq v4, v8, :cond_14

    :cond_13
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD2:[C

    aget-char v8, v8, v14

    if-eqz v8, :cond_15

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD2:[C

    aget-char v8, v8, v14

    if-ne v4, v8, :cond_15

    .line 514
    :cond_14
    add-int/lit8 v8, v14, -0x2

    aget v8, v13, v8

    add-int/lit8 v8, v8, 0x23

    .line 515
    if-ge v8, v7, :cond_15

    move v7, v8

    .line 518
    :cond_15
    :goto_11
    if-ltz v10, :cond_17

    move/from16 v0, v25

    if-eq v0, v10, :cond_16

    move/from16 v0, v25

    if-ne v0, v9, :cond_17

    .line 519
    :cond_16
    add-int/lit8 v8, v14, -0x1

    aget v8, v12, v8

    add-int/lit8 v8, v8, 0x23

    .line 520
    if-ge v8, v7, :cond_17

    move v7, v8

    .line 522
    :cond_17
    const/high16 v8, 0x100000

    if-le v7, v8, :cond_18

    const/high16 v7, 0x100000

    .line 523
    :cond_18
    aput v7, v24, v14

    .line 524
    if-ge v7, v11, :cond_1f

    .line 501
    :goto_12
    add-int/lit8 v8, v14, 0x1

    move v14, v8

    move v11, v7

    goto/16 :goto_d

    .line 497
    :cond_19
    add-int/lit8 v8, v7, -0x1

    const/high16 v14, 0x100000

    aput v14, v24, v8

    goto/16 :goto_c

    .line 526
    :cond_1a
    const/16 v4, 0x30

    move/from16 v0, p2

    if-ge v0, v4, :cond_1b

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    aput-char v22, v4, p2

    .line 527
    :cond_1b
    if-eqz v19, :cond_1c

    move/from16 v0, v16

    if-ne v15, v0, :cond_1c

    aget v4, v24, v16

    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mMaxCost:I

    if-gt v4, v7, :cond_1c

    add-int/lit8 v4, p2, 0x1

    const/16 v7, 0x30

    if-gt v4, v7, :cond_1c

    if-lez v5, :cond_1c

    .line 528
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    add-int/lit8 v7, p2, 0x1

    aget v8, v24, v16

    move-object/from16 v0, p0

    invoke-direct {v0, v4, v7, v5, v8}, Lcom/mrkeyboard/app/MrFuzzy;->offer([CIII)V

    .line 530
    :cond_1c
    if-eqz v18, :cond_1e

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mMaxCost:I

    if-gt v11, v4, :cond_1e

    add-int/lit8 v4, p2, 0x1

    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    add-int v5, v5, v16

    if-ge v4, v5, :cond_1e

    add-int/lit8 v4, p2, 0x2

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    array-length v5, v5

    if-ge v4, v5, :cond_1e

    add-int/lit8 v4, p2, 0x1

    const/16 v5, 0x30

    if-ge v4, v5, :cond_1e

    .line 532
    add-int/lit8 v4, p2, 0x1

    move-object/from16 v0, p0

    move/from16 v1, v18

    move/from16 v2, v17

    move/from16 v3, v22

    invoke-direct {v0, v1, v4, v2, v3}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 533
    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v5, 0x2ee0

    if-gt v4, v5, :cond_0

    .line 535
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v5, v4, p2

    .line 536
    if-lez p2, :cond_1d

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v7, p2, -0x1

    aget-object v4, v4, v7

    goto/16 :goto_6

    :cond_1d
    const/4 v4, 0x0

    goto/16 :goto_6

    :cond_1e
    move-object v4, v12

    move-object v5, v13

    goto/16 :goto_6

    :cond_1f
    move v7, v11

    goto/16 :goto_12

    :cond_20
    move v7, v8

    goto/16 :goto_10

    :cond_21
    move v7, v8

    goto/16 :goto_11

    :cond_22
    move v8, v7

    goto/16 :goto_f

    :cond_23
    move v7, v8

    goto/16 :goto_e

    :cond_24
    move v15, v8

    goto/16 :goto_b

    :cond_25
    move v6, v7

    goto/16 :goto_4
.end method

.method private walkRoot()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 338
    const/4 v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 339
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v2, v2, v2}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 340
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v1, 0x2ee0

    if-le v0, v1, :cond_0

    .line 344
    :goto_0
    return-void

    .line 341
    :cond_0
    const/4 v0, 0x2

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 342
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v2, v2, v2}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 343
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    goto :goto_0
.end method


# virtual methods
.method emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V
    .locals 10

    .prologue
    const/4 v2, 0x0

    .line 656
    move v7, v2

    :goto_0
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v7, v0, :cond_0

    .line 657
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v4, v0, v7

    .line 658
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v1, v0, v7

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aget v3, v0, v7

    const-wide/32 v8, 0xfffffff

    invoke-static {v4, v5, v8, v9}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v4

    long-to-int v4, v4

    const/4 v5, 0x1

    sget-object v6, Lcom/mrkeyboard/app/Dictionary$DataType;->UNIGRAM:Lcom/mrkeyboard/app/Dictionary$DataType;

    move-object v0, p1

    invoke-interface/range {v0 .. v6}, Lcom/mrkeyboard/app/Dictionary$WordCallback;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z

    .line 656
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    .line 661
    :cond_0
    return-void
.end method

.method resultCount()I
    .locals 1

    .prologue
    .line 264
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    return v0
.end method

.method resultScore(I)J
    .locals 2

    .prologue
    .line 266
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v0, v0, p1

    return-wide v0
.end method

.method resultWord(I)Ljava/lang/String;
    .locals 4

    .prologue
    .line 265
    new-instance v0, Ljava/lang/String;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v1, v1, p1

    const/4 v2, 0x0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aget v3, v3, p1

    invoke-direct {v0, v1, v2, v3}, Ljava/lang/String;-><init>([CII)V

    return-object v0
.end method

.method search(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;)V
    .locals 11

    .prologue
    .line 269
    invoke-interface {p2}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/16 v1, 0x14

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 270
    iput v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    .line 271
    const/4 v0, 0x0

    move v4, v0

    :goto_0
    if-ge v4, v5, :cond_4

    .line 272
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    invoke-interface {p2, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    aput-char v1, v0, v4

    .line 273
    const/4 v1, 0x0

    .line 274
    if-eqz p1, :cond_1

    invoke-virtual {p1, v4}, Lcom/mrkeyboard/app/WordComposer;->getCodesAt(I)[I

    move-result-object v0

    move-object v3, v0

    .line 275
    :goto_1
    if-eqz v3, :cond_0

    .line 276
    const/4 v0, 0x1

    :goto_2
    array-length v2, v3

    if-ge v0, v2, :cond_0

    const/16 v2, 0x10

    if-ge v1, v2, :cond_0

    .line 277
    aget v2, v3, v0

    .line 278
    if-gtz v2, :cond_2

    .line 283
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aput v1, v0, v4

    .line 284
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v0, v0, v4

    const/4 v1, -0x1

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([SS)V

    .line 271
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_0

    .line 274
    :cond_1
    const/4 v0, 0x0

    move-object v3, v0

    goto :goto_1

    .line 279
    :cond_2
    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v6

    .line 280
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v2, v2, v4

    if-eq v6, v2, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v7, v2, v4

    add-int/lit8 v2, v1, 0x1

    aput-char v6, v7, v1

    move v1, v2

    .line 276
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 286
    :cond_4
    invoke-static {}, Lcom/mrkeyboard/app/MrRules;->get()Lcom/mrkeyboard/app/MrRules;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 287
    const/4 v0, 0x0

    :goto_3
    if-ge v0, v5, :cond_5

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->insCost(I)I

    move-result v2

    aput v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 288
    :cond_5
    const/4 v0, 0x2

    move v3, v0

    :goto_4
    if-gt v3, v5, :cond_9

    .line 289
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v1, v3, -0x2

    aget-char v4, v0, v1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v1, v3, -0x1

    aget-char v6, v0, v1

    .line 290
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 291
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v7, v0, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v8, v0, Lcom/mrkeyboard/app/MrRules;->t2b:[C

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v9, v0, Lcom/mrkeyboard/app/MrRules;->t2d:[C

    .line 292
    const/4 v0, 0x0

    :goto_5
    array-length v10, v7

    if-ge v0, v10, :cond_8

    .line 293
    aget-char v10, v7, v0

    if-ne v10, v4, :cond_6

    aget-char v10, v8, v0

    if-ne v10, v6, :cond_6

    .line 294
    if-nez v2, :cond_7

    aget-char v2, v9, v0

    .line 292
    :cond_6
    :goto_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_5

    .line 295
    :cond_7
    if-nez v1, :cond_6

    aget-char v1, v9, v0

    goto :goto_6

    .line 298
    :cond_8
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD1:[C

    aput-char v2, v0, v3

    .line 299
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD2:[C

    aput-char v1, v0, v3

    .line 288
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_4

    .line 301
    :cond_9
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->firstLetters()V

    .line 302
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 303
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    .line 304
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    const/4 v1, 0x0

    aget-object v1, v0, v1

    .line 305
    const/4 v0, 0x0

    const/4 v2, 0x0

    aput v2, v1, v0

    .line 306
    const/4 v0, 0x1

    :goto_7
    if-gt v0, v5, :cond_a

    const/high16 v2, 0x100000

    add-int/lit8 v3, v0, -0x1

    aget v3, v1, v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    add-int/lit8 v6, v0, -0x1

    aget v4, v4, v6

    add-int/2addr v3, v4

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    aput v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_7

    .line 312
    :cond_a
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->isPrefix()Z

    move-result v1

    .line 313
    if-eqz v1, :cond_b

    const/4 v0, 0x4

    if-lt v5, v0, :cond_c

    .line 314
    :cond_b
    if-eqz v1, :cond_e

    const/4 v0, 0x4

    if-ne v5, v0, :cond_e

    const/16 v0, 0x28

    :goto_8
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 315
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->walkRoot()V

    .line 316
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-nez v0, :cond_c

    if-nez v1, :cond_c

    const/4 v0, 0x6

    if-lt v5, v0, :cond_c

    .line 318
    const/4 v0, 0x7

    if-gt v5, v0, :cond_11

    const/16 v0, 0x64

    :goto_9
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 319
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->walkRoot()V

    .line 322
    :cond_c
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    sput v0, Lcom/mrkeyboard/app/MrFuzzy;->sLastVisits:I

    .line 323
    const/4 v0, 0x4

    if-lt v5, v0, :cond_d

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->split()V

    .line 324
    :cond_d
    return-void

    .line 314
    :cond_e
    const/4 v0, 0x3

    if-gt v5, v0, :cond_f

    const/16 v0, 0x2d

    goto :goto_8

    :cond_f
    const/4 v0, 0x4

    if-ne v5, v0, :cond_10

    const/16 v0, 0x3c

    goto :goto_8

    :cond_10
    const/16 v0, 0x4b

    goto :goto_8

    .line 318
    :cond_11
    const/16 v0, 0x78

    goto :goto_9
.end method
