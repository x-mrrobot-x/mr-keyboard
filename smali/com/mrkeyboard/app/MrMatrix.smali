.class final Lcom/mrkeyboard/app/MrMatrix;
.super Ljava/lang/Object;
.source "MrMatrix.java"


# static fields
.field static final GLASS:Ljava/lang/String; = "MrMatrixGlass"

.field static final GLASS_DIALOG:Ljava/lang/String; = "Theme.MrKeyboard.Dialog.Glass"

.field static final KEY:Ljava/lang/String; = "pref_ui_matrix"

.field private static final RAIN:Ljava/util/WeakHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/WeakHashMap",
            "<",
            "Landroid/app/Activity;",
            "Lcom/mrkeyboard/app/MrRainDrawable;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 90
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrMatrix;->RAIN:Ljava/util/WeakHashMap;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static attach(Landroid/app/Activity;)Z
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 95
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v1

    .line 96
    if-nez v1, :cond_0

    .line 109
    :goto_0
    return v0

    .line 97
    :cond_0
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    .line 98
    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    .line 99
    const-string v4, "mr_ui_bg"

    const-string v5, "color"

    invoke-virtual {v2, v4, v5, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v2, v4}, Landroid/content/res/Resources;->getColor(I)I

    move-result v4

    .line 100
    const-string v5, "mr_accent"

    const-string v6, "color"

    invoke-virtual {v2, v5, v6, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getColor(I)I

    move-result v3

    .line 101
    new-instance v5, Lcom/mrkeyboard/app/MrRainDrawable;

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    iget v2, v2, Landroid/util/DisplayMetrics;->density:F

    invoke-direct {v5, v4, v3, v2}, Lcom/mrkeyboard/app/MrRainDrawable;-><init>(IIF)V

    .line 102
    invoke-virtual {v1, v5}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 103
    sget-object v2, Lcom/mrkeyboard/app/MrMatrix;->RAIN:Ljava/util/WeakHashMap;

    monitor-enter v2
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 104
    :try_start_1
    sget-object v1, Lcom/mrkeyboard/app/MrMatrix;->RAIN:Ljava/util/WeakHashMap;

    invoke-virtual {v1, p0, v5}, Ljava/util/WeakHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 105
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 106
    :try_start_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrMatrix;->glass(Landroid/app/Activity;)V
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0

    .line 107
    const/4 v0, 0x1

    goto :goto_0

    .line 105
    :catchall_0
    move-exception v1

    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw v1
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_0

    .line 108
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static dialogTheme(Landroid/app/Activity;I)I
    .locals 4

    .prologue
    .line 66
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrMatrix;->wanted(Landroid/app/Activity;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 70
    :cond_0
    :goto_0
    return p1

    .line 67
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

    .line 68
    if-eqz v0, :cond_0

    move p1, v0

    goto :goto_0

    .line 69
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static eligible(Landroid/app/Activity;)Z
    .locals 1

    .prologue
    .line 37
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
    .locals 3

    .prologue
    .line 43
    :try_start_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "pref_ui_matrix"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 45
    :goto_0
    return v0

    .line 44
    :catch_0
    move-exception v0

    .line 45
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static glass(Landroid/app/Activity;)V
    .locals 5

    .prologue
    .line 81
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v0

    .line 82
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "MrMatrixGlass"

    const-string v3, "style"

    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 83
    if-eqz v0, :cond_0

    if-eqz v1, :cond_0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/content/res/Resources$Theme;->applyStyle(IZ)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 87
    :cond_0
    :goto_0
    return-void

    .line 84
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static pause(Landroid/app/Activity;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 115
    invoke-static {p0}, Lcom/mrkeyboard/app/MrMatrix;->rainOf(Landroid/app/Activity;)Lcom/mrkeyboard/app/MrRainDrawable;

    move-result-object v0

    .line 116
    if-eqz v0, :cond_0

    invoke-virtual {v0, v1, v1}, Lcom/mrkeyboard/app/MrRainDrawable;->setVisible(ZZ)Z

    .line 117
    :cond_0
    return-void
.end method

.method private static rainOf(Landroid/app/Activity;)Lcom/mrkeyboard/app/MrRainDrawable;
    .locals 2

    .prologue
    .line 126
    if-nez p0, :cond_0

    const/4 v0, 0x0

    .line 128
    :goto_0
    return-object v0

    .line 127
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrMatrix;->RAIN:Ljava/util/WeakHashMap;

    monitor-enter v1

    .line 128
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrMatrix;->RAIN:Ljava/util/WeakHashMap;

    invoke-virtual {v0, p0}, Ljava/util/WeakHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrRainDrawable;

    monitor-exit v1

    goto :goto_0

    .line 129
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method static resume(Landroid/app/Activity;)V
    .locals 3

    .prologue
    .line 121
    invoke-static {p0}, Lcom/mrkeyboard/app/MrMatrix;->rainOf(Landroid/app/Activity;)Lcom/mrkeyboard/app/MrRainDrawable;

    move-result-object v0

    .line 122
    if-eqz v0, :cond_0

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrRainDrawable;->setVisible(ZZ)Z

    .line 123
    :cond_0
    return-void
.end method

.method static wanted(Landroid/app/Activity;)Z
    .locals 1

    .prologue
    .line 51
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
