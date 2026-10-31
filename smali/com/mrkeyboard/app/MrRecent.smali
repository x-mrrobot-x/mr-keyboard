.class public final Lcom/mrkeyboard/app/MrRecent;
.super Ljava/lang/Object;
.source "MrRecent.java"


# static fields
.field static final CAP:I = 0x60

.field static final COMP1_ALL:I = 0x0

.field static final COMP1_MAX:I = 0x1

.field static final COMP1_V:I = 0x3c

.field static final COMP_MAX:I = 0x2

.field static final COMP_V:I = 0xc8

.field static final EMPTY:[Ljava/lang/String;

.field static final MAX_LEN:I = 0x1e

.field static final MIN_LEN:I = 0x3

.field static final OOV_LOWER:I = 0x0

.field static final PAIR_SCORE:I = 0x46

.field static final PRED_BOOST:I = 0x28

.field private static sCount:I

.field private static sField:I

.field private static final sKey:[Ljava/lang/String;

.field private static sLastKey:Ljava/lang/String;

.field private static final sOov:[Z

.field private static sPairCount:I

.field private static final sPairNext:[Ljava/lang/String;

.field private static final sPairPrev:[Ljava/lang/String;

.field private static sPkg:Ljava/lang/String;

.field private static final sShow:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/16 v1, 0x60

    .line 46
    new-array v0, v1, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrRecent;->sShow:[Ljava/lang/String;

    .line 47
    new-array v0, v1, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrRecent;->sKey:[Ljava/lang/String;

    .line 49
    new-array v0, v1, [Z

    sput-object v0, Lcom/mrkeyboard/app/MrRecent;->sOov:[Z

    .line 52
    new-array v0, v1, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrRecent;->sPairPrev:[Ljava/lang/String;

    .line 53
    new-array v0, v1, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrRecent;->sPairNext:[Ljava/lang/String;

    .line 57
    const/4 v0, -0x1

    sput v0, Lcom/mrkeyboard/app/MrRecent;->sField:I

    .line 181
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrRecent;->EMPTY:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static addPair(Ljava/lang/String;Ljava/lang/String;)V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 130
    invoke-static {p1}, Lcom/mrkeyboard/app/MrRecent;->key(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    .line 131
    const/4 v2, -0x1

    move v0, v1

    .line 132
    :goto_0
    sget v4, Lcom/mrkeyboard/app/MrRecent;->sPairCount:I

    if-ge v0, v4, :cond_4

    .line 133
    sget-object v4, Lcom/mrkeyboard/app/MrRecent;->sPairPrev:[Ljava/lang/String;

    aget-object v4, v4, v0

    invoke-virtual {v4, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    sget-object v4, Lcom/mrkeyboard/app/MrRecent;->sPairNext:[Ljava/lang/String;

    aget-object v4, v4, v0

    invoke-static {v4}, Lcom/mrkeyboard/app/MrRecent;->key(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 135
    :goto_1
    if-gez v0, :cond_0

    sget v0, Lcom/mrkeyboard/app/MrRecent;->sPairCount:I

    const/16 v2, 0x5f

    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v0

    :cond_0
    move v2, v0

    .line 136
    :goto_2
    if-lez v2, :cond_2

    .line 137
    sget-object v3, Lcom/mrkeyboard/app/MrRecent;->sPairPrev:[Ljava/lang/String;

    sget-object v4, Lcom/mrkeyboard/app/MrRecent;->sPairPrev:[Ljava/lang/String;

    add-int/lit8 v5, v2, -0x1

    aget-object v4, v4, v5

    aput-object v4, v3, v2

    .line 138
    sget-object v3, Lcom/mrkeyboard/app/MrRecent;->sPairNext:[Ljava/lang/String;

    sget-object v4, Lcom/mrkeyboard/app/MrRecent;->sPairNext:[Ljava/lang/String;

    add-int/lit8 v5, v2, -0x1

    aget-object v4, v4, v5

    aput-object v4, v3, v2

    .line 136
    add-int/lit8 v2, v2, -0x1

    goto :goto_2

    .line 132
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 140
    :cond_2
    sget-object v2, Lcom/mrkeyboard/app/MrRecent;->sPairPrev:[Ljava/lang/String;

    aput-object p0, v2, v1

    .line 141
    sget-object v2, Lcom/mrkeyboard/app/MrRecent;->sPairNext:[Ljava/lang/String;

    aput-object p1, v2, v1

    .line 142
    sget v1, Lcom/mrkeyboard/app/MrRecent;->sPairCount:I

    if-ne v0, v1, :cond_3

    sget v0, Lcom/mrkeyboard/app/MrRecent;->sPairCount:I

    const/16 v1, 0x60

    if-ge v0, v1, :cond_3

    sget v0, Lcom/mrkeyboard/app/MrRecent;->sPairCount:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrRecent;->sPairCount:I

    .line 143
    :cond_3
    return-void

    :cond_4
    move v0, v2

    goto :goto_1
.end method

.method static declared-synchronized bonus(Ljava/lang/String;)I
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 161
    const-class v2, Lcom/mrkeyboard/app/MrRecent;

    monitor-enter v2

    :try_start_0
    sget v1, Lcom/mrkeyboard/app/MrRecent;->sCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_1

    .line 166
    :cond_0
    :goto_0
    monitor-exit v2

    return v0

    .line 162
    :cond_1
    :try_start_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrRecent;->key(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    move v1, v0

    .line 163
    :goto_1
    sget v4, Lcom/mrkeyboard/app/MrRecent;->sCount:I

    if-ge v1, v4, :cond_0

    .line 164
    sget-object v4, Lcom/mrkeyboard/app/MrRecent;->sKey:[Ljava/lang/String;

    aget-object v4, v4, v1

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    const/16 v0, 0x28

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrRecent;->scaled(II)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v0

    goto :goto_0

    .line 163
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 161
    :catchall_0
    move-exception v0

    monitor-exit v2

    throw v0
.end method

.method public static declared-synchronized breakPair()V
    .locals 2

    .prologue
    .line 81
    const-class v0, Lcom/mrkeyboard/app/MrRecent;

    monitor-enter v0

    const/4 v1, 0x0

    :try_start_0
    sput-object v1, Lcom/mrkeyboard/app/MrRecent;->sLastKey:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 82
    monitor-exit v0

    return-void

    .line 81
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static declared-synchronized clear()V
    .locals 3

    .prologue
    .line 70
    const-class v1, Lcom/mrkeyboard/app/MrRecent;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrRecent;->sShow:[Ljava/lang/String;

    const/4 v2, 0x0

    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([Ljava/lang/Object;Ljava/lang/Object;)V

    .line 71
    sget-object v0, Lcom/mrkeyboard/app/MrRecent;->sKey:[Ljava/lang/String;

    const/4 v2, 0x0

    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([Ljava/lang/Object;Ljava/lang/Object;)V

    .line 72
    sget-object v0, Lcom/mrkeyboard/app/MrRecent;->sPairPrev:[Ljava/lang/String;

    const/4 v2, 0x0

    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([Ljava/lang/Object;Ljava/lang/Object;)V

    .line 73
    sget-object v0, Lcom/mrkeyboard/app/MrRecent;->sPairNext:[Ljava/lang/String;

    const/4 v2, 0x0

    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([Ljava/lang/Object;Ljava/lang/Object;)V

    .line 74
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrRecent;->sCount:I

    .line 75
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrRecent;->sPairCount:I

    .line 76
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrRecent;->sLastKey:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 77
    monitor-exit v1

    return-void

    .line 70
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static complete(Lcom/mrkeyboard/app/Suggest;Lcom/mrkeyboard/app/WordComposer;)V
    .locals 13

    .prologue
    const/4 v1, 0x0

    const/4 v9, 0x1

    .line 189
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 221
    :cond_0
    :goto_0
    return-void

    .line 191
    :cond_1
    :try_start_0
    invoke-virtual {p1}, Lcom/mrkeyboard/app/WordComposer;->getTypedWord()Ljava/lang/CharSequence;

    move-result-object v2

    .line 192
    if-nez v2, :cond_3

    move v10, v1

    .line 193
    :goto_1
    if-lt v10, v9, :cond_0

    const/16 v0, 0xc

    if-gt v10, v0, :cond_0

    .line 194
    if-ne v10, v9, :cond_4

    move v3, v9

    .line 195
    :goto_2
    if-lez v3, :cond_0

    .line 196
    invoke-static {v2}, Lcom/mrkeyboard/app/MrRecent;->key(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v4

    .line 197
    new-array v11, v3, [Ljava/lang/String;

    .line 198
    new-array v12, v3, [I

    .line 200
    const-class v5, Lcom/mrkeyboard/app/MrRecent;

    monitor-enter v5
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move v2, v1

    move v7, v1

    .line 201
    :goto_3
    :try_start_1
    sget v0, Lcom/mrkeyboard/app/MrRecent;->sCount:I

    if-ge v2, v0, :cond_5

    if-ge v7, v3, :cond_5

    .line 202
    sget-object v0, Lcom/mrkeyboard/app/MrRecent;->sKey:[Ljava/lang/String;

    aget-object v0, v0, v2

    .line 203
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v6

    if-le v6, v10, :cond_7

    invoke-virtual {v0, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_7

    if-gt v10, v9, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrRecent;->sOov:[Z

    aget-boolean v0, v0, v2

    if-eqz v0, :cond_7

    .line 204
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrRecent;->sShow:[Ljava/lang/String;

    aget-object v0, v0, v2

    aput-object v0, v11, v7

    .line 205
    aput v2, v12, v7
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 206
    add-int/lit8 v0, v7, 0x1

    .line 201
    :goto_4
    add-int/lit8 v2, v2, 0x1

    move v7, v0

    goto :goto_3

    .line 192
    :cond_3
    :try_start_2
    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0

    move-result v0

    move v10, v0

    goto :goto_1

    .line 194
    :cond_4
    const/4 v0, 0x2

    move v3, v0

    goto :goto_2

    .line 209
    :cond_5
    :try_start_3
    monitor-exit v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move v8, v1

    .line 210
    :goto_5
    if-ge v8, v7, :cond_0

    .line 211
    :try_start_4
    aget-object v0, v11, v8

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 212
    if-ne v10, v9, :cond_6

    .line 213
    const/4 v2, 0x0

    array-length v3, v1

    const/16 v0, 0x7f

    const/16 v4, 0x3c

    aget v5, v12, v8

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrRecent;->scaled(II)I

    move-result v4

    invoke-static {v0, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    const/4 v5, 0x1

    sget-object v6, Lcom/mrkeyboard/app/Dictionary$DataType;->BIGRAM:Lcom/mrkeyboard/app/Dictionary$DataType;

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/Suggest;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_0

    .line 210
    :goto_6
    add-int/lit8 v0, v8, 0x1

    move v8, v0

    goto :goto_5

    .line 209
    :catchall_0
    move-exception v0

    :try_start_5
    monitor-exit v5
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    :try_start_6
    throw v0

    .line 218
    :catch_0
    move-exception v0

    goto :goto_0

    .line 215
    :cond_6
    const/4 v2, 0x0

    array-length v3, v1

    const/16 v0, 0xc8

    aget v4, v12, v8

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrRecent;->scaled(II)I

    move-result v0

    const/16 v4, 0x10

    invoke-static {v10, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    shl-int v4, v0, v4

    const/4 v5, 0x1

    sget-object v6, Lcom/mrkeyboard/app/Dictionary$DataType;->UNIGRAM:Lcom/mrkeyboard/app/Dictionary$DataType;

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/Suggest;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z
    :try_end_6
    .catch Ljava/lang/RuntimeException; {:try_start_6 .. :try_end_6} :catch_0

    goto :goto_6

    :cond_7
    move v0, v7

    goto :goto_4
.end method

.method static key(Ljava/lang/CharSequence;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 147
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    new-array v1, v0, [C

    .line 148
    const/4 v0, 0x0

    :goto_0
    array-length v2, v1

    if-ge v0, v2, :cond_0

    invoke-interface {p0, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    aput-char v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 149
    :cond_0
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/String;-><init>([C)V

    return-object v0
.end method

.method static declared-synchronized nextAfter(Ljava/lang/String;I)[Ljava/lang/String;
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 171
    const-class v3, Lcom/mrkeyboard/app/MrRecent;

    monitor-enter v3

    :try_start_0
    sget v1, Lcom/mrkeyboard/app/MrRecent;->sPairCount:I

    if-eqz v1, :cond_0

    if-nez p0, :cond_1

    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrRecent;->EMPTY:[Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 178
    :goto_0
    monitor-exit v3

    return-object v0

    .line 172
    :cond_1
    :try_start_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrRecent;->key(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v4

    .line 173
    new-array v5, p1, [Ljava/lang/String;

    move v2, v0

    move v1, v0

    .line 175
    :goto_1
    sget v0, Lcom/mrkeyboard/app/MrRecent;->sPairCount:I

    if-ge v2, v0, :cond_2

    if-ge v1, p1, :cond_2

    .line 176
    sget-object v0, Lcom/mrkeyboard/app/MrRecent;->sPairPrev:[Ljava/lang/String;

    aget-object v0, v0, v2

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    add-int/lit8 v0, v1, 0x1

    sget-object v6, Lcom/mrkeyboard/app/MrRecent;->sPairNext:[Ljava/lang/String;

    aget-object v6, v6, v2

    aput-object v6, v5, v1

    .line 175
    :goto_2
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    move v1, v0

    goto :goto_1

    .line 178
    :cond_2
    if-nez v1, :cond_3

    sget-object v0, Lcom/mrkeyboard/app/MrRecent;->EMPTY:[Ljava/lang/String;

    goto :goto_0

    :cond_3
    invoke-static {v5, v1}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 171
    :catchall_0
    move-exception v0

    monitor-exit v3

    throw v0

    :cond_4
    move v0, v1

    goto :goto_2
.end method

.method public static declared-synchronized onField(Ljava/lang/String;I)V
    .locals 2

    .prologue
    .line 63
    const-class v1, Lcom/mrkeyboard/app/MrRecent;

    monitor-enter v1

    if-eqz p0, :cond_1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrRecent;->sPkg:Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget v0, Lcom/mrkeyboard/app/MrRecent;->sField:I

    if-ne p1, v0, :cond_1

    const/4 v0, 0x1

    .line 64
    :goto_0
    sput-object p0, Lcom/mrkeyboard/app/MrRecent;->sPkg:Ljava/lang/String;

    .line 65
    sput p1, Lcom/mrkeyboard/app/MrRecent;->sField:I

    .line 66
    if-nez v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrRecent;->clear()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 67
    :cond_0
    monitor-exit v1

    return-void

    .line 63
    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static declared-synchronized record(Lcom/mrkeyboard/app/Suggest;Ljava/lang/CharSequence;)V
    .locals 9

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 91
    const-class v6, Lcom/mrkeyboard/app/MrRecent;

    monitor-enter v6

    if-nez p1, :cond_1

    .line 127
    :cond_0
    :goto_0
    monitor-exit v6

    return-void

    .line 92
    :cond_1
    :try_start_0
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v5

    .line 93
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v4

    .line 94
    const/4 v0, 0x3

    if-lt v4, v0, :cond_0

    const/16 v0, 0x1e

    if-gt v4, v0, :cond_0

    move v3, v2

    move v0, v2

    .line 96
    :goto_1
    if-ge v3, v4, :cond_3

    .line 97
    invoke-virtual {v5, v3}, Ljava/lang/String;->charAt(I)C

    move-result v7

    .line 98
    invoke-static {v7}, Ljava/lang/Character;->isDigit(C)Z

    move-result v8

    if-nez v8, :cond_0

    const/16 v8, 0x20

    if-eq v7, v8, :cond_0

    .line 99
    invoke-static {v7}, Ljava/lang/Character;->isLetter(C)Z

    move-result v7

    if-eqz v7, :cond_2

    move v0, v1

    .line 96
    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 101
    :cond_3
    if-eqz v0, :cond_0

    .line 104
    if-eqz p0, :cond_b

    .line 105
    invoke-virtual {v5}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    .line 106
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/Suggest;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_7

    move v3, v2

    move-object v4, v0

    .line 109
    :goto_2
    if-eqz v3, :cond_4

    invoke-virtual {v5}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 110
    :cond_4
    invoke-static {v4}, Lcom/mrkeyboard/app/MrRecent;->key(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v5

    .line 111
    sget-object v0, Lcom/mrkeyboard/app/MrRecent;->sLastKey:Ljava/lang/String;

    if-eqz v0, :cond_5

    sget-object v0, Lcom/mrkeyboard/app/MrRecent;->sLastKey:Ljava/lang/String;

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrRecent;->addPair(Ljava/lang/String;Ljava/lang/String;)V

    .line 112
    :cond_5
    sput-object v5, Lcom/mrkeyboard/app/MrRecent;->sLastKey:Ljava/lang/String;

    .line 113
    const/4 v1, -0x1

    move v0, v2

    .line 114
    :goto_3
    sget v2, Lcom/mrkeyboard/app/MrRecent;->sCount:I

    if-ge v0, v2, :cond_a

    .line 115
    sget-object v2, Lcom/mrkeyboard/app/MrRecent;->sKey:[Ljava/lang/String;

    aget-object v2, v2, v0

    invoke-virtual {v2, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_8

    .line 117
    :goto_4
    if-gez v0, :cond_6

    sget v0, Lcom/mrkeyboard/app/MrRecent;->sCount:I

    const/16 v1, 0x5f

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    :cond_6
    move v1, v0

    .line 118
    :goto_5
    if-lez v1, :cond_9

    .line 119
    sget-object v2, Lcom/mrkeyboard/app/MrRecent;->sShow:[Ljava/lang/String;

    sget-object v7, Lcom/mrkeyboard/app/MrRecent;->sShow:[Ljava/lang/String;

    add-int/lit8 v8, v1, -0x1

    aget-object v7, v7, v8

    aput-object v7, v2, v1

    .line 120
    sget-object v2, Lcom/mrkeyboard/app/MrRecent;->sKey:[Ljava/lang/String;

    sget-object v7, Lcom/mrkeyboard/app/MrRecent;->sKey:[Ljava/lang/String;

    add-int/lit8 v8, v1, -0x1

    aget-object v7, v7, v8

    aput-object v7, v2, v1

    .line 121
    sget-object v2, Lcom/mrkeyboard/app/MrRecent;->sOov:[Z

    sget-object v7, Lcom/mrkeyboard/app/MrRecent;->sOov:[Z

    add-int/lit8 v8, v1, -0x1

    aget-boolean v7, v7, v8

    aput-boolean v7, v2, v1

    .line 118
    add-int/lit8 v1, v1, -0x1

    goto :goto_5

    .line 107
    :cond_7
    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/Suggest;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_b

    move v3, v2

    move-object v4, v5

    goto :goto_2

    .line 114
    :cond_8
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 123
    :cond_9
    sget-object v1, Lcom/mrkeyboard/app/MrRecent;->sShow:[Ljava/lang/String;

    const/4 v2, 0x0

    aput-object v4, v1, v2

    .line 124
    sget-object v1, Lcom/mrkeyboard/app/MrRecent;->sKey:[Ljava/lang/String;

    const/4 v2, 0x0

    aput-object v5, v1, v2

    .line 125
    sget-object v1, Lcom/mrkeyboard/app/MrRecent;->sOov:[Z

    const/4 v2, 0x0

    aput-boolean v3, v1, v2

    .line 126
    sget v1, Lcom/mrkeyboard/app/MrRecent;->sCount:I

    if-ne v0, v1, :cond_0

    sget v0, Lcom/mrkeyboard/app/MrRecent;->sCount:I

    const/16 v1, 0x60

    if-ge v0, v1, :cond_0

    sget v0, Lcom/mrkeyboard/app/MrRecent;->sCount:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrRecent;->sCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto/16 :goto_0

    .line 91
    :catchall_0
    move-exception v0

    monitor-exit v6

    throw v0

    :cond_a
    move v0, v1

    goto :goto_4

    :cond_b
    move v3, v1

    move-object v4, v5

    goto/16 :goto_2
.end method

.method private static scaled(II)I
    .locals 1

    .prologue
    .line 156
    mul-int/lit8 v0, p0, 0x3

    div-int/lit8 v0, v0, 0x4

    mul-int/2addr v0, p1

    div-int/lit8 v0, v0, 0x5f

    sub-int v0, p0, v0

    return v0
.end method
