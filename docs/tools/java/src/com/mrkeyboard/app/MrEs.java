package com.mrkeyboard.app;

import android.content.Context;
import java.util.HashMap;
import java.util.Locale;

/**
 * Fixed texts in the code (sheet editor, special-key picker, attachments) that exist only in
 * Portuguese in the smali: here are the Spanish versions (and, for what was Portuguese only, English).
 * On the screens, the smali uses the Portuguese text and passes it through SheetStrings.p(), which switches to Spanish
 * when the app language is Spanish. The keys must be equal to the Portuguese text in the smali;
 * docs/tools/mres_check.py checks this and lists Portuguese texts that were left untranslated.
 */
public final class MrEs {
    private MrEs() { }

    private static final HashMap<String, String> ES = new HashMap<String, String>();
    private static final HashMap<String, String> EN = new HashMap<String, String>();

    static {
        e("Informe o texto ou r\u00f3tulo da tecla.", "Indica el texto o la etiqueta de la tecla.");
        e("Informe o nome do comando Tasker.", "Indica el nombre del comando de Tasker.");
        e("Largura proporcional: ", "Ancho proporcional: ");
        e("Lista de teclas (", "Lista de teclas (");
        e("Caracteres: ", "Caracteres: ");
        e("Nenhum (toque para configurar)  \u25b8", "Ninguno (toca para configurar)  \u25b8");
        e("Folha anterior (ciclo)", "Hoja anterior (ciclo)");
        e("ABC \u2014 Teclado principal", "ABC \u2014 Teclado principal");
        e("Pr\u00f3xima folha (ciclo)", "Hoja siguiente (ciclo)");
        e("Editar item do popup", "Editar elemento del popup");
        e("Editar tecla", "Editar tecla");
        e("Tipo de a\u00e7\u00e3o", "Tipo de acci\u00f3n");
        e("Separador", "Separador");
        e("R\u00f3tulo vis\u00edvel na tecla", "Etiqueta visible en la tecla");
        e("Texto exibido no bot\u00e3o (auto se vazio)", "Texto que se muestra en el bot\u00f3n (autom\u00e1tico si est\u00e1 vac\u00edo)");
        e("Texto inserido ao tocar", "Texto que se inserta al tocar");
        e("Caractere, tag HTML ou frase completa...", "Car\u00e1cter, etiqueta HTML o frase completa...");
        e("Comando Tasker (prefixo tskcmd: autom\u00e1tico)", "Comando de Tasker (prefijo tskcmd: autom\u00e1tico)");
        e("Ex.: wifi, bt, flash, meu_perfil", "Ej.: wifi, bt, flash, mi_perfil");
        e("Tecla especial selecionada", "Tecla especial seleccionada");
        e("Folha de destino", "Hoja de destino");
        e("Cria um espa\u00e7o vazio invis\u00edvel nesta posi\u00e7\u00e3o do teclado real. Use o controle de largura abaixo para definir o tamanho do v\u00e3o.", "Crea un espacio vac\u00edo invisible en esta posici\u00f3n del teclado real. Usa el control de ancho de abajo para definir el tama\u00f1o del hueco.");
        e("Toque longo (popup)", "Toque largo (popup)");
        e("Salvar", "Guardar");
        e("Cancelar", "Cancelar");
        e("Duplicar", "Duplicar");
        e("Excluir", "Eliminar");
        e("Escolher folha de destino", "Elegir hoja de destino");
        e("Itens do popup (", "Elementos del popup (");
        e("Limite m\u00e1ximo de 10 itens no popup.", "L\u00edmite m\u00e1ximo de 10 elementos en el popup.");
        e("Ir para: ", "Ir a: ");
        e("Texto: ", "Texto: ");
        e("Popup no toque longo", "Popup en el toque largo");
        e("Escolha o que abre ao segurar esta tecla pressionada:", "Elige qu\u00e9 se abre al mantener presionada esta tecla:");
        e("Nenhum", "Ninguno");
        e("Caracteres", "Caracteres");
        e("Teclas / A\u00e7\u00f5es", "Teclas / Acciones");
        e("Digite uma sequ\u00eancia de caracteres (cada letra vira um bot\u00e3o no popup, ex.: \u00e1\u00e0\u00e2\u00e3\u00e4):", "Escribe una secuencia de caracteres (cada letra se convierte en un bot\u00f3n en el popup, ej.: \u00e1\u00e0\u00e2\u00e3\u00e4):");
        e("Ex.: \u00b9\u00b2\u00b3\u00a3\u00a2\u20ac\u00a5", "Ej.: \u00b9\u00b2\u00b3\u00a3\u00a2\u20ac\u00a5");
        e("+ Adicionar item ao popup", "+ Agregar elemento al popup");
        e("Nenhum popup ser\u00e1 exibido ao segurar esta tecla.", "No se mostrar\u00e1 ning\u00fan popup al mantener presionada esta tecla.");
        e("Concluir", "Listo");
        e("Folha restaurada.", "Hoja restablecida.");
        e("Todas as folhas foram restauradas para o padr\u00e3o.", "Todas las hojas se restablecieron a los valores predeterminados.");
        e("Importadas ", "Se importaron ");
        e(" folhas!", " hojas!");
        e("JSON inv\u00e1lido: ", "JSON no v\u00e1lido: ");
        e("Teclado principal (fixo)", "Teclado principal (fijo)");
        e("Layout alfab\u00e9tico padr\u00e3o do idioma ativo", "Dise\u00f1o alfab\u00e9tico est\u00e1ndar del idioma activo");
        e("Padr\u00e3o", "Integrada");
        e("Personalizada", "Personalizada");
        e(" fileiras \u2022 ", " filas \u2022 ");
        e(" teclas \u2022 ", " teclas \u2022 ");
        e("Excluir folha?", "\u00bfEliminar la hoja?");
        e("Tem certeza que deseja excluir \"", "\u00bfSeguro que quieres eliminar \"");
        e("Restaurar todas as folhas?", "\u00bfRestablecer todas las hojas?");
        e("Isso restaurar\u00e1 as 4 folhas originais (123, TSK, HTML, FRS) e remover\u00e1 folhas personalizadas. Dica: voc\u00ea pode exportar um backup JSON antes.", "Esto restablecer\u00e1 las 4 hojas originales (123, TSK, HTML, FRS) y quitar\u00e1 las hojas personalizadas. Consejo: puedes exportar una copia de seguridad JSON antes.");
        e("Restaurar tudo", "Restablecer todo");
        e("Restaurar folha padr\u00e3o?", "\u00bfRestablecer la hoja predeterminada?");
        e("Restaurar \"", "\u00bfRestablecer \"");
        e("\" ao layout original?", "\" a su dise\u00f1o original?");
        e("Restaurar", "Restablecer");
        e("Limite m\u00e1ximo de 12 folhas atingido.", "Se alcanz\u00f3 el l\u00edmite m\u00e1ximo de 12 hojas.");
        e(" (c\u00f3pia)", " (copia)");
        e("Copiar teclas de qual folha?", "\u00bfDe qu\u00e9 hoja copiar las teclas?");
        e("Num\u00e9rico", "Num\u00e9rico");
        e("Navega\u00e7\u00e3o", "Navegaci\u00f3n");
        e("Folha ", "Hoja ");
        e("Nome da folha:", "Nombre de la hoja:");
        e("Selo curto no bot\u00e3o (1 a 5 caracteres):", "Sello corto en el bot\u00f3n (1 a 5 caracteres):");
        e("Nova folha", "Nueva hoja");
        e("Criar e editar", "Crear y editar");
        e(" folhas \u2022 Toque para editar teclas", " hojas \u2022 Toca para editar teclas");
        e("Nenhuma folha ativa (apenas o teclado principal ABC).\nToque em \"+ Nova folha\" ou em \u22ee \u2192 \"Restaurar todas para o padr\u00e3o\".", "Ninguna hoja activa (solo el teclado principal ABC).\nToca \"+ Nueva hoja\" o \u22ee \u2192 \"Restablecer todas a los valores predeterminados\".");
        e("Editar teclas", "Editar teclas");
        e("Renomear nome e selo", "Renombrar nombre y sello");
        e("Mover para cima", "Mover hacia arriba");
        e("Mover para baixo", "Mover hacia abajo");
        e("Duplicar folha", "Duplicar hoja");
        e("Restaurar padr\u00e3o", "Restablecer valores predeterminados");
        e("Excluir folha", "Eliminar hoja");
        e("Exportar folhas (JSON)", "Exportar hojas (JSON)");
        e("Importar folhas (JSON)", "Importar hojas (JSON)");
        e("Restaurar todas para o padr\u00e3o", "Restablecer todas a los valores predeterminados");
        e("Backup e restaura\u00e7\u00e3o", "Copia de seguridad y restauraci\u00f3n");
        e("Em branco (3 fileiras vazias)", "En blanco (3 filas vac\u00edas)");
        e("Teclado num\u00e9rico (Numpad)", "Teclado num\u00e9rico (Numpad)");
        e("Setas + Edi\u00e7\u00e3o (Home/End/PgUp/PgDn/Tab/Esc)", "Flechas + Edici\u00f3n (Home/End/PgUp/PgDn/Tab/Esc)");
        e("Copiar de folha existente...", "Copiar de una hoja existente...");
        e("Modelo da nova folha", "Plantilla de la nueva hoja");
        e("Selo curto no bot\u00e3o (at\u00e9 5 caracteres):", "Sello corto en el bot\u00f3n (hasta 5 caracteres):");
        e("Renomear folha", "Renombrar hoja");
        e("Folhas exportadas com sucesso!", "\u00a1Hojas exportadas correctamente!");
        e("Erro ao exportar: ", "Error al exportar: ");
        e("Importar folhas do arquivo?", "\u00bfImportar hojas desde el archivo?");
        e("Foram encontradas ", "Se encontraron ");
        e(" folha(s) v\u00e1lidas. Elas substituir\u00e3o a lista atual.", " hoja(s) v\u00e1lida(s). Reemplazar\u00e1n la lista actual.");
        e("Importar", "Importar");
        e("Arquivo JSON inv\u00e1lido: ", "Archivo JSON no v\u00e1lido: ");
        e("Voltar", "Atr\u00e1s");
        e("Folhas do teclado", "Hojas del teclado");
        e("Mais op\u00e7\u00f5es", "M\u00e1s opciones");
        e("FOLHAS EDIT\u00c1VEIS (ORDEM DO CICLO)", "HOJAS EDITABLES (ORDEN DEL CICLO)");
        e("+ Nova folha", "+ Nueva hoja");
        e("Exportar JSON", "Exportar JSON");
        e("Importar JSON", "Importar JSON");
        e("Folha exclu\u00edda.", "Hoja eliminada.");
        e("Folha restaurada para o padr\u00e3o.", "Hoja restablecida a los valores predeterminados.");
        e("Fileira ", "Fila ");
        e(" teclas)", " teclas)");
        e("Limite m\u00e1ximo de 6 fileiras edit\u00e1veis atingido.", "Se alcanz\u00f3 el l\u00edmite m\u00e1ximo de 6 filas editables.");
        e("A tecla Apagar (\u232b) no canto inferior direito \u00e9 fixa por seguran\u00e7a.", "La tecla Borrar (\u232b) de la esquina inferior derecha es fija por seguridad.");
        e("A fileira inferior do sistema \u00e9 fixa em todas as folhas.", "La fila inferior del sistema es fija en todas las hojas.");
        e("CAMPO DE TESTE R\u00c1PIDO", "CAMPO DE PRUEBA R\u00c1PIDA");
        e("Limpar", "Borrar");
        e("Toque aqui para abrir o teclado e testar esta folha ao vivo...", "Toca aqu\u00ed para abrir el teclado y probar esta hoja en vivo...");
        e("As edi\u00e7\u00f5es s\u00e3o aplicadas na hora \u2022 Troque para esta folha no teclado para testar.", "Los cambios se aplican al instante \u2022 Cambia a esta hoja en el teclado para probar.");
        e("Todas as edi\u00e7\u00f5es feitas nesta folha voltar\u00e3o ao layout original de f\u00e1brica.", "Todos los cambios hechos en esta hoja volver\u00e1n al dise\u00f1o original de f\u00e1brica.");
        e("Folha duplicada! Editando a nova c\u00f3pia.", "\u00a1Hoja duplicada! Editando la nueva copia.");
        e("Nada para desfazer.", "Nada que deshacer.");
        e("Altera\u00e7\u00e3o desfeita.", "Cambio deshecho.");
        e(" teclas", " teclas");
        e("AO VIVO \u2022 ", "EN VIVO \u2022 ");
        e("Gerenciar fileiras edit\u00e1veis", "Administrar filas editables");
        e("Fechar", "Cerrar");
        e("Gerenciar fileiras...", "Administrar filas...");
        e("Duplicar esta folha", "Duplicar esta hoja");
        e("Restaurar padr\u00e3o desta folha", "Restablecer los valores de esta hoja");
        e("Excluir esta folha", "Eliminar esta hoja");
        e("Selo curto no teclado (1 a 5 caracteres):", "Sello corto en el teclado (1 a 5 caracteres):");
        e("\u21b6 Desfazer", "\u21b6 Deshacer");
        e("Toque em uma tecla para editar \u2022 Segure e arraste para mover \u2022 Toque em '+' para adicionar", "Toca una tecla para editarla \u2022 Mant\u00e9n y arrastra para moverla \u2022 Toca '+' para agregar");
        e("+ Nova fileira", "+ Nueva fila");
        e("\u21c5 Fileiras", "\u21c5 Filas");
        e("\u270e Nome/Selo", "\u270e Nombre/Sello");
        e("+ Adicionar tecla", "+ Agregar tecla");
        e("Nenhuma tecla encontrada.", "No se encontr\u00f3 ninguna tecla.");
        e("C\u00f3digo inteiro inv\u00e1lido.", "C\u00f3digo entero no v\u00e1lido.");
        e("C\u00f3digo personalizado (", "C\u00f3digo personalizado (");
        e("Escolher tecla especial", "Elegir tecla especial");
        e("Buscar nome, categoria ou c\u00f3digo...", "Buscar nombre, categor\u00eda o c\u00f3digo...");
        e("C\u00f3digo avan\u00e7ado...", "C\u00f3digo avanzado...");
        e("Informe o c\u00f3digo inteiro da tecla (ex.: -21 para seta \u2190, 9 para Tab, -306 para Barra):", "Indica el c\u00f3digo entero de la tecla (ej.: -21 para flecha \u2190, 9 para Tab, -306 para la Barra):");
        e("C\u00f3digo avan\u00e7ado", "C\u00f3digo avanzado");
        e("Aplicar", "Aplicar");
        e("Ir p/ folha", "Ir a hoja");
        e("Texto", "Texto");
        e("Especial", "Especial");
        e("N\u00e3o foi poss\u00edvel abrir o seletor de arquivos.", "No se pudo abrir el selector de archivos.");
        e("O arquivo de folhas estava corrompido; os padr\u00f5es foram restaurados (backup salvo em sheets.json.bak).", "El archivo de hojas estaba da\u00f1ado; se restablecieron los valores predeterminados (copia guardada en sheets.json.bak).");
        e("Esta fileira j\u00e1 atingiu o limite de teclas.", "Esta fila ya alcanz\u00f3 el l\u00edmite de teclas.");
        e("Edi\u00e7\u00e3o", "Edici\u00f3n");
        e("Modificadores", "Modificadores");
        e("Fun\u00e7\u00e3o", "Funci\u00f3n");
        e("Sistema", "Sistema");
        e("Backspace (apagar)", "Retroceso (borrar)");
        e("Delete \u00e0 frente", "Suprimir (borrar adelante)");
        e("Enter / Retorno", "Enter / Retorno");
        e("Tab (tabula\u00e7\u00e3o)", "Tab (tabulaci\u00f3n)");
        e("Espa\u00e7o", "Espacio");
        e("Seta esquerda", "Flecha izquierda");
        e("Seta direita", "Flecha derecha");
        e("Seta cima", "Flecha arriba");
        e("Seta baixo", "Flecha abajo");
        e("Centro D-Pad", "Centro del D-Pad");
        e("Home (in\u00edcio)", "Inicio (Home)");
        e("End (fim)", "Fin (End)");
        e("Barra Mr Keyboard", "Barra de Mr Keyboard");
        e("Configura\u00e7\u00f5es", "Configuraci\u00f3n");
        e("Entrada por voz", "Entrada de voz");
        e("Tecla auxiliar (v\u00edrgula/voz)", "Tecla auxiliar (coma/voz)");
        e("Tecla F1", "Tecla F1");
        e("Tecla F2", "Tecla F2");
        e("Tecla F3", "Tecla F3");
        e("Tecla F4", "Tecla F4");
        e("Tecla F5", "Tecla F5");
        e("Tecla F6", "Tecla F6");
        e("Tecla F7", "Tecla F7");
        e("Tecla F8", "Tecla F8");
        e("Tecla F9", "Tecla F9");
        e("Tecla F10", "Tecla F10");
        e("Tecla F11", "Tecla F11");
        e("Tecla F12", "Tecla F12");
        a("Limpeza parcial", "Partial cleanup", "Limpieza parcial");
        a("Cache limpo", "Cache cleared", "Cach\u00e9 borrada");
        a("Cache limpo. Toque numa categoria ou em Atualizar.", "Cache cleared. Tap a category or Refresh.", "Cach\u00e9 borrada. Toca una categor\u00eda o Actualizar.");
        a("Limpeza parcial. Toque em Cache para tentar novamente.", "Partial cleanup. Tap Cache to try again.", "Limpieza parcial. Toca Cach\u00e9 para intentarlo de nuevo.");
        a("Limpando caches\u2026", "Clearing caches\u2026", "Borrando cach\u00e9s\u2026");
        a("Fila de anexos ocupada. Tente novamente.", "The attachment queue is busy. Try again.", "La cola de archivos adjuntos est\u00e1 ocupada. Int\u00e9ntalo de nuevo.");
        a("N\u00e3o foi poss\u00edvel atualizar. Toque para tentar novamente.", "Could not refresh. Tap to try again.", "No se pudo actualizar. Toca para intentarlo de nuevo.");
        a("O campo de destino mudou. Selecione o anexo novamente.", "The target field changed. Select the attachment again.", "El campo de destino cambi\u00f3. Selecciona el archivo adjunto de nuevo.");
        a("Limpeza finalizada. Detalhes indispon\u00edveis.", "Cleanup finished. Details unavailable.", "Limpieza terminada. Detalles no disponibles.");
        a("Cache limpo\nSeus arquivos originais n\u00e3o foram alterados.\nC\u00f3pias tempor\u00e1rias: ", "Cache cleared\nYour original files were not changed.\nTemporary copies: ", "Cach\u00e9 borrada\nTus archivos originales no se modificaron.\nCopias temporales: ");
        a("Limpeza parcial\nAlguns itens tempor\u00e1rios n\u00e3o puderam ser removidos.\nSeus arquivos originais n\u00e3o foram alterados.\nToque em Cache para tentar novamente.", "Partial cleanup\nSome temporary items could not be removed.\nYour original files were not changed.\nTap Cache to try again.", "Limpieza parcial\nNo se pudieron quitar algunos elementos temporales.\nTus archivos originales no se modificaron.\nToca Cach\u00e9 para intentarlo de nuevo.");
        a(")\nListas: ", ")\nLists: ", ")\nListas: ");
        a(")\nMiniaturas: ", ")\nThumbnails: ", ")\nMiniaturas: ");
        a("\nToque numa categoria ou em Atualizar.", "\nTap a category or Refresh.", "\nToca una categor\u00eda o Actualizar.");
    }

    private static void e(String pt, String es) {
        ES.put(pt, es);
    }

    private static void a(String pt, String en, String es) {
        EN.put(pt, en);
        ES.put(pt, es);
    }

    /** Spanish text for the Portuguese text; without a translation, the text itself. */
    public static String es(String pt) {
        String s = ES.get(pt);
        return s != null ? s : pt;
    }

    /** Two-letter language of the app (the one chosen in Settings or the system one); no answer, "pt". */
    static String lang(Context c) {
        try {
            Locale l = UiLocale.wrap(c).getResources().getConfiguration().locale;
            String s = l == null ? null : l.getLanguage();
            if (s != null && s.length() >= 2) return s.substring(0, 2).toLowerCase(Locale.ROOT);
        } catch (RuntimeException ex) {
            // falls back to the default
        }
        return "pt";
    }

    /** Text that the code had only in Portuguese, in the app language (pt, es or English). */
    public static String app(Context c, String pt) {
        String l = lang(c);
        if ("pt".equals(l)) return pt;
        if ("es".equals(l)) return es(pt);
        String s = EN.get(pt);
        return s != null ? s : pt;
    }
}
