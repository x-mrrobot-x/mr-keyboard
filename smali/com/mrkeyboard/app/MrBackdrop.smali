.class final Lcom/mrkeyboard/app/MrBackdrop;
.super Ljava/lang/Object;
.source "MrBackdrop.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrBackdrop$Grad;,
        Lcom/mrkeyboard/app/MrBackdrop$Spec;,
        Lcom/mrkeyboard/app/MrBackdrop$Look;
    }
.end annotation


# static fields
.field static final ASPECT:F = 2.0f

.field static final BAR_SHARE:F = 0.17f

.field static final COLOR:I = 0x4

.field static final COLORS:[I

.field static final DARK_OWN_TAGS:[Ljava/lang/String;

.field static final DARK_SLATE:I = -0xc3b5a2

.field static final DARK_TARGET:F = 0.4f

.field static final DEFAULT_SOFT:I = 0x19

.field static final FILE:Ljava/lang/String; = "kbd_bg.jpg"

.field static final GRADIENT:I = 0x1

.field static final GRADIENT_COUNT:I

.field static final GRADS:[Lcom/mrkeyboard/app/MrBackdrop$Grad;

.field static final IMAGE:I = 0x3

.field static final JPEG_QUALITY:I = 0x5a

.field static final KINDS:I = 0x3

.field static final KIND_FIRST:[I

.field static final KIND_GLASS:I = 0x0

.field static final KIND_GRADIENT:I = 0x2

.field static final KIND_OUTLINE:I = 0x1

.field static final LIGHT_TARGET:F = 0.62f

.field static final MAX_SIDE:I = 0x500

.field static final MAX_SOFT:I = 0x46

.field static final MAX_VEIL:F = 0.75f

.field static final NONE:I = 0x0

.field static final OWN_DEFAULT:I = -0x908401

.field static final PALE_PRESET:F = 0.85f

.field static final PENDING:Ljava/lang/String; = "kbd_bg_new.jpg"

.field static final PREF:Ljava/lang/String; = "pref_kbd_bg"

.field static final PREF_SOFT:Ljava/lang/String; = "pref_kbd_bg_soft"

.field static final PRESETS:I = 0xf

.field static final PROBE_W:I = 0x30

.field static final SCENE:I = 0x2

.field static final STYLES:I

.field static final STYLE_COLORS:[[I

.field static final STYLE_TAGS:[Ljava/lang/String;

.field static final TAG_DARK_INK:Ljava/lang/String; = "mr_overdark"

.field static final TAG_LIGHT_INK:Ljava/lang/String; = "mr_overlight"

.field static final WHITE_INK_CONTRAST:F = 4.5f

.field static final ZOOM_MAX:I = 0x190

.field static final ZOOM_MIN:I = 0x64

.field private static sDrawable:Lcom/mrkeyboard/app/MrBackdropDrawable;

.field private static sDrawableKey:Ljava/lang/String;

.field private static sLook:Lcom/mrkeyboard/app/MrBackdrop$Look;

.field private static sLookKey:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 12

    .prologue
    const/4 v11, 0x4

    const/4 v10, 0x3

    const/4 v9, 0x1

    const/4 v8, 0x0

    const/4 v7, 0x2

    .line 84
    const/16 v0, 0xf

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/mrkeyboard/app/MrBackdrop;->COLORS:[I

    .line 115
    const/16 v0, 0x14

    new-array v0, v0, [Lcom/mrkeyboard/app/MrBackdrop$Grad;

    new-array v1, v10, [I

    fill-array-data v1, :array_1

    .line 116
    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v1

    aput-object v1, v0, v8

    new-array v1, v10, [I

    fill-array-data v1, :array_2

    .line 117
    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v1

    aput-object v1, v0, v9

    new-array v1, v7, [I

    fill-array-data v1, :array_3

    .line 118
    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v1

    aput-object v1, v0, v7

    new-array v1, v7, [I

    fill-array-data v1, :array_4

    .line 119
    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v1

    aput-object v1, v0, v10

    new-array v1, v7, [I

    fill-array-data v1, :array_5

    .line 120
    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v1

    aput-object v1, v0, v11

    const/4 v1, 0x5

    new-instance v2, Lcom/mrkeyboard/app/MrBackdrop$Grad;

    const/16 v3, 0xb4

    new-array v4, v11, [I

    fill-array-data v4, :array_6

    new-array v5, v11, [F

    fill-array-data v5, :array_7

    const/4 v6, 0x0

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrBackdrop$Grad;-><init>(I[I[F[I)V

    aput-object v2, v0, v1

    const/4 v1, 0x6

    new-array v2, v7, [I

    fill-array-data v2, :array_8

    .line 122
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v2

    aput-object v2, v0, v1

    const/4 v1, 0x7

    new-array v2, v7, [I

    fill-array-data v2, :array_9

    .line 123
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v2

    aput-object v2, v0, v1

    const/16 v1, 0x8

    new-array v2, v7, [I

    fill-array-data v2, :array_a

    .line 124
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v2

    aput-object v2, v0, v1

    const/16 v1, 0x9

    new-array v2, v7, [I

    fill-array-data v2, :array_b

    .line 125
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v2

    aput-object v2, v0, v1

    const/16 v1, 0xa

    new-array v2, v7, [I

    fill-array-data v2, :array_c

    .line 126
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v2

    aput-object v2, v0, v1

    const/16 v1, 0xb

    new-array v2, v7, [I

    fill-array-data v2, :array_d

    .line 127
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v2

    aput-object v2, v0, v1

    const/16 v1, 0xc

    new-array v2, v7, [I

    fill-array-data v2, :array_e

    .line 128
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v2

    aput-object v2, v0, v1

    const/16 v1, 0xd

    new-array v2, v7, [I

    fill-array-data v2, :array_f

    .line 129
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v2

    aput-object v2, v0, v1

    const/16 v1, 0xe

    new-array v2, v7, [I

    fill-array-data v2, :array_10

    .line 130
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v2

    aput-object v2, v0, v1

    const/16 v1, 0xf

    new-instance v2, Lcom/mrkeyboard/app/MrBackdrop$Grad;

    const/16 v3, 0xb4

    new-array v4, v10, [I

    fill-array-data v4, :array_11

    new-array v5, v10, [F

    fill-array-data v5, :array_12

    const/4 v6, 0x0

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrBackdrop$Grad;-><init>(I[I[F[I)V

    aput-object v2, v0, v1

    const/16 v1, 0x10

    new-array v2, v7, [I

    fill-array-data v2, :array_13

    .line 132
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v2

    aput-object v2, v0, v1

    const/16 v1, 0x11

    new-instance v2, Lcom/mrkeyboard/app/MrBackdrop$Grad;

    const/16 v3, 0xb4

    new-array v4, v7, [I

    fill-array-data v4, :array_14

    const/4 v5, 0x0

    new-array v6, v11, [I

    fill-array-data v6, :array_15

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrBackdrop$Grad;-><init>(I[I[F[I)V

    aput-object v2, v0, v1

    const/16 v1, 0x12

    new-array v2, v7, [I

    fill-array-data v2, :array_16

    .line 134
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;

    move-result-object v2

    aput-object v2, v0, v1

    const/16 v1, 0x13

    new-instance v2, Lcom/mrkeyboard/app/MrBackdrop$Grad;

    const/16 v3, 0xb4

    new-array v4, v7, [I

    fill-array-data v4, :array_17

    const/4 v5, 0x0

    new-array v6, v11, [I

    fill-array-data v6, :array_18

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrBackdrop$Grad;-><init>(I[I[F[I)V

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrBackdrop;->GRADS:[Lcom/mrkeyboard/app/MrBackdrop$Grad;

    .line 137
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->GRADS:[Lcom/mrkeyboard/app/MrBackdrop$Grad;

    array-length v0, v0

    sput v0, Lcom/mrkeyboard/app/MrBackdrop;->GRADIENT_COUNT:I

    .line 537
    new-array v0, v10, [Ljava/lang/String;

    const-string v1, "mr_overpaleglass"

    aput-object v1, v0, v8

    const-string v1, "mr_overpaleline"

    aput-object v1, v0, v9

    const-string v1, "mr_overpalegrad"

    aput-object v1, v0, v7

    sput-object v0, Lcom/mrkeyboard/app/MrBackdrop;->DARK_OWN_TAGS:[Ljava/lang/String;

    .line 544
    const/16 v0, 0x12

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "mr_overlight"

    aput-object v1, v0, v8

    const-string v1, "mr_overice"

    aput-object v1, v0, v9

    const-string v1, "mr_overlilac"

    aput-object v1, v0, v7

    const-string v1, "mr_overmint"

    aput-object v1, v0, v10

    const-string v1, "mr_overshade"

    aput-object v1, v0, v11

    const/4 v1, 0x5

    const-string v2, "mr_overline"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "mr_overteal"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "mr_overviolet"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "mr_overfuchsia"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "mr_overlime"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "mr_overgold"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "mr_overdawn"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "mr_overtide"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "mr_overprism"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "mr_overlagoon"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "mr_overownglass"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, "mr_overownline"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "mr_overowngrad"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrBackdrop;->STYLE_TAGS:[Ljava/lang/String;

    .line 549
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->STYLE_TAGS:[Ljava/lang/String;

    array-length v0, v0

    sput v0, Lcom/mrkeyboard/app/MrBackdrop;->STYLES:I

    .line 555
    new-array v0, v11, [I

    fill-array-data v0, :array_19

    sput-object v0, Lcom/mrkeyboard/app/MrBackdrop;->KIND_FIRST:[I

    .line 562
    const/16 v0, 0xf

    new-array v0, v0, [[I

    new-array v1, v9, [I

    const/4 v2, -0x1

    aput v2, v1, v8

    aput-object v1, v0, v8

    new-array v1, v9, [I

    const v2, -0xb25c01

    aput v2, v1, v8

    aput-object v1, v0, v9

    new-array v1, v9, [I

    const v2, -0x588401

    aput v2, v1, v8

    aput-object v1, v0, v7

    new-array v1, v9, [I

    const v2, -0xc22369

    aput v2, v1, v8

    aput-object v1, v0, v10

    new-array v1, v9, [I

    const v2, -0xd5ccb0

    aput v2, v1, v8

    aput-object v1, v0, v11

    const/4 v1, 0x5

    new-array v2, v9, [I

    const/4 v3, -0x1

    aput v3, v2, v8

    aput-object v2, v0, v1

    const/4 v1, 0x6

    new-array v2, v9, [I

    const v3, -0xd21d1a

    aput v3, v2, v8

    aput-object v2, v0, v1

    const/4 v1, 0x7

    new-array v2, v9, [I

    const v3, -0x587406

    aput v3, v2, v8

    aput-object v2, v0, v1

    const/16 v1, 0x8

    new-array v2, v9, [I

    const v3, -0xa02e

    aput v3, v2, v8

    aput-object v2, v0, v1

    const/16 v1, 0x9

    new-array v2, v9, [I

    const v3, -0x591dd2

    aput v3, v2, v8

    aput-object v2, v0, v1

    const/16 v1, 0xa

    new-array v2, v9, [I

    const/16 v3, -0x37c3

    aput v3, v2, v8

    aput-object v2, v0, v1

    const/16 v1, 0xb

    new-array v2, v10, [I

    fill-array-data v2, :array_1a

    aput-object v2, v0, v1

    const/16 v1, 0xc

    new-array v2, v10, [I

    fill-array-data v2, :array_1b

    aput-object v2, v0, v1

    const/16 v1, 0xd

    new-array v2, v10, [I

    fill-array-data v2, :array_1c

    aput-object v2, v0, v1

    const/16 v1, 0xe

    new-array v2, v10, [I

    fill-array-data v2, :array_1d

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrBackdrop;->STYLE_COLORS:[[I

    return-void

    .line 84
    nop

    :array_0
    .array-data 4
        -0xd9cdc8
        -0x261504
        -0xea9a40
        -0x39d7d8
        -0xff96a4
        -0xc8c6c3
        -0x7f2116
        -0xbad860
        -0x95e466
        -0x52eba9
        -0x74430
        -0x283338
        -0xc8b8b1
        -0x1000000
        -0xe9e9ea
    .end array-data

    .line 115
    :array_1
    .array-data 4
        -0xe4eb9c
        -0xa4d57a
        -0x4db05c
    .end array-data

    .line 116
    :array_2
    .array-data 4
        -0x9d9a96
        -0xc7c6c3
        -0xf9f9f9
    .end array-data

    .line 117
    :array_3
    .array-data 4
        -0xe58a1d
        -0xf2b04d
    .end array-data

    .line 118
    :array_4
    .array-data 4
        -0xff7c91
        -0xffa6b1
    .end array-data

    .line 119
    :array_5
    .array-data 4
        -0xa3948d
        -0xd4c9c4
    .end array-data

    .line 120
    :array_6
    .array-data 4
        -0xc8976a
        -0xd0a783
        -0xe3cdb7
        -0xf1e7da
    .end array-data

    :array_7
    .array-data 4
        0x0
        0x3f0ccccd    # 0.55f
        0x3f6147ae    # 0.88f
        0x3f800000    # 1.0f
    .end array-data

    :array_8
    .array-data 4
        -0xa6a4a0
        -0xd0ccc8
    .end array-data

    .line 122
    :array_9
    .array-data 4
        -0xf4a9b4
        -0xfee0e2
    .end array-data

    .line 123
    :array_a
    .array-data 4
        -0xff7a76
        -0xeea89f
    .end array-data

    .line 124
    :array_b
    .array-data 4
        -0x7b865b
        -0xb5bda8
    .end array-data

    .line 125
    :array_c
    .array-data 4
        -0xaeb464
        -0xe0a08b
    .end array-data

    .line 126
    :array_d
    .array-data 4
        -0xff8f71
        -0xe3baa0
    .end array-data

    .line 127
    :array_e
    .array-data 4
        -0xb1d340
        -0xd3e57e
    .end array-data

    .line 128
    :array_f
    .array-data 4
        -0x4fe8a6
        -0x73f2b8
    .end array-data

    .line 129
    :array_10
    .array-data 4
        -0xfa6b20
        -0xfdca52
    .end array-data

    .line 130
    :array_11
    .array-data 4
        -0xd0d8bb
        -0x95a75a
        -0x588378
    .end array-data

    :array_12
    .array-data 4
        0x0
        0x3f333333    # 0.7f
        0x3f800000    # 1.0f
    .end array-data

    :array_13
    .array-data 4
        -0xf5b060
        -0xaccf61
    .end array-data

    .line 132
    :array_14
    .array-data 4
        -0xefbf3c
        -0xf39758
    .end array-data

    :array_15
    .array-data 4
        0x32
        0x5c
        0x3e
        -0x26f14fa0
    .end array-data

    :array_16
    .array-data 4
        -0xa3c59e
        -0x73af98
    .end array-data

    .line 134
    :array_17
    .array-data 4
        -0xc5a06e
        -0xc4b07e
    .end array-data

    :array_18
    .array-data 4
        0x64
        0x64
        0x4e
        -0x19178f84
    .end array-data

    .line 555
    :array_19
    .array-data 4
        0x0
        0x5
        0xb
        0xf
    .end array-data

    .line 562
    :array_1a
    .array-data 4
        -0x4cb9
        -0xa05e
        -0x649401
    .end array-data

    :array_1b
    .array-data 4
        -0xdd1e01
        -0xb28301
        -0x4f9401
    .end array-data

    :array_1c
    .array-data 4
        -0xb293
        -0xb20066
        -0xb27201
    .end array-data

    :array_1d
    .array-data 4
        -0x5c00a4
        -0xe61950
        -0xc27401
    .end array-data
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 139
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static declared-synchronized apply()V
    .locals 9

    .prologue
    .line 852
    const-class v1, Lcom/mrkeyboard/app/MrBackdrop;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarRoot:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 853
    if-nez v0, :cond_1

    .line 875
    :cond_0
    :goto_0
    monitor-exit v1

    return-void

    .line 854
    :cond_1
    :try_start_1
    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v2

    .line 855
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->tag()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrThemeColors;->hidden(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 856
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v3

    .line 857
    iget v4, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eqz v4, :cond_0

    .line 858
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->darkNow(Landroid/content/Context;)Z

    move-result v4

    .line 859
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->soft(Landroid/content/Context;)I

    move-result v5

    .line 860
    const-string v6, "kbd_bg"

    invoke-static {v6}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v6

    .line 862
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->format()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "|"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "|"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "|"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 863
    sget-object v8, Lcom/mrkeyboard/app/MrBackdrop;->sDrawable:Lcom/mrkeyboard/app/MrBackdropDrawable;

    if-eqz v8, :cond_2

    sget-object v8, Lcom/mrkeyboard/app/MrBackdrop;->sDrawableKey:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_3

    .line 864
    :cond_2
    invoke-static {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrBackdropDrawable;->create(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;ZII)Lcom/mrkeyboard/app/MrBackdropDrawable;

    move-result-object v2

    .line 865
    if-eqz v2, :cond_0

    .line 866
    sput-object v2, Lcom/mrkeyboard/app/MrBackdrop;->sDrawable:Lcom/mrkeyboard/app/MrBackdropDrawable;

    .line 867
    sput-object v7, Lcom/mrkeyboard/app/MrBackdrop;->sDrawableKey:Ljava/lang/String;

    .line 869
    :cond_3
    sget-object v2, Lcom/mrkeyboard/app/MrBackdrop;->sDrawable:Lcom/mrkeyboard/app/MrBackdropDrawable;

    invoke-virtual {v0, v2}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 870
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    .line 871
    if-eqz v0, :cond_0

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/view/View;->setBackgroundColor(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 872
    :catch_0
    move-exception v0

    goto :goto_0

    .line 852
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static bitmap(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;)Landroid/graphics/Bitmap;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 385
    if-eqz p1, :cond_0

    if-nez p0, :cond_1

    .line 388
    :cond_0
    :goto_0
    return-object v0

    .line 386
    :cond_1
    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v2, 0x3

    if-ne v1, v2, :cond_2

    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->load(Landroid/content/Context;)Landroid/graphics/Bitmap;

    move-result-object v0

    goto :goto_0

    .line 387
    :cond_2
    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v2, 0x2

    if-ne v1, v2, :cond_0

    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrScenes;->load(Landroid/content/Context;I)Landroid/graphics/Bitmap;

    move-result-object v0

    goto :goto_0
.end method

.method static bottomColor(Landroid/content/Context;)I
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 837
    if-eqz p0, :cond_0

    :try_start_0
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x24

    if-lt v1, v2, :cond_1

    .line 841
    :cond_0
    :goto_0
    return v0

    .line 838
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->lookNow(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Look;

    move-result-object v1

    .line 839
    if-eqz v1, :cond_0

    iget v0, v1, Lcom/mrkeyboard/app/MrBackdrop$Look;->bottom:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 840
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static channel(I)D
    .locals 4

    .prologue
    .line 487
    int-to-double v0, p0

    const-wide v2, 0x406fe00000000000L    # 255.0

    div-double/2addr v0, v2

    .line 488
    const-wide v2, 0x3fa41c8216c61523L    # 0.03928

    cmpg-double v2, v0, v2

    if-gtz v2, :cond_0

    const-wide v2, 0x4029d70a3d70a3d7L    # 12.92

    div-double/2addr v0, v2

    :goto_0
    return-wide v0

    :cond_0
    const-wide v2, 0x3fac28f5c28f5c29L    # 0.055

    add-double/2addr v0, v2

    const-wide v2, 0x3ff0e147ae147ae1L    # 1.055

    div-double/2addr v0, v2

    const-wide v2, 0x4003333333333333L    # 2.4

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    goto :goto_0
.end method

.method static clamp(III)I
    .locals 0

    .prologue
    .line 223
    if-ge p0, p1, :cond_0

    :goto_0
    return p1

    :cond_0
    if-le p0, p2, :cond_1

    move p1, p2

    goto :goto_0

    :cond_1
    move p1, p0

    goto :goto_0
.end method

.method static commitPending(Landroid/content/Context;)Z
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 696
    :try_start_0
    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v2

    const-string v3, "kbd_bg_new.jpg"

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 697
    invoke-virtual {v1}, Ljava/io/File;->isFile()Z

    move-result v2

    if-eqz v2, :cond_0

    new-instance v2, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v3

    const-string v4, "kbd_bg.jpg"

    invoke-direct {v2, v3, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Ljava/io/File;->renameTo(Ljava/io/File;)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    .line 699
    :cond_0
    :goto_0
    return v0

    .line 698
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static contrast(II)F
    .locals 4

    .prologue
    const v3, 0x3d4ccccd    # 0.05f

    .line 476
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->linear(I)F

    move-result v0

    invoke-static {p1}, Lcom/mrkeyboard/app/MrBackdrop;->linear(I)F

    move-result v1

    .line 477
    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v2

    invoke-static {v0, v1}, Ljava/lang/Math;->min(FF)F

    move-result v0

    .line 478
    add-float v1, v2, v3

    add-float/2addr v0, v3

    div-float v0, v1, v0

    return v0
.end method

.method private static copy(Ljava/io/InputStream;Ljava/io/File;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 767
    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 769
    const/16 v0, 0x4000

    :try_start_0
    new-array v0, v0, [B

    .line 771
    :goto_0
    invoke-virtual {p0, v0}, Ljava/io/InputStream;->read([B)I

    move-result v2

    if-lez v2, :cond_0

    const/4 v3, 0x0

    invoke-virtual {v1, v0, v3, v2}, Ljava/io/OutputStream;->write([BII)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 773
    :catchall_0
    move-exception v0

    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V

    .line 774
    throw v0

    .line 773
    :cond_0
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V

    .line 775
    return-void
.end method

.method static crop(IIIIIII)Landroid/graphics/Rect;
    .locals 12

    .prologue
    .line 304
    if-lez p0, :cond_0

    if-lez p1, :cond_0

    if-lez p2, :cond_0

    if-gtz p3, :cond_1

    :cond_0
    new-instance v2, Landroid/graphics/Rect;

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v5, p0}, Ljava/lang/Math;->max(II)I

    move-result v5

    const/4 v6, 0x0

    invoke-static {v6, p1}, Ljava/lang/Math;->max(II)I

    move-result v6

    invoke-direct {v2, v3, v4, v5, v6}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 322
    :goto_0
    return-object v2

    .line 305
    :cond_1
    int-to-double v2, p2

    int-to-double v4, p3

    div-double v6, v2, v4

    .line 307
    int-to-double v2, p0

    int-to-double v4, p1

    div-double/2addr v2, v4

    cmpl-double v2, v2, v6

    if-lez v2, :cond_2

    .line 308
    int-to-double v2, p1

    .line 309
    int-to-double v4, p1

    mul-double/2addr v4, v6

    .line 314
    :goto_1
    const/16 v6, 0x64

    const/16 v7, 0x190

    move/from16 v0, p4

    invoke-static {v0, v6, v7}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v6

    int-to-double v6, v6

    const-wide/high16 v8, 0x4059000000000000L    # 100.0

    div-double/2addr v6, v8

    .line 315
    div-double/2addr v4, v6

    .line 316
    div-double/2addr v2, v6

    .line 317
    int-to-double v6, p0

    sub-double/2addr v6, v4

    const/16 v8, -0x64

    const/16 v9, 0x64

    move/from16 v0, p5

    invoke-static {v0, v8, v9}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v8

    add-int/lit8 v8, v8, 0x64

    int-to-double v8, v8

    mul-double/2addr v6, v8

    const-wide/high16 v8, 0x4069000000000000L    # 200.0

    div-double/2addr v6, v8

    .line 318
    int-to-double v8, p1

    sub-double/2addr v8, v2

    const/16 v10, -0x64

    const/16 v11, 0x64

    move/from16 v0, p6

    invoke-static {v0, v10, v11}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v10

    add-int/lit8 v10, v10, 0x64

    int-to-double v10, v10

    mul-double/2addr v8, v10

    const-wide/high16 v10, 0x4069000000000000L    # 200.0

    div-double/2addr v8, v10

    .line 320
    invoke-static {v6, v7}, Ljava/lang/Math;->round(D)J

    move-result-wide v6

    long-to-int v6, v6

    const/4 v7, 0x0

    add-int/lit8 v10, p0, -0x1

    invoke-static {v6, v7, v10}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v6

    invoke-static {v8, v9}, Ljava/lang/Math;->round(D)J

    move-result-wide v8

    long-to-int v7, v8

    const/4 v8, 0x0

    add-int/lit8 v9, p1, -0x1

    invoke-static {v7, v8, v9}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v7

    .line 321
    invoke-static {v4, v5}, Ljava/lang/Math;->round(D)J

    move-result-wide v4

    long-to-int v4, v4

    add-int/2addr v4, v6

    invoke-static {p0, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    invoke-static {v2, v3}, Ljava/lang/Math;->round(D)J

    move-result-wide v2

    long-to-int v2, v2

    add-int/2addr v2, v7

    invoke-static {p1, v2}, Ljava/lang/Math;->min(II)I

    move-result v3

    .line 322
    new-instance v2, Landroid/graphics/Rect;

    add-int/lit8 v5, v6, 0x1

    invoke-static {v5, v4}, Ljava/lang/Math;->max(II)I

    move-result v4

    add-int/lit8 v5, v7, 0x1

    invoke-static {v5, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-direct {v2, v6, v7, v4, v3}, Landroid/graphics/Rect;-><init>(IIII)V

    goto/16 :goto_0

    .line 311
    :cond_2
    int-to-double v4, p0

    .line 312
    int-to-double v2, p0

    div-double/2addr v2, v6

    goto :goto_1
.end method

.method static current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Spec;
    .locals 3

    .prologue
    .line 228
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 229
    if-nez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    :goto_0
    return-object v0

    :cond_0
    const-string v1, "pref_kbd_bg"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->parse(Ljava/lang/String;)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    goto :goto_0
.end method

.method static darkInk(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z
    .locals 3

    .prologue
    .line 497
    if-eqz p0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    const/4 v0, -0x1

    sget-object v1, Lcom/mrkeyboard/app/MrBackdrop;->COLORS:[I

    iget v2, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    aget v1, v1, v2

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrBackdrop;->contrast(II)F

    move-result v0

    const/high16 v1, 0x40900000    # 4.5f

    cmpg-float v0, v0, v1

    if-gez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static darkNow(Landroid/content/Context;)Z
    .locals 1

    .prologue
    .line 809
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->tag()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrThemeColors;->dark(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method private static decode(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/Bitmap;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 630
    :try_start_0
    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v2

    invoke-direct {v1, v2, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 631
    invoke-virtual {v1}, Ljava/io/File;->isFile()Z

    move-result v2

    if-nez v2, :cond_0

    .line 636
    :goto_0
    return-object v0

    .line 632
    :cond_0
    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 635
    :catch_0
    move-exception v1

    goto :goto_0

    .line 633
    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method static degrees(I)I
    .locals 1

    .prologue
    .line 713
    packed-switch p0, :pswitch_data_0

    .line 717
    :pswitch_0
    const/4 v0, 0x0

    :goto_0
    return v0

    .line 714
    :pswitch_1
    const/16 v0, 0x5a

    goto :goto_0

    .line 715
    :pswitch_2
    const/16 v0, 0xb4

    goto :goto_0

    .line 716
    :pswitch_3
    const/16 v0, 0x10e

    goto :goto_0

    .line 713
    :pswitch_data_0
    .packed-switch 0x3
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_0
        :pswitch_3
    .end packed-switch
.end method

.method private static delete(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 686
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 687
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->deleteOnExit()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 691
    :cond_0
    :goto_0
    return-void

    .line 688
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static discardPending(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 681
    const-string v0, "kbd_bg_new.jpg"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrBackdrop;->delete(Landroid/content/Context;Ljava/lang/String;)V

    .line 682
    return-void
.end method

.method private static varargs down([I)Lcom/mrkeyboard/app/MrBackdrop$Grad;
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 111
    new-instance v0, Lcom/mrkeyboard/app/MrBackdrop$Grad;

    const/16 v1, 0xb4

    invoke-direct {v0, v1, p0, v2, v2}, Lcom/mrkeyboard/app/MrBackdrop$Grad;-><init>(I[I[F[I)V

    return-object v0
.end method

.method static draw(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/MrBackdrop$Spec;IILandroid/graphics/Bitmap;)V
    .locals 2

    .prologue
    .line 254
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    if-lez p2, :cond_0

    if-gtz p3, :cond_1

    .line 269
    :cond_0
    :goto_0
    return-void

    .line 255
    :cond_1
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    .line 260
    :pswitch_0
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrBackdrop;->gradient(Landroid/graphics/Canvas;III)V

    goto :goto_0

    .line 257
    :pswitch_1
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->COLORS:[I

    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    aget v0, v0, v1

    invoke-virtual {p0, v0}, Landroid/graphics/Canvas;->drawColor(I)V

    goto :goto_0

    .line 264
    :pswitch_2
    if-eqz p4, :cond_0

    invoke-static {p0, p1, p4, p2, p3}, Lcom/mrkeyboard/app/MrBackdrop;->picture(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;II)V

    goto :goto_0

    .line 255
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_2
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method private static fit(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;
    .locals 4

    .prologue
    const/4 v3, 0x1

    .line 779
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 780
    const/16 v1, 0x500

    if-gt v0, v1, :cond_0

    .line 782
    :goto_0
    return-object p0

    .line 781
    :cond_0
    const/high16 v1, 0x44a00000    # 1280.0f

    int-to-float v0, v0

    div-float v0, v1, v0

    .line 782
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v1

    int-to-float v1, v1

    mul-float/2addr v1, v0

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    invoke-static {v3, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    int-to-float v2, v2

    mul-float/2addr v0, v2

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-static {v3, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-static {p0, v1, v0, v3}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object p0

    goto :goto_0
.end method

.method private static gradient(Landroid/graphics/Canvas;III)V
    .locals 10

    .prologue
    .line 272
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->GRADS:[Lcom/mrkeyboard/app/MrBackdrop$Grad;

    aget-object v8, v0, p1

    .line 273
    iget v0, v8, Lcom/mrkeyboard/app/MrBackdrop$Grad;->angle:I

    int-to-double v0, v0

    invoke-static {v0, v1}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v0

    .line 274
    invoke-static {v0, v1}, Ljava/lang/Math;->sin(D)D

    move-result-wide v2

    double-to-float v3, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->cos(D)D

    move-result-wide v0

    neg-double v0, v0

    double-to-float v4, v0

    .line 276
    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v0

    int-to-float v1, p2

    mul-float/2addr v0, v1

    invoke-static {v4}, Ljava/lang/Math;->abs(F)F

    move-result v1

    int-to-float v2, p3

    mul-float/2addr v1, v2

    add-float/2addr v0, v1

    const/high16 v1, 0x40000000    # 2.0f

    div-float v5, v0, v1

    .line 277
    int-to-float v0, p2

    const/high16 v1, 0x40000000    # 2.0f

    div-float v6, v0, v1

    int-to-float v0, p3

    const/high16 v1, 0x40000000    # 2.0f

    div-float v7, v0, v1

    .line 278
    new-instance v9, Landroid/graphics/Paint;

    const/4 v0, 0x1

    invoke-direct {v9, v0}, Landroid/graphics/Paint;-><init>(I)V

    .line 279
    const/4 v0, 0x1

    invoke-virtual {v9, v0}, Landroid/graphics/Paint;->setDither(Z)V

    .line 280
    new-instance v0, Landroid/graphics/LinearGradient;

    mul-float v1, v3, v5

    sub-float v1, v6, v1

    mul-float v2, v4, v5

    sub-float v2, v7, v2

    mul-float/2addr v3, v5

    add-float/2addr v3, v6

    mul-float/2addr v4, v5

    add-float/2addr v4, v7

    iget-object v5, v8, Lcom/mrkeyboard/app/MrBackdrop$Grad;->colours:[I

    iget-object v6, v8, Lcom/mrkeyboard/app/MrBackdrop$Grad;->stops:[F

    sget-object v7, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct/range {v0 .. v7}, Landroid/graphics/LinearGradient;-><init>(FFFF[I[FLandroid/graphics/Shader$TileMode;)V

    invoke-virtual {v9, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 281
    const/4 v1, 0x0

    const/4 v2, 0x0

    int-to-float v3, p2

    int-to-float v4, p3

    move-object v0, p0

    move-object v5, v9

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 282
    iget-object v0, v8, Lcom/mrkeyboard/app/MrBackdrop$Grad;->glow:[I

    if-eqz v0, :cond_0

    .line 284
    iget-object v0, v8, Lcom/mrkeyboard/app/MrBackdrop$Grad;->glow:[I

    const/4 v1, 0x0

    aget v0, v0, v1

    mul-int/2addr v0, p2

    int-to-float v0, v0

    const/high16 v1, 0x42c80000    # 100.0f

    div-float v1, v0, v1

    iget-object v0, v8, Lcom/mrkeyboard/app/MrBackdrop$Grad;->glow:[I

    const/4 v2, 0x1

    aget v0, v0, v2

    mul-int/2addr v0, p3

    int-to-float v0, v0

    const/high16 v2, 0x42c80000    # 100.0f

    div-float v2, v0, v2

    const/high16 v0, 0x3f800000    # 1.0f

    iget-object v3, v8, Lcom/mrkeyboard/app/MrBackdrop$Grad;->glow:[I

    const/4 v4, 0x2

    aget v3, v3, v4

    mul-int/2addr v3, p2

    int-to-float v3, v3

    const/high16 v4, 0x42c80000    # 100.0f

    div-float/2addr v3, v4

    invoke-static {v0, v3}, Ljava/lang/Math;->max(FF)F

    move-result v3

    .line 285
    iget-object v0, v8, Lcom/mrkeyboard/app/MrBackdrop$Grad;->glow:[I

    const/4 v4, 0x3

    aget v5, v0, v4

    .line 286
    new-instance v0, Landroid/graphics/RadialGradient;

    const/4 v4, 0x2

    new-array v4, v4, [I

    const/4 v6, 0x0

    aput v5, v4, v6

    const/4 v6, 0x1

    const v7, 0xffffff

    and-int/2addr v5, v7

    aput v5, v4, v6

    const/4 v5, 0x2

    new-array v5, v5, [F

    fill-array-data v5, :array_0

    sget-object v6, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct/range {v0 .. v6}, Landroid/graphics/RadialGradient;-><init>(FFF[I[FLandroid/graphics/Shader$TileMode;)V

    invoke-virtual {v9, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 287
    const/4 v1, 0x0

    const/4 v2, 0x0

    int-to-float v3, p2

    int-to-float v4, p3

    move-object v0, p0

    move-object v5, v9

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 289
    :cond_0
    return-void

    .line 286
    :array_0
    .array-data 4
        0x0
        0x3f800000    # 1.0f
    .end array-data
.end method

.method private static has(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 2

    .prologue
    .line 650
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->isFile()Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 652
    :goto_0
    return v0

    .line 651
    :catch_0
    move-exception v0

    .line 652
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static hasImage(Landroid/content/Context;)Z
    .locals 1

    .prologue
    .line 641
    const-string v0, "kbd_bg.jpg"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrBackdrop;->has(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method static hasPending(Landroid/content/Context;)Z
    .locals 1

    .prologue
    .line 645
    const-string v0, "kbd_bg_new.jpg"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrBackdrop;->has(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method static hasStyles(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z
    .locals 1

    .prologue
    .line 518
    if-eqz p0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static imageStamp(Landroid/content/Context;)J
    .locals 2

    .prologue
    .line 658
    const-string v0, "kbd_bg.jpg"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrBackdrop;->stamp(Landroid/content/Context;Ljava/lang/String;)J

    move-result-wide v0

    return-wide v0
.end method

.method static importPending(Landroid/content/Context;Ljava/io/InputStream;)[I
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 728
    .line 730
    :try_start_0
    new-instance v3, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "kbd_bg_in"

    invoke-direct {v3, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_7
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 731
    :try_start_1
    invoke-static {p1, v3}, Lcom/mrkeyboard/app/MrBackdrop;->copy(Ljava/io/InputStream;Ljava/io/File;)V

    .line 732
    new-instance v1, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v1}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 733
    const/4 v2, 0x1

    iput-boolean v2, v1, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 734
    invoke-virtual {v3}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    .line 735
    iget v2, v1, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    if-lez v2, :cond_0

    iget v2, v1, Landroid/graphics/BitmapFactory$Options;->outHeight:I
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_8
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_5
    .catch Ljava/lang/OutOfMemoryError; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    if-gtz v2, :cond_3

    .line 761
    :cond_0
    if-eqz v3, :cond_1

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 762
    :cond_1
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 759
    :cond_2
    :goto_0
    return-object v0

    .line 736
    :cond_3
    :try_start_2
    new-instance v2, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v2}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 737
    iget v4, v1, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    iget v1, v1, Landroid/graphics/BitmapFactory$Options;->outHeight:I

    invoke-static {v4, v1}, Lcom/mrkeyboard/app/MrBackdrop;->sampleSize(II)I

    move-result v1

    iput v1, v2, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 738
    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v1, v2, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 739
    invoke-virtual {v3}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v2}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_8
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_5
    .catch Ljava/lang/OutOfMemoryError; {:try_start_2 .. :try_end_2} :catch_3
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    move-result-object v1

    .line 740
    if-nez v1, :cond_5

    .line 761
    if-eqz v3, :cond_4

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 762
    :cond_4
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    goto :goto_0

    .line 741
    :cond_5
    :try_start_3
    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->fit(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 742
    invoke-static {v3}, Lcom/mrkeyboard/app/MrBackdrop;->orientation(Ljava/io/File;)I

    move-result v2

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrBackdrop;->turn(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;

    move-result-object v4

    .line 743
    new-instance v2, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v5, "kbd_bg_new.jpg.tmp"

    invoke-direct {v2, v1, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_8
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_5
    .catch Ljava/lang/OutOfMemoryError; {:try_start_3 .. :try_end_3} :catch_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 744
    :try_start_4
    new-instance v5, Ljava/io/FileOutputStream;

    invoke-direct {v5, v2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_6
    .catch Ljava/lang/OutOfMemoryError; {:try_start_4 .. :try_end_4} :catch_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    .line 747
    :try_start_5
    sget-object v1, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v6, 0x5a

    invoke-virtual {v4, v1, v6, v5}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move-result v1

    .line 749
    :try_start_6
    invoke-virtual {v5}, Ljava/io/OutputStream;->close()V

    .line 752
    if-eqz v1, :cond_6

    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v5

    const-string v6, "kbd_bg_new.jpg"

    invoke-direct {v1, v5, v6}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/io/File;->renameTo(Ljava/io/File;)Z
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_6 .. :try_end_6} :catch_6
    .catch Ljava/lang/OutOfMemoryError; {:try_start_6 .. :try_end_6} :catch_4
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    move-result v1

    if-nez v1, :cond_9

    .line 761
    :cond_6
    if-eqz v3, :cond_7

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_7

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 762
    :cond_7
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    goto/16 :goto_0

    .line 749
    :catchall_0
    move-exception v1

    :try_start_7
    invoke-virtual {v5}, Ljava/io/OutputStream;->close()V

    .line 750
    throw v1
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_7 .. :try_end_7} :catch_6
    .catch Ljava/lang/OutOfMemoryError; {:try_start_7 .. :try_end_7} :catch_4
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    .line 754
    :catch_0
    move-exception v1

    move-object v1, v2

    move-object v2, v3

    .line 761
    :goto_1
    if-eqz v2, :cond_8

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_8

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    .line 762
    :cond_8
    if-eqz v1, :cond_2

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    goto/16 :goto_0

    .line 753
    :cond_9
    const/4 v1, 0x2

    :try_start_8
    new-array v1, v1, [I

    const/4 v5, 0x0

    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v6

    aput v6, v1, v5

    const/4 v5, 0x1

    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    aput v4, v1, v5
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_8 .. :try_end_8} :catch_6
    .catch Ljava/lang/OutOfMemoryError; {:try_start_8 .. :try_end_8} :catch_4
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    .line 761
    if-eqz v3, :cond_a

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_a

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 762
    :cond_a
    if-eqz v2, :cond_b

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_b

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    :cond_b
    move-object v0, v1

    .line 753
    goto/16 :goto_0

    .line 756
    :catch_1
    move-exception v1

    move-object v2, v0

    move-object v3, v0

    .line 761
    :goto_2
    if-eqz v3, :cond_c

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_c

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 762
    :cond_c
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    goto/16 :goto_0

    .line 758
    :catch_2
    move-exception v1

    move-object v2, v0

    move-object v3, v0

    .line 761
    :goto_3
    if-eqz v3, :cond_d

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_d

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 762
    :cond_d
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    goto/16 :goto_0

    .line 761
    :catchall_1
    move-exception v1

    move-object v2, v0

    move-object v3, v0

    move-object v0, v1

    :goto_4
    if-eqz v3, :cond_e

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_e

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 762
    :cond_e
    if-eqz v2, :cond_f

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_f

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    .line 763
    :cond_f
    throw v0

    .line 761
    :catchall_2
    move-exception v1

    move-object v2, v0

    move-object v0, v1

    goto :goto_4

    :catchall_3
    move-exception v0

    goto :goto_4

    .line 758
    :catch_3
    move-exception v1

    move-object v2, v0

    goto :goto_3

    :catch_4
    move-exception v1

    goto :goto_3

    .line 756
    :catch_5
    move-exception v1

    move-object v2, v0

    goto :goto_2

    :catch_6
    move-exception v1

    goto :goto_2

    .line 754
    :catch_7
    move-exception v1

    move-object v1, v0

    move-object v2, v0

    goto/16 :goto_1

    :catch_8
    move-exception v1

    move-object v1, v0

    move-object v2, v3

    goto/16 :goto_1
.end method

.method static isOwn(Ljava/lang/String;)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 589
    if-nez p0, :cond_1

    .line 593
    :cond_0
    :goto_0
    return v0

    :cond_1
    move v1, v0

    .line 590
    :goto_1
    const/4 v2, 0x3

    if-ge v1, v2, :cond_0

    .line 591
    sget-object v2, Lcom/mrkeyboard/app/MrBackdrop;->DARK_OWN_TAGS:[Ljava/lang/String;

    aget-object v2, v2, v1

    invoke-virtual {v2, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    sget-object v2, Lcom/mrkeyboard/app/MrBackdrop;->STYLE_TAGS:[Ljava/lang/String;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->ownStyle(I)I

    move-result v3

    aget-object v2, v2, v3

    invoke-virtual {v2, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    :cond_2
    const/4 v0, 0x1

    goto :goto_0

    .line 590
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_1
.end method

.method static isOwnStyle(I)Z
    .locals 1

    .prologue
    .line 584
    const/16 v0, 0xf

    if-lt p0, v0, :cond_0

    sget v0, Lcom/mrkeyboard/app/MrBackdrop;->STYLES:I

    if-ge p0, v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static kindOf(I)I
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 569
    sget v0, Lcom/mrkeyboard/app/MrBackdrop;->STYLES:I

    add-int/lit8 v0, v0, -0x1

    invoke-static {p0, v1, v0}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v2

    .line 570
    const/16 v0, 0xf

    if-lt v2, v0, :cond_1

    add-int/lit8 v0, v2, -0xf

    .line 574
    :cond_0
    :goto_0
    return v0

    .line 571
    :cond_1
    const/4 v0, 0x2

    :goto_1
    if-lez v0, :cond_2

    .line 572
    sget-object v3, Lcom/mrkeyboard/app/MrBackdrop;->KIND_FIRST:[I

    aget v3, v3, v0

    if-ge v2, v3, :cond_0

    .line 571
    add-int/lit8 v0, v0, -0x1

    goto :goto_1

    :cond_2
    move v0, v1

    .line 574
    goto :goto_0
.end method

.method private static linear(I)F
    .locals 8

    .prologue
    .line 482
    shr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->channel(I)D

    move-result-wide v0

    shr-int/lit8 v2, p0, 0x8

    and-int/lit16 v2, v2, 0xff

    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->channel(I)D

    move-result-wide v2

    and-int/lit16 v4, p0, 0xff

    invoke-static {v4}, Lcom/mrkeyboard/app/MrBackdrop;->channel(I)D

    move-result-wide v4

    .line 483
    const-wide v6, 0x3fcb367a0f9096bcL    # 0.2126

    mul-double/2addr v0, v6

    const-wide v6, 0x3fe6e2eb1c432ca5L    # 0.7152

    mul-double/2addr v2, v6

    add-double/2addr v0, v2

    const-wide v2, 0x3fb27bb2fec56d5dL    # 0.0722

    mul-double/2addr v2, v4

    add-double/2addr v0, v2

    double-to-float v0, v0

    return v0
.end method

.method static load(Landroid/content/Context;)Landroid/graphics/Bitmap;
    .locals 1

    .prologue
    .line 620
    const-string v0, "kbd_bg.jpg"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrBackdrop;->decode(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    return-object v0
.end method

.method static loadPending(Landroid/content/Context;)Landroid/graphics/Bitmap;
    .locals 1

    .prologue
    .line 625
    const-string v0, "kbd_bg_new.jpg"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrBackdrop;->decode(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    return-object v0
.end method

.method static look(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;ZI)Lcom/mrkeyboard/app/MrBackdrop$Look;
    .locals 17

    .prologue
    .line 437
    if-eqz p0, :cond_0

    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-nez v2, :cond_1

    :cond_0
    const/4 v2, 0x0

    .line 469
    :goto_0
    return-object v2

    .line 438
    :cond_1
    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/MrBackdrop;->needsBitmap(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z

    move-result v2

    if-eqz v2, :cond_2

    if-nez p1, :cond_2

    const/4 v2, 0x0

    goto :goto_0

    .line 439
    :cond_2
    if-eqz p2, :cond_3

    const/high16 v6, -0x1000000

    .line 440
    :goto_1
    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v3, 0x4

    if-ne v2, v3, :cond_4

    .line 442
    sget-object v2, Lcom/mrkeyboard/app/MrBackdrop;->COLORS:[I

    move-object/from16 v0, p0

    iget v3, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    aget v2, v2, v3

    invoke-static {v2}, Lcom/mrkeyboard/app/MrThemeColors;->luminance(I)F

    move-result v3

    .line 443
    new-instance v2, Lcom/mrkeyboard/app/MrBackdrop$Look;

    const/4 v5, 0x0

    sget-object v4, Lcom/mrkeyboard/app/MrBackdrop;->COLORS:[I

    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    aget v7, v4, v7

    move v4, v3

    invoke-direct/range {v2 .. v7}, Lcom/mrkeyboard/app/MrBackdrop$Look;-><init>(FFIII)V

    goto :goto_0

    .line 439
    :cond_3
    const/4 v6, -0x1

    goto :goto_1

    .line 445
    :cond_4
    const/4 v2, 0x1

    const/high16 v3, 0x41c00000    # 24.0f

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v10

    .line 446
    const/16 v2, 0x30

    sget-object v3, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v2, v10, v3}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v11

    .line 447
    new-instance v2, Landroid/graphics/Canvas;

    invoke-direct {v2, v11}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    const/16 v3, 0x30

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-static {v2, v0, v3, v10, v1}, Lcom/mrkeyboard/app/MrBackdrop;->draw(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/MrBackdrop$Spec;IILandroid/graphics/Bitmap;)V

    .line 449
    const/4 v2, 0x1

    int-to-float v3, v10

    const v4, 0x3e2e147b    # 0.17f

    mul-float/2addr v3, v4

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    invoke-static {v10, v3}, Ljava/lang/Math;->min(II)I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v12

    .line 450
    const-wide/16 v8, 0x0

    const-wide/16 v4, 0x0

    .line 451
    const/4 v2, 0x0

    move v7, v2

    :goto_2
    if-ge v7, v10, :cond_7

    .line 452
    const/4 v2, 0x0

    move/from16 v16, v2

    move-wide v2, v4

    move/from16 v4, v16

    :goto_3
    const/16 v5, 0x30

    if-ge v4, v5, :cond_6

    .line 453
    invoke-virtual {v11, v4, v7}, Landroid/graphics/Bitmap;->getPixel(II)I

    move-result v5

    invoke-static {v5}, Lcom/mrkeyboard/app/MrThemeColors;->luminance(I)F

    move-result v5

    .line 454
    float-to-double v14, v5

    add-double/2addr v8, v14

    .line 455
    if-ge v7, v12, :cond_5

    float-to-double v14, v5

    add-double/2addr v2, v14

    .line 452
    :cond_5
    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    .line 451
    :cond_6
    add-int/lit8 v4, v7, 0x1

    move v7, v4

    move-wide v4, v2

    goto :goto_2

    .line 458
    :cond_7
    mul-int/lit8 v2, v10, 0x30

    int-to-double v2, v2

    div-double v2, v8, v2

    double-to-float v3, v2

    .line 459
    mul-int/lit8 v2, v12, 0x30

    int-to-double v8, v2

    div-double/2addr v4, v8

    double-to-float v4, v4

    .line 460
    move/from16 v0, p2

    move/from16 v1, p3

    invoke-static {v0, v3, v1}, Lcom/mrkeyboard/app/MrBackdrop;->veil(ZFI)F

    move-result v2

    move/from16 v0, p2

    move/from16 v1, p3

    invoke-static {v0, v4, v1}, Lcom/mrkeyboard/app/MrBackdrop;->veil(ZFI)F

    move-result v5

    invoke-static {v2, v5}, Ljava/lang/Math;->max(FF)F

    move-result v9

    .line 461
    const/4 v8, 0x0

    const/4 v7, 0x0

    const/4 v5, 0x0

    .line 462
    const/4 v2, 0x0

    :goto_4
    const/16 v12, 0x30

    if-ge v2, v12, :cond_8

    .line 463
    add-int/lit8 v12, v10, -0x1

    invoke-virtual {v11, v2, v12}, Landroid/graphics/Bitmap;->getPixel(II)I

    move-result v12

    .line 464
    shr-int/lit8 v13, v12, 0x10

    and-int/lit16 v13, v13, 0xff

    add-int/2addr v8, v13

    .line 465
    shr-int/lit8 v13, v12, 0x8

    and-int/lit16 v13, v13, 0xff

    add-int/2addr v7, v13

    .line 466
    and-int/lit16 v12, v12, 0xff

    add-int/2addr v5, v12

    .line 462
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    .line 468
    :cond_8
    const/high16 v2, -0x1000000

    div-int/lit8 v8, v8, 0x30

    shl-int/lit8 v8, v8, 0x10

    or-int/2addr v2, v8

    div-int/lit8 v7, v7, 0x30

    shl-int/lit8 v7, v7, 0x8

    or-int/2addr v2, v7

    div-int/lit8 v5, v5, 0x30

    or-int/2addr v2, v5

    invoke-static {v2, v6, v9}, Lcom/mrkeyboard/app/MrBackdrop;->mix(IIF)I

    move-result v7

    .line 469
    new-instance v2, Lcom/mrkeyboard/app/MrBackdrop$Look;

    const/high16 v5, 0x437f0000    # 255.0f

    mul-float/2addr v5, v9

    invoke-static {v5}, Ljava/lang/Math;->round(F)I

    move-result v5

    invoke-direct/range {v2 .. v7}, Lcom/mrkeyboard/app/MrBackdrop$Look;-><init>(FFIII)V

    goto/16 :goto_0
.end method

.method static declared-synchronized lookNow(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Look;
    .locals 8

    .prologue
    const/4 v0, 0x0

    .line 815
    const-class v1, Lcom/mrkeyboard/app/MrBackdrop;

    monitor-enter v1

    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->tag()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrThemeColors;->hidden(Ljava/lang/String;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v2

    if-nez v2, :cond_1

    .line 828
    :cond_0
    :goto_0
    monitor-exit v1

    return-object v0

    .line 816
    :cond_1
    :try_start_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v2

    .line 817
    iget v3, v2, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eqz v3, :cond_0

    .line 818
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->darkNow(Landroid/content/Context;)Z

    move-result v3

    .line 819
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->soft(Landroid/content/Context;)I

    move-result v4

    .line 820
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->format()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "|"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "|"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 821
    sget-object v6, Lcom/mrkeyboard/app/MrBackdrop;->sLookKey:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->sLook:Lcom/mrkeyboard/app/MrBackdrop$Look;

    goto :goto_0

    .line 822
    :cond_2
    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrBackdrop;->bitmap(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;)Landroid/graphics/Bitmap;

    move-result-object v6

    .line 823
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->needsBitmap(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z

    move-result v7

    if-eqz v7, :cond_3

    if-eqz v6, :cond_0

    .line 824
    :cond_3
    invoke-static {v2, v6, v3, v4}, Lcom/mrkeyboard/app/MrBackdrop;->look(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;ZI)Lcom/mrkeyboard/app/MrBackdrop$Look;

    move-result-object v0

    .line 825
    if-eqz v6, :cond_4

    invoke-virtual {v6}, Landroid/graphics/Bitmap;->recycle()V

    .line 826
    :cond_4
    sput-object v5, Lcom/mrkeyboard/app/MrBackdrop;->sLookKey:Ljava/lang/String;

    .line 827
    sput-object v0, Lcom/mrkeyboard/app/MrBackdrop;->sLook:Lcom/mrkeyboard/app/MrBackdrop$Look;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 815
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static mix(IIF)I
    .locals 4

    .prologue
    const/high16 v3, 0x3f800000    # 1.0f

    .line 429
    shr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    int-to-float v0, v0

    sub-float v1, v3, p2

    mul-float/2addr v0, v1

    shr-int/lit8 v1, p1, 0x10

    and-int/lit16 v1, v1, 0xff

    int-to-float v1, v1

    mul-float/2addr v1, p2

    add-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 430
    shr-int/lit8 v1, p0, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-float v1, v1

    sub-float v2, v3, p2

    mul-float/2addr v1, v2

    shr-int/lit8 v2, p1, 0x8

    and-int/lit16 v2, v2, 0xff

    int-to-float v2, v2

    mul-float/2addr v2, p2

    add-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    .line 431
    and-int/lit16 v2, p0, 0xff

    int-to-float v2, v2

    sub-float/2addr v3, p2

    mul-float/2addr v2, v3

    and-int/lit16 v3, p1, 0xff

    int-to-float v3, v3

    mul-float/2addr v3, p2

    add-float/2addr v2, v3

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    .line 432
    const/high16 v3, -0x1000000

    shl-int/lit8 v0, v0, 0x10

    or-int/2addr v0, v3

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    or-int/2addr v0, v2

    return v0
.end method

.method static needsBitmap(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z
    .locals 2

    .prologue
    .line 377
    if-eqz p0, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-eq v0, v1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static orientation(Ljava/io/File;)I
    .locals 4

    .prologue
    const/4 v0, 0x1

    .line 787
    :try_start_0
    new-instance v1, Landroid/media/ExifInterface;

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/media/ExifInterface;-><init>(Ljava/lang/String;)V

    const-string v2, "Orientation"

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v3}, Landroid/media/ExifInterface;->getAttributeInt(Ljava/lang/String;I)I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 789
    :goto_0
    return v0

    .line 788
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static ownStyle(I)I
    .locals 2

    .prologue
    .line 579
    const/4 v0, 0x0

    const/4 v1, 0x2

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v0

    add-int/lit8 v0, v0, 0xf

    return v0
.end method

.method static pan(IIIIIIIFF)[I
    .locals 8

    .prologue
    .line 331
    invoke-static/range {p0 .. p6}, Lcom/mrkeyboard/app/MrBackdrop;->crop(IIIIIII)Landroid/graphics/Rect;

    move-result-object v0

    .line 332
    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    sub-int v1, p0, v1

    int-to-double v2, v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v1

    sub-int v1, p1, v1

    int-to-double v4, v1

    .line 334
    const-wide/high16 v6, 0x3fe0000000000000L    # 0.5

    cmpl-double v1, v2, v6

    if-lez v1, :cond_0

    if-lez p2, :cond_0

    .line 336
    iget v1, v0, Landroid/graphics/Rect;->left:I

    int-to-float v1, v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v6

    int-to-float v6, v6

    mul-float/2addr v6, p7

    int-to-float v7, p2

    div-float/2addr v6, v7

    sub-float/2addr v1, v6

    float-to-double v6, v1

    .line 337
    div-double v2, v6, v2

    const-wide/high16 v6, 0x4069000000000000L    # 200.0

    mul-double/2addr v2, v6

    const-wide/high16 v6, 0x4059000000000000L    # 100.0

    sub-double/2addr v2, v6

    invoke-static {v2, v3}, Ljava/lang/Math;->round(D)J

    move-result-wide v2

    long-to-int v1, v2

    const/16 v2, -0x64

    const/16 v3, 0x64

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result p5

    .line 339
    :cond_0
    const-wide/high16 v2, 0x3fe0000000000000L    # 0.5

    cmpl-double v1, v4, v2

    if-lez v1, :cond_1

    if-lez p3, :cond_1

    .line 340
    iget v1, v0, Landroid/graphics/Rect;->top:I

    int-to-float v1, v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v0

    int-to-float v0, v0

    mul-float v0, v0, p8

    int-to-float v2, p3

    div-float/2addr v0, v2

    sub-float v0, v1, v0

    float-to-double v0, v0

    .line 341
    div-double/2addr v0, v4

    const-wide/high16 v2, 0x4069000000000000L    # 200.0

    mul-double/2addr v0, v2

    const-wide/high16 v2, 0x4059000000000000L    # 100.0

    sub-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->round(D)J

    move-result-wide v0

    long-to-int v0, v0

    const/16 v1, -0x64

    const/16 v2, 0x64

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result p6

    .line 343
    :cond_1
    const/4 v0, 0x2

    new-array v0, v0, [I

    const/4 v1, 0x0

    aput p5, v0, v1

    const/4 v1, 0x1

    aput p6, v0, v1

    return-object v0
.end method

.method static pendingStamp(Landroid/content/Context;)J
    .locals 2

    .prologue
    .line 663
    const-string v0, "kbd_bg_new.jpg"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrBackdrop;->stamp(Landroid/content/Context;Ljava/lang/String;)J

    move-result-wide v0

    return-wide v0
.end method

.method private static picture(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;II)V
    .locals 9

    .prologue
    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 292
    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    iget v4, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->zoom:I

    iget v5, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dx:I

    iget v6, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dy:I

    move v2, p3

    move v3, p4

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrBackdrop;->crop(IIIIIII)Landroid/graphics/Rect;

    move-result-object v0

    .line 293
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v8}, Landroid/graphics/Paint;-><init>(I)V

    .line 294
    invoke-virtual {v1, v8}, Landroid/graphics/Paint;->setFilterBitmap(Z)V

    .line 295
    new-instance v2, Landroid/graphics/Rect;

    invoke-direct {v2, v7, v7, p3, p4}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-virtual {p0, p2, v0, v2, v1}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    .line 296
    return-void
.end method

.method private static prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 1

    .prologue
    .line 244
    if-nez p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    goto :goto_0
.end method

.method static presetColour(IZ)I
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 602
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->STYLE_COLORS:[[I

    const/16 v1, 0xe

    invoke-static {p0, v2, v1}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v1

    aget-object v0, v0, v1

    aget v0, v0, v2

    .line 603
    if-eqz p1, :cond_0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrThemeColors;->luminance(I)F

    move-result v1

    const v2, 0x3f59999a    # 0.85f

    cmpl-float v1, v1, v2

    if-lez v1, :cond_0

    const v0, -0xc3b5a2    # -2.50281E38f

    :cond_0
    return v0
.end method

.method static presetEnd(IZ)I
    .locals 3

    .prologue
    .line 608
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->STYLE_COLORS:[[I

    const/4 v1, 0x0

    const/16 v2, 0xe

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v1

    aget-object v0, v0, v1

    .line 609
    array-length v1, v0

    const/4 v2, 0x1

    if-le v1, v2, :cond_0

    array-length v1, v0

    add-int/lit8 v1, v1, -0x1

    aget v0, v0, v1

    :goto_0
    return v0

    :cond_0
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrBackdrop;->presetColour(IZ)I

    move-result v0

    goto :goto_0
.end method

.method static removeImage(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 676
    const-string v0, "kbd_bg.jpg"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrBackdrop;->delete(Landroid/content/Context;Ljava/lang/String;)V

    .line 677
    return-void
.end method

.method static rezoom(IIIIIIII)[I
    .locals 14

    .prologue
    .line 365
    invoke-static/range {p0 .. p6}, Lcom/mrkeyboard/app/MrBackdrop;->crop(IIIIIII)Landroid/graphics/Rect;

    move-result-object v0

    .line 366
    iget v1, v0, Landroid/graphics/Rect;->left:I

    int-to-double v2, v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    int-to-double v4, v1

    const-wide/high16 v6, 0x4000000000000000L    # 2.0

    div-double/2addr v4, v6

    add-double v8, v2, v4

    iget v1, v0, Landroid/graphics/Rect;->top:I

    int-to-double v2, v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v0

    int-to-double v0, v0

    const-wide/high16 v4, 0x4000000000000000L    # 2.0

    div-double/2addr v0, v4

    add-double v10, v2, v0

    .line 367
    const/4 v5, 0x0

    const/4 v6, 0x0

    move v0, p0

    move v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move/from16 v4, p7

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrBackdrop;->crop(IIIIIII)Landroid/graphics/Rect;

    move-result-object v0

    .line 368
    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    sub-int v1, p0, v1

    int-to-double v2, v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v1

    sub-int v1, p1, v1

    int-to-double v4, v1

    .line 370
    const-wide/high16 v6, 0x3fe0000000000000L    # 0.5

    cmpl-double v1, v2, v6

    if-lez v1, :cond_0

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    int-to-double v6, v1

    const-wide/high16 v12, 0x4000000000000000L    # 2.0

    div-double/2addr v6, v12

    sub-double v6, v8, v6

    div-double v2, v6, v2

    const-wide/high16 v6, 0x4069000000000000L    # 200.0

    mul-double/2addr v2, v6

    const-wide/high16 v6, 0x4059000000000000L    # 100.0

    sub-double/2addr v2, v6

    invoke-static {v2, v3}, Ljava/lang/Math;->round(D)J

    move-result-wide v2

    long-to-int v1, v2

    const/16 v2, -0x64

    const/16 v3, 0x64

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result p5

    .line 371
    :cond_0
    const-wide/high16 v2, 0x3fe0000000000000L    # 0.5

    cmpl-double v1, v4, v2

    if-lez v1, :cond_1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v0

    int-to-double v0, v0

    const-wide/high16 v2, 0x4000000000000000L    # 2.0

    div-double/2addr v0, v2

    sub-double v0, v10, v0

    div-double/2addr v0, v4

    const-wide/high16 v2, 0x4069000000000000L    # 200.0

    mul-double/2addr v0, v2

    const-wide/high16 v2, 0x4059000000000000L    # 100.0

    sub-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->round(D)J

    move-result-wide v0

    long-to-int v0, v0

    const/16 v1, -0x64

    const/16 v2, 0x64

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result p6

    .line 372
    :cond_1
    const/4 v0, 0x2

    new-array v0, v0, [I

    const/4 v1, 0x0

    aput p5, v0, v1

    const/4 v1, 0x1

    aput p6, v0, v1

    return-object v0
.end method

.method static sampleSize(II)I
    .locals 4

    .prologue
    .line 705
    invoke-static {p0, p1}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 706
    const/4 v0, 0x1

    .line 707
    :goto_0
    mul-int/lit8 v2, v0, 0x2

    div-int v2, v1, v2

    const/16 v3, 0x500

    if-lt v2, v3, :cond_0

    mul-int/lit8 v0, v0, 0x2

    goto :goto_0

    .line 708
    :cond_0
    return v0
.end method

.method static shift(IIIIIIIFF)[I
    .locals 8

    .prologue
    .line 352
    invoke-static/range {p0 .. p6}, Lcom/mrkeyboard/app/MrBackdrop;->crop(IIIIIII)Landroid/graphics/Rect;

    move-result-object v0

    .line 353
    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    sub-int v1, p0, v1

    int-to-double v2, v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v1

    sub-int v1, p1, v1

    int-to-double v4, v1

    .line 355
    const-wide/high16 v6, 0x3fe0000000000000L    # 0.5

    cmpl-double v1, v2, v6

    if-lez v1, :cond_0

    iget v1, v0, Landroid/graphics/Rect;->left:I

    int-to-float v1, v1

    add-float/2addr v1, p7

    float-to-double v6, v1

    div-double v2, v6, v2

    const-wide/high16 v6, 0x4069000000000000L    # 200.0

    mul-double/2addr v2, v6

    const-wide/high16 v6, 0x4059000000000000L    # 100.0

    sub-double/2addr v2, v6

    invoke-static {v2, v3}, Ljava/lang/Math;->round(D)J

    move-result-wide v2

    long-to-int v1, v2

    const/16 v2, -0x64

    const/16 v3, 0x64

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result p5

    .line 356
    :cond_0
    const-wide/high16 v2, 0x3fe0000000000000L    # 0.5

    cmpl-double v1, v4, v2

    if-lez v1, :cond_1

    iget v0, v0, Landroid/graphics/Rect;->top:I

    int-to-float v0, v0

    add-float v0, v0, p8

    float-to-double v0, v0

    div-double/2addr v0, v4

    const-wide/high16 v2, 0x4069000000000000L    # 200.0

    mul-double/2addr v0, v2

    const-wide/high16 v2, 0x4059000000000000L    # 100.0

    sub-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->round(D)J

    move-result-wide v0

    long-to-int v0, v0

    const/16 v1, -0x64

    const/16 v2, 0x64

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result p6

    .line 357
    :cond_1
    const/4 v0, 0x2

    new-array v0, v0, [I

    const/4 v1, 0x0

    aput p5, v0, v1

    const/4 v1, 0x1

    aput p6, v0, v1

    return-object v0
.end method

.method static soft(Landroid/content/Context;)I
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 234
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 235
    if-nez v1, :cond_0

    .line 239
    :goto_0
    return v0

    .line 237
    :cond_0
    :try_start_0
    const-string v2, "pref_kbd_bg_soft"

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    const/4 v2, 0x0

    const/16 v3, 0x46

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 238
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static stamp(Landroid/content/Context;Ljava/lang/String;)J
    .locals 4

    .prologue
    const-wide/16 v0, 0x0

    .line 668
    :try_start_0
    new-instance v2, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v3

    invoke-direct {v2, v3, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 669
    invoke-virtual {v2}, Ljava/io/File;->isFile()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v2}, Ljava/io/File;->lastModified()J
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v0

    .line 671
    :cond_0
    :goto_0
    return-wide v0

    .line 670
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method static styleOf(Ljava/lang/String;)I
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 526
    move v0, v1

    :goto_0
    sget v2, Lcom/mrkeyboard/app/MrBackdrop;->STYLES:I

    if-ge v0, v2, :cond_1

    .line 527
    sget-object v2, Lcom/mrkeyboard/app/MrBackdrop;->STYLE_TAGS:[Ljava/lang/String;

    aget-object v2, v2, v0

    invoke-virtual {v2, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 532
    :goto_1
    return v0

    .line 526
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    move v0, v1

    .line 529
    :goto_2
    const/4 v2, 0x3

    if-ge v0, v2, :cond_3

    .line 530
    sget-object v2, Lcom/mrkeyboard/app/MrBackdrop;->DARK_OWN_TAGS:[Ljava/lang/String;

    aget-object v2, v2, v0

    invoke-virtual {v2, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->ownStyle(I)I

    move-result v0

    goto :goto_1

    .line 529
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :cond_3
    move v0, v1

    .line 532
    goto :goto_1
.end method

.method static themeTag(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 502
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrBackdrop;->themeTag(Lcom/mrkeyboard/app/MrBackdrop$Spec;I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static themeTag(Lcom/mrkeyboard/app/MrBackdrop$Spec;I)Ljava/lang/String;
    .locals 2

    .prologue
    .line 511
    const/4 v0, 0x0

    sget v1, Lcom/mrkeyboard/app/MrBackdrop;->STYLES:I

    add-int/lit8 v1, v1, -0x1

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v0

    .line 512
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->darkInk(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z

    move-result v1

    if-eqz v1, :cond_1

    if-nez v0, :cond_0

    const-string v0, "mr_overdark"

    .line 513
    :goto_0
    return-object v0

    .line 512
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrBackdrop;->DARK_OWN_TAGS:[Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v0

    aget-object v0, v1, v0

    goto :goto_0

    .line 513
    :cond_1
    sget-object v1, Lcom/mrkeyboard/app/MrBackdrop;->STYLE_TAGS:[Ljava/lang/String;

    aget-object v0, v1, v0

    goto :goto_0
.end method

.method private static turn(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 794
    invoke-static {p1}, Lcom/mrkeyboard/app/MrBackdrop;->degrees(I)I

    move-result v0

    .line 795
    if-nez v0, :cond_0

    .line 798
    :goto_0
    return-object p0

    .line 796
    :cond_0
    new-instance v5, Landroid/graphics/Matrix;

    invoke-direct {v5}, Landroid/graphics/Matrix;-><init>()V

    .line 797
    int-to-float v0, v0

    invoke-virtual {v5, v0}, Landroid/graphics/Matrix;->postRotate(F)Z

    .line 798
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    const/4 v6, 0x1

    move-object v0, p0

    move v2, v1

    invoke-static/range {v0 .. v6}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object p0

    goto :goto_0
.end method

.method static veil(ZFI)F
    .locals 5

    .prologue
    const/high16 v4, 0x3f800000    # 1.0f

    const v3, 0x3f1eb852    # 0.62f

    const v2, 0x3ecccccd    # 0.4f

    .line 417
    const/4 v0, 0x0

    .line 418
    if-eqz p0, :cond_1

    .line 419
    cmpl-float v1, p1, v2

    if-lez v1, :cond_0

    div-float v0, v2, p1

    sub-float v0, v4, v0

    .line 423
    :cond_0
    :goto_0
    const/high16 v1, 0x3f400000    # 0.75f

    invoke-static {v0, v1}, Ljava/lang/Math;->min(FF)F

    move-result v0

    .line 424
    const/4 v1, 0x0

    const/16 v2, 0x46

    invoke-static {p2, v1, v2}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v1

    int-to-float v1, v1

    const/high16 v2, 0x42c80000    # 100.0f

    div-float/2addr v1, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    return v0

    .line 420
    :cond_1
    cmpg-float v1, p1, v3

    if-gez v1, :cond_0

    .line 421
    sub-float v0, v3, p1

    sub-float v1, v4, p1

    div-float/2addr v0, v1

    goto :goto_0
.end method
