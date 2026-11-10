.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$8$1;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;)V
    .locals 0

    .prologue
    .line 346
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPopupSaved(Ljava/lang/String;Ljava/util/ArrayList;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 348
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;

    iget-object v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1800(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v0

    iput-object p1, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    .line 349
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;

    iget-object v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1800(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v0

    iput-object p2, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    .line 350
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;

    iget-object v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1900(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    .line 351
    return-void
.end method
