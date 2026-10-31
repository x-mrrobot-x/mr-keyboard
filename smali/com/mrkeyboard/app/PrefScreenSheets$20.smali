.class Lcom/mrkeyboard/app/PrefScreenSheets$20;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->onActivityResult(IILandroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

.field final synthetic val$pt:Z

.field final synthetic val$raw:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;Z)V
    .registers 4

    .line 806
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->val$raw:Ljava/lang/String;

    iput-boolean p3, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->val$pt:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 5

    .line 810
    :try_start_0
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->val$raw:Ljava/lang/String;

    invoke-static {p1, p2}, Lcom/mrkeyboard/app/SheetStore;->importJsonString(Landroid/content/Context;Ljava/lang/String;)I

    move-result p1

    .line 811
    iget-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V
    invoke-static {p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 812
    iget-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-boolean v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->val$pt:Z

    if-eqz v1, :cond_1b

    const-string v1, "Importadas "

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_1d

    :cond_1b
    const-string v1, "Imported "

    :goto_1d
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    iget-boolean v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->val$pt:Z

    if-eqz v0, :cond_2c

    const-string v0, " folhas!"

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_2e

    :cond_2c
    const-string v0, " sheets!"

    :goto_2e
    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x0

    invoke-static {p2, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V
    :try_end_3e
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_3e} :catch_3f

    .line 815
    goto :goto_68

    .line 813
    :catch_3f
    move-exception p1

    .line 814
    iget-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-boolean v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->val$pt:Z

    if-eqz v1, :cond_4e

    const-string v1, "JSON inv\u00e1lido: "

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_50

    :cond_4e
    const-string v1, "Invalid JSON: "

    :goto_50
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x1

    invoke-static {p2, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 816
    :goto_68
    return-void
.end method
