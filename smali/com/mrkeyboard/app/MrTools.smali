.class public Lcom/mrkeyboard/app/MrTools;
.super Ljava/lang/Object;
.source "MrTools.java"

.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Landroid/widget/AdapterView$OnItemLongClickListener;
.implements Landroid/content/ClipboardManager$OnPrimaryClipChangedListener;
.implements Landroid/text/TextWatcher;
.implements Ljava/lang/Runnable;

.field static sAdIn:Lcom/mrkeyboard/app/MrToolsAdp;

.field static sAdOut:Lcom/mrkeyboard/app/MrToolsAdp;

.field static sAdapter:Lcom/mrkeyboard/app/MrToolsAdp;

.field static sBtnView:Landroid/widget/TextView;

.field static sCols:I

.field static sGridClip:Landroid/widget/GridView;

.field static sBarC:Landroid/view/View;

.field static sBarE:Landroid/view/View;

.field static sPEmote:Landroid/view/View;

.field static sBarMain:Landroid/view/View;

.field static sBarOn:Z

# Root of the inflated toolbar (mr_toolbar); used to apply the
# label scale to the button icons.
.field static sBarRoot:Landroid/view/View;

.field static sBarS:Landroid/view/View;

.field static sBarT:Landroid/view/View;

.field static sBtnClipCount:Landroid/widget/TextView;

.field static sBtnClipSw:Landroid/widget/TextView;

.field static sBtnClipTop:Landroid/widget/TextView;

.field static sBtnLang:Landroid/widget/TextView;

.field static sClipOn:Z

.field private static sClipListener:Lcom/mrkeyboard/app/MrTools;

.field static sClips:Ljava/util/ArrayList;
.field static sClipTs:Ljava/util/ArrayList;

.field static sCm:Landroid/content/ClipboardManager;

.field static sDeb:Lcom/mrkeyboard/app/MrTools;

.field static sDst:I

.field static sField:Landroid/widget/TextView;

.field static sHandler:Landroid/os/Handler;

.field static sHint:I

.field static sTranslateExec:Ljava/util/concurrent/ExecutorService;
.field static sApp:Landroid/content/Context;
.field static volatile sSession:I
.field mSession:I

.field static sIme:Lcom/mrkeyboard/app/LatinIME;

.field static sInited:Z

.field static sInsText:Ljava/lang/String;

.field static sItemLay:I

.field static sKbd:Landroid/view/View;

# Accent color of the Midnight Steel theme (highlight on touch) and background color of the accent keys
# (background of the buttons of the Attachments tab). Computed in deriveColors() at every wrap().
.field static sAccent:I

.field static sAccentBg:I

.field static sKeyBg:Landroid/graphics/drawable/Drawable;

