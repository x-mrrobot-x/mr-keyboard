.class final Lcom/mrkeyboard/app/MrSurround$Api31;
.super Ljava/lang/Object;
.source "MrSurround.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrSurround;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Api31"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static echo(Landroid/view/inputmethod/InputConnection;)I
    .locals 6

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    const/4 v0, -0x2

    .line 49
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->echoOneBegin()V

    .line 50
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V

    .line 52
    const/16 v1, 0x60

    const/4 v2, 0x1

    const/4 v3, 0x0

    :try_start_0
    invoke-interface {p0, v1, v2, v3}, Landroid/view/inputmethod/InputConnection;->getSurroundingText(III)Landroid/view/inputmethod/SurroundingText;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v1

    .line 56
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 58
    if-nez v1, :cond_1

    .line 59
    invoke-static {v5}, Lcom/mrkeyboard/app/MrSurround;->access$002(Z)Z

    .line 68
    :cond_0
    :goto_0
    return v0

    .line 53
    :catch_0
    move-exception v1

    .line 56
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    goto :goto_0

    :catchall_0
    move-exception v0

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 57
    throw v0

    .line 62
    :cond_1
    invoke-virtual {v1}, Landroid/view/inputmethod/SurroundingText;->getText()Ljava/lang/CharSequence;

    move-result-object v2

    .line 63
    invoke-virtual {v1}, Landroid/view/inputmethod/SurroundingText;->getSelectionStart()I

    move-result v3

    .line 64
    invoke-virtual {v1}, Landroid/view/inputmethod/SurroundingText;->getSelectionEnd()I

    move-result v1

    .line 65
    if-eqz v2, :cond_0

    if-ne v3, v1, :cond_0

    if-ltz v3, :cond_0

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-gt v3, v1, :cond_0

    .line 66
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->echoOneEnd()V

    .line 67
    invoke-interface {v2, v4, v3}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrSurround;->access$102(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    .line 68
    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-ge v3, v0, :cond_2

    invoke-interface {v2, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    goto :goto_0

    :cond_2
    const/4 v0, -0x1

    goto :goto_0
.end method
