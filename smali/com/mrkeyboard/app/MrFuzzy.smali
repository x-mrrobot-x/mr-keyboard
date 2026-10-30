.class public final Lcom/mrkeyboard/app/MrFuzzy;
.super Ljava/lang/Object;
.source "MrFuzzy.java"


# static fields
.field private static final BASE:[C

.field static final C_DEL:I = 0x3c

.field static final C_DEL_DOUBLE:I = 0x1e

.field static final C_DEL_FIRST:I = 0x23

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

    .line 56
    new-array v0, v3, [C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    .line 57
    new-array v0, v3, [C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    .line 60
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v3, :cond_0

    .line 61
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    aput-char v2, v1, v0

    .line 62
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    int-to-char v2, v0

    invoke-static {v2}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v2

    aput-char v2, v1, v0

    .line 60
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 109
    :cond_0
    const/16 v0, 0xc

    filled-new-array {v4, v0}, [I

    move-result-object v0

    sget-object v1, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v1, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    .line 110
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

    .line 114
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 77
    new-array v0, v4, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    .line 78
    const/16 v0, 0x10

    filled-new-array {v4, v0}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    .line 79
    new-array v0, v4, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    .line 80
    const/16 v0, 0x100

    filled-new-array {v4, v0}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Short;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[S

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    .line 81
    new-array v0, v4, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    .line 82
    const/16 v0, 0x100

    new-array v0, v0, [Z

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    .line 84
    new-array v0, v6, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD1:[C

    .line 85
    new-array v0, v6, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD2:[C

    .line 87
    sget-object v0, Lcom/mrkeyboard/app/MrRules;->EMPTY:Lcom/mrkeyboard/app/MrRules;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 88
    const/16 v0, 0x19

    filled-new-array {v0, v6}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    .line 89
    const/16 v0, 0x32

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    .line 98
    const/16 v0, 0x62

    filled-new-array {v5, v0}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    .line 99
    new-array v0, v5, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    .line 100
    new-array v0, v5, [J

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    .line 101
    new-array v0, v5, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    .line 793
    const/16 v0, 0x62

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    .line 794
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    .line 795
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    .line 796
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    .line 115
    iput-object p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    .line 116
    iput p2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    .line 118
    const/4 v0, 0x2

    if-le p2, v0, :cond_3

    .line 119
    invoke-virtual {p1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 120
    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 121
    const/16 v4, 0xc8

    if-lt v0, v4, :cond_2

    if-eqz v3, :cond_0

    if-ne v3, v1, :cond_2

    :cond_0
    move v0, v1

    .line 123
    :goto_0
    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    .line 124
    if-eqz v0, :cond_1

    const/4 v2, 0x2

    :cond_1
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    .line 125
    return-void

    :cond_2
    move v0, v2

    .line 121
    goto :goto_0

    :cond_3
    move v0, v2

    goto :goto_0
.end method

.method public static afterWords(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 145
    const/4 v1, 0x0

    :try_start_0
    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 146
    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 147
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 175
    :cond_0
    :goto_0
    return-void

    .line 148
    :cond_1
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->size()I

    move-result v1

    .line 149
    const/4 v2, 0x2

    if-lt v1, v2, :cond_0

    const/16 v2, 0x14

    if-gt v1, v2, :cond_0

    .line 150
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->getTypedWord()Ljava/lang/CharSequence;

    move-result-object v2

    .line 151
    if-eqz v2, :cond_0

    .line 152
    invoke-static {p1, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->rememberTouches(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V

    .line 153
    invoke-static {v2}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    .line 154
    if-eqz v3, :cond_2

    .line 155
    invoke-virtual {v3}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 156
    const/4 v2, 0x0

    array-length v3, v1

    const v4, 0x1fffffff

    const/4 v5, 0x1

    sget-object v6, Lcom/mrkeyboard/app/Dictionary$DataType;->UNIGRAM:Lcom/mrkeyboard/app/Dictionary$DataType;

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/Suggest;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z

    goto :goto_0

    .line 172
    :catch_0
    move-exception v0

    goto :goto_0

    .line 159
    :cond_2
    const/4 v3, 0x3

    if-lt v1, v3, :cond_0

    .line 160
    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/Suggest;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 161
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v1

    .line 162
    if-eqz v1, :cond_0

    .line 163
    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrLength()I

    move-result v1

    invoke-static {v3, v1}, Lcom/mrkeyboard/app/MrFuzzy;->forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;

    move-result-object v1

    .line 164
    if-eqz v1, :cond_0

    .line 165
    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 166
    :try_start_1
    invoke-virtual {v1, p1, v2}, Lcom/mrkeyboard/app/MrFuzzy;->search(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;)V

    .line 167
    invoke-virtual {v1, p0}, Lcom/mrkeyboard/app/MrFuzzy;->emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V

    .line 168
    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 169
    iget v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-lez v2, :cond_3

    iget-object v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    const/4 v3, 0x0

    aget v2, v2, v3

    const/16 v3, 0x2d

    if-gt v2, v3, :cond_3

    .line 170
    const/4 v0, 0x0

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->resultWord(I)Ljava/lang/String;

    move-result-object v0

    :cond_3
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 171
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
    .line 331
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    new-array v1, v0, [C

    .line 332
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

    .line 333
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

    .line 307
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 308
    if-eqz v0, :cond_1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 327
    :cond_0
    :goto_0
    return v1

    .line 309
    :cond_1
    const/16 v0, 0x20

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_2

    move v1, v3

    goto :goto_0

    .line 310
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-static {p1}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 311
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v2, 0x5

    if-gt v0, v2, :cond_4

    move v0, v1

    .line 312
    :goto_1
    invoke-static {v5, v6, v0}, Lcom/mrkeyboard/app/MrFuzzy;->distance(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v2

    if-le v2, v0, :cond_0

    .line 316
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v4

    if-ne v2, v4, :cond_9

    sget-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_9

    .line 317
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

    .line 319
    :goto_2
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v7

    if-ge v2, v7, :cond_8

    .line 320
    invoke-virtual {v5, v2}, Ljava/lang/String;->charAt(I)C

    move-result v7

    invoke-virtual {v6, v2}, Ljava/lang/String;->charAt(I)C

    move-result v8

    if-ne v7, v8, :cond_5

    .line 319
    :goto_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 311
    :cond_4
    const/4 v0, 0x2

    goto :goto_1

    .line 321
    :cond_5
    invoke-virtual {v6, v2}, Ljava/lang/String;->charAt(I)C

    move-result v7

    invoke-static {v2, v7}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v7

    .line 322
    if-ltz v7, :cond_6

    if-le v7, v1, :cond_7

    :cond_6
    move v1, v3

    goto :goto_0

    .line 323
    :cond_7
    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    .line 325
    :cond_8
    mul-int/lit8 v0, v0, 0x2

    if-le v4, v0, :cond_0

    move v1, v3

    goto :goto_0

    :cond_9
    move v1, v3

    .line 327
    goto :goto_0
.end method

.method private delCost(III)I
    .locals 6

    .prologue
    const/16 v1, 0x23

    const/4 v0, 0x0

    const/16 v5, 0x100

    .line 709
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 710
    if-nez p3, :cond_2

    iget v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v4, 0x3

    if-ne v3, v4, :cond_2

    .line 711
    if-ge p1, v5, :cond_0

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v0, v0, p1

    .line 712
    :cond_0
    if-lez v0, :cond_1

    if-ge v0, v1, :cond_1

    .line 721
    :goto_0
    return v0

    :cond_1
    move v0, v1

    .line 712
    goto :goto_0

    .line 714
    :cond_2
    if-nez p3, :cond_3

    if-ge p1, v5, :cond_3

    iget-object v1, v2, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v1, v1, p1

    if-lez v1, :cond_3

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v0, v0, p1

    goto :goto_0

    .line 715
    :cond_3
    if-lez p3, :cond_4

    if-ne p1, p2, :cond_4

    const/16 v0, 0x1e

    goto :goto_0

    .line 716
    :cond_4
    iget-object v1, v2, Lcom/mrkeyboard/app/MrRules;->silPrev:[C

    iget-object v3, v2, Lcom/mrkeyboard/app/MrRules;->silChar:[C

    .line 717
    :goto_1
    array-length v4, v1

    if-ge v0, v4, :cond_6

    .line 718
    aget-char v4, v3, v0

    if-ne v4, p1, :cond_5

    aget-char v4, v1, v0

    if-ne v4, p2, :cond_5

    iget-object v1, v2, Lcom/mrkeyboard/app/MrRules;->silCost:[S

    aget-short v0, v1, v0

    goto :goto_0

    .line 717
    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 720
    :cond_6
    if-lez p3, :cond_7

    if-ge p1, v5, :cond_7

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentAny:[S

    aget-short v0, v0, p1

    if-lez v0, :cond_7

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentAny:[S

    aget-short v0, v0, p1

    goto :goto_0

    .line 721
    :cond_7
    const/16 v0, 0x3c

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

    .line 270
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 275
    :cond_0
    :goto_0
    return-void

    .line 271
    :cond_1
    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrFuzzy;->isCaseVariant(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 272
    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 273
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 274
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
    .line 338
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v7

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v8

    .line 339
    sub-int v0, v7, v8

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    if-le v0, p2, :cond_0

    add-int/lit8 v0, p2, 0x1

    .line 357
    :goto_0
    return v0

    .line 340
    :cond_0
    add-int/lit8 v0, v8, 0x1

    new-array v5, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v4, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v1, v0, [I

    .line 341
    const/4 v0, 0x0

    :goto_1
    if-gt v0, v8, :cond_1

    aput v0, v4, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 342
    :cond_1
    const/4 v0, 0x1

    move v3, v0

    move-object v6, v4

    move-object v4, v1

    :goto_2
    if-gt v3, v7, :cond_6

    .line 343
    const/4 v0, 0x0

    aput v3, v4, v0

    .line 344
    const/4 v0, 0x0

    aget v1, v4, v0

    .line 345
    const/4 v0, 0x1

    move v2, v0

    :goto_3
    if-gt v2, v8, :cond_4

    .line 346
    add-int/lit8 v0, v3, -0x1

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    add-int/lit8 v9, v2, -0x1

    invoke-virtual {p1, v9}, Ljava/lang/String;->charAt(I)C

    move-result v9

    if-ne v0, v9, :cond_3

    const/4 v0, 0x0

    .line 347
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

    .line 348
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

    .line 349
    add-int/lit8 v9, v2, -0x2

    aget v9, v5, v9

    add-int/lit8 v9, v9, 0x1

    invoke-static {v0, v9}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 351
    :cond_2
    aput v0, v4, v2

    .line 352
    if-ge v0, v1, :cond_7

    .line 345
    :goto_5
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    move v1, v0

    goto :goto_3

    .line 346
    :cond_3
    const/4 v0, 0x1

    goto :goto_4

    .line 354
    :cond_4
    if-le v1, p2, :cond_5

    add-int/lit8 v0, p2, 0x1

    goto/16 :goto_0

    .line 342
    :cond_5
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    move-object v11, v5

    move-object v5, v6

    move-object v6, v4

    move-object v4, v11

    goto :goto_2

    .line 357
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

    .line 209
    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 210
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 211
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 212
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 214
    if-eqz p0, :cond_0

    :try_start_0
    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 258
    :cond_0
    :goto_0
    return p1

    .line 215
    :cond_1
    const/4 v0, 0x0

    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v5

    .line 216
    if-eqz v1, :cond_5

    invoke-virtual {v5, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_5

    .line 218
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

    .line 219
    invoke-virtual {v1}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    .line 223
    :cond_2
    :goto_1
    const/4 v4, -0x1

    move v3, v2

    .line 224
    :goto_2
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v3, v0, :cond_c

    .line 225
    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_8

    move v0, v3

    .line 227
    :goto_3
    if-ltz v0, :cond_3

    if-le v0, v6, :cond_5

    .line 228
    :cond_3
    if-le v0, v6, :cond_4

    invoke-interface {p0, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 229
    :cond_4
    const/4 v0, 0x2

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v3

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-interface {p0, v0, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 234
    :cond_5
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    if-ne v0, v2, :cond_b

    .line 235
    invoke-static {v5}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 236
    if-eqz v0, :cond_b

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_b

    .line 237
    const/4 v1, 0x0

    invoke-virtual {v5, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v1

    if-eqz v1, :cond_9

    .line 238
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

    .line 239
    :goto_4
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v0

    :goto_5
    if-lt v1, v2, :cond_a

    .line 240
    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-interface {p0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 239
    :cond_6
    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_5

    .line 220
    :cond_7
    const/4 v0, 0x0

    invoke-virtual {v5, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 221
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

    .line 224
    :cond_8
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_2

    :cond_9
    move-object v3, v0

    .line 238
    goto :goto_4

    .line 242
    :cond_a
    const/4 v0, 0x1

    invoke-interface {p0, v0, v3}, Ljava/util/List;->add(ILjava/lang/Object;)V

    move p1, v2

    .line 243
    goto/16 :goto_0

    .line 248
    :cond_b
    invoke-static {p0, v5}, Lcom/mrkeyboard/app/MrFuzzy;->demoteCaseVariant(Ljava/util/List;Ljava/lang/String;)V

    .line 251
    invoke-static {p0, v5}, Lcom/mrkeyboard/app/MrFuzzy;->touchOrder(Ljava/util/List;Ljava/lang/String;)V

    .line 252
    if-eqz p1, :cond_0

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v0, v6, :cond_0

    .line 253
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

    .line 255
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

    .line 497
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([ZZ)V

    .line 498
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v3, v0, v2

    .line 499
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    and-int/lit16 v5, v3, 0xff

    if-ge v3, v7, :cond_1

    move v0, v1

    :goto_0
    aput-boolean v0, v4, v5

    move v0, v2

    .line 500
    :goto_1
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v4, v4, v2

    if-ge v0, v4, :cond_2

    .line 501
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v4, v4, v2

    aget-char v4, v4, v0

    .line 502
    if-ge v4, v7, :cond_0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v4

    .line 500
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    move v0, v2

    .line 499
    goto :goto_0

    .line 504
    :cond_2
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    move v0, v2

    .line 505
    :goto_2
    if-ge v0, v7, :cond_5

    .line 507
    invoke-virtual {v4, v0, v3}, Lcom/mrkeyboard/app/MrRules;->pair(CC)I

    move-result v5

    if-nez v5, :cond_3

    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v5, v5, v0

    if-lez v5, :cond_4

    :cond_3
    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v0

    .line 505
    :cond_4
    add-int/lit8 v0, v0, 0x1

    int-to-char v0, v0

    goto :goto_2

    .line 510
    :cond_5
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-le v0, v1, :cond_7

    move v0, v2

    .line 511
    :goto_3
    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    array-length v5, v5

    if-ge v0, v5, :cond_7

    .line 512
    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    aget-char v5, v5, v0

    if-ne v5, v3, :cond_6

    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2b:[C

    aget-char v5, v5, v0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v6, v6, v1

    if-ne v5, v6, :cond_6

    .line 513
    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2d:[C

    aget-char v5, v5, v0

    invoke-static {v5}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v5

    .line 514
    if-ge v5, v7, :cond_6

    iget-object v6, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v6, v5

    .line 511
    :cond_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 518
    :cond_7
    :goto_4
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    array-length v0, v0

    if-ge v2, v0, :cond_9

    .line 519
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    aget-char v0, v0, v2

    if-ne v0, v3, :cond_8

    .line 520
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    aget-char v0, v0, v2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v0

    .line 521
    if-ge v0, v7, :cond_8

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v0

    .line 518
    :cond_8
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    .line 524
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

    .line 525
    :cond_a
    return-void
.end method

.method static declared-synchronized forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;
    .locals 3

    .prologue
    .line 128
    const-class v1, Lcom/mrkeyboard/app/MrFuzzy;

    monitor-enter v1

    if-eqz p0, :cond_0

    const/4 v0, 0x2

    if-gt p1, v0, :cond_2

    :cond_0
    const/4 v0, 0x0

    .line 134
    :cond_1
    :goto_0
    monitor-exit v1

    return-object v0

    .line 129
    :cond_2
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;

    .line 130
    if-eqz v0, :cond_3

    iget-object v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    if-ne v2, p0, :cond_3

    iget v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-eq v2, p1, :cond_1

    .line 131
    :cond_3
    new-instance v0, Lcom/mrkeyboard/app/MrFuzzy;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrFuzzy;-><init>(Ljava/nio/ByteBuffer;I)V

    .line 132
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 128
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private insCost(I)I
    .locals 4

    .prologue
    const/16 v0, 0x2d

    .line 699
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v1, v1, p1

    .line 700
    if-lez p1, :cond_1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v3, p1, -0x1

    aget-char v2, v2, v3

    if-ne v2, v1, :cond_1

    const/16 v0, 0x1e

    .line 704
    :cond_0
    :goto_0
    return v0

    .line 701
    :cond_1
    const/16 v2, 0x100

    if-ge v1, v2, :cond_2

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v2, v2, Lcom/mrkeyboard/app/MrRules;->extra:[Z

    aget-boolean v2, v2, v1

    if-eqz v2, :cond_2

    const/16 v0, 0x28

    goto :goto_0

    .line 702
    :cond_2
    if-lez p1, :cond_3

    add-int/lit8 v2, p1, -0x1

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v2

    if-nez v2, :cond_0

    .line 703
    :cond_3
    add-int/lit8 v2, p1, 0x1

    iget v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-ge v2, v3, :cond_4

    add-int/lit8 v2, p1, 0x1

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v1

    if-nez v1, :cond_0

    .line 704
    :cond_4
    const/16 v0, 0x3c

    goto :goto_0
.end method

.method private insert([CIIJI)V
    .locals 8

    .prologue
    const/4 v7, 0x5

    const/4 v1, 0x0

    .line 740
    move v0, v1

    :goto_0
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v0, v2, :cond_2

    .line 741
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aget v2, v2, v0

    if-ne v2, p3, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v2, v2, v0

    invoke-static {v2, p1, p2, p3}, Lcom/mrkeyboard/app/MrFuzzy;->same([C[CII)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 742
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v2, v2, v0

    cmp-long v2, p4, v2

    if-gtz v2, :cond_1

    .line 764
    :cond_0
    :goto_1
    return-void

    .line 743
    :cond_1
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->remove(I)V

    .line 747
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    move v2, v0

    .line 748
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

    .line 740
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 749
    :cond_4
    if-ge v2, v7, :cond_0

    .line 750
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    const/4 v3, 0x4

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 751
    :goto_3
    if-le v0, v2, :cond_5

    .line 752
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v3, v3, v0

    .line 753
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v6, v0, -0x1

    aget-object v5, v5, v6

    aput-object v5, v4, v0

    .line 754
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v5, v0, -0x1

    aput-object v3, v4, v5

    .line 755
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    add-int/lit8 v5, v0, -0x1

    aget v4, v4, v5

    aput v4, v3, v0

    .line 756
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    add-int/lit8 v5, v0, -0x1

    aget-wide v4, v4, v5

    aput-wide v4, v3, v0

    .line 757
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    add-int/lit8 v5, v0, -0x1

    aget v4, v4, v5

    aput v4, v3, v0

    .line 751
    add-int/lit8 v0, v0, -0x1

    goto :goto_3

    .line 759
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v0, v0, v2

    invoke-static {p1, p2, v0, v1, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 760
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aput p3, v0, v2

    .line 761
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aput-wide p4, v0, v2

    .line 762
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    aput p6, v0, v2

    .line 763
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

    .line 263
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    if-ne v1, v2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 266
    :cond_0
    :goto_0
    return v0

    .line 264
    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 265
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 266
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
    .line 669
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v1, v0, p1

    .line 670
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v0, v0, p1

    add-int/lit8 v0, v0, -0x1

    :goto_0
    if-ltz v0, :cond_1

    .line 671
    aget-char v2, v1, v0

    if-ne v2, p2, :cond_0

    const/4 v0, 0x1

    .line 673
    :goto_1
    return v0

    .line 670
    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 673
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private isPrefix()Z
    .locals 2

    .prologue
    .line 454
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

    .line 830
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 831
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 832
    sub-int v1, p2, p1

    const/16 v2, 0x30

    if-le v1, v2, :cond_0

    .line 834
    :goto_0
    return v0

    .line 833
    :cond_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v1, p1, p2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->lookupRec(IIII)V

    .line 834
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    goto :goto_0
.end method

.method private lookupRec(IIII)V
    .locals 10

    .prologue
    const/4 v3, 0x0

    .line 838
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 880
    :cond_0
    return-void

    .line 839
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v8, v0, 0xff

    .line 840
    add-int/lit8 v4, p1, 0x1

    .line 841
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v9, v0, p2

    move v7, v3

    .line 842
    :goto_0
    if-ge v7, v8, :cond_0

    .line 843
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v0, :cond_0

    .line 844
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v4, 0x1

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 845
    const/16 v2, 0xff

    if-ne v0, v2, :cond_2

    .line 846
    add-int/lit8 v0, v1, 0x1

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v0, v2, :cond_0

    .line 847
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

    .line 848
    add-int/lit8 v1, v1, 0x2

    .line 850
    :cond_2
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v2, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v4, v2, 0xff

    .line 851
    and-int/lit16 v2, v4, 0x80

    if-eqz v2, :cond_4

    const/4 v2, 0x1

    move v6, v2

    .line 853
    :goto_1
    and-int/lit8 v2, v4, 0x40

    if-eqz v2, :cond_5

    .line 854
    add-int/lit8 v2, v1, 0x2

    iget v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v2, v5, :cond_0

    .line 855
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

    .line 856
    add-int/lit8 v1, v1, 0x3

    move v5, v2

    .line 861
    :goto_2
    if-eqz v6, :cond_a

    .line 862
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    .line 863
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v1, 0x1

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 864
    iget-boolean v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v4, :cond_9

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v2

    move v4, v2

    move v2, v1

    .line 866
    :goto_3
    const/16 v1, 0x100

    if-ge v0, v1, :cond_6

    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v1, v1, v0

    .line 867
    :goto_4
    if-eq v1, v9, :cond_7

    .line 842
    :cond_3
    :goto_5
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto/16 :goto_0

    :cond_4
    move v6, v3

    .line 851
    goto :goto_1

    .line 858
    :cond_5
    add-int/lit8 v1, v1, 0x1

    move v5, v3

    goto :goto_2

    .line 866
    :cond_6
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    goto :goto_4

    .line 868
    :cond_7
    int-to-char v0, v0

    .line 869
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aput-char v0, v1, p4

    .line 870
    add-int/lit8 v0, p2, 0x1

    if-ne v0, p3, :cond_8

    .line 871
    if-eqz v6, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    if-le v2, v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aget-char v0, v0, v3

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-nez v0, :cond_3

    .line 872
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 873
    add-int/lit8 v0, p4, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 874
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    add-int/lit8 v2, p4, 0x1

    invoke-static {v0, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_5

    .line 876
    :cond_8
    if-eqz v5, :cond_3

    .line 877
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
    .line 678
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v1, v0, p1

    .line 679
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v2, v0, p1

    .line 680
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v2, :cond_1

    .line 681
    aget-char v3, v1, v0

    if-ne v3, p2, :cond_0

    .line 683
    :goto_1
    return v0

    .line 680
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 683
    :cond_1
    const/4 v0, -0x1

    goto :goto_1
.end method

.method private offer([CIII)V
    .locals 7

    .prologue
    .line 733
    invoke-direct {p0, p3, p4}, Lcom/mrkeyboard/app/MrFuzzy;->scoreFor(II)J

    move-result-wide v4

    .line 734
    const-wide/16 v0, 0x0

    cmp-long v0, v4, v0

    if-gtz v0, :cond_0

    .line 736
    :goto_0
    return-void

    .line 735
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
    .line 825
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

    .line 279
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 287
    :cond_0
    :goto_0
    return v2

    .line 281
    :cond_1
    const/4 v0, 0x0

    move v1, v2

    :goto_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v0, v3, :cond_3

    .line 282
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v3

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v4

    if-eq v3, v4, :cond_2

    .line 283
    if-gez v1, :cond_0

    move v1, v0

    .line 281
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    move v2, v1

    .line 287
    goto :goto_0
.end method

.method private prefixRec(II)Z
    .locals 11

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 458
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    :cond_0
    move v0, v2

    .line 492
    :goto_0
    return v0

    .line 459
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v6, v0, 0xff

    .line 460
    add-int/lit8 v1, p1, 0x1

    .line 461
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v7, v0, p2

    move v5, v2

    move v0, v1

    .line 462
    :goto_1
    if-ge v5, v6, :cond_d

    .line 463
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v0, v1, :cond_2

    move v0, v2

    goto :goto_0

    .line 464
    :cond_2
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v0, 0x1

    invoke-virtual {v4, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 465
    const/16 v4, 0xff

    if-ne v0, v4, :cond_4

    .line 466
    add-int/lit8 v0, v1, 0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v0, v4, :cond_3

    move v0, v2

    goto :goto_0

    .line 467
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

    .line 468
    add-int/lit8 v1, v1, 0x2

    .line 470
    :cond_4
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v8, v4, 0xff

    .line 472
    and-int/lit8 v4, v8, 0x40

    if-eqz v4, :cond_6

    .line 473
    add-int/lit8 v4, v1, 0x2

    iget v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v4, v9, :cond_5

    move v0, v2

    goto :goto_0

    .line 474
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

    .line 475
    add-int/lit8 v1, v1, 0x3

    .line 479
    :goto_2
    and-int/lit16 v8, v8, 0x80

    if-eqz v8, :cond_8

    .line 480
    iget v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v1, v8, :cond_7

    move v0, v2

    goto/16 :goto_0

    .line 477
    :cond_6
    add-int/lit8 v1, v1, 0x1

    move v4, v2

    goto :goto_2

    .line 481
    :cond_7
    add-int/lit8 v1, v1, 0x1

    .line 482
    iget-boolean v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v8, :cond_8

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v1

    .line 484
    :cond_8
    const/16 v8, 0x100

    if-ge v0, v8, :cond_a

    sget-object v8, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v0, v8, v0

    .line 485
    :goto_3
    if-eq v0, v7, :cond_b

    .line 462
    :cond_9
    add-int/lit8 v0, v5, 0x1

    move v5, v0

    move v0, v1

    goto/16 :goto_1

    .line 484
    :cond_a
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v0

    goto :goto_3

    .line 486
    :cond_b
    add-int/lit8 v0, p2, 0x1

    iget v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-ne v0, v8, :cond_c

    .line 487
    if-eqz v4, :cond_9

    move v0, v3

    goto/16 :goto_0

    .line 488
    :cond_c
    if-eqz v4, :cond_9

    add-int/lit8 v0, p2, 0x1

    invoke-direct {p0, v4, v0}, Lcom/mrkeyboard/app/MrFuzzy;->prefixRec(II)Z

    move-result v0

    if-eqz v0, :cond_9

    move v0, v3

    .line 489
    goto/16 :goto_0

    :cond_d
    move v0, v2

    .line 492
    goto/16 :goto_0
.end method

.method private static rememberTouches(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V
    .locals 9

    .prologue
    const/4 v2, 0x0

    .line 179
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    move v4, v2

    .line 180
    :goto_0
    if-ge v4, p2, :cond_3

    .line 181
    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/WordComposer;->getCodesAt(I)[I

    move-result-object v5

    .line 183
    if-eqz v5, :cond_4

    .line 184
    invoke-interface {p1, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v6

    .line 185
    const/4 v0, 0x1

    move v1, v2

    :goto_1
    array-length v3, v5

    if-ge v0, v3, :cond_0

    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    aget-object v3, v3, v4

    array-length v3, v3

    if-ge v1, v3, :cond_0

    .line 186
    aget v3, v5, v0

    if-gtz v3, :cond_1

    .line 191
    :cond_0
    :goto_2
    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchCount:[I

    aput v1, v0, v4

    .line 180
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_0

    .line 187
    :cond_1
    aget v3, v5, v0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    .line 188
    if-eq v7, v6, :cond_2

    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    aget-object v8, v3, v4

    add-int/lit8 v3, v1, 0x1

    aput-char v7, v8, v1

    move v1, v3

    .line 185
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 193
    :cond_3
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    .line 194
    return-void

    :cond_4
    move v1, v2

    goto :goto_2
.end method

.method private remove(I)V
    .locals 4

    .prologue
    .line 767
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v0, v0, p1

    .line 768
    :goto_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v1, v1, -0x1

    if-ge p1, v1, :cond_0

    .line 769
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v3, p1, 0x1

    aget-object v2, v2, v3

    aput-object v2, v1, p1

    .line 770
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    add-int/lit8 v3, p1, 0x1

    aget v2, v2, v3

    aput v2, v1, p1

    .line 771
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    add-int/lit8 v3, p1, 0x1

    aget-wide v2, v2, v3

    aput-wide v2, v1, p1

    .line 772
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    add-int/lit8 v3, p1, 0x1

    aget v2, v2, v3

    aput v2, v1, p1

    .line 768
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 774
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v2, v2, -0x1

    aput-object v0, v1, v2

    .line 775
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 776
    return-void
.end method

.method private static same([C[CII)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 779
    move v1, v0

    :goto_0
    if-ge v1, p3, :cond_1

    aget-char v2, p0, v1

    add-int v3, p2, v1

    aget-char v3, p1, v3

    if-eq v2, v3, :cond_0

    .line 780
    :goto_1
    return v0

    .line 779
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 780
    :cond_1
    const/4 v0, 0x1

    goto :goto_1
.end method

.method private scoreFor(II)J
    .locals 10

    .prologue
    const-wide v0, 0x41affffffe000000L    # 2.68435455E8

    .line 725
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    const/16 v3, 0x18

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 726
    int-to-double v4, p1

    const-wide/16 v6, 0x1

    add-int/lit8 v2, v2, 0x1

    shl-long v2, v6, v2

    long-to-double v2, v2

    mul-double/2addr v2, v4

    .line 727
    const-wide/high16 v4, 0x4000000000000000L    # 2.0

    neg-int v6, p2

    int-to-double v6, v6

    const-wide/high16 v8, 0x4039000000000000L    # 25.0

    div-double/2addr v6, v8

    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v4

    mul-double/2addr v2, v4

    .line 728
    cmpl-double v4, v2, v0

    if-lez v4, :cond_0

    .line 729
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
    .line 438
    iput p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mMaxCost:I

    .line 439
    div-int/lit8 v0, p1, 0x1e

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    .line 440
    return-void
.end method

.method private skipBigrams(I)I
    .locals 3

    .prologue
    .line 655
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 665
    :cond_0
    :goto_0
    return p1

    .line 656
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    if-eqz v0, :cond_2

    .line 657
    const/4 v0, 0x0

    .line 658
    :goto_1
    add-int/lit8 v1, p1, 0x3

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    add-int/lit8 v1, v0, 0x1

    const/16 v2, 0x2710

    if-ge v0, v2, :cond_0

    .line 659
    add-int/lit8 v0, p1, 0x3

    .line 660
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 p1, v0, 0x1

    invoke-virtual {v2, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    .line 661
    if-eqz v0, :cond_0

    move v0, v1

    .line 662
    goto :goto_1

    .line 665
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

    .line 801
    iget v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    .line 802
    const-wide/16 v4, 0x0

    move v7, v8

    move v3, v2

    .line 804
    :goto_0
    add-int/lit8 v0, v9, -0x2

    if-gt v7, v0, :cond_2

    .line 805
    if-ne v7, v8, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, v2

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneLetterWord(C)Z

    move-result v0

    if-nez v0, :cond_1

    .line 804
    :cond_0
    :goto_1
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    .line 806
    :cond_1
    invoke-direct {p0, v2, v7}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v0

    .line 807
    if-lez v0, :cond_0

    .line 808
    iget v10, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 809
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    iget-object v11, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    invoke-static {v1, v2, v11, v2, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 810
    invoke-direct {p0, v7, v9}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v1

    .line 811
    if-lez v1, :cond_0

    .line 812
    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->scoreFor(II)J

    move-result-wide v0

    .line 813
    cmp-long v11, v0, v4

    if-lez v11, :cond_0

    .line 815
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    invoke-static {v3, v2, v4, v2, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 816
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    const/16 v4, 0x20

    aput-char v4, v3, v10

    .line 817
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    add-int/lit8 v5, v10, 0x1

    iget v11, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    invoke-static {v3, v2, v4, v5, v11}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 818
    add-int/lit8 v3, v10, 0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    add-int/2addr v3, v4

    move-wide v4, v0

    goto :goto_1

    .line 821
    :cond_2
    if-lez v3, :cond_3

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    move-object v0, p0

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrFuzzy;->insert([CIIJI)V

    .line 822
    :cond_3
    return-void
.end method

.method private sub(II)I
    .locals 2

    .prologue
    .line 528
    const/16 v0, 0x100

    if-lt p2, v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, p1

    if-ne p2, v0, :cond_1

    const/4 v0, 0x0

    .line 534
    :cond_0
    :goto_0
    return v0

    .line 528
    :cond_1
    const/16 v0, 0x4b

    goto :goto_0

    .line 529
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v0, v0, p1

    aget-short v0, v0, p2

    .line 530
    if-gez v0, :cond_0

    .line 531
    int-to-char v0, p2

    invoke-direct {p0, v0, p1}, Lcom/mrkeyboard/app/MrFuzzy;->subCost(CI)I

    move-result v0

    int-to-short v0, v0

    .line 532
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

    .line 687
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v1, v1, p2

    .line 688
    if-ne p1, v1, :cond_1

    const/4 v0, 0x0

    .line 694
    :cond_0
    :goto_0
    return v0

    .line 689
    :cond_1
    invoke-direct {p0, p2, p1}, Lcom/mrkeyboard/app/MrFuzzy;->nearRank(IC)I

    move-result v2

    .line 690
    if-ltz v2, :cond_3

    if-eqz v2, :cond_0

    if-ne v2, v3, :cond_2

    const/16 v0, 0x1e

    goto :goto_0

    :cond_2
    const/16 v0, 0x23

    goto :goto_0

    .line 691
    :cond_3
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    invoke-virtual {v2, p1, v1}, Lcom/mrkeyboard/app/MrRules;->pair(CC)I

    move-result v1

    .line 692
    if-eq v1, v3, :cond_0

    .line 693
    const/4 v0, 0x2

    if-ne v1, v0, :cond_4

    const/16 v0, 0x2d

    goto :goto_0

    .line 694
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

    .line 298
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 304
    :cond_0
    :goto_0
    return-void

    .line 299
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

    .line 300
    invoke-static {p1, v1}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 301
    if-ltz v2, :cond_0

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    if-ne v3, v2, :cond_0

    .line 302
    invoke-virtual {v1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v1

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v0

    .line 303
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

    .line 291
    const/16 v0, 0x14

    if-lt p0, v0, :cond_1

    move v0, v1

    .line 294
    :cond_0
    :goto_0
    return v0

    .line 292
    :cond_1
    invoke-static {p1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    .line 293
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

    .line 294
    goto :goto_0
.end method

.method private walk(IIIC)V
    .locals 29

    .prologue
    .line 538
    if-ltz p1, :cond_0

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    move/from16 v0, p1

    if-lt v0, v4, :cond_1

    .line 652
    :cond_0
    return-void

    .line 539
    :cond_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    move/from16 v0, p1

    invoke-virtual {v4, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v0, v4, 0xff

    move/from16 v22, v0

    .line 540
    add-int/lit8 v6, p1, 0x1

    .line 541
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v14, v4, p2

    .line 542
    if-lez p2, :cond_4

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v5, p2, -0x1

    aget-object v4, v4, v5

    .line 543
    :goto_0
    move-object/from16 v0, p0

    iget v0, v0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move/from16 v17, v0

    .line 544
    const/4 v5, 0x0

    move/from16 v21, v5

    move-object v13, v4

    :goto_1
    move/from16 v0, v21

    move/from16 v1, v22

    if-ge v0, v1, :cond_0

    .line 545
    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v6, v4, :cond_0

    .line 546
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v5, v6, 0x1

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 547
    const/16 v6, 0xff

    if-ne v4, v6, :cond_2

    .line 548
    add-int/lit8 v4, v5, 0x1

    move-object/from16 v0, p0

    iget v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v6, :cond_0

    .line 549
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

    .line 550
    add-int/lit8 v5, v5, 0x2

    .line 552
    :cond_2
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v6, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    and-int/lit16 v7, v6, 0xff

    .line 553
    and-int/lit16 v6, v7, 0x80

    if-eqz v6, :cond_5

    const/4 v6, 0x1

    move/from16 v20, v6

    .line 554
    :goto_2
    const/4 v6, 0x0

    .line 555
    and-int/lit8 v8, v7, 0x40

    if-eqz v8, :cond_6

    .line 556
    add-int/lit8 v6, v5, 0x2

    move-object/from16 v0, p0

    iget v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v6, v8, :cond_0

    .line 557
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

    .line 558
    add-int/lit8 v7, v5, 0x3

    move/from16 v19, v6

    .line 562
    :goto_3
    const/4 v5, 0x0

    .line 563
    if-eqz v20, :cond_29

    .line 564
    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v7, v5, :cond_0

    .line 565
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v6, v7, 0x1

    invoke-virtual {v5, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 566
    move-object/from16 v0, p0

    iget-boolean v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v7, :cond_3

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v6

    .line 568
    :cond_3
    :goto_4
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    add-int/lit8 v7, v7, 0x1

    move-object/from16 v0, p0

    iput v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v8, 0x2ee0

    if-gt v7, v8, :cond_0

    .line 569
    const/16 v7, 0x100

    if-ge v4, v7, :cond_7

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v7, v7, v4

    move/from16 v18, v7

    .line 570
    :goto_5
    if-nez p2, :cond_c

    .line 571
    const/16 v7, 0x100

    move/from16 v0, v18

    if-lt v0, v7, :cond_8

    move-object v4, v13

    move-object v5, v14

    .line 544
    :goto_6
    add-int/lit8 v7, v21, 0x1

    move/from16 v21, v7

    move-object v13, v4

    move-object v14, v5

    goto/16 :goto_1

    .line 542
    :cond_4
    const/4 v4, 0x0

    goto/16 :goto_0

    .line 553
    :cond_5
    const/4 v6, 0x0

    move/from16 v20, v6

    goto/16 :goto_2

    .line 560
    :cond_6
    add-int/lit8 v7, v5, 0x1

    move/from16 v19, v6

    goto :goto_3

    .line 569
    :cond_7
    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    move/from16 v18, v7

    goto :goto_5

    .line 572
    :cond_8
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v8, 0x3

    if-ne v7, v8, :cond_9

    .line 573
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aget-boolean v7, v7, v18

    if-eqz v7, :cond_c

    move-object v4, v13

    move-object v5, v14

    goto :goto_6

    .line 575
    :cond_9
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aget-boolean v7, v7, v18

    if-nez v7, :cond_a

    move-object v4, v13

    move-object v5, v14

    goto :goto_6

    .line 576
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

    .line 577
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

    .line 580
    :cond_c
    int-to-char v0, v4

    move/from16 v23, v0

    .line 581
    const/16 v7, 0x100

    if-ge v4, v7, :cond_e

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    aget-char v4, v7, v4

    .line 582
    :goto_7
    move-object/from16 v0, p0

    move/from16 v1, v18

    move/from16 v2, p3

    move/from16 v3, p2

    invoke-direct {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrFuzzy;->delCost(III)I

    move-result v24

    .line 584
    const/4 v10, -0x1

    const/4 v9, -0x1

    .line 585
    if-eqz v13, :cond_11

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v7, v7, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    array-length v7, v7

    if-lez v7, :cond_11

    .line 586
    const/16 v7, 0x100

    move/from16 v0, p4

    if-ge v0, v7, :cond_f

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    aget-char v7, v7, p4

    .line 587
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

    .line 588
    const/4 v8, 0x0

    :goto_9
    array-length v0, v11

    move/from16 v16, v0

    move/from16 v0, v16

    if-ge v8, v0, :cond_11

    .line 589
    aget-char v16, v11, v8

    move/from16 v0, v16

    if-ne v0, v7, :cond_d

    aget-char v16, v12, v8

    move/from16 v0, v16

    if-ne v0, v4, :cond_d

    .line 590
    if-gez v10, :cond_10

    aget-char v10, v15, v8

    .line 588
    :cond_d
    :goto_a
    add-int/lit8 v8, v8, 0x1

    goto :goto_9

    .line 581
    :cond_e
    invoke-static/range {v23 .. v23}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v4

    goto :goto_7

    .line 586
    :cond_f
    invoke-static/range {p4 .. p4}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v7

    goto :goto_8

    .line 591
    :cond_10
    if-gez v9, :cond_d

    aget-char v9, v15, v8

    goto :goto_a

    .line 595
    :cond_11
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v8, p2, 0x1

    aget-object v25, v7, v8

    .line 596
    add-int/lit8 v7, p2, 0x1

    .line 597
    move-object/from16 v0, p0

    iget v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    sub-int v8, v7, v8

    .line 598
    move-object/from16 v0, p0

    iget v11, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    add-int/2addr v7, v11

    .line 599
    move/from16 v0, v17

    if-le v7, v0, :cond_28

    move/from16 v16, v17

    .line 600
    :goto_b
    const/high16 v12, 0x100000

    .line 601
    if-gtz v8, :cond_1c

    .line 602
    const/4 v7, 0x0

    aget v7, v14, v7

    add-int v7, v7, v24

    .line 603
    const/high16 v8, 0x100000

    if-le v7, v8, :cond_12

    const/high16 v7, 0x100000

    .line 604
    :cond_12
    const/4 v8, 0x0

    aput v7, v25, v8

    .line 606
    const/4 v8, 0x1

    move v12, v7

    .line 610
    :goto_c
    add-int/lit8 v7, v16, 0x1

    move/from16 v0, v17

    if-gt v7, v0, :cond_13

    add-int/lit8 v7, v16, 0x1

    const/high16 v11, 0x100000

    aput v11, v25, v7

    .line 611
    :cond_13
    add-int/lit8 v7, v16, 0x2

    move/from16 v0, v17

    if-gt v7, v0, :cond_14

    add-int/lit8 v7, v16, 0x2

    const/high16 v11, 0x100000

    aput v11, v25, v7

    .line 612
    :cond_14
    if-nez p2, :cond_1d

    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v11, 0x3

    if-ne v7, v11, :cond_1d

    const/4 v7, 0x1

    :goto_d
    move v15, v8

    .line 613
    :goto_e
    move/from16 v0, v16

    if-gt v15, v0, :cond_1f

    .line 614
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v11, v15, -0x1

    aget-char v26, v8, v11

    .line 616
    if-eqz v7, :cond_1e

    const/high16 v8, 0x100000

    .line 617
    :goto_f
    add-int/lit8 v11, v15, -0x1

    aget v11, v25, v11

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    move-object/from16 v27, v0

    add-int/lit8 v28, v15, -0x1

    aget v27, v27, v28

    add-int v11, v11, v27

    .line 618
    if-ge v11, v8, :cond_15

    move v8, v11

    .line 619
    :cond_15
    aget v11, v14, v15

    add-int v11, v11, v24

    .line 620
    if-ge v11, v8, :cond_27

    .line 621
    :goto_10
    const/4 v8, 0x2

    if-lt v15, v8, :cond_26

    .line 622
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

    .line 623
    add-int/lit8 v8, v15, -0x2

    aget v8, v13, v8

    add-int/lit8 v8, v8, 0x28

    .line 624
    if-ge v8, v11, :cond_25

    .line 626
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

    .line 627
    :cond_17
    add-int/lit8 v11, v15, -0x2

    aget v11, v14, v11

    add-int/lit8 v11, v11, 0x23

    .line 628
    if-ge v11, v8, :cond_18

    move v8, v11

    .line 631
    :cond_18
    :goto_12
    if-ltz v10, :cond_1a

    move/from16 v0, v26

    if-eq v0, v10, :cond_19

    move/from16 v0, v26

    if-ne v0, v9, :cond_1a

    .line 632
    :cond_19
    add-int/lit8 v11, v15, -0x1

    aget v11, v13, v11

    add-int/lit8 v11, v11, 0x23

    .line 633
    if-ge v11, v8, :cond_1a

    move v8, v11

    .line 635
    :cond_1a
    const/high16 v11, 0x100000

    if-le v8, v11, :cond_1b

    const/high16 v8, 0x100000

    .line 636
    :cond_1b
    aput v8, v25, v15

    .line 637
    if-ge v8, v12, :cond_24

    .line 613
    :goto_13
    add-int/lit8 v11, v15, 0x1

    move v15, v11

    move v12, v8

    goto/16 :goto_e

    .line 608
    :cond_1c
    add-int/lit8 v7, v8, -0x1

    const/high16 v11, 0x100000

    aput v11, v25, v7

    goto/16 :goto_c

    .line 612
    :cond_1d
    const/4 v7, 0x0

    goto/16 :goto_d

    .line 616
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

    .line 639
    :cond_1f
    const/16 v4, 0x30

    move/from16 v0, p2

    if-ge v0, v4, :cond_20

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    aput-char v23, v4, p2

    .line 640
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

    .line 641
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    add-int/lit8 v7, p2, 0x1

    aget v8, v25, v17

    move-object/from16 v0, p0

    invoke-direct {v0, v4, v7, v5, v8}, Lcom/mrkeyboard/app/MrFuzzy;->offer([CIII)V

    .line 643
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

    .line 645
    add-int/lit8 v4, p2, 0x1

    move-object/from16 v0, p0

    move/from16 v1, v19

    move/from16 v2, v18

    move/from16 v3, v23

    invoke-direct {v0, v1, v4, v2, v3}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 646
    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v5, 0x2ee0

    if-gt v4, v5, :cond_0

    .line 648
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v5, v4, p2

    .line 649
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

    .line 444
    const/4 v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 445
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v2, v2, v2}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 446
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v1, 0x2ee0

    if-le v0, v1, :cond_0

    .line 450
    :goto_0
    return-void

    .line 447
    :cond_0
    const/4 v0, 0x2

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 448
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v2, v2, v2}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 449
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    goto :goto_0
.end method


# virtual methods
.method emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V
    .locals 10

    .prologue
    const/4 v2, 0x0

    .line 784
    move v7, v2

    :goto_0
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v7, v0, :cond_0

    .line 785
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v4, v0, v7

    .line 786
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

    .line 784
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    .line 789
    :cond_0
    return-void
.end method

.method resultCount()I
    .locals 1

    .prologue
    .line 362
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    return v0
.end method

.method resultScore(I)J
    .locals 2

    .prologue
    .line 364
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v0, v0, p1

    return-wide v0
.end method

.method resultWord(I)Ljava/lang/String;
    .locals 4

    .prologue
    .line 363
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
    .line 367
    invoke-interface {p2}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/16 v1, 0x14

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 368
    iput v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    .line 369
    const/4 v0, 0x0

    move v4, v0

    :goto_0
    if-ge v4, v5, :cond_4

    .line 370
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    invoke-interface {p2, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    aput-char v1, v0, v4

    .line 371
    const/4 v1, 0x0

    .line 372
    if-eqz p1, :cond_1

    invoke-virtual {p1, v4}, Lcom/mrkeyboard/app/WordComposer;->getCodesAt(I)[I

    move-result-object v0

    move-object v3, v0

    .line 373
    :goto_1
    if-eqz v3, :cond_0

    .line 374
    const/4 v0, 0x1

    :goto_2
    array-length v2, v3

    if-ge v0, v2, :cond_0

    const/16 v2, 0x10

    if-ge v1, v2, :cond_0

    .line 375
    aget v2, v3, v0

    .line 376
    if-gtz v2, :cond_2

    .line 381
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aput v1, v0, v4

    .line 382
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v0, v0, v4

    const/4 v1, -0x1

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([SS)V

    .line 369
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_0

    .line 372
    :cond_1
    const/4 v0, 0x0

    move-object v3, v0

    goto :goto_1

    .line 377
    :cond_2
    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v6

    .line 378
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v2, v2, v4

    if-eq v6, v2, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v7, v2, v4

    add-int/lit8 v2, v1, 0x1

    aput-char v6, v7, v1

    move v1, v2

    .line 374
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 384
    :cond_4
    invoke-static {}, Lcom/mrkeyboard/app/MrRules;->get()Lcom/mrkeyboard/app/MrRules;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 385
    const/4 v0, 0x0

    :goto_3
    if-ge v0, v5, :cond_5

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->insCost(I)I

    move-result v2

    aput v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 386
    :cond_5
    const/4 v0, 0x2

    move v3, v0

    :goto_4
    if-gt v3, v5, :cond_9

    .line 387
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v1, v3, -0x2

    aget-char v4, v0, v1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v1, v3, -0x1

    aget-char v6, v0, v1

    .line 388
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 389
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v7, v0, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v8, v0, Lcom/mrkeyboard/app/MrRules;->t2b:[C

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v9, v0, Lcom/mrkeyboard/app/MrRules;->t2d:[C

    .line 390
    const/4 v0, 0x0

    :goto_5
    array-length v10, v7

    if-ge v0, v10, :cond_8

    .line 391
    aget-char v10, v7, v0

    if-ne v10, v4, :cond_6

    aget-char v10, v8, v0

    if-ne v10, v6, :cond_6

    .line 392
    if-nez v2, :cond_7

    aget-char v2, v9, v0

    .line 390
    :cond_6
    :goto_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_5

    .line 393
    :cond_7
    if-nez v1, :cond_6

    aget-char v1, v9, v0

    goto :goto_6

    .line 396
    :cond_8
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD1:[C

    aput-char v2, v0, v3

    .line 397
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD2:[C

    aput-char v1, v0, v3

    .line 386
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_4

    .line 399
    :cond_9
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->firstLetters()V

    .line 400
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 401
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    .line 402
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    const/4 v1, 0x0

    aget-object v1, v0, v1

    .line 403
    const/4 v0, 0x0

    const/4 v2, 0x0

    aput v2, v1, v0

    .line 404
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

    .line 410
    :cond_a
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->isPrefix()Z

    move-result v1

    .line 411
    if-eqz v1, :cond_b

    const/4 v0, 0x4

    if-lt v5, v0, :cond_d

    .line 412
    :cond_b
    if-eqz v1, :cond_f

    const/4 v0, 0x4

    if-ne v5, v0, :cond_f

    const/16 v0, 0x28

    :goto_8
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 413
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->walkRoot()V

    .line 414
    if-nez v1, :cond_c

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v2, 0x2ee0

    if-gt v0, v2, :cond_c

    .line 417
    const/4 v0, 0x6

    if-lt v5, v0, :cond_12

    const/16 v0, 0x1e

    :goto_9
    add-int/lit8 v0, v0, 0x23

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 418
    const/4 v0, 0x3

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 419
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-direct {p0, v0, v2, v3, v4}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 420
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 422
    :cond_c
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-nez v0, :cond_d

    if-nez v1, :cond_d

    const/4 v0, 0x6

    if-lt v5, v0, :cond_d

    .line 424
    const/4 v0, 0x7

    if-gt v5, v0, :cond_13

    const/16 v0, 0x64

    :goto_a
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 425
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->walkRoot()V

    .line 428
    :cond_d
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    sput v0, Lcom/mrkeyboard/app/MrFuzzy;->sLastVisits:I

    .line 429
    const/4 v0, 0x4

    if-lt v5, v0, :cond_e

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->split()V

    .line 430
    :cond_e
    return-void

    .line 412
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

    .line 417
    :cond_12
    const/4 v0, 0x0

    goto :goto_9

    .line 424
    :cond_13
    const/16 v0, 0x78

    goto :goto_a
.end method
