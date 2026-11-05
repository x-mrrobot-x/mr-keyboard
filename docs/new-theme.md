# Como adicionar um tema ao teclado

Cada tema é um layout com uma tag. A detecção, as flags, as cores, os drawables e o registro ficam em recursos; o smali
só os lê (`MrTheme`, `KeyStyle`, `MrTools`). Tema novo não exige mexer no smali. Em tudo abaixo, `<tema>` é o nome da
tag sem o `mr_` (`glass`, `midnight`...).

1. **Layout:** copie o mais parecido para `res/layout/input_mr_<tema>.xml`, com `android:tag="mr_<tema>"`,
   `latin:popupLayout="@layout/input_popup_<tema>"` e `latin:keyPreviewLayout="@layout/key_preview_<tema>"`. Todas as
   cores do layout vêm de `@color/mr_<tema>_*`, sem hex.
2. **Flags** (`res/values/mr_themes.xml`): uma linha em `mr_theme_tags` com a tag (`mr_<tema>`) e uma em
   `mr_theme_flags`, na mesma posição, com os bits do tema (barra plana, teclas de destaque, grupo de destaque ampliado,
   translúcido, paleta tech, texto padrão nas teclas de destaque). Os bits estão descritos no topo de
   `smali/com/mrkeyboard/app/MrTheme.smali` e no comentário do `mr_themes.xml`; o `0x01` (`INIT`) é do `MrTheme` e não
   entra no valor. Todo tema com tag liga `ACCENT_KEYS` (`0x04`) e traz o seu seletor de destaque (item 5).
   `ACCENT_WIDE` (`0x08`) amplia o grupo de destaque (item 5); todos os temas ligam.
3. **Registro** (`res/values/mr_themes.xml`): uma linha em `mr_theme_layouts`. O índice é o valor guardado em
   `pref_keyboard_layout`. Esse array é por valor da preferência (vários valores podem abrir o mesmo layout);
   `mr_theme_tags` e `mr_theme_flags` são por tema. O raio das camadas da tecla não tem registro (item 5).
4. **Seletor:** o nome em `keyboard_layout_modes` (e nas traduções) e o valor em `keyboard_layout_modes_values`.
5. **Teclas:** `btn_keyboard_key_<tema>` e `key_<tema>_{normal,pressed,on,lock,hl}`. Os drawables só referenciam
   `@color`, sem hex: as cores ficam em `res/values/mr_key_colors.xml`, com o nome
   `mr_<tema>_key_<estado>_<parte>` (estado `normal`, `pressed`, `hl`, `on`, `lock` ou `acc_<estado>`; parte `halo`, `base`,
   `fill`, `top`, `mid`, `bottom`, `stroke` ou `shadow`). As sombras neutras que se repetem entre temas são globais:
   `mr_key_shadow`, `mr_popup_shadow` e `mr_preview_shadow`. **Teclas de destaque** (Shift,
   Delete, setas, Tab, 123, Espaço, Enter...): `btn_keyboard_key_<tema>_accent`. O destaque **substitui** o fundo da
   tecla, então o seletor precisa trazer tudo (sombra, halo, borda). Há duas formas: drawables próprios
   `key_<tema>_acc_{normal,pressed,on,lock}` (Neon, Soft e Glass) ou reaproveitar `key_<tema>_hl` (repouso) e
   `pressed/on/lock` do próprio tema (Slate e Midnight), de modo que as teclas sticky e as de destaque são
   personalizadas juntas, em um só conjunto de arquivos. O `LatinKeyboardBaseView` lê o seletor pelo nome, a partir
   da tag; sem ele, a tecla sai com o fundo normal.
   **Raio das camadas da tecla:** em tempo de execução a última camada do `layer-list` (a borda, que é a tecla) recebe o
   raio das teclas (`pref_key_radius`), e cada camada de fora soma a folga que o próprio drawable desenha: o recuo
   esquerdo da última camada menos o da camada (`KeyStyle.layerGap`, nunca negativo). Halo recuado 2 dp a menos que a
   borda (Neon e Soft) fica com raio + 2 dp, e cantos ficam concêntricos. Sombra só deslocada na vertical (Slate e
   Midnight) e forma única (Glass) não têm folga lateral e ficam com o raio das teclas. Tema novo só precisa recuar as
   camadas de fora no XML; o raio escrito nelas é reserva. Mantenha a camada de dentro por último.
   Quais teclas são de destaque (`isAccentKey` no `LatinKeyboardBaseView`, vale para todos os temas): uma lista fixa de
   códigos (Shift, Delete, Tab, Ctrl, Alt, ❖, setas, Home/End, PgUp/PgDn e a tecla da barra) e, com `ACCENT_WIDE`,
   também toda tecla marcada `android:isModifier="true"` (F1, Fn, teclas F, Ins, ".", configurações...), as teclas do
   Tasker (texto `tskcmd:`), 123/TSK (`-300`), o 123 do teclado de telefone (`-2`), Espaço e Enter. Um tema que não
   queira o grupo ampliado desliga só o `ACCENT_WIDE`. Atenção: o estado `hl` do tema também é aplicado por
   `LatinKey.isHl` (lista própria mais `tskcmd:`), então o destaque e o `hl` devem andar juntos em cada tema (no Slate e
   no Midnight o destaque é o próprio `hl`).
