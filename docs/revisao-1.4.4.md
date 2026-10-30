# 1.4.4 — Espaço em dobro entre o título e o conteúdo nas telas de configurações (Android 15+)

> **Substituída pela 1.4.5.** O ajuste descrito aqui (subtrair a margem do conteúdo no `InsetsHandler`) não resolveu o vão no aparelho e foi revertido. A causa real é a ActionBar do framework nas telas de configurações; ver `revisao-1.4.5.md`.

## Problema
Em um aparelho com Android 17, as telas de configurações (ex.: "Configurações do Mr Keyboard") mostram um vão grande entre a barra de título e o primeiro item da lista. Em outro aparelho o vão não existe.

## Diagnóstico
- Não é o cabeçalho do app. O card "Mr Keyboard" (`mr_ui_pref_hero`) tem 8dp de padding superior e a lista (`MrListView`) 6dp; juntos explicam cerca de 14dp, não o vão observado.
- A diferença entre aparelhos vem do `MrApplication.onCreate`: o `InsetsHandler` só é registrado com `SDK_INT >= 35`. Em Android 14 ou menor ele não existe e o framework posiciona o conteúdo sozinho.
- O `InsetsHandler.onApplyWindowInsets` aplicava, como padding de `android.R.id.content`, o `systemBars() | displayCutout()` inteiro, sem considerar a margem que o pai já havia reservado ao conteúdo.
- As telas de configurações usam `Theme.MrKeyboard.Settings` (`Theme.Material`) com a ActionBar do framework. No código atual do AOSP, `ActionBarOverlayLayout` posiciona o conteúdo por margem (`setMargin(mContent, …)`) e, antes de medir o conteúdo, despacha para ele insets que incluem a altura da barra (`mInnerInsets`). Padding (do handler) somado a margem (do framework) reserva o espaço duas vezes.
- Medidas no print (1080x2400): a linha inferior da barra está em y≈198 px e o card do hero começa em y≈396 px. O vão de ~198 px equivale a status bar + ActionBar (≈ 92 px + 106 px, supondo a barra de 56dp a ~1,9 px/dp). O conteúdo também termina ~90 px acima da borda inferior, o que é compatível com o mesmo erro na base. Densidade estimada pelo layout, não lida do aparelho.
- Isto é inferência a partir do código do framework e do print. Não houve execução em emulador/aparelho.

## Alteração
- `InsetsHandler.onApplyWindowInsets`: de cada lado, o padding passou a ser `max(0, inset − margem do conteúdo naquele lado)`.
- Quando o conteúdo não tem margem (Activities sem ActionBar, como `Main` e `PrefScreenSheets`), o resultado é idêntico ao anterior.
- Se o conteúdo não tiver `MarginLayoutParams`, o comportamento anterior é mantido.
- As insets continuam sendo devolvidas sem consumir, como antes (o `SheetEditorActivity$Api30ImeHelper` calcula o IME a partir delas).
- Versão: 1.44.0 (código 1044000).

## Preservado
- Gate `SDK_INT >= 35` em `MrApplication`; `ImeInsets` e o teclado (1.4.3); temas e layouts.

## Validação
- `apktool b` (2.11.1, a mesma de `apktool.yml`) montou smali e recursos sem erros; desmontagem do APK gerado confirmou o método no DEX.
- Não houve execução no aparelho.

## Testes Android necessários
1. Android 15, 16 e 17 em `LatinIMESettings`, `PrefScreenView`, `PrefScreenFeedback`, `PrefScreenActions`, `PrefScreenAdvanced` e `InputLanguageSelection`: o primeiro item deve começar logo abaixo da barra de título (cerca de 14dp) e o último item deve ficar acima da barra de navegação.
2. Navegação por gestos e por três botões; retrato e paisagem; tela com recorte (cutout).
3. `Main` e `PrefScreenSheets` (sem ActionBar): devem ficar como na 1.4.3.
4. Android 14 ou menor: sem mudança (o handler não é registrado).
5. Se o vão persistir, a causa é outra. Registrar temporariamente, no listener, `systemBars().top`, `topMargin` e `getTop()` do conteúdo e comparar com o vão medido.

## Ponto a observar (não alterado)
`res/layout/main.xml` tem `android:fitsSystemWindows="true"` no ScrollView raiz e, em Android 15+, o `InsetsHandler` também aplica padding no `android.R.id.content` que o contém. Como as insets não são consumidas, o topo de `Main` pode estar com espaço em dobro pelo mesmo motivo. Não foi tocado por não ter sido relatado.

## Referências
- https://android.googlesource.com/platform/frameworks/base.git/+/refs/heads/main/core/java/com/android/internal/widget/ActionBarOverlayLayout.java
- https://developer.android.com/develop/ui/views/layout/edge-to-edge
- https://developer.android.com/about/versions/16/behavior-changes-16
