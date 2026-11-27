.class public final Lcom/mrkeyboard/app/MrDigitStart;
.super Ljava/lang/Object;
.source "MrDigitStart.java"


# static fields
.field static final MAX_HELD:I = 0x3

.field static final WAIT_MS:J = 0x5dcL

.field private static sCodes:[I

.field private static sDigit:C

.field private static sHeld:I

.field private static sWaitUntil:J


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static hold(II)Z
    .locals 8

    .prologue
    const-wide/16 v6, 0x0

    const/4 v0, 0x0

    .line 112
    sget-wide v2, Lcom/mrkeyboard/app/MrDigitStart;->sWaitUntil:J

    cmp-long v1, v2, v6

    if-nez v1, :cond_0

    .line 118
    :goto_0
    return v0

    .line 113
    :cond_0
    if-gez p1, :cond_1

    sget v1, Lcom/mrkeyboard/app/MrDigitStart;->sHeld:I

    const/4 v2, 0x3

    if-ge v1, v2, :cond_1

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    sget-wide v4, Lcom/mrkeyboard/app/MrDigitStart;->sWaitUntil:J

    cmp-long v1, v2, v4

    if-lez v1, :cond_2

    .line 114
    :cond_1
    sput-wide v6, Lcom/mrkeyboard/app/MrDigitStart;->sWaitUntil:J

    goto :goto_0

    .line 117
    :cond_2
    sget v0, Lcom/mrkeyboard/app/MrDigitStart;->sHeld:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrDigitStart;->sHeld:I

    .line 118
    const/4 v0, 0x1

    goto :goto_0
.end method

.method static lone(Ljava/lang/CharSequence;Ljava/lang/CharSequence;C)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 126
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

    .line 131
    :cond_0
    :goto_0
    return v0

    .line 127
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    const/4 v2, 0x2

    if-lt v1, v2, :cond_2

    .line 128
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x2

    invoke-interface {p0, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    .line 129
    invoke-static {v1}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "([{\"\'\u00ab\u00bf\u00a1\u201c\u2018"

    invoke-virtual {v2, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    if-ltz v1, :cond_0

    .line 131
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

    .line 44
    sput-char v2, Lcom/mrkeyboard/app/MrDigitStart;->sDigit:C

    .line 45
    sput-object v3, Lcom/mrkeyboard/app/MrDigitStart;->sCodes:[I

    .line 46
    const-wide/16 v0, 0x0

    sput-wide v0, Lcom/mrkeyboard/app/MrDigitStart;->sWaitUntil:J

    .line 48
    const/16 v0, 0x30

    if-lt p1, v0, :cond_0

    const/16 v0, 0x39

    if-gt p1, v0, :cond_0

    if-eqz p2, :cond_0

    :try_start_0
    array-length v0, p2

    if-nez v0, :cond_1

    .line 59
    :cond_0
    :goto_0
    return-void

    .line 49
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInstance()Lcom/mrkeyboard/app/KeyboardSwitcher;

    move-result-object v0

    .line 50
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->isAlphabetMode()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 51
    invoke-virtual {p2}, [I->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [I

    .line 52
    const/4 v1, 0x0

    aput p1, v0, v1

    .line 53
    int-to-char v1, p1

    sput-char v1, Lcom/mrkeyboard/app/MrDigitStart;->sDigit:C

    .line 54
    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrDigitStart;->withLetterUnder([II)[I

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrDigitStart;->sCodes:[I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 55
    :catch_0
    move-exception v0

    .line 56
    sput-char v2, Lcom/mrkeyboard/app/MrDigitStart;->sDigit:C

    .line 57
    sput-object v3, Lcom/mrkeyboard/app/MrDigitStart;->sCodes:[I

    goto :goto_0
.end method

.method public static take(Lcom/mrkeyboard/app/LatinIME;)[I
    .locals 8

    .prologue
    const/4 v3, 0x0

    const/4 v0, 0x0

    .line 66
    sget-char v2, Lcom/mrkeyboard/app/MrDigitStart;->sDigit:C

    .line 67
    sget-object v1, Lcom/mrkeyboard/app/MrDigitStart;->sCodes:[I

    .line 68
    sput-char v3, Lcom/mrkeyboard/app/MrDigitStart;->sDigit:C

    .line 69
    sput-object v0, Lcom/mrkeyboard/app/MrDigitStart;->sCodes:[I

    .line 70
    if-eqz v2, :cond_0

    if-eqz v1, :cond_0

    if-nez p0, :cond_1

    .line 80
    :cond_0
    :goto_0
    return-object v0

    .line 72
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v3

    .line 73
    if-eqz v3, :cond_0

    .line 74
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

    .line 75
    const/4 v2, 0x1

    const/4 v4, 0x0

    invoke-interface {v3, v2, v4}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 76
    const-wide/16 v2, 0x1

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v4

    const-wide/16 v6, 0x5dc

    add-long/2addr v4, v6

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v2

    sput-wide v2, Lcom/mrkeyboard/app/MrDigitStart;->sWaitUntil:J

    .line 77
    const/4 v2, 0x0

    sput v2, Lcom/mrkeyboard/app/MrDigitStart;->sHeld:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    .line 78
    goto :goto_0

    .line 79
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static withLetterUnder([II)[I
    .locals 3

    .prologue
    .line 90
    int-to-char v0, p1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrFuzzy;->letterUnder(C)C

    move-result v1

    .line 91
    if-eqz v1, :cond_0

    if-nez p0, :cond_1

    .line 103
    :cond_0
    :goto_0
    return-object p0

    .line 92
    :cond_1
    const/4 v0, 0x0

    .line 93
    :goto_1
    array-length v2, p0

    if-ge v0, v2, :cond_2

    aget v2, p0, v0

    if-lez v2, :cond_2

    .line 94
    aget v2, p0, v0

    if-eq v2, v1, :cond_0

    .line 95
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 97
    :cond_2
    array-length v2, p0

    if-ge v0, v2, :cond_3

    .line 98
    aput v1, p0, v0

    goto :goto_0

    .line 101
    :cond_3
    array-length v0, p0

    add-int/lit8 v0, v0, 0x1

    invoke-static {p0, v0}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v0

    .line 102
    array-length v2, p0

    aput v1, v0, v2

    move-object p0, v0

    .line 103
    goto :goto_0
.end method
