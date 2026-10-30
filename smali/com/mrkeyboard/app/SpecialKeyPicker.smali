.class public final Lcom/mrkeyboard/app/SpecialKeyPicker;
.super Ljava/lang/Object;
.source "SpecialKeyPicker.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;,
        Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;
    }
.end annotation


# static fields
.field private static final CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;


# direct methods
.method static constructor <clinit>()V
    .registers 56

    .line 23
    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object v7, v0

    const-string v5, "Edi\u00e7\u00e3o"

    const-string v6, "Editing"

    const/4 v1, -0x5

    const-string v2, "\u232b"

    const-string v3, "Backspace (apagar)"

    const-string v4, "Backspace"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v9, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object v8, v9

    const-string v14, "Edi\u00e7\u00e3o"

    const-string v15, "Editing"

    const/16 v10, -0x70

    const-string v11, "Del\u2192"

    const-string v12, "Delete \u00e0 frente"

    const-string v13, "Forward Delete"

    invoke-direct/range {v9 .. v15}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object v9, v0

    const-string v5, "Edi\u00e7\u00e3o"

    const-string v6, "Editing"

    const/16 v1, 0xa

    const-string v2, "\u23ce"

    const-string v3, "Enter / Retorno"

    const-string v4, "Enter / Return"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v11, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object v10, v11

    const-string v16, "Edi\u00e7\u00e3o"

    const-string v17, "Editing"

    const/16 v12, 0x9

    const-string v13, "\u21e5"

    const-string v14, "Tab (tabula\u00e7\u00e3o)"

    const-string v15, "Tab"

    invoke-direct/range {v11 .. v17}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object v11, v0

    const-string v5, "Edi\u00e7\u00e3o"

    const-string v6, "Editing"

    const/16 v1, 0x20

    const-string v2, "\u2423"

    const-string v3, "Espa\u00e7o"

    const-string v4, "Space"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v13, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object v12, v13

    const-string v18, "Edi\u00e7\u00e3o"

    const-string v19, "Editing"

    const/16 v14, -0x7c

    const-string v15, "Ins"

    const-string v16, "Insert"

    const-string v17, "Insert"

    invoke-direct/range {v13 .. v19}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object v13, v0

    const-string v5, "Edi\u00e7\u00e3o"

    const-string v6, "Editing"

    const/16 v1, -0x6f

    const-string v2, "Esc"

    const-string v3, "Escape (Esc)"

    const-string v4, "Escape (Esc)"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v15, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object v14, v15

    const-string v20, "Navega\u00e7\u00e3o"

    const-string v21, "Navigation"

    const/16 v16, -0x15

    const-string v17, "\u2190"

    const-string v18, "Seta esquerda"

    const-string v19, "Arrow Left"

    invoke-direct/range {v15 .. v21}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object v15, v0

    const-string v5, "Navega\u00e7\u00e3o"

    const-string v6, "Navigation"

    const/16 v1, -0x16

    const-string v2, "\u2192"

    const-string v3, "Seta direita"

    const-string v4, "Arrow Right"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v17, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v16, v17

    const-string v22, "Navega\u00e7\u00e3o"

    const-string v23, "Navigation"

    const/16 v18, -0x13

    const-string v19, "\u2191"

    const-string v20, "Seta cima"

    const-string v21, "Arrow Up"

    invoke-direct/range {v17 .. v23}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v17, v0

    const-string v5, "Navega\u00e7\u00e3o"

    const-string v6, "Navigation"

    const/16 v1, -0x14

    const-string v2, "\u2193"

    const-string v3, "Seta baixo"

    const-string v4, "Arrow Down"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v19, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v18, v19

    const-string v24, "Navega\u00e7\u00e3o"

    const-string v25, "Navigation"

    const/16 v20, -0x17

    const-string v21, "\u2299"

    const-string v22, "Centro D-Pad"

    const-string v23, "D-Pad Center"

    invoke-direct/range {v19 .. v25}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v19, v0

    const-string v5, "Navega\u00e7\u00e3o"

    const-string v6, "Navigation"

    const/16 v1, -0x7a

    const-string v2, "Home"

    const-string v3, "Home (in\u00edcio)"

    const-string v4, "Home"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v21, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v20, v21

    const-string v26, "Navega\u00e7\u00e3o"

    const-string v27, "Navigation"

    const/16 v22, -0x7b

    const-string v23, "End"

    const-string v24, "End (fim)"

    const-string v25, "End"

    invoke-direct/range {v21 .. v27}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v21, v0

    const-string v5, "Navega\u00e7\u00e3o"

    const-string v6, "Navigation"

    const/16 v1, -0x5c

    const-string v2, "PgUp"

    const-string v3, "Page Up"

    const-string v4, "Page Up"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v23, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v22, v23

    const-string v28, "Navega\u00e7\u00e3o"

    const-string v29, "Navigation"

    const/16 v24, -0x5d

    const-string v25, "PgDn"

    const-string v26, "Page Down"

    const-string v27, "Page Down"

    invoke-direct/range {v23 .. v29}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v23, v0

    const-string v5, "Modificadores"

    const-string v6, "Modifiers"

    const/4 v1, -0x1

    const-string v2, "\u21e7"

    const-string v3, "Shift"

    const-string v4, "Shift"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v25, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v24, v25

    const-string v30, "Modificadores"

    const-string v31, "Modifiers"

    const/16 v26, -0x71

    const-string v27, "Ctrl"

    const-string v28, "Ctrl"

    const-string v29, "Ctrl"

    invoke-direct/range {v25 .. v31}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v25, v0

    const-string v5, "Modificadores"

    const-string v6, "Modifiers"

    const/16 v1, -0x39

    const-string v2, "Alt"

    const-string v3, "Alt"

    const-string v4, "Alt"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v27, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v26, v27

    const-string v32, "Modificadores"

    const-string v33, "Modifiers"

    const/16 v28, -0x75

    const-string v29, "Meta"

    const-string v30, "Meta / Super"

    const-string v31, "Meta / Super"

    invoke-direct/range {v27 .. v33}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v27, v0

    const-string v5, "Modificadores"

    const-string v6, "Modifiers"

    const/16 v1, -0x77

    const-string v2, "Fn"

    const-string v3, "Fn"

    const-string v4, "Fn"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v29, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v28, v29

    const-string v34, "Fun\u00e7\u00e3o"

    const-string v35, "Function Keys"

    const/16 v30, -0x83

    const-string v31, "F1"

    const-string v32, "Tecla F1"

    const-string v33, "Function F1"

    invoke-direct/range {v29 .. v35}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v29, v0

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    const/16 v1, -0x84

    const-string v2, "F2"

    const-string v3, "Tecla F2"

    const-string v4, "Function F2"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v31, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v30, v31

    const-string v36, "Fun\u00e7\u00e3o"

    const-string v37, "Function Keys"

    const/16 v32, -0x85

    const-string v33, "F3"

    const-string v34, "Tecla F3"

    const-string v35, "Function F3"

    invoke-direct/range {v31 .. v37}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v31, v0

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    const/16 v1, -0x86

    const-string v2, "F4"

    const-string v3, "Tecla F4"

    const-string v4, "Function F4"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v33, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v32, v33

    const-string v38, "Fun\u00e7\u00e3o"

    const-string v39, "Function Keys"

    const/16 v34, -0x87

    const-string v35, "F5"

    const-string v36, "Tecla F5"

    const-string v37, "Function F5"

    invoke-direct/range {v33 .. v39}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v33, v0

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    const/16 v1, -0x88

    const-string v2, "F6"

    const-string v3, "Tecla F6"

    const-string v4, "Function F6"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v35, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v34, v35

    const-string v40, "Fun\u00e7\u00e3o"

    const-string v41, "Function Keys"

    const/16 v36, -0x89

    const-string v37, "F7"

    const-string v38, "Tecla F7"

    const-string v39, "Function F7"

    invoke-direct/range {v35 .. v41}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v35, v0

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    const/16 v1, -0x8a

    const-string v2, "F8"

    const-string v3, "Tecla F8"

    const-string v4, "Function F8"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v37, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v36, v37

    const-string v42, "Fun\u00e7\u00e3o"

    const-string v43, "Function Keys"

    const/16 v38, -0x8b

    const-string v39, "F9"

    const-string v40, "Tecla F9"

    const-string v41, "Function F9"

    invoke-direct/range {v37 .. v43}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v37, v0

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    const/16 v1, -0x8c

    const-string v2, "F10"

    const-string v3, "Tecla F10"

    const-string v4, "Function F10"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v39, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v38, v39

    const-string v44, "Fun\u00e7\u00e3o"

    const-string v45, "Function Keys"

    const/16 v40, -0x8d

    const-string v41, "F11"

    const-string v42, "Tecla F11"

    const-string v43, "Function F11"

    invoke-direct/range {v39 .. v45}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v39, v0

    const-string v5, "Fun\u00e7\u00e3o"

    const-string v6, "Function Keys"

    const/16 v1, -0x8e

    const-string v2, "F12"

    const-string v3, "Tecla F12"

    const-string v4, "Function F12"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v41, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v40, v41

    const-string v46, "Sistema"

    const-string v47, "System"

    const/16 v42, -0x132

    const-string v43, "Barra"

    const-string v44, "Barra Mr Keyboard"

    const-string v45, "Mr Keyboard Toolbar"

    invoke-direct/range {v41 .. v47}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v41, v0

    const-string v5, "Sistema"

    const-string v6, "System"

    const/16 v1, -0x64

    const-string v2, "\u2699"

    const-string v3, "Configura\u00e7\u00f5es"

    const-string v4, "Settings"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v43, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v42, v43

    const-string v48, "Sistema"

    const-string v49, "System"

    const/16 v44, -0x66

    const-string v45, "\ud83c\udfa4"

    const-string v46, "Entrada por voz"

    const-string v47, "Voice Input"

    invoke-direct/range {v43 .. v49}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v43, v0

    const-string v5, "Sistema"

    const-string v6, "System"

    const/16 v1, -0x67

    const-string v2, ","

    const-string v3, "Tecla auxiliar (v\u00edrgula/voz)"

    const-string v4, "Auxiliary Key (comma/voice)"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v45, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v44, v45

    const-string v50, "Sistema"

    const-string v51, "System"

    const/16 v46, -0x12c

    const-string v47, "123"

    const-string v48, "Pr\u00f3xima folha (ciclo)"

    const-string v49, "Next Sheet (cycle)"

    invoke-direct/range {v45 .. v51}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v45, v0

    const-string v5, "Sistema"

    const-string v6, "System"

    const/16 v1, -0x12b

    const-string v2, "\u25c0Fol"

    const-string v3, "Folha anterior (ciclo)"

    const-string v4, "Previous Sheet (cycle)"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v47, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v46, v47

    const-string v52, "Sistema"

    const-string v53, "System"

    const/16 v48, -0x78

    const-string v49, "SysRq"

    const-string v50, "SysRq / Print Screen"

    const-string v51, "SysRq / Print Screen"

    invoke-direct/range {v47 .. v53}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v47, v0

    const-string v5, "Sistema"

    const-string v6, "System"

    const/16 v1, -0x79

    const-string v2, "Break"

    const-string v3, "Break / Pause"

    const-string v4, "Break / Pause"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v49, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v48, v49

    const-string v54, "Sistema"

    const-string v55, "System"

    const/16 v50, -0x8f

    const-string v51, "NumLk"

    const-string v52, "Num Lock"

    const-string v53, "Num Lock"

    invoke-direct/range {v49 .. v55}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-object/from16 v49, v0

    const-string v5, "Sistema"

    const-string v6, "System"

    const/16 v1, -0x74

    const-string v2, "ScrLk"

    const-string v3, "Scroll Lock"

    const-string v4, "Scroll Lock"

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    filled-new-array/range {v7 .. v49}, [Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 73
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;
    .registers 1

    .line 22
    sget-object v0, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    return-object v0
.end method

.method static synthetic access$100(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V
    .registers 3

    .line 22
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/SpecialKeyPicker;->showCustomCodeDialog(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V

    return-void
.end method

.method public static defaultLabelForCode(I)Ljava/lang/String;
    .registers 2

    .line 85
    invoke-static {p0}, Lcom/mrkeyboard/app/SpecialKeyPicker;->findByCode(I)Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-result-object v0

    .line 86
    if-eqz v0, :cond_9

    iget-object p0, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->defaultLabel:Ljava/lang/String;

    return-object p0

    .line 87
    :cond_9
    const/16 v0, 0x21

    if-lt p0, v0, :cond_17

    const/16 v0, 0x7e

    if-gt p0, v0, :cond_17

    int-to-char p0, p0

    invoke-static {p0}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 88
    :cond_17
    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static describeCode(Landroid/content/Context;I)Ljava/lang/String;
    .registers 5

    .line 92
    invoke-static {p1}, Lcom/mrkeyboard/app/SpecialKeyPicker;->findByCode(I)Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-result-object v0

    .line 93
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result p0

    .line 94
    const-string v1, ")"

    if-eqz v0, :cond_2f

    .line 95
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz p0, :cond_16

    iget-object p0, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->namePt:Ljava/lang/String;

    goto :goto_18

    :cond_16
    iget-object p0, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->nameEn:Ljava/lang/String;

    :goto_18
    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, " ("

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 97
    :cond_2f
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz p0, :cond_39

    const-string p0, "C\u00f3digo personalizado ("

    goto :goto_3b

    :cond_39
    const-string p0, "Custom code ("

    :goto_3b
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static findByCode(I)Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;
    .registers 3

    .line 76
    const/4 v0, 0x0

    :goto_1
    sget-object v1, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    array-length v1, v1

    if-ge v0, v1, :cond_16

    .line 77
    sget-object v1, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    aget-object v1, v1, v0

    iget v1, v1, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->code:I

    if-ne v1, p0, :cond_13

    .line 78
    sget-object p0, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    aget-object p0, p0, v0

    return-object p0

    .line 76
    :cond_13
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 81
    :cond_16
    const/4 p0, 0x0

    return-object p0
.end method

.method public static getAllEntries()Ljava/util/List;
    .registers 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;",
            ">;"
        }
    .end annotation

    .line 101
    new-instance v0, Ljava/util/ArrayList;

    sget-object v1, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    array-length v1, v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 102
    const/4 v1, 0x0

    :goto_9
    sget-object v2, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    array-length v2, v2

    if-ge v1, v2, :cond_18

    .line 103
    sget-object v2, Lcom/mrkeyboard/app/SpecialKeyPicker;->CATALOG:[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    aget-object v2, v2, v1

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 102
    add-int/lit8 v1, v1, 0x1

    goto :goto_9

    .line 105
    :cond_18
    return-object v0
.end method

.method public static show(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V
    .registers 14

    .line 109
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v3

    .line 110
    const/high16 v0, 0x41900000    # 18.0f

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v1

    .line 112
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 113
    const/4 v4, 0x1

    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 114
    const/high16 v5, 0x41000000    # 8.0f

    invoke-static {p0, v5}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v6

    invoke-virtual {v2, v1, v1, v1, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 116
    new-instance v1, Landroid/widget/TextView;

    invoke-direct {v1, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 117
    if-eqz v3, :cond_26

    const-string v6, "Escolher tecla especial"

    goto :goto_28

    :cond_26
    const-string v6, "Choose special key"

    :goto_28
    invoke-virtual {v1, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 118
    const v6, -0x160f07

    invoke-virtual {v1, v6}, Landroid/widget/TextView;->setTextColor(I)V

    .line 119
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setTextSize(F)V

    .line 120
    sget-object v0, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 121
    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 123
    nop

    .line 125
    if-eqz v3, :cond_42

    const-string v0, "Buscar nome, categoria ou c\u00f3digo..."

    goto :goto_44

    :cond_42
    const-string v0, "Search name, category or code..."

    .line 123
    :goto_44
    invoke-static {p0, v0, v4}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v8

    .line 128
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x2

    const/4 v6, -0x1

    invoke-direct {v0, v6, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 129
    const/high16 v1, 0x41400000    # 12.0f

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v1

    iput v1, v0, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 130
    invoke-static {p0, v5}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v1

    iput v1, v0, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 131
    invoke-virtual {v2, v8, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 133
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 134
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v5, 0x43aa0000    # 340.0f

    invoke-static {p0, v5}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v5

    invoke-direct {v1, v6, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 135
    new-instance v1, Landroid/widget/LinearLayout;

    invoke-direct {v1, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 136
    invoke-virtual {v1, v4}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 137
    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    .line 139
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 140
    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    .line 141
    if-eqz v3, :cond_8b

    const-string v2, "C\u00f3digo avan\u00e7ado..."

    goto :goto_8d

    :cond_8b
    const-string v2, "Custom code..."

    :goto_8d
    const/4 v4, 0x0

    invoke-virtual {v0, v2, v4}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 142
    if-eqz v3, :cond_96

    const-string v2, "Cancelar"

    goto :goto_98

    :cond_96
    const-string v2, "Cancel"

    :goto_98
    invoke-virtual {v0, v2, v4}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 143
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v9

    .line 145
    new-instance v10, Lcom/mrkeyboard/app/SpecialKeyPicker$1;

    move-object v0, v10

    move-object v2, v8

    move-object v4, p0

    move v5, p1

    move-object v6, v9

    move-object v7, p2

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/SpecialKeyPicker$1;-><init>(Landroid/widget/LinearLayout;Landroid/widget/EditText;ZLandroid/content/Context;ILandroid/app/AlertDialog;Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V

    .line 242
    invoke-interface {v10}, Ljava/lang/Runnable;->run()V

    .line 243
    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$2;

    invoke-direct {v0, v10}, Lcom/mrkeyboard/app/SpecialKeyPicker$2;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v8, v0}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 254
    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$3;

    invoke-direct {v0, v9, p0, p1, p2}, Lcom/mrkeyboard/app/SpecialKeyPicker$3;-><init>(Landroid/app/AlertDialog;Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V

    invoke-virtual {v9, v0}, Landroid/app/AlertDialog;->setOnShowListener(Landroid/content/DialogInterface$OnShowListener;)V

    .line 266
    invoke-virtual {v9}, Landroid/app/AlertDialog;->show()V

    .line 267
    return-void
.end method

.method private static showCustomCodeDialog(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V
    .registers 9

    .line 270
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 271
    new-instance v1, Landroid/widget/LinearLayout;

    invoke-direct {v1, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 272
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 273
    const/high16 v3, 0x41a00000    # 20.0f

    invoke-static {p0, v3}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v3

    .line 274
    const/high16 v4, 0x41400000    # 12.0f

    invoke-static {p0, v4}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v4

    const/high16 v5, 0x40800000    # 4.0f

    invoke-static {p0, v5}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v5

    invoke-virtual {v1, v3, v4, v3, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 276
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 277
    if-eqz v0, :cond_2c

    .line 278
    const-string v4, "Informe o c\u00f3digo inteiro da tecla (ex.: -21 para seta \u2190, 9 para Tab, -306 para Barra):"

    goto :goto_2e

    .line 279
    :cond_2c
    const-string v4, "Enter integer key code (e.g. -21 for Left Arrow, 9 for Tab, -306 for Toolbar):"

    .line 277
    :goto_2e
    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 280
    const v4, -0x6c5c46

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setTextColor(I)V

    .line 281
    const/high16 v4, 0x41500000    # 13.0f

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setTextSize(F)V

    .line 282
    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 284
    const-string v3, "-21"

    invoke-static {p0, v3, v2}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v2

    .line 285
    const/16 v3, 0x1002

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setInputType(I)V

    .line 286
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 287
    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-interface {p1}, Landroid/text/Editable;->length()I

    move-result p1

    invoke-virtual {v2, p1}, Landroid/widget/EditText;->setSelection(I)V

    .line 288
    new-instance p1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-direct {p1, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 289
    const/high16 v3, 0x41200000    # 10.0f

    invoke-static {p0, v3}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v3

    iput v3, p1, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 290
    invoke-virtual {v1, v2, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 292
    new-instance p1, Landroid/app/AlertDialog$Builder;

    invoke-direct {p1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 293
    if-eqz v0, :cond_78

    const-string v3, "C\u00f3digo avan\u00e7ado"

    goto :goto_7a

    :cond_78
    const-string v3, "Custom key code"

    :goto_7a
    invoke-virtual {p1, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 294
    invoke-virtual {p1, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 295
    if-eqz v0, :cond_87

    const-string v1, "Aplicar"

    goto :goto_89

    :cond_87
    const-string v1, "Apply"

    :goto_89
    new-instance v3, Lcom/mrkeyboard/app/SpecialKeyPicker$4;

    invoke-direct {v3, v2, p2, p0, v0}, Lcom/mrkeyboard/app/SpecialKeyPicker$4;-><init>(Landroid/widget/EditText;Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;Landroid/content/Context;Z)V

    invoke-virtual {p1, v1, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    .line 308
    if-eqz v0, :cond_97

    const-string p1, "Cancelar"

    goto :goto_99

    :cond_97
    const-string p1, "Cancel"

    :goto_99
    const/4 p2, 0x0

    invoke-virtual {p0, p1, p2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p0

    .line 309
    invoke-virtual {p0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 310
    return-void
.end method
