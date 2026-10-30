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

# Raiz da barra de ferramentas inflada (mr_toolbar); usada para aplicar a
# escala dos rotulos aos icones dos botoes.
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

# Cor de destaque do tema Midnight Steel (realce ao tocar) e cor de fundo das teclas de
# destaque (fundo dos botoes da aba Anexos). Calculadas em deriveColors() a cada wrap().
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

.field static sSeq:I

.field static sSrc:I

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

# Linha principal (bar_main): escondida com painel aberto; senao MrSugg.mode decide entre
# ferramentas (1), sugestoes (2) ou nada (0). Ver MrSugg.
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

    # Com a linha visivel e sugestoes disponiveis, a tecla alterna sugestoes <-> ferramentas
    # (MrSugg). Senao, mostra/oculta a linha como antes.
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

# Aplica a escala dos rotulos das teclas aos icones dos botoes da barra de
# ferramentas (mesmo fator dos rotulos: labelScale/0.69, pois 0.69 e o padrao).
.method static applyIconScale()V
    .locals 1

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarRoot:Landroid/view/View;

    if-eqz v0, :cond_end

    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sKeyboardSettings:Lcom/mrkeyboard/app/GlobalKeyboardSettings;

    if-eqz v0, :cond_end

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarRoot:Landroid/view/View;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->scaleIcons(Landroid/view/View;)V

    :cond_end
    return-void
.end method

