.class final Lcom/mrkeyboard/app/MrThemePreview;
.super Landroid/view/View;
.source "MrThemePreview.java"


# static fields
.field private static final ATTR_ACTIVE:I = 0x10100a2

.field private static final ATTR_CHECKABLE:I = 0x101009f

.field private static final ATTR_CHECKED:I = 0x10100a0

.field static final BAR_DP:F = 48.0f

.field static final BAR_SHARE:F = 0.17f

.field static final CORNER_DP:F = 12.0f

.field static final DASH_LOCK:I = 0x3

.field static final DASH_NONE:I = 0x0

.field static final DASH_OFF:I = 0x1

.field static final DASH_ON:I = 0x2

.field static final FACE_GAP_DP:F = 3.0f

.field static final FACE_LOCK:I = 0x2

.field static final FACE_NORMAL:I = 0x0

.field static final FACE_ON:I = 0x1

.field static final FULL_ROWS:I = 0x7

.field static final HEIGHT_DEFAULT:I = 0x22

.field static final HEIGHT_MAX:I = 0x4b

.field static final HEIGHT_MIN:I = 0xf

.field private static final MOD_KEYS:[Z

.field private static final MOD_LABELS:[Ljava/lang/String;

.field private static final MOD_WIDTHS:[F

.field static final PREF_HEIGHT:Ljava/lang/String; = "settings_height_portrait"

.field static final ROWS:[Ljava/lang/String;

.field static final SMALL_ROWS:I = 0x5

.field private static final STATE_LOCK:[I

.field private static final STATE_MOD:[I

.field private static final STATE_NORMAL:[I

.field private static final STATE_ON:[I

.field static final TOOLBAR_KEY_ICON:Ljava/lang/String; = "sym_keyboard_mr_toolbar"

.field static final TOOL_ICONS:[Ljava/lang/String;

.field static final TOOL_ICON_DP:F = 24.0f

.field private static final TOP_KEYS:[Z

.field private static final TOP_LABELS:[Ljava/lang/String;

.field private static final TOP_WIDTHS:[F

.field static final WORDS:[F

.field static final WORD_GAP:F = 0.11f


# instance fields
.field private mAccent:Landroid/graphics/drawable/Drawable;

.field private mAreaH:F

.field private mAreaTop:F

.field private mAreaW:F

.field private mBg:Landroid/graphics/Bitmap;

.field private mBgKey:Ljava/lang/String;

.field private final mBgPaint:Landroid/graphics/Paint;

.field private mCheck:I

.field private mChecked:Z

.field private mCurrent:[F

.field private mCurrentFilter:Landroid/graphics/ColorFilter;

.field private mCurrentHue:I

.field private final mDensity:F

.field private mDrawn:I

.field private mEnd:I

.field private mFace:Landroid/graphics/drawable/Drawable;

.field private mFaceTag:Ljava/lang/String;

.field private mFacesLook:Lcom/mrkeyboard/app/MrKeyLook;

.field private mFilter:[Landroid/graphics/ColorFilter;

.field private mFrom:I

.field private mFull:Z

.field private mFullAspect:F

.field private mImage:Landroid/graphics/Bitmap;

.field private mKeyWidthPx:I

.field private mLook:Lcom/mrkeyboard/app/MrKeyLook;

.field private mMatrix:[[F

.field private final mMetrics:Landroid/graphics/Paint$FontMetrics;

.field private mMid:I

.field private final mPaint:Landroid/graphics/Paint;

.field private mPlus:Z

.field private mPlusFill:I

.field private mPlusInk:I

.field private mPlusLine:I

.field private mRing:I

.field private mSoft:I

.field private mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

.field private mStart:I

.field private mTag:Ljava/lang/String;

.field private final mText:Landroid/graphics/Paint;

.field private mToolIcons:[Landroid/graphics/drawable/Drawable;

.field private mToolbarKeyIcon:Landroid/graphics/drawable/Drawable;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/16 v7, 0x8

    const/4 v6, 0x2

    const/4 v5, 0x1

    const/4 v4, 0x3

    const/4 v3, 0x0

    .line 33
    new-array v0, v4, [Ljava/lang/String;

    const-string v1, "QWERTYUIOP"

    aput-object v1, v0, v3

    const-string v1, "ASDFGHJKL"

    aput-object v1, v0, v5

    const-string v1, "ZXCVBNM"

    aput-object v1, v0, v6

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->ROWS:[Ljava/lang/String;

    .line 52
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->STATE_NORMAL:[I

    .line 53
    new-array v0, v5, [I

    const v1, 0x101009f

    aput v1, v0, v3

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->STATE_MOD:[I

    .line 54
    new-array v0, v6, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->STATE_ON:[I

    .line 55
    new-array v0, v4, [I

    fill-array-data v0, :array_1

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->STATE_LOCK:[I

    .line 57
    new-array v0, v4, [F

    fill-array-data v0, :array_2

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    .line 465
    const/16 v0, 0x9

    new-array v0, v0, [F

    fill-array-data v0, :array_3

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->TOP_WIDTHS:[F

    .line 466
    const/16 v0, 0x9

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, ""

    aput-object v1, v0, v3

    const-string v1, "-"

    aput-object v1, v0, v5

    const-string v1, "="

    aput-object v1, v0, v6

    const-string v1, "=>"

    aput-object v1, v0, v4

    const/4 v1, 0x4

    const-string v2, "/"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "\u21e4"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "\u2191"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "\u21e5"

    aput-object v2, v0, v1

    const-string v1, "("

    aput-object v1, v0, v7

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->TOP_LABELS:[Ljava/lang/String;

    .line 467
    const/16 v0, 0x9

    new-array v0, v0, [Z

    fill-array-data v0, :array_4

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->TOP_KEYS:[Z

    .line 470
    new-array v0, v7, [Ljava/lang/String;

    const-string v1, "ic_mr_clip"

    aput-object v1, v0, v3

    const-string v1, "ic_mr_trans"

    aput-object v1, v0, v5

    const-string v1, "ic_mr_aied"

    aput-object v1, v0, v6

    const-string v1, "ic_mr_attach"

    aput-object v1, v0, v4

    const/4 v1, 0x4

    const-string v2, "ic_mr_fonts"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "ic_mr_emote"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "ic_mr_sheets"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "ic_mr_tune"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->TOOL_ICONS:[Ljava/lang/String;

    .line 475
    new-array v0, v7, [F

    fill-array-data v0, :array_5

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->MOD_WIDTHS:[F

    .line 476
    new-array v0, v7, [Ljava/lang/String;

    const-string v1, "Ctrl"

    aput-object v1, v0, v3

    const-string v1, "Alt"

    aput-object v1, v0, v5

    const-string v1, "\u21b9"

    aput-object v1, v0, v6

    const-string v1, "<>"

    aput-object v1, v0, v4

    const/4 v1, 0x4

    const-string v2, "\u2190"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "\u2193"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "\u2192"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "{"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->MOD_LABELS:[Ljava/lang/String;

    .line 478
    new-array v0, v7, [Z

    fill-array-data v0, :array_6

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->MOD_KEYS:[Z

    return-void

    .line 54
    nop

    :array_0
    .array-data 4
        0x101009f
        0x10100a0
    .end array-data

    .line 55
    :array_1
    .array-data 4
        0x10100a2
        0x101009f
        0x10100a0
    .end array-data

    .line 57
    :array_2
    .array-data 4
        0x3e4ccccd    # 0.2f
        0x3e0f5c29    # 0.14f
        0x3e3851ec    # 0.18f
    .end array-data

    .line 465
    :array_3
    .array-data 4
        0x41233333    # 10.2f
        0x41233333    # 10.2f
        0x41233333    # 10.2f
        0x41233333    # 10.2f
        0x41233333    # 10.2f
        0x4151999a    # 13.1f
        0x4151999a    # 13.1f
        0x4151999a    # 13.1f
        0x41233333    # 10.2f
    .end array-data

    .line 467
    :array_4
    .array-data 1
        0x1t
        0x0t
        0x0t
        0x0t
        0x0t
        0x1t
        0x1t
        0x1t
        0x0t
    .end array-data

    .line 475
    nop

    :array_5
    .array-data 4
        0x41633333    # 14.2f
        0x41533333    # 13.2f
        0x4154cccd    # 13.3f
        0x41233333    # 10.2f
        0x4151999a    # 13.1f
        0x4151999a    # 13.1f
        0x4151999a    # 13.1f
        0x41233333    # 10.2f
    .end array-data

    .line 478
    :array_6
    .array-data 1
        0x1t
        0x1t
        0x1t
        0x0t
        0x1t
        0x1t
        0x1t
        0x0t
    .end array-data
.end method

.method constructor <init>(Landroid/content/Context;)V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 101
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 59
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v2}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    .line 61
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBgPaint:Landroid/graphics/Paint;

    .line 62
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v2}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    .line 63
    new-instance v0, Landroid/graphics/Paint$FontMetrics;

    invoke-direct {v0}, Landroid/graphics/Paint$FontMetrics;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMetrics:Landroid/graphics/Paint$FontMetrics;

    .line 68
    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 69
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 74
    const v0, -0xb07301

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mRing:I

    const/4 v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCheck:I

    .line 77
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFullAspect:F

    .line 102
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    .line 104
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 105
    iget v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v0, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mKeyWidthPx:I

    .line 106
    invoke-static {p1}, Lcom/mrkeyboard/app/MrThemePreview;->fullAspect(Landroid/content/Context;)F

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFullAspect:F

    .line 107
    return-void
.end method

.method private area(FFF)V
    .locals 1

    .prologue
    .line 714
    iput p1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAreaW:F

    .line 715
    iput p2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAreaTop:F

    .line 716
    sub-float v0, p3, p2

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAreaH:F

    .line 717
    return-void
.end method

.method private background(Landroid/graphics/Canvas;Landroid/content/Context;IIZ)V
    .locals 9

    .prologue
    const/4 v8, 0x0

    const v7, -0xdfdfe0

    const/4 v6, 0x0

    .line 299
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->needsBitmap(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mImage:Landroid/graphics/Bitmap;

    if-nez v0, :cond_1

    .line 300
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v1, "kbd_bg"

    invoke-static {p2, v0, v1, v7}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->drawColor(I)V

    .line 323
    :goto_0
    return-void

    .line 303
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->format()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "|"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "|"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSoft:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "|"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "|"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mImage:Landroid/graphics/Bitmap;

    invoke-static {v1}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 304
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBgKey:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 306
    :cond_2
    :try_start_0
    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {p3, p4, v1}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 307
    new-instance v2, Landroid/graphics/Canvas;

    invoke-direct {v2, v1}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 308
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mImage:Landroid/graphics/Bitmap;

    invoke-static {v2, v3, p3, p4, v4}, Lcom/mrkeyboard/app/MrBackdrop;->draw(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/MrBackdrop$Spec;IILandroid/graphics/Bitmap;)V

    .line 309
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mImage:Landroid/graphics/Bitmap;

    iget v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSoft:I

    invoke-static {v3, v4, p5, v5}, Lcom/mrkeyboard/app/MrBackdrop;->look(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;ZI)Lcom/mrkeyboard/app/MrBackdrop$Look;

    move-result-object v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrBackdropDrawable;->veilOver(Lcom/mrkeyboard/app/MrBackdrop$Look;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/graphics/Canvas;->drawColor(I)V

    .line 310
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    .line 311
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBgKey:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_1

    .line 318
    :cond_3
    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    if-nez v0, :cond_4

    .line 319
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v1, "kbd_bg"

    invoke-static {p2, v0, v1, v7}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->drawColor(I)V

    goto/16 :goto_0

    .line 312
    :catch_0
    move-exception v0

    .line 313
    iput-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    goto :goto_1

    .line 314
    :catch_1
    move-exception v0

    .line 315
    iput-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    goto :goto_1

    .line 322
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1, v6, v6, p3, p4}, Landroid/graphics/Rect;-><init>(IIII)V

    new-instance v2, Landroid/graphics/Rect;

    invoke-direct {v2, v6, v6, p3, p4}, Landroid/graphics/Rect;-><init>(IIII)V

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBgPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    goto/16 :goto_0
.end method

.method private badge(Landroid/graphics/Canvas;II)V
    .locals 12

    .prologue
    const/high16 v8, 0x40c00000    # 6.0f

    const v11, 0x3eb851ec    # 0.36f

    const v10, 0x3df5c28f    # 0.12f

    const/high16 v9, 0x40000000    # 2.0f

    .line 752
    const/high16 v0, 0x40200000    # 2.5f

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v0, v1

    .line 753
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 754
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 755
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 756
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mRing:I

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 757
    const/high16 v1, 0x41400000    # 12.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v5, v1, v2

    .line 758
    div-float v1, v0, v9

    div-float v2, v0, v9

    int-to-float v3, p2

    div-float v4, v0, v9

    sub-float/2addr v3, v4

    int-to-float v4, p3

    div-float/2addr v0, v9

    sub-float/2addr v4, v0

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v6, v5

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 759
    const/high16 v0, 0x41100000    # 9.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v6, v0, v1

    .line 760
    int-to-float v0, p2

    sub-float/2addr v0, v6

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v1, v8

    sub-float v7, v0, v1

    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v0, v8

    add-float v8, v6, v0

    .line 761
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 762
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mRing:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 763
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v7, v8, v6, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 764
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 765
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v1, v9

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 766
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCheck:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 767
    const v0, 0x3ee66666    # 0.45f

    mul-float/2addr v0, v6

    sub-float v1, v7, v0

    const v0, 0x3ca3d70a    # 0.02f

    mul-float/2addr v0, v6

    add-float v2, v8, v0

    mul-float v0, v6, v10

    sub-float v3, v7, v0

    mul-float v0, v6, v11

    add-float v4, v8, v0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 768
    mul-float v0, v6, v10

    sub-float v1, v7, v0

    mul-float v0, v6, v11

    add-float v2, v8, v0

    const v0, 0x3ef5c28f    # 0.48f

    mul-float/2addr v0, v6

    add-float v3, v7, v0

    const v0, 0x3eae147b    # 0.34f

    mul-float/2addr v0, v6

    sub-float v4, v8, v0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 769
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 770
    return-void
.end method

.method private bar(Landroid/graphics/Canvas;Landroid/content/Context;FFF)V
    .locals 15

    .prologue
    .line 335
    move-object/from16 v0, p2

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrThemePreview;->ink(Landroid/content/Context;)I

    move-result v10

    .line 336
    mul-float v11, p4, p5

    .line 337
    const/high16 v1, 0x40400000    # 3.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v1, v2

    add-float/2addr v1, v11

    const/high16 v2, 0x40000000    # 2.0f

    div-float v12, v1, v2

    .line 338
    const v1, 0x3e6147ae    # 0.22f

    mul-float v13, v11, v1

    .line 339
    const v1, 0x3de147ae    # 0.11f

    mul-float v1, v1, p3

    sget-object v2, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    array-length v2, v2

    add-int/lit8 v2, v2, -0x1

    int-to-float v2, v2

    mul-float/2addr v2, v1

    .line 340
    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    array-length v4, v3

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v4, :cond_0

    aget v5, v3, v1

    mul-float v5, v5, p3

    add-float/2addr v2, v5

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 341
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 342
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 343
    sub-float v1, p3, v2

    const/high16 v2, 0x40000000    # 2.0f

    div-float v2, v1, v2

    .line 344
    const/4 v1, 0x0

    move v9, v1

    :goto_1
    sget-object v1, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    array-length v1, v1

    if-ge v9, v1, :cond_2

    .line 345
    sget-object v1, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    aget v1, v1, v9

    mul-float v14, p3, v1

    .line 346
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const v3, 0x3f333333    # 0.7f

    invoke-static {v10, v3}, Lcom/mrkeyboard/app/MrThemePreview;->withAlpha(IF)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 347
    const/high16 v1, 0x40000000    # 2.0f

    div-float v1, v13, v1

    sub-float v3, v12, v1

    add-float v4, v2, v14

    const/high16 v1, 0x40000000    # 2.0f

    div-float v1, v13, v1

    add-float v5, v12, v1

    const/high16 v1, 0x40000000    # 2.0f

    div-float v6, v13, v1

    const/high16 v1, 0x40000000    # 2.0f

    div-float v7, v13, v1

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v1, p1

    invoke-virtual/range {v1 .. v8}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 348
    const v1, 0x3de147ae    # 0.11f

    mul-float v1, v1, p3

    add-float/2addr v1, v14

    add-float v7, v2, v1

    .line 349
    sget-object v1, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    array-length v1, v1

    add-int/lit8 v1, v1, -0x1

    if-ge v9, v1, :cond_1

    .line 350
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/high16 v2, 0x3e800000    # 0.25f

    invoke-static {v10, v2}, Lcom/mrkeyboard/app/MrThemePreview;->withAlpha(IF)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 351
    const v1, 0x3de147ae    # 0.11f

    mul-float v1, v1, p3

    const/high16 v2, 0x40000000    # 2.0f

    div-float/2addr v1, v2

    sub-float v1, v7, v1

    const/high16 v2, 0x3f800000    # 1.0f

    sub-float v2, v1, v2

    const v1, 0x3e6147ae    # 0.22f

    mul-float/2addr v1, v11

    sub-float v3, v12, v1

    const v1, 0x3de147ae    # 0.11f

    mul-float v1, v1, p3

    const/high16 v4, 0x40000000    # 2.0f

    div-float/2addr v1, v4

    sub-float v1, v7, v1

    const/high16 v4, 0x3f800000    # 1.0f

    add-float/2addr v4, v1

    const v1, 0x3e6147ae    # 0.22f

    mul-float/2addr v1, v11

    add-float v5, v12, v1

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v1, p1

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 344
    :cond_1
    add-int/lit8 v1, v9, 0x1

    move v9, v1

    move v2, v7

    goto :goto_1

    .line 354
    :cond_2
    return-void
.end method

.method private static corner(Landroid/graphics/Path;FFFFI)V
    .locals 8

    .prologue
    .line 792
    const/4 v0, 0x1

    :goto_0
    if-gt v0, p5, :cond_0

    .line 793
    float-to-double v2, p4

    const-wide v4, 0x4056800000000000L    # 90.0

    int-to-double v6, v0

    mul-double/2addr v4, v6

    int-to-double v6, p5

    div-double/2addr v4, v6

    add-double/2addr v2, v4

    invoke-static {v2, v3}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v2

    .line 794
    invoke-static {v2, v3}, Ljava/lang/Math;->cos(D)D

    move-result-wide v4

    double-to-float v1, v4

    mul-float/2addr v1, p3

    add-float/2addr v1, p1

    invoke-static {v2, v3}, Ljava/lang/Math;->sin(D)D

    move-result-wide v2

    double-to-float v2, v2

    mul-float/2addr v2, p3

    add-float/2addr v2, p2

    invoke-virtual {p0, v1, v2}, Landroid/graphics/Path;->lineTo(FF)V

    .line 792
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 796
    :cond_0
    return-void
.end method

.method private dash(Landroid/graphics/Canvas;III)V
    .locals 8

    .prologue
    const/4 v4, 0x3

    const/high16 v7, 0x40000000    # 2.0f

    .line 619
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getContext()Landroid/content/Context;

    move-result-object v1

    .line 620
    if-ne p4, v4, :cond_2

    const-string v0, "modifier_indicator_lock"

    .line 621
    :goto_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const v3, -0x7f7f80

    invoke-static {v1, v2, v0, v3}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    .line 622
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    if-eqz v1, :cond_0

    if-eq p4, v4, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v0

    .line 623
    :cond_0
    const/4 v1, 0x1

    if-ne p4, v1, :cond_1

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeyLook;->dashOff(I)I

    move-result v0

    .line 624
    :cond_1
    const/high16 v1, 0x41600000    # 14.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v1, v2

    int-to-float v2, p2

    const v3, 0x3e99999a    # 0.3f

    mul-float/2addr v2, v3

    invoke-static {v1, v2}, Ljava/lang/Math;->min(FF)F

    move-result v3

    const/high16 v1, 0x40400000    # 3.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v6, v1, v2

    .line 625
    int-to-float v1, p3

    const/high16 v2, 0x41000000    # 8.0f

    iget v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v2, v4

    sub-float v4, v1, v2

    .line 626
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 627
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 628
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 629
    int-to-float v0, p2

    div-float/2addr v0, v7

    div-float v1, v3, v7

    sub-float v1, v0, v1

    sub-float v2, v4, v6

    int-to-float v0, p2

    div-float/2addr v0, v7

    div-float/2addr v3, v7

    add-float/2addr v3, v0

    div-float v5, v6, v7

    div-float/2addr v6, v7

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 630
    return-void

    .line 620
    :cond_2
    const/4 v0, 0x2

    if-ne p4, v0, :cond_3

    const-string v0, "modifier_indicator_on"

    goto :goto_0

    :cond_3
    const-string v0, "modifier_indicator_off"

    goto :goto_0
.end method

.method private static face(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 739
    if-nez p1, :cond_1

    .line 746
    :cond_0
    :goto_0
    return-object v0

    .line 741
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    .line 742
    if-eqz v1, :cond_0

    .line 743
    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object v2

    .line 744
    if-nez v2, :cond_2

    :goto_1
    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    goto :goto_0

    :cond_2
    invoke-virtual {v2}, Landroid/graphics/drawable/Drawable$ConstantState;->newDrawable()Landroid/graphics/drawable/Drawable;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_1

    .line 745
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private faces(Landroid/content/Context;)V
    .locals 6

    .prologue
    const/16 v5, 0x31

    const/4 v3, 0x1

    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 683
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFace:Landroid/graphics/drawable/Drawable;

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    if-nez v2, :cond_2

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFaceTag:Ljava/lang/String;

    if-nez v2, :cond_3

    :cond_0
    move v2, v3

    .line 684
    :goto_0
    if-nez v2, :cond_1

    .line 685
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFaceTag:Ljava/lang/String;

    .line 686
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    invoke-static {p1, v4, v0}, Lcom/mrkeyboard/app/MrThemeColors;->keyDrawable(Landroid/content/Context;Ljava/lang/String;Z)I

    move-result v4

    invoke-static {p1, v4}, Lcom/mrkeyboard/app/MrThemePreview;->face(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v4

    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFace:Landroid/graphics/drawable/Drawable;

    .line 687
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    invoke-static {p1, v4, v3}, Lcom/mrkeyboard/app/MrThemeColors;->keyDrawable(Landroid/content/Context;Ljava/lang/String;Z)I

    move-result v4

    invoke-static {p1, v4}, Lcom/mrkeyboard/app/MrThemePreview;->face(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v4

    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAccent:Landroid/graphics/drawable/Drawable;

    .line 688
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFacesLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 690
    :cond_1
    if-eqz v2, :cond_4

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFacesLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    if-ne v2, v4, :cond_4

    .line 704
    :goto_1
    return-void

    .line 683
    :cond_2
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFaceTag:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    :cond_3
    move v2, v0

    goto :goto_0

    .line 691
    :cond_4
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFacesLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 692
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v4, "spectrum_start"

    invoke-static {p1, v2, v4}, Lcom/mrkeyboard/app/MrThemeColors;->own(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    iput v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mStart:I

    .line 693
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v4, "spectrum_mid"

    invoke-static {p1, v2, v4}, Lcom/mrkeyboard/app/MrThemeColors;->own(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    iput v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMid:I

    .line 694
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v4, "spectrum_end"

    invoke-static {p1, v2, v4}, Lcom/mrkeyboard/app/MrThemeColors;->own(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    iput v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mEnd:I

    .line 695
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v2

    if-eqz v2, :cond_6

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    invoke-static {v2, v4}, Lcom/mrkeyboard/app/MrKeyLook;->spectrum(Ljava/lang/String;Lcom/mrkeyboard/app/MrKeyLook;)[I

    move-result-object v2

    .line 696
    :goto_2
    if-eqz v2, :cond_5

    .line 697
    aget v4, v2, v0

    iput v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mStart:I

    .line 698
    aget v3, v2, v3

    iput v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMid:I

    .line 699
    const/4 v3, 0x2

    aget v2, v2, v3

    iput v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mEnd:I

    .line 701
    :cond_5
    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mStart:I

    if-nez v2, :cond_7

    :goto_3
    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFrom:I

    .line 702
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFrom:I

    if-nez v0, :cond_8

    move-object v0, v1

    :goto_4
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMatrix:[[F

    .line 703
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFrom:I

    if-nez v0, :cond_9

    :goto_5
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFilter:[Landroid/graphics/ColorFilter;

    goto :goto_1

    :cond_6
    move-object v2, v1

    .line 695
    goto :goto_2

    .line 701
    :cond_7
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v2, "glow"

    invoke-static {p1, v0, v2}, Lcom/mrkeyboard/app/MrThemeColors;->own(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_3

    .line 702
    :cond_8
    new-array v0, v5, [[F

    goto :goto_4

    .line 703
    :cond_9
    new-array v1, v5, [Landroid/graphics/ColorFilter;

    goto :goto_5
.end method

.method private flat(Landroid/graphics/Canvas;IIZI)V
    .locals 12

    .prologue
    .line 634
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getContext()Landroid/content/Context;

    move-result-object v6

    .line 635
    const/4 v1, 0x2

    move/from16 v0, p5

    if-ne v0, v1, :cond_1

    const-string v1, "lock"

    move-object v5, v1

    .line 636
    :goto_0
    if-eqz p4, :cond_3

    const-string v1, "key_acc_normal_"

    move-object v2, v1

    .line 637
    :goto_1
    if-eqz p4, :cond_4

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "key_acc_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 639
    :goto_2
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v7, "fill"

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "top"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    const v9, -0xc5c0b9

    invoke-static {v6, v7, v8, v9}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v7

    invoke-static {v6, v3, v4, v7}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v3

    .line 640
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "lip"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v9, "bottom"

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v6, v8, v2, v3}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v2

    invoke-static {v6, v4, v7, v2}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v2

    .line 641
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "fill"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "top"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v6, v8, v9, v3}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v3

    invoke-static {v6, v4, v7, v3}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v3

    .line 642
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "lip"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v9, "bottom"

    invoke-virtual {v1, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    if-nez p5, :cond_5

    move v1, v2

    :goto_3
    invoke-static {v6, v8, v9, v1}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v1

    invoke-static {v6, v4, v7, v1}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v4

    .line 644
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz p4, :cond_6

    const-string v1, "key_acc_"

    :goto_4
    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v5, "_edge"

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v6, v2, v1}, Lcom/mrkeyboard/app/MrThemeColors;->own(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 645
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    if-eqz v1, :cond_c

    .line 646
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    invoke-static {v1, v3}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v1

    .line 647
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    invoke-static {v3, v4}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v3

    .line 648
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    invoke-static {v4, v2}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v2

    move v4, v1

    .line 650
    :goto_5
    if-ne v3, v4, :cond_7

    ushr-int/lit8 v1, v4, 0x18

    const/16 v5, 0xff

    if-eq v1, v5, :cond_7

    const/4 v1, 0x1

    .line 651
    :goto_6
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v5

    if-eqz v5, :cond_b

    .line 653
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v5, v5, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    int-to-float v5, v5

    const/high16 v6, 0x42c80000    # 100.0f

    div-float/2addr v5, v6

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrGlow;->scale(IF)I

    move-result v4

    .line 654
    if-eqz v1, :cond_8

    move v3, v4

    .line 655
    :goto_7
    if-nez v2, :cond_9

    const/4 v2, 0x0

    .line 657
    :goto_8
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v5, v5, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    if-eqz v5, :cond_b

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v2, v2, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    invoke-virtual {v5}, Lcom/mrkeyboard/app/MrKeyLook;->lineAlpha()F

    move-result v5

    invoke-static {v2, v5}, Lcom/mrkeyboard/app/MrGlow;->fade(IF)I

    move-result v2

    move v9, v2

    move v10, v4

    .line 659
    :goto_9
    const/high16 v2, 0x40400000    # 3.0f

    iget v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v2, v4

    const/high16 v4, 0x41000000    # 8.0f

    iget v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v6, v4, v5

    .line 660
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 661
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v5, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v4, v5}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 662
    if-eqz v1, :cond_a

    .line 664
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v10}, Landroid/graphics/Paint;->setColor(I)V

    .line 665
    int-to-float v1, p2

    sub-float v4, v1, v2

    int-to-float v1, p3

    sub-float v5, v1, v2

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v1, p1

    move v3, v2

    move v7, v6

    invoke-virtual/range {v1 .. v8}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 666
    if-eqz v9, :cond_0

    .line 667
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 668
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 669
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v9}, Landroid/graphics/Paint;->setColor(I)V

    .line 670
    int-to-float v1, p2

    sub-float v4, v1, v2

    int-to-float v1, p3

    sub-float v5, v1, v2

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v1, p1

    move v3, v2

    move v7, v6

    invoke-virtual/range {v1 .. v8}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 671
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 679
    :cond_0
    :goto_a
    return-void

    .line 635
    :cond_1
    const/4 v1, 0x1

    move/from16 v0, p5

    if-ne v0, v1, :cond_2

    const-string v1, "on"

    move-object v5, v1

    goto/16 :goto_0

    :cond_2
    const-string v1, "normal"

    move-object v5, v1

    goto/16 :goto_0

    .line 636
    :cond_3
    const-string v1, "key_normal_"

    move-object v2, v1

    goto/16 :goto_1

    .line 637
    :cond_4
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "key_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto/16 :goto_2

    :cond_5
    move v1, v3

    .line 642
    goto/16 :goto_3

    .line 644
    :cond_6
    const-string v1, "key_"

    goto/16 :goto_4

    .line 650
    :cond_7
    const/4 v1, 0x0

    goto/16 :goto_6

    .line 654
    :cond_8
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v5, v5, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    int-to-float v5, v5

    const/high16 v6, 0x42c80000    # 100.0f

    div-float/2addr v5, v6

    invoke-static {v3, v5}, Lcom/mrkeyboard/app/MrGlow;->scale(IF)I

    move-result v3

    goto/16 :goto_7

    .line 655
    :cond_9
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v5, v5, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    int-to-float v5, v5

    const/high16 v6, 0x42c80000    # 100.0f

    div-float/2addr v5, v6

    invoke-static {v2, v5}, Lcom/mrkeyboard/app/MrGlow;->scale(IF)I

    move-result v2

    goto/16 :goto_8

    .line 675
    :cond_a
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 676
    int-to-float v1, p2

    sub-float v4, v1, v2

    int-to-float v1, p3

    sub-float v5, v1, v2

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v1, p1

    move v3, v2

    move v7, v6

    invoke-virtual/range {v1 .. v8}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 677
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v10}, Landroid/graphics/Paint;->setColor(I)V

    .line 678
    int-to-float v1, p2

    sub-float v4, v1, v2

    int-to-float v1, p3

    sub-float/2addr v1, v2

    const/high16 v3, 0x40000000    # 2.0f

    iget v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v3, v5

    sub-float v5, v1, v3

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v1, p1

    move v3, v2

    move v7, v6

    invoke-virtual/range {v1 .. v8}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    goto/16 :goto_a

    :cond_b
    move v9, v2

    move v10, v4

    goto/16 :goto_9

    :cond_c
    move v11, v4

    move v4, v3

    move v3, v11

    goto/16 :goto_5
.end method

.method static fullAspect(FFFI)F
    .locals 1

    .prologue
    .line 118
    invoke-static {p1, p2, p3}, Lcom/mrkeyboard/app/MrThemePreview;->fullHeight(FFI)F

    move-result v0

    div-float v0, p0, v0

    return v0
.end method

.method static fullAspect(Landroid/content/Context;)F
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/high16 v1, 0x3f800000    # 1.0f

    .line 128
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    .line 129
    iget v0, v2, Landroid/util/DisplayMetrics;->density:F

    cmpl-float v0, v0, v5

    if-lez v0, :cond_0

    iget v0, v2, Landroid/util/DisplayMetrics;->density:F

    .line 130
    :goto_0
    iget v3, v2, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v4, v2, Landroid/util/DisplayMetrics;->heightPixels:I

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v3

    int-to-float v3, v3

    iget v4, v2, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v2, v2, Landroid/util/DisplayMetrics;->heightPixels:I

    invoke-static {v4, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    int-to-float v2, v2

    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemePreview;->heightPercent(Landroid/content/Context;)I

    move-result v4

    invoke-static {v3, v2, v0, v4}, Lcom/mrkeyboard/app/MrThemePreview;->fullAspect(FFFI)F
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 131
    cmpl-float v2, v0, v5

    if-lez v2, :cond_1

    .line 133
    :goto_1
    return v0

    :cond_0
    move v0, v1

    .line 129
    goto :goto_0

    :cond_1
    move v0, v1

    .line 131
    goto :goto_1

    .line 132
    :catch_0
    move-exception v0

    move v0, v1

    .line 133
    goto :goto_1
.end method

.method static fullHeight(FFI)F
    .locals 3

    .prologue
    .line 113
    const/high16 v0, 0x42400000    # 48.0f

    mul-float/2addr v0, p1

    int-to-float v1, p2

    mul-float/2addr v1, p0

    const/high16 v2, 0x42c80000    # 100.0f

    div-float/2addr v1, v2

    add-float/2addr v0, v1

    return v0
.end method

.method private fullKeys(Landroid/graphics/Canvas;Landroid/content/Context;FF)V
    .locals 53

    .prologue
    .line 504
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->faces(Landroid/content/Context;)V

    .line 505
    const/high16 v3, 0x42400000    # 48.0f

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v6, v3, v4

    .line 506
    move-object/from16 v0, p0

    move/from16 v1, p3

    move/from16 v2, p4

    invoke-direct {v0, v1, v6, v2}, Lcom/mrkeyboard/app/MrThemePreview;->area(FFF)V

    .line 507
    const v3, 0x3c03126f    # 0.008f

    mul-float v23, p3, v3

    .line 508
    sub-float v3, p4, v6

    const/high16 v4, 0x40800000    # 4.0f

    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v4, v5

    sub-float/2addr v3, v4

    const/high16 v4, 0x40e00000    # 7.0f

    div-float v8, v3, v4

    .line 509
    const/high16 v3, 0x40000000    # 2.0f

    mul-float v3, v3, v23

    sub-float v25, p3, v3

    .line 510
    const/high16 v3, 0x41200000    # 10.0f

    div-float v52, v25, v3

    .line 511
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v4, "text"

    const/4 v5, -0x1

    move-object/from16 v0, p2

    invoke-static {v0, v3, v4, v5}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v27

    .line 512
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v4, "accent_text"

    move-object/from16 v0, p2

    move/from16 v1, v27

    invoke-static {v0, v3, v4, v1}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v20

    .line 513
    invoke-direct/range {p0 .. p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v3

    if-eqz v3, :cond_0

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v3, v3, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    if-eqz v3, :cond_0

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v0, v3, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    move/from16 v20, v0

    move/from16 v27, v20

    .line 514
    :cond_0
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v4, "glow"

    move-object/from16 v0, p2

    invoke-static {v0, v3, v4}, Lcom/mrkeyboard/app/MrThemeColors;->declared(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v12

    .line 515
    if-nez v12, :cond_1

    const/4 v13, 0x0

    .line 516
    :goto_0
    const v3, 0x3ed70a3d    # 0.42f

    mul-float v16, v8, v3

    const v3, 0x3e99999a    # 0.3f

    mul-float v32, v8, v3

    .line 517
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    sget-object v4, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {v3, v4}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 519
    const/4 v4, 0x0

    .line 520
    sget-object v5, Lcom/mrkeyboard/app/MrThemePreview;->TOP_WIDTHS:[F

    array-length v7, v5

    const/4 v3, 0x0

    move/from16 v26, v4

    :goto_1
    if-ge v3, v7, :cond_2

    aget v4, v5, v3

    add-float v4, v4, v26

    add-int/lit8 v3, v3, 0x1

    move/from16 v26, v4

    goto :goto_1

    .line 515
    :cond_1
    const/high16 v3, 0x40a00000    # 5.0f

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v13, v3, v4

    goto :goto_0

    .line 522
    :cond_2
    const/4 v3, 0x0

    move/from16 v24, v3

    move/from16 v5, v23

    :goto_2
    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->TOP_WIDTHS:[F

    array-length v3, v3

    move/from16 v0, v24

    if-ge v0, v3, :cond_6

    .line 523
    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->TOP_WIDTHS:[F

    aget v3, v3, v24

    mul-float v3, v3, v25

    div-float v7, v3, v26

    .line 524
    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->TOP_KEYS:[Z

    aget-boolean v9, v3, v24

    .line 525
    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->TOP_LABELS:[Ljava/lang/String;

    aget-object v10, v3, v24

    if-eqz v9, :cond_5

    move/from16 v11, v20

    :goto_3
    const/4 v14, 0x0

    const/4 v15, 0x0

    move-object/from16 v3, p0

    move-object/from16 v4, p1

    invoke-direct/range {v3 .. v16}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 526
    if-nez v24, :cond_4

    .line 527
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mToolbarKeyIcon:Landroid/graphics/drawable/Drawable;

    if-nez v3, :cond_3

    const-string v3, "sym_keyboard_mr_toolbar"

    move-object/from16 v0, p2

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrThemePreview;->icon(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mToolbarKeyIcon:Landroid/graphics/drawable/Drawable;

    .line 528
    :cond_3
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemePreview;->mToolbarKeyIcon:Landroid/graphics/drawable/Drawable;

    move-object/from16 v19, v0

    const/high16 v3, 0x40000000    # 2.0f

    div-float v3, v7, v3

    add-float v21, v5, v3

    const/high16 v3, 0x40000000    # 2.0f

    div-float v3, v8, v3

    add-float v22, v6, v3

    move-object/from16 v17, p0

    move-object/from16 v18, p1

    invoke-direct/range {v17 .. v22}, Lcom/mrkeyboard/app/MrThemePreview;->iconAt(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;IFF)V

    .line 530
    :cond_4
    add-float/2addr v5, v7

    .line 522
    add-int/lit8 v3, v24, 0x1

    move/from16 v24, v3

    goto :goto_2

    :cond_5
    move/from16 v11, v27

    .line 525
    goto :goto_3

    .line 532
    :cond_6
    add-float v24, v6, v8

    move-object/from16 v21, p0

    move-object/from16 v22, p1

    move/from16 v26, v8

    move/from16 v28, v20

    move/from16 v29, v12

    move/from16 v30, v13

    move/from16 v31, v16

    .line 534
    invoke-direct/range {v21 .. v32}, Lcom/mrkeyboard/app/MrThemePreview;->modRow(Landroid/graphics/Canvas;FFFFIIIFFF)V

    .line 536
    const-string v18, "1234567890"

    .line 537
    const/4 v3, 0x0

    move/from16 v17, v3

    :goto_4
    invoke-virtual/range {v18 .. v18}, Ljava/lang/String;->length()I

    move-result v3

    move/from16 v0, v17

    if-ge v0, v3, :cond_7

    .line 538
    move/from16 v0, v17

    int-to-float v3, v0

    mul-float v3, v3, v52

    add-float v5, v23, v3

    add-float v6, v24, v8

    const/4 v9, 0x0

    move-object/from16 v0, v18

    move/from16 v1, v17

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v10

    const/4 v14, 0x0

    const/4 v15, 0x0

    move-object/from16 v3, p0

    move-object/from16 v4, p1

    move/from16 v7, v52

    move/from16 v11, v27

    invoke-direct/range {v3 .. v16}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 537
    add-int/lit8 v3, v17, 0x1

    move/from16 v17, v3

    goto :goto_4

    .line 540
    :cond_7
    const/4 v3, 0x0

    move/from16 v19, v3

    :goto_5
    const/4 v3, 0x3

    move/from16 v0, v19

    if-ge v0, v3, :cond_9

    .line 541
    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->ROWS:[Ljava/lang/String;

    aget-object v21, v3, v19

    .line 542
    add-int/lit8 v3, v19, 0x2

    int-to-float v3, v3

    mul-float/2addr v3, v8

    add-float v6, v24, v3

    .line 543
    invoke-virtual/range {v21 .. v21}, Ljava/lang/String;->length()I

    move-result v3

    int-to-float v3, v3

    mul-float v3, v3, v52

    .line 544
    const/high16 v4, 0x41200000    # 10.0f

    mul-float v4, v4, v52

    sub-float v3, v4, v3

    const/high16 v4, 0x40000000    # 2.0f

    div-float/2addr v3, v4

    add-float v3, v3, v23

    .line 545
    const/4 v4, 0x2

    move/from16 v0, v19

    if-ne v0, v4, :cond_a

    .line 547
    const v3, 0x3e19999a    # 0.15f

    mul-float v7, v25, v3

    .line 548
    const/4 v9, 0x1

    const-string v10, "\u21e7"

    const/4 v14, 0x0

    const/4 v15, 0x1

    move-object/from16 v3, p0

    move-object/from16 v4, p1

    move/from16 v5, v23

    move/from16 v11, v20

    invoke-direct/range {v3 .. v16}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 549
    add-float v3, v23, v25

    sub-float v5, v3, v7

    const/4 v9, 0x1

    const-string v10, "\u232b"

    const/4 v14, 0x0

    const/4 v15, 0x0

    move-object/from16 v3, p0

    move-object/from16 v4, p1

    move/from16 v11, v20

    invoke-direct/range {v3 .. v16}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 550
    add-float v3, v23, v7

    move/from16 v17, v3

    .line 552
    :goto_6
    const/4 v3, 0x0

    move/from16 v18, v3

    :goto_7
    invoke-virtual/range {v21 .. v21}, Ljava/lang/String;->length()I

    move-result v3

    move/from16 v0, v18

    if-ge v0, v3, :cond_8

    .line 553
    move/from16 v0, v18

    int-to-float v3, v0

    mul-float v3, v3, v52

    add-float v5, v17, v3

    const/4 v9, 0x0

    move-object/from16 v0, v21

    move/from16 v1, v18

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v10

    const/4 v14, 0x0

    const/4 v15, 0x0

    move-object/from16 v3, p0

    move-object/from16 v4, p1

    move/from16 v7, v52

    move/from16 v11, v27

    invoke-direct/range {v3 .. v16}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 552
    add-int/lit8 v3, v18, 0x1

    move/from16 v18, v3

    goto :goto_7

    .line 540
    :cond_8
    add-int/lit8 v3, v19, 0x1

    move/from16 v19, v3

    goto/16 :goto_5

    .line 557
    :cond_9
    const/high16 v3, 0x40a00000    # 5.0f

    mul-float/2addr v3, v8

    add-float v36, v24, v3

    .line 558
    const v3, 0x3e4ccccd    # 0.2f

    mul-float v37, v25, v3

    const v3, 0x3ecccccd    # 0.4f

    mul-float v7, v25, v3

    .line 560
    const/16 v39, 0x1

    const-string v40, "123"

    const/16 v44, 0x0

    const/16 v45, 0x0

    move-object/from16 v33, p0

    move-object/from16 v34, p1

    move/from16 v35, v23

    move/from16 v38, v8

    move/from16 v41, v20

    move/from16 v42, v12

    move/from16 v43, v13

    move/from16 v46, v32

    invoke-direct/range {v33 .. v46}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 561
    add-float v40, v23, v37

    .line 562
    const/16 v44, 0x1

    const-string v45, "F1"

    const/16 v49, 0x0

    const/16 v50, 0x0

    move-object/from16 v38, p0

    move-object/from16 v39, p1

    move/from16 v41, v36

    move/from16 v42, v52

    move/from16 v43, v8

    move/from16 v46, v20

    move/from16 v47, v12

    move/from16 v48, v13

    move/from16 v51, v32

    invoke-direct/range {v38 .. v51}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 563
    add-float v5, v40, v52

    .line 564
    const/4 v9, 0x0

    const-string v10, ""

    const/4 v14, 0x0

    const/4 v15, 0x0

    move-object/from16 v3, p0

    move-object/from16 v4, p1

    move/from16 v6, v36

    move/from16 v11, v27

    invoke-direct/range {v3 .. v16}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 565
    add-float/2addr v5, v7

    .line 566
    const/4 v9, 0x0

    const-string v10, "."

    const/4 v14, 0x0

    const/4 v15, 0x0

    move-object/from16 v3, p0

    move-object/from16 v4, p1

    move/from16 v6, v36

    move/from16 v7, v52

    move/from16 v11, v27

    invoke-direct/range {v3 .. v16}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 567
    add-float v5, v5, v52

    .line 568
    const/4 v9, 0x1

    const-string v10, "\u23ce"

    const/4 v14, 0x0

    const/4 v15, 0x0

    move-object/from16 v3, p0

    move-object/from16 v4, p1

    move/from16 v6, v36

    move/from16 v7, v37

    move/from16 v11, v20

    invoke-direct/range {v3 .. v16}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 569
    return-void

    :cond_a
    move/from16 v17, v3

    goto/16 :goto_6
.end method

.method static heightPercent(Landroid/content/Context;)I
    .locals 7

    .prologue
    const/4 v0, 0x0

    const/4 v2, 0x0

    const/high16 v1, 0x42080000    # 34.0f

    .line 139
    .line 141
    :try_start_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    .line 144
    :try_start_1
    const-string v4, "settings_height_portrait"

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/ClassCastException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v0

    move-object v3, v0

    move v0, v1

    .line 148
    :goto_0
    if-eqz v3, :cond_2

    .line 151
    :goto_1
    :try_start_2
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v2, v4, :cond_1

    invoke-virtual {v3, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Ljava/lang/Character;->isDigit(C)Z

    move-result v4

    if-nez v4, :cond_0

    invoke-virtual {v3, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v5, 0x2e

    if-ne v4, v5, :cond_1

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 145
    :catch_0
    move-exception v4

    .line 146
    const-string v4, "settings_height_portrait"

    const/16 v5, 0x22

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v3

    int-to-float v3, v3

    move-object v6, v0

    move v0, v3

    move-object v3, v6

    goto :goto_0

    .line 152
    :cond_1
    if-lez v2, :cond_2

    const/4 v0, 0x0

    invoke-virtual {v3, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_1

    move-result v0

    .line 157
    :cond_2
    :goto_2
    const/16 v1, 0xf

    const/16 v2, 0x4b

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-static {v2, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    return v0

    .line 154
    :catch_1
    move-exception v0

    move v0, v1

    .line 155
    goto :goto_2
.end method

.method private static icon(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 367
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "drawable"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, p1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 368
    if-nez v1, :cond_0

    .line 370
    :goto_0
    return-object v0

    .line 368
    :cond_0
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->face(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 369
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private iconAt(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;IFF)V
    .locals 8

    .prologue
    const/4 v5, 0x0

    const/high16 v6, 0x40400000    # 3.0f

    const/high16 v4, 0x40000000    # 2.0f

    .line 376
    const/high16 v0, 0x41c00000    # 24.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v0, v1

    .line 377
    if-nez p2, :cond_0

    .line 378
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v5}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 379
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 380
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/high16 v2, 0x3f800000    # 1.0f

    iget v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    invoke-static {v2, v3}, Ljava/lang/Math;->max(FF)F

    move-result v2

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 381
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const v2, 0x3f333333    # 0.7f

    invoke-static {p3, v2}, Lcom/mrkeyboard/app/MrThemePreview;->withAlpha(IF)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 382
    const v1, 0x3e99999a    # 0.3f

    mul-float/2addr v0, v1

    .line 383
    sub-float v1, p4, v0

    sub-float v2, p5, v0

    add-float v3, p4, v0

    add-float v4, p5, v0

    div-float v5, v0, v6

    div-float v6, v0, v6

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 384
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 391
    :goto_0
    return-void

    .line 387
    :cond_0
    div-float v1, v0, v4

    sub-float v1, p4, v1

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    div-float v2, v0, v4

    sub-float v2, p5, v2

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    div-float v3, v0, v4

    add-float/2addr v3, p4

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    div-float/2addr v0, v4

    add-float/2addr v0, p5

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-virtual {p2, v1, v2, v3, v0}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 388
    new-instance v0, Landroid/graphics/PorterDuffColorFilter;

    sget-object v1, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v0, p3, v1}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V

    invoke-virtual {p2, v0}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 389
    invoke-virtual {p2, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    .line 390
    invoke-virtual {p2, v5}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    goto :goto_0
.end method

.method private ink(Landroid/content/Context;)I
    .locals 1

    .prologue
    .line 358
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v0, v0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v0, v0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrThemeColors;->ink(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method private key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V
    .locals 14

    .prologue
    .line 573
    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    move-object v0, p0

    move-object v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move/from16 v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move-object/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p9

    move/from16 v10, p10

    invoke-direct/range {v0 .. v13}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 574
    return-void
.end method

.method private key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V
    .locals 12

    .prologue
    .line 581
    const/4 v2, 0x1

    invoke-static/range {p4 .. p4}, Ljava/lang/Math;->round(F)I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v4

    const/4 v2, 0x1

    invoke-static/range {p5 .. p5}, Ljava/lang/Math;->round(F)I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v5

    .line 582
    if-eqz p6, :cond_6

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAccent:Landroid/graphics/drawable/Drawable;

    .line 584
    :goto_0
    move/from16 v0, p4

    move/from16 v1, p5

    invoke-direct {p0, p2, p3, v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->spectrum(FFFF)V

    .line 585
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    .line 586
    if-eqz v3, :cond_2

    .line 587
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v6

    if-eqz v6, :cond_0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v6, v6, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    if-nez v6, :cond_1

    :cond_0
    move/from16 v0, p8

    invoke-static {v3, v0}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result p8

    .line 588
    :cond_1
    const/4 v3, 0x0

    cmpl-float v3, p10, v3

    if-lez v3, :cond_2

    const/high16 v3, -0x1000000

    and-int v3, v3, p9

    iget v6, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrentHue:I

    const v7, 0xffffff

    and-int/2addr v6, v7

    or-int p9, v3, v6

    .line 590
    :cond_2
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 591
    invoke-virtual {p1, p2, p3}, Landroid/graphics/Canvas;->translate(FF)V

    .line 592
    if-eqz v2, :cond_e

    .line 593
    const/4 v3, 0x0

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v6, v4, v5}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 595
    const/4 v3, 0x2

    move/from16 v0, p11

    if-ne v0, v3, :cond_7

    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->STATE_LOCK:[I

    :goto_1
    invoke-virtual {v2, v3}, Landroid/graphics/drawable/Drawable;->setState([I)Z

    .line 596
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v2, v4, v5, v3}, Lcom/mrkeyboard/app/KeyStyle;->prepare(Landroid/graphics/drawable/Drawable;IILandroid/content/Context;)V

    .line 597
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v3

    if-eqz v3, :cond_a

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrKeyLook;->faceTuned()Z

    move-result v3

    if-eqz v3, :cond_a

    const/4 v3, 0x1

    .line 599
    :goto_2
    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrentFilter:Landroid/graphics/ColorFilter;

    if-eqz v3, :cond_b

    const/4 v7, 0x1

    invoke-direct {p0, v7}, Lcom/mrkeyboard/app/MrThemePreview;->opacityFilter(Z)Landroid/graphics/ColorFilter;

    move-result-object v7

    :goto_3
    if-eqz v3, :cond_c

    const/4 v3, 0x0

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/MrThemePreview;->opacityFilter(Z)Landroid/graphics/ColorFilter;

    move-result-object v8

    .line 600
    :goto_4
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v3

    if-eqz v3, :cond_d

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v9, v3, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    :goto_5
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrKeyLook;->lineAlpha()F

    move-result v10

    iget v11, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    move-object v3, p1

    .line 599
    invoke-static/range {v2 .. v11}, Lcom/mrkeyboard/app/MrGlow;->drawFace(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;IILandroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;IFF)V

    .line 604
    :goto_6
    if-eqz p12, :cond_3

    move/from16 v0, p12

    invoke-direct {p0, p1, v4, v5, v0}, Lcom/mrkeyboard/app/MrThemePreview;->dash(Landroid/graphics/Canvas;III)V

    .line 605
    :cond_3
    invoke-virtual/range {p7 .. p7}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_5

    .line 606
    const/4 v2, 0x0

    cmpl-float v2, p13, v2

    if-lez v2, :cond_4

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    move/from16 v0, p13

    invoke-virtual {v2, v0}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 607
    :cond_4
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    move/from16 v0, p8

    invoke-virtual {v2, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 608
    const/4 v2, 0x0

    cmpl-float v2, p10, v2

    if-lez v2, :cond_f

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    const/4 v3, 0x0

    const/4 v6, 0x0

    move/from16 v0, p10

    move/from16 v1, p9

    invoke-virtual {v2, v0, v3, v6, v1}, Landroid/graphics/Paint;->setShadowLayer(FFFI)V

    .line 610
    :goto_7
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMetrics:Landroid/graphics/Paint$FontMetrics;

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->getFontMetrics(Landroid/graphics/Paint$FontMetrics;)F

    .line 611
    int-to-float v2, v4

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v2, v3

    int-to-float v3, v5

    const/high16 v4, 0x40000000    # 2.0f

    div-float/2addr v3, v4

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMetrics:Landroid/graphics/Paint$FontMetrics;

    iget v4, v4, Landroid/graphics/Paint$FontMetrics;->ascent:F

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMetrics:Landroid/graphics/Paint$FontMetrics;

    iget v5, v5, Landroid/graphics/Paint$FontMetrics;->descent:F

    add-float/2addr v4, v5

    const/high16 v5, 0x40000000    # 2.0f

    div-float/2addr v4, v5

    sub-float/2addr v3, v4

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    move-object/from16 v0, p7

    invoke-virtual {p1, v0, v2, v3, v4}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 612
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    invoke-virtual {v2}, Landroid/graphics/Paint;->clearShadowLayer()V

    .line 614
    :cond_5
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 615
    return-void

    .line 582
    :cond_6
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFace:Landroid/graphics/drawable/Drawable;

    goto/16 :goto_0

    .line 595
    :cond_7
    const/4 v3, 0x1

    move/from16 v0, p11

    if-ne v0, v3, :cond_8

    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->STATE_ON:[I

    goto/16 :goto_1

    :cond_8
    if-eqz p12, :cond_9

    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->STATE_MOD:[I

    goto/16 :goto_1

    :cond_9
    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->STATE_NORMAL:[I

    goto/16 :goto_1

    .line 597
    :cond_a
    const/4 v3, 0x0

    goto/16 :goto_2

    .line 599
    :cond_b
    const/4 v7, 0x0

    goto/16 :goto_3

    :cond_c
    const/4 v8, 0x0

    goto/16 :goto_4

    .line 600
    :cond_d
    const/4 v9, 0x0

    goto/16 :goto_5

    :cond_e
    move-object v2, p0

    move-object v3, p1

    move/from16 v6, p6

    move/from16 v7, p11

    .line 602
    invoke-direct/range {v2 .. v7}, Lcom/mrkeyboard/app/MrThemePreview;->flat(Landroid/graphics/Canvas;IIZI)V

    goto/16 :goto_6

    .line 609
    :cond_f
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    invoke-virtual {v2}, Landroid/graphics/Paint;->clearShadowLayer()V

    goto :goto_7
.end method

.method private keys(Landroid/graphics/Canvas;Landroid/content/Context;FF)V
    .locals 26

    .prologue
    .line 414
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->faces(Landroid/content/Context;)V

    .line 415
    const v3, 0x3e2e147b    # 0.17f

    mul-float v6, p4, v3

    .line 416
    move-object/from16 v0, p0

    move/from16 v1, p3

    move/from16 v2, p4

    invoke-direct {v0, v1, v6, v2}, Lcom/mrkeyboard/app/MrThemePreview;->area(FFF)V

    .line 417
    const v3, 0x3c03126f    # 0.008f

    mul-float v5, p3, v3

    .line 418
    sub-float v3, p4, v6

    const/high16 v4, 0x40a00000    # 5.0f

    div-float v8, v3, v4

    .line 419
    const/high16 v3, 0x40000000    # 2.0f

    mul-float/2addr v3, v5

    sub-float v3, p3, v3

    const/high16 v4, 0x41200000    # 10.0f

    div-float v24, v3, v4

    .line 420
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v4, "text"

    const/4 v7, -0x1

    move-object/from16 v0, p2

    invoke-static {v0, v3, v4, v7}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v9

    .line 421
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v4, "accent_text"

    move-object/from16 v0, p2

    invoke-static {v0, v3, v4, v9}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v10

    .line 422
    invoke-direct/range {p0 .. p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v3

    if-eqz v3, :cond_0

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v3, v3, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    if-eqz v3, :cond_0

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v10, v3, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    move v9, v10

    .line 424
    :cond_0
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v4, "glow"

    move-object/from16 v0, p2

    invoke-static {v0, v3, v4}, Lcom/mrkeyboard/app/MrThemeColors;->declared(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v11

    .line 425
    if-nez v11, :cond_2

    const/4 v12, 0x0

    .line 426
    :goto_0
    const v3, 0x3ed70a3d    # 0.42f

    mul-float v13, v8, v3

    const v3, 0x3e99999a    # 0.3f

    mul-float v14, v8, v3

    .line 427
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    sget-object v4, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {v3, v4}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 428
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    invoke-virtual {v3, v13}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 430
    const/high16 v3, 0x40000000    # 2.0f

    mul-float/2addr v3, v5

    sub-float v7, p3, v3

    move-object/from16 v3, p0

    move-object/from16 v4, p1

    invoke-direct/range {v3 .. v14}, Lcom/mrkeyboard/app/MrThemePreview;->modRow(Landroid/graphics/Canvas;FFFFIIIFFF)V

    .line 431
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    invoke-virtual {v3, v13}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 432
    const/4 v3, 0x0

    move v4, v3

    :goto_1
    const/4 v3, 0x4

    if-ge v4, v3, :cond_5

    .line 433
    add-int/lit8 v3, v4, 0x1

    int-to-float v3, v3

    mul-float/2addr v3, v8

    add-float v16, v6, v3

    .line 434
    const/4 v3, 0x3

    if-ge v4, v3, :cond_3

    .line 435
    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->ROWS:[Ljava/lang/String;

    aget-object v7, v3, v4

    .line 436
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v3

    int-to-float v3, v3

    mul-float v3, v3, v24

    .line 437
    const/high16 v13, 0x41200000    # 10.0f

    mul-float v13, v13, v24

    sub-float/2addr v13, v3

    const/high16 v14, 0x40000000    # 2.0f

    div-float/2addr v13, v14

    add-float v25, v5, v13

    .line 438
    const/4 v13, 0x2

    if-ne v4, v13, :cond_1

    .line 440
    const/high16 v13, 0x41200000    # 10.0f

    mul-float v13, v13, v24

    sub-float v3, v13, v3

    const/high16 v13, 0x40000000    # 2.0f

    div-float/2addr v3, v13

    const v13, 0x3dcccccd    # 0.1f

    mul-float v13, v13, v24

    sub-float v17, v3, v13

    .line 441
    const/16 v19, 0x0

    const-string v20, "\u21e7"

    move-object/from16 v13, p0

    move-object/from16 v14, p1

    move v15, v5

    move/from16 v18, v8

    move/from16 v21, v9

    move/from16 v22, v11

    move/from16 v23, v12

    invoke-direct/range {v13 .. v23}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 442
    const/high16 v3, 0x41200000    # 10.0f

    mul-float v3, v3, v24

    add-float/2addr v3, v5

    sub-float v15, v3, v17

    const/16 v19, 0x0

    const-string v20, "\u232b"

    move-object/from16 v13, p0

    move-object/from16 v14, p1

    move/from16 v18, v8

    move/from16 v21, v9

    move/from16 v22, v11

    move/from16 v23, v12

    invoke-direct/range {v13 .. v23}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 444
    :cond_1
    const/4 v3, 0x0

    :goto_2
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v13

    if-ge v3, v13, :cond_4

    .line 445
    int-to-float v13, v3

    mul-float v13, v13, v24

    add-float v15, v25, v13

    const/16 v19, 0x0

    invoke-virtual {v7, v3}, Ljava/lang/String;->charAt(I)C

    move-result v13

    invoke-static {v13}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v20

    move-object/from16 v13, p0

    move-object/from16 v14, p1

    move/from16 v17, v24

    move/from16 v18, v8

    move/from16 v21, v9

    move/from16 v22, v11

    move/from16 v23, v12

    invoke-direct/range {v13 .. v23}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 444
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 425
    :cond_2
    const/high16 v3, 0x40a00000    # 5.0f

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v12, v3, v4

    goto/16 :goto_0

    .line 448
    :cond_3
    const v3, 0x3fa66666    # 1.3f

    mul-float v17, v24, v3

    const/high16 v3, 0x3f800000    # 1.0f

    mul-float v3, v3, v24

    const v7, 0x3fd9999a    # 1.7f

    mul-float v7, v7, v24

    .line 449
    const/high16 v13, 0x41200000    # 10.0f

    mul-float v13, v13, v24

    sub-float v13, v13, v17

    const/high16 v14, 0x40000000    # 2.0f

    mul-float/2addr v14, v3

    sub-float/2addr v13, v14

    sub-float v25, v13, v7

    .line 451
    const/16 v19, 0x0

    const-string v20, "?123"

    move-object/from16 v13, p0

    move-object/from16 v14, p1

    move v15, v5

    move/from16 v18, v8

    move/from16 v21, v9

    move/from16 v22, v11

    move/from16 v23, v12

    invoke-direct/range {v13 .. v23}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 452
    add-float v15, v5, v17

    .line 453
    const/16 v19, 0x0

    const-string v20, ","

    move-object/from16 v13, p0

    move-object/from16 v14, p1

    move/from16 v17, v3

    move/from16 v18, v8

    move/from16 v21, v9

    move/from16 v22, v11

    move/from16 v23, v12

    invoke-direct/range {v13 .. v23}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 454
    add-float/2addr v15, v3

    .line 455
    const/16 v19, 0x0

    const-string v20, ""

    move-object/from16 v13, p0

    move-object/from16 v14, p1

    move/from16 v17, v25

    move/from16 v18, v8

    move/from16 v21, v9

    move/from16 v22, v11

    move/from16 v23, v12

    invoke-direct/range {v13 .. v23}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 456
    add-float v15, v15, v25

    .line 457
    const/16 v19, 0x0

    const-string v20, "."

    move-object/from16 v13, p0

    move-object/from16 v14, p1

    move/from16 v17, v3

    move/from16 v18, v8

    move/from16 v21, v9

    move/from16 v22, v11

    move/from16 v23, v12

    invoke-direct/range {v13 .. v23}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 458
    add-float/2addr v15, v3

    .line 459
    const/16 v19, 0x1

    const-string v20, "\u23ce"

    move-object/from16 v13, p0

    move-object/from16 v14, p1

    move/from16 v17, v7

    move/from16 v18, v8

    move/from16 v21, v10

    move/from16 v22, v11

    move/from16 v23, v12

    invoke-direct/range {v13 .. v23}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 432
    :cond_4
    add-int/lit8 v3, v4, 0x1

    move v4, v3

    goto/16 :goto_1

    .line 462
    :cond_5
    return-void
.end method

.method private modRow(Landroid/graphics/Canvas;FFFFIIIFFF)V
    .locals 16

    .prologue
    .line 485
    const/4 v1, 0x0

    .line 486
    sget-object v2, Lcom/mrkeyboard/app/MrThemePreview;->MOD_WIDTHS:[F

    array-length v3, v2

    const/4 v0, 0x0

    move v15, v1

    :goto_0
    if-ge v0, v3, :cond_0

    aget v1, v2, v0

    add-float/2addr v1, v15

    add-int/lit8 v0, v0, 0x1

    move v15, v1

    goto :goto_0

    .line 487
    :cond_0
    const/4 v0, 0x0

    move v14, v0

    move/from16 v2, p2

    :goto_1
    sget-object v0, Lcom/mrkeyboard/app/MrThemePreview;->MOD_WIDTHS:[F

    array-length v0, v0

    if-ge v14, v0, :cond_4

    .line 488
    sget-object v0, Lcom/mrkeyboard/app/MrThemePreview;->MOD_WIDTHS:[F

    aget v0, v0, v14

    mul-float v0, v0, p4

    div-float v4, v0, v15

    .line 489
    sget-object v0, Lcom/mrkeyboard/app/MrThemePreview;->MOD_KEYS:[Z

    aget-boolean v6, v0, v14

    .line 490
    sget-object v0, Lcom/mrkeyboard/app/MrThemePreview;->MOD_LABELS:[Ljava/lang/String;

    aget-object v7, v0, v14

    .line 491
    if-eqz v6, :cond_1

    move/from16 v8, p7

    :goto_2
    const/4 v11, 0x0

    .line 492
    const/4 v0, 0x2

    if-ge v14, v0, :cond_2

    const/4 v12, 0x1

    :goto_3
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x1

    if-le v0, v1, :cond_3

    if-eqz v6, :cond_3

    const/4 v0, 0x2

    if-ge v14, v0, :cond_3

    move/from16 v13, p11

    :goto_4
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v3, p3

    move/from16 v5, p5

    move/from16 v9, p8

    move/from16 v10, p9

    .line 491
    invoke-direct/range {v0 .. v13}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 493
    add-float/2addr v2, v4

    .line 487
    add-int/lit8 v0, v14, 0x1

    move v14, v0

    goto :goto_1

    :cond_1
    move/from16 v8, p6

    .line 491
    goto :goto_2

    .line 492
    :cond_2
    const/4 v12, 0x0

    goto :goto_3

    :cond_3
    move/from16 v13, p10

    goto :goto_4

    .line 495
    :cond_4
    return-void
.end method

.method private opacityFilter(Z)Landroid/graphics/ColorFilter;
    .locals 2

    .prologue
    .line 708
    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v0, v0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    :goto_0
    int-to-float v0, v0

    const/high16 v1, 0x42c80000    # 100.0f

    div-float/2addr v0, v1

    .line 709
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrGlow;->filter([FF)Landroid/graphics/ColorFilter;

    move-result-object v0

    return-object v0

    .line 708
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v0, v0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    goto :goto_0
.end method

.method private plus(Landroid/graphics/Canvas;II)V
    .locals 9

    .prologue
    const/4 v1, 0x0

    const/high16 v8, 0x40000000    # 2.0f

    .line 279
    const/high16 v0, 0x41400000    # 12.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v5, v0, v2

    .line 280
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 281
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 282
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusFill:I

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 283
    int-to-float v3, p2

    int-to-float v4, p3

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v2, v1

    move v6, v5

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 284
    const/high16 v0, 0x3f800000    # 1.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 285
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 286
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 287
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusLine:I

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 288
    div-float v1, v0, v8

    div-float v2, v0, v8

    int-to-float v3, p2

    div-float v4, v0, v8

    sub-float/2addr v3, v4

    int-to-float v4, p3

    div-float/2addr v0, v8

    sub-float/2addr v4, v0

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v6, v5

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 289
    invoke-static {p2, p3}, Ljava/lang/Math;->min(II)I

    move-result v0

    int-to-float v0, v0

    const v1, 0x3e2e147b    # 0.17f

    mul-float v6, v0, v1

    .line 290
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/high16 v1, 0x40200000    # 2.5f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 291
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusInk:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 292
    int-to-float v0, p2

    div-float/2addr v0, v8

    sub-float v1, v0, v6

    int-to-float v0, p3

    div-float v2, v0, v8

    int-to-float v0, p2

    div-float/2addr v0, v8

    add-float v3, v0, v6

    int-to-float v0, p3

    div-float v4, v0, v8

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 293
    int-to-float v0, p2

    div-float v1, v0, v8

    int-to-float v0, p3

    div-float/2addr v0, v8

    sub-float v2, v0, v6

    int-to-float v0, p2

    div-float v3, v0, v8

    int-to-float v0, p3

    div-float/2addr v0, v8

    add-float v4, v0, v6

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 294
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 295
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mChecked:Z

    if-eqz v0, :cond_0

    invoke-direct {p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrThemePreview;->badge(Landroid/graphics/Canvas;II)V

    .line 296
    :cond_0
    return-void
.end method

.method static roundRect(FFF)Landroid/graphics/Path;
    .locals 12

    .prologue
    .line 774
    invoke-static {p0, p1}, Ljava/lang/Math;->min(FF)F

    move-result v0

    const/high16 v1, 0x40000000    # 2.0f

    div-float/2addr v0, v1

    invoke-static {p2, v0}, Ljava/lang/Math;->min(FF)F

    move-result v2

    .line 775
    new-instance v0, Landroid/graphics/Path;

    invoke-direct {v0}, Landroid/graphics/Path;-><init>()V

    .line 776
    const/16 v5, 0x8

    .line 777
    const/4 v1, 0x0

    invoke-virtual {v0, v2, v1}, Landroid/graphics/Path;->moveTo(FF)V

    .line 778
    sub-float v1, p0, v2

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 779
    sub-float v1, p0, v2

    const/high16 v4, -0x3d4c0000    # -90.0f

    move v3, v2

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemePreview;->corner(Landroid/graphics/Path;FFFFI)V

    .line 780
    sub-float v1, p1, v2

    invoke-virtual {v0, p0, v1}, Landroid/graphics/Path;->lineTo(FF)V

    .line 781
    sub-float v7, p0, v2

    sub-float v8, p1, v2

    const/4 v10, 0x0

    move-object v6, v0

    move v9, v2

    move v11, v5

    invoke-static/range {v6 .. v11}, Lcom/mrkeyboard/app/MrThemePreview;->corner(Landroid/graphics/Path;FFFFI)V

    .line 782
    invoke-virtual {v0, v2, p1}, Landroid/graphics/Path;->lineTo(FF)V

    .line 783
    sub-float v8, p1, v2

    const/high16 v10, 0x42b40000    # 90.0f

    move-object v6, v0

    move v7, v2

    move v9, v2

    move v11, v5

    invoke-static/range {v6 .. v11}, Lcom/mrkeyboard/app/MrThemePreview;->corner(Landroid/graphics/Path;FFFFI)V

    .line 784
    const/4 v1, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/graphics/Path;->lineTo(FF)V

    .line 785
    const/high16 v4, 0x43340000    # 180.0f

    move v1, v2

    move v3, v2

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemePreview;->corner(Landroid/graphics/Path;FFFFI)V

    .line 786
    invoke-virtual {v0}, Landroid/graphics/Path;->close()V

    .line 787
    return-object v0
.end method

.method private spectrum(FFFF)V
    .locals 7

    .prologue
    const/4 v0, 0x0

    const/high16 v1, 0x40000000    # 2.0f

    .line 721
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    .line 722
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrentFilter:Landroid/graphics/ColorFilter;

    .line 723
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFrom:I

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMatrix:[[F

    if-nez v0, :cond_1

    .line 736
    :cond_0
    :goto_0
    return-void

    .line 724
    :cond_1
    div-float v0, p3, v1

    add-float/2addr v0, p1

    div-float v1, p4, v1

    add-float/2addr v1, p2

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAreaTop:F

    sub-float/2addr v1, v2

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAreaW:F

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    iget v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAreaH:F

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrGlow;->step(FFII)I

    move-result v1

    .line 725
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMatrix:[[F

    aget-object v0, v0, v1

    .line 726
    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mStart:I

    iget v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMid:I

    iget v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mEnd:I

    int-to-float v5, v1

    const/high16 v6, 0x42400000    # 48.0f

    div-float/2addr v5, v6

    invoke-static {v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrGlow;->ramp(IIIF)I

    move-result v2

    .line 727
    if-nez v0, :cond_2

    .line 728
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFrom:I

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrGlow;->remap(II)[F

    move-result-object v0

    .line 729
    if-eqz v0, :cond_0

    .line 730
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMatrix:[[F

    aput-object v0, v3, v1

    .line 731
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFilter:[Landroid/graphics/ColorFilter;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->filter([F)Landroid/graphics/ColorFilter;

    move-result-object v4

    aput-object v4, v3, v1

    .line 733
    :cond_2
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    .line 734
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFilter:[Landroid/graphics/ColorFilter;

    aget-object v0, v0, v1

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrentFilter:Landroid/graphics/ColorFilter;

    .line 735
    iput v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrentHue:I

    goto :goto_0
.end method

.method private toolbar(Landroid/graphics/Canvas;Landroid/content/Context;F)V
    .locals 11

    .prologue
    const/4 v1, 0x0

    const/high16 v10, 0x40000000    # 2.0f

    .line 398
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mToolIcons:[Landroid/graphics/drawable/Drawable;

    if-nez v0, :cond_0

    .line 399
    sget-object v0, Lcom/mrkeyboard/app/MrThemePreview;->TOOL_ICONS:[Ljava/lang/String;

    array-length v0, v0

    new-array v0, v0, [Landroid/graphics/drawable/Drawable;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mToolIcons:[Landroid/graphics/drawable/Drawable;

    move v0, v1

    .line 400
    :goto_0
    sget-object v2, Lcom/mrkeyboard/app/MrThemePreview;->TOOL_ICONS:[Ljava/lang/String;

    array-length v2, v2

    if-ge v0, v2, :cond_0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mToolIcons:[Landroid/graphics/drawable/Drawable;

    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->TOOL_ICONS:[Ljava/lang/String;

    aget-object v3, v3, v0

    invoke-static {p2, v3}, Lcom/mrkeyboard/app/MrThemePreview;->icon(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    aput-object v3, v2, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 402
    :cond_0
    invoke-direct {p0, p2}, Lcom/mrkeyboard/app/MrThemePreview;->ink(Landroid/content/Context;)I

    move-result v3

    .line 403
    const/high16 v0, 0x40800000    # 4.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v7, v0, v2

    const/high16 v0, 0x42400000    # 48.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v8, v0, v2

    .line 404
    mul-float v0, v10, v7

    sub-float v0, p3, v0

    sget-object v2, Lcom/mrkeyboard/app/MrThemePreview;->TOOL_ICONS:[Ljava/lang/String;

    array-length v2, v2

    int-to-float v2, v2

    div-float v9, v0, v2

    move v6, v1

    .line 405
    :goto_1
    sget-object v0, Lcom/mrkeyboard/app/MrThemePreview;->TOOL_ICONS:[Ljava/lang/String;

    array-length v0, v0

    if-ge v6, v0, :cond_1

    .line 406
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mToolIcons:[Landroid/graphics/drawable/Drawable;

    aget-object v2, v0, v6

    int-to-float v0, v6

    const/high16 v1, 0x3f000000    # 0.5f

    add-float/2addr v0, v1

    mul-float/2addr v0, v9

    add-float v4, v7, v0

    div-float v5, v8, v10

    move-object v0, p0

    move-object v1, p1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemePreview;->iconAt(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;IFF)V

    .line 405
    add-int/lit8 v1, v6, 0x1

    move v6, v1

    goto :goto_1

    .line 408
    :cond_1
    return-void
.end method

.method private tuned()Z
    .locals 1

    .prologue
    .line 186
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrThemeColors;->hidden(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method static withAlpha(IF)I
    .locals 2

    .prologue
    .line 799
    const/4 v0, 0x0

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-static {v1, p1}, Ljava/lang/Math;->min(FF)F

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    const/high16 v1, 0x437f0000    # 255.0f

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    shl-int/lit8 v0, v0, 0x18

    const v1, 0xffffff

    and-int/2addr v1, p0

    or-int/2addr v0, v1

    return v0
.end method


# virtual methods
.method checked()Z
    .locals 1

    .prologue
    .line 229
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mChecked:Z

    return v0
.end method

.method drawn()I
    .locals 1

    .prologue
    .line 234
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDrawn:I

    return v0
.end method

.method full()Z
    .locals 1

    .prologue
    .line 207
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFull:Z

    return v0
.end method

.method look()Lcom/mrkeyboard/app/MrKeyLook;
    .locals 1

    .prologue
    .line 181
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    return-object v0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 11

    .prologue
    .line 245
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getWidth()I

    move-result v3

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getHeight()I

    move-result v4

    .line 246
    if-lez v3, :cond_0

    if-gtz v4, :cond_1

    .line 273
    :cond_0
    :goto_0
    return-void

    .line 247
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDrawn:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDrawn:I

    .line 248
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getContext()Landroid/content/Context;

    move-result-object v2

    .line 249
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlus:Z

    if-eqz v0, :cond_2

    .line 250
    invoke-direct {p0, p1, v3, v4}, Lcom/mrkeyboard/app/MrThemePreview;->plus(Landroid/graphics/Canvas;II)V

    goto :goto_0

    .line 253
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrThemeColors;->dark(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    .line 254
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 255
    int-to-float v0, v3

    int-to-float v1, v4

    const/high16 v6, 0x41400000    # 12.0f

    iget v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v6, v7

    invoke-static {v0, v1, v6}, Lcom/mrkeyboard/app/MrThemePreview;->roundRect(FFF)Landroid/graphics/Path;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->clipPath(Landroid/graphics/Path;)Z

    move-object v0, p0

    move-object v1, p1

    .line 256
    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemePreview;->background(Landroid/graphics/Canvas;Landroid/content/Context;IIZ)V

    .line 258
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mKeyWidthPx:I

    int-to-float v8, v0

    .line 259
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFull:Z

    if-eqz v0, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFullAspect:F

    :goto_1
    div-float v9, v8, v0

    .line 260
    int-to-float v0, v3

    div-float/2addr v0, v8

    .line 261
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 262
    invoke-virtual {p1, v0, v0}, Landroid/graphics/Canvas;->scale(FF)V

    .line 263
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFull:Z

    if-eqz v0, :cond_4

    .line 264
    invoke-direct {p0, p1, v2, v8}, Lcom/mrkeyboard/app/MrThemePreview;->toolbar(Landroid/graphics/Canvas;Landroid/content/Context;F)V

    .line 265
    invoke-direct {p0, p1, v2, v8, v9}, Lcom/mrkeyboard/app/MrThemePreview;->fullKeys(Landroid/graphics/Canvas;Landroid/content/Context;FF)V

    .line 270
    :goto_2
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 271
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 272
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mChecked:Z

    if-eqz v0, :cond_0

    invoke-direct {p0, p1, v3, v4}, Lcom/mrkeyboard/app/MrThemePreview;->badge(Landroid/graphics/Canvas;II)V

    goto :goto_0

    .line 259
    :cond_3
    const/high16 v0, 0x40000000    # 2.0f

    goto :goto_1

    .line 267
    :cond_4
    const v10, 0x3e2e147b    # 0.17f

    move-object v5, p0

    move-object v6, p1

    move-object v7, v2

    invoke-direct/range {v5 .. v10}, Lcom/mrkeyboard/app/MrThemePreview;->bar(Landroid/graphics/Canvas;Landroid/content/Context;FFF)V

    .line 268
    invoke-direct {p0, p1, v2, v8, v9}, Lcom/mrkeyboard/app/MrThemePreview;->keys(Landroid/graphics/Canvas;Landroid/content/Context;FF)V

    goto :goto_2
.end method

.method protected onMeasure(II)V
    .locals 3

    .prologue
    .line 239
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v1

    .line 240
    int-to-float v2, v1

    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFull:Z

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFullAspect:F

    :goto_0
    div-float v0, v2, v0

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-virtual {p0, v1, v0}, Lcom/mrkeyboard/app/MrThemePreview;->setMeasuredDimension(II)V

    .line 241
    return-void

    .line 240
    :cond_0
    const/high16 v0, 0x40000000    # 2.0f

    goto :goto_0
.end method

.method setChecked(ZII)V
    .locals 0

    .prologue
    .line 212
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mChecked:Z

    .line 213
    iput p2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mRing:I

    .line 214
    iput p3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCheck:I

    .line 215
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->invalidate()V

    .line 216
    return-void
.end method

.method setFull(Z)V
    .locals 1

    .prologue
    .line 200
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFull:Z

    if-ne v0, p1, :cond_0

    .line 204
    :goto_0
    return-void

    .line 201
    :cond_0
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFull:Z

    .line 202
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->requestLayout()V

    .line 203
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->invalidate()V

    goto :goto_0
.end method

.method setLook(Lcom/mrkeyboard/app/MrKeyLook;)V
    .locals 0

    .prologue
    .line 175
    if-nez p1, :cond_0

    sget-object p1, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    :cond_0
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 176
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->invalidate()V

    .line 177
    return-void
.end method

.method show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V
    .locals 1

    .prologue
    .line 165
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlus:Z

    .line 166
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    .line 167
    if-nez p2, :cond_0

    sget-object p2, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    :cond_0
    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 168
    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mImage:Landroid/graphics/Bitmap;

    .line 169
    iput p4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSoft:I

    .line 170
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->invalidate()V

    .line 171
    return-void
.end method

.method showPlus(III)V
    .locals 1

    .prologue
    .line 191
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlus:Z

    .line 192
    iput p1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusFill:I

    .line 193
    iput p2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusLine:I

    .line 194
    iput p3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusInk:I

    .line 195
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->invalidate()V

    .line 196
    return-void
.end method

.method spec()Lcom/mrkeyboard/app/MrBackdrop$Spec;
    .locals 1

    .prologue
    .line 224
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    return-object v0
.end method

.method tag()Ljava/lang/String;
    .locals 1

    .prologue
    .line 220
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    return-object v0
.end method
