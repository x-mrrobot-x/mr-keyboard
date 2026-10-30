.class Lcom/mrkeyboard/app/SheetEditorActivity$13;
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

    .line 432
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$13;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 3

    .line 435
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$13;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$300(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/EditText;

    move-result-object p1

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 436
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$13;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$300(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    .line 437
    return-void
.end method
