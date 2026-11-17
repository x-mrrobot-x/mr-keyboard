.class public Lcom/mrkeyboard/app/MrImportActivity;
.super Landroid/app/Activity;
.source "MrImportActivity.java"


# static fields
.field static final EXTRA_APP:Ljava/lang/String; = "mr_words_app"

.field static final EXTRA_LOCALE:Ljava/lang/String; = "mr_words_locale"

.field private static final PREFS:Ljava/lang/String; = "mr_words"

.field static final PREVIEW_PAGE:I = 0x64

.field private static final P_APP:Ljava/lang/String; = "last_app"

.field private static final P_BATCH:Ljava/lang/String; = "last_batch"

.field private static final P_COUNT:Ljava/lang/String; = "last_count"

.field private static final P_LOCALE:Ljava/lang/String; = "last_locale"

.field private static final SAVE_TEXT_MAX:I = 0x186a0

.field private static final S_APP:Ljava/lang/String; = "mr_import_s_app"

.field private static final S_LOCALE:Ljava/lang/String; = "mr_import_s_locale"

.field private static final S_TEXT:Ljava/lang/String; = "mr_import_s_text"


# instance fields
.field private k:Lcom/mrkeyboard/app/MrKit;

.field private mAiButton:Landroid/widget/TextView;

.field private mAiCancel:Landroid/widget/TextView;

.field private volatile mAiCancelled:Z

.field private mAiNote:Landroid/widget/TextView;

.field private mAiPrimary:Ljava/lang/Boolean;

.field private mAnalyze:Landroid/widget/TextView;

.field private mApp:Ljava/lang/String;

.field private mAppBox:Landroid/widget/LinearLayout;

.field private mAppNote:Landroid/widget/TextView;

.field private mApply:Landroid/widget/TextView;

.field private mBusy:Z

.field private mCount:Landroid/widget/TextView;

.field private mLangBox:Landroid/widget/LinearLayout;

.field private mLangs:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mLocale:Ljava/lang/String;

.field private mMoreWords:Landroid/widget/TextView;

.field private mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

.field private mPreview:Landroid/widget/LinearLayout;

.field private mPreviewDialog:Landroid/app/AlertDialog;

.field private mSetting:Z

.field private mShown:I

.field private mStatus:Landroid/widget/TextView;

.field private mStore:Lcom/mrkeyboard/app/MrWordStore;

.field private mText:Landroid/widget/EditText;

.field private mUndo:Landroid/widget/TextView;

.field private mWordBox:Landroid/widget/LinearLayout;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 43
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 65
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->updateCount()V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshOffer()V

    return-void
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->undoLast()V

    return-void
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/MrImportActivity;)Z
    .locals 1

    .prologue
    .line 43
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    return v0
.end method

