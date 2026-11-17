.class public final Lcom/mrkeyboard/app/MrNav;
.super Ljava/lang/Object;
.source "MrNav.java"


# static fields
.field static final EXTRA_FROM_KEYBOARD:Ljava/lang/String; = "mr_from_keyboard"

.field static final FROM_KEYBOARD:I = 0x10020000

.field private static final OPENED:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/ref/WeakReference",
            "<",
            "Landroid/app/Activity;",
            ">;>;"
        }
    .end annotation
.end field

.field static final REUSE:I = 0x20000


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 41
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static closeOpenedByKeyboard(Ljava/lang/Class;)Z
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<*>;)Z"
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 104
    invoke-static {p0}, Lcom/mrkeyboard/app/MrNav;->openedByKeyboard(Ljava/lang/Class;)Landroid/app/Activity;

    move-result-object v1

    .line 105
    if-nez v1, :cond_0

    .line 111
    :goto_0
    return v0

    .line 107
    :cond_0
    :try_start_0
    invoke-virtual {v1}, Landroid/app/Activity;->isTaskRoot()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {v1}, Landroid/app/Activity;->finishAndRemoveTask()V

    .line 109
    :goto_1
    const/4 v0, 0x1

    goto :goto_0

    .line 108
    :cond_1
    invoke-virtual {v1}, Landroid/app/Activity;->finish()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 110
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static forget(Landroid/app/Activity;)V
    .locals 2

    .prologue
    .line 82
    sget-object v0, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v0

    :goto_0
    if-ltz v1, :cond_2

    .line 83
    sget-object v0, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    .line 84
    if-eqz v0, :cond_0

    if-eq v0, p0, :cond_0

    invoke-virtual {v0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 82
    :cond_1
    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_0

    .line 86
    :cond_2
    return-void
.end method

.method static gone(Landroid/app/Activity;)V
    .locals 2

    .prologue
    .line 74
    if-nez p0, :cond_0

    .line 78
    :goto_0
    return-void

    .line 75
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    monitor-enter v1

    .line 76
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrNav;->forget(Landroid/app/Activity;)V

    .line 77
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public static intent(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/Class",
            "<*>;)",
            "Landroid/content/Intent;"
        }
    .end annotation

    .prologue
    .line 47
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0, p0, p1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 48
    instance-of v1, p0, Landroid/app/Activity;

    if-eqz v1, :cond_0

    .line 49
    const/high16 v1, 0x20000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 54
    :goto_0
    return-object v0

    .line 51
    :cond_0
    const/high16 v1, 0x10020000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 52
    const-string v1, "mr_from_keyboard"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    goto :goto_0
.end method

.method static opened(Landroid/app/Activity;)V
    .locals 3

    .prologue
    .line 59
    if-nez p0, :cond_1

    .line 70
    :cond_0
    :goto_0
    return-void

    .line 61
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    .line 62
    if-eqz v0, :cond_0

    const-string v1, "mr_from_keyboard"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    if-eqz v0, :cond_0

    .line 66
    sget-object v1, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    monitor-enter v1

    .line 67
    const/4 v0, 0x0

    :try_start_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrNav;->forget(Landroid/app/Activity;)V

    .line 68
    sget-object v0, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    new-instance v2, Ljava/lang/ref/WeakReference;

    invoke-direct {v2, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 69
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 63
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static openedByKeyboard(Ljava/lang/Class;)Landroid/app/Activity;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<*>;)",
            "Landroid/app/Activity;"
        }
    .end annotation

    .prologue
    .line 90
    sget-object v2, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    monitor-enter v2

    .line 91
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v0

    :goto_0
    if-ltz v1, :cond_1

    .line 92
    sget-object v0, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    .line 93
    if-eqz v0, :cond_0

    invoke-virtual {p0, v0}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v0}, Landroid/app/Activity;->isFinishing()Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v3

    if-nez v3, :cond_0

    monitor-exit v2

    .line 96
    :goto_1
    return-object v0

    .line 91
    :cond_0
    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_0

    .line 95
    :cond_1
    monitor-exit v2

    .line 96
    const/4 v0, 0x0

    goto :goto_1

    .line 95
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method
