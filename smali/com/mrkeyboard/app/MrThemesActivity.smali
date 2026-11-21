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

.field static final BUTTON_RADIUS:F = 10.0f

.field static final CARD_BACKGROUND:I = 0x1

.field static final CARD_FILL:F = 0.45f

.field static final CARD_LINE:F = 0.6f

.field static final CARD_LINE_EDGE:I = 0x50

.field static final CARD_LOOK:Lcom/mrkeyboard/app/MrKeyLook;

.field static final CARD_MINE:I = 0x3

.field static final CARD_PLUS:I = 0x2

.field static final CARD_RADIUS:F = 14.0f

.field static final CARD_THEME:I = 0x0

.field static final CHUNK:I = 0x3

.field static final CLOSE_DP:I = 0x24

.field static final COLUMNS:I = 0x2

.field static final GRADIENT_OFFERED:I = 0x2

.field static final IMAGES_URI:Ljava/lang/String; = "content://media/external/images/media"

.field static final MIN_CONTROLS_DP:I = 0x60

.field static final PICK_HUE:I = 0x1

.field static final PICK_HUE2:I = 0x2

.field static final PICK_LINE:I = 0x3

.field static final PICK_TEXT:I = 0x0

.field static final REQ_PICK:I = 0x47

.field static final REVEAL_TRIES:I = 0x8

.field static final REVEAL_WAIT_MS:I = 0x28

.field static final SCENE_SAMPLE:I = 0x2

.field static final SCROLLBAR_DP:I = 0xc

.field static final SCROLL_MARGIN_DP:I = 0x14

.field static final SCROLL_THUMB_ALPHA:I = 0x59

.field static final SHEET_SHARE:F = 0.98f

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

.field mDialogKeys:Landroid/widget/LinearLayout;

.field mDialogLine:Landroid/widget/LinearLayout;

