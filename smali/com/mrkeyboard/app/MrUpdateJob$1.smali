.class Lcom/mrkeyboard/app/MrUpdateJob$1;
.super Ljava/lang/Object;
.source "MrUpdateJob.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrUpdateJob;->onStartJob(Landroid/app/job/JobParameters;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrUpdateJob;

.field final synthetic val$app:Landroid/content/Context;

.field final synthetic val$params:Landroid/app/job/JobParameters;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrUpdateJob;Landroid/content/Context;Landroid/app/job/JobParameters;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 61
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateJob$1;->this$0:Lcom/mrkeyboard/app/MrUpdateJob;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrUpdateJob$1;->val$app:Landroid/content/Context;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrUpdateJob$1;->val$params:Landroid/app/job/JobParameters;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 63
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateJob$1;->val$app:Landroid/content/Context;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateJob;->run(Landroid/content/Context;)I

    .line 64
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateJob$1;->this$0:Lcom/mrkeyboard/app/MrUpdateJob;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrUpdateJob;->access$002(Lcom/mrkeyboard/app/MrUpdateJob;Z)Z

    .line 65
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateJob$1;->val$app:Landroid/content/Context;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->arm(Landroid/content/Context;)V

    .line 66
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateJob$1;->this$0:Lcom/mrkeyboard/app/MrUpdateJob;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateJob$1;->val$params:Landroid/app/job/JobParameters;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrUpdateJob;->jobFinished(Landroid/app/job/JobParameters;Z)V

    .line 67
    return-void
.end method
