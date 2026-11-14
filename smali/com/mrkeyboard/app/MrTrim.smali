.class final Lcom/mrkeyboard/app/MrTrim;
.super Ljava/lang/Object;
.source "MrTrim.java"


# static fields
.field static final COMPLETE:I = 0x50

.field static final LOW:I = 0xa

.field static final MODERATE:I = 0x5

.field static final ROW:Ljava/lang/String; = "mr_perf_trim"

.field private static final TAG:Ljava/lang/String; = "MrTrim"

.field static sBytes:I

.field static sCount:I

.field static sKeyboards:I

.field static sLevel:I

.field static sPopups:I

.field static sShadows:I


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static forget()V
    .locals 1

    .prologue
    .line 47
    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrTrim;->sCount:I

    .line 48
    return-void
.end method

.method static onTrim(I)V
    .locals 9

    .prologue
    const/16 v8, 0x25

    const/4 v1, 0x0

    .line 52
    const/4 v0, 0x5

    if-ge p0, v0, :cond_0

    .line 77
    :goto_0
    return-void

    .line 53
    :cond_0
    invoke-static {v8}, Lcom/mrkeyboard/app/MrPerf;->begin(I)V

    .line 59
    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/KeyboardSwitcher;->dropUnused()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 60
    :try_start_1
    invoke-static {}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInstance()Lcom/mrkeyboard/app/KeyboardSwitcher;

    move-result-object v0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInputView()Lcom/mrkeyboard/app/LatinKeyboardView;

    move-result-object v2

    .line 61
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Lcom/mrkeyboard/app/LatinKeyboardView;->isShown()Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x1

    .line 62
    :goto_1
    if-eqz v2, :cond_4

    if-eqz v0, :cond_1

    const/16 v4, 0xa

    if-lt p0, v4, :cond_4

    :cond_1
    invoke-virtual {v2}, Lcom/mrkeyboard/app/LatinKeyboardView;->trimCaches()I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    move-result v2

    .line 63
    :goto_2
    if-nez v0, :cond_3

    .line 64
    :try_start_2
    invoke-static {}, Lcom/mrkeyboard/app/ShadowDrawHelper;->heldBytes()I
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    move-result v0

    .line 65
    :try_start_3
    invoke-static {}, Lcom/mrkeyboard/app/ShadowDrawHelper;->release()I
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    move-result v1

    .line 70
    :goto_3
    invoke-static {v8}, Lcom/mrkeyboard/app/MrPerf;->end(I)V

    .line 71
    sput p0, Lcom/mrkeyboard/app/MrTrim;->sLevel:I

    .line 72
    sput v3, Lcom/mrkeyboard/app/MrTrim;->sKeyboards:I

    .line 73
    sput v2, Lcom/mrkeyboard/app/MrTrim;->sPopups:I

    .line 74
    sput v1, Lcom/mrkeyboard/app/MrTrim;->sShadows:I

    .line 75
    sput v0, Lcom/mrkeyboard/app/MrTrim;->sBytes:I

    .line 76
    sget v0, Lcom/mrkeyboard/app/MrTrim;->sCount:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrTrim;->sCount:I

    goto :goto_0

    :cond_2
    move v0, v1

    .line 61
    goto :goto_1

    .line 67
    :catch_0
    move-exception v0

    move-object v4, v0

    move v2, v1

    move v3, v1

    move v0, v1

    .line 68
    :goto_4
    const-string v5, "MrTrim"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "trim "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " stopped: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v5, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_3

    .line 67
    :catch_1
    move-exception v0

    move-object v4, v0

    move v2, v1

    move v0, v1

    goto :goto_4

    :catch_2
    move-exception v0

    move-object v4, v0

    move v0, v1

    goto :goto_4

    :catch_3
    move-exception v4

    goto :goto_4

    :cond_3
    move v0, v1

    goto :goto_3

    :cond_4
    move v2, v1

    goto :goto_2
.end method
