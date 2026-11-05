.class public Lcom/mrkeyboard/app/PrefScreenAdvanced;
.super Landroid/preference/PreferenceActivity;
.source "PrefScreenAdvanced.java"

# interfaces
.implements Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Landroid/preference/PreferenceActivity;-><init>()V

    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 0

    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object p1

    invoke-super {p0, p1}, Landroid/preference/PreferenceActivity;->attachBaseContext(Landroid/content/Context;)V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    .line 29
    invoke-super {p0, p1}, Landroid/preference/PreferenceActivity;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0c01b7

    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/PrefScreenAdvanced;->setTitle(I)V

    const p1, 0x7f0f0021

    .line 30
    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/PrefScreenAdvanced;->addPreferencesFromResource(I)V

    invoke-static {p0}, Lcom/mrkeyboard/app/ListDividerFix;->apply(Landroid/preference/PreferenceActivity;)V

    .line 31
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenAdvanced;->getPreferenceManager()Landroid/preference/PreferenceManager;

    move-result-object p1

    invoke-virtual {p1}, Landroid/preference/PreferenceManager;->getSharedPreferences()Landroid/content/SharedPreferences;

    move-result-object p1

    .line 32
    invoke-interface {p1, p0}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    return-void
.end method

.method protected onDestroy()V
    .locals 1

    .line 37
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenAdvanced;->getPreferenceManager()Landroid/preference/PreferenceManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/preference/PreferenceManager;->getSharedPreferences()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0, p0}, Landroid/content/SharedPreferences;->unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 39
    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onDestroy()V

    return-void
.end method

# The row "Keyboard drawing" says what MrAccel measured on the keyboard window (it can change while this screen is away).
.method protected onResume()V
    .locals 0

    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onResume()V

    invoke-static {p0}, Lcom/mrkeyboard/app/MrAccel;->fill(Landroid/preference/PreferenceActivity;)V

    return-void
.end method

.method public onSharedPreferenceChanged(Landroid/content/SharedPreferences;Ljava/lang/String;)V
    .locals 0

    .line 43
    new-instance p1, Landroid/app/backup/BackupManager;

    invoke-direct {p1, p0}, Landroid/app/backup/BackupManager;-><init>(Landroid/content/Context;)V

    invoke-virtual {p1}, Landroid/app/backup/BackupManager;->dataChanged()V

    # The acceleration is read when the window is created: this screen is created again to take the new value (MrScreens).
    invoke-static {p0, p2}, Lcom/mrkeyboard/app/MrScreens;->onSetting(Landroid/app/Activity;Ljava/lang/String;)V

    return-void
.end method
