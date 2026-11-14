.class public final Lcom/mrkeyboard/app/MrPrevWord;
.super Ljava/lang/Object;
.source "MrPrevWord.java"


# static fields
.field private static final SPACES:Ljava/util/regex/Pattern;

.field static final WINDOW:I = 0xf

.field private static sTail:Ljava/lang/String;

.field private static sTyped:Ljava/lang/String;

.field private static sValid:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 34
    const-string v0, "\\s+"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrPrevWord;->SPACES:Ljava/util/regex/Pattern;

    .line 37
    const-string v0, ""

    sput-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sTail:Ljava/lang/String;

    .line 38
    const-string v0, ""

    sput-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sTyped:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static clear()V
    .locals 1

    .prologue
    .line 42
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrPrevWord;->sValid:Z

    .line 43
    return-void
.end method

.method private static endsWith(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 103
    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v2

    .line 104
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    sub-int v3, v1, v2

    .line 105
    if-gez v3, :cond_1

    .line 109
    :cond_0
    :goto_0
    return v0

    :cond_1
    move v1, v0

    .line 106
    :goto_1
    if-ge v1, v2, :cond_2

    .line 107
    add-int v4, v3, v1

    invoke-interface {p0, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v4

    invoke-interface {p1, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v5

    if-ne v4, v5, :cond_0

    .line 106
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 109
    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method static fromWindow(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/CharSequence;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 82
    if-nez p0, :cond_1

    .line 90
    :cond_0
    :goto_0
    return-object v0

    .line 83
    :cond_1
    sget-object v1, Lcom/mrkeyboard/app/MrPrevWord;->SPACES:Ljava/util/regex/Pattern;

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->split(Ljava/lang/CharSequence;)[Ljava/lang/String;

    move-result-object v1

    .line 84
    array-length v2, v1

    .line 85
    const/4 v3, 0x2

    if-lt v2, v3, :cond_0

    add-int/lit8 v3, v2, -0x2

    aget-object v3, v1, v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_0

    .line 86
    add-int/lit8 v2, v2, -0x2

    aget-object v1, v1, v2

    .line 87
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    move-object v0, v1

    .line 88
    goto :goto_0
.end method

.method public static get(Landroid/view/inputmethod/InputConnection;Ljava/lang/String;Ljava/lang/CharSequence;)Ljava/lang/CharSequence;
    .locals 5

    .prologue
    const/4 v2, 0x0

    const/16 v4, 0xf

    const/4 v1, 0x0

    .line 50
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    :cond_0
    move-object v0, v2

    .line 67
    :goto_0
    return-object v0

    .line 51
    :cond_1
    if-nez p2, :cond_3

    move v0, v1

    .line 52
    :goto_1
    sget-boolean v3, Lcom/mrkeyboard/app/MrPrevWord;->sValid:Z

    if-eqz v3, :cond_4

    if-lez v0, :cond_4

    sget-object v3, Lcom/mrkeyboard/app/MrPrevWord;->sTyped:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-lt v0, v3, :cond_4

    sget-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sTyped:Ljava/lang/String;

    invoke-static {p2, v0}, Lcom/mrkeyboard/app/MrPrevWord;->startsWith(Ljava/lang/CharSequence;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 53
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/mrkeyboard/app/MrPrevWord;->sTail:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-interface {p2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 54
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-le v1, v4, :cond_2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0xf

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 55
    :cond_2
    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrPrevWord;->fromWindow(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_0

    .line 51
    :cond_3
    invoke-interface {p2}, Ljava/lang/CharSequence;->length()I

    move-result v0

    goto :goto_1

    .line 57
    :cond_4
    sput-boolean v1, Lcom/mrkeyboard/app/MrPrevWord;->sValid:Z

    .line 59
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V

    .line 61
    const/16 v0, 0xf

    const/4 v1, 0x0

    :try_start_0
    invoke-interface {p0, v0, v1}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 63
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 65
    if-nez v0, :cond_5

    move-object v0, v2

    goto :goto_0

    .line 63
    :catchall_0
    move-exception v0

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 64
    throw v0

    .line 66
    :cond_5
    invoke-static {v0, p2}, Lcom/mrkeyboard/app/MrPrevWord;->remember(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)V

    .line 67
    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrPrevWord;->fromWindow(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_0
.end method

.method private static remember(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)V
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 72
    if-nez p1, :cond_1

    move v0, v1

    .line 73
    :goto_0
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    .line 74
    if-eqz v0, :cond_0

    if-lt v2, v0, :cond_0

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPrevWord;->endsWith(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 78
    :cond_0
    :goto_1
    return-void

    .line 72
    :cond_1
    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v0

    goto :goto_0

    .line 75
    :cond_2
    sub-int v0, v2, v0

    invoke-interface {p0, v1, v0}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sTail:Ljava/lang/String;

    .line 76
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sTyped:Ljava/lang/String;

    .line 77
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrPrevWord;->sValid:Z

    goto :goto_1
.end method

.method private static startsWith(Ljava/lang/CharSequence;Ljava/lang/String;)Z
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 94
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    .line 95
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-ge v1, v2, :cond_1

    .line 99
    :cond_0
    :goto_0
    return v0

    :cond_1
    move v1, v0

    .line 96
    :goto_1
    if-ge v1, v2, :cond_2

    .line 97
    invoke-interface {p0, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    if-ne v3, v4, :cond_0

    .line 96
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 99
    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method
