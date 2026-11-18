.class final Lcom/mrkeyboard/app/MrAppPicker;
.super Ljava/lang/Object;
.source "MrAppPicker.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrAppPicker$Pick;,
        Lcom/mrkeyboard/app/MrAppPicker$Source;,
        Lcom/mrkeyboard/app/MrAppPicker$Live;
    }
.end annotation


# static fields
.field static final END_DP:I = 0x48

.field static final PAGE:I = 0x1e

.field static final SEARCH_FROM:I = 0x8


# instance fields
.field private final act:Landroid/app/Activity;

.field private final k:Lcom/mrkeyboard/app/MrKit;

.field private mAll:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;"
        }
    .end annotation
.end field

.field private final mCheck:Ljava/lang/Runnable;

.field private volatile mClosed:Z

.field private final mCurrent:Ljava/lang/String;

.field private mDialog:Landroid/app/AlertDialog;

.field private volatile mDrawn:I

.field private final mEmpty:Ljava/lang/String;

.field private mListBox:Landroid/widget/LinearLayout;

.field private mMatches:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;"
        }
    .end annotation
.end field

.field private final mPick:Lcom/mrkeyboard/app/MrAppPicker$Pick;

.field private mQuery:Ljava/lang/String;

.field private mScroll:Landroid/widget/ScrollView;

.field private mSearch:Landroid/widget/EditText;

.field private mStatus:Landroid/widget/TextView;


# direct methods
.method private constructor <init>(Lcom/mrkeyboard/app/MrKit;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/MrAppPicker$Pick;)V
    .locals 1

    .prologue
    .line 77
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 65
    const-string v0, ""

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mQuery:Ljava/lang/String;

    .line 68
    new-instance v0, Lcom/mrkeyboard/app/MrAppPicker$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrAppPicker$1;-><init>(Lcom/mrkeyboard/app/MrAppPicker;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mCheck:Ljava/lang/Runnable;

    .line 78
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    .line 79
    iget-object v0, p1, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    .line 80
    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppPicker;->mCurrent:Ljava/lang/String;

    .line 81
    iput-object p3, p0, Lcom/mrkeyboard/app/MrAppPicker;->mEmpty:Ljava/lang/String;

    .line 82
    iput-object p4, p0, Lcom/mrkeyboard/app/MrAppPicker;->mPick:Lcom/mrkeyboard/app/MrAppPicker$Pick;

    .line 83
    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrAppPicker;)V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAppPicker;->nearEnd()V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrAppPicker;->post(Ljava/util/List;)V

    return-void
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/MrAppPicker;)Landroid/widget/ScrollView;
    .locals 1

    .prologue
    .line 30
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Landroid/widget/ScrollView;

    return-object v0
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/MrAppPicker;)I
    .locals 1

    .prologue
    .line 30
    iget v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDrawn:I

    return v0
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/MrAppPicker;)Landroid/app/Activity;
    .locals 1

    .prologue
    .line 30
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrAppPicker;->arrived(Ljava/util/List;)V

    return-void
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/MrAppPicker;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrAppPicker;->choose(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/MrAppPicker;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 30
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mQuery:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$402(Lcom/mrkeyboard/app/MrAppPicker;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 30
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mQuery:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/MrAppPicker;)Ljava/util/List;
    .locals 1

    .prologue
    .line 30
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$502(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)Ljava/util/List;
    .locals 0

    .prologue
    .line 30
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    return-object p1
.end method

.method static synthetic access$602(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)Ljava/util/List;
    .locals 0

    .prologue
    .line 30
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mMatches:Ljava/util/List;

    return-object p1
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/MrAppPicker;I)V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrAppPicker;->draw(I)V

    return-void
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/MrAppPicker;)Z
    .locals 1

    .prologue
    .line 30
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mClosed:Z

    return v0
.end method

