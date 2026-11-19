.class public Lcom/mrkeyboard/app/MrThemesActivity;
.super Landroid/app/Activity;
.source "MrThemesActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrThemesActivity$Card;
    }
.end annotation


# static fields
.field static final ACTION_PICK_IMAGES:Ljava/lang/String; = "android.provider.action.PICK_IMAGES"

.field static final CARD_BACKGROUND:I = 0x1

.field static final CARD_MINE:I = 0x3

.field static final CARD_PLUS:I = 0x2

.field static final CARD_THEME:I = 0x0

.field static final CHUNK:I = 0x3

.field static final COLUMNS:I = 0x1

.field static final IMAGES_URI:Ljava/lang/String; = "content://media/external/images/media"

.field static final REQ_PICK:I = 0x47

.field static final SCENE_SAMPLE:I = 0x2

.field static final SCROLL_MARGIN_DP:I = 0x14

.field static final SCROLL_THUMB_ALPHA:I = 0x59

.field static final TABS:I = 0xa

.field static final TAB_COLORS:I = 0x1

.field static final TAB_GALLERY:I = 0x9

.field static final TAB_GRADIENTS:I = 0x2

.field static final TAB_SCENES:I = 0x3

.field static final TAB_THEMES:I = 0x0

.field static final THEME_KEY:Ljava/lang/String; = "pref_keyboard_layout"

.field static final THUMB_SIDE:I = 0x140


# instance fields
.field k:Lcom/mrkeyboard/app/MrKit;

.field final mBgActions:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/widget/TextView;",
            ">;"
        }
    .end annotation
.end field

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

.field mBigScene:Landroid/graphics/Bitmap;

.field mBigSceneIndex:I

.field mBuilt:I

.field mCaption:Landroid/widget/TextView;

.field mCards:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrThemesActivity$Card;",
            ">;"
        }
    .end annotation
.end field

.field mDetail:Landroid/widget/TextView;

.field mDialog:Landroid/app/Dialog;

.field mDialogApply:Landroid/widget/TextView;

.field mDialogCancel:Landroid/widget/TextView;

.field mDialogCrop:Lcom/mrkeyboard/app/MrCropView;

.field mDialogNext:Landroid/widget/TextView;

.field mDialogPreview:Lcom/mrkeyboard/app/MrThemePreview;

.field mDialogSoft:Landroid/widget/SeekBar;

.field mGrid:Landroid/widget/LinearLayout;

.field mImage:Landroid/graphics/Bitmap;

.field mListed:I

.field mLoad:I

.field mMineTile:Lcom/mrkeyboard/app/MrThemePreview;

