.class public Lcom/mrkeyboard/app/LatinIMESettings;
.super Landroid/preference/PreferenceActivity;
.source "LatinIMESettings.java"

# interfaces
.implements Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;
.implements Landroid/content/DialogInterface$OnDismissListener;

# static fields
.field static final INPUT_CONNECTION_INFO:Ljava/lang/String; = "input_connection_info"

.field private static final PREDICTION_SETTINGS_KEY:Ljava/lang/String; = "prediction_settings"

.field private static final QUICK_FIXES_KEY:Ljava/lang/String; = "quick_fixes"

.field private static final TAG:Ljava/lang/String; = "LatinIMESettings"

.field private static final VOICE_INPUT_CONFIRM_DIALOG:I = 0x0

.field private static final VOICE_SETTINGS_KEY:Ljava/lang/String; = "voice_mode"

# instance fields
.field private mKeyboardModeLandscapePreference:Landroid/preference/ListPreference;

.field private mKeyboardModePortraitPreference:Landroid/preference/ListPreference;

.field private mLabelVersion:Landroid/preference/Preference;

.field private mOkClicked:Z

.field private mQuickFixes:Landroid/preference/CheckBoxPreference;

.field private mVoiceModeOff:Ljava/lang/String;

.field private mVoiceOn:Z

.field private mVoicePreference:Landroid/preference/ListPreference;

# direct methods

.method public constructor <init>()V
    .locals 1

    .line 40
    invoke-direct {p0}, Landroid/preference/PreferenceActivity;-><init>()V

    const/4 v0, 0x0

    .line 65
    iput-boolean v0, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mOkClicked:Z

    return-void
.end method

.method private requestNotificationPermissionIfNeeded(Landroid/content/SharedPreferences;)V
    .locals 4

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    if-lt v0, v1, :cond_end

    const-string v0, "keyboard_notification"

    const/4 v1, 0x0

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_end

    const-string v0, "android.permission.POST_NOTIFICATIONS"

    invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_end

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    aput-object v0, v1, v2

    const/16 v2, 0x2a

    invoke-virtual {p0, v1, v2}, Landroid/app/Activity;->requestPermissions([Ljava/lang/String;I)V

    :cond_end
    return-void
.end method

.method private showVoiceConfirmation()V
    .locals 1

    const/4 v0, 0x0

    .line 256
    iput-boolean v0, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mOkClicked:Z

    .line 257
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinIMESettings;->showDialog(I)V

    return-void
.end method

.method private updateSummaries()V
    .locals 0

    # v1.69: no summary for the settings key (it became a switch) nor connection details (removed)
    return-void
.end method

.method private updateVoiceModeSummary()V
    .locals 4

    .line 261
    iget-object v0, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoicePreference:Landroid/preference/ListPreference;

    .line 262
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIMESettings;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f02001d

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoicePreference:Landroid/preference/ListPreference;

    iget-object v3, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoicePreference:Landroid/preference/ListPreference;

    .line 263
    invoke-virtual {v3}, Landroid/preference/ListPreference;->getValue()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/preference/ListPreference;->findIndexOfValue(Ljava/lang/String;)I

    move-result v2

    aget-object v1, v1, v2

    .line 261
    invoke-virtual {v0, v1}, Landroid/preference/ListPreference;->setSummary(Ljava/lang/CharSequence;)V

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
    .locals 2

    .line 70
    invoke-super {p0, p1}, Landroid/preference/PreferenceActivity;->onCreate(Landroid/os/Bundle;)V

    const v0, 0x7f0c0065

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinIMESettings;->setTitle(I)V

    const p1, 0x7f0f0018

    .line 71
    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/LatinIMESettings;->addPreferencesFromResource(I)V

    invoke-static {p0}, Lcom/mrkeyboard/app/ListDividerFix;->apply(Landroid/preference/PreferenceActivity;)V

    const-string p1, "quick_fixes"

    .line 72
    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/LatinIMESettings;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object p1

    check-cast p1, Landroid/preference/CheckBoxPreference;

    iput-object p1, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mQuickFixes:Landroid/preference/CheckBoxPreference;

    const-string p1, "voice_mode"

    .line 73
    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/LatinIMESettings;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object p1

    check-cast p1, Landroid/preference/ListPreference;

    iput-object p1, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoicePreference:Landroid/preference/ListPreference;

    const-string p1, "label_version"

    .line 76
    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/LatinIMESettings;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object p1

    iput-object p1, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mLabelVersion:Landroid/preference/Preference;

    const-string p1, "pref_keyboard_mode_portrait"

    .line 80
    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/LatinIMESettings;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object p1

    check-cast p1, Landroid/preference/ListPreference;

    iput-object p1, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mKeyboardModePortraitPreference:Landroid/preference/ListPreference;

    const-string p1, "pref_keyboard_mode_landscape"

    .line 81
    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/LatinIMESettings;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object p1

    check-cast p1, Landroid/preference/ListPreference;

    iput-object p1, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mKeyboardModeLandscapePreference:Landroid/preference/ListPreference;

    .line 83
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIMESettings;->getPreferenceManager()Landroid/preference/PreferenceManager;

    move-result-object p1

    invoke-virtual {p1}, Landroid/preference/PreferenceManager;->getSharedPreferences()Landroid/content/SharedPreferences;

    move-result-object p1

    .line 84
    invoke-interface {p1, p0}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    const v0, 0x7f0c01a6

    .line 86
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinIMESettings;->getString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoiceModeOff:Ljava/lang/String;

    const-string v0, "voice_mode"

    .line 87
    iget-object v1, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoiceModeOff:Ljava/lang/String;

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoiceModeOff:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    xor-int/lit8 p1, p1, 0x1

    iput-boolean p1, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoiceOn:Z

    # v1.69: "Restore defaults" (General)
    const-string v0, "mr_reset"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinIMESettings;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/MrReset;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrReset;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    # author card: opens GitHub without closing the app if there is no browser
    const-string v0, "mr_author"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinIMESettings;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    if-eqz v0, :cond_no_author

    new-instance v1, Lcom/mrkeyboard/app/MrAuthor;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrAuthor;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    :cond_no_author
    # v1.82: "Check for updates" line, switch and new-version notice on opening
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateUi;->bind(Landroid/preference/PreferenceActivity;)V

    return-void
.end method

.method protected onCreateDialog(I)Landroid/app/Dialog;
    .locals 3

    const-string v0, "LatinIMESettings"

    .line 270
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "unknown dialog "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 p1, 0x0

    return-object p1
.end method

.method protected onDestroy()V
    .locals 1

    .line 143
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIMESettings;->getPreferenceManager()Landroid/preference/PreferenceManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/preference/PreferenceManager;->getSharedPreferences()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0, p0}, Landroid/content/SharedPreferences;->unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    # v1.82: closes the new-version dialog with the screen
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateUi;->release(Landroid/app/Activity;)V

    .line 145
    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onDestroy()V

    return-void
