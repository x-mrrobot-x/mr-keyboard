.class final Lcom/mrkeyboard/app/MrAppCache$Snapshot;
.super Ljava/lang/Object;
.source "MrAppCache.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAppCache;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Snapshot"
.end annotation


# instance fields
.field final entries:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;"
        }
    .end annotation
.end field

.field final locale:Ljava/lang/String;

.field final signature:Ljava/lang/String;

.field final sources:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 40
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->signature:Ljava/lang/String;

    .line 41
    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->locale:Ljava/lang/String;

    .line 42
    iput-object p3, p0, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->entries:Ljava/util/List;

    .line 43
    iput-object p4, p0, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->sources:Ljava/util/Map;

    .line 44
    return-void
.end method

.method static empty()Lcom/mrkeyboard/app/MrAppCache$Snapshot;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 47
    new-instance v0, Lcom/mrkeyboard/app/MrAppCache$Snapshot;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    invoke-direct {v0, v3, v3, v1, v2}, Lcom/mrkeyboard/app/MrAppCache$Snapshot;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/Map;)V

    return-object v0
.end method
