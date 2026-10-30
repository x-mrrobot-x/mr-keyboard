# 1.4.1 — Revisão da limpeza conforme documentação Android

## Implementado

### 1. Travessia NIO e validação da raiz
O helper agora usa java.nio.file.Files, disponível a partir da API 26, exatamente o minSdk deste projeto. A raiz é examinada com BasicFileAttributes e NOFOLLOW_LINKS antes da travessia. Uma raiz que seja link simbólico ou não seja diretório é recusada como pendência; uma raiz ausente é tratada como já limpa.

A travessia usa walkFileTree sem FOLLOW_LINKS. Links internos, externos, cíclicos e quebrados são tratados como entradas, sem percorrer o destino. deleteIfExists apaga o próprio link. Arquivos e links só entram na contagem quando a exclusão retorna true; links somam zero bytes, nunca o tamanho do destino. Os bytes de arquivos regulares são seus comprimentos lógicos obtidos dos atributos, não espaço físico medido no sistema.

O diretório shots é preservado. Subdiretórios vazios são removidos. Falhas de acesso, exclusão e travessia são registradas como pendências, sem anunciar limpeza completa. O registro de escritores ativos continua respeitado, incluindo subárvores protegidas. As pendências são ocorrências de erro/proteção, não necessariamente uma quantidade de arquivos distintos.

A limpeza automática de retenção também passou a usar o mesmo mecanismo seguro de travessia, com filtro de uma hora para arquivos regulares. A limpeza manual continua removendo inclusive arquivos recentes. Não foram alterados originais do MediaStore, configurações ou registros de histórico do clipboard.

O desenho pressupõe o cache privado controlado pelo aplicativo. Não é uma promessa de resistência a um processo com acesso ao mesmo diretório que substitua caminhos adversarialmente entre operações: NIO também não torna toda a sequência de filesystem atômica.

### 2. Toast curto e detalhes no painel
O Toast agora mostra apenas status, quantidade de entradas excluídas e tamanho lógico: por exemplo, “Limpos: 12 arq. • 8 MB” ou “Parcial: 12 arq. • 8 MB”. É texto padrão do sistema, sem custom Toast ou tentativa de contornar o limite de duas linhas do Android 12+.

O painel de Anexos mantém o resumo completo: arquivos/bytes, pendências, miniaturas/bytes contabilizados no LRU, listas e instruções para recarregar ou repetir a limpeza. O ícone decorativo é retirado desse estado para sobrar área de texto, e o TextView recebe rolagem vertical para telas menores. O resumo é armazenado como String, sem guardar a View; pode ser reapresentado ao reabrir o painel no mesmo processo. Um pedido explícito de categoria/Atualizar o substitui. Fechar ou recriar a interface não dispara recarga automática por causa da conclusão da limpeza.

A exclusão continua imediata e sem confirmação ou aviso prévio. O retorno parcial e os detalhes são informações posteriores à operação.

### 3. Reutilização dos executores
Foi criado um executor exclusivo de limpeza, de escopo da aplicação, independente dos pools do teclado e não encerrado no release da interface. Há no máximo um worker de limpeza, fila limitada e tratamento de rejeição que libera o bloqueio e informa resultado parcial. O worker ocioso pode terminar após 30 segundos, mas o objeto executor é reutilizado e pode criar seu worker novamente quando necessário.

Os três pools de Anexos deixaram de ser destruídos/recriados a cada limpeza. São subclasses de ThreadPoolExecutor que mantêm o registro dos threads executando tarefas, descartam a fila pendente e solicitam interrupção cooperativa dos trabalhos em andamento, sem encerrar o pool. As capacidades anteriores e a política “última consulta pendente” foram preservadas. O encerramento definitivo no release do teclado continua existindo.

O trabalho de limpeza espera, fora da UI, até dez segundos no total pela ociosidade dos pools capturados. Se alguma tarefa não responder, informa resultado parcial; não cria novos pools a cada tentativa nem apaga artificialmente a proteção do escritor. As sessões e gerações continuam invalidadas, e os monitores explícitos de publicação/miniaturas continuam impedindo resultados antigos de repovoar os caches.

Não foi acrescentado WorkManager: esta é uma operação imediata e repetível dentro do processo. Não há garantia de conclusão se o Android encerrar o processo, nem persistência do resumo após esse encerramento.

