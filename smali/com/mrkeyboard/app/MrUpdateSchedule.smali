.class final Lcom/mrkeyboard/app/MrUpdateSchedule;
.super Ljava/lang/Object;
.source "MrUpdateSchedule.java"


# static fields
.field static final JOB_ID:I = 0x71c

.field static final KEY_ASKED:Ljava/lang/String; = "perm_asked"

.field static final KEY_MINUTES:Ljava/lang/String; = "morning_min"

.field static final KEY_MORNING:Ljava/lang/String; = "morning"

.field static final KEY_NOTIFIED:Ljava/lang/String; = "notified_code"

.field static final MORNING_HOUR:I = 0x8

.field static sTestMinutes:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 41
    const/4 v0, -0x1

    sput v0, Lcom/mrkeyboard/app/MrUpdateSchedule;->sTestMinutes:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static arm(Landroid/content/Context;)V
    .locals 7

    .prologue
    .line 137
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->scheduler(Landroid/content/Context;)Landroid/app/job/JobScheduler;

    move-result-object v0

    .line 138
    if-nez v0, :cond_0

    .line 153
    :goto_0
    return-void

    .line 139
    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->morning(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 140
    const/16 v1, 0x71c

    invoke-virtual {v0, v1}, Landroid/app/job/JobScheduler;->cancel(I)V

    goto :goto_0

    .line 150
    :catch_0
    move-exception v0

    goto :goto_0

    .line 143
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdate;->now()J

    move-result-wide v2

    invoke-static {}, Ljava/util/TimeZone;->getDefault()Ljava/util/TimeZone;

    move-result-object v1

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->minutes(Landroid/content/Context;)I

    move-result v4

    invoke-static {v2, v3, v1, v4}, Lcom/mrkeyboard/app/MrUpdateSchedule;->delay(JLjava/util/TimeZone;I)J

    move-result-wide v2

    .line 144
    new-instance v1, Landroid/app/job/JobInfo$Builder;

    const/16 v4, 0x71c

    new-instance v5, Landroid/content/ComponentName;

    const-class v6, Lcom/mrkeyboard/app/MrUpdateJob;

    invoke-direct {v5, p0, v6}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-direct {v1, v4, v5}, Landroid/app/job/JobInfo$Builder;-><init>(ILandroid/content/ComponentName;)V

    .line 145
    invoke-virtual {v1, v2, v3}, Landroid/app/job/JobInfo$Builder;->setMinimumLatency(J)Landroid/app/job/JobInfo$Builder;

    move-result-object v1

    const/4 v2, 0x1

    .line 146
    invoke-virtual {v1, v2}, Landroid/app/job/JobInfo$Builder;->setRequiredNetworkType(I)Landroid/app/job/JobInfo$Builder;

    move-result-object v1

    const/4 v2, 0x1

    .line 147
    invoke-virtual {v1, v2}, Landroid/app/job/JobInfo$Builder;->setPersisted(Z)Landroid/app/job/JobInfo$Builder;

    move-result-object v1

    .line 148
    invoke-virtual {v1}, Landroid/app/job/JobInfo$Builder;->build()Landroid/app/job/JobInfo;

    move-result-object v1

    .line 149
    invoke-virtual {v0, v1}, Landroid/app/job/JobScheduler;->schedule(Landroid/app/job/JobInfo;)I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0
.end method

.method static armed(Landroid/content/Context;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 124
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->scheduler(Landroid/content/Context;)Landroid/app/job/JobScheduler;

    move-result-object v1

    .line 125
    if-eqz v1, :cond_0

    const/16 v2, 0x71c

    invoke-virtual {v1, v2}, Landroid/app/job/JobScheduler;->getPendingJob(I)Landroid/app/job/JobInfo;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    .line 127
    :cond_0
    :goto_0
    return v0

    .line 126
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static asked(Landroid/content/Context;)Z
    .locals 3

    .prologue
    .line 107
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "perm_asked"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method static delay(JLjava/util/TimeZone;I)J
    .locals 4

    .prologue
    .line 68
    const-wide/16 v0, 0x1

    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrUpdateSchedule;->next(JLjava/util/TimeZone;I)J

    move-result-wide v2

    sub-long/2addr v2, p0

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v0

    return-wide v0
.end method

.method static ensure(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 157
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->morning(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 158
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->arm(Landroid/content/Context;)V

    .line 162
    :cond_0
    :goto_0
    return-void

    .line 159
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->armed(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 160
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->arm(Landroid/content/Context;)V

    goto :goto_0
.end method

.method static minutes(Landroid/content/Context;)I
    .locals 3

    .prologue
    .line 88
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 89
    const-string v0, "morning_min"

    const/4 v2, -0x1

    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    .line 90
    if-ltz v0, :cond_0

    const/16 v2, 0x3b

    if-gt v0, v2, :cond_0

    .line 93
    :goto_0
    return v0

    .line 91
    :cond_0
    sget v0, Lcom/mrkeyboard/app/MrUpdateSchedule;->sTestMinutes:I

    if-ltz v0, :cond_1

    sget v0, Lcom/mrkeyboard/app/MrUpdateSchedule;->sTestMinutes:I

    .line 92
    :goto_1
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "morning_min"

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    goto :goto_0

    .line 91
    :cond_1
    new-instance v0, Ljava/util/Random;

    invoke-direct {v0}, Ljava/util/Random;-><init>()V

    const/16 v2, 0x3c

    invoke-virtual {v0, v2}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    goto :goto_1
.end method

.method static morning(Landroid/content/Context;)Z
    .locals 3

    .prologue
    .line 79
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "morning"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method static next(JLjava/util/TimeZone;I)J
    .locals 8

    .prologue
    const/16 v6, 0xc

    const/16 v5, 0xb

    const/16 v4, 0x8

    const/4 v3, 0x0

    .line 51
    const/16 v0, 0x3b

    invoke-static {v0, p3}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-static {v3, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 52
    invoke-static {p2}, Ljava/util/Calendar;->getInstance(Ljava/util/TimeZone;)Ljava/util/Calendar;

    move-result-object v1

    .line 53
    invoke-virtual {v1, p0, p1}, Ljava/util/Calendar;->setTimeInMillis(J)V

    .line 54
    invoke-virtual {v1, v5, v4}, Ljava/util/Calendar;->set(II)V

    .line 55
    invoke-virtual {v1, v6, v0}, Ljava/util/Calendar;->set(II)V

    .line 56
    const/16 v2, 0xd

    invoke-virtual {v1, v2, v3}, Ljava/util/Calendar;->set(II)V

    .line 57
    const/16 v2, 0xe

    invoke-virtual {v1, v2, v3}, Ljava/util/Calendar;->set(II)V

    .line 58
    invoke-virtual {v1}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide v2

    cmp-long v2, v2, p0

    if-gtz v2, :cond_0

    .line 59
    const/4 v2, 0x5

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v3}, Ljava/util/Calendar;->add(II)V

    .line 60
    invoke-virtual {v1, v5, v4}, Ljava/util/Calendar;->set(II)V

    .line 61
    invoke-virtual {v1, v6, v0}, Ljava/util/Calendar;->set(II)V

    .line 63
    :cond_0
    invoke-virtual {v1}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide v0

    return-wide v0
.end method

.method static notified(Landroid/content/Context;)J
    .locals 4

    .prologue
    .line 98
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "notified_code"

    const-wide/16 v2, 0x0

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    return-wide v0
.end method

.method static prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 1

    .prologue
    .line 74
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method private static scheduler(Landroid/content/Context;)Landroid/app/job/JobScheduler;
    .locals 2

    .prologue
    .line 117
    const-string v0, "jobscheduler"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 118
    instance-of v1, v0, Landroid/app/job/JobScheduler;

    if-eqz v1, :cond_0

    check-cast v0, Landroid/app/job/JobScheduler;

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static setAsked(Landroid/content/Context;)V
    .locals 3

    .prologue
    .line 111
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "perm_asked"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 112
    return-void
.end method

.method static setMorning(Landroid/content/Context;Z)V
    .locals 2

    .prologue
    .line 83
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "morning"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 84
    return-void
.end method

.method static setNotified(Landroid/content/Context;J)V
    .locals 3

    .prologue
    .line 102
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "notified_code"

    invoke-interface {v0, v1, p1, p2}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 103
    return-void
.end method

.method static sync(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 170
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->ensure(Landroid/content/Context;)V

    .line 171
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->morning(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateNotify;->ensureChannel(Landroid/content/Context;)V

    .line 172
    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateNotify;->dropIfInstalled(Landroid/content/Context;)V

    .line 173
    return-void
.end method
