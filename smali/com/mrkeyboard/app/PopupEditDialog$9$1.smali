.class Lcom/mrkeyboard/app/PopupEditDialog$9$1;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"

# interfaces
.implements Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PopupEditDialog$9;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PopupEditDialog$9;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PopupEditDialog$9;)V
    .registers 2

    .line 362
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$9$1;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$9;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSaved(Lcom/mrkeyboard/app/SheetModel$KeySpec;)V
    .registers 3

    .line 365
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$9$1;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/PopupEditDialog$9;->val$workingKeys:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 366
    iget-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$9$1;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$9;

    iget-object p1, p1, Lcom/mrkeyboard/app/PopupEditDialog$9;->val$refreshRef:[Ljava/lang/Runnable;

    const/4 v0, 0x0

    aget-object p1, p1, v0

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 367
    return-void
.end method
