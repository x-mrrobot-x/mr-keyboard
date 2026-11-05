.class public final Lcom/mrkeyboard/app/MrUpdate;
.super Ljava/lang/Object;
.source "MrUpdate.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrUpdate$Notice;,
        Lcom/mrkeyboard/app/MrUpdate$Result;
    }
.end annotation


# static fields
.field static final AVAILABLE:I = 0x2

.field static final ERR_FILE:I = 0x3

.field static final ERR_HTTP:I = 0x2

.field static final ERR_NETWORK:I = 0x1

.field static final ERR_NONE:I = 0x0

.field static final ERR_OLD:I = 0x5

.field static final ERR_SIGNATURE:I = 0x4

.field static final FAILED:I = 0x3

.field static final FORMAT:I = 0x1

.field static final JOB_REUSE:J = 0x1499700L

.field static final KEY_CHECKED:Ljava/lang/String; = "checked_at"

.field static final KEY_NOTICE:Ljava/lang/String; = "notice"

.field static final KEY_SEEN:Ljava/lang/String; = "seen_code"

.field static final KEY_TRIED:Ljava/lang/String; = "tried_at"

.field static final MAX_APK:J = 0x6400000L

.field static final MAX_NOTES:I = 0x1f40

.field static final MAX_NOTICE:I = 0x8000

.field static final PREFS:Ljava/lang/String; = "mr_update"

.field static final RELEASE_PAGE:Ljava/lang/String; = "https://github.com/x-mrrobot-x/mr-keyboard/releases/latest"

.field static final RETRY:J = 0x36ee80L

.field static final SIG_PREFIX:Ljava/lang/String; = "mr-keyboard/update/v1\n"

.field static final UNKNOWN:I = 0x0

.field static final UPDATE_URL:Ljava/lang/String; = "https://github.com/x-mrrobot-x/mr-keyboard/releases/latest/download/update.json"

.field static final UP_TO_DATE:I = 0x1

.field static final WINDOW:J = 0x5265c00L

.field static sTestNow:J

