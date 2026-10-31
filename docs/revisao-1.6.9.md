# 1.69 — Configurações reorganizadas e temas de forma

## Pedido
Analisar todas as configurações, tirar as de versões antigas, agrupar as parecidas e deixar as telas mais organizadas (plano em `plano-configuracoes.md`). Decisões do dono: tirar o volume do clique (depois de volta, ver a rodada 2); manter a entrada de voz como está; espaçamento e arredondamento valem em qualquer tema (saem os temas de imagem); incluir "Restaurar padrões". Depois dos testes no aparelho vieram a rodada 2 (ajustes de várias opções) e a rodada 3 (barra, cartões, varredura de sobras). Esta é a versão de commit.

## Organização final (tela principal: de 7 para 6 categorias)
- **Aparência:** tema, altura vertical e horizontal, **altura da barra de ferramentas e sugestões** e a página **Teclas e rótulos** (espaçamento, arredondamento, símbolo do Shift nas teclas e escala dos rótulos).
- **Layout:** folhas do teclado, modos vertical e horizontal e o interruptor da tecla de configurações. ("Voltar à folha principal ao digitar" fica dentro da página Folhas do teclado.)
- **Digitação:** Sugestões e dicionários (com o tamanho do texto das sugestões, cinza com as sugestões desligadas), capitalização automática e entrada de voz (sem aviso novo).
- **Toque e gestos:** duração do toque longo, **Popup ao pressionar a tecla** e as páginas **Vibração, som e prévia** e **Gestos e teclas de volume** (sem a categoria "Folhas").
- **Geral:** idioma do app, notificação permanente, **Avançadas** (dois grupos: Ctrl e Alt, e Comportamento) e **Restaurar padrões** (card rosado, por último).
- **Sobre:** versão e o cartão **by x-mrrobot-x** (abre o perfil no GitHub).

## O que mudou na 1.69
### Saíram da tela (o código usa o padrão de antes)
Método de desenho, eventos de teclas ao deslizar, truque do ConnectBot, depuração da posição do toque e o método do volume do clique (o controle de volume voltou, ver a rodada 2). Saíram junto os textos, listas e a tela `language_prefs.xml` sem uso.

### Temas
- Saíram os 6 temas de imagem (9-patch): Ice Cream Sandwich (dicas escuras), Material escuro, Material claro, Gingerbread, Stone (negrito) e Transparente (experimental). Ficam os 4 de forma: **Mr Keyboard Neon, Dark Tech suave, Dark Tech relevo e Midnight Steel**. Quem usava um dos removidos cai no Dark Tech relevo (a tabela `THEMES` do `KeyboardSwitcher` aponta os índices antigos para o layout do relevo).
- **Espaçamento e arredondamento valem nos 4 temas** (antes só em 3 de 10): `KeyStyle` deixa de olhar o tema, e o recuo das margens do `Keyboard` também. A fila de extensão (a linha extra que aparece com o gesto) continua com as teclas de imagem da ICS e só recebe o espaçamento.
- Saíram 9 layouts, 37 imagens/seletores e 10 cores que só esses temas usavam (60 arquivos).

### Restaurar padrões
Em Geral, com confirmação. Apaga só as chaves de configuração (as mesmas das telas, `MrReset.KEYS`) e deixa como estão: dicionários baixados, folhas do usuário (`files/sheets.json`), emotes recentes e avisos já vistos. Os idiomas do teclado voltam a ser os dos dicionários instalados e a tela se recria. `docs/tools/check_reset_keys.py` confere se a lista cobre todas as chaves das telas.

