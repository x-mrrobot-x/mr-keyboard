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

    .line 73
    new-instance v0, Lcom/mrkeyboard/app/MrPacksActivity$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrPacksActivity$1;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mRefresh:Ljava/lang/Runnable;

    .line 79
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

.method static synthetic access$1000(Lcom/mrkeyboard/app/MrPacksActivity;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 53
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mOpenId:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1002(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 53
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mOpenId:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->rebuild()V

    return-void
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->toast(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->fetchedModel()V

    return-void
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->showPack(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Pack;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->download(Lcom/mrkeyboard/app/MrPacks$Pack;)V

    return-void
.end method

.method static synthetic access$1600(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrPacksActivity;->confirmRemove(Ljava/lang/String;Ljava/lang/String;Z)V

    return-void
.end method

.method static synthetic access$1700(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->pickModelFile()V

    return-void
.end method

.method static synthetic access$1802(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 53
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mError:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1902(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 53
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mErrorId:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrPacksActivity;)Landroid/os/Handler;
    .locals 1

    .prologue
    .line 53
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$2000(Lcom/mrkeyboard/app/MrPacksActivity;)Z
    .locals 1

    .prologue
    .line 53
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->gestureOn()Z

    move-result v0

    return v0
.end method

.method static synthetic access$2100(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->openModel()V

    return-void
.end method

.method static synthetic access$2200(Lcom/mrkeyboard/app/MrPacksActivity;)Ljava/lang/Runnable;
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

.method static synthetic access$500(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrDiag$Report;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 53
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->memText(Lcom/mrkeyboard/app/MrDiag$Report;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/MrPacksActivity;)Landroid/preference/Preference;
    .locals 1

    .prologue
    .line 53
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    return-object v0
.end method

.method static synthetic access$702(Lcom/mrkeyboard/app/MrPacksActivity;Z)Z
    .locals 0

    .prologue
    .line 53
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    return p1
.end method

.method static synthetic access$802(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 53
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$902(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Catalog;)Lcom/mrkeyboard/app/MrPacks$Catalog;
    .locals 0

    .prologue
    .line 53
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    return-object p1
.end method

.method private askModel()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 594
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 595
    const-string v1, "mr_gesture_pack_title"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 596
    const-string v1, "mr_gesture_need_pack"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 597
    const-string v1, "mr_dicts_download"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$15;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrPacksActivity$15;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 603
    const-string v1, "mr_gesture_later"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 604
    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-nez v1, :cond_0

    .line 605
    const-string v1, "mr_gesture_from_file"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$16;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrPacksActivity$16;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 611
    :cond_0
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 612
    return-void
.end method

.method private buildGesture()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 515
    const-string v0, "mr_cat_gesture"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 516
    instance-of v1, v0, Landroid/preference/PreferenceGroup;

    if-nez v1, :cond_1

    .line 558
    :cond_0
    :goto_0
    return-void

    .line 517
    :cond_1
    check-cast v0, Landroid/preference/PreferenceGroup;

    .line 518
    new-instance v1, Landroid/preference/Preference;

    invoke-direct {v1, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGPack:Landroid/preference/Preference;

    .line 519
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGPack:Landroid/preference/Preference;

    invoke-virtual {v1, v4}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 520
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGPack:Landroid/preference/Preference;

    const-string v2, "mr_gesture_pack_title"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 521
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGPack:Landroid/preference/Preference;

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$13;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrPacksActivity$13;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v1, v2}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 527
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGPack:Landroid/preference/Preference;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceGroup;->addPreference(Landroid/preference/Preference;)Z

    .line 528
    new-instance v1, Landroid/preference/Preference;

    invoke-direct {v1, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    .line 529
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    invoke-virtual {v1, v4}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 530
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    invoke-virtual {v1, v4}, Landroid/preference/Preference;->setSelectable(Z)V

    .line 531
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->plain(Landroid/preference/Preference;)V

    .line 532
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    const-string v2, "mr_gesture_time_title"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 533
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceGroup;->addPreference(Landroid/preference/Preference;)Z

    .line 536
    new-instance v1, Landroid/preference/Preference;

    invoke-direct {v1, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGNotice:Landroid/preference/Preference;

    .line 537
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGNotice:Landroid/preference/Preference;

    invoke-virtual {v1, v4}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 538
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGNotice:Landroid/preference/Preference;

    const-string v2, "mr_gesture_notice_title"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 539
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGNotice:Landroid/preference/Preference;

    invoke-virtual {v1, v4}, Landroid/preference/Preference;->setSelectable(Z)V

    .line 540
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGNotice:Landroid/preference/Preference;

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->plain(Landroid/preference/Preference;)V

    .line 541
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGNotice:Landroid/preference/Preference;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceGroup;->addPreference(Landroid/preference/Preference;)Z

    .line 542
    const-string v0, "pref_gesture_typing"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 543
    if-eqz v0, :cond_0

    .line 544
    new-instance v1, Lcom/mrkeyboard/app/MrPacksActivity$14;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrPacksActivity$14;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceChangeListener(Landroid/preference/Preference$OnPreferenceChangeListener;)V

    goto/16 :goto_0
.end method

.method private check()V
    .locals 3

    .prologue
    .line 347
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    if-eqz v0, :cond_0

    .line 383
    :goto_0
    return-void

    .line 348
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    .line 349
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    .line 350
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->update()V

    .line 351
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 352
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$6;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity$6;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Landroid/content/Context;)V

    const-string v0, "MrPacksCheck"

    invoke-direct {v1, v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 382
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private checkState()Ljava/lang/CharSequence;
    .locals 7

    .prologue
    const/4 v6, 0x3

    const/4 v4, 0x1

    const/4 v5, 0x0

    .line 309
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mChecking:Z

    if-eqz v0, :cond_1

    const-string v0, "mr_dicts_checking"

    new-array v1, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 324
    :cond_0
    :goto_0
    return-object v0

    .line 310
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheckError:Ljava/lang/String;

    const-string v1, "mr_ui_rose"

    invoke-direct {p0, v0, v1, v4}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_0

    .line 311
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->checkedAt(Landroid/content/Context;)J

    move-result-wide v0

    .line 312
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_3

    const-string v0, "mr_dicts_check_never"

    new-array v1, v5, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 313
    :cond_3
    invoke-static {v6, v6}, Ljava/text/DateFormat;->getDateTimeInstance(II)Ljava/text/DateFormat;

    move-result-object v2

    new-instance v3, Ljava/util/Date;

    invoke-direct {v3, v0, v1}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v2, v3}, Ljava/text/DateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    .line 314
    const-string v1, "mr_dicts_check_last"

    new-array v2, v4, [Ljava/lang/Object;

    aput-object v0, v2, v5

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 315
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

    .line 316
    :cond_4
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrPacks;->updatesAvailable(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Catalog;)I

    move-result v2

    .line 317
    if-eqz v2, :cond_0

    .line 318
    new-instance v1, Landroid/text/SpannableStringBuilder;

    invoke-direct {v1, v0}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    .line 319
    const-string v0, " \u00b7 "

    invoke-virtual {v1, v0}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    .line 320
    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v3

    .line 321
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

    .line 322
    const-string v0, "mr_ui_blue"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->color(Ljava/lang/String;)I

    move-result v0

    .line 323
    if-eqz v0, :cond_5

    new-instance v2, Landroid/text/style/ForegroundColorSpan;

    invoke-direct {v2, v0}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v0

    const/16 v4, 0x21

    invoke-virtual {v1, v2, v3, v0, v4}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    :cond_5
    move-object v0, v1

    .line 324
    goto/16 :goto_0

    .line 321
    :cond_6
    const-string v0, "mr_dicts_updates_many"

    goto :goto_1
.end method

.method private color(Ljava/lang/String;)I
    .locals 3

    .prologue
    .line 260
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "color"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 261
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

    .line 492
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 493
    invoke-virtual {v1, p2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 494
    if-eqz p3, :cond_0

    const-string v0, "mr_gesture_remove_confirm"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {v1, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 495
    const-string v0, "mr_dicts_remove"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$12;

    invoke-direct {v2, p0, p3, p1}, Lcom/mrkeyboard/app/MrPacksActivity$12;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;ZLjava/lang/String;)V

    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 504
    const-string v0, "mr_dicts_close"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 505
    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 506
    return-void

    .line 494
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

    .line 392
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    .line 393
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v0, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 394
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 395
    if-eqz p2, :cond_2

    .line 396
    invoke-virtual {p2, v0}, Lcom/mrkeyboard/app/MrPacks$Pack;->description(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 397
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "\n\n"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 398
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

    .line 399
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

    .line 400
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

    .line 402
    :cond_2
    if-lez p3, :cond_4

    .line 403
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    if-lez v0, :cond_3

    const-string v0, "\n\n"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 404
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

    .line 406
    :cond_4
    new-instance v3, Landroid/app/AlertDialog$Builder;

    invoke-direct {v3, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 407
    invoke-virtual {v3, p4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 408
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 409
    if-eqz v1, :cond_7

    .line 410
    const-string v0, "mr_dicts_cancel"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$7;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrPacksActivity$7;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v3, v0, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 423
    :cond_5
    :goto_0
    if-lez p3, :cond_9

    if-nez v1, :cond_9

    .line 424
    const-string v0, "mr_dicts_remove"

    new-array v1, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/MrPacksActivity$9;

    invoke-direct {v1, p0, p1, p4, p5}, Lcom/mrkeyboard/app/MrPacksActivity$9;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;Ljava/lang/String;Z)V

    invoke-virtual {v3, v0, v1}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 436
    :cond_6
    :goto_1
    const-string v0, "mr_dicts_close"

    new-array v1, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v3, v0, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 437
    invoke-virtual {v3}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 438
    return-void

    .line 415
    :cond_7
    if-eqz p2, :cond_5

    iget v0, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    if-le v0, p3, :cond_5

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/MrPacks;->appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z

    move-result v0

    if-nez v0, :cond_5

    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-nez v0, :cond_5

    .line 416
    if-nez p3, :cond_8

    const-string v0, "mr_dicts_download"

    :goto_2
    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$8;

    invoke-direct {v2, p0, p2}, Lcom/mrkeyboard/app/MrPacksActivity$8;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    invoke-virtual {v3, v0, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    goto :goto_0

    :cond_8
    const-string v0, "mr_dicts_update"

    goto :goto_2

    .line 429
    :cond_9
    if-eqz p5, :cond_6

    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-nez v0, :cond_6

    .line 430
    const-string v0, "mr_gesture_from_file"

    new-array v1, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/MrPacksActivity$10;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrPacksActivity$10;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v3, v0, v1}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    goto :goto_1
.end method

.method private dirSize(Ljava/lang/String;IZ)J
    .locals 7

    .prologue
    .line 328
    if-eqz p3, :cond_0

    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrPacks;->modelDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;

    move-result-object v0

    :goto_0
    invoke-virtual {v0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v3

    .line 329
    const-wide/16 v0, 0x0

    .line 330
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

    .line 328
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrPacks;->packDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;

    move-result-object v0

    goto :goto_0

    .line 331
    :cond_1
    return-wide v0
.end method

.method private download(Lcom/mrkeyboard/app/MrPacks$Pack;)V
    .locals 4

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 441
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-nez v0, :cond_1

    .line 489
    :cond_0
    :goto_0
    return-void

    .line 442
    :cond_1
    iput-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mError:Ljava/lang/String;

    .line 443
    iput-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mErrorId:Ljava/lang/String;

    .line 444
    sput v1, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    .line 445
    sput-boolean v1, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 446
    iget-object v0, p1, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 447
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    .line 448
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    .line 449
    new-instance v2, Ljava/lang/Thread;

    new-instance v3, Lcom/mrkeyboard/app/MrPacksActivity$11;

    invoke-direct {v3, p0, v1, v0, p1}, Lcom/mrkeyboard/app/MrPacksActivity$11;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Catalog;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    const-string v0, "MrPacksInstall"

    invoke-direct {v2, v3, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 486
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    .line 487
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 488
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0
.end method

.method private fetchedModel()V
    .locals 6

    .prologue
    const/4 v4, 0x0

    .line 676
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    const-string v1, "gesture"

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrPacks$Catalog;->model(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v2

    .line 677
    :goto_0
    if-nez v2, :cond_1

    .line 678
    const-string v0, "mr_dicts_state_unavailable"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->toast(Ljava/lang/String;)V

    .line 686
    :goto_1
    return-void

    .line 676
    :cond_0
    const/4 v2, 0x0

    goto :goto_0

    .line 679
    :cond_1
    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrPacks;->appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 680
    const-string v0, "mr_gesture_err_app_old"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->toast(Ljava/lang/String;)V

    goto :goto_1

    .line 681
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-eqz v0, :cond_3

    .line 682
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

    .line 684
    :cond_3
    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->download(Lcom/mrkeyboard/app/MrPacks$Pack;)V

    goto :goto_1
.end method

.method private gestureOn()Z
    .locals 3

    .prologue
    .line 561
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "pref_gesture_typing"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method private gone()Z
    .locals 1

    .prologue
    .line 691
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
    .line 266
    const-string v0, " \u00b7 "

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    const/16 v0, 0x3a

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 267
    if-gez v1, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    .line 268
    :cond_0
    if-gez v0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 269
    :cond_1
    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    return v0
.end method

.method private hideQuickFixesIfUnsupported()V
    .locals 3

    .prologue
    .line 111
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getListView()Landroid/widget/ListView;

    move-result-object v0

    invoke-static {v0}, Landroid/text/AutoText;->getSize(Landroid/view/View;)I

    move-result v0

    const/4 v1, 0x1

    if-lt v0, v1, :cond_1

    .line 115
    :cond_0
    :goto_0
    return-void

    .line 112
    :cond_1
    const-string v0, "quick_fixes"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v1

    .line 113
    const-string v0, "mr_cat_suggestions"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 114
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
    .line 138
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

    .line 139
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

    .line 234
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 235
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

    .line 236
    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 237
    iget-boolean v1, p1, Lcom/mrkeyboard/app/MrDiag$Report;->hasTri:Z

    if-eqz v1, :cond_1

    .line 238
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

    .line 242
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

    .line 243
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

    .line 244
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 240
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
    .line 338
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-nez v0, :cond_0

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    .line 339
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mOpenId:Ljava/lang/String;

    .line 340
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->check()V

    .line 344
    :goto_0
    return-void

    .line 342
    :cond_0
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPacksActivity;->showPack(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private openModel()V
    .locals 6

    .prologue
    .line 584
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    const-string v1, "gesture"

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrPacks$Catalog;->model(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v2

    .line 585
    :goto_0
    if-nez v2, :cond_1

    const-string v0, "gesture"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->modelVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_1

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->askModel()V

    .line 587
    :goto_1
    return-void

    .line 584
    :cond_0
    const/4 v2, 0x0

    goto :goto_0

    .line 586
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

    .line 274
    if-nez p2, :cond_1

    move v0, v2

    .line 275
    :goto_0
    if-eqz v0, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_2

    .line 278
    :cond_0
    :goto_1
    return-object p1

    .line 274
    :cond_1
    invoke-direct {p0, p2}, Lcom/mrkeyboard/app/MrPacksActivity;->color(Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 276
    :cond_2
    new-instance v1, Landroid/text/SpannableString;

    invoke-direct {v1, p1}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    .line 277
    new-instance v3, Landroid/text/style/ForegroundColorSpan;

    invoke-direct {v3, v0}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    if-eqz p3, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    :goto_2
    const/16 v4, 0x21

    invoke-virtual {v1, v3, v2, v0, v4}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    move-object p1, v1

    .line 278
    goto :goto_1

    .line 277
    :cond_3
    invoke-static {p1}, Lcom/mrkeyboard/app/MrPacksActivity;->headEnd(Ljava/lang/String;)I

    move-result v0

    goto :goto_2
.end method

.method private pickModelFile()V
    .locals 2

    .prologue
    .line 616
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 617
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 618
    const-string v1, "*/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 620
    const/16 v1, 0x1ce9

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 624
    :goto_0
    return-void

    .line 621
    :catch_0
    move-exception v0

    .line 622
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
    .line 143
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "mr_ui_pref_row_static"

    const-string v2, "layout"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 144
    if-eqz v0, :cond_0

    invoke-virtual {p1, v0}, Landroid/preference/Preference;->setLayoutResource(I)V

    .line 145
    :cond_0
    return-void
.end method

.method private rebuild()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 149
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    if-nez v0, :cond_0

    .line 204
    :goto_0
    return-void

    .line 150
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    invoke-virtual {v0}, Landroid/preference/PreferenceCategory;->removeAll()V

    .line 151
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    .line 152
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 153
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

    .line 154
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v2, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 155
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->installedIds(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v2}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/mrkeyboard/app/MrPacks;->cardIds(Ljava/util/List;Ljava/util/List;Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v3

    .line 156
    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_2
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 157
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrPacks$Catalog;->find(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v1

    .line 158
    :goto_3
    new-instance v5, Landroid/preference/Preference;

    invoke-direct {v5, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    .line 159
    invoke-virtual {v5, v6}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 160
    if-eqz v1, :cond_3

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrPacks$Pack;->name(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    :goto_4
    invoke-virtual {v5, v1}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 161
    new-instance v1, Lcom/mrkeyboard/app/MrPacksActivity$3;

    invoke-direct {v1, p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity$3;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)V

    invoke-virtual {v5, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 167
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    invoke-virtual {v1, v5}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 168
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPackPrefs:Ljava/util/HashMap;

    invoke-virtual {v1, v0, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    .line 157
    :cond_2
    const/4 v1, 0x0

    goto :goto_3

    .line 160
    :cond_3
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->langName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_4

    .line 170
    :cond_4
    new-instance v0, Landroid/preference/Preference;

    invoke-direct {v0, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    .line 171
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    invoke-virtual {v0, v6}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 172
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    const-string v1, "mr_dicts_check"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 173
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    new-instance v1, Lcom/mrkeyboard/app/MrPacksActivity$4;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrPacksActivity$4;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 179
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 180
    new-instance v0, Landroid/preference/Preference;

    invoke-direct {v0, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    .line 181
    invoke-virtual {v0, v6}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 182
    invoke-virtual {v0, v6}, Landroid/preference/Preference;->setSelectable(Z)V

    .line 183
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->plain(Landroid/preference/Preference;)V

    .line 184
    const-string v1, "mr_dicts_langs_hint"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 185
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    invoke-virtual {v1, v0}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 187
    new-instance v1, Landroid/preference/Preference;

    invoke-direct {v1, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    .line 188
    invoke-virtual {v1, v6}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 189
    invoke-virtual {v1, v6}, Landroid/preference/Preference;->setSelectable(Z)V

    .line 190
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->plain(Landroid/preference/Preference;)V

    .line 191
    const-string v0, "mr_engine_title"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 192
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->ready()Z

    move-result v0

    if-eqz v0, :cond_5

    const-string v0, "mr_engine_native"

    :goto_5
    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 193
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 194
    new-instance v0, Landroid/preference/Preference;

    invoke-direct {v0, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    .line 195
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    invoke-virtual {v0, v6}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 196
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    invoke-virtual {v0, v6}, Landroid/preference/Preference;->setSelectable(Z)V

    .line 197
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->plain(Landroid/preference/Preference;)V

    .line 198
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    const-string v1, "mr_mem_title"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 199
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    const-string v1, "mr_mem_wait"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 200
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 201
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->refreshMem()V

    .line 202
    invoke-static {p0, v3}, Lcom/mrkeyboard/app/MrPacks;->syncLanguages(Landroid/content/Context;Ljava/util/List;)V

    .line 203
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->update()V

    goto/16 :goto_0

    .line 192
    :cond_5
    const-string v0, "mr_engine_missing"

    goto :goto_5
.end method

.method private refreshMem()V
    .locals 4

    .prologue
    .line 211
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mMem:Landroid/preference/Preference;

    .line 212
    invoke-static {}, Lcom/mrkeyboard/app/MrPacks;->activeDir()Ljava/io/File;

    move-result-object v1

    .line 213
    if-nez v0, :cond_0

    .line 230
    :goto_0
    return-void

    .line 214
    :cond_0
    if-nez v1, :cond_1

    .line 215
    const-string v1, "mr_mem_none"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 218
    :cond_1
    new-instance v2, Ljava/lang/Thread;

    new-instance v3, Lcom/mrkeyboard/app/MrPacksActivity$5;

    invoke-direct {v3, p0, v1, v0}, Lcom/mrkeyboard/app/MrPacksActivity$5;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/io/File;Landroid/preference/Preference;)V

    const-string v0, "MrDiag"

    invoke-direct {v2, v3, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 228
    const/4 v0, 0x1

    invoke-virtual {v2, v0}, Ljava/lang/Thread;->setPriority(I)V

    .line 229
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private showPack(Ljava/lang/String;)V
    .locals 6

    .prologue
    .line 386
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/MrPacks$Catalog;->find(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v2

    .line 387
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

    .line 388
    return-void

    .line 386
    :cond_0
    const/4 v2, 0x0

    goto :goto_0

    :cond_1
    move-object v4, p1

    .line 387
    goto :goto_1
.end method

.method private state(Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Pack;Z)Ljava/lang/CharSequence;
    .locals 8

    .prologue
    const/4 v5, 0x2

    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 286
    if-eqz p3, :cond_0

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->modelVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    .line 287
    :goto_0
    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 288
    sget-boolean v0, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    if-eqz v0, :cond_1

    const-string v0, "mr_dicts_state_installing"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 289
    :goto_1
    const-string v1, "mr_ui_amber"

    .line 288
    invoke-direct {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    .line 305
    :goto_2
    return-object v0

    .line 286
    :cond_0
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 289
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

    .line 291
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

    .line 292
    :cond_3
    if-eqz p2, :cond_4

    iget v1, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    if-le v1, v0, :cond_4

    move v1, v2

    .line 293
    :goto_3
    if-eqz v1, :cond_6

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/MrPacks;->appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 294
    if-lez v0, :cond_5

    .line 295
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mr_dicts_state_installed"

    new-array v5, v5, [Ljava/lang/Object;

    .line 294
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

    .line 295
    invoke-virtual {p0, v1, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_4
    const-string v1, "mr_ui_rose"

    .line 294
    invoke-direct {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->paint(Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_2

    :cond_4
    move v1, v3

    .line 292
    goto :goto_3

    .line 295
    :cond_5
    const-string v0, "mr_dicts_state_needs_app"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_4

    .line 297
    :cond_6
    if-lez v0, :cond_8

    .line 298
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

    .line 299
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

    .line 302
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

    .line 303
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

    .line 305
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
    .line 566
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->gestureOn()Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "mr_gesture_time_off"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 579
    :goto_0
    return-object v0

    .line 567
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

    .line 568
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

    .line 569
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

    .line 570
    :cond_3
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->stats()[J

    move-result-object v0

    .line 571
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

    .line 572
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

    .line 573
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

    .line 572
    invoke-virtual {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 576
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

    .line 577
    :cond_5
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureWords;->stats()[J

    move-result-object v0

    .line 578
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

    .line 579
    :cond_6
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0
.end method

.method private toast(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 695
    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {v0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 696
    :cond_0
    return-void
.end method

.method private update()V
    .locals 6

    .prologue
    const/4 v3, 0x0

    .line 249
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

    .line 250
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrPacks$Catalog;->find(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v1

    move-object v2, v1

    .line 251
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

    .line 250
    goto :goto_1

    .line 253
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCheck:Landroid/preference/Preference;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->checkState()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 254
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

    .line 255
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mGTime:Landroid/preference/Preference;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->timeText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 256
    :cond_5
    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 89
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/preference/PreferenceActivity;->attachBaseContext(Landroid/content/Context;)V

    .line 90
    return-void
.end method

.method msg(Lcom/mrkeyboard/app/MrPacks$PackException;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 699
    iget-object v0, p1, Lcom/mrkeyboard/app/MrPacks$PackException;->key:Ljava/lang/String;

    iget-object v1, p1, Lcom/mrkeyboard/app/MrPacks$PackException;->args:[Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 700
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

    .line 628
    invoke-super {p0, p1, p2, p3}, Landroid/preference/PreferenceActivity;->onActivityResult(IILandroid/content/Intent;)V

    .line 629
    const/16 v0, 0x1ce9

    if-ne p1, v0, :cond_0

    const/4 v0, -0x1

    if-ne p2, v0, :cond_0

    if-eqz p3, :cond_0

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    if-nez v0, :cond_1

    .line 672
    :cond_0
    :goto_0
    return-void

    .line 630
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 631
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    .line 632
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    .line 633
    iput-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mError:Ljava/lang/String;

    .line 634
    iput-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mErrorId:Ljava/lang/String;

    .line 635
    const/4 v2, 0x0

    sput v2, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    .line 636
    const/4 v2, 0x1

    sput-boolean v2, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 637
    const-string v2, "gesture"

    sput-object v2, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 638
    new-instance v2, Ljava/lang/Thread;

    new-instance v3, Lcom/mrkeyboard/app/MrPacksActivity$17;

    invoke-direct {v3, p0, v1, v0}, Lcom/mrkeyboard/app/MrPacksActivity$17;-><init>(Lcom/mrkeyboard/app/MrPacksActivity;Landroid/content/Context;Landroid/net/Uri;)V

    const-string v0, "MrModelFile"

    invoke-direct {v2, v3, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 669
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    .line 670
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 671
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4

    .prologue
    .line 94
    invoke-super {p0, p1}, Landroid/preference/PreferenceActivity;->onCreate(Landroid/os/Bundle;)V

    .line 95
    const-string v0, "mr_dicts_title"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->setTitle(Ljava/lang/CharSequence;)V

    .line 96
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "prefs_suggestions"

    const-string v2, "xml"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->addPreferencesFromResource(I)V

    .line 97
    invoke-static {p0}, Lcom/mrkeyboard/app/ListDividerFix;->apply(Landroid/preference/PreferenceActivity;)V

    .line 98
    const-string v0, "mr_cat_langs"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    check-cast v0, Landroid/preference/PreferenceCategory;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mLangs:Landroid/preference/PreferenceCategory;

    .line 99
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->hideQuickFixesIfUnsupported()V

    .line 100
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrGestureInput;->init(Landroid/content/Context;)V

    .line 101
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->buildGesture()V

    .line 102
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->cachedCatalog(Landroid/content/Context;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mCat:Lcom/mrkeyboard/app/MrPacks$Catalog;

    .line 103
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->rebuild()V

    .line 104
    return-void
.end method

.method protected onPause()V
    .locals 2

    .prologue
    .line 129
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 130
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mRefresh:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 131
    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onPause()V

    .line 132
    return-void
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 119
    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onResume()V

    .line 120
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->rebuild()V

    .line 121
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 122
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 123
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 125
    :cond_0
    return-void
.end method

.method varargs t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 704
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "string"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 705
    if-nez v0, :cond_0

    .line 709
    :goto_0
    return-object p1

    .line 707
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

    .line 708
    :catch_0
    move-exception v1

    .line 709
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPacksActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p1

    goto :goto_0
.end method
