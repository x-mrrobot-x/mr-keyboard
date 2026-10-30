# 1.6.0 — Sugestões: dicionário novo com bigramas, correção aproximada, previsão e aprendizado

## Pedido
Pacote "Equilibrado" da pesquisa de sugestões, 100% offline:
- dicionário pt-BR maior e mais limpo, com pares de palavras (bigramas) do corpus Leipzig (CC BY);
- correção além do prefixo: letra sobrando ou faltando, troca de lugar, erros fonéticos, espaço faltando, mapa de erros e abreviações;
- previsão da próxima palavra depois do espaço (até 3, a melhor no centro; sem previsão, a pontuação de antes);
- aprendizado funcionando sempre que as sugestões estão ligadas, nunca em senha nem em campo anônimo;
- padrões mantidos: sugestões e autocorreção continuam desligadas.

## O que mudou
| Item | 1.5.9 | 1.6.0 |
|---|---|---|
| `res/raw/main_pt.dict` | formato antigo, ~165 mil palavras, sem bigramas, 1,92 MB guardado sem compressão | formato "latest" (cabeçalho 200/1), 174.722 palavras, 400.000 bigramas (notícias + conversa do Tatoeba), 3,71 MB (limite do formato: 4 MB), comprimido no APK |
| Grafia | tinha idéia, freqüência, vôo, pára, projecto, della, vous, the... | grafia do Acordo de 1990, sem variantes lusitanas, sem palavras gramaticais estrangeiras e sem inglês que não se usa em português |
| Palavras novas | — | segunda-feira, bem-vindo, e-mail, trata-se, streaming, podcast, criptomoedas, WhatsApp, Instagram, Bolsonaro, gírias e abreviações de chat (vc, tbm, pq, kkk, rs, perrengue, crush...) |
| 1ª letra digitada | bigramas só nos modos 1 e 3 e só com a mesma letra exata | sempre que há sugestões; aceita acento e maiúscula (e → é, está) |
| Erros fora do prefixo | só tecla vizinha e uma letra sobrando | + letra faltando, troca de lugar, fonética (s/z/ç, ch/x, g/j, h mudo), letra dobrada, espaço faltando, ~200 correções e abreviações |
| Depois do espaço | pontuação | até 3 previsões (2ª, 1ª no centro, 3ª); sem previsão, pontuação |
| Aprendizado | só com a autocorreção ligada, e então os bigramas aprendidos nunca eram lidos | sempre que as sugestões estão ligadas; nunca em senha ou com `IME_FLAG_NO_PERSONALIZED_LEARNING` |
| Autocorreção ligada | modo 2 (sem bigramas) | modo 3 (com bigramas) |
| Versão | 1059000 / v1.59.0 | 1060000 / v1.60.0 (`apktool.yml` e `apktool.json`) |

## Como foi feito
### Dicionário (`docs/tools/make_wordlist.py`, `build_dict.py`)
- Base: `pt_BR_wordlist.combined.gz` v54 do AOSP (Apache-2.0 + aviso Lexiteria). Não usei a versão do HeliBoard porque o repositório dele é GPL-3.0 e não diz a licença dos dicionários; a atualização ortográfica foi refeita no script.
- Corpus: Leipzig `por_news_2024_1M` (CC BY 4.0), só fontes brasileiras (`split_br.py`: tira domínios .pt/.ao/.mz etc., sites com marcadores de pt-PT e dois sites sediados em Portugal): 876.742 de 1.000.000 frases. O teste usa 5.262 frases separadas do arquivo de 300 mil; as 804 delas que também estavam no de 1M saíram do treino (858.403 frases, 16,6 milhões de palavras).
- VERO (pt-BR) e en_US do Hunspell só como filtro; nada deles é copiado.
- Conversa: Tatoeba (CC BY 2.0 FR), 445.521 frases em português; saíram 50 autores com marcas de português europeu (autocarro, estás a), as frases com essas marcas e as repetidas, e os nomes Tom e Mary (aparecem em ~15% das frases do site). 378.366 frases para contar, 19.914 para teste (`split_tatoeba.py`). Nos pares de palavras elas contam 3 vezes; nas palavras novas contam 1 vez, para não inflar palavras raras.
- Seleção dos pares: até 3 por palavra garantidos e o resto por contagem, até 400.000.
- Palavras novas do corpus: 5.816 aceitas pelo VERO, 1.236 nomes próprios, estrangeirismos, neologismos, gírias e abreviações.
- Limpeza da base (números em `docs/tools/relatorio_lista_1.6.0.txt`): 880 grafias antigas trocadas, 538 minúsculas curtas estrangeiras, 1.535 palavras inglesas sem uso em português no corpus, 203 variantes lusitanas, 53 palavras gramaticais de outras línguas, erros de grafia (enquando, encontar, asim...), formas sem acento duplicadas (familia, agua).
- Palavras possivelmente ofensivas (lista do AOSP): nunca aparecem como previsão; 30 palavrões ficam com frequência 5 (só aparecem digitados por inteiro). As demais (crianças, negro, peito) mantêm a frequência.
- Bigramas: contagem ≥ 2 dentro de trechos sem pontuação, até 60 por palavra (limite da lib), frequência de 7 bits a partir de P(seguinte | anterior).
- `build_dict.py` grava em profundidade (a busca de bigramas da lib não funciona em largura) e relê o arquivo com uma cópia em Python das rotinas da lib, conferindo cada palavra, frequência e bigrama.

