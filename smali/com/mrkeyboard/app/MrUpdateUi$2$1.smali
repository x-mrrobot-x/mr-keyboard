.class Lcom/mrkeyboard/app/MrUpdateUi$2$1;
.super Ljava/lang/Object;
.source "MrUpdateUi.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrUpdateUi$2;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrUpdateUi$2;

.field final synthetic val$notice:Lcom/mrkeyboard/app/MrUpdate$Notice;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrUpdateUi$2;Lcom/mrkeyboard/app/MrUpdate$Notice;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 286
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateUi$2$1;->this$0:Lcom/mrkeyboard/app/MrUpdateUi$2;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrUpdateUi$2$1;->val$notice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 288
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$2$1;->this$0:Lcom/mrkeyboard/app/MrUpdateUi$2;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$a:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$2$1;->this$0:Lcom/mrkeyboard/app/MrUpdateUi$2;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$a:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 292
    :cond_0
    :goto_0
    return-void

    .line 289
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$2$1;->this$0:Lcom/mrkeyboard/app/MrUpdateUi$2;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$a:Landroid/app/Activity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateUi;->access$400(Landroid/app/Activity;)V

    .line 290
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$2$1;->this$0:Lcom/mrkeyboard/app/MrUpdateUi$2;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$a:Landroid/app/Activity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateUi;->access$300(Landroid/app/Activity;)V

    .line 291
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$2$1;->val$notice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$2$1;->this$0:Lcom/mrkeyboard/app/MrUpdateUi$2;

    iget-boolean v0, v0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$asking:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$2$1;->this$0:Lcom/mrkeyboard/app/MrUpdateUi$2;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$a:Landroid/app/Activity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateUi$2$1;->val$notice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrUpdateDialog;->show(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    goto :goto_0
.end method
