.class final Lcom/mrkeyboard/app/MrAppPicker;
.super Ljava/lang/Object;
.source "MrAppPicker.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrAppPicker$Pick;,
        Lcom/mrkeyboard/app/MrAppPicker$Source;,
        Lcom/mrkeyboard/app/MrAppPicker$Once;,
        Lcom/mrkeyboard/app/MrAppPicker$Sink;
    }
.end annotation


# static fields
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

.field private volatile mClosed:Z

.field private mCount:I

.field private final mCurrent:Ljava/lang/String;

.field private mDialog:Landroid/app/AlertDialog;

.field private volatile mDrawn:I

.field private final mEmpty:Ljava/lang/String;

.field private mLimit:I

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

.field private mScroll:Lcom/mrkeyboard/app/MrPage;

.field private mSearch:Landroid/widget/EditText;

.field private mStatus:Landroid/widget/TextView;


# direct methods
.method private constructor <init>(Lcom/mrkeyboard/app/MrKit;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/MrAppPicker$Pick;)V
    .locals 1

    .prologue
    .line 80
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 73
    const/16 v0, 0x1e

    iput v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mLimit:I

    .line 81
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    .line 82
    iget-object v0, p1, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    .line 83
    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppPicker;->mCurrent:Ljava/lang/String;

    .line 84
    iput-object p3, p0, Lcom/mrkeyboard/app/MrAppPicker;->mEmpty:Ljava/lang/String;

    .line 85
    iput-object p4, p0, Lcom/mrkeyboard/app/MrAppPicker;->mPick:Lcom/mrkeyboard/app/MrAppPicker$Pick;

    .line 86
    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrAppPicker;->loaded(Ljava/util/List;)V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrAppPicker;)Landroid/app/Activity;
    .locals 1

    .prologue
    .line 31
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/MrAppPicker;)Landroid/widget/LinearLayout;
    .locals 1

    .prologue
    .line 31
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;II)V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrAppPicker;->append(Ljava/util/List;II)V

    return-void
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/MrAppPicker;)I
    .locals 1

    .prologue
    .line 31
    iget v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDrawn:I

    return v0
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrAppPicker;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrAppPicker;->choose(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/MrAppPicker;)Ljava/util/List;
    .locals 1

    .prologue
    .line 31
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$302(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)Ljava/util/List;
    .locals 0

    .prologue
    .line 31
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    return-object p1
.end method

.method static synthetic access$402(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)Ljava/util/List;
    .locals 0

    .prologue
    .line 31
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mMatches:Ljava/util/List;

    return-object p1
.end method

.method static synthetic access$502(Lcom/mrkeyboard/app/MrAppPicker;I)I
    .locals 0

    .prologue
    .line 31
    iput p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mLimit:I

    return p1
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/MrAppPicker;)V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAppPicker;->draw()V

    return-void
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/MrAppPicker;)V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAppPicker;->checkMore()V

    return-void
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/MrAppPicker;)Z
    .locals 1

    .prologue
    .line 31
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAppPicker;->addPage()Z

    move-result v0

    return v0
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/MrAppPicker;)Z
    .locals 1

    .prologue
    .line 31
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mClosed:Z

    return v0
.end method

.method static synthetic access$902(Lcom/mrkeyboard/app/MrAppPicker;Z)Z
    .locals 0

    .prologue
    .line 31
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mClosed:Z

    return p1
.end method

