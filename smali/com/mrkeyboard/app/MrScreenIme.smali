.class public final Lcom/mrkeyboard/app/MrScreenIme;
.super Ljava/lang/Object;
.source "MrScreenIme.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrScreenIme$Api30;,
        Lcom/mrkeyboard/app/MrScreenIme$Show;,
        Lcom/mrkeyboard/app/MrScreenIme$Lift;
    }
.end annotation


# static fields
.field static final IME_API_SDK:I = 0x1e

.field static final KEY_END:Ljava/lang/String; = "mr_ime_end"

.field static final KEY_FIELD:Ljava/lang/String; = "mr_ime_field"

.field static final KEY_START:Ljava/lang/String; = "mr_ime_start"


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static fieldWithKeyboard(Landroid/widget/EditText;Landroid/widget/EditText;)I
    .locals 3

    .prologue
    const/4 v0, -0x1

    .line 36
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1e

    if-ge v1, v2, :cond_1

    .line 39
    :cond_0
    :goto_0
    return v0

    .line 37
    :cond_1
    if-eqz p0, :cond_2

    invoke-virtual {p0}, Landroid/widget/EditText;->hasFocus()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-static {p0}, Lcom/mrkeyboard/app/MrScreenIme$Api30;->imeVisible(Landroid/view/View;)Z

    move-result v1

    if-eqz v1, :cond_2

    const/4 v0, 0x0

    goto :goto_0

    .line 38
    :cond_2
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Landroid/widget/EditText;->hasFocus()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {p1}, Lcom/mrkeyboard/app/MrScreenIme$Api30;->imeVisible(Landroid/view/View;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0
.end method

.method public static lift(Landroid/widget/ScrollView;Landroid/view/View;IIIII)V
    .locals 8

    .prologue
    .line 116
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-ge v0, v1, :cond_1

    .line 120
    :cond_0
    :goto_0
    return-void

    .line 117
    :cond_1
    new-instance v0, Lcom/mrkeyboard/app/MrScreenIme$Lift;

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    move v6, p5

    move v7, p6

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/MrScreenIme$Lift;-><init>(Landroid/widget/ScrollView;Landroid/view/View;IIIII)V

    invoke-virtual {p0, v0}, Landroid/widget/ScrollView;->setOnApplyWindowInsetsListener(Landroid/view/View$OnApplyWindowInsetsListener;)V

    .line 119
    invoke-virtual {p0}, Landroid/widget/ScrollView;->requestApplyInsets()V

    goto :goto_0
.end method

.method public static restore(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V
    .locals 4

    .prologue
    .line 59
    if-eqz p0, :cond_0

    const-string v0, "mr_ime_field"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 73
    :cond_0
    :goto_0
    return-void

    .line 61
    :cond_1
    :try_start_0
    const-string v0, "mr_ime_field"

    const/4 v1, -0x1

    invoke-virtual {p0, v0, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    .line 62
    if-nez v0, :cond_3

    .line 63
    :goto_1
    if-eqz p1, :cond_0

    .line 64
    invoke-virtual {p1}, Landroid/widget/EditText;->length()I

    move-result v0

    .line 65
    const-string v1, "mr_ime_start"

    const/4 v2, -0x1

    invoke-virtual {p0, v1, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v1

    .line 66
    const-string v2, "mr_ime_end"

    const/4 v3, -0x1

    invoke-virtual {p0, v2, v3}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v2

    .line 67
    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    .line 68
    if-ltz v1, :cond_2

    if-ltz v2, :cond_2

    if-gt v1, v0, :cond_2

    if-gt v2, v0, :cond_2

    invoke-virtual {p1, v1, v2}, Landroid/widget/EditText;->setSelection(II)V

    .line 69
    :cond_2
    new-instance v0, Lcom/mrkeyboard/app/MrScreenIme$Show;

    invoke-direct {v0, p1}, Lcom/mrkeyboard/app/MrScreenIme$Show;-><init>(Landroid/widget/EditText;)V

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrScreenIme$Show;->arm()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 70
    :catch_0
    move-exception v0

    goto :goto_0

    .line 62
    :cond_3
    const/4 v1, 0x1

    if-ne v0, v1, :cond_4

    move-object p1, p2

    goto :goto_1

    :cond_4
    const/4 p1, 0x0

    goto :goto_1
.end method

.method public static save(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V
    .locals 2

    .prologue
    .line 44
    if-nez p0, :cond_1

    .line 55
    :cond_0
    :goto_0
    return-void

    .line 46
    :cond_1
    :try_start_0
    invoke-static {p1, p2}, Lcom/mrkeyboard/app/MrScreenIme;->fieldWithKeyboard(Landroid/widget/EditText;Landroid/widget/EditText;)I

    move-result v0

    .line 47
    if-ltz v0, :cond_0

    .line 48
    if-nez v0, :cond_2

    .line 49
    :goto_1
    const-string v1, "mr_ime_field"

    invoke-virtual {p0, v1, v0}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 50
    const-string v0, "mr_ime_start"

    invoke-virtual {p1}, Landroid/widget/EditText;->getSelectionStart()I

    move-result v1

    invoke-virtual {p0, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 51
    const-string v0, "mr_ime_end"

    invoke-virtual {p1}, Landroid/widget/EditText;->getSelectionEnd()I

    move-result v1

    invoke-virtual {p0, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 52
    :catch_0
    move-exception v0

    goto :goto_0

    :cond_2
    move-object p1, p2

    .line 48
    goto :goto_1
.end method
