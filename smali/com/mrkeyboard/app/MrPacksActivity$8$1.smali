.class Lcom/mrkeyboard/app/MrPacksActivity$8$1;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity$8;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrPacksActivity$8;

.field final synthetic val$fe:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity$8;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 307
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$8;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->val$fe:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 309
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->val$fe:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 310
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$8;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$8;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->val$fe:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1102(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 311
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$8;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$8;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$8;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrPacksActivity$8;->val$p:Lcom/mrkeyboard/app/MrPacks$Pack;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1202(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 312
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$8;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$8;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->val$fe:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1300(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    .line 319
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$8;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$8;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$000(Lcom/mrkeyboard/app/MrPacksActivity;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$8;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$8;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$800(Lcom/mrkeyboard/app/MrPacksActivity;)V

    .line 320
    :cond_0
    return-void

    .line 313
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$8;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$8;->val$app:Landroid/content/Context;

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "show_suggestions"

    .line 314
    invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_2

    .line 315
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$8;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$8;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$8;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrPacksActivity$8;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    const-string v2, "mr_dicts_installed_turn_on"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1300(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    goto :goto_0

    .line 317
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$8;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$8;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$8$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$8;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrPacksActivity$8;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    const-string v2, "mr_dicts_installed_ok"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1300(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    goto :goto_0
.end method
