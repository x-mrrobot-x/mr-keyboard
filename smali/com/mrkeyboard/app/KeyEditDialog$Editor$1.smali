.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$1;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnShowListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$Editor;->show()V
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
    .line 178
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onShow(Landroid/content/DialogInterface;)V
    .locals 2

    .prologue
    .line 180
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$100(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/app/AlertDialog;

    move-result-object v0

    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$1$1;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$1$1;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor$1;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 185
    return-void
.end method
