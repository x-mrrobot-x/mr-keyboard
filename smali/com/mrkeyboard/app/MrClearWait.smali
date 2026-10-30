.class final Lcom/mrkeyboard/app/MrClearWait;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;

.method constructor <init>()V
 .locals 0
 invoke-direct {p0}, Ljava/lang/Object;-><init>()V
 return-void
.end method

.method public run()V
 .locals 1
 invoke-static {}, Lcom/mrkeyboard/app/MrCacheClear;->isBusy()Z
 move-result v0
 if-eqz v0, :done
 invoke-static {}, Lcom/mrkeyboard/app/MrShots;->showWait()V
 :done
 return-void
.end method
