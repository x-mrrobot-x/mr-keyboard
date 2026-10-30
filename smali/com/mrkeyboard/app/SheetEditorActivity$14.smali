.class Lcom/mrkeyboard/app/SheetEditorActivity$14;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->showOverflowMenu(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .registers 2

    .line 504
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$14;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSelect(I)V
    .registers 2

    .line 507
    packed-switch p1, :pswitch_data_24

    goto :goto_22

    .line 521
    :pswitch_4
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$14;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->confirmDeleteCurrentSheet()V
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1400(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    goto :goto_22

    .line 518
    :pswitch_a
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$14;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->confirmRestoreDefault()V
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 519
    goto :goto_22

    .line 515
    :pswitch_10
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$14;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->duplicateCurrentSheet()V
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1200(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 516
    goto :goto_22

    .line 512
    :pswitch_16
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$14;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->showManageRowsDialog()V
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$800(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 513
    goto :goto_22

    .line 509
    :pswitch_1c
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$14;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->showRenameDialog()V
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$000(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 510
    nop

    .line 524
    :goto_22
    return-void

    nop

    :pswitch_data_24
    .packed-switch 0x1
        :pswitch_1c
        :pswitch_16
        :pswitch_10
        :pswitch_a
        :pswitch_4
    .end packed-switch
.end method
