.class public Lcom/mrkeyboard/app/MrImportActivity;
.super Landroid/app/Activity;
.source "MrImportActivity.java"


# static fields
.field static final EXTRA_LOCALE:Ljava/lang/String; = "mr_words_locale"

.field private static final PREFS:Ljava/lang/String; = "mr_words"

.field static final PREVIEW_PAGE:I = 0x64

.field private static final P_BATCH:Ljava/lang/String; = "last_batch"

.field private static final P_COUNT:Ljava/lang/String; = "last_count"

.field private static final P_LOCALE:Ljava/lang/String; = "last_locale"

.field private static final SAVE_TEXT_MAX:I = 0x186a0

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
    .line 40
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 56
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->updateCount()V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshOffer()V

    return-void
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->undoLast()V

    return-void
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/MrImportActivity;)Z
    .locals 1

    .prologue
    .line 40
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    return v0
.end method

.method static synthetic access$1202(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 40
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/content/SharedPreferences;
    .locals 1

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshLanguages()V

    return-void
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/MrImportActivity;ZLjava/lang/String;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    return-void
.end method

.method static synthetic access$1600(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;
    .locals 1

    .prologue
    .line 40
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    return-object v0
.end method

.method static synthetic access$1702(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImport$Plan;)Lcom/mrkeyboard/app/MrImport$Plan;
    .locals 0

    .prologue
    .line 40
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    return-object p1
.end method

.method static synthetic access$1800(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->showPreview()V

    return-void
.end method

.method static synthetic access$1900(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->showIgnored()V

    return-void
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrImportActivity;)Z
    .locals 1

    .prologue
    .line 40
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mSetting:Z

    return v0
.end method

.method static synthetic access$2000(Lcom/mrkeyboard/app/MrImportActivity;Z)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->tickAll(Z)V

    return-void
.end method

.method static synthetic access$2100(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->drawWords()V

    return-void
.end method

.method static synthetic access$2200(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->apply()V

    return-void
.end method

.method static synthetic access$2300(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/LinearLayout;
    .locals 1

    .prologue
    .line 40
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method static synthetic access$2302(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/LinearLayout;)Landroid/widget/LinearLayout;
    .locals 0

    .prologue
    .line 40
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    return-object p1
.end method

.method static synthetic access$2402(Lcom/mrkeyboard/app/MrImportActivity;Landroid/app/AlertDialog;)Landroid/app/AlertDialog;
    .locals 0

    .prologue
    .line 40
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreviewDialog:Landroid/app/AlertDialog;

    return-object p1
.end method

.method static synthetic access$2502(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/LinearLayout;)Landroid/widget/LinearLayout;
    .locals 0

    .prologue
    .line 40
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    return-object p1
.end method

.method static synthetic access$2602(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/TextView;)Landroid/widget/TextView;
    .locals 0

    .prologue
    .line 40
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mMoreWords:Landroid/widget/TextView;

    return-object p1
.end method

.method static synthetic access$2702(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/TextView;)Landroid/widget/TextView;
    .locals 0

    .prologue
    .line 40
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    return-object p1
.end method

.method static synthetic access$2800(Lcom/mrkeyboard/app/MrImport$NewWord;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 40
    invoke-static {p0}, Lcom/mrkeyboard/app/MrImportActivity;->mark(Lcom/mrkeyboard/app/MrImport$NewWord;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$2900(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->updateApply()V

    return-void
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->hideAiNote()V

    return-void
.end method

.method static synthetic access$3000(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/MrImportActivity;->remember(Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$3100(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrLearned$Result;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->report(Lcom/mrkeyboard/app/MrLearned$Result;)V

    return-void
.end method

.method static synthetic access$3200(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 40
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$3300(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshUndo()V

    return-void
.end method

.method static synthetic access$3400(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->askToSend(Lcom/mrkeyboard/app/MrImportAi$Plan;)V

    return-void
.end method

.method static synthetic access$3500(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->runAi(Lcom/mrkeyboard/app/MrImportAi$Plan;)V

    return-void
.end method

.method static synthetic access$3600(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/TextView;
    .locals 1

    .prologue
    .line 40
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$3700(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Result;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->finishAi(Lcom/mrkeyboard/app/MrImportAi$Result;)V

    return-void
.end method

.method static synthetic access$3800(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrWordStore;
    .locals 1

    .prologue
    .line 40
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    return-object v0
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->clearPreview()V

    return-void
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->formatTapped()V

    return-void
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->analyze()V

    return-void
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/MrImportActivity;)Z
    .locals 1

    .prologue
    .line 40
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancelled:Z

    return v0
.end method

.method static synthetic access$702(Lcom/mrkeyboard/app/MrImportActivity;Z)Z
    .locals 0

    .prologue
    .line 40
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancelled:Z

    return p1
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/TextView;
    .locals 1

    .prologue
    .line 40
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->copyPrompt()V

    return-void
.end method

.method private analyze()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 320
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-eqz v0, :cond_0

    .line 376
    :goto_0
    return-void

    .line 321
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->source()Ljava/lang/String;

    move-result-object v0

    .line 322
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 323
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_nothing"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 326
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 327
    invoke-static {v0}, Lcom/mrkeyboard/app/MrImport;->isStandard(Ljava/lang/String;)Z

    move-result v2

    .line 328
    const/4 v3, 0x1

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_working"

    new-array v6, v6, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 329
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->clearPreview()V

    .line 330
    new-instance v3, Ljava/lang/Thread;

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$9;

    invoke-direct {v4, p0, v1, v2, v0}, Lcom/mrkeyboard/app/MrImportActivity$9;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;ZLjava/lang/String;)V

    invoke-direct {v3, v4}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 375
    invoke-virtual {v3}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private apply()V
    .locals 7

    .prologue
    .line 593
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    if-nez v0, :cond_1

    .line 626
    :cond_0
    :goto_0
    return-void

    .line 594
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 595
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 596
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    .line 597
    const/4 v3, 0x1

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_saving"

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 598
    new-instance v3, Ljava/lang/Thread;

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$17;

    invoke-direct {v4, p0, v2, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity$17;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrWordStore;Lcom/mrkeyboard/app/MrImport$Plan;Ljava/lang/String;)V

    invoke-direct {v3, v4}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 625
    invoke-virtual {v3}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private applyAny()Z
    .locals 2

    .prologue
    .line 564
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImport$Plan;->checkedWords()I

    move-result v0

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->pairsToAdd()I

    move-result v1

    add-int/2addr v0, v1

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrImport$Plan;->blocked:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

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

    .line 558
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImport$Plan;->checkedWords()I

    move-result v0

    .line 559
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->pairsToAdd()I

    move-result v1

    .line 560
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

    .line 707
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->serviceHost(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 708
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_import_ai_your_service"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 709
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

    .line 710
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

    .line 711
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

    .line 712
    :cond_2
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_ai_ask_title"

    new-array v4, v6, [Ljava/lang/Object;

    .line 713
    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 714
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_dont"

    new-array v3, v6, [Ljava/lang/Object;

    .line 715
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_send"

    new-array v3, v6, [Ljava/lang/Object;

    .line 716
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$20;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/MrImportActivity$20;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 721
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 722
    return-void
.end method

.method private clearPreview()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 382
    iput-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 383
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    .line 384
    iput-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    .line 385
    iput-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    .line 386
    iput-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mMoreWords:Landroid/widget/TextView;

    .line 387
    iput-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    .line 388
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->dismissPreview()V

    .line 389
    return-void
.end method

.method private copyPrompt()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 286
    :try_start_0
    const-string v0, "clipboard"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/ClipboardManager;

    .line 287
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

    .line 288
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

    .line 292
    :goto_0
    return-void

    .line 289
    :catch_0
    move-exception v0

    .line 290
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
    .line 392
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreviewDialog:Landroid/app/AlertDialog;

    .line 393
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreviewDialog:Landroid/app/AlertDialog;

    .line 394
    if-nez v0, :cond_0

    .line 400
    :goto_0
    return-void

    .line 396
    :cond_0
    :try_start_0
    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 397
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private drawWords()V
    .locals 9

    .prologue
    const/4 v2, 0x0

    .line 512
    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 513
    if-eqz v4, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    if-nez v0, :cond_1

    .line 529
    :cond_0
    :goto_0
    return-void

    .line 514
    :cond_1
    iget-object v0, v4, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    iget v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    add-int/lit8 v1, v1, 0x64

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 515
    iget v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    move v3, v0

    :goto_1
    if-ge v3, v5, :cond_4

    .line 516
    iget-object v0, v4, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrImport$NewWord;

    .line 517
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

    .line 518
    new-instance v6, Lcom/mrkeyboard/app/MrImportActivity$16;

    invoke-direct {v6, p0, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity$16;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImport$NewWord;Landroid/widget/LinearLayout;)V

    invoke-virtual {v1, v6}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 525
    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    if-nez v3, :cond_3

    move v0, v2

    :goto_3
    invoke-virtual {v7, v0}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v6, v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 515
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_1

    .line 517
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

    .line 525
    :cond_3
    const/4 v0, 0x6

    goto :goto_3

    .line 527
    :cond_4
    iput v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    .line 528
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
    .line 778
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

    .line 782
    invoke-direct {p0, v6, v7}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 783
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 784
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrImportActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 810
    :cond_0
    :goto_0
    return-void

    .line 785
    :cond_1
    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrImportAi$Result;->empty()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 787
    iget-object v0, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->failure:Ljava/lang/String;

    if-eqz v0, :cond_2

    .line 788
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_fail_title"

    new-array v3, v6, [Ljava/lang/Object;

    .line 789
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->failure:Ljava/lang/String;

    .line 790
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->failureText(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_ok"

    new-array v3, v6, [Ljava/lang/Object;

    .line 791
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v7}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 792
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0

    .line 794
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

    .line 798
    :cond_4
    iget-object v0, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->text:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->setBox(Ljava/lang/String;)V

    .line 799
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->clearPreview()V

    .line 800
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

    .line 801
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    .line 802
    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrImportAi$Result;->complete()Z

    move-result v0

    if-nez v0, :cond_0

    .line 803
    iget-object v0, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->failure:Ljava/lang/String;

    if-eqz v0, :cond_5

    iget-object v0, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->failure:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->failureText(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 804
    :goto_2
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_ai_partial_title"

    new-array v4, v6, [Ljava/lang/Object;

    .line 805
    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_ai_partial"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    iget v5, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->done:I

    .line 806
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

    .line 807
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v7}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 808
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto/16 :goto_0

    .line 803
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

    .line 647
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-eqz v0, :cond_0

    .line 675
    :goto_0
    return-void

    .line 648
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->source()Ljava/lang/String;

    move-result-object v0

    .line 649
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 650
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_nothing"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 653
    :cond_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrImport;->isStandard(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 654
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_already"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 657
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->configured(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 658
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_nokey_title"

    new-array v3, v4, [Ljava/lang/Object;

    .line 659
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_nokey_text"

    new-array v3, v4, [Ljava/lang/Object;

    .line 660
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_cancel"

    new-array v3, v4, [Ljava/lang/Object;

    .line 661
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_nokey_open"

    new-array v3, v4, [Ljava/lang/Object;

    .line 662
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$18;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrImportActivity$18;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 671
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto/16 :goto_0

    .line 674
    :cond_3
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->prepareAi(Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method private hideAiNote()V
    .locals 2

    .prologue
    .line 813
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    if-nez v0, :cond_0

    .line 815
    :goto_0
    return-void

    .line 814
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0
.end method

.method private loadLanguages()V
    .locals 4

    .prologue
    .line 239
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    invoke-interface {v0}, Lcom/mrkeyboard/app/MrWordStore;->locales()Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 243
    :goto_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->installedIds(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrLang;->offered(Ljava/util/List;Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    .line 244
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

    .line 245
    return-void

    .line 240
    :catch_0
    move-exception v0

    .line 241
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    goto :goto_0
.end method

.method private static mark(Lcom/mrkeyboard/app/MrImport$NewWord;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 532
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
    .line 547
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 548
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    .line 549
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

    .line 550
    :cond_1
    invoke-virtual {v2}, Ljava/util/HashSet;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->pairs:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    .line 553
    :cond_2
    return v1

    .line 551
    :cond_3
    const/4 v0, 0x0

    .line 552
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
    .line 820
    const-string v0, "mr_words"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method private prepareAi(Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 679
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-eqz v0, :cond_0

    .line 703
    :goto_0
    return-void

    .line 680
    :cond_0
    const/4 v0, 0x1

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_preparing"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 681
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/mrkeyboard/app/MrImportActivity$19;

    invoke-direct {v1, p0, p1}, Lcom/mrkeyboard/app/MrImportActivity$19;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 702
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private refreshLanguages()V
    .locals 6

    .prologue
    .line 248
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangBox:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$8;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$8;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v5}, Lcom/mrkeyboard/app/MrKit;->languageCard(Landroid/widget/LinearLayout;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/MrKit$LangPick;Z)V

    .line 258
    return-void
.end method

.method private refreshOffer()V
    .locals 7

    .prologue
    const/16 v3, 0x8

    const/4 v4, 0x1

    const/4 v2, 0x0

    .line 272
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiButton:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAnalyze:Landroid/widget/TextView;

    if-nez v0, :cond_1

    .line 282
    :cond_0
    :goto_0
    return-void

    .line 273
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    if-nez v0, :cond_5

    const/4 v0, 0x0

    .line 274
    :goto_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrImport;->offer(Ljava/lang/String;)I

    move-result v5

    .line 275
    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiButton:Landroid/widget/TextView;

    if-ne v5, v4, :cond_6

    move v1, v2

    :goto_2
    invoke-virtual {v6, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 276
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAnalyze:Landroid/widget/TextView;

    const/4 v6, 0x2

    if-ne v5, v6, :cond_2

    move v3, v2

    :cond_2
    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    .line 277
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_3

    move v2, v4

    .line 278
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiPrimary:Ljava/lang/Boolean;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiPrimary:Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eq v0, v2, :cond_0

    .line 279
    :cond_4
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiPrimary:Ljava/lang/Boolean;

    .line 280
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiButton:Landroid/widget/TextView;

    if-eqz v2, :cond_7

    const-string v0, "mr_ui_ic_wand_on"

    :goto_3
    invoke-virtual {v1, v3, v2, v0}, Lcom/mrkeyboard/app/MrKit;->restyleIconButton(Landroid/widget/TextView;ZLjava/lang/String;)V

    goto :goto_0

    .line 273
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_6
    move v1, v3

    .line 275
    goto :goto_2

    .line 280
    :cond_7
    const-string v0, "mr_ui_ic_wand"

    goto :goto_3
.end method

.method private refreshUndo()V
    .locals 7

    .prologue
    const-wide/16 v2, 0x0

    const/4 v6, 0x0

    .line 829
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "last_batch"

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    .line 830
    cmp-long v0, v0, v2

    if-gtz v0, :cond_0

    .line 831
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 836
    :goto_0
    return-void

    .line 834
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

    .line 835
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0
.end method

.method private remember(Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 824
    iget-wide v0, p1, Lcom/mrkeyboard/app/MrLearned$Result;->batch:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    iget v0, p1, Lcom/mrkeyboard/app/MrLearned$Result;->words:I

    iget v1, p1, Lcom/mrkeyboard/app/MrLearned$Result;->pairs:I

    add-int/2addr v0, v1

    if-nez v0, :cond_1

    .line 826
    :cond_0
    :goto_0
    return-void

    .line 825
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

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    goto :goto_0
.end method

.method private report(Lcom/mrkeyboard/app/MrLearned$Result;)V
    .locals 9

    .prologue
    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 629
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 630
    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrLearned$Result;->total()I

    move-result v1

    if-nez v1, :cond_4

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_added_none"

    new-array v3, v7, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 632
    :goto_0
    iget v1, p1, Lcom/mrkeyboard/app/MrLearned$Result;->blocked:I

    if-lez v1, :cond_0

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

    .line 633
    :cond_0
    iget v1, p1, Lcom/mrkeyboard/app/MrLearned$Result;->dupWords:I

    iget v2, p1, Lcom/mrkeyboard/app/MrLearned$Result;->dupPairs:I

    add-int/2addr v1, v2

    if-lez v1, :cond_1

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

    .line 634
    :cond_1
    iget v1, p1, Lcom/mrkeyboard/app/MrLearned$Result;->cappedWords:I

    iget v2, p1, Lcom/mrkeyboard/app/MrLearned$Result;->cappedPairs:I

    add-int/2addr v1, v2

    if-lez v1, :cond_2

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

    .line 635
    :cond_2
    iget v1, p1, Lcom/mrkeyboard/app/MrLearned$Result;->blockedSkipped:I

    if-lez v1, :cond_3

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

    .line 636
    :cond_3
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_done_title"

    new-array v4, v7, [Ljava/lang/Object;

    .line 637
    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 638
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_ok"

    new-array v3, v7, [Ljava/lang/Object;

    .line 639
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 640
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 641
    return-void

    .line 631
    :cond_4
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

    .line 725
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-eqz v0, :cond_0

    .line 775
    :goto_0
    return-void

    .line 726
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->tag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 727
    iput-boolean v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancelled:Z

    .line 728
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

    .line 729
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setVisibility(I)V

    .line 730
    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$21;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$21;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 739
    new-instance v5, Lcom/mrkeyboard/app/MrImportActivity$22;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrImportActivity$22;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 753
    new-instance v6, Ljava/lang/Thread;

    new-instance v0, Lcom/mrkeyboard/app/MrImportActivity$23;

    move-object v1, p0

    move-object v2, p1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrImportActivity$23;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;Ljava/lang/String;Lcom/mrkeyboard/app/MrImportAi$Sender;Lcom/mrkeyboard/app/MrImportAi$Control;)V

    invoke-direct {v6, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 774
    invoke-virtual {v6}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private setBox(Ljava/lang/String;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 295
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mSetting:Z

    .line 297
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 299
    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mSetting:Z

    .line 301
    return-void

    .line 299
    :catchall_0
    move-exception v0

    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mSetting:Z

    .line 300
    throw v0
.end method

.method private setBusy(ZLjava/lang/String;)V
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 311
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    .line 312
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAnalyze:Landroid/widget/TextView;

    if-nez p1, :cond_1

    move v0, v1

    :goto_0
    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setClickable(Z)V

    .line 313
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiButton:Landroid/widget/TextView;

    if-nez p1, :cond_2

    move v0, v1

    :goto_1
    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setClickable(Z)V

    .line 314
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    if-nez p1, :cond_3

    :goto_2
    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setEnabled(Z)V

    .line 315
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    if-nez p2, :cond_0

    const-string p2, ""

    :cond_0
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 316
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    if-eqz p1, :cond_4

    :goto_3
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 317
    return-void

    :cond_1
    move v0, v2

    .line 312
    goto :goto_0

    :cond_2
    move v0, v2

    .line 313
    goto :goto_1

    :cond_3
    move v1, v2

    .line 314
    goto :goto_2

    .line 316
    :cond_4
    const/16 v2, 0x8

    goto :goto_3
.end method

.method private showIgnored()V
    .locals 10

    .prologue
    const/4 v9, 0x1

    const/4 v8, 0x0

    .line 574
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 575
    if-nez v1, :cond_0

    .line 588
    :goto_0
    return-void

    .line 576
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 577
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

    .line 578
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

    .line 580
    :cond_1
    iget v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    iget-object v3, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignored:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-le v0, v3, :cond_2

    .line 581
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

    .line 583
    :cond_2
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_see_ignored"

    new-array v5, v9, [Ljava/lang/Object;

    iget v1, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    .line 584
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v5, v8

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 585
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_ok"

    new-array v3, v8, [Ljava/lang/Object;

    .line 586
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 587
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto/16 :goto_0
.end method

.method private showPreview()V
    .locals 15

    .prologue
    const/high16 v14, 0x41000000    # 8.0f

    const/4 v13, 0x0

    const/high16 v12, 0x3f800000    # 1.0f

    const/4 v11, -0x2

    const/4 v2, 0x0

    .line 407
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 408
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v4

    .line 409
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v1, 0x41a00000    # 20.0f

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v14}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41a00000    # 20.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x40800000    # 4.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-virtual {v4, v0, v1, v5, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 410
    new-instance v5, Landroid/widget/ScrollView;

    invoke-direct {v5, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 411
    new-instance v0, Landroid/view/ViewGroup$LayoutParams;

    const/4 v1, -0x1

    invoke-direct {v0, v1, v11}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v4, v0}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 412
    iput-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    .line 413
    iput v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    .line 414
    iput-object v13, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    .line 415
    iput-object v13, p0, Lcom/mrkeyboard/app/MrImportActivity;->mMoreWords:Landroid/widget/TextView;

    .line 416
    iput-object v13, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    .line 417
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 418
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v6, v3, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v8, "mr_import_stat_words"

    new-array v9, v2, [Ljava/lang/Object;

    invoke-virtual {v7, v8, v9}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v1, v6, v7}, Lcom/mrkeyboard/app/MrKit;->stat(ILjava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v6, v2, v11, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 419
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v2, v11, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 420
    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6, v14}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-virtual {v1, v6, v2, v2, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 421
    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v7, v3, Lcom/mrkeyboard/app/MrImport$Plan;->pairs:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v7

    iget-object v8, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v9, "mr_import_stat_pairs"

    new-array v10, v2, [Ljava/lang/Object;

    invoke-virtual {v8, v9, v10}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->stat(ILjava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v6

    invoke-virtual {v0, v6, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 422
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v2, v11, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 423
    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6, v14}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-virtual {v1, v6, v2, v2, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 424
    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v3, Lcom/mrkeyboard/app/MrImport$Plan;->knownSkipped:I

    iget-object v8, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v9, "mr_import_stat_known"

    new-array v10, v2, [Ljava/lang/Object;

    invoke-virtual {v8, v9, v10}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->stat(ILjava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v6

    invoke-virtual {v0, v6, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 425
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v4, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 426
    iget-object v0, v3, Lcom/mrkeyboard/app/MrImport$Plan;->blocked:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 427
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_import_blocked_found"

    const/4 v7, 0x1

    new-array v7, v7, [Ljava/lang/Object;

    iget-object v8, v3, Lcom/mrkeyboard/app/MrImport$Plan;->blocked:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v8

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v7, v2

    invoke-virtual {v1, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/high16 v6, 0x41600000    # 14.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v0, v1, v6, v7, v2}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v6, 0xc

    invoke-virtual {v1, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v4, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 429
    :cond_0
    iget-boolean v0, v3, Lcom/mrkeyboard/app/MrImport$Plan;->pairsCut:Z

    if-eqz v0, :cond_1

    .line 430
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_import_pairs_cut"

    new-array v7, v2, [Ljava/lang/Object;

    invoke-virtual {v1, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/high16 v6, 0x41600000    # 14.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v0, v1, v6, v7, v2}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v6, 0xc

    invoke-virtual {v1, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v4, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 432
    :cond_1
    iget-object v0, v3, Lcom/mrkeyboard/app/MrImport$Plan;->languageHint:Ljava/lang/String;

    .line 433
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->localeOf(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-virtual {v1, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 434
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_import_lang_note"

    const/4 v8, 0x2

    new-array v8, v8, [Ljava/lang/Object;

    aput-object v0, v8, v2

    const/4 v0, 0x1

    iget-object v9, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-static {v9}, Lcom/mrkeyboard/app/MrLearned;->tag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    aput-object v9, v8, v0

    invoke-virtual {v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/high16 v6, 0x41600000    # 14.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->rose:I

    invoke-virtual {v1, v0, v6, v7, v2}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v6, 0xc

    invoke-virtual {v1, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v4, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 436
    :cond_2
    iget-object v0, v3, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_7

    iget-object v0, v3, Lcom/mrkeyboard/app/MrImport$Plan;->pairs:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_7

    iget-object v0, v3, Lcom/mrkeyboard/app/MrImport$Plan;->blocked:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_7

    const/4 v0, 0x1

    move v1, v0

    .line 437
    :goto_0
    if-eqz v1, :cond_3

    .line 438
    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_ui_ic_check_mint"

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v8, "mr_import_none_title"

    new-array v9, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v8, v9}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    iget-object v9, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-boolean v0, v3, Lcom/mrkeyboard/app/MrImport$Plan;->standard:Z

    if-eqz v0, :cond_8

    const-string v0, "mr_import_none_std"

    :goto_1
    new-array v10, v2, [Ljava/lang/Object;

    invoke-virtual {v9, v0, v10}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v7, v8, v0}, Lcom/mrkeyboard/app/MrKit;->emptyState(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v7, 0xe

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    invoke-virtual {v4, v0, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 440
    :cond_3
    iget v0, v3, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    if-lez v0, :cond_4

    .line 441
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_import_see_ignored"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/Object;

    iget v9, v3, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    aput-object v9, v8, v2

    invoke-virtual {v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    new-instance v7, Lcom/mrkeyboard/app/MrImportActivity$10;

    invoke-direct {v7, p0}, Lcom/mrkeyboard/app/MrImportActivity$10;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v0, v6, v2, v7}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v7, 0xc

    .line 445
    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    .line 441
    invoke-virtual {v4, v0, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 447
    :cond_4
    if-nez v1, :cond_5

    iget-object v0, v3, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_5

    .line 448
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_import_untick"

    new-array v8, v2, [Ljava/lang/Object;

    invoke-virtual {v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    const/high16 v7, 0x41500000    # 13.0f

    iget-object v8, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v8, v8, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v0, v6, v7, v8, v2}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v7, 0x10

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    invoke-virtual {v4, v0, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 449
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 450
    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v8, "mr_import_all"

    new-array v9, v2, [Ljava/lang/Object;

    invoke-virtual {v7, v8, v9}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    new-instance v8, Lcom/mrkeyboard/app/MrImportActivity$11;

    invoke-direct {v8, p0}, Lcom/mrkeyboard/app/MrImportActivity$11;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v6, v7, v2, v8}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v6

    .line 455
    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v8, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v9, "mr_import_none"

    new-array v10, v2, [Ljava/lang/Object;

    invoke-virtual {v8, v9, v10}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Lcom/mrkeyboard/app/MrImportActivity$12;

    invoke-direct {v9, p0}, Lcom/mrkeyboard/app/MrImportActivity$12;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v7, v8, v2, v9}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v7

    .line 460
    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v8, v2, v11, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v6, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 461
    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v6, v2, v11, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 462
    iget-object v8, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v8, v14}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v8

    invoke-virtual {v6, v8, v2, v2, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 463
    invoke-virtual {v0, v7, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 464
    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v7, 0x8

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    invoke-virtual {v4, v0, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 465
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    .line 466
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v7, 0x8

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    invoke-virtual {v4, v0, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 467
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_learned_more"

    new-array v8, v2, [Ljava/lang/Object;

    invoke-virtual {v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    new-instance v7, Lcom/mrkeyboard/app/MrImportActivity$13;

    invoke-direct {v7, p0}, Lcom/mrkeyboard/app/MrImportActivity$13;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v0, v6, v2, v7}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mMoreWords:Landroid/widget/TextView;

    .line 472
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mMoreWords:Landroid/widget/TextView;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v7, 0x8

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    invoke-virtual {v4, v0, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 473
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->drawWords()V

    .line 475
    :cond_5
    new-instance v6, Landroid/app/AlertDialog$Builder;

    invoke-direct {v6, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 476
    iget-boolean v0, v3, Lcom/mrkeyboard/app/MrImport$Plan;->standard:Z

    if-eqz v0, :cond_9

    const-string v0, "mr_import_found_std"

    :goto_2
    new-array v3, v2, [Ljava/lang/Object;

    invoke-virtual {v7, v0, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 477
    invoke-virtual {v0, v5}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 478
    if-eqz v1, :cond_a

    .line 479
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_words_ok"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v3, v5, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, v13}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 488
    :goto_3
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    .line 489
    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$15;

    invoke-direct {v2, p0, v4}, Lcom/mrkeyboard/app/MrImportActivity$15;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/LinearLayout;)V

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    .line 502
    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreviewDialog:Landroid/app/AlertDialog;

    .line 503
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 504
    if-nez v1, :cond_6

    .line 505
    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    .line 506
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->updateApply()V

    .line 508
    :cond_6
    return-void

    :cond_7
    move v1, v2

    .line 436
    goto/16 :goto_0

    .line 438
    :cond_8
    const-string v0, "mr_import_none_new"

    goto/16 :goto_1

    .line 476
    :cond_9
    const-string v0, "mr_import_found"

    goto :goto_2

    .line 481
    :cond_a
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_words_cancel"

    new-array v6, v2, [Ljava/lang/Object;

    invoke-virtual {v3, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3, v13}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 482
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_apply_none"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v3, v5, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/mrkeyboard/app/MrImportActivity$14;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrImportActivity$14;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    goto :goto_3
.end method

.method private source()Ljava/lang/String;
    .locals 1

    .prologue
    .line 304
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    .line 305
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
    .line 536
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 537
    if-nez v0, :cond_0

    .line 543
    :goto_0
    return-void

    .line 538
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

    .line 539
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 540
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    .line 541
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->drawWords()V

    .line 542
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->updateApply()V

    goto :goto_0
.end method

.method private undoLast()V
    .locals 10

    .prologue
    const-wide/16 v6, 0x0

    const/4 v9, 0x0

    .line 839
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "last_batch"

    invoke-interface {v0, v1, v6, v7}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    .line 840
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v2

    const-string v3, "last_locale"

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 841
    cmp-long v3, v0, v6

    if-lez v3, :cond_0

    if-nez v2, :cond_1

    .line 862
    :cond_0
    :goto_0
    return-void

    .line 842
    :cond_1
    new-instance v3, Landroid/app/AlertDialog$Builder;

    invoke-direct {v3, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_undo_title"

    new-array v6, v9, [Ljava/lang/Object;

    .line 843
    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_undo_ask"

    const/4 v6, 0x2

    new-array v6, v6, [Ljava/lang/Object;

    .line 844
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v7

    const-string v8, "last_count"

    invoke-interface {v7, v8, v9}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v7

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v6, v9

    const/4 v7, 0x1

    iget-object v8, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v8, v2}, Lcom/mrkeyboard/app/MrKit;->langName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    aput-object v8, v6, v7

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_words_cancel"

    new-array v6, v9, [Ljava/lang/Object;

    .line 845
    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_words_undo"

    new-array v6, v9, [Ljava/lang/Object;

    .line 846
    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lcom/mrkeyboard/app/MrImportActivity$24;

    invoke-direct {v5, p0, v2, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity$24;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;J)V

    invoke-virtual {v3, v4, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 861
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private updateApply()V
    .locals 2

    .prologue
    .line 568
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    if-nez v0, :cond_1

    .line 571
    :cond_0
    :goto_0
    return-void

    .line 569
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->applyLabel()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 570
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->applyAny()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setEnabled(Z)V

    goto :goto_0
.end method

.method private updateCount()V
    .locals 6

    .prologue
    .line 264
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

    .line 265
    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 85
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 86
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 10

    .prologue
    .line 108
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 109
    new-instance v0, Lcom/mrkeyboard/app/MrKit;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrKit;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 110
    invoke-static {p0}, Lcom/mrkeyboard/app/MrLearned;->store(Landroid/content/Context;)Lcom/mrkeyboard/app/MrWordStore;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    .line 111
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    if-nez v0, :cond_0

    .line 112
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_learned_unavailable"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    .line 113
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrImportActivity;->finish()V

    .line 224
    :goto_0
    return-void

    .line 116
    :cond_0
    if-eqz p1, :cond_1

    const-string v0, "mr_import_s_locale"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 117
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    if-nez v0, :cond_2

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrImportActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrImportActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "mr_words_locale"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 118
    :cond_2
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->loadLanguages()V

    .line 119
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLang;->remember(Landroid/content/SharedPreferences;Ljava/lang/String;)V

    .line 121
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 122
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->bg:I

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-virtual {v1, v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 123
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 124
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

    .line 125
    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-direct {v2, v3, v4}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 126
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

    .line 128
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

    .line 132
    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 128
    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 133
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

    .line 136
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->panel()Landroid/widget/LinearLayout;

    move-result-object v9

    .line 137
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0xe

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v9, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 138
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

    .line 139
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangBox:Landroid/widget/LinearLayout;

    .line 140
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangBox:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xa

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 141
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

    .line 143
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

    .line 145
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    const/4 v3, 0x6

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setMinLines(I)V

    .line 146
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    const/16 v3, 0x30

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setGravity(I)V

    .line 147
    if-eqz p1, :cond_3

    const-string v2, "mr_import_s_text"

    invoke-virtual {p1, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    const-string v3, "mr_import_s_text"

    invoke-virtual {p1, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 148
    :cond_3
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    new-instance v3, Lcom/mrkeyboard/app/MrImportActivity$2;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrImportActivity$2;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 166
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    const/high16 v4, 0x41400000    # 12.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->hint:I

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mCount:Landroid/widget/TextView;

    .line 167
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mCount:Landroid/widget/TextView;

    const v3, 0x800005

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setGravity(I)V

    .line 168
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

    .line 169
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

    .line 170
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->updateCount()V

    .line 173
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

    .line 178
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiButton:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xc

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 179
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

    .line 184
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAnalyze:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xc

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 185
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    const/high16 v4, 0x41500000    # 13.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    .line 186
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

    .line 187
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    .line 188
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 190
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    const/high16 v4, 0x41600000    # 14.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    .line 191
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

    .line 192
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    .line 193
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 194
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

    .line 200
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    .line 201
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x8

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 204
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->panel()Landroid/widget/LinearLayout;

    move-result-object v9

    .line 205
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

    .line 206
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

    .line 207
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

    .line 211
    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 207
    invoke-virtual {v9, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 212
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0x16

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v9, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 214
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    const-string v4, "mr_ui_ic_undo"

    const/4 v5, 0x0

    new-instance v6, Lcom/mrkeyboard/app/MrImportActivity$7;

    invoke-direct {v6, p0}, Lcom/mrkeyboard/app/MrImportActivity$7;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->iconButton(Ljava/lang/String;Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    .line 219
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x12

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 221
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->setContentView(Landroid/view/View;)V

    .line 222
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->restore(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    .line 223
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshOffer()V

    goto/16 :goto_0
.end method

.method protected onDestroy()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 100
    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 101
    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    .line 102
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->dismissPreview()V

    .line 103
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 104
    return-void
.end method

.method protected onResume()V
    .locals 1

    .prologue
    .line 228
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 229
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    if-nez v0, :cond_0

    .line 232
    :goto_0
    return-void

    .line 230
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshLanguages()V

    .line 231
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshUndo()V

    goto :goto_0
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 90
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 91
    const-string v0, "mr_import_s_locale"

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 92
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    if-nez v0, :cond_1

    move-object v0, v1

    .line 93
    :goto_0
    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-lez v2, :cond_0

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    const v3, 0x186a0

    if-gt v2, v3, :cond_0

    const-string v2, "mr_import_s_text"

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v2, v0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 94
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->save(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    .line 95
    return-void

    .line 92
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    goto :goto_0
.end method
