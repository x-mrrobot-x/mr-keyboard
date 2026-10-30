.class Lcom/mrkeyboard/app/PrefScreenSheets$15;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->confirmResetAll()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

.field final synthetic val$pt:Z


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Z)V
    .registers 3

    .line 553
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-boolean p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$pt:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 4

    .line 556
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {p1}, Lcom/mrkeyboard/app/SheetStore;->resetAllToDefaults(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_20

    .line 557
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V
    invoke-static {p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 558
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-boolean p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$pt:Z

    if-eqz p2, :cond_16

    const-string p2, "Todas as folhas foram restauradas para o padr\u00e3o."

    goto :goto_18

    :cond_16
    const-string p2, "All sheets restored to default."

    :goto_18
    const/4 v0, 0x0

    invoke-static {p1, p2, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 560
    :cond_20
    return-void
.end method
