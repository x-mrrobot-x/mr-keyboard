.class public final Lcom/mrkeyboard/app/SheetKeyboardBuilder;
.super Ljava/lang/Object;
.source "SheetKeyboardBuilder.java"


# static fields
.field private static final DIMEN_POPUP_KEY_HEIGHT:I = 0x7f06007c

.field private static final DRAWABLE_DELETE:I = 0x7f0700b8

.field private static final DRAWABLE_DELETE_PREVIEW:I = 0x7f0700bb

.field private static final DRAWABLE_HINT_POPUP:I = 0x7f07008e

.field private static final DRAWABLE_MIC:I = 0x7f0700ca

.field private static final DRAWABLE_MIC_PREVIEW:I = 0x7f0700bf

.field private static final DRAWABLE_RETURN:I = 0x7f0700d8

.field private static final DRAWABLE_RETURN_PREVIEW:I = 0x7f0700c1

.field private static final DRAWABLE_SETTINGS:I = 0x7f0700da

.field private static final DRAWABLE_SETTINGS_PREVIEW:I = 0x7f0700c3

.field private static final DRAWABLE_SHIFT:I = 0x7f0700db

.field private static final DRAWABLE_SHIFT_PREVIEW:I = 0x7f0700c4

.field private static final DRAWABLE_SPACE:I = 0x7f0700de

.field private static final DRAWABLE_SPACE_PREVIEW:I = 0x7f0700c6

.field private static final DRAWABLE_TAB:I = 0x7f0700e0

.field private static final DRAWABLE_TAB_PREVIEW:I = 0x7f0700c7

.field private static final MODE_SYMBOLS_WITH_SETTINGS:I = 0x7f08005e

.field private static final XML_KBD_SYMBOLS_FALLBACK:I = 0x7f0f000c

.field private static final XML_POPUP_PUNCTUATION:I = 0x7f0f0014

.field private static final XML_POPUP_SHEETS:I = 0x7f0f0020

