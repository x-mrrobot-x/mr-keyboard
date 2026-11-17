.class final Lcom/mrkeyboard/app/MrRain;
.super Ljava/lang/Object;
.source "MrRain.java"


# static fields
.field static final PERIOD_MAX:I = 0x3

.field static final TRAIL_MAX:I = 0x16

.field static final TRAIL_MIN:I = 0x6


# instance fields
.field private cols:I

.field private count:[I

.field private glyph:[I

.field private final glyphs:I

.field private head:[I

.field private len:[I

.field private period:[I

.field private final rnd:Ljava/util/Random;

.field private rows:I


# direct methods
.method constructor <init>(IJ)V
    .locals 2

    .prologue
    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    const/4 v0, 0x1

    invoke-static {v0, p1}, Ljava/lang/Math;->max(II)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrRain;->glyphs:I

    .line 35
    new-instance v0, Ljava/util/Random;

    invoke-direct {v0, p2, p3}, Ljava/util/Random;-><init>(J)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRain;->rnd:Ljava/util/Random;

    .line 36
    return-void
.end method

.method private launch(I)V
    .locals 5

    .prologue
    const/4 v4, 0x1

    .line 60
    const/16 v0, 0x16

    iget v1, p0, Lcom/mrkeyboard/app/MrRain;->rows:I

    add-int/lit8 v1, v1, -0x1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-static {v4, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 61
    const/4 v1, 0x6

    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 62
    iget-object v2, p0, Lcom/mrkeyboard/app/MrRain;->len:[I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrRain;->rnd:Ljava/util/Random;

    sub-int/2addr v0, v1

    add-int/lit8 v0, v0, 0x1

    invoke-virtual {v3, v0}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    add-int/2addr v0, v1

    aput v0, v2, p1

    .line 63
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRain;->period:[I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrRain;->rnd:Ljava/util/Random;

    const/4 v2, 0x3

    invoke-virtual {v1, v2}, Ljava/util/Random;->nextInt(I)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    aput v1, v0, p1

    .line 64
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRain;->count:[I

    const/4 v1, 0x0

    aput v1, v0, p1

    .line 65
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRain;->head:[I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrRain;->rnd:Ljava/util/Random;

    iget v2, p0, Lcom/mrkeyboard/app/MrRain;->rows:I

    div-int/lit8 v2, v2, 0x2

    add-int/lit8 v2, v2, 0x1

    invoke-static {v4, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/util/Random;->nextInt(I)I

    move-result v1

    neg-int v1, v1

    aput v1, v0, p1

    .line 66
    return-void
.end method


# virtual methods
.method cols()I
    .locals 1

    .prologue
    .line 38
    iget v0, p0, Lcom/mrkeyboard/app/MrRain;->cols:I

    return v0
.end method

.method first(I)I
    .locals 3

    .prologue
    .line 81
    const/4 v0, 0x0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrRain;->head:[I

    aget v1, v1, p1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrRain;->len:[I

    aget v2, v2, p1

    sub-int/2addr v1, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    return v0
.end method

.method glyphAt(II)I
    .locals 2

    .prologue
    .line 87
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRain;->glyph:[I

    iget v1, p0, Lcom/mrkeyboard/app/MrRain;->rows:I

    mul-int/2addr v1, p1

    add-int/2addr v1, p2

    aget v0, v0, v1

    return v0
.end method

.method last(I)I
    .locals 2

    .prologue
    .line 84
    iget v0, p0, Lcom/mrkeyboard/app/MrRain;->rows:I

    add-int/lit8 v0, v0, -0x1

    iget-object v1, p0, Lcom/mrkeyboard/app/MrRain;->head:[I

    aget v1, v1, p1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    return v0
.end method

.method level(II)F
    .locals 3

    .prologue
    const/high16 v0, 0x3f800000    # 1.0f

    .line 91
    iget-object v1, p0, Lcom/mrkeyboard/app/MrRain;->head:[I

    aget v1, v1, p1

    sub-int/2addr v1, p2

    .line 92
    if-ltz v1, :cond_0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrRain;->len:[I

    aget v2, v2, p1

    if-le v1, v2, :cond_2

    :cond_0
    const/4 v0, 0x0

    .line 94
    :cond_1
    :goto_0
    return v0

    .line 93
    :cond_2
    if-eqz v1, :cond_1

    .line 94
    int-to-float v1, v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrRain;->len:[I

    aget v2, v2, p1

    add-int/lit8 v2, v2, 0x1

    int-to-float v2, v2

    div-float/2addr v1, v2

    sub-float/2addr v0, v1

    goto :goto_0
.end method

.method resize(II)V
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 44
    invoke-static {v1, p1}, Ljava/lang/Math;->max(II)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrRain;->cols:I

    .line 45
    invoke-static {v1, p2}, Ljava/lang/Math;->max(II)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrRain;->rows:I

    .line 46
    iget v0, p0, Lcom/mrkeyboard/app/MrRain;->cols:I

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRain;->head:[I

    .line 47
    iget v0, p0, Lcom/mrkeyboard/app/MrRain;->cols:I

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRain;->len:[I

    .line 48
    iget v0, p0, Lcom/mrkeyboard/app/MrRain;->cols:I

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRain;->period:[I

    .line 49
    iget v0, p0, Lcom/mrkeyboard/app/MrRain;->cols:I

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRain;->count:[I

    .line 50
    iget v0, p0, Lcom/mrkeyboard/app/MrRain;->cols:I

    iget v2, p0, Lcom/mrkeyboard/app/MrRain;->rows:I

    mul-int/2addr v0, v2

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRain;->glyph:[I

    move v0, v1

    .line 51
    :goto_0
    iget v2, p0, Lcom/mrkeyboard/app/MrRain;->cols:I

    if-ge v0, v2, :cond_0

    .line 52
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrRain;->launch(I)V

    .line 53
    iget-object v2, p0, Lcom/mrkeyboard/app/MrRain;->head:[I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrRain;->rnd:Ljava/util/Random;

    const/4 v4, 0x1

    iget v5, p0, Lcom/mrkeyboard/app/MrRain;->rows:I

    iget-object v6, p0, Lcom/mrkeyboard/app/MrRain;->len:[I

    aget v6, v6, v0

    add-int/2addr v5, v6

    invoke-static {v4, v5}, Ljava/lang/Math;->max(II)I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/util/Random;->nextInt(I)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrRain;->len:[I

    aget v4, v4, v0

    sub-int/2addr v3, v4

    aput v3, v2, v0

    .line 51
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 55
    :cond_0
    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRain;->glyph:[I

    array-length v0, v0

    if-ge v1, v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrRain;->glyph:[I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrRain;->rnd:Ljava/util/Random;

    iget v3, p0, Lcom/mrkeyboard/app/MrRain;->glyphs:I

    invoke-virtual {v2, v3}, Ljava/util/Random;->nextInt(I)I

    move-result v2

    aput v2, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 56
    :cond_1
    return-void
.end method

.method rows()I
    .locals 1

    .prologue
    .line 40
    iget v0, p0, Lcom/mrkeyboard/app/MrRain;->rows:I

    return v0
.end method

.method step()V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 70
    move v0, v1

    :goto_0
    iget v2, p0, Lcom/mrkeyboard/app/MrRain;->cols:I

    if-ge v0, v2, :cond_2

    .line 71
    iget-object v2, p0, Lcom/mrkeyboard/app/MrRain;->count:[I

    aget v3, v2, v0

    add-int/lit8 v3, v3, 0x1

    aput v3, v2, v0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrRain;->period:[I

    aget v2, v2, v0

    if-ge v3, v2, :cond_1

    .line 70
    :cond_0
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 72
    :cond_1
    iget-object v2, p0, Lcom/mrkeyboard/app/MrRain;->count:[I

    aput v1, v2, v0

    .line 73
    iget-object v2, p0, Lcom/mrkeyboard/app/MrRain;->head:[I

    aget v3, v2, v0

    add-int/lit8 v3, v3, 0x1

    aput v3, v2, v0

    .line 74
    iget-object v2, p0, Lcom/mrkeyboard/app/MrRain;->head:[I

    aget v2, v2, v0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrRain;->len:[I

    aget v3, v3, v0

    sub-int/2addr v2, v3

    iget v3, p0, Lcom/mrkeyboard/app/MrRain;->rows:I

    if-lt v2, v3, :cond_0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrRain;->launch(I)V

    goto :goto_1

    .line 76
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrRain;->cols:I

    iget v1, p0, Lcom/mrkeyboard/app/MrRain;->rows:I

    mul-int/2addr v1, v0

    .line 77
    div-int/lit8 v0, v1, 0x28

    add-int/lit8 v0, v0, 0x1

    :goto_2
    if-lez v1, :cond_3

    if-lez v0, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrRain;->glyph:[I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrRain;->rnd:Ljava/util/Random;

    invoke-virtual {v3, v1}, Ljava/util/Random;->nextInt(I)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrRain;->rnd:Ljava/util/Random;

    iget v5, p0, Lcom/mrkeyboard/app/MrRain;->glyphs:I

    invoke-virtual {v4, v5}, Ljava/util/Random;->nextInt(I)I

    move-result v4

    aput v4, v2, v3

    add-int/lit8 v0, v0, -0x1

    goto :goto_2

    .line 78
    :cond_3
    return-void
.end method
