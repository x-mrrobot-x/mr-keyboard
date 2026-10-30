# 1.64 — Pacote de dicionário em inglês (en-US) e aviso do Traduzir

## Pedido
- Fase C do `docs/plano-dicionarios.md`: um pacote en-US publicado pelo mesmo caminho do pt-BR. Quem já tem a 1.63 também pode baixar.
- Aviso de que o Traduzir manda o texto do campo para o Google Tradutor, o único recurso que manda texto para fora do aparelho.

## O que mudou
### Pacote en-US (`dicts/en-US`, versão 1)
| | en-US | pt-BR (comparação) |
|---|---|---|
| Palavras | 168.992 | 173.822 |
| Pares de palavras | 400.000 | 400.000 |
| `main.dict` | 3,76 MB (limite do formato: 4,19 MB) | 3,71 MB |
| `trigrams.bin` | 2,35 MB, 142.509 contextos | 3,02 MB |
| Download | 4,1 MB | 4,5 MB |
| Instalado | 6,1 MB | 6,7 MB |

O `rules.txt` do inglês tem 346 correções:
- contrações sem apóstrofo: dont → don't, im → I'm, youre → you're…;
- i → I;
- abreviações de chat: u → you, thx → thanks, idk → I don't know, tbh → to be honest;
- erros comuns: teh, recieve, definately, seperate, goverment…;
- palavras juntas: alot → a lot, thankyou → thank you.

As regras de letras, para a correção aproximada:
- letras parecidas: c/k, c/s, s/z, k/q, g/j, i/y;
- vogais trocadas: a/e, a/i, e/i, o/u;
- grupos: f = ph, k = ck, c = ck, ks = x;
- letras mudas: knife, write, honest, what, ghost, school, rhythm, thumb, guess, build, science, have;
- vogais que somem ao digitar rápido (wnt → want).

O começo de frase é "The · **I** · You".

### App 1.64
- **Aviso do Traduzir:** o campo diz "Digite para traduzir com o Google" ("Type to translate with Google"). Na primeira vez que o painel abre, um aviso curto diz que o texto do campo vai para o Google Tradutor e o resto fica no aparelho. O aviso não aparece de novo (`MrNotice`; marca em `SharedPreferences` "mr_notices").
- **Correções de uma letra:** "i" → I e "u" → you. O `Suggest` não procura palavras para 1 letra, então o `MrFuzzy.finish` agora consulta a lista de correções nesse caso. Com a autocorreção ligada, "i" vira "I" ao dar espaço.
- **Regra nova em `[silent]`:** `* letra custo` quer dizer "pode faltar depois de qualquer letra". A 1.63 ignora essas linhas, então o pacote en-US funciona nela, só sem essa ajuda.
- Versão 1.64.0 (1064000). Sem permissão nova.

## Como foi feito
- **Lista** (`docs/tools/make_wordlist_en.py`):
  - base: a lista en_US do AOSP (Apache 2.0, mesmo commit do espelho LineageOS que a pt_BR). Saem as entradas `not_a_word`; as boas viraram correções no `rules.txt`.
  - novas do corpus: 8.400 minúsculas aceitas pelo Hunspell en_US (grafia americana; "colour" não entra), com pelo menos 3 letras.
  - nomes: 259, contados só nas notícias, para os nomes repetidos das frases do Tatoeba não entrarem.
  - conversa: 8 palavras (lol, omg, idk…).
  - palavras possivelmente ofensivas não são previsão; as vulgares ficam com frequência mínima.
- **Textos** (`docs/tools/split_en.py`):
  - Leipzig eng_news_2025_1M (CC BY 4.0): 980 mil frases de treino e 20 mil de teste.
  - Tatoeba eng (CC BY 2.0 FR): 2 milhões de frases sem repetição, 1 de cada 20 para teste. Os nomes e lugares repetidos das frases de exemplo viram separador: Tom, Mary, Layla, Rima, Skura, Boston, Algeria…, para não ensinarem "to Boston".
  - O Tatoeba em inglês tem o dobro de frases das notícias, então ele conta com peso 1. No português o peso era 3. Peso 2 deu +0,6 ponto na conversa e −0,5 nas notícias.
