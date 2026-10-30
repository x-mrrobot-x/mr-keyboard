# 1.5.3 — Botões sem fundo (estilo Gboard) e 3 posições fixas de sugestão

> **Estilo revertido na 1.5.5** (botões voltaram ao fundo de tecla do tema). **Ajustado na 1.5.4** (veja `revisao-1.5.4.md`): ícones passaram de 28 dp para 26 dp e os dos painéis também; o realce ao tocar deixou de ser cinza e segue a cor do tema; os botões da aba Anexos voltaram a ter fundo. O que diz respeito às 3 posições de sugestão continua valendo.

## Pedido
Remover fundo e bordas dos botões da barra de ferramentas, ficando como o teclado do Google, com ícones de bom tamanho; não adicionar o ícone de grade (já existe a tecla abaixo da barra). Ao digitar, mostrar 3 posições com lugares fixos e centralizados, preenchidas conforme as palavras vão surgindo.

## Barra de ferramentas
- `res/drawable/mr_tb_btn.xml`: seletor sem fundo e sem contorno. Só ao tocar aparece um realce translúcido arredondado (`#33808080`, raio 20 dp). O estilo `MrShotBtn` usa o mesmo drawable e também ficou sem fundo.
- `MrTools.btn()`: não aplica mais o fundo de tecla do tema (`sKeyBg`) em cada botão. Preenchimento, clique e tonalização do ícone continuam.
- Ícones da linha principal (`ic_mr_clip`, `trans`, `attach`, `emote`, `sheets`, `tune`): de 18 dp para 28 dp. Os ícones dos painéis não mudaram.
- `res/drawable/mr_tb_field.xml` (novo): o campo de texto da tradução mantém o contorno discreto de antes, porque não é um botão. `mr_toolbar.xml` (`t_field`) aponta para ele.
- Não foram adicionados ícone de grade nem de microfone. As teclas do teclado não mudaram.

## Sugestões: 3 posições fixas (`CandidateView`)
- A faixa é dividida em terços iguais da largura da barra: esquerda, centro, direita. Cada palavra fica **centralizada na sua posição** e a posição não depende do tamanho do texto.
- **Preenchimento:** lista do motor (0 = palavra digitada, 1 = melhor sugestão, 2 = segunda). Centro = melhor sugestão (índice 1); esquerda = palavra digitada; direita = segunda sugestão. Se a palavra digitada é válida e há autocorreção recomendada, o centro passa a ser a palavra digitada e a melhor sugestão vai para a esquerda. Com uma só entrada, ela fica no centro; com duas, centro e esquerda; as posições sem palavra ficam vazias e as palavras surgem nelas conforme a digitação avança.
- **Tom:** centro na cor cheia do texto do tema; laterais com 65% de opacidade (pedido da 1.5.2, mantido). A autocorreção recomendada fica em negrito.
- **Divisores:** sempre dois, nos limites dos terços, com a mesma cor do tema (1.5.0).
- **Texto longo:** o texto encolhe até 75% do tamanho e, se ainda não couber (largura do terço menos 10 dp de cada lado), é cortado com reticências. Nada invade a posição vizinha.
- **Dica "toque para salvar":** ocupa as posições do meio e da direita juntas (sem divisor entre elas); a palavra continua à esquerda.
- **Sem rolagem:** a faixa tem sempre a largura da barra.
- **Índices:** `pickSuggestionManually(índice, texto)` recebe o mesmo índice da lista de antes (0 = palavra digitada), então a inserção não mudou. O toque seleciona a posição tocada e desenha o realce.
- **Toque longo na palavra digitada** (adicionar ao dicionário): `CandidateView.mrOnFirst(x)` testa a posição onde a palavra digitada está.
- O atraso de 1 s para voltar às ferramentas (1.5.1) e a lógica de `MrSugg` não mudaram.

## Validação
- `apktool b` (2.11.1) sem erros; APK desmontado: versão v1.53.0 (código 1053000), `mr_tb_btn`/`mr_tb_field` presentes, ícones de 28 dp, métodos novos em `CandidateView`, `btn()` sem `sKeyBg`.
- `docs/tools/strip_sim.py`: executa o **smali** de `onDraw`, `mrLayout`, `mrDrawAll`, `mrSlot`, `mrText`, `mrDivider` e `mrOnFirst` num mini interpretador Dalvik com Canvas e Paint de mentira que gravam o desenhado, e compara com uma especificação independente em 6000 casos aleatórios (largura 0 e normais, tamanhos de fonte, 0 a 6 entradas, palavras longas e repetidas, dica, recomendada, toques). Passa.
- Testes de mutação (alterar o smali de propósito): centro, divisor, borda esquerda/direita, largura do toque longo, piso de encolhimento e cor do centro. O teste falha em todos, então pega erros de lógica e de registrador. A primeira rodada deixou sobreviver a mutação do trecho de `mWordX` (toque longo); os pontos de teste foram reforçados e agora ela é pega.
- Limite: o interpretador cobre só o subconjunto de instruções usado e não é o verificador do ART. **Não houve execução no aparelho.**

## Testes Android necessários
1. Barra de ferramentas: botões sem fundo e sem contorno, ícones maiores e bem espaçados; ao tocar, realce suave. Temas escuro e claro.
2. Campo de tradução: continua com o contorno discreto.
3. Digitar "t", "te", "tes", "test": 1ª letra aparece no centro; depois esquerda/centro/direita, sempre nos mesmos lugares, cada palavra centralizada.
4. Tocar em cada posição: insere a palavra tocada (a do centro é a melhor sugestão).
5. Palavra longa: encolhe e, se preciso, termina em "…" sem invadir a vizinha.
6. Segurar a palavra digitada (esquerda): dica "toque para salvar" ocupando centro e direita.
7. Campo com autocorreção: a recomendada em negrito.
8. Parar de digitar: depois de 1 s a linha volta às ferramentas.
