.class Lcom/mrkeyboard/app/MrPacksActivity$10;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity;->confirmRemove(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrPacksActivity;

.field final synthetic val$id:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 449
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$10;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrPacksActivity$10;->val$id:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 4

    .prologue
    const/4 v2, 0x0

    .line 451
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$10;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$10;->val$id:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacks;->remove(Landroid/content/Context;Ljava/lang/String;)V

    .line 452
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$10;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1602(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 453
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$10;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1702(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 454
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$10;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$10;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    const-string v2, "mr_dicts_removed_ok"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1200(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    .line 455
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$10;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1100(Lcom/mrkeyboard/app/MrPacksActivity;)V

    .line 456
    return-void
.end method
