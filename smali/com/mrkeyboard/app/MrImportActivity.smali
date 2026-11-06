.class public Lcom/mrkeyboard/app/MrImportActivity;
.super Landroid/app/Activity;
.source "MrImportActivity.java"


# static fields
.field static final EXTRA_LOCALE:Ljava/lang/String; = "mr_words_locale"

.field static final MAX_FILE_BYTES:I = 0x800000

.field private static final PREFS:Ljava/lang/String; = "mr_words"

.field static final PREVIEW_PAGE:I = 0x64

.field private static final P_BATCH:Ljava/lang/String; = "last_batch"

.field private static final P_COUNT:Ljava/lang/String; = "last_count"

.field private static final P_LOCALE:Ljava/lang/String; = "last_locale"

.field private static final REQ_OPEN:I = 0x1bbe

.field private static final SAVE_TEXT_MAX:I = 0x186a0

.field private static final S_LOCALE:Ljava/lang/String; = "mr_import_s_locale"

.field private static final S_TEXT:Ljava/lang/String; = "mr_import_s_text"


# instance fields
.field private k:Lcom/mrkeyboard/app/MrKit;

.field private mAiBeforeBox:Ljava/lang/String;

.field private mAiBeforeFile:Ljava/lang/String;

.field private mAiButton:Landroid/widget/TextView;

.field private mAiCancel:Landroid/widget/TextView;

.field private volatile mAiCancelled:Z

.field private mAiNote:Landroid/widget/TextView;

.field private mAiUndo:Landroid/widget/TextView;

.field private mAnalyze:Landroid/widget/TextView;

.field private mApply:Landroid/widget/TextView;

.field private mBusy:Z

.field private mFileKb:I

.field private mFileLabel:Landroid/widget/TextView;

.field private mFileText:Ljava/lang/String;

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
    .line 41
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 60
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrImportActivity;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 41
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileText:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->dropFile()V

    return-void
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/TextView;
    .locals 1

    .prologue
    .line 41
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->copyPrompt()V

    return-void
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->undoLast()V

    return-void
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/MrImportActivity;)Z
    .locals 1

    .prologue
    .line 41
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    return v0
.end method

