.class final Lcom/mrkeyboard/app/MrAppCache$Sql$Helper;
.super Landroid/database/sqlite/SQLiteOpenHelper;
.source "MrAppCache.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAppCache$Sql;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Helper"
.end annotation


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 3

    .prologue
    .line 65
    const-string v0, "mr_apps.db"

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-direct {p0, p1, v0, v1, v2}, Landroid/database/sqlite/SQLiteOpenHelper;-><init>(Landroid/content/Context;Ljava/lang/String;Landroid/database/sqlite/SQLiteDatabase$CursorFactory;I)V

    .line 66
    return-void
.end method


# virtual methods
.method public onCreate(Landroid/database/sqlite/SQLiteDatabase;)V
    .locals 1

    .prologue
    .line 70
    const-string v0, "CREATE TABLE apps (pkg TEXT PRIMARY KEY, label TEXT NOT NULL, stamp TEXT NOT NULL)"

    invoke-virtual {p1, v0}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 71
    const-string v0, "CREATE TABLE meta (k TEXT PRIMARY KEY, v TEXT)"

    invoke-virtual {p1, v0}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V

    .line 72
    return-void
.end method

.method public onUpgrade(Landroid/database/sqlite/SQLiteDatabase;II)V
    .locals 0

    .prologue
    .line 76
    return-void
.end method
