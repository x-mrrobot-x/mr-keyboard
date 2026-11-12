.class Lcom/mrkeyboard/app/MrPacksActivity$6$1;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity$6;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrPacksActivity$6;

.field final synthetic val$fc:Lcom/mrkeyboard/app/MrPacks$Catalog;

.field final synthetic val$fe:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity$6;Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Catalog;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 365
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$6;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->val$fe:Ljava/lang/String;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->val$fc:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 367
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$6;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$6;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$702(Lcom/mrkeyboard/app/MrPacksActivity;Z)Z

    .line 368
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$6;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$6;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->val$fe:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$802(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 369
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->val$fc:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$6;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$6;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->val$fc:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$902(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Catalog;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    .line 370
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$6;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$6;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1000(Lcom/mrkeyboard/app/MrPacksActivity;)Ljava/lang/String;

    move-result-object v0

    .line 371
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$6;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrPacksActivity$6;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    const/4 v2, 0x0

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1002(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 372
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$6;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrPacksActivity$6;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$000(Lcom/mrkeyboard/app/MrPacksActivity;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 379
    :cond_1
    :goto_0
    return-void

    .line 373
    :cond_2
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$6;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrPacksActivity$6;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1100(Lcom/mrkeyboard/app/MrPacksActivity;)V

    .line 374
    if-eqz v0, :cond_1

    .line 375
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->val$fe:Ljava/lang/String;

    if-eqz v1, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$6;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$6;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->val$fe:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1200(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    goto :goto_0

    .line 376
    :cond_3
    const-string v1, "gesture"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$6;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$6;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1300(Lcom/mrkeyboard/app/MrPacksActivity;)V

    goto :goto_0

    .line 377
    :cond_4
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$6$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$6;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrPacksActivity$6;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1400(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    goto :goto_0
.end method
