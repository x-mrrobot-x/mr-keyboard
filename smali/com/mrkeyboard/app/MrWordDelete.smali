.class public final Lcom/mrkeyboard/app/MrWordDelete;
.super Ljava/lang/Object;
.source "MrWordDelete.java"


# static fields
.field static final COMPOSING_MAX:I = 0x40

.field static final INTERVAL_DEFAULT:I = 0xc8

.field static final INTERVAL_MAX:I = 0x258

.field static final INTERVAL_MIN:I = 0x64

.field static final KEYCODE_DELETE:I = -0x5

.field static final LOOKBACK:I = 0x40

.field static final PREF_INTERVAL:Ljava/lang/String; = "pref_word_delete_interval"

.field static final PREF_ON:Ljava/lang/String; = "pref_word_delete"

.field private static sApp:Landroid/content/Context;

.field private static sBusy:Z

.field private static sHold:Z

.field static volatile sInterval:I

.field private static sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

.field static volatile sOn:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 60
    const/16 v0, 0xc8

    sput v0, Lcom/mrkeyboard/app/MrWordDelete;->sInterval:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 70
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static down(Lcom/mrkeyboard/app/Keyboard$Key;)V
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 151
    if-eqz p0, :cond_0

    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    array-length v0, v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    const/4 v2, 0x0

    aget v0, v0, v2

    const/4 v2, -0x5

    if-eq v0, v2, :cond_1

    .line 160
    :cond_0
    :goto_0
    return-void

    .line 152
    :cond_1
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    .line 153
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    if-nez v0, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->init(Landroid/content/Context;)V

    .line 154
    :cond_2
    sget-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    if-eqz v0, :cond_0

    .line 155
    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    .line 156
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->mrCtrlOn()Z

    move-result v0

    if-eqz v0, :cond_3

    const/4 v0, 0x1

    :goto_1
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 157
    :catch_0
    move-exception v0

    .line 158
    sput-boolean v1, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    goto :goto_0

    :cond_3
    move v0, v1

    .line 156
    goto :goto_1
.end method

.method static declared-synchronized init(Landroid/content/Context;)V
    .locals 3

    .prologue
    .line 93
    const-class v1, Lcom/mrkeyboard/app/MrWordDelete;

    monitor-enter v1

    if-nez p0, :cond_0

    .line 111
    :goto_0
    monitor-exit v1

    return-void

    .line 94
    :cond_0
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    if-nez v0, :cond_2

    .line 95
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 96
    if-eqz v0, :cond_1

    move-object p0, v0

    :cond_1
    sput-object p0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    .line 97
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 98
    if-eqz v0, :cond_2

    .line 99
    new-instance v2, Lcom/mrkeyboard/app/MrWordDelete$1;

    invoke-direct {v2}, Lcom/mrkeyboard/app/MrWordDelete$1;-><init>()V

    sput-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .line 104
    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v0, v2}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 107
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->reload()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 108
    :catch_0
    move-exception v0

    .line 109
    const/4 v0, 0x0

    :try_start_1
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 93
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static interval(I)I
    .locals 1

    .prologue
    .line 169
    sget-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    if-eqz v0, :cond_0

    sget v0, Lcom/mrkeyboard/app/MrWordDelete;->sInterval:I

    invoke-static {p0, v0}, Ljava/lang/Math;->max(II)I

    move-result p0

    :cond_0
    return p0
.end method

.method static interval(Ljava/lang/String;I)I
    .locals 2

    .prologue
    .line 130
    if-nez p0, :cond_1

    .line 138
    :cond_0
    :goto_0
    return p1

    .line 132
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v0

    .line 133
    cmpl-float v1, v0, v0

    if-nez v1, :cond_0

    .line 134
    const/high16 v1, 0x42c80000    # 100.0f

    cmpg-float v1, v0, v1

    if-gez v1, :cond_2

    const/16 p1, 0x64

    goto :goto_0

    .line 135
    :cond_2
    const/high16 v1, 0x44160000    # 600.0f

    cmpl-float v1, v0, v1

    if-lez v1, :cond_3

    const/16 p1, 0x258

    goto :goto_0

    .line 136
    :cond_3
    invoke-static {v0}, Ljava/lang/Math;->round(F)I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result p1

    goto :goto_0

    .line 137
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static isBlank(I)Z
    .locals 1

    .prologue
    .line 232
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
    .line 227
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
    .line 240
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
    .line 221
    invoke-static {p0}, Ljava/lang/Character;->getType(I)I

    move-result v0

    .line 222
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
    .line 236
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

