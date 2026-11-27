.class public final Lcom/mrkeyboard/app/MrRecorrect;
.super Ljava/lang/Object;
.source "MrRecorrect.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrRecorrect$Api31;
    }
.end annotation


# static fields
.field static final MAX_WORD:I = 0x30

.field static final NEARBY:I = 0xc

.field static final NO_SNAPSHOT:Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

.field static final REACH:I = 0x3e8


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 37
    new-instance v0, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    invoke-direct {v0}, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrRecorrect;->NO_SNAPSHOT:Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static codesFor(Lcom/mrkeyboard/app/Keyboard;Ljava/util/List;C)[I
    .locals 19
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/mrkeyboard/app/Keyboard;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/Keyboard$Key;",
            ">;C)[I"
        }
    .end annotation

    .prologue
    .line 183
    const/16 v2, 0xc

    new-array v4, v2, [I

    .line 184
    const/4 v2, -0x1

    invoke-static {v4, v2}, Ljava/util/Arrays;->fill([II)V

    .line 185
    const/4 v2, 0x0

    aput p2, v4, v2

    .line 186
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    :cond_0
    move-object v2, v4

    .line 226
    :goto_0
    return-object v2

    .line 188
    :cond_1
    :try_start_0
    invoke-static/range {p1 .. p2}, Lcom/mrkeyboard/app/MrRecorrect;->keyFor(Ljava/util/List;C)Lcom/mrkeyboard/app/Keyboard$Key;

    move-result-object v7

    .line 189
    if-nez v7, :cond_2

    move-object v2, v4

    goto :goto_0

    .line 190
    :cond_2
    iget v2, v7, Lcom/mrkeyboard/app/Keyboard$Key;->x:I

    iget v3, v7, Lcom/mrkeyboard/app/Keyboard$Key;->width:I

    div-int/lit8 v3, v3, 0x2

    add-int v8, v2, v3

    .line 191
    iget v2, v7, Lcom/mrkeyboard/app/Keyboard$Key;->y:I

    iget v3, v7, Lcom/mrkeyboard/app/Keyboard$Key;->height:I

    div-int/lit8 v3, v3, 0x2

    add-int v9, v2, v3

    .line 192
    move-object/from16 v0, p0

    invoke-virtual {v0, v8, v9}, Lcom/mrkeyboard/app/Keyboard;->getNearestKeys(II)[I

    move-result-object v10

    .line 193
    if-nez v10, :cond_3

    move-object v2, v4

    goto :goto_0

    .line 194
    :cond_3
    const v2, 0x3fb33333    # 1.4f

    iget v3, v7, Lcom/mrkeyboard/app/Keyboard$Key;->width:I

    int-to-float v3, v3

    mul-float/2addr v2, v3

    float-to-int v2, v2

    .line 195
    mul-int v11, v2, v2

    .line 196
    const/16 v2, 0xc

    new-array v12, v2, [I

    .line 197
    const/4 v3, 0x1

    .line 198
    invoke-static/range {p2 .. p2}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v13

    .line 199
    array-length v14, v10

    const/4 v2, 0x0

    move v6, v2

    :goto_1
    if-ge v6, v14, :cond_e

    aget v2, v10, v6

    .line 200
    if-ltz v2, :cond_f

    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v5

    if-lt v2, v5, :cond_4

    move v2, v3

    .line 199
    :goto_2
    add-int/lit8 v3, v6, 0x1

    move v6, v3

    move v3, v2

    goto :goto_1

    .line 201
    :cond_4
    move-object/from16 v0, p1

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/Keyboard$Key;

    .line 202
    if-eq v2, v7, :cond_f

    iget-object v5, v2, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    if-eqz v5, :cond_f

    iget-object v5, v2, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    array-length v5, v5

    if-nez v5, :cond_5

    move v2, v3

    goto :goto_2

    .line 203
    :cond_5
    iget-object v5, v2, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    const/4 v15, 0x0

    aget v15, v5, v15

    .line 204
    const/16 v5, 0x20

    if-le v15, v5, :cond_f

    invoke-static {v15}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v5

    if-ne v5, v13, :cond_6

    move v2, v3

    goto :goto_2

    .line 205
    :cond_6
    invoke-virtual {v2, v8, v9}, Lcom/mrkeyboard/app/Keyboard$Key;->squaredDistanceFrom(II)I

    move-result v16

    .line 206
    move/from16 v0, v16

    if-le v0, v11, :cond_7

    move v2, v3

    goto :goto_2

    .line 207
    :cond_7
    const/4 v2, 0x0

    .line 208
    const/4 v5, 0x1

    :goto_3
    if-ge v5, v3, :cond_8

    .line 209
    aget v17, v4, v5

    invoke-static/range {v17 .. v17}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v17

    invoke-static {v15}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v18

    move/from16 v0, v17

    move/from16 v1, v18

    if-ne v0, v1, :cond_9

    const/4 v2, 0x1

    .line 211
    :cond_8
    if-eqz v2, :cond_a

    move v2, v3

    goto :goto_2

    .line 208
    :cond_9
    add-int/lit8 v5, v5, 0x1

    goto :goto_3

    .line 212
    :cond_a
    const/16 v2, 0xc

    if-ge v3, v2, :cond_b

    move v2, v3

    .line 213
    :goto_4
    const/16 v5, 0xc

    if-lt v3, v5, :cond_c

    aget v5, v12, v2

    move/from16 v0, v16

    if-gt v5, v0, :cond_c

    move v2, v3

    goto :goto_2

    .line 212
    :cond_b
    const/16 v2, 0xb

    goto :goto_4

    .line 214
    :cond_c
    :goto_5
    const/4 v5, 0x1

    if-le v2, v5, :cond_d

    add-int/lit8 v5, v2, -0x1

    aget v5, v12, v5

    move/from16 v0, v16

    if-le v5, v0, :cond_d

    .line 215
    add-int/lit8 v5, v2, -0x1

    aget v5, v4, v5

    aput v5, v4, v2

    .line 216
    add-int/lit8 v5, v2, -0x1

    aget v5, v12, v5

    aput v5, v12, v2

    .line 217
    add-int/lit8 v2, v2, -0x1

    goto :goto_5

    .line 219
    :cond_d
    aput v15, v4, v2

    .line 220
    aput v16, v12, v2
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 221
    const/16 v2, 0xc

    if-ge v3, v2, :cond_f

    add-int/lit8 v2, v3, 0x1

    goto/16 :goto_2

    .line 223
    :catch_0
    move-exception v2

    :cond_e
    move-object v2, v4

    .line 226
    goto/16 :goto_0

    :cond_f
    move v2, v3

    goto/16 :goto_2
.end method

.method static composer(Lcom/mrkeyboard/app/KeyboardSwitcher;Ljava/lang/CharSequence;)Lcom/mrkeyboard/app/WordComposer;
    .locals 7

    .prologue
    const/4 v3, 0x0

    const/4 v0, 0x0

    .line 162
    new-instance v4, Lcom/mrkeyboard/app/WordComposer;

    invoke-direct {v4}, Lcom/mrkeyboard/app/WordComposer;-><init>()V

    .line 166
    if-eqz p0, :cond_1

    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInputView()Lcom/mrkeyboard/app/LatinKeyboardView;

    move-result-object v1

    .line 167
    :goto_0
    if-eqz v1, :cond_2

    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinKeyboardView;->getKeyboard()Lcom/mrkeyboard/app/Keyboard;

    move-result-object v1

    .line 168
    :goto_1
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/mrkeyboard/app/Keyboard;->getKeys()Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :cond_0
    :goto_2
    move v2, v3

    .line 173
    :goto_3
    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v5

    if-ge v2, v5, :cond_3

    .line 174
    invoke-interface {p1, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v5

    .line 175
    invoke-static {v1, v0, v5}, Lcom/mrkeyboard/app/MrRecorrect;->codesFor(Lcom/mrkeyboard/app/Keyboard;Ljava/util/List;C)[I

    move-result-object v6

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/WordComposer;->add(I[I)V

    .line 173
    add-int/lit8 v2, v2, 0x1

    goto :goto_3

    :cond_1
    move-object v1, v0

    .line 166
    goto :goto_0

    :cond_2
    move-object v1, v0

    .line 167
    goto :goto_1

    .line 169
    :catch_0
    move-exception v1

    move-object v1, v0

    .line 171
    goto :goto_2

    .line 177
    :cond_3
    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-lez v0, :cond_4

    invoke-interface {p1, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    if-eqz v0, :cond_4

    const/4 v3, 0x1

    :cond_4
    invoke-virtual {v4, v3}, Lcom/mrkeyboard/app/WordComposer;->setFirstCharCapitalized(Z)V

    .line 178
    return-object v4
.end method

.method static eligible(Ljava/lang/CharSequence;)Z
    .locals 8

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 45
    if-nez p0, :cond_1

    .line 56
    :cond_0
    :goto_0
    return v3

    .line 46
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v5

    .line 47
    const/4 v0, 0x2

    if-lt v5, v0, :cond_0

    const/16 v0, 0x30

    if-gt v5, v0, :cond_0

    move v4, v3

    move v0, v3

    move v1, v3

    .line 50
    :goto_1
    if-ge v4, v5, :cond_4

    .line 51
    invoke-interface {p0, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v6

    .line 52
    invoke-static {v6}, Ljava/lang/Character;->isDigit(C)Z

    move-result v7

    if-eqz v7, :cond_3

    add-int/lit8 v0, v0, 0x1

    .line 50
    :cond_2
    :goto_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 53
    :cond_3
    invoke-static {v6}, Ljava/lang/Character;->isLetter(C)Z

    move-result v6

    if-eqz v6, :cond_2

    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 55
    :cond_4
    if-nez v0, :cond_6

    if-lez v1, :cond_5

    move v0, v2

    :goto_3
    move v3, v0

    goto :goto_0

    :cond_5
    move v0, v3

    goto :goto_3

    .line 56
    :cond_6
    if-ne v0, v2, :cond_7

    const/4 v0, 0x4

    if-lt v5, v0, :cond_7

    add-int/lit8 v0, v5, -0x1

    if-ne v1, v0, :cond_7

    :goto_4
    move v3, v2

    goto :goto_0

    :cond_7
    move v2, v3

    goto :goto_4
.end method

.method static fromSnapshot(Ljava/lang/CharSequence;IIIIILjava/lang/String;)Lcom/mrkeyboard/app/EditingUtil$SelectedWord;
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 99
    if-nez p0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrRecorrect;->NO_SNAPSHOT:Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    .line 127
    :goto_0
    return-object v0

    .line 100
    :cond_0
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v5

    .line 101
    if-le p1, p2, :cond_e

    move v0, p1

    move v1, p2

    .line 102
    :goto_1
    if-ltz v1, :cond_1

    if-le v0, v5, :cond_2

    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrRecorrect;->NO_SNAPSHOT:Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    goto :goto_0

    .line 103
    :cond_2
    if-ltz p3, :cond_3

    move v4, p3

    .line 104
    :goto_2
    if-gez v4, :cond_4

    sget-object v0, Lcom/mrkeyboard/app/MrRecorrect;->NO_SNAPSHOT:Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    goto :goto_0

    .line 103
    :cond_3
    invoke-static {p4, p5}, Ljava/lang/Math;->min(II)I

    move-result v3

    sub-int/2addr v3, v1

    move v4, v3

    goto :goto_2

    .line 106
    :cond_4
    if-ne v1, v0, :cond_7

    .line 108
    :goto_3
    if-lez v1, :cond_5

    add-int/lit8 v3, v1, -0x1

    invoke-interface {p0, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    invoke-static {v3, p6}, Lcom/mrkeyboard/app/MrRecorrect;->isSeparator(CLjava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_5

    add-int/lit8 v1, v1, -0x1

    goto :goto_3

    .line 110
    :cond_5
    :goto_4
    if-ge v0, v5, :cond_6

    invoke-interface {p0, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    invoke-static {v3, p6}, Lcom/mrkeyboard/app/MrRecorrect;->isSeparator(CLjava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_6

    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    .line 111
    :cond_6
    if-ne v1, v0, :cond_d

    move-object v0, v2

    goto :goto_0

    .line 115
    :cond_7
    if-nez v1, :cond_9

    if-lez p3, :cond_a

    :cond_8
    move-object v0, v2

    goto :goto_0

    :cond_9
    add-int/lit8 v3, v1, -0x1

    invoke-interface {p0, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    invoke-static {v3, p6}, Lcom/mrkeyboard/app/MrRecorrect;->isSeparator(CLjava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_8

    .line 116
    :cond_a
    if-ge v0, v5, :cond_b

    invoke-interface {p0, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    invoke-static {v3, p6}, Lcom/mrkeyboard/app/MrRecorrect;->isSeparator(CLjava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_b

    move-object v0, v2

    goto :goto_0

    :cond_b
    move v3, v1

    .line 117
    :goto_5
    if-ge v3, v0, :cond_d

    .line 118
    invoke-interface {p0, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v5

    invoke-static {v5, p6}, Lcom/mrkeyboard/app/MrRecorrect;->isSeparator(CLjava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_c

    move-object v0, v2

    goto :goto_0

    .line 117
    :cond_c
    add-int/lit8 v3, v3, 0x1

    goto :goto_5

    .line 123
    :cond_d
    new-instance v2, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    invoke-direct {v2}, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;-><init>()V

    .line 124
    invoke-interface {p0, v1, v0}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v3

    invoke-interface {v3}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;->word:Ljava/lang/CharSequence;

    .line 125
    add-int/2addr v1, v4

    iput v1, v2, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;->start:I

    .line 126
    add-int/2addr v0, v4

    iput v0, v2, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;->end:I

    move-object v0, v2

    .line 127
    goto/16 :goto_0

    :cond_e
    move v0, p2

    move v1, p1

    goto/16 :goto_1
.end method

.method private static isSeparator(CLjava/lang/String;)Z
    .locals 1

    .prologue
    .line 131
    invoke-virtual {p1, p0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static isValid(Lcom/mrkeyboard/app/Suggest;Ljava/lang/CharSequence;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 142
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 147
    :cond_0
    :goto_0
    return v0

    .line 144
    :cond_1
    :try_start_0
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    .line 145
    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/Suggest;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_2

    invoke-virtual {v1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/Suggest;->isValidWord(Ljava/lang/CharSequence;)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    if-eqz v1, :cond_0

    :cond_2
    const/4 v0, 0x1

    goto :goto_0

    .line 146
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private static keyFor(Ljava/util/List;C)Lcom/mrkeyboard/app/Keyboard$Key;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/Keyboard$Key;",
            ">;C)",
            "Lcom/mrkeyboard/app/Keyboard$Key;"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 231
    invoke-static {p1}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v3

    .line 232
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v4

    move v1, v2

    :goto_0
    if-ge v1, v4, :cond_3

    .line 233
    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/Keyboard$Key;

    .line 234
    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    if-eqz v5, :cond_0

    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    array-length v5, v5

    if-eqz v5, :cond_0

    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    aget v5, v5, v2

    const/16 v6, 0x20

    if-gt v5, v6, :cond_1

    .line 232
    :cond_0
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 235
    :cond_1
    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    aget v5, v5, v2

    if-eq v5, p1, :cond_2

    iget-object v5, v0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    aget v5, v5, v2

    invoke-static {v5}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v5

    if-ne v5, v3, :cond_0

    .line 237
    :cond_2
    :goto_1
    return-object v0

    :cond_3
    const/4 v0, 0x0

    goto :goto_1
.end method

.method static wordAt(Landroid/view/inputmethod/InputConnection;IILjava/lang/String;)Lcom/mrkeyboard/app/EditingUtil$SelectedWord;
    .locals 2

    .prologue
    .line 64
    if-eqz p0, :cond_0

    if-nez p3, :cond_2

    :cond_0
    const/4 v0, 0x0

    .line 69
    :cond_1
    :goto_0
    return-object v0

    .line 65
    :cond_2
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1f

    if-lt v0, v1, :cond_3

    .line 66
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrRecorrect$Api31;->wordAt(Landroid/view/inputmethod/InputConnection;IILjava/lang/String;)Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    move-result-object v0

    .line 67
    sget-object v1, Lcom/mrkeyboard/app/MrRecorrect;->NO_SNAPSHOT:Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    if-ne v0, v1, :cond_1

    .line 69
    :cond_3
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/EditingUtil;->getWordAtCursorOrSelection(Landroid/view/inputmethod/InputConnection;IILjava/lang/String;)Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    move-result-object v0

    goto :goto_0
.end method
