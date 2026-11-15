.class public final Lcom/mrkeyboard/app/MrWordDelete;
.super Ljava/lang/Object;
.source "MrWordDelete.java"


# static fields
.field static final AFTER_DEFAULT:I = 0x3e8

.field static final AFTER_MAX:I = 0xbb8

.field static final AFTER_MIN:I = 0x1f4

.field static final KEYCODE_DELETE:I = -0x5

.field static final LOOKBACK:I = 0x40

.field static final PREF_AFTER:Ljava/lang/String; = "pref_word_delete_after"

.field static final PREF_ON:Ljava/lang/String; = "pref_word_delete"

.field static final STEP_FACTOR:I = 0x4

.field static volatile sAfter:I

.field private static sApp:Landroid/content/Context;

.field private static sDownAt:J

.field static sFakeNow:J

.field private static sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

.field static volatile sOn:Z

.field private static sStep:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 57
    const-wide/16 v0, -0x1

    sput-wide v0, Lcom/mrkeyboard/app/MrWordDelete;->sFakeNow:J

    .line 62
    const/16 v0, 0x3e8

    sput v0, Lcom/mrkeyboard/app/MrWordDelete;->sAfter:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 72
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static after(Ljava/lang/String;)I
    .locals 3

    .prologue
    const/16 v0, 0x3e8

    .line 140
    if-nez p0, :cond_1

    .line 148
    :cond_0
    :goto_0
    return v0

    .line 142
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v1

    .line 143
    cmpl-float v2, v1, v1

    if-nez v2, :cond_0

    .line 144
    const/high16 v2, 0x43fa0000    # 500.0f

    cmpg-float v2, v1, v2

    if-gez v2, :cond_2

    const/16 v0, 0x1f4

    goto :goto_0

    .line 145
    :cond_2
    const v2, 0x453b8000    # 3000.0f

    cmpl-float v2, v1, v2

    if-lez v2, :cond_3

    const/16 v0, 0xbb8

    goto :goto_0

    .line 146
    :cond_3
    invoke-static {v1}, Ljava/lang/Math;->round(F)I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 147
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public static down(Lcom/mrkeyboard/app/Keyboard$Key;)V
    .locals 6

    .prologue
    const-wide/16 v4, 0x0

    const/4 v2, 0x0

    .line 160
    if-eqz p0, :cond_0

    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    array-length v0, v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    const/4 v1, 0x0

    aget v0, v0, v1

    const/4 v1, -0x5

    if-eq v0, v1, :cond_1

    .line 169
    :cond_0
    :goto_0
    return-void

    .line 161
    :cond_1
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sStep:Z

    .line 162
    const-wide/16 v0, 0x0

    sput-wide v0, Lcom/mrkeyboard/app/MrWordDelete;->sDownAt:J

    .line 163
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    if-nez v0, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->init(Landroid/content/Context;)V

    .line 164
    :cond_2
    sget-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->now()J

    move-result-wide v0

    sput-wide v0, Lcom/mrkeyboard/app/MrWordDelete;->sDownAt:J
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 165
    :catch_0
    move-exception v0

    .line 166
    sput-wide v4, Lcom/mrkeyboard/app/MrWordDelete;->sDownAt:J

    .line 167
    sput-boolean v2, Lcom/mrkeyboard/app/MrWordDelete;->sStep:Z

    goto :goto_0
.end method

.method static declared-synchronized init(Landroid/content/Context;)V
    .locals 3

    .prologue
    .line 100
    const-class v1, Lcom/mrkeyboard/app/MrWordDelete;

    monitor-enter v1

    if-nez p0, :cond_0

    .line 118
    :goto_0
    monitor-exit v1

    return-void

    .line 101
    :cond_0
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    if-nez v0, :cond_2

    .line 102
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 103
    if-eqz v0, :cond_1

    move-object p0, v0

    :cond_1
    sput-object p0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    .line 104
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 105
    if-eqz v0, :cond_2

    .line 106
    new-instance v2, Lcom/mrkeyboard/app/MrWordDelete$1;

    invoke-direct {v2}, Lcom/mrkeyboard/app/MrWordDelete$1;-><init>()V

    sput-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .line 111
    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v0, v2}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 114
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->reload()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 115
    :catch_0
    move-exception v0

    .line 116
    const/4 v0, 0x0

    :try_start_1
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 100
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static interval(I)I
    .locals 1

    .prologue
    .line 179
    sget-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sStep:Z

    if-eqz v0, :cond_0

    mul-int/lit8 p0, p0, 0x4

    :cond_0
    return p0
.end method

