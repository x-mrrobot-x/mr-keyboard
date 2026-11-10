.class public final Lcom/mrkeyboard/app/SheetUi;
.super Ljava/lang/Object;
.source "SheetUi.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/SheetUi$IconDrawable;,
        Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;,
        Lcom/mrkeyboard/app/SheetUi$MenuEntry;
    }
.end annotation


# static fields
.field public static final ICON_ARROW_DOWN:I = 0x7

.field public static final ICON_ARROW_UP:I = 0x6

.field public static final ICON_BACK:I = 0x2

.field public static final ICON_CLEAR:I = 0xe

.field public static final ICON_DELETE:I = 0xd

.field public static final ICON_DUPLICATE:I = 0x8

.field public static final ICON_EDIT_KEYS:I = 0x4

.field public static final ICON_EXPORT:I = 0xa

.field public static final ICON_IMPORT:I = 0xb

.field public static final ICON_KEYBOARD:I = 0x3

.field public static final ICON_LOCK:I = 0xf

.field public static final ICON_MORE_VERT:I = 0x1

.field public static final ICON_RENAME:I = 0x5

.field public static final ICON_RESTORE:I = 0xc

.field public static final ICON_ROWS:I = 0x9

.field public static final TF_MEDIUM:Landroid/graphics/Typeface;

.field public static final TONE_DANGER:I = 0x2

.field public static final TONE_NORMAL:I = 0x0

.field public static final TONE_WARNING:I = 0x1


