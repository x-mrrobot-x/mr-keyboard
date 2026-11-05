.class Lcom/mrkeyboard/app/MrLearnedActivity$15;
.super Ljava/lang/Object;
.source "MrLearnedActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrLearnedActivity;->onActivityResult(IILandroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

.field final synthetic val$locale:Ljava/lang/String;

.field final synthetic val$store:Lcom/mrkeyboard/app/MrWordStore;

.field final synthetic val$uri:Landroid/net/Uri;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrLearnedActivity;Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;Landroid/net/Uri;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 511
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$15;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrLearnedActivity$15;->val$store:Lcom/mrkeyboard/app/MrWordStore;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrLearnedActivity$15;->val$locale:Ljava/lang/String;

    iput-object p4, p0, Lcom/mrkeyboard/app/MrLearnedActivity$15;->val$uri:Landroid/net/Uri;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 513
    .line 515
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$15;->val$store:Lcom/mrkeyboard/app/MrWordStore;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity$15;->val$locale:Ljava/lang/String;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrLearned;->export(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "UTF-8"

    invoke-virtual {v0, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    .line 516
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity$15;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrLearnedActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity$15;->val$uri:Landroid/net/Uri;

    const-string v4, "wt"

    invoke-virtual {v2, v3, v4}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;Ljava/lang/String;)Ljava/io/OutputStream;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 517
    if-eqz v2, :cond_0

    .line 519
    :try_start_1
    invoke-virtual {v2, v0}, Ljava/io/OutputStream;->write([B)V

    .line 520
    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 521
    const/4 v0, 0x1

    .line 523
    :try_start_2
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 530
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$15;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    new-instance v2, Lcom/mrkeyboard/app/MrLearnedActivity$15$1;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrLearnedActivity$15$1;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity$15;Z)V

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrLearnedActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 535
    return-void

    .line 523
    :catchall_0
    move-exception v0

    :try_start_3
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V

    .line 524
    throw v0
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .line 526
    :catch_0
    move-exception v0

    move v0, v1

    .line 527
    goto :goto_0

    :cond_0
    move v0, v1

    goto :goto_0
.end method
