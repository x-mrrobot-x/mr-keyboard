<!-- target-version: v1.83.0 -->
# Plano: telas corretas em todos os SDKs, sem duplicação e sem peso

Objetivo: Main, Configurações (e subtelas), folhas do teclado, editores e diálogos aparecem sem faixas, sem
espaços extras e sem sobrepor as barras do sistema do Android 8 (SDK 26) ao 17 (SDK 37), sem abrir a mesma tela
duas vezes e sem pesar a abertura ou o uso do teclado.

Este plano nasceu de uma análise estática do código (nada foi medido em aparelho) mais a leitura da documentação
oficial. O defeito relatado no Android 17 (espaço grande e fixo abaixo do título de Configurações, que não some
ao rolar) entra como item principal.

## Decisões do usuário

- Teclado abrindo uma tela que já está no histórico: **reaproveitar a aberta** (traz para frente; não cria outra
  e não fecha nada).
- Android 8–14 (SDK 26–34): **manter o modo clássico** (barras com a cor do tema). Só se corrige o Android 15+.
- Aceleração por hardware: **opção nas configurações** para ligar/desligar, **desligada por padrão** (o
  comportamento de hoje não muda para quem não mexer).
- Espaço do Android 17: **corrigir por construção** (ninguém consegue aplicar a margem da barra duas vezes). Se
  sobrar espaço depois do teste no aparelho, aí se coleta um dump da hierarquia (ver Etapa 1).

## O que a análise encontrou

**Barras e insets**
- O app tem targetSdk 36 e minSdk 26. No Android 15+ a janela é edge-to-edge à força (no 16 o opt-out sumiu).
  Um único `InsetsHandler` (callback global de Activity, registrado só com SDK ≥ 35 em `MrApplication`) aplica
  `systemBars | displayCutout` como padding de `android.R.id.content`. Por estar só no 35+, as chamadas API 30+
  dele são seguras.
- O `InsetsHandler` devolve os insets **sem consumir**. Qualquer View abaixo (inclusive o layout da
  PreferenceActivity, que é do sistema e muda entre versões do Android) pode aplicar a mesma margem de novo. É a
  causa mais provável do espaço fixo no Android 17, mas **não está confirmada** (sem o aparelho não dá para ver a
  hierarquia).
- Abaixo do 35 a janela usa o modo clássico, com `statusBarColor`/`navigationBarColor` do tema. Está correto e
  é o que o sistema espera nessas versões. Em paisagem com notch (SDK 28–34) o sistema pinta a faixa do recorte
  de preto; é o comportamento padrão, aceito.
- O tema escuro (`Theme.Material`) já dá ícones claros nas barras; não há `windowLightStatusBar` a acertar.
- Android 17: nas páginas oficiais de mudanças não há alteração de barras, insets ou edge-to-edge. A única mudança
  de interface para todos os apps é: se a configuração muda (rotação) e a Activity não trata, o teclado que estava
  aberto **não volta mais** sozinho. Afeta o editor de folhas e o editor de estilos de IA (têm campo de texto).
- Voltar: `enableOnBackInvokedCallback=true` já está ligado e nenhuma tela sobrescreve `onBackPressed`; o
  Android 16 deixar de chamá-lo não afeta as telas. O `Back` dentro do teclado (`LatinIME.onKeyDown` →
  `handleBack`) precisa de teste no aparelho (Etapa 7).

**Duplicação**
- Nove pontos do app abrem telas com só `FLAG_ACTIVITY_NEW_TASK` e launch mode padrão: `LatinIME` (engrenagem e
  atalho genérico), `MrAi` (preferências e editor de estilo), `MrPacks`, `MrTools` (folhas), `MrShots`
  (`ShotPerm` e `ShotPick`, que já são `singleInstance`) e `MrUpdateUi$Notif`. Com NEW_TASK, o sistema acha a
  tarefa do app e **empilha uma nova instância** por cima. Tocar na engrenagem três vezes dá três Configurações;
  Voltar precisa de três toques.
- Dentro do app, as linhas de Configurações abrem subtelas com `<intent action=...>` e launch mode padrão: duplo
  toque rápido abre a subtela duas vezes.
- A notificação de atualização usa `NEW_TASK | CLEAR_TASK`: não duplica, mas apaga o histórico do app. Fica como
  está (é a forma segura de abrir o diálogo da atualização).
- `recreate()`: `Main.onResume` (idioma mudou) e `LatinIMESettings` (troca de idioma). Cada um recria uma vez e
  não entra em laço. Sem problema.

**Peso no teclado**
- Telas e teclado rodam no mesmo processo, mas nenhuma tela é criada antes de ser aberta. `MrApplication.onCreate`
  só registra um callback; o `onCreate`/`onStartInputView` do teclado não toca em classes de tela.
- Os custos indiretos reais são dois: (1) instâncias duplicadas acumulando memória no processo do teclado
  (principalmente o editor de folhas, 4 mil linhas de smali e árvore de Views grande); (2) `hardwareAccelerated`
  está **desligado no app inteiro**, então Main e Configurações desenham por software e podem rolar pior. Só o
  editor de folhas, `PrefScreenSheets` e o editor de estilos de IA ligam por conta própria. A opção da Etapa 5
  deixa o usuário ligar nas demais telas, sem mudar o padrão.
