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

.field private from:[I

.field head:I

.field private final hitAt:[I

.field hits:I

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

    .line 214
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 202
    new-instance v0, Ljava/util/IdentityHashMap;

    invoke-direct {v0}, Ljava/util/IdentityHashMap;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->want:Ljava/util/IdentityHashMap;

    .line 203
    new-instance v0, Ljava/util/IdentityHashMap;

    invoke-direct {v0}, Ljava/util/IdentityHashMap;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->seen:Ljava/util/IdentityHashMap;

    .line 204
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->fields:Ljava/util/HashMap;

    .line 205
    new-array v0, v1, [Ljava/lang/Object;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->objs:[Ljava/lang/Object;

    .line 206
    new-array v0, v1, [Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->how:[Ljava/lang/String;

    .line 207
    new-array v0, v1, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->from:[I

    .line 212
    const/4 v0, 0x4

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->hitAt:[I

    .line 215
    const/4 v0, 0x0

    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_1

    .line 216
    aget-object v1, p1, v0

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->want:Ljava/util/IdentityHashMap;

    aget-object v2, p1, v0

    aget-object v3, p1, v0

    invoke-virtual {v1, v2, v3}, Ljava/util/IdentityHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 215
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 218
    :cond_1
    return-void
.end method

.method private add(ILjava/lang/String;Ljava/lang/Object;)Z
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 232
    if-eqz p3, :cond_0

    invoke-static {p3}, Lcom/mrkeyboard/app/MrLive$Search;->leaf(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->seen:Ljava/util/IdentityHashMap;

    invoke-virtual {v1, p3}, Ljava/util/IdentityHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 254
    :cond_0
    :goto_0
    return v0

    .line 233
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->seen:Ljava/util/IdentityHashMap;

    invoke-virtual {v1, p3, p3}, Ljava/util/IdentityHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 234
    iget v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->objs:[Ljava/lang/Object;

    array-length v2, v2

    if-ne v1, v2, :cond_2

    .line 235
    iget v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    mul-int/lit8 v1, v1, 0x2

    .line 236
    new-array v2, v1, [Ljava/lang/Object;

    .line 237
    new-array v3, v1, [Ljava/lang/String;

    .line 238
    new-array v1, v1, [I

    .line 239
    iget-object v4, p0, Lcom/mrkeyboard/app/MrLive$Search;->objs:[Ljava/lang/Object;

    iget v5, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    invoke-static {v4, v0, v2, v0, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 240
    iget-object v4, p0, Lcom/mrkeyboard/app/MrLive$Search;->how:[Ljava/lang/String;

    iget v5, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    invoke-static {v4, v0, v3, v0, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 241
    iget-object v4, p0, Lcom/mrkeyboard/app/MrLive$Search;->from:[I

    iget v5, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    invoke-static {v4, v0, v1, v0, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 242
    iput-object v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->objs:[Ljava/lang/Object;

    .line 243
    iput-object v3, p0, Lcom/mrkeyboard/app/MrLive$Search;->how:[Ljava/lang/String;

    .line 244
    iput-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->from:[I

    .line 246
    :cond_2
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->objs:[Ljava/lang/Object;

    iget v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    aput-object p3, v1, v2

    .line 247
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->how:[Ljava/lang/String;

    iget v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    aput-object p2, v1, v2

    .line 248
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->from:[I

    iget v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    aput p1, v1, v2

    .line 249
    iget v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    .line 250
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->want:Ljava/util/IdentityHashMap;

    invoke-virtual {v1, p3}, Ljava/util/IdentityHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 251
    iget v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->hits:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->hitAt:[I

    array-length v1, v1

    if-ge v0, v1, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->hitAt:[I

    iget v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->hits:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->hits:I

    iget v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->n:I

    add-int/lit8 v2, v2, -0x1

    aput v2, v0, v1

    .line 252
    :cond_3
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
    .line 278
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->fields:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/reflect/Field;

    .line 279
    if-eqz v0, :cond_0

    .line 301
    :goto_0
    return-object v0

    .line 280
    :cond_0
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    move-object v1, p1

    .line 281
    :goto_1
    if-eqz v1, :cond_4

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    const-string v3, "com.mrkeyboard."

    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 284
    :try_start_0
    invoke-virtual {v1}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    .line 288
    const/4 v0, 0x0

    :goto_2
    array-length v4, v3

    if-ge v0, v4, :cond_3

    .line 289
    aget-object v4, v3, v0

    .line 290
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

    .line 288
    :cond_1
    :goto_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 292
    :cond_2
    const/4 v5, 0x1

    :try_start_1
    invoke-virtual {v4, v5}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 293
    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_3

    .line 294
    :catch_0
    move-exception v4

    goto :goto_3

    .line 285
    :catch_1
    move-exception v0

    .line 281
    :cond_3
    invoke-virtual {v1}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object v0

    move-object v1, v0

    goto :goto_1

    .line 299
    :cond_4
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/reflect/Field;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/reflect/Field;

    .line 300
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->fields:Ljava/util/HashMap;

    invoke-virtual {v1, p1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0
.end method

.method private static leaf(Ljava/lang/Object;)Z
    .locals 1

    .prologue
    .line 221
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
    .line 260
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 264
    const/4 v0, 0x0

    :goto_0
    array-length v2, v1

    if-ge v0, v2, :cond_2

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrLive$Search;->done()Z

    move-result v2

    if-nez v2, :cond_2

    .line 265
    aget-object v2, v1, v0

    .line 266
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

    .line 264
    :cond_0
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 268
    :cond_1
    const/4 v3, 0x1

    :try_start_1
    invoke-virtual {v2, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 269
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

    .line 270
    :catch_0
    move-exception v2

    goto :goto_1

    .line 261
    :catch_1
    move-exception v0

    .line 274
    :cond_2
    return-void
.end method

.method done()Z
    .locals 3

    .prologue
    .line 227
    iget v0, p0, Lcom/mrkeyboard/app/MrLive$Search;->hits:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->want:Ljava/util/IdentityHashMap;

    invoke-virtual {v1}, Ljava/util/IdentityHashMap;->size()I

    move-result v1

    const/4 v2, 0x4

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method expand(I)V
    .locals 9

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x0

    .line 305
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLive$Search;->objs:[Ljava/lang/Object;

    aget-object v1, v1, p1

    .line 306
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->want:Ljava/util/IdentityHashMap;

    invoke-virtual {v2, v1}, Ljava/util/IdentityHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 360
    :cond_0
    return-void

    .line 307
    :cond_1
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    .line 308
    invoke-virtual {v6}, Ljava/lang/Class;->isArray()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 309
    invoke-virtual {v6}, Ljava/lang/Class;->getComponentType()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->isPrimitive()Z

    move-result v2

    if-nez v2, :cond_0

    .line 310
    check-cast v1, [Ljava/lang/Object;

    move v2, v3

    .line 311
    :goto_0
    array-length v3, v1

    if-ge v2, v3, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrLive$Search;->done()Z

    move-result v3

    if-nez v3, :cond_0

    const-string v3, "[]"

    aget-object v4, v1, v2

    invoke-direct {p0, p1, v3, v4}, Lcom/mrkeyboard/app/MrLive$Search;->add(ILjava/lang/String;Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 315
    :cond_2
    instance-of v2, v1, Ljava/util/Collection;

    if-eqz v2, :cond_3

    .line 318
    :try_start_0
    move-object v0, v1

    check-cast v0, Ljava/util/Collection;

    move-object v2, v0

    invoke-interface {v2}, Ljava/util/Collection;->toArray()[Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_4

    move-result-object v4

    .line 322
    :goto_1
    if-eqz v4, :cond_5

    move v2, v3

    :goto_2
    array-length v5, v4

    if-ge v2, v5, :cond_5

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrLive$Search;->done()Z

    move-result v5

    if-nez v5, :cond_5

    const-string v5, "item"

    aget-object v7, v4, v2

    invoke-direct {p0, p1, v5, v7}, Lcom/mrkeyboard/app/MrLive$Search;->add(ILjava/lang/String;Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 323
    :cond_3
    instance-of v2, v1, Ljava/util/Map;

    if-eqz v2, :cond_5

    .line 327
    :try_start_1
    move-object v0, v1

    check-cast v0, Ljava/util/Map;

    move-object v2, v0

    .line 328
    invoke-interface {v2}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Collection;->toArray()[Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v5

    .line 330
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

    .line 334
    :goto_4
    if-eqz v4, :cond_4

    move v2, v3

    :goto_5
    array-length v7, v4

    if-ge v2, v7, :cond_4

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrLive$Search;->done()Z

    move-result v7

    if-nez v7, :cond_4

    const-string v7, "key"

    aget-object v8, v4, v2

    invoke-direct {p0, p1, v7, v8}, Lcom/mrkeyboard/app/MrLive$Search;->add(ILjava/lang/String;Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_5

    .line 331
    :catch_0
    move-exception v2

    move-object v2, v4

    :goto_6
    move-object v5, v2

    goto :goto_4

    .line 335
    :cond_4
    if-eqz v5, :cond_5

    move v2, v3

    :goto_7
    array-length v4, v5

    if-ge v2, v4, :cond_5

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrLive$Search;->done()Z

    move-result v4

    if-nez v4, :cond_5

    const-string v4, "value"

    aget-object v7, v5, v2

    invoke-direct {p0, p1, v4, v7}, Lcom/mrkeyboard/app/MrLive$Search;->add(ILjava/lang/String;Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_7

    .line 337
    :cond_5
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrLive$Search;->done()Z

    move-result v2

    if-nez v2, :cond_0

    .line 338
    instance-of v2, v1, Landroid/view/View;

    if-eqz v2, :cond_6

    move-object v2, v1

    .line 339
    check-cast v2, Landroid/view/View;

    .line 341
    :try_start_3
    const-string v4, "context"

    invoke-virtual {v2}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {p0, p1, v4, v2}, Lcom/mrkeyboard/app/MrLive$Search;->add(ILjava/lang/String;Ljava/lang/Object;)Z

    .line 342
    instance-of v2, v1, Landroid/view/ViewGroup;

    if-eqz v2, :cond_6

    .line 343
    move-object v0, v1

    check-cast v0, Landroid/view/ViewGroup;

    move-object v2, v0

    .line 344
    invoke-virtual {v2}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v5

    move v4, v3

    .line 345
    :goto_8
    if-ge v4, v5, :cond_6

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrLive$Search;->done()Z

    move-result v7

    if-nez v7, :cond_6

    const-string v7, "child"

    invoke-virtual {v2, v4}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v8

    invoke-direct {p0, p1, v7, v8}, Lcom/mrkeyboard/app/MrLive$Search;->add(ILjava/lang/String;Ljava/lang/Object;)Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    add-int/lit8 v4, v4, 0x1

    goto :goto_8

    .line 347
    :catch_1
    move-exception v2

    .line 351
    :cond_6
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrLive$Search;->done()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual {v6}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    const-string v4, "com.mrkeyboard."

    invoke-virtual {v2, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 352
    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/MrLive$Search;->fieldsOf(Ljava/lang/Class;)[Ljava/lang/reflect/Field;

    move-result-object v2

    .line 353
    :goto_9
    array-length v4, v2

    if-ge v3, v4, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrLive$Search;->done()Z

    move-result v4

    if-nez v4, :cond_0

    .line 355
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

    .line 353
    :goto_a
    add-int/lit8 v3, v3, 0x1

    goto :goto_9

    .line 356
    :catch_2
    move-exception v4

    goto :goto_a

    .line 331
    :catch_3
    move-exception v2

    move-object v2, v5

    goto/16 :goto_6

    .line 319
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

    .line 374
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 375
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

    .line 376
    :cond_0
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v1, 0x8

    if-le v0, v1, :cond_5

    .line 377
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    move v1, v4

    .line 378
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

    .line 379
    :cond_1
    const-string v0, "..."

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 380
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

    .line 383
    :goto_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    move v2, v4

    .line 384
    :goto_4
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v2, v0, :cond_4

    .line 385
    if-lez v2, :cond_3

    const-string v0, " > "

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 386
    :cond_3
    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 384
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_4

    .line 388
    :cond_4
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_5
    move-object v1, v3

    goto :goto_3
.end method

.method paths()Ljava/lang/String;
    .locals 3

    .prologue
    .line 364
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 365
    const/4 v0, 0x0

    :goto_0
    iget v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->hits:I

    if-ge v0, v2, :cond_1

    .line 366
    if-lez v0, :cond_0

    const/16 v2, 0xa

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 367
    :cond_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrLive$Search;->hitAt:[I

    aget v2, v2, v0

    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/MrLive$Search;->path(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 365
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 369
    :cond_1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
