.class public final Lcom/mrkeyboard/app/SheetModel$KeySpec;
.super Ljava/lang/Object;
.source "SheetModel.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/SheetModel;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "KeySpec"
.end annotation


# instance fields
.field public label:Ljava/lang/String;

.field public popupChars:Ljava/lang/String;

.field public popupKeys:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            ">;"
        }
    .end annotation
.end field

.field public type:Ljava/lang/String;

.field public value:Ljava/lang/String;

.field public width:F


# direct methods
.method public constructor <init>()V
    .registers 3

    .line 280
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 281
    const-string v0, ""

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    .line 282
    const-string v1, "text"

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    .line 283
    iput-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 284
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    .line 285
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V
    .registers 6

    .line 287
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 288
    const-string v0, ""

    if-nez p1, :cond_8

    move-object p1, v0

    :cond_8
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    .line 289
    invoke-static {p2}, Lcom/mrkeyboard/app/SheetModel;->normalizeType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    .line 290
    if-nez p3, :cond_13

    move-object p3, v0

    :cond_13
    iput-object p3, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 291
    invoke-static {p4}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result p1

    iput p1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    .line 292
    return-void
.end method

.method public static fromJson(Lorg/json/JSONObject;Z)Lcom/mrkeyboard/app/SheetModel$KeySpec;
    .registers 11

    .line 295
    if-nez p0, :cond_4

    const/4 p0, 0x0

    return-object p0

    .line 296
    :cond_4
    const-string v0, "type"

    const-string v1, "text"

    invoke-virtual {p0, v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetModel;->normalizeType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 297
    const-string v1, "label"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 298
    const-string v3, "value"

    invoke-virtual {p0, v3, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 299
    const-string v4, "tasker"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    const-string v5, "spacer"

    if-eqz v4, :cond_2d

    .line 300
    invoke-static {v3}, Lcom/mrkeyboard/app/SheetModel;->stripTaskerPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_34

    .line 301
    :cond_2d
    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_34

    .line 302
    move-object v3, v2

    .line 304
    :cond_34
    :goto_34
    new-instance v4, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v6, "width"

    const-wide/high16 v7, 0x3ff0000000000000L    # 1.0

    invoke-virtual {p0, v6, v7, v8}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v6

    double-to-float v6, v6

    invoke-static {v6}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v6

    invoke-direct {v4, v1, v0, v3, v6}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    .line 305
    if-eqz p1, :cond_a5

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_a5

    .line 306
    const-string p1, "popupKeys"

    invoke-virtual {p0, p1}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p1

    .line 307
    if-eqz p1, :cond_8f

    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-lez v0, :cond_8f

    .line 308
    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v0

    const/16 v1, 0xa

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 309
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(I)V

    .line 310
    const/4 v3, 0x0

    move v6, v3

    :goto_6d
    if-ge v6, v0, :cond_87

    .line 311
    invoke-virtual {p1, v6}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v7

    invoke-static {v7, v3}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->fromJson(Lorg/json/JSONObject;Z)Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v7

    .line 312
    if-eqz v7, :cond_84

    iget-object v8, v7, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_84

    .line 313
    invoke-virtual {v1, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 310
    :cond_84
    add-int/lit8 v6, v6, 0x1

    goto :goto_6d

    .line 316
    :cond_87
    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_8f

    .line 317
    iput-object v1, v4, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    .line 320
    :cond_8f
    invoke-virtual {v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasPopupKeys()Z

    move-result p1

    if-nez p1, :cond_a5

    .line 321
    const-string p1, "popupChars"

    invoke-virtual {p0, p1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 322
    if-eqz p0, :cond_a5

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_a5

    .line 323
    iput-object p0, v4, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    .line 327
    :cond_a5
    return-object v4
.end method


# virtual methods
.method public deepCopy()Lcom/mrkeyboard/app/SheetModel$KeySpec;
    .registers 10

    .line 331
    new-instance v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    iget v4, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    .line 332
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    .line 333
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    if-eqz v1, :cond_4c

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_4c

    .line 334
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    .line 335
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v2, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    .line 336
    const/4 v2, 0x0

    :goto_2b
    if-ge v2, v1, :cond_4c

    .line 337
    iget-object v3, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 338
    if-eqz v3, :cond_49

    .line 339
    iget-object v4, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    new-instance v5, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v6, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    iget-object v7, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    iget-object v8, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    iget v3, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-direct {v5, v6, v7, v8, v3}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 336
    :cond_49
    add-int/lit8 v2, v2, 0x1

    goto :goto_2b

    .line 343
    :cond_4c
    return-object v0
.end method

.method public hasAnyPopup()Z
    .registers 2

    .line 347
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasPopupKeys()Z

    move-result v0

    if-nez v0, :cond_f

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasPopupChars()Z

    move-result v0

    if-eqz v0, :cond_d

    goto :goto_f

    :cond_d
    const/4 v0, 0x0

    goto :goto_10

    :cond_f
    :goto_f
    const/4 v0, 0x1

    :goto_10
    return v0
.end method

.method public hasPopupChars()Z
    .registers 2

    .line 351
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasPopupKeys()Z

    move-result v0

    if-nez v0, :cond_14

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    if-eqz v0, :cond_14

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_14

    const/4 v0, 0x1

    goto :goto_15

    :cond_14
    const/4 v0, 0x0

    :goto_15
    return v0
.end method

.method public hasPopupKeys()Z
    .registers 2

    .line 355
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    if-eqz v0, :cond_e

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_e

    const/4 v0, 0x1

    goto :goto_f

    :cond_e
    const/4 v0, 0x0

    :goto_f
    return v0
.end method

.method public toJson()Lorg/json/JSONObject;
    .registers 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 359
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 360
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    const-string v2, ""

    if-nez v1, :cond_d

    move-object v1, v2

    goto :goto_f

    :cond_d
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    :goto_f
    const-string v3, "label"

    invoke-virtual {v0, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 361
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetModel;->normalizeType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v4, "type"

    invoke-virtual {v0, v4, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 362
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    if-nez v1, :cond_25

    move-object v1, v2

    goto :goto_27

    :cond_25
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    :goto_27
    const-string v5, "value"

    invoke-virtual {v0, v5, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 363
    iget v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v1

    float-to-double v6, v1

    const-string v1, "width"

    invoke-virtual {v0, v1, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 364
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasPopupKeys()Z

    move-result v6

    if-eqz v6, :cond_9d

    .line 365
    new-instance v6, Lorg/json/JSONArray;

    invoke-direct {v6}, Lorg/json/JSONArray;-><init>()V

    .line 366
    iget-object v7, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v7

    const/16 v8, 0xa

    invoke-static {v7, v8}, Ljava/lang/Math;->min(II)I

    move-result v7

    .line 367
    const/4 v8, 0x0

    :goto_50
    if-ge v8, v7, :cond_91

    .line 368
    iget-object v9, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v9, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 369
    if-nez v9, :cond_5d

    goto :goto_8e

    .line 370
    :cond_5d
    new-instance v10, Lorg/json/JSONObject;

    invoke-direct {v10}, Lorg/json/JSONObject;-><init>()V

    .line 371
    iget-object v11, v9, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    if-nez v11, :cond_68

    move-object v11, v2

    goto :goto_6a

    :cond_68
    iget-object v11, v9, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    :goto_6a
    invoke-virtual {v10, v3, v11}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 372
    iget-object v11, v9, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-static {v11}, Lcom/mrkeyboard/app/SheetModel;->normalizeType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v4, v11}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 373
    iget-object v11, v9, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    if-nez v11, :cond_7c

    move-object v11, v2

    goto :goto_7e

    :cond_7c
    iget-object v11, v9, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    :goto_7e
    invoke-virtual {v10, v5, v11}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 374
    iget v9, v9, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v9}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v9

    float-to-double v11, v9

    invoke-virtual {v10, v1, v11, v12}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 375
    invoke-virtual {v6, v10}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 367
    :goto_8e
    add-int/lit8 v8, v8, 0x1

    goto :goto_50

    .line 377
    :cond_91
    invoke-virtual {v6}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-lez v1, :cond_b1

    .line 378
    const-string v1, "popupKeys"

    invoke-virtual {v0, v1, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_b1

    .line 380
    :cond_9d
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    if-eqz v1, :cond_b1

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_b1

    .line 381
    const-string v1, "popupChars"

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_b2

    .line 380
    :cond_b1
    :goto_b1
    nop

    .line 383
    :goto_b2
    return-object v0
.end method