.method static synthetic access$1402(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 41
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/content/SharedPreferences;
    .locals 1

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$1600(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->clearPreview()V

    return-void
.end method

.method static synthetic access$1700(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshLanguages()V

    return-void
.end method

.method static synthetic access$1800(Lcom/mrkeyboard/app/MrImportActivity;ZLjava/lang/String;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    return-void
.end method

.method static synthetic access$1900(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;
    .locals 1

    .prologue
    .line 41
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    return-object v0
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrImportActivity;)Z
    .locals 1

    .prologue
    .line 41
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mSetting:Z

    return v0
.end method

.method static synthetic access$2000(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 41
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$2100(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->showFile(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$2200(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->prepareAi(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$2302(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImport$Plan;)Lcom/mrkeyboard/app/MrImport$Plan;
    .locals 0

    .prologue
    .line 41
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    return-object p1
.end method

.method static synthetic access$2400(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->showPreview()V

    return-void
.end method

.method static synthetic access$2500(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->showIgnored()V

    return-void
.end method

.method static synthetic access$2600(Lcom/mrkeyboard/app/MrImportActivity;Z)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->tickAll(Z)V

    return-void
.end method

.method static synthetic access$2700(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->drawWords()V

    return-void
.end method

.method static synthetic access$2800(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->apply()V

    return-void
.end method

.method static synthetic access$2900(Lcom/mrkeyboard/app/MrImport$NewWord;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 41
    invoke-static {p0}, Lcom/mrkeyboard/app/MrImportActivity;->mark(Lcom/mrkeyboard/app/MrImport$NewWord;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->hideAiResult()V

    return-void
.end method

.method static synthetic access$3000(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->updateApply()V

    return-void
.end method

.method static synthetic access$3100(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/MrImportActivity;->remember(Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$3200(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrLearned$Result;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->report(Lcom/mrkeyboard/app/MrLearned$Result;)V

    return-void
.end method

.method static synthetic access$3300(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshUndo()V

    return-void
.end method

.method static synthetic access$3400(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->askToSend(Lcom/mrkeyboard/app/MrImportAi$Plan;)V

    return-void
.end method

.method static synthetic access$3500(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->runAi(Lcom/mrkeyboard/app/MrImportAi$Plan;)V

    return-void
.end method

.method static synthetic access$3600(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/TextView;
    .locals 1

    .prologue
    .line 41
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$3700(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Result;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrImportActivity;->finishAi(Lcom/mrkeyboard/app/MrImportAi$Result;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$3800(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrWordStore;
    .locals 1

    .prologue
    .line 41
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    return-object v0
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->paste()V

    return-void
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->openFile()V

    return-void
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->formatTapped()V

    return-void
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->undoAi()V

    return-void
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->analyze()V

    return-void
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/MrImportActivity;)Z
    .locals 1

    .prologue
    .line 41
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancelled:Z

    return v0
.end method

.method static synthetic access$902(Lcom/mrkeyboard/app/MrImportActivity;Z)Z
    .locals 0

    .prologue
    .line 41
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancelled:Z

    return p1
.end method

.method private analyze()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 411
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-eqz v0, :cond_0

    .line 467
    :goto_0
    return-void

    .line 412
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->source()Ljava/lang/String;

    move-result-object v0

    .line 413
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 414
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_nothing"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 417
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 418
    invoke-static {v0}, Lcom/mrkeyboard/app/MrImport;->isStandard(Ljava/lang/String;)Z

    move-result v2

    .line 419
    const/4 v3, 0x1

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_working"

    new-array v6, v6, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 420
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->clearPreview()V

    .line 421
    new-instance v3, Ljava/lang/Thread;

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$13;

    invoke-direct {v4, p0, v1, v2, v0}, Lcom/mrkeyboard/app/MrImportActivity$13;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;ZLjava/lang/String;)V

    invoke-direct {v3, v4}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 466
    invoke-virtual {v3}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private apply()V
    .locals 7

    .prologue
    .line 626
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    if-nez v0, :cond_1

    .line 660
    :cond_0
    :goto_0
    return-void

    .line 627
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 628
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 629
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    .line 630
    const/4 v3, 0x1

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_saving"

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 631
    new-instance v3, Ljava/lang/Thread;

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$20;

    invoke-direct {v4, p0, v2, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity$20;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrWordStore;Lcom/mrkeyboard/app/MrImport$Plan;Ljava/lang/String;)V

    invoke-direct {v3, v4}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 659
    invoke-virtual {v3}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private askToSend(Lcom/mrkeyboard/app/MrImportAi$Plan;)V
    .locals 8

    .prologue
    const/4 v5, 0x2

    const/4 v7, 0x1

    const/4 v6, 0x0

    .line 741
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->serviceHost(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 742
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_import_ai_your_service"

    new-array v2, v6, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 743
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

    .line 744
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

    .line 745
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

    .line 746
    :cond_2
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_ai_ask_title"

    new-array v4, v6, [Ljava/lang/Object;

    .line 747
    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 748
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_dont"

    new-array v3, v6, [Ljava/lang/Object;

    .line 749
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_send"

    new-array v3, v6, [Ljava/lang/Object;

    .line 750
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$23;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/MrImportActivity$23;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 755
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 756
    return-void
.end method

.method private clearPreview()V
    .locals 2

    .prologue
    .line 472
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 473
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    .line 474
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    if-eqz v0, :cond_0

    .line 475
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 476
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 478
    :cond_0
    return-void
.end method

.method private copyPrompt()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 296
    :try_start_0
    const-string v0, "clipboard"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/ClipboardManager;

    .line 297
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

    .line 298
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

    .line 302
    :goto_0
    return-void

    .line 299
    :catch_0
    move-exception v0

    .line 300
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_clip_empty"

    new-array v3, v5, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private drawWords()V
    .locals 9

    .prologue
    const/4 v2, 0x0

    .line 551
    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 552
    if-eqz v4, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    if-nez v0, :cond_1

    .line 568
    :cond_0
    :goto_0
    return-void

    .line 553
    :cond_1
    iget-object v0, v4, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    iget v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    add-int/lit8 v1, v1, 0x64

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 554
    iget v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    move v3, v0

    :goto_1
    if-ge v3, v5, :cond_4

    .line 555
    iget-object v0, v4, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrImport$NewWord;

    .line 556
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

    .line 557
    new-instance v6, Lcom/mrkeyboard/app/MrImportActivity$19;

    invoke-direct {v6, p0, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity$19;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImport$NewWord;Landroid/widget/LinearLayout;)V

    invoke-virtual {v1, v6}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 564
    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    if-nez v3, :cond_3

    move v0, v2

    :goto_3
    invoke-virtual {v7, v0}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v6, v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 554
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_1

    .line 556
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

    .line 564
    :cond_3
    const/4 v0, 0x6

    goto :goto_3

    .line 566
    :cond_4
    iput v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    .line 567
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

.method private dropFile()V
    .locals 2

    .prologue
    .line 380
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileText:Ljava/lang/String;

    .line 381
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileLabel:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 382
    return-void
.end method

.method private failureText(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 814
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

.method private finishAi(Lcom/mrkeyboard/app/MrImportAi$Result;Ljava/lang/String;Ljava/lang/String;)V
    .locals 10

    .prologue
    const/4 v9, 0x2

    const/4 v8, 0x1

    const/4 v7, 0x0

    const/4 v6, 0x0

    .line 818
    invoke-direct {p0, v6, v7}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 819
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 820
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrImportActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 851
    :cond_0
    :goto_0
    return-void

    .line 821
    :cond_1
    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrImportAi$Result;->empty()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 823
    iget-object v0, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->failure:Ljava/lang/String;

    if-eqz v0, :cond_2

    .line 824
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_fail_title"

    new-array v3, v6, [Ljava/lang/Object;

    .line 825
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->failure:Ljava/lang/String;

    .line 826
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->failureText(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_ok"

    new-array v3, v6, [Ljava/lang/Object;

    .line 827
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v7}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 828
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0

    .line 830
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

    .line 834
    :cond_4
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->dropFile()V

    .line 835
    iget-object v0, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->text:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->setBox(Ljava/lang/String;)V

    .line 836
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->clearPreview()V

    .line 838
    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiBeforeBox:Ljava/lang/String;

    .line 839
    iput-object p3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiBeforeFile:Ljava/lang/String;

    .line 840
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiUndo:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    .line 841
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

    .line 842
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    .line 843
    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrImportAi$Result;->complete()Z

    move-result v0

    if-nez v0, :cond_0

    .line 844
    iget-object v0, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->failure:Ljava/lang/String;

    if-eqz v0, :cond_5

    iget-object v0, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->failure:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->failureText(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 845
    :goto_2
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_ai_partial_title"

    new-array v4, v6, [Ljava/lang/Object;

    .line 846
    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_ai_partial"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    iget v5, p1, Lcom/mrkeyboard/app/MrImportAi$Result;->done:I

    .line 847
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

    .line 848
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v7}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 849
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto/16 :goto_0

    .line 844
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

    .line 681
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-eqz v0, :cond_0

    .line 709
    :goto_0
    return-void

    .line 682
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->source()Ljava/lang/String;

    move-result-object v0

    .line 683
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 684
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_nothing"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 687
    :cond_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrImport;->isStandard(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 688
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_already"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 691
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->configured(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 692
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_nokey_title"

    new-array v3, v4, [Ljava/lang/Object;

    .line 693
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_nokey_text"

    new-array v3, v4, [Ljava/lang/Object;

    .line 694
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_cancel"

    new-array v3, v4, [Ljava/lang/Object;

    .line 695
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_nokey_open"

    new-array v3, v4, [Ljava/lang/Object;

    .line 696
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$21;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrImportActivity$21;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 705
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto/16 :goto_0

    .line 708
    :cond_3
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->prepareAi(Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method private hideAiResult()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/16 v1, 0x8

    .line 854
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiUndo:Landroid/widget/TextView;

    if-nez v0, :cond_0

    .line 859
    :goto_0
    return-void

    .line 855
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiUndo:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 856
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 857
    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiBeforeBox:Ljava/lang/String;

    .line 858
    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiBeforeFile:Ljava/lang/String;

    goto :goto_0
.end method

.method private loadLanguages()V
    .locals 4

    .prologue
    .line 254
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    invoke-interface {v0}, Lcom/mrkeyboard/app/MrWordStore;->locales()Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 258
    :goto_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->installedIds(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrLang;->offered(Ljava/util/List;Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    .line 259
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

    .line 260
    return-void

    .line 255
    :catch_0
    move-exception v0

    .line 256
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    goto :goto_0
.end method

.method private static mark(Lcom/mrkeyboard/app/MrImport$NewWord;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 571
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

.method private openFile()V
    .locals 4

    .prologue
    .line 305
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 306
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 307
    const-string v1, "*/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 309
    const/16 v1, 0x1bbe

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 313
    :goto_0
    return-void

    .line 310
    :catch_0
    move-exception v0

    .line 311
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_no_files"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private pairsToAdd()I
    .locals 5

    .prologue
    .line 586
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 587
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    .line 588
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

    .line 589
    :cond_1
    invoke-virtual {v2}, Ljava/util/HashSet;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->pairs:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    .line 592
    :cond_2
    return v1

    .line 590
    :cond_3
    const/4 v0, 0x0

    .line 591
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

.method private paste()V
    .locals 5

    .prologue
    const/4 v1, 0x0

    const/4 v4, 0x0

    .line 279
    :try_start_0
    const-string v0, "clipboard"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/ClipboardManager;

    .line 280
    if-nez v0, :cond_1

    move-object v0, v1

    .line 281
    :goto_0
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/content/ClipData;->getItemCount()I

    move-result v2

    if-lez v2, :cond_2

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/content/ClipData;->getItemAt(I)Landroid/content/ClipData$Item;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/content/ClipData$Item;->coerceToText(Landroid/content/Context;)Ljava/lang/CharSequence;

    move-result-object v0

    .line 282
    :goto_1
    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-nez v1, :cond_3

    .line 283
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_clip_empty"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    .line 292
    :goto_2
    return-void

    .line 280
    :cond_1
    invoke-virtual {v0}, Landroid/content/ClipboardManager;->getPrimaryClip()Landroid/content/ClipData;

    move-result-object v0

    goto :goto_0

    :cond_2
    move-object v0, v1

    .line 281
    goto :goto_1

    .line 286
    :cond_3
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->dropFile()V

    .line 287
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 288
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->clearPreview()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 289
    :catch_0
    move-exception v0

    .line 290
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_clip_empty"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_2
.end method

.method private prefs()Landroid/content/SharedPreferences;
    .locals 2

    .prologue
    .line 880
    const-string v0, "mr_words"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method private prepareAi(Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 713
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-eqz v0, :cond_0

    .line 737
    :goto_0
    return-void

    .line 714
    :cond_0
    const/4 v0, 0x1

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_preparing"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 715
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/mrkeyboard/app/MrImportActivity$22;

    invoke-direct {v1, p0, p1}, Lcom/mrkeyboard/app/MrImportActivity$22;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 736
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private refreshLanguages()V
    .locals 5

    .prologue
    .line 263
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangBox:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$11;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$11;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->languageCard(Landroid/widget/LinearLayout;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/MrKit$LangPick;)V

    .line 273
    return-void
.end method

.method private refreshUndo()V
    .locals 7

    .prologue
    const-wide/16 v2, 0x0

    const/4 v6, 0x0

    .line 889
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "last_batch"

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    .line 890
    cmp-long v0, v0, v2

    if-gtz v0, :cond_0

    .line 891
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 896
    :goto_0
    return-void

    .line 894
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

    .line 895
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0
.end method

.method private remember(Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 884
    iget-wide v0, p1, Lcom/mrkeyboard/app/MrLearned$Result;->batch:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    iget v0, p1, Lcom/mrkeyboard/app/MrLearned$Result;->words:I

    iget v1, p1, Lcom/mrkeyboard/app/MrLearned$Result;->pairs:I

    add-int/2addr v0, v1

    if-nez v0, :cond_1

    .line 886
    :cond_0
    :goto_0
    return-void

    .line 885
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

    .line 663
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 664
    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrLearned$Result;->total()I

    move-result v1

    if-nez v1, :cond_4

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_added_none"

    new-array v3, v7, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 666
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

    .line 667
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

    .line 668
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

    .line 669
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

    .line 670
    :cond_3
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_done_title"

    new-array v4, v7, [Ljava/lang/Object;

    .line 671
    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 672
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_ok"

    new-array v3, v7, [Ljava/lang/Object;

    .line 673
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 674
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 675
    return-void

    .line 665
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
    .locals 9

    .prologue
    const/4 v8, 0x1

    const/4 v5, 0x0

    .line 759
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-eqz v0, :cond_0

    .line 811
    :goto_0
    return-void

    .line 760
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->tag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 761
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    if-nez v0, :cond_1

    const-string v6, ""

    .line 762
    :goto_1
    iget-object v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileText:Ljava/lang/String;

    .line 763
    iput-boolean v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancelled:Z

    .line 764
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_import_ai_progress"

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v5

    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrImportAi$Plan;->requests()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v8

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v8, v0}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 765
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setVisibility(I)V

    .line 766
    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$24;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$24;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 775
    new-instance v5, Lcom/mrkeyboard/app/MrImportActivity$25;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrImportActivity$25;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 789
    new-instance v8, Ljava/lang/Thread;

    new-instance v0, Lcom/mrkeyboard/app/MrImportActivity$26;

    move-object v1, p0

    move-object v2, p1

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/MrImportActivity$26;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;Ljava/lang/String;Lcom/mrkeyboard/app/MrImportAi$Sender;Lcom/mrkeyboard/app/MrImportAi$Control;Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {v8, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 810
    invoke-virtual {v8}, Ljava/lang/Thread;->start()V

    goto :goto_0

    .line 761
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v6

    goto :goto_1
.end method

.method private setBox(Ljava/lang/String;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 385
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mSetting:Z

    .line 387
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 389
    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mSetting:Z

    .line 391
    return-void

    .line 389
    :catchall_0
    move-exception v0

    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mSetting:Z

    .line 390
    throw v0
.end method

.method private setBusy(ZLjava/lang/String;)V
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 402
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    .line 403
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAnalyze:Landroid/widget/TextView;

    if-nez p1, :cond_1

    move v0, v1

    :goto_0
    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setClickable(Z)V

    .line 404
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiButton:Landroid/widget/TextView;

    if-nez p1, :cond_2

    move v0, v1

    :goto_1
    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setClickable(Z)V

    .line 405
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    if-nez p1, :cond_3

    :goto_2
    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setEnabled(Z)V

    .line 406
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    if-nez p2, :cond_0

    const-string p2, ""

    :cond_0
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 407
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    if-eqz p1, :cond_4

    :goto_3
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 408
    return-void

    :cond_1
    move v0, v2

    .line 403
    goto :goto_0

    :cond_2
    move v0, v2

    .line 404
    goto :goto_1

    :cond_3
    move v1, v2

    .line 405
    goto :goto_2

    .line 407
    :cond_4
    const/16 v2, 0x8

    goto :goto_3
.end method

.method private showFile(Ljava/lang/String;)V
    .locals 6

    .prologue
    const/4 v3, 0x1

    const/4 v5, 0x0

    .line 373
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileText:Ljava/lang/String;

    .line 374
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    div-int/lit16 v0, v0, 0x400

    invoke-static {v3, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileKb:I

    .line 375
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileLabel:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_file_loaded"

    new-array v3, v3, [Ljava/lang/Object;

    iget v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileKb:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v5

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 376
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileLabel:Landroid/widget/TextView;

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setVisibility(I)V

    .line 377
    return-void
.end method

.method private showIgnored()V
    .locals 10

    .prologue
    const/4 v9, 0x1

    const/4 v8, 0x0

    .line 607
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 608
    if-nez v1, :cond_0

    .line 621
    :goto_0
    return-void

    .line 609
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 610
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

    .line 611
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

    .line 613
    :cond_1
    iget v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    iget-object v3, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignored:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-le v0, v3, :cond_2

    .line 614
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

    .line 616
    :cond_2
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_see_ignored"

    new-array v5, v9, [Ljava/lang/Object;

    iget v1, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    .line 617
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v5, v8

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 618
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_ok"

    new-array v3, v8, [Ljava/lang/Object;

    .line 619
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 620
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto/16 :goto_0
.end method

.method private showPreview()V
    .locals 12

    .prologue
    const/16 v11, 0x8

    const/4 v10, 0x4

    const/high16 v9, 0x41600000    # 14.0f

    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 481
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 482
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 483
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v7}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 484
    iput v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    .line 485
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-boolean v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->standard:Z

    if-eqz v0, :cond_5

    const-string v0, "mr_import_found_std"

    :goto_0
    new-array v5, v7, [Ljava/lang/Object;

    invoke-virtual {v4, v0, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/high16 v4, 0x41900000    # 18.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v3, v0, v4, v5, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 486
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_counts"

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Object;

    iget-object v6, v1, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v7

    iget-object v6, v1, Lcom/mrkeyboard/app/MrImport$Plan;->pairs:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v8

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/high16 v4, 0x41700000    # 15.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v2, v3, v4, v5, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x6

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 487
    iget-object v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->blocked:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 488
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_blocked_found"

    new-array v5, v8, [Ljava/lang/Object;

    iget-object v6, v1, Lcom/mrkeyboard/app/MrImport$Plan;->blocked:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v7

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v3, v9, v4, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v10}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 490
    :cond_0
    iget v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->knownSkipped:I

    if-lez v0, :cond_1

    .line 491
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_known"

    new-array v5, v8, [Ljava/lang/Object;

    iget v6, v1, Lcom/mrkeyboard/app/MrImport$Plan;->knownSkipped:I

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v7

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v3, v9, v4, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v10}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 493
    :cond_1
    iget-boolean v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->pairsCut:Z

    if-eqz v0, :cond_2

    .line 494
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_pairs_cut"

    new-array v5, v7, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v3, v9, v4, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v10}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 496
    :cond_2
    iget-object v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->languageHint:Ljava/lang/String;

    .line 497
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_3

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->localeOf(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    .line 498
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_lang_note"

    const/4 v6, 0x2

    new-array v6, v6, [Ljava/lang/Object;

    aput-object v0, v6, v7

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->tag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v6, v8

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->rose:I

    invoke-virtual {v3, v0, v9, v4, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x6

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 500
    :cond_3
    iget v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    if-lez v0, :cond_4

    .line 501
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_see_ignored"

    new-array v5, v8, [Ljava/lang/Object;

    iget v6, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v7

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$14;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$14;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v7, v4}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xa

    .line 505
    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 501
    invoke-virtual {v0, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 507
    :cond_4
    iget-object v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_6

    iget-object v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->pairs:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_6

    iget-object v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->blocked:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 508
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_none_new"

    new-array v4, v7, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v1, v2, v9, v3, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0xa

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 509
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    .line 547
    :goto_1
    return-void

    .line 485
    :cond_5
    const-string v0, "mr_import_found"

    goto/16 :goto_0

    .line 512
    :cond_6
    iget-object v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_7

    .line 513
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_untick"

    new-array v4, v7, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/high16 v3, 0x41500000    # 13.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v1, v2, v3, v4, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0xe

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 514
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 515
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_all"

    new-array v4, v7, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/mrkeyboard/app/MrImportActivity$15;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrImportActivity$15;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v1, v2, v7, v3}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v1

    .line 520
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_none"

    new-array v5, v7, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$16;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$16;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v7, v4}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    .line 525
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, -0x2

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v3, v7, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 526
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x2

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v1, v7, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 527
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41000000    # 8.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v1, v3, v7, v7, v7}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 528
    invoke-virtual {v0, v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 529
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v11}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 530
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    .line 531
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v11}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 532
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_learned_more"

    new-array v3, v7, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$17;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrImportActivity$17;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v0, v1, v7, v2}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mMoreWords:Landroid/widget/TextView;

    .line 537
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mMoreWords:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v11}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 538
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->drawWords()V

    .line 540
    :cond_7
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, ""

    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$18;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrImportActivity$18;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v0, v1, v8, v2}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    .line 545
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0x10

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 546
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->updateApply()V

    goto/16 :goto_1
.end method

.method private source()Ljava/lang/String;
    .locals 1

    .prologue
    .line 394
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileText:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileText:Ljava/lang/String;

    .line 396
    :goto_0
    return-object v0

    .line 395
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    .line 396
    if-nez v0, :cond_1

    const-string v0, ""

    goto :goto_0

    :cond_1
    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private tickAll(Z)V
    .locals 2

    .prologue
    .line 575
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 576
    if-nez v0, :cond_0

    .line 582
    :goto_0
    return-void

    .line 577
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

    .line 578
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 579
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    .line 580
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->drawWords()V

    .line 581
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->updateApply()V

    goto :goto_0
.end method

.method private undoAi()V
    .locals 4

    .prologue
    .line 862
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiBeforeBox:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 875
    :cond_0
    :goto_0
    return-void

    .line 863
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiBeforeBox:Ljava/lang/String;

    .line 864
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiBeforeFile:Ljava/lang/String;

    .line 865
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->dropFile()V

    .line 866
    if-eqz v1, :cond_2

    .line 867
    const-string v0, ""

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->setBox(Ljava/lang/String;)V

    .line 868
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->showFile(Ljava/lang/String;)V

    .line 872
    :goto_1
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->clearPreview()V

    .line 873
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->hideAiResult()V

    .line 874
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_ai_undone"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 870
    :cond_2
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->setBox(Ljava/lang/String;)V

    goto :goto_1
.end method

.method private undoLast()V
    .locals 10

    .prologue
    const-wide/16 v6, 0x0

    const/4 v9, 0x0

    .line 899
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "last_batch"

    invoke-interface {v0, v1, v6, v7}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    .line 900
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v2

    const-string v3, "last_locale"

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 901
    cmp-long v3, v0, v6

    if-lez v3, :cond_0

    if-nez v2, :cond_1

    .line 922
    :cond_0
    :goto_0
    return-void

    .line 902
    :cond_1
    new-instance v3, Landroid/app/AlertDialog$Builder;

    invoke-direct {v3, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_undo_title"

    new-array v6, v9, [Ljava/lang/Object;

    .line 903
    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_undo_ask"

    const/4 v6, 0x2

    new-array v6, v6, [Ljava/lang/Object;

    .line 904
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

    .line 905
    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_words_undo"

    new-array v6, v9, [Ljava/lang/Object;

    .line 906
    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lcom/mrkeyboard/app/MrImportActivity$27;

    invoke-direct {v5, p0, v2, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity$27;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;J)V

    invoke-virtual {v3, v4, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 921
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private updateApply()V
    .locals 9

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 596
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    if-nez v0, :cond_1

    .line 604
    :cond_0
    :goto_0
    return-void

    .line 597
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImport$Plan;->checkedWords()I

    move-result v3

    .line 598
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->pairsToAdd()I

    move-result v4

    .line 599
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImport$Plan;->blocked:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    .line 600
    add-int v5, v3, v4

    add-int/2addr v0, v5

    if-lez v0, :cond_2

    move v0, v1

    .line 601
    :goto_1
    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    if-eqz v0, :cond_3

    iget-object v6, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_import_apply"

    const/4 v8, 0x2

    new-array v8, v8, [Ljava/lang/Object;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v8, v2

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v8, v1

    invoke-virtual {v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    :goto_2
    invoke-virtual {v5, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 602
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setClickable(Z)V

    .line 603
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    if-eqz v0, :cond_4

    const/high16 v0, 0x3f800000    # 1.0f

    :goto_3
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setAlpha(F)V

    goto :goto_0

    :cond_2
    move v0, v2

    .line 600
    goto :goto_1

    .line 601
    :cond_3
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_apply_none"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v1, v3, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    .line 603
    :cond_4
    const/high16 v0, 0x3f000000    # 0.5f

    goto :goto_3
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 92
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 93
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 5

    .prologue
    .line 317
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 318
    const/16 v0, 0x1bbe

    if-ne p1, v0, :cond_0

    const/4 v0, -0x1

    if-ne p2, v0, :cond_0

    if-eqz p3, :cond_0

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    if-nez v0, :cond_1

    .line 370
    :cond_0
    :goto_0
    return-void

    .line 319
    :cond_1
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    .line 320
    const/4 v1, 0x1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_reading"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 321
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$12;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrImportActivity$12;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Landroid/net/Uri;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 369
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 12

    .prologue
    const/high16 v11, 0x41500000    # 13.0f

    const/high16 v7, 0x41a00000    # 20.0f

    const/high16 v10, 0x40800000    # 4.0f

    const/16 v9, 0x8

    const/4 v8, 0x0

    .line 106
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 107
    new-instance v0, Lcom/mrkeyboard/app/MrKit;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrKit;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 108
    invoke-static {p0}, Lcom/mrkeyboard/app/MrLearned;->store(Landroid/content/Context;)Lcom/mrkeyboard/app/MrWordStore;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    .line 109
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    if-nez v0, :cond_0

    .line 110
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_learned_unavailable"

    new-array v3, v8, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    .line 111
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrImportActivity;->finish()V

    .line 239
    :goto_0
    return-void

    .line 114
    :cond_0
    if-eqz p1, :cond_1

    const-string v0, "mr_import_s_locale"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 115
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

    .line 116
    :cond_2
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->loadLanguages()V

    .line 117
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLang;->remember(Landroid/content/SharedPreferences;Ljava/lang/String;)V

    .line 119
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 120
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->bg:I

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v8, v3, v8}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 121
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 122
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41800000    # 16.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41c00000    # 24.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 123
    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-direct {v2, v3, v4}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 124
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41800000    # 16.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

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

    .line 126
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_title"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$1;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$1;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->header(Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 130
    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 126
    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 131
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_intro"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/high16 v4, 0x41600000    # 14.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v3, v4, v5, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v9}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 133
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangBox:Landroid/widget/LinearLayout;

    .line 134
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangBox:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x10

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 136
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_hint"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const v4, 0xa0001

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->field(Ljava/lang/String;I)Landroid/widget/EditText;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    .line 138
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    const/4 v3, 0x6

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setMinLines(I)V

    .line 139
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    const/16 v3, 0x30

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setGravity(I)V

    .line 140
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

    .line 141
    :cond_3
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    new-instance v3, Lcom/mrkeyboard/app/MrImportActivity$2;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrImportActivity$2;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 155
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xe

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 157
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v3, v11, v4, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileLabel:Landroid/widget/TextView;

    .line 158
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileLabel:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v10}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x40c00000    # 6.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v5, v10}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v2, v3, v4, v5, v8}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 159
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileLabel:Landroid/widget/TextView;

    invoke-virtual {v2, v9}, Landroid/widget/TextView;->setVisibility(I)V

    .line 160
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileLabel:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 162
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v2

    .line 163
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_paste"

    new-array v6, v8, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lcom/mrkeyboard/app/MrImportActivity$3;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrImportActivity$3;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v3, v4, v8, v5}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v3

    .line 168
    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_import_open"

    new-array v7, v8, [Ljava/lang/Object;

    invoke-virtual {v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lcom/mrkeyboard/app/MrImportActivity$4;

    invoke-direct {v6, p0}, Lcom/mrkeyboard/app/MrImportActivity$4;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v4, v5, v8, v6}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v4

    .line 173
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x2

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-direct {v5, v8, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v3, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 174
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, -0x2

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-direct {v3, v8, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 175
    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41000000    # 8.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v3, v5, v8, v8, v8}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 176
    invoke-virtual {v2, v4, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 177
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xa

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 179
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_ai_button"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$5;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$5;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v8, v4}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiButton:Landroid/widget/TextView;

    .line 184
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiButton:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v9}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 185
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v3, v11, v4, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    .line 186
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v10}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x40c00000    # 6.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v5, v10}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v2, v3, v4, v5, v8}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 187
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    invoke-virtual {v2, v9}, Landroid/widget/TextView;->setVisibility(I)V

    .line 188
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiNote:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 189
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_ai_undo"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$6;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$6;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v8, v4}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiUndo:Landroid/widget/TextView;

    .line 194
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiUndo:Landroid/widget/TextView;

    invoke-virtual {v2, v9}, Landroid/widget/TextView;->setVisibility(I)V

    .line 195
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiUndo:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v9}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 197
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_analyze"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    new-instance v5, Lcom/mrkeyboard/app/MrImportActivity$7;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrImportActivity$7;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAnalyze:Landroid/widget/TextView;

    .line 202
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAnalyze:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xc

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 203
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    const/high16 v4, 0x41600000    # 14.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v3, v4, v5, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    .line 204
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v10}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41000000    # 8.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v5, v10}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v2, v3, v4, v5, v8}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 205
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    invoke-virtual {v2, v9}, Landroid/widget/TextView;->setVisibility(I)V

    .line 206
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 207
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_words_cancel"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$8;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$8;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v8, v4}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    .line 213
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    invoke-virtual {v2, v9}, Landroid/widget/TextView;->setVisibility(I)V

    .line 214
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAiCancel:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v9}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 216
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    .line 217
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v9}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 218
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xa

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 221
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_ai_title"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/high16 v4, 0x41900000    # 18.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v6, 0x1

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x1a

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 222
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_ai_text"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/high16 v4, 0x41600000    # 14.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v3, v4, v5, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x6

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 223
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_ai_copy"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$9;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$9;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v8, v4}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xa

    .line 227
    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 223
    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 228
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_ai_warn"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->rose:I

    invoke-virtual {v2, v3, v11, v4, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v9}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 230
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$10;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$10;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v8, v4}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    .line 235
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x18

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 237
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->setContentView(Landroid/view/View;)V

    .line 238
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->restore(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    goto/16 :goto_0
.end method

.method protected onResume()V
    .locals 1

    .prologue
    .line 243
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 244
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    if-nez v0, :cond_0

    .line 247
    :goto_0
    return-void

    .line 245
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshLanguages()V

    .line 246
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshUndo()V

    goto :goto_0
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 97
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 98
    const-string v0, "mr_import_s_locale"

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 99
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    if-nez v0, :cond_1

    move-object v0, v1

    .line 100
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

    .line 101
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->save(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    .line 102
    return-void

    .line 99
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_0
.end method
