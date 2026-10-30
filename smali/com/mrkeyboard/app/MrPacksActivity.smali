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
    .line 30
    invoke-direct {p0}, Landroid/preference/PreferenceActivity;-><init>()V

    .line 31
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    .line 32
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    .line 41
    new-instance v0, Lcom/mrkeyboard/app/MrPacksActivity$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrPacksActivity$1;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrPacksActivity;)Z
    .locals 1

    .prologue
    .line 30
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->gone()Z

    move-result v0

    return v0
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->update()V

    return-void
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/MrPacksActivity;->confirmRemove(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1102(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 30
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mError:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1202(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 30
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mErrorId:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->toast(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrPacksActivity;)Landroid/os/Handler;
    .locals 1

    .prologue
    .line 30
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->showPack(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->check()V

    return-void
.end method

.method static synthetic access$502(Lcom/mrkeyboard/app/MrPacksActivity;Z)Z
    .locals 0

    .prologue
    .line 30
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    return p1
.end method

.method static synthetic access$602(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 30
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$702(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Catalog;)Lcom/mrkeyboard/app/MrPacks$Catalog;
    .locals 0

    .prologue
    .line 30
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    return-object p1
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->rebuild()V

    return-void
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Pack;)V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->download(Lcom/mrkeyboard/app/MrPacks$Pack;)V

    return-void
.end method

.method private category(Landroid/preference/PreferenceScreen;Ljava/lang/String;Ljava/lang/String;)Landroid/preference/PreferenceCategory;
    .locals 4

    .prologue
    .line 115
    new-instance v0, Landroid/preference/PreferenceCategory;

    invoke-direct {v0, p0}, Landroid/preference/PreferenceCategory;-><init>(Landroid/content/Context;)V

    .line 116
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, p2, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceCategory;->setTitle(Ljava/lang/CharSequence;)V

    .line 117
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "drawable"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, p3, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 118
    if-eqz v1, :cond_0

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceCategory;->setIcon(I)V

    .line 119
    :cond_0
    invoke-virtual {p1, v0}, Landroid/preference/PreferenceScreen;->addPreference(Landroid/preference/Preference;)Z

    .line 120
    return-object v0
.end method

.method private check()V
    .locals 3

    .prologue
    .line 209
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    if-eqz v0, :cond_0

    .line 237
    :goto_0
    return-void

    .line 210
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    .line 211
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    .line 212
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->update()V

    .line 213
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 214
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$4;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity$4;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Landroid/content/Context;)V

    const-string v0, "MrPacksCheck"

    invoke-direct {v1, v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 236
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private checkState()Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v5, 0x3

    const/4 v4, 0x0

    .line 189
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    if-eqz v0, :cond_1

    const-string v0, "mr_dicts_checking"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 196
    :cond_0
    :goto_0
    return-object v0

    .line 190
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    goto :goto_0

    .line 191
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->checkedAt(Landroid/content/Context;)J

    move-result-wide v0

    .line 192
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_3

    const-string v0, "mr_dicts_check_never"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 193
    :cond_3
    invoke-static {v5, v5}, Ljava/text/DateFormat;->getDateTimeInstance(II)Ljava/text/DateFormat;

    move-result-object v2

    new-instance v3, Ljava/util/Date;

    invoke-direct {v3, v0, v1}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v2, v3}, Ljava/text/DateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    .line 194
    const-string v1, "mr_dicts_check_last"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    aput-object v0, v2, v4

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 195
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->packs:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " \u00b7 "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "mr_dicts_empty"

    new-array v2, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private confirmRemove(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 329
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 330
    invoke-virtual {v0, p2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 331
    const-string v1, "mr_dicts_remove_confirm"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    aput-object p2, v2, v3

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 332
    const-string v1, "mr_dicts_remove"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$9;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity$9;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 341
    const-string v1, "mr_dicts_close"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 342
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 343
    return-void
.end method

.method private dirSize(Ljava/lang/String;I)J
    .locals 7

    .prologue
    .line 200
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrPacks;->packDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v3

    .line 201
    const-wide/16 v0, 0x0

    .line 202
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

    .line 203
    :cond_0
    return-wide v0
.end method

.method private download(Lcom/mrkeyboard/app/MrPacks$Pack;)V
    .locals 4

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 286
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-nez v0, :cond_1

    .line 326
    :cond_0
    :goto_0
    return-void

    .line 287
    :cond_1
    iput-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mError:Ljava/lang/String;

    .line 288
    iput-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mErrorId:Ljava/lang/String;

    .line 289
    sput v1, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    .line 290
    sput-boolean v1, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 291
    iget-object v0, p1, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 292
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    .line 293
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    .line 294
    new-instance v2, Ljava/lang/Thread;

    new-instance v3, Lcom/mrkeyboard/app/MrPacksActivity$8;

    invoke-direct {v3, p0, v1, v0, p1}, Lcom/mrkeyboard/app/MrPacksActivity$8;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Catalog;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    const-string v0, "MrPacksInstall"

    invoke-direct {v2, v3, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 323
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    .line 324
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 325
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0
.end method

.method private gone()Z
    .locals 1

    .prologue
    .line 348
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

.method private rebuild()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 125
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    if-nez v0, :cond_0

    .line 157
    :goto_0
    return-void

    .line 126
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    invoke-virtual {v0}, Landroid/preference/PreferenceCategory;->removeAll()V

    .line 127
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    .line 128
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 129
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

    .line 130
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->installedIds(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_2
    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 131
    :cond_3
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v2, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 132
    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_3
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 133
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v1, :cond_4

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrPacks$Catalog;->find(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v1

    .line 134
    :goto_4
    new-instance v4, Landroid/preference/Preference;

    invoke-direct {v4, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    .line 135
    invoke-virtual {v4, v5}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 136
    if-eqz v1, :cond_5

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrPacks$Pack;->name(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    :goto_5
    invoke-virtual {v4, v1}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 137
    new-instance v1, Lcom/mrkeyboard/app/MrPacksActivity$2;

    invoke-direct {v1, p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity$2;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    invoke-virtual {v4, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 143
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    invoke-virtual {v1, v4}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 144
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    invoke-virtual {v1, v0, v4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_3

    .line 133
    :cond_4
    const/4 v1, 0x0

    goto :goto_4

    :cond_5
    move-object v1, v0

    .line 136
    goto :goto_5

    .line 146
    :cond_6
    new-instance v0, Landroid/preference/Preference;

    invoke-direct {v0, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    .line 147
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    invoke-virtual {v0, v5}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 148
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    const-string v1, "mr_dicts_check"

    new-array v2, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 149
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    new-instance v1, Lcom/mrkeyboard/app/MrPacksActivity$3;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrPacksActivity$3;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 155
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 156
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->update()V

    goto/16 :goto_0
.end method

.method private showPack(Ljava/lang/String;)V
    .locals 13

    .prologue
    const/4 v1, 0x0

    const/4 v12, 0x2

    const/4 v11, 0x1

    const/4 v10, 0x0

    .line 240
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/MrPacks$Catalog;->find(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v0

    .line 241
    :goto_0
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v4

    .line 242
    sget-object v2, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    .line 243
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v2

    iget-object v3, v2, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 244
    if-eqz v0, :cond_8

    invoke-virtual {v0, v3}, Lcom/mrkeyboard/app/MrPacks$Pack;->name(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    .line 245
    :goto_1
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    .line 246
    if-eqz v0, :cond_2

    .line 247
    invoke-virtual {v0, v3}, Lcom/mrkeyboard/app/MrPacks$Pack;->description(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    .line 248
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v7

    if-lez v7, :cond_0

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v7, "\n\n"

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 249
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

    .line 250
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

    .line 251
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

    .line 253
    :cond_2
    if-lez v4, :cond_4

    .line 254
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    if-lez v3, :cond_3

    const-string v3, "\n\n"

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 255
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

    .line 257
    :cond_4
    new-instance v7, Landroid/app/AlertDialog$Builder;

    invoke-direct {v7, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 258
    invoke-virtual {v7, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 259
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v7, v3}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 260
    if-eqz v5, :cond_9

    .line 261
    const-string v0, "mr_dicts_cancel"

    new-array v3, v10, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v3, Lcom/mrkeyboard/app/MrPacksActivity$5;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrPacksActivity$5;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v7, v0, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 274
    :cond_5
    :goto_2
    if-lez v4, :cond_6

    if-nez v5, :cond_6

    .line 275
    const-string v0, "mr_dicts_remove"

    new-array v3, v10, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v3, Lcom/mrkeyboard/app/MrPacksActivity$7;

    invoke-direct {v3, p0, p1, v2}, Lcom/mrkeyboard/app/MrPacksActivity$7;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v7, v0, v3}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 281
    :cond_6
    const-string v0, "mr_dicts_close"

    new-array v2, v10, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v7, v0, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 282
    invoke-virtual {v7}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 283
    return-void

    :cond_7
    move-object v0, v1

    .line 240
    goto/16 :goto_0

    :cond_8
    move-object v2, p1

    .line 244
    goto/16 :goto_1

    .line 266
    :cond_9
    if-eqz v0, :cond_5

    iget v3, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    if-le v3, v4, :cond_5

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z

    move-result v3

    if-nez v3, :cond_5

    sget-object v3, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-nez v3, :cond_5

    .line 267
    if-nez v4, :cond_a

    const-string v3, "mr_dicts_download"

    :goto_3
    new-array v6, v10, [Ljava/lang/Object;

    invoke-virtual {p0, v3, v6}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v6, Lcom/mrkeyboard/app/MrPacksActivity$6;

    invoke-direct {v6, p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity$6;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    invoke-virtual {v7, v3, v6}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    goto :goto_2

    :cond_a
    const-string v3, "mr_dicts_update"

    goto :goto_3
.end method

.method private state(Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Pack;)Ljava/lang/String;
    .locals 8

    .prologue
    const/4 v5, 0x2

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 169
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v3

    .line 170
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 171
    sget-boolean v0, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    if-eqz v0, :cond_0

    const-string v0, "mr_dicts_state_installing"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 185
    :goto_0
    return-object v0

    .line 172
    :cond_0
    const-string v0, "mr_dicts_state_downloading"

    new-array v1, v1, [Ljava/lang/Object;

    sget v3, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 174
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mErrorId:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mError:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mError:Ljava/lang/String;

    goto :goto_0

    .line 175
    :cond_2
    if-eqz p2, :cond_3

    iget v0, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    if-le v0, v3, :cond_3

    move v0, v1

    .line 176
    :goto_1
    if-eqz v0, :cond_5

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/MrPacks;->appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 177
    if-lez v3, :cond_4

    .line 178
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mr_dicts_state_installed"

    new-array v5, v5, [Ljava/lang/Object;

    .line 177
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v2

    invoke-direct {p0, p1, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->dirSize(Ljava/lang/String;I)J

    move-result-wide v6

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v5, v1

    invoke-virtual {p0, v4, v5}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " \u00b7 "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "mr_dicts_state_needs_app"

    new-array v2, v2, [Ljava/lang/Object;

    .line 178
    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_3
    move v0, v2

    .line 175
    goto :goto_1

    .line 178
    :cond_4
    const-string v0, "mr_dicts_state_needs_app"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 180
    :cond_5
    if-lez v3, :cond_7

    .line 181
    if-eqz v0, :cond_6

    const-string v0, "mr_dicts_state_update"

    new-array v3, v5, [Ljava/lang/Object;

    iget v4, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v2

    iget-wide v4, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v3, v1

    invoke-virtual {p0, v0, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 182
    :cond_6
    const-string v0, "mr_dicts_state_installed"

    new-array v4, v5, [Ljava/lang/Object;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v2

    invoke-direct {p0, p1, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->dirSize(Ljava/lang/String;I)J

    move-result-wide v2

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v4, v1

    invoke-virtual {p0, v0, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 184
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

    goto/16 :goto_0

    .line 185
    :cond_8
    const-string v0, ""

    goto/16 :goto_0
.end method

.method private toast(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 352
    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {v0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 353
    :cond_0
    return-void
.end method

.method private update()V
    .locals 4

    .prologue
    .line 161
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

    .line 162
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrPacks$Catalog;->find(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v1

    move-object v2, v1

    .line 163
    :goto_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    invoke-virtual {v1, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/preference/Preference;

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->state(Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Pack;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 162
    :cond_0
    const/4 v1, 0x0

    move-object v2, v1

    goto :goto_1

    .line 165
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->checkState()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 166
    :cond_2
    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 51
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/preference/PreferenceActivity;->attachBaseContext(Landroid/content/Context;)V

    .line 52
    return-void
.end method

.method msg(Lcom/mrkeyboard/app/MrPacks$PackException;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 356
    iget-object v0, p1, Lcom/mrkeyboard/app/MrPacks$PackException;->key:Ljava/lang/String;

    iget-object v1, p1, Lcom/mrkeyboard/app/MrPacks$PackException;->args:[Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 357
    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p1, Lcom/mrkeyboard/app/MrPacks$PackException;->key:Ljava/lang/String;

    goto :goto_0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 7

    .prologue
    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 56
    invoke-super {p0, p1}, Landroid/preference/PreferenceActivity;->onCreate(Landroid/os/Bundle;)V

    .line 57
    const-string v0, "mr_dicts_title"

    new-array v1, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->setTitle(Ljava/lang/CharSequence;)V

    .line 58
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getPreferenceManager()Landroid/preference/PreferenceManager;

    move-result-object v0

    .line 59
    const-string v1, "mr_packs"

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceManager;->setSharedPreferencesName(Ljava/lang/String;)V

    .line 60
    invoke-virtual {v0, p0}, Landroid/preference/PreferenceManager;->createPreferenceScreen(Landroid/content/Context;)Landroid/preference/PreferenceScreen;

    move-result-object v0

    .line 62
    const-string v1, "mr_dicts_cat_langs"

    const-string v2, "mr_ui_ic_globe_mint"

    invoke-direct {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->category(Landroid/preference/PreferenceScreen;Ljava/lang/String;Ljava/lang/String;)Landroid/preference/PreferenceCategory;

    move-result-object v1

    iput-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    .line 64
    const-string v1, "mr_dicts_cat_options"

    const-string v2, "mr_ui_ic_gear_slate"

    invoke-direct {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->category(Landroid/preference/PreferenceScreen;Ljava/lang/String;Ljava/lang/String;)Landroid/preference/PreferenceCategory;

    move-result-object v1

    .line 65
    new-instance v2, Landroid/preference/CheckBoxPreference;

    invoke-direct {v2, p0}, Landroid/preference/CheckBoxPreference;-><init>(Landroid/content/Context;)V

    .line 66
    const-string v3, "wifi_only"

    invoke-virtual {v2, v3}, Landroid/preference/CheckBoxPreference;->setKey(Ljava/lang/String;)V

    .line 67
    const-string v3, "mr_dicts_wifi"

    new-array v4, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/preference/CheckBoxPreference;->setTitle(Ljava/lang/CharSequence;)V

    .line 68
    const-string v3, "mr_dicts_wifi_sum"

    new-array v4, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/preference/CheckBoxPreference;->setSummary(Ljava/lang/CharSequence;)V

    .line 69
    sget-object v3, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v2, v3}, Landroid/preference/CheckBoxPreference;->setDefaultValue(Ljava/lang/Object;)V

    .line 70
    invoke-virtual {v2, v6}, Landroid/preference/CheckBoxPreference;->setPersistent(Z)V

    .line 71
    invoke-virtual {v1, v2}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 72
    new-instance v2, Landroid/preference/CheckBoxPreference;

    invoke-direct {v2, p0}, Landroid/preference/CheckBoxPreference;-><init>(Landroid/content/Context;)V

    .line 73
    const-string v3, "auto_check"

    invoke-virtual {v2, v3}, Landroid/preference/CheckBoxPreference;->setKey(Ljava/lang/String;)V

    .line 74
    const-string v3, "mr_dicts_auto"

    new-array v4, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/preference/CheckBoxPreference;->setTitle(Ljava/lang/CharSequence;)V

    .line 75
    const-string v3, "mr_dicts_auto_sum"

    new-array v4, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/preference/CheckBoxPreference;->setSummary(Ljava/lang/CharSequence;)V

    .line 76
    sget-object v3, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-virtual {v2, v3}, Landroid/preference/CheckBoxPreference;->setDefaultValue(Ljava/lang/Object;)V

    .line 77
    invoke-virtual {v2, v6}, Landroid/preference/CheckBoxPreference;->setPersistent(Z)V

    .line 78
    invoke-virtual {v1, v2}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 80
    const-string v1, "mr_dicts_cat_privacy"

    const-string v2, "mr_ui_ic_info_slate"

    invoke-direct {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->category(Landroid/preference/PreferenceScreen;Ljava/lang/String;Ljava/lang/String;)Landroid/preference/PreferenceCategory;

    move-result-object v1

    .line 81
    new-instance v2, Landroid/preference/Preference;

    invoke-direct {v2, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    .line 82
    const-string v3, "mr_dicts_privacy_title"

    new-array v4, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 83
    const-string v3, "mr_dicts_privacy_text"

    new-array v4, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 84
    invoke-virtual {v2, v5}, Landroid/preference/Preference;->setSelectable(Z)V

    .line 85
    invoke-virtual {v2, v5}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 86
    invoke-virtual {v1, v2}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 88
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->setPreferenceScreen(Landroid/preference/PreferenceScreen;)V

    .line 89
    invoke-static {p0}, Lcom/mrkeyboard/app/ListDividerFix;->apply(Landroid/preference/PreferenceActivity;)V

    .line 91
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->cachedCatalog(Landroid/content/Context;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    .line 92
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->rebuild()V

    .line 93
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->autoCheck(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->check()V

    .line 94
    :cond_0
    return-void
.end method

.method protected onPause()V
    .locals 2

    .prologue
    .line 108
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 109
    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onPause()V

    .line 110
    return-void
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 98
    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onResume()V

    .line 99
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->rebuild()V

    .line 100
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 101
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 102
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 104
    :cond_0
    return-void
.end method

.method varargs t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 361
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "string"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 362
    if-nez v0, :cond_0

    .line 366
    :goto_0
    return-object p1

    .line 364
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

    .line 365
    :catch_0
    move-exception v1

    .line 366
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p1

    goto :goto_0
.end method
