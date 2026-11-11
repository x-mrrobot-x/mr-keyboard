.class final Lcom/mrkeyboard/app/MrCacheClear;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;

.field private static gate:Ljava/util/concurrent/atomic/AtomicBoolean;
.field app:Landroid/content/Context;
.field oldPools:[Ljava/util/concurrent/ExecutorService;
.field thumbs:I
.field thumbBytes:J
.field lists:I
.field private result:[J
.field private incomplete:Z
.field private phase:I

.method static constructor <clinit>()V
 .locals 1
 new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;
 invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>()V
 sput-object v0, Lcom/mrkeyboard/app/MrCacheClear;->gate:Ljava/util/concurrent/atomic/AtomicBoolean;
 return-void
.end method
.method public constructor <init>()V
 .locals 0
 invoke-direct {p0}, Ljava/lang/Object;-><init>()V
 return-void
.end method
.method static begin()Z
 .locals 3
 sget-object v0, Lcom/mrkeyboard/app/MrCacheClear;->gate:Ljava/util/concurrent/atomic/AtomicBoolean;
 const/4 v1, 0x0
 const/4 v2, 0x1
 invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z
 move-result v0
 return v0
.end method
.method static isBusy()Z
 .locals 1
 sget-object v0, Lcom/mrkeyboard/app/MrCacheClear;->gate:Ljava/util/concurrent/atomic/AtomicBoolean;
 invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z
 move-result v0
 return v0
.end method

.method public run()V
    .locals 8

    iget v0, p0, Lcom/mrkeyboard/app/MrCacheClear;->phase:I

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrCacheClear;->oldPools:[Ljava/util/concurrent/ExecutorService;

    if-eqz v0, :cond_0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrCacheJobs;->awaitQuiet([Ljava/util/concurrent/ExecutorService;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrCacheClear;->incomplete:Z

    :cond_0
    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrCopyRetention;->forget()V

    iget-object v0, p0, Lcom/mrkeyboard/app/MrCacheClear;->app:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v1

    new-instance v2, Ljava/io/File;

    const-string v3, "shots"

    invoke-direct {v2, v1, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {v2}, Lcom/mrkeyboard/app/MrCacheFiles;->purge(Ljava/io/File;)[J

    move-result-object v1

    iput-object v1, p0, Lcom/mrkeyboard/app/MrCacheClear;->result:[J
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const/4 v0, 0x3

    new-array v1, v0, [J

    const/4 v0, 0x2

    const-wide/16 v2, 0x1

    aput-wide v2, v1, v0

    iput-object v1, p0, Lcom/mrkeyboard/app/MrCacheClear;->result:[J

    :goto_0
    const/4 v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrCacheClear;->phase:I

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    move-result v0

    if-nez v0, :cond_4

    sget-object v0, Lcom/mrkeyboard/app/MrCacheClear;->gate:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    sput-boolean v1, Lcom/mrkeyboard/app/MrShots;->sBusy:Z

    return-void

    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrCacheClear;->gate:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrCacheClear;->pending()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_2

    const/4 v0, 0x1

    goto :goto_1

    :cond_2
    const/4 v0, 0x0

    :goto_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->finishCacheClear(Z)V

    :try_start_1
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrCacheClear;->summary()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrShots;->showClearSummary(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    :catch_1
    move-exception v1

    const-string v1, "Limpeza finalizada. Detalhes indispon\u00edveis."

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrShots;->showClearSummary(Ljava/lang/String;)V

    :goto_2
    :try_start_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCacheClear;->app:Landroid/content/Context;

    if-eqz v0, :cond_4

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrCacheClear;->pending()J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long v1, v1, v3

    if-eqz v1, :cond_3

    const-string v1, "Limpeza parcial"

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_3

    :cond_3
    const-string v1, "Cache limpo"

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :goto_3
    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_4

    :catch_2
    move-exception v0

    :cond_4
    :goto_4
    return-void
.end method

.method private pending()J
 .locals 4
 iget-object v0, p0, Lcom/mrkeyboard/app/MrCacheClear;->result:[J
 const/4 v1, 0x2
 aget-wide v0, v0, v1
 iget-boolean v2, p0, Lcom/mrkeyboard/app/MrCacheClear;->incomplete:Z
 if-eqz v2, :done
 const-wide/16 v2, 0x1
 add-long/2addr v0, v2
 :done
 return-wide v0
.end method

.method private summary()Ljava/lang/String;
    .locals 6

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrCacheClear;->pending()J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long v1, v1, v3

    if-eqz v1, :cond_0

    const-string v1, "Limpeza parcial\nAlguns itens tempor\u00e1rios n\u00e3o puderam ser removidos.\nSeus arquivos originais n\u00e3o foram alterados.\nToque em Cache para tentar novamente."

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_0
    const-string v1, "Cache limpo\nSeus arquivos originais n\u00e3o foram alterados.\nC\u00f3pias tempor\u00e1rias: "

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrCacheClear;->result:[J

    const/4 v2, 0x0

    aget-wide v3, v1, v2

    invoke-virtual {v0, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v2, " ("

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v2, 0x1

    aget-wide v3, v1, v2

    iget-object v5, p0, Lcom/mrkeyboard/app/MrCacheClear;->app:Landroid/content/Context;

    invoke-static {v5, v3, v4}, Landroid/text/format/Formatter;->formatShortFileSize(Landroid/content/Context;J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ")\nMiniaturas: "

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v2, p0, Lcom/mrkeyboard/app/MrCacheClear;->thumbs:I

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, " ("

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v3, p0, Lcom/mrkeyboard/app/MrCacheClear;->thumbBytes:J

    invoke-static {v5, v3, v4}, Landroid/text/format/Formatter;->formatShortFileSize(Landroid/content/Context;J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ")\nListas: "

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v2, p0, Lcom/mrkeyboard/app/MrCacheClear;->lists:I

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, "\nToque numa categoria ou em Atualizar."

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method rejected()V
 .locals 4
 const/4 v0, 0x3
 new-array v1, v0, [J
 const/4 v0, 0x2
 const-wide/16 v2, 0x1
 aput-wide v2, v1, v0
 iput-object v1, p0, Lcom/mrkeyboard/app/MrCacheClear;->result:[J
 const/4 v0, 0x1
 iput v0, p0, Lcom/mrkeyboard/app/MrCacheClear;->phase:I
 invoke-virtual {p0}, Lcom/mrkeyboard/app/MrCacheClear;->run()V
 return-void
.end method
