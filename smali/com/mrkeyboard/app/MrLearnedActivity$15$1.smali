.class Lcom/mrkeyboard/app/MrLearnedActivity$15$1;
.super Ljava/lang/Object;
.source "MrLearnedActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrLearnedActivity$15;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrLearnedActivity$15;

.field final synthetic val$done:Z


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrLearnedActivity$15;Z)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 530
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$15$1;->this$1:Lcom/mrkeyboard/app/MrLearnedActivity$15;

    iput-boolean p2, p0, Lcom/mrkeyboard/app/MrLearnedActivity$15$1;->val$done:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 532
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$15$1;->this$1:Lcom/mrkeyboard/app/MrLearnedActivity$15;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrLearnedActivity$15;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$15$1;->this$1:Lcom/mrkeyboard/app/MrLearnedActivity$15;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrLearnedActivity$15;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$1400(Lcom/mrkeyboard/app/MrLearnedActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$15$1;->this$1:Lcom/mrkeyboard/app/MrLearnedActivity$15;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrLearnedActivity$15;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$1400(Lcom/mrkeyboard/app/MrLearnedActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v2

    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$15$1;->val$done:Z

    if-eqz v0, :cond_1

    const-string v0, "mr_learned_export_done"

    :goto_0
    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v2, v0, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    .line 533
    :cond_0
    return-void

    .line 532
    :cond_1
    const-string v0, "mr_learned_export_failed"

    goto :goto_0
.end method
