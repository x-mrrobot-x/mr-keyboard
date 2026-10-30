# 1.65 — Pacote de dicionário em espanhol (es) e ¿ ¡ no teclado

## Pedido
Suporte a espanhol, para o teclado atender português, inglês e espanhol.

## O que mudou
### Pacote es (`dicts/es`, versão 1)
| | es | en-US | pt-BR |
|---|---|---|---|
| Palavras | 239.683 | 168.992 | 173.822 |
| Pares de palavras | 340.000 | 400.000 | 400.000 |
| `main.dict` | 3,79 MB (limite 4,19 MB) | 3,76 MB | 3,71 MB |
| `trigrams.bin` | 3,46 MB | 2,35 MB | 3,02 MB |
| Download | 4,6 MB | 4,1 MB | 4,5 MB |
| Instalado | 7,3 MB | 6,1 MB | 6,7 MB |

O espanhol tem mais palavras porque a lista do Android traz todas as formas dos verbos. Por isso cabem menos pares (340 mil) no limite de 4 MB do formato.

O `rules.txt` do espanhol tem 137 correções:
- abreviações de chat: q/k → que, xq/pq → porque, tb → también, xfa/porfa → por favor, dnd → dónde, tqm → te quiero mucho, ntp → no te preocupes;
- palavras juntas: enserio → en serio, osea → o sea, aver → a ver, nose → no sé, talvez → tal vez;
- erros comuns: haiga → haya, nadien → nadie, dijistes → dijiste, hechar → echar, aora → ahora, nesecito → necesito.

Ficaram de fora as que também são palavras válidas e virariam outra coisa, como "hecho" → echó.

As regras de letras:
- letras parecidas: b/v, s/z/c, c/k/q, g/j, y/i, x/s;
- grupos: y = ll ("yuvia" → lluvia), k = qu ("kiero"), ks/cs = x, s = sc;
- h muda no começo e no meio: "ola" → hola, "aber" → haber, "proibir" → prohibir;
- o u de "qu"/"gu".

O começo de frase é "El · **No** · Me". Expressões fixas de conversa ficam em primeiro na previsão:
- muchas → gracias;
- buenos → días;
- buenas → noches/tardes;
- te → quiero;
- hasta → luego;
- mucho → gusto;
- feliz → cumpleaños.

O Tatoeba tem cada frase uma vez só, então subestima essas expressões. Não entraram as de palavras muito frequentes: "de nada" na frente de "de la" piorava a previsão (−1,7 ponto no top-1).

### Pacote en-US versão 2
Seis palavras ofensivas que vieram dos textos, e não da lista do Android, estavam com frequência normal: insultos raciais e homofóbicos e "slut". Elas apareciam como complemento ao digitar o começo. Agora ficam com frequência mínima e fora da previsão, como as outras vulgares. O resto do pacote é igual à versão 1, inclusive o `trigrams.bin`.

### App 1.65
- **¿ e ¡ separam palavras**, como no teclado do Android para espanhol. Antes, "¿Cómo" ficava grudado e a palavra depois do ¿ não recebia sugestões.
- **Começo de frase:** depois de ¿ ou ¡, a faixa mostra os começos de frase.
- Versão 1.65.0 (1065000). Português e inglês sem mudança.

## Como foi feito
- **Ferramentas:**
  - `make_wordlist_lang.py --lang es|en` generaliza o `make_wordlist_en.py`, que agora só chama este. A lista inglesa sai idêntica, palavra por palavra.
  - `split_lang.py` faz o mesmo que o `split_en.py`, para qualquer idioma.
  - Correção nas vulgares: a frequência mínima agora vale também para as palavras novas dos textos. Foi isso que gerou o en-US v2.
