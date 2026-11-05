.class final Lcom/mrkeyboard/app/MrUpdateDialog;
.super Ljava/lang/Object;
.source "MrUpdateDialog.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrUpdateDialog$Box;,
        Lcom/mrkeyboard/app/MrUpdateDialog$Click;,
        Lcom/mrkeyboard/app/MrUpdateDialog$Ui;
    }
.end annotation


# static fields
.field private static final BTN_GITHUB:I = 0x2

.field private static final BTN_INSTALL:I = 0x1

.field private static final BTN_LATER:I = 0x3

.field static final ERROR:I = 0xc

.field static final NOTES:I = 0xa

.field static final PERMISSION:I = 0xb

.field static sAsked:Lcom/mrkeyboard/app/MrUpdate$Notice;

.field static sAskedCount:I

.field private static sAwaiting:Z

.field private static sCode:J

.field private static sDialog:Landroid/app/Dialog;

.field private static sNotice:Lcom/mrkeyboard/app/MrUpdate$Notice;

.field private static sOwner:Landroid/app/Activity;

.field private static sRoot:Landroid/view/View;

.field private static sState:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 47
    const/16 v0, 0xa

    sput v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sState:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()V
    .locals 0

    .prologue
    .line 32
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateDialog;->resumeAfterSettings()V

    return-void
.end method

.method static synthetic access$100()Landroid/app/Activity;
    .locals 1

    .prologue
    .line 32
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sOwner:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$200()J
    .locals 2

    .prologue
    .line 32
    sget-wide v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sCode:J

    return-wide v0
.end method

.method static synthetic access$300()Landroid/app/Dialog;
    .locals 1

    .prologue
    .line 32
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sDialog:Landroid/app/Dialog;

    return-object v0
.end method

.method static synthetic access$600()I
    .locals 1

    .prologue
    .line 32
    sget v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sState:I

    return v0
.end method

.method static synthetic access$700(Landroid/app/Activity;)V
    .locals 0

    .prologue
    .line 32
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateDialog;->openSettings(Landroid/app/Activity;)V

    return-void
.end method

