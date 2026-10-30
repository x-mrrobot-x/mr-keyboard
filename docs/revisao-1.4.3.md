# 1.4.3 — Espaço para a barra de navegação do IME (navegação por gestos)

## Problema
Em Android 17 com navegação por gestos, os botões que o sistema desenha dentro da janela do teclado (chevron para ocultar e seletor de teclado) ficam sobrepostos à base da última linha de teclas ("123" e Enter). A linha não é cortada, mas divide a área com os botões do sistema.

## Causa provável
- `ImeInsets$Api30.applyInsets` reservava espaço apenas para `navigationBars() | displayCutout()`.
- Segundo o javadoc e o código do AOSP, a barra de navegação do IME fornece insets do tipo `captionBar()` à janela do IME. O commit "Allow hiding the IME navigation bar" removeu o override de tamanho que existia na barra do sistema e passou a tratá-la internamente como caption bar.
- Em navegação por gestos, `navigationBars()` equivale à altura do puxador, menor que essa barra. Com três botões a barra é a do próprio sistema, o que explica por que o problema aparece em gestos.
- Isto é uma inferência a partir do código e da documentação do AOSP. A documentação em developer.android.com não descreve a barra do IME como `captionBar()`. Não houve medição no aparelho.

## Alteração
- `ImeInsets$Api30.applyInsets`: a máscara passou a ser `navigationBars() | captionBar() | displayCutout()`.
- `WindowInsets.getInsets(int)` com máscara combinada usa o maior valor por lado, sem somar os tipos. Onde `captionBar()` for zero, o resultado é o mesmo de antes.
- `WindowInsets.Type.captionBar()` existe desde a API 30, o mesmo piso já usado por `ImeInsets` (a classe retorna sem fazer nada abaixo da API 30).
- Versão: 1.43.0 (código 1043000).

## Preservado
- Gate `SDK_INT >= 35` em `LatinIME.setInputView`. Não alterado, porque não há documentação que vincule a mudança a uma versão e baixar o gate poderia duplicar o padding onde o framework já reserva o espaço.
- `InsetsHandler` das Activities, `onComputeInsets`, `keyboard_bottom_padding` e o restante do teclado.

## Pesquisa sobre versões
- Android 15 (API 35): edge-to-edge forçado para apps com target 35 ou maior. As Activities já tratam isso em `InsetsHandler`.
- Android 16 (API 36): `onCustomImeSwitcherButtonRequestedVisible(boolean)` foi adicionado. Só é relevante se o teclado esconder a barra do sistema com `hide(captionBar())`; este projeto não faz isso.
- Android 17 (API 37): a lista oficial de mudanças (atualizada em 2026-10-09) não traz alteração de insets ou barra de navegação do IME. Os itens de IME são a restauração da visibilidade após rotação e a acessibilidade de IME complexo (target 37). O QPR2 não tem mudanças de comportamento planejadas. O projeto continua com target 36.

## Validação
- Revisão estática do Smali: um único método alterado, `.registers 7` com `v0` e `v1` locais (`v1` é reatribuído depois), `.method`/`.end method` balanceados.
- O ambiente de edição não tinha apktool/smali. Não houve montagem DEX, build do APK nem execução em emulador/aparelho.

## Testes Android necessários
1. Android 17, navegação por gestos: a última linha de teclas deve ficar acima do chevron e do seletor de teclado, e tocar na borda inferior de "123" e Enter não deve acionar os botões do sistema.
2. Navegação por três botões: nenhuma mudança de espaço esperada. Se surgir espaço extra, `captionBar()` está sendo entregue também nesse modo.
3. Android 15 e 16 em gestos. Android 13 e 14: nenhuma mudança esperada, por causa do gate em 35.
4. Paisagem, tela dobrável e janela flutuante.
5. Se a sobreposição persistir, registrar temporariamente o `bottom` de `navigationBars()`, `captionBar()` e `tappableElement()` no listener de `ImeInsets` e comparar com o espaço sob as teclas.

## Referências
- https://android.googlesource.com/platform/frameworks/base/+/601f6eb61d4e
- https://gerrit.omnirom.org/plugins/gitiles/android_frameworks_base/+/72c0f95f6efc3cec301b7f9ff6f3583f62821b56%5E%21
- https://android.googlesource.com/platform/frameworks/base/+/HEAD/core/java/android/inputmethodservice/InputMethodService.java
- https://developer.android.com/develop/ui/views/layout/edge-to-edge
- https://developer.android.com/about/versions/17/summary
- https://developer.android.com/about/versions/17/qpr2/release-notes
