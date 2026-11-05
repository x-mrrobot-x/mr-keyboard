.class final Lcom/mrkeyboard/app/MrScreenIme$Api30;
.super Ljava/lang/Object;
.source "MrScreenIme.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrScreenIme;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Api30"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 156
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static extra(Landroid/view/WindowInsets;)I
    .locals 3

    .prologue
    .line 164
    invoke-static {}, Landroid/view/WindowInsets$Type;->ime()I

    move-result v0

    invoke-virtual {p0, v0}, Landroid/view/WindowInsets;->getInsets(I)Landroid/graphics/Insets;

    move-result-object v0

    iget v0, v0, Landroid/graphics/Insets;->bottom:I

    .line 165
    invoke-static {}, Landroid/view/WindowInsets$Type;->systemBars()I

    move-result v1

    invoke-virtual {p0, v1}, Landroid/view/WindowInsets;->getInsets(I)Landroid/graphics/Insets;

    move-result-object v1

    iget v1, v1, Landroid/graphics/Insets;->bottom:I

    .line 166
    const/4 v2, 0x0

    sub-int/2addr v0, v1

    invoke-static {v2, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    return v0
.end method

.method static imeVisible(Landroid/view/View;)Z
    .locals 2

    .prologue
    .line 158
    invoke-virtual {p0}, Landroid/view/View;->getRootWindowInsets()Landroid/view/WindowInsets;

    move-result-object v0

    .line 159
    if-eqz v0, :cond_0

    invoke-static {}, Landroid/view/WindowInsets$Type;->ime()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/WindowInsets;->isVisible(I)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
