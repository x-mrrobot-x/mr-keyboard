.class public final Lcom/mrkeyboard/app/MrWordDelete;
.super Ljava/lang/Object;
.source "MrWordDelete.java"


# static fields
.field static final INTERVAL_DEFAULT:I = 0xc8

.field static final INTERVAL_MAX:I = 0x258

.field static final INTERVAL_MIN:I = 0x64

.field static final KEYCODE_DELETE:I = -0x5

.field static final LOOKBACK:I = 0x40

.field static final PREF_INTERVAL:Ljava/lang/String; = "pref_word_delete_interval"

.field static final PREF_ON:Ljava/lang/String; = "pref_word_delete"

.field private static sApp:Landroid/content/Context;

.field private static sHold:Z

.field static volatile sInterval:I

.field private static sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

.field static volatile sOn:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 62
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

    .line 150
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

    .line 159
    :cond_0
    :goto_0
    return-void

    .line 151
    :cond_1
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    .line 152
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    if-nez v0, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->init(Landroid/content/Context;)V

    .line 153
    :cond_2
    sget-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    if-eqz v0, :cond_0

    .line 154
    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    .line 155
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

    .line 156
    :catch_0
    move-exception v0

    .line 157
    sput-boolean v1, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    goto :goto_0

    :cond_3
    move v0, v1

    .line 155
    goto :goto_1
.end method

.method static declared-synchronized init(Landroid/content/Context;)V
    .locals 3

    .prologue
    .line 92
    const-class v1, Lcom/mrkeyboard/app/MrWordDelete;

    monitor-enter v1

    if-nez p0, :cond_0

    .line 110
    :goto_0
    monitor-exit v1

    return-void

    .line 93
    :cond_0
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    if-nez v0, :cond_2

    .line 94
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 95
    if-eqz v0, :cond_1

    move-object p0, v0

    :cond_1
    sput-object p0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    .line 96
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 97
    if-eqz v0, :cond_2

    .line 98
    new-instance v2, Lcom/mrkeyboard/app/MrWordDelete$1;

    invoke-direct {v2}, Lcom/mrkeyboard/app/MrWordDelete$1;-><init>()V

    sput-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .line 103
    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v0, v2}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 106
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->reload()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 107
    :catch_0
    move-exception v0

    .line 108
    const/4 v0, 0x0

    :try_start_1
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 92
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static interval(I)I
    .locals 1

    .prologue
    .line 168
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
    .line 129
    if-nez p0, :cond_1

    .line 137
    :cond_0
    :goto_0
    return p1

    .line 131
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v0

    .line 132
    cmpl-float v1, v0, v0

    if-nez v1, :cond_0

    .line 133
    const/high16 v1, 0x42c80000    # 100.0f

    cmpg-float v1, v0, v1

    if-gez v1, :cond_2

    const/16 p1, 0x64

    goto :goto_0

    .line 134
    :cond_2
    const/high16 v1, 0x44160000    # 600.0f

    cmpl-float v1, v0, v1

    if-lez v1, :cond_3

    const/16 p1, 0x258

    goto :goto_0

    .line 135
    :cond_3
    invoke-static {v0}, Ljava/lang/Math;->round(F)I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result p1

    goto :goto_0

    .line 136
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static isBlank(I)Z
    .locals 1

    .prologue
    .line 221
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
    .line 216
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
    .line 229
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
    .line 210
    invoke-static {p0}, Ljava/lang/Character;->getType(I)I

    move-result v0

    .line 211
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
    .line 225
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

    .line 177
    sget-boolean v1, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    if-nez v1, :cond_1

    .line 203
    :cond_0
    :goto_0
    return v0

    .line 179
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v2

    .line 180
    if-eqz v2, :cond_0

    .line 182
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 184
    const/4 v1, 0x0

    :try_start_1
    invoke-interface {v2, v1}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;

    move-result-object v1

    .line 185
    if-eqz v1, :cond_2

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v1

    if-lez v1, :cond_2

    .line 198
    :try_start_2
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 201
    :catch_0
    move-exception v1

    .line 202
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    goto :goto_0

    .line 186
    :cond_2
    const/16 v1, 0x40

    const/4 v3, 0x0

    :try_start_3
    invoke-interface {v2, v1, v3}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrWordDelete;->wordLength(Ljava/lang/CharSequence;)I

    move-result v1

    .line 187
    if-lez v1, :cond_4

    .line 188
    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 190
    :try_start_4
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrHoldsWord()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrDropComposing()V

    .line 191
    :cond_3
    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    .line 192
    const/4 v3, 0x0

    invoke-interface {v2, v1, v3}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 194
    :try_start_5
    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 198
    :cond_4
    :try_start_6
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_0

    .line 200
    if-lez v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    .line 194
    :catchall_0
    move-exception v1

    :try_start_7
    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 195
    throw v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 198
    :catchall_1
    move-exception v1

    :try_start_8
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 199
    throw v1
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_0
.end method

