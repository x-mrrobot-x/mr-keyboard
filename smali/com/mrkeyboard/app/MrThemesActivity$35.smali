.class Lcom/mrkeyboard/app/MrThemesActivity$35;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->onActivityResult(IILandroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$uri:Landroid/net/Uri;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/net/Uri;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1378
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->val$uri:Landroid/net/Uri;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 1380
    .line 1383
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrThemesActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->val$uri:Landroid/net/Uri;

    invoke-virtual {v1, v2}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 1384
    if-eqz v2, :cond_1

    .line 1386
    :try_start_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrBackdrop;->importPending(Landroid/content/Context;Ljava/io/InputStream;)[I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v1

    .line 1388
    :try_start_2
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    .line 1391
    :goto_0
    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->loadPending(Landroid/content/Context;)Landroid/graphics/Bitmap;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    move-result-object v0

    .line 1397
    :cond_0
    :goto_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$35$1;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$35$1;-><init>(Lcom/mrkeyboard/app/MrThemesActivity$35;Landroid/graphics/Bitmap;)V

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 1402
    return-void

    .line 1388
    :catchall_0
    move-exception v1

    :try_start_3
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    .line 1389
    throw v1
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .line 1392
    :catch_0
    move-exception v1

    goto :goto_1

    :cond_1
    move-object v1, v0

    goto :goto_0
.end method
