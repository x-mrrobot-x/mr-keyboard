.class final Lcom/mrkeyboard/app/MrCopyRetention;
.super Ljava/lang/Object;

.field private static latest:[Ljava/io/File;
.field private static ids:[J
.field private static versions:[Ljava/lang/String;
.field private static active:Ljava/util/concurrent/ConcurrentHashMap;

.method static constructor <clinit>()V
 .locals 2
 const/4 v0, 0x3
 new-array v1, v0, [Ljava/io/File;
 sput-object v1, Lcom/mrkeyboard/app/MrCopyRetention;->latest:[Ljava/io/File;
 new-array v1, v0, [J
 sput-object v1, Lcom/mrkeyboard/app/MrCopyRetention;->ids:[J
 new-array v1, v0, [Ljava/lang/String;
 sput-object v1, Lcom/mrkeyboard/app/MrCopyRetention;->versions:[Ljava/lang/String;
 new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;
 invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V
 sput-object v0, Lcom/mrkeyboard/app/MrCopyRetention;->active:Ljava/util/concurrent/ConcurrentHashMap;
 return-void
.end method

.method static category(J)I
 .locals 3
 const-wide/16 v0, 0x0
 cmp-long v2, p0, v0
 if-ltz v2, :video
 const/4 v0, 0x0
 return v0
 :video
 const/4 v0, 0x1
 return v0
.end method

# One reusable latest copy per category. Old copies retain independent paths.
.method static declared-synchronized reuse(IJ)Ljava/io/File;
 .locals 11
 const-class v9, Lcom/mrkeyboard/app/MrCopyRetention;
 monitor-enter v9
 :sync_try_start
 sget-object v0, Lcom/mrkeyboard/app/MrCopyRetention;->latest:[Ljava/io/File;
 aget-object v1, v0, p0
 if-eqz v1, :miss
 sget-object v2, Lcom/mrkeyboard/app/MrCopyRetention;->ids:[J
 aget-wide v2, v2, p0
 cmp-long v2, v2, p1
 if-nez v2, :miss
 invoke-virtual {v1}, Ljava/io/File;->isFile()Z
 move-result v2
 if-eqz v2, :miss
 invoke-virtual {v1}, Ljava/io/File;->length()J
 move-result-wide v2
 const-wide/16 v4, 0x0
 cmp-long v2, v2, v4
 if-lez v2, :miss
 invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrCopySource;->version(IJ)Ljava/lang/String;
 move-result-object v2
 if-eqz v2, :miss
 sget-object v3, Lcom/mrkeyboard/app/MrCopyRetention;->versions:[Ljava/lang/String;
 aget-object v3, v3, p0
 invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
 move-result v2
 if-eqz v2, :miss
 invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
 move-result-wide v2
 invoke-virtual {v1}, Ljava/io/File;->lastModified()J
 move-result-wide v4
 sub-long v4, v2, v4
 const-wide/32 v6, 0x36ee80
 cmp-long v8, v4, v6
 if-gez v8, :miss
 invoke-virtual {v1, v2, v3}, Ljava/io/File;->setLastModified(J)Z
 move-result v0
 if-eqz v0, :miss
 goto :sync_return_0
 :miss
 const/4 v0, 0x0
 goto :sync_return_1
 :sync_try_end
 .catchall {:sync_try_start .. :sync_try_end} :sync_catchall
 :sync_return_0
 monitor-exit v9
 return-object v1
 :sync_return_1
 monitor-exit v9
 return-object v0
 :sync_catchall
 move-exception v10
 monitor-exit v9
 throw v10
.end method

.method static declared-synchronized remember(IJLjava/io/File;)V
 .locals 4
 const-class v2, Lcom/mrkeyboard/app/MrCopyRetention;
 monitor-enter v2
 :sync_try_start
 sget-object v0, Lcom/mrkeyboard/app/MrCopyRetention;->latest:[Ljava/io/File;
 aput-object p3, v0, p0
 sget-object v0, Lcom/mrkeyboard/app/MrCopyRetention;->ids:[J
 aput-wide p1, v0, p0
 invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrCopySource;->version(IJ)Ljava/lang/String;
 move-result-object v0
 sget-object v1, Lcom/mrkeyboard/app/MrCopyRetention;->versions:[Ljava/lang/String;
 aput-object v0, v1, p0
 goto :sync_return_0
 :sync_try_end
 .catchall {:sync_try_start .. :sync_try_end} :sync_catchall
 :sync_return_0
 monitor-exit v2
 return-void
 :sync_catchall
 move-exception v3
 monitor-exit v2
 throw v3
.end method

.method static touch(Ljava/io/File;)V
 .locals 2
 if-eqz p0, :done
 invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
 move-result-wide v0
 invoke-virtual {p0, v0, v1}, Ljava/io/File;->setLastModified(J)Z
 :done
 return-void
.end method

.method static target(Ljava/io/File;Ljava/lang/String;)Ljava/io/File;
 .locals 4
 invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;
 move-result-object v0
 invoke-virtual {v0}, Ljava/util/UUID;->toString()Ljava/lang/String;
 move-result-object v0
 new-instance v1, Ljava/io/File;
 invoke-direct {v1, p0, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
 invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z
 move-result v0
 if-nez v0, :directory_ready
 new-instance v0, Ljava/io/IOException;
 const-string v2, "Cannot create attachment cache directory"
 invoke-direct {v0, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V
 throw v0
 :directory_ready
 new-instance v0, Ljava/io/File;
 invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V
 invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;
 move-result-object v2
 invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z
 move-result v0
 if-nez v0, :fallback
 const-string v0, "."
 invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
 move-result v0
 if-nez v0, :fallback
 const-string v0, ".."
 invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
 move-result v0
 if-eqz v0, :make_file
 :fallback
 const-string v2, "anexo"
 :make_file
 new-instance v0, Ljava/io/File;
 invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
 return-object v0
.end method

.method static protect(Ljava/io/File;)V
 .locals 2
 sget-object v0, Lcom/mrkeyboard/app/MrCopyRetention;->active:Ljava/util/concurrent/ConcurrentHashMap;
 sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;
 invoke-virtual {v0, p0, v1}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
 return-void
.end method

.method static unprotect(Ljava/io/File;)V
 .locals 1
 sget-object v0, Lcom/mrkeyboard/app/MrCopyRetention;->active:Ljava/util/concurrent/ConcurrentHashMap;
 invoke-virtual {v0, p0}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;
 return-void
.end method

.method static clean(Ljava/io/File;)V
 .locals 0
 invoke-static {p0}, Lcom/mrkeyboard/app/MrCacheFiles;->expire(Ljava/io/File;)V
 return-void
.end method

.method static sweep()V
 .locals 3
 sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;
 if-eqz v0, :done
 invoke-virtual {v0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;
 move-result-object v0
 const-string v1, "shots"
 new-instance v2, Ljava/io/File;
 invoke-direct {v2, v0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
 invoke-static {v2}, Lcom/mrkeyboard/app/MrCopyRetention;->clean(Ljava/io/File;)V
 :done
 return-void
.end method

.method static forget()V
 .locals 2
 const/4 v0, 0x3
 new-array v1, v0, [Ljava/io/File;
 sput-object v1, Lcom/mrkeyboard/app/MrCopyRetention;->latest:[Ljava/io/File;
 new-array v1, v0, [J
 sput-object v1, Lcom/mrkeyboard/app/MrCopyRetention;->ids:[J
 new-array v1, v0, [Ljava/lang/String;
 sput-object v1, Lcom/mrkeyboard/app/MrCopyRetention;->versions:[Ljava/lang/String;
 return-void
.end method

.method static isActive(Ljava/io/File;)Z
 .locals 1
 sget-object v0, Lcom/mrkeyboard/app/MrCopyRetention;->active:Ljava/util/concurrent/ConcurrentHashMap;
 invoke-virtual {v0, p0}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z
 move-result v0
 return v0
.end method
