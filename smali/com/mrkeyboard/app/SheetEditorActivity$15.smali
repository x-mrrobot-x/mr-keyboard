.class Lcom/mrkeyboard/app/SheetEditorActivity$15;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->showRenameDialog()V
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
    .line 507
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onNamed(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 509
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2200(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 510
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2200(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v1

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-static {p2, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 512
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2200(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v2

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2200(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v2

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 517
    :goto_0
    return-void

    .line 513
    :cond_0
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1100(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 514
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2200(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v2

    iput-object v0, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 515
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2200(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 516
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1200(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    goto :goto_0
.end method
