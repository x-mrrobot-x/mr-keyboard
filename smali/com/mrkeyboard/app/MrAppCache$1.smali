.class Lcom/mrkeyboard/app/MrAppCache$1;
.super Ljava/lang/Object;
.source "MrAppCache.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrAppPicker$Source;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppCache;->source(Landroid/content/Context;)Lcom/mrkeyboard/app/MrAppPicker$Source;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$c:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 148
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppCache$1;->val$c:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public load(Lcom/mrkeyboard/app/MrAppPicker$Sink;)V
    .locals 3

    .prologue
    .line 151
    const/4 v1, 0x0

    .line 153
    :try_start_0
    new-instance v0, Lcom/mrkeyboard/app/MrAppCacheDb;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppCache$1;->val$c:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppCache$1;->val$c:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    :goto_0
    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/MrAppCacheDb;-><init>(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, v0

    .line 157
    :goto_1
    if-nez v1, :cond_1

    .line 158
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppCache$1;->val$c:Landroid/content/Context;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppList;->load(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    invoke-interface {p1, v0}, Lcom/mrkeyboard/app/MrAppPicker$Sink;->publish(Ljava/util/List;)V

    .line 166
    :goto_2
    return-void

    .line 153
    :cond_0
    :try_start_1
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppCache$1;->val$c:Landroid/content/Context;
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 162
    :cond_1
    :try_start_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppCache$1;->val$c:Landroid/content/Context;

    invoke-static {v0, v1, p1}, Lcom/mrkeyboard/app/MrAppCache;->refresh(Landroid/content/Context;Lcom/mrkeyboard/app/MrAppCache$Store;Lcom/mrkeyboard/app/MrAppPicker$Sink;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 164
    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrAppCacheDb;->close()V

    goto :goto_2

    :catchall_0
    move-exception v0

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrAppCacheDb;->close()V

    .line 165
    throw v0

    .line 154
    :catch_0
    move-exception v0

    goto :goto_1
.end method
