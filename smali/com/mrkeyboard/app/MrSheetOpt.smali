.class public final Lcom/mrkeyboard/app/MrSheetOpt;
.super Ljava/lang/Object;
.source "MrSheetOpt.java"


# static fields
.field static final KEY:Ljava/lang/String; = "pref_sheet_return"


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static color(Landroid/content/Context;Ljava/lang/String;)I
    .locals 3

    .prologue
    .line 32
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 33
    const-string v1, "color"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getColor(I)I

    move-result v0

    return v0
.end method

.method private static dp(Landroid/content/Context;F)I
    .locals 1

    .prologue
    .line 28
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr v0, p1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    return v0
.end method

.method public static row(Landroid/content/Context;)Landroid/view/View;
    .locals 10

    .prologue
    const/high16 v7, 0x41400000    # 12.0f

    const/high16 v9, 0x3f800000    # 1.0f

    const/high16 v8, 0x41600000    # 14.0f

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 37
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 39
    new-instance v4, Landroid/widget/LinearLayout;

    invoke-direct {v4, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 40
    invoke-virtual {v4, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 41
    const/16 v0, 0x10

    invoke-virtual {v4, v0}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 42
    invoke-static {p0, v8}, Lcom/mrkeyboard/app/MrSheetOpt;->dp(Landroid/content/Context;F)I

    move-result v0

    invoke-static {p0, v7}, Lcom/mrkeyboard/app/MrSheetOpt;->dp(Landroid/content/Context;F)I

    move-result v5

    invoke-static {p0, v8}, Lcom/mrkeyboard/app/MrSheetOpt;->dp(Landroid/content/Context;F)I

    move-result v6

    invoke-static {p0, v7}, Lcom/mrkeyboard/app/MrSheetOpt;->dp(Landroid/content/Context;F)I

    move-result v7

    invoke-virtual {v4, v0, v5, v6, v7}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 43
    new-instance v5, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v5}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 44
    instance-of v0, p0, Landroid/app/Activity;

    if-eqz v0, :cond_0

    move-object v0, p0

    check-cast v0, Landroid/app/Activity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrMatrix;->wanted(Landroid/app/Activity;)Z

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    .line 45
    :goto_0
    if-eqz v0, :cond_1

    const-string v0, "mr_ui_sunken_glass"

    :goto_1
    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrSheetOpt;->color(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v5, v0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 46
    const/high16 v0, 0x41800000    # 16.0f

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrSheetOpt;->dp(Landroid/content/Context;F)I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {v5, v0}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 47
    invoke-static {p0, v9}, Lcom/mrkeyboard/app/MrSheetOpt;->dp(Landroid/content/Context;F)I

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    const-string v6, "mr_ui_stroke"

    invoke-static {p0, v6}, Lcom/mrkeyboard/app/MrSheetOpt;->color(Landroid/content/Context;Ljava/lang/String;)I

    move-result v6

    invoke-virtual {v5, v0, v6}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 48
    invoke-virtual {v4, v5}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 50
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 51
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 52
    new-instance v5, Landroid/widget/TextView;

    invoke-direct {v5, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 53
    const-string v6, "title_sheet_return"

    new-array v7, v2, [Ljava/lang/Object;

    invoke-static {p0, v6, v7}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 54
    const-string v6, "mr_ui_text"

    invoke-static {p0, v6}, Lcom/mrkeyboard/app/MrSheetOpt;->color(Landroid/content/Context;Ljava/lang/String;)I

    move-result v6

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setTextColor(I)V

    .line 55
    const/high16 v6, 0x41680000    # 14.5f

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setTextSize(F)V

    .line 56
    const/4 v6, 0x0

    invoke-virtual {v5, v6, v1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 57
    new-instance v6, Landroid/widget/TextView;

    invoke-direct {v6, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 58
    const-string v7, "mr_ui_text2"

    invoke-static {p0, v7}, Lcom/mrkeyboard/app/MrSheetOpt;->color(Landroid/content/Context;Ljava/lang/String;)I

    move-result v7

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setTextColor(I)V

    .line 59
    const/high16 v7, 0x41480000    # 12.5f

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setTextSize(F)V

    .line 60
    invoke-virtual {v0, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 61
    invoke-virtual {v0, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 62
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v7, -0x2

    invoke-direct {v5, v2, v7, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v4, v0, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 64
    new-instance v5, Landroid/widget/Switch;

    invoke-direct {v5, p0}, Landroid/widget/Switch;-><init>(Landroid/content/Context;)V

    .line 65
    const-string v0, "pref_sheet_return"

    invoke-interface {v3, v0, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    .line 66
    invoke-virtual {v5, v0}, Landroid/widget/Switch;->setChecked(Z)V

    .line 67
    if-eqz v0, :cond_2

    const-string v0, "summary_sheet_return_true"

    :goto_2
    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 68
    new-instance v0, Lcom/mrkeyboard/app/MrSheetOpt$1;

    invoke-direct {v0, v3, v6, p0}, Lcom/mrkeyboard/app/MrSheetOpt$1;-><init>(Landroid/content/SharedPreferences;Landroid/widget/TextView;Landroid/content/Context;)V

    invoke-virtual {v5, v0}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 74
    invoke-virtual {v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 75
    new-instance v0, Lcom/mrkeyboard/app/MrSheetOpt$2;

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrSheetOpt$2;-><init>(Landroid/widget/Switch;)V

    invoke-virtual {v4, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 81
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x1

    const/4 v3, -0x2

    invoke-direct {v0, v1, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 83
    invoke-static {p0, v8}, Lcom/mrkeyboard/app/MrSheetOpt;->dp(Landroid/content/Context;F)I

    move-result v1

    const/high16 v3, 0x41200000    # 10.0f

    invoke-static {p0, v3}, Lcom/mrkeyboard/app/MrSheetOpt;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-virtual {v0, v2, v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 84
    invoke-virtual {v4, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 85
    return-object v4

    :cond_0
    move v0, v2

    .line 44
    goto/16 :goto_0

    .line 45
    :cond_1
    const-string v0, "mr_ui_sunken"

    goto/16 :goto_1

    .line 67
    :cond_2
    const-string v0, "summary_sheet_return_false"

    goto :goto_2
.end method
