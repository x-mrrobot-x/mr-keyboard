.class Lcom/mrkeyboard/app/MrPacksActivity$17$1;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity$17;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrPacksActivity$17;

.field final synthetic val$fe:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity$17;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 656
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$17$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$17;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrPacksActivity$17$1;->val$fe:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 658
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$17$1;->val$fe:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 659
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$17$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$17;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$17;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$17$1;->val$fe:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1802(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 660
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$17$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$17;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$17;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    const-string v1, "gesture"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1902(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 661
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$17$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$17;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$17;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$17$1;->val$fe:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1200(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    .line 665
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$17$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$17;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$17;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$000(Lcom/mrkeyboard/app/MrPacksActivity;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$17$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$17;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$17;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1100(Lcom/mrkeyboard/app/MrPacksActivity;)V

    .line 666
    :cond_0
    return-void

    .line 663
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$17$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$17;

    iget-object v1, v0, Lcom/mrkeyboard/app/MrPacksActivity$17;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$17$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$17;

    iget-object v2, v0, Lcom/mrkeyboard/app/MrPacksActivity$17;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$17$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$17;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$17;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$2000(Lcom/mrkeyboard/app/MrPacksActivity;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "mr_gesture_installed_ok"

    :goto_1
    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v2, v0, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1200(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    const-string v0, "mr_gesture_installed_off"

    goto :goto_1
.end method
