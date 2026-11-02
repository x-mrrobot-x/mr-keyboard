.class public final Lcom/mrkeyboard/app/MrBar;
.super Ljava/lang/Object;
.source "MrBar.java"


# static fields
.field static final KEY:Ljava/lang/String; = "pref_bar_scale"

.field private static final sBars:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/ref/WeakReference",
            "<",
            "Landroid/view/View;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

.field private static sRegistered:Landroid/content/SharedPreferences;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 27
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrBar;->sBars:Ljava/util/ArrayList;

    .line 29
    new-instance v0, Lcom/mrkeyboard/app/MrBar$1;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrBar$1;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrBar;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Ljava/util/ArrayList;
    .locals 1

    .prologue
    .line 22
    sget-object v0, Lcom/mrkeyboard/app/MrBar;->sBars:Ljava/util/ArrayList;

    return-object v0
.end method

.method static apply(Landroid/view/View;)V
    .locals 6

    .prologue
    .line 84
    invoke-virtual {p0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    .line 85
    if-nez v0, :cond_1

    .line 96
    :cond_0
    :goto_0
    return-void

    .line 86
    :cond_1
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    .line 87
    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    .line 88
    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    .line 89
    invoke-static {v1}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v4, "pref_bar_scale"

    const/4 v5, 0x0

    invoke-interface {v1, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 90
    const-string v4, "mr_bar_scale_min"

    invoke-static {v2, v3, v4}, Lcom/mrkeyboard/app/MrBar;->number(Landroid/content/res/Resources;Ljava/lang/String;Ljava/lang/String;)F

    move-result v4

    const-string v5, "mr_bar_scale_max"

    invoke-static {v2, v3, v5}, Lcom/mrkeyboard/app/MrBar;->number(Landroid/content/res/Resources;Ljava/lang/String;Ljava/lang/String;)F

    move-result v5

    invoke-static {v1, v4, v5}, Lcom/mrkeyboard/app/MrBar;->scale(Ljava/lang/String;FF)F

    move-result v1

    .line 91
    const-string v4, "mr_bar_height"

    const-string v5, "dimen"

    invoke-virtual {v2, v4, v5, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v2

    invoke-static {v2, v1}, Lcom/mrkeyboard/app/MrBar;->heightPx(FF)I

    move-result v1

    .line 92
    iget v2, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    if-eq v2, v1, :cond_0

    .line 93
    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    .line 94
    invoke-virtual {p0, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0
.end method

.method public static attach(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 42
    if-nez p0, :cond_0

    .line 45
    :goto_0
    return-void

    .line 43
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrBar;->sBars:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 44
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBar;->attachExtra(Landroid/view/View;)V

    goto :goto_0
.end method

.method public static attachExtra(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 49
    if-nez p0, :cond_0

    .line 58
    :goto_0
    return-void

    .line 50
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrBar;->sBars:Ljava/util/ArrayList;

    new-instance v1, Ljava/lang/ref/WeakReference;

    invoke-direct {v1, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 51
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 52
    sget-object v1, Lcom/mrkeyboard/app/MrBar;->sRegistered:Landroid/content/SharedPreferences;

    if-eq v1, v0, :cond_2

    .line 53
    sget-object v1, Lcom/mrkeyboard/app/MrBar;->sRegistered:Landroid/content/SharedPreferences;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/mrkeyboard/app/MrBar;->sRegistered:Landroid/content/SharedPreferences;

    sget-object v2, Lcom/mrkeyboard/app/MrBar;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v1, v2}, Landroid/content/SharedPreferences;->unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 54
    :cond_1
    sget-object v1, Lcom/mrkeyboard/app/MrBar;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 55
    sput-object v0, Lcom/mrkeyboard/app/MrBar;->sRegistered:Landroid/content/SharedPreferences;

    .line 57
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBar;->apply(Landroid/view/View;)V

    goto :goto_0
.end method

.method static heightPx(FF)I
    .locals 1

    .prologue
    .line 76
    mul-float v0, p0, p1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    return v0
.end method

.method private static number(Landroid/content/res/Resources;Ljava/lang/String;Ljava/lang/String;)F
    .locals 1

    .prologue
    .line 80
    const-string v0, "string"

    invoke-virtual {p0, p2, v0, p1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v0

    return v0
.end method

.method static scale(Ljava/lang/String;FF)F
    .locals 3

    .prologue
    const/high16 v0, 0x3f800000    # 1.0f

    .line 62
    .line 63
    if-eqz p0, :cond_1

    .line 65
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 70
    :goto_0
    cmpl-float v2, v1, v1

    if-eqz v2, :cond_0

    .line 71
    :goto_1
    invoke-static {p2, v0}, Ljava/lang/Math;->min(FF)F

    move-result v0

    invoke-static {p1, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    return v0

    .line 66
    :catch_0
    move-exception v1

    move v1, v0

    .line 67
    goto :goto_0

    :cond_0
    move v0, v1

    goto :goto_1

    :cond_1
    move v1, v0

    goto :goto_0
.end method
