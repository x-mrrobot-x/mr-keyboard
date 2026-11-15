.class final Lcom/mrkeyboard/app/MrLive$Search;
.super Ljava/lang/Object;
.source "MrLive.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrLive;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Search"
.end annotation


# instance fields
.field private final fields:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Class",
            "<*>;[",
            "Ljava/lang/reflect/Field;",
            ">;"
        }
    .end annotation
.end field

.field found:I

.field private from:[I

.field head:I

.field private how:[Ljava/lang/String;

.field n:I

.field private objs:[Ljava/lang/Object;

.field private final seen:Ljava/util/IdentityHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/IdentityHashMap",
            "<",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private final want:Ljava/util/IdentityHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/IdentityHashMap",
            "<",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>([Ljava/lang/Object;)V
    .locals 4

    .prologue
    const/16 v1, 0x1000

    .line 208
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 198
    new-instance v0, Ljava/util/IdentityHashMap;

    invoke-direct {v0}, Ljava/util/IdentityHashMap;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->want:Ljava/util/IdentityHashMap;

    .line 199
    new-instance v0, Ljava/util/IdentityHashMap;

    invoke-direct {v0}, Ljava/util/IdentityHashMap;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->seen:Ljava/util/IdentityHashMap;

    .line 200
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->fields:Ljava/util/HashMap;

    .line 201
    new-array v0, v1, [Ljava/lang/Object;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->objs:[Ljava/lang/Object;

    .line 202
    new-array v0, v1, [Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->how:[Ljava/lang/String;

    .line 203
    new-array v0, v1, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->from:[I

    .line 206
    const/4 v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->found:I

    .line 209
    const/4 v0, 0x0

    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_1

    .line 210
    aget-object v1, p1, v0

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->want:Ljava/util/IdentityHashMap;

    aget-object v2, p1, v0

    aget-object v3, p1, v0

    invoke-virtual {v1, v2, v3}, Ljava/util/IdentityHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 209
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 212
    :cond_1
    return-void
.end method

.method private add(ILjava/lang/String;Ljava/lang/Object;)Z
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 221
    if-eqz p3, :cond_0

    invoke-static {p3}, Lcom/mrkeyboard/app/MrLive$Search;->leaf(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->seen:Ljava/util/IdentityHashMap;

    invoke-virtual {v1, p3}, Ljava/util/IdentityHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 243
    :cond_0
    :goto_0
    return v0

    .line 222
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->seen:Ljava/util/IdentityHashMap;

    invoke-virtual {v1, p3, p3}, Ljava/util/IdentityHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 223
    iget v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->objs:[Ljava/lang/Object;

    array-length v2, v2

    if-ne v1, v2, :cond_2

    .line 224
    iget v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    mul-int/lit8 v1, v1, 0x2

    .line 225
    new-array v2, v1, [Ljava/lang/Object;

    .line 226
    new-array v3, v1, [Ljava/lang/String;

    .line 227
    new-array v1, v1, [I

    .line 228
    iget-object v4, p0, Lcom/mrkeyboard/app/MrLive$Search;->objs:[Ljava/lang/Object;

    iget v5, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    invoke-static {v4, v0, v2, v0, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 229
    iget-object v4, p0, Lcom/mrkeyboard/app/MrLive$Search;->how:[Ljava/lang/String;

    iget v5, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    invoke-static {v4, v0, v3, v0, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 230
    iget-object v4, p0, Lcom/mrkeyboard/app/MrLive$Search;->from:[I

    iget v5, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    invoke-static {v4, v0, v1, v0, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 231
    iput-object v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->objs:[Ljava/lang/Object;

    .line 232
    iput-object v3, p0, Lcom/mrkeyboard/app/MrLive$Search;->how:[Ljava/lang/String;

    .line 233
    iput-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->from:[I

    .line 235
    :cond_2
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->objs:[Ljava/lang/Object;

    iget v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    aput-object p3, v1, v2

    .line 236
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->how:[Ljava/lang/String;

    iget v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    aput-object p2, v1, v2

    .line 237
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->from:[I

    iget v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    aput p1, v1, v2

    .line 238
    iget v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    .line 239
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->want:Ljava/util/IdentityHashMap;

    invoke-virtual {v1, p3}, Ljava/util/IdentityHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 240
    iget v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->found:I

    .line 241
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private fieldsOf(Ljava/lang/Class;)[Ljava/lang/reflect/Field;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<*>;)[",
            "Ljava/lang/reflect/Field;"
        }
    .end annotation

    .prologue
    .line 267
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->fields:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/reflect/Field;

    .line 268
    if-eqz v0, :cond_0

    .line 290
    :goto_0
    return-object v0

    .line 269
    :cond_0
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    move-object v1, p1

    .line 270
    :goto_1
    if-eqz v1, :cond_4

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    const-string v3, "com.mrkeyboard."

    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 273
    :try_start_0
    invoke-virtual {v1}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    .line 277
    const/4 v0, 0x0

    :goto_2
    array-length v4, v3

    if-ge v0, v4, :cond_3

    .line 278
    aget-object v4, v3, v0

    .line 279
    invoke-virtual {v4}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result v5

    invoke-static {v5}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v5

    if-nez v5, :cond_1

    invoke-virtual {v4}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->isPrimitive()Z

    move-result v5

    if-eqz v5, :cond_2

    .line 277
    :cond_1
    :goto_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 281
    :cond_2
    const/4 v5, 0x1

    :try_start_1
    invoke-virtual {v4, v5}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 282
    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_3

    .line 283
    :catch_0
    move-exception v4

    goto :goto_3

    .line 274
    :catch_1
    move-exception v0

    .line 270
    :cond_3
    invoke-virtual {v1}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object v0

    move-object v1, v0

    goto :goto_1

    .line 288
    :cond_4
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/reflect/Field;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/reflect/Field;

    .line 289
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->fields:Ljava/util/HashMap;

    invoke-virtual {v1, p1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0
.end method

.method private static leaf(Ljava/lang/Object;)Z
    .locals 1

    .prologue
    .line 215
    instance-of v0, p0, Ljava/lang/CharSequence;

    if-nez v0, :cond_0

    instance-of v0, p0, Ljava/lang/Number;

    if-nez v0, :cond_0

    instance-of v0, p0, Ljava/lang/Boolean;

    if-nez v0, :cond_0

    instance-of v0, p0, Ljava/lang/Character;

    if-nez v0, :cond_0

    instance-of v0, p0, Ljava/lang/Class;

    if-nez v0, :cond_0

    instance-of v0, p0, Ljava/lang/ref/Reference;

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method addRoot(Ljava/lang/Class;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<*>;)V"
        }
    .end annotation

    .prologue
    .line 249
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 253
    const/4 v0, 0x0

    :goto_0
    array-length v2, v1

    if-ge v0, v2, :cond_2

    iget v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->found:I

    if-gez v2, :cond_2

    .line 254
    aget-object v2, v1, v0

    .line 255
    invoke-virtual {v2}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result v3

    invoke-static {v3}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v2}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->isPrimitive()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 253
    :cond_0
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 257
    :cond_1
    const/4 v3, 0x1

    :try_start_1
    invoke-virtual {v2, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 258
    const/4 v3, -0x1

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {p1}, Lcom/mrkeyboard/app/MrLive;->access$000(Ljava/lang/Class;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual {v2, v5}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-direct {p0, v3, v4, v2}, Lcom/mrkeyboard/app/MrLive$Search;->add(ILjava/lang/String;Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    .line 259
    :catch_0
    move-exception v2

    goto :goto_1

    .line 250
    :catch_1
    move-exception v0

    .line 263
    :cond_2
    return-void
.end method

.method expand(I)V
    .locals 9

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x0

    .line 294
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->objs:[Ljava/lang/Object;

    aget-object v1, v1, p1

    .line 295
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    .line 296
    invoke-virtual {v6}, Ljava/lang/Class;->isArray()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 297
    invoke-virtual {v6}, Ljava/lang/Class;->getComponentType()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->isPrimitive()Z

    move-result v2

    if-nez v2, :cond_4

    .line 298
    check-cast v1, [Ljava/lang/Object;

    move v2, v3

    .line 299
    :goto_0
    array-length v3, v1

    if-ge v2, v3, :cond_4

    iget v3, p0, Lcom/mrkeyboard/app/MrLive$Search;->found:I

    if-gez v3, :cond_4

    const-string v3, "[]"

    aget-object v4, v1, v2

    invoke-direct {p0, p1, v3, v4}, Lcom/mrkeyboard/app/MrLive$Search;->add(ILjava/lang/String;Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 303
    :cond_0
    instance-of v2, v1, Ljava/util/Collection;

    if-eqz v2, :cond_1

    .line 306
    :try_start_0
    move-object v0, v1

    check-cast v0, Ljava/util/Collection;

    move-object v2, v0

    invoke-interface {v2}, Ljava/util/Collection;->toArray()[Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_4

    move-result-object v4

    .line 310
    :goto_1
    if-eqz v4, :cond_3

    move v2, v3

    :goto_2
    array-length v5, v4

    if-ge v2, v5, :cond_3

    iget v5, p0, Lcom/mrkeyboard/app/MrLive$Search;->found:I

    if-gez v5, :cond_3

    const-string v5, "item"

    aget-object v7, v4, v2

    invoke-direct {p0, p1, v5, v7}, Lcom/mrkeyboard/app/MrLive$Search;->add(ILjava/lang/String;Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 311
    :cond_1
    instance-of v2, v1, Ljava/util/Map;

    if-eqz v2, :cond_3

    .line 315
    :try_start_1
    move-object v0, v1

    check-cast v0, Ljava/util/Map;

    move-object v2, v0

    .line 316
    invoke-interface {v2}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Collection;->toArray()[Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v5

    .line 318
    :try_start_2
    instance-of v7, v1, Ljava/util/WeakHashMap;

    if-nez v7, :cond_7

    invoke-interface {v2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->toArray()[Ljava/lang/Object;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_3

    move-result-object v2

    :goto_3
    move-object v4, v2

    .line 322
    :goto_4
    if-eqz v4, :cond_2

    move v2, v3

    :goto_5
    array-length v7, v4

    if-ge v2, v7, :cond_2

    iget v7, p0, Lcom/mrkeyboard/app/MrLive$Search;->found:I

    if-gez v7, :cond_2

    const-string v7, "key"

    aget-object v8, v4, v2

    invoke-direct {p0, p1, v7, v8}, Lcom/mrkeyboard/app/MrLive$Search;->add(ILjava/lang/String;Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_5

    .line 319
    :catch_0
    move-exception v2

    move-object v2, v4

    :goto_6
    move-object v5, v2

    goto :goto_4

    .line 323
    :cond_2
    if-eqz v5, :cond_3

    move v2, v3

    :goto_7
    array-length v4, v5

    if-ge v2, v4, :cond_3

    iget v4, p0, Lcom/mrkeyboard/app/MrLive$Search;->found:I

    if-gez v4, :cond_3

    const-string v4, "value"

    aget-object v7, v5, v2

    invoke-direct {p0, p1, v4, v7}, Lcom/mrkeyboard/app/MrLive$Search;->add(ILjava/lang/String;Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_7

    .line 325
    :cond_3
    iget v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->found:I

    if-ltz v2, :cond_5

    .line 348
    :cond_4
    return-void

    .line 326
    :cond_5
    instance-of v2, v1, Landroid/view/View;

    if-eqz v2, :cond_6

    move-object v2, v1

    .line 327
    check-cast v2, Landroid/view/View;

    .line 329
    :try_start_3
    const-string v4, "context"

    invoke-virtual {v2}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {p0, p1, v4, v2}, Lcom/mrkeyboard/app/MrLive$Search;->add(ILjava/lang/String;Ljava/lang/Object;)Z

    .line 330
    instance-of v2, v1, Landroid/view/ViewGroup;

    if-eqz v2, :cond_6

    .line 331
    move-object v0, v1

    check-cast v0, Landroid/view/ViewGroup;

    move-object v2, v0

    .line 332
    invoke-virtual {v2}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v5

    move v4, v3

    .line 333
    :goto_8
    if-ge v4, v5, :cond_6

    iget v7, p0, Lcom/mrkeyboard/app/MrLive$Search;->found:I

    if-gez v7, :cond_6

    const-string v7, "child"

    invoke-virtual {v2, v4}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v8

    invoke-direct {p0, p1, v7, v8}, Lcom/mrkeyboard/app/MrLive$Search;->add(ILjava/lang/String;Ljava/lang/Object;)Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    add-int/lit8 v4, v4, 0x1

    goto :goto_8

    .line 335
    :catch_1
    move-exception v2

    .line 339
    :cond_6
    iget v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->found:I

    if-gez v2, :cond_4

    invoke-virtual {v6}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    const-string v4, "com.mrkeyboard."

    invoke-virtual {v2, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 340
    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/MrLive$Search;->fieldsOf(Ljava/lang/Class;)[Ljava/lang/reflect/Field;

    move-result-object v2

    .line 341
    :goto_9
    array-length v4, v2

    if-ge v3, v4, :cond_4

    iget v4, p0, Lcom/mrkeyboard/app/MrLive$Search;->found:I

    if-gez v4, :cond_4

    .line 343
    :try_start_4
    aget-object v4, v2, v3

    invoke-virtual {v4}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v4

    aget-object v5, v2, v3

    invoke-virtual {v5, v1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    invoke-direct {p0, p1, v4, v5}, Lcom/mrkeyboard/app/MrLive$Search;->add(ILjava/lang/String;Ljava/lang/Object;)Z
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    .line 341
    :goto_a
    add-int/lit8 v3, v3, 0x1

    goto :goto_9

    .line 344
    :catch_2
    move-exception v4

    goto :goto_a

    .line 319
    :catch_3
    move-exception v2

    move-object v2, v5

    goto :goto_6

    .line 307
    :catch_4
    move-exception v2

    goto/16 :goto_1

    :cond_7
    move-object v2, v4

    goto/16 :goto_3
.end method

.method path(I)Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 352
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 353
    :goto_0
    if-ltz p1, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->how:[Ljava/lang/String;

    aget-object v1, v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->objs:[Ljava/lang/Object;

    aget-object v1, v1, p1

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrLive;->access$000(Ljava/lang/Class;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v4, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    iget-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->from:[I

    aget p1, v0, p1

    goto :goto_0

    .line 354
    :cond_0
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v1, 0x8

    if-le v0, v1, :cond_5

    .line 355
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    move v1, v4

    .line 356
    :goto_1
    const/4 v0, 0x4

    if-ge v1, v0, :cond_1

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 357
    :cond_1
    const-string v0, "..."

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 358
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x3

    move v1, v0

    :goto_2
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_2

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_2

    :cond_2
    move-object v1, v2

    .line 361
    :goto_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    move v2, v4

    .line 362
    :goto_4
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v2, v0, :cond_4

    .line 363
    if-lez v2, :cond_3

    const-string v0, " > "

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 364
    :cond_3
    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 362
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_4

    .line 366
    :cond_4
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_5
    move-object v1, v3

    goto :goto_3
.end method
