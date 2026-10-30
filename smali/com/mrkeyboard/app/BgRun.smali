.class Lcom/mrkeyboard/app/BgRun;
.super Ljava/lang/Object;
.source "BgRun.java"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field private final mArgs:[Ljava/lang/Object;

.field private final mTask:Lcom/mrkeyboard/app/BgTask;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/BgTask;[Ljava/lang/Object;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/mrkeyboard/app/BgRun;->mTask:Lcom/mrkeyboard/app/BgTask;

    iput-object p2, p0, Lcom/mrkeyboard/app/BgRun;->mArgs:[Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    const/16 v0, 0xa

    invoke-static {v0}, Landroid/os/Process;->setThreadPriority(I)V

    iget-object v0, p0, Lcom/mrkeyboard/app/BgRun;->mTask:Lcom/mrkeyboard/app/BgTask;

    iget-object v1, p0, Lcom/mrkeyboard/app/BgRun;->mArgs:[Ljava/lang/Object;

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/BgTask;->doInBackground([Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
