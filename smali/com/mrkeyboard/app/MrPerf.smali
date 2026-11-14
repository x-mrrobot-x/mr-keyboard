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

.field static final CAPS_FLUSH:I = 0x22

.field static final CAPS_RUN:I = 0x21

.field static final CREATE:I = 0x0

.field static final ECHO_CUT:I = 0x1c

.field static final ECHO_DROP:I = 0x20

.field static final ECHO_FULL:I = 0x1d

.field static final ECHO_ONE:I = 0x1e

.field static final ECHO_RUN:I = 0x1f

.field static final FRAME:I = 0x4

.field static final KEY:I = 0x5

.field static final KEY_DEL:I = 0xb

.field static final KEY_LETTER:I = 0x9

.field static final KEY_OTHER:I = 0xc

.field static final KEY_SEP:I = 0xa

.field static final KINDS:I = 0x23

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

.field static final STARTS_KEY:Ljava/lang/String; = "starts"

.field static final STARTS_MAX:I = 0x9

.field static final STARTS_PREFS:Ljava/lang/String; = "mr_perf"

.field static final SUGG:I = 0x8

.field static final SUGG_ENGINE:I = 0xd

.field static final SUGG_SHOW:I = 0xe

.field static final TAG:Ljava/lang/String; = "MrPerf"

.field static final TOUCH:I = 0x6

.field static final VIEW:I = 0x1

.field private static sCapsAt:J

