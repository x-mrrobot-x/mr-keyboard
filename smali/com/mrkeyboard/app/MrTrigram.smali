.class public final Lcom/mrkeyboard/app/MrTrigram;
.super Ljava/lang/Object;
.source "MrTrigram.java"


# static fields
.field private static final NATIVE_LOAD:Ljava/lang/Object;

.field private static sGen:I

.field private static sNative:Z

.field private static sPath:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 23
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrTrigram;->NATIVE_LOAD:Ljava/lang/Object;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;I)Z
    .locals 1

    .prologue
    .line 17
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrTrigram;->open(Ljava/lang/String;I)Z

    move-result v0

    return v0
.end method

.method static declared-synchronized find(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[I)I
    .locals 7

    .prologue
    .line 88
    const-class v6, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v6

    :try_start_0
    sget-boolean v0, Lcom/mrkeyboard/app/MrTrigram;->sNative:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 89
    :goto_0
    monitor-exit v6

    return v0

    :cond_1
    :try_start_1
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v3

    move-object v0, p0

    move-object v2, p1

    move-object v4, p2

    move-object v5, p3

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrNative;->triFind(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[I)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v0

    goto :goto_0

    .line 88
    :catchall_0
    move-exception v0

    monitor-exit v6

    throw v0
.end method

.method private static open(Ljava/lang/String;I)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 64
    sget-object v1, Lcom/mrkeyboard/app/MrTrigram;->NATIVE_LOAD:Ljava/lang/Object;

    monitor-enter v1

    .line 65
    :try_start_0
    const-class v2, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 66
    :try_start_1
    sget v3, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    if-eq p1, v3, :cond_0

    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 74
    :goto_0
    return v0

    .line 67
    :cond_0
    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 68
    :try_start_4
    invoke-static {p0}, Lcom/mrkeyboard/app/MrNative;->triOpen(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 69
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->triClose()V

    .line 70
    monitor-exit v1

    goto :goto_0

    .line 76
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw v0

    .line 67
    :catchall_1
    move-exception v0

    :try_start_5
    monitor-exit v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    :try_start_6
    throw v0

    .line 72
    :cond_1
    const-class v2, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v2
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 73
    :try_start_7
    sget v0, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    if-ne p1, v0, :cond_2

    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrTrigram;->sNative:Z

    .line 74
    :cond_2
    sget-boolean v0, Lcom/mrkeyboard/app/MrTrigram;->sNative:Z

    monitor-exit v2
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    :try_start_8
    monitor-exit v1
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    goto :goto_0

    .line 75
    :catchall_2
    move-exception v0

    :try_start_9
    monitor-exit v2
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    :try_start_a
    throw v0
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_0
.end method

.method static declared-synchronized ready()Z
    .locals 2

    .prologue
    .line 80
    const-class v0, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v0

    :try_start_0
    sget-boolean v1, Lcom/mrkeyboard/app/MrTrigram;->sNative:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method static use(Ljava/io/File;)V
    .locals 4

    .prologue
    .line 27
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    .line 29
    :goto_0
    const-class v1, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v1

    .line 30
    if-nez v0, :cond_2

    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrTrigram;->sPath:Ljava/lang/String;

    if-nez v2, :cond_3

    :cond_0
    monitor-exit v1

    .line 46
    :goto_1
    return-void

    .line 27
    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    .line 30
    :cond_2
    sget-object v2, Lcom/mrkeyboard/app/MrTrigram;->sPath:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 31
    :cond_3
    sput-object v0, Lcom/mrkeyboard/app/MrTrigram;->sPath:Ljava/lang/String;

    .line 32
    sget v2, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    add-int/lit8 v2, v2, 0x1

    sput v2, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    .line 33
    const/4 v3, 0x0

    sput-boolean v3, Lcom/mrkeyboard/app/MrTrigram;->sNative:Z

    .line 34
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 35
    if-nez v0, :cond_4

    .line 36
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->triClose()V

    goto :goto_1

    .line 34
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 39
    :cond_4
    new-instance v1, Ljava/lang/Thread;

    new-instance v3, Lcom/mrkeyboard/app/MrTrigram$1;

    invoke-direct {v3, v0, v2}, Lcom/mrkeyboard/app/MrTrigram$1;-><init>(Ljava/lang/String;I)V

    const-string v0, "MrTrigram"

    invoke-direct {v1, v3, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 44
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Ljava/lang/Thread;->setPriority(I)V

    .line 45
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_1
.end method

.method static useNow(Ljava/io/File;)Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 50
    invoke-static {v1}, Lcom/mrkeyboard/app/MrTrigram;->use(Ljava/io/File;)V

    .line 51
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    .line 52
    :cond_0
    if-nez v1, :cond_1

    .line 59
    :goto_0
    return v0

    .line 54
    :cond_1
    const-class v2, Lcom/mrkeyboard/app/MrTrigram;

    monitor-enter v2

    .line 55
    :try_start_0
    sput-object v1, Lcom/mrkeyboard/app/MrTrigram;->sPath:Ljava/lang/String;

    .line 56
    sget v0, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrTrigram;->sGen:I

    .line 57
    const/4 v3, 0x0

    sput-boolean v3, Lcom/mrkeyboard/app/MrTrigram;->sNative:Z

    .line 58
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 59
    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrTrigram;->open(Ljava/lang/String;I)Z

    move-result v0

    goto :goto_0

    .line 58
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method
