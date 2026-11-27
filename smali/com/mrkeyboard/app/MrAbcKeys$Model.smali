.class final Lcom/mrkeyboard/app/MrAbcKeys$Model;
.super Ljava/lang/Object;
.source "MrAbcKeys.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAbcKeys;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Model"
.end annotation


# instance fields
.field final defaults:Lcom/mrkeyboard/app/SheetModel$Sheet;

.field final ids:[[Ljava/lang/String;

.field sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetModel$Sheet;Lcom/mrkeyboard/app/SheetModel$Sheet;[[Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 74
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 75
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 76
    iput-object p2, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->defaults:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 77
    iput-object p3, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->ids:[[Ljava/lang/String;

    .line 78
    return-void
.end method


# virtual methods
.method locked(II)Z
    .locals 1

    .prologue
    .line 82
    if-ltz p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->ids:[[Ljava/lang/String;

    array-length v0, v0

    if-ge p1, v0, :cond_0

    if-ltz p2, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->ids:[[Ljava/lang/String;

    aget-object v0, v0, p1

    array-length v0, v0

    if-ge p2, v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->ids:[[Ljava/lang/String;

    aget-object v0, v0, p1

    aget-object v0, v0, p2

    if-nez v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method lockedMap()[[Z
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 87
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->ids:[[Ljava/lang/String;

    array-length v0, v0

    new-array v4, v0, [[Z

    move v0, v1

    .line 88
    :goto_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->ids:[[Ljava/lang/String;

    array-length v2, v2

    if-ge v0, v2, :cond_2

    .line 89
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->ids:[[Ljava/lang/String;

    aget-object v2, v2, v0

    array-length v2, v2

    new-array v2, v2, [Z

    aput-object v2, v4, v0

    move v2, v1

    .line 90
    :goto_1
    iget-object v3, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->ids:[[Ljava/lang/String;

    aget-object v3, v3, v0

    array-length v3, v3

    if-ge v2, v3, :cond_1

    aget-object v5, v4, v0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->ids:[[Ljava/lang/String;

    aget-object v3, v3, v0

    aget-object v3, v3, v2

    if-nez v3, :cond_0

    const/4 v3, 0x1

    :goto_2
    aput-boolean v3, v5, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_0
    move v3, v1

    goto :goto_2

    .line 88
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 92
    :cond_2
    return-object v4
.end method
