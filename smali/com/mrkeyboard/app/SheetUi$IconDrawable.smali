.class public final Lcom/mrkeyboard/app/SheetUi$IconDrawable;
.super Landroid/graphics/drawable/Drawable;
.source "SheetUi.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/SheetUi;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "IconDrawable"
.end annotation


# instance fields
.field private final mFillPaint:Landroid/graphics/Paint;

.field private final mKind:I

.field private final mPath:Landroid/graphics/Path;

.field private final mRect:Landroid/graphics/RectF;

.field private final mSizePx:I

.field private final mStrokePaint:Landroid/graphics/Paint;


# direct methods
.method public constructor <init>(Landroid/content/Context;III)V
    .registers 6

    .line 419
    invoke-direct {p0}, Landroid/graphics/drawable/Drawable;-><init>()V

    .line 416
    new-instance v0, Landroid/graphics/Path;

    invoke-direct {v0}, Landroid/graphics/Path;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    .line 417
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    .line 420
    iput p2, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mKind:I

    .line 421
    iput p4, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mSizePx:I

    .line 422
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p1

    iget p1, p1, Landroid/util/DisplayMetrics;->density:F

    const p2, 0x3feccccd    # 1.85f

    mul-float/2addr p1, p2

    const/high16 p2, 0x40000000    # 2.0f

    invoke-static {p2, p1}, Ljava/lang/Math;->max(FF)F

    move-result p1

    .line 424
    new-instance p2, Landroid/graphics/Paint;

    const/4 p4, 0x1

    invoke-direct {p2, p4}, Landroid/graphics/Paint;-><init>(I)V

    iput-object p2, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    .line 425
    iget-object p2, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    sget-object v0, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {p2, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 426
    iget-object p2, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {p2, p1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 427
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    sget-object p2, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 428
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    sget-object p2, Landroid/graphics/Paint$Join;->ROUND:Landroid/graphics/Paint$Join;

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setStrokeJoin(Landroid/graphics/Paint$Join;)V

    .line 429
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, p3}, Landroid/graphics/Paint;->setColor(I)V

    .line 431
    new-instance p1, Landroid/graphics/Paint;

    invoke-direct {p1, p4}, Landroid/graphics/Paint;-><init>(I)V

    iput-object p1, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mFillPaint:Landroid/graphics/Paint;

    .line 432
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mFillPaint:Landroid/graphics/Paint;

    sget-object p2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 433
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mFillPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, p3}, Landroid/graphics/Paint;->setColor(I)V

    .line 434
    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .registers 30

    .line 456
    move-object/from16 v0, p0

    move-object/from16 v7, p1

    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v1

    .line 457
    invoke-virtual {v1}, Landroid/graphics/Rect;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_f

    return-void

    .line 458
    :cond_f
    iget v2, v1, Landroid/graphics/Rect;->left:I

    int-to-float v8, v2

    .line 459
    iget v2, v1, Landroid/graphics/Rect;->top:I

    int-to-float v9, v2

    .line 460
    invoke-virtual {v1}, Landroid/graphics/Rect;->width()I

    move-result v2

    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    int-to-float v1, v1

    const/high16 v2, 0x41c00000    # 24.0f

    div-float v10, v1, v2

    .line 462
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    invoke-virtual {v1}, Landroid/graphics/Path;->reset()V

    .line 463
    iget v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mKind:I

    const/high16 v2, 0x419c0000    # 19.5f

    const/high16 v3, 0x41580000    # 13.5f

    const/high16 v4, 0x41800000    # 16.0f

    const/high16 v5, 0x41000000    # 8.0f

    const/high16 v11, 0x41840000    # 16.5f

    const/high16 v12, 0x40f00000    # 7.5f

    const/high16 v13, 0x41700000    # 15.0f

    const/high16 v14, 0x41a40000    # 20.5f

    const/high16 v6, 0x40a00000    # 5.0f

    const/high16 v15, 0x40800000    # 4.0f

    const/high16 v16, 0x41080000    # 8.5f

    const/high16 v17, 0x41780000    # 15.5f

    const/high16 v18, 0x41280000    # 10.5f

    const/high16 v19, 0x40600000    # 3.5f

    const/high16 v20, 0x41980000    # 19.0f

    const/high16 v21, 0x40900000    # 4.5f

    const/high16 v22, 0x418c0000    # 17.5f

    const/high16 v23, 0x40d00000    # 6.5f

    const/high16 v24, 0x41940000    # 18.5f

    const/high16 v25, 0x41a00000    # 20.0f

    const/high16 v26, 0x40b00000    # 5.5f

    const/high16 v27, 0x41400000    # 12.0f

    packed-switch v1, :pswitch_data_4fa

    .line 630
    return-void

    .line 621
    :pswitch_5d
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    mul-float v26, v26, v10

    add-float v2, v8, v26

    const/high16 v3, 0x41300000    # 11.0f

    mul-float/2addr v3, v10

    add-float v11, v9, v3

    mul-float v24, v24, v10

    add-float v3, v8, v24

    mul-float v25, v25, v10

    add-float v6, v9, v25

    invoke-virtual {v1, v2, v11, v3, v6}, Landroid/graphics/RectF;->set(FFFF)V

    .line 622
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    const/high16 v2, 0x40000000    # 2.0f

    mul-float/2addr v2, v10

    iget-object v3, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v1, v2, v2, v3}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 623
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    mul-float/2addr v5, v10

    add-float v12, v8, v5

    mul-float v21, v21, v10

    add-float v2, v9, v21

    mul-float/2addr v4, v10

    add-float/2addr v8, v4

    const/high16 v3, 0x41500000    # 13.0f

    mul-float/2addr v3, v10

    add-float/2addr v3, v9

    invoke-virtual {v1, v12, v2, v8, v3}, Landroid/graphics/RectF;->set(FFFF)V

    .line 624
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    const/4 v5, 0x0

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    const/high16 v3, 0x43340000    # 180.0f

    const/high16 v4, 0x43340000    # 180.0f

    move-object/from16 v1, p1

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawArc(Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V

    .line 625
    mul-float v10, v10, v16

    add-float/2addr v9, v10

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    move v2, v12

    move v3, v9

    move v4, v12

    move v5, v11

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 626
    iget-object v6, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    move v2, v8

    move v4, v8

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 627
    return-void

    .line 616
    :pswitch_b1
    mul-float v23, v23, v10

    add-float v11, v8, v23

    add-float v12, v9, v23

    mul-float v10, v10, v22

    add-float/2addr v8, v10

    add-float/2addr v9, v10

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    move-object/from16 v1, p1

    move v2, v11

    move v3, v12

    move v4, v8

    move v5, v9

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 617
    iget-object v6, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    move v2, v8

    move v4, v11

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 618
    return-void

    .line 597
    :pswitch_ce
    mul-float/2addr v15, v10

    add-float v2, v8, v15

    mul-float v23, v23, v10

    add-float v15, v9, v23

    mul-float v25, v25, v10

    add-float v4, v8, v25

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    move-object/from16 v1, p1

    move v3, v15

    move v5, v15

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 598
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    const/high16 v2, 0x41100000    # 9.0f

    mul-float/2addr v2, v10

    add-float/2addr v2, v8

    invoke-virtual {v1, v2, v15}, Landroid/graphics/Path;->moveTo(FF)V

    .line 599
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v21, v21, v10

    add-float v3, v9, v21

    invoke-virtual {v1, v2, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 600
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v19, v19, v10

    add-float v4, v9, v19

    const/high16 v5, 0x41200000    # 10.0f

    mul-float/2addr v5, v10

    add-float/2addr v5, v8

    invoke-virtual {v1, v2, v4, v5, v4}, Landroid/graphics/Path;->quadTo(FFFF)V

    .line 601
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    const/high16 v5, 0x41600000    # 14.0f

    mul-float/2addr v5, v10

    add-float/2addr v5, v8

    invoke-virtual {v1, v5, v4}, Landroid/graphics/Path;->lineTo(FF)V

    .line 602
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float/2addr v13, v10

    add-float/2addr v13, v8

    invoke-virtual {v1, v13, v4, v13, v3}, Landroid/graphics/Path;->quadTo(FFFF)V

    .line 603
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    invoke-virtual {v1, v13, v15}, Landroid/graphics/Path;->lineTo(FF)V

    .line 604
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    add-float v3, v8, v23

    invoke-virtual {v1, v3, v15}, Landroid/graphics/Path;->moveTo(FF)V

    .line 605
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    const v3, 0x40eccccd    # 7.4f

    mul-float/2addr v3, v10

    add-float/2addr v3, v8

    mul-float v20, v20, v10

    add-float v4, v9, v20

    invoke-virtual {v1, v3, v4}, Landroid/graphics/Path;->lineTo(FF)V

    .line 606
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float/2addr v12, v10

    add-float/2addr v12, v8

    mul-float/2addr v14, v10

    add-float/2addr v14, v9

    invoke-virtual {v1, v12, v14, v2, v14}, Landroid/graphics/Path;->quadTo(FFFF)V

    .line 607
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    invoke-virtual {v1, v13, v14}, Landroid/graphics/Path;->lineTo(FF)V

    .line 608
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float/2addr v11, v10

    add-float v2, v8, v11

    const v3, 0x4184cccd    # 16.6f

    mul-float/2addr v3, v10

    add-float/2addr v3, v8

    invoke-virtual {v1, v2, v14, v3, v4}, Landroid/graphics/Path;->quadTo(FFFF)V

    .line 609
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v22, v22, v10

    add-float v2, v8, v22

    invoke-virtual {v1, v2, v15}, Landroid/graphics/Path;->lineTo(FF)V

    .line 610
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v1, v2}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 611
    const v1, 0x4124cccd    # 10.3f

    mul-float/2addr v1, v10

    add-float v4, v8, v1

    mul-float v18, v18, v10

    add-float v12, v9, v18

    add-float/2addr v9, v11

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    move-object/from16 v1, p1

    move v2, v4

    move v3, v12

    move v5, v9

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 612
    const v1, 0x415b3333    # 13.7f

    mul-float/2addr v10, v1

    add-float v4, v8, v10

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    move-object/from16 v1, p1

    move v2, v4

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 613
    return-void

    .line 588
    :pswitch_17a
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    mul-float v21, v21, v10

    add-float v3, v8, v21

    add-float v11, v9, v21

    mul-float/2addr v2, v10

    add-float v4, v8, v2

    add-float/2addr v2, v9

    invoke-virtual {v1, v3, v11, v4, v2}, Landroid/graphics/RectF;->set(FFFF)V

    .line 589
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    const/4 v5, 0x0

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    const/high16 v3, -0x3cf90000    # -135.0f

    const/high16 v4, 0x43910000    # 290.0f

    move-object/from16 v1, p1

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawArc(Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V

    .line 590
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    const v2, 0x40866666    # 4.2f

    mul-float/2addr v2, v10

    add-float/2addr v2, v8

    invoke-virtual {v1, v2, v11}, Landroid/graphics/Path;->moveTo(FF)V

    .line 591
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    const v3, 0x411ccccd    # 9.8f

    mul-float/2addr v3, v10

    add-float/2addr v9, v3

    invoke-virtual {v1, v2, v9}, Landroid/graphics/Path;->lineTo(FF)V

    .line 592
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    const/high16 v2, 0x41180000    # 9.5f

    mul-float/2addr v10, v2

    add-float/2addr v8, v10

    invoke-virtual {v1, v8, v9}, Landroid/graphics/Path;->lineTo(FF)V

    .line 593
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v1, v2}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 594
    return-void

    .line 573
    :pswitch_1bc
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v27, v27, v10

    add-float v2, v8, v27

    mul-float/2addr v15, v10

    add-float v3, v9, v15

    invoke-virtual {v1, v2, v3}, Landroid/graphics/Path;->moveTo(FF)V

    .line 574
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float/2addr v13, v10

    add-float/2addr v13, v9

    invoke-virtual {v1, v2, v13}, Landroid/graphics/Path;->lineTo(FF)V

    .line 575
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float/2addr v12, v10

    add-float/2addr v12, v8

    mul-float v18, v18, v10

    add-float v3, v9, v18

    invoke-virtual {v1, v12, v3}, Landroid/graphics/Path;->moveTo(FF)V

    .line 576
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    invoke-virtual {v1, v2, v13}, Landroid/graphics/Path;->lineTo(FF)V

    .line 577
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float/2addr v11, v10

    add-float/2addr v11, v8

    invoke-virtual {v1, v11, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 578
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    add-float/2addr v15, v8

    mul-float v17, v17, v10

    add-float v2, v9, v17

    invoke-virtual {v1, v15, v2}, Landroid/graphics/Path;->moveTo(FF)V

    .line 579
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v24, v24, v10

    add-float v3, v9, v24

    invoke-virtual {v1, v15, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 580
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v25, v25, v10

    add-float v9, v9, v25

    mul-float v10, v10, v26

    add-float/2addr v10, v8

    invoke-virtual {v1, v15, v9, v10, v9}, Landroid/graphics/Path;->quadTo(FFFF)V

    .line 581
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    add-float v4, v8, v24

    invoke-virtual {v1, v4, v9}, Landroid/graphics/Path;->lineTo(FF)V

    .line 582
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    add-float v8, v8, v25

    invoke-virtual {v1, v8, v9, v8, v3}, Landroid/graphics/Path;->quadTo(FFFF)V

    .line 583
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    invoke-virtual {v1, v8, v2}, Landroid/graphics/Path;->lineTo(FF)V

    .line 584
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v1, v2}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 585
    return-void

    .line 558
    :pswitch_220
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v27, v27, v10

    add-float v2, v8, v27

    mul-float/2addr v13, v10

    add-float/2addr v13, v9

    invoke-virtual {v1, v2, v13}, Landroid/graphics/Path;->moveTo(FF)V

    .line 559
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float/2addr v15, v10

    add-float v3, v9, v15

    invoke-virtual {v1, v2, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 560
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float/2addr v12, v10

    add-float/2addr v12, v8

    mul-float v16, v16, v10

    add-float v4, v9, v16

    invoke-virtual {v1, v12, v4}, Landroid/graphics/Path;->moveTo(FF)V

    .line 561
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    invoke-virtual {v1, v2, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 562
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float/2addr v11, v10

    add-float/2addr v11, v8

    invoke-virtual {v1, v11, v4}, Landroid/graphics/Path;->lineTo(FF)V

    .line 563
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    add-float/2addr v15, v8

    mul-float v17, v17, v10

    add-float v2, v9, v17

    invoke-virtual {v1, v15, v2}, Landroid/graphics/Path;->moveTo(FF)V

    .line 564
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v24, v24, v10

    add-float v3, v9, v24

    invoke-virtual {v1, v15, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 565
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v25, v25, v10

    add-float v9, v9, v25

    mul-float v10, v10, v26

    add-float/2addr v10, v8

    invoke-virtual {v1, v15, v9, v10, v9}, Landroid/graphics/Path;->quadTo(FFFF)V

    .line 566
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    add-float v4, v8, v24

    invoke-virtual {v1, v4, v9}, Landroid/graphics/Path;->lineTo(FF)V

    .line 567
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    add-float v8, v8, v25

    invoke-virtual {v1, v8, v9, v8, v3}, Landroid/graphics/Path;->quadTo(FFFF)V

    .line 568
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    invoke-virtual {v1, v8, v2}, Landroid/graphics/Path;->lineTo(FF)V

    .line 569
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v1, v2}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 570
    return-void

    .line 548
    :pswitch_284
    const v1, 0x3fb33333    # 1.4f

    mul-float/2addr v1, v10

    .line 549
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    mul-float v19, v19, v10

    add-float v3, v8, v19

    const v4, 0x40866666    # 4.2f

    mul-float/2addr v4, v10

    add-float/2addr v4, v9

    mul-float/2addr v14, v10

    add-float/2addr v8, v14

    const v5, 0x41033333    # 8.2f

    mul-float/2addr v5, v10

    add-float/2addr v5, v9

    invoke-virtual {v2, v3, v4, v8, v5}, Landroid/graphics/RectF;->set(FFFF)V

    .line 550
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    iget-object v4, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v2, v1, v1, v4}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 551
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    const/high16 v4, 0x41200000    # 10.0f

    mul-float/2addr v4, v10

    add-float/2addr v4, v9

    const/high16 v5, 0x41600000    # 14.0f

    mul-float/2addr v5, v10

    add-float/2addr v5, v9

    invoke-virtual {v2, v3, v4, v8, v5}, Landroid/graphics/RectF;->set(FFFF)V

    .line 552
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    iget-object v4, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v2, v1, v1, v4}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 553
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    const v4, 0x417ccccd    # 15.8f

    mul-float/2addr v4, v10

    add-float/2addr v4, v9

    const v5, 0x419e6666    # 19.8f

    mul-float/2addr v10, v5

    add-float/2addr v9, v10

    invoke-virtual {v2, v3, v4, v8, v9}, Landroid/graphics/RectF;->set(FFFF)V

    .line 554
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    iget-object v3, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v2, v1, v1, v3}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 555
    return-void

    .line 535
    :pswitch_2cf
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    mul-float v16, v16, v10

    add-float v2, v8, v16

    add-float v3, v9, v16

    mul-float v25, v25, v10

    add-float v4, v8, v25

    add-float v5, v9, v25

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/graphics/RectF;->set(FFFF)V

    .line 536
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    const v2, 0x400ccccd    # 2.2f

    mul-float/2addr v2, v10

    iget-object v3, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v1, v2, v2, v3}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 537
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v26, v26, v10

    add-float v2, v8, v26

    mul-float v17, v17, v10

    add-float v3, v9, v17

    invoke-virtual {v1, v2, v3}, Landroid/graphics/Path;->moveTo(FF)V

    .line 538
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v21, v21, v10

    add-float v4, v8, v21

    invoke-virtual {v1, v4, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 539
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v19, v19, v10

    add-float v4, v8, v19

    const/high16 v5, 0x41680000    # 14.5f

    mul-float/2addr v10, v5

    add-float v5, v9, v10

    invoke-virtual {v1, v4, v3, v4, v5}, Landroid/graphics/Path;->quadTo(FFFF)V

    .line 540
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    add-float v3, v9, v26

    invoke-virtual {v1, v4, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 541
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    add-float v9, v9, v19

    invoke-virtual {v1, v4, v9, v2, v9}, Landroid/graphics/Path;->quadTo(FFFF)V

    .line 542
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    add-float/2addr v10, v8

    invoke-virtual {v1, v10, v9}, Landroid/graphics/Path;->lineTo(FF)V

    .line 543
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    add-float v8, v8, v17

    invoke-virtual {v1, v8, v9, v8, v3}, Landroid/graphics/Path;->quadTo(FFFF)V

    .line 544
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v1, v2}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 545
    return-void

    .line 526
    :pswitch_332
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v27, v27, v10

    add-float v2, v8, v27

    mul-float/2addr v6, v10

    add-float/2addr v6, v9

    invoke-virtual {v1, v2, v6}, Landroid/graphics/Path;->moveTo(FF)V

    .line 527
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v20, v20, v10

    add-float v4, v9, v20

    invoke-virtual {v1, v2, v4}, Landroid/graphics/Path;->lineTo(FF)V

    .line 528
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v23, v23, v10

    add-float v5, v8, v23

    mul-float/2addr v3, v10

    add-float/2addr v9, v3

    invoke-virtual {v1, v5, v9}, Landroid/graphics/Path;->moveTo(FF)V

    .line 529
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    invoke-virtual {v1, v2, v4}, Landroid/graphics/Path;->lineTo(FF)V

    .line 530
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v10, v10, v22

    add-float/2addr v8, v10

    invoke-virtual {v1, v8, v9}, Landroid/graphics/Path;->lineTo(FF)V

    .line 531
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v1, v2}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 532
    return-void

    .line 517
    :pswitch_366
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v27, v27, v10

    add-float v2, v8, v27

    mul-float v20, v20, v10

    add-float v3, v9, v20

    invoke-virtual {v1, v2, v3}, Landroid/graphics/Path;->moveTo(FF)V

    .line 518
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float/2addr v6, v10

    add-float/2addr v6, v9

    invoke-virtual {v1, v2, v6}, Landroid/graphics/Path;->lineTo(FF)V

    .line 519
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v23, v23, v10

    add-float v3, v8, v23

    mul-float v18, v18, v10

    add-float v9, v9, v18

    invoke-virtual {v1, v3, v9}, Landroid/graphics/Path;->moveTo(FF)V

    .line 520
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    invoke-virtual {v1, v2, v6}, Landroid/graphics/Path;->lineTo(FF)V

    .line 521
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v10, v10, v22

    add-float/2addr v8, v10

    invoke-virtual {v1, v8, v9}, Landroid/graphics/Path;->lineTo(FF)V

    .line 522
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v1, v2}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 523
    return-void

    .line 506
    :pswitch_39c
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v17, v17, v10

    add-float v3, v8, v17

    mul-float v21, v21, v10

    add-float v4, v9, v21

    invoke-virtual {v1, v3, v4}, Landroid/graphics/Path;->moveTo(FF)V

    .line 507
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float/2addr v2, v10

    add-float v3, v8, v2

    mul-float v16, v16, v10

    add-float v4, v9, v16

    invoke-virtual {v1, v3, v4}, Landroid/graphics/Path;->lineTo(FF)V

    .line 508
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    add-float v3, v8, v16

    add-float/2addr v2, v9

    invoke-virtual {v1, v3, v2}, Landroid/graphics/Path;->lineTo(FF)V

    .line 509
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float/2addr v15, v10

    add-float/2addr v15, v8

    mul-float v25, v25, v10

    add-float v2, v9, v25

    invoke-virtual {v1, v15, v2}, Landroid/graphics/Path;->lineTo(FF)V

    .line 510
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    add-float v2, v8, v21

    add-float v3, v9, v17

    invoke-virtual {v1, v2, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 511
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    invoke-virtual {v1}, Landroid/graphics/Path;->close()V

    .line 512
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v1, v2}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 513
    const v1, 0x41533333    # 13.2f

    mul-float/2addr v1, v10

    add-float v2, v8, v1

    const v1, 0x40d9999a    # 6.8f

    mul-float/2addr v1, v10

    add-float v3, v9, v1

    const v1, 0x4189999a    # 17.2f

    mul-float/2addr v1, v10

    add-float v4, v8, v1

    const v1, 0x412ccccd    # 10.8f

    mul-float/2addr v10, v1

    add-float v5, v9, v10

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    move-object/from16 v1, p1

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 514
    return-void

    .line 494
    :pswitch_3fd
    const v1, 0x3fe66666    # 1.8f

    mul-float/2addr v1, v10

    .line 495
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    mul-float v19, v19, v10

    add-float v4, v8, v19

    add-float v5, v9, v19

    mul-float v18, v18, v10

    add-float v6, v8, v18

    add-float v11, v9, v18

    invoke-virtual {v2, v4, v5, v6, v11}, Landroid/graphics/RectF;->set(FFFF)V

    .line 496
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    iget-object v12, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v2, v1, v1, v12}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 497
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    mul-float/2addr v3, v10

    add-float v12, v8, v3

    mul-float/2addr v10, v14

    add-float/2addr v8, v10

    invoke-virtual {v2, v12, v5, v8, v11}, Landroid/graphics/RectF;->set(FFFF)V

    .line 498
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    iget-object v5, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v2, v1, v1, v5}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 499
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    add-float/2addr v3, v9

    add-float/2addr v9, v10

    invoke-virtual {v2, v4, v3, v6, v9}, Landroid/graphics/RectF;->set(FFFF)V

    .line 500
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    iget-object v4, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v2, v1, v1, v4}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 501
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    invoke-virtual {v2, v12, v3, v8, v9}, Landroid/graphics/RectF;->set(FFFF)V

    .line 502
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    iget-object v3, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v2, v1, v1, v3}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 503
    return-void

    .line 482
    :pswitch_445
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    const/high16 v2, 0x40200000    # 2.5f

    mul-float/2addr v2, v10

    add-float v3, v8, v2

    const/high16 v6, 0x40c00000    # 6.0f

    mul-float/2addr v6, v10

    add-float/2addr v6, v9

    const/high16 v11, 0x41ac0000    # 21.5f

    mul-float/2addr v11, v10

    add-float/2addr v11, v8

    const/high16 v12, 0x41900000    # 18.0f

    mul-float/2addr v12, v10

    add-float/2addr v12, v9

    invoke-virtual {v1, v3, v6, v11, v12}, Landroid/graphics/RectF;->set(FFFF)V

    .line 483
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mRect:Landroid/graphics/RectF;

    iget-object v3, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v1, v2, v2, v3}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 484
    const v1, 0x3f866666    # 1.05f

    mul-float/2addr v1, v10

    .line 485
    const v2, 0x41233333    # 10.2f

    mul-float/2addr v2, v10

    add-float v3, v9, v2

    .line 486
    mul-float v23, v23, v10

    add-float v6, v8, v23

    iget-object v11, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v6, v3, v1, v11}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 487
    add-float/2addr v2, v8

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v2, v3, v1, v6}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 488
    const v2, 0x415ccccd    # 13.8f

    mul-float/2addr v2, v10

    add-float/2addr v2, v8

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v2, v3, v1, v6}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 489
    mul-float v22, v22, v10

    add-float v2, v8, v22

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v2, v3, v1, v6}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 490
    mul-float/2addr v5, v10

    add-float v2, v8, v5

    const v1, 0x4164cccd    # 14.3f

    mul-float/2addr v1, v10

    add-float v5, v9, v1

    mul-float/2addr v10, v4

    add-float v4, v8, v10

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    move-object/from16 v1, p1

    move v3, v5

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 491
    return-void

    .line 473
    :pswitch_4a3
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v20, v20, v10

    add-float v2, v8, v20

    mul-float v27, v27, v10

    add-float v3, v9, v27

    invoke-virtual {v1, v2, v3}, Landroid/graphics/Path;->moveTo(FF)V

    .line 474
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float/2addr v6, v10

    add-float/2addr v6, v8

    invoke-virtual {v1, v6, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 475
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    const/high16 v2, 0x41380000    # 11.5f

    mul-float/2addr v2, v10

    add-float/2addr v8, v2

    mul-float v26, v26, v10

    add-float v2, v9, v26

    invoke-virtual {v1, v8, v2}, Landroid/graphics/Path;->moveTo(FF)V

    .line 476
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    invoke-virtual {v1, v6, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 477
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    mul-float v10, v10, v24

    add-float/2addr v9, v10

    invoke-virtual {v1, v8, v9}, Landroid/graphics/Path;->lineTo(FF)V

    .line 478
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mPath:Landroid/graphics/Path;

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v1, v2}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 479
    return-void

    .line 465
    :pswitch_4d9
    const v1, 0x3ff9999a    # 1.95f

    mul-float/2addr v1, v10

    .line 466
    mul-float v27, v27, v10

    add-float v8, v8, v27

    .line 467
    mul-float v26, v26, v10

    add-float v2, v9, v26

    iget-object v3, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v8, v2, v1, v3}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 468
    add-float v2, v9, v27

    iget-object v3, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v8, v2, v1, v3}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 469
    mul-float v10, v10, v24

    add-float/2addr v9, v10

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v8, v9, v1, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 470
    return-void

    :pswitch_data_4fa
    .packed-switch 0x1
        :pswitch_4d9
        :pswitch_4a3
        :pswitch_445
        :pswitch_3fd
        :pswitch_39c
        :pswitch_366
        :pswitch_332
        :pswitch_2cf
        :pswitch_284
        :pswitch_220
        :pswitch_1bc
        :pswitch_17a
        :pswitch_ce
        :pswitch_b1
        :pswitch_5d
    .end packed-switch
.end method

.method public getIntrinsicHeight()I
    .registers 2

    .line 451
    iget v0, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mSizePx:I

    return v0
.end method

.method public getIntrinsicWidth()I
    .registers 2

    .line 446
    iget v0, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mSizePx:I

    return v0
.end method

.method public getOpacity()I
    .registers 2

    .line 646
    const/4 v0, -0x3

    return v0
.end method

.method public setAlpha(I)V
    .registers 3

    .line 634
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setAlpha(I)V

    .line 635
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setAlpha(I)V

    .line 636
    return-void
.end method

.method public setColor(I)V
    .registers 3

    .line 437
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getColor()I

    move-result v0

    if-eq v0, p1, :cond_15

    .line 438
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    .line 439
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    .line 440
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->invalidateSelf()V

    .line 442
    :cond_15
    return-void
.end method

.method public setColorFilter(Landroid/graphics/ColorFilter;)V
    .registers 3

    .line 640
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    .line 641
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetUi$IconDrawable;->mFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    .line 642
    return-void
.end method
