.class public final Lcom/mrkeyboard/app/MrFuzzy;
.super Ljava/lang/Object;
.source "MrFuzzy.java"


# static fields
.field static final ALT_CTX_FIRST:I = 0x1

.field static final ALT_GAP:I = 0x3c

.field static final ALT_MAX_COST:I = 0x28

.field static final ALT_MAX_TYPED:I = 0xc

.field static final ALT_MIN_FREQ:I = 0x6e

.field static final ALT_OFFENSIVE_FREQ:I = 0x5

.field static final ALT_TYPED_MAX:I = 0x50

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

.field private static sReserveFirst:Z

.field private static sReserveTyped:Ljava/lang/String;

.field private static sReserveWord:Ljava/lang/String;

.field private static final sTouchCount:[I

.field private static final sTouchNear:[[C

.field private static sTouchTyped:Ljava/lang/String;


# instance fields
.field private final mAb:I

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

    .line 62
    new-array v0, v3, [C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    .line 63
    new-array v0, v3, [C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    .line 66
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v3, :cond_0

    .line 67
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    aput-char v2, v1, v0

    .line 68
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    int-to-char v2, v0

    invoke-static {v2}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v2

    aput-char v2, v1, v0

    .line 66
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 143
    :cond_0
    const/16 v0, 0xc

    filled-new-array {v4, v0}, [I

    move-result-object v0

    sget-object v1, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v1, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    .line 144
    new-array v0, v4, [I

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchCount:[I

    return-void
.end method

.method constructor <init>(Ljava/nio/ByteBuffer;I)V
    .locals 7

    .prologue
    const/4 v1, 0x1

    const/4 v3, 0x2

    const/4 v2, 0x0

    const/16 v6, 0x14

    const/4 v5, 0x5

    .line 149
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 85
    new-array v0, v6, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    .line 86
    const/16 v0, 0x10

    filled-new-array {v6, v0}, [I

    move-result-object v0

    sget-object v4, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v4, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    .line 87
    new-array v0, v6, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    .line 88
    const/16 v0, 0x100

    filled-new-array {v6, v0}, [I

    move-result-object v0

    sget-object v4, Ljava/lang/Short;->TYPE:Ljava/lang/Class;

    invoke-static {v4, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[S

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    .line 89
    new-array v0, v6, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    .line 90
    const/16 v0, 0x100

    new-array v0, v0, [Z

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    .line 92
    const/16 v0, 0x15

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD1:[C

    .line 93
    const/16 v0, 0x15

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD2:[C

    .line 95
    sget-object v0, Lcom/mrkeyboard/app/MrRules;->EMPTY:Lcom/mrkeyboard/app/MrRules;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 96
    const/16 v0, 0x19

    const/16 v4, 0x15

    filled-new-array {v0, v4}, [I

    move-result-object v0

    sget-object v4, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-static {v4, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    .line 97
    const/16 v0, 0x32

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    .line 106
    const/16 v0, 0x62

    filled-new-array {v5, v0}, [I

    move-result-object v0

    sget-object v4, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v4, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    .line 107
    new-array v0, v5, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    .line 108
    new-array v0, v5, [J

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    .line 109
    new-array v0, v5, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    .line 113
    const/16 v0, 0x140

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearFlat:[C

    .line 114
    const/16 v0, 0x1ea

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutWords:[C

    .line 115
    const/16 v0, 0xb

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    .line 116
    new-array v0, v5, [J

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutScores:[J

    .line 948
    const/16 v0, 0x62

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    .line 949
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    .line 950
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    .line 951
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    .line 150
    iput-object p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    .line 151
    iput p2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    .line 153
    const/4 v0, 0x3

    .line 154
    if-le p2, v3, :cond_4

    .line 155
    invoke-virtual {p1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 156
    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 157
    const/16 v6, 0xc8

    if-lt v4, v6, :cond_3

    if-eqz v5, :cond_0

    if-eq v5, v1, :cond_0

    if-ne v5, v3, :cond_3

    .line 158
    :cond_0
    :goto_0
    if-eqz v1, :cond_1

    if-ne v5, v3, :cond_1

    const/4 v0, 0x4

    .line 160
    :cond_1
    :goto_1
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    .line 161
    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    .line 162
    if-eqz v1, :cond_2

    move v2, v3

    :cond_2
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    .line 163
    return-void

    :cond_3
    move v1, v2

    .line 157
    goto :goto_0

    :cond_4
    move v1, v2

    goto :goto_1
.end method

.method private addrAt(I)I
    .locals 3

    .prologue
    .line 804
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit8 v0, v0, 0x3f

    shl-int/lit8 v0, v0, 0x8

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, p1, 0x1

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    or-int/2addr v0, v1

    .line 805
    shl-int/lit8 v0, v0, 0x8

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, p1, 0x2

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    or-int/2addr v0, v1

    .line 806
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    const/4 v2, 0x3

    if-ne v1, v2, :cond_0

    :goto_0
    return v0

    :cond_0
    shl-int/lit8 v0, v0, 0x8

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, p1, 0x3

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    or-int/2addr v0, v1

    goto :goto_0
.end method

.method public static afterWords(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 183
    const/4 v1, 0x0

    :try_start_0
    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 184
    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 185
    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveFirst:Z

    .line 186
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 221
    :cond_0
    :goto_0
    return-void

    .line 187
    :cond_1
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->size()I

    move-result v1

    .line 188
    const/4 v2, 0x2

    if-lt v1, v2, :cond_0

    const/16 v2, 0x14

    if-gt v1, v2, :cond_0

    .line 190
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrRecent;->complete(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V

    .line 192
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPredict;->complete(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V

    .line 193
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->getTypedWord()Ljava/lang/CharSequence;

    move-result-object v2

    .line 194
    if-eqz v2, :cond_0

    .line 195
    invoke-static {p1, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->rememberTouches(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V

    .line 196
    invoke-static {v2}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    .line 197
    if-eqz v3, :cond_2

    .line 198
    invoke-virtual {v3}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 199
    const/4 v2, 0x0

    array-length v3, v1

    const v4, 0x1fffffff

    const/4 v5, 0x1

    sget-object v6, Lcom/mrkeyboard/app/Dictionary$DataType;->UNIGRAM:Lcom/mrkeyboard/app/Dictionary$DataType;

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/Suggest;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z

    goto :goto_0

    .line 218
    :catch_0
    move-exception v0

    goto :goto_0

    .line 202
    :cond_2
    const/4 v3, 0x3

    if-lt v1, v3, :cond_0

    .line 203
    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/Suggest;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 204
    invoke-static {p0, p1, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->validAlternative(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V

    goto :goto_0

    .line 207
    :cond_3
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v1

    .line 208
    if-eqz v1, :cond_0

    .line 209
    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrLength()I

    move-result v1

    invoke-static {v3, v1}, Lcom/mrkeyboard/app/MrFuzzy;->forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;

    move-result-object v1

    .line 210
    if-eqz v1, :cond_0

    .line 211
    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 212
    :try_start_1
    invoke-virtual {v1, p1, v2}, Lcom/mrkeyboard/app/MrFuzzy;->search(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;)V

    .line 213
    invoke-virtual {v1, p0}, Lcom/mrkeyboard/app/MrFuzzy;->emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V

    .line 214
    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 215
    iget v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-lez v2, :cond_4

    iget-object v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    const/4 v3, 0x0

    aget v2, v2, v3

    const/16 v3, 0x2d

    if-gt v2, v3, :cond_4

    .line 216
    const/4 v0, 0x0

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->resultWord(I)Ljava/lang/String;

    move-result-object v0

    :cond_4
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 217
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
    .line 444
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    new-array v1, v0, [C

    .line 445
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

    .line 446
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

    .line 420
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 421
    if-eqz v0, :cond_1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 440
    :cond_0
    :goto_0
    return v1

    .line 422
    :cond_1
    const/16 v0, 0x20

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_2

    move v1, v3

    goto :goto_0

    .line 423
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-static {p1}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 424
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v2, 0x5

    if-gt v0, v2, :cond_4

    move v0, v1

    .line 425
    :goto_1
    invoke-static {v5, v6, v0}, Lcom/mrkeyboard/app/MrFuzzy;->distance(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v2

    if-le v2, v0, :cond_0

    .line 429
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v4

    if-ne v2, v4, :cond_9

    sget-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_9

    .line 430
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

    .line 432
    :goto_2
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v7

    if-ge v2, v7, :cond_8

    .line 433
    invoke-virtual {v5, v2}, Ljava/lang/String;->charAt(I)C

    move-result v7

    invoke-virtual {v6, v2}, Ljava/lang/String;->charAt(I)C

    move-result v8

    if-ne v7, v8, :cond_5

    .line 432
    :goto_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 424
    :cond_4
    const/4 v0, 0x2

    goto :goto_1

    .line 434
    :cond_5
    invoke-virtual {v6, v2}, Ljava/lang/String;->charAt(I)C

    move-result v7

    invoke-static {v2, v7}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v7

    .line 435
    if-ltz v7, :cond_6

    if-le v7, v1, :cond_7

    :cond_6
    move v1, v3

    goto :goto_0

    .line 436
    :cond_7
    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    .line 438
    :cond_8
    mul-int/lit8 v0, v0, 0x2

    if-le v4, v0, :cond_0

    move v1, v3

    goto :goto_0

    :cond_9
    move v1, v3

    .line 440
    goto :goto_0
.end method

.method private delCost(III)I
    .locals 6

    .prologue
    const/4 v0, 0x0

    const/16 v5, 0x100

    const/16 v1, 0x1e

    .line 864
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 865
    if-nez p3, :cond_2

    iget v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v4, 0x3

    if-ne v3, v4, :cond_2

    .line 866
    if-ge p1, v5, :cond_0

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v0, v0, p1

    .line 867
    :cond_0
    if-lez v0, :cond_1

    if-ge v0, v1, :cond_1

    .line 876
    :goto_0
    return v0

    :cond_1
    move v0, v1

    .line 867
    goto :goto_0

    .line 869
    :cond_2
    if-nez p3, :cond_3

    if-ge p1, v5, :cond_3

    iget-object v3, v2, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v3, v3, p1

    if-lez v3, :cond_3

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v0, v0, p1

    goto :goto_0

    .line 870
    :cond_3
    if-lez p3, :cond_4

    if-ne p1, p2, :cond_4

    move v0, v1

    goto :goto_0

    .line 871
    :cond_4
    iget-object v1, v2, Lcom/mrkeyboard/app/MrRules;->silPrev:[C

    iget-object v3, v2, Lcom/mrkeyboard/app/MrRules;->silChar:[C

    .line 872
    :goto_1
    array-length v4, v1

    if-ge v0, v4, :cond_6

    .line 873
    aget-char v4, v3, v0

    if-ne v4, p1, :cond_5

    aget-char v4, v1, v0

    if-ne v4, p2, :cond_5

    iget-object v1, v2, Lcom/mrkeyboard/app/MrRules;->silCost:[S

    aget-short v0, v1, v0

    goto :goto_0

    .line 872
    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 875
    :cond_6
    if-lez p3, :cond_7

    if-ge p1, v5, :cond_7

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentAny:[S

    aget-short v0, v0, p1

    if-lez v0, :cond_7

    iget-object v0, v2, Lcom/mrkeyboard/app/MrRules;->silentAny:[S

    aget-short v0, v0, p1

    goto :goto_0

    .line 876
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

    .line 383
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 388
    :cond_0
    :goto_0
    return-void

    .line 384
    :cond_1
    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrFuzzy;->isCaseVariant(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 385
    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 386
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 387
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
    .line 451
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v7

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v8

    .line 452
    sub-int v0, v7, v8

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    if-le v0, p2, :cond_0

    add-int/lit8 v0, p2, 0x1

    .line 470
    :goto_0
    return v0

    .line 453
    :cond_0
    add-int/lit8 v0, v8, 0x1

    new-array v5, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v4, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v1, v0, [I

    .line 454
    const/4 v0, 0x0

    :goto_1
    if-gt v0, v8, :cond_1

    aput v0, v4, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 455
    :cond_1
    const/4 v0, 0x1

    move v3, v0

    move-object v6, v4

    move-object v4, v1

    :goto_2
    if-gt v3, v7, :cond_6

    .line 456
    const/4 v0, 0x0

    aput v3, v4, v0

    .line 457
    const/4 v0, 0x0

    aget v1, v4, v0

    .line 458
    const/4 v0, 0x1

    move v2, v0

    :goto_3
    if-gt v2, v8, :cond_4

    .line 459
    add-int/lit8 v0, v3, -0x1

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    add-int/lit8 v9, v2, -0x1

    invoke-virtual {p1, v9}, Ljava/lang/String;->charAt(I)C

    move-result v9

    if-ne v0, v9, :cond_3

    const/4 v0, 0x0

    .line 460
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

    .line 461
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

    .line 462
    add-int/lit8 v9, v2, -0x2

    aget v9, v5, v9

    add-int/lit8 v9, v9, 0x1

    invoke-static {v0, v9}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 464
    :cond_2
    aput v0, v4, v2

    .line 465
    if-ge v0, v1, :cond_7

    .line 458
    :goto_5
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    move v1, v0

    goto :goto_3

    .line 459
    :cond_3
    const/4 v0, 0x1

    goto :goto_4

    .line 467
    :cond_4
    if-le v1, p2, :cond_5

    add-int/lit8 v0, p2, 0x1

    goto/16 :goto_0

    .line 455
    :cond_5
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    move-object v11, v5

    move-object v5, v6

    move-object v6, v4

    move-object v4, v11

    goto :goto_2

    .line 470
    :cond_6
    aget v0, v6, v8

    goto/16 :goto_0

    :cond_7
    move v0, v1

    goto :goto_5
.end method

.method public static finish(Ljava/util/List;Z)Z
    .locals 9
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

    const/4 v8, 0x2

    const/4 v3, 0x0

    const/4 v2, 0x1

    .line 310
    sget-object v4, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 311
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 312
    sget-boolean v6, Lcom/mrkeyboard/app/MrFuzzy;->sReserveFirst:Z

    .line 314
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 315
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 316
    sput-boolean v3, Lcom/mrkeyboard/app/MrFuzzy;->sReserveFirst:Z

    .line 318
    if-eqz p0, :cond_0

    :try_start_0
    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    move v0, p1

    .line 371
    :goto_0
    return v0

    .line 319
    :cond_1
    const/4 v0, 0x0

    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v7

    .line 320
    if-eqz v1, :cond_b

    invoke-virtual {v7, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_b

    .line 322
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v0

    if-le v0, v2, :cond_6

    invoke-virtual {v7}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-virtual {v7}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_6

    .line 323
    invoke-virtual {v1}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    .line 327
    :cond_2
    :goto_1
    const/4 v5, -0x1

    move v4, v2

    .line 328
    :goto_2
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v4, v0, :cond_12

    .line 329
    invoke-interface {p0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_7

    move v0, v4

    .line 331
    :goto_3
    if-eqz v6, :cond_8

    .line 333
    if-eq v0, v2, :cond_4

    .line 334
    if-lez v0, :cond_3

    invoke-interface {p0, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 335
    :cond_3
    const/4 v0, 0x1

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v4

    invoke-static {v0, v4}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-interface {p0, v0, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    :cond_4
    move v4, v2

    .line 344
    :goto_4
    invoke-static {p0}, Lcom/mrkeyboard/app/MrLearned;->filter(Ljava/util/List;)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    if-eqz v0, :cond_11

    move v1, v3

    .line 347
    :goto_5
    :try_start_1
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v0

    if-ne v0, v2, :cond_e

    .line 348
    invoke-static {v7}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 349
    if-eqz v0, :cond_e

    invoke-virtual {v0, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 350
    const/4 v3, 0x0

    invoke-virtual {v7, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v3

    if-eqz v3, :cond_c

    .line 351
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v4, 0x0

    invoke-virtual {v0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Ljava/lang/Character;->toUpperCase(C)C

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    const/4 v4, 0x1

    invoke-virtual {v0, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v4, v0

    .line 352
    :goto_6
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v3, v0

    :goto_7
    if-lt v3, v2, :cond_d

    .line 353
    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {p0, v3}, Ljava/util/List;->remove(I)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    .line 352
    :cond_5
    add-int/lit8 v0, v3, -0x1

    move v3, v0

    goto :goto_7

    .line 324
    :cond_6
    const/4 v0, 0x0

    :try_start_2
    invoke-virtual {v7, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 325
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v4, 0x0

    invoke-virtual {v1, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Ljava/lang/Character;->toUpperCase(C)C

    move-result v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v4, 0x1

    invoke-virtual {v1, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    goto/16 :goto_1

    .line 328
    :cond_7
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_2

    .line 338
    :cond_8
    if-ltz v0, :cond_9

    if-le v0, v8, :cond_b

    .line 339
    :cond_9
    if-le v0, v8, :cond_a

    invoke-interface {p0, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 340
    :cond_a
    const/4 v0, 0x2

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v4

    invoke-static {v0, v4}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-interface {p0, v0, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0

    :cond_b
    move v4, v3

    goto/16 :goto_4

    :cond_c
    move-object v4, v0

    .line 351
    goto :goto_6

    .line 355
    :cond_d
    const/4 v0, 0x1

    :try_start_3
    invoke-interface {p0, v0, v4}, Ljava/util/List;->add(ILjava/lang/Object;)V

    move v0, v2

    .line 356
    goto/16 :goto_0

    .line 361
    :cond_e
    invoke-static {p0, v7}, Lcom/mrkeyboard/app/MrFuzzy;->demoteCaseVariant(Ljava/util/List;Ljava/lang/String;)V

    .line 364
    if-nez v4, :cond_f

    invoke-static {p0, v7}, Lcom/mrkeyboard/app/MrFuzzy;->touchOrder(Ljava/util/List;Ljava/lang/String;)V

    .line 365
    :cond_f
    if-eqz v1, :cond_10

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v0, v8, :cond_10

    .line 366
    const/4 v0, 0x1

    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v7, v0}, Lcom/mrkeyboard/app/MrFuzzy;->confident(Ljava/lang/String;Ljava/lang/String;)Z
    :try_end_3
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_1

    move-result v0

    goto/16 :goto_0

    .line 368
    :catch_0
    move-exception v0

    move v0, p1

    goto/16 :goto_0

    :catch_1
    move-exception v0

    move v0, v1

    goto/16 :goto_0

    :cond_10
    move v0, v1

    goto/16 :goto_0

    :cond_11
    move v1, p1

    goto/16 :goto_5

    :cond_12
    move v0, v5

    goto/16 :goto_3
.end method

.method private firstLetters()V
    .locals 8

    .prologue
    const/16 v7, 0x100

    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 645
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([ZZ)V

    .line 646
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v3, v0, v2

    .line 647
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    and-int/lit16 v5, v3, 0xff

    if-ge v3, v7, :cond_1

    move v0, v1

    :goto_0
    aput-boolean v0, v4, v5

    move v0, v2

    .line 648
    :goto_1
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v4, v4, v2

    if-ge v0, v4, :cond_2

    .line 649
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v4, v4, v2

    aget-char v4, v4, v0

    .line 650
    if-ge v4, v7, :cond_0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v4

    .line 648
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    move v0, v2

    .line 647
    goto :goto_0

    .line 652
    :cond_2
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    move v0, v2

    .line 653
    :goto_2
    if-ge v0, v7, :cond_5

    .line 655
    invoke-virtual {v4, v0, v3}, Lcom/mrkeyboard/app/MrRules;->pair(CC)I

    move-result v5

    if-nez v5, :cond_3

    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    aget-short v5, v5, v0

    if-lez v5, :cond_4

    :cond_3
    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v0

    .line 653
    :cond_4
    add-int/lit8 v0, v0, 0x1

    int-to-char v0, v0

    goto :goto_2

    .line 658
    :cond_5
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-le v0, v1, :cond_7

    move v0, v2

    .line 659
    :goto_3
    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    array-length v5, v5

    if-ge v0, v5, :cond_7

    .line 660
    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    aget-char v5, v5, v0

    if-ne v5, v3, :cond_6

    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2b:[C

    aget-char v5, v5, v0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v6, v6, v1

    if-ne v5, v6, :cond_6

    .line 661
    iget-object v5, v4, Lcom/mrkeyboard/app/MrRules;->t2d:[C

    aget-char v5, v5, v0

    invoke-static {v5}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v5

    .line 662
    if-ge v5, v7, :cond_6

    iget-object v6, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v6, v5

    .line 659
    :cond_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 666
    :cond_7
    :goto_4
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    array-length v0, v0

    if-ge v2, v0, :cond_9

    .line 667
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    aget-char v0, v0, v2

    if-ne v0, v3, :cond_8

    .line 668
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    aget-char v0, v0, v2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v0

    .line 669
    if-ge v0, v7, :cond_8

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aput-boolean v1, v5, v0

    .line 666
    :cond_8
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    .line 672
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

    .line 673
    :cond_a
    return-void
.end method

.method static declared-synchronized forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;
    .locals 3

    .prologue
    .line 166
    const-class v1, Lcom/mrkeyboard/app/MrFuzzy;

    monitor-enter v1

    if-eqz p0, :cond_0

    const/4 v0, 0x2

    if-gt p1, v0, :cond_2

    :cond_0
    const/4 v0, 0x0

    .line 172
    :cond_1
    :goto_0
    monitor-exit v1

    return-object v0

    .line 167
    :cond_2
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;

    .line 168
    if-eqz v0, :cond_3

    iget-object v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    if-ne v2, p0, :cond_3

    iget v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-eq v2, p1, :cond_1

    .line 169
    :cond_3
    new-instance v0, Lcom/mrkeyboard/app/MrFuzzy;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrFuzzy;-><init>(Ljava/nio/ByteBuffer;I)V

    .line 170
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 166
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private insCost(I)I
    .locals 4

    .prologue
    const/16 v0, 0x2d

    .line 854
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v1, v1, p1

    .line 855
    if-lez p1, :cond_1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v3, p1, -0x1

    aget-char v2, v2, v3

    if-ne v2, v1, :cond_1

    const/16 v0, 0x1e

    .line 859
    :cond_0
    :goto_0
    return v0

    .line 856
    :cond_1
    const/16 v2, 0x100

    if-ge v1, v2, :cond_2

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v2, v2, Lcom/mrkeyboard/app/MrRules;->extra:[Z

    aget-boolean v2, v2, v1

    if-eqz v2, :cond_2

    const/16 v0, 0x28

    goto :goto_0

    .line 857
    :cond_2
    if-lez p1, :cond_3

    add-int/lit8 v2, p1, -0x1

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v2

    if-nez v2, :cond_0

    .line 858
    :cond_3
    add-int/lit8 v2, p1, 0x1

    iget v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-ge v2, v3, :cond_4

    add-int/lit8 v2, p1, 0x1

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->isNear(IC)Z

    move-result v1

    if-nez v1, :cond_0

    .line 859
    :cond_4
    const/16 v0, 0x3c

    goto :goto_0
.end method

.method private insert([CIIJI)V
    .locals 8

    .prologue
    const/4 v7, 0x5

    const/4 v1, 0x0

    .line 895
    move v0, v1

    :goto_0
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v0, v2, :cond_2

    .line 896
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aget v2, v2, v0

    if-ne v2, p3, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v2, v2, v0

    invoke-static {v2, p1, p2, p3}, Lcom/mrkeyboard/app/MrFuzzy;->same([C[CII)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 897
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v2, v2, v0

    cmp-long v2, p4, v2

    if-gtz v2, :cond_1

    .line 919
    :cond_0
    :goto_1
    return-void

    .line 898
    :cond_1
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->remove(I)V

    .line 902
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    move v2, v0

    .line 903
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

    .line 895
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 904
    :cond_4
    if-ge v2, v7, :cond_0

    .line 905
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    const/4 v3, 0x4

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 906
    :goto_3
    if-le v0, v2, :cond_5

    .line 907
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v3, v3, v0

    .line 908
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v6, v0, -0x1

    aget-object v5, v5, v6

    aput-object v5, v4, v0

    .line 909
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v5, v0, -0x1

    aput-object v3, v4, v5

    .line 910
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    add-int/lit8 v5, v0, -0x1

    aget v4, v4, v5

    aput v4, v3, v0

    .line 911
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    add-int/lit8 v5, v0, -0x1

    aget-wide v4, v4, v5

    aput-wide v4, v3, v0

    .line 912
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    add-int/lit8 v5, v0, -0x1

    aget v4, v4, v5

    aput v4, v3, v0

    .line 906
    add-int/lit8 v0, v0, -0x1

    goto :goto_3

    .line 914
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v0, v0, v2

    invoke-static {p1, p2, v0, v1, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 915
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aput p3, v0, v2

    .line 916
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aput-wide p4, v0, v2

    .line 917
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    aput p6, v0, v2

    .line 918
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

    .line 376
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    if-ne v1, v2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 379
    :cond_0
    :goto_0
    return v0

    .line 377
    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 378
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 379
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
    .line 824
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v1, v0, p1

    .line 825
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v0, v0, p1

    add-int/lit8 v0, v0, -0x1

    :goto_0
    if-ltz v0, :cond_1

    .line 826
    aget-char v2, v1, v0

    if-ne v2, p2, :cond_0

    const/4 v0, 0x1

    .line 828
    :goto_1
    return v0

    .line 825
    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 828
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private isPrefix()Z
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 593
    iput v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    .line 594
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->prefixRec(II)Z

    move-result v0

    return v0
.end method

.method private lookup(II)I
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 986
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 987
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 988
    sub-int v1, p2, p1

    const/16 v2, 0x30

    if-le v1, v2, :cond_0

    .line 990
    :goto_0
    return v0

    .line 989
    :cond_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v1, p1, p2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->lookupRec(IIII)V

    .line 990
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    goto :goto_0
.end method

.method private lookupRec(IIII)V
    .locals 10

    .prologue
    const/4 v3, 0x0

    .line 994
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 1037
    :cond_0
    return-void

    .line 995
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    const/16 v1, 0x2ee0

    if-gt v0, v1, :cond_0

    .line 996
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v8, v0, 0xff

    .line 997
    add-int/lit8 v4, p1, 0x1

    .line 998
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v9, v0, p2

    move v7, v3

    .line 999
    :goto_0
    if-ge v7, v8, :cond_0

    .line 1000
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v0, :cond_0

    .line 1001
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v4, 0x1

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 1002
    const/16 v2, 0xff

    if-ne v0, v2, :cond_2

    .line 1003
    add-int/lit8 v0, v1, 0x1

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v0, v2, :cond_0

    .line 1004
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

    .line 1005
    add-int/lit8 v1, v1, 0x2

    .line 1007
    :cond_2
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v2, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v4, v2, 0xff

    .line 1008
    and-int/lit16 v2, v4, 0x80

    if-eqz v2, :cond_4

    const/4 v2, 0x1

    move v6, v2

    .line 1010
    :goto_1
    and-int/lit8 v2, v4, 0x40

    if-eqz v2, :cond_5

    .line 1011
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v2, v1

    add-int/lit8 v2, v2, -0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v2, v4, :cond_0

    .line 1012
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->addrAt(I)I

    move-result v2

    .line 1013
    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v1, v4

    move v5, v2

    .line 1018
    :goto_2
    if-eqz v6, :cond_a

    .line 1019
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    .line 1020
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v1, 0x1

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 1021
    iget-boolean v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v4, :cond_9

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v2

    move v4, v2

    move v2, v1

    .line 1023
    :goto_3
    const/16 v1, 0x100

    if-ge v0, v1, :cond_6

    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v1, v1, v0

    .line 1024
    :goto_4
    if-eq v1, v9, :cond_7

    .line 999
    :cond_3
    :goto_5
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    :cond_4
    move v6, v3

    .line 1008
    goto :goto_1

    .line 1015
    :cond_5
    add-int/lit8 v1, v1, 0x1

    move v5, v3

    goto :goto_2

    .line 1023
    :cond_6
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    goto :goto_4

    .line 1025
    :cond_7
    int-to-char v0, v0

    .line 1026
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aput-char v0, v1, p4

    .line 1027
    add-int/lit8 v0, p2, 0x1

    if-ne v0, p3, :cond_8

    .line 1028
    if-eqz v6, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    if-le v2, v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aget-char v0, v0, v3

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-nez v0, :cond_3

    .line 1029
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 1030
    add-int/lit8 v0, p4, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 1031
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    add-int/lit8 v2, p4, 0x1

    invoke-static {v0, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_5

    .line 1033
    :cond_8
    if-eqz v5, :cond_3

    .line 1034
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
    .line 833
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v1, v0, p1

    .line 834
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aget v2, v0, p1

    .line 835
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v2, :cond_1

    .line 836
    aget-char v3, v1, v0

    if-ne v3, p2, :cond_0

    .line 838
    :goto_1
    return v0

    .line 835
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 838
    :cond_1
    const/4 v0, -0x1

    goto :goto_1
.end method

.method private offer([CIII)V
    .locals 7

    .prologue
    .line 888
    invoke-direct {p0, p3, p4}, Lcom/mrkeyboard/app/MrFuzzy;->scoreFor(II)J

    move-result-wide v4

    .line 889
    const-wide/16 v0, 0x0

    cmp-long v0, v4, v0

    if-gtz v0, :cond_0

    .line 891
    :goto_0
    return-void

    .line 890
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
    .line 981
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

    .line 392
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 400
    :cond_0
    :goto_0
    return v2

    .line 394
    :cond_1
    const/4 v0, 0x0

    move v1, v2

    :goto_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v0, v3, :cond_3

    .line 395
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v3

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v4

    if-eq v3, v4, :cond_2

    .line 396
    if-gez v1, :cond_0

    move v1, v0

    .line 394
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    move v2, v1

    .line 400
    goto :goto_0
.end method

.method private prefixRec(II)Z
    .locals 10

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 605
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    :cond_0
    move v0, v2

    .line 640
    :goto_0
    return v0

    .line 606
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    const/16 v1, 0x2ee0

    if-le v0, v1, :cond_2

    move v0, v2

    goto :goto_0

    .line 607
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v6, v0, 0xff

    .line 608
    add-int/lit8 v1, p1, 0x1

    .line 609
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v7, v0, p2

    move v5, v2

    move v0, v1

    .line 610
    :goto_1
    if-ge v5, v6, :cond_e

    .line 611
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v0, v1, :cond_3

    move v0, v2

    goto :goto_0

    .line 612
    :cond_3
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v0, 0x1

    invoke-virtual {v4, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 613
    const/16 v4, 0xff

    if-ne v0, v4, :cond_5

    .line 614
    add-int/lit8 v0, v1, 0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v0, v4, :cond_4

    move v0, v2

    goto :goto_0

    .line 615
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

    .line 616
    add-int/lit8 v1, v1, 0x2

    .line 618
    :cond_5
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v8, v4, 0xff

    .line 620
    and-int/lit8 v4, v8, 0x40

    if-eqz v4, :cond_7

    .line 621
    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v4, v1

    add-int/lit8 v4, v4, -0x1

    iget v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v4, v9, :cond_6

    move v0, v2

    goto :goto_0

    .line 622
    :cond_6
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->addrAt(I)I

    move-result v4

    .line 623
    iget v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v1, v9

    .line 627
    :goto_2
    and-int/lit16 v8, v8, 0x80

    if-eqz v8, :cond_9

    .line 628
    iget v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt v1, v8, :cond_8

    move v0, v2

    goto :goto_0

    .line 625
    :cond_7
    add-int/lit8 v1, v1, 0x1

    move v4, v2

    goto :goto_2

    .line 629
    :cond_8
    add-int/lit8 v1, v1, 0x1

    .line 630
    iget-boolean v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v8, :cond_9

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v1

    .line 632
    :cond_9
    const/16 v8, 0x100

    if-ge v0, v8, :cond_b

    sget-object v8, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v0, v8, v0

    .line 633
    :goto_3
    if-eq v0, v7, :cond_c

    .line 610
    :cond_a
    add-int/lit8 v0, v5, 0x1

    move v5, v0

    move v0, v1

    goto :goto_1

    .line 632
    :cond_b
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v0

    goto :goto_3

    .line 634
    :cond_c
    add-int/lit8 v0, p2, 0x1

    iget v8, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    if-ne v0, v8, :cond_d

    .line 635
    if-eqz v4, :cond_a

    move v0, v3

    goto/16 :goto_0

    .line 636
    :cond_d
    if-eqz v4, :cond_a

    add-int/lit8 v0, p2, 0x1

    invoke-direct {p0, v4, v0}, Lcom/mrkeyboard/app/MrFuzzy;->prefixRec(II)Z

    move-result v0

    if-eqz v0, :cond_a

    move v0, v3

    .line 637
    goto/16 :goto_0

    :cond_e
    move v0, v2

    .line 640
    goto/16 :goto_0
.end method

.method private static rememberTouches(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V
    .locals 9

    .prologue
    const/4 v2, 0x0

    .line 280
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    move v4, v2

    .line 281
    :goto_0
    if-ge v4, p2, :cond_3

    .line 282
    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/WordComposer;->getCodesAt(I)[I

    move-result-object v5

    .line 284
    if-eqz v5, :cond_4

    .line 285
    invoke-interface {p1, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v6

    .line 286
    const/4 v0, 0x1

    move v1, v2

    :goto_1
    array-length v3, v5

    if-ge v0, v3, :cond_0

    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    aget-object v3, v3, v4

    array-length v3, v3

    if-ge v1, v3, :cond_0

    .line 287
    aget v3, v5, v0

    if-gtz v3, :cond_1

    .line 292
    :cond_0
    :goto_2
    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchCount:[I

    aput v1, v0, v4

    .line 281
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_0

    .line 288
    :cond_1
    aget v3, v5, v0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    .line 289
    if-eq v7, v6, :cond_2

    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    aget-object v8, v3, v4

    add-int/lit8 v3, v1, 0x1

    aput-char v7, v8, v1

    move v1, v3

    .line 286
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 294
    :cond_3
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    .line 295
    return-void

    :cond_4
    move v1, v2

    goto :goto_2
.end method

.method private remove(I)V
    .locals 4

    .prologue
    .line 922
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v0, v0, p1

    .line 923
    :goto_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v1, v1, -0x1

    if-ge p1, v1, :cond_0

    .line 924
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    add-int/lit8 v3, p1, 0x1

    aget-object v2, v2, v3

    aput-object v2, v1, p1

    .line 925
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    add-int/lit8 v3, p1, 0x1

    aget v2, v2, v3

    aput v2, v1, p1

    .line 926
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    add-int/lit8 v3, p1, 0x1

    aget-wide v2, v2, v3

    aput-wide v2, v1, p1

    .line 927
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    add-int/lit8 v3, p1, 0x1

    aget v2, v2, v3

    aput v2, v1, p1

    .line 923
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 929
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v2, v2, -0x1

    aput-object v0, v1, v2

    .line 930
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 931
    return-void
.end method

.method private static same([C[CII)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 934
    move v1, v0

    :goto_0
    if-ge v1, p3, :cond_1

    aget-char v2, p0, v1

    add-int v3, p2, v1

    aget-char v3, p1, v3

    if-eq v2, v3, :cond_0

    .line 935
    :goto_1
    return v0

    .line 934
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 935
    :cond_1
    const/4 v0, 0x1

    goto :goto_1
.end method

.method private scoreFor(II)J
    .locals 10

    .prologue
    const-wide v0, 0x41affffffe000000L    # 2.68435455E8

    .line 880
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    const/16 v3, 0x18

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 881
    int-to-double v4, p1

    const-wide/16 v6, 0x1

    add-int/lit8 v2, v2, 0x1

    shl-long v2, v6, v2

    long-to-double v2, v2

    mul-double/2addr v2, v4

    .line 882
    const-wide/high16 v4, 0x4000000000000000L    # 2.0

    neg-int v6, p2

    int-to-double v6, v6

    const-wide/high16 v8, 0x4039000000000000L    # 25.0

    div-double/2addr v6, v8

    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v4

    mul-double/2addr v2, v4

    .line 883
    cmpl-double v4, v2, v0

    if-lez v4, :cond_0

    .line 884
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

    .line 551
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move v0, v10

    .line 552
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

    .line 553
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

    .line 554
    if-ltz v1, :cond_1

    const/4 v0, 0x5

    if-le v1, v0, :cond_2

    :cond_1
    move v0, v10

    .line 568
    :goto_1
    return v0

    :cond_2
    move v0, v10

    .line 555
    :goto_2
    if-ge v0, v1, :cond_5

    .line 556
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    mul-int/lit8 v3, v0, 0x2

    add-int/lit8 v3, v3, 0x1

    aget v2, v2, v3

    .line 557
    if-ltz v2, :cond_3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v3, v3, v0

    array-length v3, v3

    if-le v2, v3, :cond_4

    :cond_3
    move v0, v10

    goto :goto_1

    .line 555
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 559
    :cond_5
    iput v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    move v0, v10

    .line 560
    :goto_3
    if-ge v0, v1, :cond_6

    .line 561
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    mul-int/lit8 v3, v0, 0x2

    add-int/lit8 v3, v3, 0x1

    aget v2, v2, v3

    .line 562
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutWords:[C

    mul-int/lit8 v4, v0, 0x62

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v5, v5, v0

    invoke-static {v3, v4, v5, v10, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 563
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aput v2, v3, v0

    .line 564
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    mul-int/lit8 v4, v0, 0x2

    add-int/lit8 v4, v4, 0x2

    aget v3, v3, v4

    aput v3, v2, v0

    .line 565
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutScores:[J

    aget-wide v4, v3, v0

    aput-wide v4, v2, v0

    .line 560
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 567
    :cond_6
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    aget v0, v0, v10

    sput v0, Lcom/mrkeyboard/app/MrFuzzy;->sLastVisits:I

    .line 568
    const/4 v0, 0x1

    goto :goto_1
.end method

.method private setMaxCost(I)V
    .locals 1

    .prologue
    .line 577
    iput p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mMaxCost:I

    .line 578
    div-int/lit8 v0, p1, 0x1e

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    .line 579
    return-void
.end method

.method private skipBigrams(I)I
    .locals 3

    .prologue
    .line 810
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 820
    :cond_0
    :goto_0
    return p1

    .line 811
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    if-eqz v0, :cond_2

    .line 812
    const/4 v0, 0x0

    .line 813
    :goto_1
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v1, p1

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    add-int/lit8 v1, v0, 0x1

    const/16 v2, 0x2710

    if-ge v0, v2, :cond_0

    .line 814
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v0, p1

    .line 815
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 p1, v0, 0x1

    invoke-virtual {v2, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    .line 816
    if-eqz v0, :cond_0

    move v0, v1

    .line 817
    goto :goto_1

    .line 820
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

    .line 956
    iget v9, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    .line 957
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    .line 958
    const-wide/16 v4, 0x0

    move v7, v8

    move v3, v2

    .line 960
    :goto_0
    add-int/lit8 v0, v9, -0x2

    if-gt v7, v0, :cond_2

    .line 961
    if-ne v7, v8, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, v2

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneLetterWord(C)Z

    move-result v0

    if-nez v0, :cond_1

    .line 960
    :cond_0
    :goto_1
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    .line 962
    :cond_1
    invoke-direct {p0, v2, v7}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v0

    .line 963
    if-lez v0, :cond_0

    .line 964
    iget v10, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 965
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    iget-object v11, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    invoke-static {v1, v2, v11, v2, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 966
    invoke-direct {p0, v7, v9}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v1

    .line 967
    if-lez v1, :cond_0

    .line 968
    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->scoreFor(II)J

    move-result-wide v0

    .line 969
    cmp-long v11, v0, v4

    if-lez v11, :cond_0

    .line 971
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLeftBuf:[C

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    invoke-static {v3, v2, v4, v2, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 972
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    const/16 v4, 0x20

    aput-char v4, v3, v10

    .line 973
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    add-int/lit8 v5, v10, 0x1

    iget v11, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    invoke-static {v3, v2, v4, v5, v11}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 974
    add-int/lit8 v3, v10, 0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    add-int/2addr v3, v4

    move-wide v4, v0

    goto :goto_1

    .line 977
    :cond_2
    if-lez v3, :cond_3

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSplitBuf:[C

    move-object v0, p0

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrFuzzy;->insert([CIIJI)V

    .line 978
    :cond_3
    return-void
.end method

.method private sub(II)I
    .locals 2

    .prologue
    .line 676
    const/16 v0, 0x100

    if-lt p2, v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v0, v0, p1

    if-ne p2, v0, :cond_1

    const/4 v0, 0x0

    .line 682
    :cond_0
    :goto_0
    return v0

    .line 676
    :cond_1
    const/16 v0, 0x4b

    goto :goto_0

    .line 677
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v0, v0, p1

    aget-short v0, v0, p2

    .line 678
    if-gez v0, :cond_0

    .line 679
    int-to-char v0, p2

    invoke-direct {p0, v0, p1}, Lcom/mrkeyboard/app/MrFuzzy;->subCost(CI)I

    move-result v0

    int-to-short v0, v0

    .line 680
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

    .line 842
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v1, v1, p2

    .line 843
    if-ne p1, v1, :cond_1

    const/4 v0, 0x0

    .line 849
    :cond_0
    :goto_0
    return v0

    .line 844
    :cond_1
    invoke-direct {p0, p2, p1}, Lcom/mrkeyboard/app/MrFuzzy;->nearRank(IC)I

    move-result v2

    .line 845
    if-ltz v2, :cond_3

    if-eqz v2, :cond_0

    if-ne v2, v3, :cond_2

    const/16 v0, 0x1e

    goto :goto_0

    :cond_2
    const/16 v0, 0x23

    goto :goto_0

    .line 846
    :cond_3
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    invoke-virtual {v2, p1, v1}, Lcom/mrkeyboard/app/MrRules;->pair(CC)I

    move-result v1

    .line 847
    if-eq v1, v3, :cond_0

    .line 848
    const/4 v0, 0x2

    if-ne v1, v0, :cond_4

    const/16 v0, 0x2d

    goto :goto_0

    .line 849
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

    .line 411
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 417
    :cond_0
    :goto_0
    return-void

    .line 412
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

    .line 413
    invoke-static {p1, v1}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 414
    if-ltz v2, :cond_0

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    if-ne v3, v2, :cond_0

    .line 415
    invoke-virtual {v1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v1

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v0

    .line 416
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

    .line 404
    const/16 v0, 0x14

    if-lt p0, v0, :cond_1

    move v0, v1

    .line 407
    :cond_0
    :goto_0
    return v0

    .line 405
    :cond_1
    invoke-static {p1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    .line 406
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

    .line 407
    goto :goto_0
.end method

.method private static validAlternative(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V
    .locals 6

    .prologue
    .line 225
    const/4 v0, 0x3

    if-lt p3, v0, :cond_0

    const/16 v0, 0xc

    if-le p3, v0, :cond_1

    .line 241
    :cond_0
    :goto_0
    return-void

    .line 226
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v0

    .line 227
    if-eqz v0, :cond_0

    .line 228
    invoke-virtual {v0}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v0}, Lcom/mrkeyboard/app/BinaryDictionary;->mrLength()I

    move-result v0

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;

    move-result-object v0

    .line 229
    if-eqz v0, :cond_0

    .line 230
    monitor-enter v0

    .line 231
    :try_start_0
    invoke-virtual {v0, p2}, Lcom/mrkeyboard/app/MrFuzzy;->ownFrequency(Ljava/lang/CharSequence;)I

    move-result v2

    .line 232
    const/4 v1, 0x5

    if-le v2, v1, :cond_2

    const/16 v1, 0x50

    if-le v2, v1, :cond_3

    :cond_2
    monitor-exit v0

    goto :goto_0

    .line 240
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    .line 233
    :cond_3
    :try_start_1
    invoke-virtual {v0, p1, p2}, Lcom/mrkeyboard/app/MrFuzzy;->search(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;)V

    .line 234
    invoke-interface {p2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    const/16 v3, 0x28

    const/16 v4, 0x6e

    const/16 v5, 0x3c

    invoke-virtual/range {v0 .. v5}, Lcom/mrkeyboard/app/MrFuzzy;->alternative(Ljava/lang/String;IIII)Ljava/lang/String;

    move-result-object v1

    .line 235
    if-eqz v1, :cond_4

    .line 236
    invoke-interface {p2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 237
    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 238
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPredict;->inContext(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-static {p2}, Lcom/mrkeyboard/app/MrPredict;->inContext(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_5

    const/4 v1, 0x1

    :goto_1
    sput-boolean v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveFirst:Z

    .line 240
    :cond_4
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 238
    :cond_5
    const/4 v1, 0x0

    goto :goto_1
.end method

.method private walk(IIIC)V
    .locals 29

    .prologue
    .line 686
    if-ltz p1, :cond_0

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    move/from16 v0, p1

    if-lt v0, v4, :cond_1

    .line 800
    :cond_0
    return-void

    .line 687
    :cond_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    move/from16 v0, p1

    invoke-virtual {v4, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v0, v4, 0xff

    move/from16 v22, v0

    .line 688
    add-int/lit8 v6, p1, 0x1

    .line 689
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v14, v4, p2

    .line 690
    if-lez p2, :cond_4

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v5, p2, -0x1

    aget-object v4, v4, v5

    .line 691
    :goto_0
    move-object/from16 v0, p0

    iget v0, v0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move/from16 v17, v0

    .line 692
    const/4 v5, 0x0

    move/from16 v21, v5

    move-object v13, v4

    :goto_1
    move/from16 v0, v21

    move/from16 v1, v22

    if-ge v0, v1, :cond_0

    .line 693
    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v6, v4, :cond_0

    .line 694
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v5, v6, 0x1

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 695
    const/16 v6, 0xff

    if-ne v4, v6, :cond_2

    .line 696
    add-int/lit8 v4, v5, 0x1

    move-object/from16 v0, p0

    iget v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v6, :cond_0

    .line 697
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

    .line 698
    add-int/lit8 v5, v5, 0x2

    .line 700
    :cond_2
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v6, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    and-int/lit16 v7, v6, 0xff

    .line 701
    and-int/lit16 v6, v7, 0x80

    if-eqz v6, :cond_5

    const/4 v6, 0x1

    move/from16 v20, v6

    .line 702
    :goto_2
    const/4 v6, 0x0

    .line 703
    and-int/lit8 v7, v7, 0x40

    if-eqz v7, :cond_6

    .line 704
    move-object/from16 v0, p0

    iget v6, v0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v6, v5

    add-int/lit8 v6, v6, -0x1

    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v6, v7, :cond_0

    .line 705
    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrFuzzy;->addrAt(I)I

    move-result v6

    .line 706
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v7, v5

    move/from16 v19, v6

    .line 710
    :goto_3
    const/4 v5, 0x0

    .line 711
    if-eqz v20, :cond_29

    .line 712
    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v7, v5, :cond_0

    .line 713
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v6, v7, 0x1

    invoke-virtual {v5, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 714
    move-object/from16 v0, p0

    iget-boolean v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v7, :cond_3

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v6

    .line 716
    :cond_3
    :goto_4
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    add-int/lit8 v7, v7, 0x1

    move-object/from16 v0, p0

    iput v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v8, 0x2ee0

    if-gt v7, v8, :cond_0

    .line 717
    const/16 v7, 0x100

    if-ge v4, v7, :cond_7

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v7, v7, v4

    move/from16 v18, v7

    .line 718
    :goto_5
    if-nez p2, :cond_c

    .line 719
    const/16 v7, 0x100

    move/from16 v0, v18

    if-lt v0, v7, :cond_8

    move-object v4, v13

    move-object v5, v14

    .line 692
    :goto_6
    add-int/lit8 v7, v21, 0x1

    move/from16 v21, v7

    move-object v13, v4

    move-object v14, v5

    goto/16 :goto_1

    .line 690
    :cond_4
    const/4 v4, 0x0

    goto/16 :goto_0

    .line 701
    :cond_5
    const/4 v6, 0x0

    move/from16 v20, v6

    goto :goto_2

    .line 708
    :cond_6
    add-int/lit8 v7, v5, 0x1

    move/from16 v19, v6

    goto :goto_3

    .line 717
    :cond_7
    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    move/from16 v18, v7

    goto :goto_5

    .line 720
    :cond_8
    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v8, 0x3

    if-ne v7, v8, :cond_9

    .line 721
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aget-boolean v7, v7, v18

    if-eqz v7, :cond_c

    move-object v4, v13

    move-object v5, v14

    goto :goto_6

    .line 723
    :cond_9
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mFirst:[Z

    aget-boolean v7, v7, v18

    if-nez v7, :cond_a

    move-object v4, v13

    move-object v5, v14

    goto :goto_6

    .line 724
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

    .line 725
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

    .line 728
    :cond_c
    int-to-char v0, v4

    move/from16 v23, v0

    .line 729
    const/16 v7, 0x100

    if-ge v4, v7, :cond_e

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    aget-char v4, v7, v4

    .line 730
    :goto_7
    move-object/from16 v0, p0

    move/from16 v1, v18

    move/from16 v2, p3

    move/from16 v3, p2

    invoke-direct {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrFuzzy;->delCost(III)I

    move-result v24

    .line 732
    const/4 v10, -0x1

    const/4 v9, -0x1

    .line 733
    if-eqz v13, :cond_11

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v7, v7, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    array-length v7, v7

    if-lez v7, :cond_11

    .line 734
    const/16 v7, 0x100

    move/from16 v0, p4

    if-ge v0, v7, :cond_f

    sget-object v7, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    aget-char v7, v7, p4

    .line 735
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

    .line 736
    const/4 v8, 0x0

    :goto_9
    array-length v0, v11

    move/from16 v16, v0

    move/from16 v0, v16

    if-ge v8, v0, :cond_11

    .line 737
    aget-char v16, v11, v8

    move/from16 v0, v16

    if-ne v0, v7, :cond_d

    aget-char v16, v12, v8

    move/from16 v0, v16

    if-ne v0, v4, :cond_d

    .line 738
    if-gez v10, :cond_10

    aget-char v10, v15, v8

    .line 736
    :cond_d
    :goto_a
    add-int/lit8 v8, v8, 0x1

    goto :goto_9

    .line 729
    :cond_e
    invoke-static/range {v23 .. v23}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v4

    goto :goto_7

    .line 734
    :cond_f
    invoke-static/range {p4 .. p4}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v7

    goto :goto_8

    .line 739
    :cond_10
    if-gez v9, :cond_d

    aget-char v9, v15, v8

    goto :goto_a

    .line 743
    :cond_11
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    add-int/lit8 v8, p2, 0x1

    aget-object v25, v7, v8

    .line 744
    add-int/lit8 v7, p2, 0x1

    .line 745
    move-object/from16 v0, p0

    iget v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    sub-int v8, v7, v8

    .line 746
    move-object/from16 v0, p0

    iget v11, v0, Lcom/mrkeyboard/app/MrFuzzy;->mBand:I

    add-int/2addr v7, v11

    .line 747
    move/from16 v0, v17

    if-le v7, v0, :cond_28

    move/from16 v16, v17

    .line 748
    :goto_b
    const/high16 v12, 0x100000

    .line 749
    if-gtz v8, :cond_1c

    .line 750
    const/4 v7, 0x0

    aget v7, v14, v7

    add-int v7, v7, v24

    .line 751
    const/high16 v8, 0x100000

    if-le v7, v8, :cond_12

    const/high16 v7, 0x100000

    .line 752
    :cond_12
    const/4 v8, 0x0

    aput v7, v25, v8

    .line 754
    const/4 v8, 0x1

    move v12, v7

    .line 758
    :goto_c
    add-int/lit8 v7, v16, 0x1

    move/from16 v0, v17

    if-gt v7, v0, :cond_13

    add-int/lit8 v7, v16, 0x1

    const/high16 v11, 0x100000

    aput v11, v25, v7

    .line 759
    :cond_13
    add-int/lit8 v7, v16, 0x2

    move/from16 v0, v17

    if-gt v7, v0, :cond_14

    add-int/lit8 v7, v16, 0x2

    const/high16 v11, 0x100000

    aput v11, v25, v7

    .line 760
    :cond_14
    if-nez p2, :cond_1d

    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    const/4 v11, 0x3

    if-ne v7, v11, :cond_1d

    const/4 v7, 0x1

    :goto_d
    move v15, v8

    .line 761
    :goto_e
    move/from16 v0, v16

    if-gt v15, v0, :cond_1f

    .line 762
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v11, v15, -0x1

    aget-char v26, v8, v11

    .line 764
    if-eqz v7, :cond_1e

    const/high16 v8, 0x100000

    .line 765
    :goto_f
    add-int/lit8 v11, v15, -0x1

    aget v11, v25, v11

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/mrkeyboard/app/MrFuzzy;->mIns:[I

    move-object/from16 v27, v0

    add-int/lit8 v28, v15, -0x1

    aget v27, v27, v28

    add-int v11, v11, v27

    .line 766
    if-ge v11, v8, :cond_15

    move v8, v11

    .line 767
    :cond_15
    aget v11, v14, v15

    add-int v11, v11, v24

    .line 768
    if-ge v11, v8, :cond_27

    .line 769
    :goto_10
    const/4 v8, 0x2

    if-lt v15, v8, :cond_26

    .line 770
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

    .line 771
    add-int/lit8 v8, v15, -0x2

    aget v8, v13, v8

    add-int/lit8 v8, v8, 0x28

    .line 772
    if-ge v8, v11, :cond_25

    .line 774
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

    .line 775
    :cond_17
    add-int/lit8 v11, v15, -0x2

    aget v11, v14, v11

    add-int/lit8 v11, v11, 0x23

    .line 776
    if-ge v11, v8, :cond_18

    move v8, v11

    .line 779
    :cond_18
    :goto_12
    if-ltz v10, :cond_1a

    move/from16 v0, v26

    if-eq v0, v10, :cond_19

    move/from16 v0, v26

    if-ne v0, v9, :cond_1a

    .line 780
    :cond_19
    add-int/lit8 v11, v15, -0x1

    aget v11, v13, v11

    add-int/lit8 v11, v11, 0x23

    .line 781
    if-ge v11, v8, :cond_1a

    move v8, v11

    .line 783
    :cond_1a
    const/high16 v11, 0x100000

    if-le v8, v11, :cond_1b

    const/high16 v8, 0x100000

    .line 784
    :cond_1b
    aput v8, v25, v15

    .line 785
    if-ge v8, v12, :cond_24

    .line 761
    :goto_13
    add-int/lit8 v11, v15, 0x1

    move v15, v11

    move v12, v8

    goto/16 :goto_e

    .line 756
    :cond_1c
    add-int/lit8 v7, v8, -0x1

    const/high16 v11, 0x100000

    aput v11, v25, v7

    goto/16 :goto_c

    .line 760
    :cond_1d
    const/4 v7, 0x0

    goto/16 :goto_d

    .line 764
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

    .line 787
    :cond_1f
    const/16 v4, 0x30

    move/from16 v0, p2

    if-ge v0, v4, :cond_20

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    aput-char v23, v4, p2

    .line 788
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

    .line 789
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mPath:[C

    add-int/lit8 v7, p2, 0x1

    aget v8, v25, v17

    move-object/from16 v0, p0

    invoke-direct {v0, v4, v7, v5, v8}, Lcom/mrkeyboard/app/MrFuzzy;->offer([CIII)V

    .line 791
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

    .line 793
    add-int/lit8 v4, p2, 0x1

    move-object/from16 v0, p0

    move/from16 v1, v19

    move/from16 v2, v18

    move/from16 v3, v23

    invoke-direct {v0, v1, v4, v2, v3}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 794
    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v5, 0x2ee0

    if-gt v4, v5, :cond_0

    .line 796
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    aget-object v5, v4, p2

    .line 797
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

    .line 583
    const/4 v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 584
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v2, v2, v2}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 585
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v1, 0x2ee0

    if-le v0, v1, :cond_0

    .line 589
    :goto_0
    return-void

    .line 586
    :cond_0
    const/4 v0, 0x2

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 587
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v0, v2, v2, v2}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 588
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    goto :goto_0
.end method


# virtual methods
.method alternative(Ljava/lang/String;IIII)Ljava/lang/String;
    .locals 20

    .prologue
    .line 258
    invoke-static/range {p1 .. p1}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 259
    const/4 v2, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v8

    .line 260
    const-wide/16 v2, 0x1

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    const/16 v5, 0x18

    invoke-static {v4, v5}, Ljava/lang/Math;->min(II)I

    move-result v4

    add-int/lit8 v4, v4, 0x1

    shl-long/2addr v2, v4

    long-to-double v10, v2

    .line 261
    const/4 v4, 0x0

    .line 262
    const/4 v3, 0x0

    .line 263
    const/4 v2, 0x0

    move v6, v2

    move v2, v3

    :goto_0
    move-object/from16 v0, p0

    iget v3, v0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v6, v3, :cond_3

    .line 264
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    aget v3, v3, v6

    .line 265
    if-lez v3, :cond_4

    move/from16 v0, p3

    if-le v3, v0, :cond_0

    move-object v3, v4

    .line 263
    :goto_1
    add-int/lit8 v4, v6, 0x1

    move v6, v4

    move-object v4, v3

    goto :goto_0

    .line 266
    :cond_0
    move-object/from16 v0, p0

    invoke-virtual {v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->resultWord(I)Ljava/lang/String;

    move-result-object v5

    .line 267
    const/16 v9, 0x20

    invoke-virtual {v5, v9}, Ljava/lang/String;->indexOf(I)I

    move-result v9

    if-gez v9, :cond_4

    invoke-static {v5}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    move-object v3, v4

    goto :goto_1

    .line 268
    :cond_1
    if-nez v8, :cond_2

    const/4 v9, 0x0

    invoke-virtual {v5, v9}, Ljava/lang/String;->charAt(I)C

    move-result v9

    invoke-static {v9}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v9

    if-eqz v9, :cond_2

    move-object v3, v4

    goto :goto_1

    .line 269
    :cond_2
    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v12, v9, v6

    long-to-double v12, v12

    div-double/2addr v12, v10

    const-wide/high16 v14, 0x4000000000000000L    # 2.0

    int-to-double v0, v3

    move-wide/from16 v16, v0

    const-wide/high16 v18, 0x4039000000000000L    # 25.0

    div-double v16, v16, v18

    invoke-static/range {v14 .. v17}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v14

    mul-double/2addr v12, v14

    invoke-static {v12, v13}, Ljava/lang/Math;->round(D)J

    move-result-wide v12

    long-to-int v3, v12

    .line 270
    move/from16 v0, p4

    if-lt v3, v0, :cond_4

    sub-int v9, v3, p2

    move/from16 v0, p5

    if-lt v9, v0, :cond_4

    if-le v3, v2, :cond_4

    move v2, v3

    move-object v3, v5

    .line 272
    goto :goto_1

    .line 275
    :cond_3
    return-object v4

    :cond_4
    move-object v3, v4

    goto :goto_1
.end method

.method emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V
    .locals 10

    .prologue
    const/4 v2, 0x0

    .line 939
    move v7, v2

    :goto_0
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v7, v0, :cond_0

    .line 940
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v4, v0, v7

    .line 941
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

    .line 939
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    .line 944
    :cond_0
    return-void
.end method

.method ownFrequency(Ljava/lang/CharSequence;)I
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 245
    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/16 v2, 0x14

    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 246
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move v0, v1

    .line 247
    :goto_0
    if-ge v0, v2, :cond_0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    invoke-interface {p1, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v4

    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v4

    aput-char v4, v3, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 248
    :cond_0
    iput v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    .line 249
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v0

    return v0
.end method

.method resultCost(I)I
    .locals 1

    .prologue
    .line 478
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    aget v0, v0, p1

    return v0
.end method

.method resultCount()I
    .locals 1

    .prologue
    .line 475
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    return v0
.end method

.method resultScore(I)J
    .locals 2

    .prologue
    .line 477
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v0, v0, p1

    return-wide v0
.end method

.method resultWord(I)Ljava/lang/String;
    .locals 4

    .prologue
    .line 476
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
    .line 481
    invoke-interface {p2}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/16 v1, 0x14

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 482
    iput v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    .line 483
    const/4 v0, 0x0

    move v4, v0

    :goto_0
    if-ge v4, v5, :cond_4

    .line 484
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    invoke-interface {p2, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    aput-char v1, v0, v4

    .line 485
    const/4 v1, 0x0

    .line 486
    if-eqz p1, :cond_1

    invoke-virtual {p1, v4}, Lcom/mrkeyboard/app/WordComposer;->getCodesAt(I)[I

    move-result-object v0

    move-object v3, v0

    .line 487
    :goto_1
    if-eqz v3, :cond_0

    .line 488
    const/4 v0, 0x1

    :goto_2
    array-length v2, v3

    if-ge v0, v2, :cond_0

    const/16 v2, 0x10

    if-ge v1, v2, :cond_0

    .line 489
    aget v2, v3, v0

    .line 490
    if-gtz v2, :cond_2

    .line 495
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aput v1, v0, v4

    .line 496
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSub:[[S

    aget-object v0, v0, v4

    const/4 v1, -0x1

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([SS)V

    .line 483
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_0

    .line 486
    :cond_1
    const/4 v0, 0x0

    move-object v3, v0

    goto :goto_1

    .line 491
    :cond_2
    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v6

    .line 492
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v2, v2, v4

    if-eq v6, v2, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v7, v2, v4

    add-int/lit8 v2, v1, 0x1

    aput-char v6, v7, v1

    move v1, v2

    .line 488
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 498
    :cond_4
    invoke-static {}, Lcom/mrkeyboard/app/MrRules;->get()Lcom/mrkeyboard/app/MrRules;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 501
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->searchNative()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 547
    :cond_5
    :goto_3
    return-void

    .line 502
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

    .line 503
    :cond_7
    const/4 v0, 0x2

    move v3, v0

    :goto_5
    if-gt v3, v5, :cond_b

    .line 504
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v1, v3, -0x2

    aget-char v4, v0, v1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    add-int/lit8 v1, v3, -0x1

    aget-char v6, v0, v1

    .line 505
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 506
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v7, v0, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v8, v0, Lcom/mrkeyboard/app/MrRules;->t2b:[C

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    iget-object v9, v0, Lcom/mrkeyboard/app/MrRules;->t2d:[C

    .line 507
    const/4 v0, 0x0

    :goto_6
    array-length v10, v7

    if-ge v0, v10, :cond_a

    .line 508
    aget-char v10, v7, v0

    if-ne v10, v4, :cond_8

    aget-char v10, v8, v0

    if-ne v10, v6, :cond_8

    .line 509
    if-nez v2, :cond_9

    aget-char v2, v9, v0

    .line 507
    :cond_8
    :goto_7
    add-int/lit8 v0, v0, 0x1

    goto :goto_6

    .line 510
    :cond_9
    if-nez v1, :cond_8

    aget-char v1, v9, v0

    goto :goto_7

    .line 513
    :cond_a
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD1:[C

    aput-char v2, v0, v3

    .line 514
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTwoD2:[C

    aput-char v1, v0, v3

    .line 503
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_5

    .line 516
    :cond_b
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->firstLetters()V

    .line 517
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 518
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    .line 519
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRows:[[I

    const/4 v1, 0x0

    aget-object v1, v0, v1

    .line 520
    const/4 v0, 0x0

    const/4 v2, 0x0

    aput v2, v1, v0

    .line 521
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

    .line 527
    :cond_c
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->isPrefix()Z

    move-result v1

    .line 528
    if-eqz v1, :cond_d

    const/4 v0, 0x4

    if-lt v5, v0, :cond_f

    .line 529
    :cond_d
    if-eqz v1, :cond_10

    const/4 v0, 0x4

    if-ne v5, v0, :cond_10

    const/16 v0, 0x28

    :goto_9
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 530
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->walkRoot()V

    .line 531
    if-nez v1, :cond_e

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    const/16 v2, 0x2ee0

    if-gt v0, v2, :cond_e

    .line 534
    const/4 v0, 0x6

    if-lt v5, v0, :cond_13

    const/16 v0, 0x1e

    :goto_a
    add-int/lit8 v0, v0, 0x1e

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 535
    const/4 v0, 0x3

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 536
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-direct {p0, v0, v2, v3, v4}, Lcom/mrkeyboard/app/MrFuzzy;->walk(IIIC)V

    .line 537
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOnlyTyped:I

    .line 539
    :cond_e
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-nez v0, :cond_f

    if-nez v1, :cond_f

    const/4 v0, 0x6

    if-lt v5, v0, :cond_f

    .line 541
    const/4 v0, 0x7

    if-gt v5, v0, :cond_14

    const/16 v0, 0x64

    :goto_b
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrFuzzy;->setMaxCost(I)V

    .line 542
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->walkRoot()V

    .line 545
    :cond_f
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mVisits:I

    sput v0, Lcom/mrkeyboard/app/MrFuzzy;->sLastVisits:I

    .line 546
    const/4 v0, 0x4

    if-lt v5, v0, :cond_5

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->split()V

    goto/16 :goto_3

    .line 529
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

    .line 534
    :cond_13
    const/4 v0, 0x0

    goto :goto_a

    .line 541
    :cond_14
    const/16 v0, 0x78

    goto :goto_b
.end method
