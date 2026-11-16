.class public Lcom/mrkeyboard/app/MrTourActivity;
.super Landroid/app/Activity;
.source "MrTourActivity.java"


# static fields
.field private static final BUSY:I = 0x1

.field private static final COLUMN_DP:F = 440.0f

.field private static final ERROR:I = 0x2

.field private static final NOPACK:I = 0x4

.field private static final READY:I = 0x3

.field private static final S_INDEX:Ljava/lang/String; = "mr_tour_index"

.field private static final S_STEPS:Ljava/lang/String; = "mr_tour_steps"

.field private static final T_BAR:J = 0x1ccL

.field private static final T_ENTER:J = 0x154L

.field private static final T_EXIT:J = 0xa0L

.field private static final WAIT:I


# instance fields
.field private k:Lcom/mrkeyboard/app/MrKit;

.field private mActions:Landroid/widget/LinearLayout;

.field private mArt:Landroid/widget/FrameLayout;

.field private mBarBox:Landroid/widget/LinearLayout;

.field private mBody:Landroid/widget/LinearLayout;

.field private mChip:Landroid/widget/LinearLayout;

.field private mChipDot:Landroid/view/View;

.field private mChipText:Landroid/widget/TextView;

.field private mCounter:Landroid/widget/TextView;

.field private mDisc:Landroid/view/View;

.field private final mFills:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private mGlyph:Landroid/widget/ImageView;

.field private mGlyphName:Ljava/lang/String;

.field private mHalo:Landroid/view/View;

.field private final mHandler:Landroid/os/Handler;

.field private final mIn:Landroid/view/animation/PathInterpolator;

.field private mIndex:I

.field private final mLinear:Landroid/view/animation/LinearInterpolator;

.field private mMoving:Z

.field private mNote:Landroid/widget/TextView;

.field private final mOut:Landroid/view/animation/PathInterpolator;

.field private final mPoll:Ljava/lang/Runnable;

.field private mPrimary:Landroid/widget/FrameLayout;

.field private mPrimaryFill:Landroid/view/View;

.field private mPrimaryLabel:Landroid/widget/TextView;

.field private mPulseGen:I

.field private mPulsing:Z

.field private mRing:Landroid/view/View;

.field private mSecondary:Landroid/widget/TextView;

.field private mSig:Ljava/lang/String;

.field private mStage:Landroid/widget/LinearLayout;

.field private mState:I

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

.field private mText:Landroid/widget/TextView;

.field private mTitle:Landroid/widget/TextView;

.field private mTop:Landroid/widget/LinearLayout;

.field private final mUnstick:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 4

    .prologue
    const/high16 v3, 0x3f800000    # 1.0f

    const/4 v2, 0x0

    .line 49
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 67
    new-instance v0, Landroid/view/animation/PathInterpolator;

    const v1, 0x3e99999a    # 0.3f

    invoke-direct {v0, v1, v2, v3, v3}, Landroid/view/animation/PathInterpolator;-><init>(FFFF)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mOut:Landroid/view/animation/PathInterpolator;

    .line 68
    new-instance v0, Landroid/view/animation/PathInterpolator;

    invoke-direct {v0, v2, v2, v2, v3}, Landroid/view/animation/PathInterpolator;-><init>(FFFF)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIn:Landroid/view/animation/PathInterpolator;

    .line 69
    new-instance v0, Landroid/view/animation/LinearInterpolator;

    invoke-direct {v0}, Landroid/view/animation/LinearInterpolator;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mLinear:Landroid/view/animation/LinearInterpolator;

    .line 72
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHandler:Landroid/os/Handler;

    .line 73
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    .line 80
    const/4 v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mState:I

    .line 89
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mFills:Ljava/util/ArrayList;

    .line 112
    new-instance v0, Lcom/mrkeyboard/app/MrTourActivity$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrTourActivity$1;-><init>(Lcom/mrkeyboard/app/MrTourActivity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPoll:Ljava/lang/Runnable;

    .line 127
    new-instance v0, Lcom/mrkeyboard/app/MrTourActivity$2;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrTourActivity$2;-><init>(Lcom/mrkeyboard/app/MrTourActivity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mUnstick:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/widget/LinearLayout;
    .locals 1

    .prologue
    .line 49
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mBody:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrTourActivity;)Z
    .locals 1

    .prologue
    .line 49
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mMoving:Z

    return v0
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/MrTourActivity;)V
    .locals 0

    .prologue
    .line 49
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->buildBody()V

    return-void
.end method

.method static synthetic access$102(Lcom/mrkeyboard/app/MrTourActivity;Z)Z
    .locals 0

    .prologue
    .line 49
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mMoving:Z

    return p1
.end method

.method static synthetic access$1102(Lcom/mrkeyboard/app/MrTourActivity;I)I
    .locals 0

    .prologue
    .line 49
    iput p1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mState:I

    return p1
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/MrTourActivity;Z)V
    .locals 0

    .prologue
    .line 49
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrTourActivity;->updateBar(Z)V

    return-void
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/MrTourActivity;)Ljava/lang/Runnable;
    .locals 1

    .prologue
    .line 49
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mUnstick:Ljava/lang/Runnable;

    return-object v0
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/MrTourActivity;)V
    .locals 0

    .prologue
    .line 49
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->kick()V

    return-void
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/view/animation/PathInterpolator;
    .locals 1

    .prologue
    .line 49
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIn:Landroid/view/animation/PathInterpolator;

    return-object v0
.end method

.method static synthetic access$1600(Lcom/mrkeyboard/app/MrTourActivity;)I
    .locals 1

    .prologue
    .line 49
    iget v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPulseGen:I

    return v0
.end method

.method static synthetic access$1702(Lcom/mrkeyboard/app/MrTourActivity;Z)Z
    .locals 0

    .prologue
    .line 49
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPulsing:Z

    return p1
.end method

.method static synthetic access$1800(Lcom/mrkeyboard/app/MrTourActivity;I)V
    .locals 0

    .prologue
    .line 49
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrTourActivity;->loopPulse(I)V

    return-void
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrTourActivity;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 49
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->signature()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/MrTourActivity;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 49
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSig:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$302(Lcom/mrkeyboard/app/MrTourActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 49
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSig:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/MrTourActivity;Z)V
    .locals 0

    .prologue
    .line 49
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrTourActivity;->update(Z)V

    return-void
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/MrTourActivity;)Z
    .locals 1

    .prologue
    .line 49
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->keepPolling()Z

    move-result v0

    return v0
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/os/Handler;
    .locals 1

    .prologue
    .line 49
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/MrTourActivity;Ljava/lang/String;I)V
    .locals 0

    .prologue
    .line 49
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/MrTourActivity;->onPrimary(Ljava/lang/String;I)V

    return-void
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/MrTourActivity;)V
    .locals 0

    .prologue
    .line 49
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->next()V

    return-void
.end method

.method static synthetic access$902(Lcom/mrkeyboard/app/MrTourActivity;I)I
    .locals 0

    .prologue
    .line 49
    iput p1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    return p1
.end method

