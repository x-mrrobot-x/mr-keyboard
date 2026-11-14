.class public final Lcom/mrkeyboard/app/MrPrevWord;
.super Ljava/lang/Object;
.source "MrPrevWord.java"


# static fields
.field private static final SPACES:Ljava/util/regex/Pattern;

.field static final WINDOW:I = 0xf

.field private static sComplete:Z

.field private static sHeld:Z

.field private static sHeldComplete:Z

.field private static sHeldTail:Ljava/lang/String;

.field private static sTail:Ljava/lang/String;

.field private static sTyped:Ljava/lang/String;

.field private static sValid:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 43
    const-string v0, "\\s+"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrPrevWord;->SPACES:Ljava/util/regex/Pattern;

    .line 46
    const-string v0, ""

    sput-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sTail:Ljava/lang/String;

    .line 47
    const-string v0, ""

    sput-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sTyped:Ljava/lang/String;

    .line 53
    const-string v0, ""

    sput-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sHeldTail:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static ask(Landroid/view/inputmethod/InputConnection;)Ljava/lang/CharSequence;
    .locals 2

    .prologue
    .line 130
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V

    .line 132
    const/16 v0, 0xf

    const/4 v1, 0x0

    :try_start_0
    invoke-interface {p0, v0, v1}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 134
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 132
    return-object v0

    .line 134
    :catchall_0
    move-exception v0

    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 135
    throw v0
.end method

.method public static clear()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 58
    sput-boolean v1, Lcom/mrkeyboard/app/MrPrevWord;->sValid:Z

    .line 59
    const-string v0, ""

    sput-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sTail:Ljava/lang/String;

    .line 60
    const-string v0, ""

    sput-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sTyped:Ljava/lang/String;

    .line 61
    sput-boolean v1, Lcom/mrkeyboard/app/MrPrevWord;->sComplete:Z

    .line 62
    return-void
.end method

