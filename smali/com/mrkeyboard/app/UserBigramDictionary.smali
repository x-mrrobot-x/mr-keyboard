.class public Lcom/mrkeyboard/app/UserBigramDictionary;
.super Lcom/mrkeyboard/app/ExpandableDictionary;
.source "UserBigramDictionary.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrLearned$Sink;

# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/UserBigramDictionary$UpdateDbTask;,
        Lcom/mrkeyboard/app/UserBigramDictionary$DatabaseHelper;,
        Lcom/mrkeyboard/app/UserBigramDictionary$Bigram;
    }
.end annotation

# static fields
.field private static final DATABASE_NAME:Ljava/lang/String; = "userbigram_dict.db"

.field private static final DATABASE_VERSION:I = 0x1

.field private static final FREQUENCY_FOR_TYPED:I = 0x2

.field private static final FREQUENCY_MAX:I = 0x7f

.field private static final FREQ_COLUMN_FREQUENCY:Ljava/lang/String; = "freq"

.field private static final FREQ_COLUMN_ID:Ljava/lang/String; = "_id"

.field private static final FREQ_COLUMN_PAIR_ID:Ljava/lang/String; = "pair_id"

.field private static final FREQ_TABLE_NAME:Ljava/lang/String; = "frequency"

.field private static final MAIN_COLUMN_ID:Ljava/lang/String; = "_id"

.field private static final MAIN_COLUMN_LOCALE:Ljava/lang/String; = "locale"

.field private static final MAIN_COLUMN_WORD1:Ljava/lang/String; = "word1"

.field private static final MAIN_COLUMN_WORD2:Ljava/lang/String; = "word2"

.field private static final MAIN_TABLE_NAME:Ljava/lang/String; = "main"

.field protected static final SUGGEST_THRESHOLD:I = 0xc

.field private static final TAG:Ljava/lang/String; = "UserBigramDictionary"

.field private static sDeleteUserBigrams:I = 0x3e8

.field private static final sDictProjectionMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static sMaxUserBigrams:I = 0x2710

.field private static sOpenHelper:Lcom/mrkeyboard/app/UserBigramDictionary$DatabaseHelper;

.field private static volatile sUpdatingDB:Z

# instance fields
.field private final mIme:Lcom/mrkeyboard/app/LatinIME;

.field private mLocale:Ljava/lang/String;

.field private mPendingWrites:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet<",
            "Lcom/mrkeyboard/app/UserBigramDictionary$Bigram;",
            ">;"
        }
    .end annotation
.end field

.field private final mPendingWritesLock:Ljava/lang/Object;

# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 97
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/UserBigramDictionary;->sDictProjectionMap:Ljava/util/HashMap;

    .line 98
    sget-object v0, Lcom/mrkeyboard/app/UserBigramDictionary;->sDictProjectionMap:Ljava/util/HashMap;

    const-string v1, "_id"

    const-string v2, "_id"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 99
    sget-object v0, Lcom/mrkeyboard/app/UserBigramDictionary;->sDictProjectionMap:Ljava/util/HashMap;

    const-string v1, "word1"

    const-string v2, "word1"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 100
    sget-object v0, Lcom/mrkeyboard/app/UserBigramDictionary;->sDictProjectionMap:Ljava/util/HashMap;

    const-string v1, "word2"

    const-string v2, "word2"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 101
    sget-object v0, Lcom/mrkeyboard/app/UserBigramDictionary;->sDictProjectionMap:Ljava/util/HashMap;

    const-string v1, "locale"

    const-string v2, "locale"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 103
    sget-object v0, Lcom/mrkeyboard/app/UserBigramDictionary;->sDictProjectionMap:Ljava/util/HashMap;

    const-string v1, "_id"

    const-string v2, "_id"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 104
    sget-object v0, Lcom/mrkeyboard/app/UserBigramDictionary;->sDictProjectionMap:Ljava/util/HashMap;

    const-string v1, "pair_id"

    const-string v2, "pair_id"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 105
    sget-object v0, Lcom/mrkeyboard/app/UserBigramDictionary;->sDictProjectionMap:Ljava/util/HashMap;

    const-string v1, "freq"

    const-string v2, "freq"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v0, 0x0

    .line 108
    sput-object v0, Lcom/mrkeyboard/app/UserBigramDictionary;->sOpenHelper:Lcom/mrkeyboard/app/UserBigramDictionary$DatabaseHelper;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/mrkeyboard/app/LatinIME;Ljava/lang/String;I)V
    .locals 0

    .line 142
    invoke-direct {p0, p1, p4}, Lcom/mrkeyboard/app/ExpandableDictionary;-><init>(Landroid/content/Context;I)V

    .line 90
    new-instance p1, Ljava/util/HashSet;

    invoke-direct {p1}, Ljava/util/HashSet;-><init>()V

    iput-object p1, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mPendingWrites:Ljava/util/HashSet;

    .line 91
    new-instance p1, Ljava/lang/Object;

    invoke-direct {p1}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mPendingWritesLock:Ljava/lang/Object;

    .line 143
    iput-object p2, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mIme:Lcom/mrkeyboard/app/LatinIME;

    .line 144
    iput-object p3, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mLocale:Ljava/lang/String;

    .line 145
    sget-object p1, Lcom/mrkeyboard/app/UserBigramDictionary;->sOpenHelper:Lcom/mrkeyboard/app/UserBigramDictionary$DatabaseHelper;

    if-nez p1, :cond_0

    .line 146
    new-instance p1, Lcom/mrkeyboard/app/UserBigramDictionary$DatabaseHelper;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/UserBigramDictionary;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-direct {p1, p2}, Lcom/mrkeyboard/app/UserBigramDictionary$DatabaseHelper;-><init>(Landroid/content/Context;)V

    sput-object p1, Lcom/mrkeyboard/app/UserBigramDictionary;->sOpenHelper:Lcom/mrkeyboard/app/UserBigramDictionary$DatabaseHelper;

    .line 148
    :cond_0
    iget-object p1, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mLocale:Ljava/lang/String;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mLocale:Ljava/lang/String;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    const/4 p2, 0x1

    if-le p1, p2, :cond_1

    .line 149
    invoke-virtual {p0}, Lcom/mrkeyboard/app/UserBigramDictionary;->loadDictionary()V

    :cond_1
    return-void
.end method

.method static synthetic access$000()I
    .locals 1

    .line 38
    sget v0, Lcom/mrkeyboard/app/UserBigramDictionary;->sMaxUserBigrams:I

    return v0
.end method

.method static synthetic access$100()I
    .locals 1

    .line 38
    sget v0, Lcom/mrkeyboard/app/UserBigramDictionary;->sDeleteUserBigrams:I

    return v0
.end method

.method static synthetic access$202(Z)Z
    .locals 0

    .line 38
    sput-boolean p0, Lcom/mrkeyboard/app/UserBigramDictionary;->sUpdatingDB:Z

    return p0
.end method

