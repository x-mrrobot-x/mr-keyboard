.class public final Lcom/mrkeyboard/app/MrApp;
.super Ljava/lang/Object;
.source "MrApp.java"


# static fields
.field private static final DIC_TYPE:I = 0x3

.field static final MAX_PAIRS:I = 0x2710

.field static final MAX_WORDS:I = 0x1388

.field private static final MIN_FREQ:I = 0x6

.field static final SEP:C = '|'

.field private static sApps:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field static volatile sBuilds:I

.field private static sCtx:Landroid/content/Context;

.field private static volatile sDict:Lcom/mrkeyboard/app/ExpandableDictionary;

.field private static sGen:I

.field private static sLocale:Ljava/lang/String;

.field private static sPkg:Ljava/lang/String;

.field private static sRunning:Z


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()V
    .locals 0

    .prologue
    .line 31
    invoke-static {}, Lcom/mrkeyboard/app/MrApp;->work()V

    return-void
.end method

.method static build(Lcom/mrkeyboard/app/MrWordStore;Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Lcom/mrkeyboard/app/ExpandableDictionary;
    .locals 5

    .prologue
    const/4 v4, 0x3

    .line 227
    invoke-static {p2, p3}, Lcom/mrkeyboard/app/MrApp;->scope(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 228
    const/4 v1, 0x2

    invoke-interface {p0, v1, v0}, Lcom/mrkeyboard/app/MrWordStore;->all(ILjava/lang/String;)Ljava/util/List;

    move-result-object v2

    .line 229
    invoke-interface {p0, v4, v0}, Lcom/mrkeyboard/app/MrWordStore;->all(ILjava/lang/String;)Ljava/util/List;

    move-result-object v3

    .line 230
    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    .line 241
    :goto_0
    return-object v0

    .line 232
    :cond_0
    new-instance v1, Lcom/mrkeyboard/app/ExpandableDictionary;

    invoke-direct {v1, p1, v4}, Lcom/mrkeyboard/app/ExpandableDictionary;-><init>(Landroid/content/Context;I)V

    .line 233
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_1
    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    .line 234
    iget-object v4, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    if-eqz v4, :cond_1

    iget-object v4, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    invoke-static {v4}, Lcom/mrkeyboard/app/MrLearned;->isBlocked(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_1

    iget-object v4, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    iget v0, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->wordFreq(I)I

    move-result v0

    invoke-virtual {v1, v4, v0}, Lcom/mrkeyboard/app/ExpandableDictionary;->addWord(Ljava/lang/String;I)V

    goto :goto_1

    .line 236
    :cond_2
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_3
    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    .line 237
    iget-object v3, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    if-eqz v3, :cond_3

    iget-object v3, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    if-eqz v3, :cond_3

    iget-object v3, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    invoke-static {v3}, Lcom/mrkeyboard/app/MrLearned;->isBlocked(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_3

    iget-object v3, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    invoke-static {v3}, Lcom/mrkeyboard/app/MrLearned;->isBlocked(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 238
    iget-object v3, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    iget-object v4, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    iget v0, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->pairFreq(I)I

    move-result v0

    invoke-virtual {v1, v3, v4, v0}, Lcom/mrkeyboard/app/ExpandableDictionary;->setBigram(Ljava/lang/String;Ljava/lang/String;I)I

    goto :goto_2

    :cond_4
    move-object v0, v1

    .line 241
    goto :goto_0
.end method

.method static declared-synchronized current()Ljava/lang/String;
    .locals 2

    .prologue
    .line 276
    const-class v0, Lcom/mrkeyboard/app/MrApp;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/mrkeyboard/app/MrApp;->sPkg:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method static dataChanged()V
    .locals 2

    .prologue
    .line 136
    :try_start_0
    const-class v1, Lcom/mrkeyboard/app/MrApp;

    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 137
    const/4 v0, 0x0

    :try_start_1
    sput-object v0, Lcom/mrkeyboard/app/MrApp;->sApps:Ljava/util/HashSet;

    .line 138
    sget-object v0, Lcom/mrkeyboard/app/MrApp;->sPkg:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrApp;->sCtx:Landroid/content/Context;

    if-nez v0, :cond_1

    :cond_0
    monitor-exit v1

    .line 144
    :goto_0
    return-void

    .line 139
    :cond_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 140
    :try_start_2
    invoke-static {}, Lcom/mrkeyboard/app/MrApp;->request()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 141
    :catch_0
    move-exception v0

    goto :goto_0

    .line 139
    :catchall_0
    move-exception v0

    :try_start_3
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw v0
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0
.end method

.method static dictionary()Lcom/mrkeyboard/app/ExpandableDictionary;
    .locals 1

    .prologue
    .line 271
    sget-object v0, Lcom/mrkeyboard/app/MrApp;->sDict:Lcom/mrkeyboard/app/ExpandableDictionary;

    return-object v0
.end method

.method private static drop()V
    .locals 1

    .prologue
    .line 148
    sget v0, Lcom/mrkeyboard/app/MrApp;->sGen:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrApp;->sGen:I

    .line 149
    sget-object v0, Lcom/mrkeyboard/app/MrApp;->sDict:Lcom/mrkeyboard/app/ExpandableDictionary;

    if-eqz v0, :cond_0

    .line 150
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrApp;->sDict:Lcom/mrkeyboard/app/ExpandableDictionary;

    .line 151
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureWords;->changed()V

    .line 153
    :cond_0
    return-void
.end method

.method public static getBigrams(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;Lcom/mrkeyboard/app/Dictionary$WordCallback;[I)V
    .locals 1

    .prologue
    .line 264
    sget-object v0, Lcom/mrkeyboard/app/MrApp;->sDict:Lcom/mrkeyboard/app/ExpandableDictionary;

    .line 265
    if-nez v0, :cond_0

    .line 267
    :goto_0
    return-void

    .line 266
    :cond_0
    invoke-virtual {v0, p0, p1, p2, p3}, Lcom/mrkeyboard/app/ExpandableDictionary;->getBigrams(Lcom/mrkeyboard/app/WordComposer;Ljava/lang/CharSequence;Lcom/mrkeyboard/app/Dictionary$WordCallback;[I)V

    goto :goto_0
.end method

.method static idle(J)Z
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 306
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    add-long/2addr v2, p0

    .line 307
    :goto_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    cmp-long v1, v4, v2

    if-gez v1, :cond_0

    .line 308
    const-class v1, Lcom/mrkeyboard/app/MrApp;

    monitor-enter v1

    .line 309
    :try_start_0
    sget-boolean v4, Lcom/mrkeyboard/app/MrApp;->sRunning:Z

    if-nez v4, :cond_1

    const/4 v0, 0x1

    monitor-exit v1

    .line 317
    :cond_0
    :goto_1
    return v0

    .line 310
    :cond_1
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 312
    const-wide/16 v4, 0x2

    :try_start_1
    invoke-static {v4, v5}, Ljava/lang/Thread;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 313
    :catch_0
    move-exception v1

    goto :goto_1

    .line 310
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method static isScope(Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 53
    if-eqz p0, :cond_0

    const/16 v0, 0x7c

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isValid(Ljava/lang/CharSequence;)Z
    .locals 2

    .prologue
    .line 258
    sget-object v0, Lcom/mrkeyboard/app/MrApp;->sDict:Lcom/mrkeyboard/app/ExpandableDictionary;

    .line 259
    if-eqz v0, :cond_0

    if-eqz p0, :cond_0

    invoke-virtual {v0, p0}, Lcom/mrkeyboard/app/ExpandableDictionary;->getWordFrequency(Ljava/lang/CharSequence;)I

    move-result v0

    const/4 v1, 0x6

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static localeOf(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 58
    if-nez p0, :cond_0

    const/4 v0, -0x1

    .line 59
    :goto_0
    if-gez v0, :cond_1

    :goto_1
    return-object p0

    .line 58
    :cond_0
    const/16 v0, 0x7c

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    goto :goto_0

    .line 59
    :cond_1
    const/4 v1, 0x0

    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    goto :goto_1
.end method

.method public static onInput(Landroid/content/Context;Landroid/view/inputmethod/EditorInfo;)V
    .locals 3

    .prologue
    .line 99
    if-nez p1, :cond_1

    const/4 v0, 0x0

    .line 100
    :goto_0
    if-eqz v0, :cond_0

    :try_start_0
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_2

    .line 112
    :cond_0
    :goto_1
    return-void

    .line 99
    :cond_1
    iget-object v0, p1, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;

    goto :goto_0

    .line 101
    :cond_2
    const-class v1, Lcom/mrkeyboard/app/MrApp;

    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 102
    :try_start_1
    sget-object v2, Lcom/mrkeyboard/app/MrApp;->sPkg:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    monitor-exit v1

    goto :goto_1

    .line 107
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    .line 109
    :catch_0
    move-exception v0

    goto :goto_1

    .line 103
    :cond_3
    :try_start_3
    sput-object v0, Lcom/mrkeyboard/app/MrApp;->sPkg:Ljava/lang/String;

    .line 104
    sget-object v2, Lcom/mrkeyboard/app/MrApp;->sCtx:Landroid/content/Context;

    if-nez v2, :cond_4

    if-eqz p0, :cond_4

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrApp;->sCtx:Landroid/content/Context;

    .line 105
    :cond_4
    invoke-static {}, Lcom/mrkeyboard/app/MrApp;->drop()V

    .line 106
    sget-object v2, Lcom/mrkeyboard/app/MrApp;->sApps:Ljava/util/HashSet;

    if-eqz v2, :cond_5

    sget-object v2, Lcom/mrkeyboard/app/MrApp;->sApps:Ljava/util/HashSet;

    invoke-virtual {v2, v0}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    monitor-exit v1

    goto :goto_1

    .line 107
    :cond_5
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 108
    :try_start_4
    invoke-static {}, Lcom/mrkeyboard/app/MrApp;->request()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0

    goto :goto_1
.end method

.method static onLoad(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 120
    if-nez p1, :cond_0

    .line 131
    :goto_0
    return-void

    .line 121
    :cond_0
    :try_start_0
    const-class v1, Lcom/mrkeyboard/app/MrApp;

    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 122
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrApp;->sCtx:Landroid/content/Context;

    if-nez v0, :cond_1

    if-eqz p0, :cond_1

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrApp;->sCtx:Landroid/content/Context;

    .line 123
    :cond_1
    sput-object p1, Lcom/mrkeyboard/app/MrApp;->sLocale:Ljava/lang/String;

    .line 124
    sget-object v0, Lcom/mrkeyboard/app/MrApp;->sPkg:Ljava/lang/String;

    if-nez v0, :cond_2

    monitor-exit v1

    goto :goto_0

    .line 126
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    .line 128
    :catch_0
    move-exception v0

    goto :goto_0

    .line 125
    :cond_2
    :try_start_3
    sget-object v0, Lcom/mrkeyboard/app/MrApp;->sApps:Ljava/util/HashSet;

    if-eqz v0, :cond_3

    sget-object v0, Lcom/mrkeyboard/app/MrApp;->sApps:Ljava/util/HashSet;

    sget-object v2, Lcom/mrkeyboard/app/MrApp;->sPkg:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    monitor-exit v1

    goto :goto_0

    .line 126
    :cond_3
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 127
    :try_start_4
    invoke-static {}, Lcom/mrkeyboard/app/MrApp;->request()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0

    goto :goto_0
.end method

.method static packageOf(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 64
    if-nez p0, :cond_0

    const/4 v0, -0x1

    .line 65
    :goto_0
    if-gez v0, :cond_1

    const/4 v0, 0x0

    :goto_1
    return-object v0

    .line 64
    :cond_0
    const/16 v0, 0x7c

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    goto :goto_0

    .line 65
    :cond_1
    add-int/lit8 v0, v0, 0x1

    invoke-virtual {p0, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method static packages(Ljava/util/List;)Ljava/util/HashSet;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/HashSet",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 216
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    .line 217
    if-nez p0, :cond_0

    move-object v0, v1

    .line 222
    :goto_0
    return-object v0

    .line 218
    :cond_0
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_1
    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 219
    invoke-static {v0}, Lcom/mrkeyboard/app/MrApp;->packageOf(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 220
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_1

    invoke-virtual {v1, v0}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_2
    move-object v0, v1

    .line 222
    goto :goto_0
.end method

.method private static request()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    .line 157
    const-class v1, Lcom/mrkeyboard/app/MrApp;

    monitor-enter v1

    .line 158
    :try_start_0
    sget v0, Lcom/mrkeyboard/app/MrApp;->sGen:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrApp;->sGen:I

    .line 159
    sget-boolean v0, Lcom/mrkeyboard/app/MrApp;->sRunning:Z

    if-eqz v0, :cond_0

    monitor-exit v1

    .line 169
    :goto_0
    return-void

    .line 160
    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrApp;->sRunning:Z

    .line 161
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 162
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/mrkeyboard/app/MrApp$1;

    invoke-direct {v1}, Lcom/mrkeyboard/app/MrApp$1;-><init>()V

    const-string v2, "MrApp"

    invoke-direct {v0, v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 167
    invoke-virtual {v0, v3}, Ljava/lang/Thread;->setPriority(I)V

    .line 168
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    goto :goto_0

    .line 161
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method static resetForTest()V
    .locals 4

    .prologue
    .line 281
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    const-wide/16 v2, 0x2710

    add-long/2addr v0, v2

    .line 282
    :goto_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    cmp-long v2, v2, v0

    if-gez v2, :cond_0

    .line 283
    const-class v2, Lcom/mrkeyboard/app/MrApp;

    monitor-enter v2

    .line 284
    :try_start_0
    sget-boolean v3, Lcom/mrkeyboard/app/MrApp;->sRunning:Z

    if-nez v3, :cond_1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 292
    :cond_0
    :goto_1
    const-class v1, Lcom/mrkeyboard/app/MrApp;

    monitor-enter v1

    .line 293
    const/4 v0, 0x0

    :try_start_1
    sput-object v0, Lcom/mrkeyboard/app/MrApp;->sPkg:Ljava/lang/String;

    .line 294
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrApp;->sLocale:Ljava/lang/String;

    .line 295
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrApp;->sCtx:Landroid/content/Context;

    .line 296
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrApp;->sApps:Ljava/util/HashSet;

    .line 297
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrApp;->sDict:Lcom/mrkeyboard/app/ExpandableDictionary;

    .line 298
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrApp;->sGen:I

    .line 299
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrApp;->sRunning:Z

    .line 300
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrApp;->sBuilds:I

    .line 301
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 302
    return-void

    .line 285
    :cond_1
    :try_start_2
    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 287
    const-wide/16 v2, 0x2

    :try_start_3
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_3
    .catch Ljava/lang/InterruptedException; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_0

    .line 288
    :catch_0
    move-exception v0

    goto :goto_1

    .line 285
    :catchall_0
    move-exception v0

    :try_start_4
    monitor-exit v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw v0

    .line 301
    :catchall_1
    move-exception v0

    :try_start_5
    monitor-exit v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    throw v0
.end method

.method static scope(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 48
    if-nez p1, :cond_0

    :goto_0
    return-object p0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7c

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    goto :goto_0
.end method

.method static validPackage(Ljava/lang/String;)Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 70
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v2, 0xff

    if-le v0, v2, :cond_1

    .line 75
    :cond_0
    :goto_0
    return v1

    :cond_1
    move v0, v1

    .line 71
    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v0, v2, :cond_6

    .line 72
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 73
    const/16 v3, 0x61

    if-lt v2, v3, :cond_2

    const/16 v3, 0x7a

    if-le v2, v3, :cond_5

    :cond_2
    const/16 v3, 0x41

    if-lt v2, v3, :cond_3

    const/16 v3, 0x5a

    if-le v2, v3, :cond_5

    :cond_3
    const/16 v3, 0x30

    if-lt v2, v3, :cond_4

    const/16 v3, 0x39

    if-le v2, v3, :cond_5

    :cond_4
    const/16 v3, 0x2e

    if-eq v2, v3, :cond_5

    const/16 v3, 0x5f

    if-ne v2, v3, :cond_0

    .line 71
    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 75
    :cond_6
    const/4 v1, 0x1

    goto :goto_0
.end method

.method public static words(Lcom/mrkeyboard/app/WordComposer;Lcom/mrkeyboard/app/Dictionary$WordCallback;[I)V
    .locals 1

    .prologue
    .line 251
    sget-object v0, Lcom/mrkeyboard/app/MrApp;->sDict:Lcom/mrkeyboard/app/ExpandableDictionary;

    .line 252
    if-nez v0, :cond_0

    .line 254
    :goto_0
    return-void

    .line 253
    :cond_0
    invoke-virtual {v0, p0, p1, p2}, Lcom/mrkeyboard/app/ExpandableDictionary;->getWords(Lcom/mrkeyboard/app/WordComposer;Lcom/mrkeyboard/app/Dictionary$WordCallback;[I)V

    goto :goto_0
.end method

.method private static work()V
    .locals 8

    .prologue
    const/4 v1, 0x0

    .line 178
    :goto_0
    :try_start_0
    const-class v2, Lcom/mrkeyboard/app/MrApp;

    monitor-enter v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 179
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrApp;->sPkg:Ljava/lang/String;

    .line 180
    sget-object v3, Lcom/mrkeyboard/app/MrApp;->sLocale:Ljava/lang/String;

    .line 181
    sget v4, Lcom/mrkeyboard/app/MrApp;->sGen:I

    .line 182
    sget-object v5, Lcom/mrkeyboard/app/MrApp;->sCtx:Landroid/content/Context;

    .line 183
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 187
    :try_start_2
    invoke-static {v5}, Lcom/mrkeyboard/app/MrLearned;->store(Landroid/content/Context;)Lcom/mrkeyboard/app/MrWordStore;

    move-result-object v6

    .line 188
    if-eqz v6, :cond_4

    .line 189
    invoke-interface {v6}, Lcom/mrkeyboard/app/MrWordStore;->scopes()Ljava/util/List;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrApp;->packages(Ljava/util/List;)Ljava/util/HashSet;

    move-result-object v2

    .line 190
    if-eqz v0, :cond_3

    if-eqz v3, :cond_3

    invoke-virtual {v2, v0}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_3

    invoke-static {v6, v5, v3, v0}, Lcom/mrkeyboard/app/MrApp;->build(Lcom/mrkeyboard/app/MrWordStore;Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Lcom/mrkeyboard/app/ExpandableDictionary;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    move-result-object v0

    .line 196
    :goto_1
    :try_start_3
    const-class v3, Lcom/mrkeyboard/app/MrApp;

    monitor-enter v3
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    .line 197
    :try_start_4
    sget v5, Lcom/mrkeyboard/app/MrApp;->sGen:I

    if-eq v4, v5, :cond_0

    monitor-exit v3

    goto :goto_0

    .line 205
    :catchall_0
    move-exception v0

    monitor-exit v3
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :try_start_5
    throw v0
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_0

    .line 207
    :catch_0
    move-exception v0

    .line 208
    const-class v1, Lcom/mrkeyboard/app/MrApp;

    monitor-enter v1

    .line 209
    const/4 v0, 0x0

    :try_start_6
    sput-boolean v0, Lcom/mrkeyboard/app/MrApp;->sRunning:Z

    .line 210
    monitor-exit v1
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 212
    :goto_2
    return-void

    .line 183
    :catchall_1
    move-exception v0

    :try_start_7
    monitor-exit v2
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    :try_start_8
    throw v0
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_0

    .line 192
    :catch_1
    move-exception v0

    move-object v0, v1

    move-object v2, v1

    .line 194
    goto :goto_1

    .line 198
    :cond_0
    :try_start_9
    sput-object v2, Lcom/mrkeyboard/app/MrApp;->sApps:Ljava/util/HashSet;

    .line 199
    sget-object v1, Lcom/mrkeyboard/app/MrApp;->sDict:Lcom/mrkeyboard/app/ExpandableDictionary;

    .line 200
    sput-object v0, Lcom/mrkeyboard/app/MrApp;->sDict:Lcom/mrkeyboard/app/ExpandableDictionary;

    .line 201
    if-nez v1, :cond_1

    if-eqz v0, :cond_2

    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureWords;->changed()V

    .line 202
    :cond_2
    sget v0, Lcom/mrkeyboard/app/MrApp;->sBuilds:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrApp;->sBuilds:I

    .line 203
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrApp;->sRunning:Z

    .line 204
    monitor-exit v3
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    goto :goto_2

    .line 210
    :catchall_2
    move-exception v0

    :try_start_a
    monitor-exit v1
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_2

    throw v0

    :cond_3
    move-object v0, v1

    goto :goto_1

    :cond_4
    move-object v0, v1

    move-object v2, v1

    goto :goto_1
.end method
