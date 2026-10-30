# 1.4.2 — Correção do fechamento ao limpar e botão Limpar

## Erro encontrado
Ao exibir o resumo, showClearSummary chamava:

`ScrollingMovementMethod.getInstance()Landroid/text/method/ScrollingMovementMethod;`

A assinatura real do Android retorna a interface MovementMethod:

`ScrollingMovementMethod.getInstance()Landroid/text/method/MovementMethod;`

O descritor de retorno faz parte da referência de método em DEX. A referência anterior não existe na API Android e pode lançar NoSuchMethodError na thread principal, fechando o processo ao mostrar o resultado da limpeza. Esse erro não é uma Exception e não era interceptado pelo fallback de formatação.

A assinatura foi corrigida, sem simplesmente ocultar o erro. Não foram desativados a limpeza, o resumo nem a rolagem.

## Confirmação e regressão
- A assinatura real foi conferida na documentação oficial e nos arquivos públicos de API do AOSP para os níveis 26 e 36. Ambos declaram `public static android.text.method.MovementMethod getInstance()`.
- O stub Android do teste de controlador também declarava incorretamente o retorno concreto. Isso explica por que os testes anteriores não detectaram o defeito. Foi corrigido para reproduzir o contrato real.
- Com o stub corrigido e o controlador traduzido da versão 1.4.1, o teste reproduziu NoSuchMethodError ao chamar showClearSummary.
- Com a implementação corrigida, o mesmo teste exibiu o resumo sem erro de linkage.
- Não foi recebido logcat do aparelho. O erro acima foi identificado e reproduzido em teste JVM; não é uma afirmação de reprodução no dispositivo do usuário ou de exclusão de outras possíveis falhas no aparelho.

## Interface
- O botão de limpeza de Anexos tem agora o rótulo visível “Limpar”, tooltip “Limpar” e descrição acessível “Limpar caches de anexos”.
- A lixeira foi substituída por um vetor de vassoura de 18dp; o botão permanece ao lado de Atualizar e com altura de 36dp.
- As instruções de nova tentativa passaram a mencionar “Limpar” em vez de “lixeira”.
- O ícone de lixeira usado por outras funções não foi alterado.
- Nenhuma confirmação ou aviso prévio foi acrescentado.

## Preservado
NIO sem seguir links, validação da raiz, retenção automática de uma hora, limpeza manual de cópias recentes, proteção de escritores ativos, pools reutilizáveis, resumo completo e Toast curto. Mantidos o envio pela URI original primeiro, os originais do usuário, configurações e registros do clipboard.

## Validação
- Montagem completa de Smali para DEX e desmontagem/remontagem sem erros.
- 17 grupos estáticos anteriores, fluxo direto, fluxo de limpeza e nova verificação de assinatura/rótulo/ícone passaram.
- Scanner limitado de constantes em referências: 1.745 usos examinados, sem violações detectadas.
- 117 verificações JVM anteriores continuaram passando, agora com o stub de rolagem corrigido no controlador.
- Um teste adicional de regressão de linkage passou depois de reproduzir a falha na versão anterior.
- XML do botão e do vetor conferidos por parser e atributos verificados.
- Integridade e correspondência dos arquivos do ZIP verificadas durante o empacotamento.

Os testes usam helpers de produção traduzidos de DEX para JVM e componentes Android simulados. Não houve execução do APK em emulador/aparelho. É necessário confirmar no Android o toque em Limpar, a exibição/rolagem do resumo e a reabertura do teclado. Se persistir o fechamento, o logcat com a exceção é necessário para identificar outra causa.

## Referências
- https://developer.android.com/reference/android/text/method/ScrollingMovementMethod#getInstance()
- https://android.googlesource.com/platform/prebuilts/sdk/+/refs/heads/main/26/public/api/android.txt
- https://android.googlesource.com/platform/prebuilts/sdk/+/refs/heads/main/36/public/api/android.txt
