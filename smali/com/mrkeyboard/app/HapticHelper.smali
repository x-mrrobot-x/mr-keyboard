.class final Lcom/mrkeyboard/app/HapticHelper;
.super Ljava/lang/Object;
.source "HapticHelper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/HapticHelper$Api33;,
        Lcom/mrkeyboard/app/HapticHelper$Api26;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static vibrate(Landroid/content/Context;ILandroid/view/View;)V
    .registers 5

    .line 17
    const-string v0, "vibrator"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/os/Vibrator;

    .line 18
    const/16 v0, 0x21

    if-eqz p0, :cond_2b

    invoke-virtual {p0}, Landroid/os/Vibrator;->hasVibrator()Z

    move-result v1

    if-eqz v1, :cond_2b

    if-lez p1, :cond_2b

    .line 19
    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt p2, v0, :cond_1c

    .line 20
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/HapticHelper$Api33;->vibrate(Landroid/os/Vibrator;I)V

    goto :goto_2a

    .line 21
    :cond_1c
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/HapticHelper$Api26;->vibrate(Landroid/os/Vibrator;I)V

    .line 26
    :goto_2a
    return-void

    .line 28
    :cond_2b
    if-eqz p2, :cond_3a

    .line 29
    sget p0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 p1, 0x3

    if-lt p0, v0, :cond_36

    .line 30
    invoke-virtual {p2, p1}, Landroid/view/View;->performHapticFeedback(I)Z

    goto :goto_3a

    .line 32
    :cond_36
    const/4 p0, 0x2

    invoke-virtual {p2, p1, p0}, Landroid/view/View;->performHapticFeedback(II)Z

    .line 37
    :cond_3a
    :goto_3a
    return-void
.end method
