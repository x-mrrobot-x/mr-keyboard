.class public final Lcom/mrkeyboard/app/MrGestureInput;
.super Ljava/lang/Object;
.source "MrGestureInput.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrGestureInput$Engine;
    }
.end annotation


# static fields
.field static final ALTERNATIVES:I = 0x3

.field private static final DEAD:I = 0x3

.field static final END_MARGIN_ROWS:F = 0.5f

.field private static final GESTURE:I = 0x2

.field private static final IDLE:I = 0x0

.field private static final KEYCODE_DELETE:I = -0x5

.field static final LONG_PRESS_MIN:I = 0x12c

.field static final LOOKBACK:I = 0x60

.field static final MIN_LOGP:F = -30.0f

.field private static final NONE:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/CharSequence;",
            ">;"
        }
    .end annotation
.end field

.field static final PREF_ON:Ljava/lang/String; = "pref_gesture_typing"

.field static final PREF_PREVIEW:Ljava/lang/String; = "pref_gesture_preview"

.field static final PREF_TRAIL:Ljava/lang/String; = "pref_gesture_trail"

.field private static final PREVIEW:Ljava/lang/Runnable;

.field static final PREVIEW_LOAD:I = 0x6

.field static final PREVIEW_MS:I = 0x78

.field static final REAL:Lcom/mrkeyboard/app/MrGestureInput$Engine;

.field static final START_KEYS:F = 0.7f

.field static final START_MIN_DP:F = 22.0f

.field private static final TRACK:I = 0x1

.field private static final TRAIL_ALPHA:I = -0x34000000

.field private static final TRAIL_RGB:I = 0x40c4ff

