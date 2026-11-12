.class Lcom/mrkeyboard/app/MrPacksActivity$11;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity;->download(Lcom/mrkeyboard/app/MrPacks$Pack;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrPacksActivity;

.field final synthetic val$app:Landroid/content/Context;

.field final synthetic val$cat:Lcom/mrkeyboard/app/MrPacks$Catalog;

.field final synthetic val$p:Lcom/mrkeyboard/app/MrPacks$Pack;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity;Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Catalog;Lcom/mrkeyboard/app/MrPacks$Pack;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 449
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$11;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrPacksActivity$11;->val$app:Landroid/content/Context;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrPacksActivity$11;->val$cat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    iput-object p4, p0, Lcom/mrkeyboard/app/MrPacksActivity$11;->val$p:Lcom/mrkeyboard/app/MrPacks$Pack;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 451
    .line 453
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$11;->val$app:Landroid/content/Context;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity$11;->val$cat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrPacksActivity$11;->val$p:Lcom/mrkeyboard/app/MrPacks$Pack;

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrPacks;->install(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Catalog;Lcom/mrkeyboard/app/MrPacks$Pack;)V
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 459
    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 462
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$11;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$200(Lcom/mrkeyboard/app/MrPacksActivity;)Landroid/os/Handler;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$11$1;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity$11$1;-><init>(Lcom/mrkeyboard/app/MrPacksActivity$11;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 485
    return-void

    .line 454
    :catch_0
    move-exception v1

    .line 455
    :try_start_1
    iget-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity$11;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-virtual {v2, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->msg(Lcom/mrkeyboard/app/MrPacks$PackException;)Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v1

    .line 459
    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    move-object v0, v1

    .line 460
    goto :goto_0

    .line 456
    :catch_1
    move-exception v1

    .line 457
    :try_start_2
    iget-object v3, p0, Lcom/mrkeyboard/app/MrPacksActivity$11;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity$11;->val$p:Lcom/mrkeyboard/app/MrPacks$Pack;

    iget-boolean v2, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->model:Z

    if-eqz v2, :cond_0

    const-string v2, "mr_gesture_err_io"

    :goto_1
    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v4, v5

    invoke-virtual {v3, v2, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v1

    .line 459
    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    move-object v0, v1

    .line 460
    goto :goto_0

    .line 457
    :cond_0
    :try_start_3
    const-string v2, "mr_dicts_err_io"
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    .line 459
    :catchall_0
    move-exception v1

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 460
    throw v1
.end method
