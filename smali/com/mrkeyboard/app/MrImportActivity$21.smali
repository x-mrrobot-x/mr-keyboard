.class Lcom/mrkeyboard/app/MrImportActivity$21;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity;->prepareAi(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrImportActivity;

.field final synthetic val$text:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 709
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$21;->val$text:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 711
    .line 713
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$21;->val$text:Ljava/lang/String;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrImportAi;->plan(Ljava/lang/String;)Lcom/mrkeyboard/app/MrImportAi$Plan;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 720
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$21$1;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrImportActivity$21$1;-><init>(Lcom/mrkeyboard/app/MrImportActivity$21;Lcom/mrkeyboard/app/MrImportAi$Plan;)V

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrImportActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 729
    return-void

    .line 716
    :catch_0
    move-exception v1

    goto :goto_0

    .line 714
    :catch_1
    move-exception v1

    goto :goto_0
.end method
