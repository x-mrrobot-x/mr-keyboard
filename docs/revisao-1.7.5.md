# 1.75 — Motor de sugestões: palavras recentes, letra que falta e teclas vizinhas na palavra reaberta

## Pedido
Três melhorias do motor, da lista de pendências: (1) palavras recentes na previsão, (3) letra que falta na correção e (5) teclas vizinhas na palavra reaberta pela recorreção. Combinado antes de implementar: **medir no PC cada ajuste, nos três idiomas, e só deixar entrar o que ganha sem piorar a digitação normal.**

## Notas da release
**Português**
- Corrige melhor as palavras com **letra faltando** ("vda" → vida, "sepre" → sempre, "durate" → durante), nos três idiomas.
- O teclado passa a sugerir **nomes e palavras que você acabou de escrever** na mesma conversa ("Mar" → Maria na 2ª vez). Ficam só na memória e são apagados quando você troca de campo ou de app; não valem em campo de senha nem no modo anônimo.
- "Tocar para corrigir palavras": a palavra reaberta agora também corrige **tecla vizinha** ("fato" → gato).

**English**
- Better correction of words with a **missing letter** ("vda" → vida, "sepre" → sempre, "durate" → durante), in all three languages.
- The keyboard now suggests **names and words you just wrote** in the same conversation ("Mar" → Maria the second time). They stay in memory only and are cleared when you change field or app; not used in password fields or incognito mode.
- "Touch to correct words": a reopened word now also corrects **neighbor-key** typos ("fato" → gato).

## O que mudou

### 3. Letra que falta (`MrFuzzy`)
O custo de uma letra do dicionário que não foi digitada (`C_DEL`) era 60, contra 25 da troca por tecla vizinha. A troca sempre ganhava, mesmo com a palavra certa muito mais comum (o erro "agoa" dava `agia`, `água` e `lagoa` antes de `agora`). Agora `C_DEL = 40` e `C_DEL_FIRST = 30` (falta a 1ª letra; 30 é o piso do custo de mudar o tamanho, de que a faixa da busca depende). Só duas constantes e os comentários.

### 5. Teclas vizinhas na palavra reaberta (`MrRecorrect.composer`, `LatinIME.applyTypedAlternatives`)
A palavra reaberta pela recorreção (1.74) era remontada só com as letras: sem vizinhas, a lib e o `MrFuzzy` não corrigiam tecla vizinha. Agora cada letra leva as teclas ao redor dela **no teclado que está na tela** (`Keyboard.getNearestKeys`, da mais perto para a mais longe, no alcance de 1,4 tecla, no máximo 11, vetor de 12 posições como na digitação). Letra com acento usa a tecla da letra base; sem teclado de letras na tela (símbolos), erro ao ler o teclado ou caractere sem tecla: só a letra, como antes.

### 1. Palavras recentes (`MrRecent`, novo; ganchos em `MrPredict`, `MrFuzzy.afterWords` e `LatinIME`)
Lista curta, só na RAM, dos últimos 96 termos escritos no campo atual (e dos pares "palavra → próxima"):
- **Completar:** a palavra recente que começa pelo que foi digitado entra na lista com "frequência de dicionário" 200 (cai com a idade até 50), no máximo 2 por consulta. Com **1 letra** só entram nomes e termos que o dicionário não conhece (a lista de 1 letra é a de bigramas e não pode ser empurrada).
- **Previsão depois do espaço:** quem já é candidato e foi digitado há pouco ganha até +40; pares recentes ("reunião" → "amanhã") entram como candidatos com 70.
- **O que é anotado** (`LatinIME.checkAddToDictionary`, **depois** das guardas de privacidade que já existiam): palavra de 3 a 30 caracteres, só letras. Palavra do dicionário vai em minúsculas; a que o dicionário **não** conhece só entra com maiúscula ("Maria", "iPhone", "NASA"): em minúsculas ela quase sempre é erro de digitação ("obrogado") e o teclado o ofereceria de volta.
- **Quando zera:** campo ou app novo (`onStartInputView`, por pacote e id do campo); teclado fechado e reaberto no mesmo campo mantém. Frase nova (`MrPredict.list` no começo de frase) só quebra o par com a palavra anterior. Nada vai para o disco.

