.class Lcom/mrkeyboard/app/SheetEditorActivity$4;
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

.field final synthetic val$menuBtn:Landroid/widget/ImageView;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/widget/ImageView;)V
    .registers 3

    .line 156
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$4;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$4;->val$menuBtn:Landroid/widget/ImageView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 3

    .line 159
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$4;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$4;->val$menuBtn:Landroid/widget/ImageView;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->showOverflowMenu(Landroid/view/View;)V
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$200(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/view/View;)V

    .line 160
    return-void
.end method
