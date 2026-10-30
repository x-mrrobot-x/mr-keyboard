.class Lcom/mrkeyboard/app/PrefScreenSheets$17;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->pickExistingSheetToCopy()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .registers 2

    .line 603
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$17;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 4

    .line 606
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$17;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$17;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # getter for: Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;
    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1200(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/mrkeyboard/app/SheetModel$Sheet;

    const/4 v0, 0x3

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->promptNameForNewSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    invoke-static {p1, v0, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1500(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    .line 607
    return-void
.end method