.field private static sAlts:[Ljava/lang/String;

.field private static sApp:Landroid/content/Context;

.field private static sBoundB:F

.field private static sBoundL:F

.field private static sBoundR:F

.field private static sBoundT:F

.field private static sCount:I

.field private static sDownTime:J

.field static sEngine:Lcom/mrkeyboard/app/MrGestureInput$Engine;

.field private static sFull:Z

.field private static sFx:[F

.field private static sFy:[F

.field private static sHandler:Landroid/os/Handler;

.field private static sHeight:F

.field private static final sKc:[C

.field private static final sKe:[I

.field private static sKeyCount:I

.field private static final sKh:[I

.field private static final sKw:[I

.field private static final sKx:[I

.field private static final sKy:[I

.field private static sLastEditor:Landroid/view/inputmethod/EditorInfo;

.field private static sLastSpace:Z

.field private static sLastWord:Ljava/lang/String;

.field private static sLayoutH:I

.field private static sLayoutOf:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference",
            "<",
            "Lcom/mrkeyboard/app/Keyboard;",
            ">;"
        }
    .end annotation
.end field

.field private static sLayoutOk:Z

.field private static sLayoutW:I

.field private static sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

.field static volatile sOn:Z

.field private static sPaint:Landroid/graphics/Paint;

.field private static sPath:Landroid/graphics/Path;

.field private static sPointer:I

.field private static sPrevRead:Z

.field private static sPrevWord:Ljava/lang/String;

.field static volatile sPreview:Z

.field private static final sPreviewBest:[Ljava/lang/String;

.field private static sPreviewCount:I

.field private static sPreviewDue:J

.field private static sPreviewOn:Z

.field private static sPreviewPosted:Z

.field private static sPreviewShown:Z

.field private static sPreviewWord:Ljava/lang/String;

.field private static sPt:[I

.field private static sPx:[F

.field private static sPy:[F

.field private static final sResult:Lcom/mrkeyboard/app/MrGesture$Result;

.field private static sRows:I

.field private static sStart2:F

.field private static sStatCount:I

.field private static sStatLast:J

.field private static sStatMax:J

.field private static sStatPreviewMax:J

.field private static sStatPreviewSum:J

.field private static sStatPreviews:I

.field private static sStatSum:J

.field private static sState:I

.field private static sTop:F

.field static volatile sTrail:Z

.field private static sTrailOn:Z

.field private static sTrailWidth:F

.field private static sView:Lcom/mrkeyboard/app/LatinKeyboardView;

.field private static sWidth:F

.field private static sWriting:Z


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x1

    const/16 v1, 0x40

    .line 121
    new-instance v0, Lcom/mrkeyboard/app/MrGestureInput$1;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrGestureInput$1;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->REAL:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    .line 154
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->REAL:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sEngine:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    .line 161
    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sTrail:Z

    .line 163
    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreview:Z

    .line 220
    sput v3, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    .line 230
    new-instance v0, Lcom/mrkeyboard/app/MrGesture$Result;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrGesture$Result;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sResult:Lcom/mrkeyboard/app/MrGesture$Result;

    .line 490
    new-array v0, v1, [I

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sKx:[I

    new-array v0, v1, [I

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sKy:[I

    .line 491
    new-array v0, v1, [I

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sKw:[I

    new-array v0, v1, [I

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sKh:[I

    .line 492
    new-array v0, v1, [I

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sKe:[I

    .line 493
    new-array v0, v1, [C

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sKc:[C

    .line 656
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, v3}, Ljava/util/ArrayList;-><init>(I)V

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->NONE:Ljava/util/List;

    .line 735
    new-array v0, v2, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewBest:[Ljava/lang/String;

    .line 739
    new-instance v0, Lcom/mrkeyboard/app/MrGestureInput$3;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrGestureInput$3;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->PREVIEW:Ljava/lang/Runnable;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 76
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$002(Z)Z
    .locals 0

    .prologue
    .line 75
    sput-boolean p0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewPosted:Z

    return p0
.end method

.method static synthetic access$100()I
    .locals 1

    .prologue
    .line 75
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    return v0
.end method

.method static synthetic access$200()Z
    .locals 1

    .prologue
    .line 75
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    return v0
.end method

.method static synthetic access$202(Z)Z
    .locals 0

    .prologue
    .line 75
    sput-boolean p0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    return p0
.end method

.method static synthetic access$300()Lcom/mrkeyboard/app/LatinKeyboardView;
    .locals 1

    .prologue
    .line 75
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sView:Lcom/mrkeyboard/app/LatinKeyboardView;

    return-object v0
.end method

.method static synthetic access$400()I
    .locals 1

    .prologue
    .line 75
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    return v0
.end method

.method static synthetic access$500()I
    .locals 1

    .prologue
    .line 75
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewCount:I

    return v0
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/LatinKeyboardView;)V
    .locals 0

    .prologue
    .line 75
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->previewNow(Lcom/mrkeyboard/app/LatinKeyboardView;)V

    return-void
.end method

.method private static add(FFJ)V
    .locals 4

    .prologue
    .line 444
    sget-wide v0, Lcom/mrkeyboard/app/MrGestureInput;->sDownTime:J

    sub-long v0, p2, v0

    long-to-int v0, v0

    .line 445
    sget v1, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    .line 446
    if-lez v1, :cond_1

    .line 447
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPt:[I

    add-int/lit8 v3, v1, -0x1

    aget v2, v2, v3

    if-ge v0, v2, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPt:[I

    add-int/lit8 v2, v1, -0x1

    aget v0, v0, v2

    .line 448
    :cond_0
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPt:[I

    add-int/lit8 v3, v1, -0x1

    aget v2, v2, v3

    if-ne v0, v2, :cond_1

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    add-int/lit8 v3, v1, -0x1

    aget v2, v2, v3

    cmpl-float v2, p0, v2

    if-nez v2, :cond_1

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    add-int/lit8 v3, v1, -0x1

    aget v2, v2, v3

    cmpl-float v2, p1, v2

    if-nez v2, :cond_1

    .line 458
    :goto_0
    return-void

    .line 450
    :cond_1
    const/16 v2, 0x1000

    if-lt v1, v2, :cond_2

    .line 451
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sFull:Z

    goto :goto_0

    .line 454
    :cond_2
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    aput p0, v2, v1

    .line 455
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    aput p1, v2, v1

    .line 456
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPt:[I

    aput v0, v2, v1

    .line 457
    add-int/lit8 v0, v1, 0x1

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    goto :goto_0
.end method

.method private static addAll(Landroid/view/MotionEvent;I)V
    .locals 6

    .prologue
    .line 438
    invoke-virtual {p0}, Landroid/view/MotionEvent;->getHistorySize()I

    move-result v1

    .line 439
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v1, :cond_0

    invoke-virtual {p0, p1, v0}, Landroid/view/MotionEvent;->getHistoricalX(II)F

    move-result v2

    invoke-virtual {p0, p1, v0}, Landroid/view/MotionEvent;->getHistoricalY(II)F

    move-result v3

    invoke-virtual {p0, v0}, Landroid/view/MotionEvent;->getHistoricalEventTime(I)J

    move-result-wide v4

    invoke-static {v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrGestureInput;->add(FFJ)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 440
    :cond_0
    invoke-virtual {p0, p1}, Landroid/view/MotionEvent;->getX(I)F

    move-result v0

    invoke-virtual {p0, p1}, Landroid/view/MotionEvent;->getY(I)F

    move-result v1

    invoke-virtual {p0}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v2

    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrGestureInput;->add(FFJ)V

    .line 441
    return-void
.end method

.method private static begin(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;)V
    .locals 10

    .prologue
    const/4 v9, 0x1

    const/16 v8, 0x1000

    const/4 v7, 0x0

    .line 304
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v0

    if-eq v0, v9, :cond_1

    .line 333
    :cond_0
    :goto_0
    return-void

    .line 305
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sEngine:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    .line 306
    invoke-interface {v0}, Lcom/mrkeyboard/app/MrGestureInput$Engine;->ready()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 307
    sget-object v1, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    .line 308
    if-eqz v1, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->isMain(Lcom/mrkeyboard/app/LatinKeyboardView;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 309
    invoke-static {}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInstance()Lcom/mrkeyboard/app/KeyboardSwitcher;

    move-result-object v2

    .line 310
    invoke-virtual {v2}, Lcom/mrkeyboard/app/KeyboardSwitcher;->isAlphabetMode()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v2}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getSheet()I

    move-result v2

    if-nez v2, :cond_0

    .line 311
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardView;->popupKeyboardIsShowing()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->styled()Z

    move-result v2

    if-nez v2, :cond_0

    .line 312
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardView;->getKeyboard()Lcom/mrkeyboard/app/Keyboard;

    move-result-object v2

    .line 313
    if-eqz v2, :cond_0

    invoke-static {v2}, Lcom/mrkeyboard/app/MrGestureInput;->layoutFor(Lcom/mrkeyboard/app/Keyboard;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 314
    invoke-virtual {p1, v7}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    invoke-virtual {p1, v7}, Landroid/view/MotionEvent;->getY(I)F

    move-result v4

    .line 315
    float-to-int v5, v3

    float-to-int v6, v4

    invoke-static {v5, v6}, Lcom/mrkeyboard/app/MrGestureInput;->letterAt(II)I

    move-result v5

    .line 316
    if-ltz v5, :cond_0

    invoke-static {v2}, Lcom/mrkeyboard/app/MrGestureInput;->modifierOn(Lcom/mrkeyboard/app/Keyboard;)Z

    move-result v2

    if-nez v2, :cond_0

    invoke-static {v1}, Lcom/mrkeyboard/app/MrGestureInput;->editorOk(Lcom/mrkeyboard/app/LatinIME;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v0, v1}, Lcom/mrkeyboard/app/MrGestureInput$Engine;->hasDictionary(Lcom/mrkeyboard/app/LatinIME;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 317
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    if-nez v0, :cond_2

    .line 318
    new-array v0, v8, [F

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    .line 319
    new-array v0, v8, [F

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    .line 320
    new-array v0, v8, [I

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPt:[I

    .line 322
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->density(Lcom/mrkeyboard/app/LatinKeyboardView;)F

    move-result v0

    .line 323
    const v1, 0x3f333333    # 0.7f

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sKw:[I

    aget v2, v2, v5

    int-to-float v2, v2

    mul-float/2addr v1, v2

    const/high16 v2, 0x41b00000    # 22.0f

    mul-float/2addr v2, v0

    invoke-static {v1, v2}, Ljava/lang/Math;->max(FF)F

    move-result v1

    .line 324
    mul-float/2addr v1, v1

    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sStart2:F

    .line 325
    const/high16 v1, 0x40400000    # 3.0f

    mul-float/2addr v1, v0

    const/high16 v2, 0x41000000    # 8.0f

    mul-float/2addr v0, v2

    const v2, 0x3df5c28f    # 0.12f

    sget-object v6, Lcom/mrkeyboard/app/MrGestureInput;->sKw:[I

    aget v5, v6, v5

    int-to-float v5, v5

    mul-float/2addr v2, v5

    invoke-static {v0, v2}, Ljava/lang/Math;->min(FF)F

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailWidth:F

    .line 326
    sput-object p0, Lcom/mrkeyboard/app/MrGestureInput;->sView:Lcom/mrkeyboard/app/LatinKeyboardView;

    .line 327
    invoke-virtual {p1, v7}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sPointer:I

    .line 328
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v0

    sput-wide v0, Lcom/mrkeyboard/app/MrGestureInput;->sDownTime:J

    .line 329
    sput v7, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    .line 330
    sput-boolean v7, Lcom/mrkeyboard/app/MrGestureInput;->sFull:Z

    .line 331
    sget-wide v0, Lcom/mrkeyboard/app/MrGestureInput;->sDownTime:J

    invoke-static {v3, v4, v0, v1}, Lcom/mrkeyboard/app/MrGestureInput;->add(FFJ)V

    .line 332
    sput v9, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    goto/16 :goto_0
.end method

.method private static buildLayout(Lcom/mrkeyboard/app/Keyboard;I)Z
    .locals 11

    .prologue
    const/high16 v10, 0x40000000    # 2.0f

    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 514
    sput v3, Lcom/mrkeyboard/app/MrGestureInput;->sKeyCount:I

    .line 515
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Keyboard;->getKeys()Ljava/util/List;

    move-result-object v7

    .line 517
    invoke-interface {v7}, Ljava/util/List;->size()I

    move-result v8

    move v6, v3

    move v4, v3

    :goto_0
    if-ge v6, v8, :cond_7

    .line 518
    invoke-interface {v7, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/Keyboard$Key;

    .line 519
    if-eqz v0, :cond_f

    iget-object v1, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    if-eqz v1, :cond_f

    iget-object v1, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    array-length v1, v1

    if-eqz v1, :cond_f

    iget-object v1, v0, Lcom/mrkeyboard/app/Keyboard$Key;->text:Ljava/lang/CharSequence;

    if-nez v1, :cond_f

    iget v1, v0, Lcom/mrkeyboard/app/Keyboard$Key;->width:I

    if-lez v1, :cond_f

    iget v1, v0, Lcom/mrkeyboard/app/Keyboard$Key;->height:I

    if-gtz v1, :cond_0

    move v0, v4

    .line 517
    :goto_1
    add-int/lit8 v1, v6, 0x1

    move v6, v1

    move v4, v0

    goto :goto_0

    .line 520
    :cond_0
    iget-object v1, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    aget v1, v1, v3

    .line 521
    if-lez v1, :cond_f

    const v5, 0xffff

    if-gt v1, v5, :cond_f

    invoke-static {v1}, Ljava/lang/Character;->isLetter(I)Z

    move-result v5

    if-nez v5, :cond_1

    move v0, v4

    goto :goto_1

    .line 522
    :cond_1
    int-to-char v1, v1

    invoke-static {v1}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v9

    move v5, v3

    move v1, v3

    .line 524
    :goto_2
    if-ge v5, v4, :cond_3

    if-nez v1, :cond_3

    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKc:[C

    aget-char v1, v1, v5

    if-ne v1, v9, :cond_2

    move v1, v2

    :goto_3
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    :cond_2
    move v1, v3

    goto :goto_3

    .line 525
    :cond_3
    if-eqz v1, :cond_4

    move v0, v4

    goto :goto_1

    .line 526
    :cond_4
    const/16 v1, 0x40

    if-ne v4, v1, :cond_6

    .line 560
    :cond_5
    :goto_4
    return v3

    .line 527
    :cond_6
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKc:[C

    aput-char v9, v1, v4

    .line 528
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKx:[I

    iget v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->x:I

    aput v5, v1, v4

    .line 529
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKy:[I

    iget v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->y:I

    aput v5, v1, v4

    .line 530
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKw:[I

    iget v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->width:I

    aput v5, v1, v4

    .line 531
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKh:[I

    iget v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->height:I

    aput v5, v1, v4

    .line 532
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKe:[I

    iget v0, v0, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    aput v0, v1, v4

    .line 533
    add-int/lit8 v0, v4, 0x1

    goto :goto_1

    .line 535
    :cond_7
    const/4 v0, 0x2

    if-lt v4, v0, :cond_5

    if-lez p1, :cond_5

    .line 537
    new-array v5, v4, [I

    move v0, v3

    .line 538
    :goto_5
    if-ge v0, v4, :cond_8

    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKy:[I

    aget v1, v1, v0

    aput v1, v5, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_5

    .line 539
    :cond_8
    invoke-static {v5}, Ljava/util/Arrays;->sort([I)V

    move v1, v2

    move v0, v2

    .line 541
    :goto_6
    if-ge v1, v4, :cond_a

    aget v6, v5, v1

    add-int/lit8 v7, v1, -0x1

    aget v7, v5, v7

    if-eq v6, v7, :cond_9

    add-int/lit8 v0, v0, 0x1

    :cond_9
    add-int/lit8 v1, v1, 0x1

    goto :goto_6

    .line 542
    :cond_a
    aget v6, v5, v3

    add-int/lit8 v1, v4, -0x1

    aget v7, v5, v1

    move v5, v3

    move v1, v3

    .line 544
    :goto_7
    if-ge v5, v4, :cond_c

    sget-object v8, Lcom/mrkeyboard/app/MrGestureInput;->sKy:[I

    aget v8, v8, v5

    if-ne v8, v6, :cond_b

    sget-object v8, Lcom/mrkeyboard/app/MrGestureInput;->sKh:[I

    aget v8, v8, v5

    invoke-static {v1, v8}, Ljava/lang/Math;->max(II)I

    move-result v1

    :cond_b
    add-int/lit8 v5, v5, 0x1

    goto :goto_7

    .line 545
    :cond_c
    if-le v0, v2, :cond_d

    sub-int v5, v7, v6

    int-to-float v5, v5

    add-int/lit8 v7, v0, -0x1

    int-to-float v7, v7

    div-float/2addr v5, v7

    .line 546
    :goto_8
    const/4 v7, 0x0

    cmpg-float v7, v5, v7

    if-lez v7, :cond_5

    .line 547
    int-to-float v6, v6

    int-to-float v1, v1

    sub-float v1, v5, v1

    div-float/2addr v1, v10

    sub-float v1, v6, v1

    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sTop:F

    .line 548
    int-to-float v1, v0

    mul-float/2addr v1, v5

    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sHeight:F

    .line 549
    int-to-float v1, p1

    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sWidth:F

    .line 550
    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sRows:I

    .line 551
    new-array v1, v4, [C

    .line 552
    mul-int/lit8 v0, v4, 0x2

    new-array v5, v0, [F

    move v0, v3

    .line 553
    :goto_9
    if-ge v0, v4, :cond_e

    .line 554
    sget-object v6, Lcom/mrkeyboard/app/MrGestureInput;->sKc:[C

    aget-char v6, v6, v0

    aput-char v6, v1, v0

    .line 555
    mul-int/lit8 v6, v0, 0x2

    sget-object v7, Lcom/mrkeyboard/app/MrGestureInput;->sKx:[I

    aget v7, v7, v0

    int-to-float v7, v7

    sget-object v8, Lcom/mrkeyboard/app/MrGestureInput;->sKw:[I

    aget v8, v8, v0

    int-to-float v8, v8

    div-float/2addr v8, v10

    add-float/2addr v7, v8

    sget v8, Lcom/mrkeyboard/app/MrGestureInput;->sWidth:F

    div-float/2addr v7, v8

    aput v7, v5, v6

    .line 556
    mul-int/lit8 v6, v0, 0x2

    add-int/lit8 v6, v6, 0x1

    sget-object v7, Lcom/mrkeyboard/app/MrGestureInput;->sKy:[I

    aget v7, v7, v0

    int-to-float v7, v7

    sget-object v8, Lcom/mrkeyboard/app/MrGestureInput;->sKh:[I

    aget v8, v8, v0

    int-to-float v8, v8

    div-float/2addr v8, v10

    add-float/2addr v7, v8

    sget v8, Lcom/mrkeyboard/app/MrGestureInput;->sTop:F

    sub-float/2addr v7, v8

    sget v8, Lcom/mrkeyboard/app/MrGestureInput;->sHeight:F

    div-float/2addr v7, v8

    aput v7, v5, v6

    .line 553
    add-int/lit8 v0, v0, 0x1

    goto :goto_9

    .line 545
    :cond_d
    int-to-float v5, v1

    goto :goto_8

    .line 558
    :cond_e
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sEngine:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    invoke-interface {v0, v1, v5}, Lcom/mrkeyboard/app/MrGestureInput$Engine;->layout([C[F)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 559
    sput v4, Lcom/mrkeyboard/app/MrGestureInput;->sKeyCount:I

    move v3, v2

    .line 560
    goto/16 :goto_4

    :cond_f
    move v0, v4

    goto/16 :goto_1
.end method

.method static candidates(Lcom/mrkeyboard/app/MrGesture$Result;[Ljava/lang/String;)I
    .locals 7

    .prologue
    const/4 v2, 0x0

    .line 711
    .line 712
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrGesture$Result;->count()I

    move-result v5

    move v4, v2

    move v0, v2

    .line 713
    :goto_0
    if-ge v4, v5, :cond_2

    array-length v1, p1

    if-ge v0, v1, :cond_2

    .line 714
    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrGesture$Result;->word(I)Ljava/lang/String;

    move-result-object v6

    .line 715
    invoke-static {v6}, Lcom/mrkeyboard/app/MrLearned;->isBlocked(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 713
    :cond_0
    :goto_1
    add-int/lit8 v1, v4, 0x1

    move v4, v1

    goto :goto_0

    .line 716
    :cond_1
    if-nez v0, :cond_3

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrGesture$Result;->logp(I)F

    move-result v1

    const/high16 v3, -0x3e100000    # -30.0f

    cmpg-float v1, v1, v3

    if-gez v1, :cond_3

    move v0, v2

    .line 721
    :cond_2
    return v0

    :cond_3
    move v1, v2

    move v3, v2

    .line 718
    :goto_2
    if-ge v1, v0, :cond_4

    if-nez v3, :cond_4

    aget-object v3, p1, v1

    invoke-static {v3, v6}, Lcom/mrkeyboard/app/MrGesture;->sameIgnoringCase(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 719
    :cond_4
    if-nez v3, :cond_0

    add-int/lit8 v1, v0, 0x1

    aput-object v6, p1, v0

    move v0, v1

    goto :goto_1
.end method

.method private static density(Lcom/mrkeyboard/app/LatinKeyboardView;)F
    .locals 3

    .prologue
    const/high16 v1, 0x3f800000    # 1.0f

    .line 345
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 346
    const/4 v2, 0x0

    cmpl-float v2, v0, v2

    if-lez v2, :cond_0

    .line 348
    :goto_0
    return v0

    :cond_0
    move v0, v1

    .line 346
    goto :goto_0

    .line 347
    :catch_0
    move-exception v0

    move v0, v1

    .line 348
    goto :goto_0
.end method

.method public static draw(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/graphics/Canvas;)V
    .locals 2

    .prologue
    .line 646
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-eq p0, v0, :cond_1

    .line 652
    :cond_0
    :goto_0
    return-void

    .line 648
    :cond_1
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 649
    :catch_0
    move-exception v0

    .line 650
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    goto :goto_0
.end method

.method private static editorOk(Lcom/mrkeyboard/app/LatinIME;)Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 462
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v2

    .line 463
    if-eqz v2, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v3

    if-nez v3, :cond_1

    .line 468
    :cond_0
    :goto_0
    return v1

    .line 464
    :cond_1
    iget v2, v2, Landroid/view/inputmethod/EditorInfo;->inputType:I

    .line 465
    and-int/lit8 v3, v2, 0xf

    if-ne v3, v0, :cond_0

    .line 466
    const/high16 v3, 0x80000

    and-int/2addr v3, v2

    if-nez v3, :cond_0

    .line 467
    and-int/lit16 v2, v2, 0xff0

    .line 468
    const/16 v3, 0x80

    if-eq v2, v3, :cond_2

    const/16 v3, 0x90

    if-eq v2, v3, :cond_2

    const/16 v3, 0xe0

    if-eq v2, v3, :cond_2

    const/16 v3, 0x10

    if-eq v2, v3, :cond_2

    const/16 v3, 0x20

    if-eq v2, v3, :cond_2

    const/16 v3, 0xd0

    if-eq v2, v3, :cond_2

    :goto_1
    move v1, v0

    goto :goto_0

    :cond_2
    move v0, v1

    goto :goto_1
.end method

.method private static end(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;IZ)V
    .locals 3

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 421
    const/4 v2, 0x3

    sput v2, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    .line 424
    if-ltz p2, :cond_0

    :try_start_0
    invoke-static {p1, p2}, Lcom/mrkeyboard/app/MrGestureInput;->addAll(Landroid/view/MotionEvent;I)V

    .line 425
    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->trailEnd(Lcom/mrkeyboard/app/LatinKeyboardView;)V

    .line 426
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->finish(Lcom/mrkeyboard/app/LatinKeyboardView;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-result v2

    .line 429
    if-nez v2, :cond_2

    :goto_0
    :try_start_1
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGestureInput;->previewEnd(Z)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 431
    if-eqz p3, :cond_1

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    .line 434
    :cond_1
    return-void

    :cond_2
    move v1, v0

    .line 429
    goto :goto_0

    .line 431
    :catchall_0
    move-exception v0

    if-eqz p3, :cond_3

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    .line 432
    :cond_3
    throw v0

    .line 428
    :catchall_1
    move-exception v0

    .line 429
    :try_start_2
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGestureInput;->previewEnd(Z)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 431
    if-eqz p3, :cond_4

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    .line 433
    :cond_4
    throw v0

    .line 431
    :catchall_2
    move-exception v0

    if-eqz p3, :cond_5

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    .line 432
    :cond_5
    throw v0
.end method

.method private static farEnough(I)Z
    .locals 7

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 381
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sFull:Z

    if-eqz v0, :cond_0

    move v0, v1

    .line 387
    :goto_0
    return v0

    .line 382
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    aget v3, v0, v2

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    aget v4, v0, v2

    .line 383
    invoke-static {p0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    :goto_1
    sget v5, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    if-ge v0, v5, :cond_2

    .line 384
    sget-object v5, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    aget v5, v5, v0

    sub-float/2addr v5, v3

    sget-object v6, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    aget v6, v6, v0

    sub-float/2addr v6, v4

    .line 385
    mul-float/2addr v5, v5

    mul-float/2addr v6, v6

    add-float/2addr v5, v6

    sget v6, Lcom/mrkeyboard/app/MrGestureInput;->sStart2:F

    cmpl-float v5, v5, v6

    if-ltz v5, :cond_1

    move v0, v1

    goto :goto_0

    .line 383
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_2
    move v0, v2

    .line 387
    goto :goto_0
.end method

.method private static finish(Lcom/mrkeyboard/app/LatinKeyboardView;)Z
    .locals 14

    .prologue
    const/4 v8, 0x0

    .line 666
    sget v5, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    .line 667
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sFull:Z

    if-nez v0, :cond_0

    const/4 v0, 0x2

    if-lt v5, v0, :cond_0

    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sHeight:F

    const/4 v1, 0x0

    cmpg-float v0, v0, v1

    if-lez v0, :cond_0

    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sRows:I

    if-gtz v0, :cond_1

    :cond_0
    move v0, v8

    .line 690
    :goto_0
    return v0

    .line 668
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    add-int/lit8 v1, v5, -0x1

    aget v0, v0, v1

    sget v1, Lcom/mrkeyboard/app/MrGestureInput;->sTop:F

    sub-float/2addr v0, v1

    sget v1, Lcom/mrkeyboard/app/MrGestureInput;->sHeight:F

    div-float/2addr v0, v1

    .line 669
    const/high16 v1, 0x3f000000    # 0.5f

    sget v2, Lcom/mrkeyboard/app/MrGestureInput;->sRows:I

    int-to-float v2, v2

    div-float/2addr v1, v2

    .line 670
    neg-float v2, v1

    cmpg-float v2, v0, v2

    if-ltz v2, :cond_2

    const/high16 v2, 0x3f800000    # 1.0f

    add-float/2addr v1, v2

    cmpl-float v0, v0, v1

    if-lez v0, :cond_3

    :cond_2
    move v0, v8

    goto :goto_0

    .line 671
    :cond_3
    sget-object v1, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    .line 672
    if-nez v1, :cond_4

    move v0, v8

    goto :goto_0

    .line 673
    :cond_4
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardView;->getShiftState()I

    move-result v9

    .line 674
    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->mrCommit()V

    .line 675
    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v10

    .line 676
    if-nez v10, :cond_5

    move v0, v8

    goto :goto_0

    .line 677
    :cond_5
    invoke-interface {v10}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    .line 678
    const/16 v0, 0x60

    invoke-interface {v10, v0, v8}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v11

    .line 679
    invoke-static {v11}, Lcom/mrkeyboard/app/MrText;->lastWord(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v6

    .line 680
    invoke-static {v5}, Lcom/mrkeyboard/app/MrGestureInput;->frame(I)V

    .line 681
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v12

    .line 682
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sEngine:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sFx:[F

    sget-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sFy:[F

    sget-object v4, Lcom/mrkeyboard/app/MrGestureInput;->sPt:[I

    sget-object v7, Lcom/mrkeyboard/app/MrGestureInput;->sResult:Lcom/mrkeyboard/app/MrGesture$Result;

    invoke-interface/range {v0 .. v7}, Lcom/mrkeyboard/app/MrGestureInput$Engine;->decode(Lcom/mrkeyboard/app/LatinIME;[F[F[IILjava/lang/String;Lcom/mrkeyboard/app/MrGesture$Result;)I

    move-result v0

    .line 683
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v2

    sub-long/2addr v2, v12

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrGestureInput;->stat(J)V

    .line 684
    if-gtz v0, :cond_6

    move v0, v8

    goto :goto_0

    .line 685
    :cond_6
    const/4 v0, 0x4

    new-array v0, v0, [Ljava/lang/String;

    .line 686
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sResult:Lcom/mrkeyboard/app/MrGesture$Result;

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrGestureInput;->candidates(Lcom/mrkeyboard/app/MrGesture$Result;[Ljava/lang/String;)I

    move-result v2

    .line 687
    if-gtz v2, :cond_7

    move v0, v8

    goto :goto_0

    .line 688
    :cond_7
    :goto_1
    if-ge v8, v2, :cond_8

    aget-object v3, v0, v8

    invoke-static {v3, v9}, Lcom/mrkeyboard/app/MrGestureInput;->withCase(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v0, v8

    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    .line 689
    :cond_8
    invoke-static {v11}, Lcom/mrkeyboard/app/MrGestureInput;->needsSpace(Ljava/lang/CharSequence;)Z

    move-result v3

    invoke-static {v1, v10, v3, v0, v2}, Lcom/mrkeyboard/app/MrGestureInput;->write(Lcom/mrkeyboard/app/LatinIME;Landroid/view/inputmethod/InputConnection;Z[Ljava/lang/String;I)V

    .line 690
    const/4 v0, 0x1

    goto/16 :goto_0
.end method

.method private static forget()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 909
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    .line 910
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sLastEditor:Landroid/view/inputmethod/EditorInfo;

    .line 911
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    .line 912
    return-void
.end method

.method private static frame(I)V
    .locals 4

    .prologue
    const/16 v1, 0x1000

    .line 695
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sFx:[F

    if-nez v0, :cond_0

    .line 696
    new-array v0, v1, [F

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sFx:[F

    .line 697
    new-array v0, v1, [F

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sFy:[F

    .line 699
    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-ge v0, p0, :cond_1

    .line 700
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sFx:[F

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    aget v2, v2, v0

    sget v3, Lcom/mrkeyboard/app/MrGestureInput;->sWidth:F

    div-float/2addr v2, v3

    aput v2, v1, v0

    .line 701
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sFy:[F

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    aget v2, v2, v0

    sget v3, Lcom/mrkeyboard/app/MrGestureInput;->sTop:F

    sub-float/2addr v2, v3

    sget v3, Lcom/mrkeyboard/app/MrGestureInput;->sHeight:F

    div-float/2addr v2, v3

    aput v2, v1, v0

    .line 699
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 703
    :cond_1
    return-void
.end method

.method private static gesture(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;I)V
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 392
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sPointer:I

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->findPointerIndex(I)I

    move-result v0

    .line 393
    packed-switch p2, :pswitch_data_0

    .line 415
    :cond_0
    :goto_0
    :pswitch_0
    return-void

    .line 395
    :pswitch_1
    if-ltz v0, :cond_0

    .line 396
    sget v1, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    .line 397
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrGestureInput;->addAll(Landroid/view/MotionEvent;I)V

    .line 398
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrGestureInput;->trailGrow(Lcom/mrkeyboard/app/LatinKeyboardView;I)V

    .line 399
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    if-eqz v0, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->previewMove(Lcom/mrkeyboard/app/LatinKeyboardView;)V

    goto :goto_0

    .line 403
    :pswitch_2
    if-ltz v0, :cond_0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v1

    if-ne v1, v0, :cond_0

    .line 404
    const/4 v1, 0x0

    invoke-static {p0, p1, v0, v1}, Lcom/mrkeyboard/app/MrGestureInput;->end(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;IZ)V

    goto :goto_0

    .line 407
    :pswitch_3
    invoke-static {p0, p1, v0, v1}, Lcom/mrkeyboard/app/MrGestureInput;->end(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;IZ)V

    goto :goto_0

    .line 410
    :pswitch_4
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->trailEnd(Lcom/mrkeyboard/app/LatinKeyboardView;)V

    .line 411
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGestureInput;->previewEnd(Z)V

    .line 412
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    goto :goto_0

    .line 393
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_1
        :pswitch_4
        :pswitch_0
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.method static handlerForTest()Landroid/os/Handler;
    .locals 1

    .prologue
    .line 1060
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static declared-synchronized init(Landroid/content/Context;)V
    .locals 3

    .prologue
    .line 173
    const-class v1, Lcom/mrkeyboard/app/MrGestureInput;

    monitor-enter v1

    if-nez p0, :cond_0

    .line 191
    :goto_0
    monitor-exit v1

    return-void

    .line 174
    :cond_0
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sApp:Landroid/content/Context;

    if-nez v0, :cond_2

    .line 175
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 176
    if-eqz v0, :cond_1

    move-object p0, v0

    :cond_1
    sput-object p0, Lcom/mrkeyboard/app/MrGestureInput;->sApp:Landroid/content/Context;

    .line 177
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sApp:Landroid/content/Context;

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 178
    if-eqz v0, :cond_2

    .line 179
    new-instance v2, Lcom/mrkeyboard/app/MrGestureInput$2;

    invoke-direct {v2}, Lcom/mrkeyboard/app/MrGestureInput$2;-><init>()V

    sput-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .line 184
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v0, v2}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 187
    :cond_2
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrGestureInput;->reload(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 188
    :catch_0
    move-exception v0

    .line 189
    const/4 v0, 0x0

    :try_start_1
    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sOn:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 173
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private static isMain(Lcom/mrkeyboard/app/LatinKeyboardView;)Z
    .locals 1

    .prologue
    .line 291
    invoke-static {}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInstance()Lcom/mrkeyboard/app/KeyboardSwitcher;

    move-result-object v0

    .line 292
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInputView()Lcom/mrkeyboard/app/LatinKeyboardView;

    move-result-object v0

    if-ne v0, p0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static layoutFor(Lcom/mrkeyboard/app/Keyboard;)Z
    .locals 3

    .prologue
    .line 499
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Keyboard;->getMinWidth()I

    move-result v0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/Keyboard;->getHeight()I

    move-result v1

    .line 500
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutOf:Ljava/lang/ref/WeakReference;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutOf:Ljava/lang/ref/WeakReference;

    invoke-virtual {v2}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v2

    if-ne v2, p0, :cond_0

    sget v2, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutW:I

    if-ne v0, v2, :cond_0

    sget v2, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutH:I

    if-ne v1, v2, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutOk:Z

    .line 506
    :goto_0
    return v0

    .line 501
    :cond_0
    new-instance v2, Ljava/lang/ref/WeakReference;

    invoke-direct {v2, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutOf:Ljava/lang/ref/WeakReference;

    .line 502
    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutW:I

    .line 503
    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutH:I

    .line 504
    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutOk:Z

    .line 505
    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrGestureInput;->buildLayout(Lcom/mrkeyboard/app/Keyboard;I)Z

    move-result v0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutOk:Z

    .line 506
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutOk:Z

    goto :goto_0
.end method

.method private static letterAt(II)I
    .locals 7

    .prologue
    .line 565
    const/4 v0, 0x0

    :goto_0
    sget v1, Lcom/mrkeyboard/app/MrGestureInput;->sKeyCount:I

    if-ge v0, v1, :cond_5

    .line 566
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKe:[I

    aget v1, v1, v0

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sKx:[I

    aget v2, v2, v0

    sget-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sKy:[I

    aget v3, v3, v0

    sget-object v4, Lcom/mrkeyboard/app/MrGestureInput;->sKw:[I

    aget v4, v4, v0

    add-int/2addr v4, v2

    sget-object v5, Lcom/mrkeyboard/app/MrGestureInput;->sKh:[I

    aget v5, v5, v0

    add-int/2addr v5, v3

    .line 567
    if-ge p0, v2, :cond_0

    and-int/lit8 v6, v1, 0x1

    if-eqz v6, :cond_4

    if-gt p0, v4, :cond_4

    :cond_0
    if-lt p0, v4, :cond_1

    and-int/lit8 v4, v1, 0x2

    if-eqz v4, :cond_4

    if-lt p0, v2, :cond_4

    :cond_1
    if-ge p1, v3, :cond_2

    and-int/lit8 v2, v1, 0x4

    if-eqz v2, :cond_4

    if-gt p1, v5, :cond_4

    :cond_2
    if-lt p1, v5, :cond_3

    and-int/lit8 v1, v1, 0x8

    if-eqz v1, :cond_4

    if-lt p1, v3, :cond_4

    .line 572
    :cond_3
    :goto_1
    return v0

    .line 565
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 572
    :cond_5
    const/4 v0, -0x1

    goto :goto_1
.end method

.method public static longPress(I)I
    .locals 3

    .prologue
    const/16 v0, 0x12c

    .line 583
    sget v1, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    if-ge p0, v0, :cond_0

    move p0, v0

    :cond_0
    return p0
.end method

.method private static modifierOn(Lcom/mrkeyboard/app/Keyboard;)Z
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 474
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Keyboard;->getKeys()Ljava/util/List;

    move-result-object v3

    .line 475
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v4

    move v2, v1

    :goto_0
    if-ge v2, v4, :cond_3

    .line 476
    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/Keyboard$Key;

    .line 477
    if-eqz v0, :cond_0

    iget-boolean v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->on:Z

    if-eqz v5, :cond_0

    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    if-eqz v5, :cond_0

    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    array-length v5, v5

    if-nez v5, :cond_1

    .line 475
    :cond_0
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    .line 478
    :cond_1
    iget-object v0, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    aget v0, v0, v1

    .line 479
    const/16 v5, -0x71

    if-eq v0, v5, :cond_2

    const/16 v5, -0x39

    if-eq v0, v5, :cond_2

    const/16 v5, -0x75

    if-ne v0, v5, :cond_0

    :cond_2
    const/4 v0, 0x1

    .line 481
    :goto_1
    return v0

    :cond_3
    move v0, v1

    goto :goto_1
.end method

.method static needsSpace(Ljava/lang/CharSequence;)Z
    .locals 5

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 858
    if-nez p0, :cond_1

    .line 868
    :cond_0
    :goto_0
    return v1

    .line 859
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    .line 860
    if-eqz v2, :cond_0

    .line 861
    add-int/lit8 v3, v2, -0x1

    invoke-interface {p0, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    .line 862
    invoke-static {v3}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v4

    if-nez v4, :cond_0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrGestureInput;->opens(C)Z

    move-result v4

    if-nez v4, :cond_0

    .line 863
    const/16 v4, 0x22

    if-eq v3, v4, :cond_2

    const/16 v4, 0x27

    if-ne v3, v4, :cond_4

    .line 864
    :cond_2
    if-eq v2, v0, :cond_0

    .line 865
    add-int/lit8 v2, v2, -0x2

    invoke-interface {p0, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v2

    .line 866
    invoke-static {v2}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v3

    if-nez v3, :cond_3

    invoke-static {v2}, Lcom/mrkeyboard/app/MrGestureInput;->opens(C)Z

    move-result v2

    if-nez v2, :cond_3

    :goto_1
    move v1, v0

    goto :goto_0

    :cond_3
    move v0, v1

    goto :goto_1

    :cond_4
    move v1, v0

    .line 868
    goto :goto_0
.end method

.method public static onBackspace(Lcom/mrkeyboard/app/LatinIME;)V
    .locals 7

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 974
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    if-eqz v2, :cond_0

    sget-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    if-eqz v2, :cond_1

    .line 991
    :cond_0
    :goto_0
    return-void

    .line 976
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v3

    .line 977
    invoke-static {p0, v3}, Lcom/mrkeyboard/app/MrGestureInput;->written(Lcom/mrkeyboard/app/LatinIME;Landroid/view/inputmethod/InputConnection;)I

    move-result v2

    .line 978
    if-lez v2, :cond_3

    .line 979
    sget-boolean v4, Lcom/mrkeyboard/app/MrGestureInput;->sLastSpace:Z

    if-eqz v4, :cond_2

    .line 980
    add-int/lit8 v4, v2, 0x1

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v4

    .line 981
    if-eqz v4, :cond_2

    invoke-interface {v4}, Ljava/lang/CharSequence;->length()I

    move-result v5

    add-int/lit8 v6, v2, 0x1

    if-ne v5, v6, :cond_2

    const/4 v5, 0x0

    invoke-interface {v4, v5}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v4

    const/16 v5, 0x20

    if-ne v4, v5, :cond_2

    add-int/lit8 v2, v2, 0x1

    .line 983
    :cond_2
    if-le v2, v0, :cond_3

    add-int/lit8 v2, v2, -0x1

    const/4 v4, 0x0

    invoke-interface {v3, v2, v4}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z

    .line 985
    :cond_3
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    if-eqz v2, :cond_4

    .line 986
    :goto_1
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->forget()V

    .line 987
    if-eqz v0, :cond_0

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinIME;->mrStrip(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 988
    :catch_0
    move-exception v0

    .line 989
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->forget()V

    goto :goto_0

    :cond_4
    move v0, v1

    .line 985
    goto :goto_1
.end method

.method public static onKey(Lcom/mrkeyboard/app/LatinIME;I)V
    .locals 1

    .prologue
    .line 995
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    if-nez v0, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    if-nez v0, :cond_1

    .line 1004
    :cond_0
    :goto_0
    return-void

    .line 996
    :cond_1
    const/4 v0, -0x5

    if-eq p1, v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    if-nez v0, :cond_0

    .line 998
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    if-eqz v0, :cond_2

    const/4 v0, 0x1

    .line 999
    :goto_1
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->forget()V

    .line 1000
    if-eqz v0, :cond_0

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinIME;->mrStrip(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1001
    :catch_0
    move-exception v0

    .line 1002
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->forget()V

    goto :goto_0

    .line 998
    :cond_2
    const/4 v0, 0x0

    goto :goto_1
.end method

.method public static onPick(Lcom/mrkeyboard/app/LatinIME;ILjava/lang/CharSequence;)Z
    .locals 8

    .prologue
    const/4 v3, 0x1

    const/4 v4, -0x1

    const/4 v2, 0x0

    .line 935
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    if-eqz v0, :cond_0

    move v0, v2

    .line 965
    :goto_0
    return v0

    .line 936
    :cond_0
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewShown:Z

    if-eqz v0, :cond_1

    move v0, v3

    goto :goto_0

    .line 937
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    if-nez v0, :cond_2

    move v0, v2

    goto :goto_0

    .line 939
    :cond_2
    :try_start_0
    sget-object v6, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    move v1, v2

    move v0, v4

    .line 941
    :goto_1
    array-length v5, v6

    if-ge v1, v5, :cond_4

    aget-object v5, v6, v1

    if-ne v5, p2, :cond_3

    move v0, v1

    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 942
    :cond_4
    if-ltz v0, :cond_5

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v1

    move-object v5, v1

    .line 943
    :goto_2
    if-ltz v0, :cond_6

    invoke-static {p0, v5}, Lcom/mrkeyboard/app/MrGestureInput;->written(Lcom/mrkeyboard/app/LatinIME;Landroid/view/inputmethod/InputConnection;)I

    move-result v1

    .line 944
    :goto_3
    if-gez v1, :cond_7

    .line 945
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->forget()V

    move v0, v2

    .line 946
    goto :goto_0

    .line 942
    :cond_5
    const/4 v1, 0x0

    move-object v5, v1

    goto :goto_2

    :cond_6
    move v1, v4

    .line 943
    goto :goto_3

    .line 948
    :cond_7
    aget-object v4, v6, v0

    .line 949
    sget-object v7, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    aput-object v7, v6, v0

    .line 950
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 951
    invoke-interface {v5}, Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 953
    const/4 v0, 0x0

    :try_start_1
    invoke-interface {v5, v1, v0}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z

    .line 954
    const/4 v0, -0x1

    invoke-virtual {p0, v0, v4}, Lcom/mrkeyboard/app/LatinIME;->pickSuggestionManually(ILjava/lang/CharSequence;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 956
    const/4 v0, 0x0

    :try_start_2
    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 957
    invoke-interface {v5}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 959
    sput-object v4, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    .line 960
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->showAlternatives(Lcom/mrkeyboard/app/LatinIME;)V

    move v0, v3

    .line 961
    goto :goto_0

    .line 956
    :catchall_0
    move-exception v0

    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 957
    invoke-interface {v5}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 958
    throw v0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    .line 962
    :catch_0
    move-exception v0

    .line 963
    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 964
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->forget()V

    move v0, v2

    .line 965
    goto :goto_0
.end method

.method public static onTouch(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;)Z
    .locals 8

    .prologue
    const/4 v7, 0x2

    const/4 v4, -0x1

    const/4 v0, 0x0

    const/4 v6, 0x3

    const/4 v1, 0x1

    .line 236
    sget v5, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    .line 237
    if-nez v5, :cond_0

    sget-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sOn:Z

    if-nez v2, :cond_0

    .line 258
    :goto_0
    return v0

    .line 240
    :cond_0
    :try_start_0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 241
    :try_start_1
    invoke-static {p0, p1, v2}, Lcom/mrkeyboard/app/MrGestureInput;->touch(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;I)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_3

    move-result v0

    goto :goto_0

    .line 242
    :catch_0
    move-exception v2

    move v3, v4

    .line 245
    :goto_1
    if-eq v5, v7, :cond_1

    if-eq v5, v6, :cond_1

    sget v2, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    if-eq v2, v7, :cond_1

    sget v2, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    if-ne v2, v6, :cond_4

    :cond_1
    move v2, v1

    .line 246
    :goto_2
    if-eq v3, v1, :cond_2

    if-eq v3, v6, :cond_2

    if-ne v3, v4, :cond_3

    :cond_2
    move v0, v1

    .line 248
    :cond_3
    :try_start_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->trailEnd(Lcom/mrkeyboard/app/LatinKeyboardView;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    .line 253
    :goto_3
    const/4 v1, 0x1

    :try_start_3
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGestureInput;->previewEnd(Z)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    .line 257
    :goto_4
    if-eqz v2, :cond_5

    if-nez v0, :cond_5

    sput v6, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    :goto_5
    move v0, v2

    .line 258
    goto :goto_0

    :cond_4
    move v2, v0

    .line 245
    goto :goto_2

    .line 257
    :cond_5
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    goto :goto_5

    .line 249
    :catch_1
    move-exception v1

    goto :goto_3

    .line 254
    :catch_2
    move-exception v1

    goto :goto_4

    .line 242
    :catch_3
    move-exception v3

    move v3, v2

    goto :goto_1
.end method

.method private static opens(C)Z
    .locals 1

    .prologue
    .line 872
    const-string v0, "([{<\u00ab\u201c\u2018\u00bf\u00a1/\\@#_-"

    invoke-virtual {v0, p0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static previewEnd(Z)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x0

    .line 829
    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    .line 830
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewPosted:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sHandler:Landroid/os/Handler;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sHandler:Landroid/os/Handler;

    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->PREVIEW:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 831
    :cond_0
    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewPosted:Z

    .line 832
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewShown:Z

    .line 833
    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewShown:Z

    .line 834
    sput-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewWord:Ljava/lang/String;

    .line 835
    sput-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sPrevWord:Ljava/lang/String;

    .line 836
    if-eqz v0, :cond_1

    if-nez p0, :cond_2

    .line 840
    :cond_1
    :goto_0
    return-void

    .line 837
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    .line 838
    if-eqz v0, :cond_1

    .line 839
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    if-eqz v1, :cond_3

    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    if-eqz v1, :cond_3

    invoke-static {v0}, Lcom/mrkeyboard/app/MrGestureInput;->showAlternatives(Lcom/mrkeyboard/app/LatinIME;)V

    goto :goto_0

    :cond_3
    invoke-virtual {v0, v3}, Lcom/mrkeyboard/app/LatinIME;->mrStrip(Ljava/util/List;)V

    goto :goto_0
.end method

.method private static previewMove(Lcom/mrkeyboard/app/LatinKeyboardView;)V
    .locals 4

    .prologue
    .line 782
    :try_start_0
    sget-wide v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewDue:J

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    sub-long/2addr v0, v2

    .line 783
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gtz v2, :cond_1

    .line 784
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->previewNow(Lcom/mrkeyboard/app/LatinKeyboardView;)V

    .line 792
    :cond_0
    :goto_0
    return-void

    .line 785
    :cond_1
    sget-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewPosted:Z

    if-nez v2, :cond_0

    .line 786
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sHandler:Landroid/os/Handler;

    if-nez v2, :cond_2

    new-instance v2, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sHandler:Landroid/os/Handler;

    .line 787
    :cond_2
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sHandler:Landroid/os/Handler;

    sget-object v3, Lcom/mrkeyboard/app/MrGestureInput;->PREVIEW:Ljava/lang/Runnable;

    invoke-virtual {v2, v3, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    move-result v0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewPosted:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 789
    :catch_0
    move-exception v0

    .line 790
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    goto :goto_0
.end method

.method private static previewNow(Lcom/mrkeyboard/app/LatinKeyboardView;)V
    .locals 14

    .prologue
    const/4 v13, 0x0

    const/4 v12, 0x1

    .line 795
    sget v5, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    .line 796
    sput v5, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewCount:I

    .line 797
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sFull:Z

    if-nez v0, :cond_0

    const/4 v0, 0x2

    if-lt v5, v0, :cond_0

    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sHeight:F

    const/4 v1, 0x0

    cmpg-float v0, v0, v1

    if-gtz v0, :cond_1

    .line 821
    :cond_0
    :goto_0
    return-void

    .line 798
    :cond_1
    sget-object v1, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    .line 799
    if-eqz v1, :cond_0

    .line 800
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPrevRead:Z

    if-nez v0, :cond_2

    .line 803
    sput-boolean v12, Lcom/mrkeyboard/app/MrGestureInput;->sPrevRead:Z

    .line 804
    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v0

    .line 805
    if-eqz v0, :cond_4

    const/16 v2, 0x60

    invoke-interface {v0, v2, v13}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->lastWord(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    :goto_1
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPrevWord:Ljava/lang/String;

    .line 807
    :cond_2
    invoke-static {v5}, Lcom/mrkeyboard/app/MrGestureInput;->frame(I)V

    .line 808
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v8

    .line 809
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sEngine:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sFx:[F

    sget-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sFy:[F

    sget-object v4, Lcom/mrkeyboard/app/MrGestureInput;->sPt:[I

    sget-object v6, Lcom/mrkeyboard/app/MrGestureInput;->sPrevWord:Ljava/lang/String;

    sget-object v7, Lcom/mrkeyboard/app/MrGestureInput;->sResult:Lcom/mrkeyboard/app/MrGesture$Result;

    invoke-interface/range {v0 .. v7}, Lcom/mrkeyboard/app/MrGestureInput$Engine;->decode(Lcom/mrkeyboard/app/LatinIME;[F[F[IILjava/lang/String;Lcom/mrkeyboard/app/MrGesture$Result;)I

    move-result v0

    .line 810
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v2

    sub-long/2addr v2, v8

    .line 811
    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrGestureInput;->statPreview(J)V

    .line 812
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v4

    const-wide/16 v6, 0x78

    const-wide/16 v8, 0x6

    const-wide/32 v10, 0xf4240

    div-long/2addr v2, v10

    mul-long/2addr v2, v8

    invoke-static {v6, v7, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v2

    add-long/2addr v2, v4

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewDue:J

    .line 813
    if-lez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sResult:Lcom/mrkeyboard/app/MrGesture$Result;

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewBest:[Ljava/lang/String;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrGestureInput;->candidates(Lcom/mrkeyboard/app/MrGesture$Result;[Ljava/lang/String;)I

    move-result v0

    if-lez v0, :cond_0

    .line 814
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewBest:[Ljava/lang/String;

    aget-object v0, v0, v13

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardView;->getShiftState()I

    move-result v2

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrGestureInput;->withCase(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .line 815
    sget-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewShown:Z

    if-eqz v2, :cond_3

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewWord:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 816
    :cond_3
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v12}, Ljava/util/ArrayList;-><init>(I)V

    .line 817
    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 818
    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/LatinIME;->mrStrip(Ljava/util/List;)V

    .line 819
    sput-boolean v12, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewShown:Z

    .line 820
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewWord:Ljava/lang/String;

    goto/16 :goto_0

    .line 805
    :cond_4
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private static previewStart()V
    .locals 6

    .prologue
    const/4 v0, 0x0

    const/4 v1, 0x0

    .line 752
    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewShown:Z

    .line 753
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewWord:Ljava/lang/String;

    .line 754
    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewCount:I

    .line 755
    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewPosted:Z

    .line 756
    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sPrevRead:Z

    .line 757
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPrevWord:Ljava/lang/String;

    .line 758
    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    .line 760
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    .line 761
    if-nez v0, :cond_0

    .line 768
    :goto_0
    return-void

    .line 762
    :cond_0
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sEngine:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    invoke-interface {v2, v0}, Lcom/mrkeyboard/app/MrGestureInput$Engine;->prepare(Lcom/mrkeyboard/app/LatinIME;)V

    .line 763
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    const-wide/16 v4, 0x78

    add-long/2addr v2, v4

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewDue:J

    .line 764
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreview:Z

    if-eqz v0, :cond_1

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->stripInView()Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    :goto_1
    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 765
    :catch_0
    move-exception v0

    .line 766
    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    goto :goto_0

    :cond_1
    move v0, v1

    .line 764
    goto :goto_1
.end method

.method static declared-synchronized reload(Landroid/content/Context;)V
    .locals 7

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 199
    const-class v4, Lcom/mrkeyboard/app/MrGestureInput;

    monitor-enter v4

    if-nez p0, :cond_0

    :try_start_0
    sget-object p0, Lcom/mrkeyboard/app/MrGestureInput;->sApp:Landroid/content/Context;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 200
    :cond_0
    if-nez p0, :cond_1

    .line 211
    :goto_0
    monitor-exit v4

    return-void

    .line 201
    :cond_1
    :try_start_1
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v5

    .line 202
    if-eqz v5, :cond_4

    const-string v2, "pref_gesture_typing"

    const/4 v3, 0x0

    invoke-interface {v5, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_4

    move v3, v0

    .line 203
    :goto_1
    if-eqz v5, :cond_2

    const-string v2, "pref_gesture_trail"

    const/4 v6, 0x1

    invoke-interface {v5, v2, v6}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_5

    :cond_2
    move v2, v0

    :goto_2
    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sTrail:Z

    .line 204
    if-eqz v5, :cond_3

    const-string v2, "pref_gesture_preview"

    const/4 v6, 0x1

    invoke-interface {v5, v2, v6}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_6

    :cond_3
    move v2, v0

    :goto_3
    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreview:Z

    .line 205
    if-eqz v3, :cond_7

    const-string v2, "gesture"

    const-string v3, "encoder.bin"

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacks;->modelFile(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    .line 206
    :goto_4
    if-eqz v2, :cond_8

    :goto_5
    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sOn:Z

    .line 207
    invoke-static {v2}, Lcom/mrkeyboard/app/MrGesture;->use(Ljava/io/File;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 208
    :catch_0
    move-exception v0

    .line 209
    const/4 v0, 0x0

    :try_start_2
    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sOn:Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 199
    :catchall_0
    move-exception v0

    monitor-exit v4

    throw v0

    :cond_4
    move v3, v1

    .line 202
    goto :goto_1

    :cond_5
    move v2, v1

    .line 203
    goto :goto_2

    :cond_6
    move v2, v1

    .line 204
    goto :goto_3

    .line 205
    :cond_7
    const/4 v2, 0x0

    goto :goto_4

    :cond_8
    move v0, v1

    .line 206
    goto :goto_5
.end method

.method static declared-synchronized resetForTest()V
    .locals 4

    .prologue
    .line 1035
    const-class v1, Lcom/mrkeyboard/app/MrGestureInput;

    monitor-enter v1

    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    .line 1036
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sOn:Z

    .line 1037
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrail:Z

    .line 1038
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreview:Z

    .line 1039
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPrevRead:Z

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewPosted:Z

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewShown:Z

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    .line 1040
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPrevWord:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewWord:Ljava/lang/String;

    .line 1041
    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewDue:J

    .line 1042
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewCount:I

    .line 1043
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sHandler:Landroid/os/Handler;

    .line 1044
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->REAL:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sEngine:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    .line 1045
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sApp:Landroid/content/Context;

    .line 1046
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .line 1047
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutOf:Ljava/lang/ref/WeakReference;

    .line 1048
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutOk:Z

    .line 1049
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sKeyCount:I

    .line 1050
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    .line 1051
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 1052
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->forget()V

    .line 1053
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sLastSpace:Z

    .line 1054
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviews:I

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sStatCount:I

    .line 1055
    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviewMax:J

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviewSum:J

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatMax:J

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatSum:J

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatLast:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1056
    monitor-exit v1

    return-void

    .line 1035
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private static showAlternatives(Lcom/mrkeyboard/app/LatinIME;)V
    .locals 4

    .prologue
    const/4 v0, 0x2

    .line 900
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    .line 901
    new-instance v2, Ljava/util/ArrayList;

    const/4 v3, 0x3

    invoke-direct {v2, v3}, Ljava/util/ArrayList;-><init>(I)V

    .line 902
    array-length v3, v1

    if-lt v3, v0, :cond_0

    const/4 v3, 0x1

    aget-object v3, v1, v3

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 903
    :cond_0
    const/4 v3, 0x0

    aget-object v3, v1, v3

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 904
    :goto_0
    array-length v3, v1

    if-ge v0, v3, :cond_1

    aget-object v3, v1, v0

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 905
    :cond_1
    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/LatinIME;->mrStrip(Ljava/util/List;)V

    .line 906
    return-void
.end method

.method private static declared-synchronized stat(J)V
    .locals 4

    .prologue
    .line 1012
    const-class v1, Lcom/mrkeyboard/app/MrGestureInput;

    monitor-enter v1

    :try_start_0
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sStatCount:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sStatCount:I

    .line 1013
    sput-wide p0, Lcom/mrkeyboard/app/MrGestureInput;->sStatLast:J

    .line 1014
    sget-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatSum:J

    add-long/2addr v2, p0

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatSum:J

    .line 1015
    sget-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatMax:J

    cmp-long v0, p0, v2

    if-lez v0, :cond_0

    sput-wide p0, Lcom/mrkeyboard/app/MrGestureInput;->sStatMax:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1016
    :cond_0
    monitor-exit v1

    return-void

    .line 1012
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private static declared-synchronized statPreview(J)V
    .locals 4

    .prologue
    .line 1019
    const-class v1, Lcom/mrkeyboard/app/MrGestureInput;

    monitor-enter v1

    :try_start_0
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviews:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviews:I

    .line 1020
    sget-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviewSum:J

    add-long/2addr v2, p0

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviewSum:J

    .line 1021
    sget-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviewMax:J

    cmp-long v0, p0, v2

    if-lez v0, :cond_0

    sput-wide p0, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviewMax:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1022
    :cond_0
    monitor-exit v1

    return-void

    .line 1019
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static stateForTest()I
    .locals 1

    .prologue
    .line 1065
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    return v0
.end method

.method static declared-synchronized stats()[J
    .locals 6

    .prologue
    .line 1030
    const-class v1, Lcom/mrkeyboard/app/MrGestureInput;

    monitor-enter v1

    const/4 v0, 0x7

    :try_start_0
    new-array v0, v0, [J

    const/4 v2, 0x0

    sget v3, Lcom/mrkeyboard/app/MrGestureInput;->sStatCount:I

    int-to-long v4, v3

    aput-wide v4, v0, v2

    const/4 v2, 0x1

    sget-wide v4, Lcom/mrkeyboard/app/MrGestureInput;->sStatLast:J

    aput-wide v4, v0, v2

    const/4 v2, 0x2

    sget-wide v4, Lcom/mrkeyboard/app/MrGestureInput;->sStatSum:J

    aput-wide v4, v0, v2

    const/4 v2, 0x3

    sget-wide v4, Lcom/mrkeyboard/app/MrGestureInput;->sStatMax:J

    aput-wide v4, v0, v2

    const/4 v2, 0x4

    sget v3, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviews:I

    int-to-long v4, v3

    aput-wide v4, v0, v2

    const/4 v2, 0x5

    sget-wide v4, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviewSum:J

    aput-wide v4, v0, v2

    const/4 v2, 0x6

    sget-wide v4, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviewMax:J

    aput-wide v4, v0, v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private static stripInView()Z
    .locals 1

    .prologue
    .line 775
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarMain:Landroid/view/View;

    .line 776
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static styled()Z
    .locals 2

    .prologue
    .line 340
    const-string v0, "a"

    const-string v1, "a"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrFonts;->styleLabel(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static toIdle()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 296
    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    .line 297
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sView:Lcom/mrkeyboard/app/LatinKeyboardView;

    .line 298
    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    .line 299
    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sFull:Z

    .line 300
    return-void
.end method

.method private static touch(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;I)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    const/4 v1, 0x1

    .line 263
    sget v2, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    if-eqz v2, :cond_2

    .line 264
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-eq p0, v2, :cond_5

    .line 266
    if-nez p2, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->isMain(Lcom/mrkeyboard/app/LatinKeyboardView;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 286
    :cond_0
    :goto_0
    return v0

    .line 267
    :cond_1
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGestureInput;->previewEnd(Z)V

    .line 268
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    .line 275
    :cond_2
    :goto_1
    sget v2, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    packed-switch v2, :pswitch_data_0

    .line 285
    if-eq p2, v1, :cond_3

    const/4 v0, 0x3

    if-ne p2, v0, :cond_4

    :cond_3
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    :cond_4
    move v0, v1

    .line 286
    goto :goto_0

    .line 269
    :cond_5
    if-nez p2, :cond_2

    .line 270
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->trailEnd(Lcom/mrkeyboard/app/LatinKeyboardView;)V

    .line 271
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGestureInput;->previewEnd(Z)V

    .line 272
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    goto :goto_1

    .line 277
    :pswitch_0
    if-nez p2, :cond_0

    sget-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sOn:Z

    if-eqz v1, :cond_0

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrGestureInput;->begin(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;)V

    goto :goto_0

    .line 280
    :pswitch_1
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrGestureInput;->track(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;I)Z

    move-result v0

    goto :goto_0

    .line 282
    :pswitch_2
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrGestureInput;->gesture(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;I)V

    move v0, v1

    .line 283
    goto :goto_0

    .line 275
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method private static track(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;I)Z
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 354
    if-ne p2, v4, :cond_0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v2

    if-ne v2, v1, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardView;->popupKeyboardIsShowing()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 355
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    .line 377
    :cond_1
    :goto_0
    return v0

    .line 358
    :cond_2
    sget v2, Lcom/mrkeyboard/app/MrGestureInput;->sPointer:I

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->findPointerIndex(I)I

    move-result v2

    .line 359
    if-gez v2, :cond_3

    .line 360
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    goto :goto_0

    .line 363
    :cond_3
    sget v3, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    .line 364
    invoke-static {p1, v2}, Lcom/mrkeyboard/app/MrGestureInput;->addAll(Landroid/view/MotionEvent;I)V

    .line 365
    invoke-static {v3}, Lcom/mrkeyboard/app/MrGestureInput;->farEnough(I)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 366
    sput v4, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    .line 367
    invoke-static {p1}, Landroid/view/MotionEvent;->obtain(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;

    move-result-object v2

    .line 369
    const/4 v0, 0x3

    :try_start_0
    invoke-virtual {v2, v0}, Landroid/view/MotionEvent;->setAction(I)V

    .line 371
    const/4 v0, 0x0

    invoke-virtual {p0, v2, v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->onTouchEvent(Landroid/view/MotionEvent;Z)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 373
    invoke-virtual {v2}, Landroid/view/MotionEvent;->recycle()V

    .line 375
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->trailStart(Lcom/mrkeyboard/app/LatinKeyboardView;)V

    .line 376
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->previewStart()V

    move v0, v1

    .line 377
    goto :goto_0

    .line 373
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/view/MotionEvent;->recycle()V

    .line 374
    throw v0
.end method

.method private static trailEnd(Lcom/mrkeyboard/app/LatinKeyboardView;)V
    .locals 5

    .prologue
    .line 637
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    if-nez v0, :cond_1

    .line 642
    :cond_0
    :goto_0
    return-void

    .line 638
    :cond_1
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    .line 639
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    if-eqz v0, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    invoke-virtual {v0}, Landroid/graphics/Path;->reset()V

    .line 640
    :cond_2
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailWidth:F

    float-to-int v0, v0

    add-int/lit8 v0, v0, 0x2

    .line 641
    if-eqz p0, :cond_0

    sget v1, Lcom/mrkeyboard/app/MrGestureInput;->sBoundL:F

    float-to-int v1, v1

    sub-int/2addr v1, v0

    sget v2, Lcom/mrkeyboard/app/MrGestureInput;->sBoundT:F

    float-to-int v2, v2

    sub-int/2addr v2, v0

    sget v3, Lcom/mrkeyboard/app/MrGestureInput;->sBoundR:F

    float-to-int v3, v3

    add-int/2addr v3, v0

    sget v4, Lcom/mrkeyboard/app/MrGestureInput;->sBoundB:F

    float-to-int v4, v4

    add-int/2addr v0, v4

    invoke-virtual {p0, v1, v2, v3, v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->invalidate(IIII)V

    goto :goto_0
.end method

.method private static trailGrow(Lcom/mrkeyboard/app/LatinKeyboardView;I)V
    .locals 7

    .prologue
    const/4 v0, 0x1

    .line 616
    sget-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    if-nez v1, :cond_1

    .line 634
    :cond_0
    :goto_0
    return-void

    .line 617
    :cond_1
    if-ge p1, v0, :cond_2

    move p1, v0

    .line 618
    :cond_2
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    if-ge p1, v0, :cond_0

    .line 619
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    add-int/lit8 v1, p1, -0x1

    aget v1, v0, v1

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    add-int/lit8 v2, p1, -0x1

    aget v0, v0, v2

    move v2, v1

    move v3, v1

    move v1, v0

    .line 620
    :goto_1
    sget v4, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    if-ge p1, v4, :cond_7

    .line 621
    sget-object v4, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    aget v5, v4, p1

    sget-object v4, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    aget v4, v4, p1

    .line 622
    sget-object v6, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    invoke-virtual {v6, v5, v4}, Landroid/graphics/Path;->lineTo(FF)V

    .line 623
    cmpg-float v6, v5, v3

    if-gez v6, :cond_3

    move v3, v5

    .line 624
    :cond_3
    cmpl-float v6, v5, v2

    if-lez v6, :cond_4

    move v2, v5

    .line 625
    :cond_4
    cmpg-float v5, v4, v1

    if-gez v5, :cond_5

    move v1, v4

    .line 626
    :cond_5
    cmpl-float v5, v4, v0

    if-lez v5, :cond_6

    move v0, v4

    .line 620
    :cond_6
    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    .line 628
    :cond_7
    sget v4, Lcom/mrkeyboard/app/MrGestureInput;->sBoundL:F

    cmpg-float v4, v3, v4

    if-gez v4, :cond_8

    sput v3, Lcom/mrkeyboard/app/MrGestureInput;->sBoundL:F

    .line 629
    :cond_8
    sget v4, Lcom/mrkeyboard/app/MrGestureInput;->sBoundR:F

    cmpl-float v4, v2, v4

    if-lez v4, :cond_9

    sput v2, Lcom/mrkeyboard/app/MrGestureInput;->sBoundR:F

    .line 630
    :cond_9
    sget v4, Lcom/mrkeyboard/app/MrGestureInput;->sBoundT:F

    cmpg-float v4, v1, v4

    if-gez v4, :cond_a

    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sBoundT:F

    .line 631
    :cond_a
    sget v4, Lcom/mrkeyboard/app/MrGestureInput;->sBoundB:F

    cmpl-float v4, v0, v4

    if-lez v4, :cond_b

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sBoundB:F

    .line 632
    :cond_b
    sget v4, Lcom/mrkeyboard/app/MrGestureInput;->sTrailWidth:F

    float-to-int v4, v4

    add-int/lit8 v4, v4, 0x2

    .line 633
    float-to-int v3, v3

    sub-int/2addr v3, v4

    float-to-int v1, v1

    sub-int/2addr v1, v4

    float-to-int v2, v2

    add-int/2addr v2, v4

    float-to-int v0, v0

    add-int/2addr v0, v4

    invoke-virtual {p0, v3, v1, v2, v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->invalidate(IIII)V

    goto :goto_0
.end method

.method private static trailStart(Lcom/mrkeyboard/app/LatinKeyboardView;)V
    .locals 5

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 595
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrail:Z

    if-eqz v0, :cond_0

    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    if-lez v0, :cond_0

    move v0, v1

    :goto_0
    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    .line 596
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    if-nez v0, :cond_1

    .line 612
    :goto_1
    return-void

    :cond_0
    move v0, v2

    .line 595
    goto :goto_0

    .line 597
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    if-nez v0, :cond_2

    .line 598
    new-instance v0, Landroid/graphics/Path;

    invoke-direct {v0}, Landroid/graphics/Path;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    .line 599
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPaint:Landroid/graphics/Paint;

    .line 600
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 601
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 602
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Join;->ROUND:Landroid/graphics/Paint$Join;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setStrokeJoin(Landroid/graphics/Paint$Join;)V

    .line 604
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->accent()I

    move-result v0

    .line 605
    sget-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sPaint:Landroid/graphics/Paint;

    const/high16 v4, -0x34000000    # -3.3554432E7f

    if-eqz v0, :cond_3

    :goto_2
    or-int/2addr v0, v4

    invoke-virtual {v3, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 606
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPaint:Landroid/graphics/Paint;

    sget v3, Lcom/mrkeyboard/app/MrGestureInput;->sTrailWidth:F

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 607
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    invoke-virtual {v0}, Landroid/graphics/Path;->reset()V

    .line 608
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    sget-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    aget v3, v3, v2

    sget-object v4, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    aget v4, v4, v2

    invoke-virtual {v0, v3, v4}, Landroid/graphics/Path;->moveTo(FF)V

    .line 609
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    aget v0, v0, v2

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sBoundR:F

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sBoundL:F

    .line 610
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    aget v0, v0, v2

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sBoundB:F

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sBoundT:F

    .line 611
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrGestureInput;->trailGrow(Lcom/mrkeyboard/app/LatinKeyboardView;I)V

    goto :goto_1

    .line 605
    :cond_3
    const v0, 0x40c4ff

    goto :goto_2
.end method

.method static withCase(Ljava/lang/String;I)Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 844
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 850
    :cond_0
    :goto_0
    return-object p0

    .line 845
    :cond_1
    const/4 v0, 0x2

    if-eq p1, v0, :cond_2

    const/4 v0, 0x4

    if-ne p1, v0, :cond_3

    :cond_2
    invoke-virtual {p0}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    .line 846
    :cond_3
    if-eq p1, v2, :cond_4

    const/4 v0, 0x3

    if-ne p1, v0, :cond_0

    .line 847
    :cond_4
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->toUpperCase(C)C

    move-result v1

    .line 848
    if-eq v1, v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    goto :goto_0
.end method

.method private static write(Lcom/mrkeyboard/app/LatinIME;Landroid/view/inputmethod/InputConnection;Z[Ljava/lang/String;I)V
    .locals 5

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 876
    aget-object v0, p3, v3

    .line 877
    sput-boolean v4, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 878
    invoke-interface {p1}, Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z

    .line 880
    if-eqz p2, :cond_0

    :try_start_0
    const-string v1, " "

    const/4 v2, 0x1

    invoke-interface {p1, v1, v2}, Landroid/view/inputmethod/InputConnection;->commitText(Ljava/lang/CharSequence;I)Z

    .line 881
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->NONE:Ljava/util/List;

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/LatinIME;->mrStrip(Ljava/util/List;)V

    .line 882
    const/4 v1, -0x1

    invoke-virtual {p0, v1, v0}, Lcom/mrkeyboard/app/LatinIME;->pickSuggestionManually(ILjava/lang/CharSequence;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 884
    sput-boolean v3, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 885
    invoke-interface {p1}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 887
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    .line 888
    sput-boolean p2, Lcom/mrkeyboard/app/MrGestureInput;->sLastSpace:Z

    .line 889
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sLastEditor:Landroid/view/inputmethod/EditorInfo;

    .line 890
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    .line 891
    if-le p4, v4, :cond_1

    .line 892
    add-int/lit8 v0, p4, -0x1

    new-array v0, v0, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    .line 893
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    add-int/lit8 v1, p4, -0x1

    invoke-static {p3, v4, v0, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 894
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->showAlternatives(Lcom/mrkeyboard/app/LatinIME;)V

    .line 896
    :cond_1
    return-void

    .line 884
    :catchall_0
    move-exception v0

    sput-boolean v3, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 885
    invoke-interface {p1}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 886
    throw v0
.end method

.method private static written(Lcom/mrkeyboard/app/LatinIME;Landroid/view/inputmethod/InputConnection;)I
    .locals 6

    .prologue
    const/4 v1, -0x1

    .line 919
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    .line 920
    if-eqz v2, :cond_0

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v0

    sget-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sLastEditor:Landroid/view/inputmethod/EditorInfo;

    if-eq v0, v3, :cond_1

    .line 926
    :cond_0
    :goto_0
    return v1

    .line 921
    :cond_1
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v0

    .line 922
    add-int/lit8 v3, v0, 0x1

    const/4 v4, 0x0

    invoke-interface {p1, v3, v4}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v3

    .line 923
    if-eqz v3, :cond_0

    .line 924
    invoke-interface {v3}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    .line 925
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    add-int/lit8 v5, v0, 0x1

    if-ne v4, v5, :cond_2

    invoke-virtual {v3, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v5, 0x20

    if-ne v4, v5, :cond_2

    invoke-virtual {v3, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    add-int/lit8 v1, v0, 0x1

    goto :goto_0

    .line 926
    :cond_2
    invoke-virtual {v3, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    :goto_1
    move v1, v0

    goto :goto_0

    :cond_3
    move v0, v1

    goto :goto_1
.end method
