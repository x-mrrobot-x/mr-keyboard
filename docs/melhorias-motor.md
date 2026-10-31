# Motor de sugestões e dicionários: melhorias que restam

Atualizado depois da 1.77.2. Os números vêm das medições no PC (`docs/tools/e2e/`, veja o `LEIA-ME.md` de lá) e das notas de cada versão (`docs/revisao-*.md`).

## Já feito
| Item | O que era | Versão |
|---|---|---|
| 1 | Palavras recentes na previsão e ao completar (`MrRecent`) | 1.75 |
| 3 | Letra que falta na correção (`C_DEL` 60 → 40; letra do meio, 2 posições: pt 67 → 87%, en 69 → 78%, es 58 → 80%) | 1.75 |
| 5 | Teclas vizinhas na palavra reaberta pela recorreção | 1.75 (e o ajuste do centro da faixa na 1.76) |
| 9a | Motor nativo, etapa 1: a busca de correção e os trigramas em C++ (`libmrengine.so`, repositório `mr-engine`), mesmos arquivos, resultado idêntico ao do Java, com o Java de reserva | 1.77 (código) e 1.77.1 (lib no APK); ganhos medidos no PC, funcionamento validado no aparelho (velocidade e memória no aparelho não foram medidas) |

## O que resta, da mais barata para a mais cara

### Pequenas, medíveis no PC
**2. Suavização da previsão.**
- Hoje a palavra certa aparece entre as 3 sugestões depois do espaço em cerca de 18 a 27% das vezes.
- O arquivo de duas palavras usa um bônus fixo (`TRIGRAM_BONUS`); há espaço para um cálculo melhor entre duas palavras, uma palavra e frequência.
- Falta um avaliador de previsão sem sessões (o `RecentEval` mede só o efeito das palavras recentes).

**4. Gíria e abreviação no `rules.txt`.**
- Tamanhos hoje: pt-BR ~5 KB, en-US ~7 KB, es ~4 KB.
- Falta conferir o que já está coberto ("vc", "tbm", "blz", "pq", erros comuns de digitação).
- É barato, mas sem texto de conversa real não dá para medir o ganho.

**8. Teste de precisão no CI.**
- Guardar uma amostra pequena e fixa de frases e falhar o CI quando o acerto da correção, da digitação normal ou da previsão cair.
- Aproveitar para levar o `PacksTest` (63 verificações) e o `ThreeLangTest` (23) para o CI; hoje só rodam à mão. Precisam da lib nativa de PC, que o `mr-native.yml` já compila.

### Médias
**6. Posição do dedo.**
- O app só recebe a ordem das teclas vizinhas, não a distância (limite anotado na 1.66).
- Dá para simular no PC antes (`TouchEval`), mas exige mexer no `LatinIME` e no `PointerTracker`, em smali.

**7. Esquecer pelo tempo e gerenciar o que foi aprendido.**
- Hoje o banco guarda 10 mil pares e apaga 1.000 de uma vez quando enche.
- Exigiria mudar o banco e, talvez, uma tela para ver e apagar palavras aprendidas.

### Grandes
**9b. Motor nativo, etapa 2: formato novo de dicionário.**
- A etapa 1 (1.77) já tirou os trigramas do heap Java (7 a 9 MB → ~0 no heap; 3 a 4,4 MB fora dele) e deixou a busca de correção em C++, **sem mudar os arquivos**.
- Falta o que só um formato novo resolve: remover o limite de 4 MB (22 bits de endereço) do `.dict` e guardar mais dados por palavra.
- Só compensa para dados novos (por exemplo, Leipzig News 2023): mais pares sozinhos rendem pouco (480 mil em vez de 400 mil deu só +0,2 a +0,4 ponto, na 1.6.4). Exigiria regenerar os três pacotes e mudar o app e o motor juntos.

**10. Dados mais próximos de conversa de celular.**
- Os dicionários vêm de notícias e do Tatoeba.
- O limite é achar um corpus de conversa com licença livre.

## Lacunas que as medições mostraram
- **Palavra errada que é outra palavra válida** não é corrigida. Letra do meio que falta: 3%; falta a 1ª letra: 8 a 22% (dependendo do idioma).
- **Erro de 3 letras que ainda começa outra palavra** ("coo", "dis") fica sem correção. Rodar a busca nesse caso corrigia mais, mas piorava a digitação normal em 2,8 a 4,8 pontos; foi descartado na 1.75.
- **Algumas letras faltando** ficam na 3ª ou 4ª posição ("tods" → todas).
- **Idioma misto** (português e inglês na mesma frase, com os dois dicionários baixados): ainda não conferi no código como o teclado se comporta.

## Ordem sugerida
1. **Teste de precisão no CI (8)**, para proteger o que já foi ganho.
2. **Suavização da previsão (2)**, medida no PC antes de entrar no app.
3. **Gíria e abreviação (4)**, depois de conferir o que o `rules.txt` já cobre.
4. **Posição do dedo (6)** e **esquecer pelo tempo (7)**, se o teste no aparelho mostrar falta.
5. **Formato novo de dicionário (9b)** e **dados de conversa (10)** só se o limite do formato ou a falta de dados virarem problema.
