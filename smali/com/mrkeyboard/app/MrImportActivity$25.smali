.class Lcom/mrkeyboard/app/MrImportActivity$25;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrImportAi$Control;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity;->runAi(Lcom/mrkeyboard/app/MrImportAi$Plan;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrImportActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 775
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$25;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public cancelled()Z
    .locals 1

    .prologue
    .line 778
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$25;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$900(Lcom/mrkeyboard/app/MrImportActivity;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$25;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImportActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public progress(II)V
    .locals 2

    .prologue
    .line 782
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$25;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    new-instance v1, Lcom/mrkeyboard/app/MrImportActivity$25$1;

    invoke-direct {v1, p0, p1, p2}, Lcom/mrkeyboard/app/MrImportActivity$25$1;-><init>(Lcom/mrkeyboard/app/MrImportActivity$25;II)V

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 787
    return-void
.end method
