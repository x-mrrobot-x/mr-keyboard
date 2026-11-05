.class public final Lcom/mrkeyboard/app/ImeInsets;
.super Ljava/lang/Object;
.source "ImeInsets.java"

# interfaces
.implements Landroid/view/View$OnApplyWindowInsetsListener;

.implements Landroid/view/View$OnAttachStateChangeListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/ImeInsets$Api30;
    }
.end annotation


# instance fields
.field private final mBaseB:I

.field private final mBaseL:I

.field private final mBaseR:I


# direct methods
.method private constructor <init>(III)V
    .registers 4

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 15
    iput p1, p0, Lcom/mrkeyboard/app/ImeInsets;->mBaseL:I

    .line 16
    iput p2, p0, Lcom/mrkeyboard/app/ImeInsets;->mBaseR:I

    .line 17
    iput p3, p0, Lcom/mrkeyboard/app/ImeInsets;->mBaseB:I

    .line 18
    return-void
.end method

.method public static apply(Landroid/view/View;)V
    .registers 5

    .line 21
    if-eqz p0, :cond_21

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-ge v0, v1, :cond_9

    goto :goto_21

    .line 24
    :cond_9
    new-instance v0, Lcom/mrkeyboard/app/ImeInsets;

    .line 25
    invoke-virtual {p0}, Landroid/view/View;->getPaddingLeft()I

    move-result v1

    .line 26
    invoke-virtual {p0}, Landroid/view/View;->getPaddingRight()I

    move-result v2

    .line 27
    invoke-virtual {p0}, Landroid/view/View;->getPaddingBottom()I

    move-result v3

    invoke-direct {v0, v1, v2, v3}, Lcom/mrkeyboard/app/ImeInsets;-><init>(III)V

    .line 29
    invoke-virtual {p0, v0}, Landroid/view/View;->setOnApplyWindowInsetsListener(Landroid/view/View$OnApplyWindowInsetsListener;)V

    # requestApplyInsets() is ignored while the view has no parent. LatinIME calls apply()
    # before InputMethodService.setInputView attaches the view to the inputFrame, and the keyboard is
    # recreated by Handler.post (KeyboardSwitcher$1, LatinIME$2) with the window already visible:
    # without a new request after attaching, the new view never receives the insets and the last
    # row ends up behind the IME navigation bar. Requests again when attached.
    invoke-virtual {p0, v0}, Landroid/view/View;->addOnAttachStateChangeListener(Landroid/view/View$OnAttachStateChangeListener;)V

    .line 30
    invoke-virtual {p0}, Landroid/view/View;->requestApplyInsets()V

    .line 31
    return-void

    .line 22
    :cond_21
    :goto_21
    return-void
.end method


# virtual methods
.method public onApplyWindowInsets(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .registers 6

    .line 35
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_f

    .line 36
    iget v0, p0, Lcom/mrkeyboard/app/ImeInsets;->mBaseL:I

    iget v1, p0, Lcom/mrkeyboard/app/ImeInsets;->mBaseR:I

    iget v2, p0, Lcom/mrkeyboard/app/ImeInsets;->mBaseB:I

    invoke-static {p1, p2, v0, v1, v2}, Lcom/mrkeyboard/app/ImeInsets$Api30;->applyInsets(Landroid/view/View;Landroid/view/WindowInsets;III)V

    .line 38
    :cond_f
    return-object p2
.end method

# Attached (parent already assigned): the request goes up to the ViewRootImpl and the insets are dispatched
# on the next traversal, before the new view is measured and drawn.
.method public onViewAttachedToWindow(Landroid/view/View;)V
    .registers 2

    invoke-virtual {p1}, Landroid/view/View;->requestApplyInsets()V

    return-void
.end method

.method public onViewDetachedFromWindow(Landroid/view/View;)V
    .registers 2

    return-void
.end method
