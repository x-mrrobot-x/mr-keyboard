.class final Lcom/mrkeyboard/app/MrAiDialog;
.super Ljava/lang/Object;
.source "MrAiDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnLayoutChangeListener;
.implements Landroid/content/DialogInterface$OnDismissListener;


# static fields
.field private static sAuxiliaryUiVisible:Z

.field private static sDialog:Landroid/app/Dialog;

.field private static sImeDecor:Landroid/view/View;

.field private static sListener:Lcom/mrkeyboard/app/MrAiDialog;

.field private static sReopenAfterAuxiliaryUi:Z

.field private static sReturnPackage:Ljava/lang/String;

.field private static sSawAuxiliaryUi:Z


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static cancelReopenOnReturn()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 66
    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    .line 67
    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sAuxiliaryUiVisible:Z

    .line 68
    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    .line 69
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    .line 70
    return-void
.end method

.method private static close(Landroid/app/Dialog;Z)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 110
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sImeDecor:Landroid/view/View;

    .line 111
    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sListener:Lcom/mrkeyboard/app/MrAiDialog;

    .line 112
    sput-object v2, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    .line 113
    sput-object v2, Lcom/mrkeyboard/app/MrAiDialog;->sImeDecor:Landroid/view/View;

    .line 114
    sput-object v2, Lcom/mrkeyboard/app/MrAiDialog;->sListener:Lcom/mrkeyboard/app/MrAiDialog;

    .line 115
    if-eqz v0, :cond_0

    if-eqz v1, :cond_0

    .line 117
    :try_start_0
    invoke-virtual {v0, v1}, Landroid/view/View;->removeOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 122
    :cond_0
    :goto_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->dialogClosed()V

    .line 123
    if-eqz p1, :cond_1

    if-eqz p0, :cond_1

    .line 125
    :try_start_1
    invoke-virtual {p0}, Landroid/app/Dialog;->dismiss()V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    .line 130
    :cond_1
    :goto_1
    return-void

    .line 118
    :catch_0
    move-exception v0

    goto :goto_0

    .line 126
    :catch_1
    move-exception v0

    goto :goto_1
.end method

.method static dismiss()V
    .locals 2

    .prologue
    .line 47
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAiDialog;->close(Landroid/app/Dialog;Z)V

    .line 48
    return-void
.end method

