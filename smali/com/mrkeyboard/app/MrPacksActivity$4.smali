.class Lcom/mrkeyboard/app/MrPacksActivity$4;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity;->check()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrPacksActivity;

.field final synthetic val$app:Landroid/content/Context;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity;Landroid/content/Context;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 262
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$4;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrPacksActivity$4;->val$app:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 264
    .line 267
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$4;->val$app:Landroid/content/Context;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->fetchCatalog(Landroid/content/Context;)Lcom/mrkeyboard/app/MrPacks$Catalog;
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 275
    :goto_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity$4;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacksActivity;->access$200(Lcom/mrkeyboard/app/MrPacksActivity;)Landroid/os/Handler;

    move-result-object v2

    new-instance v3, Lcom/mrkeyboard/app/MrPacksActivity$4$1;

    invoke-direct {v3, p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity$4$1;-><init>(Lcom/mrkeyboard/app/MrPacksActivity$4;Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Catalog;)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 289
    return-void

    .line 268
    :catch_0
    move-exception v1

    .line 269
    iget-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity$4;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-virtual {v2, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->msg(Lcom/mrkeyboard/app/MrPacks$PackException;)Ljava/lang/String;

    move-result-object v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    .line 272
    goto :goto_0

    .line 270
    :catch_1
    move-exception v1

    .line 271
    iget-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity$4;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    const-string v3, "mr_dicts_err_io"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v4, v5

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    goto :goto_0
.end method
