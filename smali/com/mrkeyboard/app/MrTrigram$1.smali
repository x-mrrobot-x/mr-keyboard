.class Lcom/mrkeyboard/app/MrTrigram$1;
.super Ljava/lang/Object;
.source "MrTrigram.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrTrigram;->use(Ljava/io/File;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$file:Ljava/io/File;

.field final synthetic val$gen:I

.field final synthetic val$path:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;ILjava/io/File;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 51
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTrigram$1;->val$path:Ljava/lang/String;

    iput p2, p0, Lcom/mrkeyboard/app/MrTrigram$1;->val$gen:I

    iput-object p3, p0, Lcom/mrkeyboard/app/MrTrigram$1;->val$file:Ljava/io/File;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 55
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTrigram$1;->val$path:Ljava/lang/String;

    iget v1, p0, Lcom/mrkeyboard/app/MrTrigram$1;->val$gen:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTrigram;->access$000(Ljava/lang/String;I)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 67
    :cond_0
    :goto_0
    return-void

    .line 56
    :cond_1
    const/4 v1, 0x0

    .line 58
    :try_start_0
    new-instance v0, Ljava/io/FileInputStream;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTrigram$1;->val$file:Ljava/io/File;

    invoke-direct {v0, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 59
    :try_start_1
    iget v1, p0, Lcom/mrkeyboard/app/MrTrigram$1;->val$gen:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTrigram;->access$100(Ljava/io/InputStream;I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 63
    if-eqz v0, :cond_0

    .line 64
    :try_start_2
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    goto :goto_0

    .line 60
    :catch_1
    move-exception v0

    move-object v0, v1

    .line 63
    :goto_1
    if-eqz v0, :cond_0

    .line 64
    :try_start_3
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_0

    :catch_2
    move-exception v0

    goto :goto_0

    .line 63
    :catchall_0
    move-exception v0

    :goto_2
    if-eqz v1, :cond_2

    .line 64
    :try_start_4
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    .line 66
    :cond_2
    :goto_3
    throw v0

    .line 64
    :catch_3
    move-exception v1

    goto :goto_3

    .line 63
    :catchall_1
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    goto :goto_2

    .line 60
    :catch_4
    move-exception v1

    goto :goto_1
.end method
