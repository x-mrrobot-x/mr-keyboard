.class public final Lcom/mrkeyboard/app/MrPerf;
.super Ljava/lang/Object;
.source "MrPerf.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrPerf$Reset;
    }
.end annotation


# static fields
.field static final APP:I = 0x7

.field static final CREATE:I = 0x0

.field static final FRAME:I = 0x4

.field static final KEY:I = 0x5

.field static final KINDS:I = 0x9

.field static final LOG:[Ljava/lang/String;

.field static final NAMES:[Ljava/lang/String;

.field static final OPEN:I = 0x2

.field static final ROW:Ljava/lang/String; = "mr_perf"

.field static final SHOWN:I = 0x3

.field static final SHOWN_MAX_US:I = 0x1e8480

.field static final SIZE:I = 0x100

.field static final SUGG:I = 0x8

.field static final TAG:Ljava/lang/String; = "MrPerf"

.field static final TOUCH:I = 0x6

.field static final VIEW:I = 0x1

.field private static final sCount:[I

.field static sFakeNanos:J

.field private static final sLast:[I

.field private static sLoggedKeys:I

.field private static final sMax:[I

.field private static final sRing:[I

.field private static final sScratch:[I

.field private static sShownFrom:J

.field private static final sStart:[J


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .prologue
    const/4 v8, 0x2

    const/4 v7, 0x1

    const/4 v6, 0x0

    const-wide/16 v4, -0x1

    const/16 v3, 0x9

    .line 51
    new-array v0, v3, [Ljava/lang/String;

    const-string v1, "mr_ui_perf_create"

    aput-object v1, v0, v6

    const-string v1, "mr_ui_perf_view"

    aput-object v1, v0, v7

    const-string v1, "mr_ui_perf_open"

    aput-object v1, v0, v8

    const/4 v1, 0x3

    const-string v2, "mr_ui_perf_shown"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "mr_ui_perf_frame"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "mr_ui_perf_key"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "mr_ui_perf_touch"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "mr_ui_perf_app"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "mr_ui_perf_sugg"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    .line 55
    new-array v0, v3, [Ljava/lang/String;

    const-string v1, "create"

    aput-object v1, v0, v6

    const-string v1, "view"

    aput-object v1, v0, v7

    const-string v1, "open"

    aput-object v1, v0, v8

    const/4 v1, 0x3

    const-string v2, "shown"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "frame"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "key"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "touch"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "app"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "sugg"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->LOG:[Ljava/lang/String;

    .line 57
    const/16 v0, 0x900

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    .line 58
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    .line 59
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    .line 60
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    .line 62
    new-array v0, v3, [J

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    .line 64
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 67
    const/16 v0, 0x100

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    .line 69
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sFakeNanos:J

    .line 72
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    invoke-static {v0, v4, v5}, Ljava/util/Arrays;->fill([JJ)V

    .line 73
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 75
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static add(IJ)V
    .locals 5

    .prologue
    .line 143
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-gez v0, :cond_1

    const/4 v0, 0x0

    .line 144
    :goto_0
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v1, v1, p0

    .line 145
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    mul-int/lit16 v3, p0, 0x100

    and-int/lit16 v4, v1, 0xff

    add-int/2addr v3, v4

    aput v0, v2, v3

    .line 146
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    add-int/lit8 v1, v1, 0x1

    aput v1, v2, p0

    .line 147
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    aget v1, v1, p0

    if-le v0, v1, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    aput v0, v1, p0

    .line 148
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    aput v0, v1, p0

    .line 149
    return-void

    .line 143
    :cond_1
    const-wide/32 v0, 0x7fffffff

    cmp-long v0, p1, v0

    if-lez v0, :cond_2

    const v0, 0x7fffffff

    goto :goto_0

    :cond_2
    long-to-int v0, p1

    goto :goto_0
.end method

.method public static appBegin()V
    .locals 1

    .prologue
    .line 107
    const/4 v0, 0x7

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static appEnd()V
    .locals 1

    .prologue
    .line 108
    const/4 v0, 0x7

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static begin(I)V
    .locals 4

    .prologue
    .line 131
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    aput-wide v2, v0, p0

    .line 132
    return-void
.end method

.method public static createBegin()V
    .locals 1

    .prologue
    .line 83
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static createEnd()V
    .locals 1

    .prologue
    .line 84
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static end(I)V
    .locals 6

    .prologue
    .line 135
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    aget-wide v0, v0, p0

    .line 136
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 139
    :goto_0
    return-void

    .line 137
    :cond_0
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const-wide/16 v4, -0x1

    aput-wide v4, v2, p0

    .line 138
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    sub-long v0, v2, v0

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    goto :goto_0
.end method

.method public static fill(Landroid/preference/PreferenceActivity;)V
    .locals 2

    .prologue
    .line 248
    :try_start_0
    const-string v0, "mr_perf"

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 249
    if-nez v0, :cond_0

    .line 255
    :goto_0
    return-void

    .line 250
    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->summary(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 251
    new-instance v1, Lcom/mrkeyboard/app/MrPerf$Reset;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrPerf$Reset;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 252
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static frameBegin()V
    .locals 1

    .prologue
    .line 94
    const/4 v0, 0x4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static frameEnd()V
    .locals 4

    .prologue
    .line 97
    const/4 v0, 0x4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    .line 98
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 99
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_1

    .line 103
    :cond_0
    :goto_0
    return-void

    .line 100
    :cond_1
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 101
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    sub-long v0, v2, v0

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    .line 102
    const-wide/32 v2, 0x1e8480

    cmp-long v2, v0, v2

    if-gtz v2, :cond_0

    const/4 v2, 0x3

    invoke-static {v2, v0, v1}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    goto :goto_0
.end method

.method static heapUsed()J
    .locals 4

    .prologue
    .line 193
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    .line 194
    invoke-virtual {v0}, Ljava/lang/Runtime;->totalMemory()J

    move-result-wide v2

    invoke-virtual {v0}, Ljava/lang/Runtime;->freeMemory()J

    move-result-wide v0

    sub-long v0, v2, v0

    return-wide v0
.end method

.method public static keyBegin()V
    .locals 1

    .prologue
    .line 105
    const/4 v0, 0x5

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static keyEnd()V
    .locals 1

    .prologue
    .line 106
    const/4 v0, 0x5

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static line()Ljava/lang/String;
    .locals 7

    .prologue
    const/16 v6, 0x2f

    const/4 v1, 0x0

    .line 233
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    move v0, v1

    .line 234
    :goto_0
    const/16 v3, 0x9

    if-ge v0, v3, :cond_1

    .line 235
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->stats(I)[I

    move-result-object v3

    .line 236
    aget v4, v3, v1

    if-nez v4, :cond_0

    .line 234
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 237
    :cond_0
    sget-object v4, Lcom/mrkeyboard/app/MrPerf;->LOG:[Ljava/lang/String;

    aget-object v4, v4, v0

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const/16 v5, 0x20

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    const/4 v5, 0x1

    aget v5, v3, v5

    invoke-static {v5}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    const/4 v5, 0x2

    aget v5, v3, v5

    invoke-static {v5}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    const/4 v5, 0x3

    aget v5, v3, v5

    invoke-static {v5}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " ms ("

    .line 238
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget v3, v3, v1

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ") "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 240
    :cond_1
    const-string v0, "heap "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->heapUsed()J

    move-result-wide v4

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " native "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 241
    invoke-static {}, Landroid/os/Debug;->getNativeHeapAllocatedSize()J

    move-result-wide v4

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 242
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static ms(I)Ljava/lang/String;
    .locals 4

    .prologue
    .line 198
    int-to-long v0, p0

    const-wide/16 v2, 0x3e8

    mul-long/2addr v0, v2

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static nanos()J
    .locals 4

    .prologue
    .line 78
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sFakeNanos:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-ltz v0, :cond_0

    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sFakeNanos:J

    :goto_0
    return-wide v0

    :cond_0
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v0

    goto :goto_0
.end method

.method public static onHidden()V
    .locals 2

    .prologue
    .line 122
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    const/4 v1, 0x5

    aget v0, v0, v1

    .line 123
    sget v1, Lcom/mrkeyboard/app/MrPerf;->sLoggedKeys:I

    if-ne v0, v1, :cond_0

    .line 126
    :goto_0
    return-void

    .line 124
    :cond_0
    sput v0, Lcom/mrkeyboard/app/MrPerf;->sLoggedKeys:I

    .line 125
    const-string v0, "MrPerf"

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->line()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static openBegin()V
    .locals 2

    .prologue
    const/4 v1, 0x2

    .line 89
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    .line 90
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    aget-wide v0, v0, v1

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 91
    return-void
.end method

.method public static openEnd()V
    .locals 1

    .prologue
    .line 93
    const/4 v0, 0x2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static p95(I)I
    .locals 1

    .prologue
    .line 178
    mul-int/lit8 v0, p0, 0x5f

    add-int/lit8 v0, v0, 0x63

    div-int/lit8 v0, v0, 0x64

    add-int/lit8 v0, v0, -0x1

    .line 179
    if-gez v0, :cond_0

    const/4 v0, 0x0

    :cond_0
    return v0
.end method

.method static reset()V
    .locals 4

    .prologue
    const-wide/16 v2, -0x1

    const/4 v1, 0x0

    .line 184
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 185
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 186
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 187
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    invoke-static {v0, v2, v3}, Ljava/util/Arrays;->fill([JJ)V

    .line 188
    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 189
    sput v1, Lcom/mrkeyboard/app/MrPerf;->sLoggedKeys:I

    .line 190
    return-void
.end method

.method static stats(I)[I
    .locals 10

    .prologue
    const/16 v3, 0x100

    const/4 v2, 0x0

    .line 156
    const/4 v0, 0x5

    new-array v0, v0, [I

    .line 157
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v1, v1, p0

    .line 158
    aput v1, v0, v2

    .line 159
    if-ge v1, v3, :cond_0

    move v3, v1

    .line 160
    :cond_0
    if-nez v3, :cond_1

    .line 173
    :goto_0
    return-object v0

    .line 161
    :cond_1
    const-wide/16 v4, 0x0

    .line 162
    mul-int/lit16 v6, p0, 0x100

    move v1, v2

    .line 163
    :goto_1
    if-ge v1, v3, :cond_2

    .line 164
    sget-object v7, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    add-int v8, v6, v1

    aget v7, v7, v8

    .line 165
    sget-object v8, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    aput v7, v8, v1

    .line 166
    int-to-long v8, v7

    add-long/2addr v4, v8

    .line 163
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 168
    :cond_2
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    invoke-static {v1, v2, v3}, Ljava/util/Arrays;->sort([III)V

    .line 169
    const/4 v1, 0x1

    int-to-long v6, v3

    div-long/2addr v4, v6

    long-to-int v2, v4

    aput v2, v0, v1

    .line 170
    const/4 v1, 0x2

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->p95(I)I

    move-result v3

    aget v2, v2, v3

    aput v2, v0, v1

    .line 171
    const/4 v1, 0x3

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    aget v2, v2, p0

    aput v2, v0, v1

    .line 172
    const/4 v1, 0x4

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    aget v2, v2, p0

    aput v2, v0, v1

    goto :goto_0
.end method

.method public static suggBegin()V
    .locals 1

    .prologue
    .line 109
    const/16 v0, 0x8

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static suggEnd()V
    .locals 1

    .prologue
    .line 110
    const/16 v0, 0x8

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static summary(Landroid/content/Context;)Ljava/lang/String;
    .locals 11

    .prologue
    const/4 v10, 0x3

    const/16 v9, 0xa

    const/4 v8, 0x2

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 205
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    move v3, v2

    .line 206
    :goto_0
    const/16 v0, 0x9

    if-ge v3, v0, :cond_4

    .line 207
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->stats(I)[I

    move-result-object v0

    .line 208
    aget v5, v0, v2

    if-nez v5, :cond_1

    .line 206
    :cond_0
    :goto_1
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_0

    .line 209
    :cond_1
    sget-object v5, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    aget-object v5, v5, v3

    new-array v6, v2, [Ljava/lang/Object;

    invoke-static {p0, v5, v6}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    .line 210
    aget v6, v0, v2

    if-ne v6, v1, :cond_3

    .line 211
    const-string v6, "mr_ui_perf_one"

    new-array v7, v8, [Ljava/lang/Object;

    aput-object v5, v7, v2

    const/4 v5, 0x4

    aget v0, v0, v5

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v7, v1

    invoke-static {p0, v6, v7}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 213
    :goto_2
    if-eqz v0, :cond_0

    .line 214
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I

    move-result v5

    if-lez v5, :cond_2

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 215
    :cond_2
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 212
    :cond_3
    const-string v6, "mr_ui_perf_stat"

    const/4 v7, 0x5

    new-array v7, v7, [Ljava/lang/Object;

    aput-object v5, v7, v2

    aget v5, v0, v1

    invoke-static {v5}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v7, v1

    aget v5, v0, v8

    invoke-static {v5}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v7, v8

    aget v5, v0, v10

    invoke-static {v5}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v7, v10

    const/4 v5, 0x4

    aget v0, v0, v2

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v7, v5

    invoke-static {p0, v6, v7}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    .line 217
    :cond_4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    if-lez v0, :cond_8

    move v0, v1

    .line 218
    :goto_3
    if-nez v0, :cond_5

    .line 219
    const-string v3, "mr_ui_perf_none"

    new-array v5, v2, [Ljava/lang/Object;

    invoke-static {p0, v3, v5}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 220
    if-eqz v3, :cond_5

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 222
    :cond_5
    const-string v3, "mr_ui_perf_mem"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->heapUsed()J

    move-result-wide v6

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v2

    invoke-static {}, Landroid/os/Debug;->getNativeHeapAllocatedSize()J

    move-result-wide v6

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v1

    invoke-static {p0, v3, v5}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 223
    if-eqz v1, :cond_6

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 224
    :cond_6
    if-eqz v0, :cond_7

    .line 225
    const-string v0, "mr_ui_perf_reset"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 226
    if-eqz v0, :cond_7

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 228
    :cond_7
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_8
    move v0, v2

    .line 217
    goto :goto_3
.end method

.method public static touch(Landroid/view/MotionEvent;)V
    .locals 6

    .prologue
    .line 114
    if-nez p0, :cond_1

    .line 118
    :cond_0
    :goto_0
    return-void

    .line 115
    :cond_1
    invoke-virtual {p0}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    .line 116
    if-eqz v0, :cond_2

    const/4 v1, 0x5

    if-ne v0, v1, :cond_0

    .line 117
    :cond_2
    const/4 v0, 0x6

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    invoke-virtual {p0}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v4

    sub-long/2addr v2, v4

    const-wide/16 v4, 0x3e8

    mul-long/2addr v2, v4

    invoke-static {v0, v2, v3}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    goto :goto_0
.end method

.method public static viewBegin()V
    .locals 1

    .prologue
    .line 85
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static viewEnd()V
    .locals 1

    .prologue
    .line 86
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method
