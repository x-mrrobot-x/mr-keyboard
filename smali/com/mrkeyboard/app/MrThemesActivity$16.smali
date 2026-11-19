.class Lcom/mrkeyboard/app/MrThemesActivity$16;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->showPreview(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;IZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$dots:Landroid/widget/LinearLayout;

.field final synthetic val$draw:[Ljava/lang/Runnable;

.field final synthetic val$kinds:Landroid/widget/LinearLayout;

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$style:[I

.field final synthetic val$styleLabel:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[ILandroid/widget/LinearLayout;Ljava/lang/Runnable;[Ljava/lang/Runnable;Landroid/widget/LinearLayout;Landroid/widget/TextView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 823
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$style:[I

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$kinds:Landroid/widget/LinearLayout;

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$redraw:Ljava/lang/Runnable;

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$draw:[Ljava/lang/Runnable;

    iput-object p6, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$dots:Landroid/widget/LinearLayout;

    iput-object p7, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$styleLabel:Landroid/widget/TextView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    .prologue
    const/high16 v8, 0x42200000    # 40.0f

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 825
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$style:[I

    aget v0, v0, v2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v4

    .line 826
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$kinds:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    move v3, v2

    .line 827
    :goto_0
    const/4 v0, 0x3

    if-ge v3, v0, :cond_2

    .line 829
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v5, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->kindName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v6

    if-ne v3, v4, :cond_1

    move v0, v1

    :goto_1
    new-instance v7, Lcom/mrkeyboard/app/MrThemesActivity$16$1;

    invoke-direct {v7, p0, v3}, Lcom/mrkeyboard/app/MrThemesActivity$16$1;-><init>(Lcom/mrkeyboard/app/MrThemesActivity$16;I)V

    invoke-virtual {v5, v6, v0, v7}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    .line 837
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x2

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-direct {v5, v2, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 838
    if-lez v3, :cond_0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v6, v6, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x41000000    # 8.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-virtual {v5, v6, v2, v2, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 839
    :cond_0
    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$kinds:Landroid/widget/LinearLayout;

    invoke-virtual {v6, v0, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 827
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_0

    :cond_1
    move v0, v2

    .line 829
    goto :goto_1

    .line 841
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$dots:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 842
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->KIND_FIRST:[I

    aget v0, v0, v4

    :goto_2
    sget-object v3, Lcom/mrkeyboard/app/MrBackdrop;->KIND_FIRST:[I

    add-int/lit8 v5, v4, 0x1

    aget v3, v3, v5

    if-ge v0, v3, :cond_5

    .line 844
    new-instance v5, Lcom/mrkeyboard/app/MrStyleDot;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$style:[I

    aget v3, v3, v2

    if-ne v0, v3, :cond_4

    move v3, v1

    :goto_3
    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v7, v7, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-direct {v5, v6, v0, v3, v7}, Lcom/mrkeyboard/app/MrStyleDot;-><init>(Landroid/content/Context;IZI)V

    .line 845
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-static {v3, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->styleName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v5, v3}, Lcom/mrkeyboard/app/MrStyleDot;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 846
    invoke-virtual {v5, v1}, Lcom/mrkeyboard/app/MrStyleDot;->setClickable(Z)V

    .line 847
    new-instance v3, Lcom/mrkeyboard/app/MrThemesActivity$16$2;

    invoke-direct {v3, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$16$2;-><init>(Lcom/mrkeyboard/app/MrThemesActivity$16;I)V

    invoke-virtual {v5, v3}, Lcom/mrkeyboard/app/MrStyleDot;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 854
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v6, v6, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6, v8}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v7, v7, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v7, v8}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v7

    invoke-direct {v3, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 855
    sget-object v6, Lcom/mrkeyboard/app/MrBackdrop;->KIND_FIRST:[I

    aget v6, v6, v4

    if-le v0, v6, :cond_3

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v6, v6, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x41400000    # 12.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-virtual {v3, v6, v2, v2, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 856
    :cond_3
    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$dots:Landroid/widget/LinearLayout;

    invoke-virtual {v6, v5, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 842
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :cond_4
    move v3, v2

    .line 844
    goto :goto_3

    .line 858
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$styleLabel:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$style:[I

    aget v2, v3, v2

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->styleName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 859
    return-void
.end method
