.class final Lcom/mrkeyboard/app/MrLive;
.super Ljava/lang/Object;
.source "MrLive.java"


# static fields
.field static sMeasured:Z

.field private static final sServiceRefs:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/ref/WeakReference",
            "<",
            "Ljava/lang/Object;",
            ">;>;"
        }
    .end annotation
.end field

.field static sServices:I

.field private static final sViewRefs:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/ref/WeakReference",
            "<",
            "Ljava/lang/Object;",
            ">;>;"
        }
    .end annotation
.end field

.field static sViews:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 18
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrLive;->sServiceRefs:Ljava/util/ArrayList;

    .line 19
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrLive;->sViewRefs:Ljava/util/ArrayList;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static alive(Ljava/util/ArrayList;)I
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/ref/WeakReference",
            "<",
            "Ljava/lang/Object;",
            ">;>;)I"
        }
    .end annotation

    .prologue
    .line 52
    const/4 v1, 0x0

    .line 53
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v2, v0

    :goto_0
    if-ltz v2, :cond_1

    .line 54
    invoke-virtual {p0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-virtual {p0, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move v0, v1

    .line 53
    :goto_1
    add-int/lit8 v1, v2, -0x1

    move v2, v1

    move v1, v0

    goto :goto_0

    .line 55
    :cond_0
    add-int/lit8 v0, v1, 0x1

    goto :goto_1

    .line 57
    :cond_1
    return v1
.end method

.method static declared-synchronized forget()V
    .locals 2

    .prologue
    .line 69
    const-class v0, Lcom/mrkeyboard/app/MrLive;

    monitor-enter v0

    const/4 v1, 0x0

    :try_start_0
    sput-boolean v1, Lcom/mrkeyboard/app/MrLive;->sMeasured:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 70
    monitor-exit v0

    return-void

    .line 69
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method static declared-synchronized measure()V
    .locals 2

    .prologue
    .line 62
    const-class v1, Lcom/mrkeyboard/app/MrLive;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrLive;->sServiceRefs:Ljava/util/ArrayList;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLive;->alive(Ljava/util/ArrayList;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrLive;->sServices:I

    .line 63
    sget-object v0, Lcom/mrkeyboard/app/MrLive;->sViewRefs:Ljava/util/ArrayList;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLive;->alive(Ljava/util/ArrayList;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrLive;->sViews:I

    .line 64
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrLive;->sMeasured:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 65
    monitor-exit v1

    return-void

    .line 62
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static declared-synchronized service(Ljava/lang/Object;)V
    .locals 2

    .prologue
    .line 30
    const-class v1, Lcom/mrkeyboard/app/MrLive;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrLive;->sServiceRefs:Ljava/util/ArrayList;

    invoke-static {v0, p0}, Lcom/mrkeyboard/app/MrLive;->watch(Ljava/util/ArrayList;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 31
    monitor-exit v1

    return-void

    .line 30
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static declared-synchronized view(Ljava/lang/Object;)V
    .locals 2

    .prologue
    .line 35
    const-class v1, Lcom/mrkeyboard/app/MrLive;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrLive;->sViewRefs:Ljava/util/ArrayList;

    invoke-static {v0, p0}, Lcom/mrkeyboard/app/MrLive;->watch(Ljava/util/ArrayList;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 36
    monitor-exit v1

    return-void

    .line 35
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private static watch(Ljava/util/ArrayList;Ljava/lang/Object;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/ref/WeakReference",
            "<",
            "Ljava/lang/Object;",
            ">;>;",
            "Ljava/lang/Object;",
            ")V"
        }
    .end annotation

    .prologue
    .line 39
    if-nez p1, :cond_0

    .line 49
    :goto_0
    return-void

    .line 40
    :cond_0
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v0

    :goto_1
    if-ltz v1, :cond_3

    .line 41
    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    .line 42
    if-nez v0, :cond_2

    .line 43
    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 40
    :cond_1
    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_1

    .line 44
    :cond_2
    if-ne v0, p1, :cond_1

    goto :goto_0

    .line 48
    :cond_3
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    invoke-virtual {p0, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method
