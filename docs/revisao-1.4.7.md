# 1.4.7 — Teclado atrás da barra de navegação do IME ao trocar de outro teclado

## Problema
No Android 17, com navegação por gestos, ao alternar de outro teclado para o Mr Keyboard a última fileira de teclas (123, emoji, espaço, Enter) aparece quase toda atrás da barra de navegação do IME (chevron para ocultar e globo para trocar de teclado). O espaço inferior que a 1.4.3 passou a reservar não é aplicado nesse caso.

## Causa
- O espaço inferior é reservado pelo `ImeInsets`, um `OnApplyWindowInsetsListener` instalado na raiz do teclado (a view de `MrTools.wrap`, com a barra de ferramentas e o teclado) em `LatinIME.setInputView`, com `SDK_INT >= 35`.
- `ImeInsets.apply` instalava o listener e chamava `requestApplyInsets()` antes de `InputMethodService.setInputView` anexar a view ao `inputFrame`. Nesse momento a view ainda não tem pai, e `requestApplyInsets()` não tem efeito.
- `InputMethodService.setInputView` só faz `removeAllViews()` e `addView(...)` no `inputFrame`. Não pede novo despacho de insets (conferido no AOSP atual).
- A view do teclado é recriada mais de uma vez. `KeyboardSwitcher.changeLatinKeyboardView` (via `recreateInputView`, chamado por `onCreateInputView`, por mudanças de preferência e de tema) sempre agenda `setInputView` por `Handler.post` (`KeyboardSwitcher$1`); `LatinIME.switchToKeyboardView` faz o mesmo (`LatinIME$2`). Cada chamada cria uma raiz nova em `MrTools.wrap`.
- Quando essa troca acontece com a janela do teclado já visível e as insets já despachadas, a raiz nova nunca recebe `onApplyWindowInsets`: fica sem o padding inferior e a barra de navegação do IME, desenhada por cima, cobre a última fileira. O padding só voltaria numa próxima mudança de insets da janela.
- A troca de teclado é o caso em que a recriação mais provavelmente cai depois do primeiro despacho. A sequência exata não foi medida no aparelho; o mecanismo (pedido ignorado antes de anexar, nenhum pedido depois) é determinístico.

## Alteração
- `ImeInsets` passou a implementar `View.OnAttachStateChangeListener`.
- `ImeInsets.apply` registra o próprio objeto com `addOnAttachStateChangeListener`, mantendo a chamada imediata a `requestApplyInsets()`.
- `onViewAttachedToWindow` chama `requestApplyInsets()`. Nesse ponto o pai já foi atribuído, o pedido chega ao `ViewRootImpl` e as insets são despachadas na próxima travessia, antes de medir e desenhar a view nova. Não há quadro sem padding.
- O cálculo do padding (`navigationBars() | captionBar() | displayCutout()`, 1.4.3) não mudou.
- Versão: 1.47.0 (código 1047000).

## Preservado
Gate `SDK_INT >= 35` em `LatinIME.setInputView`; `MrTools.wrap`; `KeyboardSwitcher`; `onComputeInsets`; Activities (1.4.5/1.4.6).

## Validação
- `apktool b` (2.11.1) sem erros; APK desmontado e `ImeInsets` conferido no DEX.
- Não houve execução no aparelho.

## Testes Android necessários
1. Android 17, gestos: trocar de outro teclado para o Mr Keyboard pelo globo e pelo seletor do sistema; a última fileira deve ficar inteira acima do chevron e do globo.
2. Com o teclado aberto: mudar tema, altura e folhas nas configurações e voltar ao campo; idem.
3. Abrir e fechar o teclado várias vezes; rotação; navegação por três botões (sem espaço extra).
4. Android 15 e 16 em gestos. Android 14 ou menor: sem mudança.
5. Se ainda ocorrer, registrar temporariamente em `ImeInsets.onApplyWindowInsets` o `bottom` de `navigationBars()` e `captionBar()`: se o listener for chamado com `captionBar()` = 0, o problema está no momento em que o sistema passa a fornecer a barra do IME, e não no despacho.

## Referências
- https://android.googlesource.com/platform/frameworks/base/+/HEAD/core/java/android/inputmethodservice/InputMethodService.java
- https://developer.android.com/reference/android/view/View#requestApplyInsets()
