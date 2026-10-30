.class Lcom/mrkeyboard/app/SheetEditorActivity$11$1;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity$11;->onFocusChange(Landroid/view/View;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/SheetEditorActivity$11;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity$11;)V
    .registers 2

    .line 413
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11$1;->this$1:Lcom/mrkeyboard/app/SheetEditorActivity$11;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 3

    .line 416
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$11$1;->this$1:Lcom/mrkeyboard/app/SheetEditorActivity$11;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetEditorActivity$11;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mScrollView:Landroid/widget/ScrollView;
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$400(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/ScrollView;

    move-result-object v0

    const/16 v1, 0x82

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->fullScroll(I)Z

    .line 417
    return-void
.end method
