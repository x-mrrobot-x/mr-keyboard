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
    .line 17
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrEs;->ES:Ljava/util/HashMap;

    .line 18
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrEs;->EN:Ljava/util/HashMap;

    .line 21
    const-string v0, "Informe o texto ou r\u00f3tulo da tecla."

    const-string v1, "Indica el texto o la etiqueta de la tecla."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 22
    const-string v0, "Informe o nome do comando Tasker."

    const-string v1, "Indica el nombre del comando de Tasker."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 23
    const-string v0, "Largura proporcional: "

    const-string v1, "Ancho proporcional: "

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 24
    const-string v0, "Lista de teclas ("

    const-string v1, "Lista de teclas ("

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 25
    const-string v0, "Caracteres: "

    const-string v1, "Caracteres: "

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 26
    const-string v0, "Nenhum (toque para configurar)  \u25b8"

    const-string v1, "Ninguno (toca para configurar)  \u25b8"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 27
    const-string v0, "Folha anterior (ciclo)"

    const-string v1, "Hoja anterior (ciclo)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 28
    const-string v0, "ABC \u2014 Teclado principal"

    const-string v1, "ABC \u2014 Teclado principal"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 29
    const-string v0, "Pr\u00f3xima folha (ciclo)"

    const-string v1, "Hoja siguiente (ciclo)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 30
    const-string v0, "Editar item do popup"

    const-string v1, "Editar elemento del popup"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 31
    const-string v0, "Editar tecla"

    const-string v1, "Editar tecla"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 32
    const-string v0, "Tipo de a\u00e7\u00e3o"

    const-string v1, "Tipo de acci\u00f3n"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 33
    const-string v0, "Separador"

    const-string v1, "Separador"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 34
    const-string v0, "R\u00f3tulo vis\u00edvel na tecla"

    const-string v1, "Etiqueta visible en la tecla"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 35
    const-string v0, "Texto exibido no bot\u00e3o (auto se vazio)"

    const-string v1, "Texto que se muestra en el bot\u00f3n (autom\u00e1tico si est\u00e1 vac\u00edo)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 36
    const-string v0, "Texto inserido ao tocar"

    const-string v1, "Texto que se inserta al tocar"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 37
    const-string v0, "Caractere, tag HTML ou frase completa..."

    const-string v1, "Car\u00e1cter, etiqueta HTML o frase completa..."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 38
    const-string v0, "Comando Tasker (prefixo tskcmd: autom\u00e1tico)"

    const-string v1, "Comando de Tasker (prefijo tskcmd: autom\u00e1tico)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 39
    const-string v0, "Ex.: wifi, bt, flash, meu_perfil"

    const-string v1, "Ej.: wifi, bt, flash, mi_perfil"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 40
    const-string v0, "Tecla especial selecionada"

    const-string v1, "Tecla especial seleccionada"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 41
    const-string v0, "Folha de destino"

    const-string v1, "Hoja de destino"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 42
    const-string v0, "Cria um espa\u00e7o vazio invis\u00edvel nesta posi\u00e7\u00e3o do teclado real. Use o controle de largura abaixo para definir o tamanho do v\u00e3o."

    const-string v1, "Crea un espacio vac\u00edo invisible en esta posici\u00f3n del teclado real. Usa el control de ancho de abajo para definir el tama\u00f1o del hueco."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 43
    const-string v0, "Toque longo (popup)"

    const-string v1, "Toque largo (popup)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 44
    const-string v0, "Salvar"

    const-string v1, "Guardar"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 45
    const-string v0, "Cancelar"

    const-string v1, "Cancelar"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 46
    const-string v0, "Duplicar"

    const-string v1, "Duplicar"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 47
    const-string v0, "Excluir"

    const-string v1, "Eliminar"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 48
    const-string v0, "Escolher folha de destino"

    const-string v1, "Elegir hoja de destino"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 49
    const-string v0, "Itens do popup ("

    const-string v1, "Elementos del popup ("

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 50
    const-string v0, "Limite m\u00e1ximo de 10 itens no popup."

    const-string v1, "L\u00edmite m\u00e1ximo de 10 elementos en el popup."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 51
    const-string v0, "Ir para: "

    const-string v1, "Ir a: "

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 52
    const-string v0, "Texto: "

    const-string v1, "Texto: "

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 53
    const-string v0, "Popup no toque longo"

    const-string v1, "Popup en el toque largo"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 54
    const-string v0, "Escolha o que abre ao segurar esta tecla pressionada:"

    const-string v1, "Elige qu\u00e9 se abre al mantener presionada esta tecla:"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 55
    const-string v0, "Nenhum"

    const-string v1, "Ninguno"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 56
    const-string v0, "Caracteres"

    const-string v1, "Caracteres"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 57
    const-string v0, "Teclas / A\u00e7\u00f5es"

    const-string v1, "Teclas / Acciones"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 58
    const-string v0, "Digite uma sequ\u00eancia de caracteres (cada letra vira um bot\u00e3o no popup, ex.: \u00e1\u00e0\u00e2\u00e3\u00e4):"

    const-string v1, "Escribe una secuencia de caracteres (cada letra se convierte en un bot\u00f3n en el popup, ej.: \u00e1\u00e0\u00e2\u00e3\u00e4):"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 59
    const-string v0, "Ex.: \u00b9\u00b2\u00b3\u00a3\u00a2\u20ac\u00a5"

    const-string v1, "Ej.: \u00b9\u00b2\u00b3\u00a3\u00a2\u20ac\u00a5"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 60
    const-string v0, "+ Adicionar item ao popup"

    const-string v1, "+ Agregar elemento al popup"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 61
    const-string v0, "Nenhum popup ser\u00e1 exibido ao segurar esta tecla."

    const-string v1, "No se mostrar\u00e1 ning\u00fan popup al mantener presionada esta tecla."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 62
    const-string v0, "Concluir"

    const-string v1, "Listo"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 63
    const-string v0, "Folha restaurada."

    const-string v1, "Hoja restablecida."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 64
    const-string v0, "Todas as folhas foram restauradas para o padr\u00e3o."

    const-string v1, "Todas las hojas se restablecieron a los valores predeterminados."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 65
    const-string v0, "Importadas "

    const-string v1, "Se importaron "

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 66
    const-string v0, " folhas!"

    const-string v1, " hojas!"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 67
    const-string v0, "JSON inv\u00e1lido: "

    const-string v1, "JSON no v\u00e1lido: "

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 68
    const-string v0, "Teclado principal (fixo)"

    const-string v1, "Teclado principal (fijo)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 69
    const-string v0, "Layout alfab\u00e9tico padr\u00e3o do idioma ativo"

    const-string v1, "Dise\u00f1o alfab\u00e9tico est\u00e1ndar del idioma activo"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 70
    const-string v0, "Padr\u00e3o"

    const-string v1, "Integrada"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 71
    const-string v0, "Personalizada"

    const-string v1, "Personalizada"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 72
    const-string v0, " fileiras \u2022 "

    const-string v1, " filas \u2022 "

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 73
    const-string v0, " teclas \u2022 "

    const-string v1, " teclas \u2022 "

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 74
    const-string v0, "Excluir folha?"

    const-string v1, "\u00bfEliminar la hoja?"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 75
    const-string v0, "Tem certeza que deseja excluir \""

    const-string v1, "\u00bfSeguro que quieres eliminar \""

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 76
    const-string v0, "Restaurar todas as folhas?"

    const-string v1, "\u00bfRestablecer todas las hojas?"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 77
    const-string v0, "Isso restaurar\u00e1 as 4 folhas originais (123, TSK, HTML, FRS) e remover\u00e1 folhas personalizadas. Dica: voc\u00ea pode exportar um backup JSON antes."

    const-string v1, "Esto restablecer\u00e1 las 4 hojas originales (123, TSK, HTML, FRS) y quitar\u00e1 las hojas personalizadas. Consejo: puedes exportar una copia de seguridad JSON antes."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 78
    const-string v0, "Restaurar tudo"

    const-string v1, "Restablecer todo"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 79
    const-string v0, "Restaurar folha padr\u00e3o?"

    const-string v1, "\u00bfRestablecer la hoja predeterminada?"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 80
    const-string v0, "Restaurar \""

    const-string v1, "\u00bfRestablecer \""

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 81
    const-string v0, "\" ao layout original?"

    const-string v1, "\" a su dise\u00f1o original?"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 82
    const-string v0, "Restaurar"

    const-string v1, "Restablecer"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 83
    const-string v0, "Limite m\u00e1ximo de 12 folhas atingido."

    const-string v1, "Se alcanz\u00f3 el l\u00edmite m\u00e1ximo de 12 hojas."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 84
    const-string v0, " (c\u00f3pia)"

    const-string v1, " (copia)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 85
    const-string v0, "Copiar teclas de qual folha?"

    const-string v1, "\u00bfDe qu\u00e9 hoja copiar las teclas?"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 86
    const-string v0, "Num\u00e9rico"

    const-string v1, "Num\u00e9rico"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 87
    const-string v0, "Navega\u00e7\u00e3o"

    const-string v1, "Navegaci\u00f3n"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 88
    const-string v0, "Folha "

    const-string v1, "Hoja "

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 89
    const-string v0, "Nome da folha:"

    const-string v1, "Nombre de la hoja:"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 90
    const-string v0, "Selo curto no bot\u00e3o (1 a 5 caracteres):"

    const-string v1, "Sello corto en el bot\u00f3n (1 a 5 caracteres):"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 91
    const-string v0, "Nova folha"

    const-string v1, "Nueva hoja"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 92
    const-string v0, "Criar e editar"

    const-string v1, "Crear y editar"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 93
    const-string v0, " folhas \u2022 Toque para editar teclas"

    const-string v1, " hojas \u2022 Toca para editar teclas"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 94
    const-string v0, "Nenhuma folha ativa (apenas o teclado principal ABC).\nToque em \"+ Nova folha\" ou em \u22ee \u2192 \"Restaurar todas para o padr\u00e3o\"."

    const-string v1, "Ninguna hoja activa (solo el teclado principal ABC).\nToca \"+ Nueva hoja\" o \u22ee \u2192 \"Restablecer todas a los valores predeterminados\"."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 95
    const-string v0, "Editar teclas"

    const-string v1, "Editar teclas"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 96
    const-string v0, "Renomear nome e selo"

    const-string v1, "Renombrar nombre y sello"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 97
    const-string v0, "Mover para cima"

    const-string v1, "Mover hacia arriba"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 98
    const-string v0, "Mover para baixo"

    const-string v1, "Mover hacia abajo"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 99
    const-string v0, "Duplicar folha"

    const-string v1, "Duplicar hoja"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 100
    const-string v0, "Restaurar padr\u00e3o"

    const-string v1, "Restablecer valores predeterminados"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 101
    const-string v0, "Excluir folha"

    const-string v1, "Eliminar hoja"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 102
    const-string v0, "Exportar folhas (JSON)"

    const-string v1, "Exportar hojas (JSON)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 103
    const-string v0, "Importar folhas (JSON)"

    const-string v1, "Importar hojas (JSON)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 104
    const-string v0, "Restaurar todas para o padr\u00e3o"

    const-string v1, "Restablecer todas a los valores predeterminados"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 105
    const-string v0, "Backup e restaura\u00e7\u00e3o"

    const-string v1, "Copia de seguridad y restauraci\u00f3n"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 106
    const-string v0, "Em branco (3 fileiras vazias)"

    const-string v1, "En blanco (3 filas vac\u00edas)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 107
    const-string v0, "Teclado num\u00e9rico (Numpad)"

    const-string v1, "Teclado num\u00e9rico (Numpad)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 108
    const-string v0, "Setas + Edi\u00e7\u00e3o (Home/End/PgUp/PgDn/Tab/Esc)"

    const-string v1, "Flechas + Edici\u00f3n (Home/End/PgUp/PgDn/Tab/Esc)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 109
    const-string v0, "Copiar de folha existente..."

    const-string v1, "Copiar de una hoja existente..."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 110
    const-string v0, "Modelo da nova folha"

    const-string v1, "Plantilla de la nueva hoja"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 111
    const-string v0, "Selo curto no bot\u00e3o (at\u00e9 5 caracteres):"

    const-string v1, "Sello corto en el bot\u00f3n (hasta 5 caracteres):"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 112
    const-string v0, "Renomear folha"

    const-string v1, "Renombrar hoja"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 113
    const-string v0, "Folhas exportadas com sucesso!"

    const-string v1, "\u00a1Hojas exportadas correctamente!"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 114
    const-string v0, "Erro ao exportar: "

    const-string v1, "Error al exportar: "

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 115
    const-string v0, "Importar folhas do arquivo?"

    const-string v1, "\u00bfImportar hojas desde el archivo?"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 116
    const-string v0, "Foram encontradas "

    const-string v1, "Se encontraron "

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 117
    const-string v0, " folha(s) v\u00e1lidas. Elas substituir\u00e3o a lista atual."

    const-string v1, " hoja(s) v\u00e1lida(s). Reemplazar\u00e1n la lista actual."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 118
    const-string v0, "Importar"

    const-string v1, "Importar"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 119
    const-string v0, "Arquivo JSON inv\u00e1lido: "

    const-string v1, "Archivo JSON no v\u00e1lido: "

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 120
    const-string v0, "Voltar"

    const-string v1, "Atr\u00e1s"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 121
    const-string v0, "Folhas do teclado"

    const-string v1, "Hojas del teclado"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 122
    const-string v0, "Mais op\u00e7\u00f5es"

    const-string v1, "M\u00e1s opciones"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 123
    const-string v0, "FOLHAS EDIT\u00c1VEIS (ORDEM DO CICLO)"

    const-string v1, "HOJAS EDITABLES (ORDEN DEL CICLO)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 124
    const-string v0, "+ Nova folha"

    const-string v1, "+ Nueva hoja"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 125
    const-string v0, "Exportar JSON"

    const-string v1, "Exportar JSON"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 126
    const-string v0, "Importar JSON"

    const-string v1, "Importar JSON"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 127
    const-string v0, "Folha exclu\u00edda."

    const-string v1, "Hoja eliminada."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 128
    const-string v0, "Folha restaurada para o padr\u00e3o."

    const-string v1, "Hoja restablecida a los valores predeterminados."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 129
    const-string v0, "Fileira "

    const-string v1, "Fila "

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 130
    const-string v0, " teclas)"

    const-string v1, " teclas)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 131
    const-string v0, "Limite m\u00e1ximo de 6 fileiras edit\u00e1veis atingido."

    const-string v1, "Se alcanz\u00f3 el l\u00edmite m\u00e1ximo de 6 filas editables."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 132
    const-string v0, "A tecla Apagar (\u232b) no canto inferior direito \u00e9 fixa por seguran\u00e7a."

    const-string v1, "La tecla Borrar (\u232b) de la esquina inferior derecha es fija por seguridad."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 133
    const-string v0, "A fileira inferior do sistema \u00e9 fixa em todas as folhas."

    const-string v1, "La fila inferior del sistema es fija en todas las hojas."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 134
    const-string v0, "CAMPO DE TESTE R\u00c1PIDO"

    const-string v1, "CAMPO DE PRUEBA R\u00c1PIDA"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 135
    const-string v0, "Limpar"

    const-string v1, "Borrar"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 136
    const-string v0, "Toque aqui para abrir o teclado e testar esta folha ao vivo..."

    const-string v1, "Toca aqu\u00ed para abrir el teclado y probar esta hoja en vivo..."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 137
    const-string v0, "As edi\u00e7\u00f5es s\u00e3o aplicadas na hora \u2022 Troque para esta folha no teclado para testar."

    const-string v1, "Los cambios se aplican al instante \u2022 Cambia a esta hoja en el teclado para probar."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 138
    const-string v0, "Todas as edi\u00e7\u00f5es feitas nesta folha voltar\u00e3o ao layout original de f\u00e1brica."

    const-string v1, "Todos los cambios hechos en esta hoja volver\u00e1n al dise\u00f1o original de f\u00e1brica."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 139
    const-string v0, "Folha duplicada! Editando a nova c\u00f3pia."

    const-string v1, "\u00a1Hoja duplicada! Editando la nueva copia."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 140
    const-string v0, "Nada para desfazer."

    const-string v1, "Nada que deshacer."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 141
    const-string v0, "Altera\u00e7\u00e3o desfeita."

    const-string v1, "Cambio deshecho."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 142
    const-string v0, " teclas"

    const-string v1, " teclas"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 143
    const-string v0, "AO VIVO \u2022 "

    const-string v1, "EN VIVO \u2022 "

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 144
    const-string v0, "Gerenciar fileiras edit\u00e1veis"

    const-string v1, "Administrar filas editables"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 145
    const-string v0, "Fechar"

    const-string v1, "Cerrar"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 146
    const-string v0, "Gerenciar fileiras..."

    const-string v1, "Administrar filas..."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 147
    const-string v0, "Duplicar esta folha"

    const-string v1, "Duplicar esta hoja"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 148
    const-string v0, "Restaurar padr\u00e3o desta folha"

    const-string v1, "Restablecer los valores de esta hoja"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 149
    const-string v0, "Excluir esta folha"

    const-string v1, "Eliminar esta hoja"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 150
    const-string v0, "Selo curto no teclado (1 a 5 caracteres):"

    const-string v1, "Sello corto en el teclado (1 a 5 caracteres):"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 151
    const-string v0, "\u21b6 Desfazer"

    const-string v1, "\u21b6 Deshacer"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 152
    const-string v0, "Toque em uma tecla para editar \u2022 Segure e arraste para mover \u2022 Toque em \'+\' para adicionar"

    const-string v1, "Toca una tecla para editarla \u2022 Mant\u00e9n y arrastra para moverla \u2022 Toca \'+\' para agregar"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 153
    const-string v0, "+ Nova fileira"

    const-string v1, "+ Nueva fila"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 154
    const-string v0, "\u21c5 Fileiras"

    const-string v1, "\u21c5 Filas"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 155
    const-string v0, "\u270e Nome/Selo"

    const-string v1, "\u270e Nombre/Sello"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 156
    const-string v0, "+ Adicionar tecla"

    const-string v1, "+ Agregar tecla"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 157
    const-string v0, "Nenhuma tecla encontrada."

    const-string v1, "No se encontr\u00f3 ninguna tecla."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 158
    const-string v0, "C\u00f3digo inteiro inv\u00e1lido."

    const-string v1, "C\u00f3digo entero no v\u00e1lido."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 159
    const-string v0, "C\u00f3digo personalizado ("

    const-string v1, "C\u00f3digo personalizado ("

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 160
    const-string v0, "Escolher tecla especial"

    const-string v1, "Elegir tecla especial"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 161
    const-string v0, "Buscar nome, categoria ou c\u00f3digo..."

    const-string v1, "Buscar nombre, categor\u00eda o c\u00f3digo..."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 162
    const-string v0, "C\u00f3digo avan\u00e7ado..."

    const-string v1, "C\u00f3digo avanzado..."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 163
    const-string v0, "Informe o c\u00f3digo inteiro da tecla (ex.: -21 para seta \u2190, 9 para Tab, -306 para Barra):"

    const-string v1, "Indica el c\u00f3digo entero de la tecla (ej.: -21 para flecha \u2190, 9 para Tab, -306 para la Barra):"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 164
    const-string v0, "C\u00f3digo avan\u00e7ado"

    const-string v1, "C\u00f3digo avanzado"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 165
    const-string v0, "Aplicar"

    const-string v1, "Aplicar"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 166
    const-string v0, "Ir p/ folha"

    const-string v1, "Ir a hoja"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 167
    const-string v0, "Texto"

    const-string v1, "Texto"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 168
    const-string v0, "Especial"

    const-string v1, "Especial"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 169
    const-string v0, "N\u00e3o foi poss\u00edvel abrir o seletor de arquivos."

    const-string v1, "No se pudo abrir el selector de archivos."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 170
    const-string v0, "O arquivo de folhas estava corrompido; os padr\u00f5es foram restaurados (backup salvo em sheets.json.bak)."

    const-string v1, "El archivo de hojas estaba da\u00f1ado; se restablecieron los valores predeterminados (copia guardada en sheets.json.bak)."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 171
    const-string v0, "Esta fileira j\u00e1 atingiu o limite de teclas."

    const-string v1, "Esta fila ya alcanz\u00f3 el l\u00edmite de teclas."

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 172
    const-string v0, "Edi\u00e7\u00e3o"

    const-string v1, "Edici\u00f3n"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 173
    const-string v0, "Modificadores"

    const-string v1, "Modificadores"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 174
    const-string v0, "Fun\u00e7\u00e3o"

    const-string v1, "Funci\u00f3n"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 175
    const-string v0, "Sistema"

    const-string v1, "Sistema"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 176
    const-string v0, "Backspace (apagar)"

    const-string v1, "Retroceso (borrar)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 177
    const-string v0, "Delete \u00e0 frente"

    const-string v1, "Suprimir (borrar adelante)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 178
    const-string v0, "Enter / Retorno"

    const-string v1, "Enter / Retorno"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 179
    const-string v0, "Tab (tabula\u00e7\u00e3o)"

    const-string v1, "Tab (tabulaci\u00f3n)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 180
    const-string v0, "Espa\u00e7o"

    const-string v1, "Espacio"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 181
    const-string v0, "Seta esquerda"

    const-string v1, "Flecha izquierda"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 182
    const-string v0, "Seta direita"

    const-string v1, "Flecha derecha"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 183
    const-string v0, "Seta cima"

    const-string v1, "Flecha arriba"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 184
    const-string v0, "Seta baixo"

    const-string v1, "Flecha abajo"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 185
    const-string v0, "Centro D-Pad"

    const-string v1, "Centro del D-Pad"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 186
    const-string v0, "Home (in\u00edcio)"

    const-string v1, "Inicio (Home)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 187
    const-string v0, "End (fim)"

    const-string v1, "Fin (End)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 188
    const-string v0, "Barra Mr Keyboard"

    const-string v1, "Barra de Mr Keyboard"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 189
    const-string v0, "Configura\u00e7\u00f5es"

    const-string v1, "Configuraci\u00f3n"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 190
    const-string v0, "Entrada por voz"

    const-string v1, "Entrada de voz"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 191
    const-string v0, "Tecla auxiliar (v\u00edrgula/voz)"

    const-string v1, "Tecla auxiliar (coma/voz)"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 192
    const-string v0, "Tecla F1"

    const-string v1, "Tecla F1"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 193
    const-string v0, "Tecla F2"

    const-string v1, "Tecla F2"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 194
    const-string v0, "Tecla F3"

    const-string v1, "Tecla F3"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 195
    const-string v0, "Tecla F4"

    const-string v1, "Tecla F4"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 196
    const-string v0, "Tecla F5"

    const-string v1, "Tecla F5"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 197
    const-string v0, "Tecla F6"

    const-string v1, "Tecla F6"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 198
    const-string v0, "Tecla F7"

    const-string v1, "Tecla F7"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 199
    const-string v0, "Tecla F8"

    const-string v1, "Tecla F8"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 200
    const-string v0, "Tecla F9"

    const-string v1, "Tecla F9"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 201
    const-string v0, "Tecla F10"

    const-string v1, "Tecla F10"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 202
    const-string v0, "Tecla F11"

    const-string v1, "Tecla F11"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 203
    const-string v0, "Tecla F12"

    const-string v1, "Tecla F12"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEs;->e(Ljava/lang/String;Ljava/lang/String;)V

    .line 204
    const-string v0, "Limpeza parcial"

    const-string v1, "Partial cleanup"

    const-string v2, "Limpieza parcial"

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 205
    const-string v0, "Cache limpo"

    const-string v1, "Cache cleared"

    const-string v2, "Cach\u00e9 borrada"

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 206
    const-string v0, "Cache limpo. Toque numa categoria ou em Atualizar."

    const-string v1, "Cache cleared. Tap a category or Refresh."

    const-string v2, "Cach\u00e9 borrada. Toca una categor\u00eda o Actualizar."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 207
    const-string v0, "Limpeza parcial. Toque em Cache para tentar novamente."

    const-string v1, "Partial cleanup. Tap Cache to try again."

    const-string v2, "Limpieza parcial. Toca Cach\u00e9 para intentarlo de nuevo."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 208
    const-string v0, "Limpando caches\u2026"

    const-string v1, "Clearing caches\u2026"

    const-string v2, "Borrando cach\u00e9s\u2026"

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 209
    const-string v0, "Fila de anexos ocupada. Tente novamente."

    const-string v1, "The attachment queue is busy. Try again."

    const-string v2, "La cola de archivos adjuntos est\u00e1 ocupada. Int\u00e9ntalo de nuevo."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 210
    const-string v0, "N\u00e3o foi poss\u00edvel atualizar. Toque para tentar novamente."

    const-string v1, "Could not refresh. Tap to try again."

    const-string v2, "No se pudo actualizar. Toca para intentarlo de nuevo."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 211
    const-string v0, "O campo de destino mudou. Selecione o anexo novamente."

    const-string v1, "The target field changed. Select the attachment again."

    const-string v2, "El campo de destino cambi\u00f3. Selecciona el archivo adjunto de nuevo."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 212
    const-string v0, "Limpeza finalizada. Detalhes indispon\u00edveis."

    const-string v1, "Cleanup finished. Details unavailable."

    const-string v2, "Limpieza terminada. Detalles no disponibles."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 213
    const-string v0, "Cache limpo\nSeus arquivos originais n\u00e3o foram alterados.\nC\u00f3pias tempor\u00e1rias: "

    const-string v1, "Cache cleared\nYour original files were not changed.\nTemporary copies: "

    const-string v2, "Cach\u00e9 borrada\nTus archivos originales no se modificaron.\nCopias temporales: "

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 214
    const-string v0, "Limpeza parcial\nAlguns itens tempor\u00e1rios n\u00e3o puderam ser removidos.\nSeus arquivos originais n\u00e3o foram alterados.\nToque em Cache para tentar novamente."

    const-string v1, "Partial cleanup\nSome temporary items could not be removed.\nYour original files were not changed.\nTap Cache to try again."

    const-string v2, "Limpieza parcial\nNo se pudieron quitar algunos elementos temporales.\nTus archivos originales no se modificaron.\nToca Cach\u00e9 para intentarlo de nuevo."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 215
    const-string v0, ")\nListas: "

    const-string v1, ")\nLists: "

    const-string v2, ")\nListas: "

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 216
    const-string v0, ")\nMiniaturas: "

    const-string v1, ")\nThumbnails: "

    const-string v2, ")\nMiniaturas: "

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 217
    const-string v0, "\nToque numa categoria ou em Atualizar."

    const-string v1, "\nTap a category or Refresh."

    const-string v2, "\nToca una categor\u00eda o Actualizar."

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrEs;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 218
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 225
    sget-object v0, Lcom/mrkeyboard/app/MrEs;->EN:Ljava/util/HashMap;

    invoke-virtual {v0, p0, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 226
    sget-object v0, Lcom/mrkeyboard/app/MrEs;->ES:Ljava/util/HashMap;

    invoke-virtual {v0, p0, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 227
    return-void
.end method

.method public static app(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 249
    invoke-static {p0}, Lcom/mrkeyboard/app/MrEs;->lang(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 250
    const-string v1, "pt"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 253
    :goto_0
    return-object p1

    .line 251
    :cond_0
    const-string v1, "es"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {p1}, Lcom/mrkeyboard/app/MrEs;->es(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    .line 252
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrEs;->EN:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 253
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
    .line 221
    sget-object v0, Lcom/mrkeyboard/app/MrEs;->ES:Ljava/util/HashMap;

    invoke-virtual {v0, p0, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 222
    return-void
.end method

.method public static es(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 231
    sget-object v0, Lcom/mrkeyboard/app/MrEs;->ES:Ljava/util/HashMap;

    invoke-virtual {v0, p0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 232
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

    .line 238
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v0, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 239
    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 240
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

    .line 244
    :goto_1
    return-object v0

    .line 239
    :cond_0
    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 241
    :catch_0
    move-exception v0

    .line 244
    :cond_1
    const-string v0, "pt"

    goto :goto_1
.end method