.field static sUrl:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 165
    const-string v0, "https://github.com/x-mrrobot-x/mr-keyboard/releases/latest/download/update.json"

    sput-object v0, Lcom/mrkeyboard/app/MrUpdate;->sUrl:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static cached(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Result;
    .locals 5

    .prologue
    const/4 v0, 0x1

    .line 191
    new-instance v1, Lcom/mrkeyboard/app/MrUpdate$Result;

    invoke-direct {v1}, Lcom/mrkeyboard/app/MrUpdate$Result;-><init>()V

    .line 192
    iput-boolean v0, v1, Lcom/mrkeyboard/app/MrUpdate$Result;->fromCache:Z

    .line 193
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->pending(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Notice;

    move-result-object v2

    iput-object v2, v1, Lcom/mrkeyboard/app/MrUpdate$Result;->notice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    .line 194
    iget-object v2, v1, Lcom/mrkeyboard/app/MrUpdate$Result;->notice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    if-eqz v2, :cond_1

    const/4 v0, 0x2

    :cond_0
    :goto_0
    iput v0, v1, Lcom/mrkeyboard/app/MrUpdate$Result;->status:I

    .line 195
    return-object v1

    .line 194
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    const-string v3, "notice"

    const/4 v4, 0x0

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_0

    const/4 v0, 0x0

    goto :goto_0
.end method

.method static declared-synchronized check(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Result;
    .locals 12

    .prologue
    const/4 v1, 0x1

    .line 205
    const-class v2, Lcom/mrkeyboard/app/MrUpdate;

    monitor-enter v2

    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 206
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdate;->now()J

    move-result-wide v4

    .line 207
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v6, "tried_at"

    invoke-interface {v3, v6, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 209
    :try_start_1
    sget-object v3, Lcom/mrkeyboard/app/MrUpdate;->sUrl:Ljava/lang/String;

    const v6, 0x8000

    const-string v7, "update.json"

    invoke-static {v3, v6, v7}, Lcom/mrkeyboard/app/MrPacks;->fetchBytes(Ljava/lang/String;ILjava/lang/String;)[B

    move-result-object v3

    .line 210
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->certs(Landroid/content/Context;)[Ljava/security/cert/X509Certificate;

    move-result-object v6

    .line 211
    const/4 v7, 0x1

    const-string v8, "mr-keyboard/update/v1\n"

    const-string v9, "update.json"

    invoke-static {v3, v7, v8, v9, v6}, Lcom/mrkeyboard/app/MrPacks;->verifySigned([BILjava/lang/String;Ljava/lang/String;[Ljava/security/cert/X509Certificate;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrUpdate;->readData(Ljava/lang/String;)Lcom/mrkeyboard/app/MrUpdate$Notice;

    move-result-object v3

    .line 212
    const-string v6, "seen_code"

    const-wide/16 v8, 0x0

    invoke-interface {v0, v6, v8, v9}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v6

    .line 213
    iget-wide v8, v3, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionCode:J

    cmp-long v8, v8, v6

    if-gez v8, :cond_0

    const/4 v0, 0x5

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrUpdate;->failed(II)Lcom/mrkeyboard/app/MrUpdate$Result;
    :try_end_1
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v0

    .line 221
    :goto_0
    monitor-exit v2

    return-object v0

    .line 214
    :cond_0
    :try_start_2
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v8, "seen_code"

    iget-wide v10, v3, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionCode:J

    invoke-static {v6, v7, v10, v11}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v6

    invoke-interface {v0, v8, v6, v7}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v6, "notice"

    iget-object v3, v3, Lcom/mrkeyboard/app/MrUpdate$Notice;->data:Ljava/lang/String;

    invoke-interface {v0, v6, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v3, "checked_at"

    .line 215
    invoke-interface {v0, v3, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 216
    new-instance v0, Lcom/mrkeyboard/app/MrUpdate$Result;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrUpdate$Result;-><init>()V

    .line 217
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->pending(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Notice;

    move-result-object v3

    iput-object v3, v0, Lcom/mrkeyboard/app/MrUpdate$Result;->notice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    .line 218
    iget-object v3, v0, Lcom/mrkeyboard/app/MrUpdate$Result;->notice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    if-eqz v3, :cond_1

    const/4 v1, 0x2

    :cond_1
    iput v1, v0, Lcom/mrkeyboard/app/MrUpdate$Result;->status:I
    :try_end_2
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 220
    :catch_0
    move-exception v0

    .line 221
    :try_start_3
    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdate;->failure(Lcom/mrkeyboard/app/MrPacks$PackException;)Lcom/mrkeyboard/app/MrUpdate$Result;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result-object v0

    goto :goto_0

    .line 205
    :catchall_0
    move-exception v0

    monitor-exit v2

    throw v0
.end method

.method static declared-synchronized checkIfOlder(Landroid/content/Context;J)Lcom/mrkeyboard/app/MrUpdate$Result;
    .locals 11

    .prologue
    .line 230
    const-class v2, Lcom/mrkeyboard/app/MrUpdate;

    monitor-enter v2

    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 231
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdate;->now()J

    move-result-wide v4

    .line 232
    const-string v1, "checked_at"

    const-wide/16 v6, 0x0

    invoke-interface {v0, v1, v6, v7}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v6

    const-string v1, "tried_at"

    const-wide/16 v8, 0x0

    invoke-interface {v0, v1, v8, v9}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v8

    .line 233
    const-wide/16 v0, 0x0

    cmp-long v0, v6, v0

    if-lez v0, :cond_1

    cmp-long v0, v4, v6

    if-ltz v0, :cond_1

    sub-long v0, v4, v6

    cmp-long v0, v0, p1

    if-gez v0, :cond_1

    const/4 v0, 0x1

    move v1, v0

    .line 234
    :goto_0
    const-wide/16 v6, 0x0

    cmp-long v0, v8, v6

    if-lez v0, :cond_2

    cmp-long v0, v4, v8

    if-ltz v0, :cond_2

    sub-long/2addr v4, v8

    const-wide/32 v6, 0x36ee80

    cmp-long v0, v4, v6

    if-gez v0, :cond_2

    const/4 v0, 0x1

    .line 235
    :goto_1
    if-nez v1, :cond_0

    if-eqz v0, :cond_3

    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->cached(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Result;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 236
    :goto_2
    monitor-exit v2

    return-object v0

    .line 233
    :cond_1
    const/4 v0, 0x0

    move v1, v0

    goto :goto_0

    .line 234
    :cond_2
    const/4 v0, 0x0

    goto :goto_1

    .line 236
    :cond_3
    :try_start_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->check(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Result;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v0

    goto :goto_2

    .line 230
    :catchall_0
    move-exception v0

    monitor-exit v2

    throw v0
.end method

.method static codeOf(Ljava/lang/String;)J
    .locals 8

    .prologue
    const/4 v6, 0x1

    .line 99
    invoke-virtual {p0, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "\\."

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 100
    const/4 v1, 0x0

    aget-object v1, v0, v1

    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    const-wide/32 v4, 0xf4240

    mul-long/2addr v2, v4

    aget-object v1, v0, v6

    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v4

    const-wide/16 v6, 0x3e8

    mul-long/2addr v4, v6

    add-long/2addr v2, v4

    const/4 v1, 0x2

    aget-object v0, v0, v1

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v0

    add-long/2addr v0, v2

    return-wide v0
.end method

.method private static failed(II)Lcom/mrkeyboard/app/MrUpdate$Result;
    .locals 2

    .prologue
    .line 240
    new-instance v0, Lcom/mrkeyboard/app/MrUpdate$Result;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrUpdate$Result;-><init>()V

    .line 241
    const/4 v1, 0x3

    iput v1, v0, Lcom/mrkeyboard/app/MrUpdate$Result;->status:I

    .line 242
    iput p0, v0, Lcom/mrkeyboard/app/MrUpdate$Result;->error:I

    .line 243
    iput p1, v0, Lcom/mrkeyboard/app/MrUpdate$Result;->httpCode:I

    .line 244
    return-object v0
.end method

.method private static failure(Lcom/mrkeyboard/app/MrPacks$PackException;)Lcom/mrkeyboard/app/MrUpdate$Result;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 248
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacks$PackException;->key:Ljava/lang/String;

    .line 249
    const-string v2, "mr_dicts_err_network"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 v1, 0x1

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrUpdate;->failed(II)Lcom/mrkeyboard/app/MrUpdate$Result;

    move-result-object v0

    .line 252
    :goto_0
    return-object v0

    .line 250
    :cond_0
    const-string v2, "mr_dicts_err_http"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    const/4 v1, 0x2

    iget-object v2, p0, Lcom/mrkeyboard/app/MrPacks$PackException;->args:[Ljava/lang/Object;

    array-length v2, v2

    if-lez v2, :cond_1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrPacks$PackException;->args:[Ljava/lang/Object;

    aget-object v2, v2, v0

    instance-of v2, v2, Ljava/lang/Integer;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrPacks$PackException;->args:[Ljava/lang/Object;

    aget-object v0, v2, v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    :cond_1
    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrUpdate;->failed(II)Lcom/mrkeyboard/app/MrUpdate$Result;

    move-result-object v0

    goto :goto_0

    .line 251
    :cond_2
    const-string v2, "mr_dicts_err_signature"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_3

    const-string v2, "mr_dicts_err_other_key"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    :cond_3
    const/4 v1, 0x4

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrUpdate;->failed(II)Lcom/mrkeyboard/app/MrUpdate$Result;

    move-result-object v0

    goto :goto_0

    .line 252
    :cond_4
    const/4 v1, 0x3

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrUpdate;->failed(II)Lcom/mrkeyboard/app/MrUpdate$Result;

    move-result-object v0

    goto :goto_0
.end method

.method static now()J
    .locals 4

    .prologue
    .line 170
    sget-wide v0, Lcom/mrkeyboard/app/MrUpdate;->sTestNow:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    sget-wide v0, Lcom/mrkeyboard/app/MrUpdate;->sTestNow:J

    :goto_0
    return-wide v0

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    goto :goto_0
.end method

.method static pending(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Notice;
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 179
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v2, "notice"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 180
    if-nez v0, :cond_0

    .line 185
    :goto_0
    return-object v1

    .line 182
    :cond_0
    :try_start_0
    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdate;->readData(Ljava/lang/String;)Lcom/mrkeyboard/app/MrUpdate$Notice;

    move-result-object v0

    .line 183
    iget-wide v2, v0, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionCode:J

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->appVersion(Landroid/content/Context;)J
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v4

    cmp-long v2, v2, v4

    if-lez v2, :cond_1

    :goto_1
    move-object v1, v0

    goto :goto_0

    :cond_1
    move-object v0, v1

    goto :goto_1

    .line 184
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static plain(Ljava/lang/String;)Ljava/lang/String;
    .locals 10

    .prologue
    const/4 v2, 0x0

    .line 141
    if-nez p0, :cond_0

    const-string v0, ""

    .line 159
    :goto_0
    return-object v0

    .line 142
    :cond_0
    const-string v0, "\r\n"

    const-string v1, "\n"

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "\n"

    const/4 v3, -0x1

    invoke-virtual {v0, v1, v3}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v4

    .line 143
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-direct {v5, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 145
    array-length v6, v4

    move v3, v2

    move v1, v2

    :goto_1
    if-ge v3, v6, :cond_8

    aget-object v0, v4, v3

    .line 146
    const-string v7, "**"

    const-string v8, ""

    invoke-virtual {v0, v7, v8}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v7, "`"

    const-string v8, ""

    invoke-virtual {v0, v7, v8}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v7

    .line 147
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v0

    .line 148
    :goto_2
    if-lez v0, :cond_2

    add-int/lit8 v8, v0, -0x1

    invoke-virtual {v7, v8}, Ljava/lang/String;->charAt(I)C

    move-result v8

    const/16 v9, 0x20

    if-eq v8, v9, :cond_1

    add-int/lit8 v8, v0, -0x1

    invoke-virtual {v7, v8}, Ljava/lang/String;->charAt(I)C

    move-result v8

    const/16 v9, 0x9

    if-ne v8, v9, :cond_2

    :cond_1
    add-int/lit8 v0, v0, -0x1

    goto :goto_2

    .line 149
    :cond_2
    invoke-virtual {v7, v2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 150
    const-string v7, "- "

    invoke-virtual {v0, v7}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_3

    const-string v7, "* "

    invoke-virtual {v0, v7}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_4

    :cond_3
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "\u2022 "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const/4 v8, 0x2

    invoke-virtual {v0, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 151
    :cond_4
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v7

    if-nez v7, :cond_5

    .line 152
    add-int/lit8 v1, v1, 0x1

    const/4 v7, 0x1

    if-le v1, v7, :cond_6

    .line 145
    :goto_3
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_1

    :cond_5
    move v1, v2

    .line 156
    :cond_6
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->length()I

    move-result v7

    if-lez v7, :cond_7

    const/16 v7, 0xa

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 157
    :cond_7
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_3

    .line 159
    :cond_8
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0
.end method

.method static prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 2

    .prologue
    .line 174
    const-string v0, "mr_update"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method static readData(Ljava/lang/String;)Lcom/mrkeyboard/app/MrUpdate$Notice;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    const/16 v9, 0x1f40

    const/4 v8, 0x0

    .line 106
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrJson;->parse(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v0

    .line 107
    const-string v1, "format"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v2

    const-wide/16 v4, 0x1

    cmp-long v1, v2, v4

    if-eqz v1, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_new_format"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    .line 129
    :catch_0
    move-exception v0

    .line 130
    throw v0

    .line 108
    :cond_0
    :try_start_1
    new-instance v1, Lcom/mrkeyboard/app/MrUpdate$Notice;

    invoke-direct {v1}, Lcom/mrkeyboard/app/MrUpdate$Notice;-><init>()V

    .line 109
    iput-object p0, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->data:Ljava/lang/String;

    .line 110
    const-string v2, "versionName"

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionName:Ljava/lang/String;

    .line 111
    iget-object v2, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionName:Ljava/lang/String;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->validTag(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "versionName"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_1
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    .line 131
    :catch_1
    move-exception v0

    .line 132
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_corrupt"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "update.json"

    aput-object v3, v2, v8

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 112
    :cond_1
    :try_start_2
    const-string v2, "versionCode"

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v2

    iput-wide v2, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionCode:J

    .line 113
    iget-wide v2, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionCode:J

    iget-object v4, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionName:Ljava/lang/String;

    invoke-static {v4}, Lcom/mrkeyboard/app/MrUpdate;->codeOf(Ljava/lang/String;)J

    move-result-wide v4

    cmp-long v2, v2, v4

    if-eqz v2, :cond_2

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "versionCode"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 114
    :cond_2
    const-string v2, "generated"

    const-string v3, ""

    invoke-static {v0, v2, v3}, Lcom/mrkeyboard/app/MrJson;->optStr(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->generated:Ljava/lang/String;

    .line 115
    const-string v2, "apk"

    invoke-interface {v0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v2

    .line 116
    const-string v3, "name"

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->apkName:Ljava/lang/String;

    .line 117
    iget-object v3, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->apkName:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mr-keyboard-"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionName:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ".apk"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "apk.name"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 118
    :cond_3
    const-string v3, "size"

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v4

    iput-wide v4, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->apkSize:J

    .line 119
    iget-wide v4, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->apkSize:J

    const-wide/16 v6, 0x0

    cmp-long v3, v4, v6

    if-lez v3, :cond_4

    iget-wide v4, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->apkSize:J

    const-wide/32 v6, 0x6400000

    cmp-long v3, v4, v6

    if-lez v3, :cond_5

    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "apk.size"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 120
    :cond_5
    const-string v3, "sha256"

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrPacks;->hexField(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->apkSha256:Ljava/lang/String;

    .line 121
    const-string v2, "notes"

    invoke-interface {v0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v0

    .line 122
    const-string v2, "en"

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->notesEn:Ljava/lang/String;

    .line 123
    const-string v2, "pt-BR"

    const/4 v3, 0x0

    invoke-static {v0, v2, v3}, Lcom/mrkeyboard/app/MrJson;->optStr(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->notesPt:Ljava/lang/String;

    .line 124
    iget-object v0, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->notesEn:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_6

    iget-object v0, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->notesEn:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-gt v0, v9, :cond_6

    iget-object v0, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->notesPt:Ljava/lang/String;

    if-eqz v0, :cond_7

    iget-object v0, v1, Lcom/mrkeyboard/app/MrUpdate$Notice;->notesPt:Ljava/lang/String;

    .line 125
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-le v0, v9, :cond_7

    .line 126
    :cond_6
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "notes"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_2
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_1

    .line 128
    :cond_7
    return-object v1
.end method