.field mDialogLook:[Lcom/mrkeyboard/app/MrKeyLook;

.field mDialogNext:Landroid/widget/TextView;

.field mDialogPale:Z

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

.field mPickerOpacity:Lcom/mrkeyboard/app/MrOpacityBar;

.field mPickerOpacityValue:Landroid/widget/TextView;

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
.method static constructor <clinit>()V
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 1012
    new-instance v0, Lcom/mrkeyboard/app/MrKeyLook;

    const/16 v2, 0x50

    const/4 v6, -0x1

    move v3, v1

    move v4, v1

    move v5, v1

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrKeyLook;-><init>(IIIIII)V

    sput-object v0, Lcom/mrkeyboard/app/MrThemesActivity;->CARD_LOOK:Lcom/mrkeyboard/app/MrKeyLook;

    return-void
.end method

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

.method static synthetic access$100(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/LinearLayout;Z[II[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0

    .prologue
    .line 51
    invoke-direct/range {p0 .. p8}, Lcom/mrkeyboard/app/MrThemesActivity;->fillKeys(Landroid/widget/LinearLayout;Z[II[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    return-void
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/LinearLayout;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0

    .prologue
    .line 51
    invoke-direct/range {p0 .. p5}, Lcom/mrkeyboard/app/MrThemesActivity;->fillLine(Landroid/widget/LinearLayout;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    return-void
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/LinearLayout;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0

    .prologue
    .line 51
    invoke-direct/range {p0 .. p5}, Lcom/mrkeyboard/app/MrThemesActivity;->fillText(Landroid/widget/LinearLayout;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    return-void
.end method

.method private addCard(Lcom/mrkeyboard/app/MrThemesActivity$Card;I)V
    .locals 9

    .prologue
    const/4 v4, 0x0

    .line 474
    rem-int/lit8 v6, p2, 0x2

    .line 475
    if-nez v6, :cond_0

    .line 476
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRow:Landroid/widget/LinearLayout;

    .line 477
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRow:Landroid/widget/LinearLayout;

    const/16 v1, 0x30

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 478
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

    .line 480
    :cond_0
    new-instance v1, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    .line 481
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 483
    iget v0, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->kind:I

    packed-switch v0, :pswitch_data_0

    .line 513
    :pswitch_0
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$11;

    invoke-direct {v5, p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity$11;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrThemesActivity$Card;)V

    .line 518
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 519
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    iget-object v2, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 520
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgActions:Ljava/util/List;

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 523
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

    .line 524
    iget v2, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->kind:I

    iget v0, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->kind:I

    if-nez v0, :cond_3

    iget v0, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->index:I

    :goto_3
    invoke-direct {p0, v2, v1, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->bindCard(ILcom/mrkeyboard/app/MrThemePreview;I)V

    .line 525
    return-void

    .line 478
    :cond_1
    const/16 v0, 0xc

    goto :goto_0

    .line 485
    :pswitch_1
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$8;

    invoke-direct {v5, p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity$8;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrThemesActivity$Card;)V

    .line 490
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeTiles:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 491
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeActions:Ljava/util/List;

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 494
    :pswitch_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->card:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->stroke:I

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {v1, v0, v2, v5}, Lcom/mrkeyboard/app/MrThemePreview;->showPlus(III)V

    .line 495
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$9;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrThemesActivity$9;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    goto :goto_1

    .line 502
    :pswitch_3
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$10;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/MrThemesActivity$10;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    .line 507
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 508
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    iget-object v2, p1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 509
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgActions:Ljava/util/List;

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 510
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mMineTile:Lcom/mrkeyboard/app/MrThemePreview;

    goto :goto_1

    .line 523
    :cond_2
    const/4 v4, 0x0

    goto :goto_2

    .line 524
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    goto :goto_3

    .line 483
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

    .line 1321
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-direct {v0, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 1322
    if-eqz p3, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x41400000    # 12.0f

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    invoke-virtual {v0, v1, v3, v3, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1323
    :cond_0
    invoke-virtual {p1, p2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1324
    return-void
.end method

.method private addPresetDot(Landroid/widget/LinearLayout;IZZI[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 9

    .prologue
    .line 1220
    new-instance v0, Lcom/mrkeyboard/app/MrStyleDot;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-direct {v0, p0, p2, p3, v1}, Lcom/mrkeyboard/app/MrStyleDot;-><init>(Landroid/content/Context;IZI)V

    invoke-virtual {v0, p5}, Lcom/mrkeyboard/app/MrStyleDot;->tone(I)Lcom/mrkeyboard/app/MrStyleDot;

    move-result-object v8

    .line 1221
    invoke-static {p0, p2}, Lcom/mrkeyboard/app/MrThemesActivity;->styleName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v8, v0}, Lcom/mrkeyboard/app/MrStyleDot;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 1222
    const/4 v0, 0x1

    invoke-virtual {v8, v0}, Lcom/mrkeyboard/app/MrStyleDot;->setClickable(Z)V

    .line 1223
    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$26;

    move-object v1, p0

    move v2, p2

    move v3, p4

    move-object v4, p6

    move-object/from16 v5, p7

    move-object/from16 v6, p8

    move-object/from16 v7, p9

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/MrThemesActivity$26;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;IZ[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    invoke-virtual {v8, v0}, Lcom/mrkeyboard/app/MrStyleDot;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 1230
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v0

    if-lez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-direct {p0, p1, v8, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->addDot(Landroid/widget/LinearLayout;Landroid/view/View;Z)V

    .line 1231
    return-void

    .line 1230
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private addSwatchDot(Landroid/widget/LinearLayout;ILjava/lang/String;ZI[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 8

    .prologue
    .line 1235
    new-instance v0, Lcom/mrkeyboard/app/MrStyleDot;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v1, Lcom/mrkeyboard/app/MrKit;->accent:I

    const/4 v1, 0x0

    aget-object v1, p7, v1

    iget v6, v1, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    move-object v1, p0

    move v2, p5

    move v3, p4

    move v5, p2

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrStyleDot;-><init>(Landroid/content/Context;IZIII)V

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrStyleDot;->swatch()Lcom/mrkeyboard/app/MrStyleDot;

    move-result-object v7

    .line 1236
    invoke-virtual {v7, p3}, Lcom/mrkeyboard/app/MrStyleDot;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 1237
    const/4 v0, 0x1

    invoke-virtual {v7, v0}, Lcom/mrkeyboard/app/MrStyleDot;->setClickable(Z)V

    .line 1238
    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$27;

    move-object v1, p0

    move v2, p2

    move-object v3, p6

    move-object v4, p7

    move-object/from16 v5, p8

    move-object/from16 v6, p9

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrThemesActivity$27;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    invoke-virtual {v7, v0}, Lcom/mrkeyboard/app/MrStyleDot;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 1245
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v0

    if-lez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-direct {p0, p1, v7, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->addDot(Landroid/widget/LinearLayout;Landroid/view/View;Z)V

    .line 1246
    return-void

    .line 1245
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static backgroundName(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v3, 0x0

    .line 687
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    packed-switch v0, :pswitch_data_0

    .line 692
    const-string v0, ""

    .line 694
    :goto_0
    if-eqz v0, :cond_0

    :goto_1
    return-object v0

    .line 688
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

    .line 689
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

    .line 690
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

    .line 691
    :pswitch_3
    const-string v0, "mr_themes_mine"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 694
    :cond_0
    const-string v0, ""

    goto :goto_1

    .line 687
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_0
    .end packed-switch
.end method

.method private bindCard(ILcom/mrkeyboard/app/MrThemePreview;I)V
    .locals 8

    .prologue
    const/4 v3, 0x0

    const/4 v1, 0x1

    const/4 v2, 0x0

    const/4 v7, 0x3

    .line 560
    if-nez p1, :cond_2

    .line 561
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    aget-object v0, v0, p3

    sget-object v4, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {p2, v0, v4, v3, v2}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 562
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-nez v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    if-ne p3, v0, :cond_0

    move v2, v1

    .line 563
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->accent:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    invoke-virtual {p2, v2, v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->setChecked(ZII)V

    .line 564
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeActions:Ljava/util/List;

    invoke-interface {v0, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    invoke-virtual {p2}, Lcom/mrkeyboard/app/MrThemePreview;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    check-cast v1, Landroid/view/View;

    invoke-direct {p0, v0, v2, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->markAction(Landroid/widget/TextView;ZLandroid/view/View;)V

    .line 574
    :cond_1
    :goto_0
    return-void

    .line 565
    :cond_2
    if-eq p1, v1, :cond_3

    if-ne p1, v7, :cond_1

    .line 566
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    invoke-interface {v0, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->tileSpec(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v4

    .line 567
    invoke-static {v4}, Lcom/mrkeyboard/app/MrBackdrop;->themeTag(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->tileImage(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Landroid/graphics/Bitmap;

    move-result-object v6

    iget v0, v4, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v7, :cond_7

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v7, :cond_7

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    :goto_1
    invoke-virtual {p2, v5, v4, v6, v0}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 569
    iget v0, v4, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v5, 0x2

    if-eq v0, v5, :cond_4

    iget v0, v4, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v7, :cond_8

    :cond_4
    sget-object v0, Lcom/mrkeyboard/app/MrThemesActivity;->CARD_LOOK:Lcom/mrkeyboard/app/MrKeyLook;

    :goto_2
    invoke-virtual {p2, v0}, Lcom/mrkeyboard/app/MrThemePreview;->setLook(Lcom/mrkeyboard/app/MrKeyLook;)V

    .line 570
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eqz v0, :cond_6

    iget v0, v4, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v3, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v3, :cond_6

    iget v0, v4, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eq v0, v7, :cond_5

    iget v0, v4, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v3, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    if-ne v0, v3, :cond_6

    :cond_5
    move v2, v1

    .line 571
    :cond_6
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->accent:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    invoke-virtual {p2, v2, v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->setChecked(ZII)V

    .line 572
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgActions:Ljava/util/List;

    invoke-interface {v0, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    invoke-virtual {p2}, Lcom/mrkeyboard/app/MrThemePreview;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    check-cast v1, Landroid/view/View;

    invoke-direct {p0, v0, v2, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->markAction(Landroid/widget/TextView;ZLandroid/view/View;)V

    goto :goto_0

    :cond_7
    move v0, v2

    .line 567
    goto :goto_1

    :cond_8
    move-object v0, v3

    .line 569
    goto :goto_2
.end method

.method private card(Landroid/widget/LinearLayout;Ljava/lang/String;Landroid/widget/LinearLayout;I)Landroid/widget/LinearLayout;
    .locals 8

    .prologue
    const/4 v7, 0x0

    const/high16 v6, 0x41600000    # 14.0f

    .line 1030
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 1031
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41400000    # 12.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 1032
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->solidBg()I

    move-result v1

    .line 1033
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->faint:I

    const v4, 0x3ee66666    # 0.45f

    invoke-static {v1, v3, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->towards(IIF)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->line:I

    const v5, 0x3f19999a    # 0.6f

    invoke-static {v1, v4, v5}, Lcom/mrkeyboard/app/MrThemesActivity;->towards(IIF)I

    move-result v1

    invoke-virtual {v2, v3, v1, v6, v7}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 1034
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x41700000    # 15.0f

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v4, 0x1

    invoke-virtual {v1, p2, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1035
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v0, p3, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1036
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, p4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1037
    return-object v0
.end method

.method private cardBox(Lcom/mrkeyboard/app/MrThemePreview;Ljava/lang/String;Landroid/widget/TextView;Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;
    .locals 10

    .prologue
    const/high16 v9, 0x40000000    # 2.0f

    const/high16 v6, 0x40800000    # 4.0f

    const/4 v8, -0x2

    const/high16 v5, 0x40c00000    # 6.0f

    const/4 v7, 0x0

    .line 532
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 533
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

    .line 534
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->card:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->stroke:I

    const/high16 v4, 0x41400000    # 12.0f

    invoke-virtual {v1, v2, v3, v4, v7}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 535
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 536
    invoke-virtual {v0, p5}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 537
    invoke-virtual {v0, p2}, Landroid/widget/LinearLayout;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 538
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, -0x1

    invoke-direct {v1, v2, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, p1, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 539
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 540
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v1, v2, v7, v3, v7}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 541
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41500000    # 13.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v2, p2, v3, v4, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    .line 542
    const/4 v3, 0x2

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 543
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v3, v7, v8, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 544
    const/high16 v2, 0x41400000    # 12.0f

    invoke-virtual {p3, v2}, Landroid/widget/TextView;->setTextSize(F)V

    .line 545
    const/16 v2, 0x11

    invoke-virtual {p3, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 546
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

    .line 547
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x42200000    # 40.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {p3, v2}, Landroid/widget/TextView;->setMinWidth(I)V

    .line 548
    if-eqz p4, :cond_0

    :goto_0
    invoke-virtual {p3, p4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 549
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {p3, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 550
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

    .line 551
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v8, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, p3, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 552
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    .line 553
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41000000    # 8.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v2, v7, v3, v7, v4}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 554
    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 555
    return-object v0

    .line 548
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

    .line 458
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v0, -0x2

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-direct {v3, v1, v0, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 459
    if-nez p1, :cond_0

    move v2, v1

    :goto_0
    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    move v0, v1

    :goto_1
    invoke-virtual {v3, v2, v1, v0, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 460
    return-object v3

    .line 459
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
    .line 668
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

    .line 669
    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    const-string v0, ""

    goto :goto_0
.end method

.method static choosePreset(IZ[I[Lcom/mrkeyboard/app/MrKeyLook;)V
    .locals 5

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 1206
    if-eqz p1, :cond_1

    if-eqz p0, :cond_1

    .line 1207
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v1

    .line 1208
    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->ownStyle(I)I

    move-result v0

    aput v0, p2, v3

    .line 1209
    aget-object v0, p3, v3

    invoke-static {p0, v4}, Lcom/mrkeyboard/app/MrBackdrop;->presetColour(IZ)I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/mrkeyboard/app/MrKeyLook;->withHue(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    .line 1210
    const/4 v2, 0x2

    if-ne v1, v2, :cond_0

    invoke-static {p0, v4}, Lcom/mrkeyboard/app/MrBackdrop;->presetEnd(IZ)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKeyLook;->withHue2(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    .line 1211
    :cond_0
    aget v1, p2, v3

    iget v2, v0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrKeyLook;->lineFor(II)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKeyLook;->withLine(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    aput-object v0, p3, v3

    .line 1216
    :goto_0
    return-void

    .line 1213
    :cond_1
    aput p0, p2, v3

    .line 1214
    aget-object v0, p3, v3

    aget-object v1, p3, v3

    iget v1, v1, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrKeyLook;->lineFor(II)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKeyLook;->withLine(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    aput-object v0, p3, v3

    goto :goto_0
.end method

.method static chooseSuggested(I[I[Lcom/mrkeyboard/app/MrKeyLook;)V
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 1285
    aget-object v2, p2, v1

    .line 1286
    iget v0, v2, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    aget v3, p1, v1

    iget v4, v2, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    invoke-static {v3, v4}, Lcom/mrkeyboard/app/MrKeyLook;->lineFor(II)I

    move-result v3

    if-ne v0, v3, :cond_0

    const/4 v0, 0x1

    .line 1287
    :goto_0
    aget v3, p1, v1

    invoke-static {v3}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrBackdrop;->ownStyle(I)I

    move-result v3

    aput v3, p1, v1

    .line 1288
    invoke-virtual {v2, p0}, Lcom/mrkeyboard/app/MrKeyLook;->withHue(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v2

    .line 1289
    if-eqz v0, :cond_1

    invoke-virtual {v2, v1}, Lcom/mrkeyboard/app/MrKeyLook;->withLine(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    :goto_1
    aput-object v0, p2, v1

    .line 1290
    return-void

    :cond_0
    move v0, v1

    .line 1286
    goto :goto_0

    :cond_1
    move-object v0, v2

    .line 1289
    goto :goto_1
.end method

.method static colorOf(Lcom/mrkeyboard/app/MrKeyLook;I)I
    .locals 1

    .prologue
    .line 1373
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
    const/4 v0, 0x3

    if-ne p1, v0, :cond_2

    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    goto :goto_0

    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    goto :goto_0
.end method

.method private colourLine(IZI[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)Landroid/widget/LinearLayout;
    .locals 9

    .prologue
    .line 1331
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v7

    .line 1332
    const/16 v0, 0x10

    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 1333
    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_auto"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$28;

    move-object v1, p0

    move-object v2, p5

    move v3, p3

    move-object v4, p6

    move-object/from16 v5, p7

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemesActivity$28;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[Lcom/mrkeyboard/app/MrKeyLook;ILjava/lang/Runnable;[Ljava/lang/Runnable;)V

    invoke-virtual {v6, v8, p2, v0}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    .line 1340
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, -0x2

    const/4 v3, -0x2

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v7, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1341
    new-instance v0, Landroid/view/View;

    invoke-direct {v0, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v1, v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v7, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1342
    new-instance v8, Lcom/mrkeyboard/app/MrColorDot;

    invoke-direct {v8, p0, p1}, Lcom/mrkeyboard/app/MrColorDot;-><init>(Landroid/content/Context;I)V

    .line 1343
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_pick_color"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v8, v0}, Lcom/mrkeyboard/app/MrColorDot;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 1344
    const/4 v0, 0x1

    invoke-virtual {v8, v0}, Lcom/mrkeyboard/app/MrColorDot;->setClickable(Z)V

    .line 1345
    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$29;

    move-object v1, p0

    move v2, p3

    move-object v3, p4

    move-object v4, p5

    move-object v5, p6

    move-object/from16 v6, p7

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrThemesActivity$29;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    invoke-virtual {v8, v0}, Lcom/mrkeyboard/app/MrColorDot;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 1350
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

    invoke-virtual {v7, v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1351
    return-object v7
.end method

.method private faintBar(Landroid/widget/ScrollView;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 444
    const/high16 v0, 0x2000000

    invoke-virtual {p1, v0}, Landroid/widget/ScrollView;->setScrollBarStyle(I)V

    .line 445
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v1, 0x40400000    # 3.0f

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/widget/ScrollView;->setScrollBarSize(I)V

    .line 446
    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/widget/ScrollView;->setScrollbarFadingEnabled(Z)V

    .line 447
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v1, 0x59000000

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->text2:I

    const v3, 0xffffff

    and-int/2addr v2, v3

    or-int/2addr v1, v2

    const/high16 v2, 0x40000000    # 2.0f

    invoke-virtual {v0, v1, v4, v2, v4}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/ScrollView;->setVerticalScrollbarThumbDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 448
    :cond_0
    return-void
.end method

.method private fillKeys(Landroid/widget/LinearLayout;Z[II[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 18

    .prologue
    .line 1079
    invoke-virtual/range {p1 .. p1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 1080
    const/4 v1, 0x0

    aget v1, p5, v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v13

    .line 1082
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v10

    .line 1083
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    move-object/from16 v0, p1

    invoke-virtual {v0, v10, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1084
    const/4 v4, 0x0

    :goto_0
    const/4 v1, 0x3

    if-ge v4, v1, :cond_2

    .line 1086
    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->kindName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v12

    if-ne v4, v13, :cond_1

    const/4 v1, 0x1

    move v9, v1

    :goto_1
    const/high16 v14, 0x41200000    # 10.0f

    new-instance v1, Lcom/mrkeyboard/app/MrThemesActivity$22;

    move-object/from16 v2, p0

    move-object/from16 v3, p5

    move/from16 v5, p2

    move-object/from16 v6, p6

    move-object/from16 v7, p7

    move-object/from16 v8, p8

    invoke-direct/range {v1 .. v8}, Lcom/mrkeyboard/app/MrThemesActivity$22;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[IIZ[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    invoke-virtual {v11, v12, v9, v14, v1}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZFLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v1

    .line 1094
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, 0x0

    const/4 v5, -0x2

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-direct {v2, v3, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 1095
    if-lez v4, :cond_0

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41000000    # 8.0f

    invoke-virtual {v3, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-virtual {v2, v3, v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1096
    :cond_0
    invoke-virtual {v10, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1084
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 1086
    :cond_1
    const/4 v1, 0x0

    move v9, v1

    goto :goto_1

    .line 1099
    :cond_2
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v14

    .line 1100
    const/16 v1, 0x10

    invoke-virtual {v14, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 1101
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0xa

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    move-object/from16 v0, p1

    invoke-virtual {v0, v14, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1102
    new-instance v1, Landroid/widget/HorizontalScrollView;

    move-object/from16 v0, p0

    invoke-direct {v1, v0}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;)V

    .line 1103
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/HorizontalScrollView;->setHorizontalScrollBarEnabled(Z)V

    .line 1104
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v2

    .line 1105
    new-instance v3, Landroid/view/ViewGroup$LayoutParams;

    const/4 v4, -0x2

    const/4 v5, -0x2

    invoke-direct {v3, v4, v5}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v2, v3}, Landroid/widget/HorizontalScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1106
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, 0x0

    const/4 v5, -0x2

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-direct {v3, v4, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v14, v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1107
    const/4 v1, 0x0

    aget v1, p5, v1

    const/4 v3, 0x0

    aget-object v3, p6, v3

    move/from16 v0, p2

    invoke-static {v13, v0, v1, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->presetShown(IZILcom/mrkeyboard/app/MrKeyLook;)I

    move-result v12

    .line 1108
    invoke-static {v13}, Lcom/mrkeyboard/app/MrBackdrop;->ownStyle(I)I

    move-result v15

    .line 1112
    move-object/from16 v0, p3

    invoke-static {v13, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->offeredFor(I[I)[I

    move-result-object v16

    .line 1113
    const/4 v1, 0x0

    aget v1, p5, v1

    const/4 v3, 0x0

    aget-object v3, p6, v3

    move-object/from16 v0, v16

    invoke-static {v0, v15, v1, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->offeredShown([IIILcom/mrkeyboard/app/MrKeyLook;)I

    move-result v17

    .line 1114
    sget-object v1, Lcom/mrkeyboard/app/MrBackdrop;->KIND_FIRST:[I

    aget v3, v1, v13

    .line 1115
    move-object/from16 v0, v16

    array-length v1, v0

    if-eqz v1, :cond_3

    const/4 v1, 0x2

    if-ne v13, v1, :cond_5

    .line 1116
    :cond_3
    :goto_2
    sget-object v1, Lcom/mrkeyboard/app/MrBackdrop;->KIND_FIRST:[I

    add-int/lit8 v4, v13, 0x1

    aget v1, v1, v4

    if-ge v3, v1, :cond_6

    if-ne v3, v12, :cond_4

    const/4 v4, 0x1

    :goto_3
    move-object/from16 v1, p0

    move/from16 v5, p2

    move/from16 v6, p4

    move-object/from16 v7, p5

    move-object/from16 v8, p6

    move-object/from16 v9, p7

    move-object/from16 v10, p8

    invoke-direct/range {v1 .. v10}, Lcom/mrkeyboard/app/MrThemesActivity;->addPresetDot(Landroid/widget/LinearLayout;IZZI[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    :cond_4
    const/4 v4, 0x0

    goto :goto_3

    .line 1118
    :cond_5
    if-ne v12, v3, :cond_7

    const/4 v4, 0x1

    :goto_4
    move-object/from16 v1, p0

    move/from16 v5, p2

    move/from16 v6, p4

    move-object/from16 v7, p5

    move-object/from16 v8, p6

    move-object/from16 v9, p7

    move-object/from16 v10, p8

    invoke-direct/range {v1 .. v10}, Lcom/mrkeyboard/app/MrThemesActivity;->addPresetDot(Landroid/widget/LinearLayout;IZZI[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    .line 1119
    if-le v12, v3, :cond_6

    const/4 v4, 0x1

    move-object/from16 v1, p0

    move v3, v12

    move/from16 v5, p2

    move/from16 v6, p4

    move-object/from16 v7, p5

    move-object/from16 v8, p6

    move-object/from16 v9, p7

    move-object/from16 v10, p8

    invoke-direct/range {v1 .. v10}, Lcom/mrkeyboard/app/MrThemesActivity;->addPresetDot(Landroid/widget/LinearLayout;IZZI[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    .line 1121
    :cond_6
    const/4 v1, 0x0

    move v11, v1

    :goto_5
    move-object/from16 v0, v16

    array-length v1, v0

    if-ge v11, v1, :cond_b

    .line 1122
    if-nez v13, :cond_8

    move-object/from16 v0, v16

    array-length v1, v0

    add-int/lit8 v1, v1, -0x1

    if-ne v11, v1, :cond_8

    const/4 v1, 0x1

    .line 1123
    :goto_6
    aget v3, v16, v11

    if-eqz v1, :cond_9

    const/4 v1, 0x4

    move-object/from16 v0, p0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->styleName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v4

    :goto_7
    move/from16 v0, v17

    if-ne v11, v0, :cond_a

    const/4 v5, 0x1

    :goto_8
    move-object/from16 v1, p0

    move v6, v15

    move-object/from16 v7, p5

    move-object/from16 v8, p6

    move-object/from16 v9, p7

    move-object/from16 v10, p8

    invoke-direct/range {v1 .. v10}, Lcom/mrkeyboard/app/MrThemesActivity;->addSwatchDot(Landroid/widget/LinearLayout;ILjava/lang/String;ZI[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    .line 1121
    add-int/lit8 v1, v11, 0x1

    move v11, v1

    goto :goto_5

    .line 1118
    :cond_7
    const/4 v4, 0x0

    goto :goto_4

    .line 1122
    :cond_8
    const/4 v1, 0x0

    goto :goto_6

    .line 1123
    :cond_9
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_themes_from_background"

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " #"

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, "%06X"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    aget v7, v16, v11

    const v8, 0xffffff

    and-int/2addr v7, v8

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v5, v6

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto :goto_7

    :cond_a
    const/4 v5, 0x0

    goto :goto_8

    .line 1128
    :cond_b
    new-instance v1, Lcom/mrkeyboard/app/MrStyleDot;

    const/4 v2, 0x0

    aget v2, p5, v2

    if-ne v15, v2, :cond_d

    if-gez v12, :cond_d

    if-gez v17, :cond_d

    const/4 v4, 0x1

    :goto_9
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v2, Lcom/mrkeyboard/app/MrKit;->accent:I

    const/4 v2, 0x0

    aget-object v2, p6, v2

    iget v6, v2, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    const/4 v2, 0x0

    aget-object v2, p6, v2

    iget v7, v2, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    move-object/from16 v2, p0

    move v3, v15

    invoke-direct/range {v1 .. v7}, Lcom/mrkeyboard/app/MrStyleDot;-><init>(Landroid/content/Context;IZIII)V

    .line 1129
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_pick_color"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrStyleDot;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 1130
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrStyleDot;->setClickable(Z)V

    .line 1131
    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$23;

    move-object/from16 v3, p0

    move-object/from16 v4, p5

    move-object/from16 v5, p6

    move-object/from16 v6, p7

    move-object/from16 v7, p8

    invoke-direct/range {v2 .. v7}, Lcom/mrkeyboard/app/MrThemesActivity$23;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrStyleDot;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 1136
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x42200000    # 40.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x42200000    # 40.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-direct {v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 1137
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41400000    # 12.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1138
    invoke-virtual {v14, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1139
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    if-ltz v12, :cond_e

    move v1, v12

    :goto_a
    move-object/from16 v0, p0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->styleName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v1

    const/high16 v3, 0x41600000    # 14.0f

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v5, 0x0

    invoke-virtual {v2, v1, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 1140
    const/16 v2, 0x11

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 1141
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v3, 0x4

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    move-object/from16 v0, p1

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1142
    const/4 v1, 0x2

    if-ne v13, v1, :cond_c

    .line 1145
    const/4 v1, 0x0

    aget v1, p5, v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->isOwnStyle(I)Z

    move-result v13

    .line 1146
    if-eqz v13, :cond_10

    const/4 v1, 0x0

    aget-object v1, p6, v1

    iget v1, v1, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    if-eqz v1, :cond_f

    const/4 v1, 0x0

    aget-object v1, p6, v1

    iget v3, v1, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    .line 1147
    :goto_b
    if-eqz v13, :cond_12

    const/4 v1, 0x0

    aget-object v1, p6, v1

    iget v1, v1, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    if-eqz v1, :cond_11

    const/4 v1, 0x0

    aget-object v1, p6, v1

    iget v1, v1, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    move v12, v1

    .line 1148
    :goto_c
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_grad_start"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x1

    move-object/from16 v1, p0

    move/from16 v7, p2

    move-object/from16 v8, p5

    move-object/from16 v9, p6

    move-object/from16 v10, p7

    move-object/from16 v11, p8

    invoke-direct/range {v1 .. v11}, Lcom/mrkeyboard/app/MrThemesActivity;->gradientRow(Ljava/lang/String;IZZIZ[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)Landroid/widget/LinearLayout;

    move-result-object v1

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0xc

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    move-object/from16 v0, p1

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1149
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_grad_end"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/4 v4, 0x1

    if-eqz v13, :cond_13

    const/4 v1, 0x0

    aget-object v1, p6, v1

    iget v1, v1, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    if-nez v1, :cond_13

    const/4 v5, 0x1

    :goto_d
    const/4 v6, 0x2

    move-object/from16 v1, p0

    move v3, v12

    move/from16 v7, p2

    move-object/from16 v8, p5

    move-object/from16 v9, p6

    move-object/from16 v10, p7

    move-object/from16 v11, p8

    invoke-direct/range {v1 .. v11}, Lcom/mrkeyboard/app/MrThemesActivity;->gradientRow(Ljava/lang/String;IZZIZ[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)Landroid/widget/LinearLayout;

    move-result-object v1

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v3, 0x6

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    move-object/from16 v0, p1

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1151
    :cond_c
    return-void

    .line 1128
    :cond_d
    const/4 v4, 0x0

    goto/16 :goto_9

    .line 1139
    :cond_e
    const/4 v1, 0x0

    aget v1, p5, v1

    goto/16 :goto_a

    .line 1146
    :cond_f
    const v3, -0x908401

    goto/16 :goto_b

    :cond_10
    const/4 v1, 0x0

    aget v1, p5, v1

    move/from16 v0, p2

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrBackdrop;->presetColour(IZ)I

    move-result v3

    goto/16 :goto_b

    .line 1147
    :cond_11
    invoke-static {v3}, Lcom/mrkeyboard/app/MrKeyLook;->partner(I)I

    move-result v1

    move v12, v1

    goto/16 :goto_c

    :cond_12
    const/4 v1, 0x0

    aget v1, p5, v1

    move/from16 v0, p2

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrBackdrop;->presetEnd(IZ)I

    move-result v1

    move v12, v1

    goto/16 :goto_c

    .line 1149
    :cond_13
    const/4 v5, 0x0

    goto :goto_d
.end method

.method private fillLine(Landroid/widget/LinearLayout;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 9

    .prologue
    const/4 v8, 0x0

    .line 1310
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 1311
    aget-object v0, p3, v8

    iget v1, v0, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    aget-object v0, p3, v8

    iget v0, v0, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    if-nez v0, :cond_0

    const/4 v2, 0x1

    :goto_0
    const/4 v3, 0x3

    move-object v0, p0

    move-object v4, p2

    move-object v5, p3

    move-object v6, p4

    move-object v7, p5

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/MrThemesActivity;->colourLine(IZI[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v8}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1312
    return-void

    :cond_0
    move v2, v8

    .line 1311
    goto :goto_0
.end method

.method private fillRow(Landroid/widget/LinearLayout;I)V
    .locals 3

    .prologue
    .line 465
    if-nez p1, :cond_1

    .line 470
    :cond_0
    return-void

    .line 466
    :cond_1
    rem-int/lit8 v0, p2, 0x2

    :goto_0
    if-eqz v0, :cond_0

    const/4 v1, 0x2

    if-ge v0, v1, :cond_0

    .line 467
    new-instance v1, Landroid/view/View;

    invoke-direct {v1, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 468
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->cardParams(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {p1, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 466
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method private fillText(Landroid/widget/LinearLayout;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 8

    .prologue
    const/4 v3, 0x0

    .line 1316
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 1317
    aget-object v0, p3, v3

    iget v1, v0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    aget-object v0, p3, v3

    iget v0, v0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    if-nez v0, :cond_0

    const/4 v2, 0x1

    :goto_0
    move-object v0, p0

    move-object v4, p2

    move-object v5, p3

    move-object v6, p4

    move-object v7, p5

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/MrThemesActivity;->colourLine(IZI[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1318
    return-void

    :cond_0
    move v2, v3

    .line 1317
    goto :goto_0
.end method

.method private gradientRow(Ljava/lang/String;IZZIZ[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)Landroid/widget/LinearLayout;
    .locals 10

    .prologue
    .line 1158
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v8

    .line 1159
    const/16 v0, 0x10

    invoke-virtual {v8, v0}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 1160
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v1, 0x41600000    # 14.0f

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v3, 0x0

    invoke-virtual {v0, p1, v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, 0x0

    const/4 v3, -0x2

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v1, v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v8, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1161
    if-eqz p3, :cond_0

    .line 1162
    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_auto"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$24;

    move-object v1, p0

    move-object/from16 v2, p7

    move-object/from16 v3, p8

    move/from16 v4, p6

    move-object/from16 v5, p9

    move-object/from16 v6, p10

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrThemesActivity$24;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[I[Lcom/mrkeyboard/app/MrKeyLook;ZLjava/lang/Runnable;[Ljava/lang/Runnable;)V

    invoke-virtual {v7, v9, p4, v0}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v0

    .line 1170
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, -0x2

    const/4 v3, -0x2

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 1171
    const/4 v2, 0x0

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41200000    # 10.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    const/4 v5, 0x0

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1172
    invoke-virtual {v8, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1174
    :cond_0
    new-instance v9, Lcom/mrkeyboard/app/MrColorDot;

    invoke-direct {v9, p0, p2}, Lcom/mrkeyboard/app/MrColorDot;-><init>(Landroid/content/Context;I)V

    .line 1175
    invoke-virtual {v9, p1}, Lcom/mrkeyboard/app/MrColorDot;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 1176
    const/4 v0, 0x1

    invoke-virtual {v9, v0}, Lcom/mrkeyboard/app/MrColorDot;->setClickable(Z)V

    .line 1177
    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$25;

    move-object v1, p0

    move-object v2, p1

    move v3, p5

    move-object/from16 v4, p7

    move-object/from16 v5, p8

    move-object/from16 v6, p9

    move-object/from16 v7, p10

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/MrThemesActivity$25;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Ljava/lang/String;I[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    invoke-virtual {v9, v0}, Lcom/mrkeyboard/app/MrColorDot;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 1182
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

    invoke-virtual {v8, v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1183
    return-object v8
.end method

.method static kindName(Landroid/content/Context;I)Ljava/lang/String;
    .locals 2

    .prologue
    .line 674
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

    .line 675
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

    .line 578
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    if-eqz p2, :cond_1

    const-string v0, "mr_themes_in_use"

    :goto_0
    new-array v2, v5, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 579
    if-eqz p2, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    :goto_1
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 580
    if-eqz p2, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {v0, v1, v5, v6, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    :goto_2
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 581
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

    .line 582
    :cond_0
    return-void

    .line 578
    :cond_1
    const-string v0, "mr_themes_view"

    goto :goto_0

    .line 579
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->accent:I

    goto :goto_1

    .line 580
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

    .line 581
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v0, v0, Lcom/mrkeyboard/app/MrKit;->stroke:I

    goto :goto_3
.end method

.method private newDialog(Z)Landroid/app/Dialog;
    .locals 5

    .prologue
    const/4 v1, -0x1

    .line 782
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v2, "Theme.MrKeyboard.Dialog"

    const-string v3, "style"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 783
    new-instance v2, Landroid/app/Dialog;

    invoke-direct {v2, p0, v0}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V

    .line 784
    const/4 v0, 0x1

    invoke-virtual {v2, v0}, Landroid/app/Dialog;->requestWindowFeature(I)Z

    .line 785
    invoke-virtual {v2}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v3

    .line 786
    if-eqz v3, :cond_0

    .line 788
    new-instance v4, Landroid/graphics/drawable/ColorDrawable;

    if-eqz p1, :cond_1

    const/high16 v0, -0x1000000

    :goto_0
    invoke-direct {v4, v0}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v3, v4}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 789
    if-eqz p1, :cond_2

    move v0, v1

    :goto_1
    invoke-virtual {v3, v1, v0}, Landroid/view/Window;->setLayout(II)V

    .line 790
    if-nez p1, :cond_0

    const/16 v0, 0x50

    invoke-virtual {v3, v0}, Landroid/view/Window;->setGravity(I)V

    .line 792
    :cond_0
    return-object v2

    .line 788
    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    .line 789
    :cond_2
    const/4 v0, -0x2

    goto :goto_1
.end method

.method static offeredFor(I[I)[I
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 1256
    array-length v0, p1

    if-nez v0, :cond_1

    new-array p1, v2, [I

    .line 1261
    :cond_0
    :goto_0
    return-object p1

    .line 1257
    :cond_1
    if-nez p0, :cond_2

    invoke-static {p1}, Lcom/mrkeyboard/app/MrThemesActivity;->withDark([I)[I

    move-result-object p1

    goto :goto_0

    .line 1258
    :cond_2
    const/4 v0, 0x1

    if-eq p0, v0, :cond_0

    .line 1259
    const/4 v0, 0x2

    array-length v1, p1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    new-array v0, v0, [I

    .line 1260
    array-length v1, v0

    invoke-static {p1, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    move-object p1, v0

    .line 1261
    goto :goto_0
.end method

.method static offeredShown([IIILcom/mrkeyboard/app/MrKeyLook;)I
    .locals 5

    .prologue
    const v4, 0xffffff

    const/4 v1, -0x1

    .line 1274
    if-eq p2, p1, :cond_1

    move v0, v1

    .line 1276
    :cond_0
    :goto_0
    return v0

    .line 1275
    :cond_1
    const/4 v0, 0x0

    :goto_1
    array-length v2, p0

    if-ge v0, v2, :cond_2

    iget v2, p3, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    and-int/2addr v2, v4

    aget v3, p0, v0

    and-int/2addr v3, v4

    if-eq v2, v3, :cond_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_2
    move v0, v1

    .line 1276
    goto :goto_0
.end method

.method static ownFromPreset([I[Lcom/mrkeyboard/app/MrKeyLook;Z)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 1191
    aget v0, p0, v4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->isOwnStyle(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1198
    :goto_0
    return-void

    .line 1192
    :cond_0
    aget v1, p0, v4

    .line 1193
    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v2

    .line 1194
    aget-object v0, p1, v4

    invoke-static {v1, p2}, Lcom/mrkeyboard/app/MrBackdrop;->presetColour(IZ)I

    move-result v3

    invoke-virtual {v0, v3}, Lcom/mrkeyboard/app/MrKeyLook;->withHue(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    .line 1195
    const/4 v3, 0x2

    if-ne v2, v3, :cond_1

    invoke-static {v1, p2}, Lcom/mrkeyboard/app/MrBackdrop;->presetEnd(IZ)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKeyLook;->withHue2(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    .line 1196
    :cond_1
    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop;->ownStyle(I)I

    move-result v1

    aput v1, p0, v4

    .line 1197
    aput-object v0, p1, v4

    goto :goto_0
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
    .line 1552
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 1553
    const/16 v1, 0x1e

    if-lt p0, v1, :cond_0

    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.provider.action.PICK_IMAGES"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v2, "image/*"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1554
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

    .line 1555
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1556
    const-string v2, "android.intent.category.OPENABLE"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 1557
    const-string v2, "image/*"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 1558
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1559
    return-object v0
.end method

.method static presetShown(IZILcom/mrkeyboard/app/MrKeyLook;)I
    .locals 7

    .prologue
    const/4 v4, 0x0

    const/4 v0, -0x1

    const/high16 v6, -0x1000000

    const/4 v3, 0x1

    .line 1297
    if-eqz p1, :cond_0

    if-nez p2, :cond_2

    :cond_0
    invoke-static {p2}, Lcom/mrkeyboard/app/MrBackdrop;->isOwnStyle(I)Z

    move-result v1

    if-eqz v1, :cond_1

    move p2, v0

    .line 1305
    :cond_1
    :goto_0
    return p2

    .line 1298
    :cond_2
    invoke-static {p2}, Lcom/mrkeyboard/app/MrBackdrop;->isOwnStyle(I)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1299
    sget-object v1, Lcom/mrkeyboard/app/MrBackdrop;->KIND_FIRST:[I

    aget v1, v1, p0

    :goto_1
    sget-object v2, Lcom/mrkeyboard/app/MrBackdrop;->KIND_FIRST:[I

    add-int/lit8 v5, p0, 0x1

    aget v2, v2, v5

    if-ge v1, v2, :cond_8

    .line 1300
    if-nez v1, :cond_4

    .line 1299
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 1301
    :cond_4
    iget v2, p3, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    invoke-static {v1, v3}, Lcom/mrkeyboard/app/MrBackdrop;->presetColour(IZ)I

    move-result v5

    or-int/2addr v5, v6

    if-ne v2, v5, :cond_6

    move v2, v3

    .line 1302
    :goto_2
    const/4 v5, 0x2

    if-ne p0, v5, :cond_5

    if-eqz v2, :cond_7

    iget v2, p3, Lcom/mrkeyboard/app/MrKeyLook;->hue2:I

    invoke-static {v1, v3}, Lcom/mrkeyboard/app/MrBackdrop;->presetEnd(IZ)I

    move-result v5

    or-int/2addr v5, v6

    if-ne v2, v5, :cond_7

    move v2, v3

    .line 1303
    :cond_5
    :goto_3
    if-eqz v2, :cond_3

    move p2, v1

    goto :goto_0

    :cond_6
    move v2, v4

    .line 1301
    goto :goto_2

    :cond_7
    move v2, v4

    .line 1302
    goto :goto_3

    :cond_8
    move p2, v0

    .line 1305
    goto :goto_0
.end method

.method private revealRow(Landroid/view/View;I)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 330
    if-nez p1, :cond_0

    .line 340
    :goto_0
    return-void

    .line 331
    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result v0

    if-gtz v0, :cond_1

    if-lez p2, :cond_1

    .line 332
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    new-instance v1, Lcom/mrkeyboard/app/MrThemesActivity$4;

    invoke-direct {v1, p0, p1, p2}, Lcom/mrkeyboard/app/MrThemesActivity$4;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/view/View;I)V

    const-wide/16 v2, 0x28

    invoke-virtual {v0, v1, v2, v3}, Landroid/widget/ScrollView;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0

    .line 339
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
    .line 662
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

    .line 663
    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    const-string v0, ""

    goto :goto_0
.end method

.method private sheetBox(Ljava/lang/String;Z)Lcom/mrkeyboard/app/MrSheetBox;
    .locals 10

    .prologue
    const/high16 v4, 0x41a00000    # 20.0f

    const/high16 v9, 0x41900000    # 18.0f

    const/high16 v6, 0x41800000    # 16.0f

    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 823
    new-instance v0, Lcom/mrkeyboard/app/MrSheetBox;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->heightPixels:I

    int-to-float v1, v1

    const v2, 0x3f7ae148    # 0.98f

    mul-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x42c00000    # 96.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-direct {v0, p0, v1, v2}, Lcom/mrkeyboard/app/MrSheetBox;-><init>(Landroid/content/Context;II)V

    .line 824
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrSheetBox;->setPadding(IIII)V

    .line 825
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->solidBg()I

    move-result v2

    const/high16 v3, 0x41b00000    # 22.0f

    invoke-virtual {v1, v2, v7, v3, v7}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrSheetBox;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 826
    if-nez p2, :cond_0

    .line 827
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v1, p1, v6, v2, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrSheetBox;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 848
    :goto_0
    return-object v0

    .line 831
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 832
    const/16 v2, 0x10

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 833
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v2, p1, v6, v3, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, -0x2

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v3, v7, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 834
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "\u2715"

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v3, v6, v4, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    .line 835
    const/16 v3, 0x11

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setGravity(I)V

    .line 836
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4}, Lcom/mrkeyboard/app/MrKit;->solidBg()I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->faint:I

    const v6, 0x3ee66666    # 0.45f

    invoke-static {v4, v5, v6}, Lcom/mrkeyboard/app/MrThemesActivity;->towards(IIF)I

    move-result v4

    invoke-virtual {v3, v4, v7, v9, v8}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 837
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_themes_close"

    new-array v5, v7, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 838
    invoke-virtual {v2, v8}, Landroid/widget/TextView;->setClickable(Z)V

    .line 839
    new-instance v3, Lcom/mrkeyboard/app/MrThemesActivity$12;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrThemesActivity$12;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 844
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x42100000    # 36.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x42100000    # 36.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-direct {v3, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 845
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41400000    # 12.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v3, v4, v7, v7, v7}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 846
    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 847
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2, v7}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrSheetBox;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto/16 :goto_0
.end method

.method private sheetShow(Landroid/app/Dialog;Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrThemePreview;Landroid/widget/SeekBar;ZLjava/lang/Runnable;)V
    .locals 9

    .prologue
    .line 859
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 860
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0x12

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p2, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 861
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_cancel"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    new-instance v4, Lcom/mrkeyboard/app/MrThemesActivity$13;

    invoke-direct {v4, p0, p5}, Lcom/mrkeyboard/app/MrThemesActivity$13;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Z)V

    invoke-virtual {v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v1

    .line 867
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_themes_apply"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$14;

    invoke-direct {v5, p0, p6}, Lcom/mrkeyboard/app/MrThemesActivity$14;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Ljava/lang/Runnable;)V

    invoke-virtual {v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    .line 873
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, 0x0

    const/4 v5, -0x2

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-direct {v3, v4, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 874
    const/4 v4, 0x0

    const/4 v5, 0x0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x40c00000    # 6.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    const/4 v7, 0x0

    invoke-virtual {v3, v4, v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 875
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, 0x0

    const/4 v6, -0x2

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-direct {v4, v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 876
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x40c00000    # 6.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-virtual {v4, v5, v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 877
    invoke-virtual {v0, v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 878
    invoke-virtual {v0, v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 879
    invoke-virtual {p1, p2}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 880
    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$15;

    invoke-direct {v0, p0, p5}, Lcom/mrkeyboard/app/MrThemesActivity$15;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Z)V

    invoke-virtual {p1, v0}, Landroid/app/Dialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    .line 885
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialog:Landroid/app/Dialog;

    .line 886
    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogPreview:Lcom/mrkeyboard/app/MrThemePreview;

    .line 887
    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogSoft:Landroid/widget/SeekBar;

    .line 888
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCancel:Landroid/widget/TextView;

    .line 889
    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogApply:Landroid/widget/TextView;

    .line 890
    invoke-virtual {p1}, Landroid/app/Dialog;->show()V

    .line 891
    return-void
.end method

.method private side(I)Landroid/widget/LinearLayout$LayoutParams;
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 452
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x1

    const/4 v2, -0x2

    invoke-direct {v0, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 453
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    int-to-float v2, p1

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    invoke-virtual {v0, v4, v1, v2, v4}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 454
    return-object v0
.end method

.method private slider(Landroid/widget/LinearLayout;Ljava/lang/String;IIILcom/mrkeyboard/app/MrThemesActivity$Setter;)Landroid/widget/SeekBar;
    .locals 7

    .prologue
    const/4 v6, 0x0

    const/high16 v5, 0x41700000    # 15.0f

    const/4 v4, -0x2

    .line 1047
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 1048
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1, p5}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1049
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

    .line 1050
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

    .line 1051
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v4, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1052
    new-instance v0, Landroid/widget/SeekBar;

    invoke-direct {v0, p0}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    .line 1053
    invoke-virtual {v0, p3}, Landroid/widget/SeekBar;->setMax(I)V

    .line 1054
    invoke-virtual {v0, p4}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 1055
    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$21;

    invoke-direct {v2, p0, p3, v1, p6}, Lcom/mrkeyboard/app/MrThemesActivity$21;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;ILandroid/widget/TextView;Lcom/mrkeyboard/app/MrThemesActivity$Setter;)V

    invoke-virtual {v0, v2}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 1069
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1070
    return-object v0
.end method

.method static styleName(Landroid/content/Context;I)Ljava/lang/String;
    .locals 2

    .prologue
    .line 680
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

    .line 681
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

    .line 1715
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 1716
    const/16 v1, 0x140

    if-gt v0, v1, :cond_0

    .line 1718
    :goto_0
    return-object p0

    .line 1717
    :cond_0
    const/high16 v1, 0x43a00000    # 320.0f

    int-to-float v0, v0

    div-float v0, v1, v0

    .line 1718
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

.method static towards(IIF)I
    .locals 5

    .prologue
    .line 1019
    shr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    int-to-float v0, v0

    shr-int/lit8 v1, p1, 0x10

    and-int/lit16 v1, v1, 0xff

    shr-int/lit8 v2, p0, 0x10

    and-int/lit16 v2, v2, 0xff

    sub-int/2addr v1, v2

    int-to-float v1, v1

    mul-float/2addr v1, p2

    add-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 1020
    shr-int/lit8 v1, p0, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-float v1, v1

    shr-int/lit8 v2, p1, 0x8

    and-int/lit16 v2, v2, 0xff

    shr-int/lit8 v3, p0, 0x8

    and-int/lit16 v3, v3, 0xff

    sub-int/2addr v2, v3

    int-to-float v2, v2

    mul-float/2addr v2, p2

    add-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    .line 1021
    and-int/lit16 v2, p0, 0xff

    int-to-float v2, v2

    and-int/lit16 v3, p1, 0xff

    and-int/lit16 v4, p0, 0xff

    sub-int/2addr v3, v4

    int-to-float v3, v3

    mul-float/2addr v3, p2

    add-float/2addr v2, v3

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    .line 1022
    const/high16 v3, -0x1000000

    shl-int/lit8 v0, v0, 0x10

    or-int/2addr v0, v3

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    or-int/2addr v0, v2

    return v0
.end method

.method static withColor(Lcom/mrkeyboard/app/MrKeyLook;II)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 1

    .prologue
    .line 1359
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
    const/4 v0, 0x3

    if-ne p1, v0, :cond_2

    invoke-virtual {p0, p2}, Lcom/mrkeyboard/app/MrKeyLook;->withLine(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    goto :goto_0

    :cond_2
    invoke-virtual {p0, p2}, Lcom/mrkeyboard/app/MrKeyLook;->withHue2(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    goto :goto_0
.end method

.method static withDark([I)[I
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 1266
    array-length v0, p0

    add-int/lit8 v0, v0, 0x1

    new-array v0, v0, [I

    .line 1267
    array-length v1, p0

    invoke-static {p0, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1268
    array-length v1, p0

    aget v2, p0, v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrPalette;->dark(I)I

    move-result v2

    aput v2, v0, v1

    .line 1269
    return-object v0
.end method

.method static withPicked(Lcom/mrkeyboard/app/MrKeyLook;III)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 2

    .prologue
    .line 1367
    invoke-static {p0, p1, p3}, Lcom/mrkeyboard/app/MrThemesActivity;->withColor(Lcom/mrkeyboard/app/MrKeyLook;II)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    .line 1368
    const/4 v1, 0x1

    if-ne p1, v1, :cond_0

    invoke-static {p2, p3}, Lcom/mrkeyboard/app/MrKeyLook;->lineFor(II)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKeyLook;->withLine(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    :cond_0
    return-object v0
.end method


# virtual methods
.method applyBackdrop(Lcom/mrkeyboard/app/MrBackdrop$Spec;IILcom/mrkeyboard/app/MrKeyLook;Z)V
    .locals 8

    .prologue
    const/4 v7, 0x3

    const/4 v6, 0x0

    .line 754
    .line 755
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v7, :cond_1

    if-eqz p5, :cond_1

    .line 757
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->commitPending(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 758
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_image_failed"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    .line 777
    :goto_0
    return-void

    .line 761
    :cond_0
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->zoom:I

    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dx:I

    iget v2, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dy:I

    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->imageStamp(Landroid/content/Context;)J

    move-result-wide v4

    invoke-static {v0, v1, v2, v4, v5}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->image(IIIJ)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object p1

    .line 763
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    invoke-static {p1, p3}, Lcom/mrkeyboard/app/MrBackdrop;->themeTag(Lcom/mrkeyboard/app/MrBackdrop$Spec;I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrThemeColors;->indexOfTag([Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 764
    if-gez v0, :cond_2

    .line 765
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_image_failed"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 768
    :cond_2
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 769
    const-string v2, "pref_keyboard_layout"

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    array-length v3, v3

    if-ge v0, v3, :cond_6

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    aget-object v0, v3, v0

    :goto_1
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 770
    const-string v0, "pref_kbd_bg"

    invoke-virtual {p1}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->format()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 771
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v2, 0x4

    if-eq v0, v2, :cond_3

    const-string v0, "pref_kbd_bg_soft"

    const/16 v2, 0x46

    invoke-static {p2, v6, v2}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v2

    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 772
    :cond_3
    if-nez p4, :cond_4

    sget-object p4, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    :cond_4
    invoke-virtual {p4, v1}, Lcom/mrkeyboard/app/MrKeyLook;->write(Landroid/content/SharedPreferences$Editor;)V

    .line 773
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 774
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->readPrefs()V

    .line 775
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v7, :cond_5

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->loadImage()V

    .line 776
    :cond_5
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->galleryChanged()V

    goto :goto_0

    .line 769
    :cond_6
    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 165
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 166
    return-void
.end method

.method bigImage(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Landroid/graphics/Bitmap;
    .locals 2

    .prologue
    .line 615
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 623
    :goto_0
    return-object v0

    .line 616
    :cond_0
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_3

    .line 617
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigScene:Landroid/graphics/Bitmap;

    if-eqz v0, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigSceneIndex:I

    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    if-eq v0, v1, :cond_2

    .line 618
    :cond_1
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrScenes;->load(Landroid/content/Context;I)Landroid/graphics/Bitmap;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigScene:Landroid/graphics/Bitmap;

    .line 619
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigSceneIndex:I

    .line 621
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigScene:Landroid/graphics/Bitmap;

    goto :goto_0

    .line 623
    :cond_3
    const/4 v0, 0x0

    goto :goto_0
.end method

.method buildMore(I)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 396
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabLoad:I

    if-ne p1, v0, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 419
    :cond_0
    :goto_0
    return-void

    .line 397
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    add-int/lit8 v1, v1, 0x3

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 398
    :goto_1
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    if-ge v0, v1, :cond_2

    .line 399
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->addCard(Lcom/mrkeyboard/app/MrThemesActivity$Card;I)V

    .line 400
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    goto :goto_1

    .line 402
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ge v0, v1, :cond_3

    .line 403
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    new-instance v1, Lcom/mrkeyboard/app/MrThemesActivity$5;

    invoke-direct {v1, p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity$5;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    .line 410
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRow:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->fillRow(Landroid/widget/LinearLayout;I)V

    .line 411
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    const/16 v1, 0x9

    if-ne v0, v1, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->hasImage(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 412
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

    .line 417
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
    .line 643
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->backgroundName(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;

    move-result-object v0

    .line 644
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

    .line 344
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 345
    if-nez p1, :cond_1

    move v0, v1

    .line 346
    :goto_0
    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mListed:I

    if-ge v0, v2, :cond_4

    .line 347
    new-instance v4, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    array-length v2, v2

    if-ge v0, v2, :cond_0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    aget-object v2, v2, v0

    :goto_1
    invoke-direct {v4, v1, v0, v7, v2}, Lcom/mrkeyboard/app/MrThemesActivity$Card;-><init>(IILcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;)V

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 346
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 347
    :cond_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    aget-object v2, v2, v0

    goto :goto_1

    .line 349
    :cond_1
    if-ne p1, v9, :cond_2

    move v0, v1

    .line 350
    :goto_2
    sget-object v2, Lcom/mrkeyboard/app/MrBackdrop;->COLORS:[I

    array-length v2, v2

    if-ge v0, v2, :cond_4

    .line 351
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

    .line 350
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 353
    :cond_2
    if-ne p1, v6, :cond_3

    move v0, v1

    .line 354
    :goto_3
    sget v2, Lcom/mrkeyboard/app/MrBackdrop;->GRADIENT_COUNT:I

    if-ge v0, v2, :cond_4

    .line 355
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

    .line 354
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 357
    :cond_3
    const/16 v0, 0x9

    if-ne p1, v0, :cond_5

    .line 358
    new-instance v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_themes_photo"

    new-array v5, v1, [Ljava/lang/Object;

    invoke-virtual {v2, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v6, v1, v7, v2}, Lcom/mrkeyboard/app/MrThemesActivity$Card;-><init>(IILcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;)V

    invoke-interface {v3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 359
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

    .line 367
    :cond_4
    return-object v3

    .line 361
    :cond_5
    add-int/lit8 v0, p1, -0x3

    .line 362
    :goto_4
    const/4 v2, 0x6

    if-ge v1, v2, :cond_4

    .line 363
    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrScenes;->scene(II)I

    move-result v2

    .line 364
    new-instance v4, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->scene(I)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v5

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->sceneName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v9, v2, v5, v6}, Lcom/mrkeyboard/app/MrThemesActivity$Card;-><init>(IILcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;)V

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 362
    add-int/lit8 v1, v1, 0x1

    goto :goto_4
.end method

.method choicePosition()I
    .locals 5

    .prologue
    const/4 v2, -0x1

    .line 300
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    if-nez v0, :cond_1

    move v1, v2

    .line 309
    :cond_0
    :goto_0
    return v1

    .line 301
    :cond_1
    const/4 v0, 0x0

    move v1, v0

    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_4

    .line 302
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    .line 303
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v3, v3, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-nez v3, :cond_3

    .line 304
    iget v3, v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;->kind:I

    if-nez v3, :cond_2

    iget v0, v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;->index:I

    iget v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    if-eq v0, v3, :cond_0

    .line 301
    :cond_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 305
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

    .line 309
    goto :goto_0
.end method

.method chooseTheme(I)V
    .locals 3

    .prologue
    .line 701
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

    .line 702
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->readPrefs()V

    .line 703
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    .line 704
    return-void

    .line 701
    :cond_0
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method closeDialog()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 796
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialog:Landroid/app/Dialog;

    .line 797
    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialog:Landroid/app/Dialog;

    .line 798
    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogPreview:Lcom/mrkeyboard/app/MrThemePreview;

    .line 799
    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCrop:Lcom/mrkeyboard/app/MrCropView;

    .line 800
    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogSoft:Landroid/widget/SeekBar;

    .line 801
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogPale:Z

    .line 802
    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogNext:Landroid/widget/TextView;

    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCancel:Landroid/widget/TextView;

    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogApply:Landroid/widget/TextView;

    .line 803
    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogLook:[Lcom/mrkeyboard/app/MrKeyLook;

    .line 804
    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogStyle:[I

    .line 805
    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogText:Landroid/widget/LinearLayout;

    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogLine:Landroid/widget/LinearLayout;

    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogKeys:Landroid/widget/LinearLayout;

    .line 806
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closePicker()V

    .line 807
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V

    .line 808
    :cond_0
    return-void
.end method

.method closePicker()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 812
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPicker:Landroid/app/Dialog;

    .line 813
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPicker:Landroid/app/Dialog;

    .line 814
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerView:Lcom/mrkeyboard/app/MrColorPicker;

    .line 815
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerOpacity:Lcom/mrkeyboard/app/MrOpacityBar;

    .line 816
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerOpacityValue:Landroid/widget/TextView;

    .line 817
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerCancel:Landroid/widget/TextView;

    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerOk:Landroid/widget/TextView;

    .line 818
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V

    .line 819
    :cond_0
    return-void
.end method

.method detail()Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 652
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_theme_one"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 657
    :cond_0
    :goto_0
    return-object v0

    .line 653
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->tabOfChoice()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->tabName(I)Ljava/lang/String;

    move-result-object v0

    .line 654
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->hasStyles(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 655
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

    .line 1628
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    if-nez v0, :cond_0

    .line 1631
    :goto_0
    return-void

    .line 1629
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 1630
    :goto_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    invoke-virtual {p0, v0, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->startSoft(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)I

    move-result v2

    invoke-virtual {p0, v1, v0, v2, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->showCrop(Landroid/graphics/Bitmap;Lcom/mrkeyboard/app/MrBackdrop$Spec;IZ)V

    goto :goto_0

    .line 1629
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

    .line 638
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    .line 639
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    if-ne v0, v1, :cond_0

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->showTab(I)V

    .line 640
    :cond_0
    return-void
.end method

.method imported(Landroid/graphics/Bitmap;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 1614
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1615
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->discardPending(Landroid/content/Context;)V

    .line 1624
    :goto_0
    return-void

    .line 1618
    :cond_0
    if-nez p1, :cond_1

    .line 1619
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->discardPending(Landroid/content/Context;)V

    .line 1620
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_image_failed"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 1623
    :cond_1
    const/16 v0, 0x64

    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->pendingStamp(Landroid/content/Context;)J

    move-result-wide v2

    invoke-static {v0, v4, v4, v2, v3}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->image(IIIJ)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    const/16 v1, 0x19

    const/4 v2, 0x1

    invoke-virtual {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->showCrop(Landroid/graphics/Bitmap;Lcom/mrkeyboard/app/MrBackdrop$Spec;IZ)V

    goto :goto_0
.end method

.method inUse(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 721
    if-nez p2, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v1, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v1, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    iget v2, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eq v1, v2, :cond_1

    .line 722
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

    .line 1648
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->hasImage(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1649
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 1650
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 1668
    :goto_0
    return-void

    .line 1653
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    .line 1654
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$40;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$40;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 1667
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method loadScenes(I)V
    .locals 5

    .prologue
    .line 1675
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 1676
    const/4 v0, 0x0

    :goto_0
    const/4 v2, 0x6

    if-ge v0, v2, :cond_1

    .line 1677
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrScenes;->scene(II)I

    move-result v2

    .line 1678
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScenes:[Landroid/graphics/Bitmap;

    aget-object v3, v3, v2

    if-nez v3, :cond_0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSceneBusy:[Z

    aget-boolean v3, v3, v2

    if-nez v3, :cond_0

    .line 1679
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSceneBusy:[Z

    const/4 v4, 0x1

    aput-boolean v4, v3, v2

    .line 1680
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1676
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1683
    :cond_1
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1698
    :goto_1
    return-void

    .line 1684
    :cond_2
    new-instance v0, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$41;

    invoke-direct {v2, p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity$41;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Ljava/util/List;)V

    invoke-direct {v0, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 1697
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    goto :goto_1
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 3

    .prologue
    .line 1579
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 1580
    const/16 v0, 0x47

    if-ne p1, v0, :cond_0

    const/4 v0, -0x1

    if-ne p2, v0, :cond_0

    if-nez p3, :cond_1

    .line 1610
    :cond_0
    :goto_0
    return-void

    .line 1581
    :cond_1
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    .line 1582
    if-eqz v0, :cond_0

    .line 1584
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$39;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$39;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/net/Uri;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 1609
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

    .line 170
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 171
    new-instance v0, Lcom/mrkeyboard/app/MrKit;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrKit;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 172
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    .line 173
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->tags(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    .line 174
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->names(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    .line 175
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->values(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    .line 176
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrThemeColors;->listed([Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mListed:I

    .line 177
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->readPrefs()V

    .line 179
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v2

    .line 180
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->bg:I

    const/4 v4, 0x0

    invoke-virtual {v0, v3, v1, v4, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 182
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-virtual {v0, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41800000    # 16.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v2, v0, v3, v1, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 183
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

    .line 187
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->side(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 183
    invoke-virtual {v2, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 191
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 192
    const/16 v3, 0x10

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 193
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

    .line 194
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

    .line 196
    invoke-virtual {v0, v13}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 197
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_themes_current"

    new-array v5, v1, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 198
    new-instance v3, Lcom/mrkeyboard/app/MrThemesActivity$2;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrThemesActivity$2;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;)V

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 203
    new-instance v3, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    .line 204
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const v5, 0x3fa66666    # 1.3f

    invoke-direct {v4, v1, v10, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 205
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v3

    .line 206
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4, v12}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v3, v4, v1, v1, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 207
    const/16 v4, 0x10

    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 208
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

    .line 209
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

    .line 210
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {v5, v6, v1, v11, v1}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 211
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v5, v10, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 212
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, ""

    const/high16 v6, 0x41880000    # 17.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v4, v5, v6, v7, v13}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    .line 213
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    const/4 v5, 0x2

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 214
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v6, 0x8

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 215
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, ""

    const/high16 v6, 0x41500000    # 13.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v4, v5, v6, v7, v1}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDetail:Landroid/widget/TextView;

    .line 216
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDetail:Landroid/widget/TextView;

    const/4 v5, 0x3

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 217
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDetail:Landroid/widget/TextView;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v6, 0x4

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 218
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v4, v1, v10, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 219
    const/16 v3, 0xc

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->side(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 222
    new-instance v0, Landroid/widget/HorizontalScrollView;

    invoke-direct {v0, p0}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    .line 223
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    invoke-virtual {v0, v1}, Landroid/widget/HorizontalScrollView;->setHorizontalScrollBarEnabled(Z)V

    .line 224
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v3

    move v0, v1

    .line 225
    :goto_0
    const/16 v4, 0xa

    if-ge v0, v4, :cond_1

    .line 227
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->tabName(I)Ljava/lang/String;

    move-result-object v5

    const/high16 v6, 0x41700000    # 15.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v4, v5, v6, v7, v1}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    .line 228
    const/16 v5, 0x11

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setGravity(I)V

    .line 229
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

    .line 230
    invoke-virtual {v4, v13}, Landroid/widget/TextView;->setClickable(Z)V

    .line 231
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$3;

    invoke-direct {v5, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$3;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 236
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v5, v10, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 237
    if-lez v0, :cond_0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x40c00000    # 6.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-virtual {v5, v6, v1, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 238
    :cond_0
    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 239
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    invoke-interface {v5, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 225
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 241
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    new-instance v4, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v4, v10, v10}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v3, v4}, Landroid/widget/HorizontalScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 242
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    const/16 v3, 0xe

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->side(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 246
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    .line 247
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41a00000    # 20.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v0, v1, v1, v3, v1}, Landroid/widget/ScrollView;->setPadding(IIII)V

    .line 248
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setClipToPadding(Z)V

    .line 249
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->faintBar(Landroid/widget/ScrollView;)V

    .line 250
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    .line 251
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41c00000    # 24.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v0, v1, v1, v1, v3}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 252
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    new-instance v4, Landroid/view/ViewGroup$LayoutParams;

    const/4 v5, -0x1

    invoke-direct {v4, v5, v10}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v3, v4}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 253
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x1

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v0, v3, v1, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 254
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41400000    # 12.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v0, v1, v3, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 255
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v2, v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 257
    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->setContentView(Landroid/view/View;)V

    .line 258
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    .line 259
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->tabOfChoice()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->showTab(I)V

    .line 260
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->loadImage()V

    .line 261
    return-void
.end method

.method protected onDestroy()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 265
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    .line 266
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabLoad:I

    .line 267
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closeDialog()V

    .line 269
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->discardPending(Landroid/content/Context;)V

    .line 270
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 271
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 272
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBigScene:Landroid/graphics/Bitmap;

    .line 273
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 274
    return-void
.end method

.method openBackdrop(Lcom/mrkeyboard/app/MrBackdrop$Spec;)V
    .locals 3

    .prologue
    .line 708
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    .line 709
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->editImage()V

    .line 713
    :goto_0
    return-void

    .line 712
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

    .line 1563
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrThemesActivity;->pickers(I)Ljava/util/List;

    move-result-object v3

    move v1, v2

    .line 1564
    :goto_0
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    .line 1566
    :try_start_0
    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/Intent;

    const/16 v4, 0x47

    invoke-virtual {p0, v0, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1575
    :goto_1
    return-void

    .line 1570
    :catch_0
    move-exception v0

    .line 1564
    :goto_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 1574
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_image_failed"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v1, v3, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_1

    .line 1568
    :catch_1
    move-exception v0

    goto :goto_2
.end method

.method readPrefs()V
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 588
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mValues:[Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    const-string v3, "pref_keyboard_layout"

    const-string v4, "0"

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrThemeColors;->indexOf([Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    .line 590
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

    .line 591
    :goto_0
    if-eqz v2, :cond_1

    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    :goto_1
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 592
    if-eqz v2, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTheme:I

    aget-object v0, v0, v1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->styleOf(Ljava/lang/String;)I

    move-result v0

    :goto_2
    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStyle:I

    .line 593
    if-eqz v2, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeyLook;->read(Landroid/content/SharedPreferences;)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    :goto_3
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 594
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->soft(Landroid/content/Context;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    .line 595
    return-void

    :cond_0
    move v2, v1

    .line 590
    goto :goto_0

    .line 591
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    goto :goto_1

    :cond_2
    move v0, v1

    .line 592
    goto :goto_2

    .line 593
    :cond_3
    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    goto :goto_3
.end method

.method refresh()V
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 628
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->tag()Ljava/lang/String;

    move-result-object v1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->bigImage(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Landroid/graphics/Bitmap;

    move-result-object v4

    iget v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    invoke-virtual {v0, v1, v3, v4, v5}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 629
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBig:Lcom/mrkeyboard/app/MrThemePreview;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->setLook(Lcom/mrkeyboard/app/MrKeyLook;)V

    .line 630
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCaption:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->caption()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 631
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDetail:Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->detail()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    move v1, v2

    .line 632
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

    .line 633
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

    .line 634
    :cond_1
    return-void
.end method

.method removeImage()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 1634
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->removeImage(Landroid/content/Context;)V

    .line 1635
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    .line 1637
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

    .line 1639
    :cond_0
    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 1640
    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 1641
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    .line 1642
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->readPrefs()V

    .line 1643
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->galleryChanged()V

    .line 1644
    return-void

    .line 1637
    :cond_1
    const-string v0, "0"

    goto :goto_0
.end method

.method sceneLoaded(ILandroid/graphics/Bitmap;)V
    .locals 5

    .prologue
    const/4 v3, 0x0

    .line 1702
    if-ltz p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScenes:[Landroid/graphics/Bitmap;

    array-length v0, v0

    if-lt p1, v0, :cond_1

    .line 1711
    :cond_0
    return-void

    .line 1703
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScenes:[Landroid/graphics/Bitmap;

    aput-object p2, v0, p1

    .line 1704
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSceneBusy:[Z

    aput-boolean v3, v0, p1

    move v2, v3

    .line 1705
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v2, v0, :cond_0

    .line 1706
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 1707
    iget v1, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v4, 0x2

    if-ne v1, v4, :cond_2

    iget v1, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    if-ne v1, p1, :cond_2

    .line 1708
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->themeTag(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4, v0, p2, v3}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 1705
    :cond_2
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0
.end method

.method showChoice()V
    .locals 3

    .prologue
    .line 317
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->tabOfChoice()I

    move-result v0

    .line 318
    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    if-ne v0, v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    if-nez v1, :cond_1

    :cond_0
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->showTab(I)V

    .line 319
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->choicePosition()I

    move-result v1

    .line 320
    if-gez v1, :cond_2

    .line 326
    :goto_0
    return-void

    .line 321
    :cond_2
    :goto_1
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    if-gt v0, v1, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-ge v0, v2, :cond_3

    .line 322
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrThemesActivity$Card;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->addCard(Lcom/mrkeyboard/app/MrThemesActivity$Card;I)V

    .line 323
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    goto :goto_1

    .line 325
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    div-int/lit8 v1, v1, 0x2

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->revealRow(Landroid/view/View;I)V

    goto :goto_0
.end method

.method showColorPicker(Ljava/lang/String;I[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 29

    .prologue
    .line 1383
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closePicker()V

    .line 1384
    const/4 v2, 0x0

    aget-object v18, p4, v2

    .line 1385
    const/4 v2, 0x0

    aget v20, p3, v2

    .line 1386
    move-object/from16 v0, p0

    iget-boolean v8, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogPale:Z

    .line 1387
    move-object/from16 v0, v18

    move/from16 v1, p2

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->colorOf(Lcom/mrkeyboard/app/MrKeyLook;I)I

    move-result v2

    .line 1388
    const/4 v3, 0x1

    move/from16 v0, p2

    if-ne v0, v3, :cond_3

    const/4 v3, 0x0

    aget v3, p3, v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrBackdrop;->isOwnStyle(I)Z

    move-result v3

    if-nez v3, :cond_3

    .line 1390
    const/4 v2, 0x0

    aget v2, p3, v2

    invoke-static {v2, v8}, Lcom/mrkeyboard/app/MrBackdrop;->presetColour(IZ)I

    move-result v2

    move v11, v2

    .line 1402
    :goto_0
    const/4 v2, 0x0

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->newDialog(Z)Landroid/app/Dialog;

    move-result-object v27

    .line 1403
    invoke-virtual/range {v27 .. v27}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    .line 1405
    if-eqz v2, :cond_0

    const/4 v3, 0x2

    invoke-virtual {v2, v3}, Landroid/view/Window;->clearFlags(I)V

    .line 1406
    :cond_0
    const/4 v2, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->sheetBox(Ljava/lang/String;Z)Lcom/mrkeyboard/app/MrSheetBox;

    move-result-object v28

    .line 1407
    new-instance v24, Lcom/mrkeyboard/app/MrColorPicker;

    move-object/from16 v0, v24

    move-object/from16 v1, p0

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrColorPicker;-><init>(Landroid/content/Context;)V

    .line 1408
    move-object/from16 v0, v24

    invoke-virtual {v0, v11}, Lcom/mrkeyboard/app/MrColorPicker;->setColor(I)V

    .line 1410
    const/4 v2, 0x1

    move/from16 v0, p2

    if-eq v0, v2, :cond_1

    const/4 v2, 0x3

    move/from16 v0, p2

    if-ne v0, v2, :cond_c

    :cond_1
    const/4 v2, 0x1

    move/from16 v23, v2

    .line 1411
    :goto_1
    if-eqz v23, :cond_d

    new-instance v9, Lcom/mrkeyboard/app/MrOpacityBar;

    const/16 v2, 0xfa

    const/16 v3, 0x64

    move-object/from16 v0, p0

    invoke-direct {v9, v0, v2, v3}, Lcom/mrkeyboard/app/MrOpacityBar;-><init>(Landroid/content/Context;II)V

    .line 1412
    :goto_2
    if-eqz v23, :cond_e

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    const/high16 v4, 0x41700000    # 15.0f

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v14

    .line 1413
    :goto_3
    const/4 v2, 0x1

    new-array v4, v2, [Z

    const/4 v2, 0x0

    const/4 v3, 0x0

    aput-boolean v3, v4, v2

    .line 1414
    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$30;

    move-object/from16 v3, p0

    move/from16 v5, p2

    move-object/from16 v6, p3

    move-object/from16 v7, p4

    move-object/from16 v10, p5

    invoke-direct/range {v2 .. v10}, Lcom/mrkeyboard/app/MrThemesActivity$30;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[ZI[I[Lcom/mrkeyboard/app/MrKeyLook;ZLcom/mrkeyboard/app/MrOpacityBar;Ljava/lang/Runnable;)V

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Lcom/mrkeyboard/app/MrColorPicker;->setListener(Lcom/mrkeyboard/app/MrColorPicker$Listener;)V

    .line 1424
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0x10

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    move-object/from16 v0, v28

    move-object/from16 v1, v24

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1425
    if-eqz v23, :cond_2

    .line 1426
    const/4 v2, 0x1

    move/from16 v0, p2

    if-ne v0, v2, :cond_f

    move-object/from16 v0, v18

    iget v2, v0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    .line 1427
    :goto_4
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v5

    .line 1428
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v3, 0x1

    move/from16 v0, p2

    if-ne v0, v3, :cond_10

    const-string v3, "mr_themes_key_opacity"

    :goto_5
    const/4 v10, 0x0

    new-array v10, v10, [Ljava/lang/Object;

    invoke-virtual {v7, v3, v10}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/high16 v7, 0x41600000    # 14.0f

    move-object/from16 v0, p0

    iget-object v10, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v10, v10, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v12, 0x0

    invoke-virtual {v6, v3, v7, v10, v12}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v3

    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v7, 0x0

    const/4 v10, -0x2

    const/high16 v12, 0x3f800000    # 1.0f

    invoke-direct {v6, v7, v10, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v5, v3, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1430
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "%"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v14, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1431
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x2

    const/4 v7, -0x2

    invoke-direct {v3, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v14, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1432
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v6, 0xe

    invoke-virtual {v3, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    move-object/from16 v0, v28

    invoke-virtual {v0, v5, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1433
    invoke-virtual {v9, v11}, Lcom/mrkeyboard/app/MrOpacityBar;->setColor(I)V

    .line 1434
    invoke-virtual {v9, v2}, Lcom/mrkeyboard/app/MrOpacityBar;->setValue(I)V

    .line 1435
    new-instance v10, Lcom/mrkeyboard/app/MrThemesActivity$31;

    move-object/from16 v11, p0

    move-object/from16 v12, p4

    move/from16 v13, p2

    move-object/from16 v15, p5

    invoke-direct/range {v10 .. v15}, Lcom/mrkeyboard/app/MrThemesActivity$31;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[Lcom/mrkeyboard/app/MrKeyLook;ILandroid/widget/TextView;Ljava/lang/Runnable;)V

    invoke-virtual {v9, v10}, Lcom/mrkeyboard/app/MrOpacityBar;->setListener(Lcom/mrkeyboard/app/MrOpacityBar$Listener;)V

    .line 1442
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x1

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41f00000    # 30.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-direct {v2, v3, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    move-object/from16 v0, v28

    invoke-virtual {v0, v9, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1444
    :cond_2
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v2

    .line 1445
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v5, 0x12

    invoke-virtual {v3, v5}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    move-object/from16 v0, v28

    invoke-virtual {v0, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1446
    new-instance v15, Lcom/mrkeyboard/app/MrThemesActivity$32;

    move-object/from16 v16, p0

    move-object/from16 v17, p4

    move-object/from16 v19, p3

    move-object/from16 v21, p5

    move-object/from16 v22, p6

    invoke-direct/range {v15 .. v22}, Lcom/mrkeyboard/app/MrThemesActivity$32;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[Lcom/mrkeyboard/app/MrKeyLook;Lcom/mrkeyboard/app/MrKeyLook;[IILjava/lang/Runnable;[Ljava/lang/Runnable;)V

    .line 1455
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_themes_cancel"

    const/4 v7, 0x0

    new-array v7, v7, [Ljava/lang/Object;

    invoke-virtual {v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    new-instance v7, Lcom/mrkeyboard/app/MrThemesActivity$33;

    move-object/from16 v0, p0

    invoke-direct {v7, v0, v15}, Lcom/mrkeyboard/app/MrThemesActivity$33;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Ljava/lang/Runnable;)V

    invoke-virtual {v3, v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v3

    .line 1460
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v7, "mr_themes_done"

    const/4 v10, 0x0

    new-array v10, v10, [Ljava/lang/Object;

    invoke-virtual {v6, v7, v10}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    const/4 v7, 0x1

    new-instance v16, Lcom/mrkeyboard/app/MrThemesActivity$34;

    move-object/from16 v17, p0

    move-object/from16 v18, v4

    move/from16 v19, v23

    move/from16 v20, p2

    move-object/from16 v21, p3

    move-object/from16 v22, p4

    move/from16 v23, v8

    move-object/from16 v25, p5

    move-object/from16 v26, p6

    invoke-direct/range {v16 .. v26}, Lcom/mrkeyboard/app/MrThemesActivity$34;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[ZZI[I[Lcom/mrkeyboard/app/MrKeyLook;ZLcom/mrkeyboard/app/MrColorPicker;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    move-object/from16 v0, v16

    invoke-virtual {v5, v6, v7, v0}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v4

    .line 1472
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, 0x0

    const/4 v7, -0x2

    const/high16 v8, 0x3f800000    # 1.0f

    invoke-direct {v5, v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 1473
    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v10, 0x40c00000    # 6.0f

    invoke-virtual {v8, v10}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v8

    const/4 v10, 0x0

    invoke-virtual {v5, v6, v7, v8, v10}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1474
    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v7, 0x0

    const/4 v8, -0x2

    const/high16 v10, 0x3f800000    # 1.0f

    invoke-direct {v6, v7, v8, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 1475
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v8, 0x40c00000    # 6.0f

    invoke-virtual {v7, v8}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v7

    const/4 v8, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-virtual {v6, v7, v8, v10, v11}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1476
    invoke-virtual {v2, v3, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1477
    invoke-virtual {v2, v4, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1478
    invoke-virtual/range {v27 .. v28}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 1479
    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$35;

    move-object/from16 v0, p0

    move-object/from16 v1, v27

    invoke-direct {v2, v0, v1, v15}, Lcom/mrkeyboard/app/MrThemesActivity$35;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/app/Dialog;Ljava/lang/Runnable;)V

    move-object/from16 v0, v27

    invoke-virtual {v0, v2}, Landroid/app/Dialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    .line 1484
    move-object/from16 v0, v27

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/mrkeyboard/app/MrThemesActivity;->mPicker:Landroid/app/Dialog;

    .line 1485
    move-object/from16 v0, v24

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerView:Lcom/mrkeyboard/app/MrColorPicker;

    .line 1486
    move-object/from16 v0, p0

    iput-object v9, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerOpacity:Lcom/mrkeyboard/app/MrOpacityBar;

    .line 1487
    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerOpacityValue:Landroid/widget/TextView;

    .line 1488
    move-object/from16 v0, p0

    iput-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerOk:Landroid/widget/TextView;

    .line 1489
    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mPickerCancel:Landroid/widget/TextView;

    .line 1490
    invoke-virtual/range {v27 .. v27}, Landroid/app/Dialog;->show()V

    .line 1491
    return-void

    .line 1391
    :cond_3
    const/4 v3, 0x2

    move/from16 v0, p2

    if-ne v0, v3, :cond_4

    const/4 v3, 0x0

    aget v3, p3, v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrBackdrop;->isOwnStyle(I)Z

    move-result v3

    if-nez v3, :cond_4

    .line 1392
    const/4 v2, 0x0

    aget v2, p3, v2

    invoke-static {v2, v8}, Lcom/mrkeyboard/app/MrBackdrop;->presetEnd(IZ)I

    move-result v2

    move v11, v2

    goto/16 :goto_0

    .line 1393
    :cond_4
    if-nez v2, :cond_11

    .line 1394
    if-nez p2, :cond_6

    if-eqz v8, :cond_5

    const v2, -0xdfdedc

    :goto_6
    move v11, v2

    goto/16 :goto_0

    :cond_5
    const/4 v2, -0x1

    goto :goto_6

    .line 1395
    :cond_6
    const/4 v2, 0x1

    move/from16 v0, p2

    if-ne v0, v2, :cond_7

    const v2, -0x908401

    move v11, v2

    goto/16 :goto_0

    .line 1396
    :cond_7
    const/4 v2, 0x3

    move/from16 v0, p2

    if-ne v0, v2, :cond_a

    .line 1398
    const/4 v2, 0x0

    aget v2, p3, v2

    move-object/from16 v0, v18

    iget v3, v0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrKeyLook;->lineFor(II)I

    move-result v2

    .line 1399
    if-eqz v2, :cond_8

    :goto_7
    move v11, v2

    .line 1400
    goto/16 :goto_0

    .line 1399
    :cond_8
    if-eqz v8, :cond_9

    const v2, -0xc3b5a2    # -2.50281E38f

    goto :goto_7

    :cond_9
    const/4 v2, -0x1

    goto :goto_7

    .line 1400
    :cond_a
    move-object/from16 v0, v18

    iget v2, v0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    if-eqz v2, :cond_b

    move-object/from16 v0, v18

    iget v2, v0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    :goto_8
    invoke-static {v2}, Lcom/mrkeyboard/app/MrKeyLook;->partner(I)I

    move-result v2

    move v11, v2

    goto/16 :goto_0

    :cond_b
    const v2, -0x908401

    goto :goto_8

    .line 1410
    :cond_c
    const/4 v2, 0x0

    move/from16 v23, v2

    goto/16 :goto_1

    .line 1411
    :cond_d
    const/4 v9, 0x0

    goto/16 :goto_2

    .line 1412
    :cond_e
    const/4 v14, 0x0

    goto/16 :goto_3

    .line 1426
    :cond_f
    move-object/from16 v0, v18

    iget v2, v0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    goto/16 :goto_4

    .line 1428
    :cond_10
    const-string v3, "mr_themes_edge_opacity"

    goto/16 :goto_5

    :cond_11
    move v11, v2

    goto/16 :goto_0
.end method

.method showCrop(Landroid/graphics/Bitmap;Lcom/mrkeyboard/app/MrBackdrop$Spec;IZ)V
    .locals 14

    .prologue
    .line 1498
    if-nez p1, :cond_0

    .line 1543
    :goto_0
    return-void

    .line 1499
    :cond_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closeDialog()V

    .line 1500
    const/4 v1, 0x1

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->newDialog(Z)Landroid/app/Dialog;

    move-result-object v7

    .line 1501
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v8

    .line 1502
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x41800000    # 16.0f

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41c00000    # 24.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41800000    # 16.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41800000    # 16.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v8, v1, v2, v3, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 1503
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_crop_hint"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/high16 v3, 0x41800000    # 16.0f

    const/4 v4, -0x1

    const/4 v5, 0x0

    invoke-virtual {v1, v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    .line 1504
    const/16 v2, 0x11

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 1505
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v8, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1506
    new-instance v4, Lcom/mrkeyboard/app/MrCropView;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrCropView;-><init>(Landroid/content/Context;)V

    .line 1507
    move-object/from16 v0, p2

    iget v1, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->zoom:I

    move-object/from16 v0, p2

    iget v2, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dx:I

    move-object/from16 v0, p2

    iget v3, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->dy:I

    invoke-virtual {v4, p1, v1, v2, v3}, Lcom/mrkeyboard/app/MrCropView;->set(Landroid/graphics/Bitmap;III)V

    .line 1508
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, -0x1

    const/4 v3, 0x0

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v1, v2, v3, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 1509
    const/4 v2, 0x0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41600000    # 14.0f

    invoke-virtual {v3, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    const/4 v5, 0x0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v9, 0x41200000    # 10.0f

    invoke-virtual {v6, v9}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-virtual {v1, v2, v3, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1510
    invoke-virtual {v8, v4, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1512
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v9

    .line 1513
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0xe

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v8, v9, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1514
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_themes_cancel"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$36;

    move/from16 v0, p4

    invoke-direct {v5, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$36;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Z)V

    invoke-virtual {v1, v2, v3, v5}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v10

    .line 1520
    iget-object v11, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_next"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v12

    const/4 v13, 0x1

    new-instance v1, Lcom/mrkeyboard/app/MrThemesActivity$37;

    move-object v2, p0

    move/from16 v3, p4

    move-object v5, p1

    move/from16 v6, p3

    invoke-direct/range {v1 .. v6}, Lcom/mrkeyboard/app/MrThemesActivity$37;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;ZLcom/mrkeyboard/app/MrCropView;Landroid/graphics/Bitmap;I)V

    invoke-virtual {v11, v12, v13, v1}, Lcom/mrkeyboard/app/MrKit;->button(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v1

    .line 1526
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, 0x0

    const/4 v5, -0x2

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-direct {v2, v3, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 1527
    const/4 v3, 0x0

    const/4 v5, 0x0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v11, 0x40c00000    # 6.0f

    invoke-virtual {v6, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    const/4 v11, 0x0

    invoke-virtual {v2, v3, v5, v6, v11}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1528
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, 0x0

    const/4 v6, -0x2

    const/high16 v11, 0x3f800000    # 1.0f

    invoke-direct {v3, v5, v6, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 1529
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x40c00000    # 6.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    const/4 v6, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-virtual {v3, v5, v6, v11, v12}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1530
    invoke-virtual {v9, v10, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1531
    invoke-virtual {v9, v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1532
    invoke-virtual {v7, v8}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 1533
    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$38;

    move/from16 v0, p4

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$38;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Z)V

    invoke-virtual {v7, v2}, Landroid/app/Dialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    .line 1538
    iput-object v7, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialog:Landroid/app/Dialog;

    .line 1539
    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCrop:Lcom/mrkeyboard/app/MrCropView;

    .line 1540
    iput-object v10, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCancel:Landroid/widget/TextView;

    .line 1541
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogNext:Landroid/widget/TextView;

    .line 1542
    invoke-virtual {v7}, Landroid/app/Dialog;->show()V

    goto/16 :goto_0
.end method

.method showPreview(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;IZ)V
    .locals 32

    .prologue
    .line 916
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closeDialog()V

    .line 917
    const/4 v3, 0x0

    move-object/from16 v0, p0

    invoke-direct {v0, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->newDialog(Z)Landroid/app/Dialog;

    move-result-object v30

    .line 918
    invoke-static/range {p0 .. p1}, Lcom/mrkeyboard/app/MrThemesActivity;->backgroundName(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    move-object/from16 v0, p0

    invoke-direct {v0, v3, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->sheetBox(Ljava/lang/String;Z)Lcom/mrkeyboard/app/MrSheetBox;

    move-result-object v31

    .line 919
    new-instance v5, Lcom/mrkeyboard/app/MrThemePreview;

    move-object/from16 v0, p0

    invoke-direct {v5, v0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    .line 921
    const/4 v3, 0x1

    invoke-virtual {v5, v3}, Lcom/mrkeyboard/app/MrThemePreview;->setFull(Z)V

    .line 922
    if-nez p2, :cond_0

    move-object/from16 v0, p1

    iget v3, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v4, 0x2

    if-eq v3, v4, :cond_5

    :cond_0
    move-object/from16 v8, p2

    .line 923
    :goto_0
    const/4 v3, 0x1

    new-array v9, v3, [I

    const/4 v3, 0x0

    aput p3, v9, v3

    .line 925
    const/4 v3, 0x1

    new-array v7, v3, [I

    const/4 v3, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p4

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->startStyle(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)I

    move-result v4

    aput v4, v7, v3

    .line 926
    const/4 v3, 0x1

    new-array v10, v3, [Lcom/mrkeyboard/app/MrKeyLook;

    const/4 v3, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p4

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->startLook(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v4

    aput-object v4, v10, v3

    .line 927
    new-instance v3, Lcom/mrkeyboard/app/MrThemesActivity$17;

    move-object/from16 v4, p0

    move-object/from16 v6, p1

    invoke-direct/range {v3 .. v10}, Lcom/mrkeyboard/app/MrThemesActivity$17;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrThemePreview;Lcom/mrkeyboard/app/MrBackdrop$Spec;[ILandroid/graphics/Bitmap;[I[Lcom/mrkeyboard/app/MrKeyLook;)V

    .line 933
    invoke-interface {v3}, Ljava/lang/Runnable;->run()V

    .line 934
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v6, 0xe

    invoke-virtual {v4, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    move-object/from16 v0, v31

    invoke-virtual {v0, v5, v4}, Lcom/mrkeyboard/app/MrSheetBox;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 937
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v4}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v12

    .line 938
    new-instance v4, Lcom/mrkeyboard/app/MrCappedScroll;

    move-object/from16 v0, p0

    invoke-direct {v4, v0}, Lcom/mrkeyboard/app/MrCappedScroll;-><init>(Landroid/content/Context;)V

    .line 939
    new-instance v6, Landroid/view/ViewGroup$LayoutParams;

    const/4 v11, -0x1

    const/4 v13, -0x2

    invoke-direct {v6, v11, v13}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v4, v12, v6}, Lcom/mrkeyboard/app/MrCappedScroll;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 942
    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->faintBar(Landroid/widget/ScrollView;)V

    .line 943
    const/4 v6, 0x0

    const/4 v11, 0x0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v14, 0x41400000    # 12.0f

    invoke-virtual {v13, v14}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v13

    const/4 v14, 0x0

    invoke-virtual {v4, v6, v11, v13, v14}, Lcom/mrkeyboard/app/MrCappedScroll;->setPadding(IIII)V

    .line 944
    const/4 v6, 0x0

    move-object/from16 v0, v31

    invoke-virtual {v0, v6}, Lcom/mrkeyboard/app/MrSheetBox;->setClipToPadding(Z)V

    .line 945
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v11, 0x0

    invoke-virtual {v6, v11}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v6

    .line 946
    const/4 v11, 0x0

    const/4 v13, 0x0

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v15, 0x41400000    # 12.0f

    invoke-virtual {v14, v15}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v14

    neg-int v14, v14

    const/4 v15, 0x0

    invoke-virtual {v6, v11, v13, v14, v15}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 947
    move-object/from16 v0, v31

    invoke-virtual {v0, v4, v6}, Lcom/mrkeyboard/app/MrSheetBox;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 948
    move-object/from16 v0, v31

    invoke-virtual {v0, v4}, Lcom/mrkeyboard/app/MrSheetBox;->limit(Lcom/mrkeyboard/app/MrCappedScroll;)V

    .line 950
    const/4 v4, 0x0

    .line 951
    move-object/from16 v0, p1

    iget v6, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v11, 0x1

    if-eq v6, v11, :cond_1

    move-object/from16 v0, p1

    iget v6, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v11, 0x2

    if-eq v6, v11, :cond_1

    move-object/from16 v0, p1

    iget v6, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v11, 0x3

    if-ne v6, v11, :cond_2

    .line 952
    :cond_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_themes_soften"

    const/4 v11, 0x0

    new-array v11, v11, [Ljava/lang/Object;

    invoke-virtual {v4, v6, v11}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v13

    const/16 v14, 0x46

    const/16 v16, 0xe

    new-instance v17, Lcom/mrkeyboard/app/MrThemesActivity$18;

    move-object/from16 v0, v17

    move-object/from16 v1, p0

    invoke-direct {v0, v1, v9, v3}, Lcom/mrkeyboard/app/MrThemesActivity$18;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;[ILjava/lang/Runnable;)V

    move-object/from16 v11, p0

    move/from16 v15, p3

    invoke-direct/range {v11 .. v17}, Lcom/mrkeyboard/app/MrThemesActivity;->slider(Landroid/widget/LinearLayout;Ljava/lang/String;IIILcom/mrkeyboard/app/MrThemesActivity$Setter;)Landroid/widget/SeekBar;

    move-result-object v4

    .line 958
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v13, "mr_themes_soften_hint"

    const/4 v14, 0x0

    new-array v14, v14, [Ljava/lang/Object;

    invoke-virtual {v11, v13, v14}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v11

    const/high16 v13, 0x41500000    # 13.0f

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v14, v14, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v15, 0x0

    invoke-virtual {v6, v11, v13, v14, v15}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v6

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v13, 0x2

    invoke-virtual {v11, v13}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v11

    invoke-virtual {v12, v6, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 961
    :cond_2
    invoke-static/range {p1 .. p1}, Lcom/mrkeyboard/app/MrBackdrop;->hasStyles(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z

    move-result v11

    .line 962
    if-eqz v11, :cond_6

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v13

    .line 963
    :goto_1
    if-eqz v11, :cond_7

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v21

    .line 964
    :goto_2
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v6}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v22

    .line 967
    if-eqz v11, :cond_3

    .line 968
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v14, "mr_themes_key_color"

    const/4 v15, 0x0

    new-array v15, v15, [Ljava/lang/Object;

    invoke-virtual {v6, v14, v15}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    const/16 v14, 0xe

    move-object/from16 v0, p0

    invoke-direct {v0, v12, v6, v13, v14}, Lcom/mrkeyboard/app/MrThemesActivity;->card(Landroid/widget/LinearLayout;Ljava/lang/String;Landroid/widget/LinearLayout;I)Landroid/widget/LinearLayout;

    .line 969
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v14, "mr_themes_line_color"

    const/4 v15, 0x0

    new-array v15, v15, [Ljava/lang/Object;

    invoke-virtual {v6, v14, v15}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    const/16 v14, 0xc

    move-object/from16 v0, p0

    move-object/from16 v1, v21

    invoke-direct {v0, v12, v6, v1, v14}, Lcom/mrkeyboard/app/MrThemesActivity;->card(Landroid/widget/LinearLayout;Ljava/lang/String;Landroid/widget/LinearLayout;I)Landroid/widget/LinearLayout;

    .line 971
    :cond_3
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v14, "mr_themes_text_color"

    const/4 v15, 0x0

    new-array v15, v15, [Ljava/lang/Object;

    invoke-virtual {v6, v14, v15}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    const/16 v14, 0xc

    move-object/from16 v0, p0

    move-object/from16 v1, v22

    invoke-direct {v0, v12, v6, v1, v14}, Lcom/mrkeyboard/app/MrThemesActivity;->card(Landroid/widget/LinearLayout;Ljava/lang/String;Landroid/widget/LinearLayout;I)Landroid/widget/LinearLayout;

    .line 972
    invoke-static/range {p1 .. p1}, Lcom/mrkeyboard/app/MrBackdrop;->darkInk(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z

    move-result v14

    .line 974
    if-eqz v11, :cond_8

    move-object/from16 v0, p1

    invoke-static {v0, v8}, Lcom/mrkeyboard/app/MrPalette;->of(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;)[I

    move-result-object v15

    .line 977
    :goto_3
    move-object/from16 v0, p1

    iget v6, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v12, 0x2

    if-eq v6, v12, :cond_4

    move-object/from16 v0, p1

    iget v6, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v12, 0x3

    if-ne v6, v12, :cond_9

    :cond_4
    const/4 v6, 0x1

    .line 978
    :goto_4
    if-nez v11, :cond_a

    const/16 v16, 0x0

    .line 979
    :goto_5
    const/4 v6, 0x1

    new-array v0, v6, [Ljava/lang/Runnable;

    move-object/from16 v20, v0

    .line 980
    const/4 v6, 0x0

    new-instance v11, Lcom/mrkeyboard/app/MrThemesActivity$19;

    move-object/from16 v12, p0

    move-object/from16 v17, v7

    move-object/from16 v18, v10

    move-object/from16 v19, v3

    invoke-direct/range {v11 .. v22}, Lcom/mrkeyboard/app/MrThemesActivity$19;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/LinearLayout;Z[II[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;Landroid/widget/LinearLayout;Landroid/widget/LinearLayout;)V

    aput-object v11, v20, v6

    .line 987
    const/4 v3, 0x0

    aget-object v3, v20, v3

    invoke-interface {v3}, Ljava/lang/Runnable;->run()V

    .line 989
    new-instance v23, Lcom/mrkeyboard/app/MrThemesActivity$20;

    move-object/from16 v24, p0

    move-object/from16 v25, p1

    move-object/from16 v26, v9

    move-object/from16 v27, v7

    move-object/from16 v28, v10

    move/from16 v29, p4

    invoke-direct/range {v23 .. v29}, Lcom/mrkeyboard/app/MrThemesActivity$20;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrBackdrop$Spec;[I[I[Lcom/mrkeyboard/app/MrKeyLook;Z)V

    move-object/from16 v24, p0

    move-object/from16 v25, v30

    move-object/from16 v26, v31

    move-object/from16 v27, v5

    move-object/from16 v28, v4

    move/from16 v29, p4

    move-object/from16 v30, v23

    invoke-direct/range {v24 .. v30}, Lcom/mrkeyboard/app/MrThemesActivity;->sheetShow(Landroid/app/Dialog;Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrThemePreview;Landroid/widget/SeekBar;ZLjava/lang/Runnable;)V

    .line 995
    move-object/from16 v0, p0

    iput-boolean v14, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogPale:Z

    .line 996
    move-object/from16 v0, p0

    iput-object v10, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogLook:[Lcom/mrkeyboard/app/MrKeyLook;

    .line 997
    move-object/from16 v0, p0

    iput-object v7, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogStyle:[I

    .line 998
    move-object/from16 v0, p0

    iput-object v13, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogKeys:Landroid/widget/LinearLayout;

    .line 999
    move-object/from16 v0, v21

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogLine:Landroid/widget/LinearLayout;

    .line 1000
    move-object/from16 v0, v22

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogText:Landroid/widget/LinearLayout;

    .line 1001
    return-void

    .line 922
    :cond_5
    move-object/from16 v0, p1

    iget v3, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    move-object/from16 v0, p0

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrScenes;->load(Landroid/content/Context;I)Landroid/graphics/Bitmap;

    move-result-object v8

    goto/16 :goto_0

    .line 962
    :cond_6
    const/4 v13, 0x0

    goto/16 :goto_1

    .line 963
    :cond_7
    const/16 v21, 0x0

    goto/16 :goto_2

    .line 974
    :cond_8
    const/4 v6, 0x0

    new-array v15, v6, [I

    goto/16 :goto_3

    .line 977
    :cond_9
    const/4 v6, 0x0

    goto :goto_4

    .line 978
    :cond_a
    if-eqz v6, :cond_b

    array-length v6, v15

    if-lez v6, :cond_b

    const/4 v6, 0x0

    aget v16, v15, v6

    goto :goto_5

    :cond_b
    move-object/from16 v0, p1

    invoke-static {v0, v8}, Lcom/mrkeyboard/app/MrPalette;->tone(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;)I

    move-result v16

    goto/16 :goto_5
.end method

.method showTab(I)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x0

    .line 375
    iput p1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    .line 376
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabLoad:I

    .line 377
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mGrid:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 378
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeTiles:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 379
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThemeActions:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 380
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgTiles:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 381
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgSpecs:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 382
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBgActions:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 383
    iput-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mMineTile:Lcom/mrkeyboard/app/MrThemePreview;

    .line 384
    iput-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRemove:Landroid/widget/TextView;

    .line 385
    iput-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mRow:Landroid/widget/LinearLayout;

    .line 386
    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity;->cardsOf(I)Ljava/util/List;

    move-result-object v1

    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mCards:Ljava/util/List;

    .line 387
    iput v2, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mBuilt:I

    .line 388
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->styleTabs()V

    .line 389
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v1, v2, v2}, Landroid/widget/ScrollView;->scrollTo(II)V

    .line 390
    const/4 v1, 0x3

    if-lt p1, v1, :cond_0

    const/16 v1, 0x9

    if-ge p1, v1, :cond_0

    add-int/lit8 v1, p1, -0x3

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->loadScenes(I)V

    .line 391
    :cond_0
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->buildMore(I)V

    .line 392
    return-void
.end method

.method showThemePreview(I)V
    .locals 7

    .prologue
    const/4 v4, 0x0

    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 895
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemesActivity;->closeDialog()V

    .line 896
    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/MrThemesActivity;->newDialog(Z)Landroid/app/Dialog;

    move-result-object v1

    .line 897
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    array-length v0, v0

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mNames:[Ljava/lang/String;

    aget-object v0, v0, p1

    :goto_0
    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/MrThemesActivity;->sheetBox(Ljava/lang/String;Z)Lcom/mrkeyboard/app/MrSheetBox;

    move-result-object v2

    .line 898
    new-instance v3, Lcom/mrkeyboard/app/MrThemePreview;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrThemePreview;-><init>(Landroid/content/Context;)V

    .line 899
    invoke-virtual {v3, v6}, Lcom/mrkeyboard/app/MrThemePreview;->setFull(Z)V

    .line 900
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    aget-object v0, v0, p1

    sget-object v6, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {v3, v0, v6, v4, v5}, Lcom/mrkeyboard/app/MrThemePreview;->show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V

    .line 901
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v6, 0xe

    invoke-virtual {v0, v6}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v2, v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 902
    new-instance v6, Lcom/mrkeyboard/app/MrThemesActivity$16;

    invoke-direct {v6, p0, p1}, Lcom/mrkeyboard/app/MrThemesActivity$16;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V

    move-object v0, p0

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrThemesActivity;->sheetShow(Landroid/app/Dialog;Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrThemePreview;Landroid/widget/SeekBar;ZLjava/lang/Runnable;)V

    .line 907
    return-void

    .line 897
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTags:[Ljava/lang/String;

    aget-object v0, v0, p1

    goto :goto_0
.end method

.method startLook(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)Lcom/mrkeyboard/app/MrKeyLook;
    .locals 1

    .prologue
    .line 732
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
    .locals 1

    .prologue
    .line 746
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->startSoft(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)I

    move-result v0

    return v0
.end method

.method startSoft(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)I
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v0, 0x0

    .line 740
    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eq v1, v3, :cond_1

    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v2, 0x2

    if-eq v1, v2, :cond_1

    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v2, 0x3

    if-eq v1, v2, :cond_1

    .line 742
    :cond_0
    :goto_0
    return v0

    .line 741
    :cond_1
    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/MrThemesActivity;->inUse(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)Z

    move-result v1

    if-eqz v1, :cond_2

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSoft:I

    goto :goto_0

    .line 742
    :cond_2
    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eq v1, v3, :cond_0

    const/16 v0, 0x19

    goto :goto_0
.end method

.method startStyle(Lcom/mrkeyboard/app/MrBackdrop$Spec;Z)I
    .locals 1

    .prologue
    .line 727
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
    .locals 8

    .prologue
    const/4 v4, 0x1

    const/high16 v7, 0x41900000    # 18.0f

    const/4 v2, 0x0

    .line 423
    move v1, v2

    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_4

    .line 424
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 425
    iget v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    if-ne v1, v3, :cond_0

    move v5, v4

    .line 426
    :goto_1
    if-eqz v5, :cond_1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->onAccent:I

    :goto_2
    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 427
    const/4 v6, 0x0

    if-eqz v5, :cond_2

    move v3, v4

    :goto_3
    invoke-virtual {v0, v6, v3}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 428
    if-eqz v5, :cond_3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->accent:I

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->accent:I

    invoke-virtual {v3, v5, v6, v7, v2}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    :goto_4
    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 423
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    :cond_0
    move v5, v2

    .line 425
    goto :goto_1

    .line 426
    :cond_1
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text2:I

    goto :goto_2

    :cond_2
    move v3, v2

    .line 427
    goto :goto_3

    .line 428
    :cond_3
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->stroke:I

    invoke-virtual {v3, v2, v5, v7, v2}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    goto :goto_4

    .line 430
    :cond_4
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    if-ltz v0, :cond_5

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ge v0, v1, :cond_5

    .line 431
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTabViews:Ljava/util/List;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 432
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    new-instance v2, Lcom/mrkeyboard/app/MrThemesActivity$7;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$7;-><init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/TextView;)V

    invoke-virtual {v1, v2}, Landroid/widget/HorizontalScrollView;->post(Ljava/lang/Runnable;)Z

    .line 438
    :cond_5
    return-void
.end method

.method tabName(I)Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 280
    if-nez p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_themes"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 284
    :goto_0
    return-object v0

    .line 281
    :cond_0
    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_colors"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 282
    :cond_1
    const/4 v0, 0x2

    if-ne p1, v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_gradients"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 283
    :cond_2
    const/16 v0, 0x9

    if-ne p1, v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v1, "mr_themes_gallery"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 284
    :cond_3
    add-int/lit8 v0, p1, -0x3

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->categoryName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method tabOfChoice()I
    .locals 1

    .prologue
    .line 289
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    packed-switch v0, :pswitch_data_0

    .line 294
    const/4 v0, 0x0

    :goto_0
    return v0

    .line 290
    :pswitch_0
    const/4 v0, 0x1

    goto :goto_0

    .line 291
    :pswitch_1
    const/4 v0, 0x2

    goto :goto_0

    .line 292
    :pswitch_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->index:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrScenes;->category(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x3

    goto :goto_0

    .line 293
    :pswitch_3
    const/16 v0, 0x9

    goto :goto_0

    .line 289
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
    .line 598
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
    .line 608
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 610
    :goto_0
    return-object v0

    .line 609
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

    .line 610
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method tileSpec(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Lcom/mrkeyboard/app/MrBackdrop$Spec;
    .locals 2

    .prologue
    const/4 v1, 0x3

    .line 603
    iget v0, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-ne v0, v1, :cond_0

    iget-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    :cond_0
    return-object p1
.end method
