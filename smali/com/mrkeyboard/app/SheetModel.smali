.class public final Lcom/mrkeyboard/app/SheetModel;
.super Ljava/lang/Object;
.source "SheetModel.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/SheetModel$Sheet;,
        Lcom/mrkeyboard/app/SheetModel$Row;,
        Lcom/mrkeyboard/app/SheetModel$KeySpec;
    }
.end annotation


# static fields
.field public static final CODE_SHEET_JUMP_BASE:I = -0x190

.field public static final CODE_SHEET_NEXT:I = -0x12c

.field public static final CODE_SHEET_PREV:I = -0x12b

.field public static final CODE_SPACER:I = -0x18f

.field public static final DEFAULT_WIDTH:F = 1.0f

.field public static final DELETE_KEY_WEIGHT:F = 1.5f

.field public static final MAX_BADGE_LEN:I = 0x5

.field public static final MAX_KEYS_LAST_ROW_ADD:I = 0x9

.field public static final MAX_KEYS_PER_ROW:I = 0xa

.field public static final MAX_POPUP_KEYS:I = 0xa

.field public static final MAX_ROWS:I = 0x6

.field public static final MAX_SHEETS:I = 0xc

.field public static final MAX_WIDTH:F = 4.0f

.field public static final MIN_ROWS:I = 0x1

.field public static final MIN_SHEETS:I = 0x1

.field public static final MIN_WIDTH:F = 0.5f

.field public static final SCHEMA_VERSION:I = 0x1

.field public static final TARGET_ABC:Ljava/lang/String; = "abc"

.field public static final TARGET_NEXT:Ljava/lang/String; = "next"

.field public static final TARGET_PREV:Ljava/lang/String; = "prev"

.field public static final TYPE_SHEET:Ljava/lang/String; = "sheet"

.field public static final TYPE_SPACER:Ljava/lang/String; = "spacer"

.field public static final TYPE_SPECIAL:Ljava/lang/String; = "special"

.field public static final TYPE_TASKER:Ljava/lang/String; = "tasker"

.field public static final TYPE_TEXT:Ljava/lang/String; = "text"

