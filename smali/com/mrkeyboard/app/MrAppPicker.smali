.class final Lcom/mrkeyboard/app/MrAppPicker;
.super Ljava/lang/Object;
.source "MrAppPicker.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrAppPicker$Pick;,
        Lcom/mrkeyboard/app/MrAppPicker$Source;
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

.field private mMore:Landroid/widget/TextView;

.field private final mPick:Lcom/mrkeyboard/app/MrAppPicker$Pick;

.field private mSearch:Landroid/widget/EditText;

.field private mStatus:Landroid/widget/TextView;


# direct methods
.method private constructor <init>(Lcom/mrkeyboard/app/MrKit;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/MrAppPicker$Pick;)V
    .locals 1

    .prologue
    .line 63
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 58
    const/16 v0, 0x1e

    iput v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mLimit:I

    .line 64
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    .line 65
    iget-object v0, p1, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    .line 66
    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppPicker;->mCurrent:Ljava/lang/String;

    .line 67
    iput-object p3, p0, Lcom/mrkeyboard/app/MrAppPicker;->mEmpty:Ljava/lang/String;

    .line 68
    iput-object p4, p0, Lcom/mrkeyboard/app/MrAppPicker;->mPick:Lcom/mrkeyboard/app/MrAppPicker$Pick;

    .line 69
    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrAppPicker;->loaded(Ljava/util/List;)V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrAppPicker;)Landroid/app/Activity;
    .locals 1

    .prologue
    .line 30
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrAppPicker;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrAppPicker;->choose(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/MrAppPicker;)Ljava/util/List;
    .locals 1

    .prologue
    .line 30
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$302(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)Ljava/util/List;
    .locals 0

    .prologue
    .line 30
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    return-object p1
.end method

.method static synthetic access$402(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)Ljava/util/List;
    .locals 0

    .prologue
    .line 30
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mMatches:Ljava/util/List;

    return-object p1
.end method

.method static synthetic access$502(Lcom/mrkeyboard/app/MrAppPicker;I)I
    .locals 0

    .prologue
    .line 30
    iput p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mLimit:I

    return p1
.end method

.method static synthetic access$512(Lcom/mrkeyboard/app/MrAppPicker;I)I
    .locals 1

    .prologue
    .line 30
    iget v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mLimit:I

    add-int/2addr v0, p1

    iput v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mLimit:I

    return v0
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/MrAppPicker;)V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAppPicker;->draw()V

    return-void
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/MrAppPicker;)Z
    .locals 1

    .prologue
    .line 30
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mClosed:Z

    return v0
.end method

.method static synthetic access$702(Lcom/mrkeyboard/app/MrAppPicker;Z)Z
    .locals 0

    .prologue
    .line 30
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mClosed:Z

    return p1
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/MrAppPicker;)Landroid/widget/LinearLayout;
    .locals 1

    .prologue
    .line 30
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/MrAppPicker;)I
    .locals 1

    .prologue
    .line 30
    iget v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDrawn:I

    return v0
.end method

