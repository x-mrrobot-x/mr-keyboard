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

.field private final mDict:Ljava/nio/ByteBuffer;

.field private mGuard:I

.field private final mLatest:Z

.field private final mLookBuf:[C

.field private mLookFreq:I

.field private mLookLen:I

.field private final mLookPath:[C

.field private mN:I

.field private final mNear:[[C

.field private final mNearCount:[I

.field private final mNearFlat:[C

.field private final mOutInfo:[I

.field private final mOutScores:[J

.field private final mOutWords:[C

.field private mR:Lcom/mrkeyboard/app/MrRules;

.field private final mResCost:[I

.field private mResCount:I

.field private final mResLen:[I

.field private final mResScore:[J

.field private final mResWord:[[C

.field private final mRoot:I

.field private final mSize:I

.field private final mTb:[C


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

    .line 129
    :cond_0
    const/16 v0, 0xc

    filled-new-array {v4, v0}, [I

    move-result-object v0

    sget-object v1, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v1, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    .line 130
    new-array v0, v4, [I

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchCount:[I

    return-void
.end method

.method constructor <init>(Ljava/nio/ByteBuffer;I)V
    .locals 7

    .prologue
    const/16 v6, 0x14

    const/4 v1, 0x1

    const/4 v3, 0x2

    const/4 v2, 0x0

    const/4 v5, 0x5

    .line 135
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

    .line 89
    sget-object v0, Lcom/mrkeyboard/app/MrRules;->EMPTY:Lcom/mrkeyboard/app/MrRules;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 92
    const/16 v0, 0x62

    filled-new-array {v5, v0}, [I

    move-result-object v0

    sget-object v4, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v4, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    .line 93
    new-array v0, v5, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    .line 94
    new-array v0, v5, [J

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    .line 95
    new-array v0, v5, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    .line 99
    const/16 v0, 0x140

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearFlat:[C

    .line 100
    const/16 v0, 0x1ea

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutWords:[C

    .line 101
    const/16 v0, 0xb

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    .line 102
    new-array v0, v5, [J

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutScores:[J

    .line 554
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    .line 555
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    .line 136
    iput-object p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    .line 137
    iput p2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    .line 139
    const/4 v0, 0x3

    .line 140
    if-le p2, v3, :cond_4

    .line 141
    invoke-virtual {p1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 142
    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 143
    const/16 v6, 0xc8

    if-lt v4, v6, :cond_3

    if-eqz v5, :cond_0

    if-eq v5, v1, :cond_0

    if-ne v5, v3, :cond_3

    .line 144
    :cond_0
    :goto_0
    if-eqz v1, :cond_1

    if-ne v5, v3, :cond_1

    const/4 v0, 0x4

    .line 146
    :cond_1
    :goto_1
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    .line 147
    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    .line 148
    if-eqz v1, :cond_2

    move v2, v3

    :cond_2
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    .line 149
    return-void

    :cond_3
    move v1, v2

    .line 143
    goto :goto_0

    :cond_4
    move v1, v2

    goto :goto_1
.end method

.method private addrAt(I)I
    .locals 3

    .prologue
    .line 525
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

    .line 526
    shl-int/lit8 v0, v0, 0x8

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, p1, 0x2

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    or-int/2addr v0, v1

    .line 527
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

    .line 169
    const/4 v1, 0x0

    :try_start_0
    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 170
    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 171
    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveFirst:Z

    .line 172
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 207
    :cond_0
    :goto_0
    return-void

    .line 173
    :cond_1
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->size()I

    move-result v1

    .line 174
    const/4 v2, 0x2

    if-lt v1, v2, :cond_0

    const/16 v2, 0x14

    if-gt v1, v2, :cond_0

    .line 176
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrRecent;->complete(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V

    .line 178
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPredict;->complete(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V

    .line 179
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->getTypedWord()Ljava/lang/CharSequence;

    move-result-object v2

    .line 180
    if-eqz v2, :cond_0

    .line 181
    invoke-static {p1, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->rememberTouches(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V

    .line 182
    invoke-static {v2}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    .line 183
    if-eqz v3, :cond_2

    .line 184
    invoke-virtual {v3}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 185
    const/4 v2, 0x0

    array-length v3, v1

    const v4, 0x1fffffff

    const/4 v5, 0x1

    sget-object v6, Lcom/mrkeyboard/app/Dictionary$DataType;->UNIGRAM:Lcom/mrkeyboard/app/Dictionary$DataType;

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/Suggest;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z

    goto :goto_0

    .line 204
    :catch_0
    move-exception v0

    goto :goto_0

    .line 188
    :cond_2
    const/4 v3, 0x3

    if-lt v1, v3, :cond_0

    .line 189
    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/Suggest;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 190
    invoke-static {p0, p1, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->validAlternative(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V

    goto :goto_0

    .line 193
    :cond_3
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v1

    .line 194
    if-eqz v1, :cond_0

    .line 195
    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrLength()I

    move-result v1

    invoke-static {v3, v1}, Lcom/mrkeyboard/app/MrFuzzy;->forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;

    move-result-object v1

    .line 196
    if-eqz v1, :cond_0

    .line 197
    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 198
    :try_start_1
    invoke-virtual {v1, p1, v2}, Lcom/mrkeyboard/app/MrFuzzy;->search(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;)V

    .line 199
    invoke-virtual {v1, p0}, Lcom/mrkeyboard/app/MrFuzzy;->emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V

    .line 200
    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 201
    iget v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-lez v2, :cond_4

    iget-object v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    const/4 v3, 0x0

    aget v2, v2, v3

    const/16 v3, 0x2d

    if-gt v2, v3, :cond_4

    .line 202
    const/4 v0, 0x0

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->resultWord(I)Ljava/lang/String;

    move-result-object v0

    :cond_4
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 203
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
    .line 430
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    new-array v1, v0, [C

    .line 431
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

    .line 432
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

    .line 406
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 407
    if-eqz v0, :cond_1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 426
    :cond_0
    :goto_0
    return v1

    .line 408
    :cond_1
    const/16 v0, 0x20

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_2

    move v1, v3

    goto :goto_0

    .line 409
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-static {p1}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 410
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v2, 0x5

    if-gt v0, v2, :cond_4

    move v0, v1

    .line 411
    :goto_1
    invoke-static {v5, v6, v0}, Lcom/mrkeyboard/app/MrFuzzy;->distance(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v2

    if-le v2, v0, :cond_0

    .line 415
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v4

    if-ne v2, v4, :cond_9

    sget-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_9

    .line 416
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

    .line 418
    :goto_2
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v7

    if-ge v2, v7, :cond_8

    .line 419
    invoke-virtual {v5, v2}, Ljava/lang/String;->charAt(I)C

    move-result v7

    invoke-virtual {v6, v2}, Ljava/lang/String;->charAt(I)C

    move-result v8

    if-ne v7, v8, :cond_5

    .line 418
    :goto_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 410
    :cond_4
    const/4 v0, 0x2

    goto :goto_1

    .line 420
    :cond_5
    invoke-virtual {v6, v2}, Ljava/lang/String;->charAt(I)C

    move-result v7

    invoke-static {v2, v7}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v7

    .line 421
    if-ltz v7, :cond_6

    if-le v7, v1, :cond_7

    :cond_6
    move v1, v3

    goto :goto_0

    .line 422
    :cond_7
    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    .line 424
    :cond_8
    mul-int/lit8 v0, v0, 0x2

    if-le v4, v0, :cond_0

    move v1, v3

    goto :goto_0

    :cond_9
    move v1, v3

    .line 426
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

    .line 369
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 374
    :cond_0
    :goto_0
    return-void

    .line 370
    :cond_1
    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrFuzzy;->isCaseVariant(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 371
    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 372
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 373
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
    .line 437
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v7

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v8

    .line 438
    sub-int v0, v7, v8

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    if-le v0, p2, :cond_0

    add-int/lit8 v0, p2, 0x1

    .line 456
    :goto_0
    return v0

    .line 439
    :cond_0
    add-int/lit8 v0, v8, 0x1

    new-array v5, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v4, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v1, v0, [I

    .line 440
    const/4 v0, 0x0

    :goto_1
    if-gt v0, v8, :cond_1

    aput v0, v4, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 441
    :cond_1
    const/4 v0, 0x1

    move v3, v0

    move-object v6, v4

    move-object v4, v1

    :goto_2
    if-gt v3, v7, :cond_6

    .line 442
    const/4 v0, 0x0

    aput v3, v4, v0

    .line 443
    const/4 v0, 0x0

    aget v1, v4, v0

    .line 444
    const/4 v0, 0x1

    move v2, v0

    :goto_3
    if-gt v2, v8, :cond_4

    .line 445
    add-int/lit8 v0, v3, -0x1

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    add-int/lit8 v9, v2, -0x1

    invoke-virtual {p1, v9}, Ljava/lang/String;->charAt(I)C

    move-result v9

    if-ne v0, v9, :cond_3

    const/4 v0, 0x0

    .line 446
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

    .line 447
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

    .line 448
    add-int/lit8 v9, v2, -0x2

    aget v9, v5, v9

    add-int/lit8 v9, v9, 0x1

    invoke-static {v0, v9}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 450
    :cond_2
    aput v0, v4, v2

    .line 451
    if-ge v0, v1, :cond_7

    .line 444
    :goto_5
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    move v1, v0

    goto :goto_3

    .line 445
    :cond_3
    const/4 v0, 0x1

    goto :goto_4

    .line 453
    :cond_4
    if-le v1, p2, :cond_5

    add-int/lit8 v0, p2, 0x1

    goto/16 :goto_0

    .line 441
    :cond_5
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    move-object v11, v5

    move-object v5, v6

    move-object v6, v4

    move-object v4, v11

    goto :goto_2

    .line 456
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

    .line 296
    sget-object v4, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 297
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 298
    sget-boolean v6, Lcom/mrkeyboard/app/MrFuzzy;->sReserveFirst:Z

    .line 300
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 301
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 302
    sput-boolean v3, Lcom/mrkeyboard/app/MrFuzzy;->sReserveFirst:Z

    .line 304
    if-eqz p0, :cond_0

    :try_start_0
    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    move v0, p1

    .line 357
    :goto_0
    return v0

    .line 305
    :cond_1
    const/4 v0, 0x0

    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v7

    .line 306
    if-eqz v1, :cond_b

    invoke-virtual {v7, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_b

    .line 308
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

    .line 309
    invoke-virtual {v1}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    .line 313
    :cond_2
    :goto_1
    const/4 v5, -0x1

    move v4, v2

    .line 314
    :goto_2
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v4, v0, :cond_12

    .line 315
    invoke-interface {p0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_7

    move v0, v4

    .line 317
    :goto_3
    if-eqz v6, :cond_8

    .line 319
    if-eq v0, v2, :cond_4

    .line 320
    if-lez v0, :cond_3

    invoke-interface {p0, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 321
    :cond_3
    const/4 v0, 0x1

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v4

    invoke-static {v0, v4}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-interface {p0, v0, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    :cond_4
    move v4, v2

    .line 330
    :goto_4
    invoke-static {p0}, Lcom/mrkeyboard/app/MrLearned;->filter(Ljava/util/List;)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    if-eqz v0, :cond_11

    move v1, v3

    .line 333
    :goto_5
    :try_start_1
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v0

    if-ne v0, v2, :cond_e

    .line 334
    invoke-static {v7}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 335
    if-eqz v0, :cond_e

    invoke-virtual {v0, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 336
    const/4 v3, 0x0

    invoke-virtual {v7, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v3

    if-eqz v3, :cond_c

    .line 337
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

    .line 338
    :goto_6
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v3, v0

    :goto_7
    if-lt v3, v2, :cond_d

    .line 339
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

    .line 338
    :cond_5
    add-int/lit8 v0, v3, -0x1

    move v3, v0

    goto :goto_7

    .line 310
    :cond_6
    const/4 v0, 0x0

    :try_start_2
    invoke-virtual {v7, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 311
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

    .line 314
    :cond_7
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_2

    .line 324
    :cond_8
    if-ltz v0, :cond_9

    if-le v0, v8, :cond_b

    .line 325
    :cond_9
    if-le v0, v8, :cond_a

    invoke-interface {p0, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 326
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

    .line 337
    goto :goto_6

    .line 341
    :cond_d
    const/4 v0, 0x1

    :try_start_3
    invoke-interface {p0, v0, v4}, Ljava/util/List;->add(ILjava/lang/Object;)V

    move v0, v2

    .line 342
    goto/16 :goto_0

    .line 347
    :cond_e
    invoke-static {p0, v7}, Lcom/mrkeyboard/app/MrFuzzy;->demoteCaseVariant(Ljava/util/List;Ljava/lang/String;)V

    .line 350
    if-nez v4, :cond_f

    invoke-static {p0, v7}, Lcom/mrkeyboard/app/MrFuzzy;->touchOrder(Ljava/util/List;Ljava/lang/String;)V

    .line 351
    :cond_f
    if-eqz v1, :cond_10

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v0, v8, :cond_10

    .line 352
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

    .line 354
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

.method static declared-synchronized forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;
    .locals 3

    .prologue
    .line 152
    const-class v1, Lcom/mrkeyboard/app/MrFuzzy;

    monitor-enter v1

    if-eqz p0, :cond_0

    const/4 v0, 0x2

    if-gt p1, v0, :cond_2

    :cond_0
    const/4 v0, 0x0

    .line 158
    :cond_1
    :goto_0
    monitor-exit v1

    return-object v0

    .line 153
    :cond_2
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;

    .line 154
    if-eqz v0, :cond_3

    iget-object v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    if-ne v2, p0, :cond_3

    iget v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-eq v2, p1, :cond_1

    .line 155
    :cond_3
    new-instance v0, Lcom/mrkeyboard/app/MrFuzzy;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrFuzzy;-><init>(Ljava/nio/ByteBuffer;I)V

    .line 156
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 152
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static isCaseVariant(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 362
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    if-ne v1, v2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 365
    :cond_0
    :goto_0
    return v0

    .line 363
    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 364
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 365
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_0
.end method

.method private lookup(II)I
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 561
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 562
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 563
    sub-int v1, p2, p1

    const/16 v2, 0x30

    if-le v1, v2, :cond_0

    .line 565
    :goto_0
    return v0

    .line 564
    :cond_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v1, p1, p2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->lookupRec(IIII)V

    .line 565
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    goto :goto_0
.end method

.method private lookupRec(IIII)V
    .locals 10

    .prologue
    const/4 v3, 0x0

    .line 569
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 612
    :cond_0
    return-void

    .line 570
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    const/16 v1, 0x2ee0

    if-gt v0, v1, :cond_0

    .line 571
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v8, v0, 0xff

    .line 572
    add-int/lit8 v4, p1, 0x1

    .line 573
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v9, v0, p2

    move v7, v3

    .line 574
    :goto_0
    if-ge v7, v8, :cond_0

    .line 575
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v0, :cond_0

    .line 576
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v4, 0x1

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 577
    const/16 v2, 0xff

    if-ne v0, v2, :cond_2

    .line 578
    add-int/lit8 v0, v1, 0x1

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v0, v2, :cond_0

    .line 579
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

    .line 580
    add-int/lit8 v1, v1, 0x2

    .line 582
    :cond_2
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v2, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v4, v2, 0xff

    .line 583
    and-int/lit16 v2, v4, 0x80

    if-eqz v2, :cond_4

    const/4 v2, 0x1

    move v6, v2

    .line 585
    :goto_1
    and-int/lit8 v2, v4, 0x40

    if-eqz v2, :cond_5

    .line 586
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v2, v1

    add-int/lit8 v2, v2, -0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v2, v4, :cond_0

    .line 587
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->addrAt(I)I

    move-result v2

    .line 588
    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v1, v4

    move v5, v2

    .line 593
    :goto_2
    if-eqz v6, :cond_a

    .line 594
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    .line 595
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v1, 0x1

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 596
    iget-boolean v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v4, :cond_9

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v2

    move v4, v2

    move v2, v1

    .line 598
    :goto_3
    const/16 v1, 0x100

    if-ge v0, v1, :cond_6

    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v1, v1, v0

    .line 599
    :goto_4
    if-eq v1, v9, :cond_7

    .line 574
    :cond_3
    :goto_5
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    :cond_4
    move v6, v3

    .line 583
    goto :goto_1

    .line 590
    :cond_5
    add-int/lit8 v1, v1, 0x1

    move v5, v3

    goto :goto_2

    .line 598
    :cond_6
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    goto :goto_4

    .line 600
    :cond_7
    int-to-char v0, v0

    .line 601
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aput-char v0, v1, p4

    .line 602
    add-int/lit8 v0, p2, 0x1

    if-ne v0, p3, :cond_8

    .line 603
    if-eqz v6, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    if-le v2, v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aget-char v0, v0, v3

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-nez v0, :cond_3

    .line 604
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 605
    add-int/lit8 v0, p4, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 606
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    add-int/lit8 v2, p4, 0x1

    invoke-static {v0, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_5

    .line 608
    :cond_8
    if-eqz v5, :cond_3

    .line 609
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

.method private static oneSubAt(Ljava/lang/String;Ljava/lang/String;)I
    .locals 5

    .prologue
    const/4 v2, -0x1

    .line 378
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 386
    :cond_0
    :goto_0
    return v2

    .line 380
    :cond_1
    const/4 v0, 0x0

    move v1, v2

    :goto_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v0, v3, :cond_3

    .line 381
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v3

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v4

    if-eq v3, v4, :cond_2

    .line 382
    if-gez v1, :cond_0

    move v1, v0

    .line 380
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    move v2, v1

    .line 386
    goto :goto_0
.end method

.method private static rememberTouches(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V
    .locals 9

    .prologue
    const/4 v2, 0x0

    .line 266
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    move v4, v2

    .line 267
    :goto_0
    if-ge v4, p2, :cond_3

    .line 268
    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/WordComposer;->getCodesAt(I)[I

    move-result-object v5

    .line 270
    if-eqz v5, :cond_4

    .line 271
    invoke-interface {p1, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v6

    .line 272
    const/4 v0, 0x1

    move v1, v2

    :goto_1
    array-length v3, v5

    if-ge v0, v3, :cond_0

    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    aget-object v3, v3, v4

    array-length v3, v3

    if-ge v1, v3, :cond_0

    .line 273
    aget v3, v5, v0

    if-gtz v3, :cond_1

    .line 278
    :cond_0
    :goto_2
    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchCount:[I

    aput v1, v0, v4

    .line 267
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_0

    .line 274
    :cond_1
    aget v3, v5, v0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    .line 275
    if-eq v7, v6, :cond_2

    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    aget-object v8, v3, v4

    add-int/lit8 v3, v1, 0x1

    aput-char v7, v8, v1

    move v1, v3

    .line 272
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 280
    :cond_3
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    .line 281
    return-void

    :cond_4
    move v1, v2

    goto :goto_2
.end method

.method private searchNative()Z
    .locals 11

    .prologue
    const/4 v10, 0x0

    .line 496
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move v0, v10

    .line 497
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

    .line 498
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

    .line 499
    if-ltz v1, :cond_1

    const/4 v0, 0x5

    if-le v1, v0, :cond_2

    :cond_1
    move v0, v10

    .line 513
    :goto_1
    return v0

    :cond_2
    move v0, v10

    .line 500
    :goto_2
    if-ge v0, v1, :cond_5

    .line 501
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    mul-int/lit8 v3, v0, 0x2

    add-int/lit8 v3, v3, 0x1

    aget v2, v2, v3

    .line 502
    if-ltz v2, :cond_3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v3, v3, v0

    array-length v3, v3

    if-le v2, v3, :cond_4

    :cond_3
    move v0, v10

    goto :goto_1

    .line 500
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 504
    :cond_5
    iput v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    move v0, v10

    .line 505
    :goto_3
    if-ge v0, v1, :cond_6

    .line 506
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    mul-int/lit8 v3, v0, 0x2

    add-int/lit8 v3, v3, 0x1

    aget v2, v2, v3

    .line 507
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutWords:[C

    mul-int/lit8 v4, v0, 0x62

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v5, v5, v0

    invoke-static {v3, v4, v5, v10, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 508
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aput v2, v3, v0

    .line 509
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    mul-int/lit8 v4, v0, 0x2

    add-int/lit8 v4, v4, 0x2

    aget v3, v3, v4

    aput v3, v2, v0

    .line 510
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutScores:[J

    aget-wide v4, v3, v0

    aput-wide v4, v2, v0

    .line 505
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 512
    :cond_6
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    aget v0, v0, v10

    sput v0, Lcom/mrkeyboard/app/MrFuzzy;->sLastVisits:I

    .line 513
    const/4 v0, 0x1

    goto :goto_1
.end method

.method private skipBigrams(I)I
    .locals 3

    .prologue
    .line 531
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 541
    :cond_0
    :goto_0
    return p1

    .line 532
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    if-eqz v0, :cond_2

    .line 533
    const/4 v0, 0x0

    .line 534
    :goto_1
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v1, p1

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    add-int/lit8 v1, v0, 0x1

    const/16 v2, 0x2710

    if-ge v0, v2, :cond_0

    .line 535
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v0, p1

    .line 536
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 p1, v0, 0x1

    invoke-virtual {v2, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    .line 537
    if-eqz v0, :cond_0

    move v0, v1

    .line 538
    goto :goto_1

    .line 541
    :cond_2
    add-int/lit8 p1, p1, 0x1

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

    .line 397
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 403
    :cond_0
    :goto_0
    return-void

    .line 398
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

    .line 399
    invoke-static {p1, v1}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 400
    if-ltz v2, :cond_0

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    if-ne v3, v2, :cond_0

    .line 401
    invoke-virtual {v1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v1

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v0

    .line 402
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

    .line 390
    const/16 v0, 0x14

    if-lt p0, v0, :cond_1

    move v0, v1

    .line 393
    :cond_0
    :goto_0
    return v0

    .line 391
    :cond_1
    invoke-static {p1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    .line 392
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

    .line 393
    goto :goto_0
.end method

.method private static validAlternative(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V
    .locals 6

    .prologue
    .line 211
    const/4 v0, 0x3

    if-lt p3, v0, :cond_0

    const/16 v0, 0xc

    if-le p3, v0, :cond_1

    .line 227
    :cond_0
    :goto_0
    return-void

    .line 212
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v0

    .line 213
    if-eqz v0, :cond_0

    .line 214
    invoke-virtual {v0}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v0}, Lcom/mrkeyboard/app/BinaryDictionary;->mrLength()I

    move-result v0

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;

    move-result-object v0

    .line 215
    if-eqz v0, :cond_0

    .line 216
    monitor-enter v0

    .line 217
    :try_start_0
    invoke-virtual {v0, p2}, Lcom/mrkeyboard/app/MrFuzzy;->ownFrequency(Ljava/lang/CharSequence;)I

    move-result v2

    .line 218
    const/4 v1, 0x5

    if-le v2, v1, :cond_2

    const/16 v1, 0x50

    if-le v2, v1, :cond_3

    :cond_2
    monitor-exit v0

    goto :goto_0

    .line 226
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    .line 219
    :cond_3
    :try_start_1
    invoke-virtual {v0, p1, p2}, Lcom/mrkeyboard/app/MrFuzzy;->search(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;)V

    .line 220
    invoke-interface {p2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    const/16 v3, 0x28

    const/16 v4, 0x6e

    const/16 v5, 0x3c

    invoke-virtual/range {v0 .. v5}, Lcom/mrkeyboard/app/MrFuzzy;->alternative(Ljava/lang/String;IIII)Ljava/lang/String;

    move-result-object v1

    .line 221
    if-eqz v1, :cond_4

    .line 222
    invoke-interface {p2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 223
    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 224
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPredict;->inContext(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-static {p2}, Lcom/mrkeyboard/app/MrPredict;->inContext(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_5

    const/4 v1, 0x1

    :goto_1
    sput-boolean v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveFirst:Z

    .line 226
    :cond_4
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 224
    :cond_5
    const/4 v1, 0x0

    goto :goto_1
.end method


# virtual methods
.method alternative(Ljava/lang/String;IIII)Ljava/lang/String;
    .locals 20

    .prologue
    .line 244
    invoke-static/range {p1 .. p1}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 245
    const/4 v2, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v8

    .line 246
    const-wide/16 v2, 0x1

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    const/16 v5, 0x18

    invoke-static {v4, v5}, Ljava/lang/Math;->min(II)I

    move-result v4

    add-int/lit8 v4, v4, 0x1

    shl-long/2addr v2, v4

    long-to-double v10, v2

    .line 247
    const/4 v4, 0x0

    .line 248
    const/4 v3, 0x0

    .line 249
    const/4 v2, 0x0

    move v6, v2

    move v2, v3

    :goto_0
    move-object/from16 v0, p0

    iget v3, v0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v6, v3, :cond_3

    .line 250
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    aget v3, v3, v6

    .line 251
    if-lez v3, :cond_4

    move/from16 v0, p3

    if-le v3, v0, :cond_0

    move-object v3, v4

    .line 249
    :goto_1
    add-int/lit8 v4, v6, 0x1

    move v6, v4

    move-object v4, v3

    goto :goto_0

    .line 252
    :cond_0
    move-object/from16 v0, p0

    invoke-virtual {v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->resultWord(I)Ljava/lang/String;

    move-result-object v5

    .line 253
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

    .line 254
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

    .line 255
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

    .line 256
    move/from16 v0, p4

    if-lt v3, v0, :cond_4

    sub-int v9, v3, p2

    move/from16 v0, p5

    if-lt v9, v0, :cond_4

    if-le v3, v2, :cond_4

    move v2, v3

    move-object v3, v5

    .line 258
    goto :goto_1

    .line 261
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

    .line 545
    move v7, v2

    :goto_0
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v7, v0, :cond_0

    .line 546
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v4, v0, v7

    .line 547
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

    .line 545
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    .line 550
    :cond_0
    return-void
.end method

.method ownFrequency(Ljava/lang/CharSequence;)I
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 231
    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/16 v2, 0x14

    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 232
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move v0, v1

    .line 233
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

    .line 234
    :cond_0
    iput v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    .line 235
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v0

    return v0
.end method

.method resultCost(I)I
    .locals 1

    .prologue
    .line 464
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    aget v0, v0, p1

    return v0
.end method

.method resultCount()I
    .locals 1

    .prologue
    .line 461
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    return v0
.end method

.method resultScore(I)J
    .locals 2

    .prologue
    .line 463
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v0, v0, p1

    return-wide v0
.end method

.method resultWord(I)Ljava/lang/String;
    .locals 4

    .prologue
    .line 462
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
    .locals 9

    .prologue
    const/4 v2, 0x0

    .line 472
    invoke-interface {p2}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/16 v1, 0x14

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v6

    .line 473
    iput v6, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move v5, v2

    .line 474
    :goto_0
    if-ge v5, v6, :cond_4

    .line 475
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    invoke-interface {p2, v5}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    aput-char v1, v0, v5

    .line 477
    if-eqz p1, :cond_1

    invoke-virtual {p1, v5}, Lcom/mrkeyboard/app/WordComposer;->getCodesAt(I)[I

    move-result-object v0

    move-object v4, v0

    .line 478
    :goto_1
    if-eqz v4, :cond_5

    .line 479
    const/4 v0, 0x1

    move v1, v2

    :goto_2
    array-length v3, v4

    if-ge v0, v3, :cond_0

    const/16 v3, 0x10

    if-ge v1, v3, :cond_0

    .line 480
    aget v3, v4, v0

    .line 481
    if-gtz v3, :cond_2

    .line 486
    :cond_0
    :goto_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aput v1, v0, v5

    .line 474
    add-int/lit8 v0, v5, 0x1

    move v5, v0

    goto :goto_0

    .line 477
    :cond_1
    const/4 v0, 0x0

    move-object v4, v0

    goto :goto_1

    .line 482
    :cond_2
    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    .line 483
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v3, v3, v5

    if-eq v7, v3, :cond_3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v8, v3, v5

    add-int/lit8 v3, v1, 0x1

    aput-char v7, v8, v1

    move v1, v3

    .line 479
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 488
    :cond_4
    invoke-static {}, Lcom/mrkeyboard/app/MrRules;->get()Lcom/mrkeyboard/app/MrRules;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 489
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 490
    sput v2, Lcom/mrkeyboard/app/MrFuzzy;->sLastVisits:I

    .line 491
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->searchNative()Z

    .line 492
    return-void

    :cond_5
    move v1, v2

    goto :goto_3
.end method
