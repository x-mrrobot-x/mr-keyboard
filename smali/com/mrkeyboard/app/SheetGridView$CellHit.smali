.class final Lcom/mrkeyboard/app/SheetGridView$CellHit;
.super Ljava/lang/Object;
.source "SheetGridView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/SheetGridView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "CellHit"
.end annotation


# static fields
.field static final KIND_ADD:I = 0x1

.field static final KIND_KEY:I = 0x0

.field static final KIND_LOCKED_BOTTOM:I = 0x3

.field static final KIND_LOCKED_DELETE:I = 0x2


# instance fields
.field final displayLabel:Ljava/lang/String;

.field final keyIdx:I

.field final kind:I

.field final rect:Landroid/graphics/RectF;

.field final rowIdx:I

.field final shortLabel:Ljava/lang/String;

.field final spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

.field final widthBadge:Ljava/lang/String;


# direct methods
.method constructor <init>(IIILandroid/graphics/RectF;Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V
    .registers 7

    .line 514
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 515
    iput p1, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    .line 516
    iput p2, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    .line 517
    iput p3, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->keyIdx:I

    .line 518
    iput-object p4, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    .line 519
    iput-object p5, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 520
    if-nez p6, :cond_11

    const-string p6, ""

    :cond_11
    iput-object p6, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    .line 522
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    const/16 p2, 0xa

    invoke-virtual {p1, p2}, Ljava/lang/String;->indexOf(I)I

    move-result p1

    if-ltz p1, :cond_28

    .line 523
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    const-string p2, "\n"

    const-string p3, "\u21b5"

    invoke-virtual {p1, p2, p3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    goto :goto_2a

    .line 524
    :cond_28
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    .line 525
    :goto_2a
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p2

    const/4 p3, 0x7

    if-le p2, p3, :cond_4a

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const/4 p3, 0x0

    const/4 p4, 0x6

    invoke-virtual {p1, p3, p4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, "\u2026"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :cond_4a
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    .line 527
    if-eqz p5, :cond_a5

    iget p1, p5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    const/high16 p2, 0x3f800000    # 1.0f

    sub-float/2addr p1, p2

    invoke-static {p1}, Ljava/lang/Math;->abs(F)F

    move-result p1

    const p2, 0x3d4ccccd    # 0.05f

    cmpl-float p1, p1, p2

    if-lez p1, :cond_a5

    .line 528
    iget p1, p5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    iget p2, p5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {p2}, Ljava/lang/Math;->round(F)I

    move-result p2

    int-to-float p2, p2

    sub-float/2addr p1, p2

    invoke-static {p1}, Ljava/lang/Math;->abs(F)F

    move-result p1

    const p2, 0x3c23d70a    # 0.01f

    cmpg-float p1, p1, p2

    const-string p2, "x"

    if-gez p1, :cond_8f

    .line 529
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    iget p3, p5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {p3}, Ljava/lang/Math;->round(F)I

    move-result p3

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->widthBadge:Ljava/lang/String;

    goto :goto_a8

    .line 531
    :cond_8f
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    iget p3, p5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->widthBadge:Ljava/lang/String;

    goto :goto_a8

    .line 534
    :cond_a5
    const/4 p1, 0x0

    iput-object p1, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->widthBadge:Ljava/lang/String;

    .line 536
    :goto_a8
    return-void
.end method
