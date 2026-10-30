# 1.5.4 — Cores do tema na barra, ícones de 26 dp e botões de Anexos azulados

> **Revertida na 1.5.5, exceto o tamanho dos ícones (26 dp):** as cores do tema, o realce ao tocar, o fundo mais claro da barra, os botões azulados de Anexos e o fundo da categoria de emotes foram desfeitos (veja `revisao-1.5.5.md`). O código descrito aqui (`deriveColors`, `flatBg`, `panelBtn`, `liftBars`...) não existe mais. O simulador `theme_sim.py` foi removido; `dalvik_mini.py` ficou como ferramenta genérica.

## Pedido
Clarear um pouco o fundo da barra; os outros botões (painéis, emotes) com o mesmo tamanho dos da barra, e os da barra 2 dp menores; a cor ao tocar nos botões deve seguir o tema (no padrão, azulada, não cinza); os botões da aba Anexos com fundo azulado e os cantos arredondados de antes; os ícones da barra na cor do tema (no padrão, um tom parecido com o fundo das teclas de destaque).

## Como interpretei (pontos que podem ser ajustados)
- **"Cor de fundo"**: o fundo das linhas da barra de ferramentas (principal, tradução, clipboard, anexos, emotes, personalizar).
- **"Teclas de destaque"**: as teclas de função do tema (Shift, ?123, Enter...), as que se destacam das letras. No tema padrão (`slate`) o miolo delas é `#283c57`, um azul-aço.
- **"Botões da aba Anexos"**: a linha de Anexos (voltar, fotos, vídeos, arquivos, atualizar, cache).

## O que mudou
1. **Ícones em 26 dp** (antes 28 dp na linha principal): `attach, clip, emote, sheets, trans, tune`. Os ícones dos botões dos painéis passaram de 18 dp para os mesmos 26 dp: `back, globe, rec, trash, refresh, cache, shots_c, video_c, file_c, grid, list` e as categorias de emotes `cat_r, cat_0..cat_7`. Os ícones grandes de "lista vazia" e os de itens de lista não mudaram. A escala por preferência (`scaleIcons`) continua valendo sobre esse tamanho.
2. **Cor de destaque do tema** (`MrTools.deriveColors`, chamada em cada `wrap`): `keyFace()` desenha o fundo de tecla do tema, no estado "checkable" (tecla de função), num bitmap de 64 px e lê o pixel central; `sAccent` é essa cor com o matiz do tema e brilho/saturação ajustados para ler sobre o fundo: tema escuro (texto claro) brilho mínimo 0,86 e saturação máxima 0,60; tema claro brilho máximo 0,40. Sem fundo de tecla legível, usa a cor do texto. `sAccentBg` é o próprio miolo da tecla. A leitura usa uma cópia do drawable (o do teclado não é tocado) e tem `catch`, então não pode derrubar a barra.
   - Tema padrão: miolo `#283c57` → ícones `#6597db` (contraste 5,0:1 com a barra). Tema "mr soft": `#001769` → `#5875db` (4,0:1).
3. **Ícones da barra** (`btn()`): tingidos com `sAccent` em vez da cor do texto. O texto dos botões continua na cor do texto do tema.
4. **Realce ao tocar** (`MrTools.flatBg`): a cor de destaque a 30% num retângulo de cantos de 20 dp (antes cinza `#33808080`). Cada botão recebe seu próprio drawable. O campo de tradução (EditText) mantém o contorno do layout. O XML `mr_tb_btn` ficou só como valor inicial (azul).
5. **Fundo mais claro** (`liftBars`): cada linha da barra recebe o fundo do teclado com um véu branco de 10% por cima (`0x1affffff`; no padrão `#0a0e14` → cerca de `#222529`). A raiz do teclado **não** muda: o mesmo fundo aparece sob a barra de gestos e ali ficaria uma faixa mais clara. O preenchimento de cada linha é restaurado (fundos de tema 9-patch trazem preenchimento próprio). Os painéis abertos (cartões de clipboard, anexos, idioma) continuam com o fundo que já tinham.
6. **Aba Anexos** (`panelBtn`, para tags `shot_*`): fundo azulado = miolo da tecla de destaque (`sAccentBg`), borda de 1 dp na cor de destaque a 40%, cantos de 10 dp como antes; ao tocar, fundo na cor de destaque a 50% (mais claro). Ícones e texto na cor do texto do tema (contraste 9,6:1 com o fundo no padrão).
7. **Emotes**: a categoria selecionada tinha o fundo de tecla; sem ele só havia a opacidade. Agora ela recebe um fundo na cor de destaque a 25% (`selBg`, mesmo formato do toque). Pequena adição para não perder a indicação de seleção.

