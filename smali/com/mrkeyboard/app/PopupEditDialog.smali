.class public final Lcom/mrkeyboard/app/PopupEditDialog;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;,
        Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;
    }
.end annotation


# static fields
.field private static final MODE_CHARS:I = 0x1

.field private static final MODE_KEYS:I = 0x2

.field private static final MODE_NONE:I


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Landroid/content/Context;Landroid/widget/TextView;Z)V
    .registers 3

    .line 18
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/PopupEditDialog;->styleModeChip(Landroid/content/Context;Landroid/widget/TextView;Z)V

    return-void
.end method

.method static synthetic access$100(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;)V
    .registers 4

    .line 18
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/PopupEditDialog;->showSinglePopupItemEditor(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;)V

    return-void
.end method

.method static synthetic access$200(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;IILjava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;)Landroid/view/View;
    .registers 9

    .line 18
    invoke-static/range {p0 .. p8}, Lcom/mrkeyboard/app/PopupEditDialog;->buildPopupItemRow(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;IILjava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;)Landroid/view/View;

    move-result-object p0

    return-object p0
.end method

.method private static buildPopupItemRow(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;IILjava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;)Landroid/view/View;
    .registers 24
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            "II",
            "Ljava/lang/Runnable;",
            "Ljava/lang/Runnable;",
            "Ljava/lang/Runnable;",
            "Ljava/lang/Runnable;",
            ")",
            "Landroid/view/View;"
        }
    .end annotation

    .line 93
    move-object v0, p0

    move-object/from16 v1, p2

    move/from16 v2, p3

    new-instance v3, Landroid/widget/LinearLayout;

    invoke-direct {v3, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 94
    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 95
    const/16 v5, 0x10

    invoke-virtual {v3, v5}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 96
    const/high16 v5, 0x41200000    # 10.0f

    invoke-static {p0, v5}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v6

    const/high16 v7, 0x41000000    # 8.0f

    invoke-static {p0, v7}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v8

    invoke-static {p0, v7}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v9

    invoke-static {p0, v7}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v10

    invoke-virtual {v3, v6, v8, v9, v10}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 97
    nop

    .line 99
    invoke-static {p0, v5}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v6

    .line 100
    const/high16 v8, 0x3f800000    # 1.0f

    invoke-static {p0, v8}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v9

    const/4 v10, 0x1

    invoke-static {v10, v9}, Ljava/lang/Math;->max(II)I

    move-result v9

    .line 97
    const v11, -0xf5efe8

    const v12, -0xd5c4ac

    const v13, 0x3329c5f6

    invoke-static {v11, v6, v9, v12, v13}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object v6

    invoke-virtual {v3, v6}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 104
    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v9, -0x1

    const/4 v11, -0x2

    invoke-direct {v6, v9, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 105
    const/high16 v9, 0x40c00000    # 6.0f

    invoke-static {p0, v9}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v12

    iput v12, v6, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 106
    invoke-virtual {v3, v6}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 108
    new-instance v6, Landroid/widget/TextView;

    invoke-direct {v6, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 109
    move-object/from16 v12, p1

    invoke-static {v1, v12}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->effectiveDisplayLabel(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/util/List;)Ljava/lang/String;

    move-result-object v12

    .line 110
    invoke-virtual {v12}, Ljava/lang/String;->isEmpty()Z

    move-result v13

    if-eqz v13, :cond_6f

    const-string v12, "?"

    :cond_6f
    invoke-virtual {v6, v12}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 111
    const v12, -0xd63a0a

    invoke-virtual {v6, v12}, Landroid/widget/TextView;->setTextColor(I)V

    .line 112
    sget-object v12, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v6, v12}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 113
    const/high16 v12, 0x41500000    # 13.0f

    invoke-virtual {v6, v12}, Landroid/widget/TextView;->setTextSize(F)V

    .line 114
    invoke-static {p0, v7}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v12

    const/high16 v13, 0x40800000    # 4.0f

    invoke-static {p0, v13}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v14

    invoke-static {p0, v7}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v7

    invoke-static {p0, v13}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v13

    invoke-virtual {v6, v12, v14, v7, v13}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 115
    invoke-static {p0, v9}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v7

    invoke-static {p0, v8}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v12

    invoke-static {v10, v12}, Ljava/lang/Math;->max(II)I

    move-result v12

    const v13, 0x4d29c5f6    # 1.78020192E8f

    const v14, -0xfbefd8

    invoke-static {v14, v7, v12, v13}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v7

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 116
    invoke-virtual {v3, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 118
    new-instance v6, Landroid/widget/TextView;

    invoke-direct {v6, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 119
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/PopupEditDialog;->describeActionShort(Landroid/content/Context;Lcom/mrkeyboard/app/SheetModel$KeySpec;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v6, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 120
    const v1, -0x6c5c46

    invoke-virtual {v6, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 121
    const/high16 v1, 0x41400000    # 12.0f

    invoke-virtual {v6, v1}, Landroid/widget/TextView;->setTextSize(F)V

    .line 122
    invoke-static {p0, v5}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v1

    invoke-static {p0, v9}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v5

    invoke-virtual {v6, v1, v4, v5, v4}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 123
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v4, v11, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v3, v6, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 125
    new-instance v1, Lcom/mrkeyboard/app/PopupEditDialog$1;

    move-object/from16 v5, p7

    invoke-direct {v1, v5}, Lcom/mrkeyboard/app/PopupEditDialog$1;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v3, v1}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 132
    if-lez v2, :cond_eb

    move v1, v10

    goto :goto_ec

    :cond_eb
    move v1, v4

    :goto_ec
    const-string v5, "\u2191"

    invoke-static {p0, v5, v1, v4}, Lcom/mrkeyboard/app/PopupEditDialog;->makeIconBtn(Landroid/content/Context;Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object v1

    .line 133
    new-instance v5, Lcom/mrkeyboard/app/PopupEditDialog$2;

    move-object/from16 v6, p5

    invoke-direct {v5, v6}, Lcom/mrkeyboard/app/PopupEditDialog$2;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 139
    invoke-virtual {v3, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 141
    add-int/lit8 v1, p4, -0x1

    if-ge v2, v1, :cond_105

    move v1, v10

    goto :goto_106

    :cond_105
    move v1, v4

    :goto_106
    const-string v2, "\u2193"

    invoke-static {p0, v2, v1, v4}, Lcom/mrkeyboard/app/PopupEditDialog;->makeIconBtn(Landroid/content/Context;Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object v1

    .line 142
    new-instance v2, Lcom/mrkeyboard/app/PopupEditDialog$3;

    move-object/from16 v4, p6

    invoke-direct {v2, v4}, Lcom/mrkeyboard/app/PopupEditDialog$3;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 148
    invoke-virtual {v3, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 150
    const-string v1, "\u2715"

    invoke-static {p0, v1, v10, v10}, Lcom/mrkeyboard/app/PopupEditDialog;->makeIconBtn(Landroid/content/Context;Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object v0

    .line 151
    new-instance v1, Lcom/mrkeyboard/app/PopupEditDialog$4;

    move-object/from16 v2, p8

    invoke-direct {v1, v2}, Lcom/mrkeyboard/app/PopupEditDialog$4;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 157
    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 158
    return-object v3
.end method

.method public static describeActionShort(Landroid/content/Context;Lcom/mrkeyboard/app/SheetModel$KeySpec;)Ljava/lang/String;
    .registers 5

    .line 26
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 27
    const-string v1, "tasker"

    iget-object v2, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_24

    .line 28
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "tskcmd:"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    iget-object p1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 30
    :cond_24
    const-string v1, "special"

    iget-object v2, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_41

    .line 31
    nop

    .line 33
    :try_start_2f
    iget-object p1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1
    :try_end_39
    .catch Ljava/lang/Exception; {:try_start_2f .. :try_end_39} :catch_3a

    .line 34
    goto :goto_3c

    :catch_3a
    move-exception p1

    const/4 p1, 0x0

    .line 35
    :goto_3c
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SpecialKeyPicker;->describeCode(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 37
    :cond_41
    const-string p0, "sheet"

    iget-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_66

    .line 38
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz v0, :cond_55

    const-string v0, "Ir para: "

    goto :goto_57

    :cond_55
    const-string v0, "Go to: "

    :goto_57
    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    iget-object p1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 40
    :cond_66
    iget-object p0, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    if-nez p0, :cond_6d

    const-string p0, ""

    goto :goto_77

    :cond_6d
    iget-object p0, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    const-string p1, "\n"

    const-string v1, "\u21b5"

    invoke-virtual {p0, p1, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p0

    .line 41
    :goto_77
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz v0, :cond_81

    const-string v0, "Texto: "

    goto :goto_83

    :cond_81
    const-string v0, "Text: "

    :goto_83
    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static makeIconBtn(Landroid/content/Context;Ljava/lang/String;ZZ)Landroid/widget/TextView;
    .registers 9

    .line 66
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 67
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 68
    const/high16 p1, 0x41600000    # 14.0f

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextSize(F)V

    .line 69
    sget-object v1, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 70
    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V

    .line 71
    const/high16 v1, 0x41000000    # 8.0f

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v2

    const/high16 v3, 0x40a00000    # 5.0f

    invoke-static {p0, v3}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v4

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v1

    invoke-static {p0, v3}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-virtual {v0, v2, v4, v1, v3}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 72
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setEnabled(Z)V

    .line 73
    if-nez p2, :cond_3a

    .line 74
    const p0, -0xc5b6a2

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_56

    .line 76
    :cond_3a
    if-eqz p3, :cond_40

    const p2, -0x48e7b

    goto :goto_43

    :cond_40
    const p2, -0x160f07

    :goto_43
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 77
    if-eqz p3, :cond_4c

    const p2, 0x24fb7185

    goto :goto_4f

    :cond_4c
    const p2, 0x3329c5f6

    :goto_4f
    invoke-static {p0, p2, p1}, Lcom/mrkeyboard/app/SheetUi;->borderlessCircleRipple(Landroid/content/Context;IF)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 79
    :goto_56
    return-object v0
.end method

.method private static makeModeChip(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;
    .registers 6

    .line 45
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 46
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 47
    const/high16 p1, 0x41400000    # 12.0f

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextSize(F)V

    .line 48
    sget-object p1, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 49
    const/16 p1, 0x11

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setGravity(I)V

    .line 50
    const/high16 p1, 0x41000000    # 8.0f

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v1

    const/high16 v2, 0x41100000    # 9.0f

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result p1

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result p0

    invoke-virtual {v0, v1, v3, p1, p0}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 51
    return-object v0
.end method

.method public static show(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;)V
    .registers 33
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            ">;",
            "Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;",
            ")V"
        }
    .end annotation

    .line 168
    move-object/from16 v15, p0

    move-object/from16 v0, p3

    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v16

    .line 169
    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14}, Ljava/util/ArrayList;-><init>()V

    .line 170
    const/4 v13, 0x0

    if-eqz v0, :cond_29

    .line 171
    move v1, v13

    :goto_11
    invoke-interface/range {p3 .. p3}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_29

    .line 172
    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 173
    if-eqz v2, :cond_26

    invoke-virtual {v2}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->deepCopy()Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v2

    invoke-virtual {v14, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 171
    :cond_26
    add-int/lit8 v1, v1, 0x1

    goto :goto_11

    .line 176
    :cond_29
    const/4 v0, 0x1

    new-array v12, v0, [I

    .line 177
    invoke-virtual {v14}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_34

    const/4 v1, 0x2

    goto :goto_3f

    :cond_34
    if-eqz p2, :cond_3e

    invoke-virtual/range {p2 .. p2}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_3e

    move v1, v0

    goto :goto_3f

    :cond_3e
    move v1, v13

    :goto_3f
    aput v1, v12, v13

    .line 180
    new-instance v11, Landroid/widget/ScrollView;

    invoke-direct {v11, v15}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 181
    new-instance v1, Landroid/widget/LinearLayout;

    invoke-direct {v1, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 182
    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 183
    const/high16 v2, 0x41900000    # 18.0f

    invoke-static {v15, v2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v3

    .line 184
    const/high16 v4, 0x41200000    # 10.0f

    invoke-static {v15, v4}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v4

    invoke-virtual {v1, v3, v3, v3, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 185
    invoke-virtual {v11, v1}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    .line 187
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, v15}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 188
    if-eqz v16, :cond_6a

    const-string v4, "Popup no toque longo"

    goto :goto_6c

    :cond_6a
    const-string v4, "Long-press popup"

    :goto_6c
    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 189
    const v4, -0x160f07

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setTextColor(I)V

    .line 190
    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setTextSize(F)V

    .line 191
    sget-object v2, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 192
    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 194
    new-instance v2, Landroid/widget/TextView;

    invoke-direct {v2, v15}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 195
    if-eqz v16, :cond_8a

    const-string v3, "Escolha o que abre ao segurar esta tecla pressionada:"

    goto :goto_8c

    :cond_8a
    const-string v3, "Choose what opens when holding this key:"

    :goto_8c
    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 196
    const v3, -0x6c5c46

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 197
    const/high16 v4, 0x41480000    # 12.5f

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setTextSize(F)V

    .line 198
    const/high16 v4, 0x40800000    # 4.0f

    invoke-static {v15, v4}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v4

    const/high16 v5, 0x41400000    # 12.0f

    invoke-static {v15, v5}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v6

    invoke-virtual {v2, v13, v4, v13, v6}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 199
    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 201
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 202
    invoke-virtual {v2, v13}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 203
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x1

    const/4 v7, -0x2

    invoke-direct {v4, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 205
    if-eqz v16, :cond_c3

    const-string v4, "Nenhum"

    goto :goto_c5

    :cond_c3
    const-string v4, "None"

    :goto_c5
    invoke-static {v15, v4}, Lcom/mrkeyboard/app/PopupEditDialog;->makeModeChip(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v10

    .line 206
    if-eqz v16, :cond_ce

    const-string v4, "Caracteres"

    goto :goto_d0

    :cond_ce
    const-string v4, "Characters"

    :goto_d0
    invoke-static {v15, v4}, Lcom/mrkeyboard/app/PopupEditDialog;->makeModeChip(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v9

    .line 207
    if-eqz v16, :cond_d9

    const-string v4, "Teclas / A\u00e7\u00f5es"

    goto :goto_db

    :cond_d9
    const-string v4, "Action Keys"

    :goto_db
    invoke-static {v15, v4}, Lcom/mrkeyboard/app/PopupEditDialog;->makeModeChip(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v8

    .line 209
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v4, v13, v7, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 210
    const/high16 v6, 0x40c00000    # 6.0f

    invoke-static {v15, v6}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v3

    iput v3, v4, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    .line 211
    invoke-virtual {v2, v10, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 212
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v13, v7, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 213
    invoke-static {v15, v6}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v4

    iput v4, v3, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    .line 214
    invoke-virtual {v2, v9, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 215
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const v4, 0x3f933333    # 1.15f

    invoke-direct {v3, v13, v7, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v8, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 217
    new-instance v6, Landroid/widget/LinearLayout;

    invoke-direct {v6, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 218
    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 219
    const/high16 v2, 0x41600000    # 14.0f

    invoke-static {v15, v2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-virtual {v6, v13, v3, v13, v13}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 220
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, v15}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 221
    if-eqz v16, :cond_125

    .line 222
    const-string v4, "Digite uma sequ\u00eancia de caracteres (cada letra vira um bot\u00e3o no popup, ex.: \u00e1\u00e0\u00e2\u00e3\u00e4):"

    goto :goto_127

    .line 223
    :cond_125
    const-string v4, "Type a sequence of characters (each character becomes a popup button, e.g. \u00e1\u00e0\u00e2\u00e3\u00e4):"

    .line 221
    :goto_127
    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 224
    const v4, -0x6c5c46

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setTextColor(I)V

    .line 225
    const/high16 v4, 0x41500000    # 13.0f

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setTextSize(F)V

    .line 226
    invoke-virtual {v6, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 228
    if-eqz v16, :cond_13d

    const-string v3, "Ex.: \u00b9\u00b2\u00b3\u00a3\u00a2\u20ac\u00a5"

    goto :goto_13f

    :cond_13d
    const-string v3, "E.g.: \u00b9\u00b2\u00b3\u00a3\u00a2\u20ac\u00a5"

    :goto_13f
    invoke-static {v15, v3, v0}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v5

    .line 229
    if-nez p2, :cond_148

    const-string v3, ""

    goto :goto_14a

    :cond_148
    move-object/from16 v3, p2

    :goto_14a
    invoke-virtual {v5, v3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 230
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, -0x1

    invoke-direct {v3, v4, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 231
    const/high16 v4, 0x41000000    # 8.0f

    invoke-static {v15, v4}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v7

    iput v7, v3, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 232
    invoke-virtual {v6, v5, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 233
    invoke-virtual {v1, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 235
    new-instance v7, Landroid/widget/LinearLayout;

    invoke-direct {v7, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 236
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 237
    invoke-static {v15, v2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v2

    invoke-virtual {v7, v13, v2, v13, v13}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 238
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, v15}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 239
    const v2, -0x6c5c46

    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 240
    const/high16 v2, 0x41500000    # 13.0f

    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setTextSize(F)V

    .line 241
    invoke-virtual {v7, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 243
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, v15}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 244
    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 245
    invoke-static {v15, v4}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v0

    move-object/from16 p2, v3

    invoke-static {v15, v4}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v3

    invoke-virtual {v2, v13, v0, v13, v3}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 246
    invoke-virtual {v7, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 248
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, v15}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 249
    if-eqz v16, :cond_1a5

    const-string v0, "+ Adicionar item ao popup"

    goto :goto_1a7

    :cond_1a5
    const-string v0, "+ Add popup item"

    :goto_1a7
    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 250
    const v0, -0xfbebe4

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 251
    sget-object v0, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 252
    const/16 v0, 0x11

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setGravity(I)V

    .line 253
    const/high16 v0, 0x41400000    # 12.0f

    invoke-static {v15, v0}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v4

    const/high16 v13, 0x41300000    # 11.0f

    move-object/from16 v20, v2

    invoke-static {v15, v13}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v2

    move-object/from16 v21, v5

    invoke-static {v15, v0}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v5

    invoke-static {v15, v13}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v13

    invoke-virtual {v3, v4, v2, v5, v13}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 254
    invoke-static {v15, v0}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v0

    const v2, 0x3304141c

    const v4, -0xd63a0a

    const/4 v5, 0x0

    invoke-static {v4, v0, v5, v5, v2}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 255
    invoke-virtual {v7, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 256
    invoke-virtual {v1, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 258
    new-instance v13, Landroid/widget/TextView;

    invoke-direct {v13, v15}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 259
    if-eqz v16, :cond_1f7

    const-string v0, "Nenhum popup ser\u00e1 exibido ao segurar esta tecla."

    goto :goto_1f9

    :cond_1f7
    const-string v0, "No popup will appear when holding this key."

    :goto_1f9
    invoke-virtual {v13, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 260
    const v0, -0x907f67

    invoke-virtual {v13, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 261
    const/high16 v0, 0x41500000    # 13.0f

    invoke-virtual {v13, v0}, Landroid/widget/TextView;->setTextSize(F)V

    .line 262
    const/high16 v0, 0x41800000    # 16.0f

    invoke-static {v15, v0}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v0

    const/high16 v2, 0x41000000    # 8.0f

    invoke-static {v15, v2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v2

    const/4 v5, 0x0

    invoke-virtual {v13, v5, v0, v5, v2}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 263
    invoke-virtual {v1, v13}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 265
    const/4 v0, 0x1

    new-array v4, v0, [Ljava/lang/Runnable;

    .line 266
    new-instance v17, Lcom/mrkeyboard/app/PopupEditDialog$5;

    move-object/from16 v0, v17

    move-object/from16 v1, p0

    move-object/from16 v18, v20

    move-object v2, v10

    move-object/from16 v19, p2

    move-object/from16 p2, v3

    move-object v3, v12

    move-object/from16 p3, v4

    move-object v4, v9

    move/from16 v20, v5

    move-object/from16 v22, v21

    move-object v5, v8

    move-object/from16 v21, v6

    move-object v6, v13

    move-object v13, v7

    move-object/from16 v7, v21

    move-object/from16 v23, v8

    move-object v8, v13

    move-object v13, v9

    move-object/from16 v9, v19

    move-object/from16 v24, v10

    move/from16 v10, v16

    move-object/from16 v25, v11

    move-object v11, v14

    move-object/from16 v26, v12

    move-object/from16 v12, v18

    move-object/from16 v27, v13

    move/from16 v18, v20

    move-object/from16 v13, p1

    move-object/from16 v19, v14

    move-object/from16 v14, p3

    move-object/from16 v15, p2

    invoke-direct/range {v0 .. v15}, Lcom/mrkeyboard/app/PopupEditDialog$5;-><init>(Landroid/content/Context;Landroid/widget/TextView;[ILandroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;Landroid/widget/LinearLayout;Landroid/widget/TextView;ZLjava/util/ArrayList;Landroid/widget/LinearLayout;Ljava/util/List;[Ljava/lang/Runnable;Landroid/widget/TextView;)V

    move-object/from16 v6, p3

    aput-object v17, v6, v18

    .line 334
    new-instance v0, Lcom/mrkeyboard/app/PopupEditDialog$6;

    move-object/from16 v7, v26

    invoke-direct {v0, v7, v6}, Lcom/mrkeyboard/app/PopupEditDialog$6;-><init>([I[Ljava/lang/Runnable;)V

    move-object/from16 v1, v24

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 341
    new-instance v0, Lcom/mrkeyboard/app/PopupEditDialog$7;

    invoke-direct {v0, v7, v6}, Lcom/mrkeyboard/app/PopupEditDialog$7;-><init>([I[Ljava/lang/Runnable;)V

    move-object/from16 v1, v27

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 348
    new-instance v0, Lcom/mrkeyboard/app/PopupEditDialog$8;

    invoke-direct {v0, v7, v6}, Lcom/mrkeyboard/app/PopupEditDialog$8;-><init>([I[Ljava/lang/Runnable;)V

    move-object/from16 v1, v23

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 355
    new-instance v8, Lcom/mrkeyboard/app/PopupEditDialog$9;

    move-object v0, v8

    move-object/from16 v1, v19

    move-object/from16 v2, p0

    move/from16 v3, v16

    move-object/from16 v4, p1

    move-object v5, v6

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PopupEditDialog$9;-><init>(Ljava/util/ArrayList;Landroid/content/Context;ZLjava/util/List;[Ljava/lang/Runnable;)V

    move-object/from16 v0, p2

    invoke-virtual {v0, v8}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 372
    aget-object v0, v6, v18

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 373
    new-instance v0, Landroid/app/AlertDialog$Builder;

    move-object/from16 v1, p0

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 374
    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 375
    if-eqz v16, :cond_2a8

    const-string v1, "Concluir"

    goto :goto_2aa

    :cond_2a8
    const-string v1, "Done"

    :goto_2aa
    new-instance v2, Lcom/mrkeyboard/app/PopupEditDialog$10;

    move-object/from16 v3, p4

    move-object/from16 v4, v19

    move-object/from16 v5, v22

    invoke-direct {v2, v3, v7, v5, v4}, Lcom/mrkeyboard/app/PopupEditDialog$10;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;[ILandroid/widget/EditText;Ljava/util/ArrayList;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 389
    if-eqz v16, :cond_2be

    const-string v1, "Cancelar"

    goto :goto_2c0

    :cond_2be
    const-string v1, "Cancel"

    :goto_2c0
    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 390
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 391
    return-void
.end method

.method private static showSinglePopupItemEditor(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;)V
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            "Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;",
            ")V"
        }
    .end annotation

    .line 394
    new-instance v0, Lcom/mrkeyboard/app/PopupEditDialog$11;

    invoke-direct {v0, p3}, Lcom/mrkeyboard/app/PopupEditDialog$11;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;)V

    invoke-static {p0, p1, p2, v0}, Lcom/mrkeyboard/app/KeyEditDialog;->showForPopupItem(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V

    .line 404
    return-void
.end method

.method private static styleModeChip(Landroid/content/Context;Landroid/widget/TextView;Z)V
    .registers 6

    .line 55
    const/high16 v0, 0x41200000    # 10.0f

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v0

    .line 56
    if-eqz p2, :cond_1d

    .line 57
    const p0, -0xd63a0a

    const p2, 0x3304141c

    const/4 v1, 0x0

    invoke-static {p0, v0, v1, v1, p2}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 58
    const p0, -0xfbebe4

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_3e

    .line 60
    :cond_1d
    const/high16 p2, 0x3f800000    # 1.0f

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result p0

    const/4 p2, 0x1

    invoke-static {p2, p0}, Ljava/lang/Math;->max(II)I

    move-result p0

    const p2, -0xd5c4ac

    const v1, 0x3329c5f6

    const v2, -0xf5efe8

    invoke-static {v2, v0, p0, p2, v1}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 61
    const p0, -0x6c5c46

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 63
    :goto_3e
    return-void
.end method
