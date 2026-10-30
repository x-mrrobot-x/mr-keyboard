# 1.2.0 — retenção uniforme de cópias por uma hora

## Política atual
- Inserção direta no campo, compartilhamento e clipboard usam o mesmo prazo: uma hora desde a última entrega/reutilização registrada da cópia.
- O timestamp é renovado após a entrega aceita por um desses caminhos. Uma reutilização também renova antes da tentativa, evitando entregar uma cópia prestes a expirar.
- A aceitação da entrega não comprova que o destinatário terminou de ler. Uma hora é uma política escolhida, não uma garantia universal de compatibilidade.
- Não há exclusão imediata da cópia anterior quando uma nova é criada.
- O helper referencia uma cópia mais recente por categoria (Fotos, Vídeos, Arquivos), candidata a reutilização quando o ID, tamanho e data de modificação da origem correspondem. Se os metadados não puderem ser conferidos, faz outra cópia.
- As cópias anteriores continuam em disco durante seu próprio prazo de segurança. Portanto, não é um limite rígido de três arquivos nem um limite de bytes.
- Os arquivos vencidos são removidos de forma oportunista quando uma nova operação de cópia/reutilização prepara o cache. Não existe temporizador exato de exclusão nem limpeza periódica em segundo plano.
- O Android ainda pode remover o cache por necessidade de armazenamento; o prazo não torna o cache persistente.

## Segurança das cópias
- Novas cópias recebem um subdiretório UUID dentro de cache/shots. Mesmo nomes iguais não sobrescrevem uma cópia já entregue a outro aplicativo.
- Mantém o nome do arquivo dentro do subdiretório, removendo componentes de caminho e tratando nomes inválidos.
- Usa arquivo .part, fecha streams em sucesso/falha e só publica o destino depois que renameTo confirma sucesso. Falha de rename não é anunciada como cópia concluída.
- Diretórios com cópia em andamento são registrados em um mapa sem Context/View e ignorados pela limpeza. A proteção é retirada nos caminhos de sucesso e falha.
- A limpeza percorre os subdiretórios UUID e também arquivos legados da pasta shots, removendo arquivos vencidos e diretórios vazios.
- Uma cópia concluída é reutilizável apenas enquanto existe, não está vazia, não venceu e a verificação de metadados da origem coincide. Os metadados não são um hash do conteúdo: alterações que não mudem tamanho/data informados pelo provedor podem não ser percebidas.
- Consultas de metadados e limpeza ocorrem nos workers de cópia, não durante as buscas da grade. Na entrega, a UI apenas renova o timestamp do arquivo, sem percorrer diretórios.

## Escopo
Esta versão altera retenção, reutilização e segurança dos caminhos de cópia. O fluxo de entrega continua preparando uma cópia privada antes das tentativas de inserir/compartilhar/clipboard. A estratégia opcional de tentar a URI original sem copiar não foi adicionada nesta entrega.
O cache de miniaturas (8 MiB) e o cache das listas (15 s) não foram alterados.

## Validação
- Smali completo montado para DEX; DEX desmontado e remontado sem erros.
- Checagem estática limitada de constantes em campos de referência: sem violações detectadas.
- Mantidos os 17 grupos de verificações estáticas de Anexos.
- O Smali de MrCopyRetention foi montado separadamente e traduzido de DEX para bytecode JVM para executar o helper real. Foram aprovadas 20 verificações, incluindo expiração, preservação de arquivos novos, proteção de cópias ativas, remoção de diretórios vazios, nomes únicos, isolamento por categoria/ID, renovação do prazo, preservação da anterior e invalidação da reutilização por metadados alterados/indisponíveis.
- Nos testes JVM, o contexto Android e a consulta de versão da origem foram substituídos por stubs. O MediaStore real e a entrega entre aplicativos não foram executados.
- Integridade do ZIP verificada.

## Testes ainda necessários no Android
Enviar fotos, vídeos e documentos por cada caminho; repetir o mesmo anexo; modificar a origem; enviar arquivos de mesmo nome; recriar o serviço durante cópia; conferir URIs e leitura pelos destinatários. Medir espaço e tempo real com arquivos grandes. Não há teste em aparelho, heap dump ou garantia de leitura após o prazo.
