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

.field final synthetic val$asking:Z

.field final synthetic val$look:Z


# direct methods
.method constructor <init>(Landroid/content/Context;ZLandroid/app/Activity;Z)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 273
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$app:Landroid/content/Context;

    iput-boolean p2, p0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$look:Z

    iput-object p3, p0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$a:Landroid/app/Activity;

    iput-boolean p4, p0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$asking:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 275
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$app:Landroid/content/Context;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateInstall;->cleanup(Landroid/content/Context;)V

    .line 276
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$app:Landroid/content/Context;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->sync(Landroid/content/Context;)V

    .line 277
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$look:Z

    if-nez v0, :cond_0

    .line 294
    :goto_0
    return-void

    .line 278
    :cond_0
    const/4 v0, 0x0

    .line 280
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$app:Landroid/content/Context;

    const-wide/32 v2, 0x5265c00

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrUpdate;->checkIfOlder(Landroid/content/Context;J)Lcom/mrkeyboard/app/MrUpdate$Result;

    .line 281
    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$app:Landroid/content/Context;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrUpdate;->toShow(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Notice;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 286
    :goto_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateUi$2;->val$a:Landroid/app/Activity;

    new-instance v2, Lcom/mrkeyboard/app/MrUpdateUi$2$1;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrUpdateUi$2$1;-><init>(Lcom/mrkeyboard/app/MrUpdateUi$2;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    invoke-virtual {v1, v2}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    goto :goto_0

    .line 282
    :catch_0
    move-exception v1

    goto :goto_1
.end method
