.class Lcom/mrkeyboard/app/PrefScreenSheets$14;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->confirmResetSingleBuiltin(Lcom/mrkeyboard/app/SheetModel$Sheet;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

.field final synthetic val$pt:Z

.field final synthetic val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;Z)V
    .registers 4

    .line 533
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iput-boolean p3, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->val$pt:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 4

    .line 536
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object p2, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-static {p1, p2}, Lcom/mrkeyboard/app/SheetStore;->resetBuiltinSheet(Landroid/content/Context;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_24

    .line 537
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V
    invoke-static {p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 538
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-boolean p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->val$pt:Z

    if-eqz p2, :cond_1a

    const-string p2, "Folha restaurada."

    goto :goto_1c

    :cond_1a
    const-string p2, "Sheet restored."

    :goto_1c
    const/4 v0, 0x0

    invoke-static {p1, p2, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 540
    :cond_24
    return-void
.end method
