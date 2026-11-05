.class final Lcom/mrkeyboard/app/MrImport;
.super Ljava/lang/Object;
.source "MrImport.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrImport$Plan;,
        Lcom/mrkeyboard/app/MrImport$Known;,
        Lcom/mrkeyboard/app/MrImport$NewWord;,
        Lcom/mrkeyboard/app/MrImport$NewPair;,
        Lcom/mrkeyboard/app/MrImport$Tok;,
        Lcom/mrkeyboard/app/MrImport$Ignored;
    }
.end annotation


# static fields
.field private static final CHAT_PREFIX:Ljava/util/regex/Pattern;

.field private static final DIGIT:Ljava/util/regex/Pattern;

.field private static final DIGITS:Ljava/util/regex/Pattern;

.field private static final EMAIL:Ljava/util/regex/Pattern;

.field private static final LAUGH:Ljava/util/regex/Pattern;

.field static final MAX_IGNORED_KEPT:I = 0xc8

.field static final MAX_PAIR_CANDIDATES:I = 0x30d40

.field static final MAX_PHRASE:I = 0x1e

.field static final MAX_WORD:I = 0x20

.field private static final PHONE:Ljava/util/regex/Pattern;

.field private static final RUN:Ljava/util/regex/Pattern;

.field static final R_CHARS:I = 0x5

.field static final R_LINK:I = 0x2

.field static final R_NO_WORDS:I = 0x1

.field static final R_NUMBER:I = 0x3

.field static final R_PHRASE_LONG:I = 0xb

.field static final R_SECTION:I = 0x8

.field static final R_SHORT:I = 0xa

.field static final R_SHORTCUT:I = 0x9

.field static final R_SPACE:I = 0x6

.field static final R_TOO_LONG:I = 0x4

.field static final R_WEIGHT:I = 0x7

.field private static final URL:Ljava/util/regex/Pattern;

.field static final WEIGHT_DEFAULT:I = 0x32

