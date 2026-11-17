.class public final Lcom/mrkeyboard/app/MrVersion;
.super Ljava/lang/Object;
.source "MrVersion.java"

# interfaces
.implements Landroid/preference/Preference$OnPreferenceClickListener;


# static fields
.field static final ASSET:Ljava/lang/String; = "mr_release_notes.md"

.field static final MARK_EN:Ljava/lang/String; = "**English**"

.field static final MARK_PT:Ljava/lang/String; = "**Portugu\u00eas**"

.field static final MAX_BYTES:I = 0x10000

.field private static sDialog:Landroid/app/Dialog;

.field private static sOwner:Landroid/app/Activity;


# instance fields
.field private final mActivity:Landroid/app/Activity;


# direct methods
.method public constructor <init>(Landroid/app/Activity;)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 40
    iput-object p1, p0, Lcom/mrkeyboard/app/MrVersion;->mActivity:Landroid/app/Activity;

    .line 41
    return-void
.end method

.method static block(Ljava/lang/String;Z)Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v1, -0x1

    .line 107
    const-string v0, "\r\n"

    const-string v2, "\n"

    invoke-virtual {p0, v0, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "\n"

    invoke-virtual {v0, v2, v1}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v4

    .line 110
    const/4 v0, 0x0

    move v2, v1

    :goto_0
    array-length v3, v4

    if-ge v0, v3, :cond_2

    .line 111
    aget-object v3, v4, v0

    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    .line 112
    if-gez v2, :cond_1

    const-string v5, "**Portugu\u00eas**"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    move v2, v0

    .line 110
    :cond_0
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 113
    :cond_1
    if-gez v1, :cond_0

    const-string v5, "**English**"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    move v1, v0

    goto :goto_1

    .line 115
    :cond_2
    if-eqz p1, :cond_3

    move v3, v2

    :goto_2
    if-eqz p1, :cond_4

    move v0, v1

    :goto_3
    invoke-static {v4, v3, v0}, Lcom/mrkeyboard/app/MrVersion;->body([Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v0

    .line 116
    if-eqz v0, :cond_5

    :goto_4
    return-object v0

    :cond_3
    move v3, v1

    .line 115
    goto :goto_2

    :cond_4
    move v0, v2

    goto :goto_3

    .line 116
    :cond_5
    if-eqz p1, :cond_6

    move v0, v1

    :goto_5
    if-eqz p1, :cond_7

    :goto_6
    invoke-static {v4, v0, v2}, Lcom/mrkeyboard/app/MrVersion;->body([Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v0

    goto :goto_4

    :cond_6
    move v0, v2

    goto :goto_5

    :cond_7
    move v2, v1

    goto :goto_6
.end method

.method private static body([Ljava/lang/String;II)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 121
    if-gez p1, :cond_0

    .line 129
    :goto_0
    return-object v1

    .line 122
    :cond_0
    if-le p2, p1, :cond_2

    .line 123
    :goto_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 124
    add-int/lit8 v0, p1, 0x1

    :goto_2
    if-ge v0, p2, :cond_3

    .line 125
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    if-lez v3, :cond_1

    const/16 v3, 0xa

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 126
    :cond_1
    aget-object v3, p0, v0

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 124
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 122
    :cond_2
    array-length p2, p0

    goto :goto_1

    .line 128
    :cond_3
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 129
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_4

    :goto_3
    move-object v1, v0

    goto :goto_0

    :cond_4
    move-object v0, v1

    goto :goto_3
.end method

.method static dismiss()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 144
    sget-object v0, Lcom/mrkeyboard/app/MrVersion;->sDialog:Landroid/app/Dialog;

    .line 145
    sput-object v1, Lcom/mrkeyboard/app/MrVersion;->sDialog:Landroid/app/Dialog;

    .line 146
    sput-object v1, Lcom/mrkeyboard/app/MrVersion;->sOwner:Landroid/app/Activity;

    .line 147
    if-eqz v0, :cond_0

    .line 149
    :try_start_0
    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 154
    :cond_0
    :goto_0
    return-void

    .line 150
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static fill(Landroid/app/Activity;Landroid/view/View;)Z
    .locals 13

    .prologue
    const/16 v12, 0x8

    const/4 v4, 0x0

    .line 183
    const-string v0, "upd_title"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 184
    const-string v1, "upd_sub"

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    .line 185
    const-string v2, "upd_notes"

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v3

    .line 186
    const-string v2, "upd_later"

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    .line 187
    const-string v5, "upd_install"

    invoke-virtual {p1, v5}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v5

    .line 188
    const-string v6, "upd_github"

    invoke-virtual {p1, v6}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v6

    .line 189
    const-string v7, "upd_box"

    invoke-virtual {p1, v7}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v7

    .line 190
    const-string v8, "upd_error"

    invoke-virtual {p1, v8}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v8

    .line 191
    if-eqz v0, :cond_0

    if-eqz v1, :cond_0

    instance-of v9, v3, Landroid/widget/LinearLayout;

    if-eqz v9, :cond_0

    if-eqz v2, :cond_0

    if-eqz v5, :cond_0

    if-eqz v6, :cond_0

    if-eqz v7, :cond_0

    if-nez v8, :cond_1

    :cond_0
    move v0, v4

    .line 207
    :goto_0
    return v0

    .line 193
    :cond_1
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v9

    invoke-virtual {v9}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v9

    iget-object v9, v9, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 194
    const-string v10, "mr_version_title"

    new-array v11, v4, [Ljava/lang/Object;

    invoke-static {p0, v10, v11}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v0, v10}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 195
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->appName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    move-object v0, v3

    .line 196
    check-cast v0, Landroid/widget/LinearLayout;

    invoke-static {p0, v9}, Lcom/mrkeyboard/app/MrVersion;->notes(Landroid/content/Context;Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    const-string v3, "mr_update_notes_none"

    new-array v9, v4, [Ljava/lang/Object;

    invoke-static {p0, v3, v9}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v1, v3}, Lcom/mrkeyboard/app/MrNotesText;->fill(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;)I

    .line 197
    invoke-virtual {v5, v12}, Landroid/view/View;->setVisibility(I)V

    .line 198
    invoke-virtual {v6, v12}, Landroid/view/View;->setVisibility(I)V

    .line 199
    invoke-virtual {v7, v12}, Landroid/view/View;->setVisibility(I)V

    .line 200
    invoke-virtual {v8, v12}, Landroid/view/View;->setVisibility(I)V

    .line 201
    const-string v0, "mr_version_close"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 202
    new-instance v0, Lcom/mrkeyboard/app/MrVersion$1;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrVersion$1;-><init>()V

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 207
    const/4 v0, 0x1

    goto :goto_0
.end method

.method static notes(Landroid/content/Context;Ljava/util/Locale;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 61
    invoke-static {p0}, Lcom/mrkeyboard/app/MrVersion;->readAsset(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 62
    if-nez v1, :cond_1

    const-string v0, ""

    .line 65
    :cond_0
    :goto_0
    return-object v0

    .line 63
    :cond_1
    if-eqz p1, :cond_2

    const-string v0, "pt"

    invoke-virtual {p1}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x1

    .line 64
    :goto_1
    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrVersion;->block(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    .line 65
    if-nez v0, :cond_0

    const-string v0, ""

    goto :goto_0

    .line 63
    :cond_2
    const/4 v0, 0x0

    goto :goto_1
.end method

.method static readAll(Ljava/io/InputStream;)Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 91
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 92
    const/16 v0, 0x1000

    new-array v0, v0, [B

    .line 94
    :cond_0
    invoke-virtual {p0, v0}, Ljava/io/InputStream;->read([B)I

    move-result v2

    if-lez v2, :cond_1

    .line 95
    const/4 v3, 0x0

    invoke-virtual {v1, v0, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 96
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v2

    const/high16 v3, 0x10000

    if-le v2, v3, :cond_0

    const/4 v0, 0x0

    .line 98
    :goto_0
    return-object v0

    :cond_1
    new-instance v0, Ljava/lang/String;

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    const-string v2, "UTF-8"

    invoke-direct {v0, v1, v2}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    goto :goto_0
.end method

.method static readAsset(Landroid/content/Context;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 70
    .line 72
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    const-string v2, "mr_release_notes.md"

    invoke-virtual {v1, v2}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v1

    .line 73
    :try_start_1
    invoke-static {v1}, Lcom/mrkeyboard/app/MrVersion;->readAll(Ljava/io/InputStream;)Ljava/lang/String;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_7
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-object v0

    .line 79
    if-eqz v1, :cond_0

    .line 81
    :try_start_2
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_4

    .line 77
    :cond_0
    :goto_0
    return-object v0

    .line 74
    :catch_0
    move-exception v1

    move-object v1, v0

    .line 79
    :goto_1
    if-eqz v1, :cond_0

    .line 81
    :try_start_3
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_0

    .line 82
    :catch_1
    move-exception v1

    goto :goto_0

    .line 76
    :catch_2
    move-exception v1

    move-object v1, v0

    .line 79
    :goto_2
    if-eqz v1, :cond_0

    .line 81
    :try_start_4
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_0

    .line 82
    :catch_3
    move-exception v1

    goto :goto_0

    .line 79
    :catchall_0
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    :goto_3
    if-eqz v1, :cond_1

    .line 81
    :try_start_5
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_5

    .line 86
    :cond_1
    :goto_4
    throw v0

    .line 82
    :catch_4
    move-exception v1

    goto :goto_0

    :catch_5
    move-exception v1

    goto :goto_4

    .line 79
    :catchall_1
    move-exception v0

    goto :goto_3

    .line 76
    :catch_6
    move-exception v2

    goto :goto_2

    .line 74
    :catch_7
    move-exception v2

    goto :goto_1
.end method

.method static release(Landroid/app/Activity;)V
    .locals 1

    .prologue
    .line 140
    sget-object v0, Lcom/mrkeyboard/app/MrVersion;->sOwner:Landroid/app/Activity;

    if-ne v0, p0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrVersion;->dismiss()V

    .line 141
    :cond_0
    return-void
.end method

.method static show(Landroid/app/Activity;)V
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 158
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 179
    :cond_0
    :goto_0
    return-void

    .line 159
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrVersion;->dismiss()V

    .line 162
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v2, "Theme.MrKeyboard.Dialog"

    const-string v3, "style"

    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 163
    if-nez v0, :cond_2

    const v0, 0x7f0d00a1

    .line 164
    :cond_2
    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrMatrix;->dialogTheme(Landroid/app/Activity;I)I

    move-result v2

    .line 165
    new-instance v0, Landroid/app/Dialog;

    invoke-direct {v0, p0, v2}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    .line 166
    const/4 v1, 0x1

    :try_start_1
    invoke-virtual {v0, v1}, Landroid/app/Dialog;->requestWindowFeature(I)Z

    .line 167
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "mr_update_dialog"

    const-string v3, "layout"

    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 168
    if-eqz v1, :cond_0

    .line 169
    invoke-virtual {v0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrLocaleCtx;->of(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v1, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 170
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrVersion;->fill(Landroid/app/Activity;Landroid/view/View;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 171
    invoke-virtual {v0, v1}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 172
    sput-object v0, Lcom/mrkeyboard/app/MrVersion;->sDialog:Landroid/app/Dialog;

    .line 173
    sput-object p0, Lcom/mrkeyboard/app/MrVersion;->sOwner:Landroid/app/Activity;

    .line 174
    invoke-virtual {v0}, Landroid/app/Dialog;->show()V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 175
    :catch_0
    move-exception v1

    .line 177
    :goto_1
    if-eqz v0, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrVersion;->sDialog:Landroid/app/Dialog;

    if-ne v0, v1, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrVersion;->dismiss()V

    goto :goto_0

    .line 175
    :catch_1
    move-exception v0

    move-object v0, v1

    goto :goto_1
.end method

.method static showing()Z
    .locals 1

    .prologue
    .line 135
    sget-object v0, Lcom/mrkeyboard/app/MrVersion;->sDialog:Landroid/app/Dialog;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrVersion;->sDialog:Landroid/app/Dialog;

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

.method static summary(Landroid/content/Context;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 52
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->appName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 53
    const-string v0, "mr_version_summary"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v1, v2, v3

    invoke-static {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 54
    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    move-object v0, v1

    goto :goto_0
.end method


# virtual methods
.method public onPreferenceClick(Landroid/preference/Preference;)Z
    .locals 1

    .prologue
    .line 44
    iget-object v0, p0, Lcom/mrkeyboard/app/MrVersion;->mActivity:Landroid/app/Activity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrVersion;->show(Landroid/app/Activity;)V

    .line 45
    const/4 v0, 0x1

    return v0
.end method