.method private static isBlank(I)Z
    .locals 1

    .prologue
    .line 227
    invoke-static {p0}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p0}, Ljava/lang/Character;->isWhitespace(I)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p0}, Ljava/lang/Character;->isSpaceChar(I)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static isBreak(I)Z
    .locals 1

    .prologue
    .line 222
    const/16 v0, 0xa

    if-eq p0, v0, :cond_0

    const/16 v0, 0xd

    if-eq p0, v0, :cond_0

    const/16 v0, 0x2028

    if-eq p0, v0, :cond_0

    const/16 v0, 0x2029

    if-ne p0, v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static isJoiner(I)Z
    .locals 1

    .prologue
    .line 235
    const/16 v0, 0x27

    if-eq p0, v0, :cond_0

    const/16 v0, 0x2019

    if-eq p0, v0, :cond_0

    const/16 v0, 0x2d

    if-eq p0, v0, :cond_0

    const/16 v0, 0x2010

    if-ne p0, v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static isMark(I)Z
    .locals 2

    .prologue
    .line 216
    invoke-static {p0}, Ljava/lang/Character;->getType(I)I

    move-result v0

    .line 217
    const/4 v1, 0x6

    if-eq v0, v1, :cond_0

    const/16 v1, 0x8

    if-eq v0, v1, :cond_0

    const/4 v1, 0x7

    if-eq v0, v1, :cond_0

    const/16 v0, 0x200d

    if-ne p0, v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static isWord(I)Z
    .locals 1

    .prologue
    .line 231
    invoke-static {p0}, Ljava/lang/Character;->isLetterOrDigit(I)Z

    move-result v0

    if-nez v0, :cond_0

    const/16 v0, 0x5f

    if-ne p0, v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static now()J
    .locals 4

    .prologue
    .line 75
    sget-wide v0, Lcom/mrkeyboard/app/MrWordDelete;->sFakeNow:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-ltz v0, :cond_0

    sget-wide v0, Lcom/mrkeyboard/app/MrWordDelete;->sFakeNow:J

    :goto_0
    return-wide v0

    :cond_0
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    goto :goto_0
.end method

.method public static onBackspace(Lcom/mrkeyboard/app/LatinIME;)Z
    .locals 8

    .prologue
    const-wide/16 v6, 0x0

    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 187
    sget-wide v2, Lcom/mrkeyboard/app/MrWordDelete;->sDownAt:J

    cmp-long v2, v2, v6

    if-nez v2, :cond_1

    .line 209
    :cond_0
    :goto_0
    return v0

    .line 189
    :cond_1
    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->now()J

    move-result-wide v2

    sget-wide v4, Lcom/mrkeyboard/app/MrWordDelete;->sDownAt:J

    sub-long/2addr v2, v4

    sget v4, Lcom/mrkeyboard/app/MrWordDelete;->sAfter:I

    int-to-long v4, v4

    cmp-long v2, v2, v4

    if-ltz v2, :cond_0

    .line 190
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrComposingLength()I

    move-result v2

    if-gtz v2, :cond_0

    .line 191
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v2

    .line 192
    if-eqz v2, :cond_0

    .line 194
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 196
    const/4 v3, 0x0

    :try_start_1
    invoke-interface {v2, v3}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;

    move-result-object v3

    .line 197
    if-eqz v3, :cond_2

    invoke-interface {v3}, Ljava/lang/CharSequence;->length()I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v3

    if-lez v3, :cond_2

    .line 201
    :try_start_2
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 206
    :catch_0
    move-exception v1

    .line 207
    sput-wide v6, Lcom/mrkeyboard/app/MrWordDelete;->sDownAt:J

    .line 208
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sStep:Z

    goto :goto_0

    .line 198
    :cond_2
    const/16 v3, 0x40

    const/4 v4, 0x0

    :try_start_3
    invoke-interface {v2, v3, v4}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrWordDelete;->wordLength(Ljava/lang/CharSequence;)I

    move-result v3

    .line 199
    if-lez v3, :cond_3

    const/4 v4, 0x0

    invoke-interface {v2, v3, v4}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 201
    :cond_3
    :try_start_4
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 203
    if-lez v3, :cond_0

    .line 204
    const/4 v2, 0x1

    sput-boolean v2, Lcom/mrkeyboard/app/MrWordDelete;->sStep:Z

    move v0, v1

    .line 205
    goto :goto_0

    .line 201
    :catchall_0
    move-exception v1

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 202
    throw v1
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0
.end method

