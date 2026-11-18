.class final Lcom/mrkeyboard/app/MrAppCacheDb;
.super Ljava/lang/Object;
.source "MrAppCacheDb.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrAppCache$Store;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrAppCacheDb$Helper;
    }
.end annotation


# static fields
.field private static final DB:Ljava/lang/String; = "mr_apps.db"

.field private static final K_LOCALE:Ljava/lang/String; = "locale"

.field private static final K_SIGNATURE:Ljava/lang/String; = "signature"


# instance fields
.field private final mHelper:Lcom/mrkeyboard/app/MrAppCacheDb$Helper;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    new-instance v0, Lcom/mrkeyboard/app/MrAppCacheDb$Helper;

    invoke-direct {v0, p1}, Lcom/mrkeyboard/app/MrAppCacheDb$Helper;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppCacheDb;->mHelper:Lcom/mrkeyboard/app/MrAppCacheDb$Helper;

    .line 38
    return-void
.end method


# virtual methods
.method close()V
    .locals 1

    .prologue
    .line 43
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppCacheDb;->mHelper:Lcom/mrkeyboard/app/MrAppCacheDb$Helper;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrAppCacheDb$Helper;->close()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 47
    :goto_0
    return-void

    .line 44
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public read()Lcom/mrkeyboard/app/MrAppCache$Snapshot;
    .locals 8

    .prologue
    const/4 v2, 0x0

    .line 50
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppCacheDb;->mHelper:Lcom/mrkeyboard/app/MrAppCacheDb$Helper;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrAppCacheDb$Helper;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v3

    .line 51
    if-nez v3, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->empty()Lcom/mrkeyboard/app/MrAppCache$Snapshot;

    move-result-object v0

    .line 78
    :goto_0
    return-object v0

    .line 53
    :cond_0
    const-string v0, "SELECT k, v FROM meta"

    invoke-virtual {v3, v0, v2}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v4

    move-object v0, v2

    move-object v1, v2

    .line 55
    :cond_1
    :goto_1
    :try_start_0
    invoke-interface {v4}, Landroid/database/Cursor;->moveToNext()Z

    move-result v5

    if-eqz v5, :cond_3

    .line 56
    const/4 v5, 0x0

    invoke-interface {v4, v5}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v5

    .line 57
    const-string v6, "signature"

    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    const/4 v1, 0x1

    invoke-interface {v4, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    .line 58
    :cond_2
    const-string v6, "locale"

    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/4 v0, 0x1

    invoke-interface {v4, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-result-object v0

    goto :goto_1

    .line 61
    :cond_3
    invoke-interface {v4}, Landroid/database/Cursor;->close()V

    .line 63
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 64
    new-instance v5, Ljava/util/HashMap;

    invoke-direct {v5}, Ljava/util/HashMap;-><init>()V

    .line 65
    const-string v6, "SELECT pkg, label, src FROM apps"

    invoke-virtual {v3, v6, v2}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v3

    .line 67
    :cond_4
    :goto_2
    :try_start_1
    invoke-interface {v3}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-eqz v2, :cond_6

    .line 68
    const/4 v2, 0x0

    invoke-interface {v3, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v6

    .line 69
    const/4 v2, 0x1

    invoke-interface {v3, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    .line 70
    if-eqz v6, :cond_4

    if-eqz v2, :cond_4

    .line 71
    new-instance v7, Lcom/mrkeyboard/app/MrAppList$Entry;

    invoke-direct {v7, v6, v2}, Lcom/mrkeyboard/app/MrAppList$Entry;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v4, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 72
    const/4 v2, 0x2

    invoke-interface {v3, v2}, Landroid/database/Cursor;->isNull(I)Z

    move-result v2

    if-eqz v2, :cond_5

    const-string v2, ""

    :goto_3
    invoke-virtual {v5, v6, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2

    .line 75
    :catchall_0
    move-exception v0

    invoke-interface {v3}, Landroid/database/Cursor;->close()V

    .line 76
    throw v0

    .line 61
    :catchall_1
    move-exception v0

    invoke-interface {v4}, Landroid/database/Cursor;->close()V

    .line 62
    throw v0

    .line 72
    :cond_5
    const/4 v2, 0x2

    :try_start_2
    invoke-interface {v3, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v2

    goto :goto_3

    .line 75
    :cond_6
    invoke-interface {v3}, Landroid/database/Cursor;->close()V

    .line 77
    invoke-static {v4}, Lcom/mrkeyboard/app/MrAppList;->sort(Ljava/util/List;)V

    .line 78
    new-instance v2, Lcom/mrkeyboard/app/MrAppCache$Snapshot;

    invoke-direct {v2, v1, v0, v4, v5}, Lcom/mrkeyboard/app/MrAppCache$Snapshot;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/Map;)V

    move-object v0, v2

    goto/16 :goto_0
.end method

.method public write(Lcom/mrkeyboard/app/MrAppCache$Snapshot;)V
    .locals 8

    .prologue
    .line 82
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppCacheDb;->mHelper:Lcom/mrkeyboard/app/MrAppCacheDb$Helper;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrAppCacheDb$Helper;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v2

    .line 83
    if-nez v2, :cond_0

    .line 98
    :goto_0
    return-void

    .line 84
    :cond_0
    invoke-virtual {v2}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V

    .line 86
    :try_start_0
    const-string v0, "DELETE FROM apps"

    invoke-virtual {v2, v0}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 87
    const-string v0, "DELETE FROM meta"

    invoke-virtual {v2, v0}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 88
    iget-object v0, p1, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->entries:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Entry;

    .line 89
    iget-object v1, p1, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->sources:Ljava/util/Map;

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    invoke-interface {v1, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 90
    const-string v4, "INSERT INTO apps (pkg, label, src) VALUES (?, ?, ?)"

    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAppList$Entry;->label:Ljava/lang/String;

    aput-object v0, v5, v6

    const/4 v0, 0x2

    if-nez v1, :cond_1

    const-string v1, ""

    :cond_1
    aput-object v1, v5, v0

    invoke-virtual {v2, v4, v5}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    .line 96
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V

    .line 97
    throw v0

    .line 92
    :cond_2
    :try_start_1
    const-string v0, "INSERT INTO meta (k, v) VALUES (?, ?)"

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v3, 0x0

    const-string v4, "signature"

    aput-object v4, v1, v3

    const/4 v3, 0x1

    iget-object v4, p1, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->signature:Ljava/lang/String;

    aput-object v4, v1, v3

    invoke-virtual {v2, v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 93
    const-string v0, "INSERT INTO meta (k, v) VALUES (?, ?)"

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v3, 0x0

    const-string v4, "locale"

    aput-object v4, v1, v3

    const/4 v3, 0x1

    iget-object v4, p1, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->locale:Ljava/lang/String;

    aput-object v4, v1, v3

    invoke-virtual {v2, v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 94
    invoke-virtual {v2}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 96
    invoke-virtual {v2}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V

    goto :goto_0
.end method
