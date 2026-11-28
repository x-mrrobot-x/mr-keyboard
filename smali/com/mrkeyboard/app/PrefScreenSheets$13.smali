.class Lcom/mrkeyboard/app/PrefScreenSheets$13;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->showAbcMenu(Landroid/view/View;Lcom/mrkeyboard/app/MrAbcKeys$Model;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

.field final synthetic val$abc:Lcom/mrkeyboard/app/MrAbcKeys$Model;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/MrAbcKeys$Model;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 343
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->val$abc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSelect(I)V
    .locals 2

    .prologue
    .line 345
    packed-switch p1, :pswitch_data_0

    .line 352
    :goto_0
    :pswitch_0
    return-void

    .line 346
    :pswitch_1
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    const-string v1, "abc"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$400(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V

    goto :goto_0

    .line 347
    :pswitch_2
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->val$abc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1200(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/MrAbcKeys$Model;)V

    goto :goto_0

    .line 348
    :pswitch_3
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->val$abc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/MrAbcKeys$Model;)V

    goto :goto_0

    .line 349
    :pswitch_4
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1400(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    goto :goto_0

    .line 345
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_3
        :pswitch_4
    .end packed-switch
.end method
