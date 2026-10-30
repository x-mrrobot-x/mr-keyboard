.class public Lcom/mrkeyboard/app/LatinIMEBackupAgent;
.super Landroid/app/backup/BackupAgentHelper;
.source "LatinIMEBackupAgent.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Landroid/app/backup/BackupAgentHelper;-><init>()V

    return-void
.end method


# virtual methods
.method public onCreate()V
    .locals 5

    const-string v0, "shared_pref"

    .line 29
    new-instance v1, Landroid/app/backup/SharedPreferencesBackupHelper;

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 30
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIMEBackupAgent;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, "_preferences"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    aput-object v3, v2, v4

    invoke-direct {v1, p0, v2}, Landroid/app/backup/SharedPreferencesBackupHelper;-><init>(Landroid/content/Context;[Ljava/lang/String;)V

    .line 29
    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/LatinIMEBackupAgent;->addHelper(Ljava/lang/String;Landroid/app/backup/BackupHelper;)V

    new-instance v1, Landroid/app/backup/FileBackupHelper;

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "sheets.json"

    const/4 v4, 0x0

    aput-object v3, v2, v4

    invoke-direct {v1, p0, v2}, Landroid/app/backup/FileBackupHelper;-><init>(Landroid/content/Context;[Ljava/lang/String;)V

    const-string v0, "sheets_file"

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/LatinIMEBackupAgent;->addHelper(Ljava/lang/String;Landroid/app/backup/BackupHelper;)V

    return-void
.end method

.method public onRestoreFinished()V
    .locals 0

    invoke-super {p0}, Landroid/app/backup/BackupAgentHelper;->onRestoreFinished()V

    invoke-static {}, Lcom/mrkeyboard/app/SheetStore;->invalidateCache()V

    return-void
.end method
