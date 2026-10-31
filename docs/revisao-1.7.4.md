# 1.74 — "Tocar para corrigir palavras" volta a funcionar (e vem ligada)

## Pedido
Com a opção *Tocar para corrigir palavras* ligada, nada acontecia em dois casos: (1) digitar uma palavra, dar espaço e apagar o espaço; (2) tocar em cima de uma palavra errada já digitada. Em nenhum dos dois apareciam as sugestões da palavra. Além disso, ao ligar a opção surgia um aviso cortado ("Obs.: a recorreção não funciona corretamente em …"). Pedidos extras: se o método usado for antigo, conferir a documentação e recomendar os atuais por versão do Android (aplicado abaixo); deixar a opção ligada por padrão.

## Notas da release
**Português**
- Corrige "Tocar para corrigir palavras": ao tocar numa palavra, ou ao apagar o espaço depois dela, as sugestões dela aparecem (inclusive de palavra errada) e tocar numa sugestão troca a palavra.
- A opção agora vem ligada por padrão (dá para desligar em *Sugestões e dicionários*).
- Tira o aviso cortado que aparecia ao ligar essa opção.

**English**
- Fixes "Touch to correct words": tapping a word, or deleting the space after it, now shows its suggestions (even for a misspelled word) and tapping a suggestion replaces the word.
- The option is now on by default (you can turn it off in *Suggestions and dictionaries*).
- Removes the truncated notice that appeared when turning that option on.

## Causa
O `LatinIME` herdou do Hacker's Keyboard toda a lógica de recorreção: `onUpdateSelection` percebe que o cursor passou a encostar numa palavra (o que acontece ao apagar o espaço ou ao tocar nela), espera 300 ms (`postUpdateOldSuggestions`) e chama `setOldSuggestions()`. **Esse último método tinha ficado esvaziado neste fork**: ele lia a palavra sob o cursor (`EditingUtil.getWordAtCursorOrSelection`), **descartava o resultado** e só limpava as sugestões e mostrava a pontuação. Por isso nada aparecia, com a opção ligada ou não. `applyTypedAlternatives`, `showCorrections`, `TypedWordAlternatives`, `EditingUtil.underlineWord` e o ramo "corrigindo" do `pickSuggestionManually` continuavam intactos, sem ninguém chamá-los.

## O que mudou
- **`setOldSuggestions()`** (smali): corpo restaurado. Sem composição em andamento, acha a palavra tocada, mostra as sugestões (`applyTypedAlternatives` → `showCorrections`) e marca a palavra como composição (`setComposingRegion`) para o toque numa sugestão trocá-la. **Diferença do original:** o resultado de `setComposingRegion` agora é conferido; se vier `false` (conexão inválida ou editor sem suporte ao método), a correção é desfeita (`abortCorrection`) em vez de mostrar sugestões que, ao tocar, não trocariam a palavra e a duplicariam.
- **Achar a palavra por versão do Android** (`MrRecorrect.wordAt`, Java → smali, novo):
  - **Android 12 (API 31) em diante:** `InputConnection.getSurroundingText` devolve, numa chamada só, o texto em volta do cursor (até 1.000 caracteres de cada lado), a seleção e o deslocamento desse trecho no editor. A posição da palavra sai do mesmo retrato do texto. O caminho antigo lia o texto em duas chamadas, pegava o campo **inteiro** com `getExtractedText` só para conferir o cursor e calculava o início da palavra a partir da **última seleção guardada**, que pode estar velha 300 ms depois (`setComposingRegion` num lugar errado = trocar o trecho errado).
  - **Android 8 a 11 (API 26 a 30), ou editor que não devolve o retrato** (`null`, erro, dados incoerentes): o `EditingUtil.getWordAtCursorOrSelection` de sempre. O código novo fica numa classe interna (`MrRecorrect$Api31`) que o Android 8 a 11 nunca carrega.
