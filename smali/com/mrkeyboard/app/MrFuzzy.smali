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

    const/4 v1, 0x1

    const/4 v5, 0x5

    const/4 v2, 0x0

    const/16 v4, 0x14

    .line 101
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

    .line 93
    new-array v0, v5, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    .line 635
    const/16 v0, 0x62

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    .line 636
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    .line 637
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    .line 638
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    .line 102
    iput-object p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    .line 103
    iput p2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    .line 105
    const/4 v0, 0x2

    if-le p2, v0, :cond_3

    .line 106
    invoke-virtual {p1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 107
    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 108
    const/16 v4, 0xc8

    if-lt v0, v4, :cond_2

    if-eqz v3, :cond_0

    if-ne v3, v1, :cond_2

    :cond_0
    move v0, v1

    .line 110
    :goto_0
    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    .line 111
    if-eqz v0, :cond_1

    const/4 v2, 0x2

    :cond_1
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    .line 112
    return-void

    :cond_2
    move v0, v2

    .line 108
    goto :goto_0

    :cond_3
    move v0, v2

    goto :goto_0
.end method

.method public static afterWords(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 132
    const/4 v1, 0x0

    :try_start_0
    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 133
    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 134
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 161
    :cond_0
    :goto_0
    return-void

    .line 135
    :cond_1
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->size()I

    move-result v1

    .line 136
    const/4 v2, 0x2

    if-lt v1, v2, :cond_0

    const/16 v2, 0x14

    if-gt v1, v2, :cond_0

    .line 137
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->getTypedWord()Ljava/lang/CharSequence;

    move-result-object v2

    .line 138
    if-eqz v2, :cond_0

    .line 139
    invoke-static {v2}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    .line 140
    if-eqz v3, :cond_2

    .line 141
    invoke-virtual {v3}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 142
    const/4 v2, 0x0

    array-length v3, v1

    const v4, 0x1fffffff

    const/4 v5, 0x1

    sget-object v6, Lcom/mrkeyboard/app/Dictionary$DataType;->UNIGRAM:Lcom/mrkeyboard/app/Dictionary$DataType;

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/Suggest;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z

    goto :goto_0

    .line 158
    :catch_0
    move-exception v0

    goto :goto_0

    .line 145
    :cond_2
    const/4 v3, 0x3

    if-lt v1, v3, :cond_0

    .line 146
    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/Suggest;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 147
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v1

    .line 148
    if-eqz v1, :cond_0

    .line 149
    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrLength()I

    move-result v1

    invoke-static {v3, v1}, Lcom/mrkeyboard/app/MrFuzzy;->forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;

    move-result-object v1

    .line 150
    if-eqz v1, :cond_0

    .line 151
    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 152
    :try_start_1
    invoke-virtual {v1, p1, v2}, Lcom/mrkeyboard/app/MrFuzzy;->search(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;)V

    .line 153
    invoke-virtual {v1, p0}, Lcom/mrkeyboard/app/MrFuzzy;->emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V

    .line 154
    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 155
    iget v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-lez v2, :cond_3

    iget-object v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    const/4 v3, 0x0

    aget v2, v2, v3

    const/16 v3, 0x2d

    if-gt v2, v3, :cond_3

    .line 156
    const/4 v0, 0x0

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->resultWord(I)Ljava/lang/String;

    move-result-object v0

    :cond_3
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 157
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
    .line 218
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    new-array v1, v0, [C

    .line 219
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

    .line 220
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

    .line 209
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 210
    if-eqz v0, :cond_1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 214
    :cond_0
    :goto_0
    return v1

    .line 211
    :cond_1
    const/16 v0, 0x20

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_2

    move v1, v2

    goto :goto_0

    .line 212
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {p1}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 213
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v5, 0x5

    if-gt v0, v5, :cond_3

    move v0, v1

    .line 214
    :goto_1
    invoke-static {v3, v4, v0}, Lcom/mrkeyboard/app/MrFuzzy;->distance(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v3

    if-le v3, v0, :cond_0

    move v1, v2

    goto :goto_0

    .line 213
    :cond_3
    const/4 v0, 0x2

    goto :goto_1
.end method

.method private static delCost(III)I
    .locals 2

    .prologue
    const/16 v1, 0x68

    const/16 v0, 0x1e

    .line 559
    if-nez p2, :cond_1

    if-ne p0, v1, :cond_1

    .line 563
    :cond_0
    :goto_0
    return v0

    .line 560
    :cond_1
    if-lez p2, :cond_2

    if-eq p0, p1, :cond_0

    .line 561
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

    .line 562
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

    .line 563
    :cond_6
    const/16 v0, 0x3c

    goto :goto_0
.end method

.method static distance(Ljava/lang/String;Ljava/lang/String;I)I
    .locals 12

    .prologue
    .line 225
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v7

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v8

    .line 226
    sub-int v0, v7, v8

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    if-le v0, p2, :cond_0

    add-int/lit8 v0, p2, 0x1

    .line 244
    :goto_0
    return v0

    .line 227
    :cond_0
    add-int/lit8 v0, v8, 0x1

    new-array v5, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v4, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v1, v0, [I

    .line 228
    const/4 v0, 0x0

    :goto_1
    if-gt v0, v8, :cond_1

    aput v0, v4, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 229
    :cond_1
    const/4 v0, 0x1

    move v3, v0

    move-object v6, v4

    move-object v4, v1

    :goto_2
    if-gt v3, v7, :cond_6

    .line 230
    const/4 v0, 0x0

    aput v3, v4, v0

    .line 231
    const/4 v0, 0x0

    aget v1, v4, v0

    .line 232
    const/4 v0, 0x1

    move v2, v0

    :goto_3
    if-gt v2, v8, :cond_4

    .line 233
    add-int/lit8 v0, v3, -0x1

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    add-int/lit8 v9, v2, -0x1

    invoke-virtual {p1, v9}, Ljava/lang/String;->charAt(I)C

    move-result v9

    if-ne v0, v9, :cond_3

    const/4 v0, 0x0

    .line 234
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

    .line 235
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

    .line 236
    add-int/lit8 v9, v2, -0x2

    aget v9, v5, v9

    add-int/lit8 v9, v9, 0x1

    invoke-static {v0, v9}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 238
    :cond_2
    aput v0, v4, v2

    .line 239
    if-ge v0, v1, :cond_7

    .line 232
    :goto_5
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    move v1, v0

    goto :goto_3

    .line 233
    :cond_3
    const/4 v0, 0x1

    goto :goto_4

    .line 241
    :cond_4
    if-le v1, p2, :cond_5

    add-int/lit8 v0, p2, 0x1

    goto/16 :goto_0

    .line 229
    :cond_5
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    move-object v11, v5

    move-object v5, v6

    move-object v6, v4

    move-object v4, v11

    goto :goto_2

    .line 244
    :cond_6
    aget v0, v6, v8

    goto/16 :goto_0

    :cond_7
    move v0, v1

    goto :goto_5
.end method

.method public static finish(Ljava/util/List;Z)Z
    .locals 6
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

    const/4 v5, 0x2

    const/4 v2, 0x1

    .line 176
    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 177
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 178
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 179
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 181
    if-eqz p0, :cond_0

    :try_start_0
    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 205
    :cond_0
    :goto_0
    return p1

    .line 182
    :cond_1
    const/4 v0, 0x0

    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v4

    .line 183
    if-eqz v1, :cond_5

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_5

    .line 185
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v0

    if-le v0, v2, :cond_6

    invoke-virtual {v4}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-virtual {v4}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_6

    .line 186
    invoke-virtual {v1}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    .line 190
    :cond_2
    :goto_1
    const/4 v3, -0x1

    .line 191
    :goto_2
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v2, v0, :cond_8

    .line 192
    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_7

    move v0, v2

    .line 194
    :goto_3
    if-ltz v0, :cond_3

    if-le v0, v5, :cond_5

    .line 195
    :cond_3
    if-le v0, v5, :cond_4

    invoke-interface {p0, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 196
    :cond_4
    const/4 v0, 0x2

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v2

    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-interface {p0, v0, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 199
    :cond_5
    if-eqz p1, :cond_0

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v0, v5, :cond_0

    .line 200
    const/4 v0, 0x1

    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Lcom/mrkeyboard/app/MrFuzzy;->confident(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    goto :goto_0

    .line 187
    :cond_6
    const/4 v0, 0x0

    invoke-virtual {v4, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 188
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
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    move-object v1, v0

    goto :goto_1

    .line 191
    :cond_7
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 202
    :catch_0
    move-exception v0

    goto/16 :goto_0

    :cond_8
    move v0, v3

    goto :goto_3
.end method

.method private firstLetters()V
    .locals 9

    .prologue
    const/16 v8, 0x65

    const/16 v7, 0x63

    const/16 v6, 0x100

    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 367
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([ZZ)V

    .line 368
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v3, v0, v2

    .line 369
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    and-int/lit16 v5, v3, 0xff

    if-ge v3, v6, :cond_1

    move v0, v1

    :goto_0
    aput-boolean v0, v4, v5

    move v0, v2

    .line 370
    :goto_1
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v4, v4, v2

    if-ge v0, v4, :cond_2

    .line 371
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v4, v4, v2

    aget-char v4, v4, v0

    .line 372
    if-ge v4, v6, :cond_0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v4

    .line 370
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    move v0, v2

    .line 369
    goto :goto_0

    .line 374
    :cond_2
    const/16 v0, 0x61

    :goto_2
    const/16 v2, 0x7a

    if-gt v0, v2, :cond_4

    .line 375
    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrFuzzy;->phonetic(CC)Z

    move-result v2

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v2, v0

    .line 374
    :cond_3
    add-int/lit8 v0, v0, 0x1

    int-to-char v0, v0

    goto :goto_2

    .line 377
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    const/16 v2, 0x68

    aput-boolean v1, v0, v2

    .line 378
    if-ne v3, v8, :cond_5

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    const/16 v2, 0x69

    aput-boolean v1, v0, v2

    .line 379
    :cond_5
    const/16 v0, 0x69

    if-ne v3, v0, :cond_6

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v0, v8

    .line 380
    :cond_6
    const/16 v0, 0x6f

    if-ne v3, v0, :cond_7

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    const/16 v2, 0x75

    aput-boolean v1, v0, v2

    .line 381
    :cond_7
    const/16 v0, 0x75

    if-ne v3, v0, :cond_8

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    const/16 v2, 0x6f

    aput-boolean v1, v0, v2

    .line 382
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

    .line 383
    :cond_9
    const/16 v0, 0x78

    if-ne v3, v0, :cond_a

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v0, v7

    .line 384
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

    .line 385
    :cond_b
    return-void
.end method

.method static declared-synchronized forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;
    .locals 3

    .prologue
    .line 115
    const-class v1, Lcom/mrkeyboard/app/MrFuzzy;

    monitor-enter v1

    if-eqz p0, :cond_0

    const/4 v0, 0x2

    if-gt p1, v0, :cond_2

    :cond_0
    const/4 v0, 0x0

    .line 121
    :cond_1
    :goto_0
    monitor-exit v1

    return-object v0

    .line 116
    :cond_2
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;

    .line 117
    if-eqz v0, :cond_3

    iget-object v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    if-ne v2, p0, :cond_3

    iget v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-eq v2, p1, :cond_1

    .line 118
    :cond_3
    new-instance v0, Lcom/mrkeyboard/app/MrFuzzy;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrFuzzy;-><init>(Ljava/nio/ByteBuffer;I)V

    .line 119
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 115
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private insCost(I)I
    .locals 4

    .prologue
    const/16 v0, 0x2d

    .line 549
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v1, v1, p1

    .line 550
    if-lez p1, :cond_1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v3, p1, -0x1

    aget-char v2, v2, v3

    if-ne v2, v1, :cond_1

    const/16 v0, 0x1e

    .line 554
    :cond_0
    :goto_0
    return v0

    .line 551
    :cond_1
    const/16 v2, 0x68

    if-ne v1, v2, :cond_2

    const/16 v0, 0x28

    goto :goto_0

    .line 552
    :cond_2
    if-lez p1, :cond_3

    add-int/lit8 v2, p1, -0x1

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v2

    if-nez v2, :cond_0

    .line 553
    :cond_3
    add-int/lit8 v2, p1, 0x1

    iget v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-ge v2, v3, :cond_4

    add-int/lit8 v2, p1, 0x1

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v1

    if-nez v1, :cond_0

    .line 554
    :cond_4
    const/16 v0, 0x3c

    goto :goto_0
.end method

.method private insert([CIIJI)V
    .locals 8

    .prologue
    const/4 v7, 0x5

    const/4 v1, 0x0

    .line 582
    move v0, v1

    :goto_0
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v0, v2, :cond_2

    .line 583
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aget v2, v2, v0

    if-ne v2, p3, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v2, v2, v0

    invoke-static {v2, p1, p2, p3}, Lcom/mrkeyboard/app/MrFuzzy;->same([C[CII)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 584
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v2, v2, v0

    cmp-long v2, p4, v2

    if-gtz v2, :cond_1

    .line 606
    :cond_0
    :goto_1
    return-void

    .line 585
    :cond_1
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->remove(I)V

    .line 589
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    move v2, v0

    .line 590
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

    .line 582
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 591
    :cond_4
    if-ge v2, v7, :cond_0

    .line 592
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    const/4 v3, 0x4

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 593
    :goto_3
    if-le v0, v2, :cond_5

    .line 594
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v3, v3, v0

    .line 595
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v6, v0, -0x1

    aget-object v5, v5, v6

    aput-object v5, v4, v0

    .line 596
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v5, v0, -0x1

    aput-object v3, v4, v5

    .line 597
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    add-int/lit8 v5, v0, -0x1

    aget v4, v4, v5

    aput v4, v3, v0

    .line 598
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    add-int/lit8 v5, v0, -0x1

    aget-wide v4, v4, v5

    aput-wide v4, v3, v0

    .line 599
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    add-int/lit8 v5, v0, -0x1

    aget v4, v4, v5

    aput v4, v3, v0

    .line 593
    add-int/lit8 v0, v0, -0x1

    goto :goto_3

    .line 601
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v0, v0, v2

    invoke-static {p1, p2, v0, v1, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 602
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aput p3, v0, v2

    .line 603
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aput-wide p4, v0, v2

    .line 604
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    aput p6, v0, v2

    .line 605
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
    .line 519
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v1, v0, p1

    .line 520
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v0, v0, p1

    add-int/lit8 v0, v0, -0x1

    :goto_0
    if-ltz v0, :cond_1

    .line 521
    aget-char v2, v1, v0

    if-ne v2, p2, :cond_0

    const/4 v0, 0x1

    .line 523
    :goto_1
    return v0

    .line 520
    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 523
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private isPrefix()Z
    .locals 2

    .prologue
    .line 324
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

    .line 672
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 673
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 674
    sub-int v1, p2, p1

    const/16 v2, 0x30

    if-le v1, v2, :cond_0

    .line 676
    :goto_0
    return v0

    .line 675
    :cond_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v1, p1, p2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->lookupRec(IIII)V

    .line 676
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    goto :goto_0
.end method

.method private lookupRec(IIII)V
    .locals 10

    .prologue
    const/4 v3, 0x0

    .line 680
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 722
    :cond_0
    return-void

    .line 681
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v8, v0, 0xff

    .line 682
    add-int/lit8 v4, p1, 0x1

    .line 683
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v9, v0, p2

    move v7, v3

    .line 684
    :goto_0
    if-ge v7, v8, :cond_0

    .line 685
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v0, :cond_0

    .line 686
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v4, 0x1

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 687
    const/16 v2, 0xff

    if-ne v0, v2, :cond_2

    .line 688
    add-int/lit8 v0, v1, 0x1

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v0, v2, :cond_0

    .line 689
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

    .line 690
    add-int/lit8 v1, v1, 0x2

    .line 692
    :cond_2
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v2, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v4, v2, 0xff

    .line 693
    and-int/lit16 v2, v4, 0x80

    if-eqz v2, :cond_4

    const/4 v2, 0x1

    move v6, v2

    .line 695
    :goto_1
    and-int/lit8 v2, v4, 0x40

    if-eqz v2, :cond_5

    .line 696
    add-int/lit8 v2, v1, 0x2

    iget v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v2, v5, :cond_0

    .line 697
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

    .line 698
    add-int/lit8 v1, v1, 0x3

    move v5, v2

    .line 703
    :goto_2
    if-eqz v6, :cond_a

    .line 704
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    .line 705
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v1, 0x1

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 706
    iget-boolean v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v4, :cond_9

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v2

    move v4, v2

    move v2, v1

    .line 708
    :goto_3
    const/16 v1, 0x100

    if-ge v0, v1, :cond_6

    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v1, v1, v0

    .line 709
    :goto_4
    if-eq v1, v9, :cond_7

    .line 684
    :cond_3
    :goto_5
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto/16 :goto_0

    :cond_4
    move v6, v3

    .line 693
    goto :goto_1

    .line 700
    :cond_5
    add-int/lit8 v1, v1, 0x1

    move v5, v3

    goto :goto_2

    .line 708
    :cond_6
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    goto :goto_4

    .line 710
    :cond_7
    int-to-char v0, v0

    .line 711
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aput-char v0, v1, p4

    .line 712
    add-int/lit8 v0, p2, 0x1

    if-ne v0, p3, :cond_8

    .line 713
    if-eqz v6, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    if-le v2, v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aget-char v0, v0, v3

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-nez v0, :cond_3

    .line 714
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 715
    add-int/lit8 v0, p4, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 716
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    add-int/lit8 v2, p4, 0x1

    invoke-static {v0, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_5

    .line 718
    :cond_8
    if-eqz v5, :cond_3

    .line 719
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
    .line 575
    invoke-direct {p0, p3, p4}, Lcom/mrkeyboard/app/MrFuzzy;->scoreFor(II)J

    move-result-wide v4

    .line 576
    const-wide/16 v0, 0x0

    cmp-long v0, v4, v0

    if-gtz v0, :cond_0

    .line 578
    :goto_0
    return-void

    .line 577
    :cond_0
    const/4 v2, 0x0

    move-object v0, p0

    move-object v1, p1

    move v3, p2

    move v6, p4

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrFuzzy;->insert([CIIJI)V

    goto :goto_0
.end method

.method private static oneLetterWord(C)Z
    .locals 1

    .prologue
    .line 667
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
    .line 538
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

    .line 542
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

    .line 543
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

    .line 544
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

    .line 542
    :goto_0
    return v0

    .line 544
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private prefixRec(II)Z
    .locals 11

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 328
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    :cond_0
    move v0, v2

    .line 362
    :goto_0
    return v0

    .line 329
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v6, v0, 0xff

    .line 330
    add-int/lit8 v1, p1, 0x1

    .line 331
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v7, v0, p2

    move v5, v2

    move v0, v1

    .line 332
    :goto_1
    if-ge v5, v6, :cond_d

    .line 333
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v0, v1, :cond_2

    move v0, v2

    goto :goto_0

    .line 334
    :cond_2
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v0, 0x1

    invoke-virtual {v4, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 335
    const/16 v4, 0xff

    if-ne v0, v4, :cond_4

    .line 336
    add-int/lit8 v0, v1, 0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v0, v4, :cond_3

    move v0, v2

    goto :goto_0

    .line 337
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

    .line 338
    add-int/lit8 v1, v1, 0x2

    .line 340
    :cond_4
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v8, v4, 0xff

    .line 342
    and-int/lit8 v4, v8, 0x40

    if-eqz v4, :cond_6

    .line 343
    add-int/lit8 v4, v1, 0x2

    iget v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v4, v9, :cond_5

    move v0, v2

    goto :goto_0

    .line 344
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

    .line 345
    add-int/lit8 v1, v1, 0x3

    .line 349
    :goto_2
    and-int/lit16 v8, v8, 0x80

    if-eqz v8, :cond_8

    .line 350
    iget v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v1, v8, :cond_7

    move v0, v2

    goto/16 :goto_0

    .line 347
    :cond_6
    add-int/lit8 v1, v1, 0x1

    move v4, v2

    goto :goto_2

    .line 351
    :cond_7
    add-int/lit8 v1, v1, 0x1

    .line 352
    iget-boolean v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v8, :cond_8

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v1

    .line 354
    :cond_8
    const/16 v8, 0x100

    if-ge v0, v8, :cond_a

    sget-object v8, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v0, v8, v0

    .line 355
    :goto_3
    if-eq v0, v7, :cond_b

    .line 332
    :cond_9
    add-int/lit8 v0, v5, 0x1

    move v5, v0

    move v0, v1

    goto/16 :goto_1

    .line 354
    :cond_a
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v0

    goto :goto_3

    .line 356
    :cond_b
    add-int/lit8 v0, p2, 0x1

    iget v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-ne v0, v8, :cond_c

    .line 357
    if-eqz v4, :cond_9

    move v0, v3

    goto/16 :goto_0

    .line 358
    :cond_c
    if-eqz v4, :cond_9

    add-int/lit8 v0, p2, 0x1

    invoke-direct {p0, v4, v0}, Lcom/mrkeyboard/app/MrFuzzy;->prefixRec(II)Z

    move-result v0

    if-eqz v0, :cond_9

    move v0, v3

    .line 359
    goto/16 :goto_0

    :cond_d
    move v0, v2

    .line 362
    goto/16 :goto_0
.end method

.method private remove(I)V
    .locals 4

    .prologue
    .line 609
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v0, v0, p1

    .line 610
    :goto_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v1, v1, -0x1

    if-ge p1, v1, :cond_0

    .line 611
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v3, p1, 0x1

    aget-object v2, v2, v3

    aput-object v2, v1, p1

    .line 612
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    add-int/lit8 v3, p1, 0x1

    aget v2, v2, v3

    aput v2, v1, p1

    .line 613
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    add-int/lit8 v3, p1, 0x1

    aget-wide v2, v2, v3

    aput-wide v2, v1, p1

    .line 614
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    add-int/lit8 v3, p1, 0x1

    aget v2, v2, v3

    aput v2, v1, p1

    .line 610
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 616
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v2, v2, -0x1

    aput-object v0, v1, v2

    .line 617
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 618
    return-void
.end method

.method private static same([C[CII)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 621
    move v1, v0

    :goto_0
    if-ge v1, p3, :cond_1

    aget-char v2, p0, v1

    add-int v3, p2, v1

    aget-char v3, p1, v3

    if-eq v2, v3, :cond_0

    .line 622
    :goto_1
    return v0

    .line 621
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 622
    :cond_1
    const/4 v0, 0x1

    goto :goto_1
.end method

.method private scoreFor(II)J
    .locals 10

    .prologue
    const-wide v0, 0x41affffffe000000L    # 2.68435455E8

    .line 567
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    const/16 v3, 0x18

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 568
    int-to-double v4, p1

    const-wide/16 v6, 0x1

    add-int/lit8 v2, v2, 0x1

    shl-long v2, v6, v2

    long-to-double v2, v2

    mul-double/2addr v2, v4

    .line 569
    const-wide/high16 v4, 0x4000000000000000L    # 2.0

    neg-int v6, p2

    int-to-double v6, v6

    const-wide/high16 v8, 0x4039000000000000L    # 25.0

    div-double/2addr v6, v8

    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v4

    mul-double/2addr v2, v4

    .line 570
    cmpl-double v4, v2, v0

    if-lez v4, :cond_0

    .line 571
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
    .line 308
    iput p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mMaxCost:I

    .line 309
    div-int/lit8 v0, p1, 0x1e

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    .line 310
    return-void
.end method

.method private skipBigrams(I)I
    .locals 3

    .prologue
    .line 505
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 515
    :cond_0
    :goto_0
    return p1

    .line 506
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    if-eqz v0, :cond_2

    .line 507
    const/4 v0, 0x0

    .line 508
    :goto_1
    add-int/lit8 v1, p1, 0x3

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    add-int/lit8 v1, v0, 0x1

    const/16 v2, 0x2710

    if-ge v0, v2, :cond_0

    .line 509
    add-int/lit8 v0, p1, 0x3

    .line 510
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 p1, v0, 0x1

    invoke-virtual {v2, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    .line 511
    if-eqz v0, :cond_0

    move v0, v1

    .line 512
    goto :goto_1

    .line 515
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

    .line 643
    iget v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    .line 644
    const-wide/16 v4, 0x0

    move v7, v8

    move v3, v2

    .line 646
    :goto_0
    add-int/lit8 v0, v9, -0x2

    if-gt v7, v0, :cond_2

    .line 647
    if-ne v7, v8, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, v2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneLetterWord(C)Z

    move-result v0

    if-nez v0, :cond_1

    .line 646
    :cond_0
    :goto_1
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    .line 648
    :cond_1
    invoke-direct {p0, v2, v7}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v0

    .line 649
    if-lez v0, :cond_0

    .line 650
    iget v10, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 651
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    iget-object v11, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    invoke-static {v1, v2, v11, v2, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 652
    invoke-direct {p0, v7, v9}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v1

    .line 653
    if-lez v1, :cond_0

    .line 654
    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->scoreFor(II)J

    move-result-wide v0

    .line 655
    cmp-long v11, v0, v4

    if-lez v11, :cond_0

    .line 657
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    invoke-static {v3, v2, v4, v2, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 658
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    const/16 v4, 0x20

    aput-char v4, v3, v10

    .line 659
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    add-int/lit8 v5, v10, 0x1

    iget v11, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    invoke-static {v3, v2, v4, v5, v11}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 660
    add-int/lit8 v3, v10, 0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    add-int/2addr v3, v4

    move-wide v4, v0

    goto :goto_1

    .line 663
    :cond_2
    if-lez v3, :cond_3

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    move-object v0, p0

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrFuzzy;->insert([CIIJI)V

    .line 664
    :cond_3
    return-void
.end method

.method private sub(II)I
    .locals 2

    .prologue
    .line 388
    const/16 v0, 0x100

    if-lt p2, v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, p1

    if-ne p2, v0, :cond_1

    const/4 v0, 0x0

    .line 394
    :cond_0
    :goto_0
    return v0

    .line 388
    :cond_1
    const/16 v0, 0x4b

    goto :goto_0

    .line 389
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v0, v0, p1

    aget-short v0, v0, p2

    .line 390
    if-gez v0, :cond_0

    .line 391
    int-to-char v0, p2

    invoke-direct {p0, v0, p1}, Lcom/mrkeyboard/app/MrFuzzy;->subCost(CI)I

    move-result v0

    int-to-short v0, v0

    .line 392
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

    .line 527
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v1, v1, p2

    .line 528
    if-ne p1, v1, :cond_1

    const/4 v0, 0x0

    .line 534
    :cond_0
    :goto_0
    return v0

    .line 529
    :cond_1
    invoke-direct {p0, p2, p1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v2

    if-nez v2, :cond_0

    .line 530
    invoke-static {p1, v1}, Lcom/mrkeyboard/app/MrFuzzy;->phonetic(CC)Z

    move-result v2

    if-nez v2, :cond_0

    .line 531
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

    .line 532
    :cond_5
    const/16 v0, 0x2d

    goto :goto_0

    .line 534
    :cond_6
    const/16 v0, 0x4b

    goto :goto_0
.end method

.method private walk(IIIC)V
    .locals 28

    .prologue
    .line 398
    if-ltz p1, :cond_0

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    move/from16 v0, p1

    if-lt v0, v4, :cond_1

    .line 502
    :cond_0
    return-void

    .line 399
    :cond_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    move/from16 v0, p1

    invoke-virtual {v4, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v0, v4, 0xff

    move/from16 v21, v0

    .line 400
    add-int/lit8 v6, p1, 0x1

    .line 401
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v13, v4, p2

    .line 402
    if-lez p2, :cond_4

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v5, p2, -0x1

    aget-object v4, v4, v5

    .line 403
    :goto_0
    move-object/from16 v0, p0

    iget v0, v0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move/from16 v16, v0

    .line 404
    const/4 v5, 0x0

    move/from16 v20, v5

    move-object v12, v4

    :goto_1
    move/from16 v0, v20

    move/from16 v1, v21

    if-ge v0, v1, :cond_0

    .line 405
    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v6, v4, :cond_0

    .line 406
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v5, v6, 0x1

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 407
    const/16 v6, 0xff

    if-ne v4, v6, :cond_2

    .line 408
    add-int/lit8 v4, v5, 0x1

    move-object/from16 v0, p0

    iget v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v6, :cond_0

    .line 409
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

    .line 410
    add-int/lit8 v5, v5, 0x2

    .line 412
    :cond_2
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v6, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    and-int/lit16 v7, v6, 0xff

    .line 413
    and-int/lit16 v6, v7, 0x80

    if-eqz v6, :cond_5

    const/4 v6, 0x1

    move/from16 v19, v6

    .line 414
    :goto_2
    const/4 v6, 0x0

    .line 415
    and-int/lit8 v8, v7, 0x40

    if-eqz v8, :cond_6

    .line 416
    add-int/lit8 v6, v5, 0x2

    move-object/from16 v0, p0

    iget v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v6, v8, :cond_0

    .line 417
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

    .line 418
    add-int/lit8 v7, v5, 0x3

    move/from16 v18, v6

    .line 422
    :goto_3
    const/4 v5, 0x0

    .line 423
    if-eqz v19, :cond_26

    .line 424
    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v7, v5, :cond_0

    .line 425
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v6, v7, 0x1

    invoke-virtual {v5, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 426
    move-object/from16 v0, p0

    iget-boolean v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v7, :cond_3

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v6

    .line 428
    :cond_3
    :goto_4
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    add-int/lit8 v7, v7, 0x1

    move-object/from16 v0, p0

    iput v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v8, 0x2ee0

    if-gt v7, v8, :cond_0

    .line 429
    const/16 v7, 0x100

    if-ge v4, v7, :cond_7

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v7, v7, v4

    move/from16 v17, v7

    .line 430
    :goto_5
    if-nez p2, :cond_a

    .line 431
    const/16 v7, 0x100

    move/from16 v0, v17

    if-ge v0, v7, :cond_1f

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aget-boolean v7, v7, v17

    if-nez v7, :cond_8

    move-object v4, v12

    move-object v5, v13

    .line 404
    :goto_6
    add-int/lit8 v7, v20, 0x1

    move/from16 v20, v7

    move-object v12, v4

    move-object v13, v5

    goto/16 :goto_1

    .line 402
    :cond_4
    const/4 v4, 0x0

    goto/16 :goto_0

    .line 413
    :cond_5
    const/4 v6, 0x0

    move/from16 v19, v6

    goto/16 :goto_2

    .line 420
    :cond_6
    add-int/lit8 v7, v5, 0x1

    move/from16 v18, v6

    goto :goto_3

    .line 429
    :cond_7
    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    move/from16 v17, v7

    goto :goto_5

    .line 432
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

    .line 433
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

    .line 435
    :cond_a
    int-to-char v0, v4

    move/from16 v22, v0

    .line 436
    const/16 v7, 0x100

    if-ge v4, v7, :cond_15

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    aget-char v4, v7, v4

    .line 437
    :goto_7
    move/from16 v0, v17

    move/from16 v1, p3

    move/from16 v2, p2

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrFuzzy;->delCost(III)I

    move-result v23

    .line 439
    const/4 v8, -0x1

    const/4 v7, -0x1

    .line 440
    if-eqz v12, :cond_b

    .line 441
    const/16 v9, 0x100

    move/from16 v0, p4

    if-ge v0, v9, :cond_16

    sget-object v9, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    aget-char v9, v9, p4

    .line 442
    :goto_8
    const/16 v10, 0x63

    if-ne v9, v10, :cond_17

    const/16 v10, 0x68

    if-ne v4, v10, :cond_17

    const/16 v8, 0x78

    .line 447
    :cond_b
    :goto_9
    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v10, p2, 0x1

    aget-object v24, v9, v10

    .line 448
    add-int/lit8 v10, p2, 0x1

    .line 449
    move-object/from16 v0, p0

    iget v9, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    sub-int v9, v10, v9

    .line 450
    move-object/from16 v0, p0

    iget v11, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    add-int/2addr v10, v11

    .line 451
    move/from16 v0, v16

    if-le v10, v0, :cond_25

    move/from16 v15, v16

    .line 452
    :goto_a
    const/high16 v11, 0x100000

    .line 453
    if-gtz v9, :cond_1a

    .line 454
    const/4 v9, 0x0

    aget v9, v13, v9

    add-int v9, v9, v23

    .line 455
    const/high16 v10, 0x100000

    if-le v9, v10, :cond_c

    const/high16 v9, 0x100000

    .line 456
    :cond_c
    const/4 v10, 0x0

    aput v9, v24, v10

    .line 458
    const/4 v10, 0x1

    move v11, v9

    move v9, v10

    .line 462
    :goto_b
    add-int/lit8 v10, v15, 0x1

    move/from16 v0, v16

    if-gt v10, v0, :cond_d

    add-int/lit8 v10, v15, 0x1

    const/high16 v14, 0x100000

    aput v14, v24, v10

    .line 463
    :cond_d
    add-int/lit8 v10, v15, 0x2

    move/from16 v0, v16

    if-gt v10, v0, :cond_e

    add-int/lit8 v10, v15, 0x2

    const/high16 v14, 0x100000

    aput v14, v24, v10

    :cond_e
    move v14, v9

    .line 464
    :goto_c
    if-gt v14, v15, :cond_1b

    .line 465
    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v10, v14, -0x1

    aget-char v25, v9, v10

    .line 466
    add-int/lit8 v9, v14, -0x1

    aget v9, v13, v9

    add-int/lit8 v10, v14, -0x1

    move-object/from16 v0, p0

    move/from16 v1, v17

    invoke-direct {v0, v10, v1}, Lcom/mrkeyboard/app/MrFuzzy;->sub(II)I

    move-result v10

    add-int/2addr v10, v9

    .line 467
    add-int/lit8 v9, v14, -0x1

    aget v9, v24, v9

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    move-object/from16 v26, v0

    add-int/lit8 v27, v14, -0x1

    aget v26, v26, v27

    add-int v9, v9, v26

    .line 468
    if-ge v9, v10, :cond_24

    .line 469
    :goto_d
    aget v10, v13, v14

    add-int v10, v10, v23

    .line 470
    if-ge v10, v9, :cond_23

    .line 471
    :goto_e
    const/4 v9, 0x2

    if-lt v14, v9, :cond_22

    .line 472
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

    .line 473
    add-int/lit8 v9, v14, -0x2

    aget v9, v12, v9

    add-int/lit8 v9, v9, 0x28

    .line 474
    if-ge v9, v10, :cond_21

    .line 476
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

    .line 477
    :cond_10
    add-int/lit8 v10, v14, -0x2

    aget v10, v13, v10

    add-int/lit8 v10, v10, 0x23

    .line 478
    if-ge v10, v9, :cond_11

    move v9, v10

    .line 481
    :cond_11
    :goto_10
    if-ltz v8, :cond_13

    move/from16 v0, v25

    if-eq v0, v8, :cond_12

    move/from16 v0, v25

    if-ne v0, v7, :cond_13

    .line 482
    :cond_12
    add-int/lit8 v10, v14, -0x1

    aget v10, v12, v10

    add-int/lit8 v10, v10, 0x23

    .line 483
    if-ge v10, v9, :cond_13

    move v9, v10

    .line 485
    :cond_13
    const/high16 v10, 0x100000

    if-le v9, v10, :cond_14

    const/high16 v9, 0x100000

    .line 486
    :cond_14
    aput v9, v24, v14

    .line 487
    if-ge v9, v11, :cond_20

    .line 464
    :goto_11
    add-int/lit8 v10, v14, 0x1

    move v14, v10

    move v11, v9

    goto/16 :goto_c

    .line 436
    :cond_15
    invoke-static/range {v22 .. v22}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v4

    goto/16 :goto_7

    .line 441
    :cond_16
    invoke-static/range {p4 .. p4}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v9

    goto/16 :goto_8

    .line 443
    :cond_17
    const/16 v10, 0x73

    if-ne v9, v10, :cond_18

    const/16 v10, 0x63

    if-ne v4, v10, :cond_18

    const/16 v8, 0x63

    const/16 v7, 0x73

    goto/16 :goto_9

    .line 444
    :cond_18
    const/16 v10, 0x73

    if-ne v9, v10, :cond_19

    const/16 v10, 0x73

    if-ne v4, v10, :cond_19

    const/16 v8, 0x63

    goto/16 :goto_9

    .line 445
    :cond_19
    const/16 v10, 0x78

    if-ne v9, v10, :cond_b

    const/16 v9, 0x63

    if-ne v4, v9, :cond_b

    const/16 v8, 0x73

    const/16 v7, 0x63

    goto/16 :goto_9

    .line 460
    :cond_1a
    add-int/lit8 v10, v9, -0x1

    const/high16 v14, 0x100000

    aput v14, v24, v10

    goto/16 :goto_b

    .line 489
    :cond_1b
    const/16 v4, 0x30

    move/from16 v0, p2

    if-ge v0, v4, :cond_1c

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    aput-char v22, v4, p2

    .line 490
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

    .line 491
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    add-int/lit8 v7, p2, 0x1

    aget v8, v24, v16

    move-object/from16 v0, p0

    invoke-direct {v0, v4, v7, v5, v8}, Lcom/mrkeyboard/app/MrFuzzy;->offer([CIII)V

    .line 493
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

    .line 495
    add-int/lit8 v4, p2, 0x1

    move-object/from16 v0, p0

    move/from16 v1, v18

    move/from16 v2, v17

    move/from16 v3, v22

    invoke-direct {v0, v1, v4, v2, v3}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 496
    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v5, 0x2ee0

    if-gt v4, v5, :cond_0

    .line 498
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v5, v4, p2

    .line 499
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

    .line 314
    const/4 v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 315
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v2, v2, v2}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 316
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v1, 0x2ee0

    if-le v0, v1, :cond_0

    .line 320
    :goto_0
    return-void

    .line 317
    :cond_0
    const/4 v0, 0x2

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 318
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v2, v2, v2}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 319
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    goto :goto_0
.end method


# virtual methods
.method emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V
    .locals 10

    .prologue
    const/4 v2, 0x0

    .line 626
    move v7, v2

    :goto_0
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v7, v0, :cond_0

    .line 627
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v4, v0, v7

    .line 628
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

    .line 626
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    .line 631
    :cond_0
    return-void
.end method

.method resultCount()I
    .locals 1

    .prologue
    .line 249
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    return v0
.end method

.method resultScore(I)J
    .locals 2

    .prologue
    .line 251
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v0, v0, p1

    return-wide v0
.end method

.method resultWord(I)Ljava/lang/String;
    .locals 4

    .prologue
    .line 250
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

    .line 254
    invoke-interface {p2}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/16 v2, 0x14

    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v7

    .line 255
    iput v7, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move v6, v3

    .line 256
    :goto_0
    if-ge v6, v7, :cond_4

    .line 257
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    invoke-interface {p2, v6}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    aput-char v2, v0, v6

    .line 259
    if-eqz p1, :cond_1

    invoke-virtual {p1, v6}, Lcom/mrkeyboard/app/WordComposer;->getCodesAt(I)[I

    move-result-object v0

    move-object v5, v0

    .line 260
    :goto_1
    if-eqz v5, :cond_15

    move v0, v1

    move v2, v3

    .line 261
    :goto_2
    array-length v4, v5

    if-ge v0, v4, :cond_0

    const/16 v4, 0x10

    if-ge v2, v4, :cond_0

    .line 262
    aget v4, v5, v0

    .line 263
    if-gtz v4, :cond_2

    .line 268
    :cond_0
    :goto_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aput v2, v0, v6

    .line 269
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v0, v0, v6

    const/4 v2, -0x1

    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([SS)V

    .line 256
    add-int/lit8 v0, v6, 0x1

    move v6, v0

    goto :goto_0

    .line 259
    :cond_1
    const/4 v0, 0x0

    move-object v5, v0

    goto :goto_1

    .line 264
    :cond_2
    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v8

    .line 265
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v4, v4, v6

    if-eq v8, v4, :cond_3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v9, v4, v6

    add-int/lit8 v4, v2, 0x1

    aput-char v8, v9, v2

    move v2, v4

    .line 261
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :cond_4
    move v0, v3

    .line 271
    :goto_4
    if-ge v0, v7, :cond_5

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->insCost(I)I

    move-result v4

    aput v4, v2, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    .line 272
    :cond_5
    const/4 v0, 0x2

    move v2, v0

    :goto_5
    if-gt v2, v7, :cond_c

    .line 273
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v4, v2, -0x2

    aget-char v4, v0, v4

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v5, v2, -0x1

    aget-char v5, v0, v5

    .line 274
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

    .line 275
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

    .line 272
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_5

    :cond_a
    move v0, v3

    .line 274
    goto :goto_6

    :cond_b
    move v0, v3

    .line 275
    goto :goto_7

    .line 277
    :cond_c
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->firstLetters()V

    .line 278
    iput v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 279
    iput v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    .line 280
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v0, v0, v3

    .line 281
    aput v3, v0, v3

    .line 282
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

    .line 288
    :cond_d
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->isPrefix()Z

    move-result v1

    .line 289
    if-eqz v1, :cond_e

    if-lt v7, v10, :cond_f

    .line 290
    :cond_e
    if-eqz v1, :cond_11

    if-ne v7, v10, :cond_11

    const/16 v0, 0x28

    :goto_9
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 291
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->walkRoot()V

    .line 292
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-nez v0, :cond_f

    if-nez v1, :cond_f

    const/4 v0, 0x6

    if-lt v7, v0, :cond_f

    .line 294
    const/4 v0, 0x7

    if-gt v7, v0, :cond_14

    const/16 v0, 0x64

    :goto_a
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 295
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->walkRoot()V

    .line 298
    :cond_f
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    sput v0, Lcom/mrkeyboard/app/MrFuzzy;->sLastVisits:I

    .line 299
    if-lt v7, v10, :cond_10

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->split()V

    .line 300
    :cond_10
    return-void

    .line 290
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

    .line 294
    :cond_14
    const/16 v0, 0x78

    goto :goto_a

    :cond_15
    move v2, v3

    goto/16 :goto_3
.end method
