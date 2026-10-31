.class public final Lcom/mrkeyboard/app/MrLocaleCtx;
.super Ljava/lang/Object;
.source "MrLocaleCtx.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static of(Landroid/content/Context;)Landroid/content/Context;
    .locals 3

    .prologue
    .line 17
    invoke-static {p0}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v1

    .line 18
    if-eqz v1, :cond_0

    if-ne v1, p0, :cond_1

    .line 21
    :cond_0
    :goto_0
    return-object p0

    .line 19
    :cond_1
    new-instance v0, Landroid/view/ContextThemeWrapper;

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Landroid/view/ContextThemeWrapper;-><init>(Landroid/content/Context;I)V

    .line 20
    invoke-virtual {v0}, Landroid/view/ContextThemeWrapper;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v1

    invoke-virtual {p0}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/res/Resources$Theme;->setTo(Landroid/content/res/Resources$Theme;)V

    move-object p0, v0

    .line 21
    goto :goto_0
.end method
