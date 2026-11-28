.class public final Lcom/mrkeyboard/app/MrAbcKeys;
.super Ljava/lang/Object;
.source "MrAbcKeys.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrAbcKeys$Stored;,
        Lcom/mrkeyboard/app/MrAbcKeys$Model;,
        Lcom/mrkeyboard/app/MrAbcKeys$Item;
    }
.end annotation


# static fields
.field static final BACKUP_FIELD:Ljava/lang/String; = "abc"

.field static final CODE_DELETE:I = -0x5

.field static final DEFAULT_BADGE:Ljava/lang/String; = "ABC"

.field static final DELETE_WIDTH:F = 1.5f

.field public static final ID:Ljava/lang/String; = "abc"

.field static final MODE_NORMAL:I = 0x7f08005b

.field static final POPUP_OF:Ljava/lang/String; = "mrPopupOf"

.field static final PREF:Ljava/lang/String; = "pref_abc_keys"

.field static final XML_COMPACT:I = 0x7f0f0001

.field static final XML_FULL:I = 0x7f0f0005

.field static final XML_QWERTY:I = 0x7f0f000b

.field private static volatile sBadge:Ljava/lang/String;

.field private static sCached:Lcom/mrkeyboard/app/MrAbcKeys$Stored;

.field private static sCachedRaw:Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 62
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static addToBackup(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 400
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAbcKeys;->read(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 401
    if-eqz p1, :cond_0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->parse(Ljava/lang/String;)Lcom/mrkeyboard/app/MrAbcKeys$Stored;

    move-result-object v1

    if-nez v1, :cond_1

    .line 407
    :cond_0
    :goto_0
    return-object p1

    .line 403
    :cond_1
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 404
    const-string v2, "abc"

    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 405
    const/4 v0, 0x2

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->toString(I)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object p1

    goto :goto_0

    .line 406
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static apply(Landroid/content/Context;Lcom/mrkeyboard/app/Keyboard;I)V
    .locals 3

    .prologue
    .line 432
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    invoke-static {p2}, Lcom/mrkeyboard/app/MrAbcKeys;->isAbcXml(I)Z

    move-result v0

    if-nez v0, :cond_1

    .line 440
    :cond_0
    :goto_0
    return-void

    .line 434
    :cond_1
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAbcKeys;->read(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->cached(Ljava/lang/String;)Lcom/mrkeyboard/app/MrAbcKeys$Stored;

    move-result-object v1

    .line 435
    if-eqz v1, :cond_2

    iget-object v0, v1, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->badge:Ljava/lang/String;

    if-nez v0, :cond_3

    :cond_2
    const-string v0, "ABC"

    :goto_1
    sput-object v0, Lcom/mrkeyboard/app/MrAbcKeys;->sBadge:Ljava/lang/String;

    .line 436
    if-eqz v1, :cond_0

    instance-of v0, p1, Lcom/mrkeyboard/app/LatinKeyboard;

    if-eqz v0, :cond_0

    .line 437
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getSheets(Landroid/content/Context;)Ljava/util/List;

    move-result-object v2

    check-cast p1, Lcom/mrkeyboard/app/LatinKeyboard;

    invoke-static {v0, v2, p1, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->relayout(Landroid/content/res/Resources;Ljava/util/List;Lcom/mrkeyboard/app/LatinKeyboard;Lcom/mrkeyboard/app/MrAbcKeys$Stored;)Z

    goto :goto_0

    .line 438
    :catch_0
    move-exception v0

    goto :goto_0

    .line 435
    :cond_3
    iget-object v0, v1, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->badge:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1
.end method

.method public static badge()Ljava/lang/String;
    .locals 2

    .prologue
    .line 389
    sget-object v0, Lcom/mrkeyboard/app/MrAbcKeys;->sBadge:Ljava/lang/String;

    .line 390
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    :cond_0
    const-string v0, "ABC"

    :cond_1
    return-object v0
.end method

.method private static blankToNull(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 283
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    const/4 p0, 0x0

    :cond_1
    return-object p0
.end method

.method private static declared-synchronized cached(Ljava/lang/String;)Lcom/mrkeyboard/app/MrAbcKeys$Stored;
    .locals 2

    .prologue
    .line 444
    const-class v1, Lcom/mrkeyboard/app/MrAbcKeys;

    monitor-enter v1

    if-nez p0, :cond_0

    const/4 v0, 0x0

    .line 449
    :goto_0
    monitor-exit v1

    return-object v0

    .line 445
    :cond_0
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrAbcKeys;->sCachedRaw:Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 446
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAbcKeys;->parse(Ljava/lang/String;)Lcom/mrkeyboard/app/MrAbcKeys$Stored;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrAbcKeys;->sCached:Lcom/mrkeyboard/app/MrAbcKeys$Stored;

    .line 447
    sput-object p0, Lcom/mrkeyboard/app/MrAbcKeys;->sCachedRaw:Ljava/lang/String;

    .line 449
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrAbcKeys;->sCached:Lcom/mrkeyboard/app/MrAbcKeys$Stored;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 444
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

    .line 582
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

    .line 585
    :cond_1
    :goto_0
    return-object v0

    .line 583
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    aget v0, v0, v3

    int-to-char v0, v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v2

    .line 584
    sget-object v0, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v2, v0}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 585
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

.method private static code(Lcom/mrkeyboard/app/Keyboard$Key;)I
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 108
    iget-object v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    array-length v1, v1

    if-lez v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    aget v0, v1, v0

    :cond_0
    return v0
.end method

.method static copy(Lcom/mrkeyboard/app/SheetModel$KeySpec;)Lcom/mrkeyboard/app/SheetModel$KeySpec;
    .locals 5

    .prologue
    .line 591
    new-instance v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    iget v4, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-direct {v1, v0, v2, v3, v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    .line 592
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    iput-object v0, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    .line 593
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    iput-object v0, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    .line 594
    return-object v1

    .line 593
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
    .line 598
    new-instance v2, Ljava/util/ArrayList;

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    invoke-direct {v2, v0}, Ljava/util/ArrayList;-><init>(I)V

    .line 599
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

    .line 600
    :cond_0
    return-object v2
.end method

.method static copySheet(Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .locals 4

    .prologue
    .line 604
    new-instance v2, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {v2}, Lcom/mrkeyboard/app/SheetModel$Sheet;-><init>()V

    .line 605
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    iput-object v0, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 606
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    iput-object v0, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 607
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    iput-object v0, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 608
    iget-boolean v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    iput-boolean v0, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 609
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    .line 610
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    .line 611
    new-instance v3, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {v3}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    .line 612
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->copyList(Ljava/util/List;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, v3, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    .line 613
    iget-object v0, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 610
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 615
    :cond_0
    return-object v2
.end method

.method static editable(Lcom/mrkeyboard/app/Keyboard$Key;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 97
    if-eqz p0, :cond_0

    iget-boolean v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->modifier:Z

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->icon:Landroid/graphics/drawable/Drawable;

    if-nez v1, :cond_0

    iget v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    and-int/lit8 v1, v1, 0x8

    if-eqz v1, :cond_1

    .line 99
    :cond_0
    :goto_0
    return v0

    .line 98
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-eqz v1, :cond_0

    .line 99
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

.method static edited(Lcom/mrkeyboard/app/MrAbcKeys$Model;)Z
    .locals 2

    .prologue
    .line 292
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->defaults:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->same(Lcom/mrkeyboard/app/SheetModel$Sheet;Lcom/mrkeyboard/app/SheetModel$Sheet;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static eq(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 287
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

.method static fromKeys(Ljava/util/List;ILjava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .locals 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/Keyboard$Key;",
            ">;I",
            "Ljava/lang/String;",
            ")",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;"
        }
    .end annotation

    .prologue
    const/4 v12, 0x1

    const/4 v7, 0x0

    .line 117
    if-lez p1, :cond_1

    int-to-float v0, p1

    const/high16 v1, 0x41200000    # 10.0f

    div-float/2addr v0, v1

    move v1, v0

    .line 118
    :goto_0
    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9}, Ljava/util/ArrayList;-><init>()V

    .line 119
    const/high16 v3, -0x80000000

    .line 120
    const/4 v2, 0x0

    move v8, v7

    .line 121
    :goto_1
    if-eqz p0, :cond_4

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v8, v0, :cond_4

    .line 122
    invoke-interface {p0, v8}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/Keyboard$Key;

    .line 123
    if-eqz v0, :cond_0

    iget v4, v0, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    and-int/lit8 v4, v4, 0x8

    if-nez v4, :cond_0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->code(Lcom/mrkeyboard/app/Keyboard$Key;)I

    move-result v4

    const/4 v5, -0x5

    if-ne v4, v5, :cond_2

    .line 121
    :cond_0
    :goto_2
    add-int/lit8 v0, v8, 0x1

    move v8, v0

    goto :goto_1

    .line 117
    :cond_1
    const/high16 v0, 0x3f800000    # 1.0f

    move v1, v0

    goto :goto_0

    .line 124
    :cond_2
    if-eqz v2, :cond_3

    iget v4, v0, Lcom/mrkeyboard/app/Keyboard$Key;->y:I

    if-eq v4, v3, :cond_7

    .line 125
    :cond_3
    invoke-virtual {v9}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x6

    if-lt v2, v3, :cond_6

    :cond_4
    move v1, v7

    .line 145
    :goto_3
    invoke-virtual {v9}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_d

    .line 146
    invoke-virtual {v9, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    .line 147
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-le v0, v12, :cond_5

    invoke-virtual {v2, v7}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->isGap(Lcom/mrkeyboard/app/SheetModel$KeySpec;)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->isGap(Lcom/mrkeyboard/app/SheetModel$KeySpec;)Z

    move-result v0

    if-nez v0, :cond_5

    invoke-virtual {v2, v7}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->gap(F)Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 145
    :cond_5
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_3

    .line 126
    :cond_6
    new-instance v2, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {v2}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    .line 127
    invoke-virtual {v9, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 128
    iget v3, v0, Lcom/mrkeyboard/app/Keyboard$Key;->y:I

    .line 130
    :cond_7
    iget v4, v0, Lcom/mrkeyboard/app/Keyboard$Key;->gap:I

    int-to-float v4, v4

    div-float/2addr v4, v1

    .line 131
    const/high16 v5, 0x3e800000    # 0.25f

    cmpl-float v5, v4, v5

    if-ltz v5, :cond_8

    iget-object v5, v2, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-static {v4}, Lcom/mrkeyboard/app/MrAbcKeys;->gap(F)Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v4

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 132
    :cond_8
    iget v4, v0, Lcom/mrkeyboard/app/Keyboard$Key;->width:I

    int-to-float v4, v4

    div-float/2addr v4, v1

    invoke-static {v4}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v10

    .line 134
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->editable(Lcom/mrkeyboard/app/Keyboard$Key;)Z

    move-result v4

    if-eqz v4, :cond_b

    .line 135
    iget-object v4, v0, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    invoke-interface {v4}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v5

    .line 136
    iget-object v4, v0, Lcom/mrkeyboard/app/Keyboard$Key;->text:Ljava/lang/CharSequence;

    if-eqz v4, :cond_a

    iget-object v4, v0, Lcom/mrkeyboard/app/Keyboard$Key;->text:Ljava/lang/CharSequence;

    invoke-interface {v4}, Ljava/lang/CharSequence;->length()I

    move-result v4

    if-lez v4, :cond_a

    iget-object v4, v0, Lcom/mrkeyboard/app/Keyboard$Key;->text:Ljava/lang/CharSequence;

    invoke-interface {v4}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v4

    .line 137
    :goto_4
    new-instance v6, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v11, "text"

    invoke-direct {v6, v5, v11, v4, v10}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    .line 138
    iget-object v4, v0, Lcom/mrkeyboard/app/Keyboard$Key;->popupCharacters:Ljava/lang/CharSequence;

    if-eqz v4, :cond_9

    iget-object v4, v0, Lcom/mrkeyboard/app/Keyboard$Key;->popupCharacters:Ljava/lang/CharSequence;

    invoke-interface {v4}, Ljava/lang/CharSequence;->length()I

    move-result v4

    if-lez v4, :cond_9

    iget-object v0, v0, Lcom/mrkeyboard/app/Keyboard$Key;->popupCharacters:Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v6, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    :cond_9
    move-object v0, v6

    .line 143
    :goto_5
    iget-object v4, v2, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :goto_2

    :cond_a
    move-object v4, v5

    .line 136
    goto :goto_4

    .line 140
    :cond_b
    iget-object v4, v0, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    if-eqz v4, :cond_c

    iget-object v4, v0, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    invoke-interface {v4}, Ljava/lang/CharSequence;->length()I

    move-result v4

    if-lez v4, :cond_c

    iget-object v4, v0, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    invoke-interface {v4}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v4

    .line 141
    :goto_6
    new-instance v5, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v6, "special"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->code(Lcom/mrkeyboard/app/Keyboard$Key;)I

    move-result v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v5, v4, v6, v0, v10}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    move-object v0, v5

    goto :goto_5

    .line 140
    :cond_c
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->code(Lcom/mrkeyboard/app/Keyboard$Key;)I

    move-result v4

    invoke-static {v4}, Lcom/mrkeyboard/app/SpecialKeyPicker;->defaultLabelForCode(I)Ljava/lang/String;

    move-result-object v4

    goto :goto_6

    .line 149
    :cond_d
    new-instance v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {v0}, Lcom/mrkeyboard/app/SheetModel$Sheet;-><init>()V

    .line 150
    const-string v1, "abc"

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 151
    iput-object p2, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 152
    const-string v1, "ABC"

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 153
    iput-boolean v12, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 154
    iput-object v9, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    .line 155
    return-object v0
.end method

.method private static gap(F)Lcom/mrkeyboard/app/SheetModel$KeySpec;
    .locals 5

    .prologue
    .line 159
    new-instance v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    new-instance v1, Ljava/lang/String;

    invoke-direct {v1}, Ljava/lang/String;-><init>()V

    const-string v2, "spacer"

    new-instance v3, Ljava/lang/String;

    invoke-direct {v3}, Ljava/lang/String;-><init>()V

    invoke-static {p0}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v4

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    return-object v0
.end method

.method static isAbcXml(I)Z
    .locals 1

    .prologue
    .line 104
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

.method static isGap(Lcom/mrkeyboard/app/SheetModel$KeySpec;)Z
    .locals 2

    .prologue
    .line 163
    if-eqz p0, :cond_0

    const-string v0, "spacer"

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetModel;->normalizeType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static keyFor(Landroid/content/res/Resources;Ljava/util/List;Lcom/mrkeyboard/app/LatinKeyboard;Lcom/mrkeyboard/app/Keyboard$Row;Lcom/mrkeyboard/app/MrAbcKeys$Item;Ljava/util/List;Ljava/util/Map;)Lcom/mrkeyboard/app/Keyboard$Key;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/res/Resources;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Lcom/mrkeyboard/app/LatinKeyboard;",
            "Lcom/mrkeyboard/app/Keyboard$Row;",
            "Lcom/mrkeyboard/app/MrAbcKeys$Item;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/Keyboard$Key;",
            ">;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/Keyboard$Key;",
            ">;)",
            "Lcom/mrkeyboard/app/Keyboard$Key;"
        }
    .end annotation

    .prologue
    .line 550
    iget-object v2, p4, Lcom/mrkeyboard/app/MrAbcKeys$Item;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 551
    const-string v0, "special"

    iget-object v1, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetModel;->normalizeType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 552
    iget-object v0, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->parseInt(Ljava/lang/String;)I

    move-result v3

    .line 553
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    invoke-interface {p5}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_2

    .line 554
    invoke-interface {p5, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/Keyboard$Key;

    .line 555
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->code(Lcom/mrkeyboard/app/Keyboard$Key;)I

    move-result v4

    if-eq v4, v3, :cond_0

    .line 553
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 556
    :cond_0
    invoke-interface {p5, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 557
    iget-object v1, v0, Lcom/mrkeyboard/app/Keyboard$Key;->icon:Landroid/graphics/drawable/Drawable;

    if-nez v1, :cond_1

    iget-object v1, v0, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    if-eqz v1, :cond_1

    iget-object v1, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_1

    iget-object v1, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    iput-object v1, v0, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    .line 569
    :cond_1
    :goto_1
    return-object v0

    .line 561
    :cond_2
    invoke-virtual {p2, p3}, Lcom/mrkeyboard/app/LatinKeyboard;->createCustomKey(Lcom/mrkeyboard/app/Keyboard$Row;)Lcom/mrkeyboard/app/Keyboard$Key;

    move-result-object v1

    .line 562
    invoke-static {p0, p1, v1, v2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->configureKeyFromSpec(Landroid/content/res/Resources;Ljava/util/List;Lcom/mrkeyboard/app/Keyboard$Key;Lcom/mrkeyboard/app/SheetModel$KeySpec;)V

    .line 563
    iget-object v0, p4, Lcom/mrkeyboard/app/MrAbcKeys$Item;->popupOf:Ljava/lang/String;

    if-nez v0, :cond_4

    const/4 v0, 0x0

    .line 564
    :goto_2
    if-eqz v0, :cond_3

    iget-object v2, v0, Lcom/mrkeyboard/app/Keyboard$Key;->popupCharacters:Ljava/lang/CharSequence;

    if-eqz v2, :cond_3

    .line 565
    iget-object v2, v0, Lcom/mrkeyboard/app/Keyboard$Key;->popupCharacters:Ljava/lang/CharSequence;

    iput-object v2, v1, Lcom/mrkeyboard/app/Keyboard$Key;->popupCharacters:Ljava/lang/CharSequence;

    .line 566
    iget v0, v0, Lcom/mrkeyboard/app/Keyboard$Key;->popupResId:I

    iput v0, v1, Lcom/mrkeyboard/app/Keyboard$Key;->popupResId:I

    .line 568
    :cond_3
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAbcKeys;->capital(Lcom/mrkeyboard/app/Keyboard$Key;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/Keyboard$Key;->mrSetCase(Ljava/lang/CharSequence;)V

    move-object v0, v1

    .line 569
    goto :goto_1

    .line 563
    :cond_4
    iget-object v0, p4, Lcom/mrkeyboard/app/MrAbcKeys$Item;->popupOf:Ljava/lang/String;

    invoke-interface {p6, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/Keyboard$Key;

    goto :goto_2
.end method

.method private static labels(Lcom/mrkeyboard/app/SheetModel$Sheet;)Ljava/util/LinkedHashMap;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ")",
            "Ljava/util/LinkedHashMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            ">;"
        }
    .end annotation

    .prologue
    .line 207
    new-instance v1, Ljava/util/LinkedHashMap;

    invoke-direct {v1}, Ljava/util/LinkedHashMap;-><init>()V

    .line 208
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 209
    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_1
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 210
    const-string v4, "text"

    iget-object v5, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-static {v5}, Lcom/mrkeyboard/app/SheetModel;->normalizeType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object v4, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    if-eqz v4, :cond_1

    iget-object v4, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    invoke-virtual {v1, v4}, Ljava/util/LinkedHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    iget-object v4, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    invoke-virtual {v1, v4, v0}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 213
    :cond_2
    return-object v1
.end method

.method static load(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/MrAbcKeys$Model;
    .locals 4

    .prologue
    .line 174
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrAbcKeys;->xmlSheet(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v1

    .line 175
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAbcKeys;->read(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->parse(Ljava/lang/String;)Lcom/mrkeyboard/app/MrAbcKeys$Stored;

    move-result-object v2

    .line 176
    if-eqz v2, :cond_0

    iget-object v0, v2, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->badge:Ljava/lang/String;

    if-nez v0, :cond_1

    :cond_0
    const-string v0, "ABC"

    :goto_0
    sput-object v0, Lcom/mrkeyboard/app/MrAbcKeys;->sBadge:Ljava/lang/String;

    .line 177
    new-instance v3, Lcom/mrkeyboard/app/MrAbcKeys$Model;

    if-nez v2, :cond_2

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAbcKeys;->copySheet(Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    :goto_1
    invoke-direct {v3, v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys$Model;-><init>(Lcom/mrkeyboard/app/SheetModel$Sheet;Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-object v3

    .line 176
    :cond_1
    iget-object v0, v2, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->badge:Ljava/lang/String;

    goto :goto_0

    .line 177
    :cond_2
    invoke-static {v2, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->toSheet(Lcom/mrkeyboard/app/MrAbcKeys$Stored;Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    goto :goto_1
.end method

.method static parse(Ljava/lang/String;)Lcom/mrkeyboard/app/MrAbcKeys$Stored;
    .locals 12

    .prologue
    const/4 v5, 0x0

    const/4 v1, 0x0

    .line 321
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_2

    :cond_0
    move-object v0, v1

    .line 345
    :cond_1
    :goto_0
    return-object v0

    .line 323
    :cond_2
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 324
    const-string v0, "rows"

    invoke-virtual {v2, v0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v7

    .line 325
    if-eqz v7, :cond_3

    invoke-virtual {v7}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-nez v0, :cond_4

    :cond_3
    move-object v0, v1

    goto :goto_0

    .line 326
    :cond_4
    new-instance v0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrAbcKeys$Stored;-><init>()V

    .line 327
    const-string v3, "name"

    new-instance v4, Ljava/lang/String;

    invoke-direct {v4}, Ljava/lang/String;-><init>()V

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    .line 328
    const-string v4, "badge"

    new-instance v6, Ljava/lang/String;

    invoke-direct {v6}, Ljava/lang/String;-><init>()V

    invoke-virtual {v2, v4, v6}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v4

    .line 329
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_5

    move-object v2, v1

    :goto_1
    iput-object v2, v0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->name:Ljava/lang/String;

    .line 330
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_6

    move-object v2, v1

    :goto_2
    iput-object v2, v0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->badge:Ljava/lang/String;

    move v6, v5

    .line 331
    :goto_3
    invoke-virtual {v7}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-ge v6, v2, :cond_1

    const/4 v2, 0x6

    if-ge v6, v2, :cond_1

    .line 332
    invoke-virtual {v7, v6}, Lorg/json/JSONArray;->optJSONArray(I)Lorg/json/JSONArray;

    move-result-object v8

    .line 333
    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9}, Ljava/util/ArrayList;-><init>()V

    move v4, v5

    .line 334
    :goto_4
    if-eqz v8, :cond_a

    invoke-virtual {v8}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-ge v4, v2, :cond_a

    .line 335
    invoke-virtual {v8, v4}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v10

    .line 336
    if-nez v10, :cond_7

    move-object v3, v1

    .line 337
    :goto_5
    if-nez v3, :cond_8

    .line 334
    :goto_6
    add-int/lit8 v2, v4, 0x1

    move v4, v2

    goto :goto_4

    .line 329
    :cond_5
    invoke-static {v3, v3}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_1

    .line 330
    :cond_6
    const-string v2, "ABC"

    invoke-static {v4, v2}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_2

    .line 336
    :cond_7
    const/4 v2, 0x1

    invoke-static {v10, v2}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->fromJson(Lorg/json/JSONObject;Z)Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v2

    move-object v3, v2

    goto :goto_5

    .line 338
    :cond_8
    const-string v2, "mrPopupOf"

    new-instance v11, Ljava/lang/String;

    invoke-direct {v11}, Ljava/lang/String;-><init>()V

    invoke-virtual {v10, v2, v11}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 339
    new-instance v10, Lcom/mrkeyboard/app/MrAbcKeys$Item;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v11

    if-nez v11, :cond_9

    move-object v2, v1

    :cond_9
    invoke-direct {v10, v3, v2}, Lcom/mrkeyboard/app/MrAbcKeys$Item;-><init>(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V

    invoke-virtual {v9, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_6

    .line 344
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 345
    goto/16 :goto_0

    .line 341
    :cond_a
    iget-object v2, v0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->rows:Ljava/util/ArrayList;

    invoke-virtual {v2, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 331
    add-int/lit8 v2, v6, 0x1

    move v6, v2

    goto :goto_3
.end method

.method private static parseInt(Ljava/lang/String;)I
    .locals 1

    .prologue
    .line 574
    if-nez p0, :cond_0

    :try_start_0
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0}, Ljava/lang/String;-><init>()V

    :goto_0
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    .line 576
    :goto_1
    return v0

    .line 574
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 575
    :catch_0
    move-exception v0

    .line 576
    const/4 v0, 0x0

    goto :goto_1
.end method

.method static popupOf(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/util/Map;)Ljava/lang/String;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    const/4 v2, 0x0

    .line 245
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1

    :cond_0
    move-object v0, v2

    .line 254
    :goto_0
    return-object v0

    .line 246
    :cond_1
    const-string v1, "text"

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-static {v3}, Lcom/mrkeyboard/app/SheetModel;->normalizeType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    move-object v0, v2

    goto :goto_0

    .line 247
    :cond_2
    const/4 v1, 0x2

    new-array v4, v1, [Ljava/lang/String;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    aput-object v1, v4, v0

    const/4 v1, 0x1

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    aput-object v3, v4, v1

    array-length v5, v4

    move v3, v0

    :goto_1
    if-ge v3, v5, :cond_5

    aget-object v1, v4, v3

    .line 248
    if-nez v1, :cond_3

    move-object v0, v2

    .line 249
    :goto_2
    if-eqz v0, :cond_4

    iget-object v6, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    invoke-virtual {v6, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    move-object v0, v1

    goto :goto_0

    .line 248
    :cond_3
    invoke-interface {p1, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    goto :goto_2

    .line 247
    :cond_4
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    goto :goto_1

    .line 251
    :cond_5
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_6
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Ljava/util/Map$Entry;

    .line 252
    iget-object v4, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    goto :goto_0

    :cond_7
    move-object v0, v2

    .line 254
    goto :goto_0
.end method

.method static read(Landroid/content/Context;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 351
    :try_start_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v2, "pref_abc_keys"

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 353
    :goto_0
    return-object v0

    .line 352
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static relayout(Landroid/content/res/Resources;Ljava/util/List;Lcom/mrkeyboard/app/LatinKeyboard;Lcom/mrkeyboard/app/MrAbcKeys$Stored;)Z
    .locals 32
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/res/Resources;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Lcom/mrkeyboard/app/LatinKeyboard;",
            "Lcom/mrkeyboard/app/MrAbcKeys$Stored;",
            ")Z"
        }
    .end annotation

    .prologue
    .line 458
    invoke-virtual/range {p2 .. p2}, Lcom/mrkeyboard/app/LatinKeyboard;->getKeys()Ljava/util/List;

    move-result-object v22

    .line 459
    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9}, Ljava/util/ArrayList;-><init>()V

    .line 460
    new-instance v23, Ljava/util/ArrayList;

    invoke-direct/range {v23 .. v23}, Ljava/util/ArrayList;-><init>()V

    .line 461
    const/16 v16, 0x0

    .line 462
    invoke-interface/range {v22 .. v22}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/Keyboard$Key;

    .line 463
    iget v4, v2, Lcom/mrkeyboard/app/Keyboard$Key;->edgeFlags:I

    and-int/lit8 v4, v4, 0x8

    if-eqz v4, :cond_1

    move-object/from16 v0, v23

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move-object/from16 v2, v16

    :cond_0
    :goto_1
    move-object/from16 v16, v2

    .line 466
    goto :goto_0

    .line 464
    :cond_1
    invoke-static {v2}, Lcom/mrkeyboard/app/MrAbcKeys;->code(Lcom/mrkeyboard/app/Keyboard$Key;)I

    move-result v4

    const/4 v5, -0x5

    if-ne v4, v5, :cond_2

    if-eqz v16, :cond_0

    .line 465
    :cond_2
    invoke-virtual {v9, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move-object/from16 v2, v16

    goto :goto_1

    .line 467
    :cond_3
    move-object/from16 v0, p3

    iget-object v2, v0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->rows:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x6

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v24

    .line 468
    invoke-virtual {v9}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_4

    invoke-virtual/range {v23 .. v23}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_4

    if-nez v24, :cond_5

    :cond_4
    const/4 v2, 0x0

    .line 540
    :goto_2
    return v2

    .line 471
    :cond_5
    const v5, 0x7fffffff

    const v4, 0x7fffffff

    const/high16 v3, -0x80000000

    const v7, 0x7fffffff

    const/4 v2, 0x0

    .line 472
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    .line 473
    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6, v9}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 474
    if-eqz v16, :cond_6

    move-object/from16 v0, v16

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 475
    :cond_6
    invoke-virtual {v6}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v10

    move/from16 v17, v4

    move/from16 v18, v5

    move v4, v3

    move v3, v2

    :goto_3
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_8

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/Keyboard$Key;

    .line 476
    iget v5, v2, Lcom/mrkeyboard/app/Keyboard$Key;->y:I

    move/from16 v0, v18

    invoke-static {v0, v5}, Ljava/lang/Math;->min(II)I

    move-result v6

    .line 477
    iget v5, v2, Lcom/mrkeyboard/app/Keyboard$Key;->x:I

    iget v11, v2, Lcom/mrkeyboard/app/Keyboard$Key;->gap:I

    sub-int/2addr v5, v11

    move/from16 v0, v17

    invoke-static {v0, v5}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 478
    iget v11, v2, Lcom/mrkeyboard/app/Keyboard$Key;->x:I

    iget v12, v2, Lcom/mrkeyboard/app/Keyboard$Key;->width:I

    add-int/2addr v11, v12

    invoke-static {v4, v11}, Ljava/lang/Math;->max(II)I

    move-result v4

    .line 479
    iget v11, v2, Lcom/mrkeyboard/app/Keyboard$Key;->height:I

    invoke-static {v3, v11}, Ljava/lang/Math;->max(II)I

    move-result v3

    .line 480
    iget v11, v2, Lcom/mrkeyboard/app/Keyboard$Key;->y:I

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-virtual {v8, v11}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v11

    if-nez v11, :cond_7

    iget v2, v2, Lcom/mrkeyboard/app/Keyboard$Key;->y:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v8, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_7
    move/from16 v17, v5

    move/from16 v18, v6

    .line 481
    goto :goto_3

    .line 482
    :cond_8
    invoke-virtual/range {v23 .. v23}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v6

    move v5, v7

    :goto_4
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_9

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/Keyboard$Key;

    iget v2, v2, Lcom/mrkeyboard/app/Keyboard$Key;->y:I

    invoke-static {v5, v2}, Ljava/lang/Math;->min(II)I

    move-result v2

    move v5, v2

    goto :goto_4

    .line 483
    :cond_9
    move/from16 v0, v18

    if-le v5, v0, :cond_a

    move/from16 v0, v17

    if-gt v4, v0, :cond_b

    :cond_a
    const/4 v2, 0x0

    goto/16 :goto_2

    .line 484
    :cond_b
    sub-int v2, v5, v18

    int-to-float v2, v2

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v6

    int-to-float v6, v6

    div-float/2addr v2, v6

    .line 485
    const/4 v6, 0x0

    int-to-float v3, v3

    sub-float/2addr v2, v3

    invoke-static {v6, v2}, Ljava/lang/Math;->max(FF)F

    move-result v25

    .line 486
    sub-int v2, v5, v18

    int-to-float v2, v2

    move/from16 v0, v24

    int-to-float v3, v0

    div-float v26, v2, v3

    .line 487
    const/4 v2, 0x1

    sub-float v3, v26, v25

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v15

    .line 488
    sub-int v2, v4, v17

    int-to-float v0, v2

    move/from16 v27, v0

    .line 491
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    .line 492
    new-instance v8, Ljava/util/HashMap;

    invoke-direct {v8}, Ljava/util/HashMap;-><init>()V

    .line 493
    invoke-virtual {v9}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_c
    :goto_5
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_e

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/Keyboard$Key;

    .line 494
    invoke-static {v2}, Lcom/mrkeyboard/app/MrAbcKeys;->editable(Lcom/mrkeyboard/app/Keyboard$Key;)Z

    move-result v4

    if-eqz v4, :cond_d

    .line 495
    iget-object v4, v2, Lcom/mrkeyboard/app/Keyboard$Key;->label:Ljava/lang/CharSequence;

    invoke-interface {v4}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v4

    .line 496
    invoke-virtual {v8, v4}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_c

    invoke-virtual {v8, v4, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_5

    .line 498
    :cond_d
    invoke-virtual {v7, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_5

    .line 502
    :cond_e
    new-instance v28, Ljava/util/ArrayList;

    invoke-direct/range {v28 .. v28}, Ljava/util/ArrayList;-><init>()V

    .line 504
    const/16 v19, 0x0

    .line 505
    const/4 v2, 0x0

    move/from16 v21, v2

    :goto_6
    move/from16 v0, v21

    move/from16 v1, v24

    if-ge v0, v1, :cond_15

    .line 506
    invoke-virtual/range {v28 .. v28}, Ljava/util/ArrayList;->size()I

    move-result v29

    .line 507
    move-object/from16 v0, p3

    iget-object v2, v0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->rows:Ljava/util/ArrayList;

    move/from16 v0, v21

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/ArrayList;

    .line 508
    add-int/lit8 v3, v24, -0x1

    move/from16 v0, v21

    if-ne v0, v3, :cond_f

    const/4 v3, 0x1

    move/from16 v20, v3

    .line 509
    :goto_7
    if-eqz v20, :cond_10

    if-eqz v16, :cond_10

    const/high16 v3, 0x3fc00000    # 1.5f

    .line 510
    :goto_8
    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v5

    move v4, v3

    :goto_9
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_11

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mrkeyboard/app/MrAbcKeys$Item;

    iget-object v3, v3, Lcom/mrkeyboard/app/MrAbcKeys$Item;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget v3, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v3}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v3

    add-float/2addr v3, v4

    move v4, v3

    goto :goto_9

    .line 508
    :cond_f
    const/4 v3, 0x0

    move/from16 v20, v3

    goto :goto_7

    .line 509
    :cond_10
    const/4 v3, 0x0

    goto :goto_8

    .line 511
    :cond_11
    const/high16 v3, 0x41200000    # 10.0f

    invoke-static {v3, v4}, Ljava/lang/Math;->max(FF)F

    move-result v3

    div-float v30, v27, v3

    .line 512
    move/from16 v0, v18

    int-to-float v3, v0

    move/from16 v0, v21

    int-to-float v4, v0

    mul-float v4, v4, v26

    add-float/2addr v3, v4

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v14

    .line 513
    new-instance v5, Lcom/mrkeyboard/app/Keyboard$Row;

    move-object/from16 v0, p2

    invoke-direct {v5, v0}, Lcom/mrkeyboard/app/Keyboard$Row;-><init>(Lcom/mrkeyboard/app/Keyboard;)V

    .line 514
    move/from16 v0, v30

    iput v0, v5, Lcom/mrkeyboard/app/Keyboard$Row;->defaultWidth:F

    .line 515
    iput v15, v5, Lcom/mrkeyboard/app/Keyboard$Row;->defaultHeight:I

    .line 516
    invoke-static/range {v25 .. v25}, Ljava/lang/Math;->round(F)I

    move-result v3

    iput v3, v5, Lcom/mrkeyboard/app/Keyboard$Row;->verticalGap:I

    .line 517
    const/4 v3, 0x0

    iput v3, v5, Lcom/mrkeyboard/app/Keyboard$Row;->mode:I

    .line 518
    move/from16 v0, v17

    int-to-float v10, v0

    .line 519
    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v31

    :goto_a
    invoke-interface/range {v31 .. v31}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_13

    invoke-interface/range {v31 .. v31}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/mrkeyboard/app/MrAbcKeys$Item;

    .line 520
    iget-object v2, v6, Lcom/mrkeyboard/app/MrAbcKeys$Item;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v2}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v2

    mul-float v11, v2, v30

    .line 521
    iget-object v2, v6, Lcom/mrkeyboard/app/MrAbcKeys$Item;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrAbcKeys;->isGap(Lcom/mrkeyboard/app/SheetModel$KeySpec;)Z

    move-result v2

    if-nez v2, :cond_12

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move-object/from16 v4, p2

    .line 522
    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrAbcKeys;->keyFor(Landroid/content/res/Resources;Ljava/util/List;Lcom/mrkeyboard/app/LatinKeyboard;Lcom/mrkeyboard/app/Keyboard$Row;Lcom/mrkeyboard/app/MrAbcKeys$Item;Ljava/util/List;Ljava/util/Map;)Lcom/mrkeyboard/app/Keyboard$Key;

    move-result-object v9

    .line 523
    const/4 v12, 0x0

    const/4 v13, 0x0

    invoke-virtual/range {v9 .. v15}, Lcom/mrkeyboard/app/Keyboard$Key;->setCustomBounds(FFFFII)V

    .line 524
    move-object/from16 v0, v28

    invoke-virtual {v0, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 526
    :cond_12
    add-float/2addr v10, v11

    .line 527
    goto :goto_a

    .line 528
    :cond_13
    if-eqz v20, :cond_14

    if-eqz v16, :cond_14

    .line 529
    const/high16 v2, 0x3fc00000    # 1.5f

    mul-float v11, v2, v30

    const/4 v12, 0x0

    const/4 v13, 0x0

    move-object/from16 v9, v16

    invoke-virtual/range {v9 .. v15}, Lcom/mrkeyboard/app/Keyboard$Key;->setCustomBounds(FFFFII)V

    .line 530
    move-object/from16 v0, v28

    move-object/from16 v1, v16

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 532
    :cond_14
    invoke-virtual/range {v28 .. v28}, Ljava/util/ArrayList;->size()I

    move-result v2

    move/from16 v0, v29

    if-le v2, v0, :cond_17

    add-int/lit8 v2, v19, 0x1

    .line 505
    :goto_b
    add-int/lit8 v3, v21, 0x1

    move/from16 v21, v3

    move/from16 v19, v2

    goto/16 :goto_6

    .line 534
    :cond_15
    invoke-interface/range {v22 .. v22}, Ljava/util/List;->clear()V

    .line 535
    move-object/from16 v0, v22

    move-object/from16 v1, v28

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 536
    invoke-interface/range {v22 .. v23}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 537
    invoke-interface/range {v22 .. v22}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_c
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_16

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/Keyboard$Key;

    const/4 v4, 0x0

    iput-boolean v4, v2, Lcom/mrkeyboard/app/Keyboard$Key;->popupReversed:Z

    goto :goto_c

    .line 538
    :cond_16
    invoke-virtual/range {p2 .. p2}, Lcom/mrkeyboard/app/LatinKeyboard;->getMinWidth()I

    move-result v3

    invoke-virtual/range {p2 .. p2}, Lcom/mrkeyboard/app/LatinKeyboard;->getHeight()I

    move-result v4

    invoke-virtual/range {p2 .. p2}, Lcom/mrkeyboard/app/LatinKeyboard;->getDefaultHeightPx()I

    move-result v5

    add-int/lit8 v6, v19, 0x1

    move-object/from16 v0, p2

    iget v7, v0, Lcom/mrkeyboard/app/LatinKeyboard;->mLayoutRows:I

    move-object/from16 v2, p2

    invoke-virtual/range {v2 .. v7}, Lcom/mrkeyboard/app/LatinKeyboard;->finishCustomBuild(IIIII)V

    .line 539
    invoke-virtual/range {p2 .. p2}, Lcom/mrkeyboard/app/LatinKeyboard;->bindCustomSpecialKeys()V

    .line 540
    const/4 v2, 0x1

    goto/16 :goto_2

    :cond_17
    move/from16 v2, v19

    goto :goto_b
.end method

.method static reset(Landroid/content/Context;)Z
    .locals 1

    .prologue
    .line 365
    const-string v0, "ABC"

    sput-object v0, Lcom/mrkeyboard/app/MrAbcKeys;->sBadge:Ljava/lang/String;

    .line 366
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrAbcKeys;->write(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method static same(Lcom/mrkeyboard/app/SheetModel$Sheet;Lcom/mrkeyboard/app/SheetModel$Sheet;)Z
    .locals 7

    .prologue
    const/4 v3, 0x0

    .line 259
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    iget-object v1, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->eq(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    iget-object v1, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->eq(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    iget-object v1, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 267
    :cond_0
    :goto_0
    return v3

    :cond_1
    move v2, v3

    .line 260
    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v2, v0, :cond_3

    .line 261
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v5, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget-object v0, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    .line 262
    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v0

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v1

    if-ne v0, v1, :cond_0

    move v4, v3

    .line 263
    :goto_2
    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v0

    if-ge v4, v0, :cond_2

    .line 264
    invoke-interface {v5, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-interface {v6, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->sameKey(Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/SheetModel$KeySpec;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v5, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget v1, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-interface {v6, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    sub-float v0, v1, v0

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const v1, 0x3c23d70a    # 0.01f

    cmpl-float v0, v0, v1

    if-gtz v0, :cond_0

    .line 263
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_2

    .line 260
    :cond_2
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    .line 267
    :cond_3
    const/4 v3, 0x1

    goto :goto_0
.end method

.method static sameKey(Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/SheetModel$KeySpec;)Z
    .locals 5

    .prologue
    const/4 v3, 0x0

    .line 271
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

    if-nez v0, :cond_1

    .line 279
    :cond_0
    :goto_0
    return v3

    .line 272
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->blankToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAbcKeys;->blankToNull(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->eq(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 273
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    if-nez v0, :cond_2

    move v2, v3

    .line 274
    :goto_1
    iget-object v0, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    if-nez v0, :cond_3

    move v0, v3

    .line 275
    :goto_2
    if-ne v2, v0, :cond_0

    move v4, v3

    .line 276
    :goto_3
    if-ge v4, v2, :cond_4

    .line 277
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->sameKey(Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/SheetModel$KeySpec;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 276
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_3

    .line 273
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    move v2, v0

    goto :goto_1

    .line 274
    :cond_3
    iget-object v0, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    goto :goto_2

    .line 279
    :cond_4
    const/4 v3, 0x1

    goto :goto_0
.end method

.method static save(Landroid/content/Context;Lcom/mrkeyboard/app/MrAbcKeys$Model;)Z
    .locals 2

    .prologue
    .line 359
    iget-object v0, p1, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    if-nez v0, :cond_0

    const-string v0, "ABC"

    :goto_0
    sput-object v0, Lcom/mrkeyboard/app/MrAbcKeys;->sBadge:Ljava/lang/String;

    .line 360
    invoke-static {p1}, Lcom/mrkeyboard/app/MrAbcKeys;->edited(Lcom/mrkeyboard/app/MrAbcKeys$Model;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p1, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, p1, Lcom/mrkeyboard/app/MrAbcKeys$Model;->defaults:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->toStored(Lcom/mrkeyboard/app/SheetModel$Sheet;Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/MrAbcKeys$Stored;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->toJson(Lcom/mrkeyboard/app/MrAbcKeys$Stored;)Ljava/lang/String;

    move-result-object v0

    :goto_1
    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrAbcKeys;->write(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    return v0

    .line 359
    :cond_0
    iget-object v0, p1, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    goto :goto_0

    .line 360
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method static takeFromBackup(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 413
    if-nez p1, :cond_1

    .line 421
    :cond_0
    :goto_0
    return v0

    .line 415
    :cond_1
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v2, "abc"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    .line 416
    if-nez v1, :cond_2

    const/4 v1, 0x0

    move-object v2, v1

    .line 417
    :goto_1
    if-eqz v2, :cond_0

    .line 418
    iget-object v1, v2, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->badge:Ljava/lang/String;

    if-nez v1, :cond_3

    const-string v1, "ABC"

    :goto_2
    sput-object v1, Lcom/mrkeyboard/app/MrAbcKeys;->sBadge:Ljava/lang/String;

    .line 419
    invoke-static {v2}, Lcom/mrkeyboard/app/MrAbcKeys;->toJson(Lcom/mrkeyboard/app/MrAbcKeys$Stored;)Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->write(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    goto :goto_0

    .line 416
    :cond_2
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAbcKeys;->parse(Ljava/lang/String;)Lcom/mrkeyboard/app/MrAbcKeys$Stored;

    move-result-object v1

    move-object v2, v1

    goto :goto_1

    .line 418
    :cond_3
    iget-object v1, v2, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->badge:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 420
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static toJson(Lcom/mrkeyboard/app/MrAbcKeys$Stored;)Ljava/lang/String;
    .locals 7

    .prologue
    .line 298
    :try_start_0
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 299
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    .line 300
    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3}, Lorg/json/JSONArray;-><init>()V

    .line 301
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAbcKeys$Item;

    .line 302
    iget-object v5, v0, Lcom/mrkeyboard/app/MrAbcKeys$Item;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v5}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->toJson()Lorg/json/JSONObject;

    move-result-object v5

    .line 303
    iget-object v6, v0, Lcom/mrkeyboard/app/MrAbcKeys$Item;->popupOf:Ljava/lang/String;

    if-eqz v6, :cond_0

    const-string v6, "mrPopupOf"

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAbcKeys$Item;->popupOf:Ljava/lang/String;

    invoke-virtual {v5, v6, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 304
    :cond_0
    invoke-virtual {v3, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_1

    .line 314
    :catch_0
    move-exception v0

    .line 315
    const/4 v0, 0x0

    :goto_2
    return-object v0

    .line 306
    :cond_1
    invoke-virtual {v1, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_0

    .line 308
    :cond_2
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 309
    const-string v2, "v"

    const/4 v3, 0x2

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 310
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->name:Ljava/lang/String;

    if-eqz v2, :cond_3

    const-string v2, "name"

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->name:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 311
    :cond_3
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->badge:Ljava/lang/String;

    if-eqz v2, :cond_4

    const-string v2, "badge"

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->badge:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 312
    :cond_4
    const-string v2, "rows"

    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 313
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_2
.end method

.method static toSheet(Lcom/mrkeyboard/app/MrAbcKeys$Stored;Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .locals 9

    .prologue
    const/4 v2, 0x0

    .line 182
    invoke-static {p1}, Lcom/mrkeyboard/app/MrAbcKeys;->labels(Lcom/mrkeyboard/app/SheetModel$Sheet;)Ljava/util/LinkedHashMap;

    move-result-object v3

    .line 183
    new-instance v4, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {v4}, Lcom/mrkeyboard/app/SheetModel$Sheet;-><init>()V

    .line 184
    const-string v0, "abc"

    iput-object v0, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 185
    const/4 v0, 0x1

    iput-boolean v0, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 186
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->name:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->name:Ljava/lang/String;

    :goto_0
    iput-object v0, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 187
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->badge:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->badge:Ljava/lang/String;

    :goto_1
    iput-object v0, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 188
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    .line 189
    const/4 v0, 0x0

    move v1, v0

    :goto_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_5

    const/4 v0, 0x6

    if-ge v1, v0, :cond_5

    .line 190
    new-instance v5, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {v5}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    .line 191
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_3
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAbcKeys$Item;

    .line 192
    iget-object v7, v0, Lcom/mrkeyboard/app/MrAbcKeys$Item;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-static {v7}, Lcom/mrkeyboard/app/MrAbcKeys;->copy(Lcom/mrkeyboard/app/SheetModel$KeySpec;)Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v7

    .line 193
    iget-object v8, v0, Lcom/mrkeyboard/app/MrAbcKeys$Item;->popupOf:Ljava/lang/String;

    if-nez v8, :cond_3

    move-object v0, v2

    .line 194
    :goto_4
    if-eqz v0, :cond_0

    .line 195
    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    iput-object v0, v7, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    .line 196
    iput-object v2, v7, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    .line 198
    :cond_0
    iget-object v0, v5, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 186
    :cond_1
    iget-object v0, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    goto :goto_0

    .line 187
    :cond_2
    const-string v0, "ABC"

    goto :goto_1

    .line 193
    :cond_3
    iget-object v0, v0, Lcom/mrkeyboard/app/MrAbcKeys$Item;->popupOf:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    goto :goto_4

    .line 200
    :cond_4
    iget-object v0, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 189
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_2

    .line 202
    :cond_5
    return-object v4
.end method

.method static toStored(Lcom/mrkeyboard/app/SheetModel$Sheet;Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/MrAbcKeys$Stored;
    .locals 9

    .prologue
    const/4 v1, 0x0

    .line 220
    invoke-static {p1}, Lcom/mrkeyboard/app/MrAbcKeys;->labels(Lcom/mrkeyboard/app/SheetModel$Sheet;)Ljava/util/LinkedHashMap;

    move-result-object v3

    .line 221
    new-instance v4, Lcom/mrkeyboard/app/MrAbcKeys$Stored;

    invoke-direct {v4}, Lcom/mrkeyboard/app/MrAbcKeys$Stored;-><init>()V

    .line 222
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    iget-object v2, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    :cond_0
    move-object v0, v1

    :goto_0
    iput-object v0, v4, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->name:Ljava/lang/String;

    .line 223
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    if-eqz v0, :cond_1

    const-string v0, "ABC"

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    :cond_1
    move-object v0, v1

    :goto_1
    iput-object v0, v4, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->badge:Ljava/lang/String;

    .line 224
    const/4 v0, 0x0

    move v2, v0

    :goto_2
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v2, v0, :cond_6

    const/4 v0, 0x6

    if-ge v2, v0, :cond_6

    .line 225
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    .line 226
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_3
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 227
    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrAbcKeys;->popupOf(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/util/Map;)Ljava/lang/String;

    move-result-object v7

    .line 228
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->copy(Lcom/mrkeyboard/app/SheetModel$KeySpec;)Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v0

    .line 229
    if-eqz v7, :cond_2

    .line 230
    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    .line 231
    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    .line 233
    :cond_2
    new-instance v8, Lcom/mrkeyboard/app/MrAbcKeys$Item;

    invoke-direct {v8, v0, v7}, Lcom/mrkeyboard/app/MrAbcKeys$Item;-><init>(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V

    invoke-virtual {v5, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 222
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    goto :goto_0

    .line 223
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    goto :goto_1

    .line 235
    :cond_5
    iget-object v0, v4, Lcom/mrkeyboard/app/MrAbcKeys$Stored;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 224
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_2

    .line 237
    :cond_6
    return-object v4
.end method

.method private static write(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 2

    .prologue
    .line 372
    :try_start_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 373
    if-nez p1, :cond_1

    const-string v1, "pref_abc_keys"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 375
    :goto_0
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 380
    :goto_1
    :try_start_1
    invoke-static {}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInstance()Lcom/mrkeyboard/app/KeyboardSwitcher;

    move-result-object v1

    .line 381
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/mrkeyboard/app/KeyboardSwitcher;->onSheetsChanged()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    .line 384
    :cond_0
    :goto_2
    return v0

    .line 374
    :cond_1
    :try_start_2
    const-string v1, "pref_abc_keys"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 376
    :catch_0
    move-exception v0

    .line 377
    const/4 v0, 0x0

    goto :goto_1

    .line 382
    :catch_1
    move-exception v1

    goto :goto_2
.end method

.method static xmlSheet(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .locals 6

    .prologue
    .line 168
    new-instance v0, Lcom/mrkeyboard/app/Keyboard;

    const/4 v2, 0x0

    const v3, 0x7f0f000b

    const v4, 0x7f08005b

    const/high16 v5, 0x42200000    # 40.0f

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/Keyboard;-><init>(Landroid/content/Context;IIIF)V

    .line 169
    invoke-virtual {v0}, Lcom/mrkeyboard/app/Keyboard;->getKeys()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0}, Lcom/mrkeyboard/app/Keyboard;->getMinWidth()I

    move-result v0

    invoke-static {v1, v0, p1}, Lcom/mrkeyboard/app/MrAbcKeys;->fromKeys(Ljava/util/List;ILjava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    return-object v0
.end method