## Compatibilidade e construção dos helpers
- minSdk 26, targetSdk/compileSdk 36, mantidos.
- Files, walkFileTree, deleteIfExists, BasicFileAttributes e NOFOLLOW_LINKS são compatíveis com o minSdk.
- Mantidos Handler com Looper principal explícito e LruCache limitado a 8 MiB.
- Os três novos/revisados helpers Java puros foram compilados em Java 8, convertidos com D8 8.3.37, min-api 26, e incorporados como Smali. O código Smali do projeto é o artefato utilizado no pacote.

## Validação executada
- Montagem completa Smali → DEX e desmontagem/remontagem: sem erros.
- 17 grupos estáticos anteriores de Anexos: passaram.
- Fluxo original-URI-primeiro/fallback e nova checagem estática da limpeza: passaram.
- Scanner limitado de constantes em referências: 1.745 usos examinados, sem violações detectadas.
- Retenção: 20 verificações JVM passaram.
- NIO de produção: 26 verificações JVM passaram, incluindo links externos, quebrados, cíclicos, raiz link/não diretório, ausência da raiz, falha real por permissão, escritores ativos, retry e retenção automática.
- Coordenador de produção: 22 verificações JVM passaram, incluindo resultado parcial, Toast curto/detalhes, cliques concorrentes, filesystem indisponível, Handler que recusa postagem, executor que recusa trabalho e Context ausente.
- Métodos de produção do controlador: 17 verificações JVM passaram, incluindo reutilização dos mesmos três pools, limpeza da grade/listas/LRU, monitores compartilhados, contagem e recusa de resultados antigos.
- Pools reutilizáveis e executor de limpeza: 15 verificações JVM passaram, incluindo interrupção cooperativa, remoção da fila, reutilização do mesmo thread, política de consulta, limitação da fila de limpeza e reutilização do executor.
- Envio direto: 17 verificações JVM anteriores continuaram passando.
- Total: 117 verificações JVM, além das análises estáticas e do roundtrip DEX.
- ZIP conferido por CRC e comparação com todos os arquivos do projeto durante o empacotamento.

Os testes executam os helpers/métodos de produção traduzidos de DEX para JVM. Componentes Android são simulados quando necessário. Não validam ART, renderização real, MediaStore, permissões entre aplicativos ou comportamento de provedores reais. Não houve execução do APK em emulador ou aparelho nesta etapa.

## Testes Android ainda necessários
1. API 26: iniciar teclado, abrir as três categorias, enviar e limpar; verificar ausência de falhas de linkage/verificação de classes NIO.
2. APIs 31 e 36: conferir o Toast curto em tela estreita, fonte ampliada e paisagem; verificar rolagem do resumo completo.
3. Durante consulta, miniatura e cópia: limpar, aguardar o resultado e confirmar que resultados antigos não repovoam a grade.
4. Limpar repetidas vezes; confirmar que consultas/envios posteriores funcionam sem crescimento contínuo de pools.
5. Fechar/reabrir ou recriar o teclado durante a limpeza; verificar conclusão no painel atual ou reapresentação do resumo, sem recarga automática.
6. Provedor que bloqueia/interrompe I/O: conferir resultado parcial, nova tentativa após liberar o provedor e preservação do original.
7. Encerrar o processo durante a operação: não esperar conclusão garantida; reabrir e repetir manualmente se necessário.
8. Verificar envio direto, fallback de cópia e histórico do clipboard, lembrando que URIs de cópias apagadas deixam de funcionar conforme solicitado.

## Documentação oficial utilizada
- Cache privado e exclusão de arquivos: https://developer.android.com/training/data-storage/app-specific
- Files/NIO: https://developer.android.com/reference/java/nio/file/Files
- Threads Java e reutilização de pools: https://developer.android.com/develop/background-work/background-tasks/asynchronous/java-threads
- Interrupção best-effort e encerramento: https://developer.android.com/reference/java/util/concurrent/ExecutorService
- Toasts e limite de duas linhas: https://developer.android.com/guide/topics/ui/notifiers/toasts
- Trabalho persistente/WorkManager: https://developer.android.com/develop/background-work/background-tasks/persistent
