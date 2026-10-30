.class Lcom/mrkeyboard/app/SheetEditorActivity$10;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->buildQuickTestCard(Z)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .registers 2

    .line 383
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 4

    .line 386
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$300(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    .line 388
    :try_start_9
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    const-string v0, "input_method"

    invoke-virtual {p1, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/inputmethod/InputMethodManager;

    .line 389
    if-eqz p1, :cond_21

    .line 390
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$300(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/EditText;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {p1, v0, v1}, Landroid/view/inputmethod/InputMethodManager;->showSoftInput(Landroid/view/View;I)Z
    :try_end_1f
    .catchall {:try_start_9 .. :try_end_1f} :catchall_20

    goto :goto_21

    .line 392
    :catchall_20
    move-exception p1

    :cond_21
    :goto_21
    nop

    .line 393
    return-void
.end method
