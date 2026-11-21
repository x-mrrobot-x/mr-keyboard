.class final Lcom/mrkeyboard/app/MrAdapt$Tone;
.super Ljava/lang/Object;
.source "MrAdapt.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAdapt;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Tone"
.end annotation


# static fields
.field static final OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;


# instance fields
.field final hue:F

.field private mSeeFilter:Landroid/graphics/ColorFilter;

.field final on:Z

.field final pale:Z

.field final sat:F

.field final see:[F

.field final spectrum:Z

.field final tint:F

.field final under:I


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .prologue
    const/4 v1, 0x0

    const/4 v4, 0x0

    .line 97
    new-instance v0, Lcom/mrkeyboard/app/MrAdapt$Tone;

    const/4 v7, 0x0

    move v2, v1

    move v3, v1

    move v5, v4

    move v6, v4

    move v8, v4

    invoke-direct/range {v0 .. v8}, Lcom/mrkeyboard/app/MrAdapt$Tone;-><init>(FFFZZZ[FI)V

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;

    return-void
.end method

.method private constructor <init>(FFFZZZ[FI)V
    .locals 0

    .prologue
    .line 112
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 113
    iput p1, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->hue:F

    .line 114
    iput p2, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->sat:F

    .line 115
    iput p3, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->tint:F

    .line 116
    iput-boolean p4, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->pale:Z

    .line 117
    iput-boolean p5, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->on:Z

    .line 118
    iput-boolean p6, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->spectrum:Z

    .line 119
    iput-object p7, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->see:[F

    .line 120
    iput p8, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->under:I

    .line 121
    return-void
.end method

.method static of(IZZZI)Lcom/mrkeyboard/app/MrAdapt$Tone;
    .locals 10

    .prologue
    const/high16 v4, 0x3f800000    # 1.0f

    const/4 v5, 0x1

    const/4 v9, 0x0

    const/high16 v8, 0x437f0000    # 255.0f

    const/4 v6, 0x0

    .line 128
    const/4 v0, 0x3

    new-array v1, v0, [F

    .line 129
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 130
    aget v0, v1, v5

    invoke-static {v4, v0}, Ljava/lang/Math;->min(FF)F

    move-result v3

    .line 131
    const/4 v7, 0x0

    .line 132
    if-eqz p3, :cond_0

    if-nez p1, :cond_0

    cmpl-float v0, v3, v6

    if-lez v0, :cond_0

    .line 133
    aget v0, v1, v9

    const v2, 0x3e99999a    # 0.3f

    mul-float/2addr v2, v3

    invoke-static {v0, v2, v4}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v0

    .line 134
    const/16 v2, 0x9

    new-array v7, v2, [F

    shr-int/lit8 v2, v0, 0x10

    and-int/lit16 v2, v2, 0xff

    int-to-float v2, v2

    div-float/2addr v2, v8

    aput v2, v7, v9

    aput v6, v7, v5

    const/4 v2, 0x2

    aput v6, v7, v2

    const/4 v2, 0x3

    aput v6, v7, v2

    const/4 v2, 0x4

    shr-int/lit8 v4, v0, 0x8

    and-int/lit16 v4, v4, 0xff

    int-to-float v4, v4

    div-float/2addr v4, v8

    aput v4, v7, v2

    const/4 v2, 0x5

    aput v6, v7, v2

    const/4 v2, 0x6

    aput v6, v7, v2

    const/4 v2, 0x7

    aput v6, v7, v2

    const/16 v2, 0x8

    and-int/lit16 v0, v0, 0xff

    int-to-float v0, v0

    div-float/2addr v0, v8

    aput v0, v7, v2

    .line 136
    :cond_0
    new-instance v0, Lcom/mrkeyboard/app/MrAdapt$Tone;

    aget v1, v1, v9

    const v2, 0x3f266666    # 0.65f

    mul-float/2addr v2, v3

    move v4, p1

    move v6, p2

    move v8, p4

    invoke-direct/range {v0 .. v8}, Lcom/mrkeyboard/app/MrAdapt$Tone;-><init>(FFFZZZ[FI)V

    return-object v0
.end method


# virtual methods
.method adapt(Ljava/lang/String;I)I
    .locals 3

    .prologue
    .line 187
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->on:Z

    if-eqz v0, :cond_0

    if-nez p1, :cond_1

    .line 192
    :cond_0
    :goto_0
    return p2

    .line 188
    :cond_1
    invoke-static {p1}, Lcom/mrkeyboard/app/MrAdapt;->access$000(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p0, p2}, Lcom/mrkeyboard/app/MrAdapt$Tone;->ink(I)I

    move-result p2

    goto :goto_0

    .line 189
    :cond_2
    const-string v0, "modifier_indicator_off"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "modifier_indicator_on"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    :cond_3
    invoke-virtual {p0, p2}, Lcom/mrkeyboard/app/MrAdapt$Tone;->dash(I)I

    move-result p2

    goto :goto_0

    .line 190
    :cond_4
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->pale:Z

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrAdapt;->access$100(Ljava/lang/String;Z)F

    move-result v0

    .line 191
    const/4 v1, 0x0

    cmpg-float v1, v0, v1

    if-lez v1, :cond_0

    .line 192
    iget v1, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->hue:F

    iget v2, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->sat:F

    invoke-static {p2, v1, v2, v0}, Lcom/mrkeyboard/app/MrAdapt;->retint(IFFF)I

    move-result p2

    goto :goto_0
.end method

.method dash(I)I
    .locals 3

    .prologue
    .line 178
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->on:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->spectrum:Z

    if-nez v0, :cond_0

    ushr-int/lit8 v0, p1, 0x18

    if-nez v0, :cond_1

    :cond_0
    move v0, p1

    .line 179
    :goto_0
    return v0

    :cond_1
    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/MrAdapt$Tone;->neutral(I)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/MrAdapt$Tone;->ink(I)I

    move-result v0

    goto :goto_0

    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->hue:F

    iget v1, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->sat:F

    const v2, 0x3f59999a    # 0.85f

    invoke-static {p1, v0, v1, v2}, Lcom/mrkeyboard/app/MrAdapt;->retint(IFFF)I

    move-result v0

    goto :goto_0
.end method

.method ink(I)I
    .locals 4

    .prologue
    .line 152
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->on:Z

    if-eqz v0, :cond_0

    ushr-int/lit8 v0, p1, 0x18

    if-nez v0, :cond_1

    .line 163
    :cond_0
    :goto_0
    return p1

    .line 153
    :cond_1
    const/4 v0, 0x3

    new-array v0, v0, [F

    .line 154
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 155
    const/4 v1, 0x1

    aget v1, v0, v1

    const v2, 0x3e0f5c29    # 0.14f

    cmpl-float v1, v1, v2

    if-gtz v1, :cond_0

    .line 156
    const/4 v1, 0x2

    aget v0, v0, v1

    .line 157
    const/high16 v1, 0x3f000000    # 0.5f

    cmpl-float v1, v0, v1

    if-ltz v1, :cond_2

    .line 158
    iget v1, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->tint:F

    const v2, 0x3e6147ae    # 0.22f

    mul-float/2addr v1, v2

    .line 163
    :goto_1
    const/high16 v2, -0x1000000

    and-int/2addr v2, p1

    iget v3, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->hue:F

    invoke-static {v3, v1, v0}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v0

    const v1, 0xffffff

    and-int/2addr v0, v1

    or-int p1, v2, v0

    goto :goto_0

    .line 160
    :cond_2
    iget v1, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->tint:F

    const v2, 0x3f266666    # 0.65f

    mul-float/2addr v1, v2

    .line 161
    const v2, 0x3e23d70a    # 0.16f

    invoke-static {v0, v2}, Ljava/lang/Math;->max(FF)F

    move-result v0

    goto :goto_1
.end method

.method neutral(I)Z
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 168
    const/4 v1, 0x3

    new-array v1, v1, [F

    .line 169
    invoke-static {p1, v1}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 170
    aget v1, v1, v0

    const v2, 0x3e0f5c29    # 0.14f

    cmpg-float v1, v1, v2

    if-gtz v1, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method declared-synchronized seeFilter()Landroid/graphics/ColorFilter;
    .locals 1

    .prologue
    .line 141
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->see:[F
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 143
    :goto_0
    monitor-exit p0

    return-object v0

    .line 142
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->mSeeFilter:Landroid/graphics/ColorFilter;

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->see:[F

    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->filter([F)Landroid/graphics/ColorFilter;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->mSeeFilter:Landroid/graphics/ColorFilter;

    .line 143
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->mSeeFilter:Landroid/graphics/ColorFilter;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 141
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
