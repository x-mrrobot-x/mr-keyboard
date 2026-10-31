# Plano 1.69 — Organização das configurações

> Status: **feito na 1.69, com os ajustes das rodadas 2 e 3 depois dos testes (ver `revisao-1.6.9.md`, que traz a organização final)**. A árvore e as decisões abaixo são o plano aprovado; o que mudou depois: altura da barra de ferramentas no lugar da altura da 5ª linha, tecla de configurações como interruptor, volume do clique de volta, "Restaurar padrões" em Geral (não em Sobre) e o cartão do autor em Sobre. Decisão 5: saíram os 5 temas de imagem (ICS dicas escuras, Material escuro e claro, Gingerbread e Stone) e o Transparente; ficam os 4 de forma (Neon, Dark Tech suave e relevo, Midnight Steel). O levantamento acima chamou o Neon de tema de imagem e o Transparente de tema de forma; é o contrário.

## Pedido
Analisar todas as configurações: quais estão implementadas, quais são de versões antigas e podem sair, quais devem mudar de lugar ou ser agrupadas em outras páginas. Objetivo: telas mais organizadas e intuitivas e menos opções desnecessárias.

## O que existe hoje
- **51 configurações** em 6 telas: Principal (7 categorias), Sugestões e dicionários, Vibração/som, Teclas e rótulos, Gestos e teclas, Avançadas. Mais a tela das folhas (editor, separada) e a tela inicial do app.
- **Todas as 51 têm a chave lida pelo código** (conferi no smali onde cada uma é lida). Isso mostra que estão implementadas; o efeito no aparelho não foi testado uma a uma. O contrário existe: `full_keyboard_in_portrait` é lida pelo `LatinIME` e não tem tela (resto do Hacker's Keyboard, substituída pelos modos vertical/horizontal). Não mexo nela: é código sem efeito visível.
- Da tela de idiomas que saiu na 1.67 sobraram 2 textos (`has_dictionary` e `language_selection_summary`) e o `language_prefs.xml` vazio. Entram na limpeza. Fora isso, não achei texto nem lista de opções sem uso.

## Problemas encontrados
1. **"Folhas do teclado" aparece duas vezes** (em Layout e em Gestos e teclas), e a opção "Voltar à folha principal" está longe das folhas.
2. **"Idiomas e voz" ficou quase vazio** depois da 1.67: só Entrada de voz e Idioma das configurações.
3. **A tela principal mistura coisas de nível diferente:** espaçamento e arredondamento (só valem em 2 temas) ao lado do tema e da altura; "Resposta ao toque" mistura duas páginas com duas opções soltas.
4. **"Escala dos rótulos de sugestão"** está em Tema e rótulos, longe das outras opções de sugestões.
5. **"Gestos e teclas"** (nome pouco claro) leva uma categoria "Folhas" que não é gesto nem tecla.
6. **Avançadas** mistura teclas de PC, comportamento do editor, um truque do ConnectBot e depuração.
7. **Opções de versões antigas** (Hacker's Keyboard de Android 3/4): método de desenho, eventos ao deslizar, truque do ConnectBot, depuração de toque. E um controle de volume do clique que, no padrão, não faz nada.

## Nova organização

```
Configurações
├─ Aparência
│    Tema do teclado · Altura vertical · Altura horizontal
│    › Teclas e rótulos   (espaçamento, arredondamento, rótulos de dica, escala dos rótulos)
│    Altura da barra de ferramentas e sugestões  (rodada 2, no lugar da altura da 5ª linha)
├─ Layout
│    › Folhas do teclado · Voltar à folha principal ao digitar
│    Modo vertical · Modo horizontal · Mostrar tecla de configurações
├─ Digitação
│    › Sugestões e dicionários   (+ tamanho do texto das sugestões)
│    Capitalização automática · Entrada de voz (sem aviso novo)
├─ Toque e gestos
│    Duração do toque longo · Conteúdo do miniteclado pop-up
│    › Vibração, som e pop-up
│    › Gestos e teclas de volume   (4 gestos + 2 teclas; sem categoria "Folhas")
├─ Geral
│    Idioma do app · Notificação permanente
│    › Avançadas
│         Shift e modificadoras · Ctrl, Alt e Meta · Comportamento
│    Restaurar padrões  (rodada 3; o plano o punha em Sobre)
└─ Sobre
     Versão · Detalhes da conexão (saiu na rodada 2) · cartão do autor (rodada 3)
```
De 7 para 6 categorias na tela principal. Os nomes das páginas ficam mais diretos: "Teclas e rótulos", "Vibração, som e pop-up", "Gestos e teclas de volume" e "Avançadas".

## Inventário completo e ação proposta
| Chave | Configuração hoje | Onde está | Ação | Destino / motivo |
|---|---|---|---|---|
| `pref_keyboard_layout` | Tema do teclado | Principal › Aparência | **Manter** | Aparência |
| `settings_height_portrait` | Altura do teclado, vertical | Principal › Aparência | **Manter** | Aparência |
| `settings_height_landscape` | Altura do teclado, horizontal | Principal › Aparência | **Manter** | Aparência |
| `pref_key_spacing` | Espaçamento das teclas | Principal › Aparência | **Mover** | Página Teclas e rótulos; passa a valer em qualquer tema (decisão 3 e 5) |
| `pref_key_radius` | Arredondamento das bordas | Principal › Aparência | **Mover** | Página Teclas e rótulos; passa a valer em qualquer tema (decisão 3 e 5) |
| `pref_hint_mode` | Teclas alternativas com rótulo | Tema e rótulos | **Manter** | Teclas e rótulos |
| `pref_label_scale_v2` | Escala dos rótulos das teclas | Tema e rótulos | **Manter** | Teclas e rótulos |
| `pref_top_row_scale` | Altura da 5ª linha | Tema e rótulos | **Manter** | Teclas e rótulos (só vale nos modos com 5 linhas) |
| `pref_candidate_scale` | Escala dos rótulos de sugestão | Tema e rótulos | **Mover** | Sugestões e dicionários, como "Tamanho do texto das sugestões" |
| `pref_render_mode` | Método de desenho | Tema e rótulos | **Excluir** | Legado do Android 3/4 (economia de memória × aceleração). Fica no padrão atual, "buffer por software" |
| (página) | Folhas do teclado | Principal › Layout | **Manter** | Layout (a cópia em Gestos e teclas sai) |
| `pref_sheet_return` | Voltar à folha principal ao digitar | Ações › Folhas | **Mover** | Layout, logo abaixo de Folhas do teclado |
| `pref_keyboard_mode_portrait` | Modo do teclado, vertical | Principal › Layout | **Manter** | Layout |
| `pref_keyboard_mode_landscape` | Modo do teclado, horizontal | Principal › Layout | **Manter** | Layout |
| `settings_key` | Mostrar tecla de configurações | Principal › Layout | **Manter** | Layout |
| (página) | Sugestões e dicionários | Principal › Digitação | **Manter** | Digitação (primeiro item) |
| `auto_cap` | Capitalização automática | Principal › Digitação | **Manter** | Digitação |
| `voice_mode` | Entrada de voz | Principal › Idiomas e voz | **Mover** | Digitação, como está, sem aviso novo (decisão 2) |
| `pref_ui_language` | Idioma das configurações | Principal › Idiomas e voz | **Mover** | Geral, como "Idioma do app" |
| `pref_long_press_duration` | Duração do toque longo | Principal › Resposta ao toque | **Manter** | Toque e gestos |
| `pref_popup_content` | Conteúdo do miniteclado pop-up | Principal › Resposta ao toque | **Manter** | Toque e gestos |
| (página) | Configurações de feedback das teclas | Principal › Resposta ao toque | **Renomear** | "Vibração, som e pop-up" (em Toque e gestos) |
| (página) | Ações de gestos e teclas | Principal › Resposta ao toque | **Renomear** | "Gestos e teclas de volume" (em Toque e gestos) |
| `vibrate_on` | Vibrar ao pressionar | Feedback | **Manter** | Vibração, som e pop-up |
| `vibrate_len` | Duração da vibração | Feedback | **Manter** | Vibração, som e pop-up |
| `sound_on` | Som ao pressionar a tecla | Feedback | **Manter** | Vibração, som e pop-up |
| `pref_click_method` | Método de controle do volume do clique | Feedback | **Excluir** | 4 opções obscuras; com o padrão "sistema" o controle de volume ao lado não faz nada (decisão 1) |
| `pref_click_volume` | Volume do clique das teclas | Feedback | **Excluir** | Sai junto com o método: vale o volume de toque do sistema (decisão 1) |
| `popup_on` | Pop-up ao pressionar a tecla | Feedback | **Manter** | Vibração, som e pop-up |
| `pref_swipe_up` | Deslizar para cima | Ações › Gestos | **Manter** | Gestos e teclas de volume |
| `pref_swipe_down` | Deslizar para baixo | Ações › Gestos | **Manter** | Gestos e teclas de volume |
| `pref_swipe_left` | Deslizar para a esquerda | Ações › Gestos | **Manter** | Gestos e teclas de volume |
| `pref_swipe_right` | Deslizar para a direita | Ações › Gestos | **Manter** | Gestos e teclas de volume |
| `pref_vol_up` | Aumentar volume (tecla) | Ações › Teclas físicas | **Manter** | Gestos e teclas de volume |
| `pref_vol_down` | Diminuir volume (tecla) | Ações › Teclas físicas | **Manter** | Gestos e teclas de volume |
| `keyboard_notification` | Usar notificação permanente | Principal › Geral | **Manter** | Geral |
| (página) | Configurações avançadas | Principal › Geral | **Renomear** | "Avançadas" (em Geral) |
| `pref_caps_lock` | Modo de toque duplo no Shift | Avançadas › Teclas | **Manter** | Avançadas › Shift e modificadoras |
| `pref_shift_lock_modifiers` | Shift Lock nas teclas modificadoras | Avançadas › Teclas | **Manter** | Avançadas › Shift e modificadoras |
| `pref_ctrl_a_override` | Substituição do Ctrl-A | Avançadas › Teclas | **Manter** | Avançadas › Ctrl, Alt e Meta (útil em terminais) |
| `pref_chording_ctrl_key` | Código da tecla Ctrl | Avançadas › Teclas | **Manter** | Avançadas › Ctrl, Alt e Meta |
| `pref_chording_alt_key` | Código da tecla Alt | Avançadas › Teclas | **Manter** | Avançadas › Ctrl, Alt e Meta |
| `pref_chording_meta_key` | Código da tecla Meta | Avançadas › Teclas | **Manter** | Avançadas › Ctrl, Alt e Meta |
| `pref_slide_keys_int` | Eventos de teclas ao deslizar | Avançadas › Teclas | **Excluir** | Já vem no valor recomendado (ignorar teclas ao deslizar); os outros 4 são para casos raros do Hacker's Keyboard |
| `fullscreen_override` | Editor em tela cheia no modo horizontal | Avançadas › Modo de entrada | **Manter** | Avançadas › Comportamento |
| `force_keyboard_on` | Mostrar teclado virtual | Avançadas › Modo de entrada | **Manter** | Avançadas › Comportamento |
| `connectbot_tab_hack` | Modo da tecla Tab do ConnectBot | Avançadas › Aplicativos | **Excluir** | Solução para versões antigas do ConnectBot. Continua ligado, como hoje |
| `pref_touch_pos` | Depurar posição de toque | Avançadas › Depuração | **Excluir** | Ferramenta de desenvolvimento do Hacker's Keyboard |
| `label_version` | Versão | Principal › Sobre | **Manter** | Sobre |
| `input_connection_info` | Detalhes da conexão de entrada | Principal › Sobre | **Manter** | Sobre (diagnóstico) |
| `show_suggestions` | Mostrar sugestões | Sugestões e dicionários | **Manter** | — |
| `auto_complete` | Autocompletar | Sugestões e dicionários | **Manter** | — |
| `quick_fixes` | Correções rápidas | Sugestões e dicionários | **Manter** | — |
| `recorrection_enabled` | Tocar para corrigir palavras | Sugestões e dicionários | **Manter** | — |
| `suggestions_in_landscape` | Sugestões no modo horizontal | Sugestões e dicionários | **Manter** | — |
| `pref_suggested_punctuation` | Pontuação sugerida | Sugestões e dicionários | **Manter** | — |

Resumo: **39 ficam** (alguns com nome novo de página), **6 mudam de lugar** e **6 saem**. De 51 para 45 configurações, mais o botão novo "Restaurar padrões".

## Como fica o comportamento do que sai
Nenhuma é "desligada": o código continua lendo a chave e, sem a tela, usa o valor padrão que já usa hoje.
- `pref_render_mode`: padrão 1 (buffer por software). `pref_slide_keys_int`: padrão 0 (ignorar teclas ao deslizar, o "recomendado" da tela). `connectbot_tab_hack`: padrão ligado. `pref_touch_pos`: desligado. `pref_click_method` e `pref_click_volume`: padrão 0 (volume do sistema, o controle de volume do clique não age).
- Quem tinha mudado algum desses valores perde a mudança (aqui você reseta sempre, então não há migração).

## O que muda no código
- `res/xml/prefs.xml`, `prefs_view.xml`, `prefs_actions.xml`, `prefs_advanced.xml`, `prefs_feedback.xml` e `prefs_suggestions.xml`: mover e remover entradas; novos títulos e categorias; novos textos nos dois idiomas (pt-BR e inglês).
- `PrefScreenView.smali` procura `pref_render_mode` ao abrir: ganha uma checagem de nulo (como foi feito com Correções rápidas). `LatinIMESettings.smali` não depende das opções que se movem (só dos modos, da tecla de configurações, da voz e do idioma, que ficam na tela principal).
- `MrPacksActivity` passa a carregar também a escala das sugestões (`SeekBarPreferenceString`, já usado em outras telas).
- Limpeza: `has_dictionary`, `language_selection_summary` e `language_prefs.xml` (com a entrada no `public.xml`).
- READMEs e `docs/revisao-1.6.9.md`; versão 1.69.0.

## Validação prevista
Build, `d2j-asm-verify`, `smali_regcheck.py` (registradores), conferência dos IDs de recurso do smali, testes de pacotes e de três idiomas. Roteiro no aparelho: abrir cada página, conferir que nada aparece duas vezes, que as opções movidas continuam funcionando (altura, rótulos, sugestões, folhas) e que o teclado se comporta como antes com os valores padrão das que saíram.

## Decisões tomadas
1. **Volume do clique:** sai o método e o controle de volume; vale o volume de toque do sistema.
2. **Entrada de voz:** fica como está, em Digitação, sem aviso novo. Conferi que o app e os READMEs não têm texto alarmista sobre voz; não há nada para suavizar.
3. **Espaçamento e arredondamento valem em qualquer tema.** O tema só define cores; a forma das teclas é padrão. Ver a seção abaixo.
4. **"Restaurar padrões"** entra em Geral (o plano dizia Sobre; mudou na rodada 3): pede confirmação, apaga as configurações do teclado (preferências padrão) e mantém os dicionários baixados; depois o teclado recarrega.

## Forma das teclas em qualquer tema (decisões 3 e 5)
O que o código faz hoje:
- `KeyStyle` só aplica espaçamento e arredondamento em **3 dos 10 temas** (Dark Tech suave, Dark Tech relevo e Midnight Steel). Nos outros devolve sem fazer nada.
- Os temas se dividem pela forma do fundo da tecla:
  - **de forma (XML)**, onde o arredondamento é definido por código: Dark Tech suave e relevo, Midnight Steel e Transparente (experimental), 4 temas;
  - **de imagem (9-patch .png)**, onde o arredondamento está desenhado dentro da imagem e não dá para mudar por código: Mr Keyboard Neon (ICS), ICS dicas escuras, Material escuro, Material claro, Gingerbread e Stone, 6 temas e 73 imagens.
- O **espaçamento** funciona em qualquer fundo (é um recuo do desenho) e vale para os 10 depois de pequena mudança em `KeyStyle` e no ajuste de margens do `Keyboard`.
- As outras opções que mexem no teclado (altura, escala dos rótulos, rótulos de dica, altura da 5ª linha, escala das sugestões) já são independentes do tema: não achei nenhuma checagem de tema no código além do `KeyStyle` e da escolha do estilo.

Para o **arredondamento** valer em todos, os 6 temas de imagem precisam mudar. Opções (decisão 5):
- **A.** Tirar os 6 e ficar com 4 temas de forma. Menos código e menos imagens (o APK diminui); menos escolha.
- **B.** Recriar os 6 como temas de forma (mesmas cores, teclas planas arredondadas). Material fica quase igual; ICS, Gingerbread e Stone perdem o relevo de imagem. Não dá para conferir o visual aqui; preparo uma prévia em imagem antes.
- **C.** Recriar só Material escuro e claro e tirar os outros 4 (ICS, ICS dicas escuras, Gingerbread, Stone): ficam 6 temas.
Quem tinha um tema removido volta ao padrão (Dark Tech relevo).
