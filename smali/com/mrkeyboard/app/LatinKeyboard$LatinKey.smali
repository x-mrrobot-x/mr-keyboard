.class Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;
.super Lcom/mrkeyboard/app/Keyboard$Key;
.source "LatinKeyboard.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/LatinKeyboard;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "LatinKey"
.end annotation


# instance fields
.field private final KEY_STATE_FUNCTIONAL_HL:[I

.field private final KEY_STATE_FUNCTIONAL_NORMAL:[I

.field private final KEY_STATE_FUNCTIONAL_PRESSED:[I

.field final synthetic this$0:Lcom/mrkeyboard/app/LatinKeyboard;


# direct methods
.method public constructor <init>(Lcom/mrkeyboard/app/LatinKeyboard;Landroid/content/res/Resources;Lcom/mrkeyboard/app/Keyboard$Row;IILandroid/content/res/XmlResourceParser;)V
    .locals 6

    .line 802
    iput-object p1, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->this$0:Lcom/mrkeyboard/app/LatinKeyboard;

    move-object v0, p0

    move-object v1, p2

    move-object v2, p3

    move v3, p4

    move v4, p5

    move-object v5, p6

    .line 803
    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/Keyboard$Key;-><init>(Landroid/content/res/Resources;Lcom/mrkeyboard/app/Keyboard$Row;IILandroid/content/res/XmlResourceParser;)V

    const/4 p1, 0x1

    .line 791
    new-array p1, p1, [I

    const/4 p2, 0x0

    const p3, 0x10100a3

    aput p3, p1, p2

    iput-object p1, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->KEY_STATE_FUNCTIONAL_NORMAL:[I

    const/4 p1, 0x2

    .line 796
    new-array p1, p1, [I

    fill-array-data p1, :array_0

    iput-object p1, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->KEY_STATE_FUNCTIONAL_PRESSED:[I

    const/4 p1, 0x2

    new-array p1, p1, [I

    fill-array-data p1, :array_1

    iput-object p1, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->KEY_STATE_FUNCTIONAL_HL:[I

    return-void

    nop

    :array_0
    .array-data 4
        0x10100a3
        0x10100a7
    .end array-data

    :array_1
    .array-data 4
        0x10100a3
        0x10100a1
    .end array-data
.end method

.method public constructor <init>(Lcom/mrkeyboard/app/LatinKeyboard;Lcom/mrkeyboard/app/Keyboard$Row;)V
    .locals 2

    iput-object p1, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->this$0:Lcom/mrkeyboard/app/LatinKeyboard;

    invoke-direct {p0, p2}, Lcom/mrkeyboard/app/Keyboard$Key;-><init>(Lcom/mrkeyboard/app/Keyboard$Row;)V

    const/4 p1, 0x1

    new-array p1, p1, [I

    const/4 p2, 0x0

    const v0, 0x10100a3

    aput v0, p1, p2

    iput-object p1, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->KEY_STATE_FUNCTIONAL_NORMAL:[I

    const/4 p1, 0x2

    new-array p2, p1, [I

    fill-array-data p2, :array_custom_0

    iput-object p2, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->KEY_STATE_FUNCTIONAL_PRESSED:[I

    new-array p1, p1, [I

    fill-array-data p1, :array_custom_1

    iput-object p1, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->KEY_STATE_FUNCTIONAL_HL:[I

    return-void

    nop

    :array_custom_0
    .array-data 4
        0x10100a3
        0x10100a7
    .end array-data

    :array_custom_1
    .array-data 4
        0x10100a3
        0x10100a1
    .end array-data
.end method

.method private isHl()Z
    .locals 2

    # Tasker sheet, 1st row: keys with keyOutputText "tskcmd:<command>"
    # get the same highlight (HL) as the Ctrl/slash/arrow keys.
    iget-object v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->text:Ljava/lang/CharSequence;

    if-eqz v0, :cond_hl_codes

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "tskcmd:"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_hl_codes

    const/4 v0, 0x1

    return v0

    :cond_hl_codes
    iget-object v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->codes:[I

    if-eqz v0, :cond_0

    array-length v1, v0

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    aget v0, v0, v1

    const/16 v1, -0x12b

    if-ne v0, v1, :cond_chk_jump

    const/4 v0, 0x1

    return v0

    :cond_chk_jump
    const/16 v1, -0x190

    if-gt v0, v1, :cond_chk_sswitch

    const/16 v1, -0x1f3

    if-lt v0, v1, :cond_chk_sswitch

    const/4 v0, 0x1

    return v0

    :cond_chk_sswitch
    sparse-switch v0, :sswitch_data_0

    :cond_0
    const/4 v0, 0x0

    return v0

    :sswitch_0
    const/4 v0, 0x1

    return v0

    :sswitch_data_0
    .sparse-switch
        -0x132 -> :sswitch_0
        -0x12c -> :sswitch_0
        -0x7b -> :sswitch_0
        -0x7a -> :sswitch_0
        -0x16 -> :sswitch_0
        -0x15 -> :sswitch_0
        -0x14 -> :sswitch_0
        -0x13 -> :sswitch_0
        -0x5 -> :sswitch_0
        0xa -> :sswitch_0
        0x20 -> :sswitch_0
    .end sparse-switch
.end method

.method private isFunctionalKey()Z
    .locals 1

    .line 809
    iget-boolean v0, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->sticky:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->modifier:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method


# virtual methods
.method public getCurrentDrawableState()[I
    .locals 1

    .line 829
    iget-boolean v0, p0, Lcom/mrkeyboard/app/Keyboard$Key;->pressed:Z

    if-nez v0, :cond_3

    invoke-direct {p0}, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->isHl()Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->KEY_STATE_FUNCTIONAL_HL:[I

    return-object v0

    :cond_3
    invoke-direct {p0}, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->isFunctionalKey()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 830
    iget-boolean v0, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->pressed:Z

    if-eqz v0, :cond_0

    .line 831
    iget-object v0, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->KEY_STATE_FUNCTIONAL_PRESSED:[I

    return-object v0

    .line 833
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->KEY_STATE_FUNCTIONAL_NORMAL:[I

    return-object v0

    .line 836
    :cond_1
    invoke-super {p0}, Lcom/mrkeyboard/app/Keyboard$Key;->getCurrentDrawableState()[I

    move-result-object v0

    return-object v0
.end method

.method public isInside(II)Z
    .locals 1

    .line 819
    iget-object v0, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->this$0:Lcom/mrkeyboard/app/LatinKeyboard;

    invoke-virtual {v0, p0, p1, p2}, Lcom/mrkeyboard/app/LatinKeyboard;->isInside(Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;II)Z

    move-result p1

    return p1
.end method

.method isInsideSuper(II)Z
    .locals 0

    .line 824
    invoke-super {p0, p1, p2}, Lcom/mrkeyboard/app/Keyboard$Key;->isInside(II)Z

    move-result p1

    return p1
.end method

.method public squaredDistanceFrom(II)I
    .locals 3

    .line 842
    iget-object v0, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->this$0:Lcom/mrkeyboard/app/LatinKeyboard;

    invoke-static {v0}, Lcom/mrkeyboard/app/LatinKeyboard;->access$100(Lcom/mrkeyboard/app/LatinKeyboard;)I

    move-result v0

    .line 843
    iget v1, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->x:I

    iget v2, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->width:I

    div-int/lit8 v2, v2, 0x2

    add-int/2addr v1, v2

    sub-int/2addr v1, p1

    .line 844
    iget p1, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->y:I

    iget v2, p0, Lcom/mrkeyboard/app/LatinKeyboard$LatinKey;->height:I

    add-int/2addr v2, v0

    div-int/lit8 v2, v2, 0x2

    add-int/2addr p1, v2

    sub-int/2addr p1, p2

    mul-int v1, v1, v1

    mul-int p1, p1, p1

    add-int/2addr v1, p1

    return v1
.end method
