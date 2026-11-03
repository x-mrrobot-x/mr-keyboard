.class Lcom/mrkeyboard/app/MrAiPrefs$9$1;
.super Ljava/lang/Object;
.source "MrAiPrefs.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAiPrefs$9;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrAiPrefs$9;

.field final synthetic val$result:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAiPrefs$9;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 229
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAiPrefs$9$1;->this$1:Lcom/mrkeyboard/app/MrAiPrefs$9;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrAiPrefs$9$1;->val$result:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    .line 231
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$9$1;->this$1:Lcom/mrkeyboard/app/MrAiPrefs$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAiPrefs$9;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrAiPrefs;->access$402(Lcom/mrkeyboard/app/MrAiPrefs;Z)Z

    .line 232
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$9$1;->this$1:Lcom/mrkeyboard/app/MrAiPrefs$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAiPrefs$9;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrAiPrefs;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$9$1;->this$1:Lcom/mrkeyboard/app/MrAiPrefs$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAiPrefs$9;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrAiPrefs;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 237
    :cond_0
    :goto_0
    return-void

    .line 233
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$9$1;->this$1:Lcom/mrkeyboard/app/MrAiPrefs$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAiPrefs$9;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAiPrefs;->access$500(Lcom/mrkeyboard/app/MrAiPrefs;)Landroid/preference/Preference;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$9$1;->this$1:Lcom/mrkeyboard/app/MrAiPrefs$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAiPrefs$9;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAiPrefs;->access$500(Lcom/mrkeyboard/app/MrAiPrefs;)Landroid/preference/Preference;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiPrefs$9$1;->this$1:Lcom/mrkeyboard/app/MrAiPrefs$9;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrAiPrefs$9;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    const-string v2, "mr_ai_test_sum"

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrAiPrefs;->access$600(Lcom/mrkeyboard/app/MrAiPrefs;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 234
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$9$1;->val$result:Ljava/lang/String;

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$9$1;->this$1:Lcom/mrkeyboard/app/MrAiPrefs$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAiPrefs$9;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    const-string v1, "mr_ai_test_ok"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAiPrefs;->access$600(Lcom/mrkeyboard/app/MrAiPrefs;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 236
    :goto_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiPrefs$9$1;->this$1:Lcom/mrkeyboard/app/MrAiPrefs$9;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrAiPrefs$9;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-static {v1, v0, v5}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    goto :goto_0

    .line 235
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$9$1;->this$1:Lcom/mrkeyboard/app/MrAiPrefs$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAiPrefs$9;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    const-string v1, "mr_ai_test_fail"

    new-array v2, v5, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAiPrefs$9$1;->val$result:Ljava/lang/String;

    aput-object v3, v2, v4

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method
