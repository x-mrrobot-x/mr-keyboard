.class final Lcom/mrkeyboard/app/MrCappedScroll;
.super Landroid/widget/ScrollView;
.source "MrCappedScroll.java"


# static fields
.field static final FREE:I = 0x3fffffff


# instance fields
.field private mMaxPx:I


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 17
    invoke-direct {p0, p1}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 14
    const v0, 0x3fffffff    # 1.9999999f

    iput v0, p0, Lcom/mrkeyboard/app/MrCappedScroll;->mMaxPx:I

    .line 18
    return-void
.end method


# virtual methods
.method cap(I)V
    .locals 1

    .prologue
    const v0, 0x3fffffff    # 1.9999999f

    .line 22
    if-gez p1, :cond_1

    const/4 p1, 0x0

    :cond_0
    :goto_0
    iput p1, p0, Lcom/mrkeyboard/app/MrCappedScroll;->mMaxPx:I

    .line 23
    return-void

    .line 22
    :cond_1
    if-le p1, v0, :cond_0

    move p1, v0

    goto :goto_0
.end method

.method maxPx()I
    .locals 1

    .prologue
    .line 27
    iget v0, p0, Lcom/mrkeyboard/app/MrCappedScroll;->mMaxPx:I

    return v0
.end method

.method protected onMeasure(II)V
    .locals 2

    .prologue
    .line 32
    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v0

    .line 33
    if-lez v0, :cond_0

    iget v1, p0, Lcom/mrkeyboard/app/MrCappedScroll;->mMaxPx:I

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 34
    :goto_0
    const/high16 v1, -0x80000000

    invoke-static {v0, v1}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v0

    invoke-super {p0, p1, v0}, Landroid/widget/ScrollView;->onMeasure(II)V

    .line 35
    return-void

    .line 33
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrCappedScroll;->mMaxPx:I

    goto :goto_0
.end method
