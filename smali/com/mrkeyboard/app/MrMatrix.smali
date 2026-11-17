.class final Lcom/mrkeyboard/app/MrMatrix;
.super Ljava/lang/Object;
.source "MrMatrix.java"


# static fields
.field static final GLASS:Ljava/lang/String; = "MrMatrixGlass"

.field static final GLASS_DIALOG:Ljava/lang/String; = "Theme.MrKeyboard.Dialog.Glass"

.field static final KEY:Ljava/lang/String; = "pref_ui_matrix"


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static attach(Landroid/app/Activity;)Z
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 86
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v1

    .line 87
    if-nez v1, :cond_0

    .line 96
    :goto_0
    return v0

    .line 88
    :cond_0
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    .line 89
    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    .line 90
    const-string v4, "mr_ui_bg"

    const-string v5, "color"

    invoke-virtual {v2, v4, v5, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v2, v4}, Landroid/content/res/Resources;->getColor(I)I

    move-result v4

    .line 91
    const-string v5, "mr_accent"

    const-string v6, "color"

    invoke-virtual {v2, v5, v6, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getColor(I)I

    move-result v3

    .line 92
    new-instance v5, Lcom/mrkeyboard/app/MrRainDrawable;

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    iget v2, v2, Landroid/util/DisplayMetrics;->density:F

    invoke-direct {v5, v4, v3, v2}, Lcom/mrkeyboard/app/MrRainDrawable;-><init>(IIF)V

    invoke-virtual {v1, v5}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 93
    invoke-static {p0}, Lcom/mrkeyboard/app/MrMatrix;->glass(Landroid/app/Activity;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 94
    const/4 v0, 0x1

    goto :goto_0

    .line 95
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static dialogTheme(Landroid/app/Activity;I)I
    .locals 4

    .prologue
    .line 60
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrMatrix;->wanted(Landroid/app/Activity;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 64
    :cond_0
    :goto_0
    return p1

    .line 61
    :cond_1
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "Theme.MrKeyboard.Dialog.Glass"

    const-string v2, "style"

    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 62
    if-eqz v0, :cond_0

    move p1, v0

    goto :goto_0

    .line 63
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static eligible(Landroid/app/Activity;)Z
    .locals 1

    .prologue
    .line 31
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrScreens;->isHelper(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static enabled(Landroid/content/Context;)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 37
    :try_start_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v2, "pref_ui_matrix"

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 39
    :goto_0
    return v0

    .line 38
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static glass(Landroid/app/Activity;)V
    .locals 5

    .prologue
    .line 75
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v0

    .line 76
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "MrMatrixGlass"

    const-string v3, "style"

    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 77
    if-eqz v0, :cond_0

    if-eqz v1, :cond_0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/content/res/Resources$Theme;->applyStyle(IZ)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 81
    :cond_0
    :goto_0
    return-void

    .line 78
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static wanted(Landroid/app/Activity;)Z
    .locals 1

    .prologue
    .line 45
    invoke-static {p0}, Lcom/mrkeyboard/app/MrMatrix;->eligible(Landroid/app/Activity;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrMatrix;->enabled(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
