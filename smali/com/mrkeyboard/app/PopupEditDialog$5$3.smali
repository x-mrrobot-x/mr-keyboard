.class Lcom/mrkeyboard/app/PopupEditDialog$5$3;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PopupEditDialog$5;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PopupEditDialog$5;

.field final synthetic val$idx:I

.field final synthetic val$item:Lcom/mrkeyboard/app/SheetModel$KeySpec;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PopupEditDialog$5;Lcom/mrkeyboard/app/SheetModel$KeySpec;I)V
    .registers 4

    .line 308
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$3;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$5;

    iput-object p2, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$3;->val$item:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput p3, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$3;->val$idx:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 5

    .line 311
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$3;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$5;

    iget-object v0, v0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$ctx:Landroid/content/Context;

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$3;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$5;

    iget-object v1, v1, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$allSheets:Ljava/util/List;

    iget-object v2, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$3;->val$item:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    new-instance v3, Lcom/mrkeyboard/app/PopupEditDialog$5$3$1;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/PopupEditDialog$5$3$1;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$5$3;)V

    # invokes: Lcom/mrkeyboard/app/PopupEditDialog;->showSinglePopupItemEditor(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;)V
    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/PopupEditDialog;->access$100(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;)V

    .line 318
    return-void
.end method
