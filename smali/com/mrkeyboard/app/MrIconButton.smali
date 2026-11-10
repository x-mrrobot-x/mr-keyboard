.class public Lcom/mrkeyboard/app/MrIconButton;
.super Landroid/widget/TextView;
.source "MrIconButton.java"

# A TextView that draws a vector and its (one line) text centred together as a group.
# Hand-written smali (stub for the Java sources in docs/tools/java/stubs).

# instance fields
.field private mGap:I

.field private mIcon:Landroid/graphics/drawable/Drawable;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 9

    iget-object v0, p0, Lcom/mrkeyboard/app/MrIconButton;->mIcon:Landroid/graphics/drawable/Drawable;

    if-nez v0, :plain

    invoke-super {p0, p1}, Landroid/widget/TextView;->onDraw(Landroid/graphics/Canvas;)V

    return-void

    :plain
    invoke-virtual {p0}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {p0}, Landroid/widget/TextView;->getPaint()Landroid/text/TextPaint;

    move-result-object v2

    const/4 v3, 0x0

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v4

    invoke-virtual {v2, v1, v3, v4}, Landroid/graphics/Paint;->measureText(Ljava/lang/CharSequence;II)F

    move-result v1

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v2

    invoke-virtual {v2}, Landroid/graphics/Rect;->width()I

    move-result v3

    invoke-virtual {v2}, Landroid/graphics/Rect;->height()I

    move-result v2

    iget v4, p0, Lcom/mrkeyboard/app/MrIconButton;->mGap:I

    add-int/2addr v4, v3

    int-to-float v4, v4

    add-float/2addr v4, v1

    invoke-virtual {p0}, Landroid/view/View;->getWidth()I

    move-result v5

    invoke-virtual {p0}, Landroid/view/View;->getPaddingLeft()I

    move-result v6

    invoke-virtual {p0}, Landroid/view/View;->getPaddingRight()I

    move-result v7

    add-int/2addr v6, v7

    sub-int v6, v5, v6

    int-to-float v6, v6

    cmpl-float v6, v4, v6

    if-lez v6, :fits

    invoke-super {p0, p1}, Landroid/widget/TextView;->onDraw(Landroid/graphics/Canvas;)V

    return-void

    :fits
    int-to-float v5, v5

    sub-float v4, v5, v4

    const/high16 v6, 0x40000000    # 2.0f

    div-float/2addr v4, v6

    # v4 = left of the group; draw the vector centred vertically
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    move-result v7

    sub-int/2addr v7, v2

    int-to-float v7, v7

    div-float/2addr v7, v6

    invoke-virtual {p1, v4, v7}, Landroid/graphics/Canvas;->translate(FF)V

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    # the text: centred by the gravity at (width - tw) / 2, wanted at left + iw + gap
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    iget v7, p0, Lcom/mrkeyboard/app/MrIconButton;->mGap:I

    add-int/2addr v3, v7

    int-to-float v3, v3

    add-float/2addr v3, v4

    sub-float/2addr v5, v1

    div-float/2addr v5, v6

    sub-float/2addr v3, v5

    const/4 v7, 0x0

    invoke-virtual {p1, v3, v7}, Landroid/graphics/Canvas;->translate(FF)V

    invoke-super {p0, p1}, Landroid/widget/TextView;->onDraw(Landroid/graphics/Canvas;)V

    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    return-void
.end method

.method public setIcon(Landroid/graphics/drawable/Drawable;I)V
    .locals 0

    iput-object p1, p0, Lcom/mrkeyboard/app/MrIconButton;->mIcon:Landroid/graphics/drawable/Drawable;

    iput p2, p0, Lcom/mrkeyboard/app/MrIconButton;->mGap:I

    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    return-void
.end method
