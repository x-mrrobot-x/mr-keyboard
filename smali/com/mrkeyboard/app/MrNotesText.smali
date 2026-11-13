.class final Lcom/mrkeyboard/app/MrNotesText;
.super Ljava/lang/Object;
.source "MrNotesText.java"


# static fields
.field private static final BULLET:Ljava/lang/String; = "\u2022 "

.field static final FIXED:I = 0x2

.field private static final GAP:F = 0.5f

.field static final HOW:I = 0x3

.field static final IMPROVED:I = 0x1

.field static final KINDS:I = 0x5

.field private static final LABEL_MAX:I = 0x20

.field static final NEW:I = 0x0

.field static final OTHER:I = 0x4


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static appendBold(Landroid/text/SpannableStringBuilder;Ljava/lang/String;)V
    .locals 8

    .prologue
    const/4 v5, 0x1

    const/4 v1, 0x0

    .line 92
    move v0, v1

    move v2, v1

    .line 95
    :goto_0
    const-string v3, "**"

    invoke-virtual {p1, v3, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v4

    .line 96
    if-gez v4, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    .line 97
    :goto_1
    invoke-virtual {p0}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v6

    .line 98
    invoke-virtual {p1, v0, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    .line 99
    if-eqz v2, :cond_0

    invoke-virtual {p0}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v0

    if-le v0, v6, :cond_0

    .line 100
    new-instance v0, Landroid/text/style/StyleSpan;

    invoke-direct {v0, v5}, Landroid/text/style/StyleSpan;-><init>(I)V

    invoke-virtual {p0}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v3

    const/16 v7, 0x21

    invoke-virtual {p0, v0, v6, v3, v7}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    .line 102
    :cond_0
    if-gez v4, :cond_2

    return-void

    :cond_1
    move v3, v4

    .line 96
    goto :goto_1

    .line 103
    :cond_2
    if-nez v2, :cond_3

    move v2, v5

    .line 104
    :goto_2
    add-int/lit8 v0, v4, 0x2

    .line 105
    goto :goto_0

    :cond_3
    move v2, v1

    .line 103
    goto :goto_2
.end method

.method static colorName(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 121
    if-nez p0, :cond_0

    const-string v0, "mr_ui_mint"

    .line 125
    :goto_0
    return-object v0

    .line 122
    :cond_0
    const/4 v0, 0x1

    if-ne p0, v0, :cond_1

    const-string v0, "mr_ui_blue"

    goto :goto_0

    .line 123
    :cond_1
    const/4 v0, 0x2

    if-ne p0, v0, :cond_2

    const-string v0, "mr_ui_amber"

    goto :goto_0

    .line 124
    :cond_2
    const/4 v0, 0x3

    if-ne p0, v0, :cond_3

    const-string v0, "mr_ui_violet"

    goto :goto_0

    .line 125
    :cond_3
    const-string v0, "mr_ui_slate"

    goto :goto_0
.end method

.method static forView(Landroid/widget/TextView;Ljava/lang/String;)Ljava/lang/CharSequence;
    .locals 7

    .prologue
    const/4 v6, 0x5

    .line 133
    invoke-virtual {p0}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 134
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    .line 135
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    .line 136
    new-array v4, v6, [I

    .line 137
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    if-ge v1, v6, :cond_1

    .line 138
    invoke-static {v1}, Lcom/mrkeyboard/app/MrNotesText;->colorName(I)Ljava/lang/String;

    move-result-object v0

    const-string v5, "color"

    invoke-virtual {v2, v0, v5, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 139
    if-eqz v0, :cond_0

    invoke-virtual {v2, v0}, Landroid/content/res/Resources;->getColor(I)I

    move-result v0

    :goto_1
    aput v0, v4, v1

    .line 137
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 139
    :cond_0
    const/4 v0, -0x1

    goto :goto_1

    .line 141
    :cond_1
    invoke-virtual {p0}, Landroid/widget/TextView;->getPaint()Landroid/text/TextPaint;

    move-result-object v0

    const-string v1, "\u2022 "

    invoke-virtual {v0, v1}, Landroid/text/TextPaint;->measureText(Ljava/lang/String;)F

    move-result v0

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-static {p1, v4, v0}, Lcom/mrkeyboard/app/MrNotesText;->format(Ljava/lang/String;[II)Ljava/lang/CharSequence;

    move-result-object v0

    return-object v0
.end method

.method static format(Ljava/lang/String;[II)Ljava/lang/CharSequence;
    .locals 11

    .prologue
    const/16 v10, 0x21

    const/4 v3, 0x0

    .line 66
    new-instance v1, Landroid/text/SpannableStringBuilder;

    const-string v0, ""

    invoke-direct {v1, v0}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    .line 67
    if-nez p0, :cond_0

    move-object v0, v1

    .line 87
    :goto_0
    return-object v0

    .line 68
    :cond_0
    const-string v0, "\r\n"

    const-string v2, "\n"

    invoke-virtual {p0, v0, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "\n"

    const/4 v4, -0x1

    invoke-virtual {v0, v2, v4}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v5

    .line 69
    array-length v6, v5

    move v4, v3

    :goto_1
    if-ge v4, v6, :cond_8

    aget-object v0, v5, v4

    .line 70
    const-string v2, "`"

    const-string v7, ""

    invoke-virtual {v0, v2, v7}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 71
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_2

    .line 69
    :cond_1
    :goto_2
    add-int/lit8 v0, v4, 0x1

    move v4, v0

    goto :goto_1

    .line 72
    :cond_2
    const-string v2, "- "

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    const-string v2, "* "

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_7

    :cond_3
    const/4 v2, 0x1

    .line 73
    :goto_3
    if-eqz v2, :cond_4

    const/4 v7, 0x2

    invoke-virtual {v0, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 74
    :cond_4
    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v7

    if-lez v7, :cond_5

    .line 75
    const-string v7, "\n\n"

    invoke-virtual {v1, v7}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    .line 76
    new-instance v7, Landroid/text/style/RelativeSizeSpan;

    const/high16 v8, 0x3f000000    # 0.5f

    invoke-direct {v7, v8}, Landroid/text/style/RelativeSizeSpan;-><init>(F)V

    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v8

    add-int/lit8 v8, v8, -0x1

    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v9

    invoke-virtual {v1, v7, v8, v9, v10}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    .line 78
    :cond_5
    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v7

    .line 79
    if-eqz v2, :cond_6

    const-string v8, "\u2022 "

    invoke-virtual {v1, v8}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    .line 80
    :cond_6
    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v8

    .line 81
    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrNotesText;->appendBold(Landroid/text/SpannableStringBuilder;Ljava/lang/String;)V

    .line 82
    if-eqz v2, :cond_1

    .line 83
    new-instance v2, Landroid/text/style/LeadingMarginSpan$Standard;

    invoke-direct {v2, v3, p2}, Landroid/text/style/LeadingMarginSpan$Standard;-><init>(II)V

    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v9

    invoke-virtual {v1, v2, v7, v9, v10}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    .line 84
    const-string v2, "**"

    const-string v9, ""

    invoke-virtual {v0, v2, v9}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v7, v8, v0, p1}, Lcom/mrkeyboard/app/MrNotesText;->styleHead(Landroid/text/SpannableStringBuilder;IILjava/lang/String;[I)V

    goto :goto_2

    :cond_7
    move v2, v3

    .line 72
    goto :goto_3

    :cond_8
    move-object v0, v1

    .line 87
    goto/16 :goto_0
.end method

.method static kindOf(Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 47
    sget-object v0, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {p0, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 48
    const-string v1, "novo"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "new"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 52
    :goto_0
    return v0

    .line 49
    :cond_1
    const-string v1, "melhor"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "improv"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    :cond_2
    const/4 v0, 0x1

    goto :goto_0

    .line 50
    :cond_3
    const-string v1, "corrig"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    const-string v1, "corre"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    const-string v1, "fix"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    :cond_4
    const/4 v0, 0x2

    goto :goto_0

    .line 51
    :cond_5
    const-string v1, "como receber"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_6

    const-string v1, "how to get"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_7

    :cond_6
    const/4 v0, 0x3

    goto :goto_0

    .line 52
    :cond_7
    const/4 v0, 0x4

    goto :goto_0
.end method

.method static labelEnd(Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 57
    const-string v0, ": "

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    .line 58
    if-lez v0, :cond_0

    const/16 v1, 0x20

    if-gt v0, v1, :cond_0

    add-int/lit8 v0, v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static styleHead(Landroid/text/SpannableStringBuilder;IILjava/lang/String;[I)V
    .locals 4

    .prologue
    const/16 v3, 0x21

    .line 113
    invoke-static {p3}, Lcom/mrkeyboard/app/MrNotesText;->labelEnd(Ljava/lang/String;)I

    move-result v1

    .line 114
    if-lez v1, :cond_1

    const/4 v0, 0x0

    add-int/lit8 v2, v1, -0x1

    invoke-virtual {p3, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrNotesText;->kindOf(Ljava/lang/String;)I

    move-result v0

    :goto_0
    aget v0, p4, v0

    .line 115
    new-instance v2, Landroid/text/style/ForegroundColorSpan;

    invoke-direct {v2, v0}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    add-int v0, p2, v1

    invoke-virtual {p0, v2, p1, v0, v3}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    .line 116
    if-lez v1, :cond_0

    new-instance v0, Landroid/text/style/StyleSpan;

    const/4 v2, 0x1

    invoke-direct {v0, v2}, Landroid/text/style/StyleSpan;-><init>(I)V

    add-int/2addr v1, p2

    invoke-virtual {p0, v0, p2, v1, v3}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    .line 117
    :cond_0
    return-void

    .line 114
    :cond_1
    const/4 v0, 0x4

    goto :goto_0
.end method
