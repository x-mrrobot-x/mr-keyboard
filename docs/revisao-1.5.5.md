# 1.5.5 — Estilo da barra e dos painéis de volta ao da 1.5.2

## Pedido
Reverter só o tema para como era na 1.52 (cores das teclas, cor de fundo e afins dos botões da barra de ferramentas e o padrão dos painéis dentro das ferramentas), mantendo as modificações atuais que não são de estilo.

## O que foi revertido (arquivos restaurados da 1.5.2)
- `MrTools.smali` inteiro: os botões da barra e dos painéis voltam a receber o **fundo de tecla do tema** (`sKeyBg`) em `btn()`, com os ícones na **cor do texto** do tema. Saem `deriveColors`, `keyFace`, `flatBg`, `selBg`, `panelBtn`, `lift`, `liftBar(s)` e os campos `sAccent`/`sAccentBg`. Isso desfaz de uma vez: botões sem fundo (1.5.3), realce de toque na cor de destaque, ícones na cor de destaque, linhas da barra mais claras, botões azulados de Anexos (1.5.4).
- `MrEmotes.smali`: a categoria selecionada volta a usar o fundo do próprio botão (o de tecla do tema), em vez do `selBg`.
- `res/drawable/mr_tb_btn.xml`: de volta o fundo cinza translúcido com borda de 1 dp e cantos de 10 dp (usado pelo estilo `MrShotBtn` e como valor inicial dos botões).
- `res/layout/mr_toolbar.xml`: o campo de tradução (`t_field`) volta a usar `mr_tb_btn`; `res/drawable/mr_tb_field.xml` foi removido.
- Teclas (de letras e especiais), fundo do teclado e temas: **não tinham sido tocados** desde a 1.5.2 (nenhum arquivo `key_*`, `btn_keyboard_key_*` ou `input_*` difere da 1.5.2), então não havia o que reverter neles.
- Conferência: `diff` do projeto contra a 1.5.2 mostra só os arquivos mantidos abaixo, as versões e os documentos/ferramentas; o código removido não tem mais nenhuma referência.

## O que foi mantido
- **Sugestões em 3 posições fixas e centralizadas** (1.5.3): `CandidateView` inteiro, incluindo o tom cheio no centro e 65% nas laterais, que já eram assim na 1.5.2.
- **Tamanho dos ícones em 26 dp** (1.5.4) na linha principal e nos botões dos painéis (voltar, idioma, gravar, lixeira, atualizar, cache, fotos/vídeos/arquivos, grade/lista, categorias de emotes). Considerei tamanho como medida, não como tema. Para voltar aos 18 dp da 1.5.2, troque `android:width/height` de `26dp` para `18dp` nos `res/drawable/ic_mr_*.xml` (os da linha principal eram 18 dp também).
- Atraso de 1 s para mostrar as ferramentas, toque longo na palavra digitada, tecla da barra como alternador e o dicionário: não mudaram.

## Validação
- `apktool b` (2.11.1) sem erros; APK desmontado: versão v1.55.0 (código 1055000); `btn()` com `sKeyBg`/`dupe`/`tint` como na 1.5.2; `mr_tb_btn` cinza com borda; sem `mr_tb_field`; ícones em 26 dp.
- `docs/tools/strip_sim.py` (sugestões em 3 posições) continua passando nos 6000 casos.
- Não houve execução no aparelho.

## Testes Android necessários
1. Linha da barra: botões com o fundo de tecla do tema, ícones na cor do texto, como na 1.5.2 (agora com ícones de 26 dp dentro deles; confirme se cabem sem ficar apertados).
2. Painéis (clipboard, tradução, anexos, emotes, personalizar): botões com o fundo de tecla do tema; categoria de emote selecionada com fundo de tecla.
3. Campo de tradução com o fundo de tecla do tema, como antes.
4. Digitar: 3 posições fixas, palavra no centro em tom cheio e laterais mais apagadas.
