.class Lcom/mrkeyboard/app/MrTourActivity$8;
.super Ljava/lang/Object;
.source "MrTourActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrTourActivity;->loopPulse(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrTourActivity;

.field final synthetic val$gen:I

.field final synthetic val$t0:J


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrTourActivity;IJ)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 685
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTourActivity$8;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    iput p2, p0, Lcom/mrkeyboard/app/MrTourActivity$8;->val$gen:I

    iput-wide p3, p0, Lcom/mrkeyboard/app/MrTourActivity$8;->val$t0:J

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 687
    iget v0, p0, Lcom/mrkeyboard/app/MrTourActivity$8;->val$gen:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$8;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$1600(Lcom/mrkeyboard/app/MrTourActivity;)I

    move-result v1

    if-eq v0, v1, :cond_0

    .line 697
    :goto_0
    return-void

    .line 688
    :cond_0
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/mrkeyboard/app/MrTourActivity$8;->val$t0:J

    sub-long/2addr v0, v2

    const-wide/16 v2, 0x12c

    cmp-long v0, v0, v2

    if-gez v0, :cond_1

    .line 689
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$8;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$1702(Lcom/mrkeyboard/app/MrTourActivity;Z)Z

    goto :goto_0

    .line 692
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$8;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$600(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/MrTourActivity$8$1;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrTourActivity$8$1;-><init>(Lcom/mrkeyboard/app/MrTourActivity$8;)V

    const-wide/16 v2, 0x15e

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0
.end method
