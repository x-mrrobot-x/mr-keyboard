.class Lcom/mrkeyboard/app/SheetEditorActivity$5;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


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

    .line 182
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$5;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 3

    .line 185
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$5;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$300(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/EditText;

    move-result-object v0

    if-eqz v0, :cond_22

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$5;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$300(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->hasFocus()Z

    move-result v0

    if-eqz v0, :cond_22

    .line 186
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$5;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mScrollView:Landroid/widget/ScrollView;
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$400(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/ScrollView;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$5$1;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$5$1;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity$5;)V

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->post(Ljava/lang/Runnable;)Z

    .line 193
    :cond_22
    return-void
.end method
