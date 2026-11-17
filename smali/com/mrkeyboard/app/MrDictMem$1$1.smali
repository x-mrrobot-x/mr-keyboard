.class Lcom/mrkeyboard/app/MrDictMem$1$1;
.super Ljava/lang/Object;
.source "MrDictMem.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrDictMem$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrDictMem$1;

.field final synthetic val$shown:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrDictMem$1;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 76
    iput-object p1, p0, Lcom/mrkeyboard/app/MrDictMem$1$1;->this$0:Lcom/mrkeyboard/app/MrDictMem$1;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrDictMem$1$1;->val$shown:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 78
    iget-object v0, p0, Lcom/mrkeyboard/app/MrDictMem$1$1;->this$0:Lcom/mrkeyboard/app/MrDictMem$1;

    iget v0, v0, Lcom/mrkeyboard/app/MrDictMem$1;->val$gen:I

    invoke-static {}, Lcom/mrkeyboard/app/MrDictMem;->access$000()I

    move-result v1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrDictMem$1$1;->this$0:Lcom/mrkeyboard/app/MrDictMem$1;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrDictMem$1;->val$owner:Landroid/preference/PreferenceActivity;

    invoke-virtual {v0}, Landroid/preference/PreferenceActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrDictMem$1$1;->this$0:Lcom/mrkeyboard/app/MrDictMem$1;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrDictMem$1;->val$owner:Landroid/preference/PreferenceActivity;

    invoke-virtual {v0}, Landroid/preference/PreferenceActivity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 85
    :cond_0
    :goto_0
    return-void

    .line 79
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrDictMem$1$1;->val$shown:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrDictMem;->access$102(Ljava/lang/String;)Ljava/lang/String;

    .line 81
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrDictMem$1$1;->this$0:Lcom/mrkeyboard/app/MrDictMem$1;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrDictMem$1;->val$row:Landroid/preference/Preference;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrDictMem$1$1;->this$0:Lcom/mrkeyboard/app/MrDictMem$1;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrDictMem$1;->val$owner:Landroid/preference/PreferenceActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPerf;->summary(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 82
    :catch_0
    move-exception v0

    goto :goto_0
.end method
