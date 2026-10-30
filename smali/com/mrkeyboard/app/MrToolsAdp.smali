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

    if-eqz v1, :cond_flat

    # Todas as celulas reservam SEMPRE 2 linhas: no modo 2 colunas a celula
    # menor (1 linha) ficava menor que a da mesma linha e a proxima linha
    # "colapsava" por cima. reservando 2 linhas, todas tem a mesma altura.
    const/4 v2, 0x2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setLines(I)V

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setMaxLines(I)V

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setMinLines(I)V

    # Card = mesmo fundo/borda das teclas do tema (ex.: tecla a)
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sKeyBg:Landroid/graphics/drawable/Drawable;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->dupe(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    if-eqz v1, :cond_card_fallback

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    # setBackgroundDrawable pode sobrescrever o padding: reaplica os 10dp do item
    sget v1, Lcom/mrkeyboard/app/MrTools;->sPad:I

    invoke-virtual {v0, v1, v1, v1, v1}, Landroid/widget/TextView;->setPadding(IIII)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->lockCard(Landroid/widget/TextView;)V

    return-object v0

    :cond_card_fallback
    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    sget v2, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    const v3, 0xffffff

    and-int/2addr v2, v3

    const/high16 v3, 0x22000000

    or-int/2addr v2, v3

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    sget v2, Lcom/mrkeyboard/app/MrTools;->sPadV:I

    int-to-float v2, v2

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    sget v1, Lcom/mrkeyboard/app/MrTools;->sPad:I

    invoke-virtual {v0, v1, v1, v1, v1}, Landroid/widget/TextView;->setPadding(IIII)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->lockCard(Landroid/widget/TextView;)V

    return-object v0

    :cond_flat
    iget v1, p0, Lcom/mrkeyboard/app/MrToolsAdp;->mSel:I

    if-ne v1, p1, :cond_plain

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Landroid/view/View;->setActivated(Z)V

    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    sget v2, Lcom/mrkeyboard/app/MrTools;->sSelColor:I

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    sget v2, Lcom/mrkeyboard/app/MrTools;->sPad:I

    int-to-float v2, v2

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    return-object v0

    :cond_plain
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setActivated(Z)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    return-object v0
.end method
