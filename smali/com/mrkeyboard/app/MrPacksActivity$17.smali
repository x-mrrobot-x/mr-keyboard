.class Lcom/mrkeyboard/app/MrPacksActivity$17;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity;->onActivityResult(IILandroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrPacksActivity;

.field final synthetic val$app:Landroid/content/Context;

.field final synthetic val$uri:Landroid/net/Uri;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity;Landroid/content/Context;Landroid/net/Uri;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 638
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$17;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrPacksActivity$17;->val$app:Landroid/content/Context;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrPacksActivity$17;->val$uri:Landroid/net/Uri;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    .prologue
    const/4 v7, 0x0

    const/4 v0, 0x0

    .line 640
    .line 643
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$17;->val$app:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity$17;->val$uri:Landroid/net/Uri;

    invoke-virtual {v1, v2}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v2

    .line 644
    if-nez v2, :cond_0

    :try_start_1
    new-instance v1, Ljava/io/IOException;

    const-string v3, "no stream"

    invoke-direct {v1, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_1
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 646
    :catch_0
    move-exception v1

    .line 647
    :goto_0
    :try_start_2
    iget-object v3, p0, Lcom/mrkeyboard/app/MrPacksActivity$17;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-virtual {v3, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->msg(Lcom/mrkeyboard/app/MrPacks$PackException;)Ljava/lang/String;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-result-object v1

    .line 651
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 652
    sput-boolean v7, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 653
    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    move-object v0, v1

    .line 656
    :goto_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$17;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$200(Lcom/mrkeyboard/app/MrPacksActivity;)Landroid/os/Handler;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$17$1;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity$17$1;-><init>(Lcom/mrkeyboard/app/MrPacksActivity$17;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 668
    return-void

    .line 645
    :cond_0
    :try_start_3
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$17;->val$app:Landroid/content/Context;

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrPacks;->installModelFile(Landroid/content/Context;Ljava/io/InputStream;)V
    :try_end_3
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 651
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 652
    sput-boolean v7, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 653
    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    goto :goto_1

    .line 648
    :catch_1
    move-exception v1

    move-object v2, v0

    .line 649
    :goto_2
    :try_start_4
    iget-object v3, p0, Lcom/mrkeyboard/app/MrPacksActivity$17;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    const-string v4, "mr_gesture_err_io"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v5, v6

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    move-result-object v1

    .line 651
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 652
    sput-boolean v7, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 653
    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    move-object v0, v1

    .line 654
    goto :goto_1

    .line 651
    :catchall_0
    move-exception v1

    move-object v2, v0

    :goto_3
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 652
    sput-boolean v7, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 653
    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 654
    throw v1

    .line 651
    :catchall_1
    move-exception v1

    goto :goto_3

    .line 648
    :catch_2
    move-exception v1

    goto :goto_2

    .line 646
    :catch_3
    move-exception v1

    move-object v2, v0

    goto :goto_0
.end method
