.class Lcom/mrkeyboard/app/MrAppList$2;
.super Ljava/lang/Object;
.source "MrAppList.java"

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppList;->sort(Ljava/util/List;)V
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
        "Lcom/mrkeyboard/app/MrAppList$Entry;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 133
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public compare(Lcom/mrkeyboard/app/MrAppList$Entry;Lcom/mrkeyboard/app/MrAppList$Entry;)I
    .locals 2

    .prologue
    .line 135
    iget-object v0, p1, Lcom/mrkeyboard/app/MrAppList$Entry;->folded:Ljava/lang/String;

    iget-object v1, p2, Lcom/mrkeyboard/app/MrAppList$Entry;->folded:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v0

    .line 136
    if-eqz v0, :cond_0

    :goto_0
    return v0

    :cond_0
    iget-object v0, p1, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    iget-object v1, p2, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method public bridge synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 1

    .prologue
    .line 133
    check-cast p1, Lcom/mrkeyboard/app/MrAppList$Entry;

    check-cast p2, Lcom/mrkeyboard/app/MrAppList$Entry;

    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/MrAppList$2;->compare(Lcom/mrkeyboard/app/MrAppList$Entry;Lcom/mrkeyboard/app/MrAppList$Entry;)I

    move-result v0

    return v0
.end method
