.class final Lcom/mrkeyboard/app/MrSqlStore;
.super Ljava/lang/Object;
.source "MrSqlStore.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrWordStore;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrSqlStore$Helper;
    }
.end annotation


# static fields
.field private static final AUTO:Ljava/lang/String; = "auto_dict.db"

.field private static final BIGRAM:Ljava/lang/String; = "userbigram_dict.db"

.field private static final DB:Ljava/lang/String; = "mr_words.db"

.field private static sLastBatch:J


# instance fields
.field private final mCtx:Landroid/content/Context;

.field private final mHelper:Lcom/mrkeyboard/app/MrSqlStore$Helper;

.field private mTx:Landroid/database/sqlite/SQLiteDatabase;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 54
    iput-object p1, p0, Lcom/mrkeyboard/app/MrSqlStore;->mCtx:Landroid/content/Context;

    .line 55
    new-instance v0, Lcom/mrkeyboard/app/MrSqlStore$Helper;

    invoke-direct {v0, p1}, Lcom/mrkeyboard/app/MrSqlStore$Helper;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrSqlStore;->mHelper:Lcom/mrkeyboard/app/MrSqlStore$Helper;

    .line 56
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSqlStore;->mHelper:Lcom/mrkeyboard/app/MrSqlStore$Helper;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrSqlStore$Helper;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    .line 57
    return-void
.end method