- **`applyTypedAlternatives`** (smali): antes só reabria palavra que o dicionário conhecia ou que fora digitada na sessão; a palavra errada fora disso (o caso principal) ficava de fora. Agora qualquer palavra tocada gera sugestões (a busca aproximada `MrFuzzy` cuida dos erros). Sem os toques originais só há os caracteres, então a correção por "tecla vizinha" é mais fraca que durante a digitação; troca de lugar, letra a mais ou a menos, fonética e o mapa `MrFix` funcionam igual.
- **`MrRecorrect.eligible`**: só palavras de 2 a 48 caracteres, com letra e sem dígito (`4g`, `abc123`, `2024` ficam sem sugestões).
- **Ligada por padrão:** `default_recorrection_enabled` passou para `true`. Vale para quem **nunca mexeu** na opção (instalação nova, "Restaurar padrões" ou atualização de quem nunca a tocou); quem já a ligou ou desligou de propósito mantém a escolha.
- **Aviso removido:** o `Toast` com `recorrect_warning` (era sobre aparelho anterior ao Gingerbread; o app exige o Android 8) saiu do `onSharedPreferenceChanged`, e a string foi apagada de `values`, `values-pt-rBR`, `values-es` e do `public.xml`.
- **Defeito achado no caminho e corrigido (`MrPacks`):** o stub de compilação tinha `Build.VERSION.SDK_INT` como constante (`= 0`), e o `javac` embute constantes. Resultado: o `if (SDK_INT >= 28)` de `MrPacks.certs()` (que escolhe `GET_SIGNING_CERTIFICATES` no Android 9+) **nunca existiu no código gerado**; o app usava sempre o caminho antigo `GET_SIGNATURES`. Com o stub corrigido (campo não-final) o `MrRecorrect` também precisava dele, e o `MrPacks.smali` foi regenerado: agora o Android 9+ usa a API recomendada (`SigningInfo.getApkContentsSigners`), que para um app de uma chave só devolve o mesmo certificado. É o único efeito fora da recorreção; está no roteiro de testes.
- **Stubs de compilação:** `SurroundingText`, `EditingUtil`/`SelectedWord` e `InputConnection.getSurroundingText` (método `default`, para os testes que já implementam o stub continuarem compilando). Não entram no dex.
- **Testes:** `docs/tools/recorrect_test/RecorrectTest.java` (38 verificações) no `run_java_tests.sh`. Versão 1.74.0 (`versionCode` 1074000).

## Documentação do Android: o método é antigo?
Conferi a documentação oficial e o histórico de APIs (api-diff). **Nenhum método usado aqui está obsoleto**, e a abordagem (`onUpdateSelection` + ler o texto em volta + `setComposingRegion` + `commitText`) continua válida do Android 8 (minSdk 26) ao 16 (targetSdk 36). O defeito era o método esvaziado, não uma API velha. O que há de mais novo, por versão:

| Android (API) | O que existe | Decisão |
|---|---|---|
| 26 a 30 | `getTextBeforeCursor`/`getTextAfterCursor` + `setComposingRegion` + `commitText` | Mantido (único caminho que cobre todo o intervalo). |
| 31+ | `InputConnection.getSurroundingText(antes, depois, flags)` (texto em volta + seleção + deslocamento, numa chamada) | **Aplicado**, com o caminho antigo de reserva. |
| 34+ | `InputConnection.replaceText(início, fim, texto, cursor, TextAttribute)`: equivale a `finishComposingText`, `setSelection(início, fim)` e `commitText` | Não compensa: o `setComposingRegion` + `commitText` atual dá o mesmo resultado em todas as versões. |

Pontos de documentação que pesaram:
- `onUpdateSelection` é chamado quando o app informa uma nova seleção, peça o teclado ou não o texto extraído; segue sendo o gancho certo e não há mudança entre as versões.
- Desde o Android 7 (N) o sistema tolera editores que implementam `InputConnection` direto e **não** implementam `getSelectedText` e `setComposingRegion`; nesses a chamada não surte efeito, em vez de quebrar o app (e o retorno não indica sucesso). É por isso que o resultado de `setComposingRegion` agora é conferido, e por isso o teste 5 abaixo olha editores diferentes.
- `SurroundingText` documenta o deslocamento como "-1 se desconhecido" e a seleção pode vir invertida; os dois casos estão tratados (e testados).

