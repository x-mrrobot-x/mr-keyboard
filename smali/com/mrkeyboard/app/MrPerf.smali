.class public final Lcom/mrkeyboard/app/MrPerf;
.super Ljava/lang/Object;
.source "MrPerf.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrPerf$Reset;,
        Lcom/mrkeyboard/app/MrPerf$Trim;
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

.field static final CREATE_SUGG:I = 0x24

.field static final CREATE_SUPER:I = 0x23

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

.field static final KINDS:I = 0x27

.field static final LOG:[Ljava/lang/String;

.field static final LONG_LATE:I = 0x26

.field static final MSG:I = 0x19

.field static final NAMES:[Ljava/lang/String;

.field static final OPEN:I = 0x2

.field static final OPEN_KB:I = 0xf

.field static final OPEN_SET:I = 0x10

.field static final PLACE_MAX_MS:I = 0x2710

.field static final POPUP:I = 0x11

.field static final POPUP_BUILD:I = 0x16

.field static final POPUP_SHOW:I = 0x17

.field static final PRESS_MAX_MS:I = 0x7d0

.field static final ROW:Ljava/lang/String; = "mr_perf"

.field static final SEL:I = 0x18

.field static final SHEET_KEY:I = -0x12c

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

.field static final TRIM:I = 0x25

.field static final VIEW:I = 0x1

.field private static sCapsAt:J

.field private static final sCount:[I

.field private static sEchoAt:J

.field static sFakeMode:I

.field static sFakeNanos:J

.field private static sKeyKind:I

.field private static final sLast:[I

.field private static sLastEnd:J

.field private static sLoggedKeys:I

.field private static final sMax:[I

.field private static sPopupCode:I

.field private static sPressBehindMs:J

.field private static sPressEventNs:J

.field private static sPressFrameNs:J

.field private static sPressHandledNs:J

.field private static sPressOn:Z

.field private static sPressOpen:Z

.field private static sPressSeenNs:J

.field private static final sRing:[I

.field private static final sScratch:[I

.field private static sShownFrom:J

.field private static final sStart:[J

.field static sStartSaved:Z

.field private static sWorstCode:I

.field private static sWorstLate:J

.field private static sWorstPlanned:J

.field private static sWorstPopup:J

.field private static sWorstPress:J

.field private static sWorstPressBehind:J

.field private static sWorstPressDraw:J

.field private static sWorstPressHandle:J

.field private static sWorstPressSeen:J

.field private static sWorstPressWait:J

.field private static sWorstSeen:J

.field private static sWorstTimer:J


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .prologue
    const/4 v8, 0x1

    const/4 v7, 0x0

    const/16 v6, 0xc

    const/16 v3, 0x27

    const-wide/16 v4, -0x1

    .line 119
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

    const/16 v1, 0x23

    const-string v2, "mr_ui_perf_create_super"

    aput-object v2, v0, v1

    const/16 v1, 0x24

    const-string v2, "mr_ui_perf_create_sugg"

    aput-object v2, v0, v1

    const/16 v1, 0x25

    const-string v2, "mr_ui_perf_trim"

    aput-object v2, v0, v1

    const/16 v1, 0x26

    const-string v2, "mr_ui_perf_long_late"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    .line 130
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

    const/16 v1, 0x23

    const-string v2, "create-super"

    aput-object v2, v0, v1

    const/16 v1, 0x24

    const-string v2, "create-sugg"

    aput-object v2, v0, v1

    const/16 v1, 0x25

    const-string v2, "trim"

    aput-object v2, v0, v1

    const/16 v1, 0x26

    const-string v2, "long-late"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->LOG:[Ljava/lang/String;

    .line 136
    const/16 v0, 0x2700

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    .line 137
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    .line 138
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    .line 139
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    .line 141
    new-array v0, v3, [J

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    .line 143
    sput v6, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    .line 145
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 147
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 149
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 160
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sWorstLate:J

    .line 172
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sPressHandledNs:J

    .line 176
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sPressFrameNs:J

    .line 178
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sLastEnd:J

    .line 184
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sWorstPress:J

    .line 185
    const/16 v0, 0x100

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    .line 187
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sFakeNanos:J

    .line 190
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    invoke-static {v0, v4, v5}, Ljava/util/Arrays;->fill([JJ)V

    .line 640
    const/4 v0, -0x1

    sput v0, Lcom/mrkeyboard/app/MrPerf;->sFakeMode:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 193
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static add(IJ)V
    .locals 5

    .prologue
    .line 469
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-gez v0, :cond_1

    const/4 v0, 0x0

    .line 470
    :goto_0
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v1, v1, p0

    .line 471
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    mul-int/lit16 v3, p0, 0x100

    and-int/lit16 v4, v1, 0xff

    add-int/2addr v3, v4

    aput v0, v2, v3

    .line 472
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    add-int/lit8 v1, v1, 0x1

    aput v1, v2, p0

    .line 473
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    aget v1, v1, p0

    if-le v0, v1, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    aput v0, v1, p0

    .line 474
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    aput v0, v1, p0

    .line 475
    return-void

    .line 469
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

    .line 571
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_2

    .line 572
    :cond_0
    :goto_0
    const/4 v1, 0x1

    .line 573
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

    .line 571
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

    .line 574
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

    .line 575
    :cond_4
    return-object p1
.end method

.method public static appBegin()V
    .locals 1

    .prologue
    .line 250
    const/4 v0, 0x7

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static appEnd()V
    .locals 7

    .prologue
    const/4 v6, 0x7

    .line 254
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    aget-wide v0, v0, v6

    .line 255
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 260
    :goto_0
    return-void

    .line 256
    :cond_0
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const-wide/16 v4, -0x1

    aput-wide v4, v2, v6

    .line 257
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    sub-long v0, v2, v0

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    .line 258
    invoke-static {v6, v0, v1}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    .line 259
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

    .line 267
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v6

    .line 268
    const/16 v4, 0x15

    .line 269
    const-wide/16 v2, -0x1

    .line 270
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/4 v1, 0x2

    aget-wide v0, v0, v1

    .line 271
    cmp-long v5, v0, v2

    if-lez v5, :cond_4

    sub-long v8, v6, v0

    div-long/2addr v8, v12

    cmp-long v5, v8, v10

    if-gtz v5, :cond_4

    const/16 v2, 0x14

    .line 272
    :goto_0
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/16 v4, 0x8

    aget-wide v4, v3, v4

    .line 273
    cmp-long v3, v4, v0

    if-lez v3, :cond_0

    sub-long v8, v6, v4

    div-long/2addr v8, v12

    cmp-long v3, v8, v10

    if-gtz v3, :cond_0

    const/16 v2, 0x13

    move-wide v0, v4

    .line 274
    :cond_0
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/4 v4, 0x5

    aget-wide v4, v3, v4

    .line 275
    cmp-long v3, v4, v0

    if-lez v3, :cond_1

    sub-long v8, v6, v4

    div-long/2addr v8, v12

    cmp-long v3, v8, v10

    if-gtz v3, :cond_1

    const/16 v2, 0x12

    move-wide v0, v4

    .line 276
    :cond_1
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/16 v4, 0x18

    aget-wide v4, v3, v4

    .line 277
    cmp-long v3, v4, v0

    if-lez v3, :cond_2

    sub-long v8, v6, v4

    div-long/2addr v8, v12

    cmp-long v3, v8, v10

    if-gtz v3, :cond_2

    const/16 v2, 0x1a

    move-wide v0, v4

    .line 278
    :cond_2
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/16 v4, 0x19

    aget-wide v4, v3, v4

    .line 279
    cmp-long v0, v4, v0

    if-lez v0, :cond_3

    sub-long v0, v6, v4

    div-long/2addr v0, v12

    cmp-long v0, v0, v10

    if-gtz v0, :cond_3

    const/16 v2, 0x1b

    .line 280
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
    .line 455
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    aput-wide v2, v0, p0

    .line 456
    return-void
.end method

.method public static capsFlushed()V
    .locals 6

    .prologue
    .line 349
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 350
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 353
    :goto_0
    return-void

    .line 351
    :cond_0
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 352
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
    .line 356
    const-wide/16 v0, -0x1

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    return-void
.end method

.method public static capsPosted()V
    .locals 2

    .prologue
    .line 337
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v0

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    return-void
.end method

.method public static capsRan()V
    .locals 6

    .prologue
    .line 341
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 342
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 345
    :goto_0
    return-void

    .line 343
    :cond_0
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 344
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
    .line 581
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

    .line 585
    :goto_0
    return-void

    .line 582
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static createBegin()V
    .locals 1

    .prologue
    .line 201
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static createEnd()V
    .locals 1

    .prologue
    .line 202
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static createSuggBegin()V
    .locals 1

    .prologue
    .line 205
    const/16 v0, 0x24

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static createSuggEnd()V
    .locals 1

    .prologue
    .line 206
    const/16 v0, 0x24

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static createSuperBegin()V
    .locals 1

    .prologue
    .line 203
    const/16 v0, 0x23

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static createSuperEnd()V
    .locals 1

    .prologue
    .line 204
    const/16 v0, 0x23

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static echoCutBegin()V
    .locals 1

    .prologue
    .line 306
    const/16 v0, 0x1c

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static echoCutEnd()V
    .locals 1

    .prologue
    .line 307
    const/16 v0, 0x1c

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static echoDropped()V
    .locals 6

    .prologue
    .line 330
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 331
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 334
    :goto_0
    return-void

    .line 332
    :cond_0
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 333
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
    .line 308
    const/16 v0, 0x1d

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static echoFullEnd()V
    .locals 1

    .prologue
    .line 309
    const/16 v0, 0x1d

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static echoOneBegin()V
    .locals 1

    .prologue
    .line 311
    const/16 v0, 0x1e

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static echoOneEnd()V
    .locals 1

    .prologue
    .line 312
    const/16 v0, 0x1e

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static echoPosted()V
    .locals 2

    .prologue
    .line 315
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v0

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    return-void
.end method

.method public static echoRan()V
    .locals 6

    .prologue
    .line 319
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 320
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 323
    :goto_0
    return-void

    .line 321
    :cond_0
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 322
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
    .line 459
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    aget-wide v0, v0, p0

    .line 460
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 465
    :goto_0
    return-void

    .line 461
    :cond_0
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const-wide/16 v4, -0x1

    aput-wide v4, v2, p0

    .line 462
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    .line 463
    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sLastEnd:J

    .line 464
    sub-long v0, v2, v0

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    goto :goto_0
.end method

.method public static fill(Landroid/preference/PreferenceActivity;)V
    .locals 3

    .prologue
    .line 765
    :try_start_0
    const-string v0, "mr_perf"

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 766
    if-nez v0, :cond_1

    .line 775
    :cond_0
    :goto_0
    return-void

    .line 767
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->saveStart(Landroid/content/Context;)V

    .line 768
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->summary(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 769
    new-instance v1, Lcom/mrkeyboard/app/MrPerf$Reset;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrPerf$Reset;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 770
    const-string v1, "mr_perf_trim"

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v1

    .line 771
    if-eqz v1, :cond_0

    new-instance v2, Lcom/mrkeyboard/app/MrPerf$Trim;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrPerf$Trim;-><init>(Landroid/content/Context;Landroid/preference/Preference;)V

    invoke-virtual {v1, v2}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 772
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static firstOf(I)I
    .locals 2

    .prologue
    .line 539
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v0, v0, p0

    if-nez v0, :cond_0

    const/4 v0, -0x1

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    mul-int/lit16 v1, p0, 0x100

    aget v0, v0, v1

    goto :goto_0
.end method

.method public static frameBegin()V
    .locals 5

    .prologue
    const/4 v4, 0x4

    .line 217
    invoke-static {v4}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    .line 218
    sget-boolean v0, Lcom/mrkeyboard/app/MrPerf;->sPressOn:Z

    if-eqz v0, :cond_0

    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sPressFrameNs:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-gez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    aget-wide v0, v0, v4

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sPressFrameNs:J

    .line 219
    :cond_0
    return-void
.end method

.method public static frameEnd()V
    .locals 4

    .prologue
    .line 222
    const/4 v0, 0x4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    .line 223
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->pressDone()V

    .line 224
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 225
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_1

    .line 229
    :cond_0
    :goto_0
    return-void

    .line 226
    :cond_1
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 227
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    sub-long v0, v2, v0

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    .line 228
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
    .line 651
    const/4 v0, 0x1

    if-ne p0, v0, :cond_0

    const-string v0, "mr_ui_perf_frame_gpu"

    .line 653
    :goto_0
    return-object v0

    .line 652
    :cond_0
    const/4 v0, 0x2

    if-ne p0, v0, :cond_1

    const-string v0, "mr_ui_perf_frame_cpu"

    goto :goto_0

    .line 653
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    const/4 v1, 0x4

    aget-object v0, v0, v1

    goto :goto_0
.end method

.method public static handled()V
    .locals 2

    .prologue
    .line 421
    sget-boolean v0, Lcom/mrkeyboard/app/MrPerf;->sPressOpen:Z

    if-nez v0, :cond_1

    .line 424
    :cond_0
    :goto_0
    return-void

    .line 422
    :cond_1
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrPerf;->sPressOpen:Z

    .line 423
    sget-boolean v0, Lcom/mrkeyboard/app/MrPerf;->sPressOn:Z

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v0

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sPressHandledNs:J

    goto :goto_0
.end method

.method static heapUsed()J
    .locals 4

    .prologue
    .line 629
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    .line 630
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
    .line 233
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->keyKind(I)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    .line 234
    const/4 v0, 0x5

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    .line 235
    sget v0, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    .line 236
    return-void
.end method

.method public static keyEnd()V
    .locals 1

    .prologue
    .line 239
    const/4 v0, 0x5

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    .line 240
    sget v0, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    .line 241
    return-void
.end method

.method static keyKind(I)I
    .locals 1

    .prologue
    .line 245
    const/4 v0, -0x5

    if-ne p0, v0, :cond_0

    const/16 v0, 0xb

    .line 247
    :goto_0
    return v0

    .line 246
    :cond_0
    if-gtz p0, :cond_1

    const/16 v0, 0xc

    goto :goto_0

    .line 247
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

    .line 750
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    move v0, v1

    .line 751
    :goto_0
    const/16 v3, 0x27

    if-ge v0, v3, :cond_1

    .line 752
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->stats(I)[I

    move-result-object v3

    .line 753
    aget v4, v3, v1

    if-nez v4, :cond_0

    .line 751
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 754
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

    .line 755
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget v3, v3, v1

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ") "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 757
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

    .line 758
    invoke-static {}, Landroid/os/Debug;->getNativeHeapAllocatedSize()J

    move-result-wide v4

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 759
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static longShown(JJJJJ)V
    .locals 6

    .prologue
    .line 368
    sub-long v0, p0, p2

    .line 369
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    const-wide/16 v0, 0x0

    .line 370
    :cond_0
    const/16 v2, 0x26

    const-wide/16 v4, 0x3e8

    mul-long/2addr v4, v0

    invoke-static {v2, v4, v5}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    .line 371
    sget-wide v2, Lcom/mrkeyboard/app/MrPerf;->sWorstLate:J

    cmp-long v2, v0, v2

    if-lez v2, :cond_4

    .line 372
    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sWorstLate:J

    .line 373
    sput-wide p2, Lcom/mrkeyboard/app/MrPerf;->sWorstPlanned:J

    .line 374
    const-wide/16 v0, 0x0

    cmp-long v0, p4, v0

    if-gez v0, :cond_1

    const-wide/16 p4, 0x0

    :cond_1
    sput-wide p4, Lcom/mrkeyboard/app/MrPerf;->sWorstSeen:J

    .line 375
    const-wide/16 v0, 0x0

    cmp-long v0, p6, v0

    if-gez v0, :cond_2

    const-wide/16 p6, 0x0

    :cond_2
    sput-wide p6, Lcom/mrkeyboard/app/MrPerf;->sWorstTimer:J

    .line 376
    const-wide/16 v0, 0x0

    cmp-long v0, p8, v0

    if-gez v0, :cond_3

    const-wide/16 p8, 0x0

    :cond_3
    sput-wide p8, Lcom/mrkeyboard/app/MrPerf;->sWorstPopup:J

    .line 377
    sget v0, Lcom/mrkeyboard/app/MrPerf;->sPopupCode:I

    sput v0, Lcom/mrkeyboard/app/MrPerf;->sWorstCode:I

    .line 379
    :cond_4
    return-void
.end method

.method static mode(Landroid/content/Context;)I
    .locals 1

    .prologue
    .line 643
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
    .line 634
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
    .line 303
    const/16 v0, 0x19

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static msgEnd()V
    .locals 1

    .prologue
    .line 304
    const/16 v0, 0x19

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static nanos()J
    .locals 4

    .prologue
    .line 196
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
    .line 446
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    const/4 v1, 0x5

    aget v0, v0, v1

    .line 447
    sget v1, Lcom/mrkeyboard/app/MrPerf;->sLoggedKeys:I

    if-ne v0, v1, :cond_0

    .line 450
    :goto_0
    return-void

    .line 448
    :cond_0
    sput v0, Lcom/mrkeyboard/app/MrPerf;->sLoggedKeys:I

    .line 449
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

    .line 211
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    .line 212
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    aget-wide v0, v0, v1

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 213
    return-void
.end method

.method public static openEnd()V
    .locals 1

    .prologue
    .line 215
    const/4 v0, 0x2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static openKbBegin()V
    .locals 1

    .prologue
    .line 289
    const/16 v0, 0xf

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static openKbEnd()V
    .locals 1

    .prologue
    .line 290
    const/16 v0, 0xf

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static openSetBegin()V
    .locals 1

    .prologue
    .line 291
    const/16 v0, 0x10

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static openSetEnd()V
    .locals 1

    .prologue
    .line 292
    const/16 v0, 0x10

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static p95(I)I
    .locals 1

    .prologue
    .line 504
    mul-int/lit8 v0, p0, 0x5f

    add-int/lit8 v0, v0, 0x63

    div-int/lit8 v0, v0, 0x64

    add-int/lit8 v0, v0, -0x1

    .line 505
    if-gez v0, :cond_0

    const/4 v0, 0x0

    :cond_0
    return v0
.end method

.method public static popupBegin()V
    .locals 1

    .prologue
    .line 293
    const/16 v0, 0x11

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static popupBuildBegin()V
    .locals 1

    .prologue
    .line 295
    const/16 v0, 0x16

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static popupBuildEnd()V
    .locals 1

    .prologue
    .line 296
    const/16 v0, 0x16

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static popupEnd()V
    .locals 1

    .prologue
    .line 294
    const/16 v0, 0x11

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static popupKey(I)V
    .locals 0

    .prologue
    .line 359
    sput p0, Lcom/mrkeyboard/app/MrPerf;->sPopupCode:I

    return-void
.end method

.method public static popupShowBegin()V
    .locals 1

    .prologue
    .line 297
    const/16 v0, 0x17

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static popupShowEnd()V
    .locals 1

    .prologue
    .line 298
    const/16 v0, 0x17

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static pressArm(J)V
    .locals 14

    .prologue
    const-wide/16 v12, -0x1

    const/4 v10, 0x1

    const-wide/32 v8, 0xf4240

    const-wide/16 v0, 0x0

    .line 399
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v4

    .line 400
    sget-boolean v2, Lcom/mrkeyboard/app/MrPerf;->sPressOn:Z

    if-eqz v2, :cond_0

    sget-wide v2, Lcom/mrkeyboard/app/MrPerf;->sPressSeenNs:J

    sub-long v2, v4, v2

    div-long/2addr v2, v8

    const-wide/16 v6, 0x7d0

    cmp-long v2, v2, v6

    if-gtz v2, :cond_0

    .line 413
    :goto_0
    return-void

    .line 401
    :cond_0
    cmp-long v2, p0, v0

    if-gez v2, :cond_1

    move-wide p0, v0

    .line 402
    :cond_1
    mul-long v2, p0, v8

    sub-long v6, v4, v2

    .line 403
    sget-wide v2, Lcom/mrkeyboard/app/MrPerf;->sLastEnd:J

    cmp-long v2, v2, v0

    if-gez v2, :cond_2

    move-wide v2, v0

    .line 404
    :goto_1
    cmp-long v8, v2, v0

    if-gez v8, :cond_4

    .line 405
    :goto_2
    cmp-long v2, v0, p0

    if-lez v2, :cond_3

    .line 406
    :goto_3
    sput-boolean v10, Lcom/mrkeyboard/app/MrPerf;->sPressOn:Z

    .line 407
    sput-wide v6, Lcom/mrkeyboard/app/MrPerf;->sPressEventNs:J

    .line 408
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sPressSeenNs:J

    .line 409
    sput-wide p0, Lcom/mrkeyboard/app/MrPerf;->sPressBehindMs:J

    .line 410
    sput-wide v12, Lcom/mrkeyboard/app/MrPerf;->sPressHandledNs:J

    .line 411
    sput-boolean v10, Lcom/mrkeyboard/app/MrPerf;->sPressOpen:Z

    .line 412
    sput-wide v12, Lcom/mrkeyboard/app/MrPerf;->sPressFrameNs:J

    goto :goto_0

    .line 403
    :cond_2
    sget-wide v2, Lcom/mrkeyboard/app/MrPerf;->sLastEnd:J

    sub-long/2addr v2, v6

    div-long/2addr v2, v8

    goto :goto_1

    :cond_3
    move-wide p0, v0

    goto :goto_3

    :cond_4
    move-wide v0, v2

    goto :goto_2
.end method

.method static pressDone()V
    .locals 10

    .prologue
    const-wide/16 v8, 0x0

    const-wide/32 v6, 0xf4240

    .line 428
    sget-boolean v0, Lcom/mrkeyboard/app/MrPerf;->sPressOn:Z

    if-eqz v0, :cond_0

    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sPressFrameNs:J

    cmp-long v0, v0, v8

    if-gez v0, :cond_1

    .line 442
    :cond_0
    :goto_0
    return-void

    .line 429
    :cond_1
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrPerf;->sPressOn:Z

    .line 430
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    .line 431
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sPressEventNs:J

    sub-long v0, v2, v0

    div-long/2addr v0, v6

    .line 432
    const-wide/16 v4, 0x7d0

    cmp-long v4, v0, v4

    if-gtz v4, :cond_0

    .line 433
    sget-wide v4, Lcom/mrkeyboard/app/MrPerf;->sWorstPress:J

    cmp-long v4, v0, v4

    if-lez v4, :cond_0

    .line 434
    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sWorstPress:J

    .line 435
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sPressSeenNs:J

    sget-wide v4, Lcom/mrkeyboard/app/MrPerf;->sPressEventNs:J

    sub-long/2addr v0, v4

    div-long/2addr v0, v6

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sWorstPressSeen:J

    .line 436
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sPressBehindMs:J

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sWorstPressBehind:J

    .line 437
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sPressHandledNs:J

    cmp-long v0, v0, v8

    if-gez v0, :cond_2

    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sPressSeenNs:J

    .line 438
    :goto_1
    sget-wide v4, Lcom/mrkeyboard/app/MrPerf;->sPressSeenNs:J

    sub-long v4, v0, v4

    div-long/2addr v4, v6

    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sWorstPressHandle:J

    .line 439
    sget-wide v4, Lcom/mrkeyboard/app/MrPerf;->sPressFrameNs:J

    sub-long v0, v4, v0

    div-long/2addr v0, v6

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sWorstPressWait:J

    .line 440
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sPressFrameNs:J

    sub-long v0, v2, v0

    div-long/2addr v0, v6

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sWorstPressDraw:J

    goto :goto_0

    .line 437
    :cond_2
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sPressHandledNs:J

    goto :goto_1
.end method

.method static reset()V
    .locals 4

    .prologue
    const/4 v1, 0x0

    const-wide/16 v2, -0x1

    .line 510
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 511
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 512
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 513
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    invoke-static {v0, v2, v3}, Ljava/util/Arrays;->fill([JJ)V

    .line 514
    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 515
    sput v1, Lcom/mrkeyboard/app/MrPerf;->sLoggedKeys:I

    .line 516
    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 517
    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 518
    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sWorstLate:J

    .line 519
    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sWorstPress:J

    .line 520
    sput-boolean v1, Lcom/mrkeyboard/app/MrPerf;->sPressOn:Z

    .line 521
    sput-boolean v1, Lcom/mrkeyboard/app/MrPerf;->sPressOpen:Z

    .line 522
    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sLastEnd:J

    .line 523
    invoke-static {}, Lcom/mrkeyboard/app/MrTrim;->forget()V

    .line 524
    invoke-static {}, Lcom/mrkeyboard/app/MrLive;->forget()V

    .line 525
    return-void
.end method

.method static saveStart(Landroid/content/Context;)V
    .locals 6

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 558
    sget-boolean v0, Lcom/mrkeyboard/app/MrPerf;->sStartSaved:Z

    if-nez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v0, v0, v1

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v0, v0, v2

    if-nez v0, :cond_1

    .line 567
    :cond_0
    :goto_0
    return-void

    .line 560
    :cond_1
    :try_start_0
    const-string v0, "mr_perf"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 561
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v2, 0x0

    invoke-static {v2}, Lcom/mrkeyboard/app/MrPerf;->firstOf(I)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v2}, Lcom/mrkeyboard/app/MrPerf;->firstOf(I)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x23

    invoke-static {v2}, Lcom/mrkeyboard/app/MrPerf;->firstOf(I)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x24

    invoke-static {v2}, Lcom/mrkeyboard/app/MrPerf;->firstOf(I)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 562
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

    .line 563
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrPerf;->sStartSaved:Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 564
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static selBegin()V
    .locals 1

    .prologue
    .line 300
    const/16 v0, 0x18

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static selEnd()V
    .locals 1

    .prologue
    .line 301
    const/16 v0, 0x18

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static startColumn(I)I
    .locals 1

    .prologue
    const/4 v0, 0x1

    .line 534
    if-nez p0, :cond_1

    const/4 v0, 0x0

    :cond_0
    :goto_0
    return v0

    :cond_1
    if-eq p0, v0, :cond_0

    const/16 v0, 0x23

    if-ne p0, v0, :cond_2

    const/4 v0, 0x2

    goto :goto_0

    :cond_2
    const/16 v0, 0x24

    if-ne p0, v0, :cond_3

    const/4 v0, 0x3

    goto :goto_0

    :cond_3
    const/4 v0, -0x1

    goto :goto_0
.end method

.method static startStats(Ljava/lang/String;I)[I
    .locals 9

    .prologue
    const/16 v8, 0x2c

    const/16 v7, 0x9

    const/4 v4, 0x0

    .line 593
    new-array v6, v7, [I

    move v1, v4

    move v2, v4

    .line 596
    :goto_0
    if-eqz p0, :cond_7

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-gt v1, v0, :cond_7

    if-ge v2, v7, :cond_7

    .line 597
    const/16 v0, 0x3b

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    .line 598
    if-gez v0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    :cond_0
    move v3, v4

    move v5, v1

    .line 600
    :goto_1
    if-ge v3, p1, :cond_3

    if-ltz v5, :cond_3

    .line 601
    invoke-virtual {p0, v8, v5}, Ljava/lang/String;->indexOf(II)I

    move-result v1

    .line 602
    if-ltz v1, :cond_1

    if-lt v1, v0, :cond_2

    :cond_1
    const/4 v1, -0x1

    .line 600
    :goto_2
    add-int/lit8 v3, v3, 0x1

    move v5, v1

    goto :goto_1

    .line 602
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 604
    :cond_3
    if-ltz v5, :cond_6

    .line 605
    invoke-virtual {p0, v8, v5}, Ljava/lang/String;->indexOf(II)I

    move-result v1

    .line 606
    if-ltz v1, :cond_4

    if-le v1, v0, :cond_5

    :cond_4
    move v1, v0

    .line 607
    :cond_5
    if-le v1, v5, :cond_6

    .line 609
    :try_start_0
    invoke-virtual {p0, v5, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 610
    if-ltz v3, :cond_9

    add-int/lit8 v1, v2, 0x1

    :try_start_1
    aput v3, v6, v2
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_1

    :goto_3
    move v2, v1

    .line 616
    :cond_6
    :goto_4
    add-int/lit8 v1, v0, 0x1

    .line 617
    goto :goto_0

    .line 618
    :cond_7
    const/4 v0, 0x4

    new-array v0, v0, [I

    .line 619
    aput v2, v0, v4

    .line 620
    if-nez v2, :cond_8

    .line 625
    :goto_5
    return-object v0

    .line 621
    :cond_8
    invoke-static {v6, v4, v2}, Ljava/util/Arrays;->sort([III)V

    .line 622
    const/4 v1, 0x1

    aget v3, v6, v4

    aput v3, v0, v1

    .line 623
    const/4 v1, 0x2

    mul-int/lit8 v3, v2, 0x32

    add-int/lit8 v3, v3, 0x63

    div-int/lit8 v3, v3, 0x64

    add-int/lit8 v3, v3, -0x1

    aget v3, v6, v3

    aput v3, v0, v1

    .line 624
    const/4 v1, 0x3

    add-int/lit8 v2, v2, -0x1

    aget v2, v6, v2

    aput v2, v0, v1

    goto :goto_5

    .line 611
    :catch_0
    move-exception v1

    goto :goto_4

    :catch_1
    move-exception v2

    move v2, v1

    goto :goto_4

    :cond_9
    move v1, v2

    goto :goto_3
.end method

.method static startsOf(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 545
    :try_start_0
    const-string v0, "mr_perf"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "starts"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 546
    if-nez v0, :cond_0

    const-string v0, ""
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 548
    :cond_0
    :goto_0
    return-object v0

    .line 547
    :catch_0
    move-exception v0

    .line 548
    const-string v0, ""

    goto :goto_0
.end method

.method static stats(I)[I
    .locals 10

    .prologue
    const/16 v3, 0x100

    const/4 v2, 0x0

    .line 482
    const/4 v0, 0x5

    new-array v0, v0, [I

    .line 483
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v1, v1, p0

    .line 484
    aput v1, v0, v2

    .line 485
    if-ge v1, v3, :cond_0

    move v3, v1

    .line 486
    :cond_0
    if-nez v3, :cond_1

    .line 499
    :goto_0
    return-object v0

    .line 487
    :cond_1
    const-wide/16 v4, 0x0

    .line 488
    mul-int/lit16 v6, p0, 0x100

    move v1, v2

    .line 489
    :goto_1
    if-ge v1, v3, :cond_2

    .line 490
    sget-object v7, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    add-int v8, v6, v1

    aget v7, v7, v8

    .line 491
    sget-object v8, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    aput v7, v8, v1

    .line 492
    int-to-long v8, v7

    add-long/2addr v4, v8

    .line 489
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 494
    :cond_2
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    invoke-static {v1, v2, v3}, Ljava/util/Arrays;->sort([III)V

    .line 495
    const/4 v1, 0x1

    int-to-long v6, v3

    div-long/2addr v4, v6

    long-to-int v2, v4

    aput v2, v0, v1

    .line 496
    const/4 v1, 0x2

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->p95(I)I

    move-result v3

    aget v2, v2, v3

    aput v2, v0, v1

    .line 497
    const/4 v1, 0x3

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    aget v2, v2, p0

    aput v2, v0, v1

    .line 498
    const/4 v1, 0x4

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    aget v2, v2, p0

    aput v2, v0, v1

    goto :goto_0
.end method

.method public static suggBegin()V
    .locals 1

    .prologue
    .line 283
    const/16 v0, 0x8

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static suggEnd()V
    .locals 1

    .prologue
    .line 284
    const/16 v0, 0x8

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static suggEngineBegin()V
    .locals 1

    .prologue
    .line 285
    const/16 v0, 0xd

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static suggEngineEnd()V
    .locals 1

    .prologue
    .line 286
    const/16 v0, 0xd

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static suggShowBegin()V
    .locals 1

    .prologue
    .line 287
    const/16 v0, 0xe

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static suggShowEnd()V
    .locals 1

    .prologue
    .line 288
    const/16 v0, 0xe

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static summary(Landroid/content/Context;)Ljava/lang/String;
    .locals 11

    .prologue
    .line 658
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    .line 659
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->startsOf(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v5

    .line 660
    const/4 v0, 0x0

    move v3, v0

    :goto_0
    const/16 v0, 0x27

    if-ge v3, v0, :cond_9

    .line 661
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->stats(I)[I

    move-result-object v6

    .line 662
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->startColumn(I)I

    move-result v7

    .line 663
    if-ltz v7, :cond_1

    const/4 v0, 0x1

    .line 665
    :goto_1
    const/4 v1, 0x0

    aget v1, v6, v1

    if-nez v1, :cond_2

    if-nez v0, :cond_2

    .line 660
    :cond_0
    :goto_2
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_0

    .line 663
    :cond_1
    const/4 v0, 0x0

    goto :goto_1

    .line 666
    :cond_2
    const/4 v1, 0x4

    if-ne v3, v1, :cond_6

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->mode(Landroid/content/Context;)I

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPerf;->frameName(I)Ljava/lang/String;

    move-result-object v1

    :goto_3
    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 668
    if-nez v1, :cond_1a

    const/4 v2, 0x4

    if-ne v3, v2, :cond_1a

    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    const/4 v2, 0x4

    aget-object v1, v1, v2

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    move-object v2, v1

    .line 669
    :goto_4
    if-eqz v2, :cond_0

    .line 670
    const/4 v1, 0x0

    aget v1, v6, v1

    if-lez v1, :cond_4

    .line 671
    const/4 v1, 0x0

    aget v1, v6, v1

    const/4 v8, 0x1

    if-ne v1, v8, :cond_7

    .line 672
    const-string v1, "mr_ui_perf_one"

    const/4 v8, 0x2

    new-array v8, v8, [Ljava/lang/Object;

    const/4 v9, 0x0

    aput-object v2, v8, v9

    const/4 v9, 0x1

    const/4 v10, 0x4

    aget v6, v6, v10

    invoke-static {v6}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v8, v9

    invoke-static {p0, v1, v8}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 674
    :goto_5
    if-eqz v1, :cond_4

    .line 675
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I

    move-result v6

    if-lez v6, :cond_3

    const/16 v6, 0xa

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 676
    :cond_3
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 679
    :cond_4
    if-eqz v0, :cond_0

    .line 681
    invoke-static {v5, v7}, Lcom/mrkeyboard/app/MrPerf;->startStats(Ljava/lang/String;I)[I

    move-result-object v0

    .line 682
    const/4 v1, 0x0

    aget v1, v0, v1

    const/4 v6, 0x2

    if-ge v1, v6, :cond_8

    const/4 v0, 0x0

    .line 684
    :goto_6
    if-eqz v0, :cond_0

    .line 685
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I

    move-result v1

    if-lez v1, :cond_5

    const/16 v1, 0xa

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 686
    :cond_5
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_2

    .line 666
    :cond_6
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    aget-object v1, v1, v3

    goto :goto_3

    .line 673
    :cond_7
    const-string v1, "mr_ui_perf_stat"

    const/4 v8, 0x5

    new-array v8, v8, [Ljava/lang/Object;

    const/4 v9, 0x0

    aput-object v2, v8, v9

    const/4 v9, 0x1

    const/4 v10, 0x1

    aget v10, v6, v10

    invoke-static {v10}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v9

    const/4 v9, 0x2

    const/4 v10, 0x2

    aget v10, v6, v10

    invoke-static {v10}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v9

    const/4 v9, 0x3

    const/4 v10, 0x3

    aget v10, v6, v10

    invoke-static {v10}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v9

    const/4 v9, 0x4

    const/4 v10, 0x0

    aget v6, v6, v10

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v8, v9

    invoke-static {p0, v1, v8}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    goto :goto_5

    .line 683
    :cond_8
    const-string v1, "mr_ui_perf_starts"

    const/4 v6, 0x5

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object v2, v6, v7

    const/4 v2, 0x1

    const/4 v7, 0x0

    aget v7, v0, v7

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v6, v2

    const/4 v2, 0x2

    const/4 v7, 0x1

    aget v7, v0, v7

    invoke-static {v7}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v7

    aput-object v7, v6, v2

    const/4 v2, 0x3

    const/4 v7, 0x2

    aget v7, v0, v7

    invoke-static {v7}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v7

    aput-object v7, v6, v2

    const/4 v2, 0x4

    const/4 v7, 0x3

    aget v0, v0, v7

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v6, v2

    invoke-static {p0, v1, v6}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_6

    .line 690
    :cond_9
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sWorstLate:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-ltz v0, :cond_b

    .line 692
    sget v0, Lcom/mrkeyboard/app/MrPerf;->sWorstCode:I

    const/16 v1, -0x12c

    if-ne v0, v1, :cond_17

    const-string v0, "mr_ui_perf_long_key_sheet"

    :goto_7
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 693
    if-nez v0, :cond_18

    const/4 v0, 0x0

    .line 696
    :goto_8
    if-eqz v0, :cond_b

    .line 697
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I

    move-result v1

    if-lez v1, :cond_a

    const/16 v1, 0xa

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 698
    :cond_a
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 701
    :cond_b
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sWorstPress:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-ltz v0, :cond_d

    .line 703
    const-string v0, "mr_ui_perf_press_worst"

    const/4 v1, 0x6

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    sget-wide v6, Lcom/mrkeyboard/app/MrPerf;->sWorstPress:J

    const-wide/16 v8, 0x3e8

    mul-long/2addr v6, v8

    long-to-int v3, v6

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x1

    sget-wide v6, Lcom/mrkeyboard/app/MrPerf;->sWorstPressSeen:J

    const-wide/16 v8, 0x3e8

    mul-long/2addr v6, v8

    long-to-int v3, v6

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x2

    sget-wide v6, Lcom/mrkeyboard/app/MrPerf;->sWorstPressBehind:J

    const-wide/16 v8, 0x3e8

    mul-long/2addr v6, v8

    long-to-int v3, v6

    .line 704
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x3

    sget-wide v6, Lcom/mrkeyboard/app/MrPerf;->sWorstPressHandle:J

    const-wide/16 v8, 0x3e8

    mul-long/2addr v6, v8

    long-to-int v3, v6

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x4

    sget-wide v6, Lcom/mrkeyboard/app/MrPerf;->sWorstPressWait:J

    const-wide/16 v8, 0x3e8

    mul-long/2addr v6, v8

    long-to-int v3, v6

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x5

    sget-wide v6, Lcom/mrkeyboard/app/MrPerf;->sWorstPressDraw:J

    const-wide/16 v8, 0x3e8

    mul-long/2addr v6, v8

    long-to-int v3, v6

    .line 705
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    .line 703
    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 706
    if-eqz v0, :cond_d

    .line 707
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I

    move-result v1

    if-lez v1, :cond_c

    const/16 v1, 0xa

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 708
    :cond_c
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 711
    :cond_d
    sget v0, Lcom/mrkeyboard/app/MrTrim;->sCount:I

    if-lez v0, :cond_f

    .line 713
    const-string v0, "mr_ui_perf_trim_last"

    const/4 v1, 0x5

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    sget v3, Lcom/mrkeyboard/app/MrTrim;->sLevel:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x1

    sget v3, Lcom/mrkeyboard/app/MrTrim;->sKeyboards:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x2

    sget v3, Lcom/mrkeyboard/app/MrTrim;->sPopups:I

    .line 714
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x3

    sget v3, Lcom/mrkeyboard/app/MrTrim;->sShadows:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x4

    sget v3, Lcom/mrkeyboard/app/MrTrim;->sBytes:I

    int-to-long v6, v3

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    .line 713
    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 715
    if-eqz v0, :cond_f

    .line 716
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I

    move-result v1

    if-lez v1, :cond_e

    const/16 v1, 0xa

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 717
    :cond_e
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 720
    :cond_f
    sget-boolean v0, Lcom/mrkeyboard/app/MrLive;->sMeasured:Z

    if-eqz v0, :cond_11

    .line 722
    const-string v0, "mr_ui_perf_alive"

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    sget v3, Lcom/mrkeyboard/app/MrLive;->sServices:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x1

    sget v3, Lcom/mrkeyboard/app/MrLive;->sViews:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 723
    if-eqz v0, :cond_11

    .line 724
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I

    move-result v1

    if-lez v1, :cond_10

    const/16 v1, 0xa

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 725
    :cond_10
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 728
    :cond_11
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    if-lez v0, :cond_19

    const/4 v0, 0x1

    .line 729
    :goto_9
    if-nez v0, :cond_12

    .line 730
    const-string v1, "mr_ui_perf_none"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 731
    if-eqz v1, :cond_12

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 733
    :cond_12
    const-string v1, "mr_ui_perf_mem"

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->heapUsed()J

    move-result-wide v6

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v2, v3

    const/4 v3, 0x1

    invoke-static {}, Landroid/os/Debug;->getNativeHeapAllocatedSize()J

    move-result-wide v6

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v2, v3

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 734
    if-eqz v1, :cond_13

    const/16 v2, 0xa

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 736
    :cond_13
    invoke-static {p0}, Lcom/mrkeyboard/app/MrDictMem;->block(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 737
    if-eqz v1, :cond_14

    const/16 v2, 0xa

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 739
    :cond_14
    invoke-static {p0}, Lcom/mrkeyboard/app/MrEngineStats;->block(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 740
    if-eqz v1, :cond_15

    const/16 v2, 0xa

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 741
    :cond_15
    if-eqz v0, :cond_16

    .line 742
    const-string v0, "mr_ui_perf_reset"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 743
    if-eqz v0, :cond_16

    const/16 v1, 0xa

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 745
    :cond_16
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 692
    :cond_17
    const-string v0, "mr_ui_perf_long_key_other"

    goto/16 :goto_7

    .line 693
    :cond_18
    const-string v1, "mr_ui_perf_long_worst"

    const/4 v2, 0x6

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    const/4 v0, 0x1

    sget-wide v6, Lcom/mrkeyboard/app/MrPerf;->sWorstPlanned:J

    sget-wide v8, Lcom/mrkeyboard/app/MrPerf;->sWorstLate:J

    add-long/2addr v6, v8

    const-wide/16 v8, 0x3e8

    mul-long/2addr v6, v8

    long-to-int v3, v6

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v0

    const/4 v0, 0x2

    sget-wide v6, Lcom/mrkeyboard/app/MrPerf;->sWorstPlanned:J

    const-wide/16 v8, 0x3e8

    mul-long/2addr v6, v8

    long-to-int v3, v6

    .line 694
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v0

    const/4 v0, 0x3

    sget-wide v6, Lcom/mrkeyboard/app/MrPerf;->sWorstSeen:J

    const-wide/16 v8, 0x3e8

    mul-long/2addr v6, v8

    long-to-int v3, v6

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v0

    const/4 v0, 0x4

    sget-wide v6, Lcom/mrkeyboard/app/MrPerf;->sWorstTimer:J

    const-wide/16 v8, 0x3e8

    mul-long/2addr v6, v8

    long-to-int v3, v6

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v0

    const/4 v0, 0x5

    sget-wide v6, Lcom/mrkeyboard/app/MrPerf;->sWorstPopup:J

    const-wide/16 v8, 0x3e8

    mul-long/2addr v6, v8

    long-to-int v3, v6

    .line 695
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v0

    .line 693
    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_8

    .line 728
    :cond_19
    const/4 v0, 0x0

    goto/16 :goto_9

    :cond_1a
    move-object v2, v1

    goto/16 :goto_4
.end method

.method public static touch(Landroid/view/MotionEvent;)V
    .locals 6

    .prologue
    .line 383
    if-nez p0, :cond_1

    .line 390
    :cond_0
    :goto_0
    return-void

    .line 384
    :cond_1
    invoke-virtual {p0}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    .line 385
    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrPerf;->sPressOpen:Z

    .line 386
    if-eqz v0, :cond_2

    const/4 v1, 0x5

    if-ne v0, v1, :cond_0

    .line 387
    :cond_2
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    invoke-virtual {p0}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v2

    sub-long/2addr v0, v2

    .line 388
    const/4 v2, 0x6

    const-wide/16 v4, 0x3e8

    mul-long/2addr v4, v0

    invoke-static {v2, v4, v5}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    .line 389
    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPerf;->pressArm(J)V

    goto :goto_0
.end method

.method public static viewBegin()V
    .locals 1

    .prologue
    .line 207
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static viewEnd()V
    .locals 1

    .prologue
    .line 208
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method
