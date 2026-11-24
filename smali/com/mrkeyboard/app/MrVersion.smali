.class public final Lcom/mrkeyboard/app/MrVersion;
.super Ljava/lang/Object;
.source "MrVersion.java"

# interfaces
.implements Landroid/preference/Preference$OnPreferenceClickListener;


# static fields
.field static final ASSET:Ljava/lang/String; = "mr_release_notes.md"

.field static final MARK_EN:Ljava/lang/String; = "**English**"

.field static final MARK_ES:Ljava/lang/String; = "**Espa\u00f1ol**"

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
    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    iput-object p1, p0, Lcom/mrkeyboard/app/MrVersion;->mActivity:Landroid/app/Activity;

    .line 44
    return-void
.end method

.method static block(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 7

    .prologue
    const/4 v1, -0x1

    .line 110
    const-string v0, "\r\n"

    const-string v2, "\n"

    invoke-virtual {p0, v0, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "\n"

    invoke-virtual {v0, v2, v1}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v4

    .line 114
    const/4 v0, 0x0

    move v2, v1

    move v3, v1

    :goto_0
    array-length v5, v4

    if-ge v0, v5, :cond_3

    .line 115
    aget-object v5, v4, v0

    invoke-virtual {v5}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v5

    .line 116
    if-gez v3, :cond_1

    const-string v6, "**Portugu\u00eas**"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1

    move v3, v0

    .line 114
    :cond_0
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 117
    :cond_1
    if-gez v2, :cond_2

    const-string v6, "**English**"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    move v2, v0

    goto :goto_1

    .line 118
    :cond_2
    if-gez v1, :cond_0

    const-string v6, "**Espa\u00f1ol**"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    move v1, v0

    goto :goto_1

    .line 120
    :cond_3
    const-string v0, "pt"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    move v0, v3

    .line 121
    :goto_2
    invoke-static {v4, v0, v3, v2, v1}, Lcom/mrkeyboard/app/MrVersion;->body([Ljava/lang/String;IIII)Ljava/lang/String;

    move-result-object v0

    .line 122
    if-nez v0, :cond_4

    invoke-static {v4, v2, v3, v2, v1}, Lcom/mrkeyboard/app/MrVersion;->body([Ljava/lang/String;IIII)Ljava/lang/String;

    move-result-object v0

    .line 123
    :cond_4
    if-nez v0, :cond_5

    invoke-static {v4, v3, v3, v2, v1}, Lcom/mrkeyboard/app/MrVersion;->body([Ljava/lang/String;IIII)Ljava/lang/String;

    move-result-object v0

    .line 124
    :cond_5
    if-nez v0, :cond_6

    invoke-static {v4, v1, v3, v2, v1}, Lcom/mrkeyboard/app/MrVersion;->body([Ljava/lang/String;IIII)Ljava/lang/String;

    move-result-object v0

    .line 125
    :cond_6
    return-object v0

    .line 120
    :cond_7
    const-string v0, "es"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    move v0, v1

    goto :goto_2

    :cond_8
    move v0, v2

    goto :goto_2
.end method

.method private static body([Ljava/lang/String;IIII)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 130
    if-gez p1, :cond_0

    .line 141
    :goto_0
    return-object v1

    .line 131
    :cond_0
    array-length v0, p0

    .line 132
    if-le p2, p1, :cond_1

    if-ge p2, v0, :cond_1

    move v0, p2

    .line 133
    :cond_1
    if-le p3, p1, :cond_2

    if-ge p3, v0, :cond_2

    move v0, p3

    .line 134
    :cond_2
    if-le p4, p1, :cond_6

    if-ge p4, v0, :cond_6

    .line 135
    :goto_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 136
    add-int/lit8 v0, p1, 0x1

    :goto_2
    if-ge v0, p4, :cond_4

    .line 137
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    if-lez v3, :cond_3

    const/16 v3, 0xa

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 138
    :cond_3
    aget-object v3, p0, v0

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 136
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 140
    :cond_4
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 141
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_5

    :goto_3
    move-object v1, v0

    goto :goto_0

    :cond_5
    move-object v0, v1

    goto :goto_3

    :cond_6
    move p4, v0

    goto :goto_1
.end method

.method static dismiss()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 156
    sget-object v0, Lcom/mrkeyboard/app/MrVersion;->sDialog:Landroid/app/Dialog;

    .line 157
    sput-object v1, Lcom/mrkeyboard/app/MrVersion;->sDialog:Landroid/app/Dialog;

    .line 158
    sput-object v1, Lcom/mrkeyboard/app/MrVersion;->sOwner:Landroid/app/Activity;

    .line 159
    if-eqz v0, :cond_0

    .line 161
    :try_start_0
    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 166
    :cond_0
    :goto_0
    return-void

    .line 162
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static fill(Landroid/app/Activity;Landroid/view/View;)Z
    .locals 13

    .prologue
    const/16 v12, 0x8

    const/4 v4, 0x0

    .line 195
    const-string v0, "upd_title"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 196
    const-string v1, "upd_sub"

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    .line 197
    const-string v2, "upd_notes"

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v3

    .line 198
    const-string v2, "upd_later"

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    .line 199
    const-string v5, "upd_install"

    invoke-virtual {p1, v5}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v5

    .line 200
    const-string v6, "upd_github"

    invoke-virtual {p1, v6}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v6

    .line 201
    const-string v7, "upd_box"

    invoke-virtual {p1, v7}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v7

    .line 202
    const-string v8, "upd_error"

    invoke-virtual {p1, v8}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v8

    .line 203
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

    .line 219
    :goto_0
    return v0

    .line 205
    :cond_1
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v9

    invoke-virtual {v9}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v9

    iget-object v9, v9, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 206
    const-string v10, "mr_version_title"

    new-array v11, v4, [Ljava/lang/Object;

    invoke-static {p0, v10, v11}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v0, v10}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 207
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->appName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    move-object v0, v3

    .line 208
    check-cast v0, Landroid/widget/LinearLayout;

    invoke-static {p0, v9}, Lcom/mrkeyboard/app/MrVersion;->notes(Landroid/content/Context;Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    const-string v3, "mr_update_notes_none"

    new-array v9, v4, [Ljava/lang/Object;

    invoke-static {p0, v3, v9}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v1, v3}, Lcom/mrkeyboard/app/MrNotesText;->fill(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;)I

    .line 209
    invoke-virtual {v5, v12}, Landroid/view/View;->setVisibility(I)V

    .line 210
    invoke-virtual {v6, v12}, Landroid/view/View;->setVisibility(I)V

    .line 211
    invoke-virtual {v7, v12}, Landroid/view/View;->setVisibility(I)V

    .line 212
    invoke-virtual {v8, v12}, Landroid/view/View;->setVisibility(I)V

    .line 213
    const-string v0, "mr_version_close"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrUpdateDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 214
    new-instance v0, Lcom/mrkeyboard/app/MrVersion$1;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrVersion$1;-><init>()V

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 219
    const/4 v0, 0x1

    goto :goto_0
.end method

.method static notes(Landroid/content/Context;Ljava/util/Locale;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 64
    invoke-static {p0}, Lcom/mrkeyboard/app/MrVersion;->readAsset(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 65
    if-nez v1, :cond_1

    const-string v0, ""

    .line 67
    :cond_0
    :goto_0
    return-object v0

    .line 66
    :cond_1
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    :goto_1
    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrVersion;->block(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 67
    if-nez v0, :cond_0

    const-string v0, ""

    goto :goto_0

    .line 66
    :cond_2
    const-string v0, ""

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
    .line 93
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 94
    const/16 v0, 0x1000

    new-array v0, v0, [B

    .line 96
    :cond_0
    invoke-virtual {p0, v0}, Ljava/io/InputStream;->read([B)I

    move-result v2

    if-lez v2, :cond_1

    .line 97
    const/4 v3, 0x0

    invoke-virtual {v1, v0, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 98
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v2

    const/high16 v3, 0x10000

    if-le v2, v3, :cond_0

    const/4 v0, 0x0

    .line 100
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

    .line 72
    .line 74
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

    .line 75
    :try_start_1
    invoke-static {v1}, Lcom/mrkeyboard/app/MrVersion;->readAll(Ljava/io/InputStream;)Ljava/lang/String;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_7
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-object v0

    .line 81
    if-eqz v1, :cond_0

    .line 83
    :try_start_2
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_4

    .line 79
    :cond_0
    :goto_0
    return-object v0

    .line 76
    :catch_0
    move-exception v1

    move-object v1, v0

    .line 81
    :goto_1
    if-eqz v1, :cond_0

    .line 83
    :try_start_3
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_0

    .line 84
    :catch_1
    move-exception v1

    goto :goto_0

    .line 78
    :catch_2
    move-exception v1

    move-object v1, v0

    .line 81
    :goto_2
    if-eqz v1, :cond_0

    .line 83
    :try_start_4
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_0

    .line 84
    :catch_3
    move-exception v1

    goto :goto_0

    .line 81
    :catchall_0
    move-exception v1

    move-object v3, v1

    move-object v1, v0

    move-object v0, v3

    :goto_3
    if-eqz v1, :cond_1

    .line 83
    :try_start_5
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_5

    .line 88
    :cond_1
    :goto_4
    throw v0

    .line 84
    :catch_4
    move-exception v1

    goto :goto_0

    :catch_5
    move-exception v1

    goto :goto_4

    .line 81
    :catchall_1
    move-exception v0

    goto :goto_3

    .line 78
    :catch_6
    move-exception v2

    goto :goto_2

    .line 76
    :catch_7
    move-exception v2

    goto :goto_1
.end method

.method static release(Landroid/app/Activity;)V
    .locals 1

    .prologue
    .line 152
    sget-object v0, Lcom/mrkeyboard/app/MrVersion;->sOwner:Landroid/app/Activity;

    if-ne v0, p0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrVersion;->dismiss()V

    .line 153
    :cond_0
    return-void
.end method

.method static show(Landroid/app/Activity;)V
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 170
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 191
    :cond_0
    :goto_0
    return-void

    .line 171
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrVersion;->dismiss()V

    .line 174
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v2, "Theme.MrKeyboard.Dialog"

    const-string v3, "style"

    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 175
    if-nez v0, :cond_2

    const v0, 0x7f0d00a1

    .line 176
    :cond_2
    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrMatrix;->dialogTheme(Landroid/app/Activity;I)I

    move-result v2

    .line 177
    new-instance v0, Landroid/app/Dialog;

    invoke-direct {v0, p0, v2}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    .line 178
    const/4 v1, 0x1

    :try_start_1
    invoke-virtual {v0, v1}, Landroid/app/Dialog;->requestWindowFeature(I)Z

    .line 179
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "mr_update_dialog"

    const-string v3, "layout"

    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 180
    if-eqz v1, :cond_0

    .line 181
    invoke-virtual {v0}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrLocaleCtx;->of(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v1, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 182
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrVersion;->fill(Landroid/app/Activity;Landroid/view/View;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 183
    invoke-virtual {v0, v1}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 184
    sput-object v0, Lcom/mrkeyboard/app/MrVersion;->sDialog:Landroid/app/Dialog;

    .line 185
    sput-object p0, Lcom/mrkeyboard/app/MrVersion;->sOwner:Landroid/app/Activity;

    .line 186
    invoke-virtual {v0}, Landroid/app/Dialog;->show()V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 187
    :catch_0
    move-exception v1

    .line 189
    :goto_1
    if-eqz v0, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrVersion;->sDialog:Landroid/app/Dialog;

    if-ne v0, v1, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrVersion;->dismiss()V

    goto :goto_0

    .line 187
    :catch_1
    move-exception v0

    move-object v0, v1

    goto :goto_1
.end method

.method static showing()Z
    .locals 1

    .prologue
    .line 147
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
    .line 55
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->appName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 56
    const-string v0, "mr_version_summary"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v1, v2, v3

    invoke-static {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 57
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
    .line 47
    iget-object v0, p0, Lcom/mrkeyboard/app/MrVersion;->mActivity:Landroid/app/Activity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrVersion;->show(Landroid/app/Activity;)V

    .line 48
    const/4 v0, 0x1

    return v0
.end method
