.class Lcom/mrkeyboard/app/SpecialKeyPicker$1;
.super Ljava/lang/Object;
.source "SpecialKeyPicker.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SpecialKeyPicker;->show(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$ctx:Landroid/content/Context;

.field final synthetic val$currentCode:I

.field final synthetic val$dialog:Landroid/app/AlertDialog;

.field final synthetic val$listContainer:Landroid/widget/LinearLayout;

.field final synthetic val$listener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

.field final synthetic val$pt:Z

.field final synthetic val$searchInput:Landroid/widget/EditText;


# direct methods
.method constructor <init>(Landroid/widget/LinearLayout;Landroid/widget/EditText;ZLandroid/content/Context;ILandroid/app/AlertDialog;Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V
    .registers 8

    .line 145
    iput-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$listContainer:Landroid/widget/LinearLayout;

    iput-object p2, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$searchInput:Landroid/widget/EditText;

    iput-boolean p3, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$pt:Z

    iput-object p4, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    iput p5, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$currentCode:I

    iput-object p6, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$dialog:Landroid/app/AlertDialog;

    iput-object p7, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$listener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 17

    .line 148
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$listContainer:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 149
    iget-object v1, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$searchInput:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    .line 150
    nop

    .line 151
    nop

    .line 153
    const-string v2, ""

    const/4 v3, 0x0

    move v4, v3

    move v5, v4

    :goto_22
    # getter for: Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;
    invoke-static {}, Lcom/mrkeyboard/app/SpecialKeyPicker;->access$000()[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-result-object v6

    array-length v6, v6

    if-ge v4, v6, :cond_1cb

    .line 154
    # getter for: Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;
    invoke-static {}, Lcom/mrkeyboard/app/SpecialKeyPicker;->access$000()[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-result-object v6

    aget-object v6, v6, v4

    .line 155
    iget-boolean v8, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$pt:Z

    if-eqz v8, :cond_36

    iget-object v8, v6, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->namePt:Ljava/lang/String;


    invoke-static/range {v8 .. v8}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;


    move-result-object v8

    goto :goto_38

    :cond_36
    iget-object v8, v6, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->nameEn:Ljava/lang/String;

    .line 156
    :goto_38
    iget-boolean v9, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$pt:Z

    if-eqz v9, :cond_3f

    iget-object v9, v6, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->catPt:Ljava/lang/String;


    invoke-static/range {v9 .. v9}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;


    move-result-object v9

    goto :goto_41

    :cond_3f
    iget-object v9, v6, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->catEn:Ljava/lang/String;

    .line 157
    :goto_41
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-nez v10, :cond_58

    .line 158
    iget-boolean v10, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$pt:Z

    if-eqz v10, :cond_4e

    iget-object v10, v6, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->searchKeyPt:Ljava/lang/String;

    goto :goto_50

    :cond_4e
    iget-object v10, v6, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->searchKeyEn:Ljava/lang/String;

    .line 159
    :goto_50
    invoke-virtual {v10, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v10

    if-nez v10, :cond_58

    # also finds it by the already translated name (Spanish)
    sget-object v10, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v8, v10}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v10

    if-nez v10, :cond_58

    goto/16 :goto_1c6

    .line 161
    :cond_58
    invoke-virtual {v9, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    const/high16 v11, 0x41200000    # 10.0f

    const v12, -0xd63a0a

    const/high16 v13, 0x40800000    # 4.0f

    if-nez v10, :cond_a3

    .line 162
    new-instance v2, Landroid/widget/TextView;

    iget-object v10, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-direct {v2, v10}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 163
    sget-object v10, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v9, v10}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v2, v10}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 164
    invoke-virtual {v2, v12}, Landroid/widget/TextView;->setTextColor(I)V

    .line 165
    const/high16 v10, 0x41300000    # 11.0f

    invoke-virtual {v2, v10}, Landroid/widget/TextView;->setTextSize(F)V

    .line 166
    sget-object v10, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v2, v10}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 167
    iget-object v10, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-static {v10, v13}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v10

    iget-object v14, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-static {v14, v11}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v14

    iget-object v15, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-static {v15, v13}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v15

    iget-object v7, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-static {v7, v13}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v7

    invoke-virtual {v2, v10, v14, v15, v7}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 168
    iget-object v7, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$listContainer:Landroid/widget/LinearLayout;

    invoke-virtual {v7, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 169
    move-object v2, v9

    .line 172
    :cond_a3
    iget v7, v6, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->code:I

    iget v9, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$currentCode:I

    const/4 v10, 0x1

    if-ne v7, v9, :cond_ac

    move v7, v10

    goto :goto_ad

    :cond_ac
    move v7, v3

    .line 173
    :goto_ad
    new-instance v9, Landroid/widget/LinearLayout;

    iget-object v14, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-direct {v9, v14}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 174
    invoke-virtual {v9, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 175
    const/16 v14, 0x10

    invoke-virtual {v9, v14}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 176
    iget-object v14, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-static {v14, v11}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v14

    .line 177
    invoke-virtual {v9, v14, v14, v14, v14}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 178
    nop

    .line 179
    if-eqz v7, :cond_cc

    const v14, -0xecd8c2

    goto :goto_cf

    :cond_cc
    const v14, -0xf5efe8

    :goto_cf
    iget-object v15, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    .line 180
    invoke-static {v15, v11}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v11

    iget-object v15, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    .line 181
    const/high16 v3, 0x3f800000    # 1.0f

    invoke-static {v15, v3}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v15

    invoke-static {v10, v15}, Ljava/lang/Math;->max(II)I

    move-result v15

    .line 182
    if-eqz v7, :cond_e5

    move v7, v12

    goto :goto_e8

    :cond_e5
    const v7, -0xd5c4ac

    .line 178
    :goto_e8
    const v10, 0x3329c5f6

    invoke-static {v14, v11, v15, v7, v10}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object v7

    invoke-virtual {v9, v7}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 186
    new-instance v7, Landroid/widget/TextView;

    iget-object v10, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-direct {v7, v10}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 187
    iget-object v10, v6, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->defaultLabel:Ljava/lang/String;

    invoke-virtual {v7, v10}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 188
    invoke-virtual {v7, v12}, Landroid/widget/TextView;->setTextColor(I)V

    .line 189
    const/high16 v10, 0x41500000    # 13.0f

    invoke-virtual {v7, v10}, Landroid/widget/TextView;->setTextSize(F)V

    .line 190
    sget-object v10, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v7, v10}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 191
    const/16 v10, 0x11

    invoke-virtual {v7, v10}, Landroid/widget/TextView;->setGravity(I)V

    .line 192
    iget-object v10, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    const/high16 v11, 0x42400000    # 48.0f

    invoke-static {v10, v11}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v10

    invoke-virtual {v7, v10}, Landroid/widget/TextView;->setMinWidth(I)V

    .line 193
    iget-object v10, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    const/high16 v11, 0x41000000    # 8.0f

    invoke-static {v10, v11}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v10

    iget-object v12, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-static {v12, v13}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v12

    iget-object v14, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-static {v14, v11}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v14

    iget-object v15, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-static {v15, v13}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v13

    invoke-virtual {v7, v10, v12, v14, v13}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 194
    iget-object v10, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    .line 196
    const/high16 v12, 0x40e00000    # 7.0f

    invoke-static {v10, v12}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v10

    iget-object v12, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    .line 197
    invoke-static {v12, v3}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v12

    const/4 v13, 0x1

    invoke-static {v13, v12}, Ljava/lang/Math;->max(II)I

    move-result v12

    .line 194
    const v13, -0xfbefd8

    const v14, 0x4d29c5f6    # 1.78020192E8f

    invoke-static {v13, v10, v12, v14}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v10

    invoke-virtual {v7, v10}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 200
    invoke-virtual {v9, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 202
    new-instance v7, Landroid/widget/TextView;

    iget-object v10, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-direct {v7, v10}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 203
    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 204
    const v8, -0x160f07

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setTextColor(I)V

    .line 205
    const/high16 v8, 0x41600000    # 14.0f

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setTextSize(F)V

    .line 206
    iget-object v8, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    const/high16 v10, 0x41400000    # 12.0f

    invoke-static {v8, v10}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v8

    iget-object v12, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-static {v12, v11}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v11

    const/4 v12, 0x0

    invoke-virtual {v7, v8, v12, v11, v12}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 207
    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v11, -0x2

    invoke-direct {v8, v12, v11, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v9, v7, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 209
    new-instance v3, Landroid/widget/TextView;

    iget-object v7, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-direct {v3, v7}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 210
    iget v7, v6, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->code:I

    invoke-static {v7}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 211
    const v7, -0x907f67

    invoke-virtual {v3, v7}, Landroid/widget/TextView;->setTextColor(I)V

    .line 212
    invoke-virtual {v3, v10}, Landroid/widget/TextView;->setTextSize(F)V

    .line 213
    invoke-virtual {v9, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 215
    new-instance v3, Lcom/mrkeyboard/app/SpecialKeyPicker$1$1;

    invoke-direct {v3, v0, v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$1$1;-><init>(Lcom/mrkeyboard/app/SpecialKeyPicker$1;Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;)V

    invoke-virtual {v9, v3}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 225
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x1

    invoke-direct {v3, v6, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 226
    iget-object v6, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    const/high16 v7, 0x40c00000    # 6.0f

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v6

    iput v6, v3, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 227
    iget-object v6, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$listContainer:Landroid/widget/LinearLayout;

    invoke-virtual {v6, v9, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 228
    add-int/lit8 v5, v5, 0x1

    .line 153
    :goto_1c6
    add-int/lit8 v4, v4, 0x1

    const/4 v3, 0x0

    goto/16 :goto_22

    .line 231
    :cond_1cb
    if-nez v5, :cond_202

    .line 232
    new-instance v1, Landroid/widget/TextView;

    iget-object v2, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-direct {v1, v2}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 233
    iget-boolean v2, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$pt:Z

    if-eqz v2, :cond_1db

    const-string v2, "Nenhuma tecla encontrada."

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_1dd

    :cond_1db
    const-string v2, "No matching keys found."

    :goto_1dd
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 234
    const v2, -0x6c5c46

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 235
    const/16 v2, 0x11

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 236
    iget-object v2, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    const/high16 v3, 0x41c00000    # 24.0f

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v2

    iget-object v4, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$ctx:Landroid/content/Context;

    invoke-static {v4, v3}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v3

    const/4 v4, 0x0

    invoke-virtual {v1, v4, v2, v4, v3}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 237
    iget-object v2, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$listContainer:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 239
    :cond_202
    return-void
.end method