.field private static final WORD:Ljava/util/regex/Pattern;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 134
    const-string v0, "\\p{L}[\\p{L}\\p{M}\'\u2019-]*"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrImport;->WORD:Ljava/util/regex/Pattern;

    .line 135
    const-string v0, "(?i)\\b(?:https?://|www\\.)\\S+"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrImport;->URL:Ljava/util/regex/Pattern;

    .line 136
    const-string v0, "[\\w.+-]+@[\\w-]+(?:\\.[\\w-]+)+"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrImport;->EMAIL:Ljava/util/regex/Pattern;

    .line 137
    const-string v0, "\\+?\\d[\\d\\s().-]{6,}\\d"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrImport;->PHONE:Ljava/util/regex/Pattern;

    .line 138
    const-string v0, "\\d"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrImport;->DIGIT:Ljava/util/regex/Pattern;

    .line 139
    const-string v0, "\\p{L}*\\d[\\p{L}\\d]*"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrImport;->DIGITS:Ljava/util/regex/Pattern;

    .line 141
    const-string v0, "^\\s*\\[?\\d{1,4}[/.\\-]\\d{1,2}[/.\\-]\\d{1,4},?\\s+\\d{1,2}:\\d{2}(?::\\d{2})?(?:\\s?[AaPp]\\.?[Mm]\\.?)?\\]?\\s*(?:[-\u2013\u2014]\\s*)?(?:[^:]{1,40}:\\s*)?"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrImport;->CHAT_PREFIX:Ljava/util/regex/Pattern;

    .line 144
    const-string v0, "(?i)k{3,}|(?:ha){2,}h?|(?:he){2,}h?|(?:hi){2,}h?|(?:ho){2,}h?|(?:ja){2,}j?|(?:je){2,}j?|(?:ji){2,}j?|(?:rs){2,}|(?:kk)+k?"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrImport;->LAUGH:Ljava/util/regex/Pattern;

    .line 146
    const-string v0, "(?i)(\\p{L})\\1{3,}"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrImport;->RUN:Ljava/util/regex/Pattern;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static checkWord(Ljava/lang/String;)I
    .locals 3

    .prologue
    const/16 v2, 0x20

    const/4 v1, 0x0

    .line 269
    invoke-virtual {p0, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-gez v0, :cond_0

    const/16 v0, 0x9

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_2

    :cond_0
    const/4 v1, 0x6

    .line 276
    :cond_1
    :goto_0
    return v1

    .line 270
    :cond_2
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-le v0, v2, :cond_3

    const/4 v1, 0x4

    goto :goto_0

    :cond_3
    move v0, v1

    .line 271
    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v0, v2, :cond_5

    .line 272
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isDigit(C)Z

    move-result v2

    if-eqz v2, :cond_4

    const/4 v1, 0x3

    goto :goto_0

    .line 271
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 274
    :cond_5
    sget-object v0, Lcom/mrkeyboard/app/MrImport;->WORD:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    if-nez v0, :cond_6

    const/4 v1, 0x5

    goto :goto_0

    .line 275
    :cond_6
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v2, 0x2

    if-ge v0, v2, :cond_1

    const/16 v1, 0xa

    goto :goto_0
.end method

.method private static clean(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 358
    sget-object v0, Lcom/mrkeyboard/app/MrImport;->URL:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    const-string v1, " . "

    invoke-virtual {v0, v1}, Ljava/util/regex/Matcher;->replaceAll(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 359
    sget-object v1, Lcom/mrkeyboard/app/MrImport;->EMAIL:Ljava/util/regex/Pattern;

    invoke-virtual {v1, v0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    const-string v1, " . "

    invoke-virtual {v0, v1}, Ljava/util/regex/Matcher;->replaceAll(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 360
    sget-object v1, Lcom/mrkeyboard/app/MrImport;->PHONE:Ljava/util/regex/Pattern;

    invoke-virtual {v1, v0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    const-string v1, " . "

    invoke-virtual {v0, v1}, Ljava/util/regex/Matcher;->replaceAll(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 361
    return-object v0
.end method

.method private static comment(Ljava/lang/String;Lcom/mrkeyboard/app/MrImport$Plan;)V
    .locals 4

    .prologue
    const/4 v3, 0x1

    .line 252
    invoke-virtual {p0, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 253
    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    .line 254
    const-string v2, "mr-words"

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 255
    const-string v1, "mr-words"

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 257
    :try_start_0
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p1, Lcom/mrkeyboard/app/MrImport$Plan;->version:I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 265
    :cond_0
    :goto_0
    return-void

    .line 258
    :catch_0
    move-exception v0

    .line 259
    iput v3, p1, Lcom/mrkeyboard/app/MrImport$Plan;->version:I

    goto :goto_0

    .line 261
    :cond_1
    const-string v2, "language:"

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 262
    const-string v1, "language:"

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 263
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/16 v2, 0xc

    if-gt v1, v2, :cond_0

    iput-object v0, p1, Lcom/mrkeyboard/app/MrImport$Plan;->languageHint:Ljava/lang/String;

    goto :goto_0
.end method

.method static decode([BZ)Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 154
    if-nez p0, :cond_0

    const/4 v0, 0x0

    .line 169
    :goto_0
    return-object v0

    :cond_0
    move v2, v1

    .line 155
    :goto_1
    if-eqz p1, :cond_1

    const/4 v0, 0x3

    :goto_2
    if-gt v2, v0, :cond_2

    array-length v0, p0

    if-gt v2, v0, :cond_2

    .line 157
    :try_start_0
    const-string v0, "UTF-8"

    invoke-static {v0}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v0

    invoke-virtual {v0}, Ljava/nio/charset/Charset;->newDecoder()Ljava/nio/charset/CharsetDecoder;

    move-result-object v0

    sget-object v3, Ljava/nio/charset/CodingErrorAction;->REPORT:Ljava/nio/charset/CodingErrorAction;

    invoke-virtual {v0, v3}, Ljava/nio/charset/CharsetDecoder;->onMalformedInput(Ljava/nio/charset/CodingErrorAction;)Ljava/nio/charset/CharsetDecoder;

    move-result-object v0

    sget-object v3, Ljava/nio/charset/CodingErrorAction;->REPORT:Ljava/nio/charset/CodingErrorAction;

    invoke-virtual {v0, v3}, Ljava/nio/charset/CharsetDecoder;->onUnmappableCharacter(Ljava/nio/charset/CodingErrorAction;)Ljava/nio/charset/CharsetDecoder;

    move-result-object v0

    .line 158
    const/4 v3, 0x0

    array-length v4, p0

    sub-int/2addr v4, v2

    invoke-static {p0, v3, v4}, Ljava/nio/ByteBuffer;->wrap([BII)Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/nio/charset/CharsetDecoder;->decode(Ljava/nio/ByteBuffer;)Ljava/nio/CharBuffer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/nio/CharBuffer;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/nio/charset/CharacterCodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    :cond_1
    move v0, v1

    .line 155
    goto :goto_2

    .line 159
    :catch_0
    move-exception v0

    .line 155
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    .line 164
    :cond_2
    :try_start_1
    new-instance v0, Ljava/lang/String;

    const-string v1, "windows-1252"

    invoke-direct {v0, p0, v1}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 165
    :catch_1
    move-exception v0

    .line 167
    :try_start_2
    new-instance v0, Ljava/lang/String;

    const-string v1, "ISO-8859-1"

    invoke-direct {v0, p0, v1}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_0

    .line 168
    :catch_2
    move-exception v0

    .line 169
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p0}, Ljava/lang/String;-><init>([B)V

    goto :goto_0
.end method

.method private static endsSentence(Ljava/lang/String;)Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 527
    move v0, v1

    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v0, v2, :cond_1

    .line 528
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 529
    const/16 v3, 0x2e

    if-eq v2, v3, :cond_0

    const/16 v3, 0x21

    if-eq v2, v3, :cond_0

    const/16 v3, 0x3f

    if-eq v2, v3, :cond_0

    const/16 v3, 0x2026

    if-eq v2, v3, :cond_0

    const/16 v3, 0x3a

    if-eq v2, v3, :cond_0

    const/16 v3, 0xa

    if-ne v2, v3, :cond_2

    :cond_0
    const/4 v1, 0x1

    .line 531
    :cond_1
    return v1

    .line 527
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method private static flush(Ljava/util/ArrayList;Ljava/util/ArrayList;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<[",
            "Lcom/mrkeyboard/app/MrImport$Tok;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/mrkeyboard/app/MrImport$Tok;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 523
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_0

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v0

    new-array v0, v0, [Lcom/mrkeyboard/app/MrImport$Tok;

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/mrkeyboard/app/MrImport$Tok;

    invoke-virtual {p0, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 524
    :cond_0
    return-void
.end method

.method private static isAllCaps(Ljava/lang/String;)Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 371
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-le v1, v0, :cond_0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {p0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {p0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static isNoise(Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 375
    sget-object v0, Lcom/mrkeyboard/app/MrImport;->LAUGH:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrImport;->RUN:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->find()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static isStandard(Ljava/lang/String;)Z
    .locals 6

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 176
    if-nez p0, :cond_0

    move v0, v3

    .line 190
    :goto_0
    return v0

    .line 178
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    move v2, v3

    .line 179
    :goto_1
    if-ge v2, v1, :cond_7

    .line 180
    const/16 v0, 0xa

    invoke-virtual {p0, v0, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    .line 181
    if-gez v0, :cond_1

    move v0, v1

    .line 182
    :cond_1
    invoke-virtual {p0, v2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    .line 183
    const-string v5, "\ufeff"

    invoke-virtual {v2, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-virtual {v2, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    .line 184
    :cond_2
    add-int/lit8 v0, v0, 0x1

    .line 185
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v5

    if-nez v5, :cond_3

    move v2, v0

    goto :goto_1

    .line 186
    :cond_3
    sget-object v5, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v2, v5}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    .line 187
    const-string v5, "# mr-words"

    invoke-virtual {v2, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_4

    move v0, v4

    goto :goto_0

    .line 188
    :cond_4
    const-string v5, "[words]"

    invoke-virtual {v2, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_5

    const-string v5, "[phrases]"

    invoke-virtual {v2, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_5

    const-string v5, "[blocked]"

    invoke-virtual {v2, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_5

    const-string v5, "[shortcuts]"

    invoke-virtual {v2, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_6

    :cond_5
    move v0, v4

    goto :goto_0

    :cond_6
    move v2, v0

    .line 189
    goto :goto_1

    :cond_7
    move v0, v3

    .line 190
    goto :goto_0
.end method

.method private static knows(Lcom/mrkeyboard/app/MrImport$Known;Ljava/lang/String;)Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 379
    if-nez p0, :cond_1

    move v0, v1

    .line 382
    :cond_0
    :goto_0
    return v0

    .line 380
    :cond_1
    invoke-interface {p0, p1}, Lcom/mrkeyboard/app/MrImport$Known;->knows(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 381
    sget-object v2, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {p1, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    .line 382
    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    invoke-interface {p0, v2}, Lcom/mrkeyboard/app/MrImport$Known;->knows(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    :cond_2
    move v0, v1

    goto :goto_0
.end method

.method static parse(Ljava/lang/String;Lcom/mrkeyboard/app/MrImport$Known;)Lcom/mrkeyboard/app/MrImport$Plan;
    .locals 5

    .prologue
    const/4 v4, 0x1

    .line 194
    new-instance v1, Lcom/mrkeyboard/app/MrImport$Plan;

    invoke-direct {v1}, Lcom/mrkeyboard/app/MrImport$Plan;-><init>()V

    .line 195
    if-nez p0, :cond_0

    move-object v0, v1

    .line 204
    :goto_0
    return-object v0

    .line 196
    :cond_0
    const-string v0, "\r\n"

    const-string v2, "\n"

    invoke-virtual {p0, v0, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const/16 v2, 0xd

    const/16 v3, 0xa

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    .line 197
    const-string v2, "\ufeff"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {v0, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 198
    :cond_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrImport;->isStandard(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 199
    iput-boolean v4, v1, Lcom/mrkeyboard/app/MrImport$Plan;->standard:Z

    .line 200
    invoke-static {v0, p1, v1}, Lcom/mrkeyboard/app/MrImport;->parseStandard(Ljava/lang/String;Lcom/mrkeyboard/app/MrImport$Known;Lcom/mrkeyboard/app/MrImport$Plan;)V

    :goto_1
    move-object v0, v1

    .line 204
    goto :goto_0

    .line 202
    :cond_2
    invoke-static {v0, p1, v1}, Lcom/mrkeyboard/app/MrImport;->parseFree(Ljava/lang/String;Lcom/mrkeyboard/app/MrImport$Known;Lcom/mrkeyboard/app/MrImport$Plan;)V

    goto :goto_1
.end method

.method private static parseFree(Ljava/lang/String;Lcom/mrkeyboard/app/MrImport$Known;Lcom/mrkeyboard/app/MrImport$Plan;)V
    .locals 22

    .prologue
    .line 403
    const-string v2, "\n"

    const/4 v3, -0x1

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v14

    .line 404
    new-instance v15, Ljava/util/ArrayList;

    invoke-direct {v15}, Ljava/util/ArrayList;-><init>()V

    .line 405
    new-instance v16, Ljava/util/LinkedHashMap;

    invoke-direct/range {v16 .. v16}, Ljava/util/LinkedHashMap;-><init>()V

    .line 406
    const/4 v2, 0x0

    move v3, v2

    :goto_0
    array-length v2, v14

    if-ge v3, v2, :cond_13

    .line 407
    aget-object v17, v14, v3

    .line 408
    invoke-virtual/range {v17 .. v17}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_1

    .line 406
    :cond_0
    :goto_1
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    goto :goto_0

    .line 409
    :cond_1
    move-object/from16 v0, p2

    iget v2, v0, Lcom/mrkeyboard/app/MrImport$Plan;->lines:I

    add-int/lit8 v2, v2, 0x1

    move-object/from16 v0, p2

    iput v2, v0, Lcom/mrkeyboard/app/MrImport$Plan;->lines:I

    .line 410
    sget-object v2, Lcom/mrkeyboard/app/MrImport;->CHAT_PREFIX:Ljava/util/regex/Pattern;

    move-object/from16 v0, v17

    invoke-virtual {v2, v0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v2

    const-string v4, ""

    invoke-virtual {v2, v4}, Ljava/util/regex/Matcher;->replaceFirst(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 411
    sget-object v2, Lcom/mrkeyboard/app/MrImport;->URL:Ljava/util/regex/Pattern;

    invoke-virtual {v2, v5}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/regex/Matcher;->find()Z

    move-result v2

    if-nez v2, :cond_2

    sget-object v2, Lcom/mrkeyboard/app/MrImport;->EMAIL:Ljava/util/regex/Pattern;

    invoke-virtual {v2, v5}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/regex/Matcher;->find()Z

    move-result v2

    if-nez v2, :cond_2

    sget-object v2, Lcom/mrkeyboard/app/MrImport;->PHONE:Ljava/util/regex/Pattern;

    invoke-virtual {v2, v5}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/regex/Matcher;->find()Z

    move-result v2

    if-eqz v2, :cond_7

    :cond_2
    const/4 v2, 0x1

    move v4, v2

    .line 412
    :goto_2
    sget-object v2, Lcom/mrkeyboard/app/MrImport;->DIGIT:Ljava/util/regex/Pattern;

    invoke-virtual {v2, v5}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/regex/Matcher;->find()Z

    move-result v9

    .line 413
    invoke-static {v5}, Lcom/mrkeyboard/app/MrImport;->clean(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v18

    .line 414
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    .line 415
    sget-object v2, Lcom/mrkeyboard/app/MrImport;->WORD:Ljava/util/regex/Pattern;

    move-object/from16 v0, v18

    invoke-virtual {v2, v0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v19

    .line 416
    const/4 v7, -0x1

    .line 417
    const/4 v6, 0x1

    .line 418
    const/4 v5, 0x0

    .line 419
    const/4 v2, 0x0

    move/from16 v21, v2

    move v2, v6

    move v6, v5

    move/from16 v5, v21

    .line 420
    :goto_3
    invoke-virtual/range {v19 .. v19}, Ljava/util/regex/Matcher;->find()Z

    move-result v10

    if-eqz v10, :cond_10

    .line 421
    if-gez v7, :cond_8

    const-string v7, ""

    move-object v10, v7

    .line 422
    :goto_4
    invoke-virtual/range {v19 .. v19}, Ljava/util/regex/Matcher;->end()I

    move-result v7

    .line 423
    invoke-virtual {v10}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v11

    .line 424
    invoke-virtual {v11}, Ljava/lang/String;->length()I

    move-result v10

    if-nez v10, :cond_9

    invoke-virtual {v8}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v10

    if-nez v10, :cond_9

    const/4 v10, 0x1

    .line 425
    :goto_5
    invoke-virtual {v11}, Ljava/lang/String;->length()I

    move-result v12

    if-lez v12, :cond_4

    .line 426
    invoke-virtual {v8}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_3

    .line 427
    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v2

    new-array v2, v2, [Lcom/mrkeyboard/app/MrImport$Tok;

    invoke-virtual {v8, v2}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [Lcom/mrkeyboard/app/MrImport$Tok;

    invoke-virtual {v15, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 428
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    .line 430
    :cond_3
    invoke-static {v11}, Lcom/mrkeyboard/app/MrImport;->endsSentence(Ljava/lang/String;)Z

    move-result v2

    .line 432
    :cond_4
    invoke-virtual/range {v19 .. v19}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v11

    invoke-static {v11}, Lcom/mrkeyboard/app/MrImport;->trimToken(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    const/16 v12, 0x2019

    const/16 v13, 0x27

    invoke-virtual {v11, v12, v13}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v12

    .line 434
    invoke-virtual/range {v19 .. v19}, Ljava/util/regex/Matcher;->end()I

    move-result v11

    invoke-virtual/range {v18 .. v18}, Ljava/lang/String;->length()I

    move-result v13

    if-ge v11, v13, :cond_5

    invoke-virtual/range {v19 .. v19}, Ljava/util/regex/Matcher;->end()I

    move-result v11

    move-object/from16 v0, v18

    invoke-virtual {v0, v11}, Ljava/lang/String;->charAt(I)C

    move-result v11

    invoke-static {v11}, Ljava/lang/Character;->isDigit(C)Z

    move-result v11

    if-nez v11, :cond_6

    .line 435
    :cond_5
    invoke-virtual/range {v19 .. v19}, Ljava/util/regex/Matcher;->start()I

    move-result v11

    if-lez v11, :cond_a

    invoke-virtual/range {v19 .. v19}, Ljava/util/regex/Matcher;->start()I

    move-result v11

    add-int/lit8 v11, v11, -0x1

    move-object/from16 v0, v18

    invoke-virtual {v0, v11}, Ljava/lang/String;->charAt(I)C

    move-result v11

    invoke-static {v11}, Ljava/lang/Character;->isDigit(C)Z

    move-result v11

    if-eqz v11, :cond_a

    .line 436
    :cond_6
    const/4 v9, 0x1

    .line 437
    invoke-static {v15, v8}, Lcom/mrkeyboard/app/MrImport;->flush(Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    .line 438
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    .line 439
    const/4 v2, 0x0

    .line 440
    goto/16 :goto_3

    .line 411
    :cond_7
    const/4 v2, 0x0

    move v4, v2

    goto/16 :goto_2

    .line 421
    :cond_8
    invoke-virtual/range {v19 .. v19}, Ljava/util/regex/Matcher;->start()I

    move-result v10

    move-object/from16 v0, v18

    invoke-virtual {v0, v7, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    move-object v10, v7

    goto/16 :goto_4

    .line 424
    :cond_9
    const/4 v10, 0x0

    goto/16 :goto_5

    .line 442
    :cond_a
    invoke-virtual {v12}, Ljava/lang/String;->length()I

    move-result v11

    const/16 v13, 0x20

    if-le v11, v13, :cond_b

    .line 443
    const/4 v2, 0x1

    .line 444
    add-int/lit8 v5, v3, 0x1

    const/4 v10, 0x4

    move-object/from16 v0, p2

    invoke-virtual {v0, v5, v12, v10}, Lcom/mrkeyboard/app/MrImport$Plan;->ignore(ILjava/lang/String;I)V

    .line 445
    invoke-static {v15, v8}, Lcom/mrkeyboard/app/MrImport;->flush(Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    .line 446
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    .line 447
    const/4 v5, 0x0

    move/from16 v21, v2

    move v2, v5

    move/from16 v5, v21

    .line 448
    goto/16 :goto_3

    .line 450
    :cond_b
    invoke-static {v12}, Lcom/mrkeyboard/app/MrImport;->isNoise(Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_c

    .line 451
    invoke-static {v15, v8}, Lcom/mrkeyboard/app/MrImport;->flush(Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    .line 452
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    .line 453
    const/4 v2, 0x0

    .line 454
    goto/16 :goto_3

    .line 456
    :cond_c
    const/4 v11, 0x0

    invoke-virtual {v12, v11}, Ljava/lang/String;->charAt(I)C

    move-result v11

    invoke-static {v11}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v20

    .line 458
    if-eqz v20, :cond_f

    if-nez v2, :cond_f

    invoke-static {v12}, Lcom/mrkeyboard/app/MrImport;->isAllCaps(Ljava/lang/String;)Z

    move-result v11

    if-nez v11, :cond_f

    const/4 v11, 0x1

    move v13, v11

    .line 459
    :goto_6
    if-eqz v20, :cond_25

    if-eqz v2, :cond_25

    invoke-static {v12}, Lcom/mrkeyboard/app/MrImport;->isAllCaps(Ljava/lang/String;)Z

    move-result v11

    if-nez v11, :cond_25

    .line 460
    sget-object v11, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v12, v11}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v11

    .line 461
    if-eqz p1, :cond_25

    move-object/from16 v0, p1

    invoke-interface {v0, v11}, Lcom/mrkeyboard/app/MrImport$Known;->knows(Ljava/lang/String;)Z

    move-result v20

    if-eqz v20, :cond_25

    .line 463
    :goto_7
    new-instance v20, Lcom/mrkeyboard/app/MrImport$Tok;

    move-object/from16 v0, v20

    invoke-direct {v0, v11, v2, v13, v10}, Lcom/mrkeyboard/app/MrImport$Tok;-><init>(Ljava/lang/String;ZZZ)V

    move-object/from16 v0, v20

    invoke-virtual {v8, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 464
    invoke-virtual {v12}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v10, 0x2

    if-lt v2, v10, :cond_e

    .line 465
    move-object/from16 v0, v16

    invoke-virtual {v0, v11}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [I

    .line 466
    if-nez v2, :cond_d

    .line 467
    const/4 v2, 0x2

    new-array v2, v2, [I

    .line 468
    move-object/from16 v0, v16

    invoke-virtual {v0, v11, v2}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 470
    :cond_d
    const/4 v10, 0x0

    aget v11, v2, v10

    add-int/lit8 v11, v11, 0x1

    aput v11, v2, v10

    .line 471
    if-eqz v13, :cond_e

    const/4 v10, 0x1

    const/4 v11, 0x1

    aput v11, v2, v10

    .line 473
    :cond_e
    add-int/lit8 v2, v6, 0x1

    .line 474
    const/4 v6, 0x0

    move/from16 v21, v2

    move v2, v6

    move/from16 v6, v21

    .line 475
    goto/16 :goto_3

    .line 458
    :cond_f
    const/4 v11, 0x0

    move v13, v11

    goto :goto_6

    .line 476
    :cond_10
    invoke-static {v15, v8}, Lcom/mrkeyboard/app/MrImport;->flush(Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    .line 477
    if-nez v6, :cond_0

    if-nez v5, :cond_0

    .line 478
    add-int/lit8 v5, v3, 0x1

    if-eqz v4, :cond_11

    const/4 v2, 0x2

    :goto_8
    move-object/from16 v0, p2

    move-object/from16 v1, v17

    invoke-virtual {v0, v5, v1, v2}, Lcom/mrkeyboard/app/MrImport$Plan;->ignore(ILjava/lang/String;I)V

    goto/16 :goto_1

    :cond_11
    if-eqz v9, :cond_12

    const/4 v2, 0x3

    goto :goto_8

    :cond_12
    const/4 v2, 0x1

    goto :goto_8

    .line 482
    :cond_13
    new-instance v5, Ljava/util/HashMap;

    invoke-direct {v5}, Ljava/util/HashMap;-><init>()V

    .line 483
    invoke-virtual/range {v16 .. v16}, Ljava/util/LinkedHashMap;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :cond_14
    :goto_9
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_18

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    .line 484
    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 485
    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [I

    .line 486
    move-object/from16 v0, p1

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrImport;->knows(Lcom/mrkeyboard/app/MrImport$Known;Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_14

    .line 487
    const/4 v4, 0x0

    aget v4, v2, v4

    const/4 v7, 0x2

    if-ge v4, v7, :cond_15

    const/4 v4, 0x1

    aget v4, v2, v4

    const/4 v7, 0x1

    if-ne v4, v7, :cond_14

    .line 488
    :cond_15
    const/4 v4, 0x0

    aget v4, v2, v4

    const/16 v7, 0xa

    if-lt v4, v7, :cond_16

    const/16 v4, 0x46

    .line 489
    :goto_a
    move-object/from16 v0, p2

    iget-object v7, v0, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    new-instance v8, Lcom/mrkeyboard/app/MrImport$NewWord;

    const/4 v9, 0x0

    aget v9, v2, v9

    invoke-direct {v8, v3, v4, v9}, Lcom/mrkeyboard/app/MrImport$NewWord;-><init>(Ljava/lang/String;II)V

    invoke-virtual {v7, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 490
    const/4 v4, 0x0

    aget v2, v2, v4

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v5, v3, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_9

    .line 488
    :cond_16
    const/4 v4, 0x0

    aget v4, v2, v4

    const/4 v7, 0x5

    if-lt v4, v7, :cond_17

    const/16 v4, 0x3c

    goto :goto_a

    :cond_17
    const/16 v4, 0x32

    goto :goto_a

    .line 494
    :cond_18
    new-instance v6, Ljava/util/LinkedHashMap;

    invoke-direct {v6}, Ljava/util/LinkedHashMap;-><init>()V

    .line 495
    invoke-virtual {v15}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :cond_19
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_20

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [Lcom/mrkeyboard/app/MrImport$Tok;

    .line 496
    const/4 v3, 0x1

    move v4, v3

    :goto_b
    array-length v3, v2

    if-ge v4, v3, :cond_19

    .line 497
    aget-object v3, v2, v4

    iget-boolean v3, v3, Lcom/mrkeyboard/app/MrImport$Tok;->joined:Z

    if-nez v3, :cond_1b

    .line 496
    :cond_1a
    :goto_c
    add-int/lit8 v3, v4, 0x1

    move v4, v3

    goto :goto_b

    .line 498
    :cond_1b
    add-int/lit8 v3, v4, -0x1

    aget-object v3, v2, v3

    iget-object v3, v3, Lcom/mrkeyboard/app/MrImport$Tok;->text:Ljava/lang/String;

    aget-object v8, v2, v4

    iget-object v8, v8, Lcom/mrkeyboard/app/MrImport$Tok;->text:Ljava/lang/String;

    .line 499
    invoke-virtual {v5, v3}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_1c

    move-object/from16 v0, p1

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrImport;->knows(Lcom/mrkeyboard/app/MrImport$Known;Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_1a

    :cond_1c
    invoke-virtual {v5, v8}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_1d

    move-object/from16 v0, p1

    invoke-static {v0, v8}, Lcom/mrkeyboard/app/MrImport;->knows(Lcom/mrkeyboard/app/MrImport$Known;Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_1a

    .line 500
    :cond_1d
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v9, "\u0000"

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 501
    invoke-virtual {v6, v8}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [I

    .line 502
    if-nez v3, :cond_1f

    .line 503
    invoke-virtual {v6}, Ljava/util/LinkedHashMap;->size()I

    move-result v3

    const v9, 0x30d40

    if-lt v3, v9, :cond_1e

    .line 504
    const/4 v3, 0x1

    move-object/from16 v0, p2

    iput-boolean v3, v0, Lcom/mrkeyboard/app/MrImport$Plan;->pairsCut:Z

    goto :goto_c

    .line 507
    :cond_1e
    const/4 v3, 0x1

    new-array v3, v3, [I

    .line 508
    invoke-virtual {v6, v8, v3}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 510
    :cond_1f
    const/4 v8, 0x0

    aget v9, v3, v8

    add-int/lit8 v9, v9, 0x1

    aput v9, v3, v8

    goto :goto_c

    .line 513
    :cond_20
    invoke-virtual {v6}, Ljava/util/LinkedHashMap;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_21
    :goto_d
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_24

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    .line 514
    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [I

    const/4 v5, 0x0

    aget v3, v3, v5

    .line 515
    const/4 v5, 0x2

    if-lt v3, v5, :cond_21

    .line 516
    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 517
    const/4 v5, 0x0

    invoke-virtual {v2, v5}, Ljava/lang/String;->indexOf(I)I

    move-result v5

    .line 518
    move-object/from16 v0, p2

    iget-object v6, v0, Lcom/mrkeyboard/app/MrImport$Plan;->pairs:Ljava/util/ArrayList;

    new-instance v7, Lcom/mrkeyboard/app/MrImport$NewPair;

    const/4 v8, 0x0

    invoke-virtual {v2, v8, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    add-int/lit8 v5, v5, 0x1

    invoke-virtual {v2, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    const/16 v2, 0xa

    if-lt v3, v2, :cond_22

    const/16 v2, 0x46

    :goto_e
    invoke-direct {v7, v8, v5, v2, v3}, Lcom/mrkeyboard/app/MrImport$NewPair;-><init>(Ljava/lang/String;Ljava/lang/String;II)V

    invoke-virtual {v6, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_d

    :cond_22
    const/4 v2, 0x5

    if-lt v3, v2, :cond_23

    const/16 v2, 0x3c

    goto :goto_e

    :cond_23
    const/16 v2, 0x32

    goto :goto_e

    .line 520
    :cond_24
    return-void

    :cond_25
    move-object v11, v12

    goto/16 :goto_7
.end method

.method private static parseStandard(Ljava/lang/String;Lcom/mrkeyboard/app/MrImport$Known;Lcom/mrkeyboard/app/MrImport$Plan;)V
    .locals 13

    .prologue
    const/16 v12, 0x2019

    const/16 v11, 0x27

    const/16 v10, 0x8

    .line 210
    const-string v0, "\n"

    const/4 v1, -0x1

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v8

    .line 211
    const/4 v6, 0x0

    .line 212
    new-instance v4, Ljava/util/HashMap;

    invoke-direct {v4}, Ljava/util/HashMap;-><init>()V

    .line 213
    new-instance v5, Ljava/util/HashMap;

    invoke-direct {v5}, Ljava/util/HashMap;-><init>()V

    .line 214
    new-instance v9, Ljava/util/HashSet;

    invoke-direct {v9}, Ljava/util/HashSet;-><init>()V

    .line 215
    const/4 v0, 0x0

    move v7, v0

    :goto_0
    array-length v0, v8

    if-ge v7, v0, :cond_b

    .line 216
    aget-object v0, v8, v7

    .line 217
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    .line 218
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_1

    move-object v0, v6

    .line 215
    :cond_0
    :goto_1
    add-int/lit8 v1, v7, 0x1

    move v7, v1

    move-object v6, v0

    goto :goto_0

    .line 219
    :cond_1
    iget v2, p2, Lcom/mrkeyboard/app/MrImport$Plan;->lines:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p2, Lcom/mrkeyboard/app/MrImport$Plan;->lines:I

    .line 220
    const-string v2, "#"

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 221
    invoke-static {v1, p2}, Lcom/mrkeyboard/app/MrImport;->comment(Ljava/lang/String;Lcom/mrkeyboard/app/MrImport$Plan;)V

    move-object v0, v6

    .line 222
    goto :goto_1

    .line 224
    :cond_2
    const-string v2, "["

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 225
    const/4 v0, 0x1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v1, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    sget-object v2, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 226
    const-string v2, "words"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "phrases"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "blocked"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "shortcuts"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 227
    add-int/lit8 v0, v7, 0x1

    invoke-virtual {p2, v0, v1, v10}, Lcom/mrkeyboard/app/MrImport$Plan;->ignore(ILjava/lang/String;I)V

    .line 228
    const-string v0, "?"

    goto :goto_1

    .line 232
    :cond_3
    if-eqz v6, :cond_4

    const-string v2, "?"

    invoke-virtual {v6, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 233
    :cond_4
    add-int/lit8 v0, v7, 0x1

    invoke-virtual {p2, v0, v1, v10}, Lcom/mrkeyboard/app/MrImport$Plan;->ignore(ILjava/lang/String;I)V

    move-object v0, v6

    goto :goto_1

    .line 234
    :cond_5
    const-string v2, "words"

    invoke-virtual {v6, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_6

    .line 235
    add-int/lit8 v1, v7, 0x1

    invoke-static {v1, v0, p1, p2, v4}, Lcom/mrkeyboard/app/MrImport;->standardWord(ILjava/lang/String;Lcom/mrkeyboard/app/MrImport$Known;Lcom/mrkeyboard/app/MrImport$Plan;Ljava/util/HashMap;)V

    move-object v0, v6

    goto/16 :goto_1

    .line 236
    :cond_6
    const-string v0, "phrases"

    invoke-virtual {v6, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    .line 237
    add-int/lit8 v0, v7, 0x1

    move-object v2, p1

    move-object v3, p2

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrImport;->standardPhrase(ILjava/lang/String;Lcom/mrkeyboard/app/MrImport$Known;Lcom/mrkeyboard/app/MrImport$Plan;Ljava/util/HashMap;Ljava/util/HashMap;)V

    move-object v0, v6

    goto/16 :goto_1

    .line 238
    :cond_7
    const-string v0, "blocked"

    invoke-virtual {v6, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 240
    invoke-static {v1}, Lcom/mrkeyboard/app/MrImport;->checkWord(Ljava/lang/String;)I

    move-result v0

    .line 241
    if-eqz v0, :cond_9

    add-int/lit8 v2, v7, 0x1

    invoke-virtual {p2, v2, v1, v0}, Lcom/mrkeyboard/app/MrImport$Plan;->ignore(ILjava/lang/String;I)V

    :cond_8
    :goto_2
    move-object v0, v6

    .line 243
    goto/16 :goto_1

    .line 242
    :cond_9
    sget-object v0, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v12, v11}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v9, v0}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    iget-object v0, p2, Lcom/mrkeyboard/app/MrImport$Plan;->blocked:Ljava/util/ArrayList;

    invoke-virtual {v1, v12, v11}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 244
    :cond_a
    add-int/lit8 v0, v7, 0x1

    const/16 v2, 0x9

    invoke-virtual {p2, v0, v1, v2}, Lcom/mrkeyboard/app/MrImport$Plan;->ignore(ILjava/lang/String;I)V

    move-object v0, v6

    goto/16 :goto_1

    .line 247
    :cond_b
    iget-object v0, p2, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 248
    iget-object v0, p2, Lcom/mrkeyboard/app/MrImport$Plan;->pairs:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 249
    return-void
.end method

.method static reasons()Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 548
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 549
    const/4 v0, 0x1

    :goto_0
    const/16 v2, 0xb

    if-gt v0, v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "mr_import_why_"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 550
    :cond_0
    return-object v1
.end method

.method static splitWords(Ljava/lang/String;I)[Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 538
    if-nez p0, :cond_0

    move-object v0, v1

    .line 544
    :goto_0
    return-object v0

    .line 539
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    const-string v2, "\\s+"

    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 540
    array-length v0, v2

    if-eq v0, p1, :cond_1

    move-object v0, v1

    goto :goto_0

    .line 541
    :cond_1
    const/4 v0, 0x0

    :goto_1
    array-length v3, v2

    if-ge v0, v3, :cond_3

    .line 542
    aget-object v3, v2, v0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrImport;->checkWord(Ljava/lang/String;)I

    move-result v3

    if-eqz v3, :cond_2

    move-object v0, v1

    goto :goto_0

    .line 541
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    move-object v0, v2

    .line 544
    goto :goto_0
.end method

.method private static standardPhrase(ILjava/lang/String;Lcom/mrkeyboard/app/MrImport$Known;Lcom/mrkeyboard/app/MrImport$Plan;Ljava/util/HashMap;Ljava/util/HashMap;)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/MrImport$Known;",
            "Lcom/mrkeyboard/app/MrImport$Plan;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/MrImport$NewWord;",
            ">;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/MrImport$NewPair;",
            ">;)V"
        }
    .end annotation

    .prologue
    const/16 v7, 0x32

    const/4 v1, 0x1

    .line 315
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    .line 316
    sget-object v0, Lcom/mrkeyboard/app/MrImport;->WORD:Ljava/util/regex/Pattern;

    invoke-static {p1}, Lcom/mrkeyboard/app/MrImport;->clean(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    .line 317
    :cond_0
    :goto_0
    invoke-virtual {v0}, Ljava/util/regex/Matcher;->find()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 318
    invoke-virtual {v0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrImport;->trimToken(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x2019

    const/16 v4, 0x27

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v2

    .line 319
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-eqz v3, :cond_0

    .line 320
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    const/16 v4, 0x20

    if-le v3, v4, :cond_2

    .line 321
    const/4 v0, 0x4

    invoke-virtual {p3, p0, p1, v0}, Lcom/mrkeyboard/app/MrImport$Plan;->ignore(ILjava/lang/String;I)V

    .line 353
    :cond_1
    :goto_1
    return-void

    .line 324
    :cond_2
    invoke-virtual {v5, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 326
    :cond_3
    invoke-virtual {v5}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 327
    sget-object v0, Lcom/mrkeyboard/app/MrImport;->DIGITS:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->find()Z

    move-result v0

    if-eqz v0, :cond_4

    const/4 v0, 0x3

    :goto_2
    invoke-virtual {p3, p0, p1, v0}, Lcom/mrkeyboard/app/MrImport$Plan;->ignore(ILjava/lang/String;I)V

    goto :goto_1

    :cond_4
    move v0, v1

    goto :goto_2

    .line 330
    :cond_5
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v2, 0x1e

    if-le v0, v2, :cond_6

    .line 331
    const/16 v0, 0xb

    invoke-virtual {p3, p0, p1, v0}, Lcom/mrkeyboard/app/MrImport$Plan;->ignore(ILjava/lang/String;I)V

    goto :goto_1

    .line 334
    :cond_6
    const/4 v2, 0x0

    .line 335
    const/4 v0, 0x0

    move-object v3, v2

    move v2, v0

    :goto_3
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v2, v0, :cond_1

    .line 336
    invoke-virtual {v5, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 337
    sget-object v4, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v4

    .line 339
    if-nez v2, :cond_b

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_b

    if-eqz p2, :cond_b

    invoke-interface {p2, v4}, Lcom/mrkeyboard/app/MrImport$Known;->knows(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_b

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImport;->isAllCaps(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_b

    .line 340
    :goto_4
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v6, 0x2

    if-lt v0, v6, :cond_7

    invoke-static {p2, v4}, Lcom/mrkeyboard/app/MrImport;->knows(Lcom/mrkeyboard/app/MrImport$Known;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_7

    .line 341
    invoke-virtual {p4, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrImport$NewWord;

    .line 342
    if-nez v0, :cond_9

    new-instance v0, Lcom/mrkeyboard/app/MrImport$NewWord;

    invoke-direct {v0, v4, v7, v1}, Lcom/mrkeyboard/app/MrImport$NewWord;-><init>(Ljava/lang/String;II)V

    invoke-virtual {p4, v4, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 345
    :cond_7
    :goto_5
    if-eqz v3, :cond_8

    .line 346
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v6, "\u0000"

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 347
    invoke-virtual {p5, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrImport$NewPair;

    .line 348
    if-nez v0, :cond_a

    new-instance v0, Lcom/mrkeyboard/app/MrImport$NewPair;

    invoke-direct {v0, v3, v4, v7, v1}, Lcom/mrkeyboard/app/MrImport$NewPair;-><init>(Ljava/lang/String;Ljava/lang/String;II)V

    invoke-virtual {p5, v6, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 335
    :cond_8
    :goto_6
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    move-object v3, v4

    goto :goto_3

    .line 343
    :cond_9
    iget v6, v0, Lcom/mrkeyboard/app/MrImport$NewWord;->count:I

    add-int/lit8 v6, v6, 0x1

    iput v6, v0, Lcom/mrkeyboard/app/MrImport$NewWord;->count:I

    goto :goto_5

    .line 349
    :cond_a
    iget v3, v0, Lcom/mrkeyboard/app/MrImport$NewPair;->count:I

    add-int/lit8 v3, v3, 0x1

    iput v3, v0, Lcom/mrkeyboard/app/MrImport$NewPair;->count:I

    goto :goto_6

    :cond_b
    move-object v4, v0

    goto :goto_4
.end method

.method private static standardWord(ILjava/lang/String;Lcom/mrkeyboard/app/MrImport$Known;Lcom/mrkeyboard/app/MrImport$Plan;Ljava/util/HashMap;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/MrImport$Known;",
            "Lcom/mrkeyboard/app/MrImport$Plan;",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/MrImport$NewWord;",
            ">;)V"
        }
    .end annotation

    .prologue
    const/4 v4, 0x1

    .line 280
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    .line 281
    const/16 v0, 0x32

    .line 282
    const/16 v2, 0x9

    invoke-virtual {p1, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    .line 283
    if-ltz v2, :cond_1

    .line 284
    const/4 v0, 0x0

    invoke-virtual {p1, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    .line 285
    add-int/lit8 v0, v2, 0x1

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 287
    :try_start_0
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 291
    :goto_0
    if-lt v0, v4, :cond_0

    const/16 v2, 0x64

    if-le v0, v2, :cond_1

    .line 292
    :cond_0
    const/4 v0, 0x7

    invoke-virtual {p3, p0, p1, v0}, Lcom/mrkeyboard/app/MrImport$Plan;->ignore(ILjava/lang/String;I)V

    .line 312
    :goto_1
    return-void

    .line 288
    :catch_0
    move-exception v0

    .line 289
    const/4 v0, -0x1

    goto :goto_0

    :cond_1
    move v5, v0

    move-object v0, v1

    move v1, v5

    .line 296
    invoke-static {v0}, Lcom/mrkeyboard/app/MrImport;->checkWord(Ljava/lang/String;)I

    move-result v2

    .line 297
    if-eqz v2, :cond_2

    .line 298
    invoke-virtual {p3, p0, p1, v2}, Lcom/mrkeyboard/app/MrImport$Plan;->ignore(ILjava/lang/String;I)V

    goto :goto_1

    .line 301
    :cond_2
    const/16 v2, 0x2019

    const/16 v3, 0x27

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v2

    .line 302
    invoke-static {p2, v2}, Lcom/mrkeyboard/app/MrImport;->knows(Lcom/mrkeyboard/app/MrImport$Known;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 303
    iget v0, p3, Lcom/mrkeyboard/app/MrImport$Plan;->knownSkipped:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p3, Lcom/mrkeyboard/app/MrImport$Plan;->knownSkipped:I

    goto :goto_1

    .line 306
    :cond_3
    invoke-virtual {p4, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrImport$NewWord;

    .line 307
    if-nez v0, :cond_4

    new-instance v0, Lcom/mrkeyboard/app/MrImport$NewWord;

    invoke-direct {v0, v2, v1, v4}, Lcom/mrkeyboard/app/MrImport$NewWord;-><init>(Ljava/lang/String;II)V

    invoke-virtual {p4, v2, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 309
    :cond_4
    iget v2, v0, Lcom/mrkeyboard/app/MrImport$NewWord;->count:I

    add-int/lit8 v2, v2, 0x1

    iput v2, v0, Lcom/mrkeyboard/app/MrImport$NewWord;->count:I

    .line 310
    iget v2, v0, Lcom/mrkeyboard/app/MrImport$NewWord;->weight:I

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    iput v1, v0, Lcom/mrkeyboard/app/MrImport$NewWord;->weight:I

    goto :goto_1
.end method

.method private static trimToken(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 365
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 366
    :goto_0
    if-lez v0, :cond_1

    add-int/lit8 v1, v0, -0x1

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x2d

    if-eq v1, v2, :cond_0

    add-int/lit8 v1, v0, -0x1

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x27

    if-eq v1, v2, :cond_0

    add-int/lit8 v1, v0, -0x1

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x2019

    if-ne v1, v2, :cond_1

    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 367
    :cond_1
    const/4 v1, 0x0

    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
