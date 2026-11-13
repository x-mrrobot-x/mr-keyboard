.class public Lcom/mrkeyboard/app/EditingUtil;
.super Ljava/lang/Object;
.source "EditingUtil.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/EditingUtil$SelectedWord;,
        Lcom/mrkeyboard/app/EditingUtil$Range;
    }
.end annotation


# static fields
.field private static final LOOKBACK_CHARACTER_NUM:I = 0xf







.field private static final spaceRegex:Ljava/util/regex/Pattern;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "\\s+"

    .line 174
    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/EditingUtil;->spaceRegex:Ljava/util/regex/Pattern;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static appendText(Landroid/view/inputmethod/InputConnection;Ljava/lang/String;)V
    .locals 3

    if-nez p0, :cond_0

    return-void

    .line 54
    :cond_0
    invoke-interface {p0}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    const/4 v0, 0x0

    const/4 v1, 0x1

    .line 57
    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V

    invoke-interface {p0, v1, v0}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v0

    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    if-eqz v0, :cond_1

    const-string v2, " "

    .line 59
    invoke-virtual {v0, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 60
    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-lez v0, :cond_1

    .line 61
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 64
    :cond_1
    invoke-interface {p0, p1, v1}, Landroid/view/inputmethod/InputConnection;->setComposingText(Ljava/lang/CharSequence;I)Z

    return-void
.end method

.method public static deleteWordAtCursor(Landroid/view/inputmethod/InputConnection;Ljava/lang/String;)V
    .locals 2

    const/4 v0, 0x0

    .line 97
    invoke-static {p0, p1, v0}, Lcom/mrkeyboard/app/EditingUtil;->getWordRangeAtCursor(Landroid/view/inputmethod/InputConnection;Ljava/lang/String;Lcom/mrkeyboard/app/EditingUtil$Range;)Lcom/mrkeyboard/app/EditingUtil$Range;

    move-result-object p1

    if-nez p1, :cond_0

    return-void

    .line 100
    :cond_0
    invoke-interface {p0}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    .line 103
    invoke-static {p0}, Lcom/mrkeyboard/app/EditingUtil;->getCursorPosition(Landroid/view/inputmethod/InputConnection;)I

    move-result v0

    iget v1, p1, Lcom/mrkeyboard/app/EditingUtil$Range;->charsBefore:I

    sub-int/2addr v0, v1

    .line 104
    invoke-interface {p0, v0, v0}, Landroid/view/inputmethod/InputConnection;->setSelection(II)Z

    const/4 v0, 0x0

    .line 105
    iget v1, p1, Lcom/mrkeyboard/app/EditingUtil$Range;->charsBefore:I

    iget p1, p1, Lcom/mrkeyboard/app/EditingUtil$Range;->charsAfter:I

    add-int/2addr v1, p1

    invoke-interface {p0, v0, v1}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z

    return-void
.end method

.method private static getCursorPosition(Landroid/view/inputmethod/InputConnection;)I
    .locals 2

    .line 68
    new-instance v0, Landroid/view/inputmethod/ExtractedTextRequest;

    invoke-direct {v0}, Landroid/view/inputmethod/ExtractedTextRequest;-><init>()V

    const/4 v1, 0x0

    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V

    invoke-interface {p0, v0, v1}, Landroid/view/inputmethod/InputConnection;->getExtractedText(Landroid/view/inputmethod/ExtractedTextRequest;I)Landroid/view/inputmethod/ExtractedText;

    move-result-object p0

    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    if-nez p0, :cond_0

    const/4 p0, -0x1

    return p0

    .line 73
    :cond_0
    iget v0, p0, Landroid/view/inputmethod/ExtractedText;->startOffset:I

    iget p0, p0, Landroid/view/inputmethod/ExtractedText;->selectionStart:I

    add-int/2addr v0, p0

    return v0
.end method

.method public static getPreviousWord(Landroid/view/inputmethod/InputConnection;Ljava/lang/String;)Ljava/lang/CharSequence;
    .locals 4

    const/16 v0, 0xf

    const/4 v1, 0x0

    .line 179
    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V

    invoke-interface {p0, v0, v1}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object p0

    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 183
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/EditingUtil;->spaceRegex:Ljava/util/regex/Pattern;

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->split(Ljava/lang/CharSequence;)[Ljava/lang/String;

    move-result-object p0

    .line 184
    array-length v1, p0

    const/4 v2, 0x2

    if-lt v1, v2, :cond_2

    array-length v1, p0

    sub-int/2addr v1, v2

    aget-object v1, p0, v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_2

    .line 185
    array-length v1, p0

    sub-int/2addr v1, v2

    aget-object v1, p0, v1

    array-length v3, p0

    sub-int/2addr v3, v2

    aget-object v3, p0, v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    add-int/lit8 v3, v3, -0x1

    invoke-virtual {v1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 186
    invoke-static {v1}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-eqz p1, :cond_1

    return-object v0

    .line 189
    :cond_1
    array-length p1, p0

    sub-int/2addr p1, v2

    aget-object p0, p0, p1

    return-object p0

    :cond_2
    return-object v0
.end method

.method private static getSelectedText(Landroid/view/inputmethod/InputConnection;II)Ljava/lang/CharSequence;
    .locals 1

    const/4 v0, 0x0

    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V

    invoke-interface {p0, v0}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;

    move-result-object p0

    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    return-object p0
.end method

.method public static getWordAtCursor(Landroid/view/inputmethod/InputConnection;Ljava/lang/String;Lcom/mrkeyboard/app/EditingUtil$Range;)Ljava/lang/String;
    .locals 0

    .line 86
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/EditingUtil;->getWordRangeAtCursor(Landroid/view/inputmethod/InputConnection;Ljava/lang/String;Lcom/mrkeyboard/app/EditingUtil$Range;)Lcom/mrkeyboard/app/EditingUtil$Range;

    move-result-object p0

    if-nez p0, :cond_0

    const/4 p0, 0x0

    goto :goto_0

    .line 87
    :cond_0
    iget-object p0, p0, Lcom/mrkeyboard/app/EditingUtil$Range;->word:Ljava/lang/String;

    :goto_0
    return-object p0
.end method

.method public static getWordAtCursorOrSelection(Landroid/view/inputmethod/InputConnection;IILjava/lang/String;)Lcom/mrkeyboard/app/EditingUtil$SelectedWord;
    .locals 4

    const/4 v0, 0x0

    if-ne p1, p2, :cond_1

    .line 226
    new-instance v1, Lcom/mrkeyboard/app/EditingUtil$Range;

    invoke-direct {v1}, Lcom/mrkeyboard/app/EditingUtil$Range;-><init>()V

    .line 227
    invoke-static {p0, p3, v1}, Lcom/mrkeyboard/app/EditingUtil;->getWordAtCursor(Landroid/view/inputmethod/InputConnection;Ljava/lang/String;Lcom/mrkeyboard/app/EditingUtil$Range;)Ljava/lang/String;

    move-result-object p0

    .line 228
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p3

    if-nez p3, :cond_0

    .line 229
    new-instance p3, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    invoke-direct {p3}, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;-><init>()V

    .line 230
    iput-object p0, p3, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;->word:Ljava/lang/CharSequence;

    .line 231
    iget p0, v1, Lcom/mrkeyboard/app/EditingUtil$Range;->charsBefore:I

    sub-int/2addr p1, p0

    iput p1, p3, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;->start:I

    .line 232
    iget p0, v1, Lcom/mrkeyboard/app/EditingUtil$Range;->charsAfter:I

    add-int/2addr p2, p0

    iput p2, p3, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;->end:I

    return-object p3

    :cond_0
    return-object v0

    :cond_1
    const/4 v1, 0x0

    const/4 v2, 0x1

    .line 237
    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V

    invoke-interface {p0, v2, v1}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v3

    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 238
    invoke-static {v3, p3}, Lcom/mrkeyboard/app/EditingUtil;->isWordBoundary(Ljava/lang/CharSequence;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_2

    return-object v0

    .line 243
    :cond_2
    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V

    invoke-interface {p0, v2, v1}, Landroid/view/inputmethod/InputConnection;->getTextAfterCursor(II)Ljava/lang/CharSequence;

    move-result-object v2

    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 244
    invoke-static {v2, p3}, Lcom/mrkeyboard/app/EditingUtil;->isWordBoundary(Ljava/lang/CharSequence;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    return-object v0

    .line 249
    :cond_3
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/EditingUtil;->getSelectedText(Landroid/view/inputmethod/InputConnection;II)Ljava/lang/CharSequence;

    move-result-object p0

    .line 250
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_4

    return-object v0

    .line 252
    :cond_4
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    :goto_0
    if-ge v1, v2, :cond_6

    add-int/lit8 v3, v1, 0x1

    .line 254
    invoke-interface {p0, v1, v3}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {p3, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_5

    return-object v0

    :cond_5
    move v1, v3

    goto :goto_0

    .line 259
    :cond_6
    new-instance p3, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    invoke-direct {p3}, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;-><init>()V

    .line 260
    iput p1, p3, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;->start:I

    .line 261
    iput p2, p3, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;->end:I

    .line 262
    iput-object p0, p3, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;->word:Ljava/lang/CharSequence;

    return-object p3
.end method

.method private static getWordRangeAtCursor(Landroid/view/inputmethod/InputConnection;Ljava/lang/String;Lcom/mrkeyboard/app/EditingUtil$Range;)Lcom/mrkeyboard/app/EditingUtil$Range;
    .locals 7

    const/4 v0, 0x0

    if-eqz p0, :cond_7

    if-nez p1, :cond_0

    goto/16 :goto_4

    :cond_0
    const/16 v1, 0x3e8

    const/4 v2, 0x0

    .line 141
    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V

    invoke-interface {p0, v1, v2}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v3

    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    .line 142
    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V

    invoke-interface {p0, v1, v2}, Landroid/view/inputmethod/InputConnection;->getTextAfterCursor(II)Ljava/lang/CharSequence;

    move-result-object v1

    # Performance meter (MrPerf, docs/plan-performance.md stages 5 and 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V

    if-eqz v3, :cond_6

    if-nez v1, :cond_1

    goto/16 :goto_3

    .line 148
    :cond_1
    invoke-interface {v3}, Ljava/lang/CharSequence;->length()I

    move-result v4

    :goto_0
    if-lez v4, :cond_2

    add-int/lit8 v5, v4, -0x1

    .line 149
    invoke-interface {v3, v5}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v5

    invoke-static {v5, p1}, Lcom/mrkeyboard/app/EditingUtil;->isWhitespace(ILjava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_2

    add-int/lit8 v4, v4, -0x1

    goto :goto_0

    :cond_2
    const/4 v5, -0x1

    :goto_1
    add-int/lit8 v5, v5, 0x1

    .line 153
    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v6

    if-ge v5, v6, :cond_3

    invoke-interface {v1, v5}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v6

    invoke-static {v6, p1}, Lcom/mrkeyboard/app/EditingUtil;->isWhitespace(ILjava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_3

    goto :goto_1

    .line 155
    :cond_3
    invoke-static {p0}, Lcom/mrkeyboard/app/EditingUtil;->getCursorPosition(Landroid/view/inputmethod/InputConnection;)I

    move-result p0

    if-ltz v4, :cond_5

    add-int/2addr p0, v5

    .line 156
    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result p1

    invoke-interface {v3}, Ljava/lang/CharSequence;->length()I

    move-result v6

    add-int/2addr p1, v6

    if-gt p0, p1, :cond_5

    .line 157
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {v3}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v3}, Ljava/lang/CharSequence;->length()I

    move-result v0

    invoke-virtual {p1, v4, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 158
    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1, v2, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    if-eqz p2, :cond_4

    goto :goto_2

    .line 160
    :cond_4
    new-instance p2, Lcom/mrkeyboard/app/EditingUtil$Range;

    invoke-direct {p2}, Lcom/mrkeyboard/app/EditingUtil$Range;-><init>()V

    .line 161
    :goto_2
    invoke-interface {v3}, Ljava/lang/CharSequence;->length()I

    move-result p1

    sub-int/2addr p1, v4

    iput p1, p2, Lcom/mrkeyboard/app/EditingUtil$Range;->charsBefore:I

    .line 162
    iput v5, p2, Lcom/mrkeyboard/app/EditingUtil$Range;->charsAfter:I

    .line 163
    iput-object p0, p2, Lcom/mrkeyboard/app/EditingUtil$Range;->word:Ljava/lang/String;

    return-object p2

    :cond_5
    return-object v0

    :cond_6
    :goto_3
    return-object v0

    :cond_7
    :goto_4
    return-object v0
.end method

.method private static isWhitespace(ILjava/lang/String;)Z
    .locals 0

    int-to-char p0, p0

    .line 171
    invoke-static {p0}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p0

    return p0
.end method

.method private static isWordBoundary(Ljava/lang/CharSequence;Ljava/lang/String;)Z
    .locals 1

    .line 209
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1, p0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p0

    if-eqz p0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p0, 0x1

    :goto_1
    return p0
.end method

.method public static underlineWord(Landroid/view/inputmethod/InputConnection;Lcom/mrkeyboard/app/EditingUtil$SelectedWord;)V
    .locals 2

    iget v0, p1, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;->start:I

    iget v1, p1, Lcom/mrkeyboard/app/EditingUtil$SelectedWord;->end:I

    invoke-interface {p0, v0, v1}, Landroid/view/inputmethod/InputConnection;->setComposingRegion(II)Z

    return-void
.end method
