.class final Lcom/mrkeyboard/app/MrSheetBox;
.super Landroid/widget/LinearLayout;
.source "MrSheetBox.java"


# instance fields
.field private final mMaxPx:I

.field private final mMinScrollPx:I

.field private mScroll:Lcom/mrkeyboard/app/MrCappedScroll;


# direct methods
.method constructor <init>(Landroid/content/Context;II)V
    .locals 1

    .prologue
    .line 17
    invoke-direct {p0, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 18
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrSheetBox;->setOrientation(I)V

    .line 19
    iput p2, p0, Lcom/mrkeyboard/app/MrSheetBox;->mMaxPx:I

    .line 20
    iput p3, p0, Lcom/mrkeyboard/app/MrSheetBox;->mMinScrollPx:I

    .line 21
    return-void
.end method

.method static room(III)I
    .locals 1

    .prologue
    .line 39
    sub-int v0, p0, p1

    invoke-static {p2, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    return v0
.end method


# virtual methods
.method limit(Lcom/mrkeyboard/app/MrCappedScroll;)V
    .locals 0

    .prologue
    .line 25
    iput-object p1, p0, Lcom/mrkeyboard/app/MrSheetBox;->mScroll:Lcom/mrkeyboard/app/MrCappedScroll;

    .line 26
    return-void
.end method

.method maxPx()I
    .locals 1

    .prologue
    .line 34
    iget v0, p0, Lcom/mrkeyboard/app/MrSheetBox;->mMaxPx:I

    return v0
.end method

.method protected onMeasure(II)V
    .locals 5

    .prologue
    .line 44
    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v0

    .line 45
    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getMode(I)I

    move-result v1

    if-eqz v1, :cond_0

    if-gtz v0, :cond_2

    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrSheetBox;->mMaxPx:I

    .line 46
    :goto_0
    const/high16 v1, -0x80000000

    invoke-static {v0, v1}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v1

    .line 47
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSheetBox;->mScroll:Lcom/mrkeyboard/app/MrCappedScroll;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrSheetBox;->mScroll:Lcom/mrkeyboard/app/MrCappedScroll;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrCappedScroll;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    if-eq v2, p0, :cond_3

    .line 48
    :cond_1
    invoke-super {p0, p1, v1}, Landroid/widget/LinearLayout;->onMeasure(II)V

    .line 56
    :goto_1
    return-void

    .line 45
    :cond_2
    iget v1, p0, Lcom/mrkeyboard/app/MrSheetBox;->mMaxPx:I

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    goto :goto_0

    .line 52
    :cond_3
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSheetBox;->mScroll:Lcom/mrkeyboard/app/MrCappedScroll;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrCappedScroll;->cap(I)V

    .line 53
    invoke-super {p0, p1, v1}, Landroid/widget/LinearLayout;->onMeasure(II)V

    .line 54
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSheetBox;->mScroll:Lcom/mrkeyboard/app/MrCappedScroll;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrSheetBox;->getMeasuredHeight()I

    move-result v3

    iget v4, p0, Lcom/mrkeyboard/app/MrSheetBox;->mMinScrollPx:I

    invoke-static {v0, v3, v4}, Lcom/mrkeyboard/app/MrSheetBox;->room(III)I

    move-result v0

    invoke-virtual {v2, v0}, Lcom/mrkeyboard/app/MrCappedScroll;->cap(I)V

    .line 55
    invoke-super {p0, p1, v1}, Landroid/widget/LinearLayout;->onMeasure(II)V

    goto :goto_1
.end method

.method scroll()Lcom/mrkeyboard/app/MrCappedScroll;
    .locals 1

    .prologue
    .line 29
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSheetBox;->mScroll:Lcom/mrkeyboard/app/MrCappedScroll;

    return-object v0
.end method
