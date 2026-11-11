.class final Lcom/mrkeyboard/app/MrLabelMetricsCache;
.super Ljava/lang/Object;
.field private texts:[Ljava/lang/String;
.field private paints:[Landroid/graphics/Paint;
.field private offsets:[F
.field private next:I
.field private rect:Landroid/graphics/Rect;
.method public constructor <init>()V
 .locals 2
 invoke-direct {p0}, Ljava/lang/Object;-><init>()V
 const/16 v0, 0x80
 new-array v1, v0, [Ljava/lang/String;
 iput-object v1, p0, Lcom/mrkeyboard/app/MrLabelMetricsCache;->texts:[Ljava/lang/String;
 new-array v1, v0, [Landroid/graphics/Paint;
 iput-object v1, p0, Lcom/mrkeyboard/app/MrLabelMetricsCache;->paints:[Landroid/graphics/Paint;
 new-array v1, v0, [F
 iput-object v1, p0, Lcom/mrkeyboard/app/MrLabelMetricsCache;->offsets:[F
 new-instance v0, Landroid/graphics/Rect;
 invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V
 iput-object v0, p0, Lcom/mrkeyboard/app/MrLabelMetricsCache;->rect:Landroid/graphics/Rect;
 return-void
.end method
.method public offset(Landroid/graphics/Paint;Ljava/lang/String;)F
    .locals 8

    const/4 v0, 0x0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLabelMetricsCache;->texts:[Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLabelMetricsCache;->paints:[Landroid/graphics/Paint;

    :goto_0
    const/16 v3, 0x80

    if-ge v0, v3, :cond_1

    aget-object v3, v1, v0

    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    aget-object v3, v2, v0

    invoke-static {p1, v3}, Lcom/mrkeyboard/app/MrLabelMetricsCache;->samePaint(Landroid/graphics/Paint;Landroid/graphics/Paint;)Z

    move-result v3

    if-eqz v3, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLabelMetricsCache;->offsets:[F

    aget v0, v1, v0

    return v0

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    iget-object v3, p0, Lcom/mrkeyboard/app/MrLabelMetricsCache;->rect:Landroid/graphics/Rect;

    const/4 v4, 0x0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {p1, p2, v4, v5, v3}, Landroid/graphics/Paint;->getTextBounds(Ljava/lang/String;IILandroid/graphics/Rect;)V

    iget v4, v3, Landroid/graphics/Rect;->top:I

    iget v5, v3, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v4, v5

    int-to-float v4, v4

    const/high16 v5, 0x40000000    # 2.0f

    div-float/2addr v4, v5

    iget v0, p0, Lcom/mrkeyboard/app/MrLabelMetricsCache;->next:I

    aput-object p2, v1, v0

    new-instance v3, Landroid/graphics/Paint;

    invoke-direct {v3, p1}, Landroid/graphics/Paint;-><init>(Landroid/graphics/Paint;)V

    aput-object v3, v2, v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLabelMetricsCache;->offsets:[F

    aput v4, v1, v0

    add-int/lit8 v0, v0, 0x1

    and-int/lit8 v0, v0, 0x7f

    iput v0, p0, Lcom/mrkeyboard/app/MrLabelMetricsCache;->next:I

    return v4
.end method
.method private static samePaint(Landroid/graphics/Paint;Landroid/graphics/Paint;)Z
 .locals 3
 sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
 const/16 v1, 0x1c
 if-lt v0, v1, :legacy
 invoke-virtual {p0, p1}, Landroid/graphics/Paint;->equalsForTextMeasurement(Landroid/graphics/Paint;)Z
 move-result v0
 return v0
 :legacy
 invoke-virtual {p0}, Landroid/graphics/Paint;->getTextSize()F
 move-result v0
 invoke-virtual {p1}, Landroid/graphics/Paint;->getTextSize()F
 move-result v1
 cmpl-float v2, v0, v1
 if-nez v2, :different
 invoke-virtual {p0}, Landroid/graphics/Paint;->getTextScaleX()F
 move-result v0
 invoke-virtual {p1}, Landroid/graphics/Paint;->getTextScaleX()F
 move-result v1
 cmpl-float v2, v0, v1
 if-nez v2, :different
 invoke-virtual {p0}, Landroid/graphics/Paint;->getTextSkewX()F
 move-result v0
 invoke-virtual {p1}, Landroid/graphics/Paint;->getTextSkewX()F
 move-result v1
 cmpl-float v2, v0, v1
 if-nez v2, :different
 invoke-virtual {p0}, Landroid/graphics/Paint;->getLetterSpacing()F
 move-result v0
 invoke-virtual {p1}, Landroid/graphics/Paint;->getLetterSpacing()F
 move-result v1
 cmpl-float v2, v0, v1
 if-nez v2, :different
 invoke-virtual {p0}, Landroid/graphics/Paint;->getFlags()I
 move-result v0
 invoke-virtual {p1}, Landroid/graphics/Paint;->getFlags()I
 move-result v1
 if-ne v0, v1, :different
 invoke-virtual {p0}, Landroid/graphics/Paint;->getHinting()I
 move-result v0
 invoke-virtual {p1}, Landroid/graphics/Paint;->getHinting()I
 move-result v1
 if-ne v0, v1, :different
 invoke-virtual {p0}, Landroid/graphics/Paint;->isElegantTextHeight()Z
 move-result v0
 invoke-virtual {p1}, Landroid/graphics/Paint;->isElegantTextHeight()Z
 move-result v1
 if-ne v0, v1, :different
 invoke-virtual {p0}, Landroid/graphics/Paint;->getTypeface()Landroid/graphics/Typeface;
 move-result-object v0
 invoke-virtual {p1}, Landroid/graphics/Paint;->getTypeface()Landroid/graphics/Typeface;
 move-result-object v1
 invoke-static {v0, v1}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z
 move-result v0
 if-eqz v0, :different
 invoke-virtual {p0}, Landroid/graphics/Paint;->getTextLocales()Landroid/os/LocaleList;
 move-result-object v0
 invoke-virtual {p1}, Landroid/graphics/Paint;->getTextLocales()Landroid/os/LocaleList;
 move-result-object v1
 invoke-static {v0, v1}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z
 move-result v0
 if-eqz v0, :different
 invoke-virtual {p0}, Landroid/graphics/Paint;->getFontFeatureSettings()Ljava/lang/String;
 move-result-object v0
 invoke-virtual {p1}, Landroid/graphics/Paint;->getFontFeatureSettings()Ljava/lang/String;
 move-result-object v1
 invoke-static {v0, v1}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z
 move-result v0
 if-eqz v0, :different
 invoke-virtual {p0}, Landroid/graphics/Paint;->getFontVariationSettings()Ljava/lang/String;
 move-result-object v0
 invoke-virtual {p1}, Landroid/graphics/Paint;->getFontVariationSettings()Ljava/lang/String;
 move-result-object v1
 invoke-static {v0, v1}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z
 move-result v0
 if-eqz v0, :different
 const/4 v0, 0x1
 return v0
 :different
 const/4 v0, 0x0
 return v0
.end method
