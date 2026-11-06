.class final Lcom/mrkeyboard/app/MrKit;
.super Ljava/lang/Object;
.source "MrKit.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrKit$LangPick;
    }
.end annotation


# instance fields
.field final accent:I

.field final act:Landroid/app/Activity;

.field final bg:I

.field final card:I

.field final onAccent:I

.field final rose:I

.field final soft:I

.field final stroke:I

.field final text:I

.field final text2:I


# direct methods
.method constructor <init>(Landroid/app/Activity;)V
    .locals 1

    .prologue
    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 35
    iput-object p1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    .line 36
    const-string v0, "mr_ui_bg"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->bg:I

    .line 37
    const-string v0, "mr_ui_card"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->card:I

    .line 38
    const-string v0, "mr_ui_stroke_strong"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    .line 39
    const-string v0, "mr_ui_text"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    .line 40
    const-string v0, "mr_ui_text2"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->text2:I

    .line 41
    const-string v0, "mr_accent"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->accent:I

    .line 42
    const-string v0, "mr_text_on_accent"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    .line 43
    const-string v0, "mr_ui_rose"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->rose:I

    .line 44
    const-string v0, "mr_ui_cyan_soft"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->soft:I

    .line 45
    return-void
.end method

.method private color(Ljava/lang/String;)I
    .locals 4

    .prologue
    .line 48
    iget-object v0, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "color"

    iget-object v3, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-virtual {v3}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, p1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getColor(I)I

    move-result v0

    return v0
.end method


