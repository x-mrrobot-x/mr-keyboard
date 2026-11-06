.class Lcom/mrkeyboard/app/MrImportActivity$13$3;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity$13;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrImportActivity$13;

.field final synthetic val$done:Lcom/mrkeyboard/app/MrImport$Plan;

.field final synthetic val$missing:Z


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity$13;ZLcom/mrkeyboard/app/MrImport$Plan;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 451
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$13$3;->this$1:Lcom/mrkeyboard/app/MrImportActivity$13;

    iput-boolean p2, p0, Lcom/mrkeyboard/app/MrImportActivity$13$3;->val$missing:Z

    iput-object p3, p0, Lcom/mrkeyboard/app/MrImportActivity$13$3;->val$done:Lcom/mrkeyboard/app/MrImport$Plan;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 453
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$13$3;->this$1:Lcom/mrkeyboard/app/MrImportActivity$13;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$13;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImportActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 463
    :goto_0
    return-void

    .line 454
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$13$3;->this$1:Lcom/mrkeyboard/app/MrImportActivity$13;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$13;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    const/4 v1, 0x0

    invoke-static {v0, v3, v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$1800(Lcom/mrkeyboard/app/MrImportActivity;ZLjava/lang/String;)V

    .line 455
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity$13$3;->val$missing:Z

    if-eqz v0, :cond_1

    .line 456
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$13$3;->this$1:Lcom/mrkeyboard/app/MrImportActivity$13;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$13;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1900(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$13$3;->this$1:Lcom/mrkeyboard/app/MrImportActivity$13;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrImportActivity$13;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$1900(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v1

    const-string v2, "mr_import_need_dict"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 457
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$13$3;->val$done:Lcom/mrkeyboard/app/MrImport$Plan;

    if-nez v0, :cond_2

    .line 458
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$13$3;->this$1:Lcom/mrkeyboard/app/MrImportActivity$13;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$13;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1900(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$13$3;->this$1:Lcom/mrkeyboard/app/MrImportActivity$13;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrImportActivity$13;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$1900(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v1

    const-string v2, "mr_import_failed"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 460
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$13$3;->this$1:Lcom/mrkeyboard/app/MrImportActivity$13;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$13;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$13$3;->val$done:Lcom/mrkeyboard/app/MrImport$Plan;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$2302(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImport$Plan;)Lcom/mrkeyboard/app/MrImport$Plan;

    .line 461
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$13$3;->this$1:Lcom/mrkeyboard/app/MrImportActivity$13;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$13;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$2400(Lcom/mrkeyboard/app/MrImportActivity;)V

    goto :goto_0
.end method
