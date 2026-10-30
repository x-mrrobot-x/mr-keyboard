# 1.4.6 — Revisão das demais telas e ajuste do espaço das barras na tela inicial

## Contexto
A 1.4.5 corrigiu o vão nas telas de configurações (confirmado no aparelho): sem ActionBar do framework e com o cabeçalho desenhado no próprio layout. Esta revisão verifica se outras telas precisam do mesmo tratamento.

## Levantamento
Activities do manifest (11) e o resultado:

| Tela | Tema | Situação |
|---|---|---|
| `LatinIMESettings`, `PrefScreenView`, `PrefScreenFeedback`, `PrefScreenActions`, `PrefScreenAdvanced`, `InputLanguageSelection` | `Settings` | Corrigidas na 1.4.5. Todas chamam `addPreferencesFromResource` e depois `ListDividerFix.apply`, que instala o cabeçalho; título definido com `setTitle(id)` antes. |
| `PrefScreenSheets`, `SheetEditorActivity` | `Main` | Já usam cabeçalho no layout, sem ActionBar. Sem alteração. |
| `Main` | `Main` | Sem ActionBar, mas com `fitsSystemWindows` (ver abaixo). |
| `ActivityHelper`, `ShotPerm` | `Translucent.NoTitleBar` | Sem interface visível. Sem alteração. |

- Nenhuma outra classe estende `Activity`, `PreferenceActivity`, `ListActivity` ou `Dialog`. O tema `Settings` não é aplicado por `setTheme`/`ContextThemeWrapper` em lugar nenhum.
- Diálogos (`KeyEditDialog`, `PopupEditDialog`, `SpecialKeyPicker`, os de `PrefScreenSheets`, `SheetEditorActivity` e `LatinIMESettings`) usam `AlertDialog.Builder(context)`: janelas flutuantes com `Theme.MrKeyboard.Dialog`, sem `setLayout` nem flags de tela cheia. Não são afetados.
- A janela do teclado (IME) foi tratada na 1.4.3 e não usa ActionBar.
- O único `fitsSystemWindows` do projeto estava em `res/layout/main.xml`.

## Alteração
- `res/layout/main.xml`: removido `android:fitsSystemWindows="true"` do `ScrollView` raiz.
- Motivo: em Android 15+ o `InsetsHandler` já aplica as barras do sistema como padding em `android.R.id.content` e devolve as insets sem consumir. Com o atributo, o `ScrollView` filho aplicava o padding de novo, reservando o espaço das barras duas vezes (topo e base). Sem o atributo, `Main` usa o mesmo mecanismo de `PrefScreenSheets`/`SheetEditorActivity`.
- Abaixo do Android 15 o `InsetsHandler` não é registrado e o decor já consome as insets; nada muda.
- Versão: 1.46.0 (código 1046000).

## Nota de confiança
O efeito em `Main` foi deduzido do código (padding do handler + `fitsSystemWindows` do filho, com insets não consumidas). Não foi medido no aparelho. Se `Main` já parecia correto e piorar, basta restaurar a linha `android:fitsSystemWindows="true"` no `ScrollView` de `main.xml`.

## Validação
- `apktool b` (2.11.1) sem erros; `fitsSystemWindows` não aparece mais em `res/` nem no smali.
- Não houve execução no aparelho.

## Testes Android necessários
1. Android 15, 16 e 17: tela inicial com o título logo abaixo da status bar e o conteúdo acima da barra de navegação, sem folga extra; rolagem até o fim.
2. Gestos e três botões; retrato e paisagem; recorte (cutout).
3. Android 14 ou menor: igual à versão anterior.
