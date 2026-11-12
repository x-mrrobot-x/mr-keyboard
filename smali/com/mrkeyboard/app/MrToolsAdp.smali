.class public Lcom/mrkeyboard/app/MrToolsAdp;
.super Landroid/widget/ArrayAdapter;
.source "MrToolsAdp.java"

.field mCard:Z

.field mSel:I

.method public constructor <init>(Landroid/content/Context;ILjava/util/List;)V
    .locals 1

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;ILjava/util/List;)V

    const/4 v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrToolsAdp;->mSel:I

    return-void
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 4

    invoke-super {p0, p1, p2, p3}, Landroid/widget/ArrayAdapter;->getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sget v1, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->tint(Landroid/widget/TextView;)V

    iget-boolean v1, p0, Lcom/mrkeyboard/app/MrToolsAdp;->mCard:Z

    if-eqz v1, :cond_1

    const/4 v2, 0x2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setLines(I)V

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setMaxLines(I)V

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setMinLines(I)V

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sKeyBg:Landroid/graphics/drawable/Drawable;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->dupe(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    # a card that is a key: its text and icon are the labels of the keys, not the ink of the background
    sget v2, Lcom/mrkeyboard/app/MrTools;->sKeyText:I

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrTools;->tintColor(Landroid/widget/TextView;I)V

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrTools;->lookFixed(Landroid/graphics/drawable/Drawable;Landroid/content/Context;)V

    sget v1, Lcom/mrkeyboard/app/MrTools;->sPad:I

    invoke-virtual {v0, v1, v1, v1, v1}, Landroid/widget/TextView;->setPadding(IIII)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->lockCard(Landroid/widget/TextView;)V

    return-object v0

    :cond_0
    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    sget v2, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    const v3, 0xffffff

    and-int/2addr v2, v3

    const-string v3, "alpha_card"

    invoke-static {v3}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v3

    or-int/2addr v2, v3

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    const/high16 v2, 0x40000000    # 2.0f

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTools;->radius(F)F

    move-result v2

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    sget v1, Lcom/mrkeyboard/app/MrTools;->sPad:I

    invoke-virtual {v0, v1, v1, v1, v1}, Landroid/widget/TextView;->setPadding(IIII)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->lockCard(Landroid/widget/TextView;)V

    return-object v0

    :cond_1
    iget v1, p0, Lcom/mrkeyboard/app/MrToolsAdp;->mSel:I

    if-ne v1, p1, :cond_2

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Landroid/view/View;->setActivated(Z)V

    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    sget v2, Lcom/mrkeyboard/app/MrTools;->sSelColor:I

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    # the selected row is a pane too: in a theme of glass it gets the rim
    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->rim(Landroid/graphics/drawable/GradientDrawable;)V

    const/high16 v2, 0x40000000    # 2.0f

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTools;->radius(F)F

    move-result v2

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    return-object v0

    :cond_2
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setActivated(Z)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    return-object v0
.end method
