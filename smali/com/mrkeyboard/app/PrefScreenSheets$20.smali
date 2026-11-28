.class Lcom/mrkeyboard/app/PrefScreenSheets$20;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->confirmDeleteSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

.field final synthetic val$idx:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 535
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->val$idx:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    .prologue
    .line 537
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$2000(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->val$idx:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 538
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$2000(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 539
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1700(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 540
    return-void
.end method
