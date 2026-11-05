.class final Lcom/mrkeyboard/app/MrUpdateInstall;
.super Ljava/lang/Object;
.source "MrUpdateInstall.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrUpdateInstall$Job;,
        Lcom/mrkeyboard/app/MrUpdateInstall$Failure;,
        Lcom/mrkeyboard/app/MrUpdateInstall$Sink;,
        Lcom/mrkeyboard/app/MrUpdateInstall$Copied;,
        Lcom/mrkeyboard/app/MrUpdateInstall$Listener;,
        Lcom/mrkeyboard/app/MrUpdateInstall$Target;,
        Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;
    }
.end annotation


# static fields
.field static final ACTION:Ljava/lang/String; = "com.mrkeyboard.app.UPDATE_RESULT"

.field static final ACTION_UNKNOWN_SOURCES:Ljava/lang/String; = "android.settings.MANAGE_UNKNOWN_APP_SOURCES"

.field static final APK_NAME:Ljava/lang/String; = "mr-keyboard.apk"

.field private static final BLOCK:I = 0x10000

.field static final DOWNLOADING:I = 0x1

.field static final INSTALLING:I = 0x3

.field static final VERIFYING:I = 0x2

.field private static sJob:Lcom/mrkeyboard/app/MrUpdateInstall$Job;


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static abandonMine(Landroid/content/pm/PackageInstaller;)V
    .locals 2

    .prologue
    .line 385
    invoke-virtual {p0}, Landroid/content/pm/PackageInstaller;->getMySessions()Ljava/util/List;

    move-result-object v0

    .line 386
    if-nez v0, :cond_1

    .line 394
    :cond_0
    return-void

    .line 387
    :cond_1
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/PackageInstaller$SessionInfo;

    .line 389
    :try_start_0
    invoke-virtual {v0}, Landroid/content/pm/PackageInstaller$SessionInfo;->getSessionId()I

    move-result v0

    invoke-virtual {p0, v0}, Landroid/content/pm/PackageInstaller;->abandonSession(I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 390
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static synthetic access$000(Ljava/io/IOException;)Lcom/mrkeyboard/app/MrUpdateInstall$Failure;
    .locals 1

    .prologue
    .line 32
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateInstall;->writeFailure(Ljava/io/IOException;)Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$100()Lcom/mrkeyboard/app/MrUpdateInstall$Job;
    .locals 1

    .prologue
    .line 32
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateInstall;->sJob:Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    return-object v0
.end method

.method static synthetic access$102(Lcom/mrkeyboard/app/MrUpdateInstall$Job;)Lcom/mrkeyboard/app/MrUpdateInstall$Job;
    .locals 0

    .prologue
    .line 32
    sput-object p0, Lcom/mrkeyboard/app/MrUpdateInstall;->sJob:Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    return-object p0
.end method

.method static synthetic access$200(Landroid/content/pm/PackageInstaller;)V
    .locals 0

    .prologue
    .line 32
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateInstall;->abandonMine(Landroid/content/pm/PackageInstaller;)V

    return-void
.end method

.method static declared-synchronized busy()Z
    .locals 2

    .prologue
    .line 317
    const-class v1, Lcom/mrkeyboard/app/MrUpdateInstall;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateInstall;->sJob:Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrUpdateInstall;->sJob:Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->isCommitted()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    monitor-exit v1

    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static canInstall(Landroid/content/Context;)Z
    .locals 1

    .prologue
    .line 366
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/pm/PackageManager;->canRequestPackageInstalls()Z

    move-result v0

    return v0
.end method

.method static declared-synchronized cancel()V
    .locals 2

    .prologue
    .line 342
    const-class v1, Lcom/mrkeyboard/app/MrUpdateInstall;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateInstall;->sJob:Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrUpdateInstall;->sJob:Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->isCommitted()Z

    move-result v0

    if-nez v0, :cond_0

    .line 343
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateInstall;->sJob:Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->cancel()V

    .line 344
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrUpdateInstall;->sJob:Lcom/mrkeyboard/app/MrUpdateInstall$Job;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 346
    :cond_0
    monitor-exit v1

    return-void

    .line 342
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static cleanup(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 376
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall;->busy()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 382
    :goto_0
    return-void

    .line 378
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/pm/PackageManager;->getPackageInstaller()Landroid/content/pm/PackageInstaller;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateInstall;->abandonMine(Landroid/content/pm/PackageInstaller;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 379
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static copy(Ljava/io/InputStream;JLjava/io/OutputStream;JLcom/mrkeyboard/app/MrUpdateInstall$Sink;)Lcom/mrkeyboard/app/MrUpdateInstall$Copied;
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrUpdateInstall$Failure;
        }
    .end annotation

    .prologue
    const-wide/16 v4, 0x0

    const/4 v10, 0x0

    .line 161
    cmp-long v2, p1, v4

    if-lez v2, :cond_0

    cmp-long v2, p1, p4

    if-eqz v2, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall;->mismatch()Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    move-result-object v2

    throw v2

    .line 164
    :cond_0
    :try_start_0
    const-string v2, "SHA-256"

    invoke-static {v2}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v6

    .line 168
    const/high16 v2, 0x10000

    new-array v7, v2, [B

    .line 170
    const/4 v3, -0x1

    .line 174
    :goto_0
    :try_start_1
    invoke-virtual {p0, v7}, Ljava/io/InputStream;->read([B)I
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    move-result v2

    .line 179
    if-gez v2, :cond_2

    .line 195
    new-instance v2, Lcom/mrkeyboard/app/MrUpdateInstall$Copied;

    invoke-direct {v2}, Lcom/mrkeyboard/app/MrUpdateInstall$Copied;-><init>()V

    .line 196
    iput-wide v4, v2, Lcom/mrkeyboard/app/MrUpdateInstall$Copied;->total:J

    .line 197
    invoke-virtual {v6}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->hex([B)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lcom/mrkeyboard/app/MrUpdateInstall$Copied;->sha256:Ljava/lang/String;

    .line 198
    return-object v2

    .line 165
    :catch_0
    move-exception v2

    .line 166
    new-instance v2, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    const-string v3, "mr_update_err_install"

    const/4 v4, 0x0

    invoke-direct {v2, v3, v4, v10}, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v2

    .line 175
    :catch_1
    move-exception v2

    .line 176
    invoke-interface/range {p6 .. p6}, Lcom/mrkeyboard/app/MrUpdateInstall$Sink;->cancelled()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;->cancelled()Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    move-result-object v2

    throw v2

    .line 177
    :cond_1
    invoke-static {v2}, Lcom/mrkeyboard/app/MrUpdateInstall;->readFailure(Ljava/io/IOException;)Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    move-result-object v2

    throw v2

    .line 180
    :cond_2
    invoke-interface/range {p6 .. p6}, Lcom/mrkeyboard/app/MrUpdateInstall$Sink;->cancelled()Z

    move-result v8

    if-eqz v8, :cond_3

    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;->cancelled()Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    move-result-object v2

    throw v2

    .line 181
    :cond_3
    int-to-long v8, v2

    add-long/2addr v4, v8

    .line 182
    cmp-long v8, v4, p4

    if-lez v8, :cond_4

    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall;->mismatch()Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    move-result-object v2

    throw v2

    .line 183
    :cond_4
    invoke-virtual {v6, v7, v10, v2}, Ljava/security/MessageDigest;->update([BII)V

    .line 185
    const/4 v8, 0x0

    :try_start_2
    invoke-virtual {p3, v7, v8, v2}, Ljava/io/OutputStream;->write([BII)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    .line 189
    move-wide/from16 v0, p4

    invoke-static {v4, v5, v0, v1}, Lcom/mrkeyboard/app/MrUpdateInstall;->percent(JJ)I

    move-result v2

    .line 190
    if-eq v2, v3, :cond_5

    .line 192
    move-object/from16 v0, p6

    invoke-interface {v0, v2}, Lcom/mrkeyboard/app/MrUpdateInstall$Sink;->percent(I)V

    :goto_1
    move v3, v2

    .line 194
    goto :goto_0

    .line 186
    :catch_2
    move-exception v2

    .line 187
    invoke-static {v2}, Lcom/mrkeyboard/app/MrUpdateInstall;->writeFailure(Ljava/io/IOException;)Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    move-result-object v2

    throw v2

    :cond_5
    move v2, v3

    goto :goto_1
.end method

.method static flow(Lcom/mrkeyboard/app/MrUpdate$Notice;Lcom/mrkeyboard/app/MrUpdateInstall$Target;Lcom/mrkeyboard/app/MrUpdateInstall$Listener;Lcom/mrkeyboard/app/MrUpdateInstall$Sink;)V
    .locals 11

    .prologue
    const/4 v8, 0x1

    const/4 v9, 0x0

    const/4 v7, 0x0

    .line 208
    .line 212
    const/4 v0, 0x1

    const/4 v1, 0x0

    :try_start_0
    invoke-interface {p2, v0, v1}, Lcom/mrkeyboard/app/MrUpdateInstall$Listener;->state(II)V

    .line 213
    const/4 v0, 0x1

    new-array v1, v0, [J
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrUpdateInstall$Failure; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_3
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 215
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sNet:Lcom/mrkeyboard/app/MrPacks$Net;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrUpdate$Notice;->apkUrl()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v2, v1}, Lcom/mrkeyboard/app/MrPacks$Net;->open(Ljava/lang/String;[J)Ljava/io/InputStream;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Lcom/mrkeyboard/app/MrUpdateInstall$Failure; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v0

    .line 221
    :try_start_2
    invoke-interface {p1}, Lcom/mrkeyboard/app/MrUpdateInstall$Target;->openWrite()Ljava/io/OutputStream;
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_4
    .catch Lcom/mrkeyboard/app/MrUpdateInstall$Failure; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_5
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-result-object v3

    .line 225
    const/4 v2, 0x0

    :try_start_3
    aget-wide v1, v1, v2

    iget-wide v4, p0, Lcom/mrkeyboard/app/MrUpdate$Notice;->apkSize:J

    move-object v6, p3

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrUpdateInstall;->copy(Ljava/io/InputStream;JLjava/io/OutputStream;JLcom/mrkeyboard/app/MrUpdateInstall$Sink;)Lcom/mrkeyboard/app/MrUpdateInstall$Copied;

    move-result-object v1

    .line 226
    const/4 v2, 0x2

    const/16 v4, 0x64

    invoke-interface {p2, v2, v4}, Lcom/mrkeyboard/app/MrUpdateInstall$Listener;->state(II)V

    .line 227
    invoke-static {v1, p0}, Lcom/mrkeyboard/app/MrUpdateInstall;->verify(Lcom/mrkeyboard/app/MrUpdateInstall$Copied;Lcom/mrkeyboard/app/MrUpdate$Notice;)V
    :try_end_3
    .catch Lcom/mrkeyboard/app/MrUpdateInstall$Failure; {:try_start_3 .. :try_end_3} :catch_7
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_8
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 229
    :try_start_4
    invoke-interface {p1, v3}, Lcom/mrkeyboard/app/MrUpdateInstall$Target;->sync(Ljava/io/OutputStream;)V

    .line 230
    invoke-virtual {v3}, Ljava/io/OutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_6
    .catch Lcom/mrkeyboard/app/MrUpdateInstall$Failure; {:try_start_4 .. :try_end_4} :catch_7
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_8
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 235
    :try_start_5
    invoke-interface {p3}, Lcom/mrkeyboard/app/MrUpdateInstall$Sink;->beginCommit()Z

    move-result v1

    if-nez v1, :cond_3

    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;->cancelled()Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    move-result-object v1

    throw v1
    :try_end_5
    .catch Lcom/mrkeyboard/app/MrUpdateInstall$Failure; {:try_start_5 .. :try_end_5} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_5 .. :try_end_5} :catch_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 239
    :catch_0
    move-exception v1

    move-object v3, v9

    move-object v9, v0

    move-object v0, v1

    move v1, v7

    .line 241
    :goto_0
    :try_start_6
    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;->isCancel()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-interface {p3}, Lcom/mrkeyboard/app/MrUpdateInstall$Sink;->cancelled()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-interface {p2, v0}, Lcom/mrkeyboard/app/MrUpdateInstall$Listener;->failed(Lcom/mrkeyboard/app/MrUpdateInstall$Failure;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_4

    .line 246
    :cond_0
    invoke-static {v9}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 247
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 248
    if-eqz v1, :cond_4

    invoke-interface {p1}, Lcom/mrkeyboard/app/MrUpdateInstall$Target;->close()V

    .line 251
    :goto_1
    return-void

    .line 216
    :catch_1
    move-exception v0

    .line 217
    :try_start_7
    invoke-interface {p3}, Lcom/mrkeyboard/app/MrUpdateInstall$Sink;->cancelled()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;->cancelled()Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    move-result-object v0

    throw v0

    .line 239
    :catch_2
    move-exception v0

    move v1, v7

    move-object v3, v9

    goto :goto_0

    .line 218
    :cond_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateInstall;->readFailure(Ljava/io/IOException;)Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    move-result-object v0

    throw v0
    :try_end_7
    .catch Lcom/mrkeyboard/app/MrUpdateInstall$Failure; {:try_start_7 .. :try_end_7} :catch_2
    .catch Ljava/lang/RuntimeException; {:try_start_7 .. :try_end_7} :catch_3
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 242
    :catch_3
    move-exception v0

    move-object v0, v9

    .line 244
    :goto_2
    :try_start_8
    invoke-interface {p3}, Lcom/mrkeyboard/app/MrUpdateInstall$Sink;->cancelled()Z

    move-result v1

    if-nez v1, :cond_2

    new-instance v1, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    const-string v2, "mr_update_err_install"

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-direct {v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    invoke-interface {p2, v1}, Lcom/mrkeyboard/app/MrUpdateInstall$Listener;->failed(Lcom/mrkeyboard/app/MrUpdateInstall$Failure;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    .line 246
    :cond_2
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 247
    invoke-static {v9}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 248
    if-eqz v7, :cond_5

    invoke-interface {p1}, Lcom/mrkeyboard/app/MrUpdateInstall$Target;->close()V

    goto :goto_1

    .line 222
    :catch_4
    move-exception v1

    .line 223
    :try_start_9
    invoke-static {v1}, Lcom/mrkeyboard/app/MrUpdateInstall;->writeFailure(Ljava/io/IOException;)Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    move-result-object v1

    throw v1
    :try_end_9
    .catch Lcom/mrkeyboard/app/MrUpdateInstall$Failure; {:try_start_9 .. :try_end_9} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_9 .. :try_end_9} :catch_5
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    .line 242
    :catch_5
    move-exception v1

    goto :goto_2

    .line 232
    :catch_6
    move-exception v1

    .line 233
    :try_start_a
    invoke-static {v1}, Lcom/mrkeyboard/app/MrUpdateInstall;->writeFailure(Ljava/io/IOException;)Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    move-result-object v1

    throw v1
    :try_end_a
    .catch Lcom/mrkeyboard/app/MrUpdateInstall$Failure; {:try_start_a .. :try_end_a} :catch_7
    .catch Ljava/lang/RuntimeException; {:try_start_a .. :try_end_a} :catch_8
    .catchall {:try_start_a .. :try_end_a} :catchall_2

    .line 239
    :catch_7
    move-exception v1

    move-object v9, v0

    move-object v0, v1

    move v1, v7

    goto :goto_0

    .line 236
    :cond_3
    :try_start_b
    invoke-interface {p1}, Lcom/mrkeyboard/app/MrUpdateInstall$Target;->commit()V
    :try_end_b
    .catch Lcom/mrkeyboard/app/MrUpdateInstall$Failure; {:try_start_b .. :try_end_b} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_b .. :try_end_b} :catch_5
    .catchall {:try_start_b .. :try_end_b} :catchall_1

    .line 238
    const/4 v1, 0x3

    const/16 v2, 0x64

    :try_start_c
    invoke-interface {p2, v1, v2}, Lcom/mrkeyboard/app/MrUpdateInstall$Listener;->state(II)V
    :try_end_c
    .catch Lcom/mrkeyboard/app/MrUpdateInstall$Failure; {:try_start_c .. :try_end_c} :catch_a
    .catch Ljava/lang/RuntimeException; {:try_start_c .. :try_end_c} :catch_9
    .catchall {:try_start_c .. :try_end_c} :catchall_3

    .line 246
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 247
    invoke-static {v9}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 248
    invoke-interface {p1}, Lcom/mrkeyboard/app/MrUpdateInstall$Target;->close()V

    goto :goto_1

    .line 249
    :cond_4
    invoke-interface {p1}, Lcom/mrkeyboard/app/MrUpdateInstall$Target;->abandon()V

    goto :goto_1

    :cond_5
    invoke-interface {p1}, Lcom/mrkeyboard/app/MrUpdateInstall$Target;->abandon()V

    goto :goto_1

    .line 246
    :catchall_0
    move-exception v0

    move-object v1, v9

    :goto_3
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 247
    invoke-static {v9}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 248
    if-eqz v7, :cond_6

    invoke-interface {p1}, Lcom/mrkeyboard/app/MrUpdateInstall$Target;->close()V

    .line 250
    :goto_4
    throw v0

    .line 249
    :cond_6
    invoke-interface {p1}, Lcom/mrkeyboard/app/MrUpdateInstall$Target;->abandon()V

    goto :goto_4

    .line 246
    :catchall_1
    move-exception v1

    move-object v10, v1

    move-object v1, v0

    move-object v0, v10

    goto :goto_3

    :catchall_2
    move-exception v1

    move-object v9, v3

    move-object v10, v1

    move-object v1, v0

    move-object v0, v10

    goto :goto_3

    :catchall_3
    move-exception v1

    move v7, v8

    move-object v10, v1

    move-object v1, v0

    move-object v0, v10

    goto :goto_3

    :catchall_4
    move-exception v0

    move v7, v1

    move-object v1, v9

    move-object v9, v3

    goto :goto_3

    .line 242
    :catch_8
    move-exception v1

    move-object v9, v3

    goto :goto_2

    :catch_9
    move-exception v1

    move v7, v8

    goto :goto_2

    .line 239
    :catch_a
    move-exception v1

    move-object v3, v9

    move-object v9, v0

    move-object v0, v1

    move v1, v8

    goto/16 :goto_0
.end method

.method static isNoSpace(Ljava/io/IOException;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 135
    invoke-virtual {p0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v1

    .line 136
    if-nez v1, :cond_1

    .line 138
    :cond_0
    :goto_0
    return v0

    .line 137
    :cond_1
    sget-object v2, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    .line 138
    const-string v2, "enospc"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "no space"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method static mismatch()Lcom/mrkeyboard/app/MrUpdateInstall$Failure;
    .locals 4

    .prologue
    .line 153
    new-instance v0, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    const-string v1, "mr_update_err_mismatch"

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    return-object v0
.end method

.method static declared-synchronized onResult(I)V
    .locals 6

    .prologue
    .line 350
    const-class v1, Lcom/mrkeyboard/app/MrUpdateInstall;

    monitor-enter v1

    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrUpdateInstall;->sJob:Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    .line 351
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->isCommitted()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-nez v0, :cond_1

    .line 360
    :cond_0
    :goto_0
    monitor-exit v1

    return-void

    .line 352
    :cond_1
    const/4 v0, 0x0

    :try_start_1
    sput-object v0, Lcom/mrkeyboard/app/MrUpdateInstall;->sJob:Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    .line 353
    if-eqz p0, :cond_0

    .line 354
    const/4 v0, 0x3

    if-ne p0, v0, :cond_2

    .line 355
    iget-object v0, v2, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->listener:Lcom/mrkeyboard/app/MrUpdateInstall$Listener;

    invoke-interface {v0}, Lcom/mrkeyboard/app/MrUpdateInstall$Listener;->aborted()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 350
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0

    .line 358
    :cond_2
    :try_start_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateInstall;->statusKey(I)Ljava/lang/String;

    move-result-object v0

    .line 359
    iget-object v2, v2, Lcom/mrkeyboard/app/MrUpdateInstall$Job;->listener:Lcom/mrkeyboard/app/MrUpdateInstall$Listener;

    new-instance v3, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    if-eqz v0, :cond_3

    :goto_1
    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-direct {v3, v0, v4, v5}, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    invoke-interface {v2, v3}, Lcom/mrkeyboard/app/MrUpdateInstall$Listener;->failed(Lcom/mrkeyboard/app/MrUpdateInstall$Failure;)V

    goto :goto_0

    :cond_3
    const-string v0, "mr_update_err_install"
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1
.end method

.method static percent(JJ)I
    .locals 6

    .prologue
    const-wide/16 v4, 0x64

    const-wide/16 v2, 0x0

    .line 113
    cmp-long v0, p2, v2

    if-lez v0, :cond_0

    cmp-long v0, p0, v2

    if-gtz v0, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 114
    :goto_0
    return v0

    :cond_1
    mul-long v0, p0, v4

    div-long/2addr v0, p2

    invoke-static {v4, v5, v0, v1}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v0

    long-to-int v0, v0

    goto :goto_0
.end method

.method private static readFailure(Ljava/io/IOException;)Lcom/mrkeyboard/app/MrUpdateInstall$Failure;
    .locals 4

    .prologue
    .line 146
    instance-of v0, p0, Lcom/mrkeyboard/app/MrPacks$HttpError;

    if-eqz v0, :cond_0

    .line 147
    new-instance v0, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    const-string v1, "mr_update_err_download"

    const-string v2, "mr_update_err_http"

    check-cast p0, Lcom/mrkeyboard/app/MrPacks$HttpError;

    iget v3, p0, Lcom/mrkeyboard/app/MrPacks$HttpError;->code:I

    invoke-direct {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    .line 149
    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    const-string v1, "mr_update_err_download"

    const-string v2, "mr_update_err_network"

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_0
.end method

.method static settingsIntent(Landroid/content/Context;)Landroid/content/Intent;
    .locals 4

    .prologue
    .line 371
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.MANAGE_UNKNOWN_APP_SOURCES"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "package:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    return-object v0
.end method

.method static declared-synchronized start(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;Lcom/mrkeyboard/app/MrUpdateInstall$Listener;)Z
    .locals 2

    .prologue
    .line 322
    const-class v0, Lcom/mrkeyboard/app/MrUpdateInstall;

    monitor-enter v0

    const/4 v1, 0x0

    :try_start_0
    invoke-static {p0, p1, v1, p2}, Lcom/mrkeyboard/app/MrUpdateInstall;->startJob(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;Lcom/mrkeyboard/app/MrUpdateInstall$Target;Lcom/mrkeyboard/app/MrUpdateInstall$Listener;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private static startJob(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;Lcom/mrkeyboard/app/MrUpdateInstall$Target;Lcom/mrkeyboard/app/MrUpdateInstall$Listener;)Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    .line 331
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall;->busy()Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x0

    .line 337
    :goto_0
    return v0

    .line 332
    :cond_0
    new-instance v1, Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    invoke-direct {v1, p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrUpdateInstall$Job;-><init>(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;Lcom/mrkeyboard/app/MrUpdateInstall$Target;Lcom/mrkeyboard/app/MrUpdateInstall$Listener;)V

    .line 333
    sput-object v1, Lcom/mrkeyboard/app/MrUpdateInstall;->sJob:Lcom/mrkeyboard/app/MrUpdateInstall$Job;

    .line 334
    new-instance v2, Ljava/lang/Thread;

    const-string v3, "mr-update-install"

    invoke-direct {v2, v1, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 335
    invoke-virtual {v2, v0}, Ljava/lang/Thread;->setDaemon(Z)V

    .line 336
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method static declared-synchronized startWith(Lcom/mrkeyboard/app/MrUpdate$Notice;Lcom/mrkeyboard/app/MrUpdateInstall$Target;Lcom/mrkeyboard/app/MrUpdateInstall$Listener;)Z
    .locals 2

    .prologue
    .line 327
    const-class v0, Lcom/mrkeyboard/app/MrUpdateInstall;

    monitor-enter v0

    const/4 v1, 0x0

    :try_start_0
    invoke-static {v1, p0, p1, p2}, Lcom/mrkeyboard/app/MrUpdateInstall;->startJob(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;Lcom/mrkeyboard/app/MrUpdateInstall$Target;Lcom/mrkeyboard/app/MrUpdateInstall$Listener;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method static statusKey(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 122
    packed-switch p0, :pswitch_data_0

    .line 130
    :pswitch_0
    const-string v0, "mr_update_err_install"

    :goto_0
    return-object v0

    .line 126
    :pswitch_1
    const/4 v0, 0x0

    goto :goto_0

    .line 128
    :pswitch_2
    const-string v0, "mr_update_err_storage"

    goto :goto_0

    .line 122
    nop

    :pswitch_data_0
    .packed-switch -0x1
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.method static verify(Lcom/mrkeyboard/app/MrUpdateInstall$Copied;Lcom/mrkeyboard/app/MrUpdate$Notice;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrUpdateInstall$Failure;
        }
    .end annotation

    .prologue
    .line 203
    iget-wide v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Copied;->total:J

    iget-wide v2, p1, Lcom/mrkeyboard/app/MrUpdate$Notice;->apkSize:J

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Copied;->sha256:Ljava/lang/String;

    iget-object v1, p1, Lcom/mrkeyboard/app/MrUpdate$Notice;->apkSha256:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall;->mismatch()Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    move-result-object v0

    throw v0

    .line 204
    :cond_1
    return-void
.end method

.method private static writeFailure(Ljava/io/IOException;)Lcom/mrkeyboard/app/MrUpdateInstall$Failure;
    .locals 4

    .prologue
    .line 142
    new-instance v1, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateInstall;->isNoSpace(Ljava/io/IOException;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "mr_update_err_storage"

    :goto_0
    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-direct {v1, v0, v2, v3}, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    return-object v1

    :cond_0
    const-string v0, "mr_update_err_install"

    goto :goto_0
.end method
