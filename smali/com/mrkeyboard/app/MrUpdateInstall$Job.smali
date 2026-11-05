.class final Lcom/mrkeyboard/app/MrUpdateInstall$Job;
.super Ljava/lang/Object;
.source "MrUpdateInstall.java"

# interfaces
.implements Ljava/lang/Runnable;
.implements Lcom/mrkeyboard/app/MrUpdateInstall$Sink;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrUpdateInstall;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Job"
.end annotation


# instance fields
.field final listener:Lcom/mrkeyboard/app/MrUpdateInstall$Listener;

.field private final mApp:Landroid/content/Context;

.field private mCancelled:Z

.field private mCommitted:Z

.field private final mNotice:Lcom/mrkeyboard/app/MrUpdate$Notice;

.field private final mTarget:Lcom/mrkeyboard/app/MrUpdateInstall$Target;


# direct methods
.method constructor <init>(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;Lcom/mrkeyboard/app/MrUpdateInstall$Target;Lcom/mrkeyboard/app/MrUpdateInstall$Listener;)V
    .locals 0

    .prologue
    .line 265
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 266
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->mApp:Landroid/content/Context;

    .line 267
    iput-object p2, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->mNotice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    .line 268
    iput-object p3, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->mTarget:Lcom/mrkeyboard/app/MrUpdateInstall$Target;

    .line 269
    iput-object p4, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->listener:Lcom/mrkeyboard/app/MrUpdateInstall$Listener;

    .line 270
    return-void
.end method


# virtual methods
.method public declared-synchronized beginCommit()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 301
    monitor-enter p0

    :try_start_0
    iget-boolean v1, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->mCancelled:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    const/4 v0, 0x0

    .line 303
    :goto_0
    monitor-exit p0

    return v0

    .line 302
    :cond_0
    const/4 v1, 0x1

    :try_start_1
    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->mCommitted:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 301
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method declared-synchronized cancel()V
    .locals 1

    .prologue
    .line 311
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->mCommitted:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->mCancelled:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 312
    :cond_0
    monitor-exit p0

    return-void

    .line 311
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized cancelled()Z
    .locals 1

    .prologue
    .line 297
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->mCancelled:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method declared-synchronized isCommitted()Z
    .locals 1

    .prologue
    .line 307
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->mCommitted:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public percent(I)V
    .locals 2

    .prologue
    .line 293
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->listener:Lcom/mrkeyboard/app/MrUpdateInstall$Listener;

    const/4 v1, 0x1

    invoke-interface {v0, v1, p1}, Lcom/mrkeyboard/app/MrUpdateInstall$Listener;->state(II)V

    .line 294
    return-void
.end method

.method public run()V
    .locals 5

    .prologue
    .line 274
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->mTarget:Lcom/mrkeyboard/app/MrUpdateInstall$Target;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_3

    .line 276
    if-nez v0, :cond_0

    :try_start_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->mApp:Landroid/content/Context;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->mNotice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;->create(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;)Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    move-result-object v0

    .line 284
    :cond_0
    :try_start_2
    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->mNotice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->listener:Lcom/mrkeyboard/app/MrUpdateInstall$Listener;

    invoke-static {v1, v0, v2, p0}, Lcom/mrkeyboard/app/MrUpdateInstall;->flow(Lcom/mrkeyboard/app/MrUpdate$Notice;Lcom/mrkeyboard/app/MrUpdateInstall$Target;Lcom/mrkeyboard/app/MrUpdateInstall$Listener;Lcom/mrkeyboard/app/MrUpdateInstall$Sink;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    .line 286
    const-class v1, Lcom/mrkeyboard/app/MrUpdateInstall;

    monitor-enter v1

    .line 287
    :try_start_3
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall;->access$100()Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    move-result-object v0

    if-ne v0, p0, :cond_1

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->isCommitted()Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateInstall;->access$102(Lcom/mrkeyboard/app/MrUpdateInstall$Job;)Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    .line 288
    :cond_1
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 290
    :goto_0
    return-void

    .line 277
    :catch_0
    move-exception v0

    .line 278
    :try_start_4
    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->listener:Lcom/mrkeyboard/app/MrUpdateInstall$Listener;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateInstall;->access$000(Ljava/io/IOException;)Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    move-result-object v0

    invoke-interface {v1, v0}, Lcom/mrkeyboard/app/MrUpdateInstall$Listener;->failed(Lcom/mrkeyboard/app/MrUpdateInstall$Failure;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    .line 286
    const-class v1, Lcom/mrkeyboard/app/MrUpdateInstall;

    monitor-enter v1

    .line 287
    :try_start_5
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall;->access$100()Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    move-result-object v0

    if-ne v0, p0, :cond_2

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->isCommitted()Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateInstall;->access$102(Lcom/mrkeyboard/app/MrUpdateInstall$Job;)Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    .line 288
    :cond_2
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    throw v0

    .line 280
    :catch_1
    move-exception v0

    .line 281
    :try_start_6
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->listener:Lcom/mrkeyboard/app/MrUpdateInstall$Listener;

    new-instance v1, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    const-string v2, "mr_update_err_install"

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-direct {v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    invoke-interface {v0, v1}, Lcom/mrkeyboard/app/MrUpdateInstall$Listener;->failed(Lcom/mrkeyboard/app/MrUpdateInstall$Failure;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 286
    const-class v1, Lcom/mrkeyboard/app/MrUpdateInstall;

    monitor-enter v1

    .line 287
    :try_start_7
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall;->access$100()Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    move-result-object v0

    if-ne v0, p0, :cond_3

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->isCommitted()Z

    move-result v0

    if-nez v0, :cond_3

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateInstall;->access$102(Lcom/mrkeyboard/app/MrUpdateInstall$Job;)Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    .line 288
    :cond_3
    monitor-exit v1

    goto :goto_0

    :catchall_1
    move-exception v0

    monitor-exit v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    throw v0

    :catchall_2
    move-exception v0

    :try_start_8
    monitor-exit v1
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_2

    throw v0

    .line 286
    :catchall_3
    move-exception v0

    const-class v1, Lcom/mrkeyboard/app/MrUpdateInstall;

    monitor-enter v1

    .line 287
    :try_start_9
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall;->access$100()Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    move-result-object v2

    if-ne v2, p0, :cond_4

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->isCommitted()Z

    move-result v2

    if-nez v2, :cond_4

    const/4 v2, 0x0

    invoke-static {v2}, Lcom/mrkeyboard/app/MrUpdateInstall;->access$102(Lcom/mrkeyboard/app/MrUpdateInstall$Job;)Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    .line 288
    :cond_4
    monitor-exit v1
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_4

    .line 289
    throw v0

    .line 288
    :catchall_4
    move-exception v0

    :try_start_a
    monitor-exit v1
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_4

    throw v0
.end method
