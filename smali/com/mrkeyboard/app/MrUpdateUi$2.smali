.class Lcom/mrkeyboard/app/MrUpdateUi$2;
.super Ljava/lang/Object;
.source "MrUpdateUi.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrUpdateUi;->onOpen(Landroid/app/Activity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$a:Landroid/app/Activity;

.field final synthetic val$app:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;Landroid/app/Activity;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 159
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$app:Landroid/content/Context;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$a:Landroid/app/Activity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 161
    const/4 v0, 0x0

    .line 163
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$app:Landroid/content/Context;

    const-wide/32 v2, 0x5265c00

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrUpdate;->checkIfOlder(Landroid/content/Context;J)Lcom/mrkeyboard/app/MrUpdate$Result;

    .line 164
    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$app:Landroid/content/Context;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrUpdate;->toShow(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Notice;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 169
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$a:Landroid/app/Activity;

    new-instance v2, Lcom/mrkeyboard/app/MrUpdateUi$2$1;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrUpdateUi$2$1;-><init>(Lcom/mrkeyboard/app/MrUpdateUi$2;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    invoke-virtual {v1, v2}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 176
    return-void

    .line 165
    :catch_0
    move-exception v1

    goto :goto_0
.end method
