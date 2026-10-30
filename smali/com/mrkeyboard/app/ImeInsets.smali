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

    # requestApplyInsets() e ignorado enquanto a view nao tem pai. O LatinIME chama apply()
    # antes de InputMethodService.setInputView anexar a view ao inputFrame, e o teclado e
    # recriado por Handler.post (KeyboardSwitcher$1, LatinIME$2) com a janela ja visivel:
    # sem um novo pedido depois de anexar, a view nova nunca recebe as insets e a ultima
    # fileira fica atras da barra de navegacao do IME. Pede de novo ao ser anexada.
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

# Anexada (pai ja atribuido): o pedido sobe ate o ViewRootImpl e as insets sao despachadas
# na proxima travessia, antes de medir e desenhar a view nova.
.method public onViewAttachedToWindow(Landroid/view/View;)V
    .registers 2

    invoke-virtual {p1}, Landroid/view/View;->requestApplyInsets()V

    return-void
.end method

.method public onViewDetachedFromWindow(Landroid/view/View;)V
    .registers 2

    return-void
.end method
