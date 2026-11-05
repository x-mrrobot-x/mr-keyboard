.class public final Lcom/mrkeyboard/app/MrAccel;
.super Ljava/lang/Object;
.source "MrAccel.java"


# static fields
.field static final TAG:Ljava/lang/String; = "MrAccel"

.field private static sLogged:Z


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static log(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 45
    sget-boolean v0, Lcom/mrkeyboard/app/MrAccel;->sLogged:Z

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/view/View;->isAttachedToWindow()Z

    move-result v0

    if-nez v0, :cond_1

    .line 48
    :cond_0
    :goto_0
    return-void

    .line 46
    :cond_1
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrAccel;->sLogged:Z

    .line 47
    const-string v0, "MrAccel"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "keyboard window hardwareAccelerated="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Landroid/view/View;->isHardwareAccelerated()Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " (SDK "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method static logged()Z
    .locals 1

    .prologue
    .line 51
    sget-boolean v0, Lcom/mrkeyboard/app/MrAccel;->sLogged:Z

    return v0
.end method

.method public static onShown(Landroid/inputmethodservice/InputMethodService;)V
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 29
    sget-boolean v1, Lcom/mrkeyboard/app/MrAccel;->sLogged:Z

    if-nez v1, :cond_0

    if-nez p0, :cond_1

    .line 41
    :cond_0
    :goto_0
    return-void

    .line 31
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Landroid/inputmethodservice/InputMethodService;->getWindow()Landroid/app/Dialog;

    move-result-object v1

    .line 32
    if-nez v1, :cond_2

    move-object v1, v0

    .line 33
    :goto_1
    if-nez v1, :cond_3

    .line 34
    :goto_2
    if-eqz v0, :cond_0

    .line 35
    new-instance v1, Lcom/mrkeyboard/app/MrAccel$1;

    invoke-direct {v1, v0}, Lcom/mrkeyboard/app/MrAccel$1;-><init>(Landroid/view/View;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    .line 38
    :catch_0
    move-exception v0

    goto :goto_0

    .line 32
    :cond_2
    invoke-virtual {v1}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    goto :goto_1

    .line 33
    :cond_3
    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_2
.end method

.method static reset()V
    .locals 1

    .prologue
    .line 53
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrAccel;->sLogged:Z

    return-void
.end method
