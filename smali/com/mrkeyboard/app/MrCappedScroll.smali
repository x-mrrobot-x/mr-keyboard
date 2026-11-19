.class final Lcom/mrkeyboard/app/MrCappedScroll;
.super Landroid/widget/ScrollView;
.source "MrCappedScroll.java"


# instance fields
.field private final mMaxPx:I


# direct methods
.method constructor <init>(Landroid/content/Context;I)V
    .locals 0

    .prologue
    .line 11
    invoke-direct {p0, p1}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 12
    iput p2, p0, Lcom/mrkeyboard/app/MrCappedScroll;->mMaxPx:I

    .line 13
    return-void
.end method


# virtual methods
.method maxPx()I
    .locals 1

    .prologue
    .line 17
    iget v0, p0, Lcom/mrkeyboard/app/MrCappedScroll;->mMaxPx:I

    return v0
.end method

.method protected onMeasure(II)V
    .locals 2

    .prologue
    .line 22
    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v0

    .line 23
    if-lez v0, :cond_0

    iget v1, p0, Lcom/mrkeyboard/app/MrCappedScroll;->mMaxPx:I

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 24
    :goto_0
    const/high16 v1, -0x80000000

    invoke-static {v0, v1}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v0

    invoke-super {p0, p1, v0}, Landroid/widget/ScrollView;->onMeasure(II)V

    .line 25
    return-void

    .line 23
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrCappedScroll;->mMaxPx:I

    goto :goto_0
.end method