.field public static final WIDTH_STEP:F = 0.25f


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static buildRootJson(Ljava/util/List;)Lorg/json/JSONObject;
    .registers 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;)",
            "Lorg/json/JSONObject;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 244
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 245
    const-string v1, "version"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 246
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 247
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v3

    const/16 v4, 0xc

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v3

    .line 248
    const/4 v4, 0x0

    :goto_1b
    if-ge v4, v3, :cond_58

    .line 249
    invoke-interface {p0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 250
    if-nez v5, :cond_26

    goto :goto_55

    .line 251
    :cond_26
    iget-object v6, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v6

    if-eqz v6, :cond_38

    .line 252
    iget-object v6, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    new-instance v7, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {v7}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    invoke-virtual {v6, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 254
    :cond_38
    :goto_38
    iget-object v6, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    const/4 v7, 0x6

    if-le v6, v7, :cond_4e

    .line 255
    iget-object v6, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    iget-object v7, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v7

    sub-int/2addr v7, v2

    invoke-virtual {v6, v7}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    goto :goto_38

    .line 257
    :cond_4e
    invoke-virtual {v5}, Lcom/mrkeyboard/app/SheetModel$Sheet;->toJson()Lorg/json/JSONObject;

    move-result-object v5

    invoke-virtual {v1, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 248
    :goto_55
    add-int/lit8 v4, v4, 0x1

    goto :goto_1b

    .line 259
    :cond_58
    const-string p0, "sheets"

    invoke-virtual {v0, p0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 260
    return-object v0
.end method

.method public static clampWidth(F)F
    .registers 4

    .line 41
    invoke-static {p0}, Ljava/lang/Float;->isNaN(F)Z

    move-result v0

    if-nez v0, :cond_23

    invoke-static {p0}, Ljava/lang/Float;->isInfinite(F)Z

    move-result v0

    if-eqz v0, :cond_d

    goto :goto_23

    .line 44
    :cond_d
    const/high16 v0, 0x40800000    # 4.0f

    mul-float/2addr p0, v0

    invoke-static {p0}, Ljava/lang/Math;->round(F)I

    move-result p0

    int-to-float p0, p0

    div-float/2addr p0, v0

    .line 45
    const/high16 v1, 0x3f000000    # 0.5f

    cmpg-float v2, p0, v1

    if-gez v2, :cond_1d

    return v1

    .line 46
    :cond_1d
    cmpl-float v1, p0, v0

    if-lez v1, :cond_22

    return v0

    .line 47
    :cond_22
    return p0

    .line 42
    :cond_23
    :goto_23
    const/high16 p0, 0x3f800000    # 1.0f

    return p0
.end method

.method public static createBlankTemplate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .registers 4

    .line 51
    new-instance v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {v0}, Lcom/mrkeyboard/app/SheetModel$Sheet;-><init>()V

    .line 52
    iput-object p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 53
    const-string p0, "Nova folha"

    invoke-static {p1, p0}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    iput-object p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 54
    const-string p0, "NEW"

    invoke-static {p2, p0}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    iput-object p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 55
    const/4 p0, 0x0

    iput-boolean p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 56
    iget-object p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    new-instance p1, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {p1}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    invoke-virtual {p0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 57
    iget-object p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    new-instance p1, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {p1}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    invoke-virtual {p0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 58
    iget-object p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    new-instance p1, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {p1}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    invoke-virtual {p0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 59
    return-object v0
.end method

.method public static createNavEditTemplate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .registers 11

    .line 63
    new-instance v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {v0}, Lcom/mrkeyboard/app/SheetModel$Sheet;-><init>()V

    .line 64
    iput-object p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 65
    const-string p0, "Navega\u00e7\u00e3o"

    invoke-static {p1, p0}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    iput-object p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 66
    const-string p0, "NAV"

    invoke-static {p2, p0}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    iput-object p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 67
    const/4 p0, 0x0

    iput-boolean p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 69
    new-instance p0, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    .line 70
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance p2, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v1, "Esc"

    const-string v2, "special"

    const-string v3, "-111"

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {p2, v1, v2, v3, v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {p1, p2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 71
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance p2, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v1, "Tab"

    const-string v3, "9"

    invoke-direct {p2, v1, v2, v3, v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {p1, p2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 72
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance p2, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v1, "Home"

    const-string v3, "-122"

    invoke-direct {p2, v1, v2, v3, v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {p1, p2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 73
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance p2, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v1, "\u2191"

    const-string v3, "-19"

    const/high16 v5, 0x3fa00000    # 1.25f

    invoke-direct {p2, v1, v2, v3, v5}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {p1, p2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 74
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance p2, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v1, "End"

    const-string v3, "-123"

    invoke-direct {p2, v1, v2, v3, v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {p1, p2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 75
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance p2, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v1, "PgUp"

    const-string v3, "-92"

    invoke-direct {p2, v1, v2, v3, v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {p1, p2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 77
    new-instance p1, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {p1}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    .line 78
    iget-object p2, p1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v3, "Ctrl"

    const-string v6, "-113"

    invoke-direct {v1, v3, v2, v6, v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {p2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 79
    iget-object p2, p1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v3, "Alt"

    const-string v6, "-57"

    invoke-direct {v1, v3, v2, v6, v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {p2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 80
    iget-object p2, p1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v3, "\u2190"

    const-string v6, "-21"

    invoke-direct {v1, v3, v2, v6, v5}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {p2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 81
    iget-object p2, p1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v3, "\u2193"

    const-string v6, "-20"

    invoke-direct {v1, v3, v2, v6, v5}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {p2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 82
    iget-object p2, p1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v3, "\u2192"

    const-string v6, "-22"

    invoke-direct {v1, v3, v2, v6, v5}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {p2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 83
    iget-object p2, p1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v3, "PgDn"

    const-string v6, "-93"

    invoke-direct {v1, v3, v2, v6, v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {p2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 85
    new-instance p2, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {p2}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    .line 86
    iget-object v1, p2, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v6, "Ins"

    const-string v7, "-124"

    invoke-direct {v3, v6, v2, v7, v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 87
    iget-object v1, p2, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v4, "Del\u2192"

    const-string v6, "-112"

    invoke-direct {v3, v4, v2, v6, v5}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 88
    iget-object v1, p2, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v4, "Barra"

    const-string v6, "-306"

    invoke-direct {v3, v4, v2, v6, v5}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 89
    iget-object v1, p2, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v3, "sheet"

    const-string v4, "abc"

    const-string v6, "ABC"

    invoke-direct {v2, v6, v3, v4, v5}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 91
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v1, p0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 92
    iget-object p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {p0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 93
    iget-object p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {p0, p2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 94
    return-object v0
.end method

.method public static createNumpadTemplate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .registers 11

    .line 98
    new-instance v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {v0}, Lcom/mrkeyboard/app/SheetModel$Sheet;-><init>()V

    .line 99
    iput-object p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 100
    const-string p0, "Num\u00e9rico"

    invoke-static {p1, p0}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    iput-object p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 101
    const-string p0, "NUM"

    invoke-static {p2, p0}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    iput-object p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 102
    const/4 p0, 0x0

    iput-boolean p0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 103
    const-string p1, "9"

    const-string p2, "/"

    const-string v1, "7"

    const-string v2, "8"

    filled-new-array {v1, v2, p1, p2}, [Ljava/lang/String;

    move-result-object p1

    const-string p2, "6"

    const-string v1, "*"

    const-string v2, "4"

    const-string v3, "5"

    filled-new-array {v2, v3, p2, v1}, [Ljava/lang/String;

    move-result-object p2

    const-string v1, "3"

    const-string v2, "-"

    const-string v3, "1"

    const-string v4, "2"

    filled-new-array {v3, v4, v1, v2}, [Ljava/lang/String;

    move-result-object v1

    const-string v2, "="

    const-string v3, "+"

    const-string v4, "0"

    const-string v5, "."

    filled-new-array {v4, v5, v2, v3}, [Ljava/lang/String;

    move-result-object v2

    filled-new-array {p1, p2, v1, v2}, [[Ljava/lang/String;

    move-result-object p1

    .line 109
    move p2, p0

    :goto_4f
    const/4 v1, 0x4

    if-ge p2, v1, :cond_7a

    .line 110
    new-instance v1, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {v1}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    .line 111
    move v2, p0

    :goto_58
    aget-object v3, p1, p2

    array-length v3, v3

    if-ge v2, v3, :cond_72

    .line 112
    aget-object v3, p1, p2

    aget-object v3, v3, v2

    .line 113
    iget-object v4, v1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    new-instance v5, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v6, "text"

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-direct {v5, v3, v6, v3, v7}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 111
    add-int/lit8 v2, v2, 0x1

    goto :goto_58

    .line 115
    :cond_72
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 109
    add-int/lit8 p2, p2, 0x1

    goto :goto_4f

    .line 117
    :cond_7a
    return-object v0
.end method

.method public static isKnownBuiltinId(Ljava/lang/String;)Z
    .registers 2

    .line 121
    const-string v0, "symbols"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_23

    const-string v0, "tasker"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_23

    const-string v0, "html"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_23

    const-string v0, "frases"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_21

    goto :goto_23

    :cond_21
    const/4 p0, 0x0

    goto :goto_24

    :cond_23
    :goto_23
    const/4 p0, 0x1

    :goto_24
    return p0
.end method

.method public static makeUniqueId(Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;
    .registers 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 125
    new-instance v0, Ljava/util/HashSet;

    const/4 v1, 0x2

    if-eqz p0, :cond_b

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v2

    mul-int/2addr v2, v1

    goto :goto_d

    :cond_b
    const/16 v2, 0x8

    :goto_d
    invoke-direct {v0, v2}, Ljava/util/HashSet;-><init>(I)V

    .line 126
    if-eqz p0, :cond_27

    .line 127
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v2

    const/4 v3, 0x0

    :goto_17
    if-ge v3, v2, :cond_27

    .line 128
    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v0, v4}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 127
    add-int/lit8 v3, v3, 0x1

    goto :goto_17

    .line 131
    :cond_27
    if-eqz p1, :cond_2f

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result p0

    if-eqz p0, :cond_31

    :cond_2f
    const-string p1, "custom"

    .line 132
    :cond_31
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    const-wide/32 v4, 0xf4240

    rem-long/2addr v2, v4

    .line 133
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v4, "_"

    invoke-virtual {p0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 134
    nop

    .line 135
    :goto_51
    invoke-virtual {v0, p0}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_77

    .line 136
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 137
    add-int/lit8 v1, v1, 0x1

    goto :goto_51

    .line 139
    :cond_77
    return-object p0
.end method

.method public static normalizeType(Ljava/lang/String;)Ljava/lang/String;
    .registers 3

    .line 143
    const-string v0, "tasker"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_9

    return-object v0

    .line 144
    :cond_9
    const-string v0, "special"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_12

    return-object v0

    .line 145
    :cond_12
    const-string v0, "sheet"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1b

    return-object v0

    .line 146
    :cond_1b
    const-string v0, "spacer"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_24

    return-object v0

    .line 147
    :cond_24
    const-string p0, "text"

    return-object p0
.end method

.method public static parseSheets(Ljava/lang/String;)Ljava/util/ArrayList;
    .registers 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/ArrayList<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 151
    if-eqz p0, :cond_8e

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_8e

    .line 154
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p0, "sheets"

    invoke-virtual {v0, p0}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p0

    .line 155
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-eqz v0, :cond_86

    .line 158
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v0

    const/16 v1, 0xc

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 159
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(I)V

    .line 160
    new-instance v2, Ljava/util/HashSet;

    mul-int/lit8 v3, v0, 0x2

    invoke-direct {v2, v3}, Ljava/util/HashSet;-><init>(I)V

    .line 161
    const/4 v3, 0x0

    move v4, v3

    :goto_35
    if-ge v4, v0, :cond_77

    .line 162
    invoke-virtual {p0, v4}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    invoke-static {v5, v4}, Lcom/mrkeyboard/app/SheetModel$Sheet;->fromJson(Lorg/json/JSONObject;I)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v5

    .line 163
    if-nez v5, :cond_42

    goto :goto_74

    .line 164
    :cond_42
    iget-object v6, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 165
    const/4 v7, 0x2

    .line 166
    :goto_45
    iget-object v8, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v2, v8}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_6c

    .line 167
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "_"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    add-int/lit8 v9, v7, 0x1

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    iput-object v7, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 168
    iput-boolean v3, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    move v7, v9

    goto :goto_45

    .line 170
    :cond_6c
    iget-object v6, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v2, v6}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 171
    invoke-virtual {v1, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 161
    :goto_74
    add-int/lit8 v4, v4, 0x1

    goto :goto_35

    .line 173
    :cond_77
    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result p0

    if-nez p0, :cond_7e

    .line 176
    return-object v1

    .line 174
    :cond_7e
    new-instance p0, Lorg/json/JSONException;

    const-string v0, "No valid sheets parsed"

    invoke-direct {p0, v0}, Lorg/json/JSONException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 156
    :cond_86
    new-instance p0, Ljava/util/ArrayList;

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Ljava/util/ArrayList;-><init>(I)V

    return-object p0

    .line 152
    :cond_8e
    new-instance p0, Lorg/json/JSONException;

    const-string v0, "Empty JSON"

    invoke-direct {p0, v0}, Lorg/json/JSONException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 4

    .line 214
    if-nez p0, :cond_5

    const-string p0, ""

    goto :goto_9

    :cond_5
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 215
    :goto_9
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    const-string v1, "123"

    if-eqz v0, :cond_19

    .line 216
    if-nez p1, :cond_15

    move-object p0, v1

    goto :goto_19

    :cond_15
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 218
    :cond_19
    :goto_19
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_20

    .line 219
    goto :goto_21

    .line 218
    :cond_20
    move-object v1, p0

    .line 221
    :goto_21
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result p0

    const/4 p1, 0x5

    if-le p0, p1, :cond_2d

    const/4 p0, 0x0

    invoke-virtual {v1, p0, p1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    :cond_2d
    return-object v1
.end method

.method public static sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 4

    .line 225
    if-nez p0, :cond_5

    const-string p0, ""

    goto :goto_9

    :cond_5
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 226
    :goto_9
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    const-string v1, "Folha"

    if-eqz v0, :cond_19

    .line 227
    if-nez p1, :cond_15

    move-object p0, v1

    goto :goto_19

    :cond_15
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 229
    :cond_19
    :goto_19
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_20

    .line 230
    goto :goto_21

    .line 229
    :cond_20
    move-object v1, p0

    .line 232
    :goto_21
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result p0

    const/16 p1, 0x28

    if-le p0, p1, :cond_2e

    const/4 p0, 0x0

    invoke-virtual {v1, p0, p1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    :cond_2e
    return-object v1
.end method

.method public static sanitizeSheetsCopy(Ljava/util/List;)Ljava/util/ArrayList;
    .registers 14
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;)",
            "Ljava/util/ArrayList<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;"
        }
    .end annotation

    .line 180
    const/4 v0, 0x0

    if-eqz p0, :cond_8

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v1

    goto :goto_9

    :cond_8
    move v1, v0

    :goto_9
    const/16 v2, 0xc

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 181
    new-instance v2, Ljava/util/ArrayList;

    const/4 v3, 0x1

    invoke-static {v3, v1}, Ljava/lang/Math;->max(II)I

    move-result v4

    invoke-direct {v2, v4}, Ljava/util/ArrayList;-><init>(I)V

    .line 182
    new-instance v4, Ljava/util/HashSet;

    mul-int/lit8 v5, v1, 0x2

    const/4 v6, 0x2

    add-int/2addr v5, v6

    invoke-direct {v4, v5}, Ljava/util/HashSet;-><init>(I)V

    .line 183
    move v5, v0

    :goto_23
    if-ge v5, v1, :cond_106

    .line 184
    invoke-interface {p0, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 185
    if-nez v7, :cond_2f

    goto/16 :goto_102

    .line 186
    :cond_2f
    invoke-virtual {v7}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v7

    .line 187
    iget-object v8, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    if-nez v8, :cond_3a

    const-string v8, ""

    goto :goto_40

    :cond_3a
    iget-object v8, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v8}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v8

    .line 188
    :goto_40
    invoke-virtual {v8}, Ljava/lang/String;->isEmpty()Z

    move-result v9

    const-string v10, "_"

    if-eqz v9, :cond_67

    .line 189
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "sheet_"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    invoke-virtual {v8, v11, v12}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 191
    :cond_67
    nop

    .line 192
    move v11, v6

    move-object v9, v8

    .line 193
    :goto_6a
    invoke-virtual {v4, v9}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v12

    if-eqz v12, :cond_8b

    .line 194
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    add-int/lit8 v12, v11, 0x1

    invoke-virtual {v9, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    .line 195
    iput-boolean v0, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    move v11, v12

    goto :goto_6a

    .line 197
    :cond_8b
    invoke-virtual {v4, v9}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 198
    iput-object v9, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 199
    iget-boolean v8, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-eqz v8, :cond_9c

    invoke-static {v9}, Lcom/mrkeyboard/app/SheetModel;->isKnownBuiltinId(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_9c

    move v8, v3

    goto :goto_9d

    :cond_9c
    move v8, v0

    :goto_9d
    iput-boolean v8, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 200
    iget-object v8, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Folha "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    add-int/lit8 v10, v5, 0x1

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    iput-object v8, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 201
    iget-object v8, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "F"

    invoke-virtual {v9, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    iput-object v8, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 202
    iget-object v8, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v8

    if-eqz v8, :cond_e9

    .line 203
    iget-object v8, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    new-instance v9, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {v9}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    invoke-virtual {v8, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 205
    :cond_e9
    :goto_e9
    iget-object v8, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v8

    const/4 v9, 0x6

    if-le v8, v9, :cond_ff

    .line 206
    iget-object v8, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    iget-object v9, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v9}, Ljava/util/ArrayList;->size()I

    move-result v9

    sub-int/2addr v9, v3

    invoke-virtual {v8, v9}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    goto :goto_e9

    .line 208
    :cond_ff
    invoke-virtual {v2, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 183
    :goto_102
    add-int/lit8 v5, v5, 0x1

    goto/16 :goto_23

    .line 210
    :cond_106
    return-object v2
.end method

.method public static serializeSheets(Ljava/util/List;)Ljava/lang/String;
    .registers 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 236
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetModel;->buildRootJson(Ljava/util/List;)Lorg/json/JSONObject;

    move-result-object p0

    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Lorg/json/JSONObject;->toString(I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static serializeSheetsCompact(Ljava/util/List;)Ljava/lang/String;
    .registers 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 240
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetModel;->buildRootJson(Ljava/util/List;)Lorg/json/JSONObject;

    move-result-object p0

    invoke-virtual {p0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static stripTaskerPrefix(Ljava/lang/String;)Ljava/lang/String;
    .registers 7

    .line 264
    if-nez p0, :cond_5

    const-string p0, ""

    return-object p0

    .line 265
    :cond_5
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 266
    :goto_9
    const/4 v4, 0x0

    const/4 v5, 0x7

    const/4 v1, 0x1

    const/4 v2, 0x0

    const-string v3, "tskcmd:"

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Ljava/lang/String;->regionMatches(ZILjava/lang/String;II)Z

    move-result v0

    if-eqz v0, :cond_20

    .line 267
    const/4 v0, 0x7

    invoke-virtual {p0, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    goto :goto_9

    .line 269
    :cond_20
    return-object p0
.end method