.field private static final sCount:[I

.field private static sEchoAt:J

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

.field static sStartSaved:Z


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .prologue
    const/4 v8, 0x1

    const/4 v7, 0x0

    const/16 v6, 0xc

    const-wide/16 v4, -0x1

    const/16 v3, 0x23

    .line 106
    new-array v0, v3, [Ljava/lang/String;

    const-string v1, "mr_ui_perf_create"

    aput-object v1, v0, v7

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

    aput-object v1, v0, v6

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

    const/16 v1, 0x1f

    const-string v2, "mr_ui_perf_echo_run"

    aput-object v2, v0, v1

    const/16 v1, 0x20

    const-string v2, "mr_ui_perf_echo_drop"

    aput-object v2, v0, v1

    const/16 v1, 0x21

    const-string v2, "mr_ui_perf_caps_run"

    aput-object v2, v0, v1

    const/16 v1, 0x22

    const-string v2, "mr_ui_perf_caps_flush"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    .line 116
    new-array v0, v3, [Ljava/lang/String;

    const-string v1, "create"

    aput-object v1, v0, v7

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

    aput-object v1, v0, v6

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

    const/16 v1, 0x1f

    const-string v2, "echo-run"

    aput-object v2, v0, v1

    const/16 v1, 0x20

    const-string v2, "echo-drop"

    aput-object v2, v0, v1

    const/16 v1, 0x21

    const-string v2, "caps-run"

    aput-object v2, v0, v1

    const/16 v1, 0x22

    const-string v2, "caps-flush"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->LOG:[Ljava/lang/String;

    .line 121
    const/16 v0, 0x2300

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    .line 122
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    .line 123
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    .line 124
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    .line 126
    new-array v0, v3, [J

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    .line 128
    sput v6, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    .line 130
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 132
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 134
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 139
    const/16 v0, 0x100

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    .line 141
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sFakeNanos:J

    .line 144
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    invoke-static {v0, v4, v5}, Ljava/util/Arrays;->fill([JJ)V

    .line 480
    const/4 v0, -0x1

    sput v0, Lcom/mrkeyboard/app/MrPerf;->sFakeMode:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 147
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static add(IJ)V
    .locals 5

    .prologue
    .line 335
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-gez v0, :cond_1

    const/4 v0, 0x0

    .line 336
    :goto_0
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v1, v1, p0

    .line 337
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    mul-int/lit16 v3, p0, 0x100

    and-int/lit16 v4, v1, 0xff

    add-int/2addr v3, v4

    aput v0, v2, v3

    .line 338
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    add-int/lit8 v1, v1, 0x1

    aput v1, v2, p0

    .line 339
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    aget v1, v1, p0

    if-le v0, v1, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    aput v0, v1, p0

    .line 340
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    aput v0, v1, p0

    .line 341
    return-void

    .line 335
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

.method static addStart(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .prologue
    const/16 v3, 0x3b

    .line 417
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_2

    .line 418
    :cond_0
    :goto_0
    const/4 v1, 0x1

    .line 419
    const/4 v0, 0x0

    :goto_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v0, v2, :cond_3

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    if-ne v2, v3, :cond_1

    add-int/lit8 v1, v1, 0x1

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 417
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ";"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    .line 420
    :cond_3
    :goto_2
    const/16 v0, 0x9

    if-le v1, v0, :cond_4

    invoke-virtual {p1, v3}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    add-int/lit8 v1, v1, -0x1

    goto :goto_2

    .line 421
    :cond_4
    return-object p1
.end method

.method public static appBegin()V
    .locals 1

    .prologue
    .line 196
    const/4 v0, 0x7

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static appEnd()V
    .locals 7

    .prologue
    const/4 v6, 0x7

    .line 200
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    aget-wide v0, v0, v6

    .line 201
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 206
    :goto_0
    return-void

    .line 202
    :cond_0
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const-wide/16 v4, -0x1

    aput-wide v4, v2, v6

    .line 203
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    sub-long v0, v2, v0

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    .line 204
    invoke-static {v6, v0, v1}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    .line 205
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

    .line 213
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v6

    .line 214
    const/16 v4, 0x15

    .line 215
    const-wide/16 v2, -0x1

    .line 216
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/4 v1, 0x2

    aget-wide v0, v0, v1

    .line 217
    cmp-long v5, v0, v2

    if-lez v5, :cond_4

    sub-long v8, v6, v0

    div-long/2addr v8, v12

    cmp-long v5, v8, v10

    if-gtz v5, :cond_4

    const/16 v2, 0x14

    .line 218
    :goto_0
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/16 v4, 0x8

    aget-wide v4, v3, v4

    .line 219
    cmp-long v3, v4, v0

    if-lez v3, :cond_0

    sub-long v8, v6, v4

    div-long/2addr v8, v12

    cmp-long v3, v8, v10

    if-gtz v3, :cond_0

    const/16 v2, 0x13

    move-wide v0, v4

    .line 220
    :cond_0
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/4 v4, 0x5

    aget-wide v4, v3, v4

    .line 221
    cmp-long v3, v4, v0

    if-lez v3, :cond_1

    sub-long v8, v6, v4

    div-long/2addr v8, v12

    cmp-long v3, v8, v10

    if-gtz v3, :cond_1

    const/16 v2, 0x12

    move-wide v0, v4

    .line 222
    :cond_1
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/16 v4, 0x18

    aget-wide v4, v3, v4

    .line 223
    cmp-long v3, v4, v0

    if-lez v3, :cond_2

    sub-long v8, v6, v4

    div-long/2addr v8, v12

    cmp-long v3, v8, v10

    if-gtz v3, :cond_2

    const/16 v2, 0x1a

    move-wide v0, v4

    .line 224
    :cond_2
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/16 v4, 0x19

    aget-wide v4, v3, v4

    .line 225
    cmp-long v0, v4, v0

    if-lez v0, :cond_3

    sub-long v0, v6, v4

    div-long/2addr v0, v12

    cmp-long v0, v0, v10

    if-gtz v0, :cond_3

    const/16 v2, 0x1b

    .line 226
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
    .line 323
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    aput-wide v2, v0, p0

    .line 324
    return-void
.end method

.method public static capsFlushed()V
    .locals 6

    .prologue
    .line 295
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 296
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 299
    :goto_0
    return-void

    .line 297
    :cond_0
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 298
    const/16 v2, 0x22

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v4

    sub-long v0, v4, v0

    const-wide/16 v4, 0x3e8

    div-long/2addr v0, v4

    invoke-static {v2, v0, v1}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    goto :goto_0
.end method

.method public static capsForget()V
    .locals 2

    .prologue
    .line 302
    const-wide/16 v0, -0x1

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    return-void
.end method

.method public static capsPosted()V
    .locals 2

    .prologue
    .line 283
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v0

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    return-void
.end method

.method public static capsRan()V
    .locals 6

    .prologue
    .line 287
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 288
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 291
    :goto_0
    return-void

    .line 289
    :cond_0
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 290
    const/16 v2, 0x21

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v4

    sub-long v0, v4, v0

    const-wide/16 v4, 0x3e8

    div-long/2addr v0, v4

    invoke-static {v2, v0, v1}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    goto :goto_0
.end method

.method static clearStarts(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 427
    :try_start_0
    const-string v0, "mr_perf"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "starts"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 431
    :goto_0
    return-void

    .line 428
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static createBegin()V
    .locals 1

    .prologue
    .line 155
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static createEnd()V
    .locals 1

    .prologue
    .line 156
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static echoCutBegin()V
    .locals 1

    .prologue
    .line 252
    const/16 v0, 0x1c

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static echoCutEnd()V
    .locals 1

    .prologue
    .line 253
    const/16 v0, 0x1c

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static echoDropped()V
    .locals 6

    .prologue
    .line 276
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 277
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 280
    :goto_0
    return-void

    .line 278
    :cond_0
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 279
    const/16 v2, 0x20

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v4

    sub-long v0, v4, v0

    const-wide/16 v4, 0x3e8

    div-long/2addr v0, v4

    invoke-static {v2, v0, v1}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    goto :goto_0
.end method

.method public static echoFullBegin()V
    .locals 1

    .prologue
    .line 254
    const/16 v0, 0x1d

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static echoFullEnd()V
    .locals 1

    .prologue
    .line 255
    const/16 v0, 0x1d

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static echoOneBegin()V
    .locals 1

    .prologue
    .line 257
    const/16 v0, 0x1e

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static echoOneEnd()V
    .locals 1

    .prologue
    .line 258
    const/16 v0, 0x1e

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static echoPosted()V
    .locals 2

    .prologue
    .line 261
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v0

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    return-void
.end method

.method public static echoRan()V
    .locals 6

    .prologue
    .line 265
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 266
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 269
    :goto_0
    return-void

    .line 267
    :cond_0
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 268
    const/16 v2, 0x1f

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v4

    sub-long v0, v4, v0

    const-wide/16 v4, 0x3e8

    div-long/2addr v0, v4

    invoke-static {v2, v0, v1}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    goto :goto_0
.end method

.method static end(I)V
    .locals 6

    .prologue
    .line 327
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    aget-wide v0, v0, p0

    .line 328
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 331
    :goto_0
    return-void

    .line 329
    :cond_0
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const-wide/16 v4, -0x1

    aput-wide v4, v2, p0

    .line 330
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
    .line 560
    :try_start_0
    const-string v0, "mr_perf"

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 561
    if-nez v0, :cond_0

    .line 568
    :goto_0
    return-void

    .line 562
    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->saveStart(Landroid/content/Context;)V

    .line 563
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->summary(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 564
    new-instance v1, Lcom/mrkeyboard/app/MrPerf$Reset;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrPerf$Reset;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 565
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static frameBegin()V
    .locals 1

    .prologue
    .line 166
    const/4 v0, 0x4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static frameEnd()V
    .locals 4

    .prologue
    .line 169
    const/4 v0, 0x4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    .line 170
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 171
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_1

    .line 175
    :cond_0
    :goto_0
    return-void

    .line 172
    :cond_1
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 173
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    sub-long v0, v2, v0

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    .line 174
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
    .line 491
    const/4 v0, 0x1

    if-ne p0, v0, :cond_0

    const-string v0, "mr_ui_perf_frame_gpu"

    .line 493
    :goto_0
    return-object v0

    .line 492
    :cond_0
    const/4 v0, 0x2

    if-ne p0, v0, :cond_1

    const-string v0, "mr_ui_perf_frame_cpu"

    goto :goto_0

    .line 493
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    const/4 v1, 0x4

    aget-object v0, v0, v1

    goto :goto_0
.end method

.method static heapUsed()J
    .locals 4

    .prologue
    .line 469
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    .line 470
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
    .line 179
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->keyKind(I)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    .line 180
    const/4 v0, 0x5

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    .line 181
    sget v0, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    .line 182
    return-void
.end method

.method public static keyEnd()V
    .locals 1

    .prologue
    .line 185
    const/4 v0, 0x5

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    .line 186
    sget v0, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    .line 187
    return-void
.end method

.method static keyKind(I)I
    .locals 1

    .prologue
    .line 191
    const/4 v0, -0x5

    if-ne p0, v0, :cond_0

    const/16 v0, 0xb

    .line 193
    :goto_0
    return v0

    .line 192
    :cond_0
    if-gtz p0, :cond_1

    const/16 v0, 0xc

    goto :goto_0

    .line 193
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

    .line 545
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    move v0, v1

    .line 546
    :goto_0
    const/16 v3, 0x23

    if-ge v0, v3, :cond_1

    .line 547
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->stats(I)[I

    move-result-object v3

    .line 548
    aget v4, v3, v1

    if-nez v4, :cond_0

    .line 546
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 549
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

    .line 550
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget v3, v3, v1

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ") "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 552
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

    .line 553
    invoke-static {}, Landroid/os/Debug;->getNativeHeapAllocatedSize()J

    move-result-wide v4

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 554
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static mode(Landroid/content/Context;)I
    .locals 1

    .prologue
    .line 483
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
    .line 474
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
    .line 249
    const/16 v0, 0x19

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static msgEnd()V
    .locals 1

    .prologue
    .line 250
    const/16 v0, 0x19

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static nanos()J
    .locals 4

    .prologue
    .line 150
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
    .line 314
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    const/4 v1, 0x5

    aget v0, v0, v1

    .line 315
    sget v1, Lcom/mrkeyboard/app/MrPerf;->sLoggedKeys:I

    if-ne v0, v1, :cond_0

    .line 318
    :goto_0
    return-void

    .line 316
    :cond_0
    sput v0, Lcom/mrkeyboard/app/MrPerf;->sLoggedKeys:I

    .line 317
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

    .line 161
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    .line 162
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    aget-wide v0, v0, v1

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 163
    return-void
.end method

.method public static openEnd()V
    .locals 1

    .prologue
    .line 165
    const/4 v0, 0x2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static openKbBegin()V
    .locals 1

    .prologue
    .line 235
    const/16 v0, 0xf

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static openKbEnd()V
    .locals 1

    .prologue
    .line 236
    const/16 v0, 0xf

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static openSetBegin()V
    .locals 1

    .prologue
    .line 237
    const/16 v0, 0x10

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static openSetEnd()V
    .locals 1

    .prologue
    .line 238
    const/16 v0, 0x10

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static p95(I)I
    .locals 1

    .prologue
    .line 370
    mul-int/lit8 v0, p0, 0x5f

    add-int/lit8 v0, v0, 0x63

    div-int/lit8 v0, v0, 0x64

    add-int/lit8 v0, v0, -0x1

    .line 371
    if-gez v0, :cond_0

    const/4 v0, 0x0

    :cond_0
    return v0
.end method

.method public static popupBegin()V
    .locals 1

    .prologue
    .line 239
    const/16 v0, 0x11

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static popupBuildBegin()V
    .locals 1

    .prologue
    .line 241
    const/16 v0, 0x16

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static popupBuildEnd()V
    .locals 1

    .prologue
    .line 242
    const/16 v0, 0x16

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static popupEnd()V
    .locals 1

    .prologue
    .line 240
    const/16 v0, 0x11

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static popupShowBegin()V
    .locals 1

    .prologue
    .line 243
    const/16 v0, 0x17

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static popupShowEnd()V
    .locals 1

    .prologue
    .line 244
    const/16 v0, 0x17

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static reset()V
    .locals 4

    .prologue
    const-wide/16 v2, -0x1

    const/4 v1, 0x0

    .line 376
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 377
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 378
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 379
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    invoke-static {v0, v2, v3}, Ljava/util/Arrays;->fill([JJ)V

    .line 380
    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 381
    sput v1, Lcom/mrkeyboard/app/MrPerf;->sLoggedKeys:I

    .line 382
    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 383
    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 384
    return-void
.end method

.method static saveStart(Landroid/content/Context;)V
    .locals 6

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 404
    sget-boolean v0, Lcom/mrkeyboard/app/MrPerf;->sStartSaved:Z

    if-nez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v0, v0, v1

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v0, v0, v2

    if-nez v0, :cond_1

    .line 413
    :cond_0
    :goto_0
    return-void

    .line 406
    :cond_1
    :try_start_0
    const-string v0, "mr_perf"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 407
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    const/4 v3, 0x0

    aget v2, v2, v3

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    const/16 v3, 0x100

    aget v2, v2, v3

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 408
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    const-string v3, "starts"

    const-string v4, "starts"

    const-string v5, ""

    invoke-interface {v0, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPerf;->addStart(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v3, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 409
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrPerf;->sStartSaved:Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 410
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static selBegin()V
    .locals 1

    .prologue
    .line 246
    const/16 v0, 0x18

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static selEnd()V
    .locals 1

    .prologue
    .line 247
    const/16 v0, 0x18

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static startStats(Ljava/lang/String;I)[I
    .locals 8

    .prologue
    const/16 v7, 0x9

    const/4 v4, 0x0

    .line 439
    new-array v5, v7, [I

    move v1, v4

    move v2, v4

    .line 442
    :goto_0
    if-eqz p0, :cond_3

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-gt v1, v0, :cond_3

    if-ge v2, v7, :cond_3

    .line 443
    const/16 v0, 0x3b

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    .line 444
    if-gez v0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 445
    :cond_0
    const/16 v3, 0x2c

    invoke-virtual {p0, v3, v1}, Ljava/lang/String;->indexOf(II)I

    move-result v3

    .line 446
    if-le v3, v1, :cond_2

    add-int/lit8 v6, v0, -0x1

    if-ge v3, v6, :cond_2

    .line 448
    :try_start_0
    invoke-virtual {p0, v1, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 449
    add-int/lit8 v3, v3, 0x1

    invoke-virtual {p0, v3, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 450
    if-nez p1, :cond_1

    move v3, v1

    .line 451
    :cond_1
    if-ltz v3, :cond_5

    add-int/lit8 v1, v2, 0x1

    :try_start_1
    aput v3, v5, v2
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_1

    :goto_1
    move v2, v1

    .line 456
    :cond_2
    :goto_2
    add-int/lit8 v0, v0, 0x1

    move v1, v0

    .line 457
    goto :goto_0

    .line 458
    :cond_3
    const/4 v0, 0x4

    new-array v0, v0, [I

    .line 459
    aput v2, v0, v4

    .line 460
    if-nez v2, :cond_4

    .line 465
    :goto_3
    return-object v0

    .line 461
    :cond_4
    invoke-static {v5, v4, v2}, Ljava/util/Arrays;->sort([III)V

    .line 462
    const/4 v1, 0x1

    aget v3, v5, v4

    aput v3, v0, v1

    .line 463
    const/4 v1, 0x2

    mul-int/lit8 v3, v2, 0x32

    add-int/lit8 v3, v3, 0x63

    div-int/lit8 v3, v3, 0x64

    add-int/lit8 v3, v3, -0x1

    aget v3, v5, v3

    aput v3, v0, v1

    .line 464
    const/4 v1, 0x3

    add-int/lit8 v2, v2, -0x1

    aget v2, v5, v2

    aput v2, v0, v1

    goto :goto_3

    .line 452
    :catch_0
    move-exception v1

    goto :goto_2

    :catch_1
    move-exception v2

    move v2, v1

    goto :goto_2

    :cond_5
    move v1, v2

    goto :goto_1
.end method

.method static startsOf(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 391
    :try_start_0
    const-string v0, "mr_perf"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "starts"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 392
    if-nez v0, :cond_0

    const-string v0, ""
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 394
    :cond_0
    :goto_0
    return-object v0

    .line 393
    :catch_0
    move-exception v0

    .line 394
    const-string v0, ""

    goto :goto_0
.end method

.method static stats(I)[I
    .locals 10

    .prologue
    const/16 v3, 0x100

    const/4 v2, 0x0

    .line 348
    const/4 v0, 0x5

    new-array v0, v0, [I

    .line 349
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v1, v1, p0

    .line 350
    aput v1, v0, v2

    .line 351
    if-ge v1, v3, :cond_0

    move v3, v1

    .line 352
    :cond_0
    if-nez v3, :cond_1

    .line 365
    :goto_0
    return-object v0

    .line 353
    :cond_1
    const-wide/16 v4, 0x0

    .line 354
    mul-int/lit16 v6, p0, 0x100

    move v1, v2

    .line 355
    :goto_1
    if-ge v1, v3, :cond_2

    .line 356
    sget-object v7, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    add-int v8, v6, v1

    aget v7, v7, v8

    .line 357
    sget-object v8, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    aput v7, v8, v1

    .line 358
    int-to-long v8, v7

    add-long/2addr v4, v8

    .line 355
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 360
    :cond_2
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    invoke-static {v1, v2, v3}, Ljava/util/Arrays;->sort([III)V

    .line 361
    const/4 v1, 0x1

    int-to-long v6, v3

    div-long/2addr v4, v6

    long-to-int v2, v4

    aput v2, v0, v1

    .line 362
    const/4 v1, 0x2

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->p95(I)I

    move-result v3

    aget v2, v2, v3

    aput v2, v0, v1

    .line 363
    const/4 v1, 0x3

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    aget v2, v2, p0

    aput v2, v0, v1

    .line 364
    const/4 v1, 0x4

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    aget v2, v2, p0

    aput v2, v0, v1

    goto :goto_0
.end method

.method public static suggBegin()V
    .locals 1

    .prologue
    .line 229
    const/16 v0, 0x8

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static suggEnd()V
    .locals 1

    .prologue
    .line 230
    const/16 v0, 0x8

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static suggEngineBegin()V
    .locals 1

    .prologue
    .line 231
    const/16 v0, 0xd

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static suggEngineEnd()V
    .locals 1

    .prologue
    .line 232
    const/16 v0, 0xd

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static suggShowBegin()V
    .locals 1

    .prologue
    .line 233
    const/16 v0, 0xe

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static suggShowEnd()V
    .locals 1

    .prologue
    .line 234
    const/16 v0, 0xe

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static summary(Landroid/content/Context;)Ljava/lang/String;
    .locals 14

    .prologue
    const/4 v13, 0x3

    const/4 v12, 0x4

    const/4 v11, 0x2

    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 498
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    .line 499
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->startsOf(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v7

    move v5, v1

    .line 500
    :goto_0
    const/16 v0, 0x23

    if-ge v5, v0, :cond_b

    .line 501
    invoke-static {v5}, Lcom/mrkeyboard/app/MrPerf;->stats(I)[I

    move-result-object v8

    .line 502
    if-eqz v5, :cond_0

    if-ne v5, v2, :cond_2

    :cond_0
    move v0, v2

    .line 504
    :goto_1
    aget v3, v8, v1

    if-nez v3, :cond_3

    if-nez v0, :cond_3

    .line 500
    :cond_1
    :goto_2
    add-int/lit8 v0, v5, 0x1

    move v5, v0

    goto :goto_0

    :cond_2
    move v0, v1

    .line 502
    goto :goto_1

    .line 505
    :cond_3
    if-ne v5, v12, :cond_7

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->mode(Landroid/content/Context;)I

    move-result v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->frameName(I)Ljava/lang/String;

    move-result-object v3

    :goto_3
    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 507
    if-nez v3, :cond_10

    if-ne v5, v12, :cond_10

    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    aget-object v3, v3, v12

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    move-object v4, v3

    .line 508
    :goto_4
    if-eqz v4, :cond_1

    .line 509
    aget v3, v8, v1

    if-lez v3, :cond_5

    .line 510
    aget v3, v8, v1

    if-ne v3, v2, :cond_8

    .line 511
    const-string v3, "mr_ui_perf_one"

    new-array v9, v11, [Ljava/lang/Object;

    aput-object v4, v9, v1

    aget v8, v8, v12

    invoke-static {v8}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v8

    aput-object v8, v9, v2

    invoke-static {p0, v3, v9}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 513
    :goto_5
    if-eqz v3, :cond_5

    .line 514
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->length()I

    move-result v8

    if-lez v8, :cond_4

    const/16 v8, 0xa

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 515
    :cond_4
    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 518
    :cond_5
    if-eqz v0, :cond_1

    .line 520
    if-nez v5, :cond_9

    move v0, v1

    :goto_6
    invoke-static {v7, v0}, Lcom/mrkeyboard/app/MrPerf;->startStats(Ljava/lang/String;I)[I

    move-result-object v0

    .line 521
    aget v3, v0, v1

    if-ge v3, v11, :cond_a

    const/4 v0, 0x0

    .line 523
    :goto_7
    if-eqz v0, :cond_1

    .line 524
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    if-lez v3, :cond_6

    const/16 v3, 0xa

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 525
    :cond_6
    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_2

    .line 505
    :cond_7
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    aget-object v3, v3, v5

    goto :goto_3

    .line 512
    :cond_8
    const-string v3, "mr_ui_perf_stat"

    const/4 v9, 0x5

    new-array v9, v9, [Ljava/lang/Object;

    aput-object v4, v9, v1

    aget v10, v8, v2

    invoke-static {v10}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v9, v2

    aget v10, v8, v11

    invoke-static {v10}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v9, v11

    aget v10, v8, v13

    invoke-static {v10}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v9, v13

    aget v8, v8, v1

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v9, v12

    invoke-static {p0, v3, v9}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    goto :goto_5

    :cond_9
    move v0, v2

    .line 520
    goto :goto_6

    .line 522
    :cond_a
    const-string v3, "mr_ui_perf_starts"

    const/4 v8, 0x5

    new-array v8, v8, [Ljava/lang/Object;

    aput-object v4, v8, v1

    aget v4, v0, v1

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v8, v2

    aget v4, v0, v2

    invoke-static {v4}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v8, v11

    aget v4, v0, v11

    invoke-static {v4}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v8, v13

    aget v0, v0, v13

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v8, v12

    invoke-static {p0, v3, v8}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_7

    .line 529
    :cond_b
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    if-lez v0, :cond_f

    move v0, v2

    .line 530
    :goto_8
    if-nez v0, :cond_c

    .line 531
    const-string v3, "mr_ui_perf_none"

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 532
    if-eqz v3, :cond_c

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 534
    :cond_c
    const-string v3, "mr_ui_perf_mem"

    new-array v4, v11, [Ljava/lang/Object;

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->heapUsed()J

    move-result-wide v8

    invoke-static {v8, v9}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v1

    invoke-static {}, Landroid/os/Debug;->getNativeHeapAllocatedSize()J

    move-result-wide v8

    invoke-static {v8, v9}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v2

    invoke-static {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 535
    if-eqz v2, :cond_d

    const/16 v3, 0xa

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 536
    :cond_d
    if-eqz v0, :cond_e

    .line 537
    const-string v0, "mr_ui_perf_reset"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 538
    if-eqz v0, :cond_e

    const/16 v1, 0xa

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 540
    :cond_e
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_f
    move v0, v1

    .line 529
    goto :goto_8

    :cond_10
    move-object v4, v3

    goto/16 :goto_4
.end method

.method public static touch(Landroid/view/MotionEvent;)V
    .locals 6

    .prologue
    .line 306
    if-nez p0, :cond_1

    .line 310
    :cond_0
    :goto_0
    return-void

    .line 307
    :cond_1
    invoke-virtual {p0}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    .line 308
    if-eqz v0, :cond_2

    const/4 v1, 0x5

    if-ne v0, v1, :cond_0

    .line 309
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
    .line 157
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static viewEnd()V
    .locals 1

    .prologue
    .line 158
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method
