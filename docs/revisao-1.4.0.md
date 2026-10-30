# 1.4.0 — Limpar caches de anexos

## Uso
Nova lixeira na barra de Anexos, ao lado de Atualizar. O toque inicia a limpeza imediatamente, sem confirmação nem aviso prévio. Ao terminar, um Toast de duas linhas apresenta arquivos efetivamente excluídos e seus bytes lógicos, miniaturas removidas do LRU e seu tamanho contabilizado, e quantidade de listas descartadas. Em caso de falha, informa resultado parcial e pendências, sem declarar que tudo foi apagado.

A grade permanece vazia após a limpeza. Toque numa categoria ou em Atualizar para carregar novamente; não há recarga automática que repovoe os caches imediatamente.

## Escopo e preservação
- Remove cópias privadas em cache/shots, incluindo recentes, vencidas, arquivos .part e pastas UUID que ficarem vazias. A limpeza manual não aplica o prazo normal de uma hora.
- Descarta as miniaturas em memória e as listas das categorias; esvazia os dados do adaptador e redefine o adaptador da grade para liberar as Views recicladas com miniaturas antigas.
- Não exclui arquivos originais do MediaStore ou de outras pastas, nem configurações ou registros do histórico do clipboard. Uma URI antiga no histórico pode deixar de funcionar se apontava para uma cópia excluída, conforme solicitado.
- A exclusão é limitada ao cache privado de anexos, com verificação de caminho canônico. Links que apontem para fora não são seguidos; ficam como pendência.
- Preservados: entrega pela URI original primeiro, cópia somente como fallback, retenção automática normal de uma hora, listas por 15 segundos, miniaturas limitadas a 8 MiB e ajustes anteriores de interface/inicialização.

## Coordenação e ciclo de vida
- Um bloqueio atômico global impede toques de limpeza duplicados e novos pedidos/seleções durante a operação, inclusive após recriação da interface.
- A ação invalida as sessões e gerações, interrompe e substitui os três pools de trabalho. Resultados antigos de consultas, cópias ou miniaturas não podem voltar à interface como trabalho atual.
- A inserção de miniaturas e a publicação final de cópias usam o mesmo monitor de classe da limpeza, com nova checagem de sessão dentro da região crítica. A cópia de bytes e a espera não mantêm esse monitor.
- A revisão corrigiu o uso de synchronized em métodos Smali não nativos dos helpers alterados: agora há monitor-enter/monitor-exit explícitos e catchall para liberar o monitor em exceções. O flag ACC_SYNCHRONIZED sozinho não implementa esse contrato em DEX para métodos não nativos. A mesma correção foi aplicada aos dois métodos de metadados de retenção existentes.
- A limpeza de disco é executada numa Thread independente, não na fila de cópias que pode ser cancelada ao liberar o teclado. Captura o Context da aplicação e o executor antigo, não o serviço nem as Views. Aguarda até dez segundos pelo encerramento das cópias antigas fora da UI e publica a conclusão por Handler do Looper principal.
- O registro de escritores ativos não é apagado artificialmente. Se um provedor/operação não responder à interrupção, o caminho protegido permanece e o resultado é parcial; outro toque permite tentar novamente. Não há retenção deliberada de cópias recentes para leitores externos: essas cópias são removidas sem prazo de proteção.
- Corrigido também o encaminhamento de tarefas no submit: consulta no pool de consultas, miniatura no de miniaturas, cópia/preparação direta no pool correspondente.

## Contagem
O total de arquivos e bytes só aumenta depois de File.delete() retornar true. Diretórios vazios removidos não entram no número de arquivos. O espaço é o comprimento lógico dos arquivos apagados, não uma medição de espaço físico liberado no sistema. O tamanho das miniaturas corresponde à contabilização do LRU, não à promessa de coleta de lixo ou queda imediata do heap. Bitmaps compartilhados não são reciclados manualmente.

## Validação
- Smali completo montado para DEX, desmontado e remontado sem erros.
- 17 grupos anteriores de verificações estáticas de Anexos passaram; verificações do fluxo direto/fallback e nova checagem de limpeza/monitores passaram.
- Scanner limitado de constantes em referências: 1.726 usos examinados sem violações detectadas.
- Helper de retenção de produção traduzido para JVM: 20 verificações passaram.
- Helper de exclusão de produção traduzido para JVM: 17 verificações passaram, incluindo contagem/bytes reais, cópia recente, escritor ativo e nova tentativa, link externo, raiz ausente e falha de exclusão.
- Coordenador de limpeza de produção traduzido para JVM: 19 verificações passaram, incluindo bloqueio de cliques concorrentes, Toast com contagens, sucesso/parcial, falha de filesystem e falha de postagem do Handler.
- Métodos de produção do controlador de Anexos extraídos para um harness JVM: 17 verificações passaram, incluindo invalidação de gerações, substituição dos três pools, limpeza do adaptador/grade/LRU/listas, contagens capturadas, monitor compartilhado, rejeição de miniatura antiga, cancelamento de publicação antiga e roteamento dos executores.
- Helper de envio direto: 17 verificações anteriores continuaram passando.
- Integridade e correspondência dos arquivos do ZIP verificadas durante o empacotamento.

Os testes JVM usam componentes Android simulados. Não substituem a verificação do ART nem exercitam MediaStore, UI, concessões reais, provedores ou aplicativos destinatários em aparelho. Não houve geração/execução de APK nesta etapa; o ZIP contém o projeto modificado, como nas versões anteriores. Recomenda-se testar no Android a limpeza durante consulta, miniatura e envio, o fechamento/reabertura do teclado, o Toast em telas pequenas e a nova tentativa após provedor bloqueado.

## Referência técnica
- AOSP, formato DEX e flags de acesso: https://source.android.com/docs/core/runtime/dex-format#access-flags
- Android LruCache: https://developer.android.com/reference/android/util/LruCache
