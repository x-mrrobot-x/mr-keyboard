.class final Lcom/mrkeyboard/app/MrMemStore;
.super Ljava/lang/Object;
.source "MrMemStore.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrWordStore;


# instance fields
.field private final mLocale:[Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "[",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mNextBatch:J

.field private mNextId:J

.field private final mRows:[Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "[",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/mrkeyboard/app/MrWordStore$Row;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>()V
    .locals 4

    .prologue
    const-wide/16 v0, 0x1

    const/4 v3, 0x5

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 13
    iput-wide v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mNextId:J

    .line 14
    iput-wide v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mNextBatch:J

    .line 18
    new-array v0, v3, [Ljava/util/ArrayList;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    .line 19
    new-array v0, v3, [Ljava/util/ArrayList;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mLocale:[Ljava/util/ArrayList;

    .line 20
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v3, :cond_0

    .line 21
    iget-object v1, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    aput-object v2, v1, v0

    .line 22
    iget-object v1, p0, Lcom/mrkeyboard/app/MrMemStore;->mLocale:[Ljava/util/ArrayList;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    aput-object v2, v1, v0

    .line 20
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 24
    :cond_0
    return-void
.end method

.method static fold(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 28
    if-nez p0, :cond_0

    const-string v0, ""

    .line 31
    :goto_0
    return-object v0

    .line 29
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    new-array v1, v0, [C

    .line 30
    const/4 v0, 0x0

    :goto_1
    array-length v2, v1

    if-ge v0, v2, :cond_1

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    aput-char v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 31
    :cond_1
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/String;-><init>([C)V

    goto :goto_0
.end method

.method private static ok(I)Z
    .locals 1

    .prologue
    .line 35
    if-ltz p0, :cond_0

    const/4 v0, 0x5

    if-ge p0, v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method public declared-synchronized add(ILjava/lang/String;Lcom/mrkeyboard/app/MrWordStore$Row;)J
    .locals 10

    .prologue
    .line 74
    monitor-enter p0

    :try_start_0
    invoke-static {p1}, Lcom/mrkeyboard/app/MrMemStore;->ok(I)Z

    move-result v0

    if-eqz v0, :cond_0

    if-eqz p3, :cond_0

    iget-object v0, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_1

    :cond_0
    const-wide/16 v0, -0x1

    .line 79
    :goto_0
    monitor-exit p0

    return-wide v0

    .line 75
    :cond_1
    :try_start_1
    new-instance v1, Lcom/mrkeyboard/app/MrWordStore$Row;

    iget-object v3, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    iget-object v4, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    iget v5, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    iget-wide v6, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->batch:J

    iget-wide v8, p3, Lcom/mrkeyboard/app/MrWordStore$Row;->added:J

    move v2, p1

    invoke-direct/range {v1 .. v9}, Lcom/mrkeyboard/app/MrWordStore$Row;-><init>(ILjava/lang/String;Ljava/lang/String;IJJ)V

    .line 76
    iget-wide v2, p0, Lcom/mrkeyboard/app/MrMemStore;->mNextId:J

    const-wide/16 v4, 0x1

    add-long/2addr v4, v2

    iput-wide v4, p0, Lcom/mrkeyboard/app/MrMemStore;->mNextId:J

    iput-wide v2, v1, Lcom/mrkeyboard/app/MrWordStore$Row;->id:J

    .line 77
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 78
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mLocale:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 79
    iget-wide v0, v1, Lcom/mrkeyboard/app/MrWordStore$Row;->id:J
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 74
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized all(ILjava/lang/String;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrWordStore$Row;",
            ">;"
        }
    .end annotation

    .prologue
    .line 67
    monitor-enter p0

    :try_start_0
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 68
    invoke-static {p1}, Lcom/mrkeyboard/app/MrMemStore;->ok(I)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_0

    move-object v0, v1

    .line 70
    :goto_0
    monitor-exit p0

    return-object v0

    .line 69
    :cond_0
    const/4 v0, 0x0

    move v2, v0

    :goto_1
    :try_start_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v2, v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mLocale:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_1
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    :cond_2
    move-object v0, v1

    .line 70
    goto :goto_0

    .line 67
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public begin()V
    .locals 0

    .prologue
    .line 125
    return-void
.end method

.method public declared-synchronized count(ILjava/lang/String;)I
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 39
    monitor-enter p0

    :try_start_0
    invoke-static {p1}, Lcom/mrkeyboard/app/MrMemStore;->ok(I)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_1

    .line 42
    :cond_0
    monitor-exit p0

    return v1

    :cond_1
    move v2, v1

    .line 41
    :goto_0
    :try_start_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v2, v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mLocale:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v0

    if-eqz v0, :cond_2

    add-int/lit8 v0, v1, 0x1

    :goto_1
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    move v1, v0

    goto :goto_0

    .line 39
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :cond_2
    move v0, v1

    goto :goto_1
.end method

.method public declared-synchronized delete(IJ)Z
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 83
    monitor-enter p0

    :try_start_0
    invoke-static {p1}, Lcom/mrkeyboard/app/MrMemStore;->ok(I)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_0

    move v0, v1

    .line 91
    :goto_0
    monitor-exit p0

    return v0

    :cond_0
    move v2, v1

    .line 84
    :goto_1
    :try_start_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v2, v0, :cond_2

    .line 85
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    iget-wide v4, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->id:J

    cmp-long v0, v4, p2

    if-nez v0, :cond_1

    .line 86
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 87
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mLocale:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 88
    const/4 v0, 0x1

    goto :goto_0

    .line 84
    :cond_1
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    :cond_2
    move v0, v1

    .line 91
    goto :goto_0

    .line 83
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized deleteAll(ILjava/lang/String;)I
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 95
    monitor-enter p0

    :try_start_0
    invoke-static {p1}, Lcom/mrkeyboard/app/MrMemStore;->ok(I)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_1

    .line 104
    :cond_0
    monitor-exit p0

    return v1

    .line 97
    :cond_1
    :try_start_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v2, v0

    :goto_0
    if-ltz v2, :cond_0

    .line 98
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mLocale:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 99
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 100
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mLocale:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 101
    add-int/lit8 v0, v1, 0x1

    .line 97
    :goto_1
    add-int/lit8 v1, v2, -0x1

    move v2, v1

    move v1, v0

    goto :goto_0

    .line 95
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :cond_2
    move v0, v1

    goto :goto_1
.end method

.method public declared-synchronized deleteBatch(Ljava/lang/String;J)I
    .locals 6

    .prologue
    .line 108
    monitor-enter p0

    const/4 v1, 0x0

    .line 109
    const/4 v0, 0x2

    move v3, v0

    :goto_0
    const/4 v0, 0x3

    if-gt v3, v0, :cond_1

    .line 110
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    aget-object v0, v0, v3

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v2, v0

    :goto_1
    if-ltz v2, :cond_0

    .line 111
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mLocale:[Ljava/util/ArrayList;

    aget-object v0, v0, v3

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    aget-object v0, v0, v3

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    iget-wide v4, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->batch:J

    cmp-long v0, v4, p2

    if-nez v0, :cond_2

    .line 112
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    aget-object v0, v0, v3

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 113
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mLocale:[Ljava/util/ArrayList;

    aget-object v0, v0, v3

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 114
    add-int/lit8 v0, v1, 0x1

    .line 110
    :goto_2
    add-int/lit8 v1, v2, -0x1

    move v2, v1

    move v1, v0

    goto :goto_1

    .line 109
    :cond_0
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_0

    .line 118
    :cond_1
    monitor-exit p0

    return v1

    .line 108
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :cond_2
    move v0, v1

    goto :goto_2
.end method

.method public end()V
    .locals 0

    .prologue
    .line 127
    return-void
.end method

.method public declared-synchronized list(ILjava/lang/String;Ljava/lang/String;III)Ljava/util/List;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "III)",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrWordStore$Row;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 46
    monitor-enter p0

    :try_start_0
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 47
    invoke-static {p1}, Lcom/mrkeyboard/app/MrMemStore;->ok(I)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_0

    move-object v0, v2

    .line 63
    :goto_0
    monitor-exit p0

    return-object v0

    .line 48
    :cond_0
    if-nez p3, :cond_2

    :try_start_1
    const-string v0, ""

    move-object v1, v0

    .line 49
    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v3, v0, :cond_5

    .line 50
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mLocale:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 49
    :cond_1
    :goto_2
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_1

    .line 48
    :cond_2
    invoke-virtual {p3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrMemStore;->fold(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    goto :goto_1

    .line 51
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mRows:[Ljava/util/ArrayList;

    aget-object v0, v0, p1

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    .line 52
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v4

    if-lez v4, :cond_4

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrWordStore$Row;->text()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/mrkeyboard/app/MrMemStore;->fold(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 53
    :cond_4
    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2

    .line 46
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    .line 55
    :cond_5
    :try_start_2
    new-instance v0, Lcom/mrkeyboard/app/MrMemStore$1;

    invoke-direct {v0, p0, p4}, Lcom/mrkeyboard/app/MrMemStore$1;-><init>(Lcom/mrkeyboard/app/MrMemStore;I)V

    invoke-static {v2, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 61
    const/4 v0, 0x0

    invoke-static {v0, p5}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 62
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v3, 0x0

    invoke-static {v3, p6}, Ljava/lang/Math;->max(II)I

    move-result v3

    add-int/2addr v3, v1

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v3

    .line 63
    new-instance v0, Ljava/util/ArrayList;

    invoke-virtual {v2, v1, v3}, Ljava/util/ArrayList;->subList(II)Ljava/util/List;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0
.end method

.method public declared-synchronized locales()Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 130
    monitor-enter p0

    :try_start_0
    new-instance v1, Ljava/util/TreeSet;

    invoke-direct {v1}, Ljava/util/TreeSet;-><init>()V

    .line 131
    const/4 v0, 0x0

    :goto_0
    const/4 v2, 0x5

    if-ge v0, v2, :cond_0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrMemStore;->mLocale:[Ljava/util/ArrayList;

    aget-object v2, v2, v0

    invoke-virtual {v1, v2}, Ljava/util/TreeSet;->addAll(Ljava/util/Collection;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 132
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 130
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized newBatch()J
    .locals 4

    .prologue
    .line 122
    monitor-enter p0

    :try_start_0
    iget-wide v0, p0, Lcom/mrkeyboard/app/MrMemStore;->mNextBatch:J

    const-wide/16 v2, 0x1

    add-long/2addr v2, v0

    iput-wide v2, p0, Lcom/mrkeyboard/app/MrMemStore;->mNextBatch:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-wide v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
