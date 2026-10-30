.class Lcom/mrkeyboard/app/PrefScreenSheets$16;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->showNewSheetTemplatePicker()V
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

    .line 580
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$16;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 4

    .line 583
    const/4 p1, 0x3

    if-ne p2, p1, :cond_9

    .line 584
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$16;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->pickExistingSheetToCopy()V
    invoke-static {p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1400(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    goto :goto_f

    .line 586
    :cond_9
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$16;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    const/4 v0, 0x0

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->promptNameForNewSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    invoke-static {p1, p2, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1500(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    .line 588
    :goto_f
    return-void
.end method
