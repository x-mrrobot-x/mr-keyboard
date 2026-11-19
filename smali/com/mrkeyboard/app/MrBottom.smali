.class public final Lcom/mrkeyboard/app/MrBottom;
.super Ljava/lang/Object;
.source "MrBottom.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrBottom$Api29;
    }
.end annotation


# static fields
.field private static final APPLIED:Ljava/util/WeakHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/WeakHashMap",
            "<",
            "Landroid/view/View;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field static final BAR_SDK:I = 0x1e

.field static final GAP_DP:F = 4.0f

.field static final MIN_KEYS_PERCENT:I = 0x32

.field static final NO_COLOR:I = -0xff01

.field static final TRANSPARENT_BAR_SDK:I = 0x24


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 43
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrBottom;->APPLIED:Ljava/util/WeakHashMap;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static apply(Landroid/view/View;)V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 76
    if-eqz p0, :cond_0

    instance-of v0, p0, Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    if-eqz v0, :cond_1

    .line 86
    :cond_0
    :goto_0
    return-void

    .line 78
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBottom;->gapPx(Landroid/content/Context;)I

    move-result v2

    .line 79
    sget-object v0, Lcom/mrkeyboard/app/MrBottom;->APPLIED:Ljava/util/WeakHashMap;

    invoke-virtual {v0, p0}, Ljava/util/WeakHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 80
    invoke-virtual {p0}, Landroid/view/View;->getPaddingBottom()I

    move-result v3

    if-nez v0, :cond_2

    move v0, v1

    :goto_1
    sub-int v0, v3, v0

    .line 81
    invoke-virtual {p0}, Landroid/view/View;->getPaddingLeft()I

    move-result v1

    invoke-virtual {p0}, Landroid/view/View;->getPaddingTop()I

    move-result v3

    invoke-virtual {p0}, Landroid/view/View;->getPaddingRight()I

    move-result v4

    const/4 v5, 0x0

    invoke-static {v5, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    add-int/2addr v0, v2

    invoke-virtual {p0, v1, v3, v4, v0}, Landroid/view/View;->setPadding(IIII)V

    .line 82
    sget-object v0, Lcom/mrkeyboard/app/MrBottom;->APPLIED:Ljava/util/WeakHashMap;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, p0, v1}, Ljava/util/WeakHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 83
    :catch_0
    move-exception v0

    goto :goto_0

    .line 80
    :cond_2
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_1
.end method

.method public static bar(Landroid/inputmethodservice/InputMethodService;)V
    .locals 4

    .prologue
    .line 106
    if-eqz p0, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-ge v0, v1, :cond_1

    .line 121
    :cond_0
    :goto_0
    return-void

    .line 108
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Landroid/inputmethodservice/InputMethodService;->getWindow()Landroid/app/Dialog;

    move-result-object v0

    .line 109
    if-nez v0, :cond_3

    const/4 v0, 0x0

    move-object v2, v0

    .line 110
    :goto_1
    if-eqz v2, :cond_0

    .line 111
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const-string v1, "kbd_bg"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrBottom;->barColor(II)I

    move-result v1

    .line 113
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->bottomColor(Landroid/content/Context;)I

    move-result v0

    .line 114
    if-eqz v0, :cond_4

    .line 115
    :goto_2
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x24

    if-ge v1, v3, :cond_2

    const v1, -0xff01

    if-eq v0, v1, :cond_0

    .line 116
    :cond_2
    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrBottom$Api29;->bar(Landroid/view/Window;I)V

    .line 117
    sget v0, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrLight;->bars(Landroid/inputmethodservice/InputMethodService;I)V

    goto :goto_0

    .line 118
    :catch_0
    move-exception v0

    goto :goto_0

    .line 109
    :cond_3
    invoke-virtual {v0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    move-object v2, v0

    goto :goto_1

    :cond_4
    move v0, v1

    goto :goto_2
.end method

.method static barColor(II)I
    .locals 1

    .prologue
    .line 95
    const/16 v0, 0x24

    if-lt p0, v0, :cond_0

    const/4 p1, 0x0

    .line 96
    :cond_0
    return p1
.end method

.method public static gapPx(Landroid/content/Context;)I
    .locals 2

    .prologue
    .line 50
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    .line 51
    const/high16 v1, 0x40800000    # 4.0f

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 53
    :goto_0
    return v0

    .line 52
    :catch_0
    move-exception v0

    .line 53
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static keysHeight(II)I
    .locals 2

    .prologue
    .line 62
    if-lez p0, :cond_0

    if-gtz p1, :cond_1

    .line 63
    :cond_0
    :goto_0
    return p0

    :cond_1
    sub-int v0, p0, p1

    mul-int/lit8 v1, p0, 0x32

    div-int/lit8 v1, v1, 0x64

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result p0

    goto :goto_0
.end method

.method public static keysHeight(Landroid/content/Context;I)I
    .locals 1

    .prologue
    .line 68
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBottom;->gapPx(Landroid/content/Context;)I

    move-result v0

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrBottom;->keysHeight(II)I

    move-result v0

    return v0
.end method
