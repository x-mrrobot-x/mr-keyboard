.class Lcom/mrkeyboard/app/SheetEditorActivity$11;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


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
    .line 354
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 356
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    .line 358
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    const-string v1, "input_method"

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodManager;

    .line 359
    if-eqz v0, :cond_0

    .line 360
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/EditText;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/view/inputmethod/InputMethodManager;->showSoftInput(Landroid/view/View;I)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 364
    :cond_0
    :goto_0
    return-void

    .line 362
    :catch_0
    move-exception v0

    goto :goto_0
.end method
