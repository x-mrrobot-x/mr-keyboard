.class public final Lcom/mrkeyboard/app/MrWordDelete;
.super Ljava/lang/Object;
.source "MrWordDelete.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrWordDelete$Cut;
    }
.end annotation


# static fields
.field static final INTERVAL_DEFAULT:I = 0xc8

.field static final INTERVAL_MAX:I = 0x258

.field static final INTERVAL_MIN:I = 0x64

.field static final KEYCODE_DELETE:I = -0x5

.field static final LOOKBACK:I = 0x40

.field static final PREF_INTERVAL:Ljava/lang/String; = "pref_word_delete_interval"

.field static final PREF_ON:Ljava/lang/String; = "pref_word_delete"

.field static final UNDO_LIFETIME_MS:J = 0x1d4c0L

.field static final UNDO_MAX:I = 0x20

.field private static sApp:Landroid/content/Context;

.field static sClock:J

.field private static final sCuts:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/mrkeyboard/app/MrWordDelete$Cut;",
            ">;"
        }
    .end annotation
.end field

.field private static sHold:Z

.field static volatile sInterval:I

.field private static sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

.field static volatile sOn:Z

.field private static sPure:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 79
    const/16 v0, 0xc8

    sput v0, Lcom/mrkeyboard/app/MrWordDelete;->sInterval:I

    .line 104
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    .line 108
    const-wide/16 v0, -0x1

    sput-wide v0, Lcom/mrkeyboard/app/MrWordDelete;->sClock:J

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 113
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static down(Lcom/mrkeyboard/app/Keyboard$Key;)V
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 199
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

    .line 208
    :cond_0
    :goto_0
    return-void

    .line 200
    :cond_1
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    .line 201
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    if-nez v0, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->init(Landroid/content/Context;)V

    .line 202
    :cond_2
    sget-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    if-eqz v0, :cond_0

    .line 203
    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    .line 204
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

    .line 205
    :catch_0
    move-exception v0

    .line 206
    sput-boolean v1, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    goto :goto_0

    :cond_3
    move v0, v1

    .line 204
    goto :goto_1
.end method

.method static declared-synchronized init(Landroid/content/Context;)V
    .locals 3

    .prologue
    .line 138
    const-class v1, Lcom/mrkeyboard/app/MrWordDelete;

    monitor-enter v1

    if-nez p0, :cond_0

    .line 156
    :goto_0
    monitor-exit v1

    return-void

    .line 139
    :cond_0
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    if-nez v0, :cond_2

    .line 140
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 141
    if-eqz v0, :cond_1

    move-object p0, v0

    :cond_1
    sput-object p0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    .line 142
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 143
    if-eqz v0, :cond_2

    .line 144
    new-instance v2, Lcom/mrkeyboard/app/MrWordDelete$1;

    invoke-direct {v2}, Lcom/mrkeyboard/app/MrWordDelete$1;-><init>()V

    sput-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .line 149
    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v0, v2}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 152
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->reload()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 153
    :catch_0
    move-exception v0

    .line 154
    const/4 v0, 0x0

    :try_start_1
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 138
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static interval(I)I
    .locals 1

    .prologue
    .line 217
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
    .line 178
    if-nez p0, :cond_1

    .line 186
    :cond_0
    :goto_0
    return p1

    .line 180
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v0

    .line 181
    cmpl-float v1, v0, v0

    if-nez v1, :cond_0

    .line 182
    const/high16 v1, 0x42c80000    # 100.0f

    cmpg-float v1, v0, v1

    if-gez v1, :cond_2

    const/16 p1, 0x64

    goto :goto_0

    .line 183
    :cond_2
    const/high16 v1, 0x44160000    # 600.0f

    cmpl-float v1, v0, v1

    if-lez v1, :cond_3

    const/16 p1, 0x258

    goto :goto_0

    .line 184
    :cond_3
    invoke-static {v0}, Ljava/lang/Math;->round(F)I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result p1

    goto :goto_0

    .line 185
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static isBlank(I)Z
    .locals 1

    .prologue
    .line 373
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
    .line 368
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
    .line 381
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
    .line 362
    invoke-static {p0}, Ljava/lang/Character;->getType(I)I

    move-result v0

    .line 363
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
    .line 377
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

