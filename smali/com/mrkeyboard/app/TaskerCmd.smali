.class public final Lcom/mrkeyboard/app/TaskerCmd;
.super Ljava/lang/Object;
.source "TaskerCmd.java"

# Teclas da 1a fileira da folha TSK (kbd_tasker.xml) usam keyOutputText = "tskcmd:<comando>".
# Em vez de digitar o texto, o LatinIME.onText chama handle(), que envia um broadcast:
#   action : com.mrkeyboard.app.TASKER_CMD
#   extra  : cmd = <comando>   (no Tasker vira a variavel local %cmd)
# O broadcast e implicito (sem setPackage): o evento "Intent Received" do Tasker
# nao recebe intents enderecados a um pacote/componente especifico.

.field public static final ACTION:Ljava/lang/String; = "com.mrkeyboard.app.TASKER_CMD"

.field public static final EXTRA_CMD:Ljava/lang/String; = "cmd"

.field public static final PREFIX:Ljava/lang/String; = "tskcmd:"


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

# Retorna true se o texto era um comando (e o broadcast foi disparado);
# false se for texto comum, que deve ser digitado normalmente.
.method public static handle(Landroid/content/Context;Ljava/lang/CharSequence;)Z
    .locals 4

    if-eqz p1, :cond_no

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "tskcmd:"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_no

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    new-instance v2, Landroid/content/Intent;

    const-string v3, "com.mrkeyboard.app.TASKER_CMD"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v3, "cmd"

    invoke-virtual {v2, v3, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :try_start_0
    invoke-virtual {p0, v2}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0

    :catch_0
    move-exception v0

    goto :goto_0
.end method
