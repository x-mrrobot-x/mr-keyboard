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

.field static sCapTyped:Ljava/lang/String;

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

    .line 68
    new-array v0, v3, [C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    .line 69
    new-array v0, v3, [C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    .line 72
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v3, :cond_0

    .line 73
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    aput-char v2, v1, v0

    .line 74
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->LOWER:[C

    int-to-char v2, v0

    invoke-static {v2}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v2

    aput-char v2, v1, v0

    .line 72
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 135
    :cond_0
    const/16 v0, 0xc

    filled-new-array {v4, v0}, [I

    move-result-object v0

    sget-object v1, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v1, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    .line 136
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

    .line 146
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 91
    new-array v0, v6, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    .line 92
    const/16 v0, 0x10

    filled-new-array {v6, v0}, [I

    move-result-object v0

    sget-object v4, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v4, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    .line 93
    new-array v0, v6, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    .line 95
    sget-object v0, Lcom/mrkeyboard/app/MrRules;->EMPTY:Lcom/mrkeyboard/app/MrRules;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 98
    const/16 v0, 0x62

    filled-new-array {v5, v0}, [I

    move-result-object v0

    sget-object v4, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-static {v4, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

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

    .line 105
    const/16 v0, 0x140

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearFlat:[C

    .line 106
    const/16 v0, 0x1ea

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutWords:[C

    .line 107
    const/16 v0, 0xb

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    .line 108
    new-array v0, v5, [J

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutScores:[J

    .line 666
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    .line 667
    const/16 v0, 0x31

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    .line 147
    iput-object p1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    .line 148
    iput p2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    .line 150
    const/4 v0, 0x3

    .line 151
    if-le p2, v3, :cond_4

    .line 152
    invoke-virtual {p1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 153
    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 154
    const/16 v6, 0xc8

    if-lt v4, v6, :cond_3

    if-eqz v5, :cond_0

    if-eq v5, v1, :cond_0

    if-ne v5, v3, :cond_3

    .line 155
    :cond_0
    :goto_0
    if-eqz v1, :cond_1

    if-ne v5, v3, :cond_1

    const/4 v0, 0x4

    .line 157
    :cond_1
    :goto_1
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    .line 158
    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    .line 159
    if-eqz v1, :cond_2

    move v2, v3

    :cond_2
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    .line 160
    return-void

    :cond_3
    move v1, v2

    .line 154
    goto :goto_0

    :cond_4
    move v1, v2

    goto :goto_1
.end method

.method private addrAt(I)I
    .locals 3

    .prologue
    .line 637
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

    .line 638
    shl-int/lit8 v0, v0, 0x8

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, p1, 0x2

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    or-int/2addr v0, v1

    .line 639
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

    .line 190
    const/4 v1, 0x0

    :try_start_0
    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 191
    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 192
    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveFirst:Z

    .line 193
    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sCapTyped:Ljava/lang/String;

    .line 194
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 230
    :cond_0
    :goto_0
    return-void

    .line 195
    :cond_1
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->size()I

    move-result v1

    .line 196
    const/4 v2, 0x2

    if-lt v1, v2, :cond_0

    const/16 v2, 0x14

    if-gt v1, v2, :cond_0

    .line 198
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrRecent;->complete(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V

    .line 200
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPredict;->complete(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V

    .line 201
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->getTypedWord()Ljava/lang/CharSequence;

    move-result-object v2

    .line 202
    if-eqz v2, :cond_0

    .line 203
    invoke-static {p1, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->rememberTouches(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V

    .line 204
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->isFirstCharCapitalized()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    sput-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sCapTyped:Ljava/lang/String;

    .line 205
    :cond_2
    invoke-static {v2}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    .line 206
    if-eqz v3, :cond_3

    .line 207
    invoke-virtual {v3}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 208
    const/4 v2, 0x0

    array-length v3, v1

    const v4, 0x1fffffff

    const/4 v5, 0x1

    sget-object v6, Lcom/mrkeyboard/app/Dictionary$DataType;->UNIGRAM:Lcom/mrkeyboard/app/Dictionary$DataType;

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/Suggest;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z

    goto :goto_0

    .line 227
    :catch_0
    move-exception v0

    goto :goto_0

    .line 211
    :cond_3
    const/4 v3, 0x3

    if-lt v1, v3, :cond_0

    .line 212
    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/Suggest;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 213
    invoke-static {p0, p1, v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->validAlternative(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V

    goto :goto_0

    .line 216
    :cond_4
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v1

    .line 217
    if-eqz v1, :cond_0

    .line 218
    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrLength()I

    move-result v1

    invoke-static {v3, v1}, Lcom/mrkeyboard/app/MrFuzzy;->forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;

    move-result-object v1

    .line 219
    if-eqz v1, :cond_0

    .line 220
    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 221
    :try_start_1
    invoke-virtual {v1, p1, v2}, Lcom/mrkeyboard/app/MrFuzzy;->search(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;)V

    .line 222
    invoke-virtual {v1, p0}, Lcom/mrkeyboard/app/MrFuzzy;->emit(Lcom/mrkeyboard/app/Dictionary$WordCallback;)V

    .line 223
    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 224
    iget v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-lez v2, :cond_5

    iget-object v2, v1, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    const/4 v3, 0x0

    aget v2, v2, v3

    const/16 v3, 0x2d

    if-gt v2, v3, :cond_5

    .line 225
    const/4 v0, 0x0

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->resultWord(I)Ljava/lang/String;

    move-result-object v0

    :cond_5
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 226
    monitor-exit v1

    goto/16 :goto_0

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
    .line 542
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    new-array v1, v0, [C

    .line 543
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

    .line 544
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

    .line 431
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 432
    if-eqz v0, :cond_1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 453
    :cond_0
    :goto_0
    return v1

    .line 433
    :cond_1
    const/16 v0, 0x20

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_2

    move v1, v3

    goto :goto_0

    .line 435
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFuzzy;->digitCount(Ljava/lang/CharSequence;)I

    move-result v0

    if-lez v0, :cond_3

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrFuzzy;->digitSlip(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    goto :goto_0

    .line 436
    :cond_3
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-static {p1}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 437
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v2, 0x5

    if-gt v0, v2, :cond_5

    move v0, v1

    .line 438
    :goto_1
    invoke-static {v5, v6, v0}, Lcom/mrkeyboard/app/MrFuzzy;->distance(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v2

    if-le v2, v0, :cond_0

    .line 442
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v4

    if-ne v2, v4, :cond_a

    sget-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_a

    .line 443
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_a

    :cond_4
    move v2, v3

    move v4, v3

    .line 445
    :goto_2
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v7

    if-ge v2, v7, :cond_9

    .line 446
    invoke-virtual {v5, v2}, Ljava/lang/String;->charAt(I)C

    move-result v7

    invoke-virtual {v6, v2}, Ljava/lang/String;->charAt(I)C

    move-result v8

    if-ne v7, v8, :cond_6

    .line 445
    :goto_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 437
    :cond_5
    const/4 v0, 0x2

    goto :goto_1

    .line 447
    :cond_6
    invoke-virtual {v6, v2}, Ljava/lang/String;->charAt(I)C

    move-result v7

    invoke-static {v2, v7}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v7

    .line 448
    if-ltz v7, :cond_7

    if-le v7, v1, :cond_8

    :cond_7
    move v1, v3

    goto :goto_0

    .line 449
    :cond_8
    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    .line 451
    :cond_9
    mul-int/lit8 v0, v0, 0x2

    if-le v4, v0, :cond_0

    move v1, v3

    goto :goto_0

    :cond_a
    move v1, v3

    .line 453
    goto/16 :goto_0
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

    .line 394
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 399
    :cond_0
    :goto_0
    return-void

    .line 395
    :cond_1
    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrFuzzy;->isCaseVariant(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 396
    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 397
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 398
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

.method static digitCount(Ljava/lang/CharSequence;)I
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 458
    move v1, v0

    .line 459
    :goto_0
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-ge v0, v2, :cond_1

    invoke-interface {p0, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isDigit(C)Z

    move-result v2

    if-eqz v2, :cond_0

    add-int/lit8 v1, v1, 0x1

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 460
    :cond_1
    return v1
.end method

.method static digitSlip(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 8

    .prologue
    const/4 v3, 0x1

    const/4 v4, 0x0

    .line 485
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v5

    .line 486
    const/4 v0, 0x3

    if-lt v5, v0, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-ne v0, v5, :cond_0

    invoke-static {p1}, Lcom/mrkeyboard/app/MrFuzzy;->digitCount(Ljava/lang/CharSequence;)I

    move-result v0

    if-lez v0, :cond_1

    .line 505
    :cond_0
    :goto_0
    return v4

    .line 488
    :cond_1
    const/4 v0, -0x2

    move v1, v4

    move v2, v4

    .line 489
    :goto_1
    if-ge v1, v5, :cond_4

    .line 490
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v6

    .line 491
    invoke-static {v6}, Ljava/lang/Character;->isDigit(C)Z

    move-result v7

    if-eqz v7, :cond_3

    .line 492
    add-int/lit8 v0, v0, 0x1

    if-eq v1, v0, :cond_0

    .line 494
    add-int/lit8 v0, v2, 0x1

    .line 495
    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 496
    invoke-static {v2}, Ljava/lang/Character;->isLetter(C)Z

    move-result v7

    if-eqz v7, :cond_0

    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    invoke-static {v6, v2, v1, v5}, Lcom/mrkeyboard/app/MrFuzzy;->slipLetter(CCII)Z

    move-result v2

    if-eqz v2, :cond_0

    move v2, v0

    move v0, v1

    .line 489
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 497
    :cond_3
    invoke-static {v6}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v6

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v7

    invoke-static {v7}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    if-eq v6, v7, :cond_2

    goto :goto_0

    .line 501
    :cond_4
    if-eqz v2, :cond_0

    const/4 v0, 0x6

    if-lt v5, v0, :cond_6

    const/4 v0, 0x2

    :goto_2
    if-gt v2, v0, :cond_0

    .line 502
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    :cond_5
    move v4, v3

    goto :goto_0

    :cond_6
    move v0, v3

    .line 501
    goto :goto_2

    .line 504
    :cond_7
    invoke-virtual {p1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 505
    invoke-virtual {p0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Ljava/lang/Character;->isDigit(C)Z

    move-result v1

    if-eqz v1, :cond_8

    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sCapTyped:Ljava/lang/String;

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    move v0, v3

    :goto_3
    move v4, v0

    goto :goto_0

    :cond_8
    move v0, v4

    goto :goto_3
.end method

.method static digitsOf(Ljava/lang/CharSequence;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 465
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 466
    const/4 v0, 0x0

    :goto_0
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-ge v0, v2, :cond_1

    invoke-interface {p0, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isDigit(C)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {p0, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 467
    :cond_1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static distance(Ljava/lang/String;Ljava/lang/String;I)I
    .locals 12

    .prologue
    .line 549
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v7

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v8

    .line 550
    sub-int v0, v7, v8

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    if-le v0, p2, :cond_0

    add-int/lit8 v0, p2, 0x1

    .line 568
    :goto_0
    return v0

    .line 551
    :cond_0
    add-int/lit8 v0, v8, 0x1

    new-array v5, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v4, v0, [I

    add-int/lit8 v0, v8, 0x1

    new-array v1, v0, [I

    .line 552
    const/4 v0, 0x0

    :goto_1
    if-gt v0, v8, :cond_1

    aput v0, v4, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 553
    :cond_1
    const/4 v0, 0x1

    move v3, v0

    move-object v6, v4

    move-object v4, v1

    :goto_2
    if-gt v3, v7, :cond_6

    .line 554
    const/4 v0, 0x0

    aput v3, v4, v0

    .line 555
    const/4 v0, 0x0

    aget v1, v4, v0

    .line 556
    const/4 v0, 0x1

    move v2, v0

    :goto_3
    if-gt v2, v8, :cond_4

    .line 557
    add-int/lit8 v0, v3, -0x1

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    add-int/lit8 v9, v2, -0x1

    invoke-virtual {p1, v9}, Ljava/lang/String;->charAt(I)C

    move-result v9

    if-ne v0, v9, :cond_3

    const/4 v0, 0x0

    .line 558
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

    .line 559
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

    .line 560
    add-int/lit8 v9, v2, -0x2

    aget v9, v5, v9

    add-int/lit8 v9, v9, 0x1

    invoke-static {v0, v9}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 562
    :cond_2
    aput v0, v4, v2

    .line 563
    if-ge v0, v1, :cond_7

    .line 556
    :goto_5
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    move v1, v0

    goto :goto_3

    .line 557
    :cond_3
    const/4 v0, 0x1

    goto :goto_4

    .line 565
    :cond_4
    if-le v1, p2, :cond_5

    add-int/lit8 v0, p2, 0x1

    goto/16 :goto_0

    .line 553
    :cond_5
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    move-object v11, v5

    move-object v5, v6

    move-object v6, v4

    move-object v4, v11

    goto :goto_2

    .line 568
    :cond_6
    aget v0, v6, v8

    goto/16 :goto_0

    :cond_7
    move v0, v1

    goto :goto_5
.end method

.method static dropOtherNumbers(Ljava/util/List;Ljava/lang/String;)V
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
    .line 533
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x2

    if-lt v0, v1, :cond_0

    invoke-static {p1}, Lcom/mrkeyboard/app/MrFuzzy;->digitCount(Ljava/lang/CharSequence;)I

    move-result v0

    if-nez v0, :cond_1

    .line 539
    :cond_0
    return-void

    .line 534
    :cond_1
    invoke-static {p1}, Lcom/mrkeyboard/app/MrFuzzy;->digitsOf(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    .line 535
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v0

    :goto_0
    const/4 v0, 0x1

    if-lt v1, v0, :cond_0

    .line 536
    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    .line 537
    invoke-static {v0}, Lcom/mrkeyboard/app/MrFuzzy;->digitCount(Ljava/lang/CharSequence;)I

    move-result v3

    if-lez v3, :cond_2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrFuzzy;->digitsOf(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-interface {p0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 535
    :cond_2
    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_0
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

    .line 319
    sget-object v4, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 320
    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 321
    sget-boolean v6, Lcom/mrkeyboard/app/MrFuzzy;->sReserveFirst:Z

    .line 323
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 324
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 325
    sput-boolean v3, Lcom/mrkeyboard/app/MrFuzzy;->sReserveFirst:Z

    .line 327
    if-eqz p0, :cond_0

    :try_start_0
    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    move v0, p1

    .line 382
    :goto_0
    return v0

    .line 328
    :cond_1
    const/4 v0, 0x0

    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v7

    .line 329
    if-eqz v1, :cond_b

    invoke-virtual {v7, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_b

    .line 331
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

    .line 332
    invoke-virtual {v1}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    .line 336
    :cond_2
    :goto_1
    const/4 v5, -0x1

    move v4, v2

    .line 337
    :goto_2
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v4, v0, :cond_12

    .line 338
    invoke-interface {p0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_7

    move v0, v4

    .line 340
    :goto_3
    if-eqz v6, :cond_8

    .line 342
    if-eq v0, v2, :cond_4

    .line 343
    if-lez v0, :cond_3

    invoke-interface {p0, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 344
    :cond_3
    const/4 v0, 0x1

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v4

    invoke-static {v0, v4}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-interface {p0, v0, v1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    :cond_4
    move v4, v2

    .line 353
    :goto_4
    invoke-static {p0}, Lcom/mrkeyboard/app/MrLearned;->filter(Ljava/util/List;)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    if-eqz v0, :cond_11

    move v1, v3

    .line 356
    :goto_5
    :try_start_1
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v0

    if-ne v0, v2, :cond_e

    .line 357
    invoke-static {v7}, Lcom/mrkeyboard/app/MrFix;->lookup(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 358
    if-eqz v0, :cond_e

    invoke-virtual {v0, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 359
    const/4 v3, 0x0

    invoke-virtual {v7, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v3

    if-eqz v3, :cond_c

    .line 360
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

    .line 361
    :goto_6
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v3, v0

    :goto_7
    if-lt v3, v2, :cond_d

    .line 362
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

    .line 361
    :cond_5
    add-int/lit8 v0, v3, -0x1

    move v3, v0

    goto :goto_7

    .line 333
    :cond_6
    const/4 v0, 0x0

    :try_start_2
    invoke-virtual {v7, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 334
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

    .line 337
    :cond_7
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_2

    .line 347
    :cond_8
    if-ltz v0, :cond_9

    if-le v0, v8, :cond_b

    .line 348
    :cond_9
    if-le v0, v8, :cond_a

    invoke-interface {p0, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 349
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

    .line 360
    goto :goto_6

    .line 364
    :cond_d
    const/4 v0, 0x1

    :try_start_3
    invoke-interface {p0, v0, v4}, Ljava/util/List;->add(ILjava/lang/Object;)V

    move v0, v2

    .line 365
    goto/16 :goto_0

    .line 369
    :cond_e
    invoke-static {p0, v7}, Lcom/mrkeyboard/app/MrFuzzy;->dropOtherNumbers(Ljava/util/List;Ljava/lang/String;)V

    .line 372
    invoke-static {p0, v7}, Lcom/mrkeyboard/app/MrFuzzy;->demoteCaseVariant(Ljava/util/List;Ljava/lang/String;)V

    .line 375
    if-nez v4, :cond_f

    invoke-static {p0, v7}, Lcom/mrkeyboard/app/MrFuzzy;->touchOrder(Ljava/util/List;Ljava/lang/String;)V

    .line 376
    :cond_f
    if-eqz v1, :cond_10

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v0, v8, :cond_10

    .line 377
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

    .line 379
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
    .line 163
    const-class v1, Lcom/mrkeyboard/app/MrFuzzy;

    monitor-enter v1

    if-eqz p0, :cond_0

    const/4 v0, 0x2

    if-gt p1, v0, :cond_2

    :cond_0
    const/4 v0, 0x0

    .line 169
    :cond_1
    :goto_0
    monitor-exit v1

    return-object v0

    .line 164
    :cond_2
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;

    .line 165
    if-eqz v0, :cond_3

    iget-object v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    if-ne v2, p0, :cond_3

    iget v2, v0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-eq v2, p1, :cond_1

    .line 166
    :cond_3
    new-instance v0, Lcom/mrkeyboard/app/MrFuzzy;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrFuzzy;-><init>(Ljava/nio/ByteBuffer;I)V

    .line 167
    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 163
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static isCaseVariant(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 387
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    if-ne v1, v2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 390
    :cond_0
    :goto_0
    return v0

    .line 388
    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 389
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 390
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_0
.end method

.method static letterUnder(C)C
    .locals 2

    .prologue
    .line 527
    const-string v0, "1234567890"

    invoke-virtual {v0, p0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 528
    if-gez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const-string v1, "qwertyuiop"

    invoke-virtual {v1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    goto :goto_0
.end method

.method private lookup(II)I
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 673
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 674
    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 675
    sub-int v1, p2, p1

    const/16 v2, 0x30

    if-le v1, v2, :cond_0

    .line 677
    :goto_0
    return v0

    .line 676
    :cond_0
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mRoot:I

    invoke-direct {p0, v1, p1, p2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->lookupRec(IIII)V

    .line 677
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    goto :goto_0
.end method

.method private lookupRec(IIII)V
    .locals 10

    .prologue
    const/4 v3, 0x0

    .line 681
    if-ltz p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 724
    :cond_0
    return-void

    .line 682
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    const/16 v1, 0x2ee0

    if-gt v0, v1, :cond_0

    .line 683
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v8, v0, 0xff

    .line 684
    add-int/lit8 v4, p1, 0x1

    .line 685
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v9, v0, p2

    move v7, v3

    .line 686
    :goto_0
    if-ge v7, v8, :cond_0

    .line 687
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v4, v0, :cond_0

    .line 688
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, v4, 0x1

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 689
    const/16 v2, 0xff

    if-ne v0, v2, :cond_2

    .line 690
    add-int/lit8 v0, v1, 0x1

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v0, v2, :cond_0

    .line 691
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

    .line 692
    add-int/lit8 v1, v1, 0x2

    .line 694
    :cond_2
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v2, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v4, v2, 0xff

    .line 695
    and-int/lit16 v2, v4, 0x80

    if-eqz v2, :cond_4

    const/4 v2, 0x1

    move v6, v2

    .line 697
    :goto_1
    and-int/lit8 v2, v4, 0x40

    if-eqz v2, :cond_5

    .line 698
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v2, v1

    add-int/lit8 v2, v2, -0x1

    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v2, v4, :cond_0

    .line 699
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrFuzzy;->addrAt(I)I

    move-result v2

    .line 700
    iget v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v1, v4

    move v5, v2

    .line 705
    :goto_2
    if-eqz v6, :cond_a

    .line 706
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    .line 707
    iget-object v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v1, 0x1

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 708
    iget-boolean v4, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLatest:Z

    if-eqz v4, :cond_9

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/MrFuzzy;->skipBigrams(I)I

    move-result v2

    move v4, v2

    move v2, v1

    .line 710
    :goto_3
    const/16 v1, 0x100

    if-ge v0, v1, :cond_6

    sget-object v1, Lcom/mrkeyboard/app/MrFuzzy;->BASE:[C

    aget-char v1, v1, v0

    .line 711
    :goto_4
    if-eq v1, v9, :cond_7

    .line 686
    :cond_3
    :goto_5
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    :cond_4
    move v6, v3

    .line 695
    goto :goto_1

    .line 702
    :cond_5
    add-int/lit8 v1, v1, 0x1

    move v5, v3

    goto :goto_2

    .line 710
    :cond_6
    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    goto :goto_4

    .line 712
    :cond_7
    int-to-char v0, v0

    .line 713
    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aput-char v0, v1, p4

    .line 714
    add-int/lit8 v0, p2, 0x1

    if-ne v0, p3, :cond_8

    .line 715
    if-eqz v6, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    if-le v2, v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    aget-char v0, v0, v3

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-nez v0, :cond_3

    .line 716
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookFreq:I

    .line 717
    add-int/lit8 v0, p4, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookLen:I

    .line 718
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookPath:[C

    iget-object v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mLookBuf:[C

    add-int/lit8 v2, p4, 0x1

    invoke-static {v0, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_5

    .line 720
    :cond_8
    if-eqz v5, :cond_3

    .line 721
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

    .line 403
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 411
    :cond_0
    :goto_0
    return v2

    .line 405
    :cond_1
    const/4 v0, 0x0

    move v1, v2

    :goto_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v0, v3, :cond_3

    .line 406
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v3

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v4

    if-eq v3, v4, :cond_2

    .line 407
    if-gez v1, :cond_0

    move v1, v0

    .line 405
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    move v2, v1

    .line 411
    goto :goto_0
.end method

.method static declared-synchronized release()V
    .locals 2

    .prologue
    .line 179
    const-class v0, Lcom/mrkeyboard/app/MrFuzzy;

    monitor-enter v0

    const/4 v1, 0x0

    :try_start_0
    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sCache:Lcom/mrkeyboard/app/MrFuzzy;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 180
    monitor-exit v0

    return-void

    .line 179
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private static rememberTouches(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V
    .locals 9

    .prologue
    const/4 v2, 0x0

    .line 289
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    move v4, v2

    .line 290
    :goto_0
    if-ge v4, p2, :cond_3

    .line 291
    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/WordComposer;->getCodesAt(I)[I

    move-result-object v5

    .line 293
    if-eqz v5, :cond_4

    .line 294
    invoke-interface {p1, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v6

    .line 295
    const/4 v0, 0x1

    move v1, v2

    :goto_1
    array-length v3, v5

    if-ge v0, v3, :cond_0

    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    aget-object v3, v3, v4

    array-length v3, v3

    if-ge v1, v3, :cond_0

    .line 296
    aget v3, v5, v0

    if-gtz v3, :cond_1

    .line 301
    :cond_0
    :goto_2
    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchCount:[I

    aput v1, v0, v4

    .line 290
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_0

    .line 297
    :cond_1
    aget v3, v5, v0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    .line 298
    if-eq v7, v6, :cond_2

    sget-object v3, Lcom/mrkeyboard/app/MrFuzzy;->sTouchNear:[[C

    aget-object v8, v3, v4

    add-int/lit8 v3, v1, 0x1

    aput-char v7, v8, v1

    move v1, v3

    .line 295
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 303
    :cond_3
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    .line 304
    return-void

    :cond_4
    move v1, v2

    goto :goto_2
.end method

.method private searchNative()Z
    .locals 11

    .prologue
    const/4 v10, 0x0

    .line 608
    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move v0, v10

    .line 609
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

    .line 610
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

    .line 611
    if-ltz v1, :cond_1

    const/4 v0, 0x5

    if-le v1, v0, :cond_2

    :cond_1
    move v0, v10

    .line 625
    :goto_1
    return v0

    :cond_2
    move v0, v10

    .line 612
    :goto_2
    if-ge v0, v1, :cond_5

    .line 613
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    mul-int/lit8 v3, v0, 0x2

    add-int/lit8 v3, v3, 0x1

    aget v2, v2, v3

    .line 614
    if-ltz v2, :cond_3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v3, v3, v0

    array-length v3, v3

    if-le v2, v3, :cond_4

    :cond_3
    move v0, v10

    goto :goto_1

    .line 612
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 616
    :cond_5
    iput v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    move v0, v10

    .line 617
    :goto_3
    if-ge v0, v1, :cond_6

    .line 618
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    mul-int/lit8 v3, v0, 0x2

    add-int/lit8 v3, v3, 0x1

    aget v2, v2, v3

    .line 619
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutWords:[C

    mul-int/lit8 v4, v0, 0x62

    iget-object v5, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResWord:[[C

    aget-object v5, v5, v0

    invoke-static {v3, v4, v5, v10, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 620
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResLen:[I

    aput v2, v3, v0

    .line 621
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    mul-int/lit8 v4, v0, 0x2

    add-int/lit8 v4, v4, 0x2

    aget v3, v3, v4

    aput v3, v2, v0

    .line 622
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutScores:[J

    aget-wide v4, v3, v0

    aput-wide v4, v2, v0

    .line 617
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 624
    :cond_6
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mOutInfo:[I

    aget v0, v0, v10

    sput v0, Lcom/mrkeyboard/app/MrFuzzy;->sLastVisits:I

    .line 625
    const/4 v0, 0x1

    goto :goto_1
.end method

.method private skipBigrams(I)I
    .locals 3

    .prologue
    .line 643
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-lt p1, v0, :cond_1

    .line 653
    :cond_0
    :goto_0
    return p1

    .line 644
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    if-eqz v0, :cond_2

    .line 645
    const/4 v0, 0x0

    .line 646
    :goto_1
    iget v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v1, p1

    iget v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mSize:I

    if-ge v1, v2, :cond_0

    add-int/lit8 v1, v0, 0x1

    const/16 v2, 0x2710

    if-ge v0, v2, :cond_0

    .line 647
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mAb:I

    add-int/2addr v0, p1

    .line 648
    iget-object v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mDict:Ljava/nio/ByteBuffer;

    add-int/lit8 p1, v0, 0x1

    invoke-virtual {v2, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0x80

    .line 649
    if-eqz v0, :cond_0

    move v0, v1

    .line 650
    goto :goto_1

    .line 653
    :cond_2
    add-int/lit8 p1, p1, 0x1

    goto :goto_0
.end method

.method static slipLetter(CCII)Z
    .locals 5

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 514
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFuzzy;->letterUnder(C)C

    move-result v2

    .line 515
    if-nez v2, :cond_1

    .line 522
    :cond_0
    :goto_0
    return v1

    .line 516
    :cond_1
    const/4 v3, 0x3

    if-eq p3, v3, :cond_2

    if-nez p2, :cond_4

    :cond_2
    if-ne p1, v2, :cond_3

    :goto_1
    move v1, v0

    goto :goto_0

    :cond_3
    move v0, v1

    goto :goto_1

    .line 517
    :cond_4
    add-int/lit8 v3, p3, -0x1

    if-ne p2, v3, :cond_7

    .line 518
    const-string v3, "1234567890"

    invoke-virtual {v3, p0}, Ljava/lang/String;->indexOf(I)I

    move-result v3

    .line 519
    const-string v4, "qwertyuiop"

    .line 520
    if-eq p1, v2, :cond_6

    if-lez v3, :cond_5

    add-int/lit8 v2, v3, -0x1

    invoke-virtual {v4, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    if-eq p1, v2, :cond_6

    :cond_5
    const/16 v2, 0x9

    if-ge v3, v2, :cond_0

    add-int/lit8 v2, v3, 0x1

    invoke-virtual {v4, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    if-ne p1, v2, :cond_0

    :cond_6
    move v1, v0

    goto :goto_0

    :cond_7
    move v1, v0

    .line 522
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

    .line 422
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrFuzzy;->sTouchTyped:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 428
    :cond_0
    :goto_0
    return-void

    .line 423
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

    .line 424
    invoke-static {p1, v1}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 425
    if-ltz v2, :cond_0

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->oneSubAt(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    if-ne v3, v2, :cond_0

    .line 426
    invoke-virtual {v1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v2, v1}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v1

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrFuzzy;->touchRank(IC)I

    move-result v0

    .line 427
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

    .line 415
    const/16 v0, 0x14

    if-lt p0, v0, :cond_1

    move v0, v1

    .line 418
    :cond_0
    :goto_0
    return v0

    .line 416
    :cond_1
    invoke-static {p1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    .line 417
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

    .line 418
    goto :goto_0
.end method

.method private static validAlternative(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;I)V
    .locals 6

    .prologue
    .line 234
    const/4 v0, 0x3

    if-lt p3, v0, :cond_0

    const/16 v0, 0xc

    if-le p3, v0, :cond_1

    .line 250
    :cond_0
    :goto_0
    return-void

    .line 235
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v0

    .line 236
    if-eqz v0, :cond_0

    .line 237
    invoke-virtual {v0}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v0}, Lcom/mrkeyboard/app/BinaryDictionary;->mrLength()I

    move-result v0

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrFuzzy;->forDict(Ljava/nio/ByteBuffer;I)Lcom/mrkeyboard/app/MrFuzzy;

    move-result-object v0

    .line 238
    if-eqz v0, :cond_0

    .line 239
    monitor-enter v0

    .line 240
    :try_start_0
    invoke-virtual {v0, p2}, Lcom/mrkeyboard/app/MrFuzzy;->ownFrequency(Ljava/lang/CharSequence;)I

    move-result v2

    .line 241
    const/4 v1, 0x5

    if-le v2, v1, :cond_2

    const/16 v1, 0x50

    if-le v2, v1, :cond_3

    :cond_2
    monitor-exit v0

    goto :goto_0

    .line 249
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    .line 242
    :cond_3
    :try_start_1
    invoke-virtual {v0, p1, p2}, Lcom/mrkeyboard/app/MrFuzzy;->search(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;)V

    .line 243
    invoke-interface {p2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    const/16 v3, 0x28

    const/16 v4, 0x6e

    const/16 v5, 0x3c

    invoke-virtual/range {v0 .. v5}, Lcom/mrkeyboard/app/MrFuzzy;->alternative(Ljava/lang/String;IIII)Ljava/lang/String;

    move-result-object v1

    .line 244
    if-eqz v1, :cond_4

    .line 245
    invoke-interface {p2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrFuzzy;->sReserveTyped:Ljava/lang/String;

    .line 246
    sput-object v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveWord:Ljava/lang/String;

    .line 247
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPredict;->inContext(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-static {p2}, Lcom/mrkeyboard/app/MrPredict;->inContext(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_5

    const/4 v1, 0x1

    :goto_1
    sput-boolean v1, Lcom/mrkeyboard/app/MrFuzzy;->sReserveFirst:Z

    .line 249
    :cond_4
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 247
    :cond_5
    const/4 v1, 0x0

    goto :goto_1
.end method


# virtual methods
.method alternative(Ljava/lang/String;IIII)Ljava/lang/String;
    .locals 20

    .prologue
    .line 267
    invoke-static/range {p1 .. p1}, Lcom/mrkeyboard/app/MrFuzzy;->baseString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 268
    const/4 v2, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v8

    .line 269
    const-wide/16 v2, 0x1

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    const/16 v5, 0x18

    invoke-static {v4, v5}, Ljava/lang/Math;->min(II)I

    move-result v4

    add-int/lit8 v4, v4, 0x1

    shl-long/2addr v2, v4

    long-to-double v10, v2

    .line 270
    const/4 v4, 0x0

    .line 271
    const/4 v3, 0x0

    .line 272
    const/4 v2, 0x0

    move v6, v2

    move v2, v3

    :goto_0
    move-object/from16 v0, p0

    iget v3, v0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v6, v3, :cond_3

    .line 273
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    aget v3, v3, v6

    .line 274
    if-lez v3, :cond_4

    move/from16 v0, p3

    if-le v3, v0, :cond_0

    move-object v3, v4

    .line 272
    :goto_1
    add-int/lit8 v4, v6, 0x1

    move v6, v4

    move-object v4, v3

    goto :goto_0

    .line 275
    :cond_0
    move-object/from16 v0, p0

    invoke-virtual {v0, v6}, Lcom/mrkeyboard/app/MrFuzzy;->resultWord(I)Ljava/lang/String;

    move-result-object v5

    .line 276
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

    .line 277
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

    .line 278
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

    .line 279
    move/from16 v0, p4

    if-lt v3, v0, :cond_4

    sub-int v9, v3, p2

    move/from16 v0, p5

    if-lt v9, v0, :cond_4

    if-le v3, v2, :cond_4

    move v2, v3

    move-object v3, v5

    .line 281
    goto :goto_1

    .line 284
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

    .line 657
    move v7, v2

    :goto_0
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    if-ge v7, v0, :cond_0

    .line 658
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v4, v0, v7

    .line 659
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

    .line 657
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_0

    .line 662
    :cond_0
    return-void
.end method

.method ownFrequency(Ljava/lang/CharSequence;)I
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 254
    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/16 v2, 0x14

    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 255
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move v0, v1

    .line 256
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

    .line 257
    :cond_0
    iput v1, p0, Lcom/mrkeyboard/app/MrFuzzy;->mGuard:I

    .line 258
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/MrFuzzy;->lookup(II)I

    move-result v0

    return v0
.end method

.method resultCost(I)I
    .locals 1

    .prologue
    .line 576
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCost:[I

    aget v0, v0, p1

    return v0
.end method

.method resultCount()I
    .locals 1

    .prologue
    .line 573
    iget v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    return v0
.end method

.method resultScore(I)J
    .locals 2

    .prologue
    .line 575
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResScore:[J

    aget-wide v0, v0, p1

    return-wide v0
.end method

.method resultWord(I)Ljava/lang/String;
    .locals 4

    .prologue
    .line 574
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

    .line 584
    invoke-interface {p2}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/16 v1, 0x14

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v6

    .line 585
    iput v6, p0, Lcom/mrkeyboard/app/MrFuzzy;->mN:I

    move v5, v2

    .line 586
    :goto_0
    if-ge v5, v6, :cond_4

    .line 587
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    invoke-interface {p2, v5}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    aput-char v1, v0, v5

    .line 589
    if-eqz p1, :cond_1

    invoke-virtual {p1, v5}, Lcom/mrkeyboard/app/WordComposer;->getCodesAt(I)[I

    move-result-object v0

    move-object v4, v0

    .line 590
    :goto_1
    if-eqz v4, :cond_5

    .line 591
    const/4 v0, 0x1

    move v1, v2

    :goto_2
    array-length v3, v4

    if-ge v0, v3, :cond_0

    const/16 v3, 0x10

    if-ge v1, v3, :cond_0

    .line 592
    aget v3, v4, v0

    .line 593
    if-gtz v3, :cond_2

    .line 598
    :cond_0
    :goto_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNearCount:[I

    aput v1, v0, v5

    .line 586
    add-int/lit8 v0, v5, 0x1

    move v5, v0

    goto :goto_0

    .line 589
    :cond_1
    const/4 v0, 0x0

    move-object v4, v0

    goto :goto_1

    .line 594
    :cond_2
    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v7

    .line 595
    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mTb:[C

    aget-char v3, v3, v5

    if-eq v7, v3, :cond_3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrFuzzy;->mNear:[[C

    aget-object v8, v3, v5

    add-int/lit8 v3, v1, 0x1

    aput-char v7, v8, v1

    move v1, v3

    .line 591
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 600
    :cond_4
    invoke-static {}, Lcom/mrkeyboard/app/MrRules;->get()Lcom/mrkeyboard/app/MrRules;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrFuzzy;->mR:Lcom/mrkeyboard/app/MrRules;

    .line 601
    iput v2, p0, Lcom/mrkeyboard/app/MrFuzzy;->mResCount:I

    .line 602
    sput v2, Lcom/mrkeyboard/app/MrFuzzy;->sLastVisits:I

    .line 603
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFuzzy;->searchNative()Z

    .line 604
    return-void

    :cond_5
    move v1, v2

    goto :goto_3
.end method