.method private applySide()V
    .locals 7

    .prologue
    const/4 v4, 0x0

    const/high16 v6, 0x41800000    # 16.0f

    const/high16 v5, 0x40800000    # 4.0f

    .line 248
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mTop:Landroid/widget/LinearLayout;

    if-nez v0, :cond_0

    .line 255
    :goto_0
    return-void

    .line 249
    :cond_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrTourActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    .line 250
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x41c00000    # 24.0f

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x43dc0000    # 440.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    sub-int/2addr v0, v2

    div-int/lit8 v0, v0, 0x2

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 251
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mTop:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x40c00000    # 6.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {v1, v0, v2, v0, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 252
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mBarBox:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x40000000    # 2.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {v1, v0, v2, v0, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 253
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mStage:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    add-int/2addr v2, v0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    add-int/2addr v4, v0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 254
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mActions:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41000000    # 8.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41a00000    # 20.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v1, v0, v2, v0, v3}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    goto :goto_0
.end method

.method private buildBody()V
    .locals 13

    .prologue
    const/4 v12, 0x0

    const/4 v11, -0x1

    const/16 v10, 0x11

    const/4 v9, 0x1

    const/4 v8, 0x0

    .line 348
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->stopPulse()V

    .line 349
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->step()Ljava/lang/String;

    move-result-object v0

    .line 350
    invoke-static {v0}, Lcom/mrkeyboard/app/MrTour;->isSetup(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrTour;->markDone(Landroid/content/Context;)V

    .line 351
    :cond_0
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mGlyphName:Ljava/lang/String;

    .line 352
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mStage:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 353
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mActions:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 355
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x43280000    # 168.0f

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    .line 356
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x42e80000    # 116.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    .line 357
    new-instance v3, Landroid/widget/FrameLayout;

    invoke-direct {v3, p0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mArt:Landroid/widget/FrameLayout;

    .line 358
    new-instance v3, Landroid/view/View;

    invoke-direct {v3, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHalo:Landroid/view/View;

    .line 359
    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mArt:Landroid/widget/FrameLayout;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHalo:Landroid/view/View;

    new-instance v5, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v5, v1, v1, v10}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    invoke-virtual {v3, v4, v5}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 360
    new-instance v3, Landroid/view/View;

    invoke-direct {v3, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mRing:Landroid/view/View;

    .line 361
    new-instance v3, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v3}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 362
    invoke-virtual {v3, v9}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 363
    iget-object v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x40000000    # 2.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-static {v9, v4}, Ljava/lang/Math;->max(II)I

    move-result v4

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrTourActivity;->stepColor(Ljava/lang/String;)I

    move-result v5

    const/16 v6, 0xcc

    invoke-static {v5, v6}, Lcom/mrkeyboard/app/MrTourActivity;->tint(II)I

    move-result v5

    invoke-virtual {v3, v4, v5}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 364
    iget-object v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->mRing:Landroid/view/View;

    invoke-virtual {v4, v3}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 365
    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mRing:Landroid/view/View;

    invoke-virtual {v3, v12}, Landroid/view/View;->setAlpha(F)V

    .line 366
    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mArt:Landroid/widget/FrameLayout;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->mRing:Landroid/view/View;

    new-instance v5, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v5, v2, v2, v10}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    invoke-virtual {v3, v4, v5}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 367
    new-instance v3, Landroid/view/View;

    invoke-direct {v3, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mDisc:Landroid/view/View;

    .line 368
    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mArt:Landroid/widget/FrameLayout;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->mDisc:Landroid/view/View;

    new-instance v5, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v5, v2, v2, v10}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    invoke-virtual {v3, v4, v5}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 369
    new-instance v2, Landroid/widget/ImageView;

    invoke-direct {v2, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mGlyph:Landroid/widget/ImageView;

    .line 370
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mArt:Landroid/widget/FrameLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mGlyph:Landroid/widget/ImageView;

    new-instance v4, Landroid/widget/FrameLayout$LayoutParams;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x42500000    # 52.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    iget-object v6, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x42500000    # 52.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-direct {v4, v5, v6, v10}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    invoke-virtual {v2, v3, v4}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 371
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mStage:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mArt:Landroid/widget/FrameLayout;

    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v4, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 373
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "mr_tour_"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "_title"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v3, v8, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/high16 v2, 0x41d00000    # 26.0f

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-direct {p0, v1, v2, v3, v9}, Lcom/mrkeyboard/app/MrTourActivity;->centred(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    iput-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mTitle:Landroid/widget/TextView;

    .line 374
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mStage:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mTitle:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x1a

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 375
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "mr_tour_"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "_text"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v2, v8, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/high16 v1, 0x41780000    # 15.5f

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-direct {p0, v0, v1, v2, v8}, Lcom/mrkeyboard/app/MrTourActivity;->centred(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mText:Landroid/widget/TextView;

    .line 376
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mText:Landroid/widget/TextView;

    const v1, 0x3f99999a    # 1.2f

    invoke-virtual {v0, v12, v1}, Landroid/widget/TextView;->setLineSpacing(FF)V

    .line 377
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mStage:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mText:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0xc

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 379
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mChip:Landroid/widget/LinearLayout;

    .line 380
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mChip:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x41600000    # 14.0f

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41100000    # 9.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41800000    # 16.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41100000    # 9.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 381
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mChip:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->raised:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->line:I

    const/high16 v4, 0x41900000    # 18.0f

    invoke-virtual {v1, v2, v3, v4, v8}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 382
    new-instance v0, Landroid/view/View;

    invoke-direct {v0, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mChipDot:Landroid/view/View;

    .line 383
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x41000000    # 8.0f

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41000000    # 8.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-direct {v0, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 384
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x41000000    # 8.0f

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-virtual {v0, v8, v8, v1, v8}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 385
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mChip:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mChipDot:Landroid/view/View;

    invoke-virtual {v1, v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 386
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, ""

    const/high16 v2, 0x41500000    # 13.0f

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v0, v1, v2, v3, v9}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mChipText:Landroid/widget/TextView;

    .line 387
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mChip:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mChipText:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 388
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mStage:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mChip:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v3, -0x2

    const/4 v4, -0x2

    const/16 v5, 0x16

    invoke-virtual {v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->lp(III)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 391
    new-instance v0, Landroid/widget/FrameLayout;

    invoke-direct {v0, p0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimary:Landroid/widget/FrameLayout;

    .line 392
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimary:Landroid/widget/FrameLayout;

    invoke-virtual {v0, v9}, Landroid/widget/FrameLayout;->setClickable(Z)V

    .line 393
    new-instance v0, Landroid/view/View;

    invoke-direct {v0, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryFill:Landroid/view/View;

    .line 394
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryFill:Landroid/view/View;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->accent:I

    const/high16 v3, 0x41d80000    # 27.0f

    invoke-virtual {v1, v2, v8, v3, v8}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 395
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryFill:Landroid/view/View;

    invoke-virtual {v0, v12}, Landroid/view/View;->setPivotX(F)V

    .line 396
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryFill:Landroid/view/View;

    invoke-virtual {v0, v12}, Landroid/view/View;->setScaleX(F)V

    .line 397
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryFill:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 398
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimary:Landroid/widget/FrameLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryFill:Landroid/view/View;

    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v2, v11, v11}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 399
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, ""

    const/high16 v2, 0x41800000    # 16.0f

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    invoke-virtual {v0, v1, v2, v3, v9}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryLabel:Landroid/widget/TextView;

    .line 400
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryLabel:Landroid/widget/TextView;

    invoke-virtual {v0, v10}, Landroid/widget/TextView;->setGravity(I)V

    .line 401
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimary:Landroid/widget/FrameLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryLabel:Landroid/widget/TextView;

    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v2, v11, v11, v10}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 402
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimary:Landroid/widget/FrameLayout;

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrTourActivity;->pressable(Landroid/view/View;)V

    .line 403
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mActions:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimary:Landroid/widget/FrameLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x42580000    # 54.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v2, v11, v3, v8}, Lcom/mrkeyboard/app/MrKit;->lp(III)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 405
    const-string v0, ""

    const/high16 v1, 0x41700000    # 15.0f

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-direct {p0, v0, v1, v2, v9}, Lcom/mrkeyboard/app/MrTourActivity;->centred(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSecondary:Landroid/widget/TextView;

    .line 406
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSecondary:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x41400000    # 12.0f

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41600000    # 14.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41400000    # 12.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41600000    # 14.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 407
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSecondary:Landroid/widget/TextView;

    invoke-virtual {v0, v9}, Landroid/widget/TextView;->setClickable(Z)V

    .line 408
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSecondary:Landroid/widget/TextView;

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrTourActivity;->pressable(Landroid/view/View;)V

    .line 409
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mActions:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSecondary:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v3, 0x4

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 410
    const-string v0, ""

    const/high16 v1, 0x41400000    # 12.0f

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->hint:I

    invoke-direct {p0, v0, v1, v2, v8}, Lcom/mrkeyboard/app/MrTourActivity;->centred(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mNote:Landroid/widget/TextView;

    .line 411
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mActions:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mNote:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 412
    return-void
.end method

.method private bump(Landroid/view/View;)V
    .locals 4

    .prologue
    const v1, 0x3f8f5c29    # 1.12f

    .line 660
    invoke-virtual {p1}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->scaleX(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->scaleY(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const-wide/16 v2, 0x0

    invoke-virtual {v0, v2, v3}, Landroid/view/ViewPropertyAnimator;->setStartDelay(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const-wide/16 v2, 0x8c

    invoke-virtual {v0, v2, v3}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIn:Landroid/view/animation/PathInterpolator;

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/MrTourActivity$7;

    invoke-direct {v1, p0, p1}, Lcom/mrkeyboard/app/MrTourActivity$7;-><init>(Lcom/mrkeyboard/app/MrTourActivity;Landroid/view/View;)V

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->withEndAction(Ljava/lang/Runnable;)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    .line 664
    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->start()V

    .line 665
    return-void
.end method

.method private centred(Ljava/lang/String;FIZ)Landroid/widget/TextView;
    .locals 2

    .prologue
    .line 341
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 342
    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V

    .line 343
    return-object v0
.end method

.method private disc(I)Landroid/graphics/drawable/GradientDrawable;
    .locals 4

    .prologue
    const/4 v3, 0x1

    .line 333
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 334
    invoke-virtual {v0, v3}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 335
    const/16 v1, 0x24

    invoke-static {p1, v1}, Lcom/mrkeyboard/app/MrTourActivity;->tint(II)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 336
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x3fc00000    # 1.5f

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-static {v3, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    const/16 v2, 0x8c

    invoke-static {p1, v2}, Lcom/mrkeyboard/app/MrTourActivity;->tint(II)I

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 337
    return-object v0
.end method

.method private enter()V
    .locals 8

    .prologue
    const/4 v0, 0x0

    const/high16 v7, 0x3f800000    # 1.0f

    const/4 v6, 0x0

    .line 639
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mArt:Landroid/widget/FrameLayout;

    const-wide/16 v2, 0x28

    invoke-direct {p0, v1, v2, v3}, Lcom/mrkeyboard/app/MrTourActivity;->popIn(Landroid/view/View;J)V

    .line 640
    const/4 v1, 0x3

    new-array v1, v1, [Landroid/view/View;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mTitle:Landroid/widget/TextView;

    aput-object v2, v1, v0

    const/4 v2, 0x1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mText:Landroid/widget/TextView;

    aput-object v3, v1, v2

    const/4 v2, 0x2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mChip:Landroid/widget/LinearLayout;

    aput-object v3, v1, v2

    .line 641
    :goto_0
    array-length v2, v1

    if-ge v0, v2, :cond_0

    .line 642
    aget-object v2, v1, v0

    .line 643
    invoke-virtual {v2, v6}, Landroid/view/View;->setAlpha(F)V

    .line 644
    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41600000    # 14.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    int-to-float v3, v3

    invoke-virtual {v2, v3}, Landroid/view/View;->setTranslationY(F)V

    .line 645
    invoke-virtual {v2}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v7}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v6}, Landroid/view/ViewPropertyAnimator;->translationY(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    mul-int/lit8 v3, v0, 0x46

    add-int/lit16 v3, v3, 0xa0

    int-to-long v4, v3

    invoke-virtual {v2, v4, v5}, Landroid/view/ViewPropertyAnimator;->setStartDelay(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    const-wide/16 v4, 0x17c

    invoke-virtual {v2, v4, v5}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIn:Landroid/view/animation/PathInterpolator;

    invoke-virtual {v2, v3}, Landroid/view/ViewPropertyAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/ViewPropertyAnimator;->start()V

    .line 641
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 647
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mActions:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v6}, Landroid/widget/LinearLayout;->setAlpha(F)V

    .line 648
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mActions:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0, v7}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const-wide/16 v2, 0x1a4

    invoke-virtual {v0, v2, v3}, Landroid/view/ViewPropertyAnimator;->setStartDelay(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const-wide/16 v2, 0x12c

    invoke-virtual {v0, v2, v3}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIn:Landroid/view/animation/PathInterpolator;

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->start()V

    .line 649
    return-void
.end method

.method private fade(Landroid/view/View;)V
    .locals 4

    .prologue
    .line 668
    const v0, 0x3e99999a    # 0.3f

    invoke-virtual {p1, v0}, Landroid/view/View;->setAlpha(F)V

    .line 669
    invoke-virtual {p1}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const-wide/16 v2, 0x0

    invoke-virtual {v0, v2, v3}, Landroid/view/ViewPropertyAnimator;->setStartDelay(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const-wide/16 v2, 0xf0

    invoke-virtual {v0, v2, v3}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIn:Landroid/view/animation/PathInterpolator;

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->start()V

    .line 670
    return-void
.end method

.method private static glyphOf(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 326
    const-string v0, "enable"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "mr_tour_ic_keyboard"

    .line 329
    :goto_0
    return-object v0

    .line 327
    :cond_0
    const-string v0, "select"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "mr_tour_ic_pick"

    goto :goto_0

    .line 328
    :cond_1
    const-string v0, "dict"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "mr_tour_ic_book"

    goto :goto_0

    .line 329
    :cond_2
    const-string v0, "mr_tour_ic_swipe"

    goto :goto_0
.end method

.method private go(I)V
    .locals 4

    .prologue
    .line 589
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mMoving:Z

    if-eqz v0, :cond_0

    .line 613
    :goto_0
    return-void

    .line 590
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mMoving:Z

    .line 591
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->stopPulse()V

    .line 592
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mUnstick:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 593
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mUnstick:Ljava/lang/Runnable;

    const-wide/16 v2, 0x4b0

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 594
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v1, 0x42100000    # 36.0f

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    int-to-float v0, v0

    .line 595
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mBody:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    neg-float v2, v0

    invoke-virtual {v1, v2}, Landroid/view/ViewPropertyAnimator;->translationX(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    const-wide/16 v2, 0xa0

    invoke-virtual {v1, v2, v3}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mOut:Landroid/view/animation/PathInterpolator;

    invoke-virtual {v1, v2}, Landroid/view/ViewPropertyAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrTourActivity$6;

    invoke-direct {v2, p0, p1, v0}, Lcom/mrkeyboard/app/MrTourActivity$6;-><init>(Lcom/mrkeyboard/app/MrTourActivity;IF)V

    invoke-virtual {v1, v2}, Landroid/view/ViewPropertyAnimator;->withEndAction(Ljava/lang/Runnable;)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    .line 612
    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->start()V

    goto :goto_0
.end method

.method private keepPolling()Z
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 163
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->step()Ljava/lang/String;

    move-result-object v1

    .line 164
    sget-boolean v2, Lcom/mrkeyboard/app/MrTour;->sBusy:Z

    if-eqz v2, :cond_1

    sget-object v2, Lcom/mrkeyboard/app/MrTour;->sStep:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 165
    :cond_0
    :goto_0
    return v0

    :cond_1
    invoke-static {v1}, Lcom/mrkeyboard/app/MrTour;->isSetup(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrTour;->ready(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private kick()V
    .locals 2

    .prologue
    .line 169
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 170
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 171
    return-void
.end method

.method private loopPulse(I)V
    .locals 6

    .prologue
    const v4, 0x3fb9999a    # 1.45f

    const/high16 v3, 0x3f800000    # 1.0f

    .line 680
    iget v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPulseGen:I

    if-ne p1, v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mRing:Landroid/view/View;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrTourActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 699
    :cond_0
    :goto_0
    return-void

    .line 681
    :cond_1
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    .line 682
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mRing:Landroid/view/View;

    invoke-virtual {v2, v3}, Landroid/view/View;->setScaleX(F)V

    .line 683
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mRing:Landroid/view/View;

    invoke-virtual {v2, v3}, Landroid/view/View;->setScaleY(F)V

    .line 684
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mRing:Landroid/view/View;

    const v3, 0x3f19999a    # 0.6f

    invoke-virtual {v2, v3}, Landroid/view/View;->setAlpha(F)V

    .line 685
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mRing:Landroid/view/View;

    invoke-virtual {v2}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v4}, Landroid/view/ViewPropertyAnimator;->scaleX(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v4}, Landroid/view/ViewPropertyAnimator;->scaleY(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    const-wide/16 v4, 0x0

    invoke-virtual {v2, v4, v5}, Landroid/view/ViewPropertyAnimator;->setStartDelay(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    const-wide/16 v4, 0x6a4

    invoke-virtual {v2, v4, v5}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIn:Landroid/view/animation/PathInterpolator;

    invoke-virtual {v2, v3}, Landroid/view/ViewPropertyAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    new-instance v3, Lcom/mrkeyboard/app/MrTourActivity$8;

    invoke-direct {v3, p0, p1, v0, v1}, Lcom/mrkeyboard/app/MrTourActivity$8;-><init>(Lcom/mrkeyboard/app/MrTourActivity;IJ)V

    invoke-virtual {v2, v3}, Landroid/view/ViewPropertyAnimator;->withEndAction(Ljava/lang/Runnable;)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    .line 698
    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->start()V

    goto :goto_0
.end method

.method private next()V
    .locals 2

    .prologue
    .line 578
    iget v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    add-int/lit8 v0, v0, 0x1

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lt v0, v1, :cond_0

    .line 579
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrTourActivity;->finish()V

    .line 583
    :goto_0
    return-void

    .line 582
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    add-int/lit8 v0, v0, 0x1

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrTourActivity;->go(I)V

    goto :goto_0
.end method

.method private onPrimary(Ljava/lang/String;I)V
    .locals 1

    .prologue
    .line 541
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mMoving:Z

    if-eqz v0, :cond_0

    .line 554
    :goto_0
    return-void

    .line 542
    :cond_0
    const/4 v0, 0x3

    if-ne p2, v0, :cond_1

    .line 543
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->next()V

    goto :goto_0

    .line 544
    :cond_1
    const-string v0, "enable"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 545
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->openKeyboardSettings()V

    goto :goto_0

    .line 546
    :cond_2
    const-string v0, "select"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 547
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->pickKeyboard()V

    goto :goto_0

    .line 548
    :cond_3
    const/4 v0, 0x4

    if-ne p2, v0, :cond_4

    .line 549
    const-class v0, Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrNav;->intent(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrTourActivity;->startActivity(Landroid/content/Intent;)V

    goto :goto_0

    .line 551
    :cond_4
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrTour;->download(Landroid/content/Context;Ljava/lang/String;)V

    .line 552
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->kick()V

    goto :goto_0
.end method

.method private openKeyboardSettings()V
    .locals 4

    .prologue
    .line 559
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.INPUT_METHOD_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrTourActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 563
    :goto_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->kick()V

    .line 564
    return-void

    .line 560
    :catch_0
    move-exception v0

    .line 561
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_tour_settings_error"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private paintButtons(Ljava/lang/String;IZZ)V
    .locals 10

    .prologue
    const/high16 v1, 0x3f800000    # 1.0f

    const/4 v3, 0x4

    const/4 v9, 0x3

    const/4 v8, 0x1

    const/4 v2, 0x0

    .line 482
    if-ne p2, v8, :cond_1

    .line 483
    sget-boolean v0, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_dicts_state_installing"

    new-array v5, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 493
    :goto_0
    iget-object v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryLabel:Landroid/widget/TextView;

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 494
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryFill:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->cancel()V

    .line 495
    if-ne p2, v8, :cond_9

    .line 496
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimary:Landroid/widget/FrameLayout;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->raised:I

    iget-object v6, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->line:I

    const/high16 v7, 0x41d80000    # 27.0f

    invoke-virtual {v4, v5, v6, v7, v2}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/widget/FrameLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 497
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryLabel:Landroid/widget/TextView;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setTextColor(I)V

    .line 498
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryFill:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    .line 499
    sget-boolean v0, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    if-eqz v0, :cond_8

    move v0, v1

    .line 500
    :goto_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryFill:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/ViewPropertyAnimator;->scaleX(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const-wide/16 v4, 0x17c

    invoke-virtual {v0, v4, v5}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mLinear:Landroid/view/animation/LinearInterpolator;

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->start()V

    .line 501
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimary:Landroid/widget/FrameLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 516
    :goto_2
    if-eqz p3, :cond_a

    .line 517
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSecondary:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 529
    :goto_3
    if-eqz p3, :cond_d

    .line 530
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mNote:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mr_tour_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "_note"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v4, v2, [Ljava/lang/Object;

    invoke-virtual {v1, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 531
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mNote:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 536
    :goto_4
    return-void

    .line 483
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_dicts_state_downloading"

    new-array v5, v8, [Ljava/lang/Object;

    sget v6, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v2

    invoke-virtual {v0, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 484
    :cond_1
    if-ne p2, v9, :cond_3

    .line 485
    iget-object v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    if-eqz p4, :cond_2

    const-string v0, "mr_tour_finish"

    :goto_5
    new-array v5, v2, [Ljava/lang/Object;

    invoke-virtual {v4, v0, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :cond_2
    const-string v0, "mr_tour_continue"

    goto :goto_5

    .line 486
    :cond_3
    const-string v0, "enable"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    const-string v0, "select"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 487
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mr_tour_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "_open"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v5, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 488
    :cond_5
    if-ne p2, v3, :cond_6

    .line 489
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_tour_choose"

    new-array v5, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .line 491
    :cond_6
    iget-object v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v0, 0x2

    if-ne p2, v0, :cond_7

    const-string v0, "mr_tour_retry"

    :goto_6
    new-array v5, v2, [Ljava/lang/Object;

    invoke-virtual {v4, v0, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :cond_7
    const-string v0, "mr_tour_download"

    goto :goto_6

    .line 499
    :cond_8
    const v0, 0x3d4ccccd    # 0.05f

    sget v4, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    int-to-float v4, v4

    const/high16 v5, 0x42c80000    # 100.0f

    div-float/2addr v4, v5

    invoke-static {v1, v4}, Ljava/lang/Math;->min(FF)F

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    goto/16 :goto_1

    .line 503
    :cond_9
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimary:Landroid/widget/FrameLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->accent:I

    const/high16 v5, 0x41d80000    # 27.0f

    invoke-virtual {v1, v4, v2, v5, v2}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 504
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryLabel:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 505
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryFill:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 506
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimaryFill:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setScaleX(F)V

    .line 507
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimary:Landroid/widget/FrameLayout;

    invoke-virtual {v0, v8}, Landroid/widget/FrameLayout;->setClickable(Z)V

    .line 508
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPrimary:Landroid/widget/FrameLayout;

    new-instance v1, Lcom/mrkeyboard/app/MrTourActivity$4;

    invoke-direct {v1, p0, p1, p2}, Lcom/mrkeyboard/app/MrTourActivity$4;-><init>(Lcom/mrkeyboard/app/MrTourActivity;Ljava/lang/String;I)V

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    goto/16 :goto_2

    .line 519
    :cond_a
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSecondary:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mr_tour_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "_off"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v5, v2, [Ljava/lang/Object;

    invoke-virtual {v1, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 520
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSecondary:Landroid/widget/TextView;

    if-eq p2, v8, :cond_b

    if-ne p2, v9, :cond_c

    :cond_b
    move v0, v3

    :goto_7
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    .line 521
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSecondary:Landroid/widget/TextView;

    new-instance v1, Lcom/mrkeyboard/app/MrTourActivity$5;

    invoke-direct {v1, p0, p1}, Lcom/mrkeyboard/app/MrTourActivity$5;-><init>(Lcom/mrkeyboard/app/MrTourActivity;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    goto/16 :goto_3

    :cond_c
    move v0, v2

    .line 520
    goto :goto_7

    .line 533
    :cond_d
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mNote:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_tour_net_note"

    new-array v5, v2, [Ljava/lang/Object;

    invoke-virtual {v1, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 534
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mNote:Landroid/widget/TextView;

    if-ne p2, v9, :cond_e

    :goto_8
    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    goto/16 :goto_4

    :cond_e
    move v3, v2

    goto :goto_8
.end method

.method private pickKeyboard()V
    .locals 4

    .prologue
    .line 569
    :try_start_0
    const-string v0, "input_method"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrTourActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 570
    instance-of v1, v0, Landroid/view/inputmethod/InputMethodManager;

    if-eqz v1, :cond_0

    check-cast v0, Landroid/view/inputmethod/InputMethodManager;

    invoke-virtual {v0}, Landroid/view/inputmethod/InputMethodManager;->showInputMethodPicker()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 574
    :cond_0
    :goto_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->kick()V

    .line 575
    return-void

    .line 571
    :catch_0
    move-exception v0

    .line 572
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_tour_settings_error"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private popIn(Landroid/view/View;J)V
    .locals 4

    .prologue
    const v0, 0x3ecccccd    # 0.4f

    const/high16 v1, 0x3f800000    # 1.0f

    .line 652
    invoke-virtual {p1, v0}, Landroid/view/View;->setScaleX(F)V

    .line 653
    invoke-virtual {p1, v0}, Landroid/view/View;->setScaleY(F)V

    .line 654
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setAlpha(F)V

    .line 655
    invoke-virtual {p1}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->scaleX(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->scaleY(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0, p2, p3}, Landroid/view/ViewPropertyAnimator;->setStartDelay(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const-wide/16 v2, 0x1a4

    invoke-virtual {v0, v2, v3}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    new-instance v1, Landroid/view/animation/OvershootInterpolator;

    const v2, 0x400ccccd    # 2.2f

    invoke-direct {v1, v2}, Landroid/view/animation/OvershootInterpolator;-><init>(F)V

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->start()V

    .line 656
    return-void
.end method

.method private pressable(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 712
    new-instance v0, Lcom/mrkeyboard/app/MrTourActivity$9;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrTourActivity$9;-><init>(Lcom/mrkeyboard/app/MrTourActivity;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 723
    return-void
.end method

.method private signature()Ljava/lang/String;
    .locals 5

    .prologue
    .line 155
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->step()Ljava/lang/String;

    move-result-object v1

    .line 156
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrTourActivity;->stateOf(Ljava/lang/String;)I

    move-result v2

    .line 157
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "|"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "|"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/4 v0, 0x1

    if-ne v2, v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget v4, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, "|"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-boolean v4, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "|"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 158
    const/4 v0, 0x2

    if-ne v2, v0, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrTour;->sError:Ljava/lang/String;

    :goto_1
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "|"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v0, "dict"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-static {p0}, Lcom/mrkeyboard/app/MrTour;->packIdForSystem(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    :goto_2
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 157
    return-object v0

    :cond_0
    const-string v0, ""

    goto :goto_0

    .line 158
    :cond_1
    const-string v0, ""

    goto :goto_1

    :cond_2
    const-string v0, ""

    goto :goto_2
.end method

.method private startPulse()V
    .locals 1

    .prologue
    .line 674
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPulsing:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mRing:Landroid/view/View;

    if-nez v0, :cond_1

    .line 677
    :cond_0
    :goto_0
    return-void

    .line 675
    :cond_1
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPulsing:Z

    .line 676
    iget v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPulseGen:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPulseGen:I

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrTourActivity;->loopPulse(I)V

    goto :goto_0
.end method

.method private stateOf(Ljava/lang/String;)I
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 145
    invoke-static {p1}, Lcom/mrkeyboard/app/MrTour;->isSetup(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    move v2, v0

    .line 146
    :goto_0
    if-eqz v2, :cond_1

    sget-boolean v3, Lcom/mrkeyboard/app/MrTour;->sBusy:Z

    if-eqz v3, :cond_1

    sget-object v3, Lcom/mrkeyboard/app/MrTour;->sStep:Ljava/lang/String;

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 150
    :goto_1
    return v0

    :cond_0
    move v2, v1

    .line 145
    goto :goto_0

    .line 147
    :cond_1
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrTour;->ready(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x3

    goto :goto_1

    .line 148
    :cond_2
    if-eqz v2, :cond_3

    sget-object v0, Lcom/mrkeyboard/app/MrTour;->sErrorStep:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    sget-object v0, Lcom/mrkeyboard/app/MrTour;->sError:Ljava/lang/String;

    if-eqz v0, :cond_3

    const/4 v0, 0x2

    goto :goto_1

    .line 149
    :cond_3
    const-string v0, "dict"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-static {p0}, Lcom/mrkeyboard/app/MrTour;->packIdForSystem(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_4

    const/4 v0, 0x4

    goto :goto_1

    :cond_4
    move v0, v1

    .line 150
    goto :goto_1
.end method

.method private step()Ljava/lang/String;
    .locals 2

    .prologue
    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method private stepColor(Ljava/lang/String;)I
    .locals 1

    .prologue
    .line 319
    const-string v0, "enable"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "mr_ui_cyan"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrTourActivity;->uiColor(Ljava/lang/String;)I

    move-result v0

    .line 322
    :goto_0
    return v0

    .line 320
    :cond_0
    const-string v0, "select"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "mr_ui_violet"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrTourActivity;->uiColor(Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 321
    :cond_1
    const-string v0, "dict"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "mr_ui_mint"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrTourActivity;->uiColor(Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 322
    :cond_2
    const-string v0, "mr_ui_amber"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrTourActivity;->uiColor(Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method private stopPulse()V
    .locals 2

    .prologue
    .line 702
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPulsing:Z

    .line 703
    iget v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPulseGen:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPulseGen:I

    .line 704
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mRing:Landroid/view/View;

    if-eqz v0, :cond_0

    .line 705
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mRing:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->cancel()V

    .line 706
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mRing:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setAlpha(F)V

    .line 708
    :cond_0
    return-void
.end method

.method private static tint(II)I
    .locals 2

    .prologue
    .line 315
    shl-int/lit8 v0, p1, 0x18

    const v1, 0xffffff

    and-int/2addr v1, p0

    or-int/2addr v0, v1

    return v0
.end method

.method private uiColor(Ljava/lang/String;)I
    .locals 4

    .prologue
    .line 311
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

.method private update(Z)V
    .locals 20

    .prologue
    .line 416
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrTourActivity;->mDisc:Landroid/view/View;

    if-eqz v2, :cond_0

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 478
    :cond_0
    :goto_0
    return-void

    .line 417
    :cond_1
    invoke-direct/range {p0 .. p0}, Lcom/mrkeyboard/app/MrTourActivity;->step()Ljava/lang/String;

    move-result-object v9

    .line 418
    move-object/from16 v0, p0

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/MrTourActivity;->stateOf(Ljava/lang/String;)I

    move-result v10

    .line 419
    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrTourActivity;->mState:I

    if-eq v10, v2, :cond_5

    const/4 v2, 0x1

    .line 420
    :goto_1
    move-object/from16 v0, p0

    iget v3, v0, Lcom/mrkeyboard/app/MrTourActivity;->mState:I

    const/4 v4, -0x1

    if-ne v3, v4, :cond_6

    const/4 v3, 0x1

    .line 421
    :goto_2
    move-object/from16 v0, p0

    iput v10, v0, Lcom/mrkeyboard/app/MrTourActivity;->mState:I

    .line 422
    invoke-static {v9}, Lcom/mrkeyboard/app/MrTour;->isSetup(Ljava/lang/String;)Z

    move-result v11

    .line 423
    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    add-int/lit8 v5, v5, -0x1

    if-ne v4, v5, :cond_7

    const/4 v4, 0x1

    .line 424
    :goto_3
    const-string v5, "dict"

    invoke-virtual {v5, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_8

    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/MrTour;->packIdForSystem(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v5

    .line 425
    :goto_4
    const-string v6, "mr_ui_mint"

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrTourActivity;->uiColor(Ljava/lang/String;)I

    move-result v7

    .line 426
    const-string v6, "mr_ui_amber"

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrTourActivity;->uiColor(Ljava/lang/String;)I

    move-result v8

    .line 431
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->text2:I

    .line 432
    const/4 v12, 0x1

    if-ne v10, v12, :cond_9

    .line 433
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v8, "mr_tour_downloading"

    const/4 v12, 0x0

    new-array v12, v12, [Ljava/lang/Object;

    invoke-virtual {v5, v8, v12}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    .line 434
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->accent:I

    move/from16 v19, v6

    move v6, v5

    move/from16 v5, v19

    .line 453
    :goto_5
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/mrkeyboard/app/MrTourActivity;->mChipText:Landroid/widget/TextView;

    invoke-virtual {v12, v8}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 454
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrTourActivity;->mChipText:Landroid/widget/TextView;

    invoke-virtual {v8, v5}, Landroid/widget/TextView;->setTextColor(I)V

    .line 455
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrTourActivity;->mChipDot:Landroid/view/View;

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x1

    invoke-virtual {v8, v6, v12, v13, v14}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 458
    const/4 v5, 0x3

    if-ne v10, v5, :cond_f

    .line 459
    :goto_6
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrTourActivity;->mDisc:Landroid/view/View;

    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/MrTourActivity;->disc(I)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 460
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrTourActivity;->mHalo:Landroid/view/View;

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v8, 0x14

    invoke-static {v7, v8}, Lcom/mrkeyboard/app/MrTourActivity;->tint(II)I

    move-result v8

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x1

    invoke-virtual {v6, v8, v12, v13, v14}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 461
    const/4 v5, 0x3

    if-ne v10, v5, :cond_10

    const-string v5, "mr_tour_ic_check"

    .line 462
    :goto_7
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->mGlyphName:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_2

    .line 463
    move-object/from16 v0, p0

    iput-object v5, v0, Lcom/mrkeyboard/app/MrTourActivity;->mGlyphName:Ljava/lang/String;

    .line 464
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->mGlyph:Landroid/widget/ImageView;

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v12, 0x42500000    # 52.0f

    invoke-virtual {v8, v5, v12}, Lcom/mrkeyboard/app/MrKit;->icon(Ljava/lang/String;F)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    invoke-virtual {v6, v5}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 466
    :cond_2
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrTourActivity;->mGlyph:Landroid/widget/ImageView;

    invoke-virtual {v5, v7}, Landroid/widget/ImageView;->setColorFilter(I)V

    .line 467
    if-eqz p1, :cond_3

    if-eqz v2, :cond_3

    if-nez v3, :cond_3

    .line 468
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrTourActivity;->mChip:Landroid/widget/LinearLayout;

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/MrTourActivity;->fade(Landroid/view/View;)V

    .line 469
    const/4 v2, 0x3

    if-ne v10, v2, :cond_3

    .line 470
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrTourActivity;->mGlyph:Landroid/widget/ImageView;

    const-wide/16 v6, 0x0

    move-object/from16 v0, p0

    invoke-direct {v0, v2, v6, v7}, Lcom/mrkeyboard/app/MrTourActivity;->popIn(Landroid/view/View;J)V

    .line 471
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrTourActivity;->mDisc:Landroid/view/View;

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/MrTourActivity;->bump(Landroid/view/View;)V

    .line 474
    :cond_3
    if-eqz v10, :cond_4

    const/4 v2, 0x1

    if-eq v10, v2, :cond_4

    const/4 v2, 0x4

    if-ne v10, v2, :cond_11

    :cond_4
    invoke-direct/range {p0 .. p0}, Lcom/mrkeyboard/app/MrTourActivity;->startPulse()V

    .line 477
    :goto_8
    move-object/from16 v0, p0

    invoke-direct {v0, v9, v10, v11, v4}, Lcom/mrkeyboard/app/MrTourActivity;->paintButtons(Ljava/lang/String;IZZ)V

    goto/16 :goto_0

    .line 419
    :cond_5
    const/4 v2, 0x0

    goto/16 :goto_1

    .line 420
    :cond_6
    const/4 v3, 0x0

    goto/16 :goto_2

    .line 423
    :cond_7
    const/4 v4, 0x0

    goto/16 :goto_3

    .line 424
    :cond_8
    const/4 v5, 0x0

    goto/16 :goto_4

    .line 435
    :cond_9
    const/4 v12, 0x2

    if-ne v10, v12, :cond_a

    .line 436
    sget-object v8, Lcom/mrkeyboard/app/MrTour;->sError:Ljava/lang/String;

    .line 437
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v5, Lcom/mrkeyboard/app/MrKit;->rose:I

    .line 438
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->rose:I

    goto/16 :goto_5

    .line 439
    :cond_a
    const/4 v12, 0x3

    if-ne v10, v12, :cond_c

    .line 440
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    if-eqz v11, :cond_b

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "mr_tour_"

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v8, "_on"

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    :goto_9
    const/4 v8, 0x0

    new-array v8, v8, [Ljava/lang/Object;

    invoke-virtual {v6, v5, v8}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    move v6, v7

    move-object v8, v5

    move v5, v7

    .line 442
    goto/16 :goto_5

    .line 440
    :cond_b
    const-string v5, "mr_tour_ready"

    goto :goto_9

    .line 443
    :cond_c
    const/4 v12, 0x4

    if-ne v10, v12, :cond_d

    .line 444
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v12, "mr_tour_dict_nopack"

    const/4 v13, 0x0

    new-array v13, v13, [Ljava/lang/Object;

    invoke-virtual {v5, v12, v13}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    move/from16 v19, v6

    move v6, v8

    move-object v8, v5

    move/from16 v5, v19

    .line 445
    goto/16 :goto_5

    .line 446
    :cond_d
    const-string v12, "dict"

    invoke-virtual {v12, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    if-eqz v12, :cond_e

    .line 447
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v13, "mr_tour_dict_missing"

    const/4 v14, 0x1

    new-array v14, v14, [Ljava/lang/Object;

    const/4 v15, 0x0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v16, v0

    const/16 v17, 0x2d

    const/16 v18, 0x5f

    move/from16 v0, v17

    move/from16 v1, v18

    invoke-virtual {v5, v0, v1}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v16

    invoke-virtual {v0, v5}, Lcom/mrkeyboard/app/MrKit;->langName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v14, v15

    invoke-virtual {v12, v13, v14}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    move/from16 v19, v6

    move v6, v8

    move-object v8, v5

    move/from16 v5, v19

    .line 448
    goto/16 :goto_5

    .line 450
    :cond_e
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "mr_tour_"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, "_missing"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    const/4 v13, 0x0

    new-array v13, v13, [Ljava/lang/Object;

    invoke-virtual {v5, v12, v13}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    move/from16 v19, v6

    move v6, v8

    move-object v8, v5

    move/from16 v5, v19

    .line 451
    goto/16 :goto_5

    .line 458
    :cond_f
    move-object/from16 v0, p0

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/MrTourActivity;->stepColor(Ljava/lang/String;)I

    move-result v7

    goto/16 :goto_6

    .line 461
    :cond_10
    invoke-static {v9}, Lcom/mrkeyboard/app/MrTourActivity;->glyphOf(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    goto/16 :goto_7

    .line 475
    :cond_11
    invoke-direct/range {p0 .. p0}, Lcom/mrkeyboard/app/MrTourActivity;->stopPulse()V

    goto/16 :goto_8
.end method

.method private updateBar(Z)V
    .locals 10

    .prologue
    const/4 v9, 0x2

    const/4 v8, 0x1

    const/4 v7, 0x0

    const/4 v0, 0x0

    const/high16 v6, 0x3f800000    # 1.0f

    .line 617
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mCounter:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_tour_step"

    new-array v4, v9, [Ljava/lang/Object;

    iget v5, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    add-int/lit8 v5, v5, 0x1

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v8

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 618
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mCounter:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_tour_step"

    new-array v4, v9, [Ljava/lang/Object;

    iget v5, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    add-int/lit8 v5, v5, 0x1

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v8

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setContentDescription(Ljava/lang/CharSequence;)V

    move v1, v0

    .line 619
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mFills:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_3

    .line 620
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mFills:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    .line 621
    invoke-virtual {v0}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/ViewPropertyAnimator;->cancel()V

    .line 622
    iget v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    if-ge v1, v2, :cond_0

    .line 623
    invoke-virtual {v0, v6}, Landroid/view/View;->setScaleX(F)V

    .line 619
    :goto_1
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 624
    :cond_0
    iget v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    if-ne v1, v2, :cond_2

    .line 625
    if-eqz p1, :cond_1

    .line 626
    invoke-virtual {v0, v7}, Landroid/view/View;->setScaleX(F)V

    .line 627
    invoke-virtual {v0}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0, v6}, Landroid/view/ViewPropertyAnimator;->scaleX(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const-wide/16 v2, 0x1cc

    invoke-virtual {v0, v2, v3}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIn:Landroid/view/animation/PathInterpolator;

    invoke-virtual {v0, v2}, Landroid/view/ViewPropertyAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->start()V

    goto :goto_1

    .line 629
    :cond_1
    invoke-virtual {v0, v6}, Landroid/view/View;->setScaleX(F)V

    goto :goto_1

    .line 632
    :cond_2
    invoke-virtual {v0, v7}, Landroid/view/View;->setScaleX(F)V

    goto :goto_1

    .line 635
    :cond_3
    return-void
.end method


# virtual methods
.method public finish()V
    .locals 0

    .prologue
    .line 304
    invoke-static {p0}, Lcom/mrkeyboard/app/MrTour;->markDone(Landroid/content/Context;)V

    .line 305
    invoke-super {p0}, Landroid/app/Activity;->finish()V

    .line 306
    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0

    .prologue
    .line 259
    invoke-super {p0, p1}, Landroid/app/Activity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 260
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->applySide()V

    .line 261
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 12

    .prologue
    const/high16 v11, 0x40400000    # 3.0f

    const/high16 v10, 0x3f800000    # 1.0f

    const/4 v4, 0x1

    const/4 v9, -0x1

    const/4 v1, 0x0

    .line 177
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 178
    new-instance v0, Lcom/mrkeyboard/app/MrKit;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrKit;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 179
    if-eqz p1, :cond_2

    .line 180
    const-string v0, "mr_tour_steps"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 181
    if-eqz v0, :cond_1

    const-string v2, ","

    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    array-length v3, v2

    move v0, v1

    :goto_0
    if-ge v0, v3, :cond_1

    aget-object v5, v2, v0

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v6

    if-lez v6, :cond_0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v6, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 182
    :cond_1
    const-string v0, "mr_tour_index"

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    .line 184
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-static {p0}, Lcom/mrkeyboard/app/MrTour;->steps(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    .line 185
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 186
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrTourActivity;->finish()V

    .line 244
    :cond_4
    :goto_1
    return-void

    .line 189
    :cond_5
    iget v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    if-ltz v0, :cond_6

    iget v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lt v0, v2, :cond_7

    :cond_6
    iput v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    .line 191
    :cond_7
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v5

    .line 192
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->bg:I

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v1, v3, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {v5, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 194
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mTop:Landroid/widget/LinearLayout;

    .line 195
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, ""

    const/high16 v3, 0x41500000    # 13.0f

    iget-object v6, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v0, v2, v3, v6, v4}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mCounter:Landroid/widget/TextView;

    .line 196
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mTop:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mCounter:Landroid/widget/TextView;

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x2

    invoke-direct {v3, v1, v6, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 197
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_tour_skip"

    new-array v6, v1, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/high16 v3, 0x41700000    # 15.0f

    iget-object v6, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {v0, v2, v3, v6, v4}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 198
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41600000    # 14.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41400000    # 12.0f

    invoke-virtual {v3, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v6, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x40000000    # 2.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    iget-object v7, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v8, 0x41400000    # 12.0f

    invoke-virtual {v7, v8}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v7

    invoke-virtual {v0, v2, v3, v6, v7}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 199
    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setClickable(Z)V

    .line 200
    new-instance v2, Lcom/mrkeyboard/app/MrTourActivity$3;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrTourActivity$3;-><init>(Lcom/mrkeyboard/app/MrTourActivity;)V

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 205
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrTourActivity;->pressable(Landroid/view/View;)V

    .line 206
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mTop:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 207
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mTop:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v1}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v5, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 209
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mBarBox:Landroid/widget/LinearLayout;

    move v0, v1

    .line 210
    :goto_2
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v0, v2, :cond_a

    .line 211
    new-instance v6, Landroid/widget/FrameLayout;

    invoke-direct {v6, p0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    .line 212
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->stroke:I

    invoke-virtual {v2, v3, v1, v11, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v2

    invoke-virtual {v6, v2}, Landroid/widget/FrameLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 213
    new-instance v2, Landroid/view/View;

    invoke-direct {v2, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 214
    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v7, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {v3, v7, v1, v11, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 215
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/view/View;->setPivotX(F)V

    .line 216
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/view/View;->setScaleX(F)V

    .line 217
    new-instance v3, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v3, v9, v9}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v6, v2, v3}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 218
    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mFills:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 219
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x40a00000    # 5.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-direct {v7, v1, v2, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 220
    if-nez v0, :cond_8

    move v2, v1

    :goto_3
    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSteps:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    add-int/lit8 v3, v3, -0x1

    if-ne v0, v3, :cond_9

    move v3, v1

    :goto_4
    invoke-virtual {v7, v2, v1, v3, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 221
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mBarBox:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v6, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 210
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 220
    :cond_8
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    goto :goto_3

    :cond_9
    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    goto :goto_4

    .line 223
    :cond_a
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mBarBox:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v3, 0x4

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v5, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 226
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mBody:Landroid/widget/LinearLayout;

    .line 227
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 228
    invoke-virtual {v0, v4}, Landroid/widget/ScrollView;->setFillViewport(Z)V

    .line 229
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mStage:Landroid/widget/LinearLayout;

    .line 230
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mStage:Landroid/widget/LinearLayout;

    const/16 v3, 0x11

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 231
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mStage:Landroid/widget/LinearLayout;

    new-instance v3, Landroid/view/ViewGroup$LayoutParams;

    const/4 v6, -0x2

    invoke-direct {v3, v9, v6}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v2, v3}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 232
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mBody:Landroid/widget/LinearLayout;

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v9, v1, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 233
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mActions:Landroid/widget/LinearLayout;

    .line 234
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mBody:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTourActivity;->mActions:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTourActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v1}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 235
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mBody:Landroid/widget/LinearLayout;

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v9, v1, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v5, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 236
    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrTourActivity;->setContentView(Landroid/view/View;)V

    .line 237
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->applySide()V

    .line 239
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->buildBody()V

    .line 240
    if-nez p1, :cond_b

    move v0, v4

    :goto_5
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrTourActivity;->updateBar(Z)V

    .line 241
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrTourActivity;->update(Z)V

    .line 242
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->signature()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSig:Ljava/lang/String;

    .line 243
    if-nez p1, :cond_4

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->enter()V

    goto/16 :goto_1

    :cond_b
    move v0, v1

    .line 240
    goto :goto_5
.end method

.method protected onDestroy()V
    .locals 2

    .prologue
    .line 295
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 296
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mUnstick:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 297
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->stopPulse()V

    .line 298
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 299
    return-void
.end method

.method protected onPause()V
    .locals 2

    .prologue
    .line 288
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 289
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->stopPulse()V

    .line 290
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 291
    return-void
.end method

.method protected onResume()V
    .locals 1

    .prologue
    .line 274
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 275
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mBody:Landroid/widget/LinearLayout;

    if-nez v0, :cond_0

    .line 278
    :goto_0
    return-void

    .line 276
    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mSig:Ljava/lang/String;

    .line 277
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->kick()V

    goto :goto_0
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 4

    .prologue
    .line 265
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 266
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 267
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

    .line 268
    :cond_0
    const-string v0, "mr_tour_steps"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 269
    const-string v0, "mr_tour_index"

    iget v1, p0, Lcom/mrkeyboard/app/MrTourActivity;->mIndex:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 270
    return-void
.end method

.method public onWindowFocusChanged(Z)V
    .locals 1

    .prologue
    .line 282
    invoke-super {p0, p1}, Landroid/app/Activity;->onWindowFocusChanged(Z)V

    .line 283
    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity;->mBody:Landroid/widget/LinearLayout;

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrTourActivity;->kick()V

    .line 284
    :cond_0
    return-void
.end method
