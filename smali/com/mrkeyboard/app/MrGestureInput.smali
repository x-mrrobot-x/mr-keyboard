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

.field private static final GLUE:Ljava/lang/String; = ".,!?);:"

.field private static final IDLE:I = 0x0

.field private static final KEYCODE_DELETE:I = -0x5

.field static final LONG_PRESS_MIN:I = 0xfa

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

.field private static sTapEditor:Landroid/view/inputmethod/EditorInfo;

.field private static sTapWord:Ljava/lang/String;

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

    .line 123
    new-instance v0, Lcom/mrkeyboard/app/MrGestureInput$1;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrGestureInput$1;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->REAL:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    .line 156
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->REAL:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sEngine:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    .line 163
    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sTrail:Z

    .line 165
    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreview:Z

    .line 232
    sput v3, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    .line 242
    new-instance v0, Lcom/mrkeyboard/app/MrGesture$Result;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrGesture$Result;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sResult:Lcom/mrkeyboard/app/MrGesture$Result;

    .line 502
    new-array v0, v1, [I

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sKx:[I

    new-array v0, v1, [I

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sKy:[I

    .line 503
    new-array v0, v1, [I

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sKw:[I

    new-array v0, v1, [I

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sKh:[I

    .line 504
    new-array v0, v1, [I

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sKe:[I

    .line 505
    new-array v0, v1, [C

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sKc:[C

    .line 669
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, v3}, Ljava/util/ArrayList;-><init>(I)V

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->NONE:Ljava/util/List;

    .line 752
    new-array v0, v2, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewBest:[Ljava/lang/String;

    .line 756
    new-instance v0, Lcom/mrkeyboard/app/MrGestureInput$3;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrGestureInput$3;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->PREVIEW:Ljava/lang/Runnable;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 77
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$002(Z)Z
    .locals 0

    .prologue
    .line 76
    sput-boolean p0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewPosted:Z

    return p0
.end method

.method static synthetic access$100()I
    .locals 1

    .prologue
    .line 76
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    return v0
.end method

.method static synthetic access$200()Z
    .locals 1

    .prologue
    .line 76
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    return v0
.end method

.method static synthetic access$202(Z)Z
    .locals 0

    .prologue
    .line 76
    sput-boolean p0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    return p0
.end method

.method static synthetic access$300()Lcom/mrkeyboard/app/LatinKeyboardView;
    .locals 1

    .prologue
    .line 76
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sView:Lcom/mrkeyboard/app/LatinKeyboardView;

    return-object v0
.end method

.method static synthetic access$400()I
    .locals 1

    .prologue
    .line 76
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    return v0
.end method

.method static synthetic access$500()I
    .locals 1

    .prologue
    .line 76
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewCount:I

    return v0
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/LatinKeyboardView;)V
    .locals 0

    .prologue
    .line 76
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->previewNow(Lcom/mrkeyboard/app/LatinKeyboardView;)V

    return-void
.end method

.method private static add(FFJ)V
    .locals 4

    .prologue
    .line 456
    sget-wide v0, Lcom/mrkeyboard/app/MrGestureInput;->sDownTime:J

    sub-long v0, p2, v0

    long-to-int v0, v0

    .line 457
    sget v1, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    .line 458
    if-lez v1, :cond_1

    .line 459
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPt:[I

    add-int/lit8 v3, v1, -0x1

    aget v2, v2, v3

    if-ge v0, v2, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPt:[I

    add-int/lit8 v2, v1, -0x1

    aget v0, v0, v2

    .line 460
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

    .line 470
    :goto_0
    return-void

    .line 462
    :cond_1
    const/16 v2, 0x1000

    if-lt v1, v2, :cond_2

    .line 463
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sFull:Z

    goto :goto_0

    .line 466
    :cond_2
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    aput p0, v2, v1

    .line 467
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    aput p1, v2, v1

    .line 468
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPt:[I

    aput v0, v2, v1

    .line 469
    add-int/lit8 v0, v1, 0x1

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    goto :goto_0
.end method

.method private static addAll(Landroid/view/MotionEvent;I)V
    .locals 6

    .prologue
    .line 450
    invoke-virtual {p0}, Landroid/view/MotionEvent;->getHistorySize()I

    move-result v1

    .line 451
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

    .line 452
    :cond_0
    invoke-virtual {p0, p1}, Landroid/view/MotionEvent;->getX(I)F

    move-result v0

    invoke-virtual {p0, p1}, Landroid/view/MotionEvent;->getY(I)F

    move-result v1

    invoke-virtual {p0}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v2

    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrGestureInput;->add(FFJ)V

    .line 453
    return-void
.end method

.method public static afterTap(Lcom/mrkeyboard/app/LatinIME;Ljava/lang/CharSequence;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 1057
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    if-eqz v0, :cond_0

    .line 1065
    :goto_0
    return-void

    .line 1059
    :cond_0
    if-eqz p1, :cond_1

    :try_start_0
    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-nez v0, :cond_2

    :cond_1
    move-object v0, v1

    :goto_1
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sTapWord:Ljava/lang/String;

    .line 1060
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sTapWord:Ljava/lang/String;

    if-nez v0, :cond_3

    move-object v0, v1

    :goto_2
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sTapEditor:Landroid/view/inputmethod/EditorInfo;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1061
    :catch_0
    move-exception v0

    .line 1062
    sput-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sTapWord:Ljava/lang/String;

    .line 1063
    sput-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sTapEditor:Landroid/view/inputmethod/EditorInfo;

    goto :goto_0

    .line 1059
    :cond_2
    :try_start_1
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 1060
    :cond_3
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v0

    goto :goto_2
.end method

.method private static begin(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;)V
    .locals 10

    .prologue
    const/4 v9, 0x1

    const/16 v8, 0x1000

    const/4 v7, 0x0

    .line 316
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v0

    if-eq v0, v9, :cond_1

    .line 345
    :cond_0
    :goto_0
    return-void

    .line 317
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sEngine:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    .line 318
    invoke-interface {v0}, Lcom/mrkeyboard/app/MrGestureInput$Engine;->ready()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 319
    sget-object v1, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    .line 320
    if-eqz v1, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->isMain(Lcom/mrkeyboard/app/LatinKeyboardView;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 321
    invoke-static {}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInstance()Lcom/mrkeyboard/app/KeyboardSwitcher;

    move-result-object v2

    .line 322
    invoke-virtual {v2}, Lcom/mrkeyboard/app/KeyboardSwitcher;->isAlphabetMode()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v2}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getSheet()I

    move-result v2

    if-nez v2, :cond_0

    .line 323
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardView;->popupKeyboardIsShowing()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->styled()Z

    move-result v2

    if-nez v2, :cond_0

    .line 324
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardView;->getKeyboard()Lcom/mrkeyboard/app/Keyboard;

    move-result-object v2

    .line 325
    if-eqz v2, :cond_0

    invoke-static {v2}, Lcom/mrkeyboard/app/MrGestureInput;->layoutFor(Lcom/mrkeyboard/app/Keyboard;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 326
    invoke-virtual {p1, v7}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    invoke-virtual {p1, v7}, Landroid/view/MotionEvent;->getY(I)F

    move-result v4

    .line 327
    float-to-int v5, v3

    float-to-int v6, v4

    invoke-static {v5, v6}, Lcom/mrkeyboard/app/MrGestureInput;->letterAt(II)I

    move-result v5

    .line 328
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

    .line 329
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    if-nez v0, :cond_2

    .line 330
    new-array v0, v8, [F

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    .line 331
    new-array v0, v8, [F

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    .line 332
    new-array v0, v8, [I

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPt:[I

    .line 334
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->density(Lcom/mrkeyboard/app/LatinKeyboardView;)F

    move-result v0

    .line 335
    const v1, 0x3f333333    # 0.7f

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sKw:[I

    aget v2, v2, v5

    int-to-float v2, v2

    mul-float/2addr v1, v2

    const/high16 v2, 0x41b00000    # 22.0f

    mul-float/2addr v2, v0

    invoke-static {v1, v2}, Ljava/lang/Math;->max(FF)F

    move-result v1

    .line 336
    mul-float/2addr v1, v1

    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sStart2:F

    .line 337
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

    .line 338
    sput-object p0, Lcom/mrkeyboard/app/MrGestureInput;->sView:Lcom/mrkeyboard/app/LatinKeyboardView;

    .line 339
    invoke-virtual {p1, v7}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sPointer:I

    .line 340
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v0

    sput-wide v0, Lcom/mrkeyboard/app/MrGestureInput;->sDownTime:J

    .line 341
    sput v7, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    .line 342
    sput-boolean v7, Lcom/mrkeyboard/app/MrGestureInput;->sFull:Z

    .line 343
    sget-wide v0, Lcom/mrkeyboard/app/MrGestureInput;->sDownTime:J

    invoke-static {v3, v4, v0, v1}, Lcom/mrkeyboard/app/MrGestureInput;->add(FFJ)V

    .line 344
    sput v9, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    goto/16 :goto_0
.end method

.method private static buildLayout(Lcom/mrkeyboard/app/Keyboard;I)Z
    .locals 11

    .prologue
    const/high16 v10, 0x40000000    # 2.0f

    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 526
    sput v3, Lcom/mrkeyboard/app/MrGestureInput;->sKeyCount:I

    .line 527
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Keyboard;->getKeys()Ljava/util/List;

    move-result-object v7

    .line 529
    invoke-interface {v7}, Ljava/util/List;->size()I

    move-result v8

    move v6, v3

    move v4, v3

    :goto_0
    if-ge v6, v8, :cond_7

    .line 530
    invoke-interface {v7, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/Keyboard$Key;

    .line 531
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

    .line 529
    :goto_1
    add-int/lit8 v1, v6, 0x1

    move v6, v1

    move v4, v0

    goto :goto_0

    .line 532
    :cond_0
    iget-object v1, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    aget v1, v1, v3

    .line 533
    if-lez v1, :cond_f

    const v5, 0xffff

    if-gt v1, v5, :cond_f

    invoke-static {v1}, Ljava/lang/Character;->isLetter(I)Z

    move-result v5

    if-nez v5, :cond_1

    move v0, v4

    goto :goto_1

    .line 534
    :cond_1
    int-to-char v1, v1

    invoke-static {v1}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v9

    move v5, v3

    move v1, v3

    .line 536
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

    .line 537
    :cond_3
    if-eqz v1, :cond_4

    move v0, v4

    goto :goto_1

    .line 538
    :cond_4
    const/16 v1, 0x40

    if-ne v4, v1, :cond_6

    .line 572
    :cond_5
    :goto_4
    return v3

    .line 539
    :cond_6
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKc:[C

    aput-char v9, v1, v4

    .line 540
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKx:[I

    iget v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->x:I

    aput v5, v1, v4

    .line 541
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKy:[I

    iget v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->y:I

    aput v5, v1, v4

    .line 542
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKw:[I

    iget v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->width:I

    aput v5, v1, v4

    .line 543
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKh:[I

    iget v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->height:I

    aput v5, v1, v4

    .line 544
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKe:[I

    iget v0, v0, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    aput v0, v1, v4

    .line 545
    add-int/lit8 v0, v4, 0x1

    goto :goto_1

    .line 547
    :cond_7
    const/4 v0, 0x2

    if-lt v4, v0, :cond_5

    if-lez p1, :cond_5

    .line 549
    new-array v5, v4, [I

    move v0, v3

    .line 550
    :goto_5
    if-ge v0, v4, :cond_8

    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sKy:[I

    aget v1, v1, v0

    aput v1, v5, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_5

    .line 551
    :cond_8
    invoke-static {v5}, Ljava/util/Arrays;->sort([I)V

    move v1, v2

    move v0, v2

    .line 553
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

    .line 554
    :cond_a
    aget v6, v5, v3

    add-int/lit8 v1, v4, -0x1

    aget v7, v5, v1

    move v5, v3

    move v1, v3

    .line 556
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

    .line 557
    :cond_c
    if-le v0, v2, :cond_d

    sub-int v5, v7, v6

    int-to-float v5, v5

    add-int/lit8 v7, v0, -0x1

    int-to-float v7, v7

    div-float/2addr v5, v7

    .line 558
    :goto_8
    const/4 v7, 0x0

    cmpg-float v7, v5, v7

    if-lez v7, :cond_5

    .line 559
    int-to-float v6, v6

    int-to-float v1, v1

    sub-float v1, v5, v1

    div-float/2addr v1, v10

    sub-float v1, v6, v1

    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sTop:F

    .line 560
    int-to-float v1, v0

    mul-float/2addr v1, v5

    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sHeight:F

    .line 561
    int-to-float v1, p1

    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sWidth:F

    .line 562
    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sRows:I

    .line 563
    new-array v1, v4, [C

    .line 564
    mul-int/lit8 v0, v4, 0x2

    new-array v5, v0, [F

    move v0, v3

    .line 565
    :goto_9
    if-ge v0, v4, :cond_e

    .line 566
    sget-object v6, Lcom/mrkeyboard/app/MrGestureInput;->sKc:[C

    aget-char v6, v6, v0

    aput-char v6, v1, v0

    .line 567
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

    .line 568
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

    .line 565
    add-int/lit8 v0, v0, 0x1

    goto :goto_9

    .line 557
    :cond_d
    int-to-float v5, v1

    goto :goto_8

    .line 570
    :cond_e
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sEngine:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    invoke-interface {v0, v1, v5}, Lcom/mrkeyboard/app/MrGestureInput$Engine;->layout([C[F)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 571
    sput v4, Lcom/mrkeyboard/app/MrGestureInput;->sKeyCount:I

    move v3, v2

    .line 572
    goto/16 :goto_4

    :cond_f
    move v0, v4

    goto/16 :goto_1
.end method

.method static candidates(Lcom/mrkeyboard/app/MrGesture$Result;[Ljava/lang/String;)I
    .locals 7

    .prologue
    const/4 v2, 0x0

    .line 728
    .line 729
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrGesture$Result;->count()I

    move-result v5

    move v4, v2

    move v0, v2

    .line 730
    :goto_0
    if-ge v4, v5, :cond_2

    array-length v1, p1

    if-ge v0, v1, :cond_2

    .line 731
    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrGesture$Result;->word(I)Ljava/lang/String;

    move-result-object v6

    .line 732
    invoke-static {v6}, Lcom/mrkeyboard/app/MrLearned;->isBlocked(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 730
    :cond_0
    :goto_1
    add-int/lit8 v1, v4, 0x1

    move v4, v1

    goto :goto_0

    .line 733
    :cond_1
    if-nez v0, :cond_3

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrGesture$Result;->logp(I)F

    move-result v1

    const/high16 v3, -0x3e100000    # -30.0f

    cmpg-float v1, v1, v3

    if-gez v1, :cond_3

    move v0, v2

    .line 738
    :cond_2
    return v0

    :cond_3
    move v1, v2

    move v3, v2

    .line 735
    :goto_2
    if-ge v1, v0, :cond_4

    if-nez v3, :cond_4

    aget-object v3, p1, v1

    invoke-static {v3, v6}, Lcom/mrkeyboard/app/MrGesture;->sameIgnoringCase(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 736
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

    .line 357
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 358
    const/4 v2, 0x0

    cmpl-float v2, v0, v2

    if-lez v2, :cond_0

    .line 360
    :goto_0
    return v0

    :cond_0
    move v0, v1

    .line 358
    goto :goto_0

    .line 359
    :catch_0
    move-exception v0

    move v0, v1

    .line 360
    goto :goto_0
.end method

.method public static draw(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/graphics/Canvas;)V
    .locals 2

    .prologue
    .line 659
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-eq p0, v0, :cond_1

    .line 665
    :cond_0
    :goto_0
    return-void

    .line 661
    :cond_1
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 662
    :catch_0
    move-exception v0

    .line 663
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    goto :goto_0
.end method

.method private static editorOk(Lcom/mrkeyboard/app/LatinIME;)Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 474
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v2

    .line 475
    if-eqz v2, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v3

    if-nez v3, :cond_1

    .line 480
    :cond_0
    :goto_0
    return v1

    .line 476
    :cond_1
    iget v2, v2, Landroid/view/inputmethod/EditorInfo;->inputType:I

    .line 477
    and-int/lit8 v3, v2, 0xf

    if-ne v3, v0, :cond_0

    .line 478
    const/high16 v3, 0x80000

    and-int/2addr v3, v2

    if-nez v3, :cond_0

    .line 479
    and-int/lit16 v2, v2, 0xff0

    .line 480
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

    .line 433
    const/4 v2, 0x3

    sput v2, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    .line 436
    if-ltz p2, :cond_0

    :try_start_0
    invoke-static {p1, p2}, Lcom/mrkeyboard/app/MrGestureInput;->addAll(Landroid/view/MotionEvent;I)V

    .line 437
    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->trailEnd(Lcom/mrkeyboard/app/LatinKeyboardView;)V

    .line 438
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->finish(Lcom/mrkeyboard/app/LatinKeyboardView;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-result v2

    .line 441
    if-nez v2, :cond_2

    :goto_0
    :try_start_1
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGestureInput;->previewEnd(Z)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 443
    if-eqz p3, :cond_1

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    .line 446
    :cond_1
    return-void

    :cond_2
    move v1, v0

    .line 441
    goto :goto_0

    .line 443
    :catchall_0
    move-exception v0

    if-eqz p3, :cond_3

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    .line 444
    :cond_3
    throw v0

    .line 440
    :catchall_1
    move-exception v0

    .line 441
    :try_start_2
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGestureInput;->previewEnd(Z)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 443
    if-eqz p3, :cond_4

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    .line 445
    :cond_4
    throw v0

    .line 443
    :catchall_2
    move-exception v0

    if-eqz p3, :cond_5

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    .line 444
    :cond_5
    throw v0
.end method

.method private static farEnough(I)Z
    .locals 7

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 393
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sFull:Z

    if-eqz v0, :cond_0

    move v0, v1

    .line 399
    :goto_0
    return v0

    .line 394
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    aget v3, v0, v2

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    aget v4, v0, v2

    .line 395
    invoke-static {p0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    :goto_1
    sget v5, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    if-ge v0, v5, :cond_2

    .line 396
    sget-object v5, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    aget v5, v5, v0

    sub-float/2addr v5, v3

    sget-object v6, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    aget v6, v6, v0

    sub-float/2addr v6, v4

    .line 397
    mul-float/2addr v5, v5

    mul-float/2addr v6, v6

    add-float/2addr v5, v6

    sget v6, Lcom/mrkeyboard/app/MrGestureInput;->sStart2:F

    cmpl-float v5, v5, v6

    if-ltz v5, :cond_1

    move v0, v1

    goto :goto_0

    .line 395
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_2
    move v0, v2

    .line 399
    goto :goto_0
.end method

.method private static finish(Lcom/mrkeyboard/app/LatinKeyboardView;)Z
    .locals 14

    .prologue
    const/4 v8, 0x0

    .line 683
    sget v5, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    .line 684
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

    .line 707
    :goto_0
    return v0

    .line 685
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    add-int/lit8 v1, v5, -0x1

    aget v0, v0, v1

    sget v1, Lcom/mrkeyboard/app/MrGestureInput;->sTop:F

    sub-float/2addr v0, v1

    sget v1, Lcom/mrkeyboard/app/MrGestureInput;->sHeight:F

    div-float/2addr v0, v1

    .line 686
    const/high16 v1, 0x3f000000    # 0.5f

    sget v2, Lcom/mrkeyboard/app/MrGestureInput;->sRows:I

    int-to-float v2, v2

    div-float/2addr v1, v2

    .line 687
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

    .line 688
    :cond_3
    sget-object v1, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    .line 689
    if-nez v1, :cond_4

    move v0, v8

    goto :goto_0

    .line 690
    :cond_4
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardView;->getShiftState()I

    move-result v9

    .line 691
    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->mrCommit()V

    .line 692
    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v10

    .line 693
    if-nez v10, :cond_5

    move v0, v8

    goto :goto_0

    .line 694
    :cond_5
    invoke-interface {v10}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    .line 695
    const/16 v0, 0x60

    invoke-static {v10, v0}, Lcom/mrkeyboard/app/MrGestureInput;->textBefore(Landroid/view/inputmethod/InputConnection;I)Ljava/lang/CharSequence;

    move-result-object v11

    .line 696
    invoke-static {v11}, Lcom/mrkeyboard/app/MrText;->lastWord(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v6

    .line 697
    invoke-static {v5}, Lcom/mrkeyboard/app/MrGestureInput;->frame(I)V

    .line 698
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v12

    .line 699
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sEngine:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sFx:[F

    sget-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sFy:[F

    sget-object v4, Lcom/mrkeyboard/app/MrGestureInput;->sPt:[I

    sget-object v7, Lcom/mrkeyboard/app/MrGestureInput;->sResult:Lcom/mrkeyboard/app/MrGesture$Result;

    invoke-interface/range {v0 .. v7}, Lcom/mrkeyboard/app/MrGestureInput$Engine;->decode(Lcom/mrkeyboard/app/LatinIME;[F[F[IILjava/lang/String;Lcom/mrkeyboard/app/MrGesture$Result;)I

    move-result v0

    .line 700
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v2

    sub-long/2addr v2, v12

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrGestureInput;->stat(J)V

    .line 701
    if-gtz v0, :cond_6

    move v0, v8

    goto :goto_0

    .line 702
    :cond_6
    const/4 v0, 0x4

    new-array v0, v0, [Ljava/lang/String;

    .line 703
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sResult:Lcom/mrkeyboard/app/MrGesture$Result;

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrGestureInput;->candidates(Lcom/mrkeyboard/app/MrGesture$Result;[Ljava/lang/String;)I

    move-result v2

    .line 704
    if-gtz v2, :cond_7

    move v0, v8

    goto :goto_0

    .line 705
    :cond_7
    :goto_1
    if-ge v8, v2, :cond_8

    aget-object v3, v0, v8

    invoke-static {v3, v9}, Lcom/mrkeyboard/app/MrGestureInput;->withCase(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v0, v8

    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    .line 706
    :cond_8
    invoke-static {v11}, Lcom/mrkeyboard/app/MrGestureInput;->needsSpace(Ljava/lang/CharSequence;)Z

    move-result v3

    invoke-static {v1, v10, v3, v0, v2}, Lcom/mrkeyboard/app/MrGestureInput;->write(Lcom/mrkeyboard/app/LatinIME;Landroid/view/inputmethod/InputConnection;Z[Ljava/lang/String;I)V

    .line 707
    const/4 v0, 0x1

    goto/16 :goto_0
.end method

.method private static forget()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 928
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    .line 929
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sLastEditor:Landroid/view/inputmethod/EditorInfo;

    .line 930
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sTapWord:Ljava/lang/String;

    .line 931
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sTapEditor:Landroid/view/inputmethod/EditorInfo;

    .line 932
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    .line 933
    return-void
.end method

.method private static frame(I)V
    .locals 4

    .prologue
    const/16 v1, 0x1000

    .line 712
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sFx:[F

    if-nez v0, :cond_0

    .line 713
    new-array v0, v1, [F

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sFx:[F

    .line 714
    new-array v0, v1, [F

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sFy:[F

    .line 716
    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-ge v0, p0, :cond_1

    .line 717
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sFx:[F

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    aget v2, v2, v0

    sget v3, Lcom/mrkeyboard/app/MrGestureInput;->sWidth:F

    div-float/2addr v2, v3

    aput v2, v1, v0

    .line 718
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sFy:[F

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    aget v2, v2, v0

    sget v3, Lcom/mrkeyboard/app/MrGestureInput;->sTop:F

    sub-float/2addr v2, v3

    sget v3, Lcom/mrkeyboard/app/MrGestureInput;->sHeight:F

    div-float/2addr v2, v3

    aput v2, v1, v0

    .line 716
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 720
    :cond_1
    return-void
.end method

.method private static gesture(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;I)V
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 404
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sPointer:I

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->findPointerIndex(I)I

    move-result v0

    .line 405
    packed-switch p2, :pswitch_data_0

    .line 427
    :cond_0
    :goto_0
    :pswitch_0
    return-void

    .line 407
    :pswitch_1
    if-ltz v0, :cond_0

    .line 408
    sget v1, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    .line 409
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrGestureInput;->addAll(Landroid/view/MotionEvent;I)V

    .line 410
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrGestureInput;->trailGrow(Lcom/mrkeyboard/app/LatinKeyboardView;I)V

    .line 411
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    if-eqz v0, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->previewMove(Lcom/mrkeyboard/app/LatinKeyboardView;)V

    goto :goto_0

    .line 415
    :pswitch_2
    if-ltz v0, :cond_0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v1

    if-ne v1, v0, :cond_0

    .line 416
    const/4 v1, 0x0

    invoke-static {p0, p1, v0, v1}, Lcom/mrkeyboard/app/MrGestureInput;->end(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;IZ)V

    goto :goto_0

    .line 419
    :pswitch_3
    invoke-static {p0, p1, v0, v1}, Lcom/mrkeyboard/app/MrGestureInput;->end(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;IZ)V

    goto :goto_0

    .line 422
    :pswitch_4
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->trailEnd(Lcom/mrkeyboard/app/LatinKeyboardView;)V

    .line 423
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGestureInput;->previewEnd(Z)V

    .line 424
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    goto :goto_0

    .line 405
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

.method private static glue(Lcom/mrkeyboard/app/LatinIME;ILjava/lang/String;Landroid/view/inputmethod/EditorInfo;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 1069
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v1

    .line 1070
    if-eqz v1, :cond_0

    if-nez p2, :cond_1

    .line 1071
    :cond_0
    :goto_0
    return v0

    :cond_1
    invoke-static {p0, v1, p2, p3}, Lcom/mrkeyboard/app/MrGestureInput;->written(Lcom/mrkeyboard/app/LatinIME;Landroid/view/inputmethod/InputConnection;Ljava/lang/String;Landroid/view/inputmethod/EditorInfo;)I

    move-result v1

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    if-ne v1, v2, :cond_0

    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/LatinIME;->mrGlue(I)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0
.end method

.method static handlerForTest()Landroid/os/Handler;
    .locals 1

    .prologue
    .line 1128
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static declared-synchronized init(Landroid/content/Context;)V
    .locals 3

    .prologue
    .line 185
    const-class v1, Lcom/mrkeyboard/app/MrGestureInput;

    monitor-enter v1

    if-nez p0, :cond_0

    .line 203
    :goto_0
    monitor-exit v1

    return-void

    .line 186
    :cond_0
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sApp:Landroid/content/Context;

    if-nez v0, :cond_2

    .line 187
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 188
    if-eqz v0, :cond_1

    move-object p0, v0

    :cond_1
    sput-object p0, Lcom/mrkeyboard/app/MrGestureInput;->sApp:Landroid/content/Context;

    .line 189
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sApp:Landroid/content/Context;

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 190
    if-eqz v0, :cond_2

    .line 191
    new-instance v2, Lcom/mrkeyboard/app/MrGestureInput$2;

    invoke-direct {v2}, Lcom/mrkeyboard/app/MrGestureInput$2;-><init>()V

    sput-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .line 196
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v0, v2}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 199
    :cond_2
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrGestureInput;->reload(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 200
    :catch_0
    move-exception v0

    .line 201
    const/4 v0, 0x0

    :try_start_1
    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sOn:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 185
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static isLayoutKey(I)Z
    .locals 1

    .prologue
    .line 1049
    const/4 v0, -0x1

    if-eq p0, v0, :cond_1

    const/4 v0, -0x2

    if-eq p0, v0, :cond_1

    const/16 v0, -0x12b

    if-gt p0, v0, :cond_0

    const/16 v0, -0x131

    if-ge p0, v0, :cond_1

    :cond_0
    const/16 v0, -0x18f

    if-gt p0, v0, :cond_2

    const/16 v0, -0x1f3

    if-lt p0, v0, :cond_2

    :cond_1
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static isMain(Lcom/mrkeyboard/app/LatinKeyboardView;)Z
    .locals 1

    .prologue
    .line 303
    invoke-static {}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInstance()Lcom/mrkeyboard/app/KeyboardSwitcher;

    move-result-object v0

    .line 304
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
    .line 511
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Keyboard;->getMinWidth()I

    move-result v0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/Keyboard;->getHeight()I

    move-result v1

    .line 512
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

    .line 518
    :goto_0
    return v0

    .line 513
    :cond_0
    new-instance v2, Ljava/lang/ref/WeakReference;

    invoke-direct {v2, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutOf:Ljava/lang/ref/WeakReference;

    .line 514
    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutW:I

    .line 515
    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutH:I

    .line 516
    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutOk:Z

    .line 517
    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrGestureInput;->buildLayout(Lcom/mrkeyboard/app/Keyboard;I)Z

    move-result v0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutOk:Z

    .line 518
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutOk:Z

    goto :goto_0
.end method

.method private static letterAt(II)I
    .locals 7

    .prologue
    .line 577
    const/4 v0, 0x0

    :goto_0
    sget v1, Lcom/mrkeyboard/app/MrGestureInput;->sKeyCount:I

    if-ge v0, v1, :cond_5

    .line 578
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

    .line 579
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

    .line 584
    :cond_3
    :goto_1
    return v0

    .line 577
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 584
    :cond_5
    const/4 v0, -0x1

    goto :goto_1
.end method

.method public static longPress(I)I
    .locals 3

    .prologue
    const/16 v0, 0xfa

    .line 596
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

    .line 486
    invoke-virtual {p0}, Lcom/mrkeyboard/app/Keyboard;->getKeys()Ljava/util/List;

    move-result-object v3

    .line 487
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v4

    move v2, v1

    :goto_0
    if-ge v2, v4, :cond_3

    .line 488
    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/Keyboard$Key;

    .line 489
    if-eqz v0, :cond_0

    iget-boolean v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->on:Z

    if-eqz v5, :cond_0

    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    if-eqz v5, :cond_0

    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    array-length v5, v5

    if-nez v5, :cond_1

    .line 487
    :cond_0
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    .line 490
    :cond_1
    iget-object v0, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    aget v0, v0, v1

    .line 491
    const/16 v5, -0x71

    if-eq v0, v5, :cond_2

    const/16 v5, -0x39

    if-eq v0, v5, :cond_2

    const/16 v5, -0x75

    if-ne v0, v5, :cond_0

    :cond_2
    const/4 v0, 0x1

    .line 493
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

    .line 875
    if-nez p0, :cond_1

    .line 885
    :cond_0
    :goto_0
    return v1

    .line 876
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    .line 877
    if-eqz v2, :cond_0

    .line 878
    add-int/lit8 v3, v2, -0x1

    invoke-interface {p0, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    .line 879
    invoke-static {v3}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v4

    if-nez v4, :cond_0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrGestureInput;->opens(C)Z

    move-result v4

    if-nez v4, :cond_0

    .line 880
    const/16 v4, 0x22

    if-eq v3, v4, :cond_2

    const/16 v4, 0x27

    if-ne v3, v4, :cond_4

    .line 881
    :cond_2
    if-eq v2, v0, :cond_0

    .line 882
    add-int/lit8 v2, v2, -0x2

    invoke-interface {p0, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v2

    .line 883
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

    .line 885
    goto :goto_0
.end method

.method public static onBackspace(Lcom/mrkeyboard/app/LatinIME;)V
    .locals 7

    .prologue
    const/4 v0, 0x1

    const/4 v3, 0x0

    const/4 v1, 0x0

    .line 998
    sget-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    if-eqz v2, :cond_1

    .line 1018
    :cond_0
    :goto_0
    return-void

    .line 999
    :cond_1
    sput-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sTapWord:Ljava/lang/String;

    .line 1000
    sput-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sTapEditor:Landroid/view/inputmethod/EditorInfo;

    .line 1001
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    if-eqz v2, :cond_0

    .line 1003
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v3

    .line 1004
    invoke-static {p0, v3}, Lcom/mrkeyboard/app/MrGestureInput;->written(Lcom/mrkeyboard/app/LatinIME;Landroid/view/inputmethod/InputConnection;)I

    move-result v2

    .line 1005
    if-lez v2, :cond_3

    .line 1006
    sget-boolean v4, Lcom/mrkeyboard/app/MrGestureInput;->sLastSpace:Z

    if-eqz v4, :cond_2

    .line 1007
    add-int/lit8 v4, v2, 0x1

    invoke-static {v3, v4}, Lcom/mrkeyboard/app/MrGestureInput;->textBefore(Landroid/view/inputmethod/InputConnection;I)Ljava/lang/CharSequence;

    move-result-object v4

    .line 1008
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

    .line 1010
    :cond_2
    if-le v2, v0, :cond_3

    add-int/lit8 v2, v2, -0x1

    const/4 v4, 0x0

    invoke-interface {v3, v2, v4}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z

    .line 1012
    :cond_3
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    if-eqz v2, :cond_4

    .line 1013
    :goto_1
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->forget()V

    .line 1014
    if-eqz v0, :cond_0

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinIME;->mrStrip(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1015
    :catch_0
    move-exception v0

    .line 1016
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->forget()V

    goto :goto_0

    :cond_4
    move v0, v1

    .line 1012
    goto :goto_1
.end method

.method public static onKey(Lcom/mrkeyboard/app/LatinIME;I)Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 1027
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    if-nez v0, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    if-nez v0, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sTapWord:Ljava/lang/String;

    if-nez v0, :cond_1

    move v0, v1

    .line 1044
    :cond_0
    :goto_0
    return v0

    .line 1028
    :cond_1
    const/4 v0, -0x5

    if-eq p1, v0, :cond_2

    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    if-eqz v0, :cond_3

    :cond_2
    move v0, v1

    goto :goto_0

    .line 1031
    :cond_3
    invoke-static {p1}, Lcom/mrkeyboard/app/MrGestureInput;->isLayoutKey(I)Z

    move-result v0

    if-eqz v0, :cond_4

    move v0, v1

    goto :goto_0

    .line 1034
    :cond_4
    if-lez p1, :cond_7

    :try_start_0
    const-string v0, ".,!?);:"

    invoke-virtual {v0, p1}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_7

    .line 1035
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    if-eqz v0, :cond_6

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sLastEditor:Landroid/view/inputmethod/EditorInfo;

    invoke-static {p0, p1, v0, v2}, Lcom/mrkeyboard/app/MrGestureInput;->glue(Lcom/mrkeyboard/app/LatinIME;ILjava/lang/String;Landroid/view/inputmethod/EditorInfo;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result v0

    .line 1038
    :goto_1
    :try_start_1
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    if-eqz v2, :cond_5

    const/4 v1, 0x1

    .line 1039
    :cond_5
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->forget()V

    .line 1040
    if-eqz v1, :cond_0

    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/LatinIME;->mrStrip(Ljava/util/List;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 1041
    :catch_0
    move-exception v1

    .line 1042
    :goto_2
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->forget()V

    goto :goto_0

    .line 1036
    :cond_6
    :try_start_2
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sTapWord:Ljava/lang/String;

    if-eqz v0, :cond_7

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sTapWord:Ljava/lang/String;

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sTapEditor:Landroid/view/inputmethod/EditorInfo;

    invoke-static {p0, p1, v0, v2}, Lcom/mrkeyboard/app/MrGestureInput;->glue(Lcom/mrkeyboard/app/LatinIME;ILjava/lang/String;Landroid/view/inputmethod/EditorInfo;)Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    move-result v0

    goto :goto_1

    .line 1041
    :catch_1
    move-exception v0

    move v0, v1

    goto :goto_2

    :cond_7
    move v0, v1

    goto :goto_1
.end method

.method public static onPick(Lcom/mrkeyboard/app/LatinIME;ILjava/lang/CharSequence;)Z
    .locals 8

    .prologue
    const/4 v3, 0x1

    const/4 v4, -0x1

    const/4 v2, 0x0

    .line 959
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    if-eqz v0, :cond_0

    move v0, v2

    .line 989
    :goto_0
    return v0

    .line 960
    :cond_0
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewShown:Z

    if-eqz v0, :cond_1

    move v0, v3

    goto :goto_0

    .line 961
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    if-nez v0, :cond_2

    move v0, v2

    goto :goto_0

    .line 963
    :cond_2
    :try_start_0
    sget-object v6, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    move v1, v2

    move v0, v4

    .line 965
    :goto_1
    array-length v5, v6

    if-ge v1, v5, :cond_4

    aget-object v5, v6, v1

    if-ne v5, p2, :cond_3

    move v0, v1

    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 966
    :cond_4
    if-ltz v0, :cond_5

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v1

    move-object v5, v1

    .line 967
    :goto_2
    if-ltz v0, :cond_6

    invoke-static {p0, v5}, Lcom/mrkeyboard/app/MrGestureInput;->written(Lcom/mrkeyboard/app/LatinIME;Landroid/view/inputmethod/InputConnection;)I

    move-result v1

    .line 968
    :goto_3
    if-gez v1, :cond_7

    .line 969
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->forget()V

    move v0, v2

    .line 970
    goto :goto_0

    .line 966
    :cond_5
    const/4 v1, 0x0

    move-object v5, v1

    goto :goto_2

    :cond_6
    move v1, v4

    .line 967
    goto :goto_3

    .line 972
    :cond_7
    aget-object v4, v6, v0

    .line 973
    sget-object v7, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    aput-object v7, v6, v0

    .line 974
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 975
    invoke-interface {v5}, Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 977
    const/4 v0, 0x0

    :try_start_1
    invoke-interface {v5, v1, v0}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z

    .line 978
    const/4 v0, -0x1

    invoke-virtual {p0, v0, v4}, Lcom/mrkeyboard/app/LatinIME;->pickSuggestionManually(ILjava/lang/CharSequence;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 980
    const/4 v0, 0x0

    :try_start_2
    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 981
    invoke-interface {v5}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 983
    sput-object v4, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    .line 984
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->showAlternatives(Lcom/mrkeyboard/app/LatinIME;)V

    move v0, v3

    .line 985
    goto :goto_0

    .line 980
    :catchall_0
    move-exception v0

    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 981
    invoke-interface {v5}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 982
    throw v0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    .line 986
    :catch_0
    move-exception v0

    .line 987
    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 988
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->forget()V

    move v0, v2

    .line 989
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

    .line 248
    sget v5, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    .line 249
    if-nez v5, :cond_0

    sget-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sOn:Z

    if-nez v2, :cond_0

    .line 270
    :goto_0
    return v0

    .line 252
    :cond_0
    :try_start_0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 253
    :try_start_1
    invoke-static {p0, p1, v2}, Lcom/mrkeyboard/app/MrGestureInput;->touch(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;I)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_3

    move-result v0

    goto :goto_0

    .line 254
    :catch_0
    move-exception v2

    move v3, v4

    .line 257
    :goto_1
    if-eq v5, v7, :cond_1

    if-eq v5, v6, :cond_1

    sget v2, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    if-eq v2, v7, :cond_1

    sget v2, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    if-ne v2, v6, :cond_4

    :cond_1
    move v2, v1

    .line 258
    :goto_2
    if-eq v3, v1, :cond_2

    if-eq v3, v6, :cond_2

    if-ne v3, v4, :cond_3

    :cond_2
    move v0, v1

    .line 260
    :cond_3
    :try_start_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->trailEnd(Lcom/mrkeyboard/app/LatinKeyboardView;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    .line 265
    :goto_3
    const/4 v1, 0x1

    :try_start_3
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGestureInput;->previewEnd(Z)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    .line 269
    :goto_4
    if-eqz v2, :cond_5

    if-nez v0, :cond_5

    sput v6, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    :goto_5
    move v0, v2

    .line 270
    goto :goto_0

    :cond_4
    move v2, v0

    .line 257
    goto :goto_2

    .line 269
    :cond_5
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    goto :goto_5

    .line 261
    :catch_1
    move-exception v1

    goto :goto_3

    .line 266
    :catch_2
    move-exception v1

    goto :goto_4

    .line 254
    :catch_3
    move-exception v3

    move v3, v2

    goto :goto_1
.end method

.method private static opens(C)Z
    .locals 1

    .prologue
    .line 889
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

    .line 846
    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    .line 847
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewPosted:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sHandler:Landroid/os/Handler;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sHandler:Landroid/os/Handler;

    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->PREVIEW:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 848
    :cond_0
    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewPosted:Z

    .line 849
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewShown:Z

    .line 850
    sput-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewShown:Z

    .line 851
    sput-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewWord:Ljava/lang/String;

    .line 852
    sput-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sPrevWord:Ljava/lang/String;

    .line 853
    if-eqz v0, :cond_1

    if-nez p0, :cond_2

    .line 857
    :cond_1
    :goto_0
    return-void

    .line 854
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    .line 855
    if-eqz v0, :cond_1

    .line 856
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
    .line 799
    :try_start_0
    sget-wide v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewDue:J

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    sub-long/2addr v0, v2

    .line 800
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gtz v2, :cond_1

    .line 801
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->previewNow(Lcom/mrkeyboard/app/LatinKeyboardView;)V

    .line 809
    :cond_0
    :goto_0
    return-void

    .line 802
    :cond_1
    sget-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewPosted:Z

    if-nez v2, :cond_0

    .line 803
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sHandler:Landroid/os/Handler;

    if-nez v2, :cond_2

    new-instance v2, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sHandler:Landroid/os/Handler;

    .line 804
    :cond_2
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sHandler:Landroid/os/Handler;

    sget-object v3, Lcom/mrkeyboard/app/MrGestureInput;->PREVIEW:Ljava/lang/Runnable;

    invoke-virtual {v2, v3, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    move-result v0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewPosted:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 806
    :catch_0
    move-exception v0

    .line 807
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    goto :goto_0
.end method

.method private static previewNow(Lcom/mrkeyboard/app/LatinKeyboardView;)V
    .locals 13

    .prologue
    const/4 v12, 0x1

    .line 812
    sget v5, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    .line 813
    sput v5, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewCount:I

    .line 814
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sFull:Z

    if-nez v0, :cond_0

    const/4 v0, 0x2

    if-lt v5, v0, :cond_0

    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sHeight:F

    const/4 v1, 0x0

    cmpg-float v0, v0, v1

    if-gtz v0, :cond_1

    .line 838
    :cond_0
    :goto_0
    return-void

    .line 815
    :cond_1
    sget-object v1, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    .line 816
    if-eqz v1, :cond_0

    .line 817
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPrevRead:Z

    if-nez v0, :cond_2

    .line 820
    sput-boolean v12, Lcom/mrkeyboard/app/MrGestureInput;->sPrevRead:Z

    .line 821
    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v0

    .line 822
    if-eqz v0, :cond_4

    const/16 v2, 0x60

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrGestureInput;->textBefore(Landroid/view/inputmethod/InputConnection;I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrText;->lastWord(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    :goto_1
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPrevWord:Ljava/lang/String;

    .line 824
    :cond_2
    invoke-static {v5}, Lcom/mrkeyboard/app/MrGestureInput;->frame(I)V

    .line 825
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v8

    .line 826
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sEngine:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sFx:[F

    sget-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sFy:[F

    sget-object v4, Lcom/mrkeyboard/app/MrGestureInput;->sPt:[I

    sget-object v6, Lcom/mrkeyboard/app/MrGestureInput;->sPrevWord:Ljava/lang/String;

    sget-object v7, Lcom/mrkeyboard/app/MrGestureInput;->sResult:Lcom/mrkeyboard/app/MrGesture$Result;

    invoke-interface/range {v0 .. v7}, Lcom/mrkeyboard/app/MrGestureInput$Engine;->decode(Lcom/mrkeyboard/app/LatinIME;[F[F[IILjava/lang/String;Lcom/mrkeyboard/app/MrGesture$Result;)I

    move-result v0

    .line 827
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v2

    sub-long/2addr v2, v8

    .line 828
    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrGestureInput;->statPreview(J)V

    .line 829
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

    .line 830
    if-lez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sResult:Lcom/mrkeyboard/app/MrGesture$Result;

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewBest:[Ljava/lang/String;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrGestureInput;->candidates(Lcom/mrkeyboard/app/MrGesture$Result;[Ljava/lang/String;)I

    move-result v0

    if-lez v0, :cond_0

    .line 831
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewBest:[Ljava/lang/String;

    const/4 v2, 0x0

    aget-object v0, v0, v2

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardView;->getShiftState()I

    move-result v2

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrGestureInput;->withCase(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .line 832
    sget-boolean v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewShown:Z

    if-eqz v2, :cond_3

    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewWord:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 833
    :cond_3
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v12}, Ljava/util/ArrayList;-><init>(I)V

    .line 834
    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 835
    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/LatinIME;->mrStrip(Ljava/util/List;)V

    .line 836
    sput-boolean v12, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewShown:Z

    .line 837
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewWord:Ljava/lang/String;

    goto/16 :goto_0

    .line 822
    :cond_4
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private static previewStart()V
    .locals 6

    .prologue
    const/4 v0, 0x0

    const/4 v1, 0x0

    .line 769
    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewShown:Z

    .line 770
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewWord:Ljava/lang/String;

    .line 771
    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewCount:I

    .line 772
    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewPosted:Z

    .line 773
    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sPrevRead:Z

    .line 774
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPrevWord:Ljava/lang/String;

    .line 775
    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    .line 777
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    .line 778
    if-nez v0, :cond_0

    .line 785
    :goto_0
    return-void

    .line 779
    :cond_0
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sEngine:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    invoke-interface {v2, v0}, Lcom/mrkeyboard/app/MrGestureInput$Engine;->prepare(Lcom/mrkeyboard/app/LatinIME;)V

    .line 780
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    const-wide/16 v4, 0x78

    add-long/2addr v2, v4

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewDue:J

    .line 781
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

    .line 782
    :catch_0
    move-exception v0

    .line 783
    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    goto :goto_0

    :cond_1
    move v0, v1

    .line 781
    goto :goto_1
.end method

.method static declared-synchronized reload(Landroid/content/Context;)V
    .locals 7

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 211
    const-class v4, Lcom/mrkeyboard/app/MrGestureInput;

    monitor-enter v4

    if-nez p0, :cond_0

    :try_start_0
    sget-object p0, Lcom/mrkeyboard/app/MrGestureInput;->sApp:Landroid/content/Context;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 212
    :cond_0
    if-nez p0, :cond_1

    .line 223
    :goto_0
    monitor-exit v4

    return-void

    .line 213
    :cond_1
    :try_start_1
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v5

    .line 214
    if-eqz v5, :cond_4

    const-string v2, "pref_gesture_typing"

    const/4 v3, 0x0

    invoke-interface {v5, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_4

    move v3, v0

    .line 215
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

    .line 216
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

    .line 217
    if-eqz v3, :cond_7

    const-string v2, "gesture"

    const-string v3, "encoder.bin"

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacks;->modelFile(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    .line 218
    :goto_4
    if-eqz v2, :cond_8

    :goto_5
    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sOn:Z

    .line 219
    invoke-static {v2}, Lcom/mrkeyboard/app/MrGesture;->use(Ljava/io/File;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 220
    :catch_0
    move-exception v0

    .line 221
    const/4 v0, 0x0

    :try_start_2
    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sOn:Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 211
    :catchall_0
    move-exception v0

    monitor-exit v4

    throw v0

    :cond_4
    move v3, v1

    .line 214
    goto :goto_1

    :cond_5
    move v2, v1

    .line 215
    goto :goto_2

    :cond_6
    move v2, v1

    .line 216
    goto :goto_3

    .line 217
    :cond_7
    const/4 v2, 0x0

    goto :goto_4

    :cond_8
    move v0, v1

    .line 218
    goto :goto_5
.end method

.method static declared-synchronized resetForTest()V
    .locals 4

    .prologue
    .line 1103
    const-class v1, Lcom/mrkeyboard/app/MrGestureInput;

    monitor-enter v1

    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    .line 1104
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sOn:Z

    .line 1105
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrail:Z

    .line 1106
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreview:Z

    .line 1107
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPrevRead:Z

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewPosted:Z

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewShown:Z

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewOn:Z

    .line 1108
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPrevWord:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewWord:Ljava/lang/String;

    .line 1109
    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewDue:J

    .line 1110
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sPreviewCount:I

    .line 1111
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sHandler:Landroid/os/Handler;

    .line 1112
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->REAL:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sEngine:Lcom/mrkeyboard/app/MrGestureInput$Engine;

    .line 1113
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sApp:Landroid/content/Context;

    .line 1114
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .line 1115
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutOf:Ljava/lang/ref/WeakReference;

    .line 1116
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sLayoutOk:Z

    .line 1117
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sKeyCount:I

    .line 1118
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    .line 1119
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 1120
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->forget()V

    .line 1121
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sLastSpace:Z

    .line 1122
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviews:I

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sStatCount:I

    .line 1123
    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviewMax:J

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviewSum:J

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatMax:J

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatSum:J

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatLast:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1124
    monitor-exit v1

    return-void

    .line 1103
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private static showAlternatives(Lcom/mrkeyboard/app/LatinIME;)V
    .locals 4

    .prologue
    const/4 v0, 0x2

    .line 919
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    .line 920
    new-instance v2, Ljava/util/ArrayList;

    const/4 v3, 0x3

    invoke-direct {v2, v3}, Ljava/util/ArrayList;-><init>(I)V

    .line 921
    array-length v3, v1

    if-lt v3, v0, :cond_0

    const/4 v3, 0x1

    aget-object v3, v1, v3

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 922
    :cond_0
    const/4 v3, 0x0

    aget-object v3, v1, v3

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 923
    :goto_0
    array-length v3, v1

    if-ge v0, v3, :cond_1

    aget-object v3, v1, v0

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 924
    :cond_1
    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/LatinIME;->mrStrip(Ljava/util/List;)V

    .line 925
    return-void
.end method

.method private static declared-synchronized stat(J)V
    .locals 4

    .prologue
    .line 1080
    const-class v1, Lcom/mrkeyboard/app/MrGestureInput;

    monitor-enter v1

    :try_start_0
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sStatCount:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sStatCount:I

    .line 1081
    sput-wide p0, Lcom/mrkeyboard/app/MrGestureInput;->sStatLast:J

    .line 1082
    sget-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatSum:J

    add-long/2addr v2, p0

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatSum:J

    .line 1083
    sget-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatMax:J

    cmp-long v0, p0, v2

    if-lez v0, :cond_0

    sput-wide p0, Lcom/mrkeyboard/app/MrGestureInput;->sStatMax:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1084
    :cond_0
    monitor-exit v1

    return-void

    .line 1080
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private static declared-synchronized statPreview(J)V
    .locals 4

    .prologue
    .line 1087
    const-class v1, Lcom/mrkeyboard/app/MrGestureInput;

    monitor-enter v1

    :try_start_0
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviews:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviews:I

    .line 1088
    sget-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviewSum:J

    add-long/2addr v2, p0

    sput-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviewSum:J

    .line 1089
    sget-wide v2, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviewMax:J

    cmp-long v0, p0, v2

    if-lez v0, :cond_0

    sput-wide p0, Lcom/mrkeyboard/app/MrGestureInput;->sStatPreviewMax:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1090
    :cond_0
    monitor-exit v1

    return-void

    .line 1087
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static stateForTest()I
    .locals 1

    .prologue
    .line 1133
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    return v0
.end method

.method static declared-synchronized stats()[J
    .locals 6

    .prologue
    .line 1098
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
    .line 792
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarMain:Landroid/view/View;

    .line 793
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
    .line 352
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

.method static textBefore(Landroid/view/inputmethod/InputConnection;I)Ljava/lang/CharSequence;
    .locals 1

    .prologue
    .line 175
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V

    .line 177
    const/4 v0, 0x0

    :try_start_0
    invoke-interface {p0, p1, v0}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 179
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 177
    return-object v0

    .line 179
    :catchall_0
    move-exception v0

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 180
    throw v0
.end method

.method private static toIdle()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 308
    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    .line 309
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sView:Lcom/mrkeyboard/app/LatinKeyboardView;

    .line 310
    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    .line 311
    sput-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sFull:Z

    .line 312
    return-void
.end method

.method private static touch(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;I)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    const/4 v1, 0x1

    .line 275
    sget v2, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    if-eqz v2, :cond_2

    .line 276
    sget-object v2, Lcom/mrkeyboard/app/MrGestureInput;->sView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-eq p0, v2, :cond_5

    .line 278
    if-nez p2, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->isMain(Lcom/mrkeyboard/app/LatinKeyboardView;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 298
    :cond_0
    :goto_0
    return v0

    .line 279
    :cond_1
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGestureInput;->previewEnd(Z)V

    .line 280
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    .line 287
    :cond_2
    :goto_1
    sget v2, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    packed-switch v2, :pswitch_data_0

    .line 297
    if-eq p2, v1, :cond_3

    const/4 v0, 0x3

    if-ne p2, v0, :cond_4

    :cond_3
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    :cond_4
    move v0, v1

    .line 298
    goto :goto_0

    .line 281
    :cond_5
    if-nez p2, :cond_2

    .line 282
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->trailEnd(Lcom/mrkeyboard/app/LatinKeyboardView;)V

    .line 283
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGestureInput;->previewEnd(Z)V

    .line 284
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    goto :goto_1

    .line 289
    :pswitch_0
    if-nez p2, :cond_0

    sget-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sOn:Z

    if-eqz v1, :cond_0

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrGestureInput;->begin(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;)V

    goto :goto_0

    .line 292
    :pswitch_1
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrGestureInput;->track(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;I)Z

    move-result v0

    goto :goto_0

    .line 294
    :pswitch_2
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrGestureInput;->gesture(Lcom/mrkeyboard/app/LatinKeyboardView;Landroid/view/MotionEvent;I)V

    move v0, v1

    .line 295
    goto :goto_0

    .line 287
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

    .line 366
    if-ne p2, v4, :cond_0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v2

    if-ne v2, v1, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardView;->popupKeyboardIsShowing()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 367
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    .line 389
    :cond_1
    :goto_0
    return v0

    .line 370
    :cond_2
    sget v2, Lcom/mrkeyboard/app/MrGestureInput;->sPointer:I

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->findPointerIndex(I)I

    move-result v2

    .line 371
    if-gez v2, :cond_3

    .line 372
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->toIdle()V

    goto :goto_0

    .line 375
    :cond_3
    sget v3, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    .line 376
    invoke-static {p1, v2}, Lcom/mrkeyboard/app/MrGestureInput;->addAll(Landroid/view/MotionEvent;I)V

    .line 377
    invoke-static {v3}, Lcom/mrkeyboard/app/MrGestureInput;->farEnough(I)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 378
    sput v4, Lcom/mrkeyboard/app/MrGestureInput;->sState:I

    .line 379
    invoke-static {p1}, Landroid/view/MotionEvent;->obtain(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;

    move-result-object v2

    .line 381
    const/4 v0, 0x3

    :try_start_0
    invoke-virtual {v2, v0}, Landroid/view/MotionEvent;->setAction(I)V

    .line 383
    const/4 v0, 0x0

    invoke-virtual {p0, v2, v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->onTouchEvent(Landroid/view/MotionEvent;Z)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 385
    invoke-virtual {v2}, Landroid/view/MotionEvent;->recycle()V

    .line 387
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->trailStart(Lcom/mrkeyboard/app/LatinKeyboardView;)V

    .line 388
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->previewStart()V

    move v0, v1

    .line 389
    goto :goto_0

    .line 385
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Landroid/view/MotionEvent;->recycle()V

    .line 386
    throw v0
.end method

.method private static trailEnd(Lcom/mrkeyboard/app/LatinKeyboardView;)V
    .locals 5

    .prologue
    .line 650
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    if-nez v0, :cond_1

    .line 655
    :cond_0
    :goto_0
    return-void

    .line 651
    :cond_1
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    .line 652
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    if-eqz v0, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    invoke-virtual {v0}, Landroid/graphics/Path;->reset()V

    .line 653
    :cond_2
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailWidth:F

    float-to-int v0, v0

    add-int/lit8 v0, v0, 0x2

    .line 654
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

    .line 629
    sget-boolean v1, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    if-nez v1, :cond_1

    .line 647
    :cond_0
    :goto_0
    return-void

    .line 630
    :cond_1
    if-ge p1, v0, :cond_2

    move p1, v0

    .line 631
    :cond_2
    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    if-ge p1, v0, :cond_0

    .line 632
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    add-int/lit8 v1, p1, -0x1

    aget v1, v0, v1

    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    add-int/lit8 v2, p1, -0x1

    aget v0, v0, v2

    move v2, v1

    move v3, v1

    move v1, v0

    .line 633
    :goto_1
    sget v4, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    if-ge p1, v4, :cond_7

    .line 634
    sget-object v4, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    aget v5, v4, p1

    sget-object v4, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    aget v4, v4, p1

    .line 635
    sget-object v6, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    invoke-virtual {v6, v5, v4}, Landroid/graphics/Path;->lineTo(FF)V

    .line 636
    cmpg-float v6, v5, v3

    if-gez v6, :cond_3

    move v3, v5

    .line 637
    :cond_3
    cmpl-float v6, v5, v2

    if-lez v6, :cond_4

    move v2, v5

    .line 638
    :cond_4
    cmpg-float v5, v4, v1

    if-gez v5, :cond_5

    move v1, v4

    .line 639
    :cond_5
    cmpl-float v5, v4, v0

    if-lez v5, :cond_6

    move v0, v4

    .line 633
    :cond_6
    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    .line 641
    :cond_7
    sget v4, Lcom/mrkeyboard/app/MrGestureInput;->sBoundL:F

    cmpg-float v4, v3, v4

    if-gez v4, :cond_8

    sput v3, Lcom/mrkeyboard/app/MrGestureInput;->sBoundL:F

    .line 642
    :cond_8
    sget v4, Lcom/mrkeyboard/app/MrGestureInput;->sBoundR:F

    cmpl-float v4, v2, v4

    if-lez v4, :cond_9

    sput v2, Lcom/mrkeyboard/app/MrGestureInput;->sBoundR:F

    .line 643
    :cond_9
    sget v4, Lcom/mrkeyboard/app/MrGestureInput;->sBoundT:F

    cmpg-float v4, v1, v4

    if-gez v4, :cond_a

    sput v1, Lcom/mrkeyboard/app/MrGestureInput;->sBoundT:F

    .line 644
    :cond_a
    sget v4, Lcom/mrkeyboard/app/MrGestureInput;->sBoundB:F

    cmpl-float v4, v0, v4

    if-lez v4, :cond_b

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sBoundB:F

    .line 645
    :cond_b
    sget v4, Lcom/mrkeyboard/app/MrGestureInput;->sTrailWidth:F

    float-to-int v4, v4

    add-int/lit8 v4, v4, 0x2

    .line 646
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

    .line 608
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrail:Z

    if-eqz v0, :cond_0

    sget v0, Lcom/mrkeyboard/app/MrGestureInput;->sCount:I

    if-lez v0, :cond_0

    move v0, v1

    :goto_0
    sput-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    .line 609
    sget-boolean v0, Lcom/mrkeyboard/app/MrGestureInput;->sTrailOn:Z

    if-nez v0, :cond_1

    .line 625
    :goto_1
    return-void

    :cond_0
    move v0, v2

    .line 608
    goto :goto_0

    .line 610
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    if-nez v0, :cond_2

    .line 611
    new-instance v0, Landroid/graphics/Path;

    invoke-direct {v0}, Landroid/graphics/Path;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    .line 612
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPaint:Landroid/graphics/Paint;

    .line 613
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 614
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 615
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Join;->ROUND:Landroid/graphics/Paint$Join;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setStrokeJoin(Landroid/graphics/Paint$Join;)V

    .line 617
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->accent()I

    move-result v0

    .line 618
    sget-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sPaint:Landroid/graphics/Paint;

    const/high16 v4, -0x34000000    # -3.3554432E7f

    if-eqz v0, :cond_3

    :goto_2
    or-int/2addr v0, v4

    invoke-virtual {v3, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 619
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPaint:Landroid/graphics/Paint;

    sget v3, Lcom/mrkeyboard/app/MrGestureInput;->sTrailWidth:F

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 620
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    invoke-virtual {v0}, Landroid/graphics/Path;->reset()V

    .line 621
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPath:Landroid/graphics/Path;

    sget-object v3, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    aget v3, v3, v2

    sget-object v4, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    aget v4, v4, v2

    invoke-virtual {v0, v3, v4}, Landroid/graphics/Path;->moveTo(FF)V

    .line 622
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPx:[F

    aget v0, v0, v2

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sBoundR:F

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sBoundL:F

    .line 623
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sPy:[F

    aget v0, v0, v2

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sBoundB:F

    sput v0, Lcom/mrkeyboard/app/MrGestureInput;->sBoundT:F

    .line 624
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrGestureInput;->trailGrow(Lcom/mrkeyboard/app/LatinKeyboardView;I)V

    goto :goto_1

    .line 618
    :cond_3
    const v0, 0x40c4ff

    goto :goto_2
.end method

.method static withCase(Ljava/lang/String;I)Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 861
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 867
    :cond_0
    :goto_0
    return-object p0

    .line 862
    :cond_1
    const/4 v0, 0x2

    if-eq p1, v0, :cond_2

    const/4 v0, 0x4

    if-ne p1, v0, :cond_3

    :cond_2
    invoke-virtual {p0}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    .line 863
    :cond_3
    if-eq p1, v2, :cond_4

    const/4 v0, 0x3

    if-ne p1, v0, :cond_0

    .line 864
    :cond_4
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->toUpperCase(C)C

    move-result v1

    .line 865
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
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 893
    aget-object v0, p3, v3

    .line 894
    sput-boolean v4, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 895
    invoke-interface {p1}, Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z

    .line 897
    if-eqz p2, :cond_0

    :try_start_0
    const-string v1, " "

    const/4 v2, 0x1

    invoke-interface {p1, v1, v2}, Landroid/view/inputmethod/InputConnection;->commitText(Ljava/lang/CharSequence;I)Z

    .line 898
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->NONE:Ljava/util/List;

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/LatinIME;->mrStrip(Ljava/util/List;)V

    .line 899
    const/4 v1, -0x1

    invoke-virtual {p0, v1, v0}, Lcom/mrkeyboard/app/LatinIME;->pickSuggestionManually(ILjava/lang/CharSequence;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 901
    sput-boolean v3, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 902
    invoke-interface {p1}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 904
    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    .line 905
    sput-boolean p2, Lcom/mrkeyboard/app/MrGestureInput;->sLastSpace:Z

    .line 906
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sLastEditor:Landroid/view/inputmethod/EditorInfo;

    .line 907
    sput-object v5, Lcom/mrkeyboard/app/MrGestureInput;->sTapWord:Ljava/lang/String;

    .line 908
    sput-object v5, Lcom/mrkeyboard/app/MrGestureInput;->sTapEditor:Landroid/view/inputmethod/EditorInfo;

    .line 909
    sput-object v5, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    .line 910
    if-le p4, v4, :cond_1

    .line 911
    add-int/lit8 v0, p4, -0x1

    new-array v0, v0, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    .line 912
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sAlts:[Ljava/lang/String;

    add-int/lit8 v1, p4, -0x1

    invoke-static {p3, v4, v0, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 913
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->showAlternatives(Lcom/mrkeyboard/app/LatinIME;)V

    .line 915
    :cond_1
    return-void

    .line 901
    :catchall_0
    move-exception v0

    sput-boolean v3, Lcom/mrkeyboard/app/MrGestureInput;->sWriting:Z

    .line 902
    invoke-interface {p1}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 903
    throw v0
.end method

.method private static written(Lcom/mrkeyboard/app/LatinIME;Landroid/view/inputmethod/InputConnection;)I
    .locals 2

    .prologue
    .line 940
    sget-object v0, Lcom/mrkeyboard/app/MrGestureInput;->sLastWord:Ljava/lang/String;

    sget-object v1, Lcom/mrkeyboard/app/MrGestureInput;->sLastEditor:Landroid/view/inputmethod/EditorInfo;

    invoke-static {p0, p1, v0, v1}, Lcom/mrkeyboard/app/MrGestureInput;->written(Lcom/mrkeyboard/app/LatinIME;Landroid/view/inputmethod/InputConnection;Ljava/lang/String;Landroid/view/inputmethod/EditorInfo;)I

    move-result v0

    return v0
.end method

.method private static written(Lcom/mrkeyboard/app/LatinIME;Landroid/view/inputmethod/InputConnection;Ljava/lang/String;Landroid/view/inputmethod/EditorInfo;)I
    .locals 5

    .prologue
    const/4 v1, -0x1

    .line 944
    if-eqz p2, :cond_0

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v0

    if-eq v0, p3, :cond_1

    .line 950
    :cond_0
    :goto_0
    return v1

    .line 945
    :cond_1
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    .line 946
    add-int/lit8 v2, v0, 0x1

    invoke-static {p1, v2}, Lcom/mrkeyboard/app/MrGestureInput;->textBefore(Landroid/view/inputmethod/InputConnection;I)Ljava/lang/CharSequence;

    move-result-object v2

    .line 947
    if-eqz v2, :cond_0

    .line 948
    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    .line 949
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    add-int/lit8 v4, v0, 0x1

    if-ne v3, v4, :cond_2

    invoke-virtual {v2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0x20

    if-ne v3, v4, :cond_2

    invoke-virtual {v2, p2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    add-int/lit8 v1, v0, 0x1

    goto :goto_0

    .line 950
    :cond_2
    invoke-virtual {v2, p2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    :goto_1
    move v1, v0

    goto :goto_0

    :cond_3
    move v0, v1

    goto :goto_1
.end method