.method static declared-synchronized reload()V
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 122
    const-class v1, Lcom/mrkeyboard/app/MrWordDelete;

    monitor-enter v1

    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v2, :cond_1

    .line 133
    :cond_0
    :goto_0
    monitor-exit v1

    return-void

    .line 123
    :cond_1
    :try_start_1
    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    invoke-static {v2}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 124
    if-eqz v2, :cond_2

    const-string v3, "pref_word_delete"

    const/4 v4, 0x0

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v3

    if-eqz v3, :cond_2

    const/4 v0, 0x1

    :cond_2
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    .line 125
    if-nez v2, :cond_3

    const/16 v0, 0x3e8

    :goto_1
    sput v0, Lcom/mrkeyboard/app/MrWordDelete;->sAfter:I

    .line 126
    sget-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    if-nez v0, :cond_0

    .line 127
    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/mrkeyboard/app/MrWordDelete;->sDownAt:J

    .line 128
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sStep:Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 130
    :catch_0
    move-exception v0

    .line 131
    const/4 v0, 0x0

    :try_start_2
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 122
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0

    .line 125
    :cond_3
    :try_start_3
    const-string v0, "pref_word_delete_after"

    const/4 v3, 0x0

    invoke-interface {v2, v0, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->after(Ljava/lang/String;)I
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result v0

    goto :goto_1
.end method

.method static declared-synchronized resetForTest()V
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 83
    const-class v1, Lcom/mrkeyboard/app/MrWordDelete;

    monitor-enter v1

    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    if-nez v2, :cond_1

    .line 84
    :goto_0
    if-eqz v0, :cond_0

    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v0, v2}, Landroid/content/SharedPreferences;->unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 88
    :cond_0
    :goto_1
    const/4 v0, 0x0

    :try_start_1
    sput-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    .line 89
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .line 90
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    .line 91
    const/16 v0, 0x3e8

    sput v0, Lcom/mrkeyboard/app/MrWordDelete;->sAfter:I

    .line 92
    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/mrkeyboard/app/MrWordDelete;->sDownAt:J

    .line 93
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sStep:Z

    .line 94
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrWordDelete;->sFakeNow:J
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 95
    monitor-exit v1

    return-void

    .line 83
    :cond_1
    :try_start_2
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0

    .line 85
    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method public static up()V
    .locals 2

    .prologue
    .line 173
    const-wide/16 v0, 0x0

    sput-wide v0, Lcom/mrkeyboard/app/MrWordDelete;->sDownAt:J

    .line 174
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sStep:Z

    .line 175
    return-void
.end method

.method static wordLength(Ljava/lang/CharSequence;)I
    .locals 9

    .prologue
    const/4 v0, 0x2

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 243
    if-nez p0, :cond_1

    .line 284
    :cond_0
    :goto_0
    return v2

    .line 244
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v3

    .line 245
    if-eqz v3, :cond_0

    .line 247
    invoke-static {p0, v3}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v4

    .line 248
    invoke-static {v4}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v5

    if-eqz v5, :cond_e

    .line 249
    const/16 v1, 0xa

    if-ne v4, v1, :cond_2

    if-lt v3, v0, :cond_2

    add-int/lit8 v1, v3, -0x2

    invoke-interface {p0, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    const/16 v2, 0xd

    if-ne v1, v2, :cond_2

    move v2, v0

    goto :goto_0

    .line 250
    :cond_2
    invoke-static {v4}, Ljava/lang/Character;->charCount(I)I

    move-result v2

    goto :goto_0

    .line 255
    :cond_3
    invoke-static {v0}, Ljava/lang/Character;->charCount(I)I

    move-result v0

    sub-int/2addr v5, v0

    .line 252
    :goto_1
    if-lez v5, :cond_4

    .line 253
    invoke-static {p0, v5}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v0

    .line 254
    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->isBlank(I)Z

    move-result v4

    if-nez v4, :cond_3

    .line 257
    :cond_4
    if-nez v5, :cond_5

    move v2, v3

    goto :goto_0

    .line 258
    :cond_5
    invoke-static {p0, v5}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v0

    if-eqz v0, :cond_6

    sub-int v2, v3, v5

    goto :goto_0

    .line 260
    :cond_6
    const/4 v0, -0x1

    move v4, v5

    .line 261
    :goto_2
    if-lez v4, :cond_8

    .line 262
    invoke-static {p0, v4}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v6

    .line 263
    invoke-static {v6}, Ljava/lang/Character;->charCount(I)I

    move-result v7

    .line 264
    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isMark(I)Z

    move-result v8

    if-eqz v8, :cond_7

    .line 265
    sub-int/2addr v4, v7

    .line 266
    goto :goto_2

    .line 268
    :cond_7
    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isBlank(I)Z

    move-result v8

    if-nez v8, :cond_8

    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v8

    if-eqz v8, :cond_9

    .line 284
    :cond_8
    :goto_3
    sub-int v2, v3, v4

    goto :goto_0

    .line 269
    :cond_9
    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isWord(I)Z

    move-result v8

    .line 270
    if-gez v0, :cond_c

    .line 271
    if-eqz v8, :cond_b

    move v0, v1

    .line 282
    :cond_a
    :goto_4
    sub-int/2addr v4, v7

    .line 283
    goto :goto_2

    :cond_b
    move v0, v2

    .line 271
    goto :goto_4

    .line 272
    :cond_c
    if-ne v0, v1, :cond_d

    if-nez v8, :cond_d

    .line 274
    if-ge v4, v5, :cond_8

    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isJoiner(I)Z

    move-result v6

    if-eqz v6, :cond_8

    sub-int v6, v4, v7

    if-lez v6, :cond_8

    sub-int v6, v4, v7

    invoke-static {p0, v6}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v6

    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isWord(I)Z

    move-result v6

    if-eqz v6, :cond_8

    .line 275
    sub-int/2addr v4, v7

    .line 276
    goto :goto_2

    .line 279
    :cond_d
    if-nez v0, :cond_a

    if-eqz v8, :cond_a

    goto :goto_3

    :cond_e
    move v5, v3

    goto :goto_1
.end method
