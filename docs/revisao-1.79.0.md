# 1.79.0 — "Personalizar teclado" em retrato abre como dialog com preview em tempo real

## Pedido
Adicionar o modal de preferências ("Personalizar teclado") no modo vertical (retrato) e subir a versão do APK com o processo de sempre: `versionCode`/`versionName` no `apktool.yml` e no `apktool.json`, notas em `docs/revisao-<versão>.md` e as verificações de `docs/tools/`.

## Notas da release
**Português**
- Em retrato, o *Personalizar teclado* da barra de ferramentas abre como um modal centralizado na área acima do teclado, com fundo escurecido, título e os cinco controles: altura do teclado vertical, altura da barra e sugestões, escala dos rótulos, espaçamento e arredondamento das teclas.
- Os controles mexem nas mesmas preferências das Configurações, e o teclado muda na hora enquanto você arrasta, então dá para ver a altura e o resto ao vivo.
- O modal tem os botões *Restaurar padrão* e *Fechar* e segue o idioma escolhido no app (português, inglês ou espanhol).
- Em paisagem nada muda: o *Personalizar teclado* continua como painel translúcido dentro do teclado.

**English**
- In portrait, the toolbar's *Customize keyboard* now opens as a modal centered in the area above the keyboard, with a dimmed background, a title and the five controls: vertical keyboard height, toolbar and suggestions height, key label scale, key spacing and key roundness.
- The controls change the same preferences as Settings, and the keyboard updates instantly while you drag, so you can see the height and the rest live.
- The modal has *Reset defaults* and *Close* buttons and follows the language chosen in the app (Portuguese, English or Spanish).
- Nothing changes in landscape: *Customize keyboard* is still a translucent panel inside the keyboard.

## O que mudou
- **Modal em retrato (`MrTune`).** `MrTune.toggle()` abre o painel dentro do teclado em paisagem (`togglePanel`) e, em retrato (ou quando o layout não tem o painel), abre o dialog (`showDialog`). O dialog usa a janela do próprio teclado (`TYPE_APPLICATION_ATTACHED_DIALOG`), então não precisa de `SYSTEM_ALERT_WINDOW` e vale do API 26 ao 36. O contexto passa por `MrLocaleCtx.of`, para o texto sair no idioma do app e não no do sistema. Cada deslizador grava a mesma chave das Configurações, e o teclado se atualiza pelo caminho de sempre (`LatinIME.onSharedPreferenceChanged`); só a escala dos rótulos é aplicada direto na view e gravada ao soltar, para não recriar a view do teclado (e o deslizador) a cada passo.
- **Layout `res/layout/mr_tune_dialog.xml`.** A raiz é a camada escura (só a área acima do teclado) e o cartão fica centralizado nela. Título `@string/mr_tb_customize`, cinco linhas com `SeekBar` e a pílula de valor (`mr_ui_value_pill`) com as tags `tl_*`/`sk_*`/`vl_*` que o `MrTune` já usa, e os botões `tune_reset` e `tune_ok`.
- **Fundo `res/drawable/mr_tune_dialog_bg.xml`.** Cartão no mesmo tom do `mr_ui_dialog_bg` (`#0f1621`), com cerca de 90% de opacidade, borda `mr_ui_stroke_strong` e cantos de 24 dp.
- **Recursos e textos.** `mr_tune_dialog` registrado no `public.xml`; título e rótulos nos três idiomas (`values`, `values-pt-rBR`, `values-es`), com `mr_tune_close` e `mr_tune_reset` traduzidos.
- **Versão.** `apktool.yml` e `apktool.json`: `versionName` v1.79.0 e `versionCode` 1079000 (1×1000000 + 79×1000 + 0); `apkFileName` do `apktool.yml` passa a `Mr Keyboard_v1.79.0.apk`.
- **Não mudou**: dicionários (`dicts/*/pack.json`), motor nativo (`engine/`, `native/`, os `.sha256`) e a pasta `lib/`. Por isso não há `serial` novo de catálogo nem `libmrengine.so` para regerar.

## Verificado aqui
`check_version.py` (v1.79.0, código 1079000), `check_catalog_url.py`, `check_reset_keys.py`, `mres_check.py`, `res_check.py` e `smali_regcheck.py smali` sem problemas. Não deu para rodar neste ambiente `apktool b`, `verify_dex.sh`, os testes de PC em Java e a paridade do motor nativo (sem `javac`, apktool nem rede); eles rodam no `mr-checks.yml` ao subir. Não foi testado no aparelho.

## Conferir no aparelho
- Em retrato, abrir *Personalizar teclado* na barra: o modal aparece acima do teclado, com o fundo escurecido, e o teclado continua visível e mudando ao arrastar cada um dos cinco controles.
- Arrastar os controles sem tremor do modal ou do teclado; soltar a escala dos rótulos e ver o teclado atualizar.
- *Restaurar padrão* volta os cinco valores, e *Fechar* e o botão voltar fecham o modal sem deixar nada preso na tela. Abrir e fechar várias vezes seguidas.
- Girar o aparelho com o modal aberto e em paisagem: o painel translúcido dentro do teclado segue como antes.
- Trocar o idioma do app (português, inglês e espanhol) e ver o título, os rótulos e os botões do modal no idioma escolhido.
- Repetir nos 5 temas (Neon, Soft, Slate, Midnight e Glass).
