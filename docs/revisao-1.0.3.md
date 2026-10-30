# Revisão 1.0.3 — ciclo de vida e trabalho assíncrono

## Correções
- LatinIME.onDestroy remove o listener de SharedPreferences, cancela mensagens do seu Handler, libera as ferramentas e limpa sInstance apenas se ainda for a instância encerrada.
- KeyboardSwitcher.release verifica a identidade do serviço, remove seu listener de preferências, fecha a View, limpa o mapa de teclados e solta referências ao serviço, à View e ao LanguageSwitcher. Reinicia o indicador de largura para reconstrução.
- RingCharBuffer.release verifica o Context dono, reinicia o buffer, desativa a coleta e limpa o Context. Não usa applicationContext nesse buffer porque seu código precisa de LatinIME.isWordSeparator().
- MrTools.release remove o listener de clipboard, cancela callbacks pendentes, encerra o executor de tradução, libera controles/adaptadores/Drawables/InputConnection e limpa as referências de MrTune e MrEmotes. Reseta sInited para que a recriação registre corretamente o listener e refaça a inicialização.
- Os métodos de release verificam propriedade ou aceitam repetição. A destruição tardia de um serviço antigo não deve limpar o serviço novo nas rotinas que verificam identidade.
- O Application Context e um Handler simples da main thread são mantidos intencionalmente. Não contêm referências ao serviço/View; permitem que um trabalho antigo termine e poste uma conclusão que será descartada pela sessão.

## Tarefas e filas
- MrShots identifica cada tarefa com um número de sessão. A sessão muda antes de liberar a interface, e a execução de callbacks antigos é descartada antes de acessar os controles.
- A substituição da View via setup também encerra a sessão de Anexos anterior, limpa caches e cria executores novos.
- Consultas, carregamentos e cópias usam Application Context, não LatinIME. Uma operação já em andamento que ignore interrupção não precisa reter o serviço para terminar.
- Anexos: um worker para consultas/cópias, fila de 8 tarefas; dois workers para miniaturas, fila de 64. Saturação não executa trabalho pesado na UI. Miniaturas rejeitadas poderão ser solicitadas novamente quando a célula for vinculada; consultas/cópias rejeitadas avisam para tentar novamente e liberam sBusy.
- shutdownNow remove os trabalhos ainda na fila e solicita interrupção aos ativos. Não é uma garantia de cancelamento imediato de chamadas bloqueantes de ContentResolver/MediaStore.
- A tradução deixa de criar uma Thread a cada pedido. Usa um worker, fila de uma tarefa e DiscardOldestPolicy: mantém o pedido pendente mais recente. Os números de sequência e sessão impedem resultados antigos de atualizar a interface.
- Uma conclusão de tradução conserva a sessão de origem, mesmo se for criada após a destruição/recriação do serviço.
- Cópias verificam interrupção entre blocos; helper fecha ambos os streams mesmo em falhas de abertura/escrita e remove o arquivo parcial quando a cópia falha. Não é garantia de interrupção instantânea de uma leitura bloqueada.
- O cache de miniaturas continua limitado a 8 MiB, sem recycle() de imagens que podem estar em uso. A inserção por tarefa antiga é protegida por verificação de sessão; não se promete cancelamento atômico de toda operação já em andamento.

## Validação executada
1. Montagem de todos os Smali com smali 2.5.2 para DEX, sem erros.
2. Desmontagem do DEX com baksmali e remontagem, sem erros.
3. Inspeção das rotas de encerramento e dos métodos de mídia em background para não dependerem do serviço.
4. Verificação de integridade do ZIP.

Esses testes não executam ART, Android Framework ou um APK instalado. Não houve heap dump, benchmark ou teste de corrida no aparelho. Não constituem prova de ausência de vazamentos no aplicativo inteiro.

## Testes necessários no aparelho
- Recriar o serviço várias vezes e verificar que clipboard, preferências, tradução e Anexos continuam funcionando.
- Alternar layouts/tema/orientação durante cargas de miniaturas.
- Fechar/destruir o serviço durante consulta, tradução e cópia; conferir que não há entrega tardia nem crash.
- Rolar Anexos rapidamente e saturar consultas para observar o comportamento de fila cheia e tentar novamente.
- Inspecionar heap após GC, verificando os caminhos MrTools, MrShots, MrTune, MrEmotes, KeyboardSwitcher e RingCharBuffer até o serviço antigo.

O documento 1.0.2 descreve o estado anterior. Os riscos nele listados de referências estáticas, listeners e filas foram tratados nesta revisão nos caminhos examinados.
