.class public final Lcom/mrkeyboard/app/SheetStore;
.super Ljava/lang/Object;
.source "SheetStore.java"


# static fields
.field public static final BAK_FILE_NAME:Ljava/lang/String; = "sheets.json.bak"

.field public static final FILE_NAME:Ljava/lang/String; = "sheets.json"

.field private static final LOCK:Ljava/lang/Object;

.field public static final PREF_UPDATED_AT:Ljava/lang/String; = "pref_sheets_updated_at"

.field public static final RAW_DEFAULT_SHEETS_ID:I = 0x7f0b0001

.field private static final TAG:Ljava/lang/String; = "SheetStore"

.field public static final TMP_FILE_NAME:Ljava/lang/String; = "sheets.json.tmp"

.field private static volatile sCachedFirstBadge:Ljava/lang/String;

.field private static volatile sCachedSheets:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;"
        }
    .end annotation
.end field

.field private static volatile sReadOnlyView:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;"
        }
    .end annotation
.end field

.field private static sRecoveredFromCorrupt:Z


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 25
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/SheetStore;->LOCK:Ljava/lang/Object;

    .line 26
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/SheetStore;->sCachedSheets:Ljava/util/ArrayList;

    .line 27
    sput-object v0, Lcom/mrkeyboard/app/SheetStore;->sReadOnlyView:Ljava/util/List;

    .line 28
    sput-object v0, Lcom/mrkeyboard/app/SheetStore;->sCachedFirstBadge:Ljava/lang/String;

    .line 29
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/SheetStore;->sRecoveredFromCorrupt:Z

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static computeNextSheet(Landroid/content/Context;II)I
    .registers 4

    .line 132
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getSheetCount(Landroid/content/Context;)I

    move-result p0

    const/4 v0, 0x1

    add-int/2addr p0, v0

    .line 133
    if-ge p0, v0, :cond_9

    .line 134
    move p0, v0

    .line 136
    :cond_9
    if-gez p2, :cond_10

    .line 137
    sub-int/2addr p1, v0

    rem-int/2addr p1, p0

    add-int/2addr p1, p0

    rem-int/2addr p1, p0

    return p1

    .line 139
    :cond_10
    if-nez p2, :cond_15

    .line 140
    add-int/2addr p1, v0

    rem-int/2addr p1, p0

    return p1

    .line 142
    :cond_15
    sub-int/2addr p2, v0

    .line 143
    if-ltz p2, :cond_1b

    if-ge p2, p0, :cond_1b

    .line 144
    return p2

    .line 146
    :cond_1b
    const/4 p0, 0x0

    return p0
.end method

.method public static consumeCorruptRecoveryFlag()Z
    .registers 3

    .line 42
    sget-object v0, Lcom/mrkeyboard/app/SheetStore;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    .line 43
    :try_start_3
    sget-boolean v1, Lcom/mrkeyboard/app/SheetStore;->sRecoveredFromCorrupt:Z

    .line 44
    const/4 v2, 0x0

    sput-boolean v2, Lcom/mrkeyboard/app/SheetStore;->sRecoveredFromCorrupt:Z

    .line 45
    monitor-exit v0

    return v1

    .line 46
    :catchall_a
    move-exception v1

    monitor-exit v0
    :try_end_c
    .catchall {:try_start_3 .. :try_end_c} :catchall_a

    throw v1
.end method

