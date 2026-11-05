.class final Lcom/mrkeyboard/app/MrAiDialog;
.super Ljava/lang/Object;
.source "MrAiDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnLayoutChangeListener;
.implements Landroid/content/DialogInterface$OnDismissListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrAiDialog$Retry;,
        Lcom/mrkeyboard/app/MrAiDialog$Api28;
    }
.end annotation


# static fields
.field static final RETRY_MS:J = 0x190L

.field static final RETURN_WINDOW_MS:J = 0x1d4c0L

.field static final SHORT_AREA_DP:I = 0xf0

.field static final SHOW_SELF_SDK:I = 0x1c

.field private static sAuxiliaryUiVisible:Z

.field private static sDialog:Landroid/app/Dialog;

.field private static sImeDecor:Landroid/view/View;

.field private static sKeyboardRequested:Z

.field private static sLeftAuxiliaryAt:J

.field private static sListener:Lcom/mrkeyboard/app/MrAiDialog;

.field private static sReopenAfterAuxiliaryUi:Z

.field private static sReturnPackage:Ljava/lang/String;

.field private static sSawAuxiliaryUi:Z


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static cancelReopenOnReturn()V
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 91
    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    .line 92
    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sAuxiliaryUiVisible:Z

    .line 93
    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    .line 94
    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sKeyboardRequested:Z

    .line 95
    const-wide/16 v0, 0x0

    sput-wide v0, Lcom/mrkeyboard/app/MrAiDialog;->sLeftAuxiliaryAt:J

    .line 96
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    .line 97
    return-void
.end method

.method private static close(Landroid/app/Dialog;Z)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 201
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sImeDecor:Landroid/view/View;

    .line 202
    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sListener:Lcom/mrkeyboard/app/MrAiDialog;

    .line 203
    sput-object v2, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    .line 204
    sput-object v2, Lcom/mrkeyboard/app/MrAiDialog;->sImeDecor:Landroid/view/View;

    .line 205
    sput-object v2, Lcom/mrkeyboard/app/MrAiDialog;->sListener:Lcom/mrkeyboard/app/MrAiDialog;

    .line 206
    if-eqz v0, :cond_0

    if-eqz v1, :cond_0

    .line 208
    :try_start_0
    invoke-virtual {v0, v1}, Landroid/view/View;->removeOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 213
    :cond_0
    :goto_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->dialogClosed()V

    .line 214
    if-eqz p1, :cond_1

    if-eqz p0, :cond_1

    .line 216
    :try_start_1
    invoke-virtual {p0}, Landroid/app/Dialog;->dismiss()V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    .line 221
    :cond_1
    :goto_1
    return-void

    .line 209
    :catch_0
    move-exception v0

    goto :goto_0

    .line 217
    :catch_1
    move-exception v0

    goto :goto_1
.end method

.method private static density()F
    .locals 3

    .prologue
    const/high16 v1, 0x3f800000    # 1.0f

    .line 307
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 308
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    if-nez v2, :cond_1

    .line 312
    :cond_0
    :goto_0
    return v1

    .line 309
    :cond_1
    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 310
    const/4 v2, 0x0

    cmpl-float v2, v0, v2

    if-lez v2, :cond_2

    :goto_1
    move v1, v0

    goto :goto_0

    :cond_2
    move v0, v1

    goto :goto_1

    .line 311
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static dismiss()V
    .locals 2

    .prologue
    .line 70
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAiDialog;->close(Landroid/app/Dialog;Z)V

    .line 71
    return-void
.end method

.method private static imeDecor()Landroid/view/View;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 288
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 289
    if-nez v1, :cond_1

    .line 292
    :cond_0
    :goto_0
    return-object v0

    .line 290
    :cond_1
    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getWindow()Landroid/app/Dialog;

    move-result-object v1

    .line 291
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 292
    invoke-virtual {v1}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    goto :goto_0
.end method