.method private static keep(Landroid/view/inputmethod/InputConnection;Ljava/lang/String;Ljava/lang/String;Ljava/lang/CharSequence;)V
    .locals 7

    .prologue
    .line 295
    if-nez p3, :cond_0

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 308
    :goto_0
    return-void

    .line 296
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    sget-object v1, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;

    invoke-virtual {v0, p2, p3}, Lcom/mrkeyboard/app/MrWordDelete$Cut;->matches(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 297
    :cond_1
    const/16 v0, 0x40

    const/4 v1, 0x0

    invoke-interface {p0, v0, v1}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v1

    .line 298
    if-nez v1, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 305
    :catch_0
    move-exception v0

    .line 306
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    goto :goto_0

    .line 299
    :cond_2
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sPure:Z

    .line 300
    :cond_3
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v2, 0x20

    if-lt v0, v2, :cond_4

    .line 301
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 302
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sPure:Z

    .line 304
    :cond_4
    sget-object v6, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    new-instance v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p3}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->now()J

    move-result-wide v4

    move-object v1, p1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrWordDelete$Cut;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method private static now()J
    .locals 4

    .prologue
    .line 265
    sget-wide v0, Lcom/mrkeyboard/app/MrWordDelete;->sClock:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-ltz v0, :cond_0

    sget-wide v0, Lcom/mrkeyboard/app/MrWordDelete;->sClock:J

    :goto_0
    return-wide v0

    :cond_0
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v0

    const-wide/32 v2, 0xf4240

    div-long/2addr v0, v2

    goto :goto_0
.end method

