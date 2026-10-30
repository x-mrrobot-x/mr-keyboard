.class public abstract Lcom/mrkeyboard/app/BgTask;
.super Ljava/lang/Object;
.source "BgTask.java"


# static fields
.field private static sExec:Ljava/util/concurrent/ExecutorService;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static declared-synchronized exec()Ljava/util/concurrent/ExecutorService;
    .locals 1

    sget-object v0, Lcom/mrkeyboard/app/BgTask;->sExec:Ljava/util/concurrent/ExecutorService;

    if-nez v0, :cond_ret

    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/BgTask;->sExec:Ljava/util/concurrent/ExecutorService;

    :cond_ret
    return-object v0
.end method

.method public final execute([Ljava/lang/Object;)V
    .locals 2

    invoke-virtual {p0}, Lcom/mrkeyboard/app/BgTask;->onPreExecute()V

    invoke-static {}, Lcom/mrkeyboard/app/BgTask;->exec()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/BgRun;

    invoke-direct {v1, p0, p1}, Lcom/mrkeyboard/app/BgRun;-><init>(Lcom/mrkeyboard/app/BgTask;[Ljava/lang/Object;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method


# virtual methods
.method protected abstract doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
.end method

.method protected onPreExecute()V
    .locals 0

    return-void
.end method
