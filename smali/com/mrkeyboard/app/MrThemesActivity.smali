.class public Lcom/mrkeyboard/app/MrThemesActivity;
.super Landroid/app/Activity;
.source "MrThemesActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrThemesActivity$Card;,
        Lcom/mrkeyboard/app/MrThemesActivity$Setter;
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

.field static final CONTROLS_SHARE:F = 0.38f

.field static final IMAGES_URI:Ljava/lang/String; = "content://media/external/images/media"

.field static final PICK_HUE:I = 0x1

.field static final PICK_HUE2:I = 0x2

.field static final PICK_TEXT:I = 0x0

.field static final REQ_PICK:I = 0x47

.field static final REVEAL_TRIES:I = 0x8

.field static final REVEAL_WAIT_MS:I = 0x28

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

.field mDialogEdge:Landroid/widget/SeekBar;

.field mDialogKey:Landroid/widget/SeekBar;

.field mDialogKeys:Landroid/widget/LinearLayout;

.field mDialogLook:[Lcom/mrkeyboard/app/MrKeyLook;

.field mDialogNext:Landroid/widget/TextView;

.field mDialogPreview:Lcom/mrkeyboard/app/MrThemePreview;

.field mDialogSoft:Landroid/widget/SeekBar;

.field mDialogStyle:[I

.field mDialogText:Landroid/widget/LinearLayout;

.field mGrid:Landroid/widget/LinearLayout;

.field mImage:Landroid/graphics/Bitmap;

.field mListed:I

.field mLoad:I

.field mLook:Lcom/mrkeyboard/app/MrKeyLook;

.field mMineTile:Lcom/mrkeyboard/app/MrThemePreview;

.field mNames:[Ljava/lang/String;

.field mPicker:Landroid/app/Dialog;

.field mPickerCancel:Landroid/widget/TextView;

.field mPickerOk:Landroid/widget/TextView;

.field mPickerView:Lcom/mrkeyboard/app/MrColorPicker;

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

    .line 93
    new-array v0, v1, [Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    .line 94
    new-array v0, v1, [Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    .line 96
    new-array v0, v1, [Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    .line 101
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 106
    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 112
    new-array v0, v3, [Landroid/graphics/Bitmap;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScenes:[Landroid/graphics/Bitmap;

    .line 113
    new-array v0, v3, [Z

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSceneBusy:[Z

    .line 115
    iput v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigSceneIndex:I

    .line 125
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    .line 127
    iput v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    .line 129
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    .line 133
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeTiles:Ljava/util/List;

    .line 134
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeActions:Ljava/util/List;

    .line 136
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    .line 137
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    .line 138
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgActions:Ljava/util/List;

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/view/View;I)V
    .locals 0

    .prologue
    .line 51
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/MrThemesActivity;->revealRow(Landroid/view/View;I)V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/LinearLayout;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0

    .prologue
    .line 51
    invoke-direct/range {p0 .. p5}, Lcom/mrkeyboard/app/MrThemesActivity;->fillKeys(Landroid/widget/LinearLayout;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    return-void
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/LinearLayout;[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0

    .prologue
    .line 51
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/mrkeyboard/app/MrThemesActivity;->fillText(Landroid/widget/LinearLayout;[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    return-void
.end method

.method private addCard(Lcom/mrkeyboard/app/MrThemesActivity$Card;I)V
    .locals 9

    .prologue
    const/4 v4, 0x0

    .line 464
    rem-int/lit8 v6, p2, 0x1

    .line 465
    if-nez v6, :cond_0

    .line 466
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRow:Landroid/widget/LinearLayout;

    .line 467
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRow:Landroid/widget/LinearLayout;

    const/16 v1, 0x30

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 468
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

    .line 470
    :cond_0
    new-instance v1, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    .line 471
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 473
    iget v0, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->kind:I

    packed-switch v0, :pswitch_data_0

    .line 503
    :pswitch_0
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$11;

    invoke-direct {v5, p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity$11;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrThemesActivity$Card;)V

    .line 508
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 509
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    iget-object v2, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 510
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgActions:Ljava/util/List;

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 513
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

    .line 514
    iget v2, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->kind:I

    iget v0, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->kind:I

    if-nez v0, :cond_3

    iget v0, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->index:I

    :goto_3
    invoke-direct {p0, v2, v1, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->bindCard(ILcom/mrkeyboard/app/MrThemePreview;I)V

    .line 515
    return-void

    .line 468
    :cond_1
    const/16 v0, 0xc

    goto :goto_0

    .line 475
    :pswitch_1
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$8;

    invoke-direct {v5, p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity$8;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrThemesActivity$Card;)V

    .line 480
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeTiles:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 481
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeActions:Ljava/util/List;

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 484
    :pswitch_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->card:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->stroke:I

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {v1, v0, v2, v5}, Lcom/mrkeyboard/app/MrThemePreview;->showPlus(III)V

    .line 485
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$9;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrThemesActivity$9;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    goto :goto_1

    .line 492
    :pswitch_3
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$10;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrThemesActivity$10;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    .line 497
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 498
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    iget-object v2, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 499
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgActions:Ljava/util/List;

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 500
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mMineTile:Lcom/mrkeyboard/app/MrThemePreview;

    goto :goto_1

    .line 513
    :cond_2
    const/4 v4, 0x0

    goto :goto_2

    .line 514
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    goto :goto_3

    .line 473
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method private addDot(Landroid/widget/LinearLayout;Landroid/view/View;Z)V
    .locals 5

    .prologue
    const/high16 v4, 0x42200000    # 40.0f

    const/4 v3, 0x0

    .line 1058
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-direct {v0, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 1059
    if-eqz p3, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x41400000    # 12.0f

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-virtual {v0, v1, v3, v3, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1060
    :cond_0
    invoke-virtual {p1, p2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1061
    return-void
.end method

.method static backgroundName(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v3, 0x0

    .line 675
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    packed-switch v0, :pswitch_data_0

    .line 680
    const-string v0, ""

    .line 682
    :goto_0
    if-eqz v0, :cond_0

    :goto_1
    return-object v0

    .line 676
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

    .line 677
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

    .line 678
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

    .line 679
    :pswitch_3
    const-string v0, "mr_themes_mine"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 682
    :cond_0
    const-string v0, ""

    goto :goto_1

    .line 675
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

    .line 550
    if-nez p1, :cond_2

    .line 551
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    aget-object v0, v0, p3

    sget-object v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    const/4 v4, 0x0

    invoke-virtual {p2, v0, v3, v4, v2}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 552
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-nez v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    if-ne p3, v0, :cond_0

    move v2, v1

    .line 553
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->accent:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    invoke-virtual {p2, v2, v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->setChecked(ZII)V

    .line 554
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeActions:Ljava/util/List;

    invoke-interface {v0, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    invoke-virtual {p2}, Lcom/mrkeyboard/app/MrThemePreview;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    check-cast v1, Landroid/view/View;

    invoke-direct {p0, v0, v2, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->markAction(Landroid/widget/TextView;ZLandroid/view/View;)V

    .line 562
    :cond_1
    :goto_0
    return-void

    .line 555
    :cond_2
    if-eq p1, v1, :cond_3

    if-ne p1, v6, :cond_1

    .line 556
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    invoke-interface {v0, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->tileSpec(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v3

    .line 557
    invoke-static {v3}, Lcom/mrkeyboard/app/MrBackdrop;->themeTag(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->tileImage(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Landroid/graphics/Bitmap;

    move-result-object v5

    iget v0, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v6, :cond_6

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    :goto_1
    invoke-virtual {p2, v4, v3, v5, v0}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 558
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

    .line 559
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->accent:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    invoke-virtual {p2, v2, v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->setChecked(ZII)V

    .line 560
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

    .line 557
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

    .line 522
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 523
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

    .line 524
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->card:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->stroke:I

    const/high16 v4, 0x41400000    # 12.0f

    invoke-virtual {v1, v2, v3, v4, v7}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 525
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 526
    invoke-virtual {v0, p5}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 527
    invoke-virtual {v0, p2}, Landroid/widget/LinearLayout;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 528
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, -0x1

    invoke-direct {v1, v2, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, p1, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 529
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 530
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v1, v2, v7, v3, v7}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 531
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41500000    # 13.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v2, p2, v3, v4, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    .line 532
    const/4 v3, 0x2

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 533
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v3, v7, v8, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 534
    const/high16 v2, 0x41400000    # 12.0f

    invoke-virtual {p3, v2}, Landroid/widget/TextView;->setTextSize(F)V

    .line 535
    const/16 v2, 0x11

    invoke-virtual {p3, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 536
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

    .line 537
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x42200000    # 40.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p3, v2}, Landroid/widget/TextView;->setMinWidth(I)V

    .line 538
    if-eqz p4, :cond_0

    :goto_0
    invoke-virtual {p3, p4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 539
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {p3, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 540
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

    .line 541
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v8, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, p3, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 542
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    .line 543
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41000000    # 8.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v2, v7, v3, v7, v4}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 544
    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 545
    return-object v0

    .line 538
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

    .line 448
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v0, -0x2

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-direct {v3, v1, v0, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 449
    if-nez p1, :cond_0

    move v2, v1

    :goto_0
    if-nez p1, :cond_1

    move v0, v1

    :goto_1
    invoke-virtual {v3, v2, v1, v0, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 450
    return-object v3

    .line 449
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
    .line 656
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

    .line 657
    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    const-string v0, ""

    goto :goto_0
.end method

.method static colorOf(Lcom/mrkeyboard/app/MrKeyLook;I)I
    .locals 1

    .prologue
    .line 1103
    if-nez p1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    goto :goto_0

    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    goto :goto_0
.end method

.method private colourLine(Ljava/lang/String;IZI[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)Landroid/widget/LinearLayout;
    .locals 9

    .prologue
    .line 1068
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v6

    .line 1069
    const/16 v0, 0x10

    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 1070
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v1, 0x41700000    # 15.0f

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v3, 0x1

    invoke-virtual {v0, p1, v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, 0x0

    const/4 v3, -0x2

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v1, v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v6, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1071
    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_auto"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$26;

    move-object v1, p0

    move-object v2, p5

    move v3, p4

    move-object v4, p6

    move-object/from16 v5, p7

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemesActivity$26;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[Lcom/mrkeyboard/app/MrKeyLook;ILjava/lang/Runnable;[Ljava/lang/Runnable;)V

    invoke-virtual {v7, v8, p3, v0}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    .line 1078
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, -0x2

    const/4 v3, -0x2

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v6, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1079
    new-instance v7, Lcom/mrkeyboard/app/MrColorDot;

    invoke-direct {v7, p0, p2}, Lcom/mrkeyboard/app/MrColorDot;-><init>(Landroid/content/Context;I)V

    .line 1080
    invoke-virtual {v7, p1}, Lcom/mrkeyboard/app/MrColorDot;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 1081
    const/4 v0, 0x1

    invoke-virtual {v7, v0}, Lcom/mrkeyboard/app/MrColorDot;->setClickable(Z)V

    .line 1082
    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$27;

    move-object v1, p0

    move v2, p4

    move-object v3, p5

    move-object v4, p6

    move-object/from16 v5, p7

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemesActivity$27;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    invoke-virtual {v7, v0}, Lcom/mrkeyboard/app/MrColorDot;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 1087
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x42200000    # 40.0f

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x42200000    # 40.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-direct {v0, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 1088
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x41200000    # 10.0f

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1089
    invoke-virtual {v6, v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1090
    return-object v6
.end method

.method private fillKeys(Landroid/widget/LinearLayout;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 11

    .prologue
    .line 988
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 989
    const/4 v0, 0x0

    aget v0, p2, v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v7

    .line 991
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v8

    .line 992
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {p1, v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 993
    const/4 v3, 0x0

    :goto_0
    const/4 v0, 0x3

    if-ge v3, v0, :cond_2

    .line 995
    iget-object v9, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-static {p0, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->kindName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v10

    if-ne v3, v7, :cond_1

    const/4 v0, 0x1

    move v6, v0

    :goto_1
    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$23;

    move-object v1, p0

    move-object v2, p2

    move-object v4, p4

    move-object/from16 v5, p5

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemesActivity$23;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[IILjava/lang/Runnable;[Ljava/lang/Runnable;)V

    invoke-virtual {v9, v10, v6, v0}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    .line 1003
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, 0x0

    const/4 v4, -0x2

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v1, v2, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 1004
    if-lez v3, :cond_0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41000000    # 8.0f

    invoke-virtual {v2, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-virtual {v1, v2, v4, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1005
    :cond_0
    invoke-virtual {v8, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 993
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 995
    :cond_1
    const/4 v0, 0x0

    move v6, v0

    goto :goto_1

    .line 1007
    :cond_2
    new-instance v0, Landroid/widget/HorizontalScrollView;

    invoke-direct {v0, p0}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;)V

    .line 1008
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/HorizontalScrollView;->setHorizontalScrollBarEnabled(Z)V

    .line 1009
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v10

    .line 1010
    new-instance v1, Landroid/view/ViewGroup$LayoutParams;

    const/4 v2, -0x2

    const/4 v3, -0x2

    invoke-direct {v1, v2, v3}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v10, v1}, Landroid/widget/HorizontalScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1011
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0xa

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1012
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->KIND_FIRST:[I

    aget v3, v0, v7

    :goto_2
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->KIND_FIRST:[I

    add-int/lit8 v1, v7, 0x1

    aget v0, v0, v1

    if-ge v3, v0, :cond_5

    .line 1014
    new-instance v6, Lcom/mrkeyboard/app/MrStyleDot;

    const/4 v0, 0x0

    aget v0, p2, v0

    if-ne v3, v0, :cond_3

    const/4 v0, 0x1

    :goto_3
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-direct {v6, p0, v3, v0, v1}, Lcom/mrkeyboard/app/MrStyleDot;-><init>(Landroid/content/Context;IZI)V

    .line 1015
    invoke-static {p0, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->styleName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Lcom/mrkeyboard/app/MrStyleDot;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 1016
    const/4 v0, 0x1

    invoke-virtual {v6, v0}, Lcom/mrkeyboard/app/MrStyleDot;->setClickable(Z)V

    .line 1017
    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$24;

    move-object v1, p0

    move-object v2, p2

    move-object v4, p4

    move-object/from16 v5, p5

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemesActivity$24;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[IILjava/lang/Runnable;[Ljava/lang/Runnable;)V

    invoke-virtual {v6, v0}, Lcom/mrkeyboard/app/MrStyleDot;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 1024
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->KIND_FIRST:[I

    aget v0, v0, v7

    if-le v3, v0, :cond_4

    const/4 v0, 0x1

    :goto_4
    invoke-direct {p0, v10, v6, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->addDot(Landroid/widget/LinearLayout;Landroid/view/View;Z)V

    .line 1012
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 1014
    :cond_3
    const/4 v0, 0x0

    goto :goto_3

    .line 1024
    :cond_4
    const/4 v0, 0x0

    goto :goto_4

    .line 1027
    :cond_5
    invoke-static {v7}, Lcom/mrkeyboard/app/MrBackdrop;->ownStyle(I)I

    move-result v2

    .line 1028
    new-instance v0, Lcom/mrkeyboard/app/MrStyleDot;

    const/4 v1, 0x0

    aget v1, p2, v1

    if-ne v2, v1, :cond_7

    const/4 v3, 0x1

    :goto_5
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v1, Lcom/mrkeyboard/app/MrKit;->accent:I

    const/4 v1, 0x0

    aget-object v1, p3, v1

    iget v5, v1, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    const/4 v1, 0x0

    aget-object v1, p3, v1

    iget v6, v1, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    move-object v1, p0

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrStyleDot;-><init>(Landroid/content/Context;IZIII)V

    .line 1029
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_pick_color"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrStyleDot;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 1030
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrStyleDot;->setClickable(Z)V

    .line 1031
    new-instance v3, Lcom/mrkeyboard/app/MrThemesActivity$25;

    move-object v4, p0

    move-object v5, p2

    move v6, v2

    move-object v7, p3

    move-object v8, p4

    move-object/from16 v9, p5

    invoke-direct/range {v3 .. v9}, Lcom/mrkeyboard/app/MrThemesActivity$25;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[II[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    invoke-virtual {v0, v3}, Lcom/mrkeyboard/app/MrStyleDot;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 1040
    const/4 v1, 0x1

    invoke-direct {p0, v10, v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->addDot(Landroid/widget/LinearLayout;Landroid/view/View;Z)V

    .line 1041
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v1, 0x0

    aget v1, p2, v1

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->styleName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v1

    const/high16 v2, 0x41600000    # 14.0f

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v4, 0x0

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    .line 1042
    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V

    .line 1043
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1044
    const/4 v0, 0x0

    aget v0, p2, v0

    const/4 v1, 0x2

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->ownStyle(I)I

    move-result v1

    if-ne v0, v1, :cond_6

    .line 1046
    const/4 v0, 0x0

    aget-object v0, p3, v0

    iget v0, v0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    if-eqz v0, :cond_8

    const/4 v0, 0x0

    aget-object v0, p3, v0

    iget v2, v0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    .line 1047
    :goto_6
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_grad_end"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v0, 0x0

    aget-object v0, p3, v0

    iget v0, v0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    if-nez v0, :cond_9

    const/4 v3, 0x1

    :goto_7
    const/4 v4, 0x2

    move-object v0, p0

    move-object v5, p3

    move-object v6, p4

    move-object/from16 v7, p5

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/MrThemesActivity;->colourLine(Ljava/lang/String;IZI[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1049
    :cond_6
    return-void

    .line 1028
    :cond_7
    const/4 v3, 0x0

    goto/16 :goto_5

    .line 1046
    :cond_8
    const/4 v2, 0x0

    goto :goto_6

    .line 1047
    :cond_9
    const/4 v3, 0x0

    goto :goto_7
.end method

.method private fillRow(Landroid/widget/LinearLayout;I)V
    .locals 3

    .prologue
    .line 455
    if-nez p1, :cond_1

    .line 460
    :cond_0
    return-void

    .line 456
    :cond_1
    rem-int/lit8 v0, p2, 0x1

    :goto_0
    if-eqz v0, :cond_0

    const/4 v1, 0x1

    if-ge v0, v1, :cond_0

    .line 457
    new-instance v1, Landroid/view/View;

    invoke-direct {v1, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 458
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->cardParams(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {p1, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 456
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method private fillText(Landroid/widget/LinearLayout;[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 8

    .prologue
    const/4 v4, 0x0

    .line 1053
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 1054
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_text_color"

    new-array v2, v4, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    aget-object v0, p2, v4

    iget v2, v0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    aget-object v0, p2, v4

    iget v0, v0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    if-nez v0, :cond_0

    const/4 v3, 0x1

    :goto_0
    move-object v0, p0

    move-object v5, p2

    move-object v6, p3

    move-object v7, p4

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/MrThemesActivity;->colourLine(Ljava/lang/String;IZI[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1055
    return-void

    :cond_0
    move v3, v4

    .line 1054
    goto :goto_0
.end method

.method static kindName(Landroid/content/Context;I)Ljava/lang/String;
    .locals 2

    .prologue
    .line 662
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

    .line 663
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

    .line 566
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    if-eqz p2, :cond_1

    const-string v0, "mr_themes_in_use"

    :goto_0
    new-array v2, v5, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 567
    if-eqz p2, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    :goto_1
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 568
    if-eqz p2, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {v0, v1, v5, v6, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    :goto_2
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 569
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

    .line 570
    :cond_0
    return-void

    .line 566
    :cond_1
    const-string v0, "mr_themes_view"

    goto :goto_0

    .line 567
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->accent:I

    goto :goto_1

    .line 568
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

    .line 569
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    goto :goto_3
.end method

.method private newDialog(Z)Landroid/app/Dialog;
    .locals 5

    .prologue
    const/4 v1, -0x1

    .line 762
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v2, "Theme.MrKeyboard.Dialog"

    const-string v3, "style"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 763
    new-instance v2, Landroid/app/Dialog;

    invoke-direct {v2, p0, v0}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V

    .line 764
    const/4 v0, 0x1

    invoke-virtual {v2, v0}, Landroid/app/Dialog;->requestWindowFeature(I)Z

    .line 765
    invoke-virtual {v2}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v3

    .line 766
    if-eqz v3, :cond_0

    .line 768
    new-instance v4, Landroid/graphics/drawable/ColorDrawable;

    if-eqz p1, :cond_1

    const/high16 v0, -0x1000000

    :goto_0
    invoke-direct {v4, v0}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v3, v4}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 769
    if-eqz p1, :cond_2

    move v0, v1

    :goto_1
    invoke-virtual {v3, v1, v0}, Landroid/view/Window;->setLayout(II)V

    .line 770
    if-nez p1, :cond_0

    const/16 v0, 0x50

    invoke-virtual {v3, v0}, Landroid/view/Window;->setGravity(I)V

    .line 772
    :cond_0
    return-object v2

    .line 768
    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    .line 769
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
    .line 1259
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 1260
    const/16 v1, 0x1e

    if-lt p0, v1, :cond_0

    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.provider.action.PICK_IMAGES"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v2, "image/*"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1261
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

    .line 1262
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1263
    const-string v2, "android.intent.category.OPENABLE"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 1264
    const-string v2, "image/*"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 1265
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1266
    return-object v0
.end method

.method private revealRow(Landroid/view/View;I)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 328
    if-nez p1, :cond_0

    .line 338
    :goto_0
    return-void

    .line 329
    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result v0

    if-gtz v0, :cond_1

    if-lez p2, :cond_1

    .line 330
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    new-instance v1, Lcom/mrkeyboard/app/MrThemesActivity$4;

    invoke-direct {v1, p0, p1, p2}, Lcom/mrkeyboard/app/MrThemesActivity$4;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/view/View;I)V

    const-wide/16 v2, 0x28

    invoke-virtual {v0, v1, v2, v3}, Landroid/widget/ScrollView;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0

    .line 337
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {p1}, Landroid/view/View;->getTop()I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41000000    # 8.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    sub-int/2addr v1, v2

    invoke-static {v4, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-virtual {v0, v4, v1}, Landroid/widget/ScrollView;->smoothScrollTo(II)V

    goto :goto_0
.end method

.method static sceneName(Landroid/content/Context;I)Ljava/lang/String;
    .locals 2

    .prologue
    .line 650
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

    .line 651
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

    .line 800
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 801
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

    .line 802
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->solidBg()I

    move-result v2

    const/high16 v3, 0x41b00000    # 22.0f

    invoke-virtual {v1, v2, v5, v3, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 803
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

    .line 804
    return-object v0
.end method

.method private sheetShow(Landroid/app/Dialog;Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrThemePreview;Landroid/widget/SeekBar;ZLjava/lang/Runnable;)V
    .locals 9

    .prologue
    .line 809
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 810
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0x12

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p2, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 811
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_cancel"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    new-instance v4, Lcom/mrkeyboard/app/MrThemesActivity$12;

    invoke-direct {v4, p0, p5}, Lcom/mrkeyboard/app/MrThemesActivity$12;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Z)V

    invoke-virtual {v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v1

    .line 817
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_themes_apply"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$13;

    invoke-direct {v5, p0, p6}, Lcom/mrkeyboard/app/MrThemesActivity$13;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Ljava/lang/Runnable;)V

    invoke-virtual {v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    .line 823
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, 0x0

    const/4 v5, -0x2

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-direct {v3, v4, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 824
    const/4 v4, 0x0

    const/4 v5, 0x0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x40c00000    # 6.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    const/4 v7, 0x0

    invoke-virtual {v3, v4, v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 825
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, 0x0

    const/4 v6, -0x2

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-direct {v4, v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 826
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x40c00000    # 6.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-virtual {v4, v5, v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 827
    invoke-virtual {v0, v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 828
    invoke-virtual {v0, v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 829
    invoke-virtual {p1, p2}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 830
    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$14;

    invoke-direct {v0, p0, p5}, Lcom/mrkeyboard/app/MrThemesActivity$14;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Z)V

    invoke-virtual {p1, v0}, Landroid/app/Dialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    .line 835
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialog:Landroid/app/Dialog;

    .line 836
    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogPreview:Lcom/mrkeyboard/app/MrThemePreview;

    .line 837
    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogSoft:Landroid/widget/SeekBar;

    .line 838
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCancel:Landroid/widget/TextView;

    .line 839
    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogApply:Landroid/widget/TextView;

    .line 840
    invoke-virtual {p1}, Landroid/app/Dialog;->show()V

    .line 841
    return-void
.end method

.method private side(I)Landroid/widget/LinearLayout$LayoutParams;
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 442
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x1

    const/4 v2, -0x2

    invoke-direct {v0, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 443
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    int-to-float v2, p1

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {v0, v4, v1, v2, v4}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 444
    return-object v0
.end method

.method private slider(Landroid/widget/LinearLayout;Ljava/lang/String;IIILcom/mrkeyboard/app/MrThemesActivity$Setter;)Landroid/widget/SeekBar;
    .locals 7

    .prologue
    const/4 v6, 0x0

    const/high16 v5, 0x41700000    # 15.0f

    const/4 v4, -0x2

    .line 957
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 958
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, p5}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 959
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v3, 0x1

    invoke-virtual {v1, p2, v5, v2, v3}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-direct {v2, v6, v4, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 960
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "%"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v1, v2, v5, v3, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 961
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v4, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 962
    new-instance v0, Landroid/widget/SeekBar;

    invoke-direct {v0, p0}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    .line 963
    invoke-virtual {v0, p3}, Landroid/widget/SeekBar;->setMax(I)V

    .line 964
    invoke-virtual {v0, p4}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 965
    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$22;

    invoke-direct {v2, p0, p3, v1, p6}, Lcom/mrkeyboard/app/MrThemesActivity$22;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;ILandroid/widget/TextView;Lcom/mrkeyboard/app/MrThemesActivity$Setter;)V

    invoke-virtual {v0, v2}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 979
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 980
    return-object v0
.end method

.method static styleName(Landroid/content/Context;I)Ljava/lang/String;
    .locals 2

    .prologue
    .line 668
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

    .line 669
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

    .line 1422
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 1423
    const/16 v1, 0x140

    if-gt v0, v1, :cond_0

    .line 1425
    :goto_0
    return-object p0

    .line 1424
    :cond_0
    const/high16 v1, 0x43a00000    # 320.0f

    int-to-float v0, v0

    div-float v0, v1, v0

    .line 1425
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

.method static withColor(Lcom/mrkeyboard/app/MrKeyLook;II)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 1

    .prologue
    .line 1098
    if-nez p1, :cond_0

    invoke-virtual {p0, p2}, Lcom/mrkeyboard/app/MrKeyLook;->withText(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    invoke-virtual {p0, p2}, Lcom/mrkeyboard/app/MrKeyLook;->withHue(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    goto :goto_0

    :cond_1
    invoke-virtual {p0, p2}, Lcom/mrkeyboard/app/MrKeyLook;->withHue2(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    goto :goto_0
.end method


# virtual methods
.method applyBackdrop(Lcom/mrkeyboard/app/MrBackdrop$Spec;IILcom/mrkeyboard/app/MrKeyLook;Z)V
    .locals 8

    .prologue
    const/4 v7, 0x3

    const/4 v6, 0x0

    .line 734
    .line 735
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v7, :cond_1

    if-eqz p5, :cond_1

    .line 737
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->commitPending(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 738
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_image_failed"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    .line 757
    :goto_0
    return-void

    .line 741
    :cond_0
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->zoom:I

    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dx:I

    iget v2, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dy:I

    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->imageStamp(Landroid/content/Context;)J

    move-result-wide v4

    invoke-static {v0, v1, v2, v4, v5}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->image(IIIJ)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object p1

    .line 743
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    invoke-static {p1, p3}, Lcom/mrkeyboard/app/MrBackdrop;->themeTag(Lcom/mrkeyboard/app/MrBackdrop$Spec;I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrThemeColors;->indexOfTag([Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 744
    if-gez v0, :cond_2

    .line 745
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_image_failed"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 748
    :cond_2
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 749
    const-string v2, "pref_keyboard_layout"

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    array-length v3, v3

    if-ge v0, v3, :cond_6

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    aget-object v0, v3, v0

    :goto_1
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 750
    const-string v0, "pref_kbd_bg"

    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->format()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 751
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v2, 0x4

    if-eq v0, v2, :cond_3

    const-string v0, "pref_kbd_bg_soft"

    const/16 v2, 0x46

    invoke-static {p2, v6, v2}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v2

    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 752
    :cond_3
    if-nez p4, :cond_4

    sget-object p4, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    :cond_4
    invoke-virtual {p4, v1}, Lcom/mrkeyboard/app/MrKeyLook;->write(Landroid/content/SharedPreferences$Editor;)V

    .line 753
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 754
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->readPrefs()V

    .line 755
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v7, :cond_5

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->loadImage()V

    .line 756
    :cond_5
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->galleryChanged()V

    goto :goto_0

    .line 749
    :cond_6
    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 160
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 161
    return-void
.end method

.method bigImage(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Landroid/graphics/Bitmap;
    .locals 2

    .prologue
    .line 603
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 611
    :goto_0
    return-object v0

    .line 604
    :cond_0
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_3

    .line 605
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigScene:Landroid/graphics/Bitmap;

    if-eqz v0, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigSceneIndex:I

    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    if-eq v0, v1, :cond_2

    .line 606
    :cond_1
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrScenes;->load(Landroid/content/Context;I)Landroid/graphics/Bitmap;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigScene:Landroid/graphics/Bitmap;

    .line 607
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigSceneIndex:I

    .line 609
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigScene:Landroid/graphics/Bitmap;

    goto :goto_0

    .line 611
    :cond_3
    const/4 v0, 0x0

    goto :goto_0
.end method

.method buildMore(I)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 394
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabLoad:I

    if-ne p1, v0, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 417
    :cond_0
    :goto_0
    return-void

    .line 395
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    add-int/lit8 v1, v1, 0x3

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 396
    :goto_1
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    if-ge v0, v1, :cond_2

    .line 397
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->addCard(Lcom/mrkeyboard/app/MrThemesActivity$Card;I)V

    .line 398
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    goto :goto_1

    .line 400
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ge v0, v1, :cond_3

    .line 401
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    new-instance v1, Lcom/mrkeyboard/app/MrThemesActivity$5;

    invoke-direct {v1, p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity$5;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    .line 408
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRow:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->fillRow(Landroid/widget/LinearLayout;I)V

    .line 409
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    const/16 v1, 0x9

    if-ne v0, v1, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->hasImage(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 410
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_remove"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$6;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrThemesActivity$6;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    invoke-virtual {v0, v1, v4, v2}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRemove:Landroid/widget/TextView;

    .line 415
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
    .line 631
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->backgroundName(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;

    move-result-object v0

    .line 632
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

    .line 342
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 343
    if-nez p1, :cond_1

    move v0, v1

    .line 344
    :goto_0
    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mListed:I

    if-ge v0, v2, :cond_4

    .line 345
    new-instance v4, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    array-length v2, v2

    if-ge v0, v2, :cond_0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    aget-object v2, v2, v0

    :goto_1
    invoke-direct {v4, v1, v0, v7, v2}, Lcom/mrkeyboard/app/MrThemesActivity$Card;-><init>(IILcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;)V

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 344
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 345
    :cond_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    aget-object v2, v2, v0

    goto :goto_1

    .line 347
    :cond_1
    if-ne p1, v9, :cond_2

    move v0, v1

    .line 348
    :goto_2
    sget-object v2, Lcom/mrkeyboard/app/MrBackdrop;->COLORS:[I

    array-length v2, v2

    if-ge v0, v2, :cond_4

    .line 349
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

    .line 348
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 351
    :cond_2
    if-ne p1, v6, :cond_3

    move v0, v1

    .line 352
    :goto_3
    sget v2, Lcom/mrkeyboard/app/MrBackdrop;->GRADIENT_COUNT:I

    if-ge v0, v2, :cond_4

    .line 353
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

    .line 352
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 355
    :cond_3
    const/16 v0, 0x9

    if-ne p1, v0, :cond_5

    .line 356
    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_themes_photo"

    new-array v5, v1, [Ljava/lang/Object;

    invoke-virtual {v2, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v6, v1, v7, v2}, Lcom/mrkeyboard/app/MrThemesActivity$Card;-><init>(IILcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;)V

    invoke-interface {v3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 357
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

    .line 365
    :cond_4
    return-object v3

    .line 359
    :cond_5
    add-int/lit8 v0, p1, -0x3

    .line 360
    :goto_4
    const/4 v2, 0x6

    if-ge v1, v2, :cond_4

    .line 361
    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrScenes;->scene(II)I

    move-result v2

    .line 362
    new-instance v4, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->scene(I)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v5

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->sceneName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v9, v2, v5, v6}, Lcom/mrkeyboard/app/MrThemesActivity$Card;-><init>(IILcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;)V

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 360
    add-int/lit8 v1, v1, 0x1

    goto :goto_4
.end method

.method choicePosition()I
    .locals 5

    .prologue
    const/4 v2, -0x1

    .line 298
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    if-nez v0, :cond_1

    move v1, v2

    .line 307
    :cond_0
    :goto_0
    return v1

    .line 299
    :cond_1
    const/4 v0, 0x0

    move v1, v0

    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_4

    .line 300
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    .line 301
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v3, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-nez v3, :cond_3

    .line 302
    iget v3, v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;->kind:I

    if-nez v3, :cond_2

    iget v0, v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;->index:I

    iget v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    if-eq v0, v3, :cond_0

    .line 299
    :cond_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 303
    :cond_3
    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;->spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    if-eqz v3, :cond_2

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;->spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v3, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v4, v4, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v3, v4, :cond_2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v3, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v4, 0x3

    if-eq v3, v4, :cond_0

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;->spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v3, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    if-ne v0, v3, :cond_2

    goto :goto_0

    :cond_4
    move v1, v2

    .line 307
    goto :goto_0
.end method

.method chooseTheme(I)V
    .locals 3

    .prologue
    .line 689
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

    .line 690
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->readPrefs()V

    .line 691
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    .line 692
    return-void

    .line 689
    :cond_0
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method closeDialog()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 776
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialog:Landroid/app/Dialog;

    .line 777
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialog:Landroid/app/Dialog;

    .line 778
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogPreview:Lcom/mrkeyboard/app/MrThemePreview;

    .line 779
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCrop:Lcom/mrkeyboard/app/MrCropView;

    .line 780
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogEdge:Landroid/widget/SeekBar;

    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogKey:Landroid/widget/SeekBar;

    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogSoft:Landroid/widget/SeekBar;

    .line 781
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogNext:Landroid/widget/TextView;

    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCancel:Landroid/widget/TextView;

    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogApply:Landroid/widget/TextView;

    .line 782
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogLook:[Lcom/mrkeyboard/app/MrKeyLook;

    .line 783
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogStyle:[I

    .line 784
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogText:Landroid/widget/LinearLayout;

    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogKeys:Landroid/widget/LinearLayout;

    .line 785
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closePicker()V

    .line 786
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V

    .line 787
    :cond_0
    return-void
.end method

.method closePicker()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 791
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPicker:Landroid/app/Dialog;

    .line 792
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPicker:Landroid/app/Dialog;

    .line 793
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerView:Lcom/mrkeyboard/app/MrColorPicker;

    .line 794
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerCancel:Landroid/widget/TextView;

    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerOk:Landroid/widget/TextView;

    .line 795
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V

    .line 796
    :cond_0
    return-void
.end method

.method detail()Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 640
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_theme_one"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 645
    :cond_0
    :goto_0
    return-object v0

    .line 641
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->tabOfChoice()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->tabName(I)Ljava/lang/String;

    move-result-object v0

    .line 642
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->hasStyles(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 643
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

    .line 1335
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    if-nez v0, :cond_0

    .line 1338
    :goto_0
    return-void

    .line 1336
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 1337
    :goto_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    invoke-virtual {p0, v1, v0, v2, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->showCrop(Landroid/graphics/Bitmap;Lcom/mrkeyboard/app/MrBackdrop$Spec;IZ)V

    goto :goto_0

    .line 1336
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

    .line 626
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    .line 627
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    if-ne v0, v1, :cond_0

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->showTab(I)V

    .line 628
    :cond_0
    return-void
.end method

.method imported(Landroid/graphics/Bitmap;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 1321
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1322
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->discardPending(Landroid/content/Context;)V

    .line 1331
    :goto_0
    return-void

    .line 1325
    :cond_0
    if-nez p1, :cond_1

    .line 1326
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->discardPending(Landroid/content/Context;)V

    .line 1327
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_image_failed"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 1330
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

.method inUse(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 709
    if-nez p2, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v1, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v1, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    iget v2, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eq v1, v2, :cond_1

    .line 710
    :cond_0
    :goto_0
    return v0

    :cond_1
    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v2, 0x3

    if-eq v1, v2, :cond_2

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v1, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    iget v2, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    if-ne v1, v2, :cond_0

    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method loadImage()V
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 1355
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->hasImage(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1356
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 1357
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 1375
    :goto_0
    return-void

    .line 1360
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    .line 1361
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$38;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$38;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 1374
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method loadScenes(I)V
    .locals 5

    .prologue
    .line 1382
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 1383
    const/4 v0, 0x0

    :goto_0
    const/4 v2, 0x6

    if-ge v0, v2, :cond_1

    .line 1384
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrScenes;->scene(II)I

    move-result v2

    .line 1385
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScenes:[Landroid/graphics/Bitmap;

    aget-object v3, v3, v2

    if-nez v3, :cond_0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSceneBusy:[Z

    aget-boolean v3, v3, v2

    if-nez v3, :cond_0

    .line 1386
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSceneBusy:[Z

    const/4 v4, 0x1

    aput-boolean v4, v3, v2

    .line 1387
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1383
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1390
    :cond_1
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1405
    :goto_1
    return-void

    .line 1391
    :cond_2
    new-instance v0, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$39;

    invoke-direct {v2, p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity$39;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Ljava/util/List;)V

    invoke-direct {v0, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 1404
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    goto :goto_1
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 3

    .prologue
    .line 1286
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 1287
    const/16 v0, 0x47

    if-ne p1, v0, :cond_0

    const/4 v0, -0x1

    if-ne p2, v0, :cond_0

    if-nez p3, :cond_1

    .line 1317
    :cond_0
    :goto_0
    return-void

    .line 1288
    :cond_1
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    .line 1289
    if-eqz v0, :cond_0

    .line 1291
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$37;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$37;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/net/Uri;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 1316
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 14

    .prologue
    const/high16 v13, 0x41600000    # 14.0f

    const/4 v12, 0x1

    const/high16 v11, 0x41000000    # 8.0f

    const/4 v10, -0x2

    const/4 v1, 0x0

    .line 165
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 166
    new-instance v0, Lcom/mrkeyboard/app/MrKit;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrKit;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 167
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    .line 168
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->tags(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    .line 169
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->names(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    .line 170
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->values(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    .line 171
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrThemeColors;->listed([Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mListed:I

    .line 172
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->readPrefs()V

    .line 174
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    .line 175
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->bg:I

    const/4 v4, 0x0

    invoke-virtual {v0, v3, v1, v4, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 177
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-virtual {v0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41800000    # 16.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v2, v0, v3, v1, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 178
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

    .line 182
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->side(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 178
    invoke-virtual {v2, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 186
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 187
    const/16 v3, 0x10

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 188
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

    .line 189
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

    invoke-virtual {v3, v4, v5, v13, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 191
    invoke-virtual {v0, v12}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 192
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_themes_current"

    new-array v5, v1, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 193
    new-instance v3, Lcom/mrkeyboard/app/MrThemesActivity$2;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrThemesActivity$2;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 198
    new-instance v3, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    .line 199
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const v5, 0x3fa66666    # 1.3f

    invoke-direct {v4, v1, v10, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 200
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v3

    .line 201
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v13}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v3, v4, v1, v1, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 202
    const/16 v4, 0x10

    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 203
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

    invoke-virtual {v4, v5, v6, v7, v12}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    .line 204
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

    .line 205
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {v5, v6, v1, v11, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 206
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v5, v10, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 207
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, ""

    const/high16 v6, 0x41880000    # 17.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v4, v5, v6, v7, v12}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    .line 208
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    const/4 v5, 0x2

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 209
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v6, 0x8

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 210
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, ""

    const/high16 v6, 0x41500000    # 13.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v4, v5, v6, v7, v1}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDetail:Landroid/widget/TextView;

    .line 211
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDetail:Landroid/widget/TextView;

    const/4 v5, 0x3

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 212
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDetail:Landroid/widget/TextView;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v6, 0x4

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 213
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v4, v1, v10, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 214
    const/16 v3, 0xc

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->side(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 217
    new-instance v0, Landroid/widget/HorizontalScrollView;

    invoke-direct {v0, p0}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    .line 218
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    invoke-virtual {v0, v1}, Landroid/widget/HorizontalScrollView;->setHorizontalScrollBarEnabled(Z)V

    .line 219
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v3

    move v0, v1

    .line 220
    :goto_0
    const/16 v4, 0xa

    if-ge v0, v4, :cond_1

    .line 222
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->tabName(I)Ljava/lang/String;

    move-result-object v5

    const/high16 v6, 0x41700000    # 15.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v4, v5, v6, v7, v1}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    .line 223
    const/16 v5, 0x11

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setGravity(I)V

    .line 224
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v5, v13}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v7, v13}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v7

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v8, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v8

    invoke-virtual {v4, v5, v6, v7, v8}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 225
    invoke-virtual {v4, v12}, Landroid/widget/TextView;->setClickable(Z)V

    .line 226
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$3;

    invoke-direct {v5, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$3;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 231
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v5, v10, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 232
    if-lez v0, :cond_0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x40c00000    # 6.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-virtual {v5, v6, v1, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 233
    :cond_0
    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 234
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    invoke-interface {v5, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 220
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 236
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    new-instance v4, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v4, v10, v10}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v3, v4}, Landroid/widget/HorizontalScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 237
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    const/16 v3, 0xe

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->side(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 241
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    .line 242
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41a00000    # 20.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v0, v1, v1, v3, v1}, Landroid/widget/ScrollView;->setPadding(IIII)V

    .line 243
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setClipToPadding(Z)V

    .line 244
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    const/high16 v3, 0x2000000

    invoke-virtual {v0, v3}, Landroid/widget/ScrollView;->setScrollBarStyle(I)V

    .line 245
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x40400000    # 3.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v0, v3}, Landroid/widget/ScrollView;->setScrollBarSize(I)V

    .line 246
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v0, v12}, Landroid/widget/ScrollView;->setScrollbarFadingEnabled(Z)V

    .line 247
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

    .line 248
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    .line 249
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41c00000    # 24.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v0, v1, v1, v1, v3}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 250
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    new-instance v4, Landroid/view/ViewGroup$LayoutParams;

    const/4 v5, -0x1

    invoke-direct {v4, v5, v10}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v3, v4}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 251
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x1

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v0, v3, v1, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 252
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41400000    # 12.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v0, v1, v3, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 253
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v2, v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 255
    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->setContentView(Landroid/view/View;)V

    .line 256
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    .line 257
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->tabOfChoice()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->showTab(I)V

    .line 258
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->loadImage()V

    .line 259
    return-void
.end method

.method protected onDestroy()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 263
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    .line 264
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabLoad:I

    .line 265
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closeDialog()V

    .line 267
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->discardPending(Landroid/content/Context;)V

    .line 268
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 269
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 270
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigScene:Landroid/graphics/Bitmap;

    .line 271
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 272
    return-void
.end method

.method openBackdrop(Lcom/mrkeyboard/app/MrBackdrop$Spec;)V
    .locals 3

    .prologue
    .line 696
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    .line 697
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->editImage()V

    .line 701
    :goto_0
    return-void

    .line 700
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

    .line 1270
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrThemesActivity;->pickers(I)Ljava/util/List;

    move-result-object v3

    move v1, v2

    .line 1271
    :goto_0
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    .line 1273
    :try_start_0
    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/Intent;

    const/16 v4, 0x47

    invoke-virtual {p0, v0, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1282
    :goto_1
    return-void

    .line 1277
    :catch_0
    move-exception v0

    .line 1271
    :goto_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 1281
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_image_failed"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v1, v3, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_1

    .line 1275
    :catch_1
    move-exception v0

    goto :goto_2
.end method

.method readPrefs()V
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 576
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    const-string v3, "pref_keyboard_layout"

    const-string v4, "0"

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrThemeColors;->indexOf([Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    .line 578
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

    .line 579
    :goto_0
    if-eqz v2, :cond_1

    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    :goto_1
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 580
    if-eqz v2, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    aget-object v0, v0, v1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->styleOf(Ljava/lang/String;)I

    move-result v0

    :goto_2
    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStyle:I

    .line 581
    if-eqz v2, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeyLook;->read(Landroid/content/SharedPreferences;)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    :goto_3
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 582
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->soft(Landroid/content/Context;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    .line 583
    return-void

    :cond_0
    move v2, v1

    .line 578
    goto :goto_0

    .line 579
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    goto :goto_1

    :cond_2
    move v0, v1

    .line 580
    goto :goto_2

    .line 581
    :cond_3
    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    goto :goto_3
.end method

.method refresh()V
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 616
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->tag()Ljava/lang/String;

    move-result-object v1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->bigImage(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Landroid/graphics/Bitmap;

    move-result-object v4

    iget v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    invoke-virtual {v0, v1, v3, v4, v5}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 617
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->setLook(Lcom/mrkeyboard/app/MrKeyLook;)V

    .line 618
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->caption()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 619
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDetail:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->detail()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    move v1, v2

    .line 620
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

    .line 621
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

    .line 622
    :cond_1
    return-void
.end method

.method removeImage()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 1341
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->removeImage(Landroid/content/Context;)V

    .line 1342
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    .line 1344
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

    .line 1346
    :cond_0
    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 1347
    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 1348
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    .line 1349
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->readPrefs()V

    .line 1350
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->galleryChanged()V

    .line 1351
    return-void

    .line 1344
    :cond_1
    const-string v0, "0"

    goto :goto_0
.end method

.method sceneLoaded(ILandroid/graphics/Bitmap;)V
    .locals 5

    .prologue
    const/4 v3, 0x0

    .line 1409
    if-ltz p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScenes:[Landroid/graphics/Bitmap;

    array-length v0, v0

    if-lt p1, v0, :cond_1

    .line 1418
    :cond_0
    return-void

    .line 1410
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScenes:[Landroid/graphics/Bitmap;

    aput-object p2, v0, p1

    .line 1411
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSceneBusy:[Z

    aput-boolean v3, v0, p1

    move v2, v3

    .line 1412
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v2, v0, :cond_0

    .line 1413
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 1414
    iget v1, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v4, 0x2

    if-ne v1, v4, :cond_2

    iget v1, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    if-ne v1, p1, :cond_2

    .line 1415
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->themeTag(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4, v0, p2, v3}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 1412
    :cond_2
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0
.end method

.method showChoice()V
    .locals 3

    .prologue
    .line 315
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->tabOfChoice()I

    move-result v0

    .line 316
    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    if-ne v0, v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    if-nez v1, :cond_1

    :cond_0
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->showTab(I)V

    .line 317
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->choicePosition()I

    move-result v1

    .line 318
    if-gez v1, :cond_2

    .line 324
    :goto_0
    return-void

    .line 319
    :cond_2
    :goto_1
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    if-gt v0, v1, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-ge v0, v2, :cond_3

    .line 320
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->addCard(Lcom/mrkeyboard/app/MrThemesActivity$Card;I)V

    .line 321
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    goto :goto_1

    .line 323
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    div-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->revealRow(Landroid/view/View;I)V

    goto :goto_0
.end method

.method showColorPicker(Ljava/lang/String;I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 20

    .prologue
    .line 1111
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closePicker()V

    .line 1112
    const/4 v4, 0x0

    aget-object v7, p3, v4

    .line 1113
    move/from16 v0, p2

    invoke-static {v7, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->colorOf(Lcom/mrkeyboard/app/MrKeyLook;I)I

    move-result v4

    .line 1114
    if-nez v4, :cond_0

    .line 1115
    if-nez p2, :cond_2

    const/4 v4, -0x1

    .line 1117
    :cond_0
    :goto_0
    const/4 v5, 0x0

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrThemesActivity;->newDialog(Z)Landroid/app/Dialog;

    move-result-object v12

    .line 1118
    invoke-virtual {v12}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v5

    .line 1120
    if-eqz v5, :cond_1

    const/4 v6, 0x2

    invoke-virtual {v5, v6}, Landroid/view/Window;->clearFlags(I)V

    .line 1121
    :cond_1
    invoke-direct/range {p0 .. p1}, Lcom/mrkeyboard/app/MrThemesActivity;->sheetBox(Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v13

    .line 1122
    new-instance v14, Lcom/mrkeyboard/app/MrColorPicker;

    move-object/from16 v0, p0

    invoke-direct {v14, v0}, Lcom/mrkeyboard/app/MrColorPicker;-><init>(Landroid/content/Context;)V

    .line 1123
    invoke-virtual {v14, v4}, Lcom/mrkeyboard/app/MrColorPicker;->setColor(I)V

    .line 1124
    new-instance v4, Lcom/mrkeyboard/app/MrThemesActivity$28;

    move-object/from16 v0, p0

    move-object/from16 v1, p3

    move/from16 v2, p2

    move-object/from16 v3, p4

    invoke-direct {v4, v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrThemesActivity$28;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[Lcom/mrkeyboard/app/MrKeyLook;ILjava/lang/Runnable;)V

    invoke-virtual {v14, v4}, Lcom/mrkeyboard/app/MrColorPicker;->setListener(Lcom/mrkeyboard/app/MrColorPicker$Listener;)V

    .line 1130
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v5, 0x10

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    invoke-virtual {v13, v14, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1131
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v15

    .line 1132
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v5, 0x12

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    invoke-virtual {v13, v15, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1133
    new-instance v4, Lcom/mrkeyboard/app/MrThemesActivity$29;

    move-object/from16 v5, p0

    move-object/from16 v6, p3

    move-object/from16 v8, p4

    move-object/from16 v9, p5

    invoke-direct/range {v4 .. v9}, Lcom/mrkeyboard/app/MrThemesActivity$29;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[Lcom/mrkeyboard/app/MrKeyLook;Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    .line 1141
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_themes_cancel"

    const/4 v8, 0x0

    new-array v8, v8, [Ljava/lang/Object;

    invoke-virtual {v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    const/4 v7, 0x0

    new-instance v8, Lcom/mrkeyboard/app/MrThemesActivity$30;

    move-object/from16 v0, p0

    invoke-direct {v8, v0, v4}, Lcom/mrkeyboard/app/MrThemesActivity$30;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Ljava/lang/Runnable;)V

    invoke-virtual {v5, v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v16

    .line 1146
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v17, v0

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_themes_done"

    const/4 v7, 0x0

    new-array v7, v7, [Ljava/lang/Object;

    invoke-virtual {v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v18

    const/16 v19, 0x1

    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$31;

    move-object/from16 v6, p0

    move-object/from16 v7, p3

    move/from16 v8, p2

    move-object v9, v14

    move-object/from16 v10, p4

    move-object/from16 v11, p5

    invoke-direct/range {v5 .. v11}, Lcom/mrkeyboard/app/MrThemesActivity$31;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[Lcom/mrkeyboard/app/MrKeyLook;ILcom/mrkeyboard/app/MrColorPicker;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    move-object/from16 v0, v17

    move-object/from16 v1, v18

    move/from16 v2, v19

    invoke-virtual {v0, v1, v2, v5}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v5

    .line 1154
    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v7, 0x0

    const/4 v8, -0x2

    const/high16 v9, 0x3f800000    # 1.0f

    invoke-direct {v6, v7, v8, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 1155
    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v10, 0x40c00000    # 6.0f

    invoke-virtual {v9, v10}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v9

    const/4 v10, 0x0

    invoke-virtual {v6, v7, v8, v9, v10}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1156
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v8, 0x0

    const/4 v9, -0x2

    const/high16 v10, 0x3f800000    # 1.0f

    invoke-direct {v7, v8, v9, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 1157
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v9, 0x40c00000    # 6.0f

    invoke-virtual {v8, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v8

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-virtual {v7, v8, v9, v10, v11}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1158
    move-object/from16 v0, v16

    invoke-virtual {v15, v0, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1159
    invoke-virtual {v15, v5, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1160
    invoke-virtual {v12, v13}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 1161
    new-instance v6, Lcom/mrkeyboard/app/MrThemesActivity$32;

    move-object/from16 v0, p0

    invoke-direct {v6, v0, v12, v4}, Lcom/mrkeyboard/app/MrThemesActivity$32;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/app/Dialog;Ljava/lang/Runnable;)V

    invoke-virtual {v12, v6}, Landroid/app/Dialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    .line 1166
    move-object/from16 v0, p0

    iput-object v12, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mPicker:Landroid/app/Dialog;

    .line 1167
    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerView:Lcom/mrkeyboard/app/MrColorPicker;

    .line 1168
    move-object/from16 v0, p0

    iput-object v5, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerOk:Landroid/widget/TextView;

    .line 1169
    move-object/from16 v0, v16

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerCancel:Landroid/widget/TextView;

    .line 1170
    invoke-virtual {v12}, Landroid/app/Dialog;->show()V

    .line 1171
    return-void

    .line 1115
    :cond_2
    const/4 v4, 0x1

    move/from16 v0, p2

    if-ne v0, v4, :cond_3

    const v4, -0x908401

    goto/16 :goto_0

    :cond_3
    iget v4, v7, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    if-eqz v4, :cond_4

    iget v4, v7, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    :goto_1
    invoke-static {v4}, Lcom/mrkeyboard/app/MrKeyLook;->partner(I)I

    move-result v4

    goto/16 :goto_0

    :cond_4
    const v4, -0x908401

    goto :goto_1
.end method

.method showCrop(Landroid/graphics/Bitmap;Lcom/mrkeyboard/app/MrBackdrop$Spec;IZ)V
    .locals 17

    .prologue
    .line 1178
    if-nez p1, :cond_0

    .line 1250
    :goto_0
    return-void

    .line 1179
    :cond_0
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closeDialog()V

    .line 1180
    const/4 v2, 0x1

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->newDialog(Z)Landroid/app/Dialog;

    move-result-object v9

    .line 1181
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v10

    .line 1182
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

    .line 1183
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

    .line 1184
    const/16 v3, 0x11

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setGravity(I)V

    .line 1185
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v10, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1186
    new-instance v2, Lcom/mrkeyboard/app/MrCropView;

    move-object/from16 v0, p0

    invoke-direct {v2, v0}, Lcom/mrkeyboard/app/MrCropView;-><init>(Landroid/content/Context;)V

    .line 1187
    move-object/from16 v0, p2

    iget v4, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->zoom:I

    move-object/from16 v0, p2

    iget v5, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dx:I

    move-object/from16 v0, p2

    iget v6, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dy:I

    move-object/from16 v3, p1

    move/from16 v7, p3

    invoke-virtual/range {v2 .. v7}, Lcom/mrkeyboard/app/MrCropView;->set(Landroid/graphics/Bitmap;IIII)V

    .line 1188
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, -0x1

    const/4 v5, 0x0

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-direct {v3, v4, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 1189
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

    .line 1190
    invoke-virtual {v10, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1192
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v3

    .line 1193
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    invoke-virtual {v10, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1194
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

    .line 1195
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

    .line 1196
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x2

    const/4 v7, -0x2

    invoke-direct {v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1197
    const/4 v3, 0x1

    new-array v8, v3, [I

    const/4 v3, 0x0

    aput p3, v8, v3

    .line 1198
    new-instance v11, Landroid/widget/SeekBar;

    move-object/from16 v0, p0

    invoke-direct {v11, v0}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    .line 1199
    const/16 v3, 0x46

    invoke-virtual {v11, v3}, Landroid/widget/SeekBar;->setMax(I)V

    .line 1200
    move/from16 v0, p3

    invoke-virtual {v11, v0}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 1201
    new-instance v3, Lcom/mrkeyboard/app/MrThemesActivity$33;

    move-object/from16 v0, p0

    invoke-direct {v3, v0, v8, v2, v4}, Lcom/mrkeyboard/app/MrThemesActivity$33;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[ILcom/mrkeyboard/app/MrCropView;Landroid/widget/TextView;)V

    invoke-virtual {v11, v3}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 1215
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x6

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v10, v11, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1216
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

    .line 1218
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v12

    .line 1219
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0xe

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v10, v12, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1220
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

    new-instance v6, Lcom/mrkeyboard/app/MrThemesActivity$34;

    move-object/from16 v0, p0

    move/from16 v1, p4

    invoke-direct {v6, v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity$34;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Z)V

    invoke-virtual {v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v13

    .line 1226
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

    new-instance v3, Lcom/mrkeyboard/app/MrThemesActivity$35;

    move-object/from16 v4, p0

    move/from16 v5, p4

    move-object v6, v2

    move-object/from16 v7, p1

    invoke-direct/range {v3 .. v8}, Lcom/mrkeyboard/app/MrThemesActivity$35;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;ZLcom/mrkeyboard/app/MrCropView;Landroid/graphics/Bitmap;[I)V

    move/from16 v0, v16

    invoke-virtual {v14, v15, v0, v3}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v3

    .line 1232
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, 0x0

    const/4 v6, -0x2

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-direct {v4, v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 1233
    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v8, 0x40c00000    # 6.0f

    invoke-virtual {v7, v8}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v7

    const/4 v8, 0x0

    invoke-virtual {v4, v5, v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1234
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, 0x0

    const/4 v7, -0x2

    const/high16 v8, 0x3f800000    # 1.0f

    invoke-direct {v5, v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 1235
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x40c00000    # 6.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v14, 0x0

    invoke-virtual {v5, v6, v7, v8, v14}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1236
    invoke-virtual {v12, v13, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1237
    invoke-virtual {v12, v3, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1238
    invoke-virtual {v9, v10}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 1239
    new-instance v4, Lcom/mrkeyboard/app/MrThemesActivity$36;

    move-object/from16 v0, p0

    move/from16 v1, p4

    invoke-direct {v4, v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity$36;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Z)V

    invoke-virtual {v9, v4}, Landroid/app/Dialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    .line 1244
    move-object/from16 v0, p0

    iput-object v9, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialog:Landroid/app/Dialog;

    .line 1245
    move-object/from16 v0, p0

    iput-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCrop:Lcom/mrkeyboard/app/MrCropView;

    .line 1246
    move-object/from16 v0, p0

    iput-object v11, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogSoft:Landroid/widget/SeekBar;

    .line 1247
    move-object/from16 v0, p0

    iput-object v13, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCancel:Landroid/widget/TextView;

    .line 1248
    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogNext:Landroid/widget/TextView;

    .line 1249
    invoke-virtual {v9}, Landroid/app/Dialog;->show()V

    goto/16 :goto_0
.end method

.method showPreview(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;IZ)V
    .locals 26

    .prologue
    .line 866
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closeDialog()V

    .line 867
    const/4 v3, 0x0

    move-object/from16 v0, p0

    invoke-direct {v0, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->newDialog(Z)Landroid/app/Dialog;

    move-result-object v20

    .line 868
    invoke-static/range {p0 .. p1}, Lcom/mrkeyboard/app/MrThemesActivity;->backgroundName(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    invoke-direct {v0, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->sheetBox(Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v21

    .line 869
    new-instance v5, Lcom/mrkeyboard/app/MrThemePreview;

    move-object/from16 v0, p0

    invoke-direct {v5, v0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    .line 871
    const/4 v3, 0x1

    invoke-virtual {v5, v3}, Lcom/mrkeyboard/app/MrThemePreview;->setFull(Z)V

    .line 872
    if-nez p2, :cond_0

    move-object/from16 v0, p1

    iget v3, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v4, 0x2

    if-eq v3, v4, :cond_4

    :cond_0
    move-object/from16 v8, p2

    .line 873
    :goto_0
    const/4 v3, 0x1

    new-array v9, v3, [I

    const/4 v3, 0x0

    aput p3, v9, v3

    .line 875
    const/4 v3, 0x1

    new-array v7, v3, [I

    const/4 v3, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p4

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->startStyle(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)I

    move-result v4

    aput v4, v7, v3

    .line 876
    const/4 v3, 0x1

    new-array v10, v3, [Lcom/mrkeyboard/app/MrKeyLook;

    const/4 v3, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p4

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->startLook(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v4

    aput-object v4, v10, v3

    .line 877
    new-instance v3, Lcom/mrkeyboard/app/MrThemesActivity$16;

    move-object/from16 v4, p0

    move-object/from16 v6, p1

    invoke-direct/range {v3 .. v10}, Lcom/mrkeyboard/app/MrThemesActivity$16;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrThemePreview;Lcom/mrkeyboard/app/MrBackdrop$Spec;[ILandroid/graphics/Bitmap;[I[Lcom/mrkeyboard/app/MrKeyLook;)V

    .line 883
    invoke-interface {v3}, Ljava/lang/Runnable;->run()V

    .line 884
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v6, 0xe

    invoke-virtual {v4, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    move-object/from16 v0, v21

    invoke-virtual {v0, v5, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 887
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v12

    .line 888
    new-instance v4, Lcom/mrkeyboard/app/MrCappedScroll;

    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrThemesActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v6

    iget v6, v6, Landroid/util/DisplayMetrics;->heightPixels:I

    int-to-float v6, v6

    const v8, 0x3ec28f5c    # 0.38f

    mul-float/2addr v6, v8

    invoke-static {v6}, Ljava/lang/Math;->round(F)I

    move-result v6

    move-object/from16 v0, p0

    invoke-direct {v4, v0, v6}, Lcom/mrkeyboard/app/MrCappedScroll;-><init>(Landroid/content/Context;I)V

    .line 889
    new-instance v6, Landroid/view/ViewGroup$LayoutParams;

    const/4 v8, -0x1

    const/4 v11, -0x2

    invoke-direct {v6, v8, v11}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v4, v12, v6}, Lcom/mrkeyboard/app/MrCappedScroll;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 890
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v8, 0x0

    invoke-virtual {v6, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    move-object/from16 v0, v21

    invoke-virtual {v0, v4, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 892
    const/16 v23, 0x0

    .line 893
    move-object/from16 v0, p1

    iget v4, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v6, 0x1

    if-eq v4, v6, :cond_1

    move-object/from16 v0, p1

    iget v4, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v6, 0x2

    if-ne v4, v6, :cond_2

    .line 894
    :cond_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_themes_soften"

    const/4 v8, 0x0

    new-array v8, v8, [Ljava/lang/Object;

    invoke-virtual {v4, v6, v8}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v13

    const/16 v14, 0x46

    const/16 v16, 0xe

    new-instance v17, Lcom/mrkeyboard/app/MrThemesActivity$17;

    move-object/from16 v0, v17

    move-object/from16 v1, p0

    invoke-direct {v0, v1, v9, v3}, Lcom/mrkeyboard/app/MrThemesActivity$17;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[ILjava/lang/Runnable;)V

    move-object/from16 v11, p0

    move/from16 v15, p3

    invoke-direct/range {v11 .. v17}, Lcom/mrkeyboard/app/MrThemesActivity;->slider(Landroid/widget/LinearLayout;Ljava/lang/String;IIILcom/mrkeyboard/app/MrThemesActivity$Setter;)Landroid/widget/SeekBar;

    move-result-object v23

    .line 902
    :cond_2
    invoke-static/range {p1 .. p1}, Lcom/mrkeyboard/app/MrBackdrop;->hasStyles(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z

    move-result v19

    .line 903
    if-eqz v19, :cond_5

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v4

    .line 904
    :goto_1
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v18

    .line 905
    const/4 v8, 0x0

    const/4 v6, 0x0

    .line 906
    if-eqz v19, :cond_3

    .line 907
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v11, "mr_themes_keys"

    const/4 v13, 0x0

    new-array v13, v13, [Ljava/lang/Object;

    invoke-virtual {v8, v11, v13}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    const/high16 v11, 0x41700000    # 15.0f

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v13, v13, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v14, 0x1

    invoke-virtual {v6, v8, v11, v13, v14}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v6

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v11, 0xe

    invoke-virtual {v8, v11}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v8

    invoke-virtual {v12, v6, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 908
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v8, 0x0

    invoke-virtual {v6, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    invoke-virtual {v12, v4, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 910
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v8, "mr_themes_key_opacity"

    const/4 v11, 0x0

    new-array v11, v11, [Ljava/lang/Object;

    invoke-virtual {v6, v8, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v13

    const/16 v14, 0xfa

    const/4 v6, 0x0

    aget-object v6, v10, v6

    iget v15, v6, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    const/16 v16, 0xc

    new-instance v17, Lcom/mrkeyboard/app/MrThemesActivity$18;

    move-object/from16 v0, v17

    move-object/from16 v1, p0

    invoke-direct {v0, v1, v10, v3}, Lcom/mrkeyboard/app/MrThemesActivity$18;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;)V

    move-object/from16 v11, p0

    invoke-direct/range {v11 .. v17}, Lcom/mrkeyboard/app/MrThemesActivity;->slider(Landroid/widget/LinearLayout;Ljava/lang/String;IIILcom/mrkeyboard/app/MrThemesActivity$Setter;)Landroid/widget/SeekBar;

    move-result-object v8

    .line 916
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v11, "mr_themes_edge_opacity"

    const/4 v13, 0x0

    new-array v13, v13, [Ljava/lang/Object;

    invoke-virtual {v6, v11, v13}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v13

    const/16 v14, 0xfa

    const/4 v6, 0x0

    aget-object v6, v10, v6

    iget v15, v6, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    const/16 v16, 0x8

    new-instance v17, Lcom/mrkeyboard/app/MrThemesActivity$19;

    move-object/from16 v0, v17

    move-object/from16 v1, p0

    invoke-direct {v0, v1, v10, v3}, Lcom/mrkeyboard/app/MrThemesActivity$19;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;)V

    move-object/from16 v11, p0

    invoke-direct/range {v11 .. v17}, Lcom/mrkeyboard/app/MrThemesActivity;->slider(Landroid/widget/LinearLayout;Ljava/lang/String;IIILcom/mrkeyboard/app/MrThemesActivity$Setter;)Landroid/widget/SeekBar;

    move-result-object v6

    .line 923
    :cond_3
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    if-eqz v19, :cond_6

    const/16 v11, 0xc

    :goto_2
    invoke-virtual {v13, v11}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v11

    move-object/from16 v0, v18

    invoke-virtual {v12, v0, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 924
    const/4 v11, 0x1

    new-array v0, v11, [Ljava/lang/Runnable;

    move-object/from16 v17, v0

    .line 925
    const/16 v19, 0x0

    new-instance v11, Lcom/mrkeyboard/app/MrThemesActivity$20;

    move-object/from16 v12, p0

    move-object v13, v4

    move-object v14, v7

    move-object v15, v10

    move-object/from16 v16, v3

    invoke-direct/range {v11 .. v18}, Lcom/mrkeyboard/app/MrThemesActivity$20;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/LinearLayout;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;Landroid/widget/LinearLayout;)V

    aput-object v11, v17, v19

    .line 931
    const/4 v3, 0x0

    aget-object v3, v17, v3

    invoke-interface {v3}, Ljava/lang/Runnable;->run()V

    .line 933
    new-instance v11, Lcom/mrkeyboard/app/MrThemesActivity$21;

    move-object/from16 v12, p0

    move-object/from16 v13, p1

    move-object v14, v9

    move-object v15, v7

    move-object/from16 v16, v10

    move/from16 v17, p4

    invoke-direct/range {v11 .. v17}, Lcom/mrkeyboard/app/MrThemesActivity$21;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrBackdrop$Spec;[I[I[Lcom/mrkeyboard/app/MrKeyLook;Z)V

    move-object/from16 v19, p0

    move-object/from16 v22, v5

    move/from16 v24, p4

    move-object/from16 v25, v11

    invoke-direct/range {v19 .. v25}, Lcom/mrkeyboard/app/MrThemesActivity;->sheetShow(Landroid/app/Dialog;Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrThemePreview;Landroid/widget/SeekBar;ZLjava/lang/Runnable;)V

    .line 939
    move-object/from16 v0, p0

    iput-object v8, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogKey:Landroid/widget/SeekBar;

    .line 940
    move-object/from16 v0, p0

    iput-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogEdge:Landroid/widget/SeekBar;

    .line 941
    move-object/from16 v0, p0

    iput-object v10, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogLook:[Lcom/mrkeyboard/app/MrKeyLook;

    .line 942
    move-object/from16 v0, p0

    iput-object v7, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogStyle:[I

    .line 943
    move-object/from16 v0, p0

    iput-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogKeys:Landroid/widget/LinearLayout;

    .line 944
    move-object/from16 v0, v18

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogText:Landroid/widget/LinearLayout;

    .line 945
    return-void

    .line 872
    :cond_4
    move-object/from16 v0, p1

    iget v3, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    move-object/from16 v0, p0

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrScenes;->load(Landroid/content/Context;I)Landroid/graphics/Bitmap;

    move-result-object v8

    goto/16 :goto_0

    .line 903
    :cond_5
    const/4 v4, 0x0

    goto/16 :goto_1

    .line 923
    :cond_6
    const/16 v11, 0xe

    goto :goto_2
.end method

.method showTab(I)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x0

    .line 373
    iput p1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    .line 374
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabLoad:I

    .line 375
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 376
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeTiles:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 377
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeActions:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 378
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 379
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 380
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgActions:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 381
    iput-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mMineTile:Lcom/mrkeyboard/app/MrThemePreview;

    .line 382
    iput-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRemove:Landroid/widget/TextView;

    .line 383
    iput-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRow:Landroid/widget/LinearLayout;

    .line 384
    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity;->cardsOf(I)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    .line 385
    iput v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    .line 386
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->styleTabs()V

    .line 387
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v1, v2, v2}, Landroid/widget/ScrollView;->scrollTo(II)V

    .line 388
    const/4 v1, 0x3

    if-lt p1, v1, :cond_0

    const/16 v1, 0x9

    if-ge p1, v1, :cond_0

    add-int/lit8 v1, p1, -0x3

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->loadScenes(I)V

    .line 389
    :cond_0
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->buildMore(I)V

    .line 390
    return-void
.end method

.method showThemePreview(I)V
    .locals 7

    .prologue
    const/4 v4, 0x0

    const/4 v5, 0x0

    .line 845
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closeDialog()V

    .line 846
    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/MrThemesActivity;->newDialog(Z)Landroid/app/Dialog;

    move-result-object v1

    .line 847
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    array-length v0, v0

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    aget-object v0, v0, p1

    :goto_0
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->sheetBox(Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v2

    .line 848
    new-instance v3, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    .line 849
    const/4 v0, 0x1

    invoke-virtual {v3, v0}, Lcom/mrkeyboard/app/MrThemePreview;->setFull(Z)V

    .line 850
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    aget-object v0, v0, p1

    sget-object v6, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {v3, v0, v6, v4, v5}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 851
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v6, 0xe

    invoke-virtual {v0, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v2, v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 852
    new-instance v6, Lcom/mrkeyboard/app/MrThemesActivity$15;

    invoke-direct {v6, p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity$15;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V

    move-object v0, p0

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrThemesActivity;->sheetShow(Landroid/app/Dialog;Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrThemePreview;Landroid/widget/SeekBar;ZLjava/lang/Runnable;)V

    .line 857
    return-void

    .line 847
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    aget-object v0, v0, p1

    goto :goto_0
.end method

.method startLook(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 1

    .prologue
    .line 720
    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/MrThemesActivity;->inUse(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    goto :goto_0
.end method

.method startSoft(Lcom/mrkeyboard/app/MrBackdrop$Spec;)I
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 725
    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v2, 0x1

    if-eq v1, v2, :cond_1

    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v2, 0x2

    if-eq v1, v2, :cond_1

    .line 726
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

.method startStyle(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)I
    .locals 1

    .prologue
    .line 715
    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/MrThemesActivity;->inUse(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)Z

    move-result v0

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStyle:I

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method styleTabs()V
    .locals 7

    .prologue
    const/4 v4, 0x1

    const/4 v2, 0x0

    .line 421
    move v1, v2

    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_4

    .line 422
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 423
    iget v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    if-ne v1, v3, :cond_0

    move v5, v4

    .line 424
    :goto_1
    if-eqz v5, :cond_1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    :goto_2
    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 425
    const/4 v6, 0x0

    if-eqz v5, :cond_2

    move v3, v4

    :goto_3
    invoke-virtual {v0, v6, v3}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 426
    if-eqz v5, :cond_3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->accent:I

    const/high16 v6, 0x41900000    # 18.0f

    invoke-virtual {v3, v5, v2, v6, v2}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    :goto_4
    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 421
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    :cond_0
    move v5, v2

    .line 423
    goto :goto_1

    .line 424
    :cond_1
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text2:I

    goto :goto_2

    :cond_2
    move v3, v2

    .line 425
    goto :goto_3

    .line 426
    :cond_3
    new-instance v3, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v3, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    goto :goto_4

    .line 428
    :cond_4
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    if-ltz v0, :cond_5

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ge v0, v1, :cond_5

    .line 429
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 430
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$7;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$7;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/TextView;)V

    invoke-virtual {v1, v2}, Landroid/widget/HorizontalScrollView;->post(Ljava/lang/Runnable;)Z

    .line 436
    :cond_5
    return-void
.end method

.method tabName(I)Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 278
    if-nez p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_themes"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 282
    :goto_0
    return-object v0

    .line 279
    :cond_0
    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_colors"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 280
    :cond_1
    const/4 v0, 0x2

    if-ne p1, v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_gradients"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 281
    :cond_2
    const/16 v0, 0x9

    if-ne p1, v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_gallery"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 282
    :cond_3
    add-int/lit8 v0, p1, -0x3

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->categoryName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method tabOfChoice()I
    .locals 1

    .prologue
    .line 287
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    packed-switch v0, :pswitch_data_0

    .line 292
    const/4 v0, 0x0

    :goto_0
    return v0

    .line 288
    :pswitch_0
    const/4 v0, 0x1

    goto :goto_0

    .line 289
    :pswitch_1
    const/4 v0, 0x2

    goto :goto_0

    .line 290
    :pswitch_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrScenes;->category(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x3

    goto :goto_0

    .line 291
    :pswitch_3
    const/16 v0, 0x9

    goto :goto_0

    .line 287
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
    .line 586
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
    .line 596
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 598
    :goto_0
    return-object v0

    .line 597
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

    .line 598
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method tileSpec(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Lcom/mrkeyboard/app/MrBackdrop$Spec;
    .locals 2

    .prologue
    const/4 v1, 0x3

    .line 591
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v1, :cond_0

    iget-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    :cond_0
    return-object p1
.end method
