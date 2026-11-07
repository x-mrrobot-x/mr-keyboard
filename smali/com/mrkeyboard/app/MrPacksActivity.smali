.class public Lcom/mrkeyboard/app/MrPacksActivity;
.super Landroid/preference/PreferenceActivity;
.source "MrPacksActivity.java"


# instance fields
.field private mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

.field private mCheck:Landroid/preference/Preference;

.field private mCheckError:Ljava/lang/String;

.field private mChecking:Z

.field private mError:Ljava/lang/String;

.field private mErrorId:Ljava/lang/String;

.field private final mHandler:Landroid/os/Handler;

.field private mLangs:Landroid/preference/PreferenceCategory;

.field private mMem:Landroid/preference/Preference;

.field private mOpenId:Ljava/lang/String;

.field private final mPackPrefs:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Landroid/preference/Preference;",
            ">;"
        }
    .end annotation
.end field

.field private final mPoll:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 40
    invoke-direct {p0}, Landroid/preference/PreferenceActivity;-><init>()V

    .line 41
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    .line 42
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    .line 55
    new-instance v0, Lcom/mrkeyboard/app/MrPacksActivity$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrPacksActivity$1;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrPacksActivity;)Z
    .locals 1

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->gone()Z

    move-result v0

    return v0
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->update()V

    return-void
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/MrPacksActivity;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 40
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mOpenId:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1002(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 40
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mOpenId:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->rebuild()V

    return-void
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->toast(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->showPack(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Pack;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->download(Lcom/mrkeyboard/app/MrPacks$Pack;)V

    return-void
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/MrPacksActivity;->confirmRemove(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1602(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 40
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mError:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1702(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 40
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mErrorId:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrPacksActivity;)Landroid/os/Handler;
    .locals 1

    .prologue
    .line 40
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->open(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->check()V

    return-void
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrDiag$Report;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 40
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->memText(Lcom/mrkeyboard/app/MrDiag$Report;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/MrPacksActivity;)Landroid/preference/Preference;
    .locals 1

    .prologue
    .line 40
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    return-object v0
.end method

.method static synthetic access$702(Lcom/mrkeyboard/app/MrPacksActivity;Z)Z
    .locals 0

    .prologue
    .line 40
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    return p1
.end method

.method static synthetic access$802(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 40
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$902(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Catalog;)Lcom/mrkeyboard/app/MrPacks$Catalog;
    .locals 0

    .prologue
    .line 40
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    return-object p1
.end method

.method private check()V
    .locals 3

    .prologue
    .line 307
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    if-eqz v0, :cond_0

    .line 341
    :goto_0
    return-void

    .line 308
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    .line 309
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    .line 310
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->update()V

    .line 311
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 312
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$5;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity$5;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Landroid/content/Context;)V

    const-string v0, "MrPacksCheck"

    invoke-direct {v1, v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 340
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private checkState()Ljava/lang/CharSequence;
    .locals 7

    .prologue
    const/4 v6, 0x3

    const/4 v4, 0x1

    const/4 v5, 0x0

    .line 269
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    if-eqz v0, :cond_1

    const-string v0, "mr_dicts_checking"

    new-array v1, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 284
    :cond_0
    :goto_0
    return-object v0

    .line 270
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    const-string v1, "mr_ui_rose"

    invoke-direct {p0, v0, v1, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_0

    .line 271
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->checkedAt(Landroid/content/Context;)J

    move-result-wide v0

    .line 272
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_3

    const-string v0, "mr_dicts_check_never"

    new-array v1, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 273
    :cond_3
    invoke-static {v6, v6}, Ljava/text/DateFormat;->getDateTimeInstance(II)Ljava/text/DateFormat;

    move-result-object v2

    new-instance v3, Ljava/util/Date;

    invoke-direct {v3, v0, v1}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v2, v3}, Ljava/text/DateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    .line 274
    const-string v1, "mr_dicts_check_last"

    new-array v2, v4, [Ljava/lang/Object;

    aput-object v0, v2, v5

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 275
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v1, :cond_4

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->packs:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_4

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " \u00b7 "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "mr_dicts_empty"

    new-array v2, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 276
    :cond_4
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrPacks;->updatesAvailable(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Catalog;)I

    move-result v2

    .line 277
    if-eqz v2, :cond_0

    .line 278
    new-instance v1, Landroid/text/SpannableStringBuilder;

    invoke-direct {v1, v0}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    .line 279
    const-string v0, " \u00b7 "

    invoke-virtual {v1, v0}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    .line 280
    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v3

    .line 281
    if-ne v2, v4, :cond_6

    const-string v0, "mr_dicts_updates_one"

    :goto_1
    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v4, v5

    invoke-virtual {p0, v0, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    .line 282
    const-string v0, "mr_ui_blue"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->color(Ljava/lang/String;)I

    move-result v0

    .line 283
    if-eqz v0, :cond_5

    new-instance v2, Landroid/text/style/ForegroundColorSpan;

    invoke-direct {v2, v0}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v0

    const/16 v4, 0x21

    invoke-virtual {v1, v2, v3, v0, v4}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    :cond_5
    move-object v0, v1

    .line 284
    goto/16 :goto_0

    .line 281
    :cond_6
    const-string v0, "mr_dicts_updates_many"

    goto :goto_1
.end method

.method private color(Ljava/lang/String;)I
    .locals 3

    .prologue
    .line 223
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "color"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 224
    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getColor(I)I

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private confirmRemove(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 433
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 434
    invoke-virtual {v0, p2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 435
    const-string v1, "mr_dicts_remove_confirm"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    aput-object p2, v2, v3

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 436
    const-string v1, "mr_dicts_remove"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$10;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity$10;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 445
    const-string v1, "mr_dicts_close"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 446
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 447
    return-void
.end method

.method private dirSize(Ljava/lang/String;I)J
    .locals 7

    .prologue
    .line 288
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrPacks;->packDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v3

    .line 289
    const-wide/16 v0, 0x0

    .line 290
    if-eqz v3, :cond_0

    array-length v6, v3

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v6, :cond_0

    aget-object v4, v3, v2

    invoke-virtual {v4}, Ljava/io/File;->length()J

    move-result-wide v4

    add-long/2addr v4, v0

    add-int/lit8 v0, v2, 0x1

    move v2, v0

    move-wide v0, v4

    goto :goto_0

    .line 291
    :cond_0
    return-wide v0
.end method

.method private download(Lcom/mrkeyboard/app/MrPacks$Pack;)V
    .locals 4

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 390
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-nez v0, :cond_1

    .line 430
    :cond_0
    :goto_0
    return-void

    .line 391
    :cond_1
    iput-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mError:Ljava/lang/String;

    .line 392
    iput-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mErrorId:Ljava/lang/String;

    .line 393
    sput v1, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    .line 394
    sput-boolean v1, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 395
    iget-object v0, p1, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 396
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    .line 397
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    .line 398
    new-instance v2, Ljava/lang/Thread;

    new-instance v3, Lcom/mrkeyboard/app/MrPacksActivity$9;

    invoke-direct {v3, p0, v1, v0, p1}, Lcom/mrkeyboard/app/MrPacksActivity$9;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Catalog;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    const-string v0, "MrPacksInstall"

    invoke-direct {v2, v3, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 427
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    .line 428
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 429
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0
.end method

.method private gone()Z
    .locals 1

    .prologue
    .line 452
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static headEnd(Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 229
    const-string v0, " \u00b7 "

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    const/16 v0, 0x3a

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 230
    if-gez v1, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    .line 231
    :cond_0
    if-gez v0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 232
    :cond_1
    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    return v0
.end method

.method private hideQuickFixesIfUnsupported()V
    .locals 3

    .prologue
    .line 85
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getListView()Landroid/widget/ListView;

    move-result-object v0

    invoke-static {v0}, Landroid/text/AutoText;->getSize(Landroid/view/View;)I

    move-result v0

    const/4 v1, 0x1

    if-lt v0, v1, :cond_1

    .line 89
    :cond_0
    :goto_0
    return-void

    .line 86
    :cond_1
    const-string v0, "quick_fixes"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v1

    .line 87
    const-string v0, "mr_cat_suggestions"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 88
    if-eqz v1, :cond_0

    instance-of v2, v0, Landroid/preference/PreferenceGroup;

    if-eqz v2, :cond_0

    check-cast v0, Landroid/preference/PreferenceGroup;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceGroup;->removePreference(Landroid/preference/Preference;)Z

    goto :goto_0
.end method

.method private langName(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 111
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mr_lang_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x2d

    const/16 v2, 0x5f

    invoke-virtual {p1, v1, v2}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 112
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "string"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v0, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    :cond_0
    return-object p1
.end method

.method private memText(Lcom/mrkeyboard/app/MrDiag$Report;)Ljava/lang/String;
    .locals 11

    .prologue
    const/4 v10, 0x3

    const/16 v9, 0xa

    const/4 v8, 0x2

    const/4 v7, 0x1

    const/4 v6, 0x0

    .line 199
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 200
    const-string v1, "mr_mem_dict"

    const/4 v2, 0x5

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p1, Lcom/mrkeyboard/app/MrDiag$Report;->id:Ljava/lang/String;

    aput-object v3, v2, v6

    iget v3, p1, Lcom/mrkeyboard/app/MrDiag$Report;->version:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v7

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->dictBytes:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v8

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->dictMem:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v10

    const/4 v3, 0x4

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->dictNs:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 201
    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 202
    iget-boolean v1, p1, Lcom/mrkeyboard/app/MrDiag$Report;->hasTri:Z

    if-eqz v1, :cond_1

    .line 203
    const-string v1, "mr_mem_tri"

    const/4 v2, 0x4

    new-array v2, v2, [Ljava/lang/Object;

    iget v3, p1, Lcom/mrkeyboard/app/MrDiag$Report;->triFormat:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v6

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->triBytes:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v7

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->triMem:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->bytesText(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v8

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->triNs:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v10

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 207
    :goto_0
    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "mr_mem_engine"

    new-array v3, v8, [Ljava/lang/Object;

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->engineNs:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v6

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrDiag$Report;->rulesNs:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v7

    invoke-virtual {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 208
    iget-wide v2, p1, Lcom/mrkeyboard/app/MrDiag$Report;->dictMem:J

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-gez v1, :cond_0

    iget-wide v2, p1, Lcom/mrkeyboard/app/MrDiag$Report;->triMem:J

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-gez v1, :cond_0

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "mr_mem_nomem"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 209
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 205
    :cond_1
    const-string v1, "mr_mem_tri_none"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0
.end method

.method private open(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 298
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-nez v0, :cond_0

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    .line 299
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mOpenId:Ljava/lang/String;

    .line 300
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->check()V

    .line 304
    :goto_0
    return-void

    .line 302
    :cond_0
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->showPack(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;
    .locals 5

    .prologue
    const/4 v2, 0x0

    .line 237
    if-nez p2, :cond_1

    move v0, v2

    .line 238
    :goto_0
    if-eqz v0, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_2

    .line 241
    :cond_0
    :goto_1
    return-object p1

    .line 237
    :cond_1
    invoke-direct {p0, p2}, Lcom/mrkeyboard/app/MrPacksActivity;->color(Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 239
    :cond_2
    new-instance v1, Landroid/text/SpannableString;

    invoke-direct {v1, p1}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    .line 240
    new-instance v3, Landroid/text/style/ForegroundColorSpan;

    invoke-direct {v3, v0}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    if-eqz p3, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    :goto_2
    const/16 v4, 0x21

    invoke-virtual {v1, v3, v2, v0, v4}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    move-object p1, v1

    .line 241
    goto :goto_1

    .line 240
    :cond_3
    invoke-static {p1}, Lcom/mrkeyboard/app/MrPacksActivity;->headEnd(Ljava/lang/String;)I

    move-result v0

    goto :goto_2
.end method

.method private rebuild()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 117
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    if-nez v0, :cond_0

    .line 169
    :goto_0
    return-void

    .line 118
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    invoke-virtual {v0}, Landroid/preference/PreferenceCategory;->removeAll()V

    .line 119
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    .line 120
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 121
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacks$Catalog;->packs:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrPacks$Pack;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 122
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v2, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 123
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->installedIds(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v2}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/mrkeyboard/app/MrPacks;->cardIds(Ljava/util/List;Ljava/util/List;Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v3

    .line 124
    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_2
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 125
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrPacks$Catalog;->find(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v1

    .line 126
    :goto_3
    new-instance v5, Landroid/preference/Preference;

    invoke-direct {v5, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    .line 127
    invoke-virtual {v5, v6}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 128
    if-eqz v1, :cond_3

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrPacks$Pack;->name(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    :goto_4
    invoke-virtual {v5, v1}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 129
    new-instance v1, Lcom/mrkeyboard/app/MrPacksActivity$2;

    invoke-direct {v1, p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity$2;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    invoke-virtual {v5, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 135
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    invoke-virtual {v1, v5}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 136
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    invoke-virtual {v1, v0, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    .line 125
    :cond_2
    const/4 v1, 0x0

    goto :goto_3

    .line 128
    :cond_3
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->langName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_4

    .line 138
    :cond_4
    new-instance v0, Landroid/preference/Preference;

    invoke-direct {v0, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    .line 139
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    invoke-virtual {v0, v6}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 140
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    const-string v1, "mr_dicts_check"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    new-instance v1, Lcom/mrkeyboard/app/MrPacksActivity$3;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrPacksActivity$3;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 147
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 148
    new-instance v0, Landroid/preference/Preference;

    invoke-direct {v0, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    .line 149
    invoke-virtual {v0, v6}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 150
    invoke-virtual {v0, v6}, Landroid/preference/Preference;->setSelectable(Z)V

    .line 151
    const-string v1, "mr_dicts_langs_hint"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 152
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    invoke-virtual {v1, v0}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 154
    new-instance v1, Landroid/preference/Preference;

    invoke-direct {v1, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    .line 155
    invoke-virtual {v1, v6}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 156
    invoke-virtual {v1, v6}, Landroid/preference/Preference;->setSelectable(Z)V

    .line 157
    const-string v0, "mr_engine_title"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 158
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->ready()Z

    move-result v0

    if-eqz v0, :cond_5

    const-string v0, "mr_engine_native"

    :goto_5
    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 159
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 160
    new-instance v0, Landroid/preference/Preference;

    invoke-direct {v0, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    .line 161
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    invoke-virtual {v0, v6}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 162
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    invoke-virtual {v0, v6}, Landroid/preference/Preference;->setSelectable(Z)V

    .line 163
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    const-string v1, "mr_mem_title"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 164
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    const-string v1, "mr_mem_wait"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 165
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 166
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->refreshMem()V

    .line 167
    invoke-static {p0, v3}, Lcom/mrkeyboard/app/MrPacks;->syncLanguages(Landroid/content/Context;Ljava/util/List;)V

    .line 168
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->update()V

    goto/16 :goto_0

    .line 158
    :cond_5
    const-string v0, "mr_engine_missing"

    goto :goto_5
.end method

.method private refreshMem()V
    .locals 4

    .prologue
    .line 176
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    .line 177
    invoke-static {}, Lcom/mrkeyboard/app/MrPacks;->activeDir()Ljava/io/File;

    move-result-object v1

    .line 178
    if-nez v0, :cond_0

    .line 195
    :goto_0
    return-void

    .line 179
    :cond_0
    if-nez v1, :cond_1

    .line 180
    const-string v1, "mr_mem_none"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 183
    :cond_1
    new-instance v2, Ljava/lang/Thread;

    new-instance v3, Lcom/mrkeyboard/app/MrPacksActivity$4;

    invoke-direct {v3, p0, v1, v0}, Lcom/mrkeyboard/app/MrPacksActivity$4;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/io/File;Landroid/preference/Preference;)V

    const-string v0, "MrDiag"

    invoke-direct {v2, v3, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 193
    const/4 v0, 0x1

    invoke-virtual {v2, v0}, Ljava/lang/Thread;->setPriority(I)V

    .line 194
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private showPack(Ljava/lang/String;)V
    .locals 13

    .prologue
    const/4 v1, 0x0

    const/4 v12, 0x2

    const/4 v11, 0x1

    const/4 v10, 0x0

    .line 344
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/MrPacks$Catalog;->find(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v0

    .line 345
    :goto_0
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v4

    .line 346
    sget-object v2, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    .line 347
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v2

    iget-object v3, v2, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 348
    if-eqz v0, :cond_8

    invoke-virtual {v0, v3}, Lcom/mrkeyboard/app/MrPacks$Pack;->name(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    .line 349
    :goto_1
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    .line 350
    if-eqz v0, :cond_2

    .line 351
    invoke-virtual {v0, v3}, Lcom/mrkeyboard/app/MrPacks$Pack;->description(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    .line 352
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v7

    if-lez v7, :cond_0

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v7, "\n\n"

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 353
    :cond_0
    const-string v3, "mr_dicts_size_download"

    new-array v7, v12, [Ljava/lang/Object;

    iget-wide v8, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    invoke-static {v8, v9}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v8

    aput-object v8, v7, v10

    iget-wide v8, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->installedSize:J

    invoke-static {v8, v9}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v8

    aput-object v8, v7, v11

    invoke-virtual {p0, v3, v7}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 354
    iget-object v3, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->licenses:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_1

    const-string v3, "\n"

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v7, "mr_dicts_licenses"

    new-array v8, v11, [Ljava/lang/Object;

    iget-object v9, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->licenses:Ljava/lang/String;

    aput-object v9, v8, v10

    invoke-virtual {p0, v7, v8}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 355
    :cond_1
    iget-object v3, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->credits:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_2

    const-string v3, "\n\n"

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v7, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->credits:Ljava/lang/String;

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 357
    :cond_2
    if-lez v4, :cond_4

    .line 358
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    if-lez v3, :cond_3

    const-string v3, "\n\n"

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 359
    :cond_3
    const-string v3, "mr_dicts_state_installed"

    new-array v7, v12, [Ljava/lang/Object;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v7, v10

    invoke-direct {p0, p1, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->dirSize(Ljava/lang/String;I)J

    move-result-wide v8

    invoke-static {v8, v9}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v8

    aput-object v8, v7, v11

    invoke-virtual {p0, v3, v7}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 361
    :cond_4
    new-instance v7, Landroid/app/AlertDialog$Builder;

    invoke-direct {v7, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 362
    invoke-virtual {v7, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 363
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v7, v3}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 364
    if-eqz v5, :cond_9

    .line 365
    const-string v0, "mr_dicts_cancel"

    new-array v3, v10, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v3, Lcom/mrkeyboard/app/MrPacksActivity$6;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrPacksActivity$6;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v7, v0, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 378
    :cond_5
    :goto_2
    if-lez v4, :cond_6

    if-nez v5, :cond_6

    .line 379
    const-string v0, "mr_dicts_remove"

    new-array v3, v10, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v3, Lcom/mrkeyboard/app/MrPacksActivity$8;

    invoke-direct {v3, p0, p1, v2}, Lcom/mrkeyboard/app/MrPacksActivity$8;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v7, v0, v3}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 385
    :cond_6
    const-string v0, "mr_dicts_close"

    new-array v2, v10, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v7, v0, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 386
    invoke-virtual {v7}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 387
    return-void

    :cond_7
    move-object v0, v1

    .line 344
    goto/16 :goto_0

    :cond_8
    move-object v2, p1

    .line 348
    goto/16 :goto_1

    .line 370
    :cond_9
    if-eqz v0, :cond_5

    iget v3, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    if-le v3, v4, :cond_5

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z

    move-result v3

    if-nez v3, :cond_5

    sget-object v3, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-nez v3, :cond_5

    .line 371
    if-nez v4, :cond_a

    const-string v3, "mr_dicts_download"

    :goto_3
    new-array v6, v10, [Ljava/lang/Object;

    invoke-virtual {p0, v3, v6}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v6, Lcom/mrkeyboard/app/MrPacksActivity$7;

    invoke-direct {v6, p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity$7;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    invoke-virtual {v7, v3, v6}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    goto :goto_2

    :cond_a
    const-string v3, "mr_dicts_update"

    goto :goto_3
.end method

.method private state(Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Pack;)Ljava/lang/CharSequence;
    .locals 8

    .prologue
    const/4 v5, 0x2

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 249
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v3

    .line 250
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 251
    sget-boolean v0, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    if-eqz v0, :cond_0

    const-string v0, "mr_dicts_state_installing"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 252
    :goto_0
    const-string v2, "mr_ui_amber"

    .line 251
    invoke-direct {p0, v0, v2, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    .line 265
    :goto_1
    return-object v0

    .line 252
    :cond_0
    const-string v0, "mr_dicts_state_downloading"

    new-array v3, v1, [Ljava/lang/Object;

    sget v4, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v2

    invoke-virtual {p0, v0, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 254
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mErrorId:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mError:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mError:Ljava/lang/String;

    const-string v2, "mr_ui_rose"

    invoke-direct {p0, v0, v2, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_1

    .line 255
    :cond_2
    if-eqz p2, :cond_3

    iget v0, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    if-le v0, v3, :cond_3

    move v0, v1

    .line 256
    :goto_2
    if-eqz v0, :cond_5

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/MrPacks;->appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 257
    if-lez v3, :cond_4

    .line 258
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mr_dicts_state_installed"

    new-array v5, v5, [Ljava/lang/Object;

    .line 257
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v2

    invoke-direct {p0, p1, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->dirSize(Ljava/lang/String;I)J

    move-result-wide v6

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v5, v1

    invoke-virtual {p0, v4, v5}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " \u00b7 "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "mr_dicts_state_needs_app"

    new-array v2, v2, [Ljava/lang/Object;

    .line 258
    invoke-virtual {p0, v3, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_3
    const-string v2, "mr_ui_rose"

    .line 257
    invoke-direct {p0, v0, v2, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_1

    :cond_3
    move v0, v2

    .line 255
    goto :goto_2

    .line 258
    :cond_4
    const-string v0, "mr_dicts_state_needs_app"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_3

    .line 260
    :cond_5
    if-lez v3, :cond_7

    .line 261
    if-eqz v0, :cond_6

    const-string v0, "mr_dicts_state_update"

    new-array v3, v5, [Ljava/lang/Object;

    iget v4, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v2

    iget-wide v4, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v1

    invoke-virtual {p0, v0, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "mr_ui_blue"

    invoke-direct {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    goto/16 :goto_1

    .line 262
    :cond_6
    const-string v0, "mr_dicts_state_installed"

    new-array v4, v5, [Ljava/lang/Object;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v2

    invoke-direct {p0, p1, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->dirSize(Ljava/lang/String;I)J

    move-result-wide v6

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v4, v1

    invoke-virtual {p0, v0, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "mr_ui_mint"

    invoke-direct {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    goto/16 :goto_1

    .line 264
    :cond_7
    if-eqz p2, :cond_8

    const-string v0, "mr_dicts_state_available"

    new-array v1, v1, [Ljava/lang/Object;

    iget-wide v4, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_1

    .line 265
    :cond_8
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v0, :cond_9

    const-string v0, "mr_dicts_state_unavailable"

    :goto_4
    new-array v1, v2, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_1

    :cond_9
    const-string v0, "mr_dicts_state_notdl"

    goto :goto_4
.end method

.method private toast(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 456
    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {v0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 457
    :cond_0
    return-void
.end method

.method private update()V
    .locals 4

    .prologue
    .line 214
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 215
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrPacks$Catalog;->find(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v1

    move-object v2, v1

    .line 216
    :goto_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    invoke-virtual {v1, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/preference/Preference;

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->state(Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Pack;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 215
    :cond_0
    const/4 v1, 0x0

    move-object v2, v1

    goto :goto_1

    .line 218
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->checkState()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 219
    :cond_2
    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 65
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/preference/PreferenceActivity;->attachBaseContext(Landroid/content/Context;)V

    .line 66
    return-void
.end method

.method msg(Lcom/mrkeyboard/app/MrPacks$PackException;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 460
    iget-object v0, p1, Lcom/mrkeyboard/app/MrPacks$PackException;->key:Ljava/lang/String;

    iget-object v1, p1, Lcom/mrkeyboard/app/MrPacks$PackException;->args:[Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 461
    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p1, Lcom/mrkeyboard/app/MrPacks$PackException;->key:Ljava/lang/String;

    goto :goto_0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4

    .prologue
    .line 70
    invoke-super {p0, p1}, Landroid/preference/PreferenceActivity;->onCreate(Landroid/os/Bundle;)V

    .line 71
    const-string v0, "mr_dicts_title"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->setTitle(Ljava/lang/CharSequence;)V

    .line 72
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "prefs_suggestions"

    const-string v2, "xml"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->addPreferencesFromResource(I)V

    .line 73
    invoke-static {p0}, Lcom/mrkeyboard/app/ListDividerFix;->apply(Landroid/preference/PreferenceActivity;)V

    .line 74
    const-string v0, "mr_cat_langs"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    check-cast v0, Landroid/preference/PreferenceCategory;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    .line 75
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->hideQuickFixesIfUnsupported()V

    .line 76
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->cachedCatalog(Landroid/content/Context;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    .line 77
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->rebuild()V

    .line 78
    return-void
.end method

.method protected onPause()V
    .locals 2

    .prologue
    .line 103
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 104
    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onPause()V

    .line 105
    return-void
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 93
    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onResume()V

    .line 94
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->rebuild()V

    .line 95
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 96
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 97
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 99
    :cond_0
    return-void
.end method

.method varargs t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 465
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "string"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 466
    if-nez v0, :cond_0

    .line 470
    :goto_0
    return-object p1

    .line 468
    :cond_0
    :try_start_0
    array-length v1, p2

    if-nez v1, :cond_1

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    :goto_1
    move-object p1, v0

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0, p2}, Landroid/content/res/Resources;->getString(I[Ljava/lang/Object;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_1

    .line 469
    :catch_0
    move-exception v1

    .line 470
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p1

    goto :goto_0
.end method
