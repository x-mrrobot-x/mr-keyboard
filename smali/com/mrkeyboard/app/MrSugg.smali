.class public final Lcom/mrkeyboard/app/MrSugg;
.super Ljava/lang/Object;
.source "MrSugg.java"


# Sugestoes de palavras na linha da barra de ferramentas (bar_main).
#
# A faixa de sugestoes (container de candidates.xml com o CandidateView) mora em "sg_host",
# dentro de bar_main, e nao na area de candidatos do InputMethodService. bar_main tem dois
# grupos que se alternam na mesma linha de 44dp: bar_tools (ferramentas) e bar_sugg.
#
# A linha continua obedecendo a tecla da barra (MrTools.sBarOn): oculta, nao mostra nada.
# Visivel (sem painel aberto):
#   ha sugestoes e o usuario nao pediu as ferramentas nesta palavra -> sugestoes
#   caso contrario                                                 -> ferramentas
# Tecla da barra (MrTools.toggleBar -> onBarKey):
#   linha visivel e ha sugestoes -> alterna sugestoes <-> ferramentas (vale ate a palavra acabar)
#   senao                        -> mostra/oculta a linha, como antes
# Cores da faixa seguem o tema (CandidateView.mrTheme com MrTools.sTextColor).
#
# Atraso (debounce): quando as sugestoes acabam (fim da palavra, espaco), a faixa continua
# visivel por DELAY (1 s) antes de dar lugar as ferramentas. Se chegarem novas sugestoes nesse
# intervalo (usuario digitando a proxima palavra), a espera e cancelada e a linha nao alterna.
# Cada nova lista sem sugestoes durante a espera reinicia o relogio. A tecla da barra encerra a
# espera e mostra as ferramentas na hora. Trocar de ferramentas para sugestoes e imediato.


# static fields
.field static sContainer:Landroid/view/View;

# Espera pendente: sem sugestoes, mas a faixa ainda e mostrada.
.field static sHold:Z

.field static sHandler:Landroid/os/Handler;

.field static sExpire:Ljava/lang/Runnable;

.field static sHost:Landroid/view/ViewGroup;

.field static sTools:Landroid/view/View;

.field static sSugg:Landroid/view/View;

.field static sHas:Z

.field static sPinned:Z


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

# Chamado por MrTools.wrap a cada nova raiz da barra.
.method static setup(Landroid/view/View;)V
    .locals 2

    const-string v0, "bar_tools"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sTools:Landroid/view/View;

    const-string v0, "bar_sugg"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sSugg:Landroid/view/View;

    const-string v0, "sg_host"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    instance-of v1, v0, Landroid/view/ViewGroup;

    if-nez v1, :cond_host

    const/4 v0, 0x0

    :cond_host
    check-cast v0, Landroid/view/ViewGroup;

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sHost:Landroid/view/ViewGroup;

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->attach()V

    return-void
.end method

# Aplica a cor do texto das teclas do tema atual ao CandidateView da faixa.
.method private static theme()V
    .locals 2

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sContainer:Landroid/view/View;

    if-eqz v0, :cond_end

    const v1, 0x7f080028

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    instance-of v1, v0, Lcom/mrkeyboard/app/CandidateView;

    if-eqz v1, :cond_end

    check-cast v0, Lcom/mrkeyboard/app/CandidateView;

    sget v1, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/CandidateView;->mrTheme(I)V

    :cond_end
    return-void
.end method

# Move a faixa de sugestoes para o host atual (a raiz da barra e recriada a cada setInputView)
# e aplica as cores do tema.
.method private static attach()V
    .locals 4

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sContainer:Landroid/view/View;

    sget-object v1, Lcom/mrkeyboard/app/MrSugg;->sHost:Landroid/view/ViewGroup;

    if-eqz v0, :cond_end

    if-eqz v1, :cond_end

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->theme()V

    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    if-eq v2, v1, :cond_end

    instance-of v3, v2, Landroid/view/ViewGroup;

    if-eqz v3, :cond_add

    check-cast v2, Landroid/view/ViewGroup;

    invoke-virtual {v2, v0}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    :cond_add
    # fundo transparente: a faixa usa o fundo da propria barra
    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v3, -0x1

    invoke-direct {v2, v3, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v0, v2}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    :cond_end
    return-void
.end method

# LatinIME.onCreateCandidatesView: a faixa foi criada (sugestoes ligadas para o campo).
.method public static host(Landroid/view/View;)V
    .locals 0

    sput-object p0, Lcom/mrkeyboard/app/MrSugg;->sContainer:Landroid/view/View;

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->attach()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    return-void
.end method

# LatinIME.removeCandidateViewContainer: sugestoes desligadas para o campo.
.method public static unhost()V
    .locals 1

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->cancel()V

    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sContainer:Landroid/view/View;

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sPinned:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    return-void
.end method

