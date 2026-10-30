.class public Lcom/mrkeyboard/app/CandidateView;
.super Landroid/view/View;
.source "CandidateView.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;
    }
.end annotation


# static fields
.field private static final MAX_SUGGESTIONS:I = 0x20

.field private static final OUT_OF_BOUNDS_WORD_INDEX:I = -0x1

.field private static final OUT_OF_BOUNDS_X_COORD:I = -0x1

.field private static final SCROLL_PIXELS:I = 0x14

.field private static final X_GAP:I = 0xa


# instance fields
.field private mAddToDictionaryHint:Ljava/lang/CharSequence;

.field private mBgPadding:Landroid/graphics/Rect;

.field private mColorNormal:I

.field private mColorOther:I

.field private mColorRecommended:I

.field private mCurrentWordIndex:I

.field private final mDescent:I

.field private mDivider:Landroid/graphics/drawable/Drawable;

# Espaco minimo entre o texto de cada sugestao e o divisor, em pixels, de cada lado (10dp, calculado
# no construtor). Substitui o X_GAP fixo de 10px. Textos maiores que a posicao encolhem/cortam.
.field private mGap:I

# Layout fixo de 3 posicoes (mrLayout): indice da lista em cada posicao (esquerda, centro, direita;
# -1 = vazia), indice da mais provavel (cor cheia) e se a dica "salvar" ocupa as posicoes 1 e 2.
.field private mSlot:[I

.field private mCenter:I

.field private mMerged:Z

# Altura da faixa e linha de base do texto, calculadas a cada onDraw.
.field private mH:I

.field private mY:I

.field private final mGestureDetector:Landroid/view/GestureDetector;

.field private mHaveMinimalSuggestion:Z

.field private final mMinTouchableWidth:I

.field private final mPaint:Landroid/graphics/Paint;

.field private mPopupPreviewX:I

.field private mPopupPreviewY:I

.field private final mPreviewPopup:Landroid/widget/PopupWindow;

.field private final mPreviewText:Landroid/widget/TextView;

.field private mScrolled:Z

.field private mSelectedIndex:I

.field private mSelectedString:Ljava/lang/CharSequence;

.field private mSelectionHighlight:Landroid/graphics/drawable/Drawable;

.field private mService:Lcom/mrkeyboard/app/LatinIME;

.field private mShowingAddToDictionary:Z

.field private mShowingCompletions:Z

.field private final mSuggestions:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/CharSequence;",
            ">;"
        }
    .end annotation
.end field

.field private mTargetScrollX:I

.field private mTotalWidth:I

.field private mTouchX:I

.field private mTypedWordValid:Z

