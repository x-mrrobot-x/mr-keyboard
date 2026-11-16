.class public Lcom/mrkeyboard/app/MrTourActivity;
.super Landroid/app/Activity;
.source "MrTourActivity.java"


# static fields
.field private static final S_INDEX:Ljava/lang/String; = "mr_tour_index"

.field private static final S_STEPS:Ljava/lang/String; = "mr_tour_steps"


# instance fields
.field private k:Lcom/mrkeyboard/app/MrKit;

.field private mCol:Landroid/widget/LinearLayout;

.field private final mHandler:Landroid/os/Handler;

.field private mIndex:I

.field private final mPoll:Ljava/lang/Runnable;

.field private mSig:Ljava/lang/String;

.field private mSteps:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 23
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 28
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHandler:Landroid/os/Handler;

    .line 29
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    .line 35
    new-instance v0, Lcom/mrkeyboard/app/MrTourActivity$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrTourActivity$1;-><init>(Lcom/mrkeyboard/app/MrTourActivity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPoll:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/widget/LinearLayout;
    .locals 1

    .prologue
    .line 23
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mCol:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrTourActivity;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 23
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->signature()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrTourActivity;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 23
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSig:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$202(Lcom/mrkeyboard/app/MrTourActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 23
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSig:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/MrTourActivity;)V
    .locals 0

    .prologue
    .line 23
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->render()V

    return-void
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/os/Handler;
    .locals 1

    .prologue
    .line 23
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/MrTourActivity;)Ljava/lang/Runnable;
    .locals 1

    .prologue
    .line 23
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPoll:Ljava/lang/Runnable;

    return-object v0
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/MrTourActivity;)V
    .locals 0

    .prologue
    .line 23
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->next()V

    return-void
.end method

