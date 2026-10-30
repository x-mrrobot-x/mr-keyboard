.class final Lcom/mrkeyboard/app/MrCacheFiles;
.super Ljava/nio/file/SimpleFileVisitor;
.source "MrCacheFiles.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/nio/file/SimpleFileVisitor<",
        "Ljava/nio/file/Path;",
        ">;"
    }
.end annotation


# instance fields
.field private final cutoff:J

.field private final expiryOnly:Z

.field private final result:[J

.field private final root:Ljava/nio/file/Path;


# direct methods
.method private constructor <init>(Ljava/nio/file/Path;Z)V
    .registers 7

    .line 7
    invoke-direct {p0}, Ljava/nio/file/SimpleFileVisitor;-><init>()V

    .line 6
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    const-wide/32 v2, 0x36ee80

    sub-long/2addr v0, v2

    iput-wide v0, p0, Lcom/mrkeyboard/app/MrCacheFiles;->cutoff:J

    const/4 v0, 0x3

    new-array v0, v0, [J

    iput-object v0, p0, Lcom/mrkeyboard/app/MrCacheFiles;->result:[J

    .line 7
    iput-object p1, p0, Lcom/mrkeyboard/app/MrCacheFiles;->root:Ljava/nio/file/Path;

    iput-boolean p2, p0, Lcom/mrkeyboard/app/MrCacheFiles;->expiryOnly:Z

    return-void
.end method

.method private allowed(Ljava/nio/file/Path;)Z
    .registers 3

    .line 20
    invoke-interface {p1}, Ljava/nio/file/Path;->toAbsolutePath()Ljava/nio/file/Path;

    move-result-object p1

    invoke-interface {p1}, Ljava/nio/file/Path;->normalize()Ljava/nio/file/Path;

    move-result-object p1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrCacheFiles;->root:Ljava/nio/file/Path;

    invoke-interface {p1, v0}, Ljava/nio/file/Path;->startsWith(Ljava/nio/file/Path;)Z

    move-result p1

    return p1
.end method

.method static expire(Ljava/io/File;)V
    .registers 2

    .line 9
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrCacheFiles;->scan(Ljava/io/File;Z)[J

    return-void
.end method

.method static purge(Ljava/io/File;)[J
    .registers 2

    .line 8
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrCacheFiles;->scan(Ljava/io/File;Z)[J

    move-result-object p0

    return-object p0
.end method

.method private static scan(Ljava/io/File;Z)[J
    .registers 9

    .line 11
    new-instance v0, Lcom/mrkeyboard/app/MrCacheFiles;

    invoke-virtual {p0}, Ljava/io/File;->toPath()Ljava/nio/file/Path;

    move-result-object p0

    invoke-interface {p0}, Ljava/nio/file/Path;->toAbsolutePath()Ljava/nio/file/Path;

    move-result-object p0

    invoke-interface {p0}, Ljava/nio/file/Path;->normalize()Ljava/nio/file/Path;

    move-result-object p0

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrCacheFiles;-><init>(Ljava/nio/file/Path;Z)V

    .line 13
    const-wide/16 p0, 0x1

    const/4 v1, 0x2

    :try_start_14
    iget-object v2, v0, Lcom/mrkeyboard/app/MrCacheFiles;->root:Ljava/nio/file/Path;

    const-class v3, Ljava/nio/file/attribute/BasicFileAttributes;

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/nio/file/LinkOption;

    sget-object v5, Ljava/nio/file/LinkOption;->NOFOLLOW_LINKS:Ljava/nio/file/LinkOption;

    const/4 v6, 0x0

    aput-object v5, v4, v6

    invoke-static {v2, v3, v4}, Ljava/nio/file/Files;->readAttributes(Ljava/nio/file/Path;Ljava/lang/Class;[Ljava/nio/file/LinkOption;)Ljava/nio/file/attribute/BasicFileAttributes;

    move-result-object v2

    .line 14
    invoke-interface {v2}, Ljava/nio/file/attribute/BasicFileAttributes;->isSymbolicLink()Z

    move-result v3

    if-nez v3, :cond_37

    invoke-interface {v2}, Ljava/nio/file/attribute/BasicFileAttributes;->isDirectory()Z

    move-result v2

    if-nez v2, :cond_31

    goto :goto_37

    .line 15
    :cond_31
    iget-object v2, v0, Lcom/mrkeyboard/app/MrCacheFiles;->root:Ljava/nio/file/Path;

    invoke-static {v2, v0}, Ljava/nio/file/Files;->walkFileTree(Ljava/nio/file/Path;Ljava/nio/file/FileVisitor;)Ljava/nio/file/Path;

    goto :goto_4d

    .line 14
    :cond_37
    :goto_37
    iget-object v2, v0, Lcom/mrkeyboard/app/MrCacheFiles;->result:[J

    aget-wide v3, v2, v1

    add-long/2addr v3, p0

    aput-wide v3, v2, v1

    iget-object p0, v0, Lcom/mrkeyboard/app/MrCacheFiles;->result:[J
    :try_end_40
    .catch Ljava/nio/file/NoSuchFileException; {:try_start_14 .. :try_end_40} :catch_4c
    .catch Ljava/io/IOException; {:try_start_14 .. :try_end_40} :catch_43
    .catch Ljava/lang/RuntimeException; {:try_start_14 .. :try_end_40} :catch_41

    return-object p0

    .line 17
    :catch_41
    move-exception v2

    goto :goto_44

    :catch_43
    move-exception v2

    :goto_44
    iget-object v2, v0, Lcom/mrkeyboard/app/MrCacheFiles;->result:[J

    aget-wide v3, v2, v1

    add-long/2addr v3, p0

    aput-wide v3, v2, v1

    goto :goto_4e

    .line 16
    :catch_4c
    move-exception p0

    .line 17
    :goto_4d
    nop

    .line 18
    :goto_4e
    iget-object p0, v0, Lcom/mrkeyboard/app/MrCacheFiles;->result:[J

    return-object p0
.end method


# virtual methods
.method public bridge synthetic postVisitDirectory(Ljava/lang/Object;Ljava/io/IOException;)Ljava/nio/file/FileVisitResult;
    .registers 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 5
    check-cast p1, Ljava/nio/file/Path;

    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/MrCacheFiles;->postVisitDirectory(Ljava/nio/file/Path;Ljava/io/IOException;)Ljava/nio/file/FileVisitResult;

    move-result-object p1

    return-object p1
.end method

.method public postVisitDirectory(Ljava/nio/file/Path;Ljava/io/IOException;)Ljava/nio/file/FileVisitResult;
    .registers 8

    .line 34
    const-wide/16 v0, 0x1

    const/4 v2, 0x2

    if-eqz p2, :cond_c

    iget-object p2, p0, Lcom/mrkeyboard/app/MrCacheFiles;->result:[J

    aget-wide v3, p2, v2

    add-long/2addr v3, v0

    aput-wide v3, p2, v2

    .line 35
    :cond_c
    iget-object p2, p0, Lcom/mrkeyboard/app/MrCacheFiles;->root:Ljava/nio/file/Path;

    invoke-virtual {p1, p2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_2f

    :try_start_14
    invoke-static {p1}, Ljava/nio/file/Files;->deleteIfExists(Ljava/nio/file/Path;)Z
    :try_end_17
    .catch Ljava/nio/file/DirectoryNotEmptyException; {:try_start_14 .. :try_end_17} :catch_23
    .catch Ljava/io/IOException; {:try_start_14 .. :try_end_17} :catch_1a
    .catch Ljava/lang/RuntimeException; {:try_start_14 .. :try_end_17} :catch_18

    goto :goto_2f

    :catch_18
    move-exception p1

    goto :goto_1b

    :catch_1a
    move-exception p1

    :goto_1b
    iget-object p1, p0, Lcom/mrkeyboard/app/MrCacheFiles;->result:[J

    aget-wide v3, p1, v2

    add-long/2addr v3, v0

    aput-wide v3, p1, v2

    goto :goto_2f

    :catch_23
    move-exception p1

    iget-boolean p1, p0, Lcom/mrkeyboard/app/MrCacheFiles;->expiryOnly:Z

    if-nez p1, :cond_2f

    iget-object p1, p0, Lcom/mrkeyboard/app/MrCacheFiles;->result:[J

    aget-wide v3, p1, v2

    add-long/2addr v3, v0

    aput-wide v3, p1, v2

    .line 36
    :cond_2f
    :goto_2f
    sget-object p1, Ljava/nio/file/FileVisitResult;->CONTINUE:Ljava/nio/file/FileVisitResult;

    return-object p1
.end method

.method public bridge synthetic preVisitDirectory(Ljava/lang/Object;Ljava/nio/file/attribute/BasicFileAttributes;)Ljava/nio/file/FileVisitResult;
    .registers 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 5
    check-cast p1, Ljava/nio/file/Path;

    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/MrCacheFiles;->preVisitDirectory(Ljava/nio/file/Path;Ljava/nio/file/attribute/BasicFileAttributes;)Ljava/nio/file/FileVisitResult;

    move-result-object p1

    return-object p1
.end method

.method public preVisitDirectory(Ljava/nio/file/Path;Ljava/nio/file/attribute/BasicFileAttributes;)Ljava/nio/file/FileVisitResult;
    .registers 7

    .line 22
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrCacheFiles;->allowed(Ljava/nio/file/Path;)Z

    move-result p2

    if-eqz p2, :cond_14

    invoke-interface {p1}, Ljava/nio/file/Path;->toFile()Ljava/io/File;

    move-result-object p1

    invoke-static {p1}, Lcom/mrkeyboard/app/MrCopyRetention;->isActive(Ljava/io/File;)Z

    move-result p1

    if-eqz p1, :cond_11

    goto :goto_14

    .line 23
    :cond_11
    sget-object p1, Ljava/nio/file/FileVisitResult;->CONTINUE:Ljava/nio/file/FileVisitResult;

    return-object p1

    .line 22
    :cond_14
    :goto_14
    iget-object p1, p0, Lcom/mrkeyboard/app/MrCacheFiles;->result:[J

    const/4 p2, 0x2

    aget-wide v0, p1, p2

    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    aput-wide v0, p1, p2

    sget-object p1, Ljava/nio/file/FileVisitResult;->SKIP_SUBTREE:Ljava/nio/file/FileVisitResult;

    return-object p1
.end method

.method public bridge synthetic visitFile(Ljava/lang/Object;Ljava/nio/file/attribute/BasicFileAttributes;)Ljava/nio/file/FileVisitResult;
    .registers 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 5
    check-cast p1, Ljava/nio/file/Path;

    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/MrCacheFiles;->visitFile(Ljava/nio/file/Path;Ljava/nio/file/attribute/BasicFileAttributes;)Ljava/nio/file/FileVisitResult;

    move-result-object p1

    return-object p1
.end method

.method public visitFile(Ljava/nio/file/Path;Ljava/nio/file/attribute/BasicFileAttributes;)Ljava/nio/file/FileVisitResult;
    .registers 11

    .line 26
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCacheFiles;->root:Ljava/nio/file/Path;

    invoke-virtual {p1, v0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x2

    const-wide/16 v2, 0x1

    if-nez v0, :cond_65

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrCacheFiles;->allowed(Ljava/nio/file/Path;)Z

    move-result v0

    if-eqz v0, :cond_65

    invoke-interface {p1}, Ljava/nio/file/Path;->toFile()Ljava/io/File;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrCopyRetention;->isActive(Ljava/io/File;)Z

    move-result v0

    if-eqz v0, :cond_1c

    goto :goto_65

    .line 27
    :cond_1c
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrCacheFiles;->expiryOnly:Z

    if-eqz v0, :cond_37

    invoke-interface {p2}, Ljava/nio/file/attribute/BasicFileAttributes;->isRegularFile()Z

    move-result v0

    if-eqz v0, :cond_37

    invoke-interface {p2}, Ljava/nio/file/attribute/BasicFileAttributes;->lastModifiedTime()Ljava/nio/file/attribute/FileTime;

    move-result-object v0

    invoke-virtual {v0}, Ljava/nio/file/attribute/FileTime;->toMillis()J

    move-result-wide v4

    iget-wide v6, p0, Lcom/mrkeyboard/app/MrCacheFiles;->cutoff:J

    cmp-long v0, v4, v6

    if-lez v0, :cond_37

    sget-object p1, Ljava/nio/file/FileVisitResult;->CONTINUE:Ljava/nio/file/FileVisitResult;

    return-object p1

    .line 28
    :cond_37
    :try_start_37
    invoke-static {p1}, Ljava/nio/file/Files;->deleteIfExists(Ljava/nio/file/Path;)Z

    move-result p1

    if-eqz p1, :cond_57

    iget-object p1, p0, Lcom/mrkeyboard/app/MrCacheFiles;->result:[J

    const/4 v0, 0x0

    aget-wide v4, p1, v0

    add-long/2addr v4, v2

    aput-wide v4, p1, v0

    invoke-interface {p2}, Ljava/nio/file/attribute/BasicFileAttributes;->isRegularFile()Z

    move-result p1

    if-eqz p1, :cond_57

    iget-object p1, p0, Lcom/mrkeyboard/app/MrCacheFiles;->result:[J

    const/4 v0, 0x1

    aget-wide v4, p1, v0

    invoke-interface {p2}, Ljava/nio/file/attribute/BasicFileAttributes;->size()J

    move-result-wide v6

    add-long/2addr v4, v6

    aput-wide v4, p1, v0
    :try_end_57
    .catch Ljava/io/IOException; {:try_start_37 .. :try_end_57} :catch_5a
    .catch Ljava/lang/RuntimeException; {:try_start_37 .. :try_end_57} :catch_58

    .line 29
    :cond_57
    goto :goto_62

    :catch_58
    move-exception p1

    goto :goto_5b

    :catch_5a
    move-exception p1

    :goto_5b
    iget-object p1, p0, Lcom/mrkeyboard/app/MrCacheFiles;->result:[J

    aget-wide v4, p1, v1

    add-long/2addr v4, v2

    aput-wide v4, p1, v1

    .line 30
    :goto_62
    sget-object p1, Ljava/nio/file/FileVisitResult;->CONTINUE:Ljava/nio/file/FileVisitResult;

    return-object p1

    .line 26
    :cond_65
    :goto_65
    iget-object p1, p0, Lcom/mrkeyboard/app/MrCacheFiles;->result:[J

    aget-wide v4, p1, v1

    add-long/2addr v4, v2

    aput-wide v4, p1, v1

    sget-object p1, Ljava/nio/file/FileVisitResult;->CONTINUE:Ljava/nio/file/FileVisitResult;

    return-object p1
.end method

.method public bridge synthetic visitFileFailed(Ljava/lang/Object;Ljava/io/IOException;)Ljava/nio/file/FileVisitResult;
    .registers 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 5
    check-cast p1, Ljava/nio/file/Path;

    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/MrCacheFiles;->visitFileFailed(Ljava/nio/file/Path;Ljava/io/IOException;)Ljava/nio/file/FileVisitResult;

    move-result-object p1

    return-object p1
.end method

.method public visitFileFailed(Ljava/nio/file/Path;Ljava/io/IOException;)Ljava/nio/file/FileVisitResult;
    .registers 7

    .line 32
    iget-object p1, p0, Lcom/mrkeyboard/app/MrCacheFiles;->result:[J

    const/4 p2, 0x2

    aget-wide v0, p1, p2

    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    aput-wide v0, p1, p2

    sget-object p1, Ljava/nio/file/FileVisitResult;->CONTINUE:Ljava/nio/file/FileVisitResult;

    return-object p1
.end method