.method private static imeDecor()Landroid/view/View;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 197
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 198
    if-nez v1, :cond_1

    .line 201
    :cond_0
    :goto_0
    return-object v0

    .line 199
    :cond_1
    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getWindow()Landroid/app/Dialog;

    move-result-object v1

    .line 200
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 201
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

    .line 205
    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sImeDecor:Landroid/view/View;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sImeDecor:Landroid/view/View;

    .line 206
    :goto_0
    if-nez v1, :cond_2

    .line 209
    :cond_0
    :goto_1
    return v0

    .line 205
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->imeDecor()Landroid/view/View;

    move-result-object v1

    goto :goto_0

    .line 207
    :cond_2
    const/4 v2, 0x2

    new-array v2, v2, [I

    .line 208
    invoke-virtual {v1, v2}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 209
    aget v1, v2, v3

    if-lez v1, :cond_0

    aget v0, v2, v3

    goto :goto_1
.end method

.method static onImeWindowShown()V
    .locals 2

    .prologue
    .line 80
    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sAuxiliaryUiVisible:Z

    if-eqz v0, :cond_1

    .line 87
    :cond_0
    :goto_0
    return-void

    .line 81
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 82
    if-eqz v0, :cond_0

    .line 83
    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v0

    .line 84
    if-eqz v0, :cond_0

    .line 85
    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    if-eqz v1, :cond_2

    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    iget-object v0, v0, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 86
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->reopenPendingDialog()V

    goto :goto_0
.end method

.method static onInputViewStarted(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 91
    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sAuxiliaryUiVisible:Z

    if-nez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    if-eqz v0, :cond_0

    if-nez p0, :cond_1

    .line 99
    :cond_0
    :goto_0
    return-void

    .line 93
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 94
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getPackageName()Ljava/lang/String;

    move-result-object v0

    .line 95
    :goto_1
    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    if-eqz v0, :cond_2

    .line 96
    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 97
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->cancelReopenOnReturn()V

    goto :goto_0

    .line 94
    :cond_3
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private static reopenPendingDialog()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 102
    sget-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    if-nez v0, :cond_0

    .line 107
    :goto_0
    return-void

    .line 103
    :cond_0
    sput-boolean v1, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    .line 104
    sput-boolean v1, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    .line 105
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    .line 106
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->showDialog()V

    goto :goto_0
.end method

.method static requestReopenOnReturn()V
    .locals 3

    .prologue
    const/4 v0, 0x0

    const/4 v2, 0x0

    .line 52
    const/4 v1, 0x1

    sput-boolean v1, Lcom/mrkeyboard/app/MrAiDialog;->sReopenAfterAuxiliaryUi:Z

    .line 53
    sput-boolean v2, Lcom/mrkeyboard/app/MrAiDialog;->sAuxiliaryUiVisible:Z

    .line 54
    sput-boolean v2, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    .line 55
    sput-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;

    .line 57
    :try_start_0
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 58
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v0

    .line 59
    :cond_0
    if-eqz v0, :cond_1

    iget-object v0, v0, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sReturnPackage:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 63
    :cond_1
    :goto_0
    return-void

    .line 60
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static setAuxiliaryUiVisible(Z)V
    .locals 1

    .prologue
    .line 74
    sput-boolean p0, Lcom/mrkeyboard/app/MrAiDialog;->sAuxiliaryUiVisible:Z

    .line 75
    if-eqz p0, :cond_0

    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrAiDialog;->sSawAuxiliaryUi:Z

    .line 76
    :cond_0
    return-void
.end method

.method private static showDialog()V
    .locals 10

    .prologue
    const/4 v1, 0x0

    const/4 v2, -0x1

    const/4 v9, 0x1

    .line 133
    sget-object v4, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 134
    if-nez v4, :cond_1

    .line 194
    :cond_0
    :goto_0
    return-void

    .line 135
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 137
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->imeDecor()Landroid/view/View;

    move-result-object v5

    .line 138
    if-eqz v5, :cond_0

    .line 139
    invoke-virtual {v5}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v6

    .line 140
    if-eqz v6, :cond_0

    .line 144
    :try_start_0
    invoke-virtual {v4}, Lcom/mrkeyboard/app/LatinIME;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v3, "Theme.MrKeyboard.Dialog"

    const-string v7, "style"

    .line 145
    invoke-virtual {v4}, Lcom/mrkeyboard/app/LatinIME;->getPackageName()Ljava/lang/String;

    move-result-object v8

    .line 144
    invoke-virtual {v0, v3, v7, v8}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 146
    if-nez v0, :cond_6

    const v0, 0x7f0d00a1

    move v3, v0

    .line 147
    :goto_1
    new-instance v0, Landroid/app/Dialog;

    invoke-direct {v0, v4, v3}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    .line 148
    const/4 v1, 0x1

    :try_start_1
    invoke-virtual {v0, v1}, Landroid/app/Dialog;->requestWindowFeature(I)Z

    .line 150
    invoke-virtual {v0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v3, "mr_ai_dialog"

    const-string v7, "layout"

    .line 151
    invoke-virtual {v4}, Lcom/mrkeyboard/app/LatinIME;->getPackageName()Ljava/lang/String;

    move-result-object v4

    .line 150
    invoke-virtual {v1, v3, v7, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 152
    if-nez v1, :cond_2

    const v1, 0x7f0a0042

    .line 153
    :cond_2
    invoke-virtual {v0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrLocaleCtx;->of(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v3

    const/4 v4, 0x0

    .line 154
    invoke-virtual {v3, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 155
    const-string v3, "ai_card"

    invoke-virtual {v1, v3}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v3

    .line 156
    if-eqz v3, :cond_0

    .line 158
    new-instance v4, Lcom/mrkeyboard/app/MrAiDialog;

    invoke-direct {v4}, Lcom/mrkeyboard/app/MrAiDialog;-><init>()V

    .line 159
    sput-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    .line 160
    sput-object v5, Lcom/mrkeyboard/app/MrAiDialog;->sImeDecor:Landroid/view/View;

    .line 161
    sput-object v4, Lcom/mrkeyboard/app/MrAiDialog;->sListener:Lcom/mrkeyboard/app/MrAiDialog;

    .line 162
    invoke-virtual {v1, v4}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 163
    const/4 v7, 0x1

    invoke-virtual {v3, v7}, Landroid/view/View;->setClickable(Z)V

    .line 164
    const/4 v3, 0x1

    invoke-virtual {v0, v3}, Landroid/app/Dialog;->setCancelable(Z)V

    .line 165
    const/4 v3, 0x1

    invoke-virtual {v0, v3}, Landroid/app/Dialog;->setCanceledOnTouchOutside(Z)V

    .line 166
    invoke-virtual {v0, v4}, Landroid/app/Dialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    .line 167
    invoke-virtual {v0, v1}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 168
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->setup(Landroid/view/View;)V

    .line 170
    invoke-virtual {v0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v3

    .line 171
    if-nez v3, :cond_3

    .line 172
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    .line 190
    :catch_0
    move-exception v1

    .line 191
    :goto_2
    if-eqz v0, :cond_5

    sget-object v1, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    if-ne v0, v1, :cond_5

    invoke-static {v0, v9}, Lcom/mrkeyboard/app/MrAiDialog;->close(Landroid/app/Dialog;Z)V

    goto/16 :goto_0

    .line 175
    :cond_3
    :try_start_2
    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    const/4 v7, 0x0

    invoke-direct {v1, v7}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v3, v1}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 176
    const/4 v1, 0x2

    invoke-virtual {v3, v1}, Landroid/view/Window;->clearFlags(I)V

    .line 177
    const/high16 v1, 0x20000

    invoke-virtual {v3, v1}, Landroid/view/Window;->clearFlags(I)V

    .line 178
    const/16 v1, 0x308

    invoke-virtual {v3, v1}, Landroid/view/Window;->addFlags(I)V

    .line 179
    invoke-virtual {v3}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v7

    .line 180
    iput-object v6, v7, Landroid/view/WindowManager$LayoutParams;->token:Landroid/os/IBinder;

    .line 181
    const/16 v1, 0x3eb

    iput v1, v7, Landroid/view/WindowManager$LayoutParams;->type:I

    .line 182
    const/16 v1, 0x37

    iput v1, v7, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 183
    const/4 v1, -0x1

    iput v1, v7, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 184
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->imeTop()I

    move-result v1

    .line 185
    if-lez v1, :cond_4

    :goto_3
    iput v1, v7, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 186
    invoke-virtual {v3, v7}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    .line 188
    invoke-virtual {v5, v4}, Landroid/view/View;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    .line 189
    invoke-virtual {v0}, Landroid/app/Dialog;->show()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto/16 :goto_0

    :cond_4
    move v1, v2

    .line 185
    goto :goto_3

    .line 192
    :cond_5
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->dialogClosed()V

    goto/16 :goto_0

    .line 190
    :catch_1
    move-exception v0

    move-object v0, v1

    goto :goto_2

    :cond_6
    move v3, v0

    goto/16 :goto_1
.end method

.method static toggle()V
    .locals 1

    .prologue
    .line 35
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 36
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 43
    :goto_0
    return-void

    .line 38
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->showDialog()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 40
    :catch_0
    move-exception v0

    .line 41
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    goto :goto_0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0

    .prologue
    .line 213
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 214
    return-void
.end method

.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 2

    .prologue
    .line 217
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    if-ne p1, v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAiDialog;->close(Landroid/app/Dialog;Z)V

    .line 218
    :cond_0
    return-void
.end method

.method public onLayoutChange(Landroid/view/View;IIIIIIII)V
    .locals 4

    .prologue
    .line 222
    sget-object v0, Lcom/mrkeyboard/app/MrAiDialog;->sDialog:Landroid/app/Dialog;

    .line 223
    if-nez v0, :cond_1

    .line 237
    :cond_0
    :goto_0
    return-void

    .line 225
    :cond_1
    :try_start_0
    invoke-virtual {v0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    .line 226
    if-eqz v1, :cond_0

    .line 227
    invoke-virtual {v1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v2

    .line 228
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->imeTop()I

    move-result v0

    .line 229
    if-gtz v0, :cond_2

    const/4 v0, -0x1

    .line 230
    :cond_2
    iget v3, v2, Landroid/view/WindowManager$LayoutParams;->height:I

    if-eq v3, v0, :cond_0

    .line 231
    iput v0, v2, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 232
    invoke-virtual {v1, v2}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 234
    :catch_0
    move-exception v0

    goto :goto_0
.end method
