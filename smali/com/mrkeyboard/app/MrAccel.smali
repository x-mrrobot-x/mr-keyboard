.class public final Lcom/mrkeyboard/app/MrAccel;
.super Ljava/lang/Object;
.source "MrAccel.java"


# static fields
.field static final ACCELERATED:I = 0x1

.field static final FLAG_HW:I = 0x1000000

.field static final KEY_ACCEL:Ljava/lang/String; = "kbd_accel"

.field static final KEY_SDK:Ljava/lang/String; = "kbd_sdk"

.field static final PREFS:Ljava/lang/String; = "mr_diag"

.field static final ROW:Ljava/lang/String; = "mr_kbd_accel"

.field static final ROW_SCREEN:Ljava/lang/String; = "mr_scr_accel"

.field static final SOFTWARE:I = 0x2

.field static final TAG:Ljava/lang/String; = "MrAccel"

.field static final UNKNOWN:I

.field private static sLogged:Z


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static fill(Landroid/preference/PreferenceActivity;)V
    .locals 0

    .prologue
    .line 102
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAccel;->fillKeyboard(Landroid/preference/PreferenceActivity;)V

    .line 103
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAccel;->fillScreen(Landroid/preference/PreferenceActivity;)V

    .line 104
    return-void
.end method

.method static fillKeyboard(Landroid/preference/PreferenceActivity;)V
    .locals 3

    .prologue
    .line 109
    :try_start_0
    const-string v0, "mr_kbd_accel"

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 110
    if-nez v0, :cond_1

    .line 116
    :cond_0
    :goto_0
    return-void

    .line 111
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAccel;->state(Landroid/content/Context;)I

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAccel;->textName(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 112
    if-eqz v1, :cond_0

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 113
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static fillScreen(Landroid/preference/PreferenceActivity;)V
    .locals 3

    .prologue
    .line 125
    :try_start_0
    const-string v0, "mr_scr_accel"

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v1

    .line 126
    invoke-virtual {p0}, Landroid/preference/PreferenceActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    .line 127
    if-nez v0, :cond_1

    const/4 v0, 0x0

    .line 128
    :goto_0
    if-eqz v1, :cond_0

    if-nez v0, :cond_2

    .line 135
    :cond_0
    :goto_1
    return-void

    .line 127
    :cond_1
    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    goto :goto_0

    .line 129
    :cond_2
    new-instance v2, Lcom/mrkeyboard/app/MrAccel$2;

    invoke-direct {v2, p0, v1, v0}, Lcom/mrkeyboard/app/MrAccel$2;-><init>(Landroid/preference/PreferenceActivity;Landroid/preference/Preference;Landroid/view/View;)V

    invoke-virtual {v0, v2}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 132
    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method static log(Landroid/view/View;)V
    .locals 4

    .prologue
    .line 68
    sget-boolean v0, Lcom/mrkeyboard/app/MrAccel;->sLogged:Z

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/view/View;->isAttachedToWindow()Z

    move-result v0

    if-nez v0, :cond_1

    .line 80
    :cond_0
    :goto_0
    return-void

    .line 69
    :cond_1
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrAccel;->sLogged:Z

    .line 70
    invoke-virtual {p0}, Landroid/view/View;->isHardwareAccelerated()Z

    move-result v0

    .line 71
    const-string v1, "MrAccel"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "keyboard window hardwareAccelerated="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " (SDK "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 73
    :try_start_0
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    .line 74
    if-eqz v1, :cond_0

    .line 75
    const-string v2, "mr_diag"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "kbd_accel"

    .line 76
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "kbd_sdk"

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 77
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static logged()Z
    .locals 1

    .prologue
    .line 158
    sget-boolean v0, Lcom/mrkeyboard/app/MrAccel;->sLogged:Z

    return v0
.end method

.method public static onShown(Landroid/inputmethodservice/InputMethodService;)V
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 52
    sget-boolean v1, Lcom/mrkeyboard/app/MrAccel;->sLogged:Z

    if-nez v1, :cond_0

    if-nez p0, :cond_1

    .line 64
    :cond_0
    :goto_0
    return-void

    .line 54
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Landroid/inputmethodservice/InputMethodService;->getWindow()Landroid/app/Dialog;

    move-result-object v1

    .line 55
    if-nez v1, :cond_2

    move-object v1, v0

    .line 56
    :goto_1
    if-nez v1, :cond_3

    .line 57
    :goto_2
    if-eqz v0, :cond_0

    .line 58
    new-instance v1, Lcom/mrkeyboard/app/MrAccel$1;

    invoke-direct {v1, v0}, Lcom/mrkeyboard/app/MrAccel$1;-><init>(Landroid/view/View;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    .line 61
    :catch_0
    move-exception v0

    goto :goto_0

    .line 55
    :cond_2
    invoke-virtual {v1}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    goto :goto_1

    .line 56
    :cond_3
    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_2
.end method

.method static reset()V
    .locals 1

    .prologue
    .line 160
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrAccel;->sLogged:Z

    return-void
.end method

.method static screenTextName(ZZ)Ljava/lang/String;
    .locals 1

    .prologue
    .line 153
    if-eqz p1, :cond_1

    if-eqz p0, :cond_0

    const-string v0, "mr_ui_scr_accel_asked"

    .line 154
    :goto_0
    return-object v0

    .line 153
    :cond_0
    const-string v0, "mr_ui_scr_accel_system"

    goto :goto_0

    .line 154
    :cond_1
    if-eqz p0, :cond_2

    const-string v0, "mr_ui_scr_accel_refused"

    goto :goto_0

    :cond_2
    const-string v0, "mr_ui_scr_accel_off"

    goto :goto_0
.end method

.method static showScreen(Landroid/preference/PreferenceActivity;Landroid/preference/Preference;Landroid/view/View;)V
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 139
    :try_start_0
    invoke-virtual {p2}, Landroid/view/View;->isAttachedToWindow()Z

    move-result v1

    if-nez v1, :cond_1

    .line 149
    :cond_0
    :goto_0
    return-void

    .line 140
    :cond_1
    invoke-virtual {p0}, Landroid/preference/PreferenceActivity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    .line 141
    if-eqz v1, :cond_2

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    const/high16 v2, 0x1000000

    and-int/2addr v1, v2

    if-eqz v1, :cond_2

    const/4 v0, 0x1

    .line 142
    :cond_2
    invoke-virtual {p2}, Landroid/view/View;->isHardwareAccelerated()Z

    move-result v1

    .line 143
    const-string v2, "MrAccel"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " window asked="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " given="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " (SDK "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ")"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 144
    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAccel;->screenTextName(ZZ)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 145
    if-eqz v0, :cond_0

    invoke-virtual {p1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 146
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static state(Landroid/content/Context;)I
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 85
    :try_start_0
    const-string v1, "mr_diag"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 86
    const-string v2, "kbd_sdk"

    const/4 v3, -0x1

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v2

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ne v2, v3, :cond_0

    invoke-interface {v1}, Landroid/content/SharedPreferences;->getAll()Ljava/util/Map;

    move-result-object v2

    const-string v3, "kbd_accel"

    invoke-interface {v2, v3}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 89
    :cond_0
    :goto_0
    return v0

    .line 87
    :cond_1
    const-string v2, "kbd_accel"

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x1

    goto :goto_0

    :cond_2
    const/4 v0, 0x2

    goto :goto_0

    .line 88
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static textName(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 95
    const/4 v0, 0x1

    if-ne p0, v0, :cond_0

    const-string v0, "mr_ui_kbd_accel_on"

    .line 97
    :goto_0
    return-object v0

    .line 96
    :cond_0
    const/4 v0, 0x2

    if-ne p0, v0, :cond_1

    const-string v0, "mr_ui_kbd_accel_off"

    goto :goto_0

    .line 97
    :cond_1
    const-string v0, "mr_ui_kbd_accel_unknown"

    goto :goto_0
.end method
