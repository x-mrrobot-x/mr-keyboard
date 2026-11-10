.class Lcom/mrkeyboard/app/MrImportActivity$21$1;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity$21;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

.field final synthetic val$done:Lcom/mrkeyboard/app/MrImportAi$Plan;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity$21;Lcom/mrkeyboard/app/MrImportAi$Plan;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 720
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->val$done:Lcom/mrkeyboard/app/MrImportAi$Plan;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 722
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    const/4 v1, 0x0

    invoke-static {v0, v3, v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$1800(Lcom/mrkeyboard/app/MrImportActivity;ZLjava/lang/String;)V

    .line 723
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImportActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 727
    :goto_0
    return-void

    .line 724
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->val$done:Lcom/mrkeyboard/app/MrImportAi$Plan;

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1900(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$1900(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v1

    const-string v2, "mr_import_failed"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 725
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->val$done:Lcom/mrkeyboard/app/MrImportAi$Plan;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImportAi$Plan;->requests()I

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1900(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$1900(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v1

    const-string v2, "mr_import_ai_nothing"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 726
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->val$done:Lcom/mrkeyboard/app/MrImportAi$Plan;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$3400(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;)V

    goto :goto_0
.end method