# virtual methods
.method button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;
    .locals 7

    .prologue
    const/high16 v6, 0x41d00000    # 26.0f

    const/high16 v3, 0x41600000    # 14.0f

    const/high16 v4, 0x41400000    # 12.0f

    const/4 v5, 0x0

    .line 121
    const/high16 v1, 0x41700000    # 15.0f

    if-eqz p2, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    :goto_0
    invoke-virtual {p0, p1, v1, v0, p2}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 122
    const/16 v0, 0x11

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setGravity(I)V

    .line 123
    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v1, v0, v2, v3, v4}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 124
    if-eqz p2, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {p0, v0, v5, v6, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    :goto_1
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 125
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setClickable(Z)V

    .line 126
    invoke-virtual {v1, p3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 127
    return-object v1

    .line 121
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    goto :goto_0

    .line 124
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->card:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    invoke-virtual {p0, v0, v2, v6, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    goto :goto_1
.end method

.method chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;
    .locals 7

    .prologue
    const/high16 v6, 0x41900000    # 18.0f

    const/high16 v3, 0x41400000    # 12.0f

    const/high16 v4, 0x41000000    # 8.0f

    const/4 v5, 0x0

    .line 132
    const/high16 v1, 0x41600000    # 14.0f

    if-eqz p2, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    :goto_0
    invoke-virtual {p0, p1, v1, v0, p2}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 133
    const/16 v0, 0x11

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setGravity(I)V

    .line 134
    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v1, v0, v2, v3, v4}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 135
    if-eqz p2, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {p0, v0, v5, v6, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    :goto_1
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 136
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setClickable(Z)V

    .line 137
    invoke-virtual {v1, p3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 138
    return-object v1

    .line 132
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    goto :goto_0

    .line 135
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->card:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    invoke-virtual {p0, v0, v2, v6, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    goto :goto_1
.end method

.method column()Landroid/widget/LinearLayout;
    .locals 2

    .prologue
    .line 85
    new-instance v0, Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 86
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 87
    return-object v0
.end method

.method dp(F)I
    .locals 1

    .prologue
    .line 52
    iget-object v0, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr v0, p1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    return v0
.end method

.method field(Ljava/lang/String;I)Landroid/widget/EditText;
    .locals 6

    .prologue
    const/high16 v5, 0x41800000    # 16.0f

    const/high16 v3, 0x41600000    # 14.0f

    const/high16 v4, 0x41400000    # 12.0f

    .line 211
    new-instance v0, Landroid/widget/EditText;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 212
    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    .line 213
    iget v1, p0, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setHintTextColor(I)V

    .line 214
    iget v1, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTextColor(I)V

    .line 215
    invoke-virtual {v0, v5}, Landroid/widget/EditText;->setTextSize(F)V

    .line 216
    invoke-virtual {v0, p2}, Landroid/widget/EditText;->setInputType(I)V

    .line 217
    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/EditText;->setPadding(IIII)V

    .line 218
    iget v1, p0, Lcom/mrkeyboard/app/MrKit;->card:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    const/4 v3, 0x0

    invoke-virtual {p0, v1, v2, v5, v3}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 219
    return-object v0
.end method

.method fill(Landroid/widget/LinearLayout;Ljava/util/List;I)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/LinearLayout;",
            "Ljava/util/List",
            "<",
            "Landroid/widget/TextView;",
            ">;I)V"
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 143
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 144
    const/4 v0, 0x0

    move v3, v1

    .line 145
    :goto_0
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result v2

    if-ge v3, v2, :cond_2

    .line 146
    rem-int v2, v3, p3

    if-nez v2, :cond_3

    .line 147
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v2

    .line 148
    if-nez v3, :cond_1

    move v0, v1

    :goto_1
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {p1, v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 150
    :goto_2
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v0, -0x2

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v4, v1, v0, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 151
    rem-int v0, v3, p3

    if-eqz v0, :cond_0

    const/high16 v0, 0x41000000    # 8.0f

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    invoke-virtual {v4, v0, v1, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 152
    :cond_0
    invoke-interface {p2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {v2, v0, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 145
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    move-object v0, v2

    goto :goto_0

    .line 148
    :cond_1
    const/16 v0, 0x8

    goto :goto_1

    .line 154
    :cond_2
    return-void

    :cond_3
    move-object v2, v0

    goto :goto_2
.end method

.method header(Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;
    .locals 8

    .prologue
    const/4 v7, 0x0

    const/high16 v4, 0x41200000    # 10.0f

    const/high16 v5, 0x40c00000    # 6.0f

    const/4 v6, -0x2

    .line 108
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 109
    const/high16 v1, 0x41c00000    # 24.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v3, 0x1

    invoke-virtual {p0, p1, v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 110
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-direct {v2, v7, v6, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 111
    const-string v1, "\u2715"

    const/high16 v2, 0x41a00000    # 20.0f

    iget v3, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {p0, v1, v2, v3, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 112
    const/16 v2, 0x11

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 113
    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 114
    invoke-virtual {v1, p2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 115
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v6, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 116
    return-object v0
.end method

.method item(Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;
    .locals 8

    .prologue
    const/high16 v4, 0x41400000    # 12.0f

    const/4 v7, -0x2

    const/high16 v6, 0x41600000    # 14.0f

    const/4 v5, 0x0

    .line 224
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 225
    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 226
    iget v1, p0, Lcom/mrkeyboard/app/MrKit;->card:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    invoke-virtual {p0, v1, v2, v6, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 227
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 228
    invoke-virtual {v0, p3}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 229
    const/high16 v1, 0x41800000    # 16.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {p0, p1, v1, v2, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 230
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-direct {v2, v5, v7, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 231
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    .line 232
    const/high16 v1, 0x41500000    # 13.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {p0, p2, v1, v2, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 233
    const/high16 v2, 0x41200000    # 10.0f

    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {v1, v2, v5, v5, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 234
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v7, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 236
    :cond_0
    return-object v0
.end method

.method label(Ljava/lang/String;FIZ)Landroid/widget/TextView;
    .locals 3

    .prologue
    .line 98
    new-instance v0, Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 99
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 100
    invoke-virtual {v0, p3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 101
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setTextSize(F)V

    .line 102
    if-eqz p4, :cond_0

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 103
    :cond_0
    return-object v0
.end method

.method langName(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 241
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mr_lang_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 242
    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "string"

    iget-object v3, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-virtual {v3}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v0, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    invoke-static {p1}, Lcom/mrkeyboard/app/MrLearned;->tag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method languageCard(Landroid/widget/LinearLayout;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/MrKit$LangPick;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/LinearLayout;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/MrKit$LangPick;",
            ")V"
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 186
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 187
    const-string v0, "mr_lang_card_title"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p3}, Lcom/mrkeyboard/app/MrKit;->langName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrKit$1;

    invoke-direct {v2, p0, p2, p3, p4}, Lcom/mrkeyboard/app/MrKit$1;-><init>(Lcom/mrkeyboard/app/MrKit;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/MrKit$LangPick;)V

    invoke-virtual {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->select(Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 207
    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    .line 187
    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 208
    return-void
.end method

.method lp(III)Landroid/widget/LinearLayout$LayoutParams;
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 75
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, p1, p2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 76
    if-eqz p3, :cond_0

    int-to-float v1, p3

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-virtual {v0, v2, v1, v2, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 77
    :cond_0
    return-object v0
.end method

.method round(IIFZ)Landroid/graphics/drawable/GradientDrawable;
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 66
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 67
    if-eqz p4, :cond_1

    invoke-virtual {v0, v2}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 69
    :goto_0
    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 70
    if-eqz p2, :cond_0

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-virtual {v0, v1, p2}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 71
    :cond_0
    return-object v0

    .line 68
    :cond_1
    invoke-virtual {p0, p3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    goto :goto_0
.end method

.method row()Landroid/widget/LinearLayout;
    .locals 2

    .prologue
    .line 91
    new-instance v0, Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 92
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 93
    const/16 v1, 0x10

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 94
    return-object v0
.end method

.method select(Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;
    .locals 10

    .prologue
    const/4 v9, 0x1

    const/high16 v8, 0x41800000    # 16.0f

    const/4 v7, -0x2

    const/high16 v6, 0x41400000    # 12.0f

    const/4 v5, 0x0

    .line 161
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 162
    invoke-virtual {p0, v8}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    const/high16 v3, 0x41600000    # 14.0f

    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 163
    iget v1, p0, Lcom/mrkeyboard/app/MrKit;->card:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    invoke-virtual {p0, v1, v2, v8, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 164
    invoke-virtual {v0, v9}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 165
    invoke-virtual {v0, p3}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 166
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 167
    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {p0, p1, v6, v2, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 168
    const/high16 v2, 0x41880000    # 17.0f

    iget v3, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {p0, p2, v2, v3, v9}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    const/4 v3, 0x2

    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 169
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-direct {v2, v5, v7, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 170
    const-string v1, "\u25be"

    const/high16 v2, 0x41900000    # 18.0f

    iget v3, p0, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {p0, v1, v2, v3, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 171
    const/high16 v2, 0x41200000    # 10.0f

    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {v1, v2, v5, v5, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 172
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v7, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 173
    return-object v0
.end method

.method varargs t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 57
    iget-object v0, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-static {v0, p1, p2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 58
    if-eqz v0, :cond_0

    move-object p1, v0

    :cond_0
    return-object p1
.end method

.method toast(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 62
    iget-object v0, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    const/4 v1, 0x0

    invoke-static {v0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 63
    return-void
.end method

.method wide(I)Landroid/widget/LinearLayout$LayoutParams;
    .locals 2

    .prologue
    .line 81
    const/4 v0, -0x1

    const/4 v1, -0x2

    invoke-virtual {p0, v0, v1, p1}, Lcom/mrkeyboard/app/MrKit;->lp(III)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    return-object v0
.end method
