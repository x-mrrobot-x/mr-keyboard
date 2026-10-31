.class final Lcom/mrkeyboard/app/MrRecorrect$Api31;
.super Ljava/lang/Object;
.source "MrRecorrect.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrRecorrect;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Api31"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 64
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static wordAt(Landroid/view/inputmethod/InputConnection;IILjava/lang/String;)Lcom/mrkeyboard/app/EditingUtil$SelectedWord;
    .locals 7

    .prologue
    .line 69
    const/16 v0, 0x3e8

    const/16 v1, 0x3e8

    const/4 v2, 0x0

    :try_start_0
    invoke-interface {p0, v0, v1, v2}, Landroid/view/inputmethod/InputConnection;->getSurroundingText(III)Landroid/view/inputmethod/SurroundingText;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v3

    .line 73
    if-nez v3, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrRecorrect;->NO_SNAPSHOT:Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    .line 74
    :goto_0
    return-object v0

    .line 70
    :catch_0
    move-exception v0

    .line 71
    sget-object v0, Lcom/mrkeyboard/app/MrRecorrect;->NO_SNAPSHOT:Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    goto :goto_0

    .line 74
    :cond_0
    invoke-virtual {v3}, Landroid/view/inputmethod/SurroundingText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v3}, Landroid/view/inputmethod/SurroundingText;->getSelectionStart()I

    move-result v1

    invoke-virtual {v3}, Landroid/view/inputmethod/SurroundingText;->getSelectionEnd()I

    move-result v2

    invoke-virtual {v3}, Landroid/view/inputmethod/SurroundingText;->getOffset()I

    move-result v3

    move v4, p1

    move v5, p2

    move-object v6, p3

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrRecorrect;->fromSnapshot(Ljava/lang/CharSequence;IIIIILjava/lang/String;)Lcom/mrkeyboard/app/EditingUtil$SelectedWord;

    move-result-object v0

    goto :goto_0
.end method
