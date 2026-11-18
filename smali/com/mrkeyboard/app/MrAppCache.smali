.class final Lcom/mrkeyboard/app/MrAppCache;
.super Ljava/lang/Object;
.source "MrAppCache.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrAppCache$Store;,
        Lcom/mrkeyboard/app/MrAppCache$Snapshot;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static refresh(Landroid/content/Context;Lcom/mrkeyboard/app/MrAppCache$Store;Lcom/mrkeyboard/app/MrAppPicker$Sink;)V
    .locals 15

    .prologue
    .line 99
    :try_start_0
    invoke-interface/range {p1 .. p1}, Lcom/mrkeyboard/app/MrAppCache$Store;->read()Lcom/mrkeyboard/app/MrAppCache$Snapshot;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 103
    :goto_0
    if-nez v1, :cond_9

    invoke-static {}, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->empty()Lcom/mrkeyboard/app/MrAppCache$Snapshot;

    move-result-object v1

    move-object v3, v1

    .line 104
    :goto_1
    const/4 v1, 0x0

    .line 105
    iget-object v2, v3, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->entries:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_8

    .line 106
    iget-object v1, v3, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->entries:Ljava/util/List;

    move-object/from16 v0, p2

    invoke-interface {v0, v1}, Lcom/mrkeyboard/app/MrAppPicker$Sink;->publish(Ljava/util/List;)V

    .line 107
    const/4 v1, 0x1

    move v4, v1

    .line 109
    :goto_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAppList;->scan(Landroid/content/Context;)Ljava/util/List;

    move-result-object v2

    .line 110
    if-nez v2, :cond_1

    .line 111
    if-nez v4, :cond_0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p2

    invoke-interface {v0, v1}, Lcom/mrkeyboard/app/MrAppPicker$Sink;->publish(Ljava/util/List;)V

    .line 144
    :cond_0
    :goto_3
    return-void

    .line 100
    :catch_0
    move-exception v1

    .line 101
    const/4 v1, 0x0

    goto :goto_0

    .line 114
    :cond_1
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/Locale;->toString()Ljava/lang/String;

    move-result-object v6

    .line 115
    invoke-static {v2}, Lcom/mrkeyboard/app/MrAppCache;->signature(Ljava/util/List;)Ljava/lang/String;

    move-result-object v7

    .line 116
    if-eqz v4, :cond_2

    iget-object v1, v3, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->signature:Ljava/lang/String;

    invoke-virtual {v7, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, v3, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->locale:Ljava/lang/String;

    invoke-virtual {v6, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 118
    :cond_2
    iget-object v1, v3, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->locale:Ljava/lang/String;

    invoke-virtual {v6, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    .line 119
    new-instance v8, Ljava/util/HashMap;

    invoke-direct {v8}, Ljava/util/HashMap;-><init>()V

    .line 120
    if-eqz v1, :cond_3

    .line 121
    iget-object v1, v3, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->entries:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_4
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/MrAppList$Entry;

    iget-object v9, v1, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    invoke-virtual {v8, v9, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_4

    .line 123
    :cond_3
    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9}, Ljava/util/ArrayList;-><init>()V

    .line 124
    new-instance v10, Ljava/util/HashMap;

    invoke-direct {v10}, Ljava/util/HashMap;-><init>()V

    .line 125
    const/4 v1, 0x0

    .line 127
    :try_start_1
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v1

    move-object v5, v1

    .line 131
    :goto_5
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v11

    :goto_6
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_6

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/MrAppList$Found;

    .line 132
    iget-object v2, v1, Lcom/mrkeyboard/app/MrAppList$Found;->pkg:Ljava/lang/String;

    invoke-virtual {v8, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/MrAppList$Entry;

    .line 133
    if-eqz v2, :cond_4

    iget-object v12, v1, Lcom/mrkeyboard/app/MrAppList$Found;->source:Ljava/lang/String;

    iget-object v13, v3, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->sources:Ljava/util/Map;

    iget-object v14, v1, Lcom/mrkeyboard/app/MrAppList$Found;->pkg:Ljava/lang/String;

    invoke-interface {v13, v14}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    if-nez v12, :cond_5

    :cond_4
    invoke-static {v5, v1}, Lcom/mrkeyboard/app/MrAppList;->entry(Landroid/content/pm/PackageManager;Lcom/mrkeyboard/app/MrAppList$Found;)Lcom/mrkeyboard/app/MrAppList$Entry;

    move-result-object v2

    .line 134
    :cond_5
    invoke-virtual {v9, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 135
    iget-object v2, v1, Lcom/mrkeyboard/app/MrAppList$Found;->pkg:Ljava/lang/String;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrAppList$Found;->source:Ljava/lang/String;

    invoke-virtual {v10, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_6

    .line 128
    :catch_1
    move-exception v5

    move-object v5, v1

    goto :goto_5

    .line 137
    :cond_6
    invoke-static {v9}, Lcom/mrkeyboard/app/MrAppList;->sort(Ljava/util/List;)V

    .line 139
    :try_start_2
    new-instance v1, Lcom/mrkeyboard/app/MrAppCache$Snapshot;

    invoke-direct {v1, v7, v6, v9, v10}, Lcom/mrkeyboard/app/MrAppCache$Snapshot;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/Map;)V

    move-object/from16 v0, p1

    invoke-interface {v0, v1}, Lcom/mrkeyboard/app/MrAppCache$Store;->write(Lcom/mrkeyboard/app/MrAppCache$Snapshot;)V
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_2

    .line 143
    :goto_7
    if-eqz v4, :cond_7

    iget-object v1, v3, Lcom/mrkeyboard/app/MrAppCache$Snapshot;->entries:Ljava/util/List;

    invoke-static {v1, v9}, Lcom/mrkeyboard/app/MrAppCache;->same(Ljava/util/List;Ljava/util/List;)Z

    move-result v1

    if-nez v1, :cond_0

    :cond_7
    move-object/from16 v0, p2

    invoke-interface {v0, v9}, Lcom/mrkeyboard/app/MrAppPicker$Sink;->publish(Ljava/util/List;)V

    goto/16 :goto_3

    .line 140
    :catch_2
    move-exception v1

    goto :goto_7

    :cond_8
    move v4, v1

    goto/16 :goto_2

    :cond_9
    move-object v3, v1

    goto/16 :goto_1
.end method

.method static same(Ljava/util/List;Ljava/util/List;)Z
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;)Z"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 85
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 89
    :cond_0
    :goto_0
    return v2

    :cond_1
    move v1, v2

    .line 86
    :goto_1
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_2

    .line 87
    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Entry;

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Entry;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Entry;

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAppList$Entry;->label:Ljava/lang/String;

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Entry;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAppList$Entry;->label:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 86
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 89
    :cond_2
    const/4 v2, 0x1

    goto :goto_0
.end method

.method static signature(Ljava/util/List;)Ljava/lang/String;
    .locals 8
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
    const/4 v1, 0x0

    .line 62
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 63
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Found;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v5, v0, Lcom/mrkeyboard/app/MrAppList$Found;->pkg:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\n"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAppList$Found;->source:Ljava/lang/String;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 64
    :cond_0
    invoke-static {v2}, Ljava/util/Collections;->sort(Ljava/util/List;)V

    .line 66
    :try_start_0
    const-string v0, "SHA-1"

    invoke-static {v0}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v3

    .line 67
    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 68
    const-string v5, "UTF-8"

    invoke-virtual {v0, v5}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/security/MessageDigest;->update([B)V

    .line 69
    const/4 v0, 0x0

    invoke-virtual {v3, v0}, Ljava/security/MessageDigest;->update(B)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 77
    :catch_0
    move-exception v0

    .line 79
    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_2
    return-object v0

    .line 71
    :cond_1
    :try_start_1
    invoke-virtual {v3}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v3

    .line 72
    new-instance v4, Ljava/lang/StringBuilder;

    array-length v0, v3

    mul-int/lit8 v0, v0, 0x2

    invoke-direct {v4, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 73
    array-length v5, v3

    move v0, v1

    :goto_3
    if-ge v0, v5, :cond_2

    aget-byte v1, v3, v0

    .line 74
    shr-int/lit8 v6, v1, 0x4

    and-int/lit8 v6, v6, 0xf

    const/16 v7, 0x10

    invoke-static {v6, v7}, Ljava/lang/Character;->forDigit(II)C

    move-result v6

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v6

    and-int/lit8 v1, v1, 0xf

    const/16 v7, 0x10

    invoke-static {v1, v7}, Ljava/lang/Character;->forDigit(II)C

    move-result v1

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 73
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 76
    :cond_2
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v0

    goto :goto_2
.end method

.method static source(Landroid/content/Context;)Lcom/mrkeyboard/app/MrAppPicker$Source;
    .locals 1

    .prologue
    .line 148
    new-instance v0, Lcom/mrkeyboard/app/MrAppCache$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrAppCache$1;-><init>(Landroid/content/Context;)V

    return-object v0
.end method
