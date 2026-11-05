.class Lcom/mrkeyboard/app/MrUpdateUi$1$1;
.super Ljava/lang/Object;
.source "MrUpdateUi.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrUpdateUi$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrUpdateUi$1;

.field final synthetic val$result:Lcom/mrkeyboard/app/MrUpdate$Result;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrUpdateUi$1;Lcom/mrkeyboard/app/MrUpdate$Result;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 159
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateUi$1$1;->this$0:Lcom/mrkeyboard/app/MrUpdateUi$1;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrUpdateUi$1$1;->val$result:Lcom/mrkeyboard/app/MrUpdate$Result;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 161
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateUi;->access$002(Z)Z

    .line 162
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$1$1;->this$0:Lcom/mrkeyboard/app/MrUpdateUi$1;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrUpdateUi$1;->val$a:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$1$1;->this$0:Lcom/mrkeyboard/app/MrUpdateUi$1;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrUpdateUi$1;->val$a:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 164
    :cond_0
    :goto_0
    return-void

    .line 163
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$1$1;->this$0:Lcom/mrkeyboard/app/MrUpdateUi$1;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrUpdateUi$1;->val$a:Landroid/app/Activity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateUi$1$1;->this$0:Lcom/mrkeyboard/app/MrUpdateUi$1;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrUpdateUi$1;->val$row:Landroid/preference/Preference;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrUpdateUi$1$1;->val$result:Lcom/mrkeyboard/app/MrUpdate$Result;

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrUpdateUi;->access$100(Landroid/app/Activity;Landroid/preference/Preference;Lcom/mrkeyboard/app/MrUpdate$Result;)V

    goto :goto_0
.end method
