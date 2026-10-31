.class public final Lcom/mrkeyboard/app/MrFuzzy;
.super Ljava/lang/Object;
.source "MrFuzzy.java"


# static fields
.field private static final BASE:[C

.field static final C_DEL:I = 0x28

.field static final C_DEL_DOUBLE:I = 0x1e

.field static final C_DEL_FIRST:I = 0x1e

.field static final C_INS:I = 0x3c

.field static final C_INS_DOUBLE:I = 0x1e

.field static final C_INS_H:I = 0x28

.field static final C_INS_NEAR:I = 0x2d

.field static final C_MULTI:I = 0x23

.field static final C_PHON:I = 0x19

.field static final C_PROX:I = 0x19

.field static final C_PROX_1:I = 0x19

.field static final C_PROX_2:I = 0x1e

.field static final C_PROX_FAR:I = 0x23

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

.field private static final sTouchCount:[I

.field private static final sTouchNear:[[C

.field private static sTouchTyped:Ljava/lang/String;


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
    .locals 5

    .prologue
    const/16 v4, 0x14

    const/16 v3, 0x100

    .line 61
    new-array v0, v3, [C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    .line 62
    new-array v0, v3, [C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    .line 65
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v3, :cond_0

    .line 66
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    aput-char v2, v1, v0

    .line 67
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    int-to-char v2, v0

    invoke-static {v2}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v2

    aput-char v2, v1, v0

    .line 65
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 114
    :cond_0
    const/16 v0, 0xc

    filled-new-array {v4, v0}, [I

    move-result-object v0

    sget-object v1, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v1, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    .line 115
    new-array v0, v4, [I

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchCount:[I

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

    .line 119
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 82
    new-array v0, v4, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    .line 83
    const/16 v0, 0x10

    filled-new-array {v4, v0}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    .line 84
    new-array v0, v4, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    .line 85
    const/16 v0, 0x100

    filled-new-array {v4, v0}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Short;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[S

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    .line 86
    new-array v0, v4, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    .line 87
    const/16 v0, 0x100

    new-array v0, v0, [Z

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    .line 89
    new-array v0, v6, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD1:[C

    .line 90
    new-array v0, v6, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD2:[C

    .line 92
    sget-object v0, Lcom/mrkeyboard/app/MrRules;->EMPTY:Lcom/mrkeyboard/app/MrRules;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 93
    const/16 v0, 0x19

    filled-new-array {v0, v6}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    .line 94
    const/16 v0, 0x32

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    .line 103
    const/16 v0, 0x62

    filled-new-array {v5, v0}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    .line 104
    new-array v0, v5, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    .line 105
    new-array v0, v5, [J

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    .line 106
    new-array v0, v5, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    .line 800
    const/16 v0, 0x62

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    .line 801
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    .line 802
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    .line 803
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    .line 120
    iput-object p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    .line 121
    iput p2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    .line 123
    const/4 v0, 0x2

    if-le p2, v0, :cond_3

    .line 124
    invoke-virtual {p1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 125
    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 126
    const/16 v4, 0xc8

    if-lt v0, v4, :cond_2

    if-eqz v3, :cond_0

    if-ne v3, v1, :cond_2

    :cond_0
    move v0, v1

    .line 128
    :goto_0
    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    .line 129
    if-eqz v0, :cond_1

    const/4 v2, 0x2

    :cond_1
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    .line 130
    return-void

    :cond_2
    move v0, v2

    .line 126
    goto :goto_0

    :cond_3
    move v0, v2

    goto :goto_0
.end method

.method public static afterWords(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 150
    const/4 v1, 0x0

    :try_start_0
    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 151
    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 152
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 182
    :cond_0
    :goto_0
    return-void

    .line 153
    :cond_1
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->size()I

    move-result v1

    .line 154
    const/4 v2, 0x2

    if-lt v1, v2, :cond_0

    const/16 v2, 0x14

    if-gt v1, v2, :cond_0

    .line 156
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrRecent;->complete(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V

    .line 157
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->getTypedWord()Ljava/lang/CharSequence;

    move-result-object v2

    .line 158
    if-eqz v2, :cond_0

    .line 159
    invoke-static {p1, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->rememberTouches(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V

    .line 160
    invoke-static {v2}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    .line 161
    if-eqz v3, :cond_2

    .line 162
    invoke-virtual {v3}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 163
    const/4 v2, 0x0

    array-length v3, v1

    const v4, 0x1fffffff

    const/4 v5, 0x1

    sget-object v6, Lcom/mrkeyboard/app/Dictionary$DataType;->UNIGRAM:Lcom/mrkeyboard/app/Dictionary$DataType;

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/Suggest;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z

    goto :goto_0

    .line 179
    :catch_0
    move-exception v0

    goto :goto_0

    .line 166
    :cond_2
    const/4 v3, 0x3

    if-lt v1, v3, :cond_0

    .line 167
    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/Suggest;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 168
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v1

    .line 169
    if-eqz v1, :cond_0

    .line 170
    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrLength()I

    move-result v1

    invoke-static {v3, v1}, Lcom/mrkeyboard/app/MrFuzzy;->forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;

    move-result-object v1

    .line 171
    if-eqz v1, :cond_0

    .line 172
    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 173
    :try_start_1
    invoke-virtual {v1, p1, v2}, Lcom/mrkeyboard/app/MrFuzzy;->search(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;)V

    .line 174
    invoke-virtual {v1, p0}, Lcom/mrkeyboard/app/MrFuzzy;->emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V

    .line 175
    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 176
    iget v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-lez v2, :cond_3

    iget-object v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    const/4 v3, 0x0

    aget v2, v2, v3

    const/16 v3, 0x2d

    if-gt v2, v3, :cond_3

    .line 177
    const/4 v0, 0x0

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->resultWord(I)Ljava/lang/String;

    move-result-object v0

    :cond_3
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 178
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
    .line 338
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    new-array v1, v0, [C

    .line 339
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

    .line 340
    :cond_0
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/String;-><init>([C)V

    return-object v0
.end method

.method static confident(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 9

    .prologue
    const/4 v1, 0x1

    const/4 v3, 0x0

    .line 314
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 315
    if-eqz v0, :cond_1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 334
    :cond_0
    :goto_0
    return v1

    .line 316
    :cond_1
    const/16 v0, 0x20

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_2

    move v1, v3

    goto :goto_0

    .line 317
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-static {p1}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 318
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v2, 0x5

    if-gt v0, v2, :cond_4

    move v0, v1

    .line 319
    :goto_1
    invoke-static {v5, v6, v0}, Lcom/mrkeyboard/app/MrFuzzy;->distance(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v2

    if-le v2, v0, :cond_0

    .line 323
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v4

    if-ne v2, v4, :cond_9

    sget-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_9

    .line 324
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_9

    :cond_3
    move v2, v3

    move v4, v3

    .line 326
    :goto_2
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v7

    if-ge v2, v7, :cond_8

    .line 327
    invoke-virtual {v5, v2}, Ljava/lang/String;->charAt(I)C

    move-result v7

    invoke-virtual {v6, v2}, Ljava/lang/String;->charAt(I)C

    move-result v8

    if-ne v7, v8, :cond_5

    .line 326
    :goto_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 318
    :cond_4
    const/4 v0, 0x2

    goto :goto_1

    .line 328
    :cond_5
    invoke-virtual {v6, v2}, Ljava/lang/String;->charAt(I)C

    move-result v7

    invoke-static {v2, v7}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v7

    .line 329
    if-ltz v7, :cond_6

    if-le v7, v1, :cond_7

    :cond_6
    move v1, v3

    goto :goto_0

    .line 330
    :cond_7
    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    .line 332
    :cond_8
    mul-int/lit8 v0, v0, 0x2

    if-le v4, v0, :cond_0

    move v1, v3

    goto :goto_0

    :cond_9
    move v1, v3

    .line 334
    goto :goto_0
.end method

.method private delCost(III)I
    .locals 6

    .prologue
    const/4 v0, 0x0

    const/16 v5, 0x100

    const/16 v1, 0x1e

    .line 716
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 717
    if-nez p3, :cond_2

    iget v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v4, 0x3

    if-ne v3, v4, :cond_2

    .line 718
    if-ge p1, v5, :cond_0

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v0, v0, p1

    .line 719
    :cond_0
    if-lez v0, :cond_1

    if-ge v0, v1, :cond_1

    .line 728
    :goto_0
    return v0

    :cond_1
    move v0, v1

    .line 719
    goto :goto_0

    .line 721
    :cond_2
    if-nez p3, :cond_3

    if-ge p1, v5, :cond_3

    iget-object v3, v2, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v3, v3, p1

    if-lez v3, :cond_3

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v0, v0, p1

    goto :goto_0

    .line 722
    :cond_3
    if-lez p3, :cond_4

    if-ne p1, p2, :cond_4

    move v0, v1

    goto :goto_0

    .line 723
    :cond_4
    iget-object v1, v2, Lcom/mrkeyboard/app/MrRules;->silPrev:[C

    iget-object v3, v2, Lcom/mrkeyboard/app/MrRules;->silChar:[C

    .line 724
    :goto_1
    array-length v4, v1

    if-ge v0, v4, :cond_6

    .line 725
    aget-char v4, v3, v0

    if-ne v4, p1, :cond_5

    aget-char v4, v1, v0

    if-ne v4, p2, :cond_5

    iget-object v1, v2, Lcom/mrkeyboard/app/MrRules;->silCost:[S

    aget-short v0, v1, v0

    goto :goto_0

    .line 724
    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 727
    :cond_6
    if-lez p3, :cond_7

    if-ge p1, v5, :cond_7

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentAny:[S

    aget-short v0, v0, p1

    if-lez v0, :cond_7

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentAny:[S

    aget-short v0, v0, p1

    goto :goto_0

    .line 728
    :cond_7
    const/16 v0, 0x28

    goto :goto_0
.end method

.method static demoteCaseVariant(Ljava/util/List;Ljava/lang/String;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/CharSequence;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    const/4 v3, 0x2

    const/4 v2, 0x1

    .line 277
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 282
    :cond_0
    :goto_0
    return-void

    .line 278
    :cond_1
    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrFuzzy;->isCaseVariant(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 279
    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 280
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 281
    if-ltz v1, :cond_0

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v0

    if-ltz v0, :cond_0

    invoke-interface {p0, v3}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {p0, v2, v0}, Ljava/util/List;->add(ILjava/lang/Object;)V

    goto :goto_0
.end method

.method static distance(Ljava/lang/String;Ljava/lang/String;I)I
    .locals 12

    .prologue
    .line 345
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v7

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v8

    .line 346
    sub-int v0, v7, v8

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    if-le v0, p2, :cond_0

    add-int/lit8 v0, p2, 0x1

    .line 364
    :goto_0
    return v0

    .line 347
    :cond_0
    add-int/lit8 v0, v8, 0x1

    new-array v5, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v4, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v1, v0, [I

    .line 348
    const/4 v0, 0x0

    :goto_1
    if-gt v0, v8, :cond_1

    aput v0, v4, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 349
    :cond_1
    const/4 v0, 0x1

    move v3, v0

    move-object v6, v4

    move-object v4, v1

    :goto_2
    if-gt v3, v7, :cond_6

    .line 350
    const/4 v0, 0x0

    aput v3, v4, v0

    .line 351
    const/4 v0, 0x0

    aget v1, v4, v0

    .line 352
    const/4 v0, 0x1

    move v2, v0

    :goto_3
    if-gt v2, v8, :cond_4

    .line 353
    add-int/lit8 v0, v3, -0x1

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    add-int/lit8 v9, v2, -0x1

    invoke-virtual {p1, v9}, Ljava/lang/String;->charAt(I)C

    move-result v9

    if-ne v0, v9, :cond_3

    const/4 v0, 0x0

    .line 354
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

    .line 355
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

    .line 356
    add-int/lit8 v9, v2, -0x2

    aget v9, v5, v9

    add-int/lit8 v9, v9, 0x1

    invoke-static {v0, v9}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 358
    :cond_2
    aput v0, v4, v2

    .line 359
    if-ge v0, v1, :cond_7

    .line 352
    :goto_5
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    move v1, v0

    goto :goto_3

    .line 353
    :cond_3
    const/4 v0, 0x1

    goto :goto_4

    .line 361
    :cond_4
    if-le v1, p2, :cond_5

    add-int/lit8 v0, p2, 0x1

    goto/16 :goto_0

    .line 349
    :cond_5
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    move-object v11, v5

    move-object v5, v6

    move-object v6, v4

    move-object v4, v11

    goto :goto_2

    .line 364
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

    .line 216
    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 217
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 218
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 219
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 221
    if-eqz p0, :cond_0

    :try_start_0
    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 265
    :cond_0
    :goto_0
    return p1

    .line 222
    :cond_1
    const/4 v0, 0x0

    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v5

    .line 223
    if-eqz v1, :cond_5

    invoke-virtual {v5, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_5

    .line 225
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

    .line 226
    invoke-virtual {v1}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    .line 230
    :cond_2
    :goto_1
    const/4 v4, -0x1

    move v3, v2

    .line 231
    :goto_2
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v3, v0, :cond_c

    .line 232
    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_8

    move v0, v3

    .line 234
    :goto_3
    if-ltz v0, :cond_3

    if-le v0, v6, :cond_5

    .line 235
    :cond_3
    if-le v0, v6, :cond_4

    invoke-interface {p0, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 236
    :cond_4
    const/4 v0, 0x2

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v3

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-interface {p0, v0, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 241
    :cond_5
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    if-ne v0, v2, :cond_b

    .line 242
    invoke-static {v5}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 243
    if-eqz v0, :cond_b

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_b

    .line 244
    const/4 v1, 0x0

    invoke-virtual {v5, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v1

    if-eqz v1, :cond_9

    .line 245
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

    .line 246
    :goto_4
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v0

    :goto_5
    if-lt v1, v2, :cond_a

    .line 247
    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-interface {p0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 246
    :cond_6
    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_5

    .line 227
    :cond_7
    const/4 v0, 0x0

    invoke-virtual {v5, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 228
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

    .line 231
    :cond_8
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_2

    :cond_9
    move-object v3, v0

    .line 245
    goto :goto_4

    .line 249
    :cond_a
    const/4 v0, 0x1

    invoke-interface {p0, v0, v3}, Ljava/util/List;->add(ILjava/lang/Object;)V

    move p1, v2

    .line 250
    goto/16 :goto_0

    .line 255
    :cond_b
    invoke-static {p0, v5}, Lcom/mrkeyboard/app/MrFuzzy;->demoteCaseVariant(Ljava/util/List;Ljava/lang/String;)V

    .line 258
    invoke-static {p0, v5}, Lcom/mrkeyboard/app/MrFuzzy;->touchOrder(Ljava/util/List;Ljava/lang/String;)V

    .line 259
    if-eqz p1, :cond_0

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v0, v6, :cond_0

    .line 260
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

    .line 262
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

    .line 504
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([ZZ)V

    .line 505
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v3, v0, v2

    .line 506
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    and-int/lit16 v5, v3, 0xff

    if-ge v3, v7, :cond_1

    move v0, v1

    :goto_0
    aput-boolean v0, v4, v5

    move v0, v2

    .line 507
    :goto_1
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v4, v4, v2

    if-ge v0, v4, :cond_2

    .line 508
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v4, v4, v2

    aget-char v4, v4, v0

    .line 509
    if-ge v4, v7, :cond_0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v4

    .line 507
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    move v0, v2

    .line 506
    goto :goto_0

    .line 511
    :cond_2
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    move v0, v2

    .line 512
    :goto_2
    if-ge v0, v7, :cond_5

    .line 514
    invoke-virtual {v4, v0, v3}, Lcom/mrkeyboard/app/MrRules;->pair(CC)I

    move-result v5

    if-nez v5, :cond_3

    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v5, v5, v0

    if-lez v5, :cond_4

    :cond_3
    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v0

    .line 512
    :cond_4
    add-int/lit8 v0, v0, 0x1

    int-to-char v0, v0

    goto :goto_2

    .line 517
    :cond_5
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-le v0, v1, :cond_7

    move v0, v2

    .line 518
    :goto_3
    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    array-length v5, v5

    if-ge v0, v5, :cond_7

    .line 519
    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    aget-char v5, v5, v0

    if-ne v5, v3, :cond_6

    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2b:[C

    aget-char v5, v5, v0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v6, v6, v1

    if-ne v5, v6, :cond_6

    .line 520
    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2d:[C

    aget-char v5, v5, v0

    invoke-static {v5}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v5

    .line 521
    if-ge v5, v7, :cond_6

    iget-object v6, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v6, v5

    .line 518
    :cond_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 525
    :cond_7
    :goto_4
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    array-length v0, v0

    if-ge v2, v0, :cond_9

    .line 526
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    aget-char v0, v0, v2

    if-ne v0, v3, :cond_8

    .line 527
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    aget-char v0, v0, v2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v0

    .line 528
    if-ge v0, v7, :cond_8

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v0

    .line 525
    :cond_8
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    .line 531
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

    .line 532
    :cond_a
    return-void
.end method

.method static declared-synchronized forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;
    .locals 3

    .prologue
    .line 133
    const-class v1, Lcom/mrkeyboard/app/MrFuzzy;

    monitor-enter v1

    if-eqz p0, :cond_0

    const/4 v0, 0x2

    if-gt p1, v0, :cond_2

    :cond_0
    const/4 v0, 0x0

    .line 139
    :cond_1
    :goto_0
    monitor-exit v1

    return-object v0

    .line 134
    :cond_2
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;

    .line 135
    if-eqz v0, :cond_3

    iget-object v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    if-ne v2, p0, :cond_3

    iget v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-eq v2, p1, :cond_1

    .line 136
    :cond_3
    new-instance v0, Lcom/mrkeyboard/app/MrFuzzy;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrFuzzy;-><init>(Ljava/nio/ByteBuffer;I)V

    .line 137
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 133
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private insCost(I)I
    .locals 4

    .prologue
    const/16 v0, 0x2d

    .line 706
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v1, v1, p1

    .line 707
    if-lez p1, :cond_1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v3, p1, -0x1

    aget-char v2, v2, v3

    if-ne v2, v1, :cond_1

    const/16 v0, 0x1e

    .line 711
    :cond_0
    :goto_0
    return v0

    .line 708
    :cond_1
    const/16 v2, 0x100

    if-ge v1, v2, :cond_2

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v2, v2, Lcom/mrkeyboard/app/MrRules;->extra:[Z

    aget-boolean v2, v2, v1

    if-eqz v2, :cond_2

    const/16 v0, 0x28

    goto :goto_0

    .line 709
    :cond_2
    if-lez p1, :cond_3

    add-int/lit8 v2, p1, -0x1

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v2

    if-nez v2, :cond_0

    .line 710
    :cond_3
    add-int/lit8 v2, p1, 0x1

    iget v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-ge v2, v3, :cond_4

    add-int/lit8 v2, p1, 0x1

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v1

    if-nez v1, :cond_0

    .line 711
    :cond_4
    const/16 v0, 0x3c

    goto :goto_0
.end method

.method private insert([CIIJI)V
    .locals 8

    .prologue
    const/4 v7, 0x5

    const/4 v1, 0x0

    .line 747
    move v0, v1

    :goto_0
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v0, v2, :cond_2

    .line 748
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aget v2, v2, v0

    if-ne v2, p3, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v2, v2, v0

    invoke-static {v2, p1, p2, p3}, Lcom/mrkeyboard/app/MrFuzzy;->same([C[CII)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 749
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v2, v2, v0

    cmp-long v2, p4, v2

    if-gtz v2, :cond_1

    .line 771
    :cond_0
    :goto_1
    return-void

    .line 750
    :cond_1
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->remove(I)V

    .line 754
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    move v2, v0

    .line 755
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

    .line 747
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 756
    :cond_4
    if-ge v2, v7, :cond_0

    .line 757
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    const/4 v3, 0x4

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 758
    :goto_3
    if-le v0, v2, :cond_5

    .line 759
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v3, v3, v0

    .line 760
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v6, v0, -0x1

    aget-object v5, v5, v6

    aput-object v5, v4, v0

    .line 761
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v5, v0, -0x1

    aput-object v3, v4, v5

    .line 762
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    add-int/lit8 v5, v0, -0x1

    aget v4, v4, v5

    aput v4, v3, v0

    .line 763
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    add-int/lit8 v5, v0, -0x1

    aget-wide v4, v4, v5

    aput-wide v4, v3, v0

    .line 764
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    add-int/lit8 v5, v0, -0x1

    aget v4, v4, v5

    aput v4, v3, v0

    .line 758
    add-int/lit8 v0, v0, -0x1

    goto :goto_3

    .line 766
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v0, v0, v2

    invoke-static {p1, p2, v0, v1, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 767
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aput p3, v0, v2

    .line 768
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aput-wide p4, v0, v2

    .line 769
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    aput p6, v0, v2

    .line 770
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v0, v7, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    goto :goto_1
.end method

.method static isCaseVariant(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 270
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    if-ne v1, v2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 273
    :cond_0
    :goto_0
    return v0

    .line 271
    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 272
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 273
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_0
.end method

.method private isNear(IC)Z
    .locals 3

    .prologue
    .line 676
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v1, v0, p1

    .line 677
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v0, v0, p1

    add-int/lit8 v0, v0, -0x1

    :goto_0
    if-ltz v0, :cond_1

    .line 678
    aget-char v2, v1, v0

    if-ne v2, p2, :cond_0

    const/4 v0, 0x1

    .line 680
    :goto_1
    return v0

    .line 677
    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 680
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private isPrefix()Z
    .locals 2

    .prologue
    .line 461
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

    .line 837
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 838
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 839
    sub-int v1, p2, p1

    const/16 v2, 0x30

    if-le v1, v2, :cond_0

    .line 841
    :goto_0
    return v0

    .line 840
    :cond_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v1, p1, p2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->lookupRec(IIII)V

    .line 841
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    goto :goto_0
.end method

.method private lookupRec(IIII)V
    .locals 10

    .prologue
    const/4 v3, 0x0

    .line 845
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 887
    :cond_0
    return-void

    .line 846
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v8, v0, 0xff

    .line 847
    add-int/lit8 v4, p1, 0x1

    .line 848
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v9, v0, p2

    move v7, v3

    .line 849
    :goto_0
    if-ge v7, v8, :cond_0

    .line 850
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v0, :cond_0

    .line 851
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v4, 0x1

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 852
    const/16 v2, 0xff

    if-ne v0, v2, :cond_2

    .line 853
    add-int/lit8 v0, v1, 0x1

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v0, v2, :cond_0

    .line 854
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

    .line 855
    add-int/lit8 v1, v1, 0x2

    .line 857
    :cond_2
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v2, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v4, v2, 0xff

    .line 858
    and-int/lit16 v2, v4, 0x80

    if-eqz v2, :cond_4

    const/4 v2, 0x1

    move v6, v2

    .line 860
    :goto_1
    and-int/lit8 v2, v4, 0x40

    if-eqz v2, :cond_5

    .line 861
    add-int/lit8 v2, v1, 0x2

    iget v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v2, v5, :cond_0

    .line 862
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

    .line 863
    add-int/lit8 v1, v1, 0x3

    move v5, v2

    .line 868
    :goto_2
    if-eqz v6, :cond_a

    .line 869
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    .line 870
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v1, 0x1

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 871
    iget-boolean v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v4, :cond_9

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v2

    move v4, v2

    move v2, v1

    .line 873
    :goto_3
    const/16 v1, 0x100

    if-ge v0, v1, :cond_6

    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v1, v1, v0

    .line 874
    :goto_4
    if-eq v1, v9, :cond_7

    .line 849
    :cond_3
    :goto_5
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto/16 :goto_0

    :cond_4
    move v6, v3

    .line 858
    goto :goto_1

    .line 865
    :cond_5
    add-int/lit8 v1, v1, 0x1

    move v5, v3

    goto :goto_2

    .line 873
    :cond_6
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    goto :goto_4

    .line 875
    :cond_7
    int-to-char v0, v0

    .line 876
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aput-char v0, v1, p4

    .line 877
    add-int/lit8 v0, p2, 0x1

    if-ne v0, p3, :cond_8

    .line 878
    if-eqz v6, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    if-le v2, v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aget-char v0, v0, v3

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-nez v0, :cond_3

    .line 879
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 880
    add-int/lit8 v0, p4, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 881
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    add-int/lit8 v2, p4, 0x1

    invoke-static {v0, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_5

    .line 883
    :cond_8
    if-eqz v5, :cond_3

    .line 884
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

.method private nearRank(IC)I
    .locals 4

    .prologue
    .line 685
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v1, v0, p1

    .line 686
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v2, v0, p1

    .line 687
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v2, :cond_1

    .line 688
    aget-char v3, v1, v0

    if-ne v3, p2, :cond_0

    .line 690
    :goto_1
    return v0

    .line 687
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 690
    :cond_1
    const/4 v0, -0x1

    goto :goto_1
.end method

.method private offer([CIII)V
    .locals 7

    .prologue
    .line 740
    invoke-direct {p0, p3, p4}, Lcom/mrkeyboard/app/MrFuzzy;->scoreFor(II)J

    move-result-wide v4

    .line 741
    const-wide/16 v0, 0x0

    cmp-long v0, v4, v0

    if-gtz v0, :cond_0

    .line 743
    :goto_0
    return-void

    .line 742
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
    .line 832
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

.method private static oneSubAt(Ljava/lang/String;Ljava/lang/String;)I
    .locals 5

    .prologue
    const/4 v2, -0x1

    .line 286
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 294
    :cond_0
    :goto_0
    return v2

    .line 288
    :cond_1
    const/4 v0, 0x0

    move v1, v2

    :goto_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v0, v3, :cond_3

    .line 289
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v3

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v4

    if-eq v3, v4, :cond_2

    .line 290
    if-gez v1, :cond_0

    move v1, v0

    .line 288
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    move v2, v1

    .line 294
    goto :goto_0
.end method

.method private prefixRec(II)Z
    .locals 11

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 465
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    :cond_0
    move v0, v2

    .line 499
    :goto_0
    return v0

    .line 466
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v6, v0, 0xff

    .line 467
    add-int/lit8 v1, p1, 0x1

    .line 468
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v7, v0, p2

    move v5, v2

    move v0, v1

    .line 469
    :goto_1
    if-ge v5, v6, :cond_d

    .line 470
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v0, v1, :cond_2

    move v0, v2

    goto :goto_0

    .line 471
    :cond_2
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v0, 0x1

    invoke-virtual {v4, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 472
    const/16 v4, 0xff

    if-ne v0, v4, :cond_4

    .line 473
    add-int/lit8 v0, v1, 0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v0, v4, :cond_3

    move v0, v2

    goto :goto_0

    .line 474
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

    .line 475
    add-int/lit8 v1, v1, 0x2

    .line 477
    :cond_4
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v8, v4, 0xff

    .line 479
    and-int/lit8 v4, v8, 0x40

    if-eqz v4, :cond_6

    .line 480
    add-int/lit8 v4, v1, 0x2

    iget v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v4, v9, :cond_5

    move v0, v2

    goto :goto_0

    .line 481
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

    .line 482
    add-int/lit8 v1, v1, 0x3

    .line 486
    :goto_2
    and-int/lit16 v8, v8, 0x80

    if-eqz v8, :cond_8

    .line 487
    iget v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v1, v8, :cond_7

    move v0, v2

    goto/16 :goto_0

    .line 484
    :cond_6
    add-int/lit8 v1, v1, 0x1

    move v4, v2

    goto :goto_2

    .line 488
    :cond_7
    add-int/lit8 v1, v1, 0x1

    .line 489
    iget-boolean v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v8, :cond_8

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v1

    .line 491
    :cond_8
    const/16 v8, 0x100

    if-ge v0, v8, :cond_a

    sget-object v8, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v0, v8, v0

    .line 492
    :goto_3
    if-eq v0, v7, :cond_b

    .line 469
    :cond_9
    add-int/lit8 v0, v5, 0x1

    move v5, v0

    move v0, v1

    goto/16 :goto_1

    .line 491
    :cond_a
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v0

    goto :goto_3

    .line 493
    :cond_b
    add-int/lit8 v0, p2, 0x1

    iget v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-ne v0, v8, :cond_c

    .line 494
    if-eqz v4, :cond_9

    move v0, v3

    goto/16 :goto_0

    .line 495
    :cond_c
    if-eqz v4, :cond_9

    add-int/lit8 v0, p2, 0x1

    invoke-direct {p0, v4, v0}, Lcom/mrkeyboard/app/MrFuzzy;->prefixRec(II)Z

    move-result v0

    if-eqz v0, :cond_9

    move v0, v3

    .line 496
    goto/16 :goto_0

    :cond_d
    move v0, v2

    .line 499
    goto/16 :goto_0
.end method

.method private static rememberTouches(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V
    .locals 9

    .prologue
    const/4 v2, 0x0

    .line 186
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    move v4, v2

    .line 187
    :goto_0
    if-ge v4, p2, :cond_3

    .line 188
    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/WordComposer;->getCodesAt(I)[I

    move-result-object v5

    .line 190
    if-eqz v5, :cond_4

    .line 191
    invoke-interface {p1, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v6

    .line 192
    const/4 v0, 0x1

    move v1, v2

    :goto_1
    array-length v3, v5

    if-ge v0, v3, :cond_0

    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    aget-object v3, v3, v4

    array-length v3, v3

    if-ge v1, v3, :cond_0

    .line 193
    aget v3, v5, v0

    if-gtz v3, :cond_1

    .line 198
    :cond_0
    :goto_2
    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchCount:[I

    aput v1, v0, v4

    .line 187
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_0

    .line 194
    :cond_1
    aget v3, v5, v0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    .line 195
    if-eq v7, v6, :cond_2

    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    aget-object v8, v3, v4

    add-int/lit8 v3, v1, 0x1

    aput-char v7, v8, v1

    move v1, v3

    .line 192
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 200
    :cond_3
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    .line 201
    return-void

    :cond_4
    move v1, v2

    goto :goto_2
.end method

.method private remove(I)V
    .locals 4

    .prologue
    .line 774
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v0, v0, p1

    .line 775
    :goto_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v1, v1, -0x1

    if-ge p1, v1, :cond_0

    .line 776
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v3, p1, 0x1

    aget-object v2, v2, v3

    aput-object v2, v1, p1

    .line 777
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    add-int/lit8 v3, p1, 0x1

    aget v2, v2, v3

    aput v2, v1, p1

    .line 778
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    add-int/lit8 v3, p1, 0x1

    aget-wide v2, v2, v3

    aput-wide v2, v1, p1

    .line 779
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    add-int/lit8 v3, p1, 0x1

    aget v2, v2, v3

    aput v2, v1, p1

    .line 775
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 781
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v2, v2, -0x1

    aput-object v0, v1, v2

    .line 782
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 783
    return-void
.end method

.method private static same([C[CII)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 786
    move v1, v0

    :goto_0
    if-ge v1, p3, :cond_1

    aget-char v2, p0, v1

    add-int v3, p2, v1

    aget-char v3, p1, v3

    if-eq v2, v3, :cond_0

    .line 787
    :goto_1
    return v0

    .line 786
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 787
    :cond_1
    const/4 v0, 0x1

    goto :goto_1
.end method

.method private scoreFor(II)J
    .locals 10

    .prologue
    const-wide v0, 0x41affffffe000000L    # 2.68435455E8

    .line 732
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    const/16 v3, 0x18

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 733
    int-to-double v4, p1

    const-wide/16 v6, 0x1

    add-int/lit8 v2, v2, 0x1

    shl-long v2, v6, v2

    long-to-double v2, v2

    mul-double/2addr v2, v4

    .line 734
    const-wide/high16 v4, 0x4000000000000000L    # 2.0

    neg-int v6, p2

    int-to-double v6, v6

    const-wide/high16 v8, 0x4039000000000000L    # 25.0

    div-double/2addr v6, v8

    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v4

    mul-double/2addr v2, v4

    .line 735
    cmpl-double v4, v2, v0

    if-lez v4, :cond_0

    .line 736
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
    .line 445
    iput p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mMaxCost:I

    .line 446
    div-int/lit8 v0, p1, 0x1e

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    .line 447
    return-void
.end method

.method private skipBigrams(I)I
    .locals 3

    .prologue
    .line 662
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 672
    :cond_0
    :goto_0
    return p1

    .line 663
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    if-eqz v0, :cond_2

    .line 664
    const/4 v0, 0x0

    .line 665
    :goto_1
    add-int/lit8 v1, p1, 0x3

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    add-int/lit8 v1, v0, 0x1

    const/16 v2, 0x2710

    if-ge v0, v2, :cond_0

    .line 666
    add-int/lit8 v0, p1, 0x3

    .line 667
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 p1, v0, 0x1

    invoke-virtual {v2, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    .line 668
    if-eqz v0, :cond_0

    move v0, v1

    .line 669
    goto :goto_1

    .line 672
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

    .line 808
    iget v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    .line 809
    const-wide/16 v4, 0x0

    move v7, v8

    move v3, v2

    .line 811
    :goto_0
    add-int/lit8 v0, v9, -0x2

    if-gt v7, v0, :cond_2

    .line 812
    if-ne v7, v8, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, v2

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneLetterWord(C)Z

    move-result v0

    if-nez v0, :cond_1

    .line 811
    :cond_0
    :goto_1
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    .line 813
    :cond_1
    invoke-direct {p0, v2, v7}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v0

    .line 814
    if-lez v0, :cond_0

    .line 815
    iget v10, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 816
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    iget-object v11, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    invoke-static {v1, v2, v11, v2, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 817
    invoke-direct {p0, v7, v9}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v1

    .line 818
    if-lez v1, :cond_0

    .line 819
    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->scoreFor(II)J

    move-result-wide v0

    .line 820
    cmp-long v11, v0, v4

    if-lez v11, :cond_0

    .line 822
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    invoke-static {v3, v2, v4, v2, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 823
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    const/16 v4, 0x20

    aput-char v4, v3, v10

    .line 824
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    add-int/lit8 v5, v10, 0x1

    iget v11, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    invoke-static {v3, v2, v4, v5, v11}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 825
    add-int/lit8 v3, v10, 0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    add-int/2addr v3, v4

    move-wide v4, v0

    goto :goto_1

    .line 828
    :cond_2
    if-lez v3, :cond_3

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    move-object v0, p0

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrFuzzy;->insert([CIIJI)V

    .line 829
    :cond_3
    return-void
.end method

.method private sub(II)I
    .locals 2

    .prologue
    .line 535
    const/16 v0, 0x100

    if-lt p2, v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, p1

    if-ne p2, v0, :cond_1

    const/4 v0, 0x0

    .line 541
    :cond_0
    :goto_0
    return v0

    .line 535
    :cond_1
    const/16 v0, 0x4b

    goto :goto_0

    .line 536
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v0, v0, p1

    aget-short v0, v0, p2

    .line 537
    if-gez v0, :cond_0

    .line 538
    int-to-char v0, p2

    invoke-direct {p0, v0, p1}, Lcom/mrkeyboard/app/MrFuzzy;->subCost(CI)I

    move-result v0

    int-to-short v0, v0

    .line 539
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v1, v1, p1

    aput-short v0, v1, p2

    goto :goto_0
.end method

.method private subCost(CI)I
    .locals 4

    .prologue
    const/16 v0, 0x19

    const/4 v3, 0x1

    .line 694
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v1, v1, p2

    .line 695
    if-ne p1, v1, :cond_1

    const/4 v0, 0x0

    .line 701
    :cond_0
    :goto_0
    return v0

    .line 696
    :cond_1
    invoke-direct {p0, p2, p1}, Lcom/mrkeyboard/app/MrFuzzy;->nearRank(IC)I

    move-result v2

    .line 697
    if-ltz v2, :cond_3

    if-eqz v2, :cond_0

    if-ne v2, v3, :cond_2

    const/16 v0, 0x1e

    goto :goto_0

    :cond_2
    const/16 v0, 0x23

    goto :goto_0

    .line 698
    :cond_3
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    invoke-virtual {v2, p1, v1}, Lcom/mrkeyboard/app/MrRules;->pair(CC)I

    move-result v1

    .line 699
    if-eq v1, v3, :cond_0

    .line 700
    const/4 v0, 0x2

    if-ne v1, v0, :cond_4

    const/16 v0, 0x2d

    goto :goto_0

    .line 701
    :cond_4
    const/16 v0, 0x4b

    goto :goto_0
.end method

.method static touchOrder(Ljava/util/List;Ljava/lang/String;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/CharSequence;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    const/4 v5, 0x2

    const/4 v4, 0x1

    .line 305
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 311
    :cond_0
    :goto_0
    return-void

    .line 306
    :cond_1
    invoke-interface {p0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p0, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 307
    invoke-static {p1, v1}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 308
    if-ltz v2, :cond_0

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    if-ne v3, v2, :cond_0

    .line 309
    invoke-virtual {v1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v1

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v0

    .line 310
    if-ltz v0, :cond_0

    if-ltz v1, :cond_2

    if-ge v0, v1, :cond_0

    :cond_2
    invoke-interface {p0, v5}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {p0, v4, v0}, Ljava/util/List;->add(ILjava/lang/Object;)V

    goto :goto_0
.end method

.method private static touchRank(IC)I
    .locals 4

    .prologue
    const/4 v1, -0x1

    .line 298
    const/16 v0, 0x14

    if-lt p0, v0, :cond_1

    move v0, v1

    .line 301
    :cond_0
    :goto_0
    return v0

    .line 299
    :cond_1
    invoke-static {p1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    .line 300
    const/4 v0, 0x0

    :goto_1
    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sTouchCount:[I

    aget v3, v3, p0

    if-ge v0, v3, :cond_2

    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    aget-object v3, v3, p0

    aget-char v3, v3, v0

    if-eq v3, v2, :cond_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_2
    move v0, v1

    .line 301
    goto :goto_0
.end method

.method private walk(IIIC)V
    .locals 29

    .prologue
    .line 545
    if-ltz p1, :cond_0

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    move/from16 v0, p1

    if-lt v0, v4, :cond_1

    .line 659
    :cond_0
    return-void

    .line 546
    :cond_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    move/from16 v0, p1

    invoke-virtual {v4, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v0, v4, 0xff

    move/from16 v22, v0

    .line 547
    add-int/lit8 v6, p1, 0x1

    .line 548
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v14, v4, p2

    .line 549
    if-lez p2, :cond_4

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v5, p2, -0x1

    aget-object v4, v4, v5

    .line 550
    :goto_0
    move-object/from16 v0, p0

    iget v0, v0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move/from16 v17, v0

    .line 551
    const/4 v5, 0x0

    move/from16 v21, v5

    move-object v13, v4

    :goto_1
    move/from16 v0, v21

    move/from16 v1, v22

    if-ge v0, v1, :cond_0

    .line 552
    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v6, v4, :cond_0

    .line 553
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v5, v6, 0x1

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 554
    const/16 v6, 0xff

    if-ne v4, v6, :cond_2

    .line 555
    add-int/lit8 v4, v5, 0x1

    move-object/from16 v0, p0

    iget v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v6, :cond_0

    .line 556
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

    .line 557
    add-int/lit8 v5, v5, 0x2

    .line 559
    :cond_2
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v6, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    and-int/lit16 v7, v6, 0xff

    .line 560
    and-int/lit16 v6, v7, 0x80

    if-eqz v6, :cond_5

    const/4 v6, 0x1

    move/from16 v20, v6

    .line 561
    :goto_2
    const/4 v6, 0x0

    .line 562
    and-int/lit8 v8, v7, 0x40

    if-eqz v8, :cond_6

    .line 563
    add-int/lit8 v6, v5, 0x2

    move-object/from16 v0, p0

    iget v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v6, v8, :cond_0

    .line 564
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

    .line 565
    add-int/lit8 v7, v5, 0x3

    move/from16 v19, v6

    .line 569
    :goto_3
    const/4 v5, 0x0

    .line 570
    if-eqz v20, :cond_29

    .line 571
    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v7, v5, :cond_0

    .line 572
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v6, v7, 0x1

    invoke-virtual {v5, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 573
    move-object/from16 v0, p0

    iget-boolean v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v7, :cond_3

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v6

    .line 575
    :cond_3
    :goto_4
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    add-int/lit8 v7, v7, 0x1

    move-object/from16 v0, p0

    iput v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v8, 0x2ee0

    if-gt v7, v8, :cond_0

    .line 576
    const/16 v7, 0x100

    if-ge v4, v7, :cond_7

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v7, v7, v4

    move/from16 v18, v7

    .line 577
    :goto_5
    if-nez p2, :cond_c

    .line 578
    const/16 v7, 0x100

    move/from16 v0, v18

    if-lt v0, v7, :cond_8

    move-object v4, v13

    move-object v5, v14

    .line 551
    :goto_6
    add-int/lit8 v7, v21, 0x1

    move/from16 v21, v7

    move-object v13, v4

    move-object v14, v5

    goto/16 :goto_1

    .line 549
    :cond_4
    const/4 v4, 0x0

    goto/16 :goto_0

    .line 560
    :cond_5
    const/4 v6, 0x0

    move/from16 v20, v6

    goto/16 :goto_2

    .line 567
    :cond_6
    add-int/lit8 v7, v5, 0x1

    move/from16 v19, v6

    goto :goto_3

    .line 576
    :cond_7
    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    move/from16 v18, v7

    goto :goto_5

    .line 579
    :cond_8
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v8, 0x3

    if-ne v7, v8, :cond_9

    .line 580
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aget-boolean v7, v7, v18

    if-eqz v7, :cond_c

    move-object v4, v13

    move-object v5, v14

    goto :goto_6

    .line 582
    :cond_9
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aget-boolean v7, v7, v18

    if-nez v7, :cond_a

    move-object v4, v13

    move-object v5, v14

    goto :goto_6

    .line 583
    :cond_a
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v8, 0x1

    if-ne v7, v8, :cond_b

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    const/4 v8, 0x0

    aget-char v7, v7, v8

    move/from16 v0, v18

    if-eq v0, v7, :cond_b

    move-object v4, v13

    move-object v5, v14

    goto :goto_6

    .line 584
    :cond_b
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v8, 0x2

    if-ne v7, v8, :cond_c

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    const/4 v8, 0x0

    aget-char v7, v7, v8

    move/from16 v0, v18

    if-ne v0, v7, :cond_c

    move-object v4, v13

    move-object v5, v14

    goto :goto_6

    .line 587
    :cond_c
    int-to-char v0, v4

    move/from16 v23, v0

    .line 588
    const/16 v7, 0x100

    if-ge v4, v7, :cond_e

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    aget-char v4, v7, v4

    .line 589
    :goto_7
    move-object/from16 v0, p0

    move/from16 v1, v18

    move/from16 v2, p3

    move/from16 v3, p2

    invoke-direct {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrFuzzy;->delCost(III)I

    move-result v24

    .line 591
    const/4 v10, -0x1

    const/4 v9, -0x1

    .line 592
    if-eqz v13, :cond_11

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v7, v7, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    array-length v7, v7

    if-lez v7, :cond_11

    .line 593
    const/16 v7, 0x100

    move/from16 v0, p4

    if-ge v0, v7, :cond_f

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    aget-char v7, v7, p4

    .line 594
    :goto_8
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v11, v8, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v12, v8, Lcom/mrkeyboard/app/MrRules;->d2c:[C

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v15, v8, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    .line 595
    const/4 v8, 0x0

    :goto_9
    array-length v0, v11

    move/from16 v16, v0

    move/from16 v0, v16

    if-ge v8, v0, :cond_11

    .line 596
    aget-char v16, v11, v8

    move/from16 v0, v16

    if-ne v0, v7, :cond_d

    aget-char v16, v12, v8

    move/from16 v0, v16

    if-ne v0, v4, :cond_d

    .line 597
    if-gez v10, :cond_10

    aget-char v10, v15, v8

    .line 595
    :cond_d
    :goto_a
    add-int/lit8 v8, v8, 0x1

    goto :goto_9

    .line 588
    :cond_e
    invoke-static/range {v23 .. v23}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v4

    goto :goto_7

    .line 593
    :cond_f
    invoke-static/range {p4 .. p4}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v7

    goto :goto_8

    .line 598
    :cond_10
    if-gez v9, :cond_d

    aget-char v9, v15, v8

    goto :goto_a

    .line 602
    :cond_11
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v8, p2, 0x1

    aget-object v25, v7, v8

    .line 603
    add-int/lit8 v7, p2, 0x1

    .line 604
    move-object/from16 v0, p0

    iget v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    sub-int v8, v7, v8

    .line 605
    move-object/from16 v0, p0

    iget v11, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    add-int/2addr v7, v11

    .line 606
    move/from16 v0, v17

    if-le v7, v0, :cond_28

    move/from16 v16, v17

    .line 607
    :goto_b
    const/high16 v12, 0x100000

    .line 608
    if-gtz v8, :cond_1c

    .line 609
    const/4 v7, 0x0

    aget v7, v14, v7

    add-int v7, v7, v24

    .line 610
    const/high16 v8, 0x100000

    if-le v7, v8, :cond_12

    const/high16 v7, 0x100000

    .line 611
    :cond_12
    const/4 v8, 0x0

    aput v7, v25, v8

    .line 613
    const/4 v8, 0x1

    move v12, v7

    .line 617
    :goto_c
    add-int/lit8 v7, v16, 0x1

    move/from16 v0, v17

    if-gt v7, v0, :cond_13

    add-int/lit8 v7, v16, 0x1

    const/high16 v11, 0x100000

    aput v11, v25, v7

    .line 618
    :cond_13
    add-int/lit8 v7, v16, 0x2

    move/from16 v0, v17

    if-gt v7, v0, :cond_14

    add-int/lit8 v7, v16, 0x2

    const/high16 v11, 0x100000

    aput v11, v25, v7

    .line 619
    :cond_14
    if-nez p2, :cond_1d

    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v11, 0x3

    if-ne v7, v11, :cond_1d

    const/4 v7, 0x1

    :goto_d
    move v15, v8

    .line 620
    :goto_e
    move/from16 v0, v16

    if-gt v15, v0, :cond_1f

    .line 621
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v11, v15, -0x1

    aget-char v26, v8, v11

    .line 623
    if-eqz v7, :cond_1e

    const/high16 v8, 0x100000

    .line 624
    :goto_f
    add-int/lit8 v11, v15, -0x1

    aget v11, v25, v11

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    move-object/from16 v27, v0

    add-int/lit8 v28, v15, -0x1

    aget v27, v27, v28

    add-int v11, v11, v27

    .line 625
    if-ge v11, v8, :cond_15

    move v8, v11

    .line 626
    :cond_15
    aget v11, v14, v15

    add-int v11, v11, v24

    .line 627
    if-ge v11, v8, :cond_27

    .line 628
    :goto_10
    const/4 v8, 0x2

    if-lt v15, v8, :cond_26

    .line 629
    if-eqz v13, :cond_25

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v27, v15, -0x2

    aget-char v8, v8, v27

    move/from16 v0, v18

    if-ne v0, v8, :cond_25

    move/from16 v0, p3

    move/from16 v1, v26

    if-ne v0, v1, :cond_25

    move/from16 v0, v18

    move/from16 v1, p3

    if-eq v0, v1, :cond_25

    .line 630
    add-int/lit8 v8, v15, -0x2

    aget v8, v13, v8

    add-int/lit8 v8, v8, 0x28

    .line 631
    if-ge v8, v11, :cond_25

    .line 633
    :goto_11
    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD1:[C

    aget-char v11, v11, v15

    if-eqz v11, :cond_16

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD1:[C

    aget-char v11, v11, v15

    if-eq v4, v11, :cond_17

    :cond_16
    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD2:[C

    aget-char v11, v11, v15

    if-eqz v11, :cond_18

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD2:[C

    aget-char v11, v11, v15

    if-ne v4, v11, :cond_18

    .line 634
    :cond_17
    add-int/lit8 v11, v15, -0x2

    aget v11, v14, v11

    add-int/lit8 v11, v11, 0x23

    .line 635
    if-ge v11, v8, :cond_18

    move v8, v11

    .line 638
    :cond_18
    :goto_12
    if-ltz v10, :cond_1a

    move/from16 v0, v26

    if-eq v0, v10, :cond_19

    move/from16 v0, v26

    if-ne v0, v9, :cond_1a

    .line 639
    :cond_19
    add-int/lit8 v11, v15, -0x1

    aget v11, v13, v11

    add-int/lit8 v11, v11, 0x23

    .line 640
    if-ge v11, v8, :cond_1a

    move v8, v11

    .line 642
    :cond_1a
    const/high16 v11, 0x100000

    if-le v8, v11, :cond_1b

    const/high16 v8, 0x100000

    .line 643
    :cond_1b
    aput v8, v25, v15

    .line 644
    if-ge v8, v12, :cond_24

    .line 620
    :goto_13
    add-int/lit8 v11, v15, 0x1

    move v15, v11

    move v12, v8

    goto/16 :goto_e

    .line 615
    :cond_1c
    add-int/lit8 v7, v8, -0x1

    const/high16 v11, 0x100000

    aput v11, v25, v7

    goto/16 :goto_c

    .line 619
    :cond_1d
    const/4 v7, 0x0

    goto/16 :goto_d

    .line 623
    :cond_1e
    add-int/lit8 v8, v15, -0x1

    aget v8, v14, v8

    add-int/lit8 v11, v15, -0x1

    move-object/from16 v0, p0

    move/from16 v1, v18

    invoke-direct {v0, v11, v1}, Lcom/mrkeyboard/app/MrFuzzy;->sub(II)I

    move-result v11

    add-int/2addr v8, v11

    goto/16 :goto_f

    .line 646
    :cond_1f
    const/16 v4, 0x30

    move/from16 v0, p2

    if-ge v0, v4, :cond_20

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    aput-char v23, v4, p2

    .line 647
    :cond_20
    if-eqz v20, :cond_21

    move/from16 v0, v16

    move/from16 v1, v17

    if-ne v0, v1, :cond_21

    aget v4, v25, v17

    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mMaxCost:I

    if-gt v4, v7, :cond_21

    add-int/lit8 v4, p2, 0x1

    const/16 v7, 0x30

    if-gt v4, v7, :cond_21

    if-lez v5, :cond_21

    .line 648
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    add-int/lit8 v7, p2, 0x1

    aget v8, v25, v17

    move-object/from16 v0, p0

    invoke-direct {v0, v4, v7, v5, v8}, Lcom/mrkeyboard/app/MrFuzzy;->offer([CIII)V

    .line 650
    :cond_21
    if-eqz v19, :cond_23

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mMaxCost:I

    if-gt v12, v4, :cond_23

    add-int/lit8 v4, p2, 0x1

    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    add-int v5, v5, v17

    if-ge v4, v5, :cond_23

    add-int/lit8 v4, p2, 0x2

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    array-length v5, v5

    if-ge v4, v5, :cond_23

    add-int/lit8 v4, p2, 0x1

    const/16 v5, 0x30

    if-ge v4, v5, :cond_23

    .line 652
    add-int/lit8 v4, p2, 0x1

    move-object/from16 v0, p0

    move/from16 v1, v19

    move/from16 v2, v18

    move/from16 v3, v23

    invoke-direct {v0, v1, v4, v2, v3}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 653
    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v5, 0x2ee0

    if-gt v4, v5, :cond_0

    .line 655
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v5, v4, p2

    .line 656
    if-lez p2, :cond_22

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v7, p2, -0x1

    aget-object v4, v4, v7

    goto/16 :goto_6

    :cond_22
    const/4 v4, 0x0

    goto/16 :goto_6

    :cond_23
    move-object v4, v13

    move-object v5, v14

    goto/16 :goto_6

    :cond_24
    move v8, v12

    goto/16 :goto_13

    :cond_25
    move v8, v11

    goto/16 :goto_11

    :cond_26
    move v8, v11

    goto/16 :goto_12

    :cond_27
    move v11, v8

    goto/16 :goto_10

    :cond_28
    move/from16 v16, v7

    goto/16 :goto_b

    :cond_29
    move v6, v7

    goto/16 :goto_4
.end method

.method private walkRoot()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 451
    const/4 v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 452
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v2, v2, v2}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 453
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v1, 0x2ee0

    if-le v0, v1, :cond_0

    .line 457
    :goto_0
    return-void

    .line 454
    :cond_0
    const/4 v0, 0x2

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 455
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v2, v2, v2}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 456
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    goto :goto_0
.end method


# virtual methods
.method emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V
    .locals 10

    .prologue
    const/4 v2, 0x0

    .line 791
    move v7, v2

    :goto_0
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v7, v0, :cond_0

    .line 792
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v4, v0, v7

    .line 793
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

    .line 791
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    .line 796
    :cond_0
    return-void
.end method

.method resultCount()I
    .locals 1

    .prologue
    .line 369
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    return v0
.end method

.method resultScore(I)J
    .locals 2

    .prologue
    .line 371
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v0, v0, p1

    return-wide v0
.end method

.method resultWord(I)Ljava/lang/String;
    .locals 4

    .prologue
    .line 370
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
    .line 374
    invoke-interface {p2}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/16 v1, 0x14

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 375
    iput v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    .line 376
    const/4 v0, 0x0

    move v4, v0

    :goto_0
    if-ge v4, v5, :cond_4

    .line 377
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    invoke-interface {p2, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    aput-char v1, v0, v4

    .line 378
    const/4 v1, 0x0

    .line 379
    if-eqz p1, :cond_1

    invoke-virtual {p1, v4}, Lcom/mrkeyboard/app/WordComposer;->getCodesAt(I)[I

    move-result-object v0

    move-object v3, v0

    .line 380
    :goto_1
    if-eqz v3, :cond_0

    .line 381
    const/4 v0, 0x1

    :goto_2
    array-length v2, v3

    if-ge v0, v2, :cond_0

    const/16 v2, 0x10

    if-ge v1, v2, :cond_0

    .line 382
    aget v2, v3, v0

    .line 383
    if-gtz v2, :cond_2

    .line 388
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aput v1, v0, v4

    .line 389
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v0, v0, v4

    const/4 v1, -0x1

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([SS)V

    .line 376
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_0

    .line 379
    :cond_1
    const/4 v0, 0x0

    move-object v3, v0

    goto :goto_1

    .line 384
    :cond_2
    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v6

    .line 385
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v2, v2, v4

    if-eq v6, v2, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v7, v2, v4

    add-int/lit8 v2, v1, 0x1

    aput-char v6, v7, v1

    move v1, v2

    .line 381
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 391
    :cond_4
    invoke-static {}, Lcom/mrkeyboard/app/MrRules;->get()Lcom/mrkeyboard/app/MrRules;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 392
    const/4 v0, 0x0

    :goto_3
    if-ge v0, v5, :cond_5

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->insCost(I)I

    move-result v2

    aput v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 393
    :cond_5
    const/4 v0, 0x2

    move v3, v0

    :goto_4
    if-gt v3, v5, :cond_9

    .line 394
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v1, v3, -0x2

    aget-char v4, v0, v1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v1, v3, -0x1

    aget-char v6, v0, v1

    .line 395
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 396
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v7, v0, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v8, v0, Lcom/mrkeyboard/app/MrRules;->t2b:[C

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v9, v0, Lcom/mrkeyboard/app/MrRules;->t2d:[C

    .line 397
    const/4 v0, 0x0

    :goto_5
    array-length v10, v7

    if-ge v0, v10, :cond_8

    .line 398
    aget-char v10, v7, v0

    if-ne v10, v4, :cond_6

    aget-char v10, v8, v0

    if-ne v10, v6, :cond_6

    .line 399
    if-nez v2, :cond_7

    aget-char v2, v9, v0

    .line 397
    :cond_6
    :goto_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_5

    .line 400
    :cond_7
    if-nez v1, :cond_6

    aget-char v1, v9, v0

    goto :goto_6

    .line 403
    :cond_8
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD1:[C

    aput-char v2, v0, v3

    .line 404
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD2:[C

    aput-char v1, v0, v3

    .line 393
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_4

    .line 406
    :cond_9
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->firstLetters()V

    .line 407
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 408
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    .line 409
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    const/4 v1, 0x0

    aget-object v1, v0, v1

    .line 410
    const/4 v0, 0x0

    const/4 v2, 0x0

    aput v2, v1, v0

    .line 411
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

    .line 417
    :cond_a
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->isPrefix()Z

    move-result v1

    .line 418
    if-eqz v1, :cond_b

    const/4 v0, 0x4

    if-lt v5, v0, :cond_d

    .line 419
    :cond_b
    if-eqz v1, :cond_f

    const/4 v0, 0x4

    if-ne v5, v0, :cond_f

    const/16 v0, 0x28

    :goto_8
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 420
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->walkRoot()V

    .line 421
    if-nez v1, :cond_c

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v2, 0x2ee0

    if-gt v0, v2, :cond_c

    .line 424
    const/4 v0, 0x6

    if-lt v5, v0, :cond_12

    const/16 v0, 0x1e

    :goto_9
    add-int/lit8 v0, v0, 0x1e

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 425
    const/4 v0, 0x3

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 426
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-direct {p0, v0, v2, v3, v4}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 427
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 429
    :cond_c
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-nez v0, :cond_d

    if-nez v1, :cond_d

    const/4 v0, 0x6

    if-lt v5, v0, :cond_d

    .line 431
    const/4 v0, 0x7

    if-gt v5, v0, :cond_13

    const/16 v0, 0x64

    :goto_a
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 432
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->walkRoot()V

    .line 435
    :cond_d
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    sput v0, Lcom/mrkeyboard/app/MrFuzzy;->sLastVisits:I

    .line 436
    const/4 v0, 0x4

    if-lt v5, v0, :cond_e

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->split()V

    .line 437
    :cond_e
    return-void

    .line 419
    :cond_f
    const/4 v0, 0x3

    if-gt v5, v0, :cond_10

    const/16 v0, 0x2d

    goto :goto_8

    :cond_10
    const/4 v0, 0x4

    if-ne v5, v0, :cond_11

    const/16 v0, 0x3c

    goto :goto_8

    :cond_11
    const/16 v0, 0x4b

    goto :goto_8

    .line 424
    :cond_12
    const/4 v0, 0x0

    goto :goto_9

    .line 431
    :cond_13
    const/16 v0, 0x78

    goto :goto_a
.end method
