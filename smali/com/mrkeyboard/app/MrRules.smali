.class public final Lcom/mrkeyboard/app/MrRules;
.super Ljava/lang/Object;
.source "MrRules.java"


# static fields
.field static final DEFAULT_SILENT:I = 0x2d

.field static final DEFAULT_SILENT_START:I = 0x1e

.field static final EMPTY:Lcom/mrkeyboard/app/MrRules;

.field static final MAX_STARTERS:I = 0x3

.field private static volatile sCurrent:Lcom/mrkeyboard/app/MrRules;


# instance fields
.field final corrections:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field d2c:[C

.field d2p:[C

.field d2t:[C

.field final extra:[Z

.field final oneLetter:[Z

.field final pairs:[B

.field silChar:[C

.field silCost:[S

.field silPrev:[C

.field final silentStart:[S

.field starters:[Ljava/lang/String;

.field t2a:[C

.field t2b:[C

.field t2d:[C


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 30
    new-instance v0, Lcom/mrkeyboard/app/MrRules;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrRules;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrRules;->EMPTY:Lcom/mrkeyboard/app/MrRules;

    .line 31
    sget-object v0, Lcom/mrkeyboard/app/MrRules;->EMPTY:Lcom/mrkeyboard/app/MrRules;

    sput-object v0, Lcom/mrkeyboard/app/MrRules;->sCurrent:Lcom/mrkeyboard/app/MrRules;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    const/16 v2, 0x100

    const/4 v1, 0x0

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    new-array v0, v1, [Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRules;->starters:[Ljava/lang/String;

    .line 43
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRules;->corrections:Ljava/util/HashMap;

    .line 45
    const/high16 v0, 0x10000

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRules;->pairs:[B

    .line 47
    new-array v0, v1, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    new-array v0, v1, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRules;->t2b:[C

    new-array v0, v1, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRules;->t2d:[C

    .line 49
    new-array v0, v1, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    new-array v0, v1, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRules;->d2c:[C

    new-array v0, v1, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    .line 51
    new-array v0, v2, [S

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    .line 53
    new-array v0, v1, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRules;->silPrev:[C

    new-array v0, v1, [C

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRules;->silChar:[C

    .line 54
    new-array v0, v1, [S

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRules;->silCost:[S

    .line 55
    new-array v0, v2, [Z

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRules;->extra:[Z

    .line 56
    new-array v0, v2, [Z

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRules;->oneLetter:[Z

    return-void
.end method

.method public static get()Lcom/mrkeyboard/app/MrRules;
    .locals 1

    .prologue
    .line 35
    sget-object v0, Lcom/mrkeyboard/app/MrRules;->sCurrent:Lcom/mrkeyboard/app/MrRules;

    return-object v0
.end method

.method static parse(Ljava/io/InputStream;)Lcom/mrkeyboard/app/MrRules;
    .locals 15
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 63
    new-instance v3, Ljava/io/BufferedReader;

    new-instance v0, Ljava/io/InputStreamReader;

    const-string v1, "UTF-8"

    invoke-direct {v0, p0, v1}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v3, v0}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 64
    new-instance v4, Lcom/mrkeyboard/app/MrRules;

    invoke-direct {v4}, Lcom/mrkeyboard/app/MrRules;-><init>()V

    .line 65
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    .line 66
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    .line 67
    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9}, Ljava/util/ArrayList;-><init>()V

    .line 68
    const-string v1, ""

    .line 70
    const/4 v0, 0x0

    .line 71
    :cond_0
    :goto_0
    invoke-virtual {v3}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 72
    add-int/lit8 v0, v0, 0x1

    const/16 v10, 0x4e20

    if-le v0, v10, :cond_2

    .line 140
    :cond_1
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/String;

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    iput-object v0, v4, Lcom/mrkeyboard/app/MrRules;->starters:[Ljava/lang/String;

    .line 141
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    div-int/lit8 v1, v0, 0x3

    .line 142
    new-array v0, v1, [C

    iput-object v0, v4, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    new-array v0, v1, [C

    iput-object v0, v4, Lcom/mrkeyboard/app/MrRules;->t2b:[C

    new-array v0, v1, [C

    iput-object v0, v4, Lcom/mrkeyboard/app/MrRules;->t2d:[C

    .line 143
    const/4 v0, 0x0

    :goto_1
    if-ge v0, v1, :cond_11

    .line 144
    iget-object v2, v4, Lcom/mrkeyboard/app/MrRules;->t2a:[C

    mul-int/lit8 v3, v0, 0x3

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->charAt(I)C

    move-result v3

    aput-char v3, v2, v0

    iget-object v2, v4, Lcom/mrkeyboard/app/MrRules;->t2b:[C

    mul-int/lit8 v3, v0, 0x3

    add-int/lit8 v3, v3, 0x1

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->charAt(I)C

    move-result v3

    aput-char v3, v2, v0

    iget-object v2, v4, Lcom/mrkeyboard/app/MrRules;->t2d:[C

    mul-int/lit8 v3, v0, 0x3

    add-int/lit8 v3, v3, 0x2

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->charAt(I)C

    move-result v3

    aput-char v3, v2, v0

    .line 143
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 73
    :cond_2
    const/4 v10, 0x1

    if-ne v0, v10, :cond_3

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v10

    if-lez v10, :cond_3

    const/4 v10, 0x0

    invoke-virtual {v2, v10}, Ljava/lang/String;->charAt(I)C

    move-result v10

    const v11, 0xfeff

    if-ne v10, v11, :cond_3

    const/4 v10, 0x1

    invoke-virtual {v2, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    .line 74
    :cond_3
    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v10

    .line 75
    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v11

    if-eqz v11, :cond_0

    const/4 v11, 0x0

    invoke-virtual {v10, v11}, Ljava/lang/String;->charAt(I)C

    move-result v11

    const/16 v12, 0x23

    if-eq v11, v12, :cond_0

    .line 76
    const/4 v11, 0x0

    invoke-virtual {v10, v11}, Ljava/lang/String;->charAt(I)C

    move-result v11

    const/16 v12, 0x5b

    if-ne v11, v12, :cond_4

    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v11

    add-int/lit8 v11, v11, -0x1

    invoke-virtual {v10, v11}, Ljava/lang/String;->charAt(I)C

    move-result v11

    const/16 v12, 0x5d

    if-ne v11, v12, :cond_4

    .line 77
    const/4 v1, 0x1

    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v10, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    goto/16 :goto_0

    .line 80
    :cond_4
    const-string v11, "sentence_start"

    invoke-virtual {v1, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_5

    .line 81
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v11, 0x3

    if-ge v2, v11, :cond_0

    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v2

    const/16 v11, 0x30

    if-gt v2, v11, :cond_0

    invoke-virtual {v5, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :goto_0

    .line 82
    :cond_5
    const-string v11, "corrections"

    invoke-virtual {v1, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_6

    .line 83
    const/16 v10, 0x9

    invoke-virtual {v2, v10}, Ljava/lang/String;->indexOf(I)I

    move-result v10

    .line 84
    if-lez v10, :cond_0

    .line 85
    const/4 v11, 0x0

    invoke-virtual {v2, v11, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v11

    invoke-static {v11}, Lcom/mrkeyboard/app/MrFix;->key(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v11

    .line 86
    add-int/lit8 v10, v10, 0x1

    invoke-virtual {v2, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    .line 87
    if-eqz v11, :cond_0

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v10

    if-lez v10, :cond_0

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v10

    const/16 v12, 0x30

    if-gt v10, v12, :cond_0

    iget-object v10, v4, Lcom/mrkeyboard/app/MrRules;->corrections:Ljava/util/HashMap;

    invoke-virtual {v10, v11, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_0

    .line 88
    :cond_6
    const-string v2, "phonetic"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_7

    const-string v2, "vowels"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_9

    .line 89
    :cond_7
    const-string v2, "\\s+"

    invoke-virtual {v10, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 90
    array-length v10, v2

    const/4 v11, 0x2

    if-lt v10, v11, :cond_0

    const/4 v10, 0x0

    aget-object v10, v2, v10

    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v10

    const/4 v11, 0x1

    if-ne v10, v11, :cond_0

    const/4 v10, 0x1

    aget-object v10, v2, v10

    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v10

    const/4 v11, 0x1

    if-ne v10, v11, :cond_0

    .line 91
    const/4 v10, 0x0

    aget-object v10, v2, v10

    const/4 v11, 0x0

    invoke-virtual {v10, v11}, Ljava/lang/String;->charAt(I)C

    move-result v10

    invoke-static {v10}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v10

    const/4 v11, 0x1

    aget-object v2, v2, v11

    const/4 v11, 0x0

    invoke-virtual {v2, v11}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v11

    .line 92
    const/16 v2, 0x100

    if-ge v10, v2, :cond_0

    const/16 v2, 0x100

    if-ge v11, v2, :cond_0

    if-eq v10, v11, :cond_0

    .line 93
    const-string v2, "phonetic"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_8

    const/4 v2, 0x1

    .line 94
    :goto_2
    iget-object v12, v4, Lcom/mrkeyboard/app/MrRules;->pairs:[B

    shl-int/lit8 v13, v10, 0x8

    or-int/2addr v13, v11

    aput-byte v2, v12, v13

    .line 95
    iget-object v12, v4, Lcom/mrkeyboard/app/MrRules;->pairs:[B

    shl-int/lit8 v11, v11, 0x8

    or-int/2addr v10, v11

    aput-byte v2, v12, v10

    goto/16 :goto_0

    .line 93
    :cond_8
    const/4 v2, 0x2

    goto :goto_2

    .line 96
    :cond_9
    const-string v2, "groups"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_b

    .line 97
    const/16 v2, 0x3d

    invoke-virtual {v10, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    .line 98
    if-lez v2, :cond_0

    .line 99
    const/4 v11, 0x0

    invoke-virtual {v10, v11, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v11

    add-int/lit8 v2, v2, 0x1

    invoke-virtual {v10, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    .line 100
    invoke-virtual {v11}, Ljava/lang/String;->length()I

    move-result v10

    const/4 v12, 0x2

    if-ne v10, v12, :cond_a

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v10

    const/4 v12, 0x1

    if-ne v10, v12, :cond_a

    .line 101
    const/4 v10, 0x0

    invoke-virtual {v11, v10}, Ljava/lang/String;->charAt(I)C

    move-result v10

    invoke-static {v10}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v10

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v10

    const/4 v12, 0x1

    invoke-virtual {v11, v12}, Ljava/lang/String;->charAt(I)C

    move-result v11

    invoke-static {v11}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v10

    const/4 v11, 0x0

    .line 102
    invoke-virtual {v2, v11}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v2

    invoke-virtual {v10, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto/16 :goto_0

    .line 103
    :cond_a
    invoke-virtual {v11}, Ljava/lang/String;->length()I

    move-result v10

    const/4 v12, 0x1

    if-ne v10, v12, :cond_0

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v10

    const/4 v12, 0x2

    if-ne v10, v12, :cond_0

    .line 104
    const/4 v10, 0x0

    invoke-virtual {v2, v10}, Ljava/lang/String;->charAt(I)C

    move-result v10

    invoke-static {v10}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v10

    invoke-virtual {v7, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v10

    const/4 v12, 0x1

    invoke-virtual {v2, v12}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v2

    invoke-virtual {v10, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    const/4 v10, 0x0

    .line 105
    invoke-virtual {v11, v10}, Ljava/lang/String;->charAt(I)C

    move-result v10

    invoke-static {v10}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v10

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto/16 :goto_0

    .line 107
    :cond_b
    const-string v2, "silent"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_f

    .line 108
    const-string v2, "\\s+"

    invoke-virtual {v10, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v10

    .line 109
    array-length v2, v10

    const/4 v11, 0x2

    if-lt v2, v11, :cond_0

    const/4 v2, 0x0

    aget-object v2, v10, v2

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v11, 0x1

    if-ne v2, v11, :cond_0

    const/4 v2, 0x1

    aget-object v2, v10, v2

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v11, 0x1

    if-ne v2, v11, :cond_0

    .line 110
    const/4 v2, 0x1

    aget-object v2, v10, v2

    const/4 v11, 0x0

    invoke-virtual {v2, v11}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v11

    .line 111
    const/16 v2, 0x100

    if-ge v11, v2, :cond_0

    .line 112
    const/4 v2, 0x0

    aget-object v2, v10, v2

    const-string v12, "^"

    invoke-virtual {v2, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    .line 113
    if-eqz v12, :cond_d

    const/16 v2, 0x1e

    .line 114
    :goto_3
    array-length v13, v10

    const/4 v14, 0x3

    if-lt v13, v14, :cond_c

    .line 116
    const/4 v2, 0x2

    :try_start_0
    aget-object v2, v10, v2

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 120
    const/4 v13, 0x1

    if-lt v2, v13, :cond_0

    const/16 v13, 0xc8

    if-gt v2, v13, :cond_0

    .line 122
    :cond_c
    if-eqz v12, :cond_e

    .line 123
    iget-object v10, v4, Lcom/mrkeyboard/app/MrRules;->silentStart:[S

    int-to-short v2, v2

    aput-short v2, v10, v11

    goto/16 :goto_0

    .line 113
    :cond_d
    const/16 v2, 0x2d

    goto :goto_3

    .line 125
    :cond_e
    const/4 v12, 0x0

    aget-object v10, v10, v12

    const/4 v12, 0x0

    invoke-virtual {v10, v12}, Ljava/lang/String;->charAt(I)C

    move-result v10

    invoke-static {v10}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v10

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 126
    int-to-short v2, v2

    invoke-static {v2}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object v2

    invoke-virtual {v9, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :goto_0

    .line 128
    :cond_f
    const-string v2, "extra"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_10

    .line 129
    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v11, 0x1

    if-ne v2, v11, :cond_0

    .line 130
    const/4 v2, 0x0

    invoke-virtual {v10, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    .line 131
    const/16 v10, 0x100

    if-ge v2, v10, :cond_0

    iget-object v10, v4, Lcom/mrkeyboard/app/MrRules;->extra:[Z

    const/4 v11, 0x1

    aput-boolean v11, v10, v2

    goto/16 :goto_0

    .line 133
    :cond_10
    const-string v2, "one_letter_words"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 134
    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v11, 0x1

    if-ne v2, v11, :cond_0

    .line 135
    const/4 v2, 0x0

    invoke-virtual {v10, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    .line 136
    const/16 v10, 0x100

    if-ge v2, v10, :cond_0

    iget-object v10, v4, Lcom/mrkeyboard/app/MrRules;->oneLetter:[Z

    const/4 v11, 0x1

    aput-boolean v11, v10, v2

    goto/16 :goto_0

    .line 146
    :cond_11
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    div-int/lit8 v1, v0, 0x3

    .line 147
    new-array v0, v1, [C

    iput-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    new-array v0, v1, [C

    iput-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2c:[C

    new-array v0, v1, [C

    iput-object v0, v4, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    .line 148
    const/4 v0, 0x0

    :goto_4
    if-ge v0, v1, :cond_12

    .line 149
    iget-object v2, v4, Lcom/mrkeyboard/app/MrRules;->d2p:[C

    mul-int/lit8 v3, v0, 0x3

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->charAt(I)C

    move-result v3

    aput-char v3, v2, v0

    iget-object v2, v4, Lcom/mrkeyboard/app/MrRules;->d2c:[C

    mul-int/lit8 v3, v0, 0x3

    add-int/lit8 v3, v3, 0x1

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->charAt(I)C

    move-result v3

    aput-char v3, v2, v0

    iget-object v2, v4, Lcom/mrkeyboard/app/MrRules;->d2t:[C

    mul-int/lit8 v3, v0, 0x3

    add-int/lit8 v3, v3, 0x2

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->charAt(I)C

    move-result v3

    aput-char v3, v2, v0

    .line 148
    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    .line 151
    :cond_12
    invoke-virtual {v8}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    div-int/lit8 v2, v0, 0x2

    .line 152
    new-array v0, v2, [C

    iput-object v0, v4, Lcom/mrkeyboard/app/MrRules;->silPrev:[C

    new-array v0, v2, [C

    iput-object v0, v4, Lcom/mrkeyboard/app/MrRules;->silChar:[C

    new-array v0, v2, [S

    iput-object v0, v4, Lcom/mrkeyboard/app/MrRules;->silCost:[S

    .line 153
    const/4 v0, 0x0

    move v1, v0

    :goto_5
    if-ge v1, v2, :cond_13

    .line 154
    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->silPrev:[C

    mul-int/lit8 v3, v1, 0x2

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->charAt(I)C

    move-result v3

    aput-char v3, v0, v1

    iget-object v0, v4, Lcom/mrkeyboard/app/MrRules;->silChar:[C

    mul-int/lit8 v3, v1, 0x2

    add-int/lit8 v3, v3, 0x1

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->charAt(I)C

    move-result v3

    aput-char v3, v0, v1

    iget-object v3, v4, Lcom/mrkeyboard/app/MrRules;->silCost:[S

    invoke-virtual {v9, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Short;

    invoke-virtual {v0}, Ljava/lang/Short;->shortValue()S

    move-result v0

    aput-short v0, v3, v1

    .line 153
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_5

    .line 156
    :cond_13
    return-object v4

    .line 117
    :catch_0
    move-exception v2

    goto/16 :goto_0
.end method

.method static set(Lcom/mrkeyboard/app/MrRules;)V
    .locals 0

    .prologue
    .line 39
    if-eqz p0, :cond_0

    :goto_0
    sput-object p0, Lcom/mrkeyboard/app/MrRules;->sCurrent:Lcom/mrkeyboard/app/MrRules;

    .line 40
    return-void

    .line 39
    :cond_0
    sget-object p0, Lcom/mrkeyboard/app/MrRules;->EMPTY:Lcom/mrkeyboard/app/MrRules;

    goto :goto_0
.end method


# virtual methods
.method isEmpty()Z
    .locals 1

    .prologue
    .line 59
    sget-object v0, Lcom/mrkeyboard/app/MrRules;->EMPTY:Lcom/mrkeyboard/app/MrRules;

    if-ne p0, v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method pair(CC)I
    .locals 2

    .prologue
    const/16 v0, 0x100

    .line 161
    if-ge p1, v0, :cond_0

    if-lt p2, v0, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 162
    :goto_0
    return v0

    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRules;->pairs:[B

    shl-int/lit8 v1, p1, 0x8

    or-int/2addr v1, p2

    aget-byte v0, v0, v1

    goto :goto_0
.end method
