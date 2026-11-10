.class Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/view/View$OnApplyWindowInsetsListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper;->attach(Landroid/view/View;Landroid/view/View;IIIILjava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private mLastExtra:I

.field final synthetic val$content:Landroid/view/View;

.field final synthetic val$onKeyboardShown:Ljava/lang/Runnable;

.field final synthetic val$padBottom:I

.field final synthetic val$padLeft:I

.field final synthetic val$padRight:I

.field final synthetic val$padTop:I


# direct methods
.method constructor <init>(Landroid/view/View;IIIILjava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 682
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$content:Landroid/view/View;

    iput p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$padLeft:I

    iput p3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$padTop:I

    iput p4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$padRight:I

    iput p5, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$padBottom:I

    iput-object p6, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$onKeyboardShown:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onApplyWindowInsets(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 686
    invoke-static {}, Landroid/view/WindowInsets$Type;->ime()I

    move-result v1

    invoke-virtual {p2, v1}, Landroid/view/WindowInsets;->getInsets(I)Landroid/graphics/Insets;

    move-result-object v1

    iget v1, v1, Landroid/graphics/Insets;->bottom:I

    .line 687
    invoke-static {}, Landroid/view/WindowInsets$Type;->systemBars()I

    move-result v2

    invoke-virtual {p2, v2}, Landroid/view/WindowInsets;->getInsets(I)Landroid/graphics/Insets;

    move-result-object v2

    iget v2, v2, Landroid/graphics/Insets;->bottom:I

    sub-int/2addr v1, v2

    .line 688
    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 689
    iget v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->mLastExtra:I

    if-eq v1, v2, :cond_1

    .line 690
    iget v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->mLastExtra:I

    if-le v1, v2, :cond_0

    if-lez v1, :cond_0

    const/4 v0, 0x1

    .line 691
    :cond_0
    iput v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->mLastExtra:I

    .line 692
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$content:Landroid/view/View;

    iget v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$padLeft:I

    iget v4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$padTop:I

    iget v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$padRight:I

    iget v6, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$padBottom:I

    add-int/2addr v1, v6

    invoke-virtual {v2, v3, v4, v5, v1}, Landroid/view/View;->setPadding(IIII)V

    .line 693
    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$onKeyboardShown:Ljava/lang/Runnable;

    if-eqz v0, :cond_1

    .line 694
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$onKeyboardShown:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 697
    :cond_1
    return-object p2
.end method
