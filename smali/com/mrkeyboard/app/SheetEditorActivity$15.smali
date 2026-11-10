.class Lcom/mrkeyboard/app/SheetEditorActivity$15;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->bindTestCard(Landroid/view/View;)V
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
    .line 400
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 402
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/EditText;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->hasFocus()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 403
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2000(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/ScrollView;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$15$1;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$15$1;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity$15;)V

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->post(Ljava/lang/Runnable;)Z

    .line 409
    :cond_0
    return-void
.end method
