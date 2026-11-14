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

.field static final KINDS:I = 0x26

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

.field static final TRIM:I = 0x25

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

    const/16 v3, 0x26

    .line 110
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

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    .line 121
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

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->LOG:[Ljava/lang/String;

    .line 126
    const/16 v0, 0x2600

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    .line 127
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    .line 128
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    .line 129
    new-array v0, v3, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    .line 131
    new-array v0, v3, [J

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    .line 133
    sput v6, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    .line 135
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 137
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 139
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 144
    const/16 v0, 0x100

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    .line 146
    sput-wide v4, Lcom/mrkeyboard/app/MrPerf;->sFakeNanos:J

    .line 149
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    invoke-static {v0, v4, v5}, Ljava/util/Arrays;->fill([JJ)V

    .line 509
    const/4 v0, -0x1

    sput v0, Lcom/mrkeyboard/app/MrPerf;->sFakeMode:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 152
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static add(IJ)V
    .locals 5

    .prologue
    .line 344
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-gez v0, :cond_1

    const/4 v0, 0x0

    .line 345
    :goto_0
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v1, v1, p0

    .line 346
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    mul-int/lit16 v3, p0, 0x100

    and-int/lit16 v4, v1, 0xff

    add-int/2addr v3, v4

    aput v0, v2, v3

    .line 347
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    add-int/lit8 v1, v1, 0x1

    aput v1, v2, p0

    .line 348
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    aget v1, v1, p0

    if-le v0, v1, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    aput v0, v1, p0

    .line 349
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    aput v0, v1, p0

    .line 350
    return-void

    .line 344
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

    .line 440
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_2

    .line 441
    :cond_0
    :goto_0
    const/4 v1, 0x1

    .line 442
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

    .line 440
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

    .line 443
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

    .line 444
    :cond_4
    return-object p1
.end method

.method public static appBegin()V
    .locals 1

    .prologue
    .line 205
    const/4 v0, 0x7

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static appEnd()V
    .locals 7

    .prologue
    const/4 v6, 0x7

    .line 209
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    aget-wide v0, v0, v6

    .line 210
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 215
    :goto_0
    return-void

    .line 211
    :cond_0
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const-wide/16 v4, -0x1

    aput-wide v4, v2, v6

    .line 212
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    sub-long v0, v2, v0

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    .line 213
    invoke-static {v6, v0, v1}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    .line 214
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

    .line 222
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v6

    .line 223
    const/16 v4, 0x15

    .line 224
    const-wide/16 v2, -0x1

    .line 225
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/4 v1, 0x2

    aget-wide v0, v0, v1

    .line 226
    cmp-long v5, v0, v2

    if-lez v5, :cond_4

    sub-long v8, v6, v0

    div-long/2addr v8, v12

    cmp-long v5, v8, v10

    if-gtz v5, :cond_4

    const/16 v2, 0x14

    .line 227
    :goto_0
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/16 v4, 0x8

    aget-wide v4, v3, v4

    .line 228
    cmp-long v3, v4, v0

    if-lez v3, :cond_0

    sub-long v8, v6, v4

    div-long/2addr v8, v12

    cmp-long v3, v8, v10

    if-gtz v3, :cond_0

    const/16 v2, 0x13

    move-wide v0, v4

    .line 229
    :cond_0
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/4 v4, 0x5

    aget-wide v4, v3, v4

    .line 230
    cmp-long v3, v4, v0

    if-lez v3, :cond_1

    sub-long v8, v6, v4

    div-long/2addr v8, v12

    cmp-long v3, v8, v10

    if-gtz v3, :cond_1

    const/16 v2, 0x12

    move-wide v0, v4

    .line 231
    :cond_1
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/16 v4, 0x18

    aget-wide v4, v3, v4

    .line 232
    cmp-long v3, v4, v0

    if-lez v3, :cond_2

    sub-long v8, v6, v4

    div-long/2addr v8, v12

    cmp-long v3, v8, v10

    if-gtz v3, :cond_2

    const/16 v2, 0x1a

    move-wide v0, v4

    .line 233
    :cond_2
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const/16 v4, 0x19

    aget-wide v4, v3, v4

    .line 234
    cmp-long v0, v4, v0

    if-lez v0, :cond_3

    sub-long v0, v6, v4

    div-long/2addr v0, v12

    cmp-long v0, v0, v10

    if-gtz v0, :cond_3

    const/16 v2, 0x1b

    .line 235
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
    .line 332
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    aput-wide v2, v0, p0

    .line 333
    return-void
.end method

.method public static capsFlushed()V
    .locals 6

    .prologue
    .line 304
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 305
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 308
    :goto_0
    return-void

    .line 306
    :cond_0
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 307
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
    .line 311
    const-wide/16 v0, -0x1

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    return-void
.end method

.method public static capsPosted()V
    .locals 2

    .prologue
    .line 292
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v0

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    return-void
.end method

.method public static capsRan()V
    .locals 6

    .prologue
    .line 296
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 297
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 300
    :goto_0
    return-void

    .line 298
    :cond_0
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 299
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
    .line 450
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

    .line 454
    :goto_0
    return-void

    .line 451
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static createBegin()V
    .locals 1

    .prologue
    .line 160
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static createEnd()V
    .locals 1

    .prologue
    .line 161
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static createSuggBegin()V
    .locals 1

    .prologue
    .line 164
    const/16 v0, 0x24

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static createSuggEnd()V
    .locals 1

    .prologue
    .line 165
    const/16 v0, 0x24

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static createSuperBegin()V
    .locals 1

    .prologue
    .line 162
    const/16 v0, 0x23

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static createSuperEnd()V
    .locals 1

    .prologue
    .line 163
    const/16 v0, 0x23

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static echoCutBegin()V
    .locals 1

    .prologue
    .line 261
    const/16 v0, 0x1c

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static echoCutEnd()V
    .locals 1

    .prologue
    .line 262
    const/16 v0, 0x1c

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static echoDropped()V
    .locals 6

    .prologue
    .line 285
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 286
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 289
    :goto_0
    return-void

    .line 287
    :cond_0
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 288
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
    .line 263
    const/16 v0, 0x1d

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static echoFullEnd()V
    .locals 1

    .prologue
    .line 264
    const/16 v0, 0x1d

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static echoOneBegin()V
    .locals 1

    .prologue
    .line 266
    const/16 v0, 0x1e

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static echoOneEnd()V
    .locals 1

    .prologue
    .line 267
    const/16 v0, 0x1e

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static echoPosted()V
    .locals 2

    .prologue
    .line 270
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v0

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    return-void
.end method

.method public static echoRan()V
    .locals 6

    .prologue
    .line 274
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 275
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 278
    :goto_0
    return-void

    .line 276
    :cond_0
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 277
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
    .line 336
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    aget-wide v0, v0, p0

    .line 337
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_0

    .line 340
    :goto_0
    return-void

    .line 338
    :cond_0
    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    const-wide/16 v4, -0x1

    aput-wide v4, v2, p0

    .line 339
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    sub-long v0, v2, v0

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPerf;->add(IJ)V

    goto :goto_0
.end method

.method public static fill(Landroid/preference/PreferenceActivity;)V
    .locals 3

    .prologue
    .line 599
    :try_start_0
    const-string v0, "mr_perf"

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 600
    if-nez v0, :cond_1

    .line 609
    :cond_0
    :goto_0
    return-void

    .line 601
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->saveStart(Landroid/content/Context;)V

    .line 602
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->summary(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 603
    new-instance v1, Lcom/mrkeyboard/app/MrPerf$Reset;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrPerf$Reset;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 604
    const-string v1, "mr_perf_trim"

    invoke-virtual {p0, v1}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v1

    .line 605
    if-eqz v1, :cond_0

    new-instance v2, Lcom/mrkeyboard/app/MrPerf$Trim;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrPerf$Trim;-><init>(Landroid/content/Context;Landroid/preference/Preference;)V

    invoke-virtual {v1, v2}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 606
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static firstOf(I)I
    .locals 2

    .prologue
    .line 408
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
    .locals 1

    .prologue
    .line 175
    const/4 v0, 0x4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static frameEnd()V
    .locals 4

    .prologue
    .line 178
    const/4 v0, 0x4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    .line 179
    sget-wide v0, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 180
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gez v2, :cond_1

    .line 184
    :cond_0
    :goto_0
    return-void

    .line 181
    :cond_1
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 182
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->nanos()J

    move-result-wide v2

    sub-long v0, v2, v0

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    .line 183
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
    .line 520
    const/4 v0, 0x1

    if-ne p0, v0, :cond_0

    const-string v0, "mr_ui_perf_frame_gpu"

    .line 522
    :goto_0
    return-object v0

    .line 521
    :cond_0
    const/4 v0, 0x2

    if-ne p0, v0, :cond_1

    const-string v0, "mr_ui_perf_frame_cpu"

    goto :goto_0

    .line 522
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    const/4 v1, 0x4

    aget-object v0, v0, v1

    goto :goto_0
.end method

.method static heapUsed()J
    .locals 4

    .prologue
    .line 498
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    .line 499
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
    .line 188
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->keyKind(I)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    .line 189
    const/4 v0, 0x5

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    .line 190
    sget v0, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    .line 191
    return-void
.end method

.method public static keyEnd()V
    .locals 1

    .prologue
    .line 194
    const/4 v0, 0x5

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    .line 195
    sget v0, Lcom/mrkeyboard/app/MrPerf;->sKeyKind:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    .line 196
    return-void
.end method

.method static keyKind(I)I
    .locals 1

    .prologue
    .line 200
    const/4 v0, -0x5

    if-ne p0, v0, :cond_0

    const/16 v0, 0xb

    .line 202
    :goto_0
    return v0

    .line 201
    :cond_0
    if-gtz p0, :cond_1

    const/16 v0, 0xc

    goto :goto_0

    .line 202
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

    .line 584
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    move v0, v1

    .line 585
    :goto_0
    const/16 v3, 0x26

    if-ge v0, v3, :cond_1

    .line 586
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->stats(I)[I

    move-result-object v3

    .line 587
    aget v4, v3, v1

    if-nez v4, :cond_0

    .line 585
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 588
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

    .line 589
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget v3, v3, v1

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ") "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 591
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

    .line 592
    invoke-static {}, Landroid/os/Debug;->getNativeHeapAllocatedSize()J

    move-result-wide v4

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 593
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static mode(Landroid/content/Context;)I
    .locals 1

    .prologue
    .line 512
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
    .line 503
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
    .line 258
    const/16 v0, 0x19

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static msgEnd()V
    .locals 1

    .prologue
    .line 259
    const/16 v0, 0x19

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static nanos()J
    .locals 4

    .prologue
    .line 155
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
    .line 323
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    const/4 v1, 0x5

    aget v0, v0, v1

    .line 324
    sget v1, Lcom/mrkeyboard/app/MrPerf;->sLoggedKeys:I

    if-ne v0, v1, :cond_0

    .line 327
    :goto_0
    return-void

    .line 325
    :cond_0
    sput v0, Lcom/mrkeyboard/app/MrPerf;->sLoggedKeys:I

    .line 326
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

    .line 170
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    .line 171
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    aget-wide v0, v0, v1

    sput-wide v0, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 172
    return-void
.end method

.method public static openEnd()V
    .locals 1

    .prologue
    .line 174
    const/4 v0, 0x2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static openKbBegin()V
    .locals 1

    .prologue
    .line 244
    const/16 v0, 0xf

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static openKbEnd()V
    .locals 1

    .prologue
    .line 245
    const/16 v0, 0xf

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static openSetBegin()V
    .locals 1

    .prologue
    .line 246
    const/16 v0, 0x10

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static openSetEnd()V
    .locals 1

    .prologue
    .line 247
    const/16 v0, 0x10

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static p95(I)I
    .locals 1

    .prologue
    .line 379
    mul-int/lit8 v0, p0, 0x5f

    add-int/lit8 v0, v0, 0x63

    div-int/lit8 v0, v0, 0x64

    add-int/lit8 v0, v0, -0x1

    .line 380
    if-gez v0, :cond_0

    const/4 v0, 0x0

    :cond_0
    return v0
.end method

.method public static popupBegin()V
    .locals 1

    .prologue
    .line 248
    const/16 v0, 0x11

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static popupBuildBegin()V
    .locals 1

    .prologue
    .line 250
    const/16 v0, 0x16

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static popupBuildEnd()V
    .locals 1

    .prologue
    .line 251
    const/16 v0, 0x16

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static popupEnd()V
    .locals 1

    .prologue
    .line 249
    const/16 v0, 0x11

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static popupShowBegin()V
    .locals 1

    .prologue
    .line 252
    const/16 v0, 0x17

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static popupShowEnd()V
    .locals 1

    .prologue
    .line 253
    const/16 v0, 0x17

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static reset()V
    .locals 4

    .prologue
    const-wide/16 v2, -0x1

    const/4 v1, 0x0

    .line 385
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 386
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 387
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 388
    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sStart:[J

    invoke-static {v0, v2, v3}, Ljava/util/Arrays;->fill([JJ)V

    .line 389
    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sShownFrom:J

    .line 390
    sput v1, Lcom/mrkeyboard/app/MrPerf;->sLoggedKeys:I

    .line 391
    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sEchoAt:J

    .line 392
    sput-wide v2, Lcom/mrkeyboard/app/MrPerf;->sCapsAt:J

    .line 393
    invoke-static {}, Lcom/mrkeyboard/app/MrTrim;->forget()V

    .line 394
    return-void
.end method

.method static saveStart(Landroid/content/Context;)V
    .locals 6

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 427
    sget-boolean v0, Lcom/mrkeyboard/app/MrPerf;->sStartSaved:Z

    if-nez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v0, v0, v1

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v0, v0, v2

    if-nez v0, :cond_1

    .line 436
    :cond_0
    :goto_0
    return-void

    .line 429
    :cond_1
    :try_start_0
    const-string v0, "mr_perf"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 430
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

    .line 431
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

    .line 432
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrPerf;->sStartSaved:Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 433
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static selBegin()V
    .locals 1

    .prologue
    .line 255
    const/16 v0, 0x18

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static selEnd()V
    .locals 1

    .prologue
    .line 256
    const/16 v0, 0x18

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static startColumn(I)I
    .locals 1

    .prologue
    const/4 v0, 0x1

    .line 403
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

    .line 462
    new-array v6, v7, [I

    move v1, v4

    move v2, v4

    .line 465
    :goto_0
    if-eqz p0, :cond_7

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-gt v1, v0, :cond_7

    if-ge v2, v7, :cond_7

    .line 466
    const/16 v0, 0x3b

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    .line 467
    if-gez v0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    :cond_0
    move v3, v4

    move v5, v1

    .line 469
    :goto_1
    if-ge v3, p1, :cond_3

    if-ltz v5, :cond_3

    .line 470
    invoke-virtual {p0, v8, v5}, Ljava/lang/String;->indexOf(II)I

    move-result v1

    .line 471
    if-ltz v1, :cond_1

    if-lt v1, v0, :cond_2

    :cond_1
    const/4 v1, -0x1

    .line 469
    :goto_2
    add-int/lit8 v3, v3, 0x1

    move v5, v1

    goto :goto_1

    .line 471
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 473
    :cond_3
    if-ltz v5, :cond_6

    .line 474
    invoke-virtual {p0, v8, v5}, Ljava/lang/String;->indexOf(II)I

    move-result v1

    .line 475
    if-ltz v1, :cond_4

    if-le v1, v0, :cond_5

    :cond_4
    move v1, v0

    .line 476
    :cond_5
    if-le v1, v5, :cond_6

    .line 478
    :try_start_0
    invoke-virtual {p0, v5, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 479
    if-ltz v3, :cond_9

    add-int/lit8 v1, v2, 0x1

    :try_start_1
    aput v3, v6, v2
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_1

    :goto_3
    move v2, v1

    .line 485
    :cond_6
    :goto_4
    add-int/lit8 v1, v0, 0x1

    .line 486
    goto :goto_0

    .line 487
    :cond_7
    const/4 v0, 0x4

    new-array v0, v0, [I

    .line 488
    aput v2, v0, v4

    .line 489
    if-nez v2, :cond_8

    .line 494
    :goto_5
    return-object v0

    .line 490
    :cond_8
    invoke-static {v6, v4, v2}, Ljava/util/Arrays;->sort([III)V

    .line 491
    const/4 v1, 0x1

    aget v3, v6, v4

    aput v3, v0, v1

    .line 492
    const/4 v1, 0x2

    mul-int/lit8 v3, v2, 0x32

    add-int/lit8 v3, v3, 0x63

    div-int/lit8 v3, v3, 0x64

    add-int/lit8 v3, v3, -0x1

    aget v3, v6, v3

    aput v3, v0, v1

    .line 493
    const/4 v1, 0x3

    add-int/lit8 v2, v2, -0x1

    aget v2, v6, v2

    aput v2, v0, v1

    goto :goto_5

    .line 480
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
    .line 414
    :try_start_0
    const-string v0, "mr_perf"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "starts"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 415
    if-nez v0, :cond_0

    const-string v0, ""
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 417
    :cond_0
    :goto_0
    return-object v0

    .line 416
    :catch_0
    move-exception v0

    .line 417
    const-string v0, ""

    goto :goto_0
.end method

.method static stats(I)[I
    .locals 10

    .prologue
    const/16 v3, 0x100

    const/4 v2, 0x0

    .line 357
    const/4 v0, 0x5

    new-array v0, v0, [I

    .line 358
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sCount:[I

    aget v1, v1, p0

    .line 359
    aput v1, v0, v2

    .line 360
    if-ge v1, v3, :cond_0

    move v3, v1

    .line 361
    :cond_0
    if-nez v3, :cond_1

    .line 374
    :goto_0
    return-object v0

    .line 362
    :cond_1
    const-wide/16 v4, 0x0

    .line 363
    mul-int/lit16 v6, p0, 0x100

    move v1, v2

    .line 364
    :goto_1
    if-ge v1, v3, :cond_2

    .line 365
    sget-object v7, Lcom/mrkeyboard/app/MrPerf;->sRing:[I

    add-int v8, v6, v1

    aget v7, v7, v8

    .line 366
    sget-object v8, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    aput v7, v8, v1

    .line 367
    int-to-long v8, v7

    add-long/2addr v4, v8

    .line 364
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 369
    :cond_2
    sget-object v1, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    invoke-static {v1, v2, v3}, Ljava/util/Arrays;->sort([III)V

    .line 370
    const/4 v1, 0x1

    int-to-long v6, v3

    div-long/2addr v4, v6

    long-to-int v2, v4

    aput v2, v0, v1

    .line 371
    const/4 v1, 0x2

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sScratch:[I

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->p95(I)I

    move-result v3

    aget v2, v2, v3

    aput v2, v0, v1

    .line 372
    const/4 v1, 0x3

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sMax:[I

    aget v2, v2, p0

    aput v2, v0, v1

    .line 373
    const/4 v1, 0x4

    sget-object v2, Lcom/mrkeyboard/app/MrPerf;->sLast:[I

    aget v2, v2, p0

    aput v2, v0, v1

    goto :goto_0
.end method

.method public static suggBegin()V
    .locals 1

    .prologue
    .line 238
    const/16 v0, 0x8

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static suggEnd()V
    .locals 1

    .prologue
    .line 239
    const/16 v0, 0x8

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static suggEngineBegin()V
    .locals 1

    .prologue
    .line 240
    const/16 v0, 0xd

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static suggEngineEnd()V
    .locals 1

    .prologue
    .line 241
    const/16 v0, 0xd

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method public static suggShowBegin()V
    .locals 1

    .prologue
    .line 242
    const/16 v0, 0xe

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static suggShowEnd()V
    .locals 1

    .prologue
    .line 243
    const/16 v0, 0xe

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method

.method static summary(Landroid/content/Context;)Ljava/lang/String;
    .locals 15

    .prologue
    const/4 v14, 0x3

    const/4 v13, 0x4

    const/4 v12, 0x2

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 527
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    .line 528
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->startsOf(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v7

    move v5, v2

    .line 529
    :goto_0
    const/16 v0, 0x26

    if-ge v5, v0, :cond_9

    .line 530
    invoke-static {v5}, Lcom/mrkeyboard/app/MrPerf;->stats(I)[I

    move-result-object v8

    .line 531
    invoke-static {v5}, Lcom/mrkeyboard/app/MrPerf;->startColumn(I)I

    move-result v9

    .line 532
    if-ltz v9, :cond_1

    move v0, v1

    .line 534
    :goto_1
    aget v3, v8, v2

    if-nez v3, :cond_2

    if-nez v0, :cond_2

    .line 529
    :cond_0
    :goto_2
    add-int/lit8 v0, v5, 0x1

    move v5, v0

    goto :goto_0

    :cond_1
    move v0, v2

    .line 532
    goto :goto_1

    .line 535
    :cond_2
    if-ne v5, v13, :cond_6

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPerf;->mode(Landroid/content/Context;)I

    move-result v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPerf;->frameName(I)Ljava/lang/String;

    move-result-object v3

    :goto_3
    new-array v4, v2, [Ljava/lang/Object;

    invoke-static {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 537
    if-nez v3, :cond_10

    if-ne v5, v13, :cond_10

    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    aget-object v3, v3, v13

    new-array v4, v2, [Ljava/lang/Object;

    invoke-static {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    move-object v4, v3

    .line 538
    :goto_4
    if-eqz v4, :cond_0

    .line 539
    aget v3, v8, v2

    if-lez v3, :cond_4

    .line 540
    aget v3, v8, v2

    if-ne v3, v1, :cond_7

    .line 541
    const-string v3, "mr_ui_perf_one"

    new-array v10, v12, [Ljava/lang/Object;

    aput-object v4, v10, v2

    aget v8, v8, v13

    invoke-static {v8}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v8

    aput-object v8, v10, v1

    invoke-static {p0, v3, v10}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 543
    :goto_5
    if-eqz v3, :cond_4

    .line 544
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->length()I

    move-result v8

    if-lez v8, :cond_3

    const/16 v8, 0xa

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 545
    :cond_3
    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 548
    :cond_4
    if-eqz v0, :cond_0

    .line 550
    invoke-static {v7, v9}, Lcom/mrkeyboard/app/MrPerf;->startStats(Ljava/lang/String;I)[I

    move-result-object v0

    .line 551
    aget v3, v0, v2

    if-ge v3, v12, :cond_8

    const/4 v0, 0x0

    .line 553
    :goto_6
    if-eqz v0, :cond_0

    .line 554
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    if-lez v3, :cond_5

    const/16 v3, 0xa

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 555
    :cond_5
    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_2

    .line 535
    :cond_6
    sget-object v3, Lcom/mrkeyboard/app/MrPerf;->NAMES:[Ljava/lang/String;

    aget-object v3, v3, v5

    goto :goto_3

    .line 542
    :cond_7
    const-string v3, "mr_ui_perf_stat"

    const/4 v10, 0x5

    new-array v10, v10, [Ljava/lang/Object;

    aput-object v4, v10, v2

    aget v11, v8, v1

    invoke-static {v11}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v11

    aput-object v11, v10, v1

    aget v11, v8, v12

    invoke-static {v11}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v11

    aput-object v11, v10, v12

    aget v11, v8, v14

    invoke-static {v11}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v11

    aput-object v11, v10, v14

    aget v8, v8, v2

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v10, v13

    invoke-static {p0, v3, v10}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    goto :goto_5

    .line 552
    :cond_8
    const-string v3, "mr_ui_perf_starts"

    const/4 v8, 0x5

    new-array v8, v8, [Ljava/lang/Object;

    aput-object v4, v8, v2

    aget v4, v0, v2

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v8, v1

    aget v4, v0, v1

    invoke-static {v4}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v8, v12

    aget v4, v0, v12

    invoke-static {v4}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v8, v14

    aget v0, v0, v14

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->ms(I)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v8, v13

    invoke-static {p0, v3, v8}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_6

    .line 559
    :cond_9
    sget v0, Lcom/mrkeyboard/app/MrTrim;->sCount:I

    if-lez v0, :cond_b

    .line 561
    const-string v0, "mr_ui_perf_trim_last"

    const/4 v3, 0x5

    new-array v3, v3, [Ljava/lang/Object;

    sget v4, Lcom/mrkeyboard/app/MrTrim;->sLevel:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v2

    sget v4, Lcom/mrkeyboard/app/MrTrim;->sKeyboards:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v1

    sget v4, Lcom/mrkeyboard/app/MrTrim;->sPopups:I

    .line 562
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v12

    sget v4, Lcom/mrkeyboard/app/MrTrim;->sShadows:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v14

    sget v4, Lcom/mrkeyboard/app/MrTrim;->sBytes:I

    int-to-long v4, v4

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v13

    .line 561
    invoke-static {p0, v0, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 563
    if-eqz v0, :cond_b

    .line 564
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    if-lez v3, :cond_a

    const/16 v3, 0xa

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 565
    :cond_a
    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 568
    :cond_b
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    if-lez v0, :cond_f

    move v0, v1

    .line 569
    :goto_7
    if-nez v0, :cond_c

    .line 570
    const-string v3, "mr_ui_perf_none"

    new-array v4, v2, [Ljava/lang/Object;

    invoke-static {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 571
    if-eqz v3, :cond_c

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 573
    :cond_c
    const-string v3, "mr_ui_perf_mem"

    new-array v4, v12, [Ljava/lang/Object;

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->heapUsed()J

    move-result-wide v8

    invoke-static {v8, v9}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v2

    invoke-static {}, Landroid/os/Debug;->getNativeHeapAllocatedSize()J

    move-result-wide v8

    invoke-static {v8, v9}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v1

    invoke-static {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 574
    if-eqz v1, :cond_d

    const/16 v3, 0xa

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 575
    :cond_d
    if-eqz v0, :cond_e

    .line 576
    const-string v0, "mr_ui_perf_reset"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 577
    if-eqz v0, :cond_e

    const/16 v1, 0xa

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 579
    :cond_e
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_f
    move v0, v2

    .line 568
    goto :goto_7

    :cond_10
    move-object v4, v3

    goto/16 :goto_4
.end method

.method public static touch(Landroid/view/MotionEvent;)V
    .locals 6

    .prologue
    .line 315
    if-nez p0, :cond_1

    .line 319
    :cond_0
    :goto_0
    return-void

    .line 316
    :cond_1
    invoke-virtual {p0}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    .line 317
    if-eqz v0, :cond_2

    const/4 v1, 0x5

    if-ne v0, v1, :cond_0

    .line 318
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
    .line 166
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    return-void
.end method

.method public static viewEnd()V
    .locals 1

    .prologue
    .line 167
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    return-void
.end method