.field private final mWordWidth:[I

.field private final mWordX:[I


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 3

    .line 98
    invoke-direct {p0, p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 48
    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    iput-object p2, p0, Lcom/mrkeyboard/app/CandidateView;->mSuggestions:Ljava/util/ArrayList;

    const/4 p2, -0x1

    .line 52
    iput p2, p0, Lcom/mrkeyboard/app/CandidateView;->mTouchX:I

    const/16 p2, 0x20

    .line 68
    new-array v0, p2, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mWordWidth:[I

    .line 69
    new-array p2, p2, [I

    iput-object p2, p0, Lcom/mrkeyboard/app/CandidateView;->mWordX:[I

    .line 99
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    const v0, 0x7f0700a1

    invoke-virtual {p2, v0}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p2

    iput-object p2, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectionHighlight:Landroid/graphics/drawable/Drawable;

    const-string p2, "layout_inflater"

    .line 104
    invoke-virtual {p1, p2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Landroid/view/LayoutInflater;

    .line 105
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 106
    new-instance v1, Landroid/widget/PopupWindow;

    invoke-direct {v1, p1}, Landroid/widget/PopupWindow;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewPopup:Landroid/widget/PopupWindow;

    const/4 p1, 0x0

    const v1, 0x7f0a001c

    .line 107
    invoke-virtual {p2, v1, p1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewText:Landroid/widget/TextView;

    .line 108
    iget-object p2, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewPopup:Landroid/widget/PopupWindow;

    const/4 v1, -0x2

    invoke-virtual {p2, v1, v1}, Landroid/widget/PopupWindow;->setWindowLayoutMode(II)V

    .line 109
    iget-object p2, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewPopup:Landroid/widget/PopupWindow;

    iget-object v1, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewText:Landroid/widget/TextView;

    invoke-virtual {p2, v1}, Landroid/widget/PopupWindow;->setContentView(Landroid/view/View;)V

    .line 110
    iget-object p2, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewPopup:Landroid/widget/PopupWindow;

    invoke-virtual {p2, p1}, Landroid/widget/PopupWindow;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 111
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewPopup:Landroid/widget/PopupWindow;

    const p2, 0x7f0d009e

    invoke-virtual {p1, p2}, Landroid/widget/PopupWindow;->setAnimationStyle(I)V

    .line 113
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 p2, 0x1

    const/4 v1, 0x0

    const/16 v2, 0x1c

    if-lt p1, v2, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    .line 114
    :goto_0
    iget-object v2, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewPopup:Landroid/widget/PopupWindow;

    invoke-virtual {v2, p1}, Landroid/widget/PopupWindow;->setClippingEnabled(Z)V

    const p1, 0x7f050026

    .line 115
    invoke-virtual {v0, p1}, Landroid/content/res/Resources;->getColor(I)I

    move-result p1

    iput p1, p0, Lcom/mrkeyboard/app/CandidateView;->mColorNormal:I

    const p1, 0x7f050028

    .line 116
    invoke-virtual {v0, p1}, Landroid/content/res/Resources;->getColor(I)I

    move-result p1

    iput p1, p0, Lcom/mrkeyboard/app/CandidateView;->mColorRecommended:I

    const p1, 0x7f050027

    .line 117
    invoke-virtual {v0, p1}, Landroid/content/res/Resources;->getColor(I)I

    move-result p1

    iput p1, p0, Lcom/mrkeyboard/app/CandidateView;->mColorOther:I

    const p1, 0x7f0700a0

    .line 118
    invoke-virtual {v0, p1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    iput-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mDivider:Landroid/graphics/drawable/Drawable;

    const p1, 0x7f0c0067

    .line 119
    invoke-virtual {v0, p1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mAddToDictionaryHint:Ljava/lang/CharSequence;

    .line 121
    new-instance p1, Landroid/graphics/Paint;

    invoke-direct {p1}, Landroid/graphics/Paint;-><init>()V

    iput-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mPaint:Landroid/graphics/Paint;

    .line 122
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mPaint:Landroid/graphics/Paint;

    iget v2, p0, Lcom/mrkeyboard/app/CandidateView;->mColorNormal:I

    invoke-virtual {p1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 123
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    .line 124
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mPaint:Landroid/graphics/Paint;

    iget-object p2, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewText:Landroid/widget/TextView;

    invoke-virtual {p2}, Landroid/widget/TextView;->getTextSize()F

    move-result p2

    sget-object v2, Lcom/mrkeyboard/app/LatinIME;->sKeyboardSettings:Lcom/mrkeyboard/app/GlobalKeyboardSettings;

    iget v2, v2, Lcom/mrkeyboard/app/GlobalKeyboardSettings;->candidateScalePref:F

    mul-float p2, p2, v2

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 125
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mPaint:Landroid/graphics/Paint;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 126
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mPaint:Landroid/graphics/Paint;

    sget-object p2, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 127
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1}, Landroid/graphics/Paint;->descent()F

    move-result p1

    float-to-int p1, p1

    iput p1, p0, Lcom/mrkeyboard/app/CandidateView;->mDescent:I

    const p1, 0x7f06004c

    .line 128
    invoke-virtual {v0, p1}, Landroid/content/res/Resources;->getDimension(I)F

    move-result p1

    float-to-int p1, p1

    iput p1, p0, Lcom/mrkeyboard/app/CandidateView;->mMinTouchableWidth:I

    # mGap = 10dp em pixels (v0 ainda e o Resources aqui)
    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p1

    iget p1, p1, Landroid/util/DisplayMetrics;->density:F

    const/high16 p2, 0x41200000    # 10.0f

    mul-float/2addr p1, p2

    const/high16 p2, 0x3f000000    # 0.5f

    add-float/2addr p1, p2

    float-to-int p1, p1

    iput p1, p0, Lcom/mrkeyboard/app/CandidateView;->mGap:I

    .line 130
    new-instance p1, Landroid/view/GestureDetector;

    new-instance p2, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;

    iget v0, p0, Lcom/mrkeyboard/app/CandidateView;->mMinTouchableWidth:I

    invoke-direct {p2, p0, v0}, Lcom/mrkeyboard/app/CandidateView$CandidateStripGestureListener;-><init>(Lcom/mrkeyboard/app/CandidateView;I)V

    invoke-direct {p1, p2}, Landroid/view/GestureDetector;-><init>(Landroid/view/GestureDetector$OnGestureListener;)V

    iput-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mGestureDetector:Landroid/view/GestureDetector;

    .line 132
    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/CandidateView;->setWillNotDraw(Z)V

    .line 133
    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/CandidateView;->setHorizontalScrollBarEnabled(Z)V

    .line 134
    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/CandidateView;->setVerticalScrollBarEnabled(Z)V

    .line 135
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->getScrollY()I

    move-result p1

    invoke-virtual {p0, v1, p1}, Lcom/mrkeyboard/app/CandidateView;->scrollTo(II)V

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/CandidateView;)Ljava/util/ArrayList;
    .locals 0

    .line 42
    iget-object p0, p0, Lcom/mrkeyboard/app/CandidateView;->mSuggestions:Ljava/util/ArrayList;

    return-object p0
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/CandidateView;)[I
    .locals 0

    .line 42
    iget-object p0, p0, Lcom/mrkeyboard/app/CandidateView;->mWordWidth:[I

    return-object p0
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/CandidateView;)V
    .locals 0

    .line 42
    invoke-direct {p0}, Lcom/mrkeyboard/app/CandidateView;->longPressFirstWord()V

    return-void
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/CandidateView;)Z
    .locals 0

    .line 42
    iget-boolean p0, p0, Lcom/mrkeyboard/app/CandidateView;->mScrolled:Z

    return p0
.end method

.method static synthetic access$302(Lcom/mrkeyboard/app/CandidateView;Z)Z
    .locals 0

    .line 42
    iput-boolean p1, p0, Lcom/mrkeyboard/app/CandidateView;->mScrolled:Z

    return p1
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/CandidateView;)I
    .locals 0

    .line 42
    iget p0, p0, Lcom/mrkeyboard/app/CandidateView;->mTotalWidth:I

    return p0
.end method

.method static synthetic access$502(Lcom/mrkeyboard/app/CandidateView;I)I
    .locals 0

    .line 42
    iput p1, p0, Lcom/mrkeyboard/app/CandidateView;->mTargetScrollX:I

    return p1
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/CandidateView;)V
    .locals 0

    .line 42
    invoke-direct {p0}, Lcom/mrkeyboard/app/CandidateView;->hidePreview()V

    return-void
.end method

.method private hidePreview()V
    .locals 1

    const/4 v0, -0x1

    .line 438
    iput v0, p0, Lcom/mrkeyboard/app/CandidateView;->mTouchX:I

    .line 439
    iput v0, p0, Lcom/mrkeyboard/app/CandidateView;->mCurrentWordIndex:I

    .line 440
    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewPopup:Landroid/widget/PopupWindow;

    invoke-virtual {v0}, Landroid/widget/PopupWindow;->dismiss()V

    return-void
.end method

.method private longPressFirstWord()V
    .locals 5

    .line 480
    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mSuggestions:Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    .line 481
    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    const/4 v3, 0x2

    if-ge v2, v3, :cond_0

    return-void

    .line 482
    :cond_0
    iget-object v2, p0, Lcom/mrkeyboard/app/CandidateView;->mService:Lcom/mrkeyboard/app/LatinIME;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/LatinIME;->addWordToDictionary(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 483
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const v3, 0x7f0c001d

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    aput-object v0, v4, v1

    invoke-virtual {v2, v3, v4}, Landroid/content/res/Resources;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v1, v0}, Lcom/mrkeyboard/app/CandidateView;->showPreview(ILjava/lang/String;)V

    :cond_1
    return-void
.end method

.method private scrollToTarget()V
    .locals 2

    .line 298
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->getScrollX()I

    move-result v0

    .line 299
    iget v1, p0, Lcom/mrkeyboard/app/CandidateView;->mTargetScrollX:I

    if-le v1, v0, :cond_1

    add-int/lit8 v0, v0, 0x14

    .line 301
    iget v1, p0, Lcom/mrkeyboard/app/CandidateView;->mTargetScrollX:I

    if-lt v0, v1, :cond_0

    .line 302
    iget v0, p0, Lcom/mrkeyboard/app/CandidateView;->mTargetScrollX:I

    .line 303
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->getScrollY()I

    move-result v1

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/CandidateView;->scrollTo(II)V

    .line 304
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->requestLayout()V

    goto :goto_0

    .line 306
    :cond_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->getScrollY()I

    move-result v1

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/CandidateView;->scrollTo(II)V

    goto :goto_0

    :cond_1
    add-int/lit8 v0, v0, -0x14

    .line 310
    iget v1, p0, Lcom/mrkeyboard/app/CandidateView;->mTargetScrollX:I

    if-gt v0, v1, :cond_2

    .line 311
    iget v0, p0, Lcom/mrkeyboard/app/CandidateView;->mTargetScrollX:I

    .line 312
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->getScrollY()I

    move-result v1

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/CandidateView;->scrollTo(II)V

    .line 313
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->requestLayout()V

    goto :goto_0

    .line 315
    :cond_2
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->getScrollY()I

    move-result v1

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/CandidateView;->scrollTo(II)V

    .line 318
    :goto_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->invalidate()V

    return-void
.end method

.method private showPreview(ILjava/lang/String;)V
    .locals 6

    .line 444
    iget v0, p0, Lcom/mrkeyboard/app/CandidateView;->mCurrentWordIndex:I

    .line 445
    iput p1, p0, Lcom/mrkeyboard/app/CandidateView;->mCurrentWordIndex:I

    .line 447
    iget v1, p0, Lcom/mrkeyboard/app/CandidateView;->mCurrentWordIndex:I

    if-ne v0, v1, :cond_0

    if-eqz p2, :cond_4

    :cond_0
    const/4 v0, -0x1

    if-ne p1, v0, :cond_1

    .line 449
    invoke-direct {p0}, Lcom/mrkeyboard/app/CandidateView;->hidePreview()V

    goto/16 :goto_2

    :cond_1
    if-eqz p2, :cond_2

    goto :goto_0

    .line 451
    :cond_2
    iget-object p2, p0, Lcom/mrkeyboard/app/CandidateView;->mSuggestions:Ljava/util/ArrayList;

    invoke-virtual {p2, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/CharSequence;

    .line 452
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewText:Landroid/widget/TextView;

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 453
    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewText:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-static {v1, v1}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v2

    .line 454
    invoke-static {v1, v1}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v3

    .line 453
    invoke-virtual {v0, v2, v3}, Landroid/widget/TextView;->measure(II)V

    .line 455
    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mPaint:Landroid/graphics/Paint;

    invoke-interface {p2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    invoke-virtual {v0, p2, v1, v2}, Landroid/graphics/Paint;->measureText(Ljava/lang/CharSequence;II)F

    move-result p2

    const/high16 v0, 0x41a00000    # 20.0f

    add-float/2addr p2, v0

    float-to-int p2, p2

    .line 456
    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewText:Landroid/widget/TextView;

    .line 457
    invoke-virtual {v0}, Landroid/widget/TextView;->getPaddingLeft()I

    move-result v0

    add-int/2addr v0, p2

    iget-object v2, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewText:Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getPaddingRight()I

    move-result v2

    add-int/2addr v0, v2

    .line 458
    iget-object v2, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewText:Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getMeasuredHeight()I

    move-result v2

    .line 460
    iget-object v3, p0, Lcom/mrkeyboard/app/CandidateView;->mWordX:[I

    aget v3, v3, p1

    iget-object v4, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewText:Landroid/widget/TextView;

    invoke-virtual {v4}, Landroid/widget/TextView;->getPaddingLeft()I

    move-result v4

    sub-int/2addr v3, v4

    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->getScrollX()I

    move-result v4

    sub-int/2addr v3, v4

    iget-object v4, p0, Lcom/mrkeyboard/app/CandidateView;->mWordWidth:[I

    aget p1, v4, p1

    sub-int/2addr p1, p2

    const/4 p2, 0x2

    div-int/2addr p1, p2

    add-int/2addr v3, p1

    iput v3, p0, Lcom/mrkeyboard/app/CandidateView;->mPopupPreviewX:I

    neg-int p1, v2

    .line 462
    iput p1, p0, Lcom/mrkeyboard/app/CandidateView;->mPopupPreviewY:I

    .line 463
    new-array p1, p2, [I

    .line 464
    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/CandidateView;->getLocationInWindow([I)V

    .line 465
    iget-object p2, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewPopup:Landroid/widget/PopupWindow;

    invoke-virtual {p2}, Landroid/widget/PopupWindow;->isShowing()Z

    move-result p2

    const/4 v3, 0x1

    if-eqz p2, :cond_3

    .line 466
    iget-object p2, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewPopup:Landroid/widget/PopupWindow;

    iget v4, p0, Lcom/mrkeyboard/app/CandidateView;->mPopupPreviewX:I

    iget v5, p0, Lcom/mrkeyboard/app/CandidateView;->mPopupPreviewY:I

    aget p1, p1, v3

    add-int/2addr v5, p1

    invoke-virtual {p2, v4, v5, v0, v2}, Landroid/widget/PopupWindow;->update(IIII)V

    goto :goto_1

    .line 469
    :cond_3
    iget-object p2, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewPopup:Landroid/widget/PopupWindow;

    invoke-virtual {p2, v0}, Landroid/widget/PopupWindow;->setWidth(I)V

    .line 470
    iget-object p2, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewPopup:Landroid/widget/PopupWindow;

    invoke-virtual {p2, v2}, Landroid/widget/PopupWindow;->setHeight(I)V

    .line 471
    iget-object p2, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewPopup:Landroid/widget/PopupWindow;

    iget v0, p0, Lcom/mrkeyboard/app/CandidateView;->mPopupPreviewX:I

    iget v2, p0, Lcom/mrkeyboard/app/CandidateView;->mPopupPreviewY:I

    aget p1, p1, v3

    add-int/2addr v2, p1

    invoke-virtual {p2, p0, v1, v0, v2}, Landroid/widget/PopupWindow;->showAtLocation(Landroid/view/View;III)V

    .line 474
    :goto_1
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mPreviewText:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_4
    :goto_2
    return-void
.end method


# virtual methods
.method public clear()V
    .locals 2

    .line 368
    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mSuggestions:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    const/4 v0, -0x1

    .line 369
    iput v0, p0, Lcom/mrkeyboard/app/CandidateView;->mTouchX:I

    const/4 v1, 0x0

    .line 370
    iput-object v1, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectedString:Ljava/lang/CharSequence;

    .line 371
    iput v0, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectedIndex:I

    const/4 v0, 0x0

    .line 372
    iput-boolean v0, p0, Lcom/mrkeyboard/app/CandidateView;->mShowingAddToDictionary:Z

    .line 373
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->invalidate()V

    .line 374
    iget-object v1, p0, Lcom/mrkeyboard/app/CandidateView;->mWordWidth:[I

    invoke-static {v1, v0}, Ljava/util/Arrays;->fill([II)V

    .line 375
    iget-object v1, p0, Lcom/mrkeyboard/app/CandidateView;->mWordX:[I

    invoke-static {v1, v0}, Ljava/util/Arrays;->fill([II)V

    return-void
.end method

.method public computeHorizontalScrollRange()I
    .locals 1

    .line 203
    iget v0, p0, Lcom/mrkeyboard/app/CandidateView;->mTotalWidth:I

    return v0
.end method

.method public dismissAddToDictionaryHint()Z
    .locals 1

    .line 356
    iget-boolean v0, p0, Lcom/mrkeyboard/app/CandidateView;->mShowingAddToDictionary:Z

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    .line 357
    :cond_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->clear()V

    const/4 v0, 0x1

    return v0
.end method

.method getSuggestions()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/CharSequence;",
            ">;"
        }
    .end annotation

    .line 362
    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mSuggestions:Ljava/util/ArrayList;

    return-object v0
.end method

.method public isShowingAddToDictionaryHint()Z
    .locals 1

    .line 344
    iget-boolean v0, p0, Lcom/mrkeyboard/app/CandidateView;->mShowingAddToDictionary:Z

    return v0
.end method

.method public onDetachedFromWindow()V
    .locals 0

    .line 489
    invoke-super {p0}, Landroid/view/View;->onDetachedFromWindow()V

    .line 490
    invoke-direct {p0}, Lcom/mrkeyboard/app/CandidateView;->hidePreview()V

    return-void
.end method


.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 5

    .line 381
    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mGestureDetector:Landroid/view/GestureDetector;

    invoke-virtual {v0, p1}, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    return v1

    .line 385
    :cond_0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    .line 386
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    float-to-int v2, v2

    .line 387
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result p1

    float-to-int p1, p1

    .line 388
    iput v2, p0, Lcom/mrkeyboard/app/CandidateView;->mTouchX:I

    const/4 v2, -0x1

    const/4 v3, 0x0

    packed-switch v0, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    if-gtz p1, :cond_3

    .line 397
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectedString:Ljava/lang/CharSequence;

    if-eqz p1, :cond_3

    .line 400
    iget-boolean p1, p0, Lcom/mrkeyboard/app/CandidateView;->mShowingCompletions:Z

    .line 406
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mService:Lcom/mrkeyboard/app/LatinIME;

    iget v0, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectedIndex:I

    iget-object v4, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectedString:Ljava/lang/CharSequence;

    invoke-virtual {p1, v0, v4}, Lcom/mrkeyboard/app/LatinIME;->pickSuggestionManually(ILjava/lang/CharSequence;)V

    .line 407
    iput-object v3, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectedString:Ljava/lang/CharSequence;

    .line 408
    iput v2, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectedIndex:I

    goto :goto_1

    .line 413
    :pswitch_1
    iget-boolean p1, p0, Lcom/mrkeyboard/app/CandidateView;->mScrolled:Z

    if-nez p1, :cond_2

    .line 414
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectedString:Ljava/lang/CharSequence;

    if-eqz p1, :cond_2

    .line 415
    iget-boolean p1, p0, Lcom/mrkeyboard/app/CandidateView;->mShowingAddToDictionary:Z

    if-eqz p1, :cond_1

    .line 416
    invoke-direct {p0}, Lcom/mrkeyboard/app/CandidateView;->longPressFirstWord()V

    .line 417
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->clear()V

    goto :goto_0

    .line 419
    :cond_1
    iget-boolean p1, p0, Lcom/mrkeyboard/app/CandidateView;->mShowingCompletions:Z

    .line 423
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mService:Lcom/mrkeyboard/app/LatinIME;

    iget v0, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectedIndex:I

    iget-object v4, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectedString:Ljava/lang/CharSequence;

    invoke-virtual {p1, v0, v4}, Lcom/mrkeyboard/app/LatinIME;->pickSuggestionManually(ILjava/lang/CharSequence;)V

    .line 427
    :cond_2
    :goto_0
    iput-object v3, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectedString:Ljava/lang/CharSequence;

    .line 428
    iput v2, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectedIndex:I

    .line 429
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->requestLayout()V

    .line 430
    invoke-direct {p0}, Lcom/mrkeyboard/app/CandidateView;->hidePreview()V

    .line 431
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->invalidate()V

    goto :goto_1

    .line 392
    :pswitch_2
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->invalidate()V

    :cond_3
    :goto_1
    return v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public setService(Lcom/mrkeyboard/app/LatinIME;)V
    .locals 0

    .line 198
    iput-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mService:Lcom/mrkeyboard/app/LatinIME;

    return-void
.end method

.method public setSuggestions(Ljava/util/List;ZZZ)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/CharSequence;",
            ">;ZZZ)V"
        }
    .end annotation

    .line 323
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->clear()V

    if-eqz p1, :cond_1

    .line 325
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    const/16 v1, 0x20

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 326
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    .line 327
    iget-object v2, p0, Lcom/mrkeyboard/app/CandidateView;->mSuggestions:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, -0x1

    if-nez v0, :cond_0

    .line 332
    :cond_1
    iput-boolean p2, p0, Lcom/mrkeyboard/app/CandidateView;->mShowingCompletions:Z

    .line 333
    iput-boolean p3, p0, Lcom/mrkeyboard/app/CandidateView;->mTypedWordValid:Z

    .line 334
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->getScrollY()I

    move-result p1

    const/4 p2, 0x0

    invoke-virtual {p0, p2, p1}, Lcom/mrkeyboard/app/CandidateView;->scrollTo(II)V

    .line 335
    iput p2, p0, Lcom/mrkeyboard/app/CandidateView;->mTargetScrollX:I

    .line 336
    iput-boolean p4, p0, Lcom/mrkeyboard/app/CandidateView;->mHaveMinimalSuggestion:Z

    const/4 p1, 0x0

    .line 338
    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/CandidateView;->onDraw(Landroid/graphics/Canvas;)V

    .line 339
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->invalidate()V

    .line 340
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->requestLayout()V

    return-void
.end method

.method public showAddToDictionaryHint(Ljava/lang/CharSequence;)V
    .locals 1

    .line 348
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 349
    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 350
    iget-object p1, p0, Lcom/mrkeyboard/app/CandidateView;->mAddToDictionaryHint:Ljava/lang/CharSequence;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const/4 p1, 0x0

    .line 351
    invoke-virtual {p0, v0, p1, p1, p1}, Lcom/mrkeyboard/app/CandidateView;->setSuggestions(Ljava/util/List;ZZZ)V

    const/4 p1, 0x1

    .line 352
    iput-boolean p1, p0, Lcom/mrkeyboard/app/CandidateView;->mShowingAddToDictionary:Z

    return-void
.end method

# Mr Keyboard: cores das sugestoes a partir da cor do texto das teclas do tema atual
# (MrSugg). A mais provavel (centro, ver mrLayout) na cor do texto, com negrito quando e a
# autocorrecao; as laterais com 65% de opacidade (mColorNormal); divisor e realce de toque
# tingidos com a mesma cor (a transparencia vem do proprio drawable).
.method public mrTheme(I)V
    .locals 2

    iput p1, p0, Lcom/mrkeyboard/app/CandidateView;->mColorOther:I

    iput p1, p0, Lcom/mrkeyboard/app/CandidateView;->mColorRecommended:I

    const v0, 0xffffff

    and-int/2addr v0, p1

    const/high16 v1, -0x5a000000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/mrkeyboard/app/CandidateView;->mColorNormal:I

    iget-object v1, p0, Lcom/mrkeyboard/app/CandidateView;->mPaint:Landroid/graphics/Paint;

    if-eqz v1, :cond_divider

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setColor(I)V

    :cond_divider
    iget-object v1, p0, Lcom/mrkeyboard/app/CandidateView;->mDivider:Landroid/graphics/drawable/Drawable;

    if-eqz v1, :cond_highlight

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/graphics/drawable/Drawable;->setTint(I)V

    iput-object v1, p0, Lcom/mrkeyboard/app/CandidateView;->mDivider:Landroid/graphics/drawable/Drawable;

    :cond_highlight
    iget-object v1, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectionHighlight:Landroid/graphics/drawable/Drawable;

    if-eqz v1, :cond_done

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/graphics/drawable/Drawable;->setTint(I)V

    iput-object v1, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectionHighlight:Landroid/graphics/drawable/Drawable;

    :cond_done
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->invalidate()V

    return-void
.end method





# Toque longo: x (ja somado ao scroll) esta sobre a celula da palavra digitada (indice 0)?
.method public mrOnFirst(F)Z
    .locals 3

    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mWordWidth:[I

    const/4 v1, 0x0

    aget v2, v0, v1

    if-lez v2, :cond_no

    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mWordX:[I

    aget v0, v0, v1

    int-to-float v1, v0

    cmpg-float v1, p1, v1

    if-ltz v1, :cond_no

    add-int/2addr v0, v2

    int-to-float v0, v0

    cmpg-float v0, p1, v0

    if-gez v0, :cond_no

    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method


# Desenho da faixa de sugestoes: 3 posicoes fixas, de largura igual e ocupando toda a faixa
# (esquerda, centro, direita), com o texto centralizado em cada uma e um divisor entre elas, como
# no teclado do Google. Ver mrLayout para o que vai em cada posicao.
.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 6

    if-eqz p1, :cond_nocanvas

    invoke-super {p0, p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    :cond_nocanvas
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/CandidateView;->mTotalWidth:I

    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->getHeight()I

    move-result v1

    iput v1, p0, Lcom/mrkeyboard/app/CandidateView;->mH:I

    iget-object v2, p0, Lcom/mrkeyboard/app/CandidateView;->mBgPadding:Landroid/graphics/Rect;

    if-nez v2, :cond_bg

    new-instance v2, Landroid/graphics/Rect;

    invoke-direct {v2, v0, v0, v0, v0}, Landroid/graphics/Rect;-><init>(IIII)V

    iput-object v2, p0, Lcom/mrkeyboard/app/CandidateView;->mBgPadding:Landroid/graphics/Rect;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v3

    if-eqz v3, :cond_nopad

    invoke-virtual {v3, v2}, Landroid/graphics/drawable/Drawable;->getPadding(Landroid/graphics/Rect;)Z

    :cond_nopad
    iget-object v2, p0, Lcom/mrkeyboard/app/CandidateView;->mDivider:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v2}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v3

    invoke-virtual {v2}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v4

    invoke-virtual {v2, v0, v0, v3, v4}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    :cond_bg
    # linha de base do texto: (altura + tamanho do texto - descent) / 2
    int-to-float v2, v1

    iget-object v3, p0, Lcom/mrkeyboard/app/CandidateView;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v3}, Landroid/graphics/Paint;->getTextSize()F

    move-result v3

    add-float/2addr v2, v3

    iget v3, p0, Lcom/mrkeyboard/app/CandidateView;->mDescent:I

    int-to-float v3, v3

    sub-float/2addr v2, v3

    float-to-int v2, v2

    div-int/lit8 v2, v2, 0x2

    iput v2, p0, Lcom/mrkeyboard/app/CandidateView;->mY:I

    invoke-direct {p0}, Lcom/mrkeyboard/app/CandidateView;->mrLayout()V

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/CandidateView;->mrDrawAll(Landroid/graphics/Canvas;)Z

    move-result v0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->isInEditMode()Z

    move-result v1

    if-nez v1, :cond_end

    iget-object v1, p0, Lcom/mrkeyboard/app/CandidateView;->mService:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/LatinIME;->onAutoCompletionStateChanged(Z)V

    :cond_end
    return-void
.end method

# Posicoes das sugestoes: 3 fixas (esquerda, centro, direita), cada uma com 1/3 da largura da faixa.
# As 3 primeiras entradas da lista do motor (0 = palavra digitada, 1 = melhor sugestao, 2 = a
# seguinte) ocupam as posicoes na ordem da lista, com a mais provavel no centro:
#   centro  = indice 1; indice 0 se a digitada e valida e ha sugestao minima (autocorrecao);
#             com uma unica entrada, ela fica no centro.
#   se o centro e o indice 0, o indice 1 vai para a posicao da esquerda.
#   posicao sem entrada fica vazia (as posicoes nao mudam de lugar).
#   dica "toque para salvar": palavra a esquerda e dica nas posicoes 1 e 2 juntas (mMerged).
# Preenche mSlot, mCenter, mMerged, mTotalWidth (largura da faixa, sem rolagem) e, por indice da
# lista, mWordX/mWordWidth (largura 0 = nao mostrada).
.method private mrLayout()V
    .locals 9

    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mWordWidth:[I

    const/4 v1, 0x0

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mWordX:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    iput v1, p0, Lcom/mrkeyboard/app/CandidateView;->mCenter:I

    iput-boolean v1, p0, Lcom/mrkeyboard/app/CandidateView;->mMerged:Z

    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mSlot:[I

    if-nez v0, :cond_have

    const/4 v2, 0x3

    new-array v0, v2, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mSlot:[I

    :cond_have
    const/4 v2, -0x1

    const/4 v3, 0x0

    aput v2, v0, v3

    const/4 v3, 0x1

    aput v2, v0, v3

    const/4 v3, 0x2

    aput v2, v0, v3

    # v4 = largura da faixa (se ainda nao medida, a largura da tela)
    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->getWidth()I

    move-result v4

    if-gtz v4, :cond_w

    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v4

    iget v4, v4, Landroid/util/DisplayMetrics;->widthPixels:I

    :cond_w
    iput v4, p0, Lcom/mrkeyboard/app/CandidateView;->mTotalWidth:I

    # v5 = n = min(tamanho da lista, 3)
    iget-object v5, p0, Lcom/mrkeyboard/app/CandidateView;->mSuggestions:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    const/4 v6, 0x3

    invoke-static {v5, v6}, Ljava/lang/Math;->min(II)I

    move-result v5

    if-eqz v5, :cond_end

    iget-boolean v6, p0, Lcom/mrkeyboard/app/CandidateView;->mShowingAddToDictionary:Z

    if-eqz v6, :cond_norm

    const/4 v6, 0x2

    if-lt v5, v6, :cond_norm

    # dica de salvar: palavra na posicao 0, dica nas posicoes 1 e 2 juntas
    const/4 v6, 0x1

    iput-boolean v6, p0, Lcom/mrkeyboard/app/CandidateView;->mMerged:Z

    iput v6, p0, Lcom/mrkeyboard/app/CandidateView;->mCenter:I

    const/4 v7, 0x0

    aput v7, v0, v7

    aput v6, v0, v6

    goto :cond_geo

    :cond_norm
    # v6 = centro
    const/4 v6, 0x0

    const/4 v7, 0x2

    if-lt v5, v7, :cond_c

    const/4 v6, 0x1

    iget-boolean v7, p0, Lcom/mrkeyboard/app/CandidateView;->mHaveMinimalSuggestion:Z

    if-eqz v7, :cond_c

    iget-boolean v7, p0, Lcom/mrkeyboard/app/CandidateView;->mTypedWordValid:Z

    if-eqz v7, :cond_c

    const/4 v6, 0x0

    :cond_c
    iput v6, p0, Lcom/mrkeyboard/app/CandidateView;->mCenter:I

    const/4 v7, 0x1

    aput v6, v0, v7

    const/4 v7, 0x2

    if-lt v5, v7, :cond_geo

    rsub-int/lit8 v8, v6, 0x1

    const/4 v7, 0x0

    aput v8, v0, v7

    const/4 v7, 0x3

    if-lt v5, v7, :cond_geo

    const/4 v7, 0x2

    aput v7, v0, v7

    :cond_geo
    iget-object v6, p0, Lcom/mrkeyboard/app/CandidateView;->mWordX:[I

    iget-object v7, p0, Lcom/mrkeyboard/app/CandidateView;->mWordWidth:[I

    const/4 v1, 0x0

    :gloop
    const/4 v2, 0x3

    if-ge v1, v2, :cond_end

    aget v2, v0, v1

    if-ltz v2, :cond_gnext

    mul-int v3, v1, v4

    div-int/lit8 v3, v3, 0x3

    add-int/lit8 v8, v1, 0x1

    mul-int v8, v8, v4

    div-int/lit8 v8, v8, 0x3

    iget-boolean v5, p0, Lcom/mrkeyboard/app/CandidateView;->mMerged:Z

    if-eqz v5, :cond_gset

    const/4 v5, 0x1

    if-ne v1, v5, :cond_gset

    move v8, v4

    :cond_gset
    aput v3, v6, v2

    sub-int/2addr v8, v3

    aput v8, v7, v2

    :cond_gnext
    add-int/lit8 v1, v1, 0x1

    goto :gloop

    :cond_end
    return-void
.end method

# Desenha as 3 posicoes e os divisores. Devolve true se alguma entrada e a autocorrecao
# recomendada (para LatinIME.onAutoCompletionStateChanged). canvas pode ser null (passada de
# setSuggestions): nada e desenhado, mas a selecao por toque e a recomendada sao calculadas.
.method private mrDrawAll(Landroid/graphics/Canvas;)Z
    .locals 8

    const/4 v0, 0x0

    const/4 v1, 0x0

    :loop
    const/4 v2, 0x3

    if-ge v1, v2, :done

    iget v3, p0, Lcom/mrkeyboard/app/CandidateView;->mTotalWidth:I

    mul-int v4, v1, v3

    div-int/lit8 v4, v4, 0x3

    add-int/lit8 v5, v1, 0x1

    mul-int v5, v5, v3

    div-int/lit8 v5, v5, 0x3

    iget-boolean v6, p0, Lcom/mrkeyboard/app/CandidateView;->mMerged:Z

    if-eqz v6, :cond_geo

    const/4 v7, 0x1

    if-ne v1, v7, :cond_geo

    move v5, v3

    :cond_geo
    iget-object v7, p0, Lcom/mrkeyboard/app/CandidateView;->mSlot:[I

    aget v7, v7, v1

    if-ltz v7, :cond_div

    invoke-direct {p0, p1, v7, v4, v5}, Lcom/mrkeyboard/app/CandidateView;->mrSlot(Landroid/graphics/Canvas;III)Z

    move-result v7

    if-eqz v7, :cond_div

    const/4 v0, 0x1

    :cond_div
    # divisor no fim das posicoes 0 e 1 (nao depois da dica que ocupa as posicoes 1 e 2)
    if-eqz p1, :cond_next

    const/4 v7, 0x1

    if-gt v1, v7, :cond_next

    if-eqz v6, :cond_dodiv

    if-eq v1, v7, :cond_next

    :cond_dodiv
    invoke-direct {p0, p1, v5}, Lcom/mrkeyboard/app/CandidateView;->mrDivider(Landroid/graphics/Canvas;I)V

    :cond_next
    add-int/lit8 v1, v1, 0x1

    goto :loop

    :done
    return v0
.end method

# Divisor vertical com a borda esquerda em x, centralizado na altura da faixa.
.method private mrDivider(Landroid/graphics/Canvas;I)V
    .locals 5

    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mDivider:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v1

    iget v2, p0, Lcom/mrkeyboard/app/CandidateView;->mH:I

    sub-int/2addr v2, v1

    div-int/lit8 v2, v2, 0x2

    int-to-float v3, p2

    int-to-float v4, v2

    invoke-virtual {p1, v3, v4}, Landroid/graphics/Canvas;->translate(FF)V

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    neg-float v3, v3

    neg-float v4, v4

    invoke-virtual {p1, v3, v4}, Landroid/graphics/Canvas;->translate(FF)V

    return-void
.end method

# Uma posicao [l, r): cor (centro em cor cheia, laterais mais opacas, recomendada em negrito),
# destaque e selecao de toque e o texto. Devolve true se a entrada e a recomendada.
.method private mrSlot(Landroid/graphics/Canvas;III)Z
    .locals 11

    iget-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mSuggestions:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    if-nez v0, :cond_t

    const/4 v0, 0x0

    return v0

    :cond_t
    # v1 = recomendada: sugestao minima e (indice 1 com a digitada invalida ou indice 0 valida)
    const/4 v1, 0x0

    iget-boolean v2, p0, Lcom/mrkeyboard/app/CandidateView;->mHaveMinimalSuggestion:Z

    if-eqz v2, :cond_rd

    iget-boolean v2, p0, Lcom/mrkeyboard/app/CandidateView;->mTypedWordValid:Z

    const/4 v3, 0x1

    if-ne p2, v3, :cond_n1

    if-nez v2, :cond_rd

    const/4 v1, 0x1

    goto :cond_rd

    :cond_n1
    if-nez p2, :cond_rd

    if-eqz v2, :cond_rd

    const/4 v1, 0x1

    :cond_rd
    # v2 = cor
    if-eqz v1, :cond_nr

    iget v2, p0, Lcom/mrkeyboard/app/CandidateView;->mColorRecommended:I

    goto :cond_col

    :cond_nr
    iget v3, p0, Lcom/mrkeyboard/app/CandidateView;->mCenter:I

    if-ne p2, v3, :cond_sd

    iget v2, p0, Lcom/mrkeyboard/app/CandidateView;->mColorOther:I

    goto :cond_col

    :cond_sd
    iget v2, p0, Lcom/mrkeyboard/app/CandidateView;->mColorNormal:I

    :cond_col
    # toque dentro da posicao: destaque (so com canvas e sem a dica de salvar) e selecao
    iget v3, p0, Lcom/mrkeyboard/app/CandidateView;->mTouchX:I

    const/4 v4, -0x1

    if-eq v3, v4, :cond_ns

    iget-boolean v4, p0, Lcom/mrkeyboard/app/CandidateView;->mScrolled:Z

    if-nez v4, :cond_ns

    invoke-virtual {p0}, Lcom/mrkeyboard/app/CandidateView;->getScrollX()I

    move-result v4

    add-int/2addr v3, v4

    if-lt v3, p3, :cond_ns

    if-ge v3, p4, :cond_ns

    if-eqz p1, :cond_ss

    iget-boolean v3, p0, Lcom/mrkeyboard/app/CandidateView;->mShowingAddToDictionary:Z

    if-nez v3, :cond_ss

    int-to-float v3, p3

    const/4 v4, 0x0

    invoke-virtual {p1, v3, v4}, Landroid/graphics/Canvas;->translate(FF)V

    iget-object v5, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectionHighlight:Landroid/graphics/drawable/Drawable;

    iget-object v6, p0, Lcom/mrkeyboard/app/CandidateView;->mBgPadding:Landroid/graphics/Rect;

    iget v6, v6, Landroid/graphics/Rect;->top:I

    sub-int v7, p4, p3

    iget v8, p0, Lcom/mrkeyboard/app/CandidateView;->mH:I

    const/4 v9, 0x0

    invoke-virtual {v5, v9, v6, v7, v8}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    invoke-virtual {v5, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    neg-int v3, p3

    int-to-float v3, v3

    invoke-virtual {p1, v3, v4}, Landroid/graphics/Canvas;->translate(FF)V

    :cond_ss
    iput-object v0, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectedString:Ljava/lang/CharSequence;

    iput p2, p0, Lcom/mrkeyboard/app/CandidateView;->mSelectedIndex:I

    :cond_ns
    if-eqz p1, :cond_ret

    iget-object v4, p0, Lcom/mrkeyboard/app/CandidateView;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v4, v2}, Landroid/graphics/Paint;->setColor(I)V

    sget-object v5, Landroid/graphics/Typeface;->DEFAULT:Landroid/graphics/Typeface;

    if-eqz v1, :cond_tf

    sget-object v5, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    :cond_tf
    invoke-virtual {v4, v5}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    sub-int v6, p4, p3

    invoke-direct {p0, p1, v0, p3, v6}, Lcom/mrkeyboard/app/CandidateView;->mrText(Landroid/graphics/Canvas;Ljava/lang/CharSequence;II)V

    sget-object v5, Landroid/graphics/Typeface;->DEFAULT:Landroid/graphics/Typeface;

    invoke-virtual {v4, v5}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    :cond_ret
    return v1
.end method

# Texto centralizado na posicao [x, x + w), com a cor e a fonte ja definidas no mPaint. Se nao cabe
# (w menos mGap de cada lado), encolhe o tamanho ate 75% e, se ainda nao couber, corta com "...".
.method private mrText(Landroid/graphics/Canvas;Ljava/lang/CharSequence;II)V
    .locals 11

    move-object v0, p1

    move-object v1, p2

    const/4 v2, 0x0

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v3

    # v7 = espaco disponivel (w - 2 * mGap)
    iget v4, p0, Lcom/mrkeyboard/app/CandidateView;->mGap:I

    mul-int/lit8 v4, v4, 0x2

    sub-int v4, p4, v4

    int-to-float v7, v4

    # v4 = x do centro; v5 = linha de base; v6 = paint
    div-int/lit8 v4, p4, 0x2

    add-int/2addr v4, p3

    int-to-float v4, v4

    iget v5, p0, Lcom/mrkeyboard/app/CandidateView;->mY:I

    int-to-float v5, v5

    iget-object v6, p0, Lcom/mrkeyboard/app/CandidateView;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v6, v1, v2, v3}, Landroid/graphics/Paint;->measureText(Ljava/lang/CharSequence;II)F

    move-result v8

    cmpl-float v9, v8, v7

    if-lez v9, :cond_draw

    # encolhe: tamanho * max(0,75, disponivel / medido)
    invoke-virtual {v6}, Landroid/graphics/Paint;->getTextSize()F

    move-result v9

    div-float v10, v7, v8

    const/high16 v8, 0x3f400000    # 0.75f

    cmpg-float v2, v10, v8

    if-gez v2, :cond_ratio

    move v10, v8

    :cond_ratio
    const/4 v2, 0x0

    mul-float/2addr v10, v9

    invoke-virtual {v6, v10}, Landroid/graphics/Paint;->setTextSize(F)V

    invoke-virtual {v6, v1, v2, v3}, Landroid/graphics/Paint;->measureText(Ljava/lang/CharSequence;II)F

    move-result v10

    cmpl-float v8, v10, v7

    if-lez v8, :cond_shrunk

    new-instance v8, Landroid/text/TextPaint;

    invoke-direct {v8, v6}, Landroid/text/TextPaint;-><init>(Landroid/graphics/Paint;)V

    sget-object v10, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-static {v1, v8, v7, v10}, Landroid/text/TextUtils;->ellipsize(Ljava/lang/CharSequence;Landroid/text/TextPaint;FLandroid/text/TextUtils$TruncateAt;)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v3

    :cond_shrunk
    invoke-virtual/range {v0 .. v6}, Landroid/graphics/Canvas;->drawText(Ljava/lang/CharSequence;IIFFLandroid/graphics/Paint;)V

    invoke-virtual {v6, v9}, Landroid/graphics/Paint;->setTextSize(F)V

    return-void

    :cond_draw
    invoke-virtual/range {v0 .. v6}, Landroid/graphics/Canvas;->drawText(Ljava/lang/CharSequence;IIFFLandroid/graphics/Paint;)V

    return-void
.end method
