.class Lcom/mrkeyboard/app/MrPacksActivity$11$1;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity$11;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

.field final synthetic val$fe:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity$11;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 462
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->val$fe:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 464
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->val$fe:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 465
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$11;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->val$fe:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1802(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 466
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$11;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrPacksActivity$11;->val$p:Lcom/mrkeyboard/app/MrPacks$Pack;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1902(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 467
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$11;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->val$fe:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1200(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    .line 482
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$11;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$000(Lcom/mrkeyboard/app/MrPacksActivity;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$11;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1100(Lcom/mrkeyboard/app/MrPacksActivity;)V

    .line 483
    :cond_0
    return-void

    .line 468
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$11;->val$p:Lcom/mrkeyboard/app/MrPacks$Pack;

    iget-boolean v0, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->model:Z

    if-eqz v0, :cond_3

    .line 471
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

    iget-object v1, v0, Lcom/mrkeyboard/app/MrPacksActivity$11;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

    iget-object v2, v0, Lcom/mrkeyboard/app/MrPacksActivity$11;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$11;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$2000(Lcom/mrkeyboard/app/MrPacksActivity;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "mr_gesture_installed_ok"

    :goto_1
    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v2, v0, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1200(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    const-string v0, "mr_gesture_installed_off"

    goto :goto_1

    .line 473
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$11;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    const-string v1, "show_suggestions"

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 474
    instance-of v1, v0, Landroid/preference/CheckBoxPreference;

    if-eqz v1, :cond_4

    .line 475
    check-cast v0, Landroid/preference/CheckBoxPreference;

    invoke-virtual {v0, v2}, Landroid/preference/CheckBoxPreference;->setChecked(Z)V

    .line 480
    :goto_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$11;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrPacksActivity$11;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    const-string v2, "mr_dicts_installed_ok"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1200(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    goto :goto_0

    .line 477
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$11$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$11;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$11;->val$app:Landroid/content/Context;

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "show_suggestions"

    .line 478
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    goto :goto_2
.end method
