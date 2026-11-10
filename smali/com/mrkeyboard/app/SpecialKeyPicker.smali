.class public final Lcom/mrkeyboard/app/SpecialKeyPicker;
.super Ljava/lang/Object;
.source "SpecialKeyPicker.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;,
        Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;,
        Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;
    }
.end annotation


# static fields
.field private static final CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

.field private static final EMPTY:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 12

    .prologue
    const/16 v11, 0x20

    const/16 v10, 0xa

    const/16 v9, 0x9

    .line 63
    const/16 v0, 0x2b

    new-array v7, v0, [Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/4 v8, 0x0

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/4 v1, -0x5

    const-string v2, "\u232b"

    const-string v3, "Backspace (apagar)"

    const-string v4, "Backspace"

    const-string v5, "Edi\u00e7\u00e3o"

    const-string v6, "Editing"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/4 v8, 0x1

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x70

    const-string v2, "Del\u2192"

    const-string v3, "Delete \u00e0 frente"

    const-string v4, "Forward Delete"

    const-string v5, "Edi\u00e7\u00e3o"

    const-string v6, "Editing"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/4 v8, 0x2

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const-string v2, "\u23ce"

    const-string v3, "Enter / Retorno"

    const-string v4, "Enter / Return"

    const-string v5, "Edi\u00e7\u00e3o"

    const-string v6, "Editing"

    move v1, v10

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/4 v8, 0x3

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const-string v2, "\u21e5"

    const-string v3, "Tab (tabula\u00e7\u00e3o)"

    const-string v4, "Tab"

    const-string v5, "Edi\u00e7\u00e3o"

    const-string v6, "Editing"

    move v1, v9

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/4 v8, 0x4

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const-string v2, "\u2423"

    const-string v3, "Espa\u00e7o"

    const-string v4, "Space"

    const-string v5, "Edi\u00e7\u00e3o"

    const-string v6, "Editing"

    move v1, v11

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/4 v8, 0x5

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x7c

    const-string v2, "Ins"

    const-string v3, "Insert"

    const-string v4, "Insert"

    const-string v5, "Edi\u00e7\u00e3o"

    const-string v6, "Editing"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/4 v8, 0x6

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x6f

    const-string v2, "Esc"

    const-string v3, "Escape (Esc)"

    const-string v4, "Escape (Esc)"

    const-string v5, "Edi\u00e7\u00e3o"

    const-string v6, "Editing"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/4 v8, 0x7

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x15

    const-string v2, "\u2190"

    const-string v3, "Seta esquerda"

    const-string v4, "Arrow Left"

    const-string v5, "Navega\u00e7\u00e3o"

    const-string v6, "Navigation"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x8

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x16

    const-string v2, "\u2192"

    const-string v3, "Seta direita"

    const-string v4, "Arrow Right"

    const-string v5, "Navega\u00e7\u00e3o"

    const-string v6, "Navigation"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x13

    const-string v2, "\u2191"

    const-string v3, "Seta cima"

    const-string v4, "Arrow Up"

    const-string v5, "Navega\u00e7\u00e3o"

    const-string v6, "Navigation"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v9

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x14

    const-string v2, "\u2193"

    const-string v3, "Seta baixo"

    const-string v4, "Arrow Down"

    const-string v5, "Navega\u00e7\u00e3o"

    const-string v6, "Navigation"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v10

    const/16 v8, 0xb

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x17

    const-string v2, "\u2299"

    const-string v3, "Centro D-Pad"

    const-string v4, "D-Pad Center"

    const-string v5, "Navega\u00e7\u00e3o"

    const-string v6, "Navigation"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0xc

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x7a

    const-string v2, "Home"

    const-string v3, "Home (in\u00edcio)"

    const-string v4, "Home"

    const-string v5, "Navega\u00e7\u00e3o"

    const-string v6, "Navigation"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0xd

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x7b

    const-string v2, "End"

    const-string v3, "End (fim)"

    const-string v4, "End"

    const-string v5, "Navega\u00e7\u00e3o"

    const-string v6, "Navigation"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0xe

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x5c

    const-string v2, "PgUp"

    const-string v3, "Page Up"

    const-string v4, "Page Up"

    const-string v5, "Navega\u00e7\u00e3o"

    const-string v6, "Navigation"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0xf

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x5d

    const-string v2, "PgDn"

    const-string v3, "Page Down"

    const-string v4, "Page Down"

    const-string v5, "Navega\u00e7\u00e3o"

    const-string v6, "Navigation"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x10

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/4 v1, -0x1

    const-string v2, "\u21e7"

    const-string v3, "Shift"

    const-string v4, "Shift"

    const-string v5, "Modificadores"

    const-string v6, "Modifiers"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x11

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x71

    const-string v2, "Ctrl"

    const-string v3, "Ctrl"

    const-string v4, "Ctrl"

    const-string v5, "Modificadores"

    const-string v6, "Modifiers"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x12

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x39

    const-string v2, "Alt"

    const-string v3, "Alt"

    const-string v4, "Alt"

    const-string v5, "Modificadores"

    const-string v6, "Modifiers"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x13

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x75

    const-string v2, "Meta"

    const-string v3, "Meta / Super"

    const-string v4, "Meta / Super"

    const-string v5, "Modificadores"

    const-string v6, "Modifiers"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x14

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x77

    const-string v2, "Fn"

    const-string v3, "Fn"

    const-string v4, "Fn"

    const-string v5, "Modificadores"

    const-string v6, "Modifiers"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x15

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x83

    const-string v2, "F1"

    const-string v3, "Tecla F1"

    const-string v4, "Function F1"

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x16

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x84

    const-string v2, "F2"

    const-string v3, "Tecla F2"

    const-string v4, "Function F2"

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x17

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x85

    const-string v2, "F3"

    const-string v3, "Tecla F3"

    const-string v4, "Function F3"

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x18

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x86

    const-string v2, "F4"

    const-string v3, "Tecla F4"

    const-string v4, "Function F4"

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x19

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x87

    const-string v2, "F5"

    const-string v3, "Tecla F5"

    const-string v4, "Function F5"

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x1a

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x88

    const-string v2, "F6"

    const-string v3, "Tecla F6"

    const-string v4, "Function F6"

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x1b

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x89

    const-string v2, "F7"

    const-string v3, "Tecla F7"

    const-string v4, "Function F7"

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x1c

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x8a

    const-string v2, "F8"

    const-string v3, "Tecla F8"

    const-string v4, "Function F8"

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x1d

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x8b

    const-string v2, "F9"

    const-string v3, "Tecla F9"

    const-string v4, "Function F9"

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x1e

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x8c

    const-string v2, "F10"

    const-string v3, "Tecla F10"

    const-string v4, "Function F10"

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x1f

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x8d

    const-string v2, "F11"

    const-string v3, "Tecla F11"

    const-string v4, "Function F11"

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x8e

    const-string v2, "F12"

    const-string v3, "Tecla F12"

    const-string v4, "Function F12"

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v11

    const/16 v8, 0x21

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x132

    const-string v2, "Barra"

    const-string v3, "Barra Mr Keyboard"

    const-string v4, "Mr Keyboard Toolbar"

    const-string v5, "Sistema"

    const-string v6, "System"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x22

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x64

    const-string v2, "\u2699"

    const-string v3, "Configura\u00e7\u00f5es"

    const-string v4, "Settings"

    const-string v5, "Sistema"

    const-string v6, "System"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x23

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x66

    const-string v2, "\ud83c\udfa4"

    const-string v3, "Entrada por voz"

    const-string v4, "Voice Input"

    const-string v5, "Sistema"

    const-string v6, "System"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x24

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x67

    const-string v2, ","

    const-string v3, "Tecla auxiliar (v\u00edrgula/voz)"

    const-string v4, "Auxiliary Key (comma/voice)"

    const-string v5, "Sistema"

    const-string v6, "System"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x25

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x12c

    const-string v2, "123"

    const-string v3, "Pr\u00f3xima folha (ciclo)"

    const-string v4, "Next Sheet (cycle)"

    const-string v5, "Sistema"

    const-string v6, "System"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x26

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x12b

    const-string v2, "\u25c0Fol"

    const-string v3, "Folha anterior (ciclo)"

    const-string v4, "Previous Sheet (cycle)"

    const-string v5, "Sistema"

    const-string v6, "System"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x27

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x78

    const-string v2, "SysRq"

    const-string v3, "SysRq / Print Screen"

    const-string v4, "SysRq / Print Screen"

    const-string v5, "Sistema"

    const-string v6, "System"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x28

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x79

    const-string v2, "Break"

    const-string v3, "Break / Pause"

    const-string v4, "Break / Pause"

    const-string v5, "Sistema"

    const-string v6, "System"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x29

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x8f

    const-string v2, "NumLk"

    const-string v3, "Num Lock"

    const-string v4, "Num Lock"

    const-string v5, "Sistema"

    const-string v6, "System"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    const/16 v8, 0x2a

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    const/16 v1, -0x74

    const-string v2, "ScrLk"

    const-string v3, "Scroll Lock"

    const-string v4, "Scroll Lock"

    const-string v5, "Sistema"

    const-string v6, "System"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v0, v7, v8

    sput-object v7, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    .line 287
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0}, Ljava/lang/String;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/SpecialKeyPicker;->EMPTY:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 109
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I
    .locals 1

    .prologue
    .line 33
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/SpecialKeyPicker;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method static synthetic access$200(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 33
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/SpecialKeyPicker;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$700()Ljava/lang/String;
    .locals 1

    .prologue
    .line 33
    sget-object v0, Lcom/mrkeyboard/app/SpecialKeyPicker;->EMPTY:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$800()[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;
    .locals 1

    .prologue
    .line 33
    sget-object v0, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    return-object v0
.end method

.method public static defaultLabelForCode(I)Ljava/lang/String;
    .locals 1

    .prologue
    .line 121
    invoke-static {p0}, Lcom/mrkeyboard/app/SpecialKeyPicker;->findByCode(I)Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-result-object v0

    .line 122
    if-eqz v0, :cond_0

    iget-object v0, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->defaultLabel:Ljava/lang/String;

    .line 124
    :goto_0
    return-object v0

    .line 123
    :cond_0
    const/16 v0, 0x21

    if-lt p0, v0, :cond_1

    const/16 v0, 0x7e

    if-le p0, v0, :cond_2

    :cond_1
    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 124
    :cond_2
    int-to-char v0, p0

    invoke-static {v0}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static describeCode(Landroid/content/Context;I)Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    .line 129
    invoke-static {p1}, Lcom/mrkeyboard/app/SpecialKeyPicker;->findByCode(I)Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-result-object v0

    .line 130
    if-eqz v0, :cond_1

    .line 131
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v1

    .line 132
    const-string v2, "mr_pick_describe"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    if-eqz v1, :cond_0

    iget-object v0, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->namePt:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    aput-object v0, v3, v4

    .line 133
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v3, v5

    .line 132
    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/SpecialKeyPicker;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 135
    :goto_1
    return-object v0

    .line 132
    :cond_0
    iget-object v0, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->nameEn:Ljava/lang/String;

    goto :goto_0

    .line 135
    :cond_1
    const-string v0, "mr_pick_custom_code"

    new-array v1, v5, [Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v1, v4

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/SpecialKeyPicker;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method public static findByCode(I)Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;
    .locals 2

    .prologue
    .line 113
    const/4 v0, 0x0

    :goto_0
    sget-object v1, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    array-length v1, v1

    if-ge v0, v1, :cond_1

    .line 114
    sget-object v1, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    aget-object v1, v1, v0

    iget v1, v1, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->code:I

    if-ne v1, p0, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    aget-object v0, v1, v0

    .line 116
    :goto_1
    return-object v0

    .line 113
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 116
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method public static getAllEntries()Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;",
            ">;"
        }
    .end annotation

    .prologue
    .line 140
    new-instance v1, Ljava/util/ArrayList;

    sget-object v0, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    array-length v0, v0

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(I)V

    .line 141
    const/4 v0, 0x0

    :goto_0
    sget-object v2, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    array-length v2, v2

    if-ge v0, v2, :cond_0

    .line 142
    sget-object v2, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    aget-object v2, v2, v0

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 141
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 144
    :cond_0
    return-object v1
.end method

.method private static res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 298
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p1, p2, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public static show(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V
    .locals 1

    .prologue
    .line 151
    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;

    invoke-direct {v0, p0, p1, p2}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;-><init>(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->show()V

    .line 152
    return-void
.end method

.method public static showCustomCodeDialog(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V
    .locals 7

    .prologue
    const/4 v6, 0x0

    const/4 v5, 0x0

    .line 262
    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const-string v1, "mr_pick_custom"

    const-string v2, "layout"

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/SpecialKeyPicker;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1, v6}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 263
    const-string v0, "code_field"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    .line 264
    const/16 v2, 0x1002

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setInputType(I)V

    .line 265
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 266
    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-interface {v2}, Landroid/text/Editable;->length()I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setSelection(I)V

    .line 267
    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-direct {v2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v3, "mr_pick_custom_title"

    new-array v4, v5, [Ljava/lang/Object;

    .line 268
    invoke-static {p0, v3, v4}, Lcom/mrkeyboard/app/SpecialKeyPicker;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 269
    invoke-virtual {v2, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const-string v2, "mr_pick_apply"

    new-array v3, v5, [Ljava/lang/Object;

    .line 270
    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/SpecialKeyPicker;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/mrkeyboard/app/SpecialKeyPicker$1;

    invoke-direct {v3, v0, p2, p0}, Lcom/mrkeyboard/app/SpecialKeyPicker$1;-><init>(Landroid/widget/EditText;Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;Landroid/content/Context;)V

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_pick_cancel"

    new-array v2, v5, [Ljava/lang/Object;

    .line 280
    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/SpecialKeyPicker;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v6}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 281
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 282
    return-void
.end method

.method private static varargs text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 290
    const-string v0, "string"

    invoke-static {p0, p1, v0}, Lcom/mrkeyboard/app/SpecialKeyPicker;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 291
    if-nez v0, :cond_0

    .line 292
    :goto_0
    return-object p1

    :cond_0
    array-length v1, p2

    if-nez v1, :cond_1

    .line 293
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    :goto_1
    move-object p1, v0

    .line 292
    goto :goto_0

    .line 294
    :cond_1
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0, p2}, Landroid/content/res/Resources;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method
