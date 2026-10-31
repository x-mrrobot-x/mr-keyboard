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

.field private mGuard:I

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

.field private final mNearFlat:[C

.field private mOnlyTyped:I

.field private final mOutInfo:[I

.field private final mOutScores:[J

.field private final mOutWords:[C

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

    .line 120
    :cond_0
    const/16 v0, 0xc

    filled-new-array {v4, v0}, [I

    move-result-object v0

    sget-object v1, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v1, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    .line 121
    new-array v0, v4, [I

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchCount:[I

    return-void
.end method

.method constructor <init>(Ljava/nio/ByteBuffer;I)V
    .locals 7

    .prologue
    const/16 v6, 0x15

    const/4 v1, 0x1

    const/4 v2, 0x0

    const/16 v5, 0x14

    const/4 v4, 0x5

    .line 125
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 82
    new-array v0, v5, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    .line 83
    const/16 v0, 0x10

    filled-new-array {v5, v0}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    .line 84
    new-array v0, v5, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    .line 85
    const/16 v0, 0x100

    filled-new-array {v5, v0}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Short;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[S

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    .line 86
    new-array v0, v5, [I

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

    filled-new-array {v4, v0}, [I

    move-result-object v0

    sget-object v3, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v3, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    .line 104
    new-array v0, v4, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    .line 105
    new-array v0, v4, [J

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    .line 106
    new-array v0, v4, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    .line 110
    const/16 v0, 0x140

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearFlat:[C

    .line 111
    const/16 v0, 0x1ea

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutWords:[C

    .line 112
    const/16 v0, 0xb

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    .line 113
    new-array v0, v4, [J

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutScores:[J

    .line 841
    const/16 v0, 0x62

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    .line 842
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    .line 843
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    .line 844
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    .line 126
    iput-object p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    .line 127
    iput p2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    .line 129
    const/4 v0, 0x2

    if-le p2, v0, :cond_3

    .line 130
    invoke-virtual {p1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 131
    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 132
    const/16 v4, 0xc8

    if-lt v0, v4, :cond_2

    if-eqz v3, :cond_0

    if-ne v3, v1, :cond_2

    :cond_0
    move v0, v1

    .line 134
    :goto_0
    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    .line 135
    if-eqz v0, :cond_1

    const/4 v2, 0x2

    :cond_1
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    .line 136
    return-void

    :cond_2
    move v0, v2

    .line 132
    goto :goto_0

    :cond_3
    move v0, v2

    goto :goto_0
.end method

.method public static afterWords(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 156
    const/4 v1, 0x0

    :try_start_0
    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 157
    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 158
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 188
    :cond_0
    :goto_0
    return-void

    .line 159
    :cond_1
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->size()I

    move-result v1

    .line 160
    const/4 v2, 0x2

    if-lt v1, v2, :cond_0

    const/16 v2, 0x14

    if-gt v1, v2, :cond_0

    .line 162
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrRecent;->complete(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V

    .line 163
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->getTypedWord()Ljava/lang/CharSequence;

    move-result-object v2

    .line 164
    if-eqz v2, :cond_0

    .line 165
    invoke-static {p1, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->rememberTouches(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V

    .line 166
    invoke-static {v2}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    .line 167
    if-eqz v3, :cond_2

    .line 168
    invoke-virtual {v3}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 169
    const/4 v2, 0x0

    array-length v3, v1

    const v4, 0x1fffffff

    const/4 v5, 0x1

    sget-object v6, Lcom/mrkeyboard/app/Dictionary$DataType;->UNIGRAM:Lcom/mrkeyboard/app/Dictionary$DataType;

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/Suggest;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z

    goto :goto_0

    .line 185
    :catch_0
    move-exception v0

    goto :goto_0

    .line 172
    :cond_2
    const/4 v3, 0x3

    if-lt v1, v3, :cond_0

    .line 173
    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/Suggest;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 174
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v1

    .line 175
    if-eqz v1, :cond_0

    .line 176
    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrLength()I

    move-result v1

    invoke-static {v3, v1}, Lcom/mrkeyboard/app/MrFuzzy;->forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;

    move-result-object v1

    .line 177
    if-eqz v1, :cond_0

    .line 178
    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 179
    :try_start_1
    invoke-virtual {v1, p1, v2}, Lcom/mrkeyboard/app/MrFuzzy;->search(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;)V

    .line 180
    invoke-virtual {v1, p0}, Lcom/mrkeyboard/app/MrFuzzy;->emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V

    .line 181
    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 182
    iget v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-lez v2, :cond_3

    iget-object v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    const/4 v3, 0x0

    aget v2, v2, v3

    const/16 v3, 0x2d

    if-gt v2, v3, :cond_3

    .line 183
    const/4 v0, 0x0

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->resultWord(I)Ljava/lang/String;

    move-result-object v0

    :cond_3
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 184
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
    .line 344
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    new-array v1, v0, [C

    .line 345
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

    .line 346
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

    .line 320
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 321
    if-eqz v0, :cond_1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 340
    :cond_0
    :goto_0
    return v1

    .line 322
    :cond_1
    const/16 v0, 0x20

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_2

    move v1, v3

    goto :goto_0

    .line 323
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-static {p1}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 324
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v2, 0x5

    if-gt v0, v2, :cond_4

    move v0, v1

    .line 325
    :goto_1
    invoke-static {v5, v6, v0}, Lcom/mrkeyboard/app/MrFuzzy;->distance(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v2

    if-le v2, v0, :cond_0

    .line 329
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v4

    if-ne v2, v4, :cond_9

    sget-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_9

    .line 330
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

    .line 332
    :goto_2
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v7

    if-ge v2, v7, :cond_8

    .line 333
    invoke-virtual {v5, v2}, Ljava/lang/String;->charAt(I)C

    move-result v7

    invoke-virtual {v6, v2}, Ljava/lang/String;->charAt(I)C

    move-result v8

    if-ne v7, v8, :cond_5

    .line 332
    :goto_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 324
    :cond_4
    const/4 v0, 0x2

    goto :goto_1

    .line 334
    :cond_5
    invoke-virtual {v6, v2}, Ljava/lang/String;->charAt(I)C

    move-result v7

    invoke-static {v2, v7}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v7

    .line 335
    if-ltz v7, :cond_6

    if-le v7, v1, :cond_7

    :cond_6
    move v1, v3

    goto :goto_0

    .line 336
    :cond_7
    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    .line 338
    :cond_8
    mul-int/lit8 v0, v0, 0x2

    if-le v4, v0, :cond_0

    move v1, v3

    goto :goto_0

    :cond_9
    move v1, v3

    .line 340
    goto :goto_0
.end method

.method private delCost(III)I
    .locals 6

    .prologue
    const/4 v0, 0x0

    const/16 v5, 0x100

    const/16 v1, 0x1e

    .line 757
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 758
    if-nez p3, :cond_2

    iget v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v4, 0x3

    if-ne v3, v4, :cond_2

    .line 759
    if-ge p1, v5, :cond_0

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v0, v0, p1

    .line 760
    :cond_0
    if-lez v0, :cond_1

    if-ge v0, v1, :cond_1

    .line 769
    :goto_0
    return v0

    :cond_1
    move v0, v1

    .line 760
    goto :goto_0

    .line 762
    :cond_2
    if-nez p3, :cond_3

    if-ge p1, v5, :cond_3

    iget-object v3, v2, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v3, v3, p1

    if-lez v3, :cond_3

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v0, v0, p1

    goto :goto_0

    .line 763
    :cond_3
    if-lez p3, :cond_4

    if-ne p1, p2, :cond_4

    move v0, v1

    goto :goto_0

    .line 764
    :cond_4
    iget-object v1, v2, Lcom/mrkeyboard/app/MrRules;->silPrev:[C

    iget-object v3, v2, Lcom/mrkeyboard/app/MrRules;->silChar:[C

    .line 765
    :goto_1
    array-length v4, v1

    if-ge v0, v4, :cond_6

    .line 766
    aget-char v4, v3, v0

    if-ne v4, p1, :cond_5

    aget-char v4, v1, v0

    if-ne v4, p2, :cond_5

    iget-object v1, v2, Lcom/mrkeyboard/app/MrRules;->silCost:[S

    aget-short v0, v1, v0

    goto :goto_0

    .line 765
    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 768
    :cond_6
    if-lez p3, :cond_7

    if-ge p1, v5, :cond_7

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentAny:[S

    aget-short v0, v0, p1

    if-lez v0, :cond_7

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentAny:[S

    aget-short v0, v0, p1

    goto :goto_0

    .line 769
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

    .line 283
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 288
    :cond_0
    :goto_0
    return-void

    .line 284
    :cond_1
    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrFuzzy;->isCaseVariant(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 285
    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 286
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 287
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
    .line 351
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v7

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v8

    .line 352
    sub-int v0, v7, v8

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    if-le v0, p2, :cond_0

    add-int/lit8 v0, p2, 0x1

    .line 370
    :goto_0
    return v0

    .line 353
    :cond_0
    add-int/lit8 v0, v8, 0x1

    new-array v5, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v4, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v1, v0, [I

    .line 354
    const/4 v0, 0x0

    :goto_1
    if-gt v0, v8, :cond_1

    aput v0, v4, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 355
    :cond_1
    const/4 v0, 0x1

    move v3, v0

    move-object v6, v4

    move-object v4, v1

    :goto_2
    if-gt v3, v7, :cond_6

    .line 356
    const/4 v0, 0x0

    aput v3, v4, v0

    .line 357
    const/4 v0, 0x0

    aget v1, v4, v0

    .line 358
    const/4 v0, 0x1

    move v2, v0

    :goto_3
    if-gt v2, v8, :cond_4

    .line 359
    add-int/lit8 v0, v3, -0x1

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    add-int/lit8 v9, v2, -0x1

    invoke-virtual {p1, v9}, Ljava/lang/String;->charAt(I)C

    move-result v9

    if-ne v0, v9, :cond_3

    const/4 v0, 0x0

    .line 360
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

    .line 361
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

    .line 362
    add-int/lit8 v9, v2, -0x2

    aget v9, v5, v9

    add-int/lit8 v9, v9, 0x1

    invoke-static {v0, v9}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 364
    :cond_2
    aput v0, v4, v2

    .line 365
    if-ge v0, v1, :cond_7

    .line 358
    :goto_5
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    move v1, v0

    goto :goto_3

    .line 359
    :cond_3
    const/4 v0, 0x1

    goto :goto_4

    .line 367
    :cond_4
    if-le v1, p2, :cond_5

    add-int/lit8 v0, p2, 0x1

    goto/16 :goto_0

    .line 355
    :cond_5
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    move-object v11, v5

    move-object v5, v6

    move-object v6, v4

    move-object v4, v11

    goto :goto_2

    .line 370
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

    .line 222
    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 223
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 224
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 225
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 227
    if-eqz p0, :cond_0

    :try_start_0
    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 271
    :cond_0
    :goto_0
    return p1

    .line 228
    :cond_1
    const/4 v0, 0x0

    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v5

    .line 229
    if-eqz v1, :cond_5

    invoke-virtual {v5, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_5

    .line 231
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

    .line 232
    invoke-virtual {v1}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    .line 236
    :cond_2
    :goto_1
    const/4 v4, -0x1

    move v3, v2

    .line 237
    :goto_2
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v3, v0, :cond_c

    .line 238
    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_8

    move v0, v3

    .line 240
    :goto_3
    if-ltz v0, :cond_3

    if-le v0, v6, :cond_5

    .line 241
    :cond_3
    if-le v0, v6, :cond_4

    invoke-interface {p0, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 242
    :cond_4
    const/4 v0, 0x2

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v3

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-interface {p0, v0, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 247
    :cond_5
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    if-ne v0, v2, :cond_b

    .line 248
    invoke-static {v5}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 249
    if-eqz v0, :cond_b

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_b

    .line 250
    const/4 v1, 0x0

    invoke-virtual {v5, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v1

    if-eqz v1, :cond_9

    .line 251
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

    .line 252
    :goto_4
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v0

    :goto_5
    if-lt v1, v2, :cond_a

    .line 253
    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-interface {p0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 252
    :cond_6
    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_5

    .line 233
    :cond_7
    const/4 v0, 0x0

    invoke-virtual {v5, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 234
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

    .line 237
    :cond_8
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_2

    :cond_9
    move-object v3, v0

    .line 251
    goto :goto_4

    .line 255
    :cond_a
    const/4 v0, 0x1

    invoke-interface {p0, v0, v3}, Ljava/util/List;->add(ILjava/lang/Object;)V

    move p1, v2

    .line 256
    goto/16 :goto_0

    .line 261
    :cond_b
    invoke-static {p0, v5}, Lcom/mrkeyboard/app/MrFuzzy;->demoteCaseVariant(Ljava/util/List;Ljava/lang/String;)V

    .line 264
    invoke-static {p0, v5}, Lcom/mrkeyboard/app/MrFuzzy;->touchOrder(Ljava/util/List;Ljava/lang/String;)V

    .line 265
    if-eqz p1, :cond_0

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v0, v6, :cond_0

    .line 266
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

    .line 268
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

    .line 545
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([ZZ)V

    .line 546
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v3, v0, v2

    .line 547
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    and-int/lit16 v5, v3, 0xff

    if-ge v3, v7, :cond_1

    move v0, v1

    :goto_0
    aput-boolean v0, v4, v5

    move v0, v2

    .line 548
    :goto_1
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v4, v4, v2

    if-ge v0, v4, :cond_2

    .line 549
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v4, v4, v2

    aget-char v4, v4, v0

    .line 550
    if-ge v4, v7, :cond_0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v4

    .line 548
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    move v0, v2

    .line 547
    goto :goto_0

    .line 552
    :cond_2
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    move v0, v2

    .line 553
    :goto_2
    if-ge v0, v7, :cond_5

    .line 555
    invoke-virtual {v4, v0, v3}, Lcom/mrkeyboard/app/MrRules;->pair(CC)I

    move-result v5

    if-nez v5, :cond_3

    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v5, v5, v0

    if-lez v5, :cond_4

    :cond_3
    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v0

    .line 553
    :cond_4
    add-int/lit8 v0, v0, 0x1

    int-to-char v0, v0

    goto :goto_2

    .line 558
    :cond_5
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-le v0, v1, :cond_7

    move v0, v2

    .line 559
    :goto_3
    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    array-length v5, v5

    if-ge v0, v5, :cond_7

    .line 560
    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    aget-char v5, v5, v0

    if-ne v5, v3, :cond_6

    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2b:[C

    aget-char v5, v5, v0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v6, v6, v1

    if-ne v5, v6, :cond_6

    .line 561
    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2d:[C

    aget-char v5, v5, v0

    invoke-static {v5}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v5

    .line 562
    if-ge v5, v7, :cond_6

    iget-object v6, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v6, v5

    .line 559
    :cond_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 566
    :cond_7
    :goto_4
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    array-length v0, v0

    if-ge v2, v0, :cond_9

    .line 567
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    aget-char v0, v0, v2

    if-ne v0, v3, :cond_8

    .line 568
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    aget-char v0, v0, v2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v0

    .line 569
    if-ge v0, v7, :cond_8

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v0

    .line 566
    :cond_8
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    .line 572
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

    .line 573
    :cond_a
    return-void
.end method

.method static declared-synchronized forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;
    .locals 3

    .prologue
    .line 139
    const-class v1, Lcom/mrkeyboard/app/MrFuzzy;

    monitor-enter v1

    if-eqz p0, :cond_0

    const/4 v0, 0x2

    if-gt p1, v0, :cond_2

    :cond_0
    const/4 v0, 0x0

    .line 145
    :cond_1
    :goto_0
    monitor-exit v1

    return-object v0

    .line 140
    :cond_2
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;

    .line 141
    if-eqz v0, :cond_3

    iget-object v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    if-ne v2, p0, :cond_3

    iget v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-eq v2, p1, :cond_1

    .line 142
    :cond_3
    new-instance v0, Lcom/mrkeyboard/app/MrFuzzy;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrFuzzy;-><init>(Ljava/nio/ByteBuffer;I)V

    .line 143
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 139
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private insCost(I)I
    .locals 4

    .prologue
    const/16 v0, 0x2d

    .line 747
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v1, v1, p1

    .line 748
    if-lez p1, :cond_1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v3, p1, -0x1

    aget-char v2, v2, v3

    if-ne v2, v1, :cond_1

    const/16 v0, 0x1e

    .line 752
    :cond_0
    :goto_0
    return v0

    .line 749
    :cond_1
    const/16 v2, 0x100

    if-ge v1, v2, :cond_2

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v2, v2, Lcom/mrkeyboard/app/MrRules;->extra:[Z

    aget-boolean v2, v2, v1

    if-eqz v2, :cond_2

    const/16 v0, 0x28

    goto :goto_0

    .line 750
    :cond_2
    if-lez p1, :cond_3

    add-int/lit8 v2, p1, -0x1

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v2

    if-nez v2, :cond_0

    .line 751
    :cond_3
    add-int/lit8 v2, p1, 0x1

    iget v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-ge v2, v3, :cond_4

    add-int/lit8 v2, p1, 0x1

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v1

    if-nez v1, :cond_0

    .line 752
    :cond_4
    const/16 v0, 0x3c

    goto :goto_0
.end method

.method private insert([CIIJI)V
    .locals 8

    .prologue
    const/4 v7, 0x5

    const/4 v1, 0x0

    .line 788
    move v0, v1

    :goto_0
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v0, v2, :cond_2

    .line 789
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aget v2, v2, v0

    if-ne v2, p3, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v2, v2, v0

    invoke-static {v2, p1, p2, p3}, Lcom/mrkeyboard/app/MrFuzzy;->same([C[CII)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 790
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v2, v2, v0

    cmp-long v2, p4, v2

    if-gtz v2, :cond_1

    .line 812
    :cond_0
    :goto_1
    return-void

    .line 791
    :cond_1
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->remove(I)V

    .line 795
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    move v2, v0

    .line 796
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

    .line 788
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 797
    :cond_4
    if-ge v2, v7, :cond_0

    .line 798
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    const/4 v3, 0x4

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 799
    :goto_3
    if-le v0, v2, :cond_5

    .line 800
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v3, v3, v0

    .line 801
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v6, v0, -0x1

    aget-object v5, v5, v6

    aput-object v5, v4, v0

    .line 802
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v5, v0, -0x1

    aput-object v3, v4, v5

    .line 803
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    add-int/lit8 v5, v0, -0x1

    aget v4, v4, v5

    aput v4, v3, v0

    .line 804
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    add-int/lit8 v5, v0, -0x1

    aget-wide v4, v4, v5

    aput-wide v4, v3, v0

    .line 805
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    add-int/lit8 v5, v0, -0x1

    aget v4, v4, v5

    aput v4, v3, v0

    .line 799
    add-int/lit8 v0, v0, -0x1

    goto :goto_3

    .line 807
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v0, v0, v2

    invoke-static {p1, p2, v0, v1, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 808
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aput p3, v0, v2

    .line 809
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aput-wide p4, v0, v2

    .line 810
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    aput p6, v0, v2

    .line 811
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

    .line 276
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    if-ne v1, v2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 279
    :cond_0
    :goto_0
    return v0

    .line 277
    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 278
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 279
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
    .line 717
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v1, v0, p1

    .line 718
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v0, v0, p1

    add-int/lit8 v0, v0, -0x1

    :goto_0
    if-ltz v0, :cond_1

    .line 719
    aget-char v2, v1, v0

    if-ne v2, p2, :cond_0

    const/4 v0, 0x1

    .line 721
    :goto_1
    return v0

    .line 718
    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 721
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private isPrefix()Z
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 493
    iput v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    .line 494
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->prefixRec(II)Z

    move-result v0

    return v0
.end method

.method private lookup(II)I
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 879
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 880
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 881
    sub-int v1, p2, p1

    const/16 v2, 0x30

    if-le v1, v2, :cond_0

    .line 883
    :goto_0
    return v0

    .line 882
    :cond_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v1, p1, p2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->lookupRec(IIII)V

    .line 883
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    goto :goto_0
.end method

.method private lookupRec(IIII)V
    .locals 10

    .prologue
    const/4 v3, 0x0

    .line 887
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 930
    :cond_0
    return-void

    .line 888
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    const/16 v1, 0x2ee0

    if-gt v0, v1, :cond_0

    .line 889
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v8, v0, 0xff

    .line 890
    add-int/lit8 v4, p1, 0x1

    .line 891
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v9, v0, p2

    move v7, v3

    .line 892
    :goto_0
    if-ge v7, v8, :cond_0

    .line 893
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v0, :cond_0

    .line 894
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v4, 0x1

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 895
    const/16 v2, 0xff

    if-ne v0, v2, :cond_2

    .line 896
    add-int/lit8 v0, v1, 0x1

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v0, v2, :cond_0

    .line 897
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

    .line 898
    add-int/lit8 v1, v1, 0x2

    .line 900
    :cond_2
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v2, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v4, v2, 0xff

    .line 901
    and-int/lit16 v2, v4, 0x80

    if-eqz v2, :cond_4

    const/4 v2, 0x1

    move v6, v2

    .line 903
    :goto_1
    and-int/lit8 v2, v4, 0x40

    if-eqz v2, :cond_5

    .line 904
    add-int/lit8 v2, v1, 0x2

    iget v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v2, v5, :cond_0

    .line 905
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

    .line 906
    add-int/lit8 v1, v1, 0x3

    move v5, v2

    .line 911
    :goto_2
    if-eqz v6, :cond_a

    .line 912
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    .line 913
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v1, 0x1

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 914
    iget-boolean v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v4, :cond_9

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v2

    move v4, v2

    move v2, v1

    .line 916
    :goto_3
    const/16 v1, 0x100

    if-ge v0, v1, :cond_6

    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v1, v1, v0

    .line 917
    :goto_4
    if-eq v1, v9, :cond_7

    .line 892
    :cond_3
    :goto_5
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto/16 :goto_0

    :cond_4
    move v6, v3

    .line 901
    goto :goto_1

    .line 908
    :cond_5
    add-int/lit8 v1, v1, 0x1

    move v5, v3

    goto :goto_2

    .line 916
    :cond_6
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    goto :goto_4

    .line 918
    :cond_7
    int-to-char v0, v0

    .line 919
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aput-char v0, v1, p4

    .line 920
    add-int/lit8 v0, p2, 0x1

    if-ne v0, p3, :cond_8

    .line 921
    if-eqz v6, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    if-le v2, v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aget-char v0, v0, v3

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-nez v0, :cond_3

    .line 922
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 923
    add-int/lit8 v0, p4, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 924
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    add-int/lit8 v2, p4, 0x1

    invoke-static {v0, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_5

    .line 926
    :cond_8
    if-eqz v5, :cond_3

    .line 927
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
    .line 726
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v1, v0, p1

    .line 727
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v2, v0, p1

    .line 728
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v2, :cond_1

    .line 729
    aget-char v3, v1, v0

    if-ne v3, p2, :cond_0

    .line 731
    :goto_1
    return v0

    .line 728
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 731
    :cond_1
    const/4 v0, -0x1

    goto :goto_1
.end method

.method private offer([CIII)V
    .locals 7

    .prologue
    .line 781
    invoke-direct {p0, p3, p4}, Lcom/mrkeyboard/app/MrFuzzy;->scoreFor(II)J

    move-result-wide v4

    .line 782
    const-wide/16 v0, 0x0

    cmp-long v0, v4, v0

    if-gtz v0, :cond_0

    .line 784
    :goto_0
    return-void

    .line 783
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
    .line 874
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

    .line 292
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 300
    :cond_0
    :goto_0
    return v2

    .line 294
    :cond_1
    const/4 v0, 0x0

    move v1, v2

    :goto_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v0, v3, :cond_3

    .line 295
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v3

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v4

    if-eq v3, v4, :cond_2

    .line 296
    if-gez v1, :cond_0

    move v1, v0

    .line 294
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    move v2, v1

    .line 300
    goto :goto_0
.end method

.method private prefixRec(II)Z
    .locals 11

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 505
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    :cond_0
    move v0, v2

    .line 540
    :goto_0
    return v0

    .line 506
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    const/16 v1, 0x2ee0

    if-le v0, v1, :cond_2

    move v0, v2

    goto :goto_0

    .line 507
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v6, v0, 0xff

    .line 508
    add-int/lit8 v1, p1, 0x1

    .line 509
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v7, v0, p2

    move v5, v2

    move v0, v1

    .line 510
    :goto_1
    if-ge v5, v6, :cond_e

    .line 511
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v0, v1, :cond_3

    move v0, v2

    goto :goto_0

    .line 512
    :cond_3
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v0, 0x1

    invoke-virtual {v4, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 513
    const/16 v4, 0xff

    if-ne v0, v4, :cond_5

    .line 514
    add-int/lit8 v0, v1, 0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v0, v4, :cond_4

    move v0, v2

    goto :goto_0

    .line 515
    :cond_4
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

    .line 516
    add-int/lit8 v1, v1, 0x2

    .line 518
    :cond_5
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v8, v4, 0xff

    .line 520
    and-int/lit8 v4, v8, 0x40

    if-eqz v4, :cond_7

    .line 521
    add-int/lit8 v4, v1, 0x2

    iget v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v4, v9, :cond_6

    move v0, v2

    goto :goto_0

    .line 522
    :cond_6
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

    .line 523
    add-int/lit8 v1, v1, 0x3

    .line 527
    :goto_2
    and-int/lit16 v8, v8, 0x80

    if-eqz v8, :cond_9

    .line 528
    iget v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v1, v8, :cond_8

    move v0, v2

    goto/16 :goto_0

    .line 525
    :cond_7
    add-int/lit8 v1, v1, 0x1

    move v4, v2

    goto :goto_2

    .line 529
    :cond_8
    add-int/lit8 v1, v1, 0x1

    .line 530
    iget-boolean v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v8, :cond_9

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v1

    .line 532
    :cond_9
    const/16 v8, 0x100

    if-ge v0, v8, :cond_b

    sget-object v8, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v0, v8, v0

    .line 533
    :goto_3
    if-eq v0, v7, :cond_c

    .line 510
    :cond_a
    add-int/lit8 v0, v5, 0x1

    move v5, v0

    move v0, v1

    goto/16 :goto_1

    .line 532
    :cond_b
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v0

    goto :goto_3

    .line 534
    :cond_c
    add-int/lit8 v0, p2, 0x1

    iget v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-ne v0, v8, :cond_d

    .line 535
    if-eqz v4, :cond_a

    move v0, v3

    goto/16 :goto_0

    .line 536
    :cond_d
    if-eqz v4, :cond_a

    add-int/lit8 v0, p2, 0x1

    invoke-direct {p0, v4, v0}, Lcom/mrkeyboard/app/MrFuzzy;->prefixRec(II)Z

    move-result v0

    if-eqz v0, :cond_a

    move v0, v3

    .line 537
    goto/16 :goto_0

    :cond_e
    move v0, v2

    .line 540
    goto/16 :goto_0
.end method

.method private static rememberTouches(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V
    .locals 9

    .prologue
    const/4 v2, 0x0

    .line 192
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    move v4, v2

    .line 193
    :goto_0
    if-ge v4, p2, :cond_3

    .line 194
    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/WordComposer;->getCodesAt(I)[I

    move-result-object v5

    .line 196
    if-eqz v5, :cond_4

    .line 197
    invoke-interface {p1, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v6

    .line 198
    const/4 v0, 0x1

    move v1, v2

    :goto_1
    array-length v3, v5

    if-ge v0, v3, :cond_0

    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    aget-object v3, v3, v4

    array-length v3, v3

    if-ge v1, v3, :cond_0

    .line 199
    aget v3, v5, v0

    if-gtz v3, :cond_1

    .line 204
    :cond_0
    :goto_2
    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchCount:[I

    aput v1, v0, v4

    .line 193
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_0

    .line 200
    :cond_1
    aget v3, v5, v0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    .line 201
    if-eq v7, v6, :cond_2

    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    aget-object v8, v3, v4

    add-int/lit8 v3, v1, 0x1

    aput-char v7, v8, v1

    move v1, v3

    .line 198
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 206
    :cond_3
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    .line 207
    return-void

    :cond_4
    move v1, v2

    goto :goto_2
.end method

.method private remove(I)V
    .locals 4

    .prologue
    .line 815
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v0, v0, p1

    .line 816
    :goto_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v1, v1, -0x1

    if-ge p1, v1, :cond_0

    .line 817
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v3, p1, 0x1

    aget-object v2, v2, v3

    aput-object v2, v1, p1

    .line 818
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    add-int/lit8 v3, p1, 0x1

    aget v2, v2, v3

    aput v2, v1, p1

    .line 819
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    add-int/lit8 v3, p1, 0x1

    aget-wide v2, v2, v3

    aput-wide v2, v1, p1

    .line 820
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    add-int/lit8 v3, p1, 0x1

    aget v2, v2, v3

    aput v2, v1, p1

    .line 816
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 822
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v2, v2, -0x1

    aput-object v0, v1, v2

    .line 823
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 824
    return-void
.end method

.method private static same([C[CII)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 827
    move v1, v0

    :goto_0
    if-ge v1, p3, :cond_1

    aget-char v2, p0, v1

    add-int v3, p2, v1

    aget-char v3, p1, v3

    if-eq v2, v3, :cond_0

    .line 828
    :goto_1
    return v0

    .line 827
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 828
    :cond_1
    const/4 v0, 0x1

    goto :goto_1
.end method

.method private scoreFor(II)J
    .locals 10

    .prologue
    const-wide v0, 0x41affffffe000000L    # 2.68435455E8

    .line 773
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    const/16 v3, 0x18

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 774
    int-to-double v4, p1

    const-wide/16 v6, 0x1

    add-int/lit8 v2, v2, 0x1

    shl-long v2, v6, v2

    long-to-double v2, v2

    mul-double/2addr v2, v4

    .line 775
    const-wide/high16 v4, 0x4000000000000000L    # 2.0

    neg-int v6, p2

    int-to-double v6, v6

    const-wide/high16 v8, 0x4039000000000000L    # 25.0

    div-double/2addr v6, v8

    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v4

    mul-double/2addr v2, v4

    .line 776
    cmpl-double v4, v2, v0

    if-lez v4, :cond_0

    .line 777
    :goto_0
    double-to-long v0, v0

    return-wide v0

    :cond_0
    move-wide v0, v2

    goto :goto_0
.end method

.method private searchNative()Z
    .locals 11

    .prologue
    const/4 v10, 0x0

    .line 451
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move v0, v10

    .line 452
    :goto_0
    if-ge v0, v2, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v1, v1, v0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearFlat:[C

    mul-int/lit8 v4, v0, 0x10

    const/16 v5, 0x10

    invoke-static {v1, v10, v3, v4, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 453
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearFlat:[C

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    iget-object v6, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v7, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutWords:[C

    iget-object v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    iget-object v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutScores:[J

    invoke-static/range {v0 .. v9}, Lcom/mrkeyboard/app/MrNative;->search(Ljava/nio/ByteBuffer;II[C[C[ILcom/mrkeyboard/app/MrRules;[C[I[J)I

    move-result v1

    .line 454
    if-ltz v1, :cond_1

    const/4 v0, 0x5

    if-le v1, v0, :cond_2

    :cond_1
    move v0, v10

    .line 468
    :goto_1
    return v0

    :cond_2
    move v0, v10

    .line 455
    :goto_2
    if-ge v0, v1, :cond_5

    .line 456
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    mul-int/lit8 v3, v0, 0x2

    add-int/lit8 v3, v3, 0x1

    aget v2, v2, v3

    .line 457
    if-ltz v2, :cond_3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v3, v3, v0

    array-length v3, v3

    if-le v2, v3, :cond_4

    :cond_3
    move v0, v10

    goto :goto_1

    .line 455
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 459
    :cond_5
    iput v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    move v0, v10

    .line 460
    :goto_3
    if-ge v0, v1, :cond_6

    .line 461
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    mul-int/lit8 v3, v0, 0x2

    add-int/lit8 v3, v3, 0x1

    aget v2, v2, v3

    .line 462
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutWords:[C

    mul-int/lit8 v4, v0, 0x62

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v5, v5, v0

    invoke-static {v3, v4, v5, v10, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 463
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aput v2, v3, v0

    .line 464
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    mul-int/lit8 v4, v0, 0x2

    add-int/lit8 v4, v4, 0x2

    aget v3, v3, v4

    aput v3, v2, v0

    .line 465
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutScores:[J

    aget-wide v4, v3, v0

    aput-wide v4, v2, v0

    .line 460
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 467
    :cond_6
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    aget v0, v0, v10

    sput v0, Lcom/mrkeyboard/app/MrFuzzy;->sLastVisits:I

    .line 468
    const/4 v0, 0x1

    goto :goto_1
.end method

.method private setMaxCost(I)V
    .locals 1

    .prologue
    .line 477
    iput p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mMaxCost:I

    .line 478
    div-int/lit8 v0, p1, 0x1e

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    .line 479
    return-void
.end method

.method private skipBigrams(I)I
    .locals 3

    .prologue
    .line 703
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 713
    :cond_0
    :goto_0
    return p1

    .line 704
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    if-eqz v0, :cond_2

    .line 705
    const/4 v0, 0x0

    .line 706
    :goto_1
    add-int/lit8 v1, p1, 0x3

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    add-int/lit8 v1, v0, 0x1

    const/16 v2, 0x2710

    if-ge v0, v2, :cond_0

    .line 707
    add-int/lit8 v0, p1, 0x3

    .line 708
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 p1, v0, 0x1

    invoke-virtual {v2, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    .line 709
    if-eqz v0, :cond_0

    move v0, v1

    .line 710
    goto :goto_1

    .line 713
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

    .line 849
    iget v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    .line 850
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    .line 851
    const-wide/16 v4, 0x0

    move v7, v8

    move v3, v2

    .line 853
    :goto_0
    add-int/lit8 v0, v9, -0x2

    if-gt v7, v0, :cond_2

    .line 854
    if-ne v7, v8, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, v2

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneLetterWord(C)Z

    move-result v0

    if-nez v0, :cond_1

    .line 853
    :cond_0
    :goto_1
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    .line 855
    :cond_1
    invoke-direct {p0, v2, v7}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v0

    .line 856
    if-lez v0, :cond_0

    .line 857
    iget v10, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 858
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    iget-object v11, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    invoke-static {v1, v2, v11, v2, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 859
    invoke-direct {p0, v7, v9}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v1

    .line 860
    if-lez v1, :cond_0

    .line 861
    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->scoreFor(II)J

    move-result-wide v0

    .line 862
    cmp-long v11, v0, v4

    if-lez v11, :cond_0

    .line 864
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    invoke-static {v3, v2, v4, v2, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 865
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    const/16 v4, 0x20

    aput-char v4, v3, v10

    .line 866
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    add-int/lit8 v5, v10, 0x1

    iget v11, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    invoke-static {v3, v2, v4, v5, v11}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 867
    add-int/lit8 v3, v10, 0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    add-int/2addr v3, v4

    move-wide v4, v0

    goto :goto_1

    .line 870
    :cond_2
    if-lez v3, :cond_3

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    move-object v0, p0

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrFuzzy;->insert([CIIJI)V

    .line 871
    :cond_3
    return-void
.end method

.method private sub(II)I
    .locals 2

    .prologue
    .line 576
    const/16 v0, 0x100

    if-lt p2, v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, p1

    if-ne p2, v0, :cond_1

    const/4 v0, 0x0

    .line 582
    :cond_0
    :goto_0
    return v0

    .line 576
    :cond_1
    const/16 v0, 0x4b

    goto :goto_0

    .line 577
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v0, v0, p1

    aget-short v0, v0, p2

    .line 578
    if-gez v0, :cond_0

    .line 579
    int-to-char v0, p2

    invoke-direct {p0, v0, p1}, Lcom/mrkeyboard/app/MrFuzzy;->subCost(CI)I

    move-result v0

    int-to-short v0, v0

    .line 580
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

    .line 735
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v1, v1, p2

    .line 736
    if-ne p1, v1, :cond_1

    const/4 v0, 0x0

    .line 742
    :cond_0
    :goto_0
    return v0

    .line 737
    :cond_1
    invoke-direct {p0, p2, p1}, Lcom/mrkeyboard/app/MrFuzzy;->nearRank(IC)I

    move-result v2

    .line 738
    if-ltz v2, :cond_3

    if-eqz v2, :cond_0

    if-ne v2, v3, :cond_2

    const/16 v0, 0x1e

    goto :goto_0

    :cond_2
    const/16 v0, 0x23

    goto :goto_0

    .line 739
    :cond_3
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    invoke-virtual {v2, p1, v1}, Lcom/mrkeyboard/app/MrRules;->pair(CC)I

    move-result v1

    .line 740
    if-eq v1, v3, :cond_0

    .line 741
    const/4 v0, 0x2

    if-ne v1, v0, :cond_4

    const/16 v0, 0x2d

    goto :goto_0

    .line 742
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

    .line 311
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 317
    :cond_0
    :goto_0
    return-void

    .line 312
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

    .line 313
    invoke-static {p1, v1}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 314
    if-ltz v2, :cond_0

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    if-ne v3, v2, :cond_0

    .line 315
    invoke-virtual {v1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v1

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v0

    .line 316
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

    .line 304
    const/16 v0, 0x14

    if-lt p0, v0, :cond_1

    move v0, v1

    .line 307
    :cond_0
    :goto_0
    return v0

    .line 305
    :cond_1
    invoke-static {p1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    .line 306
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

    .line 307
    goto :goto_0
.end method

.method private walk(IIIC)V
    .locals 29

    .prologue
    .line 586
    if-ltz p1, :cond_0

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    move/from16 v0, p1

    if-lt v0, v4, :cond_1

    .line 700
    :cond_0
    return-void

    .line 587
    :cond_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    move/from16 v0, p1

    invoke-virtual {v4, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v0, v4, 0xff

    move/from16 v22, v0

    .line 588
    add-int/lit8 v6, p1, 0x1

    .line 589
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v14, v4, p2

    .line 590
    if-lez p2, :cond_4

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v5, p2, -0x1

    aget-object v4, v4, v5

    .line 591
    :goto_0
    move-object/from16 v0, p0

    iget v0, v0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move/from16 v17, v0

    .line 592
    const/4 v5, 0x0

    move/from16 v21, v5

    move-object v13, v4

    :goto_1
    move/from16 v0, v21

    move/from16 v1, v22

    if-ge v0, v1, :cond_0

    .line 593
    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v6, v4, :cond_0

    .line 594
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v5, v6, 0x1

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 595
    const/16 v6, 0xff

    if-ne v4, v6, :cond_2

    .line 596
    add-int/lit8 v4, v5, 0x1

    move-object/from16 v0, p0

    iget v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v6, :cond_0

    .line 597
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

    .line 598
    add-int/lit8 v5, v5, 0x2

    .line 600
    :cond_2
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v6, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    and-int/lit16 v7, v6, 0xff

    .line 601
    and-int/lit16 v6, v7, 0x80

    if-eqz v6, :cond_5

    const/4 v6, 0x1

    move/from16 v20, v6

    .line 602
    :goto_2
    const/4 v6, 0x0

    .line 603
    and-int/lit8 v8, v7, 0x40

    if-eqz v8, :cond_6

    .line 604
    add-int/lit8 v6, v5, 0x2

    move-object/from16 v0, p0

    iget v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v6, v8, :cond_0

    .line 605
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

    .line 606
    add-int/lit8 v7, v5, 0x3

    move/from16 v19, v6

    .line 610
    :goto_3
    const/4 v5, 0x0

    .line 611
    if-eqz v20, :cond_29

    .line 612
    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v7, v5, :cond_0

    .line 613
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v6, v7, 0x1

    invoke-virtual {v5, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 614
    move-object/from16 v0, p0

    iget-boolean v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v7, :cond_3

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v6

    .line 616
    :cond_3
    :goto_4
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    add-int/lit8 v7, v7, 0x1

    move-object/from16 v0, p0

    iput v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v8, 0x2ee0

    if-gt v7, v8, :cond_0

    .line 617
    const/16 v7, 0x100

    if-ge v4, v7, :cond_7

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v7, v7, v4

    move/from16 v18, v7

    .line 618
    :goto_5
    if-nez p2, :cond_c

    .line 619
    const/16 v7, 0x100

    move/from16 v0, v18

    if-lt v0, v7, :cond_8

    move-object v4, v13

    move-object v5, v14

    .line 592
    :goto_6
    add-int/lit8 v7, v21, 0x1

    move/from16 v21, v7

    move-object v13, v4

    move-object v14, v5

    goto/16 :goto_1

    .line 590
    :cond_4
    const/4 v4, 0x0

    goto/16 :goto_0

    .line 601
    :cond_5
    const/4 v6, 0x0

    move/from16 v20, v6

    goto/16 :goto_2

    .line 608
    :cond_6
    add-int/lit8 v7, v5, 0x1

    move/from16 v19, v6

    goto :goto_3

    .line 617
    :cond_7
    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    move/from16 v18, v7

    goto :goto_5

    .line 620
    :cond_8
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v8, 0x3

    if-ne v7, v8, :cond_9

    .line 621
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aget-boolean v7, v7, v18

    if-eqz v7, :cond_c

    move-object v4, v13

    move-object v5, v14

    goto :goto_6

    .line 623
    :cond_9
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aget-boolean v7, v7, v18

    if-nez v7, :cond_a

    move-object v4, v13

    move-object v5, v14

    goto :goto_6

    .line 624
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

    .line 625
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

    .line 628
    :cond_c
    int-to-char v0, v4

    move/from16 v23, v0

    .line 629
    const/16 v7, 0x100

    if-ge v4, v7, :cond_e

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    aget-char v4, v7, v4

    .line 630
    :goto_7
    move-object/from16 v0, p0

    move/from16 v1, v18

    move/from16 v2, p3

    move/from16 v3, p2

    invoke-direct {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrFuzzy;->delCost(III)I

    move-result v24

    .line 632
    const/4 v10, -0x1

    const/4 v9, -0x1

    .line 633
    if-eqz v13, :cond_11

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v7, v7, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    array-length v7, v7

    if-lez v7, :cond_11

    .line 634
    const/16 v7, 0x100

    move/from16 v0, p4

    if-ge v0, v7, :cond_f

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    aget-char v7, v7, p4

    .line 635
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

    .line 636
    const/4 v8, 0x0

    :goto_9
    array-length v0, v11

    move/from16 v16, v0

    move/from16 v0, v16

    if-ge v8, v0, :cond_11

    .line 637
    aget-char v16, v11, v8

    move/from16 v0, v16

    if-ne v0, v7, :cond_d

    aget-char v16, v12, v8

    move/from16 v0, v16

    if-ne v0, v4, :cond_d

    .line 638
    if-gez v10, :cond_10

    aget-char v10, v15, v8

    .line 636
    :cond_d
    :goto_a
    add-int/lit8 v8, v8, 0x1

    goto :goto_9

    .line 629
    :cond_e
    invoke-static/range {v23 .. v23}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v4

    goto :goto_7

    .line 634
    :cond_f
    invoke-static/range {p4 .. p4}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v7

    goto :goto_8

    .line 639
    :cond_10
    if-gez v9, :cond_d

    aget-char v9, v15, v8

    goto :goto_a

    .line 643
    :cond_11
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v8, p2, 0x1

    aget-object v25, v7, v8

    .line 644
    add-int/lit8 v7, p2, 0x1

    .line 645
    move-object/from16 v0, p0

    iget v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    sub-int v8, v7, v8

    .line 646
    move-object/from16 v0, p0

    iget v11, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    add-int/2addr v7, v11

    .line 647
    move/from16 v0, v17

    if-le v7, v0, :cond_28

    move/from16 v16, v17

    .line 648
    :goto_b
    const/high16 v12, 0x100000

    .line 649
    if-gtz v8, :cond_1c

    .line 650
    const/4 v7, 0x0

    aget v7, v14, v7

    add-int v7, v7, v24

    .line 651
    const/high16 v8, 0x100000

    if-le v7, v8, :cond_12

    const/high16 v7, 0x100000

    .line 652
    :cond_12
    const/4 v8, 0x0

    aput v7, v25, v8

    .line 654
    const/4 v8, 0x1

    move v12, v7

    .line 658
    :goto_c
    add-int/lit8 v7, v16, 0x1

    move/from16 v0, v17

    if-gt v7, v0, :cond_13

    add-int/lit8 v7, v16, 0x1

    const/high16 v11, 0x100000

    aput v11, v25, v7

    .line 659
    :cond_13
    add-int/lit8 v7, v16, 0x2

    move/from16 v0, v17

    if-gt v7, v0, :cond_14

    add-int/lit8 v7, v16, 0x2

    const/high16 v11, 0x100000

    aput v11, v25, v7

    .line 660
    :cond_14
    if-nez p2, :cond_1d

    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v11, 0x3

    if-ne v7, v11, :cond_1d

    const/4 v7, 0x1

    :goto_d
    move v15, v8

    .line 661
    :goto_e
    move/from16 v0, v16

    if-gt v15, v0, :cond_1f

    .line 662
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v11, v15, -0x1

    aget-char v26, v8, v11

    .line 664
    if-eqz v7, :cond_1e

    const/high16 v8, 0x100000

    .line 665
    :goto_f
    add-int/lit8 v11, v15, -0x1

    aget v11, v25, v11

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    move-object/from16 v27, v0

    add-int/lit8 v28, v15, -0x1

    aget v27, v27, v28

    add-int v11, v11, v27

    .line 666
    if-ge v11, v8, :cond_15

    move v8, v11

    .line 667
    :cond_15
    aget v11, v14, v15

    add-int v11, v11, v24

    .line 668
    if-ge v11, v8, :cond_27

    .line 669
    :goto_10
    const/4 v8, 0x2

    if-lt v15, v8, :cond_26

    .line 670
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

    .line 671
    add-int/lit8 v8, v15, -0x2

    aget v8, v13, v8

    add-int/lit8 v8, v8, 0x28

    .line 672
    if-ge v8, v11, :cond_25

    .line 674
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

    .line 675
    :cond_17
    add-int/lit8 v11, v15, -0x2

    aget v11, v14, v11

    add-int/lit8 v11, v11, 0x23

    .line 676
    if-ge v11, v8, :cond_18

    move v8, v11

    .line 679
    :cond_18
    :goto_12
    if-ltz v10, :cond_1a

    move/from16 v0, v26

    if-eq v0, v10, :cond_19

    move/from16 v0, v26

    if-ne v0, v9, :cond_1a

    .line 680
    :cond_19
    add-int/lit8 v11, v15, -0x1

    aget v11, v13, v11

    add-int/lit8 v11, v11, 0x23

    .line 681
    if-ge v11, v8, :cond_1a

    move v8, v11

    .line 683
    :cond_1a
    const/high16 v11, 0x100000

    if-le v8, v11, :cond_1b

    const/high16 v8, 0x100000

    .line 684
    :cond_1b
    aput v8, v25, v15

    .line 685
    if-ge v8, v12, :cond_24

    .line 661
    :goto_13
    add-int/lit8 v11, v15, 0x1

    move v15, v11

    move v12, v8

    goto/16 :goto_e

    .line 656
    :cond_1c
    add-int/lit8 v7, v8, -0x1

    const/high16 v11, 0x100000

    aput v11, v25, v7

    goto/16 :goto_c

    .line 660
    :cond_1d
    const/4 v7, 0x0

    goto/16 :goto_d

    .line 664
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

    .line 687
    :cond_1f
    const/16 v4, 0x30

    move/from16 v0, p2

    if-ge v0, v4, :cond_20

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    aput-char v23, v4, p2

    .line 688
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

    .line 689
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    add-int/lit8 v7, p2, 0x1

    aget v8, v25, v17

    move-object/from16 v0, p0

    invoke-direct {v0, v4, v7, v5, v8}, Lcom/mrkeyboard/app/MrFuzzy;->offer([CIII)V

    .line 691
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

    .line 693
    add-int/lit8 v4, p2, 0x1

    move-object/from16 v0, p0

    move/from16 v1, v19

    move/from16 v2, v18

    move/from16 v3, v23

    invoke-direct {v0, v1, v4, v2, v3}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 694
    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v5, 0x2ee0

    if-gt v4, v5, :cond_0

    .line 696
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v5, v4, p2

    .line 697
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

    .line 483
    const/4 v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 484
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v2, v2, v2}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 485
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v1, 0x2ee0

    if-le v0, v1, :cond_0

    .line 489
    :goto_0
    return-void

    .line 486
    :cond_0
    const/4 v0, 0x2

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 487
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v2, v2, v2}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 488
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    goto :goto_0
.end method


# virtual methods
.method emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V
    .locals 10

    .prologue
    const/4 v2, 0x0

    .line 832
    move v7, v2

    :goto_0
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v7, v0, :cond_0

    .line 833
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v4, v0, v7

    .line 834
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

    .line 832
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    .line 837
    :cond_0
    return-void
.end method

.method resultCost(I)I
    .locals 1

    .prologue
    .line 378
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    aget v0, v0, p1

    return v0
.end method

.method resultCount()I
    .locals 1

    .prologue
    .line 375
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    return v0
.end method

.method resultScore(I)J
    .locals 2

    .prologue
    .line 377
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v0, v0, p1

    return-wide v0
.end method

.method resultWord(I)Ljava/lang/String;
    .locals 4

    .prologue
    .line 376
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
    .line 381
    invoke-interface {p2}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/16 v1, 0x14

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 382
    iput v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    .line 383
    const/4 v0, 0x0

    move v4, v0

    :goto_0
    if-ge v4, v5, :cond_4

    .line 384
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    invoke-interface {p2, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    aput-char v1, v0, v4

    .line 385
    const/4 v1, 0x0

    .line 386
    if-eqz p1, :cond_1

    invoke-virtual {p1, v4}, Lcom/mrkeyboard/app/WordComposer;->getCodesAt(I)[I

    move-result-object v0

    move-object v3, v0

    .line 387
    :goto_1
    if-eqz v3, :cond_0

    .line 388
    const/4 v0, 0x1

    :goto_2
    array-length v2, v3

    if-ge v0, v2, :cond_0

    const/16 v2, 0x10

    if-ge v1, v2, :cond_0

    .line 389
    aget v2, v3, v0

    .line 390
    if-gtz v2, :cond_2

    .line 395
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aput v1, v0, v4

    .line 396
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v0, v0, v4

    const/4 v1, -0x1

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([SS)V

    .line 383
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_0

    .line 386
    :cond_1
    const/4 v0, 0x0

    move-object v3, v0

    goto :goto_1

    .line 391
    :cond_2
    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v6

    .line 392
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v2, v2, v4

    if-eq v6, v2, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v7, v2, v4

    add-int/lit8 v2, v1, 0x1

    aput-char v6, v7, v1

    move v1, v2

    .line 388
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 398
    :cond_4
    invoke-static {}, Lcom/mrkeyboard/app/MrRules;->get()Lcom/mrkeyboard/app/MrRules;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 401
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->searchNative()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 447
    :cond_5
    :goto_3
    return-void

    .line 402
    :cond_6
    const/4 v0, 0x0

    :goto_4
    if-ge v0, v5, :cond_7

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->insCost(I)I

    move-result v2

    aput v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    .line 403
    :cond_7
    const/4 v0, 0x2

    move v3, v0

    :goto_5
    if-gt v3, v5, :cond_b

    .line 404
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v1, v3, -0x2

    aget-char v4, v0, v1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v1, v3, -0x1

    aget-char v6, v0, v1

    .line 405
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 406
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v7, v0, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v8, v0, Lcom/mrkeyboard/app/MrRules;->t2b:[C

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v9, v0, Lcom/mrkeyboard/app/MrRules;->t2d:[C

    .line 407
    const/4 v0, 0x0

    :goto_6
    array-length v10, v7

    if-ge v0, v10, :cond_a

    .line 408
    aget-char v10, v7, v0

    if-ne v10, v4, :cond_8

    aget-char v10, v8, v0

    if-ne v10, v6, :cond_8

    .line 409
    if-nez v2, :cond_9

    aget-char v2, v9, v0

    .line 407
    :cond_8
    :goto_7
    add-int/lit8 v0, v0, 0x1

    goto :goto_6

    .line 410
    :cond_9
    if-nez v1, :cond_8

    aget-char v1, v9, v0

    goto :goto_7

    .line 413
    :cond_a
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD1:[C

    aput-char v2, v0, v3

    .line 414
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD2:[C

    aput-char v1, v0, v3

    .line 403
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_5

    .line 416
    :cond_b
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->firstLetters()V

    .line 417
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 418
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    .line 419
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    const/4 v1, 0x0

    aget-object v1, v0, v1

    .line 420
    const/4 v0, 0x0

    const/4 v2, 0x0

    aput v2, v1, v0

    .line 421
    const/4 v0, 0x1

    :goto_8
    if-gt v0, v5, :cond_c

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

    goto :goto_8

    .line 427
    :cond_c
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->isPrefix()Z

    move-result v1

    .line 428
    if-eqz v1, :cond_d

    const/4 v0, 0x4

    if-lt v5, v0, :cond_f

    .line 429
    :cond_d
    if-eqz v1, :cond_10

    const/4 v0, 0x4

    if-ne v5, v0, :cond_10

    const/16 v0, 0x28

    :goto_9
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 430
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->walkRoot()V

    .line 431
    if-nez v1, :cond_e

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v2, 0x2ee0

    if-gt v0, v2, :cond_e

    .line 434
    const/4 v0, 0x6

    if-lt v5, v0, :cond_13

    const/16 v0, 0x1e

    :goto_a
    add-int/lit8 v0, v0, 0x1e

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 435
    const/4 v0, 0x3

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 436
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-direct {p0, v0, v2, v3, v4}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 437
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 439
    :cond_e
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-nez v0, :cond_f

    if-nez v1, :cond_f

    const/4 v0, 0x6

    if-lt v5, v0, :cond_f

    .line 441
    const/4 v0, 0x7

    if-gt v5, v0, :cond_14

    const/16 v0, 0x64

    :goto_b
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 442
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->walkRoot()V

    .line 445
    :cond_f
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    sput v0, Lcom/mrkeyboard/app/MrFuzzy;->sLastVisits:I

    .line 446
    const/4 v0, 0x4

    if-lt v5, v0, :cond_5

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->split()V

    goto/16 :goto_3

    .line 429
    :cond_10
    const/4 v0, 0x3

    if-gt v5, v0, :cond_11

    const/16 v0, 0x2d

    goto :goto_9

    :cond_11
    const/4 v0, 0x4

    if-ne v5, v0, :cond_12

    const/16 v0, 0x3c

    goto :goto_9

    :cond_12
    const/16 v0, 0x4b

    goto :goto_9

    .line 434
    :cond_13
    const/4 v0, 0x0

    goto :goto_a

    .line 441
    :cond_14
    const/16 v0, 0x78

    goto :goto_b
.end method
