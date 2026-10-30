.class Lcom/mrkeyboard/app/KeyEditDialog$8$1;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$8;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/KeyEditDialog$8;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$8;)V
    .registers 2

    .line 399
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$8$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$8;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPopupSaved(Ljava/lang/String;Ljava/util/ArrayList;)V
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList<",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            ">;)V"
        }
    .end annotation

    .line 402
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$8$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$8;

    iget-object v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$8;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object p1, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    .line 403
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$8$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$8;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$8;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object p2, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    .line 404
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$8$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$8;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$8;->val$updatePopupSummary:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 405
    return-void
.end method
