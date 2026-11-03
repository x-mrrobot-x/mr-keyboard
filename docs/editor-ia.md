# Editor de IA

## Abertura pela barra de ferramentas

O botão `b_aied` da barra principal continua sendo o único ponto de abertura. O seu código (`0x18`) chama `MrAiDialog.toggle()` em vez de selecionar um painel do teclado.

`MrAiDialog` cria um `Dialog` preso ao token da janela do IME (`TYPE_APPLICATION_ATTACHED_DIALOG`), usando o mesmo padrão do diálogo Preferências do `MrTune`: a janela cobre a área acima do teclado, o teclado permanece visível e o diálogo acompanha as mudanças de tamanho/orientação. O layout próprio está em `res/layout/mr_ai_dialog.xml`.

Foram retirados do fluxo do Editor de IA o painel `bar_ai`/`p_ai`, a integração com `MrTools.showPanel(5)`, a consulta `barVisible()`, o ajuste de altura do painel interno ao teclado e a montagem do painel durante `MrTools.wrap`. O botão da barra não expande mais conteúdo dentro do teclado.

O cartão do diálogo usa a altura do conteúdo atual e fica centralizado na área acima do teclado; se o conteúdo não couber, ele pode rolar. Os chips medem o próprio conteúdo e a faixa horizontal permite acessar todos, inclusive rótulos longos. O cabeçalho e os botões de ícone são compactos, com os glifos centralizados, e Emojificar tem um checkbox arredondado que indica o estado. Criar usa um ícone vetorial de adicionar. Os diálogos não editáveis usam `FLAG_NOT_FOCUSABLE` para preservar o foco do campo enquanto aparecem acima do teclado, conforme o guia de visibilidade do IME do Android. Ao ocultar o teclado, `LatinIME.onWindowHidden()` fecha tanto o Editor de IA quanto o diálogo de Preferências do `MrTune`. Abrir configurações ou o editor de estilos fecha o Editor de IA e marca uma reabertura pendente; ao voltar ao editor original, `onWindowShown()` reabre o diálogo. Ao aplicar o resultado, ele fecha.

## Tema

O diálogo usa exclusivamente `Theme.MrKeyboard.Dialog` e a paleta das configurações (`mr_ui_*`, mais `mr_ai_scrim` no fundo); as cores são lidas direto dos recursos, sem valores de reserva no código. Chips, resultado e botões não consultam `MrTheme` nem as cores do teclado (`MrTools.shotTab`, `fieldBg`, `flatBar` etc.), portanto trocar o tema do teclado não altera as cores do Editor de IA. O restante do teclado continua com suporte aos seus temas normalmente.

## Estrutura

- `docs/tools/java/src/com/mrkeyboard/app/MrAi.java`: captura e valida o texto, monta a interface do diálogo, chama o provedor, atualiza o resultado e aplica/copia o texto. A rede só é usada depois que a pessoa escolhe um estilo.
- `docs/tools/java/src/com/mrkeyboard/app/MrAiDialog.java`: ciclo de vida do diálogo anexado à janela do IME e redimensionamento acima do teclado.
- `MrAiPrefs`: configurações do provedor, modelo, chave e estilos; `MrAiStyleActivity`: criação/edição dos estilos.
- `res/xml/prefs_ai.xml`: configurações; `res/layout/mr_ai_dialog.xml`: interface modal; `MrNotice.aiEditor`: aviso exibido na primeira abertura.
- `MrTools.smali` mantém os ganchos manuais da barra (botão `b_aied`), chama o diálogo pelo código `0x18` e encerra a ferramenta ao liberar o teclado.

## Rede e privacidade

O pedido usa o endpoint compatível com Chat Completions configurado em *Configurações → Editor de IA*. A chave vai somente no cabeçalho `Authorization` daquele pedido. Em campos de senha, o texto não é capturado nem enviado. O texto selecionado — ou o trecho antes do cursor — é substituído somente se ainda corresponder ao original; caso contrário, é possível copiar o resultado.

O manifest não habilita tráfego HTTP sem TLS. Use um endpoint `https://`; o texto do diálogo do endereço (`mr_ai_endpoint_dlg`, em inglês, português e espanhol) informa esse requisito.

Só endereços `https://` são aceitos, e a chave é sempre exigida. A chave não fica nas preferências padrão: o valor vai para o arquivo `mr_ai` (`MrAi.apiKey`/`setApiKey`), que não consta em `backup_rules.xml` nem em `data_extraction_rules.xml`, então não sai por backup na nuvem nem por transferência de aparelho. A linha `pref_ai_key` é não persistente e *Restaurar padrões* apaga o valor.

## Geração e verificações

As classes `MrAi` e `MrAiDialog` têm fonte em `docs/tools/java/src` e smali gerado em `smali/com/mrkeyboard/app/` pelo `docs/tools/build_java.sh`. `MrTools.smali` continua sendo editado à mão. O build Java usa os stubs de `docs/tools/java/stubs` apenas para compilar testes/geração; eles não entram no APK.
