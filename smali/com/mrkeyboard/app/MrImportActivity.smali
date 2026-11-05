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

.method static synthetic access$002(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 41
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileText:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->dropFile()V

    return-void
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshLanguages()V

    return-void
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/MrImportActivity;ZLjava/lang/String;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    return-void
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;
    .locals 1

    .prologue
    .line 41
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    return-object v0
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 41
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/MrImportActivity;)I
    .locals 1

    .prologue
    .line 41
    iget v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileKb:I

    return v0
.end method

.method static synthetic access$1402(Lcom/mrkeyboard/app/MrImportActivity;I)I
    .locals 0

    .prologue
    .line 41
    iput p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileKb:I

    return p1
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/TextView;
    .locals 1

    .prologue
    .line 41
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileLabel:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$1602(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImport$Plan;)Lcom/mrkeyboard/app/MrImport$Plan;
    .locals 0

    .prologue
    .line 41
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    return-object p1
.end method

.method static synthetic access$1700(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->showPreview()V

    return-void
.end method

.method static synthetic access$1800(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->showIgnored()V

    return-void
.end method

.method static synthetic access$1900(Lcom/mrkeyboard/app/MrImportActivity;Z)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->tickAll(Z)V

    return-void
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->paste()V

    return-void
.end method

.method static synthetic access$2000(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->drawWords()V

    return-void
.end method

.method static synthetic access$2100(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->apply()V

    return-void
.end method

.method static synthetic access$2200(Lcom/mrkeyboard/app/MrImport$NewWord;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 41
    invoke-static {p0}, Lcom/mrkeyboard/app/MrImportActivity;->mark(Lcom/mrkeyboard/app/MrImport$NewWord;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$2300(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->updateApply()V

    return-void
.end method

.method static synthetic access$2400(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/MrImportActivity;->remember(Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$2500(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrLearned$Result;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->report(Lcom/mrkeyboard/app/MrLearned$Result;)V

    return-void
.end method

.method static synthetic access$2600(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshUndo()V

    return-void
.end method

.method static synthetic access$2700(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrWordStore;
    .locals 1

    .prologue
    .line 41
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    return-object v0
.end method

.method static synthetic access$2800(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/content/SharedPreferences;
    .locals 1

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->openFile()V

    return-void
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->analyze()V

    return-void
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->copyPrompt()V

    return-void
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->undoLast()V

    return-void
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/MrImportActivity;)Z
    .locals 1

    .prologue
    .line 41
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    return v0
.end method

.method static synthetic access$802(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 41
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->clearPreview()V

    return-void
.end method

.method private analyze()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 372
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-eqz v0, :cond_0

    .line 428
    :goto_0
    return-void

    .line 373
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->source()Ljava/lang/String;

    move-result-object v0

    .line 374
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 375
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_nothing"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 378
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 379
    invoke-static {v0}, Lcom/mrkeyboard/app/MrImport;->isStandard(Ljava/lang/String;)Z

    move-result v2

    .line 380
    const/4 v3, 0x1

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_working"

    new-array v6, v6, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 381
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->clearPreview()V

    .line 382
    new-instance v3, Ljava/lang/Thread;

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$10;

    invoke-direct {v4, p0, v1, v2, v0}, Lcom/mrkeyboard/app/MrImportActivity$10;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;ZLjava/lang/String;)V

    invoke-direct {v3, v4}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 427
    invoke-virtual {v3}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private apply()V
    .locals 7

    .prologue
    .line 587
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    if-nez v0, :cond_1

    .line 621
    :cond_0
    :goto_0
    return-void

    .line 588
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 589
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 590
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    .line 591
    const/4 v3, 0x1

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_saving"

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 592
    new-instance v3, Ljava/lang/Thread;

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$17;

    invoke-direct {v4, p0, v2, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity$17;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrWordStore;Lcom/mrkeyboard/app/MrImport$Plan;Ljava/lang/String;)V

    invoke-direct {v3, v4}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 620
    invoke-virtual {v3}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private clearPreview()V
    .locals 2

    .prologue
    .line 433
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 434
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    .line 435
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    if-eqz v0, :cond_0

    .line 436
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 437
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 439
    :cond_0
    return-void
.end method

.method private copyPrompt()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 274
    :try_start_0
    const-string v0, "clipboard"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/ClipboardManager;

    .line 275
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

    .line 276
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

    .line 280
    :goto_0
    return-void

    .line 277
    :catch_0
    move-exception v0

    .line 278
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

.method private dropFile()V
    .locals 2

    .prologue
    .line 352
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileText:Ljava/lang/String;

    .line 353
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileLabel:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 354
    return-void
.end method

.method private loadLanguages()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 214
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    invoke-interface {v0}, Lcom/mrkeyboard/app/MrWordStore;->locales()Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 218
    :goto_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->installedIds(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrLearned;->languages(Ljava/util/List;Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    .line 219
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 220
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    const-string v1, "pt_BR"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 221
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    const-string v1, "en_US"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 222
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    const-string v1, "es"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 224
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 225
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrImportActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v0, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v2

    .line 226
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    invoke-interface {v0, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 227
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 228
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->splitLocale(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    aget-object v4, v4, v5

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 233
    :goto_1
    iput-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 235
    :cond_3
    return-void

    .line 215
    :catch_0
    move-exception v0

    .line 216
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    goto :goto_0

    :cond_4
    move-object v1, v0

    goto :goto_1
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

.method private openFile()V
    .locals 4

    .prologue
    .line 283
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 284
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 285
    const-string v1, "*/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 287
    const/16 v1, 0x1bbe

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 291
    :goto_0
    return-void

    .line 288
    :catch_0
    move-exception v0

    .line 289
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

.method private paste()V
    .locals 5

    .prologue
    const/4 v1, 0x0

    const/4 v4, 0x0

    .line 257
    :try_start_0
    const-string v0, "clipboard"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/ClipboardManager;

    .line 258
    if-nez v0, :cond_1

    move-object v0, v1

    .line 259
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

    .line 260
    :goto_1
    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-nez v1, :cond_3

    .line 261
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_clip_empty"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    .line 270
    :goto_2
    return-void

    .line 258
    :cond_1
    invoke-virtual {v0}, Landroid/content/ClipboardManager;->getPrimaryClip()Landroid/content/ClipData;

    move-result-object v0

    goto :goto_0

    :cond_2
    move-object v0, v1

    .line 259
    goto :goto_1

    .line 264
    :cond_3
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->dropFile()V

    .line 265
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 266
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->clearPreview()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 267
    :catch_0
    move-exception v0

    .line 268
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
    .line 641
    const-string v0, "mr_words"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method private refreshLanguages()V
    .locals 7

    .prologue
    .line 238
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 239
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangs:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 240
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v0}, Lcom/mrkeyboard/app/MrKit;->langName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    new-instance v6, Lcom/mrkeyboard/app/MrImportActivity$8;

    invoke-direct {v6, p0, v0}, Lcom/mrkeyboard/app/MrImportActivity$8;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)V

    invoke-virtual {v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 250
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangBox:Landroid/widget/LinearLayout;

    const/4 v3, 0x2

    invoke-virtual {v0, v2, v1, v3}, Lcom/mrkeyboard/app/MrKit;->fill(Landroid/widget/LinearLayout;Ljava/util/List;I)V

    .line 251
    return-void
.end method

.method private refreshUndo()V
    .locals 7

    .prologue
    const-wide/16 v2, 0x0

    const/4 v6, 0x0

    .line 650
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "last_batch"

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    .line 651
    cmp-long v0, v0, v2

    if-gtz v0, :cond_0

    .line 652
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 657
    :goto_0
    return-void

    .line 655
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

    .line 656
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0
.end method

.method private remember(Lcom/mrkeyboard/app/MrLearned$Result;Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 645
    iget-wide v0, p1, Lcom/mrkeyboard/app/MrLearned$Result;->batch:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    iget v0, p1, Lcom/mrkeyboard/app/MrLearned$Result;->words:I

    iget v1, p1, Lcom/mrkeyboard/app/MrLearned$Result;->pairs:I

    add-int/2addr v0, v1

    if-nez v0, :cond_1

    .line 647
    :cond_0
    :goto_0
    return-void

    .line 646
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

    .line 624
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 625
    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrLearned$Result;->total()I

    move-result v1

    if-nez v1, :cond_4

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_import_added_none"

    new-array v3, v7, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 627
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

    .line 628
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

    .line 629
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

    .line 630
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

    .line 631
    :cond_3
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_done_title"

    new-array v4, v7, [Ljava/lang/Object;

    .line 632
    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 633
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_ok"

    new-array v3, v7, [Ljava/lang/Object;

    .line 634
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 635
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 636
    return-void

    .line 626
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

.method private setBusy(ZLjava/lang/String;)V
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 365
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mBusy:Z

    .line 366
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAnalyze:Landroid/widget/TextView;

    if-nez p1, :cond_1

    const/4 v0, 0x1

    :goto_0
    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setClickable(Z)V

    .line 367
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    if-nez p2, :cond_0

    const-string p2, ""

    :cond_0
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 368
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    if-eqz p1, :cond_2

    :goto_1
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 369
    return-void

    :cond_1
    move v0, v1

    .line 366
    goto :goto_0

    .line 368
    :cond_2
    const/16 v1, 0x8

    goto :goto_1
.end method

.method private showIgnored()V
    .locals 10

    .prologue
    const/4 v9, 0x1

    const/4 v8, 0x0

    .line 568
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 569
    if-nez v1, :cond_0

    .line 582
    :goto_0
    return-void

    .line 570
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 571
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

    .line 572
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

    .line 574
    :cond_1
    iget v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    iget-object v3, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignored:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-le v0, v3, :cond_2

    .line 575
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

    .line 577
    :cond_2
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_see_ignored"

    new-array v5, v9, [Ljava/lang/Object;

    iget v1, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    .line 578
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v5, v8

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 579
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_ok"

    new-array v3, v8, [Ljava/lang/Object;

    .line 580
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 581
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

    .line 442
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    .line 443
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 444
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v7}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 445
    iput v7, p0, Lcom/mrkeyboard/app/MrImportActivity;->mShown:I

    .line 446
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

    .line 447
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

    .line 448
    iget-object v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->blocked:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 449
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

    .line 451
    :cond_0
    iget v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->knownSkipped:I

    if-lez v0, :cond_1

    .line 452
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

    .line 454
    :cond_1
    iget-boolean v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->pairsCut:Z

    if-eqz v0, :cond_2

    .line 455
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

    .line 457
    :cond_2
    iget-object v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->languageHint:Ljava/lang/String;

    .line 458
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

    .line 459
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

    .line 461
    :cond_3
    iget v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->ignoredCount:I

    if-lez v0, :cond_4

    .line 462
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

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$11;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$11;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v7, v4}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xa

    .line 466
    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 462
    invoke-virtual {v0, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 468
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

    .line 469
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

    .line 470
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    .line 508
    :goto_1
    return-void

    .line 446
    :cond_5
    const-string v0, "mr_import_found"

    goto/16 :goto_0

    .line 473
    :cond_6
    iget-object v0, v1, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_7

    .line 474
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

    .line 475
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 476
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_all"

    new-array v4, v7, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/mrkeyboard/app/MrImportActivity$12;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrImportActivity$12;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v1, v2, v7, v3}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v1

    .line 481
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_none"

    new-array v5, v7, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$13;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$13;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v7, v4}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    .line 486
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, -0x2

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v3, v7, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 487
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x2

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v1, v7, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 488
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41000000    # 8.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v1, v3, v7, v7, v7}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 489
    invoke-virtual {v0, v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 490
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v11}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 491
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    .line 492
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mWordBox:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v11}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 493
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_learned_more"

    new-array v3, v7, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$14;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrImportActivity$14;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v0, v1, v7, v2}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mMoreWords:Landroid/widget/TextView;

    .line 498
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mMoreWords:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v11}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 499
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->drawWords()V

    .line 501
    :cond_7
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, ""

    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$15;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrImportActivity$15;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v0, v1, v8, v2}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    .line 506
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0x10

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 507
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->updateApply()V

    goto/16 :goto_1
.end method

.method private source()Ljava/lang/String;
    .locals 1

    .prologue
    .line 357
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileText:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileText:Ljava/lang/String;

    .line 359
    :goto_0
    return-object v0

    .line 358
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    .line 359
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

    .line 660
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "last_batch"

    invoke-interface {v0, v1, v6, v7}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    .line 661
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v2

    const-string v3, "last_locale"

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 662
    cmp-long v3, v0, v6

    if-lez v3, :cond_0

    if-nez v2, :cond_1

    .line 683
    :cond_0
    :goto_0
    return-void

    .line 663
    :cond_1
    new-instance v3, Landroid/app/AlertDialog$Builder;

    invoke-direct {v3, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_undo_title"

    new-array v6, v9, [Ljava/lang/Object;

    .line 664
    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_import_undo_ask"

    const/4 v6, 0x2

    new-array v6, v6, [Ljava/lang/Object;

    .line 665
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

    .line 666
    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_words_undo"

    new-array v6, v9, [Ljava/lang/Object;

    .line 667
    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lcom/mrkeyboard/app/MrImportActivity$18;

    invoke-direct {v5, p0, v2, v0, v1}, Lcom/mrkeyboard/app/MrImportActivity$18;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;J)V

    invoke-virtual {v3, v4, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 682
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private updateApply()V
    .locals 9

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 557
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    if-nez v0, :cond_1

    .line 565
    :cond_0
    :goto_0
    return-void

    .line 558
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImport$Plan;->checkedWords()I

    move-result v3

    .line 559
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->pairsToAdd()I

    move-result v4

    .line 560
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPlan:Lcom/mrkeyboard/app/MrImport$Plan;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImport$Plan;->blocked:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    .line 561
    add-int v5, v3, v4

    add-int/2addr v0, v5

    if-lez v0, :cond_2

    move v0, v1

    .line 562
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

    .line 563
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setClickable(Z)V

    .line 564
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->mApply:Landroid/widget/TextView;

    if-eqz v0, :cond_4

    const/high16 v0, 0x3f800000    # 1.0f

    :goto_3
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setAlpha(F)V

    goto :goto_0

    :cond_2
    move v0, v2

    .line 561
    goto :goto_1

    .line 562
    :cond_3
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_apply_none"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v1, v3, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    .line 564
    :cond_4
    const/high16 v0, 0x3f000000    # 0.5f

    goto :goto_3
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 81
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 82
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 5

    .prologue
    .line 295
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 296
    const/16 v0, 0x1bbe

    if-ne p1, v0, :cond_0

    const/4 v0, -0x1

    if-ne p2, v0, :cond_0

    if-eqz p3, :cond_0

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    if-nez v0, :cond_1

    .line 349
    :cond_0
    :goto_0
    return-void

    .line 297
    :cond_1
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    .line 298
    const/4 v1, 0x1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_import_reading"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/MrImportActivity;->setBusy(ZLjava/lang/String;)V

    .line 299
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$9;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrImportActivity$9;-><init>(Lcom/mrkeyboard/app/MrImportActivity;Landroid/net/Uri;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 348
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 12

    .prologue
    const/high16 v11, 0x41600000    # 14.0f

    const/high16 v7, 0x41a00000    # 20.0f

    const/high16 v10, 0x40800000    # 4.0f

    const/16 v9, 0x8

    const/4 v8, 0x0

    .line 95
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 96
    new-instance v0, Lcom/mrkeyboard/app/MrKit;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrKit;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 97
    invoke-static {p0}, Lcom/mrkeyboard/app/MrLearned;->store(Landroid/content/Context;)Lcom/mrkeyboard/app/MrWordStore;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    .line 98
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    if-nez v0, :cond_0

    .line 99
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_learned_unavailable"

    new-array v3, v8, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    .line 100
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrImportActivity;->finish()V

    .line 199
    :goto_0
    return-void

    .line 103
    :cond_0
    if-eqz p1, :cond_1

    const-string v0, "mr_import_s_locale"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    .line 104
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

    .line 105
    :cond_2
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->loadLanguages()V

    .line 107
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 108
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->bg:I

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v8, v3, v8}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 109
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 110
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

    .line 111
    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-direct {v2, v3, v4}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 112
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

    .line 114
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

    .line 118
    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 114
    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 119
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_intro"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v3, v11, v4, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v9}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 121
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangBox:Landroid/widget/LinearLayout;

    .line 122
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLangBox:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x10

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 124
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

    .line 126
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    const/4 v3, 0x6

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setMinLines(I)V

    .line 127
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    const/16 v3, 0x30

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setGravity(I)V

    .line 128
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

    .line 129
    :cond_3
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    new-instance v3, Lcom/mrkeyboard/app/MrImportActivity$2;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrImportActivity$2;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 141
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xe

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 143
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    const/high16 v4, 0x41500000    # 13.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v3, v4, v5, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileLabel:Landroid/widget/TextView;

    .line 144
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

    .line 145
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileLabel:Landroid/widget/TextView;

    invoke-virtual {v2, v9}, Landroid/widget/TextView;->setVisibility(I)V

    .line 146
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mFileLabel:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 148
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v2

    .line 149
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

    .line 154
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

    .line 159
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x2

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-direct {v5, v8, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v3, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 160
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, -0x2

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-direct {v3, v8, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 161
    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41000000    # 8.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v3, v5, v8, v8, v8}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 162
    invoke-virtual {v2, v4, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 163
    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xa

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 165
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_analyze"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    new-instance v5, Lcom/mrkeyboard/app/MrImportActivity$5;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrImportActivity$5;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAnalyze:Landroid/widget/TextView;

    .line 170
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mAnalyze:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xc

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 171
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v3, v11, v4, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    .line 172
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

    .line 173
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    invoke-virtual {v2, v9}, Landroid/widget/TextView;->setVisibility(I)V

    .line 174
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStatus:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 176
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    .line 177
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v9}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 178
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mPreview:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xa

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 181
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

    .line 182
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_ai_text"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v3, v11, v4, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x6

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 183
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_ai_copy"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$6;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$6;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v8, v4}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xa

    .line 187
    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 183
    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 188
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_import_ai_warn"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/high16 v4, 0x41500000    # 13.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->rose:I

    invoke-virtual {v2, v3, v4, v5, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v9}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 190
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    new-instance v4, Lcom/mrkeyboard/app/MrImportActivity$7;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrImportActivity$7;-><init>(Lcom/mrkeyboard/app/MrImportActivity;)V

    invoke-virtual {v2, v3, v8, v4}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    .line 195
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mUndo:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x18

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 197
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrImportActivity;->setContentView(Landroid/view/View;)V

    .line 198
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->restore(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    goto/16 :goto_0
.end method

.method protected onResume()V
    .locals 1

    .prologue
    .line 203
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 204
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    if-nez v0, :cond_0

    .line 207
    :goto_0
    return-void

    .line 205
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshLanguages()V

    .line 206
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrImportActivity;->refreshUndo()V

    goto :goto_0
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 86
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 87
    const-string v0, "mr_import_s_locale"

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity;->mLocale:Ljava/lang/String;

    invoke-virtual {p1, v0, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 88
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    if-nez v0, :cond_1

    move-object v0, v1

    .line 89
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

    .line 90
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->save(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    .line 91
    return-void

    .line 88
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity;->mText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_0
.end method
