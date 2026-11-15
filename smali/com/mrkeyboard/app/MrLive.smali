.class final Lcom/mrkeyboard/app/MrLive;
.super Ljava/lang/Object;
.source "MrLive.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrLive$Result;,
        Lcom/mrkeyboard/app/MrLive$Search;
    }
.end annotation


# static fields
.field private static final BUDGET:I = 0x61a80

.field static final HELD_CUT:I = 0x3

.field static final HELD_NONE:I = 0x0

.field static final HELD_OUTSIDE:I = 0x2

.field static final HELD_PATH:I = 0x1

.field private static final MAX_PATHS:I = 0x4

.field private static final PKG:Ljava/lang/String; = "com.mrkeyboard."

.field private static final ROOTS:[Ljava/lang/String;

.field private static final TIME_NS:J = 0x77359400L

.field static sHeld:Ljava/lang/String;

.field static sHeldKind:I

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
    .locals 3

    .prologue
    .line 36
    const/16 v0, 0x3a

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "AutoDictionary"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "BgTask"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "ComposeSequence"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "Dictionary$DataType"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "KeyStyle"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "KeyboardSwitcher"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "LatinIME"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "LatinIMEUtil$GCUtils"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "LatinIMEUtil$RingCharBuffer"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "MrAi"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "MrAiDialog"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "MrAiStyleActivity"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "MrAnim"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "MrBar"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "MrCacheClear"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "MrCacheJobs"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, "MrCopyRetention"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "MrEmojiIndex"

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, "MrEmojiNew"

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, "MrEmojiSearch"

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, "MrEmotes"

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string v2, "MrEs"

    aput-object v2, v0, v1

    const/16 v1, 0x16

    const-string v2, "MrFonts"

    aput-object v2, v0, v1

    const/16 v1, 0x17

    const-string v2, "MrFuzzy"

    aput-object v2, v0, v1

    const/16 v1, 0x18

    const-string v2, "MrGesture"

    aput-object v2, v0, v1

    const/16 v1, 0x19

    const-string v2, "MrGestureInput"

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    const-string v2, "MrGestureWords"

    aput-object v2, v0, v1

    const/16 v1, 0x1b

    const-string v2, "MrGlow"

    aput-object v2, v0, v1

    const/16 v1, 0x1c

    const-string v2, "MrHaptic"

    aput-object v2, v0, v1

    const/16 v1, 0x1d

    const-string v2, "MrLearned"

    aput-object v2, v0, v1

    const/16 v1, 0x1e

    const-string v2, "MrLive"

    aput-object v2, v0, v1

    const/16 v1, 0x1f

    const-string v2, "MrNative"

    aput-object v2, v0, v1

    const/16 v1, 0x20

    const-string v2, "MrPacks"

    aput-object v2, v0, v1

    const/16 v1, 0x21

    const-string v2, "MrPerf"

    aput-object v2, v0, v1

    const/16 v1, 0x22

    const-string v2, "MrPredict"

    aput-object v2, v0, v1

    const/16 v1, 0x23

    const-string v2, "MrRecent"

    aput-object v2, v0, v1

    const/16 v1, 0x24

    const-string v2, "MrRecorrect"

    aput-object v2, v0, v1

    const/16 v1, 0x25

    const-string v2, "MrReset"

    aput-object v2, v0, v1

    const/16 v1, 0x26

    const-string v2, "MrRules"

    aput-object v2, v0, v1

    const/16 v1, 0x27

    const-string v2, "MrScreens"

    aput-object v2, v0, v1

    const/16 v1, 0x28

    const-string v2, "MrShots"

    aput-object v2, v0, v1

    const/16 v1, 0x29

    const-string v2, "MrSugg"

    aput-object v2, v0, v1

    const/16 v1, 0x2a

    const-string v2, "MrTools"

    aput-object v2, v0, v1

    const/16 v1, 0x2b

    const-string v2, "MrTrigram"

    aput-object v2, v0, v1

    const/16 v1, 0x2c

    const-string v2, "MrTune"

    aput-object v2, v0, v1

    const/16 v1, 0x2d

    const-string v2, "MrUpdateDialog"

    aput-object v2, v0, v1

    const/16 v1, 0x2e

    const-string v2, "MrUpdateInstall"

    aput-object v2, v0, v1

    const/16 v1, 0x2f

    const-string v2, "MrUpdateUi"

    aput-object v2, v0, v1

    const/16 v1, 0x30

    const-string v2, "PluginManager"

    aput-object v2, v0, v1

    const/16 v1, 0x31

    const-string v2, "PointerTracker"

    aput-object v2, v0, v1

    const/16 v1, 0x32

    const-string v2, "ShadowDrawHelper"

    aput-object v2, v0, v1

    const/16 v1, 0x33

    const-string v2, "SheetStore"

    aput-object v2, v0, v1

    const/16 v1, 0x34

    const-string v2, "SheetUi"

    aput-object v2, v0, v1

    const/16 v1, 0x35

    const-string v2, "SpecialKeyPicker"

    aput-object v2, v0, v1

    const/16 v1, 0x36

    const-string v2, "TextEntryState"

    aput-object v2, v0, v1

    const/16 v1, 0x37

    const-string v2, "TextEntryState$State"

    aput-object v2, v0, v1

    const/16 v1, 0x38

    const-string v2, "UserBigramDictionary"

    aput-object v2, v0, v1

    const/16 v1, 0x39

    const-string v2, "UserDictionary"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrLive;->ROOTS:[Ljava/lang/String;

    .line 60
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrLive;->sServiceRefs:Ljava/util/ArrayList;

    .line 61
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrLive;->sViewRefs:Ljava/util/ArrayList;

    .line 68
    const-string v0, ""

    sput-object v0, Lcom/mrkeyboard/app/MrLive;->sHeld:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 70
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/Class;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 34
    invoke-static {p0}, Lcom/mrkeyboard/app/MrLive;->simple(Ljava/lang/Class;)Ljava/lang/String;

    move-result-object v0

    return-object v0
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
    .line 96
    const/4 v1, 0x0

    .line 97
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v2, v0

    :goto_0
    if-ltz v2, :cond_1

    .line 98
    invoke-virtual {p0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-virtual {p0, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move v0, v1

    .line 97
    :goto_1
    add-int/lit8 v1, v2, -0x1

    move v2, v1

    move v1, v0

    goto :goto_0

    .line 99
    :cond_0
    add-int/lit8 v0, v1, 0x1

    goto :goto_1

    .line 101
    :cond_1
    return v1
.end method

.method static declared-synchronized forget()V
    .locals 2

    .prologue
    .line 142
    const-class v1, Lcom/mrkeyboard/app/MrLive;

    monitor-enter v1

    const/4 v0, 0x0

    :try_start_0
    sput-boolean v0, Lcom/mrkeyboard/app/MrLive;->sMeasured:Z

    .line 143
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrLive;->sHeldKind:I

    .line 144
    const-string v0, ""

    sput-object v0, Lcom/mrkeyboard/app/MrLive;->sHeld:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 145
    monitor-exit v1

    return-void

    .line 142
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static measure()V
    .locals 1

    .prologue
    .line 117
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLive;->measure([Ljava/lang/Class;)V

    .line 118
    return-void
.end method

.method static declared-synchronized measure([Ljava/lang/Class;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/lang/Class",
            "<*>;)V"
        }
    .end annotation

    .prologue
    .line 122
    const-class v1, Lcom/mrkeyboard/app/MrLive;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrLive;->sServiceRefs:Ljava/util/ArrayList;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLive;->alive(Ljava/util/ArrayList;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrLive;->sServices:I

    .line 123
    sget-object v0, Lcom/mrkeyboard/app/MrLive;->sViewRefs:Ljava/util/ArrayList;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLive;->alive(Ljava/util/ArrayList;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrLive;->sViews:I

    .line 124
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrLive;->sMeasured:Z

    .line 125
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrLive;->sHeldKind:I

    .line 126
    const-string v0, ""

    sput-object v0, Lcom/mrkeyboard/app/MrLive;->sHeld:Ljava/lang/String;

    .line 127
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 128
    sget-object v2, Lcom/mrkeyboard/app/MrLive;->sServiceRefs:Ljava/util/ArrayList;

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrLive;->old(Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    .line 129
    sget-object v2, Lcom/mrkeyboard/app/MrLive;->sViewRefs:Ljava/util/ArrayList;

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrLive;->old(Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    .line 130
    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v2

    if-eqz v2, :cond_0

    .line 138
    :goto_0
    monitor-exit v1

    return-void

    .line 132
    :cond_0
    :try_start_1
    invoke-virtual {v0}, Ljava/util/ArrayList;->toArray()[Ljava/lang/Object;

    move-result-object v0

    if-eqz p0, :cond_1

    :goto_1
    invoke-static {v0, p0}, Lcom/mrkeyboard/app/MrLive;->search([Ljava/lang/Object;[Ljava/lang/Class;)Lcom/mrkeyboard/app/MrLive$Result;

    move-result-object v0

    .line 133
    iget v2, v0, Lcom/mrkeyboard/app/MrLive$Result;->kind:I

    sput v2, Lcom/mrkeyboard/app/MrLive;->sHeldKind:I

    .line 134
    iget-object v0, v0, Lcom/mrkeyboard/app/MrLive$Result;->path:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrLive;->sHeld:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 135
    :catch_0
    move-exception v0

    .line 136
    const/4 v0, 0x3

    :try_start_2
    sput v0, Lcom/mrkeyboard/app/MrLive;->sHeldKind:I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 122
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0

    .line 132
    :cond_1
    :try_start_3
    invoke-static {}, Lcom/mrkeyboard/app/MrLive;->rootClasses()[Ljava/lang/Class;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result-object p0

    goto :goto_1
.end method

.method private static old(Ljava/util/ArrayList;Ljava/util/ArrayList;)V
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
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 109
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    if-ge v1, v0, :cond_1

    .line 110
    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    .line 111
    if-eqz v0, :cond_0

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 109
    :cond_0
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 113
    :cond_1
    return-void
.end method

.method private static rootClasses()[Ljava/lang/Class;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()[",
            "Ljava/lang/Class",
            "<*>;"
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 148
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 149
    const-class v2, Lcom/mrkeyboard/app/MrLive;

    invoke-virtual {v2}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v2

    .line 150
    :goto_0
    sget-object v3, Lcom/mrkeyboard/app/MrLive;->ROOTS:[Ljava/lang/String;

    array-length v3, v3

    if-ge v0, v3, :cond_0

    .line 152
    :try_start_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "com.mrkeyboard.app."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/mrkeyboard/app/MrLive;->ROOTS:[Ljava/lang/String;

    aget-object v4, v4, v0

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-static {v3, v4, v2}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 150
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 157
    :cond_0
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/Class;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/Class;

    return-object v0

    .line 153
    :catch_0
    move-exception v3

    goto :goto_1
.end method

.method static search([Ljava/lang/Object;[Ljava/lang/Class;)Lcom/mrkeyboard/app/MrLive$Result;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/lang/Object;",
            "[",
            "Ljava/lang/Class",
            "<*>;)",
            "Lcom/mrkeyboard/app/MrLive$Result;"
        }
    .end annotation

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 173
    new-instance v3, Lcom/mrkeyboard/app/MrLive$Search;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrLive$Search;-><init>([Ljava/lang/Object;)V

    .line 174
    new-instance v4, Lcom/mrkeyboard/app/MrLive$Result;

    invoke-direct {v4}, Lcom/mrkeyboard/app/MrLive$Result;-><init>()V

    .line 175
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v6

    const-wide/32 v8, 0x77359400

    add-long/2addr v6, v8

    move v0, v1

    .line 176
    :goto_0
    array-length v5, p1

    if-ge v0, v5, :cond_1

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrLive$Search;->done()Z

    move-result v5

    if-nez v5, :cond_1

    aget-object v5, p1, v0

    invoke-virtual {v3, v5}, Lcom/mrkeyboard/app/MrLive$Search;->addRoot(Ljava/lang/Class;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 183
    :cond_0
    iget v0, v3, Lcom/mrkeyboard/app/MrLive$Search;->head:I

    add-int/lit8 v5, v0, 0x1

    iput v5, v3, Lcom/mrkeyboard/app/MrLive$Search;->head:I

    invoke-virtual {v3, v0}, Lcom/mrkeyboard/app/MrLive$Search;->expand(I)V

    .line 178
    :cond_1
    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrLive$Search;->done()Z

    move-result v0

    if-nez v0, :cond_3

    iget v0, v3, Lcom/mrkeyboard/app/MrLive$Search;->head:I

    iget v5, v3, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    if-ge v0, v5, :cond_3

    .line 179
    iget v0, v3, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    const v5, 0x61a80

    if-ge v0, v5, :cond_2

    iget v0, v3, Lcom/mrkeyboard/app/MrLive$Search;->head:I

    and-int/lit16 v0, v0, 0xff

    if-nez v0, :cond_0

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v8

    cmp-long v0, v8, v6

    if-lez v0, :cond_0

    :cond_2
    move v1, v2

    .line 185
    :cond_3
    iget v0, v3, Lcom/mrkeyboard/app/MrLive$Search;->hits:I

    if-lez v0, :cond_4

    .line 186
    iput v2, v4, Lcom/mrkeyboard/app/MrLive$Result;->kind:I

    .line 187
    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrLive$Search;->paths()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v4, Lcom/mrkeyboard/app/MrLive$Result;->path:Ljava/lang/String;

    .line 191
    :goto_1
    return-object v4

    .line 189
    :cond_4
    if-eqz v1, :cond_5

    const/4 v0, 0x3

    :goto_2
    iput v0, v4, Lcom/mrkeyboard/app/MrLive$Result;->kind:I

    goto :goto_1

    :cond_5
    const/4 v0, 0x2

    goto :goto_2
.end method

.method static declared-synchronized service(Ljava/lang/Object;)V
    .locals 2

    .prologue
    .line 74
    const-class v1, Lcom/mrkeyboard/app/MrLive;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrLive;->sServiceRefs:Ljava/util/ArrayList;

    invoke-static {v0, p0}, Lcom/mrkeyboard/app/MrLive;->watch(Ljava/util/ArrayList;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 75
    monitor-exit v1

    return-void

    .line 74
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private static simple(Ljava/lang/Class;)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<*>;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    .line 195
    invoke-virtual {p0}, Ljava/lang/Class;->isArray()Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Class;->getComponentType()Ljava/lang/Class;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrLive;->simple(Ljava/lang/Class;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "[]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 198
    :cond_0
    :goto_0
    return-object v0

    .line 196
    :cond_1
    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    .line 197
    const/16 v1, 0x2e

    invoke-virtual {v0, v1}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v1

    .line 198
    if-ltz v1, :cond_0

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static declared-synchronized view(Ljava/lang/Object;)V
    .locals 2

    .prologue
    .line 79
    const-class v1, Lcom/mrkeyboard/app/MrLive;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrLive;->sViewRefs:Ljava/util/ArrayList;

    invoke-static {v0, p0}, Lcom/mrkeyboard/app/MrLive;->watch(Ljava/util/ArrayList;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 80
    monitor-exit v1

    return-void

    .line 79
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
    .line 83
    if-nez p1, :cond_0

    .line 93
    :goto_0
    return-void

    .line 84
    :cond_0
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v0

    :goto_1
    if-ltz v1, :cond_3

    .line 85
    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    .line 86
    if-nez v0, :cond_2

    .line 87
    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 84
    :cond_1
    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_1

    .line 88
    :cond_2
    if-ne v0, p1, :cond_1

    goto :goto_0

    .line 92
    :cond_3
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    invoke-virtual {p0, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method