## Validação (rodado aqui)
- `build_java.sh` gerou `MrRecorrect.smali`, `MrRecorrect$Api31.smali` e o `MrPacks.smali` novo; `check_java_smali.sh` passa; `smali_regcheck.py`: 0 problemas (nos fontes e no smali decodificado do APK montado); `res_check.py` (920 recursos, nenhum sem uso), `mres_check.py`, `check_reset_keys.py`, `check_version.py` e `check_catalog_url.py` passam.
- **Montagem temporária** só para verificar (não entregue): `apktool b` sem erro e `verify_dex.sh` sem nenhum erro de verificação. No jar gerado o `MrRecorrect.wordAt` e o `MrPacks.certs` leem `Build.VERSION.SDK_INT` de verdade (`getstatic`, comparação com 31 e 28) e o bytecode do `setOldSuggestions` segue o fluxo desenhado.
- `RecorrectTest` (38 verificações) com um **editor de mentira**: cursor no fim, meio e começo da palavra; depois do espaço; começo e fim do texto; campo vazio; acentos e pontuação; seleção guardada velha (o deslocamento do editor manda); deslocamento desconhecido; texto de 3 mil caracteres (a janela de 1.000 não atrapalha as posições); seleção de palavra inteira, parcial, de duas palavras e invertida; reserva quando o editor devolve `null`, lança erro ou devolve dados incoerentes; API 26, 28 e 30 nem pedem o retrato; API 31 já usa. Testado também **ao contrário**: quatro defeitos plantados no código (ignorar o deslocamento, usar o retrato já na API 30, não cair na reserva com `null`, aceitar separador dentro da seleção) foram pegos pelo teste.
- `run_java_tests.sh` com o jar do APK: AuthorTest (12), RecorrectTest (38) e EsTest (23) passam.
- **Não testado no aparelho**: o `LatinIME` não roda no PC, então o fluxo todo (tocar na palavra, apagar o espaço, trocar pela sugestão) só se confirma no celular. O `PacksTest` completo (que precisa da lib de PC e do jar) não foi rodado; ele não passa por `certs()` (usa certificado de teste).

## Testes Android necessários
1. Instalar sobre a versão anterior: em *Sugestões e dicionários*, a opção *Tocar para corrigir palavras* aparece ligada (se você já tinha escolhido, vale a sua escolha); ligar e desligar não mostra mais o aviso cortado.
2. Digitar "obrogado", dar espaço e **apagar o espaço**: a palavra fica sublinhada, as sugestões dela aparecem (obrigado) e tocar numa sugestão troca a palavra sem duplicar nada.
3. Escrever uma frase com uma palavra errada e **tocar no meio dela**: mesmo resultado.
4. Tocar numa palavra de texto que já estava no campo (colado ou de outra sessão): também aparecem sugestões.
5. Repetir em apps diferentes (mensagens, notas, campo de página da web). Se algum editor não aceitar a marcação da palavra, não deve aparecer nada e **nunca** texto duplicado ou perdido. Em campo de texto grande (uma nota longa) tocar numa palavra no fim do texto: a palavra certa é a sublinhada.
6. Tocar em "4g", "abc123" ou um número: nenhuma sugestão.
7. Depois de trocar por uma sugestão, o cursor volta a funcionar normal e o texto fica certo.
8. Digitação normal (sugestões, autocorreção, previsão) continua igual; com a opção desligada nada da recorreção acontece.
9. **Dicionários (por causa do `MrPacks`):** *Procurar atualizações* e baixar/atualizar um idioma continuam funcionando. Se aparecer erro de assinatura do catálogo, é o `MrPacks.certs()` no Android 9+; me avise com o modelo do aparelho e a versão do Android.
