.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$1$1;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$Editor$1;->onShow(Landroid/content/DialogInterface;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$1;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor$1;)V
    .locals 0

    .prologue
    .line 180
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$1$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 182
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$1$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$1;

    iget-object v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$000(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    .line 183
    return-void
.end method
