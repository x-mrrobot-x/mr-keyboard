# 1.5.1 — Mais espaço ao redor dos divisores e espera de 1 s antes das ferramentas

## Pedido
1. Dar mais espaço entre as sugestões e os divisores (`|`).
2. Só mostrar as ferramentas depois de 1 segundo sem sugestões, para a linha não ficar alternando entre sugestões e ferramentas a cada palavra digitada.

## Espaço ao redor dos divisores
- Em `CandidateView.onDraw`, cada sugestão ocupa uma célula de largura `texto + 2 × X_GAP`, com o texto centralizado e o divisor na borda direita. `X_GAP` era uma constante de 10 px, ou seja, 10 px de cada lado do texto (cerca de 3,7 dp em uma tela de 2,7×).
- Agora o espaço de cada lado é de **12 dp**, convertido para pixels pela densidade da tela no construtor (`mGap`). Em tela de densidade 2,6 a 2,8 isso dá cerca de 31 a 34 px (antes 10 px).
- A largura da célula passa por `CandidateView.mrWidth(texto)`: `max(largura mínima de toque, texto + 2 × mGap)`. Como o desenho, o realce de toque e a detecção de toque usam a mesma largura de célula (`mWordWidth`/`mWordX`), tudo continua alinhado.
- Consequência: cabem menos sugestões na tela de uma vez; o restante continua acessível por rolagem. Para ajustar, basta trocar `0x41400000` (12,0f) no construtor de `CandidateView`.

## Espera antes das ferramentas (`MrSugg`)
- Antes: ao esvaziar a lista de sugestões (espaço, fim da palavra), a linha trocava para as ferramentas na hora e voltava para as sugestões na primeira letra da palavra seguinte. Digitando sem parar, a linha piscava a cada palavra.
- Agora, quando a lista passa de "com sugestões" para "sem sugestões" e a faixa estava visível, ela **continua visível por 1 s**. Só depois disso a linha mostra as ferramentas.
  - Durante a espera a faixa mostra o que o teclado já mostrava depois de um espaço (a lista de pontuação).
  - Chegou uma nova lista com sugestões durante a espera (próxima palavra): a espera é cancelada e a linha não muda.
  - Cada lista vazia que chega durante a espera reinicia o relógio, então o tempo é contado desde a última atividade (debounce de verdade).
  - Voltar das ferramentas para as sugestões continua imediato.
- Tecla da barra durante a espera: encerra a espera e mostra as ferramentas na hora. Depois, a próxima palavra volta às sugestões normalmente.
- Sem espera quando não há o que atrasar: linha oculta pela tecla, escolha manual de ferramentas (a palavra termina e continua nas ferramentas) ou painel aberto.
- Desligar as sugestões para o campo (`unhost`) ou destruir o teclado (`release`) cancela a espera.
- Implementação: `Handler` do looper principal e um `Runnable` único (`MrSugg$Expire`), com `postDelayed(…, 1000)`. Novos membros em `MrSugg`: `sHold`, `sHandler`, `sExpire`, `schedule()`, `cancel()`, `expire()`; `available()` considera `sHold`; `onList` e `onBarKey` foram ajustados.

## Preservado
Cores do tema (1.5.0), tecla da barra como único controle, dicionário pt-BR (1.4.9), motor de sugestões e configuração "Mostrar sugestões".

## Validação
- `apktool b` (2.11.1) sem erros; APK desmontado: `MrSugg$Expire`, `MrSugg` com `schedule/cancel/expire`, `CandidateView.mGap`/`mrWidth`, versão 1.51.0 (código 1051000).
- Modelo da máquina de estados (`docs/tools/model_sugg.py`, traduzido do smali): 27 verificações passam. Cobrem digitação contínua com pausas curtas (sem alternar), parada de mais de 1 s, tecla durante a espera, escolha manual de ferramentas, barra oculta, `unhost` durante a espera, relógio reiniciado por listas vazias repetidas e volta imediata das ferramentas para as sugestões.
- Não houve execução no aparelho.

## Testes Android necessários
1. Digitar uma frase seguida, com intervalo menor que 1 s entre as palavras: a linha fica nas sugestões o tempo todo, sem aparecer as ferramentas.
2. Parar de digitar depois de um espaço: depois de cerca de 1 s a linha mostra as ferramentas. Voltar a digitar: sugestões na hora.
3. Parar de digitar e apertar a tecla da barra antes de 1 s: as ferramentas aparecem na hora.
4. Conferir o espaço entre as palavras e os divisores em um tema escuro e em um claro; tocar e segurar uma sugestão (o realce deve cobrir a célula inteira, centralizado no texto).
5. Palavras longas: rolar a faixa na horizontal e conferir que a última sugestão não é cortada de forma estranha.
