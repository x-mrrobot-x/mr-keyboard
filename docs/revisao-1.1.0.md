# 1.1.0 — resposta mais rápida em Anexos

## Comportamento
- Fotos, Vídeos e Arquivos têm snapshots independentes com até 60 resultados por categoria. São arrays de IDs e, em Arquivos, nomes e MIME types; não guardam Views ou Contexts.
- Retornar a uma categoria com snapshot mostra os dados imediatamente. Na atualização da mesma categoria, a grade não é apagada.
- Um snapshot tem validade de 15 segundos, medida por elapsedRealtime(). Após esse prazo, continua sendo mostrado enquanto uma nova consulta acontece.
- Não há temporizador de busca. A validade é avaliada ao abrir Anexos ou tocar numa categoria.
- Atualizar e recarregar após o fluxo de permissões ignoram a validade do cache. Uma consulta da mesma categoria já pendente é compartilhada, em vez de duplicada.
- Falhas de consulta não substituem um snapshot bom por uma lista vazia. Se não houver conteúdo, o estado vazio permite tentar novamente.
- A posição de rolagem de cada categoria é lembrada durante a sessão. Atualizar a mesma categoria não força voltar ao início.

## Consultas, cópias e miniaturas
- Um executor exclusivo executa consultas: um worker e uma vaga pendente com política de manter a mais recente. Pedidos consecutivos da mesma categoria são agrupados; pedidos pendentes superados são descartados.
- Cópias continuam em outro executor limitado. Uma cópia longa não ocupa o worker de consultas.
- Cada consulta captura sua categoria no momento da criação. A troca de aba não altera o tipo da consulta em execução.
- Geração e categoria são conferidas antes de mostrar o resultado. Um resultado de Vídeos não pode substituir Fotos quando o usuário já voltou a Fotos, mesmo que Fotos tenha sido atendido pelo cache sem nova consulta.
- Uma consulta antiga que já começou pode terminar e alimentar apenas o cache de sua própria categoria. Não há promessa de cancelamento instantâneo de uma consulta ativa.
- Ao mudar de categoria, a fila de miniaturas da aba anterior é limpa e sua geração é invalidada.
- Um listener de rolagem remove miniaturas pendentes de células recicladas ou fora da área visível. As inspeções de View acontecem na thread principal, não na thread de decodificação. Trabalhos já ativos podem terminar e beneficiar o cache.
- Antes de decodificar, o worker confere novamente o cache, evitando parte das decodificações repetidas quando outro trabalho já concluiu a imagem.
- Não foi implementado um registro global de deduplicação de toda decodificação em andamento. Duas tarefas simultâneas ainda podem iniciar a mesma imagem antes de existir um resultado no cache.

## MediaStore
- As projeções existentes foram preservadas: 1 coluna para Vídeos, 6 para Fotos e 5 para Arquivos, necessárias para seus critérios atuais.
- Solicita limites no provedor via argumentos Bundle disponíveis desde a API 26: 60 vídeos, 1.000 candidatos a fotos e 2.000 candidatos a arquivos.
- Mantém os filtros, a ordenação por data e os critérios de prioridade existentes; seleciona até 60 resultados finais por categoria.
- Provedores que rejeitam a consulta Bundle usam a consulta anterior como fallback. Provedores que ignoram o limite continuam sujeitos ao limite de iteração no cliente.
- Cursor nulo é tratado como falha, não como uma lista vazia válida.

## Memória e permissões
- Os snapshots e o novo executor são liberados com a sessão de Anexos, inclusive ao substituir a View.
- Permanecem as proteções da 1.0.3: filas limitadas, WeakReference para miniaturas, cache de imagens de 8 MiB e descarte de callbacks de sessões encerradas.
- A verificação de permissões existente ocorre antes de mostrar o cache e novamente ao aplicar resultados. Ao detectar ausência de permissão, limpa os snapshots e a lista apresentada.
- O cache é somente em memória. Recriar a View ou destruir o serviço descarta os snapshots; não há banco novo ou serviço periódico.

## Validação realizada
- Montagem completa do Smali para DEX sem erros.
- Desmontagem e remontagem do DEX sem erros.
- 17 grupos de verificações estáticas do código alterado: roteamento dos executores, captura da categoria, uso do cache, validade monotônica, preservação de rolagem, descarte de resultados antigos, proteção por permissões e referências aos helpers.
- Verificação de integridade do ZIP.

Não houve execução do APK no Android, heap dump ou benchmark. As verificações acima não equivalem a testes de integração ou validação do ART.

## Testes no aparelho
1. Abrir Fotos, visitar Vídeos e Arquivos e voltar: verificar cache imediato da categoria correta.
2. Dentro de 15 s, abrir/tocar na mesma aba: não deve iniciar outra consulta, salvo Atualizar.
3. Depois de 15 s, abrir a aba: conteúdo antigo permanece durante a nova consulta.
4. Atualizar durante uma cópia grande: consulta não deve aguardar a cópia no mesmo worker.
5. Alternar rapidamente Fotos/Vídeos/Arquivos, inclusive voltando a uma aba com cache recente enquanto outra consulta está ativa.
6. Rolar rapidamente e depois parar: conferir miniaturas das células visíveis e ausência de imagens trocadas.
7. Revogar/conceder permissões; recriar o serviço e girar a tela durante cargas.
8. Medir tempo até o primeiro conteúdo, duração das consultas, frame times e memória com grandes bibliotecas.
