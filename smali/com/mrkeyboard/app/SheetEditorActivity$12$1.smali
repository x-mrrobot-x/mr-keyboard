.class Lcom/mrkeyboard/app/SheetEditorActivity$12$1;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity$12;->onFocusChange(Landroid/view/View;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/SheetEditorActivity$12;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity$12;)V
    .locals 0

    .prologue
    .line 373
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$12$1;->this$1:Lcom/mrkeyboard/app/SheetEditorActivity$12;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 375
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$12$1;->this$1:Lcom/mrkeyboard/app/SheetEditorActivity$12;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetEditorActivity$12;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2000(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/ScrollView;

    move-result-object v0

    const/16 v1, 0x82

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->fullScroll(I)Z

    .line 376
    return-void
.end method
