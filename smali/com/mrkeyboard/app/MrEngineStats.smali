.class final Lcom/mrkeyboard/app/MrEngineStats;
.super Ljava/lang/Object;
.source "MrEngineStats.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static block(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 17
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrEngineStats;->engineLine(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 18
    invoke-static {p0}, Lcom/mrkeyboard/app/MrEngineStats;->gestureLines(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 19
    if-nez v0, :cond_1

    move-object v0, v1

    .line 22
    :cond_0
    :goto_0
    return-object v0

    .line 20
    :cond_1
    if-eqz v1, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\n"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 21
    :catch_0
    move-exception v0

    .line 22
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static engineLine(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 28
    const-string v0, "mr_engine_title"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 29
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->ready()Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "mr_engine_native"

    :goto_0
    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 30
    if-eqz v1, :cond_0

    if-nez v0, :cond_2

    :cond_0
    const/4 v0, 0x0

    :goto_1
    return-object v0

    .line 29
    :cond_1
    const-string v0, "mr_engine_missing"

    goto :goto_0

    .line 30
    :cond_2
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ": "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method static gestureLines(Landroid/content/Context;)Ljava/lang/String;
    .locals 14

    .prologue
    const/4 v13, 0x4

    const/4 v12, 0x2

    const/4 v0, 0x0

    const/4 v11, 0x1

    const/4 v10, 0x0

    .line 39
    const-string v1, "mr_gesture_time_title"

    new-array v2, v10, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 40
    if-nez v3, :cond_1

    .line 66
    :cond_0
    :goto_0
    return-object v0

    .line 42
    :cond_1
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v2, "pref_gesture_typing"

    invoke-interface {v1, v2, v11}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "mr_gesture_time_off"

    .line 46
    :goto_1
    if-eqz v1, :cond_6

    move-object v2, v0

    .line 47
    :goto_2
    if-eqz v2, :cond_2

    aget-wide v4, v2, v10

    const-wide/16 v6, 0x0

    cmp-long v4, v4, v6

    if-gtz v4, :cond_2

    const-string v1, "mr_gesture_time_none"

    .line 48
    :cond_2
    if-eqz v1, :cond_7

    .line 49
    new-array v2, v10, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 50
    if-eqz v1, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ": "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 43
    :cond_3
    const-string v1, "gesture"

    const-string v2, "encoder.bin"

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->modelFile(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    if-nez v1, :cond_4

    const-string v1, "mr_gesture_time_nopack"

    goto :goto_1

    .line 44
    :cond_4
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->ready()Z

    move-result v1

    if-nez v1, :cond_5

    const-string v1, "mr_engine_missing"

    goto :goto_1

    .line 45
    :cond_5
    invoke-static {}, Lcom/mrkeyboard/app/MrGesture;->ready()Z

    move-result v1

    if-nez v1, :cond_a

    const-string v1, "mr_gesture_time_loading"

    goto :goto_1

    .line 46
    :cond_6
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->stats()[J

    move-result-object v2

    goto :goto_2

    .line 52
    :cond_7
    const-string v1, "mr_gesture_time_stats"

    new-array v4, v13, [Ljava/lang/Object;

    aget-wide v6, v2, v11

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v10

    aget-wide v6, v2, v12

    aget-wide v8, v2, v10

    div-long/2addr v6, v8

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v11

    const/4 v5, 0x3

    aget-wide v6, v2, v5

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v12

    const/4 v5, 0x3

    aget-wide v6, v2, v10

    const-wide/32 v8, 0x7fffffff

    .line 53
    invoke-static {v6, v7, v8, v9}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v6

    long-to-int v6, v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v4, v5

    .line 52
    invoke-static {p0, v1, v4}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 54
    if-eqz v1, :cond_0

    .line 55
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v3, ": "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 57
    aget-wide v4, v2, v13

    const-wide/16 v6, 0x0

    cmp-long v1, v4, v6

    if-lez v1, :cond_8

    .line 58
    const-string v1, "mr_gesture_time_preview"

    new-array v3, v12, [Ljava/lang/Object;

    const/4 v4, 0x5

    aget-wide v4, v2, v4

    aget-wide v6, v2, v13

    div-long/2addr v4, v6

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v10

    const/4 v4, 0x6

    aget-wide v4, v2, v4

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v3, v11

    invoke-static {p0, v1, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 59
    if-eqz v1, :cond_8

    const/16 v2, 0xa

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 61
    :cond_8
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureWords;->stats()[J

    move-result-object v1

    .line 62
    aget-wide v2, v1, v10

    const-wide/16 v4, 0x0

    cmp-long v2, v2, v4

    if-lez v2, :cond_9

    .line 63
    const-string v2, "mr_gesture_time_words"

    new-array v3, v12, [Ljava/lang/Object;

    aget-wide v4, v1, v10

    const-wide/32 v6, 0x7fffffff

    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v4

    long-to-int v4, v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v10

    aget-wide v4, v1, v11

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v1

    aput-object v1, v3, v11

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 64
    if-eqz v1, :cond_9

    const/16 v2, 0xa

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 66
    :cond_9
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :cond_a
    move-object v1, v0

    goto/16 :goto_1
.end method
