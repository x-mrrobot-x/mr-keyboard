.class Lcom/mrkeyboard/app/MrAiPrefs$9;
.super Ljava/lang/Object;
.source "MrAiPrefs.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAiPrefs;->test()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrAiPrefs;

.field final synthetic val$app:Landroid/content/Context;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAiPrefs;Landroid/content/Context;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 218
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAiPrefs$9;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrAiPrefs$9;->val$app:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    .prologue
    const/4 v7, 0x0

    .line 220
    const/4 v6, 0x0

    .line 222
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$9;->val$app:Landroid/content/Context;

    const-string v1, "Reply with only the word OK."

    const-string v2, "ping"

    const/4 v3, 0x0

    const-wide v4, 0x3fd3333333333333L    # 0.3

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrAi;->rewrite(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZD)Ljava/lang/String;
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    move-object v0, v6

    .line 229
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiPrefs$9;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAiPrefs;->access$700(Lcom/mrkeyboard/app/MrAiPrefs;)Landroid/os/Handler;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrAiPrefs$9$1;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrAiPrefs$9$1;-><init>(Lcom/mrkeyboard/app/MrAiPrefs$9;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 239
    return-void

    .line 223
    :catch_0
    move-exception v0

    .line 224
    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrAi$AiFail;->getMessage()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 225
    :catch_1
    move-exception v0

    .line 226
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$9;->val$app:Landroid/content/Context;

    const-string v1, "mr_ai_net_fail"

    new-array v2, v7, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method
