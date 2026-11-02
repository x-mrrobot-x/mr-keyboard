.class final Lcom/mrkeyboard/app/MrTheme;

.super Ljava/lang/Object;

.source "MrTheme.java"

# Deteccao unica do tema do teclado. Cada layout de tema traz uma tag no LatinKeyboardView
# (mr_neon, mr_soft, mr_slate, mr_midnight, mr_glass) e esta classe a converte em flags de
# capacidade, lidas de mr_theme_tags e mr_theme_flags (res/values/mr_themes.xml). Nenhum outro ponto do codigo deve comparar cor de texto ou tag para saber o tema.
#
# Flags (bits):
#   INIT              0x01  flags ja calculadas (valor 0 = ainda nao calculado)
#   FLAT_BAR          0x02  barra de ferramentas e paineis planos (Midnight, Glass)
#   ACCENT_KEYS       0x04  teclas de destaque pintadas pelo drawable btn_keyboard_key_<tema>_accent (todo tema
#                           com tag; a view sem tag, como o popup de variantes, nao tem destaque)
#   ACCENT_WIDE       0x08  grupo de destaque ampliado: alem das teclas da lista fixa, entram toda tecla isModifier,
#                           as teclas do Tasker (texto "tskcmd:"), 123/TSK, Espaco e Enter (todos os temas ligam;
#                           desligar tira so esse grupo)
#   TRANSLUCENT       0x10  tema translucido, com blur de fundo (Glass)
#   TECH_PALETTE      0x20  paleta escura "tech" com texto #e7eef7 (Slate, Midnight, Glass)
#   PLAIN_ACCENT_TEXT 0x40  teclas de destaque usam o texto padrao do tema (Slate, Midnight, Glass); sem a flag
#                           o texto e o icone vem da cor mr_<tema>_accent_text (Neon, Soft)
.field static final INIT:I = 0x1

.field static final FLAT_BAR:I = 0x2

.field static final ACCENT_KEYS:I = 0x4

.field static final ACCENT_WIDE:I = 0x8

.field static final TRANSLUCENT:I = 0x10

.field static final TECH_PALETTE:I = 0x20

.field static final PLAIN_ACCENT_TEXT:I = 0x40

# Flags do teclado atual (o mesmo que MrTools.sKbd), para a barra e os paineis.
.field private static sFlags:I

# Tag do layout do teclado atual (mr_glass, mr_midnight...); null quando nao ha teclado.
.field private static sTag:Ljava/lang/String;


# p0 = contexto, p1 = tag do layout (String ou null). Procura a tag em mr_theme_tags e devolve a flag da mesma posicao
# em mr_theme_flags. Sempre devolve com o bit INIT ligado; tag desconhecida ou recurso ausente devolve so o INIT.
.method static flags(Landroid/content/Context;Ljava/lang/Object;)I
    .locals 8

    const/4 v0, 0x1

    if-eqz p0, :cond_done

    if-eqz p1, :cond_done

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const-string v4, "array"

    const-string v3, "mr_theme_tags"

    invoke-virtual {v1, v3, v4, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v3

    const-string v5, "mr_theme_flags"

    invoke-virtual {v1, v5, v4, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    invoke-virtual {v1, v5}, Landroid/content/res/Resources;->getIntArray(I)[I

    move-result-object v5

    const/4 v6, 0x0

    array-length v7, v3

    :goto_loop
    if-ge v6, v7, :cond_done

    aget-object v2, v3, v6

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_next

    aget v2, v5, v6

    or-int/lit8 v0, v2, 0x1

    goto :cond_done

    :cond_next
    add-int/lit8 v6, v6, 0x1

    goto :goto_loop
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_done
    return v0

    :catch_0
    move-exception v1

    const/4 v0, 0x1

    return v0
.end method

# Guarda flags e tag do teclado que acabou de ser criado (MrTools.wrap). null limpa.
.method static attach(Landroid/view/View;)V
    .locals 2

    if-nez p0, :cond_have

    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->clear()V

    return-void

    :cond_have
    invoke-virtual {p0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrTheme;->flags(Landroid/content/Context;Ljava/lang/Object;)I

    move-result v1

    sput v1, Lcom/mrkeyboard/app/MrTheme;->sFlags:I

    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_nostr

    check-cast v0, Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrTheme;->sTag:Ljava/lang/String;

    return-void

    :cond_nostr
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrTheme;->sTag:Ljava/lang/String;

    return-void
.end method

.method static clear()V
    .locals 1

    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrTheme;->sFlags:I

    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrTheme;->sTag:Ljava/lang/String;

    return-void
.end method

# Cor de um papel (ex.: "panel_btn") lida de colors.xml por nome: primeiro <tag do tema>_<papel>
# (mr_glass_panel_btn), depois mr_<papel> (mr_panel_btn). Sem a cor, devolve magenta opaco para o erro
# aparecer na tela em vez de derrubar o teclado.
.method static color(Ljava/lang/String;)I
    .locals 6

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    if-nez v0, :cond_ctx

    const v0, -0xff01

    return v0

    :cond_ctx
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "color"

    sget-object v4, Lcom/mrkeyboard/app/MrTheme;->sTag:Ljava/lang/String;

    if-eqz v4, :cond_default

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, "_"

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4, v3, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    if-eqz v4, :cond_default

    invoke-virtual {v1, v4}, Landroid/content/res/Resources;->getColor(I)I

    move-result v4

    return v4

    :cond_default
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mr_"

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4, v3, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    if-nez v4, :cond_found

    const v0, -0xff01

    return v0

    :cond_found
    invoke-virtual {v1, v4}, Landroid/content/res/Resources;->getColor(I)I

    move-result v4

    return v4
.end method

# Barra de ferramentas e paineis planos (antes MrTools.isMidnight, que ja valia para o Glass).
.method static flatBar()Z
    .locals 1

    sget v0, Lcom/mrkeyboard/app/MrTheme;->sFlags:I

    and-int/lit8 v0, v0, 0x2

    if-eqz v0, :cond_no

    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method

# Tema translucido com blur de fundo (antes MrTools.isGlass).
.method static translucent()Z
    .locals 1

    sget v0, Lcom/mrkeyboard/app/MrTheme;->sFlags:I

    and-int/lit8 v0, v0, 0x10

    if-eqz v0, :cond_no

    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method

# Paleta escura "tech" (texto #e7eef7): Slate, Midnight e Glass. Antes era comparar sTextColor.
.method static techPalette()Z
    .locals 1

    sget v0, Lcom/mrkeyboard/app/MrTheme;->sFlags:I

    and-int/lit8 v0, v0, 0x20

    if-eqz v0, :cond_no

    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method
