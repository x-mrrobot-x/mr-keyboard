.class final Lcom/mrkeyboard/app/MrNotesText;
.super Ljava/lang/Object;
.source "MrNotesText.java"


# static fields
.field private static final GAP_DP:I = 0x8

.field private static final LABEL_MAX:I = 0x20

.field private static final PAD_H_DP:I = 0xc

.field private static final PAD_V_DP:I = 0xa

.field private static final TEXT_SP:I = 0xe


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static appendBold(Landroid/text/SpannableStringBuilder;Ljava/lang/String;)V
    .locals 8

    .prologue
    const/4 v5, 0x1

    const/4 v1, 0x0

    .line 77
    move v0, v1

    move v2, v1

    .line 80
    :goto_0
    const-string v3, "**"

    invoke-virtual {p1, v3, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v4

    .line 81
    if-gez v4, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    .line 82
    :goto_1
    invoke-virtual {p0}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v6

    .line 83
    invoke-virtual {p1, v0, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    .line 84
    if-eqz v2, :cond_0

    invoke-virtual {p0}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v0

    if-le v0, v6, :cond_0

    .line 85
    new-instance v0, Landroid/text/style/StyleSpan;

    invoke-direct {v0, v5}, Landroid/text/style/StyleSpan;-><init>(I)V

    invoke-virtual {p0}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v3

    const/16 v7, 0x21

    invoke-virtual {p0, v0, v6, v3, v7}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    .line 87
    :cond_0
    if-gez v4, :cond_2

    return-void

    :cond_1
    move v3, v4

    .line 81
    goto :goto_1

    .line 88
    :cond_2
    if-nez v2, :cond_3

    move v2, v5

    .line 89
    :goto_2
    add-int/lit8 v0, v4, 0x2

    .line 90
    goto :goto_0

    :cond_3
    move v2, v1

    .line 88
    goto :goto_2
.end method

.method private static color(Landroid/content/res/Resources;Ljava/lang/String;Ljava/lang/String;)I
    .locals 1

    .prologue
    .line 131
    const-string v0, "color"

    invoke-virtual {p0, p2, v0, p1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 132
    if-eqz v0, :cond_0

    invoke-virtual {p0, v0}, Landroid/content/res/Resources;->getColor(I)I

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method private static dp(IF)I
    .locals 1

    .prologue
    .line 126
    int-to-float v0, p0

    mul-float/2addr v0, p1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    return v0
.end method

.method static fill(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;)I
    .locals 13

    .prologue
    .line 98
    invoke-virtual {p0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 99
    invoke-static {p1}, Lcom/mrkeyboard/app/MrNotesText;->items(Ljava/lang/String;)Ljava/util/List;

    move-result-object v3

    .line 100
    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    invoke-interface {v3, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 101
    :cond_0
    invoke-virtual {p0}, Landroid/widget/LinearLayout;->getContext()Landroid/content/Context;

    move-result-object v4

    .line 102
    invoke-virtual {v4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 103
    invoke-virtual {v4}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    .line 104
    const-string v2, "mr_ui_text2"

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrNotesText;->color(Landroid/content/res/Resources;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    .line 105
    const-string v2, "mr_ui_text"

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrNotesText;->color(Landroid/content/res/Resources;Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    .line 106
    const-string v2, "mr_ui_note_card"

    const-string v7, "drawable"

    invoke-virtual {v0, v2, v7, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v7

    .line 107
    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 108
    if-eqz v0, :cond_3

    iget v1, v0, Landroid/util/DisplayMetrics;->density:F

    const/4 v2, 0x0

    cmpl-float v1, v1, v2

    if-lez v1, :cond_3

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    move v1, v0

    .line 109
    :goto_0
    const/4 v0, 0x0

    move v2, v0

    :goto_1
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v0

    if-ge v2, v0, :cond_4

    .line 110
    new-instance v8, Landroid/widget/TextView;

    invoke-direct {v8, v4}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 111
    const/high16 v0, 0x41600000    # 14.0f

    invoke-virtual {v8, v0}, Landroid/widget/TextView;->setTextSize(F)V

    .line 112
    invoke-virtual {v8, v5}, Landroid/widget/TextView;->setTextColor(I)V

    .line 113
    const/high16 v0, 0x40400000    # 3.0f

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    int-to-float v0, v0

    const/high16 v9, 0x3f800000    # 1.0f

    invoke-virtual {v8, v0, v9}, Landroid/widget/TextView;->setLineSpacing(FF)V

    .line 114
    const/16 v0, 0xc

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrNotesText;->dp(IF)I

    move-result v0

    const/16 v9, 0xa

    invoke-static {v9, v1}, Lcom/mrkeyboard/app/MrNotesText;->dp(IF)I

    move-result v9

    const/16 v10, 0xc

    invoke-static {v10, v1}, Lcom/mrkeyboard/app/MrNotesText;->dp(IF)I

    move-result v10

    const/16 v11, 0xa

    invoke-static {v11, v1}, Lcom/mrkeyboard/app/MrNotesText;->dp(IF)I

    move-result v11

    invoke-virtual {v8, v0, v9, v10, v11}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 115
    if-eqz v7, :cond_1

    invoke-virtual {v8, v7}, Landroid/widget/TextView;->setBackgroundResource(I)V

    .line 116
    :cond_1
    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0, v6}, Lcom/mrkeyboard/app/MrNotesText;->format(Ljava/lang/String;I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v8, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 117
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v9, -0x1

    const/4 v10, -0x2

    invoke-direct {v0, v9, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 119
    if-lez v2, :cond_2

    const/4 v9, 0x0

    const/16 v10, 0x8

    invoke-static {v10, v1}, Lcom/mrkeyboard/app/MrNotesText;->dp(IF)I

    move-result v10

    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-virtual {v0, v9, v10, v11, v12}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 120
    :cond_2
    invoke-virtual {p0, v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 109
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    .line 108
    :cond_3
    const/high16 v0, 0x3f800000    # 1.0f

    move v1, v0

    goto :goto_0

    .line 122
    :cond_4
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method static format(Ljava/lang/String;I)Ljava/lang/CharSequence;
    .locals 6

    .prologue
    const/16 v5, 0x21

    const/4 v4, 0x0

    .line 64
    new-instance v0, Landroid/text/SpannableStringBuilder;

    const-string v1, ""

    invoke-direct {v0, v1}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    .line 65
    if-nez p0, :cond_1

    .line 72
    :cond_0
    :goto_0
    return-object v0

    .line 66
    :cond_1
    invoke-static {v0, p0}, Lcom/mrkeyboard/app/MrNotesText;->appendBold(Landroid/text/SpannableStringBuilder;Ljava/lang/String;)V

    .line 67
    const-string v1, "**"

    const-string v2, ""

    invoke-virtual {p0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrNotesText;->labelEnd(Ljava/lang/String;)I

    move-result v1

    .line 68
    if-lez v1, :cond_0

    .line 69
    new-instance v2, Landroid/text/style/ForegroundColorSpan;

    invoke-direct {v2, p1}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v0, v2, v4, v1, v5}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    .line 70
    new-instance v2, Landroid/text/style/StyleSpan;

    const/4 v3, 0x1

    invoke-direct {v2, v3}, Landroid/text/style/StyleSpan;-><init>(I)V

    invoke-virtual {v0, v2, v4, v1, v5}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    goto :goto_0
.end method

.method static items(Ljava/lang/String;)Ljava/util/List;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 51
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 52
    if-nez p0, :cond_0

    move-object v0, v1

    .line 59
    :goto_0
    return-object v0

    .line 53
    :cond_0
    const-string v0, "\r\n"

    const-string v2, "\n"

    invoke-virtual {p0, v0, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "\n"

    const/4 v3, -0x1

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v3

    .line 54
    array-length v4, v3

    const/4 v0, 0x0

    move v2, v0

    :goto_1
    if-ge v2, v4, :cond_4

    aget-object v0, v3, v2

    .line 55
    const-string v5, "`"

    const-string v6, ""

    invoke-virtual {v0, v5, v6}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 56
    const-string v5, "- "

    invoke-virtual {v0, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_1

    const-string v5, "* "

    invoke-virtual {v0, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    :cond_1
    const/4 v5, 0x2

    invoke-virtual {v0, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 57
    :cond_2
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_3

    const-string v5, "-"

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_3

    const-string v5, "*"

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_3

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 54
    :cond_3
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    :cond_4
    move-object v0, v1

    .line 59
    goto :goto_0
.end method

.method static labelEnd(Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 41
    const-string v0, ": "

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    .line 42
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