.method public static onBackspace(Lcom/mrkeyboard/app/LatinIME;)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 178
    sget-boolean v1, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    if-eqz v1, :cond_0

    sget-boolean v1, Lcom/mrkeyboard/app/MrWordDelete;->sBusy:Z

    if-eqz v1, :cond_1

    .line 196
    :cond_0
    :goto_0
    return v0

    .line 180
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v1

    .line 181
    if-eqz v1, :cond_0

    .line 182
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrComposingLength()I

    move-result v2

    if-lez v2, :cond_2

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrWordDelete;->takeBackTyped(Lcom/mrkeyboard/app/LatinIME;Landroid/view/inputmethod/InputConnection;)Z

    move-result v0

    goto :goto_0

    .line 184
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 186
    const/4 v2, 0x0

    :try_start_1
    invoke-interface {v1, v2}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;

    move-result-object v2

    .line 187
    if-eqz v2, :cond_3

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v2

    if-lez v2, :cond_3

    .line 191
    :try_start_2
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 194
    :catch_0
    move-exception v1

    .line 195
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    goto :goto_0

    .line 188
    :cond_3
    const/16 v2, 0x40

    const/4 v3, 0x0

    :try_start_3
    invoke-interface {v1, v2, v3}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrWordDelete;->wordLength(Ljava/lang/CharSequence;)I

    move-result v2

    .line 189
    if-lez v2, :cond_4

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 191
    :cond_4
    :try_start_4
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 193
    if-lez v2, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    .line 191
    :catchall_0
    move-exception v1

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 192
    throw v1
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0
.end method

.method static declared-synchronized reload()V
    .locals 6

    .prologue
    const/16 v0, 0xc8

    const/4 v1, 0x0

    .line 115
    const-class v2, Lcom/mrkeyboard/app/MrWordDelete;

    monitor-enter v2

    :try_start_0
    sget-object v3, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v3, :cond_1

    .line 123
    :cond_0
    :goto_0
    monitor-exit v2

    return-void

    .line 116
    :cond_1
    :try_start_1
    sget-object v3, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    invoke-static {v3}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 117
    if-eqz v3, :cond_2

    const-string v4, "pref_word_delete"

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v4

    if-eqz v4, :cond_2

    const/4 v1, 0x1

    :cond_2
    sput-boolean v1, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    .line 118
    if-nez v3, :cond_3

    :goto_1
    sput v0, Lcom/mrkeyboard/app/MrWordDelete;->sInterval:I

    .line 119
    sget-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    if-nez v0, :cond_0

    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 120
    :catch_0
    move-exception v0

    .line 121
    const/4 v0, 0x0

    :try_start_2
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 115
    :catchall_0
    move-exception v0

    monitor-exit v2

    throw v0

    .line 118
    :cond_3
    :try_start_3
    const-string v0, "pref_word_delete_interval"

    const/4 v1, 0x0

    invoke-interface {v3, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0xc8

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrWordDelete;->interval(Ljava/lang/String;I)I
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result v0

    goto :goto_1
.end method

.method static declared-synchronized resetForTest()V
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 77
    const-class v1, Lcom/mrkeyboard/app/MrWordDelete;

    monitor-enter v1

    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    if-nez v2, :cond_1

    .line 78
    :goto_0
    if-eqz v0, :cond_0

    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v0, v2}, Landroid/content/SharedPreferences;->unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 82
    :cond_0
    :goto_1
    const/4 v0, 0x0

    :try_start_1
    sput-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    .line 83
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .line 84
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    .line 85
    const/16 v0, 0xc8

    sput v0, Lcom/mrkeyboard/app/MrWordDelete;->sInterval:I

    .line 86
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    .line 87
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sBusy:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 88
    monitor-exit v1

    return-void

    .line 77
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

    .line 79
    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method private static takeBackTyped(Lcom/mrkeyboard/app/LatinIME;Landroid/view/inputmethod/InputConnection;)Z
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 206
    sput-boolean v3, Lcom/mrkeyboard/app/MrWordDelete;->sBusy:Z

    .line 207
    invoke-interface {p1}, Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z

    .line 209
    const/16 v0, 0x40

    .line 210
    :goto_0
    add-int/lit8 v1, v0, -0x1

    if-lez v0, :cond_0

    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrComposingLength()I

    move-result v0

    if-lez v0, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrBackspace()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move v0, v1

    goto :goto_0

    .line 212
    :cond_0
    sput-boolean v2, Lcom/mrkeyboard/app/MrWordDelete;->sBusy:Z

    .line 213
    invoke-interface {p1}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 215
    return v3

    .line 212
    :catchall_0
    move-exception v0

    sput-boolean v2, Lcom/mrkeyboard/app/MrWordDelete;->sBusy:Z

    .line 213
    invoke-interface {p1}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 214
    throw v0