- A janela do teclado não depende desse atributo: o javadoc de `InputMethodService.enableHardwareAcceleration`
  diz que, da API 21 em diante, a aceleração do IME é ligada pelo sistema nos aparelhos capazes.

**Diálogos**
- AlertDialog e diálogos de preferência (`Theme.MrKeyboard.Dialog`) e `MrUpdateDialog` são janelas flutuantes: a
  imposição de edge-to-edge não as afeta.
- `MrAiDialog` fica preso à janela do teclado, com gravidade TOP e altura até o topo do teclado
  (`TYPE_APPLICATION_ATTACHED_DIALOG`, flags `0x308`). Precisa de teste no Android 15+ para confirmar que o
  cartão não fica sob a barra de status nem sob o recorte (Etapas 4 e 7).

## Etapas

### Etapa 1 — Insets consumidos e um só lugar para as telas (corrige o espaço do Android 17) — FEITA
- `MrScreens` (Java, `docs/tools/java/src/com/mrkeyboard/app/`) no lugar de `InsetsHandler.smali`: callback de
  ciclo de vida que, no Android 15+, aplica as barras do sistema e o recorte como padding de
  `android.R.id.content` e **devolve `insets.inset(l, t, r, b)`**. A margem fica consumida: nenhum descendente
  (nem o layout do sistema, que muda entre versões) consegue aplicá-la de novo. As chamadas da API 30 ficam
  isoladas em `MrScreens$Api30`, como já é feito em `ImeInsets`.
- O teclado (IME) continua passando para as telas: `inset` só desconta o que já virou padding. A conta do
  editor de folhas (`ime.bottom − systemBars.bottom`, em `Api30ImeHelper`) dá o mesmo valor de antes (852 no
  exemplo do teste, com teclado de 900 e barra de 48).
- `MrApplication.smali` chama `MrScreens.install(this)`; a checagem de SDK (35) fica dentro do Java, em
  `onActivityStarted` (os insets). Desde a Etapa 5 o callback é registrado em todos os Androids, porque a opção de
  aceleração vale em todos; abaixo do 35 os insets continuam intocados, como antes.
- O tema continua com `statusBarColor`/`navigationBarColor` (valem no SDK 26–34 e na barra de 3 botões).
- Teste no PC: `docs/tools/screens_test/ScreensTest.java` (25 checks: SDK que registra, padding, insets que
  sobram, paisagem com recorte, teclado). Sete mutações do `MrScreens` foram todas pegas pelo teste.
- Se depois do teste no aparelho o espaço continuar no Android 17: coletar com `adb shell dumpsys activity top`
  a hierarquia e as posições das Views de Configurações e achar quem aplica a margem.
- Arquivos: `MrScreens.java`, `MrScreens.smali` e `MrScreens$Api30.smali` (gerados), `MrApplication.smali`,
  `InsetsHandler.smali` (removido), comentário do `SettingsHeader.smali`, stubs (`Application`, `Insets`,
  `WindowInsets`, `View`, `Activity`), `run_java_tests.sh`, `build_java.sh`.

### Etapa 2 — Teclado ao girar a tela e retorno ao Editor de IA — FEITA
- **`MrScreenIme`** (Java, novo): `save` guarda em `onSaveInstanceState` qual campo tinha o foco com o teclado
  aberto (`getRootWindowInsets().isVisible(Type.ime())`, API 30+; abaixo disso não guarda nada, que é o que
  essas versões já faziam) e a posição do cursor. `restore`, no fim do `onCreate`, devolve o foco e pede o
  teclado quando a janela nova recebe o foco, num `post` (antes disso o sistema ignora o pedido). O motivo: no
  Android 17 o app precisa pedir o teclado de novo depois da rotação; só continua aberto o campo que ainda tem
  foco com `SOFT_INPUT_STATE_ALWAYS_VISIBLE`, que não usamos porque abriria o teclado em toda volta ao app.
- **Editor de folhas** (`SheetEditorActivity`, smali): novo `onSaveInstanceState` e uma chamada a
  `MrScreenIme.restore` depois do `setContentView`; vale para o campo de teste.
- **Editor de estilo de IA** (`MrAiStyleActivity`):
  - Os campos não tinham `id`, então o sistema nunca salvou o que foi digitado: girar a tela apagava o nome e as
    instruções. Agora nome, instruções, emoji e o "Excluir" já armado sobrevivem à recriação e vencem o que está
    guardado no estilo.
  - O achado da Etapa 1 se confirmou na leitura do código: sem tratar o teclado, no Android 15+ o campo de
    instruções ficava atrás dele. `MrScreenIme.lift` soma a altura do teclado (descontadas as barras) ao padding
    de baixo da coluna e rola até o campo com o foco quando o teclado aparece, na mesma conta do editor de folhas.
    Segue **a confirmar no aparelho**.
