.class Lcom/mrkeyboard/app/SheetEditorActivity$2;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .registers 2

    .line 102
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$2;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 2

    .line 105
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$2;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->showRenameDialog()V
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$000(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 106
    return-void
.end method
