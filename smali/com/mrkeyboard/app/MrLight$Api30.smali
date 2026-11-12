.class final Lcom/mrkeyboard/app/MrLight$Api30;
.super Ljava/lang/Object;
.source "MrLight.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrLight;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Api30"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 62
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static navigationButtons(Landroid/view/Window;Z)V
    .locals 3

    .prologue
    .line 65
    invoke-virtual {p0}, Landroid/view/Window;->getInsetsController()Landroid/view/WindowInsetsController;

    move-result-object v2

    .line 66
    if-nez v2, :cond_0

    .line 69
    :goto_0
    return-void

    .line 67
    :cond_0
    const/16 v1, 0x10

    .line 68
    if-eqz p1, :cond_1

    move v0, v1

    :goto_1
    invoke-interface {v2, v0, v1}, Landroid/view/WindowInsetsController;->setSystemBarsAppearance(II)V

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method
