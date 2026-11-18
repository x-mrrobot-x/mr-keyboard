.class final Lcom/mrkeyboard/app/MrAppCache;
.super Ljava/lang/Object;
.source "MrAppCache.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrAppPicker$Live;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrAppCache$Disk;,
        Lcom/mrkeyboard/app/MrAppCache$Sql;
    }
.end annotation


# instance fields
.field private final mCtx:Landroid/content/Context;

.field private final mDisk:Lcom/mrkeyboard/app/MrAppCache$Disk;


# direct methods
.method constructor <init>(Landroid/content/Context;Lcom/mrkeyboard/app/MrAppCache$Disk;)V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppCache;->mCtx:Landroid/content/Context;

    .line 29
    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppCache;->mDisk:Lcom/mrkeyboard/app/MrAppCache$Disk;

    .line 30
    return-void
.end method

.method static open(Landroid/content/Context;)Lcom/mrkeyboard/app/MrAppCache;
    .locals 2

    .prologue
    .line 33
    new-instance v0, Lcom/mrkeyboard/app/MrAppCache;

    new-instance v1, Lcom/mrkeyboard/app/MrAppCache$Sql;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrAppCache$Sql;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, p0, v1}, Lcom/mrkeyboard/app/MrAppCache;-><init>(Landroid/content/Context;Lcom/mrkeyboard/app/MrAppCache$Disk;)V

    return-object v0
.end method


# virtual methods
.method public cached()Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;"
        }
    .end annotation

    .prologue
    .line 37
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 38
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppCache;->mDisk:Lcom/mrkeyboard/app/MrAppCache$Disk;

    invoke-interface {v0}, Lcom/mrkeyboard/app/MrAppCache$Disk;->rows()Ljava/util/Map;

    move-result-object v0

    .line 39
    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    new-instance v4, Lcom/mrkeyboard/app/MrAppList$Entry;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    const/4 v5, 0x0

    aget-object v0, v0, v5

    invoke-direct {v4, v1, v0}, Lcom/mrkeyboard/app/MrAppList$Entry;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 40
    :cond_0
    invoke-static {v2}, Lcom/mrkeyboard/app/MrAppList;->sort(Ljava/util/List;)V

    .line 41
    return-object v2
.end method

.method public close()V
    .locals 1

    .prologue
    .line 55
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppCache;->mDisk:Lcom/mrkeyboard/app/MrAppCache$Disk;

    invoke-interface {v0}, Lcom/mrkeyboard/app/MrAppCache$Disk;->close()V

    .line 56
    return-void
.end method

.method public refresh()Ljava/util/List;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;"
        }
    .end annotation

    .prologue
    .line 45
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppCache;->mCtx:Landroid/content/Context;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppList;->scan(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    .line 46
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppList;->signature(Ljava/util/List;)Ljava/lang/String;

    move-result-object v1

    .line 47
    if-eqz v1, :cond_0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppCache;->mDisk:Lcom/mrkeyboard/app/MrAppCache$Disk;

    invoke-interface {v2}, Lcom/mrkeyboard/app/MrAppCache$Disk;->signature()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 v0, 0x0

    .line 51
    :goto_0
    return-object v0

    .line 48
    :cond_0
    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    .line 49
    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppCache;->mCtx:Landroid/content/Context;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAppCache;->mDisk:Lcom/mrkeyboard/app/MrAppCache$Disk;

    invoke-interface {v4}, Lcom/mrkeyboard/app/MrAppCache$Disk;->rows()Ljava/util/Map;

    move-result-object v4

    invoke-static {v3, v0, v4, v2}, Lcom/mrkeyboard/app/MrAppList;->named(Landroid/content/Context;Ljava/util/List;Ljava/util/Map;Ljava/util/Map;)Ljava/util/List;

    move-result-object v0

    .line 50
    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppCache;->mDisk:Lcom/mrkeyboard/app/MrAppCache$Disk;

    invoke-interface {v3, v2, v1}, Lcom/mrkeyboard/app/MrAppCache$Disk;->save(Ljava/util/Map;Ljava/lang/String;)V

    goto :goto_0
.end method