.method static synthetic access$802(Lcom/mrkeyboard/app/MrAppPicker;Z)Z
    .locals 0

    .prologue
    .line 30
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mClosed:Z

    return p1
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/MrAppPicker;)Landroid/widget/LinearLayout;
    .locals 1

    .prologue
    .line 30
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method private addRows(Ljava/util/List;II)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;II)V"
        }
    .end annotation

    .prologue
    .line 261
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 262
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 263
    :goto_0
    if-ge p2, p3, :cond_1

    .line 264
    invoke-interface {p1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Entry;

    .line 265
    iget-object v4, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    invoke-direct {p0, v0, v3}, Lcom/mrkeyboard/app/MrAppPicker;->row(Lcom/mrkeyboard/app/MrAppList$Entry;Ljava/util/ArrayList;)Landroid/view/View;

    move-result-object v5

    iget-object v6, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    if-nez p2, :cond_0

    const/4 v1, 0x0

    :goto_1
    invoke-virtual {v6, v1}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v4, v5, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 266
    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 263
    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 265
    :cond_0
    const/4 v1, 0x6

    goto :goto_1

    .line 268
    :cond_1
    invoke-virtual {v2}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/MrAppPicker;->loadIcons(Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    .line 269
    :cond_2
    return-void
.end method

.method private arrived(Ljava/util/List;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;)V"
        }
    .end annotation

    .prologue
    const/16 v5, 0x1e

    const/16 v1, 0x8

    const/4 v0, 0x0

    .line 215
    iget-boolean v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->mClosed:Z

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->isFinishing()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 233
    :cond_0
    :goto_0
    return-void

    .line 216
    :cond_1
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    if-nez v2, :cond_3

    const/4 v2, 0x1

    .line 217
    :goto_1
    if-nez v2, :cond_2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    invoke-static {v3, p1}, Lcom/mrkeyboard/app/MrAppPicker;->same(Ljava/util/List;Ljava/util/List;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 218
    :cond_2
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    .line 219
    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->mQuery:Ljava/lang/String;

    invoke-static {p1, v3}, Lcom/mrkeyboard/app/MrAppList;->filter(Ljava/util/List;Ljava/lang/String;)Ljava/util/List;

    move-result-object v3

    iput-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->mMatches:Ljava/util/List;

    .line 220
    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v4

    if-le v4, v1, :cond_4

    :goto_2
    invoke-virtual {v3, v0}, Landroid/widget/EditText;->setVisibility(I)V

    .line 221
    if-eqz v2, :cond_5

    .line 222
    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/MrAppPicker;->draw(I)V

    goto :goto_0

    :cond_3
    move v2, v0

    .line 216
    goto :goto_1

    :cond_4
    move v0, v1

    .line 220
    goto :goto_2

    .line 225
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v0

    invoke-static {v5, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 226
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v1}, Landroid/widget/ScrollView;->getScrollY()I

    move-result v1

    .line 227
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrAppPicker;->draw(I)V

    .line 228
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Landroid/widget/ScrollView;

    new-instance v2, Lcom/mrkeyboard/app/MrAppPicker$9;

    invoke-direct {v2, p0, v1}, Lcom/mrkeyboard/app/MrAppPicker$9;-><init>(Lcom/mrkeyboard/app/MrAppPicker;I)V

    invoke-virtual {v0, v2}, Landroid/widget/ScrollView;->post(Ljava/lang/Runnable;)Z

    goto :goto_0
.end method

.method private choose(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 244
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDialog:Landroid/app/AlertDialog;

    .line 245
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    .line 246
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mPick:Lcom/mrkeyboard/app/MrAppPicker$Pick;

    invoke-interface {v0, p1}, Lcom/mrkeyboard/app/MrAppPicker$Pick;->onPick(Ljava/lang/String;)V

    .line 247
    return-void
.end method

.method private draw(I)V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 250
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->mMatches:Ljava/util/List;

    .line 251
    iget v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDrawn:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDrawn:I

    .line 252
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 253
    if-nez v2, :cond_0

    .line 258
    :goto_0
    return-void

    .line 254
    :cond_0
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v0

    invoke-static {v0, p1}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-direct {p0, v2, v1, v0}, Lcom/mrkeyboard/app/MrAppPicker;->addRows(Ljava/util/List;II)V

    .line 255
    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->mStatus:Landroid/widget/TextView;

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mEmpty:Ljava/lang/String;

    :goto_1
    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 256
    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->mStatus:Landroid/widget/TextView;

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    move v0, v1

    :goto_2
    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setVisibility(I)V

    .line 257
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Landroid/widget/ScrollView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mCheck:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    .line 255
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_app_none"

    new-array v5, v1, [Ljava/lang/Object;

    invoke-virtual {v0, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_2
    const-string v0, ""

    goto :goto_1

    .line 256
    :cond_3
    const/16 v0, 0x8

    goto :goto_2
.end method

.method private loadIcons(Ljava/util/ArrayList;Ljava/util/ArrayList;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/widget/ImageView;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 311
    iget v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDrawn:I

    .line 312
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrAppPicker$11;

    invoke-direct {v2, p0, p1, v0, p2}, Lcom/mrkeyboard/app/MrAppPicker$11;-><init>(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/ArrayList;ILjava/util/ArrayList;)V

    const-string v0, "MrAppIcons"

    invoke-direct {v1, v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 327
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Ljava/lang/Thread;->setPriority(I)V

    .line 328
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    .line 329
    return-void
.end method

.method private nearEnd()V
    .locals 5

    .prologue
    .line 272
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mMatches:Ljava/util/List;

    .line 273
    iget-boolean v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mClosed:Z

    if-nez v1, :cond_0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Landroid/widget/ScrollView;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v1}, Landroid/widget/ScrollView;->getHeight()I

    move-result v1

    if-gtz v1, :cond_1

    .line 281
    :cond_0
    :goto_0
    return-void

    .line 274
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v1

    .line 275
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_0

    .line 276
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Landroid/widget/ScrollView;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/ScrollView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    .line 277
    if-eqz v2, :cond_0

    .line 278
    invoke-virtual {v2}, Landroid/view/View;->getBottom()I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v3}, Landroid/widget/ScrollView;->getScrollY()I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v4}, Landroid/widget/ScrollView;->getHeight()I

    move-result v4

    add-int/2addr v3, v4

    sub-int/2addr v2, v3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x42900000    # 72.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    if-gt v2, v3, :cond_0

    .line 279
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    add-int/lit8 v3, v1, 0x1e

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    invoke-direct {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrAppPicker;->addRows(Ljava/util/List;II)V

    .line 280
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Landroid/widget/ScrollView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mCheck:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->post(Ljava/lang/Runnable;)Z

    goto :goto_0
.end method

.method private open(Ljava/lang/String;)V
    .locals 10

    .prologue
    const/high16 v4, 0x41a00000    # 20.0f

    const/high16 v9, 0x41400000    # 12.0f

    const/16 v8, 0x8

    const/high16 v6, 0x40800000    # 4.0f

    const/4 v7, 0x0

    .line 153
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 154
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41000000    # 8.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v1, v0, v2, v3, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 155
    new-instance v2, Landroid/widget/ScrollView;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    invoke-direct {v2, v0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 156
    new-instance v0, Landroid/view/ViewGroup$LayoutParams;

    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-direct {v0, v3, v4}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v1, v0}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 159
    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_app_all"

    new-array v5, v7, [Ljava/lang/Object;

    invoke-virtual {v0, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mCurrent:Ljava/lang/String;

    if-nez v0, :cond_0

    const-string v0, "\u2713"

    :goto_0
    new-instance v5, Lcom/mrkeyboard/app/MrAppPicker$5;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrAppPicker$5;-><init>(Lcom/mrkeyboard/app/MrAppPicker;)V

    invoke-virtual {v3, v4, v0, v5}, Lcom/mrkeyboard/app/MrKit;->item(Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    .line 163
    invoke-virtual {v3, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 159
    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 164
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_app_only"

    new-array v5, v7, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/high16 v4, 0x41500000    # 13.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v0, v3, v4, v5, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x10

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 166
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_app_search"

    new-array v5, v7, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const v4, 0x80001

    invoke-virtual {v0, v3, v4}, Lcom/mrkeyboard/app/MrKit;->field(Ljava/lang/String;I)Landroid/widget/EditText;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    .line 167
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    const/4 v3, 0x1

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setSingleLine(Z)V

    .line 168
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    invoke-virtual {v0, v8}, Landroid/widget/EditText;->setVisibility(I)V

    .line 169
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    new-instance v3, Lcom/mrkeyboard/app/MrAppPicker$6;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrAppPicker$6;-><init>(Lcom/mrkeyboard/app/MrAppPicker;)V

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 183
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 184
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_app_loading"

    new-array v5, v7, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/high16 v4, 0x41600000    # 14.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v0, v3, v4, v5, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mStatus:Landroid/widget/TextView;

    .line 185
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mStatus:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    iget-object v6, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-virtual {v0, v3, v4, v5, v6}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 186
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mStatus:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 187
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    .line 188
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 189
    iput-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Landroid/widget/ScrollView;

    .line 190
    new-instance v0, Lcom/mrkeyboard/app/MrAppPicker$7;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrAppPicker$7;-><init>(Lcom/mrkeyboard/app/MrAppPicker;)V

    invoke-virtual {v2, v0}, Landroid/widget/ScrollView;->setOnScrollChangeListener(Landroid/view/View$OnScrollChangeListener;)V

    .line 196
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 197
    invoke-virtual {v0, p1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 198
    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_cancel"

    new-array v3, v7, [Ljava/lang/Object;

    .line 199
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 200
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    .line 201
    new-instance v1, Lcom/mrkeyboard/app/MrAppPicker$8;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrAppPicker$8;-><init>(Lcom/mrkeyboard/app/MrAppPicker;)V

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    .line 210
    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDialog:Landroid/app/AlertDialog;

    .line 211
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 212
    return-void

    .line 159
    :cond_0
    const-string v0, ""

    goto/16 :goto_0
.end method

.method private post(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    new-instance v1, Lcom/mrkeyboard/app/MrAppPicker$4;

    invoke-direct {v1, p0, p1}, Lcom/mrkeyboard/app/MrAppPicker$4;-><init>(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 146
    return-void
.end method

.method private row(Lcom/mrkeyboard/app/MrAppList$Entry;Ljava/util/ArrayList;)Landroid/view/View;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/widget/ImageView;",
            ">;)",
            "Landroid/view/View;"
        }
    .end annotation

    .prologue
    const/high16 v9, 0x42100000    # 36.0f

    const/4 v8, -0x2

    const/high16 v7, 0x41600000    # 14.0f

    const/high16 v6, 0x41200000    # 10.0f

    const/4 v5, 0x0

    .line 284
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 285
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v1, v0, v2, v3, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 286
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->card:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->stroke:I

    invoke-virtual {v0, v2, v3, v7, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 287
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 288
    new-instance v0, Lcom/mrkeyboard/app/MrAppPicker$10;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrAppPicker$10;-><init>(Lcom/mrkeyboard/app/MrAppPicker;Lcom/mrkeyboard/app/MrAppList$Entry;)V

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 293
    new-instance v0, Landroid/widget/ImageView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    invoke-direct {v0, v2}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 294
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-direct {v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 295
    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41400000    # 12.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v2, v5, v5, v3, v5}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 296
    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 297
    invoke-virtual {p2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 298
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p1, Lcom/mrkeyboard/app/MrAppList$Entry;->label:Ljava/lang/String;

    const/high16 v3, 0x41800000    # 16.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v0, v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 299
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-direct {v2, v5, v8, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 300
    iget-object v0, p1, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->mCurrent:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "\u2713"

    .line 301
    :goto_0
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_0

    .line 302
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41500000    # 13.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v0, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 303
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {v0, v2, v5, v5, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 304
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v8, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 306
    :cond_0
    return-object v1

    .line 300
    :cond_1
    iget-object v0, p1, Lcom/mrkeyboard/app/MrAppList$Entry;->note:Ljava/lang/String;

    goto :goto_0
.end method

.method private static same(Ljava/util/List;Ljava/util/List;)Z
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;)Z"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 236
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 240
    :cond_0
    :goto_0
    return v2

    :cond_1
    move v1, v2

    .line 237
    :goto_1
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_2

    .line 238
    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Entry;

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Entry;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Entry;

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAppList$Entry;->label:Ljava/lang/String;

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Entry;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAppList$Entry;->label:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 237
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 240
    :cond_2
    const/4 v2, 0x1

    goto :goto_0
.end method

.method static show(Lcom/mrkeyboard/app/MrKit;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/MrAppPicker$Live;Lcom/mrkeyboard/app/MrAppPicker$Pick;)Lcom/mrkeyboard/app/MrAppPicker;
    .locals 4

    .prologue
    .line 106
    new-instance v0, Lcom/mrkeyboard/app/MrAppPicker;

    invoke-direct {v0, p0, p1, p3, p5}, Lcom/mrkeyboard/app/MrAppPicker;-><init>(Lcom/mrkeyboard/app/MrKit;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/MrAppPicker$Pick;)V

    .line 107
    invoke-direct {v0, p2}, Lcom/mrkeyboard/app/MrAppPicker;->open(Ljava/lang/String;)V

    .line 108
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrAppPicker$3;

    invoke-direct {v2, p4, v0}, Lcom/mrkeyboard/app/MrAppPicker$3;-><init>(Lcom/mrkeyboard/app/MrAppPicker$Live;Lcom/mrkeyboard/app/MrAppPicker;)V

    const-string v3, "MrAppList"

    invoke-direct {v1, v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 135
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/Thread;->setPriority(I)V

    .line 136
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    .line 137
    return-object v0
.end method

.method static show(Lcom/mrkeyboard/app/MrKit;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/MrAppPicker$Source;Lcom/mrkeyboard/app/MrAppPicker$Pick;)Lcom/mrkeyboard/app/MrAppPicker;
    .locals 6

    .prologue
    .line 90
    new-instance v4, Lcom/mrkeyboard/app/MrAppPicker$2;

    invoke-direct {v4, p4}, Lcom/mrkeyboard/app/MrAppPicker$2;-><init>(Lcom/mrkeyboard/app/MrAppPicker$Source;)V

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v5, p5

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrAppPicker;->show(Lcom/mrkeyboard/app/MrKit;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/MrAppPicker$Live;Lcom/mrkeyboard/app/MrAppPicker$Pick;)Lcom/mrkeyboard/app/MrAppPicker;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method dialog()Landroid/app/AlertDialog;
    .locals 1

    .prologue
    .line 149
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDialog:Landroid/app/AlertDialog;

    return-object v0
.end method
