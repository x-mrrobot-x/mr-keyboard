.class final Lcom/mrkeyboard/app/MrJson;
.super Ljava/lang/Object;
.source "MrJson.java"


# static fields
.field private static final MAX_DEPTH:I = 0x20


# instance fields
.field private p:I

.field private final s:Ljava/lang/String;


# direct methods
.method private constructor <init>(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    iput-object p1, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    .line 20
    return-void
.end method

.method private array(I)Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .prologue
    const/16 v3, 0x5d

    .line 103
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 104
    iget v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    .line 105
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->ws()V

    .line 106
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->peek()C

    move-result v1

    if-ne v1, v3, :cond_1

    iget v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    .line 114
    :cond_0
    return-object v0

    .line 108
    :cond_1
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->ws()V

    .line 109
    add-int/lit8 v1, p1, 0x1

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrJson;->value(I)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 110
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->ws()V

    .line 111
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->peek()C

    move-result v1

    .line 112
    iget v2, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    .line 113
    const/16 v2, 0x2c

    if-eq v1, v2, :cond_1

    .line 114
    if-eq v1, v3, :cond_0

    .line 115
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "expected \',\' or \']\'"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method static list(Ljava/lang/Object;)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .prologue
    .line 42
    instance-of v0, p0, Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "expected a list"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 43
    :cond_0
    check-cast p0, Ljava/util/List;

    return-object p0
.end method

.method static num(Ljava/util/Map;Ljava/lang/String;)J
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;",
            "Ljava/lang/String;",
            ")J"
        }
    .end annotation

    .prologue
    .line 58
    invoke-interface {p0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 59
    instance-of v1, v0, Ljava/lang/Long;

    if-nez v1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "field "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " missing or not an integer"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 60
    :cond_0
    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    return-wide v0
.end method

.method private number()Ljava/lang/Object;
    .locals 5

    .prologue
    const/16 v4, 0x2d

    .line 158
    iget v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    .line 159
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->peek()C

    move-result v0

    if-ne v0, v4, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    .line 160
    :cond_0
    const/4 v0, 0x0

    .line 161
    :goto_0
    iget v2, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v2, v3, :cond_3

    .line 162
    iget-object v2, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    iget v3, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    invoke-virtual {v2, v3}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 163
    const/16 v3, 0x30

    if-lt v2, v3, :cond_1

    const/16 v3, 0x39

    if-gt v2, v3, :cond_1

    iget v2, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    goto :goto_0

    .line 164
    :cond_1
    const/16 v3, 0x2e

    if-eq v2, v3, :cond_2

    const/16 v3, 0x65

    if-eq v2, v3, :cond_2

    const/16 v3, 0x45

    if-eq v2, v3, :cond_2

    const/16 v3, 0x2b

    if-eq v2, v3, :cond_2

    if-ne v2, v4, :cond_3

    :cond_2
    const/4 v0, 0x1

    iget v2, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    goto :goto_0

    .line 167
    :cond_3
    iget-object v2, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    iget v3, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    invoke-virtual {v2, v1, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 169
    if-nez v0, :cond_4

    :try_start_0
    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    .line 170
    :goto_1
    return-object v0

    :cond_4
    invoke-static {v1}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_1

    .line 171
    :catch_0
    move-exception v0

    .line 172
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "invalid number: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method static obj(Ljava/lang/Object;)Ljava/util/Map;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            ")",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .prologue
    .line 36
    instance-of v0, p0, Ljava/util/Map;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "expected an object"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 37
    :cond_0
    check-cast p0, Ljava/util/Map;

    return-object p0
.end method

.method private object(I)Ljava/util/Map;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .prologue
    const/16 v4, 0x7d

    .line 80
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 81
    iget v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    .line 82
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->ws()V

    .line 83
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->peek()C

    move-result v1

    if-ne v1, v4, :cond_2

    iget v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    .line 97
    :cond_0
    return-object v0

    .line 90
    :cond_1
    iget v2, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    .line 91
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->ws()V

    .line 92
    add-int/lit8 v2, p1, 0x1

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/MrJson;->value(I)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 93
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->ws()V

    .line 94
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->peek()C

    move-result v1

    .line 95
    iget v2, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    .line 96
    const/16 v2, 0x2c

    if-ne v1, v2, :cond_4

    .line 85
    :cond_2
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->ws()V

    .line 86
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->peek()C

    move-result v1

    const/16 v2, 0x22

    if-eq v1, v2, :cond_3

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "expected a field name"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 87
    :cond_3
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->string()Ljava/lang/String;

    move-result-object v1

    .line 88
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->ws()V

    .line 89
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->peek()C

    move-result v2

    const/16 v3, 0x3a

    if-eq v2, v3, :cond_1

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "expected \':\'"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 97
    :cond_4
    if-eq v1, v4, :cond_0

    .line 98
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "expected \',\' or \'}\'"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method static optStr(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    .line 53
    invoke-interface {p0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 54
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_0

    check-cast v0, Ljava/lang/String;

    :goto_0
    return-object v0

    :cond_0
    move-object v0, p2

    goto :goto_0
.end method

.method static parse(Ljava/lang/String;)Ljava/lang/Object;
    .locals 3

    .prologue
    .line 23
    if-nez p0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 24
    :cond_0
    new-instance v0, Lcom/mrkeyboard/app/MrJson;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrJson;-><init>(Ljava/lang/String;)V

    .line 25
    invoke-direct {v0}, Lcom/mrkeyboard/app/MrJson;->ws()V

    .line 26
    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrJson;->value(I)Ljava/lang/Object;

    move-result-object v1

    .line 27
    invoke-direct {v0}, Lcom/mrkeyboard/app/MrJson;->ws()V

    .line 28
    iget v0, v0, Lcom/mrkeyboard/app/MrJson;->p:I

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-eq v0, v2, :cond_1

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "extra data after the JSON"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 29
    :cond_1
    return-object v1
.end method

.method private peek()C
    .locals 2

    .prologue
    .line 177
    iget v0, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-lt v0, v1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "unexpected end"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 178
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    iget v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    return v0
.end method

.method static str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    .line 47
    invoke-interface {p0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 48
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "field "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " missing or not text"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 49
    :cond_0
    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method private string()Ljava/lang/String;
    .locals 6

    .prologue
    const/16 v5, 0x5c

    const/16 v4, 0x22

    .line 120
    iget v0, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    .line 121
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 123
    :goto_0
    iget v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-lt v1, v2, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "unterminated string"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 124
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    iget v2, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    invoke-virtual {v1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 125
    if-ne v1, v4, :cond_1

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 126
    :cond_1
    if-ne v1, v5, :cond_4

    .line 127
    iget v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-lt v1, v2, :cond_2

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "unterminated escape"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 128
    :cond_2
    iget-object v1, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    iget v2, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    invoke-virtual {v1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 129
    sparse-switch v1, :sswitch_data_0

    .line 148
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid escape"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 130
    :sswitch_0
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 131
    :sswitch_1
    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 132
    :sswitch_2
    const/16 v1, 0x2f

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 133
    :sswitch_3
    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 134
    :sswitch_4
    const/16 v1, 0xc

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 135
    :sswitch_5
    const/16 v1, 0xa

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 136
    :sswitch_6
    const/16 v1, 0xd

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 137
    :sswitch_7
    const/16 v1, 0x9

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 139
    :sswitch_8
    iget v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v1, v1, 0x4

    iget-object v2, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-le v1, v2, :cond_3

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "incomplete \\u"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 141
    :cond_3
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    iget v2, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    iget v3, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v3, v3, 0x4

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x10

    invoke-static {v1, v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;I)I

    move-result v1

    int-to-char v1, v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 145
    iget v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v1, v1, 0x4

    iput v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    goto/16 :goto_0

    .line 142
    :catch_0
    move-exception v0

    .line 143
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid \\u"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 151
    :cond_4
    const/16 v2, 0x20

    if-ge v1, v2, :cond_5

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "control character inside string"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 152
    :cond_5
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto/16 :goto_0

    .line 129
    nop

    :sswitch_data_0
    .sparse-switch
        0x22 -> :sswitch_0
        0x2f -> :sswitch_2
        0x5c -> :sswitch_1
        0x62 -> :sswitch_3
        0x66 -> :sswitch_4
        0x6e -> :sswitch_5
        0x72 -> :sswitch_6
        0x74 -> :sswitch_7
        0x75 -> :sswitch_8
    .end sparse-switch
.end method

.method private value(I)Ljava/lang/Object;
    .locals 4

    .prologue
    .line 66
    const/16 v0, 0x20

    if-le p1, v0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "JSON nested too deep"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 67
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-lt v0, v1, :cond_1

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "unexpected end"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 68
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    iget v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 69
    const/16 v1, 0x7b

    if-ne v0, v1, :cond_2

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrJson;->object(I)Ljava/util/Map;

    move-result-object v0

    .line 75
    :goto_0
    return-object v0

    .line 70
    :cond_2
    const/16 v1, 0x5b

    if-ne v0, v1, :cond_3

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrJson;->array(I)Ljava/util/List;

    move-result-object v0

    goto :goto_0

    .line 71
    :cond_3
    const/16 v1, 0x22

    if-ne v0, v1, :cond_4

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->string()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 72
    :cond_4
    const/16 v1, 0x74

    if-ne v0, v1, :cond_5

    iget-object v1, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    const-string v2, "true"

    iget v3, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;I)Z

    move-result v1

    if-eqz v1, :cond_5

    iget v0, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    goto :goto_0

    .line 73
    :cond_5
    const/16 v1, 0x66

    if-ne v0, v1, :cond_6

    iget-object v1, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    const-string v2, "false"

    iget v3, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;I)Z

    move-result v1

    if-eqz v1, :cond_6

    iget v0, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v0, v0, 0x5

    iput v0, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    goto :goto_0

    .line 74
    :cond_6
    const/16 v1, 0x6e

    if-ne v0, v1, :cond_7

    iget-object v1, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    const-string v2, "null"

    iget v3, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;I)Z

    move-result v1

    if-eqz v1, :cond_7

    iget v0, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v0, v0, 0x4

    iput v0, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    const/4 v0, 0x0

    goto :goto_0

    .line 75
    :cond_7
    const/16 v1, 0x2d

    if-eq v0, v1, :cond_8

    const/16 v1, 0x30

    if-lt v0, v1, :cond_9

    const/16 v1, 0x39

    if-gt v0, v1, :cond_9

    :cond_8
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrJson;->number()Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    .line 76
    :cond_9
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "unexpected character at position "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private ws()V
    .locals 2

    .prologue
    .line 182
    :goto_0
    iget v0, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-ge v0, v1, :cond_1

    .line 183
    iget-object v0, p0, Lcom/mrkeyboard/app/MrJson;->s:Ljava/lang/String;

    iget v1, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 184
    const/16 v1, 0x20

    if-eq v0, v1, :cond_0

    const/16 v1, 0xa

    if-eq v0, v1, :cond_0

    const/16 v1, 0xd

    if-eq v0, v1, :cond_0

    const/16 v1, 0x9

    if-ne v0, v1, :cond_1

    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrJson;->p:I

    goto :goto_0

    .line 187
    :cond_1
    return-void
.end method
