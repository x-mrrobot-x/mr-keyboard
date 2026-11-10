.class Lcom/mrkeyboard/app/MrImportActivity$12;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity;->analyze()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrImportActivity;

.field final synthetic val$locale:Ljava/lang/String;

.field final synthetic val$standard:Z

.field final synthetic val$text:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;ZLjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 415
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$12;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$12;->val$locale:Ljava/lang/String;

    iput-boolean p3, p0, Lcom/mrkeyboard/app/MrImportActivity$12;->val$standard:Z

    iput-object p4, p0, Lcom/mrkeyboard/app/MrImportActivity$12;->val$text:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 417
    .line 418
    const/4 v0, 0x0

    .line 419
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity$12;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity$12;->val$locale:Ljava/lang/String;

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrPacks;->openDictionary(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v3

    .line 421
    if-nez v3, :cond_1

    :try_start_0
    iget-boolean v2, p0, Lcom/mrkeyboard/app/MrImportActivity$12;->val$standard:Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v2, :cond_1

    .line 422
    const/4 v0, 0x1

    .line 441
    :goto_0
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Lcom/mrkeyboard/app/BinaryDictionary;->close()V

    .line 445
    :cond_0
    :goto_1
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity$12;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    new-instance v3, Lcom/mrkeyboard/app/MrImportActivity$12$3;

    invoke-direct {v3, p0, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity$12$3;-><init>(Lcom/mrkeyboard/app/MrImportActivity$12;ZLcom/mrkeyboard/app/MrImport$Plan;)V

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrImportActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 459
    return-void

    .line 424
    :cond_1
    :try_start_1
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity$12;->val$text:Ljava/lang/String;

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$12$1;

    invoke-direct {v4, p0, v3}, Lcom/mrkeyboard/app/MrImportActivity$12$1;-><init>(Lcom/mrkeyboard/app/MrImportActivity$12;Lcom/mrkeyboard/app/BinaryDictionary;)V

    invoke-static {v2, v4}, Lcom/mrkeyboard/app/MrImport;->parse(Ljava/lang/String;Lcom/mrkeyboard/app/MrImport$Known;)Lcom/mrkeyboard/app/MrImport$Plan;

    move-result-object v2

    .line 430
    iget-object v4, v2, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    new-instance v5, Lcom/mrkeyboard/app/MrImportActivity$12$2;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrImportActivity$12$2;-><init>(Lcom/mrkeyboard/app/MrImportActivity$12;)V

    invoke-static {v4, v5}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-object v1, v2

    goto :goto_0

    .line 436
    :catch_0
    move-exception v2

    .line 441
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Lcom/mrkeyboard/app/BinaryDictionary;->close()V

    goto :goto_1

    .line 438
    :catch_1
    move-exception v2

    .line 441
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Lcom/mrkeyboard/app/BinaryDictionary;->close()V

    goto :goto_1

    :catchall_0
    move-exception v0

    if-eqz v3, :cond_2

    invoke-virtual {v3}, Lcom/mrkeyboard/app/BinaryDictionary;->close()V

    .line 442
    :cond_2
    throw v0
.end method
