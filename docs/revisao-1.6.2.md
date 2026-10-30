# 1.6.2 — Previsão com duas palavras, correção reservada, começo de frase, aprendizado rápido e autocorreção cuidadosa

## Pedido
Melhorias rápidas e médias listadas depois da 1.6.1, feitas em Java/smali (sem mexer na lib nativa).

## O que mudou
| Item | 1.6.1 | 1.6.2 |
|---|---|---|
| Previsão depois do espaço | olha só a última palavra | olha as **duas** últimas quando o contexto existe ("eu não" → quero, sei, tenho; antes: se, é, tem) |
| 1ª letra da palavra seguinte | só pares | também as continuações das duas palavras ("bom dia" + p → para, pode) |
| Correção que forma o começo de outra palavra | sumia atrás dos complementos ("prota" mostrava protagonista) | uma correção barata (troca de lugar, letra dobrada, h, fonética, vizinha) sempre fica numa das 3 posições ("prota" → porta na direita) |
| Começo do texto e depois de . ! ? | pontuação | "Você", **"Eu"**, "Não" (as que mais abrem frase no Tatoeba) |
| Aprendizado | par do usuário só aparecia depois de 6 usos e valia pouco | aparece depois de 2 usos; 2 usos = 80, 3 = 100, 5+ = 127 na escala do dicionário |
| Autocorreção (quando ligada) | trocava pela 1ª sugestão, inclusive complementos ("obrig" → obrigado) e palpites com espaço | só troca se a sugestão for do mapa MrFix ou estiver a até 1 erro (até 5 letras) ou 2 erros (maiores), sem contar acento e caixa; nunca por palpite com espaço fora do mapa |
| Siglas | 900 siglas que nunca aparecem no corpus (FHM, RBN, TgN) | removidas, menos as técnicas (USB, PDF, GPS...); "tbm" não mostra mais FHM |
| Versão | 1061000 / v1.61.0 | 1062000 / v1.62.0 |

O esquecimento continua o que o app já tinha: o banco de pares do usuário guarda até 10.000 e apaga 1.000 de uma vez quando enche. Esquecer por tempo pediria mudar o banco.

## Como foi feito
- `assets/mr_trigrams.bin` (3,0 MB; 1,8 MB comprimido no APK), de `docs/tools/make_trigrams.py`: contextos de duas palavras vistos 8+ vezes nas notícias e no Tatoeba (peso 3), com as 3 continuações mais frequentes, **só quando elas diferem das que o par já dá** (169.258 contextos, 30.618 palavras). Fontes e licenças iguais às do dicionário.
- `MrTrigram` (novo): lê o arquivo numa thread à parte no primeiro uso (uns 6 MB na memória); até terminar, a previsão usa só os pares.
- `MrPredict`: contexto de duas palavras (`MrText.lastTwoWords`; vírgula e ponto quebram o contexto), palavras de começo de frase, `firstLetter` para a 1ª letra. Recebe o `Context` do `LatinIME` para abrir o arquivo.
- `MrFuzzy.finish` (chamado no fim de `Suggest.getSuggestions`): espaço reservado para a correção e a regra da autocorreção.
- `ExpandableDictionary.reverseLookUp`: limite do par do usuário de 12 para 4 e `MrText.userBigramScore`.
- `make_wordlist.py`: regra das siglas; o dicionário foi refeito (173.822 palavras, 400.000 pares, 3,71 MB).

## Validação (no PC)
- Previsão, palavra certa entre as 3 mostradas:

| | Notícias, depois do espaço | Notícias, depois da 1ª letra | Conversa, depois do espaço | Conversa, depois da 1ª letra |
|---|---|---|---|---|
| 1.6.1 (só a última palavra) | 25,4% | 49,2% | 25,1% | 55,2% |
| **1.6.2 (duas palavras)** | **31,7%** | **52,3%** | **33,5%** | **58,6%** |

- Ponta a ponta com as classes do APK e a lib do PC: todas as verificações passaram, inclusive "prota" → porta e as 6 de autocorreção (corrige obrogado, pesquiza, asim, concerteza; não corrige obrig nem eusei).
- Dicionário: 173.822/173.822 palavras válidas e os 400.000 pares exatos na lib original; amostras do teste do CI (`native/test`) refeitas para o dicionário novo.
- Tempo no PC: 0,19 ms por tecla, 0,06 ms por previsão (igual à 1.6.1).
- APK sem assinatura: 5,6 MB (1.6.1: 3,9 MB), por causa do arquivo de duas palavras.
- **Não rodei num aparelho.**

## Testes Android necessários
1. Digitar "eu não " e ver quero/sei/tenho; "muito obrigado " e ver pela/por.
2. Campo vazio e depois de "Oi. ": Você / Eu / Não.
3. "prota": porta aparece na faixa.
4. Escolher a mesma palavra depois de outra 2 vezes: na 3ª ela aparece na previsão.
5. Autocorreção ligada: "obrogado" + espaço corrige; "obrig" + espaço não vira obrigado.
6. Abrir o teclado logo depois de instalar e digitar rápido: sem travadas enquanto o arquivo de duas palavras carrega (a 1ª previsão pode vir sem ele).
7. Memória: o teclado não pode ser fechado pelo sistema em aparelho com pouca RAM.
