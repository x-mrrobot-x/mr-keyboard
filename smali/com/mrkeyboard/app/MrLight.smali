.class final Lcom/mrkeyboard/app/MrLight;
.super Ljava/lang/Object;
.source "MrLight.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrLight$Api30;
    }
.end annotation


# static fields
.field static final EDGE_TO_EDGE_SDK:I = 0x23


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static bars(Landroid/inputmethodservice/InputMethodService;I)V
    .locals 2

    .prologue
    .line 51
    if-eqz p0, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x23

    if-ge v0, v1, :cond_1

    .line 58
    :cond_0
    :goto_0
    return-void

    .line 53
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Landroid/inputmethodservice/InputMethodService;->getWindow()Landroid/app/Dialog;

    move-result-object v0

    if-nez v0, :cond_2

    const/4 v0, 0x0

    .line 54
    :goto_1
    if-eqz v0, :cond_0

    invoke-static {p1}, Lcom/mrkeyboard/app/MrLight;->is(I)Z

    move-result v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLight$Api30;->navigationButtons(Landroid/view/Window;Z)V

    goto :goto_0

    .line 55
    :catch_0
    move-exception v0

    goto :goto_0

    .line 53
    :cond_2
    invoke-virtual {p0}, Landroid/inputmethodservice/InputMethodService;->getWindow()Landroid/app/Dialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_1
.end method

.method static is(I)Z
    .locals 3

    .prologue
    .line 32
    shr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    shr-int/lit8 v1, p0, 0x8

    and-int/lit16 v1, v1, 0xff

    and-int/lit16 v2, p0, 0xff

    .line 33
    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 34
    mul-int/lit8 v0, v0, 0x2

    const/16 v1, 0xff

    if-gt v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static shadowRadius(IF)F
    .locals 1

    .prologue
    .line 42
    invoke-static {p0}, Lcom/mrkeyboard/app/MrLight;->is(I)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p1, 0x0

    :cond_0
    return p1
.end method
