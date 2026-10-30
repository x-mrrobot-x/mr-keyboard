# 1.4.5 — Cabeçalho das telas de configurações sem a ActionBar do framework

## Problema
No Android 17, as telas de configurações (ex.: "Configurações do Mr Keyboard") mostram um vão grande entre a barra de título e o primeiro item. As telas "Folhas do teclado" e "Editor de folhas" aparecem corretamente no mesmo aparelho. A tentativa da 1.4.4 (compensar a margem no `InsetsHandler`) não resolveu e foi revertida.

## O que as telas corretas fazem de diferente
- `PrefScreenSheets` e `SheetEditorActivity` usam `Theme.MrKeyboard.Main` (`windowActionBar=false`, `windowNoTitle=true`) e montam o cabeçalho em código no próprio layout: linha de cabeçalho, divisor de 1dp e conteúdo.
- O `InsetsHandler` é o mesmo nas duas famílias de telas. Ele só reserva as barras do sistema como padding de `android.R.id.content`. Sem ActionBar, isso basta.
- As seis `PreferenceActivity` (`LatinIMESettings`, `PrefScreenView`, `PrefScreenFeedback`, `PrefScreenActions`, `PrefScreenAdvanced`, `InputLanguageSelection`) usam `Theme.MrKeyboard.Settings`, que mantém a ActionBar do framework. O `Theme.MrKeyboard.Main` herda do `Settings` e só acrescenta o desligamento da ActionBar; essa é a única diferença de tema entre as telas que funcionam e as que não funcionam.
- Conclusão: o vão vem da combinação ActionBar do framework + padding do `InsetsHandler` em Android 15+. O `InsetsHandler` só é registrado com `SDK_INT >= 35`, o que explica por que o outro aparelho não mostra o vão. O mecanismo interno exato dentro da ActionBar não foi reproduzido; a conclusão se apoia na comparação entre as telas.

## Alteração
- `Theme.MrKeyboard.Settings`: `android:windowActionBar=false` e `android:windowNoTitle=true`.
- Novo `SettingsHeader.install(Activity)`: envolve a raiz do `PreferenceActivity` num `LinearLayout` vertical com cabeçalho (56dp, fundo `mr_ui_bg`, título de `getTitle()` em 19sp medium `mr_ui_text`, 16dp de margem lateral) e divisor de 1dp (`mr_ui_stroke`), seguido do conteúdo original com peso 1. Mesmas cores e medidas da ActionBar anterior.
- `ListDividerFix.apply` (já chamado no `onCreate` das seis telas, depois de `addPreferencesFromResource`) passou a chamar `SettingsHeader.install`.
- `InsetsHandler` voltou ao original da 1.4.3.
- Versão: 1.45.0 (código 1045000).

## Preservado
Lista de preferências, estilos de linha/cartão, `MrListView`, diálogos, `PrefScreenSheets`, `SheetEditorActivity`, `Main` e o teclado.

## Validação
- `apktool b` (2.11.1) montou smali e recursos sem erros; o APK gerado foi desmontado e o tema, o helper e a chamada foram conferidos.
- Não houve execução no aparelho.

## Testes Android necessários
1. Android 17 (e 15/16) nas seis telas: título logo abaixo da status bar, primeiro item a ~14dp do divisor, último item acima da barra de navegação.
2. Navegação por gestos e por três botões; retrato e paisagem; recorte (cutout).
3. Android 14 ou menor: o cabeçalho deve ficar com a mesma aparência da ActionBar anterior (fundo escuro, título à esquerda, linha fina embaixo).
4. Idioma da interface diferente do sistema: o título usa `getTitle()`, como a ActionBar usava.
5. Sem botão de voltar no cabeçalho, como antes (voltar pelo gesto/botão do sistema).

## Limitações conhecidas
- O cabeçalho é fixo em 56dp; a ActionBar usava 48dp em paisagem.
- Se o vão persistir após esta alteração, a causa não é a ActionBar e é necessário medir as insets no aparelho.