# Percorre a arvore da barra redimensionando os icones (compound drawables) de
# cada botao. Painéis (tags "p_*") e o hospedeiro do teclado ("kbd_host") sao
# ignorados: seus icones nao sao de botoes da barra.
.method private static scaleIcons(Landroid/view/View;)V
    .locals 8

    if-nez p0, :cond_go

    return-void

    :cond_go
    invoke-virtual {p0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_type

    check-cast v0, Ljava/lang/String;

    const-string v1, "p_"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_kbd

    return-void

    :cond_kbd
    const-string v1, "kbd_host"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_type

    return-void

    :cond_type
    instance-of v0, p0, Landroid/widget/TextView;

    if-eqz v0, :cond_group

    # fator f = labelScalePref / 0.69 (0.69 = escala padrao dos rotulos)
    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sKeyboardSettings:Lcom/mrkeyboard/app/GlobalKeyboardSettings;

    iget v0, v0, Lcom/mrkeyboard/app/GlobalKeyboardSettings;->labelScalePref:F

    const v1, 0x3f30a3d7    # 0.69f

    div-float/2addr v0, v1

    check-cast p0, Landroid/widget/TextView;

    invoke-virtual {p0}, Landroid/widget/TextView;->getCompoundDrawables()[Landroid/graphics/drawable/Drawable;

    move-result-object v1

    const/4 v2, 0x0

    :goto_d
    array-length v3, v1

    if-ge v2, v3, :cond_apply

    aget-object v3, v1, v2

    if-eqz v3, :cond_next_d

    invoke-virtual {v3}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v4

    invoke-virtual {v3}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v5

    if-lez v4, :cond_next_d

    if-lez v5, :cond_next_d

    int-to-float v4, v4

    mul-float/2addr v4, v0

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    int-to-float v5, v5

    mul-float/2addr v5, v0

    invoke-static {v5}, Ljava/lang/Math;->round(F)I

    move-result v5

    const/4 v6, 0x0

    invoke-virtual {v3, v6, v6, v4, v5}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    :cond_next_d
    add-int/lit8 v2, v2, 0x1

    goto :goto_d

    :cond_apply
    const/4 v0, 0x0

    aget-object v2, v1, v0

    const/4 v0, 0x1

    aget-object v3, v1, v0

    const/4 v0, 0x2

    aget-object v4, v1, v0

    const/4 v0, 0x3

    aget-object v5, v1, v0

    invoke-virtual {p0, v2, v3, v4, v5}, Landroid/widget/TextView;->setCompoundDrawables(Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {p0}, Landroid/widget/TextView;->requestLayout()V

    invoke-virtual {p0}, Landroid/widget/TextView;->invalidate()V

    return-void

    :cond_group
    instance-of v0, p0, Landroid/view/ViewGroup;

    if-eqz v0, :cond_end

    check-cast p0, Landroid/view/ViewGroup;

    const/4 v1, 0x0

    :goto_c
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    if-ge v1, v0, :cond_end

    invoke-virtual {p0, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->scaleIcons(Landroid/view/View;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_c

    :cond_end
    return-void
.end method

.method static btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;
    .locals 4

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sget v1, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->isMidnight()Z

    move-result v1

    if-eqz v1, :cond_keybg

    # Midnight Steel: campo de texto (EditText) com fundo proprio (fieldBg); botoes da linha
    # principal (tags "b_*") e abas de categoria de emote ("cat_*") planos, com destaque
    # translucido so ao tocar (flatBg); demais botoes dos paineis (voltar, idioma, anexos...)
    # com fundo discreto, perto da cor da barra (panelBg).
    instance-of v1, v0, Landroid/widget/EditText;

    if-eqz v1, :cond_notfield

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->fieldBg()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    goto :cond_mid_set

    :cond_notfield
    const-string v1, "b_"

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_flat

    const-string v1, "cat_"

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_flat

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->panelBg()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    goto :cond_mid_set

    :cond_flat
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->flatBg()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    :cond_mid_set
    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    goto :cond_nobg

    :cond_keybg
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sKeyBg:Landroid/graphics/drawable/Drawable;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->dupe(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    if-eqz v1, :cond_nobg

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    :cond_nobg
    sget v1, Lcom/mrkeyboard/app/MrTools;->sPad:I

    invoke-virtual {v0}, Landroid/widget/TextView;->length()I

    move-result v2

    if-eqz v2, :cond_padset

    mul-int/lit8 v1, v1, 0x4

    div-int/lit8 v1, v1, 0x5

    :cond_padset
    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2, v1, v2}, Landroid/view/View;->setPadding(IIII)V

    if-ltz p2, :cond_nolistener

    new-instance v1, Lcom/mrkeyboard/app/MrTools;

    const/4 v3, 0x0

    invoke-direct {v1, p2, v3}, Lcom/mrkeyboard/app/MrTools;-><init>(ILjava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_nolistener
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->isMidnight()Z

    move-result v1

    if-eqz v1, :cond_tint_def

    # Midnight Steel: icones em branco levemente azulado (#dfe7f1)
    const v1, -0x20180f

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tintColor(Landroid/widget/TextView;I)V

    goto :cond_btn_end

    :cond_tint_def
    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->tint(Landroid/widget/TextView;)V

    :cond_btn_end
    return-object v0
.end method

# ---------------------------------------------------------------------------------------
# Estilos do tema Midnight Steel para a barra de ferramentas
# ---------------------------------------------------------------------------------------

# Tema Midnight Steel ativo: o teclado atual (layout input_mr_midnight) traz a tag "mr_midnight".
# Os estilos exclusivos do tema (cores derivadas, botoes planos, linhas da barra) so valem aqui.
.method static isMidnight()Z
    .locals 2

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    if-nez v0, :cond_im_have

    const/4 v0, 0x0

    return v0

    :cond_im_have
    invoke-virtual {v0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    const-string v1, "mr_midnight"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

# Cor do miolo da tecla de destaque do tema (tecla "checkable": Shift, ?123, Enter...), lida
# desenhando o fundo de tecla do tema nesse estado num bitmap pequeno. 0 se nao for possivel.
.method private static keyFace()I
    .locals 5

    :try_start_kf
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sKeyBg:Landroid/graphics/drawable/Drawable;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->dupe(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    if-eqz v0, :cond_kf_none

    const/4 v1, 0x1

    new-array v1, v1, [I

    const/4 v2, 0x0

    const v3, 0x101009f

    aput v3, v1, v2

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setState([I)Z

    const/16 v1, 0x40

    sget-object v2, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v1, v1, v2}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v2

    new-instance v3, Landroid/graphics/Canvas;

    invoke-direct {v3, v2}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    const/4 v4, 0x0

    invoke-virtual {v0, v4, v4, v1, v1}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    invoke-virtual {v0, v3}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    div-int/lit8 v1, v1, 0x2

    invoke-virtual {v2, v1, v1}, Landroid/graphics/Bitmap;->getPixel(II)I

    move-result v0

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    :try_end_kf
    .catch Ljava/lang/Exception; {:try_start_kf .. :try_end_kf} :catch_kf

    # pixel totalmente transparente = sem cor util
    ushr-int/lit8 v1, v0, 0x18

    if-nez v1, :cond_kf_ret

    :cond_kf_none
    const/4 v0, 0x0

    :cond_kf_ret
    return v0

    :catch_kf
    move-exception v0

    const/4 v0, 0x0

    return v0
.end method

# sAccent: a cor da tecla de destaque ajustada para ler bem sobre o fundo (tema escuro: brilho
# minimo 0,86 e saturacao maxima 0,60; tema claro: brilho maximo 0,40; o matiz e do tema). sAccentBg: o
# proprio miolo da tecla de destaque, opaco. Sem tecla de destaque, usa a cor do texto.
.method static deriveColors()V
    .locals 5

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->keyFace()I

    move-result v0

    sget v1, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    const/4 v2, 0x3

    new-array v2, v2, [F

    # tema escuro = texto claro (brilho HSV do texto > 0,5); o resultado fica em v3
    invoke-static {v1, v2}, Landroid/graphics/Color;->colorToHSV(I[F)V

    const/4 v3, 0x2

    aget v3, v2, v3

    const/high16 v4, 0x3f000000    # 0.5f

    cmpl-float v3, v3, v4

    if-nez v0, :cond_dc_have

    move v0, v1

    :cond_dc_have
    invoke-static {v0, v2}, Landroid/graphics/Color;->colorToHSV(I[F)V

    const/4 v4, 0x2

    aget v1, v2, v4

    if-lez v3, :cond_dc_light

    const v4, 0x3f5c28f6    # 0.86f

    cmpg-float v3, v1, v4

    if-gez v3, :cond_dc_sat

    move v1, v4

    :cond_dc_sat
    # saturacao no maximo 0,60: azuis puros e saturados ficam escuros demais para icones
    const/4 v3, 0x1

    aget v3, v2, v3

    const v4, 0x3f19999a    # 0.60f

    cmpl-float v3, v3, v4

    if-lez v3, :cond_dc_set

    const/4 v3, 0x1

    aput v4, v2, v3

    goto :cond_dc_set

    :cond_dc_light
    const v4, 0x3ecccccd    # 0.40f

    cmpl-float v3, v1, v4

    if-lez v3, :cond_dc_set

    move v1, v4

    :cond_dc_set
    const/4 v4, 0x2

    aput v1, v2, v4

    invoke-static {v2}, Landroid/graphics/Color;->HSVToColor([F)I

    move-result v1

    sput v1, Lcom/mrkeyboard/app/MrTools;->sAccent:I

    const/high16 v1, -0x1000000

    or-int/2addr v0, v1

    sput v0, Lcom/mrkeyboard/app/MrTools;->sAccentBg:I

    # fundo do idioma selecionado nas listas de idioma: a cor de destaque a 28%
    sget v1, Lcom/mrkeyboard/app/MrTools;->sAccent:I

    const v2, 0xffffff

    and-int/2addr v1, v2

    const/high16 v2, 0x47000000

    or-int/2addr v1, v2

    sput v1, Lcom/mrkeyboard/app/MrTools;->sSelColor:I

    return-void
.end method

# Retangulo arredondado: p0 = preenchimento, p1 = cor da borda, p2 = largura da borda (px),
# p3 = raio dos cantos (px).
.method private static rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;
    .locals 1

    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    invoke-virtual {v0, p0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    invoke-virtual {v0, p2, p1}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    invoke-virtual {v0, p3}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    return-object v0
.end method

# Fundo dos botoes da barra: transparente; ao tocar, a cor de destaque do tema a 30% num
# retangulo de cantos de 10 dp.
.method static flatBg()Landroid/graphics/drawable/Drawable;
    .locals 5

    new-instance v0, Landroid/graphics/drawable/StateListDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/StateListDrawable;-><init>()V

    sget v1, Lcom/mrkeyboard/app/MrTools;->sAccent:I

    const v2, 0xffffff

    and-int/2addr v1, v2

    const/high16 v2, 0x4d000000

    or-int/2addr v1, v2

    const/4 v2, 0x0

    sget v3, Lcom/mrkeyboard/app/MrTools;->sPad:I

    int-to-float v3, v3

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

# Fundo da categoria de emotes selecionada: igual ao dos botoes dos paineis (voltar), fundo
# #263344, borda de 1 dp #3a4d65 e cantos de 10 dp.
.method static selBg()Landroid/graphics/drawable/Drawable;
    .locals 4

    sget v0, Lcom/mrkeyboard/app/MrTools;->sPad:I

    div-int/lit8 v1, v0, 0xa

    int-to-float v2, v0

    const v0, 0xff263344

    const v3, 0xff3a4d65

    invoke-static {v0, v3, v1, v2}, Lcom/mrkeyboard/app/MrTools;->rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    return-object v0
.end method

.method static tabOffBg()Landroid/graphics/drawable/Drawable;
    .locals 4

    sget v0, Lcom/mrkeyboard/app/MrTools;->sPad:I

    div-int/lit8 v1, v0, 0xa

    int-to-float v2, v0

    const v0, 0xff1e2937

    const v3, 0xff2c3b4f

    invoke-static {v0, v3, v1, v2}, Lcom/mrkeyboard/app/MrTools;->rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    return-object v0
.end method

.method static shotTab(Landroid/widget/TextView;Z)V
    .locals 3

    const/high16 v0, 0x3f800000

    invoke-virtual {p0, v0}, Landroid/view/View;->setAlpha(F)V

    if-eqz p1, :cond_st_off

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->panelBg()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    const v2, -0x20180f

    goto :cond_st_set

    :cond_st_off
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->tabOffBg()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    const v2, 0xff9db1c8

    :cond_st_set
    invoke-virtual {p0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrTools;->tintColor(Landroid/widget/TextView;I)V

    return-void
.end method

.method static cardBg()Landroid/graphics/drawable/Drawable;
    .locals 3

    const v0, 0x33888888

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->isMidnight()Z

    move-result v1

    if-eqz v1, :cond_cb_go

    const v0, 0xff263344

    :cond_cb_go
    sget v1, Lcom/mrkeyboard/app/MrTools;->sPad:I

    int-to-float v1, v1

    const/4 v2, 0x0

    invoke-static {v0, v2, v2, v1}, Lcom/mrkeyboard/app/MrTools;->rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    return-object v0
.end method

# Fundo do campo "Digite aqui para traduzir": mais escuro que a barra (#0e141b), com borda fina
# em azul-aco (#2a3645) e os mesmos cantos de 10 dp dos botoes.
.method static fieldBg()Landroid/graphics/drawable/Drawable;
    .locals 4

    sget v0, Lcom/mrkeyboard/app/MrTools;->sPad:I

    div-int/lit8 v1, v0, 0xa

    int-to-float v2, v0

    const v0, 0xff0e141b

    const v3, 0xff2a3645

    invoke-static {v0, v3, v1, v2}, Lcom/mrkeyboard/app/MrTools;->rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    return-object v0
.end method

# Fundo dos botoes dentro das ferramentas (voltar, idioma, anexos, limpar...): azul-aco um pouco
# mais claro que a barra (#263344, borda #3a4d65), cantos de 10 dp; ao tocar, a cor de
# destaque do tema a 35%.
.method static panelBg()Landroid/graphics/drawable/Drawable;
    .locals 6

    sget v0, Lcom/mrkeyboard/app/MrTools;->sAccent:I

    const v1, 0xffffff

    and-int/2addr v0, v1

    const/high16 v1, 0x59000000

    or-int/2addr v0, v1

    sget v1, Lcom/mrkeyboard/app/MrTools;->sPad:I

    div-int/lit8 v2, v1, 0xa

    int-to-float v3, v1

    const v4, 0xff3a4d65

    const v5, 0xff263344

    invoke-static {v5, v4, v2, v3}, Lcom/mrkeyboard/app/MrTools;->rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v5

    invoke-static {v0, v4, v2, v3}, Lcom/mrkeyboard/app/MrTools;->rrect(IIIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    new-instance v1, Landroid/graphics/drawable/StateListDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/StateListDrawable;-><init>()V

    const/4 v2, 0x1

    new-array v2, v2, [I

    const/4 v3, 0x0

    const v4, 0x10100a7

    aput v4, v2, v3

    invoke-virtual {v1, v2, v0}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    new-array v2, v3, [I

    invoke-virtual {v1, v2, v5}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    return-object v1
.end method

# Fundo da linha da barra (por tag) no tema Midnight Steel: cor propria #171e27, um tom mais
# clara que o fundo do teclado. O preenchimento da linha e preservado, pois alguns fundos de
# tema (9-patch) trazem preenchimento proprio.
.method private static liftBar(Landroid/view/View;Ljava/lang/String;)V
    .locals 6

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_lb_end

    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    const v2, -0xe8e1d9

    invoke-direct {v1, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v0}, Landroid/view/View;->getPaddingLeft()I

    move-result v2

    invoke-virtual {v0}, Landroid/view/View;->getPaddingTop()I

    move-result v3

    invoke-virtual {v0}, Landroid/view/View;->getPaddingRight()I

    move-result v4

    invoke-virtual {v0}, Landroid/view/View;->getPaddingBottom()I

    move-result v5

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {v0, v2, v3, v4, v5}, Landroid/view/View;->setPadding(IIII)V

    :cond_lb_end
    return-void
.end method

# Linhas da barra de ferramentas: principal, traducao, clipboard, anexos, emotes e personalizar.
.method private static liftBars(Landroid/view/View;)V
    .locals 1

    const-string v0, "bar_main"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->liftBar(Landroid/view/View;Ljava/lang/String;)V

    const-string v0, "bar_t"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->liftBar(Landroid/view/View;Ljava/lang/String;)V

    const-string v0, "bar_c"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->liftBar(Landroid/view/View;Ljava/lang/String;)V

    const-string v0, "bar_s"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->liftBar(Landroid/view/View;Ljava/lang/String;)V

    const-string v0, "bar_e"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->liftBar(Landroid/view/View;Ljava/lang/String;)V

    const-string v0, "bar_tune"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->liftBar(Landroid/view/View;Ljava/lang/String;)V

    return-void
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

    # Se o painel "Personalizar teclado" estiver aberto, fecha para voltar a mostrar o teclado.
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
# Abre direto a pagina de configuracao "Folhas do teclado" (PrefScreenSheets).
.method private static openSheetsPrefs()V
    .locals 3

    :try_start_sheets
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    if-nez v0, :cond_sheets_go

    return-void

    :cond_sheets_go
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-direct {v1, v0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v2, 0x10000000

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/LatinIME;->startActivity(Landroid/content/Intent;)V
    :try_end_sheets
    .catch Ljava/lang/Throwable; {:try_start_sheets .. :try_end_sheets} :catch_sheets

    return-void

    :catch_sheets
    move-exception v0

    return-void
.end method

# Atualiza o rotulo "N clips" ao lado do botao voltar do painel de clipboard.
.method static refreshClipCount()V
    .locals 4

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBtnClipCount:Landroid/widget/TextView;

    if-eqz v0, :cond_no_count

    sget v2, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sClips:Ljava/util/ArrayList;

    if-nez v1, :cond_has_list

    const-string v1, "0 clips"

    goto :goto_set_count

    :cond_has_list
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const/4 v3, 0x1

    if-ne v1, v3, :cond_plural

    const-string v1, " clip"

    goto :goto_suffix

    :cond_plural
    const-string v1, " clips"

    :goto_suffix
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_set_count
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_no_count
    return-void
.end method

# Trava a altura dos cards do clipboard: SEMPRE duas linhas de texto + paddings.
# Sem isso, card de 1 linha e card de 2 linhas mediam alturas diferentes
# (fonte/paddings proprios) e a linha do GridView ficava irregular.
.method static lockCard(Landroid/widget/TextView;)V
    .locals 4

    if-nez p0, :cond_card_ok

    return-void

    :cond_card_ok
    # no maximo 2 linhas, com "..." no fim da ultima quando o texto e grande
    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setMaxLines(I)V

    sget-object v0, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    # altura minima = 2 linhas + folga de fonte + paddings
    # (NAO usar setMaxHeight: ele muda o mMaxMode do TextView e o maxLines
    #  passa a ser ignorado, deixando o texto vazar e ser cortado)
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

    # Campo de entrada vazio (usuario apagou tudo): remove do campo do app a
    # traducao que foi inserida anteriormente. Antes so zerava as variaveis e a
    # traducao ficava no campo.
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

    if-eqz v0, :cond_off

    const v1, 0x7f0c01c2

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v1

    const/high16 v2, 0x3f800000

    goto :goto_apply

    :cond_off
    const v1, 0x7f0c01c3

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTools;->str(I)Ljava/lang/String;

    move-result-object v1

    const/high16 v2, 0x3f000000

    :goto_apply
    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sBtnClipSw:Landroid/widget/TextView;

    if-eqz v3, :cond_skip_sw

    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {v3, v2}, Landroid/view/View;->setAlpha(F)V

    :cond_skip_sw
    sget-object v3, Lcom/mrkeyboard/app/MrTools;->sBtnClipTop:Landroid/widget/TextView;

    if-eqz v3, :cond_skip_top

    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setAlpha(F)V

    :cond_skip_top
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

    invoke-static {p0}, Lcom/mrkeyboard/app/MrTools;->shotsMode(I)V

    invoke-static {p0}, Lcom/mrkeyboard/app/MrTools;->emoteMode(I)V

    const/16 v1, 0x8

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eq p0, v3, :cond_chk_h

    const/4 v3, 0x2

    if-ne p0, v3, :cond_noh

    :cond_chk_h
    sget-object v4, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    invoke-virtual {v4}, Landroid/view/View;->getVisibility()I

    move-result v5

    if-nez v5, :cond_noh

    invoke-virtual {v4}, Landroid/view/View;->getHeight()I

    move-result v5

    if-lez v5, :cond_noh

    const/4 v3, 0x1

    if-ne p0, v3, :cond_h_lang

    sget-object v4, Lcom/mrkeyboard/app/MrTools;->sPClip:Landroid/view/View;

    goto :cond_h_set

    :cond_h_lang
    sget-object v4, Lcom/mrkeyboard/app/MrTools;->sPLang:Landroid/view/View;

    :cond_h_set
    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrTools;->fitHeight(Landroid/view/View;I)V

    :cond_noh
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sPClip:Landroid/view/View;

    const/4 v3, 0x1

    if-ne p0, v3, :cond_clip_hide

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_clip

    :cond_clip_hide
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_clip
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sPLang:Landroid/view/View;

    const/4 v3, 0x2

    if-ne p0, v3, :cond_lang_hide

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_lang

    :cond_lang_hide
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_lang
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    if-nez p0, :cond_kbd_hide

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_kbd

    :cond_kbd_hide
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_kbd
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarMain:Landroid/view/View;

    sget-object v4, Lcom/mrkeyboard/app/MrTools;->sBarC:Landroid/view/View;

    const/4 v3, 0x1

    if-ne p0, v3, :cond_main_chk

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    if-eqz v4, :cond_main_end

    invoke-virtual {v4, v2}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_main_chk
    if-eqz v4, :cond_nobarc

    invoke-virtual {v4, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_nobarc
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    :cond_main_end
    return-void
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

.method private static sheet(Landroid/view/View;Ljava/lang/String;)V
    .locals 5

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_end

    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    sget v2, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    const v3, 0xffe7eef7

    if-eq v2, v3, :cond_tech

    const v3, 0xffffff

    and-int/2addr v2, v3

    const/high16 v3, 0x14000000

    or-int/2addr v3, v2

    const/high16 v4, 0x44000000

    or-int/2addr v2, v4

    goto :cond_paint

    :cond_tech
    const v3, 0xff111823

    const v2, 0xff2a3748

    # Midnight Steel: painel de idiomas (p_lang) com fundo e borda proprios
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->isMidnight()Z

    move-result v4

    if-eqz v4, :cond_paint

    const-string v4, "p_lang"

    invoke-virtual {v4, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_paint

    const v3, 0xff1a232e

    const v2, 0xff2c3a4b

    :cond_paint
    invoke-virtual {v1, v3}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    sget v3, Lcom/mrkeyboard/app/MrTools;->sPad:I

    div-int/lit8 v3, v3, 0xa

    invoke-virtual {v1, v3, v2}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    sget v2, Lcom/mrkeyboard/app/MrTools;->sPad:I

    mul-int/lit8 v2, v2, 0x7

    div-int/lit8 v2, v2, 0x5

    int-to-float v2, v2

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    :cond_end
    return-void
.end method

.method private static flatSheet(Landroid/view/View;Ljava/lang/String;)V
    .locals 7

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->isMidnight()Z

    move-result v0

    if-eqz v0, :cond_fs_end

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_fs_end

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    instance-of v2, v1, Landroid/view/ViewGroup$MarginLayoutParams;

    if-eqz v2, :cond_fs_end

    check-cast v1, Landroid/view/ViewGroup$MarginLayoutParams;

    iget v2, v1, Landroid/view/ViewGroup$MarginLayoutParams;->leftMargin:I

    iget v3, v1, Landroid/view/ViewGroup$MarginLayoutParams;->topMargin:I

    iget v4, v1, Landroid/view/ViewGroup$MarginLayoutParams;->rightMargin:I

    iget v5, v1, Landroid/view/ViewGroup$MarginLayoutParams;->bottomMargin:I

    const/4 v6, 0x0

    invoke-virtual {v1, v6, v6, v6, v6}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    const v6, -0xe8e1d9

    invoke-direct {v1, v6}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {v0, v2, v3, v4, v5}, Landroid/view/View;->setPadding(IIII)V

    :cond_fs_end
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

    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrTools;->sRedirect:Landroid/view/inputmethod/InputConnection;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrTools;->init(Landroid/content/Context;)V

    move-object v0, p1

    check-cast v0, Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->getMrKeyTextColor()I

    move-result v1

    sput v1, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    const v2, 0xffffff

    and-int/2addr v2, v1

    const/high16 v3, 0x33000000

    or-int/2addr v2, v3

    sput v2, Lcom/mrkeyboard/app/MrTools;->sSelColor:I

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->getMrKeyHintColor()I

    move-result v1

    sput v1, Lcom/mrkeyboard/app/MrTools;->sHint:I

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->getMrKeyBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sKeyBg:Landroid/graphics/drawable/Drawable;

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->isMidnight()Z

    move-result v1

    if-eqz v1, :cond_nomid_dc

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->deriveColors()V

    :cond_nomid_dc
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->density:F

    const/high16 v2, 0x41200000

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

    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getLayoutInflater()Landroid/view/LayoutInflater;

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

    if-eqz v1, :cond_nobg

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    :cond_nobg
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->isMidnight()Z

    move-result v1

    if-eqz v1, :cond_nomid_lb

    # Midnight Steel: linhas da barra de ferramentas um tom mais claras que o fundo do teclado
    # (a raiz fica como estava: o mesmo fundo aparece sob a barra de gestos)
    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->liftBars(Landroid/view/View;)V

    :cond_nomid_lb
    const-string v1, "b_clip"

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrTools;->sBtnClipTop:Landroid/widget/TextView;

    const-string v1, "b_trans"

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "clip_back"

    const/4 v2, 0x7

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    # rotulo com a quantidade de clips salvos (nao e botao: sem fundo/codigo)
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

    # botao "Folhas do teclado" (abre PrefScreenSheets), antes das preferencias
    const-string v1, "b_sheets"

    const/16 v2, 0x15

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "b_tune"

    const/16 v2, 0x13

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "b_emote"

    const/16 v2, 0x14

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "tune_back"

    const/4 v2, -0x1

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    const-string v1, "tune_info"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    sget v2, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTune;->setup(Landroid/view/View;)V

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

    const-string v1, "clip_empty"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->center(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "shot_empty"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->center(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "p_clip"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->sheet(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "p_lang"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->sheet(Landroid/view/View;Ljava/lang/String;)V

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->flatSheet(Landroid/view/View;Ljava/lang/String;)V

    const-string v1, "p_shots"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->sheet(Landroid/view/View;Ljava/lang/String;)V

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->flatSheet(Landroid/view/View;Ljava/lang/String;)V

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

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->sheet(Landroid/view/View;Ljava/lang/String;)V

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->flatSheet(Landroid/view/View;Ljava/lang/String;)V

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

    # sugestoes de palavras na linha da barra (MrSugg)
    invoke-static {v0}, Lcom/mrkeyboard/app/MrSugg;->setup(Landroid/view/View;)V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    instance-of v2, v1, Landroid/view/ViewGroup;

    if-eqz v2, :cond_noparent

    check-cast v1, Landroid/view/ViewGroup;

    invoke-virtual {v1, p1}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    :cond_noparent
    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrTune;->attach(Landroid/view/ViewGroup;Landroid/view/View;)V

    # dimensiona os icones dos botoes conforme a escala dos rotulos
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyIconScale()V

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

    const/16 v1, 0x12

    if-ne v0, v1, :cond_notview

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->toggleCols()V

    return-void

    :cond_notview
    const/16 v1, 0x13

    if-ne v0, v1, :cond_nottune

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->toggle()V

    return-void

    :cond_nottune
    const/16 v1, 0x14

    if-ne v0, v1, :cond_notemote

    const/4 v0, 0x4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void

    :cond_notemote
    const/16 v1, 0x15

    if-ne v0, v1, :cond_notsheets

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->openSheetsPrefs()V

    return-void

    :cond_notsheets
    sparse-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sPClip:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_open_clip

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void

    :cond_open_clip
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void

    :pswitch_1
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->enterTranslate()V

    return-void

    :pswitch_2
    sget-boolean v0, Lcom/mrkeyboard/app/MrTools;->sClipOn:Z

    if-eqz v0, :cond_turn_on

    const/4 v0, 0x0

    goto :goto_toggled

    :cond_turn_on
    const/4 v0, 0x1

    :goto_toggled
    sput-boolean v0, Lcom/mrkeyboard/app/MrTools;->sClipOn:Z

    const-string v1, "clip_on"

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrTools;->savePrefBool(Ljava/lang/String;Z)V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->refreshSwitch()V

    return-void

    :pswitch_3
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sClips:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sClipTs:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->saveClips()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->notifyAdapter()V

    return-void

    :pswitch_5
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sPLang:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_open_lang

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void

    :cond_open_lang
    const/4 v0, 0x2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void

    :pswitch_6
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->leave(Z)V

    return-void

    :pswitch_7
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void

    :pswitch_8
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->open()V

    return-void

    :pswitch_9
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    return-void

    :pswitch_a
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->reload()V

    return-void

    :pswitch_b

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->setVid(Z)V

    return-void

    :pswitch_c

    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->setVid(Z)V

    return-void

    :pswitch_16

    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->setFiles()V

    return-void

    :pswitch_17
    invoke-static {}, Lcom/mrkeyboard/app/MrShots;->clearCaches()V
    return-void

    :pswitch_data_0

    .sparse-switch
        0x0 -> :pswitch_0
        0x1 -> :pswitch_1
        0x2 -> :pswitch_2
        0x3 -> :pswitch_3
        0x5 -> :pswitch_5
        0x6 -> :pswitch_6
        0x7 -> :pswitch_7
        0x8 -> :pswitch_8
        0x9 -> :pswitch_9
        0xa -> :pswitch_a
        0xb -> :pswitch_b
        0xc -> :pswitch_c

        0x16 -> :pswitch_16
        0x17 -> :pswitch_17

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
 sput-boolean v0, Lcom/mrkeyboard/app/MrTune;->sOn:Z
 sput-boolean v0, Lcom/mrkeyboard/app/MrTune;->sSilent:Z
 invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->release()V
 :done
 return-void
.end method
