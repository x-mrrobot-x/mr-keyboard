.class Lcom/mrkeyboard/app/PopupEditDialog$5$3$1;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"

# interfaces
.implements Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PopupEditDialog$5$3;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/PopupEditDialog$5$3;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PopupEditDialog$5$3;)V
    .registers 2

    .line 311
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$3$1;->this$1:Lcom/mrkeyboard/app/PopupEditDialog$5$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSaved(Lcom/mrkeyboard/app/SheetModel$KeySpec;)V
    .registers 4

    .line 314
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$3$1;->this$1:Lcom/mrkeyboard/app/PopupEditDialog$5$3;

    iget-object v0, v0, Lcom/mrkeyboard/app/PopupEditDialog$5$3;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$5;

    iget-object v0, v0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$workingKeys:Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$3$1;->this$1:Lcom/mrkeyboard/app/PopupEditDialog$5$3;

    iget v1, v1, Lcom/mrkeyboard/app/PopupEditDialog$5$3;->val$idx:I

    invoke-virtual {v0, v1, p1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 315
    iget-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$3$1;->this$1:Lcom/mrkeyboard/app/PopupEditDialog$5$3;

    iget-object p1, p1, Lcom/mrkeyboard/app/PopupEditDialog$5$3;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$5;

    iget-object p1, p1, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$refreshRef:[Ljava/lang/Runnable;

    const/4 v0, 0x0

    aget-object p1, p1, v0

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 316
    return-void
.end method
