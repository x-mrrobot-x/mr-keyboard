.class final Lcom/mrkeyboard/app/MrDictMem;
.super Ljava/lang/Object;
.source "MrDictMem.java"


# static fields
.field static final ROW:Ljava/lang/String; = "mr_dict_mem"

.field private static sGeneration:I

.field private static sMain:Landroid/os/Handler;

.field static volatile sReads:I


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()I
    .locals 1

    .prologue
    .line 19
    sget v0, Lcom/mrkeyboard/app/MrDictMem;->sGeneration:I

    return v0
.end method

.method public static fill(Landroid/preference/PreferenceActivity;)V
    .locals 7

    .prologue
    .line 40
    :try_start_0
    const-string v0, "mr_dict_mem"

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v5

    .line 41
    if-nez v5, :cond_0

    .line 74
    :goto_0
    return-void

    .line 43
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrPacks;->activeDir()Ljava/io/File;

    move-result-object v2

    .line 44
    sget v0, Lcom/mrkeyboard/app/MrDictMem;->sGeneration:I

    add-int/lit8 v4, v0, 0x1

    sput v4, Lcom/mrkeyboard/app/MrDictMem;->sGeneration:I

    .line 45
    if-nez v2, :cond_1

    .line 46
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrDictMem;->text(Landroid/content/Context;Lcom/mrkeyboard/app/MrDiag$Report;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 71
    :catch_0
    move-exception v0

    goto :goto_0

    .line 49
    :cond_1
    const-string v0, "mr_mem_wait"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrDictMem;->string(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 50
    invoke-static {}, Lcom/mrkeyboard/app/MrDictMem;->main()Landroid/os/Handler;

    move-result-object v3

    .line 51
    new-instance v6, Ljava/lang/Thread;

    new-instance v0, Lcom/mrkeyboard/app/MrDictMem$1;

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrDictMem$1;-><init>(Landroid/preference/PreferenceActivity;Ljava/io/File;Landroid/os/Handler;ILandroid/preference/Preference;)V

    const-string v1, "MrDiag"

    invoke-direct {v6, v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 68
    const/4 v0, 0x1

    invoke-virtual {v6, v0}, Ljava/lang/Thread;->setPriority(I)V

    .line 69
    sget v0, Lcom/mrkeyboard/app/MrDictMem;->sReads:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrDictMem;->sReads:I

    .line 70
    invoke-virtual {v6}, Ljava/lang/Thread;->start()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0
.end method

.method static main()Landroid/os/Handler;
    .locals 2

    .prologue
    .line 33
    sget-object v0, Lcom/mrkeyboard/app/MrDictMem;->sMain:Landroid/os/Handler;

    if-nez v0, :cond_0

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/mrkeyboard/app/MrDictMem;->sMain:Landroid/os/Handler;

    .line 34
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrDictMem;->sMain:Landroid/os/Handler;

    return-object v0
.end method

.method private static varargs string(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 96
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 97
    if-eqz v0, :cond_0

    move-object p1, v0

    :cond_0
    return-object p1
.end method

.method static text(Landroid/content/Context;Lcom/mrkeyboard/app/MrDiag$Report;)Ljava/lang/String;
    .locals 11

    .prologue
    const/4 v10, 0x3

    const/16 v9, 0xa

    const/4 v8, 0x2

    const/4 v7, 0x1

    const/4 v6, 0x0

    .line 78
    if-nez p1, :cond_0

    const-string v0, "mr_mem_none"

    new-array v1, v6, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrDictMem;->string(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 91
    :goto_0
    return-object v0

    .line 79
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 80
    const-string v1, "mr_mem_dict"

    const/4 v2, 0x5

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p1, Lcom/mrkeyboard/app/MrDiag$Report;->id:Ljava/lang/String;

    aput-object v3, v2, v6

    iget v3, p1, Lcom/mrkeyboard/app/MrDiag$Report;->version:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v7

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->dictBytes:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v8

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->dictMem:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v10

    const/4 v3, 0x4

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->dictNs:J

    .line 81
    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v3

    .line 80
    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrDictMem;->string(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 82
    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 83
    iget-boolean v1, p1, Lcom/mrkeyboard/app/MrDiag$Report;->hasTri:Z

    if-eqz v1, :cond_2

    .line 84
    const-string v1, "mr_mem_tri"

    const/4 v2, 0x4

    new-array v2, v2, [Ljava/lang/Object;

    iget v3, p1, Lcom/mrkeyboard/app/MrDiag$Report;->triFormat:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v6

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->triBytes:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v7

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->triMem:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v8

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->triNs:J

    .line 85
    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v10

    .line 84
    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrDictMem;->string(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 89
    :goto_1
    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "mr_mem_engine"

    new-array v3, v8, [Ljava/lang/Object;

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->engineNs:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v6

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->rulesNs:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v7

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrDictMem;->string(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 90
    iget-wide v2, p1, Lcom/mrkeyboard/app/MrDiag$Report;->dictMem:J

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-gez v1, :cond_1

    iget-wide v2, p1, Lcom/mrkeyboard/app/MrDiag$Report;->triMem:J

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-gez v1, :cond_1

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "mr_mem_nomem"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrDictMem;->string(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 91
    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 87
    :cond_2
    const-string v1, "mr_mem_tri_none"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrDictMem;->string(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1
.end method