.method public static endsPlain(Ljava/lang/CharSequence;)Z
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 124
    if-nez p0, :cond_1

    move v1, v0

    .line 125
    :goto_0
    if-lez v1, :cond_0

    add-int/lit8 v1, v1, -0x1

    invoke-interface {p0, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v1

    invoke-static {v1}, Ljava/lang/Character;->isWhitespace(C)Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0

    .line 124
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    goto :goto_0
.end method

.method private static endsWith(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 191
    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v2

    .line 192
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    sub-int v3, v1, v2

    .line 193
    if-gez v3, :cond_1

    .line 197
    :cond_0
    :goto_0
    return v0

    :cond_1
    move v1, v0

    .line 194
    :goto_1
    if-ge v1, v2, :cond_2

    .line 195
    add-int v4, v3, v1

    invoke-interface {p0, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v4

    invoke-interface {p1, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v5

    if-ne v4, v5, :cond_0

    .line 194
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 197
    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method static fromWindow(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/CharSequence;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 170
    if-nez p0, :cond_1

    .line 178
    :cond_0
    :goto_0
    return-object v0

    .line 171
    :cond_1
    sget-object v1, Lcom/mrkeyboard/app/MrPrevWord;->SPACES:Ljava/util/regex/Pattern;

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->split(Ljava/lang/CharSequence;)[Ljava/lang/String;

    move-result-object v1

    .line 172
    array-length v2, v1

    .line 173
    const/4 v3, 0x2

    if-lt v2, v3, :cond_0

    add-int/lit8 v3, v2, -0x2

    aget-object v3, v1, v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_0

    .line 174
    add-int/lit8 v2, v2, -0x2

    aget-object v1, v1, v2

    .line 175
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

    .line 176
    goto :goto_0
.end method

.method public static get(Landroid/view/inputmethod/InputConnection;Ljava/lang/String;Ljava/lang/CharSequence;)Ljava/lang/CharSequence;
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 143
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    :cond_0
    move-object v0, v1

    .line 154
    :goto_0
    return-object v0

    .line 144
    :cond_1
    if-nez p2, :cond_3

    const/4 v0, 0x0

    .line 145
    :goto_1
    sget-boolean v2, Lcom/mrkeyboard/app/MrPrevWord;->sValid:Z

    if-eqz v2, :cond_4

    if-lez v0, :cond_4

    sget-object v2, Lcom/mrkeyboard/app/MrPrevWord;->sTyped:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-lt v0, v2, :cond_4

    sget-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sTyped:Ljava/lang/String;

    invoke-static {p2, v0}, Lcom/mrkeyboard/app/MrPrevWord;->startsWith(Ljava/lang/CharSequence;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 146
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

    .line 147
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/16 v2, 0xf

    if-le v1, v2, :cond_2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0xf

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 148
    :cond_2
    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrPrevWord;->fromWindow(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_0

    .line 144
    :cond_3
    invoke-interface {p2}, Ljava/lang/CharSequence;->length()I

    move-result v0

    goto :goto_1

    .line 150
    :cond_4
    invoke-static {}, Lcom/mrkeyboard/app/MrPrevWord;->clear()V

    .line 151
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPrevWord;->ask(Landroid/view/inputmethod/InputConnection;)Ljava/lang/CharSequence;

    move-result-object v0

    .line 152
    if-nez v0, :cond_5

    move-object v0, v1

    goto :goto_0

    .line 153
    :cond_5
    invoke-static {v0, p2}, Lcom/mrkeyboard/app/MrPrevWord;->remember(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)V

    .line 154
    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrPrevWord;->fromWindow(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_0
.end method

.method public static hold(Ljava/lang/CharSequence;)V
    .locals 2

    .prologue
    .line 83
    invoke-static {}, Lcom/mrkeyboard/app/MrPrevWord;->release()V

    .line 84
    if-nez p0, :cond_1

    const/4 v0, 0x0

    .line 85
    :goto_0
    sget-boolean v1, Lcom/mrkeyboard/app/MrPrevWord;->sValid:Z

    if-eqz v1, :cond_0

    if-lez v0, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrPrevWord;->sTyped:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-lt v0, v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sTyped:Ljava/lang/String;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPrevWord;->startsWith(Ljava/lang/CharSequence;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 86
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrPrevWord;->sHeld:Z

    .line 87
    sget-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sTail:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sHeldTail:Ljava/lang/String;

    .line 88
    sget-boolean v0, Lcom/mrkeyboard/app/MrPrevWord;->sComplete:Z

    sput-boolean v0, Lcom/mrkeyboard/app/MrPrevWord;->sHeldComplete:Z

    .line 90
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrPrevWord;->clear()V

    .line 91
    return-void

    .line 84
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    goto :goto_0
.end method

.method public static previousForLearning(Landroid/view/inputmethod/InputConnection;Ljava/lang/String;I)Ljava/lang/CharSequence;
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 101
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    :cond_0
    move-object v0, v1

    .line 114
    :goto_0
    return-object v0

    .line 102
    :cond_1
    sget-boolean v0, Lcom/mrkeyboard/app/MrPrevWord;->sHeld:Z

    if-eqz v0, :cond_5

    if-lez p2, :cond_5

    .line 103
    const/16 v0, 0xf

    invoke-static {p2, v0}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 104
    rsub-int/lit8 v3, v2, 0xf

    .line 105
    sget-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sHeldTail:Ljava/lang/String;

    .line 106
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v4, v3, :cond_2

    sget-boolean v4, Lcom/mrkeyboard/app/MrPrevWord;->sHeldComplete:Z

    if-eqz v4, :cond_5

    .line 107
    :cond_2
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lt v3, v1, :cond_3

    .line 108
    :goto_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 109
    const/4 v0, 0x0

    :goto_2
    if-ge v0, v2, :cond_4

    const/16 v3, 0x78

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 107
    :cond_3
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    sub-int/2addr v1, v3

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 110
    :cond_4
    invoke-static {v1, p1}, Lcom/mrkeyboard/app/MrPrevWord;->fromWindow(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_0

    .line 113
    :cond_5
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPrevWord;->ask(Landroid/view/inputmethod/InputConnection;)Ljava/lang/CharSequence;

    move-result-object v0

    .line 114
    if-nez v0, :cond_6

    move-object v0, v1

    goto :goto_0

    :cond_6
    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrPrevWord;->fromWindow(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    goto :goto_0
.end method

.method public static release()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 72
    sput-boolean v1, Lcom/mrkeyboard/app/MrPrevWord;->sHeld:Z

    .line 73
    const-string v0, ""

    sput-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sHeldTail:Ljava/lang/String;

    .line 74
    sput-boolean v1, Lcom/mrkeyboard/app/MrPrevWord;->sHeldComplete:Z

    .line 75
    return-void
.end method

.method private static remember(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)V
    .locals 5

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 159
    if-nez p1, :cond_1

    move v0, v1

    .line 160
    :goto_0
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v3

    .line 161
    if-eqz v0, :cond_0

    if-lt v3, v0, :cond_0

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPrevWord;->endsWith(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 166
    :cond_0
    :goto_1
    return-void

    .line 159
    :cond_1
    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v0

    goto :goto_0

    .line 162
    :cond_2
    sub-int v0, v3, v0

    invoke-interface {p0, v1, v0}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sTail:Ljava/lang/String;

    .line 163
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sTyped:Ljava/lang/String;

    .line 164
    const/16 v0, 0xf

    if-ge v3, v0, :cond_3

    move v1, v2

    :cond_3
    sput-boolean v1, Lcom/mrkeyboard/app/MrPrevWord;->sComplete:Z

    .line 165
    sput-boolean v2, Lcom/mrkeyboard/app/MrPrevWord;->sValid:Z

    goto :goto_1
.end method

.method public static reset()V
    .locals 0

    .prologue
    .line 66
    invoke-static {}, Lcom/mrkeyboard/app/MrPrevWord;->clear()V

    .line 67
    invoke-static {}, Lcom/mrkeyboard/app/MrPrevWord;->release()V

    .line 68
    return-void
.end method

.method private static startsWith(Ljava/lang/CharSequence;Ljava/lang/String;)Z
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 182
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    .line 183
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-ge v1, v2, :cond_1

    .line 187
    :cond_0
    :goto_0
    return v0

    :cond_1
    move v1, v0

    .line 184
    :goto_1
    if-ge v1, v2, :cond_2

    .line 185
    invoke-interface {p0, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    if-ne v3, v4, :cond_0

    .line 184
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 187
    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method static textInMemory()I
    .locals 2

    .prologue
    .line 119
    sget-object v0, Lcom/mrkeyboard/app/MrPrevWord;->sTail:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    sget-object v1, Lcom/mrkeyboard/app/MrPrevWord;->sTyped:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/2addr v0, v1

    sget-object v1, Lcom/mrkeyboard/app/MrPrevWord;->sHeldTail:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/2addr v0, v1

    return v0
.end method