.end method

.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 1

    .line 276
    iget-boolean p1, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mOkClicked:Z

    if-nez p1, :cond_0

    .line 279
    iget-object p1, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoicePreference:Landroid/preference/ListPreference;

    iget-object v0, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoiceModeOff:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/preference/ListPreference;->setValue(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method protected onResume()V
    .locals 12

    .line 92
    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onResume()V

    # v1.82.0: the line "Allow notifications" of the morning check follows the system settings (Java layer, MrUpdateUi)
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateUi;->resume(Landroid/preference/PreferenceActivity;)V

    # v1.67: "Quick corrections" moved to the Suggestions and dictionaries screen (MrPacksActivity),
    # which hides the option on its own when Android has no autotext for the language.
    # v1 = 1 came from the removed block and is used as an index further below.
    const/4 v1, 0x1

    const-string v0, "LatinIMESettings"

    .line 99
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "compactModeEnabled="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v3, Lcom/mrkeyboard/app/LatinIME;->sKeyboardSettings:Lcom/mrkeyboard/app/GlobalKeyboardSettings;

    iget-boolean v3, v3, Lcom/mrkeyboard/app/GlobalKeyboardSettings;->compactModeEnabled:Z

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 100
    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sKeyboardSettings:Lcom/mrkeyboard/app/GlobalKeyboardSettings;

    iget-boolean v0, v0, Lcom/mrkeyboard/app/GlobalKeyboardSettings;->compactModeEnabled:Z

    const/4 v2, 0x0

    if-nez v0, :cond_1

    .line 101
    iget-object v0, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mKeyboardModePortraitPreference:Landroid/preference/ListPreference;

    invoke-virtual {v0}, Landroid/preference/ListPreference;->getEntries()[Ljava/lang/CharSequence;

    move-result-object v0

    .line 102
    iget-object v3, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mKeyboardModePortraitPreference:Landroid/preference/ListPreference;

    invoke-virtual {v3}, Landroid/preference/ListPreference;->getEntryValues()[Ljava/lang/CharSequence;

    move-result-object v3

    .line 104
    array-length v4, v0

    const/4 v5, 0x2

    if-le v4, v5, :cond_1

    .line 105
    new-array v4, v5, [Ljava/lang/CharSequence;

    aget-object v6, v0, v2

    aput-object v6, v4, v2

    aget-object v0, v0, v5

    aput-object v0, v4, v1

    .line 106
    new-array v0, v5, [Ljava/lang/CharSequence;

    aget-object v6, v3, v2

    aput-object v6, v0, v2

    aget-object v3, v3, v5

    aput-object v3, v0, v1

    .line 107
    iget-object v3, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mKeyboardModePortraitPreference:Landroid/preference/ListPreference;

    invoke-virtual {v3, v4}, Landroid/preference/ListPreference;->setEntries([Ljava/lang/CharSequence;)V

    .line 108
    iget-object v3, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mKeyboardModePortraitPreference:Landroid/preference/ListPreference;

    invoke-virtual {v3, v0}, Landroid/preference/ListPreference;->setEntryValues([Ljava/lang/CharSequence;)V

    .line 109
    iget-object v3, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mKeyboardModeLandscapePreference:Landroid/preference/ListPreference;

    invoke-virtual {v3, v4}, Landroid/preference/ListPreference;->setEntries([Ljava/lang/CharSequence;)V

    .line 110
    iget-object v3, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mKeyboardModeLandscapePreference:Landroid/preference/ListPreference;

    invoke-virtual {v3, v0}, Landroid/preference/ListPreference;->setEntryValues([Ljava/lang/CharSequence;)V

    .line 114
    :cond_1
    invoke-direct {p0}, Lcom/mrkeyboard/app/LatinIMESettings;->updateSummaries()V

    const-string v0, ""

    .line 118
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIMESettings;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v3

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIMESettings;->getPackageName()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v3

    .line 119
    iget-object v4, v3, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_1

    .line 121
    :try_start_1
    const/4 v0, 0x0

    new-array v0, v0, [Landroid/content/pm/Signature;

    array-length v3, v0

    const/4 v5, 0x0

    const/4 v6, 0x0

    :goto_0
    if-ge v5, v3, :cond_4

    aget-object v7, v0, v5

    .line 122
    invoke-virtual {v7}, Landroid/content/pm/Signature;->toByteArray()[B

    move-result-object v7

    const/4 v8, 0x0

    const/4 v9, 0x0

    .line 124
    :goto_1
    array-length v10, v7

    if-ge v8, v10, :cond_2

    .line 125
    rem-int/lit8 v10, v8, 0x4

    .line 126
    aget-byte v11, v7, v8

    mul-int/lit8 v10, v10, 0x4

    shl-int v10, v11, v10

    xor-int/2addr v9, v10

    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    :cond_2
    const v7, -0x71f89

    if-ne v9, v7, :cond_3

    const/4 v6, 0x1

    :cond_3
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 133
    :cond_4
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    if-eqz v6, :cond_5

    const-string v1, " official"

    goto :goto_2

    :cond_5
    const-string v1, " custom"

    :goto_2
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_1
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_3

    :catch_0
    move-object v0, v4

    :catch_1
    const-string v1, "LatinIMESettings"

    const-string v2, "Could not find version info."

    .line 135
    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 138
    :goto_3
    iget-object v1, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mLabelVersion:Landroid/preference/Preference;

    invoke-virtual {v1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public onSharedPreferenceChanged(Landroid/content/SharedPreferences;Ljava/lang/String;)V
    .locals 1

    .line 149
    new-instance v0, Landroid/app/backup/BackupManager;

    invoke-direct {v0, p0}, Landroid/app/backup/BackupManager;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0}, Landroid/app/backup/BackupManager;->dataChanged()V

    const-string v0, "pref_ui_language"

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_ui_lang

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIMESettings;->recreate()V

    return-void

    :cond_ui_lang
    const-string v0, "keyboard_notification"

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_not_notif

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/LatinIMESettings;->requestNotificationPermissionIfNeeded(Landroid/content/SharedPreferences;)V

    :cond_not_notif
    const-string v0, "voice_mode"

    .line 151
    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-boolean p2, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoiceOn:Z

    if-nez p2, :cond_0

    const-string p2, "voice_mode"

    .line 152
    iget-object v0, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoiceModeOff:Ljava/lang/String;

    invoke-interface {p1, p2, v0}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iget-object v0, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoiceModeOff:Ljava/lang/String;

    .line 153
    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_0

    .line 154
    invoke-direct {p0}, Lcom/mrkeyboard/app/LatinIMESettings;->showVoiceConfirmation()V

    :cond_0
    const-string p2, "voice_mode"

    .line 157
    iget-object v0, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoiceModeOff:Ljava/lang/String;

    invoke-interface {p1, p2, v0}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoiceModeOff:Ljava/lang/String;

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    xor-int/lit8 p1, p1, 0x1

    iput-boolean p1, p0, Lcom/mrkeyboard/app/LatinIMESettings;->mVoiceOn:Z

    .line 158
    invoke-direct {p0}, Lcom/mrkeyboard/app/LatinIMESettings;->updateVoiceModeSummary()V

    .line 159
    invoke-direct {p0}, Lcom/mrkeyboard/app/LatinIMESettings;->updateSummaries()V

    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 1

    invoke-super {p0, p1, p2, p3}, Landroid/preference/PreferenceActivity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    const/16 v0, 0x2a

    if-ne p1, v0, :cond_end

    if-eqz p3, :cond_end

    array-length v0, p3

    if-lez v0, :cond_end

    const/4 v0, 0x0

    aget v0, p3, v0

    if-eqz v0, :cond_end

    const v0, 0x7f0c01ca

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V

    :cond_end
    return-void
.end method
