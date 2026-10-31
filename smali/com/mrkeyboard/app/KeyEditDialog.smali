.class public final Lcom/mrkeyboard/app/KeyEditDialog;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;,
        Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;
    }
.end annotation


# static fields
.field private static final TASKER_PRESETS:[Ljava/lang/String;

.field private static final WIDTH_PRESETS:[F


# direct methods
.method static constructor <clinit>()V
    .registers 10

    .line 24
    const-string v8, "clip"

    const-string v9, "notif"

    const-string v0, "wifi"

    const-string v1, "bt"

    const-string v2, "dados"

    const-string v3, "flash"

    const-string v4, "som"

    const-string v5, "brilho"

    const-string v6, "auto"

    const-string v7, "print"

    filled-new-array/range {v0 .. v9}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/KeyEditDialog;->TASKER_PRESETS:[Ljava/lang/String;

    .line 25
    const/4 v0, 0x5

    new-array v0, v0, [F

    fill-array-data v0, :array_24

    sput-object v0, Lcom/mrkeyboard/app/KeyEditDialog;->WIDTH_PRESETS:[F

    return-void

    nop

    :array_24
    .array-data 4
        0x3f000000    # 0.5f
        0x3f800000    # 1.0f
        0x3fc00000    # 1.5f
        0x40000000    # 2.0f
        0x40400000    # 3.0f
    .end array-data
.end method

.method private constructor <init>()V
    .registers 1

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;)V
    .registers 4

    .line 23
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/KeyEditDialog;->showSheetTargetDialog(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;)V

    return-void
.end method

.method static synthetic access$100(F)Ljava/lang/String;
    .registers 1

    .line 23
    invoke-static {p0}, Lcom/mrkeyboard/app/KeyEditDialog;->formatWidth(F)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$200(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;
    .registers 3

    .line 23
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/KeyEditDialog;->describeSheetTarget(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static describeSheetTarget(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;
    .registers 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 30
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result p0

    .line 31
    const-string v0, "prev"

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_14

    .line 32
    if-eqz p0, :cond_11

    const-string p0, "Folha anterior (ciclo)"

    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    goto :goto_13

    :cond_11
    const-string p0, "Previous sheet (cycle)"

    :goto_13
    return-object p0

    .line 34
    :cond_14
    const-string v0, "abc"

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_24

    .line 35
    if-eqz p0, :cond_21

    const-string p0, "ABC \u2014 Teclado principal"

    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    goto :goto_23

    :cond_21
    const-string p0, "ABC \u2014 Main keyboard"

    :goto_23
    return-object p0

    .line 37
    :cond_24
    if-eqz p1, :cond_60

    .line 38
    const/4 v0, 0x0

    :goto_27
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    if-ge v0, v1, :cond_60

    .line 39
    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 40
    iget-object v2, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v2, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5d

    .line 41
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p1, "["

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    iget-object p1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "] "

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    iget-object p1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 38
    :cond_5d
    add-int/lit8 v0, v0, 0x1

    goto :goto_27

    .line 45
    :cond_60
    if-eqz p0, :cond_65

    const-string p0, "Pr\u00f3xima folha (ciclo)"

    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    goto :goto_67

    :cond_65
    const-string p0, "Next sheet (cycle)"

    :goto_67
    return-object p0
.end method

.method private static formatWidth(F)Ljava/lang/String;
    .registers 4

    .line 49
    invoke-static {p0}, Ljava/lang/Math;->round(F)I

    move-result v0

    int-to-float v0, v0

    sub-float v0, p0, v0

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const v1, 0x3c23d70a    # 0.01f

    cmpg-float v0, v0, v1

    if-gez v0, :cond_23

    .line 50
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-static {p0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p0

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    const-string v1, "%.0fx"

    invoke-static {v0, v1, p0}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 52
    :cond_23
    const/high16 v0, 0x40000000    # 2.0f

    mul-float/2addr v0, p0

    .line 53
    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v2

    int-to-float v2, v2

    sub-float/2addr v0, v2

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    cmpg-float v0, v0, v1

    if-gez v0, :cond_45

    .line 54
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-static {p0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p0

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    const-string v1, "%.1fx"

    invoke-static {v0, v1, p0}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 56
    :cond_45
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-static {p0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p0

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    const-string v1, "%.2fx"

    invoke-static {v0, v1, p0}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static makeActionChip(Landroid/content/Context;Ljava/lang/String;ZZ)Landroid/widget/TextView;
    .registers 8

    .line 107
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 108
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 109
    const/high16 p1, 0x41400000    # 12.0f

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextSize(F)V

    .line 110
    sget-object p1, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 111
    const/16 p1, 0x11

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setGravity(I)V

    .line 112
    const/high16 p1, 0x40c00000    # 6.0f

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v1

    const/high16 v2, 0x41100000    # 9.0f

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result p1

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v2

    invoke-virtual {v0, v1, v3, p1, v2}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 113
    const/high16 p1, 0x41200000    # 10.0f

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result p1

    .line 114
    const/high16 v1, 0x3f800000    # 1.0f

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result p0

    const/4 v1, 0x1

    invoke-static {v1, p0}, Ljava/lang/Math;->max(II)I

    move-result p0

    .line 115
    const v1, -0xf5efe8

    if-nez p2, :cond_55

    .line 116
    const p3, -0xe5dacb

    invoke-static {v1, p1, p0, p3}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 117
    const p0, -0xc5b6a2

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_7e

    .line 118
    :cond_55
    if-eqz p3, :cond_6b

    .line 119
    const p3, 0x4dfb7185    # 5.27315104E8f

    const v1, 0x24fb7185

    invoke-static {v1, p1, p0, p3, v1}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 120
    const p0, -0x48e7b

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_7e

    .line 122
    :cond_6b
    const p3, -0xd5c4ac

    const v2, 0x3329c5f6

    invoke-static {v1, p1, p0, p3, v2}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 123
    const p0, -0x160f07

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 125
    :goto_7e
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setEnabled(Z)V

    .line 126
    return-object v0
.end method

.method private static makeSectionTitle(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;
    .registers 4

    .line 60
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 61
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 62
    const p1, -0x6c5c46

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 63
    const/high16 p1, 0x41400000    # 12.0f

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextSize(F)V

    .line 64
    sget-object v1, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 65
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result p1

    const/high16 v1, 0x40c00000    # 6.0f

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result p0

    const/4 v1, 0x0

    invoke-virtual {v0, v1, p1, v1, p0}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 66
    return-object v0
.end method

.method private static makeSelectButton(Landroid/content/Context;)Landroid/widget/TextView;
    .registers 8

    .line 70
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 71
    const v1, -0x160f07

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 72
    const/high16 v1, 0x41600000    # 14.0f

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V

    .line 73
    nop

    .line 75
    const/high16 v2, 0x41400000    # 12.0f

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v2

    .line 76
    const/high16 v3, 0x3f800000    # 1.0f

    invoke-static {p0, v3}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v3

    const/4 v4, 0x1

    invoke-static {v4, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    .line 73
    const v4, -0xf5efe8

    const v5, 0x4d29c5f6    # 1.78020192E8f

    const v6, 0x3329c5f6

    invoke-static {v4, v2, v3, v5, v6}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 80
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v1

    .line 81
    const/high16 v2, 0x41300000    # 11.0f

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result p0

    .line 82
    invoke-virtual {v0, v1, p0, v1, p0}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 83
    return-object v0
.end method

.method private static makeSmallPill(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;
    .registers 7

    .line 87
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 88
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 89
    const/high16 p1, 0x41400000    # 12.0f

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextSize(F)V

    .line 90
    sget-object p1, Lcom/mrkeyboard/app/SheetUi;->TF_MEDIUM:Landroid/graphics/Typeface;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 91
    const p1, -0xd63a0a

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 92
    nop

    .line 94
    const/high16 p1, 0x42c80000    # 100.0f

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result p1

    .line 95
    const/high16 v1, 0x3f800000    # 1.0f

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v1

    const/4 v2, 0x1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 92
    const v2, 0x2429c5f6

    const v3, 0x4d29c5f6    # 1.78020192E8f

    const v4, 0x3329c5f6

    invoke-static {v2, p1, v1, v3, v4}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 99
    const/high16 p1, 0x41300000    # 11.0f

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v1

    const/high16 v2, 0x40a00000    # 5.0f

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result p1

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v2

    invoke-virtual {v0, v1, v3, p1, v2}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 100
    new-instance p1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x2

    invoke-direct {p1, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 101
    const/high16 v1, 0x40c00000    # 6.0f

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result p0

    iput p0, p1, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    .line 102
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 103
    return-object v0
.end method

.method private static parseSafeInt(Ljava/lang/String;I)I
    .registers 2

    .line 130
    if-nez p0, :cond_3

    return p1

    .line 132
    :cond_3
    :try_start_3
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_b} :catch_c

    return p0

    .line 133
    :catch_c
    move-exception p0

    .line 134
    return p1
.end method

.method public static show(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
    .registers 17
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            "ZZZZ",
            "Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;",
            ")V"
        }
    .end annotation

    .line 148
    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v4, p3

    move v5, p4

    move v6, p5

    move v7, p6

    move-object/from16 v8, p7

    invoke-static/range {v0 .. v8}, Lcom/mrkeyboard/app/KeyEditDialog;->showInternal(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V

    .line 149
    return-void
.end method

.method public static showForPopupItem(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
    .registers 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            "Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;",
            ")V"
        }
    .end annotation

    .line 152
    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v8, p3

    invoke-static/range {v0 .. v8}, Lcom/mrkeyboard/app/KeyEditDialog;->showInternal(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V

    .line 153
    return-void
.end method

.method private static showInternal(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
    .registers 42
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            "ZZZZZ",
            "Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;",
            ")V"
        }
    .end annotation

    .line 166
    move-object/from16 v15, p0

    move-object/from16 v14, p8

    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v13

    .line 167
    const-string v0, "text"

    const-string v6, ""

    if-eqz p2, :cond_13

    invoke-virtual/range {p2 .. p2}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->deepCopy()Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v1

    goto :goto_1a

    :cond_13
    new-instance v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-direct {v1, v6, v0, v6, v2}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    :goto_1a
    move-object v12, v1

    .line 169
    new-instance v7, Landroid/widget/ScrollView;

    invoke-direct {v7, v15}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 170
    new-instance v8, Landroid/widget/LinearLayout;

    invoke-direct {v8, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 171
    const/4 v9, 0x1

    invoke-virtual {v8, v9}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 172
    const/high16 v1, 0x41900000    # 18.0f

    invoke-static {v15, v1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v2

    .line 173
    const/high16 v3, 0x41000000    # 8.0f

    invoke-static {v15, v3}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v4

    invoke-virtual {v8, v2, v2, v2, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 174
    invoke-virtual {v7, v8}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    .line 176
    new-instance v2, Landroid/widget/TextView;

    invoke-direct {v2, v15}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 177
    if-eqz p3, :cond_4a

    .line 178
    if-eqz v13, :cond_47

    const-string v4, "Editar item do popup"

    invoke-static/range {v4 .. v4}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    goto :goto_51

    :cond_47
    const-string v4, "Edit popup item"

    goto :goto_51

    .line 179
    :cond_4a
    if-eqz v13, :cond_4f

    const-string v4, "Editar tecla"

    invoke-static/range {v4 .. v4}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    goto :goto_51

    :cond_4f
    const-string v4, "Edit key"

    .line 177
    :goto_51
    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 180
    const v4, -0x160f07

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setTextColor(I)V

    .line 181
    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setTextSize(F)V

    .line 182
    sget-object v1, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 183
    invoke-virtual {v8, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 185
    if-eqz v13, :cond_6a

    const-string v1, "Tipo de a\u00e7\u00e3o"

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_6c

    :cond_6a
    const-string v1, "Action type"

    :goto_6c
    invoke-static {v15, v1}, Lcom/mrkeyboard/app/KeyEditDialog;->makeSectionTitle(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v8, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 186
    const-string v1, "sheet"

    const-string v2, "special"

    const-string v4, "tasker"

    if-eqz p3, :cond_81

    .line 187
    filled-new-array {v0, v4, v2, v1}, [Ljava/lang/String;

    move-result-object v5

    move-object v11, v5

    goto :goto_88

    .line 188
    :cond_81
    const-string v5, "spacer"

    filled-new-array {v0, v4, v2, v1, v5}, [Ljava/lang/String;

    move-result-object v5

    move-object v11, v5

    .line 189
    :goto_88
    const-string v5, "Ir p/ folha"

    invoke-static/range {v5 .. v5}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v10, "Sheet"

    const/16 v16, 0x3

    const-string v17, "Especial"

    invoke-static/range {v17 .. v17}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v17

    const-string v18, "Special"

    const/16 v19, 0x2

    const-string v20, "Tasker"

    const-string v21, "Texto"

    invoke-static/range {v21 .. v21}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v21

    const-string v22, "Text"

    const/4 v3, 0x4

    if-eqz p3, :cond_ba

    .line 190
    new-array v9, v3, [Ljava/lang/String;

    if-eqz v13, :cond_a2

    goto :goto_a4

    :cond_a2
    move-object/from16 v21, v22

    :goto_a4
    const/16 v22, 0x0

    aput-object v21, v9, v22

    const/16 v21, 0x1

    aput-object v20, v9, v21

    if-eqz v13, :cond_af

    goto :goto_b1

    :cond_af
    move-object/from16 v17, v18

    :goto_b1
    aput-object v17, v9, v19

    if-eqz v13, :cond_b6

    goto :goto_b7

    :cond_b6
    move-object v5, v10

    :goto_b7
    aput-object v5, v9, v16

    goto :goto_e0

    .line 191
    :cond_ba
    const/4 v9, 0x5

    new-array v9, v9, [Ljava/lang/String;

    if-eqz v13, :cond_c0

    goto :goto_c2

    :cond_c0
    move-object/from16 v21, v22

    :goto_c2
    const/16 v22, 0x0

    aput-object v21, v9, v22

    const/16 v21, 0x1

    aput-object v20, v9, v21

    if-eqz v13, :cond_cd

    goto :goto_cf

    :cond_cd
    move-object/from16 v17, v18

    :goto_cf
    aput-object v17, v9, v19

    if-eqz v13, :cond_d4

    goto :goto_d5

    :cond_d4
    move-object v5, v10

    :goto_d5
    aput-object v5, v9, v16

    if-eqz v13, :cond_dc

    const-string v5, "Separador"

    invoke-static/range {v5 .. v5}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    goto :goto_de

    :cond_dc
    const-string v5, "Spacer"

    :goto_de
    aput-object v5, v9, v3

    .line 193
    :goto_e0
    new-instance v5, Landroid/widget/HorizontalScrollView;

    invoke-direct {v5, v15}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;)V

    .line 194
    const/4 v10, 0x0

    invoke-virtual {v5, v10}, Landroid/widget/HorizontalScrollView;->setHorizontalScrollBarEnabled(Z)V

    .line 195
    new-instance v3, Landroid/widget/LinearLayout;

    invoke-direct {v3, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 196
    invoke-virtual {v3, v10}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 197
    invoke-virtual {v5, v3}, Landroid/widget/HorizontalScrollView;->addView(Landroid/view/View;)V

    .line 198
    invoke-virtual {v8, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 200
    array-length v5, v11

    new-array v10, v5, [Landroid/widget/TextView;

    .line 201
    const/4 v5, 0x0

    :goto_fb
    array-length v14, v11

    move-object/from16 v17, v11

    if-ge v5, v14, :cond_155

    .line 202
    new-instance v14, Landroid/widget/TextView;

    invoke-direct {v14, v15}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 203
    aget-object v11, v9, v5

    invoke-virtual {v14, v11}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 204
    const/high16 v11, 0x41400000    # 12.0f

    invoke-virtual {v14, v11}, Landroid/widget/TextView;->setTextSize(F)V

    .line 205
    sget-object v11, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v14, v11}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 206
    move-object/from16 v21, v9

    const/high16 v11, 0x41400000    # 12.0f

    invoke-static {v15, v11}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v9

    move-object/from16 v25, v6

    move-object/from16 v22, v7

    const/high16 v7, 0x41000000    # 8.0f

    invoke-static {v15, v7}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v6

    invoke-static {v15, v11}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v11

    move-object/from16 p2, v1

    invoke-static {v15, v7}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v1

    invoke-virtual {v14, v9, v6, v11, v1}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 207
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x2

    invoke-direct {v1, v6, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 208
    const/high16 v6, 0x40c00000    # 6.0f

    invoke-static {v15, v6}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v6

    iput v6, v1, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    .line 209
    invoke-virtual {v3, v14, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 210
    aput-object v14, v10, v5

    .line 201
    add-int/lit8 v5, v5, 0x1

    move-object/from16 v1, p2

    move-object/from16 v14, p8

    move-object/from16 v11, v17

    move-object/from16 v9, v21

    move-object/from16 v7, v22

    move-object/from16 v6, v25

    goto :goto_fb

    .line 213
    :cond_155
    move-object/from16 p2, v1

    move-object/from16 v25, v6

    move-object/from16 v22, v7

    new-instance v6, Landroid/widget/LinearLayout;

    invoke-direct {v6, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 214
    const/4 v1, 0x1

    invoke-virtual {v6, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 215
    if-eqz v13, :cond_169

    const-string v1, "R\u00f3tulo vis\u00edvel na tecla"

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_16b

    :cond_169
    const-string v1, "Visible key label"

    :goto_16b
    invoke-static {v15, v1}, Lcom/mrkeyboard/app/KeyEditDialog;->makeSectionTitle(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v6, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 216
    if-eqz v13, :cond_177

    const-string v1, "Texto exibido no bot\u00e3o (auto se vazio)"

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_179

    :cond_177
    const-string v1, "Text shown on button (auto if empty)"

    :goto_179
    const/4 v3, 0x1

    invoke-static {v15, v1, v3}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v14

    .line 217
    iget-object v1, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    if-nez v1, :cond_185

    move-object/from16 v1, v25

    goto :goto_187

    :cond_185
    iget-object v1, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    :goto_187
    invoke-virtual {v14, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 218
    invoke-virtual {v6, v14}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 219
    invoke-virtual {v8, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 221
    new-instance v7, Landroid/widget/LinearLayout;

    invoke-direct {v7, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 222
    const/4 v1, 0x1

    invoke-virtual {v7, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 223
    if-eqz v13, :cond_19e

    const-string v1, "Texto inserido ao tocar"

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_1a0

    :cond_19e
    const-string v1, "Text committed on tap"

    :goto_1a0
    invoke-static {v15, v1}, Lcom/mrkeyboard/app/KeyEditDialog;->makeSectionTitle(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v7, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 224
    if-eqz v13, :cond_1ac

    const-string v1, "Caractere, tag HTML ou frase completa..."

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_1ae

    :cond_1ac
    const-string v1, "Character, HTML tag or phrase..."

    :goto_1ae
    const/4 v3, 0x0

    invoke-static {v15, v1, v3}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v11

    .line 225
    const/4 v1, 0x4

    invoke-virtual {v11, v1}, Landroid/widget/EditText;->setMaxLines(I)V

    .line 226
    iget-object v1, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1cb

    .line 227
    iget-object v0, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    if-nez v0, :cond_1c6

    move-object/from16 v0, v25

    goto :goto_1c8

    :cond_1c6
    iget-object v0, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    :goto_1c8
    invoke-virtual {v11, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 229
    :cond_1cb
    invoke-virtual {v7, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 230
    invoke-virtual {v8, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 232
    new-instance v9, Landroid/widget/LinearLayout;

    invoke-direct {v9, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 233
    const/4 v0, 0x1

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 234
    if-eqz v13, :cond_1df

    const-string v0, "Comando Tasker (prefixo tskcmd: autom\u00e1tico)"

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1e1

    :cond_1df
    const-string v0, "Tasker command (auto tskcmd: prefix)"

    :goto_1e1
    invoke-static {v15, v0}, Lcom/mrkeyboard/app/KeyEditDialog;->makeSectionTitle(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 235
    if-eqz v13, :cond_1ed

    const-string v0, "Ex.: wifi, bt, flash, meu_perfil"

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1ef

    :cond_1ed
    const-string v0, "E.g.: wifi, bt, flash, my_task"

    :goto_1ef
    const/4 v1, 0x1

    invoke-static {v15, v0, v1}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v5

    .line 236
    iget-object v0, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_205

    .line 237
    iget-object v0, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetModel;->stripTaskerPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 239
    :cond_205
    invoke-virtual {v9, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 241
    new-instance v0, Landroid/widget/HorizontalScrollView;

    invoke-direct {v0, v15}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;)V

    .line 242
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/HorizontalScrollView;->setHorizontalScrollBarEnabled(Z)V

    .line 243
    new-instance v3, Landroid/widget/LinearLayout;

    invoke-direct {v3, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 244
    invoke-virtual {v3, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 245
    const/high16 v4, 0x40e00000    # 7.0f

    invoke-static {v15, v4}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v4

    invoke-virtual {v3, v1, v4, v1, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 246
    const/4 v1, 0x0

    :goto_223
    sget-object v4, Lcom/mrkeyboard/app/KeyEditDialog;->TASKER_PRESETS:[Ljava/lang/String;

    array-length v4, v4

    if-ge v1, v4, :cond_246

    .line 247
    sget-object v4, Lcom/mrkeyboard/app/KeyEditDialog;->TASKER_PRESETS:[Ljava/lang/String;

    aget-object v4, v4, v1

    .line 248
    move-object/from16 v16, v7

    invoke-static {v15, v4}, Lcom/mrkeyboard/app/KeyEditDialog;->makeSmallPill(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v7

    .line 249
    move-object/from16 v21, v6

    new-instance v6, Lcom/mrkeyboard/app/KeyEditDialog$1;

    invoke-direct {v6, v5, v4, v14}, Lcom/mrkeyboard/app/KeyEditDialog$1;-><init>(Landroid/widget/EditText;Ljava/lang/String;Landroid/widget/EditText;)V

    invoke-virtual {v7, v6}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 258
    invoke-virtual {v3, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 246
    add-int/lit8 v1, v1, 0x1

    move-object/from16 v7, v16

    move-object/from16 v6, v21

    goto :goto_223

    .line 260
    :cond_246
    move-object/from16 v21, v6

    move-object/from16 v16, v7

    invoke-virtual {v0, v3}, Landroid/widget/HorizontalScrollView;->addView(Landroid/view/View;)V

    .line 261
    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 262
    invoke-virtual {v8, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 264
    new-instance v7, Landroid/widget/LinearLayout;

    invoke-direct {v7, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 265
    const/4 v0, 0x1

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 266
    if-eqz v13, :cond_261

    const-string v0, "Tecla especial selecionada"

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_263

    :cond_261
    const-string v0, "Selected special key"

    :goto_263
    invoke-static {v15, v0}, Lcom/mrkeyboard/app/KeyEditDialog;->makeSectionTitle(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 267
    const/4 v0, 0x1

    new-array v6, v0, [I

    .line 268
    iget-object v0, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_27e

    iget-object v0, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    const/16 v1, -0x15

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog;->parseSafeInt(Ljava/lang/String;I)I

    move-result v0

    goto :goto_280

    :cond_27e
    const/16 v0, -0x15

    :goto_280
    const/4 v1, 0x0

    aput v0, v6, v1

    .line 270
    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/KeyEditDialog;->makeSelectButton(Landroid/content/Context;)Landroid/widget/TextView;

    move-result-object v4

    .line 271
    new-instance v0, Lcom/mrkeyboard/app/KeyEditDialog$2;

    invoke-direct {v0, v15, v6, v4, v14}, Lcom/mrkeyboard/app/KeyEditDialog$2;-><init>(Landroid/content/Context;[ILandroid/widget/TextView;Landroid/widget/EditText;)V

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 288
    invoke-virtual {v7, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 289
    invoke-virtual {v8, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 291
    new-instance v3, Landroid/widget/LinearLayout;

    invoke-direct {v3, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 292
    const/4 v0, 0x1

    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 293
    if-eqz v13, :cond_2a3

    const-string v0, "Folha de destino"

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_2a5

    :cond_2a3
    const-string v0, "Target sheet"

    :goto_2a5
    invoke-static {v15, v0}, Lcom/mrkeyboard/app/KeyEditDialog;->makeSectionTitle(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 294
    const/4 v0, 0x1

    new-array v2, v0, [Ljava/lang/String;

    .line 295
    iget-object v0, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    move-object/from16 v1, p2

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2c8

    iget-object v0, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    if-eqz v0, :cond_2c8

    iget-object v0, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2c8

    .line 296
    iget-object v0, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    goto :goto_2ca

    .line 297
    :cond_2c8
    const-string v0, "next"

    :goto_2ca
    const/4 v1, 0x0

    aput-object v0, v2, v1

    .line 299
    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/KeyEditDialog;->makeSelectButton(Landroid/content/Context;)Landroid/widget/TextView;

    move-result-object v1

    .line 300
    new-instance v0, Lcom/mrkeyboard/app/KeyEditDialog$3;

    move-object/from16 p2, v0

    move-object/from16 v26, v1

    move-object/from16 v1, p0

    move-object/from16 v27, v2

    move-object/from16 v2, p1

    move-object/from16 v28, v7

    move-object v7, v3

    move-object/from16 v3, v27

    move-object/from16 v29, v4

    move-object/from16 v4, v26

    move-object/from16 v30, v5

    move-object v5, v14

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/KeyEditDialog$3;-><init>(Landroid/content/Context;Ljava/util/List;[Ljava/lang/String;Landroid/widget/TextView;Landroid/widget/EditText;)V

    move-object/from16 v5, v26

    invoke-virtual {v5, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 315
    invoke-virtual {v7, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 316
    invoke-virtual {v8, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 318
    new-instance v4, Landroid/widget/TextView;

    invoke-direct {v4, v15}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 319
    if-eqz v13, :cond_301

    .line 320
    const-string v0, "Cria um espa\u00e7o vazio invis\u00edvel nesta posi\u00e7\u00e3o do teclado real. Use o controle de largura abaixo para definir o tamanho do v\u00e3o."

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_303

    .line 321
    :cond_301
    const-string v0, "Creates an invisible empty gap on the live keyboard. Adjust the width below to size the gap."

    .line 319
    :goto_303
    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 322
    const v0, -0x6c5c46

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 323
    const/high16 v0, 0x41500000    # 13.0f

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setTextSize(F)V

    .line 324
    const/high16 v0, 0x41400000    # 12.0f

    invoke-static {v15, v0}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v0

    const/high16 v1, 0x40800000    # 4.0f

    invoke-static {v15, v1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v1

    const/4 v2, 0x0

    invoke-virtual {v4, v2, v0, v2, v1}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 325
    invoke-virtual {v8, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 327
    iget v0, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v0

    const/high16 v1, 0x3f000000    # 0.5f

    sub-float/2addr v0, v1

    const/high16 v1, 0x3e800000    # 0.25f

    div-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    filled-new-array {v0}, [I

    move-result-object v3

    .line 328
    if-nez p3, :cond_3c1

    .line 329
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 330
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 331
    move-object/from16 v1, v25

    invoke-static {v15, v1}, Lcom/mrkeyboard/app/KeyEditDialog;->makeSectionTitle(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v1

    .line 332
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 334
    new-instance v2, Landroid/widget/SeekBar;

    invoke-direct {v2, v15}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    .line 335
    move-object/from16 p2, v4

    const/16 v4, 0xe

    invoke-virtual {v2, v4}, Landroid/widget/SeekBar;->setMax(I)V

    .line 336
    move-object/from16 v26, v5

    move-object/from16 v19, v6

    const/4 v5, 0x0

    aget v6, v3, v5

    invoke-static {v4, v6}, Ljava/lang/Math;->min(II)I

    move-result v4

    invoke-static {v5, v4}, Ljava/lang/Math;->max(II)I

    move-result v4

    invoke-virtual {v2, v4}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 337
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 339
    new-instance v4, Landroid/widget/LinearLayout;

    invoke-direct {v4, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 340
    invoke-virtual {v4, v5}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 341
    const/high16 v6, 0x40a00000    # 5.0f

    invoke-static {v15, v6}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v6

    invoke-virtual {v4, v5, v6, v5, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 342
    const/4 v5, 0x0

    :goto_37f
    sget-object v6, Lcom/mrkeyboard/app/KeyEditDialog;->WIDTH_PRESETS:[F

    array-length v6, v6

    if-ge v5, v6, :cond_3a6

    .line 343
    sget-object v6, Lcom/mrkeyboard/app/KeyEditDialog;->WIDTH_PRESETS:[F

    aget v6, v6, v5

    .line 344
    move-object/from16 v25, v7

    invoke-static {v6}, Lcom/mrkeyboard/app/KeyEditDialog;->formatWidth(F)Ljava/lang/String;

    move-result-object v7

    invoke-static {v15, v7}, Lcom/mrkeyboard/app/KeyEditDialog;->makeSmallPill(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v7

    .line 345
    move-object/from16 v31, v9

    new-instance v9, Lcom/mrkeyboard/app/KeyEditDialog$4;

    invoke-direct {v9, v2, v6}, Lcom/mrkeyboard/app/KeyEditDialog$4;-><init>(Landroid/widget/SeekBar;F)V

    invoke-virtual {v7, v9}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 351
    invoke-virtual {v4, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 342
    add-int/lit8 v5, v5, 0x1

    move-object/from16 v7, v25

    move-object/from16 v9, v31

    goto :goto_37f

    .line 353
    :cond_3a6
    move-object/from16 v25, v7

    move-object/from16 v31, v9

    invoke-virtual {v0, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 355
    new-instance v4, Lcom/mrkeyboard/app/KeyEditDialog$5;

    invoke-direct {v4, v3, v1, v13}, Lcom/mrkeyboard/app/KeyEditDialog$5;-><init>([ILandroid/widget/TextView;Z)V

    .line 362
    invoke-interface {v4}, Ljava/lang/Runnable;->run()V

    .line 363
    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$6;

    invoke-direct {v1, v3, v4}, Lcom/mrkeyboard/app/KeyEditDialog$6;-><init>([ILjava/lang/Runnable;)V

    invoke-virtual {v2, v1}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 372
    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_3cb

    .line 328
    :cond_3c1
    move-object/from16 p2, v4

    move-object/from16 v26, v5

    move-object/from16 v19, v6

    move-object/from16 v25, v7

    move-object/from16 v31, v9

    .line 375
    :goto_3cb
    new-instance v9, Landroid/widget/LinearLayout;

    invoke-direct {v9, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 376
    const/4 v0, 0x1

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 377
    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/KeyEditDialog;->makeSelectButton(Landroid/content/Context;)Landroid/widget/TextView;

    move-result-object v0

    .line 378
    if-nez p3, :cond_3ee

    .line 379
    if-eqz v13, :cond_3df

    const-string v1, "Toque longo (popup)"

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_3e1

    :cond_3df
    const-string v1, "Long-press popup"

    :goto_3e1
    invoke-static {v15, v1}, Lcom/mrkeyboard/app/KeyEditDialog;->makeSectionTitle(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v9, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 380
    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 381
    invoke-virtual {v8, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 384
    :cond_3ee
    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$7;

    invoke-direct {v1, v12, v0, v13}, Lcom/mrkeyboard/app/KeyEditDialog$7;-><init>(Lcom/mrkeyboard/app/SheetModel$KeySpec;Landroid/widget/TextView;Z)V

    .line 396
    new-instance v2, Lcom/mrkeyboard/app/KeyEditDialog$8;

    move-object/from16 v7, p1

    invoke-direct {v2, v15, v7, v12, v1}, Lcom/mrkeyboard/app/KeyEditDialog$8;-><init>(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/Runnable;)V

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 409
    invoke-interface {v1}, Ljava/lang/Runnable;->run()V

    .line 411
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, v15}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 412
    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    .line 413
    if-eqz v13, :cond_40f

    const-string v1, "Salvar"

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_411

    :cond_40f
    const-string v1, "Save"

    :goto_411
    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 414
    if-eqz v13, :cond_41a

    const-string v1, "Cancelar"

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_41c

    :cond_41a
    const-string v1, "Cancel"

    :goto_41c
    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 415
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v6

    .line 417
    if-nez p3, :cond_4df

    .line 418
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 419
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 420
    const/16 v2, 0x10

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 421
    const/high16 v2, 0x41600000    # 14.0f

    invoke-static {v15, v2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v2

    const/high16 v4, 0x40800000    # 4.0f

    invoke-static {v15, v4}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v1, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 423
    const-string v2, "\u2190"

    move/from16 v4, p4

    invoke-static {v15, v2, v4, v1}, Lcom/mrkeyboard/app/KeyEditDialog;->makeActionChip(Landroid/content/Context;Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object v2

    .line 424
    new-instance v4, Lcom/mrkeyboard/app/KeyEditDialog$9;

    move-object/from16 v5, p8

    invoke-direct {v4, v6, v5}, Lcom/mrkeyboard/app/KeyEditDialog$9;-><init>(Landroid/app/AlertDialog;Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 431
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    move-object/from16 v22, v3

    const v3, 0x3f333333    # 0.7f

    const/4 v7, -0x2

    invoke-direct {v4, v1, v7, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 433
    const-string v2, "\u2192"

    move/from16 v3, p5

    invoke-static {v15, v2, v3, v1}, Lcom/mrkeyboard/app/KeyEditDialog;->makeActionChip(Landroid/content/Context;Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object v2

    .line 434
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const v4, 0x3f333333    # 0.7f

    invoke-direct {v3, v1, v7, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 435
    const/high16 v1, 0x40c00000    # 6.0f

    invoke-static {v15, v1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v4

    iput v4, v3, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    .line 436
    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$10;

    invoke-direct {v1, v6, v5}, Lcom/mrkeyboard/app/KeyEditDialog$10;-><init>(Landroid/app/AlertDialog;Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 443
    invoke-virtual {v0, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 445
    if-eqz v13, :cond_48b

    const-string v1, "Duplicar"

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_48d

    :cond_48b
    const-string v1, "Duplicate"

    :goto_48d
    move/from16 v2, p6

    const/4 v3, 0x0

    invoke-static {v15, v1, v2, v3}, Lcom/mrkeyboard/app/KeyEditDialog;->makeActionChip(Landroid/content/Context;Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object v1

    .line 446
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const v4, 0x3f99999a    # 1.2f

    const/4 v7, -0x2

    invoke-direct {v2, v3, v7, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 447
    const/high16 v3, 0x40c00000    # 6.0f

    invoke-static {v15, v3}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v4

    iput v4, v2, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    .line 448
    new-instance v3, Lcom/mrkeyboard/app/KeyEditDialog$11;

    invoke-direct {v3, v6, v5}, Lcom/mrkeyboard/app/KeyEditDialog$11;-><init>(Landroid/app/AlertDialog;Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 455
    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 457
    if-eqz v13, :cond_4b5

    const-string v1, "Excluir"

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_4b7

    :cond_4b5
    const-string v1, "Delete"

    :goto_4b7
    move/from16 v2, p7

    const/4 v3, 0x1

    invoke-static {v15, v1, v2, v3}, Lcom/mrkeyboard/app/KeyEditDialog;->makeActionChip(Landroid/content/Context;Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object v1

    .line 458
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const v3, 0x3f8ccccd    # 1.1f

    const/4 v4, -0x2

    const/4 v7, 0x0

    invoke-direct {v2, v7, v4, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 459
    const/high16 v3, 0x40c00000    # 6.0f

    invoke-static {v15, v3}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v3

    iput v3, v2, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    .line 460
    new-instance v3, Lcom/mrkeyboard/app/KeyEditDialog$12;

    invoke-direct {v3, v6, v5}, Lcom/mrkeyboard/app/KeyEditDialog$12;-><init>(Landroid/app/AlertDialog;Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 467
    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 468
    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto :goto_4e3

    .line 417
    :cond_4df
    move-object/from16 v5, p8

    move-object/from16 v22, v3

    .line 471
    :goto_4e3
    const/4 v0, 0x1

    new-array v1, v0, [Z

    iget-object v2, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    if-eqz v2, :cond_4ff

    iget-object v2, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    .line 472
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_4ff

    iget-object v2, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    iget-object v3, v12, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4fd

    goto :goto_4ff

    :cond_4fd
    const/4 v0, 0x0

    goto :goto_500

    :cond_4ff
    :goto_4ff
    nop

    :goto_500
    const/16 v18, 0x0

    aput-boolean v0, v1, v18

    .line 474
    new-instance v0, Lcom/mrkeyboard/app/KeyEditDialog$13;

    invoke-direct {v0, v11, v1}, Lcom/mrkeyboard/app/KeyEditDialog$13;-><init>(Landroid/widget/EditText;[Z)V

    invoke-virtual {v14, v0}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 484
    new-instance v0, Lcom/mrkeyboard/app/KeyEditDialog$14;

    invoke-direct {v0, v1, v14}, Lcom/mrkeyboard/app/KeyEditDialog$14;-><init>([ZLandroid/widget/EditText;)V

    invoke-virtual {v11, v0}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 496
    new-instance v20, Lcom/mrkeyboard/app/KeyEditDialog$15;

    move-object/from16 v0, v20

    move-object/from16 v1, p0

    move-object/from16 v2, v17

    move-object v3, v12

    move-object/from16 v23, p2

    move-object v4, v10

    move-object/from16 v24, v26

    move-object/from16 v5, v21

    move-object v8, v6

    move-object/from16 v6, v16

    move-object/from16 v21, v25

    move-object/from16 v16, v28

    move-object/from16 v7, v31

    move-object/from16 p2, v8

    move-object/from16 v8, v16

    move-object/from16 v16, v9

    move-object/from16 v9, v21

    move-object/from16 v21, v10

    move-object/from16 v10, v23

    move-object/from16 v23, v11

    move-object/from16 v32, v17

    move/from16 v11, p3

    move-object/from16 v25, v12

    move-object/from16 v12, v16

    move/from16 v26, v13

    move-object/from16 v13, v29

    move-object/from16 v28, v14

    move-object/from16 v14, v19

    move-object/from16 v15, v24

    move-object/from16 v16, p1

    move-object/from16 v17, v27

    invoke-direct/range {v0 .. v17}, Lcom/mrkeyboard/app/KeyEditDialog$15;-><init>(Landroid/content/Context;[Ljava/lang/String;Lcom/mrkeyboard/app/SheetModel$KeySpec;[Landroid/widget/TextView;Landroid/widget/LinearLayout;Landroid/widget/LinearLayout;Landroid/widget/LinearLayout;Landroid/widget/LinearLayout;Landroid/widget/LinearLayout;Landroid/widget/TextView;ZLandroid/widget/LinearLayout;Landroid/widget/TextView;[ILandroid/widget/TextView;Ljava/util/List;[Ljava/lang/String;)V

    .line 526
    move/from16 v0, v18

    :goto_556
    move-object/from16 v5, v32

    array-length v1, v5

    if-ge v0, v1, :cond_575

    .line 527
    aget-object v9, v5, v0

    .line 528
    aget-object v1, v21, v0

    new-instance v2, Lcom/mrkeyboard/app/KeyEditDialog$16;

    move-object v7, v2

    move-object/from16 v8, v25

    move-object/from16 v10, v28

    move-object/from16 v11, v19

    move-object/from16 v12, v20

    invoke-direct/range {v7 .. v12}, Lcom/mrkeyboard/app/KeyEditDialog$16;-><init>(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;Landroid/widget/EditText;[ILjava/lang/Runnable;)V

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 526
    add-int/lit8 v0, v0, 0x1

    move-object/from16 v32, v5

    goto :goto_556

    .line 539
    :cond_575
    invoke-interface/range {v20 .. v20}, Ljava/lang/Runnable;->run()V

    .line 541
    new-instance v14, Lcom/mrkeyboard/app/KeyEditDialog$17;

    move-object v0, v14

    move-object/from16 v1, p2

    move-object/from16 v2, v28

    move/from16 v3, p3

    move-object/from16 v4, v22

    move-object/from16 v5, v25

    move-object/from16 v6, v23

    move-object/from16 v7, p0

    move/from16 v8, v26

    move-object/from16 v9, v30

    move-object/from16 v10, v19

    move-object/from16 v11, v27

    move-object/from16 v12, p1

    move-object/from16 v13, p8

    invoke-direct/range {v0 .. v13}, Lcom/mrkeyboard/app/KeyEditDialog$17;-><init>(Landroid/app/AlertDialog;Landroid/widget/EditText;Z[ILcom/mrkeyboard/app/SheetModel$KeySpec;Landroid/widget/EditText;Landroid/content/Context;ZLandroid/widget/EditText;[I[Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V

    move-object/from16 v0, p2

    invoke-virtual {v0, v14}, Landroid/app/AlertDialog;->setOnShowListener(Landroid/content/DialogInterface$OnShowListener;)V

    .line 594
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 595
    return-void
.end method

.method private static showSheetTargetDialog(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;)V
    .registers 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Ljava/lang/String;",
            "Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;",
            ")V"
        }
    .end annotation

    .line 598
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 599
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 600
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 601
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 603
    const-string v4, "next"

    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 604
    const-string v4, "123\u25b8"

    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 605
    if-eqz v0, :cond_22

    const-string v4, "Pr\u00f3xima folha (ciclo)"

    invoke-static/range {v4 .. v4}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    goto :goto_24

    :cond_22
    const-string v4, "Next sheet (cycle)"

    :goto_24
    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 607
    const-string v4, "prev"

    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 608
    const-string v4, "\u25c2123"

    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 609
    if-eqz v0, :cond_36

    const-string v4, "Folha anterior (ciclo)"

    invoke-static/range {v4 .. v4}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    goto :goto_38

    :cond_36
    const-string v4, "Previous sheet (cycle)"

    :goto_38
    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 611
    const-string v4, "abc"

    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 612
    const-string v4, "ABC"

    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 613
    if-eqz v0, :cond_4a

    const-string v4, "ABC \u2014 Teclado principal"

    invoke-static/range {v4 .. v4}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    goto :goto_4c

    :cond_4a
    const-string v4, "ABC \u2014 Main keyboard"

    :goto_4c
    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 615
    const/4 v4, 0x0

    if-eqz p1, :cond_90

    .line 616
    move v5, v4

    :goto_53
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v6

    if-ge v5, v6, :cond_90

    .line 617
    invoke-interface {p1, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 618
    iget-object v7, v6, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v1, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 619
    iget-object v7, v6, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-virtual {v2, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 620
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "["

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, v6, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "] "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v6, v6, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 616
    add-int/lit8 v5, v5, 0x1

    goto :goto_53

    .line 624
    :cond_90
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result p1

    new-array p1, p1, [Ljava/lang/CharSequence;

    .line 625
    nop

    .line 626
    move v5, v4

    :goto_98
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v6

    if-ge v4, v6, :cond_b6

    .line 627
    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/CharSequence;

    aput-object v6, p1, v4

    .line 628
    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-virtual {v6, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_b3

    .line 629
    move v5, v4

    .line 626
    :cond_b3
    add-int/lit8 v4, v4, 0x1

    goto :goto_98

    .line 633
    :cond_b6
    new-instance p2, Landroid/app/AlertDialog$Builder;

    invoke-direct {p2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 634
    if-eqz v0, :cond_c0

    const-string p0, "Escolher folha de destino"

    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    goto :goto_c2

    :cond_c0
    const-string p0, "Choose target sheet"

    :goto_c2
    invoke-virtual {p2, p0}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    new-instance p2, Lcom/mrkeyboard/app/KeyEditDialog$18;

    invoke-direct {p2, p3, v1, v2, v3}, Lcom/mrkeyboard/app/KeyEditDialog$18;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    .line 635
    invoke-virtual {p0, p1, v5, p2}, Landroid/app/AlertDialog$Builder;->setSingleChoiceItems([Ljava/lang/CharSequence;ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    .line 642
    if-eqz v0, :cond_d4

    const-string p1, "Cancelar"

    invoke-static/range {p1 .. p1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_d6

    :cond_d4
    const-string p1, "Cancel"

    :goto_d6
    const/4 p2, 0x0

    invoke-virtual {p0, p1, p2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    .line 643
    invoke-virtual {p0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 644
    return-void
.end method
