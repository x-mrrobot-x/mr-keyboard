# Medições do motor de sugestões no PC (1.75)

Roda as classes reais do APK (classes.dex → jar com o dex2jar) e a lib nativa compilada para o PC a partir do
mesmo `dictionary.cpp`. Só o `LatinIME` (que precisa do Android) fica de fora. Serve para decidir mudanças no motor
**antes** de mexer no app: cada ajuste é medido em três idiomas e só entra se ganhar sem piorar o resto.

`bash docs/tools/e2e/run_eval.sh` roda tudo (veja o cabeçalho do script para as variáveis). O que cada classe mede:

| Classe | O que mede |
|---|---|
| `CorrEval` (`gen_typos_all.py`) | erros sintéticos (tecla vizinha, troca de lugar, letra que falta no começo, no meio e no fim, letra repetida): a palavra certa aparece na 1ª posição? nas 2 posições? Separa os casos em que a palavra errada é uma palavra válida. `--noprox` monta a palavra só com as letras (a recorreção até a 1.74). |
| `PrefixEval` | digitação **sem erro**: depois de 2 a 5 letras de uma palavra do texto, ela está entre as 3 primeiras? É o freio de qualquer mudança na correção: não pode piorar. |
| `OovEval` | palavras certas que o dicionário não conhece (nomes, gírias): com a autocorreção ligada, quantas seriam trocadas? É o risco de uma correção mais agressiva. |
| `RecentEval` (`gen_sessions.py`) | palavras recentes: a próxima palavra está entre as 3 mostradas depois do espaço e depois de 1 a 3 letras, em sessões simuladas, com e sem `MrRecent` (`-Drecent=0`). |
| `E2ETest`, `E2EEn`, `E2EEs` | verificações de ponta a ponta com expectativas fixas (TUDO OK ou FALHA). |
| `Parity`, `TouchEval`, `TypoEval` | comparação de duas versões lista a lista, toques imprecisos e erros sintéticos (1.64 a 1.66). |
| `NativeParity` | motor nativo (1.77): a busca do `MrFuzzy` e a lista final de `Suggest` pelo Java e pela `libmrengine.so`, palavra por palavra, pontuação, custo e nós visitados; trigramas pelos dois caminhos; tempo dos dois. Sai com 1 se houver qualquer diferença. Roda no CI via `run_native_parity.sh`. |

### Motor nativo (1.77)
`bash docs/tools/e2e/run_native_parity.sh [jar_do_app.jar]` compila as libs de PC (`engine/` e `native/`), gera as consultas do próprio
`dicts/` (`engine/tools/gen_parity_queries.py`) e roda o `NativeParity` nos 3 idiomas; é o mesmo que o *Mr Keyboard - checks* roda.
Qualquer outra classe desta pasta (`CorrEval`, `PrefixEval`…) também usa a lib quando ela está no `java.library.path` (o `run_eval.sh`
já põe as duas); `JAVA_OPTS=-Dmr.native=off` força o Java. Nas medições comparativas rode as duas vezes.

## Limites da medição
- Os textos de teste (Leipzig, Tatoeba) vêm **embaralhados**, sem conversa de verdade. `gen_sessions.py` fabrica duas
  aproximações: sessões **por assunto** (frases que repetem uma palavra rara: otimista, o assunto repete mais do que numa
  conversa) e **aleatórias** (frases sem relação: pessimista, as palavras recentes só podem atrapalhar). A verdade está no meio.
- Os erros são sintéticos e uniformes por tipo; erro de digitação real tem outra distribuição.
- Tempos são do PC (JIT aquecido); no celular ficam algumas vezes maiores.

## Ajustar um valor sem recompilar o app
Copie o `.java` para uma pasta temporária, troque `static final int NOME = N;` por
`static int NOME = Integer.getInteger("NOME", N);`, compile contra o jar e ponha a pasta na frente do classpath;
`-DNOME=valor` muda o número sem recompilar. Foi assim que `C_DEL`, `COMP_V` e os outros foram escolhidos.