.field private static final XML_POPUP_TEMPLATE:I = 0x7f0f000a


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static applySpecialKeyTraits(Landroid/content/res/Resources;Lcom/mrkeyboard/app/Keyboard$Key;ILjava/lang/String;)V
    .registers 16

    .line 359
    invoke-static {p2}, Lcom/mrkeyboard/app/SpecialKeyPicker;->defaultLabelForCode(I)Ljava/lang/String;

    move-result-object v0

    .line 360
    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz p3, :cond_17

    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_17

    invoke-virtual {p3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_15

    goto :goto_17

    :cond_15
    move v3, v2

    goto :goto_18

    :cond_17
    :goto_17
    move v3, v1

    .line 361
    :goto_18
    const/16 v4, -0x16

    const/16 v5, -0x15

    const/16 v6, -0x14

    const/16 v7, -0x13

    const/16 v8, 0x20

    const/4 v9, -0x5

    if-eq p2, v9, :cond_36

    const/16 v10, -0x70

    if-eq p2, v10, :cond_36

    if-eq p2, v8, :cond_36

    if-eq p2, v7, :cond_36

    if-eq p2, v6, :cond_36

    if-eq p2, v5, :cond_36

    if-ne p2, v4, :cond_34

    goto :goto_36

    :cond_34
    move v10, v2

    goto :goto_37

    :cond_36
    :goto_36
    move v10, v1

    :goto_37
    iput-boolean v10, p1, Lcom/mrkeyboard/app/Keyboard$Key;->repeatable:Z

    .line 362
    const/4 v10, -0x1

    if-eq p2, v10, :cond_4b

    const/16 v11, -0x71

    if-eq p2, v11, :cond_4b

    const/16 v11, -0x39

    if-eq p2, v11, :cond_4b

    const/16 v11, -0x75

    if-ne p2, v11, :cond_49

    goto :goto_4b

    :cond_49
    move v11, v2

    goto :goto_4c

    :cond_4b
    :goto_4b
    move v11, v1

    :goto_4c
    iput-boolean v11, p1, Lcom/mrkeyboard/app/Keyboard$Key;->sticky:Z

    .line 363
    if-eq p2, v7, :cond_6d

    if-eq p2, v6, :cond_6d

    if-eq p2, v5, :cond_6d

    if-eq p2, v4, :cond_6d

    const/16 v4, -0x17

    if-eq p2, v4, :cond_6d

    const/16 v4, -0x5c

    if-eq p2, v4, :cond_6d

    const/16 v4, -0x5d

    if-eq p2, v4, :cond_6d

    const/16 v4, -0x7a

    if-eq p2, v4, :cond_6d

    const/16 v4, -0x7b

    if-ne p2, v4, :cond_6b

    goto :goto_6d

    :cond_6b
    move v4, v2

    goto :goto_6e

    :cond_6d
    :goto_6d
    move v4, v1

    :goto_6e
    iput-boolean v4, p1, Lcom/mrkeyboard/app/Keyboard$Key;->isCursor:Z

    .line 364
    const/16 v4, 0xa

    const/16 v5, 0x9

    if-ltz p2, :cond_7c

    if-eq p2, v5, :cond_7c

    if-ne p2, v4, :cond_7b

    goto :goto_7c

    :cond_7b
    move v1, v2

    :cond_7c
    :goto_7c
    iput-boolean v1, p1, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    .line 366
    if-eqz v3, :cond_119

    .line 367
    if-ne p2, v9, :cond_95

    .line 368
    const p2, 0x7f0700b8

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object p2

    iput-object p2, p1, Lcom/mrkeyboard/app/Keyboard$Key;->icon:Landroid/graphics/drawable/Drawable;

    .line 369
    const p2, 0x7f0700bb

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    iput-object p0, p1, Lcom/mrkeyboard/app/Keyboard$Key;->iconPreview:Landroid/graphics/drawable/Drawable;

    .line 370
    return-void

    .line 372
    :cond_95
    if-ne p2, v4, :cond_aa

    .line 373
    const p2, 0x7f0700d8

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object p2

    iput-object p2, p1, Lcom/mrkeyboard/app/Keyboard$Key;->icon:Landroid/graphics/drawable/Drawable;

    .line 374
    const p2, 0x7f0700c1

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    iput-object p0, p1, Lcom/mrkeyboard/app/Keyboard$Key;->iconPreview:Landroid/graphics/drawable/Drawable;

    .line 375
    return-void

    .line 377
    :cond_aa
    if-ne p2, v8, :cond_c1

    .line 378
    const p2, 0x7f0700de

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object p2

    iput-object p2, p1, Lcom/mrkeyboard/app/Keyboard$Key;->icon:Landroid/graphics/drawable/Drawable;

    .line 379
    const p2, 0x7f0700c6

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    iput-object p0, p1, Lcom/mrkeyboard/app/Keyboard$Key;->iconPreview:Landroid/graphics/drawable/Drawable;

    .line 380
    iput-boolean v2, p1, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    .line 381
    return-void

    .line 383
    :cond_c1
    if-ne p2, v5, :cond_d6

    .line 384
    const p2, 0x7f0700e0

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object p2

    iput-object p2, p1, Lcom/mrkeyboard/app/Keyboard$Key;->icon:Landroid/graphics/drawable/Drawable;

    .line 385
    const p2, 0x7f0700c7

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    iput-object p0, p1, Lcom/mrkeyboard/app/Keyboard$Key;->iconPreview:Landroid/graphics/drawable/Drawable;

    .line 386
    return-void

    .line 388
    :cond_d6
    if-ne p2, v10, :cond_eb

    .line 389
    const p2, 0x7f0700db

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object p2

    iput-object p2, p1, Lcom/mrkeyboard/app/Keyboard$Key;->icon:Landroid/graphics/drawable/Drawable;

    .line 390
    const p2, 0x7f0700c4

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    iput-object p0, p1, Lcom/mrkeyboard/app/Keyboard$Key;->iconPreview:Landroid/graphics/drawable/Drawable;

    .line 391
    return-void

    .line 393
    :cond_eb
    const/16 v1, -0x64

    if-ne p2, v1, :cond_102

    .line 394
    const p2, 0x7f0700da

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object p2

    iput-object p2, p1, Lcom/mrkeyboard/app/Keyboard$Key;->icon:Landroid/graphics/drawable/Drawable;

    .line 395
    const p2, 0x7f0700c3

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    iput-object p0, p1, Lcom/mrkeyboard/app/Keyboard$Key;->iconPreview:Landroid/graphics/drawable/Drawable;

    .line 396
    return-void

    .line 398
    :cond_102
    const/16 v1, -0x66

    if-ne p2, v1, :cond_119

    .line 399
    const p2, 0x7f0700ca

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object p2

    iput-object p2, p1, Lcom/mrkeyboard/app/Keyboard$Key;->icon:Landroid/graphics/drawable/Drawable;

    .line 400
    const p2, 0x7f0700bf

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    iput-object p0, p1, Lcom/mrkeyboard/app/Keyboard$Key;->iconPreview:Landroid/graphics/drawable/Drawable;

    .line 401
    return-void

    .line 404
    :cond_119
    if-eqz p3, :cond_121

    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result p0

    if-eqz p0, :cond_122

    :cond_121
    move-object p3, v0

    :cond_122
    iput-object p3, p1, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    .line 405
    return-void
.end method

.method public static buildActionPopup(Landroid/content/Context;Lcom/mrkeyboard/app/Keyboard$Key;I)Lcom/mrkeyboard/app/Keyboard;
    .registers 36

    .line 192
    move-object/from16 v0, p1

    if-eqz v0, :cond_1a0

    iget-object v2, v0, Lcom/mrkeyboard/app/Keyboard$Key;->popupKeys:Ljava/util/List;

    if-eqz v2, :cond_1a0

    iget-object v2, v0, Lcom/mrkeyboard/app/Keyboard$Key;->popupKeys:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_12

    goto/16 :goto_1a0

    .line 195
    :cond_12
    iget-object v0, v0, Lcom/mrkeyboard/app/Keyboard$Key;->popupKeys:Ljava/util/List;

    .line 196
    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetStore;->getSheets(Landroid/content/Context;)Ljava/util/List;

    move-result-object v2

    .line 197
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    .line 198
    const v4, 0x7f06007c

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v4

    .line 199
    new-instance v12, Lcom/mrkeyboard/app/Keyboard;

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v8, 0x0

    move-object v5, v12

    move-object/from16 v6, p0

    move v7, v4

    invoke-direct/range {v5 .. v10}, Lcom/mrkeyboard/app/Keyboard;-><init>(Landroid/content/Context;IIIF)V

    .line 200
    invoke-virtual {v12}, Lcom/mrkeyboard/app/Keyboard;->getDisplayWidth()I

    move-result v5

    .line 201
    invoke-virtual {v12}, Lcom/mrkeyboard/app/Keyboard;->getVerticalGap()I

    move-result v13

    .line 202
    invoke-virtual {v12}, Lcom/mrkeyboard/app/Keyboard;->getHorizontalPad()F

    move-result v14

    .line 203
    invoke-virtual {v12}, Lcom/mrkeyboard/app/Keyboard;->getVerticalPad()F

    move-result v15

    .line 205
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v6

    const/16 v7, 0xa

    invoke-static {v6, v7}, Ljava/lang/Math;->min(II)I

    move-result v11

    .line 206
    const/4 v6, 0x5

    invoke-static {v11, v6}, Ljava/lang/Math;->min(II)I

    move-result v6

    const/4 v7, 0x1

    invoke-static {v7, v6}, Ljava/lang/Math;->max(II)I

    move-result v6

    .line 207
    nop

    .line 208
    const/4 v8, 0x3

    move v1, v8

    const/4 v9, 0x0

    :goto_57
    if-ge v9, v11, :cond_73

    .line 209
    invoke-interface {v0, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v16

    move-object/from16 v10, v16

    check-cast v10, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-static {v10, v2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->effectiveDisplayLabel(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/util/List;)Ljava/lang/String;

    move-result-object v10

    .line 210
    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v7

    if-le v7, v1, :cond_6f

    .line 211
    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v1

    .line 208
    :cond_6f
    add-int/lit8 v9, v9, 0x1

    const/4 v7, 0x1

    goto :goto_57

    .line 214
    :cond_73
    const/4 v7, 0x6

    if-lt v1, v7, :cond_7a

    if-le v6, v8, :cond_7a

    .line 215
    move v10, v8

    goto :goto_7b

    .line 217
    :cond_7a
    move v10, v6

    :goto_7b
    add-int v6, v11, v10

    const/4 v7, 0x1

    sub-int/2addr v6, v7

    div-int v9, v6, v10

    .line 219
    int-to-float v5, v5

    .line 220
    const v6, 0x3e051eb8    # 0.13f

    mul-float/2addr v6, v5

    const v7, 0x3e8f5c29    # 0.28f

    mul-float/2addr v7, v5

    int-to-float v1, v1

    const v8, 0x3d3851ec    # 0.045f

    mul-float/2addr v1, v8

    const v8, 0x3d75c28f    # 0.06f

    add-float/2addr v1, v8

    mul-float/2addr v1, v5

    .line 221
    invoke-static {v7, v1}, Ljava/lang/Math;->min(FF)F

    move-result v1

    invoke-static {v6, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    const v6, 0x3f6b851f    # 0.92f

    mul-float/2addr v5, v6

    int-to-float v6, v10

    div-float/2addr v5, v6

    .line 220
    invoke-static {v1, v5}, Ljava/lang/Math;->min(FF)F

    move-result v1

    .line 225
    invoke-virtual {v12}, Lcom/mrkeyboard/app/Keyboard;->getKeys()Ljava/util/List;

    move-result-object v8

    .line 226
    nop

    .line 227
    nop

    .line 228
    nop

    .line 230
    move/from16 v16, v13

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    :goto_b2
    if-ge v6, v9, :cond_18f

    .line 231
    move/from16 p1, v6

    sub-int v6, v11, v5

    invoke-static {v10, v6}, Ljava/lang/Math;->min(II)I

    move-result v6

    .line 232
    move/from16 v17, v5

    move/from16 v18, v11

    const/4 v5, 0x0

    invoke-static {v12, v1, v4, v13, v5}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->makeRow(Lcom/mrkeyboard/app/Keyboard;FIII)Lcom/mrkeyboard/app/Keyboard$Row;

    move-result-object v11

    .line 233
    int-to-float v5, v6

    mul-float v19, v5, v1

    .line 234
    nop

    .line 235
    const/4 v5, 0x0

    move/from16 v20, v5

    const/4 v5, 0x0

    move/from16 v32, v17

    move/from16 v17, v1

    move/from16 v1, v32

    :goto_d3
    if-ge v5, v6, :cond_157

    .line 236
    add-int/lit8 v21, v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 237
    move-object/from16 v22, v0

    new-instance v0, Lcom/mrkeyboard/app/Keyboard$Key;

    invoke-direct {v0, v11}, Lcom/mrkeyboard/app/Keyboard$Key;-><init>(Lcom/mrkeyboard/app/Keyboard$Row;)V

    .line 238
    invoke-static {v3, v2, v0, v1}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->configureKeyFromSpec(Landroid/content/res/Resources;Ljava/util/List;Lcom/mrkeyboard/app/Keyboard$Key;Lcom/mrkeyboard/app/SheetModel$KeySpec;)V

    .line 239
    const/4 v1, 0x0

    iput-object v1, v0, Lcom/mrkeyboard/app/Keyboard$Key;->popupCharacters:Ljava/lang/CharSequence;

    .line 240
    iput-object v1, v0, Lcom/mrkeyboard/app/Keyboard$Key;->popupKeys:Ljava/util/List;

    .line 241
    const/4 v1, 0x0

    iput v1, v0, Lcom/mrkeyboard/app/Keyboard$Key;->popupResId:I

    .line 242
    add-int/lit8 v1, v6, -0x1

    if-ne v5, v1, :cond_f6

    sub-float v23, v19, v20

    goto :goto_f8

    :cond_f6
    move/from16 v23, v17

    .line 243
    :goto_f8
    move-object/from16 v24, v2

    move v2, v5

    move-object v5, v0

    move-object/from16 v25, v3

    move/from16 v26, v6

    move/from16 v3, p1

    move/from16 v6, v20

    move-object/from16 p1, v12

    move v12, v7

    move/from16 v7, v23

    move/from16 v27, v13

    move-object v13, v8

    move v8, v14

    move/from16 v28, v9

    move v9, v15

    move/from16 v30, v10

    const/16 v29, 0x0

    move/from16 v10, v16

    move-object/from16 v31, v11

    move v11, v4

    invoke-static/range {v5 .. v11}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->placeKey(Lcom/mrkeyboard/app/Keyboard$Key;FFFFII)V

    .line 244
    if-nez v3, :cond_120

    const/4 v10, 0x4

    goto :goto_122

    :cond_120
    move/from16 v10, v29

    :goto_122
    add-int/lit8 v9, v28, -0x1

    if-ne v3, v9, :cond_129

    const/16 v5, 0x8

    goto :goto_12b

    :cond_129
    move/from16 v5, v29

    :goto_12b
    or-int/2addr v5, v10

    .line 245
    if-nez v2, :cond_130

    or-int/lit8 v5, v5, 0x1

    .line 246
    :cond_130
    if-ne v2, v1, :cond_134

    or-int/lit8 v5, v5, 0x2

    .line 247
    :cond_134
    iput v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    .line 248
    invoke-interface {v13, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 249
    add-float v20, v20, v23

    .line 235
    add-int/lit8 v5, v2, 0x1

    move v7, v12

    move-object v8, v13

    move/from16 v1, v21

    move-object/from16 v0, v22

    move-object/from16 v2, v24

    move/from16 v6, v26

    move/from16 v13, v27

    move/from16 v9, v28

    move/from16 v10, v30

    move-object/from16 v11, v31

    move-object/from16 v12, p1

    move/from16 p1, v3

    move-object/from16 v3, v25

    goto/16 :goto_d3

    .line 251
    :cond_157
    move-object/from16 v22, v0

    move-object/from16 v24, v2

    move-object/from16 v25, v3

    move/from16 v28, v9

    move/from16 v30, v10

    move/from16 v27, v13

    const/16 v29, 0x0

    move/from16 v3, p1

    move-object v13, v8

    move-object/from16 p1, v12

    move v12, v7

    invoke-static/range {v19 .. v19}, Ljava/lang/Math;->round(F)I

    move-result v7

    .line 252
    if-le v7, v12, :cond_172

    goto :goto_173

    :cond_172
    move v7, v12

    .line 253
    :goto_173
    add-int v0, v4, v27

    add-int v16, v16, v0

    .line 230
    add-int/lit8 v6, v3, 0x1

    move-object/from16 v12, p1

    move v5, v1

    move-object v8, v13

    move/from16 v1, v17

    move/from16 v11, v18

    move-object/from16 v0, v22

    move-object/from16 v2, v24

    move-object/from16 v3, v25

    move/from16 v13, v27

    move/from16 v9, v28

    move/from16 v10, v30

    goto/16 :goto_b2

    .line 255
    :cond_18f
    move/from16 v28, v9

    move-object/from16 p1, v12

    move v12, v7

    move-object/from16 v5, p1

    move v6, v12

    move/from16 v7, v16

    move v8, v4

    move/from16 v10, v28

    invoke-virtual/range {v5 .. v10}, Lcom/mrkeyboard/app/Keyboard;->finishCustomBuild(IIIII)V

    .line 256
    return-object p1

    .line 193
    :cond_1a0
    :goto_1a0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static buildKeyboard(Landroid/content/Context;IIF)Lcom/mrkeyboard/app/LatinKeyboard;
    .registers 37

    .line 34
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetStore;->getSheets(Landroid/content/Context;)Ljava/util/List;

    move-result-object v4

    .line 35
    invoke-interface {v4}, Ljava/util/List;->isEmpty()Z

    move-result v5

    if-eqz v5, :cond_1b

    .line 36
    new-instance v1, Lcom/mrkeyboard/app/LatinKeyboard;

    const v4, 0x7f0f000c

    invoke-direct {v1, v0, v4, v2, v3}, Lcom/mrkeyboard/app/LatinKeyboard;-><init>(Landroid/content/Context;IIF)V

    return-object v1

    .line 38
    :cond_1b
    const/4 v5, 0x0

    if-ltz v1, :cond_24

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v6

    if-lt v1, v6, :cond_25

    :cond_24
    move v1, v5

    .line 39
    :cond_25
    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 41
    new-instance v12, Lcom/mrkeyboard/app/LatinKeyboard;

    invoke-direct {v12, v0, v5, v2, v3}, Lcom/mrkeyboard/app/LatinKeyboard;-><init>(Landroid/content/Context;IIF)V

    .line 42
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 43
    invoke-virtual {v12}, Lcom/mrkeyboard/app/LatinKeyboard;->getDisplayWidth()I

    move-result v7

    .line 44
    invoke-virtual {v12}, Lcom/mrkeyboard/app/LatinKeyboard;->getKeyboardHeightPx()I

    move-result v3

    .line 45
    invoke-virtual {v12}, Lcom/mrkeyboard/app/LatinKeyboard;->getVerticalGap()I

    move-result v6

    .line 46
    invoke-virtual {v12}, Lcom/mrkeyboard/app/LatinKeyboard;->getHorizontalPad()F

    move-result v8

    .line 47
    invoke-virtual {v12}, Lcom/mrkeyboard/app/LatinKeyboard;->getVerticalPad()F

    move-result v9

    .line 49
    iget-object v10, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v10}, Ljava/util/ArrayList;->size()I

    move-result v10

    const/4 v11, 0x6

    invoke-static {v10, v11}, Ljava/lang/Math;->min(II)I

    move-result v10

    const/4 v11, 0x1

    invoke-static {v11, v10}, Ljava/lang/Math;->max(II)I

    move-result v10

    .line 50
    add-int/lit8 v20, v10, 0x1

    .line 51
    if-lez v3, :cond_5f

    div-int v3, v3, v20

    goto :goto_6c

    :cond_5f
    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v3

    iget v3, v3, Landroid/util/DisplayMetrics;->density:F

    const/high16 v13, 0x42380000    # 46.0f

    mul-float/2addr v3, v13

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    .line 52
    :goto_6c
    invoke-virtual {v12}, Lcom/mrkeyboard/app/LatinKeyboard;->getKeys()Ljava/util/List;

    move-result-object v15

    .line 54
    nop

    .line 55
    int-to-float v14, v7

    .line 57
    move v13, v5

    move/from16 v21, v6

    :goto_75
    const/high16 v16, 0x41200000    # 10.0f

    if-ge v13, v10, :cond_1cf

    .line 58
    iget-object v5, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v5, v13}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 59
    add-int/lit8 v11, v10, -0x1

    if-ne v13, v11, :cond_87

    const/4 v11, 0x1

    goto :goto_88

    :cond_87
    const/4 v11, 0x0

    .line 60
    :goto_88
    move/from16 p3, v10

    div-float v10, v14, v16

    invoke-static {v12, v10, v3, v6, v2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->makeRow(Lcom/mrkeyboard/app/Keyboard;FIII)Lcom/mrkeyboard/app/Keyboard$Row;

    move-result-object v10

    .line 61
    iget-object v5, v5, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    .line 62
    move/from16 v22, v7

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v7

    .line 64
    nop

    .line 65
    const/16 v16, 0x0

    move/from16 v17, v13

    move/from16 v18, v16

    const/4 v13, 0x0

    :goto_a0
    if-ge v13, v7, :cond_b9

    .line 66
    invoke-interface {v5, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v19

    move/from16 v23, v14

    move-object/from16 v14, v19

    check-cast v14, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget v14, v14, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v14}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v14

    add-float v18, v18, v14

    .line 65
    add-int/lit8 v13, v13, 0x1

    move/from16 v14, v23

    goto :goto_a0

    .line 68
    :cond_b9
    move/from16 v23, v14

    if-eqz v11, :cond_c4

    .line 69
    const/high16 v13, 0x3fc00000    # 1.5f

    add-float v18, v18, v13

    move/from16 v24, v18

    goto :goto_c6

    .line 68
    :cond_c4
    move/from16 v24, v18

    .line 72
    :goto_c6
    cmpg-float v13, v24, v16

    const/16 v25, 0x4

    if-gtz v13, :cond_fd

    .line 73
    invoke-virtual {v12, v10}, Lcom/mrkeyboard/app/LatinKeyboard;->createCustomKey(Lcom/mrkeyboard/app/Keyboard$Row;)Lcom/mrkeyboard/app/Keyboard$Key;

    move-result-object v5

    .line 74
    const/16 v7, -0x18f

    filled-new-array {v7}, [I

    move-result-object v7

    iput-object v7, v5, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    .line 75
    const/4 v14, 0x0

    move/from16 v26, v17

    move-object v13, v5

    move-object v7, v15

    move/from16 v15, v23

    move/from16 v16, v8

    move/from16 v17, v9

    move/from16 v18, v21

    move/from16 v19, v3

    invoke-static/range {v13 .. v19}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->placeKey(Lcom/mrkeyboard/app/Keyboard$Key;FFFFII)V

    .line 76
    if-nez v26, :cond_ed

    goto :goto_ef

    :cond_ed
    const/16 v25, 0x0

    :goto_ef
    or-int/lit8 v10, v25, 0x3

    iput v10, v5, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    .line 77
    invoke-interface {v7, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 78
    move-object/from16 v32, v1

    move-object/from16 v31, v4

    move-object v1, v7

    goto/16 :goto_1ba

    .line 79
    :cond_fd
    move/from16 v26, v17

    .line 80
    add-int v13, v7, v11

    const/4 v14, 0x1

    sub-int/2addr v13, v14

    .line 81
    move/from16 v27, v16

    const/4 v14, 0x0

    :goto_106
    if-ge v14, v7, :cond_16b

    .line 82
    invoke-interface {v5, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v16

    move-object/from16 v28, v5

    move-object/from16 v5, v16

    check-cast v5, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 83
    if-ne v14, v13, :cond_11b

    sub-float v16, v23, v27

    move/from16 v29, v16

    move/from16 v16, v13

    goto :goto_129

    :cond_11b
    move/from16 v16, v13

    iget v13, v5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v13}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v13

    div-float v13, v13, v24

    mul-float v13, v13, v23

    move/from16 v29, v13

    .line 84
    :goto_129
    invoke-virtual {v12, v10}, Lcom/mrkeyboard/app/LatinKeyboard;->createCustomKey(Lcom/mrkeyboard/app/Keyboard$Row;)Lcom/mrkeyboard/app/Keyboard$Key;

    move-result-object v13

    .line 85
    invoke-static {v0, v4, v13, v5}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->configureKeyFromSpec(Landroid/content/res/Resources;Ljava/util/List;Lcom/mrkeyboard/app/Keyboard$Key;Lcom/mrkeyboard/app/SheetModel$KeySpec;)V

    .line 86
    move-object/from16 v30, v13

    move/from16 v5, v16

    move-object/from16 v31, v4

    move v4, v14

    move/from16 v14, v27

    move-object/from16 v32, v1

    move-object v1, v15

    move/from16 v15, v29

    move/from16 v16, v8

    move/from16 v17, v9

    move/from16 v18, v21

    move/from16 v19, v3

    invoke-static/range {v13 .. v19}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->placeKey(Lcom/mrkeyboard/app/Keyboard$Key;FFFFII)V

    .line 87
    if-nez v26, :cond_14e

    move/from16 v13, v25

    goto :goto_14f

    :cond_14e
    const/4 v13, 0x0

    .line 88
    :goto_14f
    if-nez v4, :cond_153

    or-int/lit8 v13, v13, 0x1

    .line 89
    :cond_153
    if-ne v4, v5, :cond_157

    or-int/lit8 v13, v13, 0x2

    .line 90
    :cond_157
    move-object/from16 v14, v30

    iput v13, v14, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    .line 91
    invoke-interface {v1, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 92
    add-float v27, v27, v29

    .line 81
    add-int/lit8 v14, v4, 0x1

    move-object v15, v1

    move v13, v5

    move-object/from16 v5, v28

    move-object/from16 v4, v31

    move-object/from16 v1, v32

    goto :goto_106

    .line 94
    :cond_16b
    move-object/from16 v32, v1

    move-object/from16 v31, v4

    move-object v1, v15

    if-eqz v11, :cond_1ba

    .line 95
    sub-float v14, v23, v27

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-static {v4, v14}, Ljava/lang/Math;->max(FF)F

    move-result v15

    .line 96
    invoke-virtual {v12, v10}, Lcom/mrkeyboard/app/LatinKeyboard;->createCustomKey(Lcom/mrkeyboard/app/Keyboard$Row;)Lcom/mrkeyboard/app/Keyboard$Key;

    move-result-object v4

    .line 97
    const/4 v5, -0x5

    filled-new-array {v5}, [I

    move-result-object v5

    iput-object v5, v4, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    .line 98
    const/4 v5, 0x1

    iput-boolean v5, v4, Lcom/mrkeyboard/app/Keyboard$Key;->repeatable:Z

    .line 99
    iput-boolean v5, v4, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    .line 100
    const v5, 0x7f0700b8

    invoke-static {v0, v5}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    iput-object v5, v4, Lcom/mrkeyboard/app/Keyboard$Key;->icon:Landroid/graphics/drawable/Drawable;

    .line 101
    const v5, 0x7f0700bb

    invoke-static {v0, v5}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    iput-object v5, v4, Lcom/mrkeyboard/app/Keyboard$Key;->iconPreview:Landroid/graphics/drawable/Drawable;

    .line 102
    move-object v13, v4

    move/from16 v14, v27

    move/from16 v16, v8

    move/from16 v17, v9

    move/from16 v18, v21

    move/from16 v19, v3

    invoke-static/range {v13 .. v19}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->placeKey(Lcom/mrkeyboard/app/Keyboard$Key;FFFFII)V

    .line 103
    if-nez v26, :cond_1ad

    goto :goto_1af

    :cond_1ad
    const/16 v25, 0x0

    :goto_1af
    or-int/lit8 v5, v25, 0x2

    .line 104
    if-nez v7, :cond_1b5

    or-int/lit8 v5, v5, 0x1

    .line 105
    :cond_1b5
    iput v5, v4, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    .line 106
    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 109
    :cond_1ba
    :goto_1ba
    add-int v4, v3, v6

    add-int v21, v21, v4

    .line 57
    add-int/lit8 v13, v26, 0x1

    move/from16 v10, p3

    move-object v15, v1

    move/from16 v7, v22

    move/from16 v14, v23

    move-object/from16 v4, v31

    move-object/from16 v1, v32

    const/4 v5, 0x0

    const/4 v11, 0x1

    goto/16 :goto_75

    .line 113
    :cond_1cf
    move-object/from16 v32, v1

    move/from16 v22, v7

    move/from16 v23, v14

    move-object v1, v15

    div-float v14, v23, v16

    invoke-static {v12, v14, v3, v6, v2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->makeRow(Lcom/mrkeyboard/app/Keyboard;FIII)Lcom/mrkeyboard/app/Keyboard$Row;

    move-result-object v4

    .line 114
    const v5, 0x7f08005e

    if-ne v2, v5, :cond_1e3

    const/4 v2, 0x1

    goto :goto_1e4

    :cond_1e3
    const/4 v2, 0x0

    .line 115
    :goto_1e4
    move-object/from16 v5, v32

    iget-object v5, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v6, "123"

    invoke-static {v5, v6}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 117
    nop

    .line 118
    if-eqz v2, :cond_1f5

    const v6, 0x3e19999a    # 0.15f

    goto :goto_1f8

    :cond_1f5
    const v6, 0x3e4ccccd    # 0.2f

    :goto_1f8
    mul-float v6, v6, v23

    .line 119
    invoke-virtual {v12, v4}, Lcom/mrkeyboard/app/LatinKeyboard;->createCustomKey(Lcom/mrkeyboard/app/Keyboard$Row;)Lcom/mrkeyboard/app/Keyboard$Key;

    move-result-object v7

    .line 120
    const/16 v10, -0x12c

    filled-new-array {v10}, [I

    move-result-object v10

    iput-object v10, v7, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    .line 121
    iput-object v5, v7, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    .line 122
    const/4 v5, 0x1

    iput-boolean v5, v7, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    .line 123
    const v5, 0x7f0f0020

    iput v5, v7, Lcom/mrkeyboard/app/Keyboard$Key;->popupResId:I

    .line 124
    const/4 v5, 0x0

    move-object v13, v7

    move v14, v5

    move v15, v6

    move/from16 v16, v8

    move/from16 v17, v9

    move/from16 v18, v21

    move/from16 v19, v3

    invoke-static/range {v13 .. v19}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->placeKey(Lcom/mrkeyboard/app/Keyboard$Key;FFFFII)V

    .line 125
    const/16 v10, 0x9

    iput v10, v7, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    .line 126
    invoke-interface {v1, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 127
    add-float/2addr v6, v5

    .line 129
    const v5, 0x3dcccccd    # 0.1f

    const/16 v7, 0x8

    if-eqz v2, :cond_265

    .line 130
    mul-float v10, v23, v5

    .line 131
    invoke-virtual {v12, v4}, Lcom/mrkeyboard/app/LatinKeyboard;->createCustomKey(Lcom/mrkeyboard/app/Keyboard$Row;)Lcom/mrkeyboard/app/Keyboard$Key;

    move-result-object v11

    .line 132
    const/16 v13, -0x64

    filled-new-array {v13}, [I

    move-result-object v13

    iput-object v13, v11, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    .line 133
    const/4 v13, 0x1

    iput-boolean v13, v11, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    .line 134
    const v13, 0x7f0700da

    invoke-static {v0, v13}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object v13

    iput-object v13, v11, Lcom/mrkeyboard/app/Keyboard$Key;->icon:Landroid/graphics/drawable/Drawable;

    .line 135
    const v13, 0x7f0700c3

    invoke-static {v0, v13}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object v13

    iput-object v13, v11, Lcom/mrkeyboard/app/Keyboard$Key;->iconPreview:Landroid/graphics/drawable/Drawable;

    .line 136
    move-object v13, v11

    move v14, v6

    move v15, v10

    move/from16 v16, v8

    move/from16 v17, v9

    move/from16 v18, v21

    move/from16 v19, v3

    invoke-static/range {v13 .. v19}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->placeKey(Lcom/mrkeyboard/app/Keyboard$Key;FFFFII)V

    .line 137
    iput v7, v11, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    .line 138
    invoke-interface {v1, v11}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 139
    add-float/2addr v6, v10

    .line 142
    :cond_265
    mul-float v5, v5, v23

    .line 143
    invoke-virtual {v12, v4}, Lcom/mrkeyboard/app/LatinKeyboard;->createCustomKey(Lcom/mrkeyboard/app/Keyboard$Row;)Lcom/mrkeyboard/app/Keyboard$Key;

    move-result-object v10

    .line 144
    const/16 v11, -0x67

    filled-new-array {v11}, [I

    move-result-object v11

    iput-object v11, v10, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    .line 145
    const/4 v11, 0x1

    iput-boolean v11, v10, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    .line 146
    move-object v13, v10

    move v14, v6

    move v15, v5

    move/from16 v16, v8

    move/from16 v17, v9

    move/from16 v18, v21

    move/from16 v19, v3

    invoke-static/range {v13 .. v19}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->placeKey(Lcom/mrkeyboard/app/Keyboard$Key;FFFFII)V

    .line 147
    iput v7, v10, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    .line 148
    invoke-interface {v1, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 149
    add-float/2addr v6, v5

    .line 151
    if-eqz v2, :cond_290

    const v2, 0x3e99999a    # 0.3f

    goto :goto_293

    :cond_290
    const v2, 0x3ecccccd    # 0.4f

    :goto_293
    mul-float v2, v2, v23

    .line 152
    invoke-virtual {v12, v4}, Lcom/mrkeyboard/app/LatinKeyboard;->createCustomKey(Lcom/mrkeyboard/app/Keyboard$Row;)Lcom/mrkeyboard/app/Keyboard$Key;

    move-result-object v10

    .line 153
    const/16 v11, 0x20

    filled-new-array {v11}, [I

    move-result-object v11

    iput-object v11, v10, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    .line 154
    const/4 v11, 0x1

    iput-boolean v11, v10, Lcom/mrkeyboard/app/Keyboard$Key;->repeatable:Z

    .line 155
    const/4 v11, 0x0

    iput-boolean v11, v10, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    .line 156
    const v11, 0x7f0700de

    invoke-static {v0, v11}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object v11

    iput-object v11, v10, Lcom/mrkeyboard/app/Keyboard$Key;->icon:Landroid/graphics/drawable/Drawable;

    .line 157
    const v11, 0x7f0700c6

    invoke-static {v0, v11}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object v11

    iput-object v11, v10, Lcom/mrkeyboard/app/Keyboard$Key;->iconPreview:Landroid/graphics/drawable/Drawable;

    .line 158
    move-object v13, v10

    move v14, v6

    move v15, v2

    move/from16 v16, v8

    move/from16 v17, v9

    move/from16 v18, v21

    move/from16 v19, v3

    invoke-static/range {v13 .. v19}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->placeKey(Lcom/mrkeyboard/app/Keyboard$Key;FFFFII)V

    .line 159
    iput v7, v10, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    .line 160
    invoke-interface {v1, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 161
    add-float/2addr v6, v2

    .line 163
    nop

    .line 164
    invoke-virtual {v12, v4}, Lcom/mrkeyboard/app/LatinKeyboard;->createCustomKey(Lcom/mrkeyboard/app/Keyboard$Row;)Lcom/mrkeyboard/app/Keyboard$Key;

    move-result-object v2

    .line 165
    const/16 v10, 0x2e

    filled-new-array {v10}, [I

    move-result-object v10

    iput-object v10, v2, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    .line 166
    const-string v10, "."

    iput-object v10, v2, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    .line 167
    const/4 v10, 0x1

    iput-boolean v10, v2, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    .line 168
    const v10, 0x7f0f0014

    iput v10, v2, Lcom/mrkeyboard/app/Keyboard$Key;->popupResId:I

    .line 169
    const v10, 0x7f07008e

    invoke-static {v0, v10}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object v10

    iput-object v10, v2, Lcom/mrkeyboard/app/Keyboard$Key;->icon:Landroid/graphics/drawable/Drawable;

    .line 170
    move-object v13, v2

    move v14, v6

    move v15, v5

    invoke-static/range {v13 .. v19}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->placeKey(Lcom/mrkeyboard/app/Keyboard$Key;FFFFII)V

    .line 171
    iput v7, v2, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    .line 172
    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 173
    add-float v14, v6, v5

    .line 175
    sub-float v2, v23, v14

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-static {v5, v2}, Ljava/lang/Math;->max(FF)F

    move-result v15

    .line 176
    invoke-virtual {v12, v4}, Lcom/mrkeyboard/app/LatinKeyboard;->createCustomKey(Lcom/mrkeyboard/app/Keyboard$Row;)Lcom/mrkeyboard/app/Keyboard$Key;

    move-result-object v2

    .line 177
    const/16 v4, 0xa

    filled-new-array {v4}, [I

    move-result-object v5

    iput-object v5, v2, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    .line 178
    const/4 v5, 0x1

    iput-boolean v5, v2, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    .line 179
    const v5, 0x7f0700d8

    invoke-static {v0, v5}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    iput-object v5, v2, Lcom/mrkeyboard/app/Keyboard$Key;->icon:Landroid/graphics/drawable/Drawable;

    .line 180
    const v5, 0x7f0700c1

    invoke-static {v0, v5}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/Keyboard$Key;->iconPreview:Landroid/graphics/drawable/Drawable;

    .line 181
    move-object v13, v2

    invoke-static/range {v13 .. v19}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->placeKey(Lcom/mrkeyboard/app/Keyboard$Key;FFFFII)V

    .line 182
    iput v4, v2, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    .line 183
    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 185
    add-int v8, v21, v3

    move-object v6, v12

    move/from16 v7, v22

    move v9, v3

    move/from16 v10, v20

    move/from16 v11, v20

    invoke-virtual/range {v6 .. v11}, Lcom/mrkeyboard/app/LatinKeyboard;->finishCustomBuild(IIIII)V

    .line 186
    invoke-virtual {v12}, Lcom/mrkeyboard/app/LatinKeyboard;->bindCustomSpecialKeys()V

    .line 187
    return-object v12
.end method

.method public static buildSheetsPopup(Landroid/content/Context;Lcom/mrkeyboard/app/Keyboard$Key;I)Lcom/mrkeyboard/app/Keyboard;
    .registers 31

    .line 260
    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetStore;->getSheets(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_has_sheets

    const/4 v0, 0x0

    return-object v0

    :cond_has_sheets
    .line 261
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f06007c

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    .line 262
    new-instance v2, Lcom/mrkeyboard/app/Keyboard;

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v6, 0x0

    move-object v3, v2

    move-object/from16 v4, p0

    move v5, v1

    invoke-direct/range {v3 .. v8}, Lcom/mrkeyboard/app/Keyboard;-><init>(Landroid/content/Context;IIIF)V

    .line 263
    invoke-virtual {v2}, Lcom/mrkeyboard/app/Keyboard;->getDisplayWidth()I

    move-result v3

    .line 264
    invoke-virtual {v2}, Lcom/mrkeyboard/app/Keyboard;->getVerticalGap()I

    move-result v10

    .line 265
    invoke-virtual {v2}, Lcom/mrkeyboard/app/Keyboard;->getHorizontalPad()F

    move-result v11

    .line 266
    invoke-virtual {v2}, Lcom/mrkeyboard/app/Keyboard;->getVerticalPad()F

    move-result v12

    .line 268
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v4

    const/4 v5, 0x1

    add-int/lit8 v13, v4, 0x1

    .line 269
    const/4 v4, 0x6

    invoke-static {v13, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    invoke-static {v5, v4}, Ljava/lang/Math;->max(II)I

    move-result v14

    .line 270
    add-int v4, v13, v14

    sub-int/2addr v4, v5

    div-int v15, v4, v14

    .line 271
    int-to-float v3, v3

    .line 272
    const v4, 0x3e0a3d71    # 0.135f

    mul-float/2addr v4, v3

    const v5, 0x3f6b851f    # 0.92f

    mul-float/2addr v3, v5

    int-to-float v5, v14

    div-float/2addr v3, v5

    invoke-static {v4, v3}, Ljava/lang/Math;->min(FF)F

    move-result v9

    .line 273
    mul-float/2addr v5, v9

    invoke-static {v5}, Ljava/lang/Math;->round(F)I

    move-result v3

    .line 275
    invoke-virtual {v2}, Lcom/mrkeyboard/app/Keyboard;->getKeys()Ljava/util/List;

    move-result-object v8

    .line 276
    nop

    .line 277
    nop

    .line 279
    move v6, v3

    move v3, v7

    move v5, v3

    move/from16 v16, v10

    :goto_5f
    if-ge v5, v15, :cond_166

    .line 280
    sub-int v4, v13, v3

    invoke-static {v14, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    .line 281
    move/from16 p0, v13

    invoke-static {v2, v9, v1, v10, v7}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->makeRow(Lcom/mrkeyboard/app/Keyboard;FIII)Lcom/mrkeyboard/app/Keyboard$Row;

    move-result-object v13

    .line 282
    int-to-float v7, v4

    mul-float v17, v9, v7

    .line 283
    nop

    .line 284
    const/4 v7, 0x0

    move/from16 v18, v7

    move v7, v3

    const/4 v3, 0x0

    :goto_76
    if-ge v3, v4, :cond_130

    .line 285
    move/from16 p2, v14

    new-instance v14, Lcom/mrkeyboard/app/Keyboard$Key;

    invoke-direct {v14, v13}, Lcom/mrkeyboard/app/Keyboard$Key;-><init>(Lcom/mrkeyboard/app/Keyboard$Row;)V

    .line 286
    if-nez v7, :cond_94

    .line 287
    move/from16 v19, v5

    const-string v5, "ABC"

    iput-object v5, v14, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    .line 288
    const/16 v5, -0x190

    filled-new-array {v5}, [I

    move-result-object v5

    iput-object v5, v14, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    move-object/from16 v20, v0

    move/from16 v21, v6

    goto :goto_c5

    .line 290
    :cond_94
    move/from16 v19, v5

    add-int/lit8 v5, v7, -0x1

    invoke-interface {v0, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v5, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    move-object/from16 v20, v0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v21, v6

    const-string v6, "F"

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v5, v0}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v14, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    .line 291
    rsub-int v0, v7, -0x190

    filled-new-array {v0}, [I

    move-result-object v0

    iput-object v0, v14, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    .line 293
    :goto_c5
    const/4 v0, 0x0

    iput-boolean v0, v14, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    .line 294
    add-int/lit8 v6, v4, -0x1

    if-ne v3, v6, :cond_d1

    sub-float v5, v17, v18

    move/from16 v22, v5

    goto :goto_d3

    :cond_d1
    move/from16 v22, v9

    .line 295
    :goto_d3
    move v5, v3

    move-object v3, v14

    move/from16 v23, v4

    move/from16 v4, v18

    move/from16 v0, v19

    move-object/from16 v19, v13

    move v13, v5

    move/from16 v5, v22

    move-object/from16 v24, v2

    move/from16 v2, v21

    move/from16 v21, v10

    move v10, v6

    move v6, v11

    move/from16 v25, v7

    const/16 v26, 0x0

    move v7, v12

    move/from16 p1, v11

    move-object v11, v8

    move/from16 v8, v16

    move/from16 v27, v9

    move v9, v1

    invoke-static/range {v3 .. v9}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->placeKey(Lcom/mrkeyboard/app/Keyboard$Key;FFFFII)V

    .line 296
    if-nez v0, :cond_fc

    const/4 v7, 0x4

    goto :goto_fe

    :cond_fc
    move/from16 v7, v26

    :goto_fe
    add-int/lit8 v3, v15, -0x1

    if-ne v0, v3, :cond_105

    const/16 v3, 0x8

    goto :goto_107

    :cond_105
    move/from16 v3, v26

    :goto_107
    or-int/2addr v3, v7

    .line 297
    if-nez v13, :cond_10c

    or-int/lit8 v3, v3, 0x1

    .line 298
    :cond_10c
    if-ne v13, v10, :cond_110

    or-int/lit8 v3, v3, 0x2

    .line 299
    :cond_110
    iput v3, v14, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    .line 300
    invoke-interface {v11, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 301
    add-float v18, v18, v22

    .line 302
    add-int/lit8 v7, v25, 0x1

    .line 284
    add-int/lit8 v3, v13, 0x1

    move/from16 v14, p2

    move v5, v0

    move v6, v2

    move-object v8, v11

    move-object/from16 v13, v19

    move-object/from16 v0, v20

    move/from16 v10, v21

    move/from16 v4, v23

    move-object/from16 v2, v24

    move/from16 v9, v27

    move/from16 v11, p1

    goto/16 :goto_76

    .line 304
    :cond_130
    move-object/from16 v20, v0

    move-object/from16 v24, v2

    move v0, v5

    move v2, v6

    move/from16 v25, v7

    move/from16 v27, v9

    move/from16 v21, v10

    move/from16 p1, v11

    move/from16 p2, v14

    const/16 v26, 0x0

    move-object v11, v8

    invoke-static/range {v17 .. v17}, Ljava/lang/Math;->round(F)I

    move-result v6

    .line 305
    if-le v6, v2, :cond_14a

    goto :goto_14b

    :cond_14a
    move v6, v2

    .line 306
    :goto_14b
    add-int v10, v1, v21

    add-int v16, v16, v10

    .line 279
    add-int/lit8 v5, v0, 0x1

    move/from16 v13, p0

    move/from16 v14, p2

    move-object v8, v11

    move-object/from16 v0, v20

    move/from16 v10, v21

    move-object/from16 v2, v24

    move/from16 v3, v25

    move/from16 v7, v26

    move/from16 v9, v27

    move/from16 v11, p1

    goto/16 :goto_5f

    .line 308
    :cond_166
    move-object/from16 v24, v2

    move v2, v6

    move-object/from16 v3, v24

    move v4, v2

    move/from16 v5, v16

    move v6, v1

    move v7, v15

    move v8, v15

    invoke-virtual/range {v3 .. v8}, Lcom/mrkeyboard/app/Keyboard;->finishCustomBuild(IIIII)V

    .line 309
    return-object v24
.end method

.method private static configureKeyFromSpec(Landroid/content/res/Resources;Ljava/util/List;Lcom/mrkeyboard/app/Keyboard$Key;Lcom/mrkeyboard/app/SheetModel$KeySpec;)V
    .registers 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/res/Resources;",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Lcom/mrkeyboard/app/Keyboard$Key;",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            ")V"
        }
    .end annotation

    .line 313
    iget-object v0, p3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetModel;->normalizeType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 314
    iget-object v1, p3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    const-string v2, ""

    if-nez v1, :cond_e

    move-object v1, v2

    goto :goto_10

    :cond_e
    iget-object v1, p3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    .line 315
    :goto_10
    iget-object v3, p3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    if-nez v3, :cond_15

    goto :goto_17

    :cond_15
    iget-object v2, p3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 317
    :goto_17
    const-string v3, "spacer"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    const/4 v4, 0x0

    if-eqz v3, :cond_2d

    .line 318
    const/16 p0, -0x18f

    filled-new-array {p0}, [I

    move-result-object p0

    iput-object p0, p2, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    .line 319
    iput-object v4, p2, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    .line 320
    iput-object v4, p2, Lcom/mrkeyboard/app/Keyboard$Key;->text:Ljava/lang/CharSequence;

    .line 321
    return-void

    .line 323
    :cond_2d
    const-string v3, "tasker"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    const/4 v5, 0x0

    if-eqz v3, :cond_61

    .line 324
    invoke-static {v2}, Lcom/mrkeyboard/app/SheetModel;->stripTaskerPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 325
    filled-new-array {v5}, [I

    move-result-object p1

    iput-object p1, p2, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    .line 326
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "tskcmd:"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p2, Lcom/mrkeyboard/app/Keyboard$Key;->text:Ljava/lang/CharSequence;

    .line 327
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_5c

    move-object v1, p0

    :cond_5c
    iput-object v1, p2, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    .line 328
    iput-boolean v5, p2, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    .line 329
    goto :goto_c6

    :cond_61
    const-string v3, "sheet"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    const/4 v6, 0x1

    if-eqz v3, :cond_83

    .line 330
    invoke-static {p1, v2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->resolveSheetTargetCode(Ljava/util/List;Ljava/lang/String;)I

    move-result p0

    filled-new-array {p0}, [I

    move-result-object p0

    iput-object p0, p2, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    .line 331
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result p0

    if-eqz p0, :cond_7e

    invoke-static {p3, p1}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->effectiveDisplayLabel(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/util/List;)Ljava/lang/String;

    move-result-object v1

    :cond_7e
    iput-object v1, p2, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    .line 332
    iput-boolean v6, p2, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    goto :goto_c6

    .line 333
    :cond_83
    const-string p1, "special"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_99

    .line 334
    invoke-static {v2, v5}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->parseSafeInt(Ljava/lang/String;I)I

    move-result p1

    .line 335
    filled-new-array {p1}, [I

    move-result-object v0

    iput-object v0, p2, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    .line 336
    invoke-static {p0, p2, p1, v1}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->applySpecialKeyTraits(Landroid/content/res/Resources;Lcom/mrkeyboard/app/Keyboard$Key;ILjava/lang/String;)V

    .line 337
    goto :goto_c6

    .line 338
    :cond_99
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result p0

    if-eqz p0, :cond_a0

    move-object v2, v1

    .line 339
    :cond_a0
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result p0

    if-eqz p0, :cond_a7

    move-object v1, v2

    :cond_a7
    iput-object v1, p2, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    .line 340
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result p0

    if-ne p0, v6, :cond_bc

    .line 341
    invoke-virtual {v2, v5}, Ljava/lang/String;->charAt(I)C

    move-result p0

    filled-new-array {p0}, [I

    move-result-object p0

    iput-object p0, p2, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    .line 342
    iput-object v4, p2, Lcom/mrkeyboard/app/Keyboard$Key;->text:Ljava/lang/CharSequence;

    goto :goto_c4

    .line 344
    :cond_bc
    filled-new-array {v5}, [I

    move-result-object p0

    iput-object p0, p2, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    .line 345
    iput-object v2, p2, Lcom/mrkeyboard/app/Keyboard$Key;->text:Ljava/lang/CharSequence;

    .line 347
    :goto_c4
    iput-boolean v5, p2, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    .line 350
    :goto_c6
    invoke-virtual {p3}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasPopupKeys()Z

    move-result p0

    if-eqz p0, :cond_d1

    .line 351
    iget-object p0, p3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    iput-object p0, p2, Lcom/mrkeyboard/app/Keyboard$Key;->popupKeys:Ljava/util/List;

    goto :goto_e0

    .line 352
    :cond_d1
    invoke-virtual {p3}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasPopupChars()Z

    move-result p0

    if-eqz p0, :cond_e0

    .line 353
    iget-object p0, p3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    iput-object p0, p2, Lcom/mrkeyboard/app/Keyboard$Key;->popupCharacters:Ljava/lang/CharSequence;

    .line 354
    const p0, 0x7f0f000a

    iput p0, p2, Lcom/mrkeyboard/app/Keyboard$Key;->popupResId:I

    .line 356
    :cond_e0
    :goto_e0
    return-void
.end method

.method public static effectiveDisplayLabel(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/util/List;)Ljava/lang/String;
    .registers 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 408
    const-string v0, ""

    if-eqz p0, :cond_88

    const-string v1, "spacer"

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_10

    goto/16 :goto_88

    .line 411
    :cond_10
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    if-eqz v1, :cond_1f

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1f

    .line 412
    iget-object p0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    return-object p0

    .line 414
    :cond_1f
    const-string v1, "special"

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_35

    .line 415
    iget-object p0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->parseSafeInt(Ljava/lang/String;I)I

    move-result p0

    invoke-static {p0}, Lcom/mrkeyboard/app/SpecialKeyPicker;->defaultLabelForCode(I)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 417
    :cond_35
    const-string v1, "sheet"

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_80

    .line 418
    const-string v0, "abc"

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4c

    const-string p0, "ABC"

    return-object p0

    .line 419
    :cond_4c
    const-string v0, "prev"

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_59

    const-string p0, "\u25c0Fol"

    return-object p0

    .line 420
    :cond_59
    if-eqz p1, :cond_7d

    .line 421
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    :goto_5f
    if-ge v2, v0, :cond_7d

    .line 422
    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7a

    .line 423
    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object p0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    return-object p0

    .line 421
    :cond_7a
    add-int/lit8 v2, v2, 0x1

    goto :goto_5f

    .line 427
    :cond_7d
    const-string p0, "123"

    return-object p0

    .line 429
    :cond_80
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    if-nez p1, :cond_85

    goto :goto_87

    :cond_85
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    :goto_87
    return-object v0

    .line 409
    :cond_88
    :goto_88
    return-object v0
.end method

.method private static loadBoundedDrawable(Landroid/content/res/Resources;I)Landroid/graphics/drawable/Drawable;
    .registers 4

    .line 454
    :try_start_0
    invoke-virtual {p0, p1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    .line 455
    if-eqz p0, :cond_12

    .line 456
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result p1

    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v0

    const/4 v1, 0x0

    invoke-virtual {p0, v1, v1, p1, v0}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V
    :try_end_12
    .catchall {:try_start_0 .. :try_end_12} :catchall_13

    .line 458
    :cond_12
    return-object p0

    .line 459
    :catchall_13
    move-exception p0

    .line 460
    const/4 p0, 0x0

    return-object p0
.end method

.method private static makeRow(Lcom/mrkeyboard/app/Keyboard;FIII)Lcom/mrkeyboard/app/Keyboard$Row;
    .registers 6

    .line 465
    new-instance v0, Lcom/mrkeyboard/app/Keyboard$Row;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/Keyboard$Row;-><init>(Lcom/mrkeyboard/app/Keyboard;)V

    .line 466
    iput p1, v0, Lcom/mrkeyboard/app/Keyboard$Row;->defaultWidth:F

    .line 467
    iput p2, v0, Lcom/mrkeyboard/app/Keyboard$Row;->defaultHeight:I

    .line 468
    const/4 p0, 0x0

    iput p0, v0, Lcom/mrkeyboard/app/Keyboard$Row;->defaultHorizontalGap:F

    .line 469
    iput p3, v0, Lcom/mrkeyboard/app/Keyboard$Row;->verticalGap:I

    .line 470
    iput p4, v0, Lcom/mrkeyboard/app/Keyboard$Row;->mode:I

    .line 471
    const/4 p0, 0x0

    iput-boolean p0, v0, Lcom/mrkeyboard/app/Keyboard$Row;->extension:Z

    .line 472
    return-object v0
.end method

.method private static parseSafeInt(Ljava/lang/String;I)I
    .registers 2

    .line 481
    if-nez p0, :cond_3

    return p1

    .line 483
    :cond_3
    :try_start_3
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_b} :catch_c

    return p0

    .line 484
    :catch_c
    move-exception p0

    .line 485
    return p1
.end method

.method private static placeKey(Lcom/mrkeyboard/app/Keyboard$Key;FFFFII)V
    .registers 15

    .line 476
    const/high16 v0, 0x3f800000    # 1.0f

    sub-float/2addr p2, p3

    invoke-static {v0, p2}, Ljava/lang/Math;->max(FF)F

    move-result v3

    .line 477
    const/high16 p2, 0x40000000    # 2.0f

    div-float/2addr p3, p2

    sub-float v2, p1, p3

    const/4 v4, 0x0

    move-object v1, p0

    move v5, p4

    move v6, p5

    move v7, p6

    invoke-virtual/range {v1 .. v7}, Lcom/mrkeyboard/app/Keyboard$Key;->setCustomBounds(FFFFII)V

    .line 478
    return-void
.end method

.method public static resolveSheetTargetCode(Ljava/util/List;Ljava/lang/String;)I
    .registers 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Ljava/lang/String;",
            ")I"
        }
    .end annotation

    .line 433
    const/16 v0, -0x12c

    if-eqz p1, :cond_48

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_48

    const-string v1, "next"

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_13

    goto :goto_48

    .line 436
    :cond_13
    const-string v1, "prev"

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1e

    .line 437
    const/16 p0, -0x12b

    return p0

    .line 439
    :cond_1e
    const-string v1, "abc"

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/16 v2, -0x190

    if-eqz v1, :cond_29

    .line 440
    return v2

    .line 442
    :cond_29
    if-eqz p0, :cond_47

    .line 443
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v1

    const/4 v3, 0x0

    :goto_30
    if-ge v3, v1, :cond_47

    .line 444
    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {p1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_44

    .line 445
    add-int/lit8 v3, v3, 0x1

    sub-int/2addr v2, v3

    return v2

    .line 443
    :cond_44
    add-int/lit8 v3, v3, 0x1

    goto :goto_30

    .line 449
    :cond_47
    return v0

    .line 434
    :cond_48
    :goto_48
    return v0
.end method
