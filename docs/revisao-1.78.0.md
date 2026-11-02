# 1.78.0 — Temas padronizados: cores, raios, escalas e flags em um ponto só

## Pedido
Padronizar os 5 temas (Neon, Soft, Slate, Midnight e Glass) seguindo o `plano-padronizacao-temas.md`: tirar cor fixa dos drawables e do smali, fazer raios e escalas seguirem as configurações em vez de valores soltos, e deixar o registro de um tema novo só em recursos.

## Notas da release
**Português**
- O arredondamento das teclas agora vale também no popup do toque longo, no balão de preview, nos botões da barra e nos painéis. Com raio 0 tudo fica reto.
- A escala da barra vale também nos cabeçalhos dos painéis (tradução, clipboard, anexos, emotes e personalizar), e a faixa de sugestões acompanha a altura da barra.
- O tamanho do texto das sugestões vai de 0,5× a 3×, e o texto nunca passa de 75% da altura da faixa.
- O texto do popup do Neon deixa de ser negrito, como nos outros temas, e a dica do popup do Midnight fica igual à do teclado.
- No Neon, o brilho (halo) ao redor das teclas passa a acompanhar o raio das teclas: no raio padrão fica com cantos de 10 dp, em volta da borda de 8 dp, como o desenho do tema prevê. Os outros temas não mudam.
- No Soft, a borda das teclas de destaque deixa o ciano e passa a um azul do mesmo tom do fundo da tecla, só mais claro, para não chamar tanta atenção. A diferença entre repouso, ligada, pressionada e travada continua.
- No Glass, a borda das teclas normais e das de destaque deixa o branco acinzentado e passa a um azul-gelo claro, ainda bem discreto. A borda clareia do repouso ao travado, e as de destaque ficam um degrau mais visíveis que as normais. Só a cor muda: a largura da borda e o preenchimento das teclas ficam como estavam.

**English**
- Key corner roundness now also applies to the long-press popup, the key preview bubble, the toolbar buttons and the panels. With roundness 0 everything is square.
- The toolbar scale now also applies to the panel headers (translate, clipboard, attachments, emotes and customize), and the suggestion strip follows the toolbar height.
- Suggestion text size goes from 0.5× to 3×, and the text never exceeds 75% of the strip height.
- The Neon popup text is no longer bold, like the other themes, and the Midnight popup hint now matches the keyboard hint.
- On Neon, the glow (halo) around the keys now follows the key corner radius: at the default radius it has 10 dp corners around the 8 dp border, as the theme drawable intends. The other themes are unchanged.
- On Soft, the border of the accent keys moves from cyan to a blue in the same hue as the key background, just lighter, so it stands out less. The difference between rest, on, pressed and locked is kept.
- On Glass, the border of the normal and accent keys moves from grayish white to a light icy blue that is still very discreet. The border gets lighter from rest to locked, and the accent keys stay one step more visible than the normal ones. Only the color changes: the border width and the key fill stay as they were.

