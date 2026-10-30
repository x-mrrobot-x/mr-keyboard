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


# direct methods
.method constructor <init>(Ljava/io/File;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 45
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTrigram$1;->val$file:Ljava/io/File;

    iput p2, p0, Lcom/mrkeyboard/app/MrTrigram$1;->val$gen:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 47
    const/4 v1, 0x0

    .line 49
    :try_start_0
    new-instance v0, Ljava/io/FileInputStream;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTrigram$1;->val$file:Ljava/io/File;

    invoke-direct {v0, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 50
    :try_start_1
    iget v1, p0, Lcom/mrkeyboard/app/MrTrigram$1;->val$gen:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTrigram;->access$000(Ljava/io/InputStream;I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 54
    if-eqz v0, :cond_0

    .line 55
    :try_start_2
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    .line 58
    :cond_0
    :goto_0
    return-void

    .line 51
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 54
    :goto_1
    if-eqz v0, :cond_0

    .line 55
    :try_start_3
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_0

    .line 54
    :catchall_0
    move-exception v0

    :goto_2
    if-eqz v1, :cond_1

    .line 55
    :try_start_4
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    .line 57
    :cond_1
    :goto_3
    throw v0

    .line 55
    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v1

    goto :goto_3

    .line 54
    :catchall_1
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    goto :goto_2

    .line 51
    :catch_4
    move-exception v1

    goto :goto_1
.end method