.field mNames:[Ljava/lang/String;

.field mPrefs:Landroid/content/SharedPreferences;

.field mRemove:Landroid/widget/TextView;

.field mRow:Landroid/widget/LinearLayout;

.field final mSceneBusy:[Z

.field final mScenes:[Landroid/graphics/Bitmap;

.field mScroll:Landroid/widget/ScrollView;

.field mSoft:I

.field mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

.field mStrip:Landroid/widget/HorizontalScrollView;

.field mStyle:I

.field mTab:I

.field mTabLoad:I

.field final mTabViews:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/widget/TextView;",
            ">;"
        }
    .end annotation
.end field

.field mTags:[Ljava/lang/String;

.field mTheme:I

.field final mThemeActions:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/widget/TextView;",
            ">;"
        }
    .end annotation
.end field

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


# direct methods
.method public constructor <init>()V
    .locals 4

    .prologue
    const/16 v3, 0x24

    const/4 v2, -0x1

    const/4 v1, 0x0

    .line 51
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 91
    new-array v0, v1, [Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    .line 92
    new-array v0, v1, [Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    .line 94
    new-array v0, v1, [Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    .line 99
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 108
    new-array v0, v3, [Landroid/graphics/Bitmap;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScenes:[Landroid/graphics/Bitmap;

    .line 109
    new-array v0, v3, [Z

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSceneBusy:[Z

    .line 111
    iput v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigSceneIndex:I

    .line 121
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    .line 123
    iput v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    .line 125
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    .line 129
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeTiles:Ljava/util/List;

    .line 130
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeActions:Ljava/util/List;

    .line 132
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    .line 133
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    .line 134
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgActions:Ljava/util/List;

    return-void
.end method

.method private addCard(Lcom/mrkeyboard/app/MrThemesActivity$Card;I)V
    .locals 9

    .prologue
    const/4 v4, 0x0

    .line 399
    rem-int/lit8 v6, p2, 0x1

    .line 400
    if-nez v6, :cond_0

    .line 401
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRow:Landroid/widget/LinearLayout;

    .line 402
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRow:Landroid/widget/LinearLayout;

    const/16 v1, 0x30

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 403
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRow:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v0

    if-nez v0, :cond_1

    move v0, v4

    :goto_0
    invoke-virtual {v3, v0}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v1, v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 405
    :cond_0
    new-instance v1, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    .line 406
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 408
    iget v0, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->kind:I

    packed-switch v0, :pswitch_data_0

    .line 438
    :pswitch_0
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$9;

    invoke-direct {v5, p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity$9;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrThemesActivity$Card;)V

    .line 443
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 444
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    iget-object v2, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 445
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgActions:Ljava/util/List;

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 448
    :goto_1
    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRow:Landroid/widget/LinearLayout;

    iget-object v2, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->name:Ljava/lang/String;

    iget v0, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->kind:I

    const/4 v8, 0x2

    if-ne v0, v8, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v8, "mr_themes_choose"

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v0, v8, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    :goto_2
    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemesActivity;->cardBox(Lcom/mrkeyboard/app/MrThemePreview;Ljava/lang/String;Landroid/widget/TextView;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/MrThemesActivity;->cardParams(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v7, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 449
    iget v2, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->kind:I

    iget v0, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->kind:I

    if-nez v0, :cond_3

    iget v0, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->index:I

    :goto_3
    invoke-direct {p0, v2, v1, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->bindCard(ILcom/mrkeyboard/app/MrThemePreview;I)V

    .line 450
    return-void

    .line 403
    :cond_1
    const/16 v0, 0xc

    goto :goto_0

    .line 410
    :pswitch_1
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$6;

    invoke-direct {v5, p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity$6;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrThemesActivity$Card;)V

    .line 415
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeTiles:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 416
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeActions:Ljava/util/List;

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 419
    :pswitch_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->card:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->stroke:I

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {v1, v0, v2, v5}, Lcom/mrkeyboard/app/MrThemePreview;->showPlus(III)V

    .line 420
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$7;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrThemesActivity$7;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    goto :goto_1

    .line 427
    :pswitch_3
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$8;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrThemesActivity$8;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    .line 432
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 433
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    iget-object v2, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 434
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgActions:Ljava/util/List;

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 435
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mMineTile:Lcom/mrkeyboard/app/MrThemePreview;

    goto :goto_1

    .line 448
    :cond_2
    const/4 v4, 0x0

    goto :goto_2

    .line 449
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    goto :goto_3

    .line 408
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method static backgroundName(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v3, 0x0

    .line 608
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    packed-switch v0, :pswitch_data_0

    .line 613
    const-string v0, ""

    .line 615
    :goto_0
    if-eqz v0, :cond_0

    :goto_1
    return-object v0

    .line 609
    :pswitch_0
    const-string v0, "mr_themes_color"

    new-array v1, v1, [Ljava/lang/Object;

    iget v2, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    add-int/lit8 v2, v2, 0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v1, v3

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 610
    :pswitch_1
    const-string v0, "mr_themes_gradient"

    new-array v1, v1, [Ljava/lang/Object;

    iget v2, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    add-int/lit8 v2, v2, 0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v1, v3

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 611
    :pswitch_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-static {v1}, Lcom/mrkeyboard/app/MrScenes;->category(I)I

    move-result v1

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->categoryName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " \u00b7 "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->sceneName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 612
    :pswitch_3
    const-string v0, "mr_themes_mine"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 615
    :cond_0
    const-string v0, ""

    goto :goto_1

    .line 608
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_0
    .end packed-switch
.end method

.method private bindCard(ILcom/mrkeyboard/app/MrThemePreview;I)V
    .locals 7

    .prologue
    const/4 v6, 0x3

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 485
    if-nez p1, :cond_2

    .line 486
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    aget-object v0, v0, p3

    sget-object v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    const/4 v4, 0x0

    invoke-virtual {p2, v0, v3, v4, v2}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 487
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-nez v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    if-ne p3, v0, :cond_0

    move v2, v1

    .line 488
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->accent:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    invoke-virtual {p2, v2, v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->setChecked(ZII)V

    .line 489
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeActions:Ljava/util/List;

    invoke-interface {v0, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    invoke-virtual {p2}, Lcom/mrkeyboard/app/MrThemePreview;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    check-cast v1, Landroid/view/View;

    invoke-direct {p0, v0, v2, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->markAction(Landroid/widget/TextView;ZLandroid/view/View;)V

    .line 497
    :cond_1
    :goto_0
    return-void

    .line 490
    :cond_2
    if-eq p1, v1, :cond_3

    if-ne p1, v6, :cond_1

    .line 491
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    invoke-interface {v0, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->tileSpec(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v3

    .line 492
    invoke-static {v3}, Lcom/mrkeyboard/app/MrBackdrop;->themeTag(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->tileImage(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Landroid/graphics/Bitmap;

    move-result-object v5

    iget v0, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v6, :cond_6

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    :goto_1
    invoke-virtual {p2, v4, v3, v5, v0}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 493
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eqz v0, :cond_5

    iget v0, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v4, v4, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v4, :cond_5

    iget v0, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eq v0, v6, :cond_4

    iget v0, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v3, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    if-ne v0, v3, :cond_5

    :cond_4
    move v2, v1

    .line 494
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->accent:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    invoke-virtual {p2, v2, v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->setChecked(ZII)V

    .line 495
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgActions:Ljava/util/List;

    invoke-interface {v0, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    invoke-virtual {p2}, Lcom/mrkeyboard/app/MrThemePreview;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    check-cast v1, Landroid/view/View;

    invoke-direct {p0, v0, v2, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->markAction(Landroid/widget/TextView;ZLandroid/view/View;)V

    goto :goto_0

    :cond_6
    move v0, v2

    .line 492
    goto :goto_1
.end method

.method private cardBox(Lcom/mrkeyboard/app/MrThemePreview;Ljava/lang/String;Landroid/widget/TextView;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;
    .locals 10

    .prologue
    const/high16 v9, 0x40000000    # 2.0f

    const/high16 v6, 0x40800000    # 4.0f

    const/4 v8, -0x2

    const/high16 v5, 0x40c00000    # 6.0f

    const/4 v7, 0x0

    .line 457
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 458
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 459
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->card:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->stroke:I

    const/high16 v4, 0x41400000    # 12.0f

    invoke-virtual {v1, v2, v3, v4, v7}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 460
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 461
    invoke-virtual {v0, p5}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 462
    invoke-virtual {v0, p2}, Landroid/widget/LinearLayout;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 463
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, -0x1

    invoke-direct {v1, v2, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, p1, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 464
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 465
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v1, v2, v7, v3, v7}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 466
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41500000    # 13.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v2, p2, v3, v4, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    .line 467
    const/4 v3, 0x2

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 468
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v3, v7, v8, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 469
    const/high16 v2, 0x41400000    # 12.0f

    invoke-virtual {p3, v2}, Landroid/widget/TextView;->setTextSize(F)V

    .line 470
    const/16 v2, 0x11

    invoke-virtual {p3, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 471
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41200000    # 10.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41200000    # 10.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {p3, v2, v3, v4, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 472
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x42200000    # 40.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p3, v2}, Landroid/widget/TextView;->setMinWidth(I)V

    .line 473
    if-eqz p4, :cond_0

    :goto_0
    invoke-virtual {p3, p4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 474
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {p3, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 475
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->raised:I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->card:I

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->accent:I

    const/high16 v6, 0x3f000000    # 0.5f

    invoke-static {v4, v5, v6}, Lcom/mrkeyboard/app/MrBackdrop;->mix(IIF)I

    move-result v4

    const/high16 v5, 0x41000000    # 8.0f

    invoke-virtual {v2, v3, v4, v5, v7}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v2

    invoke-virtual {p3, v2}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 476
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v8, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, p3, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 477
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    .line 478
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41000000    # 8.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v2, v7, v3, v7, v4}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 479
    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 480
    return-object v0

    .line 473
    :cond_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_view"

    new-array v4, v7, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p4

    goto :goto_0
.end method

.method private cardParams(I)Landroid/widget/LinearLayout$LayoutParams;
    .locals 5

    .prologue
    const/high16 v4, 0x40c00000    # 6.0f

    const/4 v1, 0x0

    .line 383
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v0, -0x2

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-direct {v3, v1, v0, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 384
    if-nez p1, :cond_0

    move v2, v1

    :goto_0
    if-nez p1, :cond_1

    move v0, v1

    :goto_1
    invoke-virtual {v3, v2, v1, v0, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 385
    return-object v3

    .line 384
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

.method static categoryName(Landroid/content/Context;I)Ljava/lang/String;
    .locals 2

    .prologue
    .line 589
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mr_themes_scene_cat_"

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

    .line 590
    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    const-string v0, ""

    goto :goto_0
.end method

.method private fillRow(Landroid/widget/LinearLayout;I)V
    .locals 3

    .prologue
    .line 390
    if-nez p1, :cond_1

    .line 395
    :cond_0
    return-void

    .line 391
    :cond_1
    rem-int/lit8 v0, p2, 0x1

    :goto_0
    if-eqz v0, :cond_0

    const/4 v1, 0x1

    if-ge v0, v1, :cond_0

    .line 392
    new-instance v1, Landroid/view/View;

    invoke-direct {v1, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 393
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->cardParams(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {p1, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 391
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method static kindName(Landroid/content/Context;I)Ljava/lang/String;
    .locals 2

    .prologue
    .line 595
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mr_themes_kind_"

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

    .line 596
    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    const-string v0, ""

    goto :goto_0
.end method

.method private markAction(Landroid/widget/TextView;ZLandroid/view/View;)V
    .locals 7

    .prologue
    const/high16 v6, 0x41000000    # 8.0f

    const/4 v5, 0x0

    .line 501
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    if-eqz p2, :cond_1

    const-string v0, "mr_themes_in_use"

    :goto_0
    new-array v2, v5, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 502
    if-eqz p2, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    :goto_1
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 503
    if-eqz p2, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {v0, v1, v5, v6, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    :goto_2
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 504
    if-eqz p3, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v0, Lcom/mrkeyboard/app/MrKit;->card:I

    if-eqz p2, :cond_4

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->accent:I

    :goto_3
    const/high16 v3, 0x41400000    # 12.0f

    invoke-virtual {v1, v2, v0, v3, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {p3, v0}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 505
    :cond_0
    return-void

    .line 501
    :cond_1
    const-string v0, "mr_themes_view"

    goto :goto_0

    .line 502
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->accent:I

    goto :goto_1

    .line 503
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->raised:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->card:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->accent:I

    const/high16 v4, 0x3f000000    # 0.5f

    invoke-static {v2, v3, v4}, Lcom/mrkeyboard/app/MrBackdrop;->mix(IIF)I

    move-result v2

    invoke-virtual {v0, v1, v2, v6, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    goto :goto_2

    .line 504
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    goto :goto_3
.end method

.method private newDialog(Z)Landroid/app/Dialog;
    .locals 5

    .prologue
    const/4 v1, -0x1

    .line 674
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v2, "Theme.MrKeyboard.Dialog"

    const-string v3, "style"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 675
    new-instance v2, Landroid/app/Dialog;

    invoke-direct {v2, p0, v0}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V

    .line 676
    const/4 v0, 0x1

    invoke-virtual {v2, v0}, Landroid/app/Dialog;->requestWindowFeature(I)Z

    .line 677
    invoke-virtual {v2}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v3

    .line 678
    if-eqz v3, :cond_0

    .line 680
    new-instance v4, Landroid/graphics/drawable/ColorDrawable;

    if-eqz p1, :cond_1

    const/high16 v0, -0x1000000

    :goto_0
    invoke-direct {v4, v0}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v3, v4}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 681
    if-eqz p1, :cond_2

    move v0, v1

    :goto_1
    invoke-virtual {v3, v1, v0}, Landroid/view/Window;->setLayout(II)V

    .line 682
    if-nez p1, :cond_0

    const/16 v0, 0x50

    invoke-virtual {v3, v0}, Landroid/view/Window;->setGravity(I)V

    .line 684
    :cond_0
    return-object v2

    .line 680
    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    .line 681
    :cond_2
    const/4 v0, -0x2

    goto :goto_1
.end method

.method static pickers(I)Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)",
            "Ljava/util/List",
            "<",
            "Landroid/content/Intent;",
            ">;"
        }
    .end annotation

    .prologue
    .line 956
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 957
    const/16 v1, 0x1e

    if-lt p0, v1, :cond_0

    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.provider.action.PICK_IMAGES"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v2, "image/*"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 958
    :cond_0
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.PICK"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v2, "content://media/external/images/media"

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    const-string v3, "image/*"

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 959
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 960
    const-string v2, "android.intent.category.OPENABLE"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 961
    const-string v2, "image/*"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 962
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 963
    return-object v0
.end method

.method static sceneName(Landroid/content/Context;I)Ljava/lang/String;
    .locals 2

    .prologue
    .line 583
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

    .line 584
    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    const-string v0, ""

    goto :goto_0
.end method

.method private sheetBox(Ljava/lang/String;)Landroid/widget/LinearLayout;
    .locals 7

    .prologue
    const/high16 v4, 0x41a00000    # 20.0f

    const/high16 v6, 0x41900000    # 18.0f

    const/4 v5, 0x0

    .line 699
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 700
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 701
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->solidBg()I

    move-result v2

    const/high16 v3, 0x41b00000    # 22.0f

    invoke-virtual {v1, v2, v5, v3, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 702
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x41800000    # 16.0f

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v4, 0x1

    invoke-virtual {v1, p1, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v5}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 703
    return-object v0
.end method

.method private sheetShow(Landroid/app/Dialog;Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrThemePreview;Landroid/widget/SeekBar;ZLjava/lang/Runnable;)V
    .locals 9

    .prologue
    .line 708
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 709
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0x12

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p2, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 710
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_cancel"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    new-instance v4, Lcom/mrkeyboard/app/MrThemesActivity$10;

    invoke-direct {v4, p0, p5}, Lcom/mrkeyboard/app/MrThemesActivity$10;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Z)V

    invoke-virtual {v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v1

    .line 716
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_themes_apply"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$11;

    invoke-direct {v5, p0, p6}, Lcom/mrkeyboard/app/MrThemesActivity$11;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Ljava/lang/Runnable;)V

    invoke-virtual {v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    .line 722
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, 0x0

    const/4 v5, -0x2

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-direct {v3, v4, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 723
    const/4 v4, 0x0

    const/4 v5, 0x0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x40c00000    # 6.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    const/4 v7, 0x0

    invoke-virtual {v3, v4, v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 724
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, 0x0

    const/4 v6, -0x2

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-direct {v4, v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 725
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x40c00000    # 6.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-virtual {v4, v5, v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 726
    invoke-virtual {v0, v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 727
    invoke-virtual {v0, v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 728
    invoke-virtual {p1, p2}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 729
    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$12;

    invoke-direct {v0, p0, p5}, Lcom/mrkeyboard/app/MrThemesActivity$12;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Z)V

    invoke-virtual {p1, v0}, Landroid/app/Dialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    .line 734
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialog:Landroid/app/Dialog;

    .line 735
    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogPreview:Lcom/mrkeyboard/app/MrThemePreview;

    .line 736
    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogSoft:Landroid/widget/SeekBar;

    .line 737
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCancel:Landroid/widget/TextView;

    .line 738
    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogApply:Landroid/widget/TextView;

    .line 739
    invoke-virtual {p1}, Landroid/app/Dialog;->show()V

    .line 740
    return-void
.end method

.method private side(I)Landroid/widget/LinearLayout$LayoutParams;
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 377
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x1

    const/4 v2, -0x2

    invoke-direct {v0, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 378
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    int-to-float v2, p1

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {v0, v4, v1, v2, v4}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 379
    return-object v0
.end method

.method static styleName(Landroid/content/Context;I)Ljava/lang/String;
    .locals 2

    .prologue
    .line 601
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mr_themes_style_"

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

    .line 602
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

    .line 1119
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 1120
    const/16 v1, 0x140

    if-gt v0, v1, :cond_0

    .line 1122
    :goto_0
    return-object p0

    .line 1121
    :cond_0
    const/high16 v1, 0x43a00000    # 320.0f

    int-to-float v0, v0

    div-float v0, v1, v0

    .line 1122
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


# virtual methods
.method applyBackdrop(Lcom/mrkeyboard/app/MrBackdrop$Spec;IIZ)V
    .locals 8

    .prologue
    const/4 v7, 0x3

    const/4 v6, 0x0

    .line 647
    .line 648
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v7, :cond_1

    if-eqz p4, :cond_1

    .line 650
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->commitPending(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 651
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_image_failed"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    .line 669
    :goto_0
    return-void

    .line 654
    :cond_0
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->zoom:I

    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dx:I

    iget v2, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dy:I

    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->imageStamp(Landroid/content/Context;)J

    move-result-wide v4

    invoke-static {v0, v1, v2, v4, v5}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->image(IIIJ)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object p1

    .line 656
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    invoke-static {p1, p3}, Lcom/mrkeyboard/app/MrBackdrop;->themeTag(Lcom/mrkeyboard/app/MrBackdrop$Spec;I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrThemeColors;->indexOfTag([Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 657
    if-gez v0, :cond_2

    .line 658
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_image_failed"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 661
    :cond_2
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 662
    const-string v2, "pref_keyboard_layout"

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    array-length v3, v3

    if-ge v0, v3, :cond_5

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    aget-object v0, v3, v0

    :goto_1
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 663
    const-string v0, "pref_kbd_bg"

    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->format()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 664
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v2, 0x4

    if-eq v0, v2, :cond_3

    const-string v0, "pref_kbd_bg_soft"

    const/16 v2, 0x46

    invoke-static {p2, v6, v2}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v2

    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 665
    :cond_3
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 666
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->readPrefs()V

    .line 667
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v7, :cond_4

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->loadImage()V

    .line 668
    :cond_4
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->galleryChanged()V

    goto :goto_0

    .line 662
    :cond_5
    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 147
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 148
    return-void
.end method

.method bigImage(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Landroid/graphics/Bitmap;
    .locals 2

    .prologue
    .line 537
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 545
    :goto_0
    return-object v0

    .line 538
    :cond_0
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_3

    .line 539
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigScene:Landroid/graphics/Bitmap;

    if-eqz v0, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigSceneIndex:I

    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    if-eq v0, v1, :cond_2

    .line 540
    :cond_1
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrScenes;->load(Landroid/content/Context;I)Landroid/graphics/Bitmap;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigScene:Landroid/graphics/Bitmap;

    .line 541
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigSceneIndex:I

    .line 543
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigScene:Landroid/graphics/Bitmap;

    goto :goto_0

    .line 545
    :cond_3
    const/4 v0, 0x0

    goto :goto_0
.end method

.method buildMore(I)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 329
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabLoad:I

    if-ne p1, v0, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 352
    :cond_0
    :goto_0
    return-void

    .line 330
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    add-int/lit8 v1, v1, 0x3

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 331
    :goto_1
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    if-ge v0, v1, :cond_2

    .line 332
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->addCard(Lcom/mrkeyboard/app/MrThemesActivity$Card;I)V

    .line 333
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    goto :goto_1

    .line 335
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ge v0, v1, :cond_3

    .line 336
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    new-instance v1, Lcom/mrkeyboard/app/MrThemesActivity$3;

    invoke-direct {v1, p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity$3;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    .line 343
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRow:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->fillRow(Landroid/widget/LinearLayout;I)V

    .line 344
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    const/16 v1, 0x9

    if-ne v0, v1, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->hasImage(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 345
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_remove"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$4;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrThemesActivity$4;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    invoke-virtual {v0, v1, v4, v2}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRemove:Landroid/widget/TextView;

    .line 350
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRemove:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0x14

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0
.end method

.method caption()Ljava/lang/String;
    .locals 2

    .prologue
    .line 564
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->backgroundName(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;

    move-result-object v0

    .line 565
    :goto_0
    return-object v0

    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mListed:I

    if-ge v0, v1, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    array-length v1, v1

    if-ge v0, v1, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    aget-object v0, v0, v1

    goto :goto_0

    :cond_1
    const-string v0, ""

    goto :goto_0
.end method

.method cardsOf(I)Ljava/util/List;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrThemesActivity$Card;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v7, 0x0

    const/4 v6, 0x2

    const/4 v9, 0x1

    const/4 v1, 0x0

    .line 277
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 278
    if-nez p1, :cond_1

    move v0, v1

    .line 279
    :goto_0
    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mListed:I

    if-ge v0, v2, :cond_4

    .line 280
    new-instance v4, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    array-length v2, v2

    if-ge v0, v2, :cond_0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    aget-object v2, v2, v0

    :goto_1
    invoke-direct {v4, v1, v0, v7, v2}, Lcom/mrkeyboard/app/MrThemesActivity$Card;-><init>(IILcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;)V

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 279
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 280
    :cond_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    aget-object v2, v2, v0

    goto :goto_1

    .line 282
    :cond_1
    if-ne p1, v9, :cond_2

    move v0, v1

    .line 283
    :goto_2
    sget-object v2, Lcom/mrkeyboard/app/MrBackdrop;->COLORS:[I

    array-length v2, v2

    if-ge v0, v2, :cond_4

    .line 284
    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->color(I)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_themes_color"

    new-array v7, v9, [Ljava/lang/Object;

    add-int/lit8 v8, v0, 0x1

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v7, v1

    invoke-virtual {v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v2, v9, v0, v4, v5}, Lcom/mrkeyboard/app/MrThemesActivity$Card;-><init>(IILcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;)V

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 283
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 286
    :cond_2
    if-ne p1, v6, :cond_3

    move v0, v1

    .line 287
    :goto_3
    sget v2, Lcom/mrkeyboard/app/MrBackdrop;->GRADIENT_COUNT:I

    if-ge v0, v2, :cond_4

    .line 288
    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->gradient(I)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_themes_gradient"

    new-array v7, v9, [Ljava/lang/Object;

    add-int/lit8 v8, v0, 0x1

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v7, v1

    invoke-virtual {v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v2, v9, v0, v4, v5}, Lcom/mrkeyboard/app/MrThemesActivity$Card;-><init>(IILcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;)V

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 287
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 290
    :cond_3
    const/16 v0, 0x9

    if-ne p1, v0, :cond_5

    .line 291
    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_themes_photo"

    new-array v5, v1, [Ljava/lang/Object;

    invoke-virtual {v2, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v6, v1, v7, v2}, Lcom/mrkeyboard/app/MrThemesActivity$Card;-><init>(IILcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;)V

    invoke-interface {v3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 292
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->hasImage(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_4

    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    const/4 v2, 0x3

    const/16 v4, 0x64

    const-wide/16 v6, 0x0

    invoke-static {v4, v1, v1, v6, v7}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->image(IIIJ)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_themes_mine"

    new-array v7, v1, [Ljava/lang/Object;

    invoke-virtual {v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v0, v2, v1, v4, v5}, Lcom/mrkeyboard/app/MrThemesActivity$Card;-><init>(IILcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;)V

    invoke-interface {v3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 300
    :cond_4
    return-object v3

    .line 294
    :cond_5
    add-int/lit8 v0, p1, -0x3

    .line 295
    :goto_4
    const/4 v2, 0x6

    if-ge v1, v2, :cond_4

    .line 296
    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrScenes;->scene(II)I

    move-result v2

    .line 297
    new-instance v4, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->scene(I)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v5

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->sceneName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v9, v2, v5, v6}, Lcom/mrkeyboard/app/MrThemesActivity$Card;-><init>(IILcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;)V

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 295
    add-int/lit8 v1, v1, 0x1

    goto :goto_4
.end method

.method chooseTheme(I)V
    .locals 3

    .prologue
    .line 622
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

    const-string v1, "pref_kbd_bg"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 623
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->readPrefs()V

    .line 624
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    .line 625
    return-void

    .line 622
    :cond_0
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method closeDialog()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 688
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialog:Landroid/app/Dialog;

    .line 689
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialog:Landroid/app/Dialog;

    .line 690
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogPreview:Lcom/mrkeyboard/app/MrThemePreview;

    .line 691
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCrop:Lcom/mrkeyboard/app/MrCropView;

    .line 692
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogSoft:Landroid/widget/SeekBar;

    .line 693
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogNext:Landroid/widget/TextView;

    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCancel:Landroid/widget/TextView;

    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogApply:Landroid/widget/TextView;

    .line 694
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V

    .line 695
    :cond_0
    return-void
.end method

.method detail()Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 573
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_theme_one"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 578
    :cond_0
    :goto_0
    return-object v0

    .line 574
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->tabOfChoice()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->tabName(I)Ljava/lang/String;

    move-result-object v0

    .line 575
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->hasStyles(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 576
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_keys"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStyle:I

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v1

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->kindName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " \u00b7 "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStyle:I

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->styleName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method editImage()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 1032
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    if-nez v0, :cond_0

    .line 1035
    :goto_0
    return-void

    .line 1033
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 1034
    :goto_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    invoke-virtual {p0, v1, v0, v2, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->showCrop(Landroid/graphics/Bitmap;Lcom/mrkeyboard/app/MrBackdrop$Spec;IZ)V

    goto :goto_0

    .line 1033
    :cond_1
    const/16 v0, 0x64

    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->imageStamp(Landroid/content/Context;)J

    move-result-wide v2

    invoke-static {v0, v4, v4, v2, v3}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->image(IIIJ)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    goto :goto_1
.end method

.method galleryChanged()V
    .locals 2

    .prologue
    const/16 v1, 0x9

    .line 559
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    .line 560
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    if-ne v0, v1, :cond_0

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->showTab(I)V

    .line 561
    :cond_0
    return-void
.end method

.method imported(Landroid/graphics/Bitmap;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 1018
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1019
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->discardPending(Landroid/content/Context;)V

    .line 1028
    :goto_0
    return-void

    .line 1022
    :cond_0
    if-nez p1, :cond_1

    .line 1023
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->discardPending(Landroid/content/Context;)V

    .line 1024
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_image_failed"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 1027
    :cond_1
    const/16 v0, 0x64

    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->pendingStamp(Landroid/content/Context;)J

    move-result-wide v2

    invoke-static {v0, v4, v4, v2, v3}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->image(IIIJ)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    const/4 v2, 0x1

    invoke-virtual {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->showCrop(Landroid/graphics/Bitmap;Lcom/mrkeyboard/app/MrBackdrop$Spec;IZ)V

    goto :goto_0
.end method

.method loadImage()V
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 1052
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->hasImage(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1053
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 1054
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 1072
    :goto_0
    return-void

    .line 1057
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    .line 1058
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$23;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$23;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 1071
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method loadScenes(I)V
    .locals 5

    .prologue
    .line 1079
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 1080
    const/4 v0, 0x0

    :goto_0
    const/4 v2, 0x6

    if-ge v0, v2, :cond_1

    .line 1081
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrScenes;->scene(II)I

    move-result v2

    .line 1082
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScenes:[Landroid/graphics/Bitmap;

    aget-object v3, v3, v2

    if-nez v3, :cond_0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSceneBusy:[Z

    aget-boolean v3, v3, v2

    if-nez v3, :cond_0

    .line 1083
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSceneBusy:[Z

    const/4 v4, 0x1

    aput-boolean v4, v3, v2

    .line 1084
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1080
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1087
    :cond_1
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1102
    :goto_1
    return-void

    .line 1088
    :cond_2
    new-instance v0, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$24;

    invoke-direct {v2, p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity$24;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Ljava/util/List;)V

    invoke-direct {v0, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 1101
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    goto :goto_1
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 3

    .prologue
    .line 983
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 984
    const/16 v0, 0x47

    if-ne p1, v0, :cond_0

    const/4 v0, -0x1

    if-ne p2, v0, :cond_0

    if-nez p3, :cond_1

    .line 1014
    :cond_0
    :goto_0
    return-void

    .line 985
    :cond_1
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    .line 986
    if-eqz v0, :cond_0

    .line 988
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$22;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$22;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/net/Uri;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 1013
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 14

    .prologue
    const/4 v13, 0x1

    const/high16 v12, 0x41600000    # 14.0f

    const/high16 v11, 0x41000000    # 8.0f

    const/4 v10, -0x2

    const/4 v1, 0x0

    .line 152
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 153
    new-instance v0, Lcom/mrkeyboard/app/MrKit;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrKit;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 154
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    .line 155
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->tags(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    .line 156
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->names(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    .line 157
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->values(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    .line 158
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrThemeColors;->listed([Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mListed:I

    .line 159
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->readPrefs()V

    .line 161
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    .line 162
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->bg:I

    const/4 v4, 0x0

    invoke-virtual {v0, v3, v1, v4, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 164
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-virtual {v0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41800000    # 16.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v2, v0, v3, v1, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 165
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_themes_title"

    new-array v5, v1, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrThemesActivity$1;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrThemesActivity$1;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    invoke-virtual {v0, v3, v4}, Lcom/mrkeyboard/app/MrKit;->backHeader(Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 169
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->side(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 165
    invoke-virtual {v2, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 173
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 174
    const/16 v3, 0x10

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 175
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41200000    # 10.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41200000    # 10.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41400000    # 12.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x41200000    # 10.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-virtual {v0, v3, v4, v5, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 176
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->card:I

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->card:I

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->accent:I

    const v7, 0x3f0ccccd    # 0.55f

    invoke-static {v5, v6, v7}, Lcom/mrkeyboard/app/MrBackdrop;->mix(IIF)I

    move-result v5

    invoke-virtual {v3, v4, v5, v12, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 177
    new-instance v3, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    .line 178
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const v5, 0x3fa66666    # 1.3f

    invoke-direct {v4, v1, v10, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 179
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v3

    .line 180
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v12}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v3, v4, v1, v1, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 181
    const/16 v4, 0x10

    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 182
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_themes_current"

    new-array v7, v1, [Ljava/lang/Object;

    invoke-virtual {v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    sget-object v6, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v5, v6}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v5

    const/high16 v6, 0x41300000    # 11.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    invoke-virtual {v4, v5, v6, v7, v13}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    .line 183
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v5, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x40400000    # 3.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v7, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v7

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v9, 0x40400000    # 3.0f

    invoke-virtual {v8, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v8

    invoke-virtual {v4, v5, v6, v7, v8}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 184
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {v5, v6, v1, v11, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 185
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v5, v10, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 186
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, ""

    const/high16 v6, 0x41880000    # 17.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v4, v5, v6, v7, v13}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    .line 187
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    const/4 v5, 0x2

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 188
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v6, 0x8

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 189
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, ""

    const/high16 v6, 0x41500000    # 13.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v4, v5, v6, v7, v1}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDetail:Landroid/widget/TextView;

    .line 190
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDetail:Landroid/widget/TextView;

    const/4 v5, 0x3

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 191
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDetail:Landroid/widget/TextView;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v6, 0x4

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 192
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v4, v1, v10, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 193
    const/16 v3, 0xc

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->side(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 196
    new-instance v0, Landroid/widget/HorizontalScrollView;

    invoke-direct {v0, p0}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    .line 197
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    invoke-virtual {v0, v1}, Landroid/widget/HorizontalScrollView;->setHorizontalScrollBarEnabled(Z)V

    .line 198
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v3

    move v0, v1

    .line 199
    :goto_0
    const/16 v4, 0xa

    if-ge v0, v4, :cond_1

    .line 201
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->tabName(I)Ljava/lang/String;

    move-result-object v5

    const/high16 v6, 0x41700000    # 15.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v4, v5, v6, v7, v1}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    .line 202
    const/16 v5, 0x11

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setGravity(I)V

    .line 203
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v5, v12}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v7, v12}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v7

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v8, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v8

    invoke-virtual {v4, v5, v6, v7, v8}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 204
    invoke-virtual {v4, v13}, Landroid/widget/TextView;->setClickable(Z)V

    .line 205
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$2;

    invoke-direct {v5, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$2;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 210
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v5, v10, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 211
    if-lez v0, :cond_0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x40c00000    # 6.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-virtual {v5, v6, v1, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 212
    :cond_0
    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 213
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    invoke-interface {v5, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 199
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 215
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    new-instance v4, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v4, v10, v10}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v3, v4}, Landroid/widget/HorizontalScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 216
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    const/16 v3, 0xe

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->side(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 220
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    .line 221
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41a00000    # 20.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v0, v1, v1, v3, v1}, Landroid/widget/ScrollView;->setPadding(IIII)V

    .line 222
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setClipToPadding(Z)V

    .line 223
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    const/high16 v3, 0x2000000

    invoke-virtual {v0, v3}, Landroid/widget/ScrollView;->setScrollBarStyle(I)V

    .line 224
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x40400000    # 3.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v0, v3}, Landroid/widget/ScrollView;->setScrollBarSize(I)V

    .line 225
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v0, v13}, Landroid/widget/ScrollView;->setScrollbarFadingEnabled(Z)V

    .line 226
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1d

    if-lt v0, v3, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x59000000

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    const v6, 0xffffff

    and-int/2addr v5, v6

    or-int/2addr v4, v5

    const/high16 v5, 0x40000000    # 2.0f

    invoke-virtual {v3, v4, v1, v5, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/ScrollView;->setVerticalScrollbarThumbDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 227
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    .line 228
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41c00000    # 24.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v0, v1, v1, v1, v3}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 229
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    new-instance v4, Landroid/view/ViewGroup$LayoutParams;

    const/4 v5, -0x1

    invoke-direct {v4, v5, v10}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v3, v4}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 230
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x1

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v0, v3, v1, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 231
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41400000    # 12.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v0, v1, v3, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 232
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v2, v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 234
    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->setContentView(Landroid/view/View;)V

    .line 235
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    .line 236
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->tabOfChoice()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->showTab(I)V

    .line 237
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->loadImage()V

    .line 238
    return-void
.end method

.method protected onDestroy()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 242
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    .line 243
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabLoad:I

    .line 244
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closeDialog()V

    .line 246
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->discardPending(Landroid/content/Context;)V

    .line 247
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 248
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 249
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigScene:Landroid/graphics/Bitmap;

    .line 250
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 251
    return-void
.end method

.method openBackdrop(Lcom/mrkeyboard/app/MrBackdrop$Spec;)V
    .locals 3

    .prologue
    .line 629
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    .line 630
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->editImage()V

    .line 634
    :goto_0
    return-void

    .line 633
    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity;->startSoft(Lcom/mrkeyboard/app/MrBackdrop$Spec;)I

    move-result v1

    const/4 v2, 0x0

    invoke-virtual {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->showPreview(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;IZ)V

    goto :goto_0
.end method

.method pick()V
    .locals 5

    .prologue
    const/4 v2, 0x0

    .line 967
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrThemesActivity;->pickers(I)Ljava/util/List;

    move-result-object v3

    move v1, v2

    .line 968
    :goto_0
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    .line 970
    :try_start_0
    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/Intent;

    const/16 v4, 0x47

    invoke-virtual {p0, v0, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 979
    :goto_1
    return-void

    .line 974
    :catch_0
    move-exception v0

    .line 968
    :goto_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 978
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_image_failed"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v1, v3, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_1

    .line 972
    :catch_1
    move-exception v0

    goto :goto_2
.end method

.method readPrefs()V
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 511
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    const-string v3, "pref_keyboard_layout"

    const-string v4, "0"

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrThemeColors;->indexOf([Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    .line 513
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    array-length v2, v2

    if-ge v0, v2, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    aget-object v0, v0, v2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrThemeColors;->hidden(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    move v2, v0

    .line 514
    :goto_0
    if-eqz v2, :cond_1

    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    :goto_1
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 515
    if-eqz v2, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    aget-object v0, v0, v1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->styleOf(Ljava/lang/String;)I

    move-result v0

    :goto_2
    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStyle:I

    .line 516
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->soft(Landroid/content/Context;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    .line 517
    return-void

    :cond_0
    move v2, v1

    .line 513
    goto :goto_0

    .line 514
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    goto :goto_1

    :cond_2
    move v0, v1

    .line 515
    goto :goto_2
.end method

.method refresh()V
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 550
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->tag()Ljava/lang/String;

    move-result-object v1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->bigImage(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Landroid/graphics/Bitmap;

    move-result-object v4

    iget v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    invoke-virtual {v0, v1, v3, v4, v5}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 551
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->caption()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 552
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDetail:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->detail()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    move v1, v2

    .line 553
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeTiles:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeTiles:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-direct {p0, v2, v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->bindCard(ILcom/mrkeyboard/app/MrThemePreview;I)V

    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 554
    :cond_0
    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v2, v0, :cond_1

    const/4 v1, 0x1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-direct {p0, v1, v0, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->bindCard(ILcom/mrkeyboard/app/MrThemePreview;I)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 555
    :cond_1
    return-void
.end method

.method removeImage()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 1038
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->removeImage(Landroid/content/Context;)V

    .line 1039
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    .line 1041
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "pref_kbd_bg"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "pref_keyboard_layout"

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    array-length v0, v0

    if-lez v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    const/4 v3, 0x0

    aget-object v0, v0, v3

    :goto_0
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 1043
    :cond_0
    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 1044
    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 1045
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    .line 1046
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->readPrefs()V

    .line 1047
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->galleryChanged()V

    .line 1048
    return-void

    .line 1041
    :cond_1
    const-string v0, "0"

    goto :goto_0
.end method

.method sceneLoaded(ILandroid/graphics/Bitmap;)V
    .locals 5

    .prologue
    const/4 v3, 0x0

    .line 1106
    if-ltz p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScenes:[Landroid/graphics/Bitmap;

    array-length v0, v0

    if-lt p1, v0, :cond_1

    .line 1115
    :cond_0
    return-void

    .line 1107
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScenes:[Landroid/graphics/Bitmap;

    aput-object p2, v0, p1

    .line 1108
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSceneBusy:[Z

    aput-boolean v3, v0, p1

    move v2, v3

    .line 1109
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v2, v0, :cond_0

    .line 1110
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 1111
    iget v1, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v4, 0x2

    if-ne v1, v4, :cond_2

    iget v1, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    if-ne v1, p1, :cond_2

    .line 1112
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->themeTag(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4, v0, p2, v3}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 1109
    :cond_2
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0
.end method

.method showCrop(Landroid/graphics/Bitmap;Lcom/mrkeyboard/app/MrBackdrop$Spec;IZ)V
    .locals 17

    .prologue
    .line 875
    if-nez p1, :cond_0

    .line 947
    :goto_0
    return-void

    .line 876
    :cond_0
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closeDialog()V

    .line 877
    const/4 v2, 0x1

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->newDialog(Z)Landroid/app/Dialog;

    move-result-object v9

    .line 878
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v10

    .line 879
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41800000    # 16.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41c00000    # 24.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41800000    # 16.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41800000    # 16.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v10, v2, v3, v4, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 880
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_themes_crop_hint"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/high16 v4, 0x41800000    # 16.0f

    const/4 v5, -0x1

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    .line 881
    const/16 v3, 0x11

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setGravity(I)V

    .line 882
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v10, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 883
    new-instance v2, Lcom/mrkeyboard/app/MrCropView;

    move-object/from16 v0, p0

    invoke-direct {v2, v0}, Lcom/mrkeyboard/app/MrCropView;-><init>(Landroid/content/Context;)V

    .line 884
    move-object/from16 v0, p2

    iget v4, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->zoom:I

    move-object/from16 v0, p2

    iget v5, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dx:I

    move-object/from16 v0, p2

    iget v6, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dy:I

    move-object/from16 v3, p1

    move/from16 v7, p3

    invoke-virtual/range {v2 .. v7}, Lcom/mrkeyboard/app/MrCropView;->set(Landroid/graphics/Bitmap;IIII)V

    .line 885
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, -0x1

    const/4 v5, 0x0

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-direct {v3, v4, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 886
    const/4 v4, 0x0

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41600000    # 14.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    const/4 v6, 0x0

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v8, 0x41200000    # 10.0f

    invoke-virtual {v7, v8}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v7

    invoke-virtual {v3, v4, v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 887
    invoke-virtual {v10, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 889
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v3

    .line 890
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    invoke-virtual {v10, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 891
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_themes_soften"

    const/4 v7, 0x0

    new-array v7, v7, [Ljava/lang/Object;

    invoke-virtual {v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    const/high16 v6, 0x41800000    # 16.0f

    const/4 v7, -0x1

    const/4 v8, 0x1

    invoke-virtual {v4, v5, v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, 0x0

    const/4 v7, -0x2

    const/high16 v8, 0x3f800000    # 1.0f

    invoke-direct {v5, v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 892
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v0, p3

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "%"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    const/high16 v6, 0x41800000    # 16.0f

    const v7, -0x37332a

    const/4 v8, 0x0

    invoke-virtual {v4, v5, v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    .line 893
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x2

    const/4 v7, -0x2

    invoke-direct {v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 894
    const/4 v3, 0x1

    new-array v8, v3, [I

    const/4 v3, 0x0

    aput p3, v8, v3

    .line 895
    new-instance v11, Landroid/widget/SeekBar;

    move-object/from16 v0, p0

    invoke-direct {v11, v0}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    .line 896
    const/16 v3, 0x46

    invoke-virtual {v11, v3}, Landroid/widget/SeekBar;->setMax(I)V

    .line 897
    move/from16 v0, p3

    invoke-virtual {v11, v0}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 898
    new-instance v3, Lcom/mrkeyboard/app/MrThemesActivity$18;

    move-object/from16 v0, p0

    invoke-direct {v3, v0, v8, v2, v4}, Lcom/mrkeyboard/app/MrThemesActivity$18;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[ILcom/mrkeyboard/app/MrCropView;Landroid/widget/TextView;)V

    invoke-virtual {v11, v3}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 912
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x6

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v10, v11, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 913
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_themes_soften_hint"

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const/high16 v5, 0x41500000    # 13.0f

    const v6, -0x37332a

    const/4 v7, 0x0

    invoke-virtual {v3, v4, v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v5, 0x2

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    invoke-virtual {v10, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 915
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v12

    .line 916
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xe

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v10, v12, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 917
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_themes_cancel"

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    new-instance v6, Lcom/mrkeyboard/app/MrThemesActivity$19;

    move-object/from16 v0, p0

    move/from16 v1, p4

    invoke-direct {v6, v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity$19;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Z)V

    invoke-virtual {v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v13

    .line 923
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_themes_next"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v15

    const/16 v16, 0x1

    new-instance v3, Lcom/mrkeyboard/app/MrThemesActivity$20;

    move-object/from16 v4, p0

    move/from16 v5, p4

    move-object v6, v2

    move-object/from16 v7, p1

    invoke-direct/range {v3 .. v8}, Lcom/mrkeyboard/app/MrThemesActivity$20;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;ZLcom/mrkeyboard/app/MrCropView;Landroid/graphics/Bitmap;[I)V

    move/from16 v0, v16

    invoke-virtual {v14, v15, v0, v3}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v3

    .line 929
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, 0x0

    const/4 v6, -0x2

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-direct {v4, v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 930
    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v8, 0x40c00000    # 6.0f

    invoke-virtual {v7, v8}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v7

    const/4 v8, 0x0

    invoke-virtual {v4, v5, v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 931
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, 0x0

    const/4 v7, -0x2

    const/high16 v8, 0x3f800000    # 1.0f

    invoke-direct {v5, v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 932
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x40c00000    # 6.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v14, 0x0

    invoke-virtual {v5, v6, v7, v8, v14}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 933
    invoke-virtual {v12, v13, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 934
    invoke-virtual {v12, v3, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 935
    invoke-virtual {v9, v10}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 936
    new-instance v4, Lcom/mrkeyboard/app/MrThemesActivity$21;

    move-object/from16 v0, p0

    move/from16 v1, p4

    invoke-direct {v4, v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity$21;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Z)V

    invoke-virtual {v9, v4}, Landroid/app/Dialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    .line 941
    move-object/from16 v0, p0

    iput-object v9, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialog:Landroid/app/Dialog;

    .line 942
    move-object/from16 v0, p0

    iput-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCrop:Lcom/mrkeyboard/app/MrCropView;

    .line 943
    move-object/from16 v0, p0

    iput-object v11, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogSoft:Landroid/widget/SeekBar;

    .line 944
    move-object/from16 v0, p0

    iput-object v13, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCancel:Landroid/widget/TextView;

    .line 945
    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogNext:Landroid/widget/TextView;

    .line 946
    invoke-virtual {v9}, Landroid/app/Dialog;->show()V

    goto/16 :goto_0
.end method

.method showPreview(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;IZ)V
    .locals 18

    .prologue
    .line 765
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closeDialog()V

    .line 766
    const/4 v1, 0x0

    move-object/from16 v0, p0

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->newDialog(Z)Landroid/app/Dialog;

    move-result-object v16

    .line 767
    invoke-static/range {p0 .. p1}, Lcom/mrkeyboard/app/MrThemesActivity;->backgroundName(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;

    move-result-object v1

    move-object/from16 v0, p0

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->sheetBox(Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v17

    .line 768
    new-instance v3, Lcom/mrkeyboard/app/MrThemePreview;

    move-object/from16 v0, p0

    invoke-direct {v3, v0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    .line 770
    const/4 v1, 0x1

    invoke-virtual {v3, v1}, Lcom/mrkeyboard/app/MrThemePreview;->setFull(Z)V

    .line 771
    if-nez p2, :cond_0

    move-object/from16 v0, p1

    iget v1, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v2, 0x2

    if-eq v1, v2, :cond_4

    :cond_0
    move-object/from16 v6, p2

    .line 772
    :goto_0
    const/4 v1, 0x1

    new-array v7, v1, [I

    const/4 v1, 0x0

    aput p3, v7, v1

    .line 773
    const/4 v1, 0x1

    new-array v5, v1, [I

    const/4 v1, 0x0

    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mStyle:I

    aput v2, v5, v1

    .line 774
    new-instance v1, Lcom/mrkeyboard/app/MrThemesActivity$14;

    move-object/from16 v2, p0

    move-object/from16 v4, p1

    invoke-direct/range {v1 .. v7}, Lcom/mrkeyboard/app/MrThemesActivity$14;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrThemePreview;Lcom/mrkeyboard/app/MrBackdrop$Spec;[ILandroid/graphics/Bitmap;[I)V

    .line 779
    invoke-interface {v1}, Ljava/lang/Runnable;->run()V

    .line 780
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xe

    invoke-virtual {v2, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    move-object/from16 v0, v17

    invoke-virtual {v0, v3, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 782
    const/4 v2, 0x0

    .line 783
    move-object/from16 v0, p1

    iget v4, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v6, 0x1

    if-eq v4, v6, :cond_1

    move-object/from16 v0, p1

    iget v4, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v6, 0x2

    if-ne v4, v6, :cond_2

    .line 784
    :cond_1
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v2

    .line 785
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v6, 0xe

    invoke-virtual {v4, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    move-object/from16 v0, v17

    invoke-virtual {v0, v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 786
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v8, "mr_themes_soften"

    const/4 v9, 0x0

    new-array v9, v9, [Ljava/lang/Object;

    invoke-virtual {v6, v8, v9}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    const/high16 v8, 0x41700000    # 15.0f

    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v9, v9, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v10, 0x1

    invoke-virtual {v4, v6, v8, v9, v10}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v8, 0x0

    const/4 v9, -0x2

    const/high16 v10, 0x3f800000    # 1.0f

    invoke-direct {v6, v8, v9, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v4, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 787
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v0, p3

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v8, "%"

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    const/high16 v8, 0x41700000    # 15.0f

    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v9, v9, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v10, 0x0

    invoke-virtual {v4, v6, v8, v9, v10}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    .line 788
    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v8, -0x2

    const/4 v9, -0x2

    invoke-direct {v6, v8, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v4, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 789
    new-instance v2, Landroid/widget/SeekBar;

    move-object/from16 v0, p0

    invoke-direct {v2, v0}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    .line 790
    const/16 v6, 0x46

    invoke-virtual {v2, v6}, Landroid/widget/SeekBar;->setMax(I)V

    .line 791
    move/from16 v0, p3

    invoke-virtual {v2, v0}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 792
    new-instance v6, Lcom/mrkeyboard/app/MrThemesActivity$15;

    move-object/from16 v0, p0

    invoke-direct {v6, v0, v7, v4, v1}, Lcom/mrkeyboard/app/MrThemesActivity$15;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[ILandroid/widget/TextView;Ljava/lang/Runnable;)V

    invoke-virtual {v2, v6}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 806
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v6, 0x4

    invoke-virtual {v4, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    move-object/from16 v0, v17

    invoke-virtual {v0, v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 809
    :cond_2
    invoke-static/range {p1 .. p1}, Lcom/mrkeyboard/app/MrBackdrop;->hasStyles(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 810
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v8, "mr_themes_keys"

    const/4 v9, 0x0

    new-array v9, v9, [Ljava/lang/Object;

    invoke-virtual {v6, v8, v9}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    const/high16 v8, 0x41700000    # 15.0f

    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v9, v9, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v10, 0x1

    invoke-virtual {v4, v6, v8, v9, v10}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v8, 0xc

    invoke-virtual {v6, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    move-object/from16 v0, v17

    invoke-virtual {v0, v4, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 812
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v11

    .line 813
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v6, 0x8

    invoke-virtual {v4, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    move-object/from16 v0, v17

    invoke-virtual {v0, v11, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 814
    new-instance v4, Landroid/widget/HorizontalScrollView;

    move-object/from16 v0, p0

    invoke-direct {v4, v0}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;)V

    .line 815
    const/4 v6, 0x0

    invoke-virtual {v4, v6}, Landroid/widget/HorizontalScrollView;->setHorizontalScrollBarEnabled(Z)V

    .line 816
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v14

    .line 817
    new-instance v6, Landroid/view/ViewGroup$LayoutParams;

    const/4 v8, -0x2

    const/4 v9, -0x2

    invoke-direct {v6, v8, v9}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v4, v14, v6}, Landroid/widget/HorizontalScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 818
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v8, 0xa

    invoke-virtual {v6, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    move-object/from16 v0, v17

    invoke-virtual {v0, v4, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 819
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, ""

    const/high16 v8, 0x41600000    # 14.0f

    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v9, v9, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v10, 0x0

    invoke-virtual {v4, v6, v8, v9, v10}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v15

    .line 820
    const/16 v4, 0x11

    invoke-virtual {v15, v4}, Landroid/widget/TextView;->setGravity(I)V

    .line 821
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v6, 0x4

    invoke-virtual {v4, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    move-object/from16 v0, v17

    invoke-virtual {v0, v15, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 822
    const/4 v4, 0x1

    new-array v13, v4, [Ljava/lang/Runnable;

    .line 823
    const/4 v4, 0x0

    new-instance v8, Lcom/mrkeyboard/app/MrThemesActivity$16;

    move-object/from16 v9, p0

    move-object v10, v5

    move-object v12, v1

    invoke-direct/range {v8 .. v15}, Lcom/mrkeyboard/app/MrThemesActivity$16;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[ILandroid/widget/LinearLayout;Ljava/lang/Runnable;[Ljava/lang/Runnable;Landroid/widget/LinearLayout;Landroid/widget/TextView;)V

    aput-object v8, v13, v4

    .line 861
    const/4 v1, 0x0

    aget-object v1, v13, v1

    invoke-interface {v1}, Ljava/lang/Runnable;->run()V

    .line 863
    :cond_3
    new-instance v8, Lcom/mrkeyboard/app/MrThemesActivity$17;

    move-object/from16 v9, p0

    move-object/from16 v10, p1

    move-object v11, v7

    move-object v12, v5

    move/from16 v13, p4

    invoke-direct/range {v8 .. v13}, Lcom/mrkeyboard/app/MrThemesActivity$17;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrBackdrop$Spec;[I[IZ)V

    move-object/from16 v9, p0

    move-object/from16 v10, v16

    move-object/from16 v11, v17

    move-object v12, v3

    move-object v13, v2

    move/from16 v14, p4

    move-object v15, v8

    invoke-direct/range {v9 .. v15}, Lcom/mrkeyboard/app/MrThemesActivity;->sheetShow(Landroid/app/Dialog;Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrThemePreview;Landroid/widget/SeekBar;ZLjava/lang/Runnable;)V

    .line 868
    return-void

    .line 771
    :cond_4
    move-object/from16 v0, p1

    iget v1, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    move-object/from16 v0, p0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrScenes;->load(Landroid/content/Context;I)Landroid/graphics/Bitmap;

    move-result-object v6

    goto/16 :goto_0
.end method

.method showTab(I)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x0

    .line 308
    iput p1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    .line 309
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabLoad:I

    .line 310
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 311
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeTiles:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 312
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeActions:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 313
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 314
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 315
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgActions:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 316
    iput-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mMineTile:Lcom/mrkeyboard/app/MrThemePreview;

    .line 317
    iput-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRemove:Landroid/widget/TextView;

    .line 318
    iput-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRow:Landroid/widget/LinearLayout;

    .line 319
    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity;->cardsOf(I)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    .line 320
    iput v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    .line 321
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->styleTabs()V

    .line 322
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v1, v2, v2}, Landroid/widget/ScrollView;->scrollTo(II)V

    .line 323
    const/4 v1, 0x3

    if-lt p1, v1, :cond_0

    const/16 v1, 0x9

    if-ge p1, v1, :cond_0

    add-int/lit8 v1, p1, -0x3

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->loadScenes(I)V

    .line 324
    :cond_0
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->buildMore(I)V

    .line 325
    return-void
.end method

.method showThemePreview(I)V
    .locals 7

    .prologue
    const/4 v4, 0x0

    const/4 v5, 0x0

    .line 744
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closeDialog()V

    .line 745
    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/MrThemesActivity;->newDialog(Z)Landroid/app/Dialog;

    move-result-object v1

    .line 746
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    array-length v0, v0

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    aget-object v0, v0, p1

    :goto_0
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->sheetBox(Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v2

    .line 747
    new-instance v3, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    .line 748
    const/4 v0, 0x1

    invoke-virtual {v3, v0}, Lcom/mrkeyboard/app/MrThemePreview;->setFull(Z)V

    .line 749
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    aget-object v0, v0, p1

    sget-object v6, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {v3, v0, v6, v4, v5}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 750
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v6, 0xe

    invoke-virtual {v0, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v2, v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 751
    new-instance v6, Lcom/mrkeyboard/app/MrThemesActivity$13;

    invoke-direct {v6, p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity$13;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V

    move-object v0, p0

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrThemesActivity;->sheetShow(Landroid/app/Dialog;Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrThemePreview;Landroid/widget/SeekBar;ZLjava/lang/Runnable;)V

    .line 756
    return-void

    .line 746
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    aget-object v0, v0, p1

    goto :goto_0
.end method

.method startSoft(Lcom/mrkeyboard/app/MrBackdrop$Spec;)I
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 638
    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v2, 0x1

    if-eq v1, v2, :cond_1

    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v2, 0x2

    if-eq v1, v2, :cond_1

    .line 639
    :cond_0
    :goto_0
    return v0

    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v1, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    iget v2, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v1, v2, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v1, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    iget v2, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    if-ne v1, v2, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    goto :goto_0
.end method

.method styleTabs()V
    .locals 7

    .prologue
    const/4 v4, 0x1

    const/4 v2, 0x0

    .line 356
    move v1, v2

    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_4

    .line 357
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 358
    iget v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    if-ne v1, v3, :cond_0

    move v5, v4

    .line 359
    :goto_1
    if-eqz v5, :cond_1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    :goto_2
    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 360
    const/4 v6, 0x0

    if-eqz v5, :cond_2

    move v3, v4

    :goto_3
    invoke-virtual {v0, v6, v3}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 361
    if-eqz v5, :cond_3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->accent:I

    const/high16 v6, 0x41900000    # 18.0f

    invoke-virtual {v3, v5, v2, v6, v2}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    :goto_4
    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 356
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    :cond_0
    move v5, v2

    .line 358
    goto :goto_1

    .line 359
    :cond_1
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text2:I

    goto :goto_2

    :cond_2
    move v3, v2

    .line 360
    goto :goto_3

    .line 361
    :cond_3
    new-instance v3, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v3, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    goto :goto_4

    .line 363
    :cond_4
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    if-ltz v0, :cond_5

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ge v0, v1, :cond_5

    .line 364
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 365
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$5;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$5;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/TextView;)V

    invoke-virtual {v1, v2}, Landroid/widget/HorizontalScrollView;->post(Ljava/lang/Runnable;)Z

    .line 371
    :cond_5
    return-void
.end method

.method tabName(I)Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 257
    if-nez p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_themes"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 261
    :goto_0
    return-object v0

    .line 258
    :cond_0
    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_colors"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 259
    :cond_1
    const/4 v0, 0x2

    if-ne p1, v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_gradients"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 260
    :cond_2
    const/16 v0, 0x9

    if-ne p1, v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_gallery"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 261
    :cond_3
    add-int/lit8 v0, p1, -0x3

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->categoryName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method tabOfChoice()I
    .locals 1

    .prologue
    .line 266
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    packed-switch v0, :pswitch_data_0

    .line 271
    const/4 v0, 0x0

    :goto_0
    return v0

    .line 267
    :pswitch_0
    const/4 v0, 0x1

    goto :goto_0

    .line 268
    :pswitch_1
    const/4 v0, 0x2

    goto :goto_0

    .line 269
    :pswitch_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrScenes;->category(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x3

    goto :goto_0

    .line 270
    :pswitch_3
    const/16 v0, 0x9

    goto :goto_0

    .line 266
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_0
    .end packed-switch
.end method

.method tag()Ljava/lang/String;
    .locals 2

    .prologue
    .line 520
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

.method tileImage(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Landroid/graphics/Bitmap;
    .locals 2

    .prologue
    .line 530
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 532
    :goto_0
    return-object v0

    .line 531
    :cond_0
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    if-ltz v0, :cond_1

    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScenes:[Landroid/graphics/Bitmap;

    array-length v1, v1

    if-ge v0, v1, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScenes:[Landroid/graphics/Bitmap;

    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    aget-object v0, v0, v1

    goto :goto_0

    .line 532
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method tileSpec(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Lcom/mrkeyboard/app/MrBackdrop$Spec;
    .locals 2

    .prologue
    const/4 v1, 0x3

    .line 525
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v1, :cond_0

    iget-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    :cond_0
    return-object p1
.end method
