# 1.3.0 — URI original primeiro, cópia como fallback

## Novo fluxo
1. Ao selecionar um anexo, captura o destino atual por referência fraca à InputConnection e pelo nome do pacote. Nenhuma cópia é iniciada nesse momento.
2. Em worker, prepara a URI original de Fotos/Vídeos/Arquivos, confere abertura para leitura e determina o MIME. Fecha o AssetFileDescriptor sem copiar o conteúdo para o cache.
3. Na thread de UI, confirma que o destino continua sendo o capturado. Tenta commitContent com a URI original por meio do helper existente de compatibilidade/MIME e pedido de permissão de leitura.
4. Se a inserção for recusada ou lançar Exception, tenta ACTION_SEND explícito ao pacote atual com a URI original em EXTRA_STREAM e ClipData e FLAG_GRANT_READ_URI_PERMISSION.
5. Se a entrega direta for aceita, encerra sem criar/reutilizar uma cópia privada do anexo.
6. Se a URI não puder ser preparada, ou ambas as tentativas diretas forem recusadas/falharem de forma detectável, envia o trabalho para o executor de cópias. Mantém o fallback anterior: cópia privada reutilizável quando válida, FileProvider, inserir/compartilhar e, em último caso, clipboard.

## Permissões e segurança
- Não assume que a permissão de armazenamento do teclado é automaticamente transferida para o destinatário. As APIs de commitContent e os flags/ClipData do Intent solicitam ao Android a concessão apropriada. Recusas detectáveis levam à cópia.
- Não faz concessão explícita duradoura com grantUriPermission(). O compartilhamento usa as concessões temporárias associadas pelo Android à entrega via Intent; o ciclo de vida dessas permissões é controlado pelo sistema.
- O clipboard continua usando cópia privada: o próximo aplicativo a colar não é conhecido no momento da seleção.
- O destino é conferido tanto antes de tentar o envio original quanto antes de entregar uma cópia que terminou depois. Se mudou, cancela a entrega e pede que o usuário selecione novamente, em vez de inserir no campo novo.
- Dados para os workers não incluem uma referência forte ao serviço, à View ou à conexão de entrada. Mantém as verificações de sessão anteriores.
- Não transforma nem altera o original e não cria um arquivo temporário no caminho direto. Abrir o descritor ainda é uma operação de I/O do provedor, não uma promessa de latência zero.

## Limitações importantes
Retorno true de commitContent ou retorno sem exceção de startActivity significa aceitação da entrega, não confirmação de que o outro aplicativo leu tudo. Se o destinatário aceitar e falhar só depois, o teclado não recebe necessariamente um callback de erro. Não há fallback automático garantido nesse caso nem tentativa automática duplicada após aceitação.
O arquivo original precisa continuar disponível enquanto o destinatário o utiliza. Exclusão/alteração posterior do original não é impedida pelo teclado.

## Cache
O prazo de uma hora vale para as cópias de fallback, incluindo clipboard, compartilhamento e inserção. Não se aplica ao arquivo original, que não pertence ao teclado.
A política de reutilização, nomes únicos, proteção de cópias ativas e renovação na entrega foi preservada. A limpeza oportunista de cópias vencidas também é executada pelo worker de preparação direta, para não depender de futuras cópias quando o caminho direto passa a funcionar.
Os caches de listas (15 s) e miniaturas (8 MiB) foram mantidos.
O documento 1.2.0 descreve a versão anterior: sua observação de que não havia caminho direto foi superada por esta versão.

## Validação realizada
- Smali completo montado para DEX e DEX desmontado/remontado sem erros.
- Checagem estática limitada para constantes indevidas em campos de referência.
- Verificações estáticas de que a seleção começa pela preparação direta, de que essa preparação não chama as rotinas de cópia, da ordem inserir/compartilhar/fallback, da proteção de destino e dos flags/ClipData.
- 17 grupos de verificações estáticas anteriores de Anexos mantidos.
- Helper MrDirectSend montado isoladamente e traduzido de DEX para JVM: 17 verificações passaram com componentes Android simulados, cobrindo aceitação de inserção sem share, URI original preservada, MIME/pacote/flags/ClipData, recusa de concessão, exceção de commit, ausência de editor/URI/MIME e recusa de compartilhamento com o próprio teclado.
- Os 20 testes JVM do helper de retenção também continuaram passando.
- Integridade do ZIP verificada.

Os testes JVM usam stubs para Android e não exercitam as concessões reais do sistema, o MediaStore ou os aplicativos destinatários. Não houve execução do APK em aparelho nem confirmação de compatibilidade com aplicativos específicos. São necessários testes de inserção e compartilhamento com Fotos, Vídeos e Arquivos, incluindo erros de acesso, troca de campo durante a preparação e fallback para clipboard.