- **Base:** lista es do AOSP (Apache 2.0, mesmo commit do espelho LineageOS).
- **Filtro das palavras novas:** os corretores es_ES, es_MX e es_AR do LibreOffice (vale se qualquer um aceitar). Entraram 2.787 palavras (criptomonedas, resiliencia, ahorita, golazo…), 694 nomes contados só nas notícias e 9 de conversa (jaja, jeje, porfa, finde…).
- **Textos:**
  - Leipzig spa_news_2024_1M (CC BY 4.0): 980 mil frases de treino e 20 mil de teste.
  - Tatoeba spa (CC BY 2.0 FR): 443 mil frases sem repetição, 1 de cada 20 para teste.
  - Viram separador: Tom, Mary, Tomás, Tomasa, John, Boston, Australia e Tatoeba.
  - A conversa conta com peso 3, como no português. Peso 5 dava +0,4 a +0,9 ponto na conversa e −0,4 a −0,8 nas notícias.

## Validação
**Previsão** (frases de teste fora do treino; acertos entre as 3 mostradas):

| | depois do espaço | depois da 1ª letra |
|---|---|---|
| espanhol, notícias | 32,8% | 53,5% |
| espanhol, conversa | 32,0% | 54,8% |
| inglês, notícias | 29,0% | 49,6% |
| inglês, conversa | 35,1% | 61,4% |
| português, notícias | 31,7% | 52,3% |
| português, conversa | 33,5% | 58,6% |

Sem as duas palavras, o espanhol fica em 28,5/51,7 nas notícias e 25,0/51,9 na conversa.

**Correção** (1.489 erros sintéticos, teclado com ñ): a palavra certa aparece nas 2 posições de sugestão em 88,9% dos casos.

| tipo de erro | acerto |
|---|---|
| tecla vizinha | 98% |
| troca de lugar | 96% |
| letra dobrada | 99% |
| letra que falta | 63% |

A autocorreção acertou 1.063 vezes e errou 154 (ela vem desligada).

**Ponta a ponta** (`E2EEs`, classes do APK 1.65): TUDO OK.
- correções: q, Q, xq, Xq, tb, ola, haiga, nadien, aver, nose, enserio, porfa, dijistes, kiero, aora, yuvia, aber, proibir, qiero, vien, caveza, sapato, ajencia, trabjo, graicas, manana, cancion, esta, despues…
- primeira letra: "g" depois de muchas → gracias; "d" depois de buenos → días.
- previsão: "te quiero" → mucho; "no sé" → qué.
- começo de frase depois de ¿ e ¡.
- autocorreção: haiga, nadien, q, dijistes e kiero são corrigidas; ola, esta, tenia, como e si ficam como digitadas.

**Três idiomas** (`ThreeLangTest`, catálogo com os 3 pacotes; o pt-BR é o zip publicado no GitHub):
- en_US/en → en-US;
- es_ES, es_MX, es_US e es → es;
- pt_BR/pt → pt-BR;
- cada um com as regras e os começos de frase do próprio idioma;
- alemão sem pacote e sem oferecer download.

**Português:** as 14.041 palavras de paridade saem idênticas às da 1.62. `PacksTest`: 50 verificações OK.

**Tempo por tecla** (PC):

| | média | p99 |
|---|---|---|
| espanhol, conversa | 0,17 ms | 0,70 ms |
| inglês | 0,21 ms | 0,95 ms |
| português | 0,25 ms | 1,0 ms |

**Build:**
- `d2j-asm-verify` sem erros;
- nenhum ID de recurso usado no smali mudou;
- catálogo série 3: en-US v2 e es v1 novos; pt-BR v2 igual ao publicado.

## Testes Android necessários
1. Push e rodar *Mr Keyboard - dicionários*: publica en-US v2 e es v1.
2. Instalar a 1.65. Em Dicionários → Procurar atualizações:
   - aparecem Espanhol, Inglês (EUA) e Português (Brasil);
   - quem já tem o inglês v1 vê "Atualização disponível".
3. Idiomas de entrada: ligar Español e trocar pela barra de espaço. Conferir:
   - xq → porque, q → que, ola → hola;
   - muchas → gracias;
   - ¿ seguido de palavra recebe sugestões, e depois do ¿ aparecem os começos de frase.
4. Trocar entre os três idiomas: cada um com as próprias sugestões, sem reiniciar.