- **Retorno ao diálogo do Editor de IA depois de Configurações** (pedido do usuário). Antes, o diálogo só voltava
  se o sistema religasse o teclado sozinho (`onWindowShown`); se não religasse, não voltava nem o teclado nem o
  diálogo. Agora `LatinIME.onStartInput` chama `MrAiDialog.onInputStarted`: quando o campo do app de onde o
  usuário saiu volta a conectar, o teclado pede para aparecer (`requestShowSelf(0)`, API 28+; antes disso fica
  como antes) e, quando a janela aparece, o diálogo reabre (`onImeWindowShown`, já existente).
  - Só para o mesmo pacote, só uma vez por ida (mais uma repetição depois de 400 ms se o teclado ainda não subiu),
    só com a tela de Configurações/Estilos já fora da frente.
  - Limite de 2 minutos desde que a última tela auxiliar saiu da frente: depois disso o pedido é descartado,
    para o diálogo e o teclado não aparecerem do nada na próxima vez que o app for usado.
  - Vale também para o botão de estilos do diálogo (mesmo caminho).
- Testes no PC: `screenime_test/ScreenImeTest.java` (57 checks) e `ai_return_test/AiReturnTest.java` (38 checks).
  Mutações: todas pegas, exceto duas equivalentes.
- Arquivos: `MrScreenIme.java` (+ `.smali` gerados), `MrAiDialog.java`, `MrAiStyleActivity.java`,
  `SheetEditorActivity.smali`, `LatinIME.smali`, stubs (`Bundle`, `View`, `ViewGroup`, `ViewTreeObserver`,
  `TextView`, `EditText`, `ScrollView`, `WindowInsets`, `InputMethodManager`, `SystemClock`,
  `InputMethodService`, `Activity`, `Context`), `run_java_tests.sh`, `build_java.sh`.
- **Voltar caía na página principal do teclado, às vezes** (pedido do usuário, no mesmo commit). Nenhuma tela tinha
  tarefa própria (todas com a afinidade do app). Aberta pelo teclado com `NEW_TASK`, a tela entrava na tarefa do app
  quando ela já existia (app aberto antes, nos recentes), em cima da página principal: o Voltar mostrava essa página.
  Sem tarefa do app aberta, criava tarefa nova e o Voltar voltava ao app em que se digitava. Isso explica o "às
  vezes". Causa lida no manifesto e no código (nenhum código abre a `Main` ao voltar); **a confirmar no aparelho**.
  - Correção: `android:taskAffinity="com.mrkeyboard.app.screens"` nas cinco telas que o teclado abre
    (`LatinIMESettings`, `PrefScreenSheets`, `MrPacksActivity`, `MrAiPrefs`, `MrAiStyleActivity`; decisão do
    usuário: todas as telas abertas pelo teclado). As cinco dividem a mesma afinidade para o editor de estilo
    ficar na tarefa das configurações de IA. As subtelas abertas de dentro do app não precisam: sem `NEW_TASK`
    elas ficam na tarefa de quem as abriu. `ShotPerm`/`ShotPick` já são `singleInstance` fora dos recentes.
  - Efeito colateral aceito: essas telas aparecem como um cartão próprio nos apps recentes.
  - A notificação de atualização (`NEW_TASK | CLEAR_TASK` para `LatinIMESettings`) passa a limpar só a tarefa
    dessas telas, não mais a do app inteiro.
  - Guarda no `res_check.py`: as cinco precisam ter afinidade própria (não o nome do pacote) e a mesma.
  - A Etapa 3 (`MrNav`) mantém essas telas com `NEW_TASK` quando vêm do teclado.
- Os diálogos de preferência com campo de texto são recriados junto com a tela; não precisam de nada.

### Etapa 2b — Ferramenta "Personalizar teclado", teclado ao girar a tela e botões da barra — FEITA
- Pedido do usuário (teste no aparelho): com a ferramenta aberta em retrato (diálogo), girar para paisagem deve abrir o
  painel dentro do teclado, e ao voltar para retrato o diálogo deve reaparecer, sem o teclado fechar. Antes, girar
  fechava a ferramenta (a janela do teclado esconde e `onWindowHidden` fecha a ferramenta; ao reconstruir o teclado o
  `MrTune.setup` também fecha o diálogo em paisagem e o painel em retrato).
- **`MrKeep`** (Java, novo, `docs/tools/java/src/com/mrkeyboard/app/MrKeep.java`), ligado em três pontos do `LatinIME.smali`:
  `onConfigurationChanged` (quando a orientação muda, antes de reconstruir o teclado: `onTurn`), `onWindowHidden`
  (antes de fechar a ferramenta: `onHidden`) e `onStartInput` (`onInput`).
  - Guarda, na virada, se a ferramenta estava aberta (painel ou diálogo), se o teclado estava visível e de qual app.
  - Uma checagem leve num `Handler` (a cada 150 ms, só durante os 4 s depois da virada): quando o teclado está
    visível e a ferramenta não está aberta, chama `MrTune.toggle()`, que abre o painel (paisagem) ou o diálogo (retrato).
  - **Android 17:** um app recriado pela rotação não recebe mais o teclado de volta do sistema. Se o teclado estava
    visível na virada e o mesmo app liga um campo de novo, pede `requestShowSelf` (até 3 vezes, 450 ms entre elas,
    mesma rotina do retorno do Editor de IA). Se o teclado já está visível, não pede nada.
  - Nada dura além de 4 s depois do último evento; esconder o teclado sem girar (Voltar, tocar fora) não reabre nada;
    ferramenta fechada antes de girar continua fechada; outro app que ligue um campo não recebe o teclado à força.
