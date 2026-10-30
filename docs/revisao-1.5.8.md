# 1.5.8 — Emotes sem borda, botões padronizados e mais espaço vertical

> **Ajustado na 1.5.9** (veja `revisao-1.5.9.md`): a categoria de emote selecionada passou a usar o mesmo fundo e a mesma borda do botão voltar (`selBg`), em vez do destaque azulado descrito aqui.

## Pedido
Na tela de emotes: fundo do painel na cor da barra de ferramentas, sem a borda ao redor dos emotes, texto das categorias com cor ajustada se preciso, e o arredondamento dos botões de emote igual ao do botão voltar. Aumentar o espaço vertical entre os botões e as margens de cima e baixo da barra, em todos os botões (inclusive Traduzir e Anexos), de forma padronizada. Melhorar um pouco a cor dos botões.

## O que mudou
| Item | Antes | Agora |
|---|---|---|
| Painel de emotes (`p_emote`), Midnight Steel | fundo `#111823`, borda `#2a3748`, cantos de 14 dp, margem escura de 2/6 dp em volta | fundo `#171e27` (igual à barra), sem borda, sem cantos, sem faixa escura em volta: barra e painel formam uma superfície só |
| Texto das categorias ("Recentes", "Carinhas e pessoas"...), Midnight Steel | cinza `#8d95a0` (contraste 5,5:1) | azul-aço `#9db1c8` (7,6:1 sobre `#171e27`) |
| Categoria de emote selecionada | cantos de 20 dp, sem borda, destaque a 25% | cantos de 10 dp (iguais ao voltar), borda de 1 dp, destaque a 32% e borda a 55% |
| Realce ao tocar nos botões planos (barra principal e abas) | cantos de 20 dp | cantos de 10 dp |
| Botões dos painéis (voltar, idioma, Anexos, Clipboard...), Midnight Steel | fundo `#1e2631`, borda `#273241` | fundo `#263344`, borda `#3a4d65` (um passo mais claro e mais azulado que a barra); toque inalterado (destaque a 35%) |
| Altura das barras (principal, traduzir, clipboard, anexos, emotes, personalizar) | 44 dp | 48 dp |
| Margem vertical dos botões | 3 dp (4 dp até a borda da barra) | 5 dp (6 dp até a borda da barra) |
| Voltar e idioma do Traduzir | 40 dp de altura (2 dp até a borda) | 36 dp, como os demais |
| Campo de tradução | altura mínima de 40 dp | 36 dp |

Todos os botões ficam com 36 dp de altura e 6 dp de espaço em cima e embaixo, em qualquer barra. Os botões de Anexos já tinham 36 dp; só ganharam espaço pela barra mais alta.

## Alcance
- **Layout** (`res/layout/mr_toolbar.xml`): altura das barras, margens e alturas dos botões valem para **todos os temas**.
- **Cores, bordas, cantos e painel de emotes**: só no **Midnight Steel**. Dark Tech (relevo) e os demais temas seguem como estavam.

## Como foi feito
- `MrTools.smali`:
  - `flatBg()`: cantos de `sPad` (10 dp) em vez de `2 * sPad`.
  - `selBg()`: cantos de `sPad`, borda de `sPad / 10` (1 dp), preenchimento `0x52` e borda `0x8c` de alfa sobre a cor de destaque.
  - `panelBg()`: `0xff263344` (fundo) e `0xff3a4d65` (borda).
  - `flatSheet()` (novo), chamado em `wrap()` logo após `sheet()` do `p_emote`: só no Midnight Steel, lê as margens do painel, zera as margens, troca o fundo por `#171e27` liso e passa as margens para o preenchimento do painel. O conteúdo fica na mesma posição e `fitHeight()` continua dando a altura certa ao painel.
- `MrEmotes.smali`: `header()` usa `#9db1c8` no Midnight Steel; nos outros temas segue `sHint`.
- `apktool.yml` / `apktool.json`: v1.58.0 (código 1058000).

## Onde mexer nos valores
- Espaço vertical: `android:layout_marginTop/Bottom` (5 dp) e `android:layout_height` das barras (48 dp) em `mr_toolbar.xml`.
- Cor dos botões: `panelBg` (`0xff263344`, `0xff3a4d65`). Aba selecionada: `selBg` (`0x52000000`, `0x8c000000`).
- Cor do painel de emotes: `flatSheet` (`-0xe8e1d9` = `#171e27`, a mesma de `liftBar`).
- Cor dos títulos das categorias: `MrEmotes.header` (`0xff9db1c8`).
- Para voltar o painel de emotes com moldura e borda: remover a chamada a `flatSheet` em `wrap()`.

## Validação
- XML de `mr_toolbar.xml` lido sem erro; nenhum `layout_margin="3dp"` restante.
- Conferência estática dos métodos smali alterados: registradores dentro de `.locals`, rótulos definidos e sem repetição.
- **Não rodei o `apktool b` nem o app** (o ambiente não tem apktool nem Android). Precisa compilar e testar no aparelho.

## Testes Android necessários
1. Emotes: painel na mesma cor da barra, sem borda e sem faixa escura em volta; "Recentes" e as categorias em azul-aço legível; os emotes continuam na mesma posição e a lista rola normalmente.
2. Categoria selecionada com cantos iguais aos do botão voltar e borda azulada fina; as outras seguem apagadas.
3. Voltar, Traduzir (voltar, campo, idiomas), Clipboard, Anexos e Personalizar: botões com a mesma altura, mais espaço em cima e embaixo, fundo um pouco mais claro e azulado que antes.
4. Campo de tradução: texto e dica sem corte na altura de 36 dp; digitar e apagar normalmente.
5. Barra principal: sugestões e botões sem corte na altura de 48 dp; realce ao tocar com cantos de 10 dp.
6. Dark Tech (relevo) e outros temas: cores e painéis como antes; só o espaço vertical dos botões muda.
