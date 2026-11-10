.class public Lcom/mrkeyboard/app/MrLearnedActivity;
.super Landroid/app/Activity;
.source "MrLearnedActivity.java"


# static fields
.field private static final A_ALLOW:I = 0x4

.field private static final A_BLOCK:I = 0x2

.field private static final A_EDIT:I = 0x1

.field private static final A_FORGET:I = 0x3

.field static final EXTRA_LOCALE:Ljava/lang/String; = "mr_words_locale"

.field static final PAGE:I = 0x32

.field private static final REQ_EXPORT:I = 0x1bbd

.field private static final S_FILTER:Ljava/lang/String; = "mr_words_s_filter"

.field private static final S_LOCALE:Ljava/lang/String; = "mr_words_s_locale"

.field private static final S_SORT:Ljava/lang/String; = "mr_words_s_sort"

.field private static final S_TAB:Ljava/lang/String; = "mr_words_s_tab"

.field private static final S_TYPE:Ljava/lang/String; = "mr_words_s_type"

.field static final TAB_ADDED:I = 0x1

.field static final TAB_BLOCKED:I = 0x2

.field static final TAB_LEARNED:I


# instance fields
.field private k:Lcom/mrkeyboard/app/MrKit;

.field private mDeleteAll:Landroid/widget/TextView;

.field private mEmpty:Landroid/widget/TextView;

.field private mExportLocale:Ljava/lang/String;

.field private mFilter:Ljava/lang/String;

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

.field private mLimit:I

.field private mListBox:Landroid/widget/LinearLayout;

.field private mLocale:Ljava/lang/String;

.field private mMore:Landroid/widget/TextView;

.field private mSearch:Landroid/widget/EditText;

.field private mSort:I

.field private mSortChip:Landroid/widget/TextView;

.field private mStore:Lcom/mrkeyboard/app/MrWordStore;

.field private mTab:I

.field private mTabBox:Landroid/widget/LinearLayout;

.field private mType:I

.field private mTypeBox:Landroid/widget/LinearLayout;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 31
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 52
    iput v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    .line 55
    iput v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSort:I

    .line 56
    const-string v0, ""

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mFilter:Ljava/lang/String;

    .line 57
    const/16 v0, 0x32

    iput v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLimit:I

    .line 58
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLangs:Ljava/util/List;

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrLearnedActivity;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 31
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mFilter:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$002(Lcom/mrkeyboard/app/MrLearnedActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 31
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mFilter:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/MrLearnedActivity;Lcom/mrkeyboard/app/MrWordStore$Row;)V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrLearnedActivity;->menu(Lcom/mrkeyboard/app/MrWordStore$Row;)V

    return-void
.end method

.method static synthetic access$102(Lcom/mrkeyboard/app/MrLearnedActivity;I)I
    .locals 0

    .prologue
    .line 31
    iput p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLimit:I

    return p1
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/MrLearnedActivity;ILcom/mrkeyboard/app/MrWordStore$Row;)V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/MrLearnedActivity;->act(ILcom/mrkeyboard/app/MrWordStore$Row;)V

    return-void
.end method

.method static synthetic access$112(Lcom/mrkeyboard/app/MrLearnedActivity;I)I
    .locals 1

    .prologue
    .line 31
    iget v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLimit:I

    add-int/2addr v0, p1

    iput v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLimit:I

    return v0
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/MrLearnedActivity;Lcom/mrkeyboard/app/MrWordStore$Row;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/MrLearnedActivity;->saveEdit(Lcom/mrkeyboard/app/MrWordStore$Row;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/MrLearnedActivity;I)V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrLearnedActivity;->deleteAll(I)V

    return-void
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/MrLearnedActivity;)Lcom/mrkeyboard/app/MrKit;
    .locals 1

    .prologue
    .line 31
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    return-object v0
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrLearnedActivity;)V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->refreshList()V

    return-void
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/MrLearnedActivity;)I
    .locals 1

    .prologue
    .line 31
    iget v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSort:I

    return v0
.end method

.method static synthetic access$302(Lcom/mrkeyboard/app/MrLearnedActivity;I)I
    .locals 0

    .prologue
    .line 31
    iput p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSort:I

    return p1
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/MrLearnedActivity;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 31
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$402(Lcom/mrkeyboard/app/MrLearnedActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 31
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/MrLearnedActivity;)V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->startExport()V

    return-void
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/MrLearnedActivity;)V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->askDeleteAll()V

    return-void
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/MrLearnedActivity;)V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->refreshAll()V

    return-void
