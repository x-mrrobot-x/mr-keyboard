# 1.70 — Limpeza do motor: chaves de opções que já não têm tela

## Pedido
Depois da 1.69 (configurações reorganizadas, ver `revisao-1.6.9.md`), tirar do motor do teclado o que sobrou das opções que saíram das telas: as leituras de preferências sem tela, as classes e as constantes que só serviam a elas.

## O que mudou
Antes, o teclado ainda lia do aparelho o valor guardado de 10 opções que saíram das telas; um valor antigo (de uma versão em que a opção existia) continuava mudando o comportamento sem ninguém poder ver ou desfazer. Agora essas leituras acabaram e os campos têm o valor padrão fixo:
- `GlobalKeyboardSettings`: saíram os registros e as 7 classes internas de `pref_slide_keys_int` (teclas ao deslizar: 0), `pref_touch_pos` (depuração do toque: desligada), `pref_top_row_scale` (1.0), `pref_chording_meta_key` (0), `pref_click_method` (agora 1, "volume absoluto", no construtor), `pref_caps_lock` (Caps Lock no toque duplo no Shift: ligado) e `pref_shift_lock_modifiers` (desligado).
- `LatinIME`: saíram a leitura e o ramo de mudança de `pref_render_mode` (modo de desenho: 1) e de `connectbot_tab_hack` (truque da Tab: ligado, fixo), e as constantes das duas e de `full_keyboard_in_portrait` (que nada lia).
- `SeekBarPreferenceString.isLive`: sai `pref_top_row_scale`.
- Recursos que só serviam a essas leituras: `default_render_mode`, `default_connectbot_tab_hack`, `default_caps_lock`, `default_shift_lock_modifiers`, `default_chording_meta_key` e `default_click_method` (e as 6 entradas do `public.xml`).
- Os campos continuam existindo e quem os usa (`LatinKeyboardBaseView`, `PointerTracker`, `Keyboard$Row` etc.) não mudou: o ganho é que nenhum valor guardado chega mais a eles. O código de depuração do toque e o de "teclas ao deslizar" segue lá, desligado.
- Essas 10 chaves seguem em `MrReset.KEYS` (lista `ANTIGAS` do `check_reset_keys.py`) só para o "Restaurar padrões" apagar valores velhos do arquivo de preferências; nenhum código as lê.
- Teste novo no PC (`docs/tools/settings_test`): carrega o `GlobalKeyboardSettings` do APK, roda `initPrefs` e lista os campos. Padrões de antes e de depois: iguais. Com valores antigos guardados (Caps Lock desligado, método do clique 0, toque ligado, teclas ao deslizar 2, Meta 5): o APK novo ignora todos; o de antes (controle) era afetado por eles.

Versão **1.70.0** (código 1070000). Nenhuma tela, texto de tela ou dicionário mudou; o APK ficou cerca de 1 KB menor (897,7 KB).

## Como foi feito
- Edição direta do smali: `GlobalKeyboardSettings.smali` (7 registros e 7 classes internas apagados; o construtor passa a pôr `keyClickMethod` em 1), `LatinIME.smali` (4 trechos e 3 constantes) e `SeekBarPreferenceString.smali` (1 chave a menos em `isLive`). Cada trecho apagado foi casado por padrão exato e conferido com `diff` contra a 1.69.
- Os recursos `default_*` ficaram sem uso e saíram dos valores e do `public.xml` (6 entradas).
- Comentário de `MrReset.java` ajustado: as chaves antigas só estão na lista para limpar valores guardados.

## Validação
- `apktool b` sem erro; `d2j-asm-verify` sem erros; `smali_regcheck.py` com 0 problemas no smali e no dex do APK.
- As 246 constantes de ID de recurso do smali apontam para o mesmo recurso no APK; nenhuma entrada do `public.xml` sem recurso; só sobra sem uso `status_bar_notification_info_overflow` (biblioteca de suporte).
- `settings_test` (novo): lista os campos do `GlobalKeyboardSettings` depois do `initPrefs`. Com preferências vazias, a lista da 1.70 é igual à da 1.69; com valores antigos guardados (Caps Lock desligado, método do clique 0, toque ligado, teclas ao deslizar 2, Meta 5) a 1.70 continua igual aos padrões, e a 1.69 (controle) mudava 6 campos.
- `check_reset_keys.py`: 40 chaves nas telas, todas em `MrReset.KEYS` (51 com as antigas e `pref_sheet_return`). `PacksTest`: 62 OK. `ThreeLangTest`: 23 OK.
- **Não testado no aparelho:** nada do motor. O `LatinIME` não roda no PC; a mudança nele é só trocar a leitura por valor fixo, mas é o que mais precisa do roteiro abaixo.

## Testes Android necessários
- **Shift:** toque simples põe uma maiúscula; **toque duplo** liga o Caps Lock (o indicador muda); outro toque desliga.
- **Som do clique:** com "Som ao pressionar a tecla" ligado, o deslizador "Volume do clique" muda o volume do clique (baixo fica bem fraco, 100% fica forte); com o som desligado, nada toca.
- **Desenho do teclado:** abrir e fechar o teclado, girar a tela e trocar de tema: as teclas desenham normalmente, sem tela em branco, piscadas ou pedaços sem atualizar.
- **Toque e deslize:** digitar rápido deslizando o dedo entre teclas não gera teclas extras; os gestos de deslize (cima, baixo, esquerda, direita) e o toque longo continuam funcionando; nenhuma bolinha ou marca aparece onde o dedo toca.
- **Linha de cima das teclas:** altura igual à de antes (sem esticar nem encolher).
- **Terminal (truque do ConnectBot):** no Termux ou ConnectBot, as setas e a Tab com Ctrl ou Alt apertadas mandam as sequências certas (ex.: Ctrl+← anda uma palavra no shell, Ctrl+C interrompe); num campo de texto comum, Ctrl+A (selecionar tudo) e as setas funcionam como antes.
- **Configurações:** abrir todas as páginas sem travar; mudar tema, modo vertical/horizontal, escala dos rótulos, popup e pontuação sugerida e ver o teclado reagir na hora; **Restaurar padrões** continua funcionando.
- Se algo disso estiver diferente do que a 1.69 fazia, o suspeito é esta limpeza; o `LatinIME.smali` e o `GlobalKeyboardSettings.smali` da 1.69 servem de comparação.
