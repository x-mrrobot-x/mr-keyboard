.class final Lcom/mrkeyboard/app/MrAppCache$Sql;
.super Ljava/lang/Object;
.source "MrAppCache.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrAppCache$Disk;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAppCache;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Sql"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrAppCache$Sql$Helper;
    }
.end annotation


# static fields
.field private static final DB:Ljava/lang/String; = "mr_apps.db"


# instance fields
.field private final mHelper:Lcom/mrkeyboard/app/MrAppCache$Sql$Helper;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 79
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 80
    new-instance v0, Lcom/mrkeyboard/app/MrAppCache$Sql$Helper;

    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAppCache$Sql$Helper;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppCache$Sql;->mHelper:Lcom/mrkeyboard/app/MrAppCache$Sql$Helper;

    .line 81
    return-void
.end method


# virtual methods
.method public close()V
    .locals 1

    .prologue
    .line 136
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppCache$Sql;->mHelper:Lcom/mrkeyboard/app/MrAppCache$Sql$Helper;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrAppCache$Sql$Helper;->close()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 139
    :goto_0
    return-void

    .line 137
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public rows()Ljava/util/Map;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "[",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 84
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 87
    :try_start_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppCache$Sql;->mHelper:Lcom/mrkeyboard/app/MrAppCache$Sql$Helper;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrAppCache$Sql$Helper;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v2

    .line 88
    if-nez v2, :cond_1

    .line 94
    if-eqz v1, :cond_0

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 96
    :cond_0
    :goto_0
    return-object v0

    .line 89
    :cond_1
    :try_start_1
    const-string v3, "SELECT pkg, label, stamp FROM apps"

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v1

    .line 90
    :goto_1
    if-eqz v1, :cond_2

    invoke-interface {v1}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-eqz v2, :cond_2

    const/4 v2, 0x0

    invoke-interface {v1, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/String;

    const/4 v4, 0x0

    const/4 v5, 0x1

    invoke-interface {v1, v5}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    const/4 v5, 0x2

    invoke-interface {v1, v5}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-virtual {v0, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 91
    :catch_0
    move-exception v2

    .line 92
    :try_start_2
    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 94
    if-eqz v1, :cond_0

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    goto :goto_0

    :cond_2
    if-eqz v1, :cond_0

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    goto :goto_0

    :catchall_0
    move-exception v0

    if-eqz v1, :cond_3

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 95
    :cond_3
    throw v0
.end method

.method public save(Ljava/util/Map;Ljava/lang/String;)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "[",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 114
    .line 116
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppCache$Sql;->mHelper:Lcom/mrkeyboard/app/MrAppCache$Sql$Helper;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrAppCache$Sql$Helper;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;

    move-result-object v2

    .line 117
    if-nez v2, :cond_0

    .line 132
    :goto_0
    return-void

    .line 118
    :cond_0
    invoke-virtual {v2}, Landroid/database/sqlite/SQLiteDatabase;->beginTransaction()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 120
    :try_start_1
    const-string v0, "DELETE FROM apps"

    invoke-virtual {v2, v0}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 121
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 122
    const-string v4, "INSERT INTO apps (pkg, label, stamp) VALUES (?, ?, ?)"

    const/4 v1, 0x3

    new-array v5, v1, [Ljava/lang/Object;

    const/4 v1, 0x0

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v6

    aput-object v6, v5, v1

    const/4 v6, 0x1

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/String;

    const/4 v7, 0x0

    aget-object v1, v1, v7

    aput-object v1, v5, v6

    const/4 v1, 0x2

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    const/4 v6, 0x1

    aget-object v0, v0, v6

    aput-object v0, v5, v1

    invoke-virtual {v2, v4, v5}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 128
    :catchall_0
    move-exception v0

    :try_start_2
    invoke-virtual {v2}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V

    .line 129
    throw v0
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0

    .line 130
    :catch_0
    move-exception v0

    goto :goto_0

    .line 124
    :cond_1
    if-nez p2, :cond_2

    :try_start_3
    const-string v0, "DELETE FROM meta WHERE k=\'sig\'"

    invoke-virtual {v2, v0}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 126
    :goto_2
    invoke-virtual {v2}, Landroid/database/sqlite/SQLiteDatabase;->setTransactionSuccessful()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 128
    :try_start_4
    invoke-virtual {v2}, Landroid/database/sqlite/SQLiteDatabase;->endTransaction()V
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_0

    goto :goto_0

    .line 125
    :cond_2
    :try_start_5
    const-string v0, "INSERT OR REPLACE INTO meta (k, v) VALUES (\'sig\', ?)"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p2, v1, v3

    invoke-virtual {v2, v0, v1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_2
.end method

.method public signature()Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 100
    .line 102
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppCache$Sql;->mHelper:Lcom/mrkeyboard/app/MrAppCache$Sql$Helper;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrAppCache$Sql$Helper;->getWritableDatabase()Landroid/database/sqlite/SQLiteDatabase;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v1

    .line 103
    if-nez v1, :cond_1

    .line 109
    if-eqz v0, :cond_0

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 107
    :cond_0
    :goto_0
    return-object v0

    .line 104
    :cond_1
    :try_start_1
    const-string v2, "SELECT v FROM meta WHERE k=\'sig\'"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/database/sqlite/SQLiteDatabase;->rawQuery(Ljava/lang/String;[Ljava/lang/String;)Landroid/database/Cursor;
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v1

    .line 105
    if-eqz v1, :cond_2

    :try_start_2
    invoke-interface {v1}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-eqz v2, :cond_2

    const/4 v2, 0x0

    invoke-interface {v1, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-result-object v0

    .line 109
    :cond_2
    if-eqz v1, :cond_0

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    goto :goto_0

    .line 106
    :catch_0
    move-exception v1

    move-object v1, v0

    .line 109
    :goto_1
    if-eqz v1, :cond_0

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    goto :goto_0

    :catchall_0
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    :goto_2
    if-eqz v1, :cond_3

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 110
    :cond_3
    throw v0

    .line 109
    :catchall_1
    move-exception v0

    goto :goto_2

    .line 106
    :catch_1
    move-exception v2

    goto :goto_1
.end method