.end method

.method public static up()V
    .locals 1

    .prologue
    .line 164
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    .line 165
    return-void
.end method

.method static wordLength(Ljava/lang/CharSequence;)I
    .locals 9

    .prologue
    const/4 v0, 0x2

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 248
    if-nez p0, :cond_1

    .line 289
    :cond_0
    :goto_0
    return v2

    .line 249
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v3

    .line 250
    if-eqz v3, :cond_0

    .line 252
    invoke-static {p0, v3}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v4

    .line 253
    invoke-static {v4}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v5

    if-eqz v5, :cond_e

    .line 254
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

    .line 255
    :cond_2
    invoke-static {v4}, Ljava/lang/Character;->charCount(I)I

    move-result v2

    goto :goto_0

    .line 260
    :cond_3
    invoke-static {v0}, Ljava/lang/Character;->charCount(I)I

    move-result v0

    sub-int/2addr v5, v0

    .line 257
    :goto_1
    if-lez v5, :cond_4

    .line 258
    invoke-static {p0, v5}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v0

    .line 259
    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->isBlank(I)Z

    move-result v4

    if-nez v4, :cond_3

    .line 262
    :cond_4
    if-nez v5, :cond_5

    move v2, v3

    goto :goto_0

    .line 263
    :cond_5
    invoke-static {p0, v5}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v0

    if-eqz v0, :cond_6

    sub-int v2, v3, v5

    goto :goto_0

    .line 265
    :cond_6
    const/4 v0, -0x1

    move v4, v5

    .line 266
    :goto_2
    if-lez v4, :cond_8

    .line 267
    invoke-static {p0, v4}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v6

    .line 268
    invoke-static {v6}, Ljava/lang/Character;->charCount(I)I

    move-result v7

    .line 269
    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isMark(I)Z

    move-result v8

    if-eqz v8, :cond_7

    .line 270
    sub-int/2addr v4, v7

    .line 271
    goto :goto_2

    .line 273
    :cond_7
    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isBlank(I)Z

    move-result v8

    if-nez v8, :cond_8

    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v8

    if-eqz v8, :cond_9

    .line 289
    :cond_8
    :goto_3
    sub-int v2, v3, v4

    goto :goto_0

    .line 274
    :cond_9
    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isWord(I)Z

    move-result v8

    .line 275
    if-gez v0, :cond_c

    .line 276
    if-eqz v8, :cond_b

    move v0, v1

    .line 287
    :cond_a
    :goto_4
    sub-int/2addr v4, v7

    .line 288
    goto :goto_2

    :cond_b
    move v0, v2

    .line 276
    goto :goto_4

    .line 277
    :cond_c
    if-ne v0, v1, :cond_d

    if-nez v8, :cond_d

    .line 279
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

    .line 280
    sub-int/2addr v4, v7

    .line 281
    goto :goto_2

    .line 284
    :cond_d
    if-nez v0, :cond_a

    if-eqz v8, :cond_a

    goto :goto_3

    :cond_e
    move v5, v3

    goto :goto_1
.end method
