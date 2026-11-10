.class Lcom/mrkeyboard/app/PopupEditDialog$4;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PopupEditDialog;->buildPopupItemRow(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;IILjava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$onDelete:Ljava/lang/Runnable;


# direct methods
.method constructor <init>(Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 104
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$4;->val$onDelete:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 106
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$4;->val$onDelete:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 107
    return-void
.end method
