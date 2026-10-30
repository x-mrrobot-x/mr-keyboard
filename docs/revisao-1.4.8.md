# 1.4.8 — Sugestões de palavras na linha da barra de ferramentas

## Situação encontrada
- O motor de sugestões do Hacker's Keyboard está completo: `Suggest`, `CandidateView`, aprendizado de palavras (`AutoDictionary`), bigramas e dicionário do usuário do Android. A opção "Mostrar sugestões" (`show_suggestions`) vem desligada por padrão (`default_suggestions=false`).
- Ligada, a faixa ia para a área de candidatos do `InputMethodService`, uma linha separada acima da barra de ferramentas.
- O app não traz dicionário principal: `res/xml/dictionary.xml` pede `raw/main`, que não existe (`res/raw` só tem `sheets_default.json`). O `Suggest` então só usa dicionários de outros apps (pacotes do Hacker's Keyboard, ação `org.pocketworkstation.DICT`, ou do AnySoftKeyboard do tipo `binary`), palavras aprendidas e o dicionário do usuário. Sem um desses pacotes instalado, a faixa mostra basicamente a palavra digitada. Esse é o motivo mais provável de a função parecer não implementada.

## Alternância escolhida (mesma linha de 44dp)
Modelo do Gboard: as ferramentas são o padrão, e as sugestões tomam a linha enquanto há uma palavra em andamento.

| Situação | Linha mostra |
|---|---|
| Painel aberto (tradução, clipboard, anexos, emotes, personalizar) | nada (como antes) |
| Sugestões ligadas, há sugestões, ferramentas não fixadas | sugestões, com botão de ferramentas (ícone da tecla da barra) à esquerda |
| Barra de ferramentas ligada (sem palavra em andamento ou ferramentas fixadas) | ferramentas; com ferramentas fixadas e sugestões pendentes, botão ‹ no início para voltar às sugestões |
| Barra desligada, sugestões ligadas | sugestões (faixa fica mesmo vazia; sem botão de ferramentas) |
| Barra e sugestões desligadas | nada (como antes) |

- "Há sugestões" = a última lista enviada ao `CandidateView` não é nula, nem vazia, nem a lista de pontuação (`mSuggestPuncList`, mostrada depois de terminar a palavra). A dica "toque para salvar" também conta.
- Fixar ferramentas vale até a palavra terminar. Quando a lista volta a ficar vazia ou de pontuação, a fixação é desfeita, e a próxima palavra volta a mostrar sugestões sozinha.
- A altura do teclado não muda ao alternar: os dois grupos ocupam a mesma linha.

## Alteração
- `res/layout/mr_toolbar.xml`: `bar_main` passou a ter dois grupos com peso 1. `bar_tools` tem o novo `b_sugg` (oculto) e os seis botões atuais, sem mudança. `bar_sugg` (oculto) tem `sg_tools` e `sg_host`. Todas as buscas por tag usam `findViewWithTag`, que é recursivo.
- Nova classe `MrSugg` com o estado (`sHas`, `sPinned`), a hospedagem da faixa no `sg_host`, a regra de modo e os cliques dos dois botões.
- `MrTools.applyMain`: decide entre escondida, ferramentas ou sugestões via `MrSugg.mode`. Passa a considerar também o painel "Personalizar" (`MrTune.sBar`) como painel aberto. `wrap` chama `MrSugg.setup` (a faixa é movida para cada nova raiz da barra) e `release` chama `MrSugg.release`.
- `LatinIME.onCreateCandidatesView`: a faixa é entregue ao `MrSugg.host`, e o método devolve `null` ao framework. Assim o `InputMethodService` não chama `setCandidatesView` com uma view que já tem pai, e a área de candidatos do sistema fica vazia (altura 0). As chamadas internas não usam o retorno.
- `LatinIME.removeCandidateViewContainer` chama `MrSugg.unhost`, e `setSuggestions` chama `MrSugg.onList`. Depois de `showAddToDictionaryHint`, chama `MrSugg.onList(true)`.
- Fundo da faixa transparente na barra; cores e toque do `CandidateView` inalterados.
- Versão: 1.48.0 (código 1048000).

## Preservado
Motor de sugestões, autocorreção, aprendizado, configurações, painéis da barra, tecla de mostrar/ocultar barra, `ImeInsets` (1.4.7).

## Validação
- `apktool b` (2.11.1) sem erros; APK desmontado: `MrSugg` (12 métodos), as 8 chamadas novas e o layout conferidos.
- Revisão estática: todas as referências existem; métodos chamados de outras classes são públicos ou de pacote; registradores revisados.
- Não houve execução no aparelho nem teste do verificador do ART.

## Testes Android necessários
1. Ligar "Mostrar sugestões". Campo vazio → ferramentas. Digitar → sugestões. Espaço/pontuação → ferramentas.
2. Durante a palavra: botão de ferramentas → ferramentas com ‹; ‹ → sugestões; terminar a palavra → próxima palavra volta às sugestões.
3. Tocar numa sugestão; tocar na palavra digitada ("toque para salvar") e tocar de novo.
4. Abrir/fechar clipboard, tradução (digitar no campo de tradução), anexos, emotes, personalizar: a linha some e volta corretamente.
5. Tecla de ocultar barra com sugestões ligadas (só a faixa) e desligadas (nada).
6. Trocar de teclado, girar a tela, mudar tema/altura com o teclado aberto: a faixa continua na barra.
7. Campos de senha/número (sugestões desligadas pelo tipo de campo): só ferramentas.

## Pendente
- Dicionário principal pt-BR embutido: sem ele as sugestões são fracas. Exige um dicionário no formato binário que a `libjni_pckeyboard.so` lê (formato antigo do LatinIME); a fonte e o formato precisam ser confirmados antes de embutir.
- Cores da faixa (branco e âmbar) podem ser alinhadas ao tema do teclado.
