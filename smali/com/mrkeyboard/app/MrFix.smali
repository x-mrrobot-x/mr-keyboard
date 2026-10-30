.class public final Lcom/mrkeyboard/app/MrFix;
.super Ljava/lang/Object;
.source "MrFix.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static key(Ljava/lang/CharSequence;)Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 15
    if-nez p0, :cond_1

    .line 20
    :cond_0
    :goto_0
    return-object v0

    .line 16
    :cond_1
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    .line 17
    if-eqz v1, :cond_0

    const/16 v2, 0x18

    if-gt v1, v2, :cond_0

    .line 18
    new-array v2, v1, [C

    .line 19
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

    .line 20
    :cond_2
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v2}, Ljava/lang/String;-><init>([C)V

    goto :goto_0
.end method

.method public static lookup(Ljava/lang/CharSequence;)Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 25
    invoke-static {}, Lcom/mrkeyboard/app/MrRules;->get()Lcom/mrkeyboard/app/MrRules;

    move-result-object v1

    .line 26
    iget-object v2, v1, Lcom/mrkeyboard/app/MrRules;->corrections:Ljava/util/HashMap;

    invoke-virtual {v2}, Ljava/util/HashMap;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 29
    :cond_0
    :goto_0
    return-object v0

    .line 27
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrFix;->key(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    .line 28
    if-eqz v2, :cond_0

    .line 29
    iget-object v0, v1, Lcom/mrkeyboard/app/MrRules;->corrections:Ljava/util/HashMap;

    invoke-virtual {v0, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    goto :goto_0
.end method

.method static size()I
    .locals 1

    .prologue
    .line 34
    invoke-static {}, Lcom/mrkeyboard/app/MrRules;->get()Lcom/mrkeyboard/app/MrRules;

    move-result-object v0

    iget-object v0, v0, Lcom/mrkeyboard/app/MrRules;->corrections:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->size()I

    move-result v0

    return v0
.end method