- **Pares a mais:** testei 480 mil pares em vez de 400 mil. Ganha só 0,2 a 0,4 ponto e deixa o dicionário em 4,08 MB, perto do limite. Ficaram 400 mil.

## Validação
**Previsão** (`eval_predict.py`, frases de teste fora do treino; acertos entre as 3 mostradas):

| | depois do espaço | depois da 1ª letra |
|---|---|---|
| inglês, notícias (20 mil frases) | 29,0% | 49,6% |
| inglês, conversa (20 mil frases) | 35,1% | 61,4% |
| português 1.62, notícias | 31,7% | 52,3% |
| português 1.62, conversa | 33,5% | 58,6% |

Sem as duas palavras (trigramas), o inglês fica em 25,0/48,3 nas notícias e 26,7/59,0 na conversa.

**Correção** (1.488 erros sintéticos nas palavras mais comuns dos testes):
- a palavra certa aparece nas 2 posições de sugestão em 86,5% dos casos:

  | tipo de erro | acerto |
  |---|---|
  | tecla vizinha | 99% |
  | troca de lugar | 93% |
  | letra dobrada | 100% |
  | letra que falta | 57% |

  Muitos erros de letra que falta são na primeira letra ("lso" → also), que a busca não tenta, ou viram outra palavra válida ("hem" → them).
- a regra de vogais que somem deu +2 pontos e custou +15% no tempo médio por tecla;
- a autocorreção acertou 1.027 vezes e errou 158 (ela vem desligada).

**Ponta a ponta** (`E2EEn`, classes do APK 1.64): TUDO OK.
- correções: teh, recieve, dont/Dont, im/Im, i, u, wat, nife, alot, thankyou, helo, beleive, freind, tomorow, definately, seperate…
- primeira letra: "y" depois de thank → you; "m" depois de very → much.
- previsão: thank → you; "thank you" → for; "how are" → you; "I don't" → know.
- **Autocorreção como no LatinIME** (só troca quando a digitada não é palavra):
  - teh, recieve, dont, im, i e definately são corrigidas;
  - id, ill, its, were, well e lets ficam como digitadas.

**Dois idiomas** (`TwoLangTest`): com pt-BR e en-US instalados, o teclado pega o pacote certo e as regras dele:
- en_US, en e en_GB → en-US;
- pt_BR e pt → pt-BR;
- alemão: sem pacote, e sem oferecer download, porque o catálogo não tem;
- o aviso do Traduzir fica marcado como visto.

**Fluxo de pacotes** (`PacksTest`, 1.64): 50 verificações OK.

**Português sem mudança:** as 14.041 palavras de paridade saem idênticas às da 1.62.

**Tempo por tecla** (PC):

| | média | p99 |
|---|---|---|
| inglês, conversa | 0,21 ms | 0,95 ms |
| inglês, notícias | 0,27 ms | 1,8 ms |
| português | 0,25 ms | 1,0 ms |

**Build:**
- `d2j-asm-verify` sem erros;
- nenhum ID de recurso usado no smali mudou;
- o catálogo monta com os dois pacotes (série 2: en-US v1 e pt-BR v2).

## Testes Android necessários
1. Push e rodar *Mr Keyboard - dicionários*: publica en-US v1 e pt-BR v2 (série 2).
2. Instalar a 1.64.
   - Dicionários → Procurar atualizações: aparecem Inglês (EUA) e Português (Brasil).
   - Baixar o inglês.
3. Idiomas de entrada: ligar English (US) e trocar pela barra de espaço. Conferir:
   - as sugestões em inglês: teh → the, dont → don't, i → I;
   - a previsão: thank → you;
   - o começo de frase: I no centro.
4. Voltar ao português: as sugestões em português voltam na hora.
5. Traduzir:
   - a dica no campo;
   - o aviso na primeira vez, que não aparece de novo;
   - interface em inglês: o aviso em inglês.
6. Na 1.63, se ainda houver alguma instalada, o pacote en-US também baixa e funciona.
