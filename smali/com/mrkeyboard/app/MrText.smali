.class public final Lcom/mrkeyboard/app/MrText;
.super Ljava/lang/Object;
.source "MrText.java"


# static fields
.field private static final ALL_LOWER:Ljava/lang/String; = "abcdefghijklmnopqrstuvwxyz\u00e0\u00e1\u00e2\u00e3\u00e9\u00ea\u00ed\u00f3\u00f4\u00f5\u00fa\u00fc\u00e7"

.field private static final VARIANTS_A:Ljava/lang/String; = "\u00e0\u00e1\u00e2\u00e3"

.field private static final VARIANTS_C:Ljava/lang/String; = "\u00e7"

.field private static final VARIANTS_E:Ljava/lang/String; = "\u00e9\u00ea"

.field private static final VARIANTS_I:Ljava/lang/String; = "\u00ed"

.field private static final VARIANTS_O:Ljava/lang/String; = "\u00f3\u00f4\u00f5"

.field private static final VARIANTS_U:Ljava/lang/String; = "\u00fa\u00fc"


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static allInitials([I)I
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 114
    .line 115
    array-length v2, p0

    move v1, v0

    .line 116
    :goto_0
    const-string v3, "abcdefghijklmnopqrstuvwxyz\u00e0\u00e1\u00e2\u00e3\u00e9\u00ea\u00ed\u00f3\u00f4\u00f5\u00fa\u00fc\u00e7"

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v0, v3, :cond_0

    .line 117
    const-string v3, "abcdefghijklmnopqrstuvwxyz\u00e0\u00e1\u00e2\u00e3\u00e9\u00ea\u00ed\u00f3\u00f4\u00f5\u00fa\u00fc\u00e7"

    invoke-virtual {v3, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 118
    invoke-static {p0, v1, v2, v3}, Lcom/mrkeyboard/app/MrText;->put([IIII)I

    move-result v1

    .line 119
    invoke-static {v3}, Ljava/lang/Character;->toUpperCase(C)C

    move-result v3

    invoke-static {p0, v1, v2, v3}, Lcom/mrkeyboard/app/MrText;->put([IIII)I

    move-result v1

    .line 116
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    move v0, v1

    .line 121
    :goto_1
    if-ge v0, v2, :cond_1

    const/4 v3, -0x1

    aput v3, p0, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 122
    :cond_1
    return v1
.end method

.method public static base(I)C
    .locals 1

    .prologue
    .line 15
    int-to-char v0, p0

    .line 16
    packed-switch v0, :pswitch_data_0

    .line 39
    :pswitch_0
    invoke-static {v0}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v0

    :goto_0
    return v0

    .line 19
    :pswitch_1
    const/16 v0, 0x61

    goto :goto_0

    .line 21
    :pswitch_2
    const/16 v0, 0x63

    goto :goto_0

    .line 24
    :pswitch_3
    const/16 v0, 0x65

    goto :goto_0

    .line 27
    :pswitch_4
    const/16 v0, 0x69

    goto :goto_0

    .line 29
    :pswitch_5
    const/16 v0, 0x6e

    goto :goto_0

    .line 32
    :pswitch_6
    const/16 v0, 0x6f

    goto :goto_0

    .line 35
    :pswitch_7
    const/16 v0, 0x75

    goto :goto_0

    .line 37
    :pswitch_8
    const/16 v0, 0x79

    goto :goto_0

    .line 16
    nop

    :pswitch_data_0
    .packed-switch 0xc0
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_2
        :pswitch_3
        :pswitch_3
        :pswitch_3
        :pswitch_3
        :pswitch_4
        :pswitch_4
        :pswitch_4
        :pswitch_4
        :pswitch_0
        :pswitch_5
        :pswitch_6
        :pswitch_6
        :pswitch_6
        :pswitch_6
        :pswitch_6
        :pswitch_0
        :pswitch_0
        :pswitch_7
        :pswitch_7
        :pswitch_7
        :pswitch_7
        :pswitch_8
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_2
        :pswitch_3
        :pswitch_3
        :pswitch_3
        :pswitch_3
        :pswitch_4
        :pswitch_4
        :pswitch_4
        :pswitch_4
        :pswitch_0
        :pswitch_5
        :pswitch_6
        :pswitch_6
        :pswitch_6
        :pswitch_6
        :pswitch_6
        :pswitch_0
        :pswitch_0
        :pswitch_7
        :pswitch_7
        :pswitch_7
        :pswitch_7
        :pswitch_8
        :pswitch_0
        :pswitch_8
    .end packed-switch
.end method

.method public static fillInitials([I[II)I
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 83
    array-length v0, p1

    if-le p2, v0, :cond_0

    array-length p2, p1

    .line 85
    :cond_0
    if-eqz p0, :cond_3

    move v0, v1

    move v2, v1

    .line 86
    :goto_0
    array-length v3, p0

    if-ge v0, v3, :cond_4

    .line 87
    aget v3, p0, v0

    .line 88
    if-gtz v3, :cond_2

    .line 89
    if-nez v0, :cond_4

    .line 86
    :cond_1
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 92
    :cond_2
    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v4

    .line 93
    invoke-static {p1, v2, p2, v3}, Lcom/mrkeyboard/app/MrText;->put([IIII)I

    move-result v2

    .line 94
    int-to-char v5, v3

    invoke-static {v5}, Ljava/lang/Character;->toUpperCase(C)C

    move-result v5

    invoke-static {p1, v2, p2, v5}, Lcom/mrkeyboard/app/MrText;->put([IIII)I

    move-result v2

    .line 95
    int-to-char v3, v3

    invoke-static {v3}, Ljava/lang/Character;->isLetter(C)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 96
    invoke-static {p1, v2, p2, v4}, Lcom/mrkeyboard/app/MrText;->put([IIII)I

    move-result v2

    .line 97
    invoke-static {v4}, Ljava/lang/Character;->toUpperCase(C)C

    move-result v3

    invoke-static {p1, v2, p2, v3}, Lcom/mrkeyboard/app/MrText;->put([IIII)I

    move-result v2

    .line 98
    invoke-static {v4}, Lcom/mrkeyboard/app/MrText;->variantsOf(C)Ljava/lang/String;

    move-result-object v4

    move v3, v2

    move v2, v1

    .line 99
    :goto_2
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v2, v5, :cond_6

    .line 100
    invoke-virtual {v4, v2}, Ljava/lang/String;->charAt(I)C

    move-result v5

    invoke-static {p1, v3, p2, v5}, Lcom/mrkeyboard/app/MrText;->put([IIII)I

    move-result v3

    .line 101
    invoke-virtual {v4, v2}, Ljava/lang/String;->charAt(I)C

    move-result v5

    invoke-static {v5}, Ljava/lang/Character;->toUpperCase(C)C

    move-result v5

    invoke-static {p1, v3, p2, v5}, Lcom/mrkeyboard/app/MrText;->put([IIII)I

    move-result v3

    .line 99
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_3
    move v2, v1

    :cond_4
    move v0, v2

    .line 106
    :goto_3
    if-ge v0, p2, :cond_5

    const/4 v1, -0x1

    aput v1, p1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 107
    :cond_5
    return v2

    :cond_6
    move v2, v3

    goto :goto_1
.end method

.method public static fixNative([C)V
    .locals 3

    .prologue
    .line 131
    if-nez p0, :cond_1

    .line 136
    :cond_0
    return-void

    .line 132
    :cond_1
    const/4 v0, 0x0

    :goto_0
    array-length v1, p0

    if-ge v0, v1, :cond_0

    .line 133
    aget-char v1, p0, v0

    .line 134
    const v2, 0xff80

    if-lt v1, v2, :cond_2

    and-int/lit16 v1, v1, 0xff

    int-to-char v1, v1

    aput-char v1, p0, v0

    .line 132
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method public static lastWord(Ljava/lang/CharSequence;)Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 158
    if-nez p0, :cond_1

    .line 172
    :cond_0
    :goto_0
    return-object v0

    .line 159
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    .line 160
    :goto_1
    if-lez v1, :cond_2

    add-int/lit8 v2, v1, -0x1

    invoke-interface {p0, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v2

    if-eqz v2, :cond_2

    add-int/lit8 v1, v1, -0x1

    goto :goto_1

    .line 161
    :cond_2
    if-eqz v1, :cond_0

    move v2, v1

    .line 163
    :goto_2
    if-lez v2, :cond_4

    .line 164
    add-int/lit8 v3, v2, -0x1

    invoke-interface {p0, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    .line 165
    invoke-static {v3}, Ljava/lang/Character;->isLetter(C)Z

    move-result v4

    if-nez v4, :cond_3

    const/16 v4, 0x27

    if-eq v3, v4, :cond_3

    const/16 v4, 0x2d

    if-ne v3, v4, :cond_4

    :cond_3
    add-int/lit8 v2, v2, -0x1

    .line 167
    goto :goto_2

    .line 168
    :cond_4
    :goto_3
    if-ge v2, v1, :cond_5

    invoke-interface {p0, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/Character;->isLetter(C)Z

    move-result v3

    if-nez v3, :cond_5

    add-int/lit8 v2, v2, 0x1

    goto :goto_3

    .line 169
    :cond_5
    :goto_4
    if-le v1, v2, :cond_6

    add-int/lit8 v3, v1, -0x1

    invoke-interface {p0, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/Character;->isLetter(C)Z

    move-result v3

    if-nez v3, :cond_6

    add-int/lit8 v1, v1, -0x1

    goto :goto_4

    .line 170
    :cond_6
    if-ge v2, v1, :cond_0

    .line 171
    sub-int v3, v1, v2

    const/16 v4, 0x2f

    if-gt v3, v4, :cond_0

    .line 172
    invoke-interface {p0, v2, v1}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static learnable(Ljava/lang/CharSequence;)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 144
    if-nez p0, :cond_1

    .line 150
    :cond_0
    :goto_0
    return v0

    .line 145
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    .line 146
    if-eqz v2, :cond_0

    move v1, v0

    .line 147
    :goto_1
    if-ge v1, v2, :cond_2

    .line 148
    invoke-interface {p0, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v3

    if-nez v3, :cond_0

    .line 147
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 150
    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private static put([IIII)I
    .locals 2

    .prologue
    .line 69
    if-lez p3, :cond_0

    if-lt p1, p2, :cond_1

    .line 74
    :cond_0
    :goto_0
    return p1

    .line 70
    :cond_1
    const/4 v0, 0x0

    :goto_1
    if-ge v0, p1, :cond_2

    .line 71
    aget v1, p0, v0

    if-eq v1, p3, :cond_0

    .line 70
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 73
    :cond_2
    aput p3, p0, p1

    .line 74
    add-int/lit8 p1, p1, 0x1

    goto :goto_0
.end method

.method public static sameInitial(Ljava/lang/CharSequence;I)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 45
    if-eqz p0, :cond_0

    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 46
    :cond_0
    :goto_0
    return v0

    :cond_1
    invoke-interface {p0, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v1

    invoke-static {p1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v2

    if-ne v1, v2, :cond_0

    const/4 v0, 0x1

    goto :goto_0
.end method

.method private static variantsOf(C)Ljava/lang/String;
    .locals 1

    .prologue
    .line 57
    sparse-switch p0, :sswitch_data_0

    .line 64
    const-string v0, ""

    :goto_0
    return-object v0

    .line 58
    :sswitch_0
    const-string v0, "\u00e0\u00e1\u00e2\u00e3"

    goto :goto_0

    .line 59
    :sswitch_1
    const-string v0, "\u00e9\u00ea"

    goto :goto_0

    .line 60
    :sswitch_2
    const-string v0, "\u00ed"

    goto :goto_0

    .line 61
    :sswitch_3
    const-string v0, "\u00f3\u00f4\u00f5"

    goto :goto_0

    .line 62
    :sswitch_4
    const-string v0, "\u00fa\u00fc"

    goto :goto_0

    .line 63
    :sswitch_5
    const-string v0, "\u00e7"

    goto :goto_0

    .line 57
    :sswitch_data_0
    .sparse-switch
        0x61 -> :sswitch_0
        0x63 -> :sswitch_5
        0x65 -> :sswitch_1
        0x69 -> :sswitch_2
        0x6f -> :sswitch_3
        0x75 -> :sswitch_4
    .end sparse-switch
.end method
