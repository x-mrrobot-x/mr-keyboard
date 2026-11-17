.class final Lcom/mrkeyboard/app/MrGestureWords$Collector;
.super Ljava/lang/Object;
.source "MrGestureWords.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrGestureWords;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Collector"
.end annotation


# instance fields
.field private final buf:[C

.field freqs:[I

.field private index:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field n:I

.field words:[Ljava/lang/String;


# direct methods
.method constructor <init>()V
    .locals 2

    .prologue
    const/16 v1, 0x100

    .line 152
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 153
    new-array v0, v1, [Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->words:[Ljava/lang/String;

    .line 154
    new-array v0, v1, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->freqs:[I

    .line 156
    const/16 v0, 0x30

    new-array v0, v0, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->buf:[C

    .line 157
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->index:Ljava/util/HashMap;

    return-void
.end method

.method private static clamp(I)I
    .locals 1

    .prologue
    const/16 v0, 0xff

    .line 215
    if-gez p0, :cond_1

    const/4 p0, 0x0

    :cond_0
    :goto_0
    return p0

    :cond_1
    if-le p0, v0, :cond_0

    move p0, v0

    goto :goto_0
.end method

.method private walk(Lcom/mrkeyboard/app/ExpandableDictionary$NodeArray;II)V
    .locals 8

    .prologue
    const/4 v1, 0x0

    .line 165
    if-eqz p1, :cond_0

    const/16 v0, 0x30

    if-lt p2, v0, :cond_1

    .line 176
    :cond_0
    return-void

    .line 166
    :cond_1
    iget-object v2, p1, Lcom/mrkeyboard/app/ExpandableDictionary$NodeArray;->data:[Lcom/mrkeyboard/app/ExpandableDictionary$Node;

    .line 167
    if-eqz v2, :cond_0

    .line 168
    iget v0, p1, Lcom/mrkeyboard/app/ExpandableDictionary$NodeArray;->length:I

    array-length v3, v2

    invoke-static {v0, v3}, Ljava/lang/Math;->min(II)I

    move-result v3

    move v0, v1

    .line 169
    :goto_0
    if-ge v0, v3, :cond_0

    .line 170
    aget-object v4, v2, v0

    .line 171
    if-nez v4, :cond_2

    .line 169
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 172
    :cond_2
    iget-object v5, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->buf:[C

    iget-char v6, v4, Lcom/mrkeyboard/app/ExpandableDictionary$Node;->code:C

    aput-char v6, v5, p2

    .line 173
    iget-boolean v5, v4, Lcom/mrkeyboard/app/ExpandableDictionary$Node;->terminal:Z

    if-eqz v5, :cond_3

    iget v5, v4, Lcom/mrkeyboard/app/ExpandableDictionary$Node;->frequency:I

    if-lt v5, p3, :cond_3

    new-instance v5, Ljava/lang/String;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->buf:[C

    add-int/lit8 v7, p2, 0x1

    invoke-direct {v5, v6, v1, v7}, Ljava/lang/String;-><init>([CII)V

    iget v6, v4, Lcom/mrkeyboard/app/ExpandableDictionary$Node;->frequency:I

    invoke-virtual {p0, v5, v6}, Lcom/mrkeyboard/app/MrGestureWords$Collector;->add(Ljava/lang/String;I)V

    .line 174
    :cond_3
    iget-object v4, v4, Lcom/mrkeyboard/app/ExpandableDictionary$Node;->children:Lcom/mrkeyboard/app/ExpandableDictionary$NodeArray;

    add-int/lit8 v5, p2, 0x1

    invoke-direct {p0, v4, v5, p3}, Lcom/mrkeyboard/app/MrGestureWords$Collector;->walk(Lcom/mrkeyboard/app/ExpandableDictionary$NodeArray;II)V

    goto :goto_1
.end method


# virtual methods
.method add(Ljava/lang/String;I)V
    .locals 3

    .prologue
    .line 179
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0x30

    if-gt v0, v1, :cond_0

    invoke-static {p1}, Lcom/mrkeyboard/app/MrLearned;->isBlocked(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 193
    :cond_0
    :goto_0
    return-void

    .line 180
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->index:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 181
    if-eqz v0, :cond_2

    .line 182
    iget-object v1, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->freqs:[I

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v2

    aget v1, v1, v2

    if-le p2, v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->freqs:[I

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    aput p2, v1, v0

    goto :goto_0

    .line 185
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->n:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->words:[Ljava/lang/String;

    array-length v1, v1

    if-ne v0, v1, :cond_3

    .line 186
    iget-object v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->words:[Ljava/lang/String;

    iget v1, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->n:I

    mul-int/lit8 v1, v1, 0x2

    invoke-static {v0, v1}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->words:[Ljava/lang/String;

    .line 187
    iget-object v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->freqs:[I

    iget v1, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->n:I

    mul-int/lit8 v1, v1, 0x2

    invoke-static {v0, v1}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->freqs:[I

    .line 189
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->index:Ljava/util/HashMap;

    iget v1, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->n:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 190
    iget-object v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->words:[Ljava/lang/String;

    iget v1, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->n:I

    aput-object p1, v0, v1

    .line 191
    iget-object v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->freqs:[I

    iget v1, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->n:I

    aput p2, v0, v1

    .line 192
    iget v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->n:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->n:I

    goto :goto_0
.end method

.method keepBest(I)V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 197
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->index:Ljava/util/HashMap;

    .line 198
    iget v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->n:I

    if-gt v0, p1, :cond_0

    .line 212
    :goto_0
    return-void

    .line 199
    :cond_0
    const/16 v0, 0x101

    new-array v3, v0, [I

    move v0, v1

    .line 200
    :goto_1
    iget v2, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->n:I

    if-ge v0, v2, :cond_1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->freqs:[I

    aget v2, v2, v0

    invoke-static {v2}, Lcom/mrkeyboard/app/MrGestureWords$Collector;->clamp(I)I

    move-result v2

    aget v4, v3, v2

    add-int/lit8 v4, v4, 0x1

    aput v4, v3, v2

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 201
    :cond_1
    const/16 v0, 0xff

    move v4, v0

    move v0, v1

    .line 202
    :goto_2
    if-lez v4, :cond_2

    aget v2, v3, v4

    add-int/2addr v2, v0

    if-gt v2, p1, :cond_2

    add-int/lit8 v2, v4, -0x1

    aget v4, v3, v4

    add-int/2addr v0, v4

    move v4, v2

    goto :goto_2

    .line 203
    :cond_2
    sub-int v0, p1, v0

    move v2, v0

    move v0, v1

    .line 204
    :goto_3
    iget v3, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->n:I

    if-ge v1, v3, :cond_6

    .line 205
    iget-object v3, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->freqs:[I

    aget v3, v3, v1

    invoke-static {v3}, Lcom/mrkeyboard/app/MrGestureWords$Collector;->clamp(I)I

    move-result v3

    .line 206
    if-lt v3, v4, :cond_3

    if-ne v3, v4, :cond_5

    add-int/lit8 v3, v2, -0x1

    if-gtz v2, :cond_4

    move v2, v3

    .line 204
    :cond_3
    :goto_4
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    :cond_4
    move v2, v3

    .line 207
    :cond_5
    iget-object v3, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->words:[Ljava/lang/String;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->words:[Ljava/lang/String;

    aget-object v5, v5, v1

    aput-object v5, v3, v0

    .line 208
    iget-object v3, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->freqs:[I

    iget-object v5, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->freqs:[I

    aget v5, v5, v1

    aput v5, v3, v0

    .line 209
    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    .line 211
    :cond_6
    iput v0, p0, Lcom/mrkeyboard/app/MrGestureWords$Collector;->n:I

    goto :goto_0
.end method

.method read(Lcom/mrkeyboard/app/ExpandableDictionary$NodeArray;I)V
    .locals 1

    .prologue
    .line 161
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0, p2}, Lcom/mrkeyboard/app/MrGestureWords$Collector;->walk(Lcom/mrkeyboard/app/ExpandableDictionary$NodeArray;II)V

    .line 162
    return-void
.end method
