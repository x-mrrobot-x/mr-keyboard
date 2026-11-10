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
    .locals 4

    .prologue
    .line 678
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 679
    iput p1, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    .line 680
    iput p2, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    .line 681
    iput p3, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->keyIdx:I

    .line 682
    iput-object p4, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    .line 683
    iput-object p5, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 684
    if-nez p6, :cond_0

    const-string p6, ""

    :cond_0
    iput-object p6, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    .line 685
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    const/16 v1, 0xa

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    const-string v1, "\n"

    const-string v2, "\u21b5"

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 686
    :goto_0
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x7

    if-le v1, v2, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v2, 0x0

    const/4 v3, 0x6

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\u2026"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_1
    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    .line 687
    if-eqz p5, :cond_2

    iget v0, p5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    const/high16 v1, 0x3f800000    # 1.0f

    sub-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const v1, 0x3d4ccccd    # 0.05f

    cmpg-float v0, v0, v1

    if-gtz v0, :cond_4

    .line 688
    :cond_2
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->widthBadge:Ljava/lang/String;

    .line 694
    :goto_1
    return-void

    .line 685
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    goto :goto_0

    .line 689
    :cond_4
    iget v0, p5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    iget v1, p5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    int-to-float v1, v1

    sub-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const v1, 0x3c23d70a    # 0.01f

    cmpg-float v0, v0, v1

    if-gez v0, :cond_5

    .line 690
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget v1, p5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->widthBadge:Ljava/lang/String;

    goto :goto_1

    .line 692
    :cond_5
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget v1, p5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->widthBadge:Ljava/lang/String;

    goto :goto_1
.end method