.field static sLC:[Ljava/lang/String;

.field static sLN:[Ljava/lang/String;

.field static sLastKey:Ljava/lang/String;

.field static sNamesIn:Ljava/util/ArrayList;

.field static sNamesOut:Ljava/util/ArrayList;

.field static sPClip:Landroid/view/View;

.field static sPShots:Landroid/view/View;

.field static sPLang:Landroid/view/View;

.field static sPad:I

.field static sPadV:I

.field static sPrefs:Landroid/content/SharedPreferences;

.field static sRedirect:Landroid/view/inputmethod/InputConnection;

.field static sSelColor:I

# Rim of the panes of a theme of glass (role pane_rim, Cobalt Glass): 0 = no rim, as in every other theme.
.field static sRim:I

.field static sSeq:I

.field static sSrc:I

.field static sKeyText:I

.field static sTextColor:I

.field private mCode:I

.field private mSeq:I

.field private mText:Ljava/lang/String;

.method static constructor <clinit>()V
    .locals 4

    const/16 v0, 0x8

    new-array v1, v0, [Ljava/lang/String;

    new-array v2, v0, [Ljava/lang/String;

    const/4 v0, 0x0

    const-string v3, "pt"

    aput-object v3, v1, v0

    const-string v3, "Portugu\u00eas"

    aput-object v3, v2, v0

    const/4 v0, 0x1

    const-string v3, "en"

    aput-object v3, v1, v0

    const-string v3, "English"

    aput-object v3, v2, v0

    const/4 v0, 0x2

    const-string v3, "es"

    aput-object v3, v1, v0

    const-string v3, "Espa\u00f1ol"

    aput-object v3, v2, v0

    const/4 v0, 0x3

    const-string v3, "fr"

    aput-object v3, v1, v0

    const-string v3, "Fran\u00e7ais"

    aput-object v3, v2, v0

    const/4 v0, 0x4

    const-string v3, "de"

    aput-object v3, v1, v0

    const-string v3, "Deutsch"

    aput-object v3, v2, v0

    const/4 v0, 0x5

    const-string v3, "it"

    aput-object v3, v1, v0

    const-string v3, "Italiano"

    aput-object v3, v2, v0

    const/4 v0, 0x6

    const-string v3, "ja"

    aput-object v3, v1, v0

    const-string v3, "\u65e5\u672c\u8a9e"

    aput-object v3, v2, v0

    const/4 v0, 0x7

    const-string v3, "ru"

    aput-object v3, v1, v0

    const-string v3, "\u0420\u0443\u0441\u0441\u043a\u0438\u0439"

    aput-object v3, v2, v0

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sLC:[Ljava/lang/String;

    sput-object v2, Lcom/mrkeyboard/app/MrTools;->sLN:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(ILjava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/mrkeyboard/app/MrTools;->mCode:I

    iput-object p2, p0, Lcom/mrkeyboard/app/MrTools;->mText:Ljava/lang/String;

    sget v0, Lcom/mrkeyboard/app/MrTools;->sSession:I
    iput v0, p0, Lcom/mrkeyboard/app/MrTools;->mSession:I
    return-void
.end method
.method static accent()I
    .locals 2

    sget v0, Lcom/mrkeyboard/app/MrTools;->sAccent:I

    const v1, 0xffffff

    and-int/2addr v0, v1

    return v0
.end method

.method private static applyResult(Ljava/lang/String;)V
    .locals 5

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getAppInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v0

    if-eqz v0, :cond_end

    invoke-interface {v0}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sInsText:Ljava/lang/String;

    if-eqz v1, :cond_commit

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x0

    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v4

    invoke-static {v4}, Lcom/mrkeyboard/app/MrTools;->strOf(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_commit

    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z

    :cond_commit
    const/4 v1, 0x1

    invoke-interface {v0, p0, v1}, Landroid/view/inputmethod/InputConnection;->commitText(Ljava/lang/CharSequence;I)Z

    sput-object p0, Lcom/mrkeyboard/app/MrTools;->sInsText:Ljava/lang/String;

    :cond_end
    return-void
.end method

.method private static applyCols()V
    .locals 3

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sGridClip:Landroid/widget/GridView;

    if-eqz v0, :cond_end

    sget v1, Lcom/mrkeyboard/app/MrTools;->sCols:I

    invoke-virtual {v0, v1}, Landroid/widget/GridView;->setNumColumns(I)V

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBtnView:Landroid/widget/TextView;

    if-eqz v0, :cond_end

    invoke-virtual {v0}, Landroid/widget/TextView;->getCompoundDrawables()[Landroid/graphics/drawable/Drawable;

    move-result-object v0

    const/4 v2, 0x0

    aget-object v0, v0, v2

    if-eqz v0, :cond_end

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setLevel(I)Z

    :cond_end
    return-void
.end method

.method private static toggleCols()V
    .locals 2

    sget v0, Lcom/mrkeyboard/app/MrTools;->sCols:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_one

    const/4 v1, 0x2

    :cond_one
    sput v1, Lcom/mrkeyboard/app/MrTools;->sCols:I

    const-string v0, "clip_cols"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->savePrefInt(Ljava/lang/String;I)V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyCols()V

    return-void
.end method

# Main row (bar_main): hidden when a panel is open; otherwise MrSugg.mode decides between
# tools (1), suggestions (2) or nothing (0). See MrSugg.
.method static applyMain()V
    .locals 4

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarMain:Landroid/view/View;

    if-eqz v0, :cond_am_end

    const/16 v1, 0x8

    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sBarT:Landroid/view/View;

    if-eqz v2, :cond_am_chkc

    invoke-virtual {v2}, Landroid/view/View;->getVisibility()I

    move-result v2

    if-eqz v2, :cond_am_set

    :cond_am_chkc
    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sBarC:Landroid/view/View;

    if-eqz v2, :cond_am_chks

    invoke-virtual {v2}, Landroid/view/View;->getVisibility()I

    move-result v2

    if-eqz v2, :cond_am_set

    :cond_am_chks
    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sBarS:Landroid/view/View;

    if-eqz v2, :cond_am_che

    invoke-virtual {v2}, Landroid/view/View;->getVisibility()I

    move-result v2

    if-eqz v2, :cond_am_set

    :cond_am_che
    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sBarE:Landroid/view/View;

    if-eqz v2, :cond_am_chtune

    invoke-virtual {v2}, Landroid/view/View;->getVisibility()I

    move-result v2

    if-eqz v2, :cond_am_set

    :cond_am_chtune
    sget-object v2, Lcom/mrkeyboard/app/MrTune;->sBar:Landroid/view/View;

    if-eqz v2, :cond_am_mode

    invoke-virtual {v2}, Landroid/view/View;->getVisibility()I

    move-result v2

    if-eqz v2, :cond_am_set

    :cond_am_mode
    sget-boolean v3, Lcom/mrkeyboard/app/MrTools;->sBarOn:Z

    invoke-static {v3}, Lcom/mrkeyboard/app/MrSugg;->mode(Z)I

    move-result v2

    if-eqz v2, :cond_am_set

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrSugg;->applyInner(IZ)V

    const/4 v1, 0x0

    :cond_am_set
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_am_end
    return-void
.end method

.method public static toggleBar()V
    .locals 2

        # With the row visible and suggestions available, the key toggles suggestions <-> tools
        # (MrSugg). Otherwise, it shows/hides the row as before.
    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->onBarKey()Z

    move-result v0

    if-eqz v0, :cond_tb_toggle

    return-void

    :cond_tb_toggle
    sget-boolean v0, Lcom/mrkeyboard/app/MrTools;->sBarOn:Z

    xor-int/lit8 v0, v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrTools;->sBarOn:Z

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sPrefs:Landroid/content/SharedPreferences;

    if-eqz v1, :cond_tb_nosave

    const-string v1, "bar_on"

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrTools;->savePrefBool(Ljava/lang/String;Z)V

    :cond_tb_nosave
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    instance-of v1, v0, Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    if-eqz v1, :cond_tb_end

    check-cast v0, Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->invalidateAllKeys()V

    :cond_tb_end
    return-void
.end method

.method static btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;
    .locals 4

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sget v1, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    instance-of v1, v0, Landroid/widget/EditText;

    if-eqz v1, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->fieldBg()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    goto :goto_0

    :cond_0
    const-string v1, "b_"

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "cat_"

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->panelBg()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    goto :goto_0

    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->flatBg()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    sget v1, Lcom/mrkeyboard/app/MrTools;->sPad:I

    invoke-virtual {v0}, Landroid/widget/TextView;->length()I

    move-result v2

    if-eqz v2, :cond_2

    mul-int/lit8 v1, v1, 0x4

    div-int/lit8 v1, v1, 0x5

    :cond_2
    const-string v2, "b_"

    invoke-virtual {p1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    mul-int/lit8 v1, v1, 0x4

    div-int/lit8 v1, v1, 0x5

    :cond_3
    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2, v1, v2}, Landroid/view/View;->setPadding(IIII)V

    if-ltz p2, :cond_4

    new-instance v1, Lcom/mrkeyboard/app/MrTools;

    const/4 v3, 0x0

    invoke-direct {v1, p2, v3}, Lcom/mrkeyboard/app/MrTools;-><init>(ILjava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_4
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->flatBar()Z

    move-result v1

    if-eqz v1, :cond_5

    const-string v1, "panel_icon"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tintColor(Landroid/widget/TextView;I)V

    goto :goto_1

    :cond_5
    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->tint(Landroid/widget/TextView;)V

    :goto_1
    return-object v0
.end method

# ---------------------------------------------------------------------------------------
# Midnight Steel theme styles for the toolbar
# ---------------------------------------------------------------------------------------

.method static applyTranslucentBlur()V
    .locals 5

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    if-nez v0, :cond_ag_ime

    return-void

    :cond_ag_ime
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->translucent()Z

    move-result v1

    const/4 v2, 0x0

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1f

    if-lt v3, v4, :cond_ag_color

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTranslucentBlur;->apply(Landroid/inputmethodservice/InputMethodService;Z)Z

    move-result v2

    :cond_ag_color
    if-eqz v1, :cond_ag_end

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    if-eqz v0, :cond_ag_end

    if-eqz v2, :cond_ag_plain

    const-string v1, "kbd_bg_blur"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    goto :cond_ag_set

    :cond_ag_plain

    const-string v1, "kbd_bg"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    :cond_ag_set
    # one sheet of glass: the veil goes on the root of the tools, which holds the bar, the panels and the keyboard, and the
    # keyboard view itself is left clear, so that the bar and the keys sit on the same veil (the keyboard's own background
    # on top of the copy that wrap gives the root would make the part of the keys denser than the bar)
    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sBarRoot:Landroid/view/View;

    if-eqz v2, :cond_ag_own

    invoke-virtual {v2, v1}, Landroid/view/View;->setBackgroundColor(I)V

    const/4 v1, 0x0

    :cond_ag_own
    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V

    :cond_ag_end
    return-void
.end method

# sAccent: the accent key color adjusted to read well over the background (dark theme: minimum
# brightness 0.86 and maximum saturation 0.60; light theme: maximum brightness 0.40; the hue is the theme's), or the role
# tool_tint when the theme declares one. sAccentBg: the accent key core itself, opaque. Without an accent key, it uses the text color.
.method static deriveColors()V
    .locals 5

    const-string v0, "ctrl_bg"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sget v1, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    const/4 v2, 0x3

    new-array v2, v2, [F

    invoke-static {v1, v2}, Landroid/graphics/Color;->colorToHSV(I[F)V

    const/4 v3, 0x2

    aget v3, v2, v3

    const/high16 v4, 0x3f000000    # 0.5f

    cmpl-float v3, v3, v4

    if-nez v0, :cond_0

    move v0, v1

    :cond_0
    invoke-static {v0, v2}, Landroid/graphics/Color;->colorToHSV(I[F)V

    const/4 v4, 0x2

    aget v1, v2, v4

    if-lez v3, :cond_2

    const v4, 0x3f5c28f6    # 0.86f

    cmpg-float v3, v1, v4

    if-gez v3, :cond_1

    move v1, v4

    :cond_1
    const/4 v3, 0x1

    aget v3, v2, v3

    const v4, 0x3f19999a    # 0.6f

    cmpl-float v3, v3, v4

    if-lez v3, :cond_3

    const/4 v3, 0x1

    aput v4, v2, v3

    goto :goto_0

    :cond_2
    const v4, 0x3ecccccd    # 0.4f

    cmpl-float v3, v1, v4

    if-lez v3, :cond_3

    move v1, v4

    :cond_3
    :goto_0
    const/4 v4, 0x2

    aput v1, v2, v4

    invoke-static {v2}, Landroid/graphics/Color;->HSVToColor([F)I

    move-result v1

    sput v1, Lcom/mrkeyboard/app/MrTools;->sAccent:I

    const/high16 v1, -0x1000000

    or-int/2addr v0, v1

    sput v0, Lcom/mrkeyboard/app/MrTools;->sAccentBg:I

    # a theme that declares the role tool_tint paints the inner buttons, the tabs, the border of the field and the selection with
    # that color as it is (a light theme gets a vivid one; the derivation above turns a light face into a dark, dull tone)
    const-string v1, "tool_tint"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_mr_tint

    const/high16 v2, -0x1000000

    or-int/2addr v1, v2

    sput v1, Lcom/mrkeyboard/app/MrTools;->sAccent:I

    :cond_mr_tint
    sget v1, Lcom/mrkeyboard/app/MrTools;->sAccent:I

    const v2, 0xffffff

    and-int/2addr v1, v2

    const-string v2, "alpha_sel"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v2

    or-int/2addr v1, v2

    sput v1, Lcom/mrkeyboard/app/MrTools;->sSelColor:I

    # a theme of glass panes (Cobalt Glass) declares the rim that outlines every pane of the tools (rrect, rim)
    const-string v1, "pane_rim"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    sput v1, Lcom/mrkeyboard/app/MrTools;->sRim:I

    return-void
.end method

# Rounded rectangle: p0 = fill, p1 = border color, p2 = border width (px),
# p3 = corner radius (px).
.method private static rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;
    .locals 2

    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    invoke-virtual {v0, p0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    invoke-virtual {v0, p2, p1}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    invoke-virtual {v0, p3}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    # a pane with a fill and no border of its own: in a theme of glass it gets the rim (see rim)
    if-nez p2, :cond_mr_rim

    ushr-int/lit8 v1, p0, 0x18

    if-eqz v1, :cond_mr_rim

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->rim(Landroid/graphics/drawable/GradientDrawable;)V

    :cond_mr_rim
    return-object v0
.end method

# Outlines the pane p0 with the rim of a theme of glass panes (role pane_rim, read in deriveColors): 1 dp, in every pane
# of the tools that has a fill (buttons, tabs, cards, the selected row, a tool of the bar under the finger). Nothing in a
# theme that does not declare the role.
.method static rim(Landroid/graphics/drawable/GradientDrawable;)V
    .locals 2

    sget v0, Lcom/mrkeyboard/app/MrTools;->sRim:I

    if-eqz v0, :cond_0

    sget v1, Lcom/mrkeyboard/app/MrTools;->sPad:I

    div-int/lit8 v1, v1, 0xa

    if-gtz v1, :cond_1

    const/4 v1, 0x1

    :cond_1
    invoke-virtual {p0, v1, v0}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    :cond_0
    return-void
.end method

# Corner radius (px) of the toolbar and panel buttons and fields: 8 dp + margin p0 (dp), fixed. It does not
# follow the key radius (pref_key_radius) nor the label scale: those change only the keys.
.method static radius(F)F
    .locals 2
    sget v0, Lcom/mrkeyboard/app/MrTools;->sPad:I
    int-to-float v0, v0
    const/high16 v1, 0x41200000    # 10.0f
    div-float/2addr v0, v1
    const/high16 v1, 0x41000000    # 8.0f
    add-float/2addr v1, p0
    mul-float/2addr v0, v1
    return v0
.end method
.method static lookFixed(Landroid/graphics/drawable/Drawable;Landroid/content/Context;)V
    .locals 10
    if-nez p0, :cond_0
    return-void
    :cond_0
    instance-of v0, p0, Landroid/graphics/drawable/DrawableContainer;
    if-eqz v0, :cond_1
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;
    move-result-object v0
    instance-of v1, v0, Landroid/graphics/drawable/DrawableContainer$DrawableContainerState;
    if-eqz v1, :cond_4
    check-cast v0, Landroid/graphics/drawable/DrawableContainer$DrawableContainerState;
    invoke-virtual {v0}, Landroid/graphics/drawable/DrawableContainer$DrawableContainerState;->getChildren()[Landroid/graphics/drawable/Drawable;
    move-result-object v0
    array-length v1, v0
    const/4 v2, 0x0
    :goto_0
    if-ge v2, v1, :cond_4
    aget-object v3, v0, v2
    invoke-static {v3, p1}, Lcom/mrkeyboard/app/MrTools;->lookFixed(Landroid/graphics/drawable/Drawable;Landroid/content/Context;)V
    add-int/lit8 v2, v2, 0x1
    goto :goto_0
    :cond_1
    const/4 v2, 0x0
    invoke-static {v2}, Lcom/mrkeyboard/app/MrTools;->radius(F)F
    move-result v2
    instance-of v6, p0, Landroid/graphics/drawable/LayerDrawable;
    if-eqz v6, :cond_3
    check-cast p0, Landroid/graphics/drawable/LayerDrawable;
    invoke-virtual {p0}, Landroid/graphics/drawable/LayerDrawable;->getNumberOfLayers()I
    move-result v6
    const/4 v7, 0x0
    :goto_1
    if-ge v7, v6, :cond_4
    invoke-virtual {p0, v7}, Landroid/graphics/drawable/LayerDrawable;->getDrawable(I)Landroid/graphics/drawable/Drawable;
    move-result-object v8
    instance-of v9, v8, Landroid/graphics/drawable/GradientDrawable;
    if-eqz v9, :cond_2
    invoke-static {p0, v7}, Lcom/mrkeyboard/app/KeyStyle;->layerGap(Landroid/graphics/drawable/LayerDrawable;I)F
    move-result v9
    add-float/2addr v9, v2
    check-cast v8, Landroid/graphics/drawable/GradientDrawable;
    invoke-virtual {v8, v9}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V
    :cond_2
    add-int/lit8 v7, v7, 0x1
    goto :goto_1
    :cond_3
    instance-of v6, p0, Landroid/graphics/drawable/GradientDrawable;
    if-eqz v6, :cond_4
    check-cast p0, Landroid/graphics/drawable/GradientDrawable;
    invoke-virtual {p0, v2}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V
    :cond_4
    return-void
.end method

# Background of the bar buttons: transparent; on touch, the color of the highlight keys (ctrlBg) with the
# theme's alpha_flat, in a rectangle with the same corners as the panel buttons (radius(0) = 8 dp).
.method static flatBg()Landroid/graphics/drawable/Drawable;
    .locals 5

    new-instance v0, Landroid/graphics/drawable/StateListDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/StateListDrawable;-><init>()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->ctrlBg()I

    move-result v1

    const v2, 0xffffff

    and-int/2addr v1, v2

    const-string v2, "alpha_flat"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v2

    or-int/2addr v1, v2

    const/4 v2, 0x0

    const/4 v3, 0x0    # 0.0f

    invoke-static {v3}, Lcom/mrkeyboard/app/MrTools;->radius(F)F

    move-result v3

    invoke-static {v1, v2, v2, v3}, Lcom/mrkeyboard/app/MrTools;->rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    const/4 v3, 0x1

    new-array v3, v3, [I

    const v4, 0x10100a7

    aput v4, v3, v2

    invoke-virtual {v0, v3, v1}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    new-array v3, v2, [I

    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v1, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v0, v3, v1}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    return-object v0
.end method

# Background of the selected emote category: equal to that of the panel buttons (back), see softBg.
.method static selBg()Landroid/graphics/drawable/Drawable;
    .locals 1

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->softBg()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method static tabOffBg()Landroid/graphics/drawable/Drawable;
    .locals 3

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->accent()I

    move-result v0

    const-string v1, "alpha_tab_off"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    or-int/2addr v0, v1

    const/4 v1, 0x0    # 0.0f

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->radius(F)F

    move-result v1

    const/4 v2, 0x0

    invoke-static {v0, v2, v2, v1}, Lcom/mrkeyboard/app/MrTools;->rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    return-object v0
.end method

.method static shotTab(Landroid/widget/TextView;Z)V
    .locals 3

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-virtual {p0, v0}, Landroid/view/View;->setAlpha(F)V

    if-eqz p1, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->panelBg()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    const-string v2, "panel_tab_on_text"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v2

    goto :goto_0

    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->tabOffBg()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    const-string v2, "panel_tab_off_text"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v2

    :goto_0
    invoke-virtual {p0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrTools;->tintColor(Landroid/widget/TextView;I)V

    return-void
.end method

.method static cardBg()Landroid/graphics/drawable/Drawable;
    .locals 3

    const-string v0, "panel_card"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->flatBar()Z

    move-result v1

    if-eqz v1, :cond_cb_go

    const-string v0, "panel_btn"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    :cond_cb_go
    const/high16 v1, 0x40000000    # 2.0f

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->radius(F)F

    move-result v1

    const/4 v2, 0x0

    invoke-static {v0, v2, v2, v1}, Lcom/mrkeyboard/app/MrTools;->rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    return-object v0
.end method

.method static selFill()Landroid/graphics/drawable/Drawable;
    .locals 3

    const-string v0, "sel_card"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    const/high16 v1, 0x40000000    # 2.0f

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->radius(F)F

    move-result v1

    const/4 v2, 0x0

    invoke-static {v0, v2, v2, v1}, Lcom/mrkeyboard/app/MrTools;->rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    return-object v0
.end method

# Button background: p0 = background color, p1 = border color (1 dp), p2 = text or icon color, p3 = radius (px).
# On touch, the background blends 18% with the text color. The colors come from the theme roles (MrTheme.color).
.method static roleBg(IIIF)Landroid/graphics/drawable/Drawable;
    .locals 7

    sget v0, Lcom/mrkeyboard/app/MrTools;->sPad:I

    div-int/lit8 v0, v0, 0xa

    invoke-static {p0, p1, v0, p3}, Lcom/mrkeyboard/app/MrTools;->rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    new-instance v2, Landroid/animation/ArgbEvaluator;

    invoke-direct {v2}, Landroid/animation/ArgbEvaluator;-><init>()V

    const v3, 0x3e3851ec    # 0.18f

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v2, v3, v4, v5}, Landroid/animation/ArgbEvaluator;->evaluate(FLjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-static {v2, p1, v0, p3}, Lcom/mrkeyboard/app/MrTools;->rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v2

    new-instance v3, Landroid/graphics/drawable/StateListDrawable;

    invoke-direct {v3}, Landroid/graphics/drawable/StateListDrawable;-><init>()V

    const/4 v4, 0x1

    new-array v4, v4, [I

    const/4 v5, 0x0

    const v6, 0x10100a7

    aput v6, v4, v5

    invoke-virtual {v3, v4, v2}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    new-array v4, v5, [I

    invoke-virtual {v3, v4, v1}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    return-object v3
.end method

.method static fabBg()Landroid/graphics/drawable/Drawable;
    .locals 4

    const-string v0, "attach_fab"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    const-string v1, "attach_fab_stroke"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    const-string v2, "attach_fab_icon"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v2

    const v3, 0x447a0000    # 1000.0f

    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrTools;->roleBg(IIIF)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

# Background of the "Digite aqui para traduzir" (type here to translate) field: the theme's panel_field color
# (transparent by default, so the keyboard background shows through), a 1.5 dp border in the accent color with
# alpha_btn, or in the theme's panel_field_stroke when it declares one, and the same corners as the buttons
# (radius(0) = 8 dp).
.method static fieldBg()Landroid/graphics/drawable/Drawable;
    .locals 5

    sget v0, Lcom/mrkeyboard/app/MrTools;->sPad:I

    int-to-float v1, v0

    const v2, 0x3e19999a    # 0.15f: sPad is 10 dp, so this is 1.5 dp in pixels

    mul-float/2addr v1, v2

    const/high16 v2, 0x3f000000    # 0.5f (rounds to the nearest pixel)

    add-float/2addr v1, v2

    float-to-int v1, v1

    const/4 v2, 0x0    # 0.0f: radius(0) = 8 dp

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTools;->radius(F)F

    move-result v2

    const-string v0, "panel_field"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    # the outline: the theme's own (role panel_field_stroke), or the accent at alpha_btn
    const-string v3, "panel_field_stroke"

    invoke-static {v3}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_mr_stroke

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->accent()I

    move-result v3

    const-string v4, "alpha_btn"

    invoke-static {v4}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v4

    or-int/2addr v3, v4

    :cond_mr_stroke
    invoke-static {v0, v3, v1, v2}, Lcom/mrkeyboard/app/MrTools;->rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    return-object v0
.end method

# Background of the buttons inside the tools (back, language, attachments, clear...): see softBg.
.method static panelBg()Landroid/graphics/drawable/Drawable;
    .locals 1

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->softBg()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method static commit(Ljava/lang/String;)V
    .locals 2

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v0

    if-eqz v0, :cond_end

    invoke-interface {v0}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    const/4 v1, 0x1

    invoke-interface {v0, p0, v1}, Landroid/view/inputmethod/InputConnection;->commitText(Ljava/lang/CharSequence;I)Z

    :cond_end
    return-void
.end method
# RGB (no alpha) of the highlight keys' fill (Ctrl) in the current theme: the role ctrl_bg of mr_colors.xml.
.method static ctrlBg()I
    .locals 2

    const-string v0, "ctrl_bg"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    const v1, 0xffffff

    and-int/2addr v0, v1

    return v0
.end method

.method static dupe(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;
    .locals 1

    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object v0

    if-nez v0, :cond_1

    const/4 v0, 0x0

    return-object v0

    :cond_1
    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable$ConstantState;->newDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method private static enterTranslate()V
    .locals 3

        # If the "Personalizar teclado" (customize keyboard) panel is open, closes it to show the keyboard again.
    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->close()V

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->mrCommit()V

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sBarMain:Landroid/view/View;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sBarT:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sField:Landroid/widget/TextView;

    const-string v2, ""

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    sput-object v0, Lcom/mrkeyboard/app/MrTools;->sInsText:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrTools;->sLastKey:Ljava/lang/String;

    sget v2, Lcom/mrkeyboard/app/MrTools;->sSeq:I

    add-int/lit8 v2, v2, 0x1

    sput v2, Lcom/mrkeyboard/app/MrTools;->sSeq:I

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;

    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sDeb:Lcom/mrkeyboard/app/MrTools;

    invoke-virtual {v0, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    new-instance v0, Landroid/view/inputmethod/EditorInfo;

    invoke-direct {v0}, Landroid/view/inputmethod/EditorInfo;-><init>()V

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->onCreateInputConnection(Landroid/view/inputmethod/EditorInfo;)Landroid/view/inputmethod/InputConnection;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrTools;->sRedirect:Landroid/view/inputmethod/InputConnection;

    invoke-virtual {v1}, Landroid/view/View;->requestFocus()Z

    return-void
.end method
# Opens the "Folhas do teclado" (keyboard sheets) settings page directly (PrefScreenSheets).
.method private static openSheetsPrefs()V
    .locals 3

    :try_start_sheets
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    if-nez v0, :cond_sheets_go

    return-void

    :cond_sheets_go
    const-class v2, Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrNav;->intent(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/LatinIME;->startActivity(Landroid/content/Intent;)V

    :try_end_sheets
    .catch Ljava/lang/Throwable; {:try_start_sheets .. :try_end_sheets} :catch_sheets

    return-void

    :catch_sheets
    move-exception v0

    return-void
.end method

# Updates the "N clips" label next to the back button of the clipboard panel (the text comes from the strings
# mr_tb_clip_count_one / mr_tb_clip_count_many, in the app language).
.method static refreshClipCount()V
    .locals 5
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBtnClipCount:Landroid/widget/TextView;
    if-eqz v0, :cond_no_count
    sget v2, Lcom/mrkeyboard/app/MrTools;->sTextColor:I
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sClips:Ljava/util/ArrayList;
    const/4 v2, 0x0
    if-eqz v1, :cond_size
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I
    move-result v2
    :cond_size
    const/4 v3, 0x1
    if-ne v2, v3, :cond_plural
    const v3, 0x7f0c01d6
    goto :goto_fmt
    :cond_plural
    const v3, 0x7f0c01d7
    :goto_fmt
    invoke-static {v3}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;
    move-result-object v3
    if-eqz v3, :cond_no_count
    const/4 v4, 0x1
    new-array v4, v4, [Ljava/lang/Object;
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v1
    const/4 v2, 0x0
    aput-object v1, v4, v2
    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :cond_no_count
    return-void
.end method

# Locks the height of the clipboard cards: ALWAYS two lines of text + paddings.
# Without it, a 1-line card and a 2-line card measured different heights
# (own font/paddings) and the GridView row ended up uneven.
.method static lockCard(Landroid/widget/TextView;)V
    .locals 4

    if-nez p0, :cond_card_ok

    return-void

    :cond_card_ok
        # at most 2 lines, with "..." at the end of the last one when the text is long
    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setMaxLines(I)V

    sget-object v0, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

        # minimum height = 2 lines + font margin + paddings
        # (do NOT use setMaxHeight: it changes the mMaxMode of the TextView and maxLines
        #  is ignored, letting the text spill and be cut off)
    invoke-virtual {p0}, Landroid/widget/TextView;->getPaint()Landroid/text/TextPaint;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/Paint;->getFontMetricsInt()Landroid/graphics/Paint$FontMetricsInt;

    move-result-object v0

    iget v1, v0, Landroid/graphics/Paint$FontMetricsInt;->top:I

    iget v2, v0, Landroid/graphics/Paint$FontMetricsInt;->ascent:I

    sub-int/2addr v1, v2

    iget v2, v0, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    iget v3, v0, Landroid/graphics/Paint$FontMetricsInt;->descent:I

    sub-int/2addr v2, v3

    add-int/2addr v1, v2

    invoke-virtual {p0}, Landroid/widget/TextView;->getLineHeight()I

    move-result v2

    shl-int/lit8 v2, v2, 0x1

    add-int/2addr v1, v2

    invoke-virtual {p0}, Landroid/view/View;->getPaddingTop()I

    move-result v2

    add-int/2addr v1, v2

    invoke-virtual {p0}, Landroid/view/View;->getPaddingBottom()I

    move-result v2

    add-int/2addr v1, v2

    invoke-virtual {p0, v1}, Landroid/widget/TextView;->setMinHeight(I)V

    return-void
.end method

.method private static fetch(Ljava/lang/String;)Ljava/lang/String;
    .locals 9

    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "https://translate.googleapis.com/translate_a/single?client=gtx&dt=t&sl="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget v4, Lcom/mrkeyboard/app/MrTools;->sSrc:I

    if-nez v4, :cond_hassrc

    const-string v3, "auto"

    goto :goto_src

    :cond_hassrc
    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sLC:[Ljava/lang/String;

    add-int/lit8 v4, v4, -0x1

    aget-object v3, v3, v4

    :goto_src
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "&tl="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sLC:[Ljava/lang/String;

    sget v4, Lcom/mrkeyboard/app/MrTools;->sDst:I

    aget-object v3, v3, v4

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "&q="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "UTF-8"

    invoke-static {p0, v3}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v3, Ljava/net/URL;

    invoke-direct {v3, v0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v3

    check-cast v3, Ljava/net/HttpURLConnection;

    move-object v1, v3

    const/16 v3, 0x2710

    invoke-virtual {v1, v3}, Ljava/net/URLConnection;->setConnectTimeout(I)V

    invoke-virtual {v1, v3}, Ljava/net/URLConnection;->setReadTimeout(I)V

    const-string v3, "User-Agent"

    const-string v4, "Mozilla/5.0"

    invoke-virtual {v1, v3, v4}, Ljava/net/URLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/net/URLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v4

    const-string v5, "UTF-8"

    new-instance v3, Ljava/io/InputStreamReader;

    invoke-direct {v3, v4, v5}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    new-instance v8, Ljava/io/BufferedReader;

    invoke-direct {v8, v3}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    move-object v2, v8

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    :goto_read
    invoke-virtual {v2}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_read_done

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_read

    :cond_read_done
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V

    const/4 v2, 0x0

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lorg/json/JSONArray;

    invoke-direct {v4, v3}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Lorg/json/JSONArray;->getJSONArray(I)Lorg/json/JSONArray;

    move-result-object v4

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    :goto_seg
    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-ge v5, v6, :cond_seg_done

    invoke-virtual {v4, v5}, Lorg/json/JSONArray;->getJSONArray(I)Lorg/json/JSONArray;

    move-result-object v6

    const/4 v7, 0x0

    invoke-virtual {v6, v7}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v5, v5, 0x1

    goto :goto_seg

    :cond_seg_done
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_ret_ok

    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_ret_ok
    return-object v0

    :catchall_0
    move-exception v0

    if-eqz v2, :cond_close_all

    :try_start_1
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_ignore_1

    :catch_ignore_1
    :cond_close_all
    if-eqz v1, :cond_rethrow

    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_rethrow
    throw v0

    :catch_0
    move-exception v0

    if-eqz v2, :cond_close_err

    :try_start_2
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_ignore_2

    :catch_ignore_2
    :cond_close_err
    if-eqz v1, :cond_ret_null

    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_ret_null
    const/4 v0, 0x0

    return-object v0
.end method

.method private static fire()V
    .locals 5

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sField:Landroid/widget/TextView;

    if-eqz v0, :cond_end

    invoke-virtual {v0}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->strOf(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_has

        # Empty input field (user erased everything): removes from the app field the
        # translation that was inserted earlier. Before, it only zeroed the variables and the
        # translation stayed in the field.
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sInsText:Ljava/lang/String;

    if-eqz v1, :cond_cleared

    const-string v1, ""

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->applyResult(Ljava/lang/String;)V

    :cond_cleared
    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sInsText:Ljava/lang/String;

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sLastKey:Ljava/lang/String;

    return-void

    :cond_has
    const/16 v2, 0x5dc

    if-le v1, v2, :cond_len

    const v1, 0x7f0c01c0

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V

    return-void

    :cond_len
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "|"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget v2, Lcom/mrkeyboard/app/MrTools;->sSrc:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, "|"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget v2, Lcom/mrkeyboard/app/MrTools;->sDst:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sLastKey:Ljava/lang/String;

    if-eqz v2, :cond_new

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_new

    return-void

    :cond_new
    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sLastKey:Ljava/lang/String;

    sget v1, Lcom/mrkeyboard/app/MrTools;->sSeq:I

    add-int/lit8 v1, v1, 0x1

    sput v1, Lcom/mrkeyboard/app/MrTools;->sSeq:I

    new-instance v2, Lcom/mrkeyboard/app/MrTools;

    const/16 v3, 0xc

    invoke-direct {v2, v3, v0}, Lcom/mrkeyboard/app/MrTools;-><init>(ILjava/lang/String;)V

    iput v1, v2, Lcom/mrkeyboard/app/MrTools;->mSeq:I

    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sTranslateExec:Ljava/util/concurrent/ExecutorService;
    if-eqz v3, :cond_end
    invoke-interface {v3, v2}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    :cond_end
    return-void
.end method

.method static hint(Landroid/view/View;Ljava/lang/String;)V
    .locals 2

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sget v1, Lcom/mrkeyboard/app/MrTools;->sHint:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tintColor(Landroid/widget/TextView;I)V

    return-void
.end method

.method private static sysSrc()I
    .locals 4

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Configuration;->getLocales()Landroid/os/LocaleList;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/LocaleList;->get(I)Ljava/util/Locale;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sLC:[Ljava/lang/String;

    const/4 v2, 0x0

    :goto_sys
    array-length v3, v1

    if-ge v2, v3, :cond_none

    aget-object v3, v1, v2

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_found

    add-int/lit8 v2, v2, 0x1

    goto :goto_sys

    :cond_found
    sget v3, Lcom/mrkeyboard/app/MrTools;->sDst:I

    if-eq v2, v3, :cond_none

    add-int/lit8 v2, v2, 0x1

    return v2

    :cond_none
    const/4 v2, 0x0

    return v2
.end method

.method private static init(Landroid/content/Context;)V
    .locals 6

    sget-boolean v0, Lcom/mrkeyboard/app/MrTools;->sInited:Z

    if-eqz v0, :cond_start

    return-void

    :cond_start
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrTools;->sInited:Z

    const-string v0, "mr_toolbar"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrTools;->sPrefs:Landroid/content/SharedPreferences;

    const-string v1, "clip_on"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    sput-boolean v1, Lcom/mrkeyboard/app/MrTools;->sClipOn:Z

    const-string v1, "bar_on"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    sput-boolean v1, Lcom/mrkeyboard/app/MrTools;->sBarOn:Z

    const-string v1, "dst"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    if-ltz v1, :cond_baddst

    const/16 v2, 0x8

    if-lt v1, v2, :cond_gooddst

    :cond_baddst
    const/4 v1, 0x1

    :cond_gooddst
    sput v1, Lcom/mrkeyboard/app/MrTools;->sDst:I

    const-string v1, "src"

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->sysSrc()I

    move-result v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    if-ltz v1, :cond_badsrc

    const/16 v2, 0x9

    if-lt v1, v2, :cond_goodsrc

    :cond_badsrc
    const/4 v1, 0x0

    :cond_goodsrc
    sput v1, Lcom/mrkeyboard/app/MrTools;->sSrc:I

    const-string v1, "clip_cols"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    const/4 v2, 0x2

    if-eq v1, v2, :cond_goodcols

    const/4 v1, 0x1

    :cond_goodcols
    sput v1, Lcom/mrkeyboard/app/MrTools;->sCols:I

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sClips:Ljava/util/ArrayList;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sClipTs:Ljava/util/ArrayList;

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->loadClips()V

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sNamesOut:Ljava/util/ArrayList;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    sput-object v2, Lcom/mrkeyboard/app/MrTools;->sNamesIn:Ljava/util/ArrayList;

    const v3, 0x7f0c01c1

    invoke-static {v3}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sLN:[Ljava/lang/String;

    const/4 v4, 0x0

    :goto_names
    array-length v5, v3

    if-ge v4, v5, :cond_names_done

    aget-object v5, v3, v4

    invoke-virtual {v1, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v4, v4, 0x1

    goto :goto_names

    :cond_names_done
    new-instance v1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;
    const/4 v1, 0x1
    invoke-static {v1, v1}, Lcom/mrkeyboard/app/MrWorkPools;->latest(II)Ljava/util/concurrent/ExecutorService;
    move-result-object v1
    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sTranslateExec:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/mrkeyboard/app/MrTools;

    const/16 v2, 0xe

    const/4 v3, 0x0

    invoke-direct {v1, v2, v3}, Lcom/mrkeyboard/app/MrTools;-><init>(ILjava/lang/String;)V

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sDeb:Lcom/mrkeyboard/app/MrTools;

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "clipboard"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/content/ClipboardManager;

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sCm:Landroid/content/ClipboardManager;

    if-eqz v1, :cond_cm_done

    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sClipListener:Lcom/mrkeyboard/app/MrTools;

    if-nez v2, :cond_cm_done

    new-instance v2, Lcom/mrkeyboard/app/MrTools;

    const/16 v3, 0x9

    const/4 v4, 0x0

    invoke-direct {v2, v3, v4}, Lcom/mrkeyboard/app/MrTools;-><init>(ILjava/lang/String;)V

    sput-object v2, Lcom/mrkeyboard/app/MrTools;->sClipListener:Lcom/mrkeyboard/app/MrTools;

    invoke-virtual {v1, v2}, Landroid/content/ClipboardManager;->addPrimaryClipChangedListener(Landroid/content/ClipboardManager$OnPrimaryClipChangedListener;)V

    :cond_cm_done
    return-void
.end method

.method private static langChanged()V
    .locals 2

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->refreshLang()V

    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrTools;->sLastKey:Ljava/lang/String;

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->fire()V

    return-void
.end method

.method static layoutId(Landroid/content/Context;Ljava/lang/String;)I
    .locals 3

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "layout"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method private static leave(Z)V
    .locals 3

    if-eqz p0, :cond_nocommit

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sRedirect:Landroid/view/inputmethod/InputConnection;

    if-eqz v0, :cond_nocommit

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->mrCommit()V

    :cond_nocommit
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrTools;->sRedirect:Landroid/view/inputmethod/InputConnection;

    sput-object v0, Lcom/mrkeyboard/app/MrTools;->sInsText:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrTools;->sLastKey:Ljava/lang/String;

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;

    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sDeb:Lcom/mrkeyboard/app/MrTools;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    sget v1, Lcom/mrkeyboard/app/MrTools;->sSeq:I

    add-int/lit8 v1, v1, 0x1

    sput v1, Lcom/mrkeyboard/app/MrTools;->sSeq:I

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sField:Landroid/widget/TextView;

    const-string v2, ""

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sBarT:Landroid/view/View;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void
.end method

.method private static loadClips()V
    .locals 12

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sPrefs:Landroid/content/SharedPreferences;

    const-string v1, "clips"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_done

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    const-wide/32 v10, 0x241c9c80

    sub-long v10, v6, v10

    sget-object v4, Lcom/mrkeyboard/app/MrTools;->sClips:Ljava/util/ArrayList;

    sget-object v5, Lcom/mrkeyboard/app/MrTools;->sClipTs:Ljava/util/ArrayList;

    :try_start_0
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1, v0}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    const/4 v2, 0x0

    :goto_load
    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-ge v2, v3, :cond_done

    invoke-virtual {v1, v2}, Lorg/json/JSONArray;->get(I)Ljava/lang/Object;

    move-result-object v3

    instance-of v0, v3, Lorg/json/JSONArray;

    if-eqz v0, :cond_legacy

    check-cast v3, Lorg/json/JSONArray;

    const/4 v0, 0x0

    invoke-virtual {v3, v0}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v0

    const/4 v9, 0x1

    invoke-virtual {v3, v9, v6, v7}, Lorg/json/JSONArray;->optLong(IJ)J

    move-result-wide v8

    goto :cond_ttl

    :cond_legacy
    invoke-virtual {v1, v2}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v0

    move-wide v8, v6

    :cond_ttl
    cmp-long v3, v8, v10

    if-ltz v3, :cond_skip

    if-eqz v0, :cond_skip

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    invoke-virtual {v5, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_skip
    add-int/lit8 v2, v2, 0x1

    goto :goto_load

    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception v0

    :cond_done
    return-void
.end method

.method private static notifyAdapter()V
    .locals 1

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sAdapter:Lcom/mrkeyboard/app/MrToolsAdp;

    if-eqz v0, :cond_end

    invoke-virtual {v0}, Landroid/widget/ArrayAdapter;->notifyDataSetChanged()V

    :cond_end
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->refreshClipCount()V

    return-void
.end method

.method public static reset()V
    .locals 1

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->close()V

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    if-eqz v0, :cond_end

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarT:Landroid/view/View;

    if-eqz v0, :cond_end

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarMain:Landroid/view/View;

    if-eqz v0, :cond_end

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sField:Landroid/widget/TextView;

    if-eqz v0, :cond_end

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->leave(Z)V

    :cond_end
    return-void
.end method

.method private static refreshLang()V
    .locals 5

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBtnLang:Landroid/widget/TextView;

    if-eqz v0, :cond_end

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget v2, Lcom/mrkeyboard/app/MrTools;->sSrc:I

    if-nez v2, :cond_hassrc

    const-string v3, "AUTO"

    goto :goto_src

    :cond_hassrc
    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sLC:[Ljava/lang/String;

    add-int/lit8 v2, v2, -0x1

    aget-object v3, v3, v2

    invoke-virtual {v3}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v3

    :goto_src
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " \u2192 "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sLC:[Ljava/lang/String;

    sget v4, Lcom/mrkeyboard/app/MrTools;->sDst:I

    aget-object v3, v3, v4

    invoke-virtual {v3}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_end
    return-void
.end method

.method private static refreshSwitch()V
    .locals 4

    sget-boolean v0, Lcom/mrkeyboard/app/MrTools;->sClipOn:Z

    if-eqz v0, :cond_0

    const v1, 0x7f0c01c2

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v1

    const/high16 v2, 0x3f800000    # 1.0f

    goto :goto_0

    :cond_0
    const v1, 0x7f0c01c3

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v1

    const/high16 v2, 0x3f000000    # 0.5f

    :goto_0
    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sBtnClipSw:Landroid/widget/TextView;

    if-eqz v3, :cond_1

    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {v3, v2}, Landroid/view/View;->setAlpha(F)V

    :cond_1
    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sBtnClipTop:Landroid/widget/TextView;

    if-eqz v3, :cond_2

    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setAlpha(F)V

    :cond_2
    return-void
.end method

.method private static saveClips()V
    .locals 6

    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sClips:Ljava/util/ArrayList;

    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sClipTs:Ljava/util/ArrayList;

    const/4 v3, 0x0

    :goto_save
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-ge v3, v4, :cond_out

    new-instance v5, Lorg/json/JSONArray;

    invoke-direct {v5}, Lorg/json/JSONArray;-><init>()V

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v5, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v5, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    invoke-virtual {v0, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    add-int/lit8 v3, v3, 0x1

    goto :goto_save

    :cond_out
    invoke-virtual {v0}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "clips"

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method private static savePrefBool(Ljava/lang/String;Z)V
    .locals 2

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0, p0, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method private static savePrefInt(Ljava/lang/String;I)V
    .locals 2

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0, p0, p1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method public static sendKey(I)Z
    .locals 4

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sRedirect:Landroid/view/inputmethod/InputConnection;

    if-eqz v0, :cond_no

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sField:Landroid/widget/TextView;

    if-eqz v0, :cond_no

    new-instance v1, Landroid/view/KeyEvent;

    const/4 v2, 0x0

    invoke-direct {v1, v2, p0}, Landroid/view/KeyEvent;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/view/View;->dispatchKeyEvent(Landroid/view/KeyEvent;)Z

    new-instance v1, Landroid/view/KeyEvent;

    const/4 v3, 0x1

    invoke-direct {v1, v3, p0}, Landroid/view/KeyEvent;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/view/View;->dispatchKeyEvent(Landroid/view/KeyEvent;)Z

    return v3

    :cond_no
    const/4 v0, 0x0

    return v0
.end method

.method private static setupList(Landroid/view/View;Ljava/lang/String;Ljava/util/ArrayList;II)Lcom/mrkeyboard/app/MrToolsAdp;
    .locals 4

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/AbsListView;

    new-instance v1, Lcom/mrkeyboard/app/MrToolsAdp;

    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    sget v3, Lcom/mrkeyboard/app/MrTools;->sItemLay:I

    invoke-direct {v1, v2, v3, p2}, Lcom/mrkeyboard/app/MrToolsAdp;-><init>(Landroid/content/Context;ILjava/util/List;)V

    iput p3, v1, Lcom/mrkeyboard/app/MrToolsAdp;->mSel:I

    invoke-virtual {v0, v1}, Landroid/widget/AbsListView;->setAdapter(Landroid/widget/ListAdapter;)V

    new-instance v2, Lcom/mrkeyboard/app/MrTools;

    const/4 v3, 0x0

    invoke-direct {v2, p4, v3}, Lcom/mrkeyboard/app/MrTools;-><init>(ILjava/lang/String;)V

    invoke-virtual {v0, v2}, Landroid/widget/AdapterView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    return-object v1
.end method
.method private static sheetPadding(Landroid/view/View;Ljava/lang/String;)V
    .locals 7

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    instance-of v2, v1, Landroid/view/ViewGroup$MarginLayoutParams;

    if-eqz v2, :cond_0

    check-cast v1, Landroid/view/ViewGroup$MarginLayoutParams;

    iget v2, v1, Landroid/view/ViewGroup$MarginLayoutParams;->leftMargin:I

    iget v3, v1, Landroid/view/ViewGroup$MarginLayoutParams;->topMargin:I

    iget v4, v1, Landroid/view/ViewGroup$MarginLayoutParams;->rightMargin:I

    iget v5, v1, Landroid/view/ViewGroup$MarginLayoutParams;->bottomMargin:I

    const/4 v6, 0x0

    invoke-virtual {v1, v6, v6, v6, v6}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {v0, v2, v3, v4, v5}, Landroid/view/View;->setPadding(IIII)V

    :cond_0
    return-void
.end method

.method static fitHeight(Landroid/view/View;I)V
    .locals 3

    invoke-virtual {p0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    instance-of v1, v0, Landroid/view/ViewGroup$MarginLayoutParams;

    if-eqz v1, :cond_fh_set

    move-object v1, v0

    check-cast v1, Landroid/view/ViewGroup$MarginLayoutParams;

    iget v2, v1, Landroid/view/ViewGroup$MarginLayoutParams;->topMargin:I

    sub-int/2addr p1, v2

    iget v2, v1, Landroid/view/ViewGroup$MarginLayoutParams;->bottomMargin:I

    sub-int/2addr p1, v2

    :cond_fh_set
    iput p1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-virtual {p0}, Landroid/view/View;->requestLayout()V

    return-void
.end method

.method static showPanel(I)V
    .locals 6

    invoke-static {p0}, Lcom/mrkeyboard/app/MrTune;->onPanel(I)V

    invoke-static {p0}, Lcom/mrkeyboard/app/MrFonts;->onPanel(I)V

    invoke-static {p0}, Lcom/mrkeyboard/app/MrTools;->shotsMode(I)V

    invoke-static {p0}, Lcom/mrkeyboard/app/MrTools;->emoteMode(I)V

    const/16 v1, 0x8

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eq p0, v3, :cond_0

    const/4 v3, 0x2

    if-ne p0, v3, :cond_2

    :cond_0
    sget-object v4, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    invoke-virtual {v4}, Landroid/view/View;->getVisibility()I

    move-result v5

    if-nez v5, :cond_2

    invoke-virtual {v4}, Landroid/view/View;->getHeight()I

    move-result v5

    if-lez v5, :cond_2

    const/4 v3, 0x1

    if-ne p0, v3, :cond_1

    sget-object v4, Lcom/mrkeyboard/app/MrTools;->sPClip:Landroid/view/View;

    goto :goto_0

    :cond_1
    sget-object v4, Lcom/mrkeyboard/app/MrTools;->sPLang:Landroid/view/View;

    :goto_0
    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrTools;->fitHeight(Landroid/view/View;I)V

    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sPClip:Landroid/view/View;

    const/4 v3, 0x1

    if-ne p0, v3, :cond_3

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_3
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_1
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sPLang:Landroid/view/View;

    const/4 v3, 0x2

    if-ne p0, v3, :cond_4

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_2

    :cond_4
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_2
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    if-nez p0, :cond_5

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_3

    :cond_5
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_3
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarMain:Landroid/view/View;

    sget-object v4, Lcom/mrkeyboard/app/MrTools;->sBarC:Landroid/view/View;

    const/4 v3, 0x1

    if-ne p0, v3, :cond_6

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    if-eqz v4, :cond_8

    invoke-virtual {v4, v2}, Landroid/view/View;->setVisibility(I)V

    invoke-static {p0}, Lcom/mrkeyboard/app/MrFonts;->afterPanel(I)V

    return-void

    :cond_6
    if-eqz v4, :cond_7

    invoke-virtual {v4, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_7
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    :cond_8
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFonts;->afterPanel(I)V

    return-void
.end method
# Soft button background: the accent color (accent()) with the theme's alpha_btn, no border, 8 dp corners
# (radius(0)); on touch, the same color with alpha_press.
.method static softBg()Landroid/graphics/drawable/Drawable;
    .locals 6

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->accent()I

    move-result v0

    const-string v1, "alpha_press"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    or-int/2addr v1, v0

    const-string v2, "alpha_btn"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v2

    or-int/2addr v0, v2

    const/4 v2, 0x0    # 0.0f

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTools;->radius(F)F

    move-result v2

    const/4 v3, 0x0

    invoke-static {v0, v3, v3, v2}, Lcom/mrkeyboard/app/MrTools;->rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-static {v1, v3, v3, v2}, Lcom/mrkeyboard/app/MrTools;->rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    new-instance v4, Landroid/graphics/drawable/StateListDrawable;

    invoke-direct {v4}, Landroid/graphics/drawable/StateListDrawable;-><init>()V

    const/4 v5, 0x1

    new-array v5, v5, [I

    const v2, 0x10100a7

    aput v2, v5, v3

    invoke-virtual {v4, v5, v1}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    new-array v5, v3, [I

    invoke-virtual {v4, v5, v0}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    return-object v4
.end method

.method static shotsMode(I)V
    .locals 5

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sPShots:Landroid/view/View;

    if-nez v0, :cond_sm_ok

    return-void

    :cond_sm_ok
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sBarS:Landroid/view/View;

    const/4 v2, 0x3

    if-eq p0, v2, :cond_sm_show

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->clearSel()V

    const/16 v2, 0x8

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    if-eqz v1, :cond_sm_end

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_sm_end
    return-void

    :cond_sm_show
    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    invoke-virtual {v3}, Landroid/view/View;->getVisibility()I

    move-result v4

    if-nez v4, :cond_sm_vis

    invoke-virtual {v3}, Landroid/view/View;->getHeight()I

    move-result v4

    if-lez v4, :cond_sm_vis

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrTools;->fitHeight(Landroid/view/View;I)V

    :cond_sm_vis
    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    if-eqz v1, :cond_sm_end2

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_sm_end2
    return-void
.end method

.method static emoteMode(I)V
    .locals 5

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sPEmote:Landroid/view/View;

    if-nez v0, :cond_em_ok

    return-void

    :cond_em_ok
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sBarE:Landroid/view/View;

    const/4 v2, 0x4

    if-eq p0, v2, :cond_em_show

    const/16 v2, 0x8

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    if-eqz v1, :cond_em_end

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_em_end
    return-void

    :cond_em_show
    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v3

    if-eqz v3, :cond_em_norefresh

    invoke-static {}, Lcom/mrkeyboard/app/MrEmotes;->refresh()V

    :cond_em_norefresh
    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    invoke-virtual {v3}, Landroid/view/View;->getVisibility()I

    move-result v4

    if-nez v4, :cond_em_vis

    invoke-virtual {v3}, Landroid/view/View;->getHeight()I

    move-result v4

    if-lez v4, :cond_em_vis

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrTools;->fitHeight(Landroid/view/View;I)V

    :cond_em_vis
    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    if-eqz v1, :cond_em_end2

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_em_end2
    return-void
.end method

.method private static strOf(Ljava/lang/CharSequence;)Ljava/lang/String;
    .locals 1

    if-nez p0, :cond_0

    const-string v0, ""

    return-object v0

    :cond_0
    invoke-interface {p0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;
    .locals 1

    invoke-virtual {p0, p1}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method static tint(Landroid/widget/TextView;)V
    .locals 1

    sget v0, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->tintColor(Landroid/widget/TextView;I)V

    return-void
.end method

.method static tintColor(Landroid/widget/TextView;I)V
    .locals 4

    invoke-virtual {p0}, Landroid/widget/TextView;->getCompoundDrawables()[Landroid/graphics/drawable/Drawable;

    move-result-object v0

    sget-object v1, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    const/4 v2, 0x0

    :goto_loop
    array-length v3, v0

    if-ge v2, v3, :cond_end

    aget-object v3, v0, v2

    if-eqz v3, :cond_next

    invoke-virtual {v3, p1, v1}, Landroid/graphics/drawable/Drawable;->setColorFilter(ILandroid/graphics/PorterDuff$Mode;)V

    :cond_next
    add-int/lit8 v2, v2, 0x1

    goto :goto_loop

    :cond_end
    return-void
.end method

.method private static center(Landroid/view/View;Ljava/lang/String;)V
    .locals 2

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_end

    new-instance v1, Lcom/mrkeyboard/app/MrCenter;

    invoke-direct {v1}, Lcom/mrkeyboard/app/MrCenter;-><init>()V

    invoke-virtual {v0, v1}, Landroid/view/View;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    :cond_end
    return-void
.end method

.method static toast(Ljava/lang/String;)V
    .locals 2

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    if-eqz v0, :toast_done
    const/4 v1, 0x0

    invoke-static {v0, p0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    :toast_done
    return-void
.end method

.method public static wrap(Lcom/mrkeyboard/app/LatinIME;Landroid/view/View;)Landroid/view/View;
    .locals 8

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    sput-object p0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    sput-object p1, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    invoke-static {p1}, Lcom/mrkeyboard/app/MrTheme;->attach(Landroid/view/View;)V

    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrTools;->sRedirect:Landroid/view/inputmethod/InputConnection;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrTools;->init(Landroid/content/Context;)V

    move-object v0, p1

    check-cast v0, Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->getMrKeyTextColor()I

    move-result v1

    sput v1, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    # the color of the labels of the keys, kept apart: the clipboard cards are keys, so what is written on them is not the ink of the
    # background (tool_ink, below), which is the opposite one in a theme of light keys on a dark background
    sput v1, Lcom/mrkeyboard/app/MrTools;->sKeyText:I

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->getMrKeyHintColor()I

    move-result v1

    sput v1, Lcom/mrkeyboard/app/MrTools;->sHint:I

    # A theme whose keys and whose background are of opposite brightness (Chrome: light keys, dark background) declares the
    # ink of what sits on the background, which is not the one of the key labels: the roles tool_ink (text and icons of
    # the bar, the panels and the suggestions, and what decides the dark or light buttons under the keyboard) and tool_hint
    # (their secondary text). 0 = the text and the hint of the layout, as in every other theme.
    const-string v1, "tool_ink"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_mr_ink

    const/high16 v2, -0x1000000

    or-int/2addr v1, v2

    sput v1, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    :cond_mr_ink
    const-string v1, "tool_hint"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_mr_inkh

    const/high16 v2, -0x1000000

    or-int/2addr v1, v2

    sput v1, Lcom/mrkeyboard/app/MrTools;->sHint:I

    :cond_mr_inkh
    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->getMrKeyBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sKeyBg:Landroid/graphics/drawable/Drawable;

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->deriveColors()V

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->density:F

    const/high16 v2, 0x41200000    # 10.0f

    mul-float/2addr v1, v2

    float-to-int v1, v1

    sput v1, Lcom/mrkeyboard/app/MrTools;->sPad:I

    div-int/lit8 v1, v1, 0x2

    sput v1, Lcom/mrkeyboard/app/MrTools;->sPadV:I

    const-string v0, "mr_clip_item"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->layoutId(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrTools;->sItemLay:I

    const-string v0, "mr_toolbar"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->layoutId(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrLocaleCtx;->of(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v1

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/view/LayoutInflater;->cloneInContext(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    sput-object v0, Lcom/mrkeyboard/app/MrTools;->sBarRoot:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->dupe(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    :cond_0
    const-string v1, "b_clip"

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sBtnClipTop:Landroid/widget/TextView;

    const-string v1, "b_trans"

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "b_aied"

    const/16 v2, 0x18

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "clip_back"

    const/4 v2, 0x7

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "clip_count"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sBtnClipCount:Landroid/widget/TextView;

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->refreshClipCount()V

    const-string v1, "clip_sw"

    const/4 v2, 0x2

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sBtnClipSw:Landroid/widget/TextView;

    const-string v1, "clip_clear"

    const/4 v2, 0x3

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "clip_view"

    const/16 v2, 0x12

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sBtnView:Landroid/widget/TextView;

    const-string v1, "l_clip"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/GridView;

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sGridClip:Landroid/widget/GridView;

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyCols()V

    const-string v1, "b_shots"

    const/16 v2, 0x8

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "b_sheets"

    const/16 v2, 0x15

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "b_tune"

    const/16 v2, 0x13

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "b_emote"

    const/16 v2, 0x14

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "b_fonts"

    const/16 v2, 0x19

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "tune_back"

    const/4 v2, -0x1

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "tune_reset"

    const/4 v2, -0x1

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "tune_info"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    sget v2, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTune;->setup(Landroid/view/View;)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrFonts;->setup(Landroid/view/View;)V

    const-string v1, "shot_back"

    const/16 v2, 0x9

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "shot_refresh"

    const/16 v2, 0xa

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "shot_clear_cache"

    const/16 v2, 0x17

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "shot_photos"

    const/16 v2, 0xb

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "shot_videos"

    const/16 v2, 0xc

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "shot_files"

    const/16 v2, 0x16

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "t_lang"

    const/4 v2, 0x5

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sBtnLang:Landroid/widget/TextView;

    const-string v1, "t_back"

    const/4 v2, 0x6

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "t_field"

    const/4 v2, -0x1

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sField:Landroid/widget/TextView;

    sget v2, Lcom/mrkeyboard/app/MrTools;->sHint:I

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setHintTextColor(I)V

    sget v2, Lcom/mrkeyboard/app/MrTools;->sPad:I

    sget v3, Lcom/mrkeyboard/app/MrTools;->sPadV:I

    invoke-virtual {v1, v2, v3, v2, v3}, Landroid/view/View;->setPadding(IIII)V

    new-instance v2, Lcom/mrkeyboard/app/MrTools;

    const/16 v3, 0x11

    const/4 v4, 0x0

    invoke-direct {v2, v3, v4}, Lcom/mrkeyboard/app/MrTools;-><init>(ILjava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->addTextChangedListener(Landroid/text/TextWatcher;)V

    const-string v1, "clip_hint"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->hint(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "clip_empty"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->hint(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "hdr_in"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->hint(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "hdr_out"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->hint(Landroid/view/View;Ljava/lang/String;)V

    # the line between the two language lists: role panel_divider
    const-string v1, "lang_div"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_mr_div

    const-string v2, "panel_divider"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/view/View;->setBackgroundColor(I)V

    :cond_mr_div

    const-string v1, "b_clip"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->center(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "b_trans"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->center(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "b_shots"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->center(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "b_emote"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->center(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "b_sheets"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->center(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "b_tune"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->center(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "b_aied"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->center(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "clip_empty"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->center(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "shot_empty"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->center(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "p_clip"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->sheetPadding(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "p_lang"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->sheetPadding(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "p_shots"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->sheetPadding(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "bar_main"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sBarMain:Landroid/view/View;

    const-string v1, "bar_c"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sBarC:Landroid/view/View;

    const-string v1, "bar_t"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sBarT:Landroid/view/View;

    const-string v1, "p_clip"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sPClip:Landroid/view/View;

    const-string v1, "p_lang"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sPLang:Landroid/view/View;

    const-string v1, "bar_s"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sBarS:Landroid/view/View;

    const-string v1, "p_shots"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sPShots:Landroid/view/View;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->setup(Landroid/view/View;)V

    const-string v1, "bar_e"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sBarE:Landroid/view/View;

    const-string v1, "p_emote"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrTools;->sPEmote:Landroid/view/View;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->sheetPadding(Landroid/view/View;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrEmotes;->setup(Landroid/view/View;)V

    const-string v1, "mr_clip_card"

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrTools;->layoutId(Landroid/content/Context;Ljava/lang/String;)I

    move-result v1

    sput v1, Lcom/mrkeyboard/app/MrTools;->sItemLay:I

    const-string v1, "l_clip"

    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sClips:Ljava/util/ArrayList;

    const/4 v3, -0x1

    const/16 v4, 0xa

    invoke-static {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrTools;->setupList(Landroid/view/View;Ljava/lang/String;Ljava/util/ArrayList;II)Lcom/mrkeyboard/app/MrToolsAdp;

    move-result-object v2

    sput-object v2, Lcom/mrkeyboard/app/MrTools;->sAdapter:Lcom/mrkeyboard/app/MrToolsAdp;

    const/4 v3, 0x1

    iput-boolean v3, v2, Lcom/mrkeyboard/app/MrToolsAdp;->mCard:Z

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/AdapterView;

    new-instance v2, Lcom/mrkeyboard/app/MrTools;

    const/16 v3, 0xb

    const/4 v4, 0x0

    invoke-direct {v2, v3, v4}, Lcom/mrkeyboard/app/MrTools;-><init>(ILjava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/widget/AdapterView;->setOnItemLongClickListener(Landroid/widget/AdapterView$OnItemLongClickListener;)V

    const-string v2, "clip_empty"

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/AdapterView;->setEmptyView(Landroid/view/View;)V

    const-string v1, "mr_clip_item"

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrTools;->layoutId(Landroid/content/Context;Ljava/lang/String;)I

    move-result v1

    sput v1, Lcom/mrkeyboard/app/MrTools;->sItemLay:I

    const-string v1, "l_in"

    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sNamesIn:Ljava/util/ArrayList;

    sget v3, Lcom/mrkeyboard/app/MrTools;->sSrc:I

    const/16 v4, 0xf

    invoke-static {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrTools;->setupList(Landroid/view/View;Ljava/lang/String;Ljava/util/ArrayList;II)Lcom/mrkeyboard/app/MrToolsAdp;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sAdIn:Lcom/mrkeyboard/app/MrToolsAdp;

    const-string v1, "l_out"

    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sNamesOut:Ljava/util/ArrayList;

    sget v3, Lcom/mrkeyboard/app/MrTools;->sDst:I

    const/16 v4, 0x10

    invoke-static {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrTools;->setupList(Landroid/view/View;Ljava/lang/String;Ljava/util/ArrayList;II)Lcom/mrkeyboard/app/MrToolsAdp;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sAdOut:Lcom/mrkeyboard/app/MrToolsAdp;

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->refreshSwitch()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->refreshLang()V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrSugg;->setup(Landroid/view/View;)V

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sBarMain:Landroid/view/View;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBar;->attach(Landroid/view/View;)V

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sBarT:Landroid/view/View;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBar;->attachExtra(Landroid/view/View;)V

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sBarC:Landroid/view/View;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBar;->attachExtra(Landroid/view/View;)V

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sBarS:Landroid/view/View;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBar;->attachExtra(Landroid/view/View;)V

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sBarE:Landroid/view/View;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBar;->attachExtra(Landroid/view/View;)V

    const-string v1, "bar_tune"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBar;->attachExtra(Landroid/view/View;)V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    instance-of v2, v1, Landroid/view/ViewGroup;

    if-eqz v2, :cond_1

    check-cast v1, Landroid/view/ViewGroup;

    invoke-virtual {v1, p1}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    :cond_1
    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrTune;->attach(Landroid/view/ViewGroup;Landroid/view/View;)V

    # a see-through theme: the veil of this new view, without waiting for the window to be shown again (onWindowShown
    # applies it too, when the blur may have changed)
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyTranslucentBlur()V

    return-object v0
.end method

.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 4

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sRedirect:Landroid/view/inputmethod/InputConnection;

    if-eqz v0, :cond_end

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sDeb:Lcom/mrkeyboard/app/MrTools;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    const-wide/16 v2, 0x3e8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_end
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    iget v0, p0, Lcom/mrkeyboard/app/MrTools;->mCode:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBarClose;->onClick(I)V

    const/16 v1, 0x12

    if-ne v0, v1, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->toggleCols()V

    return-void

    :cond_0
    const/16 v1, 0x13

    if-ne v0, v1, :cond_1

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->toggle()V

    return-void

    :cond_1
    const/16 v1, 0x14

    if-ne v0, v1, :cond_2

    const/4 v0, 0x4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void

    :cond_2
    const/16 v1, 0x19

    if-ne v0, v1, :cond_3

    const/4 v0, 0x6

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void

    :cond_3
    const/16 v1, 0x15

    if-ne v0, v1, :cond_4

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->openSheetsPrefs()V

    return-void

    :cond_4
    const/16 v1, 0x18

    if-ne v0, v1, :cond_5

    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->toggle()V

    return-void

    :cond_5
    sparse-switch v0, :sswitch_data_0

    return-void

    :sswitch_0
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sPClip:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_6

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void

    :cond_6
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void

    :sswitch_1
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->enterTranslate()V

    return-void

    :sswitch_2
    sget-boolean v0, Lcom/mrkeyboard/app/MrTools;->sClipOn:Z

    if-eqz v0, :cond_7

    const/4 v0, 0x0

    goto :goto_0

    :cond_7
    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/mrkeyboard/app/MrTools;->sClipOn:Z

    const-string v1, "clip_on"

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrTools;->savePrefBool(Ljava/lang/String;Z)V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->refreshSwitch()V

    return-void

    :sswitch_3
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sClips:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sClipTs:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->saveClips()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->notifyAdapter()V

    return-void

    :sswitch_4
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sPLang:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_8

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void

    :cond_8
    const/4 v0, 0x2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void

    :sswitch_5
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->leave(Z)V

    return-void

    :sswitch_6
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void

    :sswitch_7
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->open()V

    return-void

    :sswitch_8
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->clearSel()V

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void

    :sswitch_9
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->clearSel()V

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->reload()V

    return-void

    :sswitch_a
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->setVid(Z)V

    return-void

    :sswitch_b
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->setVid(Z)V

    return-void

    :sswitch_c
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->setFiles()V

    return-void

    :sswitch_d
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->clearSel()V

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->clearCaches()V

    return-void

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0x1 -> :sswitch_1
        0x2 -> :sswitch_2
        0x3 -> :sswitch_3
        0x5 -> :sswitch_4
        0x6 -> :sswitch_5
        0x7 -> :sswitch_6
        0x8 -> :sswitch_7
        0x9 -> :sswitch_8
        0xa -> :sswitch_9
        0xb -> :sswitch_a
        0xc -> :sswitch_b
        0x16 -> :sswitch_c
        0x17 -> :sswitch_d
    .end sparse-switch
.end method

.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 3

    iget v0, p0, Lcom/mrkeyboard/app/MrTools;->mCode:I

    const/16 v1, 0xf

    if-eq v0, v1, :cond_in

    const/16 v1, 0x10

    if-eq v0, v1, :cond_out

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sClips:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge p3, v1, :cond_end

    invoke-virtual {v0, p3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->commit(Ljava/lang/String;)V

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    :cond_end
    return-void

    :cond_in
    sput p3, Lcom/mrkeyboard/app/MrTools;->sSrc:I

    const-string v0, "src"

    invoke-static {v0, p3}, Lcom/mrkeyboard/app/MrTools;->savePrefInt(Ljava/lang/String;I)V

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sAdIn:Lcom/mrkeyboard/app/MrToolsAdp;

    iput p3, v0, Lcom/mrkeyboard/app/MrToolsAdp;->mSel:I

    invoke-virtual {v0}, Landroid/widget/ArrayAdapter;->notifyDataSetChanged()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->langChanged()V

    return-void

    :cond_out
    sput p3, Lcom/mrkeyboard/app/MrTools;->sDst:I

    const-string v0, "dst"

    invoke-static {v0, p3}, Lcom/mrkeyboard/app/MrTools;->savePrefInt(Ljava/lang/String;I)V

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sAdOut:Lcom/mrkeyboard/app/MrToolsAdp;

    iput p3, v0, Lcom/mrkeyboard/app/MrToolsAdp;->mSel:I

    invoke-virtual {v0}, Landroid/widget/ArrayAdapter;->notifyDataSetChanged()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->langChanged()V

    return-void
.end method

.method public onItemLongClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)Z
    .locals 2

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sClips:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge p3, v1, :cond_end

    invoke-virtual {v0, p3}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sClipTs:Ljava/util/ArrayList;

    invoke-virtual {v1, p3}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->saveClips()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->notifyAdapter()V

    :cond_end
    const/4 v0, 0x1

    return v0
.end method

.method public onPrimaryClipChanged()V
    .locals 8
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;
    if-nez v0, :clipboard_live
    return-void
    :clipboard_live

    sget-boolean v0, Lcom/mrkeyboard/app/MrTools;->sClipOn:Z

    if-eqz v0, :cond_end

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sCm:Landroid/content/ClipboardManager;

    if-eqz v0, :cond_end

    invoke-virtual {v0}, Landroid/content/ClipboardManager;->getPrimaryClip()Landroid/content/ClipData;

    move-result-object v0

    if-eqz v0, :cond_end

    invoke-virtual {v0}, Landroid/content/ClipData;->getDescription()Landroid/content/ClipDescription;

    move-result-object v1

    if-eqz v1, :cond_not_sensitive

    invoke-virtual {v1}, Landroid/content/ClipDescription;->getExtras()Landroid/os/PersistableBundle;

    move-result-object v2

    if-eqz v2, :cond_not_sensitive

    const-string v3, "android.content.extra.IS_SENSITIVE"

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Landroid/os/PersistableBundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    if-nez v2, :cond_end

    :cond_not_sensitive
    if-eqz v1, :cond_lbl_ok

    invoke-virtual {v1}, Landroid/content/ClipDescription;->getLabel()Ljava/lang/CharSequence;

    move-result-object v1

    if-eqz v1, :cond_lbl_ok

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "mr_shot"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_end

    :cond_lbl_ok
    invoke-virtual {v0}, Landroid/content/ClipData;->getItemCount()I

    move-result v1

    if-lez v1, :cond_end

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/content/ClipData;->getItemAt(I)Landroid/content/ClipData$Item;

    move-result-object v0

    if-eqz v0, :cond_end

    invoke-virtual {v0}, Landroid/content/ClipData$Item;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->strOf(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_end

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sClips:Ljava/util/ArrayList;

    sget-object v4, Lcom/mrkeyboard/app/MrTools;->sClipTs:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->indexOf(Ljava/lang/Object;)I

    move-result v2

    if-ltz v2, :cond_nodup

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    :cond_nodup
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    invoke-static {v5, v6}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v7

    const/4 v2, 0x0

    invoke-virtual {v1, v2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    invoke-virtual {v4, v2, v7}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    :goto_trim
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/16 v3, 0x32

    if-le v2, v3, :cond_trim_done

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    goto :goto_trim

    :cond_trim_done
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->saveClips()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->notifyAdapter()V

    :cond_end
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public run()V
    .locals 4

    iget v0, p0, Lcom/mrkeyboard/app/MrTools;->mSession:I
    sget v1, Lcom/mrkeyboard/app/MrTools;->sSession:I
    if-eq v0, v1, :session_current
    return-void
    :session_current
    iget v0, p0, Lcom/mrkeyboard/app/MrTools;->mCode:I

    const/16 v1, 0xc

    if-ne v0, v1, :cond_not_bg

    iget-object v0, p0, Lcom/mrkeyboard/app/MrTools;->mText:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->fetch(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/MrTools;

    const/16 v2, 0xd

    invoke-direct {v1, v2, v0}, Lcom/mrkeyboard/app/MrTools;-><init>(ILjava/lang/String;)V

    iget v2, p0, Lcom/mrkeyboard/app/MrTools;->mSeq:I

    iput v2, v1, Lcom/mrkeyboard/app/MrTools;->mSeq:I
    iget v2, p0, Lcom/mrkeyboard/app/MrTools;->mSession:I
    iput v2, v1, Lcom/mrkeyboard/app/MrTools;->mSession:I

    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;

    invoke-virtual {v2, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

    :cond_not_bg
    const/16 v1, 0xe

    if-ne v0, v1, :cond_ui

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->fire()V

    return-void

    :cond_ui
    iget v1, p0, Lcom/mrkeyboard/app/MrTools;->mSeq:I

    sget v2, Lcom/mrkeyboard/app/MrTools;->sSeq:I

    if-eq v1, v2, :cond_fresh

    return-void

    :cond_fresh
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTools;->mText:Ljava/lang/String;

    if-nez v0, :cond_ok

    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sLastKey:Ljava/lang/String;

    const v0, 0x7f0c01c4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V

    return-void

    :cond_ok
    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->applyResult(Ljava/lang/String;)V

    return-void
.end method

.method static str(I)Ljava/lang/String;
    .locals 2

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    if-eqz v0, :cond_null

    invoke-static {v0}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_null

    invoke-virtual {v0, p0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    return-object v1

    :cond_null
    const/4 v0, 0x0

    return-object v0
.end method

.method static release(Lcom/mrkeyboard/app/LatinIME;)V
 .locals 3
 sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;
 if-ne v0, p0, :done
 sget v0, Lcom/mrkeyboard/app/MrTools;->sSession:I
 add-int/lit8 v0, v0, 0x1
 sput v0, Lcom/mrkeyboard/app/MrTools;->sSession:I
 sget v0, Lcom/mrkeyboard/app/MrTools;->sSeq:I
 add-int/lit8 v0, v0, 0x1
 sput v0, Lcom/mrkeyboard/app/MrTools;->sSeq:I
 sget-object v0, Lcom/mrkeyboard/app/MrTools;->sCm:Landroid/content/ClipboardManager;
 sget-object v1, Lcom/mrkeyboard/app/MrTools;->sClipListener:Lcom/mrkeyboard/app/MrTools;
 if-eqz v0, :handler
 if-eqz v1, :handler
 invoke-virtual {v0, v1}, Landroid/content/ClipboardManager;->removePrimaryClipChangedListener(Landroid/content/ClipboardManager$OnPrimaryClipChangedListener;)V
 :handler
 sget-object v0, Lcom/mrkeyboard/app/MrTools;->sHandler:Landroid/os/Handler;
 if-eqz v0, :media
 const/4 v1, 0x0
 invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V
 :media
 sget-object v0, Lcom/mrkeyboard/app/MrTools;->sTranslateExec:Ljava/util/concurrent/ExecutorService;
 if-eqz v0, :translation_stopped
 invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdownNow()Ljava/util/List;
 :translation_stopped
 invoke-static {}, Lcom/mrkeyboard/app/MrShots;->release()V

 invoke-static {}, Lcom/mrkeyboard/app/MrAi;->release()V
 const/4 v0, 0x0
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sTranslateExec:Ljava/util/concurrent/ExecutorService;
 sput-object v0, Lcom/mrkeyboard/app/MrEmotes;->sList:Landroid/widget/ListView;
 sput-object v0, Lcom/mrkeyboard/app/MrEmotes;->sTabs:[Landroid/widget/TextView;
 sput-object v0, Lcom/mrkeyboard/app/MrEmotes;->sBg:[Landroid/graphics/drawable/Drawable;
 sput-object v0, Lcom/mrkeyboard/app/MrEmotes;->sAdp:Lcom/mrkeyboard/app/MrEmoteAdp;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sAdIn:Lcom/mrkeyboard/app/MrToolsAdp;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sAdOut:Lcom/mrkeyboard/app/MrToolsAdp;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sAdapter:Lcom/mrkeyboard/app/MrToolsAdp;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sBtnView:Landroid/widget/TextView;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sGridClip:Landroid/widget/GridView;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sBarC:Landroid/view/View;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sBarE:Landroid/view/View;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sPEmote:Landroid/view/View;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sBarMain:Landroid/view/View;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sBarRoot:Landroid/view/View;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sBarS:Landroid/view/View;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sBarT:Landroid/view/View;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sBtnClipCount:Landroid/widget/TextView;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sBtnClipSw:Landroid/widget/TextView;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sBtnClipTop:Landroid/widget/TextView;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sBtnLang:Landroid/widget/TextView;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sClipListener:Lcom/mrkeyboard/app/MrTools;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sCm:Landroid/content/ClipboardManager;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sDeb:Lcom/mrkeyboard/app/MrTools;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sField:Landroid/widget/TextView;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;
 invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->clear()V
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sKeyBg:Landroid/graphics/drawable/Drawable;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sPClip:Landroid/view/View;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sPShots:Landroid/view/View;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sPLang:Landroid/view/View;
 sput-object v0, Lcom/mrkeyboard/app/MrTools;->sRedirect:Landroid/view/inputmethod/InputConnection;
 sput-boolean v0, Lcom/mrkeyboard/app/MrTools;->sInited:Z
 sput-boolean v0, Lcom/mrkeyboard/app/MrTools;->sBarOn:Z
 sput-boolean v0, Lcom/mrkeyboard/app/MrTools;->sClipOn:Z
 sput-object v0, Lcom/mrkeyboard/app/MrTune;->sPanel:Landroid/view/View;
 sput-object v0, Lcom/mrkeyboard/app/MrTune;->sBar:Landroid/view/View;
 sput-object v0, Lcom/mrkeyboard/app/MrTune;->sList:Ljava/util/ArrayList;
 sput-object v0, Lcom/mrkeyboard/app/MrTune;->sPList:Ljava/util/ArrayList;
 sput-boolean v0, Lcom/mrkeyboard/app/MrTune;->sOn:Z
 sput-boolean v0, Lcom/mrkeyboard/app/MrTune;->sSilent:Z
 invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->release()V
 :done
 return-void
.end method
