.class final Lcom/mrkeyboard/app/MrUpdateUi;
.super Ljava/lang/Object;
.source "MrUpdateUi.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrUpdateUi$Check;,
        Lcom/mrkeyboard/app/MrUpdateUi$Auto;
    }
.end annotation


# static fields
.field static final EXTRA_SHOW:Ljava/lang/String; = "mr_update_show"

.field private static sChecking:Z


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$002(Z)Z
    .locals 0

    .prologue
    .line 20
    sput-boolean p0, Lcom/mrkeyboard/app/MrUpdateUi;->sChecking:Z

    return p0
.end method

.method static synthetic access$100(Landroid/app/Activity;Landroid/preference/Preference;Lcom/mrkeyboard/app/MrUpdate$Result;)V
    .locals 0

    .prologue
    .line 20
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrUpdateUi;->answer(Landroid/app/Activity;Landroid/preference/Preference;Lcom/mrkeyboard/app/MrUpdate$Result;)V

    return-void
.end method

.method static synthetic access$200(Landroid/app/Activity;Landroid/preference/Preference;)V
    .locals 0

    .prologue
    .line 20
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrUpdateUi;->check(Landroid/app/Activity;Landroid/preference/Preference;)V

    return-void
.end method

.method static synthetic access$300(Landroid/app/Activity;)V
    .locals 0

    .prologue
    .line 20
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateUi;->refreshRow(Landroid/app/Activity;)V

    return-void
.end method