.end method

.method static synthetic access$802(Lcom/mrkeyboard/app/MrLearnedActivity;I)I
    .locals 0

    .prologue
    .line 31
    iput p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    return p1
.end method

.method static synthetic access$902(Lcom/mrkeyboard/app/MrLearnedActivity;I)I
    .locals 0

    .prologue
    .line 31
    iput p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mType:I

    return p1
.end method

.method private act(ILcom/mrkeyboard/app/MrWordStore$Row;)V
    .locals 8

    .prologue
    const/4 v7, 0x0

    .line 374
    packed-switch p1, :pswitch_data_0

    .line 401
    :goto_0
    return-void

    .line 376
    :pswitch_0
    :try_start_0
    invoke-direct {p0, p2}, Lcom/mrkeyboard/app/MrLearnedActivity;->askEdit(Lcom/mrkeyboard/app/MrWordStore$Row;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 395
    :catch_0
    move-exception v0

    .line 396
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_learned_unavailable"

    new-array v3, v7, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 379
    :pswitch_1
    :try_start_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    iget-object v2, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-static {v0, v1, v2, v4, v5}, Lcom/mrkeyboard/app/MrLearned;->block(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;Ljava/lang/String;J)I

    move-result v0

    .line 380
    if-gez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_learned_cannot_block"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    .line 399
    :goto_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrLearned;->changed(Landroid/content/Context;)V

    .line 400
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->refreshAll()V

    goto :goto_0

    .line 381
    :cond_0
    :try_start_2
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_learned_blocked_done"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    iget-object v6, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    aput-object v6, v4, v5

    const/4 v5, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v4, v5

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_1

    .line 385
    :pswitch_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    iget v1, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->kind:I

    iget-wide v2, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->id:J

    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrLearned;->forget(Lcom/mrkeyboard/app/MrWordStore;IJ)Z

    .line 386
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_learned_forgotten"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_1

    .line 389
    :pswitch_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    iget-wide v2, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->id:J

    invoke-static {v0, v2, v3}, Lcom/mrkeyboard/app/MrLearned;->unblock(Lcom/mrkeyboard/app/MrWordStore;J)Z

    .line 390
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_learned_allowed"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_1

    .line 374
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method private askDeleteAll()V
    .locals 8

    .prologue
    const/4 v5, 0x1

    const/4 v7, 0x0

    .line 450
    iget v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    .line 451
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_learned_delete_all"

    new-array v4, v7, [Ljava/lang/Object;

    .line 452
    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 453
    if-nez v1, :cond_0

    const-string v0, "mr_learned_delete_ask_learned"

    .line 454
    :goto_0
    new-array v4, v5, [Ljava/lang/Object;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->langName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v7

    .line 453
    invoke-virtual {v3, v0, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_words_cancel"

    new-array v4, v7, [Ljava/lang/Object;

    .line 455
    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_words_delete"

    new-array v4, v7, [Ljava/lang/Object;

    .line 456
    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/mrkeyboard/app/MrLearnedActivity$14;

    invoke-direct {v3, p0, v1}, Lcom/mrkeyboard/app/MrLearnedActivity$14;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity;I)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 461
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 462
    return-void

    .line 454
    :cond_0
    if-ne v1, v5, :cond_1

    const-string v0, "mr_learned_delete_ask_added"

    goto :goto_0

    :cond_1
    const-string v0, "mr_learned_delete_ask_blocked"

    goto :goto_0
.end method

.method private askEdit(Lcom/mrkeyboard/app/MrWordStore$Row;)V
    .locals 7

    .prologue
    const/high16 v5, 0x41a00000    # 20.0f

    const/4 v6, 0x0

    .line 404
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, ""

    const v2, 0x80001

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->field(Ljava/lang/String;I)Landroid/widget/EditText;

    move-result-object v0

    .line 405
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSingleLine(Z)V

    .line 406
    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrWordStore$Row;->text()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 407
    invoke-virtual {v0}, Landroid/widget/EditText;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSelection(I)V

    .line 408
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 409
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41000000    # 8.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v1, v2, v3, v4, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 410
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 411
    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-direct {v2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_learned_edit_title"

    new-array v5, v6, [Ljava/lang/Object;

    .line 412
    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 413
    invoke-virtual {v2, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_words_cancel"

    new-array v4, v6, [Ljava/lang/Object;

    .line 414
    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_words_ok"

    new-array v4, v6, [Ljava/lang/Object;

    .line 415
    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/mrkeyboard/app/MrLearnedActivity$13;

    invoke-direct {v3, p0, p1, v0}, Lcom/mrkeyboard/app/MrLearnedActivity$13;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity;Lcom/mrkeyboard/app/MrWordStore$Row;Landroid/widget/EditText;)V

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 420
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 421
    return-void
.end method

.method private static clamp(III)I
    .locals 1

    .prologue
    .line 216
    invoke-static {p2, p0}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-static {p1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    return v0
.end method

.method private deleteAll(I)V
    .locals 6

    .prologue
    const/4 v4, 0x1

    const/4 v5, 0x0

    .line 467
    if-nez p1, :cond_0

    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLearned;->deleteAllLearned(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 474
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_learned_deleted"

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v4, v5

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    .line 475
    invoke-static {p0}, Lcom/mrkeyboard/app/MrLearned;->changed(Landroid/content/Context;)V

    .line 476
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->refreshAll()V

    .line 477
    :goto_1
    return-void

    .line 468
    :cond_0
    if-ne p1, v4, :cond_1

    :try_start_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLearned;->deleteAllImported(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 469
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    const/4 v1, 0x4

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Lcom/mrkeyboard/app/MrWordStore;->deleteAll(ILjava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    move-result v0

    goto :goto_0

    .line 470
    :catch_0
    move-exception v0

    .line 471
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_learned_unavailable"

    new-array v3, v5, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_1
.end method

.method private kind()I
    .locals 2

    .prologue
    const/4 v0, 0x2

    .line 291
    iget v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    if-ne v1, v0, :cond_1

    const/4 v0, 0x4

    .line 293
    :cond_0
    :goto_0
    return v0

    .line 292
    :cond_1
    iget v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    if-nez v1, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mType:I

    if-nez v0, :cond_2

    const/4 v0, 0x0

    goto :goto_0

    :cond_2
    const/4 v0, 0x1

    goto :goto_0

    .line 293
    :cond_3
    iget v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mType:I

    if-eqz v1, :cond_0

    const/4 v0, 0x3

    goto :goto_0
.end method

.method private loadLanguages()V
    .locals 4

    .prologue
    .line 225
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    invoke-interface {v0}, Lcom/mrkeyboard/app/MrWordStore;->locales()Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 229
    :goto_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->installedIds(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrLang;->offered(Ljava/util/List;Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLangs:Ljava/util/List;

    .line 230
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLangs:Ljava/util/List;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    const-string v2, "mr_words"

    const/4 v3, 0x0

    invoke-virtual {p0, v2, v3}, Lcom/mrkeyboard/app/MrLearnedActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrLang;->last(Landroid/content/SharedPreferences;)Ljava/lang/String;

    move-result-object v2

    .line 231
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v3

    iget-object v3, v3, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v3}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v3

    .line 230
    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrLang;->pick(Ljava/util/List;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    .line 232
    return-void

    .line 226
    :catch_0
    move-exception v0

    .line 227
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    goto :goto_0
.end method

.method private menu(Lcom/mrkeyboard/app/MrWordStore$Row;)V
    .locals 6

    .prologue
    const/4 v3, 0x4

    const/4 v5, 0x0

    .line 347
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 348
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 349
    iget v2, p1, Lcom/mrkeyboard/app/MrWordStore$Row;->kind:I

    if-ne v2, v3, :cond_0

    .line 350
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 351
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_learned_act_allow"

    new-array v4, v5, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 362
    :goto_0
    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-direct {v2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 363
    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrWordStore$Row;->text()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    new-array v3, v5, [Ljava/lang/CharSequence;

    .line 364
    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/CharSequence;

    new-instance v3, Lcom/mrkeyboard/app/MrLearnedActivity$12;

    invoke-direct {v3, p0, v1, p1}, Lcom/mrkeyboard/app/MrLearnedActivity$12;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity;Ljava/util/ArrayList;Lcom/mrkeyboard/app/MrWordStore$Row;)V

    invoke-virtual {v2, v0, v3}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 369
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 370
    return-void

    .line 353
    :cond_0
    const/4 v2, 0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 354
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_learned_act_edit"

    new-array v4, v5, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 355
    iget-object v2, p1, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    if-nez v2, :cond_1

    .line 356
    const/4 v2, 0x2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 357
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_learned_act_block"

    new-array v4, v5, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 359
    :cond_1
    const/4 v2, 0x3

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 360
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_learned_act_forget"

    new-array v4, v5, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method private refreshAll()V
    .locals 11

    .prologue
    const/4 v10, 0x3

    const/4 v9, 0x2

    const/4 v8, 0x1

    const/4 v2, 0x0

    .line 239
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLearned;->counts(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;)[I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 243
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLangBox:Landroid/widget/LinearLayout;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLangs:Ljava/util/List;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    new-instance v6, Lcom/mrkeyboard/app/MrLearnedActivity$8;

    invoke-direct {v6, p0}, Lcom/mrkeyboard/app/MrLearnedActivity$8;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity;)V

    invoke-virtual {v1, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->languageCard(Landroid/widget/LinearLayout;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/MrKit$LangPick;)V

    .line 252
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 253
    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_learned_tab_learned"

    new-array v5, v8, [Ljava/lang/Object;

    aget v6, v0, v2

    aget v7, v0, v8

    add-int/2addr v6, v7

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v2

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/MrLearnedActivity;->tabChip(ILjava/lang/String;)Landroid/widget/TextView;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 254
    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_learned_tab_added"

    new-array v5, v8, [Ljava/lang/Object;

    aget v6, v0, v9

    aget v7, v0, v10

    add-int/2addr v6, v7

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v2

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v8, v3}, Lcom/mrkeyboard/app/MrLearnedActivity;->tabChip(ILjava/lang/String;)Landroid/widget/TextView;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 255
    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_learned_tab_blocked"

    new-array v5, v8, [Ljava/lang/Object;

    const/4 v6, 0x4

    aget v6, v0, v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v2

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v9, v3}, Lcom/mrkeyboard/app/MrLearnedActivity;->tabChip(ILjava/lang/String;)Landroid/widget/TextView;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 256
    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTabBox:Landroid/widget/LinearLayout;

    invoke-virtual {v3, v4, v1, v10}, Lcom/mrkeyboard/app/MrKit;->fill(Landroid/widget/LinearLayout;Ljava/util/List;I)V

    .line 258
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 259
    iget v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    if-eq v1, v9, :cond_0

    .line 260
    iget v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    if-nez v1, :cond_1

    aget v1, v0, v2

    .line 261
    :goto_1
    iget v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    if-nez v4, :cond_2

    aget v0, v0, v8

    .line 262
    :goto_2
    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_learned_type_words"

    new-array v6, v8, [Ljava/lang/Object;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v6, v2

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/MrLearnedActivity;->typeChip(ILjava/lang/String;)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 263
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_learned_type_pairs"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v5, v2

    invoke-virtual {v1, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v8, v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->typeChip(ILjava/lang/String;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 265
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTypeBox:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1, v3, v9}, Lcom/mrkeyboard/app/MrKit;->fill(Landroid/widget/LinearLayout;Ljava/util/List;I)V

    .line 266
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTypeBox:Landroid/widget/LinearLayout;

    invoke-virtual {v3}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    const/16 v0, 0x8

    :goto_3
    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 267
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->refreshList()V

    .line 268
    return-void

    .line 240
    :catch_0
    move-exception v0

    .line 241
    const/4 v0, 0x5

    new-array v0, v0, [I

    goto/16 :goto_0

    .line 260
    :cond_1
    aget v1, v0, v9

    goto :goto_1

    .line 261
    :cond_2
    aget v0, v0, v10

    goto :goto_2

    :cond_3
    move v0, v2

    .line 266
    goto :goto_3
.end method

.method private refreshList()V
    .locals 15

    .prologue
    const/4 v14, 0x4

    const/4 v10, 0x2

    const/16 v7, 0x8

    const/4 v9, 0x1

    const/4 v8, 0x0

    .line 297
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mListBox:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 298
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSortChip:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSort:I

    if-nez v0, :cond_0

    const-string v0, "mr_learned_sort_used"

    :goto_0
    new-array v3, v8, [Ljava/lang/Object;

    invoke-virtual {v2, v0, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 299
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSortChip:Landroid/widget/TextView;

    iget v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    if-ne v0, v10, :cond_1

    move v0, v7

    :goto_1
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    .line 302
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->kind()I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mFilter:Ljava/lang/String;

    iget v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSort:I

    const/4 v5, 0x0

    iget v6, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLimit:I

    add-int/lit8 v6, v6, 0x1

    invoke-interface/range {v0 .. v6}, Lcom/mrkeyboard/app/MrWordStore;->list(ILjava/lang/String;Ljava/lang/String;III)Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    move-object v1, v0

    .line 307
    :goto_2
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v0

    iget v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLimit:I

    if-le v0, v2, :cond_2

    move v2, v9

    .line 308
    :goto_3
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v0

    iget v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLimit:I

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 310
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->table()Landroid/widget/LinearLayout;

    move-result-object v6

    move v4, v8

    .line 311
    :goto_4
    if-ge v4, v5, :cond_6

    .line 312
    invoke-interface {v1, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    .line 313
    iget v3, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->kind:I

    if-ne v3, v14, :cond_3

    const-string v3, ""

    .line 316
    :goto_5
    iget-object v11, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrWordStore$Row;->text()Ljava/lang/String;

    move-result-object v12

    new-instance v13, Lcom/mrkeyboard/app/MrLearnedActivity$11;

    invoke-direct {v13, p0, v0}, Lcom/mrkeyboard/app/MrLearnedActivity$11;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity;Lcom/mrkeyboard/app/MrWordStore$Row;)V

    invoke-virtual {v11, v6, v12, v3, v13}, Lcom/mrkeyboard/app/MrKit;->tableRow(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)V

    .line 311
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_4

    .line 298
    :cond_0
    const-string v0, "mr_learned_sort_new"

    goto :goto_0

    :cond_1
    move v0, v8

    .line 299
    goto :goto_1

    .line 303
    :catch_0
    move-exception v0

    .line 304
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 305
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_learned_unavailable"

    new-array v4, v8, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    move-object v1, v0

    goto :goto_2

    :cond_2
    move v2, v8

    .line 307
    goto :goto_3

    .line 314
    :cond_3
    iget v3, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->kind:I

    if-eqz v3, :cond_4

    iget v3, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->kind:I

    if-ne v3, v9, :cond_5

    .line 315
    :cond_4
    iget v3, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    invoke-static {v3}, Lcom/mrkeyboard/app/MrLearned;->weightOfLearned(I)I

    move-result v3

    .line 314
    :goto_6
    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    goto :goto_5

    .line 315
    :cond_5
    iget v3, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    goto :goto_6

    .line 322
    :cond_6
    if-lez v5, :cond_7

    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mListBox:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, v6, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 323
    :cond_7
    const-string v0, ""

    .line 324
    if-nez v5, :cond_8

    .line 325
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mFilter:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_9

    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_learned_empty_search"

    new-array v3, v8, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 329
    :cond_8
    :goto_7
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mEmpty:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 330
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mEmpty:Landroid/widget/TextView;

    if-nez v5, :cond_c

    move v0, v8

    :goto_8
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    .line 331
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mMore:Landroid/widget/TextView;

    if-eqz v2, :cond_d

    move v0, v8

    :goto_9
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    .line 334
    :try_start_1
    iget v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    if-ne v0, v10, :cond_e

    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    const/4 v1, 0x4

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Lcom/mrkeyboard/app/MrWordStore;->count(ILjava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    move-result v0

    .line 340
    :goto_a
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mDeleteAll:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_learned_delete_all"

    new-array v4, v8, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 341
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mDeleteAll:Landroid/widget/TextView;

    if-lez v0, :cond_11

    :goto_b
    invoke-virtual {v1, v8}, Landroid/widget/TextView;->setVisibility(I)V

    .line 342
    return-void

    .line 326
    :cond_9
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    if-nez v0, :cond_a

    const-string v0, "mr_learned_empty_learned"

    .line 327
    :goto_c
    new-array v3, v8, [Ljava/lang/Object;

    .line 326
    invoke-virtual {v1, v0, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_7

    .line 327
    :cond_a
    iget v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    if-ne v0, v9, :cond_b

    const-string v0, "mr_learned_empty_added"

    goto :goto_c

    :cond_b
    const-string v0, "mr_learned_empty_blocked"

    goto :goto_c

    :cond_c
    move v0, v7

    .line 330
    goto :goto_8

    :cond_d
    move v0, v7

    .line 331
    goto :goto_9

    .line 335
    :cond_e
    :try_start_2
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    iget v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    if-nez v0, :cond_f

    move v0, v8

    :goto_d
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    invoke-interface {v1, v0, v2}, Lcom/mrkeyboard/app/MrWordStore;->count(ILjava/lang/String;)I

    move-result v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    .line 336
    iget v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    if-nez v2, :cond_10

    :goto_e
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    invoke-interface {v1, v9, v2}, Lcom/mrkeyboard/app/MrWordStore;->count(ILjava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_1

    move-result v1

    add-int/2addr v0, v1

    goto :goto_a

    :cond_f
    move v0, v10

    .line 335
    goto :goto_d

    .line 336
    :cond_10
    const/4 v9, 0x3

    goto :goto_e

    .line 337
    :catch_1
    move-exception v0

    move v0, v8

    .line 338
    goto :goto_a

    :cond_11
    move v8, v7

    .line 341
    goto :goto_b
.end method

.method private saveEdit(Lcom/mrkeyboard/app/MrWordStore$Row;Ljava/lang/String;)V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 424
    iget-object v0, p1, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    .line 425
    :goto_0
    if-eqz v0, :cond_1

    const/16 v0, 0x2019

    const/16 v2, 0x27

    invoke-virtual {p2, v0, v2}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x2

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrImport;->splitWords(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_1

    .line 426
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_learned_need_two"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v1}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    .line 445
    :goto_1
    return-void

    :cond_0
    move v0, v1

    .line 424
    goto :goto_0

    .line 431
    :cond_1
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    invoke-static {v0, v2, p1, p2}, Lcom/mrkeyboard/app/MrLearned;->edit(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;Lcom/mrkeyboard/app/MrWordStore$Row;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 436
    if-nez v0, :cond_2

    .line 437
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_learned_saved"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v1}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    .line 438
    invoke-static {p0}, Lcom/mrkeyboard/app/MrLearned;->changed(Landroid/content/Context;)V

    .line 439
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->refreshAll()V

    goto :goto_1

    .line 432
    :catch_0
    move-exception v0

    .line 433
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_learned_unavailable"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v1}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_1

    .line 440
    :cond_2
    if-lez v0, :cond_3

    .line 441
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mr_import_why_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {v3, v0, v1}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_1

    .line 443
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_learned_unavailable"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v1}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_1
.end method

.method private startExport()V
    .locals 4

    .prologue
    .line 482
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mExportLocale:Ljava/lang/String;

    .line 483
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.CREATE_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 484
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 485
    const-string v1, "text/plain"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 486
    const-string v1, "android.intent.extra.TITLE"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "mr-keyboard-words-"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    invoke-static {v3}, Lcom/mrkeyboard/app/MrLearned;->tag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".txt"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 488
    const/16 v1, 0x1bbd

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrLearnedActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 492
    :goto_0
    return-void

    .line 489
    :catch_0
    move-exception v0

    .line 490
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_no_files"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private tabChip(ILjava/lang/String;)Landroid/widget/TextView;
    .locals 3

    .prologue
    .line 271
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    if-ne v0, p1, :cond_0

    const/4 v0, 0x1

    :goto_0
    new-instance v2, Lcom/mrkeyboard/app/MrLearnedActivity$9;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/MrLearnedActivity$9;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity;I)V

    invoke-virtual {v1, p2, v0, v2}, Lcom/mrkeyboard/app/MrKit;->tabChip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private typeChip(ILjava/lang/String;)Landroid/widget/TextView;
    .locals 3

    .prologue
    .line 281
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mType:I

    if-ne v0, p1, :cond_0

    const/4 v0, 0x1

    :goto_0
    new-instance v2, Lcom/mrkeyboard/app/MrLearnedActivity$10;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/MrLearnedActivity$10;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity;I)V

    invoke-virtual {v1, p2, v0, v2}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 73
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 74
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 5

    .prologue
    .line 496
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 497
    const/16 v0, 0x1bbd

    if-ne p1, v0, :cond_0

    const/4 v0, -0x1

    if-ne p2, v0, :cond_0

    if-eqz p3, :cond_0

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    if-nez v0, :cond_1

    .line 527
    :cond_0
    :goto_0
    return-void

    .line 498
    :cond_1
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v1

    .line 499
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mExportLocale:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mExportLocale:Ljava/lang/String;

    .line 500
    :goto_1
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    .line 501
    new-instance v3, Ljava/lang/Thread;

    new-instance v4, Lcom/mrkeyboard/app/MrLearnedActivity$15;

    invoke-direct {v4, p0, v2, v0, v1}, Lcom/mrkeyboard/app/MrLearnedActivity$15;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity;Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;Landroid/net/Uri;)V

    invoke-direct {v3, v4}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 526
    invoke-virtual {v3}, Ljava/lang/Thread;->start()V

    goto :goto_0

    .line 499
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    goto :goto_1
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 12

    .prologue
    const/high16 v11, 0x41a00000    # 20.0f

    const/high16 v10, 0x41600000    # 14.0f

    const/high16 v9, 0x41400000    # 12.0f

    const/4 v7, 0x1

    const/4 v8, 0x0

    .line 89
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 90
    new-instance v0, Lcom/mrkeyboard/app/MrKit;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrKit;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 91
    invoke-static {p0}, Lcom/mrkeyboard/app/MrLearned;->store(Landroid/content/Context;)Lcom/mrkeyboard/app/MrWordStore;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    .line 92
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    if-nez v0, :cond_0

    .line 93
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_learned_unavailable"

    new-array v3, v8, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    .line 94
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->finish()V

    .line 202
    :goto_0
    return-void

    .line 97
    :cond_0
    if-eqz p1, :cond_2

    .line 98
    const-string v0, "mr_words_s_locale"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    .line 99
    const-string v0, "mr_words_s_tab"

    invoke-virtual {p1, v0, v8}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    const/4 v1, 0x2

    invoke-static {v0, v8, v1}, Lcom/mrkeyboard/app/MrLearnedActivity;->clamp(III)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    .line 100
    const-string v0, "mr_words_s_type"

    invoke-virtual {p1, v0, v8}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    invoke-static {v0, v8, v7}, Lcom/mrkeyboard/app/MrLearnedActivity;->clamp(III)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mType:I

    .line 101
    const-string v0, "mr_words_s_sort"

    invoke-virtual {p1, v0, v8}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    if-ne v0, v7, :cond_4

    move v0, v7

    :goto_1
    iput v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSort:I

    .line 102
    const-string v0, "mr_words_s_filter"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 103
    if-nez v0, :cond_1

    const-string v0, ""

    :cond_1
    iput-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mFilter:Ljava/lang/String;

    .line 105
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    if-nez v0, :cond_3

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "mr_words_locale"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    .line 106
    :cond_3
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->loadLanguages()V

    .line 107
    const-string v0, "mr_words"

    invoke-virtual {p0, v0, v8}, Lcom/mrkeyboard/app/MrLearnedActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLang;->remember(Landroid/content/SharedPreferences;Ljava/lang/String;)V

    .line 109
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 110
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->bg:I

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v8, v3, v8}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 111
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 112
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41800000    # 16.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41c00000    # 24.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 113
    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-direct {v2, v3, v4}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 114
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41800000    # 16.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41c00000    # 24.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    iget-object v6, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrScreenIme;->lift(Landroid/widget/ScrollView;Landroid/view/View;IIIII)V

    .line 116
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_learned_title"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrLearnedActivity$1;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrLearnedActivity$1;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity;)V

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->backHeader(Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 120
    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 116
    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 121
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_learned_intro"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v3, v10, v4, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    .line 122
    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x8

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 124
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLangBox:Landroid/widget/LinearLayout;

    .line 125
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLangBox:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x10

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 126
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTabBox:Landroid/widget/LinearLayout;

    .line 127
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTabBox:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xc

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 128
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTypeBox:Landroid/widget/LinearLayout;

    .line 129
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTypeBox:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x8

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 131
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v2

    .line 132
    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_learned_search_hint"

    new-array v6, v8, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const v5, 0x80001

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->field(Ljava/lang/String;I)Landroid/widget/EditText;

    move-result-object v3

    iput-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSearch:Landroid/widget/EditText;

    .line 133
    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSearch:Landroid/widget/EditText;

    invoke-virtual {v3, v7}, Landroid/widget/EditText;->setSingleLine(Z)V

    .line 134
    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSearch:Landroid/widget/EditText;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mFilter:Ljava/lang/String;

    invoke-virtual {v3, v4}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 135
    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSearch:Landroid/widget/EditText;

    new-instance v4, Lcom/mrkeyboard/app/MrLearnedActivity$2;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrLearnedActivity$2;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity;)V

    invoke-virtual {v3, v4}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 150
    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSearch:Landroid/widget/EditText;

    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, -0x2

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-direct {v4, v8, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 151
    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, ""

    new-instance v5, Lcom/mrkeyboard/app/MrLearnedActivity$3;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrLearnedActivity$3;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity;)V

    invoke-virtual {v3, v4, v8, v5}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v3

    iput-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSortChip:Landroid/widget/TextView;

    .line 158
    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSortChip:Landroid/widget/TextView;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->card:I

    iget-object v6, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->stroke:I

    invoke-virtual {v4, v5, v6, v9, v8}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 159
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, -0x2

    const/4 v5, -0x1

    invoke-direct {v3, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 160
    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41000000    # 8.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v3, v4, v8, v8, v8}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 161
    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSortChip:Landroid/widget/TextView;

    invoke-virtual {v2, v4, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 162
    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xc

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 164
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mListBox:Landroid/widget/LinearLayout;

    .line 165
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mListBox:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xc

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 166
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v3, v10, v4, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mEmpty:Landroid/widget/TextView;

    .line 167
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mEmpty:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x40800000    # 4.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x40800000    # 4.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    iget-object v6, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-virtual {v2, v3, v4, v5, v6}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 168
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mEmpty:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 169
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_learned_more"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrLearnedActivity$4;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrLearnedActivity$4;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity;)V

    invoke-virtual {v2, v3, v8, v4}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mMore:Landroid/widget/TextView;

    .line 175
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mMore:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xa

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 177
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_learned_add"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "mr_ui_ic_plus"

    new-instance v5, Lcom/mrkeyboard/app/MrLearnedActivity$5;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrLearnedActivity$5;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity;)V

    invoke-virtual {v2, v3, v4, v7, v5}, Lcom/mrkeyboard/app/MrKit;->iconButton(Ljava/lang/String;Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x16

    .line 183
    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 177
    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 184
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_learned_export"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "mr_ui_ic_export"

    new-instance v5, Lcom/mrkeyboard/app/MrLearnedActivity$6;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrLearnedActivity$6;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity;)V

    invoke-virtual {v2, v3, v4, v8, v5}, Lcom/mrkeyboard/app/MrKit;->iconButton(Ljava/lang/String;Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xa

    .line 188
    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 184
    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 189
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->rose:I

    invoke-virtual {v2, v3, v10, v4, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mDeleteAll:Landroid/widget/TextView;

    .line 190
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mDeleteAll:Landroid/widget/TextView;

    const/16 v3, 0x11

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setGravity(I)V

    .line 191
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mDeleteAll:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41000000    # 8.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v10}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41000000    # 8.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    iget-object v6, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v8, 0x40800000    # 4.0f

    invoke-virtual {v6, v8}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-virtual {v2, v3, v4, v5, v6}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 192
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mDeleteAll:Landroid/widget/TextView;

    invoke-virtual {v2, v7}, Landroid/widget/TextView;->setClickable(Z)V

    .line 193
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mDeleteAll:Landroid/widget/TextView;

    new-instance v3, Lcom/mrkeyboard/app/MrLearnedActivity$7;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrLearnedActivity$7;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity;)V

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 198
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mDeleteAll:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x8

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 200
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->setContentView(Landroid/view/View;)V

    .line 201
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSearch:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->restore(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    goto/16 :goto_0

    :cond_4
    move v0, v8

    .line 101
    goto/16 :goto_1
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 206
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 207
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mStore:Lcom/mrkeyboard/app/MrWordStore;

    if-nez v0, :cond_0

    .line 213
    :goto_0
    return-void

    .line 209
    :cond_0
    const-string v0, "mr_words"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrLearnedActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLang;->last(Landroid/content/SharedPreferences;)Ljava/lang/String;

    move-result-object v0

    .line 210
    if-eqz v0, :cond_1

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    .line 211
    :cond_1
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->loadLanguages()V

    .line 212
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrLearnedActivity;->refreshAll()V

    goto :goto_0
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    .prologue
    .line 78
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 79
    const-string v0, "mr_words_s_locale"

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mLocale:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 80
    const-string v0, "mr_words_s_tab"

    iget v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mTab:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 81
    const-string v0, "mr_words_s_type"

    iget v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mType:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 82
    const-string v0, "mr_words_s_sort"

    iget v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSort:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 83
    const-string v0, "mr_words_s_filter"

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mFilter:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 84
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity;->mSearch:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->save(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    .line 85
    return-void
.end method