## O que mudou
- **Cores dos drawables (etapa 1).** As cores das teclas, do popup e do balão de preview saíram dos drawables e foram para `res/values/mr_key_colors.xml` (`mr_<tema>_key_<estado>_<parte>`), com 3 sombras globais (`mr_key_shadow`, `mr_popup_shadow`, `mr_preview_shadow`). Os drawables de tema só referenciam `@color`.
- **Alinhamentos (etapa 2).** Os 5 `input_mr_*`, `input_popup_*` e `key_preview_*` ficam iguais entre si, exceto pelo nome do tema. Os hex do `styles.xml`, do `mr_toolbar.xml` e dos drawables sem tema viraram `@color`.
- **Raios (etapa 3).** `KeyStyle.radiusPx` e `KeyStyle.applyShape` devolvem o raio das teclas mais uma folga (balão +2 dp, fundo do popup +8 dp; botões, campos e painéis pelo `MrTools`). No raio padrão (8 dp) valem os raios de antes; o fundo do popup do Neon fica com 16 dp, como nos outros temas.
- **Raio das camadas da tecla (item 3.5 do plano).** O array `mr_theme_keystyle` (Soft = modo 1, os demais = modo 2) e o `KeyStyle.modeFor` saíram, junto com o `sMode` e a leitura de `pref_keyboard_layout` no `KeyStyle`. Em `KeyStyle.prepare` e `KeyStyle.applyKeyLook` cada camada recebe o raio das teclas mais a folga que o próprio drawable desenha (`KeyStyle.layerGap`: recuo esquerdo da última camada menos o da camada, nunca negativo). Soft, Slate, Midnight e Glass ficam com os mesmos raios de antes em qualquer raio das teclas. No Neon, o halo passa de `r` para `r + 2 dp` (10 dp no padrão) e, nas teclas de destaque, o preenchimento de baixo passa de `r` para `r + 1 dp`, concêntrico com a borda de 2 dp. O `res_check.py` deixou de conferir o array, e o `novo-tema.md` explica a regra.
- **Borda das teclas de destaque do Soft.** As quatro cores `mr_soft_key_acc_{normal,on,pressed,lock}_stroke` (`res/values/mr_key_colors.xml`) saíram do ciano (`#2ae6fa`, `#70f0ff`, `#a8fcff`, `#d0ffff`) e foram para azuis de matiz próximo ao do fundo (`#4987f3`, `#629cf8`, `#7db0fc`, `#a3c9ff`), com o brilho subindo na mesma ordem. As bordas só são usadas nos 4 `key_soft_acc_*`; o halo e o fundo não mudaram.
- **Borda das teclas do Glass.** As nove cores `mr_glass_key_*_stroke` (`res/values/mr_key_colors.xml`) saíram do branco e do ciano com 8% a 13% de opacidade em repouso (`#14ffffff`, `#1affffff`, `#22cfe3ff`) e dos azuis pálidos dos outros estados e foram para azul-gelo claro, com a opacidade subindo na mesma ordem. Teclas normais: normal `#1ac8e0ff`, selecionada `#1fc8e0ff`, ligada `#4cd4e8ff`, pressionada `#42d8eaff`, travada `#5ce2f0ff`. Teclas de destaque: normal `#24cce3ff`, ligada `#52d8eaff`, pressionada `#47dcecff`, travada `#61e6f2ff`. Só mudou a cor: os preenchimentos, a largura das bordas (1, 1,5 e 2 dp) e o popup do toque longo ficaram como estavam.
- **Constantes no smali (etapa 4).** Cores fixas do `MrTools`, `MrTune`, `MrEmotes` e `MrSheetOpt` viraram `@color`; `default_label_scale`, `mr_bar_height`, `mr_bar_scale_min` e `mr_bar_scale_max` passaram a ser lidos de um recurso só.
- **Alturas e escalas (etapa 5).** `MrBar` passou a guardar uma lista de views e ganhou `attachExtra` para os cabeçalhos dos painéis; o `CandidateView` ficou em `match_parent`; o texto das sugestões é limitado pela altura da faixa. Removidos 4 recursos sem uso.
- **Flags em recursos (etapa 6).** `MrTheme.flags` não tem mais a cadeia de `if` com números fixos: lê a tag em `mr_theme_tags` e devolve a flag da mesma posição em `mr_theme_flags` (`res/values/mr_themes.xml`). A assinatura passou a `flags(Context, Object)`, e `LatinKeyboardBaseView.hasTheme` e `MrTheme.attach` passam o contexto da view. Os valores são os mesmos de antes (Neon e Soft `0x0d`, Slate `0x6d`, Midnight `0x6f`, Glass `0x7f`); em recursos ficam sem o bit `INIT` (`0x0c`, `0x0c`, `0x6c`, `0x6e`, `0x7e`), que o `MrTheme` liga. Tag desconhecida ou recurso ausente devolve só o `INIT`, como antes.
- **`res_check.py`.** Confere que `mr_theme_tags` e `mr_theme_flags` têm o mesmo tamanho, sem tag repetida e só com bits válidos, que a tag de cada layout está em `mr_theme_tags` e, desde as etapas anteriores, que não há hex nos drawables de tema e que os layouts por tema são iguais entre si.
- **Documentação.** `docs/novo-tema.md` e os dois READMEs refletem o fluxo novo: tema novo não exige mexer no smali.
- **Não mudou**: o layout único por tema continua como opção futura (item 6.2 do plano).

## Verificado aqui
`res_check.py` sem problemas, `smali_regcheck.py smali/ --base` com 0 métodos com problema em relação ao smali da etapa 5, `check_version.py` em dia (v1.78.0, código 1078000) e XMLs bem formados. Para o item 3.5, além disso: rótulos e registradores do `KeyStyle.smali` conferidos por script e uma simulação do raio de cada camada de todos os drawables de tecla com raio 0, 8 e 30 (só o Neon muda). Não foi testado no aparelho.

## Conferir no aparelho
- Trocar entre os 5 temas: barra plana e blur no Glass, barra plana no Midnight, texto próprio das teclas de destaque no Neon e no Soft, grupo de destaque ampliado em todos (Esc, Ctrl, Alt, Tab, setas, Shift, Apagar, Espaço, Enter e 123).
- Raio das teclas em 0, 8 e 30 em cada tema: teclas, popup, balão, botões da barra e painéis. No Neon (inclusive as teclas de destaque) e no Soft, olhar o halo em volta da borda: faixa de brilho de largura uniforme, sem engrossar nos cantos nem sobra de preenchimento verde para fora. No Soft, ver a borda azul das teclas de destaque (Shift, Delete, setas, Espaço, Enter...) em repouso, pressionadas e travadas.
- Escala da barra em 60%, 100% e 150% e sugestões em 1×, 2× e 3×.
- No Glass, olhar a borda das teclas normais e de destaque sobre fundos claros e escuros (com e sem blur): clara e discreta, sem cinza fosco, um pouco mais forte em ligada, pressionada e travada.
