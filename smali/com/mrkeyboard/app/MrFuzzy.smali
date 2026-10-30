.class public final Lcom/mrkeyboard/app/MrFuzzy;
.super Ljava/lang/Object;
.source "MrFuzzy.java"


# static fields
.field private static final BASE:[C

.field static final C_DEL:I = 0x3c

.field static final C_DEL_DOUBLE:I = 0x1e

.field static final C_DEL_H:I = 0x2d

.field static final C_DEL_H0:I = 0x1e

.field static final C_DEL_U:I = 0x28

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

.field private static sCache:Lcom/mrkeyboard/app/MrFuzzy;

.field static sLastVisits:I


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

.field private final mTwoC:[Z

.field private final mTwoX:[Z

.field private mVisits:I


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/16 v3, 0x100

    .line 51
    new-array v0, v3, [C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    .line 52
    new-array v0, v3, [C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    .line 55
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v3, :cond_0

    .line 56
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    aput-char v2, v1, v0

    .line 57
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    int-to-char v2, v0

    invoke-static {v2}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v2

    aput-char v2, v1, v0

    .line 55
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 59
    :cond_0
    return-void
.end method

.method constructor <init>(Ljava/nio/ByteBuffer;I)V
    .locals 7

    .prologue
    const/16 v6, 0x15

    const/4 v5, 0x5

    const/4 v1, 0x1

    const/4 v2, 0x0

    const/16 v4, 0x14

    .line 95
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 72
    new-array v0, v4, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    .line 73
    const/16 v0, 0x10

    filled-new-array {v4, v0}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    .line 74
    new-array v0, v4, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    .line 75
    const/16 v0, 0x100

    filled-new-array {v4, v0}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Short;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[S

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    .line 76
    new-array v0, v4, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    .line 77
    const/16 v0, 0x100

    new-array v0, v0, [Z

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    .line 78
    new-array v0, v6, [Z

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoX:[Z

    .line 79
    new-array v0, v6, [Z

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoC:[Z

    .line 80
    const/16 v0, 0x19

    filled-new-array {v0, v6}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    .line 81
    const/16 v0, 0x32

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    .line 90
    const/16 v0, 0x62

    filled-new-array {v5, v0}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    .line 91
    new-array v0, v5, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    .line 92
    new-array v0, v5, [J

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    .line 537
    const/16 v0, 0x62

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    .line 538
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    .line 539
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    .line 540
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    .line 96
    iput-object p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    .line 97
    iput p2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    .line 99
    const/4 v0, 0x2

    if-le p2, v0, :cond_3

    .line 100
    invoke-virtual {p1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 101
    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 102
    const/16 v4, 0xc8

    if-lt v0, v4, :cond_2

    if-eqz v3, :cond_0

    if-ne v3, v1, :cond_2

    :cond_0
    move v0, v1

    .line 104
    :goto_0
    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    .line 105
    if-eqz v0, :cond_1

    const/4 v2, 0x2

    :cond_1
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    .line 106
    return-void

    :cond_2
    move v0, v2

    .line 102
    goto :goto_0

    :cond_3
    move v0, v2

    goto :goto_0
.end method

.method public static afterWords(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V
    .locals 7

    .prologue
    .line 126
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 150
    :cond_0
    :goto_0
    return-void

    .line 127
    :cond_1
    :try_start_0
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->size()I

    move-result v0

    .line 128
    const/4 v1, 0x2

    if-lt v0, v1, :cond_0

    const/16 v1, 0x14

    if-gt v0, v1, :cond_0

    .line 129
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->getTypedWord()Ljava/lang/CharSequence;

    move-result-object v1

    .line 130
    if-eqz v1, :cond_0

    .line 131
    invoke-static {v1}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    .line 132
    if-eqz v2, :cond_2

    .line 133
    invoke-virtual {v2}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 134
    const/4 v2, 0x0

    array-length v3, v1

    const v4, 0x1fffffff

    const/4 v5, 0x1

    sget-object v6, Lcom/mrkeyboard/app/Dictionary$DataType;->UNIGRAM:Lcom/mrkeyboard/app/Dictionary$DataType;

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/Suggest;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z

    goto :goto_0

    .line 147
    :catch_0
    move-exception v0

    goto :goto_0

    .line 137
    :cond_2
    const/4 v2, 0x3

    if-lt v0, v2, :cond_0

    .line 138
    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/Suggest;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 139
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v0

    .line 140
    if-eqz v0, :cond_0

    .line 141
    invoke-virtual {v0}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBuffer()Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v0}, Lcom/mrkeyboard/app/BinaryDictionary;->mrLength()I

    move-result v0

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;

    move-result-object v2

    .line 142
    if-eqz v2, :cond_0

    .line 143
    monitor-enter v2
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 144
    :try_start_1
    invoke-virtual {v2, p1, v1}, Lcom/mrkeyboard/app/MrFuzzy;->search(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;)V

    .line 145
    invoke-virtual {v2, p0}, Lcom/mrkeyboard/app/MrFuzzy;->emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V

    .line 146
    monitor-exit v2

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v0
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0
.end method

.method private static delCost(III)I
    .locals 2

    .prologue
    const/16 v1, 0x68

    const/16 v0, 0x1e

    .line 464
    if-nez p2, :cond_1

    if-ne p0, v1, :cond_1

    .line 468
    :cond_0
    :goto_0
    return v0

    .line 465
    :cond_1
    if-lez p2, :cond_2

    if-eq p0, p1, :cond_0

    .line 466
    :cond_2
    const/16 v0, 0x75

    if-ne p0, v0, :cond_4

    const/16 v0, 0x71

    if-eq p1, v0, :cond_3

    const/16 v0, 0x67

    if-ne p1, v0, :cond_4

    :cond_3
    const/16 v0, 0x28

    goto :goto_0

    .line 467
    :cond_4
    if-ne p0, v1, :cond_6

    const/16 v0, 0x63

    if-eq p1, v0, :cond_5

    const/16 v0, 0x6c

    if-eq p1, v0, :cond_5

    const/16 v0, 0x6e

    if-ne p1, v0, :cond_6

    :cond_5
    const/16 v0, 0x2d

    goto :goto_0

    .line 468
    :cond_6
    const/16 v0, 0x3c

    goto :goto_0
.end method

.method private firstLetters()V
    .locals 9

    .prologue
    const/16 v8, 0x65

    const/16 v7, 0x63

    const/16 v6, 0x100

    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 272
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([ZZ)V

    .line 273
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v3, v0, v2

    .line 274
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    and-int/lit16 v5, v3, 0xff

    if-ge v3, v6, :cond_1

    move v0, v1

    :goto_0
    aput-boolean v0, v4, v5

    move v0, v2

    .line 275
    :goto_1
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v4, v4, v2

    if-ge v0, v4, :cond_2

    .line 276
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v4, v4, v2

    aget-char v4, v4, v0

    .line 277
    if-ge v4, v6, :cond_0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v4

    .line 275
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    move v0, v2

    .line 274
    goto :goto_0

    .line 279
    :cond_2
    const/16 v0, 0x61

    :goto_2
    const/16 v2, 0x7a

    if-gt v0, v2, :cond_4

    .line 280
    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrFuzzy;->phonetic(CC)Z

    move-result v2

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v2, v0

    .line 279
    :cond_3
    add-int/lit8 v0, v0, 0x1

    int-to-char v0, v0

    goto :goto_2

    .line 282
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    const/16 v2, 0x68

    aput-boolean v1, v0, v2

    .line 283
    if-ne v3, v8, :cond_5

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    const/16 v2, 0x69

    aput-boolean v1, v0, v2

    .line 284
    :cond_5
    const/16 v0, 0x69

    if-ne v3, v0, :cond_6

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v0, v8

    .line 285
    :cond_6
    const/16 v0, 0x6f

    if-ne v3, v0, :cond_7

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    const/16 v2, 0x75

    aput-boolean v1, v0, v2

    .line 286
    :cond_7
    const/16 v0, 0x75

    if-ne v3, v0, :cond_8

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    const/16 v2, 0x6f

    aput-boolean v1, v0, v2

    .line 287
    :cond_8
    if-ne v3, v7, :cond_9

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-le v0, v1, :cond_9

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, v1

    const/16 v2, 0x68

    if-ne v0, v2, :cond_9

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    const/16 v2, 0x78

    aput-boolean v1, v0, v2

    .line 288
    :cond_9
    const/16 v0, 0x78

    if-ne v3, v0, :cond_a

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v0, v7

    .line 289
    :cond_a
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-le v0, v1, :cond_b

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, v1

    if-ge v0, v6, :cond_b

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v2, v2, v1

    aput-boolean v1, v0, v2

    .line 290
    :cond_b
    return-void
.end method

.method static declared-synchronized forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;
    .locals 3

    .prologue
    .line 109
    const-class v1, Lcom/mrkeyboard/app/MrFuzzy;

    monitor-enter v1

    if-eqz p0, :cond_0

    const/4 v0, 0x2

    if-gt p1, v0, :cond_2

    :cond_0
    const/4 v0, 0x0

    .line 115
    :cond_1
    :goto_0
    monitor-exit v1

    return-object v0

    .line 110
    :cond_2
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;

    .line 111
    if-eqz v0, :cond_3

    iget-object v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    if-ne v2, p0, :cond_3

    iget v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-eq v2, p1, :cond_1

    .line 112
    :cond_3
    new-instance v0, Lcom/mrkeyboard/app/MrFuzzy;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrFuzzy;-><init>(Ljava/nio/ByteBuffer;I)V

    .line 113
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 109
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private insCost(I)I
    .locals 4

    .prologue
    const/16 v0, 0x2d

    .line 454
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v1, v1, p1

    .line 455
    if-lez p1, :cond_1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v3, p1, -0x1

    aget-char v2, v2, v3

    if-ne v2, v1, :cond_1

    const/16 v0, 0x1e

    .line 459
    :cond_0
    :goto_0
    return v0

    .line 456
    :cond_1
    const/16 v2, 0x68

    if-ne v1, v2, :cond_2

    const/16 v0, 0x28

    goto :goto_0

    .line 457
    :cond_2
    if-lez p1, :cond_3

    add-int/lit8 v2, p1, -0x1

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v2

    if-nez v2, :cond_0

    .line 458
    :cond_3
    add-int/lit8 v2, p1, 0x1

    iget v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-ge v2, v3, :cond_4

    add-int/lit8 v2, p1, 0x1

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v1

    if-nez v1, :cond_0

    .line 459
    :cond_4
    const/16 v0, 0x3c

    goto :goto_0
.end method

.method private insert([CIIJ)V
    .locals 8

    .prologue
    const/4 v7, 0x5

    const/4 v1, 0x0

    .line 487
    move v0, v1

    :goto_0
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v0, v2, :cond_2

    .line 488
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aget v2, v2, v0

    if-ne v2, p3, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v2, v2, v0

    invoke-static {v2, p1, p2, p3}, Lcom/mrkeyboard/app/MrFuzzy;->same([C[CII)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 489
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v2, v2, v0

    cmp-long v2, p4, v2

    if-gtz v2, :cond_1

    .line 509
    :cond_0
    :goto_1
    return-void

    .line 490
    :cond_1
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->remove(I)V

    .line 494
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    move v2, v0

    .line 495
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

    .line 487
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 496
    :cond_4
    if-ge v2, v7, :cond_0

    .line 497
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    const/4 v3, 0x4

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 498
    :goto_3
    if-le v0, v2, :cond_5

    .line 499
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v3, v3, v0

    .line 500
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v6, v0, -0x1

    aget-object v5, v5, v6

    aput-object v5, v4, v0

    .line 501
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v5, v0, -0x1

    aput-object v3, v4, v5

    .line 502
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    add-int/lit8 v5, v0, -0x1

    aget v4, v4, v5

    aput v4, v3, v0

    .line 503
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    add-int/lit8 v5, v0, -0x1

    aget-wide v4, v4, v5

    aput-wide v4, v3, v0

    .line 498
    add-int/lit8 v0, v0, -0x1

    goto :goto_3

    .line 505
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v0, v0, v2

    invoke-static {p1, p2, v0, v1, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 506
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aput p3, v0, v2

    .line 507
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aput-wide p4, v0, v2

    .line 508
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
    .line 424
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v1, v0, p1

    .line 425
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v0, v0, p1

    add-int/lit8 v0, v0, -0x1

    :goto_0
    if-ltz v0, :cond_1

    .line 426
    aget-char v2, v1, v0

    if-ne v2, p2, :cond_0

    const/4 v0, 0x1

    .line 428
    :goto_1
    return v0

    .line 425
    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 428
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private isPrefix()Z
    .locals 2

    .prologue
    .line 229
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

    .line 574
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 575
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 576
    sub-int v1, p2, p1

    const/16 v2, 0x30

    if-le v1, v2, :cond_0

    .line 578
    :goto_0
    return v0

    .line 577
    :cond_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v1, p1, p2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->lookupRec(IIII)V

    .line 578
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    goto :goto_0
.end method

.method private lookupRec(IIII)V
    .locals 10

    .prologue
    const/4 v3, 0x0

    .line 582
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 624
    :cond_0
    return-void

    .line 583
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v8, v0, 0xff

    .line 584
    add-int/lit8 v4, p1, 0x1

    .line 585
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v9, v0, p2

    move v7, v3

    .line 586
    :goto_0
    if-ge v7, v8, :cond_0

    .line 587
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v0, :cond_0

    .line 588
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v4, 0x1

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 589
    const/16 v2, 0xff

    if-ne v0, v2, :cond_2

    .line 590
    add-int/lit8 v0, v1, 0x1

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v0, v2, :cond_0

    .line 591
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

    .line 592
    add-int/lit8 v1, v1, 0x2

    .line 594
    :cond_2
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v2, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v4, v2, 0xff

    .line 595
    and-int/lit16 v2, v4, 0x80

    if-eqz v2, :cond_4

    const/4 v2, 0x1

    move v6, v2

    .line 597
    :goto_1
    and-int/lit8 v2, v4, 0x40

    if-eqz v2, :cond_5

    .line 598
    add-int/lit8 v2, v1, 0x2

    iget v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v2, v5, :cond_0

    .line 599
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

    .line 600
    add-int/lit8 v1, v1, 0x3

    move v5, v2

    .line 605
    :goto_2
    if-eqz v6, :cond_a

    .line 606
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    .line 607
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v1, 0x1

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 608
    iget-boolean v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v4, :cond_9

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v2

    move v4, v2

    move v2, v1

    .line 610
    :goto_3
    const/16 v1, 0x100

    if-ge v0, v1, :cond_6

    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v1, v1, v0

    .line 611
    :goto_4
    if-eq v1, v9, :cond_7

    .line 586
    :cond_3
    :goto_5
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto/16 :goto_0

    :cond_4
    move v6, v3

    .line 595
    goto :goto_1

    .line 602
    :cond_5
    add-int/lit8 v1, v1, 0x1

    move v5, v3

    goto :goto_2

    .line 610
    :cond_6
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    goto :goto_4

    .line 612
    :cond_7
    int-to-char v0, v0

    .line 613
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aput-char v0, v1, p4

    .line 614
    add-int/lit8 v0, p2, 0x1

    if-ne v0, p3, :cond_8

    .line 615
    if-eqz v6, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    if-le v2, v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aget-char v0, v0, v3

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-nez v0, :cond_3

    .line 616
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 617
    add-int/lit8 v0, p4, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 618
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    add-int/lit8 v2, p4, 0x1

    invoke-static {v0, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_5

    .line 620
    :cond_8
    if-eqz v5, :cond_3

    .line 621
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
    .locals 6

    .prologue
    .line 480
    invoke-direct {p0, p3, p4}, Lcom/mrkeyboard/app/MrFuzzy;->scoreFor(II)J

    move-result-wide v4

    .line 481
    const-wide/16 v0, 0x0

    cmp-long v0, v4, v0

    if-gtz v0, :cond_0

    .line 483
    :goto_0
    return-void

    .line 482
    :cond_0
    const/4 v2, 0x0

    move-object v0, p0

    move-object v1, p1

    move v3, p2

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrFuzzy;->insert([CIIJ)V

    goto :goto_0
.end method

.method private static oneLetterWord(C)Z
    .locals 1

    .prologue
    .line 569
    const/16 v0, 0x61

    if-eq p0, v0, :cond_0

    const/16 v0, 0x65

    if-eq p0, v0, :cond_0

    const/16 v0, 0x6f

    if-ne p0, v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static pair(CCCC)Z
    .locals 1

    .prologue
    .line 443
    if-ne p0, p2, :cond_0

    if-eq p1, p3, :cond_1

    :cond_0
    if-ne p0, p3, :cond_2

    if-ne p1, p2, :cond_2

    :cond_1
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static phonetic(CC)Z
    .locals 6

    .prologue
    const/16 v5, 0x77

    const/16 v4, 0x75

    const/16 v3, 0x6b

    const/16 v1, 0x63

    const/16 v2, 0x73

    .line 447
    const/16 v0, 0x7a

    invoke-static {p0, p1, v2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->pair(CCCC)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p0, p1, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->pair(CCCC)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p0, p1, v1, v3}, Lcom/mrkeyboard/app/MrFuzzy;->pair(CCCC)Z

    move-result v0

    if-nez v0, :cond_0

    const/16 v0, 0x71

    invoke-static {p0, p1, v3, v0}, Lcom/mrkeyboard/app/MrFuzzy;->pair(CCCC)Z

    move-result v0

    if-nez v0, :cond_0

    const/16 v0, 0x67

    const/16 v1, 0x6a

    .line 448
    invoke-static {p0, p1, v0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->pair(CCCC)Z

    move-result v0

    if-nez v0, :cond_0

    const/16 v0, 0x78

    const/16 v1, 0x7a

    invoke-static {p0, p1, v0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->pair(CCCC)Z

    move-result v0

    if-nez v0, :cond_0

    const/16 v0, 0x78

    invoke-static {p0, p1, v0, v2}, Lcom/mrkeyboard/app/MrFuzzy;->pair(CCCC)Z

    move-result v0

    if-nez v0, :cond_0

    const/16 v0, 0x76

    invoke-static {p0, p1, v5, v0}, Lcom/mrkeyboard/app/MrFuzzy;->pair(CCCC)Z

    move-result v0

    if-nez v0, :cond_0

    .line 449
    invoke-static {p0, p1, v5, v4}, Lcom/mrkeyboard/app/MrFuzzy;->pair(CCCC)Z

    move-result v0

    if-nez v0, :cond_0

    const/16 v0, 0x79

    const/16 v1, 0x69

    invoke-static {p0, p1, v0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->pair(CCCC)Z

    move-result v0

    if-nez v0, :cond_0

    const/16 v0, 0x6c

    invoke-static {p0, p1, v0, v4}, Lcom/mrkeyboard/app/MrFuzzy;->pair(CCCC)Z

    move-result v0

    if-nez v0, :cond_0

    const/16 v0, 0x6d

    const/16 v1, 0x6e

    invoke-static {p0, p1, v0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->pair(CCCC)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    .line 447
    :goto_0
    return v0

    .line 449
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private prefixRec(II)Z
    .locals 11

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 233
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    :cond_0
    move v0, v2

    .line 267
    :goto_0
    return v0

    .line 234
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v6, v0, 0xff

    .line 235
    add-int/lit8 v1, p1, 0x1

    .line 236
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v7, v0, p2

    move v5, v2

    move v0, v1

    .line 237
    :goto_1
    if-ge v5, v6, :cond_d

    .line 238
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v0, v1, :cond_2

    move v0, v2

    goto :goto_0

    .line 239
    :cond_2
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v0, 0x1

    invoke-virtual {v4, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 240
    const/16 v4, 0xff

    if-ne v0, v4, :cond_4

    .line 241
    add-int/lit8 v0, v1, 0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v0, v4, :cond_3

    move v0, v2

    goto :goto_0

    .line 242
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

    .line 243
    add-int/lit8 v1, v1, 0x2

    .line 245
    :cond_4
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v8, v4, 0xff

    .line 247
    and-int/lit8 v4, v8, 0x40

    if-eqz v4, :cond_6

    .line 248
    add-int/lit8 v4, v1, 0x2

    iget v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v4, v9, :cond_5

    move v0, v2

    goto :goto_0

    .line 249
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

    .line 250
    add-int/lit8 v1, v1, 0x3

    .line 254
    :goto_2
    and-int/lit16 v8, v8, 0x80

    if-eqz v8, :cond_8

    .line 255
    iget v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v1, v8, :cond_7

    move v0, v2

    goto/16 :goto_0

    .line 252
    :cond_6
    add-int/lit8 v1, v1, 0x1

    move v4, v2

    goto :goto_2

    .line 256
    :cond_7
    add-int/lit8 v1, v1, 0x1

    .line 257
    iget-boolean v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v8, :cond_8

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v1

    .line 259
    :cond_8
    const/16 v8, 0x100

    if-ge v0, v8, :cond_a

    sget-object v8, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v0, v8, v0

    .line 260
    :goto_3
    if-eq v0, v7, :cond_b

    .line 237
    :cond_9
    add-int/lit8 v0, v5, 0x1

    move v5, v0

    move v0, v1

    goto/16 :goto_1

    .line 259
    :cond_a
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v0

    goto :goto_3

    .line 261
    :cond_b
    add-int/lit8 v0, p2, 0x1

    iget v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-ne v0, v8, :cond_c

    .line 262
    if-eqz v4, :cond_9

    move v0, v3

    goto/16 :goto_0

    .line 263
    :cond_c
    if-eqz v4, :cond_9

    add-int/lit8 v0, p2, 0x1

    invoke-direct {p0, v4, v0}, Lcom/mrkeyboard/app/MrFuzzy;->prefixRec(II)Z

    move-result v0

    if-eqz v0, :cond_9

    move v0, v3

    .line 264
    goto/16 :goto_0

    :cond_d
    move v0, v2

    .line 267
    goto/16 :goto_0
.end method

.method private remove(I)V
    .locals 4

    .prologue
    .line 512
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v0, v0, p1

    .line 513
    :goto_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v1, v1, -0x1

    if-ge p1, v1, :cond_0

    .line 514
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v3, p1, 0x1

    aget-object v2, v2, v3

    aput-object v2, v1, p1

    .line 515
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    add-int/lit8 v3, p1, 0x1

    aget v2, v2, v3

    aput v2, v1, p1

    .line 516
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    add-int/lit8 v3, p1, 0x1

    aget-wide v2, v2, v3

    aput-wide v2, v1, p1

    .line 513
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 518
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v2, v2, -0x1

    aput-object v0, v1, v2

    .line 519
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 520
    return-void
.end method

.method private static same([C[CII)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 523
    move v1, v0

    :goto_0
    if-ge v1, p3, :cond_1

    aget-char v2, p0, v1

    add-int v3, p2, v1

    aget-char v3, p1, v3

    if-eq v2, v3, :cond_0

    .line 524
    :goto_1
    return v0

    .line 523
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 524
    :cond_1
    const/4 v0, 0x1

    goto :goto_1
.end method

.method private scoreFor(II)J
    .locals 10

    .prologue
    const-wide v0, 0x41affffffe000000L    # 2.68435455E8

    .line 472
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    const/16 v3, 0x18

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 473
    int-to-double v4, p1

    const-wide/16 v6, 0x1

    add-int/lit8 v2, v2, 0x1

    shl-long v2, v6, v2

    long-to-double v2, v2

    mul-double/2addr v2, v4

    .line 474
    const-wide/high16 v4, 0x4000000000000000L    # 2.0

    neg-int v6, p2

    int-to-double v6, v6

    const-wide/high16 v8, 0x4039000000000000L    # 25.0

    div-double/2addr v6, v8

    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v4

    mul-double/2addr v2, v4

    .line 475
    cmpl-double v4, v2, v0

    if-lez v4, :cond_0

    .line 476
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
    .line 213
    iput p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mMaxCost:I

    .line 214
    div-int/lit8 v0, p1, 0x1e

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    .line 215
    return-void
.end method

.method private skipBigrams(I)I
    .locals 3

    .prologue
    .line 410
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 420
    :cond_0
    :goto_0
    return p1

    .line 411
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    if-eqz v0, :cond_2

    .line 412
    const/4 v0, 0x0

    .line 413
    :goto_1
    add-int/lit8 v1, p1, 0x3

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    add-int/lit8 v1, v0, 0x1

    const/16 v2, 0x2710

    if-ge v0, v2, :cond_0

    .line 414
    add-int/lit8 v0, p1, 0x3

    .line 415
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 p1, v0, 0x1

    invoke-virtual {v2, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    .line 416
    if-eqz v0, :cond_0

    move v0, v1

    .line 417
    goto :goto_1

    .line 420
    :cond_2
    add-int/lit8 p1, p1, 0x1

    goto :goto_0
.end method

.method private split()V
    .locals 11

    .prologue
    const/4 v7, 0x1

    const/4 v2, 0x0

    .line 545
    iget v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    .line 546
    const-wide/16 v4, 0x0

    move v6, v7

    move v3, v2

    .line 548
    :goto_0
    add-int/lit8 v0, v8, -0x2

    if-gt v6, v0, :cond_2

    .line 549
    if-ne v6, v7, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, v2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneLetterWord(C)Z

    move-result v0

    if-nez v0, :cond_1

    .line 548
    :cond_0
    :goto_1
    add-int/lit8 v0, v6, 0x1

    move v6, v0

    goto :goto_0

    .line 550
    :cond_1
    invoke-direct {p0, v2, v6}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v0

    .line 551
    if-lez v0, :cond_0

    .line 552
    iget v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 553
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    iget-object v10, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    invoke-static {v1, v2, v10, v2, v9}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 554
    invoke-direct {p0, v6, v8}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v1

    .line 555
    if-lez v1, :cond_0

    .line 556
    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    const/16 v1, 0x23

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->scoreFor(II)J

    move-result-wide v0

    .line 557
    cmp-long v10, v0, v4

    if-lez v10, :cond_0

    .line 559
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    invoke-static {v3, v2, v4, v2, v9}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 560
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    const/16 v4, 0x20

    aput-char v4, v3, v9

    .line 561
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    add-int/lit8 v5, v9, 0x1

    iget v10, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    invoke-static {v3, v2, v4, v5, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 562
    add-int/lit8 v3, v9, 0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    add-int/2addr v3, v4

    move-wide v4, v0

    goto :goto_1

    .line 565
    :cond_2
    if-lez v3, :cond_3

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrFuzzy;->insert([CIIJ)V

    .line 566
    :cond_3
    return-void
.end method

.method private sub(II)I
    .locals 2

    .prologue
    .line 293
    const/16 v0, 0x100

    if-lt p2, v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, p1

    if-ne p2, v0, :cond_1

    const/4 v0, 0x0

    .line 299
    :cond_0
    :goto_0
    return v0

    .line 293
    :cond_1
    const/16 v0, 0x4b

    goto :goto_0

    .line 294
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v0, v0, p1

    aget-short v0, v0, p2

    .line 295
    if-gez v0, :cond_0

    .line 296
    int-to-char v0, p2

    invoke-direct {p0, v0, p1}, Lcom/mrkeyboard/app/MrFuzzy;->subCost(CI)I

    move-result v0

    int-to-short v0, v0

    .line 297
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v1, v1, p1

    aput-short v0, v1, p2

    goto :goto_0
.end method

.method private subCost(CI)I
    .locals 7

    .prologue
    const/16 v6, 0x75

    const/16 v5, 0x6f

    const/16 v4, 0x69

    const/16 v3, 0x65

    const/16 v0, 0x19

    .line 432
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v1, v1, p2

    .line 433
    if-ne p1, v1, :cond_1

    const/4 v0, 0x0

    .line 439
    :cond_0
    :goto_0
    return v0

    .line 434
    :cond_1
    invoke-direct {p0, p2, p1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v2

    if-nez v2, :cond_0

    .line 435
    invoke-static {p1, v1}, Lcom/mrkeyboard/app/MrFuzzy;->phonetic(CC)Z

    move-result v2

    if-nez v2, :cond_0

    .line 436
    if-ne p1, v3, :cond_2

    if-eq v1, v4, :cond_5

    :cond_2
    if-ne p1, v4, :cond_3

    if-eq v1, v3, :cond_5

    :cond_3
    if-ne p1, v5, :cond_4

    if-eq v1, v6, :cond_5

    :cond_4
    if-ne p1, v6, :cond_6

    if-ne v1, v5, :cond_6

    .line 437
    :cond_5
    const/16 v0, 0x2d

    goto :goto_0

    .line 439
    :cond_6
    const/16 v0, 0x4b

    goto :goto_0
.end method

.method private walk(IIIC)V
    .locals 28

    .prologue
    .line 303
    if-ltz p1, :cond_0

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    move/from16 v0, p1

    if-lt v0, v4, :cond_1

    .line 407
    :cond_0
    return-void

    .line 304
    :cond_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    move/from16 v0, p1

    invoke-virtual {v4, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v0, v4, 0xff

    move/from16 v21, v0

    .line 305
    add-int/lit8 v6, p1, 0x1

    .line 306
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v13, v4, p2

    .line 307
    if-lez p2, :cond_4

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v5, p2, -0x1

    aget-object v4, v4, v5

    .line 308
    :goto_0
    move-object/from16 v0, p0

    iget v0, v0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move/from16 v16, v0

    .line 309
    const/4 v5, 0x0

    move/from16 v20, v5

    move-object v12, v4

    :goto_1
    move/from16 v0, v20

    move/from16 v1, v21

    if-ge v0, v1, :cond_0

    .line 310
    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v6, v4, :cond_0

    .line 311
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v5, v6, 0x1

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 312
    const/16 v6, 0xff

    if-ne v4, v6, :cond_2

    .line 313
    add-int/lit8 v4, v5, 0x1

    move-object/from16 v0, p0

    iget v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v6, :cond_0

    .line 314
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

    .line 315
    add-int/lit8 v5, v5, 0x2

    .line 317
    :cond_2
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v6, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    and-int/lit16 v7, v6, 0xff

    .line 318
    and-int/lit16 v6, v7, 0x80

    if-eqz v6, :cond_5

    const/4 v6, 0x1

    move/from16 v19, v6

    .line 319
    :goto_2
    const/4 v6, 0x0

    .line 320
    and-int/lit8 v8, v7, 0x40

    if-eqz v8, :cond_6

    .line 321
    add-int/lit8 v6, v5, 0x2

    move-object/from16 v0, p0

    iget v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v6, v8, :cond_0

    .line 322
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

    .line 323
    add-int/lit8 v7, v5, 0x3

    move/from16 v18, v6

    .line 327
    :goto_3
    const/4 v5, 0x0

    .line 328
    if-eqz v19, :cond_26

    .line 329
    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v7, v5, :cond_0

    .line 330
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v6, v7, 0x1

    invoke-virtual {v5, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 331
    move-object/from16 v0, p0

    iget-boolean v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v7, :cond_3

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v6

    .line 333
    :cond_3
    :goto_4
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    add-int/lit8 v7, v7, 0x1

    move-object/from16 v0, p0

    iput v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v8, 0x2ee0

    if-gt v7, v8, :cond_0

    .line 334
    const/16 v7, 0x100

    if-ge v4, v7, :cond_7

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v7, v7, v4

    move/from16 v17, v7

    .line 335
    :goto_5
    if-nez p2, :cond_a

    .line 336
    const/16 v7, 0x100

    move/from16 v0, v17

    if-ge v0, v7, :cond_1f

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aget-boolean v7, v7, v17

    if-nez v7, :cond_8

    move-object v4, v12

    move-object v5, v13

    .line 309
    :goto_6
    add-int/lit8 v7, v20, 0x1

    move/from16 v20, v7

    move-object v12, v4

    move-object v13, v5

    goto/16 :goto_1

    .line 307
    :cond_4
    const/4 v4, 0x0

    goto/16 :goto_0

    .line 318
    :cond_5
    const/4 v6, 0x0

    move/from16 v19, v6

    goto/16 :goto_2

    .line 325
    :cond_6
    add-int/lit8 v7, v5, 0x1

    move/from16 v18, v6

    goto :goto_3

    .line 334
    :cond_7
    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    move/from16 v17, v7

    goto :goto_5

    .line 337
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

    .line 338
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

    .line 340
    :cond_a
    int-to-char v0, v4

    move/from16 v22, v0

    .line 341
    const/16 v7, 0x100

    if-ge v4, v7, :cond_15

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    aget-char v4, v7, v4

    .line 342
    :goto_7
    move/from16 v0, v17

    move/from16 v1, p3

    move/from16 v2, p2

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrFuzzy;->delCost(III)I

    move-result v23

    .line 344
    const/4 v8, -0x1

    const/4 v7, -0x1

    .line 345
    if-eqz v12, :cond_b

    .line 346
    const/16 v9, 0x100

    move/from16 v0, p4

    if-ge v0, v9, :cond_16

    sget-object v9, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    aget-char v9, v9, p4

    .line 347
    :goto_8
    const/16 v10, 0x63

    if-ne v9, v10, :cond_17

    const/16 v10, 0x68

    if-ne v4, v10, :cond_17

    const/16 v8, 0x78

    .line 352
    :cond_b
    :goto_9
    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v10, p2, 0x1

    aget-object v24, v9, v10

    .line 353
    add-int/lit8 v10, p2, 0x1

    .line 354
    move-object/from16 v0, p0

    iget v9, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    sub-int v9, v10, v9

    .line 355
    move-object/from16 v0, p0

    iget v11, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    add-int/2addr v10, v11

    .line 356
    move/from16 v0, v16

    if-le v10, v0, :cond_25

    move/from16 v15, v16

    .line 357
    :goto_a
    const/high16 v11, 0x100000

    .line 358
    if-gtz v9, :cond_1a

    .line 359
    const/4 v9, 0x0

    aget v9, v13, v9

    add-int v9, v9, v23

    .line 360
    const/high16 v10, 0x100000

    if-le v9, v10, :cond_c

    const/high16 v9, 0x100000

    .line 361
    :cond_c
    const/4 v10, 0x0

    aput v9, v24, v10

    .line 363
    const/4 v10, 0x1

    move v11, v9

    move v9, v10

    .line 367
    :goto_b
    add-int/lit8 v10, v15, 0x1

    move/from16 v0, v16

    if-gt v10, v0, :cond_d

    add-int/lit8 v10, v15, 0x1

    const/high16 v14, 0x100000

    aput v14, v24, v10

    .line 368
    :cond_d
    add-int/lit8 v10, v15, 0x2

    move/from16 v0, v16

    if-gt v10, v0, :cond_e

    add-int/lit8 v10, v15, 0x2

    const/high16 v14, 0x100000

    aput v14, v24, v10

    :cond_e
    move v14, v9

    .line 369
    :goto_c
    if-gt v14, v15, :cond_1b

    .line 370
    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v10, v14, -0x1

    aget-char v25, v9, v10

    .line 371
    add-int/lit8 v9, v14, -0x1

    aget v9, v13, v9

    add-int/lit8 v10, v14, -0x1

    move-object/from16 v0, p0

    move/from16 v1, v17

    invoke-direct {v0, v10, v1}, Lcom/mrkeyboard/app/MrFuzzy;->sub(II)I

    move-result v10

    add-int/2addr v10, v9

    .line 372
    add-int/lit8 v9, v14, -0x1

    aget v9, v24, v9

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    move-object/from16 v26, v0

    add-int/lit8 v27, v14, -0x1

    aget v26, v26, v27

    add-int v9, v9, v26

    .line 373
    if-ge v9, v10, :cond_24

    .line 374
    :goto_d
    aget v10, v13, v14

    add-int v10, v10, v23

    .line 375
    if-ge v10, v9, :cond_23

    .line 376
    :goto_e
    const/4 v9, 0x2

    if-lt v14, v9, :cond_22

    .line 377
    if-eqz v12, :cond_21

    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v26, v14, -0x2

    aget-char v9, v9, v26

    move/from16 v0, v17

    if-ne v0, v9, :cond_21

    move/from16 v0, p3

    move/from16 v1, v25

    if-ne v0, v1, :cond_21

    move/from16 v0, v17

    move/from16 v1, p3

    if-eq v0, v1, :cond_21

    .line 378
    add-int/lit8 v9, v14, -0x2

    aget v9, v12, v9

    add-int/lit8 v9, v9, 0x28

    .line 379
    if-ge v9, v10, :cond_21

    .line 381
    :goto_f
    move-object/from16 v0, p0

    iget-object v10, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoX:[Z

    aget-boolean v10, v10, v14

    if-eqz v10, :cond_f

    const/16 v10, 0x78

    if-eq v4, v10, :cond_10

    :cond_f
    move-object/from16 v0, p0

    iget-object v10, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoC:[Z

    aget-boolean v10, v10, v14

    if-eqz v10, :cond_11

    const/16 v10, 0xe7

    if-ne v4, v10, :cond_11

    .line 382
    :cond_10
    add-int/lit8 v10, v14, -0x2

    aget v10, v13, v10

    add-int/lit8 v10, v10, 0x23

    .line 383
    if-ge v10, v9, :cond_11

    move v9, v10

    .line 386
    :cond_11
    :goto_10
    if-ltz v8, :cond_13

    move/from16 v0, v25

    if-eq v0, v8, :cond_12

    move/from16 v0, v25

    if-ne v0, v7, :cond_13

    .line 387
    :cond_12
    add-int/lit8 v10, v14, -0x1

    aget v10, v12, v10

    add-int/lit8 v10, v10, 0x23

    .line 388
    if-ge v10, v9, :cond_13

    move v9, v10

    .line 390
    :cond_13
    const/high16 v10, 0x100000

    if-le v9, v10, :cond_14

    const/high16 v9, 0x100000

    .line 391
    :cond_14
    aput v9, v24, v14

    .line 392
    if-ge v9, v11, :cond_20

    .line 369
    :goto_11
    add-int/lit8 v10, v14, 0x1

    move v14, v10

    move v11, v9

    goto/16 :goto_c

    .line 341
    :cond_15
    invoke-static/range {v22 .. v22}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v4

    goto/16 :goto_7

    .line 346
    :cond_16
    invoke-static/range {p4 .. p4}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v9

    goto/16 :goto_8

    .line 348
    :cond_17
    const/16 v10, 0x73

    if-ne v9, v10, :cond_18

    const/16 v10, 0x63

    if-ne v4, v10, :cond_18

    const/16 v8, 0x63

    const/16 v7, 0x73

    goto/16 :goto_9

    .line 349
    :cond_18
    const/16 v10, 0x73

    if-ne v9, v10, :cond_19

    const/16 v10, 0x73

    if-ne v4, v10, :cond_19

    const/16 v8, 0x63

    goto/16 :goto_9

    .line 350
    :cond_19
    const/16 v10, 0x78

    if-ne v9, v10, :cond_b

    const/16 v9, 0x63

    if-ne v4, v9, :cond_b

    const/16 v8, 0x73

    const/16 v7, 0x63

    goto/16 :goto_9

    .line 365
    :cond_1a
    add-int/lit8 v10, v9, -0x1

    const/high16 v14, 0x100000

    aput v14, v24, v10

    goto/16 :goto_b

    .line 394
    :cond_1b
    const/16 v4, 0x30

    move/from16 v0, p2

    if-ge v0, v4, :cond_1c

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    aput-char v22, v4, p2

    .line 395
    :cond_1c
    if-eqz v19, :cond_1d

    move/from16 v0, v16

    if-ne v15, v0, :cond_1d

    aget v4, v24, v16

    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mMaxCost:I

    if-gt v4, v7, :cond_1d

    add-int/lit8 v4, p2, 0x1

    const/16 v7, 0x30

    if-gt v4, v7, :cond_1d

    if-lez v5, :cond_1d

    .line 396
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    add-int/lit8 v7, p2, 0x1

    aget v8, v24, v16

    move-object/from16 v0, p0

    invoke-direct {v0, v4, v7, v5, v8}, Lcom/mrkeyboard/app/MrFuzzy;->offer([CIII)V

    .line 398
    :cond_1d
    if-eqz v18, :cond_1f

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mMaxCost:I

    if-gt v11, v4, :cond_1f

    add-int/lit8 v4, p2, 0x1

    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    add-int v5, v5, v16

    if-ge v4, v5, :cond_1f

    add-int/lit8 v4, p2, 0x2

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    array-length v5, v5

    if-ge v4, v5, :cond_1f

    add-int/lit8 v4, p2, 0x1

    const/16 v5, 0x30

    if-ge v4, v5, :cond_1f

    .line 400
    add-int/lit8 v4, p2, 0x1

    move-object/from16 v0, p0

    move/from16 v1, v18

    move/from16 v2, v17

    move/from16 v3, v22

    invoke-direct {v0, v1, v4, v2, v3}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 401
    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v5, 0x2ee0

    if-gt v4, v5, :cond_0

    .line 403
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v5, v4, p2

    .line 404
    if-lez p2, :cond_1e

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v7, p2, -0x1

    aget-object v4, v4, v7

    goto/16 :goto_6

    :cond_1e
    const/4 v4, 0x0

    goto/16 :goto_6

    :cond_1f
    move-object v4, v12

    move-object v5, v13

    goto/16 :goto_6

    :cond_20
    move v9, v11

    goto/16 :goto_11

    :cond_21
    move v9, v10

    goto/16 :goto_f

    :cond_22
    move v9, v10

    goto/16 :goto_10

    :cond_23
    move v10, v9

    goto/16 :goto_e

    :cond_24
    move v9, v10

    goto/16 :goto_d

    :cond_25
    move v15, v10

    goto/16 :goto_a

    :cond_26
    move v6, v7

    goto/16 :goto_4
.end method

.method private walkRoot()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 219
    const/4 v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 220
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v2, v2, v2}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 221
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v1, 0x2ee0

    if-le v0, v1, :cond_0

    .line 225
    :goto_0
    return-void

    .line 222
    :cond_0
    const/4 v0, 0x2

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 223
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v2, v2, v2}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 224
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    goto :goto_0
.end method


# virtual methods
.method emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V
    .locals 10

    .prologue
    const/4 v2, 0x0

    .line 528
    move v7, v2

    :goto_0
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v7, v0, :cond_0

    .line 529
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v4, v0, v7

    .line 530
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

    .line 528
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    .line 533
    :cond_0
    return-void
.end method

.method resultCount()I
    .locals 1

    .prologue
    .line 154
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    return v0
.end method

.method resultScore(I)J
    .locals 2

    .prologue
    .line 156
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v0, v0, p1

    return-wide v0
.end method

.method resultWord(I)Ljava/lang/String;
    .locals 4

    .prologue
    .line 155
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
    .locals 13

    .prologue
    const/16 v12, 0x73

    const/16 v11, 0x63

    const/4 v10, 0x4

    const/4 v1, 0x1

    const/4 v3, 0x0

    .line 159
    invoke-interface {p2}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/16 v2, 0x14

    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v7

    .line 160
    iput v7, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move v6, v3

    .line 161
    :goto_0
    if-ge v6, v7, :cond_4

    .line 162
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    invoke-interface {p2, v6}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    aput-char v2, v0, v6

    .line 164
    if-eqz p1, :cond_1

    invoke-virtual {p1, v6}, Lcom/mrkeyboard/app/WordComposer;->getCodesAt(I)[I

    move-result-object v0

    move-object v5, v0

    .line 165
    :goto_1
    if-eqz v5, :cond_15

    move v0, v1

    move v2, v3

    .line 166
    :goto_2
    array-length v4, v5

    if-ge v0, v4, :cond_0

    const/16 v4, 0x10

    if-ge v2, v4, :cond_0

    .line 167
    aget v4, v5, v0

    .line 168
    if-gtz v4, :cond_2

    .line 173
    :cond_0
    :goto_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aput v2, v0, v6

    .line 174
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v0, v0, v6

    const/4 v2, -0x1

    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([SS)V

    .line 161
    add-int/lit8 v0, v6, 0x1

    move v6, v0

    goto :goto_0

    .line 164
    :cond_1
    const/4 v0, 0x0

    move-object v5, v0

    goto :goto_1

    .line 169
    :cond_2
    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v8

    .line 170
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v4, v4, v6

    if-eq v8, v4, :cond_3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v9, v4, v6

    add-int/lit8 v4, v2, 0x1

    aput-char v8, v9, v2

    move v2, v4

    .line 166
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :cond_4
    move v0, v3

    .line 176
    :goto_4
    if-ge v0, v7, :cond_5

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->insCost(I)I

    move-result v4

    aput v4, v2, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    .line 177
    :cond_5
    const/4 v0, 0x2

    move v2, v0

    :goto_5
    if-gt v2, v7, :cond_c

    .line 178
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v4, v2, -0x2

    aget-char v4, v0, v4

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v5, v2, -0x1

    aget-char v5, v0, v5

    .line 179
    iget-object v6, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoX:[Z

    if-ne v4, v11, :cond_6

    const/16 v0, 0x68

    if-eq v5, v0, :cond_7

    :cond_6
    const/16 v0, 0x6b

    if-ne v4, v0, :cond_a

    if-ne v5, v12, :cond_a

    :cond_7
    move v0, v1

    :goto_6
    aput-boolean v0, v6, v2

    .line 180
    iget-object v6, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoC:[Z

    if-ne v4, v12, :cond_8

    if-eq v5, v12, :cond_9

    if-eq v5, v11, :cond_9

    :cond_8
    const/16 v0, 0x78

    if-ne v4, v0, :cond_b

    if-ne v5, v11, :cond_b

    :cond_9
    move v0, v1

    :goto_7
    aput-boolean v0, v6, v2

    .line 177
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_5

    :cond_a
    move v0, v3

    .line 179
    goto :goto_6

    :cond_b
    move v0, v3

    .line 180
    goto :goto_7

    .line 182
    :cond_c
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->firstLetters()V

    .line 183
    iput v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 184
    iput v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    .line 185
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v0, v0, v3

    .line 186
    aput v3, v0, v3

    .line 187
    :goto_8
    if-gt v1, v7, :cond_d

    const/high16 v2, 0x100000

    add-int/lit8 v3, v1, -0x1

    aget v3, v0, v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    add-int/lit8 v5, v1, -0x1

    aget v4, v4, v5

    add-int/2addr v3, v4

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    aput v2, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_8

    .line 193
    :cond_d
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->isPrefix()Z

    move-result v1

    .line 194
    if-eqz v1, :cond_e

    if-lt v7, v10, :cond_f

    .line 195
    :cond_e
    if-eqz v1, :cond_11

    if-ne v7, v10, :cond_11

    const/16 v0, 0x28

    :goto_9
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 196
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->walkRoot()V

    .line 197
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-nez v0, :cond_f

    if-nez v1, :cond_f

    const/4 v0, 0x6

    if-lt v7, v0, :cond_f

    .line 199
    const/4 v0, 0x7

    if-gt v7, v0, :cond_14

    const/16 v0, 0x64

    :goto_a
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 200
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->walkRoot()V

    .line 203
    :cond_f
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    sput v0, Lcom/mrkeyboard/app/MrFuzzy;->sLastVisits:I

    .line 204
    if-lt v7, v10, :cond_10

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->split()V

    .line 205
    :cond_10
    return-void

    .line 195
    :cond_11
    const/4 v0, 0x3

    if-gt v7, v0, :cond_12

    const/16 v0, 0x2d

    goto :goto_9

    :cond_12
    if-ne v7, v10, :cond_13

    const/16 v0, 0x3c

    goto :goto_9

    :cond_13
    const/16 v0, 0x4b

    goto :goto_9

    .line 199
    :cond_14
    const/16 v0, 0x78

    goto :goto_a

    :cond_15
    move v2, v3

    goto/16 :goto_3
.end method