### Também
- **Testes de PC:** `RecentTest` (30 verificações), `RecorrectTest` (51, com o `composer` num teclado QWERTY de mentira) no `run_java_tests.sh`; os stubs de `Suggest`, `WordComposer`, `Keyboard`, `KeyboardSwitcher` e `LatinKeyboardView` ficaram funcionais para isso.
- **Ferramentas de medição** (`docs/tools/e2e/`, com `LEIA-ME.md` e `run_eval.sh`): `CorrEval`, `PrefixEval`, `OovEval`, `RecentEval`, `gen_typos_all.py`, `gen_sessions.py`.
- README (inglês e português): uma linha sobre as palavras recentes. Versão 1.75.0 (`versionCode` 1075000).

## Como foi medido (PC, classes reais do APK e a lib nativa de PC)
- **Correção:** ~14 mil erros sintéticos por idioma (tecla vizinha, troca de lugar, letra repetida, letra que falta na 1ª posição, no meio e no fim): a palavra certa aparece nas 2 posições da faixa?
- **Digitação normal** (freio): depois de 2 a 5 letras de palavras de texto de teste, a certa está entre as 3 primeiras? Não pode piorar.
- **Palavra certa fora do dicionário** (risco): com a autocorreção ligada, quantas seriam trocadas? Não pode subir.
- **Palavras recentes:** 300 sessões simuladas por idioma, em duas versões: **por assunto** (frases que repetem uma palavra rara; otimista) e **aleatórias** (sem relação; pessimista). Os textos de teste vêm embaralhados, sem conversa de verdade; a verdade está no meio.

## Resultados

### 3. Letra que falta (acerto nas 2 posições; 1.74 → 1.75)
| | pt-BR | en-US | es |
|---|---|---|---|
| **letra do meio que falta** | 66,6% → **86,7%** | 68,5% → **78,2%** | 57,6% → **80,4%** |
| falta a 1ª letra | 86,8% → 90,3% | 84,0% → 88,6% | 84,5% → 88,1% |
| falta a última letra | 87,7% → 92,3% | 90,8% → 93,9% | 80,8% → 85,3% |
| tecla vizinha | 98,7% → 98,6% | 99,5% → 99,5% | 97,6% → 97,6% |
| troca de lugar | 97,0% → 97,9% | 96,1% → 96,9% | 95,1% → 95,8% |
| letra repetida | 99,9% → 99,9% | 99,9% → 99,9% | 99,4% → 99,4% |
| **todos os tipos** (2 posições) | 86,3% → **90,5%** | 86,7% → **89,3%** | 83,6% → **88,2%** |
| todos os tipos (1ª posição) | 78,2% → 81,5% | 77,6% → 79,8% | 73,1% → 76,5% |

**Digitação normal** (palavra certa entre as 3 primeiras): igual ou melhor em todas as faixas (pt 4 letras 44,2% → 44,8%; en 4 e 5 letras 54,6% → 54,9% e 66,9% → 67,6%; es 4 letras 48,5% → 48,7%); a única queda é de 0,2 ponto (pt, 5 letras: 53,9% → 53,7%). **Palavra certa fora do dicionário** que a autocorreção trocaria: pt 42,9% → 43,0%, en 38,5% → 38,8%, es 38,4% → 39,8%. **Tempo no PC:** por tecla na digitação normal 0,27 → 0,39 ms (pt; en e es parecidos); nos erros 0,7 → 1,0 ms.

