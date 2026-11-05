.class final Lcom/mrkeyboard/app/MrKeep;
.super Ljava/lang/Object;
.source "MrKeep.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrKeep$Tick;
    }
.end annotation


# static fields
.field static final ASK_AGAIN_MS:J = 0x1c2L

.field static final MAX_ASKS:I = 0x3

.field static final TICK_MS:J = 0x96L

.field static final WINDOW_MS:J = 0xfa0L

.field private static sAskedAt:J

.field private static sAsks:I

.field private static sKeyboard:Z

.field private static sPackage:Ljava/lang/String;

.field private static sRebound:Z

.field private static sStart:J

.field private static sTicking:Z

.field private static sTool:Z

.field private static sTurned:Z


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$102(Z)Z
    .locals 0

    .prologue
    .line 23
    sput-boolean p0, Lcom/mrkeyboard/app/MrKeep;->sTicking:Z

    return p0
.end method

.method private static active(J)Z
    .locals 4

    .prologue
    .line 122
    sget-wide v0, Lcom/mrkeyboard/app/MrKeep;->sStart:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    sget-wide v0, Lcom/mrkeyboard/app/MrKeep;->sStart:J

    sub-long v0, p0, v0

    const-wide/16 v2, 0xfa0

    cmp-long v0, v0, v2

    if-gtz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static ask(J)V
    .locals 4

    .prologue
    .line 126
    sget v0, Lcom/mrkeyboard/app/MrKeep;->sAsks:I

    const/4 v1, 0x3

    if-ge v0, v1, :cond_0

    sget v0, Lcom/mrkeyboard/app/MrKeep;->sAsks:I

    if-lez v0, :cond_1

    sget-wide v0, Lcom/mrkeyboard/app/MrKeep;->sAskedAt:J

    sub-long v0, p0, v0

    const-wide/16 v2, 0x1c2

    cmp-long v0, v0, v2

    if-gez v0, :cond_1

    .line 130
    :cond_0
    :goto_0
    return-void

    .line 127
    :cond_1
    sget v0, Lcom/mrkeyboard/app/MrKeep;->sAsks:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrKeep;->sAsks:I

    .line 128
    sput-wide p0, Lcom/mrkeyboard/app/MrKeep;->sAskedAt:J

    .line 129
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->showKeyboard()V

    goto :goto_0
.end method

.method private static begin(J)V
    .locals 4

    .prologue
    .line 117
    sget-wide v0, Lcom/mrkeyboard/app/MrKeep;->sStart:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    sget-wide v0, Lcom/mrkeyboard/app/MrKeep;->sStart:J

    sub-long v0, p0, v0

    const-wide/16 v2, 0xfa0

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrKeep;->reset()V

    .line 118
    :cond_0
    sput-wide p0, Lcom/mrkeyboard/app/MrKeep;->sStart:J

    .line 119
    return-void
.end method

.method static onHidden()V
    .locals 2

    .prologue
    .line 71
    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrKeep;->toolOpen()Z

    move-result v0

    if-nez v0, :cond_0

    .line 78
    :goto_0
    return-void

    .line 72
    :cond_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrKeep;->begin(J)V

    .line 73
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrKeep;->sTool:Z

    .line 74
    invoke-static {}, Lcom/mrkeyboard/app/MrKeep;->postTick()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 75
    :catch_0
    move-exception v0

    .line 76
    invoke-static {}, Lcom/mrkeyboard/app/MrKeep;->reset()V

    goto :goto_0
.end method

.method static onInput(Landroid/view/inputmethod/EditorInfo;)V
    .locals 2

    .prologue
    .line 83
    if-eqz p0, :cond_0

    :try_start_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrKeep;->active(J)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrKeep;->sTurned:Z

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrKeep;->sKeyboard:Z

    if-nez v0, :cond_1

    .line 91
    :cond_0
    :goto_0
    return-void

    .line 84
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrKeep;->sPackage:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrKeep;->sPackage:Ljava/lang/String;

    iget-object v1, p0, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 85
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrKeep;->sRebound:Z

    .line 86
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 87
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->isInputViewShown()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrKeep;->ask(J)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 88
    :catch_0
    move-exception v0

    .line 89
    invoke-static {}, Lcom/mrkeyboard/app/MrKeep;->reset()V

    goto :goto_0
.end method

.method static onTurn(Lcom/mrkeyboard/app/LatinIME;)V
    .locals 2

    .prologue
    .line 52
    if-nez p0, :cond_0

    .line 66
    :goto_0
    return-void

    .line 53
    :cond_0
    :try_start_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrKeep;->begin(J)V

    .line 54
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrKeep;->sTurned:Z

    .line 55
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->isInputViewShown()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 56
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrKeep;->sKeyboard:Z

    .line 57
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v0

    .line 58
    if-eqz v0, :cond_1

    iget-object v1, v0, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v0, v0, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrKeep;->sPackage:Ljava/lang/String;

    .line 60
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrKeep;->toolOpen()Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrKeep;->sTool:Z

    .line 61
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrKeep;->postTick()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 62
    :catch_0
    move-exception v0

    .line 64
    invoke-static {}, Lcom/mrkeyboard/app/MrKeep;->reset()V

    goto :goto_0