.method private static ensureLoadedLocked(Landroid/content/Context;)V
    .registers 7

    .line 58
    sget-object v0, Lcom/mrkeyboard/app/SheetStore;->sCachedSheets:Ljava/util/ArrayList;

    if-eqz v0, :cond_5

    .line 59
    return-void

    .line 61
    :cond_5
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "sheets.json"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 62
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    const/4 v2, 0x1

    const-string v3, "SheetStore"

    if-eqz v1, :cond_44

    .line 64
    :try_start_19
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetStore;->readFileUtf8(Ljava/io/File;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetModel;->parseSheets(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v1

    .line 65
    invoke-static {v1}, Lcom/mrkeyboard/app/SheetStore;->setCacheLocked(Ljava/util/ArrayList;)V
    :try_end_24
    .catch Ljava/lang/Exception; {:try_start_19 .. :try_end_24} :catch_25

    .line 66
    return-void

    .line 67
    :catch_25
    move-exception v1

    .line 68
    const-string v4, "Corrupted sheets.json, backing up and restoring defaults"

    invoke-static {v3, v4, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 69
    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v4

    const-string v5, "sheets.json.bak"

    invoke-direct {v1, v4, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 70
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_3f

    .line 71
    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    .line 73
    :cond_3f
    invoke-virtual {v0, v1}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    .line 74
    sput-boolean v2, Lcom/mrkeyboard/app/SheetStore;->sRecoveredFromCorrupt:Z

    .line 78
    :cond_44
    :try_start_44
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->loadDefaultsFromRaw(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    .line 79
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetModel;->serializeSheetsCompact(Ljava/util/List;)Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/SheetStore;->writeAtomicallyLocked(Landroid/content/Context;Ljava/lang/String;)V

    .line 80
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetStore;->setCacheLocked(Ljava/util/ArrayList;)V
    :try_end_52
    .catch Ljava/lang/Exception; {:try_start_44 .. :try_end_52} :catch_53

    .line 86
    goto :goto_6e

    .line 81
    :catch_53
    move-exception p0

    .line 82
    const-string v0, "Fallback in-memory sheet creation"

    invoke-static {v3, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 83
    new-instance p0, Ljava/util/ArrayList;

    invoke-direct {p0, v2}, Ljava/util/ArrayList;-><init>(I)V

    .line 84
    const-string v0, "S\u00edmbolos"

    const-string v1, "123"

    const-string v2, "symbols"

    invoke-static {v2, v0, v1}, Lcom/mrkeyboard/app/SheetModel;->createNumpadTemplate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 85
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->setCacheLocked(Ljava/util/ArrayList;)V

    .line 87
    :goto_6e
    return-void
.end method

.method public static exportJsonString(Landroid/content/Context;)Ljava/lang/String;
    .registers 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 246
    sget-object v0, Lcom/mrkeyboard/app/SheetStore;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    .line 247
    :try_start_3
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->ensureLoadedLocked(Landroid/content/Context;)V

    .line 248
    sget-object p0, Lcom/mrkeyboard/app/SheetStore;->sCachedSheets:Ljava/util/ArrayList;

    invoke-static {p0}, Lcom/mrkeyboard/app/SheetModel;->serializeSheets(Ljava/util/List;)Ljava/lang/String;

    move-result-object p0

    monitor-exit v0

    return-object p0

    .line 249
    :catchall_e
    move-exception p0

    monitor-exit v0
    :try_end_10
    .catchall {:try_start_3 .. :try_end_10} :catchall_e

    throw p0
.end method

.method public static findSheetIndexById(Landroid/content/Context;Ljava/lang/String;)I
    .registers 6

    .line 162
    const/4 v0, -0x1

    if-eqz p0, :cond_24

    if-nez p1, :cond_6

    goto :goto_24

    .line 163
    :cond_6
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getSheets(Landroid/content/Context;)Ljava/util/List;

    move-result-object p0

    .line 164
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x0

    :goto_f
    if-ge v2, v1, :cond_23

    .line 165
    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_20

    .line 166
    return v2

    .line 164
    :cond_20
    add-int/lit8 v2, v2, 0x1

    goto :goto_f

    .line 169
    :cond_23
    return v0

    .line 162
    :cond_24
    :goto_24
    return v0
.end method

.method public static getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/ArrayList<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;"
        }
    .end annotation

    .line 173
    sget-object v0, Lcom/mrkeyboard/app/SheetStore;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    .line 174
    :try_start_3
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->ensureLoadedLocked(Landroid/content/Context;)V

    .line 175
    sget-object p0, Lcom/mrkeyboard/app/SheetStore;->sCachedSheets:Ljava/util/ArrayList;

    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result p0

    .line 176
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, p0}, Ljava/util/ArrayList;-><init>(I)V

    .line 177
    const/4 v2, 0x0

    :goto_12
    if-ge v2, p0, :cond_26

    .line 178
    sget-object v3, Lcom/mrkeyboard/app/SheetStore;->sCachedSheets:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 177
    add-int/lit8 v2, v2, 0x1

    goto :goto_12

    .line 180
    :cond_26
    monitor-exit v0

    return-object v1

    .line 181
    :catchall_28
    move-exception p0

    monitor-exit v0
    :try_end_2a
    .catchall {:try_start_3 .. :try_end_2a} :catchall_28

    throw p0
.end method

.method public static getFirstBadge(Landroid/content/Context;)Ljava/lang/String;
    .registers 2

    .line 118
    sget-object v0, Lcom/mrkeyboard/app/SheetStore;->sCachedFirstBadge:Ljava/lang/String;

    .line 119
    if-eqz v0, :cond_5

    .line 120
    return-object v0

    .line 122
    :cond_5
    if-nez p0, :cond_a

    .line 123
    const-string p0, "123"

    return-object p0

    .line 125
    :cond_a
    sget-object v0, Lcom/mrkeyboard/app/SheetStore;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    .line 126
    :try_start_d
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->ensureLoadedLocked(Landroid/content/Context;)V

    .line 127
    sget-object p0, Lcom/mrkeyboard/app/SheetStore;->sCachedFirstBadge:Ljava/lang/String;

    monitor-exit v0

    return-object p0

    .line 128
    :catchall_14
    move-exception p0

    monitor-exit v0
    :try_end_16
    .catchall {:try_start_d .. :try_end_16} :catchall_14

    throw p0
.end method

.method public static getSheetCopyById(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .registers 7

    .line 185
    const/4 v0, 0x0

    if-eqz p0, :cond_33

    if-nez p1, :cond_6

    goto :goto_33

    .line 186
    :cond_6
    sget-object v1, Lcom/mrkeyboard/app/SheetStore;->LOCK:Ljava/lang/Object;

    monitor-enter v1

    .line 187
    :try_start_9
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->ensureLoadedLocked(Landroid/content/Context;)V

    .line 188
    sget-object p0, Lcom/mrkeyboard/app/SheetStore;->sCachedSheets:Ljava/util/ArrayList;

    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result p0

    const/4 v2, 0x0

    :goto_13
    if-ge v2, p0, :cond_2e

    .line 189
    sget-object v3, Lcom/mrkeyboard/app/SheetStore;->sCachedSheets:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 190
    iget-object v4, v3, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {p1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2b

    .line 191
    invoke-virtual {v3}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object p0

    monitor-exit v1

    return-object p0

    .line 188
    :cond_2b
    add-int/lit8 v2, v2, 0x1

    goto :goto_13

    .line 194
    :cond_2e
    monitor-exit v1

    return-object v0

    .line 195
    :catchall_30
    move-exception p0

    monitor-exit v1
    :try_end_32
    .catchall {:try_start_9 .. :try_end_32} :catchall_30

    throw p0

    .line 185
    :cond_33
    :goto_33
    return-object v0
.end method

.method public static getSheetCount(Landroid/content/Context;)I
    .registers 2

    .line 104
    sget-object v0, Lcom/mrkeyboard/app/SheetStore;->sCachedSheets:Ljava/util/ArrayList;

    .line 105
    if-eqz v0, :cond_9

    .line 106
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result p0

    return p0

    .line 108
    :cond_9
    if-nez p0, :cond_d

    .line 109
    const/4 p0, 0x4

    return p0

    .line 111
    :cond_d
    sget-object v0, Lcom/mrkeyboard/app/SheetStore;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    .line 112
    :try_start_10
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->ensureLoadedLocked(Landroid/content/Context;)V

    .line 113
    sget-object p0, Lcom/mrkeyboard/app/SheetStore;->sCachedSheets:Ljava/util/ArrayList;

    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result p0

    monitor-exit v0

    return p0

    .line 114
    :catchall_1b
    move-exception p0

    monitor-exit v0
    :try_end_1d
    .catchall {:try_start_10 .. :try_end_1d} :catchall_1b

    throw p0
.end method

.method public static getSheets(Landroid/content/Context;)Ljava/util/List;
    .registers 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;"
        }
    .end annotation

    .line 90
    sget-object v0, Lcom/mrkeyboard/app/SheetStore;->sReadOnlyView:Ljava/util/List;

    .line 91
    if-eqz v0, :cond_5

    .line 92
    return-object v0

    .line 94
    :cond_5
    if-nez p0, :cond_c

    .line 95
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object p0

    return-object p0

    .line 97
    :cond_c
    sget-object v0, Lcom/mrkeyboard/app/SheetStore;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    .line 98
    :try_start_f
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->ensureLoadedLocked(Landroid/content/Context;)V

    .line 99
    sget-object p0, Lcom/mrkeyboard/app/SheetStore;->sReadOnlyView:Ljava/util/List;

    monitor-exit v0

    return-object p0

    .line 100
    :catchall_16
    move-exception p0

    monitor-exit v0
    :try_end_18
    .catchall {:try_start_f .. :try_end_18} :catchall_16

    throw p0
.end method

.method public static importJsonString(Landroid/content/Context;Ljava/lang/String;)I
    .registers 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 253
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetModel;->parseSheets(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object p1

    .line 254
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    move-result p0

    if-eqz p0, :cond_f

    .line 255
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p0

    return p0

    .line 257
    :cond_f
    new-instance p0, Ljava/io/IOException;

    const-string p1, "Could not save imported sheets"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static invalidateCache()V
    .registers 2

    .line 34
    sget-object v0, Lcom/mrkeyboard/app/SheetStore;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    .line 35
    const/4 v1, 0x0

    :try_start_4
    sput-object v1, Lcom/mrkeyboard/app/SheetStore;->sCachedSheets:Ljava/util/ArrayList;

    .line 36
    sput-object v1, Lcom/mrkeyboard/app/SheetStore;->sReadOnlyView:Ljava/util/List;

    .line 37
    sput-object v1, Lcom/mrkeyboard/app/SheetStore;->sCachedFirstBadge:Ljava/lang/String;

    .line 38
    monitor-exit v0

    .line 39
    return-void

    .line 38
    :catchall_c
    move-exception v1

    monitor-exit v0
    :try_end_e
    .catchall {:try_start_4 .. :try_end_e} :catchall_c

    throw v1
.end method

.method public static loadDefaultBuiltinSheet(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .registers 6

    .line 262
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->loadDefaultsFromRaw(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object p0

    .line 263
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    :goto_9
    if-ge v1, v0, :cond_1d

    .line 264
    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 265
    iget-object v3, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3
    :try_end_17
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_17} :catch_1e

    if-eqz v3, :cond_1a

    .line 266
    return-object v2

    .line 263
    :cond_1a
    add-int/lit8 v1, v1, 0x1

    goto :goto_9

    .line 271
    :cond_1d
    goto :goto_37

    .line 269
    :catch_1e
    move-exception p0

    .line 270
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Failed to load default builtin sheet: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "SheetStore"

    invoke-static {v0, p1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 272
    :goto_37
    const/4 p0, 0x0

    return-object p0
.end method

.method private static loadDefaultsFromRaw(Landroid/content/Context;)Ljava/util/ArrayList;
    .registers 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/ArrayList<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 290
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    const v0, 0x7f0b0001

    invoke-virtual {p0, v0}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;

    move-result-object p0

    .line 292
    :try_start_b
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->readStreamUtf8(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetModel;->parseSheets(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0
    :try_end_13
    .catchall {:try_start_b .. :try_end_13} :catchall_1a

    .line 295
    :try_start_13
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_16
    .catch Ljava/io/IOException; {:try_start_13 .. :try_end_16} :catch_17

    .line 296
    :goto_16
    goto :goto_19

    :catch_17
    move-exception p0

    goto :goto_16

    .line 292
    :goto_19
    return-object v0

    .line 294
    :catchall_1a
    move-exception v0

    .line 295
    :try_start_1b
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_1e
    .catch Ljava/io/IOException; {:try_start_1b .. :try_end_1e} :catch_1f

    .line 296
    :goto_1e
    goto :goto_21

    :catch_1f
    move-exception p0

    goto :goto_1e

    .line 297
    :goto_21
    throw v0
.end method

.method private static notifyChanged(Landroid/content/Context;)V
    .registers 4

    .line 302
    :try_start_0
    new-instance v0, Landroid/app/backup/BackupManager;

    invoke-direct {v0, p0}, Landroid/app/backup/BackupManager;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0}, Landroid/app/backup/BackupManager;->dataChanged()V
    :try_end_8
    .catchall {:try_start_0 .. :try_end_8} :catchall_9

    goto :goto_a

    .line 303
    :catchall_9
    move-exception v0

    :goto_a
    nop

    .line 305
    :try_start_b
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object p0

    .line 306
    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    const-string v0, "pref_sheets_updated_at"

    .line 307
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-interface {p0, v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    .line 308
    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_20
    .catchall {:try_start_b .. :try_end_20} :catchall_21

    goto :goto_22

    .line 309
    :catchall_21
    move-exception p0

    :goto_22
    nop

    .line 310
    invoke-static {}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInstance()Lcom/mrkeyboard/app/KeyboardSwitcher;

    move-result-object p0

    .line 311
    if-eqz p0, :cond_2f

    .line 313
    :try_start_29
    invoke-virtual {p0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->onSheetsChanged()V
    :try_end_2c
    .catchall {:try_start_29 .. :try_end_2c} :catchall_2d

    .line 314
    :goto_2c
    goto :goto_2f

    :catchall_2d
    move-exception p0

    goto :goto_2c

    .line 316
    :cond_2f
    :goto_2f
    return-void
.end method

.method private static readFileUtf8(Ljava/io/File;)Ljava/lang/String;
    .registers 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 319
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 321
    :try_start_5
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetStore;->readStreamUtf8(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object p0
    :try_end_9
    .catchall {:try_start_5 .. :try_end_9} :catchall_d

    .line 323
    invoke-virtual {v0}, Ljava/io/FileInputStream;->close()V

    .line 321
    return-object p0

    .line 323
    :catchall_d
    move-exception p0

    invoke-virtual {v0}, Ljava/io/FileInputStream;->close()V

    .line 324
    throw p0
.end method

.method public static readStreamUtf8(Ljava/io/InputStream;)Ljava/lang/String;
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 328
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    const/16 v1, 0x1000

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 329
    new-array v1, v1, [B

    .line 331
    :goto_9
    invoke-virtual {p0, v1}, Ljava/io/InputStream;->read([B)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_15

    .line 332
    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_9

    .line 334
    :cond_15
    const-string p0, "UTF-8"

    invoke-virtual {v0, p0}, Ljava/io/ByteArrayOutputStream;->toString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static resetAllToDefaults(Landroid/content/Context;)Z
    .registers 3

    .line 282
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->loadDefaultsFromRaw(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    move-result p0
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_8} :catch_9

    return p0

    .line 283
    :catch_9
    move-exception p0

    .line 284
    const-string v0, "SheetStore"

    const-string v1, "Failed to reset all sheets"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 285
    const/4 p0, 0x0

    return p0
.end method

.method public static resetBuiltinSheet(Landroid/content/Context;Ljava/lang/String;)Z
    .registers 2

    .line 276
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetStore;->loadDefaultBuiltinSheet(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object p1

    .line 277
    if-eqz p1, :cond_e

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetStore;->updateSingleSheet(Landroid/content/Context;Lcom/mrkeyboard/app/SheetModel$Sheet;)Z

    move-result p0

    if-eqz p0, :cond_e

    const/4 p0, 0x1

    goto :goto_f

    :cond_e
    const/4 p0, 0x0

    :goto_f
    return p0
.end method

.method public static resolveKeyboardXmlId(Landroid/content/Context;I)I
    .registers 4

    .line 150
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getSheetCount(Landroid/content/Context;)I

    move-result p0

    .line 151
    if-gtz p0, :cond_a

    .line 152
    const p0, 0x7f0f000c

    return p0

    .line 154
    :cond_a
    const/4 v0, 0x0

    const/4 v1, 0x1

    if-lt p1, v1, :cond_10

    sub-int/2addr p1, v1

    goto :goto_11

    :cond_10
    move p1, v0

    .line 155
    :goto_11
    if-ltz p1, :cond_18

    if-lt p1, p0, :cond_16

    goto :goto_18

    :cond_16
    move v0, p1

    goto :goto_19

    .line 156
    :cond_18
    :goto_18
    nop

    .line 158
    :goto_19
    rsub-int p0, v0, -0x3e8

    return p0
.end method

.method public static save(Landroid/content/Context;Ljava/util/List;)Z
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;)Z"
        }
    .end annotation

    .line 199
    const/4 v0, 0x0

    if-eqz p0, :cond_39

    if-nez p1, :cond_c

    goto :goto_39

    .line 202
    :cond_c
    sget-object v1, Lcom/mrkeyboard/app/SheetStore;->LOCK:Ljava/lang/Object;

    monitor-enter v1

    .line 204
    :try_start_f
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeSheetsCopy(Ljava/util/List;)Ljava/util/ArrayList;

    move-result-object p1

    .line 208
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetModel;->serializeSheetsCompact(Ljava/util/List;)Ljava/lang/String;

    move-result-object v2

    .line 209
    invoke-static {p0, v2}, Lcom/mrkeyboard/app/SheetStore;->writeAtomicallyLocked(Landroid/content/Context;Ljava/lang/String;)V

    .line 210
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetStore;->setCacheLocked(Ljava/util/ArrayList;)V

    .line 211
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->notifyChanged(Landroid/content/Context;)V
    :try_end_28
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_28} :catch_2d
    .catchall {:try_start_f .. :try_end_28} :catchall_2b

    .line 212
    :try_start_28
    monitor-exit v1

    const/4 p0, 0x1

    return p0

    .line 217
    :catchall_2b
    move-exception p0

    goto :goto_37

    .line 213
    :catch_2d
    move-exception p0

    .line 214
    const-string p1, "SheetStore"

    const-string v2, "Failed to save sheets.json"

    invoke-static {p1, v2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 215
    monitor-exit v1

    return v0

    .line 217
    :goto_37
    monitor-exit v1
    :try_end_38
    .catchall {:try_start_28 .. :try_end_38} :catchall_2b

    throw p0

    .line 200
    :cond_39
    :goto_39
    return v0
.end method

.method private static setCacheLocked(Ljava/util/ArrayList;)V
    .registers 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;)V"
        }
    .end annotation

    .line 50
    sput-object p0, Lcom/mrkeyboard/app/SheetStore;->sCachedSheets:Ljava/util/ArrayList;

    .line 51
    invoke-static {p0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/SheetStore;->sReadOnlyView:Ljava/util/List;

    .line 52
    invoke-virtual {p0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_11

    .line 53
    const-string v1, "\u2014"

    goto :goto_1e

    .line 54
    :cond_11
    const-string v1, "123"

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object p0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :goto_1e
    sput-object v1, Lcom/mrkeyboard/app/SheetStore;->sCachedFirstBadge:Ljava/lang/String;

    .line 55
    return-void
.end method

.method public static updateSingleSheet(Landroid/content/Context;Lcom/mrkeyboard/app/SheetModel$Sheet;)Z
    .registers 10

    .line 221
    const/4 v0, 0x0

    if-eqz p0, :cond_50

    if-nez p1, :cond_6

    goto :goto_50

    .line 224
    :cond_6
    sget-object v1, Lcom/mrkeyboard/app/SheetStore;->LOCK:Ljava/lang/Object;

    monitor-enter v1

    .line 225
    :try_start_9
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->ensureLoadedLocked(Landroid/content/Context;)V

    .line 226
    sget-object v2, Lcom/mrkeyboard/app/SheetStore;->sCachedSheets:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    .line 227
    new-instance v3, Ljava/util/ArrayList;

    add-int/lit8 v4, v2, 0x1

    invoke-direct {v3, v4}, Ljava/util/ArrayList;-><init>(I)V

    .line 228
    nop

    .line 229
    move v4, v0

    :goto_1b
    if-ge v0, v2, :cond_3a

    .line 230
    sget-object v5, Lcom/mrkeyboard/app/SheetStore;->sCachedSheets:Ljava/util/ArrayList;

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 231
    iget-object v6, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    iget-object v7, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_34

    .line 232
    invoke-virtual {v3, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 233
    const/4 v4, 0x1

    goto :goto_37

    .line 235
    :cond_34
    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 229
    :goto_37
    add-int/lit8 v0, v0, 0x1

    goto :goto_1b

    .line 238
    :cond_3a
    if-nez v4, :cond_47

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v2, 0xc

    if-ge v0, v2, :cond_47

    .line 239
    invoke-virtual {v3, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 241
    :cond_47
    invoke-static {p0, v3}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    move-result p0

    monitor-exit v1

    return p0

    .line 242
    :catchall_4d
    move-exception p0

    monitor-exit v1
    :try_end_4f
    .catchall {:try_start_9 .. :try_end_4f} :catchall_4d

    throw p0

    .line 222
    :cond_50
    :goto_50
    return v0
.end method

.method private static writeAtomicallyLocked(Landroid/content/Context;Ljava/lang/String;)V
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 338
    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object p0

    .line 339
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_d

    .line 340
    invoke-virtual {p0}, Ljava/io/File;->mkdirs()Z

    .line 342
    :cond_d
    new-instance v0, Ljava/io/File;

    const-string v1, "sheets.json.tmp"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 343
    new-instance v1, Ljava/io/File;

    const-string v2, "sheets.json"

    invoke-direct {v1, p0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 344
    const-string p0, "UTF-8"

    invoke-virtual {p1, p0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object p0

    .line 345
    new-instance p1, Ljava/io/FileOutputStream;

    invoke-direct {p1, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 347
    :try_start_26
    invoke-virtual {p1, p0}, Ljava/io/FileOutputStream;->write([B)V

    .line 348
    invoke-virtual {p1}, Ljava/io/FileOutputStream;->flush()V
    :try_end_2c
    .catchall {:try_start_26 .. :try_end_2c} :catchall_5e

    .line 350
    invoke-virtual {p1}, Ljava/io/FileOutputStream;->close()V

    .line 351
    nop

    .line 352
    invoke-virtual {v0, v1}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result p1

    if-nez p1, :cond_5d

    .line 353
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_3f

    .line 354
    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    .line 356
    :cond_3f
    invoke-virtual {v0, v1}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result p1

    if-nez p1, :cond_5d

    .line 357
    new-instance p1, Ljava/io/FileOutputStream;

    invoke-direct {p1, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 359
    :try_start_4a
    invoke-virtual {p1, p0}, Ljava/io/FileOutputStream;->write([B)V

    .line 360
    invoke-virtual {p1}, Ljava/io/FileOutputStream;->flush()V
    :try_end_50
    .catchall {:try_start_4a .. :try_end_50} :catchall_58

    .line 362
    invoke-virtual {p1}, Ljava/io/FileOutputStream;->close()V

    .line 363
    nop

    .line 364
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    goto :goto_5d

    .line 362
    :catchall_58
    move-exception p0

    invoke-virtual {p1}, Ljava/io/FileOutputStream;->close()V

    .line 363
    throw p0

    .line 367
    :cond_5d
    :goto_5d
    return-void

    .line 350
    :catchall_5e
    move-exception p0

    invoke-virtual {p1}, Ljava/io/FileOutputStream;->close()V

    .line 351
    throw p0
.end method
