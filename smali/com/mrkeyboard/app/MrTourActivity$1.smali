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
    .line 119
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 121
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrTourActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$000(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/widget/LinearLayout;

    move-result-object v0

    if-nez v0, :cond_1

    .line 130
    :cond_0
    :goto_0
    return-void

    .line 122
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$100(Lcom/mrkeyboard/app/MrTourActivity;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 123
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$200(Lcom/mrkeyboard/app/MrTourActivity;)Ljava/lang/String;

    move-result-object v0

    .line 124
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$300(Lcom/mrkeyboard/app/MrTourActivity;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 125
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$302(Lcom/mrkeyboard/app/MrTourActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 126
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$400(Lcom/mrkeyboard/app/MrTourActivity;Z)V

    .line 129
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$500(Lcom/mrkeyboard/app/MrTourActivity;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$1;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$600(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/os/Handler;

    move-result-object v2

    sget-boolean v0, Lcom/mrkeyboard/app/MrTour;->sBusy:Z

    if-eqz v0, :cond_3

    const-wide/16 v0, 0x190

    :goto_1
    invoke-virtual {v2, p0, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0

    :cond_3
    const-wide/16 v0, 0x1f4

    goto :goto_1
.end method
