.class Lcom/mrkeyboard/app/SheetEditorActivity$4;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->bindHeader(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

.field final synthetic val$more:Landroid/widget/ImageView;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/widget/ImageView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 177
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$4;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$4;->val$more:Landroid/widget/ImageView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 179
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$4;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$4;->val$more:Landroid/widget/ImageView;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$200(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/view/View;)V

    .line 180
    return-void
.end method