# LatinIME.setSuggestions / dica "toque para salvar": ha (ou nao) sugestoes para mostrar.
# Com sugestoes: cancela a espera e mostra a faixa na hora.
# Sem sugestoes: a escolha manual de ferramentas e desfeita (vale so para a palavra atual). Se a
# faixa estava sendo mostrada, ela e mantida por DELAY antes de dar lugar as ferramentas.
.method public static onList(Z)V
    .locals 2

    if-eqz p0, :cond_none

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->cancel()V

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    if-nez v0, :cond_end

    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    goto :cond_end

    :cond_none
    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHold:Z

    if-eqz v0, :cond_nohold

    # ja esperando: reinicia o relogio
    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->schedule()V

    goto :cond_end

    :cond_nohold
    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    if-eqz v0, :cond_end

    # modo atual (antes de mudar o estado): 2 = faixa de sugestoes visivel
    sget-boolean v0, Lcom/mrkeyboard/app/MrTools;->sBarOn:Z

    invoke-static {v0}, Lcom/mrkeyboard/app/MrSugg;->mode(Z)I

    move-result v0

    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    sput-boolean v1, Lcom/mrkeyboard/app/MrSugg;->sPinned:Z

    const/4 v1, 0x2

    if-ne v0, v1, :cond_apply

    # a faixa continua visivel durante a espera
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHold:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->schedule()V

    goto :cond_end

    :cond_apply
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    :cond_end
    return-void
.end method

# Agenda (ou reagenda) o fim da espera para DELAY (1000 ms) a partir de agora.
.method private static schedule()V
    .locals 4

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sHandler:Landroid/os/Handler;

    if-nez v0, :cond_ready

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sHandler:Landroid/os/Handler;

    new-instance v1, Lcom/mrkeyboard/app/MrSugg$Expire;

    invoke-direct {v1}, Lcom/mrkeyboard/app/MrSugg$Expire;-><init>()V

    sput-object v1, Lcom/mrkeyboard/app/MrSugg;->sExpire:Ljava/lang/Runnable;

    :cond_ready
    sget-object v1, Lcom/mrkeyboard/app/MrSugg;->sExpire:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    const-wide/16 v2, 0x3e8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

# Encerra a espera sem mudar a linha.
.method private static cancel()V
    .locals 2

    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHold:Z

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sHandler:Landroid/os/Handler;

    if-eqz v0, :cond_end

    sget-object v1, Lcom/mrkeyboard/app/MrSugg;->sExpire:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    :cond_end
    return-void
.end method

# Fim da espera (MrSugg$Expire.run, na thread principal): mostra as ferramentas.
.method public static expire()V
    .locals 1

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHold:Z

    if-eqz v0, :cond_end

    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHold:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    :cond_end
    return-void
.end method

# Sugestoes para mostrar: reais (sHas) ou ainda mantidas pela espera (sHold).
.method private static available()Z
    .locals 1

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sContainer:Landroid/view/View;

    if-eqz v0, :cond_no

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sHost:Landroid/view/ViewGroup;

    if-eqz v0, :cond_no

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    if-nez v0, :cond_yes

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHold:Z

    return v0

    :cond_yes
    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method

# 0 = linha oculta, 1 = ferramentas, 2 = sugestoes (MrTools.applyMain, sem painel aberto).
.method static mode(Z)I
    .locals 1

    if-nez p0, :cond_on

    const/4 v0, 0x0

    return v0

    :cond_on
    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->available()Z

    move-result v0

    if-eqz v0, :cond_tools

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sPinned:Z

    if-nez v0, :cond_tools

    const/4 v0, 0x2

    return v0

    :cond_tools
    const/4 v0, 0x1

    return v0
.end method

# Aplica o modo aos grupos internos de bar_main (a visibilidade de bar_main e do MrTools).
.method static applyInner(IZ)V
    .locals 4

    const/16 v0, 0x8

    const/4 v1, 0x0

    const/4 v2, 0x2

    sget-object v3, Lcom/mrkeyboard/app/MrSugg;->sTools:Landroid/view/View;

    if-eqz v3, :cond_sugg

    if-ne p0, v2, :cond_tools_on

    invoke-virtual {v3, v0}, Landroid/view/View;->setVisibility(I)V

    goto :cond_sugg

    :cond_tools_on
    invoke-virtual {v3, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_sugg
    sget-object v3, Lcom/mrkeyboard/app/MrSugg;->sSugg:Landroid/view/View;

    if-eqz v3, :cond_end

    if-ne p0, v2, :cond_sugg_off

    invoke-virtual {v3, v1}, Landroid/view/View;->setVisibility(I)V

    goto :cond_end

    :cond_sugg_off
    invoke-virtual {v3, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_end
    return-void
.end method

# Tecla da barra (MrTools.toggleBar). Com a linha visivel e sugestoes disponiveis, alterna
# sugestoes <-> ferramentas e devolve true. Caso contrario devolve false e o toggleBar
# mostra/oculta a linha como antes.
.method static onBarKey()Z
    .locals 2

    sget-boolean v0, Lcom/mrkeyboard/app/MrTools;->sBarOn:Z

    if-eqz v0, :cond_no

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarMain:Landroid/view/View;

    if-eqz v0, :cond_no

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_no

    # tecla durante a espera: mostra as ferramentas agora
    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHold:Z

    if-eqz v0, :cond_chk

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->cancel()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    const/4 v0, 0x1

    return v0

    :cond_chk
    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->available()Z

    move-result v0

    if-eqz v0, :cond_no

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sPinned:Z

    xor-int/lit8 v0, v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sPinned:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method

# MrTools.release (teclado destruido).
.method static release()V
    .locals 1

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->cancel()V

    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sContainer:Landroid/view/View;

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sHost:Landroid/view/ViewGroup;

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sTools:Landroid/view/View;

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sSugg:Landroid/view/View;

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sPinned:Z

    return-void
.end method
