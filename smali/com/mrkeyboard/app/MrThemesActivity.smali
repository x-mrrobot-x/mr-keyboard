.class public Lcom/mrkeyboard/app/MrThemesActivity;
.super Landroid/app/Activity;
.source "MrThemesActivity.java"


# static fields
.field static final COLUMNS:I = 0x3

.field static final REQ_PICK:I = 0x47

.field static final THEME_KEY:Ljava/lang/String; = "pref_keyboard_layout"

.field static final THUMB_SIDE:I = 0x140


# instance fields
.field k:Lcom/mrkeyboard/app/MrKit;

.field final mBgSpecs:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrBackdrop$Spec;",
            ">;"
        }
    .end annotation
.end field

.field final mBgTiles:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrThemePreview;",
            ">;"
        }
    .end annotation
.end field

.field mBig:Lcom/mrkeyboard/app/MrThemePreview;

.field mCaption:Landroid/widget/TextView;

.field mDragging:Z

.field mEditor:Landroid/widget/LinearLayout;

.field mImage:Landroid/graphics/Bitmap;

.field mLastX:F

.field mLastY:F

.field mLoad:I

.field mMineTile:Lcom/mrkeyboard/app/MrThemePreview;

.field mNames:[Ljava/lang/String;

.field mPrefs:Landroid/content/SharedPreferences;

.field mRemove:Landroid/widget/TextView;

.field mSoft:I

.field mSoftBar:Landroid/widget/SeekBar;

.field mSoftBox:Landroid/widget/LinearLayout;

.field mSoftText:Landroid/widget/TextView;

.field mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

.field mTags:[Ljava/lang/String;

.field mTheme:I

.field final mThemeTiles:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrThemePreview;",
            ">;"
        }
    .end annotation
.end field

.field mThumb:Landroid/graphics/Bitmap;

.field mValues:[Ljava/lang/String;

.field mZoom:Landroid/widget/SeekBar;

.field mZoomText:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 39
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 48
    new-array v0, v1, [Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    .line 49
    new-array v0, v1, [Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    .line 51
    new-array v0, v1, [Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    .line 53
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 65
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeTiles:Ljava/util/List;

    .line 67
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    .line 68
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    return-void
.end method

.method private addBg(Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;IZ)Lcom/mrkeyboard/app/MrThemePreview;
    .locals 3

    .prologue
    .line 272
    new-instance v1, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    .line 273
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 274
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    invoke-interface {v0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 275
    if-eqz p5, :cond_1

    const/4 v0, 0x0

    :goto_0
    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$7;

    invoke-direct {v2, p0, p2}, Lcom/mrkeyboard/app/MrThemesActivity$7;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrBackdrop$Spec;)V

    invoke-direct {p0, v1, v0, p4, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->tileBox(Lcom/mrkeyboard/app/MrThemePreview;Ljava/lang/String;ILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 280
    if-eqz p5, :cond_0

    invoke-virtual {v0, p3}, Landroid/widget/LinearLayout;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 281
    :cond_0
    invoke-direct {p0, p4}, Lcom/mrkeyboard/app/MrThemesActivity;->tileParams(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {p1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 282
    return-object v1

    :cond_1
    move-object v0, p3

    .line 275
    goto :goto_0
.end method

.method private addGallery(Landroid/widget/LinearLayout;)V
    .locals 5

    .prologue
    const/4 v4, 0x1

    .line 287
    new-instance v0, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    .line 288
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->card:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->stroke:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrThemePreview;->showPlus(III)V

    .line 289
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_gallery"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$8;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrThemesActivity$8;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    invoke-direct {p0, v0, v1, v4, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->tileBox(Lcom/mrkeyboard/app/MrThemePreview;Ljava/lang/String;ILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 293
    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->tileParams(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    .line 289
    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 294
    return-void
.end method

.method static backgroundName(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 355
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    packed-switch v0, :pswitch_data_0

    .line 359
    const-string v0, "mr_themes_none"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 361
    :goto_0
    if-eqz v0, :cond_0

    :goto_1
    return-object v0

    .line 356
    :pswitch_0
    const-string v0, "mr_themes_gradient"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    iget v2, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    add-int/lit8 v2, v2, 0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v1, v3

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 357
    :pswitch_1
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->sceneName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 358
    :pswitch_2
    const-string v0, "mr_themes_mine"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 361
    :cond_0
    const-string v0, ""

    goto :goto_1

    .line 355
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method private fillRow(Landroid/widget/LinearLayout;I)V
    .locals 3

    .prologue
    .line 247
    if-nez p1, :cond_1

    .line 252
    :cond_0
    return-void

    .line 248
    :cond_1
    rem-int/lit8 v0, p2, 0x3

    :goto_0
    if-eqz v0, :cond_0

    const/4 v1, 0x3

    if-ge v0, v1, :cond_0

    .line 249
    new-instance v1, Landroid/view/View;

    invoke-direct {v1, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 250
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->tileParams(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {p1, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 248
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method static sceneName(Landroid/content/Context;I)Ljava/lang/String;
    .locals 2

    .prologue
    .line 348
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mr_themes_scene_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 349
    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    const-string v0, ""

    goto :goto_0
.end method

.method static thumb(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;
    .locals 4

    .prologue
    const/4 v3, 0x1

    .line 533
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 534
    const/16 v1, 0x140

    if-gt v0, v1, :cond_0

    .line 536
    :goto_0
    return-object p0

    .line 535
    :cond_0
    const/high16 v1, 0x43a00000    # 320.0f

    int-to-float v0, v0

    div-float v0, v1, v0

    .line 536
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v1

    int-to-float v1, v1

    mul-float/2addr v1, v0

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    invoke-static {v3, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    int-to-float v2, v2

    mul-float/2addr v0, v2

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-static {v3, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-static {p0, v1, v0, v3}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object p0

    goto :goto_0
.end method

.method private tileBox(Lcom/mrkeyboard/app/MrThemePreview;Ljava/lang/String;ILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;
    .locals 6

    .prologue
    const/4 v5, 0x1

    .line 256
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 257
    invoke-virtual {v0, v5}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 258
    invoke-virtual {v0, p4}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 259
    invoke-virtual {v0, p2}, Landroid/widget/LinearLayout;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 260
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, -0x1

    const/4 v3, -0x2

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, p1, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 261
    if-eqz p2, :cond_0

    .line 262
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x41400000    # 12.0f

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v4, 0x0

    invoke-virtual {v1, p2, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 263
    const/16 v2, 0x11

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 264
    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 265
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v3, 0x4

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 267
    :cond_0
    return-object v0
.end method

.method private tileParams(I)Landroid/widget/LinearLayout$LayoutParams;
    .locals 5

    .prologue
    const/high16 v4, 0x40a00000    # 5.0f

    const/4 v1, 0x0

    .line 240
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v0, -0x2

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-direct {v3, v1, v0, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 241
    if-nez p1, :cond_0

    move v2, v1

    :goto_0
    const/4 v0, 0x2

    if-ne p1, v0, :cond_1

    move v0, v1

    :goto_1
    invoke-virtual {v3, v2, v1, v0, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 242
    return-object v3

    .line 241
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    move v2, v0

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    goto :goto_1
.end method

.method private tileRow(Landroid/widget/LinearLayout;)Landroid/widget/LinearLayout;
    .locals 3

    .prologue
    .line 233
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 234
    const/16 v0, 0x30

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 235
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {p1}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {v2, v0}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {p1, v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 236
    return-object v1

    .line 235
    :cond_0
    const/16 v0, 0xa

    goto :goto_0
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 77
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 78
    return-void
.end method

.method caption()Ljava/lang/String;
    .locals 2

    .prologue
    .line 341
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    array-length v1, v1

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    aget-object v0, v0, v1

    .line 342
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v1, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-nez v1, :cond_1

    .line 343
    :goto_1
    return-object v0

    .line 341
    :cond_0
    const-string v0, ""

    goto :goto_0

    .line 343
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " \u00b7 "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->backgroundName(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method chooseBackground(Lcom/mrkeyboard/app/MrBackdrop$Spec;)V
    .locals 4

    .prologue
    const/4 v2, 0x3

    const/4 v1, 0x0

    .line 373
    .line 374
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v2, :cond_1

    .line 376
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v2, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 378
    :goto_0
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 379
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "pref_kbd_bg"

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->format()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 380
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    .line 381
    return-void

    .line 376
    :cond_0
    const/16 v0, 0x64

    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->imageStamp(Landroid/content/Context;)J

    move-result-wide v2

    invoke-static {v0, v1, v1, v2, v3}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->image(IIIJ)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    goto :goto_0

    :cond_1
    move-object v0, p1

    goto :goto_0
.end method

.method chooseTheme(I)V
    .locals 3

    .prologue
    .line 367
    iput p1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    .line 368
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "pref_keyboard_layout"

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    array-length v0, v0

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    aget-object v0, v0, p1

    :goto_0
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 369
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    .line 370
    return-void

    .line 368
    :cond_0
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method drag(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 12

    .prologue
    const/4 v2, 0x3

    const/4 v10, 0x0

    const/4 v9, 0x1

    .line 408
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v2, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    if-nez v0, :cond_1

    :cond_0
    move v0, v10

    .line 433
    :goto_0
    return v0

    .line 409
    :cond_1
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    .line 410
    if-nez v0, :cond_3

    .line 411
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLastX:F

    .line 412
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getY()F

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLastY:F

    .line 413
    iput-boolean v9, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDragging:Z

    .line 414
    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    .line 415
    if-eqz v0, :cond_2

    invoke-interface {v0, v9}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    :cond_2
    move v0, v9

    .line 416
    goto :goto_0

    .line 418
    :cond_3
    iget-boolean v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDragging:Z

    if-nez v1, :cond_4

    move v0, v10

    goto :goto_0

    .line 419
    :cond_4
    const/4 v1, 0x2

    if-ne v0, v1, :cond_5

    .line 420
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v2

    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v4, v4, Lcom/mrkeyboard/app/MrBackdrop$Spec;->zoom:I

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v5, v5, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dx:I

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v6, v6, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dy:I

    .line 421
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result v7

    iget v8, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLastX:F

    sub-float/2addr v7, v8

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getY()F

    move-result v8

    iget v11, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLastY:F

    sub-float/2addr v8, v11

    .line 420
    invoke-static/range {v0 .. v8}, Lcom/mrkeyboard/app/MrBackdrop;->pan(IIIIIIIFF)[I

    move-result-object v0

    .line 422
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result v1

    iput v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLastX:F

    .line 423
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getY()F

    move-result v1

    iput v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLastY:F

    .line 424
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v2, v2, Lcom/mrkeyboard/app/MrBackdrop$Spec;->zoom:I

    aget v3, v0, v10

    aget v0, v0, v9

    invoke-virtual {v1, v2, v3, v0}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->moved(III)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 425
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->tag()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    iget v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    move v0, v9

    .line 426
    goto/16 :goto_0

    .line 428
    :cond_5
    if-eq v0, v9, :cond_6

    if-ne v0, v2, :cond_7

    .line 429
    :cond_6
    iput-boolean v10, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDragging:Z

    .line 430
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->saveSpec()V

    move v0, v9

    .line 431
    goto/16 :goto_0

    :cond_7
    move v0, v10

    .line 433
    goto/16 :goto_0
.end method

.method imported(Z)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 485
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 494
    :goto_0
    return-void

    .line 486
    :cond_0
    if-nez p1, :cond_1

    .line 487
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_image_failed"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 490
    :cond_1
    const/16 v0, 0x64

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v0, v4, v4, v2, v3}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->image(IIIJ)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 491
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "pref_kbd_bg"

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->format()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 492
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->loadImage()V

    .line 493
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    goto :goto_0
.end method

.method loadImage()V
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 509
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->hasImage(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 510
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 511
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 529
    :goto_0
    return-void

    .line 514
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    .line 515
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$10;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$10;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 528
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 3

    .prologue
    .line 453
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 454
    const/16 v0, 0x47

    if-ne p1, v0, :cond_0

    const/4 v0, -0x1

    if-ne p2, v0, :cond_0

    if-nez p3, :cond_1

    .line 481
    :cond_0
    :goto_0
    return-void

    .line 455
    :cond_1
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    .line 456
    if-eqz v0, :cond_0

    .line 458
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$9;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$9;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/net/Uri;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 480
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 11

    .prologue
    .line 82
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 83
    new-instance v0, Lcom/mrkeyboard/app/MrKit;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrKit;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 84
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    .line 85
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->tags(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    .line 86
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->names(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    .line 87
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->values(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    .line 88
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->readPrefs()V

    .line 90
    new-instance v7, Landroid/widget/ScrollView;

    invoke-direct {v7, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 91
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->bg:I

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/widget/ScrollView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 92
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v8

    .line 93
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v1, 0x41a00000    # 20.0f

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x41800000    # 16.0f

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41c00000    # 24.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v8, v0, v1, v2, v3}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 94
    new-instance v0, Landroid/view/ViewGroup$LayoutParams;

    const/4 v1, -0x1

    const/4 v2, -0x2

    invoke-direct {v0, v1, v2}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v7, v8, v0}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 96
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_title"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$1;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrThemesActivity$1;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->backHeader(Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v2, 0x0

    .line 100
    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    .line 96
    invoke-virtual {v8, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 103
    new-instance v0, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    .line 104
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0xe

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v8, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 105
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    new-instance v1, Lcom/mrkeyboard/app/MrThemesActivity$2;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrThemesActivity$2;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 110
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, ""

    const/high16 v2, 0x41600000    # 14.0f

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v4, 0x0

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    .line 111
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V

    .line 112
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v8, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 114
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->panel()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mEditor:Landroid/widget/LinearLayout;

    .line 115
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mEditor:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0xc

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v8, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 116
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mEditor:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_drag"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/high16 v3, 0x41500000    # 13.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v5, 0x0

    invoke-virtual {v1, v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 117
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 118
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mEditor:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0xa

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 119
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_zoom"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/high16 v3, 0x41800000    # 16.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v5, 0x1

    invoke-virtual {v1, v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, 0x0

    const/4 v4, -0x2

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v2, v3, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 120
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, ""

    const/high16 v3, 0x41800000    # 16.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v5, 0x0

    invoke-virtual {v1, v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mZoomText:Landroid/widget/TextView;

    .line 121
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mZoomText:Landroid/widget/TextView;

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x2

    const/4 v4, -0x2

    invoke-direct {v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 122
    new-instance v0, Landroid/widget/SeekBar;

    invoke-direct {v0, p0}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mZoom:Landroid/widget/SeekBar;

    .line 123
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mZoom:Landroid/widget/SeekBar;

    const/16 v1, 0x12c

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setMax(I)V

    .line 124
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mZoom:Landroid/widget/SeekBar;

    new-instance v1, Lcom/mrkeyboard/app/MrThemesActivity$3;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrThemesActivity$3;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 136
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mEditor:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mZoom:Landroid/widget/SeekBar;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v3, 0x6

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 138
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->panel()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoftBox:Landroid/widget/LinearLayout;

    .line 139
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoftBox:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0xc

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v8, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 140
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 141
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoftBox:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 142
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_soften"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/high16 v3, 0x41800000    # 16.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v5, 0x1

    invoke-virtual {v1, v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, 0x0

    const/4 v4, -0x2

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v2, v3, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 143
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, ""

    const/high16 v3, 0x41800000    # 16.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v5, 0x0

    invoke-virtual {v1, v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoftText:Landroid/widget/TextView;

    .line 144
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoftText:Landroid/widget/TextView;

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x2

    const/4 v4, -0x2

    invoke-direct {v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 145
    new-instance v0, Landroid/widget/SeekBar;

    invoke-direct {v0, p0}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoftBar:Landroid/widget/SeekBar;

    .line 146
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoftBar:Landroid/widget/SeekBar;

    const/16 v1, 0x46

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setMax(I)V

    .line 147
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoftBar:Landroid/widget/SeekBar;

    new-instance v1, Lcom/mrkeyboard/app/MrThemesActivity$4;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrThemesActivity$4;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 159
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoftBox:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoftBar:Landroid/widget/SeekBar;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v3, 0x6

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 160
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoftBox:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_soften_hint"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/high16 v3, 0x41500000    # 13.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v5, 0x0

    invoke-virtual {v1, v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v3, 0x4

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 163
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_themes"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/high16 v2, 0x41800000    # 16.0f

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v4, 0x1

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0x16

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v8, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 164
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v3

    .line 165
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v8, v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 166
    const/4 v1, 0x0

    .line 167
    const/4 v0, 0x0

    move v2, v0

    move-object v0, v1

    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    array-length v1, v1

    if-ge v2, v1, :cond_2

    .line 168
    rem-int/lit8 v1, v2, 0x3

    if-nez v1, :cond_0

    .line 169
    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->tileRow(Landroid/widget/LinearLayout;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 172
    :cond_0
    new-instance v4, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    .line 173
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeTiles:Ljava/util/List;

    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 174
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    array-length v1, v1

    if-ge v2, v1, :cond_1

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    aget-object v1, v1, v2

    :goto_1
    rem-int/lit8 v5, v2, 0x3

    new-instance v6, Lcom/mrkeyboard/app/MrThemesActivity$5;

    invoke-direct {v6, p0, v2}, Lcom/mrkeyboard/app/MrThemesActivity$5;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V

    invoke-direct {p0, v4, v1, v5, v6}, Lcom/mrkeyboard/app/MrThemesActivity;->tileBox(Lcom/mrkeyboard/app/MrThemePreview;Ljava/lang/String;ILandroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v1

    rem-int/lit8 v4, v2, 0x3

    .line 178
    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->tileParams(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    .line 174
    invoke-virtual {v0, v1, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 167
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_0

    .line 174
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    aget-object v1, v1, v2

    goto :goto_1

    .line 180
    :cond_2
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    array-length v1, v1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->fillRow(Landroid/widget/LinearLayout;I)V

    .line 183
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_backgrounds"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/high16 v2, 0x41800000    # 16.0f

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v4, 0x1

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0x16

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v8, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 184
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 185
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0x8

    invoke-virtual {v0, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v8, v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 186
    sget-object v2, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_none"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v0, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemesActivity;->addBg(Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;IZ)Lcom/mrkeyboard/app/MrThemePreview;

    .line 187
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->addGallery(Landroid/widget/LinearLayout;)V

    .line 188
    const/16 v0, 0x64

    const/4 v2, 0x0

    const/4 v3, 0x0

    const-wide/16 v4, 0x0

    invoke-static {v0, v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->image(IIIJ)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_mine"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v0, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x2

    const/4 v5, 0x0

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemesActivity;->addBg(Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;IZ)Lcom/mrkeyboard/app/MrThemePreview;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mMineTile:Lcom/mrkeyboard/app/MrThemePreview;

    .line 190
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_landscapes"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/high16 v2, 0x41800000    # 16.0f

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v4, 0x1

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0x12

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v8, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 191
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v9

    .line 192
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v8, v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 193
    const/4 v1, 0x0

    .line 194
    const/4 v0, 0x0

    move v6, v0

    :goto_2
    const/4 v0, 0x6

    if-ge v6, v0, :cond_4

    .line 195
    rem-int/lit8 v0, v6, 0x3

    if-nez v0, :cond_3

    invoke-direct {p0, v9}, Lcom/mrkeyboard/app/MrThemesActivity;->tileRow(Landroid/widget/LinearLayout;)Landroid/widget/LinearLayout;

    move-result-object v1

    .line 196
    :cond_3
    invoke-static {v6}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->scene(I)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v2

    invoke-static {p0, v6}, Lcom/mrkeyboard/app/MrThemesActivity;->sceneName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v3

    rem-int/lit8 v4, v6, 0x3

    const/4 v5, 0x1

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemesActivity;->addBg(Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;IZ)Lcom/mrkeyboard/app/MrThemePreview;

    .line 194
    add-int/lit8 v0, v6, 0x1

    move v6, v0

    goto :goto_2

    .line 198
    :cond_4
    const/4 v0, 0x6

    invoke-direct {p0, v1, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->fillRow(Landroid/widget/LinearLayout;I)V

    .line 200
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_gradients"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/high16 v2, 0x41800000    # 16.0f

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v4, 0x1

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0x12

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v8, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 201
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v9

    .line 202
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v8, v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 203
    const/4 v1, 0x0

    .line 204
    const/4 v0, 0x0

    move v6, v0

    :goto_3
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->GRADIENTS:[[I

    array-length v0, v0

    if-ge v6, v0, :cond_6

    .line 205
    rem-int/lit8 v0, v6, 0x3

    if-nez v0, :cond_5

    invoke-direct {p0, v9}, Lcom/mrkeyboard/app/MrThemesActivity;->tileRow(Landroid/widget/LinearLayout;)Landroid/widget/LinearLayout;

    move-result-object v1

    .line 206
    :cond_5
    invoke-static {v6}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->gradient(I)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_gradient"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    add-int/lit8 v10, v6, 0x1

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v4, v5

    invoke-virtual {v0, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    rem-int/lit8 v4, v6, 0x3

    const/4 v5, 0x1

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemesActivity;->addBg(Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;IZ)Lcom/mrkeyboard/app/MrThemePreview;

    .line 204
    add-int/lit8 v0, v6, 0x1

    move v6, v0

    goto :goto_3

    .line 208
    :cond_6
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->GRADIENTS:[[I

    array-length v0, v0

    invoke-direct {p0, v1, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->fillRow(Landroid/widget/LinearLayout;I)V

    .line 210
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_remove"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-instance v3, Lcom/mrkeyboard/app/MrThemesActivity$6;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrThemesActivity$6;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    invoke-virtual {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRemove:Landroid/widget/TextView;

    .line 215
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRemove:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0x16

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v8, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 217
    invoke-virtual {p0, v7}, Lcom/mrkeyboard/app/MrThemesActivity;->setContentView(Landroid/view/View;)V

    .line 218
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    .line 219
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->loadImage()V

    .line 220
    return-void
.end method

.method protected onDestroy()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 224
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    .line 225
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 226
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 227
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 228
    return-void
.end method

.method pick()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 440
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 441
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 442
    const-string v1, "image/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 443
    const/16 v1, 0x47

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    .line 449
    :goto_0
    return-void

    .line 444
    :catch_0
    move-exception v0

    .line 445
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_image_failed"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 446
    :catch_1
    move-exception v0

    .line 447
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_image_failed"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0
.end method

.method readPrefs()V
    .locals 4

    .prologue
    .line 300
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 301
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->soft(Landroid/content/Context;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    .line 302
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    const-string v2, "pref_keyboard_layout"

    const-string v3, "0"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrThemeColors;->indexOf([Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    .line 303
    return-void
.end method

.method refresh()V
    .locals 12

    .prologue
    const/4 v11, 0x3

    const/16 v6, 0x8

    const/4 v3, 0x1

    const/4 v4, 0x0

    .line 311
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->tag()Ljava/lang/String;

    move-result-object v7

    .line 312
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v11, :cond_0

    move v2, v3

    .line 313
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    iget v8, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    invoke-virtual {v0, v7, v1, v5, v8}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    move v1, v4

    .line 314
    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeTiles:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_3

    .line 315
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeTiles:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrThemePreview;

    .line 316
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    array-length v5, v5

    if-ge v1, v5, :cond_1

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    aget-object v5, v5, v1

    :goto_2
    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v9, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    iget v10, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    invoke-virtual {v0, v5, v8, v9, v10}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 317
    iget v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    if-ne v1, v5, :cond_2

    move v5, v3

    :goto_3
    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v8, v8, Lcom/mrkeyboard/app/MrKit;->accent:I

    iget-object v9, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v9, v9, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    invoke-virtual {v0, v5, v8, v9}, Lcom/mrkeyboard/app/MrThemePreview;->setChecked(ZII)V

    .line 314
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    :cond_0
    move v2, v4

    .line 312
    goto :goto_0

    .line 316
    :cond_1
    const/4 v5, 0x0

    goto :goto_2

    :cond_2
    move v5, v4

    .line 317
    goto :goto_3

    .line 319
    :cond_3
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->hasImage(Landroid/content/Context;)Z

    move-result v8

    move v5, v4

    .line 320
    :goto_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v5, v0, :cond_6

    .line 321
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrThemePreview;

    .line 322
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    invoke-interface {v1, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 323
    iget-object v9, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    iget v10, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    invoke-virtual {v0, v7, v1, v9, v10}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 324
    iget v9, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    iget-object v10, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v10, v10, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v9, v10, :cond_5

    iget v9, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eqz v9, :cond_4

    iget v9, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eq v9, v11, :cond_4

    iget v1, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    iget-object v9, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v9, v9, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    if-ne v1, v9, :cond_5

    :cond_4
    move v1, v3

    :goto_5
    iget-object v9, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v9, v9, Lcom/mrkeyboard/app/MrKit;->accent:I

    iget-object v10, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v10, v10, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    invoke-virtual {v0, v1, v9, v10}, Lcom/mrkeyboard/app/MrThemePreview;->setChecked(ZII)V

    .line 320
    add-int/lit8 v0, v5, 0x1

    move v5, v0

    goto :goto_4

    :cond_5
    move v1, v4

    .line 324
    goto :goto_5

    .line 326
    :cond_6
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mMineTile:Lcom/mrkeyboard/app/MrThemePreview;

    if-eqz v0, :cond_7

    .line 327
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mMineTile:Lcom/mrkeyboard/app/MrThemePreview;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrThemePreview;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    .line 328
    if-eqz v0, :cond_7

    if-eqz v8, :cond_8

    move v1, v4

    :goto_6
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 330
    :cond_7
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->caption()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 331
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mEditor:Landroid/widget/LinearLayout;

    if-eqz v2, :cond_9

    move v0, v4

    :goto_7
    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 332
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoftBox:Landroid/widget/LinearLayout;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-nez v0, :cond_a

    move v0, v6

    :goto_8
    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 333
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mZoom:Landroid/widget/SeekBar;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v1, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->zoom:I

    add-int/lit8 v1, v1, -0x64

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 334
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mZoomText:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v2, v2, Lcom/mrkeyboard/app/MrBackdrop$Spec;->zoom:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "%"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 335
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoftBar:Landroid/widget/SeekBar;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 336
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoftText:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "%"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 337
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRemove:Landroid/widget/TextView;

    if-eqz v8, :cond_b

    :goto_9
    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 338
    return-void

    .line 328
    :cond_8
    const/4 v1, 0x4

    goto :goto_6

    :cond_9
    move v0, v6

    .line 331
    goto :goto_7

    :cond_a
    move v0, v4

    .line 332
    goto :goto_8

    :cond_b
    move v4, v6

    .line 337
    goto :goto_9
.end method

.method removeImage()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 497
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->removeImage(Landroid/content/Context;)V

    .line 498
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    .line 499
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 500
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "pref_kbd_bg"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 502
    :cond_0
    iput-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 503
    iput-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 504
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    .line 505
    return-void
.end method

.method saveSoft()V
    .locals 3

    .prologue
    .line 402
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "pref_kbd_bg_soft"

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 403
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    .line 404
    return-void
.end method

.method saveSpec()V
    .locals 3

    .prologue
    .line 397
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "pref_kbd_bg"

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->format()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 398
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    .line 399
    return-void
.end method

.method softChanged(I)V
    .locals 5

    .prologue
    .line 390
    const/4 v0, 0x0

    const/16 v1, 0x46

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    .line 391
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->tag()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    iget v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 392
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoftText:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "%"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 393
    return-void
.end method

.method tag()Ljava/lang/String;
    .locals 2

    .prologue
    .line 306
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    array-length v1, v1

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    aget-object v0, v0, v1

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method zoomChanged(I)V
    .locals 5

    .prologue
    .line 384
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v1, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dx:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v2, v2, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dy:I

    invoke-virtual {v0, p1, v1, v2}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->moved(III)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 385
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->tag()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    iget v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 386
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mZoomText:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v2, v2, Lcom/mrkeyboard/app/MrBackdrop$Spec;->zoom:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "%"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 387
    return-void
.end method
