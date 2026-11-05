.class public final Lcom/mrkeyboard/app/MrTune;
.super Ljava/lang/Object;
.source "MrTune.java"

# "Customize keyboard" tool: 5 sliders (vertical or horizontal height depending on the orientation,
# bar height, label scale, spacing, rounding). In landscape it appears as a translucent black panel
# inside the keyboard (p_tune, in mr_toolbar); in portrait it opens as a dialog (mr_tune_dialog).
# Each slider writes the same preference as the settings, so the keyboard
# updates in real time through the same path (LatinIME.onSharedPreferenceChanged).
# Exception: the label scale would recreate the keyboard view (and the slider itself)
# at every step; so it is applied straight to the view and only saved on release.

.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;
.implements Landroid/view/View$OnLayoutChangeListener;


# static fields
.field static sList:Ljava/util/ArrayList;

.field static sOn:Z

.field static sPanel:Landroid/view/View;

.field static sBar:Landroid/view/View;

.field static sSilent:Z

.field static sRoot:Landroid/view/View;

.field static sDlg:Landroid/app/Dialog;

.field static sLis:Lcom/mrkeyboard/app/MrTune;

.field static sDList:Ljava/util/ArrayList;

# list of the panel's sliders (sList can be replaced by the dialog's)
.field static sPList:Ljava/util/ArrayList;


# instance fields
.field mIdx:I

.field mSeek:Landroid/widget/SeekBar;

.field mVal:Landroid/widget/TextView;


