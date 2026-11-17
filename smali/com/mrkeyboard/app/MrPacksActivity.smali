.class public Lcom/mrkeyboard/app/MrPacksActivity;
.super Landroid/preference/PreferenceActivity;
.source "MrPacksActivity.java"


# static fields
.field private static final G:Ljava/lang/String; = "gesture"

.field private static final REQ_MODEL_FILE:I = 0x1ce9


# instance fields
.field private mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

.field private mCheck:Landroid/preference/Preference;

.field private mCheckError:Ljava/lang/String;

.field private mChecking:Z

.field private mError:Ljava/lang/String;

.field private mErrorId:Ljava/lang/String;

.field private mGNotice:Landroid/preference/Preference;

.field private mGPack:Landroid/preference/Preference;

.field private mGTime:Landroid/preference/Preference;

.field private final mHandler:Landroid/os/Handler;

.field private mLangs:Landroid/preference/PreferenceCategory;

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

.field private final mRefresh:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 53
    invoke-direct {p0}, Landroid/preference/PreferenceActivity;-><init>()V

    .line 54
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    .line 55
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    .line 71
    new-instance v0, Lcom/mrkeyboard/app/MrPacksActivity$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrPacksActivity$1;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mRefresh:Ljava/lang/Runnable;

    .line 77
    new-instance v0, Lcom/mrkeyboard/app/MrPacksActivity$2;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrPacksActivity$2;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrPacksActivity;)Z
    .locals 1

    .prologue
    .line 53
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->gone()Z

    move-result v0

    return v0
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->update()V

    return-void
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->toast(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->fetchedModel()V

    return-void
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->showPack(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Pack;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->download(Lcom/mrkeyboard/app/MrPacks$Pack;)V

    return-void
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrPacksActivity;->confirmRemove(Ljava/lang/String;Ljava/lang/String;Z)V

    return-void
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->pickModelFile()V

    return-void
.end method

.method static synthetic access$1602(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 53
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mError:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1702(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 53
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mErrorId:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1800(Lcom/mrkeyboard/app/MrPacksActivity;)Z
    .locals 1

    .prologue
    .line 53
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->gestureOn()Z

    move-result v0

    return v0
.end method

.method static synthetic access$1900(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->openModel()V

    return-void
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrPacksActivity;)Landroid/os/Handler;
    .locals 1

    .prologue
    .line 53
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$2000(Lcom/mrkeyboard/app/MrPacksActivity;)Ljava/lang/Runnable;
    .locals 1

    .prologue
    .line 53
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mRefresh:Ljava/lang/Runnable;

    return-object v0
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->open(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->check()V

    return-void
.end method

.method static synthetic access$502(Lcom/mrkeyboard/app/MrPacksActivity;Z)Z
    .locals 0

    .prologue
    .line 53
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    return p1
.end method

.method static synthetic access$602(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 53
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$702(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Catalog;)Lcom/mrkeyboard/app/MrPacks$Catalog;
    .locals 0

    .prologue
    .line 53
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    return-object p1
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/MrPacksActivity;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 53
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mOpenId:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$802(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 53
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mOpenId:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->rebuild()V

    return-void
.end method

.method private askModel()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 543
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 544
    const-string v1, "mr_gesture_pack_title"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 545
    const-string v1, "mr_gesture_need_pack"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 546
    const-string v1, "mr_dicts_download"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$14;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrPacksActivity$14;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 552
    const-string v1, "mr_gesture_later"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 553
    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-nez v1, :cond_0

    .line 554
    const-string v1, "mr_gesture_from_file"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$15;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrPacksActivity$15;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 560
    :cond_0
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 561
    return-void
.end method

.method private buildGesture()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 464
    const-string v0, "mr_cat_gesture"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 465
    instance-of v1, v0, Landroid/preference/PreferenceGroup;

    if-nez v1, :cond_1

    .line 507
    :cond_0
    :goto_0
    return-void

    .line 466
    :cond_1
    check-cast v0, Landroid/preference/PreferenceGroup;

    .line 467
    new-instance v1, Landroid/preference/Preference;

    invoke-direct {v1, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGPack:Landroid/preference/Preference;

    .line 468
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGPack:Landroid/preference/Preference;

    invoke-virtual {v1, v4}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 469
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGPack:Landroid/preference/Preference;

    const-string v2, "mr_gesture_pack_title"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 470
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGPack:Landroid/preference/Preference;

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$12;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrPacksActivity$12;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v1, v2}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 476
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGPack:Landroid/preference/Preference;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceGroup;->addPreference(Landroid/preference/Preference;)Z

    .line 477
    new-instance v1, Landroid/preference/Preference;

    invoke-direct {v1, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    .line 478
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    invoke-virtual {v1, v4}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 479
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    invoke-virtual {v1, v4}, Landroid/preference/Preference;->setSelectable(Z)V

    .line 480
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->plain(Landroid/preference/Preference;)V

    .line 481
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    const-string v2, "mr_gesture_time_title"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 482
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceGroup;->addPreference(Landroid/preference/Preference;)Z

    .line 485
    new-instance v1, Landroid/preference/Preference;

    invoke-direct {v1, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGNotice:Landroid/preference/Preference;

    .line 486
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGNotice:Landroid/preference/Preference;

    invoke-virtual {v1, v4}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 487
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGNotice:Landroid/preference/Preference;

    const-string v2, "mr_gesture_notice_title"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 488
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGNotice:Landroid/preference/Preference;

    invoke-virtual {v1, v4}, Landroid/preference/Preference;->setSelectable(Z)V

    .line 489
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGNotice:Landroid/preference/Preference;

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->plain(Landroid/preference/Preference;)V

    .line 490
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGNotice:Landroid/preference/Preference;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceGroup;->addPreference(Landroid/preference/Preference;)Z

    .line 491
    const-string v0, "pref_gesture_typing"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 492
    if-eqz v0, :cond_0

    .line 493
    new-instance v1, Lcom/mrkeyboard/app/MrPacksActivity$13;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrPacksActivity$13;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceChangeListener(Landroid/preference/Preference$OnPreferenceChangeListener;)V

    goto/16 :goto_0
.end method

.method private check()V
    .locals 3

    .prologue
    .line 296
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    if-eqz v0, :cond_0

    .line 332
    :goto_0
    return-void

    .line 297
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    .line 298
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    .line 299
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->update()V

    .line 300
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 301
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$5;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity$5;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Landroid/content/Context;)V

    const-string v0, "MrPacksCheck"

    invoke-direct {v1, v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 331
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private checkState()Ljava/lang/CharSequence;
    .locals 7

    .prologue
    const/4 v6, 0x3

    const/4 v4, 0x1

    const/4 v5, 0x0

    .line 258
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    if-eqz v0, :cond_1

    const-string v0, "mr_dicts_checking"

    new-array v1, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 273
    :cond_0
    :goto_0
    return-object v0

    .line 259
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    const-string v1, "mr_ui_rose"

    invoke-direct {p0, v0, v1, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_0

    .line 260
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->checkedAt(Landroid/content/Context;)J

    move-result-wide v0

    .line 261
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_3

    const-string v0, "mr_dicts_check_never"

    new-array v1, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 262
    :cond_3
    invoke-static {v6, v6}, Ljava/text/DateFormat;->getDateTimeInstance(II)Ljava/text/DateFormat;

    move-result-object v2

    new-instance v3, Ljava/util/Date;

    invoke-direct {v3, v0, v1}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v2, v3}, Ljava/text/DateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    .line 263
    const-string v1, "mr_dicts_check_last"

    new-array v2, v4, [Ljava/lang/Object;

    aput-object v0, v2, v5

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 264
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

    .line 265
    :cond_4
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrPacks;->updatesAvailable(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Catalog;)I

    move-result v2

    .line 266
    if-eqz v2, :cond_0

    .line 267
    new-instance v1, Landroid/text/SpannableStringBuilder;

    invoke-direct {v1, v0}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    .line 268
    const-string v0, " \u00b7 "

    invoke-virtual {v1, v0}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    .line 269
    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v3

    .line 270
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

    .line 271
    const-string v0, "mr_ui_blue"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->color(Ljava/lang/String;)I

    move-result v0

    .line 272
    if-eqz v0, :cond_5

    new-instance v2, Landroid/text/style/ForegroundColorSpan;

    invoke-direct {v2, v0}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v0

    const/16 v4, 0x21

    invoke-virtual {v1, v2, v3, v0, v4}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    :cond_5
    move-object v0, v1

    .line 273
    goto/16 :goto_0

    .line 270
    :cond_6
    const-string v0, "mr_dicts_updates_many"

    goto :goto_1
.end method

.method private color(Ljava/lang/String;)I
    .locals 3

    .prologue
    .line 209
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "color"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 210
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

.method private confirmRemove(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 441
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 442
    invoke-virtual {v1, p2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 443
    if-eqz p3, :cond_0

    const-string v0, "mr_gesture_remove_confirm"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {v1, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 444
    const-string v0, "mr_dicts_remove"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$11;

    invoke-direct {v2, p0, p3, p1}, Lcom/mrkeyboard/app/MrPacksActivity$11;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;ZLjava/lang/String;)V

    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 453
    const-string v0, "mr_dicts_close"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 454
    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 455
    return-void

    .line 443
    :cond_0
    const-string v0, "mr_dicts_remove_confirm"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    aput-object p2, v2, v3

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private details(Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Pack;ILjava/lang/String;Z)V
    .locals 9

    .prologue
    const/4 v8, 0x2

    const/4 v7, 0x1

    const/4 v6, 0x0

    .line 341
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    .line 342
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v0, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 343
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 344
    if-eqz p2, :cond_2

    .line 345
    invoke-virtual {p2, v0}, Lcom/mrkeyboard/app/MrPacks$Pack;->description(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 346
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "\n\n"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 347
    :cond_0
    const-string v0, "mr_dicts_size_download"

    new-array v3, v8, [Ljava/lang/Object;

    iget-wide v4, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v6

    iget-wide v4, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->installedSize:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v7

    invoke-virtual {p0, v0, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 348
    iget-object v0, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->licenses:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_1

    const-string v0, "\n"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "mr_dicts_licenses"

    new-array v4, v7, [Ljava/lang/Object;

    iget-object v5, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->licenses:Ljava/lang/String;

    aput-object v5, v4, v6

    invoke-virtual {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 349
    :cond_1
    iget-object v0, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->credits:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_2

    const-string v0, "\n\n"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v3, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->credits:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 351
    :cond_2
    if-lez p3, :cond_4

    .line 352
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    if-lez v0, :cond_3

    const-string v0, "\n\n"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 353
    :cond_3
    const-string v0, "mr_dicts_state_installed"

    new-array v3, v8, [Ljava/lang/Object;

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v6

    invoke-direct {p0, p1, p3, p5}, Lcom/mrkeyboard/app/MrPacksActivity;->dirSize(Ljava/lang/String;IZ)J

    move-result-wide v4

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v7

    invoke-virtual {p0, v0, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 355
    :cond_4
    new-instance v3, Landroid/app/AlertDialog$Builder;

    invoke-direct {v3, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 356
    invoke-virtual {v3, p4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 357
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 358
    if-eqz v1, :cond_7

    .line 359
    const-string v0, "mr_dicts_cancel"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$6;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrPacksActivity$6;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v3, v0, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 372
    :cond_5
    :goto_0
    if-lez p3, :cond_9

    if-nez v1, :cond_9

    .line 373
    const-string v0, "mr_dicts_remove"

    new-array v1, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/MrPacksActivity$8;

    invoke-direct {v1, p0, p1, p4, p5}, Lcom/mrkeyboard/app/MrPacksActivity$8;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;Ljava/lang/String;Z)V

    invoke-virtual {v3, v0, v1}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 385
    :cond_6
    :goto_1
    const-string v0, "mr_dicts_close"

    new-array v1, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v3, v0, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 386
    invoke-virtual {v3}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 387
    return-void

    .line 364
    :cond_7
    if-eqz p2, :cond_5

    iget v0, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    if-le v0, p3, :cond_5

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/MrPacks;->appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z

    move-result v0

    if-nez v0, :cond_5

    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-nez v0, :cond_5

    .line 365
    if-nez p3, :cond_8

    const-string v0, "mr_dicts_download"

    :goto_2
    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$7;

    invoke-direct {v2, p0, p2}, Lcom/mrkeyboard/app/MrPacksActivity$7;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    invoke-virtual {v3, v0, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    goto :goto_0

    :cond_8
    const-string v0, "mr_dicts_update"

    goto :goto_2

    .line 378
    :cond_9
    if-eqz p5, :cond_6

    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-nez v0, :cond_6

    .line 379
    const-string v0, "mr_gesture_from_file"

    new-array v1, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/MrPacksActivity$9;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrPacksActivity$9;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v3, v0, v1}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    goto :goto_1
.end method

.method private dirSize(Ljava/lang/String;IZ)J
    .locals 7

    .prologue
    .line 277
    if-eqz p3, :cond_0

    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrPacks;->modelDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;

    move-result-object v0

    :goto_0
    invoke-virtual {v0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v3

    .line 278
    const-wide/16 v0, 0x0

    .line 279
    if-eqz v3, :cond_1

    array-length v6, v3

    const/4 v2, 0x0

    :goto_1
    if-ge v2, v6, :cond_1

    aget-object v4, v3, v2

    invoke-virtual {v4}, Ljava/io/File;->length()J

    move-result-wide v4

    add-long/2addr v4, v0

    add-int/lit8 v0, v2, 0x1

    move v2, v0

    move-wide v0, v4

    goto :goto_1

    .line 277
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrPacks;->packDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;

    move-result-object v0

    goto :goto_0

    .line 280
    :cond_1
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

    .line 438
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

    new-instance v3, Lcom/mrkeyboard/app/MrPacksActivity$10;

    invoke-direct {v3, p0, v1, v0, p1}, Lcom/mrkeyboard/app/MrPacksActivity$10;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Catalog;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    const-string v0, "MrPacksInstall"

    invoke-direct {v2, v3, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 435
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    .line 436
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 437
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0
.end method

.method private fetchedModel()V
    .locals 6

    .prologue
    const/4 v4, 0x0

    .line 625
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    const-string v1, "gesture"

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrPacks$Catalog;->model(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v2

    .line 626
    :goto_0
    if-nez v2, :cond_1

    .line 627
    const-string v0, "mr_dicts_state_unavailable"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->toast(Ljava/lang/String;)V

    .line 635
    :goto_1
    return-void

    .line 625
    :cond_0
    const/4 v2, 0x0

    goto :goto_0

    .line 628
    :cond_1
    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrPacks;->appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 629
    const-string v0, "mr_gesture_err_app_old"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->toast(Ljava/lang/String;)V

    goto :goto_1

    .line 630
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-eqz v0, :cond_3

    .line 631
    const-string v1, "gesture"

    const-string v0, "gesture"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->modelVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v3

    const-string v0, "mr_gesture_pack_title"

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x1

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrPacksActivity;->details(Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Pack;ILjava/lang/String;Z)V

    goto :goto_1

    .line 633
    :cond_3
    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->download(Lcom/mrkeyboard/app/MrPacks$Pack;)V

    goto :goto_1
.end method

.method private gestureOn()Z
    .locals 3

    .prologue
    .line 510
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "pref_gesture_typing"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method private gone()Z
    .locals 1

    .prologue
    .line 640
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
    .line 215
    const-string v0, " \u00b7 "

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    const/16 v0, 0x3a

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 216
    if-gez v1, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    .line 217
    :cond_0
    if-gez v0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 218
    :cond_1
    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    return v0
.end method

.method private hideQuickFixesIfUnsupported()V
    .locals 3

    .prologue
    .line 109
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getListView()Landroid/widget/ListView;

    move-result-object v0

    invoke-static {v0}, Landroid/text/AutoText;->getSize(Landroid/view/View;)I

    move-result v0

    const/4 v1, 0x1

    if-lt v0, v1, :cond_1

    .line 113
    :cond_0
    :goto_0
    return-void

    .line 110
    :cond_1
    const-string v0, "quick_fixes"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v1

    .line 111
    const-string v0, "mr_cat_suggestions"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 112
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
    .line 136
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

    .line 137
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

.method private open(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 287
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-nez v0, :cond_0

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    .line 288
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mOpenId:Ljava/lang/String;

    .line 289
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->check()V

    .line 293
    :goto_0
    return-void

    .line 291
    :cond_0
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->showPack(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private openModel()V
    .locals 6

    .prologue
    .line 533
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    const-string v1, "gesture"

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrPacks$Catalog;->model(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v2

    .line 534
    :goto_0
    if-nez v2, :cond_1

    const-string v0, "gesture"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->modelVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_1

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->askModel()V

    .line 536
    :goto_1
    return-void

    .line 533
    :cond_0
    const/4 v2, 0x0

    goto :goto_0

    .line 535
    :cond_1
    const-string v1, "gesture"

    const-string v0, "gesture"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->modelVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v3

    const-string v0, "mr_gesture_pack_title"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x1

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrPacksActivity;->details(Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Pack;ILjava/lang/String;Z)V

    goto :goto_1
.end method

.method private paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;
    .locals 5

    .prologue
    const/4 v2, 0x0

    .line 223
    if-nez p2, :cond_1

    move v0, v2

    .line 224
    :goto_0
    if-eqz v0, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_2

    .line 227
    :cond_0
    :goto_1
    return-object p1

    .line 223
    :cond_1
    invoke-direct {p0, p2}, Lcom/mrkeyboard/app/MrPacksActivity;->color(Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 225
    :cond_2
    new-instance v1, Landroid/text/SpannableString;

    invoke-direct {v1, p1}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    .line 226
    new-instance v3, Landroid/text/style/ForegroundColorSpan;

    invoke-direct {v3, v0}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    if-eqz p3, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    :goto_2
    const/16 v4, 0x21

    invoke-virtual {v1, v3, v2, v0, v4}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    move-object p1, v1

    .line 227
    goto :goto_1

    .line 226
    :cond_3
    invoke-static {p1}, Lcom/mrkeyboard/app/MrPacksActivity;->headEnd(Ljava/lang/String;)I

    move-result v0

    goto :goto_2
.end method

.method private pickModelFile()V
    .locals 2

    .prologue
    .line 565
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 566
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 567
    const-string v1, "*/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 569
    const/16 v1, 0x1ce9

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 573
    :goto_0
    return-void

    .line 570
    :catch_0
    move-exception v0

    .line 571
    const-string v0, "mr_words_no_files"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->toast(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private plain(Landroid/preference/Preference;)V
    .locals 4

    .prologue
    .line 141
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "mr_ui_pref_row_static"

    const-string v2, "layout"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 142
    if-eqz v0, :cond_0

    invoke-virtual {p1, v0}, Landroid/preference/Preference;->setLayoutResource(I)V

    .line 143
    :cond_0
    return-void
.end method

.method private rebuild()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 147
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    if-nez v0, :cond_0

    .line 194
    :goto_0
    return-void

    .line 148
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    invoke-virtual {v0}, Landroid/preference/PreferenceCategory;->removeAll()V

    .line 149
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    .line 150
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 151
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

    .line 152
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v2, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 153
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->installedIds(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v2}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/mrkeyboard/app/MrPacks;->cardIds(Ljava/util/List;Ljava/util/List;Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v3

    .line 154
    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_2
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 155
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrPacks$Catalog;->find(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v1

    .line 156
    :goto_3
    new-instance v5, Landroid/preference/Preference;

    invoke-direct {v5, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    .line 157
    invoke-virtual {v5, v6}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 158
    if-eqz v1, :cond_3

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrPacks$Pack;->name(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    :goto_4
    invoke-virtual {v5, v1}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 159
    new-instance v1, Lcom/mrkeyboard/app/MrPacksActivity$3;

    invoke-direct {v1, p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity$3;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    invoke-virtual {v5, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 165
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    invoke-virtual {v1, v5}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 166
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    invoke-virtual {v1, v0, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    .line 155
    :cond_2
    const/4 v1, 0x0

    goto :goto_3

    .line 158
    :cond_3
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->langName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_4

    .line 168
    :cond_4
    new-instance v0, Landroid/preference/Preference;

    invoke-direct {v0, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    .line 169
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    invoke-virtual {v0, v6}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 170
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    const-string v1, "mr_dicts_check"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 171
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    new-instance v1, Lcom/mrkeyboard/app/MrPacksActivity$4;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrPacksActivity$4;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 177
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 178
    new-instance v0, Landroid/preference/Preference;

    invoke-direct {v0, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    .line 179
    invoke-virtual {v0, v6}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 180
    invoke-virtual {v0, v6}, Landroid/preference/Preference;->setSelectable(Z)V

    .line 181
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->plain(Landroid/preference/Preference;)V

    .line 182
    const-string v1, "mr_dicts_langs_hint"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 183
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    invoke-virtual {v1, v0}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 185
    new-instance v1, Landroid/preference/Preference;

    invoke-direct {v1, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    .line 186
    invoke-virtual {v1, v6}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 187
    invoke-virtual {v1, v6}, Landroid/preference/Preference;->setSelectable(Z)V

    .line 188
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->plain(Landroid/preference/Preference;)V

    .line 189
    const-string v0, "mr_engine_title"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 190
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->ready()Z

    move-result v0

    if-eqz v0, :cond_5

    const-string v0, "mr_engine_native"

    :goto_5
    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 191
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 192
    invoke-static {p0, v3}, Lcom/mrkeyboard/app/MrPacks;->syncLanguages(Landroid/content/Context;Ljava/util/List;)V

    .line 193
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->update()V

    goto/16 :goto_0

    .line 190
    :cond_5
    const-string v0, "mr_engine_missing"

    goto :goto_5
.end method

.method private showPack(Ljava/lang/String;)V
    .locals 6

    .prologue
    .line 335
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/MrPacks$Catalog;->find(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v2

    .line 336
    :goto_0
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v3

    if-eqz v2, :cond_1

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v0, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v2, v0}, Lcom/mrkeyboard/app/MrPacks$Pack;->name(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v4

    :goto_1
    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrPacksActivity;->details(Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Pack;ILjava/lang/String;Z)V

    .line 337
    return-void

    .line 335
    :cond_0
    const/4 v2, 0x0

    goto :goto_0

    :cond_1
    move-object v4, p1

    .line 336
    goto :goto_1
.end method

.method private state(Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Pack;Z)Ljava/lang/CharSequence;
    .locals 8

    .prologue
    const/4 v5, 0x2

    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 235
    if-eqz p3, :cond_0

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->modelVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    .line 236
    :goto_0
    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 237
    sget-boolean v0, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    if-eqz v0, :cond_1

    const-string v0, "mr_dicts_state_installing"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 238
    :goto_1
    const-string v1, "mr_ui_amber"

    .line 237
    invoke-direct {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    .line 254
    :goto_2
    return-object v0

    .line 235
    :cond_0
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 238
    :cond_1
    const-string v0, "mr_dicts_state_downloading"

    new-array v1, v2, [Ljava/lang/Object;

    sget v4, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v1, v3

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 240
    :cond_2
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mErrorId:Ljava/lang/String;

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mError:Ljava/lang/String;

    if-eqz v1, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mError:Ljava/lang/String;

    const-string v1, "mr_ui_rose"

    invoke-direct {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_2

    .line 241
    :cond_3
    if-eqz p2, :cond_4

    iget v1, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    if-le v1, v0, :cond_4

    move v1, v2

    .line 242
    :goto_3
    if-eqz v1, :cond_6

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/MrPacks;->appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 243
    if-lez v0, :cond_5

    .line 244
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mr_dicts_state_installed"

    new-array v5, v5, [Ljava/lang/Object;

    .line 243
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v3

    invoke-direct {p0, p1, v0, p3}, Lcom/mrkeyboard/app/MrPacksActivity;->dirSize(Ljava/lang/String;IZ)J

    move-result-wide v6

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v5, v2

    invoke-virtual {p0, v4, v5}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " \u00b7 "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "mr_dicts_state_needs_app"

    new-array v3, v3, [Ljava/lang/Object;

    .line 244
    invoke-virtual {p0, v1, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_4
    const-string v1, "mr_ui_rose"

    .line 243
    invoke-direct {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_2

    :cond_4
    move v1, v3

    .line 241
    goto :goto_3

    .line 244
    :cond_5
    const-string v0, "mr_dicts_state_needs_app"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_4

    .line 246
    :cond_6
    if-lez v0, :cond_8

    .line 247
    if-eqz v1, :cond_7

    const-string v0, "mr_dicts_state_update"

    new-array v1, v5, [Ljava/lang/Object;

    iget v4, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v1, v3

    iget-wide v4, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v1, v2

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "mr_ui_blue"

    invoke-direct {p0, v0, v1, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    goto/16 :goto_2

    .line 248
    :cond_7
    const-string v1, "mr_dicts_state_installed"

    new-array v4, v5, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v3

    invoke-direct {p0, p1, v0, p3}, Lcom/mrkeyboard/app/MrPacksActivity;->dirSize(Ljava/lang/String;IZ)J

    move-result-wide v6

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v4, v2

    invoke-virtual {p0, v1, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "mr_ui_mint"

    invoke-direct {p0, v0, v1, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    goto/16 :goto_2

    .line 251
    :cond_8
    if-eqz p3, :cond_9

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->gestureOn()Z

    move-result v0

    if-eqz v0, :cond_9

    const-string v0, "mr_gesture_state_needed"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "mr_ui_rose"

    invoke-direct {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    goto/16 :goto_2

    .line 252
    :cond_9
    if-eqz p2, :cond_a

    const-string v0, "mr_dicts_state_available"

    new-array v1, v2, [Ljava/lang/Object;

    iget-wide v4, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v1, v3

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_2

    .line 254
    :cond_a
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v0, :cond_b

    if-nez p3, :cond_b

    const-string v0, "mr_dicts_state_unavailable"

    :goto_5
    new-array v1, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_2

    :cond_b
    const-string v0, "mr_dicts_state_notdl"

    goto :goto_5
.end method

.method private timeText()Ljava/lang/String;
    .locals 10

    .prologue
    .line 515
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->gestureOn()Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "mr_gesture_time_off"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 528
    :goto_0
    return-object v0

    .line 516
    :cond_0
    const-string v0, "gesture"

    const-string v1, "encoder.bin"

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->modelFile(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    if-nez v0, :cond_1

    const-string v0, "mr_gesture_time_nopack"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 517
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->ready()Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "mr_engine_missing"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 518
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrGesture;->ready()Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "mr_gesture_time_loading"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 519
    :cond_3
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->stats()[J

    move-result-object v0

    .line 520
    const/4 v1, 0x0

    aget-wide v2, v0, v1

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-gtz v1, :cond_4

    const-string v0, "mr_gesture_time_none"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 521
    :cond_4
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "mr_gesture_time_stats"

    const/4 v3, 0x4

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    const/4 v5, 0x1

    aget-wide v6, v0, v5

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    const/4 v5, 0x2

    aget-wide v6, v0, v5

    const/4 v5, 0x0

    aget-wide v8, v0, v5

    div-long/2addr v6, v8

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x2

    const/4 v5, 0x3

    aget-wide v6, v0, v5

    .line 522
    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x3

    const/4 v5, 0x0

    aget-wide v6, v0, v5

    const-wide/32 v8, 0x7fffffff

    invoke-static {v6, v7, v8, v9}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v6

    long-to-int v5, v6

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    .line 521
    invoke-virtual {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 525
    const/4 v2, 0x4

    aget-wide v2, v0, v2

    const-wide/16 v4, 0x0

    cmp-long v2, v2, v4

    if-lez v2, :cond_5

    const/16 v2, 0xa

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "mr_gesture_time_preview"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const/4 v6, 0x5

    aget-wide v6, v0, v6

    const/4 v8, 0x4

    aget-wide v8, v0, v8

    div-long/2addr v6, v8

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v4, v5

    const/4 v5, 0x1

    const/4 v6, 0x6

    aget-wide v6, v0, v6

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v4, v5

    invoke-virtual {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 526
    :cond_5
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureWords;->stats()[J

    move-result-object v0

    .line 527
    const/4 v2, 0x0

    aget-wide v2, v0, v2

    const-wide/16 v4, 0x0

    cmp-long v2, v2, v4

    if-lez v2, :cond_6

    const/16 v2, 0xa

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "mr_gesture_time_words"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const/4 v6, 0x0

    aget-wide v6, v0, v6

    const-wide/32 v8, 0x7fffffff

    invoke-static {v6, v7, v8, v9}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v6

    long-to-int v6, v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v4, v5

    const/4 v5, 0x1

    const/4 v6, 0x1

    aget-wide v6, v0, v6

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrDiag;->msText(J)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v4, v5

    invoke-virtual {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 528
    :cond_6
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0
.end method

.method private toast(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 644
    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {v0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 645
    :cond_0
    return-void
.end method

.method private update()V
    .locals 6

    .prologue
    const/4 v3, 0x0

    .line 198
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 199
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrPacks$Catalog;->find(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v1

    move-object v2, v1

    .line 200
    :goto_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    invoke-virtual {v1, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/preference/Preference;

    const/4 v5, 0x0

    invoke-direct {p0, v0, v2, v5}, Lcom/mrkeyboard/app/MrPacksActivity;->state(Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Pack;Z)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_0
    move-object v2, v3

    .line 199
    goto :goto_1

    .line 202
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->checkState()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 203
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGPack:Landroid/preference/Preference;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGPack:Landroid/preference/Preference;

    const-string v1, "gesture"

    iget-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    const-string v3, "gesture"

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrPacks$Catalog;->model(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v3

    :cond_3
    const/4 v2, 0x1

    invoke-direct {p0, v1, v3, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->state(Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Pack;Z)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 204
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->timeText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 205
    :cond_5
    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 87
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/preference/PreferenceActivity;->attachBaseContext(Landroid/content/Context;)V

    .line 88
    return-void
.end method

.method msg(Lcom/mrkeyboard/app/MrPacks$PackException;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 648
    iget-object v0, p1, Lcom/mrkeyboard/app/MrPacks$PackException;->key:Ljava/lang/String;

    iget-object v1, p1, Lcom/mrkeyboard/app/MrPacks$PackException;->args:[Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 649
    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p1, Lcom/mrkeyboard/app/MrPacks$PackException;->key:Ljava/lang/String;

    goto :goto_0
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 4

    .prologue
    const/4 v2, 0x0

    .line 577
    invoke-super {p0, p1, p2, p3}, Landroid/preference/PreferenceActivity;->onActivityResult(IILandroid/content/Intent;)V

    .line 578
    const/16 v0, 0x1ce9

    if-ne p1, v0, :cond_0

    const/4 v0, -0x1

    if-ne p2, v0, :cond_0

    if-eqz p3, :cond_0

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    if-nez v0, :cond_1

    .line 621
    :cond_0
    :goto_0
    return-void

    .line 579
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 580
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    .line 581
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    .line 582
    iput-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mError:Ljava/lang/String;

    .line 583
    iput-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mErrorId:Ljava/lang/String;

    .line 584
    const/4 v2, 0x0

    sput v2, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    .line 585
    const/4 v2, 0x1

    sput-boolean v2, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 586
    const-string v2, "gesture"

    sput-object v2, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 587
    new-instance v2, Ljava/lang/Thread;

    new-instance v3, Lcom/mrkeyboard/app/MrPacksActivity$16;

    invoke-direct {v3, p0, v1, v0}, Lcom/mrkeyboard/app/MrPacksActivity$16;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Landroid/content/Context;Landroid/net/Uri;)V

    const-string v0, "MrModelFile"

    invoke-direct {v2, v3, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 618
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    .line 619
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 620
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4

    .prologue
    .line 92
    invoke-super {p0, p1}, Landroid/preference/PreferenceActivity;->onCreate(Landroid/os/Bundle;)V

    .line 93
    const-string v0, "mr_dicts_title"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->setTitle(Ljava/lang/CharSequence;)V

    .line 94
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "prefs_suggestions"

    const-string v2, "xml"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->addPreferencesFromResource(I)V

    .line 95
    invoke-static {p0}, Lcom/mrkeyboard/app/ListDividerFix;->apply(Landroid/preference/PreferenceActivity;)V

    .line 96
    const-string v0, "mr_cat_langs"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    check-cast v0, Landroid/preference/PreferenceCategory;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    .line 97
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->hideQuickFixesIfUnsupported()V

    .line 98
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrGestureInput;->init(Landroid/content/Context;)V

    .line 99
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->buildGesture()V

    .line 100
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->cachedCatalog(Landroid/content/Context;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    .line 101
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->rebuild()V

    .line 102
    return-void
.end method

.method protected onPause()V
    .locals 2

    .prologue
    .line 127
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 128
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mRefresh:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 129
    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onPause()V

    .line 130
    return-void
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 117
    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onResume()V

    .line 118
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->rebuild()V

    .line 119
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 120
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 121
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 123
    :cond_0
    return-void
.end method

.method varargs t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 653
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "string"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 654
    if-nez v0, :cond_0

    .line 658
    :goto_0
    return-object p1

    .line 656
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

    .line 657
    :catch_0
    move-exception v1

    .line 658
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p1

    goto :goto_0
.end method
