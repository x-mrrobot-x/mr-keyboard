.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindPopup()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V
    .locals 0

    .prologue
    .line 343
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 5

    .prologue
    .line 345
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1100(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1700(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Ljava/util/List;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1800(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v2

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v3}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1800(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v3

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    new-instance v4, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8$1;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8$1;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;)V

    invoke-static {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/PopupEditDialog;->show(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;)V

    .line 353
    return-void
.end method
