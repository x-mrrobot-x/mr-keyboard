.class Lcom/mrkeyboard/app/MrPacksActivity$12;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity;->confirmRemove(Ljava/lang/String;Ljava/lang/String;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrPacksActivity;

.field final synthetic val$id:Ljava/lang/String;

.field final synthetic val$model:Z


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity;ZLjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 495
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$12;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iput-boolean p2, p0, Lcom/mrkeyboard/app/MrPacksActivity$12;->val$model:Z

    iput-object p3, p0, Lcom/mrkeyboard/app/MrPacksActivity$12;->val$id:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 4

    .prologue
    const/4 v2, 0x0

    .line 497
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$12;->val$model:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$12;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$12;->val$id:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacks;->removeModel(Landroid/content/Context;Ljava/lang/String;)V

    .line 498
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$12;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1802(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 499
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$12;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1902(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 500
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$12;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity$12;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$12;->val$model:Z

    if-eqz v0, :cond_1

    const-string v0, "mr_gesture_removed_ok"

    :goto_1
    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v2, v0, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1200(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    .line 501
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$12;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1100(Lcom/mrkeyboard/app/MrPacksActivity;)V

    .line 502
    return-void

    .line 497
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$12;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$12;->val$id:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacks;->remove(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    .line 500
    :cond_1
    const-string v0, "mr_dicts_removed_ok"

    goto :goto_1
.end method
