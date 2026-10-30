# 1.5.9 — Anexos e Idiomas sem borda, abas de Anexos sem opacidade e aba de emote igual ao voltar

## Pedido
- Painel de Anexos: tirar a borda que rodeia os cards de mídia e deixar o fundo do painel na cor da barra de ferramentas.
- Cards de arquivos na cor do tema.
- Botões não marcados (Fotos, Vídeos, Arquivos): melhorar a cor sem usar opacidade, que deixava os ícones meio lilás.
- Aba de emote ativa com o mesmo fundo e borda do botão voltar.
- Painel de idiomas (entrada e saída) do Traduzir: tirar a borda e deixar o fundo na cor da barra.

## O que mudou (só no Midnight Steel)
| Item | Antes | Agora |
|---|---|---|
| Painel de Anexos (`p_shots`) | fundo `#111823`, borda `#2a3748`, cantos de 14 dp, margem escura em volta | fundo `#171e27` (igual à barra), sem borda, sem faixa escura em volta |
| Painel de idiomas (`p_lang`) | fundo `#1a232e`, borda `#2c3a4b` | fundo `#171e27`, sem borda, sem faixa escura em volta; a linha fina entre entrada e saída continua |
| Cards de arquivos e fundo dos cards de mídia enquanto carregam | cinza translúcido `#33888888` | `#263344`, o mesmo fundo dos botões dos painéis, cantos de 10 dp |
| Aba marcada de Anexos | botão do painel, opacidade 100% | igual: fundo `#263344`, borda `#3a4d65`, ícone `#dfe7f1` |
| Abas não marcadas de Anexos | botão do painel com opacidade 50% (ícone `#7c848f`, contraste 3,9:1) | sem opacidade: fundo `#1e2937`, borda `#2c3b4f`, ícone azul-aço `#9db1c8` (contraste 6,7:1) |
| Aba de emote ativa | fundo azulado (cor de destaque a 32%) e borda a 55% | fundo `#263344` e borda `#3a4d65`, iguais aos do botão voltar |

Os outros painéis (Clipboard, Emotes) e os outros temas não mudaram em relação à 1.5.8.

## Como foi feito
- `MrTools.smali`:
  - `flatSheet()` (da 1.5.8) passou a ser chamado também para `p_lang` e `p_shots`, logo após `sheet()`. Zera as margens do painel, pinta `#171e27` e passa as margens para o preenchimento, então o conteúdo fica na mesma posição.
  - `selBg()`: `0xff263344` e `0xff3a4d65`, borda de `sPad / 10` (1 dp), cantos de `sPad`.
  - `tabOffBg()` (novo): fundo das abas não marcadas, `0xff1e2937` e `0xff2c3b4f`.
  - `shotTab(TextView, boolean)` (novo): opacidade 1, fundo (`panelBg` se marcada, `tabOffBg` se não) e cor do ícone (`#dfe7f1` ou `0xff9db1c8`).
  - `cardBg()` (novo): fundo dos cards; `0xff263344` no Midnight Steel e o cinza translúcido de antes nos outros temas.
- `MrShots.smali`:
  - `styleTabs()`: no Midnight Steel chama `shotTab` para as três abas (marcada: Arquivos, Vídeos ou Fotos, nessa ordem de prioridade, como antes); nos outros temas segue com a opacidade de 50%.
  - `getView()` e `getFileView()`: o fundo do card vem de `MrTools.cardBg()`.

## Onde mexer nos valores
- Fundo e borda dos botões e da aba de emote ativa: `selBg` e `panelBg` (`0xff263344`, `0xff3a4d65`).
- Abas de Anexos não marcadas: `tabOffBg` (`0xff1e2937`, `0xff2c3b4f`) e o ícone em `shotTab` (`0xff9db1c8`).
- Cards de arquivos e de mídia: `cardBg` (`0xff263344`).
- Para voltar um painel à moldura com borda: remover a chamada a `flatSheet` dele em `wrap()`.

## Validação
- Conferência estática dos métodos smali alterados: registradores dentro de `.locals`, rótulos definidos e sem repetição. Os valores booleanos passados a `shotTab` são constantes `0x0` e `0x1`, sem aritmética sobre booleanos.
- **Não rodei o `apktool b` nem o app** (o ambiente não tem apktool nem Android). Precisa compilar e testar no aparelho.

## Testes Android necessários
1. Anexos, aba Fotos, Vídeos e Arquivos: painel na cor da barra, sem borda e sem faixa escura em volta; a grade e a rolagem continuam como antes.
2. Abas de Anexos: a marcada com fundo e borda de botão e ícone claro; as outras com fundo mais escuro e ícone azul-aço, sem aspecto lilás. Trocar de aba alterna o destaque.
3. Aba Arquivos: os cards com fundo `#263344`, texto e ícone legíveis.
4. Traduzir, botão de idiomas: painel sem borda e na cor da barra, com a linha entre as duas colunas; o idioma selecionado continua em azul-aço.
5. Emotes: a categoria ativa com o mesmo fundo e borda do botão voltar.
6. Dark Tech (relevo) e outros temas: Anexos e Idiomas como antes (cards cinza, abas com 50% de opacidade, painéis com moldura).
