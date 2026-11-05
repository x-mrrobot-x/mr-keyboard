.class interface abstract Lcom/mrkeyboard/app/MrWordStore;
.super Ljava/lang/Object;
.source "MrWordStore.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrWordStore$Row;
    }
.end annotation


# static fields
.field public static final KIND_BLOCKED:I = 0x4

.field public static final KIND_IMPORTED_PAIR:I = 0x3

.field public static final KIND_IMPORTED_WORD:I = 0x2

.field public static final KIND_LEARNED_PAIR:I = 0x1

.field public static final KIND_LEARNED_WORD:I = 0x0

.field public static final SORT_NEW:I = 0x1

.field public static final SORT_USED:I


# virtual methods
.method public abstract add(ILjava/lang/String;Lcom/mrkeyboard/app/MrWordStore$Row;)J
.end method

.method public abstract all(ILjava/lang/String;)Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrWordStore$Row;",
            ">;"
        }
    .end annotation
.end method

.method public abstract begin()V
.end method

.method public abstract count(ILjava/lang/String;)I
.end method

.method public abstract delete(IJ)Z
.end method

.method public abstract deleteAll(ILjava/lang/String;)I
.end method

.method public abstract deleteBatch(Ljava/lang/String;J)I
.end method

.method public abstract end()V
.end method

.method public abstract list(ILjava/lang/String;Ljava/lang/String;III)Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "III)",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrWordStore$Row;",
            ">;"
        }
    .end annotation
.end method

.method public abstract locales()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end method

.method public abstract newBatch()J
.end method
