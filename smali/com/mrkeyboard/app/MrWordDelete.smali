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

.field private static final sRedo:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/mrkeyboard/app/MrWordDelete$Cut;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 86
    const/16 v0, 0xc8

    sput v0, Lcom/mrkeyboard/app/MrWordDelete;->sInterval:I

    .line 118
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    .line 120
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sRedo:Ljava/util/ArrayList;

    .line 124
    const-wide/16 v0, -0x1

    sput-wide v0, Lcom/mrkeyboard/app/MrWordDelete;->sClock:J

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 129
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static down(Lcom/mrkeyboard/app/Keyboard$Key;)V
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 216
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

    .line 225
    :cond_0
    :goto_0
    return-void

    .line 217
    :cond_1
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    .line 218
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    if-nez v0, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->init(Landroid/content/Context;)V

    .line 219
    :cond_2
    sget-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    if-eqz v0, :cond_0

    .line 220
    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    .line 221
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

    .line 222
    :catch_0
    move-exception v0

    .line 223
    sput-boolean v1, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    goto :goto_0

    :cond_3
    move v0, v1

    .line 221
    goto :goto_1
.end method

.method static declared-synchronized init(Landroid/content/Context;)V
    .locals 3

    .prologue
    .line 155
    const-class v1, Lcom/mrkeyboard/app/MrWordDelete;

    monitor-enter v1

    if-nez p0, :cond_0

    .line 173
    :goto_0
    monitor-exit v1

    return-void

    .line 156
    :cond_0
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    if-nez v0, :cond_2

    .line 157
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 158
    if-eqz v0, :cond_1

    move-object p0, v0

    :cond_1
    sput-object p0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    .line 159
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 160
    if-eqz v0, :cond_2

    .line 161
    new-instance v2, Lcom/mrkeyboard/app/MrWordDelete$1;

    invoke-direct {v2}, Lcom/mrkeyboard/app/MrWordDelete$1;-><init>()V

    sput-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .line 166
    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v0, v2}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 169
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->reload()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 170
    :catch_0
    move-exception v0

    .line 171
    const/4 v0, 0x0

    :try_start_1
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 155
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method public static interval(I)I
    .locals 1

    .prologue
    .line 234
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
    .line 195
    if-nez p0, :cond_1

    .line 203
    :cond_0
    :goto_0
    return p1

    .line 197
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v0

    .line 198
    cmpl-float v1, v0, v0

    if-nez v1, :cond_0

    .line 199
    const/high16 v1, 0x42c80000    # 100.0f

    cmpg-float v1, v0, v1

    if-gez v1, :cond_2

    const/16 p1, 0x64

    goto :goto_0

    .line 200
    :cond_2
    const/high16 v1, 0x44160000    # 600.0f

    cmpl-float v1, v0, v1

    if-lez v1, :cond_3

    const/16 p1, 0x258

    goto :goto_0

    .line 201
    :cond_3
    invoke-static {v0}, Ljava/lang/Math;->round(F)I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result p1

    goto :goto_0

    .line 202
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static isBlank(I)Z
    .locals 1

    .prologue
    .line 450
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
    .line 445
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
    .line 458
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
    .line 439
    invoke-static {p0}, Ljava/lang/Character;->getType(I)I

    move-result v0

    .line 440
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
    .line 454
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
    .locals 6

    .prologue
    .line 337
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sRedo:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 338
    if-nez p3, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 346
    :goto_0
    return-void

    .line 339
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

    .line 340
    :cond_1
    const/16 v0, 0x40

    const/4 v1, 0x0

    invoke-interface {p0, v0, v1}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v1

    .line 341
    if-nez v1, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 343
    :catch_0
    move-exception v0

    .line 344
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    goto :goto_0

    .line 342
    :cond_2
    :try_start_1
    new-instance v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p3}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    const-wide/16 v4, 0x0

    move-object v1, p1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrWordDelete$Cut;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->push(Lcom/mrkeyboard/app/MrWordDelete$Cut;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method private static letGo(Ljava/util/ArrayList;J)Z
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/mrkeyboard/app/MrWordDelete$Cut;",
            ">;J)Z"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 303
    move v1, v2

    .line 304
    :goto_0
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;

    iget-wide v4, v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;->at:J

    sub-long v4, p1, v4

    const-wide/32 v6, 0x1d4c0

    cmp-long v0, v4, v6

    if-ltz v0, :cond_0

    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 305
    :cond_0
    if-lez v1, :cond_1

    invoke-virtual {p0, v2, v1}, Ljava/util/ArrayList;->subList(II)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 306
    :cond_1
    if-lez v1, :cond_2

    const/4 v2, 0x1

    :cond_2
    return v2
.end method

.method private static now()J
    .locals 4

    .prologue
    .line 282
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

    .line 243
    sget-boolean v1, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    if-nez v1, :cond_1

    .line 275
    :cond_0
    :goto_0
    return v0

    .line 245
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v2

    .line 246
    if-eqz v2, :cond_0

    .line 248
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 250
    const/4 v1, 0x0

    :try_start_1
    invoke-interface {v2, v1}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;

    move-result-object v1

    .line 251
    if-eqz v1, :cond_2

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v1

    if-lez v1, :cond_2

    .line 270
    :try_start_2
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 273
    :catch_0
    move-exception v1

    .line 274
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    goto :goto_0

    .line 252
    :cond_2
    const/16 v1, 0x40

    const/4 v3, 0x0

    :try_start_3
    invoke-interface {v2, v1, v3}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v1

    .line 253
    invoke-static {v1}, Lcom/mrkeyboard/app/MrWordDelete;->wordLength(Ljava/lang/CharSequence;)I

    move-result v3

    .line 254
    if-lez v3, :cond_4

    .line 255
    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v4

    sub-int/2addr v4, v3

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v5

    invoke-interface {v1, v4, v5}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v4

    invoke-interface {v4}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v4

    .line 256
    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    .line 257
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->purge()V

    .line 258
    invoke-static {v2}, Lcom/mrkeyboard/app/MrWordDelete;->readAfter(Landroid/view/inputmethod/InputConnection;)Ljava/lang/CharSequence;

    move-result-object v5

    .line 259
    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 261
    :try_start_4
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrHoldsWord()Z

    move-result v6

    if-eqz v6, :cond_3

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrDropComposing()V

    .line 262
    :cond_3
    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    .line 263
    const/4 v6, 0x0

    invoke-interface {v2, v3, v6}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 265
    :try_start_5
    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 267
    invoke-static {v2, v4, v1, v5}, Lcom/mrkeyboard/app/MrWordDelete;->keep(Landroid/view/inputmethod/InputConnection;Ljava/lang/String;Ljava/lang/String;Ljava/lang/CharSequence;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 270
    :cond_4
    :try_start_6
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_0

    .line 272
    if-lez v3, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    .line 265
    :catchall_0
    move-exception v1

    :try_start_7
    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 266
    throw v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 270
    :catchall_1
    move-exception v1

    :try_start_8
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 271
    throw v1
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_0
.end method

.method public static onUndoRedo(Lcom/mrkeyboard/app/LatinIME;C)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 354
    sget-object v1, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    sget-object v1, Lcom/mrkeyboard/app/MrWordDelete;->sRedo:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 368
    :cond_0
    :goto_0
    return v0

    .line 356
    :cond_1
    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->purge()V

    .line 357
    sget-object v1, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_2

    sget-object v1, Lcom/mrkeyboard/app/MrWordDelete;->sRedo:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 358
    :cond_2
    sget-boolean v1, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    if-nez v1, :cond_3

    .line 359
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->release()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 366
    :catch_0
    move-exception v1

    .line 367
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->release()V

    goto :goto_0

    .line 362
    :cond_3
    const/16 v1, 0x79

    if-eq p1, v1, :cond_4

    const/16 v1, 0x59

    if-ne p1, v1, :cond_6

    :cond_4
    const/4 v1, 0x1

    .line 363
    :goto_1
    if-nez v1, :cond_5

    const/16 v2, 0x7a

    if-eq p1, v2, :cond_5

    const/16 v2, 0x5a

    if-ne p1, v2, :cond_0

    .line 364
    :cond_5
    :try_start_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrCtrlOnly()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 365
    if-eqz v1, :cond_7

    invoke-static {p0}, Lcom/mrkeyboard/app/MrWordDelete;->redo(Lcom/mrkeyboard/app/LatinIME;)Z

    move-result v0

    goto :goto_0

    :cond_6
    move v1, v0

    .line 362
    goto :goto_1

    .line 365
    :cond_7
    invoke-static {p0}, Lcom/mrkeyboard/app/MrWordDelete;->undo(Lcom/mrkeyboard/app/LatinIME;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-result v0

    goto :goto_0
.end method

.method private static purge()V
    .locals 3

    .prologue
    .line 297
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->now()J

    move-result-wide v0

    .line 298
    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-static {v2, v0, v1}, Lcom/mrkeyboard/app/MrWordDelete;->letGo(Ljava/util/ArrayList;J)Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 v2, 0x0

    sput-boolean v2, Lcom/mrkeyboard/app/MrWordDelete;->sPure:Z

    .line 299
    :cond_0
    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sRedo:Ljava/util/ArrayList;

    invoke-static {v2, v0, v1}, Lcom/mrkeyboard/app/MrWordDelete;->letGo(Ljava/util/ArrayList;J)Z

    .line 300
    return-void
.end method

.method private static push(Lcom/mrkeyboard/app/MrWordDelete$Cut;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 320
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sPure:Z

    .line 321
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v1, 0x20

    if-lt v0, v1, :cond_1

    .line 322
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 323
    sput-boolean v2, Lcom/mrkeyboard/app/MrWordDelete;->sPure:Z

    .line 325
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->now()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/mrkeyboard/app/MrWordDelete$Cut;->at:J

    .line 326
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 327
    return-void
.end method

.method private static readAfter(Landroid/view/inputmethod/InputConnection;)Ljava/lang/CharSequence;
    .locals 2

    .prologue
    .line 312
    const/16 v0, 0x40

    const/4 v1, 0x0

    :try_start_0
    invoke-interface {p0, v0, v1}, Landroid/view/inputmethod/InputConnection;->getTextAfterCursor(II)Ljava/lang/CharSequence;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 314
    :goto_0
    return-object v0

    .line 313
    :catch_0
    move-exception v0

    .line 314
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static redo(Lcom/mrkeyboard/app/LatinIME;)Z
    .locals 6

    .prologue
    const/16 v5, 0x40

    const/4 v1, 0x0

    .line 409
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sRedo:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    .line 433
    :goto_0
    return v0

    .line 410
    :cond_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v2

    .line 411
    if-nez v2, :cond_1

    move v0, v1

    goto :goto_0

    .line 412
    :cond_1
    invoke-interface {v2, v1}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;

    move-result-object v0

    .line 413
    if-eqz v0, :cond_2

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-lez v0, :cond_2

    .line 414
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->release()V

    move v0, v1

    .line 415
    goto :goto_0

    .line 417
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sRedo:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v3, v0, -0x1

    .line 418
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sRedo:Ljava/util/ArrayList;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;

    .line 419
    invoke-interface {v2, v5, v1}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v4

    invoke-interface {v2, v5, v1}, Landroid/view/inputmethod/InputConnection;->getTextAfterCursor(II)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-virtual {v0, v4, v5}, Lcom/mrkeyboard/app/MrWordDelete$Cut;->matchesBack(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_3

    .line 420
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->release()V

    move v0, v1

    .line 421
    goto :goto_0

    .line 423
    :cond_3
    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z

    .line 425
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrHoldsWord()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrDropComposing()V

    .line 426
    :cond_4
    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    .line 427
    iget-object v1, v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;->text:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v4, 0x0

    invoke-interface {v2, v1, v4}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 429
    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 431
    sget-object v1, Lcom/mrkeyboard/app/MrWordDelete;->sRedo:Ljava/util/ArrayList;

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 432
    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->push(Lcom/mrkeyboard/app/MrWordDelete$Cut;)V

    .line 433
    const/4 v0, 0x1

    goto :goto_0

    .line 429
    :catchall_0
    move-exception v0

    invoke-interface {v2}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 430
    throw v0
.end method

.method public static release()V
    .locals 1

    .prologue
    .line 290
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 291
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sRedo:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 292
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sPure:Z

    .line 293
    return-void
.end method

.method static declared-synchronized reload()V
    .locals 6

    .prologue
    const/16 v0, 0xc8

    const/4 v1, 0x0

    .line 177
    const-class v2, Lcom/mrkeyboard/app/MrWordDelete;

    monitor-enter v2

    :try_start_0
    sget-object v3, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v3, :cond_1

    .line 188
    :cond_0
    :goto_0
    monitor-exit v2

    return-void

    .line 178
    :cond_1
    :try_start_1
    sget-object v3, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    invoke-static {v3}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 179
    if-eqz v3, :cond_2

    const-string v4, "pref_word_delete"

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v4

    if-eqz v4, :cond_2

    const/4 v1, 0x1

    :cond_2
    sput-boolean v1, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    .line 180
    if-nez v3, :cond_3

    :goto_1
    sput v0, Lcom/mrkeyboard/app/MrWordDelete;->sInterval:I

    .line 181
    sget-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    if-nez v0, :cond_0

    .line 182
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    .line 183
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->release()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 185
    :catch_0
    move-exception v0

    .line 186
    const/4 v0, 0x0

    :try_start_2
    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 177
    :catchall_0
    move-exception v0

    monitor-exit v2

    throw v0

    .line 180
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

    .line 136
    const-class v1, Lcom/mrkeyboard/app/MrWordDelete;

    monitor-enter v1

    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    if-nez v2, :cond_1

    .line 137
    :goto_0
    if-eqz v0, :cond_0

    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v0, v2}, Landroid/content/SharedPreferences;->unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 141
    :cond_0
    :goto_1
    const/4 v0, 0x0

    :try_start_1
    sput-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sApp:Landroid/content/Context;

    .line 142
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sListener:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .line 143
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sOn:Z

    .line 144
    const/16 v0, 0xc8

    sput v0, Lcom/mrkeyboard/app/MrWordDelete;->sInterval:I

    .line 145
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    .line 146
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 147
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sRedo:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 148
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sPure:Z

    .line 149
    const-wide/16 v2, -0x1

    sput-wide v2, Lcom/mrkeyboard/app/MrWordDelete;->sClock:J
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 150
    monitor-exit v1

    return-void

    .line 136
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

    .line 138
    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method private static undo(Lcom/mrkeyboard/app/LatinIME;)Z
    .locals 7

    .prologue
    const/16 v6, 0x40

    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 373
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    .line 405
    :goto_0
    return v0

    .line 374
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v3, v0, -0x1

    .line 375
    if-nez v3, :cond_1

    sget-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sPure:Z

    if-eqz v0, :cond_1

    .line 376
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;

    .line 377
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->now()J

    move-result-wide v2

    iput-wide v2, v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;->at:J

    .line 378
    sget-object v2, Lcom/mrkeyboard/app/MrWordDelete;->sRedo:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move v0, v1

    .line 379
    goto :goto_0

    .line 381
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v4

    .line 382
    if-nez v4, :cond_2

    move v0, v1

    goto :goto_0

    .line 383
    :cond_2
    invoke-interface {v4, v1}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;

    move-result-object v0

    .line 384
    if-eqz v0, :cond_3

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-lez v0, :cond_3

    .line 385
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->release()V

    move v0, v1

    .line 386
    goto :goto_0

    .line 388
    :cond_3
    sget-object v0, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;

    .line 389
    invoke-interface {v4, v6, v1}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v4, v6, v1}, Landroid/view/inputmethod/InputConnection;->getTextAfterCursor(II)Ljava/lang/CharSequence;

    move-result-object v6

    invoke-virtual {v0, v5, v6}, Lcom/mrkeyboard/app/MrWordDelete$Cut;->matches(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_4

    .line 390
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->release()V

    move v0, v1

    .line 391
    goto :goto_0

    .line 393
    :cond_4
    invoke-interface {v4}, Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z

    .line 395
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrHoldsWord()Z

    move-result v5

    if-eqz v5, :cond_5

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->mrDropComposing()V

    .line 396
    :cond_5
    invoke-interface {v4}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    .line 397
    iget-object v5, v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;->text:Ljava/lang/String;

    const/4 v6, 0x1

    invoke-interface {v4, v5, v6}, Landroid/view/inputmethod/InputConnection;->commitText(Ljava/lang/CharSequence;I)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 399
    invoke-interface {v4}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 401
    sget-object v4, Lcom/mrkeyboard/app/MrWordDelete;->sCuts:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 402
    sput-boolean v1, Lcom/mrkeyboard/app/MrWordDelete;->sPure:Z

    .line 403
    invoke-static {}, Lcom/mrkeyboard/app/MrWordDelete;->now()J

    move-result-wide v4

    iput-wide v4, v0, Lcom/mrkeyboard/app/MrWordDelete$Cut;->at:J

    .line 404
    sget-object v1, Lcom/mrkeyboard/app/MrWordDelete;->sRedo:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move v0, v2

    .line 405
    goto/16 :goto_0

    .line 399
    :catchall_0
    move-exception v0

    invoke-interface {v4}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 400
    throw v0
.end method

.method public static up()V
    .locals 1

    .prologue
    .line 229
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrWordDelete;->sHold:Z

    .line 230
    return-void
.end method

.method static wordLength(Ljava/lang/CharSequence;)I
    .locals 9

    .prologue
    const/4 v0, 0x2

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 466
    if-nez p0, :cond_1

    .line 507
    :cond_0
    :goto_0
    return v2

    .line 467
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v3

    .line 468
    if-eqz v3, :cond_0

    .line 470
    invoke-static {p0, v3}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v4

    .line 471
    invoke-static {v4}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v5

    if-eqz v5, :cond_e

    .line 472
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

    .line 473
    :cond_2
    invoke-static {v4}, Ljava/lang/Character;->charCount(I)I

    move-result v2

    goto :goto_0

    .line 478
    :cond_3
    invoke-static {v0}, Ljava/lang/Character;->charCount(I)I

    move-result v0

    sub-int/2addr v5, v0

    .line 475
    :goto_1
    if-lez v5, :cond_4

    .line 476
    invoke-static {p0, v5}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v0

    .line 477
    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->isBlank(I)Z

    move-result v4

    if-nez v4, :cond_3

    .line 480
    :cond_4
    if-nez v5, :cond_5

    move v2, v3

    goto :goto_0

    .line 481
    :cond_5
    invoke-static {p0, v5}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v0

    if-eqz v0, :cond_6

    sub-int v2, v3, v5

    goto :goto_0

    .line 483
    :cond_6
    const/4 v0, -0x1

    move v4, v5

    .line 484
    :goto_2
    if-lez v4, :cond_8

    .line 485
    invoke-static {p0, v4}, Ljava/lang/Character;->codePointBefore(Ljava/lang/CharSequence;I)I

    move-result v6

    .line 486
    invoke-static {v6}, Ljava/lang/Character;->charCount(I)I

    move-result v7

    .line 487
    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isMark(I)Z

    move-result v8

    if-eqz v8, :cond_7

    .line 488
    sub-int/2addr v4, v7

    .line 489
    goto :goto_2

    .line 491
    :cond_7
    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isBlank(I)Z

    move-result v8

    if-nez v8, :cond_8

    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isBreak(I)Z

    move-result v8

    if-eqz v8, :cond_9

    .line 507
    :cond_8
    :goto_3
    sub-int v2, v3, v4

    goto :goto_0

    .line 492
    :cond_9
    invoke-static {v6}, Lcom/mrkeyboard/app/MrWordDelete;->isWord(I)Z

    move-result v8

    .line 493
    if-gez v0, :cond_c

    .line 494
    if-eqz v8, :cond_b

    move v0, v1

    .line 505
    :cond_a
    :goto_4
    sub-int/2addr v4, v7

    .line 506
    goto :goto_2

    :cond_b
    move v0, v2

    .line 494
    goto :goto_4

    .line 495
    :cond_c
    if-ne v0, v1, :cond_d

    if-nez v8, :cond_d

    .line 497
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

    .line 498
    sub-int/2addr v4, v7

    .line 499
    goto :goto_2

    .line 502
    :cond_d
    if-nez v0, :cond_a

    if-eqz v8, :cond_a

    goto :goto_3

    :cond_e
    move v5, v3

    goto :goto_1
.end method
