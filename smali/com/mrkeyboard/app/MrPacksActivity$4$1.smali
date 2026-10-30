.class Lcom/mrkeyboard/app/MrPacksActivity$4$1;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity$4;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrPacksActivity$4;

.field final synthetic val$fc:Lcom/mrkeyboard/app/MrPacks$Catalog;

.field final synthetic val$fe:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity$4;Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Catalog;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 227
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$4;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->val$fe:Ljava/lang/String;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->val$fc:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 229
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$4;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$4;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$502(Lcom/mrkeyboard/app/MrPacksActivity;Z)Z

    .line 230
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$4;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$4;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->val$fe:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$602(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 231
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->val$fc:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$4;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$4;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->val$fc:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$702(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Catalog;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    .line 232
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$4;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$4;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$000(Lcom/mrkeyboard/app/MrPacksActivity;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$4;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$4;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$800(Lcom/mrkeyboard/app/MrPacksActivity;)V

    .line 233
    :cond_1
    return-void
.end method
