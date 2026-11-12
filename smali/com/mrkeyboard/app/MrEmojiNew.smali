.class final Lcom/mrkeyboard/app/MrEmojiNew;
.super Ljava/lang/Object;
.source "MrEmojiNew.java"


# static fields
.field static final CATEGORIES:I = 0x8

.field private static final GROUPS:[[Ljava/lang/String;

.field private static sAll:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final sBase:[Ljava/lang/String;

.field private static final sGlyph:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field private static final sMerged:[Ljava/lang/String;

.field private static sPaint:Landroid/graphics/Paint;


# direct methods
.method static constructor <clinit>()V
    .locals 10

    .prologue
    const/16 v9, 0x8

    const/4 v8, 0x3

    const/4 v7, 0x2

    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 31
    new-array v0, v9, [[Ljava/lang/String;

    const/16 v1, 0x36

    new-array v1, v1, [Ljava/lang/String;

    const-string v2, "\ud83d\ude43|\ud83e\udee0|\ud83e\udeea|\ud83e\udeeb"

    aput-object v2, v1, v5

    const-string v2, "\ud83e\udd2d|\ud83e\udee2|\ud83e\udee3"

    aput-object v2, v1, v6

    const-string v2, "\ud83e\udd14|\ud83e\udee1"

    aput-object v2, v1, v7

    const-string v2, "\ud83d\ude36|\ud83e\udee5|\ud83d\ude36\u200d\ud83c\udf2b\ufe0f"

    aput-object v2, v1, v8

    const/4 v2, 0x4

    const-string v3, "\ud83d\ude2c|\ud83d\ude2e\u200d\ud83d\udca8"

    aput-object v3, v1, v2

    const/4 v2, 0x5

    const-string v3, "\ud83e\udd25|\ud83e\udee8|\ud83d\ude42\u200d\u2194\ufe0f|\ud83d\ude42\u200d\u2195\ufe0f"

    aput-object v3, v1, v2

    const/4 v2, 0x6

    const-string v3, "\ud83d\ude34|\ud83e\udee9"

    aput-object v3, v1, v2

    const/4 v2, 0x7

    const-string v3, "\ud83d\ude35|\ud83d\ude35\u200d\ud83d\udcab"

    aput-object v3, v1, v2

    const-string v2, "\ud83d\ude15|\ud83e\udee4"

    aput-object v2, v1, v9

    const/16 v2, 0x9

    const-string v3, "\ud83e\udd7a|\ud83e\udd79"

    aput-object v3, v1, v2

    const/16 v2, 0xa

    const-string v3, "\ud83d\udc94|\u2764\ufe0f\u200d\ud83d\udd25|\u2764\ufe0f\u200d\ud83e\ude79"

    aput-object v3, v1, v2

    const/16 v2, 0xb

    const-string v3, "\u2764\ufe0f|\ud83e\ude77"

    aput-object v3, v1, v2

    const/16 v2, 0xc

    const-string v3, "\ud83d\udc99|\ud83e\ude75"

    aput-object v3, v1, v2

    const/16 v2, 0xd

    const-string v3, "\ud83d\udda4|\ud83e\ude76"

    aput-object v3, v1, v2

    const/16 v2, 0xe

    const-string v3, "\ud83d\udca5|\ud83e\udeef"

    aput-object v3, v1, v2

    const/16 v2, 0xf

    const-string v3, "\ud83d\udcac|\ud83d\udc41\ufe0f\u200d\ud83d\udde8\ufe0f"

    aput-object v3, v1, v2

    const/16 v2, 0x10

    const-string v3, "\ud83d\udd96|\ud83e\udef1|\ud83e\udef2|\ud83e\udef3|\ud83e\udef4|\ud83e\udef7|\ud83e\udef8|\ud83e\udef9|\ud83e\udefa"

    aput-object v3, v1, v2

    const/16 v2, 0x11

    const-string v3, "\ud83e\udd1e|\ud83e\udef0"

    aput-object v3, v1, v2

    const/16 v2, 0x12

    const-string v3, "\u261d\ufe0f|\ud83e\udef5"

    aput-object v3, v1, v2

    const/16 v2, 0x13

    const-string v3, "\ud83d\ude4c|\ud83e\udef6"

    aput-object v3, v1, v2

    const/16 v2, 0x14

    const-string v3, "\ud83d\udc44|\ud83e\udee6"

    aput-object v3, v1, v2

    const/16 v2, 0x15

    const-string v3, "\ud83d\udc63|\ud83e\udec6"

    aput-object v3, v1, v2

    const/16 v2, 0x16

    const-string v3, "\ud83d\udc78|\ud83e\udec5"

    aput-object v3, v1, v2

    const/16 v2, 0x17

    const-string v3, "\ud83e\udd30|\ud83e\udec3|\ud83e\udec4"

    aput-object v3, v1, v2

    const/16 v2, 0x18

    const-string v3, "\ud83e\udd36|\ud83e\uddd1\u200d\ud83c\udf84"

    aput-object v3, v1, v2

    const/16 v2, 0x19

    const-string v3, "\ud83e\udddf|\ud83e\uddcc"

    aput-object v3, v1, v2

    const/16 v2, 0x1a

    const-string v3, "\ud83d\udd7a|\ud83e\uddd1\u200d\ud83e\ude70"

    aput-object v3, v1, v2

    const/16 v2, 0x1b

    const-string v3, "\ud83e\uddce|\ud83e\uddd1\u200d\ud83e\uddaf|\ud83d\udc68\u200d\ud83e\uddaf|\ud83d\udc69\u200d\ud83e\uddaf|\ud83e\uddd1\u200d\ud83e\uddbc|\ud83d\udc68\u200d\ud83e\uddbc|\ud83d\udc69\u200d\ud83e\uddbc|\ud83e\uddd1\u200d\ud83e\uddbd|\ud83d\udc68\u200d\ud83e\uddbd|\ud83d\udc69\u200d\ud83e\uddbd"

    aput-object v3, v1, v2

    const/16 v2, 0x1c

    const-string v3, "\ud83d\udc69|\ud83e\uddd1\u200d\ud83e\uddb0|\ud83e\uddd1\u200d\ud83e\uddb1|\ud83e\uddd1\u200d\ud83e\uddb3|\ud83e\uddd1\u200d\ud83e\uddb2|\ud83d\udc68\u200d\ud83e\uddb0|\ud83d\udc68\u200d\ud83e\uddb1|\ud83d\udc68\u200d\ud83e\uddb3|\ud83d\udc68\u200d\ud83e\uddb2|\ud83d\udc69\u200d\ud83e\uddb0|\ud83d\udc69\u200d\ud83e\uddb1|\ud83d\udc69\u200d\ud83e\uddb3|\ud83d\udc69\u200d\ud83e\uddb2"

    aput-object v3, v1, v2

    const/16 v2, 0x1d

    const-string v3, "\ud83d\udecc|\ud83e\uddd1\u200d\ud83e\udd1d\u200d\ud83e\uddd1"

    aput-object v3, v1, v2

    const/16 v2, 0x1e

    const-string v3, "\ud83d\udc68\u200d\u2695\ufe0f|\ud83e\uddd1\u200d\u2695\ufe0f"

    aput-object v3, v1, v2

    const/16 v2, 0x1f

    const-string v3, "\ud83d\udc68\u200d\ud83c\udf93|\ud83e\uddd1\u200d\ud83c\udf93"

    aput-object v3, v1, v2

    const/16 v2, 0x20

    const-string v3, "\ud83d\udc68\u200d\ud83c\udfeb|\ud83e\uddd1\u200d\ud83c\udfeb"

    aput-object v3, v1, v2

    const/16 v2, 0x21

    const-string v3, "\ud83d\udc68\u200d\u2696\ufe0f|\ud83e\uddd1\u200d\u2696\ufe0f"

    aput-object v3, v1, v2

    const/16 v2, 0x22

    const-string v3, "\ud83d\udc68\u200d\ud83c\udf3e|\ud83e\uddd1\u200d\ud83c\udf3e"

    aput-object v3, v1, v2

    const/16 v2, 0x23

    const-string v3, "\ud83d\udc68\u200d\ud83c\udf73|\ud83e\uddd1\u200d\ud83c\udf73"

    aput-object v3, v1, v2

    const/16 v2, 0x24

    const-string v3, "\ud83d\udc68\u200d\ud83d\udd27|\ud83e\uddd1\u200d\ud83d\udd27"

    aput-object v3, v1, v2

    const/16 v2, 0x25

    const-string v3, "\ud83d\udc68\u200d\ud83c\udfed|\ud83e\uddd1\u200d\ud83c\udfed"

    aput-object v3, v1, v2

    const/16 v2, 0x26

    const-string v3, "\ud83d\udc68\u200d\ud83d\udcbc|\ud83e\uddd1\u200d\ud83d\udcbc"

    aput-object v3, v1, v2

    const/16 v2, 0x27

    const-string v3, "\ud83d\udc68\u200d\ud83d\udd2c|\ud83e\uddd1\u200d\ud83d\udd2c"

    aput-object v3, v1, v2

    const/16 v2, 0x28

    const-string v3, "\ud83d\udc68\u200d\ud83d\udcbb|\ud83e\uddd1\u200d\ud83d\udcbb"

    aput-object v3, v1, v2

    const/16 v2, 0x29

    const-string v3, "\ud83d\udc68\u200d\ud83c\udfa4|\ud83e\uddd1\u200d\ud83c\udfa4"

    aput-object v3, v1, v2

    const/16 v2, 0x2a

    const-string v3, "\ud83d\udc68\u200d\ud83c\udfa8|\ud83e\uddd1\u200d\ud83c\udfa8"

    aput-object v3, v1, v2

    const/16 v2, 0x2b

    const-string v3, "\ud83d\udc68\u200d\u2708\ufe0f|\ud83e\uddd1\u200d\u2708\ufe0f"

    aput-object v3, v1, v2

    const/16 v2, 0x2c

    const-string v3, "\ud83d\udc68\u200d\ud83d\ude80|\ud83e\uddd1\u200d\ud83d\ude80"

    aput-object v3, v1, v2

    const/16 v2, 0x2d

    const-string v3, "\ud83d\udc68\u200d\ud83d\ude92|\ud83e\uddd1\u200d\ud83d\ude92|\ud83d\udc69\u200d\ud83c\udf7c|\ud83d\udc68\u200d\ud83c\udf7c|\ud83e\uddd1\u200d\ud83c\udf7c"

    aput-object v3, v1, v2

    const/16 v2, 0x2e

    const-string v3, "\ud83d\udc68\u200d\ud83d\udc69\u200d\ud83d\udc67\u200d\ud83d\udc66|\ud83d\udc68\u200d\ud83d\udc69\u200d\ud83d\udc66\u200d\ud83d\udc66|\ud83d\udc68\u200d\ud83d\udc69\u200d\ud83d\udc67\u200d\ud83d\udc67"

    aput-object v3, v1, v2

    const/16 v2, 0x2f

    const-string v3, "\ud83d\udc69\u200d\ud83d\udc69\u200d\ud83d\udc66|\ud83d\udc69\u200d\ud83d\udc69\u200d\ud83d\udc67|\ud83d\udc69\u200d\ud83d\udc69\u200d\ud83d\udc67\u200d\ud83d\udc66|\ud83d\udc69\u200d\ud83d\udc69\u200d\ud83d\udc66\u200d\ud83d\udc66|\ud83d\udc69\u200d\ud83d\udc69\u200d\ud83d\udc67\u200d\ud83d\udc67"

    aput-object v3, v1, v2

    const/16 v2, 0x30

    const-string v3, "\ud83d\udc68\u200d\ud83d\udc68\u200d\ud83d\udc66|\ud83d\udc68\u200d\ud83d\udc68\u200d\ud83d\udc67|\ud83d\udc68\u200d\ud83d\udc68\u200d\ud83d\udc67\u200d\ud83d\udc66|\ud83d\udc68\u200d\ud83d\udc68\u200d\ud83d\udc66\u200d\ud83d\udc66|\ud83d\udc68\u200d\ud83d\udc68\u200d\ud83d\udc67\u200d\ud83d\udc67"

    aput-object v3, v1, v2

    const/16 v2, 0x31

    const-string v3, "\ud83d\udc69\u200d\ud83d\udc66|\ud83d\udc69\u200d\ud83d\udc66\u200d\ud83d\udc66"

    aput-object v3, v1, v2

    const/16 v2, 0x32

    const-string v3, "\ud83d\udc69\u200d\ud83d\udc67|\ud83d\udc69\u200d\ud83d\udc67\u200d\ud83d\udc66|\ud83d\udc69\u200d\ud83d\udc67\u200d\ud83d\udc67"

    aput-object v3, v1, v2

    const/16 v2, 0x33

    const-string v3, "\ud83d\udc68\u200d\ud83d\udc66|\ud83d\udc68\u200d\ud83d\udc66\u200d\ud83d\udc66"

    aput-object v3, v1, v2

    const/16 v2, 0x34

    const-string v3, "\ud83d\udc68\u200d\ud83d\udc67|\ud83d\udc68\u200d\ud83d\udc67\u200d\ud83d\udc66|\ud83d\udc68\u200d\ud83d\udc67\u200d\ud83d\udc67|\ud83e\uddd1\u200d\ud83e\uddd1\u200d\ud83e\uddd2|\ud83e\uddd1\u200d\ud83e\uddd1\u200d\ud83e\uddd2\u200d\ud83e\uddd2|\ud83e\uddd1\u200d\ud83e\uddd2|\ud83e\uddd1\u200d\ud83e\uddd2\u200d\ud83e\uddd2"

    aput-object v3, v1, v2

    const/16 v2, 0x35

    const-string v3, "\ud83d\udc69\u200d\u2764\ufe0f\u200d\ud83d\udc69|\ud83d\udc69\u200d\u2764\ufe0f\u200d\ud83d\udc8b\u200d\ud83d\udc68|\ud83d\udc68\u200d\u2764\ufe0f\u200d\ud83d\udc8b\u200d\ud83d\udc68|\ud83d\udc69\u200d\u2764\ufe0f\u200d\ud83d\udc8b\u200d\ud83d\udc69"

    aput-object v3, v1, v2

    aput-object v1, v0, v5

    const/16 v1, 0xe

    new-array v1, v1, [Ljava/lang/String;

    const-string v2, "\ud83d\udc34|\ud83e\udece|\ud83e\udecf"

    aput-object v2, v1, v5

    const-string v2, "\ud83e\udda7|\ud83e\udec8"

    aput-object v2, v1, v6

    const-string v2, "\ud83e\uddae|\ud83d\udc15\u200d\ud83e\uddba"

    aput-object v2, v1, v7

    const-string v2, "\ud83d\udc08|\ud83d\udc08\u200d\u2b1b"

    aput-object v2, v1, v8

    const/4 v2, 0x4

    const-string v3, "\ud83d\udc3b|\ud83d\udc3b\u200d\u2744\ufe0f"

    aput-object v3, v1, v2

    const/4 v2, 0x5

    const-string v3, "\ud83e\udda4|\ud83e\udeb6"

    aput-object v3, v1, v2

    const/4 v2, 0x6

    const-string v3, "\ud83e\udd9c|\ud83e\udebd|\ud83d\udc26\u200d\u2b1b|\ud83e\udebf|\ud83d\udc26\u200d\ud83d\udd25"

    aput-object v3, v1, v2

    const/4 v2, 0x7

    const-string v3, "\ud83d\udc0b|\ud83e\udecd"

    aput-object v3, v1, v2

    const-string v2, "\ud83d\udc1a|\ud83e\udeb8|\ud83e\udebc"

    aput-object v2, v1, v9

    const/16 v2, 0x9

    const-string v3, "\ud83e\udd8b|\ud83e\udecc"

    aput-object v3, v1, v2

    const/16 v2, 0xa

    const-string v3, "\ud83d\udcae|\ud83e\udeb7"

    aput-object v3, v1, v2

    const/16 v2, 0xb

    const-string v3, "\ud83c\udf37|\ud83e\udebb"

    aput-object v3, v1, v2

    const/16 v2, 0xc

    const-string v3, "\ud83c\udf33|\ud83e\udebe"

    aput-object v3, v1, v2

    const/16 v2, 0xd

    const-string v3, "\ud83c\udf43|\ud83e\udeb9|\ud83e\udeba"

    aput-object v3, v1, v2

    aput-object v1, v0, v6

    new-array v1, v9, [Ljava/lang/String;

    const-string v2, "\ud83c\udf4b|\ud83c\udf4b\u200d\ud83d\udfe9"

    aput-object v2, v1, v5

    const-string v2, "\ud83e\udd55|\ud83e\udedc"

    aput-object v2, v1, v6

    const-string v2, "\ud83c\udf44|\ud83c\udf44\u200d\ud83d\udfeb"

    aput-object v2, v1, v7

    const-string v2, "\ud83e\udd5c|\ud83e\uded8"

    aput-object v2, v1, v8

    const/4 v2, 0x4

    const-string v3, "\ud83c\udf30|\ud83e\udeda|\ud83e\udedb"

    aput-object v3, v1, v2

    const/4 v2, 0x5

    const-string v3, "\ud83e\udd52|\ud83e\udedd"

    aput-object v3, v1, v2

    const/4 v2, 0x6

    const-string v3, "\ud83e\udd6b|\ud83e\uded9"

    aput-object v3, v1, v2

    const/4 v2, 0x7

    const-string v3, "\ud83e\udd43|\ud83e\uded7"

    aput-object v3, v1, v2

    aput-object v1, v0, v7

    new-array v1, v8, [Ljava/lang/String;

    const-string v2, "\ud83d\udd2e|\ud83e\ude84"

    aput-object v2, v1, v5

    const-string v2, "\ud83e\uddff|\ud83e\udeac"

    aput-object v2, v1, v6

    const-string v2, "\ud83e\ude86|\ud83e\udea9"

    aput-object v2, v1, v7

    aput-object v1, v0, v8

    const/4 v1, 0x4

    const/4 v2, 0x7

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "\ud83d\uddfa\ufe0f|\ud83d\uddfe"

    aput-object v3, v2, v5

    const-string v3, "\ud83c\udfd4\ufe0f|\ud83d\uded8"

    aput-object v3, v2, v6

    const-string v3, "\ud83d\uddfc|\ud83d\uded9"

    aput-object v3, v2, v7

    const-string v3, "\ud83c\udfa1|\ud83d\udedd"

    aput-object v3, v2, v8

    const/4 v3, 0x4

    const-string v4, "\u26fd|\ud83d\udede"

    aput-object v4, v2, v3

    const/4 v3, 0x5

    const-string v4, "\u2693|\ud83d\udedf"

    aput-object v4, v2, v3

    const/4 v3, 0x6

    const-string v4, "\u2604\ufe0f|\ud83e\ude8b"

    aput-object v4, v2, v3

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const/16 v2, 0xe

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "\ud83d\udcb3|\ud83e\udeaa"

    aput-object v3, v2, v5

    const-string v3, "\ud83d\udd0b|\ud83e\udeab"

    aput-object v3, v2, v6

    const-string v3, "\ud83c\udfba|\ud83e\ude8a"

    aput-object v3, v2, v7

    const-string v3, "\ud83e\ude98|\ud83e\ude87|\ud83e\ude88|\ud83e\ude89"

    aput-object v3, v2, v8

    const/4 v3, 0x4

    const-string v4, "\ud83e\ude92|\ud83e\udeae"

    aput-object v4, v2, v3

    const/4 v3, 0x5

    const-string v4, "\ud83e\ude79|\ud83e\ude7c"

    aput-object v4, v2, v3

    const/4 v3, 0x6

    const-string v4, "\ud83e\ude7a|\ud83e\ude7b"

    aput-object v4, v2, v3

    const/4 v3, 0x7

    const-string v4, "\u26cf\ufe0f|\ud83e\ude8f"

    aput-object v4, v2, v3

    const-string v3, "\ud83e\uddf0|\ud83e\ude8e"

    aput-object v3, v2, v9

    const/16 v3, 0x9

    const-string v4, "\ud83d\udd8d\ufe0f|\ud83e\ude8c|\ud83e\udedf"

    aput-object v4, v2, v3

    const/16 v3, 0xa

    const-string v4, "\ud83e\udea4|\ud83e\ude8d"

    aput-object v4, v2, v3

    const/16 v3, 0xb

    const-string v4, "\ud83d\udd17|\u26d3\ufe0f\u200d\ud83d\udca5"

    aput-object v4, v2, v3

    const/16 v3, 0xc

    const-string v4, "\ud83e\uddfc|\ud83e\udee7"

    aput-object v4, v2, v3

    const/16 v3, 0xd

    const-string v4, "\ud83d\udc52|\ud83e\udead"

    aput-object v4, v2, v3

    aput-object v2, v0, v1

    const/4 v1, 0x6

    new-array v2, v8, [Ljava/lang/String;

    const-string v3, "\ud83d\udcf6|\ud83d\udedc"

    aput-object v3, v2, v5

    const-string v3, "\u2797|\ud83d\udff0"

    aput-object v3, v2, v6

    const-string v3, "\u2721\ufe0f|\ud83e\udeaf"

    aput-object v3, v2, v7

    aput-object v2, v0, v1

    const/4 v1, 0x7

    new-array v2, v8, [Ljava/lang/String;

    const-string v3, "\ud83c\udff3\ufe0f\u200d\ud83c\udf08|\ud83c\udff3\ufe0f\u200d\u26a7\ufe0f"

    aput-object v3, v2, v5

    const-string v3, "\ud83c\udde8\ud83c\uddf5|\ud83c\udde8\ud83c\uddf6"

    aput-object v3, v2, v6

    const-string v3, "\ud83c\uddff\ud83c\uddfc|\ud83c\udff4\udb40\udc67\udb40\udc62\udb40\udc65\udb40\udc6e\udb40\udc67\udb40\udc7f|\ud83c\udff4\udb40\udc67\udb40\udc62\udb40\udc73\udb40\udc63\udb40\udc74\udb40\udc7f|\ud83c\udff4\udb40\udc67\udb40\udc62\udb40\udc77\udb40\udc6c\udb40\udc73\udb40\udc7f"

    aput-object v3, v2, v7

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->GROUPS:[[Ljava/lang/String;

    .line 276
    new-array v0, v9, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->sBase:[Ljava/lang/String;

    .line 277
    new-array v0, v9, [Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->sMerged:[Ljava/lang/String;

    .line 278
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->sGlyph:Ljava/util/HashMap;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 282
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static filter([Ljava/lang/String;)[Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 348
    move v0, v1

    move v2, v1

    .line 349
    :goto_0
    array-length v3, p0

    if-ge v0, v3, :cond_1

    .line 350
    aget-object v3, p0, v0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrEmojiNew;->shown(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    add-int/lit8 v2, v2, 0x1

    .line 349
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 352
    :cond_1
    array-length v0, p0

    if-ne v2, v0, :cond_2

    .line 358
    :goto_1
    return-object p0

    .line 353
    :cond_2
    new-array v3, v2, [Ljava/lang/String;

    move v0, v1

    .line 355
    :goto_2
    array-length v2, p0

    if-ge v1, v2, :cond_4

    .line 356
    aget-object v2, p0, v1

    invoke-static {v2}, Lcom/mrkeyboard/app/MrEmojiNew;->shown(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    add-int/lit8 v2, v0, 0x1

    aget-object v4, p0, v1

    aput-object v4, v3, v0

    move v0, v2

    .line 355
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_4
    move-object p0, v3

    .line 358
    goto :goto_1
.end method

.method private static declared-synchronized glyph(Ljava/lang/String;)Z
    .locals 3

    .prologue
    .line 363
    const-class v1, Lcom/mrkeyboard/app/MrEmojiNew;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->sGlyph:Ljava/util/HashMap;

    invoke-virtual {v0, p0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    .line 364
    if-nez v0, :cond_1

    .line 365
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->sPaint:Landroid/graphics/Paint;

    if-nez v0, :cond_0

    new-instance v0, Landroid/graphics/Paint;

    const/4 v2, 0x1

    invoke-direct {v0, v2}, Landroid/graphics/Paint;-><init>(I)V

    sput-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->sPaint:Landroid/graphics/Paint;

    .line 366
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->sPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p0}, Landroid/graphics/Paint;->hasGlyph(Ljava/lang/String;)Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    .line 367
    sget-object v2, Lcom/mrkeyboard/app/MrEmojiNew;->sGlyph:Ljava/util/HashMap;

    invoke-virtual {v2, p0, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 369
    :cond_1
    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    monitor-exit v1

    return v0

    .line 363
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static groups(I)[Ljava/lang/String;
    .locals 1

    .prologue
    .line 286
    if-ltz p0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->GROUPS:[[Ljava/lang/String;

    array-length v0, v0

    if-lt p0, v0, :cond_1

    :cond_0
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/String;

    :goto_0
    return-object v0

    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->GROUPS:[[Ljava/lang/String;

    aget-object v0, v0, p0

    goto :goto_0
.end method

.method static declared-synchronized merge(ILjava/lang/String;)Ljava/lang/String;
    .locals 14

    .prologue
    const/4 v1, 0x0

    .line 291
    const-class v3, Lcom/mrkeyboard/app/MrEmojiNew;

    monitor-enter v3

    if-eqz p1, :cond_0

    :try_start_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_0

    if-ltz p0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->GROUPS:[[Ljava/lang/String;

    array-length v0, v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-lt p0, v0, :cond_1

    .line 327
    :cond_0
    :goto_0
    monitor-exit v3

    return-object p1

    .line 292
    :cond_1
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->sBase:[Ljava/lang/String;

    aget-object v0, v0, p0

    if-eq p1, v0, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->sBase:[Ljava/lang/String;

    aget-object v0, v0, p0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->sMerged:[Ljava/lang/String;

    aget-object p1, v0, p0

    goto :goto_0

    .line 293
    :cond_3
    const-string v0, "[|]"

    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    .line 294
    new-instance v5, Ljava/util/HashSet;

    invoke-direct {v5}, Ljava/util/HashSet;-><init>()V

    move v0, v1

    .line 295
    :goto_1
    array-length v2, v4

    if-ge v0, v2, :cond_4

    aget-object v2, v4, v0

    invoke-virtual {v5, v2}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 296
    :cond_4
    new-instance v6, Ljava/util/HashSet;

    invoke-direct {v6}, Ljava/util/HashSet;-><init>()V

    .line 297
    new-instance v7, Ljava/util/HashMap;

    invoke-direct {v7}, Ljava/util/HashMap;-><init>()V

    .line 298
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    .line 299
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->GROUPS:[[Ljava/lang/String;

    aget-object v9, v0, p0

    move v2, v1

    .line 300
    :goto_2
    array-length v0, v9

    if-ge v2, v0, :cond_b

    .line 301
    aget-object v0, v9, v2

    const-string v10, "[|]"

    invoke-virtual {v0, v10}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v10

    .line 302
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    .line 303
    const/4 v0, 0x1

    :goto_3
    array-length v12, v10

    if-ge v0, v12, :cond_7

    .line 304
    aget-object v12, v10, v0

    .line 305
    invoke-virtual {v5, v12}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_5

    invoke-virtual {v6, v12}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_5

    invoke-static {v12}, Lcom/mrkeyboard/app/MrEmojiNew;->glyph(Ljava/lang/String;)Z

    move-result v13

    if-nez v13, :cond_6

    .line 303
    :cond_5
    :goto_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 306
    :cond_6
    invoke-virtual {v6, v12}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 307
    const/16 v13, 0x7c

    invoke-virtual {v11, v13}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_4

    .line 291
    :catchall_0
    move-exception v0

    monitor-exit v3

    throw v0

    .line 309
    :cond_7
    :try_start_2
    invoke-virtual {v11}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    if-nez v0, :cond_8

    .line 300
    :goto_5
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_2

    .line 310
    :cond_8
    const/4 v0, 0x0

    aget-object v0, v10, v0

    invoke-virtual {v5, v0}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 311
    const/4 v0, 0x0

    aget-object v0, v10, v0

    invoke-virtual {v7, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 312
    const/4 v12, 0x0

    aget-object v10, v10, v12

    if-nez v0, :cond_9

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_6
    invoke-virtual {v7, v10, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_5

    :cond_9
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v12, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_6

    .line 314
    :cond_a
    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/CharSequence;)Ljava/lang/StringBuilder;

    goto :goto_5

    .line 317
    :cond_b
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit16 v0, v0, 0x800

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 318
    :goto_7
    array-length v0, v4

    if-ge v1, v0, :cond_e

    .line 319
    if-lez v1, :cond_c

    const/16 v0, 0x7c

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 320
    :cond_c
    aget-object v0, v4, v1

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 321
    aget-object v0, v4, v1

    invoke-virtual {v7, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 322
    if-eqz v0, :cond_d

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 318
    :cond_d
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_7

    .line 324
    :cond_e
    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/CharSequence;)Ljava/lang/StringBuilder;

    .line 325
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->sBase:[Ljava/lang/String;

    aput-object p1, v0, p0

    .line 326
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->sMerged:[Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v0, p0

    .line 327
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiNew;->sMerged:[Ljava/lang/String;

    aget-object p1, v0, p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto/16 :goto_0
.end method

.method static declared-synchronized shown(Ljava/lang/String;)Z
    .locals 9

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 332
    const-class v5, Lcom/mrkeyboard/app/MrEmojiNew;

    monitor-enter v5

    if-nez p0, :cond_1

    .line 343
    :cond_0
    :goto_0
    monitor-exit v5

    return v0

    .line 333
    :cond_1
    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrEmojiNew;->sAll:Ljava/util/HashSet;

    if-nez v2, :cond_5

    .line 334
    new-instance v6, Ljava/util/HashSet;

    invoke-direct {v6}, Ljava/util/HashSet;-><init>()V

    move v4, v0

    .line 335
    :goto_1
    sget-object v2, Lcom/mrkeyboard/app/MrEmojiNew;->GROUPS:[[Ljava/lang/String;

    array-length v2, v2

    if-ge v4, v2, :cond_4

    move v3, v0

    .line 336
    :goto_2
    sget-object v2, Lcom/mrkeyboard/app/MrEmojiNew;->GROUPS:[[Ljava/lang/String;

    aget-object v2, v2, v4

    array-length v2, v2

    if-ge v3, v2, :cond_3

    .line 337
    sget-object v2, Lcom/mrkeyboard/app/MrEmojiNew;->GROUPS:[[Ljava/lang/String;

    aget-object v2, v2, v4

    aget-object v2, v2, v3

    const-string v7, "[|]"

    invoke-virtual {v2, v7}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v7

    move v2, v1

    .line 338
    :goto_3
    array-length v8, v7

    if-ge v2, v8, :cond_2

    aget-object v8, v7, v2

    invoke-virtual {v6, v8}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_3

    .line 336
    :cond_2
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    goto :goto_2

    .line 335
    :cond_3
    add-int/lit8 v2, v4, 0x1

    move v4, v2

    goto :goto_1

    .line 341
    :cond_4
    sput-object v6, Lcom/mrkeyboard/app/MrEmojiNew;->sAll:Ljava/util/HashSet;

    .line 343
    :cond_5
    sget-object v2, Lcom/mrkeyboard/app/MrEmojiNew;->sAll:Ljava/util/HashSet;

    invoke-virtual {v2, p0}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_6

    invoke-static {p0}, Lcom/mrkeyboard/app/MrEmojiNew;->glyph(Ljava/lang/String;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v2

    if-eqz v2, :cond_0

    :cond_6
    move v0, v1

    goto :goto_0

    .line 332
    :catchall_0
    move-exception v0

    monitor-exit v5

    throw v0
.end method
