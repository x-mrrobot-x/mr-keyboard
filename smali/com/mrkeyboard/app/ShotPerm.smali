.class public Lcom/mrkeyboard/app/ShotPerm;
.super Landroid/app/Activity;
.source "ShotPerm.java"


.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V

    .locals 3

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->hasPerm()Z

    move-result v0

    if-eqz v0, :cond_ask

    sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sMore:Z

    if-nez v0, :cond_ask

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->reload()V

    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    return-void

    :cond_ask

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_media

    :try_start_0

    const-string v0, "package:"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.settings.MANAGE_APP_ALL_FILES_ACCESS_PERMISSION"

    invoke-direct {v1, v2, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    const/16 v0, 0x2c

    invoke-virtual {p0, v1, v0}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V

    :try_end_0

    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0

    move-exception v0

    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    return-void

    :cond_media

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->perms()[Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x2b

    invoke-virtual {p0, v0, v1}, Landroid/app/Activity;->requestPermissions([Ljava/lang/String;I)V

    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 0

    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->reload()V

    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V

    .locals 0

    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->reload()V

    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    return-void

.end method
