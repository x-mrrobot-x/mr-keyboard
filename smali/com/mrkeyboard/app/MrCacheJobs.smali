.class final Lcom/mrkeyboard/app/MrCacheJobs;
.super Ljava/lang/Object;
.source "MrCacheJobs.java"


# static fields
.field private static cleanup:Ljava/util/concurrent/ThreadPoolExecutor;


# direct methods
.method constructor <init>()V
    .registers 1

    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static awaitQuiet([Ljava/util/concurrent/ExecutorService;)Z
    .registers 12

    .line 14
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v0

    sget-object v2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v3, 0xa

    invoke-virtual {v2, v3, v4}, Ljava/util/concurrent/TimeUnit;->toNanos(J)J

    move-result-wide v5

    add-long/2addr v0, v5

    .line 15
    :goto_d
    array-length v2, p0

    const/4 v5, 0x1

    const/4 v6, 0x0

    move v8, v5

    move v7, v6

    :goto_12
    if-ge v7, v2, :cond_3a

    aget-object v9, p0, v7

    instance-of v10, v9, Ljava/util/concurrent/ThreadPoolExecutor;

    if-eqz v10, :cond_2e

    check-cast v9, Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v9}, Ljava/util/concurrent/ThreadPoolExecutor;->getActiveCount()I

    move-result v10

    if-nez v10, :cond_2c

    invoke-virtual {v9}, Ljava/util/concurrent/ThreadPoolExecutor;->getQueue()Ljava/util/concurrent/BlockingQueue;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/concurrent/BlockingQueue;->isEmpty()Z

    move-result v9

    if-nez v9, :cond_37

    :cond_2c
    move v8, v6

    goto :goto_37

    :cond_2e
    if-eqz v9, :cond_37

    invoke-interface {v9}, Ljava/util/concurrent/ExecutorService;->isTerminated()Z

    move-result v9

    if-nez v9, :cond_37

    move v8, v6

    :cond_37
    :goto_37
    add-int/lit8 v7, v7, 0x1

    goto :goto_12

    .line 16
    :cond_3a
    if-eqz v8, :cond_3d

    return v5

    :cond_3d
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v7

    cmp-long v2, v7, v0

    if-ltz v2, :cond_46

    return v6

    .line 17
    :cond_46
    :try_start_46
    invoke-static {v3, v4}, Ljava/lang/Thread;->sleep(J)V
    :try_end_49
    .catch Ljava/lang/InterruptedException; {:try_start_46 .. :try_end_49} :catch_4a

    .line 18
    goto :goto_d

    .line 17
    :catch_4a
    move-exception p0

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Thread;->interrupt()V

    return v6
.end method

.method static cancel(Ljava/util/concurrent/ExecutorService;)V
    .registers 2

    .line 10
    instance-of v0, p0, Lcom/mrkeyboard/app/MrReusablePool;

    if-eqz v0, :cond_a

    check-cast p0, Lcom/mrkeyboard/app/MrReusablePool;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrReusablePool;->cancelCurrent()V

    goto :goto_17

    .line 11
    :cond_a
    instance-of v0, p0, Ljava/util/concurrent/ThreadPoolExecutor;

    if-eqz v0, :cond_17

    check-cast p0, Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {p0}, Ljava/util/concurrent/ThreadPoolExecutor;->getQueue()Ljava/util/concurrent/BlockingQueue;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/concurrent/BlockingQueue;->clear()V

    .line 12
    :cond_17
    :goto_17
    return-void
.end method

.method static declared-synchronized execute(Ljava/lang/Runnable;)Z
    .registers 11

    const-class v0, Lcom/mrkeyboard/app/MrCacheJobs;

    monitor-enter v0

    .line 6
    :try_start_3
    sget-object v1, Lcom/mrkeyboard/app/MrCacheJobs;->cleanup:Ljava/util/concurrent/ThreadPoolExecutor;

    const/4 v2, 0x1

    if-nez v1, :cond_20

    new-instance v1, Ljava/util/concurrent/ThreadPoolExecutor;

    sget-object v8, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v9, Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-direct {v9, v2}, Ljava/util/concurrent/ArrayBlockingQueue;-><init>(I)V

    const/4 v4, 0x1

    const/4 v5, 0x1

    const-wide/16 v6, 0x1e

    move-object v3, v1

    invoke-direct/range {v3 .. v9}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;)V

    sput-object v1, Lcom/mrkeyboard/app/MrCacheJobs;->cleanup:Ljava/util/concurrent/ThreadPoolExecutor;

    sget-object v1, Lcom/mrkeyboard/app/MrCacheJobs;->cleanup:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v1, v2}, Ljava/util/concurrent/ThreadPoolExecutor;->allowCoreThreadTimeOut(Z)V
    :try_end_20
    .catchall {:try_start_3 .. :try_end_20} :catchall_2b

    .line 7
    :cond_20
    :try_start_20
    sget-object v1, Lcom/mrkeyboard/app/MrCacheJobs;->cleanup:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v1, p0}, Ljava/util/concurrent/ThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V
    :try_end_25
    .catch Ljava/util/concurrent/RejectedExecutionException; {:try_start_20 .. :try_end_25} :catch_27
    .catchall {:try_start_20 .. :try_end_25} :catchall_2b

    monitor-exit v0

    return v2

    :catch_27
    move-exception p0

    monitor-exit v0

    const/4 p0, 0x0

    return p0

    .line 5
    :catchall_2b
    move-exception p0

    monitor-exit v0

    throw p0
.end method
