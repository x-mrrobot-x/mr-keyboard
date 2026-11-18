.class Lcom/mrkeyboard/app/MrAppList$1;
.super Ljava/lang/Object;
.source "MrAppList.java"

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppList;->scan(Landroid/content/Context;)Ljava/util/List;
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
        "Lcom/mrkeyboard/app/MrAppList$Found;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 99
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public compare(Lcom/mrkeyboard/app/MrAppList$Found;Lcom/mrkeyboard/app/MrAppList$Found;)I
    .locals 2

    .prologue
    .line 101
    iget-object v0, p1, Lcom/mrkeyboard/app/MrAppList$Found;->pkg:Ljava/lang/String;

    iget-object v1, p2, Lcom/mrkeyboard/app/MrAppList$Found;->pkg:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public bridge synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 1

    .prologue
    .line 99
    check-cast p1, Lcom/mrkeyboard/app/MrAppList$Found;

    check-cast p2, Lcom/mrkeyboard/app/MrAppList$Found;

    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/MrAppList$1;->compare(Lcom/mrkeyboard/app/MrAppList$Found;Lcom/mrkeyboard/app/MrAppList$Found;)I

    move-result v0

    return v0
.end method
