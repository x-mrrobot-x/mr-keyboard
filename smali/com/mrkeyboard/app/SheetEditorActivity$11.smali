.class Lcom/mrkeyboard/app/SheetEditorActivity$11;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/view/View$OnFocusChangeListener;


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

.field final synthetic val$card:Landroid/widget/LinearLayout;

.field final synthetic val$cardRadius:F

.field final synthetic val$inputRadius:F

.field final synthetic val$inputShell:Landroid/widget/LinearLayout;

.field final synthetic val$kbdIcon:Lcom/mrkeyboard/app/SheetUi$IconDrawable;

.field final synthetic val$strokeFocus:I

.field final synthetic val$strokeIdle:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetUi$IconDrawable;Landroid/widget/LinearLayout;FIILandroid/widget/LinearLayout;F)V
    .registers 9

    .line 396
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->val$kbdIcon:Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    iput-object p3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->val$inputShell:Landroid/widget/LinearLayout;

    iput p4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->val$inputRadius:F

    iput p5, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->val$strokeFocus:I

    iput p6, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->val$strokeIdle:I

    iput-object p7, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->val$card:Landroid/widget/LinearLayout;

    iput p8, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->val$cardRadius:F

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFocusChange(Landroid/view/View;Z)V
    .registers 7

    .line 399
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->val$kbdIcon:Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    const v0, -0xd63a0a

    if-eqz p2, :cond_9

    move v1, v0

    goto :goto_c

    :cond_9
    const v1, -0x907f67

    :goto_c
    invoke-virtual {p1, v1}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->setColor(I)V

    .line 400
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->val$inputShell:Landroid/widget/LinearLayout;

    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->val$inputRadius:F

    .line 403
    if-eqz p2, :cond_18

    iget v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->val$strokeFocus:I

    goto :goto_1a

    :cond_18
    iget v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->val$strokeIdle:I

    .line 404
    :goto_1a
    if-eqz p2, :cond_1d

    goto :goto_20

    :cond_1d
    const v0, -0xd5c4ac

    .line 400
    :goto_20
    const v3, -0xf5efe8

    invoke-static {v3, v1, v2, v0}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 406
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->val$card:Landroid/widget/LinearLayout;

    iget v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->val$cardRadius:F

    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->val$strokeIdle:I

    .line 410
    if-eqz p2, :cond_36

    const v2, 0x4d29c5f6    # 1.78020192E8f

    goto :goto_39

    :cond_36
    const v2, -0xe5dacb

    .line 406
    :goto_39
    const v3, -0xf0e9df

    invoke-static {v3, v0, v1, v2}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 412
    if-eqz p2, :cond_5d

    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mScrollView:Landroid/widget/ScrollView;
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$400(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/ScrollView;

    move-result-object p1

    if-eqz p1, :cond_5d

    .line 413
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mScrollView:Landroid/widget/ScrollView;
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$400(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/ScrollView;

    move-result-object p1

    new-instance p2, Lcom/mrkeyboard/app/SheetEditorActivity$11$1;

    invoke-direct {p2, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$11$1;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity$11;)V

    const-wide/16 v0, 0x78

    invoke-virtual {p1, p2, v0, v1}, Landroid/widget/ScrollView;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 420
    :cond_5d
    return-void
.end method
