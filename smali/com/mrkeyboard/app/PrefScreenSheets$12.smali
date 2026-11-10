.class Lcom/mrkeyboard/app/PrefScreenSheets$12;
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
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 263
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iput p3, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->val$idx:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSelect(I)V
    .locals 3

    .prologue
    .line 265
    packed-switch p1, :pswitch_data_0

    .line 275
    :goto_0
    return-void

    .line 266
    :pswitch_0
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$500(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V

    goto :goto_0

    .line 267
    :pswitch_1
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$800(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    goto :goto_0

    .line 268
    :pswitch_2
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->val$idx:I

    iget v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->val$idx:I

    add-int/lit8 v2, v2, -0x1

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$600(Lcom/mrkeyboard/app/PrefScreenSheets;II)V

    goto :goto_0

    .line 269
    :pswitch_3
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->val$idx:I

    iget v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->val$idx:I

    add-int/lit8 v2, v2, 0x1

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$600(Lcom/mrkeyboard/app/PrefScreenSheets;II)V

    goto :goto_0

    .line 270
    :pswitch_4
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->val$idx:I

    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$900(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    goto :goto_0

    .line 271
    :pswitch_5
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1000(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    goto :goto_0

    .line 272
    :pswitch_6
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->val$idx:I

    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1100(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    goto :goto_0

    .line 265
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
    .end packed-switch
.end method