.method public static onBackspace(Lcom/mrkeyboard/app/LatinIME;)Z
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 226
    sget-boolean v1, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    if-nez v1, :cond_1

    .line 258
    :cond_0
    :goto_0
    return v0

    .line 228
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v2

    .line 229
    if-eqz v2, :cond_0

    .line 231
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 233
    const/4 v1, 0x0

    :try_start_1
    invoke-interface {v2, v1}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;

    move-result-object v1

    .line 234
    if-eqz v1, :cond_2

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v1

    if-lez v1, :cond_2

    .line 253
    :try_start_2
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 256
    :catch_0
    move-exception v1

    .line 257
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    goto :goto_0

    .line 235
    :cond_2
    const/16 v1, 0x40

    const/4 v3, 0x0

    :try_start_3
    invoke-interface {v2, v1, v3}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v1

    .line 236
    invoke-static {v1}, Lcom/mrkeyboard/app/MrWordDelete;->wordLength(Ljava/lang/CharSequence;)I

    move-result v3

    .line 237
    if-lez v3, :cond_4

    .line 238
    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v4

    sub-int/2addr v4, v3

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v5

    invoke-interface {v1, v4, v5}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v4

    invoke-interface {v4}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v4

    .line 239
    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    .line 240
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->purge()V

    .line 241
    invoke-static {v2}, Lcom/mrkeyboard/app/MrWordDelete;->readAfter(Landroid/view/inputmethod/InputConnection;)Ljava/lang/CharSequence;

    move-result-object v5

    .line 242
    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 244
    :try_start_4
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrHoldsWord()Z

    move-result v6

    if-eqz v6, :cond_3

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrDropComposing()V

    .line 245
    :cond_3
    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    .line 246
    const/4 v6, 0x0

    invoke-interface {v2, v3, v6}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 248
    :try_start_5
    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 250
    invoke-static {v2, v4, v1, v5}, Lcom/mrkeyboard/app/MrWordDelete;->keep(Landroid/view/inputmethod/InputConnection;Ljava/lang/String;Ljava/lang/String;Ljava/lang/CharSequence;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 253
    :cond_4
    :try_start_6
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_0

    .line 255
    if-lez v3, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    .line 248
    :catchall_0
    move-exception v1

    :try_start_7
    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 249
    throw v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 253
    :catchall_1
    move-exception v1

    :try_start_8
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 254
    throw v1
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_0
.end method

.method public static onUndo(Lcom/mrkeyboard/app/LatinIME;C)Z
    .locals 8

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 316
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    .line 355
    :goto_0
    return v0

    .line 318
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->purge()V

    .line 319
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    move v0, v1

    goto :goto_0

    .line 320
    :cond_1
    sget-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    if-nez v0, :cond_2

    .line 321
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    move v0, v1

    .line 322
    goto :goto_0

    .line 324
    :cond_2
    const/16 v0, 0x7a

    if-eq p1, v0, :cond_3

    const/16 v0, 0x5a

    if-ne p1, v0, :cond_4

    :cond_3
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrCtrlOnly()Z

    move-result v0

    if-nez v0, :cond_5

    :cond_4
    move v0, v1

    goto :goto_0

    .line 325
    :cond_5
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v3, v0, -0x1

    .line 326
    if-nez v3, :cond_6

    sget-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sPure:Z

    if-eqz v0, :cond_6

    .line 327
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    move v0, v1

    .line 328
    goto :goto_0

    .line 330
    :cond_6
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v4

    .line 331
    if-nez v4, :cond_7

    move v0, v1

    goto :goto_0

    .line 332
    :cond_7
    const/4 v0, 0x0

    invoke-interface {v4, v0}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;

    move-result-object v0

    .line 333
    if-eqz v0, :cond_8

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-lez v0, :cond_8

    .line 334
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    move v0, v1

    .line 335
    goto :goto_0

    .line 337
    :cond_8
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;

    .line 338
    const/16 v5, 0x40

    const/4 v6, 0x0

    invoke-interface {v4, v5, v6}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v5

    const/16 v6, 0x40

    const/4 v7, 0x0

    invoke-interface {v4, v6, v7}, Landroid/view/inputmethod/InputConnection;->getTextAfterCursor(II)Ljava/lang/CharSequence;

    move-result-object v6

    invoke-virtual {v0, v5, v6}, Lcom/mrkeyboard/app/MrWordDelete$Cut;->matches(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_9

    .line 339
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    move v0, v1

    .line 340
    goto :goto_0

    .line 342
    :cond_9
    invoke-interface {v4}, Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 344
    :try_start_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrHoldsWord()Z

    move-result v5

    if-eqz v5, :cond_a

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrDropComposing()V

    .line 345
    :cond_a
    invoke-interface {v4}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    .line 346
    iget-object v0, v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;->text:Ljava/lang/String;

    const/4 v5, 0x1

    invoke-interface {v4, v0, v5}, Landroid/view/inputmethod/InputConnection;->commitText(Ljava/lang/CharSequence;I)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 348
    :try_start_2
    invoke-interface {v4}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 350
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 351
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sPure:Z

    move v0, v2

    .line 352
    goto/16 :goto_0

    .line 348
    :catchall_0
    move-exception v0

    invoke-interface {v4}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 349
    throw v0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    .line 353
    :catch_0
    move-exception v0

    .line 354
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    move v0, v1

    .line 355
    goto/16 :goto_0
.end method

.method private static purge()V
    .locals 10

    .prologue
    const/4 v2, 0x0

    .line 270
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->now()J

    move-result-wide v4

    move v1, v2

    .line 272
    :goto_0
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;

    iget-wide v6, v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;->at:J

    sub-long v6, v4, v6

    const-wide/32 v8, 0x1d4c0

    cmp-long v0, v6, v8

    if-ltz v0, :cond_0

    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 273
    :cond_0
    if-lez v1, :cond_1

    .line 274
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0, v2, v1}, Ljava/util/ArrayList;->subList(II)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 275
    sput-boolean v2, Lcom/mrkeyboard/app/MrWordDelete;->sPure:Z

    .line 277
    :cond_1
    return-void
.end method

.method private static readAfter(Landroid/view/inputmethod/InputConnection;)Ljava/lang/CharSequence;
    .locals 2

    .prologue
    .line 282
    const/16 v0, 0x40

    const/4 v1, 0x0

    :try_start_0
    invoke-interface {p0, v0, v1}, Landroid/view/inputmethod/InputConnection;->getTextAfterCursor(II)Ljava/lang/CharSequence;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 284
    :goto_0
    return-object v0

    .line 283
    :catch_0
    move-exception v0

    .line 284
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static declared-synchronized reload()V
    .locals 6

    .prologue
    const/16 v0, 0xc8

    const/4 v1, 0x0

    .line 160
    const-class v2, Lcom/mrkeyboard/app/MrWordDelete;

    monitor-enter v2

    :try_start_0
    sget-object v3, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v3, :cond_1

    .line 171
    :cond_0
    :goto_0
    monitor-exit v2

    return-void

    .line 161
    :cond_1
    :try_start_1
    sget-object v3, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    invoke-static {v3}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 162
    if-eqz v3, :cond_2

    const-string v4, "pref_word_delete"

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v4

    if-eqz v4, :cond_2

    const/4 v1, 0x1

    :cond_2
    sput-boolean v1, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    .line 163
    if-nez v3, :cond_3

    :goto_1
    sput v0, Lcom/mrkeyboard/app/MrWordDelete;->sInterval:I

    .line 164
    sget-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    if-nez v0, :cond_0

    .line 165
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    .line 166
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 168
    :catch_0
    move-exception v0

    .line 169
    const/4 v0, 0x0

    :try_start_2
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 160
    :catchall_0
    move-exception v0

    monitor-exit v2

    throw v0

    .line 163
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
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 120
    const-class v1, Lcom/mrkeyboard/app/MrWordDelete;

    monitor-enter v1

    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    if-nez v2, :cond_1

    .line 121
    :goto_0
    if-eqz v0, :cond_0

    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v0, v2}, Landroid/content/SharedPreferences;->unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 125
    :cond_0
    :goto_1
    const/4 v0, 0x0

    :try_start_1
    sput-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    .line 126
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .line 127
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    .line 128
    const/16 v0, 0xc8

    sput v0, Lcom/mrkeyboard/app/MrWordDelete;->sInterval:I

    .line 129
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    .line 130
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 131
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sPure:Z

    .line 132
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrWordDelete;->sClock:J
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 133
    monitor-exit v1

    return-void

    .line 120
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

    .line 122
    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method public static up()V
    .locals 1

    .prologue
    .line 212
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    .line 213
    return-void
