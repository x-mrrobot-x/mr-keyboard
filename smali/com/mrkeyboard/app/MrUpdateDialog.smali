.class final Lcom/mrkeyboard/app/MrUpdateDialog;
.super Ljava/lang/Object;
.source "MrUpdateDialog.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrUpdateDialog$Click;
    }
.end annotation


# static fields
.field private static final GITHUB:I = 0x2

.field private static final INSTALL:I = 0x1

.field private static final LATER:I = 0x3

.field static sAsked:Lcom/mrkeyboard/app/MrUpdate$Notice;

.field static sAskedCount:I

.field private static sCode:J

.field private static sDialog:Landroid/app/Dialog;

.field private static sOwner:Landroid/app/Activity;


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static dismiss()V
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 44
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sDialog:Landroid/app/Dialog;

    .line 45
    sput-object v1, Lcom/mrkeyboard/app/MrUpdateDialog;->sDialog:Landroid/app/Dialog;

    .line 46
    sput-object v1, Lcom/mrkeyboard/app/MrUpdateDialog;->sOwner:Landroid/app/Activity;

    .line 47
    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/mrkeyboard/app/MrUpdateDialog;->sCode:J

    .line 48
    if-eqz v0, :cond_0

    .line 50
    :try_start_0
    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 55
    :cond_0
    :goto_0
    return-void

    .line 51
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static fill(Landroid/app/Activity;Landroid/view/View;Lcom/mrkeyboard/app/MrUpdate$Notice;)Z
    .locals 12

    .prologue
    .line 100
    const-string v0, "upd_sub"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 101
    const-string v1, "upd_notes"

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    .line 102
    const-string v2, "upd_install"

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    .line 103
    const-string v3, "upd_github"

    invoke-virtual {p1, v3}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v3

    .line 104
    const-string v4, "upd_later"

    invoke-virtual {p1, v4}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v4

    .line 105
    if-eqz v0, :cond_0

    if-eqz v1, :cond_0

    if-eqz v2, :cond_0

    if-eqz v3, :cond_0

    if-nez v4, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 113
    :goto_0
    return v0

    .line 106
    :cond_1
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v5

    iget-object v5, v5, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 107
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

    .line 108
    invoke-virtual {p2, v5}, Lcom/mrkeyboard/app/MrUpdate$Notice;->notes(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 109
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_2

    :goto_1
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 110
    new-instance v0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;

    const/4 v1, 0x1

    invoke-direct {v0, p0, p2, v1}, Lcom/mrkeyboard/app/MrUpdateDialog$Click;-><init>(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;I)V

    invoke-virtual {v2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 111
    new-instance v0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;

    const/4 v1, 0x2

    invoke-direct {v0, p0, p2, v1}, Lcom/mrkeyboard/app/MrUpdateDialog$Click;-><init>(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;I)V

    invoke-virtual {v3, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 112
    new-instance v0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;

    const/4 v1, 0x3

    invoke-direct {v0, p0, p2, v1}, Lcom/mrkeyboard/app/MrUpdateDialog$Click;-><init>(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;I)V

    invoke-virtual {v4, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 113
    const/4 v0, 0x1

    goto :goto_0

    .line 109
    :cond_2
    const-string v0, "mr_update_notes_none"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-static {p0, v0, v5}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method static install(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;)V
    .locals 1

    .prologue
    .line 126
    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrUpdate$Notice;->apkUrl()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrLink;->open(Landroid/content/Context;Ljava/lang/String;)Z

    .line 127
    return-void
.end method

.method static release(Landroid/app/Activity;)V
    .locals 1

    .prologue
    .line 59
    sget-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sOwner:Landroid/app/Activity;

    if-ne v0, p0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateDialog;->dismiss()V

    .line 60
    :cond_0
    return-void
.end method

.method static show(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;)V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 64
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 96
    :cond_0
    :goto_0
    return-void

    .line 65
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

    .line 66
    :cond_2
    sput-object p1, Lcom/mrkeyboard/app/MrUpdateDialog;->sAsked:Lcom/mrkeyboard/app/MrUpdate$Notice;

    .line 67
    sget v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sAskedCount:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sAskedCount:I

    .line 68
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateDialog;->dismiss()V

    .line 71
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v2, "Theme.MrKeyboard.Dialog"

    const-string v3, "style"

    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 72
    if-nez v0, :cond_3

    const v0, 0x7f0d00a1

    move v2, v0

    .line 73
    :goto_1
    new-instance v0, Landroid/app/Dialog;

    invoke-direct {v0, p0, v2}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    .line 74
    const/4 v1, 0x1

    :try_start_1
    invoke-virtual {v0, v1}, Landroid/app/Dialog;->requestWindowFeature(I)Z

    .line 75
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "mr_update_dialog"

    const-string v3, "layout"

    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 76
    if-eqz v1, :cond_0

    .line 77
    invoke-virtual {v0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrLocaleCtx;->of(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v1, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 78
    invoke-static {p0, v1, p1}, Lcom/mrkeyboard/app/MrUpdateDialog;->fill(Landroid/app/Activity;Landroid/view/View;Lcom/mrkeyboard/app/MrUpdate$Notice;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 79
    invoke-virtual {p0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    .line 81
    new-instance v3, Lcom/mrkeyboard/app/MrUpdateDialog$1;

    invoke-direct {v3, v2, p1}, Lcom/mrkeyboard/app/MrUpdateDialog$1;-><init>(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    invoke-virtual {v0, v3}, Landroid/app/Dialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    .line 86
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Landroid/app/Dialog;->setCanceledOnTouchOutside(Z)V

    .line 87
    invoke-virtual {v0, v1}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 88
    sput-object v0, Lcom/mrkeyboard/app/MrUpdateDialog;->sDialog:Landroid/app/Dialog;

    .line 89
    sput-object p0, Lcom/mrkeyboard/app/MrUpdateDialog;->sOwner:Landroid/app/Activity;

    .line 90
    iget-wide v2, p1, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionCode:J

    sput-wide v2, Lcom/mrkeyboard/app/MrUpdateDialog;->sCode:J

    .line 91
    invoke-virtual {v0}, Landroid/app/Dialog;->show()V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    .line 92
    :catch_0
    move-exception v1

    .line 94
    :goto_2
    if-eqz v0, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrUpdateDialog;->sDialog:Landroid/app/Dialog;

    if-ne v0, v1, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateDialog;->dismiss()V

    goto/16 :goto_0

    .line 92
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
    .line 39
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
    .line 117
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 118
    if-eqz v0, :cond_0

    move-object p1, v0

    :cond_0
    return-object p1
.end method
