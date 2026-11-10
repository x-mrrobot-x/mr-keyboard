.class Lcom/mrkeyboard/app/PrefScreenSheets$11;
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
    .locals 0

    .prologue
    .line 242
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSelect(I)V
    .locals 1

    .prologue
    .line 244
    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$200(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 247
    :cond_0
    :goto_0
    return-void

    .line 245
    :cond_1
    const/4 v0, 0x2

    if-ne p1, v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$300(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    goto :goto_0

    .line 246
    :cond_2
    const/4 v0, 0x3

    if-ne p1, v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$11;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$400(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    goto :goto_0
.end method
