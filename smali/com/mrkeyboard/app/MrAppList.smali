.class final Lcom/mrkeyboard/app/MrAppList;
.super Ljava/lang/Object;
.source "MrAppList.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrAppList$Found;,
        Lcom/mrkeyboard/app/MrAppList$Entry;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static filter(Ljava/util/List;Ljava/lang/String;)Ljava/util/List;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 162
    if-nez p1, :cond_0

    const-string v0, ""

    .line 163
    :goto_0
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 177
    :goto_1
    return-object p0

    .line 162
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrMemStore;->fold(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 164
    :cond_1
    const-string v1, "\\s+"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    .line 165
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 166
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :cond_2
    :goto_2
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Entry;

    .line 167
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAppList$Entry;->folded:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    sget-object v7, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v4, v7}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 168
    const/4 v2, 0x1

    .line 169
    array-length v8, v5

    move v4, v3

    :goto_3
    if-ge v4, v8, :cond_3

    aget-object v9, v5, v4

    .line 170
    invoke-virtual {v7, v9}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_4

    move v2, v3

    .line 175
    :cond_3
    if-eqz v2, :cond_2

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 169
    :cond_4
    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    :cond_5
    move-object p0, v1

    .line 177
    goto :goto_1
.end method

.method static icon(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 199
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .line 200
    if-nez v1, :cond_0

    .line 204
    :goto_0
    return-object v0

    .line 200
    :cond_0
    invoke-virtual {v1, p1}, Landroid/content/pm/PackageManager;->getApplicationIcon(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 203
    :catch_0
    move-exception v1

    goto :goto_0

    .line 201
    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method static isUserApp(I)Z
    .locals 1

    .prologue
    .line 59
    and-int/lit8 v0, p0, 0x1

    if-eqz v0, :cond_0

    and-int/lit16 v0, p0, 0x80

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static label(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 183
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 184
    if-eqz v0, :cond_0

    .line 185
    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->getApplicationLabel(Landroid/content/pm/ApplicationInfo;)Ljava/lang/CharSequence;

    move-result-object v0

    .line 186
    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object p1

    .line 193
    :cond_0
    :goto_0
    return-object p1

    .line 190
    :catch_0
    move-exception v0

    goto :goto_0

    .line 188
    :catch_1
    move-exception v0

    goto :goto_0
.end method

.method static load(Landroid/content/Context;)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 157
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAppList;->scan(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    invoke-static {p0, v0, v1, v1}, Lcom/mrkeyboard/app/MrAppList;->named(Landroid/content/Context;Ljava/util/List;Ljava/util/Map;Ljava/util/Map;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method static name(Landroid/content/pm/PackageManager;Lcom/mrkeyboard/app/MrAppList$Found;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 123
    const/4 v0, 0x0

    .line 125
    :try_start_0
    iget-object v1, p1, Lcom/mrkeyboard/app/MrAppList$Found;->info:Landroid/content/pm/ResolveInfo;

    invoke-virtual {v1, p0}, Landroid/content/pm/ResolveInfo;->loadLabel(Landroid/content/pm/PackageManager;)Ljava/lang/CharSequence;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 129
    :goto_0
    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    :goto_1
    return-object v0

    :cond_0
    iget-object v0, p1, Lcom/mrkeyboard/app/MrAppList$Found;->pkg:Ljava/lang/String;

    goto :goto_1

    .line 126
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static named(Landroid/content/Context;Ljava/util/List;Ljava/util/Map;Ljava/util/Map;)Ljava/util/List;
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Found;",
            ">;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "[",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "[",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    const/4 v10, 0x1

    const/4 v9, 0x0

    .line 143
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 144
    if-nez p0, :cond_1

    move-object v2, v3

    .line 145
    :goto_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Found;

    .line 146
    if-nez p2, :cond_2

    move-object v1, v3

    .line 147
    :goto_2
    if-eqz v1, :cond_3

    iget-object v6, v0, Lcom/mrkeyboard/app/MrAppList$Found;->stamp:Ljava/lang/String;

    aget-object v7, v1, v10

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_3

    aget-object v1, v1, v9

    .line 148
    :goto_3
    if-eqz p3, :cond_0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrAppList$Found;->pkg:Ljava/lang/String;

    const/4 v7, 0x2

    new-array v7, v7, [Ljava/lang/String;

    aput-object v1, v7, v9

    iget-object v8, v0, Lcom/mrkeyboard/app/MrAppList$Found;->stamp:Ljava/lang/String;

    aput-object v8, v7, v10

    invoke-interface {p3, v6, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 149
    :cond_0
    new-instance v6, Lcom/mrkeyboard/app/MrAppList$Entry;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAppList$Found;->pkg:Ljava/lang/String;

    invoke-direct {v6, v0, v1}, Lcom/mrkeyboard/app/MrAppList$Entry;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v4, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 144
    :cond_1
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    move-object v2, v0

    goto :goto_0

    .line 146
    :cond_2
    iget-object v1, v0, Lcom/mrkeyboard/app/MrAppList$Found;->pkg:Ljava/lang/String;

    invoke-interface {p2, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/String;

    goto :goto_2

    .line 147
    :cond_3
    if-nez v2, :cond_4

    iget-object v1, v0, Lcom/mrkeyboard/app/MrAppList$Found;->pkg:Ljava/lang/String;

    goto :goto_3

    :cond_4
    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrAppList;->name(Landroid/content/pm/PackageManager;Lcom/mrkeyboard/app/MrAppList$Found;)Ljava/lang/String;

    move-result-object v1

    goto :goto_3

    .line 151
    :cond_5
    invoke-static {v4}, Lcom/mrkeyboard/app/MrAppList;->sort(Ljava/util/List;)V

    .line 152
    return-object v4
.end method

.method static scan(Landroid/content/Context;)Ljava/util/List;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Found;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 80
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 82
    if-nez p0, :cond_0

    move-object v0, v3

    .line 83
    :goto_0
    if-nez v0, :cond_1

    move-object v0, v1

    .line 104
    :goto_1
    return-object v0

    .line 82
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    goto :goto_0

    .line 84
    :cond_1
    new-instance v2, Landroid/content/Intent;

    const-string v4, "android.intent.action.MAIN"

    invoke-direct {v2, v4}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 85
    const-string v4, "android.intent.category.LAUNCHER"

    invoke-virtual {v2, v4}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 86
    const/4 v4, 0x0

    invoke-virtual {v0, v2, v4}, Landroid/content/pm/PackageManager;->queryIntentActivities(Landroid/content/Intent;I)Ljava/util/List;

    move-result-object v0

    .line 87
    if-nez v0, :cond_2

    move-object v0, v1

    goto :goto_1

    .line 88
    :cond_2
    new-instance v6, Ljava/util/HashSet;

    invoke-direct {v6}, Ljava/util/HashSet;-><init>()V

    .line 89
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :cond_3
    :goto_2
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ResolveInfo;

    .line 90
    if-nez v0, :cond_5

    move-object v5, v3

    .line 91
    :goto_3
    if-nez v5, :cond_6

    move-object v4, v3

    .line 92
    :goto_4
    if-eqz v4, :cond_7

    iget-object v2, v4, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    if-eqz v2, :cond_7

    iget-object v2, v4, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    .line 93
    :goto_5
    invoke-static {v2}, Lcom/mrkeyboard/app/MrApp;->validPackage(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_3

    if-eqz v4, :cond_3

    iget v8, v4, Landroid/content/pm/ApplicationInfo;->flags:I

    invoke-static {v8}, Lcom/mrkeyboard/app/MrAppList;->isUserApp(I)Z

    move-result v8

    if-eqz v8, :cond_3

    invoke-virtual {v6, v2}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_3

    .line 94
    new-instance v8, Lcom/mrkeyboard/app/MrAppList$Found;

    invoke-static {v5, v4}, Lcom/mrkeyboard/app/MrAppList;->stampOf(Landroid/content/pm/ActivityInfo;Landroid/content/pm/ApplicationInfo;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v8, v2, v4, v0}, Lcom/mrkeyboard/app/MrAppList$Found;-><init>(Ljava/lang/String;Ljava/lang/String;Landroid/content/pm/ResolveInfo;)V

    invoke-virtual {v1, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 96
    :catch_0
    move-exception v0

    .line 99
    :cond_4
    new-instance v0, Lcom/mrkeyboard/app/MrAppList$1;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrAppList$1;-><init>()V

    invoke-static {v1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    move-object v0, v1

    .line 104
    goto :goto_1

    .line 90
    :cond_5
    :try_start_1
    iget-object v2, v0, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    move-object v5, v2

    goto :goto_3

    .line 91
    :cond_6
    iget-object v2, v5, Landroid/content/pm/ActivityInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    move-object v4, v2

    goto :goto_4

    .line 92
    :cond_7
    if-eqz v5, :cond_8

    iget-object v2, v5, Landroid/content/pm/ActivityInfo;->packageName:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_5

    :cond_8
    move-object v2, v3

    goto :goto_5
.end method

.method static signature(Ljava/util/List;)Ljava/lang/String;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Found;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    .line 110
    :try_start_0
    const-string v0, "SHA-256"

    invoke-static {v0}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v1

    .line 111
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Found;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAppList$Found;->pkg:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\t"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAppList$Found;->stamp:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "\n"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v3}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/security/MessageDigest;->update([B)V

    goto :goto_0

    .line 116
    :catch_0
    move-exception v0

    .line 117
    const/4 v0, 0x0

    :goto_1
    return-object v0

    .line 112
    :cond_0
    invoke-virtual {v1}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v1

    .line 113
    new-instance v2, Ljava/lang/StringBuilder;

    array-length v0, v1

    mul-int/lit8 v0, v0, 0x2

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 114
    array-length v3, v1

    const/4 v0, 0x0

    :goto_2
    if-ge v0, v3, :cond_1

    aget-byte v4, v1, v0

    shr-int/lit8 v5, v4, 0x4

    and-int/lit8 v5, v5, 0xf

    const/16 v6, 0x10

    invoke-static {v5, v6}, Ljava/lang/Character;->forDigit(II)C

    move-result v5

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v5

    and-int/lit8 v4, v4, 0xf

    const/16 v6, 0x10

    invoke-static {v4, v6}, Ljava/lang/Character;->forDigit(II)C

    move-result v4

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 115
    :cond_1
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_1
.end method

.method static sort(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 133
    new-instance v0, Lcom/mrkeyboard/app/MrAppList$2;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrAppList$2;-><init>()V

    invoke-static {p0, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 139
    return-void
.end method

.method private static stampOf(Landroid/content/pm/ActivityInfo;Landroid/content/pm/ApplicationInfo;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 75
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/Locale;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "|"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/content/pm/ActivityInfo;->labelRes:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "|"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p1, Landroid/content/pm/ApplicationInfo;->labelRes:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
