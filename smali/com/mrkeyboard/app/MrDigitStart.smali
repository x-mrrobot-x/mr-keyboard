.class public final Lcom/mrkeyboard/app/MrDigitStart;
.super Ljava/lang/Object;
.source "MrDigitStart.java"


# static fields
.field private static sCodes:[I

.field private static sDigit:C


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static lone(Ljava/lang/CharSequence;Ljava/lang/CharSequence;C)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 73
    if-eqz p0, :cond_0

    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-interface {p0, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    if-eq v1, p2, :cond_1

    .line 78
    :cond_0
    :goto_0
    return v0

    .line 74
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    const/4 v2, 0x2

    if-lt v1, v2, :cond_2

    .line 75
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x2

    invoke-interface {p0, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    .line 76
    invoke-static {v1}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "([{\"\'\u00ab\u00bf\u00a1\u201c\u2018"

    invoke-virtual {v2, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    if-ltz v1, :cond_0

    .line 78
    :cond_2
    if-eqz p1, :cond_3

    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {p1, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    invoke-static {v1}, Ljava/lang/Character;->isLetterOrDigit(C)Z

    move-result v1

    if-nez v1, :cond_0

    :cond_3
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public static sent(Lcom/mrkeyboard/app/LatinIME;I[I)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x0

    .line 31
    sput-char v2, Lcom/mrkeyboard/app/MrDigitStart;->sDigit:C

    .line 32
    sput-object v3, Lcom/mrkeyboard/app/MrDigitStart;->sCodes:[I

    .line 34
    const/16 v0, 0x30

    if-lt p1, v0, :cond_0

    const/16 v0, 0x39

    if-gt p1, v0, :cond_0

    if-eqz p2, :cond_0

    :try_start_0
    array-length v0, p2

    if-nez v0, :cond_1

    .line 45
    :cond_0
    :goto_0
    return-void

    .line 35
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInstance()Lcom/mrkeyboard/app/KeyboardSwitcher;

    move-result-object v0

    .line 36
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->isAlphabetMode()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 37
    invoke-virtual {p2}, [I->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [I

    .line 38
    const/4 v1, 0x0

    aput p1, v0, v1

    .line 39
    int-to-char v1, p1

    sput-char v1, Lcom/mrkeyboard/app/MrDigitStart;->sDigit:C

    .line 40
    sput-object v0, Lcom/mrkeyboard/app/MrDigitStart;->sCodes:[I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 41
    :catch_0
    move-exception v0

    .line 42
    sput-char v2, Lcom/mrkeyboard/app/MrDigitStart;->sDigit:C

    .line 43
    sput-object v3, Lcom/mrkeyboard/app/MrDigitStart;->sCodes:[I

    goto :goto_0
.end method

.method public static take(Lcom/mrkeyboard/app/LatinIME;)[I
    .locals 7

    .prologue
    const/4 v3, 0x0

    const/4 v0, 0x0

    .line 52
    sget-char v2, Lcom/mrkeyboard/app/MrDigitStart;->sDigit:C

    .line 53
    sget-object v1, Lcom/mrkeyboard/app/MrDigitStart;->sCodes:[I

    .line 54
    sput-char v3, Lcom/mrkeyboard/app/MrDigitStart;->sDigit:C

    .line 55
    sput-object v0, Lcom/mrkeyboard/app/MrDigitStart;->sCodes:[I

    .line 56
    if-eqz v2, :cond_0

    if-eqz v1, :cond_0

    if-nez p0, :cond_1

    .line 64
    :cond_0
    :goto_0
    return-object v0

    .line 58
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v3

    .line 59
    if-eqz v3, :cond_0

    .line 60
    const/4 v4, 0x2

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v4

    const/4 v5, 0x1

    const/4 v6, 0x0

    invoke-interface {v3, v5, v6}, Landroid/view/inputmethod/InputConnection;->getTextAfterCursor(II)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-static {v4, v5, v2}, Lcom/mrkeyboard/app/MrDigitStart;->lone(Ljava/lang/CharSequence;Ljava/lang/CharSequence;C)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 61
    const/4 v2, 0x1

    const/4 v4, 0x0

    invoke-interface {v3, v2, v4}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    if-eqz v2, :cond_0

    move-object v0, v1

    .line 62
    goto :goto_0

    .line 63
    :catch_0
    move-exception v1

    goto :goto_0
.end method