.method private static iconOf(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 112
    const-string v0, "dict"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "mr_ui_ic_book_mint"

    .line 114
    :goto_0
    return-object v0

    .line 113
    :cond_0
    const-string v0, "gesture"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "mr_ui_ic_swipe_amber"

    goto :goto_0

    .line 114
    :cond_1
    const-string v0, "mr_ui_ic_keycap_blue"

    goto :goto_0
.end method

.method private next()V
    .locals 2

    .prologue
    .line 241
    iget v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    add-int/lit8 v0, v0, 0x1

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lt v0, v1, :cond_0

    .line 242
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrTourActivity;->finish()V

    .line 248
    :goto_0
    return-void

    .line 245
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    .line 246
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->signature()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSig:Ljava/lang/String;

    .line 247
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->render()V

    goto :goto_0
.end method

.method private render()V
    .locals 18

    .prologue
    .line 118
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrTourActivity;->mCol:Landroid/widget/LinearLayout;

    if-eqz v1, :cond_0

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 238
    :cond_0
    :goto_0
    return-void

    .line 119
    :cond_1
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrTourActivity;->mCol:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 120
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 121
    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    add-int/lit8 v3, v3, -0x1

    if-ne v2, v3, :cond_2

    const/4 v2, 0x1

    .line 122
    :goto_1
    sget-boolean v3, Lcom/mrkeyboard/app/MrTour;->sBusy:Z

    if-eqz v3, :cond_3

    sget-object v3, Lcom/mrkeyboard/app/MrTour;->sStep:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    const/4 v3, 0x1

    .line 123
    :goto_2
    move-object/from16 v0, p0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTour;->ready(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v9

    .line 124
    sget-object v4, Lcom/mrkeyboard/app/MrTour;->sErrorStep:Ljava/lang/String;

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    sget-object v4, Lcom/mrkeyboard/app/MrTour;->sError:Ljava/lang/String;

    .line 125
    :goto_3
    const-string v5, "word"

    invoke-virtual {v5, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_5

    const/4 v5, 0x1

    .line 128
    :goto_4
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v6

    .line 129
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v10, "mr_tour_title"

    const/4 v11, 0x0

    new-array v11, v11, [Ljava/lang/Object;

    invoke-virtual {v8, v10, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    const/high16 v10, 0x41c00000    # 24.0f

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v11, v11, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v12, 0x1

    invoke-virtual {v7, v8, v10, v11, v12}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v7

    .line 130
    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v10, 0x0

    const/4 v11, -0x2

    const/high16 v12, 0x3f800000    # 1.0f

    invoke-direct {v8, v10, v11, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v6, v7, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 131
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v10, "mr_tour_skip"

    const/4 v11, 0x0

    new-array v11, v11, [Ljava/lang/Object;

    invoke-virtual {v8, v10, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    const/high16 v10, 0x41700000    # 15.0f

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v11, v11, Lcom/mrkeyboard/app/MrKit;->accent:I

    const/4 v12, 0x1

    invoke-virtual {v7, v8, v10, v11, v12}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v7

    .line 132
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v10, 0x41400000    # 12.0f

    invoke-virtual {v8, v10}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v8

    move-object/from16 v0, p0

    iget-object v10, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v11, 0x41000000    # 8.0f

    invoke-virtual {v10, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v10

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v12, 0x40800000    # 4.0f

    invoke-virtual {v11, v12}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v11

    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v13, 0x41000000    # 8.0f

    invoke-virtual {v12, v13}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v12

    invoke-virtual {v7, v8, v10, v11, v12}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 133
    const/4 v8, 0x1

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setClickable(Z)V

    .line 134
    new-instance v8, Lcom/mrkeyboard/app/MrTourActivity$2;

    move-object/from16 v0, p0

    invoke-direct {v8, v0}, Lcom/mrkeyboard/app/MrTourActivity$2;-><init>(Lcom/mrkeyboard/app/MrTourActivity;)V

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 139
    invoke-virtual {v6, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 140
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrTourActivity;->mCol:Landroid/widget/LinearLayout;

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v10, 0x0

    invoke-virtual {v8, v10}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v8

    invoke-virtual {v7, v6, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 143
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->mCol:Landroid/widget/LinearLayout;

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v10, "mr_tour_step"

    const/4 v11, 0x2

    new-array v11, v11, [Ljava/lang/Object;

    const/4 v12, 0x0

    move-object/from16 v0, p0

    iget v13, v0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    add-int/lit8 v13, v13, 0x1

    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    aput-object v13, v11, v12

    const/4 v12, 0x1

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v13}, Ljava/util/ArrayList;->size()I

    move-result v13

    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    aput-object v13, v11, v12

    invoke-virtual {v8, v10, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    const/high16 v10, 0x41600000    # 14.0f

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v11, v11, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v12, 0x0

    invoke-virtual {v7, v8, v10, v11, v12}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v7

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v10, 0x4

    invoke-virtual {v8, v10}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 144
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v10

    .line 145
    const/4 v6, 0x0

    :goto_5
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v7

    if-ge v6, v7, :cond_9

    .line 146
    new-instance v11, Landroid/view/View;

    move-object/from16 v0, p0

    invoke-direct {v11, v0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 147
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget v7, v0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    if-gt v6, v7, :cond_6

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->accent:I

    :goto_6
    const/4 v12, 0x0

    const/high16 v13, 0x40000000    # 2.0f

    const/4 v14, 0x0

    invoke-virtual {v8, v7, v12, v13, v14}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v7

    invoke-virtual {v11, v7}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 148
    new-instance v12, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v7, 0x0

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v13, 0x40800000    # 4.0f

    invoke-virtual {v8, v13}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v8

    const/high16 v13, 0x3f800000    # 1.0f

    invoke-direct {v12, v7, v8, v13}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 149
    if-nez v6, :cond_7

    const/4 v7, 0x0

    :goto_7
    const/4 v13, 0x0

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v8

    add-int/lit8 v8, v8, -0x1

    if-ne v6, v8, :cond_8

    const/4 v8, 0x0

    :goto_8
    const/4 v14, 0x0

    invoke-virtual {v12, v7, v13, v8, v14}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 150
    invoke-virtual {v10, v11, v12}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 145
    add-int/lit8 v6, v6, 0x1

    goto :goto_5

    .line 121
    :cond_2
    const/4 v2, 0x0

    goto/16 :goto_1

    .line 122
    :cond_3
    const/4 v3, 0x0

    goto/16 :goto_2

    .line 124
    :cond_4
    const/4 v4, 0x0

    goto/16 :goto_3

    .line 125
    :cond_5
    const/4 v5, 0x0

    goto/16 :goto_4

    .line 147
    :cond_6
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->line:I

    goto :goto_6

    .line 149
    :cond_7
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v8, 0x40400000    # 3.0f

    invoke-virtual {v7, v8}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v7

    goto :goto_7

    :cond_8
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v14, 0x40400000    # 3.0f

    invoke-virtual {v8, v14}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v8

    goto :goto_8

    .line 152
    :cond_9
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->mCol:Landroid/widget/LinearLayout;

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v8, 0xa

    invoke-virtual {v7, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v7

    invoke-virtual {v6, v10, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 155
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6}, Lcom/mrkeyboard/app/MrKit;->panel()Landroid/widget/LinearLayout;

    move-result-object v10

    .line 156
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTourActivity;->iconOf(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const/high16 v8, 0x41f00000    # 30.0f

    invoke-virtual {v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->iconView(Ljava/lang/String;F)Landroid/widget/ImageView;

    move-result-object v6

    invoke-virtual {v10, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 157
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "mr_tour_"

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v11, "_title"

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    const/4 v11, 0x0

    new-array v11, v11, [Ljava/lang/Object;

    invoke-virtual {v7, v8, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    const/high16 v8, 0x41a00000    # 20.0f

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v11, v11, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v12, 0x1

    invoke-virtual {v6, v7, v8, v11, v12}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v6

    .line 158
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v8, 0xc

    invoke-virtual {v7, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v7

    invoke-virtual {v10, v6, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 159
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "mr_tour_"

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v11, "_text"

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    const/4 v11, 0x0

    new-array v11, v11, [Ljava/lang/Object;

    invoke-virtual {v7, v8, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    const/high16 v8, 0x41600000    # 14.0f

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v11, v11, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v12, 0x0

    invoke-virtual {v6, v7, v8, v11, v12}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v6

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v8, 0x8

    invoke-virtual {v7, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v7

    invoke-virtual {v10, v6, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 160
    const-string v6, "dict"

    invoke-virtual {v6, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_c

    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/MrTour;->packIdForSystem(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v6

    .line 161
    :goto_9
    const-string v7, "dict"

    invoke-virtual {v7, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_d

    if-nez v6, :cond_d

    if-nez v9, :cond_d

    const/4 v7, 0x1

    move v8, v7

    .line 164
    :goto_a
    if-eqz v3, :cond_f

    .line 165
    sget-boolean v6, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    if-eqz v6, :cond_e

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_dicts_state_installing"

    const/4 v11, 0x0

    new-array v11, v11, [Ljava/lang/Object;

    invoke-virtual {v6, v7, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    .line 166
    :goto_b
    const-string v7, "mr_ui_amber"

    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/MrTourActivity;->uiColor(Ljava/lang/String;)I

    move-result v7

    move/from16 v17, v7

    move-object v7, v6

    move/from16 v6, v17

    .line 186
    :goto_c
    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v12, 0x41600000    # 14.0f

    const/4 v13, 0x1

    invoke-virtual {v11, v7, v12, v6, v13}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v6

    .line 187
    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v12, 0x41400000    # 12.0f

    invoke-virtual {v11, v12}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v11

    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v13, 0x41200000    # 10.0f

    invoke-virtual {v12, v13}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v12

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v14, 0x41400000    # 12.0f

    invoke-virtual {v13, v14}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v15, 0x41200000    # 10.0f

    invoke-virtual {v14, v15}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v14

    invoke-virtual {v6, v11, v12, v13, v14}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 188
    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v12, v12, Lcom/mrkeyboard/app/MrKit;->raised:I

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v13, v13, Lcom/mrkeyboard/app/MrKit;->line:I

    const/high16 v14, 0x41400000    # 12.0f

    const/4 v15, 0x0

    invoke-virtual {v11, v12, v13, v14, v15}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v11

    invoke-virtual {v6, v11}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 189
    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v12, 0xe

    invoke-virtual {v11, v12}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v11

    invoke-virtual {v10, v6, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 190
    if-eqz v5, :cond_a

    if-nez v9, :cond_a

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v12, "mr_tour_net_note"

    const/4 v13, 0x0

    new-array v13, v13, [Ljava/lang/Object;

    invoke-virtual {v11, v12, v13}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v11

    const/high16 v12, 0x41400000    # 12.0f

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v13, v13, Lcom/mrkeyboard/app/MrKit;->hint:I

    const/4 v14, 0x0

    invoke-virtual {v6, v11, v12, v13, v14}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v6

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v12, 0xa

    invoke-virtual {v11, v12}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v11

    invoke-virtual {v10, v6, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 191
    :cond_a
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->mCol:Landroid/widget/LinearLayout;

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v12, 0x10

    invoke-virtual {v11, v12}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v11

    invoke-virtual {v6, v10, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 195
    const/4 v6, 0x0

    .line 196
    if-eqz v3, :cond_15

    .line 197
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-virtual {v1, v7, v2, v3}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v1

    .line 198
    const v2, 0x3f19999a    # 0.6f

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setAlpha(F)V

    move-object v2, v1

    move-object v1, v6

    .line 235
    :goto_d
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrTourActivity;->mCol:Landroid/widget/LinearLayout;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v5, 0x10

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    invoke-virtual {v3, v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 236
    if-eqz v1, :cond_b

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrTourActivity;->mCol:Landroid/widget/LinearLayout;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x8

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v2, v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 237
    :cond_b
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrTourActivity;->mCol:Landroid/widget/LinearLayout;

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_tour_later"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/high16 v4, 0x41400000    # 12.0f

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->hint:I

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xe

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto/16 :goto_0

    .line 160
    :cond_c
    const/4 v6, 0x0

    goto/16 :goto_9

    .line 161
    :cond_d
    const/4 v7, 0x0

    move v8, v7

    goto/16 :goto_a

    .line 165
    :cond_e
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_dicts_state_downloading"

    const/4 v11, 0x1

    new-array v11, v11, [Ljava/lang/Object;

    const/4 v12, 0x0

    sget v13, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    aput-object v13, v11, v12

    invoke-virtual {v6, v7, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    goto/16 :goto_b

    .line 167
    :cond_f
    if-eqz v4, :cond_10

    .line 169
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->rose:I

    move-object v7, v4

    goto/16 :goto_c

    .line 170
    :cond_10
    if-eqz v9, :cond_11

    if-eqz v5, :cond_11

    .line 171
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_tour_ready"

    const/4 v11, 0x0

    new-array v11, v11, [Ljava/lang/Object;

    invoke-virtual {v6, v7, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    .line 172
    const-string v6, "mr_ui_mint"

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrTourActivity;->uiColor(Ljava/lang/String;)I

    move-result v6

    goto/16 :goto_c

    .line 173
    :cond_11
    if-eqz v8, :cond_12

    .line 174
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_tour_dict_nopack"

    const/4 v11, 0x0

    new-array v11, v11, [Ljava/lang/Object;

    invoke-virtual {v6, v7, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    .line 175
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->text2:I

    goto/16 :goto_c

    .line 176
    :cond_12
    const-string v7, "dict"

    invoke-virtual {v7, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_13

    .line 177
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v11, "mr_tour_dict_missing"

    const/4 v12, 0x1

    new-array v12, v12, [Ljava/lang/Object;

    const/4 v13, 0x0

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v15, 0x2d

    const/16 v16, 0x5f

    move/from16 v0, v16

    invoke-virtual {v6, v15, v0}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v14, v6}, Lcom/mrkeyboard/app/MrKit;->langName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v12, v13

    invoke-virtual {v7, v11, v12}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    .line 178
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->text2:I

    goto/16 :goto_c

    .line 179
    :cond_13
    if-eqz v5, :cond_14

    .line 180
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_tour_gesture_missing"

    const/4 v11, 0x0

    new-array v11, v11, [Ljava/lang/Object;

    invoke-virtual {v6, v7, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    .line 181
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->text2:I

    goto/16 :goto_c

    .line 183
    :cond_14
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_tour_word_on"

    const/4 v11, 0x0

    new-array v11, v11, [Ljava/lang/Object;

    invoke-virtual {v6, v7, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    .line 184
    const-string v6, "mr_ui_mint"

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrTourActivity;->uiColor(Ljava/lang/String;)I

    move-result v6

    goto/16 :goto_c

    .line 199
    :cond_15
    if-eqz v5, :cond_18

    if-nez v9, :cond_18

    .line 200
    if-eqz v8, :cond_16

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_tour_choose"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 202
    :goto_e
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x1

    new-instance v5, Lcom/mrkeyboard/app/MrTourActivity$3;

    move-object/from16 v0, p0

    invoke-direct {v5, v0, v8, v1}, Lcom/mrkeyboard/app/MrTourActivity$3;-><init>(Lcom/mrkeyboard/app/MrTourActivity;ZLjava/lang/String;)V

    invoke-virtual {v3, v2, v4, v5}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    .line 213
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "mr_tour_"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "_off"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    new-instance v6, Lcom/mrkeyboard/app/MrTourActivity$4;

    move-object/from16 v0, p0

    invoke-direct {v6, v0, v1}, Lcom/mrkeyboard/app/MrTourActivity$4;-><init>(Lcom/mrkeyboard/app/MrTourActivity;Ljava/lang/String;)V

    invoke-virtual {v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v1

    goto/16 :goto_d

    .line 200
    :cond_16
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    if-eqz v4, :cond_17

    const-string v2, "mr_tour_retry"

    :goto_f
    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v3, v2, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    goto :goto_e

    :cond_17
    const-string v2, "mr_tour_download"

    goto :goto_f

    .line 220
    :cond_18
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    if-eqz v5, :cond_1a

    if-eqz v2, :cond_19

    const-string v2, "mr_tour_finish"

    :goto_10
    const/4 v7, 0x0

    new-array v7, v7, [Ljava/lang/Object;

    invoke-virtual {v4, v2, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/4 v4, 0x1

    new-instance v7, Lcom/mrkeyboard/app/MrTourActivity$5;

    move-object/from16 v0, p0

    invoke-direct {v7, v0}, Lcom/mrkeyboard/app/MrTourActivity$5;-><init>(Lcom/mrkeyboard/app/MrTourActivity;)V

    invoke-virtual {v3, v2, v4, v7}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    .line 226
    if-nez v5, :cond_1c

    .line 227
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_tour_word_off"

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    new-instance v6, Lcom/mrkeyboard/app/MrTourActivity$6;

    move-object/from16 v0, p0

    invoke-direct {v6, v0, v1}, Lcom/mrkeyboard/app/MrTourActivity$6;-><init>(Lcom/mrkeyboard/app/MrTourActivity;Ljava/lang/String;)V

    invoke-virtual {v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v1

    goto/16 :goto_d

    .line 220
    :cond_19
    const-string v2, "mr_tour_continue"

    goto :goto_10

    :cond_1a
    if-eqz v2, :cond_1b

    const-string v2, "mr_tour_keep_finish"

    goto :goto_10

    :cond_1b
    const-string v2, "mr_tour_keep"

    goto :goto_10

    :cond_1c
    move-object v1, v6

    goto/16 :goto_d
.end method

.method private signature()Ljava/lang/String;
    .locals 5

    .prologue
    .line 49
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 50
    sget-boolean v1, Lcom/mrkeyboard/app/MrTour;->sBusy:Z

    if-eqz v1, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrTour;->sStep:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    .line 51
    :goto_0
    sget-object v2, Lcom/mrkeyboard/app/MrTour;->sErrorStep:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    sget-object v2, Lcom/mrkeyboard/app/MrTour;->sError:Ljava/lang/String;

    .line 52
    :goto_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "|"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "|"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v3, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "|"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-boolean v3, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "|"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "|"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTour;->ready(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "|"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 53
    const-string v2, "dict"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-static {p0}, Lcom/mrkeyboard/app/MrTour;->packIdForSystem(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    :goto_2
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 52
    return-object v0

    .line 50
    :cond_0
    const/4 v1, 0x0

    goto :goto_0

    .line 51
    :cond_1
    const/4 v2, 0x0

    goto :goto_1

    .line 53
    :cond_2
    const-string v0, ""

    goto :goto_2
.end method

.method private uiColor(Ljava/lang/String;)I
    .locals 4

    .prologue
    .line 108
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrTourActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrTourActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "color"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrTourActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, p1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getColor(I)I

    move-result v0

    return v0
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 7

    .prologue
    const/high16 v6, 0x41a00000    # 20.0f

    const/4 v1, 0x0

    .line 58
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 59
    new-instance v0, Lcom/mrkeyboard/app/MrKit;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrKit;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 60
    if-eqz p1, :cond_2

    .line 61
    const-string v0, "mr_tour_steps"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 62
    if-eqz v0, :cond_1

    const-string v2, ","

    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    array-length v3, v2

    move v0, v1

    :goto_0
    if-ge v0, v3, :cond_1

    aget-object v4, v2, v0

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 63
    :cond_1
    const-string v0, "mr_tour_index"

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    .line 65
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-static {p0}, Lcom/mrkeyboard/app/MrTour;->steps(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    .line 66
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 67
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrTourActivity;->finish()V

    .line 80
    :goto_1
    return-void

    .line 70
    :cond_4
    iget v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    if-ltz v0, :cond_5

    iget v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lt v0, v2, :cond_6

    :cond_5
    iput v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    .line 72
    :cond_6
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 73
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->bg:I

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v1, v4, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 74
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    iput-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mCol:Landroid/widget/LinearLayout;

    .line 75
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mCol:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41800000    # 16.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41c00000    # 24.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 76
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mCol:Landroid/widget/LinearLayout;

    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-direct {v2, v3, v4}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 77
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrTourActivity;->setContentView(Landroid/view/View;)V

    .line 78
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->signature()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSig:Ljava/lang/String;

    .line 79
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->render()V

    goto :goto_1
.end method

.method protected onDestroy()V
    .locals 2

    .prologue
    .line 252
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 253
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 254
    return-void
.end method

.method protected onPause()V
    .locals 2

    .prologue
    .line 101
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 102
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 103
    return-void
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 93
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 94
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mCol:Landroid/widget/LinearLayout;

    if-nez v0, :cond_0

    .line 97
    :goto_0
    return-void

    .line 95
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 96
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 4

    .prologue
    .line 84
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 85
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 86
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v3, 0x2c

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 87
    :cond_0
    const-string v0, "mr_tour_steps"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 88
    const-string v0, "mr_tour_index"

    iget v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 89
    return-void
.end method