### Camada Java (`docs/tools/java/src`, gerada para smali com `docs/tools/build_java.sh`)
- `MrText`: letra-base sem acento, iniciais com variantes, última palavra antes do cursor, conserto dos acentos que a lib devolve com sinal no x86, `learnable` (não aprende sugestão com espaço).
- `MrFix`: ~200 erros comuns e abreviações (vc → você, concerteza → com certeza, excessao → exceção).
- `MrFuzzy`: busca aproximada no mesmo buffer do .dict (sem cópia), com custos por tipo de erro. Só roda se a palavra digitada não é válida; 1ª passada com um erro, 2ª com dois só para palavras longas sem resultado; primeira letra restrita; teto de 12.000 nós.
- `MrPredict`: previsão depois do espaço juntando bigramas do dicionário e do usuário (peso 2 para o usuário).

### Smali
- `BinaryDictionary`: `getBigrams` passa iniciais com acento/maiúscula (até 96 códigos) e conserta acentos do x86; novos `mrBuffer`, `mrLength`, `mrBigrams`.
- `Suggest`: bigramas na 1ª letra em qualquer modo, filtro por `MrText.sameInitial`; `MrFuzzy.afterWords` depois do dicionário principal; uma maiúscula só não vira "tudo em maiúsculas"; novos `mrMainDict`, `mrUserBigrams`.
- `LatinIME`: `updateCorrectionMode` (2 → 3), `checkAddToDictionary` (aprende se `isPredictionOn`, sem `mMrNoLearn`, sem espaço), `onStartInputView` (`mMrNoLearn` de `imeOptions & 0x1000000`), `setNextSuggestions` (`MrPredict.list`).
- `apktool.yml`/`apktool.json`: "dict" saiu de `doNotCompress` (o .dict é lido por `openRawResource` + `available()`, que funciona comprimido no Android 8+).

## Validação (no PC)
- `apktool b` sem erro; APK sem assinatura de 3,8 MB (1.5.9: 2,8 MB).
- Lib nativa original compilada no PC (`dict_test.cpp`, com `-funsigned-char` como no ARM): 174.722/174.722 palavras válidas; `getBigrams` devolve exatamente os 400.000 pares gravados.
- Ponta a ponta (`docs/tools/e2e/E2ETest.java`): classes reais do APK (dex2jar) + lib nativa do PC. 26 de 27 verificações certas (1ª letra com bigramas, erros, mapa, abreviações, previsão, bigrama do usuário no centro). A que falha: "prota" mostra protagonista em vez de porta, porque a digitada ainda é começo de palavra e os complementos da lib ganham.
- Com a lib compilada como no x86 (char com sinal) as previsões com acento saem iguais.
- Previsão: a palavra certa entre as 3 mostradas

| Dicionário | Notícias, depois do espaço | Notícias, depois da 1ª letra | Conversa, depois do espaço | Conversa, depois da 1ª letra |
|---|---|---|---|---|
| Leipzig 300 mil | 25,3% | 47,6% | — | — |
| Leipzig 1M | 26,1% | 50,2% | 19,3% | 43,9% |
| **Leipzig 1M + Tatoeba (usado)** | 25,4% | 49,2% | **25,1%** | **55,2%** |

  O teste de conversa são as frases do Tatoeba separadas para teste. A mistura perde menos de 1 ponto em notícias e ganha 6 a 11 pontos em conversa.
- Erros sintéticos sobre palavras frequentes: a original aparece entre as 3 da busca aproximada em 97%.
- Tempo no PC (Java com JIT): 0,20 ms por tecla em média, 0,76 ms no p99; previsão 0,06 ms. **No aparelho não medi**: estimo 5 a 15 vezes mais.

## Testes Android necessários
1. Instalar sobre a 1.5.9 (mesma assinatura). Abrir o teclado: o dicionário carrega (logcat sem "Read ... bytes, expected").
2. Ligar sugestões. Digitar "muito " e ver 3 previsões, a do meio em cor cheia; tocar numa e ver a seguinte.
3. Depois de "bom ", digitar "d": "dia" deve aparecer. Depois de "ele ", digitar "e": "é" deve aparecer.
4. Digitar obrogado, asim, omem, pesquiza, enchergar, concerteza, vc, tbm: a correção aparece na faixa.
5. Autocorreção ligada: "obrogado" + espaço vira "obrigado"; "vc" + espaço continua "vc".
6. Aprendizado: escolher a mesma previsão algumas vezes depois de uma palavra; ela passa para o centro.
7. Campo de senha e aba anônima do navegador: nada é aprendido (repetir o teste 6 lá e conferir fora).
8. Tempo: digitar rápido palavras longas erradas; a faixa não pode atrasar. Medir a abertura do teclado logo após reiniciar.
9. Aparelho ou emulador x86: previsões com acento (depois de "não ") sem caracteres estranhos.

## Licenças e créditos
`res/raw/notice_main_pt.txt`: AOSP (Apache-2.0, Lexiteria), Leipzig Corpora Collection (CC BY 4.0, com a citação pedida), Tatoeba (CC BY 2.0 FR), listas próprias. Nenhuma frase dos corpora é distribuída, só contagens.

## Limitações
- O botão Traduzir continua enviando o texto para translate.googleapis.com quando usado (função já existente, fora deste pacote).
- Corpus de notícias: previsões puxam para o registro jornalístico até o aprendizado se ajustar ao usuário.
- "prota" → "porta" e outros erros que formam o começo de outra palavra só aparecem depois dos complementos.

## Próximos passos
Ver `docs/plano-nativo.md` (NDK pelo GitHub Actions: `.github/workflows/mr-native.yml` e `native/`).