- Guardas no `res_check.py`: os três pontos do `LatinIME.smali` precisam chamar o `MrKeep`, e `onHidden` vem antes de
  fechar a ferramenta.
- **Botão da barra de ferramentas fecha o diálogo aberto** (`MrBarClose`, Java, novo; chamado no começo de
  `MrTools.onClick`): com o diálogo do Editor de IA ou o de Personalizar teclado aberto, tocar em qualquer um dos sete
  botões da barra (área de transferência, tradutor, anexos, emoji, folhas, Personalizar, Editor de IA) fecha os diálogos
  abertos, e o botão faz em seguida o que sempre fez (abre o painel, o tradutor etc.). O diálogo que o próprio botão
  controla fica por conta do toggle dele (fechar antes faria o toggle abri-lo de novo): o botão do Editor de IA fecha o
  de Personalizar e abre/fecha o do Editor de IA; o de Personalizar faz o inverso. Botões dentro dos painéis (limpar
  a área de transferência, fotos etc.) não passam por isso. `MrTune.dismissDialog` deixou de ser privado para isso.
  O painel de Personalizar em paisagem (dentro do teclado) não é diálogo e não muda. Em paisagem o diálogo do Editor de IA
  cobre a tela toda (Etapa 4), então a barra nem fica ao alcance.
- Guardas no `res_check.py`: os três pontos do `LatinIME.smali` precisam chamar o `MrKeep` (e `onHidden` vem antes de
  fechar a ferramenta); `MrTools.onClick` precisa chamar o `MrBarClose`, e a lista de códigos do `MrBarClose` tem de ser a que o
  `MrTools` liga aos sete botões de `bar_tools`.
- Testes no PC: `keep_test/KeepTest.java` (33 checks: diálogo para painel, painel para diálogo, ferramenta fechada,
  ferramenta que continua aberta, Android 17 com 1 a 3 pedidos, outro app, expiração, esconder sem girar, duas viradas
  seguidas, pedido recusado, Android 8, `null`). Treze mutações: todas pegas, menos uma equivalente.
- Observação do usuário (teste no Acode): o teclado reabrir ao voltar para o app com o campo focado é comportamento do
  Android, confirmado por ele com outro teclado; nada a fazer.
- **A confirmar no aparelho:** a ordem em que o Android chama `onConfigurationChanged`, `onWindowHidden` e
  `onStartInput` na rotação (o `MrKeep` não depende da ordem, mas a janela de 4 s é um palpite); o painel abrir logo
  depois da virada, sem piscar.
- Testes no PC do `MrBarClose`: `bar_test/BarTest.java` (30 checks: os cinco botões que abrem outra coisa, o do Editor de IA, o
  de Personalizar, nada aberto, diálogo que já não aparece, códigos que não são da barra, sete botões). Sete mutações
  pegas e duas nas guardas.
- Arquivos: `MrKeep.java`, `MrBarClose.java` (+ smali gerados), `LatinIME.smali`, `MrTools.smali`, `MrTune.smali`,
  `MrAiDialog.java` (`showKeyboard` e `isShowing` do pacote), stub `MrTune`, `KeepTest.java`, `BarTest.java`,
  `res_check.py`, `run_java_tests.sh`, `build_java.sh`.

### Etapa 3 — Sem duplicação — FEITA
- **`MrNav`** (Java, novo): `MrNav.intent(contexto, tela)` é o único lugar que monta o Intent de abertura de tela.
  Vindo do teclado (contexto que não é Activity): `NEW_TASK | REORDER_TO_FRONT`. Vindo de uma tela: só
  `REORDER_TO_FRONT` (a nova fica na pilha de quem a abriu, e uma cópia que já esteja nessa pilha, como um editor de
  estilo deixado embaixo da lista, vem para a frente em vez de ganhar uma segunda). Sem `CLEAR_TOP` de propósito: ele anularia o `REORDER_TO_FRONT` e fecharia o que o
  usuário tem aberto por cima (um estilo em edição, por exemplo). Sem `MULTIPLE_TASK` nem `CLEAR_TASK`.
- **Pontos trocados** (a análise tinha contado nove; a guarda do `res_check.py` achou um décimo):
  `LatinIME.onOptionKeyPressed` e `LatinIME.launchSettings(Class)` (Configurações), `MrTools` (Folhas),
  `MrPacks.onPick` (Pacotes), `MrAi.openPrefs` e `MrAi.openStyleEditor`, e `NotificationHelper` (ação "Configurações"
  da notificação do teclado). Ficaram como estavam: `ShotPerm`/`ShotPick` (`singleInstance`, fora dos recentes), a
  notificação de atualização (`NEW_TASK | CLEAR_TASK`, é de propósito), as telas do sistema de notificações e de
  instalação, e os links externos.