# direct methods
.method constructor <init>(I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/mrkeyboard/app/MrTune;->mIdx:I

    return-void
.end method

# Fits the keyboard into the "kbd_host" FrameLayout (the panel sits on top of it).
.method static attach(Landroid/view/ViewGroup;Landroid/view/View;)V
    .locals 4

    const-string v0, "kbd_host"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    instance-of v1, v0, Landroid/view/ViewGroup;

    if-eqz v1, :cond_plain

    check-cast v0, Landroid/view/ViewGroup;

    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v2, -0x1

    const/4 v3, -0x2

    invoke-direct {v1, v2, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    const/4 v2, 0x0

    invoke-virtual {v0, p1, v2, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;ILandroid/view/ViewGroup$LayoutParams;)V

    return-void

    :cond_plain
    invoke-virtual {p0, p1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-void
.end method

.method private static bind(Landroid/view/View;ILjava/lang/String;Ljava/lang/String;)V
    .locals 4

    invoke-virtual {p0, p2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p0, p3}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    if-eqz v0, :cond_end

    if-eqz v1, :cond_end

    check-cast v0, Landroid/widget/SeekBar;

    check-cast v1, Landroid/widget/TextView;

    new-instance v2, Lcom/mrkeyboard/app/MrTune;

    invoke-direct {v2, p1}, Lcom/mrkeyboard/app/MrTune;-><init>(I)V

    iput-object v0, v2, Lcom/mrkeyboard/app/MrTune;->mSeek:Landroid/widget/SeekBar;

    iput-object v1, v2, Lcom/mrkeyboard/app/MrTune;->mVal:Landroid/widget/TextView;

    invoke-static {p1}, Lcom/mrkeyboard/app/MrTune;->maxOf(I)I

    move-result v3

    invoke-virtual {v0, v3}, Landroid/widget/ProgressBar;->setMax(I)V

    invoke-virtual {v0, v2}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    sget-object v3, Lcom/mrkeyboard/app/MrTune;->sList:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_end
    return-void
.end method

.method static close()V
    .locals 2

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->dismissDialog()V

    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrTune;->sOn:Z

    sget-object v1, Lcom/mrkeyboard/app/MrTune;->sPanel:Landroid/view/View;

    if-eqz v1, :cond_bar

    const/16 v0, 0x8

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_bar
    sget-object v1, Lcom/mrkeyboard/app/MrTune;->sBar:Landroid/view/View;

    if-eqz v1, :cond_main

    const/16 v0, 0x8

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_main
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    :cond_end
    return-void
.end method

.method private static defOf(I)Ljava/lang/String;
    .locals 2

    const/4 v0, 0x4

    if-ne p0, v0, :cond_d4

    const-string v0, "1.0"

    return-object v0

    :cond_d4

    const/4 v0, 0x1

    if-ne p0, v0, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0c01d1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_2
    const/4 v0, 0x2

    if-ne p0, v0, :cond_3

    const-string v0, "4"

    return-object v0

    :cond_3
    const-string v0, "8"

    return-object v0
.end method

.method private static fmt(IF)Ljava/lang/String;
    .locals 3

    const/4 v0, 0x4

    if-ne p0, v0, :cond_f4

    const/high16 v0, 0x42c80000    # 100.0f

    mul-float/2addr p1, v0

    :cond_f4

    const/4 v0, 0x1

    if-ne p0, v0, :cond_a

    const/high16 v0, 0x42c80000    # 100.0f

    mul-float/2addr p1, v0

    :cond_a
    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const/4 v0, 0x4

    if-eq p0, v0, :cond_pct

    const/4 v0, 0x2

    if-lt p0, v0, :cond_pct

    const-string v0, " dp"

    goto :goto_app

    :cond_pct
    const-string v0, "%"

    :goto_app
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static keyOf(I)Ljava/lang/String;
    .locals 2

    const/4 v0, 0x4

    if-ne p0, v0, :cond_k4

    const-string v0, "pref_bar_scale"

    return-object v0

    :cond_k4

    if-nez p0, :cond_1

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->isLand()Z

    move-result v0

    if-eqz v0, :cond_port

    const-string v0, "settings_height_landscape"

    return-object v0

    :cond_port
    const-string v0, "settings_height_portrait"

    return-object v0

    :cond_1
    const/4 v1, 0x1

    if-ne p0, v1, :cond_2

    const-string v0, "pref_label_scale_v2"

    return-object v0

    :cond_2
    const/4 v1, 0x2

    if-ne p0, v1, :cond_3

    const-string v0, "pref_key_spacing"

    return-object v0

    :cond_3
    const-string v0, "pref_key_radius"

    return-object v0
.end method

# Current orientation (true = horizontal/landscape).
.method private static isLand()Z
    .locals 2

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    if-nez v0, :cond_ok

    const/4 v0, 0x0

    return v0

    :cond_ok
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_no

    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method

# Default height for the current orientation (same resources the keyboard uses).
.method private static heightDef()Ljava/lang/String;
    .locals 2

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->isLand()Z

    move-result v1

    if-eqz v1, :cond_p

    const v1, 0x7f0c0054

    goto :goto_g

    :cond_p
    const v1, 0x7f0c0055

    :goto_g
    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

# Title of the first slider according to the orientation.
.method private static updateTitle()V
    .locals 3

    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sRoot:Landroid/view/View;

    if-nez v0, :cond_a

    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sPanel:Landroid/view/View;

    if-nez v0, :cond_a

    return-void

    :cond_a
    const-string v1, "tl_h"

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    instance-of v1, v0, Landroid/widget/TextView;

    if-nez v1, :cond_b

    return-void

    :cond_b
    check-cast v0, Landroid/widget/TextView;

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->isLand()Z

    move-result v1

    if-eqz v1, :cond_p

    const v1, 0x7f0c01c5

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_t

    :cond_p
    const v1, 0x7f0c01c6

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v1

    :goto_t
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

# Label scale: applies straight to the view (without recreating the keyboard).
.method private static liveLabel(F)V
    .locals 2

    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sKeyboardSettings:Lcom/mrkeyboard/app/GlobalKeyboardSettings;

    iput p0, v0, Lcom/mrkeyboard/app/GlobalKeyboardSettings;->labelScalePref:F

    # the label scale also sizes the icons of the toolbar buttons
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyIconScale()V

    invoke-static {}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInstance()Lcom/mrkeyboard/app/KeyboardSwitcher;

    move-result-object v0

    if-eqz v0, :cond_end

    invoke-virtual {v0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInputView()Lcom/mrkeyboard/app/LatinKeyboardView;

    move-result-object v0

    if-eqz v0, :cond_end

    invoke-virtual {v0, p0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->setMrLabelScale(F)V

    :cond_end
    return-void
.end method

.method private static maxOf(I)I
    .locals 1

    const/4 v0, 0x4

    if-ne p0, v0, :cond_m4

    const/16 v0, 0x12

    return v0

    :cond_m4

    if-nez p0, :cond_1

    const/16 v0, 0x3c

    return v0

    :cond_1
    const/4 v0, 0x1

    if-ne p0, v0, :cond_2

    const/16 v0, 0x64

    return v0

    :cond_2
    const/4 v0, 0x2

    if-ne p0, v0, :cond_3

    const/16 v0, 0x10

    return v0

    :cond_3
    const/16 v0, 0x1e

    return v0
.end method

.method static onPanel(I)V
    .locals 0

    if-eqz p0, :cond_end

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->close()V

    :cond_end
    return-void
.end method

.method private static prefs()Landroid/content/SharedPreferences;
    .locals 1

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method private static readValue(I)F
    .locals 4

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrTune;->keyOf(I)Ljava/lang/String;

    move-result-object v1

    if-nez p0, :cond_other

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->heightDef()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/LatinIME;->getHeight(Landroid/content/SharedPreferences;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    int-to-float v2, v2

    return v2

    :cond_other
    invoke-static {p0}, Lcom/mrkeyboard/app/MrTune;->defOf(I)Ljava/lang/String;

    move-result-object v2

    :try_start_0
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v3

    :catch_0
    move-exception v3

    invoke-static {v2}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v3

    return v3
.end method

.method static refresh()V
    .locals 8

    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sDList:Ljava/util/ArrayList;

    if-nez v0, :cond_has

    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sList:Ljava/util/ArrayList;

    :cond_has
    if-eqz v0, :cond_end

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->updateTitle()V

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x0

    :goto_loop
    if-ge v2, v1, :cond_end

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mrkeyboard/app/MrTune;

    iget v4, v3, Lcom/mrkeyboard/app/MrTune;->mIdx:I

    invoke-static {v4}, Lcom/mrkeyboard/app/MrTune;->readValue(I)F

    move-result v5

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrTune;->toProgress(IF)I

    move-result v6

    iget-object v7, v3, Lcom/mrkeyboard/app/MrTune;->mSeek:Landroid/widget/SeekBar;

    invoke-virtual {v7, v6}, Landroid/widget/ProgressBar;->setProgress(I)V

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrTune;->fmt(IF)Ljava/lang/String;

    move-result-object v6

    iget-object v7, v3, Lcom/mrkeyboard/app/MrTune;->mVal:Landroid/widget/TextView;

    invoke-virtual {v7, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_loop

    :cond_end
    return-void
.end method

.method private static save(IF)V
    .locals 3

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrTune;->keyOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1}, Ljava/lang/Float;->toString(F)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

# Called by LatinIME.onSharedPreferenceChanged: ignores the silent write of the scale.
.method static skip(Ljava/lang/String;)Z
    .locals 2

    sget-boolean v0, Lcom/mrkeyboard/app/MrTune;->sSilent:Z

    if-eqz v0, :cond_no

    const-string v1, "pref_label_scale_v2"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method

.method static setup(Landroid/view/View;)V
    .locals 3

    const-string v0, "p_tune"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrTune;->sPanel:Landroid/view/View;

    # in landscape the panel replaces the dialog: if it was left open (e.g. the screen was rotated), close it
    if-eqz v0, :cond_nodlg

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->isLand()Z

    move-result v1

    if-eqz v1, :cond_nodlg

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->dismissDialog()V

    :cond_nodlg
    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->updateTitle()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrTune;->sList:Ljava/util/ArrayList;

    sput-object v0, Lcom/mrkeyboard/app/MrTune;->sPList:Ljava/util/ArrayList;

    const/4 v0, 0x0

    const-string v1, "sk_h"

    const-string v2, "vl_h"

    invoke-static {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrTune;->bind(Landroid/view/View;ILjava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x1

    const-string v1, "sk_l"

    const-string v2, "vl_l"

    invoke-static {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrTune;->bind(Landroid/view/View;ILjava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x2

    const-string v1, "sk_s"

    const-string v2, "vl_s"

    invoke-static {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrTune;->bind(Landroid/view/View;ILjava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x3

    const-string v1, "sk_r"

    const-string v2, "vl_r"

    invoke-static {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrTune;->bind(Landroid/view/View;ILjava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x4

    const-string v1, "sk_b"

    const-string v2, "vl_b"

    invoke-static {p0, v0, v1, v2}, Lcom/mrkeyboard/app/MrTune;->bind(Landroid/view/View;ILjava/lang/String;Ljava/lang/String;)V

    const-string v0, "tune_back"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_noclose

    new-instance v1, Lcom/mrkeyboard/app/MrTune;

    const/4 v2, -0x1

    invoke-direct {v1, v2}, Lcom/mrkeyboard/app/MrTune;-><init>(I)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_noclose
    const-string v0, "tune_reset"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_noreset

    new-instance v1, Lcom/mrkeyboard/app/MrTune;

    const/4 v2, -0x2

    invoke-direct {v1, v2}, Lcom/mrkeyboard/app/MrTune;-><init>(I)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_noreset
    const-string v0, "bar_tune"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrTune;->sBar:Landroid/view/View;

    # rotated to portrait with the panel open: close it (the panel only exists in landscape)
    sget-boolean v2, Lcom/mrkeyboard/app/MrTune;->sOn:Z

    if-eqz v2, :cond_state

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->isLand()Z

    move-result v1

    if-nez v1, :cond_state

    const/4 v2, 0x0

    sput-boolean v2, Lcom/mrkeyboard/app/MrTune;->sOn:Z

    :cond_state
    const/16 v1, 0x8

    if-eqz v2, :cond_vis

    const/4 v1, 0x0

    :cond_vis
    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sBar:Landroid/view/View;

    if-eqz v0, :cond_nobar

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_nobar
    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sPanel:Landroid/view/View;

    if-eqz v0, :cond_end

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    if-eqz v2, :cond_end

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->refresh()V

    :cond_end
    return-void
.end method

.method private static toProgress(IF)I
    .locals 4

    const/4 v0, 0x4

    if-ne p0, v0, :cond_p4

    const v0, 0x3f19999a    # 0.6f

    sub-float v0, p1, v0

    const v1, 0x3d4ccccd    # 0.05f

    div-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    goto :goto_clamp

    :cond_p4

    const/4 v0, 0x1

    if-ne p0, v0, :cond_lin

    const/high16 v0, 0x40000000    # 2.0f

    mul-float/2addr v0, p1

    float-to-double v0, v0

    invoke-static {v0, v1}, Ljava/lang/Math;->log(D)D

    move-result-wide v0

    const-wide/high16 v2, 0x4010000000000000L    # 4.0

    invoke-static {v2, v3}, Ljava/lang/Math;->log(D)D

    move-result-wide v2

    div-double/2addr v0, v2

    const-wide/high16 v2, 0x4059000000000000L    # 100.0

    mul-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->round(D)J

    move-result-wide v0

    long-to-int v0, v0

    goto :goto_clamp

    :cond_lin
    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result v0

    if-nez p0, :goto_clamp

    add-int/lit8 v0, v0, -0xf

    :goto_clamp
    if-gez v0, :cond_pos

    const/4 v0, 0x0

    :cond_pos
    invoke-static {p0}, Lcom/mrkeyboard/app/MrTune;->maxOf(I)I

    move-result v1

    if-le v0, v1, :cond_done

    move v0, v1

    :cond_done
    return v0
.end method

.method private static toValue(II)F
    .locals 4

    const/4 v0, 0x4

    if-ne p0, v0, :cond_v4

    mul-int/lit8 v0, p1, 0x5

    add-int/lit8 v0, v0, 0x3c

    int-to-float v0, v0

    const/high16 v1, 0x42c80000    # 100.0f

    div-float/2addr v0, v1

    return v0

    :cond_v4

    const/4 v0, 0x1

    if-ne p0, v0, :cond_lin

    int-to-double v0, p1

    const-wide/high16 v2, 0x4059000000000000L    # 100.0

    div-double/2addr v0, v2

    const-wide/high16 v2, 0x4010000000000000L    # 4.0

    invoke-static {v2, v3, v0, v1}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    const-wide/high16 v2, 0x3fe0000000000000L    # 0.5

    mul-double/2addr v0, v2

    const-wide/high16 v2, 0x4059000000000000L    # 100.0

    mul-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->round(D)J

    move-result-wide v0

    long-to-double v0, v0

    const-wide/high16 v2, 0x4059000000000000L    # 100.0

    div-double/2addr v0, v2

    double-to-float v0, v0

    return v0

    :cond_lin
    if-nez p0, :cond_noff

    add-int/lit8 p1, p1, 0xf

    :cond_noff
    int-to-float v0, p1

    return v0
.end method

# "Customize" button: in landscape it opens the panel inside the keyboard (there is little room above it
# for the dialog); in portrait it opens/closes the dialog.
.method static toggle()V
    .locals 2

    :try_start_t
    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->isLand()Z

    move-result v0

    if-eqz v0, :cond_dlg

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->togglePanel()Z

    move-result v0

    if-eqz v0, :cond_dlg

    return-void

    :cond_dlg
    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sDlg:Landroid/app/Dialog;

    if-eqz v0, :cond_open

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v1

    if-eqz v1, :cond_open

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->dismissDialog()V

    return-void

    :cond_open
    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->showDialog()V
    :try_end_t
    .catch Ljava/lang/Throwable; {:try_start_t .. :try_end_t} :catch_t

    return-void

    :catch_t
    move-exception v0

    return-void
.end method

# Opens or closes the panel inside the keyboard. Returns false if the layout has no panel
# (then the toggle falls back to the dialog).
.method private static togglePanel()Z
    .locals 3

    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sPanel:Landroid/view/View;

    sget-object v1, Lcom/mrkeyboard/app/MrTune;->sBar:Landroid/view/View;

    if-eqz v0, :cond_none

    if-eqz v1, :cond_none

    # the dialog does not coexist with the panel
    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->dismissDialog()V

    sget-boolean v2, Lcom/mrkeyboard/app/MrTune;->sOn:Z

    if-eqz v2, :cond_open

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->close()V

    const/4 v0, 0x1

    return v0

    :cond_open
    const/4 v2, 0x1

    sput-boolean v2, Lcom/mrkeyboard/app/MrTune;->sOn:Z

    # the dialog may have swapped sList: go back to the panel's slider list
    sget-object v2, Lcom/mrkeyboard/app/MrTune;->sPList:Ljava/util/ArrayList;

    if-eqz v2, :cond_nolist

    sput-object v2, Lcom/mrkeyboard/app/MrTune;->sList:Ljava/util/ArrayList;

    :cond_nolist
    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->refresh()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    const/4 v0, 0x1

    return v0

    :cond_none
    const/4 v0, 0x0

    return v0
.end method

# Closes the Preferences dialog, if it is open.
.method private static dismissDialog()V
    .locals 3

    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sDlg:Landroid/app/Dialog;

    if-eqz v0, :cond_end

    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrTune;->sDlg:Landroid/app/Dialog;

    sput-object v1, Lcom/mrkeyboard/app/MrTune;->sRoot:Landroid/view/View;

    sput-object v1, Lcom/mrkeyboard/app/MrTune;->sDList:Ljava/util/ArrayList;

    sget-object v2, Lcom/mrkeyboard/app/MrTune;->sLis:Lcom/mrkeyboard/app/MrTune;

    sput-object v1, Lcom/mrkeyboard/app/MrTune;->sLis:Lcom/mrkeyboard/app/MrTune;

    :try_start_d
    if-eqz v2, :cond_nolis

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->imeDecor()Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_nolis

    invoke-virtual {v1, v2}, Landroid/view/View;->removeOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    :cond_nolis
    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V
    :try_end_d
    .catch Ljava/lang/Throwable; {:try_start_d .. :try_end_d} :catch_d

    :cond_end
    return-void

    :catch_d
    move-exception v0

    return-void
.end method

# Root view (decorView) of the keyboard window, or null if it does not exist yet.
.method private static imeDecor()Landroid/view/View;
    .locals 2

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    const/4 v1, 0x0

    if-nez v0, :cond_a

    return-object v1

    :cond_a
    invoke-virtual {v0}, Landroid/inputmethodservice/InputMethodService;->getWindow()Landroid/app/Dialog;

    move-result-object v0

    if-nez v0, :cond_b

    return-object v1

    :cond_b
    invoke-virtual {v0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    if-nez v0, :cond_c

    return-object v1

    :cond_c
    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

# Top of the keyboard in screen coordinates (-1 = unknown: the dialog uses the whole screen).
.method private static imeTop()I
    .locals 3

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->imeDecor()Landroid/view/View;

    move-result-object v0

    const/4 v1, -0x1

    if-nez v0, :cond_a

    return v1

    :cond_a
    const/4 v1, 0x2

    new-array v1, v1, [I

    invoke-virtual {v0, v1}, Landroid/view/View;->getLocationOnScreen([I)V

    const/4 v2, 0x1

    aget v1, v1, v2

    if-gtz v1, :cond_ok

    const/4 v1, -0x1

    :cond_ok
    return v1
.end method

# "Preferences" dialog: same look as the height dialog in the settings (Theme.MrKeyboard.Dialog).
# The window covers only the area between the top of the screen and the keyboard (dark layer + centered card) and
# follows the keyboard height live (onLayoutChange). It is attached to the keyboard window (IME token +
# TYPE_APPLICATION_ATTACHED_DIALOG): it does not need SYSTEM_ALERT_WINDOW and works from API 26 to 36.
# FLAG_NOT_FOCUSABLE keeps focus on the editor without blocking touches on the dialog's controls.
# The sliders write straight away while dragging.
.method private static showDialog()V
    .locals 8

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    if-nez v0, :cond_ime

    return-void

    :cond_ime
    # clears a previous dialog (e.g. closed by the back button) and its listener
    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->dismissDialog()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->imeDecor()Landroid/view/View;

    move-result-object v7

    if-nez v7, :cond_dec

    return-void

    :cond_dec
    invoke-virtual {v7}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v1

    if-nez v1, :cond_tok

    return-void

    :cond_tok
    new-instance v2, Landroid/app/Dialog;

    const v3, 0x7f0d00a1

    invoke-direct {v2, v0, v3}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/app/Dialog;->requestWindowFeature(I)Z

    invoke-virtual {v2}, Landroid/app/Dialog;->getContext()Landroid/content/Context;

    move-result-object v3

    # language chosen in the app (pref_ui_language): without it the layout comes out in the system language,
    # while the height title (MrTools.str) comes out in the app's. Same path as the toolbar.
    invoke-static {v3}, Lcom/mrkeyboard/app/MrLocaleCtx;->of(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v3

    const v4, 0x7f0a0041

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v3

    sput-object v3, Lcom/mrkeyboard/app/MrTune;->sRoot:Landroid/view/View;

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    sput-object v4, Lcom/mrkeyboard/app/MrTune;->sList:Ljava/util/ArrayList;

    const/4 v4, 0x0

    const-string v5, "sk_h"

    const-string v6, "vl_h"

    invoke-static {v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrTune;->bind(Landroid/view/View;ILjava/lang/String;Ljava/lang/String;)V

    const/4 v4, 0x1

    const-string v5, "sk_l"

    const-string v6, "vl_l"

    invoke-static {v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrTune;->bind(Landroid/view/View;ILjava/lang/String;Ljava/lang/String;)V

    const/4 v4, 0x2

    const-string v5, "sk_s"

    const-string v6, "vl_s"

    invoke-static {v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrTune;->bind(Landroid/view/View;ILjava/lang/String;Ljava/lang/String;)V

    const/4 v4, 0x3

    const-string v5, "sk_r"

    const-string v6, "vl_r"

    invoke-static {v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrTune;->bind(Landroid/view/View;ILjava/lang/String;Ljava/lang/String;)V

    const/4 v4, 0x4

    const-string v5, "sk_b"

    const-string v6, "vl_b"

    invoke-static {v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrTune;->bind(Landroid/view/View;ILjava/lang/String;Ljava/lang/String;)V

    # the dialog's own list: the keyboard setup recreates sList when the keyboard view is rebuilt
    sget-object v4, Lcom/mrkeyboard/app/MrTune;->sList:Ljava/util/ArrayList;

    sput-object v4, Lcom/mrkeyboard/app/MrTune;->sDList:Ljava/util/ArrayList;

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->refresh()V

    # a single listener: closes (touch on the dark background or OK) and follows the keyboard layout
    new-instance v4, Lcom/mrkeyboard/app/MrTune;

    const/4 v5, -0x1

    invoke-direct {v4, v5}, Lcom/mrkeyboard/app/MrTune;-><init>(I)V

    sput-object v4, Lcom/mrkeyboard/app/MrTune;->sLis:Lcom/mrkeyboard/app/MrTune;

    invoke-virtual {v3, v4}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const-string v5, "tune_ok"

    invoke-virtual {v3, v5}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v5

    if-eqz v5, :cond_nook

    invoke-virtual {v5, v4}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_nook
    new-instance v5, Lcom/mrkeyboard/app/MrTune;

    const/4 v6, -0x2

    invoke-direct {v5, v6}, Lcom/mrkeyboard/app/MrTune;-><init>(I)V

    const-string v6, "tune_reset"

    invoke-virtual {v3, v6}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v6

    if-eqz v6, :cond_noreset

    invoke-virtual {v6, v5}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_noreset
    invoke-virtual {v2, v3}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    invoke-virtual {v2}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v5

    # no window background/dim of its own: the dark layer comes from the layout
    new-instance v6, Landroid/graphics/drawable/ColorDrawable;

    const/4 v3, 0x0

    invoke-direct {v6, v3}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v5, v6}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    const/4 v6, 0x2

    invoke-virtual {v5, v6}, Landroid/view/Window;->clearFlags(I)V

    # Avoids taking the editor's focus: NOT_FOCUSABLE + full-screen layout.
    const v6, 0x20000

    invoke-virtual {v5, v6}, Landroid/view/Window;->clearFlags(I)V

    const v6, 0x308

    invoke-virtual {v5, v6}, Landroid/view/Window;->addFlags(I)V

    invoke-virtual {v5}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v6

    iput-object v1, v6, Landroid/view/WindowManager$LayoutParams;->token:Landroid/os/IBinder;

    const/16 v1, 0x3eb

    iput v1, v6, Landroid/view/WindowManager$LayoutParams;->type:I

    # TOP | FILL_HORIZONTAL, full width, height = top of the keyboard
    const/16 v1, 0x37

    iput v1, v6, Landroid/view/WindowManager$LayoutParams;->gravity:I

    const/4 v1, -0x1

    iput v1, v6, Landroid/view/WindowManager$LayoutParams;->width:I

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->imeTop()I

    move-result v1

    iput v1, v6, Landroid/view/WindowManager$LayoutParams;->height:I

    invoke-virtual {v5, v6}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    invoke-virtual {v7, v4}, Landroid/view/View;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    sput-object v2, Lcom/mrkeyboard/app/MrTune;->sDlg:Landroid/app/Dialog;

    invoke-virtual {v2}, Landroid/app/Dialog;->show()V

    return-void
.end method


# virtual methods
# Restores the default only for this dialog's settings (does not touch the rest of the preferences).
# The label scale is applied straight to the view (silent write), as when dragging the slider.
.method private static resetDefaults()V
    .locals 4

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    const/4 v1, 0x1

    sput-boolean v1, Lcom/mrkeyboard/app/MrTune;->sSilent:Z

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "pref_label_scale_v2"

    invoke-interface {v1, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    const/4 v1, 0x1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTune;->defOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTune;->liveLabel(F)V

    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrTune;->sSilent:Z

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "settings_height_portrait"

    invoke-interface {v1, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    const-string v2, "settings_height_landscape"

    invoke-interface {v1, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    const-string v2, "pref_bar_scale"

    invoke-interface {v1, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    const-string v2, "pref_key_spacing"

    invoke-interface {v1, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    const-string v2, "pref_key_radius"

    invoke-interface {v1, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->refresh()V

    return-void
.end method

# Keyboard changed size (height slider): readjusts the height of the dialog window.
.method public onLayoutChange(Landroid/view/View;IIIIIIII)V
    .locals 5

    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sDlg:Landroid/app/Dialog;

    if-nez v0, :cond_go

    return-void

    :cond_go
    :try_start_l
    invoke-virtual {v0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v2

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->imeTop()I

    move-result v3

    iget v4, v2, Landroid/view/WindowManager$LayoutParams;->height:I

    if-eq v3, v4, :cond_same

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->height:I

    invoke-virtual {v1, v2}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    :cond_same
    :try_end_l
    .catch Ljava/lang/Throwable; {:try_start_l .. :try_end_l} :catch_l

    return-void

    :catch_l
    move-exception v0

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    iget v0, p0, Lcom/mrkeyboard/app/MrTune;->mIdx:I

    const/4 v1, -0x2

    if-ne v0, v1, :cond_close

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->resetDefaults()V

    return-void

    :cond_close
    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->close()V

    return-void
.end method

.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 4

    if-eqz p3, :cond_end

    iget v0, p0, Lcom/mrkeyboard/app/MrTune;->mIdx:I

    invoke-static {v0, p2}, Lcom/mrkeyboard/app/MrTune;->toValue(II)F

    move-result v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTune;->fmt(IF)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTune;->mVal:Landroid/widget/TextView;

    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 v2, 0x1

    if-ne v0, v2, :cond_save

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTune;->liveLabel(F)V

    return-void

    :cond_save
    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTune;->save(IF)V

    :cond_end
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 3

    iget v0, p0, Lcom/mrkeyboard/app/MrTune;->mIdx:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_end

    invoke-virtual {p1}, Landroid/widget/ProgressBar;->getProgress()I

    move-result v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTune;->toValue(II)F

    move-result v1

    const/4 v2, 0x1

    sput-boolean v2, Lcom/mrkeyboard/app/MrTune;->sSilent:Z

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTune;->save(IF)V

    const/4 v2, 0x0

    sput-boolean v2, Lcom/mrkeyboard/app/MrTune;->sSilent:Z

    :cond_end
    return-void
.end method
