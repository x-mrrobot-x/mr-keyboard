.class final Lcom/mrkeyboard/app/MrKit;
.super Ljava/lang/Object;
.source "MrKit.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrKit$LangPick;
    }
.end annotation


# static fields
.field static final NEAR_END_DP:I = 0x4b


# instance fields
.field final accent:I

.field final act:Landroid/app/Activity;

.field final bg:I

.field final card:I

.field final faint:I

.field final glass:Z

.field final hint:I

.field final line:I

.field final onAccent:I

.field final raised:I

.field final rose:I

.field final soft:I

.field final stroke:I

.field final sunken:I

.field final text:I

.field final text2:I


# direct methods
.method constructor <init>(Landroid/app/Activity;)V
    .locals 1

    .prologue
    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 50
    iput-object p1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    .line 51
    invoke-static {p1}, Lcom/mrkeyboard/app/MrMatrix;->wanted(Landroid/app/Activity;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrKit;->glass:Z

    .line 52
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrKit;->glass:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->bg:I

    .line 53
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrKit;->glass:Z

    if-eqz v0, :cond_1

    const-string v0, "mr_ui_card_glass"

    :goto_1
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->card:I

    .line 54
    const-string v0, "mr_ui_stroke_strong"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    .line 55
    const-string v0, "mr_ui_text"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    .line 56
    const-string v0, "mr_ui_text2"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->text2:I

    .line 57
    const-string v0, "mr_accent"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->accent:I

    .line 58
    const-string v0, "mr_text_on_accent"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    .line 59
    const-string v0, "mr_ui_rose"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->rose:I

    .line 60
    const-string v0, "mr_ui_cyan_soft"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->soft:I

    .line 61
    const-string v0, "mr_ui_raised"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->raised:I

    .line 62
    const-string v0, "mr_ui_faint"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->faint:I

    .line 63
    const-string v0, "mr_ui_sunken"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->sunken:I

    .line 64
    const-string v0, "mr_ui_stroke"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->line:I

    .line 65
    const-string v0, "mr_ui_text3"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrKit;->hint:I

    .line 66
    return-void

    .line 52
    :cond_0
    const-string v0, "mr_ui_bg"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    .line 53
    :cond_1
    const-string v0, "mr_ui_card"

    goto :goto_1
.end method

.method private color(Ljava/lang/String;)I
    .locals 4

    .prologue
    .line 69
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

.method private hair()I
    .locals 2

    .prologue
    .line 512
    const/4 v0, 0x1

    const/high16 v1, 0x3f000000    # 0.5f

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    return v0
.end method


# virtual methods
.method backHeader(Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;
    .locals 7

    .prologue
    const/high16 v5, 0x41100000    # 9.0f

    const/4 v6, 0x0

    .line 337
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 338
    const-string v1, "mr_ui_ic_back"

    const/high16 v2, 0x42200000    # 40.0f

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->iconView(Ljava/lang/String;F)Landroid/widget/ImageView;

    move-result-object v1

    .line 339
    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/widget/ImageView;->setPadding(IIII)V

    .line 340
    const-string v2, "mr_back_desc"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {p0, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 341
    invoke-virtual {v1, p2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 342
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 343
    const/high16 v1, 0x41b00000    # 22.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v3, 0x1

    invoke-virtual {p0, p1, v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 344
    const/high16 v2, 0x40c00000    # 6.0f

    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {v1, v2, v6, v6, v6}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 345
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x2

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v2, v6, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 346
    return-object v0
.end method

.method button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;
    .locals 7

    .prologue
    const/high16 v3, 0x41600000    # 14.0f

    const/4 v6, 0x0

    const/high16 v5, 0x41400000    # 12.0f

    .line 147
    const/high16 v1, 0x41700000    # 15.0f

    if-eqz p2, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    :goto_0
    invoke-virtual {p0, p1, v1, v0, p2}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 148
    const/16 v0, 0x11

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setGravity(I)V

    .line 149
    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v1, v0, v2, v3, v4}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 150
    if-eqz p2, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {p0, v0, v6, v5, v6}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    :goto_1
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 151
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setClickable(Z)V

    .line 152
    invoke-virtual {v1, p3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 153
    return-object v1

    .line 147
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    goto :goto_0

    .line 150
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->raised:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->line:I

    invoke-virtual {p0, v0, v2, v5, v6}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    goto :goto_1
.end method

.method chip(Ljava/lang/String;ZFLandroid/view/View$OnClickListener;)Landroid/widget/TextView;
    .locals 6

    .prologue
    const/high16 v3, 0x41400000    # 12.0f

    const/high16 v4, 0x41000000    # 8.0f

    const/4 v5, 0x0

    .line 163
    const/high16 v1, 0x41600000    # 14.0f

    if-eqz p2, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    :goto_0
    invoke-virtual {p0, p1, v1, v0, p2}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 164
    const/16 v0, 0x11

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setGravity(I)V

    .line 165
    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v1, v0, v2, v3, v4}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 166
    if-eqz p2, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {p0, v0, v5, p3, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    :goto_1
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 167
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setClickable(Z)V

    .line 168
    invoke-virtual {v1, p4}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 169
    return-object v1

    .line 163
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    goto :goto_0

    .line 166
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->card:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    invoke-virtual {p0, v0, v2, p3, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    goto :goto_1
.end method

.method chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;
    .locals 1

    .prologue
    .line 158
    const/high16 v0, 0x41900000    # 18.0f

    invoke-virtual {p0, p1, p2, v0, p3}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZFLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    return-object v0
.end method

.method column()Landroid/widget/LinearLayout;
    .locals 2

    .prologue
    .line 111
    new-instance v0, Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 112
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 113
    return-object v0
.end method

.method dp(F)I
    .locals 1

    .prologue
    .line 78
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

.method emptyState(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/widget/LinearLayout;
    .locals 7

    .prologue
    const/high16 v6, 0x41600000    # 14.0f

    const/4 v5, 0x0

    .line 430
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 431
    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 432
    iget v1, p0, Lcom/mrkeyboard/app/MrKit;->raised:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->line:I

    invoke-virtual {p0, v1, v2, v6, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 433
    const/high16 v1, 0x42100000    # 36.0f

    invoke-virtual {p0, p1, v1}, Lcom/mrkeyboard/app/MrKit;->iconView(Ljava/lang/String;F)Landroid/widget/ImageView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 434
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 435
    const/high16 v2, 0x41400000    # 12.0f

    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {v1, v2, v5, v5, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 436
    const/high16 v2, 0x41700000    # 15.0f

    iget v3, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v4, 0x1

    invoke-virtual {p0, p2, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 437
    const/high16 v2, 0x41500000    # 13.0f

    iget v3, p0, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {p0, p3, v2, v3, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    const/4 v3, 0x3

    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 438
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x2

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v2, v5, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 439
    return-object v0
.end method

.method field(Ljava/lang/String;I)Landroid/widget/EditText;
    .locals 6

    .prologue
    const/high16 v3, 0x41600000    # 14.0f

    const/high16 v5, 0x41400000    # 12.0f

    .line 258
    new-instance v0, Landroid/widget/EditText;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 259
    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    .line 260
    iget v1, p0, Lcom/mrkeyboard/app/MrKit;->hint:I

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setHintTextColor(I)V

    .line 261
    iget v1, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTextColor(I)V

    .line 262
    const/high16 v1, 0x41800000    # 16.0f

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTextSize(F)V

    .line 263
    invoke-virtual {v0, p2}, Landroid/widget/EditText;->setInputType(I)V

    .line 264
    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/EditText;->setPadding(IIII)V

    .line 265
    iget v1, p0, Lcom/mrkeyboard/app/MrKit;->raised:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->line:I

    const/4 v3, 0x0

    invoke-virtual {p0, v1, v2, v5, v3}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 266
    return-object v0
.end method

.method fieldBox(Landroid/widget/EditText;Landroid/widget/TextView;)Landroid/widget/LinearLayout;
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 377
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 378
    iget v1, p0, Lcom/mrkeyboard/app/MrKit;->raised:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->line:I

    const/high16 v3, 0x41400000    # 12.0f

    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 379
    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Landroid/widget/EditText;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 380
    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 381
    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, p2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 382
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

    .line 174
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 175
    const/4 v0, 0x0

    move v3, v1

    .line 176
    :goto_0
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result v2

    if-ge v3, v2, :cond_2

    .line 177
    rem-int v2, v3, p3

    if-nez v2, :cond_3

    .line 178
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v2

    .line 179
    if-nez v3, :cond_1

    move v0, v1

    :goto_1
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {p1, v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 181
    :goto_2
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v0, -0x2

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v4, v1, v0, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 182
    rem-int v0, v3, p3

    if-eqz v0, :cond_0

    const/high16 v0, 0x41000000    # 8.0f

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    invoke-virtual {v4, v0, v1, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 183
    :cond_0
    invoke-interface {p2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {v2, v0, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 176
    add-int/lit8 v0, v3, 0x1

    move v3, v0

    move-object v0, v2

    goto :goto_0

    .line 179
    :cond_1
    const/16 v0, 0x8

    goto :goto_1

    .line 185
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

    .line 134
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 135
    const/high16 v1, 0x41c00000    # 24.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v3, 0x1

    invoke-virtual {p0, p1, v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 136
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-direct {v2, v7, v6, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 137
    const-string v1, "\u2715"

    const/high16 v2, 0x41a00000    # 20.0f

    iget v3, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {p0, v1, v2, v3, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 138
    const/16 v2, 0x11

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 139
    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 140
    invoke-virtual {v1, p2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 141
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v6, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 142
    return-object v0
.end method

.method icon(Ljava/lang/String;F)Landroid/graphics/drawable/Drawable;
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 320
    iget-object v0, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "drawable"

    iget-object v3, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-virtual {v3}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, p1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 321
    invoke-virtual {p0, p2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    .line 322
    invoke-virtual {v0, v4, v4, v1, v1}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 323
    return-object v0
.end method

.method iconButton(Ljava/lang/String;Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;
    .locals 5

    .prologue
    const/high16 v3, 0x41600000    # 14.0f

    const/high16 v4, 0x41500000    # 13.0f

    .line 387
    new-instance v0, Lcom/mrkeyboard/app/MrIconButton;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrIconButton;-><init>(Landroid/content/Context;)V

    .line 388
    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/MrIconButton;->setText(Ljava/lang/CharSequence;)V

    .line 389
    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrIconButton;->setGravity(I)V

    .line 390
    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrIconButton;->setPadding(IIII)V

    .line 391
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrIconButton;->setClickable(Z)V

    .line 392
    invoke-virtual {v0, p4}, Lcom/mrkeyboard/app/MrIconButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 393
    invoke-virtual {p0, v0, p3, p2}, Lcom/mrkeyboard/app/MrKit;->restyleIconButton(Landroid/widget/TextView;ZLjava/lang/String;)V

    .line 394
    return-object v0
.end method

.method iconRow(Ljava/lang/String;FLjava/lang/String;FIZ)Landroid/widget/LinearLayout;
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 359
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 360
    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/MrKit;->iconView(Ljava/lang/String;F)Landroid/widget/ImageView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 361
    invoke-virtual {p0, p3, p4, p5, p6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 362
    const/high16 v2, 0x41200000    # 10.0f

    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {v1, v2, v5, v5, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 363
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x2

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v2, v5, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 364
    return-object v0
.end method

.method iconView(Ljava/lang/String;F)Landroid/widget/ImageView;
    .locals 3

    .prologue
    .line 328
    new-instance v0, Landroid/widget/ImageView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 329
    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/MrKit;->icon(Ljava/lang/String;F)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 330
    invoke-virtual {p0, p2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    .line 331
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 332
    return-object v0
.end method

.method infoCard(Ljava/lang/String;)Landroid/widget/LinearLayout;
    .locals 8

    .prologue
    const/4 v6, 0x0

    const/high16 v7, 0x41800000    # 16.0f

    .line 369
    const-string v1, "mr_ui_ic_info"

    const/high16 v2, 0x41b00000    # 22.0f

    const/high16 v4, 0x41600000    # 14.0f

    iget v5, p0, Lcom/mrkeyboard/app/MrKit;->text2:I

    move-object v0, p0

    move-object v3, p1

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/MrKit;->iconRow(Ljava/lang/String;FLjava/lang/String;FIZ)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 370
    invoke-virtual {p0, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-virtual {p0, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 371
    iget v1, p0, Lcom/mrkeyboard/app/MrKit;->card:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-virtual {p0, v1, v2, v3, v6}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 372
    return-object v0
.end method

.method item(Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;
    .locals 8

    .prologue
    const/high16 v4, 0x41400000    # 12.0f

    const/4 v7, -0x2

    const/high16 v6, 0x41600000    # 14.0f

    const/4 v5, 0x0

    .line 444
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 445
    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 446
    iget v1, p0, Lcom/mrkeyboard/app/MrKit;->card:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    invoke-virtual {p0, v1, v2, v6, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 447
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 448
    invoke-virtual {v0, p3}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 449
    const/high16 v1, 0x41800000    # 16.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {p0, p1, v1, v2, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 450
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-direct {v2, v5, v7, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 451
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    .line 452
    const/high16 v1, 0x41500000    # 13.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {p0, p2, v1, v2, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 453
    const/high16 v2, 0x41200000    # 10.0f

    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {v1, v2, v5, v5, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 454
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v7, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 456
    :cond_0
    return-object v0
.end method

.method label(Ljava/lang/String;FIZ)Landroid/widget/TextView;
    .locals 3

    .prologue
    .line 124
    new-instance v0, Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 125
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 126
    invoke-virtual {v0, p3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 127
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setTextSize(F)V

    .line 128
    if-eqz p4, :cond_0

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 129
    :cond_0
    return-object v0
.end method

.method langName(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .prologue
    .line 517
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mr_lang_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 518
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
    .locals 6
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
    .line 228
    const/4 v5, 0x1

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    invoke-virtual/range {v0 .. v5}, Lcom/mrkeyboard/app/MrKit;->languageCard(Landroid/widget/LinearLayout;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/MrKit$LangPick;Z)V

    .line 229
    return-void
.end method

.method languageCard(Landroid/widget/LinearLayout;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/MrKit$LangPick;Z)V
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
            "Z)V"
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 233
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 234
    if-eqz p5, :cond_0

    const-string v0, "mr_lang_card_title"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {p0, p3}, Lcom/mrkeyboard/app/MrKit;->langName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrKit$1;

    invoke-direct {v2, p0, p2, p3, p4}, Lcom/mrkeyboard/app/MrKit$1;-><init>(Lcom/mrkeyboard/app/MrKit;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/MrKit$LangPick;)V

    invoke-virtual {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->select(Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 254
    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    .line 234
    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 255
    return-void

    .line 234
    :cond_0
    const-string v0, ""

    goto :goto_0
.end method

.method lp(III)Landroid/widget/LinearLayout$LayoutParams;
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 101
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, p1, p2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 102
    if-eqz p3, :cond_0

    int-to-float v1, p3

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-virtual {v0, v2, v1, v2, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 103
    :cond_0
    return-object v0
.end method

.method nearEnd(Landroid/widget/ScrollView;Landroid/view/ViewGroup;)Z
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 286
    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    invoke-virtual {p2}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    move v0, v3

    .line 294
    :goto_0
    return v0

    .line 287
    :cond_1
    invoke-virtual {p2}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {p2, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    .line 288
    invoke-virtual {v1}, Landroid/view/View;->getTop()I

    move-result v0

    .line 289
    invoke-virtual {v1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    move v2, v0

    .line 290
    :goto_1
    instance-of v0, v1, Landroid/view/View;

    if-eqz v0, :cond_2

    if-eq v1, p1, :cond_2

    move-object v0, v1

    .line 291
    check-cast v0, Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getTop()I

    move-result v0

    add-int/2addr v0, v2

    .line 292
    invoke-interface {v1}, Landroid/view/ViewParent;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    move v2, v0

    goto :goto_1

    .line 294
    :cond_2
    invoke-virtual {p1}, Landroid/widget/ScrollView;->getScrollY()I

    move-result v0

    invoke-virtual {p1}, Landroid/widget/ScrollView;->getHeight()I

    move-result v1

    add-int/2addr v0, v1

    sub-int v0, v2, v0

    const/high16 v1, 0x42960000    # 75.0f

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    if-gt v0, v1, :cond_3

    const/4 v0, 0x1

    goto :goto_0

    :cond_3
    move v0, v3

    goto :goto_0
.end method

.method onScroll(Landroid/widget/ScrollView;Ljava/lang/Runnable;)V
    .locals 1

    .prologue
    .line 274
    new-instance v0, Lcom/mrkeyboard/app/MrKit$2;

    invoke-direct {v0, p0, p2}, Lcom/mrkeyboard/app/MrKit$2;-><init>(Lcom/mrkeyboard/app/MrKit;Ljava/lang/Runnable;)V

    invoke-virtual {p1, v0}, Landroid/widget/ScrollView;->setOnScrollChangeListener(Landroid/view/View$OnScrollChangeListener;)V

    .line 279
    return-void
.end method

.method panel()Landroid/widget/LinearLayout;
    .locals 5

    .prologue
    const/high16 v4, 0x41800000    # 16.0f

    .line 351
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 352
    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 353
    iget v1, p0, Lcom/mrkeyboard/app/MrKit;->card:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    const/high16 v3, 0x41a00000    # 20.0f

    const/4 v4, 0x0

    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 354
    return-object v0
.end method

.method restyleIconButton(Landroid/widget/TextView;ZLjava/lang/String;)V
    .locals 4

    .prologue
    const/high16 v3, 0x41400000    # 12.0f

    const/4 v1, 0x0

    .line 402
    if-eqz p2, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 403
    if-eqz p2, :cond_2

    const/high16 v0, 0x41700000    # 15.0f

    :goto_1
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextSize(F)V

    .line 404
    const/4 v2, 0x0

    if-eqz p2, :cond_3

    const/4 v0, 0x1

    :goto_2
    invoke-virtual {p1, v2, v0}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 405
    if-eqz p2, :cond_4

    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {p0, v0, v1, v3, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    :goto_3
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 406
    instance-of v0, p1, Lcom/mrkeyboard/app/MrIconButton;

    if-eqz v0, :cond_0

    check-cast p1, Lcom/mrkeyboard/app/MrIconButton;

    const/high16 v0, 0x41800000    # 16.0f

    invoke-virtual {p0, p3, v0}, Lcom/mrkeyboard/app/MrKit;->icon(Ljava/lang/String;F)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    const/high16 v1, 0x41000000    # 8.0f

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-virtual {p1, v0, v1}, Lcom/mrkeyboard/app/MrIconButton;->setIcon(Landroid/graphics/drawable/Drawable;I)V

    .line 407
    :cond_0
    return-void

    .line 402
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    goto :goto_0

    .line 403
    :cond_2
    const/high16 v0, 0x41600000    # 14.0f

    goto :goto_1

    :cond_3
    move v0, v1

    .line 404
    goto :goto_2

    .line 405
    :cond_4
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->faint:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->line:I

    invoke-virtual {p0, v0, v2, v3, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    goto :goto_3
.end method

.method round(IIFZ)Landroid/graphics/drawable/GradientDrawable;
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 92
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 93
    if-eqz p4, :cond_1

    invoke-virtual {v0, v2}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 95
    :goto_0
    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 96
    if-eqz p2, :cond_0

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-virtual {v0, v1, p2}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 97
    :cond_0
    return-object v0

    .line 94
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
    .line 117
    new-instance v0, Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 118
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 119
    const/16 v1, 0x10

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 120
    return-object v0
.end method

.method scrollable(Landroid/widget/EditText;II)V
    .locals 1

    .prologue
    .line 303
    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setMinLines(I)V

    .line 304
    invoke-virtual {p1, p3}, Landroid/widget/EditText;->setMaxLines(I)V

    .line 305
    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setVerticalScrollBarEnabled(Z)V

    .line 306
    new-instance v0, Lcom/mrkeyboard/app/MrKit$3;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrKit$3;-><init>(Lcom/mrkeyboard/app/MrKit;)V

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 316
    return-void
.end method

.method select(Ljava/lang/String;Ljava/lang/String;Landroid/graphics/drawable/Drawable;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;
    .locals 9

    .prologue
    const/high16 v8, 0x41e00000    # 28.0f

    const/high16 v7, 0x41800000    # 16.0f

    const/high16 v5, 0x41500000    # 13.0f

    const/high16 v6, 0x41400000    # 12.0f

    const/4 v1, 0x0

    .line 197
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v2

    .line 198
    invoke-virtual {p0, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    const/high16 v4, 0x41600000    # 14.0f

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v2, v0, v3, v4, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 199
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->faint:I

    iget v3, p0, Lcom/mrkeyboard/app/MrKit;->line:I

    invoke-virtual {p0, v0, v3, v6, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 200
    const/4 v0, 0x1

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 201
    invoke-virtual {v2, p4}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 202
    if-eqz p3, :cond_0

    .line 203
    new-instance v0, Landroid/widget/ImageView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-direct {v0, v3}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 204
    invoke-virtual {v0, p3}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 205
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-virtual {p0, v8}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {p0, v8}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-direct {v3, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 206
    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v3, v1, v1, v4, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 207
    invoke-virtual {v2, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 209
    :cond_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v3

    .line 210
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_2

    const/4 v0, 0x1

    .line 211
    :goto_0
    if-eqz v0, :cond_1

    iget v4, p0, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {p0, p1, v6, v4, v1}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 212
    :cond_1
    iget v4, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {p0, p2, v7, v4, v1}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    if-eqz v0, :cond_3

    const/4 v0, 0x2

    :goto_1
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v3, v4, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 213
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, -0x2

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v0, v1, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 214
    const-string v0, "mr_ui_ic_chev_down"

    const/high16 v1, 0x41900000    # 18.0f

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrKit;->iconView(Ljava/lang/String;F)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 215
    return-object v2

    :cond_2
    move v0, v1

    .line 210
    goto :goto_0

    :cond_3
    move v0, v1

    .line 212
    goto :goto_1
.end method

.method select(Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;
    .locals 1

    .prologue
    .line 192
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0, p3}, Lcom/mrkeyboard/app/MrKit;->select(Ljava/lang/String;Ljava/lang/String;Landroid/graphics/drawable/Drawable;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    return-object v0
.end method

.method solidBg()I
    .locals 1

    .prologue
    .line 74
    const-string v0, "mr_ui_bg"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrKit;->color(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method stat(ILjava/lang/String;)Landroid/widget/LinearLayout;
    .locals 9

    .prologue
    const/4 v8, 0x2

    const/4 v7, 0x1

    const/high16 v3, 0x41000000    # 8.0f

    const/4 v6, 0x0

    const/high16 v5, 0x41400000    # 12.0f

    .line 414
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 415
    invoke-virtual {v1, v7}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 416
    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v1, v0, v2, v3, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 417
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->raised:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->line:I

    const/high16 v3, 0x41600000    # 14.0f

    invoke-virtual {p0, v0, v2, v3, v6}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 418
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    const/high16 v3, 0x41c00000    # 24.0f

    if-lez p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->accent:I

    :goto_0
    invoke-virtual {p0, v2, v3, v0, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 419
    const/16 v2, 0x11

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 420
    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 421
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {p0, p2, v5, v0, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 422
    const/16 v2, 0x11

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 423
    invoke-virtual {v0, v8}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 424
    invoke-virtual {p0, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 425
    return-object v1

    .line 418
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->hint:I

    goto :goto_0
.end method

.method varargs t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 83
    iget-object v0, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-static {v0, p1, p2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 84
    if-eqz v0, :cond_0

    move-object p1, v0

    :cond_0
    return-object p1
.end method

.method tabChip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;
    .locals 7

    .prologue
    const/high16 v6, 0x41600000    # 14.0f

    const/high16 v4, 0x41100000    # 9.0f

    const/high16 v3, 0x40c00000    # 6.0f

    const/4 v5, 0x0

    .line 465
    const/high16 v1, 0x41500000    # 13.0f

    if-eqz p2, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    :goto_0
    invoke-virtual {p0, p1, v1, v0, p2}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 466
    const/16 v0, 0x11

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setGravity(I)V

    .line 467
    const/4 v0, 0x2

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 468
    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v1, v0, v2, v3, v4}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 469
    if-eqz p2, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {p0, v0, v5, v6, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    :goto_1
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 470
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setClickable(Z)V

    .line 471
    invoke-virtual {v1, p3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 472
    return-object v1

    .line 465
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    goto :goto_0

    .line 469
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrKit;->card:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    invoke-virtual {p0, v0, v2, v6, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    goto :goto_1
.end method

.method table()Landroid/widget/LinearLayout;
    .locals 5

    .prologue
    .line 477
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 478
    iget v1, p0, Lcom/mrkeyboard/app/MrKit;->card:I

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    const/high16 v3, 0x41600000    # 14.0f

    const/4 v4, 0x0

    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 479
    return-object v0
.end method

.method tableRow(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;Landroid/view/View$OnClickListener;)V
    .locals 9

    .prologue
    const/4 v8, -0x1

    const/4 v7, -0x2

    const/high16 v5, 0x41400000    # 12.0f

    const/4 v6, 0x0

    .line 488
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v0

    if-lez v0, :cond_0

    .line 489
    new-instance v0, Landroid/view/View;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 490
    iget v1, p0, Lcom/mrkeyboard/app/MrKit;->line:I

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V

    .line 491
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrKit;->hair()I

    move-result v1

    invoke-virtual {p0, v8, v1, v6}, Lcom/mrkeyboard/app/MrKit;->lp(III)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 493
    :cond_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 494
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 495
    invoke-virtual {v0, p4}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 496
    const/high16 v1, 0x41800000    # 16.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {p0, p2, v1, v2, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 497
    const/high16 v2, 0x41600000    # 14.0f

    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {p0, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 498
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-direct {v2, v6, v7, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 499
    if-eqz p3, :cond_1

    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_1

    .line 500
    new-instance v1, Landroid/view/View;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-direct {v1, v2}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 501
    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    invoke-virtual {v1, v2}, Landroid/view/View;->setBackgroundColor(I)V

    .line 502
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrKit;->hair()I

    move-result v3

    invoke-direct {v2, v3, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 503
    const/high16 v1, 0x41700000    # 15.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {p0, p3, v1, v2, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 504
    const/16 v2, 0x11

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 505
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v3, 0x42600000    # 56.0f

    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-direct {v2, v3, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 507
    :cond_1
    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 508
    return-void
.end method

.method toast(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 88
    iget-object v0, p0, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    const/4 v1, 0x0

    invoke-static {v0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 89
    return-void
.end method

.method wide(I)Landroid/widget/LinearLayout$LayoutParams;
    .locals 2

    .prologue
    .line 107
    const/4 v0, -0x1

    const/4 v1, -0x2

    invoke-virtual {p0, v0, v1, p1}, Lcom/mrkeyboard/app/MrKit;->lp(III)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    return-object v0
.end method
