.class final Lcom/mrkeyboard/app/MrUpdateUi;
.super Ljava/lang/Object;
.source "MrUpdateUi.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrUpdateUi$Check;,
        Lcom/mrkeyboard/app/MrUpdateUi$Auto;,
        Lcom/mrkeyboard/app/MrUpdateUi$Morning;,
        Lcom/mrkeyboard/app/MrUpdateUi$Notif;
    }
.end annotation


# static fields
.field private static final ANDROID_13:I = 0x21

.field static final EXTRA_SHOW:Ljava/lang/String; = "mr_update_show"

.field static final POST_NOTIFICATIONS:Ljava/lang/String; = "android.permission.POST_NOTIFICATIONS"

.field static final REQUEST_NOTIFICATIONS:I = 0x71c

.field private static sChecking:Z

.field private static sNotifGroup:Landroid/preference/PreferenceGroup;

.field private static sNotifRow:Landroid/preference/Preference;

.field private static sNotifShown:Z

.field private static sOwner:Landroid/app/Activity;


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$002(Z)Z
    .locals 0

    .prologue
    .line 27
    sput-boolean p0, Lcom/mrkeyboard/app/MrUpdateUi;->sChecking:Z

    return p0
.end method

.method static synthetic access$100(Landroid/app/Activity;Landroid/preference/Preference;Lcom/mrkeyboard/app/MrUpdate$Result;)V
    .locals 0

    .prologue
    .line 27
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrUpdateUi;->answer(Landroid/app/Activity;Landroid/preference/Preference;Lcom/mrkeyboard/app/MrUpdate$Result;)V

    return-void
.end method

.method static synthetic access$200(Landroid/app/Activity;Landroid/preference/Preference;)V
    .locals 0

    .prologue
    .line 27
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrUpdateUi;->check(Landroid/app/Activity;Landroid/preference/Preference;)V

    return-void
.end method

.method static synthetic access$300(Landroid/app/Activity;)V
    .locals 0

    .prologue
    .line 27
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateUi;->refreshNotif(Landroid/app/Activity;)V

    return-void
.end method

.method static synthetic access$400(Landroid/app/Activity;)V
    .locals 0

    .prologue
    .line 27
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateUi;->refreshRow(Landroid/app/Activity;)V

    return-void
.end method

