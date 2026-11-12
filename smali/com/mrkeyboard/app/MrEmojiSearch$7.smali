.class Lcom/mrkeyboard/app/MrEmojiSearch$7;
.super Ljava/lang/Object;
.source "MrEmojiSearch.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrEmojiSearch;->ensureLoaded()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$pkg:Ljava/lang/String;

.field final synthetic val$res:Landroid/content/res/Resources;


# direct methods
.method constructor <init>(Landroid/content/res/Resources;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 404
    iput-object p1, p0, Lcom/mrkeyboard/app/MrEmojiSearch$7;->val$res:Landroid/content/res/Resources;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrEmojiSearch$7;->val$pkg:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 406
    .line 408
    :try_start_0
    sget-object v1, Lcom/mrkeyboard/app/MrEmojiIndex;->LANGS:[Ljava/lang/String;

    array-length v1, v1

    new-array v3, v1, [Ljava/io/InputStream;

    .line 409
    const/4 v1, 0x0

    move v2, v1

    :goto_0
    array-length v1, v3

    if-ge v2, v1, :cond_1

    .line 410
    iget-object v1, p0, Lcom/mrkeyboard/app/MrEmojiSearch$7;->val$res:Landroid/content/res/Resources;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mr_emoji_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Lcom/mrkeyboard/app/MrEmojiIndex;->LANGS:[Ljava/lang/String;

    aget-object v5, v5, v2

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const-string v5, "raw"

    iget-object v6, p0, Lcom/mrkeyboard/app/MrEmojiSearch$7;->val$pkg:Ljava/lang/String;

    invoke-virtual {v1, v4, v5, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 411
    if-nez v1, :cond_0

    move-object v1, v0

    :goto_1
    aput-object v1, v3, v2

    .line 409
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_0

    .line 411
    :cond_0
    iget-object v4, p0, Lcom/mrkeyboard/app/MrEmojiSearch$7;->val$res:Landroid/content/res/Resources;

    invoke-virtual {v4, v1}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;

    move-result-object v1

    goto :goto_1

    .line 413
    :cond_1
    invoke-static {v3}, Lcom/mrkeyboard/app/MrEmojiIndex;->parse([Ljava/io/InputStream;)Lcom/mrkeyboard/app/MrEmojiIndex;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 420
    :goto_2
    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->access$100()Landroid/os/Handler;

    move-result-object v1

    if-eqz v1, :cond_2

    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->access$100()Landroid/os/Handler;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrEmojiSearch$7$1;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrEmojiSearch$7$1;-><init>(Lcom/mrkeyboard/app/MrEmojiSearch$7;Lcom/mrkeyboard/app/MrEmojiIndex;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 425
    :cond_2
    return-void

    .line 416
    :catch_0
    move-exception v1

    goto :goto_2

    .line 414
    :catch_1
    move-exception v1

    goto :goto_2
.end method
