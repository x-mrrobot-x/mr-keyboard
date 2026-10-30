# Revisão 1.0.2 — alinhamento e memória

## Implementado
- Cache de métricas por LatinKeyboardBaseView, criado sob demanda e descartado em closing(), também chamado por onDetachedFromWindow().
- Limite fixo de 128 entradas, substituição circular. Não é LRU: evita criar chaves compostas e nós de lista durante desenhos.
- Guarda deslocamentos relativos, não coordenadas absolutas: redimensionar a tecla não reutiliza uma posição antiga.
- Mantém a política de alinhamento da 1.0.1: letras/números usam H como referência; símbolos usam os próprios limites.
- Acertos reutilizam as medidas sem construir Rect, Paint, Float ou chave concatenada. Rect de trabalho reutilizado por instância. Paint é copiado apenas em faltas.
- A identidade de medição usa Paint.equalsForTextMeasurement a partir da API 28. Em APIs 26/27 compara tamanho, escala, inclinação, flags, hinting, altura elegante, Typeface, locales, letterSpacing, fontFeatureSettings e fontVariationSettings. O projeto declara minSdk 26.
- Cache antigo de alturas também limpo ao fechar.
- Miniaturas: tarefas passam a guardar WeakReference<ImageView>, verificam a referência e o identificador da célula antes de aplicar. Ao concluir, soltam referências à View e ao Bitmap. Isso não cancela tarefas nem resolve toda a fila de trabalhos.
- Cache de miniaturas limitado a 8 MiB de alocações de Bitmap, no lugar de 36 entradas de tamanho variável. Não chama recycle(), pois uma imagem removida do cache ainda pode estar sendo exibida. O limite não inclui bitmaps nas Views ou trabalhos em andamento.

## Escopo e riscos restantes
Revisão estática direcionada a renderização, caches, tarefas de miniaturas e encerramento da View; não é auditoria exaustiva do aplicativo.
Foram observadas referências estáticas ao serviço, barras e controles em MrTools/MrShots/MrTune, e listener de clipboard sem remoção correspondente em onDestroy(). São riscos de retenção que permanecem nesta versão. Alterar esse ciclo exige coordenar recriação do serviço, callbacks e trabalhos ativos; não foi feita uma limpeza indiscriminada que poderia introduzir falhas e corridas.
O executor de miniaturas continua usando fila sem limite explícito. Não foi alterada a política de agendamento nesta revisão.
O cache de medidas é exclusivo do desenho na thread de UI, sem sincronização e sem referências a Context, Activity ou View. Paints podem reter fontes, limitadas pelas 128 entradas e pelo ciclo de vida da View.

## Validação realizada
- Todo o diretório smali montado com smali 2.5.2 para DEX, sem erros de montagem.
- XMLs modificados nas versões anteriores analisados como XML.
- Integridade do ZIP verificada.
- Compatibilidade dos métodos Paint conferida na referência oficial.
A montagem DEX não substitui verificação do ART, compilação completa do APK ou teste no aparelho.

## Validação pendente no Android
1. Digitar repetidamente, segurar setas, alternar Shift e símbolos.
2. Alterar tamanho, fonte, tema, orientação e largura do teclado.
3. Percorrer Anexos rapidamente, trocar Fotos/Vídeos/Arquivos e fechar/reabrir o teclado durante cargas.
4. Recriar/destruir o serviço repetidamente, inspecionando heap dumps e caminhos de retenção.
5. Medir frame times, alocações e pausas de GC antes/depois. Não há benchmark nem prova de ausência de vazamentos nesta entrega.

## Referências
- https://developer.android.com/reference/android/graphics/Paint#equalsForTextMeasurement(android.graphics.Paint)
- https://developer.android.com/reference/android/util/LruCache
- https://developer.android.com/reference/java/lang/ref/WeakReference
