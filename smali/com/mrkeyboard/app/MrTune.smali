.class public final Lcom/mrkeyboard/app/MrTune;
.super Ljava/lang/Object;
.source "MrTune.java"

# Ferramenta "Personalizar teclado": painel preto translucido sobre o teclado com 4
# deslizadores (altura vertical ou horizontal conforme a orientacao, escala dos rotulos, espacamento, arredondamento).
# Cada deslizador grava a mesma preferencia das configuracoes, entao o teclado
# atualiza em tempo real pelo mesmo caminho (LatinIME.onSharedPreferenceChanged).
# Excecao: a escala dos rotulos recriaria a view do teclado (e o proprio deslizador)
# a cada passo; por isso ela e aplicada direto na view e so gravada ao soltar.

.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


# static fields
.field static sList:Ljava/util/ArrayList;

.field static sOn:Z

.field static sPanel:Landroid/view/View;

.field static sBar:Landroid/view/View;

.field static sSilent:Z


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

# Encaixa o teclado no FrameLayout "kbd_host" (o painel fica por cima dele).
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

# Cor de destaque do tema atual: nos temas com paleta "tech" (Slate, Midnight e Glass) e o
# azul/ciano do app (#29c5f6); nos demais temas segue a cor do texto das teclas.
.method private static accent()I
    .locals 2

    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->techPalette()Z

    move-result v0

    if-eqz v0, :cond_theme

    const-string v0, "accent"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    return v0

    :cond_theme
    sget v0, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    return v0
.end method

# Retangulo arredondado: p0 = preenchimento, p1 = cor da borda, p2 = largura da borda (px),
# p3 = raio dos cantos (px).
.method private static shape(IIIF)Landroid/graphics/drawable/GradientDrawable;
    .locals 1

    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    invoke-virtual {v0, p0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    invoke-virtual {v0, p2, p1}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    invoke-virtual {v0, p3}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    return-object v0
.end method

# Botao X do painel: icone, borda e fundo na cor de destaque do tema (fundo mais forte ao tocar).
.method private static styleClose(Landroid/view/View;)V
    .locals 10

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->accent()I

    move-result v0

    invoke-virtual {p0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->density:F

    # borda de 1dp e cantos que seguem o raio das teclas (raio + 2 dp, como os outros botoes da barra)
    float-to-int v2, v1

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v3

    const/high16 v4, 0x40000000    # 2.0f

    invoke-static {v3, v4}, Lcom/mrkeyboard/app/KeyStyle;->radiusPx(Landroid/content/Context;F)F

    move-result v3

    const v4, 0xffffff

    and-int/2addr v4, v0

    const-string v5, "alpha_close"

    invoke-static {v5}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v5

    or-int/2addr v5, v4

    const-string v6, "alpha_press"

    invoke-static {v6}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v6

    or-int/2addr v6, v4

    const-string v7, "alpha_close_line"

    invoke-static {v7}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v7

    or-int/2addr v7, v4

    invoke-static {v5, v7, v2, v3}, Lcom/mrkeyboard/app/MrTune;->shape(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v5

    invoke-static {v6, v7, v2, v3}, Lcom/mrkeyboard/app/MrTune;->shape(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v6

    new-instance v8, Landroid/graphics/drawable/StateListDrawable;

    invoke-direct {v8}, Landroid/graphics/drawable/StateListDrawable;-><init>()V

    const/4 v9, 0x1

    new-array v9, v9, [I

    const/4 v4, 0x0

    const v7, 0x10100a7

    aput v7, v9, v4

    invoke-virtual {v8, v9, v6}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    const/4 v9, 0x0

    new-array v9, v9, [I

    invoke-virtual {v8, v9, v5}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    invoke-virtual {p0, v8}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    instance-of v1, p0, Landroid/widget/TextView;

    if-eqz v1, :cond_end

    check-cast p0, Landroid/widget/TextView;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->tintColor(Landroid/widget/TextView;I)V

    :cond_end
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

# Orientacao atual (true = horizontal/paisagem).
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

# Altura padrao da orientacao atual (mesmos recursos usados pelo teclado).
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

# Titulo do primeiro deslizador conforme a orientacao.
.method private static updateTitle()V
    .locals 3

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

# Escala dos rotulos: aplica direto na view (sem recriar o teclado).
.method private static liveLabel(F)V
    .locals 2

    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sKeyboardSettings:Lcom/mrkeyboard/app/GlobalKeyboardSettings;

    iput p0, v0, Lcom/mrkeyboard/app/GlobalKeyboardSettings;->labelScalePref:F

    # a escala dos rotulos tambem dimensiona os icones dos botoes da barra
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

    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sList:Ljava/util/ArrayList;

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

# Chamado por LatinIME.onSharedPreferenceChanged: ignora a gravacao silenciosa da escala.
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

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->updateTitle()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrTune;->sList:Ljava/util/ArrayList;

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

    const-string v0, "tune_back"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_noclose

    new-instance v1, Lcom/mrkeyboard/app/MrTune;

    const/4 v2, -0x1

    invoke-direct {v1, v2}, Lcom/mrkeyboard/app/MrTune;-><init>(I)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_noclose
    const-string v0, "bar_tune"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrTune;->sBar:Landroid/view/View;
    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sPanel:Landroid/view/View;

    if-eqz v0, :cond_end

    const/16 v1, 0x8

    sget-boolean v2, Lcom/mrkeyboard/app/MrTune;->sOn:Z

    if-eqz v2, :cond_vis

    const/4 v1, 0x0

    :cond_vis
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    if-eqz v2, :cond_end

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->refresh()V

    :cond_end
    return-void
.end method

.method private static toProgress(IF)I
    .locals 4

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

.method static toggle()V
    .locals 2

    sget-boolean v0, Lcom/mrkeyboard/app/MrTune;->sOn:Z

    if-eqz v0, :cond_open

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->close()V

    return-void

    :cond_open
    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sPanel:Landroid/view/View;

    if-nez v0, :cond_go

    return-void

    :cond_go
    const/4 v1, 0x1

    sput-boolean v1, Lcom/mrkeyboard/app/MrTune;->sOn:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->refresh()V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    sget-object v0, Lcom/mrkeyboard/app/MrTune;->sBar:Landroid/view/View;

    if-eqz v0, :cond_hidebar

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_hidebar
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarMain:Landroid/view/View;

    if-eqz v0, :cond_done

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_done
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0

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
