.class Lcom/mrkeyboard/app/PrefScreenSheets$12;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->showHeaderMenu(Landroid/view/View;)V
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

    .line 450
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSelect(I)V
    .registers 3

    .line 453
    const/4 v0, 0x1

    if-ne p1, v0, :cond_9

    .line 454
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->startExportJson()V
    invoke-static {p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$200(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    goto :goto_1a

    .line 455
    :cond_9
    const/4 v0, 0x2

    if-ne p1, v0, :cond_12

    .line 456
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->startImportJson()V
    invoke-static {p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$300(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    goto :goto_1a

    .line 457
    :cond_12
    const/4 v0, 0x3

    if-ne p1, v0, :cond_1a

    .line 458
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$12;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->confirmResetAll()V
    invoke-static {p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$400(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 460
    :cond_1a
    :goto_1a
    return-void
.end method