.method private static answer(Landroid/app/Activity;Landroid/preference/Preference;Lcom/mrkeyboard/app/MrUpdate$Result;)V
    .locals 4

    .prologue
    const/4 v2, 0x1

    .line 173
    :try_start_0
    iget v0, p2, Lcom/mrkeyboard/app/MrUpdate$Result;->status:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p2, Lcom/mrkeyboard/app/MrUpdate$Result;->notice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    if-eqz v0, :cond_0

    .line 174
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrUpdateUi;->showKnown(Landroid/app/Activity;Landroid/preference/Preference;)V

    .line 175
    iget-object v0, p2, Lcom/mrkeyboard/app/MrUpdate$Result;->notice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrUpdateDialog;->show(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    .line 187
    :goto_0
    return-void

    .line 176
    :cond_0
    iget v0, p2, Lcom/mrkeyboard/app/MrUpdate$Result;->status:I

    if-ne v0, v2, :cond_1

    .line 177
    const-string v0, "mr_update_sum_uptodate"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->appName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 184
    :catch_0
    move-exception v0

    goto :goto_0

    .line 178
    :cond_1
    iget v0, p2, Lcom/mrkeyboard/app/MrUpdate$Result;->status:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_2

    .line 179
    iget v0, p2, Lcom/mrkeyboard/app/MrUpdate$Result;->error:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdate;->errorKey(I)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget v3, p2, Lcom/mrkeyboard/app/MrUpdate$Result;->httpCode:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 180
    const-string v1, "mr_update_sum_error"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 182
    :cond_2
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrUpdateUi;->showKnown(Landroid/app/Activity;Landroid/preference/Preference;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0
.end method

.method static askNotifications(Landroid/app/Activity;Z)Z
    .locals 5

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 110
    :try_start_0
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x21

    if-lt v2, v3, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->morning(Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateNotify;->enabled(Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 116
    :cond_0
    :goto_0
    return v0

    .line 111
    :cond_1
    if-nez p1, :cond_2

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->asked(Landroid/content/Context;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 112
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->setAsked(Landroid/content/Context;)V

    .line 113
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "android.permission.POST_NOTIFICATIONS"

    aput-object v4, v2, v3

    const/16 v3, 0x71c

    invoke-virtual {p0, v2, v3}, Landroid/app/Activity;->requestPermissions([Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move v0, v1

    .line 114
    goto :goto_0

    .line 115
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static bind(Landroid/preference/PreferenceActivity;)V
    .locals 4

    .prologue
    .line 50
    :try_start_0
    const-string v1, "mr_update"

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v1

    .line 51
    if-eqz v1, :cond_0

    .line 52
    new-instance v2, Lcom/mrkeyboard/app/MrUpdateUi$Check;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrUpdateUi$Check;-><init>(Landroid/preference/PreferenceActivity;)V

    invoke-virtual {v1, v2}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 53
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrUpdateUi;->showKnown(Landroid/app/Activity;Landroid/preference/Preference;)V

    .line 55
    :cond_0
    const-string v1, "mr_update_auto"

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v2

    .line 56
    instance-of v1, v2, Landroid/preference/CheckBoxPreference;

    if-eqz v1, :cond_1

    .line 57
    move-object v0, v2

    check-cast v0, Landroid/preference/CheckBoxPreference;

    move-object v1, v0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->auto(Landroid/content/Context;)Z

    move-result v3

    invoke-virtual {v1, v3}, Landroid/preference/CheckBoxPreference;->setChecked(Z)V

    .line 58
    new-instance v1, Lcom/mrkeyboard/app/MrUpdateUi$Auto;

    invoke-virtual {p0}, Landroid/preference/PreferenceActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v1, v3}, Lcom/mrkeyboard/app/MrUpdateUi$Auto;-><init>(Landroid/content/Context;)V

    invoke-virtual {v2, v1}, Landroid/preference/Preference;->setOnPreferenceChangeListener(Landroid/preference/Preference$OnPreferenceChangeListener;)V

    .line 60
    :cond_1
    const-string v1, "mr_update_morning"

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v2

    .line 61
    instance-of v1, v2, Landroid/preference/CheckBoxPreference;

    if-eqz v1, :cond_2

    .line 62
    move-object v0, v2

    check-cast v0, Landroid/preference/CheckBoxPreference;

    move-object v1, v0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->morning(Landroid/content/Context;)Z

    move-result v3

    invoke-virtual {v1, v3}, Landroid/preference/CheckBoxPreference;->setChecked(Z)V

    .line 63
    new-instance v1, Lcom/mrkeyboard/app/MrUpdateUi$Morning;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrUpdateUi$Morning;-><init>(Landroid/preference/PreferenceActivity;)V

    invoke-virtual {v2, v1}, Landroid/preference/Preference;->setOnPreferenceChangeListener(Landroid/preference/Preference$OnPreferenceChangeListener;)V

    .line 65
    :cond_2
    const-string v1, "mr_update_notif"

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v2

    .line 66
    const-string v1, "debugging"

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v1

    .line 67
    if-eqz v2, :cond_3

    instance-of v3, v1, Landroid/preference/PreferenceGroup;

    if-eqz v3, :cond_3

    .line 68
    sput-object p0, Lcom/mrkeyboard/app/MrUpdateUi;->sOwner:Landroid/app/Activity;

    .line 69
    sput-object v2, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifRow:Landroid/preference/Preference;

    .line 70
    check-cast v1, Landroid/preference/PreferenceGroup;

    sput-object v1, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifGroup:Landroid/preference/PreferenceGroup;

    .line 71
    const/4 v1, 0x1

    sput-boolean v1, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifShown:Z

    .line 72
    new-instance v1, Lcom/mrkeyboard/app/MrUpdateUi$Notif;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrUpdateUi$Notif;-><init>(Landroid/preference/PreferenceActivity;)V

    invoke-virtual {v2, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 73
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateUi;->refreshNotif(Landroid/app/Activity;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 78
    :cond_3
    :goto_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateUi;->onOpen(Landroid/app/Activity;)V

    .line 79
    return-void

    .line 75
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static check(Landroid/app/Activity;Landroid/preference/Preference;)V
    .locals 3

    .prologue
    .line 139
    invoke-virtual {p0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 140
    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdate;->pending(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Notice;

    move-result-object v1

    .line 141
    if-eqz v1, :cond_1

    .line 142
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrUpdateDialog;->show(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    .line 168
    :cond_0
    :goto_0
    return-void

    .line 145
    :cond_1
    sget-boolean v1, Lcom/mrkeyboard/app/MrUpdateUi;->sChecking:Z

    if-nez v1, :cond_0

    .line 146
    const/4 v1, 0x1

    sput-boolean v1, Lcom/mrkeyboard/app/MrUpdateUi;->sChecking:Z

    .line 147
    const-string v1, "mr_update_sum_checking"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 148
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrUpdateUi$1;

    invoke-direct {v2, v0, p0, p1}, Lcom/mrkeyboard/app/MrUpdateUi$1;-><init>(Landroid/content/Context;Landroid/app/Activity;Landroid/preference/Preference;)V

    const-string v0, "mr-update-check"

    invoke-direct {v1, v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 167
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method static onOpen(Landroid/app/Activity;)V
    .locals 6

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 260
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v4

    .line 262
    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    const-string v3, "mr_update_show"

    const/4 v5, 0x0

    invoke-virtual {v2, v3, v5}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 263
    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    const-string v3, "mr_update_show"

    invoke-virtual {v2, v3}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    .line 264
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->pending(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Notice;

    move-result-object v2

    .line 265
    if-eqz v2, :cond_2

    .line 266
    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrUpdateDialog;->show(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    move v3, v0

    .line 271
    :goto_0
    if-nez v3, :cond_0

    const/4 v2, 0x0

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrUpdateUi;->askNotifications(Landroid/app/Activity;Z)Z

    move-result v2

    if-eqz v2, :cond_0

    move v2, v0

    .line 272
    :goto_1
    if-nez v3, :cond_1

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->auto(Landroid/content/Context;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 273
    :goto_2
    new-instance v1, Ljava/lang/Thread;

    new-instance v3, Lcom/mrkeyboard/app/MrUpdateUi$2;

    invoke-direct {v3, v4, v0, p0, v2}, Lcom/mrkeyboard/app/MrUpdateUi$2;-><init>(Landroid/content/Context;ZLandroid/app/Activity;Z)V

    const-string v0, "mr-update-open"

    invoke-direct {v1, v3, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 295
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 299
    :goto_3
    return-void

    :cond_0
    move v2, v1

    .line 271
    goto :goto_1

    :cond_1
    move v0, v1

    .line 272
    goto :goto_2

    .line 296
    :catch_0
    move-exception v0

    goto :goto_3

    :cond_2
    move v3, v1

    goto :goto_0
.end method

.method private static refreshNotif(Landroid/app/Activity;)V
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 92
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateUi;->sOwner:Landroid/app/Activity;

    if-ne v0, p0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifRow:Landroid/preference/Preference;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifGroup:Landroid/preference/PreferenceGroup;

    if-nez v0, :cond_1

    .line 101
    :cond_0
    :goto_0
    return-void

    .line 93
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->morning(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateNotify;->enabled(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_2

    move v0, v1

    .line 94
    :goto_1
    if-eqz v0, :cond_3

    sget-boolean v3, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifShown:Z

    if-nez v3, :cond_3

    .line 95
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifGroup:Landroid/preference/PreferenceGroup;

    sget-object v2, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifRow:Landroid/preference/Preference;

    invoke-virtual {v0, v2}, Landroid/preference/PreferenceGroup;->addPreference(Landroid/preference/Preference;)Z

    .line 96
    sput-boolean v1, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifShown:Z

    goto :goto_0

    :cond_2
    move v0, v2

    .line 93
    goto :goto_1

    .line 97
    :cond_3
    if-nez v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifShown:Z

    if-eqz v0, :cond_0

    .line 98
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifGroup:Landroid/preference/PreferenceGroup;

    sget-object v1, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifRow:Landroid/preference/Preference;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceGroup;->removePreference(Landroid/preference/Preference;)Z

    .line 99
    sput-boolean v2, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifShown:Z

    goto :goto_0
.end method

.method private static refreshRow(Landroid/app/Activity;)V
    .locals 2

    .prologue
    .line 132
    instance-of v0, p0, Landroid/preference/PreferenceActivity;

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrUpdateUi;->sChecking:Z

    if-eqz v0, :cond_1

    .line 135
    :cond_0
    :goto_0
    return-void

    :cond_1
    move-object v0, p0

    .line 133
    check-cast v0, Landroid/preference/PreferenceActivity;

    const-string v1, "mr_update"

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 134
    if-eqz v0, :cond_0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrUpdateUi;->showKnown(Landroid/app/Activity;Landroid/preference/Preference;)V

    goto :goto_0
.end method

.method static release(Landroid/app/Activity;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 303
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateUi;->sOwner:Landroid/app/Activity;

    if-ne v0, p0, :cond_0

    .line 304
    sput-object v1, Lcom/mrkeyboard/app/MrUpdateUi;->sOwner:Landroid/app/Activity;

    .line 305
    sput-object v1, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifRow:Landroid/preference/Preference;

    .line 306
    sput-object v1, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifGroup:Landroid/preference/PreferenceGroup;

    .line 307
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrUpdateUi;->sNotifShown:Z

    .line 309
    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateDialog;->release(Landroid/app/Activity;)V

    .line 310
    return-void
.end method

.method static resume(Landroid/preference/PreferenceActivity;)V
    .locals 1

    .prologue
    .line 84
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateUi;->refreshNotif(Landroid/app/Activity;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 88
    :goto_0
    return-void

    .line 85
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static showKnown(Landroid/app/Activity;Landroid/preference/Preference;)V
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 122
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->pending(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Notice;

    move-result-object v0

    .line 123
    if-eqz v0, :cond_0

    .line 124
    const-string v1, "mr_update_sum_available"

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionName:Ljava/lang/String;

    aput-object v0, v2, v3

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 128
    :goto_0
    return-void

    .line 126
    :cond_0
    const-string v0, "mr_update_check_sum"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->appName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v1, v3

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    goto :goto_0
.end method
