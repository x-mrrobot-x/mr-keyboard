.class Lcom/mrkeyboard/app/MrMemStore$1;
.super Ljava/lang/Object;
.source "MrMemStore.java"

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrMemStore;->list(ILjava/lang/String;Ljava/lang/String;III)Ljava/util/List;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator",
        "<",
        "Lcom/mrkeyboard/app/MrWordStore$Row;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrMemStore;

.field final synthetic val$sort:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrMemStore;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 55
    iput-object p1, p0, Lcom/mrkeyboard/app/MrMemStore$1;->this$0:Lcom/mrkeyboard/app/MrMemStore;

    iput p2, p0, Lcom/mrkeyboard/app/MrMemStore$1;->val$sort:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public compare(Lcom/mrkeyboard/app/MrWordStore$Row;Lcom/mrkeyboard/app/MrWordStore$Row;)I
    .locals 6

    .prologue
    const/4 v1, 0x1

    const/4 v0, -0x1

    .line 57
    iget v2, p0, Lcom/mrkeyboard/app/MrMemStore$1;->val$sort:I

    if-nez v2, :cond_2

    iget v2, p1, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    iget v3, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    if-eq v2, v3, :cond_2

    iget v2, p1, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    iget v3, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    if-le v2, v3, :cond_1

    .line 58
    :cond_0
    :goto_0
    return v0

    :cond_1
    move v0, v1

    .line 57
    goto :goto_0

    .line 58
    :cond_2
    iget-wide v2, p1, Lcom/mrkeyboard/app/MrWordStore$Row;->id:J

    iget-wide v4, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->id:J

    cmp-long v2, v2, v4

    if-nez v2, :cond_3

    const/4 v0, 0x0

    goto :goto_0

    :cond_3
    iget-wide v2, p1, Lcom/mrkeyboard/app/MrWordStore$Row;->id:J

    iget-wide v4, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->id:J

    cmp-long v2, v2, v4

    if-gtz v2, :cond_0

    move v0, v1

    goto :goto_0
.end method

.method public bridge synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 1

    .prologue
    .line 55
    check-cast p1, Lcom/mrkeyboard/app/MrWordStore$Row;

    check-cast p2, Lcom/mrkeyboard/app/MrWordStore$Row;

    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/MrMemStore$1;->compare(Lcom/mrkeyboard/app/MrWordStore$Row;Lcom/mrkeyboard/app/MrWordStore$Row;)I

    move-result v0

    return v0
.end method
