.class Lcom/mrkeyboard/app/MrTourActivity$3;
.super Ljava/lang/Object;
.source "MrTourActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrTourActivity;->render()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrTourActivity;

.field final synthetic val$choose:Z

.field final synthetic val$step:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrTourActivity;ZLjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 202
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTourActivity$3;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    iput-boolean p2, p0, Lcom/mrkeyboard/app/MrTourActivity$3;->val$choose:Z

    iput-object p3, p0, Lcom/mrkeyboard/app/MrTourActivity$3;->val$step:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 204
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrTourActivity$3;->val$choose:Z

    if-eqz v0, :cond_0

    .line 205
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$3;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$3;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    const-class v2, Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrNav;->intent(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrTourActivity;->startActivity(Landroid/content/Intent;)V

    .line 211
    :goto_0
    return-void

    .line 208
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$3;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$3;->val$step:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTour;->download(Landroid/content/Context;Ljava/lang/String;)V

    .line 209
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$3;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$400(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$3;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$500(Lcom/mrkeyboard/app/MrTourActivity;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 210
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$3;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$400(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$3;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$500(Lcom/mrkeyboard/app/MrTourActivity;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0
.end method
