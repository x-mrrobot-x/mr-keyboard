# 1.66 — Correção mais esperta: posição do toque, letra que falta no começo e autocorreção

## Pedido
Melhorar a correção nos três idiomas:
- a letra que falta no começo da palavra;
- usar a posição do toque, para que uma tecla mais perto do dedo pese mais que uma mais longe.

## O que mudou
Tudo em `MrFuzzy` (Java → smali), sem dicionário novo:

1. **Letra que falta no começo.** "abelo" → cabelo, "airro" → bairro, "ausa" → causa, "edida" → medida, "enha" → tenha, "ersonas" → personas.
   - Antes, a busca só começava pela inicial digitada ou por uma tecla vizinha dela; agora tem uma passada a mais com as outras iniciais.
   - Nessa passada, a raiz só pode ser a letra que faltou (custo 35), com no máximo mais um erro barato em palavra de 6 letras ou mais.
   - Ela não roda quando o digitado ainda é começo de uma palavra do dicionário, porque aí a pessoa está no meio dela.
2. **Distância do toque.** O detector de teclas do app já manda os vizinhos em ordem de distância do toque até o centro de cada tecla (`ProximityKeyDetector`). Agora essa ordem conta:
   - a tecla mais perto custa o mesmo de antes (25), a 2ª custa 30 e as outras 35;
   - quando as duas primeiras sugestões trocam a mesma letra digitada ("feve": deve × teve), fica na frente a da tecla mais perto do dedo.
3. **Autocorreção que entende o toque.** A autocorreção cuidadosa da 1.62 só trocava a palavra com até 1 erro (até 5 letras) ou 2 (palavras maiores).
   - Agora, uma letra trocada por uma das 2 teclas mais perto do toque vale meio erro: "logaf" → ligar, "tragafp" → tratado, "winds" → ainda.
   - Isso não vale quando a sugestão é nome próprio ou sigla e a pessoa digitou em minúsculas.
4. **Sigla ou nome com a mesma grafia não fica em 1º.** Quando a 2ª opção é uma tecla vizinha do toque, "ds" passa a sugerir "de", não "DS", e "abe" sugere "ave", não "Abe".
   - "cpf" → CPF e "brasil" → Brasil continuam, porque a 2ª opção deles não é troca de uma tecla vizinha.

Versão 1.66.0 (1066000). Os pacotes de dicionário não mudam.

## Como foi medido
- **Teste novo de digitação com toques imprecisos** (`docs/tools/e2e/TouchEval.java`):
  - cada letra das palavras das frases de teste vira um toque com dispersão normal em volta do centro da tecla (σ = fração da largura e da altura da tecla);
  - a tecla tocada e os vizinhos saem como no detector do app: em ordem de distância, até 1,4 largura de tecla;
  - 4 mil palavras por idioma, contando o que fica depois do espaço com a autocorreção ligada, como faz o LatinIME.

**Palavras que saíram com erro de toque:**

| σ | idioma | certa depois da autocorreção (1.65 → 1.66) | trocada por outra palavra (1.65 → 1.66) |
|---|---|---|---|
| 0,20 (≈8% das palavras com erro) | português | 84,5% → **92,0%** | 10,1% → 3,3% |
| | inglês | 86,1% → **89,4%** | 3,3% → 1,7% |
| | espanhol | 92,6% → **94,4%** | 2,4% → 1,5% |
| 0,25 (≈27%) | português | 79,6% → **87,7%** | 9,3% → 5,3% |
| | inglês | 78,3% → **85,6%** | 6,6% → 3,5% |
| | espanhol | 83,4% → **91,0%** | 6,0% → 3,0% |
| 0,30 (≈47%) | português | 69,9% → **82,2%** | 10,7% → 7,2% |
| | inglês | 71,4% → **81,5%** | 7,5% → 5,7% |
| | espanhol | 74,1% → **85,8%** | 6,2% → 4,4% |

**Palavras digitadas certas:** a autocorreção não estraga mais do que antes:
- português: 0,41% a 0,53%;
- inglês: 0%;
- espanhol: 0,2% a 0,3%.

Os casos do português são quase todos palavras que o dicionário não tem sem acento ("la" → lá, "doi" → dói).

**A palavra certa entre as 3 posições:** igual à 1.65 (96% a 99%). A mudança está na escolha.

- **Erros sintéticos** (`TypoEval`; a ordem dos vizinhos ali é fixa, não a do toque):

  | idioma | acerto nas 2 posições (1.65 → 1.66) | letra que falta (1.65 → 1.66) |
  |---|---|---|
  | inglês | 86,5% → 87,9% | 57% → 62% |
  | espanhol | 88,9% → 89,7% | 63% → 65% |

  A letra que falta continua sendo o erro mais difícil. O que sobra é, na maioria, a palavra errada ser outra palavra válida ("hey" por they), que a autocorreção não deve tocar, ou falta da 1ª letra quando o resto ainda é começo de palavra.
- **Português, 14.041 palavras de paridade:** 362 mudaram a 1ª sugestão. As mudanças olhadas são as esperadas: cabelo, bairro, baixa, famosos, parceria, causa, medida, pedra, pegar, tenha, comeu, está; anda/andar/ave/as no lugar de Abda/Abdar/Abe/AA.
- **Ponta a ponta** nos três idiomas (`E2ETest`, `E2EEn`, `E2EEs`): TUDO OK. `PacksTest` (50) e `ThreeLangTest` (20): TUDO OK.
- **Tempo por tecla** (PC):

  | | 1.66 | 1.65 |
  |---|---|---|
  | português | 0,24 ms (p99 0,98) | 0,25 ms (p99 1,0) |
  | inglês, notícias | 0,25 ms (p99 1,2) | 0,27 ms (p99 1,8) |
  | espanhol | 0,18 ms (p99 0,78) | 0,17 ms (p99 0,70) |

- **Build:** `d2j-asm-verify` sem erros; nenhum ID de recurso usado no smali mudou.

## Limites
- O app recebe a ordem dos vizinhos, não a distância em si. Um toque bem no meio da tecla e um na borda dão a mesma ordem. Por isso a tecla mais perto não ficou mais barata que antes; só as mais longe ficaram mais caras.
- Usar a distância de verdade exigiria guardar as coordenadas de cada toque no `WordComposer`, mexendo no `PointerTracker` e no `LatinIME`. Pode ser um próximo passo, se no aparelho ainda faltar.

## Testes Android necessários
1. Com a autocorreção ligada, digitar rápido frases comuns nos três idiomas e conferir que os erros de toque viram a palavra certa no espaço.
2. "ds " → de, "abe " → ave; "cpf " continua CPF.
3. Falta da 1ª letra: "abelo" → cabelo, "ersonas" → personas, "eally" (inglês) → really, se aparecer.
4. Palavras certas não podem ser trocadas, principalmente as sem acento que existem ("esta", "como", "pais").
5. Sensação de velocidade igual à da 1.65.
