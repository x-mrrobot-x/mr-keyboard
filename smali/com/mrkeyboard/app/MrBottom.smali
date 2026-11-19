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

.field static final BUTTONS_DP:F = 4.0f

.field static final EDGE_TO_EDGE_SDK:I = 0x23

.field static final GESTURE_DP:F = 10.0f

.field static final MIN_KEYS_PERCENT:I = 0x32

.field static final MODE_GESTURES:I = 0x2

.field static final NAVIGATION_MODE:Ljava/lang/String; = "navigation_mode"

.field static final NAV_BAR_MODE_RES:Ljava/lang/String; = "config_navBarInteractionMode"

.field static final SAMSUNG_GESTURES:Ljava/lang/String; = "navigation_bar_gesture_while_hidden"

.field static final XIAOMI_GESTURES:Ljava/lang/String; = "force_fsg_nav_bar"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 55
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrBottom;->APPLIED:Ljava/util/WeakHashMap;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static apply(Landroid/view/View;)V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 125
    if-eqz p0, :cond_0

    instance-of v0, p0, Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    if-eqz v0, :cond_1

    .line 135
    :cond_0
    :goto_0
    return-void

    .line 127
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBottom;->gapPx(Landroid/content/Context;)I

    move-result v2

    .line 128
    sget-object v0, Lcom/mrkeyboard/app/MrBottom;->APPLIED:Ljava/util/WeakHashMap;

    invoke-virtual {v0, p0}, Ljava/util/WeakHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 129
    invoke-virtual {p0}, Landroid/view/View;->getPaddingBottom()I

    move-result v3

    if-nez v0, :cond_2

    move v0, v1

    :goto_1
    sub-int v0, v3, v0

    .line 130
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

    .line 131
    sget-object v0, Lcom/mrkeyboard/app/MrBottom;->APPLIED:Ljava/util/WeakHashMap;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, p0, v1}, Ljava/util/WeakHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 132
    :catch_0
    move-exception v0

    goto :goto_0

    .line 129
    :cond_2
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_1
.end method

.method public static bar(Landroid/inputmethodservice/InputMethodService;)V
    .locals 2

    .prologue
    .line 144
    if-eqz p0, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x23

    if-ge v0, v1, :cond_1

    .line 152
    :cond_0
    :goto_0
    return-void

    .line 146
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Landroid/inputmethodservice/InputMethodService;->getWindow()Landroid/app/Dialog;

    move-result-object v0

    .line 147
    if-nez v0, :cond_2

    const/4 v0, 0x0

    .line 148
    :goto_1
    if-eqz v0, :cond_0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBottom$Api29;->transparentBar(Landroid/view/Window;)V

    goto :goto_0

    .line 149
    :catch_0
    move-exception v0

    goto :goto_0

    .line 147
    :cond_2
    invoke-virtual {v0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_1
.end method

.method static gapDp(Z)F
    .locals 1

    .prologue
    .line 93
    if-eqz p0, :cond_0

    const/high16 v0, 0x41200000    # 10.0f

    :goto_0
    return v0

    :cond_0
    const/high16 v0, 0x40800000    # 4.0f

    goto :goto_0
.end method

.method public static gapPx(Landroid/content/Context;)I
    .locals 2

    .prologue
    .line 99
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    .line 100
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBottom;->gestures(Landroid/content/Context;)Z

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBottom;->gapDp(Z)F

    move-result v1

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 102
    :goto_0
    return v0

    .line 101
    :catch_0
    move-exception v0

    .line 102
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static gestures(Landroid/content/Context;)Z
    .locals 6

    .prologue
    const/4 v0, -0x1

    .line 69
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    .line 70
    const-string v2, "navigation_mode"

    const/4 v3, -0x1

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v2

    .line 72
    if-gez v2, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrBottom;->resourceMode()I

    move-result v0

    .line 73
    :cond_0
    const-string v3, "navigation_bar_gesture_while_hidden"

    const/4 v4, -0x1

    invoke-static {v1, v3, v4}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v3

    .line 74
    const-string v4, "force_fsg_nav_bar"

    const/4 v5, -0x1

    invoke-static {v1, v4, v5}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    .line 75
    invoke-static {v2, v0, v3, v1}, Lcom/mrkeyboard/app/MrBottom;->gesturesFrom(IIII)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 77
    :goto_0
    return v0

    .line 76
    :catch_0
    move-exception v0

    .line 77
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static gesturesFrom(IIII)Z
    .locals 3

    .prologue
    const/4 v2, 0x2

    const/4 v1, 0x0

    const/4 v0, 0x1

    .line 61
    if-eq p2, v0, :cond_0

    if-ne p3, v0, :cond_1

    .line 63
    :cond_0
    :goto_0
    return v0

    .line 62
    :cond_1
    if-ltz p0, :cond_2

    if-eq p0, v2, :cond_0

    move v0, v1

    goto :goto_0

    .line 63
    :cond_2
    if-eq p1, v2, :cond_0

    move v0, v1

    goto :goto_0
.end method

.method static keysHeight(II)I
    .locals 2

    .prologue
    .line 111
    if-lez p0, :cond_0

    if-gtz p1, :cond_1

    .line 112
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
    .line 117
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBottom;->gapPx(Landroid/content/Context;)I

    move-result v0

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrBottom;->keysHeight(II)I

    move-result v0

    return v0
.end method

.method private static resourceMode()I
    .locals 5

    .prologue
    const/4 v0, -0x1

    .line 83
    :try_start_0
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v1

    .line 84
    const-string v2, "config_navBarInteractionMode"

    const-string v3, "integer"

    const-string v4, "android"

    invoke-virtual {v1, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 85
    if-nez v2, :cond_0

    .line 87
    :goto_0
    return v0

    .line 85
    :cond_0
    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getInteger(I)I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 86
    :catch_0
    move-exception v1

    goto :goto_0
.end method
