# 1.5.7 — Midnight Steel: campo de tradução, painel de idiomas e botões dos painéis

## Pedido
No tema Midnight Steel: mudar a cor de fundo do campo "Digite aqui para traduzir", o fundo do painel de idiomas (entrada e saída) e a cor dos idiomas selecionados; e melhorar o fundo dos botões dentro das ferramentas (por exemplo o voltar), numa cor mais próxima da barra, sem destacar muito.

## O que mudou (só no Midnight Steel)
| Item | Antes | Agora |
|---|---|---|
| Campo de tradução (`t_field`) | cinza translúcido `#22808080`, borda `#44808080` | fundo `#0e141b` (mais escuro que a barra, `#171e27`), borda de 1 dp `#2a3645`, cantos de 10 dp |
| Painel de idiomas (`p_lang`) | fundo `#111823`, borda `#2a3748` | fundo `#1a232e`, borda `#2c3a4b` |
| Idioma selecionado | cor do texto a 20% (cinza-claro) | cor de destaque do tema (`#74a4db`) a 28% |
| Botões dos painéis (voltar, idioma, clipboard, anexos, emotes, personalizar) | sem fundo; os de Anexos, azul `#2c3e53` com borda azul | fundo `#1e2631`, borda `#273241`, cantos de 10 dp; ao tocar, destaque a 35% |

## Como interpretei
- "Botões dentro das ferramentas" = os botões dos painéis abertos (voltar do Traduzir, Clipboard, Anexos, Emotes e Personalizar; idioma; alternar e limpar do Clipboard; fotos, vídeos, arquivos, atualizar e cache). Ficam como estavam (planos, sem fundo): os botões da linha principal (`b_*`) e as abas de categoria de emote (`cat_*`).
- "Cor mais próxima da barra": o fundo dos botões é só um pouco mais claro que a barra `#171e27` (diferença de cerca de 8 a 10 em cada canal), com borda fina no mesmo tom.
- Os painéis do Clipboard e de Anexos **não** mudaram de fundo; só o de idiomas.

## Como foi feito (`MrTools.smali`)
- `fieldBg()` e `panelBg()` (novos) substituem `panelBtn`. `btn()` escolhe: EditText → `fieldBg`; tags `b_*` e `cat_*` → `flatBg`; os demais → `panelBg`. Os ícones ficam todos em `#dfe7f1` (antes os de Anexos usavam a cor do texto).
- `sheet()`: para `p_lang` no Midnight Steel usa `#1a232e` / `#2c3a4b`; os outros painéis seguem como antes.
- `deriveColors()`: passa a definir `sSelColor` (cor do idioma selecionado, usada só nas listas de idioma) como a cor de destaque a 28%. Só roda no Midnight Steel; nos outros temas o `sSelColor` continua o da 1.5.5.

## Onde mexer nos valores
`MrTools.smali`: `fieldBg` (`0xff0e141b` fundo, `0xff2a3645` borda); `panelBg` (`0xff1e2631` fundo, `0xff273241` borda, `0x59000000` ao tocar); `sheet` (`0xff1a232e` fundo, `0xff2c3a4b` borda do `p_lang`); fim de `deriveColors` (`0x47000000` = idioma selecionado).

## Validação
- Conferência estática: rótulos de desvio definidos e únicos, registradores dentro de `.locals`, sem referências restantes a `panelBtn`.
- **Não rodei o `apktool b` nem o app.** Precisa compilar e testar no aparelho.

## Testes Android necessários
1. Traduzir: o campo mais escuro que a barra, com borda fina; o texto e a dica continuam legíveis; digitar e apagar normalmente.
2. Tocar no botão de idiomas: o painel com o novo fundo; o idioma selecionado em azul-aço, nas duas colunas.
3. Botão voltar (Traduzir, Clipboard, Anexos, Emotes, Personalizar) e demais botões dos painéis com fundo discreto; o toque os realça em azul.
4. Linha principal e abas de categoria de emote continuam planas.
5. Dark Tech (relevo) e os outros temas: sem nenhuma mudança.
