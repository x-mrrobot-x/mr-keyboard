.class public final Lcom/mrkeyboard/app/MrUpdateJob;
.super Landroid/app/job/JobService;
.source "MrUpdateJob.java"


# static fields
.field static final BLOCKED:I = 0x1

.field static final FAILED:I = 0x5

.field static final NONE:I = 0x2

.field static final NOTIFIED:I = 0x3

.field static final OFF:I = 0x0

.field static final REPEATED:I = 0x4


# instance fields
.field private volatile mDone:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 21
    invoke-direct {p0}, Landroid/app/job/JobService;-><init>()V

    return-void
.end method

.method static synthetic access$002(Lcom/mrkeyboard/app/MrUpdateJob;Z)Z
    .locals 0

    .prologue
    .line 21
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrUpdateJob;->mDone:Z

    return p1
.end method

.method static run(Landroid/content/Context;)I
    .locals 8

    .prologue
    const/4 v1, 0x3

    const/4 v0, 0x5

    .line 40
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->morning(Landroid/content/Context;)Z

    move-result v2

    if-nez v2, :cond_1

    const/4 v0, 0x0

    .line 53
    :cond_0
    :goto_0
    return v0

    .line 41
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateNotify;->enabled(Landroid/content/Context;)Z

    move-result v2

    if-nez v2, :cond_2

    const/4 v0, 0x1

    goto :goto_0

    .line 42
    :cond_2
    const-wide/32 v2, 0x1499700

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrUpdate;->checkIfOlder(Landroid/content/Context;J)Lcom/mrkeyboard/app/MrUpdate$Result;

    move-result-object v2

    .line 43
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->pending(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Notice;

    move-result-object v3

    .line 44
    if-nez v3, :cond_3

    .line 45
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateNotify;->dismiss(Landroid/content/Context;)V

    .line 46
    iget v2, v2, Lcom/mrkeyboard/app/MrUpdate$Result;->status:I

    if-eq v2, v1, :cond_0

    const/4 v0, 0x2

    goto :goto_0

    .line 48
    :cond_3
    iget-wide v4, v3, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionCode:J

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->notified(Landroid/content/Context;)J

    move-result-wide v6

    cmp-long v2, v4, v6

    if-gtz v2, :cond_4

    const/4 v0, 0x4

    goto :goto_0

    .line 49
    :cond_4
    invoke-static {p0, v3}, Lcom/mrkeyboard/app/MrUpdateNotify;->show(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 50
    iget-wide v2, v3, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionCode:J

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrUpdateSchedule;->setNotified(Landroid/content/Context;J)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move v0, v1

    .line 51
    goto :goto_0

    .line 52
    :catch_0
    move-exception v1

    goto :goto_0
.end method


# virtual methods
.method public onStartJob(Landroid/app/job/JobParameters;)Z
    .locals 3

    .prologue
    .line 59
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrUpdateJob;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 60
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrUpdateJob;->mDone:Z

    .line 61
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrUpdateJob$1;

    invoke-direct {v2, p0, v0, p1}, Lcom/mrkeyboard/app/MrUpdateJob$1;-><init>(Lcom/mrkeyboard/app/MrUpdateJob;Landroid/content/Context;Landroid/app/job/JobParameters;)V

    const-string v0, "mr-update-job"

    invoke-direct {v1, v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 68
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    .line 69
    const/4 v0, 0x1

    return v0
.end method

.method public onStopJob(Landroid/app/job/JobParameters;)Z
    .locals 1

    .prologue
    .line 75
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrUpdateJob;->mDone:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
