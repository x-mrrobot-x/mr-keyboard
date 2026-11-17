.class final Lcom/mrkeyboard/app/MrKeySound;
.super Ljava/lang/Object;
.source "MrKeySound.java"


# static fields
.field static final DEFAULT:Ljava/lang/String; = "default"

.field private static final FAILED:I = 0x2

.field static final FX_DELETE:I = 0x7

.field static final FX_RETURN:I = 0x8

.field static final FX_SPACEBAR:I = 0x6

.field static final FX_STANDARD:I = 0x5

.field static final KEY:Ljava/lang/String; = "pref_sound_style"

.field private static final LOADING:I = 0x0

.field private static final READY:I = 0x1

.field private static final STREAMS:I = 0x4

.field static final STYLES:[Ljava/lang/String;

.field static final VOLUME_DEFAULT:F = 0.8f

.field static final VOLUME_KEY:Ljava/lang/String; = "pref_click_volume"

.field private static sPending:F

.field private static sPool:Landroid/media/SoundPool;

.field private static sSample:I

.field private static sState:I

.field private static sStyle:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x2

    .line 32
    const/16 v0, 0xd

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "bubble"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "bubble2"

    aput-object v2, v0, v1

    const-string v1, "bell"

    aput-object v1, v0, v3

    const/4 v1, 0x3

    const-string v2, "duck"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "keyboard"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "fox"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "pistol"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "wand"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "frog"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "cat"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "drop"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "rocket"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "mouse"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrKeySound;->STYLES:[Ljava/lang/String;

    .line 48
    sput v3, Lcom/mrkeyboard/app/MrKeySound;->sState:I

    .line 50
    const/high16 v0, -0x40800000    # -1.0f

    sput v0, Lcom/mrkeyboard/app/MrKeySound;->sPending:F

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 52
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()I
    .locals 1

    .prologue
    .line 25
    sget v0, Lcom/mrkeyboard/app/MrKeySound;->sSample:I

    return v0
.end method

.method static synthetic access$100()I
    .locals 1

    .prologue
    .line 25
    sget v0, Lcom/mrkeyboard/app/MrKeySound;->sState:I

    return v0
.end method

.method static synthetic access$102(I)I
    .locals 0

    .prologue
    .line 25
    sput p0, Lcom/mrkeyboard/app/MrKeySound;->sState:I

    return p0
.end method

.method static synthetic access$200()F
    .locals 1

    .prologue
    .line 25
    sget v0, Lcom/mrkeyboard/app/MrKeySound;->sPending:F

    return v0
.end method

.method static synthetic access$202(F)F
    .locals 0

    .prologue
    .line 25
    sput p0, Lcom/mrkeyboard/app/MrKeySound;->sPending:F

    return p0
.end method

.method private static declared-synchronized ensure(Landroid/content/Context;Ljava/lang/String;)I
    .locals 7

    .prologue
    const/4 v0, 0x2

    const/4 v1, 0x0

    .line 157
    const-class v3, Lcom/mrkeyboard/app/MrKeySound;

    monitor-enter v3

    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrKeySound;->sPool:Landroid/media/SoundPool;

    if-nez v2, :cond_0

    .line 158
    new-instance v2, Landroid/media/SoundPool$Builder;

    invoke-direct {v2}, Landroid/media/SoundPool$Builder;-><init>()V

    const/4 v4, 0x4

    invoke-virtual {v2, v4}, Landroid/media/SoundPool$Builder;->setMaxStreams(I)Landroid/media/SoundPool$Builder;

    move-result-object v2

    new-instance v4, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v4}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/16 v5, 0xd

    .line 159
    invoke-virtual {v4, v5}, Landroid/media/AudioAttributes$Builder;->setUsage(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v4

    const/4 v5, 0x4

    .line 160
    invoke-virtual {v4, v5}, Landroid/media/AudioAttributes$Builder;->setContentType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v4

    invoke-virtual {v4}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v4

    .line 159
    invoke-virtual {v2, v4}, Landroid/media/SoundPool$Builder;->setAudioAttributes(Landroid/media/AudioAttributes;)Landroid/media/SoundPool$Builder;

    move-result-object v2

    .line 160
    invoke-virtual {v2}, Landroid/media/SoundPool$Builder;->build()Landroid/media/SoundPool;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrKeySound;->sPool:Landroid/media/SoundPool;

    .line 161
    sget-object v2, Lcom/mrkeyboard/app/MrKeySound;->sPool:Landroid/media/SoundPool;

    new-instance v4, Lcom/mrkeyboard/app/MrKeySound$1;

    invoke-direct {v4}, Lcom/mrkeyboard/app/MrKeySound$1;-><init>()V

    invoke-virtual {v2, v4}, Landroid/media/SoundPool;->setOnLoadCompleteListener(Landroid/media/SoundPool$OnLoadCompleteListener;)V

    .line 180
    const/4 v2, 0x0

    sput-object v2, Lcom/mrkeyboard/app/MrKeySound;->sStyle:Ljava/lang/String;

    .line 182
    :cond_0
    sget-object v2, Lcom/mrkeyboard/app/MrKeySound;->sStyle:Ljava/lang/String;

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_3

    .line 183
    sget v2, Lcom/mrkeyboard/app/MrKeySound;->sSample:I

    if-eqz v2, :cond_1

    sget-object v2, Lcom/mrkeyboard/app/MrKeySound;->sPool:Landroid/media/SoundPool;

    sget v4, Lcom/mrkeyboard/app/MrKeySound;->sSample:I

    invoke-virtual {v2, v4}, Landroid/media/SoundPool;->unload(I)Z

    .line 184
    :cond_1
    sput-object p1, Lcom/mrkeyboard/app/MrKeySound;->sStyle:Ljava/lang/String;

    .line 185
    const/4 v2, 0x0

    sput v2, Lcom/mrkeyboard/app/MrKeySound;->sSample:I

    .line 186
    const/4 v2, 0x2

    sput v2, Lcom/mrkeyboard/app/MrKeySound;->sState:I

    .line 187
    const/high16 v2, -0x40800000    # -1.0f

    sput v2, Lcom/mrkeyboard/app/MrKeySound;->sPending:F

    .line 188
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    .line 189
    if-eqz v2, :cond_2

    move-object p0, v2

    .line 190
    :cond_2
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mr_snd_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const-string v5, "raw"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v4, v5, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 191
    if-eqz v2, :cond_3

    .line 192
    sget-object v4, Lcom/mrkeyboard/app/MrKeySound;->sPool:Landroid/media/SoundPool;

    const/4 v5, 0x1

    invoke-virtual {v4, p0, v2, v5}, Landroid/media/SoundPool;->load(Landroid/content/Context;II)I

    move-result v2

    sput v2, Lcom/mrkeyboard/app/MrKeySound;->sSample:I

    .line 193
    sget v2, Lcom/mrkeyboard/app/MrKeySound;->sSample:I

    if-nez v2, :cond_4

    :goto_0
    sput v0, Lcom/mrkeyboard/app/MrKeySound;->sState:I

    .line 196
    :cond_3
    sget v0, Lcom/mrkeyboard/app/MrKeySound;->sState:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v3

    return v0

    :cond_4
    move v0, v1

    .line 193
    goto :goto_0

    .line 157
    :catchall_0
    move-exception v0

    monitor-exit v3

    throw v0
.end method

.method static known(Ljava/lang/String;)Z
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 55
    sget-object v2, Lcom/mrkeyboard/app/MrKeySound;->STYLES:[Ljava/lang/String;

    array-length v3, v2

    move v1, v0

    :goto_0
    if-ge v1, v3, :cond_0

    aget-object v4, v2, v1

    invoke-virtual {v4, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/4 v0, 0x1

    .line 56
    :cond_0
    return v0

    .line 55
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method static play(Landroid/content/Context;I)Z
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 91
    :try_start_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 92
    invoke-static {v1}, Lcom/mrkeyboard/app/MrKeySound;->style(Landroid/content/SharedPreferences;)Ljava/lang/String;

    move-result-object v2

    .line 93
    const-string v3, "default"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 96
    :goto_0
    return v0

    .line 94
    :cond_0
    invoke-static {v1}, Lcom/mrkeyboard/app/MrKeySound;->volume(Landroid/content/SharedPreferences;)F

    move-result v1

    invoke-static {p1}, Lcom/mrkeyboard/app/MrKeySound;->rate(I)F

    move-result v3

    const/4 v4, 0x0

    invoke-static {p0, v2, v1, v3, v4}, Lcom/mrkeyboard/app/MrKeySound;->start(Landroid/content/Context;Ljava/lang/String;FFZ)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 95
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static preload(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 118
    :try_start_0
    invoke-static {p1}, Lcom/mrkeyboard/app/MrKeySound;->known(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrKeySound;->ensure(Landroid/content/Context;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 122
    :cond_0
    :goto_0
    return-void

    .line 119
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static preview(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 103
    :try_start_0
    invoke-static {p1}, Lcom/mrkeyboard/app/MrKeySound;->known(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 104
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 105
    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeySound;->volume(Landroid/content/SharedPreferences;)F

    move-result v0

    const/high16 v1, 0x3f800000    # 1.0f

    const/4 v2, 0x1

    invoke-static {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/MrKeySound;->start(Landroid/content/Context;Ljava/lang/String;FFZ)Z

    .line 113
    :cond_0
    :goto_0
    return-void

    .line 107
    :cond_1
    const-string v0, "audio"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 108
    instance-of v1, v0, Landroid/media/AudioManager;

    if-eqz v1, :cond_0

    check-cast v0, Landroid/media/AudioManager;

    const/4 v1, 0x5

    const/high16 v2, -0x40800000    # -1.0f

    invoke-virtual {v0, v1, v2}, Landroid/media/AudioManager;->playSoundEffect(IF)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 110
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static rate(I)F
    .locals 1

    .prologue
    .line 80
    packed-switch p0, :pswitch_data_0

    .line 84
    const/high16 v0, 0x3f800000    # 1.0f

    :goto_0
    return v0

    .line 81
    :pswitch_0
    const v0, 0x3f59999a    # 0.85f

    goto :goto_0

    .line 82
    :pswitch_1
    const v0, 0x3f6b851f    # 0.92f

    goto :goto_0

    .line 83
    :pswitch_2
    const v0, 0x3f8a3d71    # 1.08f

    goto :goto_0

    .line 80
    :pswitch_data_0
    .packed-switch 0x6
        :pswitch_1
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.method static declared-synchronized release()V
    .locals 2

    .prologue
    .line 126
    const-class v1, Lcom/mrkeyboard/app/MrKeySound;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrKeySound;->sPool:Landroid/media/SoundPool;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    .line 128
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrKeySound;->sPool:Landroid/media/SoundPool;

    invoke-virtual {v0}, Landroid/media/SoundPool;->release()V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 133
    :cond_0
    :goto_0
    const/4 v0, 0x0

    :try_start_2
    sput-object v0, Lcom/mrkeyboard/app/MrKeySound;->sPool:Landroid/media/SoundPool;

    .line 134
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrKeySound;->sStyle:Ljava/lang/String;

    .line 135
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrKeySound;->sSample:I

    .line 136
    const/4 v0, 0x2

    sput v0, Lcom/mrkeyboard/app/MrKeySound;->sState:I

    .line 137
    const/high16 v0, -0x40800000    # -1.0f

    sput v0, Lcom/mrkeyboard/app/MrKeySound;->sPending:F
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 138
    monitor-exit v1

    return-void

    .line 126
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0

    .line 129
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static start(Landroid/content/Context;Ljava/lang/String;FFZ)Z
    .locals 7

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x1

    .line 144
    const-class v2, Lcom/mrkeyboard/app/MrKeySound;

    monitor-enter v2

    .line 145
    :try_start_0
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrKeySound;->ensure(Landroid/content/Context;Ljava/lang/String;)I

    move-result v3

    .line 146
    sget-object v0, Lcom/mrkeyboard/app/MrKeySound;->sPool:Landroid/media/SoundPool;

    .line 147
    sget v1, Lcom/mrkeyboard/app/MrKeySound;->sSample:I

    .line 148
    if-eqz p4, :cond_0

    if-nez v3, :cond_0

    sput p2, Lcom/mrkeyboard/app/MrKeySound;->sPending:F

    .line 149
    :cond_0
    monitor-exit v2

    .line 150
    const/4 v2, 0x2

    if-ne v3, v2, :cond_1

    .line 152
    :goto_0
    return v5

    .line 149
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 151
    :cond_1
    if-ne v3, v4, :cond_2

    move v2, p2

    move v3, p2

    move v6, p3

    invoke-virtual/range {v0 .. v6}, Landroid/media/SoundPool;->play(IFFIIF)I

    :cond_2
    move v5, v4

    .line 152
    goto :goto_0
.end method

.method static style(Landroid/content/SharedPreferences;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 61
    if-nez p0, :cond_0

    const/4 v0, 0x0

    .line 62
    :goto_0
    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeySound;->known(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    :goto_1
    return-object v0

    .line 61
    :cond_0
    const-string v0, "pref_sound_style"

    const-string v1, "default"

    invoke-interface {p0, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 62
    :cond_1
    const-string v0, "default"

    goto :goto_1
.end method

.method static volume(Landroid/content/SharedPreferences;)F
    .locals 4

    .prologue
    const/4 v0, 0x0

    const/high16 v2, 0x3f800000    # 1.0f

    const v1, 0x3f4ccccd    # 0.8f

    .line 67
    .line 69
    if-nez p0, :cond_0

    .line 70
    :goto_0
    if-eqz v0, :cond_3

    :try_start_0
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v0

    .line 74
    :goto_1
    const/4 v3, 0x0

    cmpl-float v3, v0, v3

    if-gez v3, :cond_1

    .line 75
    :goto_2
    return v1

    .line 69
    :cond_0
    const-string v0, "pref_click_volume"

    const/4 v3, 0x0

    invoke-interface {p0, v0, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 71
    :catch_0
    move-exception v0

    move v0, v1

    .line 72
    goto :goto_1

    .line 75
    :cond_1
    cmpl-float v1, v0, v2

    if-lez v1, :cond_2

    move v0, v2

    :cond_2
    move v1, v0

    goto :goto_2

    :cond_3
    move v0, v1

    goto :goto_1
.end method
