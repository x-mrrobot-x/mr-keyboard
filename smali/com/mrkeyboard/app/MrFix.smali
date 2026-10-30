.class public final Lcom/mrkeyboard/app/MrFix;
.super Ljava/lang/Object;
.source "MrFix.java"


# static fields
.field private static final PAIRS:[Ljava/lang/String;

.field private static sMap:Ljava/util/HashMap;
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
    .line 14
    const/16 v0, 0x1b2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "vc"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "voc\u00ea"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "vcs"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "voc\u00eas"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "tbm"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "tamb\u00e9m"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "tb"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "tamb\u00e9m"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "tmb"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "tamb\u00e9m"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "pq"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "porque"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "qdo"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "quando"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "qnd"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "quando"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, "qndo"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "quando"

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, "hj"

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, "hoje"

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, "td"

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string v2, "tudo"

    aput-object v2, v0, v1

    const/16 v1, 0x16

    const-string v2, "tds"

    aput-object v2, v0, v1

    const/16 v1, 0x17

    const-string v2, "todos"

    aput-object v2, v0, v1

    const/16 v1, 0x18

    const-string v2, "mto"

    aput-object v2, v0, v1

    const/16 v1, 0x19

    const-string v2, "muito"

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    const-string v2, "mt"

    aput-object v2, v0, v1

    const/16 v1, 0x1b

    const-string v2, "muito"

    aput-object v2, v0, v1

    const/16 v1, 0x1c

    const-string v2, "mta"

    aput-object v2, v0, v1

    const/16 v1, 0x1d

    const-string v2, "muita"

    aput-object v2, v0, v1

    const/16 v1, 0x1e

    const-string v2, "mtos"

    aput-object v2, v0, v1

    const/16 v1, 0x1f

    const-string v2, "muitos"

    aput-object v2, v0, v1

    const/16 v1, 0x20

    const-string v2, "mtas"

    aput-object v2, v0, v1

    const/16 v1, 0x21

    const-string v2, "muitas"

    aput-object v2, v0, v1

    const/16 v1, 0x22

    const-string v2, "msm"

    aput-object v2, v0, v1

    const/16 v1, 0x23

    const-string v2, "mesmo"

    aput-object v2, v0, v1

    const/16 v1, 0x24

    const-string v2, "oq"

    aput-object v2, v0, v1

    const/16 v1, 0x25

    const-string v2, "o que"

    aput-object v2, v0, v1

    const/16 v1, 0x26

    const-string v2, "obg"

    aput-object v2, v0, v1

    const/16 v1, 0x27

    const-string v2, "obrigado"

    aput-object v2, v0, v1

    const/16 v1, 0x28

    const-string v2, "obgd"

    aput-object v2, v0, v1

    const/16 v1, 0x29

    const-string v2, "obrigado"

    aput-object v2, v0, v1

    const/16 v1, 0x2a

    const-string v2, "obgda"

    aput-object v2, v0, v1

    const/16 v1, 0x2b

    const-string v2, "obrigada"

    aput-object v2, v0, v1

    const/16 v1, 0x2c

    const-string v2, "vlw"

    aput-object v2, v0, v1

    const/16 v1, 0x2d

    const-string v2, "valeu"

    aput-object v2, v0, v1

    const/16 v1, 0x2e

    const-string v2, "blz"

    aput-object v2, v0, v1

    const/16 v1, 0x2f

    const-string v2, "beleza"

    aput-object v2, v0, v1

    const/16 v1, 0x30

    const-string v2, "cmg"

    aput-object v2, v0, v1

    const/16 v1, 0x31

    const-string v2, "comigo"

    aput-object v2, v0, v1

    const/16 v1, 0x32

    const-string v2, "ctg"

    aput-object v2, v0, v1

    const/16 v1, 0x33

    const-string v2, "contigo"

    aput-object v2, v0, v1

    const/16 v1, 0x34

    const-string v2, "nd"

    aput-object v2, v0, v1

    const/16 v1, 0x35

    const-string v2, "nada"

    aput-object v2, v0, v1

    const/16 v1, 0x36

    const-string v2, "ngm"

    aput-object v2, v0, v1

    const/16 v1, 0x37

    const-string v2, "ningu\u00e9m"

    aput-object v2, v0, v1

    const/16 v1, 0x38

    const-string v2, "agr"

    aput-object v2, v0, v1

    const/16 v1, 0x39

    const-string v2, "agora"

    aput-object v2, v0, v1

    const/16 v1, 0x3a

    const-string v2, "dps"

    aput-object v2, v0, v1

    const/16 v1, 0x3b

    const-string v2, "depois"

    aput-object v2, v0, v1

    const/16 v1, 0x3c

    const-string v2, "fds"

    aput-object v2, v0, v1

    const/16 v1, 0x3d

    const-string v2, "fim de semana"

    aput-object v2, v0, v1

    const/16 v1, 0x3e

    const-string v2, "bj"

    aput-object v2, v0, v1

    const/16 v1, 0x3f

    const-string v2, "beijo"

    aput-object v2, v0, v1

    const/16 v1, 0x40

    const-string v2, "bjs"

    aput-object v2, v0, v1

    const/16 v1, 0x41

    const-string v2, "beijos"

    aput-object v2, v0, v1

    const/16 v1, 0x42

    const-string v2, "bjo"

    aput-object v2, v0, v1

    const/16 v1, 0x43

    const-string v2, "beijo"

    aput-object v2, v0, v1

    const/16 v1, 0x44

    const-string v2, "bjos"

    aput-object v2, v0, v1

    const/16 v1, 0x45

    const-string v2, "beijos"

    aput-object v2, v0, v1

    const/16 v1, 0x46

    const-string v2, "abs"

    aput-object v2, v0, v1

    const/16 v1, 0x47

    const-string v2, "abra\u00e7os"

    aput-object v2, v0, v1

    const/16 v1, 0x48

    const-string v2, "pfv"

    aput-object v2, v0, v1

    const/16 v1, 0x49

    const-string v2, "por favor"

    aput-object v2, v0, v1

    const/16 v1, 0x4a

    const-string v2, "pf"

    aput-object v2, v0, v1

    const/16 v1, 0x4b

    const-string v2, "por favor"

    aput-object v2, v0, v1

    const/16 v1, 0x4c

    const-string v2, "qq"

    aput-object v2, v0, v1

    const/16 v1, 0x4d

    const-string v2, "qualquer"

    aput-object v2, v0, v1

    const/16 v1, 0x4e

    const-string v2, "qlq"

    aput-object v2, v0, v1

    const/16 v1, 0x4f

    const-string v2, "qualquer"

    aput-object v2, v0, v1

    const/16 v1, 0x50

    const-string v2, "sdds"

    aput-object v2, v0, v1

    const/16 v1, 0x51

    const-string v2, "saudades"

    aput-object v2, v0, v1

    const/16 v1, 0x52

    const-string v2, "vdd"

    aput-object v2, v0, v1

    const/16 v1, 0x53

    const-string v2, "verdade"

    aput-object v2, v0, v1

    const/16 v1, 0x54

    const-string v2, "msg"

    aput-object v2, v0, v1

    const/16 v1, 0x55

    const-string v2, "mensagem"

    aput-object v2, v0, v1

    const/16 v1, 0x56

    const-string v2, "msgs"

    aput-object v2, v0, v1

    const/16 v1, 0x57

    const-string v2, "mensagens"

    aput-object v2, v0, v1

    const/16 v1, 0x58

    const-string v2, "naum"

    aput-object v2, v0, v1

    const/16 v1, 0x59

    const-string v2, "n\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x5a

    const-string v2, "neh"

    aput-object v2, v0, v1

    const/16 v1, 0x5b

    const-string v2, "n\u00e9"

    aput-object v2, v0, v1

    const/16 v1, 0x5c

    const-string v2, "eh"

    aput-object v2, v0, v1

    const/16 v1, 0x5d

    const-string v2, "\u00e9"

    aput-object v2, v0, v1

    const/16 v1, 0x5e

    const-string v2, "aki"

    aput-object v2, v0, v1

    const/16 v1, 0x5f

    const-string v2, "aqui"

    aput-object v2, v0, v1

    const/16 v1, 0x60

    const-string v2, "axo"

    aput-object v2, v0, v1

    const/16 v1, 0x61

    const-string v2, "acho"

    aput-object v2, v0, v1

    const/16 v1, 0x62

    const-string v2, "kd"

    aput-object v2, v0, v1

    const/16 v1, 0x63

    const-string v2, "cad\u00ea"

    aput-object v2, v0, v1

    const/16 v1, 0x64

    const-string v2, "cmo"

    aput-object v2, v0, v1

    const/16 v1, 0x65

    const-string v2, "como"

    aput-object v2, v0, v1

    const/16 v1, 0x66

    const-string v2, "tah"

    aput-object v2, v0, v1

    const/16 v1, 0x67

    const-string v2, "t\u00e1"

    aput-object v2, v0, v1

    const/16 v1, 0x68

    const-string v2, "qto"

    aput-object v2, v0, v1

    const/16 v1, 0x69

    const-string v2, "quanto"

    aput-object v2, v0, v1

    const/16 v1, 0x6a

    const-string v2, "qta"

    aput-object v2, v0, v1

    const/16 v1, 0x6b

    const-string v2, "quanta"

    aput-object v2, v0, v1

    const/16 v1, 0x6c

    const-string v2, "qts"

    aput-object v2, v0, v1

    const/16 v1, 0x6d

    const-string v2, "quantos"

    aput-object v2, v0, v1

    const/16 v1, 0x6e

    const-string v2, "fzr"

    aput-object v2, v0, v1

    const/16 v1, 0x6f

    const-string v2, "fazer"

    aput-object v2, v0, v1

    const/16 v1, 0x70

    const-string v2, "dnv"

    aput-object v2, v0, v1

    const/16 v1, 0x71

    const-string v2, "de novo"

    aput-object v2, v0, v1

    const/16 v1, 0x72

    const-string v2, "sla"

    aput-object v2, v0, v1

    const/16 v1, 0x73

    const-string v2, "sei l\u00e1"

    aput-object v2, v0, v1

    const/16 v1, 0x74

    const-string v2, "tmj"

    aput-object v2, v0, v1

    const/16 v1, 0x75

    const-string v2, "tamo junto"

    aput-object v2, v0, v1

    const/16 v1, 0x76

    const-string v2, "mds"

    aput-object v2, v0, v1

    const/16 v1, 0x77

    const-string v2, "meu Deus"

    aput-object v2, v0, v1

    const/16 v1, 0x78

    const-string v2, "sqn"

    aput-object v2, v0, v1

    const/16 v1, 0x79

    const-string v2, "s\u00f3 que n\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x7a

    const-string v2, "pdc"

    aput-object v2, v0, v1

    const/16 v1, 0x7b

    const-string v2, "pode crer"

    aput-object v2, v0, v1

    const/16 v1, 0x7c

    const-string v2, "concerteza"

    aput-object v2, v0, v1

    const/16 v1, 0x7d

    const-string v2, "com certeza"

    aput-object v2, v0, v1

    const/16 v1, 0x7e

    const-string v2, "comcerteza"

    aput-object v2, v0, v1

    const/16 v1, 0x7f

    const-string v2, "com certeza"

    aput-object v2, v0, v1

    const/16 v1, 0x80

    const-string v2, "derrepente"

    aput-object v2, v0, v1

    const/16 v1, 0x81

    const-string v2, "de repente"

    aput-object v2, v0, v1

    const/16 v1, 0x82

    const-string v2, "derepente"

    aput-object v2, v0, v1

    const/16 v1, 0x83

    const-string v2, "de repente"

    aput-object v2, v0, v1

    const/16 v1, 0x84

    const-string v2, "porisso"

    aput-object v2, v0, v1

    const/16 v1, 0x85

    const-string v2, "por isso"

    aput-object v2, v0, v1

    const/16 v1, 0x86

    const-string v2, "apartir"

    aput-object v2, v0, v1

    const/16 v1, 0x87

    const-string v2, "a partir"

    aput-object v2, v0, v1

    const/16 v1, 0x88

    const-string v2, "denovo"

    aput-object v2, v0, v1

    const/16 v1, 0x89

    const-string v2, "de novo"

    aput-object v2, v0, v1

    const/16 v1, 0x8a

    const-string v2, "oque"

    aput-object v2, v0, v1

    const/16 v1, 0x8b

    const-string v2, "o que"

    aput-object v2, v0, v1

    const/16 v1, 0x8c

    const-string v2, "daonde"

    aput-object v2, v0, v1

    const/16 v1, 0x8d

    const-string v2, "de onde"

    aput-object v2, v0, v1

    const/16 v1, 0x8e

    const-string v2, "encima"

    aput-object v2, v0, v1

    const/16 v1, 0x8f

    const-string v2, "em cima"

    aput-object v2, v0, v1

    const/16 v1, 0x90

    const-string v2, "porfavor"

    aput-object v2, v0, v1

    const/16 v1, 0x91

    const-string v2, "por favor"

    aput-object v2, v0, v1

    const/16 v1, 0x92

    const-string v2, "enchergar"

    aput-object v2, v0, v1

    const/16 v1, 0x93

    const-string v2, "enxergar"

    aput-object v2, v0, v1

    const/16 v1, 0x94

    const-string v2, "excessao"

    aput-object v2, v0, v1

    const/16 v1, 0x95

    const-string v2, "exce\u00e7\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x96

    const-string v2, "excesao"

    aput-object v2, v0, v1

    const/16 v1, 0x97

    const-string v2, "exce\u00e7\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x98

    const-string v2, "exessao"

    aput-object v2, v0, v1

    const/16 v1, 0x99

    const-string v2, "exce\u00e7\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x9a

    const-string v2, "exesao"

    aput-object v2, v0, v1

    const/16 v1, 0x9b

    const-string v2, "exce\u00e7\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x9c

    const-string v2, "previlegio"

    aput-object v2, v0, v1

    const/16 v1, 0x9d

    const-string v2, "privil\u00e9gio"

    aput-object v2, v0, v1

    const/16 v1, 0x9e

    const-string v2, "previlegios"

    aput-object v2, v0, v1

    const/16 v1, 0x9f

    const-string v2, "privil\u00e9gios"

    aput-object v2, v0, v1

    const/16 v1, 0xa0

    const-string v2, "previlegiado"

    aput-object v2, v0, v1

    const/16 v1, 0xa1

    const-string v2, "privilegiado"

    aput-object v2, v0, v1

    const/16 v1, 0xa2

    const-string v2, "mendingo"

    aput-object v2, v0, v1

    const/16 v1, 0xa3

    const-string v2, "mendigo"

    aput-object v2, v0, v1

    const/16 v1, 0xa4

    const-string v2, "mindingo"

    aput-object v2, v0, v1

    const/16 v1, 0xa5

    const-string v2, "mendigo"

    aput-object v2, v0, v1

    const/16 v1, 0xa6

    const-string v2, "sombrancelha"

    aput-object v2, v0, v1

    const/16 v1, 0xa7

    const-string v2, "sobrancelha"

    aput-object v2, v0, v1

    const/16 v1, 0xa8

    const-string v2, "sombrancelhas"

    aput-object v2, v0, v1

    const/16 v1, 0xa9

    const-string v2, "sobrancelhas"

    aput-object v2, v0, v1

    const/16 v1, 0xaa

    const-string v2, "beneficiente"

    aput-object v2, v0, v1

    const/16 v1, 0xab

    const-string v2, "beneficente"

    aput-object v2, v0, v1

    const/16 v1, 0xac

    const-string v2, "beneficiencia"

    aput-object v2, v0, v1

    const/16 v1, 0xad

    const-string v2, "benefic\u00eancia"

    aput-object v2, v0, v1

    const/16 v1, 0xae

    const-string v2, "cidadoes"

    aput-object v2, v0, v1

    const/16 v1, 0xaf

    const-string v2, "cidad\u00e3os"

    aput-object v2, v0, v1

    const/16 v1, 0xb0

    const-string v2, "seje"

    aput-object v2, v0, v1

    const/16 v1, 0xb1

    const-string v2, "seja"

    aput-object v2, v0, v1

    const/16 v1, 0xb2

    const-string v2, "esteje"

    aput-object v2, v0, v1

    const/16 v1, 0xb3

    const-string v2, "esteja"

    aput-object v2, v0, v1

    const/16 v1, 0xb4

    const-string v2, "menas"

    aput-object v2, v0, v1

    const/16 v1, 0xb5

    const-string v2, "menos"

    aput-object v2, v0, v1

    const/16 v1, 0xb6

    const-string v2, "iorgute"

    aput-object v2, v0, v1

    const/16 v1, 0xb7

    const-string v2, "iogurte"

    aput-object v2, v0, v1

    const/16 v1, 0xb8

    const-string v2, "mortandela"

    aput-object v2, v0, v1

    const/16 v1, 0xb9

    const-string v2, "mortadela"

    aput-object v2, v0, v1

    const/16 v1, 0xba

    const-string v2, "asteristico"

    aput-object v2, v0, v1

    const/16 v1, 0xbb

    const-string v2, "asterisco"

    aput-object v2, v0, v1

    const/16 v1, 0xbc

    const-string v2, "impecilho"

    aput-object v2, v0, v1

    const/16 v1, 0xbd

    const-string v2, "empecilho"

    aput-object v2, v0, v1

    const/16 v1, 0xbe

    const-string v2, "advinhar"

    aput-object v2, v0, v1

    const/16 v1, 0xbf

    const-string v2, "adivinhar"

    aput-object v2, v0, v1

    const/16 v1, 0xc0

    const-string v2, "advinha"

    aput-object v2, v0, v1

    const/16 v1, 0xc1

    const-string v2, "adivinha"

    aput-object v2, v0, v1

    const/16 v1, 0xc2

    const-string v2, "metereologia"

    aput-object v2, v0, v1

    const/16 v1, 0xc3

    const-string v2, "meteorologia"

    aput-object v2, v0, v1

    const/16 v1, 0xc4

    const-string v2, "bicabornato"

    aput-object v2, v0, v1

    const/16 v1, 0xc5

    const-string v2, "bicarbonato"

    aput-object v2, v0, v1

    const/16 v1, 0xc6

    const-string v2, "frustado"

    aput-object v2, v0, v1

    const/16 v1, 0xc7

    const-string v2, "frustrado"

    aput-object v2, v0, v1

    const/16 v1, 0xc8

    const-string v2, "frustada"

    aput-object v2, v0, v1

    const/16 v1, 0xc9

    const-string v2, "frustrada"

    aput-object v2, v0, v1

    const/16 v1, 0xca

    const-string v2, "trousse"

    aput-object v2, v0, v1

    const/16 v1, 0xcb

    const-string v2, "trouxe"

    aput-object v2, v0, v1

    const/16 v1, 0xcc

    const-string v2, "salchicha"

    aput-object v2, v0, v1

    const/16 v1, 0xcd

    const-string v2, "salsicha"

    aput-object v2, v0, v1

    const/16 v1, 0xce

    const-string v2, "cardeneta"

    aput-object v2, v0, v1

    const/16 v1, 0xcf

    const-string v2, "caderneta"

    aput-object v2, v0, v1

    const/16 v1, 0xd0

    const-string v2, "estrupo"

    aput-object v2, v0, v1

    const/16 v1, 0xd1

    const-string v2, "estupro"

    aput-object v2, v0, v1

    const/16 v1, 0xd2

    const-string v2, "prazeiroso"

    aput-object v2, v0, v1

    const/16 v1, 0xd3

    const-string v2, "prazeroso"

    aput-object v2, v0, v1

    const/16 v1, 0xd4

    const-string v2, "poblema"

    aput-object v2, v0, v1

    const/16 v1, 0xd5

    const-string v2, "problema"

    aput-object v2, v0, v1

    const/16 v1, 0xd6

    const-string v2, "pobrema"

    aput-object v2, v0, v1

    const/16 v1, 0xd7

    const-string v2, "problema"

    aput-object v2, v0, v1

    const/16 v1, 0xd8

    const-string v2, "enxer"

    aput-object v2, v0, v1

    const/16 v1, 0xd9

    const-string v2, "encher"

    aput-object v2, v0, v1

    const/16 v1, 0xda

    const-string v2, "enxarcar"

    aput-object v2, v0, v1

    const/16 v1, 0xdb

    const-string v2, "encharcar"

    aput-object v2, v0, v1

    const/16 v1, 0xdc

    const-string v2, "fragancia"

    aput-object v2, v0, v1

    const/16 v1, 0xdd

    const-string v2, "fragr\u00e2ncia"

    aput-object v2, v0, v1

    const/16 v1, 0xde

    const-string v2, "ancioso"

    aput-object v2, v0, v1

    const/16 v1, 0xdf

    const-string v2, "ansioso"

    aput-object v2, v0, v1

    const/16 v1, 0xe0

    const-string v2, "anciosa"

    aput-object v2, v0, v1

    const/16 v1, 0xe1

    const-string v2, "ansiosa"

    aput-object v2, v0, v1

    const/16 v1, 0xe2

    const-string v2, "anciedade"

    aput-object v2, v0, v1

    const/16 v1, 0xe3

    const-string v2, "ansiedade"

    aput-object v2, v0, v1

    const/16 v1, 0xe4

    const-string v2, "atravez"

    aput-object v2, v0, v1

    const/16 v1, 0xe5

    const-string v2, "atrav\u00e9s"

    aput-object v2, v0, v1

    const/16 v1, 0xe6

    const-string v2, "ezemplo"

    aput-object v2, v0, v1

    const/16 v1, 0xe7

    const-string v2, "exemplo"

    aput-object v2, v0, v1

    const/16 v1, 0xe8

    const-string v2, "exelente"

    aput-object v2, v0, v1

    const/16 v1, 0xe9

    const-string v2, "excelente"

    aput-object v2, v0, v1

    const/16 v1, 0xea

    const-string v2, "ezame"

    aput-object v2, v0, v1

    const/16 v1, 0xeb

    const-string v2, "exame"

    aput-object v2, v0, v1

    const/16 v1, 0xec

    const-string v2, "nescessario"

    aput-object v2, v0, v1

    const/16 v1, 0xed

    const-string v2, "necess\u00e1rio"

    aput-object v2, v0, v1

    const/16 v1, 0xee

    const-string v2, "nescessaria"

    aput-object v2, v0, v1

    const/16 v1, 0xef

    const-string v2, "necess\u00e1ria"

    aput-object v2, v0, v1

    const/16 v1, 0xf0

    const-string v2, "nescessidade"

    aput-object v2, v0, v1

    const/16 v1, 0xf1

    const-string v2, "necessidade"

    aput-object v2, v0, v1

    const/16 v1, 0xf2

    const-string v2, "reinvindicar"

    aput-object v2, v0, v1

    const/16 v1, 0xf3

    const-string v2, "reivindicar"

    aput-object v2, v0, v1

    const/16 v1, 0xf4

    const-string v2, "reinvindicacao"

    aput-object v2, v0, v1

    const/16 v1, 0xf5

    const-string v2, "reivindica\u00e7\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0xf6

    const-string v2, "reinvidicar"

    aput-object v2, v0, v1

    const/16 v1, 0xf7

    const-string v2, "reivindicar"

    aput-object v2, v0, v1

    const/16 v1, 0xf8

    const-string v2, "cabelelero"

    aput-object v2, v0, v1

    const/16 v1, 0xf9

    const-string v2, "cabeleireiro"

    aput-object v2, v0, v1

    const/16 v1, 0xfa

    const-string v2, "cabeleleiro"

    aput-object v2, v0, v1

    const/16 v1, 0xfb

    const-string v2, "cabeleireiro"

    aput-object v2, v0, v1

    const/16 v1, 0xfc

    const-string v2, "cabelereiro"

    aput-object v2, v0, v1

    const/16 v1, 0xfd

    const-string v2, "cabeleireiro"

    aput-object v2, v0, v1

    const/16 v1, 0xfe

    const-string v2, "carangueijo"

    aput-object v2, v0, v1

    const/16 v1, 0xff

    const-string v2, "caranguejo"

    aput-object v2, v0, v1

    const/16 v1, 0x100

    const-string v2, "bandeija"

    aput-object v2, v0, v1

    const/16 v1, 0x101

    const-string v2, "bandeja"

    aput-object v2, v0, v1

    const/16 v1, 0x102

    const-string v2, "pexe"

    aput-object v2, v0, v1

    const/16 v1, 0x103

    const-string v2, "peixe"

    aput-object v2, v0, v1

    const/16 v1, 0x104

    const-string v2, "xuxu"

    aput-object v2, v0, v1

    const/16 v1, 0x105

    const-string v2, "chuchu"

    aput-object v2, v0, v1

    const/16 v1, 0x106

    const-string v2, "chicara"

    aput-object v2, v0, v1

    const/16 v1, 0x107

    const-string v2, "x\u00edcara"

    aput-object v2, v0, v1

    const/16 v1, 0x108

    const-string v2, "enxente"

    aput-object v2, v0, v1

    const/16 v1, 0x109

    const-string v2, "enchente"

    aput-object v2, v0, v1

    const/16 v1, 0x10a

    const-string v2, "ecesso"

    aput-object v2, v0, v1

    const/16 v1, 0x10b

    const-string v2, "excesso"

    aput-object v2, v0, v1

    const/16 v1, 0x10c

    const-string v2, "exesso"

    aput-object v2, v0, v1

    const/16 v1, 0x10d

    const-string v2, "excesso"

    aput-object v2, v0, v1

    const/16 v1, 0x10e

    const-string v2, "exessivo"

    aput-object v2, v0, v1

    const/16 v1, 0x10f

    const-string v2, "excessivo"

    aput-object v2, v0, v1

    const/16 v1, 0x110

    const-string v2, "tavez"

    aput-object v2, v0, v1

    const/16 v1, 0x111

    const-string v2, "talvez"

    aput-object v2, v0, v1

    const/16 v1, 0x112

    const-string v2, "gilo"

    aput-object v2, v0, v1

    const/16 v1, 0x113

    const-string v2, "jil\u00f3"

    aput-object v2, v0, v1

    const/16 v1, 0x114

    const-string v2, "beringela"

    aput-object v2, v0, v1

    const/16 v1, 0x115

    const-string v2, "berinjela"

    aput-object v2, v0, v1

    const/16 v1, 0x116

    const-string v2, "magestade"

    aput-object v2, v0, v1

    const/16 v1, 0x117

    const-string v2, "majestade"

    aput-object v2, v0, v1

    const/16 v1, 0x118

    const-string v2, "cosinha"

    aput-object v2, v0, v1

    const/16 v1, 0x119

    const-string v2, "cozinha"

    aput-object v2, v0, v1

    const/16 v1, 0x11a

    const-string v2, "pesquiza"

    aput-object v2, v0, v1

    const/16 v1, 0x11b

    const-string v2, "pesquisa"

    aput-object v2, v0, v1

    const/16 v1, 0x11c

    const-string v2, "analizar"

    aput-object v2, v0, v1

    const/16 v1, 0x11d

    const-string v2, "analisar"

    aput-object v2, v0, v1

    const/16 v1, 0x11e

    const-string v2, "paralizar"

    aput-object v2, v0, v1

    const/16 v1, 0x11f

    const-string v2, "paralisar"

    aput-object v2, v0, v1

    const/16 v1, 0x120

    const-string v2, "paralizacao"

    aput-object v2, v0, v1

    const/16 v1, 0x121

    const-string v2, "paralisa\u00e7\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x122

    const-string v2, "atraz"

    aput-object v2, v0, v1

    const/16 v1, 0x123

    const-string v2, "atr\u00e1s"

    aput-object v2, v0, v1

    const/16 v1, 0x124

    const-string v2, "mecher"

    aput-object v2, v0, v1

    const/16 v1, 0x125

    const-string v2, "mexer"

    aput-object v2, v0, v1

    const/16 v1, 0x126

    const-string v2, "enchugar"

    aput-object v2, v0, v1

    const/16 v1, 0x127

    const-string v2, "enxugar"

    aput-object v2, v0, v1

    const/16 v1, 0x128

    const-string v2, "chingar"

    aput-object v2, v0, v1

    const/16 v1, 0x129

    const-string v2, "xingar"

    aput-object v2, v0, v1

    const/16 v1, 0x12a

    const-string v2, "enchame"

    aput-object v2, v0, v1

    const/16 v1, 0x12b

    const-string v2, "enxame"

    aput-object v2, v0, v1

    const/16 v1, 0x12c

    const-string v2, "puchar"

    aput-object v2, v0, v1

    const/16 v1, 0x12d

    const-string v2, "puxar"

    aput-object v2, v0, v1

    const/16 v1, 0x12e

    const-string v2, "fachina"

    aput-object v2, v0, v1

    const/16 v1, 0x12f

    const-string v2, "faxina"

    aput-object v2, v0, v1

    const/16 v1, 0x130

    const-string v2, "brucha"

    aput-object v2, v0, v1

    const/16 v1, 0x131

    const-string v2, "bruxa"

    aput-object v2, v0, v1

    const/16 v1, 0x132

    const-string v2, "susseso"

    aput-object v2, v0, v1

    const/16 v1, 0x133

    const-string v2, "sucesso"

    aput-object v2, v0, v1

    const/16 v1, 0x134

    const-string v2, "suceso"

    aput-object v2, v0, v1

    const/16 v1, 0x135

    const-string v2, "sucesso"

    aput-object v2, v0, v1

    const/16 v1, 0x136

    const-string v2, "acessor"

    aput-object v2, v0, v1

    const/16 v1, 0x137

    const-string v2, "assessor"

    aput-object v2, v0, v1

    const/16 v1, 0x138

    const-string v2, "asessor"

    aput-object v2, v0, v1

    const/16 v1, 0x139

    const-string v2, "assessor"

    aput-object v2, v0, v1

    const/16 v1, 0x13a

    const-string v2, "discucao"

    aput-object v2, v0, v1

    const/16 v1, 0x13b

    const-string v2, "discuss\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x13c

    const-string v2, "discusao"

    aput-object v2, v0, v1

    const/16 v1, 0x13d

    const-string v2, "discuss\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x13e

    const-string v2, "obcessao"

    aput-object v2, v0, v1

    const/16 v1, 0x13f

    const-string v2, "obsess\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x140

    const-string v2, "compreencao"

    aput-object v2, v0, v1

    const/16 v1, 0x141

    const-string v2, "compreens\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x142

    const-string v2, "extencao"

    aput-object v2, v0, v1

    const/16 v1, 0x143

    const-string v2, "extens\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x144

    const-string v2, "pretencao"

    aput-object v2, v0, v1

    const/16 v1, 0x145

    const-string v2, "pretens\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x146

    const-string v2, "atensao"

    aput-object v2, v0, v1

    const/16 v1, 0x147

    const-string v2, "aten\u00e7\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x148

    const-string v2, "acensao"

    aput-object v2, v0, v1

    const/16 v1, 0x149

    const-string v2, "ascens\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x14a

    const-string v2, "decer"

    aput-object v2, v0, v1

    const/16 v1, 0x14b

    const-string v2, "descer"

    aput-object v2, v0, v1

    const/16 v1, 0x14c

    const-string v2, "naser"

    aput-object v2, v0, v1

    const/16 v1, 0x14d

    const-string v2, "nascer"

    aput-object v2, v0, v1

    const/16 v1, 0x14e

    const-string v2, "nacer"

    aput-object v2, v0, v1

    const/16 v1, 0x14f

    const-string v2, "nascer"

    aput-object v2, v0, v1

    const/16 v1, 0x150

    const-string v2, "creser"

    aput-object v2, v0, v1

    const/16 v1, 0x151

    const-string v2, "crescer"

    aput-object v2, v0, v1

    const/16 v1, 0x152

    const-string v2, "crecer"

    aput-object v2, v0, v1

    const/16 v1, 0x153

    const-string v2, "crescer"

    aput-object v2, v0, v1

    const/16 v1, 0x154

    const-string v2, "picina"

    aput-object v2, v0, v1

    const/16 v1, 0x155

    const-string v2, "piscina"

    aput-object v2, v0, v1

    const/16 v1, 0x156

    const-string v2, "pissina"

    aput-object v2, v0, v1

    const/16 v1, 0x157

    const-string v2, "piscina"

    aput-object v2, v0, v1

    const/16 v1, 0x158

    const-string v2, "conciencia"

    aput-object v2, v0, v1

    const/16 v1, 0x159

    const-string v2, "consci\u00eancia"

    aput-object v2, v0, v1

    const/16 v1, 0x15a

    const-string v2, "esceto"

    aput-object v2, v0, v1

    const/16 v1, 0x15b

    const-string v2, "exceto"

    aput-object v2, v0, v1

    const/16 v1, 0x15c

    const-string v2, "expontaneo"

    aput-object v2, v0, v1

    const/16 v1, 0x15d

    const-string v2, "espont\u00e2neo"

    aput-object v2, v0, v1

    const/16 v1, 0x15e

    const-string v2, "extender"

    aput-object v2, v0, v1

    const/16 v1, 0x15f

    const-string v2, "estender"

    aput-object v2, v0, v1

    const/16 v1, 0x160

    const-string v2, "explendido"

    aput-object v2, v0, v1

    const/16 v1, 0x161

    const-string v2, "espl\u00eandido"

    aput-object v2, v0, v1

    const/16 v1, 0x162

    const-string v2, "beje"

    aput-object v2, v0, v1

    const/16 v1, 0x163

    const-string v2, "bege"

    aput-object v2, v0, v1

    const/16 v1, 0x164

    const-string v2, "garajem"

    aput-object v2, v0, v1

    const/16 v1, 0x165

    const-string v2, "garagem"

    aput-object v2, v0, v1

    const/16 v1, 0x166

    const-string v2, "exitar"

    aput-object v2, v0, v1

    const/16 v1, 0x167

    const-string v2, "hesitar"

    aput-object v2, v0, v1

    const/16 v1, 0x168

    const-string v2, "ogeriza"

    aput-object v2, v0, v1

    const/16 v1, 0x169

    const-string v2, "ojeriza"

    aput-object v2, v0, v1

    const/16 v1, 0x16a

    const-string v2, "tijela"

    aput-object v2, v0, v1

    const/16 v1, 0x16b

    const-string v2, "tigela"

    aput-object v2, v0, v1

    const/16 v1, 0x16c

    const-string v2, "cangica"

    aput-object v2, v0, v1

    const/16 v1, 0x16d

    const-string v2, "canjica"

    aput-object v2, v0, v1

    const/16 v1, 0x16e

    const-string v2, "rabujento"

    aput-object v2, v0, v1

    const/16 v1, 0x16f

    const-string v2, "rabugento"

    aput-object v2, v0, v1

    const/16 v1, 0x170

    const-string v2, "sargeta"

    aput-object v2, v0, v1

    const/16 v1, 0x171

    const-string v2, "sarjeta"

    aput-object v2, v0, v1

    const/16 v1, 0x172

    const-string v2, "gorgeta"

    aput-object v2, v0, v1

    const/16 v1, 0x173

    const-string v2, "gorjeta"

    aput-object v2, v0, v1

    const/16 v1, 0x174

    const-string v2, "geito"

    aput-object v2, v0, v1

    const/16 v1, 0x175

    const-string v2, "jeito"

    aput-object v2, v0, v1

    const/16 v1, 0x176

    const-string v2, "jente"

    aput-object v2, v0, v1

    const/16 v1, 0x177

    const-string v2, "gente"

    aput-object v2, v0, v1

    const/16 v1, 0x178

    const-string v2, "oje"

    aput-object v2, v0, v1

    const/16 v1, 0x179

    const-string v2, "hoje"

    aput-object v2, v0, v1

    const/16 v1, 0x17a

    const-string v2, "omem"

    aput-object v2, v0, v1

    const/16 v1, 0x17b

    const-string v2, "homem"

    aput-object v2, v0, v1

    const/16 v1, 0x17c

    const-string v2, "aver"

    aput-object v2, v0, v1

    const/16 v1, 0x17d

    const-string v2, "haver"

    aput-object v2, v0, v1

    const/16 v1, 0x17e

    const-string v2, "ospital"

    aput-object v2, v0, v1

    const/16 v1, 0x17f

    const-string v2, "hospital"

    aput-object v2, v0, v1

    const/16 v1, 0x180

    const-string v2, "quizer"

    aput-object v2, v0, v1

    const/16 v1, 0x181

    const-string v2, "quiser"

    aput-object v2, v0, v1

    const/16 v1, 0x182

    const-string v2, "fisesse"

    aput-object v2, v0, v1

    const/16 v1, 0x183

    const-string v2, "fizesse"

    aput-object v2, v0, v1

    const/16 v1, 0x184

    const-string v2, "cabecario"

    aput-object v2, v0, v1

    const/16 v1, 0x185

    const-string v2, "cabe\u00e7alho"

    aput-object v2, v0, v1

    const/16 v1, 0x186

    const-string v2, "buginganga"

    aput-object v2, v0, v1

    const/16 v1, 0x187

    const-string v2, "bugiganga"

    aput-object v2, v0, v1

    const/16 v1, 0x188

    const-string v2, "largatixa"

    aput-object v2, v0, v1

    const/16 v1, 0x189

    const-string v2, "lagartixa"

    aput-object v2, v0, v1

    const/16 v1, 0x18a

    const-string v2, "largato"

    aput-object v2, v0, v1

    const/16 v1, 0x18b

    const-string v2, "lagarto"

    aput-object v2, v0, v1

    const/16 v1, 0x18c

    const-string v2, "superticao"

    aput-object v2, v0, v1

    const/16 v1, 0x18d

    const-string v2, "supersti\u00e7\u00e3o"

    aput-object v2, v0, v1

    const/16 v1, 0x18e

    const-string v2, "adevogado"

    aput-object v2, v0, v1

    const/16 v1, 0x18f

    const-string v2, "advogado"

    aput-object v2, v0, v1

    const/16 v1, 0x190

    const-string v2, "adivogado"

    aput-object v2, v0, v1

    const/16 v1, 0x191

    const-string v2, "advogado"

    aput-object v2, v0, v1

    const/16 v1, 0x192

    const-string v2, "ritimo"

    aput-object v2, v0, v1

    const/16 v1, 0x193

    const-string v2, "ritmo"

    aput-object v2, v0, v1

    const/16 v1, 0x194

    const-string v2, "adimirar"

    aput-object v2, v0, v1

    const/16 v1, 0x195

    const-string v2, "admirar"

    aput-object v2, v0, v1

    const/16 v1, 0x196

    const-string v2, "adiquirir"

    aput-object v2, v0, v1

    const/16 v1, 0x197

    const-string v2, "adquirir"

    aput-object v2, v0, v1

    const/16 v1, 0x198

    const-string v2, "guspe"

    aput-object v2, v0, v1

    const/16 v1, 0x199

    const-string v2, "cuspe"

    aput-object v2, v0, v1

    const/16 v1, 0x19a

    const-string v2, "chicrete"

    aput-object v2, v0, v1

    const/16 v1, 0x19b

    const-string v2, "chiclete"

    aput-object v2, v0, v1

    const/16 v1, 0x19c

    const-string v2, "bicicreta"

    aput-object v2, v0, v1

    const/16 v1, 0x19d

    const-string v2, "bicicleta"

    aput-object v2, v0, v1

    const/16 v1, 0x19e

    const-string v2, "ingual"

    aput-object v2, v0, v1

    const/16 v1, 0x19f

    const-string v2, "igual"

    aput-object v2, v0, v1

    const/16 v1, 0x1a0

    const-string v2, "cocha"

    aput-object v2, v0, v1

    const/16 v1, 0x1a1

    const-string v2, "coxa"

    aput-object v2, v0, v1

    const/16 v1, 0x1a2

    const-string v2, "enchaqueca"

    aput-object v2, v0, v1

    const/16 v1, 0x1a3

    const-string v2, "enxaqueca"

    aput-object v2, v0, v1

    const/16 v1, 0x1a4

    const-string v2, "cansaso"

    aput-object v2, v0, v1

    const/16 v1, 0x1a5

    const-string v2, "cansa\u00e7o"

    aput-object v2, v0, v1

    const/16 v1, 0x1a6

    const-string v2, "cancado"

    aput-object v2, v0, v1

    const/16 v1, 0x1a7

    const-string v2, "cansado"

    aput-object v2, v0, v1

    const/16 v1, 0x1a8

    const-string v2, "passoca"

    aput-object v2, v0, v1

    const/16 v1, 0x1a9

    const-string v2, "pa\u00e7oca"

    aput-object v2, v0, v1

    const/16 v1, 0x1aa

    const-string v2, "preguisa"

    aput-object v2, v0, v1

    const/16 v1, 0x1ab

    const-string v2, "pregui\u00e7a"

    aput-object v2, v0, v1

    const/16 v1, 0x1ac

    const-string v2, "cabesa"

    aput-object v2, v0, v1

    const/16 v1, 0x1ad

    const-string v2, "cabe\u00e7a"

    aput-object v2, v0, v1

    const/16 v1, 0x1ae

    const-string v2, "comesar"

    aput-object v2, v0, v1

    const/16 v1, 0x1af

    const-string v2, "come\u00e7ar"

    aput-object v2, v0, v1

    const/16 v1, 0x1b0

    const-string v2, "conheso"

    aput-object v2, v0, v1

    const/16 v1, 0x1b1

    const-string v2, "conhe\u00e7o"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrFix;->PAIRS:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static key(Ljava/lang/CharSequence;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 88
    if-nez p0, :cond_1

    .line 93
    :cond_0
    :goto_0
    return-object v0

    .line 89
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    .line 90
    if-eqz v1, :cond_0

    const/16 v2, 0x18

    if-gt v1, v2, :cond_0

    .line 91
    new-array v2, v1, [C

    .line 92
    const/4 v0, 0x0

    :goto_1
    if-ge v0, v1, :cond_2

    invoke-interface {p0, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrText;->base(I)C

    move-result v3

    aput-char v3, v2, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 93
    :cond_2
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v2}, Ljava/lang/String;-><init>([C)V

    goto :goto_0
.end method

.method public static lookup(Ljava/lang/CharSequence;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 98
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFix;->key(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 99
    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 100
    :goto_0
    return-object v0

    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrFix;->map()Ljava/util/HashMap;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method private static declared-synchronized map()Ljava/util/HashMap;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 76
    const-class v1, Lcom/mrkeyboard/app/MrFix;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrFix;->sMap:Ljava/util/HashMap;

    if-nez v0, :cond_1

    .line 77
    new-instance v2, Ljava/util/HashMap;

    sget-object v0, Lcom/mrkeyboard/app/MrFix;->PAIRS:[Ljava/lang/String;

    array-length v0, v0

    invoke-direct {v2, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 78
    const/4 v0, 0x0

    :goto_0
    add-int/lit8 v3, v0, 0x1

    sget-object v4, Lcom/mrkeyboard/app/MrFix;->PAIRS:[Ljava/lang/String;

    array-length v4, v4

    if-ge v3, v4, :cond_0

    .line 79
    sget-object v3, Lcom/mrkeyboard/app/MrFix;->PAIRS:[Ljava/lang/String;

    aget-object v3, v3, v0

    sget-object v4, Lcom/mrkeyboard/app/MrFix;->PAIRS:[Ljava/lang/String;

    add-int/lit8 v5, v0, 0x1

    aget-object v4, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 78
    add-int/lit8 v0, v0, 0x2

    goto :goto_0

    .line 81
    :cond_0
    sput-object v2, Lcom/mrkeyboard/app/MrFix;->sMap:Ljava/util/HashMap;

    .line 83
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrFix;->sMap:Ljava/util/HashMap;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    .line 76
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static size()I
    .locals 1

    .prologue
    .line 105
    invoke-static {}, Lcom/mrkeyboard/app/MrFix;->map()Ljava/util/HashMap;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/HashMap;->size()I

    move-result v0

    return v0
.end method