**Testado e descartado** (cada um medido nos três idiomas):
- baixar o custo da letra **a mais** (`C_INS`, 60 → 35): piora a letra que falta;
- `C_DEL` 35: +1,7 a +3,2 pontos na letra do meio (sobre o 40), mas 10 a 45% mais tempo; 30: derruba a falta da 1ª letra (pt: 90,1% → 84,5%);
- rodar a busca também quando a digitada de **3 letras** ainda é começo de palavra: +1,0 a +1,9 ponto na letra do meio, mas **−2,8 a −4,8 pontos na digitação normal** (por isso "coo" → como continua sem correção: com 3 letras que ainda começam outra palavra o motor deixa os complementos);
- custo máximo 60 com 4 letras: nenhum ganho;
- partes mínimas de 3 letras na "espaço faltando": a autocorreção em palavra desconhecida sobe (pt 43,0% → 45,5%; es 39,8% → 49,6%), porque as divisões ("dura te") barravam a autocorreção.

### 5. Teclas vizinhas na palavra reaberta (2 posições; só letras → com vizinhas, já com os custos novos)
| | pt-BR | en-US | es |
|---|---|---|---|
| **tecla vizinha** | 72,6% → **98,6%** | 66,9% → **99,5%** | 68,4% → **97,6%** |
| tecla vizinha, quando a errada é palavra válida | 0% → 91,9% | 0% → 92,9% | 0% → 87,5% |
| letra do meio que falta | 90,7% → 86,7% | 84,4% → 78,2% | 86,8% → 80,4% |
| **todos os tipos** | 88,2% → **90,5%** | 86,1% → **89,3%** | 85,7% → **88,2%** |

Com vizinhas, a lib acha mais palavras por proximidade e empurra um pouco a letra que falta (−4 a −6 pontos); o saldo é positivo em todos os idiomas, e é o mesmo comportamento da digitação.

### 1. Palavras recentes (a próxima palavra entre as 3 mostradas; sem → com recentes; "todas as palavras")
| Sessões | Momento | pt-BR | en-US | es |
|---|---|---|---|---|
| por assunto | depois do espaço | 17,5% → 18,2% | 19,2% → 19,9% | 20,3% → 21,7% |
| | 1 letra | 32,7% → 32,7% | 32,7% → 32,6% | 36,6% → 36,6% |
| | 2 letras | 29,7% → **33,9%** | 36,2% → **42,4%** | 38,6% → **48,6%** |
| | 3 letras | 43,3% → **49,8%** | 47,1% → **54,8%** | 48,8% → **58,2%** |
| aleatórias | depois do espaço | 20,8% → 20,8% | 26,8% → 26,7% | 21,0% → 21,3% |
| | 1 letra | 37,4% → 37,3% | 46,3% → 46,2% | 37,6% → 37,5% |
| | 2 letras | 34,4% → 34,5% | 47,4% → 47,7% | 40,2% → 40,3% |
| | 3 letras | 48,2% → 48,3% | 64,1% → 64,4% | 49,4% → 49,6% |

Em sessões sem relação o efeito é zero (±0,3): quando não há palavra repetida o recurso não atrapalha. Nas sessões por assunto, que exageram a repetição, o ganho aparece a partir de 2 letras. Os nomes que o dicionário não conhece passam de ~0% a 2 a 7% de acerto com 1 a 3 letras (amostra pequena).

**Testado e descartado:** oferecer qualquer palavra recente com **1 letra** (+1,3 por assunto, mas **−2,5 nas aleatórias**: só nomes e termos desconhecidos entram); "frequência" 255 (−1,1 nas aleatórias com 2 letras; 200 não perde nada); bônus de previsão 80 (−0,5 no espaço nas aleatórias); anotar palavra desconhecida em minúsculas (ganharia só ~0,05 ponto, mas devolveria erros de digitação).

