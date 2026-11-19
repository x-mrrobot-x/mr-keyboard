.class public final Lcom/mrkeyboard/app/MrNav;
.super Ljava/lang/Object;
.source "MrNav.java"


# static fields
.field static final EXTRA_FROM_KEYBOARD:Ljava/lang/String; = "mr_from_keyboard"

.field static final FROM_KEYBOARD:I = 0x10808000

.field static final KEEPING_DRAFT:I = 0x10020000

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

.field static final SETTINGS_AFFINITY:Ljava/lang/String; = "com.mrkeyboard.app.settings"

.field private static final TASKS:Ljava/util/WeakHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/WeakHashMap",
            "<",
            "Landroid/app/Activity;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 48
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    .line 51
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrNav;->TASKS:Ljava/util/WeakHashMap;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static aloneInTask(Landroid/app/Activity;)Z
    .locals 7

    .prologue
    const/4 v2, 0x0

    .line 114
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getTaskId()I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 118
    sget-object v4, Lcom/mrkeyboard/app/MrNav;->TASKS:Ljava/util/WeakHashMap;

    monitor-enter v4

    .line 119
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrNav;->TASKS:Ljava/util/WeakHashMap;

    invoke-virtual {v0}, Ljava/util/WeakHashMap;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :cond_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 120
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/Activity;

    .line 121
    if-eqz v1, :cond_0

    if-eq v1, p0, :cond_0

    invoke-virtual {v1}, Landroid/app/Activity;->isFinishing()Z

    move-result v6

    if-nez v6, :cond_0

    invoke-virtual {v1}, Landroid/app/Activity;->isDestroyed()Z

    move-result v1

    if-nez v1, :cond_0

    .line 122
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-ne v0, v3, :cond_0

    monitor-exit v4

    move v0, v2

    .line 125
    :goto_0
    return v0

    .line 115
    :catch_0
    move-exception v0

    move v0, v2

    .line 116
    goto :goto_0

    .line 124
    :cond_1
    monitor-exit v4

    .line 125
    const/4 v0, 0x1

    goto :goto_0

    .line 124
    :catchall_0
    move-exception v0

    monitor-exit v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method static born(Landroid/app/Activity;)V
    .locals 3

    .prologue
    .line 84
    if-nez p0, :cond_0

    .line 94
    :goto_0
    return-void

    .line 87
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getTaskId()I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 91
    sget-object v1, Lcom/mrkeyboard/app/MrNav;->TASKS:Ljava/util/WeakHashMap;

    monitor-enter v1

    .line 92
    :try_start_1
    sget-object v2, Lcom/mrkeyboard/app/MrNav;->TASKS:Ljava/util/WeakHashMap;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v2, p0, v0}, Ljava/util/WeakHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 93
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 88
    :catch_0
    move-exception v0

    goto :goto_0
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

    .line 153
    invoke-static {p0}, Lcom/mrkeyboard/app/MrNav;->openedByKeyboard(Ljava/lang/Class;)Landroid/app/Activity;

    move-result-object v1

    .line 154
    if-nez v1, :cond_0

    .line 160
    :goto_0
    return v0

    .line 156
    :cond_0
    :try_start_0
    invoke-virtual {v1}, Landroid/app/Activity;->isTaskRoot()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrNav;->aloneInTask(Landroid/app/Activity;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {v1}, Landroid/app/Activity;->finishAndRemoveTask()V

    .line 158
    :goto_1
    const/4 v0, 0x1

    goto :goto_0

    .line 157
    :cond_1
    invoke-virtual {v1}, Landroid/app/Activity;->finish()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 159
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static forget(Landroid/app/Activity;)V
    .locals 2

    .prologue
    .line 130
    sget-object v0, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v0

    :goto_0
    if-ltz v1, :cond_2

    .line 131
    sget-object v0, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    .line 132
    if-eqz v0, :cond_0

    if-eq v0, p0, :cond_0

    invoke-virtual {v0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 130
    :cond_1
    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_0

    .line 134
    :cond_2
    return-void
.end method

.method static gone(Landroid/app/Activity;)V
    .locals 2

    .prologue
    .line 98
    if-nez p0, :cond_0

    .line 105
    :goto_0
    return-void

    .line 99
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrNav;->TASKS:Ljava/util/WeakHashMap;

    monitor-enter v1

    .line 100
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrNav;->TASKS:Ljava/util/WeakHashMap;

    invoke-virtual {v0, p0}, Ljava/util/WeakHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 101
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 102
    sget-object v1, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    monitor-enter v1

    .line 103
    :try_start_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrNav;->forget(Landroid/app/Activity;)V

    .line 104
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 101
    :catchall_1
    move-exception v0

    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

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
    .line 57
    new-instance v1, Landroid/content/Intent;

    invoke-direct {v1, p0, p1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 58
    instance-of v0, p0, Landroid/app/Activity;

    if-eqz v0, :cond_0

    .line 59
    const/high16 v0, 0x20000

    invoke-virtual {v1, v0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 64
    :goto_0
    return-object v1

    .line 61
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAiStyleActivity;->isOpen()Z

    move-result v0

    if-eqz v0, :cond_1

    const/high16 v0, 0x10020000

    :goto_1
    invoke-virtual {v1, v0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 62
    const-string v0, "mr_from_keyboard"

    const/4 v2, 0x1

    invoke-virtual {v1, v0, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    goto :goto_0

    .line 61
    :cond_1
    const v0, 0x10808000

    goto :goto_1
.end method

.method static opened(Landroid/app/Activity;)V
    .locals 3

    .prologue
    .line 69
    if-nez p0, :cond_1

    .line 80
    :cond_0
    :goto_0
    return-void

    .line 71
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    .line 72
    if-eqz v0, :cond_0

    const-string v1, "mr_from_keyboard"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    if-eqz v0, :cond_0

    .line 76
    sget-object v1, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    monitor-enter v1

    .line 77
    const/4 v0, 0x0

    :try_start_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrNav;->forget(Landroid/app/Activity;)V

    .line 78
    sget-object v0, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    new-instance v2, Ljava/lang/ref/WeakReference;

    invoke-direct {v2, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 79
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 73
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
    .line 138
    sget-object v2, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    monitor-enter v2

    .line 139
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v0

    :goto_0
    if-ltz v1, :cond_1

    .line 140
    sget-object v0, Lcom/mrkeyboard/app/MrNav;->OPENED:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    .line 141
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

    .line 144
    :goto_1
    return-object v0

    .line 139
    :cond_0
    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_0

    .line 143
    :cond_1
    monitor-exit v2

    .line 144
    const/4 v0, 0x0

    goto :goto_1

    .line 143
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method
