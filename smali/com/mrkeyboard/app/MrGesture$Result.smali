.class public final Lcom/mrkeyboard/app/MrGesture$Result;
.super Ljava/lang/Object;
.source "MrGesture.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrGesture;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Result"
.end annotation


# instance fields
.field count:I

.field extra:I

.field final info:[I

.field final scores:[F

.field final words:[C


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 69
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 70
    const/16 v0, 0x300

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrGesture$Result;->words:[C

    .line 71
    const/16 v0, 0x42

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrGesture$Result;->info:[I

    .line 72
    const/16 v0, 0x20

    new-array v0, v0, [F

    iput-object v0, p0, Lcom/mrkeyboard/app/MrGesture$Result;->scores:[F

    return-void
.end method


# virtual methods
.method public bigram(I)I
    .locals 2

    .prologue
    .line 88
    iget-object v0, p0, Lcom/mrkeyboard/app/MrGesture$Result;->info:[I

    mul-int/lit8 v1, p1, 0x4

    add-int/lit8 v1, v1, 0x5

    aget v0, v0, v1

    return v0
.end method

.method public count()I
    .locals 1

    .prologue
    .line 77
    iget v0, p0, Lcom/mrkeyboard/app/MrGesture$Result;->count:I

    return v0
.end method

.method public distinct([Ljava/lang/String;)I
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 101
    move v0, v1

    move v2, v1

    .line 102
    :goto_0
    iget v3, p0, Lcom/mrkeyboard/app/MrGesture$Result;->count:I

    if-ge v0, v3, :cond_2

    array-length v3, p1

    if-ge v2, v3, :cond_2

    .line 103
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrGesture$Result;->word(I)Ljava/lang/String;

    move-result-object v5

    move v3, v1

    move v4, v1

    .line 105
    :goto_1
    if-ge v3, v2, :cond_0

    if-nez v4, :cond_0

    aget-object v4, p1, v3

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrGesture;->sameIgnoringCase(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 106
    :cond_0
    if-nez v4, :cond_1

    add-int/lit8 v3, v2, 0x1

    aput-object v5, p1, v2

    move v2, v3

    .line 102
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 108
    :cond_2
    return v2
.end method

.method public freq(I)I
    .locals 2

    .prologue
    .line 86
    iget-object v0, p0, Lcom/mrkeyboard/app/MrGesture$Result;->info:[I

    mul-int/lit8 v1, p1, 0x4

    add-int/lit8 v1, v1, 0x4

    aget v0, v0, v1

    return v0
.end method

.method public fromExtra(I)Z
    .locals 1

    .prologue
    .line 94
    iget v0, p0, Lcom/mrkeyboard/app/MrGesture$Result;->extra:I

    shr-int/2addr v0, p1

    and-int/lit8 v0, v0, 0x1

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public hadContext()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 92
    iget-object v1, p0, Lcom/mrkeyboard/app/MrGesture$Result;->info:[I

    aget v1, v1, v0

    if-lez v1, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public keys(I)I
    .locals 2

    .prologue
    .line 84
    iget-object v0, p0, Lcom/mrkeyboard/app/MrGesture$Result;->info:[I

    mul-int/lit8 v1, p1, 0x4

    add-int/lit8 v1, v1, 0x3

    aget v0, v0, v1

    return v0
.end method

.method public logp(I)F
    .locals 2

    .prologue
    .line 82
    iget-object v0, p0, Lcom/mrkeyboard/app/MrGesture$Result;->scores:[F

    mul-int/lit8 v1, p1, 0x2

    add-int/lit8 v1, v1, 0x1

    aget v0, v0, v1

    return v0
.end method

.method public score(I)F
    .locals 2

    .prologue
    .line 80
    iget-object v0, p0, Lcom/mrkeyboard/app/MrGesture$Result;->scores:[F

    mul-int/lit8 v1, p1, 0x2

    aget v0, v0, v1

    return v0
.end method

.method public visited()I
    .locals 2

    .prologue
    .line 90
    iget-object v0, p0, Lcom/mrkeyboard/app/MrGesture$Result;->info:[I

    const/4 v1, 0x0

    aget v0, v0, v1

    return v0
.end method

.method public word(I)Ljava/lang/String;
    .locals 5

    .prologue
    .line 78
    new-instance v0, Ljava/lang/String;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrGesture$Result;->words:[C

    mul-int/lit8 v2, p1, 0x30

    iget-object v3, p0, Lcom/mrkeyboard/app/MrGesture$Result;->info:[I

    mul-int/lit8 v4, p1, 0x4

    add-int/lit8 v4, v4, 0x2

    aget v3, v3, v4

    invoke-direct {v0, v1, v2, v3}, Ljava/lang/String;-><init>([CII)V

    return-object v0
.end method
