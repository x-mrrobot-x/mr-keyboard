.class Lcom/mrkeyboard/app/SheetEditorActivity$1;
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


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 153
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$1;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 155
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$1;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->finish()V

    .line 156
    return-void
.end method
