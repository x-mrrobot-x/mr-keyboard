.class Lcom/mrkeyboard/app/PrefScreenSheets$11;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->showCardContextMenu(Landroid/view/View;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

.field final synthetic val$idx:I

.field final synthetic val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;I)V
    .registers 4

    .line 407
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iput p3, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->val$idx:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSelect(I)V
    .registers 4

    .line 410
    packed-switch p1, :pswitch_data_4c

    goto :goto_4a

    .line 430
    :pswitch_4
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->val$idx:I

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->confirmDeleteSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1100(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    goto :goto_4a

    .line 427
    :pswitch_e
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->confirmResetSingleBuiltin(Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1000(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    .line 428
    goto :goto_4a

    .line 424
    :pswitch_16
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->val$idx:I

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->duplicateSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$900(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    .line 425
    goto :goto_4a

    .line 421
    :pswitch_20
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->val$idx:I

    iget v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->val$idx:I

    add-int/lit8 v1, v1, 0x1

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->moveSheet(II)V
    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$600(Lcom/mrkeyboard/app/PrefScreenSheets;II)V

    .line 422
    goto :goto_4a

    .line 418
    :pswitch_2c
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->val$idx:I

    iget v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->val$idx:I

    add-int/lit8 v1, v1, -0x1

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->moveSheet(II)V
    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$600(Lcom/mrkeyboard/app/PrefScreenSheets;II)V

    .line 419
    goto :goto_4a

    .line 415
    :pswitch_38
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->showRenameSheetDialog(Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$800(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    .line 416
    goto :goto_4a

    .line 412
    :pswitch_40
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->openEditor(Ljava/lang/String;)V
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$500(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V

    .line 413
    nop

    .line 433
    :goto_4a
    return-void

    nop

    :pswitch_data_4c
    .packed-switch 0x1
        :pswitch_40
        :pswitch_38
        :pswitch_2c
        :pswitch_20
        :pswitch_16
        :pswitch_e
        :pswitch_4
    .end packed-switch
.end method