.method private static answer(Landroid/app/Activity;Landroid/preference/Preference;Lcom/mrkeyboard/app/MrUpdate$Result;)V
    .locals 4

    .prologue
    const/4 v2, 0x1

    .line 102
    :try_start_0
    iget v0, p2, Lcom/mrkeyboard/app/MrUpdate$Result;->status:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p2, Lcom/mrkeyboard/app/MrUpdate$Result;->notice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    if-eqz v0, :cond_0

    .line 103
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrUpdateUi;->showKnown(Landroid/app/Activity;Landroid/preference/Preference;)V

    .line 104
    iget-object v0, p2, Lcom/mrkeyboard/app/MrUpdate$Result;->notice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrUpdateDialog;->show(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    .line 116
    :goto_0
    return-void

    .line 105
    :cond_0
    iget v0, p2, Lcom/mrkeyboard/app/MrUpdate$Result;->status:I

    if-ne v0, v2, :cond_1

    .line 106
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

    .line 113
    :catch_0
    move-exception v0

    goto :goto_0

    .line 107
    :cond_1
    iget v0, p2, Lcom/mrkeyboard/app/MrUpdate$Result;->status:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_2

    .line 108
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

    .line 109
    const-string v1, "mr_update_sum_error"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 111
    :cond_2
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrUpdateUi;->showKnown(Landroid/app/Activity;Landroid/preference/Preference;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0
.end method

.method static bind(Landroid/preference/PreferenceActivity;)V
    .locals 4

    .prologue
    .line 33
    :try_start_0
    const-string v1, "mr_update"

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v1

    .line 34
    if-eqz v1, :cond_0

    .line 35
    new-instance v2, Lcom/mrkeyboard/app/MrUpdateUi$Check;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrUpdateUi$Check;-><init>(Landroid/preference/PreferenceActivity;)V

    invoke-virtual {v1, v2}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 36
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrUpdateUi;->showKnown(Landroid/app/Activity;Landroid/preference/Preference;)V

    .line 38
    :cond_0
    const-string v1, "mr_update_auto"

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v2

    .line 39
    instance-of v1, v2, Landroid/preference/CheckBoxPreference;

    if-eqz v1, :cond_1

    .line 40
    move-object v0, v2

    check-cast v0, Landroid/preference/CheckBoxPreference;

    move-object v1, v0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->auto(Landroid/content/Context;)Z

    move-result v3

    invoke-virtual {v1, v3}, Landroid/preference/CheckBoxPreference;->setChecked(Z)V

    .line 41
    new-instance v1, Lcom/mrkeyboard/app/MrUpdateUi$Auto;

    invoke-virtual {p0}, Landroid/preference/PreferenceActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v1, v3}, Lcom/mrkeyboard/app/MrUpdateUi$Auto;-><init>(Landroid/content/Context;)V

    invoke-virtual {v2, v1}, Landroid/preference/Preference;->setOnPreferenceChangeListener(Landroid/preference/Preference$OnPreferenceChangeListener;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 46
    :cond_1
    :goto_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateUi;->onOpen(Landroid/app/Activity;)V

    .line 47
    return-void

    .line 43
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static check(Landroid/app/Activity;Landroid/preference/Preference;)V
    .locals 3

    .prologue
    .line 68
    invoke-virtual {p0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 69
    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdate;->pending(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Notice;

    move-result-object v1

    .line 70
    if-eqz v1, :cond_1

    .line 71
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrUpdateDialog;->show(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    .line 97
    :cond_0
    :goto_0
    return-void

    .line 74
    :cond_1
    sget-boolean v1, Lcom/mrkeyboard/app/MrUpdateUi;->sChecking:Z

    if-nez v1, :cond_0

    .line 75
    const/4 v1, 0x1

    sput-boolean v1, Lcom/mrkeyboard/app/MrUpdateUi;->sChecking:Z

    .line 76
    const-string v1, "mr_update_sum_checking"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 77
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrUpdateUi$1;

    invoke-direct {v2, v0, p0, p1}, Lcom/mrkeyboard/app/MrUpdateUi$1;-><init>(Landroid/content/Context;Landroid/app/Activity;Landroid/preference/Preference;)V

    const-string v0, "mr-update-check"

    invoke-direct {v1, v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 96
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method static onOpen(Landroid/app/Activity;)V
    .locals 3

    .prologue
    .line 149
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "mr_update_show"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 150
    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "mr_update_show"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    .line 151
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->pending(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Notice;

    move-result-object v0

    .line 152
    if-eqz v0, :cond_1

    .line 153
    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrUpdateDialog;->show(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    .line 181
    :cond_0
    :goto_0
    return-void

    .line 157
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->auto(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 158
    invoke-virtual {p0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 159
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrUpdateUi$2;

    invoke-direct {v2, v0, p0}, Lcom/mrkeyboard/app/MrUpdateUi$2;-><init>(Landroid/content/Context;Landroid/app/Activity;)V

    const-string v0, "mr-update-open"

    invoke-direct {v1, v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 177
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 178
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static refreshRow(Landroid/app/Activity;)V
    .locals 2

    .prologue
    .line 61
    instance-of v0, p0, Landroid/preference/PreferenceActivity;

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrUpdateUi;->sChecking:Z

    if-eqz v0, :cond_1

    .line 64
    :cond_0
    :goto_0
    return-void

    :cond_1
    move-object v0, p0

    .line 62
    check-cast v0, Landroid/preference/PreferenceActivity;

    const-string v1, "mr_update"

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 63
    if-eqz v0, :cond_0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrUpdateUi;->showKnown(Landroid/app/Activity;Landroid/preference/Preference;)V

    goto :goto_0
.end method

.method static release(Landroid/app/Activity;)V
    .locals 0

    .prologue
    .line 185
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateDialog;->release(Landroid/app/Activity;)V

    .line 186
    return-void
.end method

.method private static showKnown(Landroid/app/Activity;Landroid/preference/Preference;)V
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 51
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->pending(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Notice;

    move-result-object v0

    .line 52
    if-eqz v0, :cond_0

    .line 53
    const-string v1, "mr_update_sum_available"

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionName:Ljava/lang/String;

    aput-object v0, v2, v3

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 57
    :goto_0
    return-void

    .line 55
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