.method private static imeTop()I
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v0, -0x1

    .line 317
    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sImeDecor:Landroid/view/View;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sImeDecor:Landroid/view/View;

    .line 318
    :goto_0
    if-nez v1, :cond_2

    .line 321
    :cond_0
    :goto_1
    return v0

    .line 317
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->imeDecor()Landroid/view/View;

    move-result-object v1

    goto :goto_0

    .line 319
    :cond_2
    const/4 v2, 0x2

    new-array v2, v2, [I

    .line 320
    invoke-virtual {v1, v2}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 321
    aget v1, v2, v3

    if-lez v1, :cond_0

    aget v0, v2, v3

    goto :goto_1
.end method

.method static isShowing()Z
    .locals 1

    .prologue
    .line 65
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static onImeWindowShown()V
    .locals 2

    .prologue
    .line 171
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->returnPending()Z

    move-result v0

    if-nez v0, :cond_1

    .line 178
    :cond_0
    :goto_0
    return-void

    .line 172
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 173
    if-eqz v0, :cond_0

    .line 174
    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v0

    .line 175
    if-eqz v0, :cond_0

    .line 176
    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    if-eqz v1, :cond_2

    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    iget-object v0, v0, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 177
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->reopenPendingDialog()V

    goto :goto_0
.end method

.method static onInputStarted(Landroid/view/inputmethod/EditorInfo;)V
    .locals 4

    .prologue
    .line 128
    if-eqz p0, :cond_0

    :try_start_0
    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sKeyboardRequested:Z

    if-nez v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->returnPending()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 136
    :cond_0
    :goto_0
    return-void

    .line 129
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    iget-object v1, p0, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 130
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sKeyboardRequested:Z

    .line 131
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->showKeyboard()V

    .line 132
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/mrkeyboard/app/MrAiDialog$Retry;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Lcom/mrkeyboard/app/MrAiDialog$Retry;-><init>(Lcom/mrkeyboard/app/MrAiDialog$1;)V

    const-wide/16 v2, 0x190

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 133
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static onInputViewStarted(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 182
    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sAuxiliaryUiVisible:Z

    if-nez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    if-eqz v0, :cond_0

    if-nez p0, :cond_1

    .line 190
    :cond_0
    :goto_0
    return-void

    .line 184
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 185
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getPackageName()Ljava/lang/String;

    move-result-object v0

    .line 186
    :goto_1
    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    if-eqz v0, :cond_2

    .line 187
    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 188
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->cancelReopenOnReturn()V

    goto :goto_0

    .line 185
    :cond_3
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private static reopenPendingDialog()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 193
    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    if-nez v0, :cond_0

    .line 198
    :goto_0
    return-void

    .line 194
    :cond_0
    sput-boolean v1, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    .line 195
    sput-boolean v1, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    .line 196
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    .line 197
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->showDialog()V

    goto :goto_0
.end method

.method static requestReopenOnReturn()V
    .locals 4

    .prologue
    const/4 v0, 0x0

    const/4 v2, 0x0

    .line 75
    const/4 v1, 0x1

    sput-boolean v1, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    .line 76
    sput-boolean v2, Lcom/mrkeyboard/app/MrAiDialog;->sAuxiliaryUiVisible:Z

    .line 77
    sput-boolean v2, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    .line 78
    sput-boolean v2, Lcom/mrkeyboard/app/MrAiDialog;->sKeyboardRequested:Z

    .line 79
    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/mrkeyboard/app/MrAiDialog;->sLeftAuxiliaryAt:J

    .line 80
    sput-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    .line 82
    :try_start_0
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 83
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v0

    .line 84
    :cond_0
    if-eqz v0, :cond_1

    iget-object v0, v0, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 88
    :cond_1
    :goto_0
    return-void

    .line 85
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static retryKeyboard()V
    .locals 2

    .prologue
    .line 140
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 141
    if-eqz v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->returnPending()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->isInputViewShown()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 143
    :cond_0
    :goto_0
    return-void

    .line 142
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->showKeyboard()V

    goto :goto_0
.end method

.method private static returnPending()Z
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 112
    sget-boolean v1, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    if-eqz v1, :cond_0

    sget-boolean v1, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    if-eqz v1, :cond_0

    sget-boolean v1, Lcom/mrkeyboard/app/MrAiDialog;->sAuxiliaryUiVisible:Z

    if-eqz v1, :cond_1

    .line 117
    :cond_0
    :goto_0
    return v0

    .line 113
    :cond_1
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    sget-wide v4, Lcom/mrkeyboard/app/MrAiDialog;->sLeftAuxiliaryAt:J

    sub-long/2addr v2, v4

    const-wide/32 v4, 0x1d4c0

    cmp-long v1, v2, v4

    if-lez v1, :cond_2

    .line 114
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->cancelReopenOnReturn()V

    goto :goto_0

    .line 117
    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method static setAuxiliaryUiVisible(Z)V
    .locals 2

    .prologue
    .line 101
    sput-boolean p0, Lcom/mrkeyboard/app/MrAiDialog;->sAuxiliaryUiVisible:Z

    .line 102
    if-eqz p0, :cond_0

    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    .line 104
    :goto_0
    return-void

    .line 103
    :cond_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    sput-wide v0, Lcom/mrkeyboard/app/MrAiDialog;->sLeftAuxiliaryAt:J

    goto :goto_0
.end method

.method private static showDialog()V
    .locals 9

    .prologue
    const/4 v1, 0x0

    const/4 v8, 0x1

    .line 224
    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 225
    if-nez v3, :cond_1

    .line 285
    :cond_0
    :goto_0
    return-void

    .line 226
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 228
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->imeDecor()Landroid/view/View;

    move-result-object v4

    .line 229
    if-eqz v4, :cond_0

    .line 230
    invoke-virtual {v4}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v5

    .line 231
    if-eqz v5, :cond_0

    .line 235
    :try_start_0
    invoke-virtual {v3}, Lcom/mrkeyboard/app/LatinIME;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v2, "Theme.MrKeyboard.Dialog"

    const-string v6, "style"

    .line 236
    invoke-virtual {v3}, Lcom/mrkeyboard/app/LatinIME;->getPackageName()Ljava/lang/String;

    move-result-object v7

    .line 235
    invoke-virtual {v0, v2, v6, v7}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 237
    if-nez v0, :cond_5

    const v0, 0x7f0d00a1

    move v2, v0

    .line 238
    :goto_1
    new-instance v0, Landroid/app/Dialog;

    invoke-direct {v0, v3, v2}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    .line 239
    const/4 v1, 0x1

    :try_start_1
    invoke-virtual {v0, v1}, Landroid/app/Dialog;->requestWindowFeature(I)Z

    .line 241
    invoke-virtual {v0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "mr_ai_dialog"

    const-string v6, "layout"

    .line 242
    invoke-virtual {v3}, Lcom/mrkeyboard/app/LatinIME;->getPackageName()Ljava/lang/String;

    move-result-object v3

    .line 241
    invoke-virtual {v1, v2, v6, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 243
    if-nez v1, :cond_2

    const v1, 0x7f0a0042

    .line 244
    :cond_2
    invoke-virtual {v0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrLocaleCtx;->of(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v2

    const/4 v3, 0x0

    .line 245
    invoke-virtual {v2, v1, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 246
    const-string v2, "ai_card"

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    .line 247
    if-eqz v2, :cond_0

    .line 249
    new-instance v3, Lcom/mrkeyboard/app/MrAiDialog;

    invoke-direct {v3}, Lcom/mrkeyboard/app/MrAiDialog;-><init>()V

    .line 250
    sput-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    .line 251
    sput-object v4, Lcom/mrkeyboard/app/MrAiDialog;->sImeDecor:Landroid/view/View;

    .line 252
    sput-object v3, Lcom/mrkeyboard/app/MrAiDialog;->sListener:Lcom/mrkeyboard/app/MrAiDialog;

    .line 253
    invoke-virtual {v1, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 254
    const/4 v6, 0x1

    invoke-virtual {v2, v6}, Landroid/view/View;->setClickable(Z)V

    .line 255
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Landroid/app/Dialog;->setCancelable(Z)V

    .line 256
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Landroid/app/Dialog;->setCanceledOnTouchOutside(Z)V

    .line 257
    invoke-virtual {v0, v3}, Landroid/app/Dialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    .line 258
    invoke-virtual {v0, v1}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 259
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->setup(Landroid/view/View;)V

    .line 261
    invoke-virtual {v0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    .line 262
    if-nez v2, :cond_3

    .line 263
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    .line 281
    :catch_0
    move-exception v1

    .line 282
    :goto_2
    if-eqz v0, :cond_4

    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    if-ne v0, v1, :cond_4

    invoke-static {v0, v8}, Lcom/mrkeyboard/app/MrAiDialog;->close(Landroid/app/Dialog;Z)V

    goto/16 :goto_0

    .line 266
    :cond_3
    :try_start_2
    new-instance v6, Landroid/graphics/drawable/ColorDrawable;

    const/4 v7, 0x0

    invoke-direct {v6, v7}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v2, v6}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 267
    const/4 v6, 0x2

    invoke-virtual {v2, v6}, Landroid/view/Window;->clearFlags(I)V

    .line 268
    const/high16 v6, 0x20000

    invoke-virtual {v2, v6}, Landroid/view/Window;->clearFlags(I)V

    .line 269
    const/16 v6, 0x308

    invoke-virtual {v2, v6}, Landroid/view/Window;->addFlags(I)V

    .line 270
    invoke-virtual {v2}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v6

    invoke-static {v6, v1}, Lcom/mrkeyboard/app/MrScreens;->fitDialog(Landroid/view/View;Landroid/view/View;)V

    .line 271
    invoke-virtual {v2}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    .line 272
    iput-object v5, v1, Landroid/view/WindowManager$LayoutParams;->token:Landroid/os/IBinder;

    .line 273
    const/16 v5, 0x3eb

    iput v5, v1, Landroid/view/WindowManager$LayoutParams;->type:I

    .line 274
    const/16 v5, 0x37

    iput v5, v1, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 275
    const/4 v5, -0x1

    iput v5, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 276
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->imeTop()I

    move-result v5

    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->density()F

    move-result v6

    invoke-static {v5, v6}, Lcom/mrkeyboard/app/MrAiDialog;->windowHeight(IF)I

    move-result v5

    iput v5, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 277
    invoke-virtual {v2, v1}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    .line 279
    invoke-virtual {v4, v3}, Landroid/view/View;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    .line 280
    invoke-virtual {v0}, Landroid/app/Dialog;->show()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto/16 :goto_0

    .line 283
    :cond_4
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->dialogClosed()V

    goto/16 :goto_0

    .line 281
    :catch_1
    move-exception v0

    move-object v0, v1

    goto :goto_2

    :cond_5
    move v2, v0

    goto/16 :goto_1
.end method

.method static showKeyboard()V
    .locals 3

    .prologue
    .line 147
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 148
    if-eqz v0, :cond_0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1c

    if-ge v1, v2, :cond_1

    .line 154
    :cond_0
    :goto_0
    return-void

    .line 150
    :cond_1
    :try_start_0
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAiDialog$Api28;->show(Landroid/inputmethodservice/InputMethodService;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 151
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static toggle()V
    .locals 1

    .prologue
    .line 53
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 54
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 61
    :goto_0
    return-void

    .line 56
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->showDialog()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 58
    :catch_0
    move-exception v0

    .line 59
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    goto :goto_0
.end method

.method static windowHeight(IF)I
    .locals 2

    .prologue
    .line 301
    if-lez p0, :cond_0

    int-to-float v0, p0

    const/high16 v1, 0x43700000    # 240.0f

    mul-float/2addr v1, p1

    cmpg-float v0, v0, v1

    if-gez v0, :cond_1

    :cond_0
    const/4 p0, -0x1

    .line 302
    :cond_1
    return p0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0

    .prologue
    .line 325
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 326
    return-void
.end method

.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 2

    .prologue
    .line 329
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    if-ne p1, v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAiDialog;->close(Landroid/app/Dialog;Z)V

    .line 330
    :cond_0
    return-void
.end method

.method public onLayoutChange(Landroid/view/View;IIIIIIII)V
    .locals 4

    .prologue
    .line 334
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    .line 335
    if-nez v0, :cond_1

    .line 348
    :cond_0
    :goto_0
    return-void

    .line 337
    :cond_1
    :try_start_0
    invoke-virtual {v0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    .line 338
    if-eqz v0, :cond_0

    .line 339
    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    .line 340
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->imeTop()I

    move-result v2

    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->density()F

    move-result v3

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrAiDialog;->windowHeight(IF)I

    move-result v2

    .line 341
    iget v3, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    if-eq v3, v2, :cond_0

    .line 342
    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 343
    invoke-virtual {v0, v1}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 345
    :catch_0
    move-exception v0

    goto :goto_0
.end method
