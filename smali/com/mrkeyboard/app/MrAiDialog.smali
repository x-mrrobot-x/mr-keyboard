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
    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static cancelReopenOnReturn()V
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 84
    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    .line 85
    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sAuxiliaryUiVisible:Z

    .line 86
    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    .line 87
    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sKeyboardRequested:Z

    .line 88
    const-wide/16 v0, 0x0

    sput-wide v0, Lcom/mrkeyboard/app/MrAiDialog;->sLeftAuxiliaryAt:J

    .line 89
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    .line 90
    return-void
.end method

.method private static close(Landroid/app/Dialog;Z)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 193
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sImeDecor:Landroid/view/View;

    .line 194
    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sListener:Lcom/mrkeyboard/app/MrAiDialog;

    .line 195
    sput-object v2, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    .line 196
    sput-object v2, Lcom/mrkeyboard/app/MrAiDialog;->sImeDecor:Landroid/view/View;

    .line 197
    sput-object v2, Lcom/mrkeyboard/app/MrAiDialog;->sListener:Lcom/mrkeyboard/app/MrAiDialog;

    .line 198
    if-eqz v0, :cond_0

    if-eqz v1, :cond_0

    .line 200
    :try_start_0
    invoke-virtual {v0, v1}, Landroid/view/View;->removeOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 205
    :cond_0
    :goto_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->dialogClosed()V

    .line 206
    if-eqz p1, :cond_1

    if-eqz p0, :cond_1

    .line 208
    :try_start_1
    invoke-virtual {p0}, Landroid/app/Dialog;->dismiss()V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    .line 213
    :cond_1
    :goto_1
    return-void

    .line 201
    :catch_0
    move-exception v0

    goto :goto_0

    .line 209
    :catch_1
    move-exception v0

    goto :goto_1
.end method

.method static dismiss()V
    .locals 2

    .prologue
    .line 63
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAiDialog;->close(Landroid/app/Dialog;Z)V

    .line 64
    return-void
.end method

