.class Lcom/mrkeyboard/app/SheetEditorActivity$19;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->showManageRowsDialog()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

.field final synthetic val$box:Landroid/widget/LinearLayout;

.field final synthetic val$pt:Z

.field final synthetic val$rebuild:[Ljava/lang/Runnable;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/widget/LinearLayout;Z[Ljava/lang/Runnable;)V
    .registers 5

    .line 720
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->val$box:Landroid/widget/LinearLayout;

    iput-boolean p3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->val$pt:Z

    iput-object p4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->val$rebuild:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 12

    .line 723
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->val$box:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 724
    const/4 v0, 0x0

    move v1, v0

    :goto_7
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;
    invoke-static {v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$500(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v2

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_171

    .line 725
    nop

    .line 726
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;
    invoke-static {v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$500(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v2

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 727
    new-instance v3, Landroid/widget/LinearLayout;

    iget-object v4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {v3, v4}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 728
    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 729
    const/16 v4, 0x10

    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 730
    iget-object v4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    const/high16 v5, 0x41400000    # 12.0f

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I
    invoke-static {v4, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1500(Lcom/mrkeyboard/app/SheetEditorActivity;F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    const/high16 v6, 0x41000000    # 8.0f

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I
    invoke-static {v5, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1500(Lcom/mrkeyboard/app/SheetEditorActivity;F)I

    move-result v5

    iget-object v7, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I
    invoke-static {v7, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1500(Lcom/mrkeyboard/app/SheetEditorActivity;F)I

    move-result v7

    iget-object v8, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I
    invoke-static {v8, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1500(Lcom/mrkeyboard/app/SheetEditorActivity;F)I

    move-result v6

    invoke-virtual {v3, v4, v5, v7, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 731
    iget-object v4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    const/high16 v5, 0x41200000    # 10.0f

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    const/high16 v6, 0x3f800000    # 1.0f

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I
    invoke-static {v5, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1500(Lcom/mrkeyboard/app/SheetEditorActivity;F)I

    move-result v5

    const/4 v7, 0x1

    invoke-static {v7, v5}, Ljava/lang/Math;->max(II)I

    move-result v5

    const v8, -0xd5c4ac

    const v9, -0xf5efe8

    invoke-static {v9, v4, v5, v8}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 732
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, -0x1

    const/4 v8, -0x2

    invoke-direct {v4, v5, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 733
    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    const/high16 v9, 0x40c00000    # 6.0f

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I
    invoke-static {v5, v9}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1500(Lcom/mrkeyboard/app/SheetEditorActivity;F)I

    move-result v5

    iput v5, v4, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 734
    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 736
    new-instance v4, Landroid/widget/TextView;

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {v4, v5}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 737
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    iget-boolean v9, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->val$pt:Z

    if-eqz v9, :cond_9b

    const-string v9, "Fileira "

    invoke-static/range {v9 .. v9}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    goto :goto_9d

    :cond_9b
    const-string v9, "Row "

    :goto_9d
    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    add-int/lit8 v9, v1, 0x1

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v10, " ("

    invoke-virtual {v5, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-boolean v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->val$pt:Z

    if-eqz v5, :cond_be

    const-string v5, " teclas)"

    invoke-static/range {v5 .. v5}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    goto :goto_c0

    :cond_be
    const-string v5, " keys)"

    :goto_c0
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 738
    const v2, -0x160f07

    invoke-virtual {v4, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 739
    const/high16 v2, 0x41580000    # 13.5f

    invoke-virtual {v4, v2}, Landroid/widget/TextView;->setTextSize(F)V

    .line 740
    sget-object v2, Lcom/mrkeyboard/app/SheetUi;->TF_MEDIUM:Landroid/graphics/Typeface;

    invoke-virtual {v4, v2}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 741
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v0, v8, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v3, v4, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 743
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    if-lez v1, :cond_e9

    move v4, v7

    goto :goto_ea

    :cond_e9
    move v4, v0

    :goto_ea
    const-string v5, "\u2191"

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->makeMiniRowBtn(Ljava/lang/String;ZZ)Landroid/widget/TextView;
    invoke-static {v2, v5, v4, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1600(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object v2

    .line 744
    new-instance v4, Lcom/mrkeyboard/app/SheetEditorActivity$19$1;

    invoke-direct {v4, p0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity$19$1;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity$19;I)V

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 756
    invoke-virtual {v3, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 758
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object v4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;
    invoke-static {v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$500(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v4

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    sub-int/2addr v4, v7

    if-ge v1, v4, :cond_10e

    move v4, v7

    goto :goto_10f

    :cond_10e
    move v4, v0

    :goto_10f
    const-string v5, "\u2193"

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->makeMiniRowBtn(Ljava/lang/String;ZZ)Landroid/widget/TextView;
    invoke-static {v2, v5, v4, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1600(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object v2

    .line 759
    new-instance v4, Lcom/mrkeyboard/app/SheetEditorActivity$19$2;

    invoke-direct {v4, p0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity$19$2;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity$19;I)V

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 771
    invoke-virtual {v3, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 773
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object v4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;
    invoke-static {v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$500(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v4

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    const/4 v5, 0x6

    if-ge v4, v5, :cond_133

    move v4, v7

    goto :goto_134

    :cond_133
    move v4, v0

    :goto_134
    const-string v5, "\u29c9"

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->makeMiniRowBtn(Ljava/lang/String;ZZ)Landroid/widget/TextView;
    invoke-static {v2, v5, v4, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1600(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object v2

    .line 774
    new-instance v4, Lcom/mrkeyboard/app/SheetEditorActivity$19$3;

    invoke-direct {v4, p0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity$19$3;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity$19;I)V

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 785
    invoke-virtual {v3, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 787
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object v4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;
    invoke-static {v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$500(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v4

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-le v4, v7, :cond_157

    move v4, v7

    goto :goto_158

    :cond_157
    move v4, v0

    :goto_158
    const-string v5, "\u2715"

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->makeMiniRowBtn(Ljava/lang/String;ZZ)Landroid/widget/TextView;
    invoke-static {v2, v5, v4, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1600(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object v2

    .line 788
    new-instance v4, Lcom/mrkeyboard/app/SheetEditorActivity$19$4;

    invoke-direct {v4, p0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity$19$4;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity$19;I)V

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 799
    invoke-virtual {v3, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 800
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->val$box:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 724
    move v1, v9

    goto/16 :goto_7

    .line 802
    :cond_171
    return-void
.end method
