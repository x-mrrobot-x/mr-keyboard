.class Lcom/mrkeyboard/app/PrefScreenSheets$13;
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
    .registers 3

    .line 516
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->val$idx:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 3

    .line 519
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # getter for: Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;
    invoke-static {p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1200(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object p1

    iget p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->val$idx:I

    invoke-virtual {p1, p2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 520
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # getter for: Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;
    invoke-static {p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1200(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object p2

    invoke-static {p1, p2}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 521
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V
    invoke-static {p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 522
    return-void
.end method