## Limites
- **Textos e erros sintéticos.** Sem conversa de verdade no PC, as sessões são aproximações (acima). O efeito real das palavras recentes depende de quanto você repete nomes e assuntos.
- **Palavra errada com 3 letras que ainda começa outra palavra** ("coo", "dis") não é procurada (ver o descartado acima), e algumas letras faltando continuam na 3ª ou 4ª posição ("tods" → todas).
- **Palavra errada que é outra palavra válida** continua fora da correção (letra do meio que falta: 3%; falta a 1ª letra: 8 a 22%). Só quando o dicionário não conhece a digitada o motor procura.
- **Palavra reaberta:** a distância real do dedo não existe (usa o centro da tecla). No aparelho as vizinhas vêm do teclado em uso; os testes de PC usam um QWERTY de mentira, então o formato exato dos vizinhos só se confirma no celular.
- **Tempo:** +40% por tecla no PC (0,27 → 0,39 ms); no celular fica algumas vezes maior, mas segue em milissegundos.
- **Palavra recente ≠ aprendizado:** não grava nada; o aprendizado de pares e palavras (disco, a partir de 2 usos) continua o mesmo.

## Validação (rodado aqui)
- `check_java_smali.sh`: "smali da camada Java em dia"; `smali_regcheck.py`: 0 problemas; `res_check.py`, `mres_check.py`, `check_reset_keys.py`, `check_version.py`, `check_catalog_url.py`, `test_make_catalog.py` e `publish_test/run.sh` passam.
- Montagem **temporária** só para medir e verificar (não entregue): `apktool b` sem erro e `verify_dex.sh` sem erro de verificação; o bytecode do `checkAddToDictionary` mostra a anotação depois do `learnable`, só quando a palavra pode ser aprendida (a 1ª posição do gancho no smali estava errada e foi pega lendo o bytecode).
- `run_java_tests.sh` com o jar do APK: AuthorTest (12), RecorrectTest (51), RecentTest (30) e EsTest (23). Defeitos plantados em `MrRecent` (5) e em `MrRecorrect` (4, na 1.74) são pegos pelos testes.
- Ponta a ponta no PC: `E2ETest` (pt), `E2EEn`, `E2EEs`: TUDO OK. `PacksTest` (63) e `ThreeLangTest` (23) com o catálogo da release única: TUDO OK.
- `docs/tools/e2e/run_eval.sh` rodado de ponta a ponta (monta o jar, gera os erros e as sessões e mede nos três idiomas).
- **Não testado no aparelho.**

## Testes Android necessários
1. **Letra que falta:** digitar "vda", "sepre", "durate", "prte", "agoa" e ver vida / sempre / durante / parte / agora entre as sugestões. Digitar normalmente uma frase longa: as sugestões de completar continuam aparecendo como antes e o teclado não ficou mais lento.
2. **Palavras recentes:** escrever "Fernanda" (nome que o dicionário não conhece) numa mensagem e, depois, digitar "Fe" ou "Fer": "Fernanda" aparece. Escrever "reunião de amanhã", depois "reunião de" e ver "amanhã".
3. **Privacidade:** trocar de app ou de campo: o nome **não** é mais oferecido. Em campo de senha e no modo anônimo nada é oferecido nem anotado. Fechar e reabrir o teclado no mesmo campo: mantém.
4. **Erro de digitação não volta:** digitar uma palavra errada em minúsculas, dar espaço e depois digitar as primeiras letras dela: o erro **não** deve ser oferecido.
5. **Recorreção com vizinhas:** digitar "fato" querendo gato, apagar o espaço (ou tocar na palavra) e ver "gato" entre as sugestões; também "vanto" → canto/santo etc. Conferir com o teclado de letras na tela e com o de símbolos (nesse, só as letras valem).
6. A recorreção da 1.74 continua igual (tocar na palavra, trocar pela sugestão, sem duplicar texto).
7. Autocorreção (se usar): erros comuns continuam sendo trocados e palavras certas não são trocadas.
