.class Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/view/View$OnApplyWindowInsetsListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper;->attach(Landroid/view/View;Landroid/view/View;IIILjava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private mLastExtra:I

.field final synthetic val$basePadBottom:I

.field final synthetic val$onImeShown:Ljava/lang/Runnable;

.field final synthetic val$padH:I

.field final synthetic val$padTop:I

.field final synthetic val$paddedBody:Landroid/view/View;


# direct methods
.method constructor <init>(Landroid/view/View;IIILjava/lang/Runnable;)V
    .registers 6

    .line 908
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$paddedBody:Landroid/view/View;

    iput p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$padH:I

    iput p3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$padTop:I

    iput p4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$basePadBottom:I

    iput-object p5, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$onImeShown:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 909
    const/4 p1, 0x0

    iput p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->mLastExtra:I

    return-void
.end method


# virtual methods
.method public onApplyWindowInsets(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .registers 9

    .line 913
    invoke-static {}, Landroid/view/WindowInsets$Type;->ime()I

    move-result p1

    invoke-virtual {p2, p1}, Landroid/view/WindowInsets;->getInsets(I)Landroid/graphics/Insets;

    move-result-object p1

    .line 914
    invoke-static {}, Landroid/view/WindowInsets$Type;->systemBars()I

    move-result v0

    invoke-virtual {p2, v0}, Landroid/view/WindowInsets;->getInsets(I)Landroid/graphics/Insets;

    move-result-object v0

    .line 915
    iget p1, p1, Landroid/graphics/Insets;->bottom:I

    iget v0, v0, Landroid/graphics/Insets;->bottom:I

    sub-int/2addr p1, v0

    const/4 v0, 0x0

    invoke-static {v0, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    .line 916
    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->mLastExtra:I

    if-eq p1, v1, :cond_40

    .line 917
    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->mLastExtra:I

    if-le p1, v1, :cond_25

    if-lez p1, :cond_25

    const/4 v0, 0x1

    .line 918
    :cond_25
    iput p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->mLastExtra:I

    .line 919
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$paddedBody:Landroid/view/View;

    iget v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$padH:I

    iget v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$padTop:I

    iget v4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$padH:I

    iget v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$basePadBottom:I

    add-int/2addr v5, p1

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/view/View;->setPadding(IIII)V

    .line 920
    if-eqz v0, :cond_40

    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$onImeShown:Ljava/lang/Runnable;

    if-eqz p1, :cond_40

    .line 921
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;->val$onImeShown:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 924
    :cond_40
    return-object p2
.end method
