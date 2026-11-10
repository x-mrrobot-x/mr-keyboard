package com.mrkeyboard.app;

import android.content.Context;
import java.util.HashMap;
import java.util.Locale;

/**
 * Fixed texts in the code (names and categories of the special-key picker, attachments and cache) that exist only in
 * Portuguese in the smali: here are the Spanish versions (and, for what was Portuguese only, English). The sheet editor,
 * the key and popup editors and the key grid are not here: since 1.92.0 their texts are in mr_strings.xml.
 * On these screens, the smali uses the Portuguese text and passes it through SheetStrings.p(), which switches to Spanish
 * when the app language is Spanish. The keys must be equal to the Portuguese text in the smali;
 * docs/tools/mres_check.py checks this and lists Portuguese texts that were left untranslated.
 */
public final class MrEs {
    private MrEs() { }

    private static final HashMap<String, String> ES = new HashMap<String, String>();
    private static final HashMap<String, String> EN = new HashMap<String, String>();

    static {
        e("Folha anterior (ciclo)", "Hoja anterior (ciclo)");
        e("Pr\u00f3xima folha (ciclo)", "Hoja siguiente (ciclo)");
        e("Num\u00e9rico", "Num\u00e9rico");
        e("Navega\u00e7\u00e3o", "Navegaci\u00f3n");
        e("Folha ", "Hoja ");
        e("Nova folha", "Nueva hoja");
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