# direct methods
.method static constructor <clinit>()V
    .registers 2

    .line 90
    const-string v0, "sans-serif-medium"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Landroid/graphics/Typeface;->create(Ljava/lang/String;I)Landroid/graphics/Typeface;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/SheetUi;->TF_MEDIUM:Landroid/graphics/Typeface;

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 92
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static borderlessCircleRipple(Landroid/content/Context;IF)Landroid/graphics/drawable/Drawable;
    .registers 4

    .line 120
    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result p0

    const/4 p2, 0x0

    const/4 v0, -0x1

    invoke-static {v0, p0, p2, p2}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p0

    .line 121
    new-instance p2, Landroid/graphics/drawable/RippleDrawable;

    invoke-static {p1}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object p1

    const/4 v0, 0x0

    invoke-direct {p2, p1, v0, p0}, Landroid/graphics/drawable/RippleDrawable;-><init>(Landroid/content/res/ColorStateList;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    return-object p2
.end method

.method public static dp(Landroid/content/Context;F)I
    .registers 2

    .line 95
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p0

    iget p0, p0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, p0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p0

    return p0
.end method

.method public static dpf(Landroid/content/Context;F)F
    .registers 2

    .line 99
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p0

    iget p0, p0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, p0

    return p1
.end method

.method public static editFieldBackground(Landroid/content/Context;F)Landroid/graphics/drawable/Drawable;
    .registers 5

    .line 125
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result p1

    .line 126
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v0

    const/4 v1, 0x1

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 127
    const/high16 v1, 0x3fc00000    # 1.5f

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result p0

    const/4 v1, 0x2

    invoke-static {v1, p0}, Ljava/lang/Math;->max(II)I

    move-result p0

    .line 128
    const v1, -0xe46804

    const v2, -0xf7eee1

    invoke-static {v2, p1, p0, v1}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p0

    .line 129
    const v1, -0xe0cbac

    invoke-static {v2, p1, v0, v1}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p1

    .line 130
    new-instance v0, Landroid/graphics/drawable/StateListDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/StateListDrawable;-><init>()V

    .line 131
    const v1, 0x101009c

    filled-new-array {v1}, [I

    move-result-object v1

    invoke-virtual {v0, v1, p0}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    .line 132
    const/4 p0, 0x0

    new-array p0, p0, [I

    invoke-virtual {v0, p0, p1}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    .line 133
    return-object v0
.end method

.method public static makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;
    .registers 4

    .line 137
    new-instance v0, Landroid/widget/EditText;

    invoke-direct {v0, p0}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 138
    if-eqz p1, :cond_a

    .line 139
    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    .line 141
    :cond_a
    const p1, -0x755b34

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setHintTextColor(I)V

    .line 142
    const p1, -0x1

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setTextColor(I)V

    .line 143
    const/high16 p1, 0x41700000    # 15.0f

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setTextSize(F)V

    .line 144
    invoke-virtual {v0, p2}, Landroid/widget/EditText;->setSingleLine(Z)V

    .line 145
    const/high16 p1, 0x41400000    # 12.0f

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->editFieldBackground(Landroid/content/Context;F)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 146
    const/high16 p1, 0x41600000    # 14.0f

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result p1

    .line 147
    const/high16 p2, 0x41300000    # 11.0f

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result p0

    .line 148
    invoke-virtual {v0, p1, p0, p1, p0}, Landroid/widget/EditText;->setPadding(IIII)V

    .line 149
    return-object v0
.end method

.method public static makeIconButton(Landroid/content/Context;IIILjava/lang/String;)Landroid/widget/ImageView;
    .registers 9

    .line 153
    new-instance v0, Landroid/widget/ImageView;

    invoke-direct {v0, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 154
    int-to-float p3, p3

    invoke-static {p0, p3}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v1

    .line 155
    const/high16 v2, 0x41a00000    # 20.0f

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v2

    .line 156
    new-instance v3, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    invoke-direct {v3, p0, p1, p2, v2}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    .line 157
    invoke-virtual {v0, v3}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 158
    sget-object p1, Landroid/widget/ImageView$ScaleType;->CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    .line 159
    const/high16 p1, 0x40000000    # 2.0f

    div-float/2addr p3, p1

    const p1, 0x331b97fc

    invoke-static {p0, p1, p3}, Lcom/mrkeyboard/app/SheetUi;->borderlessCircleRipple(Landroid/content/Context;IF)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 160
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setMinimumWidth(I)V

    .line 161
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setMinimumHeight(I)V

    .line 162
    if-eqz p4, :cond_35

    .line 163
    invoke-virtual {v0, p4}, Landroid/widget/ImageView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 165
    :cond_35
    return-object v0
.end method

.method public static rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;
    .registers 5

    .line 114
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p0

    .line 115
    const/4 p2, -0x1

    const/4 p3, 0x0

    invoke-static {p2, p1, p3, p3}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p1

    .line 116
    new-instance p2, Landroid/graphics/drawable/RippleDrawable;

    invoke-static {p4}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object p3

    invoke-direct {p2, p3, p0, p1}, Landroid/graphics/drawable/RippleDrawable;-><init>(Landroid/content/res/ColorStateList;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    return-object p2
.end method

.method public static roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;
    .registers 6

    .line 103
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 104
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 105
    invoke-virtual {v0, p0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 106
    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 107
    if-lez p2, :cond_14

    .line 108
    invoke-virtual {v0, p2, p3}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 110
    :cond_14
    return-object v0
.end method

.method public static showPopupMenu(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;)V
    .registers 25
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Landroid/view/View;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetUi$MenuEntry;",
            ">;",
            "Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;",
            ")V"
        }
    .end annotation

    .line 193
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v4, p4

    if-eqz v0, :cond_461

    if-eqz v1, :cond_461

    if-eqz v4, :cond_461

    invoke-interface/range {p4 .. p4}, Ljava/util/List;->isEmpty()Z

    move-result v5

    if-eqz v5, :cond_18

    goto/16 :goto_461

    .line 196
    :cond_18
    instance-of v5, v0, Landroid/app/Activity;

    if-eqz v5, :cond_26

    move-object v5, v0

    check-cast v5, Landroid/app/Activity;

    invoke-virtual {v5}, Landroid/app/Activity;->isFinishing()Z

    move-result v5

    if-eqz v5, :cond_26

    .line 197
    return-void

    .line 199
    :cond_26
    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v5

    if-nez v5, :cond_2d

    .line 200
    return-void

    .line 203
    :cond_2d
    const/high16 v5, 0x41200000    # 10.0f

    invoke-static {v0, v5}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v6

    .line 204
    new-instance v7, Landroid/widget/FrameLayout;

    invoke-direct {v7, v0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    .line 205
    invoke-virtual {v7, v6, v6, v6, v6}, Landroid/widget/FrameLayout;->setPadding(IIII)V

    .line 207
    new-instance v8, Landroid/widget/LinearLayout;

    invoke-direct {v8, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 208
    const/4 v9, 0x1

    invoke-virtual {v8, v9}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 209
    const/high16 v10, 0x41900000    # 18.0f

    invoke-static {v0, v10}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v11

    .line 210
    # Dialog WITHOUT border: stroke = 0. Slightly lighter background (0xFF1A2433) to
    # stand out from the background page (C_BG = 0xFF080C11).
    const v15, -0xe5dbcd    # 0xFF1A2433 (C_DIALOG_BG)

    const/4 v13, 0x0

    invoke-static {v15, v11, v13, v13}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v11

    invoke-virtual {v8, v11}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 211
    const/high16 v11, 0x41400000    # 12.0f

    invoke-static {v0, v11}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v11

    invoke-virtual {v8, v11}, Landroid/widget/LinearLayout;->setElevation(F)V

    .line 212
    # clipToOutline on + no border: there is no stroke to be clipped and the
    # dialog corners are always rounded (the header also draws its own).
    const/4 v9, 0x1

    invoke-virtual {v8, v9}, Landroid/widget/LinearLayout;->setClipToOutline(Z)V

    .line 214
    const v14, -0xe46804

    const/16 v10, 0x10

    const/high16 v15, 0x41300000    # 11.0f

    const/high16 v11, 0x41100000    # 9.0f

    const/high16 v13, 0x41600000    # 14.0f

    const/4 v9, 0x0

    # Menu header REMOVED: the dialog shows only the options (with subtle dividers
    # between the groups, marked by MenuEntry.dividerBefore).
    .line 214
    :cond_176
    const v13, 0x241b97fc

    .line 252
    :goto_179
    new-instance v2, Landroid/widget/ScrollView;

    invoke-direct {v2, v0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 253
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/ScrollView;->setVerticalScrollBarEnabled(Z)V

    .line 254
    new-instance v3, Landroid/widget/LinearLayout;

    invoke-direct {v3, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 255
    const/4 v5, 0x1

    invoke-virtual {v3, v5}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 256
    const/high16 v5, 0x40a00000    # 5.0f

    invoke-static {v0, v5}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v9

    .line 257
    invoke-static {v0, v5}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v5

    .line 258
    invoke-virtual {v3, v5, v9, v5, v9}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 259
    new-instance v5, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v9, -0x1

    const/4 v10, -0x2

    invoke-direct {v5, v9, v10}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v3, v5}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 260
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v5, v9, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v8, v2, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 262
    new-instance v2, Landroid/widget/PopupWindow;

    const/4 v5, 0x1

    invoke-direct {v2, v7, v10, v10, v5}, Landroid/widget/PopupWindow;-><init>(Landroid/view/View;IIZ)V

    .line 263
    invoke-virtual {v2, v5}, Landroid/widget/PopupWindow;->setOutsideTouchable(Z)V

    .line 264
    new-instance v5, Landroid/graphics/drawable/ColorDrawable;

    const/4 v9, 0x0

    invoke-direct {v5, v9}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v2, v5}, Landroid/widget/PopupWindow;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 265
    const/4 v5, 0x0

    invoke-virtual {v2, v5}, Landroid/widget/PopupWindow;->setElevation(F)V

    .line 267
    const/4 v5, 0x0

    :goto_1c1
    invoke-interface/range {p4 .. p4}, Ljava/util/List;->size()I

    move-result v9

    const/high16 v12, 0x41000000    # 8.0f

    if-ge v5, v9, :cond_342

    .line 268
    invoke-interface {v4, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    .line 269
    iget-boolean v13, v9, Lcom/mrkeyboard/app/SheetUi$MenuEntry;->dividerBefore:Z

    if-eqz v13, :cond_210

    if-lez v5, :cond_210

    .line 270
    new-instance v13, Landroid/view/View;

    invoke-direct {v13, v0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 271
    # subtle divider: 0xFF33445E (one step above the 0xFF1A2433 background)
    # WARNING: without the 0xFF alpha the value becomes 0x0033445E = fully transparent
    const v14, -0xccbba2

    invoke-virtual {v13, v14}, Landroid/view/View;->setBackgroundColor(I)V

    .line 272
    new-instance v14, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v15, 0x3f800000    # 1.0f

    invoke-static {v0, v15}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v10

    const/4 v15, 0x1

    invoke-static {v15, v10}, Ljava/lang/Math;->max(II)I

    move-result v10

    const/4 v15, -0x1

    invoke-direct {v14, v15, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 273
    const/high16 v10, 0x40800000    # 4.0f

    invoke-static {v0, v10}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v10

    iput v10, v14, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 274
    const/high16 v10, 0x40800000    # 4.0f

    invoke-static {v0, v10}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v10

    iput v10, v14, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 275
    invoke-static {v0, v12}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v10

    iput v10, v14, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    .line 276
    invoke-static {v0, v12}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v10

    iput v10, v14, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    .line 277
    invoke-virtual {v3, v13, v14}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 280
    :cond_210
    new-instance v10, Landroid/widget/LinearLayout;

    invoke-direct {v10, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 281
    const/4 v13, 0x0

    invoke-virtual {v10, v13}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 282
    const/16 v13, 0x10

    invoke-virtual {v10, v13}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 283
    const/high16 v14, 0x42300000    # 44.0f

    invoke-static {v0, v14}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v14

    invoke-virtual {v10, v14}, Landroid/widget/LinearLayout;->setMinimumHeight(I)V

    .line 284
    invoke-static {v0, v11}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v14

    invoke-static {v0, v12}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v15

    const/high16 v11, 0x41500000    # 13.0f

    invoke-static {v0, v11}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v11

    invoke-static {v0, v12}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v13

    invoke-virtual {v10, v14, v15, v11, v13}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 290
    iget v11, v9, Lcom/mrkeyboard/app/SheetUi$MenuEntry;->tone:I

    const/4 v13, 0x2

    if-ne v11, v13, :cond_250

    .line 291
    nop

    .line 292
    nop

    .line 293
    nop

    .line 294
    const v11, -0x48e7b

    const v13, 0x1ffb7185

    const v14, 0x1ffb7185

    move v15, v14

    move v14, v11

    goto :goto_2a3

    .line 295
    :cond_250
    iget v11, v9, Lcom/mrkeyboard/app/SheetUi$MenuEntry;->tone:I

    const/4 v13, 0x1

    if-ne v11, v13, :cond_265

    .line 296
    nop

    .line 297
    nop

    .line 298
    nop

    .line 299
    const v11, -0x440dc

    const v13, 0x24fbbf24

    const v14, -0x440dc

    const v15, 0x24fbbf24

    goto :goto_2a3

    .line 301
    :cond_265
    nop

    .line 302
    nop

    .line 303
    iget v11, v9, Lcom/mrkeyboard/app/SheetUi$MenuEntry;->icon:I

    const/16 v13, 0xa

    const v14, -0x1

    const v15, 0x331b97fc

    if-ne v11, v13, :cond_27b

    .line 304
    nop

    .line 305
    const v11, -0xcb2c67

    const v13, 0x2434d399

    goto :goto_2a3

    .line 306
    :cond_27b
    iget v11, v9, Lcom/mrkeyboard/app/SheetUi$MenuEntry;->icon:I

    const/16 v13, 0x8

    if-ne v11, v13, :cond_289

    .line 307
    nop

    .line 308
    const v11, -0x587406

    const v13, 0x24a78bfa

    goto :goto_2a3

    .line 309
    :cond_289
    iget v11, v9, Lcom/mrkeyboard/app/SheetUi$MenuEntry;->icon:I

    const/4 v13, 0x6

    if-eq v11, v13, :cond_29c

    iget v11, v9, Lcom/mrkeyboard/app/SheetUi$MenuEntry;->icon:I

    const/4 v13, 0x7

    if-ne v11, v13, :cond_294

    goto :goto_29c

    .line 313
    :cond_294
    nop

    .line 314
    const v11, -0xe46804

    const v13, 0x241b97fc

    goto :goto_2a3

    .line 310
    :cond_29c
    :goto_29c
    nop

    .line 311
    const v13, 0x1fc2dcf6

    const v11, -0x3d230a

    .line 318
    :goto_2a3
    const/high16 v12, 0x41300000    # 11.0f

    invoke-static {v0, v12}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v4

    const/4 v12, 0x0

    invoke-static {v12, v4, v12, v12, v15}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object v4

    invoke-virtual {v10, v4}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 320
    const/high16 v4, 0x41e00000    # 28.0f

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v4

    .line 321
    new-instance v12, Landroid/widget/ImageView;

    invoke-direct {v12, v0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 322
    sget-object v15, Landroid/widget/ImageView$ScaleType;->CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v12, v15}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    .line 323
    const/high16 v15, 0x41000000    # 8.0f

    invoke-static {v0, v15}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v15

    move/from16 v17, v6

    const/4 v6, 0x0

    invoke-static {v13, v15, v6, v6}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v13

    invoke-virtual {v12, v13}, Landroid/widget/ImageView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 324
    new-instance v6, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    iget v13, v9, Lcom/mrkeyboard/app/SheetUi$MenuEntry;->icon:I

    move-object/from16 v18, v7

    const/high16 v15, 0x41800000    # 16.0f

    invoke-static {v0, v15}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v7

    invoke-direct {v6, v0, v13, v11, v7}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    invoke-virtual {v12, v6}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 325
    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v6, v4, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 326
    const/high16 v4, 0x41300000    # 11.0f

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v7

    iput v7, v6, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    .line 327
    invoke-virtual {v10, v12, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 329
    new-instance v6, Landroid/widget/TextView;

    invoke-direct {v6, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 330
    iget-object v7, v9, Lcom/mrkeyboard/app/SheetUi$MenuEntry;->title:Ljava/lang/String;

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 331
    invoke-virtual {v6, v14}, Landroid/widget/TextView;->setTextColor(I)V

    .line 332
    const/high16 v7, 0x41600000    # 14.0f

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setTextSize(F)V

    .line 333
    sget-object v11, Lcom/mrkeyboard/app/SheetUi;->TF_MEDIUM:Landroid/graphics/Typeface;

    invoke-virtual {v6, v11}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 334
    const/4 v11, 0x1

    invoke-virtual {v6, v11}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 335
    sget-object v11, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v6, v11}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    .line 336
    new-instance v11, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v12, -0x2

    invoke-direct {v11, v12, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v10, v6, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 338
    new-instance v6, Lcom/mrkeyboard/app/SheetUi$1;

    move-object/from16 v11, p5

    invoke-direct {v6, v2, v11, v9}, Lcom/mrkeyboard/app/SheetUi$1;-><init>(Landroid/widget/PopupWindow;Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;Lcom/mrkeyboard/app/SheetUi$MenuEntry;)V

    invoke-virtual {v10, v6}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 349
    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v9, -0x1

    invoke-direct {v6, v9, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v10, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 267
    add-int/lit8 v5, v5, 0x1

    move v15, v4

    move/from16 v6, v17

    move-object/from16 v7, v18

    const/high16 v11, 0x41100000    # 9.0f

    const v13, 0x241b97fc

    const v14, -0xe46804

    move-object/from16 v4, p4

    goto/16 :goto_1c1

    .line 352
    :cond_342
    move/from16 v17, v6

    move-object/from16 v18, v7

    new-instance v3, Landroid/graphics/Rect;

    invoke-direct {v3}, Landroid/graphics/Rect;-><init>()V

    .line 353
    invoke-virtual {v1, v3}, Landroid/view/View;->getWindowVisibleDisplayFrame(Landroid/graphics/Rect;)V

    .line 354
    invoke-virtual {v3}, Landroid/graphics/Rect;->width()I

    move-result v4

    if-lez v4, :cond_359

    invoke-virtual {v3}, Landroid/graphics/Rect;->width()I

    move-result v4

    goto :goto_363

    :cond_359
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v4

    iget v4, v4, Landroid/util/DisplayMetrics;->widthPixels:I

    .line 355
    :goto_363
    invoke-virtual {v3}, Landroid/graphics/Rect;->height()I

    move-result v5

    if-lez v5, :cond_36e

    invoke-virtual {v3}, Landroid/graphics/Rect;->height()I

    move-result v5

    goto :goto_378

    :cond_36e
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v5

    iget v5, v5, Landroid/util/DisplayMetrics;->heightPixels:I

    .line 357
    :goto_378
    const/high16 v6, 0x43600000    # 224.0f

    invoke-static {v0, v6}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v6

    .line 358
    const/high16 v7, 0x43920000    # 292.0f

    invoke-static {v0, v7}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v7

    const/high16 v9, 0x41e00000    # 28.0f

    invoke-static {v0, v9}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v9

    sub-int/2addr v4, v9

    invoke-static {v7, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    .line 359
    nop

    .line 360
    const/high16 v7, -0x80000000

    invoke-static {v4, v7}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v9

    .line 361
    const/high16 v10, 0x42000000    # 32.0f

    invoke-static {v0, v10}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v10

    sub-int v10, v5, v10

    invoke-static {v10, v7}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v10

    .line 359
    invoke-virtual {v8, v9, v10}, Landroid/widget/LinearLayout;->measure(II)V

    .line 363
    invoke-virtual {v8}, Landroid/widget/LinearLayout;->getMeasuredWidth()I

    move-result v9

    invoke-static {v4, v9}, Ljava/lang/Math;->min(II)I

    move-result v4

    invoke-static {v6, v4}, Ljava/lang/Math;->max(II)I

    move-result v4

    .line 364
    nop

    .line 365
    const/high16 v6, 0x40000000    # 2.0f

    invoke-static {v4, v6}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v6

    .line 366
    const/high16 v9, 0x42000000    # 32.0f

    invoke-static {v0, v9}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v9

    sub-int/2addr v5, v9

    invoke-static {v5, v7}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v5

    .line 364
    invoke-virtual {v8, v6, v5}, Landroid/widget/LinearLayout;->measure(II)V

    .line 368
    invoke-virtual {v8}, Landroid/widget/LinearLayout;->getMeasuredHeight()I

    move-result v5

    .line 370
    new-instance v6, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v7, -0x2

    invoke-direct {v6, v4, v7}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    move-object/from16 v9, v18

    invoke-virtual {v9, v8, v6}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 371
    mul-int/lit8 v6, v17, 0x2

    add-int v8, v4, v6

    .line 372
    add-int/2addr v6, v5

    .line 373
    invoke-virtual {v2, v8}, Landroid/widget/PopupWindow;->setWidth(I)V

    .line 374
    invoke-virtual {v2, v7}, Landroid/widget/PopupWindow;->setHeight(I)V

    .line 376
    const/4 v7, 0x2

    new-array v7, v7, [I

    .line 377
    invoke-virtual {v1, v7}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 378
    const/4 v9, 0x0

    aget v10, v7, v9

    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->getWidth()I

    move-result v9

    add-int/2addr v10, v9

    .line 379
    const/4 v9, 0x1

    aget v11, v7, v9

    .line 380
    aget v7, v7, v9

    invoke-virtual/range {p1 .. p1}, Landroid/view/View;->getHeight()I

    move-result v9

    add-int/2addr v7, v9

    .line 382
    sub-int/2addr v10, v4

    sub-int v10, v10, v17

    .line 383
    iget v4, v3, Landroid/graphics/Rect;->left:I

    const/high16 v9, 0x40c00000    # 6.0f

    invoke-static {v0, v9}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v12

    add-int/2addr v4, v12

    sub-int v4, v4, v17

    .line 384
    iget v12, v3, Landroid/graphics/Rect;->right:I

    sub-int/2addr v12, v8

    invoke-static {v0, v9}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v8

    sub-int/2addr v12, v8

    add-int v12, v12, v17

    .line 385
    if-ge v10, v4, :cond_413

    move v10, v4

    .line 386
    :cond_413
    if-le v10, v12, :cond_416

    goto :goto_417

    :cond_416
    move v12, v10

    .line 388
    :goto_417
    iget v4, v3, Landroid/graphics/Rect;->bottom:I

    sub-int/2addr v4, v7

    const/high16 v8, 0x41000000    # 8.0f

    invoke-static {v0, v8}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v9

    sub-int/2addr v4, v9

    .line 389
    iget v9, v3, Landroid/graphics/Rect;->top:I

    sub-int v9, v11, v9

    invoke-static {v0, v8}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v8

    sub-int/2addr v9, v8

    .line 391
    if-le v5, v4, :cond_440

    if-lt v4, v9, :cond_42f

    goto :goto_440

    .line 397
    :cond_42f
    sub-int/2addr v11, v5

    sub-int v11, v11, v17

    const/high16 v4, 0x40000000    # 2.0f

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v0

    sub-int/2addr v11, v0

    .line 398
    iget v0, v3, Landroid/graphics/Rect;->top:I

    if-ge v11, v0, :cond_459

    .line 399
    iget v11, v3, Landroid/graphics/Rect;->top:I

    goto :goto_459

    .line 392
    :cond_440
    :goto_440
    sub-int v7, v7, v17

    const/high16 v4, 0x40000000    # 2.0f

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v0

    add-int v11, v7, v0

    .line 393
    add-int v0, v11, v6

    iget v4, v3, Landroid/graphics/Rect;->bottom:I

    if-le v0, v4, :cond_459

    .line 394
    iget v0, v3, Landroid/graphics/Rect;->top:I

    iget v3, v3, Landroid/graphics/Rect;->bottom:I

    sub-int/2addr v3, v6

    invoke-static {v0, v3}, Ljava/lang/Math;->max(II)I

    move-result v11

    .line 404
    :cond_459
    :goto_459
    const/4 v0, 0x0

    :try_start_45a
    invoke-virtual {v2, v1, v0, v12, v11}, Landroid/widget/PopupWindow;->showAtLocation(Landroid/view/View;III)V
    :try_end_45d
    .catchall {:try_start_45a .. :try_end_45d} :catchall_45e

    .line 405
    :goto_45d
    goto :goto_460

    :catchall_45e
    move-exception v0

    goto :goto_45d

    .line 406
    :goto_460
    return-void

    .line 194
    :cond_461
    :goto_461
    return-void
.end method

# Rectangle with background, border and rounded TOP corners (bottom corners
# square). Used in the Sheets menu header so the top border shows up.