## Onde mexer nos valores
`MrTools.smali`: véu `0x1affffff` em `lift`; brilho 0,86 / saturação 0,60 / 0,40 em `deriveColors`; toque `0x4d000000` em `flatBg`; fundo ao tocar `0x80` e borda `0x66` em `panelBtn`; seleção `0x40000000` em `selBg`. Ícones: `android:width/height` em `res/drawable/ic_mr_*.xml`.

## Validação
- `apktool b` (2.11.1) sem erros; APK desmontado: versão v1.54.0 (código 1054000), ícones de 26 dp, métodos novos presentes, `selBg` usado em `MrEmotes`.
- `docs/tools/dalvik_mini.py` (interpretador Dalvik reaproveitável) e `docs/tools/theme_sim.py`: executam o **smali** de `deriveColors`, `keyFace`, `flatBg`, `selBg`, `panelBtn`, `lift`, `liftBar`, `liftBars` e `btn` com Color/Bitmap/Drawable/View de mentira e **os drawables reais do projeto** (miolo da tecla de destaque dos temas `slate` e `mr`). Conferem cores exatas (conversão HSV igual à do Skia), estados dos fundos, que o EditText não troca de fundo, que a raiz não muda, preenchimento restaurado e os caminhos de falha (sem fundo de tecla, exceção, pixel transparente). Passa.
- Testes de mutação (alterar o smali de propósito): 19 mutações, 19 detectadas (estado da tecla, constantes de brilho/saturação/transparência, raio, guarda do EditText, prefixo `shot_`, cor dos ícones, linha esquecida, preenchimento, cópia do drawable, `catch`, pixel transparente). Uma mutação (o preenchimento da linha) passou na primeira rodada por teste fraco; reforcei o teste e ela passou a ser detectada.
- Achado durante os testes: no tema "mr" o ícone com brilho 0,82 e saturação cheia ficava `#002ed1` (escuro demais, contraste 2:1); por isso o limite de saturação e o brilho mínimo 0,86.
- Temas com fundo de tecla em imagem (gingerbread, ICS, stone, neon, material): não consegui calcular a cor fora do aparelho; o código lê o pixel central da imagem e, se vier transparente ou falhar, os ícones ficam na cor do texto do tema.
- Limite: o interpretador cobre só as instruções usadas e não é o verificador do ART. **Não houve execução no aparelho.**

## Testes Android necessários
1. Tema padrão: ícones da barra em azul-aço claro (não branco), todos do mesmo tamanho; ao tocar, realce azulado translúcido (não cinza).
2. Fundo da barra um tom mais claro que as teclas; sem faixa clara sob a barra de gestos.
3. Aba Anexos: botões com fundo azulado e cantos arredondados; ao tocar ficam mais claros; ícones brancos legíveis. Trocar Fotos/Vídeos/Arquivos continua alternando a opacidade.
4. Emotes: ícones das categorias com o mesmo tamanho dos da barra; a selecionada com fundo azulado; a barra rola se não couber.
5. Clipboard (gravar, ver, limpar) e Tradução (voltar, idioma): ícones 26 dp, cor do tema, sem fundo; campo de tradução com contorno.
6. Outros temas (claro e escuro) e fontes grandes/escala de ícones: ícones legíveis e sem cortes.
