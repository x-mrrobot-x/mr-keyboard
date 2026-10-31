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

.field static final NO_SNAPSHOT:Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

.field static final REACH:I = 0x3e8


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 30
    new-instance v0, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    invoke-direct {v0}, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrRecorrect;->NO_SNAPSHOT:Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static eligible(Ljava/lang/CharSequence;)Z
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 37
    if-nez p0, :cond_1

    move v0, v1

    .line 46
    :cond_0
    :goto_0
    return v0

    .line 38
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v3

    .line 39
    const/4 v0, 0x2

    if-lt v3, v0, :cond_2

    const/16 v0, 0x30

    if-le v3, v0, :cond_3

    :cond_2
    move v0, v1

    goto :goto_0

    :cond_3
    move v2, v1

    move v0, v1

    .line 41
    :goto_1
    if-ge v2, v3, :cond_0

    .line 42
    invoke-interface {p0, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v4

    .line 43
    invoke-static {v4}, Ljava/lang/Character;->isDigit(C)Z

    move-result v5

    if-eqz v5, :cond_4

    move v0, v1

    goto :goto_0

    .line 44
    :cond_4
    invoke-static {v4}, Ljava/lang/Character;->isLetter(C)Z

    move-result v4

    if-eqz v4, :cond_5

    const/4 v0, 0x1

    .line 41
    :cond_5
    add-int/lit8 v2, v2, 0x1

    goto :goto_1
.end method

.method static fromSnapshot(Ljava/lang/CharSequence;IIIIILjava/lang/String;)Lcom/mrkeyboard/app/EditingUtil$SelectedWord;
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 86
    if-nez p0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrRecorrect;->NO_SNAPSHOT:Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    .line 114
    :goto_0
    return-object v0

    .line 87
    :cond_0
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v5

    .line 88
    if-le p1, p2, :cond_e

    move v0, p1

    move v1, p2

    .line 89
    :goto_1
    if-ltz v1, :cond_1

    if-le v0, v5, :cond_2

    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrRecorrect;->NO_SNAPSHOT:Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    goto :goto_0

    .line 90
    :cond_2
    if-ltz p3, :cond_3

    move v4, p3

    .line 91
    :goto_2
    if-gez v4, :cond_4

    sget-object v0, Lcom/mrkeyboard/app/MrRecorrect;->NO_SNAPSHOT:Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    goto :goto_0

    .line 90
    :cond_3
    invoke-static {p4, p5}, Ljava/lang/Math;->min(II)I

    move-result v3

    sub-int/2addr v3, v1

    move v4, v3

    goto :goto_2

    .line 93
    :cond_4
    if-ne v1, v0, :cond_7

    .line 95
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

    .line 97
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

    .line 98
    :cond_6
    if-ne v1, v0, :cond_d

    move-object v0, v2

    goto :goto_0

    .line 102
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

    .line 103
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

    .line 104
    :goto_5
    if-ge v3, v0, :cond_d

    .line 105
    invoke-interface {p0, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v5

    invoke-static {v5, p6}, Lcom/mrkeyboard/app/MrRecorrect;->isSeparator(CLjava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_c

    move-object v0, v2

    goto :goto_0

    .line 104
    :cond_c
    add-int/lit8 v3, v3, 0x1

    goto :goto_5

    .line 110
    :cond_d
    new-instance v2, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    invoke-direct {v2}, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;-><init>()V

    .line 111
    invoke-interface {p0, v1, v0}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v3

    invoke-interface {v3}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;->word:Ljava/lang/CharSequence;

    .line 112
    add-int/2addr v1, v4

    iput v1, v2, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;->start:I

    .line 113
    add-int/2addr v0, v4

    iput v0, v2, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;->end:I

    move-object v0, v2

    .line 114
    goto/16 :goto_0

    :cond_e
    move v0, p2

    move v1, p1

    goto/16 :goto_1
.end method

.method private static isSeparator(CLjava/lang/String;)Z
    .locals 1

    .prologue
    .line 118
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

.method static wordAt(Landroid/view/inputmethod/InputConnection;IILjava/lang/String;)Lcom/mrkeyboard/app/EditingUtil$SelectedWord;
    .locals 2

    .prologue
    .line 54
    if-eqz p0, :cond_0

    if-nez p3, :cond_2

    :cond_0
    const/4 v0, 0x0

    .line 59
    :cond_1
    :goto_0
    return-object v0

    .line 55
    :cond_2
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1f

    if-lt v0, v1, :cond_3

    .line 56
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrRecorrect$Api31;->wordAt(Landroid/view/inputmethod/InputConnection;IILjava/lang/String;)Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    move-result-object v0

    .line 57
    sget-object v1, Lcom/mrkeyboard/app/MrRecorrect;->NO_SNAPSHOT:Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    if-ne v0, v1, :cond_1

    .line 59
    :cond_3
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/EditingUtil;->getWordAtCursorOrSelection(Landroid/view/inputmethod/InputConnection;IILjava/lang/String;)Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    move-result-object v0

    goto :goto_0
.end method