.method static synthetic access$1202(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 43
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/content/SharedPreferences;
    .locals 1

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshLanguages()V

    return-void
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->chooseApp()V

    return-void
.end method

.method static synthetic access$1600(Lcom/mrkeyboard/app/MrImportActivity;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 43
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1602(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 43
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1700(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshApp()V

    return-void
.end method

.method static synthetic access$1800(Lcom/mrkeyboard/app/MrImportActivity;ZLjava/lang/String;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    return-void
.end method

.method static synthetic access$1900(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;
    .locals 1

    .prologue
    .line 43
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    return-object v0
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrImportActivity;)Z
    .locals 1

    .prologue
    .line 43
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mSetting:Z

    return v0
.end method

.method static synthetic access$2002(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImport$Plan;)Lcom/mrkeyboard/app/MrImport$Plan;
    .locals 0

    .prologue
    .line 43
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    return-object p1
.end method

.method static synthetic access$2100(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->showPreview()V

    return-void
.end method

.method static synthetic access$2200(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->showIgnored()V

    return-void
.end method

.method static synthetic access$2300(Lcom/mrkeyboard/app/MrImportActivity;Z)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->tickAll(Z)V

    return-void
.end method

.method static synthetic access$2400(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->drawWords()V

    return-void
.end method

.method static synthetic access$2500(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->apply()V

    return-void
.end method

.method static synthetic access$2600(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/LinearLayout;
    .locals 1

    .prologue
    .line 43
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method static synthetic access$2602(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/LinearLayout;)Landroid/widget/LinearLayout;
    .locals 0

    .prologue
    .line 43
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    return-object p1
.end method

.method static synthetic access$2702(Lcom/mrkeyboard/app/MrImportActivity;Landroid/app/AlertDialog;)Landroid/app/AlertDialog;
    .locals 0

    .prologue
    .line 43
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreviewDialog:Landroid/app/AlertDialog;

    return-object p1
.end method

.method static synthetic access$2802(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/LinearLayout;)Landroid/widget/LinearLayout;
    .locals 0

    .prologue
    .line 43
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    return-object p1
.end method

.method static synthetic access$2902(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/TextView;)Landroid/widget/TextView;
    .locals 0

    .prologue
    .line 43
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mMoreWords:Landroid/widget/TextView;

    return-object p1
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->hideAiNote()V

    return-void
.end method

.method static synthetic access$3002(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/TextView;)Landroid/widget/TextView;
    .locals 0

    .prologue
    .line 43
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    return-object p1
.end method

.method static synthetic access$3100(Lcom/mrkeyboard/app/MrImport$NewWord;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 43
    invoke-static {p0}, Lcom/mrkeyboard/app/MrImportActivity;->mark(Lcom/mrkeyboard/app/MrImport$NewWord;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$3200(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->updateApply()V

    return-void
.end method

.method static synthetic access$3300(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrImportActivity;->remember(Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$3400(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/MrImportActivity;->report(Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$3500(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 43
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$3600(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshUndo()V

    return-void
.end method

.method static synthetic access$3700(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->askToSend(Lcom/mrkeyboard/app/MrImportAi$Plan;)V

    return-void
.end method

.method static synthetic access$3800(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->runAi(Lcom/mrkeyboard/app/MrImportAi$Plan;)V

    return-void
.end method

.method static synthetic access$3900(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/TextView;
    .locals 1

    .prologue
    .line 43
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->clearPreview()V

    return-void
.end method

.method static synthetic access$4000(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Result;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->finishAi(Lcom/mrkeyboard/app/MrImportAi$Result;)V

    return-void
.end method

.method static synthetic access$4100(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrWordStore;
    .locals 1

    .prologue
    .line 43
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    return-object v0
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->formatTapped()V

    return-void
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->analyze()V

    return-void
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/MrImportActivity;)Z
    .locals 1

    .prologue
    .line 43
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancelled:Z

    return v0
.end method

.method static synthetic access$702(Lcom/mrkeyboard/app/MrImportActivity;Z)Z
    .locals 0

    .prologue
    .line 43
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancelled:Z

    return p1
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/TextView;
    .locals 1

    .prologue
    .line 43
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->copyPrompt()V

    return-void
.end method

.method private analyze()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 386
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-eqz v0, :cond_0

    .line 442
    :goto_0
    return-void

    .line 387
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->source()Ljava/lang/String;

    move-result-object v0

    .line 388
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 389
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_nothing"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 392
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 393
    invoke-static {v0}, Lcom/mrkeyboard/app/MrImport;->isStandard(Ljava/lang/String;)Z

    move-result v2

    .line 394
    const/4 v3, 0x1

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_working"

    new-array v6, v6, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 395
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->clearPreview()V

    .line 396
    new-instance v3, Ljava/lang/Thread;

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$12;

    invoke-direct {v4, p0, v1, v2, v0}, Lcom/mrkeyboard/app/MrImportActivity$12;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;ZLjava/lang/String;)V

    invoke-direct {v3, v4}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 441
    invoke-virtual {v3}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private appName()Ljava/lang/String;
    .locals 3

    .prologue
    .line 290
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_app_all"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrAppList;->label(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private apply()V
    .locals 8

    .prologue
    .line 667
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    if-nez v0, :cond_1

    .line 701
    :cond_0
    :goto_0
    return-void

    .line 668
    :cond_1
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 669
    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 670
    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    .line 671
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    .line 672
    const/4 v0, 0x1

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_import_saving"

    const/4 v7, 0x0

    new-array v7, v7, [Ljava/lang/Object;

    invoke-virtual {v1, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 673
    new-instance v6, Ljava/lang/Thread;

    new-instance v0, Lcom/mrkeyboard/app/MrImportActivity$20;

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrImportActivity$20;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrWordStore;Lcom/mrkeyboard/app/MrImport$Plan;Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {v6, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 700
    invoke-virtual {v6}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private applyAny()Z
    .locals 2

    .prologue
    .line 633
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImport$Plan;->checkedWords()I

    move-result v0

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->pairsToAdd()I

    move-result v1

    add-int/2addr v0, v1

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->blockedCount(Lcom/mrkeyboard/app/MrImport$Plan;)I

    move-result v1

    add-int/2addr v0, v1

    if-lez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private applyLabel()Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 627
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImport$Plan;->checkedWords()I

    move-result v0

    .line 628
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->pairsToAdd()I

    move-result v1

    .line 629
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->applyAny()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_apply"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v4, v5

    const/4 v0, 0x1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v4, v0

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_import_apply_none"

    new-array v2, v5, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private askToSend(Lcom/mrkeyboard/app/MrImportAi$Plan;)V
    .locals 8

    .prologue
    const/4 v5, 0x2

    const/4 v7, 0x1

    const/4 v6, 0x0

    .line 783
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->serviceHost(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 784
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_import_ai_your_service"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 785
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_ai_ask_text"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    aput-object v0, v4, v6

    iget v0, p1, Lcom/mrkeyboard/app/MrImportAi$Plan;->chars:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v4, v7

    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrImportAi$Plan;->requests()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v4, v5

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 786
    iget-boolean v0, p1, Lcom/mrkeyboard/app/MrImportAi$Plan;->truncated:Z

    if-eqz v0, :cond_1

    const-string v0, "\n\n"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_ai_ask_cut"

    new-array v4, v5, [Ljava/lang/Object;

    iget v5, p1, Lcom/mrkeyboard/app/MrImportAi$Plan;->chars:I

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v6

    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrImportAi$Plan;->requests()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v7

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 787
    :cond_1
    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrImportAi$Plan;->requests()I

    move-result v0

    const/16 v2, 0xc

    if-le v0, v2, :cond_2

    const-string v0, "\n\n"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_ai_ask_many"

    new-array v4, v7, [Ljava/lang/Object;

    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrImportAi$Plan;->requests()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v6

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 788
    :cond_2
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_ai_ask_title"

    new-array v4, v6, [Ljava/lang/Object;

    .line 789
    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 790
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_dont"

    new-array v3, v6, [Ljava/lang/Object;

    .line 791
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_send"

    new-array v3, v6, [Ljava/lang/Object;

    .line 792
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$23;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/MrImportActivity$23;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 797
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 798
    return-void
.end method

.method private blockedCount(Lcom/mrkeyboard/app/MrImport$Plan;)I
    .locals 1

    .prologue
    .line 638
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p1, Lcom/mrkeyboard/app/MrImport$Plan;->blocked:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private chooseApp()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 309
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-eqz v0, :cond_0

    .line 324
    :goto_0
    return-void

    .line 310
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_app_card_title"

    new-array v4, v5, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_app_none_installed"

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$10;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$10;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    new-instance v5, Lcom/mrkeyboard/app/MrImportActivity$11;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrImportActivity$11;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrAppPicker;->show(Lcom/mrkeyboard/app/MrKit;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/MrAppPicker$Source;Lcom/mrkeyboard/app/MrAppPicker$Pick;)Lcom/mrkeyboard/app/MrAppPicker;

    goto :goto_0
.end method

.method private clearPreview()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 448
    iput-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 449
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    .line 450
    iput-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    .line 451
    iput-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    .line 452
    iput-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mMoreWords:Landroid/widget/TextView;

    .line 453
    iput-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    .line 454
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->dismissPreview()V

    .line 455
    return-void
.end method

.method private copyPrompt()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 352
    :try_start_0
    const-string v0, "clipboard"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/ClipboardManager;

    .line 353
    const-string v1, "Mr Keyboard"

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_prompt"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/content/ClipData;->newPlainText(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/content/ClipData;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/ClipboardManager;->setPrimaryClip(Landroid/content/ClipData;)V

    .line 354
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_copied"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 358
    :goto_0
    return-void

    .line 355
    :catch_0
    move-exception v0

    .line 356
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_clip_empty"

    new-array v3, v5, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private dismissPreview()V
    .locals 2

    .prologue
    .line 458
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreviewDialog:Landroid/app/AlertDialog;

    .line 459
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreviewDialog:Landroid/app/AlertDialog;

    .line 460
    if-nez v0, :cond_0

    .line 466
    :goto_0
    return-void

    .line 462
    :cond_0
    :try_start_0
    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 463
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private drawWords()V
    .locals 9

    .prologue
    const/4 v2, 0x0

    .line 581
    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 582
    if-eqz v4, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    if-nez v0, :cond_1

    .line 598
    :cond_0
    :goto_0
    return-void

    .line 583
    :cond_1
    iget-object v0, v4, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    iget v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    add-int/lit8 v1, v1, 0x64

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 584
    iget v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    move v3, v0

    :goto_1
    if-ge v3, v5, :cond_4

    .line 585
    iget-object v0, v4, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrImport$NewWord;

    .line 586
    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->mark(Lcom/mrkeyboard/app/MrImport$NewWord;)Ljava/lang/String;

    move-result-object v7

    iget-boolean v1, v4, Lcom/mrkeyboard/app/MrImport$Plan;->standard:Z

    if-eqz v1, :cond_2

    iget v1, v0, Lcom/mrkeyboard/app/MrImport$NewWord;->weight:I

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    :goto_2
    const/4 v8, 0x0

    invoke-virtual {v6, v7, v1, v8}, Lcom/mrkeyboard/app/MrKit;->item(Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v1

    .line 587
    new-instance v6, Lcom/mrkeyboard/app/MrImportActivity$19;

    invoke-direct {v6, p0, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity$19;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImport$NewWord;Landroid/widget/LinearLayout;)V

    invoke-virtual {v1, v6}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 594
    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    if-nez v3, :cond_3

    move v0, v2

    :goto_3
    invoke-virtual {v7, v0}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v6, v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 584
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_1

    .line 586
    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "\u00d7"

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v8, v0, Lcom/mrkeyboard/app/MrImport$NewWord;->count:I

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    .line 594
    :cond_3
    const/4 v0, 0x6

    goto :goto_3

    .line 596
    :cond_4
    iput v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    .line 597
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mMoreWords:Landroid/widget/TextView;

    iget v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    iget-object v3, v4, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v1, v3, :cond_5

    :goto_4
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0

    :cond_5
    const/16 v2, 0x8

    goto :goto_4
.end method

.method private failureText(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 854
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_ai_net_fail"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    :cond_1
    return-object p1
.end method

.method private finishAi(Lcom/mrkeyboard/app/MrImportAi$Result;)V
    .locals 10

    .prologue
    const/4 v9, 0x2

    const/4 v8, 0x1

    const/4 v7, 0x0

    const/4 v6, 0x0

    .line 858
    invoke-direct {p0, v6, v7}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 859
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 860
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrImportActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 886
    :cond_0
    :goto_0
    return-void

    .line 861
    :cond_1
    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrImportAi$Result;->empty()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 863
    iget-object v0, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->failure:Ljava/lang/String;

    if-eqz v0, :cond_2

    .line 864
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_fail_title"

    new-array v3, v6, [Ljava/lang/Object;

    .line 865
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->failure:Ljava/lang/String;

    .line 866
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->failureText(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_ok"

    new-array v3, v6, [Ljava/lang/Object;

    .line 867
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v7}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 868
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0

    .line 870
    :cond_2
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-boolean v0, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->cancelled:Z

    if-eqz v0, :cond_3

    const-string v0, "mr_import_ai_cancelled"

    :goto_1
    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {v2, v0, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    const-string v0, "mr_import_ai_back_nothing"

    goto :goto_1

    .line 874
    :cond_4
    iget-object v0, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->text:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->setBox(Ljava/lang/String;)V

    .line 875
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->clearPreview()V

    .line 876
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_done"

    new-array v3, v9, [Ljava/lang/Object;

    iget v4, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->words:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v6

    iget v4, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->phrases:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v8

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 877
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    .line 878
    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrImportAi$Result;->complete()Z

    move-result v0

    if-nez v0, :cond_0

    .line 879
    iget-object v0, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->failure:Ljava/lang/String;

    if-eqz v0, :cond_5

    iget-object v0, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->failure:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->failureText(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 880
    :goto_2
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_ai_partial_title"

    new-array v4, v6, [Ljava/lang/Object;

    .line 881
    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_ai_partial"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    iget v5, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->done:I

    .line 882
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v6

    iget v5, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->parts:I

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v8

    aput-object v0, v4, v9

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_ok"

    new-array v3, v6, [Ljava/lang/Object;

    .line 883
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v7}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 884
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto/16 :goto_0

    .line 879
    :cond_5
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-boolean v0, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->cancelled:Z

    if-eqz v0, :cond_6

    const-string v0, "mr_import_ai_why_cancel"

    :goto_3
    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    :cond_6
    const-string v0, "mr_import_ai_why_unreadable"

    goto :goto_3
.end method

.method private formatTapped()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 723
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-eqz v0, :cond_0

    .line 751
    :goto_0
    return-void

    .line 724
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->source()Ljava/lang/String;

    move-result-object v0

    .line 725
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 726
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_nothing"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 729
    :cond_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrImport;->isStandard(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 730
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_already"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 733
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->configured(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 734
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_nokey_title"

    new-array v3, v4, [Ljava/lang/Object;

    .line 735
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_nokey_text"

    new-array v3, v4, [Ljava/lang/Object;

    .line 736
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_cancel"

    new-array v3, v4, [Ljava/lang/Object;

    .line 737
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_nokey_open"

    new-array v3, v4, [Ljava/lang/Object;

    .line 738
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$21;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrImportActivity$21;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 747
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto/16 :goto_0

    .line 750
    :cond_3
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->prepareAi(Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method private hideAiNote()V
    .locals 2

    .prologue
    .line 889
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    if-nez v0, :cond_0

    .line 891
    :goto_0
    return-void

    .line 890
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0
.end method

.method private loadLanguages()V
    .locals 4

    .prologue
    .line 265
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    invoke-interface {v0}, Lcom/mrkeyboard/app/MrWordStore;->locales()Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 269
    :goto_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->installedIds(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrLang;->offered(Ljava/util/List;Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    .line 270
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrLang;->last(Landroid/content/SharedPreferences;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrImportActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v3

    iget-object v3, v3, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v3}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrLang;->pick(Ljava/util/List;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 271
    return-void

    .line 266
    :catch_0
    move-exception v0

    .line 267
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    goto :goto_0
.end method

.method private static mark(Lcom/mrkeyboard/app/MrImport$NewWord;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 601
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImport$NewWord;->checked:Z

    if-eqz v0, :cond_0

    const-string v0, "\u2713  "

    :goto_0
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImport$NewWord;->word:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const-string v0, "\u25cb  "

    goto :goto_0
.end method

.method private pairsToAdd()I
    .locals 5

    .prologue
    .line 616
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 617
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    .line 618
    iget-object v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_0
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrImport$NewWord;

    iget-boolean v4, v0, Lcom/mrkeyboard/app/MrImport$NewWord;->checked:Z

    if-nez v4, :cond_0

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImport$NewWord;->word:Ljava/lang/String;

    invoke-virtual {v2, v0}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 619
    :cond_1
    invoke-virtual {v2}, Ljava/util/HashSet;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->pairs:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    .line 622
    :cond_2
    return v1

    .line 620
    :cond_3
    const/4 v0, 0x0

    .line 621
    iget-object v1, v1, Lcom/mrkeyboard/app/MrImport$Plan;->pairs:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    move v1, v0

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrImport$NewPair;

    iget-object v4, v0, Lcom/mrkeyboard/app/MrImport$NewPair;->a:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_4

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImport$NewPair;->b:Ljava/lang/String;

    invoke-virtual {v2, v0}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    add-int/lit8 v1, v1, 0x1

    move v0, v1

    :goto_2
    move v1, v0

    goto :goto_1

    :cond_4
    move v0, v1

    goto :goto_2
.end method

.method private prefs()Landroid/content/SharedPreferences;
    .locals 2

    .prologue
    .line 896
    const-string v0, "mr_words"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method private prepareAi(Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 755
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-eqz v0, :cond_0

    .line 779
    :goto_0
    return-void

    .line 756
    :cond_0
    const/4 v0, 0x1

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_preparing"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 757
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/mrkeyboard/app/MrImportActivity$22;

    invoke-direct {v1, p0, p1}, Lcom/mrkeyboard/app/MrImportActivity$22;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 778
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private refreshApp()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 295
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAppBox:Landroid/widget/LinearLayout;

    if-nez v0, :cond_0

    .line 305
    :goto_0
    return-void

    .line 296
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->appName()Ljava/lang/String;

    move-result-object v1

    .line 297
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    if-nez v0, :cond_1

    const/4 v0, 0x0

    .line 298
    :goto_1
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAppBox:Landroid/widget/LinearLayout;

    invoke-virtual {v2}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 299
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAppBox:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, ""

    new-instance v5, Lcom/mrkeyboard/app/MrImportActivity$9;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrImportActivity$9;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v3, v4, v1, v0, v5}, Lcom/mrkeyboard/app/MrKit;->select(Ljava/lang/String;Ljava/lang/String;Landroid/graphics/drawable/Drawable;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 303
    invoke-virtual {v3, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 299
    invoke-virtual {v2, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 304
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAppNote:Landroid/widget/TextView;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_app_note_all"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_2
    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 297
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrAppList;->icon(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    goto :goto_1

    .line 304
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_app_note"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    aput-object v1, v4, v6

    invoke-virtual {v0, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_2
.end method

.method private refreshLanguages()V
    .locals 6

    .prologue
    .line 274
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangBox:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$8;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$8;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v5}, Lcom/mrkeyboard/app/MrKit;->languageCard(Landroid/widget/LinearLayout;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/MrKit$LangPick;Z)V

    .line 284
    return-void
.end method

.method private refreshOffer()V
    .locals 7

    .prologue
    const/16 v3, 0x8

    const/4 v4, 0x1

    const/4 v2, 0x0

    .line 338
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiButton:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAnalyze:Landroid/widget/TextView;

    if-nez v0, :cond_1

    .line 348
    :cond_0
    :goto_0
    return-void

    .line 339
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    if-nez v0, :cond_5

    const/4 v0, 0x0

    .line 340
    :goto_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrImport;->offer(Ljava/lang/String;)I

    move-result v5

    .line 341
    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiButton:Landroid/widget/TextView;

    if-ne v5, v4, :cond_6

    move v1, v2

    :goto_2
    invoke-virtual {v6, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 342
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAnalyze:Landroid/widget/TextView;

    const/4 v6, 0x2

    if-ne v5, v6, :cond_2

    move v3, v2

    :cond_2
    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    .line 343
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_3

    move v2, v4

    .line 344
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiPrimary:Ljava/lang/Boolean;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiPrimary:Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eq v0, v2, :cond_0

    .line 345
    :cond_4
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiPrimary:Ljava/lang/Boolean;

    .line 346
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiButton:Landroid/widget/TextView;

    if-eqz v2, :cond_7

    const-string v0, "mr_ui_ic_wand_on"

    :goto_3
    invoke-virtual {v1, v3, v2, v0}, Lcom/mrkeyboard/app/MrKit;->restyleIconButton(Landroid/widget/TextView;ZLjava/lang/String;)V

    goto :goto_0

    .line 339
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_6
    move v1, v3

    .line 341
    goto :goto_2

    .line 346
    :cond_7
    const-string v0, "mr_ui_ic_wand"

    goto :goto_3
.end method

.method private refreshUndo()V
    .locals 7

    .prologue
    const-wide/16 v2, 0x0

    const/4 v6, 0x0

    .line 908
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "last_batch"

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    .line 909
    cmp-long v0, v0, v2

    if-gtz v0, :cond_0

    .line 910
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 915
    :goto_0
    return-void

    .line 913
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_undo"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v4

    const-string v5, "last_count"

    invoke-interface {v4, v5, v6}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v6

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 914
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0
.end method

.method private remember(Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 900
    iget-wide v0, p1, Lcom/mrkeyboard/app/MrLearned$Result;->batch:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    iget v0, p1, Lcom/mrkeyboard/app/MrLearned$Result;->words:I

    iget v1, p1, Lcom/mrkeyboard/app/MrLearned$Result;->pairs:I

    add-int/2addr v0, v1

    if-nez v0, :cond_1

    .line 905
    :cond_0
    :goto_0
    return-void

    .line 901
    :cond_1
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "last_batch"

    iget-wide v2, p1, Lcom/mrkeyboard/app/MrLearned$Result;->batch:J

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "last_locale"

    invoke-interface {v0, v1, p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "last_count"

    iget v2, p1, Lcom/mrkeyboard/app/MrLearned$Result;->words:I

    iget v3, p1, Lcom/mrkeyboard/app/MrLearned$Result;->pairs:I

    add-int/2addr v2, v3

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 902
    if-eqz p3, :cond_2

    const-string v1, "last_app"

    invoke-interface {v0, v1, p3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 904
    :goto_1
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    goto :goto_0

    .line 903
    :cond_2
    const-string v1, "last_app"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    goto :goto_1
.end method

.method private report(Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;)V
    .locals 9

    .prologue
    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 704
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 705
    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrLearned$Result;->total()I

    move-result v1

    if-nez v1, :cond_5

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_added_none"

    new-array v3, v7, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 707
    :goto_0
    if-eqz p2, :cond_0

    iget v1, p1, Lcom/mrkeyboard/app/MrLearned$Result;->words:I

    iget v2, p1, Lcom/mrkeyboard/app/MrLearned$Result;->pairs:I

    add-int/2addr v1, v2

    if-lez v1, :cond_0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_added_app"

    new-array v4, v8, [Ljava/lang/Object;

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/MrAppList;->label(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v7

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 708
    :cond_0
    iget v1, p1, Lcom/mrkeyboard/app/MrLearned$Result;->blocked:I

    if-lez v1, :cond_1

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_added_blocked"

    new-array v4, v8, [Ljava/lang/Object;

    iget v5, p1, Lcom/mrkeyboard/app/MrLearned$Result;->blocked:I

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v7

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 709
    :cond_1
    iget v1, p1, Lcom/mrkeyboard/app/MrLearned$Result;->dupWords:I

    iget v2, p1, Lcom/mrkeyboard/app/MrLearned$Result;->dupPairs:I

    add-int/2addr v1, v2

    if-lez v1, :cond_2

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_dups"

    new-array v4, v8, [Ljava/lang/Object;

    iget v5, p1, Lcom/mrkeyboard/app/MrLearned$Result;->dupWords:I

    iget v6, p1, Lcom/mrkeyboard/app/MrLearned$Result;->dupPairs:I

    add-int/2addr v5, v6

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v7

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 710
    :cond_2
    iget v1, p1, Lcom/mrkeyboard/app/MrLearned$Result;->cappedWords:I

    iget v2, p1, Lcom/mrkeyboard/app/MrLearned$Result;->cappedPairs:I

    add-int/2addr v1, v2

    if-lez v1, :cond_3

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_capped"

    new-array v4, v8, [Ljava/lang/Object;

    iget v5, p1, Lcom/mrkeyboard/app/MrLearned$Result;->cappedWords:I

    iget v6, p1, Lcom/mrkeyboard/app/MrLearned$Result;->cappedPairs:I

    add-int/2addr v5, v6

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v7

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 711
    :cond_3
    iget v1, p1, Lcom/mrkeyboard/app/MrLearned$Result;->blockedSkipped:I

    if-lez v1, :cond_4

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_blocked_skipped"

    new-array v4, v8, [Ljava/lang/Object;

    iget v5, p1, Lcom/mrkeyboard/app/MrLearned$Result;->blockedSkipped:I

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v7

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 712
    :cond_4
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_done_title"

    new-array v4, v7, [Ljava/lang/Object;

    .line 713
    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 714
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_ok"

    new-array v3, v7, [Ljava/lang/Object;

    .line 715
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 716
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 717
    return-void

    .line 706
    :cond_5
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_added"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    iget v4, p1, Lcom/mrkeyboard/app/MrLearned$Result;->words:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v7

    iget v4, p1, Lcom/mrkeyboard/app/MrLearned$Result;->pairs:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v8

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto/16 :goto_0
.end method

.method private runAi(Lcom/mrkeyboard/app/MrImportAi$Plan;)V
    .locals 7

    .prologue
    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 801
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-eqz v0, :cond_0

    .line 851
    :goto_0
    return-void

    .line 802
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->tag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 803
    iput-boolean v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancelled:Z

    .line 804
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_import_ai_progress"

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v5

    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrImportAi$Plan;->requests()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v6

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v6, v0}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 805
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setVisibility(I)V

    .line 806
    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$24;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$24;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 815
    new-instance v5, Lcom/mrkeyboard/app/MrImportActivity$25;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrImportActivity$25;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 829
    new-instance v6, Ljava/lang/Thread;

    new-instance v0, Lcom/mrkeyboard/app/MrImportActivity$26;

    move-object v1, p0

    move-object v2, p1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrImportActivity$26;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;Ljava/lang/String;Lcom/mrkeyboard/app/MrImportAi$Sender;Lcom/mrkeyboard/app/MrImportAi$Control;)V

    invoke-direct {v6, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 850
    invoke-virtual {v6}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private setBox(Ljava/lang/String;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 361
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mSetting:Z

    .line 363
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 365
    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mSetting:Z

    .line 367
    return-void

    .line 365
    :catchall_0
    move-exception v0

    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mSetting:Z

    .line 366
    throw v0
.end method

.method private setBusy(ZLjava/lang/String;)V
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 377
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    .line 378
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAnalyze:Landroid/widget/TextView;

    if-nez p1, :cond_1

    move v0, v1

    :goto_0
    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setClickable(Z)V

    .line 379
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiButton:Landroid/widget/TextView;

    if-nez p1, :cond_2

    move v0, v1

    :goto_1
    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setClickable(Z)V

    .line 380
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    if-nez p1, :cond_3

    :goto_2
    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setEnabled(Z)V

    .line 381
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    if-nez p2, :cond_0

    const-string p2, ""

    :cond_0
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 382
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    if-eqz p1, :cond_4

    :goto_3
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 383
    return-void

    :cond_1
    move v0, v2

    .line 378
    goto :goto_0

    :cond_2
    move v0, v2

    .line 379
    goto :goto_1

    :cond_3
    move v1, v2

    .line 380
    goto :goto_2

    .line 382
    :cond_4
    const/16 v2, 0x8

    goto :goto_3
.end method

.method private showIgnored()V
    .locals 10

    .prologue
    const/4 v9, 0x1

    const/4 v8, 0x0

    .line 648
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 649
    if-nez v1, :cond_0

    .line 662
    :goto_0
    return-void

    .line 650
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 651
    iget-object v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignored:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrImport$Ignored;

    .line 652
    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_line"

    new-array v6, v9, [Ljava/lang/Object;

    iget v7, v0, Lcom/mrkeyboard/app/MrImport$Ignored;->line:I

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v6, v8

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ": "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v0, Lcom/mrkeyboard/app/MrImport$Ignored;->text:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\n   \u2192 "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "mr_import_why_"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v0, v0, Lcom/mrkeyboard/app/MrImport$Ignored;->reason:I

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v6, v8, [Ljava/lang/Object;

    invoke-virtual {v5, v0, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, "\n"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 654
    :cond_1
    iget v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    iget-object v3, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignored:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-le v0, v3, :cond_2

    .line 655
    const-string v0, "\n"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_ignored_more"

    new-array v5, v9, [Ljava/lang/Object;

    iget v6, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    iget-object v7, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignored:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v7

    sub-int/2addr v6, v7

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v8

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 657
    :cond_2
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_see_ignored"

    new-array v5, v9, [Ljava/lang/Object;

    iget v1, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    .line 658
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v5, v8

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 659
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_ok"

    new-array v3, v8, [Ljava/lang/Object;

    .line 660
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 661
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto/16 :goto_0
.end method

.method private showPreview()V
    .locals 15

    .prologue
    const/16 v14, 0xc

    const/high16 v13, 0x3f800000    # 1.0f

    const/4 v2, 0x1

    const/4 v12, -0x2

    const/4 v3, 0x0

    .line 473
    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 474
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v5

    .line 475
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v1, 0x41a00000    # 20.0f

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41000000    # 8.0f

    invoke-virtual {v1, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x41a00000    # 20.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v8, 0x40800000    # 4.0f

    invoke-virtual {v7, v8}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v7

    invoke-virtual {v5, v0, v1, v6, v7}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 476
    new-instance v6, Landroid/widget/ScrollView;

    invoke-direct {v6, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 477
    new-instance v0, Landroid/view/ViewGroup$LayoutParams;

    const/4 v1, -0x1

    invoke-direct {v0, v1, v12}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v6, v5, v0}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 478
    iput-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    .line 479
    iput v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    .line 480
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    .line 481
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mMoreWords:Landroid/widget/TextView;

    .line 482
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    .line 483
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 484
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v7, v4, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v7

    iget-object v8, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v9, "mr_import_stat_words"

    new-array v10, v3, [Ljava/lang/Object;

    invoke-virtual {v8, v9, v10}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v1, v7, v8}, Lcom/mrkeyboard/app/MrKit;->stat(ILjava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v7, v3, v12, v13}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 485
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v3, v12, v13}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 486
    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v8, 0x41000000    # 8.0f

    invoke-virtual {v7, v8}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v7

    invoke-virtual {v1, v7, v3, v3, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 487
    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v8, v4, Lcom/mrkeyboard/app/MrImport$Plan;->pairs:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v8

    iget-object v9, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v10, "mr_import_stat_pairs"

    new-array v11, v3, [Ljava/lang/Object;

    invoke-virtual {v9, v10, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v8, v9}, Lcom/mrkeyboard/app/MrKit;->stat(ILjava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v7

    invoke-virtual {v0, v7, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 488
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v3, v12, v13}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 489
    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v8, 0x41000000    # 8.0f

    invoke-virtual {v7, v8}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v7

    invoke-virtual {v1, v7, v3, v3, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 490
    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v8, v4, Lcom/mrkeyboard/app/MrImport$Plan;->knownSkipped:I

    iget-object v9, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v10, "mr_import_stat_known"

    new-array v11, v3, [Ljava/lang/Object;

    invoke-virtual {v9, v10, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v8, v9}, Lcom/mrkeyboard/app/MrKit;->stat(ILjava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v7

    invoke-virtual {v0, v7, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 491
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v5, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 492
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 493
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_import_for_app"

    new-array v8, v2, [Ljava/lang/Object;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->appName()Ljava/lang/String;

    move-result-object v9

    aput-object v9, v8, v3

    invoke-virtual {v1, v7, v8}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/high16 v7, 0x41600000    # 14.0f

    iget-object v8, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v8, v8, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v0, v1, v7, v8, v2}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v14}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v5, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 495
    :cond_0
    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/MrImportActivity;->blockedCount(Lcom/mrkeyboard/app/MrImport$Plan;)I

    move-result v0

    if-lez v0, :cond_1

    .line 496
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_import_blocked_found"

    new-array v8, v2, [Ljava/lang/Object;

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/MrImportActivity;->blockedCount(Lcom/mrkeyboard/app/MrImport$Plan;)I

    move-result v9

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    aput-object v9, v8, v3

    invoke-virtual {v1, v7, v8}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/high16 v7, 0x41600000    # 14.0f

    iget-object v8, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v8, v8, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v0, v1, v7, v8, v3}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v14}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v5, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 498
    :cond_1
    iget-boolean v0, v4, Lcom/mrkeyboard/app/MrImport$Plan;->pairsCut:Z

    if-eqz v0, :cond_2

    .line 499
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_import_pairs_cut"

    new-array v8, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v7, v8}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/high16 v7, 0x41600000    # 14.0f

    iget-object v8, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v8, v8, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v0, v1, v7, v8, v3}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v14}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v5, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 501
    :cond_2
    iget-object v0, v4, Lcom/mrkeyboard/app/MrImport$Plan;->languageHint:Ljava/lang/String;

    .line 502
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_3

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->localeOf(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-virtual {v1, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 503
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v8, "mr_import_lang_note"

    const/4 v9, 0x2

    new-array v9, v9, [Ljava/lang/Object;

    aput-object v0, v9, v3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->tag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v9, v2

    invoke-virtual {v7, v8, v9}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/high16 v7, 0x41600000    # 14.0f

    iget-object v8, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v8, v8, Lcom/mrkeyboard/app/MrKit;->rose:I

    invoke-virtual {v1, v0, v7, v8, v3}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v14}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v5, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 505
    :cond_3
    iget-object v0, v4, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_8

    iget-object v0, v4, Lcom/mrkeyboard/app/MrImport$Plan;->pairs:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_8

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/MrImportActivity;->blockedCount(Lcom/mrkeyboard/app/MrImport$Plan;)I

    move-result v0

    if-nez v0, :cond_8

    move v1, v2

    .line 506
    :goto_0
    if-eqz v1, :cond_4

    .line 507
    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v8, "mr_ui_ic_check_mint"

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v9, "mr_import_none_title"

    new-array v10, v3, [Ljava/lang/Object;

    invoke-virtual {v0, v9, v10}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    iget-object v10, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-boolean v0, v4, Lcom/mrkeyboard/app/MrImport$Plan;->standard:Z

    if-eqz v0, :cond_9

    const-string v0, "mr_import_none_std"

    :goto_1
    new-array v11, v3, [Ljava/lang/Object;

    invoke-virtual {v10, v0, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v7, v8, v9, v0}, Lcom/mrkeyboard/app/MrKit;->emptyState(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v8, 0xe

    invoke-virtual {v7, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v7

    invoke-virtual {v5, v0, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 509
    :cond_4
    iget v0, v4, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    if-lez v0, :cond_5

    .line 510
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v8, "mr_import_see_ignored"

    new-array v2, v2, [Ljava/lang/Object;

    iget v9, v4, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    aput-object v9, v2, v3

    invoke-virtual {v7, v8, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v7, Lcom/mrkeyboard/app/MrImportActivity$13;

    invoke-direct {v7, p0}, Lcom/mrkeyboard/app/MrImportActivity$13;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v0, v2, v3, v7}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 514
    invoke-virtual {v2, v14}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    .line 510
    invoke-virtual {v5, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 516
    :cond_5
    if-nez v1, :cond_6

    iget-object v0, v4, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_6

    .line 517
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_import_untick"

    new-array v8, v3, [Ljava/lang/Object;

    invoke-virtual {v2, v7, v8}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/high16 v7, 0x41500000    # 13.0f

    iget-object v8, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v8, v8, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v0, v2, v7, v8, v3}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v7, 0x10

    invoke-virtual {v2, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v5, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 518
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 519
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v8, "mr_import_all"

    new-array v9, v3, [Ljava/lang/Object;

    invoke-virtual {v7, v8, v9}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    new-instance v8, Lcom/mrkeyboard/app/MrImportActivity$14;

    invoke-direct {v8, p0}, Lcom/mrkeyboard/app/MrImportActivity$14;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v7, v3, v8}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    .line 524
    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v8, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v9, "mr_import_none"

    new-array v10, v3, [Ljava/lang/Object;

    invoke-virtual {v8, v9, v10}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Lcom/mrkeyboard/app/MrImportActivity$15;

    invoke-direct {v9, p0}, Lcom/mrkeyboard/app/MrImportActivity$15;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v7, v8, v3, v9}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v7

    .line 529
    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v8, v3, v12, v13}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v2, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 530
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v3, v12, v13}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 531
    iget-object v8, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v9, 0x41000000    # 8.0f

    invoke-virtual {v8, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v8

    invoke-virtual {v2, v8, v3, v3, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 532
    invoke-virtual {v0, v7, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 533
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v7, 0x8

    invoke-virtual {v2, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v5, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 534
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    .line 535
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v7, 0x8

    invoke-virtual {v2, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v5, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 536
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_learned_more"

    new-array v8, v3, [Ljava/lang/Object;

    invoke-virtual {v2, v7, v8}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v7, Lcom/mrkeyboard/app/MrImportActivity$16;

    invoke-direct {v7, p0}, Lcom/mrkeyboard/app/MrImportActivity$16;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v0, v2, v3, v7}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mMoreWords:Landroid/widget/TextView;

    .line 541
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mMoreWords:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v7, 0x8

    invoke-virtual {v2, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v5, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 542
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->drawWords()V

    .line 544
    :cond_6
    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-direct {v2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 545
    iget-boolean v0, v4, Lcom/mrkeyboard/app/MrImport$Plan;->standard:Z

    if-eqz v0, :cond_a

    const-string v0, "mr_import_found_std"

    :goto_2
    new-array v4, v3, [Ljava/lang/Object;

    invoke-virtual {v7, v0, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 546
    invoke-virtual {v0, v6}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 547
    if-eqz v1, :cond_b

    .line 548
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_words_ok"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v2, v4, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 557
    :goto_3
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    .line 558
    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$18;

    invoke-direct {v2, p0, v5}, Lcom/mrkeyboard/app/MrImportActivity$18;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/LinearLayout;)V

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    .line 571
    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreviewDialog:Landroid/app/AlertDialog;

    .line 572
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 573
    if-nez v1, :cond_7

    .line 574
    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    .line 575
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->updateApply()V

    .line 577
    :cond_7
    return-void

    :cond_8
    move v1, v3

    .line 505
    goto/16 :goto_0

    .line 507
    :cond_9
    const-string v0, "mr_import_none_new"

    goto/16 :goto_1

    .line 545
    :cond_a
    const-string v0, "mr_import_found"

    goto :goto_2

    .line 550
    :cond_b
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_words_cancel"

    new-array v6, v3, [Ljava/lang/Object;

    invoke-virtual {v2, v4, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/4 v4, 0x0

    invoke-virtual {v0, v2, v4}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 551
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_apply_none"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v2, v4, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/mrkeyboard/app/MrImportActivity$17;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrImportActivity$17;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    goto :goto_3
.end method

.method private source()Ljava/lang/String;
    .locals 1

    .prologue
    .line 370
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    .line 371
    if-nez v0, :cond_0

    const-string v0, ""

    :goto_0
    return-object v0

    :cond_0
    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private tickAll(Z)V
    .locals 2

    .prologue
    .line 605
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 606
    if-nez v0, :cond_0

    .line 612
    :goto_0
    return-void

    .line 607
    :cond_0
    iget-object v0, v0, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrImport$NewWord;

    iput-boolean p1, v0, Lcom/mrkeyboard/app/MrImport$NewWord;->checked:Z

    goto :goto_1

    .line 608
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 609
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    .line 610
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->drawWords()V

    .line 611
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->updateApply()V

    goto :goto_0
.end method

.method private undoLast()V
    .locals 15

    .prologue
    const-wide/16 v6, 0x0

    const/4 v14, 0x0

    const/4 v13, 0x2

    const/4 v12, 0x1

    const/4 v11, 0x0

    .line 918
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "last_batch"

    invoke-interface {v0, v1, v6, v7}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v2

    .line 919
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "last_locale"

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-interface {v0, v1, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 920
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v4, "last_app"

    invoke-interface {v1, v4, v14}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 921
    cmp-long v4, v2, v6

    if-lez v4, :cond_0

    if-nez v0, :cond_1

    .line 945
    :cond_0
    :goto_0
    return-void

    .line 923
    :cond_1
    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrApp;->scope(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 924
    new-instance v5, Landroid/app/AlertDialog$Builder;

    invoke-direct {v5, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_import_undo_title"

    new-array v8, v11, [Ljava/lang/Object;

    .line 925
    invoke-virtual {v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v5

    .line 926
    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_import_undo_ask"

    new-array v7, v13, [Ljava/lang/Object;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v8

    const-string v9, "last_count"

    invoke-interface {v8, v9, v11}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v8

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v7, v11

    iget-object v8, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v8, v0}, Lcom/mrkeyboard/app/MrKit;->langName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v7, v12

    invoke-virtual {v1, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_1
    invoke-virtual {v5, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_words_cancel"

    new-array v6, v11, [Ljava/lang/Object;

    .line 928
    invoke-virtual {v1, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v14}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_words_undo"

    new-array v6, v11, [Ljava/lang/Object;

    .line 929
    invoke-virtual {v1, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v5, Lcom/mrkeyboard/app/MrImportActivity$27;

    invoke-direct {v5, p0, v4, v2, v3}, Lcom/mrkeyboard/app/MrImportActivity$27;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;J)V

    invoke-virtual {v0, v1, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 944
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0

    .line 927
    :cond_2
    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_import_undo_ask_app"

    const/4 v8, 0x3

    new-array v8, v8, [Ljava/lang/Object;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v9

    const-string v10, "last_count"

    invoke-interface {v9, v10, v11}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v9

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    aput-object v9, v8, v11

    iget-object v9, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v9, v0}, Lcom/mrkeyboard/app/MrKit;->langName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v8, v12

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrAppList;->label(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v8, v13

    invoke-virtual {v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method private updateApply()V
    .locals 2

    .prologue
    .line 642
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    if-nez v0, :cond_1

    .line 645
    :cond_0
    :goto_0
    return-void

    .line 643
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->applyLabel()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 644
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->applyAny()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setEnabled(Z)V

    goto :goto_0
.end method

.method private updateCount()V
    .locals 6

    .prologue
    .line 330
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mCount:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_count"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v5}, Landroid/widget/EditText;->length()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 331
    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 96
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 97
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 10

    .prologue
    .line 120
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 121
    new-instance v0, Lcom/mrkeyboard/app/MrKit;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrKit;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 122
    invoke-static {p0}, Lcom/mrkeyboard/app/MrLearned;->store(Landroid/content/Context;)Lcom/mrkeyboard/app/MrWordStore;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    .line 123
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    if-nez v0, :cond_0

    .line 124
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_learned_unavailable"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    .line 125
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrImportActivity;->finish()V

    .line 250
    :goto_0
    return-void

    .line 128
    :cond_0
    if-eqz p1, :cond_5

    .line 129
    const-string v0, "mr_import_s_locale"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 130
    const-string v0, "mr_import_s_app"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    .line 134
    :cond_1
    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrApp;->validPackage(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    .line 135
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    if-nez v0, :cond_3

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrImportActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrImportActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "mr_words_locale"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 136
    :cond_3
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->loadLanguages()V

    .line 137
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLang;->remember(Landroid/content/SharedPreferences;Ljava/lang/String;)V

    .line 139
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 140
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->bg:I

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-virtual {v1, v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 141
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 142
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41800000    # 16.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41a00000    # 20.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41c00000    # 24.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 143
    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-direct {v2, v3, v4}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 144
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41800000    # 16.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41a00000    # 20.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41c00000    # 24.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x41400000    # 12.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrScreenIme;->lift(Landroid/widget/ScrollView;Landroid/view/View;IIIII)V

    .line 146
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_title"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$1;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$1;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->backHeader(Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x0

    .line 150
    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 146
    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 151
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_intro"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->infoCard(Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x10

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 154
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->panel()Landroid/widget/LinearLayout;

    move-result-object v9

    .line 155
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0xe

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v9, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 156
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_ui_ic_globe"

    const/high16 v4, 0x41800000    # 16.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_lang_card_title"

    const/4 v7, 0x0

    new-array v7, v7, [Ljava/lang/Object;

    invoke-virtual {v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    const/high16 v6, 0x41700000    # 15.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v8, 0x0

    invoke-virtual/range {v2 .. v8}, Lcom/mrkeyboard/app/MrKit;->iconRow(Ljava/lang/String;FLjava/lang/String;FIZ)Landroid/widget/LinearLayout;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 157
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangBox:Landroid/widget/LinearLayout;

    .line 158
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangBox:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xa

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 160
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_ui_ic_grid_blue"

    const/high16 v4, 0x41800000    # 16.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_app_card_title"

    const/4 v7, 0x0

    new-array v7, v7, [Ljava/lang/Object;

    invoke-virtual {v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    const/high16 v6, 0x41700000    # 15.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v8, 0x0

    invoke-virtual/range {v2 .. v8}, Lcom/mrkeyboard/app/MrKit;->iconRow(Ljava/lang/String;FLjava/lang/String;FIZ)Landroid/widget/LinearLayout;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x12

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 161
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAppBox:Landroid/widget/LinearLayout;

    .line 162
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAppBox:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xa

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 163
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    const/high16 v4, 0x41500000    # 13.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAppNote:Landroid/widget/TextView;

    .line 164
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAppNote:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x40800000    # 4.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x40800000    # 4.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 165
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAppNote:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x8

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 166
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_ui_ic_keyboard"

    const/high16 v4, 0x41800000    # 16.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_import_hint"

    const/4 v7, 0x0

    new-array v7, v7, [Ljava/lang/Object;

    invoke-virtual {v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    const/high16 v6, 0x41700000    # 15.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v8, 0x0

    invoke-virtual/range {v2 .. v8}, Lcom/mrkeyboard/app/MrKit;->iconRow(Ljava/lang/String;FLjava/lang/String;FIZ)Landroid/widget/LinearLayout;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x12

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 168
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_placeholder"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const v4, 0xa0001

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->field(Ljava/lang/String;I)Landroid/widget/EditText;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    .line 170
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    const/4 v3, 0x6

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setMinLines(I)V

    .line 171
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    const/16 v3, 0x30

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setGravity(I)V

    .line 172
    if-eqz p1, :cond_4

    const-string v2, "mr_import_s_text"

    invoke-virtual {p1, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_4

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    const-string v3, "mr_import_s_text"

    invoke-virtual {p1, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 173
    :cond_4
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    new-instance v3, Lcom/mrkeyboard/app/MrImportActivity$2;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrImportActivity$2;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 191
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    const/high16 v4, 0x41400000    # 12.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->hint:I

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mCount:Landroid/widget/TextView;

    .line 192
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mCount:Landroid/widget/TextView;

    const v3, 0x800005

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setGravity(I)V

    .line 193
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mCount:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41600000    # 14.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41600000    # 14.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x41200000    # 10.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-virtual {v2, v3, v4, v5, v6}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 194
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->mCount:Landroid/widget/TextView;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->fieldBox(Landroid/widget/EditText;Landroid/widget/TextView;)Landroid/widget/LinearLayout;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xa

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 195
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->updateCount()V

    .line 198
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_ai_button"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "mr_ui_ic_wand"

    const/4 v5, 0x0

    new-instance v6, Lcom/mrkeyboard/app/MrImportActivity$3;

    invoke-direct {v6, p0}, Lcom/mrkeyboard/app/MrImportActivity$3;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->iconButton(Ljava/lang/String;Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiButton:Landroid/widget/TextView;

    .line 203
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiButton:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xc

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 204
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_analyze"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "mr_ui_ic_eye"

    const/4 v5, 0x1

    new-instance v6, Lcom/mrkeyboard/app/MrImportActivity$4;

    invoke-direct {v6, p0}, Lcom/mrkeyboard/app/MrImportActivity$4;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->iconButton(Ljava/lang/String;Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAnalyze:Landroid/widget/TextView;

    .line 209
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAnalyze:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xc

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 210
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    const/high16 v4, 0x41500000    # 13.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    .line 211
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x40800000    # 4.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x40c00000    # 6.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x40800000    # 4.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 212
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    .line 213
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 215
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    const/high16 v4, 0x41600000    # 14.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    .line 216
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x40800000    # 4.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41000000    # 8.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x40800000    # 4.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 217
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    .line 218
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 219
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_words_cancel"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    new-instance v5, Lcom/mrkeyboard/app/MrImportActivity$5;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrImportActivity$5;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    .line 225
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    .line 226
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x8

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 229
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->panel()Landroid/widget/LinearLayout;

    move-result-object v9

    .line 230
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_ui_ic_sparkle"

    const/high16 v4, 0x41a00000    # 20.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_import_ai_title"

    const/4 v7, 0x0

    new-array v7, v7, [Ljava/lang/Object;

    invoke-virtual {v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    const/high16 v6, 0x41880000    # 17.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v8, 0x1

    invoke-virtual/range {v2 .. v8}, Lcom/mrkeyboard/app/MrKit;->iconRow(Ljava/lang/String;FLjava/lang/String;FIZ)Landroid/widget/LinearLayout;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 231
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_ai_text"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/high16 v4, 0x41600000    # 14.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x8

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 232
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_ai_copy"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "mr_ui_ic_copy"

    const/4 v5, 0x0

    new-instance v6, Lcom/mrkeyboard/app/MrImportActivity$6;

    invoke-direct {v6, p0}, Lcom/mrkeyboard/app/MrImportActivity$6;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->iconButton(Ljava/lang/String;Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xc

    .line 236
    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 232
    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 237
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0x16

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v9, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 239
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    const-string v4, "mr_ui_ic_undo"

    const/4 v5, 0x0

    new-instance v6, Lcom/mrkeyboard/app/MrImportActivity$7;

    invoke-direct {v6, p0}, Lcom/mrkeyboard/app/MrImportActivity$7;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->iconButton(Ljava/lang/String;Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    .line 244
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x12

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 246
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->setContentView(Landroid/view/View;)V

    .line 247
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->restore(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    .line 248
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshOffer()V

    .line 249
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshApp()V

    goto/16 :goto_0

    .line 131
    :cond_5
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrImportActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 132
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrImportActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "mr_words_app"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    goto/16 :goto_1
.end method

.method protected onDestroy()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 112
    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 113
    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    .line 114
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->dismissPreview()V

    .line 115
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 116
    return-void
.end method

.method protected onResume()V
    .locals 1

    .prologue
    .line 254
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 255
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    if-nez v0, :cond_0

    .line 258
    :goto_0
    return-void

    .line 256
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshLanguages()V

    .line 257
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshUndo()V

    goto :goto_0
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 101
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 102
    const-string v0, "mr_import_s_locale"

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 103
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    if-eqz v0, :cond_0

    const-string v0, "mr_import_s_app"

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApp:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 104
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    if-nez v0, :cond_2

    move-object v0, v1

    .line 105
    :goto_0
    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-lez v2, :cond_1

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    const v3, 0x186a0

    if-gt v2, v3, :cond_1

    const-string v2, "mr_import_s_text"

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v2, v0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 106
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->save(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    .line 107
    return-void

    .line 104
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    goto :goto_0
.end method