- **Manifesto:** `launchMode="singleTop"` nas 10 telas que não são o launcher nem `singleInstance`
  (`LatinIMESettings`, `MrPacksActivity`, `MrAiPrefs`, `MrAiStyleActivity`, `PrefScreenActions`, `PrefScreenAdvanced`,
  `PrefScreenSheets`, `SheetEditorActivity`, `PrefScreenView`, `PrefScreenFeedback`). O duplo toque numa linha de
  Configurações chega à tela já aberta por `onNewIntent`, em vez de empilhar outra.
- **Editor de estilo de IA já aberto** (`MrAiStyleActivity.onNewIntent`): mesmo estilo, ou outro estilo mas com
  edição não salva, só fica na frente (nada se perde); outro estilo e nada a perder, a tela é recriada no estilo
  pedido. O índice agora vem do estado salvo quando há um (`recreate()` reabre com o Intent original, não com o
  novo) e o rascunho só vale se foi guardado para o mesmo estilo.
- **Guardas no `res_check.py`:** toda tela do manifesto (menos a `Main` e as `singleInstance`) tem `singleTop`; nenhum
  método monta à mão um Intent com `NEW_TASK` para as cinco telas do teclado.
- Testes no PC: `nav_test/NavTest.java` (35 checks: flags do teclado e de tela, decisão do editor de estilo). Mutações:
  todas pegas (inclusive tirar o `REORDER_TO_FRONT` das telas).
- **A confirmar no aparelho:** `REORDER_TO_FRONT` com `NEW_TASK` e `onNewIntent` seguem a documentação e o uso comum,
  mas o comportamento exato depende do Android (checklist da Etapa 7, item "Duplicação").
- Limite conhecido: uma tela aberta de dentro do app (tarefa do app) e a mesma aberta pelo teclado (tarefa própria)
  são tarefas diferentes; pode haver uma cópia em cada. Não há como unir sem mexer na navegação do app.
- Arquivos: `MrNav.java` (+ `.smali` gerados), `MrAi.java`, `MrPacks.java`, `MrAiStyleActivity.java`, `LatinIME.smali`,
  `MrTools.smali`, `NotificationHelper.smali`, `AndroidManifest.xml`, `res_check.py`, stubs (`Intent`, `Activity`,
  `LatinIMESettings`, `PrefScreenSheets`), `run_java_tests.sh`, `build_java.sh`.

### Etapa 4 — Verificar `MrAiDialog` e `MrUpdateDialog` nas janelas edge-to-edge — FEITA
- **`MrUpdateDialog`:** diálogo flutuante comum (`Theme.MrKeyboard.Dialog`, pai `Material.Dialog.Alert`), aberto de uma
  Activity, sem flags de layout próprias. O sistema o posiciona dentro da área útil. Nada a mudar.
- **`MrAiDialog`:** janela própria presa à janela do teclado (`TYPE_APPLICATION_ATTACHED_DIALOG`), gravidade no topo,
  `LAYOUT_IN_SCREEN | LAYOUT_NO_LIMITS`, do topo da tela até o teclado. Não é uma Activity, então o `MrScreens` nunca
  a via. A captura do usuário no **Android 13**, em paisagem, mostrou dois problemas (e **não** é coisa só do 15+):
  1. o cartão ficava sob a barra de status e sob o recorte da câmera (topo do cartão a 12 dp da borda, sem recuo);
  2. com o teclado ocupando quase 80% da altura, a área acima dele tinha ~90 dp: só aparecia o cabeçalho e o começo
     da linha de estilos.
- **Correção 1, recuo** (`MrScreens.fitDialog(decor, root)`, do **Android 11** em diante): as barras do sistema e o
  recorte que tocam a janela viram padding do root do diálogo (`WindowInsets.Type.systemBars | displayCutout`).
  A camada escura é o fundo do root e continua cobrindo a janela inteira; sem sobreposição o padding é zero (retrato
  igual a antes). O listener fica na **decor view**, não no root: o layout do sistema (`screen_simple`, com
  `fitsSystemWindows`) consome os insets antes de chegarem ao conteúdo, e janelas com `LAYOUT_NO_LIMITS` não
  recebem os insets legados (motivo provável de o sistema não afastar o cartão sozinho). O que chega à decor segue
  para o tratamento normal dela (`decor.onApplyWindowInsets`). Antes do Android 11 nada muda (sem a API por tipo).
- **Correção 2, altura** (`MrAiDialog.windowHeight`): se a área acima do teclado tem menos de 240 dp
  (`SHORT_AREA_DP`), a janela do diálogo ocupa a **tela inteira** (o diálogo cobre o teclado enquanto está aberto),
  já abaixo da barra de status e do recorte. Retrato e tablets: igual a antes (até o teclado). A conta usa a
  densidade da tela e é refeita a cada mudança de layout do teclado (girar a tela troca de modo sozinho).
- Testes no PC: `ScreensTest` com 41 checks (Android 13, 16 e 29, retrato, paisagem com recorte lateral, sem
  sobreposição, tela toda com barra de navegação, decor tratando o resto, `null`; `windowHeight` com 228 px a 2,5 =
  91 dp, 520 dp, o limite exato de 240 dp, em dp e não em px, posição do teclado desconhecida). Sete mutações:
  seis pegas, a sétima é equivalente (`imeTop <= 0` e `imeTop < limite` dão o mesmo para valores não positivos).
