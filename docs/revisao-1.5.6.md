# 1.5.6 — Novo tema "Midnight Steel" (estilos do tema padrão do projeto Midnight Steel)

> **Ajustado na 1.5.7** (veja `revisao-1.5.7.md`): campo de tradução, painel de idiomas, idioma selecionado e fundo dos botões dos painéis (incluindo os de Anexos, que deixaram de ser azulados) mudaram só no Midnight Steel. `panelBtn` foi substituído por `panelBg`.

## Pedido
Criar, neste projeto, um tema chamado **Midnight Steel** com só os estilos do tema padrão do projeto `mr-keyboard-midnight-steel`: fundo do teclado, fundo da linha da barra (onde ficam as sugestões), cores das teclas de texto e das teclas de destaque, painel das ferramentas e afins.

## O que foi criado
- **Opção de tema** "Mr Keyboard Midnight Steel" (valor `9`) na lista *Tema do teclado*, depois do Dark Tech (relevo). Os temas existentes e o tema padrão (`8`) **não mudaram**; para usar o novo, escolha-o nas configurações.
- **Fundo do teclado** `#0c1219` (`mr_midnight_kbd_bg`, em `res/layout/input_mr_midnight.xml`).
- **Teclas** (`key_midnight_*` + `btn_keyboard_key_midnight`): preenchimento liso (sem degradê), cantos de 6 dp, sombra `#4d000000`. Tecla de texto `#202832` com borda `#252e39`; tecla de destaque (Shift, ?123, Enter...) `#2c3e53` com borda `#34485f`. Dica de tecla `#8d95a0`. Cor do texto das teclas: a mesma dos outros temas (`mr_text_primary`).
- **Linhas da barra** (principal com as sugestões, tradução, clipboard, anexos, emotes, personalizar): fundo `#171e27`, um tom mais claro que o do teclado (`liftBar`/`liftBars`).
- **Botões da barra e dos painéis**: sem fundo de tecla; ao tocar, realce na cor de destaque do tema a 30% com cantos de 20 dp (`flatBg`). Ícones em `#dfe7f1`. O campo de tradução mantém o contorno do layout.
- **Aba Anexos**: botões com fundo azulado (miolo da tecla de destaque), borda de 1 dp e cantos de 10 dp (`panelBtn`).
- **Emotes**: a categoria selecionada ganha fundo na cor de destaque a 25% (`selBg`).
- A cor de destaque vem de `MrTools.deriveColors()`: lê o miolo da tecla de destaque (`#2c3e53`) e o ajusta para ler sobre o fundo escuro (brilho mínimo 0,86, saturação máxima 0,60), o que dá um azul-aço claro (`#74a4db`).

## Como foi ligado ao código
- `KeyboardSwitcher`: o vetor `THEMES` passou de 9 para 10 posições; a nova (`0x7f0a003f`) é o layout `input_mr_midnight`, registrado em `public.xml`.
- `KeyStyle.ensureLoaded`: o valor `9` usa o mesmo modo do Dark Tech (relevo), então **espaçamento** e **arredondamento** das teclas (ajustes das configurações) valem também no novo tema.
- `MrTools`: o layout do tema traz a tag `mr_midnight` e `MrTools.isMidnight()` a lê. Todo o estilo acima (`deriveColors`, `liftBars`, `flatBg`, `panelBtn`, ícones `#dfe7f1`) só roda quando a tag está presente; nos outros temas o caminho de código é o da 1.5.5 (fundo de tecla do tema nos botões, ícones na cor do texto).
- `MrEmotes`: usa `selBg()` só no Midnight Steel; nos outros temas segue o fundo do próprio botão.
- O popup de teclas (`input_popup_slate`) é o mesmo do projeto de origem, sem mudanças.

## O que ficou de fora (de propósito)
Só estilos foram trazidos. Nada de comportamento do projeto Midnight Steel foi copiado, nem o simulador `theme_sim.py`. O tamanho dos ícones (26 dp) continua o da 1.5.5 para todos os temas.

## Arquivos
Novos: `res/layout/input_mr_midnight.xml`, `res/drawable/btn_keyboard_key_midnight.xml`, `res/drawable/key_midnight_{normal,hl,lock,on,pressed}.xml`. Alterados: `res/values/{mr_colors,strings,arrays,public}.xml`, `res/values-pt-rBR/strings.xml`, `KeyboardSwitcher.smali`, `KeyStyle.smali`, `MrTools.smali`, `MrEmotes.smali`, versão em `apktool.yml`/`apktool.json` (v1.56.0, código 1056000).

## Validação
- Os métodos de estilo foram copiados do projeto Midnight Steel; só `liftBar` foi simplificado (sem o ramo dos outros temas) e `btn()`/`wrap()`/`MrEmotes.setup` ganharam o desvio por tema.
- Conferência estática dos arquivos smali alterados: rótulos de desvio todos definidos e sem repetição, registradores dentro de `.locals`.
- **Não rodei o `apktool b` nem o app** (o ambiente não tem apktool nem Android). Precisa compilar e testar no aparelho.

## Testes Android necessários
1. Configurações → Tema do teclado: aparece "Mr Keyboard Midnight Steel"; ao escolher, o teclado muda na hora.
2. Teclado: fundo `#0c1219`, teclas lisas com cantos arredondados, Shift/?123/Enter mais azulados que as letras.
3. Linha da barra (ferramentas e sugestões) um tom mais clara que o teclado; ícones claros e sem fundo, com realce azulado ao tocar.
4. Abrir Clipboard, Traduzir, Anexos, Emotes e Personalizar: linhas com o mesmo fundo; botões de Anexos azulados; categoria de emote selecionada com fundo azulado.
5. Trocar para o Dark Tech (relevo) e para os demais: devem estar exatamente como antes.
6. Espaçamento e arredondamento das teclas (configurações) agindo no Midnight Steel.
