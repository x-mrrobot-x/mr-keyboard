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

.field static final APP_KEY:I = 0x12

.field static final APP_MSG:I = 0x1b

.field static final APP_OPEN:I = 0x14

.field static final APP_OTHER:I = 0x15

.field static final APP_SEL:I = 0x1a

.field static final APP_SUGG:I = 0x13

.field static final CREATE:I = 0x0

.field static final ECHO_CUT:I = 0x1c

.field static final ECHO_FULL:I = 0x1d

.field static final ECHO_ONE:I = 0x1e

.field static final FRAME:I = 0x4

.field static final KEY:I = 0x5

.field static final KEY_DEL:I = 0xb

.field static final KEY_LETTER:I = 0x9

.field static final KEY_OTHER:I = 0xc

.field static final KEY_SEP:I = 0xa

.field static final KINDS:I = 0x1f

.field static final LOG:[Ljava/lang/String;

.field static final MSG:I = 0x19

.field static final NAMES:[Ljava/lang/String;

.field static final OPEN:I = 0x2

.field static final OPEN_KB:I = 0xf

.field static final OPEN_SET:I = 0x10

.field static final PLACE_MAX_MS:I = 0x2710

.field static final POPUP:I = 0x11

.field static final POPUP_BUILD:I = 0x16

.field static final POPUP_SHOW:I = 0x17

.field static final ROW:Ljava/lang/String; = "mr_perf"

.field static final SEL:I = 0x18

.field static final SHOWN:I = 0x3

.field static final SHOWN_MAX_US:I = 0x1e8480

.field static final SIZE:I = 0x100

.field static final SUGG:I = 0x8

.field static final SUGG_ENGINE:I = 0xd

.field static final SUGG_SHOW:I = 0xe

.field static final TAG:Ljava/lang/String; = "MrPerf"

.field static final TOUCH:I = 0x6

.field static final VIEW:I = 0x1

.field private static final sCount:[I

.field static sFakeMode:I

.field static sFakeNanos:J

.field private static sKeyKind:I

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
    const/4 v8, 0x1

    const/4 v5, 0x0

    const-wide/16 v6, -0x1

    const/16 v4, 0xc

    const/16 v3, 0x1f

    .line 80
    new-array v0, v3, [Ljava/lang/String;

    const-string v1, "mr_ui_perf_create"

    aput-object v1, v0, v5

    const-string v1, "mr_ui_perf_view"

    aput-object v1, v0, v8

    const/4 v1, 0x2

    const-string v2, "mr_ui_perf_open"

    aput-object v2, v0, v1

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

    const/16 v1, 0x9

    const-string v2, "mr_ui_perf_key_letter"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "mr_ui_perf_key_sep"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "mr_ui_perf_key_del"

    aput-object v2, v0, v1

    const-string v1, "mr_ui_perf_key_other"

    aput-object v1, v0, v4

    const/16 v1, 0xd

    const-string v2, "mr_ui_perf_sugg_engine"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "mr_ui_perf_sugg_show"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "mr_ui_perf_open_kb"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, "mr_ui_perf_open_set"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "mr_ui_perf_popup"

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, "mr_ui_perf_app_key"

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, "mr_ui_perf_app_sugg"

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, "mr_ui_perf_app_open"

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string v2, "mr_ui_perf_app_other"

    aput-object v2, v0, v1

    const/16 v1, 0x16

    const-string v2, "mr_ui_perf_popup_build"

    aput-object v2, v0, v1

    const/16 v1, 0x17

    const-string v2, "mr_ui_perf_popup_show"

    aput-object v2, v0, v1

    const/16 v1, 0x18

    const-string v2, "mr_ui_perf_sel"

    aput-object v2, v0, v1

    const/16 v1, 0x19

    const-string v2, "mr_ui_perf_msg"

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    const-string v2, "mr_ui_perf_app_sel"

    aput-object v2, v0, v1

    const/16 v1, 0x1b

    const-string v2, "mr_ui_perf_app_msg"

    aput-object v2, v0, v1

    const/16 v1, 0x1c

    const-string v2, "mr_ui_perf_echo_cut"

    aput-object v2, v0, v1

    const/16 v1, 0x1d

    const-string v2, "mr_ui_perf_echo_full"

    aput-object v2, v0, v1

    const/16 v1, 0x1e

    const-string v2, "mr_ui_perf_echo_one"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    .line 89
    new-array v0, v3, [Ljava/lang/String;

    const-string v1, "create"

    aput-object v1, v0, v5

    const-string v1, "view"

    aput-object v1, v0, v8

    const/4 v1, 0x2

    const-string v2, "open"

    aput-object v2, v0, v1

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

    const/16 v1, 0x9

    const-string v2, "key-letter"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "key-sep"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "key-del"

    aput-object v2, v0, v1

    const-string v1, "key-other"

    aput-object v1, v0, v4

    const/16 v1, 0xd

    const-string v2, "sugg-engine"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "sugg-show"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "open-kb"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, "open-set"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "popup"

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, "app-key"

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, "app-sugg"

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, "app-open"

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string v2, "app-other"

    aput-object v2, v0, v1

    const/16 v1, 0x16

    const-string v2, "popup-build"

    aput-object v2, v0, v1

    const/16 v1, 0x17

    const-string v2, "popup-show"

    aput-object v2, v0, v1

    const/16 v1, 0x18

    const-string v2, "sel"

    aput-object v2, v0, v1

    const/16 v1, 0x19

    const-string v2, "msg"

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    const-string v2, "app-sel"

    aput-object v2, v0, v1

    const/16 v1, 0x1b

    const-string v2, "app-msg"

    aput-object v2, v0, v1

    const/16 v1, 0x1c

    const-string v2, "echo-cut"

    aput-object v2, v0, v1

    const/16 v1, 0x1d

    const-string v2, "echo-full"

    aput-object v2, v0, v1

    const/16 v1, 0x1e

    const-string v2, "echo-one"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->LOG:[Ljava/lang/String;

    .line 94
    const/16 v0, 0x1f00

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    .line 95
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    .line 96
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    .line 97
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    .line 99
    new-array v0, v3, [J

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    .line 101
    sput v4, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    .line 103
    sput-wide v6, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 106
    const/16 v0, 0x100

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    .line 108
    sput-wide v6, Lcom/mrkeyboard/app/MrPerf;->sFakeNanos:J

    .line 111
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    invoke-static {v0, v6, v7}, Ljava/util/Arrays;->fill([JJ)V

    .line 319
    const/4 v0, -0x1

    sput v0, Lcom/mrkeyboard/app/MrPerf;->sFakeMode:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 114
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static add(IJ)V
    .locals 5

    .prologue
    .line 258
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-gez v0, :cond_1

    const/4 v0, 0x0

    .line 259
    :goto_0
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v1, v1, p0

    .line 260
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    mul-int/lit16 v3, p0, 0x100

    and-int/lit16 v4, v1, 0xff

    add-int/2addr v3, v4

    aput v0, v2, v3

    .line 261
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    add-int/lit8 v1, v1, 0x1

    aput v1, v2, p0

    .line 262
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    aget v1, v1, p0

    if-le v0, v1, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    aput v0, v1, p0

    .line 263
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    aput v0, v1, p0

    .line 264
    return-void

    .line 258
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
    .line 163
    const/4 v0, 0x7

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static appEnd()V
    .locals 7

    .prologue
    const/4 v6, 0x7

    .line 167
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    aget-wide v0, v0, v6

    .line 168
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 173
    :goto_0
    return-void

    .line 169
    :cond_0
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const-wide/16 v4, -0x1

    aput-wide v4, v2, v6

    .line 170
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    sub-long v0, v2, v0

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    .line 171
    invoke-static {v6, v0, v1}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    .line 172
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appPlace()I

    move-result v2

    invoke-static {v2, v0, v1}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    goto :goto_0
.end method

.method static appPlace()I
    .locals 14

    .prologue
    const-wide/32 v12, 0xf4240

    const-wide/16 v10, 0x2710

    .line 180
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v6

    .line 181
    const/16 v4, 0x15

    .line 182
    const-wide/16 v2, -0x1

    .line 183
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/4 v1, 0x2

    aget-wide v0, v0, v1

    .line 184
    cmp-long v5, v0, v2

    if-lez v5, :cond_4

    sub-long v8, v6, v0

    div-long/2addr v8, v12

    cmp-long v5, v8, v10

    if-gtz v5, :cond_4

    const/16 v2, 0x14

    .line 185
    :goto_0
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/16 v4, 0x8

    aget-wide v4, v3, v4

    .line 186
    cmp-long v3, v4, v0

    if-lez v3, :cond_0

    sub-long v8, v6, v4

    div-long/2addr v8, v12

    cmp-long v3, v8, v10

    if-gtz v3, :cond_0

    const/16 v2, 0x13

    move-wide v0, v4

    .line 187
    :cond_0
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/4 v4, 0x5

    aget-wide v4, v3, v4

    .line 188
    cmp-long v3, v4, v0

    if-lez v3, :cond_1

    sub-long v8, v6, v4

    div-long/2addr v8, v12

    cmp-long v3, v8, v10

    if-gtz v3, :cond_1

    const/16 v2, 0x12

    move-wide v0, v4

    .line 189
    :cond_1
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/16 v4, 0x18

    aget-wide v4, v3, v4

    .line 190
    cmp-long v3, v4, v0

    if-lez v3, :cond_2

    sub-long v8, v6, v4

    div-long/2addr v8, v12

    cmp-long v3, v8, v10

    if-gtz v3, :cond_2

    const/16 v2, 0x1a

    move-wide v0, v4

    .line 191
    :cond_2
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/16 v4, 0x19

    aget-wide v4, v3, v4

    .line 192
    cmp-long v0, v4, v0

    if-lez v0, :cond_3

    sub-long v0, v6, v4

    div-long/2addr v0, v12

    cmp-long v0, v0, v10

    if-gtz v0, :cond_3

    const/16 v2, 0x1b

    .line 193
    :cond_3
    return v2

    :cond_4
    move-wide v0, v2

    move v2, v4

    goto :goto_0
.end method

.method static begin(I)V
    .locals 4

    .prologue
    .line 246
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    aput-wide v2, v0, p0

    .line 247
    return-void
.end method

.method public static createBegin()V
    .locals 1

    .prologue
    .line 122
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static createEnd()V
    .locals 1

    .prologue
    .line 123
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static echoCutBegin()V
    .locals 1

    .prologue
    .line 219
    const/16 v0, 0x1c

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static echoCutEnd()V
    .locals 1

    .prologue
    .line 220
    const/16 v0, 0x1c

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static echoFullBegin()V
    .locals 1

    .prologue
    .line 221
    const/16 v0, 0x1d

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static echoFullEnd()V
    .locals 1

    .prologue
    .line 222
    const/16 v0, 0x1d

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static echoOneBegin()V
    .locals 1

    .prologue
    .line 224
    const/16 v0, 0x1e

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static echoOneEnd()V
    .locals 1

    .prologue
    .line 225
    const/16 v0, 0x1e

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static end(I)V
    .locals 6

    .prologue
    .line 250
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    aget-wide v0, v0, p0

    .line 251
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 254
    :goto_0
    return-void

    .line 252
    :cond_0
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const-wide/16 v4, -0x1

    aput-wide v4, v2, p0

    .line 253
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
    .line 383
    :try_start_0
    const-string v0, "mr_perf"

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 384
    if-nez v0, :cond_0

    .line 390
    :goto_0
    return-void

    .line 385
    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->summary(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 386
    new-instance v1, Lcom/mrkeyboard/app/MrPerf$Reset;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrPerf$Reset;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 387
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static frameBegin()V
    .locals 1

    .prologue
    .line 133
    const/4 v0, 0x4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static frameEnd()V
    .locals 4

    .prologue
    .line 136
    const/4 v0, 0x4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    .line 137
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 138
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_1

    .line 142
    :cond_0
    :goto_0
    return-void

    .line 139
    :cond_1
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 140
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    sub-long v0, v2, v0

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    .line 141
    const-wide/32 v2, 0x1e8480

    cmp-long v2, v0, v2

    if-gtz v2, :cond_0

    const/4 v2, 0x3

    invoke-static {v2, v0, v1}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    goto :goto_0
.end method

.method static frameName(I)Ljava/lang/String;
    .locals 2

    .prologue
    .line 330
    const/4 v0, 0x1

    if-ne p0, v0, :cond_0

    const-string v0, "mr_ui_perf_frame_gpu"

    .line 332
    :goto_0
    return-object v0

    .line 331
    :cond_0
    const/4 v0, 0x2

    if-ne p0, v0, :cond_1

    const-string v0, "mr_ui_perf_frame_cpu"

    goto :goto_0

    .line 332
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    const/4 v1, 0x4

    aget-object v0, v0, v1

    goto :goto_0
.end method

.method static heapUsed()J
    .locals 4

    .prologue
    .line 308
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    .line 309
    invoke-virtual {v0}, Ljava/lang/Runtime;->totalMemory()J

    move-result-wide v2

    invoke-virtual {v0}, Ljava/lang/Runtime;->freeMemory()J

    move-result-wide v0

    sub-long v0, v2, v0

    return-wide v0
.end method

.method public static keyBegin(I)V
    .locals 1

    .prologue
    .line 146
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->keyKind(I)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    .line 147
    const/4 v0, 0x5

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    .line 148
    sget v0, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    .line 149
    return-void
.end method

.method public static keyEnd()V
    .locals 1

    .prologue
    .line 152
    const/4 v0, 0x5

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    .line 153
    sget v0, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    .line 154
    return-void
.end method

.method static keyKind(I)I
    .locals 1

    .prologue
    .line 158
    const/4 v0, -0x5

    if-ne p0, v0, :cond_0

    const/16 v0, 0xb

    .line 160
    :goto_0
    return v0

    .line 159
    :cond_0
    if-gtz p0, :cond_1

    const/16 v0, 0xc

    goto :goto_0

    .line 160
    :cond_1
    invoke-static {p0}, Ljava/lang/Character;->isLetterOrDigit(I)Z

    move-result v0

    if-eqz v0, :cond_2

    const/16 v0, 0x9

    goto :goto_0

    :cond_2
    const/16 v0, 0xa

    goto :goto_0
.end method

.method static line()Ljava/lang/String;
    .locals 7

    .prologue
    const/16 v6, 0x2f

    const/4 v1, 0x0

    .line 368
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    move v0, v1

    .line 369
    :goto_0
    const/16 v3, 0x1f

    if-ge v0, v3, :cond_1

    .line 370
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->stats(I)[I

    move-result-object v3

    .line 371
    aget v4, v3, v1

    if-nez v4, :cond_0

    .line 369
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 372
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

    .line 373
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget v3, v3, v1

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ") "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 375
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

    .line 376
    invoke-static {}, Landroid/os/Debug;->getNativeHeapAllocatedSize()J

    move-result-wide v4

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 377
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static mode(Landroid/content/Context;)I
    .locals 1

    .prologue
    .line 322
    sget v0, Lcom/mrkeyboard/app/MrPerf;->sFakeMode:I

    if-ltz v0, :cond_0

    sget v0, Lcom/mrkeyboard/app/MrPerf;->sFakeMode:I

    :goto_0
    return v0

    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAccel;->state(Landroid/content/Context;)I

    move-result v0

    goto :goto_0
.end method

.method static ms(I)Ljava/lang/String;
    .locals 4

    .prologue
    .line 313
    int-to-long v0, p0

    const-wide/16 v2, 0x3e8

    mul-long/2addr v0, v2

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static msgBegin()V
    .locals 1

    .prologue
    .line 216
    const/16 v0, 0x19

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static msgEnd()V
    .locals 1

    .prologue
    .line 217
    const/16 v0, 0x19

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static nanos()J
    .locals 4

    .prologue
    .line 117
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
    .line 237
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    const/4 v1, 0x5

    aget v0, v0, v1

    .line 238
    sget v1, Lcom/mrkeyboard/app/MrPerf;->sLoggedKeys:I

    if-ne v0, v1, :cond_0

    .line 241
    :goto_0
    return-void

    .line 239
    :cond_0
    sput v0, Lcom/mrkeyboard/app/MrPerf;->sLoggedKeys:I

    .line 240
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

    .line 128
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    .line 129
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    aget-wide v0, v0, v1

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 130
    return-void
.end method

.method public static openEnd()V
    .locals 1

    .prologue
    .line 132
    const/4 v0, 0x2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static openKbBegin()V
    .locals 1

    .prologue
    .line 202
    const/16 v0, 0xf

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static openKbEnd()V
    .locals 1

    .prologue
    .line 203
    const/16 v0, 0xf

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static openSetBegin()V
    .locals 1

    .prologue
    .line 204
    const/16 v0, 0x10

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static openSetEnd()V
    .locals 1

    .prologue
    .line 205
    const/16 v0, 0x10

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static p95(I)I
    .locals 1

    .prologue
    .line 293
    mul-int/lit8 v0, p0, 0x5f

    add-int/lit8 v0, v0, 0x63

    div-int/lit8 v0, v0, 0x64

    add-int/lit8 v0, v0, -0x1

    .line 294
    if-gez v0, :cond_0

    const/4 v0, 0x0

    :cond_0
    return v0
.end method

.method public static popupBegin()V
    .locals 1

    .prologue
    .line 206
    const/16 v0, 0x11

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static popupBuildBegin()V
    .locals 1

    .prologue
    .line 208
    const/16 v0, 0x16

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static popupBuildEnd()V
    .locals 1

    .prologue
    .line 209
    const/16 v0, 0x16

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static popupEnd()V
    .locals 1

    .prologue
    .line 207
    const/16 v0, 0x11

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static popupShowBegin()V
    .locals 1

    .prologue
    .line 210
    const/16 v0, 0x17

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static popupShowEnd()V
    .locals 1

    .prologue
    .line 211
    const/16 v0, 0x17

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static reset()V
    .locals 4

    .prologue
    const-wide/16 v2, -0x1

    const/4 v1, 0x0

    .line 299
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 300
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 301
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 302
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    invoke-static {v0, v2, v3}, Ljava/util/Arrays;->fill([JJ)V

    .line 303
    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 304
    sput v1, Lcom/mrkeyboard/app/MrPerf;->sLoggedKeys:I

    .line 305
    return-void
.end method

.method public static selBegin()V
    .locals 1

    .prologue
    .line 213
    const/16 v0, 0x18

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static selEnd()V
    .locals 1

    .prologue
    .line 214
    const/16 v0, 0x18

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static stats(I)[I
    .locals 10

    .prologue
    const/16 v3, 0x100

    const/4 v2, 0x0

    .line 271
    const/4 v0, 0x5

    new-array v0, v0, [I

    .line 272
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v1, v1, p0

    .line 273
    aput v1, v0, v2

    .line 274
    if-ge v1, v3, :cond_0

    move v3, v1

    .line 275
    :cond_0
    if-nez v3, :cond_1

    .line 288
    :goto_0
    return-object v0

    .line 276
    :cond_1
    const-wide/16 v4, 0x0

    .line 277
    mul-int/lit16 v6, p0, 0x100

    move v1, v2

    .line 278
    :goto_1
    if-ge v1, v3, :cond_2

    .line 279
    sget-object v7, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    add-int v8, v6, v1

    aget v7, v7, v8

    .line 280
    sget-object v8, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    aput v7, v8, v1

    .line 281
    int-to-long v8, v7

    add-long/2addr v4, v8

    .line 278
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 283
    :cond_2
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    invoke-static {v1, v2, v3}, Ljava/util/Arrays;->sort([III)V

    .line 284
    const/4 v1, 0x1

    int-to-long v6, v3

    div-long/2addr v4, v6

    long-to-int v2, v4

    aput v2, v0, v1

    .line 285
    const/4 v1, 0x2

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->p95(I)I

    move-result v3

    aget v2, v2, v3

    aput v2, v0, v1

    .line 286
    const/4 v1, 0x3

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    aget v2, v2, p0

    aput v2, v0, v1

    .line 287
    const/4 v1, 0x4

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    aget v2, v2, p0

    aput v2, v0, v1

    goto :goto_0
.end method

.method public static suggBegin()V
    .locals 1

    .prologue
    .line 196
    const/16 v0, 0x8

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static suggEnd()V
    .locals 1

    .prologue
    .line 197
    const/16 v0, 0x8

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static suggEngineBegin()V
    .locals 1

    .prologue
    .line 198
    const/16 v0, 0xd

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static suggEngineEnd()V
    .locals 1

    .prologue
    .line 199
    const/16 v0, 0xd

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static suggShowBegin()V
    .locals 1

    .prologue
    .line 200
    const/16 v0, 0xe

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static suggShowEnd()V
    .locals 1

    .prologue
    .line 201
    const/16 v0, 0xe

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static summary(Landroid/content/Context;)Ljava/lang/String;
    .locals 12

    .prologue
    const/16 v11, 0xa

    const/4 v10, 0x2

    const/4 v9, 0x4

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 337
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    move v3, v2

    .line 338
    :goto_0
    const/16 v0, 0x1f

    if-ge v3, v0, :cond_6

    .line 339
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->stats(I)[I

    move-result-object v5

    .line 340
    aget v0, v5, v2

    if-nez v0, :cond_1

    .line 338
    :cond_0
    :goto_1
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_0

    .line 341
    :cond_1
    if-ne v3, v9, :cond_4

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->mode(Landroid/content/Context;)I

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->frameName(I)Ljava/lang/String;

    move-result-object v0

    :goto_2
    new-array v6, v2, [Ljava/lang/Object;

    invoke-static {p0, v0, v6}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 343
    if-nez v0, :cond_2

    if-ne v3, v9, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    aget-object v0, v0, v9

    new-array v6, v2, [Ljava/lang/Object;

    invoke-static {p0, v0, v6}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 344
    :cond_2
    if-eqz v0, :cond_0

    .line 345
    aget v6, v5, v2

    if-ne v6, v1, :cond_5

    .line 346
    const-string v6, "mr_ui_perf_one"

    new-array v7, v10, [Ljava/lang/Object;

    aput-object v0, v7, v2

    aget v0, v5, v9

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v7, v1

    invoke-static {p0, v6, v7}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 348
    :goto_3
    if-eqz v0, :cond_0

    .line 349
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I

    move-result v5

    if-lez v5, :cond_3

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 350
    :cond_3
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 341
    :cond_4
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    aget-object v0, v0, v3

    goto :goto_2

    .line 347
    :cond_5
    const-string v6, "mr_ui_perf_stat"

    const/4 v7, 0x5

    new-array v7, v7, [Ljava/lang/Object;

    aput-object v0, v7, v2

    aget v0, v5, v1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v7, v1

    aget v0, v5, v10

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v7, v10

    const/4 v0, 0x3

    const/4 v8, 0x3

    aget v8, v5, v8

    invoke-static {v8}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v8

    aput-object v8, v7, v0

    aget v0, v5, v2

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v7, v9

    invoke-static {p0, v6, v7}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_3

    .line 352
    :cond_6
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    if-lez v0, :cond_a

    move v0, v1

    .line 353
    :goto_4
    if-nez v0, :cond_7

    .line 354
    const-string v3, "mr_ui_perf_none"

    new-array v5, v2, [Ljava/lang/Object;

    invoke-static {p0, v3, v5}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 355
    if-eqz v3, :cond_7

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 357
    :cond_7
    const-string v3, "mr_ui_perf_mem"

    new-array v5, v10, [Ljava/lang/Object;

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

    .line 358
    if-eqz v1, :cond_8

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 359
    :cond_8
    if-eqz v0, :cond_9

    .line 360
    const-string v0, "mr_ui_perf_reset"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 361
    if-eqz v0, :cond_9

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 363
    :cond_9
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_a
    move v0, v2

    .line 352
    goto :goto_4
.end method

.method public static touch(Landroid/view/MotionEvent;)V
    .locals 6

    .prologue
    .line 229
    if-nez p0, :cond_1

    .line 233
    :cond_0
    :goto_0
    return-void

    .line 230
    :cond_1
    invoke-virtual {p0}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    .line 231
    if-eqz v0, :cond_2

    const/4 v1, 0x5

    if-ne v0, v1, :cond_0

    .line 232
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
    .line 124
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static viewEnd()V
    .locals 1

    .prologue
    .line 125
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method
