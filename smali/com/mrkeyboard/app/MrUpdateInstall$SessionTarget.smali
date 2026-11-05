.class final Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;
.super Ljava/lang/Object;
.source "MrUpdateInstall.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrUpdateInstall$Target;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrUpdateInstall;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "SessionTarget"
.end annotation


# instance fields
.field private final mApp:Landroid/content/Context;

.field private final mId:I

.field private final mSession:Landroid/content/pm/PackageInstaller$Session;

.field private final mSize:J


# direct methods
.method private constructor <init>(Landroid/content/Context;Landroid/content/pm/PackageInstaller$Session;IJ)V
    .locals 0

    .prologue
    .line 402
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 403
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;->mApp:Landroid/content/Context;

    .line 404
    iput-object p2, p0, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;->mSession:Landroid/content/pm/PackageInstaller$Session;

    .line 405
    iput p3, p0, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;->mId:I

    .line 406
    iput-wide p4, p0, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;->mSize:J

    .line 407
    return-void
.end method

.method static create(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;)Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v4, 0x1

    .line 410
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/pm/PackageManager;->getPackageInstaller()Landroid/content/pm/PackageInstaller;

    move-result-object v0

    .line 411
    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateInstall;->access$200(Landroid/content/pm/PackageInstaller;)V

    .line 412
    new-instance v1, Landroid/content/pm/PackageInstaller$SessionParams;

    invoke-direct {v1, v4}, Landroid/content/pm/PackageInstaller$SessionParams;-><init>(I)V

    .line 413
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/pm/PackageInstaller$SessionParams;->setAppPackageName(Ljava/lang/String;)V

    .line 414
    iget-wide v2, p1, Lcom/mrkeyboard/app/MrUpdate$Notice;->apkSize:J

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageInstaller$SessionParams;->setSize(J)V

    .line 416
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1f

    if-lt v2, v3, :cond_0

    invoke-virtual {v1, v4}, Landroid/content/pm/PackageInstaller$SessionParams;->setRequireUserAction(I)V

    .line 417
    :cond_0
    invoke-virtual {v0, v1}, Landroid/content/pm/PackageInstaller;->createSession(Landroid/content/pm/PackageInstaller$SessionParams;)I

    move-result v3

    .line 420
    :try_start_0
    invoke-virtual {v0, v3}, Landroid/content/pm/PackageInstaller;->openSession(I)Landroid/content/pm/PackageInstaller$Session;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 425
    new-instance v0, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrUpdate$Notice;->apkSize:J

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;-><init>(Landroid/content/Context;Landroid/content/pm/PackageInstaller$Session;IJ)V

    return-object v0

    .line 421
    :catch_0
    move-exception v1

    .line 422
    invoke-virtual {v0, v3}, Landroid/content/pm/PackageInstaller;->abandonSession(I)V

    .line 423
    throw v1
.end method


# virtual methods
.method public abandon()V
    .locals 1

    .prologue
    .line 446
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;->mSession:Landroid/content/pm/PackageInstaller$Session;

    invoke-virtual {v0}, Landroid/content/pm/PackageInstaller$Session;->abandon()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 450
    :goto_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;->close()V

    .line 451
    return-void

    .line 447
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public close()V
    .locals 1

    .prologue
    .line 455
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;->mSession:Landroid/content/pm/PackageInstaller$Session;

    invoke-virtual {v0}, Landroid/content/pm/PackageInstaller$Session;->close()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 459
    :goto_0
    return-void

    .line 456
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public commit()V
    .locals 5

    .prologue
    .line 437
    new-instance v1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;->mApp:Landroid/content/Context;

    const-class v2, Lcom/mrkeyboard/app/MrUpdateReceiver;

    invoke-direct {v1, v0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 438
    const-string v0, "com.mrkeyboard.app.UPDATE_RESULT"

    invoke-virtual {v1, v0}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 439
    const/high16 v0, 0x8000000

    .line 440
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1f

    if-lt v2, v3, :cond_0

    const/high16 v0, 0xa000000

    .line 441
    :cond_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;->mSession:Landroid/content/pm/PackageInstaller$Session;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;->mApp:Landroid/content/Context;

    iget v4, p0, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;->mId:I

    invoke-static {v3, v4, v1, v0}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/PendingIntent;->getIntentSender()Landroid/content/IntentSender;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/content/pm/PackageInstaller$Session;->commit(Landroid/content/IntentSender;)V

    .line 442
    return-void
.end method

.method public openWrite()Ljava/io/OutputStream;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 429
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;->mSession:Landroid/content/pm/PackageInstaller$Session;

    const-string v1, "mr-keyboard.apk"

    const-wide/16 v2, 0x0

    iget-wide v4, p0, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;->mSize:J

    invoke-virtual/range {v0 .. v5}, Landroid/content/pm/PackageInstaller$Session;->openWrite(Ljava/lang/String;JJ)Ljava/io/OutputStream;

    move-result-object v0

    return-object v0
.end method

.method public sync(Ljava/io/OutputStream;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 433
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$SessionTarget;->mSession:Landroid/content/pm/PackageInstaller$Session;

    invoke-virtual {v0, p1}, Landroid/content/pm/PackageInstaller$Session;->fsync(Ljava/io/OutputStream;)V

    .line 434
    return-void
.end method