.method private static imeDecor()Landroid/view/View;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 280
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 281
    if-nez v1, :cond_1

    .line 284
    :cond_0
    :goto_0
    return-object v0

    .line 282
    :cond_1
    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getWindow()Landroid/app/Dialog;

    move-result-object v1

    .line 283
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 284
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

    .line 288
    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sImeDecor:Landroid/view/View;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sImeDecor:Landroid/view/View;

    .line 289
    :goto_0
    if-nez v1, :cond_2

    .line 292
    :cond_0
    :goto_1
    return v0

    .line 288
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->imeDecor()Landroid/view/View;

    move-result-object v1

    goto :goto_0

    .line 290
    :cond_2
    const/4 v2, 0x2

    new-array v2, v2, [I

    .line 291
    invoke-virtual {v1, v2}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 292
    aget v1, v2, v3

    if-lez v1, :cond_0

    aget v0, v2, v3

    goto :goto_1
.end method

.method static onImeWindowShown()V
    .locals 2

    .prologue
    .line 163
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->returnPending()Z

    move-result v0

    if-nez v0, :cond_1

    .line 170
    :cond_0
    :goto_0
    return-void

    .line 164
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 165
    if-eqz v0, :cond_0

    .line 166
    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v0

    .line 167
    if-eqz v0, :cond_0

    .line 168
    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    if-eqz v1, :cond_2

    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    iget-object v0, v0, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 169
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->reopenPendingDialog()V

    goto :goto_0
.end method

.method static onInputStarted(Landroid/view/inputmethod/EditorInfo;)V
    .locals 4

    .prologue
    .line 121
    if-eqz p0, :cond_0

    :try_start_0
    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sKeyboardRequested:Z

    if-nez v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->returnPending()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 129
    :cond_0
    :goto_0
    return-void

    .line 122
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    iget-object v1, p0, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 123
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sKeyboardRequested:Z

    .line 124
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->showKeyboard()V

    .line 125
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

    .line 126
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static onInputViewStarted(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 174
    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sAuxiliaryUiVisible:Z

    if-nez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    if-eqz v0, :cond_0

    if-nez p0, :cond_1

    .line 182
    :cond_0
    :goto_0
    return-void

    .line 176
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 177
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getPackageName()Ljava/lang/String;

    move-result-object v0

    .line 178
    :goto_1
    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    if-eqz v0, :cond_2

    .line 179
    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 180
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->cancelReopenOnReturn()V

    goto :goto_0

    .line 177
    :cond_3
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private static reopenPendingDialog()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 185
    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    if-nez v0, :cond_0

    .line 190
    :goto_0
    return-void

    .line 186
    :cond_0
    sput-boolean v1, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    .line 187
    sput-boolean v1, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    .line 188
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    .line 189
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->showDialog()V

    goto :goto_0
.end method

.method static requestReopenOnReturn()V
    .locals 4

    .prologue
    const/4 v0, 0x0

    const/4 v2, 0x0

    .line 68
    const/4 v1, 0x1

    sput-boolean v1, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    .line 69
    sput-boolean v2, Lcom/mrkeyboard/app/MrAiDialog;->sAuxiliaryUiVisible:Z

    .line 70
    sput-boolean v2, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    .line 71
    sput-boolean v2, Lcom/mrkeyboard/app/MrAiDialog;->sKeyboardRequested:Z

    .line 72
    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/mrkeyboard/app/MrAiDialog;->sLeftAuxiliaryAt:J

    .line 73
    sput-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    .line 75
    :try_start_0
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 76
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v0

    .line 77
    :cond_0
    if-eqz v0, :cond_1

    iget-object v0, v0, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 81
    :cond_1
    :goto_0
    return-void

    .line 78
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static retryKeyboard()V
    .locals 2

    .prologue
    .line 133
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 134
    if-eqz v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->returnPending()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->isInputViewShown()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 136
    :cond_0
    :goto_0
    return-void

    .line 135
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->showKeyboard()V

    goto :goto_0
.end method

.method private static returnPending()Z
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 105
    sget-boolean v1, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    if-eqz v1, :cond_0

    sget-boolean v1, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    if-eqz v1, :cond_0

    sget-boolean v1, Lcom/mrkeyboard/app/MrAiDialog;->sAuxiliaryUiVisible:Z

    if-eqz v1, :cond_1

    .line 110
    :cond_0
    :goto_0
    return v0

    .line 106
    :cond_1
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    sget-wide v4, Lcom/mrkeyboard/app/MrAiDialog;->sLeftAuxiliaryAt:J

    sub-long/2addr v2, v4

    const-wide/32 v4, 0x1d4c0

    cmp-long v1, v2, v4

    if-lez v1, :cond_2

    .line 107
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->cancelReopenOnReturn()V

    goto :goto_0

    .line 110
    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method static setAuxiliaryUiVisible(Z)V
    .locals 2

    .prologue
    .line 94
    sput-boolean p0, Lcom/mrkeyboard/app/MrAiDialog;->sAuxiliaryUiVisible:Z

    .line 95
    if-eqz p0, :cond_0

    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    .line 97
    :goto_0
    return-void

    .line 96
    :cond_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    sput-wide v0, Lcom/mrkeyboard/app/MrAiDialog;->sLeftAuxiliaryAt:J

    goto :goto_0
.end method

.method private static showDialog()V
    .locals 10

    .prologue
    const/4 v1, 0x0

    const/4 v2, -0x1

    const/4 v9, 0x1

    .line 216
    sget-object v4, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 217
    if-nez v4, :cond_1

    .line 277
    :cond_0
    :goto_0
    return-void

    .line 218
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 220
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->imeDecor()Landroid/view/View;

    move-result-object v5

    .line 221
    if-eqz v5, :cond_0

    .line 222
    invoke-virtual {v5}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v6

    .line 223
    if-eqz v6, :cond_0

    .line 227
    :try_start_0
    invoke-virtual {v4}, Lcom/mrkeyboard/app/LatinIME;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v3, "Theme.MrKeyboard.Dialog"

    const-string v7, "style"

    .line 228
    invoke-virtual {v4}, Lcom/mrkeyboard/app/LatinIME;->getPackageName()Ljava/lang/String;

    move-result-object v8

    .line 227
    invoke-virtual {v0, v3, v7, v8}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 229
    if-nez v0, :cond_6

    const v0, 0x7f0d00a1

    move v3, v0

    .line 230
    :goto_1
    new-instance v0, Landroid/app/Dialog;

    invoke-direct {v0, v4, v3}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    .line 231
    const/4 v1, 0x1

    :try_start_1
    invoke-virtual {v0, v1}, Landroid/app/Dialog;->requestWindowFeature(I)Z

    .line 233
    invoke-virtual {v0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v3, "mr_ai_dialog"

    const-string v7, "layout"

    .line 234
    invoke-virtual {v4}, Lcom/mrkeyboard/app/LatinIME;->getPackageName()Ljava/lang/String;

    move-result-object v4

    .line 233
    invoke-virtual {v1, v3, v7, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 235
    if-nez v1, :cond_2

    const v1, 0x7f0a0042

    .line 236
    :cond_2
    invoke-virtual {v0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrLocaleCtx;->of(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v3

    const/4 v4, 0x0

    .line 237
    invoke-virtual {v3, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 238
    const-string v3, "ai_card"

    invoke-virtual {v1, v3}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v3

    .line 239
    if-eqz v3, :cond_0

    .line 241
    new-instance v4, Lcom/mrkeyboard/app/MrAiDialog;

    invoke-direct {v4}, Lcom/mrkeyboard/app/MrAiDialog;-><init>()V

    .line 242
    sput-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    .line 243
    sput-object v5, Lcom/mrkeyboard/app/MrAiDialog;->sImeDecor:Landroid/view/View;

    .line 244
    sput-object v4, Lcom/mrkeyboard/app/MrAiDialog;->sListener:Lcom/mrkeyboard/app/MrAiDialog;

    .line 245
    invoke-virtual {v1, v4}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 246
    const/4 v7, 0x1

    invoke-virtual {v3, v7}, Landroid/view/View;->setClickable(Z)V

    .line 247
    const/4 v3, 0x1

    invoke-virtual {v0, v3}, Landroid/app/Dialog;->setCancelable(Z)V

    .line 248
    const/4 v3, 0x1

    invoke-virtual {v0, v3}, Landroid/app/Dialog;->setCanceledOnTouchOutside(Z)V

    .line 249
    invoke-virtual {v0, v4}, Landroid/app/Dialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    .line 250
    invoke-virtual {v0, v1}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 251
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->setup(Landroid/view/View;)V

    .line 253
    invoke-virtual {v0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v3

    .line 254
    if-nez v3, :cond_3

    .line 255
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    .line 273
    :catch_0
    move-exception v1

    .line 274
    :goto_2
    if-eqz v0, :cond_5

    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    if-ne v0, v1, :cond_5

    invoke-static {v0, v9}, Lcom/mrkeyboard/app/MrAiDialog;->close(Landroid/app/Dialog;Z)V

    goto/16 :goto_0

    .line 258
    :cond_3
    :try_start_2
    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    const/4 v7, 0x0

    invoke-direct {v1, v7}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v3, v1}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 259
    const/4 v1, 0x2

    invoke-virtual {v3, v1}, Landroid/view/Window;->clearFlags(I)V

    .line 260
    const/high16 v1, 0x20000

    invoke-virtual {v3, v1}, Landroid/view/Window;->clearFlags(I)V

    .line 261
    const/16 v1, 0x308

    invoke-virtual {v3, v1}, Landroid/view/Window;->addFlags(I)V

    .line 262
    invoke-virtual {v3}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v7

    .line 263
    iput-object v6, v7, Landroid/view/WindowManager$LayoutParams;->token:Landroid/os/IBinder;

    .line 264
    const/16 v1, 0x3eb

    iput v1, v7, Landroid/view/WindowManager$LayoutParams;->type:I

    .line 265
    const/16 v1, 0x37

    iput v1, v7, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 266
    const/4 v1, -0x1

    iput v1, v7, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 267
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->imeTop()I

    move-result v1

    .line 268
    if-lez v1, :cond_4

    :goto_3
    iput v1, v7, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 269
    invoke-virtual {v3, v7}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    .line 271
    invoke-virtual {v5, v4}, Landroid/view/View;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    .line 272
    invoke-virtual {v0}, Landroid/app/Dialog;->show()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto/16 :goto_0

    :cond_4
    move v1, v2

    .line 268
    goto :goto_3

    .line 275
    :cond_5
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->dialogClosed()V

    goto/16 :goto_0

    .line 273
    :catch_1
    move-exception v0

    move-object v0, v1

    goto :goto_2

    :cond_6
    move v3, v0

    goto/16 :goto_1
.end method

.method private static showKeyboard()V
    .locals 3

    .prologue
    .line 139
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 140
    if-eqz v0, :cond_0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1c

    if-ge v1, v2, :cond_1

    .line 146
    :cond_0
    :goto_0
    return-void

    .line 142
    :cond_1
    :try_start_0
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAiDialog$Api28;->show(Landroid/inputmethodservice/InputMethodService;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 143
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static toggle()V
    .locals 1

    .prologue
    .line 51
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 52
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 59
    :goto_0
    return-void

    .line 54
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->showDialog()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 56
    :catch_0
    move-exception v0

    .line 57
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    goto :goto_0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0

    .prologue
    .line 296
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 297
    return-void
.end method

.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 2

    .prologue
    .line 300
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    if-ne p1, v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAiDialog;->close(Landroid/app/Dialog;Z)V

    .line 301
    :cond_0
    return-void
.end method

.method public onLayoutChange(Landroid/view/View;IIIIIIII)V
    .locals 4

    .prologue
    .line 305
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    .line 306
    if-nez v0, :cond_1

    .line 320
    :cond_0
    :goto_0
    return-void

    .line 308
    :cond_1
    :try_start_0
    invoke-virtual {v0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    .line 309
    if-eqz v1, :cond_0

    .line 310
    invoke-virtual {v1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v2

    .line 311
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->imeTop()I

    move-result v0

    .line 312
    if-gtz v0, :cond_2

    const/4 v0, -0x1

    .line 313
    :cond_2
    iget v3, v2, Landroid/view/WindowManager$LayoutParams;->height:I

    if-eq v3, v0, :cond_0

    .line 314
    iput v0, v2, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 315
    invoke-virtual {v1, v2}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 317
    :catch_0
    move-exception v0

    goto :goto_0
.end method
