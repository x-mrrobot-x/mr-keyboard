.class final Lcom/mrkeyboard/app/MrPalette;
.super Ljava/lang/Object;
.source "MrPalette.java"


# static fields
.field private static final CLUSTERS:I = 0xc

.field static final COUNT:I = 0x5

.field private static final DARK_VALUE:F = 0.26f

.field private static final DISTANCES:[I

.field static final HEIGHT:I = 0x30

.field private static final HUE_STEP:F = 36.0f

.field private static final MIN_VALUE:F = 0.4f

.field private static final ROUNDS:I = 0x6

.field static final WIDTH:I = 0x60


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 28
    const/4 v0, 0x3

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/mrkeyboard/app/MrPalette;->DISTANCES:[I

    return-void

    nop

    :array_0
    .array-data 4
        0x48
        0x30
        0x24
    .end array-data
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    return-void
.end method

.method private static clamp(I)I
    .locals 1

    .prologue
    const/16 v0, 0xff

    .line 303
    if-gez p0, :cond_1

    const/4 p0, 0x0

    :cond_0
    :goto_0
    return p0

    :cond_1
    if-le p0, v0, :cond_0

    move p0, v0

    goto :goto_0
.end method

.method static dark(I)I
    .locals 6

    .prologue
    const/high16 v5, -0x1000000

    .line 293
    shr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    shr-int/lit8 v1, p0, 0x8

    and-int/lit16 v1, v1, 0xff

    and-int/lit16 v2, p0, 0xff

    .line 294
    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-static {v0, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    .line 295
    const v4, 0x42849999    # 66.299995f

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    .line 296
    if-gtz v3, :cond_0

    shl-int/lit8 v0, v4, 0x10

    or-int/2addr v0, v5

    shl-int/lit8 v1, v4, 0x8

    or-int/2addr v0, v1

    or-int/2addr v0, v4

    .line 299
    :goto_0
    return v0

    .line 297
    :cond_0
    if-gt v3, v4, :cond_1

    shl-int/lit8 v0, v0, 0x10

    or-int/2addr v0, v5

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    or-int/2addr v0, v2

    goto :goto_0

    .line 298
    :cond_1
    int-to-float v4, v4

    int-to-float v3, v3

    div-float v3, v4, v3

    .line 299
    int-to-float v0, v0

    mul-float/2addr v0, v3

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPalette;->clamp(I)I

    move-result v0

    shl-int/lit8 v0, v0, 0x10

    or-int/2addr v0, v5

    int-to-float v1, v1

    mul-float/2addr v1, v3

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPalette;->clamp(I)I

    move-result v1

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    int-to-float v1, v2

    mul-float/2addr v1, v3

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPalette;->clamp(I)I

    move-result v1

    or-int/2addr v0, v1

    goto :goto_0
.end method

.method private static dist2(FFFFFF)F
    .locals 3

    .prologue
    .line 227
    sub-float v0, p0, p3

    sub-float v1, p1, p4

    sub-float v2, p2, p5

    .line 228
    mul-float/2addr v0, v0

    mul-float/2addr v1, v1

    add-float/2addr v0, v1

    mul-float v1, v2, v2

    add-float/2addr v0, v1

    return v0
.end method

.method static extract([II)[I
    .locals 23

    .prologue
    .line 93
    if-eqz p0, :cond_0

    if-gtz p1, :cond_1

    :cond_0
    const/4 v1, 0x0

    new-array v1, v1, [I

    .line 181
    :goto_0
    return-object v1

    .line 94
    :cond_1
    const/16 v1, 0x1000

    new-array v7, v1, [I

    .line 95
    const/16 v1, 0x1000

    new-array v8, v1, [F

    const/16 v1, 0x1000

    new-array v9, v1, [F

    const/16 v1, 0x1000

    new-array v10, v1, [F

    .line 96
    const/4 v2, 0x0

    .line 97
    const/4 v1, 0x0

    move v11, v2

    :goto_1
    move-object/from16 v0, p0

    array-length v2, v0

    if-ge v1, v2, :cond_3

    .line 98
    aget v2, p0, v1

    .line 99
    ushr-int/lit8 v3, v2, 0x18

    const/16 v4, 0x80

    if-ge v3, v4, :cond_2

    move v2, v11

    .line 97
    :goto_2
    add-int/lit8 v1, v1, 0x1

    move v11, v2

    goto :goto_1

    .line 100
    :cond_2
    shr-int/lit8 v3, v2, 0x14

    and-int/lit8 v3, v3, 0xf

    shl-int/lit8 v3, v3, 0x8

    shr-int/lit8 v4, v2, 0xc

    and-int/lit8 v4, v4, 0xf

    shl-int/lit8 v4, v4, 0x4

    or-int/2addr v3, v4

    shr-int/lit8 v4, v2, 0x4

    and-int/lit8 v4, v4, 0xf

    or-int/2addr v3, v4

    .line 101
    aget v4, v7, v3

    add-int/lit8 v4, v4, 0x1

    aput v4, v7, v3

    .line 102
    aget v4, v8, v3

    shr-int/lit8 v5, v2, 0x10

    and-int/lit16 v5, v5, 0xff

    int-to-float v5, v5

    add-float/2addr v4, v5

    aput v4, v8, v3

    .line 103
    aget v4, v9, v3

    shr-int/lit8 v5, v2, 0x8

    and-int/lit16 v5, v5, 0xff

    int-to-float v5, v5

    add-float/2addr v4, v5

    aput v4, v9, v3

    .line 104
    aget v4, v10, v3

    and-int/lit16 v2, v2, 0xff

    int-to-float v2, v2

    add-float/2addr v2, v4

    aput v2, v10, v3

    .line 105
    add-int/lit8 v2, v11, 0x1

    goto :goto_2

    .line 107
    :cond_3
    if-nez v11, :cond_4

    const/4 v1, 0x0

    new-array v1, v1, [I

    goto :goto_0

    .line 108
    :cond_4
    const/4 v12, 0x0

    .line 109
    const/4 v1, 0x0

    move v2, v1

    :goto_3
    const/16 v1, 0x1000

    if-ge v2, v1, :cond_5

    .line 110
    aget v1, v7, v2

    if-lez v1, :cond_16

    add-int/lit8 v1, v12, 0x1

    .line 109
    :goto_4
    add-int/lit8 v2, v2, 0x1

    move v12, v1

    goto :goto_3

    .line 112
    :cond_5
    new-array v1, v12, [F

    new-array v2, v12, [F

    new-array v3, v12, [F

    new-array v4, v12, [F

    .line 113
    const/4 v6, 0x0

    .line 114
    const/4 v5, 0x0

    move/from16 v22, v5

    move v5, v6

    move/from16 v6, v22

    :goto_5
    const/16 v13, 0x1000

    if-ge v6, v13, :cond_7

    .line 115
    aget v13, v7, v6

    if-nez v13, :cond_6

    .line 114
    :goto_6
    add-int/lit8 v6, v6, 0x1

    goto :goto_5

    .line 116
    :cond_6
    aget v13, v8, v6

    aget v14, v7, v6

    int-to-float v14, v14

    div-float/2addr v13, v14

    aput v13, v1, v5

    .line 117
    aget v13, v9, v6

    aget v14, v7, v6

    int-to-float v14, v14

    div-float/2addr v13, v14

    aput v13, v2, v5

    .line 118
    aget v13, v10, v6

    aget v14, v7, v6

    int-to-float v14, v14

    div-float/2addr v13, v14

    aput v13, v3, v5

    .line 119
    aget v13, v7, v6

    int-to-float v13, v13

    aput v13, v4, v5

    .line 120
    add-int/lit8 v5, v5, 0x1

    goto :goto_6

    .line 122
    :cond_7
    const/16 v5, 0xc

    invoke-static {v5, v12}, Ljava/lang/Math;->min(II)I

    move-result v15

    .line 123
    new-array v5, v15, [F

    new-array v6, v15, [F

    new-array v7, v15, [F

    .line 124
    invoke-static/range {v1 .. v7}, Lcom/mrkeyboard/app/MrPalette;->seed([F[F[F[F[F[F[F)V

    .line 125
    new-array v0, v12, [I

    move-object/from16 v16, v0

    .line 126
    new-array v9, v15, [F

    .line 127
    const/4 v8, 0x0

    move v14, v8

    move-object v8, v9

    :goto_7
    const/4 v9, 0x6

    if-ge v14, v9, :cond_c

    .line 128
    const/4 v8, 0x0

    move v13, v8

    :goto_8
    if-ge v13, v12, :cond_8

    aget v8, v1, v13

    aget v9, v2, v13

    aget v10, v3, v13

    invoke-static/range {v5 .. v10}, Lcom/mrkeyboard/app/MrPalette;->nearest([F[F[FFFF)I

    move-result v8

    aput v8, v16, v13

    add-int/lit8 v8, v13, 0x1

    move v13, v8

    goto :goto_8

    .line 129
    :cond_8
    new-array v10, v15, [F

    new-array v13, v15, [F

    new-array v0, v15, [F

    move-object/from16 v17, v0

    .line 130
    new-array v9, v15, [F

    .line 131
    const/4 v8, 0x0

    :goto_9
    if-ge v8, v12, :cond_9

    .line 132
    aget v18, v16, v8

    .line 133
    aget v19, v10, v18

    aget v20, v1, v8

    aget v21, v4, v8

    mul-float v20, v20, v21

    add-float v19, v19, v20

    aput v19, v10, v18

    .line 134
    aget v19, v13, v18

    aget v20, v2, v8

    aget v21, v4, v8

    mul-float v20, v20, v21

    add-float v19, v19, v20

    aput v19, v13, v18

    .line 135
    aget v19, v17, v18

    aget v20, v3, v8

    aget v21, v4, v8

    mul-float v20, v20, v21

    add-float v19, v19, v20

    aput v19, v17, v18

    .line 136
    aget v19, v9, v18

    aget v20, v4, v8

    add-float v19, v19, v20

    aput v19, v9, v18

    .line 131
    add-int/lit8 v8, v8, 0x1

    goto :goto_9

    .line 138
    :cond_9
    const/4 v8, 0x0

    :goto_a
    if-ge v8, v15, :cond_b

    .line 139
    aget v18, v9, v8

    const/16 v19, 0x0

    cmpg-float v18, v18, v19

    if-gtz v18, :cond_a

    .line 138
    :goto_b
    add-int/lit8 v8, v8, 0x1

    goto :goto_a

    .line 140
    :cond_a
    aget v18, v10, v8

    aget v19, v9, v8

    div-float v18, v18, v19

    aput v18, v5, v8

    .line 141
    aget v18, v13, v8

    aget v19, v9, v8

    div-float v18, v18, v19

    aput v18, v6, v8

    .line 142
    aget v18, v17, v8

    aget v19, v9, v8

    div-float v18, v18, v19

    aput v18, v7, v8

    goto :goto_b

    .line 127
    :cond_b
    add-int/lit8 v8, v14, 0x1

    move v14, v8

    move-object v8, v9

    goto :goto_7

    .line 146
    :cond_c
    new-array v4, v15, [F

    .line 147
    new-array v12, v15, [Ljava/lang/Integer;

    .line 148
    const/4 v2, 0x0

    .line 149
    const/4 v1, 0x0

    move v3, v1

    move v1, v2

    :goto_c
    if-ge v3, v15, :cond_e

    .line 150
    aget v2, v8, v3

    const/4 v9, 0x0

    cmpg-float v2, v2, v9

    if-gtz v2, :cond_d

    .line 149
    :goto_d
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    goto :goto_c

    .line 151
    :cond_d
    aget v2, v5, v3

    aget v9, v6, v3

    aget v10, v7, v3

    aget v13, v8, v3

    int-to-float v14, v11

    div-float/2addr v13, v14

    invoke-static {v2, v9, v10, v13}, Lcom/mrkeyboard/app/MrPalette;->score(FFFF)F

    move-result v2

    aput v2, v4, v3

    .line 152
    add-int/lit8 v2, v1, 0x1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    aput-object v9, v12, v1

    move v1, v2

    goto :goto_d

    .line 155
    :cond_e
    const/4 v2, 0x0

    new-instance v3, Lcom/mrkeyboard/app/MrPalette$1;

    invoke-direct {v3, v4}, Lcom/mrkeyboard/app/MrPalette$1;-><init>([F)V

    invoke-static {v12, v2, v1, v3}, Ljava/util/Arrays;->sort([Ljava/lang/Object;IILjava/util/Comparator;)V

    .line 161
    move/from16 v0, p1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v2

    new-array v8, v2, [I

    .line 162
    new-array v11, v15, [Z

    .line 163
    const/4 v3, 0x0

    .line 164
    const/4 v2, 0x0

    :goto_e
    sget-object v4, Lcom/mrkeyboard/app/MrPalette;->DISTANCES:[I

    array-length v4, v4

    if-ge v2, v4, :cond_14

    array-length v4, v8

    if-ge v3, v4, :cond_14

    .line 165
    sget-object v4, Lcom/mrkeyboard/app/MrPalette;->DISTANCES:[I

    aget v4, v4, v2

    int-to-float v4, v4

    sget-object v9, Lcom/mrkeyboard/app/MrPalette;->DISTANCES:[I

    aget v9, v9, v2

    int-to-float v9, v9

    mul-float v13, v4, v9

    .line 166
    const/4 v4, 0x0

    move v10, v4

    :goto_f
    if-ge v10, v1, :cond_13

    array-length v4, v8

    if-ge v3, v4, :cond_13

    .line 167
    aget-object v4, v12, v10

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v14

    .line 168
    aget-boolean v4, v11, v14

    if-eqz v4, :cond_10

    .line 166
    :cond_f
    :goto_10
    add-int/lit8 v4, v10, 0x1

    move v10, v4

    goto :goto_f

    .line 169
    :cond_10
    aget v4, v5, v14

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    aget v9, v6, v14

    invoke-static {v9}, Ljava/lang/Math;->round(F)I

    move-result v9

    aget v15, v7, v14

    invoke-static {v15}, Ljava/lang/Math;->round(F)I

    move-result v15

    invoke-static {v4, v9, v15}, Lcom/mrkeyboard/app/MrPalette;->usable(III)I

    move-result v15

    .line 170
    const/4 v9, 0x1

    .line 171
    const/4 v4, 0x0

    move/from16 v22, v4

    move v4, v9

    move/from16 v9, v22

    :goto_11
    if-ge v9, v3, :cond_12

    if-eqz v4, :cond_12

    .line 172
    aget v16, v8, v9

    .line 173
    shr-int/lit8 v17, v16, 0x10

    move/from16 v0, v17

    and-int/lit16 v0, v0, 0xff

    move/from16 v17, v0

    shr-int/lit8 v18, v15, 0x10

    move/from16 v0, v18

    and-int/lit16 v0, v0, 0xff

    move/from16 v18, v0

    sub-int v17, v17, v18

    move/from16 v0, v17

    int-to-float v0, v0

    move/from16 v17, v0

    shr-int/lit8 v18, v16, 0x8

    move/from16 v0, v18

    and-int/lit16 v0, v0, 0xff

    move/from16 v18, v0

    shr-int/lit8 v19, v15, 0x8

    move/from16 v0, v19

    and-int/lit16 v0, v0, 0xff

    move/from16 v19, v0

    sub-int v18, v18, v19

    move/from16 v0, v18

    int-to-float v0, v0

    move/from16 v18, v0

    move/from16 v0, v16

    and-int/lit16 v0, v0, 0xff

    move/from16 v16, v0

    and-int/lit16 v0, v15, 0xff

    move/from16 v19, v0

    sub-int v16, v16, v19

    move/from16 v0, v16

    int-to-float v0, v0

    move/from16 v16, v0

    .line 174
    mul-float v17, v17, v17

    mul-float v18, v18, v18

    add-float v17, v17, v18

    mul-float v16, v16, v16

    add-float v16, v16, v17

    cmpg-float v16, v16, v13

    if-gez v16, :cond_11

    const/4 v4, 0x0

    .line 171
    :cond_11
    add-int/lit8 v9, v9, 0x1

    goto :goto_11

    .line 176
    :cond_12
    if-eqz v4, :cond_f

    .line 177
    const/4 v4, 0x1

    aput-boolean v4, v11, v14

    .line 178
    add-int/lit8 v4, v3, 0x1

    aput v15, v8, v3

    move v3, v4

    goto/16 :goto_10

    .line 164
    :cond_13
    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_e

    .line 181
    :cond_14
    array-length v1, v8

    if-ne v3, v1, :cond_15

    move-object v1, v8

    goto/16 :goto_0

    :cond_15
    invoke-static {v8, v3}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v1

    goto/16 :goto_0

    :cond_16
    move v1, v12

    goto/16 :goto_4
.end method

.method static mean([I)I
    .locals 12

    .prologue
    .line 54
    if-nez p0, :cond_0

    const/4 v0, 0x0

    .line 65
    :goto_0
    return v0

    .line 55
    :cond_0
    const-wide/16 v8, 0x0

    const-wide/16 v6, 0x0

    const-wide/16 v4, 0x0

    const-wide/16 v2, 0x0

    .line 56
    const/4 v0, 0x0

    :goto_1
    array-length v1, p0

    if-ge v0, v1, :cond_2

    .line 57
    aget v1, p0, v0

    .line 58
    ushr-int/lit8 v10, v1, 0x18

    const/16 v11, 0x80

    if-ge v10, v11, :cond_1

    .line 56
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 59
    :cond_1
    shr-int/lit8 v10, v1, 0x10

    and-int/lit16 v10, v10, 0xff

    int-to-long v10, v10

    add-long/2addr v8, v10

    .line 60
    shr-int/lit8 v10, v1, 0x8

    and-int/lit16 v10, v10, 0xff

    int-to-long v10, v10

    add-long/2addr v6, v10

    .line 61
    and-int/lit16 v1, v1, 0xff

    int-to-long v10, v1

    add-long/2addr v4, v10

    .line 62
    const-wide/16 v10, 0x1

    add-long/2addr v2, v10

    goto :goto_2

    .line 64
    :cond_2
    const-wide/16 v0, 0x0

    cmp-long v0, v2, v0

    if-nez v0, :cond_3

    const/4 v0, 0x0

    goto :goto_0

    .line 65
    :cond_3
    const/high16 v0, -0x1000000

    div-long/2addr v8, v2

    long-to-int v1, v8

    shl-int/lit8 v1, v1, 0x10

    or-int/2addr v0, v1

    div-long/2addr v6, v2

    long-to-int v1, v6

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    div-long v2, v4, v2

    long-to-int v1, v2

    or-int/2addr v0, v1

    goto :goto_0
.end method

.method static near(I)[I
    .locals 10

    .prologue
    const/4 v9, 0x3

    const/4 v8, 0x2

    const/4 v2, 0x0

    const/4 v1, 0x1

    const/4 v7, 0x0

    .line 268
    new-array v3, v9, [F

    .line 269
    invoke-static {p0, v3}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 270
    const/high16 v0, -0x1000000

    or-int/2addr v0, p0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrThemeColors;->luminance(I)F

    move-result v0

    const/high16 v4, 0x3f000000    # 0.5f

    cmpl-float v0, v0, v4

    if-lez v0, :cond_1

    move v0, v1

    .line 271
    :goto_0
    aget v5, v3, v2

    .line 272
    aget v4, v3, v1

    const v6, 0x3dcccccd    # 0.1f

    cmpg-float v4, v4, v6

    if-ltz v4, :cond_0

    aget v4, v3, v8

    const v6, 0x3df5c28f    # 0.12f

    cmpg-float v4, v4, v6

    if-gez v4, :cond_3

    .line 274
    :cond_0
    if-eqz v0, :cond_2

    const/4 v0, 0x5

    new-array v0, v0, [I

    const v3, 0x3f147ae1    # 0.58f

    invoke-static {v7, v7, v3}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v3

    aput v3, v0, v2

    const v2, 0x3ed70a3d    # 0.42f

    invoke-static {v7, v7, v2}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v2

    aput v2, v0, v1

    const v1, 0x3e8f5c29    # 0.28f

    invoke-static {v7, v7, v1}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v1

    aput v1, v0, v8

    const/high16 v1, 0x43570000    # 215.0f

    const v2, 0x3ecccccd    # 0.4f

    const v3, 0x3f19999a    # 0.6f

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v1

    aput v1, v0, v9

    const/4 v1, 0x4

    const/high16 v2, 0x41f00000    # 30.0f

    const v3, 0x3ecccccd    # 0.4f

    const v4, 0x3f19999a    # 0.6f

    invoke-static {v2, v3, v4}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v2

    aput v2, v0, v1

    .line 279
    :goto_1
    return-object v0

    :cond_1
    move v0, v2

    .line 270
    goto :goto_0

    .line 275
    :cond_2
    const/4 v0, 0x5

    new-array v0, v0, [I

    const v3, 0x3f570a3d    # 0.84f

    invoke-static {v7, v7, v3}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v3

    aput v3, v0, v2

    const v2, 0x3f23d70a    # 0.64f

    invoke-static {v7, v7, v2}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v2

    aput v2, v0, v1

    const v1, 0x3eeb851f    # 0.46f

    invoke-static {v7, v7, v1}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v1

    aput v1, v0, v8

    const/high16 v1, 0x43570000    # 215.0f

    const v2, 0x3e99999a    # 0.3f

    const v3, 0x3f6b851f    # 0.92f

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v1

    aput v1, v0, v9

    const/4 v1, 0x4

    const/high16 v2, 0x41f00000    # 30.0f

    const v3, 0x3e99999a    # 0.3f

    const v4, 0x3f6b851f    # 0.92f

    invoke-static {v2, v3, v4}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v2

    aput v2, v0, v1

    goto :goto_1

    .line 277
    :cond_3
    const v4, 0x3f733333    # 0.95f

    aget v6, v3, v1

    if-eqz v0, :cond_4

    const v3, 0x3f0ccccd    # 0.55f

    :goto_2
    invoke-static {v6, v3}, Ljava/lang/Math;->max(FF)F

    move-result v3

    invoke-static {v4, v3}, Ljava/lang/Math;->min(FF)F

    move-result v6

    .line 278
    if-eqz v0, :cond_5

    const v3, 0x3f1eb852    # 0.62f

    .line 279
    :goto_3
    const/4 v4, 0x5

    new-array v4, v4, [I

    .line 280
    invoke-static {v5, v6, v3}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v7

    aput v7, v4, v2

    const/high16 v2, -0x3df00000    # -36.0f

    .line 281
    invoke-static {v5, v2}, Lcom/mrkeyboard/app/MrPalette;->turn(FF)F

    move-result v2

    invoke-static {v2, v6, v3}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v2

    aput v2, v4, v1

    const/high16 v1, 0x42100000    # 36.0f

    .line 282
    invoke-static {v5, v1}, Lcom/mrkeyboard/app/MrPalette;->turn(FF)F

    move-result v1

    invoke-static {v1, v6, v3}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v1

    aput v1, v4, v8

    .line 283
    if-eqz v0, :cond_6

    const v0, 0x3ec28f5c    # 0.38f

    invoke-static {v5, v6, v0}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v0

    :goto_4
    aput v0, v4, v9

    const/4 v0, 0x4

    const/high16 v1, 0x42900000    # 72.0f

    .line 284
    invoke-static {v5, v1}, Lcom/mrkeyboard/app/MrPalette;->turn(FF)F

    move-result v1

    invoke-static {v1, v6, v3}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v1

    aput v1, v4, v0

    move-object v0, v4

    .line 279
    goto/16 :goto_1

    .line 277
    :cond_4
    const/high16 v3, 0x3f000000    # 0.5f

    goto :goto_2

    .line 278
    :cond_5
    const v3, 0x3f6b851f    # 0.92f

    goto :goto_3

    .line 283
    :cond_6
    const v0, 0x3eb851ec    # 0.36f

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-static {v5, v0, v1}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v0

    goto :goto_4
.end method

.method private static nearest([F[F[FFFF)I
    .locals 9

    .prologue
    const/4 v0, 0x0

    .line 214
    .line 215
    const v1, 0x7f7fffff    # Float.MAX_VALUE

    move v6, v0

    move v7, v1

    move v8, v0

    .line 216
    :goto_0
    array-length v0, p0

    if-ge v6, v0, :cond_0

    .line 217
    aget v3, p0, v6

    aget v4, p1, v6

    aget v5, p2, v6

    move v0, p3

    move v1, p4

    move v2, p5

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrPalette;->dist2(FFFFFF)F

    move-result v1

    .line 218
    cmpg-float v0, v1, v7

    if-gez v0, :cond_1

    move v2, v6

    .line 216
    :goto_1
    add-int/lit8 v0, v6, 0x1

    move v6, v0

    move v7, v1

    move v8, v2

    goto :goto_0

    .line 223
    :cond_0
    return v8

    :cond_1
    move v1, v7

    move v2, v8

    goto :goto_1
.end method

.method static of(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;)[I
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 38
    if-eqz p0, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    if-ltz v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    sget-object v1, Lcom/mrkeyboard/app/MrBackdrop;->COLORS:[I

    array-length v1, v1

    if-ge v0, v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->COLORS:[I

    iget v1, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    aget v0, v0, v1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPalette;->near(I)[I

    move-result-object v0

    .line 40
    :goto_0
    return-object v0

    .line 38
    :cond_0
    new-array v0, v2, [I

    goto :goto_0

    .line 39
    :cond_1
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPalette;->pixels(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;)[I

    move-result-object v0

    .line 40
    if-nez v0, :cond_2

    new-array v0, v2, [I

    goto :goto_0

    :cond_2
    const/4 v1, 0x5

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPalette;->extract([II)[I

    move-result-object v0

    goto :goto_0
.end method

.method private static pixels(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;)[I
    .locals 9

    .prologue
    const/4 v8, 0x0

    .line 70
    if-eqz p0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-nez v0, :cond_2

    :cond_0
    move-object v1, v8

    .line 82
    :cond_1
    :goto_0
    return-object v1

    .line 71
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_4

    :cond_3
    if-nez p1, :cond_4

    move-object v1, v8

    goto :goto_0

    .line 74
    :cond_4
    const/16 v0, 0x60

    const/16 v1, 0x30

    :try_start_0
    sget-object v2, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v0, v1, v2}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 75
    :try_start_1
    new-instance v1, Landroid/graphics/Canvas;

    invoke-direct {v1, v0}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    const/16 v2, 0x60

    const/16 v3, 0x30

    invoke-static {v1, p0, v2, v3, p1}, Lcom/mrkeyboard/app/MrBackdrop;->draw(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/MrBackdrop$Spec;IILandroid/graphics/Bitmap;)V

    .line 76
    const/16 v1, 0x1200

    new-array v1, v1, [I

    .line 77
    const/4 v2, 0x0

    const/16 v3, 0x60

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/16 v6, 0x60

    const/16 v7, 0x30

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/lang/OutOfMemoryError; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 84
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->recycle()V

    goto :goto_0

    .line 79
    :catch_0
    move-exception v0

    move-object v0, v8

    .line 84
    :goto_1
    if-eqz v0, :cond_5

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->recycle()V

    :cond_5
    move-object v1, v8

    .line 80
    goto :goto_0

    .line 81
    :catch_1
    move-exception v0

    move-object v0, v8

    .line 84
    :goto_2
    if-eqz v0, :cond_6

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->recycle()V

    :cond_6
    move-object v1, v8

    .line 82
    goto :goto_0

    .line 84
    :catchall_0
    move-exception v0

    :goto_3
    if-eqz v8, :cond_7

    invoke-virtual {v8}, Landroid/graphics/Bitmap;->recycle()V

    .line 85
    :cond_7
    throw v0

    .line 84
    :catchall_1
    move-exception v1

    move-object v8, v0

    move-object v0, v1

    goto :goto_3

    .line 81
    :catch_2
    move-exception v1

    goto :goto_2

    .line 79
    :catch_3
    move-exception v1

    goto :goto_1
.end method

.method private static score(FFFF)F
    .locals 6

    .prologue
    const/high16 v4, 0x437f0000    # 255.0f

    const/high16 v1, 0x3e800000    # 0.25f

    const/4 v0, 0x0

    .line 233
    invoke-static {p1, p2}, Ljava/lang/Math;->max(FF)F

    move-result v2

    invoke-static {p0, v2}, Ljava/lang/Math;->max(FF)F

    move-result v2

    div-float v3, v2, v4

    invoke-static {p1, p2}, Ljava/lang/Math;->min(FF)F

    move-result v2

    invoke-static {p0, v2}, Ljava/lang/Math;->min(FF)F

    move-result v2

    div-float/2addr v2, v4

    .line 234
    cmpg-float v4, v3, v0

    if-gtz v4, :cond_1

    move v2, v0

    .line 235
    :goto_0
    const/high16 v0, 0x3f800000    # 1.0f

    .line 236
    const v4, 0x3e4ccccd    # 0.2f

    cmpg-float v4, v3, v4

    if-gez v4, :cond_2

    const v0, 0x3e19999a    # 0.15f

    .line 238
    :cond_0
    :goto_1
    float-to-double v4, p3

    invoke-static {v4, v5}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v4

    double-to-float v3, v4

    add-float/2addr v1, v2

    mul-float/2addr v1, v3

    mul-float/2addr v0, v1

    return v0

    .line 234
    :cond_1
    sub-float v0, v3, v2

    div-float/2addr v0, v3

    move v2, v0

    goto :goto_0

    .line 237
    :cond_2
    const v4, 0x3df5c28f    # 0.12f

    cmpg-float v4, v2, v4

    if-gez v4, :cond_0

    const v0, 0x3f59999a    # 0.85f

    cmpl-float v0, v3, v0

    if-lez v0, :cond_3

    move v0, v1

    goto :goto_1

    :cond_3
    const v0, 0x3ecccccd    # 0.4f

    goto :goto_1
.end method

.method private static seed([F[F[F[F[F[F[F)V
    .locals 14

    .prologue
    .line 186
    array-length v10, p0

    move-object/from16 v0, p4

    array-length v11, v0

    .line 187
    const/4 v2, 0x0

    .line 188
    const/4 v3, 0x1

    :goto_0
    if-ge v3, v10, :cond_1

    .line 189
    aget v4, p3, v3

    aget v5, p3, v2

    cmpl-float v4, v4, v5

    if-lez v4, :cond_0

    move v2, v3

    .line 188
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 191
    :cond_1
    const/4 v3, 0x0

    aget v4, p0, v2

    aput v4, p4, v3

    .line 192
    const/4 v3, 0x0

    aget v4, p1, v2

    aput v4, p5, v3

    .line 193
    const/4 v3, 0x0

    aget v2, p2, v2

    aput v2, p6, v3

    .line 194
    new-array v12, v10, [F

    .line 195
    const/4 v2, 0x0

    move v8, v2

    :goto_1
    if-ge v8, v10, :cond_2

    aget v2, p0, v8

    aget v3, p1, v8

    aget v4, p2, v8

    const/4 v5, 0x0

    aget v5, p4, v5

    const/4 v6, 0x0

    aget v6, p5, v6

    const/4 v7, 0x0

    aget v7, p6, v7

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrPalette;->dist2(FFFFFF)F

    move-result v2

    aput v2, v12, v8

    add-int/lit8 v2, v8, 0x1

    move v8, v2

    goto :goto_1

    .line 196
    :cond_2
    const/4 v2, 0x1

    move v9, v2

    :goto_2
    if-ge v9, v11, :cond_5

    .line 197
    const/4 v5, -0x1

    .line 198
    const/high16 v3, -0x40800000    # -1.0f

    .line 199
    const/4 v4, 0x0

    :goto_3
    if-ge v4, v10, :cond_3

    .line 200
    aget v2, v12, v4

    aget v6, p3, v4

    float-to-double v6, v6

    invoke-static {v6, v7}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v6

    double-to-float v6, v6

    mul-float/2addr v2, v6

    .line 201
    cmpl-float v6, v2, v3

    if-lez v6, :cond_6

    move v3, v4

    .line 199
    :goto_4
    add-int/lit8 v4, v4, 0x1

    move v5, v3

    move v3, v2

    goto :goto_3

    .line 206
    :cond_3
    aget v2, p0, v5

    aput v2, p4, v9

    .line 207
    aget v2, p1, v5

    aput v2, p5, v9

    .line 208
    aget v2, p2, v5

    aput v2, p6, v9

    .line 209
    const/4 v2, 0x0

    move v8, v2

    :goto_5
    if-ge v8, v10, :cond_4

    aget v13, v12, v8

    aget v2, p0, v8

    aget v3, p1, v8

    aget v4, p2, v8

    aget v5, p4, v9

    aget v6, p5, v9

    aget v7, p6, v9

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrPalette;->dist2(FFFFFF)F

    move-result v2

    invoke-static {v13, v2}, Ljava/lang/Math;->min(FF)F

    move-result v2

    aput v2, v12, v8

    add-int/lit8 v2, v8, 0x1

    move v8, v2

    goto :goto_5

    .line 196
    :cond_4
    add-int/lit8 v2, v9, 0x1

    move v9, v2

    goto :goto_2

    .line 211
    :cond_5
    return-void

    :cond_6
    move v2, v3

    move v3, v5

    goto :goto_4
.end method

.method static tone(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;)I
    .locals 3

    .prologue
    .line 48
    if-eqz p0, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    if-ltz v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    sget-object v1, Lcom/mrkeyboard/app/MrBackdrop;->COLORS:[I

    array-length v1, v1

    if-ge v0, v1, :cond_0

    const/high16 v0, -0x1000000

    sget-object v1, Lcom/mrkeyboard/app/MrBackdrop;->COLORS:[I

    iget v2, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    aget v1, v1, v2

    or-int/2addr v0, v1

    .line 49
    :goto_0
    return v0

    .line 48
    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 49
    :cond_1
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPalette;->pixels(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;)[I

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPalette;->mean([I)I

    move-result v0

    goto :goto_0
.end method

.method private static turn(FF)F
    .locals 2

    .prologue
    const/high16 v1, 0x43b40000    # 360.0f

    .line 288
    add-float v0, p0, p1

    rem-float/2addr v0, v1

    add-float/2addr v0, v1

    rem-float/2addr v0, v1

    return v0
.end method

.method static usable(III)I
    .locals 5

    .prologue
    const v4, 0x3ecccccd    # 0.4f

    const/16 v3, 0xff

    .line 243
    invoke-static {p1, p2}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-static {p0, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 244
    int-to-float v1, v0

    const/high16 v2, 0x437f0000    # 255.0f

    div-float/2addr v1, v2

    .line 245
    cmpg-float v2, v1, v4

    if-gez v2, :cond_0

    .line 246
    if-gtz v0, :cond_1

    .line 247
    const/high16 v0, 0x42cc0000    # 102.0f

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result p2

    move p1, p2

    move p0, p2

    .line 255
    :cond_0
    :goto_0
    const/high16 v0, -0x1000000

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPalette;->clamp(I)I

    move-result v1

    shl-int/lit8 v1, v1, 0x10

    or-int/2addr v0, v1

    invoke-static {p1}, Lcom/mrkeyboard/app/MrPalette;->clamp(I)I

    move-result v1

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    invoke-static {p2}, Lcom/mrkeyboard/app/MrPalette;->clamp(I)I

    move-result v1

    or-int/2addr v0, v1

    return v0

    .line 249
    :cond_1
    div-float v0, v4, v1

    .line 250
    int-to-float v1, p0

    mul-float/2addr v1, v0

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    invoke-static {v3, v1}, Ljava/lang/Math;->min(II)I

    move-result p0

    .line 251
    int-to-float v1, p1

    mul-float/2addr v1, v0

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    invoke-static {v3, v1}, Ljava/lang/Math;->min(II)I

    move-result p1

    .line 252
    int-to-float v1, p2

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-static {v3, v0}, Ljava/lang/Math;->min(II)I

    move-result p2

    goto :goto_0
.end method
