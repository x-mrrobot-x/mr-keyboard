.class Lcom/mrkeyboard/app/SheetEditorActivity$25;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->confirmRestoreDefault()V
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
    .line 810
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$25;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 812
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$25;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$25;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2400(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v1

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetStore;->loadDefaultBuiltinSheet(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    .line 813
    if-eqz v0, :cond_0

    .line 814
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$25;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 815
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$25;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2402(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 816
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$25;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1400(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 817
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$25;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$25;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    const-string v2, "mr_sheet_ed_restored"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1000(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1100(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;Z)V

    .line 819
    :cond_0
    return-void
.end method
