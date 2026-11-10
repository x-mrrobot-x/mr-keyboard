.class Lcom/mrkeyboard/app/SheetEditorActivity$13;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->bindTestCard(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 381
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$13;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 2

    .prologue
    .line 387
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$13;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2100(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/view/View;

    move-result-object v1

    if-eqz p1, :cond_0

    invoke-interface {p1}, Landroid/text/Editable;->length()I

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    const/16 v0, 0x8

    :goto_0
    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    .line 388
    return-void

    .line 387
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 382
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 384
    return-void
.end method
