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

.field final synthetic val$done:Lcom/mrkeyboard/app/MrLearned$Result;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity$21;Lcom/mrkeyboard/app/MrLearned$Result;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 700
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->val$done:Lcom/mrkeyboard/app/MrLearned$Result;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    const/4 v3, 0x0

    const/4 v4, 0x0

    .line 702
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v3, v4}, Lcom/mrkeyboard/app/MrImportActivity;->access$1800(Lcom/mrkeyboard/app/MrImportActivity;ZLjava/lang/String;)V

    .line 703
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->val$done:Lcom/mrkeyboard/app/MrLearned$Result;

    if-nez v0, :cond_1

    .line 704
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImportActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

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

    .line 718
    :cond_0
    :goto_0
    return-void

    .line 707
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->val$done:Lcom/mrkeyboard/app/MrLearned$Result;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrLearned$Result;->total()I

    move-result v0

    if-lez v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->changed(Landroid/content/Context;)V

    .line 708
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->val$done:Lcom/mrkeyboard/app/MrLearned$Result;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v2, v2, Lcom/mrkeyboard/app/MrImportActivity$21;->val$locale:Ljava/lang/String;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v3, v3, Lcom/mrkeyboard/app/MrImportActivity$21;->val$app:Ljava/lang/String;

    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrImportActivity;->access$3400(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;Ljava/lang/String;)V

    .line 709
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImportActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    .line 710
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->val$done:Lcom/mrkeyboard/app/MrLearned$Result;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v2, v2, Lcom/mrkeyboard/app/MrImportActivity$21;->val$app:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrImportActivity;->access$3500(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;)V

    .line 711
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrImportActivity;->access$2002(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImport$Plan;)Lcom/mrkeyboard/app/MrImport$Plan;

    .line 712
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$400(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 713
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$3600(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/EditText;

    move-result-object v0

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 715
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrImportActivity;->access$1602(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 716
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1700(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 717
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$21;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$3700(Lcom/mrkeyboard/app/MrImportActivity;)V

    goto :goto_0
.end method
