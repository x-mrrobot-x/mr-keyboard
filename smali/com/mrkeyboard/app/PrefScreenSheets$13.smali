.class Lcom/mrkeyboard/app/PrefScreenSheets$13;
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
    .locals 0

    .prologue
    .line 324
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    .prologue
    .line 326
    const/4 v0, 0x3

    if-ne p2, v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1200(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 328
    :goto_0
    return-void

    .line 327
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    const/4 v1, 0x0

    invoke-static {v0, p2, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    goto :goto_0
.end method