.method private addPage()Z
    .locals 5

    .prologue
    .line 253
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mMatches:Ljava/util/List;

    .line 254
    iget-boolean v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mClosed:Z

    if-nez v1, :cond_0

    if-eqz v0, :cond_0

    iget v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mCount:I

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-lt v1, v2, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 264
    :goto_0
    return v0

    .line 255
    :cond_1
    iget v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mLimit:I

    add-int/lit8 v1, v1, 0x1e

    iput v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mLimit:I

    .line 256
    iget v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mCount:I

    .line 257
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    iget v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->mLimit:I

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 259
    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Lcom/mrkeyboard/app/MrPage;

    new-instance v4, Lcom/mrkeyboard/app/MrAppPicker$8;

    invoke-direct {v4, p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrAppPicker$8;-><init>(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;II)V

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrPage;->keepPosition(Ljava/lang/Runnable;)V

    .line 264
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private append(Ljava/util/List;II)V
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
    .line 227
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 228
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 229
    :goto_0
    if-ge p2, p3, :cond_1

    .line 230
    invoke-interface {p1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Entry;

    .line 231
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

    .line 232
    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 229
    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 231
    :cond_0
    const/4 v1, 0x6

    goto :goto_1

    .line 234
    :cond_1
    iput p3, p0, Lcom/mrkeyboard/app/MrAppPicker;->mCount:I

    .line 235
    invoke-virtual {v2}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/MrAppPicker;->loadIcons(Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    .line 237
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mCount:I

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    if-ge v0, v1, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Lcom/mrkeyboard/app/MrPage;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrPage;->getHeight()I

    move-result v0

    if-lez v0, :cond_3

    .line 238
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Lcom/mrkeyboard/app/MrPage;

    new-instance v1, Lcom/mrkeyboard/app/MrAppPicker$7;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrAppPicker$7;-><init>(Lcom/mrkeyboard/app/MrAppPicker;)V

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrPage;->post(Ljava/lang/Runnable;)Z

    .line 244
    :cond_3
    return-void
.end method

.method private checkMore()V
    .locals 3

    .prologue
    .line 248
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Lcom/mrkeyboard/app/MrPage;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->nearEnd(Landroid/widget/ScrollView;Landroid/view/ViewGroup;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAppPicker;->addPage()Z

    .line 249
    :cond_0
    return-void
.end method

.method private choose(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 206
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDialog:Landroid/app/AlertDialog;

    .line 207
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    .line 208
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mPick:Lcom/mrkeyboard/app/MrAppPicker$Pick;

    invoke-interface {v0, p1}, Lcom/mrkeyboard/app/MrAppPicker$Pick;->onPick(Ljava/lang/String;)V

    .line 209
    return-void
.end method

.method private draw()V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 213
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->mMatches:Ljava/util/List;

    .line 214
    iget v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDrawn:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDrawn:I

    .line 215
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Lcom/mrkeyboard/app/MrPage;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrPage;->release()V

    .line 216
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 217
    iput v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mCount:I

    .line 218
    if-nez v2, :cond_0

    .line 223
    :goto_0
    return-void

    .line 220
    :cond_0
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v0

    iget v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->mLimit:I

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-direct {p0, v2, v1, v0}, Lcom/mrkeyboard/app/MrAppPicker;->append(Ljava/util/List;II)V

    .line 221
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

    .line 222
    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->mStatus:Landroid/widget/TextView;

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    move v0, v1

    :goto_2
    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0

    .line 221
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

    .line 222
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
    .line 295
    iget v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDrawn:I

    .line 296
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrAppPicker$10;

    invoke-direct {v2, p0, p1, v0, p2}, Lcom/mrkeyboard/app/MrAppPicker$10;-><init>(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/ArrayList;ILjava/util/ArrayList;)V

    const-string v0, "MrAppIcons"

    invoke-direct {v1, v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 311
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Ljava/lang/Thread;->setPriority(I)V

    .line 312
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    .line 313
    return-void
.end method

.method private loaded(Ljava/util/List;)V
    .locals 3
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
    const/16 v1, 0x8

    .line 197
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mClosed:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 203
    :cond_0
    :goto_0
    return-void

    .line 198
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrAppCache;->same(Ljava/util/List;Ljava/util/List;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 199
    :cond_2
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    .line 200
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    if-nez v0, :cond_3

    const-string v0, ""

    :goto_1
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrAppList;->filter(Ljava/util/List;Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mMatches:Ljava/util/List;

    .line 201
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-le v0, v1, :cond_4

    const/4 v0, 0x0

    :goto_2
    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setVisibility(I)V

    .line 202
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAppPicker;->draw()V

    goto :goto_0

    .line 200
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_4
    move v0, v1

    .line 201
    goto :goto_2
.end method

.method private open(Ljava/lang/String;)V
    .locals 10

    .prologue
    const/high16 v4, 0x41a00000    # 20.0f

    const/high16 v9, 0x41400000    # 12.0f

    const/16 v8, 0x8

    const/high16 v6, 0x40800000    # 4.0f

    const/4 v7, 0x0

    .line 127
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 128
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

    .line 129
    new-instance v2, Lcom/mrkeyboard/app/MrPage;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    invoke-direct {v2, v0}, Lcom/mrkeyboard/app/MrPage;-><init>(Landroid/content/Context;)V

    .line 130
    iput-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->mScroll:Lcom/mrkeyboard/app/MrPage;

    .line 131
    new-instance v0, Landroid/view/ViewGroup$LayoutParams;

    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-direct {v0, v3, v4}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v1, v0}, Lcom/mrkeyboard/app/MrPage;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 134
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
    new-instance v5, Lcom/mrkeyboard/app/MrAppPicker$2;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrAppPicker$2;-><init>(Lcom/mrkeyboard/app/MrAppPicker;)V

    invoke-virtual {v3, v4, v0, v5}, Lcom/mrkeyboard/app/MrKit;->item(Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    .line 138
    invoke-virtual {v3, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 134
    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 139
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

    .line 141
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

    .line 142
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    const/4 v3, 0x1

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setSingleLine(Z)V

    .line 143
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    invoke-virtual {v0, v8}, Landroid/widget/EditText;->setVisibility(I)V

    .line 144
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    new-instance v3, Lcom/mrkeyboard/app/MrAppPicker$3;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrAppPicker$3;-><init>(Lcom/mrkeyboard/app/MrAppPicker;)V

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 158
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 159
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

    .line 160
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

    .line 161
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mStatus:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 162
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    .line 163
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 165
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    new-instance v1, Lcom/mrkeyboard/app/MrAppPicker$4;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrAppPicker$4;-><init>(Lcom/mrkeyboard/app/MrAppPicker;)V

    invoke-virtual {v0, v2, v1}, Lcom/mrkeyboard/app/MrKit;->onScroll(Landroid/widget/ScrollView;Ljava/lang/Runnable;)V

    .line 171
    new-instance v0, Lcom/mrkeyboard/app/MrAppPicker$5;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrAppPicker$5;-><init>(Lcom/mrkeyboard/app/MrAppPicker;)V

    invoke-virtual {v2, v0}, Lcom/mrkeyboard/app/MrPage;->setPager(Lcom/mrkeyboard/app/MrPage$Pager;)V

    .line 177
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 178
    invoke-virtual {v0, p1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 179
    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_cancel"

    new-array v3, v7, [Ljava/lang/Object;

    .line 180
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 181
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    .line 182
    new-instance v1, Lcom/mrkeyboard/app/MrAppPicker$6;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrAppPicker$6;-><init>(Lcom/mrkeyboard/app/MrAppPicker;)V

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    .line 191
    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDialog:Landroid/app/AlertDialog;

    .line 192
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 193
    return-void

    .line 134
    :cond_0
    const-string v0, ""

    goto/16 :goto_0
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

    .line 268
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 269
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

    .line 270
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->card:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->stroke:I

    invoke-virtual {v0, v2, v3, v7, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 271
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 272
    new-instance v0, Lcom/mrkeyboard/app/MrAppPicker$9;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrAppPicker$9;-><init>(Lcom/mrkeyboard/app/MrAppPicker;Lcom/mrkeyboard/app/MrAppList$Entry;)V

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 277
    new-instance v0, Landroid/widget/ImageView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    invoke-direct {v0, v2}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 278
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-direct {v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 279
    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41400000    # 12.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v2, v5, v5, v3, v5}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 280
    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 281
    invoke-virtual {p2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 282
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p1, Lcom/mrkeyboard/app/MrAppList$Entry;->label:Ljava/lang/String;

    const/high16 v3, 0x41800000    # 16.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v0, v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 283
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-direct {v2, v5, v8, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 284
    iget-object v0, p1, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->mCurrent:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "\u2713"

    .line 285
    :goto_0
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_0

    .line 286
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41500000    # 13.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v0, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 287
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {v0, v2, v5, v5, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 288
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v8, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 290
    :cond_0
    return-object v1

    .line 284
    :cond_1
    iget-object v0, p1, Lcom/mrkeyboard/app/MrAppList$Entry;->note:Ljava/lang/String;

    goto :goto_0
.end method

.method static show(Lcom/mrkeyboard/app/MrKit;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/MrAppPicker$Source;Lcom/mrkeyboard/app/MrAppPicker$Pick;)Lcom/mrkeyboard/app/MrAppPicker;
    .locals 4

    .prologue
    .line 93
    new-instance v0, Lcom/mrkeyboard/app/MrAppPicker;

    invoke-direct {v0, p0, p1, p3, p5}, Lcom/mrkeyboard/app/MrAppPicker;-><init>(Lcom/mrkeyboard/app/MrKit;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/MrAppPicker$Pick;)V

    .line 94
    invoke-direct {v0, p2}, Lcom/mrkeyboard/app/MrAppPicker;->open(Ljava/lang/String;)V

    .line 95
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrAppPicker$1;

    invoke-direct {v2, v0, p4}, Lcom/mrkeyboard/app/MrAppPicker$1;-><init>(Lcom/mrkeyboard/app/MrAppPicker;Lcom/mrkeyboard/app/MrAppPicker$Source;)V

    const-string v3, "MrAppList"

    invoke-direct {v1, v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 117
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/Thread;->setPriority(I)V

    .line 118
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    .line 119
    return-object v0
.end method


# virtual methods
.method dialog()Landroid/app/AlertDialog;
    .locals 1

    .prologue
    .line 123
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDialog:Landroid/app/AlertDialog;

    return-object v0
.end method
