.class public Lcom/mrkeyboard/app/MrShots;
.super Landroid/widget/BaseAdapter;
.source "MrShots.java"

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Landroid/widget/AdapterView$OnItemLongClickListener;
.implements Landroid/view/View$OnClickListener;
.implements Ljava/lang/Runnable;


# modos de instancia (mMode):
# 0 = carregar lista (thread)   1 = carregar miniatura (thread)
# 2 = aplicar lista (UI)        3 = adapter da grade / clique do estado vazio
# 4 = aplicar miniatura (UI)
# 5 = copiar midia para o cache (thread)   6 = entregar copia ao app (UI)
# 7 = preparar URI original sem copia (thread)   8 = tentar entrega direta (UI)
# 9 = preparar URI do seletor (thread)   10 = aguardar destino (UI)   11 = soltar permissao da URI (UI)
# 12 = preparar lote (thread)   13 = enviar lote por commit/share (UI)   14 = copiar recusados do lote (thread)   15 = entregar copias do lote (UI)
# sVid: false = Fotos (funil: screenshots > camera > recentes)  true = Videos (MediaStore.Video)

# sFiles: true = Arquivos (MediaStore.Files, mNames/mMimes em paralelo a mIds)
# ids em mIds: positivo = imagem, negativo = video (-_id)
.field static sLists:[Lcom/mrkeyboard/app/MrShots;
.field static sQueryExec:Ljava/util/concurrent/ExecutorService;
.field static sQueryPending:Z
.field static sRequestedCategory:I
.field static volatile sThumbGen:I
.field mThumbGen:I
.field mCategory:I
.field mLoadFiles:Z
.field mLoadVid:Z
.field mFailed:Z
.field mCachedAt:J
.field mScroll:I
.field static volatile sSession:I
.field static sThumbExec:Ljava/util/concurrent/ExecutorService;
.field mSession:I
.field mOriginal:Landroid/net/Uri;
.field mTarget:Ljava/lang/ref/WeakReference;
.field mTargetPackage:Ljava/lang/String;
.field mSrc:Landroid/net/Uri;
.field mBS:Ljava/util/ArrayList;
.field mBU:Ljava/util/ArrayList;
.field mBR:Ljava/util/ArrayList;
.field mBF:Ljava/util/ArrayList;
.field mBok:I

.field static sAdp:Lcom/mrkeyboard/app/MrShots;

.field static sCache:Landroid/util/LruCache;

.field static sCut7:J

.field static sEmpty:Landroid/widget/TextView;

.field static sExec:Ljava/util/concurrent/ExecutorService;

.field static volatile sGen:I

.field static sGrid:Landroid/widget/GridView;

.field static sBF:Landroid/widget/TextView;

.field static sBV:Landroid/widget/TextView;

.field static sBA:Landroid/widget/TextView;

.field static sSel:Ljava/util/HashSet;

.field static sSelOn:Z

.field static sPick:Landroid/view/View;

.field static sBar:Landroid/view/View;

.field static sCancel:Landroid/widget/TextView;

.field static sSend:Landroid/widget/TextView;

.field static sFiles:Z

.field static volatile sClearSummary:Ljava/lang/String;
.field static volatile sBusy:Z
.field static sPickJob:Lcom/mrkeyboard/app/MrShots;

.field static sVid:Z

.field static sMore:Z

.field static sSh:I

.field static sSw:I

.field mBmp:Landroid/graphics/Bitmap;

.field mGen:I

.field mH:I

.field mId:J

.field mIds:[J

.field mFile:Ljava/io/File;

.field mMime:Ljava/lang/String;

.field mMode:I

.field mN:I

.field mView:Ljava/lang/ref/WeakReference;

.field mName:Ljava/lang/String;

.field mNames:[Ljava/lang/String;

.field mMimes:[Ljava/lang/String;


.method public constructor <init>(I)V
    .locals 1

    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    iput p1, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I

    sget v0, Lcom/mrkeyboard/app/MrShots;->sSession:I
    iput v0, p0, Lcom/mrkeyboard/app/MrShots;->mSession:I
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->category()I
    move-result v0
    iput v0, p0, Lcom/mrkeyboard/app/MrShots;->mCategory:I
    sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sFiles:Z
    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrShots;->mLoadFiles:Z
    sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sVid:Z
    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrShots;->mLoadVid:Z
    sget v0, Lcom/mrkeyboard/app/MrShots;->sThumbGen:I
    iput v0, p0, Lcom/mrkeyboard/app/MrShots;->mThumbGen:I
    return-void
.end method

.method private static clean(Ljava/io/File;)V
    .locals 0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrCopyRetention;->clean(Ljava/io/File;)V
    return-void
.end method

.method private static copyToCache(JLjava/lang/String;I)Ljava/io/File;
    .locals 10
    invoke-static {p3}, Lcom/mrkeyboard/app/MrShots;->assertCopySession(I)V
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrCopyRetention;->category(J)I
    move-result v4
    invoke-static {v4, p0, p1}, Lcom/mrkeyboard/app/MrCopyRetention;->reuse(IJ)Ljava/io/File;
    move-result-object v5
    invoke-static {p3}, Lcom/mrkeyboard/app/MrShots;->assertCopySession(I)V
    if-nez v5, :cond_ret

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v1

    new-instance v2, Ljava/io/File;

    const-string v3, "shots"

    invoke-direct {v2, v1, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    invoke-static {v2}, Lcom/mrkeyboard/app/MrShots;->clean(Ljava/io/File;)V

    const-wide/16 v3, 0x0

    cmp-long v3, p0, v3

    if-gez v3, :cond_img

    invoke-static {p2}, Lcom/mrkeyboard/app/MrShots;->vidExt(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :cond_ext

    :cond_img

    const-string v3, ".png"

    if-eqz p2, :cond_ext

    const-string v4, "jpeg"

    invoke-virtual {p2, v4}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_nojpg

    const-string v3, ".jpg"

    goto :cond_ext

    :cond_nojpg
    const-string v4, "webp"

    invoke-virtual {p2, v4}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_ext

    const-string v3, ".webp"

    :cond_ext
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "shot_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p0, p1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Lcom/mrkeyboard/app/MrCopyRetention;->target(Ljava/io/File;Ljava/lang/String;)Ljava/io/File;
    move-result-object v5

    :cond_copy
    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrShots;->uriFor(J)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v3

    new-instance v6, Ljava/io/File;

    invoke-virtual {v5}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v7

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v7, ".part"

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v3, v6, p3}, Lcom/mrkeyboard/app/MrShots;->copyToPart(Ljava/io/InputStream;Ljava/io/File;I)V

    invoke-static {v6, v5, p3}, Lcom/mrkeyboard/app/MrShots;->commitCopy(Ljava/io/File;Ljava/io/File;I)V
    invoke-static {v5}, Lcom/mrkeyboard/app/MrCopyRetention;->touch(Ljava/io/File;)V
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrCopyRetention;->category(J)I
    move-result v4
    invoke-static {v4, p0, p1, v5}, Lcom/mrkeyboard/app/MrCopyRetention;->remember(IJLjava/io/File;)V

    :cond_ret
    return-object v5
.end method

.method static perms()[Ljava/lang/String;
    .locals 3

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->permName()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    return-object v0
.end method

.method static hasPerm()Z
    .locals 1

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->filesPerm()Z

    move-result v0

    return v0
.end method

.method private static uriFor(J)Landroid/net/Uri;

    .locals 3

    const-wide/16 v0, 0x0

    cmp-long v2, p0, v0

    if-gez v2, :cond_img

    sget-object v2, Landroid/provider/MediaStore$Video$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    neg-long v0, p0

    invoke-static {v2, v0, v1}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;

    move-result-object v2

    return-object v2

    :cond_img

    sget-object v2, Landroid/provider/MediaStore$Images$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    invoke-static {v2, p0, p1}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;

    move-result-object v2

    return-object v2

.end method

.method private static vidExt(Ljava/lang/String;)Ljava/lang/String;

    .locals 3

    const/4 v0, 0x0

    if-eqz p0, :cond_def

    invoke-static {}, Landroid/webkit/MimeTypeMap;->getSingleton()Landroid/webkit/MimeTypeMap;

    move-result-object v1

    invoke-virtual {v1, p0}, Landroid/webkit/MimeTypeMap;->getExtensionFromMimeType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :cond_def

    if-nez v0, :cond_have

    const-string v0, "mp4"

    :cond_have

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "."

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

.end method

.method static styleTabs()V

    .locals 5

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->stylePick()V

    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sBF:Landroid/widget/TextView;

    if-eqz v0, :cond_end

    sget-object v1, Lcom/mrkeyboard/app/MrShots;->sBV:Landroid/widget/TextView;

    if-eqz v1, :cond_end

    sget-object v2, Lcom/mrkeyboard/app/MrShots;->sBA:Landroid/widget/TextView;

    if-eqz v2, :cond_end

    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->flatBar()Z

    move-result v3

    if-eqz v3, :cond_std

    const/4 v4, 0x0

    sget-boolean v3, Lcom/mrkeyboard/app/MrShots;->sFiles:Z

    if-eqz v3, :cond_mid_nf

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrTools;->shotTab(Landroid/widget/TextView;Z)V

    invoke-static {v1, v4}, Lcom/mrkeyboard/app/MrTools;->shotTab(Landroid/widget/TextView;Z)V

    const/4 v4, 0x1

    invoke-static {v2, v4}, Lcom/mrkeyboard/app/MrTools;->shotTab(Landroid/widget/TextView;Z)V

    return-void

    :cond_mid_nf
    invoke-static {v2, v4}, Lcom/mrkeyboard/app/MrTools;->shotTab(Landroid/widget/TextView;Z)V

    sget-boolean v3, Lcom/mrkeyboard/app/MrShots;->sVid:Z

    if-eqz v3, :cond_mid_ph

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrTools;->shotTab(Landroid/widget/TextView;Z)V

    const/4 v4, 0x1

    invoke-static {v1, v4}, Lcom/mrkeyboard/app/MrTools;->shotTab(Landroid/widget/TextView;Z)V

    return-void

    :cond_mid_ph
    invoke-static {v1, v4}, Lcom/mrkeyboard/app/MrTools;->shotTab(Landroid/widget/TextView;Z)V

    const/4 v4, 0x1

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrTools;->shotTab(Landroid/widget/TextView;Z)V

    return-void

    :cond_std
    const/high16 v3, 0x3f000000

    const/high16 v4, 0x3f800000

    invoke-virtual {v0, v3}, Landroid/view/View;->setAlpha(F)V

    invoke-virtual {v1, v3}, Landroid/view/View;->setAlpha(F)V

    invoke-virtual {v2, v3}, Landroid/view/View;->setAlpha(F)V

    sget-boolean v3, Lcom/mrkeyboard/app/MrShots;->sFiles:Z

    if-eqz v3, :cond_nofiles

    invoke-virtual {v2, v4}, Landroid/view/View;->setAlpha(F)V

    return-void

    :cond_nofiles

    sget-boolean v3, Lcom/mrkeyboard/app/MrShots;->sVid:Z

    if-eqz v3, :cond_photos

    invoke-virtual {v1, v4}, Landroid/view/View;->setAlpha(F)V

    return-void

    :cond_photos

    invoke-virtual {v0, v4}, Landroid/view/View;->setAlpha(F)V

    :cond_end

    return-void

.end method

.method public static setVid(Z)V

    .locals 2

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->clearSel()V

    sput-boolean p0, Lcom/mrkeyboard/app/MrShots;->sVid:Z

    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrShots;->sFiles:Z

    const/4 v0, 0x0
    invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->request(Z)V


    return-void

.end method

.method private doLoadVid()V

    .locals 14

    const/16 v0, 0x3c

    new-array v1, v0, [J

    const/4 v2, 0x0

    const/4 v5, 0x0

    :try_start_0

    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v6

    sget-object v7, Landroid/provider/MediaStore$Video$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/String;

    const/4 v9, 0x0

    const-string v10, "_id"

    aput-object v10, v8, v9

    const/4 v9, 0x0

    const/4 v10, 0x0

    const-string v11, "date_added DESC"

    invoke-static/range {v6 .. v11}, Lcom/mrkeyboard/app/MrShotQuery;->query(Landroid/content/ContentResolver;Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v5

    if-eqz v5, :cond_noc

    :cond_loop

    if-ge v2, v0, :cond_done

    invoke-interface {v5}, Landroid/database/Cursor;->moveToNext()Z

    move-result v12

    if-eqz v12, :cond_done

    const/4 v12, 0x0

    invoke-interface {v5, v12}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v12

    neg-long v12, v12

    aput-wide v12, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :cond_loop

    :cond_done

    invoke-interface {v5}, Landroid/database/Cursor;->close()V

    :cond_noc

    :try_end_0

    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_post

    :catch_0

    move-exception v0
    const/4 v0, 0x1
    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrShots;->mFailed:Z

    const/4 v2, 0x0

    if-eqz v5, :goto_post

    :try_start_c

    invoke-interface {v5}, Landroid/database/Cursor;->close()V

    :try_end_c

    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_c

    goto :goto_post

    :catch_c

    move-exception v0

    :goto_post

    iput-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mIds:[J

    iput v2, p0, Lcom/mrkeyboard/app/MrShots;->mN:I

    const/4 v0, 0x2

    iput v0, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;

    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

.end method

.method private doCopy()V

    .locals 7

    const/4 v0, 0x0

    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrCopyRetention;->sweep()V

    iget-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mSrc:Landroid/net/Uri;
    if-eqz v1, :cond_idcopy
    iget-object v2, p0, Lcom/mrkeyboard/app/MrShots;->mName:Ljava/lang/String;
    iget v3, p0, Lcom/mrkeyboard/app/MrShots;->mSession:I
    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrShots;->copyUri(Landroid/net/Uri;Ljava/lang/String;I)Ljava/io/File;
    move-result-object v0
    goto :goto_post
    :cond_idcopy

    iget-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mName:Ljava/lang/String;

    iget v2, p0, Lcom/mrkeyboard/app/MrShots;->mCategory:I
    const/4 v3, 0x2
    if-ne v2, v3, :cond_mediacopy
    if-nez v1, :file_name_ready
    const-string v1, "anexo"
    :file_name_ready
    iget-wide v2, p0, Lcom/mrkeyboard/app/MrShots;->mId:J

    iget v4, p0, Lcom/mrkeyboard/app/MrShots;->mSession:I
    invoke-static {v2, v3, v1, v4}, Lcom/mrkeyboard/app/MrShots;->copyFile(JLjava/lang/String;I)Ljava/io/File;

    move-result-object v0

    goto :goto_post

    :cond_mediacopy

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    iget-wide v2, p0, Lcom/mrkeyboard/app/MrShots;->mId:J

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrShots;->uriFor(J)Landroid/net/Uri;

    move-result-object v4

    invoke-virtual {v1, v4}, Landroid/content/ContentResolver;->getType(Landroid/net/Uri;)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_mime

    const-string v1, "image/png"

    const-wide/16 v5, 0x0

    cmp-long v5, v2, v5

    if-gez v5, :cond_mime

    const-string v1, "video/mp4"

    :cond_mime

    iput-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mMime:Ljava/lang/String;

    iget v4, p0, Lcom/mrkeyboard/app/MrShots;->mSession:I
    invoke-static {v2, v3, v1, v4}, Lcom/mrkeyboard/app/MrShots;->copyToCache(JLjava/lang/String;I)Ljava/io/File;

    move-result-object v0

    :try_end_0

    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_post

    :catch_0

    move-exception v1

    const/4 v0, 0x0

    :goto_post

    iput-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mFile:Ljava/io/File;

    const/4 v1, 0x6

    iput v1, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;

    invoke-virtual {v1, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

.end method

.method public static open()V
 .locals 1
 const/4 v0, 0x3
 invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V
 sget-object v0, Lcom/mrkeyboard/app/MrShots;->sClearSummary:Ljava/lang/String;
 if-eqz v0, :check_busy
 invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->showClearSummary(Ljava/lang/String;)V
 return-void
 :check_busy
 invoke-static {}, Lcom/mrkeyboard/app/MrCacheClear;->isBusy()Z
 move-result v0
 if-eqz v0, :load
 const-string v0, "Limpando caches…"

 invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->a(Ljava/lang/String;)Ljava/lang/String;

 move-result-object v0
 invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->showClearSummary(Ljava/lang/String;)V
 # Progress text is not a completed result.
 const/4 v0, 0x0
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sClearSummary:Ljava/lang/String;
 return-void
 :load
 const/4 v0, 0x0
 invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->request(Z)V
 return-void
.end method

.method public static permName()Ljava/lang/String;
    .locals 1

    const-string v0, "android.permission.READ_EXTERNAL_STORAGE"

    return-object v0
.end method

.method private static pipe(Ljava/io/InputStream;Ljava/io/OutputStream;)V
    .locals 3

    const/16 v0, 0x4000

    new-array v0, v0, [B

    :goto_rd
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/Thread;->isInterrupted()Z
    move-result v2
    if-eqz v2, :copy_not_cancelled
    new-instance v2, Ljava/io/InterruptedIOException;
    invoke-direct {v2}, Ljava/io/InterruptedIOException;-><init>()V
    throw v2
    :copy_not_cancelled
    invoke-virtual {p0, v0}, Ljava/io/InputStream;->read([B)I

    move-result v1

    if-ltz v1, :cond_done

    const/4 v2, 0x0

    invoke-virtual {p1, v0, v2, v1}, Ljava/io/OutputStream;->write([BII)V

    goto :goto_rd

    :cond_done
    return-void
.end method

.method private static request(Z)V
    .locals 7
    invoke-static {}, Lcom/mrkeyboard/app/MrCacheClear;->isBusy()Z
    move-result v0
    if-eqz v0, :not_clearing
    return-void
    :not_clearing
    const/4 v0, 0x0
    sput-object v0, Lcom/mrkeyboard/app/MrShots;->sClearSummary:Ljava/lang/String;

    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sAdp:Lcom/mrkeyboard/app/MrShots;

    if-nez v0, :cond_ok

    return-void

    :cond_ok

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->styleTabs()V

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->styleSel()V

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->emptyIcon()V

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->hasPerm()Z

    move-result v1

    if-nez v1, :cond_go

    const/4 v1, 0x0
    sput-object v1, Lcom/mrkeyboard/app/MrShots;->sLists:[Lcom/mrkeyboard/app/MrShots;
    iput-object v1, v0, Lcom/mrkeyboard/app/MrShots;->mIds:[J
    iput-object v1, v0, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;
    iput-object v1, v0, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;
    iput v1, v0, Lcom/mrkeyboard/app/MrShots;->mN:I
    sget v1, Lcom/mrkeyboard/app/MrShots;->sGen:I
    add-int/lit8 v1, v1, 0x1
    sput v1, Lcom/mrkeyboard/app/MrShots;->sGen:I
    const/4 v1, 0x0
    sput-boolean v1, Lcom/mrkeyboard/app/MrShots;->sQueryPending:Z

    invoke-virtual {v0}, Landroid/widget/BaseAdapter;->notifyDataSetChanged()V

    sget-object v1, Lcom/mrkeyboard/app/MrShots;->sEmpty:Landroid/widget/TextView;

    const v2, 0x7f0c01bb

    sget-boolean v3, Lcom/mrkeyboard/app/MrShots;->sFiles:Z

    if-nez v3, :cond_allowfiles

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1e

    if-lt v3, v4, :cond_allowtxt

    :cond_allowfiles
    const v2, 0x7f0c01d0

    :cond_allowtxt

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V



    return-void

    :cond_go
    # Invalidate an in-flight request for a different tab even on a fresh-cache hit.
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->category()I
    move-result v5
    sget-boolean v4, Lcom/mrkeyboard/app/MrShots;->sQueryPending:Z
    if-eqz v4, :cache_lookup
    sget v4, Lcom/mrkeyboard/app/MrShots;->sRequestedCategory:I
    if-eq v4, v5, :cache_lookup
    sget v4, Lcom/mrkeyboard/app/MrShots;->sGen:I
    add-int/lit8 v4, v4, 0x1
    sput v4, Lcom/mrkeyboard/app/MrShots;->sGen:I
    const/4 v4, 0x0
    sput-boolean v4, Lcom/mrkeyboard/app/MrShots;->sQueryPending:Z
    :cache_lookup
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->showCached()Z
    move-result v4
    # A forced refresh bypasses the TTL, but ordinary repeated opens don't.
    if-nez p0, :check_pending
    if-eqz v4, :check_pending
    return-void
    :check_pending
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->category()I
    move-result v5
    sget-boolean v4, Lcom/mrkeyboard/app/MrShots;->sQueryPending:Z
    if-eqz v4, :start_request
    sget v4, Lcom/mrkeyboard/app/MrShots;->sRequestedCategory:I
    if-ne v4, v5, :start_request
    # An existing request for this category already performs the refresh.
    return-void
    :start_request
    const/4 v4, 0x1
    sput-boolean v4, Lcom/mrkeyboard/app/MrShots;->sQueryPending:Z
    sput v5, Lcom/mrkeyboard/app/MrShots;->sRequestedCategory:I
    sget-object v1, Lcom/mrkeyboard/app/MrShots;->sEmpty:Landroid/widget/TextView;

    const v2, 0x7f0c01bc

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    sget v1, Lcom/mrkeyboard/app/MrShots;->sGen:I

    add-int/lit8 v1, v1, 0x1

    sput v1, Lcom/mrkeyboard/app/MrShots;->sGen:I

    new-instance v2, Lcom/mrkeyboard/app/MrShots;

    const/4 v3, 0x0

    invoke-direct {v2, v3}, Lcom/mrkeyboard/app/MrShots;-><init>(I)V

    iput v1, v2, Lcom/mrkeyboard/app/MrShots;->mGen:I

    sget-object v3, Lcom/mrkeyboard/app/MrShots;->sExec:Ljava/util/concurrent/ExecutorService;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrShots;->submit(Lcom/mrkeyboard/app/MrShots;)V

    return-void
.end method

.method private static shareTo(Ljava/lang/String;Landroid/net/Uri;Ljava/lang/String;)Z
    .locals 3

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.SEND"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p2}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    const-string v2, "android.intent.extra.STREAM"

    invoke-virtual {v1, v2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    invoke-virtual {v1, p0}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    const-string v2, "mr_shot"

    invoke-static {v2, p1}, Landroid/content/ClipData;->newRawUri(Ljava/lang/CharSequence;Landroid/net/Uri;)Landroid/content/ClipData;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setClipData(Landroid/content/ClipData;)V

    const v2, 0x10000001

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {v0, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x1

    return v0

    :catch_0
    move-exception v0

    const/4 v0, 0x0

    return v0
.end method

.method private finishSend()V

    .locals 11
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->dropSrc()V
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->targetIsCurrent()Z
    move-result v0
    if-nez v0, :copy_target_current
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->cancelDelivery()V
    return-void
    :copy_target_current

    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrShots;->sBusy:Z

    iget-object v4, p0, Lcom/mrkeyboard/app/MrShots;->mFile:Ljava/io/File;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrShots;->mMime:Ljava/lang/String;

    if-nez v4, :cond_have

    const v0, 0x7f0c01be

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V

    return-void

    :cond_have

    :try_start_0

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v5, "com.mrkeyboard.app.shots"

    invoke-static {v0, v5, v4}, Landroid/support/v4/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v4

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v5

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v6

    const/4 v7, 0x0

    if-eqz v5, :cond_nocommit

    if-eqz v6, :cond_nocommit

    new-instance v8, Landroid/content/ClipDescription;

    const/4 v9, 0x1

    new-array v9, v9, [Ljava/lang/String;

    const/4 v10, 0x0

    aput-object v3, v9, v10

    const-string v10, "screenshot"

    invoke-direct {v8, v10, v9}, Landroid/content/ClipDescription;-><init>(Ljava/lang/CharSequence;[Ljava/lang/String;)V

    invoke-static {v5, v6, v4, v8}, Lcom/mrkeyboard/app/MrMediaHelper;->commitImage(Landroid/view/inputmethod/InputConnection;Landroid/view/inputmethod/EditorInfo;Landroid/net/Uri;Landroid/content/ClipDescription;)Z

    move-result v7

    :cond_nocommit
    if-nez v7, :cond_sent

    if-eqz v6, :cond_clip

    iget-object v8, v6, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;

    if-eqz v8, :cond_clip

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_clip

    invoke-static {v8, v4, v3}, Lcom/mrkeyboard/app/MrShots;->shareTo(Ljava/lang/String;Landroid/net/Uri;Ljava/lang/String;)Z

    move-result v9

    if-nez v9, :cond_sent

    :cond_clip
    const-string v8, "clipboard"

    invoke-virtual {v0, v8}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Landroid/content/ClipboardManager;

    const-string v9, "mr_shot"

    invoke-static {v1, v9, v4}, Landroid/content/ClipData;->newUri(Landroid/content/ContentResolver;Ljava/lang/CharSequence;Landroid/net/Uri;)Landroid/content/ClipData;

    move-result-object v9

    invoke-virtual {v8, v9}, Landroid/content/ClipboardManager;->setPrimaryClip(Landroid/content/ClipData;)V

    const v8, 0x7f0c01bd

    invoke-static {v8}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V

    :cond_sent
    iget-object v8, p0, Lcom/mrkeyboard/app/MrShots;->mFile:Ljava/io/File;
    invoke-static {v8}, Lcom/mrkeyboard/app/MrCopyRetention;->touch(Ljava/io/File;)V
    const/4 v8, 0x0

    invoke-static {v8}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    const v0, 0x7f0c01be

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V

    return-void
.end method

.method public static setup(Landroid/view/View;)V
    .locals 5

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->release()V

    new-instance v0, Lcom/mrkeyboard/app/MrShots;

    const/4 v1, 0x3

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrShots;-><init>(I)V

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->density:F

    const/high16 v2, 0x42f00000    # 120.0f

    mul-float/2addr v1, v2

    float-to-int v1, v1

    iput v1, v0, Lcom/mrkeyboard/app/MrShots;->mH:I

    sput-object v0, Lcom/mrkeyboard/app/MrShots;->sAdp:Lcom/mrkeyboard/app/MrShots;

    const-string v1, "g_shots"

    invoke-virtual {p0, v1}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/GridView;

    sput-object v1, Lcom/mrkeyboard/app/MrShots;->sGrid:Landroid/widget/GridView;
    new-instance v2, Lcom/mrkeyboard/app/MrShotScroll;
    invoke-direct {v2}, Lcom/mrkeyboard/app/MrShotScroll;-><init>()V
    invoke-virtual {v1, v2}, Landroid/widget/AbsListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    invoke-virtual {v1, v0}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    invoke-virtual {v1, v0}, Landroid/widget/AdapterView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1, v0}, Landroid/widget/AdapterView;->setOnItemLongClickListener(Landroid/widget/AdapterView$OnItemLongClickListener;)V

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/view/View;->setHapticFeedbackEnabled(Z)V

    const-string v2, "shot_empty"

    invoke-virtual {p0, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    sput-object v2, Lcom/mrkeyboard/app/MrShots;->sEmpty:Landroid/widget/TextView;

    sget v3, Lcom/mrkeyboard/app/MrTools;->sHint:I

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrTools;->tintColor(Landroid/widget/TextView;I)V

    invoke-virtual {v2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-virtual {v1, v2}, Landroid/widget/AdapterView;->setEmptyView(Landroid/view/View;)V

    const-string v2, "shot_photos"

    invoke-virtual {p0, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    sput-object v2, Lcom/mrkeyboard/app/MrShots;->sBF:Landroid/widget/TextView;

    const-string v2, "shot_videos"

    invoke-virtual {p0, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    sput-object v2, Lcom/mrkeyboard/app/MrShots;->sBV:Landroid/widget/TextView;

    const-string v2, "shot_files"

    invoke-virtual {p0, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    sput-object v2, Lcom/mrkeyboard/app/MrShots;->sBA:Landroid/widget/TextView;

    const-string v2, "shot_pick"

    invoke-virtual {p0, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrShots;->sPick:Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const-string v2, "shot_selbar"

    invoke-virtual {p0, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrShots;->sBar:Landroid/view/View;

    const-string v2, "shot_sel_cancel"

    invoke-virtual {p0, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    sput-object v2, Lcom/mrkeyboard/app/MrShots;->sCancel:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const-string v2, "shot_sel_send"

    invoke-virtual {p0, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    sput-object v2, Lcom/mrkeyboard/app/MrShots;->sSend:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->styleSel()V

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->stylePick()V

    sget-object v2, Lcom/mrkeyboard/app/MrShots;->sExec:Ljava/util/concurrent/ExecutorService;

    if-nez v2, :cond_have

    new-instance v2, Lcom/mrkeyboard/app/MrThumbnailCache;

    invoke-direct {v2}, Lcom/mrkeyboard/app/MrThumbnailCache;-><init>()V

    sput-object v2, Lcom/mrkeyboard/app/MrShots;->sCache:Landroid/util/LruCache;

    const/4 v2, 0x1
    const/16 v3, 0x8
    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrWorkPools;->create(II)Ljava/util/concurrent/ExecutorService;
    move-result-object v2
    sput-object v2, Lcom/mrkeyboard/app/MrShots;->sExec:Ljava/util/concurrent/ExecutorService;
    const/4 v2, 0x1
    invoke-static {v2, v2}, Lcom/mrkeyboard/app/MrWorkPools;->latest(II)Ljava/util/concurrent/ExecutorService;
    move-result-object v2
    sput-object v2, Lcom/mrkeyboard/app/MrShots;->sQueryExec:Ljava/util/concurrent/ExecutorService;
    const/4 v2, 0x2
    const/16 v3, 0x40
    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrWorkPools;->create(II)Ljava/util/concurrent/ExecutorService;
    move-result-object v2
    sput-object v2, Lcom/mrkeyboard/app/MrShots;->sThumbExec:Ljava/util/concurrent/ExecutorService;

    :cond_have
    return-void
.end method

.method private applyList()V
    .locals 6

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->hasPerm()Z
    move-result v0
    if-nez v0, :permission_current
    const/4 v0, 0x1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->request(Z)V
    return-void
    :permission_current
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrShots;->mFailed:Z
    if-nez v0, :skip_store
    invoke-static {p0}, Lcom/mrkeyboard/app/MrShots;->storeSnapshot(Lcom/mrkeyboard/app/MrShots;)V
    :skip_store
    iget v0, p0, Lcom/mrkeyboard/app/MrShots;->mGen:I

    sget v1, Lcom/mrkeyboard/app/MrShots;->sGen:I

    if-eq v0, v1, :cond_cur

    return-void

    :cond_cur
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->category()I
    move-result v0
    iget v1, p0, Lcom/mrkeyboard/app/MrShots;->mCategory:I
    if-eq v0, v1, :category_current
    return-void
    :category_current
    const/4 v0, 0x0
    sput-boolean v0, Lcom/mrkeyboard/app/MrShots;->sQueryPending:Z
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrShots;->mFailed:Z
    if-eqz v0, :query_succeeded
    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sEmpty:Landroid/widget/TextView;
    const-string v1, "Não foi possível atualizar. Toque para tentar novamente."

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    return-void
    :query_succeeded
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->emptyIcon()V

    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sAdp:Lcom/mrkeyboard/app/MrShots;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mIds:[J

    iput-object v1, v0, Lcom/mrkeyboard/app/MrShots;->mIds:[J

    iget-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;

    iput-object v1, v0, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;

    iput-object v1, v0, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;

    iget v1, p0, Lcom/mrkeyboard/app/MrShots;->mN:I

    iput v1, v0, Lcom/mrkeyboard/app/MrShots;->mN:I

    invoke-virtual {v0}, Landroid/widget/BaseAdapter;->notifyDataSetChanged()V
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->pruneSel()V

    sget-object v2, Lcom/mrkeyboard/app/MrShots;->sGrid:Landroid/widget/GridView;

    const/4 v3, 0x0





    if-eqz v1, :cond_zero

    const/4 v2, 0x0

    sput-boolean v2, Lcom/mrkeyboard/app/MrShots;->sMore:Z

    return-void

    :cond_zero

    sget-boolean v2, Lcom/mrkeyboard/app/MrShots;->sFiles:Z

    if-eqz v2, :cond_nofl

    const/4 v2, 0x0

    sput-boolean v2, Lcom/mrkeyboard/app/MrShots;->sMore:Z

    const v2, 0x7f0c01cf

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v2

    sget-object v3, Lcom/mrkeyboard/app/MrShots;->sEmpty:Landroid/widget/TextView;

    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_nofl
    const/4 v5, 0x0

    :cond_set
    sput-boolean v5, Lcom/mrkeyboard/app/MrShots;->sMore:Z

    sget-object v3, Lcom/mrkeyboard/app/MrShots;->sEmpty:Landroid/widget/TextView;

    if-eqz v5, :cond_none

    const v2, 0x7f0c01cb

    goto :cond_txt

    :cond_none

    sget-boolean v2, Lcom/mrkeyboard/app/MrShots;->sVid:Z

    if-eqz v2, :cond_nophoto

    const v2, 0x7f0c01ce

    goto :cond_txt

    :cond_nophoto

    const v2, 0x7f0c01bf

    :cond_txt
    invoke-static {v2}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private applyThumb()V
    .locals 5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mBmp:Landroid/graphics/Bitmap;
    if-eqz v0, :done
    iget-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mView:Ljava/lang/ref/WeakReference;
    if-eqz v1, :done
    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Landroid/widget/ImageView;
    if-eqz v1, :done
    invoke-virtual {v1}, Landroid/view/View;->getTag()Ljava/lang/Object;
    move-result-object v2
    iget-wide v3, p0, Lcom/mrkeyboard/app/MrShots;->mId:J
    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;
    move-result-object v3
    invoke-virtual {v3, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-eqz v2, :done
    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V
    :done
    const/4 v0, 0x0
    iput-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mView:Ljava/lang/ref/WeakReference;
    iput-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mBmp:Landroid/graphics/Bitmap;
    return-void
.end method

.method private static scoreRow(Landroid/database/Cursor;)I
    .locals 12

    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-interface {p0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    const/4 v1, 0x2

    invoke-interface {p0, v1}, Landroid/database/Cursor;->getInt(I)I

    move-result v3

    const/4 v1, 0x3

    invoke-interface {p0, v1}, Landroid/database/Cursor;->getInt(I)I

    move-result v4

    const/4 v5, 0x0

    sget v6, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v7, 0x1d

    if-lt v6, v7, :cond_hay

    const/4 v1, 0x5

    invoke-interface {p0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v5

    :cond_hay
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz v2, :cond_b1

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_b1
    const-string v7, "|"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    if-eqz v5, :cond_b2

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_b2
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v6

    const/4 v7, 0x0

    const-string v8, "screenshot"

    invoke-virtual {v6, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_hit

    const-string v8, "screen_shot"

    invoke-virtual {v6, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_hit

    const-string v8, "screencap"

    invoke-virtual {v6, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_hit

    const-string v8, "screen cap"

    invoke-virtual {v6, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_hit

    const-string v8, "captura"

    invoke-virtual {v6, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_hit

    const-string v8, "\u622a\u5c4f"

    invoke-virtual {v6, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_hit

    const-string v8, "\u622a\u56fe"

    invoke-virtual {v6, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v8

    if-eqz v8, :cond_nohit

    :cond_hit
    const/4 v7, 0x1

    :cond_nohit
    if-eqz v7, :cond_noname

    add-int/lit8 v0, v0, 0x3

    :cond_noname
    const-string v8, "camera"

    invoke-virtual {v6, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_cam

    const-string v8, "dcim"

    invoke-virtual {v6, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v8

    if-eqz v8, :cond_nocam

    :cond_cam

    add-int/lit8 v0, v0, 0x8

    :cond_nocam
    sget v8, Lcom/mrkeyboard/app/MrShots;->sSw:I

    sget v9, Lcom/mrkeyboard/app/MrShots;->sSh:I

    if-ne v3, v8, :cond_dim2

    if-ne v4, v9, :cond_dim2

    add-int/lit8 v0, v0, 0x3

    goto :cond_dimdone

    :cond_dim2
    if-ne v3, v9, :cond_scroll

    if-ne v4, v8, :cond_scroll

    add-int/lit8 v0, v0, 0x3

    goto :cond_dimdone

    :cond_scroll
    if-ne v3, v8, :cond_scroll2

    if-le v4, v9, :cond_scroll2

    add-int/lit8 v0, v0, 0x2

    goto :cond_dimdone

    :cond_scroll2
    if-ne v3, v9, :cond_dimdone

    if-le v4, v8, :cond_dimdone

    add-int/lit8 v0, v0, 0x2

    :cond_dimdone
    const/4 v8, 0x4

    invoke-interface {p0, v8}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v3

    sget-wide v8, Lcom/mrkeyboard/app/MrShots;->sCut7:J

    cmp-long v5, v3, v8

    if-ltz v5, :cond_done

    add-int/lit8 v0, v0, 0x1

    :cond_done
    return v0
.end method

.method private doLoad()V

    .locals 14

    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrShots;->mLoadFiles:Z

    if-eqz v0, :cond_nofiles

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->doLoadFiles()V

    return-void

    :cond_nofiles

    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrShots;->mLoadVid:Z

    if-eqz v0, :cond_photo

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->doLoadVid()V

    return-void

    :cond_photo

    const/4 v5, 0x0

    const/16 v0, 0x3c

    new-array v1, v0, [J

    new-array v2, v0, [J

    const/4 v3, 0x0

    const/4 v4, 0x0

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v12

    const-wide/16 v10, 0x3e8

    div-long v12, v12, v10

    const-wide v10, 0x278d00

    sub-long v12, v12, v10

    long-to-int v0, v12

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v12

    const-wide/16 v10, 0x3e8

    div-long v12, v12, v10

    const-wide v10, 0x93a80

    sub-long v12, v12, v10

    sput-wide v12, Lcom/mrkeyboard/app/MrShots;->sCut7:J

    sget-object v5, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v6

    iget v12, v6, Landroid/util/DisplayMetrics;->widthPixels:I

    sput v12, Lcom/mrkeyboard/app/MrShots;->sSw:I

    iget v12, v6, Landroid/util/DisplayMetrics;->heightPixels:I

    sput v12, Lcom/mrkeyboard/app/MrShots;->sSh:I

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v6

    sget-object v7, Landroid/provider/MediaStore$Images$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    sget v8, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v12, 0x1d

    if-lt v8, v12, :cond_noq

    const/4 v8, 0x6

    new-array v8, v8, [Ljava/lang/String;

    const-string v12, "relative_path"

    const/4 v13, 0x5

    aput-object v12, v8, v13

    goto :cond_proj

    :cond_noq
    const/4 v8, 0x6

    new-array v8, v8, [Ljava/lang/String;

    const-string v12, "_data"

    const/4 v13, 0x5

    aput-object v12, v8, v13

    :cond_proj
    const-string v12, "_id"

    const/4 v13, 0x0

    aput-object v12, v8, v13

    const-string v12, "bucket_display_name"

    const/4 v13, 0x1

    aput-object v12, v8, v13

    const-string v12, "width"

    const/4 v13, 0x2

    aput-object v12, v8, v13

    const-string v12, "height"

    const/4 v13, 0x3

    aput-object v12, v8, v13

    const-string v12, "date_added"

    const/4 v13, 0x4

    aput-object v12, v8, v13

    const-string v9, "width>0 AND height>0 AND date_added>?"

    const/4 v12, 0x1

    new-array v10, v12, [Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v12

    const/4 v13, 0x0

    aput-object v12, v10, v13

    const-string v11, "date_added DESC"

    invoke-static/range {v6 .. v11}, Lcom/mrkeyboard/app/MrShotQuery;->query(Landroid/content/ContentResolver;Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v5

    const/16 v8, 0x3c

    const/16 v7, 0x3e8

    new-array v9, v7, [J

    new-array v2, v7, [I

    const/4 v6, 0x0

    if-eqz v5, :cond_noc

    const/4 v0, 0x0

    :cond_loop
    if-ge v0, v7, :cond_done

    invoke-interface {v5}, Landroid/database/Cursor;->moveToNext()Z

    move-result v12

    if-eqz v12, :cond_done

    add-int/lit8 v0, v0, 0x1

    invoke-static {v5}, Lcom/mrkeyboard/app/MrShots;->rowKey(Landroid/database/Cursor;)I

    move-result v12

    if-ltz v12, :cond_loop

    const/4 v13, 0x0

    invoke-interface {v5, v13}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v10

    aput-wide v10, v9, v6

    aput v12, v2, v6

    add-int/lit8 v6, v6, 0x1

    goto :cond_loop

    :cond_done
    invoke-interface {v5}, Landroid/database/Cursor;->close()V

    :cond_noc
    const/16 v0, 0x2a

    :goto_pass
    if-ltz v0, :cond_topdone

    const/4 v12, 0x0

    :goto_scan
    if-ge v12, v6, :cond_scandone

    if-ge v3, v8, :cond_scandone

    aget v13, v2, v12

    if-ne v13, v0, :cond_next

    aget-wide v10, v9, v12

    aput-wide v10, v1, v3

    add-int/lit8 v3, v3, 0x1

    :cond_next
    add-int/lit8 v12, v12, 0x1

    goto :goto_scan

    :cond_scandone
    add-int/lit8 v0, v0, -0x1

    goto :goto_pass

    :cond_topdone
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_post

    :catch_0
    move-exception v0
    const/4 v0, 0x1
    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrShots;->mFailed:Z

    const/4 v3, 0x0

    if-eqz v5, :goto_post

    :try_start_c
    invoke-interface {v5}, Landroid/database/Cursor;->close()V
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_c

    goto :goto_post

    :catch_c
    move-exception v0

    :goto_post
    iput-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mIds:[J

    iput v3, p0, Lcom/mrkeyboard/app/MrShots;->mN:I

    const/4 v0, 0x2

    iput v0, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;

    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method private doThumb()V
    .locals 7

    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lcom/mrkeyboard/app/MrShots;->sCache:Landroid/util/LruCache;
    if-eqz v1, :decode_thumbnail
    iget-wide v3, p0, Lcom/mrkeyboard/app/MrShots;->mId:J
    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;
    move-result-object v2
    invoke-virtual {v1, v2}, Landroid/util/LruCache;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Landroid/graphics/Bitmap;
    if-eqz v2, :decode_thumbnail
    move-object v0, v2
    goto :cond_nocache
    :decode_thumbnail
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    if-eqz v1, :cond_nocache

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    iget-wide v3, p0, Lcom/mrkeyboard/app/MrShots;->mId:J

    const-wide/16 v5, 0x0

    cmp-long v5, v3, v5

    if-gez v5, :cond_timg

    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0x1d

    if-ge v5, v6, :cond_timg

    neg-long v3, v3

    const/4 v5, 0x1

    const/4 v6, 0x0

    invoke-static {v1, v3, v4, v5, v6}, Landroid/provider/MediaStore$Video$Thumbnails;->getThumbnail(Landroid/content/ContentResolver;JILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v0

    goto :cond_thave

    :cond_timg

    iget-wide v3, p0, Lcom/mrkeyboard/app/MrShots;->mId:J

    invoke-static {v3, v4}, Lcom/mrkeyboard/app/MrShots;->uriFor(J)Landroid/net/Uri;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrMediaHelper;->loadThumb(Landroid/content/ContentResolver;Landroid/net/Uri;)Landroid/graphics/Bitmap;

    move-result-object v0

    :cond_thave

    if-eqz v0, :cond_nocache

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrShots;->cacheThumbnail(Lcom/mrkeyboard/app/MrShots;Landroid/graphics/Bitmap;)V

    :cond_nocache
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_post

    :catch_0
    move-exception v1

    const/4 v0, 0x0

    :goto_post
    iput-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mBmp:Landroid/graphics/Bitmap;

    const/4 v1, 0x4

    iput v1, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;

    invoke-virtual {v1, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public getCount()I
    .locals 1

    iget v0, p0, Lcom/mrkeyboard/app/MrShots;->mN:I

    return v0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public getItemId(I)J
    .locals 2

    int-to-long v0, p1

    return-wide v0
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;

    .locals 8

    sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sFiles:Z

    if-eqz v0, :cond_media

    invoke-direct {p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrShots;->getFileView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    return-object v0

    :cond_media

    instance-of v0, p2, Landroid/widget/ImageView;

    if-nez v0, :cond_chk

    const/4 p2, 0x0

    :cond_chk

    if-nez p2, :cond_reuse

    new-instance v0, Landroid/widget/ImageView;

    invoke-virtual {p3}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->cardBg()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/view/View;->setClipToOutline(Z)V

    new-instance v1, Landroid/widget/AbsListView$LayoutParams;

    const/4 v2, -0x1

    iget v3, p0, Lcom/mrkeyboard/app/MrShots;->mH:I

    invoke-direct {v1, v2, v3}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_bind

    :cond_reuse
    check-cast p2, Landroid/widget/ImageView;

    move-object v0, p2

    :goto_bind
    iget-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mIds:[J

    aget-wide v2, v1, p1

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    invoke-static {v0, v2, v3}, Lcom/mrkeyboard/app/MrShots;->paint(Landroid/view/View;J)V

    sget-object v5, Lcom/mrkeyboard/app/MrShots;->sCache:Landroid/util/LruCache;

    invoke-virtual {v5, v4}, Landroid/util/LruCache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/graphics/Bitmap;

    if-eqz v5, :cond_miss

    invoke-virtual {v0, v5}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    return-object v0

    :cond_miss
    const/4 v5, 0x0

    invoke-virtual {v0, v5}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    new-instance v5, Lcom/mrkeyboard/app/MrShots;

    const/4 v6, 0x1

    invoke-direct {v5, v6}, Lcom/mrkeyboard/app/MrShots;-><init>(I)V

    iput-wide v2, v5, Lcom/mrkeyboard/app/MrShots;->mId:J

    new-instance v6, Ljava/lang/ref/WeakReference;
    invoke-direct {v6, v0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V
    iput-object v6, v5, Lcom/mrkeyboard/app/MrShots;->mView:Ljava/lang/ref/WeakReference;

    sget-object v6, Lcom/mrkeyboard/app/MrShots;->sExec:Ljava/util/concurrent/ExecutorService;

    invoke-static {v5}, Lcom/mrkeyboard/app/MrShots;->submit(Lcom/mrkeyboard/app/MrShots;)V

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3

    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sCancel:Landroid/widget/TextView;

    if-ne p1, v0, :not_cancel

    invoke-static {}, Lcom/mrkeyboard/app/MrCacheClear;->isBusy()Z

    move-result v0

    if-nez v0, :cancel_ignore

    sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sBusy:Z

    if-nez v0, :cancel_ignore

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->clearSel()V

    :cancel_ignore
    return-void

    :not_cancel
    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sPick:Landroid/view/View;

    if-ne p1, v0, :not_pick

    invoke-static {}, Lcom/mrkeyboard/app/MrCacheClear;->isBusy()Z

    move-result v0

    if-nez v0, :pick_ignore

    sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sBusy:Z

    if-nez v0, :pick_ignore

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->pick()V

    :pick_ignore
    return-void

    :not_pick
    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sSend:Landroid/widget/TextView;

    if-ne p1, v0, :not_send

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->sendSel()V

    return-void

    :not_send
    sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sMore:Z

    if-nez v0, :cond_ask

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->hasPerm()Z

    move-result v0

    if-eqz v0, :cond_ask

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->reload()V

    return-void

    :cond_ask
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/mrkeyboard/app/ShotPerm;

    invoke-direct {v1, v0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v2, 0x10000000

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {v0, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V

    .locals 5
    invoke-static {}, Lcom/mrkeyboard/app/MrCacheClear;->isBusy()Z
    move-result v0
    if-eqz v0, :selection_ready
    return-void
    :selection_ready

    iget v0, p0, Lcom/mrkeyboard/app/MrShots;->mN:I

    if-lt p3, v0, :cond_in

    return-void

    :cond_in

    if-gez p3, :cond_ok

    return-void

    :cond_ok

    sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sBusy:Z

    if-eqz v0, :cond_go

    return-void

    :cond_go
    sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sSelOn:Z

    if-eqz v0, :cond_send

    iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mIds:[J

    aget-wide v1, v0, p3

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrShots;->toggleSel(J)Z

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->selCount()I

    move-result v0

    if-nez v0, :cond_still

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->clearSel()V

    return-void

    :cond_still
    invoke-static {p2, v1, v2}, Lcom/mrkeyboard/app/MrShots;->paint(Landroid/view/View;J)V

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->updateSel()V

    return-void

    :cond_send
    invoke-direct {p0, p3}, Lcom/mrkeyboard/app/MrShots;->sendAt(I)V
    return-void

.end method

.method private sendAt(I)V
 .locals 4
 iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mIds:[J
 aget-wide v1, v0, p1
 const/4 v0, 0x1
 sput-boolean v0, Lcom/mrkeyboard/app/MrShots;->sBusy:Z
 new-instance v0, Lcom/mrkeyboard/app/MrShots;
 const/4 v3, 0x7
 invoke-direct {v0, v3}, Lcom/mrkeyboard/app/MrShots;-><init>(I)V
 iput-wide v1, v0, Lcom/mrkeyboard/app/MrShots;->mId:J
 invoke-direct {v0}, Lcom/mrkeyboard/app/MrShots;->captureTarget()V
 sget-boolean v3, Lcom/mrkeyboard/app/MrShots;->sFiles:Z
 if-eqz v3, :cond_exec
 iget-object v3, p0, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;
 aget-object v3, v3, p1
 iput-object v3, v0, Lcom/mrkeyboard/app/MrShots;->mName:Ljava/lang/String;
 iget-object v3, p0, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;
 aget-object v3, v3, p1
 iput-object v3, v0, Lcom/mrkeyboard/app/MrShots;->mMime:Ljava/lang/String;
 :cond_exec
 invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->submit(Lcom/mrkeyboard/app/MrShots;)V
 return-void
.end method

.method public run()V
    .locals 2

    iget v0, p0, Lcom/mrkeyboard/app/MrShots;->mSession:I
    sget v1, Lcom/mrkeyboard/app/MrShots;->sSession:I
    if-eq v0, v1, :session_current
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->dropSrc()V
    return-void
    :session_current
    iget v0, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget v0, p0, Lcom/mrkeyboard/app/MrShots;->mGen:I
    sget v1, Lcom/mrkeyboard/app/MrShots;->sGen:I
    if-eq v0, v1, :query_current
    return-void
    :query_current
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->doLoad()V

    return-void

    :pswitch_1
    iget v0, p0, Lcom/mrkeyboard/app/MrShots;->mThumbGen:I
    sget v1, Lcom/mrkeyboard/app/MrShots;->sThumbGen:I
    if-eq v0, v1, :thumb_current
    return-void
    :thumb_current
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->doThumb()V

    return-void

    :pswitch_2
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->applyList()V

    return-void

    :pswitch_3
    return-void

    :pswitch_4
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->applyThumb()V

    return-void

    :pswitch_5

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->doCopy()V

    return-void

    :pswitch_6

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->finishSend()V

    return-void

    :pswitch_7
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->prepareDirect()V
    return-void

    :pswitch_8
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->finishDirect()V
    return-void

    :pswitch_9
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->prepareUri()V
    return-void

    :pswitch_a
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->awaitTarget()V
    return-void

    :pswitch_b
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->dropSrc()V
    return-void

    :pswitch_c
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->prepBatch()V
    return-void

    :pswitch_d
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->runBatch()V
    return-void

    :pswitch_e
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->copyBatch()V
    return-void

    :pswitch_f
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->finishBatch()V
    return-void

    :pswitch_data_0

    .packed-switch 0x0

    :pswitch_0

    :pswitch_1

    :pswitch_2

    :pswitch_3

    :pswitch_4

    :pswitch_5

    :pswitch_6

    :pswitch_7

    :pswitch_8

    :pswitch_9

    :pswitch_a

    :pswitch_b

    :pswitch_c

    :pswitch_d

    :pswitch_e

    :pswitch_f

    .end packed-switch
.end method

.method static filesPerm()Z

    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_legacy

    invoke-static {}, Lcom/mrkeyboard/app/MrApi30;->isManager()Z

    move-result v0

    return v0

    :cond_legacy

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    const-string v1, "android.permission.READ_EXTERNAL_STORAGE"

    invoke-virtual {v0, v1}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_no

    const/4 v0, 0x1

    return v0

    :cond_no

    const/4 v0, 0x0

    return v0

.end method



.method public static setFiles()V

    .locals 2

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->clearSel()V

    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrShots;->sVid:Z

    const/4 v1, 0x1

    sput-boolean v1, Lcom/mrkeyboard/app/MrShots;->sFiles:Z

    const/4 v0, 0x0
    invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->request(Z)V


    return-void

.end method



.method private static copyFile(JLjava/lang/String;I)Ljava/io/File;

    .locals 9
    invoke-static {p3}, Lcom/mrkeyboard/app/MrShots;->assertCopySession(I)V
    const/4 v8, 0x2
    invoke-static {v8, p0, p1}, Lcom/mrkeyboard/app/MrCopyRetention;->reuse(IJ)Ljava/io/File;
    move-result-object v3
    invoke-static {p3}, Lcom/mrkeyboard/app/MrShots;->assertCopySession(I)V
    if-nez v3, :file_return

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v1

    new-instance v2, Ljava/io/File;

    const-string v3, "shots"

    invoke-direct {v2, v1, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    invoke-static {v2}, Lcom/mrkeyboard/app/MrShots;->clean(Ljava/io/File;)V

    invoke-static {v2, p2}, Lcom/mrkeyboard/app/MrCopyRetention;->target(Ljava/io/File;Ljava/lang/String;)Ljava/io/File;
    move-result-object v3

    const-string v4, "external"

    invoke-static {v4}, Landroid/provider/MediaStore$Files;->getContentUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v4

    invoke-static {v4, p0, p1}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;

    move-result-object v4

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    invoke-virtual {v1, v4}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v5

    new-instance v6, Ljava/io/File;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v8, ".part"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v5, v6, p3}, Lcom/mrkeyboard/app/MrShots;->copyToPart(Ljava/io/InputStream;Ljava/io/File;I)V

    invoke-static {v6, v3, p3}, Lcom/mrkeyboard/app/MrShots;->commitCopy(Ljava/io/File;Ljava/io/File;I)V
    invoke-static {v3}, Lcom/mrkeyboard/app/MrCopyRetention;->touch(Ljava/io/File;)V
    const/4 v8, 0x2
    invoke-static {v8, p0, p1, v3}, Lcom/mrkeyboard/app/MrCopyRetention;->remember(IJLjava/io/File;)V
    :file_return

    return-object v3

.end method



.method private static stripRoot(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    const/4 v0, 0x0

    const-string v1, "/storage/emulated/"

    invoke-virtual {p0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_a

    const/4 v0, 0x4

    goto :cond_go

    :cond_a
    const-string v1, "/storage/"

    invoke-virtual {p0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_b

    const/4 v0, 0x3

    goto :cond_go

    :cond_b
    const-string v1, "/sdcard/"

    invoke-virtual {p0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_go

    const/4 v0, 0x2

    :cond_go
    const/4 v1, 0x0

    :goto_loop
    if-lez v0, :cond_done

    const/16 v2, 0x2f

    invoke-virtual {p0, v2, v1}, Ljava/lang/String;->indexOf(II)I

    move-result v2

    if-ltz v2, :cond_done

    add-int/lit8 v1, v2, 0x1

    add-int/lit8 v0, v0, -0x1

    goto :goto_loop

    :cond_done
    invoke-virtual {p0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method private static emptyIcon()V
    .locals 3

    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sEmpty:Landroid/widget/TextView;

    if-nez v0, :cond_ok

    return-void

    :cond_ok
    const v1, 0x7f0700f1

    sget-boolean v2, Lcom/mrkeyboard/app/MrShots;->sFiles:Z

    if-eqz v2, :cond_nf

    const v1, 0x7f0700f0

    goto :cond_set

    :cond_nf
    sget-boolean v2, Lcom/mrkeyboard/app/MrShots;->sVid:Z

    if-eqz v2, :cond_set

    const v1, 0x7f0700ef

    :cond_set
    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1, v2, v2}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    sget v1, Lcom/mrkeyboard/app/MrTools;->sHint:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tintColor(Landroid/widget/TextView;I)V

    return-void
.end method

.method private static relDir(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    if-nez p0, :cond_ok

    const/4 v0, 0x0

    return-object v0

    :cond_ok
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x2f

    invoke-virtual {v0, v1}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->stripRoot(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static depthPts(Ljava/lang/String;)I
    .locals 3

    const-string v0, "/"

    const-string v1, ""

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    sub-int/2addr v1, v0

    const/4 v2, 0x5

    if-lt v1, v2, :cond_ok

    move v1, v2

    :cond_ok
    sub-int/2addr v2, v1

    mul-int/lit8 v2, v2, 0x2

    return v2
.end method

.method private static scoreFile(Landroid/database/Cursor;)I
    .locals 6

    const/4 v0, 0x0

    const/4 v1, 0x4

    invoke-interface {p0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrShots;->relDir(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_nopath

    const-string v2, "download/"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_notroot

    const/16 v2, 0xc

    add-int/2addr v0, v2

    :cond_notroot
    invoke-static {v1}, Lcom/mrkeyboard/app/MrShots;->depthPts(Ljava/lang/String;)I

    move-result v2

    add-int/2addr v0, v2

    :cond_nopath
    const/4 v1, 0x3

    invoke-interface {p0, v1}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v1

    sget-wide v3, Lcom/mrkeyboard/app/MrShots;->sCut7:J

    cmp-long v5, v1, v3

    if-ltz v5, :cond_old

    add-int/lit8 v0, v0, 0x1

    :cond_old
    return v0
.end method

.method private static rowKey(Landroid/database/Cursor;)I
    .locals 3

    invoke-static {p0}, Lcom/mrkeyboard/app/MrShots;->scoreRow(Landroid/database/Cursor;)I

    move-result v0

    const/16 v1, 0x8

    if-lt v0, v1, :cond_noncam

    sub-int/2addr v0, v1

    const/4 v1, 0x3

    if-ge v0, v1, :cond_top

    const/4 v1, 0x1

    goto :cond_tier

    :cond_noncam
    const/4 v1, 0x3

    if-ge v0, v1, :cond_top

    const/4 v1, 0x1

    if-lt v0, v1, :cond_excl

    const/4 v1, 0x0

    goto :cond_tier

    :cond_top
    const/4 v1, 0x2

    :cond_tier
    const/4 v2, 0x5

    invoke-interface {p0, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrShots;->relDir(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_nop

    invoke-static {v2}, Lcom/mrkeyboard/app/MrShots;->depthPts(Ljava/lang/String;)I

    move-result v2

    goto :cond_pts

    :cond_nop
    const/4 v2, 0x0

    :cond_pts
    mul-int/lit8 v1, v1, 0x10

    add-int/2addr v1, v2

    return v1

    :cond_excl
    const/4 v0, -0x1

    return v0
.end method

.method private static badge(Landroid/view/View;)Landroid/graphics/drawable/Drawable;
    .locals 2

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    const v1, 0x7f0700ee

    invoke-virtual {v0, v1}, Landroid/content/Context;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

# Tamanho em px de p0 decimos de dp (15 = 1,5 dp).
.method private static dpx(I)I
    .locals 1

    sget v0, Lcom/mrkeyboard/app/MrTools;->sPad:I

    mul-int/2addr v0, p0

    div-int/lit8 v0, v0, 0x64

    return v0
.end method

# Vibra ao iniciar a selecao, se "Vibrar ao tocar" estiver ligado nas configuracoes.
.method private static buzz()V
    .locals 4

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    if-eqz v0, :buzz_end

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v2, "vibrate_on"

    const/4 v3, 0x1

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :buzz_end

    const/16 v1, 0x23

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/LatinIME;->vibrate(I)V

    :buzz_end
    return-void
.end method

# Camada de cima do item (foreground). Desmarcado: so o selo de video, centralizado (aba Videos), ou nada.
# Marcado: camada de destaque sobre a miniatura (sel_media; em arquivo, transparente porque o fundo ja muda),
# selo de video centralizado e o check no canto superior direito (circulo sel_send com anel sel_send_stroke
# e traco sel_send_text). Cada vinculo reconstroi a camada, entao a view reaproveitada nunca herda a gravidade
# nem o desenho do item anterior.
.method private static fore(Landroid/view/View;Z)V
    .locals 8

    instance-of v0, p0, Landroid/widget/TextView;

    sget-boolean v1, Lcom/mrkeyboard/app/MrShots;->sVid:Z

    if-nez p1, :fore_on

    if-nez v0, :fore_clear

    if-eqz v1, :fore_clear

    invoke-static {p0}, Lcom/mrkeyboard/app/MrShots;->badge(Landroid/view/View;)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    invoke-virtual {p0, v2}, Landroid/view/View;->setForeground(Landroid/graphics/drawable/Drawable;)V

    const/16 v2, 0x11

    invoke-virtual {p0, v2}, Landroid/view/View;->setForegroundGravity(I)V

    return-void

    :fore_clear
    const/4 v2, 0x0

    invoke-virtual {p0, v2}, Landroid/view/View;->setForeground(Landroid/graphics/drawable/Drawable;)V

    return-void

    :fore_on
    const/4 v3, 0x0

    if-nez v0, :fore_c0

    const-string v2, "sel_media"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v3

    :fore_c0
    new-instance v2, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v2, v3}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    if-nez v0, :fore_nb

    if-eqz v1, :fore_nb

    invoke-static {p0}, Lcom/mrkeyboard/app/MrShots;->badge(Landroid/view/View;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    goto :fore_c1

    :fore_nb
    new-instance v3, Landroid/graphics/drawable/ColorDrawable;

    const/4 v4, 0x0

    invoke-direct {v3, v4}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    :fore_c1
    new-instance v4, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v4}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    const-string v5, "sel_send"

    invoke-static {v5}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v5

    invoke-virtual {v4, v5}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    const-string v5, "sel_send_stroke"

    invoke-static {v5}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v5

    const/16 v6, 0xf

    invoke-static {v6}, Lcom/mrkeyboard/app/MrShots;->dpx(I)I

    move-result v6

    invoke-virtual {v4, v6, v5}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    const/16 v5, 0xc8

    invoke-static {v5}, Lcom/mrkeyboard/app/MrShots;->dpx(I)I

    move-result v5

    invoke-virtual {v4, v5, v5}, Landroid/graphics/drawable/GradientDrawable;->setSize(II)V

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v5

    const v6, 0x7f0700f6

    invoke-virtual {v5, v6}, Landroid/content/Context;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    invoke-virtual {v5}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v5

    const-string v6, "sel_send_text"

    invoke-static {v6}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v6

    invoke-virtual {v5, v6}, Landroid/graphics/drawable/Drawable;->setTint(I)V

    const/4 v6, 0x2

    new-array v6, v6, [Landroid/graphics/drawable/Drawable;

    const/4 v7, 0x0

    aput-object v4, v6, v7

    const/4 v7, 0x1

    aput-object v5, v6, v7

    new-instance v4, Landroid/graphics/drawable/LayerDrawable;

    invoke-direct {v4, v6}, Landroid/graphics/drawable/LayerDrawable;-><init>([Landroid/graphics/drawable/Drawable;)V

    const/4 v5, 0x1

    const/16 v6, 0x11

    invoke-virtual {v4, v5, v6}, Landroid/graphics/drawable/LayerDrawable;->setLayerGravity(II)V

    const/16 v6, 0xa0

    invoke-static {v6}, Lcom/mrkeyboard/app/MrShots;->dpx(I)I

    move-result v6

    invoke-virtual {v4, v5, v6, v6}, Landroid/graphics/drawable/LayerDrawable;->setLayerSize(III)V

    const/4 v5, 0x3

    new-array v5, v5, [Landroid/graphics/drawable/Drawable;

    const/4 v6, 0x0

    aput-object v2, v5, v6

    const/4 v6, 0x1

    aput-object v3, v5, v6

    const/4 v6, 0x2

    aput-object v4, v5, v6

    new-instance v2, Landroid/graphics/drawable/LayerDrawable;

    invoke-direct {v2, v5}, Landroid/graphics/drawable/LayerDrawable;-><init>([Landroid/graphics/drawable/Drawable;)V

    const/4 v5, 0x1

    const/16 v6, 0x11

    invoke-virtual {v2, v5, v6}, Landroid/graphics/drawable/LayerDrawable;->setLayerGravity(II)V

    const/16 v6, 0x140

    invoke-static {v6}, Lcom/mrkeyboard/app/MrShots;->dpx(I)I

    move-result v6

    invoke-virtual {v2, v5, v6, v6}, Landroid/graphics/drawable/LayerDrawable;->setLayerSize(III)V

    const/4 v5, 0x2

    const v6, 0x800035

    invoke-virtual {v2, v5, v6}, Landroid/graphics/drawable/LayerDrawable;->setLayerGravity(II)V

    const/16 v6, 0xc8

    invoke-static {v6}, Lcom/mrkeyboard/app/MrShots;->dpx(I)I

    move-result v6

    invoke-virtual {v2, v5, v6, v6}, Landroid/graphics/drawable/LayerDrawable;->setLayerSize(III)V

    const/16 v6, 0x32

    invoke-static {v6}, Lcom/mrkeyboard/app/MrShots;->dpx(I)I

    move-result v6

    invoke-virtual {v2, v5, v6}, Landroid/graphics/drawable/LayerDrawable;->setLayerInsetTop(II)V

    invoke-virtual {v2, v5, v6}, Landroid/graphics/drawable/LayerDrawable;->setLayerInsetEnd(II)V

    invoke-virtual {p0, v2}, Landroid/view/View;->setForeground(Landroid/graphics/drawable/Drawable;)V

    const/16 v5, 0x77

    invoke-virtual {p0, v5}, Landroid/view/View;->setForegroundGravity(I)V

    return-void
.end method

.method private doLoadFiles()V
    .locals 15

    const/16 v0, 0x7d0

    new-array v1, v0, [J

    new-array v2, v0, [Ljava/lang/String;

    new-array v3, v0, [Ljava/lang/String;

    new-array v4, v0, [I

    const/4 v5, 0x0

    const/4 v6, 0x0

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    const-wide/16 v9, 0x3e8

    div-long/2addr v7, v9

    const-wide/32 v9, 0x93a80

    sub-long/2addr v7, v9

    sput-wide v7, Lcom/mrkeyboard/app/MrShots;->sCut7:J

    sget-object v7, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    invoke-virtual {v7}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    const-string v8, "external"

    invoke-static {v8}, Landroid/provider/MediaStore$Files;->getContentUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v8

    const/4 v9, 0x5

    new-array v9, v9, [Ljava/lang/String;

    const/4 v10, 0x0

    const-string v11, "_id"

    aput-object v11, v9, v10

    const/4 v10, 0x1

    const-string v11, "_display_name"

    aput-object v11, v9, v10

    const/4 v10, 0x2

    const-string v11, "mime_type"

    aput-object v11, v9, v10

    const/4 v10, 0x3

    const-string v11, "date_added"

    aput-object v11, v9, v10

    sget v10, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v11, 0x1d

    if-lt v10, v11, :cond_legacy

    const-string v11, "relative_path"

    goto :cond_putpath

    :cond_legacy
    const-string v11, "_data"

    :cond_putpath
    const/4 v10, 0x4

    aput-object v11, v9, v10

    const-string v10, "media_type NOT IN (1,3) AND _size>0 AND mime_type IS NOT NULL AND _display_name LIKE '%.%' AND _display_name NOT LIKE '.%'"

    const/4 v11, 0x0

    const-string v12, "date_added DESC"

    invoke-static/range {v7 .. v12}, Lcom/mrkeyboard/app/MrShotQuery;->query(Landroid/content/ContentResolver;Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    if-eqz v6, :cond_noc

    :cond_loop
    if-ge v5, v0, :cond_done

    invoke-interface {v6}, Landroid/database/Cursor;->moveToNext()Z

    move-result v7

    if-eqz v7, :cond_done

    const/4 v7, 0x0

    invoke-interface {v6, v7}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v8

    aput-wide v8, v1, v5

    const/4 v7, 0x1

    invoke-interface {v6, v7}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v7

    aput-object v7, v2, v5

    const/4 v7, 0x2

    invoke-interface {v6, v7}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v7

    aput-object v7, v3, v5

    invoke-static {v6}, Lcom/mrkeyboard/app/MrShots;->scoreFile(Landroid/database/Cursor;)I

    move-result v7

    aput v7, v4, v5

    add-int/lit8 v5, v5, 0x1

    goto :cond_loop

    :cond_done
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    :cond_noc
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_post

    :catch_0
    move-exception v7
    const/4 v7, 0x1
    iput-boolean v7, p0, Lcom/mrkeyboard/app/MrShots;->mFailed:Z

    const/4 v5, 0x0

    if-eqz v6, :goto_post

    :try_start_c
    invoke-interface {v6}, Landroid/database/Cursor;->close()V
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_c

    goto :goto_post

    :catch_c
    move-exception v7

    :goto_post
    const/16 v0, 0x3c

    new-array v7, v0, [J

    new-array v8, v0, [Ljava/lang/String;

    new-array v9, v0, [Ljava/lang/String;

    const/4 v10, 0x0

    const/16 v11, 0x1e

    :goto_pass
    if-ltz v11, :cond_passdone

    const/4 v12, 0x0

    :goto_scan
    if-ge v12, v5, :cond_scandone

    if-ge v10, v0, :cond_scandone

    aget v13, v4, v12

    if-ne v13, v11, :cond_next

    aget-wide v13, v1, v12

    aput-wide v13, v7, v10

    aget-object v13, v2, v12

    aput-object v13, v8, v10

    aget-object v13, v3, v12

    aput-object v13, v9, v10

    add-int/lit8 v10, v10, 0x1

    :cond_next
    add-int/lit8 v12, v12, 0x1

    goto :goto_scan

    :cond_scandone
    add-int/lit8 v11, v11, -0x1

    goto :goto_pass

    :cond_passdone
    iput-object v7, p0, Lcom/mrkeyboard/app/MrShots;->mIds:[J

    iput-object v8, p0, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;

    iput-object v9, p0, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;

    iput v10, p0, Lcom/mrkeyboard/app/MrShots;->mN:I

    const/4 v0, 0x2

    iput v0, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;

    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method



.method private getFileView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;

    .locals 6

    instance-of v0, p2, Landroid/widget/TextView;

    if-eqz v0, :cond_new

    check-cast p2, Landroid/widget/TextView;

    move-object v0, p2

    goto :goto_bind

    :cond_new

    new-instance v0, Landroid/widget/TextView;

    invoke-virtual {p3}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V

    const/4 v1, 0x2

    const/high16 v2, 0x41300000

    invoke-virtual {v0, v1, v2}, Landroid/widget/TextView;->setTextSize(IF)V

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setMaxLines(I)V

    sget-object v1, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    sget v1, Lcom/mrkeyboard/app/MrTools;->sPad:I

    invoke-virtual {v0, v1, v1, v1, v1}, Landroid/view/View;->setPadding(IIII)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setCompoundDrawablePadding(I)V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->cardBg()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    new-instance v1, Landroid/widget/AbsListView$LayoutParams;

    const/4 v2, -0x1

    iget v3, p0, Lcom/mrkeyboard/app/MrShots;->mH:I

    invoke-direct {v1, v2, v3}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    sget v1, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    const/4 v1, 0x0

    const v2, 0x7f0700ed

    invoke-virtual {v0, v1, v2, v1, v1}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    sget v1, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tintColor(Landroid/widget/TextView;I)V

    :goto_bind
    iget-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mIds:[J

    aget-wide v2, v1, p1

    invoke-static {v0, v2, v3}, Lcom/mrkeyboard/app/MrShots;->paint(Landroid/view/View;J)V


    iget-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;

    if-eqz v1, :cond_ret

    array-length v2, v1

    if-ge p1, v2, :cond_ret

    aget-object v1, v1, p1

    if-eqz v1, :cond_ret

    const/16 v2, 0x2e

    invoke-virtual {v1, v2}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v2

    if-gtz v2, :cond_ext

    move-object v3, v1

    goto :goto_set

    :cond_ext

    add-int/lit8 v3, v2, 0x1

    invoke-virtual {v1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v3, "\n"

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    :goto_set

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_ret

    return-object v0

.end method

.method private static submit(Lcom/mrkeyboard/app/MrShots;)V
 .locals 3
 iget v0, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I
 const/4 v1, 0x1
 if-eq v0, v1, :thumbnail
 if-eqz v0, :query
 sget-object v0, Lcom/mrkeyboard/app/MrShots;->sExec:Ljava/util/concurrent/ExecutorService;
 goto :submit
 :query
 sget-object v0, Lcom/mrkeyboard/app/MrShots;->sQueryExec:Ljava/util/concurrent/ExecutorService;
 goto :submit
 :thumbnail
 sget-object v0, Lcom/mrkeyboard/app/MrShots;->sThumbExec:Ljava/util/concurrent/ExecutorService;
 :submit
 if-eqz v0, :rejected
 :try_start
 invoke-interface {v0, p0}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V
 :try_end
 .catch Ljava/util/concurrent/RejectedExecutionException; {:try_start .. :try_end} :catch_rejected
 return-void
 :catch_rejected
 move-exception v0
 :rejected
 iget v0, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I
 const/4 v1, 0x1
 if-eq v0, v1, :done
 if-nez v0, :copy_rejected
 const/4 v1, 0x0
 sput-boolean v1, Lcom/mrkeyboard/app/MrShots;->sQueryPending:Z
 goto :notify
 :copy_rejected
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->dropSrc()V
 const/4 v1, 0x0
 sput-boolean v1, Lcom/mrkeyboard/app/MrShots;->sBusy:Z
 :notify
 const-string v0, "Fila de anexos ocupada. Tente novamente."

 invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->a(Ljava/lang/String;)Ljava/lang/String;

 move-result-object v0
 invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V
 :done
 return-void
.end method

.method static clearSel()V
    .locals 4

    sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sSelOn:Z

    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrShots;->sSelOn:Z

    sget-object v1, Lcom/mrkeyboard/app/MrShots;->sSel:Ljava/util/HashSet;

    if-eqz v1, :no_set

    invoke-virtual {v1}, Ljava/util/HashSet;->clear()V

    :no_set
    if-eqz v0, :no_marks

    sget-object v1, Lcom/mrkeyboard/app/MrShots;->sGrid:Landroid/widget/GridView;

    if-eqz v1, :no_marks

    invoke-virtual {v1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v2

    :unmark_loop
    add-int/lit8 v2, v2, -0x1

    if-ltz v2, :no_marks

    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrShots;->unmark(Landroid/view/View;)V

    goto :unmark_loop

    :no_marks
    sget-object v1, Lcom/mrkeyboard/app/MrShots;->sBar:Landroid/view/View;

    if-eqz v1, :no_bar

    const/16 v0, 0x8

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    :no_bar
    sget-object v1, Lcom/mrkeyboard/app/MrShots;->sPick:Landroid/view/View;

    if-eqz v1, :no_pick

    const/4 v0, 0x0

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    :no_pick
    return-void
.end method

.method static toggleSel(J)Z
    .locals 3

    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sSel:Ljava/util/HashSet;

    if-nez v0, :have_set

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrShots;->sSel:Ljava/util/HashSet;

    :have_set
    invoke-static {p0, p1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/HashSet;->remove(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :add_id

    const/4 v2, 0x0

    return v2

    :add_id
    invoke-virtual {v0, v1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    const/4 v2, 0x1

    return v2
.end method

.method static selCount()I
    .locals 1

    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sSel:Ljava/util/HashSet;

    if-nez v0, :has_set

    const/4 v0, 0x0

    return v0

    :has_set
    invoke-virtual {v0}, Ljava/util/HashSet;->size()I

    move-result v0

    return v0
.end method

.method private static inList(J)Z
    .locals 7

    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sAdp:Lcom/mrkeyboard/app/MrShots;

    if-eqz v0, :not_found

    iget-object v1, v0, Lcom/mrkeyboard/app/MrShots;->mIds:[J

    if-eqz v1, :not_found

    iget v2, v0, Lcom/mrkeyboard/app/MrShots;->mN:I

    const/4 v3, 0x0

    :scan
    if-ge v3, v2, :not_found

    aget-wide v4, v1, v3

    cmp-long v6, v4, p0

    if-eqz v6, :found

    add-int/lit8 v3, v3, 0x1

    goto :scan

    :found
    const/4 v0, 0x1

    return v0

    :not_found
    const/4 v0, 0x0

    return v0
.end method

.method private static pruneSel()V
    .locals 5

    sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sSelOn:Z

    if-eqz v0, :prune_end

    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sSel:Ljava/util/HashSet;

    if-eqz v0, :prune_clear

    invoke-virtual {v0}, Ljava/util/HashSet;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :prune_loop
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :prune_after

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Long;

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrShots;->inList(J)Z

    move-result v4

    if-nez v4, :prune_loop

    invoke-interface {v1}, Ljava/util/Iterator;->remove()V

    goto :prune_loop

    :prune_after
    invoke-virtual {v0}, Ljava/util/HashSet;->isEmpty()Z

    move-result v2

    if-eqz v2, :prune_upd

    :prune_clear
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->clearSel()V

    goto :prune_end

    :prune_upd
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->updateSel()V

    :prune_end
    return-void
.end method

.method static isSel(J)Z
    .locals 3

    sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sSelOn:Z

    if-eqz v0, :not_sel

    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sSel:Ljava/util/HashSet;

    if-eqz v0, :not_sel

    invoke-static {p0, p1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v2

    return v2

    :not_sel
    const/4 v2, 0x0

    return v2
.end method

.method private static mark(Landroid/view/View;)V
    .locals 2

    instance-of v0, p0, Landroid/widget/TextView;

    if-eqz v0, :mark_fore

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->selFill()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    :mark_fore
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrShots;->fore(Landroid/view/View;Z)V

    return-void
.end method

.method private static unmark(Landroid/view/View;)V
    .locals 2

    instance-of v0, p0, Landroid/widget/TextView;

    if-eqz v0, :unmark_fore

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->cardBg()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    :unmark_fore
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrShots;->fore(Landroid/view/View;Z)V

    return-void
.end method

.method private static paint(Landroid/view/View;J)V
    .locals 1

    invoke-static {p1, p2}, Lcom/mrkeyboard/app/MrShots;->isSel(J)Z

    move-result v0

    if-eqz v0, :paint_off

    invoke-static {p0}, Lcom/mrkeyboard/app/MrShots;->mark(Landroid/view/View;)V

    return-void

    :paint_off
    invoke-static {p0}, Lcom/mrkeyboard/app/MrShots;->unmark(Landroid/view/View;)V

    return-void
.end method

.method private static updateSel()V
    .locals 5

    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sBar:Landroid/view/View;

    if-eqz v0, :upd_nobar

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :upd_nobar
    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sPick:Landroid/view/View;

    if-eqz v0, :upd_nopick

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :upd_nopick
    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sSend:Landroid/widget/TextView;

    if-eqz v0, :upd_end

    const v1, 0x7f0c01d4

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->selCount()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    const/4 v4, 0x0

    aput-object v3, v2, v4

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :upd_end
    return-void
.end method

.method static styleSel()V
    .locals 6

    const/high16 v5, 0x40000000    # 2.0f

    invoke-static {v5}, Lcom/mrkeyboard/app/MrTools;->radius(F)F

    move-result v5

    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sSend:Landroid/widget/TextView;

    if-eqz v0, :style_cancel

    const-string v1, "sel_send"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    const-string v2, "sel_send_stroke"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v2

    const-string v3, "sel_send_text"

    invoke-static {v3}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v3

    invoke-static {v1, v2, v3, v5}, Lcom/mrkeyboard/app/MrTools;->roleBg(IIIF)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrTools;->tintColor(Landroid/widget/TextView;I)V

    :style_cancel
    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sCancel:Landroid/widget/TextView;

    if-eqz v0, :style_end

    const-string v1, "sel_cancel"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    const-string v2, "sel_cancel_stroke"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v2

    const-string v3, "sel_cancel_text"

    invoke-static {v3}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v3

    invoke-static {v1, v2, v3, v5}, Lcom/mrkeyboard/app/MrTools;->roleBg(IIIF)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setTextColor(I)V

    :style_end
    return-void
.end method

.method static stylePick()V
    .locals 4

    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sPick:Landroid/view/View;

    if-eqz v0, :pick_end

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->fabBg()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    sget-boolean v1, Lcom/mrkeyboard/app/MrShots;->sSelOn:Z

    if-eqz v1, :pick_show

    const/16 v1, 0x8

    goto :pick_vis

    :pick_show
    const/4 v1, 0x0

    :pick_vis
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->category()I

    move-result v1

    const v2, 0x7f0700f3

    if-eqz v1, :pick_ic

    const v2, 0x7f0700f4

    const/4 v3, 0x1

    if-eq v1, v3, :pick_ic

    const v2, 0x7f0700f5

    :pick_ic
    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/content/Context;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    check-cast v0, Landroid/widget/TextView;

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1, v2, v2}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    const-string v1, "attach_fab_icon"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tintColor(Landroid/widget/TextView;I)V

    :pick_end
    return-void
.end method

.method static pick()V
    .locals 4

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    if-nez v0, :pk_ok

    return-void

    :pk_ok
    new-instance v1, Lcom/mrkeyboard/app/MrShots;

    const/4 v2, 0x7

    invoke-direct {v1, v2}, Lcom/mrkeyboard/app/MrShots;-><init>(I)V

    invoke-direct {v1}, Lcom/mrkeyboard/app/MrShots;->captureTarget()V

    sput-object v1, Lcom/mrkeyboard/app/MrShots;->sPickJob:Lcom/mrkeyboard/app/MrShots;

    new-instance v2, Landroid/content/Intent;

    const-class v3, Lcom/mrkeyboard/app/ShotPick;

    invoke-direct {v2, v0, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v3, "c"

    iget v1, v1, Lcom/mrkeyboard/app/MrShots;->mCategory:I

    invoke-virtual {v2, v3, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const/high16 v1, 0x10000000

    invoke-virtual {v2, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    :try_start_0
    invoke-virtual {v0, v2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrShots;->sPickJob:Lcom/mrkeyboard/app/MrShots;

    return-void
.end method

.method static onPicked(Ljava/util/ArrayList;)V
    .locals 3

    sget-object v0, Lcom/mrkeyboard/app/MrShots;->sPickJob:Lcom/mrkeyboard/app/MrShots;

    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrShots;->sPickJob:Lcom/mrkeyboard/app/MrShots;

    if-eqz v0, :pk_drop

    sget v1, Lcom/mrkeyboard/app/MrShots;->sSession:I

    iget v2, v0, Lcom/mrkeyboard/app/MrShots;->mSession:I

    if-ne v1, v2, :pk_drop

    sget-boolean v1, Lcom/mrkeyboard/app/MrShots;->sBusy:Z

    if-nez v1, :pk_drop

    invoke-static {}, Lcom/mrkeyboard/app/MrCacheClear;->isBusy()Z

    move-result v1

    if-nez v1, :pk_drop

    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x1

    if-eq v1, v2, :pk_one

    if-lt v1, v2, :pk_drop

    iput-object p0, v0, Lcom/mrkeyboard/app/MrShots;->mBS:Ljava/util/ArrayList;

    sput-boolean v2, Lcom/mrkeyboard/app/MrShots;->sBusy:Z

    const/16 v1, 0xc

    iput v1, v0, Lcom/mrkeyboard/app/MrShots;->mMode:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->submit(Lcom/mrkeyboard/app/MrShots;)V

    return-void

    :pk_one
    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/Uri;

    iput-object v1, v0, Lcom/mrkeyboard/app/MrShots;->mSrc:Landroid/net/Uri;

    sput-boolean v2, Lcom/mrkeyboard/app/MrShots;->sBusy:Z

    const/16 v1, 0x9

    iput v1, v0, Lcom/mrkeyboard/app/MrShots;->mMode:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->submit(Lcom/mrkeyboard/app/MrShots;)V

    return-void

    :pk_drop
    invoke-static {p0}, Lcom/mrkeyboard/app/MrShots;->dropAll(Ljava/util/ArrayList;)V

    return-void
.end method

.method private static dropGrant(Landroid/net/Uri;)V
    .locals 2

    if-eqz p0, :dg_done

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, p0, v1}, Landroid/content/ContentResolver;->releasePersistableUriPermission(Landroid/net/Uri;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :dg_done
    return-void

    :catch_0
    move-exception v0

    return-void
.end method

.method private static dropAll(Ljava/util/ArrayList;)V
    .locals 3

    if-eqz p0, :da_done

    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    :da_loop
    if-ge v1, v0, :da_done

    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/net/Uri;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrShots;->dropGrant(Landroid/net/Uri;)V

    add-int/lit8 v1, v1, 0x1

    goto :da_loop

    :da_done
    return-void
.end method

.method private dropSrc()V
    .locals 1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mSrc:Landroid/net/Uri;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->dropGrant(Landroid/net/Uri;)V

    iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mBS:Ljava/util/ArrayList;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->dropAll(Ljava/util/ArrayList;)V

    return-void
.end method

.method private lateDrop()V
    .locals 3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mSrc:Landroid/net/Uri;

    if-nez v0, :ld_go

    iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mBS:Ljava/util/ArrayList;

    if-eqz v0, :ld_done

    :ld_go

    const/16 v0, 0xb

    iput v0, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;

    const-wide/32 v1, 0xea60

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :ld_done
    return-void
.end method

.method private static uriName(Landroid/net/Uri;)Ljava/lang/String;
    .locals 9

    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/String;

    const-string v4, "_display_name"

    const/4 v8, 0x0

    aput-object v4, v3, v8

    move-object v2, p0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v7

    if-eqz v7, :un_done

    invoke-interface {v7}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v1

    if-eqz v1, :un_close

    invoke-interface {v7, v8}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    :un_close
    invoke-interface {v7}, Landroid/database/Cursor;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :un_done
    return-object v0

    :catch_0
    move-exception v1

    return-object v0
.end method

.method private static copyUri(Landroid/net/Uri;Ljava/lang/String;I)Ljava/io/File;
    .locals 8

    invoke-static {p2}, Lcom/mrkeyboard/app/MrShots;->assertCopySession(I)V

    if-nez p1, :cu_name

    const-string p1, "anexo"

    :cu_name
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v1

    new-instance v2, Ljava/io/File;

    const-string v3, "shots"

    invoke-direct {v2, v1, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    invoke-static {v2}, Lcom/mrkeyboard/app/MrShots;->clean(Ljava/io/File;)V

    invoke-static {v2, p1}, Lcom/mrkeyboard/app/MrCopyRetention;->target(Ljava/io/File;Ljava/lang/String;)Ljava/io/File;

    move-result-object v3

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    invoke-virtual {v1, p0}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v4

    invoke-virtual {v3}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v6

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v6, ".part"

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    new-instance v5, Ljava/io/File;

    invoke-direct {v5, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v4, v5, p2}, Lcom/mrkeyboard/app/MrShots;->copyToPart(Ljava/io/InputStream;Ljava/io/File;I)V

    invoke-static {v5, v3, p2}, Lcom/mrkeyboard/app/MrShots;->commitCopy(Ljava/io/File;Ljava/io/File;I)V

    invoke-static {v3}, Lcom/mrkeyboard/app/MrCopyRetention;->touch(Ljava/io/File;)V

    return-object v3
.end method

.method private prepareUri()V
    .locals 5

    const/4 v3, 0x0

    :try_start
    invoke-static {}, Lcom/mrkeyboard/app/MrCopyRetention;->sweep()V

    iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mSrc:Landroid/net/Uri;

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "r"

    invoke-virtual {v1, v0, v2}, Landroid/content/ContentResolver;->openAssetFileDescriptor(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;

    move-result-object v3

    if-eqz v3, :unreadable

    invoke-virtual {v3}, Landroid/content/res/AssetFileDescriptor;->close()V

    const/4 v3, 0x0

    invoke-virtual {v1, v0}, Landroid/content/ContentResolver;->getType(Landroid/net/Uri;)Ljava/lang/String;

    move-result-object v2

    if-nez v2, :mime_ready

    const-string v2, "application/octet-stream"

    :mime_ready
    iput-object v2, p0, Lcom/mrkeyboard/app/MrShots;->mMime:Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mOriginal:Landroid/net/Uri;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrShots;->mName:Ljava/lang/String;

    if-nez v2, :name_ready

    invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->uriName(Landroid/net/Uri;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrShots;->mName:Ljava/lang/String;

    :name_ready
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :failed
    .catchall {:try_start .. :try_end} :fatal

    goto :post

    :unreadable
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mOriginal:Landroid/net/Uri;

    goto :post

    :failed
    move-exception v0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrShots;->closeQuietly(Ljava/io/Closeable;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mOriginal:Landroid/net/Uri;

    goto :post

    :fatal
    move-exception v0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrShots;->closeQuietly(Ljava/io/Closeable;)V

    throw v0

    :post
    const/16 v0, 0xa

    iput v0, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I

    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrShots;->mN:I

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;

    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method private awaitTarget()V
    .locals 4

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    if-eqz v0, :at_wait

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v1

    if-eqz v1, :at_wait

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v0

    if-eqz v0, :at_wait

    iget-object v0, v0, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrShots;->mTargetPackage:Ljava/lang/String;

    if-eqz v2, :at_wait

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :at_wait

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mTarget:Ljava/lang/ref/WeakReference;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mBU:Ljava/util/ArrayList;

    if-eqz v0, :at_single

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->runBatch()V

    return-void

    :at_single
    const/16 v0, 0x8

    iput v0, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->finishDirect()V

    return-void

    :at_wait
    iget v0, p0, Lcom/mrkeyboard/app/MrShots;->mN:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrShots;->mN:I

    const/16 v1, 0x14

    if-lt v0, v1, :at_retry

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->cancelDelivery()V

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->dropSrc()V

    return-void

    :at_retry
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;

    const-wide/16 v2, 0x96

    invoke-virtual {v1, p0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method public onItemLongClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)Z
    .locals 4

    invoke-static {}, Lcom/mrkeyboard/app/MrCacheClear;->isBusy()Z

    move-result v0

    if-nez v0, :long_done

    sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sBusy:Z

    if-nez v0, :long_done

    if-ltz p3, :long_done

    iget v0, p0, Lcom/mrkeyboard/app/MrShots;->mN:I

    if-ge p3, v0, :long_done

    iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mIds:[J

    aget-wide v1, v0, p3

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrShots;->isSel(J)Z

    move-result v0

    if-nez v0, :long_done

    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrShots;->sSelOn:Z

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrShots;->toggleSel(J)Z

    invoke-static {p2, v1, v2}, Lcom/mrkeyboard/app/MrShots;->paint(Landroid/view/View;J)V

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->updateSel()V

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->buzz()V

    :long_done
    const/4 v0, 0x1

    return v0
.end method

.method static release()V
 .locals 2
 invoke-static {}, Lcom/mrkeyboard/app/MrShots;->clearSel()V
 sget v0, Lcom/mrkeyboard/app/MrShots;->sSession:I
 add-int/lit8 v0, v0, 0x1
 sput v0, Lcom/mrkeyboard/app/MrShots;->sSession:I
 sget v0, Lcom/mrkeyboard/app/MrShots;->sGen:I
 add-int/lit8 v0, v0, 0x1
 sput v0, Lcom/mrkeyboard/app/MrShots;->sGen:I
 sget-object v0, Lcom/mrkeyboard/app/MrShots;->sExec:Ljava/util/concurrent/ExecutorService;
 if-eqz v0, :thumbs
 invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdownNow()Ljava/util/List;
 :thumbs
 sget-object v0, Lcom/mrkeyboard/app/MrShots;->sQueryExec:Ljava/util/concurrent/ExecutorService;
 if-eqz v0, :query_stopped
 invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdownNow()Ljava/util/List;
 :query_stopped
 sget-object v0, Lcom/mrkeyboard/app/MrShots;->sThumbExec:Ljava/util/concurrent/ExecutorService;
 if-eqz v0, :cache
 invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdownNow()Ljava/util/List;
 :cache
 sget-object v0, Lcom/mrkeyboard/app/MrShots;->sCache:Landroid/util/LruCache;
 if-eqz v0, :clear
 invoke-virtual {v0}, Landroid/util/LruCache;->evictAll()V
 :clear
 const/4 v0, 0x0
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sQueryExec:Ljava/util/concurrent/ExecutorService;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sLists:[Lcom/mrkeyboard/app/MrShots;
 sput-boolean v0, Lcom/mrkeyboard/app/MrShots;->sQueryPending:Z
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sExec:Ljava/util/concurrent/ExecutorService;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sThumbExec:Ljava/util/concurrent/ExecutorService;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sAdp:Lcom/mrkeyboard/app/MrShots;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sCache:Landroid/util/LruCache;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sGrid:Landroid/widget/GridView;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sEmpty:Landroid/widget/TextView;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sBF:Landroid/widget/TextView;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sBV:Landroid/widget/TextView;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sBA:Landroid/widget/TextView;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sSel:Ljava/util/HashSet;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sPick:Landroid/view/View;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sBar:Landroid/view/View;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sCancel:Landroid/widget/TextView;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sSend:Landroid/widget/TextView;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sPickJob:Lcom/mrkeyboard/app/MrShots;
 sput-boolean v0, Lcom/mrkeyboard/app/MrShots;->sBusy:Z
 return-void
.end method

.method private static closeQuietly(Ljava/io/Closeable;)V
 .locals 1
 if-eqz p0, :done
 :try_start
 invoke-interface {p0}, Ljava/io/Closeable;->close()V
 :try_end
 .catch Ljava/lang/Exception; {:try_start .. :try_end} :ignored
 return-void
 :ignored
 move-exception v0
 :done
 return-void
.end method

.method private static copyToPart(Ljava/io/InputStream;Ljava/io/File;I)V
 .locals 4
 const/4 v0, 0x0
 invoke-virtual {p1}, Ljava/io/File;->getParentFile()Ljava/io/File;
 move-result-object v3
 invoke-static {v3}, Lcom/mrkeyboard/app/MrCopyRetention;->protect(Ljava/io/File;)V
 :try_start
 invoke-static {p2}, Lcom/mrkeyboard/app/MrShots;->assertCopySession(I)V
 invoke-virtual {v3}, Ljava/io/File;->mkdirs()Z
 new-instance v1, Ljava/io/FileOutputStream;
 invoke-direct {v1, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
 move-object v0, v1
 invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrShots;->pipe(Ljava/io/InputStream;Ljava/io/OutputStream;)V
 invoke-virtual {v0}, Ljava/io/OutputStream;->close()V
 invoke-virtual {p0}, Ljava/io/InputStream;->close()V
 invoke-static {p1}, Lcom/mrkeyboard/app/MrCopyRetention;->touch(Ljava/io/File;)V
 :try_end
 .catchall {:try_start .. :try_end} :failed
 invoke-static {v3}, Lcom/mrkeyboard/app/MrCopyRetention;->unprotect(Ljava/io/File;)V
 return-void
 :failed
 move-exception v2
 invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->closeQuietly(Ljava/io/Closeable;)V
 invoke-static {p0}, Lcom/mrkeyboard/app/MrShots;->closeQuietly(Ljava/io/Closeable;)V
 invoke-virtual {p1}, Ljava/io/File;->delete()Z
 invoke-static {v3}, Lcom/mrkeyboard/app/MrCopyRetention;->unprotect(Ljava/io/File;)V
 invoke-virtual {v3}, Ljava/io/File;->delete()Z
 throw v2
.end method


.method public static reload()V
 .locals 1
 invoke-static {}, Lcom/mrkeyboard/app/MrShots;->clearSel()V
 const/4 v0, 0x1
 invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->request(Z)V
 return-void
.end method

.method private static category()I
 .locals 1
 sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sFiles:Z
 if-eqz v0, :media
 const/4 v0, 0x2
 return v0
 :media
 sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sVid:Z
 return v0
.end method

.method private static storeSnapshot(Lcom/mrkeyboard/app/MrShots;)V
 .locals 4
 sget-object v0, Lcom/mrkeyboard/app/MrShots;->sLists:[Lcom/mrkeyboard/app/MrShots;
 if-nez v0, :ready
 const/4 v1, 0x3
 new-array v0, v1, [Lcom/mrkeyboard/app/MrShots;
 sput-object v0, Lcom/mrkeyboard/app/MrShots;->sLists:[Lcom/mrkeyboard/app/MrShots;
 :ready
 iget v1, p0, Lcom/mrkeyboard/app/MrShots;->mCategory:I
 # Preserve each category's last scroll position when replacing its snapshot.
 aget-object v2, v0, v1
 if-eqz v2, :store
 iget v2, v2, Lcom/mrkeyboard/app/MrShots;->mScroll:I
 iput v2, p0, Lcom/mrkeyboard/app/MrShots;->mScroll:I
 :store
 invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
 move-result-wide v2
 iput-wide v2, p0, Lcom/mrkeyboard/app/MrShots;->mCachedAt:J
 aput-object p0, v0, v1
 return-void
.end method

.method private static showCached()Z
 .locals 8
 invoke-static {}, Lcom/mrkeyboard/app/MrShots;->category()I
 move-result v0
 sget-object v1, Lcom/mrkeyboard/app/MrShots;->sAdp:Lcom/mrkeyboard/app/MrShots;
 sget-object v2, Lcom/mrkeyboard/app/MrShots;->sLists:[Lcom/mrkeyboard/app/MrShots;
 const/4 v3, 0x0
 if-eqz v2, :no_snapshot
 aget-object v3, v2, v0
 :no_snapshot
 iget v4, v1, Lcom/mrkeyboard/app/MrShots;->mCategory:I
 if-eq v4, v0, :check_fresh
 # Save old category scroll before binding the new category's data.
 if-eqz v2, :switch
 aget-object v5, v2, v4
 if-eqz v5, :switch
 sget-object v6, Lcom/mrkeyboard/app/MrShots;->sGrid:Landroid/widget/GridView;
 invoke-virtual {v6}, Landroid/widget/AdapterView;->getFirstVisiblePosition()I
 move-result v6
 iput v6, v5, Lcom/mrkeyboard/app/MrShots;->mScroll:I
 :switch
 iput v0, v1, Lcom/mrkeyboard/app/MrShots;->mCategory:I
 sget v4, Lcom/mrkeyboard/app/MrShots;->sThumbGen:I
 add-int/lit8 v4, v4, 0x1
 sput v4, Lcom/mrkeyboard/app/MrShots;->sThumbGen:I
 # Pending thumbnails from the previous tab must not delay this tab.
 sget-object v4, Lcom/mrkeyboard/app/MrShots;->sThumbExec:Ljava/util/concurrent/ExecutorService;
 check-cast v4, Ljava/util/concurrent/ThreadPoolExecutor;
 if-eqz v4, :bind
 invoke-virtual {v4}, Ljava/util/concurrent/ThreadPoolExecutor;->getQueue()Ljava/util/concurrent/BlockingQueue;
 move-result-object v4
 invoke-interface {v4}, Ljava/util/Collection;->clear()V
 :bind
 const/4 v4, 0x0
 iput v4, v1, Lcom/mrkeyboard/app/MrShots;->mN:I
 iput-object v4, v1, Lcom/mrkeyboard/app/MrShots;->mIds:[J
 iput-object v4, v1, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;
 iput-object v4, v1, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;
 if-eqz v3, :notify
 iget v4, v3, Lcom/mrkeyboard/app/MrShots;->mN:I
 iput v4, v1, Lcom/mrkeyboard/app/MrShots;->mN:I
 iget-object v4, v3, Lcom/mrkeyboard/app/MrShots;->mIds:[J
 iput-object v4, v1, Lcom/mrkeyboard/app/MrShots;->mIds:[J
 iget-object v4, v3, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;
 iput-object v4, v1, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;
 iget-object v4, v3, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;
 iput-object v4, v1, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;
 :notify
 invoke-virtual {v1}, Landroid/widget/BaseAdapter;->notifyDataSetChanged()V
 sget-object v1, Lcom/mrkeyboard/app/MrShots;->sGrid:Landroid/widget/GridView;
 const/4 v4, 0x0
 if-eqz v3, :select
 iget v4, v3, Lcom/mrkeyboard/app/MrShots;->mScroll:I
 :select
 invoke-virtual {v1, v4}, Landroid/widget/GridView;->setSelection(I)V
 :check_fresh
 if-eqz v3, :stale
 iget v0, v3, Lcom/mrkeyboard/app/MrShots;->mN:I
 if-nez v0, :cache_age
 const/4 v0, 0x0
 sput-boolean v0, Lcom/mrkeyboard/app/MrShots;->sMore:Z
 const v0, 0x7f0c01cb
 sget-boolean v1, Lcom/mrkeyboard/app/MrShots;->sFiles:Z
 if-eqz v1, :cache_empty_video
 const v0, 0x7f0c01cf
 goto :cache_empty_text
 :cache_empty_video
 sget-boolean v1, Lcom/mrkeyboard/app/MrShots;->sVid:Z
 if-eqz v1, :cache_empty_text
 const v0, 0x7f0c01ce
 :cache_empty_text
 invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;
 move-result-object v0
 sget-object v1, Lcom/mrkeyboard/app/MrShots;->sEmpty:Landroid/widget/TextView;
 invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
 :cache_age
 invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
 move-result-wide v4
 iget-wide v6, v3, Lcom/mrkeyboard/app/MrShots;->mCachedAt:J
 sub-long/2addr v4, v6
 const-wide/16 v6, 0x3a98
 cmp-long v0, v4, v6
 if-gez v0, :stale
 const/4 v0, 0x1
 return v0
 :stale
 const/4 v0, 0x0
 return v0
.end method

# Called only on the UI thread; never read View state from a decoding worker.
.method static pruneThumbs(Landroid/graphics/Rect;)V
 .locals 8
 sget-object v0, Lcom/mrkeyboard/app/MrShots;->sThumbExec:Ljava/util/concurrent/ExecutorService;
 if-eqz v0, :done
 check-cast v0, Ljava/util/concurrent/ThreadPoolExecutor;
 invoke-virtual {v0}, Ljava/util/concurrent/ThreadPoolExecutor;->getQueue()Ljava/util/concurrent/BlockingQueue;
 move-result-object v0
 invoke-interface {v0}, Ljava/util/Collection;->isEmpty()Z
 move-result v1
 if-nez v1, :done
 invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;
 move-result-object v1
 :next
 invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
 move-result v2
 if-eqz v2, :done
 invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
 move-result-object v2
 check-cast v2, Lcom/mrkeyboard/app/MrShots;
 iget v3, v2, Lcom/mrkeyboard/app/MrShots;->mThumbGen:I
 sget v4, Lcom/mrkeyboard/app/MrShots;->sThumbGen:I
 if-ne v3, v4, :remove
 iget-object v3, v2, Lcom/mrkeyboard/app/MrShots;->mView:Ljava/lang/ref/WeakReference;
 if-eqz v3, :remove
 invoke-virtual {v3}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;
 move-result-object v3
 check-cast v3, Landroid/widget/ImageView;
 if-eqz v3, :remove
 invoke-virtual {v3}, Landroid/view/View;->getTag()Ljava/lang/Object;
 move-result-object v4
 instance-of v5, v4, Ljava/lang/Long;
 if-eqz v5, :remove
 check-cast v4, Ljava/lang/Long;
 invoke-virtual {v4}, Ljava/lang/Long;->longValue()J
 move-result-wide v4
 iget-wide v6, v2, Lcom/mrkeyboard/app/MrShots;->mId:J
 cmp-long v4, v4, v6
 if-nez v4, :remove
 # Initial layout may enqueue before attachment: do not prune those jobs.
 invoke-virtual {v3}, Landroid/view/View;->isAttachedToWindow()Z
 move-result v4
 if-eqz v4, :next
 invoke-virtual {v3, p0}, Landroid/view/View;->getLocalVisibleRect(Landroid/graphics/Rect;)Z
 move-result v4
 if-nez v4, :next
 :remove
 invoke-interface {v0, v2}, Ljava/util/Collection;->remove(Ljava/lang/Object;)Z
 goto :next
 :done
 return-void
.end method

.method private captureTarget()V
 .locals 3
 sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;
 if-eqz v0, :done
 invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;
 move-result-object v1
 if-eqz v1, :done
 new-instance v2, Ljava/lang/ref/WeakReference;
 invoke-direct {v2, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V
 iput-object v2, p0, Lcom/mrkeyboard/app/MrShots;->mTarget:Ljava/lang/ref/WeakReference;
 invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;
 move-result-object v0
 if-eqz v0, :done
 iget-object v0, v0, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;
 iput-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mTargetPackage:Ljava/lang/String;
 :done
 return-void
.end method

.method private targetIsCurrent()Z
 .locals 4
 iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mTarget:Ljava/lang/ref/WeakReference;
 if-eqz v0, :no
 invoke-virtual {v0}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;
 move-result-object v0
 if-eqz v0, :no
 sget-object v1, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;
 if-eqz v1, :no
 invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;
 move-result-object v2
 if-ne v0, v2, :no
 invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;
 move-result-object v1
 if-eqz v1, :no
 iget-object v1, v1, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;
 iget-object v2, p0, Lcom/mrkeyboard/app/MrShots;->mTargetPackage:Ljava/lang/String;
 if-eqz v2, :no
 invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
 move-result v0
 return v0
 :no
 const/4 v0, 0x0
 return v0
.end method

.method private cancelDelivery()V
 .locals 1
 const/4 v0, 0x0
 sput-boolean v0, Lcom/mrkeyboard/app/MrShots;->sBusy:Z
 const-string v0, "O campo de destino mudou. Selecione o anexo novamente."

 invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->a(Ljava/lang/String;)Ljava/lang/String;

 move-result-object v0
 invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V
 return-void
.end method

# Worker prepares a readable original URI + MIME only. No byte-stream copy here.
.method private prepareDirect()V
 .locals 7
 const/4 v3, 0x0
 :try_start
 invoke-static {}, Lcom/mrkeyboard/app/MrCopyRetention;->sweep()V
 iget v0, p0, Lcom/mrkeyboard/app/MrShots;->mCategory:I
 const/4 v1, 0x2
 if-ne v0, v1, :media
 const-string v0, "external"
 invoke-static {v0}, Landroid/provider/MediaStore$Files;->getContentUri(Ljava/lang/String;)Landroid/net/Uri;
 move-result-object v0
 iget-wide v1, p0, Lcom/mrkeyboard/app/MrShots;->mId:J
 invoke-static {v0, v1, v2}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;
 move-result-object v0
 goto :uri_ready
 :media
 iget-wide v1, p0, Lcom/mrkeyboard/app/MrShots;->mId:J
 invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrShots;->uriFor(J)Landroid/net/Uri;
 move-result-object v0
 :uri_ready
 sget-object v1, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;
 invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
 move-result-object v1
 const-string v2, "r"
 invoke-virtual {v1, v0, v2}, Landroid/content/ContentResolver;->openAssetFileDescriptor(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;
 move-result-object v3
 if-eqz v3, :unreadable
 invoke-virtual {v3}, Landroid/content/res/AssetFileDescriptor;->close()V
 const/4 v3, 0x0
 iget-object v2, p0, Lcom/mrkeyboard/app/MrShots;->mMime:Ljava/lang/String;
 if-nez v2, :mime_ready
 invoke-virtual {v1, v0}, Landroid/content/ContentResolver;->getType(Landroid/net/Uri;)Ljava/lang/String;
 move-result-object v2
 if-nez v2, :mime_ready
 const-string v2, "application/octet-stream"
 :mime_ready
 iput-object v2, p0, Lcom/mrkeyboard/app/MrShots;->mMime:Ljava/lang/String;
 iput-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mOriginal:Landroid/net/Uri;
 :try_end
 .catch Ljava/lang/Exception; {:try_start .. :try_end} :failed
 .catchall {:try_start .. :try_end} :fatal
 goto :post
 :unreadable
 const/4 v0, 0x0
 iput-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mOriginal:Landroid/net/Uri;
 goto :post
 :failed
 move-exception v0
 invoke-static {v3}, Lcom/mrkeyboard/app/MrShots;->closeQuietly(Ljava/io/Closeable;)V
 const/4 v0, 0x0
 iput-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mOriginal:Landroid/net/Uri;
 goto :post
 :fatal
 move-exception v0
 invoke-static {v3}, Lcom/mrkeyboard/app/MrShots;->closeQuietly(Ljava/io/Closeable;)V
 throw v0
 :post
 const/16 v0, 0x8
 iput v0, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I
 sget-object v0, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;
 invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
 return-void
.end method

.method private finishDirect()V
 .locals 3
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->targetIsCurrent()Z
 move-result v0
 if-nez v0, :target_current
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->cancelDelivery()V
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->dropSrc()V
 return-void
 :target_current
 sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;
 iget-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mOriginal:Landroid/net/Uri;
 iget-object v2, p0, Lcom/mrkeyboard/app/MrShots;->mMime:Ljava/lang/String;
 invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrDirectSend;->send(Lcom/mrkeyboard/app/LatinIME;Landroid/net/Uri;Ljava/lang/String;)Z
 move-result v0
 if-eqz v0, :copy_fallback
 const/4 v0, 0x0
 sput-boolean v0, Lcom/mrkeyboard/app/MrShots;->sBusy:Z
 invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->lateDrop()V
 return-void
 :copy_fallback
 const/4 v0, 0x5
 iput v0, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I
 invoke-static {p0}, Lcom/mrkeyboard/app/MrShots;->submit(Lcom/mrkeyboard/app/MrShots;)V
 return-void
.end method

# No disk/stream copy occurs under this monitor: only publication and epoch checks.
.method private static assertCopySession(I)V
 .locals 1
 sget v0, Lcom/mrkeyboard/app/MrShots;->sSession:I
 if-eq p0, v0, :ok
 new-instance v0, Ljava/io/InterruptedIOException;
 invoke-direct {v0}, Ljava/io/InterruptedIOException;-><init>()V
 throw v0
 :ok
 return-void
.end method

.method private static declared-synchronized commitCopy(Ljava/io/File;Ljava/io/File;I)V
 .locals 4
 const-class v2, Lcom/mrkeyboard/app/MrShots;
 monitor-enter v2
 :sync_try_start
 sget v0, Lcom/mrkeyboard/app/MrShots;->sSession:I
 if-ne p2, v0, :failed
 invoke-virtual {p0, p1}, Ljava/io/File;->renameTo(Ljava/io/File;)Z
 move-result v0
 if-eqz v0, :failed
 goto :sync_return_0
 :failed
 invoke-virtual {p0}, Ljava/io/File;->delete()Z
 invoke-virtual {p0}, Ljava/io/File;->getParentFile()Ljava/io/File;
 move-result-object v0
 invoke-virtual {v0}, Ljava/io/File;->delete()Z
 new-instance v0, Ljava/io/InterruptedIOException;
 const-string v1, "Attachment copy cancelled or could not be committed"
 invoke-direct {v0, v1}, Ljava/io/InterruptedIOException;-><init>(Ljava/lang/String;)V
 throw v0
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

.method private static declared-synchronized cacheThumbnail(Lcom/mrkeyboard/app/MrShots;Landroid/graphics/Bitmap;)V
 .locals 6
 const-class v4, Lcom/mrkeyboard/app/MrShots;
 monitor-enter v4
 :sync_try_start
 iget v0, p0, Lcom/mrkeyboard/app/MrShots;->mSession:I
 sget v1, Lcom/mrkeyboard/app/MrShots;->sSession:I
 if-ne v0, v1, :done
 iget v0, p0, Lcom/mrkeyboard/app/MrShots;->mThumbGen:I
 sget v1, Lcom/mrkeyboard/app/MrShots;->sThumbGen:I
 if-ne v0, v1, :done
 sget-object v0, Lcom/mrkeyboard/app/MrShots;->sCache:Landroid/util/LruCache;
 if-eqz v0, :done
 iget-wide v1, p0, Lcom/mrkeyboard/app/MrShots;->mId:J
 invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;
 move-result-object v1
 invoke-virtual {v0, v1, p1}, Landroid/util/LruCache;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
 :done
 goto :sync_return_0
 :sync_try_end
 .catchall {:sync_try_start .. :sync_try_end} :sync_catchall
 :sync_return_0
 monitor-exit v4
 return-void
 :sync_catchall
 move-exception v5
 monitor-exit v4
 throw v5
.end method

.method private static stopPool(Ljava/util/concurrent/ExecutorService;)V
 .locals 0
 if-eqz p0, :done
 invoke-interface {p0}, Ljava/util/concurrent/ExecutorService;->shutdownNow()Ljava/util/List;
 :done
 return-void
.end method

.method public static declared-synchronized clearCaches()V
 .locals 10
 const-class v8, Lcom/mrkeyboard/app/MrShots;
 monitor-enter v8
 :sync_try_start
 invoke-static {}, Lcom/mrkeyboard/app/MrCacheClear;->begin()Z
 move-result v0
 if-eqz v0, :done
 invoke-static {}, Lcom/mrkeyboard/app/MrShots;->clearSel()V
 new-instance v0, Lcom/mrkeyboard/app/MrCacheClear;
 invoke-direct {v0}, Lcom/mrkeyboard/app/MrCacheClear;-><init>()V
 sget-object v1, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;
 iput-object v1, v0, Lcom/mrkeyboard/app/MrCacheClear;->app:Landroid/content/Context;
 sget v1, Lcom/mrkeyboard/app/MrShots;->sSession:I
 add-int/lit8 v1, v1, 0x1
 sput v1, Lcom/mrkeyboard/app/MrShots;->sSession:I
 sget-object v2, Lcom/mrkeyboard/app/MrShots;->sAdp:Lcom/mrkeyboard/app/MrShots;
 if-eqz v2, :no_adapter
 iput v1, v2, Lcom/mrkeyboard/app/MrShots;->mSession:I
 :no_adapter
 sget v1, Lcom/mrkeyboard/app/MrShots;->sGen:I
 add-int/lit8 v1, v1, 0x1
 sput v1, Lcom/mrkeyboard/app/MrShots;->sGen:I
 sget v1, Lcom/mrkeyboard/app/MrShots;->sThumbGen:I
 add-int/lit8 v1, v1, 0x1
 sput v1, Lcom/mrkeyboard/app/MrShots;->sThumbGen:I
 # Capture pools for background quiescence; cancel without replacing them.
 const/4 v3, 0x3
 new-array v3, v3, [Ljava/util/concurrent/ExecutorService;
 sget-object v1, Lcom/mrkeyboard/app/MrShots;->sExec:Ljava/util/concurrent/ExecutorService;
 const/4 v4, 0x0
 aput-object v1, v3, v4
 invoke-static {v1}, Lcom/mrkeyboard/app/MrCacheJobs;->cancel(Ljava/util/concurrent/ExecutorService;)V
 sget-object v1, Lcom/mrkeyboard/app/MrShots;->sQueryExec:Ljava/util/concurrent/ExecutorService;
 const/4 v4, 0x1
 aput-object v1, v3, v4
 invoke-static {v1}, Lcom/mrkeyboard/app/MrCacheJobs;->cancel(Ljava/util/concurrent/ExecutorService;)V
 sget-object v1, Lcom/mrkeyboard/app/MrShots;->sThumbExec:Ljava/util/concurrent/ExecutorService;
 const/4 v4, 0x2
 aput-object v1, v3, v4
 invoke-static {v1}, Lcom/mrkeyboard/app/MrCacheJobs;->cancel(Ljava/util/concurrent/ExecutorService;)V
 iput-object v3, v0, Lcom/mrkeyboard/app/MrCacheClear;->oldPools:[Ljava/util/concurrent/ExecutorService;
 const/4 v1, 0x0
 sput-object v1, Lcom/mrkeyboard/app/MrShots;->sClearSummary:Ljava/lang/String;
 # Read counts before eviction; size() is bytes for MrThumbnailCache.
 sget-object v1, Lcom/mrkeyboard/app/MrShots;->sCache:Landroid/util/LruCache;
 if-eqz v1, :no_thumbs
 invoke-virtual {v1}, Landroid/util/LruCache;->size()I
 move-result v3
 int-to-long v3, v3
 iput-wide v3, v0, Lcom/mrkeyboard/app/MrCacheClear;->thumbBytes:J
 invoke-virtual {v1}, Landroid/util/LruCache;->snapshot()Ljava/util/Map;
 move-result-object v3
 invoke-interface {v3}, Ljava/util/Map;->size()I
 move-result v3
 iput v3, v0, Lcom/mrkeyboard/app/MrCacheClear;->thumbs:I
 invoke-virtual {v1}, Landroid/util/LruCache;->evictAll()V
 :no_thumbs
 sget-object v1, Lcom/mrkeyboard/app/MrShots;->sLists:[Lcom/mrkeyboard/app/MrShots;
 const/4 v3, 0x0
 const/4 v4, 0x0
 if-eqz v1, :counted_lists
 :list_loop
 array-length v5, v1
 if-ge v3, v5, :counted_lists
 aget-object v5, v1, v3
 if-eqz v5, :next_list
 add-int/lit8 v4, v4, 0x1
 :next_list
 add-int/lit8 v3, v3, 0x1
 goto :list_loop
 :counted_lists
 iput v4, v0, Lcom/mrkeyboard/app/MrCacheClear;->lists:I
 const/4 v1, 0x0
 sput-object v1, Lcom/mrkeyboard/app/MrShots;->sLists:[Lcom/mrkeyboard/app/MrShots;
 sput-boolean v1, Lcom/mrkeyboard/app/MrShots;->sQueryPending:Z
 sput-boolean v1, Lcom/mrkeyboard/app/MrShots;->sMore:Z
 const/4 v3, 0x1
 sput-boolean v3, Lcom/mrkeyboard/app/MrShots;->sBusy:Z
 if-eqz v2, :empty_adapter
 iput v1, v2, Lcom/mrkeyboard/app/MrShots;->mN:I
 iput-object v1, v2, Lcom/mrkeyboard/app/MrShots;->mIds:[J
 iput-object v1, v2, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;
 iput-object v1, v2, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;
 invoke-virtual {v2}, Landroid/widget/BaseAdapter;->notifyDataSetChanged()V
 sget-object v3, Lcom/mrkeyboard/app/MrShots;->sGrid:Landroid/widget/GridView;
 if-eqz v3, :empty_adapter
 # Setting the adapter again discards the grid's recycled thumbnail Views too.
 invoke-virtual {v3, v2}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V
 :empty_adapter
 const-string v2, ""
 invoke-static {v2}, Lcom/mrkeyboard/app/MrShots;->showText(Ljava/lang/String;)V
 new-instance v2, Lcom/mrkeyboard/app/MrClearWait;
 invoke-direct {v2}, Lcom/mrkeyboard/app/MrClearWait;-><init>()V
 sget-object v3, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;
 const-wide/16 v4, 0x15e
 invoke-virtual {v3, v2, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
 :empty_label
 # Keep the emptied LRU and existing pools; cleanup has its own app-scoped executor.
 invoke-static {v0}, Lcom/mrkeyboard/app/MrCacheJobs;->execute(Ljava/lang/Runnable;)Z
 move-result v1
 if-nez v1, :done
 invoke-virtual {v0}, Lcom/mrkeyboard/app/MrCacheClear;->rejected()V
 :done
 goto :sync_return_0
 :sync_try_end
 .catchall {:sync_try_start .. :sync_try_end} :sync_catchall
 :sync_return_0
 monitor-exit v8
 return-void
 :sync_catchall
 move-exception v9
 monitor-exit v8
 throw v9
.end method

.method static finishCacheClear(Z)V
 .locals 2
 const/4 v0, 0x0
 sput-boolean v0, Lcom/mrkeyboard/app/MrShots;->sBusy:Z
 sget-object v0, Lcom/mrkeyboard/app/MrShots;->sEmpty:Landroid/widget/TextView;
 if-eqz v0, :done
 if-eqz p0, :partial
 const-string v1, "Cache limpo. Toque numa categoria ou em Atualizar."

 invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->a(Ljava/lang/String;)Ljava/lang/String;

 move-result-object v1
 goto :label
 :partial
 const-string v1, "Limpeza parcial. Toque em Cache para tentar novamente."

 invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->a(Ljava/lang/String;)Ljava/lang/String;

 move-result-object v1
 :label
 invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
 :done
 return-void
.end method

.method static showClearSummary(Ljava/lang/String;)V
 .locals 0
 sput-object p0, Lcom/mrkeyboard/app/MrShots;->sClearSummary:Ljava/lang/String;
 invoke-static {p0}, Lcom/mrkeyboard/app/MrShots;->showText(Ljava/lang/String;)V
 return-void
.end method

.method static showWait()V
 .locals 1
 const-string v0, "Limpando caches…"

 invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->a(Ljava/lang/String;)Ljava/lang/String;

 move-result-object v0
 invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->showText(Ljava/lang/String;)V
 return-void
.end method

.method private static showText(Ljava/lang/String;)V
 .locals 2
 sget-object v0, Lcom/mrkeyboard/app/MrShots;->sEmpty:Landroid/widget/TextView;
 if-eqz v0, :done
 const/4 v1, 0x0
 invoke-virtual {v0, v1, v1, v1, v1}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V
 const/16 v1, 0x11
 invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V
 sget v1, Lcom/mrkeyboard/app/MrTools;->sPad:I
 invoke-virtual {v0, v1, v1, v1, v1}, Landroid/view/View;->setPadding(IIII)V
 invoke-static {}, Landroid/text/method/ScrollingMovementMethod;->getInstance()Landroid/text/method/MovementMethod;
 move-result-object v1
 invoke-virtual {v0, v1}, Landroid/widget/TextView;->setMovementMethod(Landroid/text/method/MovementMethod;)V
 const/4 v1, 0x1
 invoke-virtual {v0, v1}, Landroid/view/View;->setVerticalScrollBarEnabled(Z)V
 const/4 v1, 0x0
 invoke-virtual {v0, v1, v1}, Landroid/view/View;->scrollTo(II)V
 invoke-virtual {v0, p0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
 :done
 return-void
.end method

.method static sendSel()V
 .locals 14
 invoke-static {}, Lcom/mrkeyboard/app/MrCacheClear;->isBusy()Z
 move-result v0
 if-nez v0, :end
 sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sBusy:Z
 if-nez v0, :end
 sget-boolean v0, Lcom/mrkeyboard/app/MrShots;->sSelOn:Z
 if-eqz v0, :end
 sget-object v0, Lcom/mrkeyboard/app/MrShots;->sAdp:Lcom/mrkeyboard/app/MrShots;
 if-eqz v0, :end
 iget-object v1, v0, Lcom/mrkeyboard/app/MrShots;->mIds:[J
 if-eqz v1, :end
 invoke-static {}, Lcom/mrkeyboard/app/MrShots;->selCount()I
 move-result v2
 if-lez v2, :end
 iget v3, v0, Lcom/mrkeyboard/app/MrShots;->mN:I
 const/4 v4, 0x0
 const/4 v5, 0x1
 if-ne v2, v5, :multi
 :find
 if-ge v4, v3, :end
 aget-wide v12, v1, v4
 invoke-static {v12, v13}, Lcom/mrkeyboard/app/MrShots;->isSel(J)Z
 move-result v8
 if-nez v8, :found
 add-int/lit8 v4, v4, 0x1
 goto :find
 :found
 invoke-direct {v0, v4}, Lcom/mrkeyboard/app/MrShots;->sendAt(I)V
 return-void
 :multi
 new-instance v6, Lcom/mrkeyboard/app/MrShots;
 const/16 v7, 0xc
 invoke-direct {v6, v7}, Lcom/mrkeyboard/app/MrShots;-><init>(I)V
 new-array v7, v2, [J
 const/4 v9, 0x0
 const/4 v10, 0x0
 sget-boolean v8, Lcom/mrkeyboard/app/MrShots;->sFiles:Z
 if-eqz v8, :arrays_ready
 new-array v9, v2, [Ljava/lang/String;
 new-array v10, v2, [Ljava/lang/String;
 :arrays_ready
 const/4 v11, 0x0
 :scan
 if-ge v4, v3, :scan_end
 if-ge v11, v2, :scan_end
 aget-wide v12, v1, v4
 invoke-static {v12, v13}, Lcom/mrkeyboard/app/MrShots;->isSel(J)Z
 move-result v8
 if-eqz v8, :scan_next
 aput-wide v12, v7, v11
 sget-boolean v8, Lcom/mrkeyboard/app/MrShots;->sFiles:Z
 if-eqz v8, :no_names
 iget-object v8, v0, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;
 aget-object v8, v8, v4
 aput-object v8, v9, v11
 iget-object v8, v0, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;
 aget-object v8, v8, v4
 aput-object v8, v10, v11
 :no_names
 add-int/lit8 v11, v11, 0x1
 :scan_next
 add-int/lit8 v4, v4, 0x1
 goto :scan
 :scan_end
 if-eqz v11, :end
 if-eq v11, v2, :build
 invoke-static {v7, v11}, Ljava/util/Arrays;->copyOf([JI)[J
 move-result-object v7
 if-eqz v9, :build
 invoke-static {v9, v11}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;
 move-result-object v9
 check-cast v9, [Ljava/lang/String;
 invoke-static {v10, v11}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;
 move-result-object v10
 check-cast v10, [Ljava/lang/String;
 :build
 iput-object v7, v6, Lcom/mrkeyboard/app/MrShots;->mIds:[J
 iput-object v9, v6, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;
 iput-object v10, v6, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;
 const/4 v0, 0x1
 sput-boolean v0, Lcom/mrkeyboard/app/MrShots;->sBusy:Z
 invoke-direct {v6}, Lcom/mrkeyboard/app/MrShots;->captureTarget()V
 invoke-static {v6}, Lcom/mrkeyboard/app/MrShots;->submit(Lcom/mrkeyboard/app/MrShots;)V
 :end
 return-void
.end method

.method private static readable(Landroid/net/Uri;)Z
 .locals 3
 if-eqz p0, :no
 :try_s
 sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;
 invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
 move-result-object v0
 const-string v1, "r"
 invoke-virtual {v0, p0, v1}, Landroid/content/ContentResolver;->openAssetFileDescriptor(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;
 move-result-object v1
 if-eqz v1, :no
 invoke-virtual {v1}, Landroid/content/res/AssetFileDescriptor;->close()V
 :try_e
 .catch Ljava/lang/Exception; {:try_s .. :try_e} :catch_0
 const/4 v0, 0x1
 return v0
 :catch_0
 move-exception v0
 :no
 const/4 v0, 0x0
 return v0
.end method

.method private static typeOf(Landroid/net/Uri;)Ljava/lang/String;
 .locals 2
 const/4 v0, 0x0
 if-eqz p0, :end
 :try_s
 sget-object v1, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;
 invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
 move-result-object v1
 invoke-virtual {v1, p0}, Landroid/content/ContentResolver;->getType(Landroid/net/Uri;)Ljava/lang/String;
 move-result-object v0
 :try_e
 .catch Ljava/lang/Exception; {:try_s .. :try_e} :catch_0
 :end
 return-object v0
 :catch_0
 move-exception v1
 const/4 v0, 0x0
 return-object v0
.end method

.method private prepBatch()V
 .locals 11
 invoke-static {}, Lcom/mrkeyboard/app/MrCopyRetention;->sweep()V
 iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mBS:Ljava/util/ArrayList;
 if-eqz v0, :grid_n
 invoke-virtual {v0}, Ljava/util/ArrayList;->size()I
 move-result v1
 goto :have_n
 :grid_n
 iget-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mIds:[J
 array-length v1, v1
 :have_n
 new-instance v2, Ljava/util/ArrayList;
 invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V
 iget-object v3, p0, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;
 if-nez v3, :mimes_ok
 new-array v3, v1, [Ljava/lang/String;
 iput-object v3, p0, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;
 :mimes_ok
 if-eqz v0, :names_ok
 iget-object v4, p0, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;
 if-nez v4, :names_ok
 new-array v4, v1, [Ljava/lang/String;
 iput-object v4, p0, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;
 :names_ok
 const/4 v4, 0x0
 :loop
 if-ge v4, v1, :done
 if-eqz v0, :grid_uri
 invoke-virtual {v0, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
 move-result-object v5
 check-cast v5, Landroid/net/Uri;
 goto :uri_ready
 :grid_uri
 iget-object v6, p0, Lcom/mrkeyboard/app/MrShots;->mIds:[J
 aget-wide v7, v6, v4
 iget v6, p0, Lcom/mrkeyboard/app/MrShots;->mCategory:I
 const/4 v9, 0x2
 if-ne v6, v9, :grid_media
 const-string v6, "external"
 invoke-static {v6}, Landroid/provider/MediaStore$Files;->getContentUri(Ljava/lang/String;)Landroid/net/Uri;
 move-result-object v6
 invoke-static {v6, v7, v8}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;
 move-result-object v5
 goto :uri_ready
 :grid_media
 invoke-static {v7, v8}, Lcom/mrkeyboard/app/MrShots;->uriFor(J)Landroid/net/Uri;
 move-result-object v5
 :uri_ready
 aget-object v6, v3, v4
 if-nez v6, :mime_ok
 invoke-static {v5}, Lcom/mrkeyboard/app/MrShots;->typeOf(Landroid/net/Uri;)Ljava/lang/String;
 move-result-object v6
 if-nez v6, :mime_store
 const-string v6, "application/octet-stream"
 if-nez v0, :mime_store
 iget v9, p0, Lcom/mrkeyboard/app/MrShots;->mCategory:I
 const/4 v10, 0x2
 if-eq v9, v10, :mime_store
 const-string v6, "video/mp4"
 iget-object v9, p0, Lcom/mrkeyboard/app/MrShots;->mIds:[J
 aget-wide v7, v9, v4
 const-wide/16 v9, 0x0
 cmp-long v9, v7, v9
 if-ltz v9, :mime_store
 const-string v6, "image/png"
 :mime_store
 aput-object v6, v3, v4
 :mime_ok
 if-eqz v0, :names_next
 iget-object v6, p0, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;
 aget-object v7, v6, v4
 if-nez v7, :names_next
 invoke-static {v5}, Lcom/mrkeyboard/app/MrShots;->uriName(Landroid/net/Uri;)Ljava/lang/String;
 move-result-object v7
 aput-object v7, v6, v4
 :names_next
 invoke-static {v5}, Lcom/mrkeyboard/app/MrShots;->readable(Landroid/net/Uri;)Z
 move-result v6
 if-nez v6, :add
 const/4 v5, 0x0
 :add
 invoke-virtual {v2, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
 add-int/lit8 v4, v4, 0x1
 goto :loop
 :done
 iput-object v2, p0, Lcom/mrkeyboard/app/MrShots;->mBU:Ljava/util/ArrayList;
 if-eqz v0, :post_ui
 const/16 v5, 0xa
 iput v5, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I
 const/4 v5, 0x0
 iput v5, p0, Lcom/mrkeyboard/app/MrShots;->mN:I
 goto :post
 :post_ui
 const/16 v5, 0xd
 iput v5, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I
 :post
 sget-object v5, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;
 invoke-virtual {v5, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
 return-void
.end method

.method private runBatch()V
 .locals 9
 iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mBU:Ljava/util/ArrayList;
 invoke-virtual {v0}, Ljava/util/ArrayList;->size()I
 move-result v1
 new-instance v2, Ljava/util/ArrayList;
 invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V
 const/4 v3, 0x0
 :loop
 if-ge v3, v1, :after
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->targetIsCurrent()Z
 move-result v4
 if-nez v4, :cur
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->abortBatch()V
 return-void
 :cur
 invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
 move-result-object v5
 check-cast v5, Landroid/net/Uri;
 if-eqz v5, :refuse
 sget-object v6, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;
 iget-object v7, p0, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;
 aget-object v7, v7, v3
 invoke-static {v6, v5, v7}, Lcom/mrkeyboard/app/MrDirectSend;->commit(Lcom/mrkeyboard/app/LatinIME;Landroid/net/Uri;Ljava/lang/String;)Z
 move-result v4
 if-eqz v4, :refuse
 iget v4, p0, Lcom/mrkeyboard/app/MrShots;->mBok:I
 add-int/lit8 v4, v4, 0x1
 iput v4, p0, Lcom/mrkeyboard/app/MrShots;->mBok:I
 goto :next
 :refuse
 invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
 move-result-object v4
 invoke-virtual {v2, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
 :next
 add-int/lit8 v3, v3, 0x1
 goto :loop
 :after
 invoke-virtual {v2}, Ljava/util/ArrayList;->isEmpty()Z
 move-result v4
 if-eqz v4, :pending
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->endBatch()V
 return-void
 :pending
 invoke-direct {p0, v2}, Lcom/mrkeyboard/app/MrShots;->shareStep(Ljava/util/ArrayList;)Ljava/util/ArrayList;
 move-result-object v4
 invoke-virtual {v4}, Ljava/util/ArrayList;->isEmpty()Z
 move-result v5
 if-eqz v5, :copy
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->endBatch()V
 return-void
 :copy
 iput-object v4, p0, Lcom/mrkeyboard/app/MrShots;->mBR:Ljava/util/ArrayList;
 const/16 v5, 0xe
 iput v5, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I
 invoke-static {p0}, Lcom/mrkeyboard/app/MrShots;->submit(Lcom/mrkeyboard/app/MrShots;)V
 return-void
.end method

.method private shareStep(Ljava/util/ArrayList;)Ljava/util/ArrayList;
 .locals 10
 iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mBU:Ljava/util/ArrayList;
 new-instance v1, Ljava/util/ArrayList;
 invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V
 new-instance v2, Ljava/util/ArrayList;
 invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V
 new-instance v3, Ljava/util/ArrayList;
 invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V
 invoke-virtual {p1}, Ljava/util/ArrayList;->size()I
 move-result v4
 const/4 v5, 0x0
 :split
 if-ge v5, v4, :split_done
 invoke-virtual {p1, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
 move-result-object v6
 check-cast v6, Ljava/lang/Integer;
 invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I
 move-result v7
 invoke-virtual {v0, v7}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
 move-result-object v8
 check-cast v8, Landroid/net/Uri;
 if-nez v8, :shareable
 invoke-virtual {v3, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
 goto :split_next
 :shareable
 invoke-virtual {v1, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
 iget-object v9, p0, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;
 aget-object v9, v9, v7
 invoke-virtual {v2, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
 :split_next
 add-int/lit8 v5, v5, 0x1
 goto :split
 :split_done
 invoke-virtual {v1}, Ljava/util/ArrayList;->size()I
 move-result v4
 if-eqz v4, :only_u
 sget-object v5, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;
 const/4 v6, 0x1
 if-ne v4, v6, :many
 const/4 v6, 0x0
 invoke-virtual {v1, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
 move-result-object v7
 check-cast v7, Landroid/net/Uri;
 invoke-virtual {v2, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
 move-result-object v8
 check-cast v8, Ljava/lang/String;
 invoke-static {v5, v7, v8}, Lcom/mrkeyboard/app/MrDirectSend;->share(Lcom/mrkeyboard/app/LatinIME;Landroid/net/Uri;Ljava/lang/String;)Z
 move-result v6
 goto :shared
 :many
 invoke-static {v5, v1, v2}, Lcom/mrkeyboard/app/MrDirectSend;->shareMany(Lcom/mrkeyboard/app/LatinIME;Ljava/util/ArrayList;Ljava/util/ArrayList;)Z
 move-result v6
 :shared
 if-eqz v6, :all
 iget v6, p0, Lcom/mrkeyboard/app/MrShots;->mBok:I
 add-int/2addr v6, v4
 iput v6, p0, Lcom/mrkeyboard/app/MrShots;->mBok:I
 return-object v3
 :all
 return-object p1
 :only_u
 return-object v3
.end method

.method private copyItem(I)Ljava/io/File;
 .locals 6
 iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mBS:Ljava/util/ArrayList;
 iget v1, p0, Lcom/mrkeyboard/app/MrShots;->mSession:I
 if-eqz v0, :grid
 invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
 move-result-object v2
 check-cast v2, Landroid/net/Uri;
 iget-object v3, p0, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;
 aget-object v3, v3, p1
 invoke-static {v2, v3, v1}, Lcom/mrkeyboard/app/MrShots;->copyUri(Landroid/net/Uri;Ljava/lang/String;I)Ljava/io/File;
 move-result-object v2
 return-object v2
 :grid
 iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mIds:[J
 aget-wide v2, v0, p1
 iget v4, p0, Lcom/mrkeyboard/app/MrShots;->mCategory:I
 const/4 v5, 0x2
 if-ne v4, v5, :media
 iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mNames:[Ljava/lang/String;
 aget-object v0, v0, p1
 if-nez v0, :named
 const-string v0, "anexo"
 :named
 invoke-static {v2, v3, v0, v1}, Lcom/mrkeyboard/app/MrShots;->copyFile(JLjava/lang/String;I)Ljava/io/File;
 move-result-object v0
 return-object v0
 :media
 iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;
 aget-object v0, v0, p1
 invoke-static {v2, v3, v0, v1}, Lcom/mrkeyboard/app/MrShots;->copyToCache(JLjava/lang/String;I)Ljava/io/File;
 move-result-object v0
 return-object v0
.end method

.method private copyBatch()V
 .locals 7
 new-instance v0, Ljava/util/ArrayList;
 invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V
 iget-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mBR:Ljava/util/ArrayList;
 invoke-virtual {v1}, Ljava/util/ArrayList;->size()I
 move-result v2
 const/4 v3, 0x0
 :loop
 if-ge v3, v2, :done
 invoke-virtual {v1, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
 move-result-object v4
 check-cast v4, Ljava/lang/Integer;
 invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I
 move-result v4
 const/4 v5, 0x0
 :try_s
 invoke-direct {p0, v4}, Lcom/mrkeyboard/app/MrShots;->copyItem(I)Ljava/io/File;
 move-result-object v5
 :try_e
 .catch Ljava/lang/Exception; {:try_s .. :try_e} :catch_item
 :add
 invoke-virtual {v0, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
 add-int/lit8 v3, v3, 0x1
 goto :loop
 :catch_item
 move-exception v6
 const/4 v5, 0x0
 goto :add
 :done
 iput-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mBF:Ljava/util/ArrayList;
 const/16 v0, 0xf
 iput v0, p0, Lcom/mrkeyboard/app/MrShots;->mMode:I
 sget-object v0, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;
 invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
 return-void
.end method

.method private finishBatch()V
 .locals 9
 sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;
 iget-object v1, p0, Lcom/mrkeyboard/app/MrShots;->mBR:Ljava/util/ArrayList;
 iget-object v2, p0, Lcom/mrkeyboard/app/MrShots;->mBF:Ljava/util/ArrayList;
 invoke-virtual {v1}, Ljava/util/ArrayList;->size()I
 move-result v3
 const/4 v4, 0x0
 :loop
 if-ge v4, v3, :done
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->targetIsCurrent()Z
 move-result v5
 if-nez v5, :cur
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->abortBatch()V
 return-void
 :cur
 invoke-virtual {v2, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
 move-result-object v5
 check-cast v5, Ljava/io/File;
 if-eqz v5, :next
 :try_s
 const-string v6, "com.mrkeyboard.app.shots"
 invoke-static {v0, v6, v5}, Landroid/support/v4/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;
 move-result-object v6
 invoke-virtual {v1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
 move-result-object v7
 check-cast v7, Ljava/lang/Integer;
 invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I
 move-result v7
 iget-object v8, p0, Lcom/mrkeyboard/app/MrShots;->mMimes:[Ljava/lang/String;
 aget-object v8, v8, v7
 invoke-static {v0, v6, v8}, Lcom/mrkeyboard/app/MrDirectSend;->commit(Lcom/mrkeyboard/app/LatinIME;Landroid/net/Uri;Ljava/lang/String;)Z
 move-result v6
 :try_e
 .catch Ljava/lang/Exception; {:try_s .. :try_e} :catch_item
 if-eqz v6, :next
 iget v6, p0, Lcom/mrkeyboard/app/MrShots;->mBok:I
 add-int/lit8 v6, v6, 0x1
 iput v6, p0, Lcom/mrkeyboard/app/MrShots;->mBok:I
 invoke-static {v5}, Lcom/mrkeyboard/app/MrCopyRetention;->touch(Ljava/io/File;)V
 :next
 add-int/lit8 v4, v4, 0x1
 goto :loop
 :catch_item
 move-exception v6
 goto :next
 :done
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->endBatch()V
 return-void
.end method

.method private dropBatch()V
 .locals 1
 iget v0, p0, Lcom/mrkeyboard/app/MrShots;->mBok:I
 if-lez v0, :now
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->lateDrop()V
 return-void
 :now
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->dropSrc()V
 return-void
.end method

.method private abortBatch()V
 .locals 0
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->cancelDelivery()V
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->dropBatch()V
 return-void
.end method

.method private endBatch()V
 .locals 4
 const/4 v0, 0x0
 sput-boolean v0, Lcom/mrkeyboard/app/MrShots;->sBusy:Z
 invoke-direct {p0}, Lcom/mrkeyboard/app/MrShots;->dropBatch()V
 iget-object v0, p0, Lcom/mrkeyboard/app/MrShots;->mBU:Ljava/util/ArrayList;
 invoke-virtual {v0}, Ljava/util/ArrayList;->size()I
 move-result v0
 iget v1, p0, Lcom/mrkeyboard/app/MrShots;->mBok:I
 sub-int v2, v0, v1
 if-nez v1, :some_ok
 invoke-static {v2}, Lcom/mrkeyboard/app/MrShots;->toastFail(I)V
 return-void
 :some_ok
 invoke-static {}, Lcom/mrkeyboard/app/MrShots;->clearSel()V
 const/4 v3, 0x0
 invoke-static {v3}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V
 if-lez v2, :done
 invoke-static {v2}, Lcom/mrkeyboard/app/MrShots;->toastFail(I)V
 :done
 return-void
.end method

.method private static toastFail(I)V
 .locals 4
 const v0, 0x7f0c01d5
 invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;
 move-result-object v0
 const/4 v1, 0x1
 new-array v1, v1, [Ljava/lang/Object;
 invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
 move-result-object v2
 const/4 v3, 0x0
 aput-object v2, v1, v3
 invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
 move-result-object v0
 invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V
 return-void
.end method
