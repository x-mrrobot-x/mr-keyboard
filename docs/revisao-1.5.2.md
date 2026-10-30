# 1.5.2 — No máximo 5 sugestões, a mais provável no centro

> **Substituída pela 1.5.3:** a faixa agora tem 3 posições fixas (veja `revisao-1.5.3.md`). O que segue descreve a versão de 5 posições e os testes `model_layout.py`/`layout_sim.py`, que foram removidos.

## Pedido
Mostrar no máximo as 5 sugestões mais acertivas, com a mais provável no meio em tom mais claro e as outras nas laterais em tom mais opaco, segundo a cor das letras do tema.

## Comportamento
- A faixa mostra as **5 primeiras entradas da lista** do motor de sugestões. A lista vem ordenada por pontuação, com a palavra digitada na posição 0; então são a palavra digitada e as 4 melhores sugestões. As outras (até 32) deixam de aparecer e a faixa não rola mais.
- **Centro:** a melhor sugestão (posição 1 da lista). Se a palavra digitada é válida e o motor recomenda autocorreção, o centro é a palavra digitada (posição 0), como já ocorria com o negrito. Com uma única entrada, ela fica no centro.
- **Laterais**, na ordem da lista (sem contar o centro): a 1ª à esquerda do centro (normalmente a palavra digitada), a 2ª à direita, a 3ª mais à esquerda, a 4ª mais à direita. Exemplo com a lista da captura de tela, em 1080 px: `testamento | testa | testá | festa | testar`, com `testá` no centro.
- **Cores:** o centro usa a cor do texto das teclas do tema, cheia (e em negrito quando é a autocorreção). As laterais usam a mesma cor com 65% de opacidade (`mColorNormal`). Divisor e realce de toque seguem a cor do tema (1.5.0).
- **Divisores:** um entre cada par de células vizinhas, nenhum antes da primeira nem depois da última.
- **Cabe ou não mostra:** as células têm a largura do texto mais 12 dp de cada lado do divisor (1.5.1). O centro fica sempre exatamente no meio da faixa, então cada lado tem metade do espaço que sobra. Um lado só recebe a próxima palavra se ela couber; se não couber, ela e as seguintes daquele lado não aparecem. Por isso "no máximo 5": com palavras longas aparecem menos (na captura de tela, as 5 cabem).
- **Dica "toque para salvar":** a palavra e a dica ficam lado a lado, o grupo centralizado, e a dica em cor cheia.
- **Toque longo na palavra digitada** (adicionar ao dicionário): continua funcionando, agora sobre a célula dela, onde quer que esteja (`CandidateView.mrOnFirst`). Antes valia para o canto esquerdo da faixa.
- **Lista de pontuação** (a faixa mostra `. , ? !` por até 1 s depois de um espaço, ver 1.5.1): segue a mesma regra de 5 posições, com a vírgula no centro.

## Implementação (`CandidateView`)
- `mrLayout()` roda no início de cada `onDraw` (e na passada sem canvas de `setSuggestions`): zera `mWordX`/`mWordWidth`, escolhe o centro (`mCenter`), calcula as posições e a última célula à direita (`mLast`) e define `mTotalWidth` como a largura da faixa (sem rolagem). Largura zero significa "não mostrada".
- `mrMeasure(i)`: largura da célula medida com a mesma fonte do `onDraw` (negrito na recomendada) mais `mGap` de cada lado (`mrWidth`, 1.5.1).
- `onDraw` continua percorrendo a lista na ordem original, então os índices entregues a `LatinIME.pickSuggestionManually` não mudam (0 = palavra digitada). O laço apenas pula entradas de largura zero e lê a posição de `mWordX[i]` em vez de acumulá-la. A cor do item no centro vem de `mColorOther` (cor cheia); as demais, de `mColorNormal`. O divisor não é desenhado depois de `mLast`.
- `CandidateStripGestureListener.onLongPress` passou a chamar `mrOnFirst(x)`.
- Para mudar a quantidade, o limite é a constante `0x5` em `mrLayout` (`Math.min(tamanho, 5)`); o resto do layout (esquerda, direita, esquerda, direita) já suporta mais ou menos posições.

## Validação
- `apktool b` (2.11.1) sem erros e APK desmontado com os métodos novos (versão 1.52.0, código 1052000).
- `docs/tools/model_layout.py`: modelo do layout com a lista da captura de tela e casos de borda (tela estreita, palavras longas, uma e duas entradas, dica de salvar, pontuação); invariantes de células contíguas, dentro da faixa e centro centralizado.
- `docs/tools/layout_sim.py`: executa o **smali** de `mrLayout`, `mrMeasure`, `mrWidth` e `mrOnFirst` num mini interpretador e compara com o modelo em 4000 casos aleatórios (largura da faixa 0 e normais, negrito, dica, 0 a 9 entradas, limite de 5). Passa. Mutando o smali de propósito (comparação de espaço ou acúmulo à direita), o teste falha, então ele pega erros de registrador e de lógica.
- Não houve execução no aparelho.

## Testes Android necessários
1. Digitar uma palavra comum (ex.: "test"): cinco entradas, a melhor no meio em cor cheia, as outras mais apagadas, divisores só entre elas.
2. Temas escuro e claro: a cor cheia e a opaca seguem a cor do texto das teclas.
3. Tocar em cada posição: insere a palavra tocada (a do centro é a melhor sugestão). Tocar na palavra digitada mantém a palavra como está.
4. Palavras longas: aparecem menos de 5, o centro continua no meio, nada fica cortado.
5. Segurar a palavra digitada (esquerda do centro): dica "toque para salvar", palavra e dica lado a lado; tocar na dica salva a palavra.
6. Campo com autocorreção ligada: a recomendada aparece em negrito no centro.
7. Parar de digitar: depois de 1 s a linha volta às ferramentas (1.5.1).
