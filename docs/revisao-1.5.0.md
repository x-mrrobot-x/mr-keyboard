# 1.5.0 — Sugestões com as cores do tema e alternância pela tecla da barra

## Problema (1.4.8/1.4.9 no aparelho)
- As sugestões usavam cores fixas do Hacker's Keyboard: palavra digitada em branco e as demais em âmbar (`candidate_other`/`candidate_recommended` = #fcae00), sem relação com o tema. O divisor era uma linha branca alta e o realce de toque, ciano fixo.
- A linha tinha um botão próprio com o mesmo ícone da tecla da barra de ferramentas, e o "‹" para voltar. Ficava redundante com a tecla, que antes mostrava/ocultava a linha.

## Cores
- `CandidateView.mrTheme(int corDoTexto)`, chamado pelo `MrSugg` sempre que a faixa é anexada a uma nova raiz da barra (cada `setInputView`, inclusive na troca de tema). Usa `MrTools.sTextColor`, a cor do texto das teclas do tema atual.
  - Sugestões e sugestão principal (que continua em negrito): cor do texto.
  - Palavra digitada (primeira posição): cor do texto com 65% de opacidade.
  - Divisor e realce de toque: `setTint` com a cor do texto. A transparência vem do próprio drawable (divisor ~19%, realce 25%).
- `keyboard_suggest_strip_divider.xml`: linha de 13dp centralizada (antes 22dp) com preenchimento #30ffffff, tingido pelo tema.
- Os campos de cor e de realce do `CandidateView` deixaram de ser `final` para poderem ser atualizados.
- A faixa ganhou 4dp de margem lateral dentro da linha.

## Alternância
- Removidos `sg_tools` (botão de ferramentas na linha de sugestões) e `b_sugg` ("‹" na linha de ferramentas).
- A tecla da barra (`MrTools.toggleBar`) consulta primeiro `MrSugg.onBarKey`:
  - linha visível e há sugestões para a palavra atual: alterna entre sugestões e ferramentas. A escolha de ferramentas vale até a palavra acabar.
  - caso contrário: mostra ou oculta a linha, como antes.
- Linha visível (sem painel aberto): mostra sugestões quando há palavra em digitação com sugestões, e ferramentas no resto do tempo.
- Linha oculta pela tecla: não mostra nem ferramentas nem sugestões. A 1.4.8 mantinha só a faixa de sugestões nesse caso; agora a tecla volta a controlar a linha inteira.

| Situação | Tecla da barra |
|---|---|
| Linha mostrando sugestões | passa para as ferramentas |
| Ferramentas durante uma palavra (após a tecla) | volta para as sugestões |
| Ferramentas sem palavra em digitação | oculta a linha |
| Linha oculta | mostra a linha |

## Preservado
Dicionário pt-BR (1.4.9), motor de sugestões, painéis da barra e configuração "Mostrar sugestões".

## Validação
- `apktool b` (2.11.1) sem erros. APK desmontado: `MrSugg` (12 métodos), `CandidateView.mrTheme`, chamada em `toggleBar`, divisor novo e linha sem os botões removidos.
- Checagem estática: chamadas entre classes só a métodos públicos ou de pacote, e nenhuma referência aos membros removidos.
- Não houve execução no aparelho.

## Testes Android necessários
1. Tema Dark Tech: sugestões na cor do texto das teclas, digitada um pouco apagada, divisores curtos e discretos, sem âmbar.
2. Tema claro: texto escuro legível; trocar de tema com o teclado aberto.
3. Digitar uma palavra → sugestões; tecla da barra → ferramentas; tecla de novo → sugestões; espaço → ferramentas.
4. Sem palavra em digitação: a tecla oculta e mostra a linha.
5. Tocar e segurar uma sugestão: o realce segue a cor do tema.