6. **Popup do toque longo:** `input_popup_<tema>`, `popup_<tema>_bg`, `btn_keyboard_key_popup_<tema>` e
   `key_popup_<tema>_pressed`, para todo tema (inclusive o Neon, com halo e borda verdes). O padrão do `styles.xml` para
   layout sem `popupLayout` é `input_popup_slate`, e o de `keyBackground` é `btn_keyboard_key_slate` (o tema padrão).
7. **Balão de preview:** `key_preview_<tema>`, `preview_<tema>_bg` e `preview_<tema>_more_bg`. O `LatinKeyboardBaseView`
   lê os dois drawables pelo nome (`preview_<tema>_bg` e `preview_<tema>_more_bg`) a partir da tag e, se não achar,
   usa `keyboard_key_feedback_background` e `keyboard_key_feedback_more_background`.
   **Raios (teclas, popup e preview):** o raio escrito nos drawables é só reserva. Em tempo de execução o `KeyStyle` o troca
   pelo raio das teclas (`pref_key_radius`) mais uma folga: balão de preview +2 dp e fundo do popup +8 dp
   (`LatinKeyboardBaseView`), botões, campos e painéis da barra pelo `MrTools` (`KeyStyle.radiusPx`). Com raio 0 nas
   teclas tudo fica reto; o tema novo não precisa de código para isso.
8. **Cores do tema** (`res/values/mr_colors.xml`): `mr_<tema>_kbd_bg`, `_text`, `_cursor`, `_hint`;
   `_popup_bg_{top,bottom,stroke}`, `_popup_key_{top,bottom,stroke}` (o Soft tem também `_mid`; o Neon, `_popup_halo` e
   `_popup_key_halo`) e `_popup_hint`;
   `_preview_{top,bottom,stroke,dots}`. Se o tema **não** ligar `PLAIN_ACCENT_TEXT`, o texto e o ícone das teclas de
   destaque usam `mr_<tema>_accent_text` (sem ela, vale `mr_accent_text`, branco); com a flag, usam o texto padrão do tema.
9. **Cores dos painéis:** só se o tema precisar de cores diferentes, declare `mr_<tema>_panel_<papel>` em
   `res/values/mr_colors.xml`. Sem a versão do tema vale `mr_panel_<papel>`. Os papéis são `bar`, `btn`,
   `btn_stroke`, `tab_off`, `tab_off_stroke`, `tab_on_text`, `tab_off_text`, `field`, `field_stroke`, `card` e `icon`.
   Os paineis (Clipboard, idiomas, Anexos e emotes) nao tem moldura em tema nenhum: nos temas planos o fundo e `panel_bar`.
   Papeis proprios de Anexos (sem o prefixo `panel_`, tambem com versao `mr_<tema>_<papel>` quando o tema precisar):
   `attach_fab`, `attach_fab_stroke`, `attach_fab_icon` (botao do seletor), `sel_cancel`, `sel_cancel_stroke`,
   `sel_cancel_text`, `sel_send`, `sel_send_stroke`, `sel_send_text` (barra Cancelar/Enviar e check do item marcado),
   `sel_media` (camada sobre a miniatura marcada) e `sel_card` (fundo do arquivo marcado).
10. **Confira:** `python3 docs/tools/res_check.py` e `python3 docs/tools/smali_regcheck.py smali/ --base <smali anterior>`.
    O `res_check` avisa se os arrays de registro não batem (`mr_theme_tags` com `mr_theme_flags`, valor de
    `keyboard_layout_modes_values` fora de `mr_theme_layouts` e bits de flag inválidos), se a tag do layout não está em `mr_theme_tags`, se falta
    a cor padrão de um papel, se falta algum recurso dos itens 5 a 7 (inclusive o seletor de destaque e os drawables que ele referencia), se o layout do tema não aponta para o seu popup e
    preview, se sobrou cor em hex nos layouts ou nos drawables do tema, se os `input_mr_*`, `input_popup_*` e `key_preview_*` diferem
    entre si além do nome do tema ou se o nome do tema não existe nos 3 idiomas.

## Convenção de nomes

- O que vale para todos os temas, ou é decidido por flag do `MrTheme`, leva nome genérico: `isAccentKey`,
  `drawAccentFill`, `getAccentContentColor`, `applyTranslucentBlur`, `MrTranslucentBlur`, `flatBar()`, `translucent()`.
- O que existe só para um tema leva o nome dele (`neon`, `soft`, `slate`, `midnight`, `glass`), como nos recursos
  `mr_<tema>_*`, `key_<tema>_*` e `input_popup_<tema>`.
- Nome de tema não entra em método, campo ou classe que atenda a mais de um tema.