.method static begin(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;)V
    .locals 4

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 205
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateInstall;->canInstall(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 206
    const/16 v0, 0xb

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrUpdateDialog;->setState(IILjava/lang/String;)V

    .line 212
    :goto_0
    return-void

    .line 209
    :cond_0
    sput-boolean v1, Lcom/mrkeyboard/app/MrUpdateDialog;->sAwaiting:Z

    .line 210
    const/4 v0, 0x1

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrUpdateDialog;->setState(IILjava/lang/String;)V

    .line 211
    invoke-virtual {p0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;

    iget-wide v2, p1, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionCode:J

    invoke-direct {v1, p0, v2, v3}, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;-><init>(Landroid/app/Activity;J)V

    invoke-static {v0, p1, v1}, Lcom/mrkeyboard/app/MrUpdateInstall;->start(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;Lcom/mrkeyboard/app/MrUpdateInstall$Listener;)Z

    goto :goto_0
.end method

.method static dismiss()V
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 61
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sDialog:Landroid/app/Dialog;

    .line 62
    sput-object v1, Lcom/mrkeyboard/app/MrUpdateDialog;->sDialog:Landroid/app/Dialog;

    .line 63
    sput-object v1, Lcom/mrkeyboard/app/MrUpdateDialog;->sRoot:Landroid/view/View;

    .line 64
    sput-object v1, Lcom/mrkeyboard/app/MrUpdateDialog;->sOwner:Landroid/app/Activity;

    .line 65
    sput-object v1, Lcom/mrkeyboard/app/MrUpdateDialog;->sNotice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    .line 66
    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/mrkeyboard/app/MrUpdateDialog;->sCode:J

    .line 67
    const/16 v1, 0xa

    sput v1, Lcom/mrkeyboard/app/MrUpdateDialog;->sState:I

    .line 68
    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrUpdateDialog;->sAwaiting:Z

    .line 69
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall;->cancel()V

    .line 70
    if-eqz v0, :cond_0

    .line 72
    :try_start_0
    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 77
    :cond_0
    :goto_0
    return-void

    .line 73
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static errorText(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdateInstall$Failure;)Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v3, 0x1

    const/4 v5, 0x0

    .line 152
    iget-object v0, p1, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;->reasonKey:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p1, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;->key:Ljava/lang/String;

    new-array v1, v3, [Ljava/lang/Object;

    iget-object v2, p1, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;->reasonKey:Ljava/lang/String;

    new-array v3, v3, [Ljava/lang/Object;

    iget v4, p1, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;->arg:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v5

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v1, v5

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 153
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p1, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;->key:Ljava/lang/String;

    new-array v1, v5, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static fill(Landroid/app/Activity;Landroid/view/View;Lcom/mrkeyboard/app/MrUpdate$Notice;)Z
    .locals 12

    .prologue
    .line 126
    const-string v0, "upd_sub"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 127
    const-string v1, "upd_notes"

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    .line 128
    const-string v2, "upd_install"

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    .line 129
    const-string v3, "upd_github"

    invoke-virtual {p1, v3}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v3

    .line 130
    const-string v4, "upd_later"

    invoke-virtual {p1, v4}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v4

    .line 131
    if-eqz v0, :cond_0

    if-eqz v1, :cond_0

    if-eqz v2, :cond_0

    if-eqz v3, :cond_0

    if-nez v4, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 142
    :goto_0
    return v0

    .line 132
    :cond_1
    const-string v5, "upd_title"

    invoke-virtual {p1, v5}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v5

    if-eqz v5, :cond_2

    const-string v5, "upd_scroll"

    invoke-virtual {p1, v5}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v5

    if-eqz v5, :cond_2

    const-string v5, "upd_box"

    .line 133
    invoke-virtual {p1, v5}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v5

    if-eqz v5, :cond_2

    const-string v5, "upd_status"

    invoke-virtual {p1, v5}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v5

    if-eqz v5, :cond_2

    const-string v5, "upd_bar"

    .line 134
    invoke-virtual {p1, v5}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v5

    if-eqz v5, :cond_2

    const-string v5, "upd_error"

    invoke-virtual {p1, v5}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v5

    if-nez v5, :cond_3

    :cond_2
    const/4 v0, 0x0

    goto :goto_0

    .line 135
    :cond_3
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v5

    iget-object v5, v5, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 136
    const-string v6, "mr_update_sub"

    const/4 v7, 0x3

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v8, 0x0

    iget-object v9, p2, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionName:Ljava/lang/String;

    aput-object v9, v7, v8

    const/4 v8, 0x1

    iget-wide v10, p2, Lcom/mrkeyboard/app/MrUpdate$Notice;->apkSize:J

    invoke-static {v10, v11, v5}, Lcom/mrkeyboard/app/MrUpdate;->sizeText(JLjava/util/Locale;)Ljava/lang/String;

    move-result-object v9

    aput-object v9, v7, v8

    const/4 v8, 0x2

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->appName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v9

    aput-object v9, v7, v8

    invoke-static {p0, v6, v7}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 137
    invoke-virtual {p2, v5}, Lcom/mrkeyboard/app/MrUpdate$Notice;->notes(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 138
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_4

    :goto_1
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 139
    new-instance v0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;

    const/4 v1, 0x1

    invoke-direct {v0, p0, p2, v1}, Lcom/mrkeyboard/app/MrUpdateDialog$Click;-><init>(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;I)V

    invoke-virtual {v2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 140
    new-instance v0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;

    const/4 v1, 0x2

    invoke-direct {v0, p0, p2, v1}, Lcom/mrkeyboard/app/MrUpdateDialog$Click;-><init>(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;I)V

    invoke-virtual {v3, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 141
    new-instance v0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;

    const/4 v1, 0x3

    invoke-direct {v0, p0, p2, v1}, Lcom/mrkeyboard/app/MrUpdateDialog$Click;-><init>(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;I)V

    invoke-virtual {v4, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 142
    const/4 v0, 0x1

    goto/16 :goto_0

    .line 138
    :cond_4
    const-string v0, "mr_update_notes_none"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-static {p0, v0, v5}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method private static label(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 163
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateDialog;->view(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 164
    instance-of v1, v0, Landroid/widget/TextView;

    if-eqz v1, :cond_0

    check-cast v0, Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 165
    :cond_0
    return-void
.end method

.method private static openSettings(Landroid/app/Activity;)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 224
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sAwaiting:Z

    .line 226
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateInstall;->settingsIntent(Landroid/content/Context;)Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 231
    :goto_0
    return-void

    .line 227
    :catch_0
    move-exception v0

    .line 228
    sput-boolean v3, Lcom/mrkeyboard/app/MrUpdateDialog;->sAwaiting:Z

    .line 229
    const/16 v0, 0xc

    const-string v1, "mr_update_err_install"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v3, v1}, Lcom/mrkeyboard/app/MrUpdateDialog;->setState(IILjava/lang/String;)V

    goto :goto_0
.end method

.method static release(Landroid/app/Activity;)V
    .locals 1

    .prologue
    .line 81
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sOwner:Landroid/app/Activity;

    if-ne v0, p0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateDialog;->dismiss()V

    .line 82
    :cond_0
    return-void
.end method

.method private static resumeAfterSettings()V
    .locals 4

    .prologue
    .line 216
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sOwner:Landroid/app/Activity;

    .line 217
    sget-object v1, Lcom/mrkeyboard/app/MrUpdateDialog;->sNotice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    .line 218
    sget-boolean v2, Lcom/mrkeyboard/app/MrUpdateDialog;->sAwaiting:Z

    if-eqz v2, :cond_0

    if-eqz v0, :cond_0

    if-nez v1, :cond_1

    .line 221
    :cond_0
    :goto_0
    return-void

    .line 219
    :cond_1
    const/4 v2, 0x0

    sput-boolean v2, Lcom/mrkeyboard/app/MrUpdateDialog;->sAwaiting:Z

    .line 220
    sget v2, Lcom/mrkeyboard/app/MrUpdateDialog;->sState:I

    const/16 v3, 0xb

    if-ne v2, v3, :cond_0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateInstall;->canInstall(Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrUpdateDialog;->begin(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    goto :goto_0
.end method

.method static setState(IILjava/lang/String;)V
    .locals 11

    .prologue
    const/16 v10, 0xb

    const/4 v9, 0x3

    const/4 v8, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 174
    sget-object v6, Lcom/mrkeyboard/app/MrUpdateDialog;->sOwner:Landroid/app/Activity;

    .line 175
    if-eqz v6, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sRoot:Landroid/view/View;

    if-nez v0, :cond_1

    .line 201
    :cond_0
    :goto_0
    return-void

    .line 176
    :cond_1
    sput p0, Lcom/mrkeyboard/app/MrUpdateDialog;->sState:I

    .line 177
    if-eq p0, v3, :cond_2

    if-eq p0, v8, :cond_2

    if-ne p0, v9, :cond_8

    :cond_2
    move v5, v3

    .line 179
    :goto_1
    if-eq p0, v3, :cond_3

    if-ne p0, v8, :cond_9

    :cond_3
    move v1, v3

    .line 180
    :goto_2
    const-string v4, "upd_title"

    if-ne p0, v10, :cond_a

    const-string v0, "mr_update_perm_title"

    :goto_3
    new-array v7, v2, [Ljava/lang/Object;

    invoke-static {v6, v0, v7}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Lcom/mrkeyboard/app/MrUpdateDialog;->label(Ljava/lang/String;Ljava/lang/String;)V

    .line 181
    const-string v4, "upd_scroll"

    const/16 v0, 0xa

    if-ne p0, v0, :cond_b

    move v0, v3

    :goto_4
    invoke-static {v4, v0}, Lcom/mrkeyboard/app/MrUpdateDialog;->visible(Ljava/lang/String;Z)V

    .line 182
    const-string v4, "upd_box"

    const/16 v0, 0xa

    if-eq p0, v0, :cond_c

    const/16 v0, 0xc

    if-eq p0, v0, :cond_c

    move v0, v3

    :goto_5
    invoke-static {v4, v0}, Lcom/mrkeyboard/app/MrUpdateDialog;->visible(Ljava/lang/String;Z)V

    .line 183
    const-string v4, "upd_error"

    const/16 v0, 0xc

    if-ne p0, v0, :cond_d

    move v0, v3

    :goto_6
    invoke-static {v4, v0}, Lcom/mrkeyboard/app/MrUpdateDialog;->visible(Ljava/lang/String;Z)V

    .line 184
    const/16 v0, 0xc

    if-ne p0, v0, :cond_4

    const-string v0, "upd_error"

    if-eqz p2, :cond_e

    :goto_7
    invoke-static {v0, p2}, Lcom/mrkeyboard/app/MrUpdateDialog;->label(Ljava/lang/String;Ljava/lang/String;)V

    .line 185
    :cond_4
    const-string v0, "upd_bar"

    invoke-static {v0, v5}, Lcom/mrkeyboard/app/MrUpdateDialog;->visible(Ljava/lang/String;Z)V

    .line 186
    const-string v0, "upd_bar"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateDialog;->view(Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 187
    instance-of v4, v0, Landroid/widget/ProgressBar;

    if-eqz v4, :cond_6

    .line 188
    check-cast v0, Landroid/widget/ProgressBar;

    .line 189
    if-eq p0, v8, :cond_5

    if-ne p0, v9, :cond_f

    :cond_5
    move v4, v3

    :goto_8
    invoke-virtual {v0, v4}, Landroid/widget/ProgressBar;->setIndeterminate(Z)V

    .line 190
    invoke-virtual {v0, p1}, Landroid/widget/ProgressBar;->setProgress(I)V

    .line 192
    :cond_6
    if-ne p0, v10, :cond_10

    const-string v0, "upd_status"

    const-string v4, "mr_update_perm_text"

    new-array v7, v2, [Ljava/lang/Object;

    invoke-static {v6, v4, v7}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrUpdateDialog;->label(Ljava/lang/String;Ljava/lang/String;)V

    .line 196
    :cond_7
    :goto_9
    const-string v4, "upd_install"

    if-nez v5, :cond_13

    move v0, v3

    :goto_a
    invoke-static {v4, v0}, Lcom/mrkeyboard/app/MrUpdateDialog;->visible(Ljava/lang/String;Z)V

    .line 197
    const-string v4, "upd_install"

    if-ne p0, v10, :cond_14

    const-string v0, "mr_update_open_settings"

    :goto_b
    new-array v7, v2, [Ljava/lang/Object;

    invoke-static {v6, v0, v7}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Lcom/mrkeyboard/app/MrUpdateDialog;->label(Ljava/lang/String;Ljava/lang/String;)V

    .line 198
    const-string v4, "upd_github"

    if-nez v5, :cond_15

    move v0, v3

    :goto_c
    invoke-static {v4, v0}, Lcom/mrkeyboard/app/MrUpdateDialog;->visible(Ljava/lang/String;Z)V

    .line 199
    const-string v4, "upd_later"

    if-eqz v1, :cond_16

    const-string v0, "mr_update_cancel"

    :goto_d
    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {v6, v0, v1}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Lcom/mrkeyboard/app/MrUpdateDialog;->label(Ljava/lang/String;Ljava/lang/String;)V

    .line 200
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sDialog:Landroid/app/Dialog;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sDialog:Landroid/app/Dialog;

    if-nez v5, :cond_17

    :goto_e
    invoke-virtual {v0, v3}, Landroid/app/Dialog;->setCanceledOnTouchOutside(Z)V

    goto/16 :goto_0

    :cond_8
    move v5, v2

    .line 177
    goto/16 :goto_1

    :cond_9
    move v1, v2

    .line 179
    goto/16 :goto_2

    .line 180
    :cond_a
    const-string v0, "mr_update_title"

    goto/16 :goto_3

    :cond_b
    move v0, v2

    .line 181
    goto/16 :goto_4

    :cond_c
    move v0, v2

    .line 182
    goto/16 :goto_5

    :cond_d
    move v0, v2

    .line 183
    goto/16 :goto_6

    .line 184
    :cond_e
    const-string p2, ""

    goto :goto_7

    :cond_f
    move v4, v2

    .line 189
    goto :goto_8

    .line 193
    :cond_10
    if-ne p0, v3, :cond_11

    const-string v0, "upd_status"

    const-string v4, "mr_update_downloading"

    new-array v7, v3, [Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v7, v2

    invoke-static {v6, v4, v7}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrUpdateDialog;->label(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_9

    .line 194
    :cond_11
    if-ne p0, v8, :cond_12

    const-string v0, "upd_status"

    const-string v4, "mr_update_verifying"

    new-array v7, v2, [Ljava/lang/Object;

    invoke-static {v6, v4, v7}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrUpdateDialog;->label(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_9

    .line 195
    :cond_12
    if-ne p0, v9, :cond_7

    const-string v0, "upd_status"

    const-string v4, "mr_update_installing"

    new-array v7, v2, [Ljava/lang/Object;

    invoke-static {v6, v4, v7}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrUpdateDialog;->label(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_9

    :cond_13
    move v0, v2

    .line 196
    goto/16 :goto_a

    .line 197
    :cond_14
    const-string v0, "mr_update_install"

    goto/16 :goto_b

    :cond_15
    move v0, v2

    .line 198
    goto :goto_c

    .line 199
    :cond_16
    const-string v0, "mr_update_later"

    goto :goto_d

    :cond_17
    move v3, v2

    .line 200
    goto :goto_e
.end method

.method static show(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;)V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 86
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 122
    :cond_0
    :goto_0
    return-void

    .line 87
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateDialog;->showing()Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sOwner:Landroid/app/Activity;

    if-ne v0, p0, :cond_2

    sget-wide v2, Lcom/mrkeyboard/app/MrUpdateDialog;->sCode:J

    iget-wide v4, p1, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionCode:J

    cmp-long v0, v2, v4

    if-eqz v0, :cond_0

    .line 88
    :cond_2
    sput-object p1, Lcom/mrkeyboard/app/MrUpdateDialog;->sAsked:Lcom/mrkeyboard/app/MrUpdate$Notice;

    .line 89
    sget v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sAskedCount:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sAskedCount:I

    .line 90
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateDialog;->dismiss()V

    .line 93
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v2, "Theme.MrKeyboard.Dialog"

    const-string v3, "style"

    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 94
    if-nez v0, :cond_3

    const v0, 0x7f0d00a1

    move v2, v0

    .line 95
    :goto_1
    new-instance v0, Lcom/mrkeyboard/app/MrUpdateDialog$Box;

    invoke-direct {v0, p0, v2}, Lcom/mrkeyboard/app/MrUpdateDialog$Box;-><init>(Landroid/app/Activity;I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    .line 96
    const/4 v1, 0x1

    :try_start_1
    invoke-virtual {v0, v1}, Landroid/app/Dialog;->requestWindowFeature(I)Z

    .line 97
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "mr_update_dialog"

    const-string v3, "layout"

    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 98
    if-eqz v1, :cond_0

    .line 99
    invoke-virtual {v0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrLocaleCtx;->of(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v1, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 100
    invoke-static {p0, v1, p1}, Lcom/mrkeyboard/app/MrUpdateDialog;->fill(Landroid/app/Activity;Landroid/view/View;Lcom/mrkeyboard/app/MrUpdate$Notice;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 101
    invoke-virtual {p0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    .line 103
    new-instance v3, Lcom/mrkeyboard/app/MrUpdateDialog$1;

    invoke-direct {v3, v2, p1}, Lcom/mrkeyboard/app/MrUpdateDialog$1;-><init>(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    invoke-virtual {v0, v3}, Landroid/app/Dialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    .line 110
    invoke-virtual {v0, v1}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 111
    sput-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sDialog:Landroid/app/Dialog;

    .line 112
    sput-object v1, Lcom/mrkeyboard/app/MrUpdateDialog;->sRoot:Landroid/view/View;

    .line 113
    sput-object p0, Lcom/mrkeyboard/app/MrUpdateDialog;->sOwner:Landroid/app/Activity;

    .line 114
    sput-object p1, Lcom/mrkeyboard/app/MrUpdateDialog;->sNotice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    .line 115
    iget-wide v2, p1, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionCode:J

    sput-wide v2, Lcom/mrkeyboard/app/MrUpdateDialog;->sCode:J

    .line 116
    const/16 v1, 0xa

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrUpdateDialog;->setState(IILjava/lang/String;)V

    .line 117
    invoke-virtual {v0}, Landroid/app/Dialog;->show()V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    .line 118
    :catch_0
    move-exception v1

    .line 120
    :goto_2
    if-eqz v0, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrUpdateDialog;->sDialog:Landroid/app/Dialog;

    if-ne v0, v1, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateDialog;->dismiss()V

    goto/16 :goto_0

    .line 118
    :catch_1
    move-exception v0

    move-object v0, v1

    goto :goto_2

    :cond_3
    move v2, v0

    goto :goto_1
.end method

.method static showing()Z
    .locals 1

    .prologue
    .line 56
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sDialog:Landroid/app/Dialog;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sDialog:Landroid/app/Dialog;

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

.method static varargs text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 146
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 147
    if-eqz v0, :cond_0

    move-object p1, v0

    :cond_0
    return-object p1
.end method

.method private static view(Ljava/lang/String;)Landroid/view/View;
    .locals 1

    .prologue
    .line 159
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sRoot:Landroid/view/View;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sRoot:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static visible(Ljava/lang/String;Z)V
    .locals 2

    .prologue
    .line 168
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateDialog;->view(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    .line 169
    if-eqz v1, :cond_0

    if-eqz p1, :cond_1

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    .line 170
    :cond_0
    return-void

    .line 169
    :cond_1
    const/16 v0, 0x8

    goto :goto_0
.end method
