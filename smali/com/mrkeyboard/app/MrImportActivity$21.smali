.class Lcom/mrkeyboard/app/MrImportActivity$21;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity;->apply()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrImportActivity;

.field final synthetic val$app:Ljava/lang/String;

.field final synthetic val$locale:Ljava/lang/String;

.field final synthetic val$plan:Lcom/mrkeyboard/app/MrImport$Plan;

.field final synthetic val$store:Lcom/mrkeyboard/app/MrWordStore;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrWordStore;Lcom/mrkeyboard/app/MrImport$Plan;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 691
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$21;->val$store:Lcom/mrkeyboard/app/MrWordStore;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrImportActivity$21;->val$plan:Lcom/mrkeyboard/app/MrImport$Plan;

    iput-object p4, p0, Lcom/mrkeyboard/app/MrImportActivity$21;->val$locale:Ljava/lang/String;

    iput-object p5, p0, Lcom/mrkeyboard/app/MrImportActivity$21;->val$app:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    .line 693
    .line 695
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$21;->val$store:Lcom/mrkeyboard/app/MrWordStore;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$21;->val$plan:Lcom/mrkeyboard/app/MrImport$Plan;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity$21;->val$locale:Ljava/lang/String;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity$21;->val$app:Ljava/lang/String;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrLearned;->apply(Lcom/mrkeyboard/app/MrWordStore;Lcom/mrkeyboard/app/MrImport$Plan;Ljava/lang/String;Ljava/lang/String;J)Lcom/mrkeyboard/app/MrLearned$Result;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 700
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$21;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$21$1;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrImportActivity$21$1;-><init>(Lcom/mrkeyboard/app/MrImportActivity$21;Lcom/mrkeyboard/app/MrLearned$Result;)V

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrImportActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 720
    return-void

    .line 696
    :catch_0
    move-exception v0

    .line 697
    const/4 v0, 0x0

    goto :goto_0
.end method