- Guarda no `res_check.py`: `MrAiDialog.java` chama `MrScreens.fitDialog(window.getDecorView(), root)` e tira as duas
  alturas (abertura e mudança de layout) de `windowHeight`; o smali gerado precisa estar em dia.
- **A confirmar no aparelho (Android 13 e 17, retrato e paisagem):** em paisagem o diálogo ocupa a tela, o cartão
  fica abaixo do relógio e da câmera e rola se faltar altura; em retrato é igual a antes. Se o sistema não entregar os
  insets à janela, o padding fica zero e a barra de status continua por cima (aí o plano é ler a altura da barra
  pela decor do teclado).
- Limite conhecido: Android 8 a 10 ficam como antes (sem a API de insets por tipo).
- Arquivos: `MrScreens.java` (+ `MrScreens$DialogFit` e `.smali` gerados), `MrAiDialog.java` (+ smali), `res_check.py`,
  `ScreensTest.java`, stub `View`.

### Etapa 5 — Aceleração por hardware com opção — FEITA
- Preferência nova `pref_ui_hw_accel`: caixa de seleção em **Avançado**, categoria nova "Telas" (`screen_drawing`),
  padrão **desligada**, textos em inglês, espanhol e português do Brasil (`mr_ui_cat_draw`, `mr_ui_cat_draw_sum`,
  `mr_ui_hw_accel`, `_on`, `_off`). Desligada, as telas seguem desenhando por software, exatamente como hoje. O
  resumo diz que o teclado não é afetado.
- O Android permite **ligar** a aceleração por janela, mas não desligar (documentação oficial). Por isso o
  manifesto continua `hardwareAccelerated="false"` no `<application>` e `MrScreens.onActivityCreated` liga o flag
  da janela (`FLAG_HARDWARE_ACCELERATED`) quando a preferência está ligada. A janela só é entregue ao sistema
  depois do `onResume`, então o flag chega a tempo (**a confirmar no aparelho**, Etapa 7).
- Fora da opção: as janelas auxiliares sem tela (`ShotPerm`, `ShotPick`, `ActivityHelper`, por nome em
  `MrScreens.HELPERS`) e as três telas que **já aceleram pelo manifesto** (`PrefScreenSheets`, `SheetEditorActivity`,
  `MrAiStyleActivity`): continuam `true`, são desenhadas por código próprio e passá-las para software pioraria o
  editor por padrão. Com a opção desligada o código não tira um flag que o manifesto já tenha posto.
- Falha ao ler a preferência (`RuntimeException`) deixa a tela como estava: a tela sempre abre.
- Ao alternar, `PrefScreenAdvanced.onSharedPreferenceChanged` chama `MrScreens.onSetting`, que faz `recreate()` só
  para a chave `pref_ui_hw_accel`. Só a tela Avançado se recria na hora; as telas que já estavam abertas atrás dela
  (Configurações, Main) pegam o novo valor na próxima vez que forem abertas. Não há `recreate` automático nas demais
  de propósito: se o flag não pudesse ser ligado, um laço de recriação seria pior que o problema.
- Entrou em `MrReset.KEYS` ("Restaurar padrões"): `check_reset_keys.py` agora dá 44 | 56.
- **Checagem do teclado (sem opção por enquanto):** pela documentação, a aceleração do IME é ligada pelo sistema
  na API 21+, independente do atributo do app, mas isso não foi confirmado no aparelho. `MrAccel` (Java, novo)
  escreve **uma linha por processo** no log, na primeira vez que a janela do teclado aparece e já está anexada:
  `MrAccel: keyboard window hardwareAccelerated=true|false (SDK n)`. Ler com `adb logcat -s MrAccel` e comparar com
  `adb shell dumpsys gfxinfo com.mrkeyboard.app` com o teclado aberto. Se `true`: nada a fazer. Se `false`: só
  então avaliar uma opção própria para o teclado, com teste visual completo (o desenho do teclado é por código
  próprio e pode sair errado com a aceleração). O gancho é em `LatinIME.onWindowShown`; a classe nunca falha o
  teclado (qualquer exceção é engolida).
- Testes no PC: `ScreensTest` ficou com 90 checks (registro em todos os SDKs, insets intocados abaixo do 35,
  padrão desligado, flag ligado em todos os SDKs, flags existentes preservados, auxiliares sem flag, preferência
  ilegível ou ausente, tela sem janela, `onSetting`); `accel_test/AccelTest.java` com 14 (uma linha só, espera o
  anexo da view, diz `true`/`false` conforme a janela, nada disponível não falha). Mutações: 16 das 18 foram pegas;
  as 2 que sobraram (tirar a checagem de `null` da view e do diálogo no `MrAccel`) são equivalentes, porque o
  `NullPointerException` cai no `catch (RuntimeException)` e o resultado é o mesmo (nada no log, nada falha).
- Guardas em `res_check.py`: `<application>` com `hardwareAccelerated="false"` e as únicas telas `true` são as
  três acima; a preferência (chave, `persistent`, `defaultValue="false"`, resumos) e as cinco strings nos três
  idiomas; `MrScreens.install` sem checagem de SDK e padrão `false` no código; os dois ganchos em smali. Dez
  mutações dos guardas, todas pegas.
