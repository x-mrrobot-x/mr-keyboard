.class public final Lcom/mrkeyboard/app/MrAbcKeys;
.super Ljava/lang/Object;
.source "MrAbcKeys.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrAbcKeys$Model;,
        Lcom/mrkeyboard/app/MrAbcKeys$Entry;
    }
.end annotation


# static fields
.field static final BACKUP_FIELD:Ljava/lang/String; = "abcKeys"

.field static final CODE_DELETE:I = -0x5

.field static final DEFAULT_POPUP:Ljava/lang/String; = "mrDefaultPopup"

.field public static final ID:Ljava/lang/String; = "abc"

.field static final MODE_NORMAL:I = 0x7f08005b

.field static final PREF:Ljava/lang/String; = "pref_abc_keys"

.field static final XML_COMPACT:I = 0x7f0f0001

.field static final XML_FULL:I = 0x7f0f0005

.field static final XML_QWERTY:I = 0x7f0f000b

.field private static sCached:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/MrAbcKeys$Entry;",
            ">;"
        }
    .end annotation
.end field

.field private static sCachedRaw:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 50
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrAbcKeys;->sCached:Ljava/util/Map;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 52
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static addToBackup(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 345
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAbcKeys;->read(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 346
    if-eqz p1, :cond_0

    if-eqz v0, :cond_0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->entries(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Map;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 352
    :cond_0
    :goto_0
    return-object p1

    .line 348
    :cond_1
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 349
    const-string v2, "abcKeys"

    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 350
    const/4 v0, 0x2

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->toString(I)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object p1

    goto :goto_0

    .line 351
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static apply(Landroid/content/Context;Lcom/mrkeyboard/app/Keyboard;I)V
    .locals 7

    .prologue
    .line 376
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    invoke-static {p2}, Lcom/mrkeyboard/app/MrAbcKeys;->isAbcXml(I)Z

    move-result v0

    if-nez v0, :cond_1

    .line 391
    :cond_0
    :goto_0
    return-void

    .line 378
    :cond_1
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAbcKeys;->read(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->cached(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v3

    .line 379
    invoke-interface {v3}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 380
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getSheets(Landroid/content/Context;)Ljava/util/List;

    move-result-object v4

    .line 381
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    .line 382
    invoke-virtual {p1}, Lcom/mrkeyboard/app/Keyboard;->getKeys()Ljava/util/List;

    move-result-object v6

    .line 383
    const/4 v0, 0x0

    move v2, v0

    :goto_1
    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v0

    if-ge v2, v0, :cond_0

    .line 384
    invoke-interface {v6, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/Keyboard$Key;

    .line 385
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->editable(Lcom/mrkeyboard/app/Keyboard$Key;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 383
    :cond_2
    :goto_2
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    .line 386
    :cond_3
    iget-object v1, v0, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v3, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/MrAbcKeys$Entry;

    .line 387
    if-eqz v1, :cond_2

    invoke-static {v5, v4, v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->put(Landroid/content/res/Resources;Ljava/util/List;Lcom/mrkeyboard/app/Keyboard$Key;Lcom/mrkeyboard/app/MrAbcKeys$Entry;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 389
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static blankToNull(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 249
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    const/4 p0, 0x0

    :cond_1
    return-object p0
.end method

.method private static declared-synchronized cached(Ljava/lang/String;)Ljava/util/Map;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/MrAbcKeys$Entry;",
            ">;"
        }
    .end annotation

    .prologue
    .line 395
    const-class v1, Lcom/mrkeyboard/app/MrAbcKeys;

    monitor-enter v1

    if-nez p0, :cond_0

    :try_start_0
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 400
    :goto_0
    monitor-exit v1

    return-object v0

    .line 396
    :cond_0
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrAbcKeys;->sCachedRaw:Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 397
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAbcKeys;->entries(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrAbcKeys;->sCached:Ljava/util/Map;

    .line 398
    sput-object p0, Lcom/mrkeyboard/app/MrAbcKeys;->sCachedRaw:Ljava/lang/String;

    .line 400
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrAbcKeys;->sCached:Ljava/util/Map;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 395
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static capital(Lcom/mrkeyboard/app/Keyboard$Key;)Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v1, 0x0

    const/4 v3, 0x0

    .line 417
    if-eqz p0, :cond_0

    iget-boolean v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->text:Ljava/lang/CharSequence;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    array-length v0, v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    aget v0, v0, v3

    const/16 v2, 0x20

    if-gt v0, v2, :cond_2

    :cond_0
    move-object v0, v1

    .line 420
    :cond_1
    :goto_0
    return-object v0

    .line 418
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    aget v0, v0, v3

    int-to-char v0, v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v2

    .line 419
    sget-object v0, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v2, v0}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 420
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v4, 0x1

    if-ne v3, v4, :cond_3

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    :cond_3
    move-object v0, v1

    goto :goto_0
.end method

.method static copy(Lcom/mrkeyboard/app/SheetModel$KeySpec;)Lcom/mrkeyboard/app/SheetModel$KeySpec;
    .locals 5

    .prologue
    .line 426
    new-instance v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    iget v4, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-direct {v1, v0, v2, v3, v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    .line 427
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    iput-object v0, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    .line 428
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    iput-object v0, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    .line 429
    return-object v1

    .line 428
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->copyList(Ljava/util/List;)Ljava/util/ArrayList;

    move-result-object v0

    goto :goto_0
.end method

.method static copyList(Ljava/util/List;)Ljava/util/ArrayList;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            ">;)",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            ">;"
        }
    .end annotation

    .prologue
    .line 433
    new-instance v2, Ljava/util/ArrayList;

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    invoke-direct {v2, v0}, Ljava/util/ArrayList;-><init>(I)V

    .line 434
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->copy(Lcom/mrkeyboard/app/SheetModel$KeySpec;)Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 435
    :cond_0
    return-object v2
.end method

.method static copySheet(Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .locals 4

    .prologue
    .line 439
    new-instance v2, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {v2}, Lcom/mrkeyboard/app/SheetModel$Sheet;-><init>()V

    .line 440
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    iput-object v0, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 441
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    iput-object v0, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 442
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    iput-object v0, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 443
    iget-boolean v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    iput-boolean v0, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 444
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    .line 445
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    .line 446
    new-instance v3, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {v3}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    .line 447
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->copyList(Ljava/util/List;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, v3, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    .line 448
    iget-object v0, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 445
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 450
    :cond_0
    return-object v2
.end method

.method public static count(Landroid/content/Context;)I
    .locals 1

    .prologue
    .line 307
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAbcKeys;->read(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->entries(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v0

    return v0
.end method

.method static diff(Lcom/mrkeyboard/app/MrAbcKeys$Model;Lcom/mrkeyboard/app/SheetModel$Sheet;)Ljava/util/Map;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/mrkeyboard/app/MrAbcKeys$Model;",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ")",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/MrAbcKeys$Entry;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v8, 0x0

    const/4 v3, 0x0

    .line 213
    new-instance v5, Ljava/util/LinkedHashMap;

    invoke-direct {v5}, Ljava/util/LinkedHashMap;-><init>()V

    move v2, v3

    .line 214
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->ids:[[Ljava/lang/String;

    array-length v0, v0

    if-ge v2, v0, :cond_5

    iget-object v0, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v2, v0, :cond_5

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->defaults:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v2, v0, :cond_5

    move v4, v3

    .line 215
    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->ids:[[Ljava/lang/String;

    aget-object v0, v0, v2

    array-length v0, v0

    if-ge v4, v0, :cond_4

    iget-object v0, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v4, v0, :cond_4

    .line 216
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->ids:[[Ljava/lang/String;

    aget-object v0, v0, v2

    aget-object v6, v0, v4

    .line 217
    if-nez v6, :cond_1

    .line 215
    :cond_0
    :goto_2
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_1

    .line 218
    :cond_1
    iget-object v0, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 219
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->defaults:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 220
    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->samePopup(Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/SheetModel$KeySpec;)Z

    move-result v7

    .line 221
    if-eqz v7, :cond_2

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->sameAction(Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/SheetModel$KeySpec;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 222
    :cond_2
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->copy(Lcom/mrkeyboard/app/SheetModel$KeySpec;)Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v0

    .line 223
    if-eqz v7, :cond_3

    .line 224
    iput-object v8, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    .line 225
    iput-object v8, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    .line 227
    :cond_3
    new-instance v1, Lcom/mrkeyboard/app/MrAbcKeys$Entry;

    invoke-direct {v1, v0, v7}, Lcom/mrkeyboard/app/MrAbcKeys$Entry;-><init>(Lcom/mrkeyboard/app/SheetModel$KeySpec;Z)V

    invoke-virtual {v5, v6, v1}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    .line 214
    :cond_4
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    .line 230
    :cond_5
    return-object v5
.end method

.method static editable(Lcom/mrkeyboard/app/Keyboard$Key;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 100
    if-eqz p0, :cond_0

    iget-boolean v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->icon:Landroid/graphics/drawable/Drawable;

    if-nez v1, :cond_0

    iget v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    and-int/lit8 v1, v1, 0x8

    if-eqz v1, :cond_1

    .line 102
    :cond_0
    :goto_0
    return v0

    .line 101
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-eqz v1, :cond_0

    .line 102
    iget-object v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    array-length v1, v1

    if-lez v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    aget v1, v1, v0

    const/16 v2, 0x20

    if-le v1, v2, :cond_0

    const/4 v0, 0x1

    goto :goto_0
.end method

.method static entries(Ljava/lang/String;)Ljava/util/Map;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/MrAbcKeys$Entry;",
            ">;"
        }
    .end annotation

    .prologue
    .line 277
    new-instance v1, Ljava/util/LinkedHashMap;

    invoke-direct {v1}, Ljava/util/LinkedHashMap;-><init>()V

    .line 278
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    move-object v0, v1

    .line 294
    :goto_0
    return-object v0

    .line 280
    :cond_1
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v2, "keys"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v2

    .line 281
    if-nez v2, :cond_2

    move-object v0, v1

    goto :goto_0

    .line 282
    :cond_2
    invoke-virtual {v2}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v3

    .line 283
    :cond_3
    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 284
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 285
    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    .line 286
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    if-eqz v5, :cond_3

    if-eqz v4, :cond_3

    .line 287
    const/4 v5, 0x1

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->fromJson(Lorg/json/JSONObject;Z)Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v5

    .line 288
    if-eqz v5, :cond_3

    const-string v6, "spacer"

    iget-object v7, v5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-static {v7}, Lcom/mrkeyboard/app/SheetModel;->normalizeType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_3

    .line 289
    new-instance v6, Lcom/mrkeyboard/app/MrAbcKeys$Entry;

    const-string v7, "mrDefaultPopup"

    const/4 v8, 0x0

    invoke-virtual {v4, v7, v8}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v4

    invoke-direct {v6, v5, v4}, Lcom/mrkeyboard/app/MrAbcKeys$Entry;-><init>(Lcom/mrkeyboard/app/SheetModel$KeySpec;Z)V

    invoke-virtual {v1, v0, v6}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 291
    :catch_0
    move-exception v0

    .line 292
    invoke-virtual {v1}, Ljava/util/LinkedHashMap;->clear()V

    :cond_4
    move-object v0, v1

    .line 294
    goto :goto_0
.end method

.method private static eq(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 253
    if-nez p0, :cond_1

    if-nez p1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    :cond_1
    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_0
.end method

.method static fromKeys(Ljava/util/List;I)Lcom/mrkeyboard/app/MrAbcKeys$Model;
    .locals 14
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/Keyboard$Key;",
            ">;I)",
            "Lcom/mrkeyboard/app/MrAbcKeys$Model;"
        }
    .end annotation

    .prologue
    .line 117
    if-lez p1, :cond_1

    int-to-float v0, p1

    const/high16 v1, 0x41200000    # 10.0f

    div-float/2addr v0, v1

    move v1, v0

    .line 118
    :goto_0
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    .line 119
    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9}, Ljava/util/ArrayList;-><init>()V

    .line 120
    const/high16 v4, -0x80000000

    .line 121
    const/4 v3, 0x0

    .line 122
    const/4 v2, 0x0

    .line 123
    const/4 v0, 0x0

    move v7, v0

    :goto_1
    if-eqz p0, :cond_5

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v7, v0, :cond_5

    .line 124
    invoke-interface {p0, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/Keyboard$Key;

    .line 125
    if-eqz v0, :cond_0

    iget v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    and-int/lit8 v5, v5, 0x8

    if-eqz v5, :cond_2

    .line 123
    :cond_0
    :goto_2
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_1

    .line 117
    :cond_1
    const/high16 v0, 0x3f800000    # 1.0f

    move v1, v0

    goto :goto_0

    .line 126
    :cond_2
    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    if-eqz v5, :cond_3

    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    array-length v5, v5

    if-lez v5, :cond_3

    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    const/4 v6, 0x0

    aget v5, v5, v6

    const/4 v6, -0x5

    if-eq v5, v6, :cond_0

    .line 127
    :cond_3
    if-eqz v3, :cond_4

    iget v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->y:I

    if-eq v5, v4, :cond_8

    .line 128
    :cond_4
    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x6

    if-lt v2, v3, :cond_7

    .line 156
    :cond_5
    const/4 v0, 0x0

    move v1, v0

    :goto_3
    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_f

    .line 157
    invoke-virtual {v8, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    .line 158
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v3, 0x1

    if-le v0, v3, :cond_6

    const-string v3, "spacer"

    const/4 v0, 0x0

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    const-string v3, "spacer"

    .line 159
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_6

    .line 160
    new-instance v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    new-instance v4, Ljava/lang/String;

    invoke-direct {v4}, Ljava/lang/String;-><init>()V

    const-string v5, "spacer"

    new-instance v6, Ljava/lang/String;

    invoke-direct {v6}, Ljava/lang/String;-><init>()V

    const/4 v0, 0x0

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-direct {v3, v4, v5, v6, v0}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 161
    invoke-virtual {v9, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 156
    :cond_6
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_3

    .line 129
    :cond_7
    new-instance v3, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {v3}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    .line 130
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 131
    invoke-virtual {v8, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 132
    invoke-virtual {v9, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 133
    iget v4, v0, Lcom/mrkeyboard/app/Keyboard$Key;->y:I

    .line 135
    :cond_8
    iget v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->gap:I

    int-to-float v5, v5

    div-float/2addr v5, v1

    .line 136
    const/high16 v6, 0x3e800000    # 0.25f

    cmpl-float v6, v5, v6

    if-ltz v6, :cond_9

    .line 137
    iget-object v6, v3, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance v10, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    new-instance v11, Ljava/lang/String;

    invoke-direct {v11}, Ljava/lang/String;-><init>()V

    const-string v12, "spacer"

    new-instance v13, Ljava/lang/String;

    invoke-direct {v13}, Ljava/lang/String;-><init>()V

    invoke-static {v5}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v5

    invoke-direct {v10, v11, v12, v13, v5}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {v6, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 138
    const/4 v5, 0x0

    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 140
    :cond_9
    iget v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->width:I

    int-to-float v5, v5

    div-float/2addr v5, v1

    invoke-static {v5}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v10

    .line 141
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->editable(Lcom/mrkeyboard/app/Keyboard$Key;)Z

    move-result v5

    if-eqz v5, :cond_c

    .line 142
    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v6

    .line 143
    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->text:Ljava/lang/CharSequence;

    if-eqz v5, :cond_b

    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->text:Ljava/lang/CharSequence;

    invoke-interface {v5}, Ljava/lang/CharSequence;->length()I

    move-result v5

    if-lez v5, :cond_b

    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->text:Ljava/lang/CharSequence;

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v5

    .line 144
    :goto_4
    new-instance v11, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v12, "text"

    invoke-direct {v11, v6, v12, v5, v10}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    .line 145
    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->popupCharacters:Ljava/lang/CharSequence;

    if-eqz v5, :cond_a

    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->popupCharacters:Ljava/lang/CharSequence;

    invoke-interface {v5}, Ljava/lang/CharSequence;->length()I

    move-result v5

    if-lez v5, :cond_a

    iget-object v0, v0, Lcom/mrkeyboard/app/Keyboard$Key;->popupCharacters:Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v11, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    .line 146
    :cond_a
    iget-object v0, v3, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0, v11}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 147
    invoke-virtual {v2, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :goto_2

    :cond_b
    move-object v5, v6

    .line 143
    goto :goto_4

    .line 149
    :cond_c
    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    if-eqz v5, :cond_d

    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    array-length v5, v5

    if-lez v5, :cond_d

    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    const/4 v6, 0x0

    aget v5, v5, v6

    .line 150
    :goto_5
    iget-object v6, v0, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    if-eqz v6, :cond_e

    iget-object v6, v0, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    invoke-interface {v6}, Ljava/lang/CharSequence;->length()I

    move-result v6

    if-lez v6, :cond_e

    iget-object v0, v0, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 151
    :goto_6
    iget-object v6, v3, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance v11, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v12, "special"

    invoke-static {v5}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v11, v0, v12, v5, v10}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {v6, v11}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 152
    const/4 v0, 0x0

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :goto_2

    .line 149
    :cond_d
    const/4 v5, 0x0

    goto :goto_5

    .line 150
    :cond_e
    invoke-static {v5}, Lcom/mrkeyboard/app/SpecialKeyPicker;->defaultLabelForCode(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_6

    .line 164
    :cond_f
    invoke-static {v8}, Lcom/mrkeyboard/app/MrAbcKeys;->sheet(Ljava/util/ArrayList;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v2

    .line 165
    invoke-virtual {v9}, Ljava/util/ArrayList;->size()I

    move-result v0

    new-array v3, v0, [[Ljava/lang/String;

    .line 166
    const/4 v0, 0x0

    move v1, v0

    :goto_7
    invoke-virtual {v9}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_10

    invoke-virtual {v9, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/String;

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    aput-object v0, v3, v1

    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_7

    .line 167
    :cond_10
    new-instance v0, Lcom/mrkeyboard/app/MrAbcKeys$Model;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrAbcKeys;->copySheet(Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v1

    invoke-direct {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrAbcKeys$Model;-><init>(Lcom/mrkeyboard/app/SheetModel$Sheet;Lcom/mrkeyboard/app/SheetModel$Sheet;[[Ljava/lang/String;)V

    return-object v0
.end method

.method static isAbcXml(I)Z
    .locals 1

    .prologue
    .line 107
    const v0, 0x7f0f000b

    if-eq p0, v0, :cond_0

    const v0, 0x7f0f0005

    if-eq p0, v0, :cond_0

    const v0, 0x7f0f0001

    if-ne p0, v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static load(Landroid/content/Context;)Lcom/mrkeyboard/app/MrAbcKeys$Model;
    .locals 6

    .prologue
    .line 182
    new-instance v0, Lcom/mrkeyboard/app/Keyboard;

    const/4 v2, 0x0

    const v3, 0x7f0f000b

    const v4, 0x7f08005b

    const/high16 v5, 0x42200000    # 40.0f

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/Keyboard;-><init>(Landroid/content/Context;IIIF)V

    .line 183
    invoke-virtual {v0}, Lcom/mrkeyboard/app/Keyboard;->getKeys()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0}, Lcom/mrkeyboard/app/Keyboard;->getMinWidth()I

    move-result v0

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrAbcKeys;->fromKeys(Ljava/util/List;I)Lcom/mrkeyboard/app/MrAbcKeys$Model;

    move-result-object v0

    .line 184
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAbcKeys;->read(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAbcKeys;->entries(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->withEdits(Lcom/mrkeyboard/app/MrAbcKeys$Model;Ljava/util/Map;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 185
    return-object v0
.end method

.method static put(Landroid/content/res/Resources;Ljava/util/List;Lcom/mrkeyboard/app/Keyboard$Key;Lcom/mrkeyboard/app/MrAbcKeys$Entry;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/res/Resources;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Lcom/mrkeyboard/app/Keyboard$Key;",
            "Lcom/mrkeyboard/app/MrAbcKeys$Entry;",
            ")V"
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 405
    iput-object v1, p2, Lcom/mrkeyboard/app/Keyboard$Key;->text:Ljava/lang/CharSequence;

    .line 406
    iput-object v1, p2, Lcom/mrkeyboard/app/Keyboard$Key;->popupKeys:Ljava/util/List;

    .line 407
    iget-boolean v0, p3, Lcom/mrkeyboard/app/MrAbcKeys$Entry;->defaultPopup:Z

    if-nez v0, :cond_0

    .line 408
    iput-object v1, p2, Lcom/mrkeyboard/app/Keyboard$Key;->popupCharacters:Ljava/lang/CharSequence;

    .line 409
    const/4 v0, 0x0

    iput v0, p2, Lcom/mrkeyboard/app/Keyboard$Key;->popupResId:I

    .line 411
    :cond_0
    iget-object v0, p3, Lcom/mrkeyboard/app/MrAbcKeys$Entry;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-static {p0, p1, p2, v0}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->configureKeyFromSpec(Landroid/content/res/Resources;Ljava/util/List;Lcom/mrkeyboard/app/Keyboard$Key;Lcom/mrkeyboard/app/SheetModel$KeySpec;)V

    .line 412
    invoke-static {p2}, Lcom/mrkeyboard/app/MrAbcKeys;->capital(Lcom/mrkeyboard/app/Keyboard$Key;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lcom/mrkeyboard/app/Keyboard$Key;->mrSetCase(Ljava/lang/CharSequence;)V

    .line 413
    return-void
.end method

.method static read(Landroid/content/Context;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 299
    :try_start_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v2, "pref_abc_keys"

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 301
    :goto_0
    return-object v0

    .line 300
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static reset(Landroid/content/Context;)Z
    .locals 1

    .prologue
    .line 317
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrAbcKeys;->write(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method static sameAction(Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/SheetModel$KeySpec;)Z
    .locals 2

    .prologue
    .line 234
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetModel;->normalizeType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetModel;->normalizeType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->eq(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    iget-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->eq(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    iget-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->eq(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static samePopup(Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/SheetModel$KeySpec;)Z
    .locals 5

    .prologue
    const/4 v3, 0x0

    .line 238
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->blankToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAbcKeys;->blankToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->eq(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 245
    :cond_0
    :goto_0
    return v3

    .line 239
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    if-nez v0, :cond_2

    move v2, v3

    .line 240
    :goto_1
    iget-object v0, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    if-nez v0, :cond_3

    move v0, v3

    .line 241
    :goto_2
    if-ne v2, v0, :cond_0

    move v4, v3

    .line 242
    :goto_3
    if-ge v4, v2, :cond_4

    .line 243
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->sameAction(Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/SheetModel$KeySpec;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 242
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_3

    .line 239
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    move v2, v0

    goto :goto_1

    .line 240
    :cond_3
    iget-object v0, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    goto :goto_2

    .line 245
    :cond_4
    const/4 v3, 0x1

    goto :goto_0
.end method

.method static save(Landroid/content/Context;Lcom/mrkeyboard/app/MrAbcKeys$Model;)Z
    .locals 1

    .prologue
    .line 312
    iget-object v0, p1, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrAbcKeys;->diff(Lcom/mrkeyboard/app/MrAbcKeys$Model;Lcom/mrkeyboard/app/SheetModel$Sheet;)Ljava/util/Map;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->toJson(Ljava/util/Map;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrAbcKeys;->write(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method private static sheet(Ljava/util/ArrayList;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$Row;",
            ">;)",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;"
        }
    .end annotation

    .prologue
    .line 171
    new-instance v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {v0}, Lcom/mrkeyboard/app/SheetModel$Sheet;-><init>()V

    .line 172
    const-string v1, "abc"

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 173
    const-string v1, "ABC"

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 174
    const-string v1, "ABC"

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 175
    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 176
    iput-object p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    .line 177
    return-object v0
.end method

.method static takeFromBackup(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 358
    if-nez p1, :cond_1

    .line 365
    :cond_0
    :goto_0
    return v0

    .line 360
    :cond_1
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v2, "abcKeys"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    .line 361
    if-eqz v1, :cond_0

    .line 362
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAbcKeys;->entries(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v1

    .line 363
    invoke-interface {v1}, Ljava/util/Map;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_2

    const/4 v1, 0x0

    :goto_1
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->write(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    goto :goto_0

    :cond_2
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAbcKeys;->toJson(Ljava/util/Map;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_1

    .line 364
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static toJson(Ljava/util/Map;)Ljava/lang/String;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/MrAbcKeys$Entry;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 258
    if-eqz p0, :cond_0

    invoke-interface {p0}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    move-object v0, v2

    .line 271
    :goto_0
    return-object v0

    .line 260
    :cond_1
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 261
    invoke-interface {p0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 262
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/MrAbcKeys$Entry;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrAbcKeys$Entry;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->toJson()Lorg/json/JSONObject;

    move-result-object v5

    .line 263
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/MrAbcKeys$Entry;

    iget-boolean v1, v1, Lcom/mrkeyboard/app/MrAbcKeys$Entry;->defaultPopup:Z

    if-eqz v1, :cond_2

    const-string v1, "mrDefaultPopup"

    const/4 v6, 0x1

    invoke-virtual {v5, v1, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 264
    :cond_2
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v3, v0, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_1

    .line 270
    :catch_0
    move-exception v0

    move-object v0, v2

    .line 271
    goto :goto_0

    .line 266
    :cond_3
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 267
    const-string v1, "v"

    const/4 v4, 0x1

    invoke-virtual {v0, v1, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 268
    const-string v1, "keys"

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 269
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0
.end method

.method static withEdits(Lcom/mrkeyboard/app/MrAbcKeys$Model;Ljava/util/Map;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/mrkeyboard/app/MrAbcKeys$Model;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/MrAbcKeys$Entry;",
            ">;)",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;"
        }
    .end annotation

    .prologue
    const/4 v4, 0x0

    const/4 v2, 0x0

    .line 190
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->defaults:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->copySheet(Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v6

    move v1, v2

    .line 191
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->ids:[[Ljava/lang/String;

    array-length v0, v0

    if-ge v1, v0, :cond_5

    iget-object v0, v6, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_5

    move v3, v2

    .line 192
    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->ids:[[Ljava/lang/String;

    aget-object v0, v0, v1

    array-length v0, v0

    if-ge v3, v0, :cond_4

    iget-object v0, v6, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v3, v0, :cond_4

    .line 193
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->ids:[[Ljava/lang/String;

    aget-object v0, v0, v1

    aget-object v0, v0, v3

    .line 194
    if-nez v0, :cond_0

    move-object v5, v4

    .line 195
    :goto_2
    if-nez v5, :cond_1

    .line 192
    :goto_3
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_1

    .line 194
    :cond_0
    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAbcKeys$Entry;

    move-object v5, v0

    goto :goto_2

    .line 196
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->defaults:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 197
    iget-object v7, v5, Lcom/mrkeyboard/app/MrAbcKeys$Entry;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-static {v7}, Lcom/mrkeyboard/app/MrAbcKeys;->copy(Lcom/mrkeyboard/app/SheetModel$KeySpec;)Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v7

    .line 198
    iget v8, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    iput v8, v7, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    .line 199
    iget-boolean v5, v5, Lcom/mrkeyboard/app/MrAbcKeys$Entry;->defaultPopup:Z

    if-eqz v5, :cond_2

    .line 200
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    iput-object v5, v7, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    .line 201
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    if-nez v5, :cond_3

    move-object v0, v4

    :goto_4
    iput-object v0, v7, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    .line 203
    :cond_2
    iget-object v0, v6, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0, v3, v7}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    goto :goto_3

    .line 201
    :cond_3
    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->copyList(Ljava/util/List;)Ljava/util/ArrayList;

    move-result-object v0

    goto :goto_4

    .line 191
    :cond_4
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 206
    :cond_5
    return-object v6
.end method

.method private static write(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 2

    .prologue
    .line 323
    :try_start_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 324
    if-nez p1, :cond_1

    const-string v1, "pref_abc_keys"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 326
    :goto_0
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 331
    :goto_1
    :try_start_1
    invoke-static {}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInstance()Lcom/mrkeyboard/app/KeyboardSwitcher;

    move-result-object v1

    .line 332
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/mrkeyboard/app/KeyboardSwitcher;->onSheetsChanged()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    .line 335
    :cond_0
    :goto_2
    return v0

    .line 325
    :cond_1
    :try_start_2
    const-string v1, "pref_abc_keys"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 327
    :catch_0
    move-exception v0

    .line 328
    const/4 v0, 0x0

    goto :goto_1

    .line 333
    :catch_1
    move-exception v1

    goto :goto_2
.end method
