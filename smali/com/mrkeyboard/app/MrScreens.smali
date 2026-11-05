.class public final Lcom/mrkeyboard/app/MrScreens;
.super Ljava/lang/Object;
.source "MrScreens.java"

# interfaces
.implements Landroid/app/Application$ActivityLifecycleCallbacks;
.implements Landroid/view/View$OnApplyWindowInsetsListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrScreens$DialogFit;,
        Lcom/mrkeyboard/app/MrScreens$Api30;
    }
.end annotation


# static fields
.field static final CONTENT:I = 0x1020002

.field static final EDGE_TO_EDGE_SDK:I = 0x23

.field private static final HELPERS:[Ljava/lang/String;

.field static final INSETS_API_SDK:I = 0x1e

.field static final KEY_HW_ACCEL:Ljava/lang/String; = "pref_ui_hw_accel"


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 45
    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "com.google.android.voiceime.ActivityHelper"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "com.mrkeyboard.app.ShotPerm"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "com.mrkeyboard.app.ShotPick"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrScreens;->HELPERS:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static accelerates(Landroid/app/Activity;)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 70
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrScreens;->isHelper(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 74
    :goto_0
    return v0

    .line 72
    :cond_0
    :try_start_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v2, "pref_ui_hw_accel"

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 73
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public static fitDialog(Landroid/view/View;Landroid/view/View;)V
    .locals 2

    .prologue
    .line 88
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-ge v0, v1, :cond_1

    .line 91
    :cond_0
    :goto_0
    return-void

    .line 89
    :cond_1
    new-instance v0, Lcom/mrkeyboard/app/MrScreens$DialogFit;

    invoke-direct {v0, p1}, Lcom/mrkeyboard/app/MrScreens$DialogFit;-><init>(Landroid/view/View;)V

    invoke-virtual {p0, v0}, Landroid/view/View;->setOnApplyWindowInsetsListener(Landroid/view/View$OnApplyWindowInsetsListener;)V

    .line 90
    invoke-virtual {p0}, Landroid/view/View;->requestApplyInsets()V

    goto :goto_0
.end method

.method public static install(Landroid/app/Application;)V
    .locals 1

    .prologue
    .line 50
    if-nez p0, :cond_0

    .line 52
    :goto_0
    return-void

    .line 51
    :cond_0
    new-instance v0, Lcom/mrkeyboard/app/MrScreens;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrScreens;-><init>()V

    invoke-virtual {p0, v0}, Landroid/app/Application;->registerActivityLifecycleCallbacks(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    goto :goto_0
.end method

.method static isHelper(Ljava/lang/String;)Z
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 64
    sget-object v2, Lcom/mrkeyboard/app/MrScreens;->HELPERS:[Ljava/lang/String;

    array-length v3, v2

    move v1, v0

    :goto_0
    if-ge v1, v3, :cond_0

    aget-object v4, v2, v1

    invoke-virtual {v4, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/4 v0, 0x1

    .line 65
    :cond_0
    return v0

    .line 64
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method public static onSetting(Landroid/app/Activity;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 59
    if-eqz p0, :cond_0

    const-string v0, "pref_ui_hw_accel"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/app/Activity;->recreate()V

    .line 60
    :cond_0
    return-void
.end method


# virtual methods
.method public onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 2

    .prologue
    const/high16 v1, 0x1000000

    .line 107
    invoke-static {p1}, Lcom/mrkeyboard/app/MrScreens;->accelerates(Landroid/app/Activity;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 113
    :cond_0
    :goto_0
    return-void

    .line 108
    :cond_1
    invoke-virtual {p1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v0

    .line 109
    if-eqz v0, :cond_0

    .line 110
    invoke-virtual {v0, v1, v1}, Landroid/view/Window;->setFlags(II)V

    goto :goto_0
.end method

.method public onActivityDestroyed(Landroid/app/Activity;)V
    .locals 0

    .prologue
    .line 123
    return-void
.end method

.method public onActivityPaused(Landroid/app/Activity;)V
    .locals 0

    .prologue
    .line 117
    return-void
.end method

.method public onActivityResumed(Landroid/app/Activity;)V
    .locals 0

    .prologue
    .line 115
    return-void
.end method

.method public onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 0

    .prologue
    .line 121
    return-void
.end method

.method public onActivityStarted(Landroid/app/Activity;)V
    .locals 2

    .prologue
    .line 94
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x23

    if-ge v0, v1, :cond_1

    .line 99
    :cond_0
    :goto_0
    return-void

    .line 95
    :cond_1
    const v0, 0x1020002

    invoke-virtual {p1, v0}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    .line 96
    if-eqz v0, :cond_0

    .line 97
    invoke-virtual {v0, p0}, Landroid/view/View;->setOnApplyWindowInsetsListener(Landroid/view/View$OnApplyWindowInsetsListener;)V

    .line 98
    invoke-virtual {v0}, Landroid/view/View;->requestApplyInsets()V

    goto :goto_0
.end method

.method public onActivityStopped(Landroid/app/Activity;)V
    .locals 0

    .prologue
    .line 119
    return-void
.end method

.method public onApplyWindowInsets(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .locals 2

    .prologue
    .line 102
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-ge v0, v1, :cond_0

    .line 103
    :goto_0
    return-object p2

    :cond_0
    invoke-static {p1, p2}, Lcom/mrkeyboard/app/MrScreens$Api30;->fit(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;

    move-result-object p2

    goto :goto_0
.end method