## Ajustes da rodada 2 (depois dos testes no aparelho)
1. **Altura da barra de ferramentas e sugestões** (60% a 150%, padrão 100%, em Aparência). `MrBar` aplica 48 dp × escala na linha `bar_main` do `mr_toolbar` quando a barra é montada e a cada mudança da opção. O ajuste antigo "altura da 5ª linha" saiu: ele mexia na linha de cima das teclas (a 7ª de 7 no modo Padrão); o código ignora qualquer valor antigo guardado (`GlobalKeyboardSettings$9`).
2. **Símbolo do Shift nas teclas** (antes "Teclas alternativas com rótulo"): o nome diz que vale nos modos Compacto e Completo (só neles as teclas têm símbolo de Shift); opções Ocultar, Só símbolos ASCII e Todos os símbolos.
3. **Voltar à folha principal ao digitar** é um cartão na página Folhas do teclado, abaixo do ABC (`MrSheetOpt`, mesmo visual do cartão ABC), com o mesmo padrão e a mesma chave.
4. **Mostrar tecla de configurações** virou interruptor (`show_settings_key`, padrão ligado). Antes a lista só mostrava "Automático" (faltavam 2 entradas) e, se alguém escolhesse outra, o resumo da tela quebraria. Vale só no modo Padrão (liga ou tira a engrenagem da linha de baixo).
5. **Popup ao pressionar a tecla** (antes "Conteúdo do miniteclado pop-up"): sai "Incluir com Shift" (igual a "Só únicos" no modo Padrão); padrão "Só únicos".
6. **Volume do clique** voltou logo abaixo de "Som ao pressionar a tecla" (0 a 100%, padrão 80%, ativo só com o som ligado). O método fica fixo em "volume absoluto" (`default_click_method` = 1) e usa a curva de volume que já existia no `LatinIME` (faixa de 72 dB), então o ponto ideal do padrão só se acerta no aparelho.
7. **Prévia da tecla** (antes "Pop-up ao pressionar a tecla"): o balão com a tecla acima do dedo; a página virou "Vibração, som e prévia".
8. **Avançadas:** saem Shift Lock nas modificadoras, Modo de toque duplo no Shift (fica Caps Lock) e Código da tecla Meta. Ficam Substituição do Ctrl-A, código Ctrl e código Alt (grupo "Ctrl e Alt") e tela cheia no modo horizontal e mostrar teclado virtual (grupo "Comportamento").
9. **Detalhes da conexão de entrada** saiu de Sobre (ferramenta de diagnóstico).
10. **Restaurar padrões** com card rosado suave (`mr_ui_pref_row_danger` e `mr_ui_card_ripple_danger`: fundo `mr_ui_rose_soft`, borda `mr_ui_rose_line`, título `mr_ui_rose`).

## Ajustes da rodada 3 (versão de commit)
1. **Altura da barra com o mesmo padrão da altura do teclado:** o controle abre o modal com o campo para digitar o valor e o teclado fica visível, e a barra muda na hora enquanto se ajusta (cancelar volta ao valor anterior). Foi só incluir `pref_bar_scale` na lista "ao vivo" de `SeekBarPreferenceString.isLive()`, a mesma que já vale para a altura do teclado, a escala dos rótulos, o espaçamento e o arredondamento.
2. **Cartão "Voltar à folha principal"** afastado do cartão ABC (margem de cima de 2 dp para 14 dp em `MrSheetOpt`).
3. **Restaurar padrões** movido de Sobre para **Geral** (último item, card rosado).
4. **Sobre** ganhou o cartão **by x-mrrobot-x** (`mr_author`, sem valor guardado; toque abre `https://github.com/x-mrrobot-x`). Resumo da categoria: "Versão e autor".
5. **Varredura de sobras** (ver abaixo).

### Varredura de sobras
Feita por análise de referências (manifest, XML, constantes de ID e nomes lidos por texto no smali e nos fontes Java), mais conferência de `public.xml` e das chaves de preferência:
- **Ícones sem uso removidos:** `mr_ui_ic_globe_mint` e `mr_ui_ic_grid_mint` (sobraram da tela de idiomas) e `ic_mr_file`, `ic_mr_shots` e `ic_mr_video` (as telas usam as variantes `_c`, `_lg` e `_xl`).
- **Textos sem uso removidos:** `mr_shot_photos` e `mr_shot_videos` (nos dois idiomas e no `public.xml`).
- **Procuras de opções que já não existem tiradas do smali:** `settings_key` e `input_connection_info` em `LatinIMESettings` e `pref_render_mode` em `PrefScreenView` (campos e constante `PREF_SETTINGS_KEY` junto). Antes a procura devolvia nulo e o código seguia; agora nem procura.
- **Nomes padronizados:** "pop-up" virou "popup" em pt-BR (título, lista de opções e resumo de Toque e gestos), como no nome escolhido ("Popup ao pressionar a tecla"); o resumo de Toque e gestos cita a prévia da tecla.
- **Documentação:** `plano-configuracoes.md` marcado com o que mudou depois do plano.
- **Conferido e sem sobra:** nenhum recurso sem uso além de `status_bar_notification_info_overflow` (da biblioteca de suporte); nenhuma entrada do `public.xml` sem recurso, repetida ou com ID repetido; os 52 atributos de `attrs.xml` têm uso; nenhuma chave de tela sem entrada em `MrReset.KEYS`; nenhum arquivo de backup ou de patch na árvore.
- **Mantido de propósito:** as chaves de opções que saíram (`pref_render_mode`, `pref_slide_keys_int`, `connectbot_tab_hack`, `pref_touch_pos`, `pref_click_method`, `pref_caps_lock`, `pref_shift_lock_modifiers`, `pref_chording_meta_key`, `pref_top_row_scale`, `settings_key`) ainda são lidas por `LatinIME` e `GlobalKeyboardSettings` com o valor padrão, porque o teclado depende dos campos que elas preenchem. Estão em `MrReset.KEYS` para o "Restaurar padrões" apagar um valor antigo guardado. Tirar essa leitura exigiria mexer no motor do teclado sem ganho visível.