.end method

.method static wordLength(Ljava/lang/CharSequence;)I
    .locals 9

    .prologue
    const/4 v0, 0x2

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 389
    if-nez p0, :cond_1

    .line 430
    :cond_0
    :goto_0
    return v2

    .line 390
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v3

    .line 391
    if-eqz v3, :cond_0

    .line 393
    invoke-static {p0, v3}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v4

    .line 394
    invoke-static {v4}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v5

    if-eqz v5, :cond_e

    .line 395
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

    .line 396
    :cond_2
    invoke-static {v4}, Ljava/lang/Character;->charCount(I)I

    move-result v2

    goto :goto_0

    .line 401
    :cond_3
    invoke-static {v0}, Ljava/lang/Character;->charCount(I)I

    move-result v0

    sub-int/2addr v5, v0

    .line 398
    :goto_1
    if-lez v5, :cond_4

    .line 399
    invoke-static {p0, v5}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v0

    .line 400
    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->isBlank(I)Z

    move-result v4

    if-nez v4, :cond_3

    .line 403
    :cond_4
    if-nez v5, :cond_5

    move v2, v3

    goto :goto_0

    .line 404
    :cond_5
    invoke-static {p0, v5}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v0

    if-eqz v0, :cond_6

    sub-int v2, v3, v5

    goto :goto_0

    .line 406
    :cond_6
    const/4 v0, -0x1

    move v4, v5

    .line 407
    :goto_2
    if-lez v4, :cond_8

    .line 408
    invoke-static {p0, v4}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v6

    .line 409
    invoke-static {v6}, Ljava/lang/Character;->charCount(I)I

    move-result v7

    .line 410
    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isMark(I)Z

    move-result v8

    if-eqz v8, :cond_7

    .line 411
    sub-int/2addr v4, v7

    .line 412
    goto :goto_2

    .line 414
    :cond_7
    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isBlank(I)Z

    move-result v8

    if-nez v8, :cond_8

    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v8

    if-eqz v8, :cond_9

    .line 430
    :cond_8
    :goto_3
    sub-int v2, v3, v4

    goto :goto_0

    .line 415
    :cond_9
    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isWord(I)Z

    move-result v8

    .line 416
    if-gez v0, :cond_c

    .line 417
    if-eqz v8, :cond_b

    move v0, v1

    .line 428
    :cond_a
    :goto_4
    sub-int/2addr v4, v7

    .line 429
    goto :goto_2

    :cond_b
    move v0, v2

    .line 417
    goto :goto_4

    .line 418
    :cond_c
    if-ne v0, v1, :cond_d

    if-nez v8, :cond_d

    .line 420
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

    .line 421
    sub-int/2addr v4, v7

    .line 422
    goto :goto_2

    .line 425
    :cond_d
    if-nez v0, :cond_a

    if-eqz v8, :cond_a

    goto :goto_3

    :cond_e
    move v5, v3

    goto :goto_1
.end method
