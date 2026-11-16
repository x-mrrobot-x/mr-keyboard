.class Lcom/mrkeyboard/app/MrTourActivity$7$1;
.super Ljava/lang/Object;
.source "MrTourActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrTourActivity$7;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrTourActivity$7;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrTourActivity$7;)V
    .locals 0

    .prologue
    .line 629
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTourActivity$7$1;->this$1:Lcom/mrkeyboard/app/MrTourActivity$7;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 631
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$7$1;->this$1:Lcom/mrkeyboard/app/MrTourActivity$7;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrTourActivity$7;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$102(Lcom/mrkeyboard/app/MrTourActivity;Z)Z

    .line 632
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$7$1;->this$1:Lcom/mrkeyboard/app/MrTourActivity$7;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrTourActivity$7;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$600(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$7$1;->this$1:Lcom/mrkeyboard/app/MrTourActivity$7;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrTourActivity$7;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$1500(Lcom/mrkeyboard/app/MrTourActivity;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 633
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$7$1;->this$1:Lcom/mrkeyboard/app/MrTourActivity$7;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrTourActivity$7;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$1600(Lcom/mrkeyboard/app/MrTourActivity;)V

    .line 634
    return-void
.end method
