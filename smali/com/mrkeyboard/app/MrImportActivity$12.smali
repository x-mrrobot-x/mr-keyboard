.class Lcom/mrkeyboard/app/MrImportActivity$12;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity;->onActivityResult(IILandroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrImportActivity;

.field final synthetic val$uri:Landroid/net/Uri;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;Landroid/net/Uri;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 321
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$12;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$12;->val$uri:Landroid/net/Uri;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    .prologue
    const/high16 v7, 0x800000

    const/4 v2, 0x0

    const/4 v0, 0x0

    .line 323
    .line 326
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$12;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrImportActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity$12;->val$uri:Landroid/net/Uri;

    invoke-virtual {v1, v3}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    .line 327
    if-eqz v3, :cond_2

    .line 329
    :try_start_1
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 330
    const/16 v4, 0x4000

    new-array v4, v4, [B

    .line 332
    :goto_0
    invoke-virtual {v3, v4}, Ljava/io/InputStream;->read([B)I

    move-result v5

    if-lez v5, :cond_0

    .line 333
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v6

    add-int/2addr v6, v5

    if-le v6, v7, :cond_1

    .line 334
    const/4 v5, 0x0

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v6

    sub-int v6, v7, v6

    invoke-virtual {v1, v4, v5, v6}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 335
    const/4 v0, 0x1

    .line 340
    :cond_0
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrImport;->decode([BZ)Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v1

    .line 342
    :try_start_2
    invoke-virtual {v3}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_3
    .catch Ljava/lang/OutOfMemoryError; {:try_start_2 .. :try_end_2} :catch_1

    :goto_1
    move-object v2, v1

    .line 352
    :goto_2
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$12;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    new-instance v3, Lcom/mrkeyboard/app/MrImportActivity$12$1;

    invoke-direct {v3, p0, v2, v0}, Lcom/mrkeyboard/app/MrImportActivity$12$1;-><init>(Lcom/mrkeyboard/app/MrImportActivity$12;Ljava/lang/String;Z)V

    invoke-virtual {v1, v3}, Lcom/mrkeyboard/app/MrImportActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 368
    return-void

    .line 338
    :cond_1
    const/4 v6, 0x0

    :try_start_3
    invoke-virtual {v1, v4, v6, v5}, Ljava/io/ByteArrayOutputStream;->write([BII)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    .line 342
    :catchall_0
    move-exception v1

    move-object v8, v1

    move v1, v0

    move-object v0, v8

    :try_start_4
    invoke-virtual {v3}, Ljava/io/InputStream;->close()V

    .line 343
    throw v0
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_4 .. :try_end_4} :catch_2

    .line 345
    :catch_0
    move-exception v0

    move v0, v1

    goto :goto_2

    .line 347
    :catch_1
    move-exception v1

    goto :goto_2

    :catch_2
    move-exception v0

    move v0, v1

    goto :goto_2

    .line 345
    :catch_3
    move-exception v1

    goto :goto_2

    :cond_2
    move-object v1, v2

    goto :goto_1
.end method