- Arquivos: `MrScreens.java` (e o smali gerado), `MrAccel.java` (novo, com `MrAccel$1.smali`), `MrReset.java`,
  `PrefScreenAdvanced.smali`, `LatinIME.smali` (`onWindowShown`), `MrApplication.smali` (comentário),
  `prefs_advanced.xml`, `mr_strings.xml` (3 idiomas), `res_check.py`, `build_java.sh`, `run_java_tests.sh`, stubs
  (`Window.setFlags`, `Activity.getWindow` e contador de `recreate`, `FLAG_HARDWARE_ACCELERATED`,
  `PreferenceManager.stubDefault`, `util/Log`, `View.isAttachedToWindow`/`isHardwareAccelerated`).

### Etapa 6 — Guardas e testes — FEITA
- Os testes Java no PC foram escritos junto com cada etapa, em vez de num `MrScreensTest` só: `ScreensTest` (90:
  aritmética de insets, diálogo, altura da janela, aceleração), `NavTest` (35: flags de `MrNav`), `ScreenImeTest`
  (57), `AiReturnTest` (38), `KeepTest` (33), `BarTest` (30) e `AccelTest` (14), todos no `run_java_tests.sh`.
- Guardas novas no `res_check.py` (as de manifesto, aceleração e strings da preferência já tinham entrado nas
  Etapas 2–5):
  - nenhum arquivo de `res/` nem o manifesto usa `windowOptOutEdgeToEdgeEnforcement`;
  - `Theme.MrKeyboard.Settings` mantém `statusBarColor` e `navigationBarColor` em `@color/mr_ui_bg`, e o `Main`
    herda dele (ou repete as cores); nenhuma das duas com outra cor;
  - toda tela do manifesto usa um tema `Theme.MrKeyboard.*`; as três janelas auxiliares seguem translúcidas;
  - `MrApplication.onCreate` chama `MrScreens.install`;
  - todo `*Test.java` de pasta `*_test` está no `run_java_tests.sh`, a menos que a pasta tenha um `README.md`
    dizendo como roda à mão (`packs_test` e `settings_test`, que precisam de rede, fixtures ou APK).
- Nove mutações desses guardas (opt-out, cada cor da barra, herança do `Main`, tema de tela, tema das auxiliares,
  `install`, teste fora do executor, teste novo sem registro) foram todas pegas; um `README.md` na pasta isenta
  como previsto.
- Bateria completa sem regressão: `check_java_smali.sh`, `verify_dex.sh`, `smali_regcheck.py`, as suítes Java,
  `check_reset_keys.py` (44 | 56), `mres_check.py`, `res_check.py`, versão, catálogo, update, workflows,
  `test_make_*` e `publish_test`.

### Etapa 7 — Teste no aparelho (checklist do usuário)
- **Android 17 (o seu):** título de Configurações sem espaço extra, parado e rolando; subtelas idem; girar a tela
  nos editores com o teclado aberto; navegação por gestos e por 3 botões.
- **Android 15 e 16** (se tiver): mesmas telas; Voltar por gesto com painel do teclado aberto.
- **Android 10–14 e 8–9** (se tiver): telas com barras na cor do tema; faixa preta do notch em paisagem é
  esperada.
- **Editores com teclado (Android 17):** no editor de estilo de IA, digitar nome e instruções e girar a tela:
  o texto fica e o teclado volta no mesmo campo, com o cursor no mesmo lugar. No campo de instruções, com o
  teclado aberto, o texto digitado fica acima do teclado. No editor de folhas, abrir o campo de teste, girar:
  o teclado volta.
- **Retorno ao Editor de IA:** abrir o diálogo, tocar na engrenagem, voltar (gesto e botão): o teclado e o
  diálogo reaparecem no mesmo campo. Repetir com o app de origem em outro app (navegador, mensagens) e depois
  esperar mais de 2 minutos nas Configurações: ao voltar o diálogo NÃO deve abrir sozinho.
- **Voltar ao app:** com o app do teclado aberto nos recentes (abra o ícone do teclado antes), digitar num outro
  app, abrir o Editor de IA, tocar na engrenagem e voltar: tem de voltar ao app em que se digitava, não à página
  principal. Repetir com Configurações, Pacotes e Folhas pelo teclado, e com o app do teclado fechado. Tocar na
  notificação de atualização e voltar.
- **Duplicação:** engrenagem do teclado 3 vezes seguidas, depois Voltar uma vez deve sair da tela; duplo toque
  rápido numa linha de Configurações abre uma subtela só. Abrir o Editor de IA e um estilo para editar, voltar ao
  app, digitar, abrir o Editor de IA e tocar na engrenagem de novo: abre as configurações uma só vez e Voltar leva
  ao app. Com um estilo em edição (texto digitado), abrir outro estilo pelo diálogo: o atual continua como está.