.method private query(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;
    .locals 8

    .line 244
    new-instance v0, Landroid/database/sqlite/SQLiteQueryBuilder;

    invoke-direct {v0}, Landroid/database/sqlite/SQLiteQueryBuilder;-><init>()V

    const-string v1, "main INNER JOIN frequency ON (main._id=frequency.pair_id)"

    .line 247
    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteQueryBuilder;->setTables(Ljava/lang/String;)V

    .line 251
    sget-object v1, Lcom/mrkeyboard/app/UserBigramDictionary;->sDictProjectionMap:Ljava/util/HashMap;

    invoke-virtual {v0, v1}, Landroid/database/sqlite/SQLiteQueryBuilder;->setProjectionMap(Ljava/util/Map;)V

    .line 254
    sget-object v1, Lcom/mrkeyboard/app/UserBigramDictionary;->sOpenHelper:Lcom/mrkeyboard/app/UserBigramDictionary$DatabaseHelper;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/UserBigramDictionary$DatabaseHelper;->getReadableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v1

    const/4 v2, 0x3

    .line 255
    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "word1"

    const/4 v4, 0x0

    aput-object v3, v2, v4

    const-string v3, "word2"

    const/4 v4, 0x1

    aput-object v3, v2, v4

    const-string v3, "freq"

    const/4 v4, 0x2

    aput-object v3, v2, v4

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v3, p1

    move-object v4, p2

    invoke-virtual/range {v0 .. v7}, Landroid/database/sqlite/SQLiteQueryBuilder;->query(Landroid/database/sqlite/SQLiteDatabase;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object p1

    return-object p1
.end method

# virtual methods
.method public addBigrams(Ljava/lang/String;Ljava/lang/String;)I
    .locals 4

    # Mr Keyboard v1.85: a pair that has a word the user blocked is never learned
    invoke-static {p1}, Lcom/mrkeyboard/app/MrLearned;->isBlocked(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_mr_blocked

    invoke-static {p2}, Lcom/mrkeyboard/app/MrLearned;->isBlocked(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_mr_not_blocked

    :cond_mr_blocked
    const/4 v0, 0x0

    return v0

    :cond_mr_not_blocked
    .line 168
    iget-object v0, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mIme:Lcom/mrkeyboard/app/LatinIME;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mIme:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentWord()Lcom/mrkeyboard/app/WordComposer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/WordComposer;->isAutoCapitalized()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 169
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v1, 0x0

    invoke-virtual {p2, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    const/4 v1, 0x1

    invoke-virtual {p2, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    :cond_0
    const/4 v0, 0x2

    .line 172
    invoke-super {p0, p1, p2, v0}, Lcom/mrkeyboard/app/ExpandableDictionary;->addBigram(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v1

    const/16 v2, 0x7f

    if-le v1, v2, :cond_1

    const/16 v1, 0x7f

    .line 174
    :cond_1
    iget-object v2, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mPendingWritesLock:Ljava/lang/Object;

    monitor-enter v2

    if-eq v1, v0, :cond_3

    .line 175
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mPendingWrites:Ljava/util/HashSet;

    invoke-virtual {v0}, Ljava/util/HashSet;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_2

    goto :goto_0

    .line 178
    :cond_2
    new-instance v0, Lcom/mrkeyboard/app/UserBigramDictionary$Bigram;

    invoke-direct {v0, p1, p2, v1}, Lcom/mrkeyboard/app/UserBigramDictionary$Bigram;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    .line 179
    iget-object p1, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mPendingWrites:Ljava/util/HashSet;

    invoke-virtual {p1, v0}, Ljava/util/HashSet;->remove(Ljava/lang/Object;)Z

    .line 180
    iget-object p1, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mPendingWrites:Ljava/util/HashSet;

    invoke-virtual {p1, v0}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :catchall_0
    move-exception p1

    goto :goto_2

    .line 176
    :cond_3
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mPendingWrites:Ljava/util/HashSet;

    new-instance v3, Lcom/mrkeyboard/app/UserBigramDictionary$Bigram;

    invoke-direct {v3, p1, p2, v1}, Lcom/mrkeyboard/app/UserBigramDictionary$Bigram;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    invoke-virtual {v0, v3}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 182
    :goto_1
    monitor-exit v2

    return v1

    :goto_2
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public close()V
    .locals 0

    .line 155
    invoke-virtual {p0}, Lcom/mrkeyboard/app/UserBigramDictionary;->flushPendingWrites()V

    .line 160
    invoke-super {p0}, Lcom/mrkeyboard/app/ExpandableDictionary;->close()V

    return-void
.end method

.method public flushPendingWrites()V
    .locals 6

    .line 191
    iget-object v0, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mPendingWritesLock:Ljava/lang/Object;

    monitor-enter v0

    .line 193
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mPendingWrites:Ljava/util/HashSet;

    invoke-virtual {v1}, Ljava/util/HashSet;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    monitor-exit v0

    return-void

    .line 195
    :cond_0
    new-instance v1, Lcom/mrkeyboard/app/UserBigramDictionary$UpdateDbTask;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/UserBigramDictionary;->getContext()Landroid/content/Context;

    move-result-object v2

    sget-object v3, Lcom/mrkeyboard/app/UserBigramDictionary;->sOpenHelper:Lcom/mrkeyboard/app/UserBigramDictionary$DatabaseHelper;

    iget-object v4, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mPendingWrites:Ljava/util/HashSet;

    iget-object v5, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mLocale:Ljava/lang/String;

    invoke-direct {v1, v2, v3, v4, v5}, Lcom/mrkeyboard/app/UserBigramDictionary$UpdateDbTask;-><init>(Landroid/content/Context;Lcom/mrkeyboard/app/UserBigramDictionary$DatabaseHelper;Ljava/util/HashSet;Ljava/lang/String;)V

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Void;

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/BgTask;->execute([Ljava/lang/Object;)V

    .line 197
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    iput-object v1, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mPendingWrites:Ljava/util/HashSet;

    .line 198
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public loadDictionaryAsync()V
    .locals 9

    const-string v0, "locale=?"

    const/4 v1, 0x1

    .line 217
    new-array v1, v1, [Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mLocale:Ljava/lang/String;

    const/4 v3, 0x0

    aput-object v2, v1, v3

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/UserBigramDictionary;->query(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v0

    .line 219
    :try_start_0
    invoke-interface {v0}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "word1"

    .line 220
    invoke-interface {v0, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    const-string v2, "word2"

    .line 221
    invoke-interface {v0, v2}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v2

    const-string v3, "freq"

    .line 222
    invoke-interface {v0, v3}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v3

    .line 223
    :goto_0
    invoke-interface {v0}, Landroid/database/Cursor;->isAfterLast()Z

    move-result v4

    if-nez v4, :cond_1

    .line 224
    invoke-interface {v0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v4

    .line 225
    invoke-interface {v0, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v5

    .line 226
    invoke-interface {v0, v3}, Landroid/database/Cursor;->getInt(I)I

    move-result v6

    .line 229
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v7

    const/16 v8, 0x20

    if-ge v7, v8, :cond_0

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v7

    if-ge v7, v8, :cond_0

    .line 230
    invoke-super {p0, v4, v5, v6}, Lcom/mrkeyboard/app/ExpandableDictionary;->setBigram(Ljava/lang/String;Ljava/lang/String;I)I

    .line 232
    :cond_0
    invoke-interface {v0}, Landroid/database/Cursor;->moveToNext()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 236
    :cond_1
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    # Mr Keyboard v1.85: the pairs the user added on purpose (screen "Add words and texts") join the learned ones
    invoke-virtual {p0}, Lcom/mrkeyboard/app/UserBigramDictionary;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/UserBigramDictionary;->mLocale:Ljava/lang/String;

    invoke-static {v0, p0, v1}, Lcom/mrkeyboard/app/MrLearned;->load(Landroid/content/Context;Lcom/mrkeyboard/app/MrLearned$Sink;Ljava/lang/String;)V

    return-void

    :catchall_0
    move-exception v1

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    throw v1
.end method

.method public setDatabaseDelete(I)V
    .locals 0

    .line 138
    sput p1, Lcom/mrkeyboard/app/UserBigramDictionary;->sDeleteUserBigrams:I

    return-void
.end method

.method public setDatabaseMax(I)V
    .locals 0

    .line 134
    sput p1, Lcom/mrkeyboard/app/UserBigramDictionary;->sMaxUserBigrams:I

    return-void
.end method

# Mr Keyboard v1.85: MrLearned.Sink (this dictionary takes the imported pairs, in memory only: they are stored by MrWordStore, not in userbigram_dict.db)
.method public kind()I
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public word(Ljava/lang/String;I)V
    .locals 0

    return-void
.end method

.method public pair(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 0

    invoke-super {p0, p1, p2, p3}, Lcom/mrkeyboard/app/ExpandableDictionary;->setBigram(Ljava/lang/String;Ljava/lang/String;I)I

    return-void
.end method
