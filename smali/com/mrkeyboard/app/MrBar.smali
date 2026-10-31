.class public final Lcom/mrkeyboard/app/MrBar;
.super Ljava/lang/Object;
.source "MrBar.java"


# static fields
.field static final BASE_DP:F = 48.0f

.field static final KEY:Ljava/lang/String; = "pref_bar_scale"

.field static final MAX:F = 1.5f

.field static final MIN:F = 0.6f

.field private static sBar:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference",
            "<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private static final sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

.field private static sRegistered:Landroid/content/SharedPreferences;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 26
    new-instance v0, Lcom/mrkeyboard/app/MrBar$1;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrBar$1;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrBar;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Ljava/lang/ref/WeakReference;
    .locals 1

    .prologue
    .line 16
    sget-object v0, Lcom/mrkeyboard/app/MrBar;->sBar:Ljava/lang/ref/WeakReference;

    return-object v0
.end method

.method static apply(Landroid/view/View;)V
    .locals 5

    .prologue
    .line 68
    invoke-virtual {p0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    .line 69
    if-nez v0, :cond_1

    .line 77
    :cond_0
    :goto_0
    return-void

    .line 70
    :cond_1
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    .line 71
    invoke-static {v1}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    const-string v3, "pref_bar_scale"

    const/4 v4, 0x0

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 72
    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->density:F

    invoke-static {v2}, Lcom/mrkeyboard/app/MrBar;->scale(Ljava/lang/String;)F

    move-result v2

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrBar;->heightPx(FF)I

    move-result v1

    .line 73
    iget v2, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    if-eq v2, v1, :cond_0

    .line 74
    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    .line 75
    invoke-virtual {p0, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0
.end method

.method public static attach(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 37
    if-nez p0, :cond_0

    .line 46
    :goto_0
    return-void

    .line 38
    :cond_0
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/mrkeyboard/app/MrBar;->sBar:Ljava/lang/ref/WeakReference;

    .line 39
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 40
    sget-object v1, Lcom/mrkeyboard/app/MrBar;->sRegistered:Landroid/content/SharedPreferences;

    if-eq v1, v0, :cond_2

    .line 41
    sget-object v1, Lcom/mrkeyboard/app/MrBar;->sRegistered:Landroid/content/SharedPreferences;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/mrkeyboard/app/MrBar;->sRegistered:Landroid/content/SharedPreferences;

    sget-object v2, Lcom/mrkeyboard/app/MrBar;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v1, v2}, Landroid/content/SharedPreferences;->unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 42
    :cond_1
    sget-object v1, Lcom/mrkeyboard/app/MrBar;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 43
    sput-object v0, Lcom/mrkeyboard/app/MrBar;->sRegistered:Landroid/content/SharedPreferences;

    .line 45
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBar;->apply(Landroid/view/View;)V

    goto :goto_0
.end method

.method static heightPx(FF)I
    .locals 1

    .prologue
    .line 64
    const/high16 v0, 0x42400000    # 48.0f

    mul-float/2addr v0, p0

    mul-float/2addr v0, p1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    return v0
.end method

.method static scale(Ljava/lang/String;)F
    .locals 3

    .prologue
    const/high16 v0, 0x3f800000    # 1.0f

    .line 50
    .line 51
    if-eqz p0, :cond_1

    .line 53
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 58
    :goto_0
    cmpl-float v2, v1, v1

    if-eqz v2, :cond_0

    .line 59
    :goto_1
    const v1, 0x3f19999a    # 0.6f

    const/high16 v2, 0x3fc00000    # 1.5f

    invoke-static {v2, v0}, Ljava/lang/Math;->min(FF)F

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    return v0

    .line 54
    :catch_0
    move-exception v1

    move v1, v0

    .line 55
    goto :goto_0

    :cond_0
    move v0, v1

    goto :goto_1

    :cond_1
    move v1, v0

    goto :goto_0
.end method