- **Ferramenta "Personalizar teclado" ao girar (Android 13 e 17):** abrir a ferramenta em retrato (diálogo), girar para
  paisagem: o painel abre dentro do teclado e o teclado não fecha; girar de volta: o diálogo reaparece. Com a ferramenta
  fechada, girar não abre nada. Repetir em um app que recria a tela ao girar e em um que não recria (Acode). Esconder
  o teclado (Voltar) com a ferramenta aberta, sem girar: não reabre.
- **Botões da barra com diálogo aberto:** abrir o diálogo do Editor de IA (retrato) e tocar no botão da área de
  transferência, do tradutor, de anexos, de emoji e de folhas: o diálogo fecha e o botão faz o que sempre fez. Com o
  diálogo de Personalizar aberto, o mesmo. Com o do Editor de IA aberto, tocar em Personalizar fecha o do Editor de IA e
  abre o de Personalizar; e o inverso. Tocar de novo no botão do próprio diálogo fecha ele (como antes).
- **Diálogo do Editor de IA (Android 13 e 17):** em retrato fica como antes (acima do teclado, cartão centralizado).
  Em paisagem o diálogo ocupa a tela inteira (cobre o teclado), o cartão fica abaixo do relógio e da câmera, rola
  se faltar altura, tocar fora do cartão fecha e, ao fechar, o teclado volta. Girar a tela com o diálogo aberto troca
  de modo sozinho. Também com o gesto e com a barra de 3 botões.
- **Aceleração das telas (Avançado > Telas):** com a opção desligada nada muda (padrão). Ligar: a tela Avançado
  pisca e volta com a caixa marcada; abrir Configurações e uma subtela e conferir que a rolagem segue correta e
  que nada fica sem desenhar (barra de título, ícones das categorias, listas). Desligar de novo volta ao normal.
  As telas abertas antes de alternar só mudam quando abrem de novo (esperado). Em "Restaurar padrões" a caixa
  volta a desmarcada. Os editores (folhas, estilos de IA) não mudam com a opção.
- **Flag chegou a tempo:** com a opção ligada, `adb shell dumpsys gfxinfo com.mrkeyboard.app` com Configurações
  aberta deve mostrar estatísticas de quadros da janela da tela (o `gfxinfo` só conta janelas desenhadas pelo
  renderizador por GPU, a confirmar); desligada, sem elas. Se ligada e a janela seguir em software, o flag chegou
  tarde e a Etapa 5 precisa mudar para o tema/manifesto por tela.
- **Teclado acelerado ou não:** com o teclado aberto pela primeira vez, `adb logcat -s MrAccel` mostra uma linha
  `keyboard window hardwareAccelerated=true|false (SDK n)`. Anotar o resultado nos Androids 13 e 17.
- Opcional, para medir peso: `adb shell dumpsys gfxinfo com.mrkeyboard.app framestats` com a opção ligada e
  desligada.

### Etapa 8 — Versão e notas
- v1.83.0 (`versionCode` 1083000), notas em `docs/release-notes/v1.83.0.md` (blocos Português e English, estilo
  Novo/Melhorado/Corrigido), README se a nova opção merecer menção. Apagar este plano no commit da release.

## Fora do escopo

- Subir o `targetSdk` para 37 (Google Play exige até agosto de 2027). Mudanças a tratar nesse plano futuro:
  orientação e redimensionamento deixam de poder ser travados em telas grandes (o app não trava nada hoje),
  campos `static final` ficam imutáveis, e a proteção de carga dinâmica de código passa a valer para bibliotecas
  nativas (conferir que nenhuma `.so` é carregada de fora do APK).
- Fazer a lista rolar por trás das barras do sistema (recomendação de design do Google, opcional). A lista
  continua começando abaixo do título, como hoje.

## Fontes

- Mudanças do Android 15 (edge-to-edge, cutout): https://developer.android.com/about/versions/15/behavior-changes-15
- Mudanças do Android 16 (opt-out removido, voltar preditivo): https://developer.android.com/about/versions/16/behavior-changes-16
- Mudanças do Android 17 para todos os apps (teclado após rotação): https://developer.android.com/about/versions/17/behavior-changes-all
- Mudanças do Android 17 para targetSdk 37: https://developer.android.com/about/versions/17/behavior-changes-17
- Teclado depois da rotação (o app precisa pedir de novo): https://gitlab.e.foundation/e/os/android_frameworks_base/-/commit/c929daed2d016360665dd6af710313f28961fac3
- `InputMethodService.requestShowSelf` (API 28): https://gitlab.e.foundation/e/os/android_frameworks_base/-/commit/fbc2f7acd581eca7180a3d916936fb4e758279e1
- `Intent.FLAG_ACTIVITY_REORDER_TO_FRONT` (traz à frente se já estiver na pilha; ignorado com `CLEAR_TOP`): https://developer.android.com/reference/android/content/Intent#FLAG_ACTIVITY_REORDER_TO_FRONT
- Edge-to-edge em Views: https://developer.android.com/develop/ui/views/layout/edge-to-edge
- Recortes de tela: https://developer.android.com/guide/topics/display-cutout
- Dicas de insets no Android 15: https://medium.com/androiddevelopers/insets-handling-tips-for-android-15s-edge-to-edge-enforcement-872774e8839b
- Aceleração por hardware: https://developer.android.com/develop/ui/views/graphics/hardware-accel
