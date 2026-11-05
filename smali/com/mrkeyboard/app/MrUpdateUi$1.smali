.class Lcom/mrkeyboard/app/MrUpdateUi$1;
.super Ljava/lang/Object;
.source "MrUpdateUi.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrUpdateUi;->check(Landroid/app/Activity;Landroid/preference/Preference;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$a:Landroid/app/Activity;

.field final synthetic val$app:Landroid/content/Context;

.field final synthetic val$row:Landroid/preference/Preference;


# direct methods
.method constructor <init>(Landroid/content/Context;Landroid/app/Activity;Landroid/preference/Preference;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 148
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateUi$1;->val$app:Landroid/content/Context;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrUpdateUi$1;->val$a:Landroid/app/Activity;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrUpdateUi$1;->val$row:Landroid/preference/Preference;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    const/4 v1, 0x3

    .line 152
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$1;->val$app:Landroid/content/Context;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdate;->check(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Result;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 159
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateUi$1;->val$a:Landroid/app/Activity;

    new-instance v2, Lcom/mrkeyboard/app/MrUpdateUi$1$1;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrUpdateUi$1$1;-><init>(Lcom/mrkeyboard/app/MrUpdateUi$1;Lcom/mrkeyboard/app/MrUpdate$Result;)V

    invoke-virtual {v1, v2}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 166
    return-void

    .line 153
    :catch_0
    move-exception v0

    .line 154
    new-instance v0, Lcom/mrkeyboard/app/MrUpdate$Result;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrUpdate$Result;-><init>()V

    .line 155
    iput v1, v0, Lcom/mrkeyboard/app/MrUpdate$Result;->status:I

    .line 156
    iput v1, v0, Lcom/mrkeyboard/app/MrUpdate$Result;->error:I

    goto :goto_0
.end method
