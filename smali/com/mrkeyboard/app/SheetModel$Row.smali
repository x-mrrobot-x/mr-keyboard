.class public final Lcom/mrkeyboard/app/SheetModel$Row;
.super Ljava/lang/Object;
.source "SheetModel.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/SheetModel;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Row"
.end annotation


# instance fields
.field public keys:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .registers 2

    .line 387
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 388
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    return-void
.end method

.method public static fromJson(Lorg/json/JSONObject;)Lcom/mrkeyboard/app/SheetModel$Row;
    .registers 6

    .line 391
    new-instance v0, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {v0}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    .line 392
    if-nez p0, :cond_8

    return-object v0

    .line 393
    :cond_8
    const-string v1, "keys"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p0

    .line 394
    if-eqz p0, :cond_35

    .line 395
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v1

    const/16 v2, 0xa

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 396
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->ensureCapacity(I)V

    .line 397
    const/4 v2, 0x0

    :goto_20
    if-ge v2, v1, :cond_35

    .line 398
    invoke-virtual {p0, v2}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    const/4 v4, 0x1

    invoke-static {v3, v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->fromJson(Lorg/json/JSONObject;Z)Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v3

    .line 399
    if-eqz v3, :cond_32

    .line 400
    iget-object v4, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 397
    :cond_32
    add-int/lit8 v2, v2, 0x1

    goto :goto_20

    .line 404
    :cond_35
    return-object v0
.end method


# virtual methods
.method public deepCopy()Lcom/mrkeyboard/app/SheetModel$Row;
    .registers 6

    .line 408
    new-instance v0, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {v0}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    .line 409
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    .line 410
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->ensureCapacity(I)V

    .line 411
    const/4 v2, 0x0

    :goto_11
    if-ge v2, v1, :cond_29

    .line 412
    iget-object v3, p0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 413
    if-eqz v3, :cond_26

    .line 414
    iget-object v4, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->deepCopy()Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v3

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 411
    :cond_26
    add-int/lit8 v2, v2, 0x1

    goto :goto_11

    .line 417
    :cond_29
    return-object v0
.end method

.method public toJson()Lorg/json/JSONObject;
    .registers 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 421
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 422
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 423
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/16 v3, 0xa

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 424
    const/4 v3, 0x0

    :goto_17
    if-ge v3, v2, :cond_2d

    .line 425
    iget-object v4, p0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 426
    if-eqz v4, :cond_2a

    .line 427
    invoke-virtual {v4}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->toJson()Lorg/json/JSONObject;

    move-result-object v4

    invoke-virtual {v1, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 424
    :cond_2a
    add-int/lit8 v3, v3, 0x1

    goto :goto_17

    .line 430
    :cond_2d
    const-string v2, "keys"

    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 431
    return-object v0
.end method