Valores antigos guardados das opções que saíram (ex.: tema removido, método de clique, Shift Lock) continuam no aparelho até um "Restaurar padrões" ou limpar os dados do app.

Versão **1.69.0** (código 1069000). Os pacotes de dicionário não mudam. O APK diminuiu de 976 KB (1.66) para cerca de 899 KB.

## Como foi feito
- `res/xml/prefs*.xml` reescritos (linhas movidas, não reescritas); textos novos e renomeados em pt-BR e inglês.
- `MrReset`, `MrBar` e `MrSheetOpt` (Java → smali, com `docs/tools/build_java.sh`); `LatinIMESettings.onCreate` liga o item "mr_reset" a `MrReset`.
- Remoção dos temas por análise de referências (layouts → seletores → imagens), só do que ficou sem uso em XML, manifest e smali; `public.xml` limpo das entradas apagadas.

## Validação
- `build_java.sh` e `apktool b` sem erro (o `aapt2` falharia com recurso faltando).
- `d2j-asm-verify` sem erros; `smali_regcheck.py` com 0 problemas no smali e no dex do APK.
- As 252 constantes de ID de recurso do smali apontam para o mesmo recurso no APK novo; nenhuma entrada do `public.xml` ficou sem recurso.
- `check_reset_keys.py`: 40 chaves nas telas, todas em `MrReset.KEYS` (51 com as antigas e `pref_sheet_return`).
- `PacksTest`: 62 OK. `ThreeLangTest`: 23 OK.
- **Não testado no aparelho:** nenhuma das telas novas, a altura da barra (e o modal ao vivo), o cartão da página de folhas e o novo espaço, a engrenagem, o volume do clique, o visual do espaçamento e do arredondamento no Neon, o cartão do autor (abre o navegador), Restaurar padrões em Geral.

## Testes Android necessários
1. Abrir Configurações: 6 categorias (Aparência, Layout, Digitação, Toque e gestos, Geral, Sobre) e nada repetido. "Folhas do teclado" só aparece em Layout.
2. Cada página abre e mostra o que a nova organização diz: **Teclas e rótulos** (espaçamento, arredondamento, símbolo do Shift, escala), **Vibração, som e prévia** (som, volume do clique e prévia da tecla), **Gestos e teclas de volume** (sem Folhas), **Avançadas** (dois grupos).
3. Em Sugestões e dicionários: o tamanho do texto das sugestões muda a faixa e fica cinza com "Mostrar sugestões" desligado.
4. Tema: só 4 na lista. Em cada um, mexer em espaçamento e arredondamento muda as teclas na hora (teclado aberto no campo de teste). No Neon, conferir se os cantos ficam bons com arredondamento alto e baixo.
5. Se o aparelho tinha um tema removido salvo (ex.: Material), o teclado abre no Dark Tech relevo, sem travar.
6. Painel de ajuste rápido do teclado (altura, rótulos, espaçamento e arredondamento): continua funcionando.
7. Geral → **Restaurar padrões**: o card é rosado e fica por último; pede confirmação; ao confirmar, tema, altura, gestos e sugestões voltam ao padrão, as folhas do usuário e os dicionários continuam, e o teclado segue nos idiomas dos dicionários instalados.
8. Entrada de voz em Digitação: o microfone continua como antes.
9. **Altura da barra:** tocar no controle abre o modal com o campo e o teclado; ao digitar ou arrastar, a barra de ferramentas e sugestões muda na hora, de 60% a 150%; confirmar guarda e cancelar volta ao valor anterior; os botões não ficam cortados e a linha de cima das teclas segue na altura normal.
10. **Folhas do teclado:** o cartão "Voltar à folha principal" aparece abaixo do ABC com um espaço claro entre os dois; desligar faz o teclado ficar na folha 123/TSK ao digitar.
11. **Tecla de configurações:** o interruptor tira e põe a engrenagem na linha de baixo do modo Padrão (ao trocar, o teclado se recria).
12. **Volume do clique:** com o som ligado, o deslizador muda o volume do clique de verdade; desligando o som, ele fica cinza. Ajustar o padrão (80%) se ficar alto ou baixo.
13. **Símbolo do Shift:** nos modos Compacto e Completo, os símbolos aparecem no canto das teclas conforme a opção; no Padrão não há símbolos.
14. **Sobre:** mostra Versão e o cartão "by x-mrrobot-x"; tocar nele abre o GitHub no navegador.
15. **Textos:** "Popup ao pressionar a tecla" (Toque e gestos) e "Prévia da tecla" (Vibração, som e prévia) não se confundem; nenhum texto fala em "pop-up" com hífen.
