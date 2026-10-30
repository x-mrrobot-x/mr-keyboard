.class final Lcom/mrkeyboard/app/MrWorkPools;
.super Ljava/lang/Object;
.method static create(II)Ljava/util/concurrent/ExecutorService;
 .locals 2
 new-instance v0, Lcom/mrkeyboard/app/MrReusablePool;
 const/4 v1, 0x0
 invoke-direct {v0, p0, p1, v1}, Lcom/mrkeyboard/app/MrReusablePool;-><init>(IIZ)V
 return-object v0
.end method
.method static latest(II)Ljava/util/concurrent/ExecutorService;
 .locals 2
 new-instance v0, Lcom/mrkeyboard/app/MrReusablePool;
 const/4 v1, 0x1
 invoke-direct {v0, p0, p1, v1}, Lcom/mrkeyboard/app/MrReusablePool;-><init>(IIZ)V
 return-object v0
.end method
