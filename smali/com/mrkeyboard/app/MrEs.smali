.class public final Lcom/mrkeyboard/app/MrEs;
.super Ljava/lang/Object;
.source "MrEs.java"


# static fields
.field private static final EN:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final ES:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 18
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrEs;->ES:Ljava/util/HashMap;

    .line 19
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrEs;->EN:Ljava/util/HashMap;

    .line 22
    const-string v0, "Folha anterior (ciclo)"

    const-string v1, "Hoja anterior (ciclo)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 23
    const-string v0, "Pr\u00f3xima folha (ciclo)"

    const-string v1, "Hoja siguiente (ciclo)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 24
    const-string v0, "Num\u00e9rico"

    const-string v1, "Num\u00e9rico"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 25
    const-string v0, "Navega\u00e7\u00e3o"

    const-string v1, "Navegaci\u00f3n"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 26
    const-string v0, "Folha "

    const-string v1, "Hoja "

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 27
    const-string v0, "Nova folha"

    const-string v1, "Nueva hoja"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 28
    const-string v0, "Edi\u00e7\u00e3o"

    const-string v1, "Edici\u00f3n"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 29
    const-string v0, "Modificadores"

    const-string v1, "Modificadores"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 30
    const-string v0, "Fun\u00e7\u00e3o"

    const-string v1, "Funci\u00f3n"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 31
    const-string v0, "Sistema"

    const-string v1, "Sistema"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 32
    const-string v0, "Backspace (apagar)"

    const-string v1, "Retroceso (borrar)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 33
    const-string v0, "Delete \u00e0 frente"

    const-string v1, "Suprimir (borrar adelante)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 34
    const-string v0, "Enter / Retorno"

    const-string v1, "Enter / Retorno"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 35
    const-string v0, "Tab (tabula\u00e7\u00e3o)"

    const-string v1, "Tab (tabulaci\u00f3n)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 36
    const-string v0, "Espa\u00e7o"

    const-string v1, "Espacio"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 37
    const-string v0, "Seta esquerda"

    const-string v1, "Flecha izquierda"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 38
    const-string v0, "Seta direita"

    const-string v1, "Flecha derecha"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 39
    const-string v0, "Seta cima"

    const-string v1, "Flecha arriba"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 40
    const-string v0, "Seta baixo"

    const-string v1, "Flecha abajo"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 41
    const-string v0, "Centro D-Pad"

    const-string v1, "Centro del D-Pad"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 42
    const-string v0, "Home (in\u00edcio)"

    const-string v1, "Inicio (Home)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 43
    const-string v0, "End (fim)"

    const-string v1, "Fin (End)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 44
    const-string v0, "Barra Mr Keyboard"

    const-string v1, "Barra de Mr Keyboard"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 45
    const-string v0, "Configura\u00e7\u00f5es"

    const-string v1, "Configuraci\u00f3n"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 46
    const-string v0, "Entrada por voz"

    const-string v1, "Entrada de voz"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 47
    const-string v0, "Tecla auxiliar (v\u00edrgula/voz)"

    const-string v1, "Tecla auxiliar (coma/voz)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 48
    const-string v0, "Tecla F1"

    const-string v1, "Tecla F1"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 49
    const-string v0, "Tecla F2"

    const-string v1, "Tecla F2"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 50
    const-string v0, "Tecla F3"

    const-string v1, "Tecla F3"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 51
    const-string v0, "Tecla F4"

    const-string v1, "Tecla F4"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 52
    const-string v0, "Tecla F5"

    const-string v1, "Tecla F5"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 53
    const-string v0, "Tecla F6"

    const-string v1, "Tecla F6"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 54
    const-string v0, "Tecla F7"

    const-string v1, "Tecla F7"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 55
    const-string v0, "Tecla F8"

    const-string v1, "Tecla F8"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 56
    const-string v0, "Tecla F9"

    const-string v1, "Tecla F9"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 57
    const-string v0, "Tecla F10"

    const-string v1, "Tecla F10"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 58
    const-string v0, "Tecla F11"

    const-string v1, "Tecla F11"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 59
    const-string v0, "Tecla F12"

    const-string v1, "Tecla F12"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 60
    const-string v0, "Limpeza parcial"

    const-string v1, "Partial cleanup"

    const-string v2, "Limpieza parcial"

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 61
    const-string v0, "Cache limpo"

    const-string v1, "Cache cleared"

    const-string v2, "Cach\u00e9 borrada"

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 62
    const-string v0, "Cache limpo. Toque numa categoria ou em Atualizar."

    const-string v1, "Cache cleared. Tap a category or Refresh."

    const-string v2, "Cach\u00e9 borrada. Toca una categor\u00eda o Actualizar."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 63
    const-string v0, "Limpeza parcial. Toque em Cache para tentar novamente."

    const-string v1, "Partial cleanup. Tap Cache to try again."

    const-string v2, "Limpieza parcial. Toca Cach\u00e9 para intentarlo de nuevo."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 64
    const-string v0, "Limpando caches\u2026"

    const-string v1, "Clearing caches\u2026"

    const-string v2, "Borrando cach\u00e9s\u2026"

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 65
    const-string v0, "Fila de anexos ocupada. Tente novamente."

    const-string v1, "The attachment queue is busy. Try again."

    const-string v2, "La cola de archivos adjuntos est\u00e1 ocupada. Int\u00e9ntalo de nuevo."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 66
    const-string v0, "N\u00e3o foi poss\u00edvel atualizar. Toque para tentar novamente."

    const-string v1, "Could not refresh. Tap to try again."

    const-string v2, "No se pudo actualizar. Toca para intentarlo de nuevo."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 67
    const-string v0, "O campo de destino mudou. Selecione o anexo novamente."

    const-string v1, "The target field changed. Select the attachment again."

    const-string v2, "El campo de destino cambi\u00f3. Selecciona el archivo adjunto de nuevo."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 68
    const-string v0, "Limpeza finalizada. Detalhes indispon\u00edveis."

    const-string v1, "Cleanup finished. Details unavailable."

    const-string v2, "Limpieza terminada. Detalles no disponibles."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 69
    const-string v0, "Cache limpo\nSeus arquivos originais n\u00e3o foram alterados.\nC\u00f3pias tempor\u00e1rias: "

    const-string v1, "Cache cleared\nYour original files were not changed.\nTemporary copies: "

    const-string v2, "Cach\u00e9 borrada\nTus archivos originales no se modificaron.\nCopias temporales: "

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 70
    const-string v0, "Limpeza parcial\nAlguns itens tempor\u00e1rios n\u00e3o puderam ser removidos.\nSeus arquivos originais n\u00e3o foram alterados.\nToque em Cache para tentar novamente."

    const-string v1, "Partial cleanup\nSome temporary items could not be removed.\nYour original files were not changed.\nTap Cache to try again."

    const-string v2, "Limpieza parcial\nNo se pudieron quitar algunos elementos temporales.\nTus archivos originales no se modificaron.\nToca Cach\u00e9 para intentarlo de nuevo."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 71
    const-string v0, ")\nListas: "

    const-string v1, ")\nLists: "

    const-string v2, ")\nListas: "

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 72
    const-string v0, ")\nMiniaturas: "

    const-string v1, ")\nThumbnails: "

    const-string v2, ")\nMiniaturas: "

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 73
    const-string v0, "\nToque numa categoria ou em Atualizar."

    const-string v1, "\nTap a category or Refresh."

    const-string v2, "\nToca una categor\u00eda o Actualizar."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 74
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 81
    sget-object v0, Lcom/mrkeyboard/app/MrEs;->EN:Ljava/util/HashMap;

    invoke-virtual {v0, p0, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 82
    sget-object v0, Lcom/mrkeyboard/app/MrEs;->ES:Ljava/util/HashMap;

    invoke-virtual {v0, p0, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 83
    return-void
.end method

.method public static app(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 105
    invoke-static {p0}, Lcom/mrkeyboard/app/MrEs;->lang(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 106
    const-string v1, "pt"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 109
    :goto_0
    return-object p1

    .line 107
    :cond_0
    const-string v1, "es"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {p1}, Lcom/mrkeyboard/app/MrEs;->es(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    .line 108
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrEs;->EN:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 109
    if-eqz v0, :cond_2

    :goto_1
    move-object p1, v0

    goto :goto_0

    :cond_2
    move-object v0, p1

    goto :goto_1
.end method

.method private static e(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 77
    sget-object v0, Lcom/mrkeyboard/app/MrEs;->ES:Ljava/util/HashMap;

    invoke-virtual {v0, p0, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 78
    return-void
.end method

.method public static es(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 87
    sget-object v0, Lcom/mrkeyboard/app/MrEs;->ES:Ljava/util/HashMap;

    invoke-virtual {v0, p0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 88
    if-eqz v0, :cond_0

    :goto_0
    return-object v0

    :cond_0
    move-object v0, p0

    goto :goto_0
.end method

.method static lang(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v2, 0x2

    .line 94
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v0, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 95
    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 96
    :goto_0
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lt v1, v2, :cond_1

    const/4 v1, 0x0

    const/4 v2, 0x2

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 100
    :goto_1
    return-object v0

    .line 95
    :cond_0
    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 97
    :catch_0
    move-exception v0

    .line 100
    :cond_1
    const-string v0, "pt"

    goto :goto_1
.end method
