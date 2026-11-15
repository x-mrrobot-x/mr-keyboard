.class public final Lcom/mrkeyboard/app/MrLongPress;
.super Ljava/lang/Object;
.source "MrLongPress.java"


# static fields
.field private static final NONE:J = -0x8000000000000000L

.field private static sArmedAt:J

.field private static sDue:J

.field private static sEvent:J

.field static sFakeNow:J

.field private static sFrom:J

.field private static sPlanned:J

.field private static sRan:J


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const-wide/high16 v2, -0x8000000000000000L

    .line 28
    const-wide/16 v0, -0x1

    sput-wide v0, Lcom/mrkeyboard/app/MrLongPress;->sFakeNow:J

    .line 31
    sput-wide v2, Lcom/mrkeyboard/app/MrLongPress;->sEvent:J

    .line 39
    sput-wide v2, Lcom/mrkeyboard/app/MrLongPress;->sRan:J

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static arm(J)J
    .locals 12

    .prologue
    const-wide/16 v0, 0x0

    const-wide/high16 v10, -0x8000000000000000L

    .line 58
    invoke-static {}, Lcom/mrkeyboard/app/MrLongPress;->now()J

    move-result-wide v6

    .line 59
    sget-wide v2, Lcom/mrkeyboard/app/MrLongPress;->sEvent:J

    .line 60
    sput-wide v10, Lcom/mrkeyboard/app/MrLongPress;->sEvent:J

    .line 61
    cmp-long v4, v2, v10

    if-eqz v4, :cond_0

    cmp-long v4, v2, v6

    if-lez v4, :cond_2

    :cond_0
    move-wide v4, v6

    .line 62
    :goto_0
    sub-long v2, v6, v4

    sub-long v2, p0, v2

    .line 63
    cmp-long v8, v2, v0

    if-gez v8, :cond_1

    .line 64
    :goto_1
    sput-wide v4, Lcom/mrkeyboard/app/MrLongPress;->sFrom:J

    .line 65
    sput-wide v6, Lcom/mrkeyboard/app/MrLongPress;->sArmedAt:J

    .line 66
    add-long v2, v6, v0

    sput-wide v2, Lcom/mrkeyboard/app/MrLongPress;->sDue:J

    .line 67
    sput-wide p0, Lcom/mrkeyboard/app/MrLongPress;->sPlanned:J

    .line 68
    sput-wide v10, Lcom/mrkeyboard/app/MrLongPress;->sRan:J

    .line 69
    return-wide v0

    :cond_1
    move-wide v0, v2

    goto :goto_1

    :cond_2
    move-wide v4, v2

    goto :goto_0
.end method

.method public static event(Landroid/view/MotionEvent;)V
    .locals 2

    .prologue
    .line 49
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v0

    sput-wide v0, Lcom/mrkeyboard/app/MrLongPress;->sEvent:J

    .line 50
    :cond_0
    return-void
.end method

.method static forget()V
    .locals 2

    .prologue
    const-wide/high16 v0, -0x8000000000000000L

    .line 88
    sput-wide v0, Lcom/mrkeyboard/app/MrLongPress;->sEvent:J

    .line 89
    sput-wide v0, Lcom/mrkeyboard/app/MrLongPress;->sRan:J

    .line 90
    return-void
.end method

.method static now()J
    .locals 4

    .prologue
    .line 44
    sget-wide v0, Lcom/mrkeyboard/app/MrLongPress;->sFakeNow:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-ltz v0, :cond_0

    sget-wide v0, Lcom/mrkeyboard/app/MrLongPress;->sFakeNow:J

    :goto_0
    return-wide v0

    :cond_0
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    goto :goto_0
.end method

.method public static ran()V
    .locals 2

    .prologue
    .line 74
    invoke-static {}, Lcom/mrkeyboard/app/MrLongPress;->now()J

    move-result-wide v0

    sput-wide v0, Lcom/mrkeyboard/app/MrLongPress;->sRan:J

    .line 75
    return-void
.end method

.method public static shown()V
    .locals 12

    .prologue
    const-wide/high16 v2, -0x8000000000000000L

    .line 79
    sget-wide v8, Lcom/mrkeyboard/app/MrLongPress;->sRan:J

    .line 80
    cmp-long v0, v8, v2

    if-nez v0, :cond_0

    .line 84
    :goto_0
    return-void

    .line 81
    :cond_0
    sput-wide v2, Lcom/mrkeyboard/app/MrLongPress;->sRan:J

    .line 82
    invoke-static {}, Lcom/mrkeyboard/app/MrLongPress;->now()J

    move-result-wide v10

    .line 83
    sget-wide v0, Lcom/mrkeyboard/app/MrLongPress;->sFrom:J

    sub-long v0, v10, v0

    sget-wide v2, Lcom/mrkeyboard/app/MrLongPress;->sPlanned:J

    sget-wide v4, Lcom/mrkeyboard/app/MrLongPress;->sArmedAt:J

    sget-wide v6, Lcom/mrkeyboard/app/MrLongPress;->sFrom:J

    sub-long/2addr v4, v6

    sget-wide v6, Lcom/mrkeyboard/app/MrLongPress;->sDue:J

    sub-long v6, v8, v6

    sub-long v8, v10, v8

    invoke-static/range {v0 .. v9}, Lcom/mrkeyboard/app/MrPerf;->longShown(JJJJJ)V

    goto :goto_0
.end method