.method private static closeQuietly(Landroid/database/sqlite/SQLiteDatabase;)V
    .locals 1

    .prologue
    .line 77
    if-eqz p0, :cond_0

    :try_start_0
    invoke-virtual {p0}, Landroid/database/sqlite/SQLiteDatabase;->close()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 81
    :cond_0
    :goto_0
    return-void

    .line 78
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static collect(Landroid/database/sqlite/SQLiteDatabase;Ljava/lang/String;Ljava/util/TreeSet;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/database/sqlite/SQLiteDatabase;",
            "Ljava/lang/String;",
            "Ljava/util/TreeSet",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 344
    .line 346
    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p0, p1, v1}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 347
    :cond_0
    :goto_0
    :try_start_1
    invoke-interface {v0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 348
    const/4 v1, 0x0

    invoke-interface {v0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    .line 349
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_0

    invoke-virtual {p2, v1}, Ljava/util/TreeSet;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_0

    .line 351
    :catch_0
    move-exception v1

    .line 354
    if-eqz v0, :cond_1

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 356
    :cond_1
    :goto_1
    return-void

    .line 354
    :cond_2
    if-eqz v0, :cond_1

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    goto :goto_1

    :catchall_0
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    :goto_2
    if-eqz v1, :cond_3

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 355
    :cond_3
    throw v0

    .line 354
    :catchall_1
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    goto :goto_2
.end method

.method private done(ILandroid/database/sqlite/SQLiteDatabase;)V
    .locals 1

    .prologue
    .line 95
    if-eqz p1, :cond_0

    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    :cond_0
    invoke-static {p2}, Lcom/mrkeyboard/app/MrSqlStore;->closeQuietly(Landroid/database/sqlite/SQLiteDatabase;)V

    .line 96
    :cond_1
    return-void
.end method

.method private static freqColumn(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 114
    packed-switch p0, :pswitch_data_0

    .line 119
    const-string v0, "_id"

    :goto_0
    return-object v0

    .line 115
    :pswitch_0
    const-string v0, "freq"

    goto :goto_0

    .line 116
    :pswitch_1
    const-string v0, "IFNULL(frequency.freq, 0)"

    goto :goto_0

    .line 118
    :pswitch_2
    const-string v0, "weight"

    goto :goto_0

    .line 114
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_2
    .end packed-switch
.end method

.method private static idColumn(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 110
    const/4 v0, 0x1

    if-ne p0, v0, :cond_0

    const-string v0, "main._id"

    :goto_0
    return-object v0

    :cond_0
    const-string v0, "_id"

    goto :goto_0
.end method

.method private learned(Ljava/lang/String;)Landroid/database/sqlite/SQLiteDatabase;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 67
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSqlStore;->mCtx:Landroid/content/Context;

    invoke-virtual {v1, p1}, Landroid/content/Context;->getDatabasePath(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    .line 68
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/io/File;->isFile()Z

    move-result v2

    if-nez v2, :cond_1

    .line 71
    :cond_0
    :goto_0
    return-object v0

    .line 69
    :cond_1
    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Landroid/database/sqlite/SQLiteDatabase;->openDatabase(Ljava/lang/String;Landroid/database/sqlite/SQLiteDatabase$CursorFactory;I)Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 70
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private open(I)Landroid/database/sqlite/SQLiteDatabase;
    .locals 1

    .prologue
    .line 87
    packed-switch p1, :pswitch_data_0

    .line 90
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrSqlStore;->own()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v0

    :goto_0
    return-object v0

    .line 88
    :pswitch_0
    const-string v0, "auto_dict.db"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrSqlStore;->learned(Ljava/lang/String;)Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v0

    goto :goto_0

    .line 89
    :pswitch_1
    const-string v0, "userbigram_dict.db"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrSqlStore;->learned(Ljava/lang/String;)Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v0

    goto :goto_0

    .line 87
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method private own()Landroid/database/sqlite/SQLiteDatabase;
    .locals 1

    .prologue
    .line 60
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSqlStore;->mTx:Landroid/database/sqlite/SQLiteDatabase;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrSqlStore;->mTx:Landroid/database/sqlite/SQLiteDatabase;

    .line 61
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSqlStore;->mHelper:Lcom/mrkeyboard/app/MrSqlStore$Helper;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrSqlStore$Helper;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v0

    goto :goto_0
.end method

.method private static readRow(ILandroid/database/Cursor;)Lcom/mrkeyboard/app/MrWordStore$Row;
    .locals 6

    .prologue
    const/4 v5, 0x3

    const/4 v4, 0x1

    .line 124
    new-instance v1, Lcom/mrkeyboard/app/MrWordStore$Row;

    invoke-direct {v1}, Lcom/mrkeyboard/app/MrWordStore$Row;-><init>()V

    .line 125
    iput p0, v1, Lcom/mrkeyboard/app/MrWordStore$Row;->kind:I

    .line 126
    const/4 v0, 0x0

    invoke-interface {p1, v0}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v2

    iput-wide v2, v1, Lcom/mrkeyboard/app/MrWordStore$Row;->id:J

    .line 127
    invoke-interface {p1, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    .line 128
    const/4 v0, 0x2

    invoke-interface {p1, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 129
    if-eq p0, v4, :cond_0

    if-ne p0, v5, :cond_1

    :cond_0
    :goto_0
    iput-object v0, v1, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    .line 130
    invoke-interface {p1, v5}, Landroid/database/Cursor;->getInt(I)I

    move-result v0

    iput v0, v1, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    .line 131
    const/4 v0, 0x4

    invoke-interface {p1, v0}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v2

    iput-wide v2, v1, Lcom/mrkeyboard/app/MrWordStore$Row;->batch:J

    .line 132
    const/4 v0, 0x5

    invoke-interface {p1, v0}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v2

    iput-wide v2, v1, Lcom/mrkeyboard/app/MrWordStore$Row;->added:J

    .line 133
    return-object v1

    .line 129
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static selectSql(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 99
    packed-switch p0, :pswitch_data_0

    .line 105
    const-string v0, "SELECT _id, word, \'\', 0, 0, added FROM blocked WHERE locale=?"

    :goto_0
    return-object v0

    .line 100
    :pswitch_0
    const-string v0, "SELECT _id, word, \'\', freq, 0, 0 FROM words WHERE locale=?"

    goto :goto_0

    .line 102
    :pswitch_1
    const-string v0, "SELECT main._id, word1, word2, IFNULL(frequency.freq, 0), 0, 0 FROM main LEFT JOIN frequency ON frequency.pair_id = main._id WHERE locale=?"

    goto :goto_0

    .line 103
    :pswitch_2
    const-string v0, "SELECT _id, word, \'\', weight, batch, added FROM words WHERE locale=?"

    goto :goto_0

    .line 104
    :pswitch_3
    const-string v0, "SELECT _id, w1, w2, weight, batch, added FROM pairs WHERE locale=?"

    goto :goto_0

    .line 99
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method


# virtual methods
.method public add(ILjava/lang/String;Lcom/mrkeyboard/app/MrWordStore$Row;)J
    .locals 10

    .prologue
    const-wide/16 v0, -0x1

    .line 209
    if-eqz p3, :cond_0

    iget-object v2, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    if-nez v2, :cond_1

    .line 242
    :cond_0
    :goto_0
    return-wide v0

    .line 210
    :cond_1
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrSqlStore;->open(I)Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v5

    .line 211
    if-eqz v5, :cond_0

    .line 212
    const/4 v2, 0x0

    .line 214
    packed-switch p1, :pswitch_data_0

    .line 236
    :try_start_0
    const-string v3, "INSERT INTO blocked (word, locale, added) VALUES (?, ?, ?)"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v6, 0x0

    iget-object v7, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    aput-object v7, v4, v6

    const/4 v6, 0x1

    aput-object p2, v4, v6

    const/4 v6, 0x2

    iget-wide v8, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->added:J

    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v7

    aput-object v7, v4, v6

    invoke-virtual {v5, v3, v4}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 239
    :goto_1
    const-string v3, "SELECT last_insert_rowid()"

    const/4 v4, 0x0

    invoke-virtual {v5, v3, v4}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v2

    .line 240
    invoke-interface {v2}, Landroid/database/Cursor;->moveToNext()Z

    move-result v3

    if-eqz v3, :cond_2

    const/4 v3, 0x0

    invoke-interface {v2, v3}, Landroid/database/Cursor;->getLong(I)J
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-wide v0

    .line 244
    :cond_2
    if-eqz v2, :cond_3

    invoke-interface {v2}, Landroid/database/Cursor;->close()V

    .line 245
    :cond_3
    invoke-direct {p0, p1, v5}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    goto :goto_0

    .line 216
    :pswitch_0
    :try_start_1
    const-string v3, "INSERT INTO words (word, freq, locale) VALUES (?, ?, ?)"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v6, 0x0

    iget-object v7, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    aput-object v7, v4, v6

    const/4 v6, 0x1

    iget v7, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v4, v6

    const/4 v6, 0x2

    aput-object p2, v4, v6

    invoke-virtual {v5, v3, v4}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 241
    :catch_0
    move-exception v3

    .line 244
    :goto_2
    if-eqz v2, :cond_4

    invoke-interface {v2}, Landroid/database/Cursor;->close()V

    .line 245
    :cond_4
    invoke-direct {p0, p1, v5}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    goto :goto_0

    .line 219
    :pswitch_1
    :try_start_2
    const-string v3, "INSERT INTO main (word1, word2, locale) VALUES (?, ?, ?)"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v6, 0x0

    iget-object v7, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    aput-object v7, v4, v6

    const/4 v6, 0x1

    iget-object v7, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    aput-object v7, v4, v6

    const/4 v6, 0x2

    aput-object p2, v4, v6

    invoke-virtual {v5, v3, v4}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 220
    const-string v3, "SELECT last_insert_rowid()"

    const/4 v4, 0x0

    invoke-virtual {v5, v3, v4}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v4

    .line 221
    :try_start_3
    invoke-interface {v4}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-eqz v2, :cond_6

    .line 222
    const/4 v2, 0x0

    invoke-interface {v4, v2}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v2

    .line 223
    const-string v6, "INSERT INTO frequency (pair_id, freq) VALUES (?, ?)"

    const/4 v7, 0x2

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v8, 0x0

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v9

    aput-object v9, v7, v8

    const/4 v8, 0x1

    iget v9, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    aput-object v9, v7, v8

    invoke-virtual {v5, v6, v7}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_3
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 244
    if-eqz v4, :cond_5

    invoke-interface {v4}, Landroid/database/Cursor;->close()V

    .line 245
    :cond_5
    invoke-direct {p0, p1, v5}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    move-wide v0, v2

    .line 224
    goto/16 :goto_0

    .line 244
    :cond_6
    if-eqz v4, :cond_7

    invoke-interface {v4}, Landroid/database/Cursor;->close()V

    .line 245
    :cond_7
    invoke-direct {p0, p1, v5}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    goto/16 :goto_0

    .line 228
    :pswitch_2
    :try_start_4
    const-string v3, "INSERT INTO words (word, locale, weight, batch, added) VALUES (?, ?, ?, ?, ?)"

    const/4 v4, 0x5

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v6, 0x0

    iget-object v7, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    aput-object v7, v4, v6

    const/4 v6, 0x1

    aput-object p2, v4, v6

    const/4 v6, 0x2

    iget v7, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    .line 229
    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v4, v6

    const/4 v6, 0x3

    iget-wide v8, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->batch:J

    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v7

    aput-object v7, v4, v6

    const/4 v6, 0x4

    iget-wide v8, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->added:J

    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v7

    aput-object v7, v4, v6

    .line 228
    invoke-virtual {v5, v3, v4}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto/16 :goto_1

    .line 244
    :catchall_0
    move-exception v0

    :goto_3
    if-eqz v2, :cond_8

    invoke-interface {v2}, Landroid/database/Cursor;->close()V

    .line 245
    :cond_8
    invoke-direct {p0, p1, v5}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    .line 246
    throw v0

    .line 232
    :pswitch_3
    :try_start_5
    const-string v3, "INSERT INTO pairs (w1, w2, locale, weight, batch, added) VALUES (?, ?, ?, ?, ?, ?)"

    const/4 v4, 0x6

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v6, 0x0

    iget-object v7, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    aput-object v7, v4, v6

    const/4 v6, 0x1

    iget-object v7, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    aput-object v7, v4, v6

    const/4 v6, 0x2

    aput-object p2, v4, v6

    const/4 v6, 0x3

    iget v7, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    .line 233
    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v4, v6

    const/4 v6, 0x4

    iget-wide v8, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->batch:J

    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v7

    aput-object v7, v4, v6

    const/4 v6, 0x5

    iget-wide v8, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->added:J

    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v7

    aput-object v7, v4, v6

    .line 232
    invoke-virtual {v5, v3, v4}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_5
    .catch Ljava/lang/RuntimeException; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto/16 :goto_1

    .line 244
    :catchall_1
    move-exception v0

    move-object v2, v4

    goto :goto_3

    .line 241
    :catch_1
    move-exception v2

    move-object v2, v4

    goto/16 :goto_2

    .line 214
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public all(ILjava/lang/String;)Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrWordStore$Row;",
            ">;"
        }
    .end annotation

    .prologue
    .line 190
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 191
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrSqlStore;->open(I)Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v2

    .line 192
    if-nez v2, :cond_0

    .line 203
    :goto_0
    return-object v0

    .line 193
    :cond_0
    const/4 v1, 0x0

    .line 195
    :try_start_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {p1}, Lcom/mrkeyboard/app/MrSqlStore;->selectSql(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " ORDER BY "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {p1}, Lcom/mrkeyboard/app/MrSqlStore;->idColumn(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/String;

    const/4 v5, 0x0

    aput-object p2, v4, v5

    invoke-virtual {v2, v3, v4}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v1

    .line 196
    :goto_1
    invoke-interface {v1}, Landroid/database/Cursor;->moveToNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-static {p1, v1}, Lcom/mrkeyboard/app/MrSqlStore;->readRow(ILandroid/database/Cursor;)Lcom/mrkeyboard/app/MrWordStore$Row;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    .line 197
    :catch_0
    move-exception v3

    .line 200
    if-eqz v1, :cond_1

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 201
    :cond_1
    invoke-direct {p0, p1, v2}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    goto :goto_0

    .line 200
    :cond_2
    if-eqz v1, :cond_3

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 201
    :cond_3
    invoke-direct {p0, p1, v2}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    goto :goto_0

    .line 200
    :catchall_0
    move-exception v0

    if-eqz v1, :cond_4

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 201
    :cond_4
    invoke-direct {p0, p1, v2}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    .line 202
    throw v0
.end method

.method public declared-synchronized begin()V
    .locals 1

    .prologue
    .line 361
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSqlStore;->mTx:Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    .line 364
    :goto_0
    monitor-exit p0

    return-void

    .line 362
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSqlStore;->mHelper:Lcom/mrkeyboard/app/MrSqlStore$Helper;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrSqlStore$Helper;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrSqlStore;->mTx:Landroid/database/sqlite/SQLiteDatabase;

    .line 363
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSqlStore;->mTx:Landroid/database/sqlite/SQLiteDatabase;

    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 361
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public count(ILjava/lang/String;)I
    .locals 6

    .prologue
    const/4 v2, 0x1

    const/4 v0, 0x0

    .line 137
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrSqlStore;->open(I)Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v3

    .line 138
    if-nez v3, :cond_0

    .line 146
    :goto_0
    return v0

    .line 139
    :cond_0
    const/4 v1, 0x0

    .line 141
    if-nez p1, :cond_3

    :try_start_0
    const-string v2, "words"

    .line 143
    :goto_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "SELECT COUNT(*) FROM "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " WHERE locale=?"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/String;

    const/4 v5, 0x0

    aput-object p2, v4, v5

    invoke-virtual {v3, v2, v4}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v1

    .line 144
    invoke-interface {v1}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-eqz v2, :cond_1

    const/4 v2, 0x0

    invoke-interface {v1, v2}, Landroid/database/Cursor;->getInt(I)I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    .line 148
    :cond_1
    if-eqz v1, :cond_2

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 149
    :cond_2
    invoke-direct {p0, p1, v3}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    goto :goto_0

    .line 141
    :cond_3
    if-ne p1, v2, :cond_4

    :try_start_1
    const-string v2, "main"

    goto :goto_1

    .line 142
    :cond_4
    const/4 v2, 0x2

    if-ne p1, v2, :cond_5

    const-string v2, "words"

    goto :goto_1

    :cond_5
    const/4 v2, 0x3

    if-ne p1, v2, :cond_6

    const-string v2, "pairs"

    goto :goto_1

    :cond_6
    const-string v2, "blocked"
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 145
    :catch_0
    move-exception v2

    .line 148
    if-eqz v1, :cond_7

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 149
    :cond_7
    invoke-direct {p0, p1, v3}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    goto :goto_0

    .line 148
    :catchall_0
    move-exception v0

    if-eqz v1, :cond_8

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 149
    :cond_8
    invoke-direct {p0, p1, v3}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    .line 150
    throw v0
.end method

.method public delete(IJ)Z
    .locals 6

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 250
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrSqlStore;->open(I)Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v2

    .line 251
    if-nez v2, :cond_0

    .line 266
    :goto_0
    return v0

    .line 253
    :cond_0
    const/4 v3, 0x1

    :try_start_0
    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v5

    aput-object v5, v3, v4

    .line 254
    packed-switch p1, :pswitch_data_0

    .line 262
    const-string v4, "DELETE FROM blocked WHERE _id=?"

    invoke-virtual {v2, v4, v3}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 268
    :goto_1
    invoke-direct {p0, p1, v2}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    move v0, v1

    .line 264
    goto :goto_0

    .line 255
    :pswitch_0
    :try_start_1
    const-string v4, "DELETE FROM words WHERE _id=?"

    invoke-virtual {v2, v4, v3}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 265
    :catch_0
    move-exception v1

    .line 268
    invoke-direct {p0, p1, v2}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    goto :goto_0

    .line 257
    :pswitch_1
    :try_start_2
    const-string v4, "DELETE FROM frequency WHERE pair_id=?"

    invoke-virtual {v2, v4, v3}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 258
    const-string v4, "DELETE FROM main WHERE _id=?"

    invoke-virtual {v2, v4, v3}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    .line 268
    :catchall_0
    move-exception v0

    invoke-direct {p0, p1, v2}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    .line 269
    throw v0

    .line 260
    :pswitch_2
    :try_start_3
    const-string v4, "DELETE FROM words WHERE _id=?"

    invoke-virtual {v2, v4, v3}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    .line 261
    :pswitch_3
    const-string v4, "DELETE FROM pairs WHERE _id=?"

    invoke-virtual {v2, v4, v3}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_3
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    .line 254
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public deleteAll(ILjava/lang/String;)I
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 273
    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/MrSqlStore;->count(ILjava/lang/String;)I

    move-result v1

    .line 274
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrSqlStore;->open(I)Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v2

    .line 275
    if-nez v2, :cond_0

    .line 290
    :goto_0
    return v0

    .line 277
    :cond_0
    const/4 v3, 0x1

    :try_start_0
    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p2, v3, v4

    .line 278
    packed-switch p1, :pswitch_data_0

    .line 286
    const-string v4, "DELETE FROM blocked WHERE locale=?"

    invoke-virtual {v2, v4, v3}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 292
    :goto_1
    invoke-direct {p0, p1, v2}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    move v0, v1

    .line 288
    goto :goto_0

    .line 279
    :pswitch_0
    :try_start_1
    const-string v4, "DELETE FROM words WHERE locale=?"

    invoke-virtual {v2, v4, v3}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 289
    :catch_0
    move-exception v1

    .line 292
    invoke-direct {p0, p1, v2}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    goto :goto_0

    .line 281
    :pswitch_1
    :try_start_2
    const-string v4, "DELETE FROM frequency WHERE pair_id IN (SELECT _id FROM main WHERE locale=?)"

    invoke-virtual {v2, v4, v3}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 282
    const-string v4, "DELETE FROM main WHERE locale=?"

    invoke-virtual {v2, v4, v3}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    .line 292
    :catchall_0
    move-exception v0

    invoke-direct {p0, p1, v2}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    .line 293
    throw v0

    .line 284
    :pswitch_2
    :try_start_3
    const-string v4, "DELETE FROM words WHERE locale=?"

    invoke-virtual {v2, v4, v3}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    .line 285
    :pswitch_3
    const-string v4, "DELETE FROM pairs WHERE locale=?"

    invoke-virtual {v2, v4, v3}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_3
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    .line 278
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public deleteBatch(Ljava/lang/String;J)I
    .locals 10

    .prologue
    const/4 v3, 0x2

    const/4 v0, 0x0

    .line 297
    .line 298
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrSqlStore;->own()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v4

    move v2, v3

    .line 300
    :goto_0
    const/4 v1, 0x3

    if-gt v2, v1, :cond_2

    .line 301
    if-ne v2, v3, :cond_1

    :try_start_0
    const-string v1, "words"

    .line 302
    :goto_1
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "SELECT COUNT(*) FROM "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " WHERE locale=? AND batch=?"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x2

    new-array v6, v6, [Ljava/lang/String;

    const/4 v7, 0x0

    aput-object p1, v6, v7

    const/4 v7, 0x1

    invoke-static {p2, p3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v8

    aput-object v8, v6, v7

    invoke-virtual {v4, v5, v6}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v5

    .line 304
    :try_start_1
    invoke-interface {v5}, Landroid/database/Cursor;->moveToNext()Z

    move-result v6

    if-eqz v6, :cond_0

    const/4 v6, 0x0

    invoke-interface {v5, v6}, Landroid/database/Cursor;->getInt(I)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v6

    add-int/2addr v0, v6

    .line 306
    :cond_0
    :try_start_2
    invoke-interface {v5}, Landroid/database/Cursor;->close()V

    .line 308
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "DELETE FROM "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v5, " WHERE locale=? AND batch=?"

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object p1, v5, v6

    const/4 v6, 0x1

    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v7

    aput-object v7, v5, v6

    invoke-virtual {v4, v1, v5}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 300
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_0

    .line 301
    :cond_1
    const-string v1, "pairs"

    goto :goto_1

    .line 306
    :catchall_0
    move-exception v1

    invoke-interface {v5}, Landroid/database/Cursor;->close()V

    .line 307
    throw v1
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0

    .line 310
    :catch_0
    move-exception v1

    .line 313
    :cond_2
    return v0
.end method

.method public declared-synchronized end()V
    .locals 2

    .prologue
    .line 367
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSqlStore;->mTx:Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    .line 374
    :goto_0
    monitor-exit p0

    return-void

    .line 369
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSqlStore;->mTx:Landroid/database/sqlite/SQLiteDatabase;

    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 371
    :try_start_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSqlStore;->mTx:Landroid/database/sqlite/SQLiteDatabase;

    invoke-virtual {v0}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V

    .line 372
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrSqlStore;->mTx:Landroid/database/sqlite/SQLiteDatabase;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 367
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 371
    :catchall_1
    move-exception v0

    :try_start_3
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSqlStore;->mTx:Landroid/database/sqlite/SQLiteDatabase;

    invoke-virtual {v1}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V

    .line 372
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/mrkeyboard/app/MrSqlStore;->mTx:Landroid/database/sqlite/SQLiteDatabase;

    .line 373
    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0
.end method

.method public list(ILjava/lang/String;Ljava/lang/String;III)Ljava/util/List;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "III)",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrWordStore$Row;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v0, 0x1

    const/4 v3, 0x0

    .line 154
    if-eqz p3, :cond_0

    invoke-virtual {p3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    move v4, v0

    .line 155
    :goto_0
    if-nez p4, :cond_1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " ORDER BY "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Lcom/mrkeyboard/app/MrSqlStore;->freqColumn(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " DESC, "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Lcom/mrkeyboard/app/MrSqlStore;->idColumn(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " DESC"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 157
    :goto_1
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 158
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrSqlStore;->open(I)Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v5

    .line 159
    if-nez v5, :cond_2

    move-object v0, v1

    .line 182
    :goto_2
    return-object v0

    :cond_0
    move v4, v3

    .line 154
    goto :goto_0

    .line 156
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " ORDER BY "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Lcom/mrkeyboard/app/MrSqlStore;->idColumn(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " DESC"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 160
    :cond_2
    const/4 v2, 0x0

    .line 162
    if-nez v4, :cond_6

    .line 163
    :try_start_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {p1}, Lcom/mrkeyboard/app/MrSqlStore;->selectSql(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " LIMIT "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v3, 0x0

    invoke-static {v3, p6}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " OFFSET "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v3, 0x0

    invoke-static {v3, p5}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/String;

    const/4 v4, 0x0

    aput-object p2, v3, v4

    invoke-virtual {v5, v0, v3}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-result-object v0

    .line 164
    :goto_3
    :try_start_1
    invoke-interface {v0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrSqlStore;->readRow(ILandroid/database/Cursor;)Lcom/mrkeyboard/app/MrWordStore$Row;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_3

    .line 181
    :catch_0
    move-exception v2

    .line 184
    :goto_4
    if-eqz v0, :cond_3

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 185
    :cond_3
    invoke-direct {p0, p1, v5}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    move-object v0, v1

    .line 182
    goto :goto_2

    .line 184
    :cond_4
    if-eqz v0, :cond_5

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 185
    :cond_5
    invoke-direct {p0, p1, v5}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    move-object v0, v1

    .line 165
    goto/16 :goto_2

    .line 168
    :cond_6
    :try_start_2
    invoke-virtual {p3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/mrkeyboard/app/MrMemStore;->fold(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 169
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {p1}, Lcom/mrkeyboard/app/MrSqlStore;->selectSql(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/String;

    const/4 v7, 0x0

    aput-object p2, v6, v7

    invoke-virtual {v5, v0, v6}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-result-object v0

    move v2, v3

    .line 171
    :cond_7
    :goto_5
    :try_start_3
    invoke-interface {v0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v3

    if-eqz v3, :cond_a

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v3, p6, :cond_a

    .line 172
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrSqlStore;->readRow(ILandroid/database/Cursor;)Lcom/mrkeyboard/app/MrWordStore$Row;

    move-result-object v3

    .line 173
    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrWordStore$Row;->text()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/mrkeyboard/app/MrMemStore;->fold(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_7

    .line 174
    if-ge v2, p5, :cond_8

    .line 175
    add-int/lit8 v2, v2, 0x1

    .line 176
    goto :goto_5

    .line 178
    :cond_8
    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_3
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_5

    .line 184
    :catchall_0
    move-exception v1

    move-object v2, v0

    move-object v0, v1

    :goto_6
    if-eqz v2, :cond_9

    invoke-interface {v2}, Landroid/database/Cursor;->close()V

    .line 185
    :cond_9
    invoke-direct {p0, p1, v5}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    .line 186
    throw v0

    .line 184
    :cond_a
    if-eqz v0, :cond_b

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 185
    :cond_b
    invoke-direct {p0, p1, v5}, Lcom/mrkeyboard/app/MrSqlStore;->done(ILandroid/database/sqlite/SQLiteDatabase;)V

    move-object v0, v1

    .line 180
    goto/16 :goto_2

    .line 184
    :catchall_1
    move-exception v0

    goto :goto_6

    .line 181
    :catch_1
    move-exception v0

    move-object v0, v2

    goto :goto_4
.end method

.method public locales()Ljava/util/List;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v5, 0x2

    const/4 v7, 0x1

    const/4 v1, 0x0

    .line 322
    new-instance v2, Ljava/util/TreeSet;

    invoke-direct {v2}, Ljava/util/TreeSet;-><init>()V

    .line 323
    new-array v3, v5, [[Ljava/lang/String;

    new-array v0, v5, [Ljava/lang/String;

    const-string v4, "auto_dict.db"

    aput-object v4, v0, v1

    const-string v4, "SELECT DISTINCT locale FROM words"

    aput-object v4, v0, v7

    aput-object v0, v3, v1

    new-array v0, v5, [Ljava/lang/String;

    const-string v4, "userbigram_dict.db"

    aput-object v4, v0, v1

    const-string v4, "SELECT DISTINCT locale FROM main"

    aput-object v4, v0, v7

    aput-object v0, v3, v7

    .line 324
    array-length v4, v3

    move v0, v1

    :goto_0
    if-ge v0, v4, :cond_1

    aget-object v5, v3, v0

    .line 325
    aget-object v6, v5, v1

    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/MrSqlStore;->learned(Ljava/lang/String;)Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v6

    .line 326
    if-nez v6, :cond_0

    .line 324
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 327
    :cond_0
    aget-object v5, v5, v7

    invoke-static {v6, v5, v2}, Lcom/mrkeyboard/app/MrSqlStore;->collect(Landroid/database/sqlite/SQLiteDatabase;Ljava/lang/String;Ljava/util/TreeSet;)V

    .line 328
    invoke-static {v6}, Lcom/mrkeyboard/app/MrSqlStore;->closeQuietly(Landroid/database/sqlite/SQLiteDatabase;)V

    goto :goto_1

    .line 330
    :cond_1
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrSqlStore;->own()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v0

    .line 331
    const-string v1, "SELECT DISTINCT locale FROM words"

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrSqlStore;->collect(Landroid/database/sqlite/SQLiteDatabase;Ljava/lang/String;Ljava/util/TreeSet;)V

    .line 332
    const-string v1, "SELECT DISTINCT locale FROM pairs"

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrSqlStore;->collect(Landroid/database/sqlite/SQLiteDatabase;Ljava/lang/String;Ljava/util/TreeSet;)V

    .line 333
    const-string v1, "SELECT DISTINCT locale FROM blocked"

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrSqlStore;->collect(Landroid/database/sqlite/SQLiteDatabase;Ljava/lang/String;Ljava/util/TreeSet;)V

    .line 334
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, v2}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 335
    new-instance v1, Lcom/mrkeyboard/app/MrSqlStore$1;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrSqlStore$1;-><init>(Lcom/mrkeyboard/app/MrSqlStore;)V

    invoke-static {v0, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 340
    return-object v0
.end method

.method public declared-synchronized newBatch()J
    .locals 6

    .prologue
    .line 317
    monitor-enter p0

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sget-wide v2, Lcom/mrkeyboard/app/MrSqlStore;->sLastBatch:J

    const-wide/16 v4, 0x1

    add-long/2addr v2, v4

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v0

    sput-wide v0, Lcom/mrkeyboard/app/MrSqlStore;->sLastBatch:J

    .line 318
    sget-wide v0, Lcom/mrkeyboard/app/MrSqlStore;->sLastBatch:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-wide v0

    .line 317
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
