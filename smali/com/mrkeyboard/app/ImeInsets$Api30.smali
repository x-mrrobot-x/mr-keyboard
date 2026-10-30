.class final Lcom/mrkeyboard/app/ImeInsets$Api30;
.super Ljava/lang/Object;
.source "ImeInsets.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/ImeInsets;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Api30"
.end annotation


# direct methods
.method constructor <init>()V
    .registers 1

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static applyInsets(Landroid/view/View;Landroid/view/WindowInsets;III)V
    .registers 7

    .line 44
    invoke-static {}, Landroid/view/WindowInsets$Type;->navigationBars()I

    move-result v0

    invoke-static {}, Landroid/view/WindowInsets$Type;->displayCutout()I

    move-result v1

    or-int/2addr v0, v1

    # A barra de navegacao do IME (chevron + seletor de teclado) e entregue
    # ao teclado como captionBar(), nao como navigationBars().
    invoke-static {}, Landroid/view/WindowInsets$Type;->captionBar()I

    move-result v1

    or-int/2addr v0, v1

    .line 45
    invoke-virtual {p1, v0}, Landroid/view/WindowInsets;->getInsets(I)Landroid/graphics/Insets;

    move-result-object p1

    .line 46
    iget v0, p1, Landroid/graphics/Insets;->left:I

    add-int/2addr v0, p2

    .line 48
    invoke-virtual {p0}, Landroid/view/View;->getPaddingTop()I

    move-result p2

    iget v1, p1, Landroid/graphics/Insets;->right:I

    add-int/2addr v1, p3

    iget p1, p1, Landroid/graphics/Insets;->bottom:I

    add-int/2addr p1, p4

    .line 46
    invoke-virtual {p0, v0, p2, v1, p1}, Landroid/view/View;->setPadding(IIII)V

    .line 52
    return-void
.end method
