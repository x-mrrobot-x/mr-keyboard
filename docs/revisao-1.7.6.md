# 1.76 — Palavra certa reaberta fica no centro da faixa

## Pedido
Teste da 1.75 no aparelho: tudo certo, menos um caso. Digitar "gato", dar espaço e apagar o espaço (palavra reaberta pela recorreção) mostrava "fato" **no meio** da faixa, como se fosse a melhor correção de uma palavra que está certa.

## Notas da release
**Português**
- Corrige a recorreção ("Tocar para corrigir palavras"): ao reabrir uma palavra que está certa, ela fica no centro da faixa, como na digitação, e as alternativas ficam nos lados ("fato | gato | gatos"). Palavra errada continua com a melhor correção no centro.

**English**
- Fixes recorrection ("Touch to correct words"): when you reopen a word that is spelled correctly, it stays in the center of the strip, as when typing, with the alternatives on the sides ("fato | gato | gatos"). A misspelled word still gets the best correction in the center.

## Causa
Efeito colateral da 1.75 (teclas vizinhas na palavra reaberta). A faixa decide o centro assim (`CandidateView`): o centro é a 2ª entrada da lista (a melhor alternativa), **exceto** quando a lista avisa que a palavra digitada é válida e tem sugestão mínima; aí o centro é a própria palavra. A digitação normal avisa isso. A recorreção (`LatinIME.showCorrections`) sempre avisava "digitada inválida" (os dois indicadores em falso). Na 1.74 isso passava despercebido: sem vizinhas, a 1ª alternativa de "gato" era algo como "gatos". Com as vizinhas da 1.75, a 1ª alternativa passou a ser "fato" (tecla vizinha, palavra muito comum) e foi para o centro de uma palavra certa.

## O que mudou
- **`LatinIME.showCorrections`** (smali): passa a perguntar ao novo `MrRecorrect.isValid(suggest, palavra)` e envia o resultado nos dois indicadores. Palavra do dicionário (como está ou em minúsculas): fica no centro e `mBestWord` continua sendo ela. Palavra que não é do dicionário: igual a antes (a melhor correção no centro).
- **`MrRecorrect.isValid`** (Java → smali): `isValidWord(palavra)` ou da versão em minúsculas; nulo, vazio ou erro devolvem `false`.
- **Teste:** 4 verificações novas no `RecorrectTest` (agora 55). Versão 1.76.0 (`versionCode` 1076000).
- **Não mudou:** as alternativas, a ordem delas e as teclas vizinhas da 1.75. "fato" continua na lista, só que num lado.

## Validação (rodado aqui)
- `check_java_smali.sh` em dia; `smali_regcheck.py` 0 problemas (fontes e smali decodificado); `run_java_tests.sh` com o jar do APK: AuthorTest (12), RecorrectTest (55), RecentTest (30), EsTest (23).
- Montagem **temporária** (não entregue): `apktool b` sem erro e `verify_dex.sh` sem erro; no bytecode do `showCorrections`, o resultado de `isValid` vai nos dois últimos argumentos de `showSuggestions`.
- **Não testado no aparelho** (a faixa e o `LatinIME` não rodam no PC).

## Testes Android necessários
1. Digitar "gato", espaço, apagar o espaço: "gato" no **centro**, "fato" e "gatos" nos lados. Tocar em "fato" troca a palavra por "fato" sem duplicar texto.
2. Digitar "obrogado" (palavra errada), espaço, apagar o espaço: "obrigado" (ou a melhor correção) no centro e a palavra errada num lado.
3. Tocar no meio de uma palavra certa já escrita: mesmo resultado do item 1.
4. Nome que o dicionário não conhece (ex.: "Fernanda"): comportamento igual ao da 1.75.
5. Digitação normal e previsão: sem mudança.
