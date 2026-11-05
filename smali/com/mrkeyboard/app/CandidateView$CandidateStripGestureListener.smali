.class Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;
.super Landroid/view/GestureDetector$SimpleOnGestureListener;
.source "CandidateView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/CandidateView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "CandidateStripGestureListener"
.end annotation


# instance fields
.field private final mTouchSlopSquare:I

.field final synthetic this$0:Lcom/mrkeyboard/app/CandidateView;


# direct methods
.method public constructor <init>(Lcom/mrkeyboard/app/CandidateView;I)V
    .locals 0

    .line 141
    iput-object p1, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    invoke-direct {p0}, Landroid/view/GestureDetector$SimpleOnGestureListener;-><init>()V

    mul-int p2, p2, p2

    .line 143
    iput p2, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->mTouchSlopSquare:I

    return-void
.end method


# virtual methods
.method public onDown(Landroid/view/MotionEvent;)Z
    .locals 1

    .line 157
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/CandidateView;->access$302(Lcom/mrkeyboard/app/CandidateView;Z)Z

    return v0
.end method

.method public onLongPress(Landroid/view/MotionEvent;)V
    .locals 2

    .line 148
    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    invoke-static {v0}, Lcom/mrkeyboard/app/CandidateView;->access$000(Lcom/mrkeyboard/app/CandidateView;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 149
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result p1

    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/CandidateView;->getScrollX()I

    move-result v0

    int-to-float v0, v0

    add-float/2addr p1, v0

    # long press only counts over the typed word's cell (mrLayout puts it in the middle)
    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/CandidateView;->mrOnFirst(F)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 150
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    invoke-static {p1}, Lcom/mrkeyboard/app/CandidateView;->access$200(Lcom/mrkeyboard/app/CandidateView;)V

    :cond_0
    return-void
.end method

.method public onScroll(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 2

    .line 164
    iget-object p4, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    invoke-static {p4}, Lcom/mrkeyboard/app/CandidateView;->access$300(Lcom/mrkeyboard/app/CandidateView;)Z

    move-result p4

    const/4 v0, 0x1

    if-nez p4, :cond_1

    .line 166
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result p4

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v1

    sub-float/2addr p4, v1

    float-to-int p4, p4

    .line 167
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getY()F

    move-result p2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    sub-float/2addr p2, p1

    float-to-int p1, p2

    mul-int p4, p4, p4

    mul-int p1, p1, p1

    add-int/2addr p4, p1

    .line 169
    iget p1, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->mTouchSlopSquare:I

    if-ge p4, p1, :cond_0

    return v0

    .line 172
    :cond_0
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/CandidateView;->access$302(Lcom/mrkeyboard/app/CandidateView;Z)Z

    .line 175
    :cond_1
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    invoke-virtual {p1}, Lcom/mrkeyboard/app/CandidateView;->getWidth()I

    move-result p1

    .line 176
    iget-object p2, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    invoke-static {p2, v0}, Lcom/mrkeyboard/app/CandidateView;->access$302(Lcom/mrkeyboard/app/CandidateView;Z)Z

    .line 177
    iget-object p2, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    invoke-virtual {p2}, Lcom/mrkeyboard/app/CandidateView;->getScrollX()I

    move-result p2

    float-to-int p4, p3

    add-int/2addr p2, p4

    if-gez p2, :cond_2

    const/4 p2, 0x0

    :cond_2
    const/4 v1, 0x0

    cmpl-float p3, p3, v1

    if-lez p3, :cond_3

    add-int/2addr p1, p2

    .line 182
    iget-object p3, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    invoke-static {p3}, Lcom/mrkeyboard/app/CandidateView;->access$400(Lcom/mrkeyboard/app/CandidateView;)I

    move-result p3

    if-le p1, p3, :cond_3

    sub-int/2addr p2, p4

    .line 185
    :cond_3
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    invoke-static {p1, p2}, Lcom/mrkeyboard/app/CandidateView;->access$502(Lcom/mrkeyboard/app/CandidateView;I)I

    .line 186
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    iget-object p3, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    invoke-virtual {p3}, Lcom/mrkeyboard/app/CandidateView;->getScrollY()I

    move-result p3

    invoke-virtual {p1, p2, p3}, Lcom/mrkeyboard/app/CandidateView;->scrollTo(II)V

    .line 187
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    invoke-static {p1}, Lcom/mrkeyboard/app/CandidateView;->access$600(Lcom/mrkeyboard/app/CandidateView;)V

    .line 188
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;->this$0:Lcom/mrkeyboard/app/CandidateView;

    invoke-virtual {p1}, Lcom/mrkeyboard/app/CandidateView;->invalidate()V

    return v0
.end method