.method static declared-synchronized reload()V
    .locals 6

    .prologue
    const/16 v0, 0xc8

    const/4 v1, 0x0

    .line 114
    const-class v2, Lcom/mrkeyboard/app/MrWordDelete;

    monitor-enter v2

    :try_start_0
    sget-object v3, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v3, :cond_1

    .line 122
    :cond_0
    :goto_0
    monitor-exit v2

    return-void

    .line 115
    :cond_1
    :try_start_1
    sget-object v3, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    invoke-static {v3}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 116
    if-eqz v3, :cond_2

    const-string v4, "pref_word_delete"

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v4

    if-eqz v4, :cond_2

    const/4 v1, 0x1

    :cond_2
    sput-boolean v1, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    .line 117
    if-nez v3, :cond_3

    :goto_1
    sput v0, Lcom/mrkeyboard/app/MrWordDelete;->sInterval:I

    .line 118
    sget-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    if-nez v0, :cond_0

    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 119
    :catch_0
    move-exception v0

    .line 120
    const/4 v0, 0x0

    :try_start_2
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 114
    :catchall_0
    move-exception v0

    monitor-exit v2

    throw v0

    .line 117
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
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 87
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

.method public static up()V
    .locals 1

    .prologue
    .line 163
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    .line 164
    return-void
.end method

.method static wordLength(Ljava/lang/CharSequence;)I
    .locals 9

    .prologue
    const/4 v0, 0x2

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 237
    if-nez p0, :cond_1

    .line 278
    :cond_0
    :goto_0
    return v2

    .line 238
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v3

    .line 239
    if-eqz v3, :cond_0

    .line 241
    invoke-static {p0, v3}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v4

    .line 242
    invoke-static {v4}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v5

    if-eqz v5, :cond_e

    .line 243
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

    .line 244
    :cond_2
    invoke-static {v4}, Ljava/lang/Character;->charCount(I)I

    move-result v2

    goto :goto_0

    .line 249
    :cond_3
    invoke-static {v0}, Ljava/lang/Character;->charCount(I)I

    move-result v0

    sub-int/2addr v5, v0

    .line 246
    :goto_1
    if-lez v5, :cond_4

    .line 247
    invoke-static {p0, v5}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v0

    .line 248
    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->isBlank(I)Z

    move-result v4

    if-nez v4, :cond_3

    .line 251
    :cond_4
    if-nez v5, :cond_5

    move v2, v3

    goto :goto_0

    .line 252
    :cond_5
    invoke-static {p0, v5}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v0

    if-eqz v0, :cond_6

    sub-int v2, v3, v5

    goto :goto_0

    .line 254
    :cond_6
    const/4 v0, -0x1

    move v4, v5

    .line 255
    :goto_2
    if-lez v4, :cond_8

    .line 256
    invoke-static {p0, v4}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v6

    .line 257
    invoke-static {v6}, Ljava/lang/Character;->charCount(I)I

    move-result v7

    .line 258
    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isMark(I)Z

    move-result v8

    if-eqz v8, :cond_7

    .line 259
    sub-int/2addr v4, v7

    .line 260
    goto :goto_2

    .line 262
    :cond_7
    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isBlank(I)Z

    move-result v8

    if-nez v8, :cond_8

    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v8

    if-eqz v8, :cond_9

    .line 278
    :cond_8
    :goto_3
    sub-int v2, v3, v4

    goto :goto_0

    .line 263
    :cond_9
    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isWord(I)Z

    move-result v8

    .line 264
    if-gez v0, :cond_c

    .line 265
    if-eqz v8, :cond_b

    move v0, v1

    .line 276
    :cond_a
    :goto_4
    sub-int/2addr v4, v7

    .line 277
    goto :goto_2

    :cond_b
    move v0, v2

    .line 265
    goto :goto_4

    .line 266
    :cond_c
    if-ne v0, v1, :cond_d

    if-nez v8, :cond_d

    .line 268
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

    .line 269
    sub-int/2addr v4, v7

    .line 270
    goto :goto_2

    .line 273
    :cond_d
    if-nez v0, :cond_a

    if-eqz v8, :cond_a

    goto :goto_3

    :cond_e
    move v5, v3

    goto :goto_1
.end method