.end method

.method private static postTick()V
    .locals 4

    .prologue
    .line 138
    sget-boolean v0, Lcom/mrkeyboard/app/MrKeep;->sTicking:Z

    if-eqz v0, :cond_0

    .line 141
    :goto_0
    return-void

    .line 139
    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrKeep;->sTicking:Z

    .line 140
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/mrkeyboard/app/MrKeep$Tick;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Lcom/mrkeyboard/app/MrKeep$Tick;-><init>(Lcom/mrkeyboard/app/MrKeep$1;)V

    const-wide/16 v2, 0x96

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0
.end method

.method static reset()V
    .locals 4

    .prologue
    const-wide/16 v2, 0x0

    const/4 v1, 0x0

    .line 145
    sput-wide v2, Lcom/mrkeyboard/app/MrKeep;->sStart:J

    .line 146
    sput-boolean v1, Lcom/mrkeyboard/app/MrKeep;->sTurned:Z

    .line 147
    sput-boolean v1, Lcom/mrkeyboard/app/MrKeep;->sTool:Z

    .line 148
    sput-boolean v1, Lcom/mrkeyboard/app/MrKeep;->sKeyboard:Z

    .line 149
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrKeep;->sPackage:Ljava/lang/String;

    .line 150
    sput-boolean v1, Lcom/mrkeyboard/app/MrKeep;->sRebound:Z

    .line 151
    sput v1, Lcom/mrkeyboard/app/MrKeep;->sAsks:I

    .line 152
    sput-wide v2, Lcom/mrkeyboard/app/MrKeep;->sAskedAt:J

    .line 153
    return-void
.end method

.method static tick()V
    .locals 4

    .prologue
    .line 96
    :try_start_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 97
    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 98
    if-eqz v2, :cond_0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrKeep;->active(J)Z

    move-result v3

    if-nez v3, :cond_1

    .line 99
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrKeep;->reset()V

    .line 114
    :goto_0
    return-void

    .line 102
    :cond_1
    invoke-virtual {v2}, Lcom/mrkeyboard/app/LatinIME;->isInputViewShown()Z

    move-result v2

    .line 103
    if-eqz v2, :cond_5

    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrKeep;->sKeyboard:Z

    .line 105
    :cond_2
    :goto_1
    sget-boolean v0, Lcom/mrkeyboard/app/MrKeep;->sTurned:Z

    if-eqz v0, :cond_3

    sget-boolean v0, Lcom/mrkeyboard/app/MrKeep;->sTool:Z

    if-eqz v0, :cond_3

    if-eqz v2, :cond_3

    invoke-static {}, Lcom/mrkeyboard/app/MrKeep;->toolOpen()Z

    move-result v0

    if-nez v0, :cond_3

    .line 106
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrKeep;->sTool:Z

    .line 107
    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->toggle()V

    .line 109
    :cond_3
    sget-boolean v0, Lcom/mrkeyboard/app/MrKeep;->sKeyboard:Z

    if-nez v0, :cond_4

    sget-boolean v0, Lcom/mrkeyboard/app/MrKeep;->sTool:Z

    if-eqz v0, :cond_6

    :cond_4
    invoke-static {}, Lcom/mrkeyboard/app/MrKeep;->postTick()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 111
    :catch_0
    move-exception v0

    .line 112
    invoke-static {}, Lcom/mrkeyboard/app/MrKeep;->reset()V

    goto :goto_0

    .line 104
    :cond_5
    :try_start_1
    sget-boolean v3, Lcom/mrkeyboard/app/MrKeep;->sTurned:Z

    if-eqz v3, :cond_2

    sget-boolean v3, Lcom/mrkeyboard/app/MrKeep;->sKeyboard:Z

    if-eqz v3, :cond_2

    sget-boolean v3, Lcom/mrkeyboard/app/MrKeep;->sRebound:Z

    if-eqz v3, :cond_2

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrKeep;->ask(J)V

    goto :goto_1

    .line 110
    :cond_6
    invoke-static {}, Lcom/mrkeyboard/app/MrKeep;->reset()V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method private static toolOpen()Z
    .locals 1

    .prologue
    .line 134
    sget-boolean v0, Lcom/mrkeyboard/app/MrTune;->sOn:Z

    if-nez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sDlg:Landroid/app/Dialog;

    if-eqz v0, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sDlg:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method
