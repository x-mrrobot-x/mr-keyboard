.class Lcom/mrkeyboard/app/MrImportActivity$19$1;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity$19;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

.field final synthetic val$done:Lcom/mrkeyboard/app/MrLearned$Result;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity$19;Lcom/mrkeyboard/app/MrLearned$Result;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 634
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->val$done:Lcom/mrkeyboard/app/MrLearned$Result;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x0

    .line 636
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$19;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v3, v4}, Lcom/mrkeyboard/app/MrImportActivity;->access$1800(Lcom/mrkeyboard/app/MrImportActivity;ZLjava/lang/String;)V

    .line 637
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->val$done:Lcom/mrkeyboard/app/MrLearned$Result;

    if-nez v0, :cond_1

    .line 638
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$19;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImportActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$19;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1900(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrImportActivity$19;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$1900(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v1

    const-string v2, "mr_import_failed"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    .line 650
    :cond_0
    :goto_0
    return-void

    .line 641
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->val$done:Lcom/mrkeyboard/app/MrLearned$Result;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrLearned$Result;->total()I

    move-result v0

    if-lez v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$19;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->changed(Landroid/content/Context;)V

    .line 642
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$19;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->val$done:Lcom/mrkeyboard/app/MrLearned$Result;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

    iget-object v2, v2, Lcom/mrkeyboard/app/MrImportActivity$19;->val$locale:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrImportActivity;->access$3100(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;)V

    .line 643
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$19;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImportActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    .line 644
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$19;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->val$done:Lcom/mrkeyboard/app/MrLearned$Result;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$3200(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrLearned$Result;)V

    .line 645
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$19;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrImportActivity;->access$2302(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImport$Plan;)Lcom/mrkeyboard/app/MrImport$Plan;

    .line 646
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$19;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1600(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 647
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$19;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$2000(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/EditText;

    move-result-object v0

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 648
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$19;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$200(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 649
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$19$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$19;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$19;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$3300(Lcom/mrkeyboard/app/MrImportActivity;)V

    goto :goto_0
.end method
