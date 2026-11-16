.class Lcom/mrkeyboard/app/MrTourActivity$1;
.super Ljava/lang/Object;
.source "MrTourActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrTourActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrTourActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrTourActivity;)V
    .locals 0

    .prologue
    .line 35
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 37
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrTourActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$000(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/widget/LinearLayout;

    move-result-object v0

    if-nez v0, :cond_1

    .line 44
    :cond_0
    :goto_0
    return-void

    .line 38
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$100(Lcom/mrkeyboard/app/MrTourActivity;)Ljava/lang/String;

    move-result-object v0

    .line 39
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$200(Lcom/mrkeyboard/app/MrTourActivity;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 40
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$202(Lcom/mrkeyboard/app/MrTourActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 41
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$300(Lcom/mrkeyboard/app/MrTourActivity;)V

    .line 43
    :cond_2
    sget-boolean v0, Lcom/mrkeyboard/app/MrTour;->sBusy:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$400(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/os/Handler;

    move-result-object v0

    const-wide/16 v2, 0x190

    invoke-virtual {v0, p0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0
.end method
