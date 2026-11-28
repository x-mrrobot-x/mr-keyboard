.class Lcom/mrkeyboard/app/SheetEditorActivity$21;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->showAbcMenu(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 693
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$21;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSelect(I)V
    .locals 1

    .prologue
    .line 695
    packed-switch p1, :pswitch_data_0

    .line 702
    :goto_0
    return-void

    .line 696
    :pswitch_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$21;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$000(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    goto :goto_0

    .line 697
    :pswitch_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$21;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$400(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    goto :goto_0

    .line 698
    :pswitch_2
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$21;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2400(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    goto :goto_0

    .line 699
    :pswitch_3
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$21;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2700(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    goto :goto_0

    .line 695
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method