.method private choose(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 177
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDialog:Landroid/app/AlertDialog;

    .line 178
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    .line 179
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mPick:Lcom/mrkeyboard/app/MrAppPicker$Pick;

    invoke-interface {v0, p1}, Lcom/mrkeyboard/app/MrAppPicker$Pick;->onPick(Ljava/lang/String;)V

    .line 180
    return-void
.end method

.method private draw()V
    .locals 12

    .prologue
    const/16 v3, 0x8

    const/4 v2, 0x0

    .line 184
    iget-object v5, p0, Lcom/mrkeyboard/app/MrAppPicker;->mMatches:Ljava/util/List;

    .line 185
    iget v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDrawn:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDrawn:I

    .line 186
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 187
    if-nez v5, :cond_1

    .line 200
    :cond_0
    :goto_0
    return-void

    .line 188
    :cond_1
    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v0

    iget v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mLimit:I

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v6

    .line 189
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    .line 190
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    move v4, v2

    .line 191
    :goto_1
    if-ge v4, v6, :cond_3

    .line 192
    invoke-interface {v5, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Entry;

    .line 193
    iget-object v9, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    invoke-direct {p0, v0, v8}, Lcom/mrkeyboard/app/MrAppPicker;->row(Lcom/mrkeyboard/app/MrAppList$Entry;Ljava/util/ArrayList;)Landroid/view/View;

    move-result-object v10

    iget-object v11, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    if-nez v4, :cond_2

    move v1, v2

    :goto_2
    invoke-virtual {v11, v1}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v9, v10, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 194
    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 191
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_1

    .line 193
    :cond_2
    const/4 v1, 0x6

    goto :goto_2

    .line 196
    :cond_3
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mMore:Landroid/widget/TextView;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v0

    if-ge v6, v0, :cond_4

    move v0, v2

    :goto_3
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    .line 197
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mStatus:Landroid/widget/TextView;

    invoke-interface {v5}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mEmpty:Ljava/lang/String;

    :goto_4
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 198
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mStatus:Landroid/widget/TextView;

    invoke-interface {v5}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_7

    :goto_5
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 199
    invoke-virtual {v7}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-direct {p0, v7, v8}, Lcom/mrkeyboard/app/MrAppPicker;->loadIcons(Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    goto :goto_0

    :cond_4
    move v0, v3

    .line 196
    goto :goto_3

    .line 197
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_app_none"

    new-array v6, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v4, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_4

    :cond_6
    const-string v0, ""

    goto :goto_4

    :cond_7
    move v2, v3

    .line 198
    goto :goto_5
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
    .line 230
    iget v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDrawn:I

    .line 231
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrAppPicker$7;

    invoke-direct {v2, p0, p1, v0, p2}, Lcom/mrkeyboard/app/MrAppPicker$7;-><init>(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/ArrayList;ILjava/util/ArrayList;)V

    const-string v0, "MrAppIcons"

    invoke-direct {v1, v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 246
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Ljava/lang/Thread;->setPriority(I)V

    .line 247
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    .line 248
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
    const/16 v0, 0x8

    .line 169
    iget-boolean v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mClosed:Z

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->isFinishing()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 174
    :cond_0
    :goto_0
    return-void

    .line 170
    :cond_1
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mAll:Ljava/util/List;

    .line 171
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mMatches:Ljava/util/List;

    .line 172
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    if-le v2, v0, :cond_2

    const/4 v0, 0x0

    :cond_2
    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setVisibility(I)V

    .line 173
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAppPicker;->draw()V

    goto :goto_0
.end method

.method private open(Ljava/lang/String;)V
    .locals 10

    .prologue
    const/high16 v4, 0x41a00000    # 20.0f

    const/high16 v9, 0x41400000    # 12.0f

    const/high16 v6, 0x40800000    # 4.0f

    const/16 v8, 0x8

    const/4 v7, 0x0

    .line 104
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 105
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

    .line 106
    new-instance v2, Landroid/widget/ScrollView;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    invoke-direct {v2, v0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 107
    new-instance v0, Landroid/view/ViewGroup$LayoutParams;

    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-direct {v0, v3, v4}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v1, v0}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 110
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

    .line 114
    invoke-virtual {v3, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 110
    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 115
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

    .line 117
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

    .line 118
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    const/4 v3, 0x1

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setSingleLine(Z)V

    .line 119
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    invoke-virtual {v0, v8}, Landroid/widget/EditText;->setVisibility(I)V

    .line 120
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    new-instance v3, Lcom/mrkeyboard/app/MrAppPicker$3;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrAppPicker$3;-><init>(Lcom/mrkeyboard/app/MrAppPicker;)V

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 134
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mSearch:Landroid/widget/EditText;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 135
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

    .line 136
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

    .line 137
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mStatus:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 138
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    .line 139
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mListBox:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 140
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_learned_more"

    new-array v5, v7, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrAppPicker$4;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrAppPicker$4;-><init>(Lcom/mrkeyboard/app/MrAppPicker;)V

    invoke-virtual {v0, v3, v7, v4}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mMore:Landroid/widget/TextView;

    .line 146
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mMore:Landroid/widget/TextView;

    invoke-virtual {v0, v8}, Landroid/widget/TextView;->setVisibility(I)V

    .line 147
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mMore:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 149
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 150
    invoke-virtual {v0, p1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 151
    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_words_cancel"

    new-array v3, v7, [Ljava/lang/Object;

    .line 152
    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 153
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    .line 154
    new-instance v1, Lcom/mrkeyboard/app/MrAppPicker$5;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrAppPicker$5;-><init>(Lcom/mrkeyboard/app/MrAppPicker;)V

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    .line 163
    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDialog:Landroid/app/AlertDialog;

    .line 164
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 165
    return-void

    .line 110
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

    .line 203
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 204
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

    .line 205
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->card:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->stroke:I

    invoke-virtual {v0, v2, v3, v7, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 206
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 207
    new-instance v0, Lcom/mrkeyboard/app/MrAppPicker$6;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrAppPicker$6;-><init>(Lcom/mrkeyboard/app/MrAppPicker;Lcom/mrkeyboard/app/MrAppList$Entry;)V

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 212
    new-instance v0, Landroid/widget/ImageView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->act:Landroid/app/Activity;

    invoke-direct {v0, v2}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 213
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-direct {v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 214
    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41400000    # 12.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v2, v5, v5, v3, v5}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 215
    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 216
    invoke-virtual {p2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 217
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p1, Lcom/mrkeyboard/app/MrAppList$Entry;->label:Ljava/lang/String;

    const/high16 v3, 0x41800000    # 16.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v0, v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 218
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-direct {v2, v5, v8, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 219
    iget-object v0, p1, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->mCurrent:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "\u2713"

    .line 220
    :goto_0
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_0

    .line 221
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41500000    # 13.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v0, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 222
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {v0, v2, v5, v5, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 223
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v8, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 225
    :cond_0
    return-object v1

    .line 219
    :cond_1
    iget-object v0, p1, Lcom/mrkeyboard/app/MrAppList$Entry;->note:Ljava/lang/String;

    goto :goto_0
.end method

.method static show(Lcom/mrkeyboard/app/MrKit;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/MrAppPicker$Source;Lcom/mrkeyboard/app/MrAppPicker$Pick;)Lcom/mrkeyboard/app/MrAppPicker;
    .locals 4

    .prologue
    .line 76
    new-instance v0, Lcom/mrkeyboard/app/MrAppPicker;

    invoke-direct {v0, p0, p1, p3, p5}, Lcom/mrkeyboard/app/MrAppPicker;-><init>(Lcom/mrkeyboard/app/MrKit;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/MrAppPicker$Pick;)V

    .line 77
    invoke-direct {v0, p2}, Lcom/mrkeyboard/app/MrAppPicker;->open(Ljava/lang/String;)V

    .line 78
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrAppPicker$1;

    invoke-direct {v2, p4, v0}, Lcom/mrkeyboard/app/MrAppPicker$1;-><init>(Lcom/mrkeyboard/app/MrAppPicker$Source;Lcom/mrkeyboard/app/MrAppPicker;)V

    const-string v3, "MrAppList"

    invoke-direct {v1, v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 94
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/Thread;->setPriority(I)V

    .line 95
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    .line 96
    return-object v0
.end method


# virtual methods
.method dialog()Landroid/app/AlertDialog;
    .locals 1

    .prologue
    .line 100
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker;->mDialog:Landroid/app/AlertDialog;

    return-object v0
.end method
